---
title: "Horde设备"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-devices-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde", "Horde配置", "Horde设备"]
---

# Horde设备

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde / Horde配置 / Horde设备

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-devices-for-unreal-engine

Horde设备管理器负责管理移动端和主机开发套件资源。该服务在Epic Games中受到广泛使用，已经相当成熟。 它具有以下特点：

- 可配置的设备平台和池
- 支持用户检出的共享远程设备资源
- 具有问题报告与恢复功能的自动化设备预留
- 支持使用操作面板管理硬件
- 设备使用历史记录、遥测数据以及池健康状况报告
- 与Gauntlet自动化框架集成

## 共享池

Horde用户使用共享池检出远程设备资源，用于开发和测试工作。用户通过操作面板检出设备，设备可通过明确的检入操作返回到池，或者在达到可配置的使用时长后自动返回。

有一个通知接收器，用于在检入到期前24小时提醒用户，以便他们在需要时进行更新。当检出到期且设备返回到池后，还会发送后续通知。

此外，还可以针对已检出的设备设置自动化作业，例如安装构建。

## 自动化池

设备管理器支持自动化作业设备预留，预留可受到池、平台以及型号的限制。

我们建议你将[Gauntlet集成](#gauntlet%E9%9B%86%E6%88%90)与预留系统配合使用。但你也可以使用相同的REST API来实现自定义解决方案。

## 平台配置和池配置

设备平台硬件被划分到不同的池中，供自动化测试和用户使用。设备平台和设备池通过globals.json文件的 `Devices` 部分进行配置（请参阅[DeviceConfig](../horde-schema/index.md#deviceconfig)）。

### 配置示例

以下配置片段声明了一个设备管理器配置：

- 添加了一个

  Android

  设备平台，指定多个型号
- 添加了两个池，一个是 `Automation` 池，供自动化测试使用，另一个是 `Shared` 池，供用户从中检出远程设备硬件

  ```
        "devices": {          "platforms": [              {                  "id": "android",                  "name": "Android",                  "models": [                      "Pixel4",                      "Pixel5",                      "Pixel8"                  ]              }          ],          "pools": [              {                  "id": "ue5",                  "name": "UE5",                  "poolType": "Automation"              },              {                  "id": "remote-ue5",                  "name": "Remote UE5",                  "poolType": "Shared"              }          ]      }
  ```

## 设备配置

在Horde操作面板中找到 `服务器（SERVER） > 资源（Resources） > 设备（Devices）` ，添加和管理共享设备和自动化设备。

这支持以下操作：

- 添加和编辑设备
- 将设备设置为维护模式
- 为设备添加内联备注
- 在不同池之间移动设备
- 查看池健康状况和使用的遥测数据
- 查看作业历史记录以及最后修改该设备的用户信息

## Gauntlet集成

[Gauntlet](../../../../testing-and-optimizing-content/automation-test-framework/gauntlet-automation-framework/index.md)测试可以从Horde设备管理器中预留硬件资源。该集成包括报告设备问题、使用新设备进行恢复等功能。它还支持预留块功能，可用于在一系列自动化测试中复用已安装特定构建的设备。

### Gauntlet集成示例

以下[**BuildGraph**](../../../using-the-unreal-engine-build-pipeline/unreal-automation-tool/buildgraph/index.md)片段声明：

- HordeDeviceManager

  和

  HordeDevicePool

  属性，用于指定你的Horde服务器以及要使用的池。
- 添加一个 `BootTest Android` 节点，该节点将为测试预留一台Android Pixel 8

  ```
        <Property Name="HordeDeviceManager" Value="https://horde.yourdomain.com" />      <Property Name="HordeDevicePool" Value="UE5" />			      <Node Name="BootTest Android">          <Command Name="RunUnreal" Arguments="-test=UE.BootTest -platform=Android " -deviceurl="$(HordeDeviceManager)" -devicepool="$(HordeDevicePool)" -PerfModel=Pixel8/>      </Node>
  ```
