# Vagrant Docker Image

Vagrantfile to start a Vagrant box. Inside the box docker will be installed and the following services will be pulled and run:

* [Oracle-12c](https://hub.docker.com/r/sath89/oracle-12c/) of Docker-Hub user sath89
* [Redis](https://hub.docker.com/_/redis/) offical Redis image from Docker-Hub
* [Redis Commander](https://hub.docker.com/r/tenstartups/redis-commander/) of Docker-Hub user tenstartups
* [RabbitMQ](https://hub.docker.com/_/rabbitmq/) offical RabbitMQ image from Docker-Hub

All init scripts for the Oracle DB can be found inside the /init/oracle/ directory.

This is the "normal" version of this repo. This can be used without proxies set or with proxies set like:

    <proxy>:<port>
    
    or
    
    <username>:<password>@<proxy>:<port>
    
If you are using cntlm to config your proxy, please chekout branch: cntlm_config 

## Needed Software

* Oracle VM Virtualbox 5.1.8 - [download](http://download.virtualbox.org/virtualbox/5.1.8/VirtualBox-5.1.8-111374-Win.exe)
* Oracle VM Extension Pack 5.1.8 - [download](http://download.virtualbox.org/virtualbox/5.1.8/Oracle_VM_VirtualBox_Extension_Pack-5.1.8.vbox-extpack)
* Vagrant 1.8.7 - [download](https://releases.hashicorp.com/vagrant/1.8.7/vagrant_1.8.7.msi)

Other versions of Virtualbox and Vagrant may run, too.

## Installation

If you are behind a cooperational proxy you may need their root certificate. 
See [HOWTO](init/certificates/HOWTO.md) for more information.

``` shell
git clone https://github.com/konraifen88/vagrant_docker.git
cd vagrant docker
# if using local proxy with cntlm do:
# git checkout cntlm_config
vagrant up
```

Vagrant should now download base image and install docker with the containers in it.
The first startup will take a very long time. Do not interrupt the process, you will get the terminal back if everything is downloaded.
When finished downloading, the database will still startup!
A script is attached to Vagrantfile which will check if the Database is fully running. 

Hint:
When this script is running, there will be a check all 5 seconds if DB is sucessfully up. But if there is a problem during setting up, the script will run infinitely, then you can break it with 'ctrl + c'.

## Usage

### Start the Box

``` shell
vagrant up
```

### Stop the Box

``` shell
vagrant halt
```

### Check docker logs

``` shell
# Vagrant have to be running
vagrant ssh
# inside devBox do:
docker ps
docker logs <ID of container, see output docker ps>
```

### Adding new data or change the box
See section 'Known Bugs' when adding data to Oracle DB

``` shell
vagrant up --provision
```

## Known Bugs

	Bug:
	When change the files init-files of the database and do a reload or provision up, the changes will not applied.
	
	Reason:
	Vagrant don't call docker run for a docker container till it's command did not change or on first setup. 
		"restart: "always""
	addition will not have any effect!
	
	Workaround:
	1. Destroy the box and restart it (the full download of docker containers have to be done!)
	2. Change oracle-args in 'images.yml'. You can add/remove a '/' at '-v /vagrant/init/oracle(/)'. For this case, the command has "changed" and it will re-run the container on provision. 