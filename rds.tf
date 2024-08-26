resource "random_password" "master_password" {
  length  = 16
  special = false
}

resource "aws_db_instance" "default" {
  identifier             = "mi-base-dato-test-instance"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "16.3"
  username               = "newuser"
  password               = random_password.master_password.result
  parameter_group_name   = aws_db_parameter_group.education.name
  skip_final_snapshot    = true
  publicly_accessible    = true
  db_name                = "mi_base_dato_test_db"
}

resource "aws_db_parameter_group" "education" {
  name   = "education-2"
  family = "postgres16"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_secretsmanager_secret" "rds_secret" {
  kms_key_id   ="arn:aws:kms:us-west-2:715841370957:key/fce7c2d0-9c98-403c-8010-a54f91db9d35"                 
  name          = "credential5-mi-base-dato-test"
  description = "credential bd"
}

resource "aws_secretsmanager_secret_version" "rds_credentials" {
  secret_id     = aws_secretsmanager_secret.rds_secret.id
  secret_string = <<EOF
{
  "Username": "${aws_db_instance.default.username}",
  "Password": "${random_password.master_password.result}",
  "Engine": "${aws_db_instance.default.engine}",
  "Host": "${aws_db_instance.default.endpoint}",
  "Port": ${aws_db_instance.default.port}
}
EOF
}