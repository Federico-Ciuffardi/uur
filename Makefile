install: uur 
	./deps
	cp uur /usr/bin/uur

uninstall: nay
	rm --force /usr/bin/uur
