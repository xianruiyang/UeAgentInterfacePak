---
title: "控制台命令"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/console-commands-for-network-debugging-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "联网和多人游戏", "网络调试", "控制台命令"]
---

# 控制台命令

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 联网和多人游戏 / 网络调试 / 控制台命令

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/console-commands-for-network-debugging-in-unreal-engine

# 网络调试控制台命令

**虚幻引擎（UE）** 包括数个[控制台变量](../../../../testing-and-optimizing-content/console-variables-editor/index.md)和[命令](../../../../cpp-programming/programming-in-the-unreal-engine-architecture/console-variables-cplusplus/index.md)，这对网络游戏的调试很有用。

## 网络连接

### 控制台变量

网络连接控制台变量可自定义虚幻引擎的网络连接和复制系统的行为。网络连接控制台变量以 `net.` （网络连接）或 `p.net.` （联网的物理效果）前缀开头。

| **变量** | **说明** | **参数** |
| --- | --- | --- |
| `net.ActorChannelPool` | 启用后，Actor通道会集中到一起，可节省内存和对象创建开销。 | 0：禁用，1：启用（默认值） |
| `net.AllowAsyncLoading` | 允许异步加载数据包中引用的未加载资产。禁用后客户端会卡顿并立即加载资产。启用后数据包会延迟，同时异步加载资产。 可以启用 `net.DelayUnmappedRPCs` 以延迟依赖异步加载资产的RPC。 | 0：禁用（默认值），1：启用 |
| `net.AllowClientRemapCacheObject` | 启用后允许客户端重新映射只读缓存对象并保留相同的NetGUID。 | false：禁用（默认值），true：启用 |
| `net.AllowEncryption` | 如果为1，引擎会尝试加载加密数据包处理程序组件，并基于 `?EncryptionToken` URL命令行选项和回调（如果非空）填写 `NMT_Hello` 消息的加密令牌参数。如果为2，必须填写加密令牌（这在服务器端强制实施）。 | 0：禁用，1：启用（默认值），2：必需 |
| `net.AllowPIESeamlessTravel` | 启用后允许在单进程"在编辑器中运行（PIE）"中无缝漫游。 | false：禁用（默认值），true：启用 |
| `net.AllowReliableMulticastToNonRelevantChannels` | 启用后，允许将可靠服务器组播发送到非相关Actor，只要存在现有Actor通道即可。 | 0：禁用，1：启用 |
| `net.AllowRPCDoSDetectionBlocking` | 重载是否启用RPC DoS检测RPC阻止。 | 0：禁用，1：启用 |
| `net.AllowRPCDosDetectionKicking` | 调试是否启用RPC DoS检测RPC踢出。 | 0：禁用，1：启用 |
| `net.AlwaysUpdateGuidReferenceMapForNetSerializeObjectStruct` | 启用后，GuidReferenceMap中带对象属性的、用于NetSerialize结构体属性的条目将总是更新，而不仅仅是在Guid更改或变为null时更新。在映射了结构体中未映射的Actor引用时，这应该会防止应用旧属性数据的问题。 此命令还需要 `net.TrackNetSerializeObjectReferences 1` 。 | false：禁用，true：启用 |
| `net.BitReader.EnsureOnOverflow` | 启用后，可确保在BitReader溢出时 `BitReader.LogFatalOnOverflow` 优先。 | 0：禁用，1：启用 |
| `net.BlockSend` | 启用后可阻止 `NetConnection` 上的数据包发送。 | 0：禁用（默认值），1：启用 |
| `net.CheckNoLoadPackages` | 启用后，检查 `GetObjectFromNetGUID` 中的无加载标记，然后再在未标记为 `IsFullyLoaded` 的包上强制执行同步加载。 | false：禁用，true：启用 |
| `net.CheckPushBPRepIndexAgainstName` | 启用后，验证传递到 `MarkPropertyDirtyFromRepIndex` 的蓝图生成值是否匹配实际属性数据。 | false：禁用，true：启用 |
| `net.ClientToServerUnreliableRPCQueueSize` | 从客户端发送到服务器的不可靠RPC的最大排队数。如果有更多RPC排队，则会丢弃更旧的RPC。 | `<VALUE>`：RPC数量（默认为16） |
| `net.CloseTimingDebug` | 在连接关闭时记录最后一次数据包发送/接收和TickFlush/TickDispatch时间，用于调试阻止的发送/接收路径。 | 0：禁用（默认值），1：启用 |
| `net.ContextDebug` | 用于在复制期间设置上下文字符串的调试选项。 | 0：禁用（默认值），1：启用 |
| `net.ControlChannelDestructionInfo` | 启用后，通过控制通道发送销毁信息更新，而不是通过创建新Actor通道发送。 | 0：使用Actor通道（默认值），1：使用控制通道 |
| `net.CurrentHandshakeVersion` | 当前受支持的无状态握手协议版本。 | `<INTEGER>`：版本（默认为4） |
| `net.DebugAppendResolverAddress` | 设置此项后，所有IP地址解析方法会将此控制台变量的值添加到结果列表。这将允许在多个地址之间测试解析功能，最终目标是获得成功结果。 | `<STRING>`：地址（默认为""） |
| `net.DebugDraw` | 绘制网络休眠和相关性的调试信息。 | 0：禁用（默认值），1：启用 |
| `net.DebugDrawCullDistance` | `net.DebugDraw` 的剔除距离（以世界单位计）。绘制其休眠状态时，Actor可以距离本地视图的最大世界单位。零将禁用剔除。 | `<FLOAT>`：距离（默认为0.0） |
| `net.DebugDualIPs` | 启用后，复制收到的每个数据包，然后使用新的确定性IP处理，以模拟从双IP接收客户端数据包。 | 0：禁用（默认值），1：启用 |
| `net.DebugInitialConnect` | 启用后，定期记录客户端的套接字级别发送统计数据，直至成功收到数据包以验证连接。 | 0：禁用，1：启用（默认值） |
| `net.DebugInitialConnectLogFrequency` | 初始连接调试日志记录之间间隔的时间（以秒为单位）。 | `<FLOAT>`：秒（默认为10.0） |
| `net.DelayUnmappedRPCs` | 启用后，延迟使用未映射的对象引用接收的RPC，直至接收或加载它们。禁用后，RPC使用null参数立即执行。这可以与 `net.AllowAsyncLoading` 一起使用，避免异步加载期间出现null资产参数。 | 0：禁用（默认值），1：启用 |
| `net.DelinquencyNumberOfTopOffendersToTrack` | PackageMap和GuidCache针对排队的Actor和异步加载所跟踪的"最差情况"数量。`net.TrackAsyncLoadingGUIDThreshold` 和 `net.TrackQueuedActorThreshold` 仍规定是否跟踪其中任何项目。 | `<INTEGER>`：数字（默认为10） |
| `net.DeltaInitialFastArrayElements` | 启用后，发送初始快速数组元素的增量结构体变更列表。 | false：禁用（默认值），true：启用 |
| `net.DisableBandwithThrottling` | 启用后，强制IsNetReady总是返回true。在发布版本中不可用。 | 0：禁用（默认值），1：启用 |
| `net.DisableIPv6` | 启用后，IPv6不会解析，并且会尽可能避免使用它。 | 0：禁用，1：启用（默认值） |
| `net.DisableRemapScriptActors` | 启用后，禁止针对网络连接重新映射编译的脚本Actor的名称。 | 0：禁用（默认值），1：启用 |
| `net.DiscardTornOffActorRPCs` | 启用后，在Actor已剥离时废弃RPC。 | false：禁用，true：启用（默认值） |
| `net.DoHandshakeVersionFallback` | 启用后，在客户端失败时执行随机回退到握手协议之前的版本。 | 0：禁用（默认值），1：启用 |
| `net.DoPacketOrderCorrection` | 启用后，尝试通过缓存数据包并等待缺失序列来修复"混乱"的数据包序列。 | 0：禁用，1：启用（默认值） |
| `net.DoPropertyChecksum` | 如果启用且定义了 `ENABLE_PROPERTY_CHECKSHUMS` ，复制的属性的校验和会在客户端和服务器上比较。 | 0：禁用（默认值），1：启用 |
| `net.DormancyEnable` | 启用后，使用网络休眠系统减少更新不频繁的Actor的CPU和带宽开销。 | 0：禁用，1：启用（默认值） |
| `net.DormancyHysteresis` | 系统在允许通道完全休眠之前等待的时间（以秒为单位）。这可在对象比正常情况更频繁地切换休眠与苏醒时防止抖动。 | `<FLOAT>`：秒（默认为0.0） |
| `net.DormancyValidate` | 启用后（值1或2），验证休眠Actor在处于休眠状态时不会更改状态（仅在服务器上）。 | 0：禁用（默认值），1：在苏醒时验证，2：每次网络更新时验证 |
| `net.EnableCongestionControl` | 启用后，使用拥塞控制模块。 | 0：禁用（默认值），1：启用 |
| `net.EnableDetailedScopeCounters` | 启用后，使用详细网络连接范围循环计数器。这些计数器往往有很多，可能会对性能带来负面影响。 | false：禁用，true：启用（默认值） |
| `net.EnableNetInitialSubObjects` | 启用后，在新的子对象上将 `bNetInitial` 设置为true，确保所有复制的属性都得到复制。 | false：禁用，true：启用（默认值） |
| `net.FilterGuidRemapping` | 启用后，从未映射的GUID列表删除销毁的父GUID。 | 0：禁用，1：启用（默认值） |
| `net.ForceNetFlush` | 启用后，在写入后立即清空发送缓冲区。这有助于跟踪数据包写入。 可能不稳定。 | 0：禁用（默认值），1：启用 |
| `net.HandshakeEnforceNetworkCLVersion` | 启用后，无状态握手会强制实施网络CL版本，而不是更高级别的网络代码。 | 0：禁用（默认值），1：启用 |
| `net.HandshakeResendInterval` | 在我们未收到响应时，重新发送握手数据包的延时。 | `<FLOAT>`：时间（默认为1.0） |
| `net.IgnoreNetworkChecksumMismatch` | 启用后，将忽略包映射对象上的完整性校验和。这可能导致数据不同步的问题。 | 0：禁用（默认值），1：启用 |
| `net.InstantReplayProcessQueuedBunchesMillisecondLimit` | 在即时重播期间处理排队的数据束的时间阈值。如果在一帧中花费的时间超过这个值，将等待下一帧继续处理排队的数据束。如不想限制时间，请将其设置为0。 | `<INTEGER>`：毫秒（默认为8） |
| `net.IpConnectionDisableResolution` | 启用后，所有未来IP连接都不使用解析方法。 | 0：禁用（默认值），1：启用 |
| `net.IpConnectionUseSendTasks` | 启用后，IP连接在任务图表中调用套接字的 `SendTo` 函数，以便可以通过游戏线程运行。 | 0：禁用（默认值），1：启用 |
| `net.IpNetDriverReceiveThreadPollTimeMS` | 如果启用 `net.IpNetDriverUseReceiveThread` ，则为在接收线程上作为 `FSocket::Wait` 超时值的毫秒数。负值意味着无限期等待。`FSocket::Shutdown` 会取消无限期等待。 | `<INTEGER>`：毫秒（默认为250） |
| `net.IpNetDriverReceiveThreadQueueMaxPackets` | 如果启用 `net.IpNetDriverUseReceiveThread` ，则为队列中可以等待的数据包的最大数量。收到的额外数据包会被丢弃。 | `<INTEGER>`：数据包（默认为1024） |
| `net.IpNetDriverUseReceiveThread` | 启用后，IP网络驱动程序会在单独线程（而不是游戏线程）上调用套接字的 `RecvFrom` 函数。 | 0：禁用（默认值），1：启用 |
| `net.IsPushModelEnabled` | 启用后，使用推送模型模式。推送模型网络连接模式允许游戏代码向网络连接系统通知更改而不是汇集。 | false：禁用（默认值），true：启用 |
| `net.LogPendingGuidsOnShutdown` | 启用后，在关闭时记录待处理的GUID。 | false：禁用（默认值），true：启用 |
| `net.LogSkippedRepNotifies` | 启用后，记录网络连接代码何时由于属性值未更改而跳过在客户端调用RepNotify。 | 0：禁用（默认值），1：启用 |
| `net.LogUnhandledFaults` | 未处理的网络故障的警告级别。 未处理的网络故障可能是有意为之，具体取决于实现。 | 0：禁用，1：启用（记录一次），2：启用（总是记录） |
| `net.MagicHeader` | 该字符串表示附加到游戏发送的每个数据包前面的二进制位。 最大长度为32位。 | `<STRING>`：位字符串（默认为""） |
| `net.MakeBpPropertiesPushModel` | 启用后，蓝图中声明的属性将强制使用推送模型模式。 | false：禁用，true：启用（默认值） |
| `net.MaxAggregateIPLogs` | 在完全禁用聚合预连接日志记录之前，此类日志记录中可包含的最大IP地址数。 最小值为1，最大值为128。 | `<INTEGER>`：IP数量（默认为16） |
| `net.MaxChannelSize` | 整个服务器中允许的网络通道的最大数量。 如为非正数，将使用连接 `DefaultMaxChannelSize` 。 | `<INTEGER>`：通道（默认值：0） |
| `net.MaxClientGuidRemaps` | 每次更新的未映射网络GUID的最大客户端解析数。 | `<INTEGER>`：解析数量（默认值：100） |
| `net.MaxConnectionsToTickPerServerFrame` | 每次服务器更新会将更改复制到的通道的最大数量。 非正数不起作用。 | `<INTEGER>`：通道数量（默认值：0） |
| `net.MaxConstructedPartialBunchSizeBytes` | 部分数据束的最大允许大小。 | `<INTEGER>`：数据束大小（默认值：65536） |
| `net.MaxIPHitLogs` | 在聚合更多日志之前，要单独记录特定IP预连接的最大次数。 最低值为0，最大值为 `int32` 的最大值。 | `<INTEGER>`：日志数量（默认值：4） |
| `net.MaxNetStringSize` | 网络代码发送/接收的字符串的最大大小（以字节为单位）。 | `<INTEGER>`：字节数量（默认值：16777216） |
| `net.MaxNumberOfAllowedTArrayChangesPerUpdate` | 每次更新允许的 `TArray` 更改的最大数量。 | `<INTEGER>`：更改数量（默认值：2048） |
| `net.MaxNumberOfAllowedTArrayDeletionsPerUpdate` | 每次更新允许的 `TArray` 删除的数量上限。 | `<INTEGER>`：删除数量（默认值：2048） |
| `net.MaxPlayersOverride` | 玩家数量上限。可重载标准玩家人数上限。适合用于测试服务器满员的情况。 | `<INTEGER>`：玩家数量（默认值：0） |
| `net.MaxRPCPerNetUpdate` | 每次网络更新允许的不可靠组播RPC调用的最大数量，额外调用将被丢弃。 | `<INTEGER>`：RPC数量（默认值：2） |
| `net.MaxSerializedNetExportGroups` | 我们预期在一个数据束中接收的网络导出组的最大数量。 | `<INTEGER>`：组数量（默认值：65536） |
| `net.MaxSerializedNetExportsPerGroup` | 我们预期在一个数据束中接收的每个网络导出组内网络导出的最大数量。 | `<INTEGER>`：导出数量（默认值：131072） |
| `net.MaxSerializedNetGuids` | 我们预期在一个数据束中接收的网络GUID的最大数量。 | `<INTEGER>`：GUID数量（默认值：2048） |
| `net.MaxSerializedReplayNetGuids` | 我们预期在重播导出数据中接收的网络GUID的最大数量。 | `<INTEGER>`：GUID数量（默认值：32768） |
| `net.MaxSimultaneousObjectsWithRPCs` | 可以同时具有未发送的RPC的对象的最大数量。 | `<INTEGER>`：对象数量（默认值：4096） |
| `net.MinHandshakeVersion` | 最低无状态握手协议版本。 请参阅 `StatelessConnectHandlerComponent.h` ，详细了解 `EHandshakeVersion` 。 | `<INTEGER>`：握手版本（默认值：4） |
| `net.Montage.Debug` | 打印关于动画蒙太奇的复制信息。 | 0：无打印（默认值），1：在客户端打印 |
| `net.NetFaultRecoveryLogQuotaChecks` | 启用后，针对配额检查进行调试日志记录。用于调试与 `RegisterCounterCategory` 一起使用的新网络故障。 | false：禁用，true：启用 |
| `net.NetGuidCacheHistoryEnabled` | 启用后，允许记录 `NetGUIDCache` 历史记录。 这可能会消耗大量内存，而且只有在销毁缓存之后才会释放内存。 | 0：禁用，1：启用 |
| `net.NetPingDebugDump` | 启用后，每5秒将 `NetPing` ping值转储到日志。 | 0：禁用，1：启用 |
| `net.NetPingEnabled` | 启用或禁用用于集中ping跟踪和ICMP/UDP ping的 `NetPing` ping处理接口。 | 0：禁用，1：对客户端启用，2：对服务器和客户端启用，3：仅对服务器启用 |
| `net.NetPingICMPInterval` | 指定执行ICMP ping的间隔（以秒为单位）。 | `<INTEGER>`：时间（默认值：5） |
| `net.NetPingTimeoutDisableThreshold` | 故障/超时率达到100%时，在放弃并禁用ping之前要发送ICMP/UDP ping的次数。 | `<INTEGER>`：尝试次数（默认值：15） |
| `net.NetPingTypes` | 要启用的 `EPingType` ping的逗号分隔列表，以及（可选）要应用于ping的 `EPingAverageType` 平均值。 其示例用法如下：`net.NetPingTypes="RoundTrip=None,RoundTripExclFrame=PlayerStateAvg,ICMP=MovingAverage"` 。请参阅 `NetPing.h` ，详细了解 `EPingType` 和 `EPingAverageType` 。 | 逗号分隔列表 |
| `net.NetPingUDPInterval` | 指定执行UDP ping的间隔（以秒为单位）。 | `<INTEGER>`：时间（默认值：5） |
| `net.NetPingUDPPort` | 设置用于使用ping命令连通 `UDPQoS` ping类型的端口。 | `<INTEGER>`：端口号（默认值：22222） |
| `net.NetServerMoveTimestampExpiredWarningThreshold` | 当客户端动作过期的时间超过服务器上的对应时间阈值时， `ServerMove` 发出警告的容差。 | `<FLOAT>`：时间（默认值：1） |
| `net.OodleClientEnableMode` | 何时在客户端上启用压缩。 此设置将重载 `ClientEnableMode` 引擎配置设置。 | `<STRING>`：模式（默认值：""） |
| `net.OodleMinSizeForCompression` | 传出数据包必需达到的最低大小，达到此值才会考虑进行压缩。 这不计入在Oodle之后处理数据包的处理程序组件的开销。 | `<INTEGER>`：大小（默认值：0） |
| `net.OodleNetwork.TimeGuardLimit` | 设置 `OodleNetworkHandlerComponent` 时间确保日志的最大数量。 | `<INTEGER>`：日志数量（默认值：20） |
| `net.OodleNetwork.TimeGuardThresholdMS` | `OodleNetworkHandlerComponent` 时间确保的阈值（以毫秒为单位）。 | `<FLOAT>`：MS中的时间（默认值：0.0） |
| `net.OodleServerEnableMode` | 何时在服务器上启用压缩。 此设置会重载 `ServerEnableMode` 引擎配置设置。 | `<STRING>`：模式（默认值：“”） |
| `net.OptimizedRemapping` | 使用优化路径重新映射未映射的网络GUID。 | 0：禁用，1：启用 |
| `net.PackageMap.DebugAll` | 调试所有对象的 `PackageMap` 序列化。 | 0：禁用，1：启用 |
| `net.PackageMap.DebugObject` | 调试提供的对象的 `PackageMap` 序列化。 | `<STRING>`：对象名称（默认值：“”） |
| `net.PackageMap.LongLoadThreshold` | 打印对象序列化中的长加载警告的阈值时间（以秒为单位）。 | `<FLOAT>`：时间，以秒为单位（默认值：0.2） |
| `net.PacketHandlerCRCDump` | 启用后，则转储每个传入和传出的 `HandlerComponent` 数据包CRC以供调试。 | 0：禁用，1：启用 |
| `net.PacketHandlerTimeguardLimit` | `HandlerComponent` 时间确保日志的最大数量。 | `<INTEGER>`：日志数量（默认值：20） |
| `net.PacketHandlerTimeguardThresholdMS` | 传入和传出的 `HandlerComponent` 时间确保的阈值（以毫秒为单位）。 | `<FLOAT>`：时间，以毫秒为单位（默认值：0） |
| `net.PacketOrderCorrectionEnableThreshold` | 在启用校正之前需要发生的"混乱"数据包序列的数量。 | `<INTEGER>`：序列数量（默认值：1） |
| `net.PacketOrderMaxCachedPackets` | 等待缺失数据包序列时，在将缺失数据包视为丢失之前要缓存的数据包的最大数量。 此数字必须是2的幂。 | `<INTEGER>`：数据包数量（默认值：`2^5 == 32` ） |
| `net.PacketOrderMaxMissingPackets` | 在将缺失数据包视为丢失之前允许的缺失数据包序列的最大数量。 | `<INTEGER>`：序列数量（默认值：3） |
| `net.PartialBunchReliableThreshold` | 如果一个数据束分解为此数量或更多的部分数据束，则以可靠方式发送它，即使原始数据束不可靠。部分数据束是最小单位，必须全部送达才能使用。 | `<INTEGER>`：部分数据束的数量（默认值：8） |
| `net.PingDisplayServerTime` | 显示服务器帧时间。 在发布版本中不可用。 | 0：禁用，1：启用 |
| `net.PingExcludeFrameTime` | 启用后，从计算的ping中减去游戏帧时间，以估计实际网络ping。 | 0：禁用，1：启用 |
| `net.PingUsePacketRecvTime` | 使用操作系统或接收线程数据包接收时间来计算ping。 这不包括帧时间。 | 0：禁用，1：启用 |
| `net.ProcessQueuedBunchesMillisecondLimit` | 处理排队数据束的时间阈值。如果所用时间超过单帧中的此时间，将等待下一帧以继续处理排队的数据束。 要使用无限制的时间，请将其设置为0。 | `<INTEGER>`：时间，以毫秒为单位（默认值：30） |
| `net.ProfilerUseComparisonTracking` | 使用比较跟踪。 | 0：禁用，1：启用 |
| `net.PushModelSkipUndirtiedFastArrays` | 启用后，在跳过我们可以安全看到的未弄脏对象时包括快速数组。 | false：禁用，true：启用 |
| `net.PushModelSkipUndirtiedReplication` | 启用后，跳过复制我们可以安全看到的未弄脏对象。 | false：禁用，true：启用 |
| `net.PushModelValidateProperties` | 启用后，比较所有推送模型属性并在它们未被正确标记为脏时发出警告。 | false：禁用，true：启用 |
| `net.PushModelValidateSkipUpdate` | 启用后，检测我们在基于推送模型状态可以跳过对象复制时，仍然发送了数据的时刻。 | false：禁用，true：启用 |
| `net.QuantizeActorLocationOnSpawn` | 启用后，将新生成的Actor的位置量化到小数点后一位的精度。 | false：禁用，true：启用（默认值） |
| `net.QuantizeActorRotationOnSpawn` | 启用后，将新生成的Actor的旋转量化到小数点后一位的精度。 | false：禁用，true：启用（默认值） |
| `net.QuantizeActorScaleOnSpawn` | 启用后，将新生成的Actor的缩放量化到小数点后一位的精度。 | false：禁用（默认值），true：启用 |
| `net.QuantizeActorVelocityOnSpawn` | 启用后，将新生成的Actor的速度量化到小数点后一位的精度。 | false：禁用，true：启用（默认值） |
| `net.QueuedBunchTimeoutSeconds` | 在记录警告之前要等待通道上的排队数据束清空的时间（以秒为单位）。 | `<FLOAT>`：时间，以秒为单位（默认值：30） |
| `net.RandomizeSequence` | 随机化初始数据包序列。 这有助于提供一些混淆。 | 0：禁用，1：启用 |
| `net.RcvThreadShouldSleepForLongRecvErrors` | 当 `RecvFrom` 错误预期会持续很长时间时，其接收线程是否应该休眠。 | 0：不休眠（默认值），1：休眠，2：退出接收线程 |
| `net.RcvThreadSleepTimeForWaitableErrorsInSeconds` | 套接字操作返回可等待的错误时，接收线程休眠的时间。 值0仅在平台支持时起作用。 | < 0：禁用，0：放弃（默认值），> 0：休眠时间 |
| `net.RecreateSocketCooldown` | 套接字重建尝试之间的最短间隔时间（以秒为单位）。 | `<INTEGER>`：时间，以秒为单位（默认值：10） |
| `net.RecreateSocketTimeoutThreshold` | 在触发套接字重建之前未收到数据包或未发送ACK的时间（以秒为单位）。 | `<INTEGER>`：时间，以秒为单位（默认值：0） |
| `net.RecvMultiCapacity` | 启用 `RecvMulti` 后，这是每次调用时分配给处理程序的数据包数量。 数字越大越好，尤其是在受到DDoS攻击的情况下，但需要注意内存开销。 | `<INTEGER>`：数据包数量（默认值：2048） |
| `net.Reliable.Debug` | 打印通过网络发送的所有可靠数据束。 | 0：无打印（默认值），1：打印发送的数据束，2：每次网络更新时打印可靠的数据束缓冲区 |
| `net.ReliableRPCQueueSize` | 每个对象排队的可靠RPC的最大数量。这不包括发送窗口中的256个。这是为了支持分为更小片段的超大RPC。 | `<INTEGER>`：RPC数量（默认值：4096） |
| `net.RelinkMappedReferences` | 重新链接映射的引用。 | 0：禁用，1：启用（默认值） |
| `net.RepDriver.Enable` | 启用复制驱动程序。 禁用后，回退到旧版NetDriver实现。 | 0：禁用，1：启用（默认值） |
| `net.ReplicateCustomDeltaPropertiesInRepIndexOrder` | 启用后，自定义增量属性会按属性 `RepIndex` 的顺序复制，这通常是递增属性偏移顺序。禁用后，自定义增量属性会按它们在调用 `GetLifetimeReplicatedProps` 期间添加到生命周期属性数组时的顺序复制。 自定义增量属性总是在常规属性之后序列化。 | false：禁用（默认值），true：启用 |
| `net.ReplicateOnlyBeginPlay` | 只允许对已经被BeginPlay调用的Actor进行属性复制。 | false：禁用（默认值），true：启用 |
| `net.Replication.DebugProperty` | 按名称调试属性复制。这应该被设置为要调试的属性的部分名称。 | `<STRING>`：属性名称（默认值：""） |
| `net.RepMovement.DrawDebug` | 绘制复制的移动的调试信息。 | 0：禁用（默认值），1：启用 |
| `net.ReportGameTickFlushTime` | 录制并向性能跟踪系统报告 `GameNetDriver` 的 `TickFlush` 的处理时间。 | false：禁用（默认值），true：启用 |
| `net.ReportSyncLoads` | 启用后，引擎将跟踪网络连接系统加载的对象并广播 `FNetDelegates::OnSyncLoadDetected` 以报告它们。 默认情况下，它们会被记录到 `LogNetSyncLoads` 类别。 | false：禁用（默认值），true：启用 |
| `net.RequiredEncryptionNetDriverDefNames` | `NetDriverDefinition` 的逗号分隔列表，其中的 `IsEncryptionRequired` 在 `net.AllowEncryption == 2` 时返回true。 指定 `net.RequiredEncryptionNetDriverDefNames="all"` 会为所有 `NetDriverDefinition` 启用此项。 | 逗号分隔列表 |
| `net.ReservedNetGuidSize` | NetGUID序列化的预留大小（以字节为单位），用作后续序列化的占位符。 | `<INTEGER>`：大小，以字节为单位（默认值：512） |
| `net.ResetAckStatePostSeamlessTravel` | 启用后，服务器会在无缝漫游之后重置包映射的ACK状态。 会增加带宽使用量，但可以解决无缝漫游之后客户端上的GUID不可用的一些问题。 | 0：禁用（默认值），1：启用 |
| `net.ReuseReplicatorsForDormantObjects` | 启用后，服务器将不断尝试将复制器复用于休眠的Actor和对象。 这可以防止在对象从休眠中苏醒时发送冗余信息，从而节省带宽。 | false：禁用（默认值），true：启用 |
| `net.RPC.Debug` | 打印通过网络发送的所有RPC数据束。 | 0：禁用，1：启用 |
| `net.RPCDoSAnalyticsMaxRPCs` | 要包括在RPC DoS分析中的RPC的 `N` 数量，按每秒RPC速率排名。 | `<INTEGER>`：RPC数量（默认值：20） |
| `net.RPCDoSDetectionOverride` | 按NetDriver启用RPC DoS检测。 示例用法：`net.RPCDoSDetectionOverride=GameNetDriver=1,BeaconNetDriver=0` 。此命令将指定RPC DoS检测对 `GameNetDriver` 启用并对 `BeaconNetDriver` 禁用。 | 逗号分隔列表 |
| `net.RPCDoSForcedRPCTracking` | 设置在遇到时会强制启用RPC跟踪的单个RPC。限制为一个RPC以提高性能。 你还可以指定遇到RPC会启用跟踪的随机概率，以及启用跟踪的时间长度；否则，跟踪将在下一次更新时禁用。 示例用法：`net.RPCDoSForcedRPCTracking=ServerAdmin,0.5,10` 。此命令将指定当遇到 `ServerAdmin` RPC时，有50%的概率发生跟踪；并且如果发生跟踪，会持续10秒。 | `<STRING>`：RPC名称（默认值：“”）或逗号分隔列表 |
| `net.RPCDoSScopeDebugging` | 启用后，显示RPC DoS更新/数据包范围的调试信息。 | 0：禁用（默认值），1：启用 |
| `net.ShareInitialCompareState` | 如果启用此项并启用 `net.ShareShadowState` ，则尝试在各个连接之间共享初始复制比较。 | 0：禁用（默认值），1：启用 |
| `net.ShareSerializedData` | 启用后，将使用共享序列化系统进行复制，从而在多个客户端需要相同数据时减少CPU使用量。 | 0：禁用，1：启用（默认值） |
| `net.ShareShadowState` | 启用后，为比较属性执行的工作将在各个连接之间共享。 | 0：禁用，1：启用（默认值） |
| `net.SkipDestroyNetStartupActorsOnChannelCloseDueToLevelUnloaded` | 启用后，当我们通过 `ECloseReason::LevelUnloaded` 收到通道关闭时，不会销毁作为与通道关联的 `NetStartUpActor` 的Actor。 | false：禁用，true：启用（默认值） |
| `net.SkipReplicatorForDestructionInfos` | 启用后，当我们知道没有内容有效负载并且我们打算立即销毁Actor时，跳过 `SetChannelActor` 中对象复制器的创建。 | 0：禁用，1：启用 |
| `net.SubObjects.CompareWithLegacy` | 启用后，收集使用 `ReplicateSubObjects` 方法复制的子对象，并将其与通过Actor的注册列表复制的子对象比较。如果检测到两者之间存在偏离，将触发确保。 | false：禁用（默认值），true：启用 |
| `net.SubObjects.DefaultUseSubObjectReplicationList` | 启用后，Actor和Actor组件将默认使用注册方法复制子对象。 | false：禁用（默认值），true：启用 |
| `net.SubObjects.DetectDeprecatedReplicatedSubObjects` | 启用后，当 `ReplicateSubObjects` 函数仍在使用新的注册子对象列表的类中实现时，将触发确保。 | false：禁用（默认值），true：启用 |
| `net.SubObjects.LogAllComparisonErrors` | 启用后，记录 `net.SubObjects.CompareWithLegacy` 检测到的所有错误。禁用后，仅记录第一个触发的确保。 | 0：禁用（默认值），1：启用 |
| `net.SupportFastArrayDelta` | 启用后，则使用快速数组结构体增量序列化。 | 0：禁用，1：启用（默认值） |
| `net.TickAllOpenChannels` | 启用后，每个网络连接在每次更新时更新其所有打开的通道。 启用此项可以提供有用的调试信息，但可能使性能降级。 | 0：禁用，1：启用 |
| `net.TrackAsyncLoadingGUIDThreshold` | 将跟踪异步加载所用时间超过此阈值（以秒为单位）的所有对象。 使用此命令调试和分析。如需更多信息，请参阅 `FNetGUIDCache::ConsumeDelinquencyAnalytics` 。 | `<FLOAT>`：时间，以秒为单位（默认值：0） |
| `net.TrackAsyncLoadingGUIDThresholdOwner` | 如果网络连接的所属玩家控制器或Pawn等待异步加载的时间超过此阈值（以秒为单位），触发CSV事件以跟踪它。 使用此命令调试和分析。 | `<FLOAT>`：时间，以秒为单位（默认值：0） |
| `net.TrackDormantObjectsByLevel` | 启用后，网络对象列表会针对每个连接每个关卡维持一组休眠Actor。 | false：禁用，true：启用 |
| `net.TrackNetSerializeObjectReferences` | 启用后，为网络序列化结构体创建小布局（如果它们有对象属性）。 这可以防止一些阴影状态垃圾回收崩溃。 | false：禁用（默认值），true：启用 |
| `net.TrackQueuedActorThreshold` | 将跟踪在排队数据束上花费的时间超过此阈值（以秒为单位）的所有Actor。 使用此命令调试和分析。如需更多信息，请参阅 `UPackageMap::ConsumeDelinquencyAnalytics` 。 | `<FLOAT>`：时间，以秒为单位（默认值：0） |
| `net.TrackQueuedActorThresholdOwner` | 如果网络连接的所属玩家控制器或Pawn让数据束排队的时间超过此阈值，将触发CSV事件以跟踪它。 使用此命令调试和分析。 | `<FLOAT>`：时间，以秒为单位（默认值：0） |
| `net.UnreliableRPCQueueSize` | 每个对象排队的不可靠RPC的最大数量。如果有更多RPC排队，会丢弃更旧的RPC。 | `<INTEGER>`：RPC数量（默认值：10） |
| `net.UseAdaptiveNetUpdateFrequency` | 启用后，会基于Actor在复制时实际发送内容的频率来计算 Any actor that spends longer than this threshold (in seconds) with queued bunches is tracked.。 | 0：禁用（默认值），1：启用 |
| `net.UseGranularNetworkTracking` | 启用后，对象列表将打印关于网络内存使用量的详细信息。 | 0：禁用（默认值），1：启用 |
| `net.UsePackedShadowBuffers` | 启用后， `FRepLayout` 会生成只打包了必要网络属性的影子缓冲区，而不是复制整个对象状态。 | 0：禁用，1：启用（默认值） |
| `net.UseRecvMulti` | 如果在Unix/Linux平台上启用运行，将使用一个系统调用从套接字检索多个数据包，以提高性能，同时允许检索时间戳信息。 | 0：禁用（默认值），1：启用 |
| `net.UseRecvTimestamps` | 如果在Unix/Linux平台上启用此项并启用 `net.UseRecvMulti` ，将为每个收到的数据包检索内核时间戳，以提供更准确的ping计算。 | 0：禁用（默认值），1：启用 |
| `net.ValidateReplicatedPropertyRegistration` | 启用后，如果复制的属性未在 `GetLifetimeReplicatedProps` 中注册时会发出警告。 在发布版本中默认禁用，在其他所有版本中默认启用。 | 0：禁用，1：启用 |
| `net.VerifyMagicHeader` | 启用后，会在处理数据包之前验证魔法标头。 使用 `net.MagicHeader` 设置你的魔法标头。如果过渡到新的魔法标头，同时仍支持旧标头，则禁用验证。 | 0：禁用（默认值），1：启用 |
| `net.VerifyNetClientID` | 启用后，验证数据包 `ClientID` 。 | 0：禁用，1：启用（默认值） |
| `net.VerifyNetSessionID` | 启用后，验证数据包 `SessionID` 。 | 0：禁用，1：启用（默认值） |
| `net.VerifyShareSerializedData` | 启用后，在复制期间验证共享的序列化数据。 | 0：禁用（默认值），1：启用 |
| `net.WithArrayOnRepFix` | 启用后，会尝试防止未收到 `OnRep` 调用的数组在其原型的值不同于关卡中的实例时出现问题，直至其大小更改。 | false：禁用（默认值），true：启用 |
| `p.net.ForceFault` | 启用后，强制服务器端输入故障。 | 0：禁用（默认值），1：启用 |
| `p.net.ForceInputDrop` | 启用后，强制客户端丢弃输入。 使用此命令模拟不同步。 | 0：禁用（默认值），1：启用 |
| `p.net.LerpTargetNumBufferedCmdsAggresively` | 启用后，积极地向进行 `TargetNumBufferedCmds` 线性内插（LERP）。 减少服务器端缓冲，但可能造成更多瑕疵。 | 0：禁用（默认值），1：启用 |
| `p.net.MaxBufferedCmds` | 缓冲的服务器端命令的最大数量。 | `<INTEGER>`：命令数量（默认值：16） |
| `p.net.MaxTargetNumBufferedCmds` | 服务器指向每个客户端的最大缓冲输入数。 | `<FLOAT>`：输入数量（默认值：5） |
| `p.net.MaxTimeDilationMag` | 客户端用于减慢/跟上服务器的最大时间膨胀。 | `<FLOAT>`：时间，以秒为单位（默认值：0.01） |
| `p.net.TargetNumBufferedCmds` | 发生输入故障时要增加的 `TargetNumBufferedCmds` 数量。 | `<FLOAT>`：数量（默认值：1.9） |
| `p.net.TargetNumBufferedCmdsAlpha` | `TargetNumBufferedCmds` 的线性插值（LERP）强度。 | `<FLOAT>`：强度（默认值：0.005） |
| `p.net.TargetNumBufferedCmdsDeltaOnFault` | 发生输入故障时要增加的TargetNumBufferedCmds数量。 | `<FLOAT>`：数量（默认值：1） |
| `p.net.TimeDilationAlpha` | 滑动客户端时间膨胀的线性插值（LERP）强度。 | `<FLOAT>`：强度（默认值：0.1） |
| `p.net.TimeDilationEnabled` | 启用后，则使用客户端时间膨胀。 | 0：禁用（默认值），1：启用 |

