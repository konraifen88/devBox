#!/usr/bin/env bash 

# see http://stackoverflow.com/questions/31205438/docker-on-windows-boot2docker-certificate-signed-by-unknown-authority-error
CERT_DIR="/vagrant/init/certificates"
DOCKER_KEY="/vagrant/init/gpgkey.asc"

if [ "$(ls -A $CERT_DIR)" ]; then
	echo "### install certificates ###"
    mkdir -p /etc/docker/certs.d/
	cp $CERT_DIR/* /etc/docker/certs.d/
	cp $CERT_DIR/* /usr/local/share/ca-certificates/
	update-ca-certificates
else
    echo "No Certificates found!"
	echo "If download fails pleas check HOWTO.md under <project_dir>/init/certificates/"
fi



# Downloaded key from http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xF76221572C52609D directly
if [ -f $DOCKER_KEY ]; then
	echo "### install keyfile ###"
	apt-key add $DOCKER_KEY
else
	echo "No key-file was found."
	echo "You can download it from:"
	echo "http://pgp.mit.edu/pks/lookup?op=get&options=mr&search=0x58118E89F3A912897C070ADBF76221572C52609D"
	echo "if the following commands will fail."
	echo "Simply download it and place it to: <project_dir>/init/gpgkey.asc"
fi
