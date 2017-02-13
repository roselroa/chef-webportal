#
# Cookbook:: app
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'selinux::disabled'
include_recipe 'iptables::disabled'

hosts = search(:node, "*.*")

template "/etc/hosts" do
	source "hosts.erb"
	owner "root"
	group "root"
	mode "0644"
	variables( :hosts => hosts, :hostname => node[:hostname], :fqdn => node[:fqdn] )
end
