package controller

import (
	"context"
	"github.com/gogf/gf/v2/net/ghttp"
)

// Health 健康检查控制器
type Health struct{}

// Check 健康检查
func (c *Health) Check(ctx context.Context, req *struct{}) (res *struct{}, err error) {
	return nil, nil
}

// RegisterHealthRoutes 注册健康检查路由
func RegisterHealthRoutes(group *ghttp.RouterGroup) {
	group.GET("/health", new(Health).Check)
}
