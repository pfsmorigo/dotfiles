# ==============================================================================
# GLOBAL / NON-INTERACTIVE SETTINGS
# Runs for both interactive terminals and background scripts/subshells
# ==============================================================================

# Update PATH
fish_add_path ~/.local/bin
fish_add_path /usr/local/go/bin

# Environment Variables
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PAGER less

# XDG Adjustments
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx ANSIBLE_CONFIG "$HOME/.config/ansible.cfg"
set -gx GNUPGHOME "$HOME/.config/gnupg"
set -gx PASSWORD_STORE_DIR "$HOME/.config/password-store"
set -gx SCREENRC "$HOME/.config/screenrc"

#export GIMP2_DIRECTORY="$HOME/.local/share/gimp"
#export GRAMPSHOME="$HOME/.config"
#export LESSHISTFILE="$HOME/.cache/less"
#export MPLAYER_HOME="$HOME/.config/mplayer"
#export WEECHAT_HOME="$HOME/.config/weechat"
#export WINEPREFIX="$HOME/.local/share/wine"
#export NOTMUCH_CONFIG="$HOME/.config/notmuch/default"

# Init tools that modify PATH/env
#if command -v zoxide >/dev/null
#    zoxide init fish | source
#end


# ==============================================================================
# INTERACTIVE-ONLY SETTINGS
# Runs only when opening a real terminal session
# ==============================================================================
if status is-interactive
	# Disable default greeting
	set -g fish_greeting ""

	# Vi keybindings
	#fish_vi_key_bindings

	# Abbreviations
	abbr -a g git
	abbr -a gs "git status"
	abbr -a l "ls -lh"

	set -g theme_date_timezone America/Sao_Paulo
	set -g theme_date_format "+%H:%M:%S"
	set -g theme_show_exit_status yes
	set -g theme_title_use_abbreviated_path yes
	set -g theme_nerd_fonts yes
	set -g theme_color_scheme dark
	set -g theme_display_cmd_duration yes
	set -g theme_display_git yes
	set -g theme_display_git_ahead_verbose yes
	set -g theme_display_git_dirty_verbose yes
	set -g theme_display_hostname yes
	set -g theme_display_jobs_verbose yes
	set -g theme_display_screen yes
	set -g theme_display_screen_verbose yes
	set -g theme_display_tmux yes

	# Tells GPG which terminal to use for passphrase prompts
	set -gx GPG_TTY (tty)
end
