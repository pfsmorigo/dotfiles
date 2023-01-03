# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
HISTTIMEFORMAT='%F %T '

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gd="git diff"
alias gl="git log"
alias gll="git log2"
alias gs="git status"
alias gss="git status --short"

alias qd="quilt diff"
alias qr="quilt refresh"
alias qs="quilt series"
alias qi="quilt import"

alias dp="docker ps --format '{{ .Names }}|{{.Status}}|{{ .Ports }}' --all | column -t -s'|'"

alias m="time make -j$(\grep -c ^proc /proc/cpuinfo)"
alias s="screen_switch"
alias b="buku --np --oa -S"

alias google-chrome="google-chrome --force-device-scale-factor=1.2 --force-dark-mode"
alias abook="abook --config $HOME/.config/abook/abookrc --datafile $HOME/.config/abook/addressbook"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

echo $PATH | grep -q $HOME/.local/bin || export PATH=~/.local/bin:$PATH

export PROMPT_DIRTRIM=2
export GDK_USE_XFT=1
export QT_XFT=true
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dsun.java2d.xrender=true"

export EDITOR="/usr/bin/vim"
export TERMINAL="$HOME/.local/bin/smowterm"
export BROWSER="$HOME/.local/bin/openurl"

export GPG_TTY=$(tty)

export PASSWORD_STORE_CHARACTER_SET="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,.\+\-@:;"
export PASSWORD_STORE_GENERATED_LENGTH="20"

export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

export GIMP2_DIRECTORY="$HOME/.local/share/gimp"
export GNUPGHOME="$HOME/.config/gnupg"
export GRAMPSHOME="$HOME/.config"
export LESSHISTFILE="$HOME/.cache/less"
export MPLAYER_HOME="$HOME/.config/mplayer"
export SCREENRC="$HOME/.config/screenrc"
export WEECHAT_HOME="$HOME/.config/weechat"
export WINEPREFIX="$HOME/.local/share/wine"
export ANSIBLE_CONFIG="$HOME/.config/ansible.cfg"
export PASSWORD_STORE_DIR="$HOME/.config/password-store"

# If there is a X server running
xset q &> /dev/null && test -f /usr/bin/xrdb && xrdb ~/.Xresources

# use an existing environment if it is running, otherwise start a new agent
SSH_ENV="$HOME/.ssh/environment"

ssh_start_agent() {
    echo ""
    echo -n "Initialising new SSH agent... "
    ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
    echo "done"
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
}

if [ -f "$SSH_ENV" ]; then
    . "$SSH_ENV" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        ssh_start_agent
    }
else
    ssh_start_agent
fi

# Check if the default key was already added to the agent
if ! ssh-add -l | grep -q $(ssh-keygen -lf ~/.ssh/id_ed25519.pub | cut -d' ' -f2); then
	echo "Please add your default key to the agent."
	ssh-add
fi

# Save aliases in .bash_aliases so fish can import it later
alias > ~/.bash_aliases

test -f ~/.bash_ubuntusec && . ~/.bash_ubuntusec
