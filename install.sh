#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o xtrace
set -o pipefail

sudo -i
mount /dev/sda /mnt
swapon /dev/sdb
nixos-generate-config --root /mnt

hardware="/mnt/etc/nixos/hardware-configuration.nix"

# FIX:
sed -i 's/.*fileSystems.*//g' ${hardware}
sed -i 's/.*device.*//g' ${hardware}
sed -i 's/.*fsType.*;//g' ${hardware}
sed -i 's/.*swapDevices.*//g' ${hardware}
sed -i 's/}\n\s\s\s\s];//g' ${hardware}
sed -i 's/\s\s};//g' ${hardware}
sed -i 's/\n//g' ${hardware}

curl -L https://github.com/mrioqueiroz/nixos-linode/raw/main/configuration.nix > /mnt/etc/nixos/configuration.nix
nixos-install
nix-collect-garbage -d
rm -rf /var/log/*
