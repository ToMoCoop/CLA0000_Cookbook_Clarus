#
# Cookbook Name:: cookbook_clarus
# Recipe:: directories
#

app_root = node['cookbook_clarus']['app_root']
apps_user = node['appbox']['apps_user']
deploy_user = node['appbox']['deploy_user']

# Create the base location for the shared files
directory app_root do
  owner deploy_user
  group apps_user
  mode '0755'
  action :create
  recursive true
end