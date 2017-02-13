#
# Cookbook:: db
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'selinux::disabled'
include_recipe 'iptables::disabled'

mysql = data_bag_item('passwords','mysql')
webapp = data_bag_item('passwords','webapp')
db_ip = data_bag_item('servers','db')

file '/var/tmp/secret' do
	content "#{mysql[node.chef_environment]} #{webapp[node.chef_environment]} #{db_ip[node.chef_environment]}"
end
