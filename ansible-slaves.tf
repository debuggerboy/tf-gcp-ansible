// A single Compute Engine instance
resource "google_compute_instance" "slave" {
 name         = "slave-${random_id.instance_id.hex}-${count.index}"
 machine_type = "f1-micro"
 zone         = var.gcp_infra_zone
 count        = var.ansible_slave_count

 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-10"
   }
 }

 // Make sure ansible is installed on all new instances for later steps
 metadata_startup_script = file("${path.module}/ansible-slave-install-deps.sh")
 metadata = {
   ssh-keys = "anish:${file("~/.ssh/id_rsa.pub")}"
 }

 provisioner "file" {
  source = "creds/auth_keys.pub"
  destination = "/home/anish/.ssh/authorized_keys"

  connection {
    type = "ssh"
    user = "anish"
    host = self.network_interface.0.access_config.0.nat_ip
    private_key = file("~/.ssh/id_rsa")
    agent = "false"
  }
 }

 network_interface {
   network = "default"

   access_config {
     // Include this section to give the VM an external ip address
   }
 }
}

resource "google_compute_firewall" "slave" {
 name    = "slave-firewall"
 network = "default"

 allow {
   protocol = "tcp"
   ports    = ["22", "80", "443"]
 }
}

// A variable for extracting the external IP address of the instance

output "ansible_slave_name" {
 value = google_compute_instance.slave.*.name
}

output "ansible_slave_ip" {
 value = google_compute_instance.slave.*.network_interface.0.access_config.0.nat_ip
}
