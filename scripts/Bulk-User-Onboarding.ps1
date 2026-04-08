# ================================================
# Bulk User Onboarding from CSV - Microsoft 365
# Author: BSEMC Game Dev Graduate
# ================================================

param (
    [string]$CsvPath = "C:\Users.csv"
)

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "User.ReadWrite.All","Group.ReadWrite.All","Directory.ReadWrite.All","UserAuthenticationMethod.ReadWrite.All"

$users = Import-Csv $CsvPath

foreach ($user in $users) {
    $password = "TempPass" + (Get-Random -Minimum 1000 -Maximum 9999) + "!"

    $params = @{
        DisplayName       = $user.DisplayName
        UserPrincipalName = $user.UserPrincipalName
        MailNickname      = $user.UserPrincipalName.Split('@')[0]
        AccountEnabled    = $true
        PasswordProfile   = @{
            Password                      = $password
            ForceChangePasswordNextSignIn = $true
        }
    }

    $newUser = New-MgUser @params
    Write-Host "✅ Created: $($newUser.UserPrincipalName) | Password: $password" -ForegroundColor Green

    # Optional: Add to Security Group
    # Add-MgGroupMember -GroupId "YOUR-GROUP-ID" -DirectoryObjectId $newUser.Id
}

Write-Host "`n🎉 Bulk onboarding completed!" -ForegroundColor Cyan
Disconnect-MgGraph
