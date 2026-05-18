# sg id만 map으로 출력
output "sg_ids" {
  value = [ for k, v in aws_security_group.sg_map : v.id ]
}

# sg 전체 정보 map으로 출력
output "sg_map" {
  value = { for k, v in aws_security_group.sg_map : k => v.id }
}