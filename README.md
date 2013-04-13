munin-ramfs
===========

synchronise munin rrd files between persistent storage (disk) and non-persistent
storage (ramfs) to reduce disk IO to bare minimum.

requirements
============
* rsync
* make
* munin

install
=======
```
$ sudo make install
$ sudo $(EDITOR) /etc/munin/munin.conf
$ sudo $(EDITOR) /etc/default/munin-ramfs
$ sudo /usr/sbin/update-rc.d munin-ramfs defaults
$ sudo /etc/init.d/munin-ramfs start
```

features
========
* reduce disk IO by more than 50%.
  (one example: from 30 IOPS [update + graph] to 10 IOPS avg [graph only])
* transparently works with DRBD and pacemaker.

limitations
===========
* up to 1 hour of rrd data files may be lost if init stop script is not executed.
* graph files (png,html) are still generated onto persistent disk.
* munin-cron-graph does not handle failover (*_ORIG location) if ramfs is not started/mounted.
* no error handling if all rrd data files exceed free ram.
* tested on Debian stable ("squeeze" 6.0) with DRBD and pacemaker.

author
======
David Sobon &lt; d at sobon dot org &gt;
