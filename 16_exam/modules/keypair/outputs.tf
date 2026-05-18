output "key" {
  value = {
    key_name = aws_key_pair.ssh_public_key.key_name
    openssh = tls_private_key.ssh_public_key.private_key_openssh
    algorithm = tls_private_key.ssh_public_key.algorithm
  }
}