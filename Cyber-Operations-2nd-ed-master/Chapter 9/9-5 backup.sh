#!/bin/bash
# Example of an insecure backup script

# What to backup. 
backup_files="/home/*/Desktop"

# Where to backup to.
dest="/media/sf_Downloads"

# Create archive filename.
day=$(date +%A)
hostname=$(hostname -s)
archive_file="$hostname-$day.tgz"

# Backup options
opts = "czf"
if [ -e /tmp/backup ]
then
   source /tmp/backup

# Print start status message.
echo "Backing up $backup_files to $dest/$archive_file"
date
echo

# Backup the files using tar.
tar $opts $dest/$archive_file $backup_files

# Print end status message.
echo
echo "Backup finished"
date
