#
# Cookbook Name:: cookbook_clarus
# Recipe:: npm
#

# Install from source
node.set['nodejs']['install_method'] = 'source'

# Set the node version and checksum
node.set['nodejs']['version'] = node['cookbook_clarus']['nodejs']['version']
node.set['nodejs']['source']['checksum'] = node['cookbook_clarus']['nodejs']['checksum']

# Install npm itself
include_recipe "nodejs::npm"