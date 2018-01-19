#
# Cookbook Name:: cookbook_clarus
# Recipe:: postgresql
#
# Install Postgresql and create specified databases and users, if required.
#

install_db = node['cookbook_clarus']['install_db']
if install_db

  root_password = node['cookbook_clarus']['db_root_password']
  node.set['postgresql']['password']['postgres'] = root_password

  include_recipe 'postgresql::server'
  include_recipe 'database::postgresql'

  node.set['postgresql']['pg_hba'] = [
    {:type => 'local', :db => 'all', :user => 'postgres', :addr => nil, :method => 'ident'},
    {:type => 'local', :db => 'all', :user => 'all', :addr => nil, :method => 'md5'},
    {:type => 'host', :db => 'all', :user => 'all', :addr => '127.0.0.1/32', :method => 'md5'},
    {:type => 'host', :db => 'all', :user => 'all', :addr => '::1/128', :method => 'md5'}
  ]

  postgresql_connection_info = {
    :host => 'localhost',
    :port => node['postgresql']['config']['port'],
    :username => 'postgres',
    :password => node['postgresql']['password']['postgres']
  }

  postgresql_database node['cookbook_clarus']['database']['name'] do
    connection postgresql_connection_info
    template 'template0'
    encoding 'UTF8'
    collation 'en_US.utf8'
    owner 'postgres'
    action :create
  end

  postgresql_database_user node['cookbook_clarus']['database']['username'] do
    connection postgresql_connection_info
    action [:create, :grant]
    password(node['cookbook_clarus']['database']['password'])   if node['cookbook_clarus']['database']['password']
    database_name(node['cookbook_clarus']['database']['name'])  if node['cookbook_clarus']['database']['name']
  end

  execute 'Psql template1 to UTF8' do
    user 'postgres'
    command <<-SQL
echo "
UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';
DROP DATABASE template1;
CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UNICODE' LC_CTYPE='en_US.utf8'      LC_COLLATE='en_US.utf8';
UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';
\\c template1
VACUUM FREEZE;" | psql postgres -t
    SQL
# only_if '[ $(echo "select count(*) from pg_database where datname = \'template1\' and datcollate = \'en_US.utf8\'" |psql postgres -t) -eq 0 ]'
  end

end