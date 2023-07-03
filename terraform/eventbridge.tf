# cria um bus para o event bridge caso não seja usado o default
resource "aws_cloudwatch_event_bus" "bus" {
  count = var.bus_name != "default" ? 1 : 0
  name = var.bus_name
}
