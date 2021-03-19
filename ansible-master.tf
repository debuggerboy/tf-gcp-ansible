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

 metadata = {
   ssh-keys = "anish:${file("~/.ssh/id_rsa.pub")}"
 }

 provisioner "file" {
  source = "creds/ansible-ci.key"
  destination = "/home/anish/.ssh/id_rsa"

  connection {
    type = "ssh"
    user = "anish"
    host = self.network_interface.0.access_config.0.nat_ip
    private_key = file("~/.ssh/id_rsa")
    agent = "false"
  }
 }

 // Make sure ansible is installed on all new instances for later steps
 metadata_startup_script = file("${path.module}/ansible-master-install-deps.sh")

 network_interface {
   network = "default"

   access_config {
     // Include this section to give the VM an external ip address
   }
 }
}

resource "google_compute_firewall" "default" {
 name    = "ansible-firewall"
 network = "default"

 allow {
   protocol = "tcp"
   ports    = ["22"]
 }
}

// A variable for extracting the external IP address of the instance

output "ansible_master_name" {
 value = google_compute_instance.default.name
}

output "ansible_master_ip" {
 value = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
}
