# Android设备上的Unreal Insights

---
title: "Android设备上的Unreal Insights"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/how-to-use-unreal-insights-to-profile-android-games-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "移动端调试和优化", "虚幻引擎Android优化指南", "Android设备上的Unreal Insights"]
---

# Android设备上的Unreal Insights

> 路径：虚幻引擎5.7文档 / 移动端开发 / 移动端调试和优化 / 虚幻引擎Android优化指南 / Android设备上的Unreal Insights

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/how-to-use-unreal-insights-to-profile-android-games-for-unreal-engine

[Unreal Insights](../../../../testing-and-optimizing-content/unreal-insights/index.md)是一款性能分析工具，可以记录并查看 **虚幻引擎（UE）** 应用程序的性能数据，包括部署到目标设备的构建。要记录跟踪会话，你需要使用Unreal Insights命令行参数运行应用程序。而要将这些参数推送到Android设备上需要一些额外的步骤，本指南将就此做出详细介绍。

通过本指南，你将学会：

- 通过你安装的虚幻引擎设置Unreal Insights。
- 将一个构建部署到Android设备。
- 将 `UECommandline.txt` 添加到部署好的Android应用程序，提供记录Unreal Insights跟踪信息所需的参数。
- 启动Unreal Insights并将其附加到Android设备上的构建。

## 推荐设置与先决条件

本指南适用于任何Android项目，但本文中使用的新项目设置如下：

- 俯视角模板（Top-Down Template）
- 移动/平板设备平台（Mobile/Tablet Platform）
- 可伸缩2D/3D质量（Scalable 2D/3D Quality）
- 无初学者内容包（No Starter Content）

为了按本指南操作，你还需要：

