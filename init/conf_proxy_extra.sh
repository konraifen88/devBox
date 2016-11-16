#!/usr/bin/env bash

# see http://stackoverflow.com/questions/31205438/docker-on-windows-boot2docker-certificate-signed-by-unknown-authority-error

CERT_DIR = /vagrant/init/certificates/

if [ "$(ls -A $CERT_DIR)" ]; then
	echo "### install certificates ###"
    mkdir -p /etc/docker/certs.d/
	cp /vagrant/init/certificates/* /etc/docker/certs.d/
	cp /vagrant/init/certificates/* /usr/local/share/ca-certificates/
	update-ca-certificates
else
    echo "No Certificates found!"
	echo "If download fails pleas check HOWTO.md under <project_dir>/init/certificates/"
fi


echo "### install keyfile ###"
# Downloaded key from http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xF76221572C52609D directly
apt-key add /vagrant/init/docker.key