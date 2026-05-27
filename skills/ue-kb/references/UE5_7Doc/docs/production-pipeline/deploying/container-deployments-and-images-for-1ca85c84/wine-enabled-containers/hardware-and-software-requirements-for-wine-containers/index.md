---
title: "Wine容器的硬件和软件要求"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/hardware-and-software-requirements-for-wine-containers-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "部署虚幻引擎", "容器", "虚幻引擎中支持Wine的容器", "Wine容器的硬件和软件要求"]
---

# Wine容器的硬件和软件要求

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 部署虚幻引擎 / 容器 / 虚幻引擎中支持Wine的容器 / Wine容器的硬件和软件要求

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/hardware-and-software-requirements-for-wine-containers-for-unreal-engine

## Linux容器要求

你可以在Windows、macOS或Linux系统上用虚幻引擎构建并运行支持Wine的容器镜像。要构建或运行这些容器镜像，你的计算机需要满足以下硬件要求：

- 支持

  二级地址转换（SLAT）

  的64位CPU
- 在系统BIOS中启用了硬件虚拟化支持。
- 至少需要4GB系统内存。

你的计算机还需要满足以下软件要求：

- Windows：安装了Docker Desktop for Windows的64位Windows 10家庭版、专业版、企业版或教育版，且版本不低于1903。有关如何安装Docker Desktop for Windows的说明，请参阅下面的

  安装Docker

  一节。
- macOS: 安装了Docker Desktop for Mac的macOS，且版本不低于10.14。有关如何安装Docker Desktop for Mac的说明，请参阅下面的

  安装Docker

  一节。
- Linux：安装了Docker Engine的64位CentOS 8或更高版本、Debian 10或更高版本、Fedora 32或更高版本、Ubuntu 16.04或更高版本，或者任何满足

  Docker先决条件

  的Linux发行版本。有关如何安装Docker Engine的说明，请参阅下面的

  安装Docker

  一节。

## 安装Docker

要使用Wine和虚幻引擎构建和运行容器镜像，推荐使用Docker工具。Docker的安装步骤取决于你使用何种操作系统。以下链接提供了在Docker可用的每个平台上安装Docker的操作指南：

- Windows：

  Install Docker Desktop on Windows
- macOS：

  Install Docker Desktop on Mac
- Linux：请根据你的特定Linux发行版本选择合适的Docker Engine安装指南：

  - CentOS
  - Debian
  - Fedora
  - Ubuntu
  - 其他Linux发行版本
