#
# DEPRECATED ###################
# USE ZSHRC.zsh
#
#source /usr/bin/myfunctions.sh
#source /usr/share/doc/pkgfile/command-not-found.bash
setfont cyr-sun16
[[ $- != *i* ]] && return


nvm () {
  if hash nvm 2>/dev/null; then
   source /usr/share/nvm/init-nvm.sh
   export NVM_DIR="$HOME/.nvm"                           
   export NVM_SOURCE="/usr/share/nvm"                     # The AUR package installs it to here.
   [ -s "$NVM_SOURCE/nvm.sh" ] && . "$NVM_SOURCE/nvm.sh"  # Load NVM
  fi
  nvm "$@"
}


shopt -s checkwinsize

shopt -s histappend

match_lhs=""

[[ -f ~/.dir_colors ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs} ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)

unset math_lhs

## COLORS ##
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset


#			 if    whoami  == root	             next blue                next green    pwd      if (result = 0   then  red  '('        ) reset color 
PS1="\[\033[1;34m\]:\[\033[00m\] "
#PS1="$bldblu:$txtrst "

alias minicom="sudo minicom"
alias ls="ls --color=auto"
alias mykill="mykill"
alias dir="dir --color=auto"
alias grep="grep --color=auto"
alias dmesg='dmesg --color'
alias ssr="ssh -l root 192.168.1.1 -p 23"
alias search="sudo find / -path /run/media -prune -o -name"
alias searchi="sudo find / -path /run/media -prune -o -iname"
alias pacs="yaourt -Ss"
alias pacu="sudo pacman -Syu --noconfirm"
alias pacr="sudo pacman -Rs"
alias pac="yaourt -Sy --noconfirm"
alias cdd="changeDirectory /home/andrew/python/djangochat chat"
alias start="sudo systemctl start"
alias stop="sudo systemctl stop"
alias tabTittle="tabTittle"
alias pct="echo -ne"
alias svnu="svn log -l 100 | sed -n '/akoidan/,/-----$/ p'"
alias fuck='command="$(history -p \!\!)"; echo "Enter password for \"sudo ${command}\":"; sudo ${command}'
alias poweroff="systemctl poweroff -i"
alias dmesgl="dmesg --color=alwaus |less -R"
export SSHROUT="root@193.105.201.235 -p 23"
export LS_COLORS='di=0;35:fi=0;32:ex=0;93:tw=40;35:ow=40;35:st=40;35:ln=36:or=91'
export HISTFILESIZE="9999999"
export JETTY_HOME="/usr/share/jetty/"
export KARAF_DEBUG="true"
export JPDA_SUSPEND="y"
set -o vi

#print colored text

function prompt_command() {
  local exit_code=$?

  # Manually load z here, after $? is checked, to keep $? from being clobbered.
  _z --add "$(pwd -P 2>/dev/null)" 2>/dev/null

  # (Tons of formatting stuff removed here)
  pct  "$txtcyn`date +%T`"
	pct "$txtrst:"
  if 	[[ $(whoami) == root ]] ; then
	 pct "$txtred"
	else 
   pct "$txtgrn"
	fi
	pct "`whoami`"
	pct "$txtrst:"
	pct $txtpur`pwd`
	pct "$txtrst:"
  if [[ $exit_code != 0 ]] ; then 
   pct "$bldred"
	else 
	 pct "$bldgrn"
  fi
	echo "$exit_code"
}

mv_android() {
 find . -depth -name '* *' -execdir bash -c 'mv -vi "$1" "${1// /_}"' _ {} \;
 find . -depth -name '*@*' -execdir bash -c 'mv -vi "$1" "${1//@/}"' _ {} \;
 find . -regextype sed -regex ".*[0-9]x\..*" -execdir bash -c 'mv -vi "$1" "${1//[0-9]x/}"' _ {} \;
}


# The " || _z -- add" part is a hack to keep z from modifying $PROMPT_COMMAND,
# and will never actually be executed.
export PROMPT_COMMAND="prompt_command || _z --add"


PS2="> "
PS3="> "
PS4="+ "

# Open vim as sudo if user can't write a file
sudovim() {
	# if file doesn't exists
	if [ ! -f $1 ]; then
		#if it's a directory
		if [ -d $1 ]; then
			vim "$@"
		#file doesn't exists and it's not a dir so create a new file
		else
			dirname="$(dirname ${1})"
			# if directory if writable
			if [ -w $dirname -o $EUID == 0 ]; then
				vim "$@"
			#if directory is not writable
			else 
				sudo vim "$@" 
			fi
		fi
	# if file exists and current user is not a root
	elif [ -w $1 -o $EUID == 0 ]; then
		vim "$@"
	# if file exists and its not writable by current user
	else 
		sudo vim "$@"
	fi
}
alias vim=sudovim

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


mklinkp() {
  if [[ -z "$1" ]]; then
    echo "Moves file to ext4 part and creates link from current"
    echo "Usage: mklink fileIncurrentDir"
    return 0;
  fi
  sourceFile="`readlink -f $1`"
  parentSource="`dirname "$sourceFile"`"
  placeToLink="/run/media/andrew/ext4"
  targetDir="$placeToLink$parentSource"
  targetFile="$placeToLink$sourceFile"
# echo "targetFile: $targetFile"
# echo "targetDir: $targetDir"
# echo "parentSource: $parentSource"
# echo "sourceFile: $sourceFile"
  if [ -d "$targetFile" ] || [ -f "$targetFile" ]; then
    echo "file exists $targetDir"
    return 1;
  fi
  if [ ! -d "$sourceFile" ] && [ ! -f "$sourceFile" ]; then
    echo "file doesn't exists $sourceFile"
    return 2;
  fi
  mkdir -pv "$targetDir"
  mv -v "$sourceFile" "$targetDir"
  ln -sv "$targetFile" "$parentSource"
}
alias mklink="mklinkp"


alias sshgen=sshgen

grepfile() {
 find ${PWD} -type f -name "$1" -print0 |xargs -0 grep --color -i "$2"
}


[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
