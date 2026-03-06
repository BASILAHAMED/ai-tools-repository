#!/bin/bash

# AI Tools Daily - Repository Setup and Automation Script
# This script sets up the GitHub repository and configures weekly updates

set -e

echo "🚀 AI Tools Daily - Repository Setup"
echo "===================================="

# Navigate to repository directory
cd /home/ubuntu/.picoclaw/workspace/ai-tools-daily

# Check if git is initialized
if [ ! -d .git ]; then
    echo "Initializing git repository..."
    git init
fi

# Add all files
echo "Adding files to git..."
git add .

# Commit changes
echo "Committing changes..."
git commit -m "Update: $(date +%Y-%m-%d) - Weekly AI tools update"

# Check if GitHub CLI is installed
if command -v gh &> /dev/null; then
    echo "GitHub CLI found!"

    # Check if user is authenticated
    if gh auth status &> /dev/null; then
        echo "GitHub CLI authenticated."

        # Check if repository exists
        if gh repo view $(git config user.username)/ai-tools-daily &> /dev/null; then
            echo "Repository exists, pushing updates..."
            git push origin master
        else
            echo "Creating new repository..."
            gh repo create ai-tools-daily --public --description "Weekly updated comprehensive documentation of the best AI tools across all categories" --homepage "https://github.com/$(git config user.username)/ai-tools-daily"
            git branch -M main
            git remote add origin https://github.com/$(git config user.username)/ai-tools-daily.git
            git push -u origin main
        fi
    else
        echo "⚠️  GitHub CLI not authenticated. Please run: gh auth login"
        echo "Then re-run this script."
    fi
else
    echo "⚠️  GitHub CLI (gh) not installed."
    echo "To enable automatic GitHub pushes, install gh:"
    echo "  sudo apt-get update && sudo apt-get install -y gh"
    echo "Then authenticate: gh auth login"
    echo ""
    echo "For now, repository is ready for manual push:"
    echo "  git remote add origin <your-repo-url>"
    echo "  git push -u origin master"
fi

echo "✅ Setup complete!"
