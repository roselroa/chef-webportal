# Install web service

mysql = data_bag_item('passwords','mysql')
webapp = data_bag_item('passwords','webapp')
db_ip = data_bag_item('servers','db')
web_color = data_bag_item('web','color')

# encrypted data bag will be available for debugging on dev,stg environment.
file '/var/tmp/secret' do
	content "#{mysql[node.chef_environment]} #{webapp[node.chef_environment]} #{db_ip[node.chef_environment]}"
	only_if { node.chef_environment != 'prd' }
end

package 'httpd'

service 'httpd' do
	action [:enable, :start]
end

package ['php','php-mysql'] do
	notifies :restart, 'service[httpd]', :immediately
end

cookbook_file '/var/www/html/info.php' do
	source 'info.php'
	owner 'root'
	group 'root'
	mode '0755'
	notifies :restart, 'service[httpd]', :immediately
end

template '/var/www/html/index.php' do
	variables( :webapp_access => webapp[node.chef_environment], :webapp_db => db_ip[node.chef_environment], :web_color => web_color[node.chef_environment] )
	source 'index.erb'
	owner 'root'
	group 'root'
	mode '0755'
	notifies :restart, 'service[httpd]', :immediately
end

