#!/bin/sh
set -e

npm install -g husky lint-staged prettier prettier-plugin-solidity solhint
husky install configs

git submodule update --init --recursive
