#!/bin/bash
#
# Root check
if [ $(id -u) != 0 ]; then
    echo "You must be root to run this scfipt"
    sudo ${0} ${@}
    exit
fi

# Variables
PUPPETLABS_RELEASE_RPM="puppetlabs-release-6-10.noarch.rpm"

# Functions
function install_from_repo() {
    local PKGS="${@}"
    rpm --quiet -q $PKGS || yum install -y ${PKGS}
}

# Install PuppetLabs repo
rpm --quiet -q puppetlabs-release ||
    yum install -y \
      http://yum.puppetlabs.com/el/6/products/x86_64/$PUPPETLABS_RELEASE_RPM

# Install Puppet
install_from_repo puppet-3.5.1-1.el6

# Update hostsfile
grep -q ^192.168.122.10 /etc/hosts || echo -e "192.168.122.10\tpuppet" >> /etc/hosts

# Symlink hiera config into /etc/puppet
test -h /etc/puppet/hiera.yaml || ln -s /etc/hiera.yaml /etc/puppet/hiera.yaml

# Copy hiera config
cp /vagrant/puppet/hiera/hiera.yaml /etc/hiera.yaml

# Run puppet in bootstrap mode (only do it once)
if [ ! -f /etc/sysconfig/bootstrapped ]; then
    if [ -d /etc/puppet/bootstrap ]; then
        sudo puppet apply --pluginsync \
            --modulepath=/etc/puppet/bootstrap/modules \
            /etc/puppet/bootstrap/manifests/site.pp
    else
        echo "Not the puppetmaster...continue other shizzle"
    fi
else
    echo "Already bootstrapped....not running puppet apply ..."
fi
