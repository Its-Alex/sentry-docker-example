# -*- mode: ruby -*-
# vi: set ft=ruby :
$logger = Log4r::Logger.new('vagrantfile')
def read_ip_address(machine)
  command =  "ip a | grep 'inet' | grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $2 }' | cut -f1 -d\"/\""
  result  = ""

  $logger.info "Processing #{ machine.name } ... "

  begin
    # sudo is needed for ifconfig
    machine.communicate.sudo(command) do |type, data|
      result << data if type == :stdout
    end
    $logger.info "Processing #{ machine.name } ... success"
  rescue
    result = "# NOT-UP"
    $logger.info "Processing #{ machine.name } ... not running"
  end

  # the second inet is more accurate
  result.chomp.split("\n").select { |hash| hash != "" }[1]
end

Vagrant.configure("2") do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  if Vagrant.has_plugin?("HostManager")    
    config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
      read_ip_address(vm)
    end
  end 

  config.vm.define :sentry do |sentry|
    sentry.vm.box = "ubuntu/bionic64"
    sentry.vm.box_version = "20210415.0.0"

    sentry.vm.disk :disk, size: "30GB", primary: true

    # Set hostname to ansible access
    sentry.vm.hostname = "sentry"
    # Disable default synced folder
    sentry.vm.synced_folder '.', '/vagrant', disabled: true
    sentry.vm.synced_folder './scripts/', '/srv/sentry/scripts'
    sentry.vm.synced_folder './sentry-onpremise/', '/srv/sentry/onpremise' 

    sentry.vm.network "private_network", type: "dhcp"

    sentry.hostmanager.aliases = %w(local.sentry.fr)

    $script = <<EOF
set -e

# Accept outgoing/ingoing connections

iptables -I INPUT -j ACCEPT
iptables -I OUTPUT -j ACCEPT

# Install docker

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y python3-pip
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    jq \
    python3-pip \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get -y update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io

# Install python3-pip and docker-compose

sudo pip3 install -U pip
sudo pip3 install -U docker-compose

EOF

    sentry.vm.provision "shell", inline: $script

    sentry.vm.provider :virtualbox do |vb|
      vb.memory = '8096'
      vb.cpus = '4'
    end

  end
end