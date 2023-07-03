variable "bus_name" {
  type        = string
  description = "Nome do event bus"
  default     = "default"
}

variable "bucket_name" {
  type        = string
  description = "Nome da policy para a lambda"
  default     = "policy-lambda-api-user"
}

variable "bucket_prefixes" {
  type        = list(string)
  description = "Lista de identificação de subnets para a lambda poder usar a VPC"
  default     = ["AA/", "BB/"]
}
