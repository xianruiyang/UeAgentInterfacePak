---
title: "容器概述"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/overview-of-containers-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "部署虚幻引擎", "容器", "容器概述"]
---

# 容器概述

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 部署虚幻引擎 / 容器 / 容器概述

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/overview-of-containers-in-unreal-engine

支持 **容器（Container）** 有助于 **虚幻引擎的** 支持许多前沿的基于云的开发技术和部署策略。虚幻引擎容器的作用包括：增强生产管线，开发次世代云应用程序，并以前所未有的规模部署企业解决方案等等。

尽管官方对虚幻引擎容器的支持仍处于测试阶段，但它是在[TensorWorks](https://tensorworks.com.au/)的成熟开源架构上开发的，并由[虚幻容器](https://unrealcontainers.com/)这一项社区方案促成——该方案相关的内容已被全球开发人员广泛用于实际生产。

## 了解容器和容器镜像

正如Docker官网文章[什么是容器？](https://www.docker.com/resources/what-container)介绍的，容器是一种技术，专用于将应用及其相关依赖项打包成单个标准单元（single standard unit）。标准单元可在不同计算基础设备（包括本地设备和云端设备）之间迁移。

与虚拟机的逻辑类似，容器作为 **容器镜像（container image）** 存储在磁盘上，通过镜像可运行一个或多个容器。与虚拟机不同的是，容器共享一个底层操作系统内核，并且可跨不同容器镜像共享公共数据。这使得它们从计算角度上来说属于轻量级的，并能实现大量并发部署。

如果你想了解更多容器相关的知识，可查看不同云提供商提供的资源：

- IBM：什么是容器
- Red Hat：实用容器术语介绍

## 开发和运行时容器镜像

虚幻引擎中包含两种类型的容器镜像：**开发镜像(development images)** 和 **运行时镜像（runtime images）**。

**开发镜像（Development images）** 包含虚幻编辑器和构建工具。它们主要用于那些需要用到编辑器的任务，例如生成和打包虚幻引擎项目及插件，或者渲染基于[Sequencer](../../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/index.md)的过场动画，或运行命令。分发开发镜像时需满足[虚幻引擎EULA](https://www.unrealengine.com/en-US/eula/publishing)条款的约束。

**运行时镜像（Runtime images）** 仅包含运行虚幻引擎打包项目时所需的依赖项。开发人员通过为他们打包的虚幻引擎项目添加文件，创建可部署到云环境中的新容器镜像，以此扩展运行时镜像。由于运行时镜像不包含编辑器或构建工具，因此它们的分发限制比开发镜像少。

有关开发镜像和运行时镜像间的详细差异，请参阅虚幻容器社区网站的[开发镜像与运行环境镜像对比](https://unrealcontainers.com/docs/concepts/image-types)一文。

## 可用容器镜像

从虚幻引擎4.27开始，每个引擎版本均包含官方开发和运行时容器镜像。这些容器镜像的源代码可以在虚幻引擎源代码的 `Engine/Extras/Containers` 目录中找到，你也可以通过GitHub或Perforce下载相关源代码（如果你是虚幻引擎的被许可人）。所有容器镜像的预构建版本均会发布到[GitHub容器注册表](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry)，且可供下载，你无需通过源代码进行构建。

提供以下开发镜像：

| 开发镜像类型 | 描述 |
| --- | --- |
| **dev** | 这是虚幻引擎的完整Linux开发镜像，包括虚幻引擎的已安装版本、模板项目和完整调试符号。 |
| **dev-slim** | Linux版本的开发镜像，内容较小，不包含模板项目和调试符号。 |

提供以下运行时镜像：

| 运行时镜像类型 | 描述 |
| --- | --- |
| **runtime** | 这是带有或未带有GPU加速的简化版Linux运行时镜像，专用于在容器内运行打包的虚幻引擎应用程序。为了将镜像大小压缩到最小，此镜像不支持音频输出。 此容器镜像目前仅对使用NVIDIA GPU的机器提供GPU加速支持。 |
| **runtime-pixel-streaming** | 此镜像扩展了简化版Linux运行时镜像，以添加像素流应用程序所需的依赖项，包括支持音频输出。因此，尽管此镜像仍比Windows运行时镜像要小得多，但明显比默认运行时镜像要大。 此容器镜像目前仅支持NVIDIA GPU的GPU加速。 |
| **runtime-windows** | 这是带有或未带有GPU加速的Windows运行时镜像，专用于在容器内运行打包的虚幻引擎应用程序。由于Windows容器镜像已经比Linux容器镜像大很多，而且与Windows操作系统本身的大小相比，像素流应用程序所需的依赖项相对较小，因此该镜像也包含这些依赖项。 目前，对于在基于GPU加速的Windows容器内运行像素流应用的支持还是试验性的，不建议在实际开发中使用。 |

除开发和运行时镜像外，还提供以下镜像以便用于一些特殊用例，例如像素流：

| 特殊镜像类型 | 描述 |
| --- | --- |
| **pixel-streaming-signalling-server** | 这是一个包括像素流系统使用的Cirrus信号和web服务器的Linux容器镜像。 |
| **multi-user-server** | 这是一个包括虚幻引擎多用户编辑系统所用服务器的Linux容器镜像。 |

## 局限性

对虚幻引擎容器的官方支持仍处于测试阶段，并受到诸多限制。详情请参阅[已知局限性](../known-limitations-of-containers/index.md)页面。

## 可用资源

除虚幻引擎中有关容器支持的官方文档，还有以下可用资源：

- 虚幻容器社区中心

  维护着海量书面文档，以及视频和源代码元库的相关链接。社区中心网站还附带了一个专供社区讨论如何使用和开发虚幻引擎容器的Discord服务器。
