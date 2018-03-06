#
# Cookbook Name:: cookbook_clarus
# Recipe:: passenger
#
# Setup the passenger app.
#

# Retrieve some variables and make them available locally with easier names.
appname = node['cookbook_clarus']['appname']
rails_env = node['cookbook_clarus']['rails_env']
upstream_host = node['cookbook_clarus']['upstream_host']
upstream_port = node['cookbook_clarus']['upstream_port']
deploy_user = node['appbox']['deploy_user']
deploy_group = node['appbox']['deploy_user']

# Calculate some variables based on what we know.
rails_app_dir = ::File.join(node['appbox']['apps_dir'], appname)
rails_current_dir = ::File.join(rails_app_dir, 'current')
passenger_log_file = File.join(rails_current_dir, 'log', 'passenger.log')
passenger_pid_file = File.join(rails_current_dir, 'log', 'passenger.pid')

# Create the passenger service using runit
runit_service appname do
  run_template_name  'passenger'
  log_template_name  'passenger'
  cookbook           'cookbook_clarus'
  options(
    :user              => deploy_user,
    :group             => deploy_group,
    :environment       => rails_env,
    :working_directory => rails_current_dir,
    :host              => upstream_host,
    :port              => upstream_port,
    :log_file          => passenger_log_file,
    :pid_file          => passenger_pid_file,
  )
  restart_on_update false
end