#
# Cookbook:: php
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Install php, php-mysql
case node['platform']
when 'redhat', 'centos', 'amazon', 'scientific', 'oracle'
	package ['php','php-mysql']
end

#file '/var/www/html/info.php' do
#	content '<?php phpinfo(); ?>'
#	mode '0755'
#	owner 'root'
#	group 'root'
#end

cookbook_file '/var/www/html/info.php' do
	source 'info.php'
	owner 'root'
	group 'root'
	mode '0755'
end
