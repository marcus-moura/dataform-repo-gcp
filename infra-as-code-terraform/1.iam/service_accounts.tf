# SERVICE ACCOUNT
module "service_account_with_roles" {
    source        = "../modules/iam_service_accounts"
    project_id        = var.project_id
    prefix            = local.sa_prefix
    service_accounts  = [
        {
            account_id   = local.sa_cloudfunctions
            display_name = local.sa_cloudfunctions
            description  = "SA Responsável pela operação e manutenção das Cloud Functions."
        },
        {
            account_id   = local.sa_github
            display_name = local.sa_github
            description  = "SA utlizada para executar pipelines de ci/cd no GitHub Actions."
        },
        {
            account_id   = local.sa_dataform
            display_name = local.sa_dataform
            description  = "SA utlizada para executar pipelines no dataform."
        },
        {
            account_id   = local.sa_composer
            display_name = local.sa_composer
            description  = "SA utlizada pelo cloud composer."
        },
    ]

    # Dependência da ativação das APIs
    depends_on = [module.project-services]  # Aguarda ativação das APIs antes de criar as SAs
}