#!/bin/bash

RUBYVERSION=2.4.1

if ruby --version | grep -q "^ruby $RUBYVERSION.*"
then
    echo "==== ruby $RUBYVERSION installed "
    exit
fi

PACKAGES="gcc-c++ patch readline readline-devel zlib zlib-devel libyaml-devel libffi-devel openssl-devel make  bzip2 autoconf automake libtool bison iconv-devel sqlite-devel"

wget -O - https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.1.tar.gz | gzip -dc | tar -xvf -

cd ruby-$RUBYVERSION

./configure
make
sudo make install

rm -rf ruby-$RUBYVERSION
