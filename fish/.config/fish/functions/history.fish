function history
	#builtin history --show-time='%h/%d - %H:%M:%S ' | tac
    builtin history --show-time='%m/%d/% %T $> ' | tac | less -N +G
end
