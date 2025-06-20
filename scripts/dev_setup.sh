#!/bin/bash

# This script should be run to set up the development environment for the project.

# ToDo: Install tools and check versions

# Setup vibe rules files for various editors
echo "Setting up vibe rules"
"$(dirname "$0")/init_vibe_rules.sh"

# ToDo: Install and configure tools

echo ""
echo "Development environment setup completed."