# cria um bucket s3 para teste de recebimento de arquivo
resource "aws_s3_bucket" "bucket" {
  bucket = "flc-receive"
}

# bloqueia o acesso publico ao bucket de recepção
resource "aws_s3_bucket_public_access_block" "bucket_public_block" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# configura o bucket para envio de notificações para o eventbridge
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket      = aws_s3_bucket.bucket.id
  eventbridge = true
}
