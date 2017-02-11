#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


case node['platform']
when 'redhat', 'centos', 'amazon', 'scientific', 'oracle'
	package 'httpd'
	service 'httpd' do
		action [:enable, :start]
	end
when 'ubuntu', 'debian'
	package 'apache2'
	service 'apache2' do
		action [:enable, :start]
	end
end

