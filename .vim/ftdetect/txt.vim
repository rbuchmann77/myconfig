au BufRead,BufNewFile CMakeLists.txt set filetype=cmake
au BufRead,BufNewFile *.txt if &ft!="cmake"|set filetype=asciidoc|endif
