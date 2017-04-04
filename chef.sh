#!/bin/bash
set -e

REPO=$HOME/chef-repo

mkdir -p $REPO
mkdir -p $REPO/cookbooks
mkdir -p $REPO/roles
mkdir -p $REPO/environments

echo =========== Install Chef
if [ ! -e /opt/chefdk/bin/chef ]
then
    curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable 

fi

echo =========== Create hello world cookbooks
if [ ! -e $REPO/cookbooks/hello_world ]
then
    chef generate cookbook $REPO/cookbooks/hello_world
    cat << EOF >> $REPO/cookbooks/hello_world/recipes/default.rb
file '/tmp/hello_world' do
  content 'hello world!'
end
EOF
fi

echo =========== Config local chef
if [ ! -e $REPO/solo.rb ]
then
cat <<EOF > $REPO/solo.rb
file_cache_path "/tmp/chef-solo"
cookbook_path "/home/ec2-user/chef-repo/cookbooks"
EOF
fi

if [ ! -e $REPO/web.json ]
then
cat <<EOF > $REPO/web.json
{
    "run_list": [ "recipe[hello_world]" ]
}
EOF

fi

echo =========== Download assorted cookbooks
(
    if [ ! -e $REPO/cookbooks/apt ]
    then
	cd $REPO/cookbooks
 
	knife cookbook site download apt 
	tar zxf apt*gz
	rm apt*.tar.gz
    fi
)

echo =========== Converge locally on $(hostname) for hello_world cookbook
(
    cd $REPO
    chef-client --local-mode --runlist 'recipe[hello_world]'
    chef-solo -c solo.rb -j web.json
)


exit

############################################################

knife cookbook upload hello_world


echo =========== Install Berks
if [ ! -e /opt/chef/embedded/bin/berks ]
then
    sudo /opt/chef/embedded/bin/gem install berkshelf --no-ri --no-rdoc
    sudo ln -s /opt/chef/embedded/bin/berks /usr/local/bin/berks
fi

berks install
berks upload
