#!/bin/bash

# Variables
VolumeId="<VolumeId>" # ID of the EBS volume to encrypt
Region="<Region>" # AWS Region of the EBS volume
Description="Encrypted snapshot of $VolumeId"

# Create a snapshot of the existing volume
SnapshotId=$(aws ec2 create-snapshot --volume-id $VolumeId --description "$Description" --query SnapshotId --output text --region $Region)
echo "Snapshot created: $SnapshotId"

# Wait for the snapshot to be completed
aws ec2 wait snapshot-completed --snapshot-ids $SnapshotId --region $Region
echo "Snapshot $SnapshotId is ready"

# Copy the snapshot with encryption
EncryptedSnapshotId=$(aws ec2 copy-snapshot --source-region $Region --source-snapshot-id $SnapshotId --description "$Description - Encrypted" --encrypted --query SnapshotId --output text --region $Region)
echo "Encrypted snapshot created: $EncryptedSnapshotId"

# Wait for the encrypted snapshot to be completed
aws ec2 wait snapshot-completed --snapshot-ids $EncryptedSnapshotId --region $Region
echo "Encrypted snapshot $EncryptedSnapshotId is ready"

# Create a new encrypted volume from the encrypted snapshot
EncryptedVolumeId=$(aws ec2 create-volume --snapshot-id $EncryptedSnapshotId --availability-zone ${Region}a --encrypted --query VolumeId --output text --region $Region)
echo "Encrypted volume created: $EncryptedVolumeId"

# Optional: Attach the new encrypted volume to an instance (replace <InstanceId> with your actual instance ID)
# InstanceId="<InstanceId>"
# aws ec2 attach-volume --volume-id $EncryptedVolumeId --instance-id $InstanceId --device /dev/sdf --region $Region
# echo "Encrypted volume $EncryptedVolumeId attached to instance $InstanceId"

