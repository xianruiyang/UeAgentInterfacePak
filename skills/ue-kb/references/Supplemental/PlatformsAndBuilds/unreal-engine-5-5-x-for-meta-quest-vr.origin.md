# 适用于 Meta Quest VR 的虚幻引擎 5.5.x

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/PYP7/unreal-engine-5-5-x-for-meta-quest-vr

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 9010 字符。

## 摘要

XR Meta Quest 设置指南涵盖虚幻引擎 5.5.x 的所有内容

## 中文整理

### 概览

在原始 Windows 安装上为 Meta Quest 设置 **虚幻引擎 5.5.4** 的指南。

**下载以下内容：** Unreal Engine Launcher：[https://www.unrealengine.com/en-US/download](https://www.unrealengine.com/en-US/download) Android Koala 2024.1.2 Patch 1 2024 年 9 月 17 日：[https://developer.android.com/studio/archive](https://developer.android.com/studio/archive)Java SE 开发套件21.0.3：[https://www.oracle.com/java/technologies/javase/jdk21-archive-downloads.html](https://www.oracle.com/java/technologies/javase/jdk21-archive-downloads.html) Meta Horizon Link 应用程序（桌面）：[https://www.meta.com/quest/setup/](https://www.meta.com/quest/setup/)Meta Quest 开发者中心：[https://developer.oculus.com/downloads/package/oculus-developer-hub-win](https://developer.oculus.com/downloads/package/oculus-developer-hub-win) Unreal Engine 5 Integration v78（Meta XR 插件）： [https://developer.oculus.com/downloads/package/unreal-engine-5-integration/](https://developer.oculus.com/downloads/package/unreal-engine-5-integration/)虚幻引擎 5 平台 v78（Meta XR 平台）： [https://developer.oculus.com/downloads/package/unreal-5-platform-sdk-plugin](https://developer.oculus.com/downloads/package/unreal-5-platform-sdk-plugin) Meta XR 模拟器 v78： [https://developer.oculus.com/downloads/package/meta-xr-simulator/](https://developer.oculus.com/downloads/package/meta-xr-simulator/) *我建议将所有这些安装到“C:驱动器”，因为其中一些工具太疯狂了。* **JDK 21.0.3** 运行这个“Java SE Development Kit 21.0.3”安装程序。

*安装到默认位置 (C://Program Files/Java/jdk-21)。* **Android Studio ******Koala 1.

运行安装程序 2.

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

打开开发者设置/调试模式 **Meta Quest 移动应用程序** *您需要创建一个组织帐户* 1.

安装 Meta Quest 移动应用程序 2.

按照应用程序说明连接 Quest 3。

点击耳机图标 4。

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

在 Quest 上：设置 > 高级 > 开发人员 > 启用所有 **Meta Quest 开发人员中心*** * *您需要创建一个组织帐户 /sigh* 1.

安装 2。

发射 3.

应用程序检测到 2 ADB 安装 4。

选择非Meta的（使用Android Studio ADB） 5.

在 Meta Hub 中，转到设备管理器 6。

如果需要，更新 MQDH 7.

重新启动计算机 **虚幻引擎** 1.

安装虚幻引擎启动器 2。

发射 3.

登录/创建帐户 4.

从左侧菜单 5 中选择虚幻引擎。

转到“库”选项卡 6。

在引擎版本旁边，单击“+”7.

选择5.5.4并安装8。

在“目标平台”下，启用 Android（如果错过）9.

单击启动 **虚幻引擎 Android 设置** 1。

找到虚幻引擎 5.5.4 安装文件夹 2。

运行“UE_5.5\Engine\Extras\Android\SetupAndroid.bat” **第一个虚幻项目** 1.

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

将 UnrealMetaXRPlugin.78.zip 解压到 Plugins 4 中。

确认“MetaXR”文件夹存在 5.

将 Unreal5PlatformSDKPlugin.78.zip 解压到 Plugins 6 中。

确认“MetaXRPlatform”文件夹存在 7.

启动 .uproject **虚幻引擎插件** 1。

在虚幻中：编辑 > 插件 2.

在“已安装/虚拟现实”下，启用 Meta XR 3。

在已安装/在线平台下，启用 Meta XR Platform 4。

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

XR API：Oculus OVRPlugin + OpenXR 后端（推荐）3.

色彩空间：P3 4。

控制器姿势对齐：默认 5。

支持的设备：添加您的 Quest 6。

文件 > 全部保存 7.

重新启动虚幻 **虚幻 VR 预览** 1.

打开 Meta Quest Link（桌面应用程序） 2.

在 Quest 上，快速设置 > Quest Link 3。

连接到电脑 4。

在 Unreal 中，打开 Transport 控件 5。

单击更多 6。

选择 VR 预览 **Meta XR Simulator** 如果 SDK **低于 **v76: 1。

将 meta_xr_simulator_v78.zip 解压到 C:\Users\name\Documents\Unreal Projects 2.

在meta_xr_simulator_v78 3中提取.tgz。

在 Meta XR 插件中设置 JSON 路径：C:/Users/name/Documents/Unreal Projects/meta_xr_simulator_v78/com.meta.xr.simulator/package/MetaXRSimulator/meta_openxr_simulator.json 4.

下载合成环境：https://securecdn.oculus.com/binaries/download/?id=8778927728892025 5.

解压synth_env_win64_v74.zip 6。

将 Meta XR 合成环境设置到此文件夹 7.

关闭项目设置 8.

如果 SDK 是 v76 或 **以上**，则保存全部： 1.

在视口架上，找到 Meta XR Simulator > 检查更新 2。

启用“Meta XR Simulator/Meta XR Simulator”复选框 3。

从 Meta XR Simulator 中，选择合成环境服务器 4。

按“播放/独立游戏”或“播放/VR 预览”**构建任务 APK** 1。

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

启动应用程序 **分发** 1.

打开命令提示符（管理员）2。

cd "C:\Program Files\Java\jdk-21\bin" 3.

选择密钥库名称（例如 Mumble） 4.

选择别名（例如 innit） 5.

选择密码（例如 123456） 6.

运行：keytool -genkeypair -v -keystore Mumble.keystore -alias innit -keyalg RSA -keysize 2048 -validity 10000 7.

回答提示 8.

将 Mumble.keystore 复制到 Unreal Projects\Build\Android 9。

在虚幻中：编辑 > 项目设置 > Android 10。

设置密钥库：Mumble.keystore 11。

关键别名：init 12。

密钥库密码：123456 13.

密钥密码：123456 14.

转至包装 15。

构建配置：运输 16。

完全重建：勾选17。

对于分发：勾选 18。

关闭设置 19.

平台 > 为 Android 20 构建。

打开元任务中心 21。

应用程序分发 > 上传 **Android 文件服务器** - *（可选）* 1.

项目设置 > AndroidFileServer 2.

启用包含在运输中 3。

启用编译 AFSProject 4。

构建并运行 *注意：对于发布构建，请删除 Binaries、Intermediate 和 Saved 文件夹以及 dev APK。

对于开发，重置打包（步骤 15）以避免完全重建。* *为什么将 Meta Plugin 添加到 Project Plugins 文件夹？

Meta 的指南指向一个不存在的 Marketplace 文件夹。

此外，为每个项目创建一个插件文件夹允许您在不影响编辑器的情况下更新插件。** * *[针对 Meta Horizo​​n 进行了更新 - AS、JDK、SDK、NDK、目标更新、Android 14] **[**更新了发行版 - *genkeypair；我没那么老] *[v78 更新 - Horizo​​n Integration SDK]* *[v77 更新 - 微手势] [v76.0.1 更新 - 直通相机访问] [v76 更新 - UE5.5.4] [v72.1 更新 - 性能改进]* 玩得开心！
