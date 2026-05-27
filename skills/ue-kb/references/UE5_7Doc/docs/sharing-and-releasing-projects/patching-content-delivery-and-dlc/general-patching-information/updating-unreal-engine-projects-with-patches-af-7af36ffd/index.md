---
title: "打补丁概述"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/updating-unreal-engine-projects-with-patches-after-release"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "补丁和DLC", "常用补丁信息", "打补丁概述"]
---

# 打补丁概述

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / 补丁和DLC / 常用补丁信息 / 打补丁概述

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/updating-unreal-engine-projects-with-patches-after-release

一旦您发布了您的项目，您可能会在最初的发布之后对其进行更新。这个过程被称为 **打补丁**。打补丁通常包括新内容，用于解决已知的问题，或者修复原始版本中的漏洞。

## 不同的打补丁方法

创建补丁有几种方法，但他们都使用两种方法中的其中一种。一种方法保留原始版本或之前版本中的文件，但添加一个指向新内容的指针。另一种方法是使用二进制补丁转换原始版本中的内容。

> [!NOTE]
> **注意：**您可以在虚幻引擎4(UE4)中为许多不同的平台编译补丁。但是，我们不支持为您的项目分发补丁。每个平台都有自己的系统来上传补丁文件，并将这些补丁文件分发给用户。有关这些特定于平台的分发系统的信息，请参阅该平台的软件开发工具包(SDK)文档。

## 与平台无关的打补丁方法

在虚幻引擎4中有一种创建补丁的方法，可以在任何平台上使用。该方法打包整个版本和新内容，而这两个版本之间的更改之处将被放置在添加到原始文件的sidecar文件中。新的PAK文件使用"_p"后缀进行标记。例如，如果原始版本文件名为`MyGamesStuff.pak`，您的打包文件将名为`MyGamesStuff_p.pak`。

### Windows打补丁

Windows使用[与平台无关的打补丁方法](#%E4%B8%8E%E5%B9%B3%E5%8F%B0%E6%97%A0%E5%85%B3%E7%9A%84%E6%89%93%E8%A1%A5%E4%B8%81%E6%96%B9%E6%B3%95)中描述的方法。

> [!NOTE]
> 有关与平台无关的打补丁的更多信息，请参阅[如何创建补丁](../how-to-create-a-patch/index.md)。
