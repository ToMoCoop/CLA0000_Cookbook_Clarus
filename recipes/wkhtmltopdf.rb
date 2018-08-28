#
# Cookbook Name:: cookbook_clarus
# Recipe:: wkhtmltopdf
#

# Replace the dependency packages for Ubuntu 16.06 by replacing libssl0.9.8 with libssl1.0.0
node.override['wkhtmltopdf-update']['dependency_packages'] = %w(libfontconfig1 libssl1.0.0 libxext6 libxrender1 fontconfig libjpeg8 xfonts-base xfonts-75dpi)

# Install wkhtmltopdf itself
include_recipe "wkhtmltopdf-update"