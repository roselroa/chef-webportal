#
# Cookbook:: app
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'selinux::permissive'

cookbook_file '/var/www/html/index.php' do
	source 'index.php'
	owner 'root'
	group 'root'
	mode '0755'
	action :create
end
