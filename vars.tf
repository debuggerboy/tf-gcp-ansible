variable "gcp_cred_file" {
 type = string
 description = "Enter the name of the GCP json credentials file from root directory"
}

variable "gcp_project_name" {
 type = string
 description = "Enter the name of GCP project name"
}

variable "gcp_infra_region" {
 type = string
 description = "Enter the name of GCP Region name"
 default = "us-west1"
}

variable "ansible_slave_count" {
 type = number
 description = "Enter the number of ansible slaves needed"
 default = 2
}