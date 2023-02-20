cat ~/.bashrc | grep "^\s*export" | while read -l LINE
	eval (echo "$LINE" | sed "s/^export/set -gx/;s/=/ /;s/\$(/(/")
end

for FILE in .bash_aliases .bash_ubuntusec
	if test -e ~/$FILE
		for LINE in (grep -h "^alias" ~/$FILE)
			eval (echo $LINE | sed 's/=/ /;s/$(/(/')
		end
	end
end
