default['java']['install_flavor'] = 'oracle'
default['java']['jdk_version'] = '8'
default['java']['oracle']['accept_oracle_download_terms'] = true

default['cookbook_clarus']['appname'] = 'clarus'
default['cookbook_clarus']['hostname'] = 'localhost'
default['cookbook_clarus']['rails_env'] = 'production'
default['cookbook_clarus']['install_db'] = true
default['cookbook_clarus']['db_root_password'] = ''
default['cookbook_clarus']['database']['host'] = 'localhost'
default['cookbook_clarus']['database']['name'] = ''
default['cookbook_clarus']['database']['username'] = ''
default['cookbook_clarus']['database']['password'] = ''
default['cookbook_clarus']['symlink_node_modules'] = false
default['cookbook_clarus']['symlink_tmp'] = false
default['cookbook_clarus']['symlink_jshintrc'] = false

default['cookbook_clarus']['nginx_config'] = {};

default['cookbook_clarus']['nodejs']['version'] = '4.4.3'
default['cookbook_clarus']['nodejs']['checksum'] = '57499bb0b1b86080459d4066e3c138579a278b2d0b1f5b2f19e66c69b4e8433c'

default['cookbook_clarus']['ruby']['version'] = '2.1.10'

default['cookbook_clarus']['solr']['version'] = '4.10.4'
default['cookbook_clarus']['solr']['url'] = "http://mirrors.ukfast.co.uk/sites/ftp.apache.org/lucene/solr/#{node['cookbook_clarus']['solr']['version']}/solr-#{node['cookbook_clarus']['solr']['version']}.tgz"
default['cookbook_clarus']['solr']['port'] = 8893
default['cookbook_clarus']['solr']['install_dir'] = "/opt/solr-#{node['cookbook_clarus']['solr']['version']}"
default['cookbook_clarus']['solr']['home_dir'] = "/opt/solr-#{node['cookbook_clarus']['solr']['version']}/example/solr"

default['cookbook_clarus']['jetty']['user'] = "solr"
default['cookbook_clarus']['jetty']['group'] = "solr"
default['cookbook_clarus']['jetty']['home_dir'] = "/opt/solr-#{node['cookbook_clarus']['solr']['version']}/example"
default['cookbook_clarus']['jetty']['log_dir'] = "/var/log/solr"

default['cookbook_clarus']['ftp_root'] = "/home/apps/#{node['cookbook_clarus']['appname']}/current/storage"
default['cookbook_clarus']['pure-ftpd']['url'] = 'http://download.pureftpd.org/pub/pure-ftpd/releases/pure-ftpd-1.0.43.tar.gz'
default['cookbook_clarus']['pure-ftpd']['version'] = '1.0.43'

default['cookbook_clarus']['pusher']['secret'] = nil
default['cookbook_clarus']['pusher']['key'] = nil

default['build-essential']['compile_time'] = true