# Horde Settings

---
title: "Horde Settings"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-settings-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde", "Horde部署", "Horde Settings"]
---

# Horde Settings

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde / Horde部署 / Horde Settings

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-settings-for-unreal-engine

## 服务器设置

### 服务器.JSON

All Horde-specific settings are stored in a root object called `Horde`. Other .NET functionality may be configured using properties in the root of this file.

| 名称 | 说明 |
| --- | --- |
| `runModes` | [RunMode](#runmode-enum)`[]` Modes that the server should run in. Runmodes can be used in a multi-server deployment to limit the operations that a particular instance will try to perform. |
| `dataDir` | `string` Override the data directory used by Horde. Defaults to C:\\ProgramData\\HordeServer on Windows, {AppDir}/Data on other platforms. |
| `installed` | `boolean` Whether the server is running in 'installed' mode. In this mode, on Windows, the default data directory will use the common application data folder (C:\\ProgramData\\Epic\\Horde), and configuration data will be read from here and the registry. This setting is overridden to false for local builds from appsettings.Local.json. |
| `httpPort` | `integer` Main port for serving HTTP. |
| `httpsPort` | `integer` Port for serving HTTP with TLS enabled. Disabled by default. |
| `http2Port` | `integer` Dedicated port for serving only HTTP/2. |
| `mongoConnectionString` | `string` Connection string for the Mongo database |
| `databaseConnectionString` | `string` MongoDB connection string |
| `mongoDatabaseName` | `string` MongoDB database name |
| `databaseName` | `string` |
| `mongoPublicCertificate` | `string` Optional certificate to trust in order to access the database (eg. AWS public cert for TLS) |
| `databasePublicCert` | `string` |
| `mongoReadOnlyMode` | `boolean` Access the database in read-only mode (avoids creating indices or updating content) Useful for debugging a local instance of HordeServer against a production database. |
| `databaseReadOnlyMode` | `boolean` |
| `shutdownMemoryThreshold` | `integer` Shutdown the current server process if memory usage reaches this threshold (specified in MB) Usually set to 80-90% of available memory to avoid CLR heap using all of it. If a memory leak was to occur, it's usually better to restart the process rather than to let the GC work harder and harder trying to recoup memory. Should only be used when multiple server processes are running behind a load balancer and one can be safely restarted automatically by the underlying process handler (Docker, Kubernetes, AWS ECS, Supervisor etc). The shutdown behaves similar to receiving a SIGTERM and will wait for outstanding requests to finish. |
| `serverPrivateCert` | `string` Optional PFX certificate to use for encrypting agent SSL traffic. This can be a self-signed certificate, as long as it's trusted by agents. |
| `authMethod` | [AuthMethod](#authmethod-enum) 类型 的 认证 (e.g anonymous, OIDC, 内置 Horde 账号) 如果 "Horde" 认证 模式 是 使用, 是 确保 到 configure "ServerUrl" 作为 良好. |
| `oidcProfileName` | `string` Optional profile name to report through the /api/v1/server/auth endpoint. Allows sharing auth tokens between providers configured through the same profile name in OidcToken.exe config files. |
| `oidcAuthority` | `string` OpenID Connect (OIDC) authority URL (required when OIDC is enabled) |
| `oidcAudience` | `string` Audience for validating externally issued tokens (required when OIDC is enabled) |
| `oidcClientId` | `string` Client ID for the OIDC authority (required when OIDC is enabled) |
| `oidcClientSecret` | `string` Client secret for the OIDC authority |
| `oidcSigninRedirect` | `string` Optional redirect url provided to OIDC login |
| `oidcLocalRedirectUrls` | `string[]` Optional redirect url provided to OIDC login for external tools (typically to a local server) Default value is the local web server started during signin by EpicGames.OIDC library |
| `oidcDebugMode` | `boolean` Debug mode for OIDC which logs reasons for why JWT tokens fail to authenticate Also turns off HTTPS requirement for OIDC metadata fetching. NOT FOR PRODUCTION USE! |
| `oidcRequestedScopes` | `string[]` OpenID Connect scopes to request when signing in |
| `oidcClaimNameMapping` | `string[]` List of fields in /userinfo endpoint to try map to the standard name claim (see System.Security.Claims.ClaimTypes.Name) |
| `oidcClaimEmailMapping` | `string[]` List of fields in /userinfo endpoint to try map to the standard email claim (see System.Security.Claims.ClaimTypes.Email) |
| `oidcClaimHordeUserMapping` | `string[]` List of fields in /userinfo endpoint to try map to the Horde user claim (see HordeClaimTypes.User) |
| `oidcClaimHordePerforceUserMapping` | `string[]` List of fields in /userinfo endpoint to try map to the Horde Perforce user claim (see HordeClaimTypes.PerforceUser) |
| `serverUrl` | `string` Base URL this Horde server is accessible from For example https://horde.mystudio.com If not set, a default is used based on current hostname. In more advanced setups where a reverse proxy is present in front of Horde, this must manually be set. |
| `jwtIssuer` | `string` Name of the issuer in bearer tokens from the server |
| `jwtExpiryTimeHours` | `integer` Length of time before JWT tokens expire, in hours |
| `adminClaimType` | `string` The claim type for administrators |
| `adminClaimValue` | `string` Value of the claim type for administrators |
| `corsEnabled` | `boolean` Whether to enable Cors, generally for development purposes |
| `corsOrigin` | `string` Allowed Cors origin |
| `enableDebugEndpoints` | `boolean` Whether to enable debug/administrative REST API endpoints |
| `enableNewAgentsByDefault` | `boolean` Whether to automatically enable new agents by default. If false, new agents must manually be enabled before they can take on work. |
| `schedulePollingInterval` | `string` Interval between rebuilding the schedule queue with a DB query. |
| `noResourceBackOffTime` | `string` Interval between polling for new jobs |
| `initiateJobBackOffTime` | `string` Interval between attempting to assign agents to take on jobs |
| `unknownErrorBackOffTime` | `string` Interval between scheduling jobs when an unknown error occurs |
| `redisConnectionString` | `string` Config for connecting to Redis server(s). Setting it to null will disable Redis use and connection See format at https://stackexchange.github.io/StackExchange.Redis/Configuration.html |
| `redisConnectionConfig` | `string` |
| `redisReadOnlyMode` | `boolean` Whether to disable writes to Redis. |
| `logServiceWriteCacheType` | `string` Overridden settings for storage backends. Useful for running against a production server with custom backends. |
| `logJsonToStdOut` | `boolean` Whether to log json to stdout |
| `logSessionRequests` | `boolean` Whether to log requests to the UpdateSession and QueryServerState RPC endpoints |
| `scheduleTimeZone` | `string` Timezone for evaluating schedules |
| `dashboardUrl` | `string` The URl to use for generating links back to the dashboard. |
| `helpEmailAddress` | `string` Help email address that users can contact with issues |
| `helpSlackChannel` | `string` Help slack channel that users can use for issues |
| `globalThreadPoolMinSize` | `integer` Set the minimum size of the global thread pool This value has been found in need of tweaking to avoid timeouts with the Redis client during bursts of traffic. Default is 16 for .NET Core CLR. The correct value is dependent on the traffic the Horde Server is receiving. For Epic's internal deployment, this is set to 40. |
| `withDatadog` | `boolean` Whether to enable Datadog integration for tracing |
| `configPath` | `string` Path to the root config file. Relative to the server.json file by default. |
| `forceConfigUpdateOnStartup` | `boolean` Forces configuration data to be read and updated as part of appplication startup, rather than on a schedule. Useful when running locally. |
| `openBrowser` | `boolean` Whether to open a browser on startup |
| `featureFlags` | [FeatureFlagSettings](#featureflagsettings) Experimental 功能 到 启用 在 该 服务器. |
| `openTelemetry` | [OpenTelemetrySettings](#opentelemetrysettings) 选项 用于 OpenTelemetry |
| `plugins` | [ServerPluginsConfig](#serverpluginsconfig) 配置 用于 插件 |

#### RunMode (Enum)

类型 的 运行 模式 此 流程 应 使用. 每个 carry 不同 类型 的 工作负载. 更多 比 一个 模式 可以 是 激活. 但是 不 所有 模式 为 不 guaranteed 到 是 compatible 使用 每个 其他 和 将 raise 一个 错误 如果 组合 在 例如 a 方式.

| 名称 | 说明 |
| --- | --- |
| `None` | 默认值 no-op 值 (ASP.NET 配置 将 默认 到 此 用于 enums 该 cannot 是 parsed) |
| `Server` | 处理 和 响应 到 传入 外部 请求, 例如 作为 HTTP REST 和 gRPC 调用. 这些 请求 为 时间-sensitive 和 短-存活, typically less 比 5 secs. 如果 流程 处理 请求 为 unavailable, 它 将 是 非常 可见 用于 用户. |
| `Worker` | 运行 non-请求 facing 工作负载. 例如 作为 后台 services, 处理 queues, 运行 工作 基于 在 timers 等. 短 periods 的 停机时间 或 高 CPU 用法 由于 到 bursts 为 精细 用于 此 模式. No 用户 请求 将 是 impacted 直接. 如果 自动-缩放 是 使用, a much 更多 aggressive 策略 可以 是 应用 (tighter 流程 packing, higher avg CPU 用法). |

#### AuthMethod (Enum)

认证 方法 使用 用于 日志记录 用户 在

| 名称 | 说明 |
| --- | --- |
| `Anonymous` | No 认证 启用. *仅* 用于 demo 和 测试 用途. |
| `Okta` | OpenID 连接 认证, tailored 用于 Okta |
| `OpenIdConnect` | Generic OpenID 连接 认证, recommended 用于 多数 |
| `Horde` | Authenticate 使用 用户名 和 密码 凭据 存储 在 Horde OpenID 连接 (OIDC) 是 第一个 和 foremost recommended. 但是 如果 你 具有 a 小 安装 (less 比 ~10 用户) 或 lacking 一个 OIDC 提供者, 此 是 一个 选项. |

#### FeatureFlagSettings

Feature 标志 到 aid rollout 的 新增 功能. 一次 a feature 是 运行 在 它的 intended 状态 和 是 stable, 该 标志 应 是 已移除. A 名称 和 日期 的 当 该 标志 曾 创建 是 noted 下一个 到 它 到 帮助 encourage 此 行为. 尝试 having 它们 是 仅 a 标志, a boolean.

#### OpenTelemetrySettings

OpenTelemetry 配置 用于 集合 和 发送 的 traces 和 指标.

| 名称 | 说明 |
| --- | --- |
| `enabled` | `boolean` Whether OpenTelemetry exporting is enabled |
| `serviceName` | `string` Service name |
| `serviceNamespace` | `string` Service namespace |
| `serviceVersion` | `string` Service version |
| `enableDatadogCompatibility` | `boolean` Whether to enrich and format telemetry to fit presentation in Datadog |
| `attributes` | `string` `->` `string` Extra attributes to set |
| `enableConsoleExporter` | `boolean` Whether to enable the console exporter (for debugging purposes) |
| `protocolExporters` | `string` `->` [OpenTelemetryProtocolExporterSettings](#opentelemetryprotocolexportersettings) Protocol exporters (键 是 a 唯一 和 arbitrary 名称) |

#### OpenTelemetryProtocolExporterSettings

配置 用于 一个 OpenTelemetry 导出器

| 名称 | 说明 |
| --- | --- |
| `endpoint` | `string` Endpoint URL. Usually differs depending on protocol used. |
| `protocol` | `string` Protocol for the exporter ('grpc' or 'httpprotobuf') |

#### ServerPluginsConfig

| 名称 | 说明 |
| --- | --- |
| `compute` | [ComputeServerConfig](#computeserverconfig) 配置 用于 该 计算 插件 |
| `secrets` | [PluginServerConfig](#pluginserverconfig) 配置 用于 该 密钥 插件 |
| `analytics` | [AnalyticsServerConfig](#analyticsserverconfig) 配置 用于 该 分析 插件 |
| `build` | [BuildServerConfig](#buildserverconfig) 配置 用于 该 构建 插件 |
| `storage` | [StorageServerConfig](#storageserverconfig) 配置 用于 该 存储 插件 |
| `symbols` | [PluginServerConfig](#pluginserverconfig) 配置 用于 该 符号 插件 |
| `tools` | [ToolsServerConfig](#toolsserverconfig) 配置 用于 该 工具 插件 |
| `ddc` | [PluginServerConfig](#pluginserverconfig) 配置 用于 该 DDC 插件 |

#### ComputeServerConfig

Static 配置 用于 该 计算 插件

| 名称 | 说明 |
| --- | --- |
| `enableUpgradeTasks` | `boolean` Whether to enable the upgrade task source. |
| `withAws` | `boolean` Whether to enable Amazon Web Services (AWS) specific features |
| `awsRegions` | `string[]` List of AWS regions for Horde to be aware of (e.g. us-east-1 or eu-central-1) Right now, this is only used for replicating CloudWatch metrics to multiple regions |
| `awsAutoScalingQueueUrls` | `string[]` AWS SQS queue URLs where lifecycle events from EC2 auto-scaling are received |
| `fleetManagerV2` | [FleetManagerType](#fleetmanagertype-enum) 默认值 机群 管理器 到 使用 (当 不 指定 通过 池) |
| `fleetManagerV2Config` | `object` Config for the fleet manager (serialized JSON) |
| `autoEnrollAgents` | `boolean` Whether to automatically enroll agents in the farm |
| `defaultAgentPoolSizeStrategy` | [PoolSizeStrategy](#poolsizestrategy-enum) 默认值 代理 池 大小调整 策略 用于 池 该 doesn't 具有 一个 explicitly 已配置 |
| `agentPoolScaleOutCooldownSeconds` | `integer` Scale-out cooldown for auto-scaling agent pools (in seconds). Can be overridden by per-pool settings. |
| `agentPoolScaleInCooldownSeconds` | `integer` Scale-in cooldown for auto-scaling agent pools (in seconds). Can be overridden by per-pool settings. |
| `computeTunnelPort` | `integer` Port to listen on for tunneling compute sockets to agents |
| `computeTunnelAddress` | `string` What address (host:port) clients should connect to for compute socket tunneling Port may differ from if Horde server is behind a reverse proxy/firewall |
| `enabled` | `boolean` Whether the plugin should be enabled or not |

#### FleetManagerType (Enum)

可用 机群 管理器

| 名称 | 说明 |
| --- | --- |
| `Default` | 默认值 机群 管理器 |
| `NoOp` | No-op 机群 管理器. |
| `Aws` | 机群 管理器 用于 处理 AWS EC2 实例. 将 创建 和/或 终止 实例 从 临时. |
| `AwsReuse` | 机群 管理器 用于 处理 AWS EC2 实例. 将 开始 已经 现有 但是 停止 实例 到 复用 现有 EBS 磁盘. |
| `AwsRecycle` | 机群 管理器 用于 处理 AWS EC2 实例. 将 开始 已经 现有 但是 停止 实例 到 复用 现有 EBS 磁盘. |
| `AwsAsg` | 机群 管理器 用于 处理 AWS EC2 实例. 使用 一个 EC2 自动-缩放 组 用于 控制 该 数量 的 运行 实例. |

#### PoolSizeStrategy (Enum)

可用 池 大小调整 策略

| 名称 | 说明 |
| --- | --- |
| `LeaseUtilization` | 策略 基于 在 租约 利用率 |
| `JobQueue` | 策略 基于 在 大小 的 作业 构建 队列 |
| `NoOp` | No-op 策略 使用 作为 回退/默认 行为 |
| `ComputeQueueAwsMetric` | A no-op 策略 该 报告 指标 到 让 一个 外部 AWS 自动-缩放 策略 缩放 该 机群 |
| `LeaseUtilizationAwsMetric` | A no-op 策略 该 报告 指标 到 让 一个 外部 AWS 自动-缩放 策略 缩放 该 机群 |

#### PluginServerConfig

基础 类 用于 插件 服务器 配置 对象 |

| 名称 | 说明 |
| --- | --- |
| `enabled` | `boolean` Whether the plugin should be enabled or not |

#### AnalyticsServerConfig

服务器 配置 用于 该 分析 系统

| 名称 | 说明 |
| --- | --- |
| `sinks` | [TelemetrySinkConfig](#telemetrysinkconfig) 设置 用于 该 various 遥测 sinks |
| `enabled` | `boolean` Whether the plugin should be enabled or not |

#### TelemetrySinkConfig

遥测 sinks

| 名称 | 说明 |
| --- | --- |
| `epic` | [EpicTelemetryConfig](#epictelemetryconfig) 设置 用于 该 Epic 遥测 接收器 |
| `mongo` | [MongoTelemetryConfig](#mongotelemetryconfig) 设置 用于 该 MongoDB 遥测 接收器 |

#### EpicTelemetryConfig

配置 用于 该 遥测 接收器

| 名称 | 说明 |
| --- | --- |
| `url` | `string` Base URL for the telemetry server |
| `appId` | `string` Application name to send in the event messages |
| `enabled` | `boolean` Whether to enable this sink |

#### MongoTelemetryConfig

配置 用于 该 遥测 接收器

| 名称 | 说明 |
| --- | --- |
| `retainDays` | `number` Number of days worth of telmetry events to keep |
| `enabled` | `boolean` Whether to enable this sink |

#### BuildServerConfig

Static 配置 用于 该 构建 插件

| 名称 | 说明 |
| --- | --- |
| `perforce` | [PerforceConnectionSettings](#perforceconnectionsettings)`[]` Perforce connections for use by the Horde server (not agents) |
| `useLocalPerforceEnv` | `boolean` Whether to use the local Perforce environment |
| `perforceConnectionPoolSize` | `integer` Number of pooled perforce connections to keep |
| `enableConformTasks` | `boolean` Whether to enable the conform task source. |
| `p4SwarmUrl` | `string` Url of P4 Swarm installation |
| `jiraUsername` | `string` The Jira service account user name |
| `jiraApiToken` | `string` The Jira service account API token |
| `jiraUrl` | `string` The Uri for the Jira installation |
| `sharedDeviceCheckoutDays` | `integer` The number of days shared device checkouts are held |
| `deviceProblemCooldownMinutes` | `integer` The number of cooldown minutes for device problems |
| `deviceReportChannel` | `string` Channel to send device reports to |
| `disableSchedules` | `boolean` Whether to run scheduled jobs. |
| `slackToken` | `string` Bot token for interacting with Slack (xoxb-*) |
| `slackSocketToken` | `string` Token for opening a socket to slack (xapp-*) |
| `slackAdminToken` | `string` Admin user token for Slack (xoxp-*). This is only required when using the admin endpoints to invite users. |
| `slackUsers` | `string` Filtered list of slack users to send notifications to. Should be Slack user ids, separated by commas. |
| `slackErrorPrefix` | `string` Prefix to use when reporting errors |
| `slackWarningPrefix` | `string` Prefix to use when reporting warnings |
| `configNotificationChannel` | `string` Channel for sending messages related to config update failures |
| `updateStreamsNotificationChannel` | `string` Channel to send stream notification update failures to |
| `jobNotificationChannel` | `string` Slack channel to send job related notifications to. Multiple channels can be specified, separated by ; |
| `agentNotificationChannel` | `string` Slack channel to send agent related notifications to. |
| `testDataRetainMonths` | `integer` The number of months to retain test data |
| `blockCacheDir` | `string` Directory to store the fine-grained block cache. This caches individual exports embedded in bundles. |
| `blockCacheSize` | `string` Maximum size of the block cache. Accepts standard binary suffixes. Currently only allocates in multiples of 1024mb. |
| `blockCacheSizeBytes` | `integer` Accessor for the block cache size in bytes |
| `commits` | [CommitSettings](#commitsettings) 选项 用于 该 提交 服务 |
| `enabled` | `boolean` Whether the plugin should be enabled or not |

#### PerforceConnectionSettings

Perforce 连接 信息 用于 使用 通过 该 Horde 服务器 (用于 reading 配置 文件, 等...)

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Identifier for this server |
| `serverAndPort` | `string` Server and port |
| `credentials` | [PerforceCredentials](#perforcecredentials) 凭据 用于 该 服务器 |

#### PerforceCredentials

凭据 用于 a Perforce 用户

| 名称 | 说明 |
| --- | --- |
| `userName` | `string` The username |
| `password` | `string` Password for the user |
| `ticket` | `string` Login ticket for the user (will be used instead of password if set) |

#### CommitSettings

选项 用于 该 提交 服务

| 名称 | 说明 |
| --- | --- |
| `replicateMetadata` | `boolean` Whether to mirror commit metadata to the database |
| `replicateContent` | `boolean` Whether to mirror commit data to storage |
| `bundle` | [BundleOptions](#bundleoptions) 选项 用于 如何 对象 为 packed 一起 |
| `chunking` | [ChunkingOptions](#chunkingoptions) 选项 用于 如何 对象 为 sliced |

#### BundleOptions

选项 用于 配置 a 包 serializer

| 名称 | 说明 |
| --- | --- |
| `maxVersion` | [BundleVersion](#bundleversion-enum) 最大 版本 数量 的 包 到 写入 |
| `maxBlobSize` | `integer` Maximum payload size fo a blob |
| `compressionFormat` | [BundleCompressionFormat](#bundlecompressionformat-enum) 压缩 格式 到 使用 |
| `minCompressionPacketSize` | `integer` Minimum size of a block to be compressed |
| `maxWriteQueueLength` | `integer` Maximum amount of data to store in memory. This includes any background writes as well as bundles being built. |

#### BundleVersion (Enum)

包 版本 数量

| 名称 | 说明 |
| --- | --- |
| `Initial` | 初始 版本 数量 |
| `ExportAliases` | 已添加 该 BundleExport.别名 属性 |
| `RemoveAliases` | 返回 输出 更改 到 包括 别名. 将 likely do 此 通过 一个 API 而是 比 baked 到 该 数据. |
| `InPlace` | 使用 数据 结构 其 支持 在-place reading 和 写入. |
| `ImportHashes` | 添加 导入 hashes 到 导入 节点 |
| `LatestV1` | 最后 版本 使用 该 V1 管线 |
| `PacketSequence` | 结构 包 作为 a 序列 的 自身-包含 packets (使用 V2 代码) |
| `Latest` | 该 当前 版本 数量 |
| `LatestV2` | 最后 版本 使用 该 V2 管线 |
| `LatestPlusOne` | 最后 项 在 该 enum. 使用 用于 |

#### BundleCompressionFormat (Enum)

表示 该 压缩 格式 在 该 包

| 名称 | 说明 |
| --- | --- |
| `None` | Packets 为 uncompressed |
| `LZ4` | LZ4 压缩 |
| `Gzip` | Gzip 压缩 |
| `Oodle` | Oodle 压缩 (Selkie) |
| `Brotli` | Brotli 压缩 |
| `Zstd` | ZStandard 压缩 |

#### ChunkingOptions

选项 用于 创建 文件 节点

| 名称 | 说明 |
| --- | --- |
| `leafOptions` | [LeafChunkedDataNodeOptions](#leafchunkeddatanodeoptions) 选项 用于 创建 leaf 节点 |
| `interiorOptions` | [InteriorChunkedDataNodeOptions](#interiorchunkeddatanodeoptions) 选项 用于 创建 内部 节点 |

#### LeafChunkedDataNodeOptions

选项 用于 创建 a 特定 类型 的 文件 节点

| 名称 | 说明 |
| --- | --- |
| `minSize` | `integer` Minimum chunk size |
| `maxSize` | `integer` Maximum chunk size. Chunks will be split on this boundary if another match is not found. |
| `targetSize` | `integer` Target chunk size for content-slicing |

#### InteriorChunkedDataNodeOptions

选项 用于 创建 内部 节点

| 名称 | 说明 |
| --- | --- |
| `minChildCount` | `integer` Minimum number of children in each node |
| `targetChildCount` | `integer` Target number of children in each node |
| `maxChildCount` | `integer` Maximum number of children in each node |
| `sliceThreshold` | `integer` Threshold hash value for splitting interior nodes |

#### StorageServerConfig

Static 设置 用于 该 存储 系统

| 名称 | 说明 |
| --- | --- |
| `bundleCacheDir` | `string` Directory to use for the coarse-grained backend cache. This caches full bundles downloaded from the upstream object store. |
| `bundleCacheSize` | `string` Maximum size of the storage cache on disk. Accepts standard binary suffixes (kb, mb, gb, tb, etc...) |
| `bundleCacheSizeBytes` | `integer` Accessor for the bundle cache size in bytes |
| `backends` | [BackendConfig](#backendconfig)`[]` Overridden settings for storage backends. Useful for running against a production server with custom backends. |
| `enabled` | `boolean` Whether the plugin should be enabled or not |

#### BackendConfig

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

#### StorageBackendType (Enum)

类型 的 存储 后端 到 使用

| 名称 | 说明 |
| --- | --- |
| `FileSystem` | 本地 文件系统 |
| `Aws` | AWS S3 |
| `Azure` | Azure Blob 存储 |
| `Gcs` | Google Cloud 存储 |
| `Memory` | 在-内存 仅 (用于 测试) |

#### AwsCredentialsType (Enum)

凭据 到 使用 用于 AWS

| 名称 | 说明 |
| --- | --- |
| `Default` | 使用 默认 凭据 从 该 AWS SDK |
| `Profile` | 读取 凭据 从 该 分析 在 该 AWS 配置 文件 |
| `AssumeRole` | 假定 a 特定 角色. 应 specify ARN 在 |
| `AssumeRoleWebIdentity` | 假定 a 特定 角色 使用 该 当前 环境 变量. |

#### ToolsServerConfig

服务器 配置 用于 捆绑 工具

| 名称 | 说明 |
| --- | --- |
| `bundledTools` | [BundledToolConfig](#bundledtoolconfig)`[]` Tools bundled along with the server. Data for each tool can be produced using the 'bundle create' command, and should be stored in the Tools directory. |
| `enabled` | `boolean` Whether the plugin should be enabled or not |

#### BundledToolConfig

配置 用于 a 工具 捆绑 alongsize 该 服务器

| 名称 | 说明 |
| --- | --- |
| `version` | `string` Version string for the current tool data |
| `refName` | `string` Ref name in the tools directory |
| `dataDir` | `string` Directory containing blob data for this tool. If empty, the tools/{id} folder next to the server will be used. |
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

#### AclConfig

参数 到 更新 一个 ACL

| 名称 | 说明 |
| --- | --- |
| `entries` | [AclEntryConfig](#aclentryconfig)`[]` Entries to replace the existing ACL |
| `profiles` | [AclProfileConfig](#aclprofileconfig)`[]` Defines profiles which allow grouping sets of actions into named collections |
| `inherit` | `boolean` Whether to inherit permissions from the parent ACL |
| `exceptions` | `string[]` List of exceptions to the inherited setting |

#### AclEntryConfig

单独 条目 在 一个 ACL

| 名称 | 说明 |
| --- | --- |
| `claim` | [AclClaimConfig](#aclclaimconfig) 名称 的 该 用户 或 组 |
| `actions` | `string[]` Array of actions to allow |
| `profiles` | `string[]` List of profiles to grant |

#### AclClaimConfig

新增 声明 到 创建

| 名称 | 说明 |
| --- | --- |
| `type` | `string` The claim type |
| `value` | `string` The claim value |

#### AclProfileConfig

配置 用于 一个 ACL 分析. 此 defines a 预设 组 的 动作 其 可以 是 给定 到 a 用户 通过 一个 ACL 条目.

| 名称 | 说明 |
| --- | --- |
| `id` | `string` Identifier for this profile |
| `actions` | `string[]` Actions to include |
| `excludeActions` | `string[]` Actions to exclude from the inherited actions |
| `extends` | `string[]` Other profiles to extend from |

## 代理 设置

### 代理.JSON (代理)

All Horde-specific settings are stored in a root object called `Horde`. Other .NET functionality may be configured using properties in the root of this file.

| 名称 | 说明 |
| --- | --- |
| `serverProfiles` | `string` `->` [ServerProfile](#serverprofile) 已知 服务器 到 连接 到 |
| `server` | `string` The default server, unless overridden from the command line |
| `name` | `string` Name of agent to report as when connecting to server. By default, the computer's hostname will be used. |
| `installed` | `boolean` Whether the server is running in 'installed' mode. In this mode, on Windows, the default data directory will use the common application data folder (C:\\ProgramData\\Epic\\Horde), and configuration data will be read from here and the registry. This setting is overridden to false for local builds from appsettings.Local.json. |
| `ephemeral` | `boolean` Whether agent should register as being ephemeral. Doing so will not persist any long-lived data on the server and once disconnected it's assumed to have been deleted permanently. Ideal for short-lived agents, such as spot instances on AWS EC2. |
| `workingDir` | [DirectoryReference](#directoryreference) Working 目录 用于 租约 和 作业 (i.e 位置 文件 从 Perforce 将 是 检查 输出) |
| `logsDir` | [DirectoryReference](#directoryreference) 目录 位置 代理 和 租约 记录 为 written |
| `shareMountingEnabled` | `boolean` Whether to mount the specified list of network shares |
| `shares` | [MountNetworkShare](#mountnetworkshare)`[]` List of network shares to mount |
| `wineExecutablePath` | `string` Path to Wine executable. If null, execution under Wine is disabled |
| `containerEngineExecutablePath` | `string` Path to container engine executable, such as /usr/bin/podman. If null, execution of compute workloads inside a container is disabled |
| `writeStepOutputToLogger` | `boolean` Whether to write step output to the logging device |
| `enableAwsEc2Support` | `boolean` Queries information about the current agent through the AWS EC2 interface |
| `useLocalStorageClient` | `boolean` Option to use a local storage client rather than connecting through the server. Primarily for convenience when debugging / iterating locally. |
| `computeIp` | `string` Incoming IP for listening for compute work. If not set, it will be automatically resolved. |
| `computePort` | `integer` Incoming port for listening for compute work. Needs to be tied with a lease. Set port to 0 to disable incoming compute requests. |
| `openTelemetry` | [OpenTelemetrySettings](#opentelemetrysettings) 选项 用于 OpenTelemetry |
| `enableTelemetry` | `boolean` Whether to send telemetry back to Horde server |
| `telemetryReportInterval` | `integer` How often to report telemetry events to server in milliseconds |
| `bundleCacheSize` | `integer` Maximum size of the bundle cache, in megabytes. |
| `cpuCount` | `integer` Maximum number of logical CPU cores workloads should use Currently this is only provided as a hint and requires leases to respect this value as it's set via an env variable (UE_HORDE_CPU_COUNT). |
| `cpuMultiplier` | `number` CPU core multiplier applied to CPU core count setting For example, 32 CPU cores and a multiplier of 0.5 results in max 16 CPU usage. |
| `properties` | `string` `->` `string` Key/value properties in addition to those set internally by the agent |

#### ServerProfile

信息 关于 a 服务器 到 使用

| 名称 | 说明 |
| --- | --- |
| `name` | `string` Name of this server profile |
| `environment` | `string` Name of the environment (currently just used for tracing) |
| `url` | `string` Url of the server |
| `token` | `string` Bearer token to use to initiate the connection |
| `thumbprint` | `string` Thumbprint of a certificate to trust. Allows using self-signed certs for the server. |
| `thumbprints` | `string[]` Thumbprints of certificates to trust. Allows using self-signed certs for the server. |

#### DirectoryReference

Representation 的 一个 absolute 目录 路径. 允许 快速 hashing 和 comparisons.

| 名称 | 说明 |
| --- | --- |
| `parentDirectory` | [DirectoryReference](#directoryreference) Gets 该 目录 包含 此 对象 |
| `fullName` | `string` The path to this object. Stored as an absolute path, with O/S preferred separator characters, and no trailing slash for directories. |

#### MountNetworkShare

Describes a 网络 share 到 挂载

| 名称 | 说明 |
| --- | --- |
| `mountPoint` | `string` Where the share should be mounted on the local machine. Must be a drive letter for Windows. |
| `remotePath` | `string` Path to the remote resource |

#### OpenTelemetrySettings

OpenTelemetry 配置 用于 集合 和 发送 的 traces 和 指标.

| 名称 | 说明 |
| --- | --- |
| `enabled` | `boolean` Whether OpenTelemetry exporting is enabled |
| `serviceName` | `string` Service name |
| `serviceNamespace` | `string` Service namespace |
| `serviceVersion` | `string` Service version |
| `enableDatadogCompatibility` | `boolean` Whether to enrich and format telemetry to fit presentation in Datadog |
| `attributes` | `string` `->` `string` Extra attributes to set |
| `enableConsoleExporter` | `boolean` Whether to enable the console exporter (for debugging purposes) |
| `protocolExporters` | `string` `->` [OpenTelemetryProtocolExporterSettings](#opentelemetryprotocolexportersettings) Protocol exporters (键 是 a 唯一 和 arbitrary 名称) |

#### OpenTelemetryProtocolExporterSettings

配置 用于 一个 OpenTelemetry 导出器

| 名称 | 说明 |
| --- | --- |
| `endpoint` | `string` Endpoint URL. Usually differs depending on protocol used. |
| `protocol` | `string` Protocol for the exporter ('grpc' or 'httpprotobuf') |

