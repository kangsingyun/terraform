resource "aws_elasticache_serverless_cache" "main" {
  engine               = var.cache_valkey.engine
  major_engine_version = var.cache_valkey.major_engine_version
  name                 = var.cache_valkey.name
  description          = var.cache_valkey.description

  subnet_ids         = var.subnet_ids
  security_group_ids = [for name in var.cache_valkey.sg_names : var.sg_map[name]]
  cache_usage_limits {
    data_storage {
      minimum = var.cache_valkey.cache_usage_limits.data_storage.minimum
      maximum = var.cache_valkey.cache_usage_limits.data_storage.maximum
      unit    = var.cache_valkey.cache_usage_limits.data_storage.unit
    }
    ecpu_per_second {
      minimum = var.cache_valkey.cache_usage_limits.ecpu_per_second.minimum
      maximum = var.cache_valkey.cache_usage_limits.ecpu_per_second.maximum
    }
  }
}