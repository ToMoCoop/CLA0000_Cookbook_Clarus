#
# Cookbook Name:: cookbook_clarus
# Recipe:: solr
#

# Set some locations
src_filename = ::File.basename(node['cookbook_clarus']['solr']['url'])
src_filepath = "#{Chef::Config['file_cache_path']}/#{src_filename}"

# Download Apache Solr
remote_file src_filepath do
  source node['cookbook_clarus']['solr']['url']
  action :create_if_missing
  not_if { ::File.exists?(node['cookbook_clarus']['solr']['install_dir']) }
end

#  Extract Apache Solr into jetty home
bash 'extract_module' do
  cwd ::File.dirname(src_filepath)
  code <<-EOH
    mkdir -p #{node['cookbook_clarus']['solr']['install_dir']}
    tar xzf #{src_filename} -C #{node['cookbook_clarus']['solr']['install_dir']}
    mv #{node['cookbook_clarus']['solr']['install_dir']}/*/* #{node['cookbook_clarus']['solr']['install_dir']}/
  EOH
  not_if { ::File.exists?(node['cookbook_clarus']['solr']['install_dir']) }
end

# Ensure the folder structures are available
directory "#{node['cookbook_clarus']['jetty']['log_dir']}" do
  owner node['cookbook_clarus']['jetty']['user']
  group node['cookbook_clarus']['jetty']['user']
  mode '0755'
  action :create
  recursive true
end
directory "#{node['cookbook_clarus']['jetty']['home_dir']}/etc" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  recursive true
end
directory "#{node['cookbook_clarus']['solr']['home_dir']}" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  recursive true
end


# Copy the file that defines the logging
template "#{node['cookbook_clarus']['jetty']['home_dir']}/resources/log4j.properties" do
  source 'log4j.properties.erb'
  owner node['cookbook_clarus']['jetty']['user']
  group node['cookbook_clarus']['jetty']['user']
  mode '0644'
end

# Copy the contents of the clarus solr collection to the correct place
remote_directory "#{node['cookbook_clarus']['solr']['home_dir']}/clarus" do
  source 'solr/clarus'
end

execute 'Set the owner on the solr directories' do
  command "chown -Rf #{node['cookbook_clarus']['jetty']['user']}:#{node['cookbook_clarus']['jetty']['user']} #{node['cookbook_clarus']['solr']['install_dir']}"
end

link '/opt/solr-latest' do
  to node['cookbook_clarus']['solr']['install_dir']
end