# gcloud-deep-learning-vm

Terraform configuration for deploying Deep Learning VM on the Google Cloud.

## How to use

### Init steps

1. Create project on the Google Cloud platform.
2. Install the [Google Cloud CLI](https://cloud.google.com/sdk/docs/install-sdk) and initialize it.
3. Install [Terraform](https://developer.hashicorp.com/terraform/install)
4. **(Optional)** If you want to connect with your VM using SSH with your own SSH client instead of `gcloud compute ssh` command, use `./generate_ssh_keys.zsh` script. It will generate SSH key pair and save it in the `$HOME/.ssh` directory (public key will be added automatically to the VM during infrastructure built process).

### Build infrastructure

1. Fill [gcp.tfvars](gcp.tfvars) with necessary information
2. Run following Terraform commands
```bash
# Initializes the directory with configuration
terraform init
# Validates configuration
terraform validate
# Creates infrastructure
terraform apply
```
3. When infrastructure has been built, you can inspect its state
```bash
terraform show
```

### Connect to the VM using SSH

a. `gcloud compute ssh` command
```bash
gcloud compute ssh <vm_instance_name> --zone <vm_zone>
```
b. OpenSSH client
```bash
ssh -i ~/.ssh/<ssh_private_key> <vm_user_name>@<vm_external_ip>
```