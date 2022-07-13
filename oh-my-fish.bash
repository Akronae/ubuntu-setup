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

set -L
set -U fish_color_normal normal
set -U fish_color_command 0772A1
set -U fish_color_quote 024A68
set -U fish_color_redirection 63AFD0
set -U fish_color_end 8D003B
set -U fish_color_error EC3B86
set -U fish_color_param 225E79
set -U fish_color_comment FFE100
set -U fish_color_match --background=brblue
set -U fish_color_selection white --bold --background=brblack
set -U fish_color_search_match bryellow --background=brblack
set -U fish_color_history_current --bold
set -U fish_color_operator 00a6b2
set -U fish_color_escape 00a6b2
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_valid_path --underline
set -U fish_color_autosuggestion 3BA3D0
set -U fish_color_user brgreen
set -U fish_color_host normal
set -U fish_color_cancel -r
set -U fish_pager_color_prefix normal --bold --underline
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D yellow
set -U fish_pager_color_progress brwhite --background=cyan
