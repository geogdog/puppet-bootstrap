# site.pp
node 'default' {
    class { 'epel': }
}

node 'test-puppetmaster-001.puppetbootstrap.local' inherits default {
    class { 'puppetdb': }
    class { 'puppet::master':
        storeconfigs => true,
        version      => '3.5.1-1.el6',
        autosign     => true,
    }
    class { 'puppet::agent':
        puppet_server => 'test-puppetmaster-001.puppetbootstrap.local',
    }
}
