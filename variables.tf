variable "project" {}

variable "user" {}

variable "vm_name" {
  default = "deep-learning-vm"
}

variable "region" {
  default = "europe-central2"
}

variable "zone" {
  default = "europe-central2-b" // Warsaw, Poland
}

variable "machine_type" {
  default = "n1-standard-1" # 1vCPU, 3.75GBmem, more machines are defined here: https://cloud.google.com/compute/docs/general-purpose-machines#n1_machine_types
}

variable "image" {
  default = "projects/deeplearning-platform-release/global/images/family/tf-ent-latest-gpu" # Available images: https://cloud.google.com/deep-learning-vm/docs/images
}

variable "disk_size" {
  default = "100"
}

variable "disk_type" {
  default = "pd-ssd"
}

variable "gpu_type" {
  default = "nvidia-tesla-t4"
}

variable "gpu_count" {
  default = 1  # Google Cloud project qouta needs to allow GPUs
}

locals {
  pubkey_path = "~/.ssh/gcloud-${var.project}.pub"
}
