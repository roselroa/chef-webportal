#
# Cookbook:: db
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Create DB

mysql_service 'portal' do
	port '3306'
	version '5.5'
	initial_root_password 'password'
	action [:create, :start]
end
