# This script initializes blank rules files for various editors in the project root.

# Get the directory where the script itself is located
# $PSScriptRoot is an automatic variable that contains the full path of the directory
# from which the current script is being executed.
$scriptDirectory = $PSScriptRoot

# Now, get the parent directory of the script's directory.
# This will be your project root.
$projectRoot = (Get-Item $scriptDirectory).Parent.FullName

Write-Host "Script is located at: $($scriptDirectory)"
Write-Host "Determined project root: $($projectRoot)"
Write-Host "`nCreating blank rules files for various editors in project root: $($projectRoot)"

# First, handle the ai_rules directory and rules.md file
Write-Host "`n--- AI Rules ---"
$aiRulesDir = Join-Path $projectRoot "ai_rules"
$aiRulesFile = Join-Path $aiRulesDir "shared-rules.md"

# Create ai_rules directory if it doesn't exist
if (-not (Test-Path $aiRulesDir)) {
	New-Item -ItemType Directory -Path $aiRulesDir | Out-Null
	Write-Host "Created directory: $aiRulesDir"
}

# Create rules.md file if it doesn't exist
if (-not (Test-Path $aiRulesFile)) {
	New-Item -ItemType File -Path $aiRulesFile | Out-Null
	Write-Host "Created blank file: $aiRulesFile"
}

# Define an array of objects, each representing an editor's rules file configuration
$editorConfigs = @(
	# @{
	# 	Name      = "Visual Studio Code (GitHub Copilot)"
	# 	Directory = ".github"
	# 	FileName  = "copilot-instructions.md"
	# },
	@{
		Name      = "Cursor"
		Directory = "."
		FileName  = ".cursorrules"
	},
	@{
		Name      = "Windsurf"
		Directory = ".windsurf\rules"
		FileName  = "shared_rules.md"
	}
)

# Loop through each editor configuration
foreach ($config in $editorConfigs) {
	Write-Host "`n--- $($config.Name) ---" # Separator for clarity

	$rulesDir = Join-Path $projectRoot $config.Directory
	$rulesFile = Join-Path $rulesDir $config.FileName

	# Attempt to create the directory. -Force will create it and any parent directories if they don't exist.
	# It will also do nothing if the directory already exists.
	try {
		New-Item -ItemType Directory -Path $rulesDir -Force -ErrorAction Stop | Out-Null
		Write-Host "Ensured directory exists: $rulesDir"
 }
	catch {
		Write-Host "Failed to create directory $rulesDir : $($_.Exception.Message)" -ForegroundColor Red
	}
	# Create symlink if it doesn't exist
	if (-not (Test-Path $rulesFile)) {
		try {
			New-Item -ItemType SymbolicLink -Path $rulesFile -Target $aiRulesFile -ErrorAction Stop | Out-Null
			Write-Host "Created symlink: $rulesFile -> $aiRulesFile"
  }
		catch {
			Write-Host "Failed to create symlink $rulesFile : $($_.Exception.Message)" -ForegroundColor Red
		}
	}
	else {
		Write-Host "File/link already exists: $rulesFile (Skipping creation)"
	}
}

Write-Host "`nScript completed." -ForegroundColor Green
