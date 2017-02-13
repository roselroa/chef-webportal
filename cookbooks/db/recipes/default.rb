#
# Cookbook:: db
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'selinux::disabled'
include_recipe 'iptables::disabled'

mysql = data_bag_item('passwords','mysql')
webapp = data_bag_item('passwords','webapp')

file '/var/tmp/secret' do
	content "#{mysql['dev']} #{webapp['dev']} #{webapp['stg']} #{webapp['prd']}"
end
