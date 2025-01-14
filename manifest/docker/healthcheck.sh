#!/bin/sh

# 检查API服务是否正常响应
check_api() {
    curl -f http://localhost:8000/health || exit 1
}

# 检查MySQL连接
check_mysql() {
    mysqladmin ping -h"$MYSQL_HOST" -P"$MYSQL_PORT" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" || exit 1
}

# 检查Redis连接
check_redis() {
    redis-cli -h "$REDIS_HOST" -p "$REDIS_PORT" ping | grep -q "PONG" || exit 1
}

# 执行所有检查
check_api
check_mysql
check_redis

exit 0
