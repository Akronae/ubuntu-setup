sudo apt-get update

sudo apt install curl wget git zsh bat fzf -y
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "$(echo $'zstyle \':omz:update\' mode auto' | cat - ~/.zshrc)" > ~/.zshrc
echo "$(echo $'del () { mv "$@" /tmp; }' | cat - ~/.zshrc)" > ~/.zshrc
echo "$(echo $'alias cat="batcat --paging=never --style=plain"' | cat - ~/.zshrc)" > ~/.zshrc
echo "$(echo $'export PATH=$HOME/bin:$PATH' | cat - ~/.zshrc)" > ~/.zshrc
echo "$(echo $'export PATH=$HOME/.local/bin:$PATH' | cat - ~/.zshrc)" > ~/.zshrc
echo "$(echo $'export PATH=/usr/local/bin:$PATH' | cat - ~/.zshrc)" > ~/.zshrc
print -r -- 'history_clear() {
  if [[ -z "$1" ]]; then
    echo "Usage: remove_history_prefix <prefix>"
    return 1
  fi

  local prefix="$1"
  local history_file="${HISTFILE:-$HOME/.zsh_history}"

  # Remove matching lines from the history file
  sed -i "/^: .*;$prefix/d" "$history_file"

  # Reload history
  fc -R "$history_file"
  echo "Entries starting with '\''$prefix'\'' removed from history."
}

' > ~/.zshrc.tmp && cat ~/.zshrc >> ~/.zshrc.tmp && mv ~/.zshrc.tmp ~/.zshrc

cat << 'EOF' >> ~/.zshrc

function del() {
  local TRASH_DIR="$HOME/.trash"
  mkdir -p "$TRASH_DIR"

  # Helper: timestamp for uniqueness
  timestamp() {
    date +%s%N
  }

  # del -- list
  if [[ "$1" == "--" && "$2" == "list" ]]; then
    echo "Trashed files:"
    for meta in "$TRASH_DIR"/*.meta; do
     [[ -e "$meta" ]] || { echo "(trash empty)"; return 0; }
     local file="${meta%.meta}"
      local original_path
      original_path=$(cat "$meta")
      local base_trash_file=$(basename "$file")

      local timestamp_part="${base_trash_file##*_}"

      local timestamp_sec=$((timestamp_part / 1000000000))

      local deleted_time
      deleted_time=$(date -d @"$timestamp_sec" +"%Y-%m-%d %H:%M:%S")

      echo "$base_trash_file -> $original_path (deleted at: $deleted_time)"
    done
   return
  fi


  # del -- restore
  if [[ "$1" == "--" && "$2" == "restore" ]]; then
    shift 2
    if [[ $# -eq 0 ]]; then
      echo "Select a file to restore:"
      select file in "$TRASH_DIR"/*; do
        [[ -n "$file" ]] || { echo "Invalid selection."; return 1; }
        filename=$(basename "$file")
        # Restore to original location stored in metadata
        local meta="$file.meta"
        if [[ -f "$meta" ]]; then
          original_path=$(cat "$meta")
          mv -i "$file" "$original_path"
          rm -f "$meta"
          echo "Restored '$filename' to '$original_path'"
        else
          echo "No metadata found for '$filename'. Cannot restore."
        fi
        break
      done
    else
      for filename in "$@"; do
        local file_path="$TRASH_DIR/$filename"
        if [[ -f "$file_path" ]]; then
          local meta="$file_path.meta"
          if [[ -f "$meta" ]]; then
            original_path=$(cat "$meta")
            mv -i "$file_path" "$original_path"
            rm -f "$meta"
            echo "Restored '$filename' to '$original_path'"
          else
            echo "No metadata for '$filename'. Cannot restore."
          fi
        else
          echo "File '$filename' not found in trash."
        fi
      done
    fi
    return
  fi

  # del -- cat
  if [[ "$1" == "--" && "$2" == "cat" ]]; then
    shift 2
    if [[ $# -eq 0 ]]; then
      echo "Usage: del -- cat <filename>"
      return 1
    fi
    for filename in "$@"; do
      local file_path="$TRASH_DIR/$filename"
      if [[ -f "$file_path" ]]; then
        cat "$file_path"
      else
        echo "File '$filename' not found in trash."
      fi
    done
    return
  fi

  # Otherwise, behave like rm but move files to trash
  if [[ $# -eq 0 ]]; then
    echo "Usage: del <files...> or del -- list|restore|cat"
    return 1
  fi

  # Move each argument to trash
  for file in "$@"; do
    if [[ ! -e "$file" ]]; then
      echo "del: cannot remove '$file': No such file or directory"
      continue
    fi

    # Save original absolute path in a metadata file
    local abs_path="$(realpath "$file")"
    local base_name="$(basename "$file")"
    local uniq_name="${base_name}_$(timestamp)"

    mv "$file" "$TRASH_DIR/$uniq_name"
    echo "$abs_path" > "$TRASH_DIR/$uniq_name.meta"
  done
}
EOF


git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/hlissner/zsh-autopair ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autopair
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab 

/bin/zsh -c "
export ZSH=${ZSH:-/$USER/.oh-my-zsh}
. ${ZSH:-/$USER/.oh-my-zsh}/lib/cli.zsh
omz theme set pygmalion
omz plugin enable zsh-autosuggestions
omz plugin enable zsh-autopair
omz plugin enable zsh-syntax-highlighting
omz plugin enable fzf-tab
zsh
"
