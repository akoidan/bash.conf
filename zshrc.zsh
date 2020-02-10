
# My bash

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
bakylw='\e[43m'   # Yellow bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

PS1='%F{blue}:%f '
PS2="> "
PS3="> "
PS4="+ "

precmd() {
  local exit_code=$?

  # Manually load z here, after $? is checked, to keep $? from being clobbered.
  _z --add "$(pwd -P 2>/dev/null)" 2>/dev/null

  # (Tons of formatting stuff removed here)
  echo -ne "$txtcyn`date +%T`"
	echo -ne "$txtrst:"
  if 	[[ $(whoami) == root ]] ; then
	 echo -ne "$txtred"
	else 
   echo -ne "$txtgrn"
	fi
	echo -ne "`whoami`$txtrst:$txtpur`pwd`$txtrst:"
  if [[ $exit_code != 0 ]] ; then 
   echo -ne "$bldred"
	else 
	 echo -ne "$bldgrn"
  fi
	echo "$exit_code"
}


HISTFILE=/Users/deathangel908/.zhistory
HISTSIZE=10000
SAVEHIST=10000
disable log
setopt incappendhistory

set -o vi

bindkey "\C-a" beginning-of-line
bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PATH="/usr/local/opt/openvpn/sbin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export LDFLAGS="-L/usr/local/opt/icu4c/lib"
export LC_ALL=en_US.UTF-8
export CPPFLAGS="-I/usr/local/opt/icu4c/include"
export EDITOR=vim
export HSTR_CONFIG=hicolor       # get more colors
export PATH="/usr/local/opt/krb5/bin:$PATH"
export PATH="/usr/local/opt/krb5/sbin:$PATH"
export LDFLAGS="-L/usr/local/opt/krb5/lib"
export CPPFLAGS="-I/usr/local/opt/krb5/include"
export NVM_DIR="$HOME/.nvm"

alias mc="PAGER=open /usr/local/bin/mc"
source ~/.zshrc.local
