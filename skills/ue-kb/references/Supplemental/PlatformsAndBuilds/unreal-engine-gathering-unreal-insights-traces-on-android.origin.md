# 在 Android 上收集 Unreal Insights 跟踪

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/eB9R/unreal-engine-gathering-unreal-insights-traces-on-android

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1517 字符。

## 摘要

从本地 Android 设备收集 Unreal Insights 跟踪的分步演练

## 中文整理

### 概览

本教程假设您已成功将构建部署到通过 USB 连接的本地 Android 设备。请参阅 [Android 文档](https://dev.epicgames.com/documentation/en-us/unreal-engine/android-support-for-unreal-engine)，了解有关设置 Android 开发环境的信息。虽然在桌面环境中生成和检查 Unreal Insights (.utrace) 文件相当简单，但在 Android 上还需要一些额外的步骤来生成跟踪并将其传输到桌面。

### 收集痕迹

1. 创建 UECommandLine.txt 文件以指定命令行参数：

```
../../../MyProject/MyProject.uproject -tracehost=127.0.0.1 -trace=Bookmark,Frame,CPU,GPU,LoadTime,File -statnamedevents
```

2.通过adb传输UECommandLine.txt到目标设备：

```
adb push UECommandLine.txt /sdcard/Android/data/com.companyname.MyProject/files/UnrealGame/MyProject
```

确保将 com.companyname.MyProject 替换为您项目的应用程序标识符！ 3. 启用 TCP 反向以允许将跟踪传输回桌面：

```
adb reverse tcp:1980 tcp:1980
```

如果一切正常，您应该在默认跟踪目录中看到您的 Android 跟踪！

### 故障排除

如果您无法在桌面上看到 Android 痕迹，请验证您的 Android 设备是否已使用 USB 电缆插入桌面，并且 USB 调试已启用。您可以使用 adb devices 命令来验证调试是否已启用。
