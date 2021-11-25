sudo apt install curl wget git zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo sed -i 's/_THEME=\"robbyrussell\"/_THEME=\"pygmalion\"/g' ~/.zshrc && source ~/.zshrc
sudo chsh -s $(which zsh) $(whoami)
sudo sed -i 's/_THEME=\"robbyrussell\"/_THEME=\"pygmalion\"/g' ~/.zshrc && source ~/.zshrc
sudo su - $USER
sudo sed -i .bak 's/_THEME=\"robbyrussell\"/_THEME=\"pygmalion\"/g' ~/.zshrc && source ~/.zshrc
sudo su - $USER
