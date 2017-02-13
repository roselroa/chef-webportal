#
# Cookbook:: app
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'selinux::disabled'
include_recipe 'iptables::disabled'
