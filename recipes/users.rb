#
# Cookbook Name:: cookbook_clarus
# Recipe:: users
#

# Create the solr jetty user account
user_account node['cookbook_clarus']['jetty']['user'] do
  comment 'Jetty and Solr user'
  create_group true
end