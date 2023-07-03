# cria a regra para capturar eventos de gravação no bucket
resource "aws_cloudwatch_event_rule" "rule1_capture" {
  name           = "capture-s3-${var.bucket_name}-objectcreated"
  description    = "Captura eventos de criação de objetos no bucket"
  event_bus_name = var.bus_name
  event_pattern = jsonencode({
    detail-type = ["Object Created"]
    source      = ["aws.s3"]
    detail = {
      bucket = {
        name = [{ "prefix" : "${var.bucket_name}" }]
      }
    }
  })
}

# define o destino das mensagens capturadas
resource "aws_cloudwatch_event_target" "rule1_target" {
  event_bus_name = var.bus_name
  rule           = aws_cloudwatch_event_rule.rule1_capture.name
  target_id      = "SendToSNS"
  arn            = aws_sns_topic.sns_s3_events.arn
}
