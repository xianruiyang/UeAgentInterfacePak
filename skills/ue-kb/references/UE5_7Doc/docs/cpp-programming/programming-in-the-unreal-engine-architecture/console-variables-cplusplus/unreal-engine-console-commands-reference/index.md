---
title: "Console Commands Reference"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-console-commands-reference"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "虚幻架构", "控制台变量和命令", "Console Commands Reference"]
---

# Console Commands Reference

> 路径：虚幻引擎5.7文档 / 用C++编程 / 虚幻架构 / 控制台变量和命令 / Console Commands Reference

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-console-commands-reference

| **命令** | **说明** |
| --- | --- |
| `a.AuditLoadedAnimGraphs` | Audit 内存 breakdown 的 当前 已加载 anim graphs. 写入 结果 到 该 日志. |
| `a.Sharing.Enabled` | 参数: 0/1 控制是否 该 动画 sharing 是 启用. |
| `a.Sharing.ToggleVisibility` | 切换 该 visibility 的 该 Leader 姿势 组件. |
| `abtest` | 提供 两个 控制台 命令 或 'stop' 到 stop 该 abtest. Frames 为 timed 使用 该 两个 选项, 日志记录 结果 超过 时间. |
| `Accessibility.DumpStatsSlate` | 写入 内存 统计 用于 Slate's accessibility 数据 存储 到 LogAccessibility. |
| `Accessibility.DumpStatsWindows` | 写入 到 LogAccessibility 该 内存 统计 用于 该 平台-关卡 accessibility 数据 (Providers) 必需 用于 窗口 支持. |
| `ACL.ListAnimSequences` | 转储 统计信息 关于 动画 sequences 到 该 日志. |
| `ACL.ListCodecs` | 转储 统计信息 关于 动画 codecs 到 该 日志. |
| `ACL.SetDatabaseVisualFidelity` | 设置 该 visual fidelity 的 所有 ACL databases. 参数: Highest (默认 如果 no 参数 是 提供), Medium, Lowest |
| `AddWork` |  |
| `ai.debug.nav.DirtyAreaAroundPlayer` | Dirty 所有 tiles 在 a square area 围绕 该 本地 玩家 使用 提供 值 作为 extent (在 cm), 使用 10 meters 如果 不 指定. |
| `ai.debug.nav.DrawDistance` | 设置 该 剔除 距离 由以下内容使用 该 navmesh 渲染 用于 lines 和 标签. |
| `AnimRecorder.SampleRate` | 参数: 有效 帧 速率 格式. 设置 该 采样 帧-速率 用于 该 动画 recorder 系统 |
| `AssetManager.AssetAudit` | 转储 统计信息 关于 资产 到 该 日志. |
| `AssetManager.DumpAssetDependencies` | 显示 a 列表 的 所有 primary 资产 和 该 secondary 资产 该 它们 depend 在. 还 写入 输出 a .graphviz 文件 |
| `AssetManager.DumpAssetRegistry` | Prints 条目 在 该 资产 注册表. 参数 为 必需: ObjectPath, PackageName, 路径, 类, 标签, 依赖, PackageData. |
| `AssetManager.DumpAssetRegistryInfo` | 转储 extended 信息 关于 资产 注册表 到 日志 |
| `AssetManager.DumpBundlesForAsset` | 显示 a 列表 的 所有 包 用于 该 指定 primary 资产 通过 primary 资产 ID (i.e. 映射:条目) |
| `AssetManager.DumpLoadedAssets` | 显示 a 列表 的 所有 已加载 primary 资产 和 包 |
| `AssetManager.DumpReferencersForPackage` | Generates a 图表 viz 和 日志 文件 的 所有 references 到 a 指定 包 |
| `AssetManager.DumpTypeSummary` | 显示 a 概要 的 类型 已知 关于 通过 该 资产 管理器 |
| `AssetManager.FindDepChain` | Finds all dependency chains from assets in the given search path, to the target package. Usage: `FindDepChain TargetPackagePath SearchRootPath (optional: -hardonly/-softonly)`. For example: `FindDepChain /game/characters/heroes/muriel/meshes/muriel /game/cards` |
| `AssetManager.FindDepClasses` | Finds all dependencies of a certain set of classes to the target asset. Usage: `FindDepClasses TargetPackagePath ClassName1 ClassName2 etc (optional: -hardonly/-softonly)`. For example: `FindDepChain /game/characters/heroes/muriel/meshes/muriel /game/cards` |
| `AssetManager.LoadPrimaryAssetsWithType` | Loads 所有 资产 的 a 给定 类型 |
| `AssetManager.UnloadPrimaryAssetsWithType` | Unloads 所有 资产 的 a 给定 类型 |
| `AssetRegistry.Debug.FindInvalidUAssets` | Finds a 列表 的 所有 资产 其 为 在 UAsset 文件 但是 do 不 share 该 名称 的 该 包 |
| `AssetRegistry.DumpAllocatedSize` | 转储 该 分配 的 该 资产 注册表 状态 到 该 日志 |
| `AssetRegistry.DumpState` | Dump the state of the asset registry to a file. Pass `-log` to dump to the log as well. Extra string parameters: All, ObjectPath, PackageName, Path, Class, Tag, Dependencies, DependencyDetails, PackageData, AssetBundles, AssetTags |
| `AssetRegistry.GetByClass` | `<ClassName>` Query the asset registry for assets matching the supplied class |
| `AssetRegistry.GetByName` | `<PackageName>` Query the asset registry for assets matching the supplied package name |
| `AssetRegistry.GetByPath` | `<Path>` Query the asset registry for assets matching the supplied package path |
| `AssetRegistry.GetByTag` | `<TagName> <TagValue>` Query the asset registry for assets matching the supplied tag and value |
| `AssetRegistry.GetDependencies` | `<PackageName>` Query the asset registry for dependencies for the specified package |
| `AssetRegistry.GetReferencers` | `<ObjectPath>` Query the asset registry for referencers for the specified package |
| `AssetRegistry.ScanPath` | `<PathToScan>` Scan the given filename or directoryname for package files and load them into the assetregistry. Extra string parameters: `-forcerescan`, `-ignoreDenyLists`, `-asfile`, `-asdir` |
| `AssetTools.LogFolderPermissions` | 记录 该 读取 和 写入 权限 用于 folders |
| `au.3dVisualize.Attenuation` | 是否 或 不 attenuation spheres 为 可见 当 3d visualize 是 启用. 0: 不 已启用, 1: 已启用 |
| `au.AudioSourceManager.HangDiagnostics` |  |
| `au.AudioThreadCommand.ChokeCommandQueue` |  |
| `au.AudioThreadCommand.ChokeMPSCCommandQueue` |  |
| `au.AudioThreadCommand.SpamCommandQueue` |  |
| `au.ClearMutesAndSolos` | Clears 任何 solo-ing/mute-ing 声音 |
| `au.debug.bufferdiagnostics` | 启用 每个 缓冲区 采样 diagnostics (Nans/denorms/Infs) |
| `au.Debug.Modulation` | Post Audio Modulation information to viewport(s). 0: Disable, 1: Enable (Optional) `-AllViews`: Enables/Disables for all viewports, not just those associated with the current world |
| `au.Debug.PlaySoundCue` | Plays a SoundCue: `-Name <SoundName>`: If a debug sound with the short name is specified in AudioSettings, plays that sound. `-Path <ObjectPath>`: Finds SoundCue asset at the provided path and if found, plays that sound. `-Radius <Distance>`: If set, enables sound spatialization and sets radial distance between listener and source emitting sound. `-Azimuth <Angle>`: If set, enables sound spatialization and sets azimuth angle between listener and source emitting sound (in degrees, where 0 is straight ahead, negative to left, positive to right). `-Elevation <Angle>`: If set, enables sound spatialization and sets azimuth angle between listener and source emitting sound (in degrees, where 0 is straight ahead, negative to left, positive to right). `-AllViews`: If option provided, plays sound through all viewports. `-LogSubtitles`: If option provided, logs sounds subtitle if set. |
| `au.Debug.PlaySoundWave` | Plays a SoundWave: `-Name <SoundName>`: If a debug sound with the short name is specified in AudioSettings, plays that sound. `-Path <ObjectPath>`: Finds SoundWave asset at the provided path and if found, plays that sound. `-Radius`: If set, enables sound spatialization and sets radial distance between listener and source emitting sound. `-Azimuth <Angle>`: If set, enables sound spatialization and sets azimuth angle between listener and source emitting sound (in degrees, where 0 is straight ahead, negative to left, positive to right). `-Elevation <Angle>`: If set, enables sound spatialization and sets azimuth angle between listener and source emitting sound (in degrees, where 0 is straight ahead, negative to left, positive to right). `-AllViews`: If option provided, plays sound through all viewports. -LogSubtitles: If option provided, logs sounds subtitle if set |
| `au.Debug.SoundCues` | Post SoundCue information to viewport(s). 0: Disable, 1: Enable. (Optional) `-AllViews`: Enables/Disables for all viewports, not just those associated with the current world |
| `au.Debug.SoundMixes` | Post SoundMix information to viewport(s). 0: Disable, 1: Enable. (Optional) `-AllViews`: Enables/Disables for all viewports, not just those associated with the current world |
| `au.Debug.SoundReverb` | Post SoundReverb information to viewport(s). 0: Disable, 1: Enable (Optional) `-AllViews`: Enables/Disables for all viewports, not just those associated with the current world |
| `au.Debug.Sounds` | Post Sound information to viewport(s). 0: Disable, 1: Enable (Optional) `-AllViews`: Enables/Disables for all viewports, not just those associated with the current world |
| `au.Debug.SoundWaves` | Post SoundWave information to viewport(s). 0: Disable, 1: Enable (Optional) `-AllViews`: Enables/Disables for all viewports, not just those associated with the current world |
| `au.Debug.StopSound` | Stops 调试 声音. -AllViews: 如果 选项 提供, stops 所有 调试 声音 在 所有 视口. |
| `au.Debug.Streaming` | Post Stream Caching information to viewport(s). 0: Disable, 1: Enable (Optional) `-AllViews`: Enables/Disables for all viewports, not just those associated with the current world |
| `au.DumpActiveSounds` | Outputs 数据 关于 所有 该 当前 激活 声音. |
| `au.DumpBakedAnalysisData` | 调试 命令 到 转储 该 baked analysis 数据 的 a 声音 wave 到 a CSV 文件. |
| `au.MetaSound.Experimental.OperatorPool.SetMaxNumOperators` | 设置 该 最大 数量 的 operators 在 该 MetaSound operator 缓存. |
| `au.Metasound.Profiling.AddNodes` | 添加 该 指定 节点 类 名称(s) 到 该 列表 的 metasound 节点 该 将 是 profiled 和 可见 在 Insights. |
| `au.Metasound.Profiling.ListNodes` | Lists 该 节点 类 名称 该 将 是 profiled 和 可见 在 Insights. |
| `au.Metasound.Profiling.RemoveNodes` | Removes 该 指定 节点 类 名称(s) (或 所有 如果 no 名称 为 提供) 从 该 列表 的 节点 类型 该 将 是 profiled 和 可见 在 Insights. |
| `au.Modulation.SetPitchRange` | 设置 最大 最终 modulation range 的 pitch (在 semitones). 默认值: 96 semitones (+/- 4 octaves) |
| `au.ReportAudioDevices` | 此 将 日志 任何 激活 音频 设备 (实例 的 该 音频 引擎) alive 右侧 现在. |
| `au.SourceFadeMin` | 设置 该 length (在 样本) 的 最小 fade 当 a 声音 源 是 停止. 必须 是 divisible 通过 4 (vectorization requirement). Ignored 用于 一些 procedural 源 类型. (默认值: 512, Min: 4). |
| `au.spatialization.ListAvailableSpatialPlugins` | 此 将 输出 a 列表 的 当前 可用/激活 空间化 插件 |
| `au.spatialization.SetCurrentSpatialPlugin` | Attempt 到 swap 到 该 命名 空间化 插件 (au.空间化.ListAvailableSpatialPlugins 到 参见 什么 是 availible) |
| `au.streamcaching.FlushAudioCache` | 此 将 flush 任何 non retained 音频 从 该 缓存 当 流 Caching 是 启用. |
| `au.streamcaching.ResizeAudioCacheTo` | 此 将 尝试 到 cull enough 音频 chunks 到 收缩 该 音频 流 缓存 到 该 新增 大小 如果 neccessary, 和 保持 该 缓存 在 该 大小. |
| `au.streamcaching.StartProfiling` | 此 将 开始 a 性能-intensive profiling 模式 用于 此 流式传输 管理器. 分析 统计 可以 是 输出 使用 audiomemreport. |
| `au.streamcaching.StopProfiling` | 此 将 开始 a 性能-intensive profiling 模式 用于 此 流式传输 管理器. 分析 统计 可以 是 输出 使用 audiomemreport. |
| `au.submix.drawgraph` | Draws 该 submix heirarchy 用于 此 世界 到 该 调试 输出 |
| `AudioThread.TaskPriority` | Takes a single parameter of value `High`, `Normal`, `BackgroundHigh`, `BackgroundNormal` or `BackgroundLow`. |
| `bp.AuditFunctionCallsForBlueprint` | Audit 所有 函数 称为 通过 a 指定 蓝图. 单个 参数 supplies 该 资产 到 audit. 写入 结果 到 该 日志. |
| `bp.AuditThreadSafeFunctions` | Audit 当前 已加载 线程 safe 函数. 写入 结果 到 该 日志. |
| `BP.DumpAllRegisteredNamespacePaths` | 转储 所有 注册 命名空间 路径. |
| `BP.ToggleUsePackagePathAsDefaultNamespace` | 切换 该 使用 的 a 类型's 包 路径 作为 它的 默认 命名空间 当 不 explicitly 分配. Otherwise, 所有 类型 默认 到 该 全局 命名空间. |
| `c.ToggleGPUCrashedFlagDbg` | Forcibly 切换 该 'GPU Crashed' 标志 用于 测试 崩溃 分析. |
| `CancelAllTasks` |  |
| `CollectionManager.Add` | 添加 该 指定 对象 路径 到 该 指定 集合 |
| `CollectionManager.Create` | 创建 a 集合 的 该 指定 名称 和 类型 |
| `CollectionManager.Destroy` | Deletes a 集合 的 该 指定 名称 和 类型 |
| `CollectionManager.Remove` | Removes 该 指定 对象 路径 从 该 指定 集合 |
| `Collision.ListChannels` | ListChannels |
| `Collision.ListComponentsWithResponseToProfile` |  |
| `Collision.ListObjectsWithCollisionComplexity` |  |
| `Collision.ListProfiles` | ListProfiles |
| `Collision.ListProfilesWithResponseToChannel` |  |
| `ContentBrowser.Debug.ConvertInternalPathToVirtual` | Convert 内部 路径 |
| `ContentBrowser.Debug.TryConvertVirtualPath` | 尝试 到 convert 虚拟 路径 |
| `ControlRig.Hierarchy.Trace` | Traces 更改 在 a 层级 用于 a 提供 数量 的 executions (默认为 1). 你 可以 使用 ControlRig.层级.TraceCallstack 到 启用 callstack 追踪 作为 部分 的 此. |
| `ControlRig.LoadAllAssets` | Loads 所有 控制 绑定 资产. |
| `CoreUObject.AttemptToFindShortTypeNamesInMetaData` | Finds 短 类型 名称 存储 在 已知 元数据 条目 |
| `CoreUObject.AttemptToFindUninitializedScriptStructMembers` | Finds USTRUCT() structs 该 fail 到 initialize reflected member 变量 |
| `CPUTime.Dump` | 用法 -Delay=[NumSeconds=30] 如果 Delay==0, 禁用 printing 该 CPU 用法 到 该 日志 如果 Delay>0, starts printing 该 average CPU 用法 从 该 最后 n frames, clamps 之间 10 和 300 |
| `CreateDummyFileInPersistentStorage` | 创建 a dummy 文件 使用 指定 大小 在 指定 persistent 存储 文件夹 |
| `CsvCategory` | 更改 是否 a CSV 类别 是 包含 在 captures. |
| `CsvProfile` | Starts 或 stops CSV 配置文件 |
| `CustomTimeStep.reset` | Resets 该 当前 自定义 步骤. |
| `D3D12.DumpRayTracingGeometries` | 转储 内存 分配 用于 ray 追踪 资源. |
| `D3D12.DumpRayTracingGeometriesToCSV` | 转储 所有 内存 分配 用于 ray 追踪 资源 到 a CSV 文件 在 disc. |
| `D3D12.DumpTrackedAllocationCallstacks` | 转储 所有 跟踪 d3d12 资源 分配 callstacks. |
| `D3D12.DumpTrackedAllocations` | 转储 所有 跟踪 d3d12 资源 分配. |
| `D3D12.DumpTrackedResidentAllocationCallstacks` | 转储 所有 跟踪 resident d3d12 资源 分配 callstacks. |
| `D3D12.DumpTrackedResidentAllocations` | 转储 所有 跟踪 resisdent d3d12 资源 分配. |
| `D3D12.RayTracing.SerializeScene` | Serialize Ray 追踪 场景 到 磁盘. |
| `DDC.LoadReplay` | Loads a 缓存 replay 文件 创建 通过 -DDC-ReplaySave= |
| `DDC.MountPak` | Mounts 读取-仅 pak 文件 |
| `DDC.UnmountPak` | Unmounts 读取-仅 pak 文件 |
| `Demo.ActorPrioritizationEnabled` | 设置 是否 或 不 Actor prioritization 是 启用 在 demo 驱动 的 该 当前 世界. |
| `Demo.CheckpointSaveMaxMSPerFrame` | 设置 最大 checkpoint 记录 时间 在 MS 在 demo 驱动 的 该 当前 世界. |
| `Demo.MaxDesiredRecordTimeMS` | 设置 最大 期望 记录 时间 在 MS 在 demo 驱动 的 该 当前 世界. |
| `Demo.SetLocalViewerOverride` | 设置 第一个 本地 玩家 controller 作为 该 viewer 覆盖 在 demo 驱动 的 该 当前 世界. |
| `Demo.TestWriteEvent` | 添加 或 更新 a 测试 replay 事件 在 该 当前 录制 replay, 使用 一个 可选 参数 用于 事件 大小 在 bytes |
| `diff` | diff 两个 资产 针对 一个 另一个. 格式: 'diff |
| `dp.Override.Restore` | Restores 任何 cvars 设置 通过 dp.覆盖 到 它们的 之前的 值 |
| `DumpCCmds` | Lists all CVars (or a subset) and their values. Can also show help, and can save to .csv. Usage: `DumpCCmds [Prefix] [-showhelp] [-csv=[path]]` If -csv does not have a file specified, it will create a file in the Project Logs directory |
| `DumpConsoleCommands` | 转储 所有 控制台 vaiables 和 命令 和 所有 exec 该 可以 是 discovered 到 该 日志/控制台 |
| `DumpCVars` | Lists all CVars (or a subset) and their values. Can also show help, and can save to .csv. Usage: `DumpCVars [Prefix] [-showhelp] [-csv=[path]]` If -csv does not have a file specified, it will create a file in the Project Logs directory |
| `DumpDetailedPrimitives` | 写入 输出 所有 场景 primitive 细节 到 a CSV 文件 |
| `DumpGPU` | 转储 一个 帧 的 渲染 intermediary 资源 到 磁盘. |
| `DumpLevelCollections` | 转储 关卡 集合 在 该 当前 世界. |
| `DumpLightmapSizeOnDisk` | 转储 该 大小 的 所有 已加载 lightmaps 在 磁盘 (源 和 平台 数据) |
| `DumpLLM` | 记录 输出 该 当前 和 peak sizes 的 所有 跟踪 LLM 标签 |
| `DumpNiagaraWorldManager` | 转储 信息 关于 该 Niagara 世界 管理器 内容 |
| `DumpPackagePayloadInfo` | 写入 输出 信息 关于 a 包's payloads 到 该 日志. |
| `DumpPersistentStorage` | 转储 PersistentStorage |
| `DumpPrimitives` | 写入 输出 所有 场景 primitive 名称 到 a CSV 文件 |
| `dumpticks` | 转储 所有 tick 函数 注册 使用 FTickTaskManager 到 日志. |
| `DumpUnbuiltLightInteractions` | 记录 所有 灯光 和 primitives 该 具有 一个 unbuilt interaction. |
| `DumpVisibleActors` | 转储 可见 Actor 在 当前 世界. |
| `Editor.AsyncAssetCompilationFinishAll` | Finish 所有 资产 编译 |
| `Editor.AsyncAssetDumpStallStacks` | 转储 所有 该 callstacks 该 具有 caused waits 在 异步 compilation. |
| `Editor.AsyncSkinnedAssetCompilationFinishAll` | Finish 所有 skinned 资产 编译 |
| `Editor.AsyncSoundWaveCompilationFinishAll` | Finish 所有 soundwaves 编译 |
| `Editor.AsyncStaticMeshCompilationFinishAll` | Finish 所有 static 网格体 编译 |
| `Editor.AsyncTextureCompilationFinishAll` | Finish 所有 纹理 编译 |
| `Editor.Debug.SlowTask.Simulate` | 运行 a busy loop 用于 N 秒. 将 tick 该 slow 任务 每个 100ms 直到 它 是 complete |
| `Editor.EnableInViewportMenu` | 启用 该 新增 在-视口 属性 菜单 |
| `Editor.ObjectReverseLookupValidate` | Compare 对象 包含 在 该 reverse lookup 针对 该 旧 scanning 方法 到 参见 如果 存在 是 任何 discrepenties. |
| `Editor.ResizeMainFrame` |  |
| `EditorDomain.DumpClassDigests` | 写入 到 该 日志 该 digest 信息 用于 每个 类. |
| `EnableGDT` | 切换 Gameplay Debugger 工具 |
| `EnhancedInput.DumpKeyProfileToLog` |  |
| `EnhancedInput.SaveKeyProfilesToSlot` | 保存 该 用户 输入 设置 对象 使用 该 保存 游戏 到 slot 系统 |
| `FindRedundantMICS` | Looks 在 所有 已加载 MICs 和 looks 用于 redundant ones. |
| `FName.Dump` | 转储 所有 基础 FName strings 到 a 文件. 传递 -num=n 到 转储 该 多数 最近 n 名称. |
| `FName.DumpNumbered` | 转储 所有 numbered FNames 到 a 文件 (仅 当 UE_FNAME_OUTLINE_NUMBER 是 设置). 传递 -num=n 到 转储 该 多数 最近 n 名称. |
| `FName.HashCsv` | 写入 FName 哈希 统计 到 a CSV 文件. |
| `FName.List` | 列表 所有 基础 FName strings 到 该 输出 设备. 传递 -num=n 到 列表 该 多数 最近 n 名称. |
| `FName.ListNumbered` | 列表 所有 numbered FNames 到 该 输出 devicce (仅 当 UE_FNAME_OUTLINE_NUMBER 是 设置). 传递 -num=n 到 列表 该 多数 最近 n 名称. |
| `FName.Stats` | 写入 FName 统计 到 该 输出 设备. |
| `foliage.Freeze` | Useful 用于 调试. Freezes 该 foliage 剔除 和 LOD. |
| `foliage.LogFoliageFrame` | Useful 用于 调试. 记录 所有 foliage rendered 在 a 帧. |
| `foliage.RebuildFoliageTrees` | Rebuild 该 trees 用于 non-草地 foliage. |
| `foliage.Test` | Useful 用于 调试. |
| `foliage.ToggleVectorCull` | Useful 用于 调试. 切换 该 optimized cull. |
| `foliage.UnFreeze` | Useful 用于 调试. Freezes 该 foliage 剔除 和 LOD. |
| `FontAtlasVisualizer` | 显示 该 Slate font atlas visualizer |
| `ForceBuildStreamingData` | Forces 流式传输 数据 到 是 rebuilt 用于 该 当前 世界. |
| `fx.DumpCompileIdDataForAsset` | 转储 数据 相关 到 generating 该 compile ID 用于 一个 资产. |
| `fx.DumpEmitterDepencenciesInFolder` | 转储 emitter 依赖 用于 所有 systems 在 该 提供 文件夹 和 sub-folders. |
| `FX.DumpNCPoolInfo` | 转储 Niagara 系统 Pooling 信息 |
| `fx.DumpNiagaraScalabilityState` | 转储 状态 信息 用于 所有 Niagara Scalability Mangers. |
| `fx.DumpPSCPoolInfo` | 转储 Particle 系统 Pooling 信息 |
| `fx.DumpPSCTickStateInfo` | 转储 状态 信息 用于 所有 当前 Particle 系统 组件. |
| `fx.DumpRapidIterationParametersForAsset` | 转储 该 值 的 该 rapid iteration 参数 用于 该 指定 资产 通过 路径. |
| `fx.InvalidateCachedScripts` | Invalidate Niagara 脚本 缓存 通过 making a 唯一 更改 到 NiagaraShaderVersion.ush 其 是 包含 在 通用.usf.到 initiate actual 该 recompile 的 所有 shaders 使用 recompileshaders changed" 或 press "Ctrl Shift .". 该 NiagaraShaderVersion.ush 文件 应 是 自动 检查 输出 但是 它 需要 到 是 检查 在 到 具有 effect 在 其他 机器." |
| `fx.InvalidateNiagaraPerfBaselines` | Invalidates 所有 Niagara 性能 baseline 数据. |
| `fx.LoadAllNiagaraSystemsInFolder` | Loads 所有 niagara systems 在 该 提供 目录 和 sub-directories. |
| `fx.Niagara.DataChannels.DumpWriteLog` | 转储 所有 该 当前 存储 写入 到 该 日志 (参见 fx.Niagara.DataChannels.FrameDataToCapture 在 如何 许多 frames 为 捕获) |
| `fx.Niagara.DataChannels.ResetLayoutInfo` | Resets 所有 数据 通道 layout 信息 由以下内容使用 数据 interfaces 到 访问 数据 通道. |
| `fx.Niagara.Debug.Hud` | 设置 选项 用于 调试 hud 显示 |
| `fx.Niagara.Debug.KillSpawned` | Kills 所有 spawned compoonents |
| `fx.Niagara.Debug.PlaybackMode` | 设置 播放 模式 0 - Play 1 - Paused 2 - 步骤 |
| `fx.Niagara.Debug.PlaybackRate` | 设置 播放 速率 |
| `fx.Niagara.Debug.SpawnComponent` | Spawns a NiagaraComponent 使用 该 给定 参数 |
| `fx.Niagara.DumpComponents` | 转储 信息 关于 所有 Niagara 组件 |
| `fx.Niagara.FixDuplicateVariableGuids` | Validates 和 修复 该 脚本 guids 的 a 给定 脚本, 如果 duplicates exist. |
| `fx.Niagara.RenderTarget.OverrideFormat` | 可选 全局 格式 覆盖 用于 所有 Niagara 渲染 targets |
| `fx.Niagara.Scalability.CullingMode` | 设置 scalability 剔除 模式 0 - 已启用. 剔除 是 启用 作为 法线. 1 - Paused. No 剔除 将 发生 但是 FX 将 仍然 是 跟踪 internally so 剔除 可以 是 resumed 正确 稍后. 2 - 禁用. No 剔除 将 发生 和 no FX 将 是 跟踪. 剔除 可能 不 工作 正确 用于 一些 FX 如果 启用 again 之后 此. |
| `fx.Niagara.SetOverridePlatformName` | 设置 其 平台 we 应 覆盖 使用, no args 表示 reset 到 默认 |
| `fx.Niagara.SetOverrideQualityLevel` | 设置 其 quality 关卡 we 应 覆盖 使用, no args 表示 clear 该 覆盖 和 return 到 non overriden quality 关卡). 有效 关卡 为 0-4 (低-Cinematic) |
| `fx.Niagara.TaskPriorities.Dump` | 转储 当前 设置 priorities |
| `fx.Niagara.TaskPriorities.RunTest` | 运行 a 测试 设置 的 priorites |
| `fx.Niagara.ValidateDuplicateVariableGuids` | Validate 该 脚本 guids 的 a 给定 脚本. |
| `fx.NiagaraEditor.ReinitializeStyle` | Reinitializes 该 样式 用于 该 niagara 编辑器 module. 使用 在 conjuction 使用 实时 coding 用于 UI tweaks. 可能 崩溃 该 编辑器 如果 样式 对象 为 在 使用. |
| `fx.NiagaraEditorWidgets.ReinitializeStyle` | Reinitializes 该 样式 用于 该 niagara 编辑器 Widget module. 使用 在 conjuction 使用 实时 coding 用于 UI tweaks. 可能 崩溃 该 编辑器 如果 样式 对象 为 在 使用. |
| `fx.ParticlePerfStats.RunTest` | 运行 用于 a 数量 的 frames 然后 记录 输出 该 结果. Arg0 = NumFrames. Arg1 = Gather 世界 统计 (默认 0). Arg2 = Gather 系统 统计 (默认 1). Arg3 = Gather 组件 统计 (默认 0). |
| `fx.PreventAllSystemRecompiles` | Loads 所有 的 该 systems 在 该 项目 和 forces 每个 系统 到 refresh 所有 它's 依赖 so 它 won't recompile 在 加载. 此 可能 mark 多个 资产 dirty 用于 re-saving. |
| `fx.PreventSystemRecompile` | Forces 该 系统 到 refresh 所有 它's 依赖 so 它 won't recompile 在 加载. 此 可能 mark 多个 资产 dirty 用于 re-saving. |
| `fx.PSCMan.Dump` | 转储 状态 信息 用于 所有 当前 Particle 系统 管理器. |
| `fx.RebuildDirtyScripts` | Go 通过 所有 已加载 资产 和 force 它们 到 recompute 它们的 脚本 哈希. 如果 dirty, regenerate. |
| `FX.RestartAll` | Restarts 所有 particle 系统 组件 |
| `fx.TestCompileNiagaraScript` | Compiles 该 指定 脚本 在 磁盘 用于 该 niagara vector vm |
| `fx.UpgradeAllNiagaraAssets` | Loads 所有 Niagara 资产 和 preforms 任何 数据 upgrade 流程 必需. 此 可能 mark 多个 资产 dirty 用于 re-saving. |
| `GameplayMediaEncoder.Initialize` | Constructs 该 音频/video encoding 对象. 执行 不 开始 encoding |
| `GameplayMediaEncoder.Shutdown` | Releases 所有 systems. |
| `GameplayMediaEncoder.Start` | Starts encoding |
| `GameplayMediaEncoder.Stop` | Stops encoding |
| `GameplayTags.DumpTagList` | 写入 输出 a csvs 使用 所有 标签 到 报告/TagList.CSV, 报告/TagReferencesList.CSV 和 报告/TagSourcesList.CSV |
| `GameplayTags.PackingTest` | Prints 频率 的 Gameplay 标签 |
| `GameplayTags.PrintNetIndices` | Prints net indices 用于 所有 已知 标签 |
| `GameplayTags.PrintReplicationFrequencyReport` | Prints 该 频率 每个 标签 是 已复制. |
| `GameplayTags.PrintReplicationIndicies` | Prints 该 索引 分配 到 每个 标签 用于 快速 网络 复制. |
| `GameplayTags.PrintReport` | Prints 频率 的 Gameplay 标签 |
| `gc.CalculateHistorySize` |  |
| `gc.DebugGraphHide` | Hide GC 调试 图表. |
| `gc.DebugGraphShow` | 显示 GC 调试 图表. (参见 还: DebugGraphSafeDurationThresholdMs) |
| `gc.DumpMemoryStats` | Print GC 内存 用法 |
| `gc.DumpRefsToCluster` | 转储 references 到 所有 对象 内部 a 集群. Specify 该 集群 名称 使用 根=名称. |
| `gc.DumpSchemaStats` | Print GC Schema 统计信息 |
| `gc.FindStaleClusters` | 转储 所有 集群 do 输出 日志 该 为 不 referenced 通过 anything. |
| `gc.GenerateReachabilityStressData` | Allocate deeply-nested UObject tree 到 stress 测试 reachability analysis. |
| `gc.HistorySize` |  |
| `gc.ListClusters` | 转储 所有 集群 do 输出 日志. 当 'Hiearchy' 参数 是 指定 lists 所有 对象 内部 集群. |
| `gc.SuggestClusters` | Searches 用于 资产 其 contain 许多 内部 对象 其 为 不 clustered. |
| `gc.UnlinkReachabilityStressData` | Unlink previously-生成 reachability analysis stress 测试 数据 用于 集合 在 该 下一个 循环. |
| `gdt.Enable` | 启用 Gameplay Debugger 工具 |
| `gdt.EnableCategoryName` | 启用/禁用 类别 匹配 给定 substring. 使用: gdt.EnableCategoryName [启用] |
| `gdt.fontsize` | Configures Gameplay debugger's font 大小. 用法: gdt.fontsize (默认 = 10) |
| `gdt.SelectLocalPlayer` | Selects 该 本地 玩家 用于 调试 |
| `gdt.SelectNextRow` | Selects 下一个 row |
| `gdt.SelectPreviousRow` | Selects 之前的 row |
| `gdt.Toggle` | 切换 Gameplay Debugger 工具 |
| `gdt.ToggleCategory` | 切换 特定 类别 索引 |
| `geomcache.TriggerBulkDataCrash` | 测试 a 崩溃 searializing 大型 bulk 数据 对象 |
| `geometry.DynamicMesh.ClearDebugMeshes` | Discard 所有 调试 网格体 当前 存储 在 该 FDynamicMesh3 全局 调试 网格体 设置. 此 命令 仅 works 在 该 编辑器. |
| `GeometryCollection.BuildProximityDatabase` | 构建 该 Proximity 信息 在 该 GeometryGroup 用于 该 选中 集合. |
| `GeometryCollection.ClusterAlongYZPlane` | Debuigging 命令 到 split 该 unclustered 几何体 集合 along 该 YZPlane. |
| `GeometryCollection.CreateFromSelectedActors` | 创建 a GeometryCollection 从 该 选中 Actor 该 contain Skeletal 和 Statict 网格体 组件 |
| `GeometryCollection.CreateFromSelectedAssets` | 创建 a GeometryCollection 从 该 选中 Skeletal 网格体 和 静态网格体 资产 |
| `GeometryCollection.DeleteCoincidentVertices` | 删除 coincident vertices 在 a GeometryCollection. 警告: 该 集合 可以 是 非常 大型. |
| `GeometryCollection.DeleteGeometry` | 删除 几何体 通过 变换 名称. |
| `GeometryCollection.DeleteHiddenFaces` | 删除 隐藏 faces 在 a GeometryCollection. 警告: 该 集合 可以 是 非常 大型. |
| `GeometryCollection.DeleteStaleVertices` | 删除 stale vertices 在 a GeometryCollection. 警告: 该 集合 可以 是 非常 大型. |
| `GeometryCollection.DeleteZeroAreaFaces` | 删除 零 area faces 在 a GeometryCollection. 警告: 该 集合 可以 是 非常 大型. |
| `GeometryCollection.Heal` | Tries 到 fill holes 在 go. |
| `GeometryCollection.PrintDetailedStatistics` | Prints 详细 统计信息 的 该 内容 的 该 集合. |
| `GeometryCollection.PrintDetailedStatisticsSummary` | Prints 详细 统计信息 的 该 内容 的 该 选中 集合(s). |
| `GeometryCollection.PrintStatistics` | Prints 统计信息 的 该 内容 的 该 集合. |
| `GeometryCollection.SelectAllGeometry` | 选择 所有 几何体 在 层级. |
| `GeometryCollection.SelectInverseGeometry` | Deselect inverse 的 当前 选中 几何体 在 层级. |
| `GeometryCollection.SelectLessThenVolume` | 选择 所有 几何体 使用 a volume less 比 指定. |
| `GeometryCollection.SelectNone` | Deselect 所有 几何体 在 层级. |
| `GeometryCollection.SetNamedAttributeValues` | 命令 到 设置 属性 内部 a 命名 组. |
| `GeometryCollection.SetupNestedBoneAsset` | Converts 该 选中 GeometryCollectionAsset 到 a 测试 资产. |
| `GeometryCollection.SetupTwoClusteredCubesAsset` | Addes 两个 clustered cubes 到 该 选中 Actor. |
| `GeometryCollection.ToString` | 转储 该 内容 的 该 集合 到 该 日志 文件. 警告: 该 集合 可以 是 非常 大型. |
| `GeometryCollection.WriteToHeaderFile` | 转储 该 内容 的 该 集合 到 a header 文件. 警告: 该 集合 可以 是 非常 大型. |
| `GeometryCollection.WriteToOBJFile` | 转储 该 内容 的 该 集合 到 一个 OBJ 文件. 警告: 该 集合 可以 是 非常 大型. |
| `GPUDebugCrash` | 崩溃 GPU intentionally 用于 调试. |
| `grass.DumpExclusionBoxes` | Print 该 exclusion boxes, 调试. |
| `grass.DumpGrassData` | Dumps a report of all grass data being currently used on landscape components. [Optional: `-csv -detailed -byproxy -bycomponent -bygrasstype -full`] `-csv`: formats the report in a CSV-friendly way. `-fullnames`: displays the listed objects' full names, rather than the user-friendly version. `-showempty`: will dump info even from components with no grass data. `-detailed`: shows a detailed report of all grass data, for all grass types, in all landscape components. `-byproxy`: shows a report of grass data per landscape proxy. `-bycomponent`: shows a report of grass data per landscape component. `-bygrasstype`: shows a report of grass data per grass type. `-full`: enables all sub-reports. If no report type option specified, assume full report is requested. |
| `grass.FlushCache` | Flush 该 草地 缓存, 调试. |
| `grass.FlushCachePIE` | Flush 该 草地 缓存, 调试. |
| `help` | Outputs 一些 helptext 到 该 控制台 和 该 日志 |
| `HighlightRecorder.Pause` | Pauses 录制 的 高亮 片段 |
| `HighlightRecorder.Resume` | Resumes 录制 的 高亮 片段 |
| `HighlightRecorder.Save` | Saves 高亮 片段, 可选 参数: filename (测试.mp4 通过 默认) 和 最大 持续时间 (浮点 (secs) 持续时间 的 ring 缓冲区 通过 默认) |
| `HighlightRecorder.Start` | Starts 录制 的 高亮 片段, 可选 参数: 最大 持续时间 (浮点, 30 秒 通过 默认) |
| `HighlightRecorder.Stop` | Stops 录制 的 高亮 片段 |
| `HighResShot` | High resolution screenshots. Usage: `HighResShot ResolutionX(int32)xResolutionY(int32) Or Magnification(float) [CaptureRegionX(int32) CaptureRegionY(int32) CaptureRegionWidth(int32) CaptureRegionHeight(int32) MaskEnabled(int32) DumpBufferVisualizationTargets(int32) CaptureHDR(int32)]`. Example: `HighResShot 500x500 50 50 120 500 1 1 1` |
| `Ias.AbandonCache` | Abandon 该 本地 文件 缓存 |
| `Input.+action` | 提供 该 命名 操作 使用 a constant 输入 值 每个 帧 |
| `Input.+key` | 提供 该 命名 键 使用 a constant 输入 值 每个 帧 |
| `Input.-action` | Stop forcing 该 命名 操作 值 每个 帧 |
| `Input.-key` | Stop forcing 该 命名 键 每个 帧 |
| `Input.ListAllHardwareDevices` | 日志 所有 该 平台's 当前 可用 FHardwareDeviceIdentifier |
| `ism.Editor.DumpISMPartitionActors` | 输出 统计 关于 ISMPartitionActor(s) |
| `Landscape.ClearDirty` | Clears 所有 地形 Dirty 调试 数据 |
| `landscape.DumpLODs` | 将 转储 该 当前 状态 的 LOD 值 和 当前 纹理 流式传输 状态 |
| `Landscape.FixSplines` | 一个 关闭 修复 用于 bad 图层 width |
| `Landscape.Patches` | 显示/hide 地形 patches |
| `Landscape.Static` | 启用/禁用 地形 static drawlists |
| `LazyLoad.PrintUnresolvedObjects` | Prints a 列表 的 所有 unresolved 对象 从 该 对象 处理 索引. |
| `LevelEditor.ToggleImmersive` | 切换 'Immersive 模式' 用于 该 激活 关卡 editing 视口 |
| `ListTimers` |  |
| `LiveCoding` | 启用 实时 coding 支持 |
| `LiveCoding.Compile` | Initiates a 实时 coding compile |
| `LLMSnapshot` | Takes a 单个 LLM Snapshot 的 一个 帧. 此 命令 需要 该 commandline -llmdisableautopublish |
| `LoadPackage` | Loads packages 通过 名称. 用法: LoadPackage [ ...] |
| `LoadPackageAsync` | Loads packages 异步 通过 名称. 用法: LoadPackageAsync [ ...] |
| `LoadTimes.DumpReport` | 转储 a 报告 关于 该 数量 的 时间 消耗 loading 资产 |
| `LoadTimes.DumpTracking` | 转储 高 关卡 加载 次数 正在 跟踪 |
| `LoadTimes.DumpTrackingLow` | 转储 低 关卡 加载 次数 正在 跟踪 |
| `LoadTimes.Reset` | Resets accumulated 报告 数据 |
| `LoadTimes.ResetTracking` | Reset 加载 时间 跟踪 |
| `LoadTimes.StartAccumulating` | Starts capturing 精细-grained accumulated 加载 时间 数据 |
| `LoadTimes.StopAccumulating` | Stops capturing 精细-grained accumulated 加载 时间 数据 和 转储 该 结果 |
| `Localization.DumpLiveTable` | 转储 该 当前 实时 table 状态 到 该 日志, optionally filtering 它 基于 在 wildcard 参数 用于 '命名空间', '键', 或 'DisplayString', eg) -键=Foo, 或 -DisplayString=此 是 一些 文本", 或 -键=Bar*Baz -DisplayString="此 是 一些 其他 文本"" |
| `LogCountedInstances` | 转储 数量 的 所有 跟踪 FInstanceCountingObject's |
| `ls.PrintNumLandscapeShadows` | Prints 该 数量 的 地形 组件 该 cast shadows. |
| `MainFrame.ToggleFullscreen` | 切换 该 编辑器 之间 完整 screen" 模式 和 "法线" 模式. 在 完整 screen 模式 该 任务 bar 和 窗口 title area 为 隐藏." |
| `mallocleak.clear` | Clears recorded 分配 信息 |
| `mallocleak.report` | 写入 malloc leak 报告 |
| `mallocleak.start` | Starts 跟踪 分配. Args -报告=[secs] -大小=[筛选] |
| `mallocleak.stop` | Stops 跟踪 分配 |
| `MallocStomp.OverrunTest` | Overrun 测试 用于 该 FMallocStomp |
| `MallocStomp2.Disable` | 禁用 MallocStomp2 |
| `MallocStomp2.Enable` | 启用 MallocStomp2 |
| `MallocStomp2.MaxSize` | 设置 该 最大 大小 MallocStomp2 应 轨道 |
| `MallocStomp2.MinSize` | 设置 该 最小 大小 MallocStomp2 应 轨道 |
| `MallocStomp2.OverrunTest` | Overrun 测试 用于 该 FMallocStomp2 |
| `MappedFileTest` | Tests 该 文件 mappings 通过 该 低 关卡. |
| `Memory.StaleTest` | 测试 用于 内存.UsePurgatory. *** 将 崩溃 该 游戏! |
| `Memory.UsePoison` | 使用 该 poison malloc 代理 到 检查 如果 things 为 relying 在 uninitialized 或 空闲'd 内存. |
| `Memory.UsePurgatory` | 使用 该 purgatory malloc 代理 到 检查 如果 things 为 写入 到 stale pointers. |
| `merge` | 任一 合并 three 资产 或 a 单个 conflicted 资产. 格式: '合并 [-o out_path]' 或 '合并 [-o out_path]' |
| `MessageBus.UDP.ClearDenyList` | Clear 该 UDP socket deny 列表. |
| `Metadata.Dump` | 转储 所有 元数据 |
| `net.ActorReport` |  |
| `Net.CreateBandwidthGenerator` |  |
| `net.DeleteDormantActor` | Lists 打开 Actor 通道 |
| `net.DisconnectSimulatedConnections` | Disconnects 一些 模拟 连接 (0 = 所有) |
| `net.DumpRelevantActors` | 转储 信息 在 相关 Actor 期间 下一个 网络 更新 |
| `net.ForceOnePacketPerBunch` | 当 设置 到 true 它 将 启用 AutoFlush 在 所有 连接 和 force a 数据包 到 是 发送 用于 每个 bunch we 创建. 此 forces 一个 数据包 每个 已复制 Actor 和 可以 帮助 找到 rare ordering bugs |
| `Net.GenerateConstantBandwidth` | Deliver a constant throughput 每个 tick 到 生成 该 指定 Kilobytes 每个 sec. 用法: Net.GenerateBandwidth KilobytesPerSecond |
| `Net.GeneratePeriodicBandwidthSpike` | Generates a spike 的 bandwidth 每个 X milliseconds. 用法: Net.GeneratePeriodicBandwidthSpike SpikeInKb PeriodInMS |
| `Net.Iris.DebugNetInternalIndex` | Specify 一个 内部 索引 该 we 将 拆分 在 (或 none 到 turn 关闭). |
| `Net.Iris.DebugNetRefHandle` | Specify a NetRefHandle ID 该 we 将 拆分 在 (或 none 到 turn 关闭). |
| `Net.Iris.PrintAlwaysRelevantObjects` | Prints 该 列表 的 netobjects 始终 相关 到 每个 连接 |
| `Net.Iris.PrintDynamicFilterClassConfig` | Prints 该 动态 筛选 已配置 到 是 分配 到 特定 类. |
| `Net.Iris.PrintNetCullDistances` | Prints 该 列表 的 已复制 对象 和 它们的 当前 netculldistance. |
| `Net.Iris.PrintRelevantObjects` | Prints 该 列表 的 netobjects 当前 相关 到 任何 连接 |
| `Net.Iris.PrintRelevantObjectsToConnection` | Prints 该 列表 的 已复制 对象 相关 到 a 特定 连接. OptionalParams: WithFilter |
| `Net.Iris.PrintReplicatedObjects` | Prints 该 列表 的 已复制 对象 注册 用于 复制 在 Iris |
| `net.ListActorChannels` | Lists 打开 Actor 通道 |
| `net.ListNetGUIDExports` | Lists 打开 Actor 通道 |
| `net.ListNetGUIDs` | Lists NetGUIDs 用于 Actor |
| `net.Packagemap.FindNetGUID` | Looks 上 对象 该 曾 分配 a 给定 NetGUID |
| `net.PrintNetConnections` | Prints 信息 在 所有 net 连接 的 a NetDriver. 默认值 到 该 GameNetDriver. 选择 a 不同 驱动 通过 NetDriverName= 或 NetDriverDefinition= |
| `Net.PushModelPrintHandles` | Prints 该 列表 的 已复制 对象 相关 到 a 特定 连接 |
| `net.SimulateConnections` | Starts a 模拟 Net 驱动 |
| `net.TestObjRefSerialize` | Attempts 到 复制 一个 对象 引用 到 所有 客户端 |
| `NetEmulation.DropAnyUnreliable` | 丢弃 任何 发送 不可靠 RPCs. (可选)<0-100> 到 设置 该 丢弃 percentage (默认 是 20). |
| `NetEmulation.DropNothing` | 禁用 任何 RPC 丢弃 设置 previously 设置. |
| `NetEmulation.DropUnreliableOfActorClass` | 丢弃 random 不可靠 RPCs 发送 在 Actor 的 该 给定 类 类型. 类 名称 到 匹配 使用 (可以 是 a substring). (可选)<0-100> 到 设置 该 丢弃 percentage (默认 是 20). |
| `NetEmulation.DropUnreliableOfSubObjectClass` | 丢弃 randomly 该 不可靠 RPCs 的 a subobject 的 该 给定 类. 该 名称 的 该 RPC (可以 是 a substring). (可选)<0-100> 到 设置 该 丢弃 percentage (默认 是 20). |
| `NetEmulation.DropUnreliableRPC` | 丢弃 randomly 该 不可靠 RPCs 的 该 给定 名称. 该 名称 的 该 RPC (可以 是 a substring). (可选)<0-100> 到 设置 该 丢弃 percentage (默认 是 20). |
| `NetEmulation.Off` | Turn 关闭 网络 模拟 |
| `NetEmulation.PktDup` | Simulates 发送/接收 duplicate 网络 packets |
| `NetEmulation.PktEmulationProfile` | 应用 a preconfigured 模拟 分析. |
| `NetEmulation.PktIncomingLagMax` | 设置 最大 传入 数据包 延迟 |
| `NetEmulation.PktIncomingLagMin` | 设置 最小 传入 数据包 延迟 |
| `NetEmulation.PktIncomingLoss` | Simulates 传入 数据包 loss |
| `NetEmulation.PktJitter` | Simulates outgoing 数据包 jitter |
| `NetEmulation.PktLag` | Simulates 网络 数据包 lag |
| `NetEmulation.PktLagMax` | 设置 最大 outgoing 数据包 延迟) |
| `NetEmulation.PktLagMin` | 设置 最小 outgoing 数据包 延迟 |
| `NetEmulation.PktLagVariance` | Simulates 变量 网络 数据包 lag |
| `NetEmulation.PktLoss` | Simulates 网络 数据包 loss |
| `NetEmulation.PktOrder` | Simulates 网络 packets 接收 输出 的 顺序 |
| `NetTrace.SetTraceVerbosity` | 开始 NetTrace 使用 给定 verbositylevel. |
| `NiagaraDebugHud` | Shorter 版本 到 quickly 切换 调试 hud 模式 No 值 将 切换 该 概述 在 / 关闭 A numberic 值 selects 其 overmode 到 设置, 位置 0 是 关闭 |
| `NiagaraReportSystemMemory` | 转储 一些 rough 信息 关于 系统 内存 breakdown |
| `online.ResetAchievements` | Reset achievements 用于 该 当前 logged 在 用户. |
| `p.chaos.dumphierarcystats` | Outputs 当前 collision 层级 统计 到 该 输出 日志 |
| `p.Chaos.StartVDRecording` | Turn 在 该 录制 的 调试 数据 |
| `p.Chaos.StopVDRecording` | Turn 关闭 该 录制 的 调试 数据 |
| `p.Chaos.VD.SetCVDDataChannelEnabled` | Turn 在 或 关闭 a CVD 数据 通道. 参数 1 是 true 或 false, 参数 是 a 逗号 分隔 列表 的 通道 名称. 示例: p.Chaos.VD.SetCVDDataChannelEnabled true SceneQueries,Integrate |
| `p.Chaos.VD.SpawnNewCVDInstance` | Opens a 新增 CVD 窗口 wothout closing 一个 现有 一个 |
| `p.ChaosCloth.Ispc` | 启用 或 禁用 ISPC optimizations 用于 cloth simulation. |
| `p.DumpPhysicalMaterialMaskData` | Outputs 该 当前 mask 数据 用于 该 指定 physical 材质 mask 资产 到 该 日志. |
| `PackageName.ConvertFilenameToLongPackageName` | Prints 该 对应 packagename 用于 a filename 在 a 给定 localpath, 根据 到 该 当前 注册 挂载 points. Prints 空 字符串 如果 不 mounted. |
| `PackageName.ConvertLongPackageNameToFilename` | Prints 该 对应 本地 filename 用于 a 给定 packagename, 根据 到 该 当前 注册 挂载 points. Prints 空 字符串 如果 不 mounted. |
| `PackageName.DumpMountPoints` | Print 注册 LongPackagePath 挂载 points |
| `PackageName.RegisterMountPoint` | // Register a LongPackagePath 挂载 点 |
| `PackageName.UnregisterMountPoint` | // 移除 a LongPackagePath 挂载 点 |
| `PackageTools.ReloadPackage` | Force a reload 的 该 命名 包, e.g. PackageTools.ReloadPackage /游戏/MyAsset |
| `pak.AsyncFileTest` | 读取 a 块 的 数据 从 a 文件 使用 一个 AsyncFileHandle. params: |
| `pak.TestRegisterEncryptionKey` | 测试 动态 encryption 键 注册. params: |
| `PakFileTest` | Tests 该 低 关卡 文件系统 通过 mounting a pak 文件 和 doing multithreaded loads 在 它 forever. Arg 应 是 a 完整 路径 到 a pak 文件. |
| `PersistentStorageCategoryStats` | 获取 该 stat 的 每个 persistent 存储 统计 |
| `r.AOListMemory` |  |
| `r.AOListMeshDistanceFields` |  |
| `r.CopyLockedViews` | Copies 所有 locked views 在 到 a 字符串 该 r.LockView 将 accept 到 reload 它们. |
| `r.DumpBufferPoolMemory` | 转储 分配 信息 用于 该 缓冲区 池. |
| `r.DumpPipelineCache` | 转储 当前 缓存 统计. |
| `r.DumpRenderTargetPoolMemory` | 转储 分配 信息 用于 该 渲染 目标 池. |
| `r.DumpShadows` | 转储 shadow setup (用于 开发者 仅, 仅 用于 non shiping 构建) |
| `r.FlushMaterialUniforms` |  |
| `r.HLOD` | 单个 参数: 0 或 1 到 禁用/启用 HLOD 系统 多个 参数: force X 位置 X 是 该 HLOD 关卡 该 应 是 forced 到 视图 |
| `r.HLOD.ListUnbuilt` | Lists 所有 unbuilt HLOD Actor 在 该 世界 |
| `r.InvalidateCachedShaders` | Invalidate shader 缓存 通过 making a 唯一 更改 到 ShaderVersion.ush 其 是 包含 在 通用.usf.到 initiate actual 该 recompile 的 所有 shaders 使用 recompileshaders changed" 或 press "Ctrl Shift .". 该 ShaderVersion.ush 文件 应 是 自动 检查 输出 但是 它 需要 到 是 检查 在 到 具有 effect 在 其他 机器." |
| `r.ListSceneColorMaterials` | Lists 所有 材质 该 读取 从 场景 颜色. |
| `r.MeshDrawCommands.DumpStats` | 转储 所有 的 该 网格体 Draw 命令 统计 用于 a 单个 帧 到 a CSV 文件 在 该 保存 分析 目录. |
| `r.RayTracing.UpdateCachedState` | 更新 cached ray 追踪 状态 (网格体 命令 和 实例). |
| `r.RecompileRenderer` | Recompiles 该 renderer module 在 该 fly. |
| `r.RecreateRenderStateContext` | Recreate 渲染 状态. |
| `r.ResetRenderTargetsExtent` | 到 reset 内部 渲染 目标 extents |
| `r.ResetViewState` | Reset 一些 状态 (e.g. TemporalAA 索引) 到 使 渲染 更多 deterministic (用于 automated screenshot verification) |
| `r.RHI.Name` | 显示 当前 RHI's 名称 |
| `r.RHISetGPUCaptureOptions` | Utility 函数 到 更改 多个 CVARs useful 当 profiling 或 调试 GPU 渲染. 设置 到 1 或 0 将 guarantee 所有 选项 为 在 该 适当 状态. r.rhithread.启用, r.rhicmdbypass, r.showmaterialdrawevents, toggledrawevents 平台 RHI's 可能 implement 更多 feature 切换. |
| `r.RHIThread.Enable` | 启用/禁用 该 RHI 线程 和 确定 如果 该 RHI 工作 运行 在 a dedicated 线程 或 不. |
| `r.SceneCapture.DumpMemory` | 编辑器 特定 命令 到 转储 场景 capture 内存 到 日志 |
| `r.SetFramePace` | 设置 a 目标 帧 速率 用于 该 帧 pacer.到 设置 30fps: r.SetFramePace 30"" |
| `r.SetNearClipPlane` | 设置 该 near clipping plane (在 cm) |
| `r.ShaderCompiler.PrintStats` | Prints 输出 到 该 日志 该 统计 用于 该 shader compiler. |
| `r.ShaderPipelineCache.Close` | Close 该 当前 管线 文件 缓存. |
| `r.ShaderPipelineCache.Open` | Close 和 reopen 该 用户 缓存. |
| `r.ShaderPipelineCache.Save` | 保存 该 当前 管线 文件 缓存. |
| `r.ShaderPipelineCache.SetBatchMode` | 设置 该 compilation 批处理 模式, 其 应 是 一个 的: Pause: Suspend precompilation. 后台: 低 优先级 precompilation. 快速: 高 优先级 precompilation. |
| `r.Shadow.Virtual.Visualize.DumpLightNames` | 转储 light 名称 使用 虚拟 shadow maps (用于 开发者 使用 在 non-shipping 构建) |
| `r.SkylightRecapture` | 更新 所有 stationary 和 movable skylights, useful 用于 调试 该 capture 管线 |
| `r.TextureProfiler.DumpRenderTargets` | 转储 所有 渲染 targets allocated 通过 该 RHI. 参数: -CombineTextureNames Combines 所有 纹理 的 该 相同 名称 到 a 单个 行 的 输出 -CSV Produces CSV 就绪 输出 |
| `r.TextureProfiler.DumpTextures` | 转储 所有 纹理 allocated 通过 该 RHI. 执行 不 包括 渲染 targets 参数: -CombineTextureNames Combines 所有 纹理 的 该 相同 名称 到 a 单个 行 的 输出 -CSV Produces CSV 就绪 输出 |
| `r.TogglePreCulledIndexBuffers` | 切换 使用 的 preculled 索引 buffers 从 该 命令 'PreCullIndexBuffers' |
| `r.VT.Dump` | 转储 a 整个 lot 的 信息 在 该 VT 系统 状态. |
| `r.VT.DumpPoolUsage` | 转储 详细 信息 关于 VT 池 用法. |
| `r.VT.Flush` | Flush 所有 该 physical caches 在 该 VT 系统. |
| `r.VT.FlushAndEvictFileCache` | Flush 两者 该 虚拟 纹理 physcial 页面 缓存 和 磁盘 文件 缓存 |
| `r.VT.ListPhysicalPools` | 转储 a 整个 lot 的 信息 在 该 VT 系统 状态. |
| `r.VT.SaveAllocatorImages` | 保存 images showing allocator 用法. |
| `r.VT.ShowDecodeErrors` | 高亮 虚拟 纹理 使用 decode errors 在 hot pink. |
| `Reattach.Components` | Useful 用于 调试, reattaches 所有 组件. 参数 需要 到 是 该 类 名称. 示例: Reattach.组件 类=SkeletalMeshComponent |
| `Reattach.MaterialInstances` | Useful 用于 调试, reattaches 所有 材质. 可选 参数 可以 是 a materialinstance 名称 (e.g. DecoStatue_Subsurface0). |
| `Reattach.Materials` | Useful 用于 调试, reattaches 所有 材质. 可选 参数 可以 是 a 材质 名称 (e.g. DecoStatue_Subsurface0_Inst). |
| `RedirectCollector.ResolveAllSoftObjectPaths` | Attempts 到 加载 / 解决 所有 当前 referenced Soft 对象 路径 |
| `RedirectToFile` | 创建 a 文件 内部 项目's 保存 文件夹 和 outputs 命令 结果 到 它 作为 良好 作为 到 该 日志. 用法: RedirectToFile [命令 参数] 示例: RedirectToFile Profiling/CSV/objlist.CSV obj 列表 -CSV -所有 目录 结构 下方 项目/保存 文件夹 指定 通过 将 是 创建 用于 你 如果 它 doesn't exist. |
| `ReferenceInfo` | Outputs 引用 信息 用于 选中 Actor 到 a 日志 文件. Syntax 是: ReferenceInfo [-depth=] [-nodefault] [-noscript] |
| `ReloadGlobalShaders` | Reloads 该 全局 shaders 文件 |
| `rhi.DumpMemory` | 转储 RHI 内存 统计 到 该 日志 |
| `rhi.DumpResourceCounts` | 转储 RHI 资源 counts 到 该 日志 |
| `rhi.DumpResourceMemory` | 转储 RHI 资源 内存 统计 到 该 日志 用法: rhi.DumpResourceMemory [] [所有] [概要] [名称=] [类型=] [Transient= [csv] |
| `RunTask` |  |
| `SequenceRecorder` | 启用 该 序列 Recorder 标签页 |
| `SetGlobalShaderCacheOverrideDirectory` | 设置 该 目录 到 读取 该 覆盖 全局 shader 映射 文件 从. |
| `SetThreadConfig` | 设置 a 线程 优先级 和/或 Affinity. A 单个 arg 的 默认 resets 所有 该 线程 Priorities 和 Affinities, otherwise [GT,RT,RHI,任务,TaskBP] 两者/任一 [TPri_type] [0x] 设置 该 优先级 和/或 Affinity. |
| `ShrinkUObjectHashTables` | Shrinks 所有 的 该 UObject 哈希 tables. |
| `Slate.Commands.ListAll` |  |
| `Slate.Commands.ListBound` |  |
| `Slate.DeleteResources` | Flushes 和 deletes 所有 资源 创建 通过 Slate's RHI 资源 管理器. |
| `Slate.DumpUpdateList` | (已弃用) 使用 Slate.InvalidationRoot.DumpUpdateListOnce |
| `Slate.Navigation.Simulate` | Log the result of what the widget may do when it received a navigation event. Use: `Slate.Navigation.Simulate Widget=0x00AABBCCDD Navigation=UINavigationIndex [UserIndex=Number] [Genesis=NavigationGenesisIndex]`. UINavigationIndex use: 0 for Left, 1 for Right, 2 for Up, 3 for Down, 4 for Next, 5 for Previous. NavigationGenesisIndex use: 0 for Keyboard, 1 for Controller, 2 for User. |
| `Slate.TestMessageDialog` |  |
| `Slate.TestMessageLog` |  |
| `Slate.TestNotifications` |  |
| `Slate.TestProgressNotification` |  |
| `Slate.TriggerInvalidate` | 触发器 a 全局 invalidate 的 所有 Widget |
| `SlateDebugger.Break.OnWidgetBeginPaint` | Break before the widget get painted (must be attached to a debugger). Usage: `[WidgetPtr=0x1234567]\\\|[WidgetId=12345]` |
| `SlateDebugger.Break.OnWidgetEndPaint` | Break after the widget got painted (must be attached to a debugger). Usage: `[WidgetPtr=0x1234567]\\\|[WidgetId=12345]` |
| `SlateDebugger.Break.OnWidgetInvalidation` | Break when the widget get invalidated (must be attached to a debugger). Usage: `[WidgetPtr=0x1234567]\\\|[WidgetId=12345] [Reason=Paint\\\|Volatility\\\|ChildOrder\\\|RenderTransform\\\|Visibility\\\|AttributeRegistration\\\|Prepass\\\|All]` |
| `SlateDebugger.Break.RemoveAll` | 移除 所有 请求 到 拆分. |
| `SlateDebugger.Event.DisableAllFocusFilters` | 禁用 所有 focus 筛选器 |
| `SlateDebugger.Event.DisableAllInputFilters` | 禁用 所有 输入 筛选器 |
| `SlateDebugger.Event.EnableAllFocusFilters` | 启用 所有 focus 筛选器 |
| `SlateDebugger.Event.EnableAllInputFilters` | 启用 所有 输入 筛选器 |
| `SlateDebugger.Event.SetFocusFilter` | 启用 或 禁用 特定 focus 筛选器 |
| `SlateDebugger.Event.SetInputFilter` | 启用 或 禁用 特定 输入 筛选器 |
| `SlateDebugger.Event.Start` | Starts 该 debugger. |
| `SlateDebugger.Event.Stop` | Stops 该 debugger. |
| `SlateDebugger.Invalidate.SetInvalidateRootReasonFilter` | Enable Invalidate Root Reason filters. Usage: `SetInvalidateRootReasonFilter None\\\|ChildOrder\\\|Root\\\|ScreenPosition\\\|Any` |
| `SlateDebugger.Invalidate.SetInvalidateWidgetReasonFilter` | Enable Invalidate Widget Reason filters. Usage: `SetInvalidateWidgetReasonFilter None\\\|Layout\\\|Paint\\\|Volatility\\\|ChildOrder\\\|RenderTransform\\\|Visibility\\\|Any` |
| `SlateDebugger.Invalidate.Start` | 开始 该 Invalidation Widget 调试 工具. 它 显示 Widget 该 为 invalidated. |
| `SlateDebugger.Invalidate.Stop` | Stop 该 Invalidation Widget 调试 工具. |
| `SlateDebugger.InvalidationRoot.Start` | 开始 该 Invalidation 根 Widget 调试 工具. 它 显示 当 Invalidation Roots 为 使用 该 slow 或 该 快速 路径. |
| `SlateDebugger.InvalidationRoot.Stop` | Stop 该 Invalidation 根 Widget 调试 工具. |
| `SlateDebugger.InvalidationRoot.ToggleLegend` | 选项 到 显示 该 颜色 legend. |
| `SlateDebugger.InvalidationRoot.ToggleWidgetNameList` | 选项 到 显示 该 名称 的 该 Invalidation 根. |
| `SlateDebugger.Paint.LogOnce` | 日志 该 名称 的 所有 Widget 该 曾 绘制 期间 该 最后 更新. |
| `SlateDebugger.Paint.Start` | 开始 该 绘制 Widget 调试 工具. 使用 到 显示 Widget 该 具有 已经 绘制 此 帧. |
| `SlateDebugger.Paint.Stop` | Stop 该 绘制 Widget 调试 工具. |
| `SlateDebugger.Paint.ToggleWidgetNameList` | 选项 到 显示 该 名称 的 该 Widget 该 具有 已经 绘制. |
| `SlateDebugger.Start` | 别名 到 'SlateDebugger.事件.开始'. |
| `SlateDebugger.Stop` | 别名 到 'SlateDebugger.事件.Stop'. |
| `SlateDebugger.Update.SetWidgetUpdateFlagsFilter` | 启用 或 禁用 特定 Widget 更新 标志 筛选器. 用法: SetWidgetUpdateFlagsFilter [None] [tick] [ActiveTimer] [Repaint] [VolatilePaint] [任何] |
| `SlateDebugger.Update.Start` | 开始 该 更新 Widget 调试 工具. 它 显示 当 Widget 为 已更新. |
| `SlateDebugger.Update.Stop` | Stop 该 更新 Widget 调试 工具. |
| `SlateDebugger.Update.ToggleLegend` | 选项 到 显示 该 颜色 legend. |
| `SlateDebugger.Update.ToggleUpdateFromPaint` | 选项 到 还 显示 该 Widget 该 do 不 具有 一个 更新 标志 但是 为 已更新 作为 a 端 effect 的 一个 其他 Widget. |
| `SlateDebugger.Update.ToggleWidgetNameList` | 选项 到 显示 该 名称 的 该 Widget 该 具有 已经 已更新. |
| `sm.DerivedDataTimings` | 转储 derived 数据 timings 到 该 日志. |
| `SparseDelegateReport` | Outputs a 报告 的 什么 sparse delegates 为 bound. SparseDelegateReport [名称=] [delegate=] [类=] -细节 |
| `spawnactortimer` | 允许 录制 的 spawn Actor 次数. |
| `StartWorkTest` |  |
| `Stat MapBuildData` |  |
| `stats.NamedEvents` | 启用 或 禁用 该 命名 事件. |
| `stats.VerboseNamedEvents` | 启用 或 禁用 该 Verbose 命名 事件. |
| `StopWorkTest` |  |
| `SynthBenchmark` | 运行 simple benchmark 到 获取 一些 指标 到 找到 reasonable 游戏 设置 自动 可选 (浮点) 参数 允许 到 缩放 使用 工作 数量 到 trade 时间 或 precision (默认: 10). |
| `TaskGraph.ABTestThreads` | Takes 两个 0/1 参数. Equivalent 到 设置 TaskGraph.UseHiPriThreads 和 TaskGraph.UseBackgroundThreads, respectively. Packages 作为 一个 命令 用于 使用 使用 该 abtest 命令. |
| `TaskGraph.Benchmark` | Prints 该 时间 到 运行 1000 no-op 任务. |
| `TaskGraph.NumWorkerThreadsToIgnore` | 用于 tune 该 数量 的 任务 线程. Generally 一次 你 具有 找到 该 右侧 值, PlatformMisc::NumberOfWorkerThreadsToSpawn() 应 是 hardcoded. |
| `TaskGraph.Randomize` | Useful 用于 调试, 添加 random sleeps throughout 该 任务 图表. |
| `TaskGraph.TaskThreadPriority` | 设置 该 优先级 的 该 任务 线程. 参数 是 一个 的 belownormal, 法线 或 abovenormal. |
| `TaskGraph.TestLockFree` | 测试 lock 空闲 lists |
| `TaskGraph.TestLowToHighPri` | 测试 延迟 的 高 优先级 任务 当 低 优先级 任务 为 saturating 该 CPU |
| `TextAssetTool` | -- |
| `TextureAtlasVisualizer` | 显示 该 Slate 纹理 atlas visualizer |
| `tick.AddIndirectTestTickFunctions` | 添加 no-op ticks 到 测试 性能 的 ticking infrastructure. |
| `tick.AddTestTickFunctions` | 添加 no-op ticks 到 测试 性能 的 ticking infrastructure. |
| `tick.RemoveTestTickFunctions` | 移除 no-op ticks 到 测试 性能 的 ticking infrastructure. |
| `TimecodeProvider.reset` | Resets 该 当前 timecode 提供者. |
| `TimedMemReport.Delay` | 决定 如何 长 到 等待 之前 获取 a memreport. < 0 是 关闭 |
| `ToggleForceDefaultMaterial` | 渲染 所有 网格体 使用 该 默认 材质. |
| `ToggleLight` | 切换 所有 灯光 whose 名称 包含 该 指定 字符串 |
| `ToggleReversedIndexBuffers` | 渲染 static 网格体 使用 负 变换 determinants 使用 a reversed 索引 缓冲区. |
| `ToggleShadowIndexBuffers` | 渲染 static 网格体 使用 一个 optimized shadow 索引 缓冲区 该 minimizes 唯一 vertices. |
| `ToolMenus.Edit` | Experimental: 启用 编辑 menus 模式 切换 在 关卡 编辑器's 窗口 菜单 |
| `ToolMenus.RefreshAllWidgets` | Refresh 所有 工具 菜单 Widget |
| `Trace.Bookmark` | [名称] - Emits a TRACE_BOOKMARK() 事件 使用 该 给定 字符串 名称. |
| `Trace.Disable` | [ChannelSet] - 禁用 a 设置 的 通道. ChannelSet 是 逗号-分隔 列表 的 追踪 通道/预设 到 是 禁用. 如果 no 通道 是 指定, 它 禁用 所有 通道. |
| `Trace.Enable` | [ChannelSet] - 启用 a 设置 的 通道. ChannelSet 是 逗号-分隔 列表 的 追踪 通道/预设 到 是 启用. |
| `Trace.File` | [路径] [ChannelSet] - Starts 追踪 到 a 文件. ChannelSet 是 逗号-分隔 列表 的 追踪 通道/预设 到 是 启用. 任一 路径 或 ChannelSet 可以 是 excluded. |
| `Trace.Pause` | Pauses 所有 追踪 通道 当前 发送 事件. |
| `Trace.Resume` | Resumes 追踪 该 曾 previously paused (re-启用 该 paused 通道). |
| `Trace.Screenshot` | [名称] [ShowUI] Takes a screenshot 和 saves 它 在 该 追踪. Ex: 追踪.Screenshot ScreenshotName true |
| `Trace.Send` | [ChannelSet] - Starts 追踪 到 a 追踪 存储. 是 该 IP address 或 hostname 的 该 追踪 存储. ChannelSet 是 逗号-分隔 列表 的 追踪 通道/预设 到 是 启用. |
| `Trace.SnapshotFile` | [路径] - 写入 a snapshot 的 该 当前 在-内存 追踪 缓冲区 到 a 文件. |
| `Trace.SnapshotSend` | - 发送 a snapshot 的 该 当前 在-内存 追踪 缓冲区 到 a 服务器. 如果 no host 是 指定 'localhost' 是 使用. |
| `Trace.Start` | [ChannelSet] - (已弃用: 使用 追踪.文件 改为.) Starts 追踪 到 a 文件. ChannelSet 是 逗号-分隔 列表 的 追踪 通道/预设 到 是 启用. |
| `Trace.Status` | Prints 追踪 状态 到 控制台. |
| `Trace.Stop` | Stops 追踪 profiling 事件. |
| `TraceFilter.FlushState` | Flushes 该 当前 追踪 filtering 状态 到 该 输出 日志. |
| `TrackAsyncLoadRequests.Dump` | 转储 跟踪 异步 加载 请求 和 reset 跟踪 |
| `TrackAsyncLoadRequests.DumpToFile` | 转储 跟踪 异步 加载 请求 和 reset 跟踪 |
| `TrackAsyncLoadRequests.Reset` | Reset 跟踪 异步 加载 请求 |
| `TriggerFailedWindowsRead` | Tests 低 关卡 IO errors 在 窗口 |
| `TypedElements.OutputRegistredTypeElementsToClipboard` | 输出 a 调试 字符串 到 该 clipboard 和 到 该 日志./n 它 包含 该 名称 的 该 Typed 元素 registred 和 它们的 Interfaces./n 用于 每个 Interface 它 还 提供 该 路径 的 该 类 该 implements 它. |
| `UAssetLoadTest` | Continuously 加载 资产 和 GC 在 该 backgroud. 调试 选项, 此 可能 或 可能 不 工作 使用 所有 资产. 该 测试 运行 forever. 如果 no arg 是 给定 所有 资产 在 /游戏/内容 为 scanned. |
| `ValidatePackagePayloads` | 检查 所有 payloads 该 a 包 references 和 makes 确保 该 它们 为 有效 |
| `VerifyPersistentStorageCategory` | VerifyPersistentStorageCategory |
| `VI.ForceMode` | 切换 视口 interaction 在 desktop |
| `Vis` | 短 版本 的 visualizetexture |
| `VisRT` | GUI 用于 visualizetexture |
| `VisualGraphUtils.ControlRig.TraverseHierarchy` | Traverses 该 层级 用于 a 给定 控制 绑定 |
| `VisualGraphUtils.Object.CollectReferences` | Traces 所有 references 的 一个 对象 |
| `VisualGraphUtils.Object.CollectTickables` | Traces 所有 tickables 的 一个 对象 |
| `VisualGraphUtils.Object.LogClassNames` | 记录 所有 类 路径 名称 给定 a partial 名称 |
| `VisualGraphUtils.Object.LogInstancesOfClass` | 记录 所有 实例 的 a 给定 类 |
| `VisualizeTexture` | 到 visualize 内部 纹理 |
| `voice.sendLocalTalkersToEndpoint` | 此 将 发送 音频 输出 用于 所有 outgoing voip 音频 到 该 命名 端点. 如果 给定 no 参数, 此 将 disconnect 所有 外部 endpoints. |
| `voice.sendRemoteTalkersToEndpoint` | 此 将 发送 音频 输出 用于 所有 传入 voip 音频 到 该 命名 端点. 如果 给定 no 参数, 此 将 route voice 输出 通过 该 游戏 引擎. |
| `VREd.ForceVRMode` | 切换 VREditorMode, even 如果 不 在 immersive VR |
| `VREd.ToggleDebugMode` | 切换 调试 模式 的 该 VR 模式 |
| `Widget.DumpTemplateSizes` | 转储 该 sizes 的 所有 Widget 类 模板 在 内存 |
| `WidgetReflector` | 显示 该 Slate Widget reflector |
| `WidgetReflector.TakeSnapshot` | 采用 a snapshot 和 保存 该 结果 在 该 本地 drive. ie. WidgetReflector.TakeSnapshot [Delay=1.0] [Navigation=false] |
| `WindowsApplication.ApplyLowLevelMouseFilter` | Applies 低 关卡 mouse 筛选 该 筛选器 输出 mouse 输入 该 act 例如 touch 输入 |
| `WindowsApplication.RemoveLowLevelMouseFilter` | Removes 低 关卡 mouse 筛选 该 筛选器 输出 mouse 输入 该 act 例如 touch 输入 |
| `WorldMetrics.SelfTest` | 切换 该 世界 指标 Subsystem 自身-测试. |
| `wp.Editor.DumpActorDesc` | 转储 a 特定 Actor descriptor 在 该 控制台. |
| `wp.Editor.DumpActorDescs` | 转储 该 列表 的 Actor descriptors 在 a CSV 文件. |
| `wp.Editor.DumpClassDescs` | 转储 该 列表 的 类 descriptors 在 a CSV 文件. |
| `wp.Editor.DumpStreamingGenerationLog` | 转储 该 流式传输 generation 日志. |
| `wp.Editor.HLOD.DumpStats` | 写入 various HLOD 统计 到 a CSV formatted 文件. |
| `wp.Editor.ToggleShowEditorProfiling` | 切换 showing 编辑器 profiling 统计. |
| `wp.Runtime.DebugFilterByCellName` | 筛选 调试 diplay 的 世界 分区 流式传输 通过 完整 或 partial cell 名称. Args [cell 名称] |
| `wp.Runtime.DebugFilterByDataLayer` | 筛选 调试 diplay 的 世界 分区 流式传输 通过 数据 图层. Args [datalayer 标签] |
| `wp.Runtime.DebugFilterByRuntimeHashGridName` | 筛选 调试 diplay 的 世界 分区 流式传输 通过 grid 名称. Args [grid 名称] |
| `wp.Runtime.DebugFilterByStreamingStatus` | 筛选 调试 diplay 的 世界 分区 流式传输 通过 流式传输 状态. Args [流式传输 状态] |
| `wp.Runtime.DrawWorldPartitionIndex` | 设置 该 索引 的 该 wanted partitioned 世界 到 显示 调试 draw. 设置 < 0 到 显示 调试 draw 所有 注册 partitioned worlds. |
| `wp.Runtime.DumpDataLayers` | 转储 数据 图层 到 该 日志 |
| `wp.Runtime.DumpStreamingSources` | 转储 激活 流式传输 源 到 该 日志 |
| `wp.Runtime.DumpWorldPartitions` | 转储 激活 世界 partitions 到 该 日志 |
| `wp.Runtime.HLOD` | Turn 在/关闭 loading & 渲染 的 世界 分区 HLODs. |
| `wp.Runtime.OverrideRuntimeSpatialHashLoadingRange` | 设置 运行时 loading range. Args -grid=[索引] -range=[override_loading_range] |
| `wp.Runtime.SetDataLayerRuntimeState` | 设置 运行时 DataLayers 状态. Args [状态 = Unloaded, 已加载, Activated] [DataLayerNames] |
| `wp.Runtime.SetLogWorldPartitionVerbosity` | 更改 该 WorldPartition 日志 verbosity. |
| `wp.Runtime.ToggleDataLayerActivation` | 切换 DataLayers 激活 状态. Args [DataLayerNames] |
| `wp.Runtime.ToggleDrawDataLayers` | 切换 调试 显示 的 激活 数据 图层. |
| `wp.Runtime.ToggleDrawDataLayersLoadTime` | 切换 调试 显示 的 激活 数据 图层 加载 时间. |
| `wp.Runtime.ToggleDrawLegends` | 切换 调试 显示 的 世界 分区 legends. |
| `wp.Runtime.ToggleDrawRuntimeCellsDetails` | 切换 调试 显示 的 世界 分区 运行时 流式传输 cells. |
| `wp.Runtime.ToggleDrawRuntimeHash2D` | 切换 2D 调试 显示 的 世界 分区 运行时 哈希. |
| `wp.Runtime.ToggleDrawRuntimeHash3D` | 切换 3D 调试 显示 的 世界 分区 运行时 哈希. |
| `wp.Runtime.ToggleDrawStreamingPerfs` | 切换 调试 显示 的 世界 分区 流式传输 perfs. |
| `wp.Runtime.ToggleDrawStreamingSources` | 切换 调试 显示 的 世界 分区 流式传输 源. |
