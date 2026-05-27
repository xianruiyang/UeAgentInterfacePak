---
title: "Horde分析"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-analytics-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde", "Horde配置", "Horde分析"]
---

# Horde分析

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde / Horde配置 / Horde分析

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-analytics-for-unreal-engine

Horde实现了HTTP端点，用于收集虚幻引擎编辑器发送的遥测数据。这些数据可以提供关于瓶颈和工作流程问题的深度信息，团队和Horde操作面板可以对这些数据进行汇总和图表展示，以突出显示随着时间推移所取得的改进以及出现的退步情况。

[入门 > 分析](../../horde-tutorials/horde-analytics-tutorial/index.md)指南介绍了如何配置项目以向Horde发送遥测数据。

## 遥测存储

Horde支持多个正交遥测数据存储，允许你根据需要将不同项目的遥测数据分组。每个遥测数据存储都各自有一组指标，操作面板支持切换上下文，以便使用不同存储中的数据查看相同的图表。

要将数据发送到特定遥测存储，请在项目的 `DefaultEngine.ini` 文件中的 `APIEndpointET` 属性中包含遥测存储名称。例如， `engine` 将存储使用以下URL：

```
APIEndpointET="api/v1/telemetry/engine"
```

## 指标

为了在较长的时间段内高效聚合分析数据，Horde会将遥测事件聚合为每个时间间隔的运行指标。该聚合操作将根据globals.json文件中 `Telemetry.Metrics` 部分所指定的规则来执行（请参阅[MetricConfig](../horde-schema/index.md#%E6%8C%87%E6%A0%87%E9%85%8D%E7%BD%AE)）。

## 绘制图表

Horde操作面板会提供图表，显示在服务器上收集的各项指标。这些视图将使用globals.json文件中 `Dashboard.Analytics` 部分进行配置（请参阅[TelemetryViewConfig](../horde-schema/index.md#telemetryviewconfig)）。

## 遥测接收器

Horde可以将原始遥测数据收集到自己的数据库中，也可以将这些数据转发到其他遥测接收器。

你可以通过服务器的[Server.json](../../horde-deployment/horde-settings/index.md#%E6%9C%8D%E5%8A%A1%E5%99%A8%E8%AE%BE%E7%BD%AE)文件中的 `Telemetry` 属性，配置遥测接收器。要从聚合数据计算指标，不一定要配置遥测数据接收器。
