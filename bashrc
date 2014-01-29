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


case "$TERM" in
xterm*|rxvt*|screen-256*)
  #fancy prompt
	if [ -z "$leaveMyPromptAlone" ]; then
		PS1="\[\033[$COLOR\][\A]\${?#0}\u@\h\[\033[0m\]:\[\033[$COLOR\]\w\\[\033[0m\]\$ "

		if [ -z "$disableGitPrompt" ]; then
			#if we have git, use the fancy prompt with git info
			which git > /dev/null 2>&1
			if [ $? -eq 0 ] ; then
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

					if [[ -z $disableGitDiff ]]; then 
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
				PROMPT_COMMAND='PS1="\[\033[$COLOR\][\A]\${?#0}\u@\h\[\033[0m\]:\[\033[$COLOR\]\w\[\033[0m\]`git_prompt`\[\033[0m\]\$\[\033[0m\] "'
			fi
		fi
	fi

  # Show the currently running command in the terminal title:
  # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
  show_command_in_title_bar() {
		case "$BASH_COMMAND" in
			PS1*)
				# this is my prompt_command; skip it
				;;
			*\033]0*)
				# The command is trying to set the title bar as well;
				# this is most likely the execution of $PROMPT_COMMAND.
				# In any case nested escapes confuse the terminal, so don't
				# output them.
				;;
			*)
				echo -ne "\033]0;${USER}@${HOSTNAME}: ${BASH_COMMAND}\007"
				;;
		esac
  }
  trap show_command_in_title_bar DEBUG
	;;
*)
  PS1="\h \$ "
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
alias td='rnd=$RANDOM; mkdir /tmp/`whoami`$rnd; cd /tmp/`whoami`$rnd'
alias rot13="tr a-zA-Z n-za-mN-ZA-M"
alias mysql="mysql --auto-rehash"
alias breakparams="sed 's/\s-/\n&/g'"

#typos
alias shh=ssh
alias abd=adb
alias gut=git
alias gitt=git


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

if [[ -d ~/bin/ ]]; then
  PATH="$PATH":~/bin
fi

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
true
