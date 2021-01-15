cat ~/.bashrc | grep "^\s*export" | while read -l LINE
	eval (echo "$LINE" | sed "s/^export/set -gx/;s/=/ /;s/\$(/(/")
end

for line in (grep -h "^alias" ~/.bash_aliases ~/.bash_ubuntusec)
	eval (echo $line | sed 's/=/ /')
end
