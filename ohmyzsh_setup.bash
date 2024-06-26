sudo apt-get update

sudo apt install curl wget git zsh bat -y
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "$(echo $'zstyle \':omz:update\' mode auto' | cat - ~/.zshrc)" > ~/.zshrc
echo "$(echo $'zstyle \':omz:alpha:lib:git\' async-prompt no' | cat - ~/.zshrc)" > ~/.zshrc
echo "$(echo $'del () { mv "$@" /tmp; }' | cat - ~/.zshrc)" > ~/.zshrc
echo "$(echo $'alias cat="batcat --paging=never --style=plain"' | cat - ~/.zshrc)" > ~/.zshrc
echo "$(echo $'export PATH=$HOME/bin:$PATH' | cat - ~/.zshrc)" > ~/.zshrc
echo "$(echo $'export PATH=$HOME/.local/bin:$PATH' | cat - ~/.zshrc)" > ~/.zshrc
echo "$(echo $'export PATH=/usr/local/bin:$PATH' | cat - ~/.zshrc)" > ~/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/hlissner/zsh-autopair ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autopair

/bin/zsh -c "
export ZSH=${ZSH:-/$USER/.oh-my-zsh}
. ${ZSH:-/$USER/.oh-my-zsh}/lib/cli.zsh
omz theme set pygmalion
omz plugin enable zsh-autosuggestions
omz plugin enable zsh-autopair
zsh
"
