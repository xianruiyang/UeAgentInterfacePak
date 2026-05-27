---
title: "Horde安装教程"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-installation-tutorial-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde", "Horde教程", "Horde安装教程"]
---

# Horde安装教程

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde / Horde教程 / Horde安装教程

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-installation-tutorial-for-unreal-engine

## 简介

本指南将介绍如何在装有Windows的机器上进行简单的本地Horde服务器安装。

Horde还可以通过[Linux上的Docker](../../horde-deployment/horde-server/index.md#docker-linux)安装，既可以作为单个实例，也可以通过Kubernetes等容器编排系统水平扩展服务。

有关这些高级部署方案的更详细讨论，请参阅[Horde > 部署](../../horde-deployment/index.md)。

## 先决条件

- 一台用作Horde服务器的机器。
- 一台或多台用作Horde代理的机器。目前，我们推荐针对此用途配备专用机器。

## 步骤

### Horde服务器

1. 通过运行 `Engine\Extras\Horde\UnrealHordeServer.msi` 安装Horde服务器。

   - Horde服务器也可以在

     使用Docker的Linux

     上部署。
   - 默认情况下，Horde被配置为使用

     端口13340（HTTP）和13342（HTTP/2）

     。我们建议为生产部署设置

     HTTPS

     。
   - 另请参阅：

     部署 > 服务器

### Horde代理

1. 在代理机器上的Web浏览器中，找到已安装[Horde服务器](#horde%E6%9C%8D%E5%8A%A1%E5%99%A8)。

   - 通常是带有默认安装的

     http://{{ HOST_NAME_OR_IP_ADDRESS }}:13340

     。
   - 请注意，Horde服务器默认为HTTP托管（而不是HTTPS），因此你可能需要手动输入

     http://

     作为地址的一部分。
2. 打开操作面板顶部的 **工具（Tools）** 菜单，并选择 **下载（Downloads）** 。
3. 下载并运行 **Horde代理（Windows安装程序）（Horde Agent (Windows Installer)）** 。

   - 出现提示时，输入上面使用的相同服务器地址，并为远程执行沙盒选择一个空的工作目录。
   - 我们建议选择一个至少有100GB可用空间的驱动器用于C++编译。
4. 在安装结束时，保留 `注册服务器（Enroll with Server）` 选项的选中状态，或者在系统通知区域找到虚幻图标，右键单击图标，然后选择 `注册服务器（Enroll with Server）` 。
5. 从列表中选择你的代理，然后选择 **注册（Enroll）** 。此过程可验证你信任该代理并允许代理处理工作。
