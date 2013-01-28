[ -z "$PS1" ] && return

#tab color for iterm2
function tabColor {
echo -en "\033]6;1;bg;red;brightness;$1\a" 
echo -en "\033]6;1;bg;green;brightness;$2\a"
echo -en "\033]6;1;bg;blue;brightness;$3\a"
}

COLOR="1;37m" #white
ROOTCOLOR="31m" #red

#Local thingies
BASHRC_DIR=`dirname ${BASH_SOURCE[0]}`
BASH_LOCAL=$BASHRC_DIR/.bash_local
if [ -f $BASH_LOCAL ]; then
  . $BASH_LOCAL
fi

#root stuff
if [ `id -u` -eq 0 ]; then
  COLOR=$ROOTCOLOR
  VIMRC=$BASHRC_DIR/.vimrc
  export VIMINIT="so $VIMRC"
fi

MYVIMRC=$BASHRC_DIR/.vimrc

# Function to assemble the Git parsingart of our prompt.
git_prompt () {
  c_git_clean='\[\033[32m\]'
  c_git_dirty='\[\033[31m\]'
  c_git_undecided='\[\033[33m\]'
  c_reset='\[\033[0m\]'
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi


  git_branch=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')

  if [[ -z $STFU ]]; then #TODO find a better name for this variable
    if git diff --quiet 2>/dev/null >&2; then
      git_color="$c_git_clean"
    else
      git_color="$c_git_dirty"
    fi
  else 
    git_color="$c_git_undecided"
  fi


  echo " [$git_color$git_branch${c_reset}]"
}

export PS1="\[\033[$COLOR\][\A]\${?#0}\u@\h\[\033[0m\]:\[\033[$COLOR\]\w\\[\033[0m\]\$ "
which git > /dev/null 2>&1
if [ $? -eq 0 ] ; then
  export PROMPT_COMMAND='PS1="\[\033[$COLOR\][\A]\${?#0}\u@\h\[\033[0m\]:\[\033[$COLOR\]\w\[\033[0m\]`git_prompt`\[\033[0m\]\$\[\033[0m\] "'
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

#Aliases
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi
if [ `uname` = "Darwin" ]; then #mac stuff
  alias ll="ls -lAhF"
  alias l="ls -lhF"
  alias ls="ls -F"
elif [ `uname` = "Linux" ]; then
  alias ll="ls -lAh"
  alias l="ls -lh"
  alias ls="ls --color=auto"
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
fi

#laziness
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias rc="vi ~/.bashrc"
alias clock="while true; do clear; date; sleep 1; done;"
alias grep="grep --color=auto"
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias td='thing=$RANDOM; mkdir /tmp/`whoami`$thing; cd /tmp/`whoami`$thing'
alias rot13="tr a-zA-Z n-za-mN-ZA-M"
alias mysql="mysql --auto-rehash"

#typos
alias shh=ssh
alias abd=adb


function cdl { cd "$1" && l ; }
function md { mkdir "$1" && cd "$1" ; }

#suffixes $1 with .$2
function suf { 
  if [ "$2-n" = "-n" ] 
  then 
    echo "2 args plox" 
    return 1 
  fi  
  mv $1 $1.$2
  return 0
}

#removes the file suffix
function fus {
  filename=`basename "$1"`
  filename="${filename%.*}"
  mv $1 $filename
}

#fuzzy cd
function cdf {
  cd *"$1"*/
}

#VI-Mode
set -o vi
export EDITOR='vim'

#do not clear on exiting less (and possibly other funny side effects....)
export PAGER='less -X'

#SVN environmentals
export SVN_EDITOR="/usr/bin/vim"


#histopts
shopt -s cdspell dotglob histappend
export HISTFILESIZE=20000
export HISTCONTROL=ignoredups
export HISTIGNORE=" *"
#PROMPT_COMMAND="history -n; history -a"

#Shell colors
export CLICOLOR=1

if [[ -f ~/.firstTimeHere ]]; then
  which view 2> /dev/null
  vimret=$?
  if [[ -f .bash_local && vimret -eq 0 ]]; then
    view -p .bash_local.dist .bash_local
  else
    vi .bash_local.dist; 
  fi
  rm .firstTimeHere .bash_local.dist;
fi
