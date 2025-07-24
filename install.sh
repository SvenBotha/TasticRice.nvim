#!/bin/bash

# Tastic Rice - Neovim Configuration Installer
# This script installs the Tastic Rice Neovim configuration

set -e # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Set the source directory to the current directory where the script is located
source_dir="$(dirname "$0")"
target_dir="$HOME/.config/nvim"

echo -e "${YELLOW}Installing Tastic Rice Neovim Configuration...${NC}"

# Backup existing config if it exists
if [ -d "$target_dir" ]; then
    backup_dir="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    echo -e "${YELLOW}Backing up existing config to: $backup_dir${NC}"
    mv "$target_dir" "$backup_dir"
fi

# Create the nvim config directory
echo "Creating config directory..."
mkdir -p "$target_dir"

# Copy configuration files (exclude install scripts and git files)
echo "Copying configuration files..."
for item in "$source_dir"/*; do
    filename=$(basename "$item")
    # Skip installation files, git files, and other unwanted files
    if [[ "$filename" != "install.sh" ]]; then
        cp -r "$item" "$target_dir/"
    fi
done

echo -e "${GREEN}✓ Tastic Rice Neovim configuration installed successfully!${NC}"
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Open Neovim: nvim"
echo "2. Lazy.nvim will automatically install plugins on first run"
echo "3. Enjoy your new Tastic Rice setup!"
