terraform {
  backend "gcs" {
    bucket  = "bkt-tcc-terraform-state"
    prefix  = "bigquery"
  }
}
