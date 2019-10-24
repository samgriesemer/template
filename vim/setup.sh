# move .vimrc
cp .vimrc ~/

# install solarized
mkdir -p ~/.vim/colors/
cp solarized.vim ~/.vim/colors/

# install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install vundle plugins
vim +PluginInstall +qall

# add Gilles snippets
cp tex.snippets ~/.vim/bundle/vim-snippets/UltiSnips/
