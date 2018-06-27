#
# Cookbook Name:: cookbook_clarus
# Recipe:: wkhtmltopdf
#

# Replace the dependency packages for Ubuntu 16.06 by replacing libssl0.9.8 with libssl1.0.0
node.set['wkhtmltopdf-update']['dependency_packages'] = %w(libfontconfig1 libssl1.0.0 libxext6 libxrender1 fontconfig libjpeg8 xfonts-base xfonts-75dpi)

# Switched to using the out of the box wkhtmltopdf-update cookbook from https://github.com/BallisticPain/chef-wkhtmltopdf/
# At this point the binary install script which we use tries to read a default['wkhtmltopdf-update']['package'] value which
# for some odd readon (probably a bug) is no longer set.
# So, to ease the burden, adding this in here:
node.set['wkhtmltopdf-update']['package'] = "wkhtmltox_#{node.get['wkhtmltopdf-update']['version']}.trusty-amd64.deb",

# Install wkhtmltopdf itself
include_recipe "wkhtmltopdf-update"