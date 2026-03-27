# TouchControl 项目

## 项目概述

TouchControl 是一个 KernelSU/Magisk 模块 + Android 管理器 App 组合，用于管理模拟触摸和无障碍服务的权限。

**特性**:
- ✅ 默认禁止所有模拟触摸和无障碍服务
- ✅ 仅允许硬件屏幕触摸操作
- ✅ 可配置的应用白名单
- ✅ 独立的 Android 管理器 App
- ✅ 支持广播跳转打开管理界面
- ✅ 自动中英文切换

## 文件位置

### 模块文件
- **位置**: `d:\BaiduNetdiskDownload\text\模块\`
  - `TouchControl-signed.zip` - 已签名的模块（可直接刷入）
  - `build-module.ps1` - 模块打包脚本
  - `sign-module.ps1` - 模块签名脚本

### 源代码
- **模块源码**: `d:\BaiduNetdiskDownload\text\liyu\TouchControlModule\`
  - `module.prop` - 模块配置
  - `post-fs-data.sh` - 启动脚本
  - `service.sh` - 服务脚本
  - `action.sh` - 自定义操作脚本（支持打开管理器）
  - `webroot/index.html` - WebUI（备用）

- **App 源码**: `d:\BaiduNetdiskDownload\text\liyu\TouchControlApp\`
  - 完整的 Android Studio 项目
  - 包含所有 Java 代码和资源文件

## 安装步骤

### 1. 构建管理器 App

**方法 A: 使用 Android Studio**
```
1. 打开 Android Studio
2. 打开项目：d:\BaiduNetdiskDownload\text\liyu\TouchControlApp
3. Build > Build Bundle(s) / APK(s) > Build APK(s)
4. 获取 APK: app/build/outputs/apk/release/app-release.apk
```

**方法 B: 使用 Gradle 命令行**
```powershell
cd d:\BaiduNetdiskDownload\text\liyu\TouchControlApp
gradle assembleRelease
```

### 2. 签名 APK（可选）

如果 APK 未签名，使用以下命令签名：
```bash
apksigner sign --ks my-release-key.keystore --out TouchControlManager-signed.apk app-release.apk
```

### 3. 安装管理器 App

```bash
adb install TouchControlManager.apk
```

### 4. 刷入模块

1. 将 `TouchControl-signed.zip` 刷入 KernelSU 或 Magisk
2. 重启设备

### 5. 打开管理器

**方式 1**: 点击 App 图标打开

**方式 2**: 在 KernelSU 模块管理器中点击"打开"按钮

**方式 3**: 通过 ADB 广播
```bash
adb shell am broadcast -a com.LiYv._0.OPEN_MANAGER
```

## 使用说明

### 主界面功能

1. **状态栏**: 显示模块运行状态
2. **信息卡片**: 功能说明
3. **全局设置**:
   - 允许模拟触摸（总开关）
   - 允许无障碍服务（总开关）
4. **应用列表**:
   - 模拟触摸标签页：管理允许使用模拟触摸的应用
   - 无障碍标签页：管理允许使用无障碍服务的应用

### 配置说明

- **默认状态**: 所有功能默认禁用
- **配置保存**: 使用 KernelSU 配置系统，重启不丢失
- **配置命令**:
  ```bash
  # 查看配置
  ksud module config get allow_mock_touch
  ksud module config get allow_accessibility
  
  # 修改配置
  ksud module config set allow_mock_touch true
  ksud module config set allow_accessibility false
  ```

## 技术细节

### 包名
- **管理器 App**: `com.LiYv._0`
- **模块 ID**: `com.LiYv.0`

### 广播支持

| 广播动作 | 说明 |
|---------|------|
| `com.LiYv._0.OPEN_MANAGER` | 打开管理器界面 |
| `com.LiYv._0.REFRESH_CONFIG` | 刷新配置 |

### 权限要求

- `ACCESS_SUPERUSER` - Root 权限
- `QUERY_ALL_PACKAGES` - 获取已安装应用列表

### 多语言支持

App 自动检测系统语言并切换：
- 中文系统 → 中文界面
- 英文系统 → 英文界面

## 文件结构

```
d:\BaiduNetdiskDownload\text\
├── 模块/
│   ├── TouchControl-signed.zip      # 已签名模块
│   ├── build-module.ps1             # 打包脚本
│   └── sign-module.ps1              # 签名脚本
│
└── liyu/
    ├── TouchControlModule/          # 模块源码
    │   ├── module.prop
    │   ├── post-fs-data.sh
    │   ├── service.sh
    │   ├── action.sh
    │   └── webroot/
    │       └── index.html
    │
    ├── TouchControlApp/             # App 源码
    │   ├── app/src/main/
    │   │   ├── java/com/LiYv/_0/
    │   │   │   ├── MainActivity.java
    │   │   │   └── ModuleReceiver.java
    │   │   ├── res/
    │   │   │   ├── layout/
    │   │   │   ├── drawable/
    │   │   │   ├── values/
    │   │   │   └── values-zh/
    │   │   └── AndroidManifest.xml
    │   ├── build.gradle
    │   └── README.md
    │
    └── README.md                    # 总说明文档
```

## 故障排除

### 管理器无法打开
1. 确保已安装管理器 App
2. 确保已授予 Root 权限
3. 检查 KernelSU 是否正常工作

### 配置无法保存
1. 确保模块已正确安装
2. 检查 ksud 命令是否可用
3. 重启设备后重试

### 应用列表为空
1. 等待应用列表加载完成
2. 确保授予了必要权限
3. 下拉刷新列表

## 作者信息

- **作者**: 离不开的雨 (github@LiYv0)
- **开发方式**: 模块全程 AI 开发
- **版本**: 1.0.0

## 许可证

本项目仅供学习研究使用
