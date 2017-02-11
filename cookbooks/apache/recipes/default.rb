#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


# Install web service package
case node['platform']
when 'redhat', 'centos', 'amazon', 'scientific', 'oracle'
	package 'httpd'
when 'ubuntu', 'debian'
	package 'apache2'
end

# Start web service
case node['platform']
when 'redhat', 'centos', 'amazon', 'scientific', 'oracle'
	service 'httpd' do
		action [:enable, :start]
	end
when 'ubuntu', 'debian'
	service 'apache2' do
		action [:enable, :start]
	end
end

