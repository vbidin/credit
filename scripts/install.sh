#!/bin/sh
set -e

npm install -g husky lint-staged@11.2.6 prettier prettier-plugin-solidity solhint
husky install configs
git submodule update --init --recursive
