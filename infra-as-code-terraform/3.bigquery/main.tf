provider "google" {
  # credentials = file("path_sa") # Descomentar caso precise utilizar sa json
  project     = var.project_id
  region      = var.location
}

module "create_datasets" {
    source = "../modules/bigquery_create_datasets"
    project_id                  = var.project_id
    location                    = var.location
    datasets = [
    {
      dataset_id = "tcc_bronze"
      description = "Dados brutos."
      labels = {
        zone = "bronze"
      }
    },
     {
      dataset_id = "tcc_silver"
      description = "Dados tratados."
      labels = {
        zone = "silver"
      }
    },
     {
      dataset_id = "tcc_gold"
      description = "Dados agrupados para analise."
      labels = {
        zone = "gold"
      }
    },
  ]
}