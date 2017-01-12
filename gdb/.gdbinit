set auto-load safe-path /
#add-auto-load-safe-path ~/projects/go/src/runtime/runtime-gdb.py

set $localinit = "$HOME/.config/gdb/$(basename $(pwd -P))"
python gdb.execute("shell source " + str(gdb.parse_and_eval("$localinit")))
