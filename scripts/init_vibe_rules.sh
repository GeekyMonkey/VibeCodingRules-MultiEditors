#!/bin/bash

# This script initializes blank rules files for various editors in the project root.

# Get the directory where the script itself is located
# dirname "$0" gets the directory of the script
# cd "$(dirname "$0")" changes into that directory
# pwd -P gets the absolute path, resolving symlinks
script_directory="$(cd "$(dirname "$0")" && pwd -P)"

# Now, get the parent directory of the script's directory.
# This will be your project root.
project_root="$(dirname "$script_directory")"

echo "Script is located at: $script_directory"
echo "Determined project root: $project_root"
echo ""
echo "Creating blank rules files for various editors in project root: $project_root"

# First, handle the ai_rules directory and rules.md file
echo ""
echo "--- AI Rules ---"
ai_rules_dir="$project_root/ai_rules"
ai_rules_file="$ai_rules_dir/shared-rules.md"

# Create ai_rules directory if it doesn't exist
if [ ! -d "$ai_rules_dir" ]; then
    mkdir "$ai_rules_dir"
    echo "Created directory: $ai_rules_dir"
fi

# Create rules.md file if it doesn't exist
if [ ! -f "$ai_rules_file" ]; then
    touch "$ai_rules_file"
    echo "Created blank file: $ai_rules_file"
fi

# Define an array of configurations.
# Each string in the array will represent an editor's config: "Name;Directory;FileName"
editor_configs=(
    # "Visual Studio Code (GitHub Copilot);.github;copilot-instructions.md"
    "Cursor;.;project_rules.mdc"
    "Windsurf;.windsurf/rules;shared_rules.md"
)

# Loop through each editor configuration
for config in "${editor_configs[@]}"; do
    # Split the string into components
    IFS=';' read -r name dir_path file_name <<< "$config"

    echo ""
    echo "--- $name ---"

    # Construct the full paths
    full_dir="$project_root/$dir_path"
    full_file="$full_dir/$file_name"

    # Create directory if it doesn't exist.
    # mkdir -p will create parent directories as needed and won't error if directory exists.
    if mkdir -p "$full_dir"; then
        echo "Ensured directory exists: $full_dir"
    else
        echo "Error: Failed to create or ensure directory $full_dir" >&2
    fi

    # Create symlink if it doesn't exist
    if [ ! -e "$full_file" ]; then
        if ln -s "$ai_rules_file" "$full_file"; then
            echo "Created symlink: $full_file -> $ai_rules_file"
        else
            echo "Error: Failed to create symlink $full_file" >&2
        fi
    else
        echo "File/link already exists: $full_file (Skipping creation)"
    fi
done

echo ""
echo "Script completed."
