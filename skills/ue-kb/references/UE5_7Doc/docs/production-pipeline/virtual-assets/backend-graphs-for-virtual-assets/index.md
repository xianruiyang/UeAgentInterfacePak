---
title: "虚拟资产的后端图表"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/backend-graphs-for-virtual-assets-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "虚拟资产", "虚拟资产的后端图表"]
---

# 虚拟资产的后端图表

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 虚拟资产 / 虚拟资产的后端图表

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/backend-graphs-for-virtual-assets-in-unreal-engine

虚拟资产系统将资产的批量数据负载存储在 *后端* 中，后者通常是源码控制仓库、 **派生数据缓存（DDC）** 或某种其他形式的远程存储。用户需要编辑虚拟资产时，系统从后端拉取批量数据，并将其加载到计算机上。不过，所有后端解决方案在速度、存储空间、可靠性和实用性上都有相应的取舍。

为了充分利用所有可行解决方案，虚拟资产系统使用 **后端图表** 在多个后端中查找文件，并针对不同类型的存储使用各种后端。速度较快的后端可以容纳常用文件的临时缓存，而速度较慢的后端可用于长期的持久存储。本指南可以作为参考，让你了解如何为自己的项目配置后端图表，以便你可以定制项目对虚拟资产的使用，从而优化运行拉取的过程。

## 概述

后端图表是 `*Engine.ini` 文件中的多组参数，它们将定义哪些后端可供拉取批量数据，以及虚拟资产系统在取数据时的先后顺序，即先从哪些后端拉取数据。

### 存储列表

每个后端图表主要围绕两个列表构建：**CacheStorageHierarchy** 和 **PersistentStorageHierarchy** 。

**PersistentStorageHierarchy** 列表中的后端速度较慢但更可靠。你的所有文件应在一个持久存储后端中始终可用。举例来说，Perforce等源码控制仓库就是典型的持久存储后端，它为团队的所有文件提供永久的集中式存储解决方案，但性能可能因不同用户的互联网连接状况而有所差异。

CacheStorageHierarchy列表中的后端速度更快但可靠性较低，用于加快拉取速度，特别是常用文件。举例来说，共享派生数据缓存（DDC）就是典型的缓存存储，它位于贵组织工作场所内的共享网盘上。因为DDC本就属于你的本地网络，所以速度更快。但如果你的团队高度分散，或大量团队成员远程办公，则这样的本地资源将无法供他们使用，系统就需要依靠其他资源，或者他们需要自己准备替代方案。

### 优先级

虚拟资产系统试图拉取批量数据时，会首先查看缓存存储列表中的后端，在找不到所需文件时才会转向持久存储。在查看任一列表时，它都会按照列出的顺序查看每个后端，因此你应该尽量按照从最快到最慢的顺序建立后端列表。

## 如何使用后端图表

### 创建后端图表

要创建后端图表，请打开 `DefaultEngine.ini` 文件并使用后端图表的名称创建一个新类别。方便起见，你应该将它置于 `Core.ContentVirtualization` 附近。

后端图表需要以下条目：

- `CacheStorageHierarchy=(Entry=[缓存的名称])`
- `PersistentStorageHierarchy=(Entry=[持久存储的名称])`
- 为你想要使用的每个后端建立条目，并提供名称、类型，以及在适用情况下提供所需的信息以便找到其路径。

#### 定义后端

后端使用名称定义，后跟一个条目包含查找后端所需的数据。它提供在存储层级列表中使用的别名。每个条目都包含以下信息：

| **参数** | **说明** |
| --- | --- |
| 类型（Type） | 描述当前别名使用的后端的类型。可用类型如下： FileSystem – 本地文件系统。 P4SourceControl – 你的Perforce源码控制系统。 DDCBackend – 你的项目的共享DDC。 |
| 库根路径（DepotRoot） | 如果使用的是P4SourceControl类型，则此参数为库的根路径。 |
| 路径（Path） | 如果使用的是FileSystem类型，则此参数为你存储负载的根文件夹。 |

#### 将后端添加到你的存储列表

存储列表中的每个条目都采用 `Entry=[BackendName]` 格式，其中[BackendName]替换为你定义的其中一个后端。如果你的列表包含多个后端，则需要用逗号分隔。例如：

CacheStorageHierarchy=(Entry=DDCCache1, Entry=DDCCache2, Entry=DDCCache3)

```
	PersistentStorageHierarchy=(Entry=SourceControlCache) 
```

系统在解析这些信息时，将按列出的顺序查看每个后端。因此，你应该按照从最快到最慢的顺序建立后端列表。

#### 示例

以下是一个具有占位符名称的后端图表的示例：

```
	[VABackendGraph_Name]	CacheStorageHierarchy=(Entry=DDCCache)	PersistentStorageHierarchy=(Entry=SourceControlCache)	DDCCache=(Type=DDCBackend)	SourceControlCache=(Type=P4SourceControl, DepotRoot="XXX" ) 
```

此信息添加到你的 `DefaultEngine.ini` 文件中。头文件是后端图表的名称，并且它包含的别名列表定义了哪些后端图表可用。例如，`DDCCache` 指向共享DDC，而 `SourceControlCache` 指向你的项目中使用的源码控制系统。这些名称是任意名称，可以根据需要更改。定义这些条目后，你就可以将它们放入 `CacheStorageHierarchy` 和 `PersistentStorageHierarchy` 列表中。

### 选择供你的项目要使用的后端图表

创建后端图表之后，你需要配置项目，以在使用虚拟资产系统时使用其中一个后端图表。

#### 从配置文件中选择后端图表

找到你的 `DefaultEngine.ini` 文件的 `Core.VirtualizationModule` 分段。将 BackendGraph 参数默认设置为 `ContentVirtualizationBackendGraph_None` 。

```
	[Core.VirtualizationModule]	BackendGraph=ContentVirtualizationBackendGraph_None 
```

将ContentVirtualizationBackendGraph_None更改为你自己的后端图表的名称。之后，你的项目将使用你定义的图表。

#### 从命令行覆盖你的后端图表

你可以在命令行中使用以下命令覆盖后端图表：

```
	-VABackendGraph=[GraphName] 
```

其中[GraphName]是变量，表示你想使用的图表的名称。为了解决与该图表相关的问题，日志应该显示该图表在配置文件中的名称，包括从命令行覆盖它的图表的名称，以及挂载的图表的名称。

### 推荐的后端图表设置

我们建议为持久存储解决方案使用你的项目的源码控制，为缓存存储使用共享DDC缓存。你可以根据贵组织的需要创建更复杂的方案，但这需要在更高的性能和简单易用之间做好取舍。

## 后端实施注意事项

### P4SourceControl

为P4SourceControl类型设置后端时，必须为Perforce中希望存储虚拟化载荷的位置提供Depot路径。但是，系统需要验证该路径是否正确，以避免意外提交。

要开始使用Depot路径，请在Depot路径目录下提交一个名为 `payload_metainfo.txt` 的文件。当系统启动时，它会在Depot路径上查找该文件并尝试下载。虚拟资产系统会验证路径是否正确，并确保用户拥有正确的Perforce权限，以便能够访问数据。因为除非该文件用于虚拟资产存储，否则可能不存在。
