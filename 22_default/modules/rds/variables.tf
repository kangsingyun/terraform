variable "run_db_init" {
  description = "DB 초기화 실행여부: 0 - 실행X  1 - 실행O"
  type = number
}
variable "private_subnet_ids" {
  description = "AWS VPC 사설 서브넷 IDs"
  type = list(string)
}
variable "public_subnet_ids" {
  description = "AWS VPC 공인 서브넷 IDs"
  type = list(string)
}
variable "sg_map" {
  description = "보안 그룹 맵"
  type = map(string)
}
variable "rds_mariadb" {
  description = "RDS Mariadb 정보"
  type = object({
    engine = string
    engine_version = string
    identifier = string
    username = string
    password = string
    instance_class = string
    storage_type = string
    allocated_storage = number
    multi_az = bool
    network_type = string
    publicly_accessible = bool
    skip_final_snapshot = bool
    deletion_protection = bool
    sg_names = list(string)
  })
}