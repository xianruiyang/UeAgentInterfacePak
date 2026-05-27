# Horde Schema

---
title: "Horde Schema"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-schema-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde", "Horde配置", "Horde Schema"]
---

# Horde Schema

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde / Horde配置 / Horde Schema

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-schema-for-unreal-engine

## ACL 动作

### 账号

| 名称 | 说明 |
| --- | --- |
| `CreateAccount` | 能够 创建 新增 账号 |
| `UpdateAccount` | 更新 一个 账号 设置 |
| `DeleteAccount` | 删除 一个 账号 从 该 服务器 |
| `ViewAccount` | 能够 视图 账号 信息 |

### 通知

| 名称 | 说明 |
| --- | --- |
| `CreateNotice` | 能够 创建 新增 通知 |
| `UpdateNotice` | 能够 修改 通知 在 该 服务器 |
| `DeleteNotice` | 能够 删除 通知 |

### ServiceAccounts

| 名称 | 说明 |
| --- | --- |
| `CreateAccount` | 能够 创建 新增 账号 |
| `UpdateAccount` | 更新 一个 账号 设置 |
| `DeleteAccount` | 删除 一个 账号 从 该 服务器 |
| `ViewAccount` | 能够 视图 账号 信息 |

### 代理

| 名称 | 说明 |
| --- | --- |
| `CreateAgent` | 能够 创建 一个 代理. 此 可能 是 done explicitly, 或 授予 到 代理 到 允许 它们 到 自身-register. |
| `UpdateAgent` | 更新 一个 代理's 名称, 池, 等... |
| `DeleteAgent` | Soft-删除 一个 代理 |
| `ViewAgent` | 视图 一个 代理 |
| `ListAgents` | 列表 该 可用 代理 |

### 计算

| 名称 | 说明 |
| --- | --- |
| `AddComputeTasks` | 用户 可以 添加 任务 到 该 计算 集群 |
| `GetComputeTasks` | 用户 可以 获取 和 列表 任务 从 该 计算 集群 |

### 租约

| 名称 | 说明 |
| --- | --- |
| `ViewLeases` | 视图 所有 该 租约 该 一个 代理 具有 worked 在 |
| `ViewLeaseTasks` | 视图 该 任务 数据 用于 a 租约 |

### 记录

| 名称 | 说明 |
| --- | --- |
| `CreateLog` | 能够 创建 a 日志. Implicitly 授予 到 代理. |
| `UpdateLog` | 能够 更新 日志 元数据 |
| `ViewLog` | 能够 视图 a 日志 内容 |
| `WriteLogData` | 能够 写入 日志 数据 |
| `CreateEvent` | 能够 创建 事件 |
| `ViewEvent` | 能够 视图 事件 |

### 池

| 名称 | 说明 |
| --- | --- |
| `CreatePool` | 创建 a 全局 池 的 代理 |
| `UpdatePool` | 修改 一个 代理 池 |
| `DeletePool` | 删除 一个 代理 池 |
| `ViewPool` | 能够 视图 a 池 |
| `ListPools` | 视图 所有 该 可用 代理 池 |

### Sessions

| 名称 | 说明 |
| --- | --- |
| `CreateSession` | 授予 到 代理 到 调用 CreateSession, 其 返回 a Bearer 令牌 识别 它们自身 有效 到 调用 UpdateSesssion 通过 gRPC. |
| `ViewSession` | 允许 viewing 信息 关于 一个 代理 会话 |

### 软件

| 名称 | 说明 |
| --- | --- |
| `UploadSoftware` | 能够 上传 新增 版本 的 该 代理 软件 |
| `DownloadSoftware` | 能够 下载 该 代理 软件 |
| `DeleteSoftware` | 能够 删除 代理 软件 |

### 密钥

| 名称 | 说明 |
| --- | --- |
| `ViewSecret` | 视图 a credential |

### 构件

| 名称 | 说明 |
| --- | --- |
| `ReadArtifact` | Permission 到 读取 从 一个 构件 |
| `WriteArtifact` | Permission 到 写入 到 一个 构件 |
| `DeleteArtifact` | Permission 到 删除 到 一个 构件 |
| `UploadArtifact` | 能够 创建 一个 构件. Typically 仅 用于 调试; 代理 具有 此 访问 用于 a 特定 会话. |
| `DownloadArtifact` | 能够 下载 一个 构件 |

### 二分

| 名称 | 说明 |
| --- | --- |
| `CreateBisectTask` | 能够 开始 新增 二分 任务 |
| `UpdateBisectTask` | 能够 更新 a 二分 任务 |
| `ViewBisectTask` | 能够 视图 a 二分 任务 |

### 设备

| 名称 | 说明 |
| --- | --- |
| `DeviceRead` | 能够 读取 设备 |
| `DeviceWrite` | 能够 写入 设备 |

### 作业

| 名称 | 说明 |
| --- | --- |
| `CreateJob` | 能够 开始 新增 作业 |
| `UpdateJob` | Rename a 作业, 修改 它的 优先级, 等... |
| `DeleteJob` | 删除 a 作业 属性 |
| `ExecuteJob` | 允许 更新 a 作业 元数据 (名称, 变更列表 数量, 步骤 属性, 新增 groups, 作业 states, 等...). Typically 授予 到 代理. 不 用户 facing. |
| `RetryJobStep` | 能够 retry a 失败 作业 步骤 |
| `ViewJob` | 能够 视图 a 作业 |

### 通知

| 名称 | 说明 |
| --- | --- |
| `CreateSubscription` | 能够 subscribe 到 通知 |

### 项目

| 名称 | 说明 |
| --- | --- |
| `CreateProject` | 允许 该 创建 的 新增 项目 |
| `DeleteProject` | 允许 删除 的 项目. |
| `UpdateProject` | 修改 属性 的 a 项目 (名称, 类别, 等...) |
| `ViewProject` | 视图 信息 关于 a 项目 |

### Replicators

| 名称 | 说明 |
| --- | --- |
| `UpdateReplicator` | 允许 删除 的 项目. |
| `ViewReplicator` | 允许 该 创建 的 新增 项目 |

### 流

| 名称 | 说明 |
| --- | --- |
| `CreateStream` | 允许 该 创建 的 新增 流 内部 a 项目 |
| `UpdateStream` | 允许 更新 a 流 (代理 类型, 模板, 计划) |
| `DeleteStream` | 允许 deleting a 流 |
| `ViewStream` | 能够 视图 a 流 |
| `ViewChanges` | 视图 更改 提交 到 a 流. NOTE: 此 返回 响应 从 该 服务器's Perforce 账号, 其 可能 是 a priviledged 用户. |
| `ViewTemplate` | 视图 模板 关联 使用 a 流 |

### 存储

| 名称 | 说明 |
| --- | --- |
| `ReadBlobs` | 能够 读取 Blob 从 该 存储 服务 |
| `WriteBlobs` | 能够 写入 Blob 到 该 存储 服务 |
| `ReadRefs` | 能够 读取 引用 从 该 存储 服务 |
| `WriteRefs` | 能够 写入 引用 到 该 存储 服务 |
| `DeleteRefs` | 能够 删除 引用 |

### 符号

| 名称 | 说明 |
| --- | --- |
| `ReadSymbols` | 能够 下载 符号 |

### 工具

| 名称 | 说明 |
| --- | --- |
| `DownloadTool` | 能够 下载 a 工具 |
| `UploadTool` | 能够 上传 新增 工具 版本 |

### Ddc

| 名称 | 说明 |
| --- | --- |
| `DdcReadObject` | General 读取 访问 到 引用 / Blob 和 so 在 |
| `DdcWriteObject` | General 写入 访问 到 上传 引用 / Blob 等 |
| `DdcDeleteObject` | 访问 删除 Blob / 引用 等 |
| `DdcDeleteBucket` | 访问 删除 a 特定 存储桶 |
| `DdcDeleteNamespace` | 访问 删除 a 整个 命名空间 |
| `DdcReadTransactionLog` | 访问 读取 该 事务 日志 |
| `DdcWriteTransactionLog` | 访问 写入 该 事务 日志 |
| `DdcAdminAction` | 访问 执行 管理 任务 |

TODO---------------------------------------------------------

## 仪表板

配置 用于 仪表板 功能.

