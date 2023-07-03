variable "bus_name" {
  type        = string
  description = "Nome do event bus"
  default     = "default"
}

variable "bucket_name" {
  type        = string
  description = "Nome do bucket S3 que será criado e habilitado para envio de notificações para o EventBridge"
  default     = "flc-receive"
}

variable "sns_name" {
  type        = string
  description = "Nome do tópico SNS para enviar as mensagens filtradas pelo EventBridge"
  default     = "s3-events"
}
