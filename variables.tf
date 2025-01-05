variable "project" {}

variable "user" {}

locals {
  pubkey_path = "~/.ssh/gcloud-${var.project}.pub"
}

variable "region" {
  default = "europe-central2"
}

variable "zone" {
  default = "europe-central2-b" // Warsaw, Poland
}
