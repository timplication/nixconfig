#!/usr/bin/env bash

# apply the configuration locally
sudo nix-env --profile /nix/var/nix/profiles/system --set ./result
sudo ./result/bin/switch-to-configuration boot
