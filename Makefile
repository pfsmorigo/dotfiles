commit: commit_message.txt
	git add .
	git commit -vsS -e -F $<
	rm $<
