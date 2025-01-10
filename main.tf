# Defines VM instance
resource "google_compute_instance" "vm_instance" {
  name         = var.vm_name
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size
      type  = var.disk_type
    }
  }

  guest_accelerator {
    type  = var.gpu_type
    count = var.gpu_count
  }

  network_interface {
    # VM will use default VPC (Virtual Private Cloud) network
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
