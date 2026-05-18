resource "tls_private_key" "ssh_public_key" {
  algorithm = var.algorithm
  rsa_bits = var.rsa_bits
}
resource "aws_key_pair" "ssh_public_key" {
    public_key = tls_private_key.ssh_public_key.public_key_openssh
    key_name = "terraform-${lower(var.algorithm)}-key"
}