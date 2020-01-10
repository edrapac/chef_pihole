# chef_pihole
## Chef repo to provision PiHole DNS on RaspberryPi

### What does it do?
##### This repo is meant for a rapid provisioning of a RaspberryPi and PiHole DNS

### Summary of services installed


### Dependencies
* A running Chef Server or cloud Chef Server instance
* A chef Workstation w/ChefDK and Chef installed

### Usage
![Workstation-Server-Node](img/workstation-server-node.png)

The above configuration is how we will start out, with your local development environment as the workstation, a cloud hosted instance of Chef as the server and the RaspberryPi as the node.

To get started, you will need a <b>Linux/Unix</b> dev env that is supported by Chef (I recommend Ubuntu or Debian). Whether that means you are running Linux locally as your main OS, in a VM, or in a Docker container that is up to you, <b>macOS is also totally fine</b>.

* <b>A note about VMs:</b> If you choose to have your workstation as a VM, to make the process as simple as possible when configuring networking settings, have the VM in a bridged adapter mode. The VM will then be seen as a logical host on your network with an IP address independent of your physical machine

#### Setting up the Chef Server 
For sake of simplicity this we will set up a hosted chef-server instance.

1. Navigate to https://manage.chef.io/signup/
2. Create a new account and sign up for a free hosted version of chef-server (free up to 5 nodes)
3. Create an orginization https://manage.chef.io/

For now this is all we need to do with the chef server, we will revisit it soon though.

#### Setting up the Chef Workstation
1. Install Chef (and most importantly knife) on your workstation. The commands for this vary 

    <b>macOS</b>
    `brew cask install chef/chef/chef-workstation`

    <b>Ubuntu/Debian</b>

