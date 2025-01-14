# 构建阶段
FROM golang:1.18-alpine AS builder

# 设置必要的环境变量
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# 设置工作目录
WORKDIR /build

# 复制依赖文件
COPY go.mod .
COPY go.sum .

# 下载依赖
RUN go mod download

# 复制源代码
COPY . .

# 编译
RUN go build -o main .

# 运行阶段
FROM alpine:latest

# 安装基础工具
RUN apk --no-cache add \
    ca-certificates \
    tzdata \
    curl \
    mysql-client \
    redis

# 设置时区
ENV TZ=Asia/Shanghai

WORKDIR /app

# 从构建阶段复制编译好的二进制文件
COPY --from=builder /build/main .
# 复制配置文件和资源文件
COPY --from=builder /build/manifest ./manifest
COPY --from=builder /build/resource ./resource

# 复制健康检查脚本
COPY manifest/docker/healthcheck.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/healthcheck.sh

# 创建日志目录
RUN mkdir -p /app/logs

# 健康检查配置
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD ["/usr/local/bin/healthcheck.sh"]

# 暴露端口
EXPOSE 8000

# 启动应用
CMD ["./main"]
