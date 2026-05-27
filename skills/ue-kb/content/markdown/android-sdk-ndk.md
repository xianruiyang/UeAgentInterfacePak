# 设置Android SDK和NDK

---
title: "设置Android SDK和NDK"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/set-up-android-sdk-ndk-and-android-studio-using-turnkey-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "Android支持", "虚幻引擎Android项目入门指南", "设置Android SDK和NDK"]
---

# 设置Android SDK和NDK

> 路径：虚幻引擎5.7文档 / 移动端开发 / Android支持 / 虚幻引擎Android项目入门指南 / 设置Android SDK和NDK

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/set-up-android-sdk-ndk-and-android-studio-using-turnkey-for-unreal-engine

虚幻引擎（UE）会使用**Android Studio**和**Android SDK命令行工具**下载并安装在开发Android项目时所需的Android SDK组件。

### 安装摘要

要安装Android SDK，请执行以下步骤：

1. 运行**Turnkey**以自动下载并安装所需的Android Studio版本。
2. 配置Android Studio安装以下载Android SDK命令行工具。
3. 关闭Android Studio，并让Turnkey继续安装所需的Android SDK组件。
4. 重启计算机。

以下小节将更详细地介绍这些步骤。

> [!WARNING]
> 如果你没有安装Android SDK命令行工具，Turnkey将无法下载Android NDK和其他所需组件。 切勿遗漏这一步！

### 所需版本

以下是在虚幻引擎中开发Android项目所需的软件组件：

> [!WARNING]
> 自2024年8月31日起，Google Play商店要求应用程序针对Android 14进行适配，这需要API级别34。 要在Google Play商店发布新应用程序，你必须更新到UE 5.4.4或更高版本以支持目标SDK 34。 使用旧版虚幻引擎编译的应用程序将无法再成功提交。 如需更多信息，请参阅[Google Play关于目标API级别要求的Android文档](https://developer.android.com/google/play/requirements/target-sdk)。

- 当前UE版本：5.6
- Android Studio版本：Koala 2024.1.2 2024年8月29日
- Android SDK：

  - 推荐版本：SDK 34
  - 用于编译的最低版本：SDK 34
  - 用于在设备上发布的默认目标SDK版本：34
  - 最低安装SDK级别：26

    > [!NOTE]
    > 不同商城对于目标SDK最低版本的要求是不同的，可能与上文有所不同。
- NDK版本： r27c
- 编译工具：34.0.0
- Java运行时： OpenJDK 21.0.3 2024-04-16
- [AGDE调试](../../../debugging-and-optimization-for-mobile/debugging-for-android-devices/debugging-unreal-engine-projects-for-android-in-8ae85ef6/index.md)需要AGDE v23.2.91+。

## 必要设置

要使用本安装指南，你必须安装虚幻引擎5.4或更高版本。 Android Turnkey安装过程在UE 5.3或更低版本中不可用。 如需这些版本的安装说明，请参阅[高级Android Studio设置指南](../advanced-setup-and-troubleshooting-guide-for-us-ec72c4a3/index.md)。

## 运行Turnkey以开始安装Android Studio

UE使用名为Turnkey的**虚幻自动化工具**脚本在团队中分发SDK。 通常，Turnkey要求你将平台的SDK安装文件放在团队的公共位置。 但是，Android Studio向公众开放，因此Turnkey可以自动下载它并开始设置，无需任何额外步骤。

> [!TIP]
> 有关MetaSound的更多信息，请参阅[MetaSound文档。

### 在虚幻编辑器中运行Turnkey

要在虚幻编辑器中运行Android Turnkey安装过程，请执行以下步骤：

1. 打开**虚幻编辑器（Unreal Editor）**。
2. 点击**平台（Platforms）** > **Android** > **安装SDK（Install SDK）**。

### 通过命令行运行Turnkey

要通过命令行运行Android Turnkey安装过程，请执行以下步骤：

1. 打开命令行。
2. 找到虚幻引擎安装目录并运行以下命令：

   命令行

   C++

   ```
   RunUAT.bat Turnkey -Command=InstallSDK Platform=Android
   ```

## 设置Android Studio和Android命令行工具

无论你使用哪种方法运行Turnkey，它都会下载Android Studio并自动开始安装。 但在此之前，你必须自己查看安装向导并下载Android SDK命令行工具，以便Turnkey可以获取UE所需的其他组件。 要完成安装，请执行以下步骤：

1. 当系统提示你选择组件时，请保持默认组件处于启用状态。
2. 当系统提示你选择安装目录时，请使用默认目录。

   > [!NOTE]
   > 如果你不使用默认安装目录，Turnkey将无法找到后续步骤所需的文件。 我们强烈建议保留默认目录。 要指定单独的目录，请参阅[高级Android Studio设置指南](../advanced-setup-and-troubleshooting-guide-for-us-ec72c4a3/index.md)。
3. 安装完成后，打开Android Studio。
4. 在**欢迎使用Android Studio（Welcome to Android Studio）**对话框中，点击**更多操作（More Actions）**，然后点击**SDK 管理器（SDK Manager）**。

   !["欢迎（Welcome）"对话框中SDK管理器快捷方式的位置](../../../../../assets/images/06/068cf68c625e0ab56fa240685ad761a093b2bff7e03bd38e3487bbbb4bea17aa.jpg)

此操作将打开Android Studio设置（Android Studio Settings）菜单，其位于外观和行为（Appearance and Behavior） > 系统设置（System Settings） > Android SDK。

1. 点击**SDK工具（SDK Tools）**选项卡。
2. 勾选**Android SDK命令行工具（最新）（Android SDK Command-Line Tools (latest)）**，然后点击**应用（Apply）**。 此操作将下载命令行工具，这些工具是自动配置虚幻引擎Android Studio所必需的。

   ![Android设置菜单。 Android SDK分段打开，并且被设置为SDK工具选项卡，Android SDK命令行工具被勾选。](../../../../../assets/images/ed/ed764091f831b458b06583ed121f6ff9eb4722a11d2d75ddafbb7b6a29925f4e.jpg)
3. 单击**确定（OK）**关闭"设置（Settings）"窗口，然后关闭"欢迎使用Android Studio（Welcome to Android Studio）"对话框。
4. 关闭Android Studio并返回虚幻编辑器或命令行。

## 完成并验证你的SDK设置

关闭Android Studio后，Turnkey会继续下载并安装其他Android SDK组件。 该过程完成后，会出现提示，告知你是否安装成功。

要完成Android SDK安装并确保其正常工作，请执行以下步骤：

1. 关闭虚幻编辑器或命令行。
2. 要最终确定你的Android环境变量，请从你的机器登出，然后重新登录。
3. 打开虚幻编辑器，点击**平台（Platforms）** > **Android**。 SDK的允许版本和安装版本应该匹配，并且你不应看到安装或修复Android SDK的按钮。

   !["平台（Platforms）"下拉菜单显示Android SDK安装成功。](../../../../../assets/images/cb/cb4c2dba3b4a9fc0b7ab216543301918662eae4b7ac82dcc586dcfa79a2e95db.jpg)

## 故障排除

如果你是在新系统安装，完成上述步骤后，SDK设置应该能正常运行。 然而，旧环境变量和安装可能会有冲突。 如需了解在无法设置Android SDK时如何诊断和修复问题，请参阅[高级Android Studio设置指南](../advanced-setup-and-troubleshooting-guide-for-us-ec72c4a3/index.md)。

