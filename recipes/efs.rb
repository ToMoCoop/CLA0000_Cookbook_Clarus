#
# Cookbook Name:: cookbook_clarus
# Recipe:: efs
#

fsid = node['cookbook_clarus']['efs']['fsid']
region = node['cookbook_clarus']['efs']['region']
shared_root = node['cookbook_clarus']['shared_root']
ftp_root = node['cookbook_clarus']['ftp_root']
deploy_user = node['appbox']['deploy_user']

# Create the base location for the shared files
directory shared_root do
  owner deploy_user
  group deploy_user
  mode '0755'
  action :create
  recursive true
end

# Create the base location for the FTP
# We need to create this separately to the shared files location
# as the owner and group only apply to the leaf node when
# performing a recursive directory creation.
directory ftp_root do
  owner deploy_user
  group deploy_user
  mode '0755'
  action :create
  recursive true
end

# If we have a File Storage ID for FTP, then mount EFS to it.
if fsid
  include_recipe 'nfs'
  mount_efs ftp_root do
    fsid fsid
    region region
    action :mount
  end
end