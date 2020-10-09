#!/bin/bash

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}" | xargs readlink -f)"

mkdir -p ~/.gdb
mkdir -p ~/.gdbinit.d

for f in .bashrc \
         .vim/vimrc \
         .gitconfig \
         .gdbinit.d/init \
         .gdbinit.d/initQt \
         .gdbinit.d/initStl \
         ; do
    DIR=$(dirname ~/${f} | xargs readlink -f)
    mkdir -p "${DIR}"
    touch "${HOME}/${f}"
    if ! diff "${SCRIPT_DIR}/${f}" "${HOME}/${f}" ; then
        meld "${SCRIPT_DIR}/${f}" "${HOME}/${f}"
    fi
done
