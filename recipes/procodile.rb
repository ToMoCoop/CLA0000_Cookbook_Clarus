#
# Cookbook Name:: cookbook_clarus
# Recipe:: procodile
#

rb_version = node['cookbook_clarus']['ruby']['version']

rbenv_gem 'procodile' do
  ruby_version rb_version
end