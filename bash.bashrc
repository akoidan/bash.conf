#
# /etc/bash.bashrc
#

source /usr/bin/myfunctions.sh
setfont cyr-sun16
[[ $- != *i* ]] && return

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
alias pac="sudo yaourt -Sy --noconfirm"
alias djangochat="redis-server & node --debug /home/andrew/djangochat/node_modules/ishout.js/server.js"
alias start="sudo systemctl start"
alias stop="sudo systemctl stop"
alias tabTittle="tabTittle"
alias pct="echo -ne"
alias minicom="sudo minicom"
export EDITOR="vim"
export SSHROUT="root@193.105.201.235 -p 23"
export LS_COLORS='di=0;35:fi=0;32:ex=0;93:tw=40;35:ow=40;35:st=40;35'
export HISTFILESIZE="9999999"
export JETTY_HOME="/usr/share/jetty"
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

# The " || _z -- add" part is a hack to keep z from modifying $PROMPT_COMMAND,
# and will never actually be executed.
export PROMPT_COMMAND="prompt_command || _z --add"


PS2="> "
PS3="> "
PS4="+ "

sudovim() {
	# if user can write a file and it's not root
	if [ -w $1 -o $EUID == 0 ]; then
		vim "$@"
	else 
		read -p "Open file as root [Y/n]" -n 1 -r
		echo $REPLY
		if [[ $REPLY =~ ^[Nn]$ ]]; then 
			vim "$@"
		else
			sudo vim "$@"
    		fi
	fi
}
alias vim=sudovim

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

