output "cache_endpoint" {
  value = aws_elasticache_serverless_cache.main.endpoint[0]
}