# TouchControl 管理器 App 构建说明

## 项目结构

```
TouchControlApp/
├── app/
│   ├── src/
│   │   └── main/
│   │       ├── java/com/LiYv/_0/
│   │       │   ├── MainActivity.java      # 主界面
│   │       │   └── ModuleReceiver.java    # 广播接收器
│   │       ├── res/
│   │       │   ├── layout/
│   │       │   │   ├── activity_main.xml  # 主界面布局
│   │       │   │   └── item_app.xml       # 应用列表项布局
│   │       │   ├── drawable/              # 图形资源
│   │       │   ├── values/                # 英文字符串
│   │       │   ├── values-zh/             # 中文字符串
│   │       │   └── themes.xml             # 主题样式
│   │       └── AndroidManifest.xml        # 应用清单
│   ├── build.gradle                       # App 构建配置
│   └── proguard-rules.pro                 # 混淆规则
├── build.gradle                           # 项目构建配置
├── settings.gradle                        # 项目设置
└── build-apk.ps1                          # 构建脚本
```

## 构建方法

### 方法一：使用 Android Studio（推荐）

1. 打开 Android Studio
2. 选择 "Open an Existing Project"
3. 选择 `d:\BaiduNetdiskDownload\text\liyu\TouchControlApp` 目录
4. 等待 Gradle 同步完成
5. 点击菜单 `Build` > `Build Bundle(s) / APK(s)` > `Build APK(s)`
6. 生成的 APK 位置：`app\build\outputs\apk\release\app-release.apk`

### 方法二：使用命令行

1. 确保已安装 Gradle 并配置好环境变量
2. 打开 PowerShell，进入项目目录
3. 运行：`gradle assembleRelease`
4. 生成的 APK 位置：`app\build\outputs\apk\release\app-release.apk`

### 方法三：使用提供的脚本

```powershell
cd d:\BaiduNetdiskDownload\text\liyu\TouchControlApp
.\build-apk.ps1
```

## 签名 APK

生成的 APK 是未签名的，需要签名后才能安装：

```powershell
# 使用 jarsigner 签名
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore my-release-key.keystore app-release-unsigned.apk alias_name

# 或使用 apksigner（推荐）
apksigner sign --ks my-release-key.keystore --out app-release-signed.apk app-release-unsigned.apk
```

## 安装方法

### 1. 安装管理器 App

```bash
adb install TouchControlManager.apk
```

### 2. 刷入模块

1. 在 KernelSU/Magisk 中刷入 `TouchControl-v1.0.zip`
2. 重启设备

### 3. 打开管理器

- 方法一：点击 App 图标打开
- 方法二：在模块管理器中点击"打开"按钮
- 方法三：通过广播打开
  ```bash
  am broadcast -a com.LiYv._0.OPEN_MANAGER
  ```

## 功能说明

### 主界面

- **状态栏**: 显示模块运行状态
- **信息卡片**: 说明模块功能
- **全局设置**: 
  - 允许模拟触摸（总开关）
  - 允许无障碍服务（总开关）
- **应用列表**: 
  - 模拟触摸应用列表（可为每个应用单独设置）
  - 无障碍应用列表（可为每个应用单独设置）

### 多语言支持

App 会自动检测系统语言：
- 中文系统 → 显示中文界面
- 英文系统 → 显示英文界面

### 广播支持

App 支持以下广播：
- `com.LiYv._0.OPEN_MANAGER` - 打开管理器界面
- `com.LiYv._0.REFRESH_CONFIG` - 刷新配置

## 模块集成

模块的 `action.sh` 脚本支持以下命令：

```bash
# 打开管理器
action.sh open_manager

# 发送广播
action.sh send_broadcast
```

## 配置存储

所有配置通过 KernelSU 配置系统存储：

```bash
# 获取配置
ksud module config get allow_mock_touch
ksud module config get allow_accessibility
ksud module config get mock_touch_<package_name>
ksud module config get accessibility_<package_name>

# 设置配置
ksud module config set allow_mock_touch true
ksud module config set allow_accessibility false
ksud module config set mock_touch_<package_name> true
ksud module config set accessibility_<package_name> false
```

## 技术细节

### 权限要求

- `ACCESS_SUPERUSER` - Root 权限
- `QUERY_ALL_PACKAGES` - 获取已安装应用列表

### 核心功能

1. **Root 权限执行**: 通过 `su -c` 执行 ksud 命令
2. **应用列表获取**: 使用 PackageManager 获取第三方应用
3. **配置持久化**: 使用 KernelSU 配置系统
4. **广播接收**: 支持外部触发打开界面

## 故障排除

### App 无法打开

1. 确保已授予 Root 权限
2. 检查 KernelSU 是否正常工作
3. 查看 logcat 日志：
   ```bash
   adb logcat | grep TouchControl
   ```

### 配置无法保存

1. 确保 KernelSU 配置系统正常工作
2. 检查 ksud 命令是否可用
3. 确保模块已正确安装

### 应用列表为空

1. 确保授予了 `QUERY_ALL_PACKAGES` 权限
2. 等待应用列表加载完成
3. 下拉刷新列表

## 作者信息

- **作者**: 离不开的雨 (github@LiYv0)
- **包名**: com.LiYv._0
- **开发方式**: 模块全程 AI 开发

## 许可证

本模块和 App 仅供学习研究使用
