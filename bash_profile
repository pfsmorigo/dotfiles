# .bash_profile

[[ -f ~/.bashrc ]] && . ~/.bashrc

PATH=$PATH:$HOME/.local/bin:$HOME/bin:$HOME/IBM/bin:$HOME/code/scripts:$HOME/code/pfsmorigo-scripts
export PATH

export GDK_USE_XFT=1
export QT_XFT=true
export BROWSER="/usr/bin/browser"
export EDITOR="/usr/bin/vim"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=erasedups
export HISTSIZE=10000
export HISTFILESIZE=10000

