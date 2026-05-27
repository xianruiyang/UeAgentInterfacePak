# AutoSDK参考

---
title: "AutoSDK参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-the-autosdk-system-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "常用平台支持", "AutoSDK参考"]
---

# AutoSDK参考

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / 常用平台支持 / AutoSDK参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-the-autosdk-system-in-unreal-engine

**AutoSDK** 系统提供的机制可以分发目标平台SDK，并根据需要对其进行配置，以便引擎使用。此系统专为编译机设计，可为SDK要求不同的多个分支提供服务，无需手动管理安装包，开发者无需完整安装SDK也可以进行使用。通常情况下，默认只提供基本的工具集（例如编译器或部署软件）。

[虚幻编译工具](../../../production-pipeline/using-the-unreal-engine-build-pipeline/unreal-build-tool/index.md)、[自动化工具](../../../production-pipeline/using-the-unreal-engine-build-pipeline/unreal-automation-tool/index.md)和虚幻编辑器都能与AutoSDK无缝对接，而SDK之间的切换由虚幻编译工具（UBT）负责处理（其由其他工具调用）。

针对各个引擎版本，虚幻编译工具都有一个尝试使用的首选SDK版本。此版本通常由派生自UBT源代码中 `UEBuildPlatform` 的类来定义。

## 设置

出于法律原因，Epic无法分发SDK，该目录树便是构建SDK的模板。我们建议您从AutoSDK空文件夹开始操作，并在添加特定SDK版本时从此处复制文件。

> [!WARNING]
> 请勿将AutoSDK系统配置为使用此文件夹。这只是一个模板，如果不添加其他文件，系统将无法运行。

为便于在一台机器的多个分支上共用，应将AutoSDK文件夹单独提交给游戏或引擎代码的源码管理。

想使用AutoSDK的开发者都可以将其同步，并设置 `UE_SDKS_ROOT` 环境变量指向其本地机上包含AutoSDK的UBT路径。

## 布局

AutoSDK目录结构的较为宽松，通常由每个平台自行决定，但是目录结构将遵循此通用模式。

| 目录结构 | 定义 |
| --- | --- |
| `/HostPlatform/` | 可以使用SDK的主机平台。 |
| `/HostPlatform/TargetPlatform/` | 包含"HostPlatform""TargetPlatform"SDK的目录（例如"/HostWin64/Android/"）。 |
| `/HostPlatform/TargetPlatform/1.0/` | 包含"HostPlatform""TargetPlatform" 1.0 SDK的目录。 |
| `/HostPlatform/TargetPlatform/1.0/Setup.bat` | 设置此SDK时运行的可选批处理文件。在Mac/Linux上，该文件为"setup.sh"。 |
| `/HostPlatform/TargetPlatform/1.0/Unsetup.bat` | 移除此SDK时运行的可选批处理文件。在Mac/Linux上，该文件为"unsetup.sh"。 |

运行时，Setup.bat将把名为 `OutputEnvVars.txt` 的文本文件输出到同一目录，其中包含以 `NAME=VALUE` 形式设置的环境变量列表，以及用于修改 `PATH` 环境变量的特殊指令，例如 `ADDPATH=Foo` 和 `STRIPPATH=Foo`。

> [!TIP]
> 此目录中包含Epic为支持SDK版本编写的设置脚本。

## 平台

如需了解为每个平台添加SDK的更多信息，请查阅HostPlatform/TargetPlatform子文件夹中的README.md文件。

