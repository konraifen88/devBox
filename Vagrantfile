VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.6.5"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	# Common Setup
	#config.vm.box = "ubuntu/xenial64"
	config.vm.box = "bento/ubuntu-16.04"
	config.vm.box_check_update = false
	config.vm.provider "virtualbox" do |vm|
		vm.memory = 8192
		vm.cpus = 4
	end
	
	config.vm.network :forwarded_port, guest: 15672, host: 15672, auto_correct: true
	config.vm.network :forwarded_port, guest: 6379, host: 6379,   auto_correct: true
	config.vm.network :forwarded_port, guest: 4369, host: 4369,   auto_correct: true
	config.vm.network :forwarded_port, guest: 5672, host: 5672,   auto_correct: true
	config.vm.network :forwarded_port, guest: 8080, host: 8090,   auto_correct: true
	config.vm.network :forwarded_port, guest: 1521, host: 1521,   auto_correct: true
	
	config.vm.network :private_network, ip: "192.168.33.10"
	
	config.vm.synced_folder "oracle/", "/init/oracle/"
	
#	# Setting up synced folder
#	config.vm.synced_folder "../", "/home/vagrant/projects"
#	config.ssh.forward_agent = true
#	
#	# Run startup script (optional)
#	config.vm.provision "shell", path: "provision.sh", privileged: false
	
	# Start docker container
	config.vm.provision "docker" do |docker|
		docker.run "redis",
			# See https://github.com/mitchellh/vagrant/issues/7348
			image: "redis:3.2",
			args: "-v '/var/redis/data:/data' -p '6379:6379'",
			cmd: "redis-server --appendonly yes"
		docker.run " rabbitmq",
			image: "rabbitmq:3-management",
			args: "-d --hostname my-rabbit --name some-rabbit -e RABBITMQ_DEFAULT_USER=user -e RABBITMQ_DEFAULT_PASS=password -p '15672:15672' -p '4369:4369' -p '5672:5672'"
		docker.run "oracle",
			image: "sath89/oracle-12c",
			args: "-d -p 1521:1521 -p 8080:8080 -v /init/oracle:/docker-entrypoint-initdb.d -e IMPORT_FROM_VOLUME=true"
	end

end

