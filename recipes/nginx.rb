#
# Cookbook Name:: cookbook_clarus
# Recipe:: nginx
#

node.set['nginx']['version'] = '1.9.12'
node.set['nginx']['source']['checksum'] = '1af2eb956910ed4b11aaf525a81bc37e135907e7127948f9179f5410337da042'
node.set['nginx']['source']['version']  = node['nginx']['version']
node.set['nginx']['source']['url']      = "http://nginx.org/download/nginx-#{node['nginx']['source']['version']}.tar.gz"

include_recipe 'nginx::source'
