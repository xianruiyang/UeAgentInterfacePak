---
title: "虚幻编译工具"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-build-tool-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "用虚幻构建管线", "虚幻编译工具"]
---

# 虚幻编译工具

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 用虚幻构建管线 / 虚幻编译工具

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-build-tool-in-unreal-engine

**虚幻编译工具（UBT）** 是一个自定义工具，负责管理通过各种编译配置来编译 **虚幻引擎（UE）** 源代码的过程。请阅读 `BuildConfiguration.cs`，了解诸多用户可配置的编译选项。

## 模块化架构

虚幻引擎被划分为多个模块。每个模块都拥有控制其编译方式的.build.cs文件，包括定义模块相依性的选项、额外的库、包含路径等。这些模块被默认编译为DLL文件，并通过单一可执行文件进行加载。可选择在BuildConfiguration.cs文件中编译一个单块可执行文件。

需要注意的是，开发环境任意项目文件（如Visual Studio的 `.sln` 或 `.vcproj` 文件）的编译进程均为独立进行。这些文件有助于进行编辑，因此提供了一个工具来动态生成它们（基于项目目录树内容）。使用保存在 `[Unreal Engine Root Directory]` 目录下的 `GenerateProject.bat` 文件即可运行此工具。

> [!NOTE]
> **注意：** 不时运行 `GenerateProject.bat` 将使代码编辑器与硬盘上正在添加（删除）的文件保持同步更新。

## 主题

- [目标](unreal-engine-build-tool-target-reference/index.md) - UBT目标概述，包括属性说明。

- [模块属性](module-properties/index.md) - 虚幻编译工具模块概述，包括属性说明。

- [编译配置](build-configuration/index.md) - 配置引擎的编译方式。

- [IWYU](include-what-you-use-iwyu-for-unreal-engine-programming/index.md) - 虚幻引擎更新基本代码的概览。此基本代码使用

- [IDE的项目文件](how-to-generate-unreal-engine-project-files-for-your-ide/index.md) - 关于自动为当前工作区中的游戏和模块生成项目文件的的指南。

- [二进制文件版本划分](how-to-version-binaries/index.md) - 虚幻引擎BuildID系统的参考，其可缓解由过期DLL文件造成的潜在错误。

- [第三方库](integrating-third-party-libraries-into/index.md) - 将第三方库集成到虚幻引擎中

- [静态代码分析](static-code-analysis/index.md) - 虚幻编译工具支持运行各种静态代码分析器。

- [使用Clang构建Microsoft平台](use-clang-to-build-microsoft-platforms/index.md) - 通过构建配置、命令行参数或引擎配置指定Clang选项。
