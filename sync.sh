#!/bin/bash

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}" | xargs readlink -f)"

function errexit() {
  local err=$?
  local code="${1:-1}"
  echo "Error in ${BASH_SOURCE[1]}:${BASH_LINENO[0]}. '${BASH_COMMAND}' exited with status $err"
  exit "${code}"
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
    trap 'errexit' ERR
    set -o errtrace

    bootstrap
    setup
    sync
}

main
