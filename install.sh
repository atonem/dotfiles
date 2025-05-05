#!/usr/bin/env bash

# --use-builtin-git since a new macOS machine requires accepting xcode license
sh -c "$(curl -fsLS get.chezmoi.io)" \
  -- init atonem \
  --apply \
  --use-builtin-git true \
  --purge-binary \
  "${@}"
