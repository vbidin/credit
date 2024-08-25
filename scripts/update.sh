#!/bin/sh
set -e

export FOUNDRY_CONFIG=./configs/foundry.toml

foundryup
forge update
npm upgrade -g \
  prettier \
  prettier-plugin-solidity \
  prettier-plugin-toml \
  prettier-plugin-sh \
  solhint
