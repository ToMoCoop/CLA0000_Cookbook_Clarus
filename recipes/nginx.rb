#
# Cookbook Name:: cookbook_clarus
# Recipe:: nginx
#

node.override['nginx']['version'] = '1.12.1'
node.override['nginx']['source']['checksum'] = '8793bf426485a30f91021b6b945a9fd8a84d87d17b566562c3797aba8fac76fb'
node.override['nginx']['source']['version']  = node['nginx']['version']
node.override['nginx']['source']['url']      = "http://nginx.org/download/nginx-#{node['nginx']['source']['version']}.tar.gz"

include_recipe 'chef_nginx::source'

# Retrieve some variables and make them available locally with easier names.
appname = node['cookbook_clarus']['appname']
hostname = node['cookbook_clarus']['hostname']
listen_port = node['cookbook_clarus']['listen_port']
upstream_host = node['cookbook_clarus']['upstream_host']
upstream_port = node['cookbook_clarus']['upstream_port']
ssl_key = node['cookbook_clarus']['ssl']['key']
ssl_cert = node['cookbook_clarus']['ssl']['cert']
nginx_dir = node['nginx']['dir']
nginx_log_dir = node['nginx']['log_dir']


# Calculate some variables based on what we know.
rails_app_dir = ::File.join(node['appbox']['apps_dir'], appname)
rails_current_dir = ::File.join(rails_app_dir, 'current')
rails_public_dir = ::File.join(rails_current_dir, 'public')
nginx_vhost_location = File.join(nginx_dir, 'sites-available', appname)


# Write the nginx vhost file
template nginx_vhost_location do
  source    'nginx_vhost.conf.erb'
  cookbook  'cookbook_clarus'
  mode      '0644'
  owner     'root'
  group     'root'
  variables(
    :rails_public_dir  => rails_public_dir,
    :log_dir     => nginx_log_dir,
    :appname     => appname,
    :hostname    => hostname,
    :servers     => ["#{upstream_host}:#{upstream_port}"],
    :listen_port => listen_port,
    :ssl_key     => ssl_key,
    :ssl_cert    => ssl_cert,
    )
  notifies :reload, 'service[nginx]'
end

# Restart nginx
nginx_site appname do
  notifies :reload, 'service[nginx]'
end