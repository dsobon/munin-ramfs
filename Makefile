all: install

install:
	# make backup
	if [ ! -d "orig" ]; then \
		echo "creating backup of original munin files to orig/"; \
		mkdir orig; \
		cp /etc/cron.d/munin orig/etc-cron.d-munin; \
		cp /usr/bin/munin-cron orig/usr-bin-munin-cron; \
	fi
	# install
	cp etc/cron.d/munin /etc/cron.d/munin
	cp etc/cron.d/munin-rrd-cleanup /etc/cron.d/munin-rrd-cleanup
	cp usr/bin/munin-cron /usr/bin/munin-cron
	cp usr/bin/munin-cron-graph /usr/bin/munin-cron-graph
	cp usr/bin/munin-rrd-cleanup /usr/bin/munin-rrd-cleanup
	cp etc/default/munin-ramfs /etc/default/munin-ramfs
	cat etc/fstab >> /etc/fstab
	chmod 755 /usr/bin/munin-{cron,cron-graph,rrd-cleanup}

uninstall:
	if [ ! -d "orig" ]; then \
		echo "cannot uninstall ramfs - no install was done."; \
		exit 1; \
	fi
	# restore backup
	cp orig/etc-cron.d-munin /etc/cron.d/munin
	cp orig/usr-bin-munin-cron /usr/bin/munin-cron
	# remove additional files.
	rm /etc/cron.d/munin-rrd-cleanup
	rm /usr/bin/munin-rrd-cleanup
	rm /usr/bin/munin-cron-graph
	perl -ni -e 'print unless m#/mnt/ram#' /etc/fstab
