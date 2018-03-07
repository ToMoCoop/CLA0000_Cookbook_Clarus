#
# Cookbook Name:: cookbook_clarus
# Recipe:: default
#

include_recipe 'apt'
include_recipe 'imagemagick'
include_recipe 'sqlite'
include_recipe 'appbox'
include_recipe 'runit'
include_recipe 'cookbook_clarus::directories'
include_recipe 'cookbook_clarus::ruby'
include_recipe 'cookbook_clarus::postgresql'
include_recipe 'cookbook_clarus::nginx'
include_recipe 'cookbook_clarus::passenger'
include_recipe 'cookbook_clarus::efs'
include_recipe 'cookbook_clarus::ftpd'
include_recipe 'cookbook_clarus::papertrail'
include_recipe 'cookbook_clarus::logrotate'
include_recipe 'cookbook_clarus::wkhtmltopdf'
