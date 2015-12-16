#!/usr/bin/bash

# $ curl -L curl -L https://raw.githubusercontent.com/philopon/.vim/master/README.md | bash

cd ~
git clone git@github.com:philopon/.vim.git
ln -sf .vim/vimrc .vimrc
ln -sf .vim/gvimrc .gvimrc
mkdir .config
cd .config
ln -sf ../.vim nvim