| 名称 | 说明 |
| --- | --- |
| `showLandingPage` | `boolean` Navigate to the landing page by default |
| `landingPageRoute` | `string` Custom landing page route to direct users to |
| `showCI` | `boolean` Enable CI functionality |
| `showAgents` | `boolean` Whether to show functionality related to agents, pools, and utilization on the dashboard. |
| `showAgentRegistration` | `boolean` Whether to show the agent registration page. When using registration tokens from elsewhere this is not needed. |
| `showPerforceServers` | `boolean` Show the Perforce server option on the server menu |
| `showDeviceManager` | `boolean` Show the device manager on the server menu |
| `showTests` | `boolean` Show automated tests on the server menu |
| `agentCategories` | [DashboardAgentCategoryConfig](#dashboardagentcategoryconfig)`[]` Configuration for different agent pages |
| `poolCategories` | [DashboardPoolCategoryConfig](#dashboardpoolcategoryconfig)`[]` Configuration for different pool pages |
| `include` | [ConfigInclude](#configinclude)`[]` Includes for other configuration files |
| `macros` | [ConfigMacro](#configmacro)`[]` Macros within this configuration |

### DashboardAgentCategoryConfig

配置 用于 a 类别 的 代理.

| 名称 | 说明 |
| --- | --- |
| `name` | `string` Name of the category |
| `condition` | `string` Condition string to be evaluated for this page |

### DashboardPoolCategoryConfig

配置 用于 a 类别 的 池.

| 名称 | 说明 |
| --- | --- |
| `name` | `string` Name of the category |
| `condition` | `string` Condition string to be evaluated for this page |

### ConfigInclude

Directive 到 合并 配置 数据 从 另一个 源.

| 名称 | 说明 |
| --- | --- |
| `path` | `string` Path to the config data to be included. May be relative to the including file's location. |

### ConfigMacro

Declares a 配置 宏.

| 名称 | 说明 |
| --- | --- |
| `name` | `string` Name of the macro property |
| `value` | `string` Value for the macro property |

## Globals

全局 配置. (Globals.JSON)

| 名称 | 说明 |
| --- | --- |
| `version` | `integer` Version number for the server. Values are indicated by the . |
| `include` | [ConfigInclude](#configinclude)`[]` Other paths to include |
| `macros` | [ConfigMacro](#configmacro)`[]` Macros within the global scope |
| `dashboard` | DashboardConfig 设置 用于 该 仪表板 |
| `downtime` | [ScheduledDowntime](#scheduleddowntime)`[]` List of scheduled downtime |
| `plugins` | [GlobalPluginsConfig](#globalpluginsconfig) 插件 配置 对象 |
| `parameters` | `object` General parameters for other tools. Can be queried through the api/v1/parameters endpoint. |
| `acl` | [AclConfig](#aclconfig) 访问 控制 列表 |

### ConfigInclude

Directive 到 合并 配置 数据 从 另一个 源.

| 名称 | 说明 |
| --- | --- |
| `path` | `string` Path to the config data to be included. May be relative to the including file's location. |

### ConfigMacro

Declares a 配置 宏

| 名称 | 说明 |
| --- | --- |
| `name` | `string` Name of the macro property |
| `value` | `string` Value for the macro property |

### ScheduledDowntime

设置 用于 该 maintenance 窗口

| 名称 | 说明 |
| --- | --- |
| `startTime` | `string` Start time |
| `finishTime` | `string` Finish time |
| `frequency` | [ScheduledDowntimeFrequency](#scheduleddowntimefrequency-enum) 频率 该 该 窗口 重复 |

### ScheduledDowntimeFrequency (Enum)

如何 频繁 该 maintence 窗口 重复

| 名称 | 说明 |
| --- | --- |
| `Once` | 一次 |
| `Daily` | 每个 天 |
| `Weekly` | 每个 week |

### GlobalPluginsConfig

| 名称 | 说明 |
| --- | --- |
| `compute` | [ComputeConfig](#computeconfig) 配置 用于 该 计算 插件 |
| `secrets` | [SecretsConfig](#secretsconfig) 配置 用于 该 密钥 插件 |
| `analytics` | [AnalyticsConfig](#analyticsconfig) 配置 用于 该 分析 插件 |
| `build` | [BuildConfig](#buildconfig) 配置 用于 该 构建 插件 |
| `storage` | [StorageConfig](#storageconfig) 配置 用于 该 存储 插件 |
| `symbols` | [SymbolsConfig](#symbolsconfig) 配置 用于 该 符号 插件 |
| `tools` | [ToolsConfig](#toolsconfig) 配置 用于 该 工具 插件 |
| `ddc` | [EmptyPluginConfig](#emptypluginconfig) 配置 用于 该 DDC 插件 |

### ComputeConfig

配置 用于 该 计算 系统

| 名称 | 说明 |
| --- | --- |
| `acl` | [AclConfig](#aclconfig) 继承 根 acl |
| `versionEnum` | [ConfigVersion](#configversion-enum) 配置 版本 数量 |
| `rates` | [AgentRateConfig](#agentrateconfig)`[]` List of costs of a particular agent type |
| `clusters` | [ComputeClusterConfig](#computeclusterconfig)`[]` List of compute profiles |
| `pools` | [PoolConfig](#poolconfig)`[]` List of pools |
| `software` | [AgentSoftwareConfig](#agentsoftwareconfig)`[]` List of costs of a particular agent type |
| `networks` | [NetworkConfig](#networkconfig)`[]` List of networks |

### AclConfig

参数 到 更新 一个 ACL

| 名称 | 说明 |
| --- | --- |
| `entries` | [AclEntryConfig](#aclentryconfig)`[]` Entries to replace the existing ACL |
| `profiles` | [AclProfileConfig](#aclprofileconfig)`[]` Defines profiles which allow grouping sets of actions into named collections |
| `inherit` | `boolean` Whether to inherit permissions from the parent ACL |
| `exceptions` | `string[]` List of exceptions to the inherited setting |

### AclEntryConfig

单独 条目 在 一个 ACL

| 名称 | 说明 |
| --- | --- |
| `claim` | [AclClaimConfig](#aclclaimconfig) 名称 的 该 用户 或 组 |
| `actions` | `string[]` Array of actions to allow |
| `profiles` | `string[]` List of profiles to grant |

### AclClaimConfig

新增 声明 到 创建

| 名称 | 说明 |
| --- | --- |
| `type` | `string` The claim type |
| `value` | `string` The claim value |

### AclProfileConfig

配置 用于 一个 ACL 分析. 此 defines a 预设 组 的 动作 其 可以 是 给定 到 a 用户 通过 一个 ACL 条目.

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Identifier for this profile |
| `actions` | `string[]` Actions to include |
| `excludeActions` | `string[]` Actions to exclude from the inherited actions |
| `extends` | `string[]` Other profiles to extend from |

### ConfigVersion (Enum)

全局 版本 数量 用于 运行 该 服务器. 作为 新增 功能 为 introduced 该 要求 数据 migrations, 此 版本 数量 表示 该 向后 兼容性 功能 该 必须 是 启用. 当 adding a 新增 版本 此处, 还 添加 a message 到 ConfigService.CreateSnapshotAsync 描述 该 步骤 该 需要 到 是 taken 到 upgrade 该 部署.

| 名称 | 说明 |
| --- | --- |
| `None` | 不 指定 |
| `Initial` | 初始 版本 数量 |
| `PoolsInConfigFiles` | 能够 添加/移除 池 通过 该 REST API 是 已移除. 池 应 是 已配置 通过 globals.JSON 改为. |
| `Latest` | Latest 版本 数量 |
| `LatestPlusOne` | 一个 之后 该 l`ast 定义 版本 数量 |

### AgentRateConfig

Describes 该 monetary cost 的 代理 匹配 a 特定 criteria

| 名称 | 说明 |
| --- | --- |
| `condition` | `string` Condition string |
| `rate` | `number` Rate for this agent |

### ComputeClusterConfig

分析 用于 执行 计算 请求

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Name of the partition |
| `namespaceId` | `string` Name of the namespace to use |
| `requestBucketId` | `string` Name of the input bucket |
| `responseBucketId` | `string` Name of the output bucket |
| `condition` | `string` Filter for agents to include |
| `acl` | [AclConfig](#aclconfig) 访问 控制 列表 |

### PoolConfig

Mutable 配置 用于 a 池

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Unique id for this pool |
| `base` | `string` Base pool config to copy settings from |
| `name` | `string` Name of the pool |
| `condition` | `string` Condition for agents to automatically be included in this pool |
| `properties` | `string` `->` `string` Arbitrary properties related to this pool |
| `color` | [PoolColor](#poolcolor-enum) 颜色 到 使用 用于 此 池 在 该 仪表板 |
| `enableAutoscaling` | `boolean` Whether to enable autoscaling for this pool |
| `minAgents` | `integer` The minimum number of agents to keep in the pool |
| `numReserveAgents` | `integer` The minimum number of idle agents to hold in reserve |
| `conformInterval` | `string` Interval between conforms. If zero, the pool will not conform on a schedule. |
| `scaleOutCooldown` | `string` Cooldown time between scale-out events |
| `scaleInCooldown` | `string` Cooldown time between scale-in events |
| `shutdownIfDisabledGracePeriod` | `string` Time to wait before shutting down an agent that has been disabled |
| `sizeStrategy` | [PoolSizeStrategy](#poolsizestrategy-enum) |
| `sizeStrategies` | [PoolSizeStrategyInfo](#poolsizestrategyinfo)`[]` List of pool sizing strategies for this pool. The first strategy with a matching condition will be picked. |
| `fleetManagers` | [FleetManagerInfo](#fleetmanagerinfo)`[]` List of fleet managers for this pool. The first strategy with a matching condition will be picked. If empty or no conditions match, a default fleet manager will be used. |
| `leaseUtilizationSettings` | [LeaseUtilizationSettings](#leaseutilizationsettings) 设置 用于 租约 利用率 池 大小调整 策略 (如果 使用) |
| `jobQueueSettings` | [JobQueueSettings](#jobqueuesettings) 设置 用于 作业 队列 池 大小调整 策略 (如果 使用) |
| `computeQueueAwsMetricSettings` | [ComputeQueueAwsMetricSettings](#computequeueawsmetricsettings) 设置 用于 作业 队列 池 大小调整 策略 (如果 使用) |

### PoolColor (Enum)

颜色 到 使用 用于 标签 的 此 池

| 名称 | 说明 |
| --- | --- |
| `Default` | 默认值 |
| `Blue` | Blue |
| `Orange` | Orange |
| `Green` | Green |
| `Gray` | Gray |

### PoolSizeStrategy (Enum)

可用 池 大小调整 策略

| 名称 | 说明 |
| --- | --- |
| `LeaseUtilization` | 策略 基于 在 租约 利用率 |
| `JobQueue` | 策略 基于 在 大小 的 作业 构建 队列 |
| `NoOp` | No-op 策略 使用 作为 回退/默认 行为 |
| `ComputeQueueAwsMetric` | A no-op 策略 该 报告 指标 到 让 一个 外部 AWS 自动-缩放 策略 缩放 该 机群 |
| `LeaseUtilizationAwsMetric` | A no-op 策略 该 报告 指标 到 让 一个 外部 AWS 自动-缩放 策略 缩放 该 机群 |

### PoolSizeStrategyInfo

元数据 用于 配置 和 选择 a 池 大小调整 策略

| 名称 | 说明 |
| --- | --- |
| `type` | [PoolSizeStrategy](#poolsizestrategy-enum) 策略 实现 到 使用 |
| `condition` | `string` Condition if this strategy should be enabled (right now, using date/time as a distinguishing factor) |
| `config` | `object` Configuration for the strategy, serialized as JSON |
| `extraAgentCount` | `integer` Integer to add after pool size has been calculated. Can also be negative. |

### FleetManagerInfo

元数据 用于 配置 和 选择 a 机群 管理器

| 名称 | 说明 |
| --- | --- |
| `type` | [FleetManagerType](#fleetmanagertype-enum) 机群 管理器 类型 实现 到 使用 |
| `condition` | `string` Condition if this strategy should be enabled (right now, using date/time as a distinguishing factor) |
| `config` | `object` Configuration for the strategy, serialized as JSON |

### FleetManagerType (Enum)

可用 机群 管理器

| 名称 | 说明 |
| --- | --- |
| `Default` | 默认值 机群 管理器 |
| `NoOp` | No-op 机群 管理器. |
| `Aws` | 机群 管理器 用于 处理 AWS EC2 实例. 将 创建 和/或 终止 实例 从 临时. |
| `AwsReuse` | 机群 管理器 用于 处理 AWS EC2 实例. 将 开始 已经 现有 但是 停止 实例 到 复用 现有 EBS 磁盘. |
| `AwsRecycle` | 机群 管理器 用于 处理 AWS EC2 实例. 将 开始 已经 现有 但是 停止 实例 到 复用 现有 EBS 磁盘. |
| `AwsAsg` | 机群 管理器 用于 处理 AWS EC2 实例. 使用 一个 EC2 自动-缩放 组 用于 控制 该 数量 的 运行 实例. |

### LeaseUtilizationSettings

租约 利用率 大小调整 设置 用于 a 池

| 名称 | 说明 |
| --- | --- |
| `sampleTimeSec` | `integer` Time period for each sample |
| `numSamples` | `integer` Number of samples to collect for calculating lease utilization |
| `numSamplesForResult` | `integer` Min number of samples for a valid result |
| `minAgents` | `integer` The minimum number of agents to keep in the pool |
| `numReserveAgents` | `integer` The minimum number of idle agents to hold in reserve |

### JobQueueSettings

作业 队列 大小调整 设置 用于 a 池

| 名称 | 说明 |
| --- | --- |
| `scaleOutFactor` | `number` Factor translating queue size to additional agents to grow the pool with The result is always rounded up to nearest integer. Example: if there are 20 jobs in queue, a factor 0.25 will result in 5 new agents being added (20 * 0.25) |
| `scaleInFactor` | `number` Factor by which to shrink the pool size with when queue is empty The result is always rounded up to nearest integer. Example: when the queue size is zero, a default value of 0.9 will shrink the pool by 10% (current agent count * 0.9) |
| `samplePeriodMin` | `integer` How far back in time to look for job batches (that potentially are in the queue) |
| `readyTimeThresholdSec` | `integer` Time spent in ready state before considered truly waiting for an agent A job batch can be in ready state before getting picked up and executed. This threshold will help ensure only batches that have been waiting longer than this value will be considered. |

### ComputeQueueAwsMetricSettings

| 名称 | 说明 |
| --- | --- |
| `computeClusterId` | `string` Compute cluster ID to observe |
| `namespace` | `string` AWS CloudWatch namespace to write metrics in |

### AgentSoftwareConfig

Selects 不同 代理 软件 版本 通过 评估 a 条件

| 名称 | 说明 |
| --- | --- |
| `toolId` | `string` Tool identifier |
| `condition` | `string` Condition for using this channel |

### NetworkConfig

Describes a 网络 该 ID describes 任何 逻辑 分组, 例如 作为 region, availability zone, rack 或 office 位置.

| 名称 | 说明 |
| --- | --- |
| `id` | `string` ID for this network |
| `cidrBlock` | `string` CIDR block |
| `description` | `string` Human-readable description |
| `computeId` | `string` Compute ID for this network (used when allocating compute resources) |

### SecretsConfig

配置 用于 该 密钥 系统

| 名称 | 说明 |
| --- | --- |
| `secrets` | [SecretConfig](#secretconfig)`[]` List of secrets |

### SecretConfig

配置 用于 a 密钥 值

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Identifier for this secret |
| `data` | `string` `->` `string` Key/value pairs associated with this secret |
| `sources` | [ExternalSecretConfig](#externalsecretconfig)`[]` Providers to source key/value pairs from |
| `acl` | [AclConfig](#aclconfig) Defines 访问 到 此 特定 密钥 |

### ExternalSecretConfig

配置 用于 一个 外部 密钥 提供者

| 名称 | 说明 |
| --- | --- |
| `provider` | `string` Name of the provider to use |
| `format` | [ExternalSecretFormat](#externalsecretformat-enum) 格式 的 该 密钥 |
| `key` | `string` Optional key indicating the parameter to set in the resulting data array. Required if if is . |
| `path` | `string` Optional value indicating what to fetch from the provider |

### ExternalSecretFormat (Enum)

格式 描述 如何 到 parse 外部 密钥 值

| 名称 | 说明 |
| --- | --- |
| `Text` | 密钥 是 a plain 文本 值 其 将 是 存储 使用 该 外部 密钥 键 |
| `Json` | 密钥 是 a JSON formatted 字符串 包含 键/值 键值对 |

### AnalyticsConfig

配置 设置 用于 分析

| 名称 | 说明 |
| --- | --- |
| `stores` | TelemetryStoreConfig`[]` Metrics to aggregate on the Horde server |

### BuildConfig

配置 用于 该 构建 插件

| 名称 | 说明 |
| --- | --- |
| `perforceClusters` | [PerforceCluster](#perforcecluster)`[]` List of Perforce clusters |
| `devices` | [DeviceConfig](#deviceconfig) 设备 配置 |
| `maxConformCount` | `integer` Maximum number of conforms to run at once |
| `agentShutdownIfDisabledGracePeriod` | `string` Time to wait before shutting down an agent that has been disabled Used if no value is set on the actual pool. |
| `artifactTypes` | [ArtifactTypeConfig](#artifacttypeconfig)`[]` Configuration for different artifact types |
| `projects` | ProjectConfig`[]` List of projects |
| `enableConformTasks` | `boolean` Whether to allow conform tasks to run |
| `issueFixedTag` | `string` Commit tag to use for marking issues as fixed |

### PerforceCluster

信息 关于 a 集群 的 Perforce 服务器.

| 名称 | 说明 |
| --- | --- |
| `name` | `string` Name of the cluster |
| `serviceAccount` | `string` Username for Horde to log in to this server. Will use the first account specified below if not overridden. |
| `canImpersonate` | `boolean` Whether the service account can impersonate other users |
| `supportsPartitionedWorkspaces` | `boolean` Whether to use partitioned workspaces on this server |
| `servers` | [PerforceServer](#perforceserver)`[]` List of servers |
| `credentials` | [PerforceCredentials](#perforcecredentials)`[]` List of server credentials |
| `autoSdk` | [AutoSdkWorkspace](#autosdkworkspace)`[]` List of autosdk streams |

### PerforceServer

信息 关于 一个 单独 Perforce 服务器

| 名称 | 说明 |
| --- | --- |
| `serverAndPort` | `string` The server and port. The server may be a DNS entry with multiple records, in which case it will be actively load balanced. If "ssl:" prefix is used, ensure P4 server's fingerprint/certificate is trusted. See Horde's documentation on connecting to SSL-enabled Perforce servers. |
| `healthCheck` | `boolean` Whether to query the healthcheck address under each server |
| `resolveDns` | `boolean` Whether to resolve the DNS entries and load balance between different hosts |
| `maxConformCount` | `integer` Maximum number of simultaneous conforms on this server |
| `condition` | `string` Optional condition for a machine to be eligible to use this server |
| `properties` | `string[]` List of properties for an agent to be eligible to use this server |

### PerforceCredentials

凭据 用于 a Perforce 用户

| 名称 | 说明 |
| --- | --- |
| `userName` | `string` The username |
| `password` | `string` Password for the user |
| `ticket` | `string` Login ticket for the user (will be used instead of password if set) |

### AutoSdkWorkspace

路径 到 a 平台 和 流 到 使用 用于 同步 AutoSDK

| 名称 | 说明 |
| --- | --- |
| `name` | `string` Name of this workspace |
| `properties` | `string[]` The agent properties to check (eg. "OSFamily=Windows") |
| `userName` | `string` Username for logging in to the server |
| `stream` | `string` Stream to use |

### DeviceConfig

配置 用于 设备

| 名称 | 说明 |
| --- | --- |
| `platforms` | [DevicePlatformConfig](#deviceplatformconfig)`[]` List of device platforms |
| `pools` | [DevicePoolConfig](#devicepoolconfig)`[]` List of device pools |

### DevicePlatformConfig

配置 用于 a 设备 平台

| 名称 | 说明 |
| --- | --- |
| `id` | `string` The id for this platform |
| `name` | `string` Name of the platform |
| `models` | `string[]` A list of platform models |
| `legacyNames` | `string[]` Legacy names which older versions of Gauntlet may be using |
| `legacyPerfSpecHighModel` | `string` Model name for the high perf spec, which may be requested by Gauntlet |

### DevicePoolConfig

配置 用于 a 设备 池

| 名称 | 说明 |
| --- | --- |
| `id` | `string` The id for this platform |
| `name` | `string` The name of the pool |
| `poolType` | [DevicePoolType](#devicepooltype-enum) 该 类型 的 该 池 |
| `projectIds` | `string[]` List of project ids associated with pool |

### DevicePoolType (Enum)

该 类型 的 设备 池

| 名称 | 说明 |
| --- | --- |
| `Automation` | 可用 到 CIS 作业 |
| `Shared` | Shared 通过 用户 使用 远程 检查 和 签出 |

### ArtifactTypeConfig

配置 用于 一个 构件

| 名称 | 说明 |
| --- | --- |
| `name` | `string` Legacy 'Name' property |
| `type` | `string` Name of the artifact type |
| `acl` | [AclConfig](#aclconfig) Acl 用于 该 构件 类型 |
| `keepCount` | `integer` Number of artifacts to retain |
| `keepDays` | `integer` Number of days to retain artifacts of this type |
| `namespaceId` | `string` Storage namespace to use for this artifact types |

### StorageConfig

配置 用于 存储

| 名称 | 说明 |
| --- | --- |
| `enableGc` | `boolean` Whether to enable garbage collection |
| `enableGcVerification` | `boolean` Whether to enable garbage collection in verification mode (nothing deleted, just logging on access to deleted blobs) |
| `backends` | [BackendConfig](#backendconfig)`[]` List of storage backends |
| `namespaces` | [NamespaceConfig](#namespaceconfig)`[]` List of namespaces for storage |

### BackendConfig

通用 设置 对象 用于 不同 providers

| 名称 | 说明 |
| --- | --- |
| `id` | `string` The storage backend ID |
| `base` | `string` Base backend to copy default settings from |
| `secondary` | `string` Specifies another backend to read from if an object is not found in this one. Can be used when migrating data from one backend to another. |
| `type` | [StorageBackendType](#storagebackendtype-enum) |
| `baseDir` | `string` |
| `awsBucketName` | `string` Name of the bucket to use |
| `awsBucketPath` | `string` Base path within the bucket |
| `awsCredentials` | [AwsCredentialsType](#awscredentialstype-enum) 类型 的 凭据 到 使用 |
| `awsRole` | `string` ARN of a role to assume |
| `awsProfile` | `string` The AWS profile to read credentials form |
| `awsRegion` | `string` Region to connect to |
| `azureConnectionString` | `string` Connection string for Azure |
| `azureContainerName` | `string` Name of the container |
| `relayServer` | `string` |
| `relayToken` | `string` |
| `gcsBucketName` | `string` Name of the GCS bucket to use |
| `gcsBucketPath` | `string` Base path within the bucket |

### StorageBackendType (Enum)

类型 的 存储 后端 到 使用

| 名称 | 说明 |
| --- | --- |
| `FileSystem` | 本地 文件系统 |
| `Aws` | AWS S3 |
| `Azure` | Azure Blob 存储 |
| `Gcs` | Google Cloud 存储 |
| `Memory` | 在-内存 仅 (用于 测试) |

### AwsCredentialsType (Enum)

凭据 到 使用 用于 AWS

| 名称 | 说明 |
| --- | --- |
| `Default` | 使用 默认 凭据 从 该 AWS SDK |
| `Profile` | 读取 凭据 从 该 分析 在 该 AWS 配置 文件 |
| `AssumeRole` | 假定 a 特定 角色. 应 specify ARN 在 |
| `AssumeRoleWebIdentity` | 假定 a 特定 角色 使用 该 当前 环境 变量. |

### NamespaceConfig

配置 的 a 特定 命名空间

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Identifier for this namespace |
| `backend` | `string` Backend to use for this namespace |
| `prefix` | `string` Prefix for items within this namespace |
| `gcFrequencyHrs` | `number` How frequently to run garbage collection, in hours. |
| `gcDelayHrs` | `number` How long to keep newly uploaded orphanned objects before allowing them to be deleted, in hours. |
| `enableAliases` | `boolean` Support querying exports by their aliases |
| `acl` | [AclConfig](#aclconfig) 访问 列表 用于 此 命名空间 |

### SymbolsConfig

配置 用于 该 工具 系统

| 名称 | 说明 |
| --- | --- |
| `stores` | [SymbolStoreConfig](#symbolstoreconfig)`[]` List of symbol stores |

### SymbolStoreConfig

配置 用于 a 符号 存储

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Identifier for this store |
| `namespaceId` | `string` Configuration for the symbol store backend |
| `public` | `boolean` Whether to make this store available without auth |
| `acl` | [AclConfig](#aclconfig) 访问 该 符号 存储 |

### ToolsConfig

配置 用于 该 工具 系统

| 名称 | 说明 |
| --- | --- |
| `tools` | [ToolConfig](#toolconfig)`[]` Tool configurations |

### ToolConfig

选项 用于 配置 a 工具

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Unique identifier for the tool |
| `name` | `string` Name of the tool |
| `description` | `string` Description for the tool |
| `category` | `string` Category for the tool. Will cause the tool to be shown in a different tab in the dashboard. |
| `group` | `string` Grouping key for different variations of the same tool. The dashboard will show these together. |
| `platforms` | `string[]` Platforms for this tool. Takes the form of a NET RID (https://learn.microsoft.com/en-us/dotnet/core/rid-catalog). |
| `public` | `boolean` Whether this tool should be exposed for download on a public endpoint without authentication |
| `showInUgs` | `boolean` Whether to show this tool for download in the UGS tools menu |
| `showInDashboard` | `boolean` Whether to show this tool for download in the dashboard |
| `showInToolbox` | `boolean` Whether to show this tool for download in Unreal Toolbox |
| `metadata` | `string` `->` `string` Metadata for this tool |
| `namespaceId` | `string` Default namespace for new deployments of this tool |
| `acl` | [AclConfig](#aclconfig) 权限 用于 该 工具 |

## 项目

存储 配置 用于 a 项目. (*.项目.JSON)

| 名称 | 说明 |
| --- | --- |
| `id` | `string` The project id |
| `name` | `string` Name for the new project |
| `path` | `string` Direct include path for the project config. For backwards compatibility with old config files when including from a GlobalConfig object. |
| `include` | [ConfigInclude](#configinclude)`[]` Includes for other configuration files |
| `macros` | [ConfigMacro](#configmacro)`[]` Macros within the global scope |
| `order` | `integer` Order of this project on the dashboard |
| `logo` | `string` Path to the project logo |
| `logoDarkTheme` | `string` Optional path to the project logo for the dark theme |
| `pools` | [PoolConfig](#poolconfig)`[]` List of pools for this project |
| `categories` | [ProjectCategoryConfig](#projectcategoryconfig)`[]` Categories to include in this project |
| `jobOptions` | [JobOptions](#joboptions) 默认值 设置 用于 执行 作业 |
| `workspaceTypes` | `string` `->` [WorkspaceConfig](#workspaceconfig) 默认值 工作区 类型 用于 流 这些 为 已添加 到 该 列表 的 每个 流's 工作区 类型. |
| `telemetryStoreId` | `string` Telemetry store for Horde data for this project |
| `streams` | StreamConfig`[]` List of streams |
| `artifactTypes` | [ArtifactTypeConfig](#artifacttypeconfig)`[]` Permissions for artifact types |
| `acl` | [AclConfig](#aclconfig) Acl 条目 |

### ConfigInclude

Directive 到 合并 配置 数据 从 另一个 源

| 名称 | 说明 |
| --- | --- |
| `path` | `string` Path to the config data to be included. May be relative to the including file's location. |

### ConfigMacro

Declares a 配置 宏

| 名称 | 说明 |
| --- | --- |
| `name` | `string` Name of the macro property |
| `value` | `string` Value for the macro property |

### PoolConfig

Mutable 配置 用于 a 池

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Unique id for this pool |
| `base` | `string` Base pool config to copy settings from |
| `name` | `string` Name of the pool |
| `condition` | `string` Condition for agents to automatically be included in this pool |
| `properties` | `string` `->` `string` Arbitrary properties related to this pool |
| `color` | [PoolColor](#poolcolor-enum) 颜色 到 使用 用于 此 池 在 该 仪表板 |
| `enableAutoscaling` | `boolean` Whether to enable autoscaling for this pool |
| `minAgents` | `integer` The minimum number of agents to keep in the pool |
| `numReserveAgents` | `integer` The minimum number of idle agents to hold in reserve |
| `conformInterval` | `string` Interval between conforms. If zero, the pool will not conform on a schedule. |
| `scaleOutCooldown` | `string` Cooldown time between scale-out events |
| `scaleInCooldown` | `string` Cooldown time between scale-in events |
| `shutdownIfDisabledGracePeriod` | `string` Time to wait before shutting down an agent that has been disabled |
| `sizeStrategy` | [PoolSizeStrategy](#poolsizestrategy-enum) |
| `sizeStrategies` | [PoolSizeStrategyInfo](#poolsizestrategyinfo)`[]` List of pool sizing strategies for this pool. The first strategy with a matching condition will be picked. |
| `fleetManagers` | [FleetManagerInfo](#fleetmanagerinfo)`[]` List of fleet managers for this pool. The first strategy with a matching condition will be picked. If empty or no conditions match, a default fleet manager will be used. |
| `leaseUtilizationSettings` | [LeaseUtilizationSettings](#leaseutilizationsettings) 设置 用于 租约 利用率 池 大小调整 策略 (如果 使用) |
| `jobQueueSettings` | [JobQueueSettings](#jobqueuesettings) 设置 用于 作业 队列 池 大小调整 策略 (如果 使用) |
| `computeQueueAwsMetricSettings` | [ComputeQueueAwsMetricSettings](#computequeueawsmetricsettings) 设置 用于 作业 队列 池 大小调整 策略 (如果 使用) |

### PoolColor (Enum)

颜色 到 使用 用于 标签 的 此 池

| 名称 | 说明 |
| --- | --- |
| `Default` | 默认值 |
| `Blue` | Blue |
| `Orange` | Orange |
| `Green` | Green |
| `Gray` | Gray |

### PoolSizeStrategy (Enum)

可用 池 大小调整 策略

| 名称 | 说明 |
| --- | --- |
| `LeaseUtilization` | 策略 基于 在 租约 利用率 |
| `JobQueue` | 策略 基于 在 大小 的 作业 构建 队列 |
| `NoOp` | No-op 策略 使用 作为 回退/默认 行为 |
| `ComputeQueueAwsMetric` | A no-op 策略 该 报告 指标 到 让 一个 外部 AWS 自动-缩放 策略 缩放 该 机群 |
| `LeaseUtilizationAwsMetric` | A no-op 策略 该 报告 指标 到 让 一个 外部 AWS 自动-缩放 策略 缩放 该 机群 |

### PoolSizeStrategyInfo

元数据 用于 配置 和 选择 a 池 大小调整 策略

| 名称 | 说明 |
| --- | --- |
| `type` | [PoolSizeStrategy](#poolsizestrategy-enum) 策略 实现 到 使用 |
| `condition` | `string` Condition if this strategy should be enabled (right now, using date/time as a distinguishing factor) |
| `config` | `object` Configuration for the strategy, serialized as JSON |
| `extraAgentCount` | `integer` Integer to add after pool size has been calculated. Can also be negative. |

### FleetManagerInfo

元数据 用于 配置 和 选择 a 机群 管理器

| 名称 | 说明 |
| --- | --- |
| `type` | [FleetManagerType](#fleetmanagertype-enum) 机群 管理器 类型 实现 到 使用 |
| `condition` | `string` Condition if this strategy should be enabled (right now, using date/time as a distinguishing factor) |
| `config` | `object` Configuration for the strategy, serialized as JSON |

### FleetManagerType (Enum)

可用 机群 管理器

| 名称 | 说明 |
| --- | --- |
| `Default` | 默认值 机群 管理器 |
| `NoOp` | No-op 机群 管理器. |
| `Aws` | 机群 管理器 用于 处理 AWS EC2 实例. 将 创建 和/或 终止 实例 从 临时. |
| `AwsReuse` | 机群 管理器 用于 处理 AWS EC2 实例. 将 开始 已经 现有 但是 停止 实例 到 复用 现有 EBS 磁盘. |
| `AwsRecycle` | 机群 管理器 用于 处理 AWS EC2 实例. 将 开始 已经 现有 但是 停止 实例 到 复用 现有 EBS 磁盘. |
| `AwsAsg` | 机群 管理器 用于 处理 AWS EC2 实例. 使用 一个 EC2 自动-缩放 组 用于 控制 该 数量 的 运行 实例. |

### LeaseUtilizationSettings

租约 利用率 大小调整 设置 用于 a 池

| 名称 | 说明 |
| --- | --- |
| `sampleTimeSec` | `integer` Time period for each sample |
| `numSamples` | `integer` Number of samples to collect for calculating lease utilization |
| `numSamplesForResult` | `integer` Min number of samples for a valid result |
| `minAgents` | `integer` The minimum number of agents to keep in the pool |
| `numReserveAgents` | `integer` The minimum number of idle agents to hold in reserve |

### JobQueueSettings

作业 队列 大小调整 设置 用于 a 池

| 名称 | 说明 |
| --- | --- |
| `scaleOutFactor` | `number` Factor translating queue size to additional agents to grow the pool with The result is always rounded up to nearest integer. Example: if there are 20 jobs in queue, a factor 0.25 will result in 5 new agents being added (20 * 0.25) |
| `scaleInFactor` | `number` Factor by which to shrink the pool size with when queue is empty The result is always rounded up to nearest integer. Example: when the queue size is zero, a default value of 0.9 will shrink the pool by 10% (current agent count * 0.9) |
| `samplePeriodMin` | `integer` How far back in time to look for job batches (that potentially are in the queue) |
| `readyTimeThresholdSec` | `integer` Time spent in ready state before considered truly waiting for an agent A job batch can be in ready state before getting picked up and executed. This threshold will help ensure only batches that have been waiting longer than this value will be considered. |

### ComputeQueueAwsMetricSettings

设置 用于

| 名称 | 说明 |
| --- | --- |
| `computeClusterId` | `string` Compute cluster ID to observe |
| `namespace` | `string` AWS CloudWatch namespace to write metrics in |

### ProjectCategoryConfig

信息 关于 a 类别 到 显示 用于 a 流

| 名称 | 说明 |
| --- | --- |
| `name` | `string` Name of this category |
| `row` | `integer` Index of the row to display this category on |
| `showOnNavMenu` | `boolean` Whether to show this category on the nav menu |
| `includePatterns` | `string[]` Patterns for stream names to include |
| `excludePatterns` | `string[]` Patterns for stream names to exclude |

### JobOptions

选项 用于 执行 a 作业

| 名称 | 说明 |
| --- | --- |
| `executor` | `string` Name of the executor to use |
| `useWine` | `boolean` Whether to execute using Wine emulation on Linux |
| `runInSeparateProcess` | `boolean` Executes the job lease in a separate process |
| `workspaceMaterializer` | `string` What workspace materializer to use in WorkspaceExecutor. Will override any value from workspace config. |
| `container` | [JobContainerOptions](#jobcontaineroptions) 选项 用于 执行 a 作业 内部 a 容器 |
| `expireAfterDays` | `integer` Number of days after which to expire jobs |
| `driver` | `string` Name of the driver to use |

### JobContainerOptions

选项 用于 执行 a 作业 内部 a 容器

| 名称 | 说明 |
| --- | --- |
| `enabled` | `boolean` Whether to execute job inside a container |
| `imageUrl` | `string` Image URL to container, such as "quay.io/podman/hello" |
| `containerEngineExecutable` | `string` Container engine executable (docker or with full path like /usr/bin/podman) |
| `extraArguments` | `string` Additional arguments to pass to container engine |

### WorkspaceConfig

信息 关于 a 工作区 类型

| 名称 | 说明 |
| --- | --- |
| `base` | `string` Base workspace to derive from |
| `cluster` | `string` Name of the Perforce server cluster to use |
| `serverAndPort` | `string` The Perforce server and port (eg. perforce:1666) |
| `userName` | `string` User to log into Perforce with (defaults to buildmachine) |
| `password` | `string` Password to use to log into the workspace |
| `identifier` | `string` Identifier to distinguish this workspace from other workspaces. Defaults to the workspace type name. |
| `stream` | `string` Override for the stream to sync |
| `view` | `string[]` Custom view for the workspace |
| `incremental` | `boolean` Whether to use an incrementally synced workspace |
| `useAutoSdk` | `boolean` Whether to use the AutoSDK |
| `autoSdkView` | `string[]` View for the AutoSDK paths to sync. If null, the whole thing will be synced. |
| `method` | `string` Method to use when syncing/materializing data from Perforce |
| `minScratchSpace` | `integer` Minimum disk space that must be available *之后* 同步 此 工作区 (在 兆字节) 如果 不 可用, 该 作业 将 是 中止. |
| `conformDiskFreeSpace` | `integer` Threshold for when to trigger an automatic conform of agent. Measured in megabytes free on disk. Set to null or 0 to disable. |

### ArtifactTypeConfig

配置 用于 一个 构件

| 名称 | 说明 |
| --- | --- |
| `name` | `string` Legacy 'Name' property |
| `type` | `string` Name of the artifact type |
| `acl` | [AclConfig](#aclconfig) Acl 用于 该 构件 类型 |
| `keepCount` | `integer` Number of artifacts to retain |
| `keepDays` | `integer` Number of days to retain artifacts of this type |
| `namespaceId` | `string` Storage namespace to use for this artifact types |

### AclConfig

参数 到 更新 一个 ACL

| 名称 | 说明 |
| --- | --- |
| `entries` | [AclEntryConfig](#aclentryconfig)`[]` Entries to replace the existing ACL |
| `profiles` | [AclProfileConfig](#aclprofileconfig)`[]` Defines profiles which allow grouping sets of actions into named collections |
| `inherit` | `boolean` Whether to inherit permissions from the parent ACL |
| `exceptions` | `string[]` List of exceptions to the inherited setting |

### AclEntryConfig

单独 条目 在 一个 ACL

| 名称 | 说明 |
| --- | --- |
| `claim` | [AclClaimConfig](#aclclaimconfig) 名称 的 该 用户 或 组 |
| `actions` | `string[]` Array of actions to allow |
| `profiles` | `string[]` List of profiles to grant |

### AclClaimConfig

新增 声明 到 创建

| 名称 | 说明 |
| --- | --- |
| `type` | `string` The claim type |
| `value` | `string` The claim value |

### AclProfileConfig

配置 用于 一个 ACL 分析. 此 defines a 预设 组 的 动作 其 可以 是 给定 到 a 用户 通过 一个 ACL 条目.

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Identifier for this profile |
| `actions` | `string[]` Actions to include |
| `excludeActions` | `string[]` Actions to exclude from the inherited actions |
| `extends` | `string[]` Other profiles to extend from |

## 流

配置 用于 a 流. (*.流.JSON)

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Identifier for the stream |
| `path` | `string` Direct include path for the stream config. For backwards compatibility with old config files when including from a ProjectConfig object. |
| `include` | [ConfigInclude](#configinclude)`[]` Includes for other configuration files |
| `macros` | [ConfigMacro](#configmacro)`[]` Macros within this stream |
| `name` | `string` Name of the stream |
| `enginePath` | `string` Path to the engine directory within the workspace. Used for launching UAT. |
| `clusterName` | `string` The perforce cluster containing the stream |
| `order` | `integer` Order for this stream |
| `initialAgentType` | `string` Default initial agent type for templates |
| `notificationChannel` | `string` Notification channel for all jobs in this stream |
| `notificationChannelFilter` | `string` Notification channel filter for this template. Can be Success, Failure, or Warnings. |
| `triageChannel` | `string` Channel to post issue triage notifications |
| `jobOptions` | [JobOptions](#joboptions) 默认值 设置 用于 执行 作业 |
| `telemetryStoreId` | `string` Telemetry store for Horde data for this stream |
| `autoSdkView` | `string[]` View for the AutoSDK paths to sync. If null, the whole thing will be synced. |
| `defaultPreflightTemplate` | `string` Legacy name for the default preflight template |
| `defaultPreflight` | [DefaultPreflightConfig](#defaultpreflightconfig) 默认值 模板 用于 运行 预检 |
| `commitTags` | [CommitTagConfig](#committagconfig)`[]` List of tags to apply to commits. Allows fast searching and classification of different commit types (eg. code vs content). |
| `tabs` | [TabConfig](#tabconfig)`[]` List of tabs to show for the new stream |
| `environment` | `string` `->` `string` Global environment variables for all agents in this stream |
| `agentTypes` | `string` `->` [AgentConfig](#agentconfig) 映射 的 代理 名称 到 类型 |
| `workspaceTypes` | `string` `->` [WorkspaceConfig](#workspaceconfig) 映射 的 工作区 名称 到 类型 |
| `templates` | [TemplateRefConfig](#templaterefconfig)`[]` List of templates to create |
| `acl` | [AclConfig](#aclconfig) 自定义 权限 用于 此 对象 |
| `pausedUntil` | `string` Pause stream builds until specified date |
| `pauseComment` | `string` Reason for pausing builds of the stream |
| `replicators` | [ReplicatorConfig](#replicatorconfig)`[]` Configuration for workers to replicate commit data into Horde Storage. |
| `workflows` | [WorkflowConfig](#workflowconfig)`[]` Workflows for dealing with new issues |
| `tokens` | [TokenConfig](#tokenconfig)`[]` Tokens to create for each job step |
| `artifactTypes` | [ArtifactTypeConfig](#artifacttypeconfig)`[]` Permissions for artifact types |

### ConfigInclude

Directive 到 合并 配置 数据 从 另一个 源

| 名称 | 说明 |
| --- | --- |
| `path` | `string` Path to the config data to be included. May be relative to the including file's location. |

### ConfigMacro

Declares a 配置 宏

| 名称 | 说明 |
| --- | --- |
| `name` | `string` Name of the macro property |
| `value` | `string` Value for the macro property |

### JobOptions

选项 用于 执行 a 作业

| 名称 | 说明 |
| --- | --- |
| `executor` | `string` Name of the executor to use |
| `useWine` | `boolean` Whether to execute using Wine emulation on Linux |
| `runInSeparateProcess` | `boolean` Executes the job lease in a separate process |
| `workspaceMaterializer` | `string` What workspace materializer to use in WorkspaceExecutor. Will override any value from workspace config. |
| `container` | [JobContainerOptions](#jobcontaineroptions) 选项 用于 执行 a 作业 内部 a 容器 |
| `expireAfterDays` | `integer` Number of days after which to expire jobs |
| `driver` | `string` Name of the driver to use |

### JobContainerOptions

选项 用于 执行 a 作业 内部 a 容器

| 名称 | 说明 |
| --- | --- |
| `enabled` | `boolean` Whether to execute job inside a container |
| `imageUrl` | `string` Image URL to container, such as "quay.io/podman/hello" |
| `containerEngineExecutable` | `string` Container engine executable (docker or with full path like /usr/bin/podman) |
| `extraArguments` | `string` Additional arguments to pass to container engine |

### DefaultPreflightConfig

Specifies 默认值 用于 运行 a 预检

| 名称 | 说明 |
| --- | --- |
| `templateId` | `string` The template id to query |
| `change` | [ChangeQueryConfig](#changequeryconfig) 查询 用于 该 更改 到 使用 |

### ChangeQueryConfig

查询 selecting 该 基础 变更列表 到 使用

| 名称 | 说明 |
| --- | --- |
| `name` | `string` Name of this query, for display on the dashboard. |
| `condition` | `string` Condition to evaluate before deciding to use this query. May query tags in a preflight. |
| `templateId` | `string` The template id to query |
| `target` | `string` The target to query |
| `outcomes` | [JobStepOutcome](#jobstepoutcome-enum)`[]` Whether to match a job that produced warnings |
| `commitTag` | `string` Finds the last commit with this tag |

### JobStepOutcome (Enum)

Outcome 用于 a jobstep

| 名称 | 说明 |
| --- | --- |
| `Unspecified` | Outcome 是 不 已知 |
| `Failure` | 步骤 失败 |
| `Warnings` | 步骤 完成 使用 警告 |
| `Success` | 步骤 succeeded |

### CommitTagConfig

配置 用于 自定义 提交 筛选器

| 名称 | 说明 |
| --- | --- |
| `name` | `string` Name of the tag |
| `base` | `string` Base tag to copy settings from |
| `filter` | `string[]` List of files to be included in this filter |

### TabConfig

信息 关于 a 页面 到 显示 在 该 仪表板 用于 a 流

| 名称 | 说明 |
| --- | --- |
| `title` | `string` Title of this page |
| `type` | `string` Type of this tab |
| `style` | [TabStyle](#tabstyle-enum) Presentation 样式 用于 此 页面 |
| `showNames` | `boolean` Whether to show job names on this page |
| `showPreflights` | `boolean` Whether to show all user preflights |
| `jobNames` | `string[]` Names of jobs to include on this page. If there is only one name specified, the name column does not need to be displayed. |
| `templates` | `string[]` List of job template names to show on this page. |
| `columns` | [TabColumnConfig](#tabcolumnconfig)`[]` Columns to display for different types of aggregates |

### TabStyle (Enum)

样式 用于 渲染 a 标签页

| 名称 | 说明 |
| --- | --- |
| `Normal` | Regular 作业 列表 |
| `Compact` | Omit 作业 名称, 显示 压缩 视图 |

### TabColumnConfig

Describes a 列 到 显示 在 该 作业 页面

| 名称 | 说明 |
| --- | --- |
| `type` | [TabColumnType](#tabcolumntype-enum) 该 类型 的 列 |
| `heading` | `string` Heading for this column |
| `category` | `string` Category of aggregates to display in this column. If null, includes any aggregate not matched by another column. |
| `parameter` | `string` Parameter to show in this column |
| `relativeWidth` | `integer` Relative width of this column. |

### TabColumnType (Enum)

类型 的 a 列 在 a 作业 标签页

| 名称 | 说明 |
| --- | --- |
| `Labels` | 包含 标签 |
| `Parameter` | 包含 参数 |

### AgentConfig

Mapping 从 a BuildGraph 代理 类型 到 a 设置 的 机器 在 该 农场

| 名称 | 说明 |
| --- | --- |
| `base` | `string` Base agent config to inherit settings from |
| `pool` | `string` Pool of agents to use for this agent type |
| `workspace` | `string` Name of the workspace to sync |
| `tempStorageDir` | `string` Path to the temporary storage dir |
| `environment` | `string` `->` `string` Environment variables to be set when executing the job |
| `tokens` | [TokenConfig](#tokenconfig)`[]` Tokens to allocate for this agent type |

### TokenConfig

配置 用于 allocating 访问 令牌 用于 每个 作业

| 名称 | 说明 |
| --- | --- |
| `url` | `string` URL to request tokens from |
| `clientId` | `string` Client id to use to request a new token |
| `clientSecret` | `string` Client secret to request a new access token |
| `envVar` | `string` Environment variable to set with the access token |

### WorkspaceConfig

信息 关于 a 工作区 类型

| 名称 | 说明 |
| --- | --- |
| `base` | `string` Base workspace to derive from |
| `cluster` | `string` Name of the Perforce server cluster to use |
| `serverAndPort` | `string` The Perforce server and port (eg. perforce:1666) |
| `userName` | `string` User to log into Perforce with (defaults to buildmachine) |
| `password` | `string` Password to use to log into the workspace |
| `identifier` | `string` Identifier to distinguish this workspace from other workspaces. Defaults to the workspace type name. |
| `stream` | `string` Override for the stream to sync |
| `view` | `string[]` Custom view for the workspace |
| `incremental` | `boolean` Whether to use an incrementally synced workspace |
| `useAutoSdk` | `boolean` Whether to use the AutoSDK |
| `autoSdkView` | `string[]` View for the AutoSDK paths to sync. If null, the whole thing will be synced. |
| `method` | `string` Method to use when syncing/materializing data from Perforce |
| `minScratchSpace` | `integer` Minimum disk space that must be available *之后* 同步 此 工作区 (在 兆字节) 如果 不 可用, 该 作业 将 是 中止. |
| `conformDiskFreeSpace` | `integer` Threshold for when to trigger an automatic conform of agent. Measured in megabytes free on disk. Set to null or 0 to disable. |

### TemplateRefConfig

参数 到 创建 a 模板 内部 a 流

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Optional identifier for this ref. If not specified, an id will be generated from the name. |
| `base` | `string` Base template id to copy from |
| `showUgsBadges` | `boolean` Whether to show badges in UGS for these jobs |
| `showUgsAlerts` | `boolean` Whether to show alerts in UGS for these jobs |
| `notificationChannel` | `string` Notification channel for this template. Overrides the stream channel if set. |
| `notificationChannelFilter` | `string` Notification channel filter for this template. Can be a combination of "Success", "Failure" and "Warnings" separated by pipe characters. |
| `triageChannel` | `string` Triage channel for this template. Overrides the stream channel if set. |
| `workflowId` | `string` Workflow to user for this stream |
| `annotations` | `string` `->` `string` Default annotations to apply to nodes in this template |
| `schedule` | [ScheduleConfig](#scheduleconfig) 计划 到 执行 此 模板 |
| `chainedJobs` | [ChainedJobTemplateConfig](#chainedjobtemplateconfig)`[]` List of chained job triggers |
| `acl` | [AclConfig](#aclconfig) 该 ACL 用于 此 模板 |
| `name` | `string` Name for the new template |
| `description` | `string` Description for the template |
| `priority` | [优先级](#priority-enum) 默认值 优先级 用于 此 作业 |
| `allowPreflights` | `boolean` Whether to allow preflights of this template |
| `updateIssues` | `boolean` Whether issues should be updated for all jobs using this template |
| `promoteIssuesByDefault` | `boolean` Whether issues should be promoted by default for this template, promoted issues will generate user notifications |
| `initialAgentType` | `string` Initial agent type to parse the buildgraph script on |
| `submitNewChange` | `string` Path to a file within the stream to submit to generate a new changelist for jobs |
| `submitDescription` | `string` Description for new changelists |
| `defaultChange` | [ChangeQueryConfig](#changequeryconfig)`[]` Default change to build at. Each object has a condition parameter which can evaluated by the server to determine which change to use. |
| `arguments` | `string[]` Fixed arguments for the new job |
| `parameters` | [TextParameterData](#textparameterdata)/[ListParameterData](#listparameterdata)/[BoolParameterData](#boolparameterdata)`[]` Parameters for this template |
| `jobOptions` | [JobOptions](#joboptions) 默认值 设置 用于 作业 |

### ScheduleConfig

参数 到 创建 a 新增 计划

| 名称 | 说明 |
| --- | --- |
| `claims` | [AclClaimConfig](#aclclaimconfig)`[]` Roles to impersonate for this schedule |
| `enabled` | `boolean` Whether the schedule should be enabled |
| `maxActive` | `integer` Maximum number of builds that can be active at once |
| `maxChanges` | `integer` Maximum number of changes the schedule can fall behind head revision. If greater than zero, builds will be triggered for every submitted changelist until the backlog is this size. |
| `requireSubmittedChange` | `boolean` Whether the build requires a change to be submitted |
| `gate` | [ScheduleGateConfig](#schedulegateconfig) Gate 允许 该 计划 到 触发 |
| `commits` | `string[]` Commit tags for this schedule |
| `filter` | [ChangeContentFlags](#changecontentflags-enum)`[]` The types of changes to run for |
| `files` | `string[]` Files that should cause the job to trigger |
| `templateParameters` | `string` `->` `string` Parameters for the template |
| `patterns` | [SchedulePatternConfig](#schedulepatternconfig)`[]` New patterns for the schedule |

### AclClaimConfig

新增 声明 到 创建

| 名称 | 说明 |
| --- | --- |
| `type` | `string` The claim type |
| `value` | `string` The claim value |

### ScheduleGateConfig

Gate 允许 a 计划 到 触发.

| 名称 | 说明 |
| --- | --- |
| `templateId` | `string` The template containing the dependency |
| `target` | `string` Target to wait for |

### ChangeContentFlags (Enum)

标志 识别 内容 的 a 变更列表

| 名称 | 说明 |
| --- | --- |
| `ContainsCode` | 该 更改 包含 代码 |
| `ContainsContent` | 该 更改 包含 内容 |

### SchedulePatternConfig

参数 到 创建 a 新增 计划

| 名称 | 说明 |
| --- | --- |
| `daysOfWeek` | [DayOfWeek](#dayofweek-enum)`[]` Days of the week to run this schedule on. If null, the schedule will run every day. |
| `minTime` | `string` Time during the day for the first schedule to trigger. Measured in minutes from midnight. |
| `maxTime` | `string` Time during the day for the last schedule to trigger. Measured in minutes from midnight. |
| `interval` | `string` Interval between each schedule triggering |

### DayOfWeek (Enum)

| 名称 | 说明 |
| --- | --- |
| `Sunday` | Sunday |
| `Monday` | Monday |
| `Tuesday` | Tuesday |
| `Wednesday` | Wednesday |
| `Thursday` | Thursday |
| `Friday` | Friday |
| `Saturday` | Saturday |

### ChainedJobTemplateConfig

触发 用于 另一个 模板

| 名称 | 说明 |
| --- | --- |
| `trigger` | `string` Name of the target that needs to complete before starting the other template |
| `templateId` | `string` Id of the template to trigger |
| `useDefaultChangeForTemplate` | `boolean` Whether to use the default change for the template rather than the change for the parent job. |

### AclConfig

参数 到 更新 一个 ACL

| 名称 | 说明 |
| --- | --- |
| `entries` | [AclEntryConfig](#aclentryconfig)`[]` Entries to replace the existing ACL |
| `profiles` | [AclProfileConfig](#aclprofileconfig)`[]` Defines profiles which allow grouping sets of actions into named collections |
| `inherit` | `boolean` Whether to inherit permissions from the parent ACL |
| `exceptions` | `string[]` List of exceptions to the inherited setting |

### AclEntryConfig

单独 条目 在 一个 ACL

| 名称 | 说明 |
| --- | --- |
| `claim` | [AclClaimConfig](#aclclaimconfig) 名称 的 该 用户 或 组 |
| `actions` | `string[]` Array of actions to allow |
| `profiles` | `string[]` List of profiles to grant |

### AclProfileConfig

配置 用于 一个 ACL 分析. 此 defines a 预设 组 的 动作 其 可以 是 给定 到 a 用户 通过 一个 ACL 条目.

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Identifier for this profile |
| `actions` | `string[]` Actions to include |
| `excludeActions` | `string[]` Actions to exclude from the inherited actions |
| `extends` | `string[]` Other profiles to extend from |

### 优先级 (Enum)

优先级 的 a 作业 或 步骤

| 名称 | 说明 |
| --- | --- |
| `Unspecified` | 不 指定 |
| `Lowest` | Lowest 优先级 |
| `BelowNormal` | 下方 法线 优先级 |
| `Normal` | 法线 优先级 |
| `AboveNormal` | 上方 法线 优先级 |
| `High` | 高 优先级 |
| `Highest` | Highest 优先级 |

### TextParameterData

空闲-形式 文本 条目 参数

| 名称 | 说明 |
| --- | --- |
| `type` | 文本 类型 判别字段 |
| `id` | `string` Identifier for this parameter |
| `label` | `string` Name of the parameter associated with this parameter. |
| `argument` | `string` Argument to pass to the executor |
| `default` | `string` Default value for this argument |
| `scheduleOverride` | `string` Override for the default value for this parameter when running a scheduled build |
| `hint` | `string` Hint text for this parameter |
| `validation` | `string` Regex used to validate this parameter |
| `validationError` | `string` Message displayed if validation fails, informing user of valid values. |
| `toolTip` | `string` Tool-tip text to display |

### ListParameterData

允许 该 用户 到 选择 a 值 从 a constrained 列表 的 choices

| 名称 | 说明 |
| --- | --- |
| `type` | 列表 类型 判别字段 |
| `label` | `string` Label to display next to this parameter. Defaults to the parameter name. |
| `style` | [ListParameterStyle](#listparameterstyle-enum) 该 类型 的 列表 参数 |
| `items` | [ListParameterItemData](#listparameteritemdata)`[]` List of values to display in the list |
| `toolTip` | `string` Tool tip text to display |

### ListParameterStyle (Enum)

样式 的 列表 参数

| 名称 | 说明 |
| --- | --- |
| `List` | Regular 丢弃-下 列表. 一个 项 是 始终 选中. |
| `MultiList` | 丢弃-下 列表 使用 checkboxes |
| `TagPicker` | 标签 选择器 从 列表 的 选项 |

### ListParameterItemData

可能 选项 用于 a 列表 参数

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Identifier for this parameter |
| `group` | `string` Optional group heading to display this entry under, if the picker style supports it. |
| `text` | `string` Name of the parameter associated with this list. |
| `argumentIfEnabled` | `string` Argument to pass with this parameter. |
| `argumentsIfEnabled` | `string[]` Arguments to pass with this parameter. |
| `argumentIfDisabled` | `string` Argument to pass with this parameter. |
| `argumentsIfDisabled` | `string[]` Arguments to pass if this parameter is disabled. |
| `default` | `boolean` Whether this item is selected by default |
| `scheduleOverride` | `boolean` Overridden value for this property in schedule builds |

### BoolParameterData

允许 该 用户 到 切换 一个 选项 在 或 关闭

| 名称 | 说明 |
| --- | --- |
| `type` | Bool 类型 判别字段 |
| `id` | `string` Identifier for this parameter |
| `label` | `string` Name of the parameter associated with this parameter. |
| `argumentIfEnabled` | `string` Argument to add if this parameter is enabled |
| `argumentsIfEnabled` | `string[]` Argument to add if this parameter is enabled |
| `argumentIfDisabled` | `string` Argument to add if this parameter is enabled |
| `argumentsIfDisabled` | `string[]` Arguments to add if this parameter is disabled |
| `default` | `boolean` Whether this argument is enabled by default |
| `scheduleOverride` | `boolean` Override for this parameter in scheduled builds |
| `toolTip` | `string` Tool tip text to display |

### ReplicatorConfig

配置 用于 a 流 replicator

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Identifier for the replicator within the current stream |
| `enabled` | `boolean` Whether the replicator is enabled |
| `minChange` | `integer` Minimum change number to replicate |
| `maxChange` | `integer` Maximum change number to replicate |
| `includeContent` | `boolean` Whether to include content in the replication, or just metadata |
| `namespaceId` | `string` Namespace to replicate data to |

### WorkflowConfig

配置 用于 一个 问题 工作流

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Identifier for this workflow |
| `reportTimes` | `string[]` Times of day at which to send a report |
| `summaryTab` | `string` Name of the tab to post summary data to |
| `reportChannel` | `string` Channel to post summary information for these templates. |
| `reportWarnings` | `boolean` Whether to include issues with a warning status in the summary |
| `groupIssuesByTemplate` | `boolean` Whether to group issues by template in the report |
| `triageChannel` | `string` Channel to post threads for triaging new issues |
| `triagePrefix` | `string` Prefix for all triage messages |
| `triageSuffix` | `string` Suffix for all triage messages |
| `triageInstructions` | `string` Instructions posted to triage threads |
| `triageAlias` | `string` User id of a Slack user/alias to ping if there is nobody assigned to an issue by default. |
| `triageTypeAliases` | `string` `->` `string` Slack user/alias to ping for specific issue types (such as Systemic), if there is nobody assigned to an issue by default. |
| `escalateAlias` | `string` Alias to ping if an issue has not been resolved for a certain amount of time |
| `escalateTimes` | `integer[]` Times after an issue has been opened to escalate to the alias above, in minutes. Continues to notify on the last interval once reaching the end of the list. |
| `maxMentions` | `integer` Maximum number of people to mention on a triage thread |
| `allowMentions` | `boolean` Whether to mention people on this thread. Useful to disable for testing. |
| `inviteRestrictedUsers` | `boolean` Uses the admin.conversations.invite API to invite users to the channel |
| `skipWhenEmpty` | `boolean` Skips sending reports when there are no active issues. |
| `showMergeWarnings` | `boolean` Whether to show warnings about merging changes into the origin stream. |
| `annotations` | `string` `->` `string` Additional node annotations implicit in this workflow |
| `externalIssues` | [ExternalIssueConfig](#externalissueconfig) 外部 问题 跟踪 配置 用于 此 工作流 |
| `issueHandlers` | `string[]` Additional issue handlers enabled for this workflow |

### ExternalIssueConfig

外部 问题 跟踪 配置 用于 a 工作流

| 名称 | 说明 |
| --- | --- |
| `projectKey` | `string` Project key in external issue tracker |
| `defaultComponentId` | `string` Default component id for issues using workflow |
| `defaultIssueTypeId` | `string` Default issue type id for issues using workflow |

### ArtifactTypeConfig

配置 用于 一个 构件

| 名称 | 说明 |
| --- | --- |
| `name` | `string` Legacy 'Name' property |
| `type` | `string` Name of the artifact type |
| `acl` | [AclConfig](#aclconfig) Acl 用于 该 构件 类型 |
| `keepCount` | `integer` Number of artifacts to retain |
| `keepDays` | `integer` Number of days to retain artifacts of this type |
| `namespaceId` | `string` Storage namespace to use for this artifact types |

TODO-------------------------------------------------------------------

## 遥测

配置 用于 指标. (*.遥测.JSON)

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Identifier for this store |
| `acl` | [AclConfig](#aclconfig) 权限 用于 此 存储 |
| `metrics` | [MetricConfig](#metricconfig)`[]` Metrics to aggregate on the Horde server |
| `views` | [TelemetryViewConfig](#telemetryviewconfig)`[]` Configuration for telemetry views |
| `include` | [ConfigInclude](#configinclude)`[]` Includes for other configuration files |
| `macros` | [ConfigMacro](#configmacro)`[]` Macros within this configuration |

### AclConfig

参数 到 更新 一个 ACL

| 名称 | 说明 |
| --- | --- |
| `entries` | [AclEntryConfig](#aclentryconfig)`[]` Entries to replace the existing ACL |
| `profiles` | [AclProfileConfig](#aclprofileconfig)`[]` Defines profiles which allow grouping sets of actions into named collections |
| `inherit` | `boolean` Whether to inherit permissions from the parent ACL |
| `exceptions` | `string[]` List of exceptions to the inherited setting |

### AclEntryConfig

单独 条目 在 一个 ACL

| 名称 | 说明 |
| --- | --- |
| `claim` | [AclClaimConfig](#aclclaimconfig) 名称 的 该 用户 或 组 |
| `actions` | `string[]` Array of actions to allow |
| `profiles` | `string[]` List of profiles to grant |

### AclClaimConfig

新增 声明 到 创建

| 名称 | 说明 |
| --- | --- |
| `type` | `string` The claim type |
| `value` | `string` The claim value |

### AclProfileConfig

配置 用于 一个 ACL 分析. 此 defines a 预设 组 的 动作 其 可以 是 给定 到 a 用户 通过 一个 ACL 条目.

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Identifier for this profile |
| `actions` | `string[]` Actions to include |
| `excludeActions` | `string[]` Actions to exclude from the inherited actions |
| `extends` | `string[]` Other profiles to extend from |

### MetricConfig

Configures a 指标 到 聚合 在 该 服务器

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Identifier for this metric |
| `filter` | `string` Filter expression to evaluate to determine which events to include. This query is evaluated against an array. |
| `property` | `string` Property to aggregate |
| `groupBy` | `string` Property to group by. Specified as a comma-separated list of JSON path expressions. |
| `function` | [AggregationFunction](#aggregationfunction-enum) 如何 到 聚合 样本 用于 此 指标 |
| `percentile` | `integer` For the percentile function, specifies the percentile to measure |
| `interval` | `string` Interval for each metric. Supports times such as "2d", "1h", "1h30m", "20s". |

### AggregationFunction (Enum)

方法 用于 aggregating 样本 到 a 指标

| 名称 | 说明 |
| --- | --- |
| `Count` | 数量 该 数量 的 匹配 元素 |
| `Min` | 采用 该 最小 值 的 所有 样本 |
| `Max` | 采用 该 最大 值 的 所有 样本 |
| `Sum` | Sum 所有 该 报告 值 |
| `Average` | Average 所有 该 样本 |
| `Percentile` | Estimates 该 值 在 a 某些 百分位 |

### TelemetryViewConfig

A 遥测 视图 的 相关 指标, divided 到 categofies

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Identifier for the view |
| `name` | `string` The name of the view |
| `telemetryStoreId` | `string` The telemetry store this view uses |
| `variables` | [TelemetryVariableConfig](#telemetryvariableconfig)`[]` The variables used to filter the view data |
| `categories` | [TelemetryCategoryConfig](#telemetrycategoryconfig)`[]` The categories contained within the view |

### TelemetryVariableConfig

A 遥测 视图 变量 使用 用于 filtering 该 charting 数据

| 名称 | 说明 |
| --- | --- |
| `name` | `string` The name of the variable for display purposes |
| `group` | `string` The associated data group attached to the variable |
| `defaults` | `string[]` The default values to select |

### TelemetryCategoryConfig

A 图表 categody, 将 是 显示 在 该 dashbord 下方 一个 关联 pivot

| 名称 | 说明 |
| --- | --- |
| `name` | `string` The name of the category |
| `charts` | [TelemetryChartConfig](#telemetrychartconfig)`[]` The charts contained within the category |

### TelemetryChartConfig

遥测 图表 configuraton

| 名称 | 说明 |
| --- | --- |
| `name` | `string` The name of the chart, will be displayed on the dashboard |
| `display` | [TelemetryMetricUnitType](#telemetrymetricunittype-enum) 该 单位 到 显示 |
| `graph` | [TelemetryMetricGraphType](#telemetrymetricgraphtype-enum) 该 图表 类型 |
| `metrics` | [TelemetryChartMetricConfig](#telemetrychartmetricconfig)`[]` List of configured metrics |
| `min` | `integer` The min unit value for clamping chart |
| `max` | `integer` The max unit value for clamping chart |

### TelemetryMetricUnitType (Enum)

该 units 使用 到 存在 该 遥测

| 名称 | 说明 |
| --- | --- |
| `Time` | 时间 持续时间 |
| `Ratio` | Ratio 0-100% |
| `Value` | Artbitrary numeric 值 |

### TelemetryMetricGraphType (Enum)

该 类型 的

| 名称 | 说明 |
| --- | --- |
| `Line` | A 行 图表 |
| `Indicator` | 键 性能 indicator (KPI) 图表 使用 thrasholds |

### TelemetryChartMetricConfig

指标 附加 到 a 遥测 图表

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Associated metric id |
| `threshold` | `integer` The threshold for KPI values |
| `alias` | `string` The metric alias for display purposes |

### ConfigInclude

Directive 到 合并 配置 数据 从 另一个 源

| 名称 | 说明 |
| --- | --- |
| `path` | `string` Path to the config data to be included. May be relative to the including file's location. |

### ConfigMacro

Declares a 配置 宏

| 名称 | 说明 |
| --- | --- |
| `name` | `string` Name of the macro property |
| `value` | `string` Value for the macro property |

