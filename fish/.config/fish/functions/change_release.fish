#!/bin/fish

function change_release
	set DIR $PWD
	set REL $argv

	while test $DIR != "/"
		test -e "$DIR/$REL" \
			&& set PKG (basename $DIR) \
			&& echo $DIR/$REL/$PKG-* \
			&& break
		set DIR (dirname $DIR)
	end
	test $DIR = "/" && echo $PWD
end
