# Ftp services need PG system wide.
gem_package "pg" do
  action :install
end

# Ftp services need bcrypt system wide.
gem_package "bcrypt" do
  action :install
end

# Ftp services need pusher-client system wide.
gem_package "pusher-client" do
  action :install
end

remote_file '/tmp/pure-ftpd-1.0.39.tar.gz' do
  source node['cookbook_clarus']['pure-ftpd']['url']
end

bash 'Download Pure-FTPD' do
  code <<-EOH
    sudo tar -C /tmp -xzf /tmp/pure-ftpd-1.0.39.tar.gz
    cd /tmp/pure-ftpd-1.0.39
    sudo ./configure --with-extauth
    sudo make
    sudo make install
  EOH
end

directory '/etc/pure-ftpd' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  recursive true
end

directory '/home/apps/'+node['cookbook_clarus']['appname']+'/current/public/uploads' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  recursive true
end

template '/etc/pure-ftpd/ftp-auth-handler' do
  source 'ftp-auth-handler.erb'
  owner 'root'
  group 'root'
  mode '0755'
end




