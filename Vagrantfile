Vagrant.configure(2) do |config|

  config.vm.box = "centos65-x86_64"
  config.vm.hostname = "centos65"

  config.vm.network "forwarded_port", guest: 3000, host: 8000
  config.vm.network "private_network", ip: "192.168.33.34"
  config.vm.provider :virtualbox do |vb|
    vb.memory = 2048
  end
end
