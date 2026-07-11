output "redis_endpoint" {
    description = "Redis cluster endpoint — used in REDIS_URL"
    value = aws_elasticache_cluster.main.cache_nodes[0].address 
}

output "redis_port" {
    description = "Redis cluster port — used in REDIS_URL"
    value = aws_elasticache_cluster.main.port
}

output "redis_connection_string" {
    description = "Redis cluster connection string — used in REDIS_URL"
    value = "${aws_elasticache_cluster.main.cache_nodes[0].address}:${aws_elasticache_cluster.main.port}"
}