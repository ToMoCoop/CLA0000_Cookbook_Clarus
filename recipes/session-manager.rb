directory '/etc/clarus' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  recursive true
end

if node['cookbook_clarus']['pusher']['key'] == nil && node['cookbook_clarus']['pusher']['secret'] == nil
  node.set['cookbook_clarus']['pusher'] = data_bag_item('pusher', node['cookbook_clarus']['appname'])
end

template '/etc/clarus/session-manager' do
  source 'session-manager.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

systemd_unit "session-manager.service" do
  enabled true
  active true
  content "[Unit]\nDescription=Session-Manager\nAfter=network.target\n\n[Service]\nExecStart=/etc/clarus/session-manager\nRestart=always\n\n[Install]\nWantedBy=multi-user.target"
  action [:create, :enable, :start]
end