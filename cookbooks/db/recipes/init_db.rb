# Need to be cleaned up.

mysql = data_bag_item('passwords','mysql')
webapp = data_bag_item('passwords','webapp')

execute 'create-db' do
	command "mysqladmin create webportal"
	action :run
	not_if do ::File.exists?('/var/tmp/webportal_init_db.lock') end
end

execute 'create-user' do
	command "mysql mysql -e \"grant all on webportal.* to \'webapp\'@\'%\' identified by \'#{webapp[node.chef_environment]}\'\""
	action :run
	not_if do ::File.exists?('/var/tmp/webportal_init_db.lock') end
end

execute 'reload-priv' do
	command "mysqladmin flush-privileges"
	action :run
	not_if do ::File.exists?('/var/tmp/webportal_init_db.lock') end
end

cookbook_file '/tmp/db_schema.sql' do
	source 'db_schema.sql'
	not_if do ::File.exists?('/var/tmp/webportal_init_db.lock') end
end

execute 'load-schema' do
	command "mysql webportal < /tmp/db_schema.sql"
	action :run
	not_if do ::File.exists?('/var/tmp/webportal_init_db.lock') end
end

file '/var/tmp/webportal_init_db.lock' do
	content 'db is ready'
	owner 'root'
	group 'root'
	mode '0600'
end
