# 支持适用于macOS的通用二进制文件

---
title: "支持适用于macOS的通用二进制文件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/supporting-universal-binaries-for-macos-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "MacOS", "打包和发布", "支持适用于macOS的通用二进制文件"]
---

# 支持适用于macOS的通用二进制文件

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / MacOS / 打包和发布 / 支持适用于macOS的通用二进制文件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/supporting-universal-binaries-for-macos-in-unreal-engine

随着Apple M1处理器的推出，从2021年开始的Mac机型采用ARM64架构制造。 同时，上一代基于Intel的Mac机型使用x86-64架构。

尽管Apple提供了一个名为 **Rosetta2** 的指令转换器来支持旧版应用程序，但Apple的商店要求开发者为游戏提供单个通用二进制文件以涵盖这两种架构的切片。 这样可以确保两代硬件的最佳性能和稳定性。 本页介绍了虚幻引擎与这两种架构的兼容性，以及如何调整通用二进制文件。

## 先决条件

本页上的说明假定在macOS上使用Xcode来构建项目。 在继续之前，还应该熟悉 [**虚幻自动化工具**](../../../../production-pipeline/using-the-unreal-engine-build-pipeline/unreal-automation-tool/index.md)（UAT）和 **BuildCookRun** 命令。

## 配置macOS架构

可以通过多种方式指定构建的目标架构：

- 在UAT中，使用

  -specifiedarchitecture

  或

  -architecture=

  参数设置编译采用的架构。
- 在Xcode中，从IDE顶部的下拉列表中选择目标设备。
- 在虚幻编辑器中单击"平台（Platforms）">"macOS"并选择架构。

以下是适用于Apple设备的有效架构：

| 架构 | 兼容设备 |
| --- | --- |
| `x86_64` | 搭载Intel处理器的MacOS设备。 |
| `arm64` | 搭载M1和M2或更新版处理器的MacOS设备。 |
| `arm64+x86_64` | 所有MacOS设备。 |

## 虚幻编辑器对通用二进制文件的支持

在UE 5.2+中，随Epic Games启动程序一起分发的macOS版虚幻编辑器是使用通用二进制文件构建的。 虚幻编辑器将自动使用适合相应设备架构的切片。

在Xcode中使用源代码构建编辑器时将自动使用x64架构，但可以将架构设置为 `arm64+x86_64` 以改用通用二进制文件来构建编辑器。

要改为针对x86构建编辑器，请将目标设备从 **我的Mac（My Mac）** 更改为 **我的Mac（Rosetta）（My Mac (Rosetta)）**。

## 为ARM64和x86-64创建二进制文件

要使用通用二进制文件来构建项目，请使用 `arm64+x86_64` 作为 `BuildCookRun` 中的架构。

```
	-specifiedarchitecture=arm64+x86_64
```

这样将生成一个包含ARM64和x86-64架构切片的项目。 这些构建结果可以分发到任一类型的设备，并将自动根据架构使用相应的二进制文件。

