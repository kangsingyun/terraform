variable "create" {
  type = string
  default = "no"
}

resource "local_file" "file1" {
    count = var.create == "yes" ? 1 : 0

  content = "안녕하세요."
  filename = "${path.module}/file1.txt"
}