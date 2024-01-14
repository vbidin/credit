#!/bin/sh
set -e

solhint -c configs/solhint.json 'contracts/**/*.sol' 'interfaces/**/*.sol' 'tests/**/*.sol'
