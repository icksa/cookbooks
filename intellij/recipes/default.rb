#
# Cookbook Name:: intellij
# Recipe:: default
#
# Copyright (C) 2014 Milad Fatenejad
#
include_recipe 'java'

version = node['intellij']['version']
url = node['intellij']['url']
install_path = "#{node['intellij']['prefix']}/ideaIU"
download_path = "#{Chef::Config[:file_cache_path]}/ideaIU-#{version}.tar.gz"

remote_file download_path do
  source "#{url}/ideaIU-#{version}.tar.gz"
  mode 0644
  not_if "test -d #{install_path}"
end

execute 'untar-and-install' do
  cwd Chef::Config[:file_cache_path]
  command <<-EOF
  loc=$(tar -xvzf ideaIU-13.1.3.tar.gz | grep build.txt | awk -F '/' '{print $1}')
  mv ${loc} #{install_path}
  EOF
  not_if "test -d #{install_path}"
end

template '/usr/bin/ijult' do
  source 'ijult.erb'
  mode 0755
end

file download_path do
  action :delete
end
