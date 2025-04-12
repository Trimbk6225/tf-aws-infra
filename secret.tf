resource "aws_secretsmanager_secret" "db_password_secret" {
  name       = "${var.environment}-db-password"
  kms_key_id = aws_kms_key.secrets_key.arn
  depends_on = [
    aws_kms_key.secrets_key
  ]
}

resource "aws_secretsmanager_secret_version" "db_password_secret_version" {
  secret_id = aws_secretsmanager_secret.db_password_secret.id
  secret_string = jsonencode({
    password = random_password.db_password.result
  })
}