#
# Cookbook Name:: cookbook_clarus
# Recipe:: default
#

# Set the properties on databox

# Create the apps structure that rackbox likes
apps = {
  'unicorn' => [
    {
      'appname' => node['cookbook_clarus']['appname'],
      'hostname' => node['cookbook_clarus']['hostname'],
      'unicorn_config' => {
        'preload_app' => true,
        'before_fork' => 'ActiveRecord::Base.connection.disconnect! if defined?(ActiveRecord::Base)',
        'after_fork' => 'ActiveRecord::Base.establish_connection if defined?(ActiveRecord::Base)'
      },
      'runit_config' => {
        'rack_env' => node['cookbook_clarus']['rails_env']
      },
      'nginx_config' => node['cookbook_clarus']['nginx_config']
    }
  ]
}

# Set the properties on rackbox
node.set['cookbook_rackbox']['ruby']['versions'] = %w(2.0.0-p643)
node.set['cookbook_rackbox']['ruby']['global_version'] = '2.0.0-p643'
node.set['cookbook_rackbox']['apps'] = apps


include_recipe 'cookbook_clarus::locale'
include_recipe 'apt'
include_recipe 'imagemagick'
include_recipe 'sqlite'
include_recipe 'postgresql::client'
include_recipe 'cookbook_clarus::postgresql'
include_recipe 'cookbook_rackbox'
include_recipe 'cookbook_clarus::users'
include_recipe 'cookbook_clarus::symlinks'
include_recipe 'cookbook_clarus::java'
include_recipe 'cookbook_clarus::npm'
include_recipe 'cookbook_clarus::phantomjs'
include_recipe 'cookbook_clarus::redis'
include_recipe 'cookbook_clarus::solr'
include_recipe 'cookbook_clarus::ftpd'
include_recipe 'cookbook_clarus::session-manager'
include_recipe 'cookbook_clarus::god'
include_recipe 'cookbook_clarus::logrotate'
include_recipe 'cookbook_clarus::newrelic'