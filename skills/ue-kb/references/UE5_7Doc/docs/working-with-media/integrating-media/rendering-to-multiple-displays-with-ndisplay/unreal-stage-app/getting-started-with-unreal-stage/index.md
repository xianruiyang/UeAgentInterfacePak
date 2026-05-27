---
title: "Unreal Stage快速入门"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/getting-started-with-unreal-stage-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "使用nDisplay在多显示屏上进行渲染", "Unreal Stage应用程序", "Unreal Stage快速入门"]
---

# Unreal Stage快速入门

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 使用nDisplay在多显示屏上进行渲染 / Unreal Stage应用程序 / Unreal Stage快速入门

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/getting-started-with-unreal-stage-in-unreal-engine

## 什么是Unreal Stage？

Unreal Stage是一款由Epic创建的应用程序，允许用户使用平板电脑作为物理空间中某些功能的无线控制面板。如果你需要边调整边查看相关功能（例如电影场景的光照），但计算机却需要远离舞台以便为物理设备和布景腾出空间，那么Unreal Stage就尤其适合。

设置完成后，即使不熟悉虚幻引擎的人，也能使用Unreal Stage的简化界面自主、高效地管理这些变量。

如果你有使用nDisplay的经验，并且对虚幻引擎的远程控制功能有所了解，那么本教程将非常有效。你可以将Unreal Stage作为摄像机内视觉特效处理（ICVFX）功能的移动版本来使用，ICVFX提供了这些功能按钮的引擎内内桌面版本。你将需要一台平板电脑才能使用Unreal Stage。

## 安装Unreal Stage

Unreal Stage专为平板电脑而设计。它不适用于包括手机在内的其他移动设备。该应用程序可直接从Apple App Store下载，且建议使用iPad。不过你也可以从GitHub下载Android版本。

### iOS应用程序

从Apple App Store为你的iPad安装Unreal Stage应用程序：

- Unreal Stage iOS应用程序

### Android支持

Unreal Stage是一款基于Flutter的应用程序，如有必要，可以在Android设备上部署并运行。该应用程序的源代码可在Github上找到：

- 虚幻引擎5/主版本上的Unreal Stage源代码

用户必须登录并将其Github账号与Epic Games账号绑定，才能访问GitHub上的虚幻引擎源代码。[点击此处了解如何绑定账号。](https://www.unrealengine.com/ue-on-github)

## 虚幻项目设置

请确保你的虚幻项目启用了以下插件（文件（File） > 插件（Plugins））：

- Epic Stage应用程序
- nDisplay
- 远程控制API（Remote Control API）
- 远程控制Web界面（Remote Control Web Interface）

或者，启用ICVFX插件也能确保启用所有必要的插件。启用所有插件后，重新启动虚幻引擎。

重新打开虚幻关卡后，请确保场景中有一个nDisplay根Actor。这是应用程序将连接和控制的对象。
