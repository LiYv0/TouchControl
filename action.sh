#!/system/bin/sh

# KernelSU 模块 action 脚本
# 用于处理模块的自定义操作

MODDIR=${0%/*}
MODULE_ID="com.LiYv.0"

case "$1" in
    "open_manager")
        # 打开管理器 App
        echo "Opening TouchControl Manager..."
        am start -n com.LiYv._0/.MainActivity
        ;;
    "send_broadcast")
        # 发送广播打开管理器
        echo "Sending broadcast to open manager..."
        am broadcast -a com.LiYv._0.OPEN_MANAGER
        ;;
    *)
        echo "Usage: $0 {open_manager|send_broadcast}"
        exit 1
        ;;
esac
