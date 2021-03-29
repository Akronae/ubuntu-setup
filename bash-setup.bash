BASH_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cp $BASH_DIR/~/.bash_aliases ~/.bash_aliases
cp $BASH_DIR/~/.bashrc ~/.bashrc

. ~/.bashrc
