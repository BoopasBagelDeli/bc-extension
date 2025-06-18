/// <summary>
/// Enhanced page with comprehensive error handling and user experience improvements.
/// Implements best practices for Business Central page development.
/// </summary>
page 50100 "MyPage"
{
    PageType = Card;
    SourceTable = MyTable;
    Caption = 'My Custom Page';
    UsageCategory = Documents;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General Information';

                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for this record.';
                    Editable = false;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the record. Must be at least 3 characters.';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        ValidateNameField();
                    end;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a detailed description of the record.';
                    MultiLine = true;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current status of the record.';
                }
            }

            group(Timestamps)
            {
                Caption = 'Audit Information';

                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when this record was created.';
                    Editable = false;
                }

                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when this record was last modified.';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(CreateNew)
            {
                ApplicationArea = All;
                Caption = 'Create Sample Record';
                Image = New;
                ToolTip = 'Creates a new sample record with validation.';

                trigger OnAction()
                begin
                    CreateSampleRecord();
                end;
            }

            action(ValidateData)
            {
                ApplicationArea = All;
                Caption = 'Validate Record';
                Image = Check;
                ToolTip = 'Validates the current record data.';

                trigger OnAction()
                begin
                    ValidateCurrentRecord();
                end;
            }

            action(ShowFirst)
            {
                ApplicationArea = All;
                Caption = 'Execute First Procedure';
                Image = Process;
                ToolTip = 'Executes the first business procedure.';

                trigger OnAction()
                var
                    MyCodeunit: Codeunit "MyCodeunit";
                begin
                    MyCodeunit.MyFirstProcedure();
                end;
            }
        }

        area(reporting)
        {
            action(PrintRecord)
            {
                ApplicationArea = All;
                Caption = 'Print Record';
                Image = Print;
                ToolTip = 'Prints the current record details.';

                trigger OnAction()
                begin
                    PrintCurrentRecord();
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // Initialize default values for new records
        Rec.Status := Rec.Status::Active;
        Message('Creating new record. Please fill in the required fields.');
    end;

    trigger OnAfterGetRecord()
    begin
        // Perform any validations after retrieving record
        ValidateRecordState();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        // Validate before allowing modification
        exit(ValidateBeforeModify());
    end;

    /// <summary>
    /// Validates the Name field with enhanced error handling.
    /// </summary>
    local procedure ValidateNameField()
    begin
        if Rec.Name = '' then
            Error('Name field cannot be empty.');

        if StrLen(Rec.Name) < 3 then
            Message('Consider using a more descriptive name (minimum 3 characters).');
    end;

    /// <summary>
    /// Creates a sample record for testing.
    /// </summary>
    local procedure CreateSampleRecord()
    var
        MyCodeunit: Codeunit "MyCodeunit";
        SampleName: Text[100];
        SampleDesc: Text[250];
    begin
        SampleName := 'Sample Record ' + Format(Random(1000));
        SampleDesc := 'This is a sample record created for testing purposes.';

        if MyCodeunit.CreateRecord(SampleName, SampleDesc) then
            Message('Sample record created successfully!')
        else
            Error('Failed to create sample record.');

        // Refresh page data
        CurrPage.Update(false);
    end;

    /// <summary>
    /// Validates the current record comprehensively.
    /// </summary>
    local procedure ValidateCurrentRecord()
    var
        ValidationMsg: Text;
        ValidationPassed: Boolean;
    begin
        Clear(ValidationMsg);
        ValidationPassed := true;

        if Rec.Name = '' then begin
            ValidationMsg += 'Name is required.\';
            ValidationPassed := false;
        end;

        if StrLen(Rec.Name) < 3 then begin
            ValidationMsg += 'Name should be at least 3 characters.\';
            ValidationPassed := false;
        end;

        if ValidationPassed then
            Message('Record validation passed successfully.')
        else
            Message('Validation issues found:\%1', ValidationMsg);
    end;

    /// <summary>
    /// Prints the current record.
    /// </summary>
    local procedure PrintCurrentRecord()
    begin
        if Rec.ID = 0 then
            Error('Please save the record before printing.');

        Report.Run(Report::"MyReport", true, false, Rec);
    end;

    /// <summary>
    /// Validates record state after retrieval.
    /// </summary>
    local procedure ValidateRecordState()
    begin
        // Add any business logic validation here
        if (Rec.Status = Rec.Status::Inactive) and (Rec."Modified Date" = 0DT) then
            Message('This record appears to be inactive and may need attention.');
    end;

    /// <summary>
    /// Validates before allowing record modification.
    /// </summary>
    local procedure ValidateBeforeModify(): Boolean
    begin
        if Rec.Status = Rec.Status::Archived then
            if not Confirm('This record is archived. Are you sure you want to modify it?') then
                exit(false);

        exit(true);
    end;
}