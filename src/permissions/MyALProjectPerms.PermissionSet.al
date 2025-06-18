/// <summary>
/// Permission set for My AL Project objects.
/// Grants necessary permissions for tables, pages, reports, and codeunits.
/// </summary>
permissionset 50101 "MyAL Project Perms"
{
    Assignable = true;
    Caption = 'My AL Project Permissions';
    Permissions =
        tabledata MyTable = RIMD,
        table MyTable = X,
        page MyPage = X,
        report MyReport = X,
        codeunit MyCodeunit = X;
}
