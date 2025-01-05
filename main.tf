# Defines VM instance
resource "google_compute_instance" "vm_instance" {
  name         = "deep-learning-vm"
  machine_type = "n1-standard-1" # 1vCPU, 3.75GBmem, more machines are defined here: https://cloud.google.com/compute/docs/general-purpose-machines#n1_machine_types

  boot_disk {
    initialize_params {
      image = "projects/deeplearning-platform-release/global/images/family/tf-ent-latest-gpu" # Available images: https://cloud.google.com/deep-learning-vm/docs/images
      size  = "100"
      type  = "pd-ssd"
    }
  }

  guest_accelerator {
    type  = "nvidia-tesla-t4"
    count = 1 # Google Cloud project qouta needs to allow GPUs
  }

  network_interface {
    # VM will use defau;t VPC (Virtual Private Cloud) network
    network = "default"
    access_config {
      # external IP will be assigned in a dynamic way
    }
  }

  scheduling {
    on_host_maintenance = "TERMINATE" // Set maintenance policy to terminate
    automatic_restart   = true        // Automatically restart on failure
  }

  metadata = merge(
    {
      "install-nvidia-driver" = "true"
      "serial-port-enable"    = "true" # Enable the serial console
    },
    fileexists(local.pubkey_path) ? {
      ssh-keys = "${var.user}:${file(local.pubkey_path)}"
    } : {}
  )
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"] # Allow SSH from any IP
}
