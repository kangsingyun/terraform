output "key_name" {
  value = aws_key_pair.ssh_public_key.key_name
}
output "key_filename" {
  value = local_file.private_key.filename
}

