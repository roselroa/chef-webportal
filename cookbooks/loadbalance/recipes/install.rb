#
# Cookbook:: loadbalance
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package 'epel-release'

package 'nginx'

service 'nginx' do
	action [:enable, :start]
end

webs = data_bag_item('servers','web')

template '/etc/nginx/nginx.conf' do
	variables( :web_ips => webs[node.chef_environment] )
	source 'nginx.conf.erb'
	owner 'root'
	group 'root'
	mode '0644'
	notifies :restart, 'service[nginx]', :immediately
end
