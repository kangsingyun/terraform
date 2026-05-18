terraform {
  required_version = "~> 1.0"
  required_providers {
    local = {
      version = "~> 2.8"
    }
  }
}
resource "local_file" "files" {
    count = length(var.file_infos)
    content = var.file_infos[count.index]["content"]
    filename = var.file_infos[count.index]["filename"]
}