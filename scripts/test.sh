#!/bin/sh
set -e

while getopts p:t: flag
do
    case "${flag}" in
        t) test=${OPTARG};;
    esac
done

export FOUNDRY_CONFIG=./configs/foundry.toml

if [ -z "$test" ];
then
    forge test --match-path "tests/*";
else
    forge test --match "$test";
fi
