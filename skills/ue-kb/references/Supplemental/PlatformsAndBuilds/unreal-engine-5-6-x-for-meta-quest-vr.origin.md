# 适用于 Meta Quest VR 的虚幻引擎 5.6.x

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/2KR1/unreal-engine-5-6-x-for-meta-quest-vr

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 7440 字符。

## 摘要

XR Meta Quest 设置指南涵盖虚幻引擎 5.6.x 的所有内容

## 中文整理

### 概览

在原始 Windows 安装上为 **Meta XR v85** 设置 **虚幻引擎 5.6.1** 的指南。

**下载以下内容：** Unreal Engine Launcher：[https://www.unrealengine.com/en-US/download](https://www.unrealengine.com/en-US/download) Android Koala 2024.1.2 Patch 1 2024 年 9 月 17 日：[https://developer.android.com/studio/archive](https://developer.android.com/studio/archive)Java SE 开发套件21.0.3：[https://www.oracle.com/java/technologies/javase/jdk21-archive-downloads.html](https://www.oracle.com/java/technologies/javase/jdk21-archive-downloads.html) Meta Horizon Link 应用程序（桌面）：[https://www.meta.com/quest/setup/](https://www.meta.com/quest/setup/) Meta Quest 开发者中心：[https://developer.oculus.com/downloads/package/oculus-developer-hub-win](https://developer.oculus.com/downloads/package/oculus-developer-hub-win)Unreal Engine 5 Integration v85（Meta XR 插件）： [https://developer.oculus.com/downloads/package/unreal-engine-5-integration/](https://developer.oculus.com/downloads/package/unreal-engine-5-integration/)虚幻引擎 5 平台 v85（Meta XR 平台）： [https://developer.oculus.com/downloads/package/unreal-5-platform-sdk-plugin](https://developer.oculus.com/downloads/package/unreal-5-platform-sdk-plugin) Meta XR 模拟器 v85.0： [https://developers.meta.com/horizon/downloads/package/meta-xr-simulator-windows/](https://developers.meta.com/horizon/downloads/package/meta-xr-simulator-windows/) *我建议将所有这些安装到“C:驱动器”，因为其中一些工具太疯狂了。* **JDK 21.0.3** 运行这个“Java SE Development Kit 21.0.3”安装程序。

*安装到默认位置 (C://Program Files/Java/jdk-21)。* **Android Studio ******Koala 1.

运行安装程序 2。

3. 打开Android Studio并安装所需组件。

重新启动Android Studio，点击右侧菜单中的“更多操作” 4.

选择“SDK 管理器” 5.

忽略左侧菜单 6.

在右下角，勾选“隐藏过时的软件包”和“显示软件包详细信息” 7.

在“SDK 平台”下，勾选 Android SDK 平台 34 和 35 8。

在“SDK Tools”下，展开“Android SDK Build-Tools 36.1” 9.

勾选 35.0.1 10。

展开“NDK（并排）”11。

勾选26.1.10909125（我们尝试了27.2.12479018，但没有成功）12。

展开“Android SDK命令行工具”13。

勾选最新版本（当前版本为19） 14.

展开“CMake”15。

勾选 3.22.1 16。

另请勾选：Android Emulator、Android Emulator Hypervisor Driver 和 Android SDK Platform-Tools 17。

申请并接受许可证 18.

关闭 Android Studio 19。

重新启动计算机 **JAVA_HOME** 1.

在 Windows 2 上按“开始”。

输入“环境变量...” 3.

4.打开“编辑系统环境变量”。

5. 单击“环境变量”。

在用户变量下，找到“JAVA_HOME”6。

更改为 C:\Program Files\Java\jdk-21 7.

按“确定”，然后应用 **创建元开发者帐户** 1.

创建开发者帐户：https://developer.oculus.com/ 2.

在手机上安装 Meta Quest 应用程序（App Store 或 Play Store） 3.

在应用程序中，选择菜单 > 设备 4。

选择/添加设备以启用开发者模式 5.

6. 点击“耳机设置”。

打开开发者设置/调试模式 **Meta Quest 移动应用程序*** 您需要创建一个组织帐户* 1.

安装 Meta Quest 移动应用程序 2.

按照应用程序说明连接 Quest 3。

点击耳机图标4。

选择您的任务 5。

转至管理设备 > 耳机设置 > 开发者模式 6.

启用开发者模式 **Meta Quest Link 桌面应用程序** 1.

安装 2。

发射 3.

如果出现提示，请更新驱动程序 4.

如果出现提示，请设置为默认 OpenXR 运行时 5.

在“设置”>“常规”下，启用“未知来源”6。

在设置 > Beta 下，启用公共测试通道和开发人员运行时功能 7.

使用 USB 8 将 Quest 连接到 PC。

按照链接说明进行操作 9.

接受 Quest 10 上的 USB 权限。

在 Quest 上：设置 > 高级 > 开发人员 > 启用所有 **Meta Quest 开发人员中心** *您需要创建一个组织帐户 /sigh* 1.

安装 2。

发射 3.

应用程序检测到 2 ADB 安装 4。

选择非Meta的（使用Android Studio ADB） 5.

在 Meta Hub 中，转到设备管理器 6。

如果需要，更新 MQDH 7.

重新启动计算机（以防万一）**虚幻引擎** 1.

安装虚幻引擎启动器 2。

发射 3.

登录/创建帐户 4.

从左侧菜单 5 中选择虚幻引擎。

转到“库”选项卡 6。

在引擎版本旁边，单击“+”7.

选择5.6.1并安装8。

在“目标平台”下，启用 Android（如果错过）9.

单击启动 **虚幻引擎 Android 设置** 1。

找到虚幻引擎 5.6 安装文件夹 2。

运行“UE_5.6/Engine/Extras/Android/SetupAndroid.bat” **第一个虚幻项目** 1.

在“创建新项目”屏幕 2 中。

选择游戏 3。

选择虚拟现实模板 4。

取消勾选入门内容 5。

命名项目 6.

单击创建 7.

等待项目创建 8.

退出虚幻 **Meta XR 插件** 1.

找到您的项目文件夹 2.

3. 创建“Plugins”文件夹。

将 UnrealMetaXRPlugin.85.zip 解压到 Plugins 4 中。

确认“MetaXR”文件夹存在 5.

将 Unreal5PlatformSDKPlugin.85.zip 解压到 Plugins 6 中。

确认“MetaXRPlatform”文件夹存在 7.

启动 .uproject（打开项目） **虚幻引擎插件** 1.

在虚幻中：编辑 > 插件 2.

在“已安装”>“虚拟现实”下，启用 Meta XR 3。

在“已安装”>“在线平台”下，启用 Meta XR Platform 4。

关闭插件窗口 **虚幻项目设置** 1.

编辑 > 项目设置 2.

转至平台 > Android 3。

最低 SDK：32 4。

目标SDK：34 5.

安装位置：汽车 6.

方向：风景 7.

将游戏数据打包到.apk中：勾选8。

解决所有红色警告 **Unreal SDK 设置； SDK配置** 1.

项目设置 > 平台 > Android SDK 2。

SDK：C:/Users/name/AppData/Local/Android/Sdk 3.

NDK: C:/Users/name/AppData/Local/Android/Sdk/ndk/26.1.10909125 4.

Java：C:/Program Files/Java/jdk-21 5.

SDK API 级别：android-34 6。

NDK API 级别：android-34 **Meta XR 设置** 1。

项目设置 > 插件 > Meta XR 2。

常规 > XR API：Epic Native OpenXR（推荐）3.

色彩空间：P3（推荐）4.

控制器姿势对齐：默认 5。

支持的设备：添加您的 Quest 6。

文件 > 全部保存 7.

重新启动虚幻 **虚幻 VR 预览** 1.

打开 Meta Quest Link（桌面应用程序） 2.

在 Quest 上，快速设置 > Quest Link 3。

连接到电脑 4。

在 Unreal 中，打开 Transport 控件 5。

单击更多 6。

选择 VR 预览 **构建 Quest APK** 1。

在 VRTemplateMap 中，打开“平台”菜单 2。

选择 Android > 打包项目 3。

4. 创建文件夹“Quest”。

选择文件夹 5。

构建开始（输出日志中的进度） 6.

等待构建7。

打开 Meta Quest 开发者中心 8。

在“设备管理器”中，单击“Apps 9”下的“+添加构建”。

选择Unreal 10内置的APK。

安装到 Quest 11。

在 Quest 上，打开应用程序库 12。

点击全部 > 未知来源 13。

启动应用程序** **Meta XR 模拟器** 1.

运行安装程序：meta_xr_simulator_v85.0.msi 2.

安装 MetaXRSimulator 应用程序 3。

打开模拟器应用程序 4.

Meta Simulator 应用程序：打开 Meta XR Simulator（左上） 5.

虚幻引擎：勾选 Meta XR Simulator > Meta XR Simulator 6。

重新启动您的项目。

7.

按 Play > Standalone Game 或 Play > VR Preview *注意：要覆盖 Meta XR Simulator 的版本，请编辑“项目设置 > Meta XR > Meta XR Simulator”，启用“覆盖 XRSimulator 版本”，然后设置您想要的版本。* *为什么将 Meta Plugin 添加到 Project Plugins 文件夹？

Meta 的指南指向一个不存在的 Marketplace 文件夹。

此外，为每个项目创建一个插件文件夹允许您更新插件而不影响编辑器。

** **[Meta XR- **维护版本**]* *[更新的模拟器 - 添加到指南]* 玩得开心！
