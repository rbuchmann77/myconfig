My config
=========

This repository includes:
- VIM config
    checkers for Qt/bash/english/python...
    syntax highlighting for markdown, qml, asciidoc, javascript...
    UI: theme, line highlighting, status bar
    git status
    rainbow parenthesis
    yank ring (F11)
- bash config
    setTermTitle: rename terminal (default: current directory name)
    color prompt: green/red given last exit status
    merge history (all terminals)
- git config
    add alias:
    * la (beautiful log)
    * graph (textual one), useful to avoid X11
- gdb config
    helpers for Qt and stl
    demangle


Installation
------------

git clone https://github.com/cyrus-and/gdb-dashboard.git
cp gdb-dashboard.git/.gdbinit ~/

./sync.sh

cd ~/.gdb
svn checkout svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python stlPrettyPrinter
git clone https://github.com/Lekensteyn/qt5printers.git

cd ~/

.. warning:: define your own user/email in:
   ``.gitconfig``

Read installation steps from vimrc.

TODO
----

Another gdb pretty printers:
https://community.kde.org/Guidelines_and_HOWTOs/Debugging/Debugging_with_GDB
https://github.com/KDE/kdevelop/tree/master/plugins/gdb/printers

REFERENCES/SOURCES
------------------

https://github.com/amix/vimrc
https://github.com/vgod/vimrc
