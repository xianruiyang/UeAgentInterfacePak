# 适用于 Meta Quest VR 的虚幻引擎 5.4.x

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/y4vB/unreal-engine-5-4-x-for-meta-quest-vr

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 11317 字符。

## 摘要

XR Meta Quest 设置指南涵盖一切

## 中文整理

### 概览

在原始 Windows 安装上为 Meta Quest 设置 **虚幻引擎 5.4.4** 的指南。

**下载以下内容：** 虚幻引擎启动器：[https://www.unrealengine.com/en-US/download](https://www.unrealengine.com/en-US/download) Android Studio Flamingo | 2022.2.1 补丁 2 2023 年 5 月 24 日：[https://developer.android.com/studio/archive](https://developer.android.com/studio/archive) 向下滚动到“Java SE Development Kit 17.0.10”Windows x64 压缩存档[https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html) Meta Quest (链接) 应用程序 (Quest 2 下的下载按钮): [https://www.meta.com/quest/setup/](https://www.meta.com/quest/setup/) Meta Quest Windows 开发者中心：[https://developer.oculus.com/downloads/package/oculus-developer-hub-win](https://developer.oculus.com/downloads/package/oculus-developer-hub-win) Unreal Engine 5 Integration v71（Meta XR 插件）： [https://developer.oculus.com/downloads/package/unreal-engine-5-integration/](https://developer.oculus.com/downloads/package/unreal-engine-5-integration/)虚幻引擎 5 平台 v71（Meta XR 平台）： [https://developer.oculus.com/downloads/package/unreal-5-platform-sdk-plugin](https://developer.oculus.com/downloads/package/unreal-5-platform-sdk-plugin) Meta XR 模拟器 v71： [https://developer.oculus.com/downloads/package/meta-xr-simulator/](https://developer.oculus.com/downloads/package/meta-xr-simulator/) *我建议将所有这些安装到“C:驱动器”，因为其中一些工具太疯狂了。* **JDK 17.0.10 ** 将“Java SE Development Kit 17.0.10”解压到“C:/Program Files” *Epic 推荐“Java SE Development Kit” 17.0.6"，但 17.0.10 已测试可正常工作 * **Android Studio Flamingo** 1.

运行安装程序 2。

打开“Android Studio”并安装它想要的 3.

重新启动最右侧点菜单上名为“更多操作”的“Android Studio” 4.

选择“SDK 管理器” 5.

忽略左侧的菜单 6.

在此窗口的右下角，勾选名为“隐藏过时的软件包”的复选框 7.

在“SDK Platform”选项卡下勾选：Android API 34、Android 12L (Sv2) 8。

在“SDK Tools”选项卡下展开“Android SDK Build-Tools 35-rc1” 9.

勾选以下复选框：34.0.0。

33.0.1 10。

向下滚动并展开“NDK（并排）11。

勾选旁边的框：25.1.8937393 12。

向下滚动并展开“Android SDK Command-line Tools” 13.

勾选最新版本（目前有 13 个） 14.

滚动并展开 CMake 15。

勾选版本 3.10.2.4988404 16 的复选框。

向下滚动并检查这些是否也已勾选：Android Emulator、Android Emulator hypervisor 驱动程序和 Android SDK Platform-Tools 17。

点击“应用”按钮并确定许可证 18.

完成后关闭“Android Studio” 19.

重新启动计算机！

**JAVA_HOME** 1.

按 Windows 操作系统任务栏上的“开始”（Windows 徽标） 2。

输入“环境变量...” 3.

4.打开“编辑系统环境变量”。

5. 点击“环境变量”按钮。

在“用户变量”下找到“JAVA_HOME”6。

将 JAVA_HOME 更改为“C:\Program Files\jdk-17.0.10” 7.

重新启动计算机 **创建元开发者帐户** 1.

创建开发者帐户：[https://developer.oculus.com/](https://developer.oculus.com/) 2.

在您的手机上安装 Meta Quest 应用程序（请参阅应用程序或 Play 商店） 3.

从电话应用程序导航栏中选择“菜单/设备” 4.

选择/添加您想要启用开发者模式的设备 5.

6. 点击“耳机设置”按钮。

打开“开发者设置/调试模式 **Meta Quest 移动应用程序 ***您可能需要创建和组织帐户 /sigh* 1.

从 Play/App Store 2 安装 Meta Quest Mobile 应用程序。

按照应用程序中的说明连接 Quest 3。

在“耳机”图标下，右上角第二个。

4.

选择你的任务 5。

选择：管理您的设备/耳机设置/开发者模式 6。

并启用“开发者模式”**Meta Quest Link 桌面应用程序** 1。

安装 2。

启动应用程序 3。

如果收到警报，请更新驱动程序 4.

使其成为默认的 OpenXR 运行时（如果收到警报） 5.

在“设置”下启用“未知来源” 6.

使用 USB 7 将 Meta Quest 连接到计算机。

按照安装说明将 Quest 链接到桌面应用程序 8。

在 Quest“确定”中，USB 9 的权限警报。

在 Quest 上，转到“设置/系统/开发人员”并将所有内容都“打开”**Meta Quest 开发人员中心 ** *您可能需要创建和组织帐户 /sigh* 1.

安装 2。

启动应用程序 3。

该应用程序将检测 2 ADB 安装 4。

选择“不是”Meta 的那个（使用 Android Studios ADB） 5.

在 Meta Hub 中，从菜单中选择“设备管理器”。

6.

如果需要，更新 MQDH 7.

重新启动计算机 **虚幻引擎** 1.

安装：“虚幻引擎启动器”2.

启动应用程序 3。

创建或登录启动器 4.

从左侧菜单中选择“虚幻引擎” 5.

6. 选择“库”选项卡。

单击“引擎版本”旁边的黄色“+”按钮 7.

从生成的卡中，选择“5.4.x”并安装 8。

单击“启动”按钮（允许所有操作）**虚幻引擎 Android 设置** 1.

找到虚幻引擎 5.4.x 安装文件夹 2。

启动“UE_5.4\Engine\Extras\Android\SetupAndroid.bat” **第一个虚幻项目** 1.

2. 在“创建新项目”屏幕上。

3. 从左侧菜单中选择“游戏”。

选择“虚拟现实”模板 4.

取消选中“入门内容”框 5.

将您的项目命名为 6。

7. 点击“创建”按钮。

等待虚幻编辑器创建您的项目 8.

退出虚幻引擎 **Meta XR 插件** 1.

找到您的虚幻引擎模板项目（Windows 文件夹） 2.

3. 在 Projects 文件夹中创建一个名为“Plugins”的文件夹。

将“UnrealMetaXRPlugin.71.0.zip”内容解压到“Plugins”文件夹中 4.

检查“Plugins”文件夹中是否包含名为“MetaXR”的文件夹 5.

解压“Plugins”文件夹中的“Unreal5PlatformSDKPlugin.71.0.zip”内容 6.

检查“Plugins”文件夹中是否包含名为“MetaXRPlatform”的文件夹 7.

启动 .uproject 文件 **虚幻引擎插件** 1.

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

将安装位置设置为“自动” 6.

6. 将方向设置为“横向”。

.apk内打包游戏数据勾选7。

点击所有红色按钮区域，使其变绿 **Unreal SDK 设置； SDK配置** 1.

从左侧的“项目设置”菜单中选择：“平台/Android SDK” 2.

Android SDK 的位置：C:/Users/name/AppData/Local/Android/Sdk 3.

Android NDK 的位置：C:/Users/name/AppData/Local/Android/Sdk/ndk/25.1.8937393 4.

Java 的位置：C:\Program Files\jdk-17.0.10 5.

SDK API 级别：android-34 6。

NDK API 级别：android-29 **Meta XR 设置** 1。

从左侧的项目设置菜单中选择：“插件/Meta XR”2.

通用/XR API：Oculus OVRPlugin + OpenXR 后端（当前推荐）3.

一般/色彩空间：P3（推荐）4。

常规/控制器姿势对齐：默认 5。

移动/支持的 Meta Quest 设备：添加您的设备 6.

文件/全部保存 7.

重新启动虚幻 **虚幻 VR 预览** 1.

打开“Oculus 应用”2.

在 Quest 中，转到您的个人资料图标 3 旁边的“快速设置”。

4. 选择“Quest Link”并连接到您的计算机。

在 Unreal 中找到 Transport 控件（上面有一个绿色的播放按钮） 5.

选择传输控件“更多按钮” 6.

选择 VR 预览 **Meta XR 模拟器** 1。

将“meta_xr_simulator_v71.zip”文件解压到“C:\Users\name\Documents\Unreal Projects” 2.

解压“meta_xr_simulator_v71”文件夹中的.tgz 文件 3.

在 Meta XR 插件中设置“Meta XR Simulator JSON 文件”位置：C:\Users\name\Documents\Unreal Projects\meta_xr_simulator_v71\com.meta.xr.simulator\meta_openxr_simulator.json 4.

关闭项目设置窗口6。

文件/全部保存 5.

在 VRTemplateMap 选项卡上找到“Meta XR Simulator”菜单 6。

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

启动您的应用程序**分发** 1.

打开命令行（或终端管理）2.

在命令行中输入：cd "C:\Program Files\jdk-17.0.10\bin" 3.

想想一个“密钥库”文件，我将其称为“Mumble”4。

想一个“别名”，嗯，也许是“innit”5。

想一个“密码”，与“123456”一起使用 6。

接下来输入：keytool -genkey -v -keystore Mumble.keystore -alias innit -keyalg RSA -keysize 2048 -validity 10000 7.

回答所有问题以创建密钥库文件。

8.

将 C:\Program Files\jdk-17.0.10\bin\Mumble.keystore 剪切/复制到 Unreal Projects\Build\Android 目录。

9.

打开您的虚幻引擎项目 10。

打开 Edit/Project Settings 并在左侧菜单中选择 Android 11.

设置分发签名/密钥存储：Mumble.keystore 12。

设置分发签名/密钥别名： innit 13。

分发签名/密钥库密码：123456 14.

分发签名/密钥密码：123456 15.

接下来从“项目设置”左侧菜单中选择“打包 16”。

设置项目/构建配置：运输 17.

完全重建：勾选18。

对于分发：勾选 19。

关闭项目设置 20。

在主菜单上选择“平台”和“针对 Android 21 构建”。

打开 Meta Quest Hub 应用程序 22。

首选应用程序分发和上传！

*注意：***当您想要构建以发布项目时，请考虑删除 Binaries、Intermediate 和 Saved 文件夹以及开发 APK。

当想要恢复开发时，重置打包设置（步骤 15）以避免每次都需要完全重建。

** **Meta XR 项目设置工具** 这是查找设置问题的有用工具。

它可能会抱怨 Android SDK 最低版本。

你可以忽略这一点。

29 支持是正确的，最大应该是 32。

注意：Meta 插件对于创建 VR 内容并不是必需的，但出于综合目的而包含在此处。

Meta 和 Epic 正在努力减少设置步骤，这真是太棒了。

*模拟器组件目前并不是真正必需的，但为了完整性我添加了它。* *为什么要将 Meta Plugin 添加到 Projects Plugin 文件夹中？

这是因为 Meta 指示将插件安装到不存在的“Marketplace”文件夹中。

此外，您可以更新插件版本而不影响虚幻编辑器。

* *[针对 Meta 版本 71 进行更新] [针对 Meta 版本 69 进行更新] **[更新了项目设置并添加了分发说明] [针对 UE5.4.4 更改进行了更新：* ***项目设置/平台/Android/目标 SDK 版本：32 **项目设置/*平台/Android/SDK API 级别：android-34] *[针对 Meta 版本 68 进行了更新]* ***[针对 Meta 版本 67 进行了更新] [将 Meta 移动应用更新为最新流程]*玩得开心！
