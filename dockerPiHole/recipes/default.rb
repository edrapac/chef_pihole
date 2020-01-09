# Install docker

bash 'install_docker' do
  code <<-EOH
    curl -sSL https://get.docker.com | sh
    EOH
    not_if { ::File.exist?('/usr/bin/docker') }
end

# Install dependencies for docker-compose
bash 'install_requirements' do
  code <<-EOH
    sudo apt-get install -y libffi-dev libssl-dev python3 python3-pip python3-dev python-all-dev python-wheel git
    sudo apt-get remove -y python-configparser
    EOH
end

# Install docker-compose
bash 'pip_install_docker_compose' do
  code <<-EOH
    sudo -H pip3 -v install --no-cache-dir docker-compose 
   	EOH
   	not_if { ::File.exist?('/usr/local/bin/docker-compose') }
end

# Clone the PiHole docker repo
bash 'clone_pihole' do
  cwd '/home/pi/'
  code <<-EOH
    git clone https://github.com/pi-hole/docker-pi-hole.git piHole
    EOH
end

#Start piHole, please note on first run pulling and extracting the required containers can take ~10 mins
bash 'start_pihole' do
  cwd '/home/pi/piHole/'
  code <<-EOH
    sudo docker-compose -f docker-compose.yml up -d && sudo docker logs pihole | grep random
    EOH
end

# Optional, you can comment out the code below this line
# Set bash profile to cool ParrotOS theme
bash 'modify_bashrc' do
	code <<-EOH
	  sudo cp ~/.bashrc ~/.bashrc.bak
	  sudo curl https://gist.githubusercontent.com/rickdaalhuizen90/d1df7f6042494b982db559efc01d9557/raw/488d28c1b614617025b6dc9d8da1075eedb892d4/.bashrc > ~/.bashrc
	  sudo source ~/.bashrc
	  EOH
end