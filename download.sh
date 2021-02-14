#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o xtrace
set -o pipefail

update-ca-certificates
iso=https://channels.nixos.org/nixos-20.09/latest-nixos-minimal-x86_64-linux.iso
curl -L $iso | tee >(dd of=/dev/sda) | sha256sum
curl -L https://channels.nixos.org/nixos-20.09/latest-nixos-minimal-x86_64-linux.iso.sha256
