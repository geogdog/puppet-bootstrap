================
puppet-bootstrap
================

The idea is that ``vagrant up`` gives you a puppetmaster with puppetdb.  You
could then put your own modules on it to start doing things correctly.

Setup
-----
You need to download the puppet modules needed using r10k so you need this
installed locally::

  gem install puppet -v 3.5.1 --no-ri --no-rdoc
  gem install r10k -v 1.3.4 --no-ri --no-rdoc
  pushd bootstrap; r10k puppetfile install; popd
  pushd puppet; r10k puppetfile install; popd


Known Issues
------------
Ruby 1.8.7 segmentation faults occasionally....just try a couple more times.
I'm trying to work out why, but I think it's a waste of time.

If the initial vagrant up fails becuase of this, you need to just run ``vagrant
provision puppetmaster`` until it completes, and then vagrant up after that.
