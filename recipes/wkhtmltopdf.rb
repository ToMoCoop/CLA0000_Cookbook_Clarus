#
# Cookbook Name:: cookbook_clarus
# Recipe:: wkhtmltopdf
#

# Setup wkhtmltopdf
node.set['wkhtmltopdf']['mirror_url'] = 'https://wkhtmltopdf.googlecode.com/files'
node.set['wkhtmltopdf']['version'] = '0.10.0_rc2'

# Install wkhtmltopdf itself
include_recipe "wkhtmltopdf::default"