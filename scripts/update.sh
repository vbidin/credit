#!/bin/sh
set -e

export FOUNDRY_CONFIG=./configs/foundry.toml

npm upgrade -g solhint
foundryup
forge update
