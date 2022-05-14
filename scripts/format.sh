#!/bin/sh
set -e

prettier --config configs/prettier.json --ignore-path configs/prettierignore --write .
