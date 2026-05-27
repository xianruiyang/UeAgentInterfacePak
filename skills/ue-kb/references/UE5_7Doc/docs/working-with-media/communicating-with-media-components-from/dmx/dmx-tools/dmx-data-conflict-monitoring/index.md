---
title: "DMX冲突监控器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/dmx-data-conflict-monitoring-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "与媒体组件通信", "DMX", "DMX工具", "DMX冲突监控器"]
---

# DMX冲突监控器

> 路径：虚幻引擎5.7文档 / 使用媒体 / 与媒体组件通信 / DMX / DMX工具 / DMX冲突监控器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/dmx-data-conflict-monitoring-in-unreal-engine

在将引擎中的DMX数据发送到外部设备时，DMX冲突监控器可检查所有启用的域和配接范围上的潜在DMX数据冲突。虚幻引擎中的不同DMX工具（例如控制台、像素映射器和蓝图）将DMX数据写入相同地址时，它们之间可能会发生冲突。

要打开冲突监控器，点击 **主工具栏** 中的 **DMX** > **冲突监控器（Conflict Monitor）** 。

![主工具栏中的冲突监控器](../../../../../../assets/images/8e/8e2797447339ec7b73d97554d54ea0b307e7638290c40193c825b72955342a16.jpg)

冲突监控器将作为可停靠的窗口打开。点击 **省略号（...）** 可配置其选项。

- 播放/停止（Play/stop）

  ：启动和停止监控过程。
- 选项（Options）

  - 自动暂停（Auto Pause）

    ：检测到冲突时暂停。
  - 打印到日志（Print to Log）

    ：将冲突打印到UE输出日志。仅在启用自动暂停时可用。
- 监控器（Monitor）

  - 打开时运行（Run when opened）

    ：打开时监控自动启动。
  - 深度（Depth）

    ：控制在日志条目中包含多少详情。

在冲突监控器运行时， **发生DMX的对象（Objects Sending DMX）** 分段会更新，显示当前正在发送DMX的资产。你可以根据显示打开对应资产，或在 **内容浏览器** 中找到它。

![The Objects Sending DMX section](../../../../../../assets/images/04/047f4e77f1873ba5b429416058b72b222ff30a1dbd53621b7773f2a678e0426c.png)

冲突监控可能会占用大量CPU资产。你可以在冲突监控器的右上角查看当前CPU使用情况。

![The CPU usage bar](../../../../../../assets/images/7c/7cfde52f6d249be290b9d987318f08d23a1f3cc8df31bfc72887957f6c1c2246.png)

如果冲突监控器检测到冲突，则监控器会记录关于冲突的信息，包括冲突的DMX工具和受影响的端口。

![Conflict Monitor log with information about a conflict](../../../../../../assets/images/03/038c74448250402acb352e7e99a450a5d78e0eb2eae294d824d24cd5363d3b60.png)

如果选择了 **打印到日志（Print To Log）** 选项，则冲突监控器还会将相同信息发送到UE输出日志。

![UE Output log with Conflict Monitor information](../../../../../../assets/images/62/626fc83e291f229592ac61ad4b3d887efa69fb6686137e3803f29bef323bfd40.png)
