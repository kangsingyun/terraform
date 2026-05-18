variable "index" {
  type      = string
  default   = "<?php phpinfo(); ?>"
  sensitive = false
}
resource "local_file" "index" {
  content  = var.index
  filename = "${path.module}/index.php"
  connection {
    user        = "ec2-user"
    private_key = file("./id_ed25519")
    host        = "192.168.31.81"
  }
  provisioner "file" {
    source      = self.filename
    destination = "/tmp/index.php"

  }
}
