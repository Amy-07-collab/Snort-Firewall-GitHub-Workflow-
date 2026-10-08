#!/usr/bin/env bash

# Snort & Firewall Rules Lab - Git Bash Workflow
# Run these commands from the extracted project folder.

set -e

echo "=== Snort & Firewall Rules Lab ==="
echo "Checking Git..."
git --version

echo
echo "1. Initialize repository"
git init
git branch -M main

echo
echo "2. Review files"
git status

echo
echo "3. Stage documentation"
git add .

echo
echo "4. Create first commit"
git commit -m "Document Snort and firewall rules lab"

echo
echo "5. Add your GitHub remote manually if this is a new repository:"
echo "git remote add origin https://github.com/YOUR-USERNAME/snort-firewall-lab.git"

echo
echo "6. Push:"
echo "git push -u origin main"

echo
echo "After adding screenshots or updating notes:"
echo "git add ."
echo 'git commit -m "Add lab evidence and findings"'
echo "git push"

echo
echo "Workflow ready."
