VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.6.5"

# Require YAML module
require 'yaml'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	# not using "ubuntu/xenial64" because the ubuntu verion doesn't have enough hdd space.
	config.vm.box = "bento/ubuntu-16.04"
	config.vm.box_check_update = true
	config.vm.provider "virtualbox" do |vm|
		vm.memory = 8192
		vm.cpus = 4
		vm.name = "devBox2"
	end
	
	unless Vagrant.has_plugin?("vagrant-vbguest")

		raise Vagrant::Errors::VagrantError.new, "\
		Plugin missing: vagrant-vbguest\n\
		Intstall with following command:\n\n\
		vagrant plugin install vagrant-vbguest"
	end
	
	# Setting up proxy settings, only set proxy when proxy is configured as system variable
	# Proxy settings have to be configured with cntlm
	host = Socket.gethostname
	if Vagrant.has_plugin?("vagrant-proxyconf")
		if ENV['HTTP_PROXY'] || ENV['http_proxy']
			config.proxy.http = "http://10.0.2.2:3128/"
		end
		if ENV['HTTPS_PROXY'] || ENV['https_proxy']
			config.proxy.https = "http://10.0.2.2:3128/"
		end
		if ENV['NO_PROXY'] || ENV['no_proxy']
			config.proxy.no_proxy  = "/var/run/docker.sock,localhost,127.0.0.1"
		end
	else
		raise Vagrant::Errors::VagrantError.new, "\
		Plugin missing: vagrant-proxyconf\
		Intstall with following command:\n\n\
		vagrant plugin install vagrant-proxyconf"
	end

	# Only run script when a proxy is set.
	if ENV['HTTP_PROXY'] || ENV['http_proxy'] || ENV['HTTPS_PROXY'] || ENV['https_proxy']
		config.vm.provision "shell", inline: "/vagrant/init/conf_proxy_extra.sh"
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
	
	# Need to install docker before adding images, that proxys will be set.
	# If not doing so, the script will fail.
	config.vm.provision "docker" do |docker|
	end
	
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

	config.vm.provision "shell", inline: "/vagrant/init/check_db.sh"
end

