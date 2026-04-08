# Windows Temp Files + Disk Cleanup Automation
Write-Host "🧹 Starting Windows Cleanup..." -ForegroundColor Yellow

# Clear Temp folders
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

# Clear Recycle Bin
Clear-RecycleBin -Force -ErrorAction SilentlyContinue

Write-Host "✅ Cleanup completed! Disk space freed." -ForegroundColor Green

# Optional: Show current disk space
Get-PSDrive C | Select-Object @{Name="FreeGB";Expression={[math]::Round($_.Free/1GB,2)}}
