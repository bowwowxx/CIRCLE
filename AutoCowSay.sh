#!/bin/bash

OS=$(uname -a | awk '{print $1}')

case $OS in
    Linux) COWSFOLDER=/usr/share/cowsay/cows;sudo apt-get install -y cowsay fortune;;
    Darwin) COWSFOLDER=/usr/local/Cellar/cowsay/3.03/share/cows;sudo brew install cowsay fortune;sduo gem install lolcat;;
    *) echo "Your device is not supported yet."; exit 0;;
esac

sudo wget --output-document=$COWSFOLDER/totoro.cow https://gist.githubusercontent.com/goodjob1114/d99eb052d6356ab06a5b/raw/74433a057277dcb1c3f0840e4f46edc37315d6f0/totoro.cow
sudo wget --output-document=$COWSFOLDER/totoro-fat.cow https://gist.githubusercontent.com/goodjob1114/2530450e4e8b9abfc7d1/raw/18e2f1e5ebe4c37895399048eed0709314370f10/totoro-fat.cow

git log -1 | cowsay -f dragon-and-cow | lolcat
