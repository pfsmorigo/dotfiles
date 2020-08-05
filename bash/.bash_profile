[ -f ~/.bashrc ] && source ~/.bashrc

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

alias m="time make -j$(\grep -c ^proc /proc/cpuinfo)"
alias s="screen_switch"
alias b="buku --np --oa -S"

alias google-chrome="google-chrome --force-device-scale-factor=1.2 --force-dark-mode"

export PROMPT_DIRTRIM=2
export GDK_USE_XFT=1
export QT_XFT=true
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dsun.java2d.xrender=true"

export EDITOR="/usr/bin/vim"
export TERMINAL="$HOME/.local/bin/smowterm"
export BROWSER="$HOME/.local/bin/openurl"

export GPG_TTY=$(tty)

export HISTSIZE=32768 # Larger bash history (allow 32³ entries)
export HISTFILESIZE=$HISTSIZE
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoredups:erasedups

export PASSWORD_STORE_CHARACTER_SET="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,.\+\-()@:;*"
export PASSWORD_STORE_GENERATED_LENGTH="10"

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

export PATH=~/.local/bin:$PATH

# XDG Support
if [ -e "$HOME/.config/user-dirs.dirs" ]; then
	source "$HOME/.config/user-dirs.dirs"
	[[ ! -e "$XDG_CONFIG_HOME" ]] && break

	#alias abook="abook --config $XDG_CONFIG_HOME/abook/abookrc --datafile $XDG_CONFIG_HOME/abook/addressbook"
	export GIMP2_DIRECTORY="$XDG_DATA_HOME/gimp"
	export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
	export GRAMPSHOME="$XDG_CONFIG_HOME"
	export ICEAUTHORITY="$XDG_RUNTIME_DIR/x11/ICEauthority"
	export LESSHISTFILE="$XDG_CACHE_HOME/less"
	export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
	export RXVT_SOCKET="$XDG_RUNTIME_DIR/urxvt-$(hostname)"
	export SCREENRC="$XDG_CONFIG_HOME/screenrc"
	export TASKRC="$XDG_CONFIG_HOME/task"
	export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
	export WINEPREFIX="$XDG_DATA_HOME/wine"
	export XAUTHORITY="$XDG_RUNTIME_DIR/x11/Xauthority"
	export XCOMPOSEFILE="$XDG_CONFIG_HOME/x11/XCompose"
	export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
	export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible.cfg"
fi

# If there is a X server running
xset q &> /dev/null && test -f /usr/bin/xrdb && xrdb ~/.Xresources

. shelltags -tesglfmb
