# 远程控制C++ API

---
title: "远程控制C++ API"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/remote-control-cplusplus-api-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "编辑器的脚本与自动化", "远程控制", "远程控制C++ API"]
---

# 远程控制C++ API

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 编辑器的脚本与自动化 / 远程控制 / 远程控制C++ API

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/remote-control-cplusplus-api-for-unreal-engine

借助远程控制C++ API，你可以访问远程控制插件的不同部分。你可以用虚幻引擎编写自定义的集成内容以及远程控制适配器，还可以使用自定义传输来访问远程控制实体。

本文将介绍远程控制C++ API，并提供了包含更多详情的虚幻引擎C++ API参考链接。

## 工作流程

1. 你可以在虚幻引擎项目中设置服务器，以在虚幻引擎和你的C++应用程序之间发送和接收数据。例如，你可以使用和。
2. 创建外部C++应用程序，以便在虚幻引擎项目中从服务器接收数据以及向服务器发送数据。
3. 在虚幻引擎项目中创建解析器和管理器，以处理接收的数据和调用远程控制函数。

## API

远程控制C++ API的核心功能由以下类构成：

- : 访问可以在[模块](../../../using-the-unreal-engine-build-pipeline/unreal-build-tool/module-properties/index.md)范围内使用的功能，例如获取或解析远程控制预设。
- : 包括对以下各项的访问权限：

  - 包含暴露函数、属性和Actor的目标。
  - 使用了唯一ID和标签的getter，用于被暴露的实体（例如属性、函数和Actor），以便你可以通过编辑器、游戏模式、模拟和程序包访问实体。
  - 属性更改侦听器。
  - 指定何时公开或不公开实体。
- : 访问暴露的对象、属性、函数和Actor及其元数据（metadata）。
- : 表示暴露给远程控制的属性，同时包含对 `FProperty` 和 `RemoteControlPropertyHandle` 的访问权限，以获取和设置暴露属性的数值。
- : 访问 `UFunction` 指针和函数参数，以便使用 `UObject->ProcessEvent(UFunction*, ArgumentsMemory)` 来调用特定对象上的函数。
- : 访问被暴露的Actor的指针。
- : 访问getter和setter，以修改被暴露的属性的数值，并访问复杂类型的子属性。

> [!NOTE]
> 如果是简单的属性类型，可以直接获取和设置数值。简单的属性类型包括整型、浮点数、双精度浮点数、字符串、向量和旋转度。
>
> 如果是复杂类型，例如TArray、TMap、TSet和结构体，你不能直接获取和设置属性值，而是必须访问子属性句柄（child property handle）；如果子属性是简单的属性类型，你就可以获取和设置其数值。

- DisplayClusterRemoteControlInterceptor

  : 使用此项来设置所有可通过nDisplay复制的属性值。

