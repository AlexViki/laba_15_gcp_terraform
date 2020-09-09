# laba 16 GCP terraform

### Install Terraform
`wget https://releases.hashicorp.com/terraform/0.13.2/terraform_0.13.2_linux_amd64.zip`

`unzip terraform*.zip`

`sudo mv terraform /bin/`

`terraform version`

### Initialization Terraform
need to go to folder with file *.tf

`terraform init`

### Command validates the configuration files in a directory
`terraform validate`

### Plan your changes
`terraform plan`

### To start a VM instance,
description characteristics of which we described in the configuration file main.tf, we use the command:
`terraform apply`

**NOTE:** Since version 0.11 terraform apply requests additional confirmation on execution. It is necessary add -auto-approve = true to disable this.

### Search for required resource attributes by state file
`terraform show | grep nat_ip`

`terraform show`

### Refresh data for outputs file
`terraform refresh`

`terraform taint google_compute_instance.name_your_instance`
`terraform taint google_compute_instance.web-srv`
Result well be: Resource instance google_compute_instance.web-srv has been marked as tainted.

### Format all config files using terraform command:
`terraform fmt`

### Resources can be destroyed using:
`terraform destroy`