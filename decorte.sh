#!/bin/bash

PACKAGES=emacs

for p in $PACKAGES
do
    if ! rpm -q $p > /dev/null
    then
	sudo yum install $p
    fi
done

if ! grep -q MRD $HOME/.bashrc 
then
cat <<EOF >> $HOME/.bashrc
# MRD
# turn off programmable  auto completion
complete -r

PS1='\n\u@\e[0;36m\h\e[0m:\w\n$ '

alias ls='ls -FC'
PATH=$HOME/bin:$PATH
EOF
fi
