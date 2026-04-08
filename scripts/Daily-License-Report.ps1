# Daily Microsoft 365 License & User Report
Connect-MgGraph -Scopes "User.Read.All","Directory.Read.All"

$users = Get-MgUser -All -Property DisplayName, UserPrincipalName, AssignedLicenses, AccountEnabled

$report = $users | Select-Object `
    DisplayName,
    UserPrincipalName,
    @{Name="Licenses";Expression={$_.AssignedLicenses.Count}},
    AccountEnabled

$filename = "M365_License_Report_$(Get-Date -Format yyyyMMdd).csv"
$report | Export-Csv -Path $filename -NoTypeInformation

Write-Host "📊 Report saved: $filename" -ForegroundColor Green
Disconnect-MgGraph
