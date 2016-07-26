#
# Cookbook Name:: cookbook_clarus
# Recipe:: default
#

include_recipe 'cookbook_clarus::locale'
include_recipe 'apt'
include_recipe 'imagemagick'
include_recipe 'sqlite'
include_recipe 'postgresql::client'
include_recipe 'cookbook_clarus::postgresql'
include_recipe 'appbox'
include_recipe 'cookbook_clarus::ruby'
include_recipe 'cookbook_clarus::nginx'
include_recipe 'runit'
include_recipe 'cookbook_clarus::unicorn'
include_recipe 'cookbook_clarus::users'
include_recipe 'cookbook_clarus::java'
include_recipe 'cookbook_clarus::npm'
include_recipe 'cookbook_clarus::redis'
include_recipe 'cookbook_clarus::ftpd'
include_recipe 'cookbook_clarus::session-manager'
include_recipe 'cookbook_clarus::god'
include_recipe 'cookbook_clarus::logrotate'