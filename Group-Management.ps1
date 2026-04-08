# Entra ID Group Management (Add/Remove users in bulk)
param (
    [string]$Action = "Add",  # Add or Remove
    [string]$GroupId = "YOUR-GROUP-ID-HERE",
    [string]$CsvPath = "users-to-add.csv"
)

Connect-MgGraph -Scopes "GroupMember.ReadWrite.All"

$users = Import-Csv $CsvPath

foreach ($user in $users) {
    $u = Get-MgUser -UserId $user.UserPrincipalName
    if ($Action -eq "Add") {
        Add-MgGroupMember -GroupId $GroupId -DirectoryObjectId $u.Id
        Write-Host "Added to group: $($u.UserPrincipalName)"
    } else {
        Remove-MgGroupMember -GroupId $GroupId -DirectoryObjectId $u.Id
        Write-Host "Removed from group: $($u.UserPrincipalName)"
    }
}

Disconnect-MgGraph
