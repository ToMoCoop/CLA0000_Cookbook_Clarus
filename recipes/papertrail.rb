#
# Cookbook Name:: cookbook_clarus
# Recipe:: papertrail
#
# Setup papertrail to access the logs
#

# Retrieve some variables and make them available locally with easier names.
appname = node['cookbook_clarus']['appname']
apps_dir = node['appbox']['apps_dir']
destination_host = node['cookbook_clarus']['papertrail']['destination_host']
destination_port = node['cookbook_clarus']['papertrail']['destination_port']
app_logs = ::File.join(apps_dir, appname, 'shared', 'log', '*.log')
nginx_log_dir = node['nginx']['log_dir']

if destination_host and destination_port
  node.set['papertrail']['hostname'] = appname
  node.set['papertrail']['destination_host'] = destination_host
  node.set['papertrail']['destination_port'] = destination_port
  node.set['papertrail']['files'] = [
    app_logs,
    nginx_log_dir
  ]
  include_recipe 'papertrail'
end