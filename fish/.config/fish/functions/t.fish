function t --wraps='tmux attach 2>/dev/null || tmux new-session \\; choose-tree -s' --wraps='tmux new-session \\; choose-tree -s' --description 'alias t=tmux new-session \\; choose-tree -s'
    tmux new-session \; choose-tree -s $argv
end
