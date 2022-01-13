COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

#color for git status in ps1
function git_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ ! $git_status =~ "working directory clean" ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_OCHRE
  fi
}

#function for git status in ps1
function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "($branch)"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "($commit)"
  fi
}

#custom ps1 outside of git
PS1="\[\e[31m\]\u\[\e[m\]\[\e[31m\]@\[\e[m\]\[\e[31m\]\h\[\e[m\] \[\e[32m\][\[\e[m\]\[\e[32m\]\w\[\e[m\]\[\e[32m\]]\[\e[m\]"
#git status in ps1
PS1+="\[\$(git_color)\]"        # colors git status
PS1+="\$(git_branch)"           # prints current branch
PS1+="\[$COLOR_RED\]\$\[$COLOR_RESET\] "   # '#' for root, else '$'
export PS1

export PATH="$PATH:~/scripts/.:/fjord/bin/:~/Python"

alias vpnstart="f5fpc --start --host https://vpn.mtu.edu --user pbburke -x"
alias vpnstop="f5fpc --stop"
alias vpninfo="f5fpc --info"
alias sshhome="ssh -p 50022 slipperysalmon.duckdns.org"

alias homemount="sshfs -p 50022 pbburke@slipperysalmon.duckdns.org:/mnt /mnt/abjecttestament/"

export HISTTIMEFORMAT="%F %T: "

PATH="/home/campus21/pbburke/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/campus21/pbburke/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/campus21/pbburke/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/campus21/pbburke/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/campus21/pbburke/perl5"; export PERL_MM_OPT;

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# this is for puppet development
#export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
# Load RVM into a shell session *as a function*

alias sshnokey="ssh -o PasswordAuthentication=yes -o PreferredAuthentications=keyboard-interactive,password -o PubkeyAuthentication=no"
alias prettymount="mount | awk '{ printf  \"%-40s %s %-40s %s %-15s %s\\n\", \$1, \$2, \$3, \$4, \$5, \$6 }'"
