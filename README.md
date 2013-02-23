minus
=====

# Dependencies

1. [Download & Install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Download & Install Vagrant](http://downloads.vagrantup.com/)
3. Add Vagrant Base Box (in terminal)
  `vagrant box add centos-6.3-x84_64-minimal https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box`

# Install

1. Clone out minus project `git clone git@github.com:OpenDataDevOps/minus.git`
2. Go into minus directory and boot up the vm (in terminal) `cd minus && vagrant up`
3. Get into the vm via ssh `vagrant ssh`