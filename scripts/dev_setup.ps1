# This script should be run to set up the development environment for the project.

# Setup vibe rules files for various editors
Write-Host "Setting up vibe rules"
& "$PSScriptRoot\init_vibe_rules.ps1"

# ToDo: Install other tools

Write-Host "`nDevelopment environment setup completed."
