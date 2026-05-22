data "aws_ami" "al2023_x86" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["al2023-ami-2023.*-kernel-6.1-x86_64"]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_db_subnet_group" "board" {
    name = "group-database-board"
    description = "Test Board DB Group"
    subnet_ids = var.private_subnet_ids
}
resource "aws_db_parameter_group" "board" {
    name = "para-board"
    description = "board DB parameter-map"
  family = "mariadb10.11"
  parameter {
    name = "time_zone"
    value = "Asia/Seoul"
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
resource "aws_instance" "db_init" {
  count = var.run_db_init
  ami = data.aws_ami.al2023_x86.id
  instance_type = "t3.micro"
  subnet_id = var.public_subnet_ids[0]
  key_name = "terraform-ed25519-key"
  security_groups = [var.sg_map["remote"],var.sg_map["out"]]
  iam_instance_profile = "role-ec2-access-s3"
  user_data = file("../../project/files/db_script.sh")
  instance_initiated_shutdown_behavior = "terminate"
  lifecycle {
    replace_triggered_by = [ aws_db_instance.board ]
  }
}