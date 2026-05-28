variable "bucket" {
  default =  "s3-xxxxx-board"
  type = string
}
variable "rds_endpoint" {
    type = string
  default = "endpoint-xxxxxx"
}
variable "password" {
  type = string
  default = "123"
}
variable "file_map" {
  description = "생성될 파일 정보 맵"
  type = map(object({
    key = string
  }))
  default = {
    db_script = {
      key = "db_script.sh"
    }
    web_script = {
        key = "web_script.sh"
    }
    sql = {
        key = "db_init.sql"
    }
    config = {
        key = "config.php"
    }
  }
}
variable "database" {
  type = object({
    db_name = string
    hostname = string
    username = string
    password = string
  })
  default = {
    db_name = "test_board"
    hostname = "%"
    username = "webmaster"
    password = "123"
  }
}