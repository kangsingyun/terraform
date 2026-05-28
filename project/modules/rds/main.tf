resource "aws_db_subnet_group" "board" {
    name = "group-${var.db_subnet_group}"
    description = "${var.db_subnet_group}DB Subnet Group"
    subnet_ids = var.private_subnet_ids
}
resource "aws_db_parameter_group" "board" {
  name = "parameter-${var.db_parameter_group.name}"
  description = "${var.db_parameter_group.name} DB parameter-Group"
  family = var.db_parameter_group.family
  dynamic "parameter" {
    for_each = var.db_parameter_group.parameters
    content {
      name = parameter.key
      value = parameter.value
    }
  }
  parameter {
    name = "time_zone"
    value = "Asia/Seoul"
  }
  parameter {
    name = "character_set_database"
    value = "utf8mb4"
  }
}
resource "aws_db_instance" "board" {
  engine = var.rds_mariadb.engine
  engine_version = var.rds_mariadb.engine_version
  identifier = var.rds_mariadb.identifier

  username = var.rds_mariadb.username
  password = var.rds_mariadb.password

  instance_class = var.rds_mariadb.instance_class
  storage_type = var.rds_mariadb.storage_type
  allocated_storage = var.rds_mariadb.allocated_storage

  multi_az = var.rds_mariadb.multi_az
  network_type = var.rds_mariadb.network_type
  publicly_accessible = var.rds_mariadb.publicly_accessible

  skip_final_snapshot = var.rds_mariadb.skip_final_snapshot
  deletion_protection = var.rds_mariadb.deletion_protection
  vpc_security_group_ids = [for name in var.rds_mariadb.sg_names: var.sg_map[name]]

  db_subnet_group_name = aws_db_subnet_group.board.name
  parameter_group_name = aws_db_parameter_group.board.name

}