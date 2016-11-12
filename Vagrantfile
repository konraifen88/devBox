VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.6.5"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	# not using "ubuntu/xenial64" because the ubuntu verion doesn't have enough hdd space.
	config.vm.box = "bento/ubuntu-16.04"
	config.vm.box_check_update = false
	config.vm.provider "virtualbox" do |vm|
		vm.memory = 8192
		vm.cpus = 4
	end
	
	# Setting up proxy settings, only set proxy when proxy is configured as system variable
	if Vagrant.has_plugin?("vagrant-proxyconf")
		if ENV['HTTP_PROXY']
			config.proxy.http     = ENV['HTTP_PROXY']
		elseif ENV['http_proxy']
			config.proxy.http     = ENV['http_proxy']
		end
		
		if ENV['HTTPS_PROXY']
			config.proxy.http     = ENV['HTTPS_PROXY']
		elseif ENV['https_proxy']
			config.proxy.http     = ENV['https_proxy']
		end
		
		if ENV['NO_PROXY']
			config.proxy.http     = ENV['NO_PROXY']
		elseif ENV['no_proxy']
			config.proxy.http     = ENV['no_proxy']
		end
	else
		puts "### vagrant-proxyconf plugin not installed ###"
		puts "Install with following command:"
		puts ""
		puts "vagrant plugin install vagrant-proxyconf"
		puts ""
	end
	
	# Open Ports and setting IP-address. (if you want, you can add the IP to your hosts file)
	config.vm.network :private_network, ip: "192.168.33.10"
	config.vm.network "forwarded_port", guest: 15672, host: 15672, auto_correct: true
	config.vm.network "forwarded_port", guest: 6379, host: 6379,   auto_correct: true
	config.vm.network "forwarded_port", guest: 4369, host: 4369,   auto_correct: true
	config.vm.network "forwarded_port", guest: 5672, host: 5672,   auto_correct: true
	config.vm.network "forwarded_port", guest: 8080, host: 8090,   auto_correct: true
	config.vm.network "forwarded_port", guest: 1521, host: 1521,   auto_correct: true
	
	# Add a extra synced folder, otherwise the 'docker-entrypoint-initdb.d' was empty
	config.vm.synced_folder "oracle/", "/init/oracle/"
		
	# Start docker container
	config.vm.provision "docker" do |docker|
		docker.run "redis",
			image: "redis:3.2",
			args: "-v '/var/redis/data:/data' -p '6379:6379'",
			cmd: "redis-server --appendonly yes"
		docker.run "rabbitmq",
			image: "rabbitmq:3-management",
			args: "-d --hostname my-rabbit --name some-rabbit -e RABBITMQ_DEFAULT_USER=user -e RABBITMQ_DEFAULT_PASS=password -p '15672:15672' -p '4369:4369' -p '5672:5672'"
		docker.run "oracle",
			image: "sath89/oracle-12c",
			args: "-d -p 1521:1521 -p 8080:8080 -v /init/oracle:/docker-entrypoint-initdb.d -e IMPORT_FROM_VOLUME=true"
	end

end

