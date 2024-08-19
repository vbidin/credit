#!/bin/sh
set -e

export FOUNDRY_CONFIG=./configs/foundry.toml

npm install -g solhint
curl -L https://foundry.paradigm.xyz | bash
foundryup
forge install
