# Need to be cleaned up.

mysql = data_bag_item('passwords','mysql')
webapp = data_bag_item('passwords','webapp')

execute 'create-db' do
	command "mysqladmin create webportal"
end

execute 'create-user' do
	command "mysql mysql -e \"grant all on webportal.* to \'webapp\'@\'%\' identified by \'#{webapp[node.chef_environment]}\'\""
end

execute 'reload-priv' do
	command "mysqladmin flush-privileges"
end

cookbook_file '/tmp/db_schema.sql' do
	source 'db_schema.sql'
end

execute 'load-schema' do
	command "mysql webportal < /tmp/db_schema.sql"
end
