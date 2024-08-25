#!/bin/sh
set -e

. ~/.nvm/nvm.sh

prettier \
  --config configs/prettier.toml \
  --ignore-path configs/prettierignore \
  --plugin ~/.nvm/versions/node/$(nvm current)/lib/node_modules/prettier-plugin-solidity/src/index.js \
  --plugin ~/.nvm/versions/node/$(nvm current)/lib/node_modules/prettier-plugin-toml/lib/index.js \
  --plugin ~/.nvm/versions/node/$(nvm current)/lib/node_modules/prettier-plugin-sh/lib/index.js \
  --write .
