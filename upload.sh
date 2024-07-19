#!/bin/bash

# Function to prompt for user input
prompt_for_input() {
    read -p "$1" input
    echo "$input"
}

# Get user inputs
GITHUB_USERNAME=$(prompt_for_input "Enter your GitHub username: ")
REPOSITORY_NAME=$(prompt_for_input "Enter your GitHub repository name: ")
SSH_KEY_PATH=$(prompt_for_input "Enter the full path to your SSH key (e.g., /path/to/id_ed25519): ")
UPLOAD_FOLDER=$(prompt_for_input "Enter the full path of the folder you want to upload (e.g., /path/to/folder): ")

REPO_URL="git@github.com:$GITHUB_USERNAME/$REPOSITORY_NAME.git"

# Ensure the SSH key is added to the SSH agent
eval "$(ssh-agent -s)"
ssh-add "$SSH_KEY_PATH"

# Test SSH connection to GitHub
ssh -T git@github.com
if [ $? -ne 1 ]; then
  echo "Error: SSH authentication failed. Please check your SSH key and GitHub configuration."
  exit 1
fi

# Create a temporary directory to clone the repository
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Clone the repository using SSH
git clone $REPO_URL
if [ $? -ne 0 ]; then
  echo "Error: Failed to clone the repository. Please check your repository URL."
  exit 1
fi

# Change directory to the repository
cd $REPOSITORY_NAME

# Set the remote URL to use SSH
git remote set-url origin $REPO_URL

# Copy all files and folders from the specified upload folder to the repository directory
cp -r "$UPLOAD_FOLDER"/. .

# Stage all changes
git add .

# Commit the changes with a message
git commit -m "Add initial files and folders"

# Push the changes to the repository
git push origin main
if [ $? -ne 0 ]; then
  echo "Error: Failed to push changes to GitHub. Please check your remote repository configuration."
  exit 1
fi

echo "All files and folders have been uploaded to the repository."

# Cleanup
rm -rf "$TEMP_DIR"
