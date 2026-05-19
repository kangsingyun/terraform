terraform {
  required_providers {
    local = {
      version = "~> 2.0.0"
    }
  }
}
locals {
  key1 = "value1"
  num1 = 123
  text = <<EOF
  여러행으로
  만들어진
  변수
  EOF
}
resource "local_file" "files" {
  count    = 10
  content  = "${local.text}"
  filename = "${path.module}/file${count.index + 10}.txt"
}
