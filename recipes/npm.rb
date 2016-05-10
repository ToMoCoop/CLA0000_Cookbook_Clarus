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

# Install the packages that ember development requires
nodejs_npm "bower" do
end
nodejs_npm "ember-cli" do
end
nodejs_npm "phantomjs" do
end