variable "project_id" {
  description = "ID do projeto onde os datasets serão criados."
  type        = string
}

variable "prefix" {
  description = "Prefixo utilizado em todas as services accounts."
  type        = string
}

variable "service_accounts" {
  description = "Lista de contas de serviço e suas respectivas funções"
  type        = list(object({
    account_id    = string
    display_name  = string
    description   = string
  }))
}