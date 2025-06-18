/// <summary>
/// Business Logic Codeunit with comprehensive error handling and best practices.
/// Implements SOLID principles and proper exception management.
/// </summary>
codeunit 50100 MyCodeunit
{
    var
        UpdateFailedMsg: Label 'Failed to update record with ID: %1', Comment = '%1 = Record ID';
        DeleteFailedMsg: Label 'Failed to delete record: %1', Comment = '%1 = Record Name';
        BulkRecordNameMsg: Label 'Bulk Record %1', Comment = '%1 = Counter';
        BulkRecordDescMsg: Label 'Auto-generated record number %1', Comment = '%1 = Counter';
    
    /// <summary>
    /// Main entry point for codeunit execution.
    /// Implements centralized error handling and logging.
    /// </summary>
    trigger OnRun()
    var
        ErrorInfo: ErrorInfo;
    begin
        if not TryExecuteMainLogic() then begin
            ErrorInfo.ErrorType := ErrorType::Internal;
            ErrorInfo.Verbosity := Verbosity::Error;
            ErrorInfo.Message := 'An error occurred during codeunit execution.';
            ErrorInfo.DetailedMessage := GetLastErrorText();
            Error(ErrorInfo);
        end;
    end;

    /// <summary>
    /// Creates a new record with comprehensive validation and error handling.
    /// </summary>
    /// <param name="Name">The name for the new record</param>
    /// <param name="Description">The description for the new record</param>
    /// <returns>True if successful, false otherwise</returns>
    procedure CreateRecord(Name: Text[100]; Description: Text[250]): Boolean
    var
        MyTableRec: Record MyTable;
        ErrorInfo: ErrorInfo;
    begin
        if not ValidateInputParameters(Name, Description) then
            exit(false);

        if not TryCreateRecord(MyTableRec, Name, Description) then begin
            ErrorInfo.ErrorType := ErrorType::Internal;
            ErrorInfo.Verbosity := Verbosity::Error;
            ErrorInfo.Message := 'Failed to create record.';
            ErrorInfo.DetailedMessage := GetLastErrorText();
            ErrorInfo.AddAction('Retry', Codeunit::MyCodeunit, 'RetryCreateRecord');
            Error(ErrorInfo);
        end;

        Message('Record "%1" created successfully with ID: %2', Name, MyTableRec.ID);
        exit(true);
    end;

    /// <summary>
    /// Updates an existing record with proper validation.
    /// </summary>
    /// <param name="RecordID">The ID of the record to update</param>
    /// <param name="NewName">The new name value</param>
    /// <param name="NewDescription">The new description value</param>
    /// <returns>True if successful, false otherwise</returns>
    procedure UpdateRecord(RecordID: Integer; NewName: Text[100]; NewDescription: Text[250]): Boolean
    var
        MyTableRec: Record MyTable;
        ErrorInfo: ErrorInfo;
    begin
        if RecordID <= 0 then
            Error('Invalid Record ID: %1. ID must be a positive number.', RecordID);

        if not MyTableRec.Get(RecordID) then
            Error('Record with ID %1 not found.', RecordID);

        if not ValidateInputParameters(NewName, NewDescription) then
            exit(false);

        if not TryUpdateRecord(MyTableRec, NewName, NewDescription) then begin
            ErrorInfo.ErrorType := ErrorType::Internal;
            ErrorInfo.Verbosity := Verbosity::Error;
            ErrorInfo.Message := StrSubstNo(UpdateFailedMsg, RecordID);
            ErrorInfo.DetailedMessage := GetLastErrorText();
            Error(ErrorInfo);
        end;

        Message('Record "%1" updated successfully.', NewName);
        exit(true);
    end;

    /// <summary>
    /// Deletes a record with confirmation and validation.
    /// </summary>
    /// <param name="RecordID">The ID of the record to delete</param>
    /// <returns>True if successful, false otherwise</returns>
    procedure DeleteRecord(RecordID: Integer): Boolean
    var
        MyTableRec: Record MyTable;
        ConfirmMsg: Label 'Are you sure you want to delete record "%1"?', Comment = '%1 = Record Name';
        ErrorInfo: ErrorInfo;
    begin
        if RecordID <= 0 then
            Error('Invalid Record ID: %1. ID must be a positive number.', RecordID);

        if not MyTableRec.Get(RecordID) then
            Error('Record with ID %1 not found.', RecordID);

        if not Confirm(ConfirmMsg, false, MyTableRec.Name) then
            exit(false);

        if not TryDeleteRecord(MyTableRec) then begin
            ErrorInfo.ErrorType := ErrorType::Internal;
            ErrorInfo.Verbosity := Verbosity::Error;
            ErrorInfo.Message := StrSubstNo(DeleteFailedMsg, MyTableRec.Name);
            ErrorInfo.DetailedMessage := GetLastErrorText();
            Error(ErrorInfo);
        end;

        Message('Record "%1" deleted successfully.', MyTableRec.Name);
        exit(true);
    end;

    /// <summary>
    /// Performs bulk operations with transaction management.
    /// </summary>
    /// <param name="RecordCount">Number of records to create</param>
    procedure BulkCreateRecords(RecordCount: Integer)
    var
        ErrorInfo: ErrorInfo;
        StartTime: DateTime;
        EndTime: DateTime;
    begin
        if RecordCount <= 0 then
            Error('Record count must be a positive number.');

        if RecordCount > 1000 then
            Error('Cannot create more than 1000 records at once for performance reasons.');

        StartTime := CurrentDateTime;

        if not TryBulkCreate(RecordCount) then begin
            ErrorInfo.ErrorType := ErrorType::Internal;
            ErrorInfo.Verbosity := Verbosity::Error;
            ErrorInfo.Message := 'Bulk creation failed.';
            ErrorInfo.DetailedMessage := GetLastErrorText();
            Error(ErrorInfo);
        end;

        EndTime := CurrentDateTime;
        Message('%1 records created successfully in %2 milliseconds.',
                RecordCount, EndTime - StartTime);
    end;

    /// <summary>
    /// Validates input parameters for record operations.
    /// </summary>
    local procedure ValidateInputParameters(Name: Text[100]; Description: Text[250]): Boolean
    begin
        if Name = '' then
            Error('Name cannot be empty.');

        if StrLen(Name) < 3 then
            Error('Name must be at least 3 characters long.');

        if StrLen(Name) > 100 then
            Error('Name cannot exceed 100 characters.');

        if StrLen(Description) > 250 then
            Error('Description cannot exceed 250 characters.');

        exit(true);
    end;

    /// <summary>
    /// Try function for safe record creation.
    /// </summary>
    [TryFunction]
    local procedure TryCreateRecord(var MyTableRec: Record MyTable; Name: Text[100]; Description: Text[250])
    begin
        Clear(MyTableRec);
        MyTableRec.Name := Name;
        MyTableRec.Description := Description;
        MyTableRec.Status := MyTableRec.Status::Active;
        MyTableRec.Insert(true);
    end;

    /// <summary>
    /// Try function for safe record updates.
    /// </summary>
    [TryFunction]
    local procedure TryUpdateRecord(var MyTableRec: Record MyTable; NewName: Text[100]; NewDescription: Text[250])
    begin
        MyTableRec.Name := NewName;
        MyTableRec.Description := NewDescription;
        MyTableRec.Modify(true);
    end;

    /// <summary>
    /// Try function for safe record deletion.
    /// </summary>
    [TryFunction]
    local procedure TryDeleteRecord(var MyTableRec: Record MyTable)
    begin
        MyTableRec.Delete(true);
    end;

    /// <summary>
    /// Try function for bulk operations.
    /// </summary>
    [TryFunction]
    local procedure TryBulkCreate(RecordCount: Integer)
    var
        MyTableRec: Record MyTable;
        Counter: Integer;
    begin
        for Counter := 1 to RecordCount do begin
            Clear(MyTableRec);
            MyTableRec.Name := StrSubstNo(BulkRecordNameMsg, Counter);
            MyTableRec.Description := StrSubstNo(BulkRecordDescMsg, Counter);
            MyTableRec.Status := MyTableRec.Status::Active;
            MyTableRec.Insert(true);
        end;
    end;

    /// <summary>
    /// Try function for main logic execution.
    /// </summary>
    [TryFunction]
    local procedure TryExecuteMainLogic()
    begin
        // Main logic implementation
        Message('Main logic executed successfully!');
    end;

    /// <summary>
    /// Action handler for retry functionality.
    /// </summary>
    procedure RetryCreateRecord(ErrorInfo: ErrorInfo)
    begin
        Message('Retry functionality - implement specific retry logic here.');
    end;

    /// <summary>
    /// First procedure with enhanced error handling.
    /// </summary>
    procedure MyFirstProcedure()
    var
        ErrorInfo: ErrorInfo;
    begin
        if not TryFirstProcedureLogic() then begin
            ErrorInfo.ErrorType := ErrorType::Internal;
            ErrorInfo.Verbosity := Verbosity::Warning;
            ErrorInfo.Message := 'First procedure encountered an issue.';
            ErrorInfo.DetailedMessage := GetLastErrorText();
            Error(ErrorInfo);
        end;

        Message('First procedure executed successfully!');
    end;

    /// <summary>
    /// Second procedure with enhanced error handling.
    /// </summary>
    procedure MySecondProcedure()
    var
        ErrorInfo: ErrorInfo;
    begin
        if not TrySecondProcedureLogic() then begin
            ErrorInfo.ErrorType := ErrorType::Internal;
            ErrorInfo.Verbosity := Verbosity::Warning;
            ErrorInfo.Message := 'Second procedure encountered an issue.';
            ErrorInfo.DetailedMessage := GetLastErrorText();
            Error(ErrorInfo);
        end;

        Message('Second procedure executed successfully!');
    end;

    [TryFunction]
    local procedure TryFirstProcedureLogic()
    begin
        // First procedure business logic
    end;

    [TryFunction]
    local procedure TrySecondProcedureLogic()
    begin
        // Second procedure business logic
    end;
}