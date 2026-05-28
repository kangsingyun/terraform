output "vpc_id" {
  value = aws_vpc.main.id
}

output "az_names" {
  value = local.az_names
}

output "public_subnet_ids" {
  value = [for item in aws_subnet.publics : item.id]
}

output "private_subnet_ids" {
  value = [for item in aws_subnet.privates : item.id]
}
