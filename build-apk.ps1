#!/usr/bin/env pwsh

# TouchControl App 构建脚本
# 用于编译 Android 管理器 App

$ErrorActionPreference = "Stop"

$AppDir = "d:\BaiduNetdiskDownload\text\liyu\TouchControlApp"
$OutputDir = "d:\BaiduNetdiskDownload\text\模块"

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "TouchControl App Build Script" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# 检查 Gradle 是否存在
$gradleCmd = "gradle"
try {
    $gradleVersion = & $gradleCmd --version 2>$null
    if ($gradleVersion) {
        Write-Host "Gradle found" -ForegroundColor Green
    } else {
        throw "Gradle not found"
    }
} catch {
    Write-Host "Error: Gradle is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Gradle and try again" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "For manual build:" -ForegroundColor Cyan
    Write-Host "1. Open Android Studio" -ForegroundColor White
    Write-Host "2. Open project: $AppDir" -ForegroundColor White
    Write-Host "3. Build > Build Bundle(s) / APK(s) > Build APK(s)" -ForegroundColor White
    Write-Host ""
    exit 1
}

Set-Location $AppDir

Write-Host "Building APK..." -ForegroundColor Yellow
& $gradleCmd assembleRelease

if ($LASTEXITCODE -eq 0) {
    $apkPath = "app\build\outputs\apk\release\app-release-unsigned.apk"
    if (Test-Path $apkPath) {
        Write-Host ""
        Write-Host "Build successful!" -ForegroundColor Green
        Write-Host "APK location: $apkPath" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Note: APK needs to be signed before installation" -ForegroundColor Yellow
    } else {
        Write-Host "Build completed but APK not found" -ForegroundColor Red
    }
} else {
    Write-Host "Build failed" -ForegroundColor Red
}
