report 50100 MyReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'My Custom Report';

    dataset
    {
        dataitem(MyTable; MyTable)
        {
            RequestFilterFields = "ID", "Name";

            column(ID; ID)
            {
            }
            column(Name; Name)
            {
            }
            column(Description; Description)
            {
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    Caption = 'Options';
                }
            }
        }
    }
}