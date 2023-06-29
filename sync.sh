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

    sudo apt-get install -y meld subversion undistract-me
    sudo snap install mdl  # markdownlint
}

function setup {
    mkdir -p ~/.vim/
    mkdir -p ~/.gdb
    mkdir -p ~/.gdbinit.d

    if ! [ -d ~/.vim/bundle/Vundle.vim ] ; then
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi

    if ! [ -d ~/.gdb/stlPrettyPrinter ] ; then
        pushd ~/.gdb >& /dev/null
        svn checkout svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python stlPrettyPrinter
        popd >& /dev/null
    fi

    if ! [ -d ~/.gdb/qt5printers.git ] ; then
        pushd ~/.gdb >& /dev/null
        git clone https://github.com/Lekensteyn/qt5printers.git
        popd >& /dev/null
    fi
}

function sync {
    for f in \
             .vim/vimrc \
             .gitconfig \
             .gdbinit \
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
