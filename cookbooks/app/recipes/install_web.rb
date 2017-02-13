# Install web service

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
