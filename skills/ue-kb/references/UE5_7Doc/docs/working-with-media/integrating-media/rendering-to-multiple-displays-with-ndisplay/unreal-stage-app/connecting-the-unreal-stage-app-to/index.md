---
title: "将Unreal Stage应用程序连接到虚幻引擎"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/connecting-the-unreal-stage-app-to-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "使用nDisplay在多显示屏上进行渲染", "Unreal Stage应用程序", "将Unreal Stage应用程序连接到虚幻引擎"]
---

# 将Unreal Stage应用程序连接到虚幻引擎

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 使用nDisplay在多显示屏上进行渲染 / Unreal Stage应用程序 / 将Unreal Stage应用程序连接到虚幻引擎

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/connecting-the-unreal-stage-app-to-unreal-engine

## 连接屏幕

在平板电脑上启动Unreal Stage后，它会要求你根据IP地址连接到虚幻引擎编辑器的实例。 随后它会扫描网络，如果发现任何启用了远程控制的虚幻引擎实例，那么这些实例会被自动列为可选项。应用程序会记住你上次连接的IP地址。如果没有检测到任何IP地址，你也可以手动输入一个地址。

## 场景中存在多个nDisplay根Actor

如果场景中存在多个nDisplay根Actor，Unreal Stage会提示你选择一个来进行控制。 当存在多个nDisplay根Actor时，此设置会在按场景在各个会话中被记住，且可通过设置（Settings）进行修改。
