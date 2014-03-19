#echo "FYI, this was a login shell."
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi

if [ -f ~/system/git/git-completion.bash ]; then
  . ~/system/git/git-completion.bash 
fi

##
# Your previous /Users/latzer/.bash_profile file was backed up as /Users/latzer/.bash_profile.macports-saved_2012-04-23_at_13:12:23
##

# MacPorts Installer addition on 2012-04-23_at_13:12:23: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
