# .bashrc

for FILE in bashrc bash.bashrc bash_completion; do
	[ -f /etc/$FILE ] && . /etc/$FILE
done

[ -n "$PS1" ] && . ~/.bash_profile

#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
