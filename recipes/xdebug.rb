#
# Cookbook Name:: dop_php
# Recipe:: xdebug
#

include_recipe "build-essential"

php_pear "xdebug" do
  if node['php']['xdebug']['version'] != "latest"
    version "#{node['php']['xdebug']['version']}"
  end
  #upgrade when package is installed and latest version is required
  action ( !(`pear list | grep xdebug`.empty?) and node['php']['xdebug']['version'] == "latest" ) ? :upgrade : :install
end

template "#{node['php']['fpm']['mods_dir']}/xdebug.ini" do
  source "zend_extension.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(:name => "xdebug", :directives => node['php']['xdebug']['ini'])
  not_if "php -m | grep xdebug"
end

link "#{node['php']['fpm']['conf_dir']}/20-xdebug.ini" do
  to "#{node['php']['fpm']['mods_dir']}/xdebug.ini"
  only_if node['php']['xdebug']['enabled']
end

file node['php']['xdebug']['ini']['remote_log'] do
  owner "root"
  group "root"
  mode 0777
  action :create_if_missing
end