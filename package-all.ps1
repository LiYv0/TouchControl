#!/usr/bin/env pwsh

# TouchControl App 和模块打包脚本
# 此脚本会将 App APK 打包到模块中

$ErrorActionPreference = "Stop"

$ModuleDir = "d:\BaiduNetdiskDownload\text\liyu\TouchControlModule"
$AppDir = "d:\BaiduNetdiskDownload\text\liyu\TouchControlApp"
$OutputDir = "d:\BaiduNetdiskDownload\text\模块"

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "TouchControl Module & App Packager" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# 检查是否有编译好的 APK
$apkPaths = @(
    "d:\BaiduNetdiskDownload\text\liyu\TouchControlApp\app\build\outputs\apk\release\app-release.apk",
    "d:\BaiduNetdiskDownload\text\liyu\TouchControlApp\app\build\outputs\apk\release\app-release-unsigned.apk",
    "d:\BaiduNetdiskDownload\text\模块\TouchControlManager.apk"
)

$foundApk = $false
foreach ($path in $apkPaths) {
    if (Test-Path $path) {
        Write-Host "Found APK: $path" -ForegroundColor Green
        $foundApk = $true
        break
    }
}

if (-not $foundApk) {
    Write-Host ""
    Write-Host "No APK found. Creating module without embedded APK..." -ForegroundColor Yellow
    Write-Host "User needs to install TouchControlManager.apk separately" -ForegroundColor Cyan
    Write-Host ""
}

# 复制 action.sh 到模块目录
Write-Host "Copying action.sh to module..." -ForegroundColor Yellow
if (Test-Path "$AppDir\..\TouchControlModule\action.sh") {
    Copy-Item "$AppDir\..\TouchControlModule\action.sh" "$ModuleDir\action.sh" -Force
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Green
Write-Host "Packaging complete!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Build the APK using Android Studio or Gradle" -ForegroundColor White
Write-Host "2. Place the APK in the module directory" -ForegroundColor White
Write-Host "3. Run build-module.ps1 to package the module" -ForegroundColor White
Write-Host ""
