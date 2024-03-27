#!/bin/bash

# Check if the search directory is passed as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <search_directory>"
    exit 1
fi

# Get the search directory from the script's arguments
SEARCH_DIR=$1

# Check if the provided directory exists
if [ ! -d "$SEARCH_DIR" ]; then
    echo "Error: Directory $SEARCH_DIR does not exist."
    exit 1
fi

# Define the patterns to search for
PATTERNS=(
    # REST endpoints
    '/sla_domain/assign_to_downloaded_snapshots'
    '/sla_domain/'
    'unmanaged_object/assign_retention_sla'
    '/host' # We look for /host in case it's used for NAS system.
    # Python/Ansible
    'assign_sla'
    'create_sla'
    'delete_sla'
    'assign_physical_host_fileset'
    # PowerShell Module
    'New-RubrikSLA'
    'Set-RubrikSLA'
    'Remove-RubrikSLA'
    'Resume-RubrikSLA'
    'Pause-RubrikSLA'
    'Get-RubrikSLA' # While Get should work, we still look for it as it may indicate usage of a restricted API call
    'Suspend-RubrikSLA'
    'Protect-RubrikDatabase'
    'Protect-RubrikFileset'
    'Protect-RubrikHyperVVM'
    'Protect-RubrikNutanixVM'
    'Protect-RubrikTag'
    'Protect-RubrikVApp'
    'Protect-RubrikVM'
    'Protect-RubrikVolumeGroup'
    'RubrikNASShare'
)

# Temporary file to store compatible files
COMPATIBLE_FILES=$(mktemp)

# Check file encoding and add compatible files to the temporary file
echo "Checking file encodings in $SEARCH_DIR..."
find "$SEARCH_DIR" -type f | while read -r file; do
    if file -bI "$file" | grep -qE 'charset=(us-ascii|utf-8)'; then
        echo "$file" >> "$COMPATIBLE_FILES"
    else
        echo "Warning: $file skipped due to incompatible encoding."
    fi
done

# Function to search for a pattern in compatible files
search_pattern() {
    local pattern=$1
    echo "Searching for pattern: $pattern"

    while read -r file; do
        grep -nH "$pattern" "$file"
    done < "$COMPATIBLE_FILES"
}

# Loop over each pattern and search for it in compatible files
for pattern in "${PATTERNS[@]}"; do
    search_pattern "$pattern"
    echo "------------------------------------"
done

# Clean up
rm "$COMPATIBLE_FILES"

