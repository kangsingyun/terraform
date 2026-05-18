resource "aws_instance" "webs" {
  count = length(var.public_subnet_ids)


  ami           = var.ec2_web.ami
  instance_type = var.ec2_web.instance_type
  key_name      = var.key_name
  subnet_id     = var.public_subnet_ids[count.index]

  associate_public_ip_address = var.ec2_web.associate_public_ip_address

  security_groups = [
    for name in var.ec2_web.sg_names : var.sg_map[name]
  ]

  tags = {
    Name = "web-server-${count.index + 1}"

  }
}