table 50100 MyTable
{
    /// <summary>
    /// Custom table for storing business entity data with comprehensive validation.
    /// Implements best practices for data integrity and error handling.
    /// </summary>
    DataClassification = ToBeClassified;
    Caption = 'My Custom Table';

    fields
    {
        field(1; "ID"; Integer)
        {
            DataClassification = SystemMetadata;
            Caption = 'ID';
            AutoIncrement = true;
            Editable = false;

            trigger OnValidate()
            begin
                if "ID" <= 0 then
                    Error('ID must be a positive number.');
            end;
        }

        field(2; "Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
            NotBlank = true;

            trigger OnValidate()
            begin
                ValidateName();
            end;
        }

        field(3; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';

            trigger OnValidate()
            begin
                ValidateDescription();
            end;
        }

        field(4; "Status"; Enum MyTableStatus)
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
            InitValue = "Active";
        }

        field(5; "Created Date"; DateTime)
        {
            DataClassification = SystemMetadata;
            Caption = 'Created Date';
            Editable = false;
        }

        field(6; "Modified Date"; DateTime)
        {
            DataClassification = SystemMetadata;
            Caption = 'Modified Date';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
        key(NameKey; "Name")
        {
        }
        key(StatusKey; "Status")
        {
        }
    }

    trigger OnInsert()
    begin
        ValidateInsert();
        "Created Date" := CurrentDateTime;
        "Modified Date" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        ValidateModify();
        "Modified Date" := CurrentDateTime;
    end;

    trigger OnDelete()
    begin
        ValidateDelete();
    end;

    /// <summary>
    /// Validates the Name field according to business rules.
    /// </summary>
    local procedure ValidateName()
    begin
        if StrLen(Name) < 3 then
            Error('Name must be at least 3 characters long.');

        if Name.Contains('  ') then
            Error('Name cannot contain consecutive spaces.');

        // Remove leading and trailing spaces
        if Name <> '' then
            Name := CopyStr(Name.Trim(), 1, MaxStrLen(Name));

        // Check for invalid characters
        if Name.Contains('<') or Name.Contains('>') or Name.Contains('&') then
            Error('Name contains invalid characters: < > &');
    end;

    /// <summary>
    /// Validates the Description field.
    /// </summary>
    local procedure ValidateDescription()
    begin
        // Remove leading and trailing spaces
        if Description <> '' then
            Description := CopyStr(Description.Trim(), 1, MaxStrLen(Description));

        // Optional validation - warn if description is very short
        if (Description <> '') and (StrLen(Description) < 10) then
            Message('Consider providing a more detailed description.');
    end;

    /// <summary>
    /// Validates record insertion with comprehensive checks.
    /// </summary>
    local procedure ValidateInsert()
    var
        ExistingRecord: Record MyTable;
    begin
        // Check for duplicate names
        ExistingRecord.SetRange(Name, Name);
        if not ExistingRecord.IsEmpty then
            Error('A record with the name "%1" already exists.', Name);

        // Business rule: Name is required for new records
        if Name = '' then
            Error('Name is required when creating a new record.');
    end;

    /// <summary>
    /// Validates record modification.
    /// </summary>
    local procedure ValidateModify()
    var
        ExistingRecord: Record MyTable;
    begin
        // Check for duplicate names (excluding current record)
        ExistingRecord.SetRange(Name, Name);
        ExistingRecord.SetFilter(ID, '<>%1', ID);
        if not ExistingRecord.IsEmpty then
            Error('A record with the name "%1" already exists.', Name);
    end;

    /// <summary>
    /// Validates record deletion.
    /// </summary>
    local procedure ValidateDelete()
    begin
        // Add business logic for deletion validation
        // Example: Check if record is referenced elsewhere
        if Status = Status::Active then
            if not Confirm('This record is still active. Are you sure you want to delete it?') then
                Error('');
    end;
}