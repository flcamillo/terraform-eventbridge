# cria o tópico sns para receber as mensagens do event bridge
resource "aws_sns_topic" "sns_s3_events" {
  name = "s3-events"
}

# define a policy para uso do tópico sns permitindo apenas 
# publicação pelo eventbridge e subcribe para outras contas
# da mesma organização
data "aws_iam_policy_document" "sns_policy_document" {
  statement {
    sid    = "Publish"
    effect = "Allow"
    actions = [
      "sns:Publish",
    ]
    resources = [
      aws_sns_topic.sns_s3_events.arn
    ]
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
  statement {
    sid    = "Subscribe"
    effect = "Allow"
    actions = [
      "sns:Subscribe",
    ]
    resources = [
      aws_sns_topic.sns_s3_events.arn
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalOrgID"
      values   = [data.aws_organizations_organization.org.id]
    }
  }
}

# define a policy para o tópico sns
resource "aws_sns_topic_policy" "sns_s3_events_policy" {
  arn    = aws_sns_topic.sns_s3_events.arn
  policy = data.aws_iam_policy_document.sns_policy_document.json
}
