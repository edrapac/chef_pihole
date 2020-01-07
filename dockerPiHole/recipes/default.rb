# Install docker

bash 'install_docker' do
  code <<-EOH
    curl -sSL https://get.docker.com | sh
    EOH
end

# Install dependencies for docker-compose
bash 'install_requirements' do
  code <<-EOH
    sudo apt-get install -y libffi-dev libssl-dev python python-pip
    sudo apt-get remove python-configparser
    EOH
end

# Install docker-compose
bash 'install_docker' do
  code <<-EOH
    sudo pip install docker-compose 
   	EOH
end