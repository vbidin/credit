#!/bin/sh
set -e

npm upgrade -g husky prettier prettier-plugin-solidity solhint

export FOUNDRY_CONFIG=./configs/foundry.toml

forge update
