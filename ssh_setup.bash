BASH_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

mkdir -p ~/.ssh
cp -r $BASH_DIR/~/.ssh/* ~/.ssh/
