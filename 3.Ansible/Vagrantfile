# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu1804"
  config.vm.define "ab-haproxy" do |ab-haproxy|
    ab-haproxy.vm.provider :virtualbox do |v|
      v.name = "nginxserver"
      v.memory = "1024"
      v.cpus = "1"
    end
    ab-haproxy.vm.hostname = "ab-haproxy"
    ab-haproxy.vm.network "forwarded_port", guest: 80, host: 8080
    nginxserver.vm.provision "ansible" do |nginx|
            nginx.playbook = "provisioning/configure_nginx.yml"
        end
end
