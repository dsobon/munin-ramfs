munin-ramfs
===========

synchronise munin rrd files between persistent storage (disk) and non-persistent
storage (ramfs) to reduce disk IO.

requirements
============
* rsync
* make
* munin

install
=======
```
$ sudo make install
$ sudo /etc/alternatives/editor /etc/munin/munin.conf
$ sudo /etc/alternatives/editor /etc/default/munin-ramfs
$ sudo /usr/sbin/update-rc.d munin-ramfs defaults
$ sudo /etc/init.d/munin-ramfs start
```

features
========
* reduce disk IO to nearly zero.
* graphs are now generated onto volatile (ramfs) storage.
* transparently works with DRBD and pacemaker.

limitations
===========
* up to 1 hour of rrd data files may be lost if init stop script is not executed.
* munin-cron-graph does not handle failover (*_ORIG location) if ramfs is not started/mounted.
* no error handling if rrd data total size exceeds available free ram.
* tested on Debian stable ("squeeze" 6.0) with DRBD and pacemaker.

author
======
David Sobon &lt; d at sobon dot org &gt;
