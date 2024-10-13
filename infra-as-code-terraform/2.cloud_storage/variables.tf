variable env {
  type        = string
  description = "Ambiente de execução"
  default     = ""
  nullable    = false
}

variable "project_id" {
  type        = string
  description = "ID do Projeto"
  nullable    = false
  default     = ""
}

variable "location" {
  type        = string
  description = "Região principal"
  default     = ""
  nullable    = false
}
