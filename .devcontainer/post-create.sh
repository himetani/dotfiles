#!/bin/bash
set -euo pipefail

echo "Running post-create setup..."

# Configure git to trust the workspace directory
echo "Configuring git safe directory..."
git config --global --add safe.directory /workspace

# Configure git user from environment variables
if [ -n "${GIT_USER_NAME:-}" ]; then
  echo "Setting git user name to: $GIT_USER_NAME"
  git config --global user.name "$GIT_USER_NAME"
fi

if [ -n "${GIT_USER_EMAIL:-}" ]; then
  echo "Setting git user email to: $GIT_USER_EMAIL"
  git config --global user.email "$GIT_USER_EMAIL"
fi

# Configure git repository authentication using gh token
gh auth setup-git

# Initialize firewall
echo "Initializing firewall..."
sudo /usr/local/bin/init-firewall.sh

# Trust and install mise packages
echo "Setting up mise..."
bash -lc 'mise trust -a && mise install -y'

# Add mise activation to zsh configuration
echo "Configuring mise activation in zsh..."
echo 'eval "$(mise activate zsh)"' >>~/.zshrc

echo "Post-create setup completed successfully!"

