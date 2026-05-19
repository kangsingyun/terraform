variable "file_name" {
  type = string
  default = "step0.txt"
}
resource "local_file" "step6" {
    content = "lifecycle - step 8"
    filename = var.file_name
    lifecycle {
      precondition {
        condition = var.file_name == "step0.txt"
        error_message = "파일명이  'step0.txt'와 일치하지 않습니다."
      }
    }
}
resource "local_file" "step7" {
    content = ""
    filename = "${path.module}/step7.txt"
    lifecycle {
      postcondition {
        condition = self.content == ""
        error_message = "'step7.txt' 파일의 내용이 비어있지 않습니다."
      }
    }
}
data "aws_availability_zones" "name" {
  
}
resource "local_file" "abc" {
  content  = "lifecycle - step 1"
  filename = "${path.module}/abc.txt"
  lifecycle {
    prevent_destroy = true
  }
}
resource "local_file" "def" {
  content  = "lifecycle - step 8"
  filename = "${path.module}/dedg.txt"
  lifecycle {
    prevent_destroy = false
    ignore_changes = [  filename ]
  }
}