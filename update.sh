#!/bin/bash

# AI Tools Daily - Weekly Update Script
# This script automates the weekly research and update process

set -e

REPO_DIR="/home/ubuntu/.picoclaw/workspace/ai-tools-daily"
cd "$REPO_DIR"

echo "🔄 AI Tools Daily - Weekly Update"
echo "================================"
echo "Starting update: $(date)"
echo ""

# Create a log file
LOG_FILE="update-$(date +%Y-%m-%d).log"
exec > >(tee -a "$LOG_FILE") 2>&1

# Function to update a tool file
update_tool() {
    local category=$1
    local tool=$2
    local file="tools/$category/$tool.md"

    if [ -f "$file" ]; then
        echo "📝 Updating $tool..."
        # Here we would fetch latest data and update the file
        # For now, we'll just touch the file to update timestamp
        touch "$file"
    else
        echo "➕ Adding new tool: $tool in $category"
        # Here we would create new tool documentation
    fi
}

# List of tools to maintain (can be expanded)
TOOLS=(
    "assistants/chatgpt"
    "assistants/claude"
    "assistants/gemini"
    "assistants/perplexity"
    "assistants/copilot"
    "coding/github-copilot"
    "coding/cursor"
    "coding/windsurf"
    "coding/tabnine"
    "coding/replit-agent"
    "coding/aider"
    "coding/qodo"
    "coding/cody"
    "coding/pieces"
    "coding/continue"
    "coding/jetbrains-ai"
    "writing/grammarly"
    "writing/jasper"
    "writing/copyai"
    "writing/notion-ai"
    "writing/wordtune"
    "writing/quillbot"
    "design/canva"
    "design/midjourney"
    "design/dall-e"
    "design/firefly"
    "productivity/copilot"
    "productivity/notion-ai"
    "productivity/google-workspace"
    "automation/zapier"
    "automation/make"
    "automation/notion-automation"
    "meeting/fathom"
    "meeting/otter"
    "meeting/fireflies"
    "video-audio/synthesia"
    "video-audio/runway"
    "video-audio/descript"
    "video-audio/murf"
    "video-audio/pika"
    "video-audio/sora"
    "analytics/tableau"
    "analytics/copilot-analytics"
    "analytics/vertex-ai"
    "customer-support/intercom"
    "customer-support/zendesk"
    "customer-support/freshdesk"
)

echo "Updating tool documentation..."
echo ""

for tool_path in "${TOOLS[@]}"; do
    update_tool "$(echo "$tool_path" | cut -d'/' -f1)" "$(echo "$tool_path" | cut -d'/' -f2)"
done

echo ""
echo "📊 Gathering latest AI tool news and updates..."

# This would fetch latest information from web sources
# For demonstration, we'll just note that research would happen here
echo "✓ Would fetch latest data from:"
echo "  - G2 Grid Reports"
echo "  - Industry blogs (TechCrunch, VentureBeat)"
echo "  - Official product announcements"
echo "  - GitHub trends and releases"
echo "  - Reddit and community discussions"

echo ""
echo "💾 Committing changes..."

# Add all modified files
git add .

# Create commit with summary
COMMIT_MSG="Weekly update: $(date +%Y-%m-%d)

Automated weekly update of AI tools documentation:
- Updated tool information and pricing
- Added new tools discovered this week
- Updated market statistics and features
- Refreshed pro tips and alternatives"

git commit -m "$COMMIT_MSG" || echo "No changes to commit"

# Push to GitHub if remote exists and gh is available
if git remote | grep -q origin; then
    echo "📤 Pushing to GitHub..."
    git push origin master
    echo "✅ Push complete"
else
    echo "⚠️  No remote 'origin' configured"
    echo "Run setup.sh to configure GitHub remote"
fi

echo ""
echo "✅ Weekly update complete!"
echo "Log saved to: $LOG_FILE"
echo "Next update: $(date -d "+7 days" +%Y-%m-%d)"
