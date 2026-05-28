variable "subnet_ids" {
  description = "AWS VPC 서브넷 IDs"
  type        = list(string)
}
variable "sg_map" {
  description = "보안 그룹 맵"
  type        = map(string)
}
variable "cache_valkey" {
  type = object({
    engine               = string
    major_engine_version = string
    name                 = string
    description          = string
    sg_names             = list(string)
    cache_usage_limits = object({
      data_storage = object({
        minimum = number
        maximum = number
        unit    = string
      })
      ecpu_per_second = object({
        minimum = number
        maximum = number
      })
    })
  })
}