### 控制台命令

| **命令** | **说明** | **参数** |
| --- | --- | --- |
| `net.ActorReport` | 打印世界中所有积极复制的Actor的Actor调试信息。 | 无 |
| `net.CreateBandwidthGenerator` | 创建带宽生成器。 | 无 |
| `net.DeleteDormantActor` | 删除所有休眠Actor。 | 无 |
| `net.DisconnectSimulatedConnections` | 断开指定数量的模拟客户端连接。 使用 `net.DisconnectSimulatedConnections 0` 断开所有模拟的客户端连接。 | `<INTEGER>`：连接数量 |
| `net.DumpRelevantActors` | 在下一次网络更新期间转储相关Actor的信息。 | 无 |
| `net.ForceOnePacketPerBunch` | 启用后，将AutoFlush用于所有连接，并强制在创建每个数据束时发送一个数据包。这会强制为每个复制的Actor发送一个数据包。 这有助于找到排序漏洞。 | true：启用，false：禁用 |
| `net.GenerateConstantBandwidth` | 每次更新时交付一个常量吞吐量，以生成指定的Kb/秒（千比特/秒）。 | `<FLOAT>`：带宽，以Kb/秒为单位 |
| `net.GeneratePeriodicBandwidthSpike` | 每 `<INTEGER>` 秒生成一个 `<FLOAT>` Kb的带宽峰值。 要生成每5秒100 Kb的带宽峰值，请使用以下命令：`net.GeneratePeriodicBandwidthSpike 100 5` 。 | `<FLOAT>`：大小，以Kb为单位， `<INTEGER>`：时间，以秒为单位 |
| `net.ListActorChannels` | 列出所有打开的Actor通道。 | 无 |
| `net.ListNetGUIDExports` | 列出每个网络GUID已导出的次数。 | 无 |
| `net.ListNetGUIDs` | 列出所有Actor的网络GUID。 | 无 |
| `net.PackageMap.FindNetGUID` | 查找被分配了指定网络GUID的对象。 在测试或发布版本中不可用。 如果你不提供参数，系统会在网络GUID缓存中查找所有对象。 | `<INTEGER>`：网络GUID |
| `net.SimulateConnections` | 启动模拟NetDriver。 | `<INTEGER>`：连接数量 |
| `net.TestObjRefSerialize` | 尝试将对象引用复制到所有客户端。 在测试或发布版本中不可用。 | 无 |
| `NetEmulation.Off` | 关闭网络模拟。 | 无 |
| `NetEmulation.PktDup` | 指定发送的出站数据包被复制的百分比概率。 | 值限制在0（不复制数据包）到100（复制所有数据包）之间。 |
| `NetEmulation.PktEmulationProfile` | 应用预配置的模拟配置文件。 | `<STRING>`：配置文件名称 |
| `NetEmulation.PktIncomingLagMax` | 指定接收端潜在数据包延迟的最大数量。 | `<INTEGER>`：时间，以毫秒为单位 |
| `NetEmulation.PktIncomingLagMin` | 指定接收端潜在数据包延迟的最小数量。 | `<INTEGER>`：时间，以毫秒为单位 |
| `NetEmulation.PktIncomingLoss` | 指定入站数据包被丢弃的百分比概率，以模拟数据包丢失。 | 值限制在0（不丢弃数据包）到100（丢弃所有数据包）之间。 |
| `NetEmulation.PktJitter` | 通过将NetEmulation.PktJitter的值添加到可能的数据包延迟时间范围，使已发送数据包具有可变的波动性延迟。 | `<INTEGER>`：时间，以毫秒为单位 |
| `NetEmulation.PktLag` | 以指定时长（以毫秒为单位）延迟数据包的发送。 不能用于 `NetEmulation.PktOrder` 。 | `<INTEGER>`：时间，以毫秒为单位 |
| `NetEmulation.PktLagMax` | 指定发送端潜在数据包延迟的最大数量。 | `<INTEGER>`：时间，以毫秒为单位 |
| `NetEmulation.PktLagMin` | 指定发送端潜在数据包延迟的最小数量。 | `<INTEGER>`：时间，以毫秒为单位 |
| `NetEmulation.PktLagVariance` | 使数据包延迟的行为类似随机变量而不是常量延迟时间（以毫秒为单位）。 如果设置，延迟是 `[PktLag - PktLagVariance, PktLag + PktLagVariance]` 区间上的均匀随机变量。 只能在启用 `NetEmulation.PktLag` 时启用。 | `<INTEGER>`：方差 |
| `NetEmulation.PktLoss` | 指定出站数据包被丢弃的百分比概率，以模拟数据包丢失。 | 值限制在0（不丢弃数据包）到100（丢弃所有数据包）之间。 |
| `NetEmulation.PktOrder` | 随机更改数据包的顺序。其工作方式是随机选择数据包以延迟到后续调用 `FlushNet` 为止。 | 0：禁用，1：启用 |

