BASH_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

sudo apt install openssh-server
sudo systemctl start ssh
sudo ufw allow ssh

mkdir -p ~/.ssh
cp -r $BASH_DIR/~/.ssh/* ~/.ssh/
