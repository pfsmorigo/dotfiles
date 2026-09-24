function t --description "Smart tmux session manager"
    # Prevent running tmux inside an existing tmux session
    if set -q TMUX
        echo "Already inside a tmux session."
        return 1
    end

    if test (count $argv) -gt 0
        set -l session_name $argv[1]

        # Use current folder name if argument is "."
        if test "$session_name" = "."
            set session_name (path basename (pwd))
        end

        # Sanitize dots in session names (tmux treats dots as session:window separators)
        set session_name (string replace -a '.' '_' $session_name)

        # Attach to the session if it exists, otherwise create it
        tmux new-session -A -s "$session_name"
    else
        # If any tmux sessions exist, launch directly into choose-tree
        if tmux has-session 2>/dev/null
            tmux new-session -d 2>/dev/null
            tmux attach-session \; choose-tree -s
        else
            # No sessions exist; create a fresh default session
            tmux new-session
        end
    end
end
