#!/bin/bash

VERSION=0.9.2


if [ ! -e /opt/terraform ]
then
    wget https://releases.hashicorp.com/terraform/"$VERSION"/terraform_"$VERSION"_linux_amd64.zip -O /tmp/terraform.zip

    sudo mkdir -p /opt/terraform

    cd /opt/terraform
    sudo unzip /tmp/terraform.zip
    rm /tmp/terraform.zip
fi


