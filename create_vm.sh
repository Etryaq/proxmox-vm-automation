#!/bin/bash
# Description: Automate VM creation from a template in Proxmox VE
# Author: Eslam (System Administrator)

# Variables
TEMPLATE_ID=9000
NEW_VM_ID=$1
VM_NAME=$2
STORAGE="local-lvm"
BRIDGE="vmbr0"

if [ -z "$NEW_VM_ID" ] || [ -z "$VM_NAME" ]; then
  echo "Usage: ./create_vm.sh <New_VM_ID> <VM_Name>"
  exit 1
fi

echo "Creating VM $VM_NAME (ID: $NEW_VM_ID) from Template $TEMPLATE_ID..."
qm clone $TEMPLATE_ID $NEW_VM_ID --name $VM_NAME --full

echo "Configuring Network and Starting VM..."
qm set $NEW_VM_ID --net0 virtio,bridge=$BRIDGE
qm start $NEW_VM_ID

echo "VM $VM_NAME successfully created and started!"
