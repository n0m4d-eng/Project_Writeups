#!/bin/bash

# Check if a directory name was provided
if [ -z "$1" ]; then
  echo "create_machine_dir <machine name>"
  echo "Usage: create_machine_dir.sh <directory-name>"
  exit 1
fi

dirname="$1"

# Create the main directory
mkdir -p "$dirname"

# Check if the main directory was created successfully
if [ $? -eq 0 ]; then
  echo "Main directory '$dirname' created successfully."

  # Create subdirectories
  for subdir in hashes passwords users vulns files; do
    mkdir -p "$dirname/$subdir"
    echo "Created subdirectory: $dirname/$subdir"
  done
else
  echo "Failed to create main directory '$dirname'."
  exit 1
fi
