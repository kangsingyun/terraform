output "instance_ids" {
  value = [for instance in aws_instance.webs : instance.id]
}


output "public_ips" {
  value = [for instance in aws_instance.webs : instance.public_ip]
}