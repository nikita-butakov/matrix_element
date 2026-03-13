#!/bin/bash

# Exit immediately if a command fails
set -e

# Get directory where this script is located
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

# Path to Nginx Proxy Manager certificates
NPM_CERT_DIR="$BASE_DIR/npm/letsencrypt/live/npm-2"

# Path to Synapse data directory
SYNAPSE_DATA_DIR="$BASE_DIR/synapse/data"

# Synapse container name
SYNAPSE_CONTAINER="synapse"

# Source certificate files
FULLCHAIN_SRC="$NPM_CERT_DIR/fullchain.pem"
PRIVKEY_SRC="$NPM_CERT_DIR/privkey.pem"

# Destination files inside Synapse data directory
CERT_DST="$SYNAPSE_DATA_DIR/cert.pem"
KEY_DST="$SYNAPSE_DATA_DIR/key.pem"

echo "Starting certificate update..."

# Check if certificate files exist
if [[ ! -f "$FULLCHAIN_SRC" || ! -f "$PRIVKEY_SRC" ]]; then
    echo "❌ Certificate files not found in $NPM_CERT_DIR"
    exit 1
fi

# Copy certificates to Synapse directory
echo "Copying certificates..."
cp "$FULLCHAIN_SRC" "$CERT_DST"
cp "$PRIVKEY_SRC" "$KEY_DST"

# Set correct permissions (Synapse container runs as uid 1000)
echo "Setting file permissions..."
chown 1000:1000 "$CERT_DST" "$KEY_DST"
chmod 644 "$CERT_DST" "$KEY_DST"

# Restart Synapse container to apply new certificates
echo "Restarting Synapse container..."
docker restart "$SYNAPSE_CONTAINER"

echo "✅ Certificates successfully updated and Synapse container restarted."
