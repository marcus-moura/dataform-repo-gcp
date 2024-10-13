variable "project_id" {
  description = "ID do projeto onde os datasets serão criados."
  type        = string
}

variable "location" {
  description = "Localização onde os datasets serão criados."
  type        = string
}

variable "datasets" {
  description = "Lista de datasets a serem criados."
  type        = list(object({
      dataset_id    = string
      description   = string
      labels        = map(string)
    }))
}