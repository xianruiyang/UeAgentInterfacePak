---
title: "远程控制"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/remote-control-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "编辑器的脚本与自动化", "远程控制"]
---

# 远程控制

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 编辑器的脚本与自动化 / 远程控制

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/remote-control-for-unreal-engine

虚幻编辑器提供了一套强大的工具，几乎可以操纵项目内容的方方面面。但在某些情况下，要在大型内容编辑流程中成功使用引擎，需从编辑器UI以外对项目进行修改。例如，广播电视和电影制片需要操作者能够借助有限的一组常用功能进行方便快捷的控制。而他们必须通过在流程中使用的其他软件集成的自定义UI来访问这些功能。

远程控制（Remote Control）系统实现了这一目标，它在虚幻引擎中运行一个网络服务器，服务由远程网络应用程序通过类似REST API发出的WebSocket消息和HTTP请求。

在适当的情形下，这套系统能提供多种优点：

- 可创建全新UI与项目内容进行交互，重点是对特定用例有意义的对象和属性。
- 可将这些自定义UI与已在使用的第三方应用程序整合在一起，或作为为组织创建的其他网络应用的一部分。
- 用户可以从连接到运行虚幻引擎的计算机所在网络的其他计算机或移动设备远程操作引擎。

## 它的作用

远程控制API提供的对虚幻编辑器和项目内容的控制与使用蓝图和Python时类似。

- 你的Web应用程序可调用公开到蓝图和Python的任意函数。
- 你的Web应用程序可读写暴露给蓝图、Python或

  远程控制预设（Remote Control Preset）

  的任何属性的值。

无需任何编码，你就可以通过 **远程控制预设（Remote Control Preset）** 将项目内容暴露给远程控制API，并将它们与配套Web应用中的控件相连接。更多细节请参见[远程控制预设和Web应用](remote-control-presets-and-web-application/index.md)。

只要有一些巧思和网络开发技能，即可将这些相对简单的构件用作基础来打造自己的编辑工具。

> [!NOTE]
> 在[打包](https://dev.epicgames.com/documentation/404)项目或以 `-game` 启动项目时，远程控制会默认被禁用，以配合虚拟制片工作流。在启动项目实例时，你可以在命令行中添加下列参数来启用远程控制：
>
> ```
> 	-RCWebControlEnable -RCWebInterfaceEnable
> ```

## 入门

- [远程控制快速入门](remote-control-quick-start/index.md) - 通过网页远程控制虚幻编辑器的详细步骤说明。

- [远程控制C++ API](remote-control-cplusplus-api/index.md) - 学习如何使用远程控制C++ API来远程控制引擎。

## 参考

- [远程控制API WebSocket参考](remote-control-api-websocket-reference/index.md) - 远程控制API提供的、用于远程控制引擎的WebSocket端点的详情。

- [远程控制预设API HTTP参考](remote-control-preset-api-http-reference/index.md) - 详细介绍远程控制API所提供的，用于访问远程控制预设中公开的属性和函数的HTTP端点。

- [远程控制API HTTP参考](remote-control-api-http-reference/index.md) - 关于远程控制API所提供的HTTP端点的详细信息。
