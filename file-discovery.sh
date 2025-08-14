#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to search for files
search_files() {
    local dir="$1"
    echo -e "${YELLOW}[*] Searching in $dir ${NC}"
    
    # Common credential file patterns including compressed files
    find "$dir" -type f \( \
        # Config files
        -iname "*.conf" -o -iname "*.cnf" -o -iname "*.config" -o \
        -iname "*.ini" -o -iname "*.inf" -o -iname "*.properties" -o \
        -iname "*.env" -o \
        
        # Data files
        -iname "*.txt" -o -iname "*.csv" -o -iname "*.xml" -o \
        -iname "*.json" -o -iname "*.yaml" -o -iname "*.yml" -o \
        
        # Scripts/logs
        -iname "*.ps1" -o -iname "*.bat" -o -iname "*.sh" -o \
        -iname "*.bak" -o -iname "*.log" -o \
        
        # Credential-related names
        -iname "*pass*" -o -iname "*cred*" -o -iname "*auth*" -o \
        -iname "*token*" -o -iname "*key*" -o \
        
        # Database files
        -iname "*.sql" -o -iname "*.db" -o -iname "*.sqlite" -o \
        -iname "*.mdf" -o -iname "*.ldf" -o -iname "*.bson" -o \
        
        # Security files
        -iname "*.kdbx" -o -iname "*.rdp" -o -iname "*.sdtid" -o \
        -iname "*.pfx" -o -iname "*.p12" -o -iname "*.crt" -o \
        -iname "*.cer" -o -iname "*.pem" -o -iname "*.ppk" -o \
        -iname "*.jks" -o -iname "*.kwallet" -o \
        
        # Network configs
        -iname "*.ovpn" -o \
        
        # Windows specific
        -iname "*.admx" -o -iname "*.adml" -o -iname "*.msi" -o \
        -iname "*.cab" -o \
        
        # macOS specific
        -iname "*.dmg" -o \
        
        # Compressed files
        -iname "*.zip" -o -iname "*.tar" -o -iname "*.gz" -o \
        -iname "*.bz2" -o -iname "*.7z" -o -iname "*.rar" -o \
        -iname "*.tgz" -o -iname "*.xz" -o -iname "*.lz" -o \
        -iname "*.z" -o -iname "*.zipx" -o -iname "*.iso" -o \
        
        # Java archives
        -iname "*.war" -o -iname "*.jar" -o -iname "*.ear" -o \
        
        # Financial files
        -iname "*.gnucash" -o \
        
        # Other data files
        -iname "*.tbls" \
    \) 2>/dev/null | while read -r file; do
        # Check file size (skip large files)
        size=$(stat -c%s "$file" 2>/dev/null || stat -f%z "$file" 2>/dev/null)
        
        if [ -z "$size" ] || [ "$size" -lt 1000000 ]; then
            if file "$file" | grep -q -E "archive|compressed"; then
                echo -e "${BLUE}[Archive] ${GREEN}$file${NC}"
            else
                echo -e "${GREEN}[File]    $file${NC}"
            fi
        fi
    done
}

# Check if running as root
if [ "$(id -u)" -eq 0 ]; then
    echo -e "${YELLOW}[*] Running as root, searching all directories ${NC}"
    search_files "/"
else
    echo -e "${YELLOW}[*] Running as user, searching user directories ${NC}"
    search_files "$HOME"
    search_files "/etc"
    search_files "/var"
    search_files "/tmp"
fi

echo -e "${YELLOW}[*] Search complete ${NC}"
