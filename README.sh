#!/usr/bin/bash

# $ curl -L curl -L https://raw.githubusercontent.com/philopon/.vim/master/README.sh | bash

cd ~
git clone git@github.com:philopon/.vim.git
ln -sf .vim/vimrc .vimrc
ln -sf .vim/gvimrc .gvimrc
[ ! -d .config ] && mkdir .config
cd .config
ln -sf ../.vim nvim
