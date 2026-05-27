# 在Visual Studio中使用AGDE调试

---
title: "在Visual Studio中使用AGDE调试"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/debugging-unreal-engine-projects-for-android-in-visual-studio-with-the-agde-plugin"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "移动端调试和优化", "Android调试", "在Visual Studio中使用AGDE调试"]
---

# 在Visual Studio中使用AGDE调试

> 路径：虚幻引擎5.7文档 / 移动端开发 / 移动端调试和优化 / Android调试 / 在Visual Studio中使用AGDE调试

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/debugging-unreal-engine-projects-for-android-in-visual-studio-with-the-agde-plugin

**虚幻引擎(UE)** 支持使用 **Visual Studio** 的[**Android游戏开发扩展(AGDE)插件**](https://developer.android.com/games/agde)进行调试，该插件为Visual Studio中的Android项目提供了调试和分析工具，无需将环境切换到Android Studio。对于Windows用户，这是UE中Android项目的推荐调试环境。

本指南将指导你完成下载和启用此插件，并提供了使用此插件的实用资源链接。

## 载和安装AGDE

若要安装AGDE插件并设置项目的解决方案来使用该插件，请执行以下步骤：

1. 确保你安装了 **Visual Studio 2022** ，并将其用作虚幻引擎的默认Visual Studio版本。
2. 从[Android开发人员页面](https://developer.android.com/games/agde)下载AGDE插件。当前UE需要23.1.82或更高版本的AGDE。
3. 将AGDE插件安装到Visual Studio。
4. 找到项目的.uproject文件，右键点击打开上下文菜单，然后点击 **生成项目文件（Generate Project Files）** 以重新生成Visual Studio解决方案。

新的解决方案文件将默认启用该插件。

## 验证你的JDK环境变量

从虚幻引擎5.3开始，AGDE和虚幻引擎需要 **OpenJDK 17.0.6 2023-01-17** 作为JDK目标版本。如果你使用全新安装的Android Studio和虚幻引擎5.3及更高版本，则无需执行其他步骤，因为UE的[Android SDK设置流程](../../../android-support/getting-started-and-setup-for-android-projects/advanced-setup-and-troubleshooting-guide-for-us-ec72c4a3/index.md)会自动设置此JDK版本。如果你是从较早的UE版本迁移，则执行以下步骤：

1. 打开 **系统设置（System Settings）** ，并点击 **环境变量（Environment Variables）** 。
2. 如果你看到名为 `AGDE_JAVA_HOME` 的环境变量，删除它。
3. 确保 `JAVA_HOME` 指向 `C:\Program Files\Android\Android Studio\jbr` 。

如果你需要维护较早虚幻引擎版本的安装，请参阅[设置Android SDK和NDK](../../../android-support/getting-started-and-setup-for-android-projects/advanced-setup-and-troubleshooting-guide-for-us-ec72c4a3/index.md)，了解有关如何在UE中手动定位SDK路径的信息。If you are working with an earlier version of Unreal Engine, refer to the documentation for that version.

## 使用AGDE启动项目

AGDE可以调试或附加到你的Android设备上的虚幻引擎应用程序。这需要你在Visual Studio中设置一些配置选项，还需要在使用AGDE之前打包APK，因为它可以编译你的Android项目的代码，但无法烘焙内容。执行以下步骤，在你的设备上启动项目。

1. 使用 **BuildCookRun** 命令为Android打包你的项目。你还可以使用 **Turnkey** 或 **虚幻编辑器（Unreal Editor）** 中的 **平台（Platforms）** 下拉菜单。

   ![点击](../../../../../assets/images/2c/2c1b287782662bfbd3ded8b0047f3abe4d8e7e8be469dd4d9a363457bb4dafd7.jpg)

   > [!TIP]
   > 请参阅"构建操作"和"烘焙内容"，详细了解烘焙和打包过程。
2. 打开你的项目的Visual Studio解决方案。
3. 将你的 **解决方案配置（Solution Configuration）** 设置为 **DebugGame** ，并将你的 **解决方案平台（Solution Platform）** 设置为 **Android** 。
4. 使用数据线将你想测试的Android设备插入计算机。设备会询问你授予USB调试权限或计算机访问设备数据的权限，此时请授予权限。

   > [!TIP]
   > 使用USB连接时，确保计算机上的数据线和端口都支持数据。
5. 用于构建和调试项目的按钮现在应该显示设备的名称。点击它或按 **F5** 开始调试。你可能需要等待调试器。

   > [!NOTE]
   > 如果你遇到SIGILL错误，请按F5跳过错误并继续运行AGDE。

项目将在你的设备上构建和启动，并且你将能够像使用Windows应用程序那样使用Visual Studio的调试工具。

## 将AGDE附加到应用程序

要附加到虚幻引擎应用程序的运行中实例，请执行以下步骤：

1. 点击工具栏中的 **调试（Debug）** 下拉菜单，然后点击 **附加到进程（Attach to Process）** 。

   ![点击](../../../../../assets/images/3e/3e35d83919c02790f124b676efeb8c9e214676dcea6453ac9c080dab18c34c4b.png)

   附加到进程"" loading="lazy" />
2. 将 **连接类型（Connection Type）** 设置为 **Android游戏开发扩展（Android Game Development Extension）** 。
3. 点击 **连接目标（Connection Target）** 下拉菜单，然后点击你的设备的条目。
4. 选择你的应用程序的进程，然后点击 **附加（Attach）** 。

   ![从菜单选择要附加到的进程](../../../../../assets/images/99/99e9ab46d158218c5b3f8caf7fefe042d58a7d6b4271e7bcd6c5c957ff1cb8b2.png)

## 错误调试

本章节针对在调试AGDE时可能出现的问题提供了修复和错误调试方面的提示。

### 修复Android 14设备上的断言

AGDE在Android 14设备上运行时，可能会抛出断言。要修复此断言，请按以下步骤操作：

1. 在Visual Studio中打开项目的 **配置属性（Configuration Properties）** 并点击 **调试（Debugging）**。
2. 在LLDB Post Attach Commands中，添加以下行：

   LLDB Post Attach Commands

   ```
        process handle --pass true --stop false --notify true SIGBUS
   ```

   [Under Configuration Properties > Debugging, fill LLDB Post Attach Commands with the text above.](https://dev.epicgames.com/documentation/404)

## 更多信息

有关AGDE的功能的更多信息，请参阅以下文档：

- **概述（Overview）** ：[https://developer.android.com/games/agde](https://developer.android.com/games/agde)
- **项目配置（Project Configuration）** ：[https://developer.android.com/games/agde/adapt-existing-project](https://developer.android.com/games/agde/adapt-existing-project)
- **调试人员指南（Debugger Guide）** ：[https://developer.android.com/games/agde/debugger](https://developer.android.com/games/agde/debugger)
- **分析（Profiling）** ：[https://developer.android.com/games/agde/measure](https://developer.android.com/games/agde/measure)

