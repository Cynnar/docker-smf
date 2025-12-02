#!/bin/bash
set -e

# Define Version to download if empty
SMF_VERSION="2-1-4"
SMF_URL="https://download.simplemachines.org/index.php/smf_${SMF_VERSION}_install.tar.gz"

# Check if index.php exists. If not, install SMF.
if [ ! -f /var/www/html/index.php ]; then
    echo "[SMF] SMF not found. Downloading version ${SMF_VERSION}..."
    
    # Download and Extract
    curl -L -o smf_install.tar.gz "$SMF_URL"
    tar -xzf smf_install.tar.gz
    rm smf_install.tar.gz
    
    # Fix Permissions
    chown -R www-data:www-data /var/www/html
    echo "[SMF] Installation files ready. Please browse to your site to finish setup."
else
    echo "[SMF] SMF detected. Starting Apache."
fi

# Execute the main container command (Apache)
exec "$@"