function __t_connect -a session_name
    # Use current folder name if argument is "."
    if test "$session_name" = "."
        set session_name (path basename (pwd))
    end

    # Sanitize dots in session names (tmux treats dots as session:window separators)
    set session_name (string replace -a '.' '_' -- $session_name)

    # If session exists, join it (grouped if already attached, direct if detached)
    if tmux has-session -t "$session_name" 2>/dev/null
        set -l is_attached (tmux display-message -p -t "$session_name" '#{session_attached}' 2>/dev/null)
        if test "$is_attached" -gt 0
            # Spawn a grouped session so both terminals maintain independent window views
            tmux new-session -t "$session_name" \; set-option destroy-unattached on
        else
            tmux attach-session -t "$session_name"
        end
    else
        # Create a fresh session with the name
        tmux new-session -s "$session_name"
    end
end

function t --description "Smart tmux session manager"
    # Prevent running tmux inside an existing tmux session
    if set -q TMUX
        echo "Already inside a tmux session."
        return 1
    end

    if test (count $argv) -gt 0
        __t_connect $argv[1]
    else
        # If no sessions exist, create a fresh session for the current folder
        if not tmux has-session 2>/dev/null
            __t_connect .
            return
        end

        # Get active sessions sorted by last activity (most recent first)
        set -l sessions (tmux list-sessions -F '#{session_activity} #S' 2>/dev/null | sort -nr | string replace -r '^\d+\s+' '')
        set -l count (count $sessions)

        echo "Active tmux sessions:"
        for i in (seq $count)
            set -l s $sessions[$i]
            set -l att (tmux display-message -p -t "$s" '#{session_attached}' 2>/dev/null)
            if test "$att" -gt 0
                echo "  $i) $s (attached)"
            else
                echo "  $i) $s"
            end
        end
        echo ""

        set -l current_dir (string replace -a '.' '_' -- (path basename (pwd)))
        read -P "Select session [1-$count], new name, or Enter for [$current_dir]: " choice
        set choice (string trim -- "$choice")

        # 1. Enter pressed without input: join or create session for current directory
        if test -z "$choice"
            __t_connect $current_dir

        # 2. Picked a number from the list
        else if string match -qr '^[0-9]+$' -- "$choice"; and test "$choice" -ge 1 -a "$choice" -le $count
            __t_connect $sessions[$choice]

        # 3. Typed text: create a new session (or join if already existing)
        else
            __t_connect $choice
        end
    end
end
