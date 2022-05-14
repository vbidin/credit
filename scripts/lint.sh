#!/bin/sh
set -e

solhint -c configs/solhint.json 'interfaces/**/*.sol' 'contracts/**/*.sol' 'tests/**/*.sol'
