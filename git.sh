#!/bin/bash

REPO="linux-config-aws"
USER=MichaelDeCorte

git init
git config --global user.email mdecorte.decorte+github@gmail.com 
git config --global user.name "$USER"
git config --global push.default simple

# setup rsa key authentication

if [ ! -e ~/.ssh/github.com ]
then
    echo "**** ~/.ssh/github.com missing****"
    exit 1
fi

chmod 400 ~/.ssh/github.com

if ! grep -q github.com ~/.ssh/config
then
cat <<EOF >> ~/.ssh/config
Host github.com
     HostName github.com
     User git
     IdentityFile ~/.ssh/github.com
EOF
chmod 644 ~/.ssh/config
fi

git remote set-url origin git@github.com:"$USER"/"$REPO".git

exit

# setup new repo

echo "# $REPO" > README.md
git add README.md
git remote add origin https://github.com/$USER/"$REPO".git
git commit -m "first commit"
git push -u origin master


exit

# don't use ssh.  save id and pw
git config credential.helper store
