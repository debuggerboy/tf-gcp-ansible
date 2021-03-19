# Terraform GCP

Create a standalone GCP Instance using Debian 10 and install Python3 and Ansible.

Pre-Steps:

- copy your GCP "json credentials" file into this directory.
- modify `vars.cf` with the name of the json credential file or pass it during invocation.
- refer the `creds/Readme.md` file and create the SSH keys

Steps:

`terraform init`

`terraform validate`

`terform plan`

`terraform apply`

Once the terraform apply is complete it should give you back the Name and IP Address details.

Sources:

- https://cloud.google.com/community/tutorials/getting-started-on-gcp-with-terraform

- https://github.com/ansible-semaphore/semaphore
