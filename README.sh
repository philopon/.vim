#!/usr/bin/env bash

# curl -L https://raw.githubusercontent.com/philopon/.vim/master/README.sh | bash

set -e

cd $HOME
[ ! -d .vim ] && git clone git@github.com:philopon/.vim.git
ln -sf .vim/vimrc .vimrc
ln -sf .vim/gvimrc .gvimrc
[ ! -d .config ] && mkdir .config
cd $HOME/.config
[ ! -d nvim ] && ln -sf ../.vim nvim
