# site.pp

# hiera class lookups.
hiera_include('classes')

# include jenkins plugins from hiera
create_resources(jenkins::plugin, hiera_hash('jenkins_plugins', {}))

# hosts can be included in hiera too
create_resources(host, hiera_hash('hosts', {}))

# packages can be included in hiera too
create_resources(package, hiera_hash('extra_packages', {}))
