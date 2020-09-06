cat ~/.bashrc | grep "^\s*export" | while read -l LINE
	eval (echo "$LINE" | sed "s/^export/set -gx/;s/=/ /;s/\$(/(/")
end
