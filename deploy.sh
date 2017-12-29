#!/bin/bash

VHOME=/opt/local
HNCURSES=$VHOME/ncurses
HVIM=$VHOME/vim
HCONF=$VHOME/dconf

tar xvzf ncurses-5.8.tar.gz
cd ncurses-5.8

./configure --prefix=$HNCURSES
make
make install
cd ..

tar xvjf vim-7.4.tar.bz2
cd vim74
export LDFLAGS="-L$HNCURSES/lib"
./configure --enable-gui=no --without-x -with-features=huge --prefix=$HVIM --with-tlib=ncurses
make
make install
cp $HVIM/bin/vim $HVIM/bin/dvim
cd ..

cp -rf dconf $VHOME
cd $HCONF
sh install_vundle.sh

echo "set nocompatible" >> vimrc.new
echo "set rtp+=$HCONF/bundle/vundle/" >> vimrc.new
echo "call vundle#rc(\"$HCONF/bundle/vundle\")" >> vimrc.new
cat vimrc >> vimrc.new
mv vimrc.new vimrc


echo "export VIM_DIR=$HVIM" >> ~/.limrc
echo "export VIMRUNTIME=\$VIM_DIR/share/vim/vim74" >> ~/.limrc
echo "export EDITOR=dvim" >> ~/.limrc
echo "export PATH=\$VIM_DIR/bin:\$PATH" >> ~/.limrc
echo "alias lim='dvim -u $HCONF/vimrc'" >> ~/.limrc

