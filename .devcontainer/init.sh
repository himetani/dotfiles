#!/bin/bash
set -euo pipefail

echo "Running devcontainer initialization..."

# Create devcontainer directory if it doesn't exist
mkdir -p .devcontainer

# Get host UID/GID
HOST_UID=$(id -u)
HOST_GID=$(id -g)
echo "Host UID: $HOST_UID"
echo "Host GID: $HOST_GID"

# Write to envfile
cat > .devcontainer/envfile <<EOF
HOST_UID=$HOST_UID
HOST_GID=$HOST_GID
EOF

echo "Created .devcontainer/envfile with HOST_UID and HOST_GID"

# Create Claude configuration directory
mkdir -p "${HOME}/devcontainer/$(basename $(pwd))"

echo "Devcontainer initialization completed successfully!"