#!/usr/bin/env bash
set -euo pipefail

REPO_NAME="rust-playground"

# Ensure gh is available
if ! command -v gh >/dev/null 2>&1; then
  echo "Error: GitHub CLI (gh) is not installed."
  exit 1
fi

# Ensure gh is authenticated
if ! gh auth status >/dev/null 2>&1; then
  echo "Error: gh is not authenticated. Run: gh auth login"
  exit 1
fi

# Initialize git repo if needed
if [ ! -d ".git" ]; then
  git init
fi

# Create an initial commit only if there are changes
git add .
if git diff --cached --quiet; then
  echo "No changes to commit."
else
  git commit -m "Initial commit"
fi

# Create the GitHub repo and push
gh repo create "$REPO_NAME" \
  --source=. \
  --public \
  --push \
  --confirm

echo "✅ GitHub repository '$REPO_NAME' created and pushed successfully."

