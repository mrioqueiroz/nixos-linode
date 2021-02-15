#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o xtrace
set -o pipefail

sudo -i
mount /dev/sda /mnt
swapon /dev/sdb
nixos-generate-config --root /mnt
cd /mnt/etc/nixos
curl -L https://github.com/mrioqueiroz/nixos-linode/raw/main/configuration.nix > configuration.nix
nixos-install