## Iris

Iris是虚幻引擎的下一代复制系统。如需详细了解Iris，请参阅Iris概述文档。Iris控制台变量以 `net.iris.` （网络连接Iris）前缀开头。

### 控制台变量

| **变量** | **说明** | **参数** |
| --- | --- | --- |
| `net.iris.AllowAsyncLoading` | 启用后，在启用Iris复制时允许异步加载。 还必须启用 `net.AllowAsyncLoading` 。 | false：禁用，true：启用（默认值） |
| `net.iris.AllowPollPeriodOverrides` | 启用后，允许轮询周期重载 `ObjectReplicationBridgeConfig` 中的设置。 | false：禁用，true：启用（默认值） |
| `net.iris.bWarnAboutStructPropertiesWithSuspectedNotReplicatedProperties` | 启用后，尝试检测作为属性复制的结构体是否可能包含未注释的成员。 | false：禁用（默认值），true：启用 |
| `net.iris.CullNonRelevant` | 启用后，剔除与任何客户端都不相关的已复制的Actor。 | false：禁用，true：启用（默认值） |
| `net.iris.DebugName` | 设置要在其中中断的类或对象名称。 | `<STRING>`：名称（默认值""） |
| `net.iris.DebugRPCName` | 设置要在其中中断的RPC名称。 | `<STRING>`：名称（默认值""） |
| `net.iris.DeferEndReplication` | 启用后，对 `EndReplication` 的调用会延迟到应用状态数据之后。 | false：禁用，true：启用（默认值） |
| `net.iris.DeltaCompressInitialState` | 启用后，序列化时将比较初始状态与默认状态。 | false：禁用，true：启用（默认值） |
| `net.iris.EnableDeltaCompression` | 启用后，将对复制的对象进行增量压缩。 | false：禁用，true：启用（默认值） |
| `net.iris.EnableFilterMappings` | 启用后，将采用 `ObjectReplicationBridgeConfig` 中设置的筛选器映射。如果启用筛选器映射，还可以向对象分配默认空间筛选器，即使没有具体映射。 | false：禁用，true：启用（默认值） |
| `net.iris.EnableForceNetUpdate` | 启用后，系统仅允许 `ForceNetUpdate` 跳过对象的轮询频率。禁用后会立即轮询 `MarkDirty` 对象。 | false：禁用（默认值），true：启用 |
| `net.iris.EnableRPCs` | 启用后，让Iris复制并执行RPC。 | 0：禁用，1：启用（默认值） |
| `net.iris.ExecuteReliableRPCsBeforeOnReps` | 如果启用并且Iris以向后兼容性模式运行，则会在 `OnRep` 之前在目标对象上执行可靠RPC。 | false：禁用（默认值），true：启用 |
| `net.iris.ForceFullCopyAndQuantize` | 启用后，将使用完整复制和量化。禁用后，系统仅复制并量化脏状态数据。 | false：禁用（默认值），true：启用 |
| `net.iris.ForcePruneBeforeUpdate` | 启用后，将在每次更新开始时验证所有跟踪的实例的完整性。 在发布版本中不可用。 | false：禁用（默认值），true：启用 |
| `net.iris.IrisPreExportExistingNetTokensOnConnect` | 启用后，将在添加新连接时将所有现有网络令牌排队以进行预导出。 | false：禁用（默认值），true：启用 |
| `net.iris.LogReplicationProtocols` | 启用后，记录所有创建的复制协议。 | false：禁用（默认值），true：启用 |
| `net.iris.MinimumNumberOfFramesBetweenBaselines` | 为对象创建新增量压缩基线之间间隔的最少帧数。 | `<INTEGER>`：帧（默认为60） |
| `net.iris.OnlyQuantizeDirtyMembers` | 启用后，仅量化被标记为脏的成员，除非这是新对象。 | false：禁用，true：启用（默认值） |
| `net.iris.PushModelMode` | 设置Iris网络连接的推送模型模式。 此设置需要你启用 `net.IsPushModelEnabled` 和 `WITH_PUSH_MODEL > 0` ，以在向后兼容性模式下使用基于推送的脏污。 | 0：禁用（运行时可切换），1：启用（运行时不可切换），2：启用（运行时可切换）（默认值） |
| `net.iris.ReplicationWriter.ValidateObjectsWithDirtyChanges` | 启用后，验证所有被标记为脏的对象。 | false：禁用（默认值），true：启用 |
| `net.iris.SaturateBandwidth` | 启用后，将使带宽饱和。 | false：禁用（默认值），true：启用 |
| `net.iris.UseChangeMaskForTArray` | 启用后，将对 `TArray` 中的单独元素使用更改遮罩。启用此项后，如果发生数据包丢失，接收的数组可能无法反映发送端存在的状态，因为数组不会以原子方式复制。 | false：禁用，true：启用（默认值） |
| `net.iris.UseDormancyToFilterPolling` | 启用后，使用休眠筛选掉不应该被轮询的对象。 | false：禁用，true：启用（默认值） |
| `net.iris.UseFrequencyBasedPolling` | 启用后，使用基于频率的轮询。 | false：禁用，true：启用（默认值） |
| `net.iris.UseIrisReplication` | 启用后，使用Iris复制系统。禁用后，仍可使用虚幻引擎的旧版复制系统进行复制。 | 0：禁用（默认值），1：启用 |
| `net.iris.UseNativeFastArray` | 启用后，使用 `IrisNativeFastArray` 。 | false：禁用，true：启用（默认值） |
| `net.iris.UsePrevReceivedStateForOnReps` | 启用后， `OnRep` 在执行 `OnRep` 时使用之前接收的状态，并且不执行比较。禁用后，在发出 `OnRep` 之前会复制本地状态并比较。 | false：禁用（默认值），true：启用 |
| `net.iris.UseSupportsStructNetSerializerList` | 启用后， `SupportsStructNetSerializerList` 中的结构体不发出警告，即使结构体有 `NetSerialize`/`NetDeltaserialize` ，但没有自定义 `NetSerializer` 。 | false：禁用，true：启用（默认值） |
| `net.iris.WarnAboutDroppedAttachmentsToObjectsNotInScope` | 启用后，在由于对象不在范围内而丢弃附件时发出警告。 | false：禁用（默认值），true：启用 |
| `net.iris.WarnAboutStructsWithCustomSerialization` | 启用后，在为带有自定义序列化的结构体生成描述符时发出警告。 | false：禁用，true：启用（默认值） |

### 控制台命令

| **命令** | **说明** | **参数** |
| --- | --- | --- |
| `net.iris.DebugNetInternalIndex` | 指定要在其中中断的内部索引。 | `<INTEGER>`：内部网络引用索引 |
| `net.iris.DebugNetRefHandle` | 指定要在其中中断的NetRefHandle ID。 | `<INTEGER>`：网络引用句柄 |

## 检查控制台变量状态

要检查控制台变量的状态，你可以将控制台变量的名称输入控制台中，后跟问号（?）。要检查所有控制台变量的状态，请使用 `DumpCVars` 。要检查所有控制台命令的状态，请使用 `DumpCCmds` 。如果你只想查看网络连接控制台变量，你可以搜索 `net.` 控制台变量以筛选控制台日志。
