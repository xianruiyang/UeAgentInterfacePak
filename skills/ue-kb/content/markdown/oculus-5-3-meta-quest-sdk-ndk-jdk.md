# 适用于 Oculus 5.3 引擎源码分支的 Meta Quest SDK/NDK/JDK

# 适用于 Oculus 5.3 引擎源码分支的 Meta Quest SDK/NDK/JDK

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/oMMe/unreal-engine-meta-quest-sdk-ndk-jdk-for-the-oculus-5-3-fork-of-the-engine-source

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 3740 字符。

## 摘要

我用来成功构建和打包 Meta Quest APK 的简短概述

## 中文整理

### 概览

- [Java 下载 - JDK 17.0.9](https://oracle.com/java/technologies/downloads#jdk21-windows) - [Android Studio 4.0 - 2020 年 5 月 28 日 - 直接下载](https://redirector.gvt1.com/edgedl/android/studio/install/4.0.0.16/android-studio-ide-193.6514223-windows.exe)

### 免责声明

这不是教程，而是演练，假设您已经知道如何设置虚幻引擎来进行任务开发。如果您还没有，那么我建议您首先观看 [GDXR 教程](https://youtu.be/nixc8NF_97s?si=SqEZzOL6RvhMICEZ) 以了解整个过程，然后返回此处下载、安装并设置正确的变量。

### 是什么最终让我走到了这一步……

与每个新版本一样，Meta 坚持不发布任何文档的传统，我只能假设这是为了通过开发人员的痛苦来塑造角色。有人说这是他们长期战略的一部分，某种投资，这样只有最强大的人才能够熬过即将到来的 VR 冬天。尽管如此，我已经尝试并取得了胜利，因此您不必...经过一些安静的沉思，我决定创建此演练来帮助您找到正确的道路。但请不要将我的慷慨误认为是仁慈，因为这只是阻止你们像我一样成长和发展生存技能的一种手段。

### Android SDK 的最终项目设置

那么让我们直接切入正题吧

### 我的 Android SDK 设置

![教程图片](assets/unreal-engine-meta-quest-sdk-ndk-jdk-for-the-oculus-5-3-fork-of-the-engine-source/image-01.jpg)

### 下载什么

**Android Studio** - Android **API 32** - 适用于 **目标 SDK** 版本 - Android **API 10** - 适用于 **最低 SDK** 版本 - Android **API 33** - 因为它不断请求并尝试下载它 - SDK 构建工具 **33.0.2** - 命令行工具 **8.0** - NDK **25.1.89 **- 以防万一出于 **兼容性** 原因 - **CMake** - 列表中的所有内容- 3.22.1 - 3.18.1 - 3.10.2 - 3.6.411** ** **Java** - JDK **17.0.9** - [下载链接](https://www.oracle.com/java/technologies/downloads/#jdk21-windows) - (必须创建一个帐户才能下载)

### 使用的参考视频

用于设置下面演练中的所有内容

### Android Studio 下载和设置

您需要 [Android Studio](https://developer.android.com/studio/archive) 4.0 (2020 年 5 月 28 日) - [直接下载链接](https://redirector.gvt1.com/edgedl/android/studio/install/4.0.0.16/android-studio-ide-193.6514223-windows.exe)

![点击右下角的Configure并选择SDK Manager](assets/unreal-engine-meta-quest-sdk-ndk-jdk-for-the-oculus-5-3-fork-of-the-engine-source/image-02.jpg)

![选择 Android API 33、32 和 10](assets/unreal-engine-meta-quest-sdk-ndk-jdk-for-the-oculus-5-3-fork-of-the-engine-source/image-03.jpg)

![在Android SDK Build-Tools下选择33.0.2](assets/unreal-engine-meta-quest-sdk-ndk-jdk-for-the-oculus-5-3-fork-of-the-engine-source/image-04.jpg)

![如果您没有看到它们，请确保未选中隐藏过时的软件包并选中右下角的显示软件包详细信息。](assets/unreal-engine-meta-quest-sdk-ndk-jdk-for-the-oculus-5-3-fork-of-the-engine-source/image-05.jpg)

![NDK下选择25.1.89](assets/unreal-engine-meta-quest-sdk-ndk-jdk-for-the-oculus-5-3-fork-of-the-engine-source/image-06.jpg)

![选择 Android SDK Command-line Tools 下的 Android SDK Command-line Tools 8.0 以及 CMake 下的所有内容](assets/unreal-engine-meta-quest-sdk-ndk-jdk-for-the-oculus-5-3-fork-of-the-engine-source/image-07.jpg)

![现在点击应用并安装软件包。完成前面的步骤后，请务必保存路径](assets/unreal-engine-meta-quest-sdk-ndk-jdk-for-the-oculus-5-3-fork-of-the-engine-source/image-08.jpg)

![安装后，转到源文件夹中的 Engine\Extras\Android 并运行 SetupAndroid.bat](assets/unreal-engine-meta-quest-sdk-ndk-jdk-for-the-oculus-5-3-fork-of-the-engine-source/image-09.jpg)

### 构建工具和命令行设置

### 转到您的 [Android Sdk 位置]\build-tools

![找到 SDK 30 以上的所有文件夹。我们需要进入并更改一些文件名。](assets/unreal-engine-meta-quest-sdk-ndk-jdk-for-the-oculus-5-3-fork-of-the-engine-source/image-10.jpg)

### 现在转到 [Android Sdk Location]\cmdline-tools

将里面的文件夹重命名为“**latest**”

### Java下载和环境变量

转到 [JDK 下载](https://www.oracle.com/java/technologies/downloads/#jdk21-windows) 页面并获取 **JDK 17.0.9**

### 设置环境变量

### 引擎内设置

- Android SDK 位置：[**Android Sdk 位置**] - Android SDK 位置：[**Android Sdk 位置**]**\ndk\****25.1.8937393** - JAVA 位置：[**Java 位置**] - SDK API 级别：**最新** - NDK API 级别：**android-32** ** **

### 我解决的其他一些问题...

### “不支持 OpenXR 运行时”

```
LogOVRPlugin: Error: Non-Oculus OpenXR runtime is not supported. (arvr\projects\integrations\OVRPlugin\Src\Util\CompositorOpenXR.cpp:2029)
```

转到 **项目设置 > 插件 > Meta XR** 并将 XR API 更改为“**带有 Oculus 供应商扩展的 Epic Native OpenXR**”

### “插件‘OculusXR’未将插件‘OpenXR’列为依赖项”

```
UATHelper: Packaging (Android (ASTC)): Warning: Plugin 'OculusXR' does not list plugin 'OpenXR' as a dependency, but module 'OculusXROpenXRHMD' depends on 'OpenXRHMD'.
```

- 在 **\Engine\Plugins\Runtime\OpenXR** 中打开 **OculusXR.Plugin** - 转到 **第 136 行** - 将“**Enabled**”设置为 **T****rue**

### 差不多就是这样了。你应该已经准备好了！

至少在 Meta 的下一个 **版本更新** 之前......

## 相关链接

- [Java Download  -  JDK 17.0.9](https://oracle.com/java/technologies/downloads#jdk21-windows)
- [Android Studio 4.0  -  May 28, 2020  -  Direct Download](https://redirector.gvt1.com/edgedl/android/studio/install/4.0.0.16/android-studio-ide-193.6514223-windows.exe)

