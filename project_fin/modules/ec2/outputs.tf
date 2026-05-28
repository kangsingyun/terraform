output "instance_ids" {
  value = [
    for web in aws_instance.webs : web.id
  ]
}