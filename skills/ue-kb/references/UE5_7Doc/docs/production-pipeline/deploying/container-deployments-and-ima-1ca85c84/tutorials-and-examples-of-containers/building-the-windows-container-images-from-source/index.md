---
title: "通过源代码构建Windows容器镜像"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/building-the-windows-container-images-from-source"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "部署虚幻引擎", "容器", "容器教程", "通过源代码构建Windows容器镜像"]
---

# 通过源代码构建Windows容器镜像

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 部署虚幻引擎 / 容器 / 容器教程 / 通过源代码构建Windows容器镜像

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/building-the-windows-container-images-from-source

> [!TIP]
> 包含在虚幻引擎中的所有容器均有可从GitHub容器注册表下载的预构建版本。如果想为虚幻引擎自定义版本构建开发镜像，或修改镜像源代码，你只需通过源代码构建映镜像即可。

## 要求

如需构建虚幻引擎附带的Windows容器镜像，计算机需达到[硬件和软件要求](../../../container-deployments-and-images-for-unreal-editor-and/hardware-and-software-requirements-for-containe-f83f20cb/index.md)页面Windows容器部分列明的硬件和软件要求。

## 安装Docker

Docker是构建包含在虚幻引擎中的容器镜像的推荐工具。如需安装Docker，请按照[安装Windows版Docker桌面版](https://docs.docker.com/docker-for-windows/install/)的指示操作。

一旦Docker桌面版安装成功，你需要[从Linux容器模式切换](https://docs.docker.com/docker-for-windows#switch-between-windows-and-linux-containers)（默认）到Windows容器模式。

## 构建镜像

> [!NOTE]
> 如果你已从GitHub下载了虚幻引擎的源代码，那么需要运行源代码根目录的 `Setup.sh` ，来下载引擎的二进制依赖文件。如果不执行此步骤，那么构建容器镜像所需的文件就会丢失。

导航至虚幻引擎源代码的子目录：

Engine/Extras/Containers/Dockerfiles/windows

如需构建Windows容器镜像，请双击 `build.bat` 文件。该操作会根据机上当前运行的Windows版本构建对应的Windows运行时镜像。
