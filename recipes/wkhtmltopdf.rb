#
# Cookbook Name:: cookbook_clarus
# Recipe:: wkhtmltopdf
#

# Setup wkhtmltopdf
node.set['wkhtmltopdf']['mirror_url'] = 'https://wkhtmltopdf.googlecode.com/files'
node.set['wkhtmltopdf']['version'] = '0.10.0_rc2'

# Reset some variables based on these changes.
node.set['wkhtmltopdf']['wkhtmltoimage']['binary_full_name'] = "wkhtmltoimage-#{node['wkhtmltopdf']['version']}-static-#{node['wkhtmltopdf']['arch']}"
node.set['wkhtmltopdf']['wkhtmltoimage']['binary_url'] = "#{node['wkhtmltopdf']['mirror_url']}/#{node['wkhtmltopdf']['wkhtmltoimage']['binary_full_name']}.tar.bz2"
node.set['wkhtmltopdf']['wkhtmltopdf']['binary_full_name'] = "wkhtmltopdf-#{node['wkhtmltopdf']['version']}-static-#{node['wkhtmltopdf']['arch']}"
node.set['wkhtmltopdf']['wkhtmltopdf']['binary_url'] = "#{node['wkhtmltopdf']['mirror_url']}/#{node['wkhtmltopdf']['wkhtmltopdf']['binary_full_name']}.tar.bz2"


# Install wkhtmltopdf itself
include_recipe "wkhtmltopdf::default"