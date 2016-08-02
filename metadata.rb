name             'cookbook_clarus'
maintainer       'Fred Thompson'
maintainer_email 'fred.thompson@buildempire.co.uk'
license          'Apache 2.0'
description      'The Clarus server cookbook, ready for the Clarus application deployment.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.4.1'

recipe 'cookbook_clarus', 'The Clarus server cookbook, ready for the Clarus application deployment.'

%w{ ubuntu }.each do |os|
  supports os
end

%w{appbox apt build-essential  database imagemagick java logrotate newrelic nginx nodejs postgresql rbenv redisio ruby_build runit sqlite unicorn wkhtmltopdf}.each do |cb|
  depends cb
end