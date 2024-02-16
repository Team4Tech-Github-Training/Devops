#!/bin/bash
# Warning do not run this script if you havent taken permission from the system admin
# Define the age threshold
DAYS=30
REGION=ca-central-1



# Define the directory to search in. Be very careful with this setting!
# Using "/" will search the entire system, which can be very dangerous.
# It's better to specify a directory like "/var/tmp" or "/tmp"
TARGET_DIRECTORY="/path/to/target/directory"

# Find and delete files older than the specified number of days
find $TARGET_DIRECTORY -type f -mtime +$DAYS -exec rm -f {} \;

echo "Files older than $DAYS days have been deleted."

