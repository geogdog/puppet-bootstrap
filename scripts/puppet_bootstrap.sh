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
