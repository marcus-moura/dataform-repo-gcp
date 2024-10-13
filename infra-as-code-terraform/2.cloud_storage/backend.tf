terraform {
  backend "gcs" {
    bucket  = "bkt-tcc-terraform-state"
    prefix  = "cloud_storage"
  }
 
}
