---
title: "远程控制预设和Web应用程序"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/remote-control-presets-and-web-application-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "编辑器的脚本与自动化", "远程控制", "远程控制预设和Web应用程序"]
---

# 远程控制预设和Web应用程序

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 编辑器的脚本与自动化 / 远程控制 / 远程控制预设和Web应用程序

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/remote-control-presets-and-web-application-for-unreal-engine

利用 **远程控制预设（Remote Control Preset）**，收集任何UI参数或函数并组织到单个面板中，并向[远程控制API](../index.md)公开。这些参数和函数可以连接到 **远程控制Web界面（Remote Control Web Interface）** 插件配套的Web应用程序中的控件，以远程控制引擎。此Web应用程序具有内置的UI编辑器，可以用来自定义其界面，而不需要额外的代码来创建它或对其进行格式化。

由于这是Web应用程序，因此你可以同时运行多个客户端。在一个客户端中修改的任何属性都会通过Web服务器将其更改传播到所有其他客户端。这有助于在实时环境中创建协作式的工作流。

## [远程控制预设入门远程控制预设入门借助远程控制预设，你可以收集各种UI参数或函数，并将它们整理到单个面板中，然后向远程控制API公开。](getting-started-with-remo-1077b97f/index.md) [远程控制协议远程控制协议借助远程控制协议，你可以将协议输入数据绑定给被暴露的属性，从而通过外部设备控制属性。](remote-control-protocols/index.md)

- [远程控制Web应用程序](remote-control-web-application/index.md) - 学习如何通过随附的远程控制Web应用来控制引擎，以及如何使用使用内置UI编辑器，在不创建额外代码或执行格式化的情况下创建自定义UI。

- [远程控制面板参考](remote-control-panel-reference/index.md) - 本页面将简要介绍远程控制面板中包含的界面元素和选项。
