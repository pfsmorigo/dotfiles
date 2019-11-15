
TARGET=~/.Xresources

${TARGET}: Xresources
	cpp -P $< > $@
	xrdb $@

clean:
	rm -rf ${TARGET}

.PRONE: Xresources
