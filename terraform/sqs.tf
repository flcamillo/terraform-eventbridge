# cria a fila sqs para simular o consumidor1 do sqs
resource "aws_sqs_queue" "sqs1" {
  name                      = "sqs-cliente1"
  receive_wait_time_seconds = 10
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.sqs1_dead.arn
    maxReceiveCount     = 4
  })
}

# cria a fila sqs de mensagens mortas do consumidor1
resource "aws_sqs_queue" "sqs1_dead" {
  name = "sqs-cliente1-dead"
}

# define a policy para uso da fila sqs do consumidor1
data "aws_iam_policy_document" "sqs1_policy_document" {
  statement {
    sid    = "SendMessage"
    effect = "Allow"
    actions = [
      "sqs:SendMessage",
    ]
    resources = [
      aws_sqs_queue.sqs1.arn
    ]
    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    }
  }
}

# define a policy na fila sqs do consumidor1
resource "aws_sqs_queue_policy" "sqs1_policy" {
  queue_url = aws_sqs_queue.sqs1.id
  policy    = data.aws_iam_policy_document.sqs1_policy_document.json
}

# cria a inscrição no tópico sns para o consumidor1
resource "aws_sns_topic_subscription" "sqs1_sub" {
  topic_arn           = aws_sns_topic.sns_s3_events.arn
  protocol            = "sqs"
  endpoint            = aws_sqs_queue.sqs1.arn
  filter_policy_scope = "MessageBody"
  filter_policy = jsonencode({
    detail = {
      bucket = {
        name = [{ "prefix" : "flc-receive" }]
      }
      object = {
        key = [{ "prefix" : "AA/" }]
      }
    }
  })
}

# cria a fila sqs para simular o consumidor2 do sqs
resource "aws_sqs_queue" "sqs2" {
  name                      = "sqs-cliente2"
  receive_wait_time_seconds = 10
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.sqs2_dead.arn
    maxReceiveCount     = 4
  })
}

# cria a fila sqs de mensagens mortas do consumidor2
resource "aws_sqs_queue" "sqs2_dead" {
  name = "sqs-cliente2-dead"
}

# define a policy para uso da fila sqs do consumidor1
data "aws_iam_policy_document" "sqs2_policy_document" {
  statement {
    sid    = "SendMessage"
    effect = "Allow"
    actions = [
      "sqs:SendMessage",
    ]
    resources = [
      aws_sqs_queue.sqs2.arn
    ]
    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    }
  }
}

# define a policy na fila sqs do consumidor2
resource "aws_sqs_queue_policy" "sqs2_policy" {
  queue_url = aws_sqs_queue.sqs2.id
  policy    = data.aws_iam_policy_document.sqs2_policy_document.json
}

# cria a inscrição no tópico sns para o consumidor2
resource "aws_sns_topic_subscription" "sqs2_sub" {
  topic_arn           = aws_sns_topic.sns_s3_events.arn
  protocol            = "sqs"
  endpoint            = aws_sqs_queue.sqs2.arn
  filter_policy_scope = "MessageBody"
  filter_policy = jsonencode({
    detail = {
      bucket = {
        name = [{ "prefix" : "flc-receive" }]
      }
      object = {
        key = [{ "prefix" : "BB/" }]
      }
    }
  })
}
