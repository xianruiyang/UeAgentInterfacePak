---
title: "垃圾回收"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/garbage-collection-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "引擎", "垃圾回收"]
---

# 垃圾回收

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 引擎 / 垃圾回收

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/garbage-collection-settings-in-the-unreal-engine-project-settings

## 垃圾回收

### 通用

| **分段** | **说明** |
| --- | --- |
| **清除待杀死对象之间的间隔时间（Time Between Purging Pending Kill Objects）** | 清除待杀死对象的对象引用之间要等待的时间，以秒为单位（游戏时间）。 |
| **在GC时清空流送（Flush Streaming On GC）** | 如果启用，将在每次触发垃圾回收时清空流送。 |
| **强制GC之前的重试次数（Number Of Retries Before Forcing GC）** | 如果工作线程正在修改UObject状态，可以跳过GC的最大次数。 0表示从不强制GC。 |

### 优化

| **分段** | **说明** |
| --- | --- |
| **允许并行GC（Allow Parallel GC）** | 如果启用，垃圾回收将使用多个线程。 |
| **启用增量BeginDestroy（Incremental BeginDestroy Enabled）** | 如果启用，引擎将使用每个帧的时间限制逐步销毁对象（每帧销毁少量对象）。 |
| **启用多线程破坏（Multithreaded Destruction Enabled）** | 如果启用，引擎将在工作线程上释放对象的内存。 |
| **创建垃圾回收器UObject群集（Create Garbage Collector UObject Clusters）** | 如果启用，引擎将尝试创建对象群集，以实现更好的垃圾回收性能。 |
| **启用资产群集（Asset Clustering Enabled）** | 指定是否允许资产文件为GC创建Actor群集。 |
| **启用Actor群集（Actor Clustering Enabled）** | 指定是否允许关卡为GC创建Actor群集。 |
| **启用蓝图群集（Blueprint Clustering Enabled）** | 指定是否允许蓝图类创建GC群集。 |
| **在专用服务器上使用DisregardForGC（Use DisregardForGC On Dedicated Servers）** | 如果禁用，将在专用服务器上禁用 `DisregardForGC` （垃圾回收优化）。 |
| **启用待杀死（Pending Kill Enabled）** | 如果启用，标记为 `PendingKill` 的对象将自动失效并由垃圾回收器销毁。 |
| **最小GC群集大小（Minimum GC Cluster Size）** | GC群集的最小大小。 |
| **GC不考虑的对象数量上限（Maximum Object Count Not Considered By GC）** | GC不考虑的对象数量上限。 仅适用于烘焙版本。 |
| **永久对象池的大小（Size of Permanent Object Pool）** | 永久对象池的大小，以字节为单位。 仅适用于烘焙版本。 |
| **烘焙游戏中可以存在的UObject最大数量（Maximum Number of UObjects that Can Exist in Cooked Game）** | 烘焙游戏中可以存在的UObject最大数量。 该数量应尽可能小。 |
| **编辑器游戏中可以存在的UObject最大数量（Maximum Number of UObjects that Can Exist in Editor Game）** | 编辑器游戏中可以存在的对象最大数量。 确保该数量能够在合理限制内容纳编辑器和Commandlet的足够对象。 |

### 调试

| **分段** | **说明** |
| --- | --- |
| **验证FGCObject名称（Verify FGCObject names）** | 如果启用，引擎将验证 `FGCObject` 派生的所有类是否都定义了 `GetReferencerName()` 函数重载。 |
| **验证UObject是否非FGCObject（Verify UObjects Are Not FGCObjects）** | 如果启用，引擎在检测到 `UObject` 派生的类也派生自 `FGCObject` 时，或其任意成员派生自 `FGCObject` 时，将抛出警告。 |
