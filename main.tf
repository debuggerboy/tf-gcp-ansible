// Configure the Google Cloud provider
provider "google" {
 credentials = file("anish.json")
 project     = "study-299721"
 region      = "us-west1"
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}