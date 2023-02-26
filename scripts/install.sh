#!/bin/sh
set -e

export FOUNDRY_CONFIG=./configs/foundry.toml

curl -L https://foundry.paradigm.xyz | bash && foundryup
npm install -g husky lint-staged prettier prettier-plugin-solidity solhint

husky install configs
forge install
