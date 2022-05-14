#!/bin/sh
set -e

while getopts p:t: flag
do
    case "${flag}" in
        p) profile=${OPTARG};;
        t) test=${OPTARG};;
    esac
done

export FOUNDRY_CONFIG=./configs/foundry.toml
export FOUNDRY_PROFILE=$profile

if [ -z "$test" ];
then
    forge test --match-path "tests/*" -o output;
else
    forge test --match "$test" -o output;
fi
