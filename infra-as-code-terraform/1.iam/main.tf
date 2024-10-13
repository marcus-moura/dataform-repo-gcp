provider "google" {
  # credentials = file("sa-terraform-admin.json") # Descomentar caso precise utilizar sa json
  project     = var.project_id
  region      = var.location
}

data "google_project" "project" {
  project_id = var.project_id
}

# Define variáveis locais
locals {
  project_number               = data.google_project.project.number
  sa_prefix                    = "sa"
  sa_cloudfunctions            = "cloudfunctions"
  sa_composer                  = "composer"
  sa_dataform                  = "dataform"
  sa_github                    = "ci-github-actions"
}

# Habilita APIs necessárias.
module "project-services" {
  source                      = "terraform-google-modules/project-factory/google//modules/project_services"
  project_id                  = var.project_id
  enable_apis                 = true
  disable_services_on_destroy = true
  activate_apis = [
    "compute.googleapis.com",         # Compute Engine API
    "composer.googleapis.com",        # Cloud Composer API
    "dataform.googleapis.com",        # Dataform API
    "cloudfunctions.googleapis.com",  # Cloud Functions API
    "run.googleapis.com",             # Cloud Run API
    "secretmanager.googleapis.com",   # Secret Manager API
    "storage.googleapis.com",
    "cloudapis.googleapis.com"
  ]
}