all: install

install:
	# make backup
	if [ ! -d "orig" ]; then \
		echo "creating backup of original munin files to orig/"; \
		mkdir orig; \
		cp /etc/munin/munin.conf orig/etc-munin-munin.conf; \
		cp /etc/cron.d/munin orig/etc-cron.d-munin; \
		cp /usr/bin/munin-cron orig/usr-bin-munin-cron; \
	fi
	# install
	cp etc/cron.d/munin /etc/cron.d/
	cp etc/cron.d/munin-rrd-cleanup /etc/cron.d/
	cp usr/bin/munin-cron /usr/bin/
	cp usr/bin/munin-cron-graph /usr/bin/
	cp usr/bin/munin-rrd-cleanup /usr/bin/
	cp etc/default/munin-ramfs /etc/default/
	cp etc/init.d/munin-ramfs /etc/init.d/
	grep -q /mnt/ram /etc/fstab || cat etc/fstab >> /etc/fstab
	chmod 755 /etc/init.d/munin-ramfs
	chmod 755 /usr/bin/munin-cron
	chmod 755 /usr/bin/munin-cron-graph
	chmod 755 /usr/bin/munin-rrd-cleanup
	mkdir -p /mnt/ram
	@echo ""
	@echo "Please modify dbdir: /etc/munin/munin.conf"
	@echo "Edit to taste: /etc/default/munin-ramfs"
	@echo "Then run: /etc/init.d/munin-ramfs start"
	@echo ""

uninstall:
	if [ ! -d "orig" ]; then \
		echo "cannot uninstall ramfs - no install was done."; \
		exit 1; \
	fi
	# restore backup
	cp -a orig/usr-bin-munin-cron /usr/bin/munin-cron
	cp -a orig/etc-cron.d-munin /etc/cron.d/munin
	cp -a orig/etc-munin-munin.conf /etc/munin/munin.conf
	# remove additional files.
	rm /etc/default/munin-ramfs
	rm /etc/cron.d/munin-rrd-cleanup
	rm /usr/bin/munin-rrd-cleanup
	rm /usr/bin/munin-cron-graph
	perl -ni -e 'print unless m#/mnt/ram#' /etc/fstab
	# stop.
	/etc/init.d/munin-ramfs stop
	rmdir /mnt/ram
	# final.
	rm /etc/init.d/munin-ramfs
