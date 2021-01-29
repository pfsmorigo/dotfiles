#!/bin/fish

for RELEASE in trusty xenial bionic focal groovy hirsute buster jessie stretch testing unstable wheezy
	alias $RELEASE="cd (change_release $RELEASE)"
end
