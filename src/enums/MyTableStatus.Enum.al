/// <summary>
/// Enumeration for MyTable Status values.
/// Provides standardized status options with extensibility.
/// </summary>
enum 50100 MyTableStatus
{
    Extensible = true;
    Caption = 'My Table Status';

    value(0; Active)
    {
        Caption = 'Active';
    }
    value(1; Inactive)
    {
        Caption = 'Inactive';
    }
    value(2; Pending)
    {
        Caption = 'Pending';
    }
    value(3; Archived)
    {
        Caption = 'Archived';
    }
}
