#!/bin/sh
set -e

export FOUNDRY_CONFIG=./configs/foundry.toml

forge build -o output
