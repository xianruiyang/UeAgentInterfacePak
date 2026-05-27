---
title: "从影片渲染队列过渡到影片渲染图表"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/transitioning-to-the-movie-render-graph-from-movie-render-queue-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "影片渲染管线", "从影片渲染队列过渡到影片渲染图表"]
---

# 从影片渲染队列过渡到影片渲染图表

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / 影片渲染管线 / 从影片渲染队列过渡到影片渲染图表

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/transitioning-to-the-movie-render-graph-from-movie-render-queue-in-unreal-engine

## 简介

虚幻引擎的影片渲染图表是一种基于节点的工具，可以创建高品质的渲染输出。相比影片渲染队列，它更加强大、灵活和易用。本指南将概述如何在已熟悉了MRQ的前提下过渡到使用MRG。

## 示例内容

[Meerkat示例项目](../../../../samples-and-tutorials/engine-feature-examples/meerkat-sample-project/index.md)提供了简单的影片渲染图表示例。

![ImageAltText](../../../../../assets/images/f8/f807a97010a445d5166d4139c3216735d0964986ab33306b7fece66e88a6db74.png)

![ImageAltText](../../../../../assets/images/c1/c104266ef16674ec89ae75267644edacd492aa4f138cc10103c0f1a4bec72d19.jpg)

## MRQ配置到图表的过渡

默认的影片渲染图表与默认的MRQ配置几乎一致。主要区别在于，图表内置的设置节点更有助于按图层渲染。

### 导出

![ImageAltText](../../../../../assets/images/6a/6a9ee7a0e77a0fc1e657931310d2fcf38270f29b48c0ea2e75dfd9d7bcb0bdd9.png)

#### 文件名格式

文件名格式被移动到了File Type Output节点。这让用户能够逐渲染图层控制文件的命名设置。

![ImageAltText](../../../../../assets/images/16/164377d845d67e685b46cee7471c3cb1c69d9bd9e1d91829f049f0087329e515.png)

#### 命令行编码

![ImageAltText](../../../../../assets/images/56/56ce9a2cf13f2c8cfa650054d9da1ec27394fa9f533d7f91531a32d83fb8992e.png)

### 设置

![ImageAltText](../../../../../assets/images/57/5765d957d7167566d3c6ef7a7246d25c41d5af93eac11b6193a26a562a7283b2.jpg)

#### 抗锯齿

由于时间取样需要在全局层面进行设置，而空间取样可以逐渲染图层进行设置，因此图表将时间和空间取样设置分离了。

时间取样在Sampling Method节点中设置。

![ImageAltText](../../../../../assets/images/7d/7d9916d4996062fad5e52e5141223ec16906b262b6467c4cdc26d91d3ab70105.jpg)

而空间取样则在Renderer节点中设置。抗锯齿方法可以逐渲染图层进行设置，且也位于Renderer节点。

![ImageAltText](../../../../../assets/images/79/79f586f214f913fe2ca8a99cc8565356d7e768111d1626ddb75e589b5e3ecbd1.jpg)

#### 预热设置

预热设置得到了简化，且拥有了自己的节点：

> 图片已省略：ImageAltText

#### 烧入

> 图片已省略：ImageAltText

#### 摄像机设置

> 图片已省略：ImageAltText

#### 颜色输出

**OCIO** 也被移到了 **File Type Output** 节点，从而实现了渲染图层级别的控制，而非作业级别。

> 图片已省略：ImageAltText

色调曲线（Tone Curve）现通过Renderer节点控制。

> 图片已省略：ImageAltText

#### 控制台变量

> 图片已省略：ImageAltText

#### 调试选项

写入所有样本（Write All Samples）已被移至Renderer节点

> 图片已省略：ImageAltText

Render Dock的Insights追踪或捕捉帧功能现位于Debug Settings节点

> 图片已省略：ImageAltText

#### 游戏重载项

Game Overrides节点默认位于图表内，删除或断开连接后将失去对渲染的控制，这点与配置文件的行为相反。

> 图片已省略：ImageAltText

### 渲染

> 图片已省略：ImageAltText

#### 渲染路径

用户可以将对应的节点连接到渲染链，从而在路径追踪器和延迟渲染路径之间进行选择。这可以逐渲染图层进行选择。

> 图片已省略：ImageAltText

#### 视图模式索引

视图模式渲染现在位于Renderer节点。

> 图片已省略：ImageAltText

#### 额外后期处理材质

额外后期处理材质位于Renderer节点，可逐渲染图层进行设置。

> 图片已省略：ImageAltText

#### 用户界面渲染器

> 图片已省略：ImageAltText

### 影片渲染图表暂不支持的功能

MRQ现在支持，但使用MRG时尚不支持的功能如下：

- **nDisplay渲染**
- **高分辨率渲染**
- **Apple Pro Res插件**
- **Final Cut Pro XML**
- **预流送录制器**
- **32位后期处理材质渲染**
