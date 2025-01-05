# Terraform settings
terraform {
  required_providers {
    google = {
      # Google provider's source
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

# Provider configuration
provider "google" {
  project = var.project
  // Check GPU availability
  region = var.region
  zone   = var.zone
}
