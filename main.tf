terraform {
  required_version = ">=0.13"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.29.0, < 5.0"
      
    }
    
    
  }
    provider_meta "google" {
    module_name = "blueprints/terraform/terraform-google-kubernetes-engine/v23.1.0"
    
  }
  
}
 terraform {
    backend "gcs" {
   # bucket  = "terrafomr-test-amit-win"
    credentials = "gs://terrafomr-test-amit-win/groovy-test.json"
  }
}

resource "google_compute_instance" "my_new_vm" {
  project = "shoptrue-gke"
  name = "terraform-instance"
  machine_type = "f1-micro"
  zone = "us-central1-a"
  allow_stopping_for_update = true
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
      }
     }
   
   
   network_interface {
    network = "default"
    access_config {
    }
   }
 
 
}
