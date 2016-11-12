VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.6.5"

# Require YAML module
require 'yaml'

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
	ports = YAML.load_file('config/ports.yml')
	ports.each do |ports|
		config.vm.network "forwarded_port", 
			guest: ports["guest"], 
			host: ports["host"], 
			auto_correct: ports["autocorrect"]
	end
	
	# Add a extra synced folder, otherwise the 'docker-entrypoint-initdb.d' was empty
	config.vm.synced_folder "oracle/", "/init/oracle/"
		
	# Start docker container
	images = YAML.load_file('config/images.yml')
	config.vm.provision "docker" do |docker|
		images.each do |images|
			docker.run images["name"],
				image: images["image"],
				args: images["args"],
				cmd: images["cmd"]
		end
	end

end

