#
# Cookbook:: iptables
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


# Disable firewall service

case node['platform']
when 'redhat', 'centos', 'amazon', 'scientific', 'oracle'
	service 'iptables' do
		action [:disable, :stop]
	end
	service 'iptables-ipv6' do
		action [:disable, :stop]
	end
end

