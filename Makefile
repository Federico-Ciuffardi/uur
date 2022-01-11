install: uur 
	cp uur /usr/bin/uur
	cp naylib/naylib /usr/lib/naylib

uninstall: nay
	rm --force /usr/bin/uur
	cp naylib/naylib /usr/lib/naylib
