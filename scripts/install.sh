#!/bin/sh
set -e

npm install -g prettier prettier-plugin-solidity solhint

git submodule update --init --recursive

# TODO: setup husky and lint-staged for auto-linting
