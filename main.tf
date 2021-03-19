// Configure the Google Cloud provider
provider "google" {
 credentials = file(var.gcp_cred_file)
 project     = var.gcp_project_name
 region      = var.gcp_infra_region
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}