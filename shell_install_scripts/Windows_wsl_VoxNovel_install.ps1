
# Define variables
$desktopPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'VoxNovel.lnk')
$scriptPath = "https://github.com/DrewThomasson/VoxNovel/blob/main/shell_install_scripts/Windows_wsl_run_VoxNovel.ps1"
$logoUrl = "https://github.com/DrewThomasson/VoxNovel/raw/6f49c6a8b36927c987b1d628ff3e9c1afcb04dab/readme_files/logo.jpeg"
$shortcutName = "VoxNovel"

# Create the shortcut
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($desktopPath)
$Shortcut.TargetPath = "powershell.exe"
$Shortcut.Arguments = "-ExecutionPolicy Bypass -File $scriptPath"
$Shortcut.IconLocation = "powershell.exe,0" # Default PowerShell icon
$Shortcut.Save()

# Download the logo
$logoPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'logo.jpeg')
Invoke-WebRequest -Uri $logoUrl -OutFile $logoPath

# Set the icon for the shortcut
$Shortcut.IconLocation = $logoPath
$Shortcut.Save()

# Run WSL installation
Start-Process powershell -ArgumentList "wsl --install Ubuntu" -NoNewWindow -Wait

# Wait for WSL installation to complete (adjust time if needed)
Start-Sleep -Seconds 60

# Run the installation script in the WSL environment
Start-Process powershell -ArgumentList "wsl -d Ubuntu -e bash -c 'yes | wget -O - https://raw.githubusercontent.com/DrewThomasson/VoxNovel/main/shell_install_scripts/Ubuntu-install.sh | bash'" -NoNewWindow -Wait