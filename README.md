# TouchControl Module

TouchControl 是一个 KernelSU/Magisk 模块，用于管理模拟触摸和无障碍服务的权限。

## 功能特性

- **默认禁止所有模拟触摸**: 阻止所有应用的模拟触摸功能，仅允许硬件屏幕触摸
- **默认禁止所有无障碍服务**: 防止恶意应用滥用无障碍权限
- **可配置的应用白名单**: 可以通过 WebUI 管理界面允许特定应用使用模拟触摸和无障碍
- **现代化 WebUI 管理界面**: 类似 LSPosed 的美观界面，支持中英文自动切换
- **持久化配置**: 使用 KernelSU 内置配置系统，重启后配置不丢失

## 安装要求

- KernelSU 或 Magisk root
- Android 8.1 及以上版本

## 安装方法

1. 下载 `TouchControl-v1.0.zip`
2. 在 KernelSU 或 Magisk 管理器中刷入模块
3. 重启设备
4. 在 KernelSU 管理器中打开模块 WebUI 进行配置

## 使用说明

### WebUI 管理界面

模块安装后，在 KernelSU 管理器中点击模块即可打开 WebUI 管理界面。

界面包含两个主要标签页:

1. **模拟触摸**: 管理允许使用模拟触摸功能的应用
2. **无障碍**: 管理允许使用无障碍服务的应用

### 配置选项

- **全局开关**: 可以一键启用/禁用所有模拟触摸或无障碍功能
- **应用列表**: 显示所有已安装的第三方应用，可以单独控制每个应用的权限

### 默认行为

- 所有模拟触摸功能默认禁止
- 所有无障碍服务默认禁止
- 仅允许硬件屏幕触摸操作

## 技术实现

### KernelSU 配置系统

模块使用 KernelSU 内置的配置系统存储设置:

```bash
# 获取配置
ksud module config get allow_mock_touch
ksud module config get allow_accessibility

# 设置配置
ksud module config set allow_mock_touch true
ksud module config set allow_accessibility false
```

### 脚本执行时机

- `post-fs-data.sh`: 在系统启动早期执行，设置权限控制
- `service.sh`: 在系统完全启动后执行，提供后台服务

## 文件结构

```
TouchControlModule/
├── module.prop          # 模块配置信息
├── post-fs-data.sh      # 启动脚本
├── service.sh           # 服务脚本
└── webroot/
    └── index.html       # WebUI 管理界面
```

## 构建方法

使用提供的 PowerShell 脚本构建模块:

```powershell
.\build-module.ps1
```

输出文件: `TouchControl-v1.0.zip`

## 作者信息

- **作者**: 离不开的雨 (github@LiYv0)
- **包名**: com.LiYv.0
- **开发方式**: 模块全程 AI 开发

## 多语言支持

WebUI 管理界面自动检测系统语言:
- 中文系统 → 显示中文界面
- 英文系统 → 显示英文界面

## 注意事项

1. 模块需要 root 权限才能正常工作
2. 修改配置后可能需要重启相关应用才能生效
3. 建议仅信任的应用才允许使用模拟触摸和无障碍功能
4. 如果遇到问题，可以在 KernelSU 管理器中禁用或卸载模块

## 许可证

本模块仅供学习研究使用

## 更新日志

### v1.0.0
- 初始版本发布
- 实现模拟触摸和无障碍权限管理
- 提供 WebUI 管理界面
- 支持中英文双语
