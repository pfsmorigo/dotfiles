set auto-load safe-path ~
source ~/dotfiles/gdb/.config/gdb/default.py

#set $local = "$HOME/.config/gdb/$(basename $(pwd -P))"
#python gdb.execute("shell echo source " + str(gdb.parse_and_eval("$local")) + "> /tmp/gdb")
#source /tmp/gdb
