
 locals {
 terraform_service_account = "tf-test@shoptrue-gke.iam.gserviceaccount.com"
}

provider "google" {
 alias = "impersonation"
 scopes = [
   "https://www.googleapis.com/auth/cloud-platform",
   "https://www.googleapis.com/auth/userinfo.email",
 ]
}
data "google_service_account_access_token" "default" {
 provider               	= google.impersonation
 target_service_account 	= local.terraform_service_account
 scopes                 	= ["userinfo-email", "cloud-platform"]
 lifetime               	= "1200s"
}

provider "google" {
 project 		= "shoptrue-gke"
 access_token	= data.google_service_account_access_token.default.access_token
 request_timeout 	= "60s"
}
resource "google_compute_instance" "my_new_vm" {
  project = "shoptrue-gke"
  name = "terraform-instance"
  machine_type = "f1-micro"
  zone = "us-central1-a"
  allow_stopping_for_update = true
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      }
     }
   
   
   network_interface {
    network = "default"
    access_config {
    }
   }
 
 
}
