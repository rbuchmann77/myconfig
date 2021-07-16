#!/bin/bash

_SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}" | xargs readlink -f)"

function err_report {
    >&2 echo "ERROR on line $(caller)"
    exit 1
}

function bootstrap {
    if md5sum -c "${_SCRIPT_DIR}/installed.md5" ; then
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
    for f in \
             .vim/vimrc \
             .gitconfig \
             .gdbinit.d/init \
             .gdbinit.d/initQt \
             .gdbinit.d/initStl \
             .config/flake8 \
            ; do
        DIR=$(dirname ~/${f} | xargs readlink -f)
        mkdir -p "${DIR}"
        touch "${HOME}/${f}"
        if ! diff "${_SCRIPT_DIR}/${f}" "${HOME}/${f}" ; then
            meld "${_SCRIPT_DIR}/${f}" "${HOME}/${f}"
        fi
    done

    if ! grep -q ${_SCRIPT_DIR}/bashrc_myconfig ~/.bashrc ; then
        echo "source ${_SCRIPT_DIR}/bashrc_myconfig" >> ~/.bashrc
    fi
}

function main {
    trap 'err_report' ERR

    bootstrap
    setup
    sync
}

main
