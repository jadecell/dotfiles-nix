#!/bin/sh
cd ~/.config/nixos
sudo nixos-rebuild -I nixos-config=configuration.nix switch --flake .#
cd ..
