# -*- mode: ruby -*-
# vi: set ft=ruby :

# User Variables
BOX_OS_BASE = "ubuntu/jammy64" 
BOX_NAME = "Ubuntu LTS"
BOX_CPU_COUNT = "2"
BOX_RAM_MB = "1024"
NEW_USER_NAME = "klarsen"
NEW_USER_PASSWORD = "ou812"

Vagrant.configure("2") do |config|
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  
  # Ubuntu 22.04 LTS "Jammy Jellyfish" option for base image
  config.vm.box = BOX_OS_BASE
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"    
  
  config.vm.define "proxysql" do |proxysql|
    proxysql.vm.hostname = "proxysql"
    #proxysql.vm.network "forwarded_port", guest: 6032, host: 6336
    #proxysql.vm.network "forwarded_port", guest: 6031, host: 6331
    proxysql.vm.network :public_network, :ip => "10.8.0.150", :bridge => "en6: AX88179A", :use_dhcp_assigned_default_route => true
  end
  
  sleep 10

  config.vm.define "orchestrator" do |orchestrator|
    orchestrator.vm.hostname = "orchestrator"
    #orchestrator.vm.network "forwarded_port", guest: 3000, host: 3330
    orchestrator.vm.network :public_network, :ip => "10.8.0.151", :bridge => "en6: AX88179A", :use_dhcp_assigned_default_route => true
  end

  sleep 10

  config.vm.define "primary" do |primary|
    primary.vm.hostname = "primary"
    #primary.vm.network "forwarded_port", guest: 3306, host: 3337
    primary.vm.network :public_network, :ip => "10.8.0.152", :bridge => "en6: AX88179A", :use_dhcp_assigned_default_route => true
  end

 config.vm.define "replica" do |replica|
     replica.vm.hostname = "replica"
     #replica.vm.network "forwarded_port", guest: 3306, host: 3338
     replica.vm.network :public_network, :ip => "10.8.0.153", :bridge => "en6: AX88179A", :use_dhcp_assigned_default_route => true
   end

 config.vm.define "etlreplica" do |etlreplica|
    etlreplica.vm.hostname = "etlreplica"
    #etlreplica.vm.network "forwarded_port", guest: 3306, host: 3339
    etlreplica.vm.network :public_network, :ip => "10.8.0.154", :bridge => "en6: AX88179A", :use_dhcp_assigned_default_route => true
  end

  config.vm.provider "virtualbox" do |vb|      
    #vb.name = BOX_NAME
    vb.memory = BOX_RAM_MB
    vb.cpus = BOX_CPU_COUNT
  end  
  
  sleep 20
  
  config.vm.provision "shell", inline: <<-SHELL
   apt-get update
   apt-get -y dist-upgrade
   add-apt-repository ppa:longsleep/golang-backports
   apt-get install -y bash build-essential module-assistant virtualbox-ose-guest-utils virtualbox-ext-pack
   apt-get install -y cifs-utils curl openssh-server openssh-client 
   apt-get install -y screen tree   
   apt-get install -y perl python3 python3-dev python3-pip telnet vim-common gnupg software-properties-common
   apt-get install  -y libpq-dev
   apt-get install -y golang-1.20
   apt -y install golang-go
   apt-get install -y libxt6 libxmu6
   apt-get install -y bpfcc-tools linux-headers-$(uname -r) 
   SHELL
   
  #Additional provisioning with shell script to create customized user
  config.vm.provision "shell", inline: <<-SHELL2  
    sudo su - root
    useradd -m -s /bin/bash -U #{NEW_USER_NAME}
    usermod -aG sudo #{NEW_USER_NAME}
    echo '#{NEW_USER_NAME}:#{NEW_USER_PASSWORD}' | chpasswd
    cp -pr /home/vagrant/.ssh /home/#{NEW_USER_NAME}/
    chown -R #{NEW_USER_NAME}:#{NEW_USER_NAME} /home/#{NEW_USER_NAME}
    echo '3' | update-alternatives --config editor    
    wait
    shutdown -r now
    SHELL2

    sleep 20

#    config.vm.provision "ansible" do |ansible|
#      ansible.verbose = "v"
#      ansible.playbook = "build.yml"
#      ansible.become = true
#      #ansible.compatibility_mode = "2.0"
#      ansible.raw_arguments = "-v"
#      ansible.become = true
#      #ansible.raw_arguments  = "--vault-password-file=vars/vault_pass.txt"
#    end    

end
