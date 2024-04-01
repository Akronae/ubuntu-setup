git config --global user.name "Alexandre Daubricourt"
git config --global user.email "alexandre@daubricourt.com"
git config --global alias.cleanbr "! git branch -d \`git branch --merged | grep -v '^*\\|main\\|master\\|staging\\|devel'\`"
git config --global init.defaultBranch main
