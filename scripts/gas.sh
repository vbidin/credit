#!/bin/sh
set -e

while getopts p: flag
do
    case "${flag}" in
        p) profile=${OPTARG};;
    esac
done

export FOUNDRY_CONFIG=./configs/foundry.toml
export FOUNDRY_PROFILE=$profile

forge test -o output --gas-report
