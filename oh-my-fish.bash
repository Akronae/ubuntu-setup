sudo apt-get update
sudo apt-get install fish

sudo apt-get update
sudo apt-get install curl
curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install > install
fish install

chsh -s /usr/bin/fish

cp -r ./~/.config/fish ~/.config

curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install jorgebucaran/autopair.fish
