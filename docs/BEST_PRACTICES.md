# AL Development Best Practices and Guidelines

## Table of Contents
1. [Error Handling](#error-handling)
2. [Data Validation](#data-validation)
3. [Code Structure](#code-structure)
4. [Performance Optimization](#performance-optimization)
5. [Security Best Practices](#security-best-practices)
6. [Testing Guidelines](#testing-guidelines)

## Error Handling

### 1. Use Try Functions for Safe Operations
```al
[TryFunction]
local procedure TryCreateRecord(var MyRec: Record MyTable): Boolean
begin
    MyRec.Insert(true);
end;

// Usage
if not TryCreateRecord(MyRec) then begin
    // Handle error appropriately
    Error('Failed to create record: %1', GetLastErrorText());
end;
```

### 2. Implement ErrorInfo for Rich Error Messages
```al
var
    ErrorInfo: ErrorInfo;
begin
    ErrorInfo.ErrorType := ErrorType::Client;
    ErrorInfo.Verbosity := Verbosity::Error;
    ErrorInfo.Message := 'Primary error message';
    ErrorInfo.DetailedMessage := 'Detailed explanation';
    ErrorInfo.AddAction('Retry', Codeunit::MyCodeunit, 'RetryAction');
    Error(ErrorInfo);
end;
```

### 3. Validate Input Parameters
```al
local procedure ValidateParameters(Name: Text[100]; ID: Integer)
begin
    if Name = '' then
        Error('Name parameter cannot be empty.');
    
    if ID <= 0 then
        Error('ID must be a positive number.');
        
    if StrLen(Name) > 100 then
        Error('Name cannot exceed 100 characters.');
end;
```

## Data Validation

### 1. Table-Level Validation
```al
// In table triggers
trigger OnInsert()
begin
    ValidateInsert();
    InitializeAuditFields();
end;

trigger OnModify()
begin
    ValidateModify();
    UpdateAuditFields();
end;

// Field validation
field(2; "Name"; Text[100])
{
    trigger OnValidate()
    begin
        ValidateName();
    end;
}
```

### 2. Business Rule Validation
```al
local procedure ValidateName()
begin
    // Remove whitespace
    if Name <> '' then
        Name := CopyStr(Name.Trim(), 1, MaxStrLen(Name));
    
    // Length validation
    if StrLen(Name) < 3 then
        Error('Name must be at least 3 characters long.');
    
    // Character validation
    if Name.Contains('<') or Name.Contains('>') then
        Error('Name contains invalid characters.');
    
    // Uniqueness validation
    CheckNameUniqueness();
end;
```

### 3. Cross-Field Validation
```al
local procedure ValidateBusinessLogic()
begin
    if (Status = Status::Active) and ("End Date" <> 0D) then
        Error('Active records cannot have an end date.');
        
    if ("Start Date" <> 0D) and ("End Date" <> 0D) and ("End Date" < "Start Date") then
        Error('End date cannot be before start date.');
end;
```

## Code Structure

### 1. Documentation Standards
```al
/// <summary>
/// Creates a new customer record with comprehensive validation.
/// Implements business rules for customer creation.
/// </summary>
/// <param name="CustomerName">The name of the customer (required)</param>
/// <param name="Email">Customer email address (optional)</param>
/// <returns>True if successful, false otherwise</returns>
procedure CreateCustomer(CustomerName: Text[100]; Email: Text[50]): Boolean
```

### 2. Naming Conventions
- **Tables**: Use singular nouns (Customer, not Customers)
- **Fields**: Use descriptive names with spaces ("Customer Name")
- **Procedures**: Use verbs (CreateRecord, ValidateData)
- **Variables**: Use descriptive names (CustomerRec, not Rec)

### 3. Object Organization
```al
// Group related procedures together
#region "Data Validation"
local procedure ValidateName()
local procedure ValidateEmail()
local procedure ValidateBusinessRules()
#endregion

#region "Helper Functions"
local procedure InitializeDefaults()
local procedure UpdateAuditFields()
#endregion
```

## Performance Optimization

### 1. Efficient Database Operations
```al
// Use SetRange for filtering
CustomerRec.SetRange("Customer Type", CustomerRec."Customer Type"::Premium);
CustomerRec.SetRange("Status", CustomerRec.Status::Active);

// Avoid FindSet when you only need one record
if CustomerRec.FindFirst() then
    // Process single record

// Use temporary tables for processing
TempCustomer.Copy(Customer, true);
// Perform operations on temporary table
```

### 2. Bulk Operations
```al
// Process records in batches
CustomerRec.FindSet();
repeat
    // Process record
    Counter += 1;
    if Counter mod 100 = 0 then
        Commit(); // Commit periodically for large datasets
until CustomerRec.Next() = 0;
```

### 3. Memory Management
```al
// Clear large variables when done
Clear(LargeDataSet);

// Use specific field selection
CustomerRec.SetLoadFields(Name, "No.", Email);
```

## Security Best Practices

### 1. Data Classification
```al
field(1; "Customer No."; Code[20])
{
    DataClassification = CustomerContent;
}

field(2; "Social Security No."; Text[20])
{
    DataClassification = EndUserPseudonymousIdentifiers;
}
```

### 2. Permission Validation
```al
local procedure ValidatePermissions()
begin
    if not UserPermissions.HasTableDataPermission(TableData::Customer) then
        Error('Insufficient permissions to access customer data.');
end;
```

### 3. Input Sanitization
```al
local procedure SanitizeInput(var InputText: Text)
begin
    // Remove potentially dangerous characters
    InputText := InputText.Replace('<', '');
    InputText := InputText.Replace('>', '');
    InputText := InputText.Replace('&', '');
    
    // Trim whitespace
    InputText := CopyStr(InputText.Trim(), 1, MaxStrLen(InputText));
end;
```

## Testing Guidelines

### 1. Unit Testing Structure
```al
codeunit 50101 "Test MyTable Operations"
{
    Subtype = Test;
    
    [Test]
    procedure TestCreateRecord()
    var
        MyTable: Record MyTable;
        MyCodeunit: Codeunit MyCodeunit;
    begin
        // Arrange
        Initialize();
        
        // Act
        asserterror MyCodeunit.CreateRecord('', 'Description');
        
        // Assert
        Assert.ExpectedError('Name cannot be empty');
    end;
}
```

### 2. Test Data Management
```al
local procedure Initialize()
begin
    // Clean up test data
    MyTable.DeleteAll();
    
    // Setup test prerequisites
    CreateTestData();
end;

local procedure CreateTestData()
var
    MyTable: Record MyTable;
begin
    MyTable.Init();
    MyTable.Name := 'Test Record';
    MyTable.Insert();
end;
```

## Common Anti-Patterns to Avoid

### ❌ Don't Do This
```al
// No error handling
CustomerRec.Insert();

// Hard-coded values
if Status = 1 then

// No validation
Name := UserInput;

// Silent failures
if CustomerRec.Get(CustomerNo) then
    // Process
// No else clause - silent failure
```

### ✅ Do This Instead
```al
// Proper error handling
if not CustomerRec.Insert() then
    Error('Failed to create customer: %1', GetLastErrorText());

// Use enums
if Status = Status::Active then

// Validate input
ValidateUserInput(UserInput);
Name := UserInput;

// Handle all cases
if CustomerRec.Get(CustomerNo) then
    ProcessCustomer(CustomerRec)
else
    Error('Customer %1 not found.', CustomerNo);
```

## Checklist for Code Review

- [ ] All input parameters are validated
- [ ] Error handling is implemented with Try functions
- [ ] Documentation is complete and accurate
- [ ] No hard-coded values or magic numbers
- [ ] Performance considerations are addressed
- [ ] Security and data classification is proper
- [ ] Unit tests cover main scenarios
- [ ] Code follows naming conventions
- [ ] No code duplication
- [ ] All edge cases are handled

## Tools and Extensions

### Recommended VS Code Extensions
- AL Language Extension
- BusinessCentral.LinterCop
- BusinessCentral.UICop
- AL Code Outline

### Code Analysis Rules
Configure `ruleset.json` with appropriate rules for your project standards.

---

This document should be regularly updated as best practices evolve and new patterns are discovered.
