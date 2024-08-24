#!/bin/sh
set -e

export FOUNDRY_CONFIG=./configs/foundry.toml

npm upgrade -g prettier prettier-plugin-solidity prettier-plugin-toml solhint
foundryup
forge update
