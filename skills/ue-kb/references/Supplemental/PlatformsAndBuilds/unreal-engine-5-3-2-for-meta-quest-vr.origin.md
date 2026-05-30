# 适用于 Meta Quest VR 的虚幻引擎 5.3.2

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/3Vx6/unreal-engine-5-3-2-for-meta-quest-vr

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 8863 字符。

## 摘要

XR Meta Quest 设置指南涵盖一切

## 中文整理

### 概览

在原始 Windows 安装上为 Meta Ouest 设置虚幻引擎 5.3.2 的指南。

**所需下载：** 虚幻引擎启动器：[https://www.unrealengine.com/en-US/download](https://www.unrealengine.com/en-US/download) Android Studio Flamingo | 2022.2.1 补丁 2 2023 年 5 月 24 日：[https://developer.android.com/studio/archive](https://developer.android.com/studio/archive) Java SE 开发套件 17.0.10 Windows x64 压缩存档[https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html) Oculus 桌面应用程序：[https://www.meta.com/quest/setup/](https://www.meta.com/quest/setup/) 适用于 Windows 的 Meta Quest 开发者中心： [https://developer.oculus.com/downloads/package/oculus-developer-hub-win](https://developer.oculus.com/downloads/package/oculus-developer-hub-win) Unreal Engine 5 Integration v65（Meta XR 插件）： [https://developer.oculus.com/downloads/package/unreal-engine-5-integration/](https://developer.oculus.com/downloads/package/unreal-engine-5-integration/)虚幻引擎5平台v65（Meta XR平台）： [https://developer.oculus.com/downloads/package/unreal-5-platform-sdk-plugin](https://developer.oculus.com/downloads/package/unreal-5-platform-sdk-plugin) Meta XR 模拟器 v65： [https://developer.oculus.com/downloads/package/meta-xr-simulator/](https://developer.oculus.com/downloads/package/meta-xr-simulator/) *我建议将所有这些安装到“C:驱动器”，因为其中一些工具太疯狂了。* ** JDK 17.0.10** 1.

将“Java SE Development Kit 17.0.10”解压到“C:/Program Files” *Epic 推荐“Java SE Development Kit 17.0.6”，但 17.0.10 已测试可正常工作* **Android Studio Flamingo** 1.

运行安装程序 2。

打开“Android Studio”并安装它想要的 3.

重新启动最右侧点菜单上名为“更多操作”的“Android Studio” 4.

选择“SDK 管理器” 5.

忽略左侧的菜单 6.

在此窗口的右下角，勾选名为“隐藏过时的软件包”的复选框 7.

在“SDK Platform”选项卡下勾选：Android API 34、Android 12L (Sv2) 8。

在“SDK Tools”选项卡下展开“Android SDK Build-Tools 35-rc2” 9.

勾选以下复选框：34.0.0。

33.0.1 10。

向下滚动并展开“NDK（并排）11。

勾选旁边的框：25.1.8937393 12。

向下滚动并展开“Android SDK Command-line Tools” 13.

勾选版本 11.0 14 的复选框。

滚动并展开 CMake 15。

勾选版本 3.10.2 16 的复选框。

向下滚动并检查这些是否也已勾选：Android Emulator、Android Emulator hypervisor 驱动程序和 Android SDK Platform-Tools 17。

点击“应用”，但是...

**第一个虚幻项目** 1。

在“创建新项目”屏幕上。

2.

3. 从左侧菜单中选择“游戏”。

选择“虚拟现实”模板 4.

取消选中“入门内容”框 5.

将您的项目命名为 6。

7. 点击“创建”按钮。

等待虚幻编辑器加载 8。

退出虚幻引擎 **Meta XR 插件** 1.

找到您的虚幻引擎模板项目（Windows 文件夹）2.

3. 在 Projects 文件夹中创建一个名为“Plugins”的文件夹。

将“UnrealMetaXRPlugin.65.0.zip”内容解压到“Plugins”文件夹中 4.

检查“Plugins”文件夹仅包含一个名为“MetaXR”的文件夹 5.

解压“Plugins”文件夹中的“Unreal5PlatformSDKPlugin.65.0.zip”内容 6.

检查“Plugins”文件夹包含一个名为“MetaXRPlatform”的文件夹 5.

启动 .uproject 文件 ** 虚幻引擎插件** 1.

在 Unreal 主菜单中选择“编辑/插件”2。

在左侧菜单中找到“已安装/虚拟现实”3。

如果未启用，则启用“Meta XR”（默认启用） 4.

在左侧菜单中找到“已安装/在线平台”5。

如果未启用，则启用“Meta XR Platform”（默认启用） 6.

关闭“插件”窗口 **虚幻项目设置** 1.

在虚幻主菜单中选择“编辑/项目设置”2。

向下滚动到“平台/Android”3.

将“最低 SDK 版本”设置为“29” 4.

将“目标 SDK 版本”设置为“32” 5.

点击所有红色按钮区域，使它们变绿 6.

从左侧菜单中选择“平台/Android SDK”**Unreal SDK 设置； SDK配置** 1.

Android SDK 的位置：C:/Users/name/AppData/Local/Android/Sdk 2.

Android NDK 的位置：C:/Users/name/AppData/Local/Android/Sdk/ndk/25.1.8937393 3.

Java 的位置：C:\Program Files\jdk-17.0.10 4.

SDK API 级别：android-32 5。

NDK API 级别：android-29 **Meta XR 设置** 1。

从左侧的项目设置菜单中选择：“插件/Meta XR”2.

通用/XR API：带有 Oculus 供应商扩展的 Epic Native OpenXR 3。

一般/色彩空间：P3（推荐）4。

常规/控制器姿势对齐：默认 5。

文件/全部保存 6.

重新启动虚幻 **虚幻 VR 预览** 1.

在编辑/插件 2 下。

打开“Oculus 应用” 3.

在 Quest 中，转到您的个人资料图标 4 旁边的“快速设置”。

5. 选择“Quest Link”并连接到您的计算机。

在 Unreal 中找到 Transport 控件（上面有一个绿色的播放按钮） 6.

选择传输控件“更多按钮” 7.

选择 VR 预览 **Meta XR 模拟器** 1。

将“meta_xr_simulator_v65.zip”文件解压到“C:\Users\name\Documents\Unreal Projects” 2.

将 .tgz 文件解压缩到同一位置“C:\Users\name\Documents\Unreal Projects” 3.

将“meta_xr_simulator_v65”文件夹移动到“C:\Users\name\Documents\Unreal Projects\” 4.

在 Meta XR 插件中设置“Meta XR Simulator JSON 文件”位置：C:\Users\name\Documents\Unreal Projects\meta_xr_simulator_v65\package\MetaXRSimulator\meta_openxr_simulator.json 5.

关闭项目设置窗口 6.

文件/全部保存 7.

在 VRTemplateMap 选项卡上找到“Meta XR Simulator”菜单 8。

打开它 **构建 Quest APK** 1。

VRTemplateMap 选项卡找到“平台”菜单 2。

选择“Android/包项目” 3.

4. 创建一个名为“Quest”的新文件夹。

5. 打开文件夹并点击“选择文件夹”按钮。

Unreal将开始构建，您可以在“OutputLog”6中看到进度。

等待 Unreal 构建 7。

打开“Meta Quest 开发者中心”应用程序 8.

在“设备管理器”中，点击“应用程序”选项卡下的“+添加构建”按钮 9.

找到您刚刚在 Unreal 10 中构建的 APK。

将 APK 安装到 Quest 11。

在 Quest 中点击“应用程序库”（所有应用程序都位于其中） 12.

点击搜索旁边的“全部”，然后选择“未知来源” 13.

启动您的应用程序 注意：元插件对于创建 VR 内容并不是必需的，但出于综合目的而包含在此处。

Meta 和 Epic 正在努力减少设置步骤，这真是太棒了。

模拟器组件目前并不是真正必需的，但为了完整性我添加了它。

*为什么要将Meta Plugin添加到Projects Plugin文件夹中？

这是因为 Meta 指示将插件安装到不存在的“Marketplace”文件夹中。

此外，您可以在不影响虚幻编辑器的情况下更新插件版本。* *[更新到 Meta 插件版本 65]* *[更新到 Meta 插件版本 64]* *[更新到 Meta 插件版本 63]* *[更新到 Meta 插件版本 62]* *[更新到 JDK 17.0.10]* *[更新 Android Studio Flamingo 到 2022.2.1 Patch 2 May 2023 年 2 月 24 日]* *[不再需要虚幻 VR 预览解决方法]* 玩得开心！
