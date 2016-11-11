# Vagrant Docker Image

Vagrantfile to start a Vagrant box. Inside the box docker will be installed and the following services will be pulled and run:

* [Oracle-12c](https://hub.docker.com/r/sath89/oracle-12c/) of Docker-Hub user sath89
* [Redis](https://hub.docker.com/_/redis/) offical Redis image from Docker-Hub
* [RabbitMQ](https://hub.docker.com/_/rabbitmq/) offical RabbitMQ image from Docker-Hub

All init scripts for the Oracle DB can be found inside the oracle/ directory.

To start the box run

```
vagrant up
```

After some changes inside the Vagrantfile run

```
vagrant up --provision
```