- 兼容你所使用的虚幻引擎版本的Android SDK版本，详见[Android SDK设置指南](https://dev.epicgames.com/documentation/404)。
- 为项目启用Android支持，详见[Android快速入门](../../../android-support/getting-started-and-setup-for-android-projects/setting-up-unreal-engine-projects-for-android-d-db209844/index.md)指南。
- 一台已针对你的计算器进行过USB或WiFi调试设置的安卓设备，详见[设置Android设备](../../../android-support/getting-started-and-setup-for-android-projects/setting-up-your-android-device-for-developing-a-f537b307/index.md)。

## 编译Unreal Insights

在你的虚幻引擎安装目录下，检查所使用的操作系统对应的 `Engine/Binaries/` 文件夹，确认Unreal Insights是否已编译。例如在Windows系统上，如果Unreal Insights已编译完成，你就能在 `Engine/Binaries/Win64` 中看到UnrealInsights.exe。

![image alt text](../../../../../assets/images/f3/f3653f63b95dbe11154bb55e67dff112f9a3098bed72a522ec54354203479679.png)

该可执行文件可在通过Epic Games启动程序分发的构建中获取。如果你使用的是源代码构建，而该文件未出现，请在你的IDE中打开虚幻引擎解决方案，并编译位于"Programs/UnrealInsights"下的项目。

![image alt text](../../../../../assets/images/24/24469cfda12a60e272d52305bbc72ca89916722974f39a8d2e9cd0ac96581038.png)

## 为项目启用AndroidFileServer

在后续步骤中，你需要将一个命令行文件推送到Android设备，以启用Unreal Insights跟踪通道。为此，你需要Android File Server（AFS）插件。它会将一个文件服务器嵌入你的项目，你可以通过Unreal Android File Tool（UAFT）连接到该服务器。这是Android Debug Bridge（adb）的替代方案，专为虚幻引擎项目设计，可以让你更直接地访问UE应用程序及其文件路径。要将AFS添加到项目，请按以下步骤操作：

1. 启用AndroidFileServer插件。
2. 在 **项目设置（Project Settings）** > **插件（Plugins）** > **AndroidFileServer** 下启用 `使用AndroidFileServer（Use AndroidFileServer）` 设置。这可以让你连接到 **UnrealAndroidFileTool（UAFT）** 并在后续步骤中管理文件。
3. 根据所在组织的安全和网络要求配置其他设置。

关于配置AFS和UAFT的更多详情，请参阅[其相关文档](../../debugging-for-android-devices/android-file-server/index.md)。

> [!TIP]
> 本指南使用设备序列号连接UAFT，但你可以使用 **插件（Plugins）** > **AndroidFileServer** 设置中的 **安全令牌（Security Token）**。

## 打包虚幻Android项目

打包你的UE项目并将其推送到Android设备。详细的打包指南，请参阅[打包Android项目](../../../android-support/packaging-and-publishing-android-projects/packaging-android-projects/index.md)一文。如果你已经设置好了测试设备，可以在虚幻编辑器中使用的 **平台（Platforms）** 下拉菜单顶部的 **快速启动（Quick Launch）** 选项编译项目并将其直接推送到设备。

关于项目打包的更多详情，请参阅[构建操作](../../../../sharing-and-releasing-projects/packaging-and-cooking/cooking-content/index.md)一文。

## 在设备管理器中连接到Android设备

要在设备上查看实时跟踪信息，你需要将为设置为USB或Wi-Fi调试模式，并确保其在 **设备管理器（Device Manager）** 中处于可用状态。关于如何设置Android设备以连接到UE，详见[设置Android设备](../../../android-support/getting-started-and-setup-for-android-projects/setting-up-your-android-device-for-developing-a-f537b307/index.md)一文。关于设备管理器的使用详情，请参阅[设备管理器](../../../../sharing-and-releasing-projects/tools-for-general-platform-support/connecting-to-and-managing-devices/index.md)一文。

## 将UECommandline.txt添加到Android设备并启用跟踪功能

你的应用程序必须通过一组命令行参数运行，才能在Unreal Insights中启用跟踪会话。Android上的UE应用程序可以同过一个名为 `UECommandline.txt` 的文件接收命令行参数。要将包含Unreal Insights所需参数的 `UECommandline.txt` 推送到设备，请按以下步骤操作：

1. 在你的虚幻引擎安装目录中，打开 `Engine/Build/Android/UnrealGame` 文件夹。
2. 新建一个名为 `UECommandline.txt` 空白txt文件。
3. 将以下参数添加到该txt文件，并将[ProjectName]替换为你的项目名称：

   示例UECommandline.txt

   ```
        ../../../[ProjectName]/[ProjectName].uproject		-tracehost=127.0.0.1	-cpuprofilertrace
   ```

   你可以使用以下参数获取额外的加载时间信息

   示例UECommandline.txt

   ```
        ../../../[ProjectName]/[ProjectName].uproject  -tracehost=127.0.0.1 -filetrace -loadtimetrace  -statnamedevents -trace=Bookmark,Frame,CPU,GPU,LoadTime,File
   ```
4. 通过 `devices` 命令运行 `UnrealAndroidFileTool.exe`，查看连接到你的计算机的设备列表。记下目标设备的序列号，但要去掉 `@` 前缀。
5. 使用shell命令运行 `UnrealAndroidFileTool.exe` 来以交互模式将其连接到你的设备。以下是一个示例，用于通过设备序列号和 `ExampleGame` 的数据包名称名连接到设备。请将示例序列号替换为你在上一步中获取的那个，并将数据包名称替换为你的应用程序的数据包名称。

   命令行

   ```
        UnrealAndroidFileTool.exe -s AB187923123CD123 -p -k [security token] com.OrganizationName.ExampleGame shell
   ```
6. 使用 `push` 命令将 `UECommandLine.txt` 运送到你的设备，使用 `"commandfile` 快捷方式代替目标路径。在下面的示例中，项目名称为即可ExampleGame。

   命令行

   ```
        push D:/UnrealEngine/Projects/ExampleGame/Engine/Build/Android/UnrealGame/UECommandLine.txt ^commandfile
   ```
7. 运行 `quit` 或 `exit` 命令关闭UAFT。

   命令行

   ```
        quit
   ```

如果你使用文件系统浏览设备，可以在设备的 `UEGame/[ProjectName]` 目录中看到一个 `UECommandline.txt`。现在，在启动应用程序时，它会为Unreal Insights记录跟踪数据了。你可以通过更多命令行配置要激活的跟踪通道和功能，详见[Unreal Insights](../../../../testing-and-optimizing-content/unreal-insights/index.md)一文。

## 通过实时跟踪会话启动Timing Insights

1. 打开你的虚幻引擎安装目录，找到 `Engine/Binaries` 文件夹。
2. 在平台对应文件夹中找到 `UnrealInsights.exe`，双击打开Unreal Insights。
3. 在Unreal Insights的 **会话浏览器（Session Browser）** 中，选择状态为 **LIVE** 的，正在你的Android设备上运行的会话，然后点击 **打开（Open）** 按钮。

   ![image alt text](../../../../../assets/images/ea/eaee4d2deff7fdaa73f77ff1a7f90da5198724cd11224563545bbef07d6990b2.png)

   Timing Insights窗口会出现，显示你的CPU和GPU线程处理数据的情况。

此时，你就可以使用Unreal Insights分析项目在Android设备上的性能了。

## 从Android设备加载记录的跟踪会话

Unreal Insights跟踪会话会被记录下来，以便在开发者之间传递并进行异步检查。你可以通过以下步骤从设备中获取跟踪会话文件：

1. 通过shell命令运行UAFT，以交互模式将其连接到你的设备。下面的示例使用了占位符来表示设备的序列号，以此来指定目标设备。

   命令行

   ```
        UnrealAndroidFileTool.exe -s AB187923123CD123 -p com.OrganizationName.ExampleGame -k [security token] shell
   ```
2. 通过 `pull` 命令拉取要存放在计算机上的跟踪文件。它应该会被保存在你的游戏的 `Saved/Traces` 目录中，你可以通过 `^saved` 快捷方式来访问它。

   命令行

   ```
        pull ^saved/Traces/2202999_112345.trace D:/Insights/MyProject/Saved/Traces
   ```

   你通过一个文件路径指定的跟踪文件会出现在你本地计算机上通过第二个文件路径指定的目录中。

   > [!TIP]
   > 如果你不确定跟踪文件的名称或文件路径，可以使用 `ls` 命令和 `-R` 参数获取项目目录中的文件列表。使用 `^project` 快捷方式可以从顶层快速访问它。
   >
   > 命令行
   >
   > ```
   >      ls -R ^unreal
   > ```
3. 运行 `quit` 或 `exit` 命令关闭UAFT。

   命令行

   ```
        quit
   ```
4. 运行Unreal Insights并加载跟踪会话。

## 扩展阅读

关于Unreal Insights分析工具套件的更多使用详情，请参阅[Unreal Insights文档](../../../../testing-and-optimizing-content/unreal-insights/index.md)。

关于Android File Server和UAFT的赓续哦详情，请参阅[Android File Server文档](../../debugging-for-android-devices/android-file-server/index.md)。

