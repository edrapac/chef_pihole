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
4. <b>MAKE SURE TO SAVE YOUR PRIVATE KEY THAT WAS JUST CREATED SOMEWHERE SECURE AND EASILY ACCESSIBLE YOU WILL NEED IT</b>

For now this is all we need to do with the chef server, we will revisit it soon though.

#### Setting up the Chef Workstation
1. Install Chef (and most importantly knife) on your workstation. The commands for this vary 

    <b>macOS</b>
    
    `brew cask install chef/chef/chef-workstation`

    <b>Ubuntu/Debian</b>
    
    `apt-get install chef`

2. Install the ChefDk

    <b>macOS</b>

    Follow this guide: https://docs.chef.io/install_dk.html

    <b>Ubuntu/Debian</b>

    ```
    wget https://packages.chef.io/files/stable/chefdk/3.2.30/ubuntu/18.04/chefdk_3.2.30-1_amd64.deb

    dpkg -i chefdk_3.2.30-1_amd64.deb
    ```

#### Download your configs from your Chef Server 
1. Log back into your chef server https://manage.chef.io/
2. Go to the Administration tab, selection your new organization and click Generate Knife Config
3. Save knife.rb to ~/.chef on your Workstation
4. Save your private key you created when you registered the org also to the ~/.chef directory on your Workstation
5. Perform a quick test that your Workstation can communicate with your Chef server by running `knife ssl check`

#### Copy the dockerPiHole cookbook here to your cookbook dir
1. By default, the `knife.rb` file you downloaded will have set your cookbook path to `~/cookbooks` if that directory does not exist, create it now via `mkdir cookbooks` in your home dir
2. Now run `mv dockerPiHole/ ~/cookbooks/`
3. Now run `knife cookbook upload dockerPihole`

#### Bootstrap your RaspberryPi!
1. Finally, run the following command to bootstrap chef-client onto your RaspberryPi and run the recipe
```
knife bootstrap PI_IP_ADDRESS -t raspbian-jessie-gems.erb --ssh-user pi --ssh-password 'raspberry' --sudo --use-sudo-password --node-name 'NODE_NAME' --run-list 'recipe[dockerPiHole]'
```
