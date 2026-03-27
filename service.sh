#!/system/bin/sh

MODDIR=${0%/*}
cd "$MODDIR" || exit

# 等待系统完全启动
sleep 10

log -t TouchControl "TouchControl 服务已启动"

# 这里可以添加更多的服务逻辑
# 例如监控应用安装、动态调整权限等
