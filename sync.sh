#!/bin/bash

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}" | xargs readlink -f)"

for f in .bashrc .vim/vimrc .gitconfig .gdbinit ; do
    meld ${SCRIPT_DIR}/${f} ~/${f}
done
