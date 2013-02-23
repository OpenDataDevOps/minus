minus
=====

# Install

1. [Download & Install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Download & Install Vagrant](http://downloads.vagrantup.com/)
3. Add Vagrant Base Box (in terminal)
  `vagrant box add centos-6.3-x84_64-minimal https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box`
4. Clone out minus project
  `git clone git@github.com:OpenDataDevOps/minus.git`
4. Go into minus directory and boot up the vm (in terminal)
  `cd minus && vagrant up`
5. Get into the vm via ssh
  `vagrant ssh`