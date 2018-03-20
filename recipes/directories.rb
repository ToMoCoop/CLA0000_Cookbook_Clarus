#
# Cookbook Name:: cookbook_clarus
# Recipe:: directories
#

app_root = node['cookbook_clarus']['app_root']
deploy_user = node['appbox']['deploy_user']

# Create the base location for the shared files
directory app_root do
  owner deploy_user
  group deploy_user
  mode '0755'
  action :create
  recursive true
end