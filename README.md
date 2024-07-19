### README.md

# GitHub Repository Uploader

This repository contains a script to upload contents from a specified folder to your GitHub repository using SSH.

## How to Generate an SSH Key and Add it to GitHub

### Step 1: Generate a New SSH Key

1. Open Terminal:
   - Open your terminal application.

2. Generate a new SSH key:
   - Use the command: `ssh-keygen -t ed25519 -C "your_email@example.com"`
   - If you're using a legacy system that doesn't support the Ed25519 algorithm, use RSA instead: `ssh-keygen -t rsa -b 4096 -C "your_email@example.com"`

3. Follow the prompts:
   - When prompted to "Enter a file in which to save the key," press Enter to save the key in the default location (`~/.ssh/id_ed25519` or `~/.ssh/id_rsa`).
   - Enter a secure passphrase when prompted.

### Step 2: Add Your SSH Key to the SSH Agent

1. Start the SSH agent in the background:
   - Use the command: `eval "$(ssh-agent -s)"`

2. Add your SSH private key to the SSH agent:
   - For Ed25519: `ssh-add ~/.ssh/id_ed25519`
   - For RSA: `ssh-add ~/.ssh/id_rsa`

### Step 3: Add Your SSH Key to Your GitHub Account

1. Copy the SSH key to your clipboard:
   - For Ed25519: `pbcopy < ~/.ssh/id_ed25519.pub`
   - For RSA: `pbcopy < ~/.ssh/id_rsa.pub`

2. Add the SSH key to GitHub:
   - Log in to your GitHub account.
   - Go to **Settings**.
   - Click on **SSH and GPG keys** in the sidebar.
   - Click **New SSH key**.
   - Add a descriptive label for the new key.
   - Paste your key into the "Key" field.
   - Click **Add SSH key**.

## How to Use the Script

### Step 1: Create the Shell Script File

1. Open Terminal:
   - Open your terminal application.

2. Create a new shell script file:
   - Use the command: `nano script.sh`

3. Copy and paste the provided script into the `script.sh` file.

4. Save and close the file:
   - Press `Ctrl + X` to exit.
   - Press `Y` to confirm changes.
   - Press `Enter` to save the file.

### Step 2: Make the Script Executable

Make the script executable:
   - Use the command: `chmod +x script.sh`

### Step 3: Run the Script

Run the script:
   - Use the command: `./script.sh`

