#!/bin/bash

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}" | xargs readlink -f)"

function err_report {
    >&2 echo "ERROR on line $(caller)"
    exit 1
}

function bootstrap {
    if md5sum -c "${SCRIPT_DIR}/installed.md5" ; then
        return
    fi

    sudo apt-get install -y meld subversion
}

function setup {
    mkdir -p ~/.vim/
    mkdir -p ~/.gdb
    mkdir -p ~/.gdbinit.d
}

function sync {
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
}

function main {
    trap 'err_report' ERR

    bootstrap
    setup
    sync
}

main
