#!/bin/bash

RUBYVERSION=2.4.1

if ruby --version | grep -q "^ruby $RUBYVERSION.*"
then
    echo "==== ruby $RUBYVERSION installed "
    exit
fi

sudo yum -y remove ruby

PACKAGES="gcc-c++ patch readline readline-devel zlib zlib-devel libyaml-devel libffi-devel openssl-devel make  bzip2 autoconf automake libtool bison iconv-devel sqlite-devel"
for p in $PACKAGES
do
    if ! rpm -q $p > /dev/null
    then
	sudo yum -y install $p
    fi
done

wget -O - https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.1.tar.gz | gzip -dc | tar -xvf -

cd ruby-$RUBYVERSION

./configure --prefix=/usr
make
sudo make install
sudo mv -n /usr/bin/ruby /usr/bin/ruby.old
sudo ln -s /usr/local/bin/ruby /usr/bin/ruby 

rm -rf ruby-$RUBYVERSION
