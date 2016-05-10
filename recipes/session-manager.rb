directory '/etc/clarus' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  recursive true
end

template '/etc/clarus/session-manager' do
  source 'session-manager.erb'
  owner 'root'
  group 'root'
  mode '0755'
end
