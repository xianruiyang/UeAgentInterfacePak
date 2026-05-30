# Horde 的实用调试技巧 (Part 2/2)

# Horde 的实用调试技巧 (Part 2/2)

Source file: `unreal-engine-practical-debugging-tips-for-horde.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### 编辑部落配置文件

Horde 拥有丰富的配置，编辑时有时会出现错误（大声和无声）。值得注意的是，Horde 有一个 JSON 模式，您可以使用它来进行所有配置编辑。要使用此功能，您可以遵循 [VSCode](https://code.visualstudio.com/docs/languages/json#_json-schemas-and-settings) 文档，或类似的 **Visual Studio** 文档：

![用于 json 编辑的 Visual Studio 架构选择器。](assets/unreal-engine-practical-debugging-tips-for-horde/image-03.jpg)

JSON 模式的元数据可以通过使用 **HORDE_URL/api/v1/schema/catalog.json **api 端点轻松获取。
### 常见操作问题

虽然每个人的设置都有很大差异，但团队在运营部落时面临一些常见的运营挑战。虽然应始终遵守高级调试策略，但下面包含通过历史数据看到的一些主要挑战领域。
### 存储服务性能

Horde 的存储策略已经从直接将数据从代理写入存储后端，转变为代理写入服务器（然后中继到存储后端）。这包括步骤间数据传输和最终工件存储。有关该架构的更全面的文档，请查看[存储架构文档](https://github.com/EpicGames/UnrealEngine/blob/5.6/Engine/Source/Programs/Horde/Docs/Internals/StorageArchitecture.md)。某些存储后端支持预签名重定向 URL，以便可以进行“代理到存储后端”传输。这会减少 Horde 服务器上的负载，但需要使用正确的存储后端（以 [AWSObjectStore.cs](https://github.com/EpicGames/UnrealEngine/blob/5.6/Engine/Source/Programs/Horde/Plugins/Storage/HordeServer.Storage/Storage/ObjectStores/AwsObjectStore.cs#L4) 为例）。存储服务性能的常见问题可能是： 1. Horde 服务器动力不足 2. 负载过多 - 即许多步骤同时完成（并同时将工件发布到存储服务器） 3. 网络带宽不足 4. 拓扑不理想（服务器和代理在地理上分开）。 5. 病毒扫描程序阻碍读/写或网络流量 6. MongoDB **或 **Redis 实例动力不足 7. 跨代理复制过多的临时数据 1. 如果您打算**始终**使用给定构建的特定副产品，在后续步骤中，将这些数据整合到同一节点中可能会有所帮助，以减少传输的临时数据。请参阅 [BuildGraph](https://dev.epicgames.com/documentation/en-us/unreal-engine/buildgraph-for-unreal-engine#writingbuildgraphscripts) 文档，了解如何最好地利用 BuildGraph 来实现这一目标。请参阅 Horde Agent & Server State 部分来分析服务器实例，从而排除进程内性能问题和环境问题。
### 问题和事件匹配器

当任务在 Horde 上运行时，可以突出显示并跟踪问题。突出显示有两个主要切入点： 1. 在生成指纹信息时直接将指纹信息包含在[结构化日志事件](https://github.com/EpicGames/UnrealEngine/blob/5.6/Engine/Source/Programs/Horde/Docs/Internals/StructuredLogging.md)中。 2. 构建步骤完成后，通过在 Horde 服务器中对[结构化日志事件](https://github.com/EpicGames/UnrealEngine/blob/5.6/Engine/Source/Programs/Horde/Docs/Internals/StructuredLogging.md)进行后处理。 [事件匹配器](https://github.com/EpicGames/UnrealEngine/tree/5.6/Engine/Source/Programs/UnrealBuildTool/Matchers) 对于突出显示特定错误（在构建内）是必要的，并且如上所述，对于合并很有用。 Build Health 文档包含[有关问题匹配（和指纹打印）的信息](https://github.com/EpicGames/UnrealEngine/blob/5.6/Engine/Source/Programs/Horde/Docs/Config/BuildHealth.md#issues-spans-and-fingerprints)。每个 BuildHealth 问题都提供一个 [https://yourhorde.com/audit/issue/###](https://yourhorde.com/audit/issue/###) 日志来查看问题的历史记录。 **我如何检查...
### 数据保留
### 垃圾收集（存储服务）

**Globals.json 中的存储命名空间配置**

```
“namespaces”: [         
          {
            "id": "horde-artifacts",
            "gcFrequencyHrs": 0.1,
            "gcDelayHrs": 6,
          },
     ]
```

**相关GC配置StorageConfig**

```
/// <summary>
/// How frequently to run garbage collection, in hours.
/// </summary>
public double GcFrequencyHrs { get; set; } = 0.1;

/// <summary>
/// How long to keep newly uploaded orphaned objects before allowing them to be deleted, in hours.
/// </summary>
public double GcDelayHrs { get; set; } = 6.0;
```
### 日志清理
### 中间清理（符合（完整））
### 佩福斯
### 初始代理类型和首选代理类型
### 集群
### 方法字符串

**WorkspaceConfig 的示例方法字符串**

```
"method": "name=managedWorkspace&preferNativeClient=true&useHaveTable=false&numParallelSyncThreads=8&maxFileConcurrency=8",
```
### 分区工作区
### 托管工作区
### 表现
### 验证
### 安装人员
### Horde 解决方案和调试设置
### 架构概览
### 项目依赖关系

![项目级别依赖关系图（从 Rider Architecture 工具生成）。](assets/unreal-engine-practical-debugging-tips-for-horde/image-04.jpg)
### 服务器

![高级服务器架构以及与客户端的交互（代理、仪表板）。](assets/unreal-engine-practical-debugging-tips-for-horde/image-05.jpg)
### 数据图（存储服务）

![存储服务 blob、引用和工件的文档关系。](assets/unreal-engine-practical-debugging-tips-for-horde/image-06.jpg)
### 服务器和代理核心事务

![服务器<>代理在基本任务执行上的交互。](assets/unreal-engine-practical-debugging-tips-for-horde/image-07.jpg)
### 感兴趣的文件和一般 CSProj 结构
### C# 项目
### C# 文件
### 应用程序和源调试
### 服务器与代理
### 在同一台机器上进行服务器和代理调试

**Horde HttpPort 的环境配置**

```cpp
{ 
  "environment": 
    [ 
      {
        "name": "Horde__HttpPort", 
        "value": "51000"
      } 
    ]
}
```
### 连接到远程服务器或代理（Windows 或 Linux）

![Visual Studio 远程连接目标 - 4026 端口标识符。](assets/unreal-engine-practical-debugging-tips-for-horde/image-08.jpg)

![远程调试时禁用身份验证模式。](assets/unreal-engine-practical-debugging-tips-for-horde/image-09.jpg)
### 添加新插件
### 前端

![Chrome 开发者工具。](assets/unreal-engine-practical-debugging-tips-for-horde/image-10.jpg)
### 数据库调试和自省
### 蒙戈
### 雷迪斯

```
KEYS *
```

```
GET perforce-lb:server
```

