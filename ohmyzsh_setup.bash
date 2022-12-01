sudo apt install curl wget git zsh bat
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "$(echo $'zstyle \':omz:update\' mode auto' | cat - ~/.zshrc)" > ~/.zshrc
echo "$(echo $'del () { mv "$@" /tmp; }' | cat - ~/.zshrc)" > ~/.zshrc
echo "$(echo $'alias cat="batcat --paging=never --style=plain"' | cat - ~/.zshrc)" > ~/.zshrc
echo "$(echo $'export PATH=$HOME/bin:/usr/local/bin:$PATH' | cat - ~/.zshrc)" > ~/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
/bin/zsh -i -c "\
omz theme set pygmalion &&\
omz plugin enable nvm &&\
omz plugin enable zsh-autosuggestions"
