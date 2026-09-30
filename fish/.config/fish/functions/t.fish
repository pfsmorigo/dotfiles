function __t_connect -a group_name
    # Use current folder name if argument is "."
    if test "$group_name" = "."
        set group_name (path basename (pwd))
    end

    # Sanitize dots in names (tmux treats dots as session:window separators)
    set group_name (string replace -a '.' '_' -- $group_name)

    # Check if a session or group with this name already exists
    if tmux has-session -t "$group_name" 2>/dev/null
        # Count total attached clients across this session/group
        set -l attached_count 0
        for line in (tmux list-sessions -F '#{?session_grouped,#{session_group},#S} #{session_attached}' 2>/dev/null)
            set -l parts (string split ' ' -- $line)
            if test "$parts[1]" = "$group_name"
                set attached_count (math $attached_count + $parts[2])
            end
        end

        if test "$attached_count" -gt 0
            # Spawn a grouped session with a unique ID so terminals share windows but have independent views
            set -l client_id (random)
            tmux new-session -t "$group_name" -s "$group_name-$client_id" \; set-option destroy-unattached on
        else
            # No other client attached: attach directly to the existing session/group
            tmux attach-session -t "$group_name"
        end
    else
        # Create a fresh anchor session with the group name
        tmux new-session -s "$group_name"
    end
end

function t --description "Smart tmux session group manager"
    # Prevent running tmux inside an existing tmux session
    if set -q TMUX
        echo "Already inside a tmux session."
        return 1
    end

    if test (count $argv) -gt 0
        __t_connect $argv[1]
    else
        # If no sessions exist, create a fresh session group for the current folder
        if not tmux has-session 2>/dev/null
            __t_connect .
            return
        end

        # Get active session groups sorted by last activity (most recent first)
        set -l groups
        set -l attached_counts

        for line in (tmux list-sessions -F '#{session_activity} #{?session_grouped,#{session_group},#S} #{session_attached}' 2>/dev/null | sort -nr)
            set -l parts (string split ' ' -- $line)
            set -l g $parts[2]
            set -l att $parts[3]

            set -l idx (contains -i -- $g $groups)
            if test -n "$idx"
                set attached_counts[$idx] (math $attached_counts[$idx] + $att)
            else
                set -a groups $g
                set -a attached_counts $att
            end
        end

        set -l count (count $groups)

        echo "Active tmux session groups:"
        for i in (seq $count)
            set -l g $groups[$i]
            set -l att $attached_counts[$i]
            if test "$att" -gt 1
                echo "  $i) $g ($att attached)"
            else if test "$att" -eq 1
                echo "  $i) $g (attached)"
            else
                echo "  $i) $g"
            end
        end
        echo ""

        set -l current_dir (string replace -a '.' '_' -- (path basename (pwd)))
        read -P "Select group [1-$count], new name, or Enter for [$current_dir]: " choice
        set choice (string trim -- "$choice")

        # 1. Enter pressed without input: join or create session group for current directory
        if test -z "$choice"
            __t_connect $current_dir

        # 2. Picked a number from the list
        else if string match -qr '^[0-9]+$' -- "$choice"; and test "$choice" -ge 1 -a "$choice" -le $count
            __t_connect $groups[$choice]

        # 3. Typed text: create a new session group (or join if already existing)
        else
            __t_connect $choice
        end
    end
end
