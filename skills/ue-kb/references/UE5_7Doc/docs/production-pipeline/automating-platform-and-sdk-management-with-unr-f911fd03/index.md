---
title: "虚幻Turnkey"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/automating-platform-and-sdk-management-with-unreal-turnkey"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "虚幻Turnkey"]
---

# 虚幻Turnkey

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 虚幻Turnkey

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/automating-platform-and-sdk-management-with-unreal-turnkey

**Turnkey** 是在 **虚幻引擎5** 中引入的系统，可以自动执行设置平台支持时需要执行的大部分步骤，包括查找用于安装SDK和显示开发工具包的源文件。

你的组织设置Turnkey的文件源仓库之后，个体团队成员就可以使用一键式流程为任何目标平台设置自己的系统。本页面上列出的指南将展示如何为Turnkey托管SDK，以及如何使用Turnkey将其下载和安装到虚幻引擎的个体实例上。

## 概述

Turnkey是AutomationTool脚本，可以通过 `RunUAT.bat` 进行访问，配备了大量可以用于和SDK交互的工具。它会访问你为组织设置的仓库，然后自动从该仓库下载文件和设置SDK。

在运行Turnkey来安装SDK时，它会执行以下流程：

- Turnkey启动，并使用

  TurnkeyManifest.xml

  提供的信息来扫描SDK。
- Turnkey根据用户的输入选择一个平台。
- 版本系统告知Turnkey哪些版本的SDK对于当前的虚幻引擎版本有效。
- 从提供的所有有效SDK中选择最合适的SDK。

  - Turnkey使用一系列特定于平台的规则来将版本号转换成整数，然后选择有效SDK范围中的最大数字。这些规则是在

    *PlatformSDK.cs

    文件中指定的。
- Turnkey将SDK文件下载到用户的机器。

  - 如果SDK文件包含在

    .zip

    或

    .7z

    文件中，则会自动解压到一个临时位置。
- 版本系统将安装下载的SDK。

这样一来，即使存在大量可用的SDK版本，可以快速设置你的虚幻引擎项目，并且无论何时更新可用的SDK都可以简化维护。

## 设置Turnkey

要使用Turnkey，你需要在文件源仓库中托管SDK，然后使用必要的信息来设置 `TurnkeyManifest.xml` 和 `TurnkeyStudioSettings.xml` 文件，以便于Turnkey发现。

下面列出的页面提供了有关如何设置每个组件的说明，以及如何设置目录结构以便Turnkey的自动化流程能够识别你的SDK版本。

- [为你的组织配置Turnkey](setting-up-turnkey-for-your-organization/index.md) - 介绍如何编写Turnkey清单以及为你的组织配置副本提供方的信息。

- [设置适用于虚幻Turnkey的Google Drive](setting-up-google-drive-for-turnkey/index.md) - 如何设置Google Drive API和托管SDK以便用于虚幻Turnkey

## 用途

为你的组织设置Turnkey之后，用户可以直接在虚幻引擎中与其进行交互，或在命令行界面中使用 `RunUAT.bat` 与其交互。下面列出的页面包含了每种方式的用法信息。

- [在虚幻编辑器中管理平台](using-the-platforms-dropdown-in-unreal-editor/index.md) - 使用虚幻编辑器中的全新

- [使用Turnkey命令行](using-the-turnkey-commandline/index.md) - 本文介绍了如何在命令行界面中使用RunUAT.bat来运行Turnkey
