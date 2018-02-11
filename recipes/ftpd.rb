# Ftp services need bcrypt system wide.
gem_package "bcrypt" do
  action :install
end

remote_file "/tmp/pure-ftpd-#{node['cookbook_clarus']['pure-ftpd']['version']}.tar.gz" do
  source node['cookbook_clarus']['pure-ftpd']['url']
end

bash 'Download Pure-FTPD' do
  code <<-EOH
    sudo tar -C /tmp -xzf /tmp/pure-ftpd-#{node['cookbook_clarus']['pure-ftpd']['version']}.tar.gz
    cd /tmp/pure-ftpd-#{node['cookbook_clarus']['pure-ftpd']['version']}
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

template '/etc/pure-ftpd/ftp-auth-handler' do
  source 'ftp-auth-handler.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

systemd_unit "pure-ftpd-authd.service" do
  enabled true
  active true
  content "[Unit]\nDescription=Pure-FTPd-Authd\nAfter=network.target\n\n[Service]\nExecStart=/usr/local/sbin/pure-authd -s /var/run/ftpd.sock -r /etc/pure-ftpd/ftp-auth-handler\nRestart=always\n\n[Install]\nWantedBy=multi-user.target"
  action [:create]
end

systemd_unit "pure-ftpd.service" do
  enabled true
  active true
  content "[Unit]\nDescription=Pure-FTPd\nAfter=network.target\n\n[Service]\nExecStart=/usr/local/sbin/pure-ftpd -lextauth:/var/run/ftpd.sock -p 50000:50400\nRestart=always\n\n[Install]\nWantedBy=multi-user.target"
  action [:create]
end

systemd_unit "pure-ftpd-authd.service" do
  action [:enable, :start]
end

systemd_unit "pure-ftpd.service" do
  action [:enable, :start]
end