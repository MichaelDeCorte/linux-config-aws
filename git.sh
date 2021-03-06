#!/bin/bash
set -x

USER=MichaelDeCorte
REPO="linux-config-aws"
EMAIL=mdecorte.decorte+github@gmail.com

# USER=VirtualClarity
# REPO=MigrationDirector-Analysis
# EMAIL=mdecorte.decorte@virtualclarity.com

if [ ! -e ~/.gitignore ]
then
	cat <<EOF > ~/.gitignore
*.[oa]
*~
EOF
fi

# setup rsa key authentication

if [ ! -e ~/.ssh/github.com ]
then
    echo "**** ~/.ssh/github.com missing****"
    exit 1
fi

chmod 400 ~/.ssh/github.com

touch ~/.ssh/config
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

git config --global user.email mdecorte.decorte@virtualclarity.com
git config --global user.name "$USER"
git config --global push.default simple



# check an existing repostory

if true
then
    git clone https://github.com/$USER/"$REPO".git

    cd $REPO

    git remote set-url origin git@github.com:"$USER"/"$REPO".git

fi

# setup a new repostory
if false
then
	git init

	# setup new repo

	if [ ! -f README.md ]
	then
	    echo "# $REPO" > README.md
	fi
	git add README.md

	git remote add origin https://github.com/$USER/"$REPO".git
	git remote set-url origin git@github.com:"$USER"/"$REPO".git

	git commit -m "first commit"

	git push -u origin master

fi
exit

# don't use ssh.  save id and pw
git config credential.helper store

