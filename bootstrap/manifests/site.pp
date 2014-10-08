# site.pp
node 'default' {}

node 'test-puppetmaster-001.puppetbootstrap.local' inherits default {
    class { 'epel': }
    class { 'puppetdb': }
    class { 'puppet::master':
        storeconfigs => true,
        version      => '3.5.1-1.el6',
        autosign     => true,
    }
    class { 'puppet::agent':
        puppet_server => 'test-puppetmaster-001.puppetbootstrap.local',
    }
    file { '/etc/sysconfig/bootstrapped':
      ensure => 'file',
      owner  => 'root',
      group => 'root',
      mode => '0444',
      content => "I've been bootstrapped",
    }
}
