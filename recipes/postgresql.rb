#
# Cookbook Name:: cookbook_clarus
# Recipe:: postgresql
#
# Install Postgresql and create specified databases and users, if required.
#

# Install the client for postgresql, as we always need this
postgresql_client_install 'Install Postgresql Client' do

end

# Get some key variables
install_db = node['cookbook_clarus']['install_db']
database = node['cookbook_clarus']['database']
postgres_home = "/home/#{database['username']}/"

# If we're installing a database on the server, we need the
# postgres server, and then setup as applicable.
if install_db

  postgresql_server_install 'Install Postgresql Server' do
    password database['password']
  end

  postgresql_access 'access1' do
    access_type 'local'
    access_db 'all'
    access_user 'postgres'
    access_method 'peer'
    access_addr 'nil'
  end

  postgresql_access 'access3' do
    access_type 'host'
    access_db 'all'
    access_user 'all'
    access_addr '127.0.0.1/32'
    access_method 'md5'
  end

  postgresql_access 'access4' do
    access_type 'host'
    access_db 'all'
    access_user 'all'
    access_addr '::1/128'
    access_method 'md5'
  end

  directory postgres_home do
    mode "2775"
    owner database['username']
    group database['username']
    action :create
    recursive true
  end

  postgresql_database database['name'] do
    owner database['username']
  end

end

# Ftp services need PG system wide.
postgresql_pg_gem 'install postgresql gem' do
  ruby_binary '/usr/local/rbenv/shims/ruby'
end