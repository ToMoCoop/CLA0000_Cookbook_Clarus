#
# Cookbook Name:: cookbook_clarus
# Recipe:: symlinks
#

# Since Vagrant on an NTFS host doesn't support symlinks properly,
# We decided to move the node_modules and tmp directory off the shared disk.

directory "/home/apps/#{node['cookbook_clarus']['appname']}/current/frontend/node_modules" do
  recursive true
  action :delete
  not_if "test -L /home/apps/#{node['cookbook_clarus']['appname']}/current/frontend/node_modules"
  only_if { node['cookbook_clarus']['symlink_node_modules'] }
end

directory "/home/apps/#{node['cookbook_clarus']['appname']}/node_modules" do
  owner "vagrant"
  group "vagrant"
  only_if { node['cookbook_clarus']['symlink_node_modules'] }
end

link "/home/apps/#{node['cookbook_clarus']['appname']}/current/frontend/node_modules" do
  owner "vagrant"
  group "vagrant"
  to "/home/apps/#{node['cookbook_clarus']['appname']}/node_modules"
  only_if { node['cookbook_clarus']['symlink_node_modules'] }
end


directory "/home/apps/#{node['cookbook_clarus']['appname']}/current/frontend/tmp" do
  recursive true
  action :delete
  not_if "test -L /home/apps/#{node['cookbook_clarus']['appname']}/current/frontend/tmp"
  only_if { node['cookbook_clarus']['symlink_tmp'] }
end

directory "/home/apps/#{node['cookbook_clarus']['appname']}/tmp" do
  owner "vagrant"
  group "vagrant"
  only_if { node['cookbook_clarus']['symlink_tmp'] }
end

link "/home/apps/#{node['cookbook_clarus']['appname']}/current/frontend/tmp" do
  owner "vagrant"
  group "vagrant"
  to "/home/apps/#{node['cookbook_clarus']['appname']}/tmp"
  only_if { node['cookbook_clarus']['symlink_tmp'] }
end

link "/home/apps/#{node['cookbook_clarus']['appname']}/.jshintrc" do
  action :delete
end

link "/home/apps/#{node['cookbook_clarus']['appname']}/.jshintrc" do
  owner "vagrant"
  group "vagrant"
  to "/home/apps/#{node['cookbook_clarus']['appname']}/current/frontend/.jshintrc"
  only_if { node['cookbook_clarus']['symlink_jshintrc'] }
end

