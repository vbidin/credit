#!/bin/sh
set -e

foundryup
npm upgrade -g husky lint-staged prettier prettier-plugin-solidity solhint

export FOUNDRY_CONFIG=./configs/foundry.toml

forge update
