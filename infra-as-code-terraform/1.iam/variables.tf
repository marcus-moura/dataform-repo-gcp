variable "project_id" {
  type        = string
  description = "ID do Projeto"
  nullable    = false
  default     = ""
}

variable "network_project" {
  type        = string
  description = "ID do Projeto de rede"
  nullable    = false
  default     = ""
}

variable "network_project_apps" {
  type        = string
  description = "ID do Projeto de rede de Apps"
  nullable    = false
  default     = ""
}

variable "location" {
  type        = string
  description = "Região principal"
  default     = ""
  nullable    = false
}
