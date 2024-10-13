terraform {
  backend "gcs" {
    bucket  = "bkt-tcc-terraform-state"
    prefix  = "iam"
  }
}
