source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh # yay -S zsh-autosuggestions-git
source /usr/share/fzf/key-bindings.zsh                                    # pacman -S fzf
function precmd() {
  local exit_code=$? # capture last command exit code
  txtcyn=$'\033[0;36m'
  txtred=$'\033[0;31m'
  txtgrn=$'\033[0;32m'
  txtpur=$'\033[0;35m'
  bldred=$'\033[1;31m'
  bldgrn=$'\033[1;32m'
  txtrst=$'\033[0m'

  # Optional: update _z if you use it
  _z --add "$(pwd -P 2>/dev/null)" 2>/dev/null

  # Print time
  echo -ne "$txtcyn$(date +%T)$txtrst:"

  # Print username
  if [[ $(whoami) == root ]]; then
    echo -ne "$txtred"
  else
    echo -ne "$txtgrn"
  fi
  echo -ne "$(whoami)$txtrst:"

  # Print current directory
  echo -ne "$txtpur$(pwd)"

  # Print exit code with color
  local show_dirty=$1
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  if [[ -n $branch ]]; then
    local txtylw=$'\033[0;33m'
    local underline=$'\033[4m'
    local reset=$'\033[0m'

    # Git icon
    local icon=""

    echo -ne " ${txtylw}${underline}${icon}${branch}${reset}"
  fi
  #my_git_formatter
  echo -ne "$txtrst:"
  if [[ $exit_code != 0 ]]; then
    echo -ne "$bldred$exit_code$txtrst"
  else
    echo -ne "$bldgrn$exit_code$txtrst"
  fi
  echo
  # echo -ne "$my_git_format"
}

PS1="%B%F{blue}:%f%b "
#PS2="> " # continuation prompt
#PS3="> " # select prompt for `select`
#PS4="+ " # for xtrace (set -x)

export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt APPEND_HISTORY
setopt SHARE_HISTORY

export EDITOR="nvim"
bindkey -v # set cltr+r emaks reverse search binding
export LS_COLORS='di=0;35:fi=0;32:ex=0;93:tw=40;35:ow=40;35:st=40;35:ln=36:or=91'

alias ls="ls --color=auto"
alias pacs="yay -Ss"
alias pacu="sudo pacman -Syu --noconfirm"
alias pacr="sudo pacman -Rs"
alias pac="yay -Sy --noconfirm"
alias start="sudo systemctl start"
alias stop="sudo systemctl stop"
alias poweroff="systemctl poweroff -i"
alias dmesgl="dmesg --color=alwaus |less -R"
alias vim="nvim"

nvm() {
  if ! hash nvm 2>/dev/null; then
    echo "Loading nvm script..."
    export NVM_DIR="$HOME/.nvm"
    export NVM_SOURCE="/usr/share/nvm"
    [ -s "$NVM_SOURCE/nvm.sh" ] && . "$NVM_SOURCE/nvm.sh"
  fi
  nvm "$@"
}

grepfile() {
  find ${PWD} -type f -name "$1" -print0 | xargs -0 grep --color -i "$2"
}

sshgen() {
  if [ -z "$1" ]; then
    echo "Generates rsa key on server, usage:"
    echo "sshgen andrew@192.168.1.100"
  else
    if [ ! -f ~/.ssh/id_rsa.pub ]; then
      echo "Generating rsa"
      mkdir -p ~/.ssh
      ssh-keygen -t rsa
    fi
    cat ~/.ssh/id_rsa.pub | ssh $@ "cat > /tmp/r2d2_auth_keys && mkdir -p ~/.ssh && cat /tmp/r2d2_auth_keys >> ~/.ssh/authorized_keys"
  fi
}
