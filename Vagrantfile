# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/xenial64"

  # Create a private network, which allows host-only access to the machine using a specific IP.
  # TODO: Update IP Address & Hostname every time we create a new Vagrant Server
  config.vm.network "private_network", ip: "192.168.33.12"
  config.vm.hostname = "swiftshot"

  # Share an additional folder to the guest VM. The first argument is the path on the host to the actual folder.
  # The second argument is the path on the guest to mount the folder.
  # Also exclude our git file from uploading
  config.vm.synced_folder "./", "/var/www/html", type: "rsync",
    rsync__exclude: [".git/", "node_modules/"],
    rsync__args: ["--verbose", "--rsync-path='sudo rsync'", "--archive", "--delete", "-z"],
    :mount_options => ["dmode=777","fmode=666"]

  config.vm.provider "virtualbox" do |vb|
    #   # Display the VirtualBox GUI when booting the machine
    #   vb.gui = true
    #
    #   # Customize the amount of memory on the VM:
    vb.memory = "1524"
  end

  # Define the bootstrap file: A (shell) script that runs after first setup of your box (= provisioning)
  config.vm.provision :shell, path: "bootstrap.sh"


end
