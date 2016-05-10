#
# Cookbook Name:: cookbook_clarus
# Recipe:: god
#

# Create the god upstart script
template '/etc/init/god.conf' do
  source 'god.conf.erb'
  mode '0644'
  action :create
end

service 'god' do
  provider Chef::Provider::Service::Upstart
  supports :restart => true, :start => true, :stop => true
  action :stop
end