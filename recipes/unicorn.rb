#
# Cookbook Name:: cookbook_clarus
# Recipe:: unicorn
#
# Setup unicorn apps
#

::Chef::Recipe.send(:include, CookbookRackbox::Helpers)

# Build the app
app = {
  'appname' => node['cookbook_clarus']['appname'],
  'hostname' => node['cookbook_clarus']['hostname'],
  'unicorn_config' => {
    'preload_app' => true,
    'before_fork' => 'ActiveRecord::Base.connection.disconnect! if defined?(ActiveRecord::Base)',
    'after_fork' => 'ActiveRecord::Base.establish_connection if defined?(ActiveRecord::Base)',
    'listen_port_options' => { :tcp_nodelay => true, :backlog => 100 },
    'worker_timeout' => 60,
    'worker_processes' => [node[:cpu][:total].to_i * 4, 8].min
  },
  'runit_config' => {
    'rack_env' => node['cookbook_clarus']['rails_env'],
    'template_name' => 'unicorn',
    'template_cookbook' => 'cookbook_clarus'
  },
  'nginx_config' => {
    'template_name' => 'nginx_vhost.conf.erb',
    'template_cookbook' => 'cookbook_clarus',
    'listen_port' => 80
  }
}


default_port = 10001
rails_app_dir = ::File.join(node['appbox']['apps_dir'], app['appname'])
rails_app_dir = ::File.join(rails_app_dir, 'current')
rails_public_dir = ::File.join(rails_app_dir, 'public')

setup_nginx_site(app, rails_public_dir, default_port)
setup_unicorn_config(app, rails_app_dir, default_port)
setup_unicorn_runit(app, rails_app_dir)

