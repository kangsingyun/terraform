resource "aws_instance" "webs" {
    count = var.web.count
    subnet_id = var.public_subnet_ids[count.index % length(var.public_subnet_ids)]
/*     security_groups = [
        for name in var.web.sg_names:
        var.sg_map[name]
    ] */
    vpc_security_group_ids = [
        for name in var.web.sg_names:
        var.sg_map[name]
    ]
    launch_template {
      id = var.lt_web_id
      version = "$Latest"
    }
    tags = {
      Name = "ec2-web-${count.index + 1}"
    }
}