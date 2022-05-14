#!/bin/sh
set -e

npm upgrade -g solhint

export FOUNDRY_CONFIG=./configs/foundry.toml

forge update
