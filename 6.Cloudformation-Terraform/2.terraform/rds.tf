#resource "aws_db_instance" "db" {
#  identifier = "tf-psql-db"
#  instance_class = "db.t3.micro"
#  engine = "postgres"
#  engine_version = "15.3"
#  db_subnet_group_name = aws_db_subnet_group.db-subnet-group.name
#  availability_zone = "eu-north-1a"
#  vpc_security_group_ids = [aws_security_group.db-sg.id]
#  storage_type = "gp2"
#  allocated_storage = 20
#  port = 5432
#  username = "postgres"
#  password = "postgres"
#  backup_retention_period = 7
#  skip_final_snapshot = false
#}