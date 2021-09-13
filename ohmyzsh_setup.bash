sudo apt install curl wget git zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo sed -i 's/_THEME=\"robbyrussell\"/_THEME=\"pygmalion\"/g' ~/.zshrc && source ~/.zshrc
