resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%^&*()-_=+{}[]:;<>,.?~" # exclude '/', '@', '"', and space
}
