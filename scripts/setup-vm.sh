#!/usr/bin/env bash

qcow_path="$1"

if [ -z "$qcow_path" ]; then
  printf 'Error: missing qcow file path\n' >&2
  exit 1
fi

virt-install \
  --name haos \
  --description "Home Assistant OS" \
  --os-variant=generic \
  --ram=3072 \
  --vcpus=6 \
  --disk "$qcow_path",bus=scsi \
  --controller type=scsi,model=virtio-scsi \
  --import \
  --graphics none \
  --boot uefi \
  --connect qemu:///system \
  --network bridge=br0,model=virtio,mac=52:54:00:da:db:0d \
  --hostdev 0x303a:0x4001 \
  --hostdev 0x303a:0x831a
