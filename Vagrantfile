
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/impish64"
  config.vm.define "master" do | w |
      w.vm.hostname = "master"
      w.vm.network "private_network", ip: "192.168.33.13"
      w.vm.provider "virtualbox" do |vb|
        vb.memory = "12096"
        vb.cpus = 2
        vb.name = "master"
      end
      for i in 9000..9050
          w.vm.network :forwarded_port, guest: i, host: i
      end
      w.vm.network :forwarded_port, guest: 80, host: 9090
      w.vm.network :forwarded_port, guest: 8080, host: 9080
      w.vm.network :forwarded_port, guest: 443, host: 9443
      w.vm.network :forwarded_port, guest: 6443, host: 9643

      w.vm.provision "file", source: "~/.ssh", destination: "~/.ssh"
      w.vm.provision "setup-k8s-setup-master", :type => "shell", :path => "k8s-setup-master.sh"
      w.vm.provision "setup-helm", :type => "shell", :path => "setup-helm.sh"
      w.vm.provision "setup-gcloud", :type => "shell", :path => "setup-gcloud.sh"
      w.vm.provision "setup-minikube", :type => "shell", :path => "setup-minikube.sh"
      w.vm.provision "setup-bash-aliases", :type => "shell", :path => "setup-k8s-config.sh"
      w.vm.provision "setup-k8s-config", :type => "shell", :path => "setup-k8s-config.sh"
      #w.vm.provision "setup-helm-dashboard-k8s", :type => "shell", :path => "setup-helm-dashboard-k8s.sh"

      config.vm.synced_folder ".", "/vagrant"
      w.vm.provision "file", source: "bash_aliases", destination: "/tmp/bash_aliases"
      w.vm.provision "shell", inline: <<-SHELL
        cp /tmp/bash-aliases /home/vagrant/.bash_aliases
        chown vagrant:vagrant /home/vagrant/.bash_aliases
        cp /tmp/bash-aliases /root/.bash_aliases
        sudo cp -f /etc/kubernetes/admin.conf /vagrant/
      SHELL

      config.vm.provision "shell", inline: <<-SHELL
        apt-get update
        apt-get install -y git wget curl nano
       SHELL
  end

  config.vm.box = "ubuntu/impish64"
    config.vm.define "worker-1" do | w |
        w.vm.hostname = "worker-1"
        w.vm.network "private_network", ip: "192.168.33.14"

        w.vm.provider "virtualbox" do |vb|
          vb.memory = "3048"
          vb.cpus = 2
          vb.name = "worker-1"
        end
         w.vm.provision "setup-k8s-setup-master-worker-1", :type => "shell", :path => "k8s-setup-master.sh" do |s|
       end
  end

  config.vm.box = "ubuntu/impish64"
      config.vm.define "worker-2" do | w |
          w.vm.hostname = "worker-2"
          w.vm.network "private_network", ip: "192.168.33.15"

          w.vm.provider "virtualbox" do |vb|
            vb.memory = "3048"
            vb.cpus = 2
            vb.name = "worker-2"
          end
           w.vm.provision "setup-k8s-setup-master-worker-2", :type => "shell", :path => "k8s-setup-master.sh" do |s|
         end
    end
end
