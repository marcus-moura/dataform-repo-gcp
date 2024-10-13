resource "google_service_account" "service_accounts" {
    project      = var.project_id

    for_each = { for sa in var.service_accounts : sa.account_id => sa }
    account_id   = "${var.prefix}-${each.value.account_id}"
    display_name = "${var.prefix}-${each.value.display_name}"
    description = each.value.description
}
