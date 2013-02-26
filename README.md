minus
=====

# About
Minus is OpenDataDevOps's first virtual machine (aka "vm") targeted to Open Data developers, researchers, and Government data publishers.

Our immediate goal is creating a proof-of-concept "vagrant base box" demonstrating how a ready-to-run "guest" virtual computer can be easily downloaded onto a "host" laptop and be auto-configured with useful software and data.

Our long term goal is to help open data teams and projects go from zero to hero as fast as possible with a range of ready-to-run OpenData DevOps (aka "ODDO") vagrant boxes.

Minus started as an Open Data Day event on February 23, 2013 hosted at The World Bank.

# Dependencies

1. A computer onto which you can install software. (Tested on Mac, and Linux).
2. [Download & Install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
3. [Download & Install Vagrant](http://downloads.vagrantup.com/)
4. Add Vagrant Base Box (in terminal)
  `vagrant box add centos-6.3-x84_64-minimal https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box`

# Install

1. Clone out minus project `git clone git@github.com:OpenDataDevOps/minus.git`
2. Go into minus directory and boot up the vm (in terminal) `cd minus && vagrant up`
3. _If Apache configuration reports error on initial `vagrant up`, run `vagrant reload` to correct problem._
3. Get into the virtual machine (vm) via ssh `vagrant ssh`


# Use

1. `vagrant up` from the directory with this repository starts your vm and adds the correct configuration.
2. `http://localhost:8080` in your host computer browser brings up the Apache-served pages from your minus guest vm.
3. `http://localhost:8111` in your host computer browser brings up the Tomcat-served pages from your minus guest vm.

# What's Installed

- Apache2 web server and index.html page stub, so you can start serving web pages.
- Java and Tomcat, so don't need to figure out how to install Java.
- Drake (a kind of make for data), so you can define reproducable data preparation sequences.

# Other Commands

* `vagrant halt` stops the minus guest vm.
* `vagrant reload` re-runs the configuration (and applies changes in the vagrant manifest) to the minus guest vm without re-establishing the base box.
* `vagrant destroy` blows away the minus guest vm and let's you start all over again. Just. Like. That!

