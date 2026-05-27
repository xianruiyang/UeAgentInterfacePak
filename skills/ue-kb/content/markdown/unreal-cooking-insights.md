# Unreal Cooking Insights

---
title: "Unreal Cooking Insights"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-cooking-insights-in-unreal-engine-5"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "Unreal Insights", "Timing Insights", "Unreal Cooking Insights"]
---

# Unreal Cooking Insights

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / Unreal Insights / Timing Insights / Unreal Cooking Insights

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-cooking-insights-in-unreal-engine-5

利用 **Unreal Cooking Insights** ，你可以采集和显示关于项目中数据包烘焙方式的信息。如果烘焙时间较长，可能会显著影响处理较大项目的团队工作效率。此工具可显示烘焙每个数据包所用的时间，帮助缩短烘焙时间。

### 设置

你可以从命令行使用以下命令为Cooking Insights运行跟踪：

```
	trace=default,cook 
```

你也可以针对特定的主机和平台运行以下命令：

```
	MyProject -run=cook -log -trace=default,cook -tracehost=localhost -targetplatform=Windows 
```

加载包含烘焙数据的跟踪时， **数据包（Packages）** 表将在分析完成后填充每个数据包的 **加载时间（load time）** 、 **保存时间（save time）** 和 **烘焙时间（cooking time）** 。

![undefined](../../../../../assets/images/d1/d1e0e96ebfded6601d11cdec4339ccca9575503388d92b266d0576c5b22624fd.png)

### 层级排序

选择 **层级（Hierarchy）** 筛选器时，你可以从以下分组选项中选择。

![层级排序](../../../../../assets/images/51/511ebf2f42e9050b516d8c973bf85712d1d670e4812bc763f88de32f4f48d4c2.png)

| **层级分组选项** | **说明** |
| --- | --- |
| 扁平（全部） | 创建包含所有项目的单个组。 |
| 唯一值 - 资产类 | 为每个唯一值创建一个组。 |
| 路径详细分解 - 数据包名称 | 从字符串值的路径结构创建树层级。 |

### 预设选项

观察数据包数据时，你可以找到 **预设（Preset）** 以配置树状图。

![预设选项](../../../../../assets/images/9f/9fd60100da9850013298d5ec6a165fd1de79dbdde2321094481a88b94d63b407.png)

你可以从以下预设中选择：

| **预设选项** | **说明** |
| --- | --- |
| 默认 | 显示默认数据包信息。 |
| 数据包路径 | 按数据包路径对数据包分组。 |
| 资产类 | 按最重要的资产对数据包分组。 |

### 列排序

Cooking Insights在以下列中对特定数据包数据分组。

| **列名称** | **说明** |
| --- | --- |
| 层级 | 数据包的树的层级。 |
| Id | 数据包的Id。 |
| LoadTime | 加载数据包所用的时间长度。 |
| SaveTime | 保存数据包所用的时间长度。 |
| BeginCache | 在数据包的 `BeginCacheForCookedPlatformData` 函数中所用的总时间。 |
| IsCachedCooked | 在数据包的 `IsCachedCookedPlatformDataLoaded` 函数中所用的总时间。 |
| 资产类 | 数据包中最重要的资产的类。 |

你可以将列分为以下排序类别。

| **排序选项** | **说明** |
| --- | --- |
| 升序排序 | 按升序对选定列排序。 |
| 降序排序 | 按降序对选定列排序。 |
| 排序依据 | 按以下值对列排序： 数据包层级 Id LoadTime SaveTime BeginCache IsCachedCooked AssetClass |

你还可以使用以下选项，通过单独显示和隐藏列来自定义表。

| **列可视性** | **说明** |
| --- | --- |
| 查看列 | 隐藏或显示列。 |
| 显示所有列 | 重置树状图以显示所有列。 |
| 将列重置为默认值 | 将列重置为默认值。 |

