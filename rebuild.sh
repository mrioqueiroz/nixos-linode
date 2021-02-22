#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o xtrace
set -o pipefail

nocache=$(date +%H%M%S)
url="https://github.com/mrioqueiroz/nixos-linode/raw/main/configuration.nix?${nocache}"

curl -L -H "Cache-Control: no-cache" "${url}" > /etc/nixos/configuration.nix
