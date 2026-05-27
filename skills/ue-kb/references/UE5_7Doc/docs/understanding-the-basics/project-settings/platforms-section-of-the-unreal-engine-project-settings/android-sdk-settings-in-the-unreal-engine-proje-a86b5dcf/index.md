---
title: "Android SDK"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/android-sdk-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "平台", "Android SDK"]
---

# Android SDK

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 平台 / Android SDK

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/android-sdk-settings-in-the-unreal-engine-project-settings

## Android SDK

### SDK配置

| **设置** | **说明** |
| --- | --- |
| **Android SDK的位置（Location of Android SDK）** | Android SDK的磁盘上位置（如果此字段为空白，则回退到 `ANDROID_HOME` 环境变量）。 该目录通常包含 `android-sdk-` 。 |
| **Android NDK的位置（Location of Android NDK）** | Android NDK的磁盘上位置（如果此字段为空白，则回退到 `NDKROOT` 环境变量）。 该目录通常包含 `android-ndk-` 。 |
| **JAVA的位置（Location of JAVA）** | Java的磁盘上位置（如果此字段留空，则回退到 `JAVA_HOME` 环境变量）。 该目录通常包含 `jdk` 。 |
| **SDK API级别（SDK API Level）** | 定义使用哪个SDK来打包和编译Java。 你可以使用： 具体版本。 `latest` 以表示磁盘上的最新版本。 `matchndk` 以匹配NDK API级别。 |
| **NDK API级别（NDK API Level）** | 定义使用哪个NDK来编译（具体版本，或 `latest` 以表示磁盘上的最新版本）。 若选择 `android-21` 或更高版本，将导致应用不会在5.0之前版本的设备上运行。 |
