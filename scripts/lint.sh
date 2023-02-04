#!/bin/sh
set -e

prettier --loglevel warn --config configs/prettier.json --ignore-path configs/prettierignore --write .
solhint -c configs/solhint.json 'interfaces/**/*.sol' 'contracts/**/*.sol' 'tests/**/*.sol'
