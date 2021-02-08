function history
    #builtin history --show-time='%Y-%m-%d %T $> ' | tac
    builtin history --show-time='%Y-%m-%d %T $> ' | tac | less -N +G
end
