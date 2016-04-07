#!/bin/bash
set -x
cd $(dirname "$0")/bundle/YouCompleteMe
./install.py --tern-completer --racer-completer --clang-completer
