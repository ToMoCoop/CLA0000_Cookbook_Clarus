#
# Cookbook Name:: cookbook_clarus
# Recipe:: ruby
#
# Install and setup Ruby environment
#

rb_version = node['cookbook_clarus']['ruby']['version']

include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

rbenv_ruby rb_version
rbenv_gem 'bundler' do
  ruby_version rb_version
end
