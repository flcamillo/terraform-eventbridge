# cria um bus para no event bridge
resource "aws_cloudwatch_event_bus" "bus" {
  name = "s3-events"
}
