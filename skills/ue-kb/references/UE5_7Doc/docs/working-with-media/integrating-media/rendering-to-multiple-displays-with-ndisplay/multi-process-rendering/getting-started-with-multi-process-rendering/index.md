---
title: "多进程渲染快速入门"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/getting-started-with-multi-process-rendering-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "使用nDisplay在多显示屏上进行渲染", "多进程渲染", "多进程渲染快速入门"]
---

# 多进程渲染快速入门

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 使用nDisplay在多显示屏上进行渲染 / 多进程渲染 / 多进程渲染快速入门

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/getting-started-with-multi-process-rendering-in-unreal-engine

## 入门指南

多进程nDisplay配置（无论是新创建还是由现存配置转换而来）拥有如下内容：

- 屏幕内节点（Onscreen Nodes）：

  所有常规的"屏幕内"nDisplay节点都会以主GPU作为其GPU适配器
- 屏幕外节点（Offscreen Nodes）：

  为每台主机额外添加的"屏幕外"nDisplay节点，以次级GPU作为GPU适配器
- 摄像机内视觉特效处理（ICVFX）摄像机：

  为每台ICVFX摄像机组件设置的

  共享媒体输入

  和

  输出

  ，用于将渲染从屏幕外节点传输到屏幕内节点。由于ICVFX摄像机在次级GPU上进行渲染，因此可获得性能优势。

本指南将更加详细地介绍这些设置的各个方面。

如果你想了解如何从零开始创建新配置，请查看下方的"ICVFX快速入门"文档链接：

- ICVFX快速入门

## 设置常规屏幕内nDisplay节点

你必须将常规的"屏幕内（onscreen）"nDisplay节点设为使用与屏幕外节点不同的GPU进行渲染。将常规nDisplay节点的图形适配器（Graphics Adapter）设为0，即可将其分配给计算机的主GPU。注意：这是典型的编号情况，但部分机器可能会使用不同的编号。如果你通过Switchboard监视器发现了异常的GPU使用率，建议更改GPU索引号。

图形适配器（Graphics Adapter）的设置位于节点的细节（Details）面板。

常规nDisplay节点位于群集（Cluster）选项卡中。

图形适配器（Graphics Adapter）的设置位于节点的细节（Details）面板。

## 设置屏幕外nDisplay节点

你需要为每台主机逐个添加"屏幕外（offscreen）"渲染节点：

"添加新群集节点（Add New Cluster Node）"位于群集（Cluster）选项卡中。

请注意 **添加新群集节点（Add New Cluster Node）** 窗口中的如下细节：

- 要求为

  名称（Name）

  使用唯一标识符。下方示例中，添加的"_OS"表示屏幕外节点。请注意，名称的其余部分（"Node_0"）要保持一致。这一点很重要，因为这样可以清楚地指示哪个节点属于Switchboard中的哪台主机。
- 取消勾选

  为新群集节点添加视口（Add Viewport to New Cluster Node）

  ，以避免添加视口。若启用此选项，则需要移除视口才能进行无头渲染。
- 启用

  无头渲染（Headless Rendering）

  。这将迫使渲染在屏幕外进行，从而避免对桌面真实空间产生负面影响，或者干扰Nvidia同步。
- 将

  图形适配器（Graphics Adapter）

  设为

  1

  ，表示次级GPU。注意：这是典型的编号情况，但部分机器可能会使用不同的编号。

上图突出显示了添加新群集节点窗口中必须更新的部分。

## ICVFX摄像机设置

### 共享媒体的输入和输出

在ICVFX组件的"细节（Details）"面板中，存在一个"媒体（Media）"分段。这时最好将"媒体"理解为内视锥体的渲染，该渲染由屏幕外节点传输给常规节点，然后被显示在外视锥体上。媒体的设置将控制nDisplay视口发送和接收不同类型媒体的方式。你必须让媒体处于"启用"状态，并配置以下两个区域：

- 媒体输出群组（Media Output Groups）

  ，控制被渲染媒体的发送方。
- 媒体输入群组（Media Intput Groups）

  ，控制被渲染媒体的接收方。

### 媒体输出群组

必须将所有屏幕外节点都添加到 **群集节点索引（Cluster Nodes Index）** 之下。此外，媒体输出（Media Output）将被分配 **唯一名称** （"CameraA"）。该名称用于接收来自输入群组的纹理，因此必须区分大小写，而且每台ICVFX摄像机组件必须使用不同的唯一名称。

### 媒体输入群组

媒体输入群组将使用类似的设置：

- 将常规节点添加到

  群集节点索引（Cluster Nodes Index）

  。所有常规节点都应位列其中。
- 唯一名称

  （"CameraA"）必须按ICVFX摄像机组件配对，与媒体输出分段的名称

  一致

  。
- 将"模式（Mode）"设为

  帧锁定（Framelocked）

  。这将确保屏幕外节点上渲染的帧能够与当前屏幕内节点上渲染的帧正确配对。这一点非常重要，因为屏幕外节点运行的是无同步策略，实际上就是自由运行。如果不启用"帧锁定（Framelocked）"，则有可能在需要时让接收到的帧提前显示。
- 启用

  零延迟（Zero Latency）

  。这将消除任何延迟，而延迟通常被用作防止FPS下降的缓冲。但这对ICVFX而言是多余的，因为必须始终达到目标FPS。

更新相关设置后，进行 **编译（Compile）** 。

## 参考项目

**摄像机内视觉特效处理（InCamera VFX）** 的模板项目提供了启用多进程nDisplay的参考配置。模板项目的位置位于 **影片/视频和线上活动（Film/Video & Live Events） > InCameraVFX** 下的新项目窗口中。

相关配置见内容浏览器中的 **内容（Content） > InCamVFXBP > nDisplay_InCamVFX_MultiProcess_Config** 。

## 使用Switchboard运行多线程

添加完多进程nDisplay配置后，屏幕外节点和屏幕内节点都会作为单独的设备在Switchboard中显示。[点击此处了解虚幻引擎Switchboard的更多信息。](../../../../communicating-with-media-components-from/switchboard/index.md)。

每个节点都需要连接，但每台机器只需要一个Switchboard监听器实例即可。 屏幕内和屏幕外节点应同时启动和运行。要实现这一点，最好使用"启动所有已连接的nDisplay设备（Start All Connected nDisplay Devices）"按钮。
