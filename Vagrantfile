Vagrant.configure(2) do |config|

  config.vm.box = "centos65-x86_64"
  # config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v6.5.1/centos65-x86_64-20131205.box"
  config.vm.hostname = "centos65"

  config.vm.network "forwarded_port", guest: 3000, host: 8000
  config.vm.network "private_network", ip: "192.168.33.34"
  config.vm.provider :virtualbox do |vb|
    vb.memory = 2048
  end
end
