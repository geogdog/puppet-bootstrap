================
puppet-bootstrap
================

The idea is that ``vagrant up`` gives you a puppetmaster with puppetdb.  You
could then put your own modules on it to start doing things correctly.

Known Issues
------------
Ruby 1.8.7 segmentation faults occasionally....just try a couple more times.
I'm trying to work out why, but I think it's a waste of time.
