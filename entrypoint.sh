#!/bin/bash
set -e

# Define Version and URL for the ZIP file (safer download)
SMF_VERSION="2-1-4"
SMF_URL="https://download.simplemachines.org/index.php?thanks;filename=smf_2-1-4_install.zip"
SMF_FILENAME="smf_install.zip"

# Check if index.php exists. If not, install SMF.
if [ ! -f /var/www/html/index.php ]; then
    echo "[SMF] SMF not found. Downloading version ${SMF_VERSION}..."
    
    # Download the ZIP file
    curl -L -o "$SMF_FILENAME" "$SMF_URL"
    
    # Extract using unzip (Fixes the "not in gzip format" error)
    unzip "$SMF_FILENAME"
    rm "$SMF_FILENAME"
    
    # Fix Permissions
    chown -R www-data:www-data /var/www/html
    echo "[SMF] Installation files ready. Please browse to your site to finish setup."
else
    echo "[SMF] SMF detected. Starting Apache."
fi

# Execute the main container command (Apache)
exec "$@"