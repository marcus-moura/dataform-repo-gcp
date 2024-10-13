resource "google_bigquery_dataset" "dataset" {
  project      = var.project_id
  location     = var.location

  for_each = { for dataset in var.datasets : dataset.dataset_id => dataset }
  dataset_id    = each.value.dataset_id
  friendly_name = each.value.dataset_id
  description   = each.value.description
  labels        = each.value.labels
}
