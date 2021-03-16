// A single Compute Engine instance
resource "google_compute_instance" "default" {
 name         = "master-${random_id.instance_id.hex}"
 machine_type = "f1-micro"
 zone         = "us-west1-a"

 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-10"
   }
 }

// Make sure flask is installed on all new instances for later steps
 metadata_startup_script = "sudo echo 'deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main' > /etc/apt/sources.list.d/ansible-debian.list 2>/dev/null; sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367; sudo apt-get update; sudo apt-get install -yq python3 python3-pip python3-venv ansible"

 network_interface {
   network = "default"

   access_config {
     // Include this section to give the VM an external ip address
   }
 }
}