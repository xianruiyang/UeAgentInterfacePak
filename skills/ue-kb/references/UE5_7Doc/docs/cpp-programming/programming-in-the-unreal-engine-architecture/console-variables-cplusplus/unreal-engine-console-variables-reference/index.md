---
title: "控制台变量参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-console-variables-reference"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "虚幻架构", "控制台变量和命令", "控制台变量参考"]
---

# 控制台变量参考

> 路径：虚幻引擎5.7文档 / 用C++编程 / 虚幻架构 / 控制台变量和命令 / 控制台变量参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-console-variables-reference

## 动画

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `a.AccumulateLocalSpaceAdditivePose.ISPC` | `true` | 是否使用ISPC优化来累积局部空间叠加姿势 |
| `a.AnimNode.AimOffsetLookAt.Debug` | `0` | 切换LookAt AimOffset调试 |
| `a.AnimNode.AimOffsetLookAt.Enable` | `1` | 启用/禁用LookAt AimOffset |
| `a.AnimNode.ControlRig.Debug` | `0` | 设置为1可开启AnimNode_ControlRigBase的调试绘制 |
| `a.AnimNode.DeadBlending.Enable` | `1` | 启用/禁用DeadBlending |
| `a.AnimNode.HandIKRetargeting.Enable` | `true` | 启用/禁用手部IK重定向 |
| `a.AnimNode.Inertialization.Enable` | `1` | 启用/禁用惯性化 |
| `a.AnimNode.Inertialization.IgnoreDeficit` | `0` | 忽略由中断引起的惯性化时间缺陷 |
| `a.AnimNode.Inertialization.IgnoreVelocity` | `0` | 在惯性化过程中忽略速度信息（有效地恢复到五次方对比混合） |
| `a.AnimNode.LegIK.AveragePull` | `1` | 腿部IK AveragePull |
| `a.AnimNode.LegIK.Debug` | `0` | 打开FAnimNode_LegIK的调试 |
| `a.AnimNode.LegIK.Enable` | `1` | 切换LegIK节点。 |
| `a.AnimNode.LegIK.EnableTwoBone` | `1` | 启用双骨代码路径。 |
| `a.AnimNode.LegIK.MaxIterations` | `0` | 腿部IK MaxIterations重载。0=节点默认，>0重载。 |
| `a.AnimNode.LegIK.PullDistribution` | `0.5` | 腿部IK PullDistribution。0=脚，0.5=平衡，1.f=臀部 |
| `a.AnimNode.LegIK.TargetReachStepPercent` | `0.7` | 腿部IK TargetReachStepPercent。 |
| `a.AnimNode.StateMachine.EnableRelevancyReset` | `1` | 在相关时重置状态机 |
| `a.AnimSequencer.DirectControlRigMode` | `1` | 1=FKControl绑定使用直接方法设置控制变换。0=FKControl绑定使用替换方法（变换偏移）设置控制变换 |
| `a.AnimSequencer.ValidationMode` | `0` | 1=启用操作后验证，以根据旧版本测试数据完整性。0=禁用验证 |
| `a.BlendCurves.ISPC` | `true` | 是否使用ISPC优化来混合曲线 |
| `a.BlendPoseAccumulate.ISPC` | `true` | 是否使用ISPC优化来累积姿势混合 |
| `a.BlendPoseOverwrite.ISPC` | `true` | 是否使用ISPC优化来覆盖姿势混合 |
| `a.BlendPosesPerBoneFilter.ISPC` | `true` | 是否使用ISPC优化来使用按骨骼筛选器来混合姿势 |
| `a.BonePose.ISPC` | `true` | 是否在骨骼姿势计算中使用ISPC优化 |
| `a.CacheLocalSpaceBounds` | `1` | 如果为1（默认值），将计算和缓存局部空间边界，否则将编译和缓存世界空间边界（并进行反转变换以生成局部边界）。 |
| `a.Compiler.CachePoseNodeUpdateOrderDebug.Enable` | `0` | 在AnimBP编译期间切换CacheNodeUpdateOrder调试 |
| `a.Compression.CompressibleDataOutput` |  | 是否输出包含可压缩数据的JSON文件。（逗号分隔） 位置：输出轨道位置数据 旋转：输出轨道旋转数据 缩放：输出轨道缩放数据 曲线：输出富曲线数据 |
| `a.Compression.ValidateCompressedRichCurveEvaluation` | `0` | 1 = 运行验证，在动画中对压缩的富曲线求值，将其采样率与MaxCurveError进行比较。0=禁用验证 |
| `a.ConstantKeyLerp.ISPC` | `true` | 是否在常量关键帧动画编码中使用ISPC优化 |
| `a.ConvertMeshRotationPoseToLocalSpace.ISPC` | `true` | 是否使用ISPC优化将网格体空间旋转转换为局部空间 |
| `a.ConvertPoseToAdditive.ISPC` | `true` | 是否使用ISPC优化将姿势转换为叠加姿势 |
| `a.ConvertPoseToMeshRotation.ISPC` | `true` | 是否使用ISPC优化将局部空间旋转转换为网格体空间 |
| `a.DebugDrawBoneAxes` | `0` | 绘制骨骼（使用显示骨骼（Show Bones））时，绘制骨骼轴。 |
| `a.DebugDrawSimpleBones` | `0` | 绘制骨骼（使用显示骨骼（Show Bones））时，将骨骼绘制为简单线条。 |
| `a.EnableAnimStreamable` | `0` | 1=启用制作动画可流送资产的能力。0=关闭 |
| `a.EnableQueuedAnimEventsOnServer` | `1` | 是否在服务器上启用列队的动画事件。大多数情况下，当服务器正在进行完整的动画图形更新时，服务器不会触发列队的通知，但此变量将启用它们。建议在使用监听服务器的项目中启用此变量。 0：禁用，1：启用 |
| `a.ForceEvalRawData` | `0` | 值：0/1 控制是否强制对非压缩动画数据进行采样。 |
| `a.ForceParallelAnimUpdate` | `0` | 如果!= 0，无论项目或动画蓝图上的设置如何，将更新工作线程上的动画。 |
| `a.KeepNotifyAndCurvesOnAnimationRecord` | `1` | 如果非零，在录制动画时将保留动画通知、曲线和同步标记，如果为0，将在录制前丢弃。 |
| `a.LerpBoneTransforms.ISPC` | `true` | 是否使用ISPC优化为骨骼变换插值 |
| `a.MarkLayerAsGarbageOnUninitialize` | `0` | 是否在初始化图层后将图层标记为垃圾。 |
| `a.Montage.EndSectionRequiresTimeRemaining` | `false` | 仅在有剩余时间时才选中蒙太奇EndOfSection（默认值为false）。 |
| `a.MotionTrajectory.Debug` | `0` | 打开运动轨迹的调试绘制 |
| `a.MotionTrajectory.Options` | `0` | 切换运动轨迹示例信息： 0. 禁用文本 1. 索引 2. 累积时间 3.位置 4.速度 5.加速度 |
| `a.MotionTrajectory.Stride` | `1` | 在显示信息时配置示例步幅 |
| `a.OutputMontageFrameRateWarning` | `false` | 如果为true，将警告用户关于由不兼容动画资产（不兼容帧率）组成的动画蒙太奇/复合。 |
| `a.ParallelAnimEvaluation` | `1` | 如果为1，将在任务图表系统中运行动画求值。如果为0，将完全在游戏线程上运行求值 |
| `a.ParallelAnimInterpolation` | `1` | 如果为1，动画插值将在任务图表系统上运行。如果为0，插值将完全在游戏线程上运行 |
| `a.ParallelAnimUpdate` | `1` | 如果！= 0，则在工作线程上更新动画混合树、原生更新、资产播放器和蒙太奇（如果可能）。 |
| `a.ParallelBlendPhysics` | `1` | 如果为1，则物理混合将在任务图表系统中运行。如果为0，混合将完全在游戏线程上运行 |
| `a.PerTrackCompression.ISPC` | `true` | 是否在逐轨道动画编码中使用ISPC优化 |
| `a.RecordExternalMorphTargets` | `false` | 记录动画信息内部的外部变形目标权重。此变量默认禁用，因为它会减慢录制速度。 |
| `a.Sharing.DebugStates` | `0` | 值：0/1/2/3 控制是否启用以及启用哪些动画共享调试功能。 0：关闭。 1：打开激活先导组件和混合材质着色，以及每个Actor在胶囊体上方的打印状态信息。 2：打开有关当前激活动画状态的打印状态信息、混合等。还支持从跟随组件到当前分配的先导组件的线条绘制。 |
| `a.Sharing.ScalabilityPlatform` |  | 控制在检索每个平台可伸缩性设置时应使用哪个平台。 空白：当前平台。 平台名称 平台组名称 |
| `a.SkeletalMesh.ISPC` | `true` | 是否在动画骨骼网格体组件中使用ISPC优化。已废弃，请换为a.SkinnedAsset.ISPC |
| `a.Skeleton.AllowIncompatibleSkeletalMeshMerge` | `false` | 导入或以其他方式合并骨骼网格体骨骼时，允许骨骼插入存在‘不兼容’的层级。 |
| `a.SkinnedAsset.ISPC` | `true` | 是否在蒙皮资产上使用ISPC优化 |
| `a.SkinWeightProfile.AllowedFromLOD` | `-1` | 重载LOD索引，从该索引可以应用蒙皮权重配置文件 |
| `a.SkinWeightProfile.DefaultLODOverride` | `-1` | 重载LOD索引，从该索引默认蒙皮权重配置文件应重载骨骨骼网格体的默认蒙皮权重 |
| `a.SkinWeightProfile.LoadByDefaultMode` | `-1` | 启用/禁用运行时优化，以使用指定为默认设置的配置文件重载原始蒙皮权重，从而进行替换。可用于优化特定平台或设备的内存 -1=禁用 0=静态禁用 1=静态启用 2=动态禁用 3=动态启用 |
| `a.SkipDDC` | `0` | 1=在压缩期间跳过DDC。0=在压缩期间包括DDC结果 |
| `a.Streaming.ChunkSizeSeconds` | `4` | 流送动画块的大小，以秒为单位，0或负数表示只有1个块 |
| `a.Streaming.SpoofFailedChunkLoad` | `0` | 强制无法加载流送动画块。 0：未启用，1：启用 |
| `a.StripAdditiveRefPose` | `0` | 1=在烘焙时剥离叠加参考姿势。0=关闭 |
| `a.StripFramesOnCompression` | `0` | 1=在具有偶数帧的动画上每隔一帧剥离一次。0=关闭 |
| `a.StripOddFramesWhenFrameStripping` | `0` | 1=当帧剥离也适用于具有奇数帧的动画。0=仅偶数帧动画 |
| `a.URO.DisableInterpolation` | `0` | 设置为1，可禁用插值 |
| `a.URO.Draw` | `0` | 为True，可为动画速率绘制颜色编码框。 |
| `a.URO.Enable` | `1` | 为True，可优化动画速率。 |
| `a.URO.ForceAnimRate` | `0` | 非零，可强制执行动画速率。10=每十帧对可执行的网格体进行动画求值。在某些情况下，帧被视为30fps。 |
| `a.URO.ForceInterpolation` | `0` | 设置为1，可强制插值 |
| `a.VariableKeyLerp.ISPC` | `true` | 是否在变量关键帧动画编码中使用ISPC优化 |
| `a.VisualizeLODs` | `0` | 可视化SkelMesh LOD |

## AB测试

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `abtest.CoolDown` | `5` | 每个命令后要丢弃数据的帧数，以覆盖线程处理。 |
| `abtest.HistoryNum` | `1000` | 用于统计的历史帧数。 |
| `abtest.MinFramesPerTrial` | `10` | 在切换前运行给定命令所需的帧数；这是随机的。 |
| `abtest.NumResamples` | `256` | 用于确定置信度的重新采样数量。 |
| `abtest.ReportNum` | `100` | 报告之间的帧数。 |

## 可访问性

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Accessibility.Enable` | `false` | 如果为false，将忽略来自可访问API的所有查询。在某些平台上，必须重新启动应用程序才能生效。 |

## Actor

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Actor.IncludeSCSModifiedPropertiesInDiff` | `true` | 如果为True，可在任何事务对比中包括SCS修改的属性，如果为False，则可跳过 |
| `ActorSequence.DefaultDisplayRate` | `30fps` | 指定新建关卡序列的默认显示帧率；还定义帧锁定帧率，其中序列设置为帧锁定。示例：30 fps，120/1 (120 fps)，30000/1001 (29.97)，0.01s (10ms)。 |
| `ActorSequence.DefaultEvaluationType` | `0` | 0：播放锁定到播放帧 1：带有子帧插值的未锁定播放 |
| `ActorSequence.DefaultTickResolution` | `24000fps` | 指定新建关卡序列的默认更新分辨率。示例：30 fps，120/1 (120 fps)，30000/1001 (29.97)，0.01s (10ms)。 |

## AI

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `ai.crowd.DebugSelectedActors` | `0` | 为选定人群代理启用调试绘制。 0：禁用，1：启用 |
| `ai.crowd.DebugVisLog` | `0` | 为所有人群代理启用详细的Vislog录制。 0：禁用，1：启用 |
| `ai.crowd.DrawDebugBoundaries` | `0` | 绘制人群模拟使用的共享寻路网格体边界。 0：禁用，1：启用 |
| `ai.crowd.DrawDebugCollisionSegments` | `1` | 绘制碰撞寻路网格体边缘，需要ai.crowd.DebugSelectedActors。 0：禁用，1：启用 |
| `ai.crowd.DrawDebugCorners` | `1` | 绘制路径边角数据，需要ai.crowd.DebugSelectedActors。 0：禁用，1：启用 |
| `ai.crowd.DrawDebugNeighbors` | `1` | 绘制当前相邻数据，需要ai.crowd.DebugSelectedActors。 0：禁用，1：启用 |
| `ai.crowd.DrawDebugPath` | `1` | 绘制激活路径，需要ai.crowd.DebugSelectedActors。 0：禁用，1：启用 |
| `ai.crowd.DrawDebugPathOptimization` | `1` | 绘制路径优化数据，需要ai.crowd.DebugSelectedActors。 0：禁用，1：启用 |
| `ai.crowd.DrawDebugVelocityObstacles` | `1` | 绘制速度障碍物取样，需要ai.crowd.DebugSelectedActors。 0：禁用，1：启用 |
| `ai.debug.DetailedReplicationLogs` | `0` | 为Gameplay调试器启用或禁用非常详细的复制日志 |
| `ai.debug.DrawOverheadIcons` | `1` | 是否应绘制默认AI开销图标 |
| `ai.debug.DrawPaths` | `false` | 是否应绘制AI路径 |
| `ai.debug.EQS.RefreshInterval` | `2` | 收集数据的间隔（以秒为单位）。 |
| `ai.debug.nav.DisplaySize` | `3` | 在Gameplay调试器中以图块（DisplaySize x DisplaySize）显示的区域。大小将四舍五入到奇数图块。剔除距离可以使用'ai.debug.nav.DrawDistance’修改。 |
| `ai.debug.nav.DrawExcludedFlags` | `0` | 如果想"在调试绘制时标记禁止的导航多边形"。 |
| `ai.debug.nav.RefreshInterval` | `5` | 收集数据的间隔（以秒为单位）。 |
| `ai.DestroyNavDataInCleanUpAndMarkPendingKill` | `1` | 如果设置为1，NavData将在CleanUpAndMarkPendingKill中进行销毁，而不是被标记为垃圾。 |
| `ai.nav.bNavmeshAllowPartitionedBuildingFromEditor` | `false` | 启用试验性寻路网格体分区编译。 |
| `ai.nav.EnableNavMeshResolutions` | `true` | 当设置为false时，将忽略寻路网格体分辨率。 |
| `ai.nav.EnableSpanHeightRasterizationFix` | `true` | 默认激活。启用范围高度的光栅化修复。 |
| `ai.nav.GNavmeshDebugTileX` | `2147483647` |  |
| `ai.nav.GNavmeshDebugTileY` | `2147483647` |  |
| `ai.nav.GNavmeshGenerateDebugTileOnly` | `false` |  |
| `ai.nav.GNavmeshSynchronousTileGeneration` | `0` |  |
| `ai.nav.NavmeshUseOodleCompression` | `true` | 使用Oodle进行运行时图块缓存压缩/解压缩。在编辑器针对大小优化，在独立模式中针对速度优化。 |
| `ai.nav.RecentlyBuildTileDisplayTime` | `0.2` | 最近编译的图块的显示时间（以秒为单位）。 |
| `ai.nav.UseTightBoundExpansion` | `true` | 默认激活。使用一个AgentRadius的扩展。设置为false，可恢复到之前的行为（2个AgentRadius）。 |
| `ai.NavCollisionAvailable` | `1` | 如果设置为0，NavCollision将不会进行烘焙，且在运行时不可用。 |

## 异步渲染线程

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `AllowAsyncRenderThreadUpdates` | `1` | 用于控制异步渲染线程更新。在FApp::ShouldUseThreadingForPerformance()上也被限制。 |
| `AllowAsyncRenderThreadUpdatesDuringGamethreadUpdates` | `1` | 如果>0，则在并行更新的 *同时* 更新游戏线程。 |
| `AllowAsyncRenderThreadUpdatesEditor` | `0` | 用于在编辑器中控制异步渲染线程更新。 |
| `AllowAsyncRenderThreadUpdatesEditorGameWorld` | `0` | 用于在编辑器游戏世界中控制异步渲染线程更新。 |

## 允许虚拟键盘

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `AllowVirtualKeyboard` | `false` | 允许使用虚拟键盘，尽管平台主屏幕不可触控 |

## 分析

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `AnalyticsET.PayloadFlushTimeSecForWarning` | `0.001` | 清空EventCache负载所需的时间（以秒为单位），然后触发一条警告消息，列出负载中的事件。它用于调查垃圾邮件或缓慢遥测。 |
| `AnalyticsET.PayloadPercentageOfMaxForWarning` | `1` | EventCache最大负载的百分比，将触发警告消息，列出负载中的事件。它用于调查垃圾邮件或缓慢遥测。 |
| `AnalyticsET.PreventMultipleFlushesInOneFrame` | `true` | 当为true时，防止多个AnalyticsProviderET实例在同一帧中清空，从而允许分摊刷新和HTTP开销。 |
| `AnalyticsET.UserAgentCommentsEnabled` | `true` | 是否支持在分析用户代理字符串中写下注解 |

## Android

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Android.DeviceDetectionPollInterval` | `10` | 轮询连接的Android设备之间的秒数。 默认值：10 |

## 动画录制器

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `AnimRecorder.AnimLength` | `60` | 设置动画录制器系统的默认动画长度。 |
| `AnimRecorder.RecordInWorldSpace` | `1` | 设置为True，可在世界空间录制动画关键帧，设置为false，则仅在局部空间录制。 |
| `ApproximateActors.RenderCapture` | `0` | 确定是否触发渲染捕获。 0：关闭 1：打开 |

## 资产注册表

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `AssetRegistry.BlockPackagesWithMarkOfTheWeb` | `false` | 是否在资产注册表中阻止带有Web标记的包文件 |
| `AssetRegistry.DeferDependencySort` | `false` | 如果为true，依赖节点上的依赖列表直到初始加载完成后才会进行排序 |
| `AssetRegistry.DeferReferencerSort` | `true` | 如果为true，依赖节点上的引用者列表直到初始加载完成后才会进行排序 |
| `AssetRegistry.IgnoreEmptyDirectories` | `false` | 如果为true，资产注册表在扫描时将忽略完全空白的叶目录 |
| `AssetRegistry.ManagementPathsPackageDebugName` |  | 如果设置，在设置管理引用后，导致此包成为托管状态的引用链将被打印到日志中 |
| `AssetRegistry.MaxSecondsPerFrame` | `0.04` | 可用于处理资产注册表的最长时间，以秒为单位 |

## 资产工具

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `AssetTools.EnablePublicAssetFeature` | `false` | 启用试验性公共资产功能（False：禁用，True：启用 |
| `AssetTools.FollowRedirectorsWhenImporting` | `false` | 设置后，如果你在一个有重定向器的位置导入资产，你将改为导入到重定向器的目标位置 |
| `AssetTools.UseHeaderPatchingAdvancedCopy` | `false` | 如果设置为true，这将使用头文件配接复制文件，而不是执行完全加载。 |
| `AssetTools.UseNewPackageMigration` | `true` | 设置后，包迁移将使用为5.1制定的新实现。 |

## 异步

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Async.ParallelFor.YieldingTimeout` | `8` | 当任务的后台优先级并行时的超时（以毫秒为单位），若超过该时间，将放弃执行以给更高优先级的任务提供运行的机会。 |
| `AsyncReadFile.CacheHandleForPakFilesOnly` | `1` | 控制异步读取句柄如何缓存文件的底层平台句柄。 0：缓存所有文件的底层平台句柄。 1：仅缓存.pak文件的底层平台句柄（默认值）。 |

## 音频

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `au.3dVisualize.ActiveSounds` | `1` | 活动音效的可视化模式。 0：未启用，1：音量（Lin），2：音量（dB），3：距离，4：随机颜色，5：遮蔽 |
| `au.3dVisualize.ActiveSounds.Type` | `0` | 是否显示所有音效，AudioComponents（仅限组件）打开，或AudioComponents（仅限非组件）关闭。 0：全部，1：仅限组件，2：仅限非组件 |
| `au.3dVisualize.Enabled` | `0` | 是否启用音频可视化。 0：未启用，1：启用 |
| `au.3dVisualize.Listeners` | `0` | 启用3d可视化时，监听器是否可见。 0：未启用，1：启用 |
| `au.3dVisualize.SpatialSources` | `1` | 启用3D可视化时，音频空间化源是否可见。 0：未启用，1：启用 |
| `au.3dVisualize.VirtualLoops` | `1` | 启用3D可视化时，虚拟化循环是否可见。 0：未启用，1：启用 |
| `au.ActorSoundParameterInterface.GatherImplementers` | `false` | 当为true时，允许接口搜索实现该接口的附加组件和Actor。 |
| `au.adpcm.ADPCMReadFailiureTimeout` | `64` | 设置在完全停止声波之前尝试ADPCM解码的次数。 |
| `au.adpcm.ChanceForIntentionalChunkMiss` | `0` | 如果设置为>0，将有意丢弃文件块。用于调试。 |
| `au.adpcm.DisableSeekForwardOnReadMisses` | `1` | 当有一个查找挂起且此控制台变量设置为0时，将在文件中向前扫描。 |
| `au.adpcm.DisableSeeking` | `0` | 禁用通过ADPCM搜索。 |
| `au.adpcm.OnlySeekForwardOneChunk` | `1` | 当设置为1时，在连续加载两个文件块失败后，将不再继续向前查找。 |
| `au.AllowAudioSpatialization` | `1` | 控制是否允许音频的空间化，通常为启用。 如果禁用，所有音频不会空间化，但是会产生衰减。 0：禁用，>0：启用 |
| `au.AllowReverbForMultichannelSources` | `1` | 控制是否允许对信道数大于2的源进行混响处理。 0：禁用，>0：启用 |
| `au.Ambisonics.VirtualIntermediateChannels` | `1` | 在混音之前启用解码为虚拟7.1扬声器配置。 0：直接解码为输出设备配置，1：启用 |
| `au.AnalysisTimeShift` | `0` | 改变烘焙分析播放的时间轴。 值：改变时间轴的时间（以秒为单位）。 |
| `au.AudioThreadCommand.ExecutionTimeWarningThresholdInMs` | `500` | 如果一个命令的执行时间超过该数字（以毫秒为单位），则记录一条警告 |
| `au.AudioThreadCommand.LogEveryExecution` | `0` | 每个音频线程命令调用者及其执行时间的极其详细的记录 |
| `au.BakedAnalysisEnabled` | `1` | 启用或禁用对音频组件烘焙分析的查询。 |
| `au.BusReaderPatchWaitTimeout` | `3` | Audio Bus Reader节点等待其补丁输出接收示例的最长时间。 |
| `au.BypassAllSubmixEffects` | `0` | 当设置为1时，将绕过所有子混音效果。 1：将禁用子混音效果。 |
| `au.BypassAudioPlugins` | `0` | 绕过任何音频插件处理。 0：未禁用，1：禁用 |
| `au.BypassPlayWhenSilent` | `0` | 当设置为1时，将忽略非程序源的静音播放标记。 0：调用静音播放标记，1：停止所有静音非程序源。 |
| `au.CommandBufferFlushWaitTimeMs` | `1000` | 等待命令缓冲区完成清空的时间。 |
| `au.CommandBufferInitialCapacity` | `500` | 要初始化命令缓冲区容量的元素数量 |
| `au.CommandBufferMaxSizeInMb` | `10` | 在忽略更多命令之前，允许命令缓冲区增长的程度 |
| `au.compression.AsyncCompression` | `1` | 1：当编解码器支持时，允许USoundWave的异步压缩。 0：禁用异步压缩。 |
| `au.Concurrency.MinVolumeScale` | `0.001` | 音量缩放（线性比例）的音量阈值被视为静音。 |
| `au.Debug.Display.X` | `100` | 调试统计信息界面上的X位置。 默认值：100 |
| `au.Debug.Display.Y` | `-1` | 调试统计信息界面上的X位置。 默认值：-1（禁用，使用默认的调试位置） |
| `au.Debug.Generator` | `0` | 启用/禁用调试音效生成。 0：禁用，1：SinTone，2：WhiteNoise |
| `au.Debug.Generator.Amp` | `0.2` | 设置。 默认值：0.2f |
| `au.Debug.Generator.Channel` | `0` | 设置调试音频的通道输出索引。 如果提供的数字高于支持的数字，则使用左。 0：左，1：右，等等。 |
| `au.Debug.Generator.Freq` | `440` | 设置调试音效生成频率。 0：未禁用，1：SinTone，2：WhiteNoise |
| `au.Debug.SoundCues.Minimal` | `0` | 启用后，使用Sound Cue调试的紧凑视图。 0：未启用，1：启用 |
| `au.Debug.Soundcues.ShowDistance` | `0` | 启用后，显示Sound Cue的距离。 0：未启用，1：启用 |
| `au.Debug.Soundcues.ShowPath` | `1` | 启用后，显示Sound Cue的完整路径。 0：未启用，1：启用 |
| `au.Debug.SoundCues.Spacing.Char` | `7` | 具有紧凑视图的角色大小（以像素为单位）。 默认值：7 |
| `au.Debug.SoundCues.Spacing.Tab` | `5` | 具有紧凑视图的选项卡大小（以字符为单位）。 默认值：5 |
| `au.Debug.Sounds.Max` | `32` | 在完整的音效调试器视图中显示的最大音效数。 默认值：32 |
| `au.Debug.Sounds.ShowPath` | `1` | 启用后，显示音效的完整路径。 0：未启用，1：启用 |
| `au.Debug.Sounds.Sort` | `Name` | 音效统计处于活动状态时要排序并显示的值。 类、距离、名称（默认）、优先级（每个音效的最高波形实例）、时间、波形、音量 |
| `au.Debug.Sounds.TextColor` | `White` | 音频调试视图中正文文本的颜色。 白色、红色、橙色、黄色、蓝色、洋红色、紫色、黑色 |
| `au.DecompressionThreshold` | `0` | 如果非零，则重载音效组或平台运行时设置中设置的解压阈值。 值：应该完全解压的最大时长，以秒为单位。 |
| `au.DefaultModulationPlugin` |  | 要加载和使用的默认调制插件的名称（由配置中平台特定实现名称重载。 |
| `au.DisableAppVolume` | `0` | 设置为1时，禁用应用程序音量。 0：启用应用程序音量，1：禁用应用程序音量 |
| `au.DisableAutomaticPrecache` | `0` | 设置为1时，这会在加载或启动时禁用预缓存，将仅在播放时同步预缓存。 0：使用普通的预缓存逻辑，1：禁用除同步调用以外的所有预缓存。 |
| `au.DisableBinauralSpatialization` | `0` | 禁用双耳空间化。 |
| `au.DisableDeviceSwap` | `0` | 在Windows上禁用音频混合器的设备交换处理代码。 0：未启用，1：启用 |
| `au.DisableDistanceAttenuation` | `0` | 禁止使用任何距离衰减。 0：未禁用，1：禁用 |
| `au.DisableEnvelopeFollowing` | `0` | 禁止使用包络跟踪器进行源包络跟踪。 0：未禁用，1：禁用 |
| `au.DisableFiltering` | `0` | 禁止使用每源低通和高通滤波器。 0：未禁用，1：禁用 |
| `au.DisableHPFiltering` | `0` | 禁止使用每源高通滤波器。 0：未禁用，1：禁用 |
| `au.DisableLegacyReverb` | `0` | 在旧版音频后端禁用混响。 0：启用，1：禁用 |
| `au.DisableOcclusion` | `0` | 禁用(1)或启用(0)音频遮挡。 |
| `au.DisableParallelSourceProcessing` | `1` | 禁止使用异步任务处理源。 0：未禁用，1：禁用 |
| `au.DisableQuadReverb` | `0` | 禁用环绕声中的四重混响。 0：未禁用，1：禁用 |
| `au.DisableReverbSubmix` | `0` | 禁用混响子混音。 0：未禁用，1：禁用 |
| `au.DisableSourceEffects` | `0` | 禁止使用任何源效果。 0：未禁用，1：禁用 |
| `au.DisableStereoSpread` | `0` | 当设置为1时，将忽略衰减设置中的3D立体声扩散属性，而是从奇点渲染音频。 0：未禁用，1：禁用 |
| `au.DisableStoppingVoices` | `0` | 禁用停止语音功能。 0：未禁用，1：禁用 |
| `au.DisableSubmixEffectEQ` | `1` | 禁用均衡器子混音（从5.0开始默认为true）。 0：未禁用，1：禁用 |
| `au.DisableSubmixMutationLock` | `0` | 禁用子混合音变锁定。 0：未禁用（默认），1：禁用 |
| `au.dsp.FFTMethod` | `0` | 确定是使用迭代FFT方法还是DFT。 0：使用迭代FFT，1：使用DFT |
| `au.DSP.InitialFDelayAllocationSeconds` | `-1` | 重载初始延迟线路分配（以秒为单位），它将增长到InBufferLengthSec。 |
| `au.editor.CookOverrideCachingInterval` | `60` | 它设置在项目设置中更改烘焙重载时与将其应用于新音频源时之间的最大延迟。 n：缓存间隔之间的时间，以秒为单位。 |
| `au.editor.ForceAudioNonStreaming` | `0` | 当设置为1时，将强制任何音频进行非流式播放 可以强制DDC丢失。 0：调用静音播放标记，1：停止所有静音非程序源。 |
| `au.editor.SoundWaveOwnerLoadingBehaviorCacheOnStartup` | `0` | 禁用在单例启动时搜索资产注册表。否则，它将递增填充缓存 |
| `au.editor.SoundWaveOwnerLoadingBehaviorEnable` | `1` | 启用或禁用Soundwave所有者加载行为标记 |
| `au.EnableBinauralAudioForAllSpatialSounds` | `0` | 如果双耳渲染可用，切换所有空间音效的双耳音频渲染。 |
| `au.EnableDetailedWindowsDeviceLogging` | `0` | 启用详细的Windows设备日志记录。 0：未启用，1：启用 |
| `au.EnableOcclusionFilterScale` | `0` | 是否将遮挡缩放0.25f，以便补偿音频混频器中滤波器截止频率的变化。 0：未启用，1：启用 |
| `au.EnableReverbStereoFlipForQuad` | `0` | 启用在环绕声中进行四路混响立体声翻转。 0：未启用，1：启用 |
| `au.EnableUserSoundwaveImport` | `1` | 启用允许用户在编辑器中导入声波。 0：禁用，1：启用 |
| `au.ExtraAudioMixerDeviceLogging` | `0` | 为音频混音器设备运行启用额外的日志记录 0：没有日志记录，1：每500次回调记录一次 |
| `au.ExtraResonanceLogging` | `0` | 如果非零，将记录有关共振HRTF处理状态的额外信息。 0：禁用，>0：启用 |
| `au.FadeOutTimeoutMSec` | `2000` | 等待FadeOut事件触发的时间。 |
| `au.FloatArrayMath.ISPC` | `true` | 是否在音频浮点数组数学运算中使用ISPC优化 |
| `au.FlushAudioRenderCommandsOnSuspend` | `0` | 设置为1时，确保在应用程序挂起时，将所有待处理的命令发送到音频线程和音频渲染线程。 0：未禁用，1：禁用 |
| `au.FlushAudioRenderThreadOnGC` | `0` | 当设置为1时，每次垃圾回收运行时，将清空所有待处理的音频渲染线程命令。 |
| `au.FlushCommandBufferOnTimeout` | `0` | 当设置为1时，如果栅栏超时，则同步清空音频渲染线程。 0：未禁用，1：禁用 |
| `au.FocusData.InitializeFocusFactorOnFirstUpdate` | `1` | 当设置为1时，将在第一次更新时将焦点因子初始化为正确值，而不是从0插值到正确值。 0：禁用，1：启用（默认） |
| `au.ForceRealtimeDecompression` | `0` | 当设置为1时，这可以特意确保所有音频资产在播放时解压，而不是在加载时完全解压。 0：允许加载时完全解压，1：强制实时解压。 |
| `au.ForceSyncAudioDecodes` | `0` | 禁止使用异步任务处理源。 0：未禁用，1：禁用 |
| `au.ForceSynchronizedAudioTaskKick` | `0` | 将强制在一个音频渲染帧中创建的所有音频任务"进入队列，直到可以在帧末尾将它们全部一次"踢出"。 0：不强制，1：强制" |
| `au.IgnoreUserResonanceSubmix` | `0` | 当设置为1时，将绕过谐振项目设置。 1：将禁用子混音效果。 |
| `au.InteriorData.UseAudioVolumes` | `1` | 当设置为1时，将允许从音频音量（旧版）收集内部数据。 0：禁用，1：启用（默认） |
| `au.InteriorData.UseIActiveSoundUpdate` | `1` | 当设置为1时，将允许从实现IActiveSoundUpdate接口的子系统收集内部数据。 0：禁用，1：启用（默认） |
| `au.LinearGainScalarForFinalOutut` | `1` | 应用于最终浮点缓冲区的线性增益标量，可支持可热修复的削波抑制 默认值为1.0f |
| `au.LogRenderTimes` | `0` | 记录音频渲染时间。 0：未记录，1：记录 |
| `au.LogSubmixAutoDisable` | `0` | 启用子混音禁用和启用状态的日志记录。 1：子混音启用日志记录打开。0：子混音启用/禁用日志记录关闭。 |
| `au.MaxConcurrentStreams` | `0` | 重载最大并行流送。 0：未重载，>0 已重载 |
| `au.MaxRandomBranches` | `0` | 设置任意随机节点要播放的最大分支数。分支的其他部分将从内存中释放。 0：没有剔除，任何其他值：对于任意随机节点，应使用的分支数量的最大值。 |
| `au.MaxWorldDistance` | `2.09715e+06` | 音频相关计算中使用的最大世界距离（例如衰减）。 |
| `au.MetaSound.AutoUpdate.NativeClassesOfEqualVersion` | `1` | 如果为true，则在接口不同时，对共享版本号的原生类的节点引用将尝试自动更新，这将导致图表加载时间变慢。 0：不要自动更新存在接口差异的相同版本的原生类，!0：自动更新存在接口差异的相同版本的原生类（默认） |
| `au.MetaSound.BlockRate` | `0` | 设置MetaSounds的块速率（块/秒）。 默认值：100.0f，最小值：1.0f，最大值：1000.0f |
| `au.MetaSound.Builder.TransactionBasedRegistrationEnabled` | `1` | 强制向前端注册MetaSound对象的所有编译器调用。 启用（默认）：!0，禁用：0 |
| `au.MetaSound.BusyWaitOnAsyncRegistrationTasks` | `true` | 使用TaskGraph BusyWait，而不是简单的Wait。需要避免在核心数较低的平台上挂起。 |
| `au.MetaSound.Debug.EnableOperatorMissingOverrideLog` | `false` | 在缺少重载的运算符上启用额外日记记录 默认值：false |
| `au.MetaSound.DisableAsyncGraphRegistration` | `false` | 禁用MetaSound图表的异步注册 默认值：false |
| `au.MetaSound.DisableWaveCachePriming` | `0` | 禁用MetaSound波缓存填充。 0（默认值）：启用，1：禁用 |
| `au.MetaSound.Editor.AsyncRegistrationEnabled` | `1` | 启用在编辑器加载时异步注册所有MetaSound资产类。 0：禁用，!0：启用（默认） |
| `au.MetaSound.Editor.Debug.ShowNodeDebugData` | `0` | 启用后，在MetaSound资产编辑器中将鼠标悬停在节点标题和引脚上时显示调试数据，如节点ID、顶点ID、顶点名称和类名称。 0：禁用（默认），!0：启用 |
| `au.MetaSound.EnableAllVersionsNodeClassCreation` | `0` | 启用在编辑器中为已弃用的MetaSound类的主要版本创建节点。 0：禁用（默认），!0：启用 |
| `au.MetaSound.EnableAsyncGeneratorBuilder` | `true` | 启用FMetaSoundGenerators的异步构建 默认值：true |
| `au.MetaSound.EnableCookDeterministicIDGeneration` | `1` | 启用移动MetaSound注册操作（如AutoUpdate）以及使用确定性ID生成从运行时到烘焙的一些模板节点变换 0：禁用，!0：启用（默认） |
| `au.MetaSound.EnableGeneratorInvalidSampleValueLogging` | `false` | 启用从FMetaSoundGenerator生成的超过绝对取样值阈值的音频取样值的日志记录 默认值：false |
| `au.MetaSound.EnableGeneratorNonFiniteLogging` | `false` | 启用从FMetaSoundGenerator生成的无限（NaN/inf）音频取样值的日志记录 默认值：false |
| `au.MetaSound.Experimental.DynamicOperatorTransformTimeoutInSeconds` | `0.01` | 设置在单个MetaSound渲染周期中处理挂起的动态图表转换所允许的秒数。 [小于零]：禁用，[大于零]：启用，0.010s（默认） |
| `au.MetaSound.Experimental.EnableAutoCachingForAllOperators` | `false` | 启用自动缓存所有MetaSound运算符。 （请参阅MetasoundOperatorCacheSubsystem.h了解手动路径）。 默认值：false |
| `au.MetaSound.Experimental.EnableAutoCachingForOneShotOperators` | `false` | 启用使用OneShot源接口自动缓存MetaSound运算符。 （请参阅MetasoundOperatorCacheSubsystem.h了解手动路径）。 默认值：false |
| `au.MetaSound.Experimental.EnableRuntimePresetGraphInflation` | `false` | 启用MetaSounds的试验性功能以减少预设图形的开销 默认值：false |
| `au.MetaSound.Frontend.DiscardStreamedRegistryTransactions` | `1` | 启用后，MetaSound注册事务将在流式处理后被丢弃。 0：禁用，!0：启用（默认） |
| `au.MetaSound.GeneratorSampleValueThreshold` | `2` | 如果启用了无效取样值日志记录，它将设置用于记录取样的最大abs值阈值 默认值：2.0 |
| `au.MetaSound.OperatorPoolHitRateWindowSeconds` | `1` | 控制命中/未命中结果对成功率报告的影响时长。 |
| `au.MetaSound.OperatorPoolSyncGraphRetrieval` | `true` | 在异步任务创建实例之前，检索请求线程上的图表。 |
| `au.MetaSound.Parameter.EnableWarningOnIgnoredParameter` | `0` | 启用后，当发送到MetaSound的参数被忽略时，将记录警告。 0：禁用（默认），!0：启用 |
| `au.MetaSound.ProfileAllGraphs` | `0` | 启用分析所有MetaSound图表。注意：如果设置了节点筛选器，它仍适用（请参阅au.Metasound.AddProfileNode） 0：禁用（默认），!0：启用 |
| `au.MetaSound.SampleRate` | `0` | 重载Metasounds的采样率。负值将默认为音频混合器采样率。 默认值：0，最大值：8000，最大值：48000 |
| `au.MetaSound.WavePlayer.DeinterleaveBlockSizeInFrames` | `512` | 用于在MetaSound Wave Player节点中分选音频的块大小（以帧为单位）。 默认值：512 |
| `au.MetaSound.WavePlayer.MaxDecodeSizeInFrames` | `1024` | 用于在MetaSound wave player节点中解码音频的最大大小（以帧为单位）。 默认值：1024 |
| `au.MinLogTimeBetweenUnderrunWarnings` | `10000` | MS中欠载警告之间的最短时间（全局） 全局设置每个后续欠载日志警告之间的时间（默认为10秒） |
| `au.MultithreadedPatching.PushCallsPerOutputCleanupCheck` | `256` | 在调用多少次推送后（通常会与音频块更新相一致）检查输出是否准备好销毁。默认值 = 256 |
| `au.NeverMuteNonRealtimeAudioDevices` | `0` | 当设置为1时，非实时音频设备将免于正常的音频设备静音（例如当窗口失去焦点时）。 0：未禁用，1：禁用 |
| `au.NumPrecacheFrames` | `0` | 设置为>0时，将使用该值作为预缓存音频缓冲区的帧数。 0：使用预缓存帧的默认值，>0：要预缓存的帧数。 |
| `au.OverrunTimeoutMSec` | `5000` | 交换到空设备之前等待渲染线程超时的时间。 |
| `au.PatchBufferBlocks` | `3` | 确定适合补丁缓冲区的块数量。 |
| `au.Quartz.bAlwaysTakeVoiceSlot` | `1` | 始终立即获取语音槽而不会尝试在组件上缓存请求 默认值 = 1：始终立即将请求转发给音频引擎。-0：尝试在组件上缓存播放请求，直到接近截止日期。 |
| `au.Quartz.DecrementSlotIndexOnStarted` | `1` | 默认为1，可启用委托泄漏修复。 设置为0，可恢复到修复前行为。 1：新行为，0：旧行为 |
| `au.Quartz.HeadlessClockSampleRate` | `100000` | 当没有混音器设备时，用于Quartz时钟/节拍器的采样率。 0：未启用，1：启用 |
| `au.Quartz.MaxSubscribersToUpdatePerTick` | `-1` | 限制每次函数更新的Quartz订阅者数量。 <= 0：没有限制，>= 1：限制 |
| `au.Quartz.SimulateNoAudioDevice` | `0` | 启用后，QuartzSubsystem将假定没有音频设备，并以无头模式运行新时钟。 0：未启用，1：启用 |
| `au.Quartz.TimeToTakeUpVoiceSlot` | `6` | EQuartzCommandQuantization类型（默认值：EQuartzCommandQuantization::EighthNote），播放之前，一个列队的音效应占用一个语音槽 值：所需时长的EQuartzCommandQuantization索引 |
| `au.RealtimeDecompressZeroDurationSounds` | `0` | 当设置为1时，将回退到实时解码任何无效时长的声波。 0：完全解压时长为0的声音，1：实时解压时长为0的声音。 |
| `au.RecoverRecordingOnShutdown` | `0` | 设置为1时，如果在录制过程中关闭游戏，将尝试将录制内容退回到wav文件。 0：禁用，1：启用 |
| `au.RecycleThreads` | `1` | 保留线程以重复使用，而不是创建/销毁线程，0关闭，1打开 |
| `au.RenderThreadAffinity` | `0` | 重载音频渲染线程亲疏度。 0：禁用（默认），否则重载线程亲疏度。 |
| `au.RenderThreadPriority` | `3` | 设置音频渲染线程优先级。默认为3。 0：正常，1：高于正常水平，2：低于正常水平，3：最高，4：最低，5：略低于正常水平，6：时间要求严格 |
| `au.resonance.quality` | `0` | 重载共振声源的质量。不会提高质量级别。采用的质量将是共振源设置和此重载中质量的最小值。 0：不重载质量；1：立体声平移，2：低质量，3：中质量，4：高质量 |
| `au.Resonance.UsingReverb` | `1` | 允许共振查询音频音量，获取混响效果。 0：禁用，1：启用（默认） |
| `au.SetAudioChannelCount` | `0` | 更改音频信道数。最大值限制为初始化音频引擎所使用的MaxChannelCount。 0：禁用，>0：启用 |
| `au.SetAudioChannelScaleCount` | `1` | 按百分比更改音频信道数。 |
| `au.SoundDistanceOptimizationLength` | `1` | 在一次性距离优化时进入剔除候选之列的音效必须具备的最大时长。 |
| `au.SoundWaveImportLengthLimitInSeconds` | `-1` | 当设置值>0.0f值时，时长大于该值的声波将导入失败。 如果值<0.0f，则长度将不受限制 |
| `au.SoundWaveProxyReader.SimulateSeek` | `0` | 如果为true，非可搜索格式的声波将通过读取和丢弃取样来模拟查找调用。 0：不模拟查找，!0：模拟查找 |
| `au.SpoofFailedStreamChunkLoad` | `0` | 强制无法加载流送文件块。 0：未启用，1：启用 |
| `au.streamcache.BlockOnChunkLoadCompletion` | `0` | 当设置为1时，USoundWaves将总是在USoundWave请求完成后尝试同步加载文件块。 0：不要试图在SoundWave完成加载文件块后阻止，1：在USoundWave的块请求完成后阻止。 |
| `au.streamcache.DisableRetaining` | `0` | 当设置为1时，USoundWaves将不会保留自己的音频块。 0：不禁用保留，1：禁用保留。 |
| `au.streamcache.DispatchToGameThreadOnChunkRequest` | `1` | 当设置为1时，只要USoundWave请求完成，就会向游戏线程分派回调。这可能会导致音频块在需要时被清除。 0：加载音频文件块后，立即捕获音频文件块。1：加载文件块后，立即向游戏线程分派回调。 |
| `au.streamcache.priming.BypassRetainFromSoundCues` | `0` | 当设置为1时，直接忽略Sound Cue上设置的音效类的加载行为。 |
| `au.streamcache.priming.ManuallyPrimeChildNodes` | `1` | 当设置为1时，直接忽略Sound Cue上设置的音效类的加载行为。 |
| `au.streamcache.priming.PrimeDelayNodes` | `0` | 当设置为1时，当遇到延迟节点时，音效将自动加载到缓存。 |
| `au.streamcache.priming.PrimeRandomNodes` | `0` | 当设置为1时，当遇到随机节点时，音效将自动加载到缓存。 |
| `au.streamcache.SoundWaveDefaultLoadingBehavior` | `3` | 当加载USoundWave时，它可以设置为定义默认行为。 1：加载时保留音频数据，2：加载时填充音频数据，3：按需加载（在USoundWave播放或填充之前，不会加载音频数据）。 |
| `au.streamcaching.AlwaysLogCacheMisses` | `0` | 当设置为非零值时，所有缓存未命中都将添加到audiomemreport。 0：在调用au.streamcaching.StartProfiling之前不记录缓存未命中。1：始终记录缓存未命中。 |
| `au.streamcaching.BlockForPendingLoadOnCacheOverflow` | `0` | 此控制台变量可设置将要播放但不在缓存中的音频文件块默认请求优先级。 0：清理缓存时，我们将清除所有声波保留内容。1：清理缓存时，我们将试图取消进行中负载。 |
| `au.streamcaching.ChunkSlotNumScalar` | `1` | 这允许调整预分配的文件块槽的数量。 1.0：是下限 |
| `au.streamcaching.DebugView` | `2` | 启用在比较流送缓存文件块键时比较FObjectKey。 当没有此FName时，如果2个声波名称相同，可能会发生争用。 0：旧版，1：默认值，2：平均视图，3：高细节视图 |
| `au.streamcaching.EnableExhaustiveCacheSearches` | `0` | 启用FindElementForKey中缓存的详尽搜索。 0：依赖文件块偏移。1：使用线性搜索进行搜索 |
| `au.streamcaching.EnableTrimmingRetainedAudio` | `1` | 当设置>0时，当流送缓存超过内存限制，将修剪保留的音频。 0：从不修剪保留的音频，>0：将修剪保留的音频。 |
| `au.streamcaching.ForceBlockForLoad` | `0` | 当设置为非零值时，将在磁盘读取完成前阻止GetLoadedChunk。 |
| `au.streamcaching.KeepCacheMissBufferOnFlush` | `1` | 如果设置为1，则在调用AudioMemReport之后，将保留记录的缓存未命中的缓冲区。否则，调用audiomemreport将清空所有先前记录的缓存未命中。 1：整个会话中的所有缓存未命中都会显示在audiomemreport中。0：仅自上一次调用audiomemreport后的缓存未命中将显示在当前audiomemreport中。 |
| `au.streamcaching.MaxCachesToDisplay` | `128` | 设置要在屏幕上显示的最大流送文件块数。 n：要在界面上显示的元素数。 |
| `au.streamcaching.MemoryLimitTrimPercentage` | `0.1` | 当设置>0.0时，当流送缓存超过内存限制，将修剪每个修剪调用的内存缓存音频百分比。 0.0：仅修剪要分配单个文件块所需的量，>0：内存限制的百分比。 |
| `au.streamcaching.MinimumCacheUsage` | `0.9` | 该值是可支持的流送缓存最小潜在占用量。例如，将其设置为0.25，会导致在开始逐出文件块时（最坏的情况）缓存占用可能达到25%。 0.0：将文件块数限制为（缓存大小/最大文件块大小）[0.01-0.99]：播放多个小音效时，增加文件块的数量可限制磁盘IO。 |
| `au.streamcaching.NumSoundWavesToClearOnCacheOverflow` | `0` | 当设置>0时，每次缓存溢出时，将尝试释放一定数量的音效的保留内容。 0：当缓存溢出时重置所有保留音效，>0：每当缓存溢出时清除指定数量的音效。 |
| `au.streamcaching.PlaybackRequestPriority` | `0` | 此控制台变量可设置将要播放但不在缓存中的音频文件块默认请求优先级。 0：最高，1：正常，2：低于正常水平，3：低，4：最小值 |
| `au.streamcaching.PrimeSoundOnAudioComponents` | `0` | 设置为1时，当使用该音效生成UAudioComponent或调用UAudioComponent::SetSound时，会自动启动USoundBase。 |
| `au.streamcaching.ReadRequestPriority` | `1` | 此控制台变量可设置当打开流缓存时可设置音频文件块的默认请求优先级。 0：最高，1：正常，2：低于正常水平，3：低，4：最小值 |
| `au.streamcaching.SaveAudiomemReportOnCacheOverflow` | `0` | 设置为1时，如果缓存溢出，将打印audiomemreport。 0：禁用，1：启用 |
| `au.streamcaching.SearchUsingChunkArray` | `1` | 如果对缓存执行详尽搜索，使用文件块数组而不是LRU（我们放弃了解元素在缓存中的向下距离）。 0：使用LRU（链表）搜索。1：使用文件块池（TArray）搜索 |
| `au.streamcaching.StreamCacheSizeOverrideMB` | `0` | 可以将此控制台变量设置为重载缓存大小。 0：使用项目设置中的缓存大小。n：新的缓存大小（以兆字节为单位）。 |
| `au.streamcaching.TrimCacheWhenOverBudget` | `1` | 当设置为非零值时，将在AddOrTouchChunk中调用TrimMemory，以防超出预算。 |
| `au.submix.audibledefaultendpoints` | `0` | 允许音频发送到默认（通常静音）端点子混合，以便通过主子混合是可听到。（适合用于调试）0：禁用（默认），1：启用 |
| `au.submix.clearbrokensubmixassets` | `0` | 如果已设置，将验证你的子混音不会列示不再是其子项的子子混音，且前子项也不会错误地列出其之前的父项。 0：禁用，>0：启用 |
| `au.Submix.Effects.DynamicsProcessor.Bypass` | `0` | 如果非零，将绕过当前所有激活的子混合动态处理器。 |
| `au.ThreadedSwapDebugExtraTime` | `0` | 将向交换任务添加额外时间，从而模拟缓慢的设备交换 |
| `au.UnderrunTimeoutMSec` | `5` | 提交欠载缓冲区之前，等待渲染线程生成下一个缓冲区的时间。 |
| `au.UseCachedDeviceInfoCache` | `1` | 将使用DeviceCache缓存而不是要求OS0关闭，1打开 |
| `au.UseListenerOverrideForSpread` | `0` | 零衰减重载距离立体声平移 0：使用实际距离，1：使用监听器重载 |
| `au.UseThreadedDeviceSwap` | `1` | 让设备交换将扩大运行范围。0关闭，1打开 |
| `au.VirtualLoops.Enabled` | `1` | 启用或禁用音频循环是否支持虚拟化。 |
| `au.VirtualLoops.ForceUpdateListenerMoveDistance` | `2500` | 设置强制更新虚拟化音频所需的距离阈值，以检查监听器是否在给定距离内以单帧移动。 |
| `au.VirtualLoops.PerfDistance` | `15000` | 设置虚拟循环距离，使更新速率在超越最大可听音效距离的最小值和最大值之间缩放。 |
| `au.VirtualLoops.UpdateRate.Max` | `3` | 设置最大速率，以便检查音效是否再次可听（超出音效的最大可听距离+性能缩放距离）。 |
| `au.VirtualLoops.UpdateRate.Min` | `0.1` | 设置最小速率，以便检查在音效的最大可听距离处，音效是否再次可听。 |
| `au.voip.AlwaysPlayVoiceComponent` | `1` | 当设置为1时，保证voip组件不会被降低优先级。 0：让voip组件终止；1：强制VOIP组件优先级高于所有其他音频源。 |
| `au.vorbis.ReadFailiureTimeout` | `1` | 当设置为1时，如果在多次尝试后仍无法成功解码Ogg Vorbis音效，我们将会放弃解码。 |
| `au.WaitForSoundWaveToLoad` | `1` | 设置为1时，除非已加载USoundWave，否则将拒绝播放任何音效。 0：尝试播放，1：等待加载。 |
| `au.WaveInstanceMinVolume` | `0.0001` | 设置被视为激活的声波实例的最小音量 默认值为0.0001（-80 dB） |
| `au.WorldlessGetAudioTimeBehavior` | `0` | 确定当音频组件不属于世界时GetAudioTime的返回值。 0：0.f（默认），1：应用程序的CurrentTime |
| `AudioCommand.FenceWaitTimeMs` | `35` | 设置栅栏等待的毫秒数 |
| `AudioThread.AboveNormalPriority` | `0` | 0=Normal，1=AboveNormal |
| `AudioThread.BatchAsyncBatchSize` | `128` | 当AudioThread.EnableBatchProcessing=1时，控制分组在一起进行线程处理的音频命令的数量。 |
| `AudioThread.EnableAudioCommandLogging` | `0` | 0=禁用，1=启用 |
| `AudioThread.EnableAudioThreadWait` | `1` | 启用等待音频线程完成其命令。 0：未启用，1：启用 |
| `AudioThread.EnableBatchProcessing` | `1` | 启用批处理音频线程命令。 0：未启用，1：启用 |
| `AudioThread.SuspendAudioThread` | `0` | 0=恢复，1=暂停 |
| `AudioThread.UseBackgroundThreadPool` | `1` | 如果为true，使用后台线程池进行实时音频解压缩。 |

## 自动化

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Automation.CaptureLogEvents` | `true` | 将测试期间的警告/错误日志事件视为影响测试本身 |
| `Automation.EnableStereoTestVariants` | `false` | 是否为屏幕截图功能测试启用立体声测试变体 |
| `Automation.LightweightStereoTestVariants` | `true` | 是否在基线测试失败时跳过变体，并跳过为成功变体保存屏幕截图 |
| `Automation.LogBPTestMetadata` | `false` | 测试运行时是否将蓝图功能测试元数据输出到日志 |
| `Automation.LogTestStateTrace` | `false` | 是启用还是禁用测试状态追踪日志记录 |
| `Automation.SkipStackWalk` | `false` | 是否跳过自动化测试框架触发的任何堆栈问题 |
| `AutomationAllowFrameTraceCapture` | `1` | 允许自动捕获帧追踪。 |
| `AutomationScreenshotResolutionHeight` | `0` | 自动化屏幕截图的高度。 |
| `AutomationScreenshotResolutionWidth` | `0` | 自动化屏幕截图的宽度。 |

## 反向通道

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `backchannel.logerrors` | `1` | 记录数据包错误 |
| `backchannel.logpackets` | `0` | 记录传入数据包 |

## 信标

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `beacon.DelayCancellationResponse` | `0` | 从收到取消响应到通知之间的延迟时间，以秒为单位 |
| `beacon.DelayFinishHandshake` | `0` | 在通过调用客户端RPC完成握手之前的延迟时间 时间以秒为单位。值为0表示没有延迟，负值表示从不调用它。 |
| `beacon.DelayFinishHandshakeBeaconType` |  | 要应用握手延迟的信标类型。 全部留空。 |
| `beacon.DelayFullResponse` | `0` | 从收到全面响应到通知之间的延迟时间，以秒为单位 |
| `beacon.DelayReservationResponse` | `0` | 从收到响应到通知之间的延迟时间，以秒为单位 |
| `beacon.DelayUpdateResponse` | `0` | 从收到更新响应到通知之间的延迟时间，以秒为单位 |
| `beacon.RequireInitiatorIsPartyLeader` | `true` | 强制RPC验证，该验证将检查预定RPC的发起者是否是一方主导者 启用 |

## 行为树

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `BehaviorTree.ApplyAuxNodesFromFailedSearches` | `false` | 应用失败搜索中的辅助节点 |
| `BehaviorTree.RecordFrameSearchTimes` | `0` | 记录每帧的搜索次数，用于性能统计 |

## 比特读取器

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `BitReader.LogFatalOnOverflow` | `false` | LogFatal（如果BitReader溢出） |

## 蓝图

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Blueprint.PC_Real.DisplayMode` | `1` | 实数命名模式 0：实数 1：浮点（默认） 2：数字 注意需要重新启动编辑器才能完全生效 |
| `BP.ActionMenuFilterCacheLeafCapacity` | `32` | 要同时缓存的操作菜单上下文的数量。提高该数字会增加内存占用，但会降低清理缓存的频率 |
| `BP.bAllowConversionOfComparisonOps` | `true` | 如果为true，则允许用户在UK2Node_PromotableOperator上的比较操作符之间进行转换 |
| `BP.bEnableSkelReinstUpdate` | `true` | 如果为true，SKEL类的Reinstancing将使用新的FBlueprintCompileReinstancer::MoveDependentSkelToReinst(o(n))，而不是旧的MoveSkelCDOAside (o(n^2)) |
| `BP.bForceAllDependenciesToRecompile` | `false` | 如果为true，即使所有引用的函数都没有签名更改，所有依赖项将进行字节码编译。用于编译器开发/调试目的。 |
| `bp.bForcePastedComponentsToSCS` | `true` | 若将此项设置为True，粘贴到蓝图中的实例化组件将更改为SCS组件 |
| `bp.BlamePrintString` | `false` | 当为true时，将打印生成了Print String调用的蓝图资产和函数。适合用于跟踪屏幕消息垃圾邮件。 |
| `bp.ComponentInstancingFastPathDisabled` | `0` | 禁用蓝图组件实例化快速路径。 |
| `BP.ContextMenu.CategoryWeight` | `4` | 与用户输入内容相匹配的类别所占的权重额 |
| `BP.ContextMenu.ContainerBonus` | `1000` | 如果从引脚中拖动的对象与操作的容器类型相匹配，则给予加值 |
| `BP.ContextMenu.DescriptionWeight` | `10` | 在搜索项描述上放置的权重额 |
| `BP.ContextMenu.FavoriteBonus` | `1000` | 如果节点为收藏项则给予加值 |
| `BP.ContextMenu.KeywordWeight` | `30` | 在搜索项关键字上放置的权重额 |
| `BP.ContextMenu.MatchingFromPinCategory` | `500` | 在与被拖移的节点具有相同类别的操作上放置的权重额 |
| `BP.ContextMenu.MaxWordLength` | `30` | 在奖励短词权重时计入的最大长度 |
| `BP.ContextMenu.NodeTitleWeight` | `10` | 在搜索项标题上放置的权重额 |
| `BP.ContextMenu.PercentageMatchWeightMultiplier` | `1` | 一个乘数，用于根据匹配的百分比给予某对象多少权重 |
| `BP.ContextMenu.ShorterWeight` | `10` | 增大此权重会让较短的词语更受欢迎 |
| `BP.ContextMenu.StartsWithBonusWeightMultiplier` | `4` | 如果关键字以用户键入的词语开头，则给出乘数 |
| `BP.ContextMenu.WordContainsLetterWeightMultiplier` | `0.5` | 如果关键字仅包含用户键入的词语，则给出乘数 |
| `bp.DatabasePrimingMaxPerFrame` | `16` | 每帧应向数据库填充的条目数。 |
| `bp.DebuggerEnableExternalSearch` | `false` | 允许Blueprint Debugger TreeView控件搜索外部对象 |
| `bp.DebuggerMaxSearchDepth` | `50` | Blueprint Debugger TreeView控件的最大搜索深度（设置为<=0，获得无限深度） |
| `bp.DefaultSubobjectValidationDisabled` | `1` | 在编辑器加载/保存时禁用蓝图类默认子对象。 |
| `bp.DisableSearchDataUpdateOnSave` | `false` | 不要在保存时更新蓝图搜索元数据（仅用于QA/测试目的）。在编辑器重新启动时，它应该在第一次搜索后将BP包含在未索引计数中。 |
| `BP.EnableActionMenuFilterCaching` | `false` | 启用后，设有CacheResults标记的操作筛选器测试将缓存其结果 |
| `bp.EnableAutomaticLibraryAssetLoading` | `1` | 打开BP编辑器是否应加载所有宏和函数库资产？ 0：禁用，1：启用（默认为启用） 未加载库中定义的节点将不会显示在上下文菜单中！ |
| `bp.EnableDeprecatedWarningForComponentDelegateNodes` | `true` | 显示组件委托事件节点的废弃警告 |
| `BP.EnableNamespaceFilteringFeatures` | `true` | 在蓝图编辑器中启用命名空间筛选功能（试验性）。 |
| `BP.EnableNamespaceImportingFeatures` | `true` | 在蓝图编辑器中启用命名空间导入功能（试验性）。 |
| `bp.ForceOldSearchDataFormatVersionOnSave` | `false` | 强制蓝图搜索元数据在保存时使用旧格式版本（仅用于QA/测试目的）。在编辑器重新启动时，它应该在第一次搜索后将BP包含在过时计数中。 |
| `bp.GenerateFieldNotifyBroadcastForOnRepFunction` | `true` | 需要时，在调用OnRep函数时生成Broadcast FieldNotification节点。 |
| `BP.ImportParentClassNamespaces` | `false` | 在打开蓝图进行编辑时启用父类命名空间的导入。 |
| `bp.MaxFunctionStatDepth` | `255` | 用于记录每个函数统计的脚本堆栈阈值。 |
| `bp.NativePropertyInitFastPathDisabled` | `0` | 禁用原生属性初始化快速路径。 |
| `bp.PinValidityCheck.bDisplayInvalidPinWarning` | `true` | 控制台变量将控制引脚有效性警告，该警告将在宏图表静默失败时抛出 |
| `bp.PinValidityCheck.bDisplayMissingBoundComponentWarning` | `true` | 控制台变量将控制引脚有效性警告，该警告将在绑定事件没有匹配组件时抛出 |
| `bp.ScriptRecurseLimit` | `120` | 设置在无限循环中考虑脚本之前的递归次数。 |
| `bp.ShortScriptWarnings` | `0` | 缩短蓝图异常日志。 |
| `bp.UseLegacyAnimInstanceReinstancingBehavior` | `false` | 在销毁和重新创建实例的动画实例中使用旧版重新实例化行为。 |
| `bp.VerboseStats` | `0` | 为蓝图执行创建额外的统计数据。 |

## 构建

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `buildidoverride` | `0` | 设置用于匹配的构建ID |
| `BuildPatchFileConstructor.bStallWhenFileSystemThrottled` | `false` | 文件系统受限时是否停顿 |
| `BuildPatchFileConstructor.SleepTimeWhenFileSystemThrottledSeconds` | `15` | 如果目标文件系统受限，为需要的休眠时间。 |

## 子Actor

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `cac.ExperimentalAllowPerInstanceChildActorProperties` | `0` | [试验性]如果为true，允许在每个实例的基础上修改子Actor的属性。 |

## 画布

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Canvas.DistanceFieldSmoothness` | `4` | 由画布渲染的距离场字体/形状的全局清晰度。 |

## 导致卡顿

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `CauseHitches` | `0` | 导致每秒卡顿200毫秒。卡顿大小由CauseHitchesHitchMS控制 |
| `CauseHitchesHitchMS` | `200` | 控制由CauseHitch引起的卡顿的大小（以毫秒为单位）。 |

## Chaos调试

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Chaos.Debug.RadialImpulseDistributeToChildren` | `true` | 当一个应用到一个几何体集合群集时，冲量将在所有子项之间平均分配 |
| `Chaos.Debug.StrainModifier` | `200` | （已废弃）当使用径向冲量时，通过将冲量乘以此因子来计算张力 |

## 群集并集

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `ClusterUnion.ApplyReplicatedRigidStateOnCreatePhysicsState` | `true` | 创建物理状态时，应用复制的刚性状态。很有用，因为有时在代理存在之前已经调用初始OnRep，因此将取消设置初始属性 |
| `ClusterUnion.DirtyRigidStateOnlyIfChanged` | `false` | 在将更改的刚性状态标记为脏状态并更新复制的数据之前，添加检查。如果没有更改，则不需要刷新更新。 |
| `ClusterUnion.FlushNetDormancyOnSyncProxy` | `true` | 当权限有新的刚性状态时，将刷新网络休眠，这样即使该对象处于网络休眠状态，刚性状态也会传递给客户端。 |
| `ClusterUnion.LocalBoneDataMapGrowFactor` | `1.2` | 当预分配局部骨骼数据贴图时，生长因子应用于预先存在组件的骨骼数据数组的大小 |
| `ClusterUnion.PreAllocateLocalBoneDataMap` | `true` | 如果为true，它将保留用于缓存更新后骨骼数据的局部贴图的预期大小 |
| `ClusterUnion.SkipZeroStateInOnRep` | `true` | 在为群集并集的复制刚性状态运行onrep时，是否跳过0（未初始化）状态 |
| `ClusterUnion.StressSolver.EnableDebugDraw` | `false` | 启用后，将绘制有关应力解算器执行的视觉调试信息。 |
| `ClusterUnion.StressSolver.StrengthScalar` | `1` | Materioal强度标量（<1：更弱，>1：更强） |
| `ClusterUnion.UseAccelerationStructure` | `true` | 针对群集并集的组件级别扫描和重叠是否应使用加速结构。 |
| `ClusterUnion.UseLocalRoleForAuthorityCheck` | `true` | 如果为true，将仅检查此组件的所有者局部角色以确定权限 |

## 集合

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Collections.MaxCLDescriptionPathCount` | `1000` | 设置在检查添加或删除条目的集合时在更改列表中报告的路径数上限。 |

## 兼容性

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Compat.MAX_GPUSKIN_BONES` | `65536` | 单个绘制调用中可以在GPU上蒙皮的骨骼数量上限。此设置限制每个平台的项目限制URendererSettings::MaxSkinBones。无法在运行时更改。 |
| `Compat.UseDXT5NormalMaps` | `0` | 是否将DXT5用于法线贴图，否则将使用BC5，后者并非在所有硬件上都受支持。 两种格式需要相同内存量（如果驱动程序不模拟该格式）。 更改此变量会导致法线贴图在下次加载时重新压缩（或使用重新编译着色器） 0：使用BC5纹理格式（默认） 1：使用DXT5纹理格式（更低质量） |

## 主机

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `con.MinLogVerbosity` | `0` | 允许在游戏主机中查看日志（默认禁用以避免垃圾邮件和轻微性能损失）。 0：除主机响应之外没有日志记录（默认） 1：仅致命错误（不是很有用） 2：其他错误 3：其他警告 4：其他显示 5：其他日志 .. >=7：全部 |
| `console.CmdLink.enable` | `false` | 打开一个管线，该管线运行作为命令行参数传递给CmdLink.exe的命令 |
| `console.CmdLink.key` | `None` | 更改用于连接到CmdLink.exe管线的名称 |
| `console.position.enable` | `0` | 启用自定义主机定位 |
| `console.position.x` | `0` | 主机从左侧边界的X偏移 |
| `console.position.y` | `0` | 主机从底部边界的Y偏移 |
| `console.searchmode.legacy` | `false` | 使用控制台命令的旧版搜索行为 |

## 约束

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Constraints.DebugDependencies` | `false` | 在创建新约束时打印有关依赖项的调试信息。 |
| `Constraints.DebugEvaluationGraph` | `false` | 打印有关约束求值图表的调试信息。 |
| `Constraints.IncludeTarget` | `true` | 在获取子项的现有约束时包括目标。 |
| `Constraints.PreEvaluateChild` | `true` | 在约束计算之前强制子项求值。 |
| `Constraints.PreTickChild` | `false` | 在约束计算之前强制子项刷新。 |
| `Constraints.UseEvaluationGraph` | `true` | 操控时使用求值图表更新约束。 |

## 内容浏览器

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `ContentBrowser.Debug.CrumbsEnumerate` | `true` | 枚举痕迹 |
| `ContentBrowser.HideSaveCollectionButton` | `false` | 隐藏内容浏览器按钮，以将搜索保存为动态集合。 |
| `ContentBrowser.ShowCustomVirtualFolderIcon` | `1` | 是否在内容浏览器中显示为了方便整理而添加的自定义虚拟文件夹的特殊图标。例如，插件中的EditorCustomVirtualPath字段 |
| `ContentBrowser.ShowPluginFolderIcon` | `1` | 是否在内容浏览器中显示插件文件夹的特殊图标。 |

## 上下文菜单

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `ContextMenu.CategoryWeight` | `1` | 与用户输入内容相匹配的类别所占的权重额 |
| `ContextMenu.DescriptionWeight` | `10` | 在搜索项描述上放置的权重额 |
| `ContextMenu.KeywordWeight` | `4` | 在搜索项关键字上放置的权重额 |
| `ContextMenu.NodeTitleWeight` | `1` | 在搜索项标题上放置的权重额 |
| `ContextMenu.PrintDebugInfo` | `false` | 打印有关上下文菜单选择的调试信息 |
| `ContextMenu.WholeMatchLocalizedWeightMultiplier` | `3` | 如果存在与搜索词的精确本地化匹配，则给出乘数 |
| `ContextMenu.WholeMatchWeightMultiplier` | `2` | 如果存在与搜索词的精确匹配，则给出乘数 |

## 控制器

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Controller.InvalidControlRotationMagnitude` | `8.38861e+06` | 如果传递给SetControlRotation的FRotator的任何组件大于此量级，则忽略该值。大值通常来自未初始化的变量，并可能导致NaN/Inf稍后传播。 |

## 控制绑定

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `ControlRig.CreateFloatControlsForCurves` | `0` | 如果非零，则为曲线容器中的每条曲线创建一个浮点控制，这对于调试低级控制很有用。 |
| `ControlRig.DisableExecutionInAnimNode` | `0` | 如果非零，将在动画节点中禁用控制绑定的执行。 |
| `ControlRig.DisableExecutionInComponent` | `0` | 如果非零，将在ControlRigComponent中禁用控制绑定的执行。 |
| `ControlRig.EnableDrawInterfaceInGame` | `0` | 如果非零，将在运行期间启用调试绘制。 |
| `ControlRig.Hierarchy.EnableRotationOrder` | `true` | 启用控制的旋转顺序 |
| `ControlRig.Hierarchy.Modules` | `true` | 启用模块化绑定功能 |
| `ControlRig.Hierarchy.TraceAlways` | `0` | 如果非零，将记录所有的变换更改。 |
| `ControlRig.Hierarchy.TraceCallstack` | `0` | 如果非零，将记录任何追踪条目的调用堆栈。 仅在(ControlRig.Hierarchy.TraceEnabled != 0)时才适用 |
| `ControlRig.Hierarchy.TraceOnSpawn` | `0` | 设置生成新的层级时要追踪的帧数 |
| `ControlRig.Hierarchy.TracePrecision` | `3` | 设置追踪层级时浮点中的位数。 |
| `ControlRig.Preview.ShowSchematicPanelOverlay` | `true` | 当为true时，将向角色添加覆层，以显示模块化绑定信息。 |
| `ControlRig.Sequencer.AutoGenerateTrack` | `true` | 当为true时，在向关卡添加控制绑定时自动创建控制绑定轨道。 |
| `ControlRig.Sequencer.ClickSelectThroughGizmo` | `false` | 当为false时，如果在动画模式下选择小工具，则不能点击小工具并更改选择，默认为false。 |
| `ControlRig.Sequencer.EnableAdditiveControlRigs` | `true` | 当为true时，可以向骨骼网格体组件添加叠加控制绑定。 |
| `ControlRig.Sequencer.SelectedKeysSelectControls` | `false` | 当为true时，若在Sequencer中选择关键帧，它将选择控制，默认为false。 |
| `ControlRig.Sequencer.SelectedSectionSetsSectionToKey` | `true` | 当为true时，若在分段中选择通道，如果它是唯一被选中的分段，我们将其设置为分"段至关键帧（Section To Key）"，默认为false。 |
| `ControlRig.Test.EnableTestingToolbar` | `false` | 当为true时，将在控制绑定编辑器中显示测试工具栏。 |

## 烘焙

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `cook.AllowASTCHDRProfile` | `0` | 是否允许ASTC HDR配置文件，hdr格式仅在某些设备上受到支持，例如Apple A13、Mali-G72、Adreno (TM) 660 |
| `Cook.AllowContentValidation` | `true` | 如果为true，则允许在烘焙期间运行内容验证（如果请求），如果为false，则禁用。 |
| `cook.AllowCookedDataInEditorBuilds` | `0` | 如果为true，则允许在编辑器中加载烘焙后的资产。 |
| `cook.ASTCTextureCompressor` | `1` | 0：IntelISPC，1：ARM |
| `Cook.CookAllByDefault` | `true` | 当FilesInPath为空时。默认烘焙所有包。 |
| `Cook.display.diagnostictime` | `30` | 控制烘焙器诊断消息间隔的时间。 |
| `cook.display.repeattime` | `5` | 控制烘焙器将重复同一条进度消息之前的时间。 |
| `cook.display.updatetime` | `2` | 控制烘焙器将发送一条新的进度消息之前的时间。 |
| `Cook.display.warnbusytime` | `120` | 控制烘焙器将发出一条说明忙碌队列中出现死锁的警告之前的时间。 |
| `cook.displaymode` | `1` | 控制包的烘焙器日志的显示： 0：不显示 1：显示剩余包的数量 2：按名称显示每个包 3：显示名称和计数 4：显示每个包的发起者 5：显示发起者和数量 6：显示发起者和名称 7：显示发起者及名称和数量 |
| `cook.PollAsyncPeriod` | `0.1` | PollPendingCookedPlatformData间隔的最小时间，以秒为单位。 |
| `Cook.retrybusytime` | `0.01` | 当保存和加载队列繁忙且没有其他工作要做时，控制保存和加载时重试的时间间隔。 |
| `cook.SkipAsyncLoaderForCookedData` | `0` | 如果为true，则跳过异步加载器并同步加载包头文件，以减少线程之间的乒/乓。 |

## 核心

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Core.bFastDecimalFormatLargeFloatSupport` | `1` | True意味着对9223372036854775807以上的浮点类型执行额外的处理，以防止裁剪到该值。 |
| `core.EnsureAlwaysEnabled` | `true` | 设置为false可将ensureAlways转换为常规ensure |
| `core.EnsuresAreErrors` | `1` | True表示失败的ensure被记录为错误。False表示它们被记录为警告。 |

## CPFUO

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `cpfuo.AuditAggressiveReferenceReplacment` | `true` | 是否对来自主动替换路径的引用替换进行审核和报告。 |
| `cpfuo.UseAggressiveReferenceReplacment` | `false` | 是否积极替换引用。此行为将被废弃，但在出现问题时仍可以切换回去。 |

## 关键路径停顿

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `CriticalPathStall.AfterInitViews` | `0` | 在InitViews之后休眠给定时间。时间以毫米为单位。这是一个调试选项，用于关键路径分析和强制更改关键路径。 |
| `CriticalPathStall.ParallelAnimation` | `0` | 在每个并行动画任务中休眠给定时间。时间以毫米为单位。这是一个调试选项，用于关键路径分析和强制更改关键路径。 |
| `CriticalPathStall.TickStartFrame` | `0` | 在开始帧中休眠给定时间。时间以毫米为单位。这是一个调试选项，用于关键路径分析和强制更改关键路径。 |

## CSV

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `csv.AlwaysShowFrameCount` | `false` | 启用后，即使屏幕消息被禁用，也将在非发布构建中显示帧数 |
| `csv.BlockOnCaptureEnd` | `1` | 当为1时，将阻止游戏线程，直到捕获结束时CSV文件被完全写入。当为0时，在文件被写入时，不会阻止游戏线程。 |
| `csv.CompressionMode` | `-1` | 控制CSV文件在写出时是否压缩。-1=（默认）如果启动捕获的代码选择了压缩，则使用压缩。0=强制禁用压缩。所有文件都将作为未压缩.csv文件写入。1=强制启用压缩。所有文件都将作为压缩.csv.gz文件写入。 |
| `csv.ContinuousWrites` | `1` | 当为1时，完成的CSV行被转换为CSV格式字符串，并在捕获过程中附加到写入缓冲区。当为0时，CSV行作为二进制数据在内存中积累，仅在捕获结束时转换为字符串并刷新到磁盘。 |
| `csv.DetailedTickContext` | `0` | 为CSV中的更新计数给出更多详细信息 |
| `csv.ForceExit` | `0` | 如果为1，在启用exitOnCompletion时，执行强制退出 |
| `csv.FramesToBuffer` | `128` | 定义在刷新帧之前要保留在内存中的最小帧数。 |
| `csv.MaxPerThreadStatDataSlackKB` | `64` | 捕获期间允许的每个线程松驰数据的最大数量。值更高，性能更好，因为分配更少，但内存开销更高 |
| `csv.NamedEventsExclusive` | `false` | 确定是否为排他性统计发出具名事件 |
| `csv.NamedEventsTiming` | `false` | 确定是否为非排他性定时统计发出具名事件 |
| `csv.PauseProcessingThread` | `0` | 仅调试 - 当为1时，将阻止处理线程以模拟饥饿 |
| `csv.RecordActorCounts` | `1` | 执行CSV捕获时按类记录Actor数量 |
| `csv.RecordActorCountsThreshold` | `5` | 录制到CSV统计数据之前所需的原生Actor类的实例数 |
| `csv.RecordActorCountThreshold` | `5` | 录制到CSV统计数据之前所需的原生Actor类的实例数 |
| `csv.RecordTickCounts` | `1` | 执行CSV捕获时按上下文记录更新数量 |
| `csv.statCounts` | `0` | 如果为1，输出数量统计数据 |
| `csv.TargetFrameRateOverride` | `0` | 如果为0，默认为使用rhi.SyncInterval和最大刷新率计算目标帧率。 |
| `csv.trackWaitsAllThreads` | `false` | 确定是否追踪所有线程上的等待。注意，这会产生大量开销 |
| `csv.trackWaitsGT` | `true` | 确定是否追踪游戏线程等待。注意，这会产生开销 |
| `csv.trackWaitsRT` | `true` | 确定是否追踪渲染线程等待。注意，这会产生开销 |
| `csv.WriteBufferSize` | `131072` | 如果非零，定义写入CSV文件时要使用的写入缓冲区的大小。GZip压缩输出需要一个非零值。 |

## 曲线

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `CurveEditor.DrawCurveKeys` | `true` | 当为true时，将绘制曲线关键帧，当为false时不绘制。 |
| `CurveEditor.DrawCurveLines` | `true` | 当为true时，将绘制曲线，当为false时不绘制。 |
| `CurveEditor.MaxCurvesPerPinnedView` | `0` | 当CurveEditor.PinnedViews为1时，将定义固定视图上允许的曲线数上限（0表示没有最大值）。 |
| `CurveEditor.PinnedViews` | `0` | 固定曲线是否还应导致曲线被专门添加到固定视图（默认值：关闭），而不是简单地始终保持可见。 |
| `CurveEditor.UseCurveCache` | `true` | 当为true时，将缓存曲线值，当为false时，我们将始终重新生成。 |
| `CurveTable.RemoveRedundantKeys` | `1` |  |

## D3D12

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `D3D12.AdjustTexturePoolSizeBasedOnBudget` | `0` | 指示当应用程序超过操作系统提供的内存预算时，RHI是否应该降低纹理池大小。这可能导致纹理质量降低（但有可能提高性能）。 |
| `d3d12.AllowDiscardResources` | `1` | 获取临时锯齿后是否调用DiscardResources。在某些平台上，如果新获得的资源在使用前被清除，则不需要这样做。 |
| `d3d12.AllowPoolAllocateIndirectArgBuffers` | `0` | 允许间接参数被池分配（否则它们将被提交资源）（默认值：0） |
| `d3d12.BatchResourceBarriers` | `1` | 是否允许批处理资源屏障 |
| `D3D12.Bindless.ResourceDescriptorHeapSize` | `100000` | 无绑定资源描述符堆大小 |
| `D3D12.Bindless.SamplerDescriptorHeapSize` | `2048` | 无绑定取样器描述符堆大小 |
| `D3D12.BindlessOnlineDescriptorHeapBlockSize` | `2000` | 全局视图描述符堆上的子分配的块大小。 |
| `D3D12.BindlessOnlineDescriptorHeapSize` | `500000` | 在线描述符堆大小 |
| `d3d12.BindResourceLabels` | `1` | 是否启用调试名称到D3D12资源的绑定。 |
| `D3D12.EmitRgpFrameMarkers` | `0` | 启用/禁用AMD的RGP工具的帧标识。 |
| `D3D12.EvictAllResidentResourcesInBackground` | `false` | 当应用程序未受到关注时，强制D3D12资源常驻管理器清除所有追踪的未使用资源 |
| `d3d12.ExtraDepthTransitions` | `0` | 为深度缓冲区添加额外的过渡以修复验证问题。但这目前断开了异步计算 |
| `d3d12.FastAllocator.MinPagesToRetain` | `5` | 要保留的页数下限。低于此限制的页面将始终不会被释放。高于此限制的页面在未使用一定帧数后可以被释放。 |
| `d3d12.FastConstantAllocatorPageSize` | `65536` | 快速常量分配器的页面大小 |
| `D3D12.GlobalResourceDescriptorHeapSize` | `1000000` | 全局资源描述符堆大小 |
| `D3D12.GlobalSamplerDescriptorHeapSize` | `2048` | 全局取样器描述符堆大小 |
| `D3D12.GlobalSamplerHeapSize` | `2048` | 全局取样器描述符堆大小 |
| `D3D12.InsertOuterOcclusionQuery` | `0` | 如果为true，则在遮挡查询批次周围启用一个虚拟的外遮挡查询。可以提高一些GPU架构上的性能 |
| `D3D12.LocalViewHeapSize` | `500000` | 局部视图堆大小 |
| `D3D12.LockTexture2DRHIFlush` | `0` | 启用后，在LockTexture2D上执行RHIThread清空。可能在任何平台上都不需要，但目前仅用于测试目的 0：关闭（默认） 1：打开 |
| `D3D12.LogViewportEvents` | `0` | 记录所有视口事件。 |
| `D3D12.MaxCommandsPerCommandList` | `10000` | 在一定数量的列队命令之后将命令列表刷新到GPU（绘制、调度、复制...）（默认值10000） |
| `D3D12.OnlineDescriptorHeapBlockSize` | `2000` | 全局视图描述符堆上的子分配的块大小。 |
| `D3D12.OnlineDescriptorHeapSize` | `500000` | 在线描述符堆大小 |
| `d3d12.PoolAllocator.ReadOnlyTextureMaxAllocationSize` | `67108864` | VRAM ReadOnly纹理池分配器中单个分配的最大大小（默认值64MB） |
| `d3d12.PoolAllocator.ReadOnlyTextureVRAMPoolSize` | `67108864` | 单个VRAM ReadOnly纹理内存池的池大小（默认为64MB） |
| `d3d12.PoolAllocator.RTUAVTextureMaxAllocationSize` | `0` | VRAM RTUAV纹理池分配器中单个分配的最大大小（默认值0MB - 禁用） |
| `d3d12.PoolAllocator.RTUAVTextureVRAMPoolSize` | `0` | 单个VRAM RTUAV纹理内存池的池大小（默认值0MB-禁用） |
| `D3D12.PSO.DiskCache` | `0` | 为管线状态对象启用磁盘缓存（PSO）。 PSO说明缓存到磁盘，以便后续运行可以在加载时而不是在运行时创建PSO。 此缓存包含独立于创建它的硬件、驱动程序或计算机的数据。它可以与发布内容一起提供。 0：禁用管线状态盘缓存 1：启用管线状态盘缓存（默认） |
| `D3D12.PSO.DriverOptimizedDiskCache` | `0` | 为驱动优化的管线状态对象（PSO）启用磁盘缓存。 PSO说明缓存到磁盘，以便后续运行可以在加载时而不是在运行时创建PSO。 此缓存包含特定于创建它的硬件、驱动程序和计算机的数据。 0：禁用驱动优化的管线状态磁盘缓存 1：启用驱动优化的管线状态磁盘缓存 |
| `D3D12.PSO.StallWarningThresholdInMs` | `100` | 设置一个阈值，说明何时记录由于PSO创建而导致的停顿消息。 值以毫秒为单位。（100为默认值） |
| `D3D12.PSOPrecache.KeepLowLevel` | `0` | 在内存中保留d3d12 PSO blob用于预缓存PSO。会消耗更多内存，但会减少停顿。 |
| `d3d12.ReadOnlyTextureAllocator.MaxPoolSize` | `20971520` | 每个大小列表的最大分配粒度（以字节为单位） |
| `d3d12.ReadOnlyTextureAllocator.MinNumToPool` | `8` | 每个大小列表的纹理池必须足够大以存储如此多的纹理，除非受到最大分配粒度的限制 |
| `d3d12.ReadOnlyTextureAllocator.MinPoolSize` | `4194304` | 每个大小列表的最小分配粒度（以字节为单位） |
| `d3d12.ReservedResourceHeapSizeMB` | `16` | 预留资源的支持堆大小，以兆字节为单位（默认值16MB）。 |
| `D3D12.ResidencyManagement` | `1` | 控制D3D12资源常驻管理是否激活（默认值=打开）。 |
| `D3D12.SamplerWarningThreshold` | `10` | 用于启动有关创建过多采样器状态的警告的阈值 |
| `d3d12.SegListTrackLeaks` | `0` | 1：在d3d12 seglist中启用泄漏追踪 |
| `D3D12.StablePowerState` | `0` | 如果为true，启用稳定电源状态。这将提高GPU定时测量精确度，但可能会降低整体GPU时钟速率。 |
| `D3D12.TexturePoolOnlyAccountStreamableTexture` | `false` | 纹理流送池大小仅考虑可流送纹理。 - 0：池中所有纹理类型都计算在内（旧版，默认）。 - 1：池中仅可流送纹理计算在内。 当启用新行为时，r.Streaming.PoolSize将需要重新调整。 |
| `D3D12.TrackAllAllocations` | `0` | 控制D3D12 RHI是否应追踪所有分配信息（默认=关闭）。 |
| `D3D12.TrackedReleasedAllocationFrameRetention` | `100` | 当启用资源追踪时，保留空闲分配数据的帧数 |
| `d3d12.TransientAllocator.FullAliasingBarrier` | `0` | 在临时获取操作上插入一个完整的锯齿屏障。适合用于在锯齿丢失时进行调试。 |
| `D3D12.UnsafeCrossGPUTransfers` | `true` | 禁用跨GPU同步正确性以提高性能（默认值：true）。 |
| `d3d12.UploadAllocator.PendingDeleteSizeForceFlushInGB` | `1` | 如果在挂起的delete队列中达到给定的GB阈值，将触发强制GPU清空以减少内存负载（默认为1，0表示禁用） |
| `d3d12.UploadHeap.BigBlock.MaxAllocationSize` | `67108864` | 上传内存的大块分配器上的最大分配大小 |
| `d3d12.UploadHeap.BigBlock.PoolSize` | `8388608` | 上传内存大块分配器的池大小 |
| `d3d12.UploadHeap.SmallBlock.MaxAllocationSize` | `65536` | 上传内存的小块分配器上的最大分配大小 |
| `d3d12.UploadHeap.SmallBlock.PoolSize` | `4194304` | 上传内存小块分配器的池大小 |
| `D3D12.UseUpdateTexture3DComputeShader` | `0` | 启用后，为UpdateTexture3D使用计算着色器。避免对齐限制 0：关闭（默认） 1：打开 |
| `d3d12.VRAMBufferPoolDefrag` | `1` | 对VRAM缓冲池进行碎片整理 |
| `d3d12.VRAMBufferPoolDefrag.MaxCopySizePerFrame` | `33554432` | 在单帧碎片整理期间要复制的最大数据量（默认为32MB） |
| `d3d12.VRAMTexturePoolDefrag` | `1` | 对VRAM纹理池进行碎片整理（默认启用） |
| `d3d12.VRAMTexturePoolDefrag.MaxCopySizePerFrame` | `33554432` | 在单帧碎片整理期间要复制的最大数据量（默认为32MB） |
| `D3D12.ZeroBufferSizeInMB` | `4` | D3D12 RHI需要静态零分配，在异步流送纹理时使用。它应该足够大，以支持你需要流送的最大mipmap。默认值为4MB。 |

## DDC

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `DDC.Graph` | `Default` | 要用于派生数据缓存的图表的名称。 |

## 调试视图

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `DebugViewModeHelpers.Enable` | `true` | 指定是否启用调试视图模式着色器。通常仅对特殊情况下的编辑器构建禁用，前提是该构建不需要它们 |

## 试玩版

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `demo.AsyncLoadWorld` | `0` | 如果为1，将使用无缝服务器传输以异步加载重播世界 |
| `demo.CheckpointSaveMaxMSPerFrameOverride` | `-1` | 如果>=0，该值将重载CheckpointSaveMaxMSPerFrame成员变量，该变量是每帧用于保存检查点所允许的最大时间。如果为0，它将检查点保存在单个帧中，而不论花费多长时间。 |
| `demo.CheckpointUploadDelayInSeconds` | `30` |  |
| `demo.ClientRecordAsyncEndOfFrame` | `0` | 如果为true，将在与Slate并行的线程上调用TickFlush。 |
| `demo.CullDistanceOverride` | `0` | 如果>0，将表示到任何观看者的距离，其中将停止记录Actor。 |
| `demo.DecreaseRepPrioritizeThreshold` | `0.7` | 复制到优先级的Actor的百分比，其中优先级时间将增加。 |
| `demo.DestructionInfoPriority` | `2147483647` | 在录制期间分配给销毁信息的重播网络优先级。 |
| `demo.EnableCheckpoints` | `1` | 检查点是否保存在服务器上 |
| `Demo.ExceededBudgetWarningInterval` | `60` | 当>0时，将在用于演示录制超出时间预算的日志警告之间等待指定的秒数。 |
| `demo.FastForwardDestroyTearOffActors` | `1` | 如果为true，驱动程序将在快进重播时立即销毁所有断开的Actor。 |
| `demo.FastForwardIgnoreRPCs` | `1` | 如果为true，RPC将在快进播放期间被丢弃。 |
| `demo.FastForwardLevelsPausePlayback` | `0` | 如果为true，则在快进级别任务运行时暂停通道和播放。 |
| `demo.FastForwardSkipRepNotifies` | `1` | 如果为true，驱动程序将通过延迟对RepNotify函数的调用来优化快进，直到快进完成。 |
| `demo.ForceDisableAsyncPackageMapLoading` | `0` | 如果为true，将禁用网络资产的异步包映射加载。 |
| `demo.ForcePersistentLevelPriority` | `0` | 如果为true，在优先和使用流送关卡修复时，强制先记录持久关卡。 |
| `demo.GotoTimeInSeconds` | `-1` | 仅用于测试，跳转到一个特定时间 |
| `demo.IncreaseRepPrioritizeThreshold` | `0.9` | 复制到优先级的Actor的百分比，其中优先级时间将减少。 |
| `demo.InternalPauseChannels` | `1` | 如果为true，为PauseChannels运行标准逻辑，而不是让游戏通过FOnPauseChannelsDelegate处理它。 |
| `demo.JumpToEndOfLiveReplay` | `1` | 如果为true，当开始播放时快进到结束前几秒钟（如果回放仍在录制中）。 |
| `demo.LateActorDormancyCheck` | `1` | 如果为true，检查Actor是否应尽可能晚地休眠——在将其序列化到演示存档时。 |
| `demo.LateDestructionInfoPrioritize` | `0` | 如果为true，将在优先级阶段结束时处理销毁信息。 |
| `demo.LoadCheckpointGarbageCollect` | `1` | 如果非零，在清理旧的Actor和连接后，将在LoadCheckpoint期间调用CollectGarbage。 |
| `demo.Loop` | `0` | <1>：在播放结束时从头开始播放 / <0>：在播放结束时停止播放 |
| `demo.LoopCount` | `0` | 如果>1，将在播放如此多回放次数后停止播放。 |
| `demo.MaximumRecDestructionInfoTime` | `0.2` | 如果启用了每帧限制，则为要使用复制销毁信息的最大帧百分比。 |
| `demo.MaximumRepPrioritizePercent` | `0.7` | 在不考虑限制的情况下，可对Actor进行优先级排序的最大时间百分比。 |
| `demo.MinimumRepPrioritizePercent` | `0.3` | 在不考虑限制的情况下，必须对Actor进行优先级排序的最小时间百分比。 |
| `demo.MinRecordHz` | `0` | 每秒记录的演示帧数下限（谨慎使用） |
| `demo.QueueCheckpointChannels` | `1` | 如果为true，驱动程序将在检查点加载期间将创建的所有通道置于队列模式，以分摊跨多个帧生成新Actor的开销。 |
| `demo.RecordHz` | `8` | 每秒记录的演示帧数上限 |
| `demo.RecordHzWhenNotRelevant` | `2` | 当Actor不相关时，以此频率记录。 |
| `demo.RecordUnicastRPCs` | `false` | 当为true时，还记录与演示驱动程序共享网络驱动程序名称的Actor上的单播客户端rpc。 |
| `demo.ReplayStreamerAutoDemoPrefix` | `demo` | 生成自动演示名称时使用的前缀。 |
| `demo.ReplayStreamerAutoDemoUseDateTimePostfix` | `0` | 启用后，使用当前时间作为自动演示名称（而不是索引）的后缀 |
| `demo.SaveRollbackActorState` | `1` | 如果为true，回滚Actor将保存一些复制状态以便在重生时应用。 |
| `demo.SkipTime` | `0` | 跳过固定数量的网络重播时间（以秒为单位） |
| `demo.TimeDilation` | `-1` | 在演示播放期间重载时间膨胀（-1=不重载） |
| `demo.UseAdaptiveReplayUpdateFrequency` | `1` | 如果为1，将根据Actor在录制到重播时实际写入内容的频率计算NetUpdateFrequency |
| `demo.UseNetRelevancy` | `0` | 如果为1，将启用相关性检查和距离剔除，使用所有连接的客户端作为参考。 |
| `demo.ViewTargetPriorityScale` | `3` | 在启用优先级时，按此值缩放视图目标优先级。 |
| `demo.WithDeltaCheckpoints` | `0` | 如果为true，将检查点记录为前一个检查点的增量。 |
| `demo.WithGameSpecificFrameData` | `0` | 如果为true，允许在每个演示帧中记录特定于游戏的数据。 |
| `demo.WithLevelStreamingFixes` | `0` | 如果为1，提供关卡流送的修复（但破坏了向后兼容性）。 |
| `demo.WithTimeBurnIn` | `0` | 如果为true，将在屏幕上添加一条带有当前DemoTime和Changelist的消息。 |

## 细节面板

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `DetailsPanel.Style.EnableCardLayout` | `false` | 指定卡片布局是否对细节视图有效。 |
| `DetailsPanel.UI.ForceShowComponentEditor` | `false` | 如果为true，将强制组件编辑器在通常隐藏的UObject的主视口和蓝图细节面板中显示。 |

## 禁用孤立的引脚

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `DisableOrphanPins` | `0` | 0=启用孤立的引脚（默认），1=禁用孤立的引脚（注意：将来此选项将消失） |

## 池化线程超时

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `DoPooledThreadWaitTimeouts` | `false` | 启用后，使用旧行为每10ms唤醒池线程一次。否则，让池线程休眠，直至数据到达。 |

## 设备描述

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `dp.AllowScalabilityGroupsToChangeAtRuntime` | `0` | 如果为true，设备配置文件可伸缩性桶控制台变量将设置为scalabilitypriority，这允许它们在运行时进行更改。默认关闭。 |
| `dp.Override` |  | DeviceProfile重载-设置此选项将使用具名DP作为激活DP。此外，在设置之前（首次之后在设置之前执行dp.OverridePop），它将恢复所有之前的重载。 命令行-dp选项将在启动时重载此选项，但在运行时设置时不会重载此选项 |

## 转储

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `DumpCopyPropertiesForUnrelatedObjects` | `0` | 转储跨类复制的对象 |
| `DumpStatPackets` | `0` | 如果为true，转储统计数据包。 |

## 编辑器

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Editor.AllowPlayWorldFeature` | `true` | 当为true时，允许播放世界。 |
| `Editor.AsyncAssetCompilation` | `0` | 1 - 启用异步资产编译。 2 - 启用异步资产编译，但处于暂停状态（用于调试）。 启用后，资产将被占位符替换，直到可以减少游戏线程上的停顿，提高编辑器整体性能。 |
| `Editor.AsyncAssetCompilationMaxConcurrency` | `-1` | 设置并发资产编译的数量上限，-1表示无限制。 |
| `Editor.AsyncAssetCompilationMaxMemoryUsage` | `0` | 0 - 没有硬内存限制，将根据系统可用内存进行调整（推荐默认值）。 N -尝试将资产编译的总内存使用量限制为此数量（以GB为单位）。 在内存压力下，通过减少并发，尽量保持在指定内存限制下进行资产编译。 |
| `Editor.AsyncAssetCompilationMemoryPerCore` | `4` | 报告所需内存量的任务应保留多少内存量（以GB为单位） 未知（-1）。 |
| `Editor.AsyncAssetCompilationResume` | `0` | 暂停时要恢复的列队工作数。 |
| `Editor.AsyncSkinnedAssetCompilation` | `1` | 1 - 启用异步蒙皮资产编译。 2 - 启用异步蒙皮资产编译，但处于暂停状态（用于调试）。 启用后，蒙皮资产将被占位符替换，直到可以减少游戏线程上的停顿，提高编辑器整体性能。 |
| `Editor.AsyncSkinnedAssetCompilationMaxConcurrency` | `-1` | 设置并发蒙皮资产编译的数量上限，-1表示无限制。 |
| `Editor.AsyncSkinnedAssetCompilationResume` | `0` | 暂停时要恢复的列队工作数。 |
| `Editor.AsyncSoundWaveCompilation` | `1` | 1 - 启用异步声波编译。 2 - 启用异步声波编译，但处于暂停状态（用于调试）。 启用后，声波将被占位符替换，直到可以减少游戏线程上的停顿，提高编辑器整体性能。 |
| `Editor.AsyncSoundWaveCompilationMaxConcurrency` | `-1` | 设置并发声波编译的数量上限，-1表示无限制。 |
| `Editor.AsyncSoundWaveCompilationResume` | `0` | 暂停时要恢复的列队工作数。 |
| `Editor.AsyncStaticMeshCompilation` | `1` | 1 - 启用异步静态网格体编译。 2 - 启用异步静态网格体编译，但处于暂停状态（用于调试）。 启用后，静态网格体将被占位符替换，直到可以减少游戏线程上的停顿，提高编辑器整体性能。 |
| `Editor.AsyncStaticMeshCompilationMaxConcurrency` | `-1` | 设置并发静态网格体编译的数量上限，-1表示无限制。 |
| `Editor.AsyncStaticMeshCompilationResume` | `0` | 暂停时要恢复的列队工作数。 |
| `Editor.AsyncStaticMeshPlayInEditorDebugDraw` | `false` | 0 - 禁用异步静态网格体编译的调试绘制。 1 - 启用异步静态网格体编译的调试绘制。 玩家周围的碰撞球体使用白色绘制，同时可以使用Editor.AsyncStaticMeshPlayInEditorDistance调整 任何影响物理的静态网格体仍在编译中，它们的边界框使用绿色绘制。 对于因离玩家太近而处于等待状态的静态网格体，将在几秒内将其边界框绘制为红色。 |
| `Editor.AsyncStaticMeshPlayInEditorDistance` | `2` | 适用于玩家边界球体的比例，用于确定在恢复游戏之前强制网格体编译的距离。 当Editor.AsyncStaticMeshPlayInEditorDebugDraw = 1时，在游戏会话中可以看到此效果。 |
| `Editor.AsyncStaticMeshPlayInEditorMode` | `0` | 0-在进入PIE之前，等待所有静态网格体完成编译。（速度最慢，但不会造成视觉效果或行为瑕疵。） 1-在进入PIE之前，等待所有影响寻路和物理的静态网格体完成编译。（在编译过程中可能会丢失一些视觉效果。） 2-仅在那些当靠近玩家时就会影响寻路和物理的静态网格体上等待。（速度最快，同时还能防止掉落时穿过地板和穿过对象。） |
| `Editor.AsyncTextureCompilation` | `1` | 1-启用异步纹理编译。 2-启用异步纹理编译，但处于暂停状态（用于调试）。 启用后，纹理将被占位符替换，直到可以减少游戏线程上的停顿，提高编辑器整体性能。 |
| `Editor.AsyncTextureCompilationMaxConcurrency` | `-1` | 设置并发纹理编译的数量上限，-1表示无限制。 |
| `Editor.AsyncTextureCompilationResume` | `0` | 暂停时要恢复的列队工作数。 |
| `Editor.ComponentVisualizer.AutoSelectComponent` | `true` | 在样条线上选择一个点时，如果可用，将自动将样条线组件添加到选择集 |
| `Editor.HDRNITLevel` | `160` | 设置在HDR上运行时编辑器的所需NIT级别 |
| `Editor.HDRSupport` | `0` | 设置是否允许编辑器在HDR显示器上运行 |
| `Editor.ObjectReverseLookupMask` | `-1` | -1-对所有对象类型执行验证（最慢） 0-跳过对所有对象类型的验证 1-对纹理到纹理查找执行验证 2-对纹理到材质查找执行验证 4-对材质到图元查找执行验证 8-对静态网格体到组件查找执行验证 16-对材质到材质查找执行验证 |
| `Editor.ObjectReverseLookupMode` | `1` | 0-每次需要反向查找表时都会计算反向查找表（较慢的行为） 1-维护永久性反向查找表（较快的行为） 2-比较模式（在两种模式之间执行验证最慢） |
| `Editor.ReflectEditorLevelVisibilityWithGame` | `0` | 当编辑器可视性状态改变时，启用游戏可视性状态的操作。 0-游戏状态*不*反映在编辑器上。 1-游戏状态通过编辑器反映出来。 |
| `Editor.UseLegacyGetReferencersForDeletion` | `false` | 选择在检测到任何资产/对象的引用者被删除时要使用的算法。 0：使用最优化的版本（默认） 1：使用较慢的旧版本（用于调试/比较） |
| `Editorpaths.Enabled` | `false` | 启用试验性编辑器路径支持。 |
| `EnableHighDPIAwareness` | `1` | 启用或禁用高dpi模式 |
| `EnableLeakTest` | `0` | 如果设置为1，启用泄漏测试，用于测试基于统计的内存分析器 |

## 引擎

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Engine.DelayTrimMemoryDuringMapLoadMode` | `0` | 0：LoadMap期间TrimMemory用作法线 1：延迟TrimMemory，直至LoadMap结束（初始启动） 2：在 *每个* LoadMap调用中延迟TrimMemory |
| `Engine.MinNumOverlapsToUseTMap` | `3` | 在使用TMap去重之前需要的最小重叠数 |
| `Engine.SupressWarningsInOnScreenDisplay` | `0` | 0：在屏幕上显示错误和警告，1：仅在屏幕上显示错误（无论哪种情况，仅当DurationOfErrorsAndWarningsOnHUD大于零时） |
| `Engine.VerifyLoadMapWorldCleanup.Severity` | `2` | 当引擎在LoadMap期间检测到UWorld出现泄漏时，控制日志记录的严重性。 0-禁用所有引用追踪和日志记录 1-记录错误 2-保证 3-致命错误 |
| `Engine.VerifyLoadMapWorldCleanup.TraceMode` | `1` | 当引擎在LoadMap期间检测到世界出现泄漏时，控制引用追踪的细节级别。 0-仅直接引用 1-完整引用追踪 |

## 增强输入

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `EnhancedEditorInput.bAutomaticallyStartConsumingInput` | `false` | 是否应在初始化后立即启动UEnhancedInputEditorSubsystem？ |
| `EnhancedEditorInput.bShouldLogAllInputs` | `false` | 是否应记录每个InputKey调用？ |
| `EnhancedInput.bEnableAutoUpgrade` | `true` | 如果你的项目当前使用旧版输入系统，你的项目是否应自动设置为使用增强输入？ |
| `EnhancedInput.bEnableNameValidation` | `true` | 用于在UPlayerMappableKeySettings资产的编辑器中启用或禁用名称验证的标记 |
| `enhancedInput.bp.bShouldWarnOnUnsupportedInputPin` | `false` | 如果不受支持的"引脚有连接"，增强输入事件节点是否应抛出警告？ |
| `EnhancedInput.bShouldLogAllWorldSubsystemInputs` | `false` | 是否应记录对世界子系统的每个InputKey调用？ |
| `EnhancedInput.Editor.EnableMappingNameValidation` | `true` | 启用编辑器对玩家映射名称的验证 |
| `EnhancedInput.EnableDefaultMappingContexts` | `1` | UEnhancedInputDeveloperSettings::DefaultMappingContexts是否应应用于每个UEnhancedPlayerInput？ |
| `EnhancedInput.Mappings.bCheckForEmptyKeyMappingsDuringValidation` | `false` | 当为true时，如果增强输入键映射被映射到空键，增强输入键映射将在验证期间抛出错误。 |
| `EnhancedInput.OnlyTriggerLastActionInChord` | `1` | 是否应仅触发ChordedAction触发中的最后一个操作？如果禁用此选项，则还将触发相关和弦 |

## 外部插件

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `ExternalPluginCookedAssetRootPath` |  | 在对烘焙路径外部插件资产求值时使用的根路径，或者保留为空白以使用标准引擎/项目根路径。 |

## 文件缓存

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `fc.BlockSize` | `64` | 全局文件缓存对象中每个块的大小（以KB为单位） 应与包压缩块大小匹配以从包中获得最佳读取 |
| `fc.NumBlocks` | `64` | 全局文件缓存对象中的块数量 |

## 植被

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `foliage.CullAll` | `0` | 如果大于零，所有内容都将被视为剔除。 |
| `foliage.CullAllInVertexShader` | `0` | 调试时，如果该值大于0，将剔除顶点着色器中的所有实例。 |
| `foliage.CullDistanceScale` | `1` | 控制剔除距离比例。植被必须通过植被类型选择剔除距离缩放。 |
| `foliage.DebugBuildTreeAsyncDelayInSeconds` | `0` | 为BuildTreeAsync任务增加一个延迟（以秒为单位）用于调试 |
| `foliage.DensityScale` | `1` | 控制要渲染的植被的数量。植被必须通过植被类型选择密度缩放。 |
| `foliage.DisableCull` | `0` | 如果大于零，不基于视锥体执行剔除。 |
| `foliage.DiscardDataOnLoad` | `0` | 1：如果已启用植被类型，将在加载时丢弃植被数据； 0：保留植被数据，无论植被类型是否启用（需要重新加载关卡） |
| `foliage.DitheredLOD` | `1` | 如果大于零，将使用抖动LOD，否则使用弹出LOD。 |
| `foliage.ForceLOD` | `-1` | 如果大于或等于零，强制植被LOD到该级别。 |
| `foliage.InstanceRuns` | `0` | 是否使用FMeshBatch的InstanceRuns功能压缩发送给渲染器的植被绘制调用数据。 网格体绘制命令管线不受支持。 |
| `foliage.LODDistanceScale` | `1` | 用于计算植被LOD的距离的比例因子。 |
| `foliage.MaxEndCullDistance` | `0` | 末端剔除的最大距离（0表示禁用）。 |
| `foliage.MaxOcclusionQueriesPerComponent` | `16` | 控制遮挡剔除的粒度。16-128是合理范围。 |
| `foliage.MaxTrianglesToRender` | `100000000` | 这是在一次遍历中渲染的植被三角形数量的绝对限制。它用于防止不当的LOD参数错误导致操作系统终止GPU。 |
| `foliage.MinimumScreenSize` | `5e-06` | 它将控制我们完全剔除植被实例的屏幕大小。 |
| `foliage.MinInstancesPerOcclusionQuery` | `256` | 控制遮挡剔除的粒度。1024到65536是合理范围。这不精确，实际最小值可能会相差两倍。 |
| `foliage.MinLOD` | `-1` | 用于丢弃顶部LOD进行性能评估。-1：禁用此控制台变量的所有效果。 |
| `foliage.MinOcclusionQueriesPerComponent` | `6` | 控制遮挡剔除的粒度。2应该是最小值。 |
| `foliage.MinVertsToSplitNode` | `8192` | 控制剔除和LOD精度与剔除和CPU性能之间的精度。 |
| `foliage.OffGroundThreshold` | `5` | 从基本组件（在局部空间中）到实例仍被视为有效的位置处的最大距离 |
| `foliage.OnlyLOD` | `-1` | 如果大于或等于零，将仅渲染该级别的植被LOD。 |
| `foliage.OverestimateLOD` | `0` | 如果LOD大于零且不使用抖动LOD，则使用LOD的过高估计而不是过低估计。 |
| `foliage.RandomLODRange` | `0` | 将添加到每个实例距离以计算LOD的随机距离。 |
| `foliage.SplitFactor` | `16` | 它将控制观叶树的分支因子。 |

## 强制

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `ForceDecompressionFails` | `0` | 如果>0，则强制解压失败以测试紧急同步读取回退。 |
| `ForcePakProcessReads` | `false` | 如果为true，则从pak文件异步读取将始终使用FPakProcessedReadRequest系统，该系统通常仅用于压缩文件。 |

## 帧抓取器

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `framegrabber.framelatency` | `0` | 在回读一帧之前需要等待的帧数。0：帧将工作，但由于CPU和GPU同步导致性能下降。 |

## 冻结

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `FreezeAtPosition` |  | 此控制台变量将存储FreezeAt命令的位置和旋转，该命令允许锁定摄像机以提供更确定的渲染分析。 可以在ConsoleVariables.ini中设置FreezeAtPosition（使用MAPNAME?bTourist=1启动地图）。 另请参见FreezeAt command控制台命令。 如果数字语法与BugIt命令使用的相同： 前三个值定义位置，后三个定义旋转。 示例： FreezeAtPosition 2819.5520 416.2633 75.1500 65378 -25879 0 |

## 全尺寸单位图表

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `FullSizeUnitGraph` | `0` | 如果为true，单位图表为旧的全尺寸，全亮度版本。 |

## FX

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `FX.AllowAsyncTick` | `0` | 允许粒子系统并行刷新。 |
| `FX.AllowCulling` | `1` | 允许剔除发射器。 |
| `fx.AllowFastPathFunctionLibrary` | `0` | 如果>0，允许图表将自定义快速路径操作到插入图表中。 |
| `FX.AllowGPUParticles` | `1` | 如果为true，允许使用GPU粒子。 |
| `FX.AllowGPUSorting` | `1` | 允许在GPU上对粒子排序。 |
| `FX.BatchAsync` | `0` | 如果为1，粒子异步任务将进行批处理，因为它们通常比唤醒任务线程所需花费的时间更少。对编辑器没有影响。 |
| `FX.BatchAsyncBatchSize` | `32` | 当FX.BatchAsync=1时，控制分组在一起进行线程处理的粒子系统的数量。 |
| `fx.Budget.AdjustedUsageDecayRate` | `0.1` | FX预算调整的使用量值允许衰减的速率。当剔除/启用FX时，如果使用量超过剔除阈值振荡，这可以放置FX关闭/打开。 |
| `fx.Budget.AdjustedUsageMax` | `2` | FX预算调整的使用量的最大值。防止一个非常长的帧在预算范围内长时间保持1.0以上的使用量。 |
| `fx.Budget.Debug.GameThreadConcurrentTimeOverride` | `-1` | 当>=0.0时，重载GameThreadConcurrent上的FX报告时间。适合用于观察/调试对其他系统的影响。 |
| `fx.Budget.Debug.GameThreadTimeOverride` | `-1` | 当>=0.0时，重载GameThread上的FX报告时间。适合用于观察/调试对其他系统的影响。 |
| `fx.Budget.Debug.RenderThreadTimeOverride` | `-1` | 当>=0.0时，重载RenderThread上的FX报告时间。适合用于观察/调试对其他系统的影响。 |
| `fx.Budget.Enabled` | `false` | 控制是否追踪全局FX预算。 |
| `fx.Budget.EnabledInEditor` | `false` | 控制是否在编辑器构建中追踪全局FX预算。 |
| `fx.Budget.GameThread` | `2` | 仅在游戏线程上运行的所有合并FX工作的预算（以毫秒为单位）。随着接近或超过此预算，各种FX系统将尝试越来越积极地缩减，以便保持在预算范围内。 |
| `fx.Budget.GameThreadConcurrent` | `2` | 所有合并FX工作的预算（以毫秒为单位），而这些工作在游戏线程上运行或在从游戏线程产生的并发任务上运行。随着接近或超过此预算，各种FX系统将尝试越来越积极地缩减，以便保持在预算范围内。 |
| `fx.Budget.HistoryFrames` | `60` | 全局FX预算追踪将保留用于计算其平均帧时间的帧数。 |
| `fx.Budget.RenderThread` | `2` | 在渲染线程上运行的所有合并FX工作的预算（以毫秒为单位）。 随着接近或超过此预算，各种FX系统将尝试越来越积极地缩减，以便保持在预算范围内。 |
| `fx.Cascade.BeamRenderingEnabled` | `true` | 控制是否为级联启用光束渲染 |
| `fx.Cascade.GpuSpriteDynamicAllocations` | `false` | 控制是否动态分配gpu Sprite |
| `fx.Cascade.GpuSpriteRenderingEnabled` | `true` | 控制是否为级联启用gpu Sprite渲染 |
| `fx.Cascade.MeshRenderingEnabled` | `true` | 控制是否为级联启用网格体渲染 |
| `fx.Cascade.SetTemplateDenyList` |  | 设置要使用的模板拒绝列表。（即P_SystemA,P_SystemB） |
| `fx.Cascade.SkipZeroDeltaTime` | `true` | 启用后，接近0.0的增量刷新时间将导致我们跳过组件更新。 这将修复像PSA_Velocity分配Sprite这样的问题，但可能导致依赖于精准速度的项目（即TSR）出现问题。 |
| `fx.Cascade.SpriteRenderingEnabled` | `true` | 控制是否为级联启用Sprite渲染 |
| `fx.Cascade.TrailRenderingEnabled` | `true` | 控制是否为级联启用尾迹渲染 |
| `fx.Cascade.UseVelocityForMotionBlur` | `true` | 启用后，速度将用于近似支持此功能的顶点工厂的速度。 |
| `fx.DeferrPSCDeactivation` | `0` | 如果>0，粒子系统组件的所有停用将延迟到下一个刷新。 |
| `fx.DetailedCSVStats` | `false` | 如果为true，将详细的粒子统计信息写入CSV分析器。 |
| `fx.DetailedCSVStats.MemoryMode` | `1` | 根据模式收集近似内存信息。 0=禁用（默认）。 1=最小信息（较小性能影响）。 2=完整信息（较大性能影响）。 |
| `fx.DumpGraphKeyGen` | `0` | 如果>0，密钥生成将转储到日志中。 |
| `fx.DumpParticleData` | `0` | 如果>0，当前帧粒子数据将在模拟后转储。 |
| `fx.DumpParticleParameterStores` | `0` | 如果>0，当前帧粒子参数存储将在更新时转储。 |
| `fx.DumpSystemData` | `0` | 如果>0，系统模拟结果将转储到日志中。 |
| `fx.DumpVMIR` | `0` | 如果>0，将为vm编译器后端启用详细日志记录。 |
| `FX.EarlyScheduleAsync` | `0` | 如果为1，可以异步运行的粒子系统组件将在帧中提前安排 |
| `fx.EnableCircularAnimTrailDump` | `2` | 控制在动画尾迹中发现圆形链接时的日志记录。 0=没有日志记录。 1=最小日志记录。 2=详细日志记录。 |
| `fx.EnableEmitterMergeChangeIdLogging` | `0` | 如果>0，将记录详细更改id信息以帮助调试合并问题。 |
| `fx.EnableNiagaraCRHandler` | `0` | 如果>0，Niagara会将一些状态推动到崩溃报告器。这不是免费的，所以不应使用，除非在wild中主动追踪崩溃。即便如此，也只能在需要的平台上启用它。 |
| `fx.EnableNiagaraLightRendering` | `1` | 如果==0，将禁用Niagara光源渲染器。 |
| `fx.EnableNiagaraMeshRendering` | `1` | 如果==0，将禁用Niagara网格体渲染器。 |
| `fx.EnableNiagaraRibbonRendering` | `1` | 如果==0，将禁用Niagara条带渲染器。 |
| `fx.EnableNiagaraRuntimeCycleCounts` | `0` | 运行时周期计数追踪Niagara的帧时间的开关。 |
| `fx.EnableNiagaraSpriteRendering` | `1` | 如果==0，将禁用Niagara Sprite渲染器。 |
| `fx.EnableVerboseNiagaraChangeIdLogging` | `0` | 如果>0，将打印详细的更改ID日志信息。 |
| `fx.ExecVMScripts` | `1` | 如果>0，将执行VM脚本，否则不会执行，对于查看崩溃编译脚本的字节码很有用。 |
| `fx.ForceCompileOnLoad` | `0` | 如果>0，将强制发射器在加载时编译。 |
| `fx.ForceExecVMPath` | `0` | 如果<0，将使用旧版VM路径，如果>0，将使用试验性版本，默认为0。 |
| `fx.ForceFailIfPreviouslyNotSetOnMerge` | `0` | 如果>0，当从父发射器合并时，将堆栈中的链接变量切换为默认类型"Fail If Previously Not Set"。 |
| `fx.ForceMergeOnLoad` | `0` | 如果>0，将强制发射器在加载时合并。 |
| `fx.ForceNiagaraCacheDump` | `0` | 如果>0，将转储所有缓存图表遍历数据 |
| `fx.ForceNiagaraCompileToFail` | `0` | 如果>0，发射器将经历编译的操作，但始终不会设置有效的字节码。 |
| `fx.ForceNiagaraSpawnAttachedSolo` | `0` | 如果>0，将强制附加生成的Niagara系统在单人模式下生成，用于调试目的。 |
| `fx.ForceNiagaraTranslatorDump` | `0` | 如果>0，将转储平移生成的HLSL |
| `fx.ForceNiagaraTranslatorSingleThreaded` | `1` | 如果>0，将一次执行所有平移，适用于调试。 |
| `fx.ForceNiagaraVMBinaryDump` | `0` | 如果>0，将转储平移生成的所有二进制文本 |
| `fx.ForceSafeScriptAttributeTrim` | `0` | 如果>0，属性修剪将使不太激进的算法来移除脚本属性。 |
| `FX.FreezeGPUSimulation` | `0` | 冻结在GPU上模拟的粒子。 |
| `FX.FreezeParticleSimulation` | `0` | 冻结粒子模拟。 |
| `fx.FXAllowParticleMeshLODs` | `0` | 是否允许粒子网格体使用LOD |
| `FX.GPUCollisionDepthBounds` | `500` | 搜索碰撞平面时限制深度边界。 |
| `fx.GPUSimulationDynTextureSizeXY` | `16` | 当启用动态大小调整时的GPU粒子模拟纹理XY维度（默认值=16） |
| `fx.GPUSimulationTextureSizeX` | `1024` | GPU粒子模拟纹理X维度（默认值=1024）；在项目渲染器设置中设置；可能被设备描述重载。 |
| `fx.GPUSimulationTextureSizeY` | `1024` | GPU粒子模拟纹理Y维度（默认值=1024）；在项目渲染器设置中设置；可能被设备描述重载。 |
| `fx.GPUSort.BufferSlack` | `2` | 调整GPU排序缓冲区大小时的松弛比例。必须大于1（默认值=2） |
| `fx.GPUSort.FrameCountBeforeShrinking` | `100` | 连续帧的数量，其中GPU排序缓冲区在允许缩减之前被视为过大。（默认值=100） |
| `fx.GPUSort.MinBufferSize` | `8192` | 最小GPU排序缓冲区大小，以粒子为单位（默认值=8192） |
| `fx.GPUSort.StressTest` | `0` | 通过每帧释放持久数据（默认=0）强制对GPU排序进行压力测试 |
| `FX.GPUSpawnWarningThreshold` | `20000` | 生成GPU粒子的警告阈值。 |
| `fx.LastRenderTimeSafetyBias` | `0.1` | 偏差LastRenderTime value值以允许被RT写入而延迟的时间。 |
| `fx.LogCompileIdGeneration` | `0` | 如果>0，将记录所有编译id生成。如果为2或者更大，记录详细信息。 |
| `fx.LogCompileStaticVars` | `0` | 如果>0，将记录处理静态变量的所有编译id生成。 |
| `fx.LogNiagaraSystemChanges` | `0` | 如果>0，当在编辑器中打开和关闭Niagara系统时，将这些系统写入文本格式。 |
| `fx.LWCTileRecache` | `2` | 从开始FX的地方跨越此数量的LWC图块时，需要重新缓存LWC图块以避免瑕疵。 当出现这种情况时，系统可能需要重置，剔除过远的粒子，或者做一些额外的处理来进行处理。 将此值设置为0将移除此行为，但可能会引入渲染和模拟瑕疵。 |
| `FX.MaxCPUParticlesPerEmitter` | `1000` | 每个发射器允许的CPU粒子数量上限。 |
| `FX.MaxGPUParticlesSpawnedPerFrame` | `1048576` | 每个发射器每帧允许生成的GPU粒子数量上限。 |
| `fx.MaxNiagaraCPUParticlesPerEmitter` | `1000000` | Niagara中每个发射器受支持的最大CPU粒子数量。 |
| `fx.MaxNiagaraGPUParticlesSpawnPerFrame` | `2000000` | 预计在单个帧中生成的最大GPU粒子数量。 |
| `fx.MaxNiagaraNeighborGridCells` | `134217728` | Niagara中受支持的最大网格单元数量。超过此阈值将导致模拟发出警告并失败。 |
| `fx.MaxNiagaraRasterizationGridCells` | `1073741824` | Niagara中受支持的最大网格单元数量。超过此阈值将导致模拟发出警告并失败。 |
| `FX.MaxParticleTilePreAllocation` | `100` | GPU粒子的最大图块预分配。 |
| `fx.Niagara.AllowAllDeviceProfiles` | `0` |  |
| `fx.Niagara.AllowAsyncWorkToEndOfFrame` | `1` | 允许异步工作持续到帧结束，如果为false，它将在它开始所在的刷新组内完成。 |
| `fx.Niagara.AllowCullProxies` | `1` | 切换Niagara是否将使用剔除代理系统代替可伸缩性剔除的系统。 |
| `fx.Niagara.AllowDeferredReset` | `1` | 如果正在运行异步工作，当请求重置时，将队列等待执行确定，这避免了停顿GameThread。 |
| `fx.Niagara.AllowPrimedPools` | `1` | 允许填充Niagara池。 |
| `fx.Niagara.AllowVisibilityCullingForDynamicBounds` | `1` | 允许异步工作持续到帧结束，如果为false，它将在它开始所在的刷新组内完成。 |
| `fx.Niagara.Analytics.ReportOnCook` | `1` | 如果为true，则将收集和报告基本系统信息，作为每个烘焙系统的编辑器分析的一部分。 |
| `fx.Niagara.Array.PositionDebugRadius` | `32` | 使用Diagara调试器时的位置数组调试显示的半径 |
| `fx.Niagara.AsyncGpuTrace.GlobalSdfEnabled` | `1` | 如果禁用，全局SDF不支持AsyncGpuTrace。 |
| `fx.Niagara.AsyncGpuTrace.HWRayTraceEnabled` | `1` | 如果禁用，硬件光线追踪场景不支持AsyncGpuTrace。 |
| `fx.Niagara.AsyncTrace.CountsScratchPadBucketSize` | `768` | 异步gpu追踪计数缓冲区的暂存桶大小。此缓冲区需要4。 |
| `fx.Niagara.AsyncTrace.ScratchPadBucketSize` | `1024` | 异步gpu追踪暂存缓冲桶的大小（以元素为单位）。 |
| `fx.Niagara.BaselineGenerationDelay` | `5` | 在匹配开始之前，为了在烘焙游戏中生成niagara性能基线而延迟的时间。 |
| `fx.Niagara.Batcher.DebugLogging` | `0` | 启用大量对日志的喷涌（spew）以调试批处理程序。 |
| `fx.Niagara.Batcher.TickFlush.MaxPendingTicks` | `10` | 在处理未处理刷新之前，未处理刷新数量上限。 数字越大，在单个帧中处理的数据就越多。 |
| `fx.Niagara.Batcher.TickFlush.MaxQueuedFrames` | `3` | 在处理未处理帧之前，包括列队刷新的未处理帧数量。 数字越大，在单个帧中处理的数据就越多，通常只有当应用程序没有焦点时这才会成为问题。 |
| `fx.Niagara.Batcher.TickFlush.Mode` | `1` | 超出最大列队帧时怎么办。 0=保持刷新列队，当再次获得焦点时，可以导致长时间的暂停。 1 =（默认）用虚拟视图/缓冲区数据处理所有列队的刷新，可能会由于缺少深度碰撞等原因导致不正确的模拟。2 =杀死所有挂起的刷新，可能会由于缺少数据帧而导致不正确的模拟，即粒子重置。 |
| `fx.Niagara.Collision.CPUEnabled` | `1` | 控制是否启用CPU碰撞。 |
| `fx.Niagara.Compilation.MaxActiveTaskCount` | `16` | 可以并行运行的激活Niagara编译的数量上限。 |
| `fx.Niagara.CompileDDCWaitTimeout` | `10` | 在脚本编译期间，在开始着色器编译之前，等待ddc回答的时长（以秒为单位）。 |
| `fx.Niagara.CompileDumpTimings` | `false` | 启用后，包含不同编译脚本的编译指标的文件将被转储到日志文件夹中 |
| `fx.Niagara.CompileHashAllDataInterfaces` | `1` | 强制Niagara包括所有数据接口，作为编译哈希生成的一部分。 0=禁用。 1=启用，但哈希一次，可提高性能。 2=启用，生成的哈希始终适合Niagara工作上的迭代。 |
| `fx.Niagara.CompileValidateMode` | `1` | 控制验证编译模式在比较默认/异步编译时如何报告遇到的差异 |
| `fx.Niagara.CompileWaitLoggingCap` | `3` | 在自动化过程中，在编译失败之前，记录多少次日志。 |
| `fx.Niagara.CompileWaitLoggingThreshold` | `30` | 在自动化过程中，在日志记录之前，等待编译结果需要多长时间。 |
| `fx.Niagara.ComponentRenderComponentCountWarning` | `50` | 在组件渲染器中显示ui警告之前允许的最大组件数。 |
| `fx.Niagara.ComponentRenderPoolInactiveTimeLimit` | `5` | 非激活组件在销毁之前在池中停留的时间，以秒为单位。 |
| `fx.Niagara.ComponentWarnAsleepCullReaction` | `1` | 启用后，如果NiagaraComponent自然完成，但设置了休眠模式进行剔除响应，我们会发出警告。 |
| `fx.Niagara.ComponentWarnNullAsset` | `0` | 启用后，如果使用空资产激活NiagaraComponent，将发出警告。 这有时适用于追踪可删除的组件。 |
| `fx.Niagara.CompressScriptByteCode` | `false` | 应压缩脚本字节码以节省内存。将按需解压缩。 |
| `fx.Niagara.CSVSplitTime` | `180` | 传递给CSV分析器的Niagara分割时间事件的长度。这是用于向检查提供更受限的统计平均值。 |
| `fx.Niagara.DataChannels.AllowAsyncLoad` | `1` | 如果我们应尝试异步加载系统等，则为True。 |
| `fx.Niagara.DataChannels.AllowLazyHandlerInit` | `1` | 如果允许延迟初始化NDC处理程序，则为True。 |
| `fx.Niagara.DataChannels.BlockAsyncLoadOnUse` | `1` | 如果在使用这些资产时应阻止任何挂起的异步加载，则为True。 |
| `fx.Niagara.DataChannels.DebugDumpWriterDI` | `0` |  |
| `fx.Niagara.DataChannels.DumpHandlerTick` | `0` |  |
| `fx.Niagara.DataChannels.Enabled` | `true` | 如果为true，将启用Niagara数据通道。 |
| `fx.Niagara.DataChannels.ForceReadPrevFrame` | `false` | 如果为true，将强制具有NDC读取DI的Niagara系统从前一帧读取。 |
| `fx.Niagara.DataChannels.ForceReadTickGroup` | `-1` | 当>=0时，将强制具有NDC读取DI的Niagara系统在给定的刷新组中进行刷新。 |
| `fx.Niagara.DataChannels.FrameDataToCapture` | `0` | 调试器将为写入请求捕获的帧数。 |
| `fx.Niagara.DataChannels.LogWritesToOutputLog` | `0` | 0=禁用，1=日志写入摘要，2=还写入数据；如果>0，NDC调试器将所有数据通道写入打印到输出日志。 |
| `fx.Niagara.DataChannels.WarnOnLateWrites` | `true` | 如果为true，对NDC延迟写入将产生警告。延迟意味着在它们最后允许的刷新组之后。 |
| `fx.Niagara.Debug.GlobalLoopTime` | `0` | 如果>0，所有Niagara FX将每N秒重置一次。 |
| `fx.Niagara.DebugDraw.Enabled` | `1` | 启用或禁用调试绘制数据接口，注意不会完全禁用开销。 |
| `fx.Niagara.DecalRenderer.DrawDebug` | `false` | 如果非零，将绘制调试信息。 |
| `fx.Niagara.DecalRenderer.Enabled` | `true` | 如果==0，将禁用Niagara贴花渲染器。 |
| `fx.Niagara.DelayScriptAsyncOptimization` | `true` | 是否应延迟异步优化直至发射器激活？ |
| `fx.Niagara.DeletePythonFilesOnError` | `1` | 它决定在以下情况下是否保留模块/发射器版本控制所使用的中间python：当它们被执行并导致错误时。 |
| `fx.Niagara.DigestGraphCacheSize` | `512` | 定义消化后的Niagara图表的缓存大小。 |
| `fx.Niagara.DumpNans` | `0` | 如果不为0，将始终转储所有NaN。 |
| `fx.Niagara.DumpNansOnce` | `0` | 如果不为0，将为遇到NaN的第一个发射器转储任何NaN。 |
| `fx.Niagara.Emitter.ComputePSOPrecacheMode` | `1` | 控制应该如何为Niagara计算着色器执行PSO预缓存 0=禁用（默认）。 1=启用，如果也启用了r.PSOPrecaching。如果r.PSOPrecache.ProxyCreationWhenPSOReady=1，发射器在完成之前不允许运行 2=启用强制。 3=启用强制，发射器在完成之前不允许运行。 |
| `fx.Niagara.Emitter.MaxGPUBufferElements` | `0` | 每个GPU缓冲区的最大元素数（例如4k元素）将浮点缓冲区限制为每个缓冲区最大16k。 注意：如果你要求的大小低于满足单个工作单元所需的大小，它将增加到该大小。 默认为0，这将允许缓冲区为RHI允许的最大值。 |
| `fx.Niagara.EmitterBounds.DynamicExpandMultiplier` | `1.1` | 用于动态边界采集的乘数，即1表示没有变化，1.1表示增加10%。 此值在计算任何动态边界对齐之后应用。 |
| `fx.Niagara.EmitterBounds.DynamicSnapValue` | `0` | 用于将动态边界计算集中对齐（四舍五入到）到的值。例如，对齐128和值1将得到128 |
| `fx.Niagara.EmitterBounds.FixedExpandMultiplier` | `1` | 用于固定边界采集的乘数，即1表示没有变化，1.1表示增加10%。 |
| `fx.Niagara.EnableCustomInlineDynamicInputFormats` | `1` | 如果>0，启用了动态输入树的试验性内联编辑器，将应用脚本上定义的自定义格式。 |
| `fx.Niagara.EnableExperimentalInlineDynamicInputs` | `0` | 如果>0，右键单击菜单中的堆栈即可使用动态输入树的试验性内联编辑器。 |
| `fx.Niagara.EventSpawnsUpdateAttributeInitialValues` | `1` | 如果>0，Niagara事件刷新脚本将更新初始值。*粒子属性值。 |
| `fx.Niagara.FailIfNotSetSeverity` | `3` | 参数使用默认模式Fail If Not Set发射的消息的严重性。"3=错误， 2=警告， 1=日志， 0=禁用。" |
| `fx.Niagara.FailStaticMeshDataInterface` | `0` | 启用后，将无法使用静态网格体数据接口。 |
| `fx.Niagara.ForceLastTickGroup` | `0` | 强制Niagara刷新位于最后一个刷新组中，这反映了旧行为，可以用于测试异步重叠问题。 |
| `fx.Niagara.ForceWaitForCompilationOnActivate` | `0` | 当一个组件被激活时，它将暂停等待任何挂起的着色器编译。 |
| `fx.Niagara.GeometryComponentRenderPoolInactiveTimeLimit` | `5` | 非激活组件在销毁之前在池中停留的时间，以秒为单位。 |
| `fx.Niagara.GpuComputeDebug.DrawDebugEnabled` | `1` | 是否应绘制任何调试信息。 |
| `fx.Niagara.GpuComputeDebug.FourComponentMode` | `0` | 调整如何可视化四种组件类型 0=可视化RGB（默认） 1=可视化A |
| `fx.Niagara.GpuComputeDebug.MaxLineInstances` | `4096` | 在单个帧中支持的线条绘制数上限。 |
| `fx.Niagara.GpuComputeDebug.MaxTextureHeight` | `128` | 将可视化纹理的最大高度，旨在避免对象在屏幕上变得过大。 |
| `fx.Niagara.GpuComputeDebug.MinTextureHeight` | `128` | 将可视化纹理的最小高度，较小纹理将按比例放大以匹配此高度。 |
| `fx.Niagara.GpuComputeDebug.OccludedLineColorScale` | `0.05` | 调整遮挡线条的标量值，其中0表示透明，1表示不透明。 默认值为0.05或5% |
| `fx.Niagara.GpuComputeDebug.ShowNaNInf` | `1` | 启用后，将NaN显示为闪烁的颜色。 |
| `fx.Niagara.GpuEmitterCheckFloat16Support` | `true` | 启用后，检查RHI是否支持Float16 UAV读取/写入，如果不支持，使用Float16的GPU发射器将被禁止运行。 |
| `fx.Niagara.GpuProfiling.Enabled` | `true` | 主要控制是否允许Niagara使用GPU分析。 |
| `fx.Niagara.GpuScriptsCompiledBySystem` | `true` | 如果为true，Niagara脚本的GPU着色器将与NiagaraSystem一起编译（当使用AsyncTask编译模式时）。 |
| `fx.Niagara.GraphDataCacheSize` | `16384` | 在GraphDataCache中存储的元素的数量上限。 |
| `fx.Niagara.GraphDataCacheValidation` | `false` | 如果为true，将对从数据FNiagaraGraphDataCache检索数据执行验证。 |
| `fx.Niagara.Grid2D.OverrideFormat` | `-1` | 所有网格的可选重载将使用此格式。 |
| `fx.Niagara.Grid2D.ResolutionMultiplier` | `1` | 网格分辨率的可选全局修饰符 |
| `fx.Niagara.Grid3D.OverrideFormat` | `-1` | 所有网格的可选重载将使用此格式。 |
| `fx.Niagara.Grid3D.ResolutionMultiplier` | `1` | 网格分辨率的可选全局修饰符 |
| `fx.Niagara.Grid3D.UseRGBAGrid` | `1` | 尽可能使用RGBA纹理 |
| `fx.Niagara.IndirectArgsPool.AllowShrinking` | `1` | 当一组帧低于低水位线之后，允许间接参数池收缩。 |
| `fx.Niagara.IndirectArgsPool.BlockSizeFactor` | `2` | 当需要增加间接参数池大小以避免空间不足时，对间接参数池大小使用的乘数。（默认值=2.0） |
| `fx.Niagara.IndirectArgsPool.LowWaterAmount` | `0.5` | 被视为大小较低且值得收缩的间接参数池的百分比（0-1） |
| `fx.Niagara.IndirectArgsPool.LowWaterFrames` | `150` | 等待收缩低于低水位线的间接参数池的帧数。（默认值=150） |
| `fx.Niagara.IndirectArgsPool.MinSize` | `256` | 分配到池中的绘制间接参数的数量下限。（默认值=256） |
| `fx.Niagara.LeakDetector.DebugMessageTime` | `5` | 在屏幕上显示调试信息的时间。 |
| `fx.Niagara.LeakDetector.Enabled` | `false` | 启用或禁用泄漏检测器。 |
| `fx.Niagara.LeakDetector.GrowthCountThreshold` | `16` | 需要在不出现计数下降的情况下看到指定次数的增长，之后才将其视为泄漏。 |
| `fx.Niagara.LeakDetector.ReportActiveLeaks` | `1` | 如何报告激活组件泄漏？0-从不报告。1-立即报告。（默认值）2-在回收垃圾时报告。 |
| `fx.Niagara.LeakDetector.ReportTotalLeaks` | `2` | 如何报告组件总泄漏？0-从不报告。1-立即报告。2-在回收垃圾时报告。（默认值） |
| `fx.Niagara.LeakDetector.TickDeltaSeconds` | `1` | 采样组件信息之前必须经过的时间，以秒为单位。 |
| `fx.Niagara.LegacyDeviceProfile` | `-1` | 这是一个特殊的控制台变量，允许我们使用控制台变量条件维护旧版设备描述的行为。 不要直接用于新内容。 可以向旧版设备描述赋予此控制台变量的一个特定值，然后控制台变量条件用于适当地启用/禁用，以便与基于它们的启用/禁用内容的旧版资产相匹配。 |
| `fx.Niagara.LogFoundButNotAllowedAssets` | `0` | 如果>0，对于已找到但在当前编辑器上下文中不被允许的资产，将打印到日志中。 |
| `fx.Niagara.LogVerboseWarnings` | `1` | 启用以将更详细的警告输出到日志文件，这些警告被视为可忽略的警告，但可以在调试时提供信息。 默认值在编辑器构建中启用，在非编辑器构建中禁用。 |
| `fx.Niagara.LUT.OptimizeThreshold` | `0.01` | 优化曲线LUT时使用的误差阈值，设置为0.0或更低将导致没有优化 |
| `fx.Niagara.LUT.VerifyPostLoad` | `0` | 启用以验证在PostLoad与加载数据中的LUT匹配 |
| `fx.Niagara.MaxCompilePollTimePerFrame` | `0.016` | 当许多系统编译任务列队时，它是用于推进它们的每帧最大时间。 |
| `fx.Niagara.MaxStatRecordedFrames` | `30` | 为niagara cpu和gpu脚本的统计性能显示记录的帧数。 |
| `fx.Niagara.MeshRenderer.CalcMeshUsedParticleCount` | `64` | 将检查渲染器可视化/网格体索引以确定我们可以渲染的网格集的优化。 |
| `fx.Niagara.NDIExport.GPUMaxReadbackCount` | `1000` | 在PerParticleMode中时GPU回读的最大缓冲区实例计数，其中<=0表示忽略。 |
| `fx.Niagara.NDISpline.GDisableLUTs` | `false` | 是否应关闭CPU上的所有LUT？ |
| `fx.Niagara.NDIStaticMesh.UseInlineLODsOnly` | `2` | 启用后，Niagara将从不使用流送LOD级别，仅使用内联LOD。0=可以对流送LOD采样。1=只能对内联LOD采样。2=默认情况下只能对内联LOD采样，但如果需要，每个DI都可以重载它。 |
| `fx.Niagara.ObjectNeedsLoadMode` | `1` | 决定如何处理需要加载的对象 0-什么都不做 1 -验证加载的对象 2-验证对象加载并强制预加载 |
| `fx.Niagara.OnDemandCompileEnabled` | `1` | 根据需要编译Niagara系统，而不是在后期负载时。 |
| `fx.Niagara.ParticleRead.IgnoreUnsafeReads` | `false` | 启用后，将允许编译不安全的读取并发出警告，但是读取结果将无效。 |
| `fx.Niagara.PerfTestFrames` | `240` | 在每个性能测试中要收集的帧数。 |
| `fx.Niagara.PreloadSelectablePluginAssetsOnDemand` | `1` | 如果>0，则niagara插件提供的niagara系统、发射器和脚本资产将在打开选择它们的对话框时进行预加载。它是烘焙编辑器构建中出现的资产注册表问题的临时解决方案。 |
| `fx.Niagara.PruneEmittersOnCook` | `1` | 如果>0，该平台将在烘焙过程中修剪禁用的发射器。 |
| `fx.Niagara.PSOPrecache.ReverseCulling` | `1` | 当不是2面时，也可以使用反向剔除集预缓存PSO。（默认值1） |
| `fx.Niagara.QualityLevel` | `3` | Niagara特效的质量级别。 |
| `fx.Niagara.QualityLevel.Max` | `-1` | Niagara特效的最高质量级别。 |
| `fx.Niagara.QualityLevel.Min` | `-1` | Niagara特效的最低质量级别。 |
| `fx.Niagara.Renderer.CookOutStaticEnabledBinding` | `1` | 如果非零，对于带有用于启用绑定的静态变量的渲染器，如果没有启用，它们将进行烘焙。 |
| `fx.Niagara.RenderTarget.IgnoreCookedOut` | `1` | 忽略为已剔除的发射器创建渲染目标，即不被任何GPU发射器使用的目标。 |
| `fx.Niagara.RenderTarget.ResolutionMultiplier` | `1` | Niagara渲染目标分辨率的可选全局修饰符。 |
| `fx.Niagara.RenderTarget2D.SimCacheCompressed` | `1` | 启用后，压缩用于模拟缓存数据。 |
| `fx.Niagara.RenderTargetVolume.SimCacheCompressed` | `1` | 启用后，压缩用于模拟缓存数据。 |
| `fx.Niagara.RenderTargetVolume.SimCacheDataStorageMode` | `1` | 音量RT模拟缓存数据的备份存储类型。 0使用原始数据，1使用OpenVDB，2使用SVT |
| `fx.Niagara.RenderTargetVolume.SimCacheEnabled` | `1` | 启用后，可以将数据写入模拟缓存。 |
| `fx.Niagara.RenderTargetVolume.SimCacheUseOpenVDBFloatGrids` | `0` | 使用OpenVDB浮点网格作为输出。 |
| `fx.Niagara.Scalability.CanPreventCullingOnPlayerFX` | `1` | 启用后，Niagara可以选择性地阻止与玩家相关的FX的可伸缩性剔除。 |
| `fx.Niagara.Scalability.DistanceCulling` | `1` | 如果非零，将启用基于距离的高级可伸缩性剔除。 |
| `fx.Niagara.Scalability.GlobalBudgetCulling` | `1` | 如果非零，将启用基于全局时间预算的高级可伸缩性剔除。 |
| `fx.Niagara.Scalability.InstanceCountCulling` | `1` | 如果非零，将启用基于实例计数的高级可伸缩性剔除。 |
| `fx.Niagara.Scalability.MinMaxDistance` | `1` | Niagara最大距离值的最小值。主要是为了防止除零问题，并确保排序重要性剔除的合理距离值。 |
| `fx.Niagara.Scalability.VisibilityCulling` | `1` | 如果非零，将启用基于可见性的高级可伸缩性剔除。 |
| `fx.Niagara.SetEmitterDenyList` |  | 设置要使用的发射器拒绝列表。（即NS_SystemA:EmitterA,NS_SystemB:EmitterA） |
| `fx.Niagara.SetGpuDataInterfaceDenyList` |  | 设置要使用的Gpu数据接口拒绝列表。 （即UMyDataInteraceA,UMyDataInteraceB） |
| `fx.Niagara.SetGpuDenyList` |  | 设置要使用的Gpu拒绝列表使用，更有针对性，而不是允许比较OS,OSVersion,CPU,GPU。 格式为OSLabel,OSVersion,CPU,GPU。假设空白条目自动通过匹配。 |
| `fx.Niagara.SetGpuEmitterDenyList` |  | 设置要使用的Gpu发射器拒绝列表。（即NS_SystemA:EmitterA,NS_SystemB:EmitterA） |
| `fx.Niagara.SetGpuRHIAdapterDenyList` |  | 设置要使用的Gpu RHI适配器拒绝列表，逗号分隔并使用通配符，即(*MyGpu*)将排除包含MyGpu的任何内容 |
| `fx.Niagara.SetGpuRHIDenyList` |  | 设置要使用的Gpu RHI拒绝列表，逗号分隔并使用通配符，即(*MyRHI*)将排除包含MyRHI的任何内容 |
| `fx.Niagara.SetSystemDenyList` |  | 设置要使用的系统拒绝列表。（即S_SystemA,NS_SystemB） |
| `fx.Niagara.Shader.ForceBindEverything` | `0` | 强制Niagara显示有关丢失着色器绑定的错误。 |
| `fx.Niagara.ShowAllocationWarnings` | `0` | 如果不为0，则频繁重新分配和过度分配粒子内存将在日志中引发警告。 |
| `fx.Niagara.Solo.AllowAsyncWorkToEndOfFrame` | `1` | 对于单独的Niagara实例，允许异步工作持续到帧结束，如果为false，它将在它开始所在的刷新组内完成。 |
| `fx.Niagara.Solo.TickEarly` | `1` | 启用后，将刷新第一个可用的刷新组。 |
| `fx.Niagara.StripByteCodeOverride` | `0` | 重载项目设置，以便在加载时从脚本中剥离字节代码。 -1=启用，剥离试验性VM。 0=禁用。 1=启用，剥离原始VM。 |
| `fx.Niagara.SystemSimulation.AllowASync` | `1` | 如果>0，将并行处理系统后期刷新。 |
| `fx.Niagara.SystemSimulation.BatchGPUTickSubmit` | `1` | 如果非零，允许GPU刷新被批量提交到渲染线程。 |
| `fx.Niagara.SystemSimulation.ConcurrentGPUTickInit` | `1` | 如果非零，允许GPU刷新在系统的并发刷新中被初始化，而不是在游戏线程中被初始化。 |
| `fx.Niagara.SystemSimulation.MaxTickSubsteps` | `100` | 当系统使用固定刷新增量时，每帧可能的最大子步数。 |
| `fx.Niagara.SystemSimulation.SkipTickDeltaSeconds` | `0` | 如果非零，将跳过增量秒数小于等于此数字的所有刷新。 |
| `fx.Niagara.SystemSimulation.TaskStallTimeout` | `0` | 被视为停顿的Niagara模拟任务的超时，以微秒为单位。 当它>0时，忙于等待而不是加入TG，因此避免使用except进行调试。 |
| `fx.Niagara.SystemSimulation.TickBatchSize` | `4` | 每个异步任务要处理的系统实例数量。 |
| `fx.Niagara.SystemSimulation.TickTaskAllowFrameOverlap` | `0` | 启用后，允许刷新在PostActorTick之外重叠，直到EOF更新或下一次刷新。 |
| `fx.Niagara.SystemSimulation.TickTaskShouldWait` | `false` | 启用后，刷新任务将等待并发工作完成，禁用后，任务会在GT刷新完成后立即完成。 |
| `fx.Niagara.SystemSimulation.UpdateOnSpawn` | `1` | 如果>0，系统模拟将在生成后进行小更新。 |
| `fx.Niagara.TaskPriorities.Background` | `bnn` | 设置为后台时的任务优先级 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：fx.Niagara.TaskPriorities.Background bnh |
| `fx.Niagara.TaskPriorities.High` | `hnn` | 设置为高时的任务优先级 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：fx.Niagara.TaskPriorities.High bnh |
| `fx.Niagara.TaskPriorities.Low` | `nnn` | 设置为低时的任务优先级 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：fx.Niagara.TaskPriorities.Low bnh |
| `fx.Niagara.TaskPriorities.Normal` | `hnn` | 设置为正常时的任务优先级 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：fx.Niagara.TaskPriorities.Normal bnh |
| `fx.Niagara.TaskPriorities.PerfCapturePriority` | `1` | 如果启用了性能捕获，要使用的优先级。 减少Niagara的上下文切换的量，以使得性能测量更加可靠。默认值为1，设置为-1表示不重载默认优先级。 |
| `fx.Niagara.TaskPriorities.PostActorTickPriority` | `1` | 在后期Actor刷新中，执行的任何任务（例如生成）都会以此优先级运行。 |
| `fx.Niagara.TaskPriorities.TickGroupPriority` |  | 设置Niagara的刷新组优先级。例如TG_PrePhysics:2,TG_DuringPhysics:2 |
| `fx.Niagara.UseFastSetUserParametersToDefaultValues` | `1` | 当一个组件被激活时，将检查抑制列表。 |
| `fx.Niagara.UseGlobalFXBudget` | `true` | 如果true，Niagara将追踪性能数据到全局FX预算中，并将全局预算值提供给可伸缩性。 |
| `fx.Niagara.VolumeRenderer.Enabled` | `true` | 如果==0，将禁用Niagara音量渲染器。 |
| `fx.Niagara.WaitOnPreGC` | `1` | Niagara是否在任何垃圾回收调用之前等待所有异步任务完成的开关。 |
| `fx.Niagara.WarnComponentRenderCount` | `50` | 在显示日志警告之前，单个系统可以生成的组件的最大数量。 |
| `fx.Niagara.WorldManager.FirstHighPriTickGroup` | `0` | 为世界管理器定义哪些刷新组应设置为高优先级。 0-（默认值）所有刷新组将运行高优先级。 1-第一个刷新组将为正常优先级，所有其他的为高优先级。 |
| `fx.Niagara.WorldManager.KillUniqueSims` | `true` | 系统模拟将在唯一时被删除，而不是等待垃圾回收。 |
| `fx.Niagara.WorldManager.ObjectPoolEnabled` | `true` | 是否应池化对象。 |
| `fx.Niagara.WorldManager.SpawnPerTickGroup` | `1` | 将尝试更早生成新系统（默认启用）。 |
| `fx.NiagaraAllowComputeShaders` | `1` | 如果为true，允许在Niagara内使用计算着色器。 |
| `fx.NiagaraAllowGPUParticles` | `1` | 如果为true，允许Niagara使用GPU粒子。 |
| `fx.NiagaraAllowRuntimeScalabilityChanges` | `1` | 如果>0，此平台允许在运行时更改niagara可伸缩性设置。 |
| `fx.NiagaraBatcher.FreeBufferEarly` | `1` | 将尽可能选择释放GPU缓冲区。 这将减少内存压力，但如果你将乒乓效应从零粒子缓冲到许多粒子，则可能导致更多的分配。 |
| `FX.NiagaraComponentPool.CleanTime` | `30` | 池应多久清理一次（以秒为单位）。 |
| `FX.NiagaraComponentPool.Enable` | `1` | 当为池创建新的粒子系统组件时，要预先分配多少粒子系统组件。 |
| `FX.NiagaraComponentPool.KeepComponentsRegistered` | `1` | 如果非零，返回到池的组件将保持向世界注册，但设置为不可见。这将减少推送/弹出组件的开销。 |
| `FX.NiagaraComponentPool.KillUnusedTime` | `180` | 池化的粒子组件在被销毁之前需要不使用多长时间。 |
| `FX.NiagaraComponentPool.Validation` | `0` | 启用池化验证。 |
| `fx.NiagaraDataBufferMinSize` | `512` | Niagara数据缓冲区最小分配大小，以字节为单位（默认值=512）。 |
| `fx.NiagaraDataBufferShrinkFactor` | `3` | Niagara数据缓冲区大小的收缩阈值。（默认值=3） 当使用的缓冲区大小变为已分配大小的1/F时，将重新分配缓冲区。 |
| `fx.NiagaraEnablePrecompilerNamespaceDatasetCulling` | `0` | 强制命名空间修复预编译器进程剔除未使用的数据集参数。仅当fx.NiagaraEnablePrecompilerNamespaceFixup也启用时才启用。 |
| `fx.NiagaraEnablePrecompilerNamespaceFixup` | `0` | 启用预编译器阶段，以发现参数名称匹配并将匹配的参数hlsl名称令牌转换为适当的命名空间。 |
| `fx.NiagaraGlobalSystemCountScale` | `1` | 用于在Niagara中进行剔除的系统计数阈值的全局比例。 |
| `fx.NiagaraGPUDataBufferChunkSize` | `4096` | Niagara GPU数据缓冲区分配块大小，用于四舍五入到GPU分配，必须是2的幂，以字节为单位（默认值=4096） |
| `fx.NiagaraGPUDataBufferShrinkFactor` | `2` | Niagara GPU数据缓冲区大小的收缩阈值。（默认值=2） 当使用的缓冲区大小变为已分配大小的1/F时，将重新分配缓冲区。 |
| `fx.NiagaraGPUDataWarningSize` | `0` | 应记录一条警告的分配大小。 |
| `fx.NiagaraGpuLowLatencyTranslucencyEnabled` | `1` | 启用后，半透明材质可以使用当前帧的模拟数据，无论Niagara使用哪个刷新通道。 这可能导致需要额外的数据缓冲区，但在使用视图统一缓冲区/深度缓冲区/距离场等时将减少任何延迟 |
| `fx.NiagaraGpuSubmitCommandHint` | `0` | 如果大于零，在发出调度数量后使用此值提交命令。 |
| `fx.NiagaraLogNamespaceFixup` | `0` | 在预编译中记录匹配的变量和引脚名称更改。 |
| `fx.NiagaraMaxStatInstanceReports` | `20` | 聚合统计报告的不同实例的最大数量。 |
| `fx.NiagaraOptimizeCrossGPUTransfer` | `1` | 通过nDisplay在多个GPU上渲染视图时，优化栅栏等待跨GPU传输。 （默认值=1） |
| `fx.NiagaraPerfReporting` | `0` | 0=禁用 1=有关世界过渡的文本性能报告。 2=性能较差或糟糕的每次测试的文本报告。 3 =与2相同，但还会针对每次糟糕的测试生成屏幕截图。 |
| `fx.NiagaraRegenBaselinesOnWorldChange` | `1` | 如果>0，将在每次更改级别时重新生成Niagara的性能基线。 |
| `fx.NiagaraReleaseBuffersOnReset` | `true` | 将在数据集重置时释放与数据缓冲区相关的所有内存。 |
| `fx.NiagaraRuntimeCycleHistorySize` | `15` | 在Niagara的运行时性能跟踪器中要使用多少帧历史记录。 |
| `fx.NiagaraScalabilityUpdateTime_High` | `0.25` | Niagara系统可伸缩性状态的更新间隔时间，其中被设置为高频更新，以秒为单位。 |
| `fx.NiagaraScalabilityUpdateTime_Low` | `1` | Niagara系统可伸缩性状态的更新间隔时间，其中被设置为低频更新，以秒为单位。 |
| `fx.NiagaraScalabilityUpdateTime_Medium` | `0.5` | Niagara系统可伸缩性状态的更新间隔时间，其中被设置为中频更新，以秒为单位。 |
| `fx.NiagaraScriptStatTracking` | `1` | 如果>0，将统计追踪操作编译成Niagara脚本。 |
| `fx.NiagaraStateless.ComputeManager.UseCache` | `true` | 启用后，将尝试在帧之间重复使用分配的缓冲区。 |
| `fx.NiagaraStateless.Distribution.OptimizeLUTs` | `true` | 启用后，将优化LUT生成。 |
| `fx.NiagaraVectorFieldUseIspc` | `true` | 启用后，如果合适，VectorField将使用ISPC进行采样。 |
| `fx.NumFramesBetweenRuntimePerfSamples` | `5` | Niagara运行时性能的每个采样之间的帧数。 |
| `fx.ParticleCollisionIgnoreInvisibleTime` | `0.1` | 要忽略所有碰撞，粒子系统组件必须不可见的时间。 |
| `fx.ParticleDefaultLightInverseExposureBlend` | `0` | 用于在强度和强度/曝光之间混合的混合因子。 |
| `fx.ParticleManagerAsyncBatchSize` | `8` | 对于每个异步任务，ParticleWorldManager应刷新多少个PSC。 |
| `fx.ParticlePerfStats.Enabled` | `true` | 用于控制是否启用统计收集。 |
| `FX.ParticleSlackGPU` | `0.02` | 分配给GPU粒子以防止图块抖动的松弛量，作为占总粒子的百分比。 |
| `FX.ParticleSystemPool.CleanTime` | `30` | 池应多久清理一次（以秒为单位）。 |
| `FX.ParticleSystemPool.Enable` | `1` | 当为池创建新的粒子系统组件时，要预先分配多少粒子系统组件。 |
| `FX.ParticleSystemPool.KillUnusedTime` | `180` | 池化的粒子组件在被销毁之前需要不使用多长时间。 |
| `fx.PerfBaselineThreshold_Bad` | `5` | 与基准性能的比率，即认为系统性能糟糕并对此发出强烈警告的比率。 |
| `fx.PerfBaselineThreshold_Poor` | `2` | 与基准性能的比率，即认为系统性能较差并对此进行警告的比率。 |
| `fx.PruneEmittersOnCookByDetailMode` | `0` | 是否消除所有与细节模式不匹配的发射器。 只有当影响细节模式的可伸缩性设置无法在运行时更改时（取决于平台）才有效。 |
| `fx.PSCMan.Enable` | `1` | 如果启用了PSC世界管理器。 |
| `fx.QualityLevelSpawnRateScaleReferenceLevel` | `2` | 控制基于质量级别的生成速率缩放的参考水平。它是生成速率不会按比例缩小的FX质量级别；对于每次低于参考水平的级别降低，生成速率缩放将通过每个发射器的QualityLevelSpawnRateScale值实现。 默认值=2。取值范围为0到最大FX质量级别。 |
| `fx.ScalabilityManParallelThreshold` | `50` | Niagara重要性管理器并行更新所需的实例数。 |
| `fx.ScalabilityMaxUpdatesPerFrame` | `50` | 更新可伸缩性状态时，每帧可处理的实例数。它们都为-1。 |
| `fx.ShowNiagaraDeveloperWindows` | `0` | 如果>0，niagara系统、发射器和脚本编辑器将显示额外的开发者窗口。 这些窗口用于niagara工具开发和调试，直接在这些窗口中编辑数据可能会导致不稳定。 |
| `fx.SkipVectorVMBackendOptimizations` | `1` | 如果为1，将在VectorVM编译过程中跳过HLSLCC的后端优化。 |
| `fx.SuppressNiagaraSystems` | `0` | 如果>0，将不激活Niagara粒子系统。 |
| `FX.TestGPUSort` | `0` | 测试GPU排序。1：小，2：大，3：详尽，4：随机 |
| `FX.Trail.MaxDistanceTessellation` | `65535` | 基于距离的曲面细分允许的最大曲面细分步骤。 |
| `FX.Trail.MaxTangentTessellation` | `65535` | 基于切线的曲面细分允许的最大曲面细分步骤。 |
| `fx.TriggerDebugCrash` | `0` | 如果>0，将特意崩溃以测试崩溃报告器集成。 |
| `fx.UseNewGraphHash` | `1` | 如果>0，将使用图表节点状态的哈希，否则将使用旧的代码路径。 |
| `FX.VisualizeGPUSimulation` | `0` | 可视化GPU模拟的当前状态。 0=关闭 1=可视化粒子状态 2 = 可视化曲线纹理 |
| `fx.WaitForAsyncStallWarnThresholdMS` | `0` | 如果在WaitForAsync中停顿的时间超过此阈值，则会发出一条停顿警告消息。 |

## 垃圾

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `g.bEnablePendingCleanupObjectsCommandBatching` | `true` | 启用批处理PendingCleanupObjects销毁。 |
| `g.DebugCameraTraceComplex` | `1` | DebugCamera应使用复杂碰撞还是简单碰撞来进行直线追踪。 1：复杂碰撞，0：简单碰撞 |
| `g.TimeoutForBlockOnRenderFence` | `120000` | 当等待渲染线程栅栏时，游戏线程在失败之前应等待的毫秒数。 |
| `g.TimeToBlockOnRenderFence` | `1` | 当等待渲染线程栅栏时，游戏线程应阻止的毫秒数。 |

## 游戏功能插件

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `GameFeaturePlugin.LeakedAssetTrace.MaxReportCount. Deprecated use PluginManager.LeakedAssetTrace.MaxReportCount instead` | `10` | 发现泄漏的资产时，要报告的最大资产数。 |
| `GameFeaturePlugin.LeakedAssetTrace.RenameLeakedPackages. Deprecated used PluginManager.LeakedAssetTrace.RenameLeakedPackages instead` | `true` | 卸载或解除挂载游戏功能插件之后是否应追踪发生泄漏的包。 |
| `GameFeaturePlugin.LeakedAssetTrace.Severity` | `2` | 当引擎检测到游戏功能插件中的资产在卸载或解除挂载期间发生泄漏时，控制日志记录的严重性。。已废弃，改用GameFeaturePlugin.LeakedAssetTrace 0 - 禁用所有引用追踪和日志记录 1 - 记录错误 2 - 保证 3 - 致命错误 |
| `GameFeaturePlugin.LeakedAssetTrace.TraceMode` | `1` | 当引擎检测到游戏功能插件中的资产在卸载或解除挂载期间发生泄漏时，控制引用追踪的细节级别。已废弃，改用PluginManager.LeakedAssetTrace.TraceMode instead 0 - 仅直接引用 1 - 完整引用追踪 |
| `GameFeaturePlugin.VerifyUnload` | `true` | 验证插件资产在卸载时不再在内存中。已废弃，改用PluginManager.VerifyUnload |

## Gameplay摄像机

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `GameplayCameras.EnableInstantiationRecycling` | `true` | （默认值：true。）切换实例化摄像机对象的回收。 |
| `GameplayCameras.EnableLiveEdit` | `true` | （默认值：true。）切换摄像机运行时对象的实时编辑。 |

## Gameplay标签

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `GameplayTags.EnableDetailedStats` | `false` | 详细CPU分析统计的运行时开关 |
| `GameplayTags.PrintNetIndiceAssignment` | `0` | 记录GameplayTag NetIndice分配 |
| `GameplayTags.PrintReportOnShutdown` | `0` | 在关机时打印gameplay标签复制报告 |

## 垃圾回收

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `gc.ActorClusteringEnabled` | `0` | 是否允许关卡为垃圾回收创建Actor群集。 |
| `gc.AdditionalFinishDestroyTimeGC` | `40` | 允许FinishDestroy完成的额外等待时间，以秒为单位。 |
| `gc.AllowIncrementalGather` | `0` | 设置以控制递增收集不可达对象（试验性） |
| `gc.AllowIncrementalReachability` | `0` | 设置以控制递增可达性分析（试验性） |
| `gc.AllowParallelGC` | `1` | 用于控制并行垃圾回收。 |
| `gc.AssetClustreringEnabled` | `0` | 如果为true，引擎将尝试从资产文件创建群集。 |
| `gc.CollectGarbageEveryFrame` | `0` | 用于调试垃圾回收…如果该值为>0，每N帧回收垃圾。 |
| `gc.ContinuousIncrementalGC` | `0` | 用于调试垃圾回收…在递增垃圾回收完成后立即启动下一个。 |
| `gc.CreateGCClusters` | `1` | 如果为true，引擎将尝试创建对象群集，以实现更好的垃圾回收性能。 |
| `gc.DebugGraphSafeDurationThresholdMs` | `4` | 垃圾回收调试图表：安全的垃圾回收时长阈值（以毫秒为单位）。 |
| `gc.DelayReachabilityIterations` | `0` | 使垃圾回收器按提供的帧数延迟递增可达性迭代。 |
| `gc.DumpAnalyticsToLog` | `0` | 在每个垃圾回收结束时将垃圾回收分析转储到日志。 |
| `gc.DumpObjectCountsToLogWhenMaxObjectLimitExceeded` | `0` | 如果不为0，当达到最大对象计数限制时，将UObject计数转储到日志。 |
| `gc.FlushStreamingOnGC` | `0` | 启用后，每次触发垃圾回收时将清空流送。 |
| `gc.ForceCollectGarbageEveryFrame` | `0` | 如果设置为1，引擎将每帧强制垃圾回收。 |
| `gc.ForceEnableGCProcessor` | `false` | 强制垃圾回收使用垃圾回收崩溃期间可能提供额外信息的调试处理器。 |
| `gc.GarbageEliminationEnabled` | `1` | 如果为true，被标记为垃圾的对象将自动失效并由垃圾回收器销毁。 |
| `gc.GarbageReferenceTrackingEnabled` | `0` | 使垃圾回收器追踪和记录未释放的垃圾对象。如果为1，将转储每个引用。如果为2，将转储引用示例以突出问题属性。 |
| `gc.IncrementalBeginDestroyEnabled` | `1` | 如果为true，引擎将每帧使用时间限制递增销毁对象 |
| `gc.IncrementalGatherTimeLimit` | `0` | 重载递增采集时间限制（以秒为单位）。 |
| `gc.IncrementalGCTimePerFrame` | `0.002` | 每帧递增垃圾回收允许的时间，以秒为单位 |
| `gc.IncrementalReachabilityTimeLimit` | `0.005` | 应允许的递增垃圾回收的时间（游戏时间），以秒为单位（试验性）。 |
| `gc.LowMemory.IncrementalGCTimePerFrame` | `0.002` | 如果内存低，每帧递增垃圾回收允许的时间，以秒为单位 |
| `gc.LowMemory.MemoryThresholdMB` | `0` | 低内存垃圾回收模式的内存阈值，以MB为单位 |
| `gc.LowMemory.TimeBetweenPurgingPendingKillObjects` | `30` | 当内存低时，清除待杀死对象的对象引用之间应该等待的时间，以秒为单位（游戏时间） |
| `gc.LowMemory.TimeBetweenPurgingPendingLevels` | `15` | 当内存低且有关卡等待卸载时，在垃圾回收之间应该等待的时间，以秒为单位（游戏时间） |
| `gc.MaxFinishDestroyTimeoutObjectsToLog` | `10` | 当对象销毁时间超过预期时，要注销的对象的数量上限 |
| `gc.MaxObjectsInEditor` | `25165824` | 控制台变量占位符，目前未在运行时使用。 |
| `gc.MaxObjectsInGame` | `0` | 控制台变量占位符，目前未在运行时使用。 |
| `gc.MaxObjectsNotConsideredByGC` | `1` | 控制台变量占位符，目前未在运行时使用。 |
| `gc.MinGCClusterSize` | `5` | 最小垃圾回收群集大小 |
| `gc.MultithreadedDestructionEnabled` | `1` | 如果为true，引擎将从工作线程释放对象的内存 |
| `gc.NumRetriesBeforeForcingGC` | `10` | 工作线程当前在修改UObject状态时可以跳过垃圾回收的次数上限。 |
| `gc.PerformGCWhileAsyncLoading` | `0` | 允许执行垃圾回收，即便正在进行异步加载。 |
| `gc.SizeOfPermanentObjectPool` | `0` | 控制台变量占位符，目前未在运行时使用。 |
| `gc.StressTestGC` | `0` | 如果设置为1，引擎将在异步加载时每帧尝试触发垃圾回收。 |
| `gc.TimeBetweenPurgingPendingKillObjects` | `61.1` | 清除待杀死对象的对象引用之间应该等待的时间，以秒为单位（游戏时间）。 |
| `gc.TimeBetweenPurgingPendingKillObjectsOnIdleServerMultiplier` | `10` | 当服务器空闲时，要应用于清除待杀死对象之间的时间的乘数。 |
| `gc.UseDisregardForGCOnDedicatedServers` | `1` | 如果为false，将在专用服务器上禁用DisregardForGC。 |
| `gc.VerifyAssumptions` | `false` | 是否在每个垃圾回收上验证垃圾回收假设（忽略垃圾回收、群集）。 |
| `gc.VerifyAssumptionsChance` | `0` | 在每个垃圾回收上随机验证GC假设的机会（0-1）。 |
| `gc.VerifyAssumptionsOnFullPurge` | `false` | 是否在完全清除垃圾回收上验证垃圾回收假设（忽略垃圾回收、群集）。 |
| `gc.VerifyNoUnreachableObjects` | `0` | 启用或禁用，没有不可达对象是可达验证 |
| `gc.VerifyUObjectsAreNotFGCObjects` | `0` | 如果为true，引擎在检测到UObject派生的类也派生自FGCObject时，或其任意成员派生自FGCObject时，将抛出警告 |

## 几何体

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `geometry.CombineInstances.DebugRemoveHiddenStrategy` | `1` | 通过（临时调试）配置隐藏移除策略 |
| `geometry.CombineInstances.Verbose` | `false` | 在组合网格体实例中启用详细日志记录，同时禁用并行LOD处理 |
| `geometry.DynamicMesh.DupeStashTimeout` | `300` | 内部UDynamicMesh复制辅助进程系统保存的引用的超时，以秒为单位。请参阅FDynamicMeshCopyHelper。 |
| `geometry.DynamicMesh.EnableDebugMeshes` | `false` | 启用/禁用FDynamicMesh3全局调试网格体支持。调试网格体支持仅在编辑器中可用。 |
| `geometry.DynamicMesh.MaxPoolSize` | `1000` | 在运行垃圾回收之前，UDynamicMeshPool允许池中的网格体数上限 |
| `geometry.DynamicMesh.TextBasedDupeTriThreshold` | `1000` | 使用Base64基于文本的UDynamicMesh复制的三角形数量阈值。大值相当慢。 |
| `geometry.MeshSceneAdapter.SingleThreaded` | `0` | 确定是否在MeshSceneAdapter中使用多线程。 |

## 几何体缓存

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `GeometryCache.Codec.Debug` | `0` | 为编码解码器启用调试日志记录。 |
| `GeometryCache.InterpolateFrames` | `1` | 在几何体缓存帧之间插值（如果拓扑允许的话）。 |
| `GeometryCache.LookaheadSeconds` | `5` | 尝试提前为几何体缓存保留的数据量，以动画秒数表示。注意，无论播放方向如何，这都有效。 |
| `GeometryCache.OffloadUpdate` | `0` | 将渲染线程中的一些更新分担给工作线程和RHI线程。 |
| `GeometryCache.PrefetchSeconds` | `0.5` | 用于预加载几何体缓存的数据量，以动画秒数表示。它是在组件生成时阻止加载的数据。 |
| `GeometryCache.Streamer.BlockTillFinishStreaming` | `false` | 强制GeometryCache流送器阻止，直到它完成所有请求帧的流送 |
| `GeometryCache.Streamer.ShowNotification` | `true` | 当GeometryCache流送器正在流送数据时显示通知 |
| `GeometryCache.TrailingSeconds` | `2.5` | 尝试保留与几何体缓存的播放方向相反的数据量，以动画秒数表示。 |

## 小工具

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Gizmos.DebugDraw` | `false` | 显示调试信息。 |
| `Gizmos.DotThreshold` | `0.2` | 确定旋转平面是否垂直于摄像机视图的点阈值[0.2, 1.0] |
| `Gizmos.ProjectIndirect` | `true` | 当处理间接旋转时，投影到最近的曲线点。 |

## GPU排序

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `GPUSort.DebugOffsets` | `0` | 调试GPU排序偏移。 |
| `GPUSort.DebugSort` | `0` | 调试GPU排序。 |

## 草地

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `grass.CullDistanceScale` | `1` | 所有草地剔除距离的乘数。 |
| `grass.CullSubsections` | `1` | 1：剔除每个植被组件；0：仅基于地形组件剔除。 |
| `grass.densityScale` | `1` | 所有草地密度的乘数。 |
| `grass.DisableDynamicShadows` | `0` | 0：来自草地的动态阴影遵循草地类型bCastDynamicShadow标记；1：将禁用所有草地的动态阴影 |
| `grass.DisableGPUCull` | `0` | 用于调试。将它设置为零以查看生成草地的位置。适用于调整保护分段。 |
| `grass.DiscardDataOnLoad` | `0` | 1：在加载时丢弃草地数据（禁用草地）；0：保留草地数据（需要重新加载关卡） |
| `grass.DrawExclusionVolumes` | `false` | 是否应绘制排除体积 |
| `grass.Enable` | `1` | 1：启用草地；0：禁用草地 |
| `grass.GrassCreationPrioritizedMultipler` | `4` | 当优先创建草地时，应用于MaxCreatePerFrame和MaxAsyncTasks的乘数。 |
| `grass.GrassMap.AlwaysBuildRuntimeGenerationResources` | `0` | 默认情况下，仅在启用运行时生成时编译着色器和构建资源用于生成运行时。 将它设置为1，将始终为所有平台编译它们，同时允许你在烘焙构建中切换运行时生成。 |
| `grass.GrassMap.GuardBandDiscardMultiplier` | `1.6` | 用于控制草地贴图运行时生成系统中的丢弃。近似范围1-4。乘以在丢弃草地贴图时控制的剔除距离。 |
| `grass.GrassMap.GuardBandMultiplier` | `1.5` | 用于控制草地贴图运行时生成系统中的丢弃。近似范围1-4。乘以在添加草地贴图时控制的剔除距离。 |
| `grass.GrassMap.MaxComponentsForBlockingUpdate` | `6` | 当运行阻止草地贴图更新时（即在编辑器保存时）有多少地形组件可以同时更新。 |
| `grass.GrassMap.MaxComponentsRendering` | `3` | 当使用分散运行时生成时，有多少地形组件可以同时渲染草地贴图。 |
| `grass.GrassMap.MaxComponentsStreaming` | `1` | 当使用分散运行时生成时，有多少地形组件可以同时流送其纹理。 |
| `grass.GrassMap.MaxDiscardChecksPerFrame` | `25` | 如果地形组件应每帧丢弃其草地贴图，可以检查多少地形组件。 |
| `grass.GrassMap.PrioritizedMultiplier` | `4` | 当优先创建草地时，应用于MaxComponentsStreaming和MaxComponentsRendering的乘数。 |
| `grass.GrassMap.RenderCaptureNextDraws` | `0` | 在接下来N个草地贴图绘制调用中触发渲染捕获。 |
| `grass.GrassMap.UseAsyncFetch` | `0` | 启用异步获取任务以从GPU回读运行时草地贴图。 禁用后在游戏线程上执行获取，启用后改用异步任务。 |
| `grass.GrassMap.UseRuntimeGeneration` | `0` | 启用运行时草地贴图生成，以节省磁盘空间和运行时内存。 启用后，草地密度贴图不会序列化，而是在运行时动态编译。 |
| `grass.GuardBandDiscardMultiplier` | `1.4` | 用于控制草地系统中的丢弃。近似范围1-4。乘以在丢弃草地组件时控制的剔除距离。 |
| `grass.GuardBandMultiplier` | `1.3` | 用于控制草地系统中的丢弃。近似范围1-4。乘以在添加草地组件时控制的剔除距离。 |
| `grass.IgnoreExcludeBoxes` | `0` | 用于调试。忽略任何排除盒体。 |
| `grass.MaxAsyncTasks` | `4` | 用于控制一次性创建的草地组件的数量。 |
| `grass.MaxCreatePerFrame` | `1` | 每帧创建的草地组件的数量上限 |
| `grass.MaxInstancesPerComponent` | `65536` | 用于控制创建的草地组件的数量。数量越多效率越高，但随着新组件的出现，可能会出现卡顿 |
| `grass.MinFramesToKeepGrass` | `30` | 在可以丢弃缓存草地之前的帧数下限；用来防止抖动。 |
| `grass.MinTimeToKeepGrass` | `5` | 在可以丢弃缓存草地之前的秒数下限；用来防止抖动。 |
| `grass.PrerenderGrassmaps` | `1` | 1：在编辑器中为所有组件预渲染草地贴图；0：在编辑器中移动时根据需要生成草地贴图 |
| `grass.TickInterval` | `1` | 草地刷新之间的帧数。 |
| `grass.UpdateAllOnRebuild` | `0` |  |
| `grass.UseStreamingManagerForCameras` | `1` | 1：使用流送管理器；0：使用ViewLocationsRenderedLastFrame |

## 生命值

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `health.logHealthSnapshot` | `1` | 记录生命值快照 |

## HTTP

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `http.CurlDebugServerResponseEnabled` | `false` | 启用服务器响应的调试 |
| `http.CurlEventLoopEnableChance` | `0` | 启用事件循环的机会，从0到100 |
| `http.DefaultUserAgentCommentsEnabled` | `true` | 默认用户代理字符串中是否支持注解 |
| `Http.InsecureProtocolEnabled` | `false` | 启用不安全的http协议 |
| `Http.RetrySystemNonGameThreadSupportEnabled` | `false` | 启用重试系统非游戏线程支持 |

## IA

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `IA.ValidateAccessFromGameThread` | `false` | 如果设置，当尝试从非游戏线程中解析或访问句柄时将报告错误。 |

## IAS

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `ias.DisplayOnScreenStatistics` | `false` | 启用在屏幕统计信息上显示Ias |
| `ias.DistributedEndpointAttemptCount` | `5` | 在重新使用回退url（如有）之前，应尝试解析分布式端点的次数。 |
| `ias.DistributedEndpointFallbackUrl` |  | 当无法到达分布式端点时要使用的CDN url（重载IoStoreOnDemand.ini） |
| `ias.DistributedEndpointRetryWaitTime` | `15` | 在解析分布式端点失败后，需要等待多长时间才进行重试（以秒为单位） |
| `ias.DistributedEndpointTimeout` | `30` | 分布式端点解析请求需要等待多长时间才会超时（以秒为单位） |
| `ias.HttpChangeEndpointAfterSuccessfulRetry` | `true` | 重试成功后是否更改当前端点 |
| `ias.HttpConcurrentRequests` | `8` | http客户端中的并发请求数。 |
| `ias.HttpConnectionCount` | `4` | 连接到按需端点的打开HTTP连接数。 |
| `ias.HttpEnabled` | `true` | 启用通过HTTP进行单独的资源流送 |
| `ias.HttpErrorHighWater` | `0.5` | 禁用HTTP流送时的高水位线 |
| `ias.HttpErrorSampleCount` | `8` | 用于计算HTTP请求失败的移动平均值的示例数 |
| `ias.HttpFailTimeOutMs` | `4000` | 超过该设置的无线网络等待失效（以毫秒为单位，0=禁用） |
| `ias.HttpHealthCheckWaitTime` | `3000` | 在重新连接到可用端点之前要等待的毫秒数 |
| `ias.HttpIdleMs` | `50000` | 关闭空闲连接或等待失效的时间，以秒为单位 |
| `ias.HttpOptionalBulkDataEnabled` | `true` | 启用通过HTTP的可选批量数据 |
| `ias.HttpPipelineLength` | `2` | 一个连接上的并发请求数 |
| `ias.HttpPollTimeoutMs` | `17` | Http刷新轮询超时，以毫秒为单位 |
| `ias.HttpPrimaryEndpoint` | `0` | 从分布端点返回的要使用的主端点 |
| `ias.HttpRangeRequestMinSizeKiB` | `128` | 部分块请求的最小数据块大小 |
| `ias.HttpRateLimitKiBPerSecond` | `0` | Http节流限制，以KiBPerSecond为单位 |
| `ias.HttpRecvBufKiB` | `-1` | Recv缓冲区大小 |
| `ias.HttpRecvWorkThresholdKiB` | `80` | 发送下一个请求时保留的数据阈值（以KiB为单位） |
| `ias.HttpRetryCount` | `2` | 请求失败之前的HTTP请求重试次数（如果连接到服务url而不是分布式端点）。 |
| `ias.HttpSocksIp` |  | 通过给定SOCKS代理路由所有IAS HTTP流量 |
| `ias.HttpSocksPort` | `1080` | 要使用的SOCKS代理的端口 |
| `ias.HttpSocksVersion` | `5` | 要使用的SOCKS代理协议版本 |
| `ias.HttpTimeOutMs` | `10000` | HTTP请求的超时值，以毫秒为单位 |
| `ias.MaxEndpointTestCountAtStartup` | `1` | 要在启动时测试的端点数 |
| `ias.ReportAnalytics` | `true` | 启用向分析系统报告统计数据 |
| `ias.ReportCacheAnalytics` | `true` | 启用向分析系统报告文件缓存使用情况的静态数据 |
| `ias.ReportHttpAnalytics` | `true` | 启用向分析系统报告http流量统计信息 |
| `ias.StatisticsLogInterval` | `30` | 启用并设置统计数据的定期日志记录间隔 |
| `ias.SuspendSystem` | `false` | 暂停OnDemand系统的使用 |
| `ias.TocMode` | `0` | IAS系统应如何加载其toc（请参见ETocMode）。 0=加载单个.iochunktoc 1=每次挂载pak文件时尝试查找.uondemandtoc 2=从目标CDN下载toc |

## IDO

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `IDO.Enable` | `false` | 允许为支持的类创建属性包和IDO。 |

## 图像

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `ImageWriteQueue.MaxConcurrency` | `-1` | 在任何给定时间允许的异步图像写入次数上限。默认为使用可用核数。 |
| `ImageWriteQueue.MaxQueueSize` | `-1` | 允许的排队图像写入任务数上限，当添加更多内容时将进行阻止。默认为使用可用内核数的4倍，如果在命令行上禁用多线程，则使用16倍。 |
| `ImgMedia.FieldOfViewMultiplier` | `1` | 将激活摄像机的视野乘以此值，通常会增加视锥体的总体大小，从而减少缺失图块瑕疵。 |
| `ImgMedia.FrameInvalidationMaxCount` | `2` | 当缺失最新mip/图块时，可以失效的缓存帧的数量上限。 |
| `ImgMedia.ICVFX.InnerOnlyTiles` | `false` | 此控制台变量将忽略除显示群集内部视口外的所有视口的图块计算。用户应在媒体板上启用分辨率修改以显示更低质量的mip，否则其他视口将仅显示专门为内部视口加载的图块，而不会显示其他内容。 |
| `ImgMedia.MipMapDebug` | `false` | 在ImgMedia插件使用的mipmap和图块上显示调试。 0：关闭（默认） 1：开启 |
| `ImgMedia.MipMapLevelPadding` | `0` | 填充到加载器使用的预估（最小和最大）mipmap级别的值。 |

## 游戏中的性能追踪

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `InGamePerformanceTracking.Enabled` | `0` | 如果启用了游戏中的性能追踪。大多数游戏可能不使用或不需要此功能，所以应禁用它。 |
| `InGamePerformanceTracking.HistorySize` | `30` | 游戏性能追踪应在历史记录中存储多少帧。 |

## 输入

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Input.AutoReconcilePressedEventsOnFirstRepeat` | `true` | 如果为true，则如果收到IE_Repeat事件但没有先收到按下事件，将自动标记IE_Pressed事件。 注意：此选项将在未来更新中移除。 |
| `Input.AxisEventsCanBeConsumed` | `true` | 如果为true，且给定轴事件的所有FKey都被消耗，则不会触发轴委托。 |
| `input.bRemapDeviceIdForOffsetPlayerGamepadIds` | `true` | 如果为true，则当bOffsetPlayerGamepadIds为true时，将根据需要为下一个本地播放器创建一个新的输入设备Id。这将修复分屏中的行为。 注意：此控制台变量将在未来版本中删除，这是漏洞修复行为的临时包装器。 |
| `Input.Debug.ShowBindingNames` | `false` | 如果为true，可在输入绑定编辑器中显示绑定名称。 |
| `Input.Debug.ShowTouches` | `0` | 是否在屏幕上显示触摸输入。 |
| `input.DisableHaptics` | `0` | 如果大于零，将不处理触觉反馈。 |
| `input.GlobalAxisConfigMode` | `0` | 是否应用全局轴配置设置。0=默认值（仅鼠标），1=全部，2=无 |
| `Input.ShouldAlwaysEvaluateForceFeedbackDuration` | `true` | 每次调用力反馈效果时是否应对其时长求值？ |

## Insights

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Insights.RecordAllWorldTypes` | `0` | 默认情况下，Gameplay Insights记录仅记录游戏世界和PIE世界。将此值切换为1将记录其他世界类型。 |

## 交换

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Interchange.FeatureFlags.Import.BMP` | `true` | 是否启用BMP支持。 |
| `Interchange.FeatureFlags.Import.DDS` | `true` | 是否启用DDS支持。 |
| `Interchange.FeatureFlags.Import.DefaultBasicLayoutView` | `false` | 在基本布局中是否默认启动导入对话框。 |
| `Interchange.FeatureFlags.Import.Enable` | `true` | 是否启用交换导入。 |
| `Interchange.FeatureFlags.Import.EXR` | `true` | 是否启用OpenEXR支持。 |
| `Interchange.FeatureFlags.Import.FBX` | `false` | 是否启用FBX支持。 |
| `Interchange.FeatureFlags.Import.FBX.ToLevel` | `false` | 是否启用对FBX级别导入的支持。 |
| `Interchange.FeatureFlags.Import.HDR` | `true` | 是否启用HDR支持。 |
| `Interchange.FeatureFlags.Import.IES` | `true` | 是否启用IES支持。 |
| `Interchange.FeatureFlags.Import.JPG` | `true` | 是否启用JPG支持。 |
| `Interchange.FeatureFlags.Import.MTLX` | `true` | 是否启用MaterialX支持。 |
| `Interchange.FeatureFlags.Import.OBJ` | `true` | 是否启用OBJ支持。 |
| `Interchange.FeatureFlags.Import.PCX` | `true` | 是否启用PCX支持。 |
| `Interchange.FeatureFlags.Import.PNG` | `true` | 是否启用PNG支持。 |
| `Interchange.FeatureFlags.Import.PSD` | `true` | 是否启用PSD支持。 |
| `Interchange.FeatureFlags.Import.Substrate` | `true` | 启用或禁用通过交换支持Substrate（仅当在项目设置中启用Substrate时有效）。默认启用。 |
| `Interchange.FeatureFlags.Import.TGA` | `true` | 是否启用TGA支持。 |
| `Interchange.FeatureFlags.Import.TIFF` | `true` | 是否启用TIFF支持。 |
| `Interchange.FeatureFlags.Import.UEJPEG` | `true` | 是否启用UEJPEG支持。 |
| `Interchange.FeatureFlags.Translator.UseWorker.FBX` | `false` | FBX转换器是否可以使用InterchangeWorker进程并行执行。 |

## 地形

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `landscape.AllowGrassStripping` | `true` | 启用在烘焙过程中有条件的剥离草地数据。 禁用将忽略bStripGrassWhenCooked*。 |
| `landscape.AllowNonNaniteVirtualShadowMapInvalidation` | `true` | 对于非Nanite地形，当顶点变形引入的高度差过大时，缓存的虚拟阴影贴图页面需要作废。这将完全启用或禁用此行为 |
| `landscape.AllowPhysicsStripping` | `true` | 启用在烘焙过程中有条件的剥离物理数据。 禁用将忽略bStripPhysicsWhenCooked*。 |
| `landscape.ApplyPhysicalMaterialChangesImmediately` | `1` | 立即应用物理材质任务更改，而不是在下一次烘焙/PIE中。 |
| `landscape.BrushFramePadding` | `5` | 当笔刷调用RequestLandscapeUpdate时，在推送一个完整的地形更新之前要等待的帧数 |
| `landscape.BrushOptim` | `0` | 这将启用地形图层优化。 |
| `landscape.CollisionMesh.HeightOffset` | `0` | 偏移碰撞网格体线框，从而帮助从较低地形LOD可能隐藏它的距离观看。 |
| `landscape.CollisionMesh.Show` | `1` | 选择使用ShowFlags.Collision时要可视化的高度场。0表示禁用，1表示简单，2表示复杂，3表示仅编辑器。 |
| `landscape.CollisionMesh.ShowPhysicalMaterial` | `false` | 启用后，将基于物理材质选择碰撞网格体的顶点颜色 |
| `Landscape.DebugViewMode` | `0` | 更改地形渲染的视图模式。有效输入：0=正常，2=DebugLayer，3=LayerDensity，4=LayerUsage，5=LOD分布，6=WireframeOnTop，7=LayerContribution |
| `landscape.DirtyHeightmapHeightThreshold` | `0` | 阈值，用于避免某些GPU在检测到高度图高度变化时出现不精确性问题，即只有高度差>此阈值（N超过16位单位高度），将被检测为发生变化。 |
| `landscape.DirtyHeightmapNormalThreshold` | `0` | 阈值，用于避免某些GPU在检测到高度图法线变化时出现不精确性问题，即只有法线通道差>此阈值（N分别超过每个8位单位B通道和A通道），将被检测为发生变化。 |
| `landscape.DirtyWeightmapThreshold` | `0` | 阈值，用于避免某些GPU在检测到权重图变化时出现不精确性问题，即只有差>此阈值（N超过每个8位单位权重图通道） |
| `landscape.DumpDiffDetails` | `false` | 当转储高度图的对比（landscape.DumpHeightmapDiff）或权重图的对比（landscape.DumpWeightmapDiff）时，转储有关像素不同的额外细节 |
| `landscape.DumpHeightmapDiff` | `0` | 这将保存上一个编辑图层混合相位中更改的回读高度图纹理的图像。（=0无对比,1=Mip 0对比，2=所有Mip对比 |
| `landscape.DumpWeightmapDiff` | `0` | 这将保存上一个编辑图层混合相位中更改的回读权重图纹理的图像。（=0无对比,1=Mip 0对比，2=所有Mip对比 |
| `landscape.EditLayersLocalMerge.Enable` | `0` | 这将允许新的合并算法（用于在地形组件级别合并图层）用于支持它的地形上。这是在等待不兼容的地形被弃用时的临时措施。 |
| `landscape.EditLayersLocalMerge.MaxComponentsPerHeightmapResolveBatch` | `16` | 解析高度图时，在单个批处理中渲染的组件数。数值越高，单个批处理中可以解析的高度图越多（同时GPU内存消耗越高，因为内存中一次性需要更多瞬态纹理）。 |
| `landscape.EditLayersLocalMerge.MaxComponentsPerWeightmapResolveBatch` | `16` | 解析权重图时，在单个批处理中渲染的组件数。数值越高，单个批处理中可以解析的权重图越多（同时GPU内存消耗越高，因为内存中一次性需要更多瞬态纹理）。 |
| `landscape.EnableGPUCulling` | `1` | 是否使用地形GPU剔除（如果受支持）。允许在运行时切换剔除 |
| `landscape.EnableGPUCullingShadows` | `1` | 是否为阴影视图使用地形GPU剔除（如果受支持）。允许在运行时切换阴影视图剔除 |
| `landscape.ForceFlush` | `0` | 这将在地形编辑时强制每帧渲染刷新。 |
| `landscape.ForceInvalidateNaniteOnLoad` | `false` | 在加载时触发Nanite表示的重新编译（用于调试目的） |
| `landscape.ForceLayersUpdate` | `0` | 这将强制地形编辑图层每帧更新，而不仅仅在请求时更新。 |
| `landscape.HeightmapCompressionMode` | `0` | 定义是否向地形应用压缩。 0：使用每个地形设置bUseCompressedHeightmapStorage（默认） 1：强制在所有地形上启用高度图压缩 -1：强制在所有地形上禁用高度图压缩 |
| `landscape.MobileWeightTextureArray` | `0` | 在移动平台上使用权重的纹理数组 |
| `landscape.Nanite.AsyncDebugWait` | `0` | 要暂停异步Nanite构建的时间，以秒为单位。用于调试 |
| `landscape.Nanite.LiveRebuildOnModification` | `0` | 执行修改后立即触发Nanite表示的重新编译（仅限世界分区贴图） |
| `landscape.Nanite.MaxAsyncProxyBuildsPerSecond` | `6` | 每秒要调度的异步nanite代理的数量 |
| `landscape.Nanite.MaxSimultaneousMultithreadBuilds` | `-1` | 最大数量的同时Nanite静态网格体任务（-1=无限制） |
| `landscape.Nanite.MultithreadBuild` | `1` | 多线程nanite地形编译（仅世界分区贴图） |
| `landscape.Nanite.UpdateLag` | `0.25` | 在上次地形更新后要等待的时间，之后才会触发nanite粒子重新编译，以秒为单位 |
| `landscape.NonNaniteVirtualShadowMapInvalidationLODAttenuationExponent` | `2` | 对于非Nanite地形，控制虚拟阴影贴图页面的失效率衰减曲线的形状（1 - X^N），其中X为相对LOD值（LODValue/NumMips范围为[0,1]），N为控制台变量 |
| `landscape.Optim` | `1` | 这将启用地形图层优化。 |
| `landscape.OutputLayersRTContent` | `0` | 这将输出渲染目标的内容。这仅用于调试。 |
| `landscape.OutputLayersWeightmapsRTContent` | `0` | 这将输出用于权重图的渲染目标的内容。这仅用于调试。 |
| `landscape.OverrideLOD0Distribution` | `-1` | 当>0时，将强制重载所有地形上的LOD0DistributionSetting属性，并忽略r.LandscapeLOD0DistributionScale |
| `landscape.OverrideLOD0ScreenSize` | `-1` | 当>0时，将强制重载所有地形上的地形LOD0ScreenSize属性 |
| `landscape.OverrideLODBlendRange` | `-1` | 当>0时，将强制重载所有地形上的LODBlendRange属性 |
| `landscape.OverrideLODDistribution` | `-1` | 当>0时，将强制重载所有地形上的地形LODDistributionSetting属性，并忽略r.LandscapeLODDistributionScale |
| `landscape.OverrideNonNaniteVirtualShadowMapConstantDepthBiasOverride` | `-1` | 当>0时，将强制重载所有地形上的地形NonNaniteVirtualShadowMapConstantDepthBias属性 |
| `landscape.OverrideNonNaniteVirtualShadowMapInvalidationHeightErrorThreshold` | `-1` | 当>0时，将强制重载所有地形上的地形NonNaniteVirtualShadowMapInvalidationHeightErrorThreshold属性 |
| `landscape.OverrideNonNaniteVirtualShadowMapInvalidationScreenSizeLimit` | `-1` | 当>0时，将强制重载所有地形上的地形NonNaniteVirtualShadowMapInvalidationScreenSizeLimit属性 |
| `landscape.RemoveEmptyPaintLayersOnEdit` | `0` | 这将分析回读时的权重图并删除不需要的分配（对于未绘制的图层）。 |
| `landscape.RenderCaptureLayersNextHeightmapDraws` | `0` | 在接下来的高度图绘制调用中触发N个渲染捕获。 |
| `landscape.RenderCaptureLayersNextPhysicalMaterialDraws` | `0` | 在接下来的地形物理材质绘制调用中触发N个渲染捕获。 |
| `landscape.RenderCaptureLayersNextWeightmapDraws` | `0` | 在接下来的权重图绘制调用中触发N个渲染捕获。 |
| `landscape.RenderCaptureNextMergeRenders` | `0` | 在接下来的N个RenderHeightmap/RenderWeightmap绘制中触发渲染捕获 |
| `landscape.RenderNanite` | `1` | 使用Nanite渲染地形。 |
| `landscape.ShowDirty` | `0` | 这将突出显示在图层混合相位过程中更改的数据。 |
| `landscape.SilenceSharedPropertyDeprecationFixup` | `true` | 在处理强制引入之前修改的数据时，静默地执行共享属性中的差异修复。 |
| `landscape.SimulateAlphaBrushTextureLoadFailure` | `false` | 在加载alpha笔刷纹理时，用于模拟加载失败（例如无效源数据，这可能发生在烘焙编辑器或虚拟化糟糕的纹理中）的调试工具 |
| `landscape.SimulatePhysics` | `0` | 这将在包含地形的世界上启用物理模拟。 |
| `landscape.SplineFalloffModulation` | `1` | 启用样条线图层衰减的纹理调制。 |
| `Landscape.Splines.ApplyToSplineComponentMaxIterations` | `200` | 将地形样条线转换为样条线组件时的最大可能迭代 |
| `landscape.StripLayerMipsOnLoad` | `false` | （在加载时）从图层中不必要的纹理中删除mip链 |
| `landscape.SupportGPUCulling` | `1` | 是否支持地形GPU剔除 |
| `landscape.SupressMapCheckWarnings.Nanite` | `false` | 如果Nanite数据过期，将发出MapCheck Info消息而不是警告 |
| `landscape.TrackDirty` | `0` | 这将追踪图层混合相位过程中所作的数据更改的累积。 |
| `landscape.UpdateProxyActorRenderMethodOnTickAtRuntime` | `false` | 刷新后，将更新地形代理的渲染方法（启用nanite）。始终在编辑器中启用。 |
| `landscape.ValidateProxyWeightmapUsages` | `1` | 这将验证权重图在地形代理及其组件中的使用与地形组件图层分配不同步。 |

## 布局UV

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `LayoutUV.TracePackingForInputHash` |  | 激活值中指定的输入哈希的追踪。 |

## 关卡实例

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `levelinstance.debug.forcelevelstreaming` | `0` | 设置为1，将强制关卡实例流送，而不是嵌入到世界分区网格中。 |
| `LevelInstance.ForceEditorWorldMode` | `false` | 允许-game实例的行为类似临时根对象附加到实例的编辑器。这将阻止HLOD在-game中工作。仅非WP世界上支持此功能。 |

## 关卡序列

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `LevelSequence.DefaultClockSource` | `0` | 指定新建关卡序列的默认时钟来源。0：刷新，1：平台，2：音频，3：相对时间码，4：时间码，5：自定义 |
| `LevelSequence.DefaultDisplayRate` | `30fps` | 指定新建关卡序列的默认显示帧率；还定义帧锁定帧率，其中序列设置为帧锁定。示例：30 fps，120/1 (120 fps)，30000/1001 (29.97)，0.01s (10ms)。 |
| `LevelSequence.DefaultLockEngineToDisplayRate` | `0` | 0：播放锁定到播放帧 1：带有子帧插值的未锁定播放 |
| `LevelSequence.DefaultTickResolution` | `24000fps` | 指定新建关卡序列的默认更新分辨率。示例：30 fps，120/1 (120 fps)，30000/1001 (29.97)，0.01s (10ms)。 |
| `LevelSequence.InvalidBindingTagWarnings` | `true` | 当使用无效对象绑定标记重载绑定时是否发出警告。 |
| `LevelSequence.MarkSequencePlayerAsGarbageOnDestroy` | `true` | 当Actor被销毁时，是否将序列播放器对象标记为垃圾 |

## 关卡流送

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `LevelStreaming.DefaultAllowClientUseMakingInvisibleTransactionRequests` | `true` | 标记与世界支持相结合，用于使事务请求对服务器不可见，用于确定客户端是否应等待服务器确认可见性更新，然后再使流送关卡不可见。 0：禁用，1：启用 |
| `LevelStreaming.DefaultAllowClientUseMakingVisibleTransactionRequests` | `false` | 标记与世界支持相结合，用于使事务请求对服务器可见，用于确定客户端是否应等待服务器确认可见性更新，然后再使流送关卡可见。 0：禁用，1：启用 |
| `LevelStreaming.Profiling.Enabled` | `true` | 是否自动启用LevelStreamingProfilingSubsystem。 |
| `LevelStreaming.Profiling.LateStreamingDistanceSquared` | `0` | 距离的平方（例如来自世界分区单元边界），低于它时关卡被视为较晚流送。 |
| `LevelStreaming.Profiling.StartAutomatically` | `false` | 在子系统创建后是否立即开始记录关卡流送事件。 |
| `LevelStreaming.ShouldReuseUnloadedButStillAroundLevels` | `true` | 关卡流送是否会重复使用尚未垃圾回收的未加载关卡。 0：禁用，1：启用 |
| `LevelStreaming.ShouldServerUseMakingVisibleTransactionRequest` | `true` | 服务器是否应等待客户端确认可见性更新，然后才将流送关卡视为客户端可见。 0：禁用，1：启用 |

## 连接器

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `linker.EnableFullBlueprintPreloading` | `true` | 如果为true，蓝图类重新生成将对所有依赖项执行完整的预加载。 |
| `linker.TreatVerifyImportErrorsAsWarnings` | `0` | 如果为true，由于验证导入失败而发出的错误将改为警告。 |

## 实时编码

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `LiveCoding.ConsolePath` | `D:/UE54Test/UE_RelTestA/Engine/Binaries/Win64/LiveCodingConsole.exe` | 实时编码控制台应用程序的路径 |
| `LiveCoding.SourceProject` | `D:/UnrealProjects/IrisTest/IrisTest.uproject` | 到编译此目标的项目的路径 |

## 低级别内存

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `LLM.LLMHeaderMaxSize` | `5000` | 所有低级别内存图块所允许的最大总字符数 |
| `LLM.LLMWriteInterval` | `1` | 低级别内存csv中每行之间的秒数（零表示每帧写入） |
| `LLM.TrackPeaks` | `0` | 追踪每个类别中自进程开始时间而不是当前帧的值以来的峰值内存。 |

## 本地化

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Localization.AsyncLoadLocalizationData` | `true` | True，可异步加载本地化数据（无阻止），False，可同步加载该数据（阻止） |
| `Localization.AsyncLoadLocalizationDataOnLanguageChange` | `false` | True，当语言发生改变时可异步加载本地化数据（无阻止），False，可同步加载该数据（阻止） |
| `Localization.DisplayStringSupport` | `0` | 是否启用显示字符串支持？0：自动（默认），1：启用，2：禁用 |
| `Localization.HangulTextWrappingMethod` | `1` | 0：PerSyllable，1：PerWord（默认）。 |
| `Localization.Message.AllowTextArgumentModifiers` | `false` | 是否允许消息->文本转换使用文本样式的参数修饰符（默认值：false） |
| `Localization.SpanishUsesMinTwoGrouping` | `true` | False：1234将使用组分隔符；True：1234将不使用组分隔符(默认)。 |
| `Localization.SpanishUsesRAENumberFormat` | `true` | False：禁用（CLDR格式），True：启用（RAE格式，默认）。 |
| `Localization.UGC.AlwaysExportFullGatherLog` | `false` | True，可从运行本地化commandlet导出完整的采集日志，即使没有错误 |
| `Localization.UseLocaleSpecificDigitCharacters` | `true` | False：语言区将始终使用阿拉伯数字字符（例如1234），True：语言区将使用其CLDR数据中指定的数字字符（默认值）。 |

## 细节级别

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `lod.TemporalLag` | `0.5` | 它控制临时LOD的时间延迟，以秒为单位。 |

## 记录

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `log.Category` | `1` | 定义类别是否以什么形式包含在日志文件的每一行中。 0=不记录类别 2=记录类别（默认） |
| `log.flushInterval` | `0.2` | 日志记录间隔，以秒为单位 |
| `log.Timestamp` | `1` | 定义时间是否以什么形式包含在日志文件的每一行中。布局：[time][frame mod 1000] 0=不显示日志时间戳 1=记录时间戳（UTC格式）和帧时间（默认），例如[2015.11.25-21.28.50:803][376] 2=记录自GStartTime开始经过的时间戳（以秒为单位），例如[0130.29][420] 3=记录时间戳（本地时间）和帧时间，例如[2017.08.04-17.59.50:803][420] 4=记录时间戳及引擎事件代码和帧时间，例如[17:59:50:18][420] |
| `LogBlueprintComponentInstanceCalls` | `0` | 记录蓝图组件实例调用；调试。 |
| `LogGameThreadFNameChurn.Enable` | `0` | 如果>0，则收集示例游戏线程fname创建，定期打印最糟糕情况的报告。 |
| `LogGameThreadFNameChurn.PrintFrequency` | `300` | 抖动报告之间的帧数。 |
| `LogGameThreadFNameChurn.RemoveAliases` | `1` | 如果值>0，则删除计数进程中的别名。这实际上是合并具有相同人工可读字符串的地址。它更慢。 |
| `LogGameThreadFNameChurn.SampleFrequency` | `1` | 每个示例的fname创建数量。这用于防止抖动采样过多地拖慢游戏速度。 |
| `LogGameThreadFNameChurn.StackIgnore` | `4` | 从堆栈帧顶部丢弃的项目数。 |
| `LogGameThreadFNameChurn.StackLen` | `3` | 要保留的堆栈帧项目的数量上限。这将改进聚合，因为从不同位置发出但最终到达同一位置的调用将一起计算。 |
| `LogGameThreadFNameChurn.Threshhold` | `10` | 报告中要包含的每帧fname创建的最小平均数量。 |
| `LogGameThreadMallocChurn.Enable` | `0` | 如果>0，则收集示例游戏线程malloc、重新分配和释放，定期打印最糟糕情况的报告。 |
| `LogGameThreadMallocChurn.PrintFrequency` | `300` | 抖动报告之间的帧数。 |
| `LogGameThreadMallocChurn.RemoveAliases` | `1` | 如果值>0，则删除计数进程中的别名。这实际上是合并具有相同人工可读字符串的地址。它更慢。 |
| `LogGameThreadMallocChurn.SampleFrequency` | `100` | 在示例之间要跳过的分配数。这用于防止抖动采样过多地拖慢游戏速度。 |
| `LogGameThreadMallocChurn.StackIgnore` | `2` | 从堆栈帧顶部丢弃的项目数。 |
| `LogGameThreadMallocChurn.StackLen` | `3` | 要保留的堆栈帧项目的数量上限。这将改进聚合，因为从不同位置发出但最终到达同一位置的调用将一起计算。 |
| `LogGameThreadMallocChurn.Threshhold` | `10` | 报告中要包含的每帧分配的最小平均数量。 |

## LWI

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `LWI.Editor.GridSize` | `-1` | 设置将生成LWI管理器的网格的大小。 |

## 主框架

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Mainframe.ShowRestoreAssetsPromptInPIE` | `false` | 在启动时使用PIE运行时恢复资产窗口（默认值：false）。在沉浸模式下或如果Mainframe.ShowRestoreAssetsPromptOnStartup设置为false，它不起作用。 |
| `Mainframe.ShowRestoreAssetsPromptOnStartup` | `true` |  |

## Malloc

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `MallocBinned2.FlushThreadCacheMaxWaitTime` | `0.02` | 时间阈值，超过此阈值将发出有关FlushCurrentThreadCache耗时太久的警告，以秒为单位。 |
| `MallocBinned3.FlushThreadCacheMaxWaitTime` | `0.02` | 时间阈值，超过此阈值将发出有关FlushCurrentThreadCache耗时太久的警告，以秒为单位。 |

## 材质

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `MaterialBaking.ForceDisableEmissiveScaling` | `false` | 如果设置为true，自发光纹理中存储的值将限制为[0, 1]范围，而不是使用EmissiveScale材质静态参数进行规格化和比例重置。 |
| `MaterialBaking.RenderDocCapture` | `0` | 确定是否触发RenderDoc捕获。 0：关闭 1：打开 |
| `MaterialBaking.SaveIntermediateTextures` | `0` | 确定是否为每个展平材质属性保存中间BMP图像。 0：关闭 1：打开 |
| `MaterialBaking.UseMaterialProxyCaching` | `1` | 确定是否应缓存材质代理以加速材质烘焙。 0：关闭 1：打开 |
| `MaterialBaking.VTWarmupFrames` | `5` | 当材质烘焙时，为虚拟纹理预热而要渲染的帧数。 |
| `MaterialUtilities.WarmupFrames` | `10` | 为预热各种渲染系统（VT/Nanite/等等）而在每次捕获前要渲染的帧数。 |

## 最大资产

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `MaxAssetFullPath` | `32767` | 资产的最大完整路径名称。 |

## 媒体IO

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `MediaIO.PreventFieldFlipping` | `1` | 是否启用交错地块翻转修复。（试验性） |

## 内存

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `memory.logGenericPlatformMemoryStats` | `1` | 报告平台内存统计数据 |
| `memory.MemoryPressureCriticalThresholdMB` | `512` | 当可用物理内存低于此阈值时，内存统计数据将这视为处于临界压力。 如果平台可以明确说明其内存压力，则可以忽略此测试。 0（默认值），临界压力不使用此阈值。 |
| `memory.WindowsPlatformMemoryGetStatsLimitTotalGB` | `0` | 设置综合平台总内存大小（以GB为单位），它将作为总内存和可用内存从GetStats返回 |
| `memory.WindowsPlatformMemoryUseContainerMemory` | `false` | 设置为假设该进程在docker容器中运行，并在计算可用内存时，考虑整个容器的内存使用情况。 |
| `mi.MemoryResetDelay` | `10000` | 将最近释放的内存页保留在进程内以供重复使用的时间（以毫秒为单位）。这可以在分配高强度工作负载期间显著减少操作系统的内存归零和页面错误开销。 |
| `mmio.enable` | `1` | 如果>0，则在支持内存映射IO的平台上启用。 |

## 网格体

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `MeshMergeUtilities.UVGenerationMethod` | `0` | 创建合并或代理网格体时的UV生成方法 0-引擎默认-（当前补丁编译器） 1-旧版 2-UVAtlas 3-XAtlas 4-补丁编译器 |
| `n.bNavmeshAllowPartitionedBuildingFromEditor` | `false` | 启用试验性寻路网格体分区编译。5.3已废弃：改用ai.nav.bNavmeshAllowPartitionedBuildingFromEditor。 |

## 消息总线

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `MessageBus.UDP.BadEndpointPeriod` | `60` | 端点套接字错误之间的时间间隔，将被视为错误端点，以秒为单位。 |
| `MessageBus.UDP.CheckForExpiredWithFullQueue` | `0` | 尝试通过检查在途片段是否已过期但未经过确认，尝试释放工作队列上的压力。 |
| `MessageBus.UDP.ConnectionsToError` |  | 当启用MessageBus.UDP.InduceSocketError时，连接出错。 可以用逗号分隔，格式为IPAddr2:port,IPAddr3:port |
| `MessageBus.UDP.EndpointDenyListEnabled` | `true` | 指定是否启用端点拒绝列表。启用后，问题端点将进行标记，以便可能被排除在通信之外。允许的最大尝试次数由MessageBus.UDP.MaxRetriesForBadEndpoint决定 |
| `MessageBus.UDP.InduceSocketError` | `0` | 该控制台变量可用于在出站通信中引起套接字失败。 如果IP地址匹配，任何非零值将强制输出套接字连接失败 MessageBus.UDP.ConnectionsToError中的值之一。可通过调用MessageBus.UDP.ClearDenyList清除该列表。 |
| `MessageBus.UDP.MaxRetriesForBadEndpoint` | `5` | 当套接字连接未能到达端点时，将尝试的重试次数上限。 |
| `MessageBus.UDP.SegmenterMaxResends` | `16` | 尝试将数据重新发送到端点的次数。值限制为1到100之间。 |
| `MessageBus.UDP.SegmenterTimeout` | `100` | 等待片段被确认的毫秒数，之后再尝试重新发送。值限制为10到1000之间 |

## 建模

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `modeling.CreateMesh.IgnoreProjectSettings` | `false` | 启用后，在构建新的网格体对象时，不要使用建模工具的项目设置中的首选项设置 |
| `modeling.DisableAutoUVAreaDensitySampling` | `0` | 如果设置，将AutoUV的PatchBuilder算法的行为返回到旧版行为。 |
| `modeling.EnablePolyModel` | `0` | 启用原型PolyEdit选项卡 |
| `modeling.EnablePresets` | `1` | 启用工具预设功能和UX |
| `modeling.EnablePrototypes` | `0` | 启用不支持的试验性原型建模工具 |
| `modeling.EnableVolumeSnapping` | `false` | 启用对齐到体积 |
| `modeling.PolyEdit.EdgeLimit` | `60000` | PolyEd和TriEd支持的最大边缘数。在PolyEd或TriEd中需要渲染超过此数量的边缘的网格体，将强制禁用工具以避免挂起编辑器。 |
| `modeling.Selection.EnableStaticMeshLocking` | `true` | 控制是否默认为静态网格体启用选择锁定 |
| `modeling.Selection.EnableVolumeLocking` | `true` | 控制是否默认为体积启用选择锁定 |
| `modeling.Selection.FullHoverHighlights` | `0` | 使用完整选择悬停高亮，而不是简化的高亮 |
| `modeling.UVEditor.EnableLivePreviewArrangement` | `1` | 当从内容浏览器加载多个对象时，在UV编辑器的实时视口中启用自动排列对象。 |
| `modeling.UVEditor.LivePreviewArrangementMode` | `0` | 用于UV编辑器实时预览自动排列的模式：0-直线，1-圆形 |
| `modeling.UVEditor.UDIMSupport` | `1` | 在UVEditor中启用试验性UDIM支持 |
| `modeling.VolumeMaxTriCount` | `500` | 建模工具发出的体积的三角形数量限制。超过此限制的网格体将被自动简化。 |
| `modeling.WorldRenderCapture.VTWarmupFrames` | `5` | 为预热渲染器而在每次捕获前要渲染的帧数。 |

## 电影场景

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `MovieScene.LegacyConversionFrameRate` | `60000fps` | 指定4.20之前保存的UMovieScene数据的默认刷新分辨率（默认值：60000fps）。示例：60000 fps，120/1 (120 fps)，30000/1001 (29.97)，0.01s (10ms)。 |
| `MovieScene.RemoveMutedTracksOnCook` | `0` | 如果为1，将在烘焙时删除静音追踪，否则保持原样。 |

## 网络连接

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `n.IpNetDriverMaxFrameTimeBeforeAlert` | `1` | 在发出提醒之前，在单个帧中处理网络数据所花费的时间（以秒为单位） 如果在上一个提醒之后的额外处理再次超过阈值，则可能在单个帧中多次调用它 默认值：1s |
| `n.IpNetDriverMaxFrameTimeBeforeLogging` | `10` | 在打印输出日志警告之前，在单个帧中处理网络数据所花费的时间（以秒为单位） 默认值：10s |
| `n.VerifyPeer` | `1` | 设置libcurl的CURLOPT_SSL_VERIFYPEER选项以验证对等方证书的真实性。 0=禁用（允许自签名证书） 1=启用[默认值] |
| `net.ActorChannelPool` | `1` | 如果非零，Actor通道将进行池化以节省内存和对象创建开销。 |
| `net.AddNetDriverInfoToNetAnalytics` | `false` | 自动将NetDriver信息添加到NetAnalytics缓存中 |
| `net.AllowAsyncLoading` | `0` | 允许异步加载数据包中引用的未加载资产。如果为false，客户端将卡顿并立即加载资产，如果为true，数据包将在资产异步加载时延迟。可启用net.DelayUnmappedRPCs以延迟依赖于异步加载资产的RPC。 |
| `net.AllowClientRemapCacheObject` | `false` | 启用后，将允许客户端重新映射只读缓存对象并保留相同的NetGUID。 |
| `net.AllowEncryption` | `1` | 如果为true，引擎将尝试加载一个加密PacketHandlercomponent，并基于?EncryptionToken=URL选项填充NMT_Hello消息的EncryptionToken参数，如果它不为空，将调用回调。此外，值'2'将使EncryptionToken成为必需-这将在服务器端强制执行。0=禁用，1=允许（默认，2=必需） |
| `net.AllowPIESeamlessTravel` | `false` | 当为true时，允许在单个进程PIE中无缝漫游。 |
| `net.AllowReliableMulticastToNonRelevantChannels` | `1` | 允许可靠的服务器组播被发送到不相关的Actor，只要它们是一个现有的Actor通道即可。 |
| `net.AllowRPCDoSDetectionBlocking` | `1` | 重载是否允许RPC DoS检测RPC阻止。0=禁用，1=启用。 |
| `net.AllowRPCDoSDetectionKicking` | `1` | 重载是否启用RPC DoS检测RPC踢出。0=禁用，1=启用。 |
| `net.AlwaysUpdateGuidReferenceMapForNetSerializeObjectStruct` | `false` | 需要net.TrackNetSerializeObjectReferences。如果为true，带有对象属性的NetSerialize结构体属性的GuidReferenceMap中的条目将始终更新，而不仅仅是当Guid发生更改或变为NULL时。这可以防止在映射结构体中未映射的Actor引用时应用旧属性数据出现问题。 |
| `net.BitReader.EnsureOnOverflow` | `1` | 确保BitReader是否溢出。如果设置，'BitReader.LogFatalOnOverflow'将优先于它。 |
| `net.BlockSend` | `0` | 启用后，在NetConnection's上发送阻止数据包。 |
| `net.CheckNoLoadPackages` | `true` | 启用后，在对未标记为IsFullyLoaded的数据包强制同步加载之前，检查GetObjectFromNetGUID中的没有加载标志 |
| `Net.CheckPushBPRepIndexAgainstName` | `false` | 启用后，验证BP生成的传递给MarkPropertyDirtyFromRepIndex的值是否与实际属性数据匹配 |
| `net.CleanUpRenamedDynamicActors` | `0` | 启用后，在服务器上通过Rename()更改外部的动态Actor将关闭其通道或向客户端发送销毁信息，但未加载Actor的新关卡。 |
| `net.ClientIncomingBunchFrameTimeLimitMS` | `0` | 限制客户端传入束处理限制的时间，以秒为单位。如果为0，没有限制。只要低于限制，将开始处理另一个束。需要一段时间才能完成处理的单个束可能会超过限制。在达到限制后，数据包中的剩余束将排队，且IpNetDriver将不再处理当前帧中的任何数据包。 |
| `net.ClientToServerUnreliableRPCQueueSize` | `16` | 从客户端发送到服务器的不可靠的排队RPC的数量上限。如果有更多的RPC排队，则将丢弃旧的RPC。 |
| `net.CloseTimingDebug` | `0` | 在连接关闭时，记录最后一个数据包发送/接收和TickFlush/TickDispatch次数-用于调试阻止发送/接收路径。 |
| `net.ContextDebug` | `0` | 用于在复制期间设置上下文字符串的调试选项 |
| `net.ControlChannelDestructionInfo` | `0` | 启用后，通过控制通道发送销毁信息更新，而不是创建一个新的Actor通道。0：旧行为，使用Actor通道。1：新行为，使用控制通道 |
| `net.CurrentHandshakeVersion` | `4` | 当前支持的无状态握手协议版本（数字） |
| `net.DebugAppendResolverAddress` |  | 如果设置了该值，所有IP地址分辨率方法会将该控制台变量的值添加到结果列表中。这允许在所有多个地址上测试分辨率功能，最终目标是获得成功的结果（作为该控制台变量的值）。 |
| `net.DebugDraw` | `0` | 绘制网络休眠和相关性的调试信息 1启用网络调试绘制。0，禁用。 |
| `net.DebugDrawCullDistance` | `0` | net.DebugDraw的剔除距离。世界UnitsMax世界单位，Actor可以远离本地视图以绘制其休眠状态。零将禁用剔除 |
| `net.DebugDualIPs` | `0` | 如果为true，将复制接收到的每个数据包，并使用新的（确定性）IP进行处理，用于模拟接收来自双IP的客户端数据包-这可能发生在现实世界网络条件下（仅支持服务器上的单个客户端）。 |
| `net.DebugInitialConnect` | `1` | 启用后，定期记录套接字级别的客户端发送状态，直到成功接收数据包以验证连接。 |
| `net.DebugInitialConnectLogFrequency` | `10` | 初始连接调试日志记录之间的时间间隔，以秒为单位。 |
| `net.DelayUnmappedRPCs` | `0` | 如果为true，延迟接收到具有未映射对象引用的RPC，直到它们被接收或加载，如果为false，RPC将立即执行空参数。这可以与net.AllowAsyncLoading一起使用，以在异步加载期间避免资产参数为空。 |
| `net.DelinquencyNumberOfTopOffendersToTrack` | `10` | 当>0时，这将是PackageMap和GuidCache分别为排队Actor和异步加载追踪的'TopOffenders'的数量。net.TrackAsyncLoadingGUIDThreshold/net.TrackQueuedActorThreshold仍决定是否追踪这些项目。 |
| `net.DeltaInitialFastArrayElements` | `false` | 如果为true，发送初始快速数组元素的增量结构体变更列表。 |
| `net.DisableBandwithThrottling` | `0` | 强制IsNetReady始终返回true。在发布构建中不可用。 |
| `net.DisableIPv6` | `1` | 如果为true，IPv6将不解析，并尽可能避免使用 |
| `net.DisableRemapScriptActors` | `0` | 当设置时，禁用编译脚本Actor的名称重新映射（用于网络连接） |
| `net.DiscardTornOffActorRPCs` | `true` | 启用后，如果Actor断开，丢弃RPC。 |
| `net.DoHandshakeVersionFallback` | `0` | （客户端）是否在失败时执行随机回退到握手协议的先前版本。 |
| `net.DoPacketOrderCorrection` | `1` | 是否通过缓存数据包并等待缺失的序列，尝试修复"乱序"数据包序列。 |
| `net.DoPropertyChecksum` | `0` | 当为true且定义了ENABLE_PROPERTY_CHECKSUMS时，将在客户端和服务器上比较复制属性的校验和 |
| `net.DormancyEnable` | `1` | 启用网络休眠系统，以减少不频繁更新Actor的CPU和带宽开销 1启用网络休眠。0禁用网络休眠。 |
| `net.DormancyHysteresis` | `0` | 当>0时，表示在让通道完全休眠之前等待的时间（以秒为单位）。当对象比正常情况下更频繁地进入和退出休眠状态时，它可以防止抖动。 |
| `net.DormancyValidate` | `0` | 验证休眠Actor在休眠状态时不会改变状态（仅在服务器上）0：不验证。1：在唤醒时验证。2：在每次网络更新时验证 |
| `net.EnableCongestionControl` | `0` | 启用拥塞控制模块。 |
| `net.EnableDetailedScopeCounters` | `true` | 启用详细的网络范围循环计数器。通常会有很多这样的情况，这会对性能产生负面影响。 |
| `net.EnableFlushDormantSubObjects` | `1` | 启用后，FlushNetDormancy将刷新复制的子对象以及复制的组件。仅适用于使用复制的子对象列表的对象。 |
| `net.EnableFlushDormantSubObjectsCheckConditions` | `1` | 启用后，当et.EnableFlushDormantSubObjects也为true时，休眠刷新也将检查复制的子对象条件 |
| `net.EnableNetInitialSubObjects` | `true` | 启用新的SubObjects以将bNetInitial设置为true，从而确保所有复制的属性都已复制。 |
| `net.FilterGuidRemapping` | `1` | 从未映射列表中删除已销毁的GUID和父GUID |
| `net.fix.AllowListenParamSentToClient` | `false` | 当为true时，允许'?listen'在漫游期间被发送到客户端。这将混淆客户端并导致RPC崩溃。 |
| `net.FlushDormancyUseDefaultStateForUnloadedLevels` | `1` | 启用后，如果客户端没有加载Actor的关卡，休眠刷新将使用默认对象状态的复制器。 |
| `Net.ForceConnectionViewerPriority` | `1` | 强制连接的玩家控制器和查看Pawn作为最高优先级。 |
| `net.ForceNetFlush` | `0` | 写入时立即刷新发送缓冲区（帮助追踪数据包写入-警告：可能不稳定）。 |
| `net.HandshakeEnforceNetworkCLVersion` | `0` | 无状态握手是否应强制Network CL版本，而不是更高级别的网络代码。 |
| `net.HandshakeResendInterval` | `1` | 重新发送握手数据包之间尚未没有收到响应的延迟。 |
| `net.IgnoreNetworkChecksumMismatch` | `0` | 如果为true，将忽略packagemap对象上的完整性校验和，这可能导致数据不同步的问题 |
| `net.InstantReplayProcessQueuedBunchesMillisecondLimit` | `8` | 用于在即时重播期间处理排队束的时间阈值。如果在单个帧中花费的时间超过此时间，则等到下一帧继续处理排队束。对于无限时间，设置为0。 |
| `net.IpConnectionDisableResolution` | `0` | 启用后，任何未来的ip连接将不会使用分辨率方法。 |
| `net.IpConnectionUseSendTasks` | `0` | 如果为true，IpConnection将在任务图表任务中调用套接字的SendTo函数，以便它可以脱离游戏线程运行。 |
| `net.IpNetDriverReceiveThreadPollTimeMS` | `250` | 如果net.IpNetDriverUseReceiveThread为true，接收线程上用作FSocket::Wait的超时值的毫秒数。负值表示无限期等待（但FSocket::Shutdown应取消它）。 |
| `net.IpNetDriverReceiveThreadQueueMaxPackets` | `1024` | 如果net.IpNetDriverUseReceiveThread为true，可以在队列中等待的数据包数上限。将丢弃收到的其他数据包。 |
| `net.IpNetDriverUseReceiveThread` | `0` | 如果为true，IpNetDriver将在单独的线程（不是游戏线程）上调用套接字的RecvFrom函数 |
| `net.iris.AllowAsyncLoading` | `true` | 允许或不允许在使用iris复制时进行异步加载的标记。注意：还必须启用net.allowAsyncLoading。 |
| `net.Iris.AllowPollPeriodOverrides` | `true` | 是否允许在ObjectReplicationBridgeConfig中设置的轮询周期重载。默认值为true。 |
| `net.Iris.Attachments.AllowSendPolicyFlags` | `true` | 允许使用ENetObjectAttachmentSendPolicyFlags指定RPC的行为。 |
| `net.Iris.bWarnAboutStructPropertiesWithSuspectedNotReplicatedProperties` | `false` | 尝试检测作为属性复制的结构体是否可能包含默认禁用的未注释成员。 |
| `net.Iris.ColdResolvingRetryTimeMS` | `200` | 在此毫秒数后解析未解析的冷引用。 |
| `Net.Iris.CullNonRelevant` | `true` | 启用后，将剔除与任何客户端都不相关的复制Actor。 |
| `Net.Iris.DebugName` |  | 设置要中断的类名称或对象名称。 |
| `Net.Iris.DebugRPCName` |  | 设置要断开的RPC的名称。 |
| `net.Iris.DeferEndReplication` | `true` | bDeferEndReplication，如果为true，对EndReplication的调用将延迟到应用statdata之后。默认值为true。 |
| `net.Iris.DeltaCompressInitialState` | `true` | 如果为true，在序列化初始状态时与默认状态进行比较。 |
| `net.Iris.DispatchUnresolvedPreviouslyReceivedChanges` | `false` | 在应用状态数据时，是否包括先前接收到的更改，这些更改包含对此帧收到的数据的未解析对象引用。它可以调用要调用的rep notify函数，尽管它没有更改。默认值为false。 |
| `net.Iris.EnableActorLevelChanges` | `true` | 当为true时，ActorReplicationBridge将通过更新Actor的级别组处理更改级别的Actor。 |
| `net.Iris.EnableDeltaCompression` | `true` | 为复制对象启用增量压缩。默认值为true。 |
| `net.Iris.EnableFilterMappings` | `true` | 是否支持ObjectReplicationBridgeConfig中设置的过滤器映射。如果启用过滤器映射，即使没有特定的映射，也可以为对象分配默认空间过滤器。默认值为true。 |
| `net.Iris.EnableForceNetUpdate` | `false` | 当为true时，系统仅允许forceneupdate跳过对象的轮询频率。当为false时，将立即轮询任何MarkDirty对象。 |
| `net.Iris.EnableRPCs` | `1` | 如果>0，让Iris复制和执行RPC。 |
| `net.Iris.EnsureIfNumGroupMembershipsExceeds` | `128` | 如果设置为正数，将警告并确保对象是否添加到多个组中。 |
| `net.Iris.ExecuteReliableRPCsBeforeApplyState` | `true` | 如果为true且Iris以向后兼容模式运行，则可靠的RPC将在我们对目标对象应用状态数据之前执行，除非我们首先需要生成对象。 |
| `net.iris.ForceFullCopyAndQuantize` | `false` | 启用后，将使用完整复制和量化，禁用后，将仅复制和量化脏状态数据。 |
| `net.iris.ForceFullDequantizeAndApply` | `false` | 启用后，将在应用收到的状态数据时使用脏状态的完全去量化，而不论片段中设置的特征如何。 |
| `net.Iris.ForcePruneBeforeUpdate` | `false` | 在每次更新开始时验证所有追踪实例的完整性。 |
| `net.Iris.HotResolvingLifetimeMS` | `1000` | 如果在此毫秒数内创建了未解析引用，该引用将被视为热的，否则将被视为冷的。 |
| `net.Iris.IrisPreExportExistingNetTokensOnConnect` | `false` | 如果为true，将在添加新连接时将所有现有NetTokens排队用于预导出。 |
| `net.Iris.LogReplicationProtocols` | `false` | 如果为true，将记录所有创建的复制协议。 |
| `net.Iris.MinimumNumberOfFramesBetweenBaselines` | `60` | 在为对象创建新的增量压缩基线之间的帧数下限。默认值为60。 |
| `net.Iris.OnlyQuantizeDirtyMembers` | `true` | 如果为true，将仅量化标记为脏的成员，除非这是一个新对象。 |
| `net.Iris.PacketSequenceSafetyMargin` | `4` | 在考虑数据包序列满之前需要预留多少数据包。这允许发送一些非DataStreamChannel数据包，而不会弄乱数据包确认。 |
| `net.Iris.PushModelMode` | `2` | 0=禁用但运行时可切换，1=启用但不可切换，2=启用但运行时可切换。需要Net.IsPushModelEnabled为true且WITH_PUSH_MODEL>0，以在向后兼容模式使用基于推送的脏污度。 |
| `net.Iris.RemapDynamicObjects` | `true` | 允许在接收端重新映射动态对象。这允许在重新创建对象时更新先前指向特定对象的属性。默认值为true。 |
| `net.Iris.ReplicationWriter.ValidateObjectsWithDirtyChanges` | `true` | 当无效对象不应被标记为脏时，确保我们不会尝试将其标记为脏。 |
| `net.Iris.ReplicationWriterMaxAllowedPacketsIfNotHugeObject` | `3` | 如果有更多数据要写入，允许ReplicationWriter超额提交数据。 |
| `net.Iris.ReplicationWriterMaxHugeObjectsInTransit` | `16` | 允许安排发送多少个非常大的对象（其中这些对象的负载不适合单个数据包）。需要至少为1。 |
| `net.Iris.ResolvedObjectsDispatchDebugging` | `false` | 调试解析对象状态调度的日志记录。默认值为false。 |
| `net.Iris.SaturateBandwidth` | `false` | 是否使带宽饱和。默认值为false。 |
| `net.Iris.Stats.ShouldIncludeSubObjectWithRoot` | `true` | 启用后，SubObjects将与RootObject一起报告统计数据，如果设置为false，SubObjects将被视为单独的对象。 |
| `net.Iris.UseChangeMaskForTArray` | `true` | 为TArray中的单个元素启用或禁用更改遮罩的使用。当启用且发生数据包丢失时，收到的数组可能不反映发送端曾经存在的状态，因为数组不会自动复制。默认启用。 |
| `net.Iris.UseDormancyToFilterPolling` | `true` | 是否应使用休眠过滤掉不应轮询的对象。默认值为true。 |
| `net.Iris.UseFrequencyBasedPolling` | `true` | 是否使用基于频率的轮询。默认值为true。 |
| `net.Iris.UseIrisReplication` | `1` | 启用Iris复制系统。0将回退到旧版复制系统。 |
| `net.Iris.UseNativeFastArray` | `true` | 启用或禁用IrisNativeFastArray。 |
| `net.Iris.UsePrevReceivedStateForOnReps` | `false` | 如果设置为true，OnReps将在执行onrep时使用先前收到的状态，且不进行任何比较，如果设置为false，将复制本地状态并在发出onrep之前进行比较 |
| `net.Iris.UseResolvingHandleCache` | `true` | 在解析未解析的缓存时启用冷热缓存的使用，以减少解析引用所花的时间。 |
| `net.Iris.UseSupportsStructNetSerializerList` | `true` | 启用后，SupportsStructNetSerializerList中的结构体不会发出警告，即使结构体有NetSerialize/NetDeltaSerialize但没有自定义NetSerializer。 |
| `net.Iris.WarnAboutDroppedAttachmentsToObjectsNotInScope` | `false` | 当由于对象不在范围内而丢弃附件时，将发出警告。默认值为false。 |
| `net.Iris.WarnAboutStructsWithCustomSerialization` | `true` | 在为自定义序列化的结构体生成描述符时，将发出警告。 |
| `Net.IsPushModelEnabled` | `true` | 是否启用推送模型。此网络模式允许游戏代码通知网络系统的更改，而不是抓取。 |
| `Net.LogPendingGuidsOnShutdown` | `false` |  |
| `Net.LogSkippedRepNotifies` | `0` | 当网络代码由于属性值不变而跳过调用repnotify客户端时，将记录日志。 |
| `net.LogUnhandledFaults` | `1` | 是否警告未处理的网络故障（可能是有意的，取决于实现）。0=关闭，1=记录一次，2=始终记录。 |
| `net.MagicHeader` |  | 表示二进制位的字符串，它被附加到游戏发送的每个数据包中。最大长度：32位。 |
| `Net.MakeBpPropertiesPushModel` | `true` | 是否强制蓝图中声明的属性使用推送模型 |
| `net.MaxAggregateIPLogs` | `16` | 在完全禁用聚合的预连接日志记录之前，在这些日记记录中包含的IP数上限（最小值：1，最大值：128）。 |
| `net.MaxChannelSize` | `0` | 整个服务器允许的网络通道数上限，如果<=0，将使用连接DefaultMaxChannelSize。 |
| `net.MaxClientGuidRemaps` | `100` | 每次更新时未映射网络guid的最大客户端解析 |
| `net.MaxConnectionsToTickPerServerFrame` | `0` | 如果非零，每次服务器更新将复制到它们的已更改的通道数上限 |
| `net.MaxConstructedPartialBunchSizeBytes` | `65536` | 部分束允许的最大大小。 |
| `net.MaxIPHitLogs` | `4` | 在聚合其他日志之前，单独记录特定IP预连接的次数上限。 |
| `net.MaxNetStringSize` | `16777216` | 网络代码允许发送/接收的字符串大小上限（以字节为单位）。 |
| `net.MaxNumberOfAllowedTArrayChangesPerUpdate` | `2048` |  |
| `net.MaxNumberOfAllowedTArrayDeletionsPerUpdate` | `2048` |  |
| `net.MaxPlayersOverride` | `0` | 如果大于0，将重载标准的最大玩家人数。适用于测试完整服务器。 |
| `net.MaxRPCPerNetUpdate` | `2` | 每次网络更新时允许的不可靠组播RPC调用的数量上限，将丢弃其他调用 |
| `net.MaxSerializedNetExportGroups` | `65536` | 预计在束中收到的网络导出组的数量上限 |
| `net.MaxSerializedNetExportsPerGroup` | `131072` | 预计在束中收到的每组网络导出的数量上限 |
| `net.MaxSerializedNetGuids` | `2048` | 预计在束中收到的网络guid的数量上限 |
| `net.MaxSerializedReplayNetGuids` | `32768` | 预计在重播导出数据中收到的网络guid的数量上限。 |
| `net.MaxSimultaneousObjectsWithRPCs` | `4096` | 可以同时拥有未发送RPC的对象的数量上限。 |
| `net.MinHandshakeVersion` | `3` | 支持的最低无状态握手协议版本（数字）。 |
| `net.Montage.Debug` | `0` | 打印有关AnimMontages的复制信息 0：不打印。 1：当播放nimMontage时在客户端打印它们的信息。 |
| `net.NetFaultRecoveryLogQuotaChecks` | `0` | 是否启用配额检查的调试日志记录（适用于与'RegisterCounterCategory’一起调试新的新网络故障） |
| `Net.NetGuidCacheHistoryEnabled` | `0` | 启用后，允许记录NetGUIDCache历史记录。警告，这可能会消耗大量内存，同时在缓存销毁之前不会释放自己。 |
| `net.NetPingDebugDump` | `0` | 是否每5秒转储要记录的NetPing ping值。 |
| `net.NetPingEnabled` | `0` | 是否启用NetPing ping处理接口。用于集中式追踪ping，以及ICMP/UDP ping。(有效值：0=关闭，1=为客户端启用，2=为服务器和客户端启用，3=仅为服务器启用） |
| `net.NetPingICMPInterval` | `5` | 指定执行ICMP ping的时间间隔（以秒为单位）。 |
| `net.NetPingTimeoutDisableThreshold` | `15` | 在100%的失败率或超时率下，在放弃和禁用ping之前发送ICMP/UDP ping的次数。 |
| `net.NetPingTypes` |  | 将启用的以逗号分隔的EPingType ping列表，以及将应用于ping的EPingAverageType平均值（可选），例如：`RoundTrip=None \\\| RoundTripExclFrame=PlayerStateAvg \\\| ICMP=MovingAverage`")." |
| `net.NetPingUDPInterval` | `5` | 指定执行UDP ping的时间间隔（以秒为单位）。 |
| `net.NetPingUDPPort` | `22222` | 对于'UDPQoS' ping类型，设置用于执行ping的端口。 |
| `net.NetServerMoveTimestampExpiredWarningThreshold` | `1` | 当客户端移动过期时间超过服务器背后的此时间阈值时，允许ServerMove()发出警告。 |
| `net.OodleClientEnableMode` |  | 是否在客户端启用压缩（重载'ClientEnableMode' .ini设置）。 |
| `net.OodleMinSizeForCompression` | `0` | 要考虑对传出数据包进行压缩，传出数据包必须达到的最小大小（不计算在Oodle之后处理数据包的处理程序组件的开销）。 |
| `net.OodleNetwork.TimeGuardLimit` | `20` | 设置OodleNetworkHandlerComponent timeguard日志的数量上限。 |
| `net.OodleNetwork.TimeGuardThresholdMS` | `0` | OodleNetworkHandlerComponent timeguard的阈值，以毫秒为单位。 |
| `net.OodleServerEnableMode` |  | 何时在客户端启用压缩（重载'ServerEnableMode' .ini设置）。 |
| `net.OptimizedRemapping` | `1` | 使用优化路径重新映射未映射的网络guid |
| `net.PackageMap.DebugAll` | `0` | 调试所有对象的PackageMap序列化 |
| `net.PackageMap.DebugObject` |  | 调试要调试的对象的objectPartial名称的PackageMap序列化 |
| `net.PackageMap.LongLoadThreshhold` | `0.02` | 对象序列化中打印长加载警告的阈值时间，以秒为单位 |
| `net.PacketHandlerCRCDump` | `0` | 启用或禁用每个HandlerComponent（传入和传出）的数据包CRC转储，用于调试。 |
| `net.PacketHandlerTimeguardLimit` | `20` | 设置HandlerComponent timeguard日志的数量上限。 |
| `net.PacketHandlerTimeguardThresholdMS` | `0` | HandlerComponent timeguard（传入和传出）的阈值，以毫秒为单位。 |
| `net.PacketOrderCorrectionEnableThreshold` | `1` | 在启用校正之前需要出现的'乱序'数据包序列的数量。 |
| `net.PacketOrderMaxCachedPackets` | `32` | （注意：必须是2的幂！）在将缺失的数据包视为丢失之前，在等待缺失的数据包序列时要缓存的数据包数量上限。 |
| `net.PacketOrderMaxMissingPackets` | `3` | 在将缺失的数据包视为丢失之前，允许缺失的数据包序列的数量上限。 |
| `net.PartialBunchReliableThreshold` | `8` | 如果束被分解成此数量的部分束，即使原始束不可靠，也会将其发送为可靠。部分束是原子的，必须全部转让才能使用 |
| `net.PingDisplayServerTime` | `0` | 显示服务器帧时间。在发布构建中不可用。 |
| `net.PingExcludeFrameTime` | `0` | 如果为true，游戏帧时间将从计算的ping中扣减，以近似实际网络ping |
| `net.PingUsePacketRecvTime` | `0` | 使用操作系统或接收线程数据包接收时间，用于计算ping。不包括帧时间。 |
| `net.ProcessQueuedBunchesMillisecondLimit` | `30` | 用于处理排队束的时间阈值。如果在单个帧中花费的时间超过此时间，则等到下一帧继续处理排队束。对于无限时间，设置为0。 |
| `Net.ProfilerUseComparisonTracking` | `false` |  |
| `net.PushModelSkipUndirtiedFastArrays` | `false` | 当为true时，若可以稳定地看到的跳过对象不脏时，将包含快速数组。 |
| `net.PushModelSkipUndirtiedReplication` | `false` | 当为true时，跳过复制任何可以稳定地看到不脏的对象。 |
| `net.PushModelValidateProperties` | `false` | 当为true时，将比较所有推送模型属性，如果它们没有被正确标记为脏，将发出警告。 |
| `net.PushModelValidateSkipUpdate` | `false` | 启用后，当我们认为可以基于推送模型状态跳过对象复制但我们还是发送了数据时，将进行检测。 |
| `net.QuantizeActorLocationOnSpawn` | `true` | 启用后，将新生成的Actor的位置量化为单个小数精度。 |
| `net.QuantizeActorRotationOnSpawn` | `true` | 启用后，将新生成的Actor的旋转量化为单个小数精度。 |
| `net.QuantizeActorScaleOnSpawn` | `false` | 启用后，将新生成的Actor的缩放量化为单个小数精度。 |
| `net.QuantizeActorVelocityOnSpawn` | `true` | 启用后，将新生成的Actor的速度量化为单个小数精度。 |
| `net.QueuedBunchTimeFailsafeSeconds` | `2` | 在强制处理所有排队束之前，排队束的等待时间，以秒为单位，同时忽略NetDriver的HasExceededIncomingBunchFrameProcessingTime。 |
| `net.QueuedBunchTimeoutSeconds` | `30` | 在记录警告之前，要刷新的通道上的排队束的等待时间，以秒为单位。 |
| `net.RandomizeSequence` | `1` | 随机化初始数据包序列，可以提供一些混淆 |
| `net.RcvThreadShouldSleepForLongRecvErrors` | `0` | 接收线程是否应为预计会持续很长时间的RecvFrom错误而休眠。0=不休眠，1=休眠，2=退出接收线程。 |
| `net.RcvThreadSleepTimeForWaitableErrorsInSeconds` | `0` | 当套接字操作返回可等待错误时，接收线程将休眠的时间。 |
| `net.RecreateSocketCooldown` | `10` | 套接字重建尝试之间的最小时间，以秒为单位。 |
| `net.RecreateSocketTimeoutThreshold` | `0` | 在触发套接字重建之前，没有收到数据包或没有发送确认的时间，以秒为单位。（0.0=关闭） |
| `net.RecvMultiCapacity` | `2048` | 当启用RecvMulti时，它是分配给每个调用处理的数据包数量——越大越好（特别是在DDoS下），但要注意内存开销。 |
| `net.Reliable.Debug` | `0` | 打印通过网络发送的所有可靠束 0：不打印。 1：当束发送时打印束。 2：每次网络更新打印可靠的束缓冲 |
| `net.ReliableRPCQueueSize` | `4096` | 每个对象排队的可靠RPC的数量上限。它是在发送窗口中的256个之外。它用于支持非常大的RPC，这些RPC被拆分为更小的部分。 |
| `net.RelinkMappedReferences` | `1` |  |
| `net.RemapStableSubobjects` | `true` | 启用后，当也启用了net.OptimizedRemapping时，尝试重新映射稳定子对象。 |
| `Net.RepDriver.Enable` | `1` | 启用复制驱动程序。0将回退到旧版NetDriver实现。 |
| `Net.RepGraph.ForceConnectionViewerPriority` | `1` | 强制连接的玩家控制器和查看Pawn作为最高优先级。与Net.ForceConnectionViewerPriority相同。 |
| `net.ReplicateCustomDeltaPropertiesInRepIndexOrder` | `false` | 如果为false（默认），自定义增量属性将按照在调用GetLifetimeReplicatedProps期间添加到生命周期属性数组的顺序进行复制。如果为true，自定义增量属性将按照属性RepIndex的顺序进行复制，该顺序通常按递增的属性偏移顺序排列。注意，自定义增量属性始终在常规属性之后序列化。 |
| `net.ReplicateOnlyBeginPlay` | `false` | 仅允许对调用BeginPlay的Actor进行属性复制。 |
| `net.Replication.DebugProperty` |  | 按名称调试属性的复制，它应设置为要调试的属性的部分名称 |
| `Net.RepMovement.DrawDebug` | `0` |  |
| `net.ReportGameTickFlushTime` | `false` | 记录GameNetDriver的TickFlush的处理时间，并向性能追踪系统报告。 |
| `net.ReportSyncLoads` | `false` | 启用后，引擎将追踪网络系统加载的对象，并广播FNetDelegates::OnSyncLoadDetected以对它们进行报告。默认情况下，它们将被记录到LogNetSyncLoads类别。 |
| `net.RequiredEncryptionNetDriverDefNames` | `all` | 以逗号分隔的NetDriverDefinition列表，其中当'net.AllowEncryption'为2时，'IsEncryptionRequired'将返回true。（指定'all'将为所有NetDriverDefinition启用它） |
| `net.ReservedNetGuidSize` | `512` | 为NetGUID序列化保留的大小，用作以后序列化的占位符，以字节为单位 |
| `net.ResetAckStatePostSeamlessTravel` | `0` | 如果为1，服务器将在无缝漫游后重置数据包映射的确认状态。增加带宽使用，但可以解决一些GUID在无缝漫游后在客户端不可用的问题。 |
| `Net.ReuseReplicatorsForDormantObjects` | `false` | 当为true时，服务器将持续存在并尝试为休眠Actor和对象重用复制器。这可以防止在从休眠状态唤醒对象时发送冗余信息，从而减少带宽。 |
| `net.RPC.Debug` | `0` | 打印通过网络发送的所有RPC束 0：不打印。 1：当束发送时打印束。 |
| `net.RPCDoSAnalyticsMaxRPCs` | `20` | 在RPC DoS分析中包括的RPC的前'x'个数，按每秒RPC速率排序。 |
| `net.RPCDoSDetectionOverride` |  | 重载是否每个NetDriver启用RPC DoS检测。0=禁用，1=启用。示例：net.RPCDoSDetectionOverride=GameNetDriver=1,BeaconNetDriver=0 |
| `net.RPCDoSForcedRPCTracking` |  | 设置单个RPC，当遇到该RPC时，强制启用RPC跟踪（限制为一个RPC以保证性能）。还可以指定一个介于0.0和1.0之间的随机几率，用于当遇到RPC时启用追踪，以及启用追踪的时间长度（否则禁用下一个刷新）。示例（50%的几率，持续10秒）：net.RPCDoSForcedRPCTracking=ServerAdmin,0.5,10 |
| `net.RPCDoSScopeDebugging` | `0` | 设置是否调试/确保应为RPC DoS Tick/Packet范围启用。 |
| `net.SerializeNewActorOverrideLevel` | `1` | 如果为true，服务器将序列化一个生成的、复制Actor的关卡，以便客户端也尝试将其生成到该关卡。如果为false，客户端会将所有这些Actor生成到持久关卡。 |
| `net.ShareInitialCompareState` | `0` | 如果为true且已启用net.ShareShadowState，还尝试跨连接共享初始复制比较。 |
| `net.ShareSerializedData` | `1` | 如果为true，将启用复制使用的共享序列化系统，以在多个客户端需要相同数据时减少CPU使用 |
| `net.ShareShadowState` | `1` | 如果为true，将跨网络共享为比较属性所做的工作 |
| `net.SkipDestroyNetStartupActorsOnChannelCloseDueToLevelUnloaded` | `true` | 收到通道关闭和ECloseReason::LevelUnloaded时，控制是否销毁与通道关联的NetStartUpActor的Actor。 |
| `net.SkipReplicatorForDestructionInfos` | `1` | 启用后，当我们知道没有内容负载且将立即销毁Actor时，将跳过在SetChannelActor中创建对象复制器。 |
| `net.SubObjects.CompareWithLegacy` | `false` | 打开后，将收集由ReplicateSubObjects方法复制的子对象，并将它们与通过Actor的注册列表复制的子对象进行比较。如果检测到差异，将触发ensure。 |
| `net.SubObjects.DefaultUseSubObjectReplicationList` | `true` | 默认情况下，Actor和Actor组件是否使用注册方法复制子对象。 |
| `net.SubObjects.DetectDeprecatedReplicatedSubObjects` | `false` | 打开后，如果检测到仍在使用新SubObject列表的类中实现ReplicateSubObjects()函数，将触发一个ensure。 |
| `net.SubObjects.LogAllComparisonErrors` | `0` | 启用后，将记录CompareWithLegacy作弊检测到的所有错误。否则，将仅记录触发第一个ensure。 |
| `net.SupportFastArrayDelta` | `1` | 是否启用快速数组结构体增量序列化。 |
| `net.TickAllOpenChannels` | `0` | 如果非零，每个网络连接将在每次刷新时刷新其所有打开的通道。关闭该设置将提高性能。 |
| `net.TrackAsyncLoadingGUIDThreshold` | `0` | 当>0时，将追踪任何花费时间超过异步加载阈值的对象。阈值，以秒为单位，@see FNetGUIDCache::ConsumeDelinquencyAnalytics。用于调试和分析 |
| `net.TrackAsyncLoadingGUIDThresholdOwner` | `0` | 当>0时，如果网络连接的所属控制器或Pawn等待异步加载的时间超过此阈值，将触发一个CSV事件以对它进行追踪。用于调试和分析 |
| `net.TrackDormantObjectsByLevel` | `false` | 当为true时，网络对象列表将为每个关卡的每个连接维护一组休眠Actor。 |
| `net.TrackFlushedDormantObjects` | `1` | 启用后，在休眠状态刷新时追踪休眠子对象，因此如果在下一个ReplicateActor之前销毁它们，可以正确删除它们。 |
| `net.TrackNetSerializeObjectReferences` | `false` | 如果为true，如果网络序列化结构体具有对象属性，将为它们创建小布局。这可以防止一些影子状态垃圾回收崩溃。 |
| `net.TrackQueuedActorThreshold` | `0` | 当>0时，将追踪任何花费时间超过排队束阈值的对象。阈值，以秒为单位，@see UPackageMap::ConsumeDelinquencyAnalytics。用于调试和分析 |
| `net.TrackQueuedActorThresholdOwner` | `0` | 当>0时，如果网络连接的所属控制器或Pawn的排队束的时间超过此阈值，将触发一个CSV事件以对它进行追踪。用于调试和分析 |
| `net.UnreliableRPCQueueSize` | `10` | 每个对象排队的不可靠RPC的数量上限。如果有更多的RPC排队，则将丢弃旧的RPC。 |
| `net.UseAdaptiveNetUpdateFrequency` | `0` | 如果为1，将根据Actor在复制时实际发送内容的频率计算NetUpdateFrequency |
| `Net.UseGranularNetworkTracking` | `0` | 启用后，Obj List将打印有关网络内存使用的非常详细的信息 |
| `Net.UsePackedShadowBuffers` | `1` | 启用后，FRepLayout将生成仅包含必要NetProperties的阴影缓冲区，而不是复制整个对象状态。 |
| `net.UseRecvMulti` | `0` | 如果为true且在Unix/Linux平台上运行，将使用一个syscall将从套接字检索多个数据包，从而提高性能，同时允许检索时间戳信息。 |
| `net.UseRecvTimestamps` | `0` | 如果为true且net.UseRecvMulti也为true，在Unix/Linux平台上，将为收到的每个数据包检索内核时间戳，从而提供更准确的ping计算。 |
| `net.ValidateReplicatedPropertyRegistration` | `1` | 如果复制属性没有在GetLifetimeReplicatedProps中注册，将发出警告。 |
| `net.VerifyMagicHeader` | `0` | 在处理数据包之前，是否执行魔术头文件的验证。如果过渡到一个新的魔术头文件而希望继续支持旧的头文件一段时间，将禁用。 |
| `net.VerifyNetClientID` | `1` | 是否执行数据包ClientID值的验证。 |
| `net.VerifyNetSessionID` | `1` | 是否执行数据包SessionID值的验证。 |
| `net.VerifyShareSerializedData` | `0` | 调试用于在复制期间验证共享序列化数据的选项 |
| `net.WithArrayOnRepFix` | `false` | 如果为true，如果数组原型的值与关卡中的实例的值不同，将尝试防止数组在其大小更改之前未接收OnRep调用的问题。 |
| `NetAnalytics.MinimumNumberOfPacketsForBurstTracking` | `5` | 要考虑一个帧的数据包丢失百分比而必须通知的数据包数下限（在输出中）。请参见NetAnalytics.PercentOfDroppedPacketsToConsiderBurst |
| `NetAnalytics.NumberOfConsecutiveDroppedPacketsToConsiderBurst` | `3` | 连续丢失的数据包数量（输入或输出），将该帧视为具有数据包丢失突发。不受NetAnalytics.MinimumNumberOfPacketsForBurstTracking影响。 |
| `NetAnalytics.PercentOfDroppedPacketsToConsiderBurst` | `0.2` | 在一个帧中丢失的数据包百分比（输入或输出），将该帧视为具有数据包丢失突发。 请参见NetAnalytics.MinimumNumberOfPacketsForBurstTracking。 |
| `networkversionoverride` | `0` | 设置用于多人游戏的网络版本 |

## Niagara

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `niagara.AllowAllNiagaraNodesInEmitterGraphs` | `1` | 如果为true，Niagara发射器图表中允许所有节点。 |
| `niagara.CreateShadersOnLoad` | `0` | 是否在加载时创建Niagara的模拟着色器，这可以减少卡顿，但使用更多内存。 否则将根据需要创建着色器。 |
| `Niagara.EmitterStatsFormat` | `1` | 0表示粒子计数、ms、mb和状态。1表示粒子计数。 |
| `Niagara.GPUCountBufferSlack` | `1.5` | GPU计数缓冲区大小的乘数，以防止频繁的重新分配。 |
| `Niagara.GPUCountManager.AllocateIncrement` | `64` | 如果耗尽了分配空间，这将是分配的数量，而不是单个条目。（默认值=64） |
| `Niagara.GPUCulling` | `1` | 是否在GPU上视锥体和摄像机距离剔除粒子 |
| `Niagara.GPUCulling.CPUToGPUThreshold` | `0` | 粒子计数从CPU排序移动到GPU剔除。-1，禁用。（默认值=0） |
| `Niagara.GPUSorting.CPUToGPUThreshold` | `-1` | 粒子计数从CPU排序移动到GPU排序。-1，禁用。（默认值=-1） |
| `Niagara.MinCulledGPUInstanceCount` | `2048` | 在全局缓冲区中分配的剔除（每个视图）实例计数条目的数量下限。（默认值=2048） |
| `Niagara.MinGPUInstanceCount` | `2048` | 在全局缓冲区中分配的实例计数条目的数量下限。（默认值=2048） |
| `Niagara.RadixSortThreshold` | `400` | 使用基数排序而不是内省排序的实例计数。 设置为-1，将从不使用基数排序。（默认值=400） |
| `Niagara.Ribbon.GpuAllocateMaxCount` | `1` | 启用（默认）后，将分配所需元素的数量上限。如果计数变化很大，这可能会导致内存膨胀，但性能会更稳定 |
| `Niagara.Ribbon.GpuBufferAlign` | `512` | 当未分配所需元素的数量上限时，将请求元素对齐到此大小，以提高缓冲区的重复使用。 |
| `Niagara.Ribbon.GpuBufferCachePurgeCounter` | `0` | 保留到条带缓冲区的帧数。当为0（默认）时，如果下一帧不使用，将清除它们。负值将清除同一帧的缓冲区，基本上零重复使用。 |
| `Niagara.Ribbon.GpuEnabled` | `1` | 启用任何与GPU条带相关的代码（包括GPU初始化）。 |
| `Niagara.Ribbon.GpuInitMode` | `0` | 修改使用的GPU初始化模式，即将CPU计算分担给GPU。 0=遵循属性中的bUseGPUInit（默认） 1=强制启用 2=强制禁用 |
| `Niagara.Ribbon.MinSegmentLength` | `1` | niagara条带最小长度。（默认值=1） |
| `Niagara.Ribbon.ShareGeneratedData` | `true` | 允许条带尽可能共享生成数据。 |
| `Niagara.Ribbon.Tessellation.Enabled` | `1` | 确定是否允许在此平台上进行曲面细分。 |
| `Niagara.Ribbon.Tessellation.MaxErrorScreenPercentage` | `0.002` | 用于计算曲面细分系数的屏幕百分比。 值越小，产生的曲面细分越多，直到最大曲面细分。（默认值=0.002） |
| `Niagara.Ribbon.Tessellation.MaxInterp` | `16` | 当TessellationAngle为>0时，这是最大曲面细分因子。 值越大，曲面细分的划分更均匀。 当TessellationAngle为0时，这是实际曲面细分因子（默认值=16）。 |
| `Niagara.Ribbon.Tessellation.MinAbsoluteError` | `0.5` | 曲面细分时的最小绝对世界尺寸错误。 当距离变得非常小时，防止过度曲面细分。（默认值=0.5） |
| `Niagara.Ribbon.Tessellation.MinAngle` | `0.261799` | 用于以弧度曲面细分的条带片段角度。（默认值=15度） |
| `niagara.ShowShaderCompilerWarnings` | `0` | 当设置为1时，将显示来自Niagara着色器编译的所有警告。 |
| `Niagara.StaticSwitch.EnableAutoRefreshOldStaticSwitches` | `false` | 在后期加载时为旧的静态开关节点启用自动刷新，并更新到枚举资产。启用该设置并烘焙资产，以检查过时枚举上有多少节点执行操作 |
| `Niagara.WaveIntrinsics` | `0` |  |

## 网络物理

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `np2.EnableDebugRPC` | `1` | （5.4已废弃，仅部分旧版物理帧偏移逻辑）向客户端发送有关服务器端输入缓冲的额外调试信息 |
| `np2.EnableDefaultReplication` | `0` | 在网络物理预测流中启用默认复制。 |
| `np2.NetworkPhysicsPredictionFrameOffset` | `4` | （5.4已弃用，改用np2.PredictionAsyncFrameBuffer）将被添加到网络预测使用的本地到服务器的额外帧偏移 |
| `np2.NumRedundantCmds` | `3` | （5.4已弃用，仅部分旧版物理帧偏移逻辑）每帧发送的冗余用户cmd的数量 |
| `np2.PredictionAsyncFrameBuffer` | `3` | 将被添加到网络预测使用的本地到服务器的额外帧偏移 |
| `np2.PredictiveInterpolation.AlwaysHardSnap` | `false` | 当为true时，预测插值复制模式将始终硬对齐。用作备用措施 |
| `np2.PredictiveInterpolation.AverageReceiveIntervalSmoothing` | `3` | 推荐范围：1.0-5.0。值越高，平均接收间隔调整本身将越慢，将降低InterpolationTime峰值。 |
| `np2.PredictiveInterpolation.DisableErrorVelocityLimits` | `false` | 禁用速度限制并允许以任何速度累积错误。 |
| `np2.PredictiveInterpolation.DisableSoftSnap` | `false` | 当为true时，当速度失败时，预测插值将不会使用软对齐来纠正复制。如果复制不能到达目标，硬对齐最终仍将生效。 |
| `np2.PredictiveInterpolation.DontClearTarget` | `false` | 当为true时，预测插值在停止后不会丢失对最后一次复制状态的追踪。 |
| `np2.PredictiveInterpolation.DrawDebugTargets` | `false` | 绘制目标状态，根据它们来自的ServerFrame进行颜色编码，复制目标很大，但外推目标很小。绘制调用有一个Z偏移。 |
| `np2.PredictiveInterpolation.DrawDebugVectors` | `false` | 绘制复制向量、目标速度、复制速度和复制调用之间的速度变化等。 |
| `np2.PredictiveInterpolation.EarlyOutAngle` | `1.5` | 如果对象在源目标的此旋转角度（以度为单位）范围内，将提前退出复制，并在复制时应用休眠。 |
| `np2.PredictiveInterpolation.EarlyOutDistanceSqr` | `1` | 平方值。如果对象在源目标的此距离内，将提前退出复制，并在复制时应用休眠。 |
| `np2.PredictiveInterpolation.EarlyOutWithVelocity` | `true` | 如果为true，如果当前速度能够很好地驱动复制，将允许复制逻辑提前退出。如果为false，仅在目标速度为零时才提前退出。 |
| `np2.PredictiveInterpolation.ErrorAccAngVelMaxLimit` | `1.5` | 如果目标角速度（以度为单位）低于此限制，将检查是否取消同步，以触发软对齐和累积时间，从而建立硬对齐。 |
| `np2.PredictiveInterpolation.ErrorAccLinVelMaxLimit` | `50` | 如果目标速度低于此限制，将检查是否取消同步，以触发软对齐和累积时间，从而建立硬对齐。 |
| `np2.PredictiveInterpolation.ErrorAccumulationDecreaseMultiplier` | `0.5` | 不再累积错误时，用于调整减少累积错误时间的速度的乘数。 |
| `np2.PredictiveInterpolation.ErrorAccumulationSeconds` | `3` | 如果复制无法在此时间内重载到目标的最小预期距离，将执行重新定位。 |
| `np2.PredictiveInterpolation.ExtrapolationMinTime` | `0.75` | 限制最小外推时间。值以秒为单位。通过设置为0，禁用最小限制。 |
| `np2.PredictiveInterpolation.ExtrapolationTimeMultiplier` | `3` | 用于调整执行外推目标的时间的乘数，该时间基于当前发送速率。 |
| `np2.PredictiveInterpolation.FakeTargetOnClientWakeUp` | `false` | 当为true时，预测插值将在标记为休眠的当前变换中伪造复制目标，此目标仅适用于当客户端未收到来自服务器的目标时。如果客户端被错误唤醒，这将阻止客户端与服务器的取消同步 |
| `np2.PredictiveInterpolation.InterpolationTimeMultiplier` | `1.1` | 用于调整复制插值时间的乘数，该时间基于来自服务器的复制数据的发送速率。 |
| `np2.PredictiveInterpolation.MinExpectedDistanceCovered` | `0.5` | 值介于0-1之间，以百分比表示，0.25=25%。对象在模拟刷新中基于复制速度应涵盖多少预计距离才会不被视为卡住。 |
| `np2.PredictiveInterpolation.PosCorrectionAsVelocity` | `false` | 当为true时，预测插值将应用位置偏移校正作为速度，而不是作为每次刷新的位置变化。 |
| `np2.PredictiveInterpolation.PosCorrectionTimeBase` | `0` | 校正位置偏移的基准时间。在此之上添加RTT x PosCorrectionTimeMultiplier。 |
| `np2.PredictiveInterpolation.PosCorrectionTimeMin` | `0.1` | 校正位置偏移的最小时间。在此之上添加DeltaSeconds。 |
| `np2.PredictiveInterpolation.PosCorrectionTimeMultiplier` | `1` | 用于调整将多少RTT（网络往返时间）添加到位置偏移校正的乘数。 |
| `np2.PredictiveInterpolation.PostResimWaitForUpdate` | `false` | 在重新模拟之后，等待与后期重新模拟状态对应的复制状态，然后再处理复制。 |
| `np2.PredictiveInterpolation.RotCorrectionTimeBase` | `0` | 校正位置偏移的基准时间。在此之上添加RTT x PosCorrectionTimeMultiplier。 |
| `np2.PredictiveInterpolation.RotCorrectionTimeMin` | `0.1` | 校正旋转偏移的最小时间。在此之上添加DeltaSeconds。 |
| `np2.PredictiveInterpolation.RotCorrectionTimeMultiplier` | `1` | 用于调整将多少RTT（网络往返时间）添加到位置偏移校正的乘数。 |
| `np2.PredictiveInterpolation.RotInterpolationTimeMultiplier` | `1.25` | 用于调整旋转复制插值时间的乘数，该时间基于来自服务器的复制数据的发送速率。 |
| `np2.PredictiveInterpolation.SkipReplication` | `false` | 当为true时，将不再应用预测插值，而是让对象自由模拟 |
| `np2.PredictiveInterpolation.SkipVelocityRepOnPosEarlyOut` | `true` | 如果为true，而且位置可以提前退出但角度不能提前退出，不要运行线性速度复制。 |
| `np2.PredictiveInterpolation.SleepSecondsClearTarget` | `15` | 在清除复制目标之前，等待对象休眠此秒数，以确保在对象在客户端进入休眠状态后没有任何项目唤醒它。 |
| `np2.PredictiveInterpolation.SoftSnapPosStrength` | `0.5` | 0.0-1.0之间的百分比值表示每次刷新时剩余距离的软对齐程度。 |
| `np2.PredictiveInterpolation.SoftSnapRotStrength` | `0.5` | 0.0-1.0之间的百分比值表示每次刷新时剩余距离的软对齐程度。 |
| `np2.PredictiveInterpolation.SoftSnapToSource` | `false` | 如果为true，将对当前目标的源状态执行软对齐，而不是对当前目标的预测状态。 |
| `np2.PredictiveInterpolation.TargetTickAlignmentClampMultiplier` | `1` | 用于通过TickCount调整目标对齐的限制的乘数。在AverageReceiveInterval上执行乘数。 |
| `np2.PredictiveInterpolation.VelocityBased` | `true` | 当为true时，预测插值复制模式将仅应用线性速度和角速度 |
| `np2.ReplicationCache.LingerForNSeconds` | `3` | 在没有Actor访问的情况下，在复制缓存中保留数据多长时间，在此之后将停止缓存Actor状态，直到它再次尝试访问。 |
| `np2.Resim.AllowRewindToClosestState` | `true` | 当倒回到特定帧时，如果客户端没有该帧的状态数据，使用最接近的可用数据。当FPBDRigidsEvolution设置为重置（Reset）时，仅影响第一个倒回帧。 |
| `np2.Resim.AngVelStabilityMultiplier` | `0.5` | 推荐范围为0.0-1.0。值越小，角速度校正越稳定。 |
| `np2.Resim.ApplyTargetsWhileResimulating` | `false` | 如果为false，来自服务器的目标状态将仅适用于倒回。如果为true，将在重新模拟期间应用来自服务器的目标状态（如果可用）。 |
| `np2.Resim.CompareInputToTriggerRewind` | `false` | 如果应将本地玩家预计输入与传入服务器输入进行比较，以在它们不同时触发重新模拟，则通过FNetworkPhysicsData::CompareData进行比较。 |
| `np2.Resim.CompareStateToTriggerRewind` | `false` | 如果应在倒回历史记录中缓存本地玩家自定义状态结构体，并将预计状态与传入服务器状态进行比较，以在它们不同时触发模拟，则通过FNetworkPhysicsData::CompareData进行比较。 |
| `np2.Resim.DisableReplicationOnInteraction` | `true` | 如果重新模拟对象与未运行重新模拟的另一个对象交互，将停用该对象的复制，直到交互停止。 |
| `np2.Resim.DrawDebug` | `false` | 重新模拟调试绘制调用 |
| `np2.Resim.PosStabilityMultiplier` | `0.5` | 推荐范围为0.0-1.0。值越小，位置校正越稳定。 |
| `np2.Resim.RotStabilityMultiplier` | `1` | 推荐范围为0.0-1.0。值越小，旋转校正越稳定。 |
| `np2.Resim.RuntimeCorrectConnectedBodies` | `true` | 如果为true，运行时位置和旋转校正也将对任何连接的物理对象进行移位变换。当RuntimeCorrectionEnabled为true时使用。 |
| `np2.Resim.RuntimeCorrectionEnabled` | `true` | 当错误很小，不足以触发重新模拟时，应用运行时校正。 |
| `np2.Resim.RuntimeVelocityCorrection` | `false` | 当在重新模拟触发器内运行时应用线性速度校正和角速度校正。当RuntimeCorrectionEnabled为true时使用。 |
| `np2.Resim.SimProxyRepMode` | `-1` | 所有具有以下特点的Actor将改变它们的物理复制模式：具有NetworkPhysicsSettingsComponent，正在运行重新模拟，且为ROLE_SimulatedProxy。-1=禁用，0=默认，1=预测插值，2=重新模拟 |
| `np2.Resim.VelStabilityMultiplier` | `0.5` | 推荐范围为0.0-1.0。值越低，线性速度校正越稳定。 |
| `np2.TickOffsetCorrectionLimit` | `10` | 如果客户端与物理刷新的不同步超过此限制，则降低损失并重置偏移。 |
| `np2.TickOffsetUpdateInterval` | `10` | 在每次刷新偏移更新之间需要等待多少次物理刷新。最低可行值=1，即每次刷新更新一次。设置为0或负值可禁用物理偏移更新。 |
| `np2.TimeDilationAmount` | `0.01` | 服务器端控制台变量，设置为0可禁用时间膨胀。值以百分比表示，0.01=1%膨胀。示例：1.0/0.01=100，即在一段时间内，通常需要刷新100个物理步骤，我们将刷新99或101个，这取决于是向上还是向下膨胀。 |
| `np2.TimeDilationEscalation` | `true` | 服务器端控制台变量，膨胀时间，更多地取决于需要调整的刷新数量。当设置为false时，使用设置的时间膨胀量并等待执行校正偏移所需的时间。当设置为true时，将时间膨胀量与缓冲区偏移相乘，这将在一个时间膨胀量周期内校正偏移。 |
| `np2.TimeDilationEscalationDecay` | `0.05` | 值为乘数，默认值：0.05。对于每个升级的时间膨胀量，也衰减同样的量。设置为0即禁用。 |
| `np2.TimeDilationEscalationDecayMax` | `0.5` | 值为乘数，默认值：0.5。升级时间膨胀的最大衰减值。值越低，衰减越高。 |
| `np2.TimeDilationMax` | `1.1` | 时间膨胀乘数的最大值。 |
| `np2.TimeDilationMin` | `0.9` | 时间膨胀乘数的最小值 |

## 对象工具

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `ObjectTools.MaxRecursionDepth` | `4` | 为找到要搜索的对象而要递归多少次 |
| `ObjectTools.MaxTimesToCheckSameObject` | `3` | 将属性链映射到对象时，在同一对象上递归的次数。 |

## OpenGL

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `OpenGL.UseEmulatedUBs` | `1` | 如果为true，启用在OpenGL Mobile模式下使用模拟的统一缓冲区。 |

## 在线子系统

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `OSS.DelayAsyncTaskOutQueue` | `0` | 最小总异步任务时间 时间以秒为单位 |
| `oss.PlatformOverride` |  | 重载该客户端的检测平台用于进行各种调试 有效值WIN MAC PSN XBL IOS和LIN SWT OTHER |
| `OSS.VoiceLoopback` | `0` | 启用语音回环 1，启用。0，禁用。 |
| `OSSNull.AddUserNumToNullId` | `false` | 如果登录名应包含本地用户号，将为True，这允许每个用户号使用不同的稳定Id |
| `OSSNull.AutoLoginAtStartup` | `true` | 如果应像单用户平台一样在启动时登录第一个用户，将为True；如果仅在请求时登录，将为false |
| `OSSNull.ForceOfflineMode` | `false` | 如果应使伪造的网络查询失效并且像离线系统一样，将为True |
| `OSSNull.ForceShowLoginUIUserChange` | `false` | 如果用户索引在登录UI期间应发生更改以模拟平台用户更改，将为True |
| `OSSNull.ForceStableNullId` | `false` | 如果应使用系统稳定的null Id登录，该Id与命令行上的-StableNullID相同，将为True |
| `OSSNull.OnlineRequiresSecondLogin` | `false` | 如果第一次登录仅被视为本地登录，需要第二次登录作为在线访问，将为True |
| `OSSNull.RequireLoginCredentials` | `false` | 如果登录需要用户/通道充当外部服务，将为True；如果要匹配大多数平台并使用默认值，将为false |
| `OSSNull.RequireShowLoginUI` | `false` | 如果登录需要在externalUI上调用ShowLoginUI，将为True，取决于SupportExternalUI |
| `OSSNull.SupportExternalUI` | `false` | 如果应支持外部UI接口，将为True |

## 输出日志

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `OutputLogModule.HideConsole` | `false` | 是否应隐藏调试控制台控件（默认为false） |

## 物理

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `p.AABBMaxChildrenInLeaf` | `500` |  |
| `p.AABBMaxTreeDepth` | `200` |  |
| `p.aabbtree.DirtyElementGridCellSize` | `1000` | DirtyElement网格加速结构单元尺寸，以厘米为单位。0或更小值将禁用该功能 |
| `p.aabbtree.DirtyElementMaxCellCapacity` | `32` | 在溢出到较慢的扁平列表之前，可以添加到单个网格单元的脏元素的数量上限 |
| `p.aabbtree.DirtyElementMaxGridCellQueryCount` | `340` | 在回退到暴力搜索，在DirtyElement网格加速结构中可以查询的最大网格单元数（例如每个光线投射） |
| `p.aabbtree.DirtyElementMaxPhysicalSizeInCells` | `16` | 如果脏元素跨越的单元数超过此数量，则不会将它添加到网格加速结构中 |
| `p.aabbtree.DynamicTreeBoundingBoxPadding` | `5` | 为动态AABB树添加到边界框以分摊更新开销的额外填充 |
| `p.aabbtree.DynamicTreeLeafCapacity` | `8` | 动态树叶容量 |
| `p.aabbtree.MaxProcessingTimePerSliceSeconds` | `0.001` | 如果我们想要按毫秒预算而不是按处理的节点或复制的数据大小对树生成进行时间切片，将设置为True |
| `p.aabbtree.MinDataChunkToProcessBetweenTimeChecks` | `500` | 在检查是否在预算范围内之前，要处理的最小数据元素数量 |
| `p.aabbtree.MinNodesChunkToProcessBetweenTimeChecks` | `250` | 在检查是否在预算范围内之前，要处理的最小节点数量 |
| `p.aabbtree.splitataveragecenter` | `1` | 在元素中心的平均值位置分割AABB树节点 |
| `p.aabbtree.splitonvarianceaxis` | `1` | 当元素中心方差最大时，沿轴线分割AABB树节点 |
| `p.aabbtree.updatedirtyelementpayloads` | `1` | 允许AABB树元素在收到负载更新时更新内部负载数据 |
| `p.aabbtree.UseTimeSliceMillisecondBudget` | `true` | 如果我们想要按毫秒预算而不是按处理的节点对树生成进行时间切片，将设置为True |
| `p.AddFormerBaseVelocityToRootMotionOverrideWhenFalling` | `true` | 当根运动源将Pawn从移动基座移动到自由落体时，为了避免速度突然发生变化，该控制台变量将在CharacterMovementComponent上启用FormerBaseVelocityDecayHalfLife属性。 |
| `p.AggregateGeom.ISPC` | `true` | 是否在物理聚合几何体计算中使用ISPC优化 |
| `p.AllowCachedOverlaps` | `1` | 图元组件物理 0：禁用缓存重叠，1：启用（默认） |
| `p.AllowDestroyNonNetworkActors` | `1` | 启用后，允许联网游戏中的客户端销毁非联网Actor（AActor::Role==ROLE_None）。不会改变服务器或独立游戏上的行为。 |
| `p.AllowKinematicKinematicConstraints` | `true` | 不要在两个刚性运动学之间创建约束。 |
| `p.AllowNotForDedServerPhysicsAssets` | `1` | 在PhysicsAssets上允许'Not For Dedicated Server'标记 0：忽略标记，1：遵从标记（默认） |
| `p.AlwaysCreatePhysicsStateConversionHack` | `0` | 破解方法，用于通过查询转换Actor，并忽略所有以始终创建物理。 |
| `p.AlwaysHardSnap` | `0` |  |
| `p.AlwaysResetPhysics` | `0` |  |
| `p.AngleLerp` | `-1` |  |
| `p.AngularEtherDragOverride` | `-1` | 设置重载角以太阻力值。-1.f，禁用 |
| `p.AngularVelocityCoefficient` | `-1` |  |
| `p.AnimDynamics` | `1` | 启用/禁用动画动态节点更新。 |
| `p.AnimDynamics.ComponentAppliedLinearAccClampOverride` | `-1` | 重载所有动画动态节点的ComponentAppliedLinearAccClamp的所有轴（X、Y和Z）的每个资源设置。将忽略负值。 |
| `p.animdynamics.debugbone` |  | 按名称将p.animdynamics.showdebug过滤到特定骨骼。 |
| `p.AnimDynamics.GravityScale` | `1` | 将所有动画动态节点上的默认重力和重力重载相乘。 |
| `p.animdynamics.showdebug` | `0` | 启用/禁用动画动态数据的绘制。 |
| `p.AnimDynamicsAdaptiveSubstep` | `0` | 启用/禁用自适应分步。自适应分步将在必要时分步模拟，并保留时间的债务缓冲，始终尝试利用尽可能多的时间。 |
| `p.AnimDynamicsDetailedStats` | `false` | 当设置为1时，将启用更详细的统计数据。 |
| `p.AnimDynamicsLODThreshold` | `-1` | 允许动画动态运行的最大LOD。提供一个全局阈值，可重载每个节点的LODThreshold属性。-1表示无重载。 |
| `p.AnimDynamicsNumDebtFrames` | `5` | 当使用自适应分步时，要保留作为时间债务的帧数，它应至少为1，否则将从不清除时间债务。 |
| `p.AnimDynamicsRestrictLOD` | `-1` | 强制仅为指定LOD启用动画动态，-1，在所有LOD上启用。 |
| `p.AnimDynamicsWind` | `1` | 全局启用/禁用动画动态风力。 |
| `p.ApplyAsyncSleepState` | `1` |  |
| `p.AsyncCharacterMovement` | `0` | 1，在物理线程上启用角色移动的异步模拟。不建议在运行时切换该设置。该功能尚未完全开发，因此不鼓励使用。 |
| `p.AsyncInterpolationMultiplier` | `2` | 针对插值，应回看固定dt的多少倍 |
| `p.AsyncPhysicsBlockMode` | `0` | 设置为0，将在过去GT帧中生成的任何物理步骤上阻止，同时在当前帧中的任何任务上不阻止。1将在所有任务上阻止，但最近的任务（包括当前帧中的任务）除外。1应保证始终有一个针对过去2帧的插值的未来输出。2不会阻止游戏线程，如果花费太多时间，可能最终会丢弃物理步骤。 |
| `p.BasedMovementMode` | `2` | 0表示始终处于正常刷新（默认值）；1表示仅在不推迟更新的情况下；2表示当在物理基础上时定期刷新和后期物理上基于更新和保存的移动。 |
| `p.bGeometryCollectionRepUseClusterVelocityMatch` | `true` | 使用物理速度匹配群集状态 |
| `p.BodySetupSkipDDCThreshold` | `16384` | 允许跳过顶点计数低于阈值的全身设置的DDC。默认值：16384 |
| `p.BoundingBoxMarginForConnectionGraphFiltering` | `0` | 当UseBoundingBoxForConnectionGraphFiltering打开时，用于重叠测试的边距[默认值：0] |
| `p.BoundingVolumeNumCells` | `35` |  |
| `p.BPTreeOfGrids` | `1` | 是否为bp使用单独的网格树 |
| `p.BroadphaseType` | `1` |  |
| `p.bUseUnifiedHeightfield` | `1` | 是否使用PhysX统一高度场。PhysX的这一功能使地形碰撞与三角形网格体一致，但统一高度场不支持厚度参数。1启用，0禁用。默认值：1 |
| `p.Chaos.AABBTransform.ISPC` | `true` | 计算AABB变换时是否使用ISPC优化 |
| `p.Chaos.AABBTransform.Optimized` | `false` | 是否使用优化的AABB变换 |
| `p.Chaos.AccelerationStructureCacheOverlappingLeaves` | `1` | 设置为1：缓存重叠叶以获得更快的重叠查询，任何其他值将禁用该功能 |
| `p.Chaos.AccelerationStructureIsolateQueryOnlyObjects` | `0` | 设置为1：QueryOnly对象将不会移至物理线程上的加速结构 |
| `p.Chaos.AccelerationStructureSplitStaticDynamic` | `1` | 设置为1：将动态和静态对象分类到单独的加速结构中，任何其他值将禁用该功能 |
| `p.Chaos.AccelerationStructureTimeSlicingMaxBytesCopy` | `100000` | 在复制时间切片期间要复制到外部加速结构的字节数上限 |
| `p.Chaos.AccelerationStructureTimeSlicingMaxQueueSizeBeforeForce` | `1000` | 如果更新队列达到此限制，将禁用时间切片，并且立即构建加速结构 |
| `p.Chaos.AccelerationStructureUseDirtyTreeInsteadOfGrid` | `1` | 对脏元素使用动态树结构，而不是2D网格 |
| `p.Chaos.AccelerationStructureUseDynamicTree` | `1` | 对动态对象使用动态BVH树结构 |
| `p.chaos.AllowCreatePhysxBodies` | `1` | 0为关闭，1为打开（默认） |
| `p.Chaos.ArrayCollection.MaxSlackFraction` | `0.5` | 如果松弛元素数量超过该部分的元素数量，将缩小粒子数组 |
| `p.Chaos.ArrayCollection.MinSlack` | `100` | 不要减少粒子数组的大小（如果它将保留比此处更少的松弛） |
| `p.Chaos.AxialSpring.ISPC` | `true` | 是否在AxialSpring约束中使用ISPC优化 |
| `p.Chaos.AxialSpring.ParallelConstraintCount` | `100` | 如果有更多约束，在Apply中使用parallel-for。 |
| `p.Chaos.Bending.ISPC` | `true` | 是否在弯曲约束中使用ISPC优化 |
| `p.Chaos.Bending.ParallelConstraintCount` | `100` | 如果有更多约束，在Apply中使用parallel-for。 |
| `p.Chaos.BoxCalcBounds.ISPC` | `true` | 是否在计算几何体集合中的框边界时使用ISPC优化 |
| `p.Chaos.BroadPhase.MidPhaseRedistributionEnabled` | `true` |  |
| `p.Chaos.Cache.CompressTracksAfterRecording` | `true` | 启用后，缓存将在记录完成后压缩变换轨道。[默认值：true] |
| `p.Chaos.Cache.UseInterpolation` | `true` | 启用后，缓存在关键帧之间插值。[默认值：true] |
| `p.Chaos.CalculateBounds.ISPC` | `true` | 是否在CalculateBounds中使用ISPC优化 |
| `p.Chaos.CCD.AllowedDepthBoundsScale` | `0.2` | 当回滚到TOI时，允许（最小边界的范围）AllowedDepthBoundsScale，而不是回滚到精确的TOI，其中穿透=0。 |
| `p.Chaos.CCD.AxisThresholdMode` | `2` | 更改用于为粒子几何体生成CCD轴阈值边界的模式。 0：使用对象边界 1：找到任何轴上最薄的对象边界，并将其用于所有CCD轴 2：在每个轴上，使用该轴上最薄的形状边界 3：找到任何轴上最薄的形状边界，并将其用于所有轴 |
| `p.Chaos.CCD.CCDAxisThresholdUsesProbeShapes` | `false` | 当为true时，将考虑探头形状用于CCD轴阈值计算，同时探头形状可以在初始CCD阶段生成触点。 |
| `p.Chaos.CCD.CCDSweepsUseProbeShapes` | `false` | 当为true时，可以扫描探针形状以获得更准确的碰撞检测。 |
| `p.Chaos.CCD.EnableThresholdBoundsScale` | `0.4` | 当对象位置正在发生改变>最小边界的范围BoundsScale，将使用CCD。0将始终使用CCD。值<0，将禁用CCD。 |
| `p.Chaos.CCD.NewTargetDepthMode` | `true` | 找到第一个导致(CCDAllowedDepthBoundsScale*Size)穿透的接触，而不是第一个接触 |
| `p.Chaos.CCD.NoCullAllShapePairs` | `true` | 是否根据对所有形状对（不仅仅是凸包凸包）的扫描的phi提前剔除接触。 |
| `p.Chaos.CCD.OnlyConsiderDynamicStatic` | `0` | 仅为动态-静态对启用CCD。 |
| `p.Chaos.CCD.UseGenericSweptConvexConstraints` | `1` | 对于没有专门实现的凸包形状对，使用通用凸包凸包扫描约束生成。 |
| `p.Chaos.CharacterGroundConstraint.ExternalMovementThreshold` | `2` | 如果移动距离小于此值，则相对于地面，保持当前移动目标。 |
| `p.Chaos.CharacterGroundConstraint.InputMovementThreshold` | `0.1` | 每帧最小输入移动距离，以厘米为单位。 |
| `p.Chaos.CheckForInterclusterEdgesOnRelease` | `true` | 当从父群集中移除子级时，是否检查群集间边缘，以便将粒子添加回群集并集中。 |
| `p.Chaos.Cloth.CGTol` | `50` | CG容差[默认值：1e-4] |
| `p.Chaos.Cloth.DisplayResidual` | `false` | 显示前10个迭代的残留法线[默认值：false] |
| `p.Chaos.Cloth.DoQuasistatics` | `false` | 执行布料半静态[默认值：false] |
| `p.Chaos.Cloth.EnableCG` | `false` | 用共轭梯度代替非线性Gauss Seidel[默认值：false] |
| `p.Chaos.Cloth.EnableGaussSeidel` | `false` | 使用Gauss Seidel约束而不是XPBD[默认值：false] |
| `p.Chaos.Cloth.MakeSandwich` | `false` | xpbd的MakeSandwich解算器-Newton/GS[默认值：false] |
| `p.Chaos.Cloth.MaxItCG` | `50` | CG的最大迭代[默认值：50] |
| `p.Chaos.Cloth.MaxResidualIters` | `10` | 显示残留的最大迭代次数[默认：10] |
| `p.Chaos.Cloth.MiddleBreadIters` | `3` | 三明治解算器的中间面包的迭代[默认值：3] |
| `p.Chaos.Cloth.ReplaceBiasElementsWithCorotatedCod` | `false` | 用Gauss Seidel共旋转余维替换现有的各向异性偏置元素约束[默认值：false] |
| `p.Chaos.Cloth.SOROmega` | `1.7` | 加速的SOR omega系数[默认：1.7] |
| `p.Chaos.Cloth.StiffnessPaddingRatio` | `0` | Gauss Seidel的刚度填充[默认：1] |
| `p.Chaos.Cloth.UpperBreadIters` | `3` | 三明治解算器的上层面包迭代[默认值：3] |
| `p.Chaos.Cloth.UseSOR` | `true` | 将SOR加速用于Gauss Seidel[默认值：true] |
| `p.Chaos.Cloth.WriteFinalResiduals` | `false` | 将每个时间步进的最终残留写入文件[默认值：false] |
| `p.Chaos.Cloth.WriteResidual2File` | `false` | 将残留写入文件[默认值：false] |
| `p.Chaos.Cloth.YoungsModulus` | `10000` | Youngs模块[默认值：1e4] |
| `p.chaos.clustering.breakonlystrained` | `1` | 启用后，仅处理用于中断的紧张群集，禁用后，将遍历和检查所有群集 |
| `p.Chaos.Clustering.DumpClusterAndReleaseStats` | `0` | 报告每帧的群集进程和释放粒子的数量，打开/关闭，1/0 |
| `p.Chaos.Clustering.PerAdvanceBreaksAllowed` | `2147483647` | 每次调用AdvanceClustering时允许发生的中断数 |
| `p.Chaos.Clustering.PerAdvanceBreaksRescheduleLimit` | `2147483647` | 允许为下一帧（若有）重新安排的中断数量 |
| `p.Chaos.ClusterUnion.DoNotAddEmptyClusters` | `true` | 限制有风险的漏洞修复。 |
| `p.Chaos.ClusterUnion.GenerateInterclusterEdges` | `true` | 是否在添加到群集并集时自动生成群集间边缘（并在从群集并集退出时移除它们）。 |
| `p.Chaos.Collision.AABBBoundsCheck` | `true` |  |
| `p.Chaos.Collision.ABTestSolver` | `false` |  |
| `p.Chaos.Collision.AllowLevelsetManifolds` | `true` | 使用增量流形进行关卡集-关卡集碰撞。该功能不能很好地运行-小片段中有太多旋转 |
| `p.Chaos.Collision.AllowParticleTracking` | `true` | 当DoBufferCollisions标记为启用时，允许粒子追踪它们的碰撞约束[默认：true] |
| `p.Chaos.Collision.CCD.AllowClipping` | `true` | 当计算预算耗尽时，这将裁剪碰撞位置的CCD对象。默认值为true。关闭此选项可能会导致隧道效应。 |
| `p.Chaos.Collision.CCD.ConstraintMaxProcessCount` | `1` | 应用CCD约束时，每个约束可以解析的最大次数。默认值为2。该数字越大，就会越充分地解析CCD约束。 |
| `p.Chaos.Collision.CCD.CorrectionIterations` | `4` | 要运行的后期解析CCD校正迭代的次数。 |
| `p.Chaos.Collision.CCD.CorrectionPhiToleranceScale` | `0.02` | 在校正阶段允许的穿透程度（形状大小乘数） |
| `p.Chaos.Collision.CCD.EnableResweep` | `true` | 启用CCD的重新扫描。重新扫描让CCD可以捕获到更多二次碰撞，但开销也更高。默认值为true。 |
| `p.Chaos.Collision.CCD.UseTightBoundingBox` | `true` |  |
| `p.Chaos.Collision.ConvexZeroMargin` | `0` |  |
| `p.Chaos.Collision.CullDistanceReferenceSize` | `0.01` |  |
| `p.Chaos.Collision.DebugDrawProbeDetection` | `false` | 绘制探头约束检测。 |
| `p.Chaos.Collision.EdgePrunePlaneDistance` | `3` |  |
| `p.Chaos.Collision.EnableBoundsChecks` | `true` |  |
| `p.Chaos.Collision.EnableCollisionManager` | `true` | 启用Chaos的碰撞管理器，以忽略刚体之间的碰撞。[默认值：1] |
| `p.Chaos.Collision.EnableEdgeCollisionPruning` | `true` |  |
| `p.Chaos.Collision.EnableEdgePrune` | `true` |  |
| `p.Chaos.Collision.EnableLargeMeshManifolds` | `true` | 是否允许大型网格体流形与网格体碰撞（良好操作需要） |
| `p.Chaos.Collision.EnableMACDFallback` | `false` |  |
| `p.Chaos.Collision.EnableManifoldGJKInject` | `false` |  |
| `p.Chaos.Collision.EnableManifoldGJKReplace` | `false` |  |
| `p.Chaos.Collision.EnableMeshCollisionPruning` | `true` |  |
| `p.Chaos.Collision.EnableMeshManifoldOptimizedLoop` | `true` |  |
| `p.Chaos.Collision.EnableMeshManifoldOptimizedLoopTriMesh` | `true` |  |
| `p.Chaos.Collision.EnableOneWayInteraction` | `true` | 在碰撞约束中是否遵循单向交互标记 |
| `p.Chaos.Collision.EnableShapePairs` | `true` |  |
| `p.Chaos.Collision.EnableSubSurfaceCollisionPruning` | `false` |  |
| `p.Chaos.Collision.EPAEpsilon` | `1e-06` |  |
| `p.Chaos.Collision.GBFCharacteristicTimeRatio` | `1` | 特征时间与Dt的比率 |
| `p.Chaos.Collision.GJKEpsilon` | `1e-06` |  |
| `p.Chaos.Collision.Manifold.CapsuleAxisAlignedThreshold` | `0.8` |  |
| `p.Chaos.Collision.Manifold.CapsuleDeepPenetrationFraction` | `0.05` |  |
| `p.Chaos.Collision.Manifold.CapsuleMinContactDistanceFraction` | `0.1` |  |
| `p.Chaos.Collision.Manifold.CapsuleRadialContactFraction` | `0.25` |  |
| `p.Chaos.Collision.Manifold.CullDistanceMarginMultiplier` | `1` |  |
| `p.Chaos.Collision.Manifold.EdgeNormalThreshold` | `0.9` |  |
| `p.Chaos.Collision.Manifold.EnableFrictionRestore` | `true` |  |
| `p.Chaos.Collision.Manifold.EnableGjkWarmStart` | `true` |  |
| `p.Chaos.Collision.Manifold.ForceOneShotManifoldEdgeEdgeCaseZeroCullDistance` | `false` | 启用后，如果一次性流形击中边缘/边缘案例，将强制剔除距离为零。这意味着，如果分离的话，将丢弃边缘/边缘接触。仅适用于凸包/凸包一次性实现。 |
| `p.Chaos.Collision.Manifold.FrictionExactPositionTolerance` | `0.2` |  |
| `p.Chaos.Collision.Manifold.FrictionNearPositionTolerance` | `1` |  |
| `p.Chaos.Collision.Manifold.MatchNormalTolerance` | `0.02` | 法线点积上的公差，用于确定两个接触点是否相同 |
| `p.Chaos.Collision.Manifold.MatchPositionTolerance` | `0.3` | 作为对象大小的一部分的公差，用于确定两个接触点是否相同 |
| `p.Chaos.Collision.Manifold.MinFaceSearchDistance` | `1` |  |
| `p.Chaos.Collision.Manifold.PlaneContactNormalEpsilon` | `0.001` | 法线公差，用于区分面接触和边缘-边缘接触 |
| `p.Chaos.Collision.Manifold.SphereCapsuleSizeThreshold` | `0.5` |  |
| `p.Chaos.Collision.Manifold.TriangleConvexMarginMultiplier` | `0.5` |  |
| `p.Chaos.Collision.Manifold.TriangleNormalThreshold` | `0.75` |  |
| `p.Chaos.Collision.MarginFraction` | `-1` | 重载物理设置中设置的碰撞边缘部分（如果>=0） |
| `p.Chaos.Collision.MarginMax` | `-1` | 重载物理设置中设置的最大碰撞边缘（如果>=0） |
| `p.Chaos.Collision.MaxManifoldPoints` | `-1` |  |
| `p.Chaos.Collision.MaxShapePairs` | `100` |  |
| `p.Chaos.Collision.MeshContactNormalRejectionThreshold` | `0.7` | 如果边缘法线和顶点法线超出有效范围，且程度超过此范围，不要校正 |
| `p.Chaos.Collision.MeshContactNormalThreshold` | `0.998` | 将法线与大于此值的三角形面之间的点积的接触视为面碰撞 |
| `p.Chaos.Collision.MeshManifoldHashSize` | `256` | 在凸包网格体碰撞的顶点和边缘贴图中使用的哈希表大小 |
| `p.Chaos.Collision.MinCullDistanceScale` | `1` |  |
| `p.Chaos.Collision.OneSidedHeightField` | `true` |  |
| `p.Chaos.Collision.OneSidedTriangleMesh` | `true` |  |
| `p.Chaos.Collision.OneWayStiffness` | `0.5` | 单向交互的碰撞解算器刚度 |
| `p.Chaos.Collision.ShapesArrayMode` | `true` |  |
| `p.Chaos.Collision.SortMeshManifoldByDistance` | `false` | 通过"RxN"对大型网格流形点进行排序，以提高求解器的稳定性（在第一次迭代中减少旋转） |
| `p.Chaos.Collision.SphereBoundsCheck` | `true` |  |
| `p.Chaos.Collision.Stiffness` | `-1` | 重载碰撞解算器刚度（如果>=0） |
| `p.Chaos.Collision.TriangeMeshDistanceTolerance` | `0.1` |  |
| `p.Chaos.Collision.TriangeMeshPhiToleranceScale` | `1` |  |
| `p.Chaos.Collision.UnionBVH.Enabled` | `true` | 设置为false，以在碰撞检测期间禁用BVH（不影响创建和序列化） |
| `p.Chaos.Collision.UnionBVH.MaxDepth` | `14` | 当BVH用于封装形状层级时允许的BVH深度 |
| `p.Chaos.Collision.UnionBVH.NumShapes` | `10` | 如果几何体层级有此数量的形状，将其封装在BVH中进行碰撞检测（负数将禁用BVH）。 |
| `p.Chaos.Collision.UnionBVH.SplitBias` | `0.1` |  |
| `p.Chaos.Collision.UnionBVH.UseOptimizedCountLeafObjects` | `true` |  |
| `p.Chaos.Collision.UseCapsuleTriMesh2` | `true` |  |
| `p.Chaos.Collision.UseConvexTriMesh2` | `true` |  |
| `p.Chaos.Collision.UseGJK2` | `false` |  |
| `p.Chaos.CollisionSpring.FalloffMultiplier` | `1` | 与三角形的切线距离（按厚度缩放），超出该距离的点不被视为是运动学上的碰撞 |
| `p.Chaos.CollisionSpring.ISPC` | `true` | 是否在碰撞弹性约束中使用ISPC优化 |
| `p.Chaos.CollisionSpring.MaxDepthMultiplier` | `10` | 穿透深度，超过此深度时将忽略运动学碰撞（以免推错方向） |
| `p.Chaos.CollisionSpring.MaxTimer` | `0.1` | 在移动超过厚度后，要记住运动碰撞连接的时间（以秒为单位）增大该值，可以减少抖动，但代价是计算增多。 |
| `p.Chaos.CollisionStore.Enabled` | `true` |  |
| `p.Chaos.ConstraintGraph.Validate` | `false` | 启用每次刷新ConstraintGraph验证检查/断言 |
| `p.Chaos.Constraints.DetailedStats` | `0` | 当设置为1时，将启用更详细的统计数据。 |
| `p.Chaos.Convex.DynamicMode` | `2` | 动态形状的简化模式（0：单个凸包，1：每个子级一个凸包，2：使用分割阈值合并连接的子级 |
| `p.Chaos.Convex.EnableMerging` | `true` | 布尔值，用于检查是合并（自下而上）还是拆分（自上而下）凸包 |
| `p.Chaos.Convex.KinematicMode` | `2` | 运动学形状的简化模式（0：单个凸包，1：每个子级一个凸包，2：使用分割阈值合并连接的子级 |
| `p.Chaos.Convex.MinVolume` | `10000` | 简化凸包的最小体积 |
| `p.Chaos.Convex.SimplifyUnion` | `false` | 如果为true，将隐式层级中的所有凸包替换为简化凸包（目前为kdop18 tribox），用于碰撞 |
| `p.Chaos.Convex.SplittingThreshold` | `1` | Tribox体积/凸包外壳阈值，用于在树构建过程中触发体积分割 |
| `p.Chaos.Convex.UseSimplifierForTConvexHull3Builder` | `false` | 如果默认编译使用几何体工具凸包外壳算法，也将使用相应简化器。[默认值：false] |
| `p.Chaos.Convex.UseTConvexHull3Builder` | `true` | 设置默认编译方法时，使用较新的几何体工具代码路径生成凸包外壳。[默认值：true] |
| `p.Chaos.ConvexGeometryCheckEnable` | `0` | 为Chaos物理系统执行凸包几何体复杂性检查。 |
| `p.Chaos.ConvexParticlesWarningThreshold` | `50` | 超过此阈值时将针对碰撞几何体复杂性发出警告。 |
| `p.Chaos.CU.UseFlushNetDormancy` | `true` | 当为true时，它将在下一帧刷新所有者的网络休眠，而不是唤醒Actor |
| `p.Chaos.DampVelocity.ISPC` | `true` | 是否在每个粒子阻尼速度计算中使用ISPC优化 |
| `p.Chaos.DebugDraw.BVHBounds` | `true` | 是否绘制BVH节点边界（着色） |
| `p.Chaos.DebugDraw.BVHLevel` | `-1` | 要绘制的BVH的哪个级别（-1=叶） |
| `p.Chaos.DebugDraw.BVHShapes` | `false` | 是否绘制每个BVH节点中的形状（着色） |
| `p.Chaos.DebugDraw.CCDDuration` | `0` | CCD调试绘制应在屏幕上停留多长时间，以秒为单位。0表示1帧。 |
| `p.Chaos.DebugDraw.CollisionDuration` | `0` | 碰撞调试绘图应在屏幕上停留多长时间，以秒为单位。0表示1帧。 |
| `p.Chaos.DebugDraw.ColorBoundsByShapeType` | `false` | 是否使用形状类型定义边界颜色，而不是使用粒子状态（如果有多个形状，将使用第一个） |
| `p.Chaos.DebugDraw.ColorShapesByClusterUnion` | `false` | ColorShapesByInternalCluster选项的扩展：不是为每个内部群集使用单一颜色，而是为每个群集并集使用唯一颜色。非群集并集将为黑色。 |
| `p.Chaos.DebugDraw.ColorShapesByConvexType` | `false` | 是否使用不同颜色显示凸包和简化形状：（简化：绿色，法线：橙色） |
| `p.Chaos.DebugDraw.ColorShapesByInternalCluster` | `false` | 是否检查粒子是否为内部群集以定义其颜色（黑色：常规粒子；红色：内部群集） |
| `p.Chaos.DebugDraw.ColorShapesByIsland` | `false` | 是否使用粒子岛状区定义形状颜色，而不是使用粒子状态 |
| `p.Chaos.DebugDraw.ColorShapesByShapeType` | `false` | 是否使用形状类型定义形状颜色，而不是使用粒子状态 |
| `p.Chaos.DebugDraw.ColorShapesBySimQueryType` | `false` | 是否使用不同颜色显示启用了模拟和启用了查询的形状（模拟：蓝色，查询：橙色） |
| `p.Chaos.DebugDraw.ConnectionGraph.ShowAreas` | `false` | 在显示连接图表时，将连接区域显示为磁盘 |
| `p.Chaos.DebugDraw.ConnectionGraph.ShowInternalStrains` | `false` | 在显示连接图表时，显示每个节点的张力值 |
| `p.Chaos.DebugDraw.ConnectionGraphLevelOffset` | `0` | 如果为0，将绘制激活粒子的子粒子之间的连接图表。如果为1，将绘制激活粒子的孙子粒子等之间的连接图表。 |
| `p.Chaos.DebugDraw.ConvexExplodeDistance` | `0` | 将凸包边缘按此数量爆炸（对于查看凸完整性很有用） |
| `p.Chaos.DebugDraw.Deformable.KinematicParticle` | `false` | 调试绘制可变形运动学粒子。[默认值：false] |
| `p.Chaos.DebugDraw.Deformable.RigidCollisionGeometry` | `false` | 调试绘制可变形解算器刚度碰撞几何体。[默认值：false] |
| `p.Chaos.DebugDraw.Deformable.TetrahedralParticle` | `false` | 调试绘制可变形解算器四面体。[默认值：false] |
| `p.Chaos.DebugDraw.Deformable.TransientKinematicParticle` | `false` | 调试绘制可变形临时运动学粒子。[默认值：false] |
| `p.Chaos.DebugDraw.Enabled` | `false` | 是否调试绘制低级别物理解算器信息 |
| `p.Chaos.DebugDraw.GeometryCollectionReplication` | `false` | 如果为true，将调试绘制几何体集合复制的增量和校正 |
| `p.Chaos.DebugDraw.MaxLines` | `20000` | 设置可渲染的调试绘制线条的数量上限（用于限制性能下降） |
| `p.Chaos.DebugDraw.Mode` | `0` | 在何处发送绘制调制命令。0=UE调试绘制；1=VisLog；2=两者 |
| `p.Chaos.DebugDraw.Radius` | `3000` | 设置调试绘制捕获停止的摄像机的半径（0表示无限） |
| `p.Chaos.DebugDraw.SeeThrough` | `true` | 启用后，将在所有几何体顶部绘制线条 |
| `p.Chaos.DebugDraw.ShowCollisionAnchors` | `false` |  |
| `p.Chaos.DebugDraw.ShowCollisionParticles` | `false` | 是否显示碰撞粒子（如果存在） |
| `p.Chaos.DebugDraw.ShowContactGraph` | `false` | 绘制岛状区时是否显示接触图表 |
| `p.Chaos.DebugDraw.ShowContactGraphUnused` | `false` | 绘制岛状区时是否显示未使用的边缘接触图表（无冲量碰撞） |
| `p.Chaos.DebugDraw.ShowContactGraphUsed` | `false` | 绘制岛状区时是否显示使用过的边缘接触图表（有冲量碰撞） |
| `p.Chaos.DebugDraw.ShowContactIterations` | `false` | 是否显示表示接触点激活的迭代次数的指示器 |
| `p.Chaos.DebugDraw.ShowConvexVertices` | `false` | 是否显示凸包形状的顶点 |
| `p.Chaos.DebugDraw.ShowCoreShapes` | `false` | 是否在适用时显示核心（边缘减少）形状 |
| `p.Chaos.DebugDraw.ShowExactCoreShapes` | `false` | 是否显示确切的核心形状。注意：开销极其高昂，应仅在有几个凸形状的小场景中使用 |
| `p.Chaos.DebugDraw.ShowInactiveContacts` | `true` | 是否显示未激活接触点（没有产生冲量或推出的接触点） |
| `p.Chaos.DebugDraw.ShowIslands` | `true` | 绘制岛状区时是否显示岛状区框（如果只需接触点图表） |
| `p.Chaos.DebugDraw.ShowOptimizedConvexes` | `false` |  |
| `p.Chaos.DebugDraw.ShowPIEClient` | `1` | 在PIE模式下运行时，显示客户端调试绘制 |
| `p.Chaos.DebugDraw.ShowPIEServer` | `0` | 在PIE模式下运行时，显示服务器调试绘制 |
| `p.Chaos.DebugDraw.ShowProbeOnly` | `true` | 是否显示ProbeOnly形状 |
| `p.Chaos.DebugDraw.ShowQueryOnly` | `true` | 是否显示QueryOnly形状 |
| `p.Chaos.DebugDraw.ShowShapeBounds` | `false` | 是否在DrawShapes中显示每个形状的边界 |
| `p.Chaos.DebugDraw.ShowSimOnly` | `true` | 是否显示SimOnly形状 |
| `p.Chaos.DebugDraw.SingleActor` | `false` | 如果为true，则为摄像机正在查看的Actor绘制。 |
| `p.Chaos.DebugDraw.SingleActorMaxRadius` | `1000` | 设置最大半径以围绕单个Actor绘制。 |
| `p.Chaos.DebugDraw.SingleActorTraceLength` | `2000` | 从用于选择单个Actor的摄像机设置追踪长度。 |
| `p.Chaos.DedicatedThreadEnabled` | `1` | 为Chaos任务启用专用物理任务/线程。0：禁用；1：启用 |
| `p.Chaos.Deformable.GSParallelMax` | `100` | 在Gauss Seidel约束下并行处理的最小粒子数。[默认值：100] |
| `p.Chaos.Deformable.XPBDBatchSize` | `5` | 物理并行的批处理大小。[默认值：5] |
| `p.Chaos.Deformable.XPBDBatchThreshold` | `5` | 物理并行的批处理阈值。[默认值：5] |
| `p.Chaos.Deformable.XPBDWeakConstraintEnableDraw` | `false` | 调试绘制XPBD弱约束中的双绑定。[默认值：false] |
| `p.Chaos.Deformable.XPBDWeakConstraintLineWidth` | `5` | 用于在XPBD弱约束中可视化双绑定的线条宽度。[默认值：5] |
| `p.Chaos.Deformable.XPBDWeakConstraintParticleWidth` | `20` | 用于在XPBD弱约束中可视化双绑定的线条宽度。[默认值：20] |
| `p.Chaos.DisableCollisionParallelFor` | `false` | 禁用Chaos碰撞的并行执行（也通过DisableParticleParallelFor禁用） |
| `p.Chaos.DisableParticleParallelFor` | `false` | 禁用Chaos粒子的并行执行（碰撞， |
| `p.Chaos.DisablePhysicsParallelFor` | `false` | 禁用Chaos演变中的并行执行 |
| `P.Chaos.DrawHierarchy.Bounds` | `1` | 启用/禁用物理层级边界的绘制 |
| `P.Chaos.DrawHierarchy.CellElementThresh` | `128` | "在渲染时被视为单元着色高"的元素数量。 |
| `P.Chaos.DrawHierarchy.Cells` | `0` | 启用/禁用物理层级单元的绘制 |
| `P.Chaos.DrawHierarchy.DrawEmptyCells` | `1` | 是否在单元启用时绘制为空的单元。 |
| `P.Chaos.DrawHierarchy.Enable` | `0` | 启用/禁用物理层级的绘制 |
| `P.Chaos.DrawHierarchy.ObjectBounds` | `1` | 启用/禁用物理层级对象边界的绘制 |
| `p.Chaos.DumpHierElementBuckets` | `1 \\\| 8 \\\| 16 \\\| 32 \\\| 64 \\\|128 \\\| 256 \\\| 512` | Distribution buckets for dump hierarchy stats command |
| `p.Chaos.GC.CreatePhysicsStateInEditor` | `false` | 当打开时，将在编辑器中创建垃圾回收的物理状态（非PIE） |
| `p.Chaos.GC.EmitRootBreakingEvent` | `false` | 当为true时，若root中断，发送一个中断事件 |
| `p.Chaos.GC.EnableCollisionParticles` | `true` | 允许使用碰撞粒子进行碰撞[默认值：true] |
| `p.Chaos.GC.EnableRootProxyComponents` | `true` | 当打开时（默认），将创建根代理组件 |
| `p.Chaos.GC.InitConstantDataParallelForBatchSize` | `5000` | 当在InitConstantData中使用parallelFor时，定义一部分顶点的最小大小 |
| `p.Chaos.GC.InitConstantDataUseParallelFor` | `true` | 启用后，InitConstant数据将使用parallelFor复制一些数据 |
| `p.Chaos.GC.ISMPoolDebugDraw` | `0` | 显示ISM池的调试绘制 |
| `p.Chaos.GC.ISMPoolDebugStats` | `0` | 显示ISM池的统计数据 |
| `p.Chaos.GC.MaxGeometryCollectionAsyncPhysicsTickIdleTimeMs` | `30` | 当异步刷新不执行任何操作时，在异步刷新关闭之前的毫秒数。 |
| `p.Chaos.GC.NetAwakeningMode` | `1` | 对垃圾回收组件确保其所有者处于复制状态的方式进行更改。0=ForceDormancyAwake，1=使用刷新网络休眠 |
| `p.Chaos.GC.RemovalTimerMultiplier` | `1` | 用于删除时间求值的乘数（>1：更快删除，>1更慢 |
| `p.Chaos.GC.UseCustomRenderer` | `true` | 启用后，如果指定，将使用自定义渲染器 |
| `p.Chaos.GC.UseReplicationV2` | `true` | 当为true时，将使用新的复制数据模型 |
| `p.Chaos.Geometry.ForceDeepCopyAccess` | `false` | 当修改粒子几何体时，是否始终使用深度副本 |
| `p.Chaos.GetSimData.ISPC` | `true` | 获取模拟数据时是否使用ISPC优化 |
| `p.Chaos.ImmPhys.Collision.CullDistance` | `-1` | 设置碰撞CullDistance（如果>=0） |
| `p.Chaos.ImmPhys.Collision.DeferNarrowPhase` | `1` | [旧版解算器]为所有broadphase对创建接触点，稍后再执行NarrowPhase。 |
| `p.Chaos.ImmPhys.Collision.Enabled` | `1` | 在Immediate Physics中启用/禁用碰撞。 |
| `p.Chaos.ImmPhys.Collision.MaxDepenetrationVelocity` | `-1` | 设置碰撞最大穿透速度（如果>=0） |
| `p.Chaos.ImmPhys.Collision.Priority` | `1` | 设置碰撞约束排序（关节具有优先级0） |
| `p.Chaos.ImmPhys.Collision.RestitutionEnabled` | `1` | 碰撞恢复启用/禁用 |
| `p.Chaos.ImmPhys.Collision.RestitutionThresholdMultiplier` | `1.5` | 碰撞恢复阈值（加速）=乘数 x 重力 |
| `p.Chaos.ImmPhys.Collision.UseManifolds` | `0` | [旧版解算器]在碰撞中启用/禁用流形的使用。 |
| `p.Chaos.ImmPhys.DebugDraw.AngVelScale` | `0` | 如果>0，在绘制粒子变换时显示角速度。 |
| `p.Chaos.ImmPhys.DebugDraw.ArrowSize` | `1.5` | ArrowSize。 |
| `p.Chaos.ImmPhys.DebugDraw.BodyAxisLen` | `4` | BodyAxisLen。 |
| `p.Chaos.ImmPhys.DebugDraw.ConstraintAxisLen` | `5` | ConstraintAxisLen。 |
| `p.Chaos.ImmPhys.DebugDraw.ContactInfoWidth` | `2` | ContactInfoWidth。 |
| `p.Chaos.ImmPhys.DebugDraw.ContactLen` | `4` | ContactLen。 |
| `p.Chaos.ImmPhys.DebugDraw.ContactOwnerWidth` | `0` | ContactOwnerWidth。 |
| `p.Chaos.ImmPhys.DebugDraw.ContactWidth` | `2` | ContactWidth。 |
| `p.Chaos.ImmPhys.DebugDraw.ImpulseScale` | `0` | 如果>0，在绘制碰撞时显示冲量。 |
| `p.Chaos.ImmPhys.DebugDraw.InertiaScale` | `0` | 如果>0，在绘制粒子时显示惯性。 |
| `p.Chaos.ImmPhys.DebugDraw.JointFeatures.ActorConnector` | `true` | 关节功能遮罩（请参见FDebugDrawJointFeatures）。 |
| `p.Chaos.ImmPhys.DebugDraw.JointFeatures.Axes` | `false` | 关节功能遮罩（请参见FDebugDrawJointFeatures）。 |
| `p.Chaos.ImmPhys.DebugDraw.JointFeatures.Color` | `false` | 关节功能遮罩（请参见FDebugDrawJointFeatures）。 |
| `p.Chaos.ImmPhys.DebugDraw.JointFeatures.CoMConnector` | `false` | 关节功能遮罩（请参见FDebugDrawJointFeatures）。 |
| `p.Chaos.ImmPhys.DebugDraw.JointFeatures.Index` | `false` | 关节功能遮罩（请参见FDebugDrawJointFeatures）。 |
| `p.Chaos.ImmPhys.DebugDraw.JointFeatures.Island` | `false` | 关节功能遮罩（请参见FDebugDrawJointFeatures）。 |
| `p.Chaos.ImmPhys.DebugDraw.JointFeatures.Level` | `false` | 关节功能遮罩（请参见FDebugDrawJointFeatures）。 |
| `p.Chaos.ImmPhys.DebugDraw.JointFeatures.Stretch` | `true` | 关节功能遮罩（请参见FDebugDrawJointFeatures）。 |
| `p.Chaos.ImmPhys.DebugDraw.LineThickness` | `0.15` | LineThickness。 |
| `p.Chaos.ImmPhys.DebugDraw.PushOutScale` | `0` | 如果>0，在绘制碰撞时显示推出。 |
| `p.Chaos.ImmPhys.DebugDraw.Scale` | `1` | 应用于所有Chaos调试绘制线条长度等的比例。 |
| `p.Chaos.ImmPhys.DebugDraw.ShapeLineThicknessScale` | `1` | 形状lineThickness乘数。 |
| `p.Chaos.ImmPhys.DebugDraw.VelScale` | `0` | 如果>0，在绘制粒子变换时显示速度。 |
| `p.Chaos.ImmPhys.DebugDrawBounds` | `false` | 是否在调试绘制时绘制边界。 |
| `p.Chaos.ImmPhys.DebugDrawCollisions` | `false` | 是否在调试绘制时绘制碰撞。 |
| `p.Chaos.ImmPhys.DebugDrawJoints` | `false` | 是否在调试绘制时绘制关节。 |
| `p.Chaos.ImmPhys.DebugDrawOnSimulate` | `false` | 在模拟完成后启用调试绘制。 |
| `p.Chaos.ImmPhys.DebugDrawParticles` | `false` | 是否在调试绘制时绘制粒子。 |
| `p.Chaos.ImmPhys.DebugDrawShapes` | `false` | 是否在调试绘制时绘制形状。 |
| `p.Chaos.ImmPhys.DebugDrawShowDynamics` | `true` | 如果启用了形状调试绘制，将显示动态 |
| `p.Chaos.ImmPhys.DebugDrawShowKinematics` | `true` | 如果启用了形状调试绘制，将显示运动学 |
| `p.Chaos.ImmPhys.DebugDrawShowStatics` | `true` | 如果启用了形状调试绘制，将显示统计数据 |
| `p.Chaos.ImmPhys.DebugDrawSimulationSpace` | `false` | 调试绘制时是否绘制引用、加速和速度的模拟帧。 |
| `p.Chaos.ImmPhys.DeltaTimeCount` | `100` | 计算移动平均值的刷新次数 |
| `p.Chaos.ImmPhys.DisableInactiveByIndex` | `1` | 基于索引而不仅仅是计数，禁用不再激活的对象。 |
| `p.Chaos.ImmPhys.FixedStepTime` | `-1` | 重载固定步长时间模式：固定步长时间（如果为正数）；可变时间模式（如果为零）；定义的资产（如果为负数） |
| `p.Chaos.ImmPhys.FixedStepTolerance` | `0.05` | 添加新步长所需的剩余时间（FixedStepTime的一部分） |
| `p.Chaos.ImmPhys.InertiaConditioning.Distance` | `10` | 惯性调节系统的输入。需要稳定的关节距离误差（产生低旋转）。 |
| `p.Chaos.ImmPhys.InertiaConditioning.LinearEnabled` | `true` | 当使用线性关节解算器时，通过惯性调节启用/禁用约束稳定性 |
| `p.Chaos.ImmPhys.InertiaConditioning.MaxInvInertiaComponentRatio` | `0` | 惯性调节系统的输入。最大惯性分量必须至少是最小惯性分量的最小倍数 |
| `p.Chaos.ImmPhys.InertiaConditioning.NonlinearEnabled` | `false` | 当使用非线性关节解算器时，通过惯性调节启用/禁用约束稳定性 |
| `p.Chaos.ImmPhys.InertiaConditioning.RotationRatio` | `2` | 惯性调节系统的输入。旋转与平移的最大关节校正比 |
| `p.Chaos.ImmPhys.InitialStepTime` | `0.033` | 初始步长时间（然后从滚动平均值计算） |
| `p.Chaos.ImmPhys.Joint.AngleTolerance` | `0.001` | AngleTolerance。 |
| `p.Chaos.ImmPhys.Joint.AngularDriveDamping` | `-1` | 6Dof关节驱动阻尼重载（如果>0）。 |
| `p.Chaos.ImmPhys.Joint.AngularDriveStiffness` | `-1` | 6Dof关节驱动刚度重载（如果>0）。 |
| `p.Chaos.ImmPhys.Joint.AngularProjection` | `-1` | 6Dof关节投射量重载（如果>=0）。 |
| `p.Chaos.ImmPhys.Joint.EnableDrives` | `1` | EnableDrives。 |
| `p.Chaos.ImmPhys.Joint.EnableSwingLimits` | `1` | EnableSwingLimits。 |
| `p.Chaos.ImmPhys.Joint.EnableTwistLimits` | `1` | EnableTwistLimits。 |
| `p.Chaos.ImmPhys.Joint.LinearDriveDamping` | `-1` | 6Dof关节驱动阻尼重载（如果>0）。 |
| `p.Chaos.ImmPhys.Joint.LinearDriveStiffness` | `-1` | 6Dof关节驱动刚度重载（如果>0）。 |
| `p.Chaos.ImmPhys.Joint.LinearProjection` | `-1` | 6Dof关节投射量重载（如果>=0）。 |
| `p.Chaos.ImmPhys.Joint.MaxInertiaRatio` | `5` | 6Dof关节MaxInertiaRatio（如果>0） |
| `p.Chaos.ImmPhys.Joint.MinParentMassRatio` | `0.2` | 6Dof关节MinParentMassRatio（如果>0） |
| `p.Chaos.ImmPhys.Joint.NumShockPropagationIterations` | `-1` | 冲击传播需要运行多少次迭代 |
| `p.Chaos.ImmPhys.Joint.PositionTolerance` | `0.025` | PositionTolerance。 |
| `p.Chaos.ImmPhys.Joint.ShockPropagation` | `-1` | 6Dof关节冲击传播重载（如果>=0）。 |
| `p.Chaos.ImmPhys.Joint.SoftLinearStiffness` | `-1` | 6Dof关节软线性刚度重载（如果>0）。 |
| `p.Chaos.ImmPhys.Joint.SoftSwingDamping` | `-1` | 6Dof关节SoftSwing阻尼重载（如果>0）。 |
| `p.Chaos.ImmPhys.Joint.SoftSwingStiffness` | `-1` | 6Dof关节SoftSwing刚度重载（如果>0）。 |
| `p.Chaos.ImmPhys.Joint.SoftTwistDamping` | `-1` | 6Dof关节SoftTwist阻尼重载（如果>0）。 |
| `p.Chaos.ImmPhys.Joint.SoftTwistStiffness` | `-1` | 6Dof关节SoftTwist刚度重载（如果>0）。 |
| `p.Chaos.ImmPhys.Joint.SolvePositionLast` | `1` | 是应按照先位置后旋转的顺序（false）还是先旋转后定位置的顺序（true，默认）解析关节？ |
| `p.Chaos.ImmPhys.Joint.Stiffness` | `-1` | 6Dof关节刚度重载（如果>0）。 |
| `p.Chaos.ImmPhys.Joint.SwingTwistAngleTolerance` | `1e-06` | SwingTwistAngleTolerance. |
| `p.Chaos.ImmPhys.Joint.UseLinearSolver` | `-1` | 强制使用线性还是非线性关节解算器。（-1，将使用PhysicsAsset设置） |
| `p.Chaos.ImmPhys.Joint.UsePBDDrives` | `1` | 是在解算器的位置还是速度相位解析驱动（默认为true） |
| `p.Chaos.ImmPhys.MinStepTime` | `0.01` | 如果非零，则如果步长时间小于此值，使用此时间步长进入固定步长模式。 |
| `p.Chaos.ImmPhys.NumCollisionsPerBlock` | `50` | 碰撞池中一个块中的碰撞次数。值越高，缓存效率就越高，但如果不需要如此多，则会浪费内存 |
| `p.Chaos.ImmPhys.NumSteps` | `0` | 重载阶梯数（如果非零） |
| `p.Chaos.ImmPhys.PositionIterations` | `-1` | 重载即时物理中位置迭代循环的数量（如果>=0） |
| `p.Chaos.ImmPhys.ProjectionIterations` | `-1` | 重载即时物理中投射迭代循环的数量（如果>=0） |
| `p.Chaos.ImmPhys.SimSpaceCentrifugalAlpha` | `1` | 刚体节点的模拟空间系统设置 |
| `p.Chaos.ImmPhys.SimSpaceCoriolisAlpha` | `0.5` | 刚体节点的模拟空间系统设置 |
| `p.Chaos.ImmPhys.SimSpaceEulerAlpha` | `1` | 刚体节点的模拟空间系统设置 |
| `p.Chaos.ImmPhys.StepTime` | `0` | 重载步长时间（如果非零） |
| `p.Chaos.ImmPhys.VelocityIterations` | `-1` | 重载即时物理中速度迭代循环的数量（如果>=0） |
| `p.Chaos.InnerParallelForBatchSize` | `0` | 为内部并行设置批处理大小阈值 |
| `p.Chaos.Joint.AngularVelocityThresholdToApplyRestitution` | `0.01` | 仅当初始速度高于此阈值时应用恢复（在Quasipbd中使用） |
| `p.Chaos.Joint.DegenerateRotationLimit` | `-0.998` | 被视为取消生成的摇摆角度的余弦（默认值为Cos(176deg)） |
| `p.Chaos.Joint.DisableSoftLimits` | `false` | 禁用软限制（仅用于调试） |
| `p.Chaos.Joint.ISPC` | `false` | 是否在关节解算器中使用ISPC优化 |
| `p.Chaos.Joint.LinearVelocityThresholdToApplyRestitution` | `0.01` | 仅当初始速度高于此阈值时应用恢复（在Quasipbd中使用） |
| `p.Chaos.Joint.MultiDimension` | `1` |  |
| `p.Chaos.Joint.Plasticity.ClampToLimits` | `true` | 经过塑性计算后，将驱动位置目标限制为定义的限制 |
| `p.Chaos.Joint.VelProjectionAlpha` | `0.1` | 在投射过程中要应用多少速度校正。投射速度增量的等效值（1-阻尼） |
| `p.Chaos.JointConstraint.AngularBreakScale` | `1` | 角断开阈值的转换因子。 |
| `p.Chaos.JointConstraint.AngularDriveDampingScale` | `1.5` | 角驱动阻尼的转换因子。 |
| `p.Chaos.JointConstraint.AngularDriveStiffnessScale` | `1.5` | 角驱动刚度的转换因子。 |
| `p.Chaos.JointConstraint.JointStiffness` | `1` | 硬关节解算器刚度。 |
| `p.Chaos.JointConstraint.LinaearDriveDampingScale` | `1` | 线性驱动阻尼的转换因子。 |
| `p.Chaos.JointConstraint.LinearBreakScale` | `1` | 线性断开阈值的转换因子。 |
| `p.Chaos.JointConstraint.LinearDriveStiffnessScale` | `1` | 线性驱动刚度的转换因子。 |
| `p.Chaos.JointConstraint.SoftAngularDampingScale` | `1000` | 软关节阻尼的转换因子。 |
| `p.Chaos.JointConstraint.SoftAngularForceMode` | `0` | 软角约束强制模式（0：加速；1：强制 |
| `p.Chaos.JointConstraint.SoftAngularStiffnessScale` | `100000` | 软关节刚度的转换因子。 |
| `p.Chaos.JointConstraint.SoftLinearDampingScale` | `1.2` | 软关节阻尼的转换因子。 |
| `p.Chaos.JointConstraint.SoftLinearForceMode` | `0` | 软线性约束强制模式（0：加速；1：强制 |
| `p.Chaos.JointConstraint.SoftLinearStiffnessScale` | `1.5` | 软关节刚度的转换因子。 |
| `p.Chaos.LargeBatchSize` | `100` | Chaos并行循环的大型批处理大小 |
| `p.Chaos.LinearSystem.Preconditioner` | `0` | 0=对角线，1=IncompleteCholesky |
| `p.Chaos.LongRange.ISPC` | `true` | 是否在长距离约束中使用ISPC优化 |
| `p.Chaos.MaxInflationScale` | `2` | 当CCD禁用时，用于检测碰撞的边界限制。边界限制为此比例乘以对象的最大尺寸 |
| `p.Chaos.MaxNumWorkers` | `100` | 设置物理工作程序的最大数量 |
| `p.Chaos.MeshContactGenerator.FixContactNormal.FixEnabled` | `true` | 直至新的代码路径经过良好的测试 |
| `p.chaos.MinContactSpeedForStrainEval` | `1` | 在张力求值累积之前接触点处的最小速度 |
| `p.Chaos.MinEvolution.ForceMaxConstraintIterations` | `false` | 是否强制约束始终使用最糟糕情况下的迭代次数上限 |
| `p.chaos.MinImpulseForStrainEval` | `65.3333` | 在张力求值累积之前的最小累积冲量 |
| `p.Chaos.MinRangeBatchSize` | `0` | 设置并行处理的最小范围批处理大小 |
| `p.Chaos.MultiRes.ApplyTargetNormalOffset` | `true` | 将法线偏移应用于目标。 |
| `p.Chaos.MultiRes.ISPC` | `true` | 是否在MultiRes约束中使用ISPC优化 |
| `p.Chaos.MultiRes.SparseWeightMap` | `false` | 利用稀疏权重贴图结构，并在开始和结束处跳过刚度为0的粒子 |
| `p.Chaos.NewtonEvolution.FastPositionBasedFriction` | `true` |  |
| `p.Chaos.NewtonEvolution.MinParallelBatchSize` | `300` |  |
| `p.Chaos.NewtonEvolution.ParalleIntegrate` | `false` | 并行运行集成步骤。 |
| `p.Chaos.NewtonEvolution.UseNestedParallelFor` | `true` |  |
| `p.Chaos.NewtonEvolution.UseSmoothTimeStep` | `true` |  |
| `p.Chaos.NewtonEvolution.WriteCCDContacts` | `false` | 写入CCD碰撞接触点和法线，可能导致CCD碰撞线程锁定，同时允许调试这些接触点。 |
| `p.Chaos.OnlyUseInterclusterEdgesAttachedToMainParticles` | `true` | 如果为true，群集间边缘必须直接附加到主粒子，以使该粒子保持群集并集的一部分。 |
| `p.Chaos.PBDCollisionSolver.AutoStiffness.MassRatio1` | `0` |  |
| `p.Chaos.PBDCollisionSolver.AutoStiffness.MassRatio2` | `0` |  |
| `p.Chaos.PBDCollisionSolver.EnableInitialDepenetration` | `true` |  |
| `p.Chaos.PBDCollisionSolver.EnableSoftCollisions` | `true` |  |
| `p.Chaos.PBDCollisionSolver.JacobiPositionTolerance` | `1e-06` |  |
| `p.Chaos.PBDCollisionSolver.JacobiRotationTolerance` | `1e-08` |  |
| `p.Chaos.PBDCollisionSolver.JacobiStiffness` | `0.5` |  |
| `p.Chaos.PBDCollisionSolver.MaxManifoldPoints` | `-1` |  |
| `p.Chaos.PBDCollisionSolver.Position.MinInvMassScale` | `0.77` |  |
| `p.Chaos.PBDCollisionSolver.Position.SolveEnabled` | `true` |  |
| `p.Chaos.PBDCollisionSolver.Position.StaticFriction.Stiffness` | `0.5` |  |
| `p.Chaos.PBDCollisionSolver.Velocity.AveragePointEnabled` | `false` |  |
| `p.Chaos.PBDCollisionSolver.Velocity.FrictionEnabled` | `true` |  |
| `p.Chaos.PBDCollisionSolver.Velocity.MinInvMassScale` | `0.77` |  |
| `p.Chaos.PBDCollisionSolver.Velocity.SolveEnabled` | `true` |  |
| `p.Chaos.PBDCollisionSolver.Velocity.StaticFriction.Stiffness` | `1` |  |
| `p.Chaos.PBDEvolution.FastPositionBasedFriction` | `true` |  |
| `p.Chaos.PBDEvolution.MinParallelBatchSize` | `300` |  |
| `p.Chaos.PBDEvolution.ParalleIntegrate` | `false` | 并行运行集成步骤。 |
| `p.Chaos.PBDEvolution.UseNestedParallelFor` | `true` |  |
| `p.Chaos.PBDEvolution.UseSmoothTimeStep` | `true` |  |
| `p.Chaos.PBDEvolution.WriteCCDContacts` | `false` | 写入CCD碰撞接触点和法线，可能导致CCD碰撞线程锁定，同时允许调试这些接触点。 |
| `p.Chaos.PBDLongRangeConstraints.MinParallelBatchSize` | `500` | 批处理中要并行处理的长距离系链的数量下限。 |
| `p.Chaos.PerformGeometryReduction` | `0` | 执行凸包几何体简化以提高Chaos物理系统的性能。 |
| `p.Chaos.PerParticleCollision.ISPC` | `true` | 是否在每个粒子碰撞中使用ISPC优化 |
| `p.Chaos.PerParticleCollision.ISPC.ParallelBatchSize` | `128` | ISPC的并行批处理大小 |
| `p.Chaos.PostIterationUpdates.ISPC` | `true` | 是否在PBD后期迭代更新中使用ISPC优化 |
| `p.Chaos.PreSimulationTransforms.ISPC` | `true` | 是否在ApplySimulationTransforms中使用ISPC优化 |
| `p.Chaos.PreSubstepInterpolation.ISPC` | `true` | 是否在PreSubstep中使用ISPC优化 |
| `p.Chaos.RemoveParticleFromMovingKinematicsOnDisable` | `true` |  |
| `p.Chaos.Simulation.ApplySolverProjectSettings` | `1` | 是否在生成解算器时应用解算器项目设置 |
| `P.Chaos.Simulation.Enable` | `1` | 启用/禁用chaos模拟。如果禁用，物理不会刷新。 |
| `p.Chaos.SkinPhysicsMesh.ISPC` | `true` | 是否在蒙皮物理网格体上使用ISPC优化 |
| `p.Chaos.SmallBatchSize` | `10` | Chaos并行循环的小型批处理大小 |
| `p.Chaos.SmoothedPositionLerpRate` | `0.3` | 平滑位置计算的插值率。用于休眠。 |
| `p.Chaos.SoftBodyCollision.ISPC` | `true` | 是否在每个粒子碰撞中使用ISPC优化 |
| `p.Chaos.SoftBodyCollision.ISPC.ParallelBatchSize` | `128` | ISPC的并行批处理大小 |
| `p.Chaos.Solver.bChaosForceMACD` | `false` | 强制所有碰撞使用MACD进行测试 |
| `p.Chaos.Solver.CharacterGroundConstraint.Priority` | `0` | 设置约束优先级。稍后对较大的值求值[默认值：0] |
| `p.Chaos.Solver.CheckParticleViews` | `false` |  |
| `p.Chaos.Solver.CleanupCommandsOnDestruction` | `1` | 是否在解算器销毁时运行内部命令队列清理（0=无清理，>0=清理所有命令） |
| `p.Chaos.Solver.Collision.AllowManifoldUpdate` | `1` | 启用/禁用在刷新之间重复使用流形（用于小移动）。 |
| `p.Chaos.Solver.Collision.CullDistance` | `-1` | 重载剔除距离（如果>=0） |
| `p.Chaos.Solver.Collision.DeferNarrowPhase` | `0` | 为所有broadphase对创建接触点，稍后再执行NarrowPhase。 |
| `p.Chaos.Solver.Collision.DepenetrationVelocity` | `-1` | 重载初始重叠穿透速度（如果>=0） |
| `p.Chaos.Solver.Collision.Enabled` | `true` | 在主场景中启用/禁用碰撞。 |
| `p.Chaos.Solver.Collision.MaxPushOutVelocity` | `-1` | 重载最大推出速度（如果>=0） |
| `p.Chaos.Solver.Collision.MaxVelocityBoundsExpansion` | `3` | 重载最大速度边界扩展（如果>=0） |
| `p.Chaos.Solver.Collision.MaxVelocityBoundsExpansionMACD` | `1000` | 重载MACD的最大速度边界扩展（如果>=0） |
| `p.Chaos.Solver.Collision.PositionFrictionIterations` | `-1` | 重载应用摩擦的位置迭代的数量（如果>=0） |
| `p.Chaos.Solver.Collision.PositionShockPropagationIterations` | `-1` | 重载应用冲击传播的位置迭代的数量（如果>=0） |
| `p.Chaos.Solver.Collision.Priority` | `0` | 设置约束优先级。稍后对较大的值求值[默认值：0] |
| `p.Chaos.Solver.Collision.SolverType` | `-1` | -1：使用默认值（Gauss Seidel）：0：Gauss Seidel；1：Gauss Seidel SOA 2：Partial Jacobi |
| `p.Chaos.Solver.Collision.UseManifolds` | `1` | 在碰撞中启用/禁用流形的使用。 |
| `p.Chaos.Solver.Collision.VelocityBoundsMultiplier` | `1` | 重载速度边界乘数（如果>=0） |
| `p.Chaos.Solver.Collision.VelocityBoundsMultiplierMACD` | `1` | 重载MACD的速度边界乘数（如果>=0） |
| `p.Chaos.Solver.Collision.VelocityFrictionIterations` | `-1` | 重载应用摩擦的速度迭代的数量（如果>=0） |
| `p.Chaos.Solver.Collision.VelocityShockPropagationIterations` | `-1` | 重载应用冲击传播的速度迭代的数量（如果>=0） |
| `p.Chaos.Solver.CollisionModifiersBeforeCCD` | `false` | True：在应用CCD倒回前运行碰撞修饰符；False（默认）：在CCD倒回后运行修饰符。请参见代码中的注解。 |
| `p.Chaos.Solver.DebugDraw.AngVelScale` | `0` | 如果>0，在绘制粒子变换时显示角速度。 |
| `p.Chaos.Solver.DebugDraw.ArrowSize` | `10` | ArrowSize。 |
| `p.Chaos.Solver.DebugDraw.BodyAxisLen` | `30` | BodyAxisLen。 |
| `p.Chaos.Solver.DebugDraw.Cluster.Constraints` | `0` | 绘制激活群集约束（0=从不；1=帧结束）。 |
| `p.Chaos.Solver.DebugDraw.ColorShapeByClientServer` | `0` | 根据客户端和服务器对形状着色：红色=服务器/蓝色=客户端 |
| `p.Chaos.Solver.DebugDraw.ConstraintAxisLen` | `30` | ConstraintAxisLen。 |
| `p.Chaos.Solver.DebugDraw.ContactInfoWidth` | `6` | ContactInfoWidth。 |
| `p.Chaos.Solver.DebugDraw.ContactLen` | `30` | ContactLen。 |
| `p.Chaos.Solver.DebugDraw.ContactOwnerWidth` | `0` | ContactOwnerWidth。 |
| `p.Chaos.Solver.DebugDraw.ContactWidth` | `6` | ContactWidth。 |
| `p.Chaos.Solver.DebugDraw.DrawPriority` | `10` | 调试绘制形状的绘制优先级（0在实际Z处绘制，+ve更接近屏幕）。 |
| `p.Chaos.Solver.DebugDraw.ImpulseScale` | `0` | 如果>0，在绘制碰撞时显示冲量。 |
| `p.Chaos.Solver.DebugDraw.InertiaScale` | `1` | 当启用DebugDrawTransforms时，显示按此量缩放的质量规格化惯性矩阵。 |
| `p.Chaos.Solver.DebugDraw.JointFeatures.ActorConnector` | `true` | 关节功能遮罩（请参见FDebugDrawJointFeatures）。 |
| `p.Chaos.Solver.DebugDraw.JointFeatures.Axes` | `false` | 关节功能遮罩（请参见FDebugDrawJointFeatures）。 |
| `p.Chaos.Solver.DebugDraw.JointFeatures.Color` | `false` | 关节功能遮罩（请参见FDebugDrawJointFeatures）。 |
| `p.Chaos.Solver.DebugDraw.JointFeatures.CoMConnector` | `false` | 关节功能遮罩（请参见FDebugDrawJointFeatures）。 |
| `p.Chaos.Solver.DebugDraw.JointFeatures.Index` | `false` | 关节功能遮罩（请参见FDebugDrawJointFeatures）。 |
| `p.Chaos.Solver.DebugDraw.JointFeatures.Island` | `false` | 关节功能遮罩（请参见FDebugDrawJointFeatures）。 |
| `p.Chaos.Solver.DebugDraw.JointFeatures.Level` | `false` | 关节功能遮罩（请参见FDebugDrawJointFeatures）。 |
| `p.Chaos.Solver.DebugDraw.JointFeatures.Stretch` | `true` | 关节功能遮罩（请参见FDebugDrawJointFeatures）。 |
| `p.Chaos.Solver.DebugDraw.LineThickness` | `1` | LineThickness。 |
| `p.Chaos.Solver.DebugDraw.PointSize` | `5` | 点大小。 |
| `p.Chaos.Solver.DebugDraw.PushOutScale` | `0` | 如果>0，在绘制碰撞时显示推出。 |
| `p.Chaos.Solver.DebugDraw.Scale` | `1` | 应用于所有Chaos调试绘制线条长度等的比例。 |
| `p.Chaos.Solver.DebugDraw.ShapeLineThicknessScale` | `1` | 形状lineThickness乘数。 |
| `p.Chaos.Solver.DebugDraw.ShowClient` | `1` | 绘制客户端相关调试数据 |
| `p.Chaos.Solver.DebugDraw.ShowComplex` | `false` | 是否显示已启用复杂碰撞为形状绘制 |
| `p.Chaos.Solver.DebugDraw.ShowDynamics` | `1` | 如果启用了DebugDrawShapes，是否显示动态对象 |
| `p.Chaos.Solver.DebugDraw.ShowKinematics` | `1` | 如果启用了DebugDrawShapes，是否显示运动学对象 |
| `p.Chaos.Solver.DebugDraw.ShowLevelSet` | `true` | 是否显示已启用关卡集碰撞为形状绘制 |
| `p.Chaos.Solver.DebugDraw.ShowServer` | `1` | 绘制服务器相关调试数据 |
| `p.Chaos.Solver.DebugDraw.ShowSimple` | `true` | 是否显示已启用简单碰撞为形状绘制 |
| `p.Chaos.Solver.DebugDraw.ShowStatics` | `1` | 如果启用了DebugDrawShapes，是否显示静态对象 |
| `p.Chaos.Solver.DebugDraw.VelScale` | `0` | 如果>0，在绘制粒子变换时显示速度。 |
| `p.Chaos.Solver.DebugDrawBounds` | `0` | 在broadphase内绘制包围体（0=从不；1=帧结束）。 |
| `p.Chaos.Solver.DebugDrawBVHs` | `0` | 如果适用，绘制粒子BVH（0=从不；1=帧结束）。 |
| `p.Chaos.Solver.DebugDrawCCDInteractions` | `0` | 绘制CCD交互。 |
| `p.Chaos.Solver.DebugDrawCCDThresholds` | `0` | 绘制CCD扫描阈值。 |
| `p.Chaos.Solver.DebugDrawCharacterGroundConstraints` | `0` | 绘制角色地面约束 |
| `p.Chaos.Solver.DebugDrawCollidingShapes` | `0` | 绘制有碰撞的形状（0=从不；1=帧结束）。 |
| `p.Chaos.Solver.DebugDrawCollisions` | `0` | 绘制碰撞（0=从不；1=帧结束）。 |
| `p.Chaos.Solver.DebugDrawIslands` | `0` | 绘制解算器岛状区（0=从不；1=帧结束）。 |
| `p.Chaos.Solver.DebugDrawJoints` | `0` | 绘制关节 |
| `p.Chaos.Solver.DebugDrawMass` | `0` | 绘制质量值，以Kg为单位（0=从不；1=帧结束）。 |
| `p.Chaos.Solver.DebugDrawMeshBVHOverlaps` | `0` | 绘制对象重叠网格体的BVH |
| `p.Chaos.Solver.DebugDrawMeshContacts` | `0` | 绘制网格体接触点 |
| `p.Chaos.Solver.DebugDrawPostIntegrationCollisions` | `0` | 在约束解析相位之前绘制碰撞。 |
| `p.Chaos.Solver.DebugDrawPostIntegrationShapes` | `0` | 在约束解析相位之前绘制形状。 |
| `p.Chaos.Solver.DebugDrawPreIntegrationCollisions` | `0` | 在集成之前绘制碰撞。 |
| `p.Chaos.Solver.DebugDrawPreIntegrationShapes` | `0` | 在集成之前绘制形状。 |
| `p.Chaos.Solver.DebugDrawShapes` | `0` | 绘制形状（0=从不；1=帧结束）。 |
| `p.Chaos.Solver.DebugDrawSleepState` | `0` | 绘制岛状区休眠状态。 |
| `p.Chaos.Solver.DebugDrawSpatialAccelerationStructure` | `0` | 绘制空间加速结构 |
| `p.Chaos.Solver.DebugDrawSpatialAccelerationStructure.ShowLeaves` | `0` | 当空间加速结构的调试绘制启用时，显示空间加速结构叶 |
| `p.Chaos.Solver.DebugDrawSpatialAccelerationStructure.ShowNodes` | `0` | 当空间加速结构的调试绘制启用时，显示空间加速结构节点 |
| `p.Chaos.Solver.DebugDrawSuspension` | `0` | 绘制暂停（0=从不；1=帧结束）。 |
| `p.Chaos.Solver.DebugDrawTransforms` | `0` | 绘制粒子变换（0=从不；1=帧结束）。 |
| `p.Chaos.Solver.Deterministic` | `1` | 重载确定性。0：禁用；1：启用；-1：使用配置 |
| `p.Chaos.Solver.DoFinalProbeNarrowPhase` | `true` |  |
| `p.Chaos.Solver.InertiaConditioning.Distance` | `20` | 惯性调节系统的输入。需要稳定的关节距离误差（产生低旋转）。 |
| `p.Chaos.Solver.InertiaConditioning.Enabled` | `true` | 通过惯性调节启用/禁用约束稳定 |
| `p.Chaos.Solver.InertiaConditioning.MaxInvInertiaComponentRatio` | `0` | 惯性调节系统的输入。最大惯性分量必须至少是最小惯性分量的最小倍数 |
| `p.Chaos.Solver.InertiaConditioning.RotationRatio` | `2` | 惯性调节系统的输入。旋转与平移的最大关节校正比 |
| `p.Chaos.Solver.IslandGroups.MaxWorkers` | `0` | 要使用的工作线程的数量上限（0表示无限制） |
| `p.Chaos.Solver.IslandGroups.MinBodiesPerWorker` | `50` | 每个工作线程需要的对象数量下限 |
| `p.Chaos.Solver.IslandGroups.MinConstraintsPerWorker` | `50` | 每个工作线程需要的约束数量下限 |
| `p.Chaos.Solver.IslandGroups.ParallelMode` | `2` | 0：单线程；1：并行；2：任务 |
| `p.Chaos.Solver.IslandGroups.WorkerMultiplier` | `1` | 解算器中的岛状区组的总数将为NumWorkerThreads x WorkerThreadMultiplier。[默认值：1] |
| `p.Chaos.Solver.Iterations.Position` | `-1` | 重载解算器位置迭代的次数（-1表示使用配置） |
| `p.Chaos.Solver.Iterations.Projection` | `-1` | 重载解算器投射迭代的次数（-1表示使用配置） |
| `p.Chaos.Solver.Iterations.Velocity` | `-1` | 重载解算器速度迭代的次数（-1表示使用配置） |
| `p.Chaos.Solver.Joint.AngleTolerance` | `0.001` | AngleTolerance。 |
| `p.Chaos.Solver.Joint.MaxInertiaRatio` | `5` | 6Dof关节MaxInertiaRatio（如果>0） |
| `p.Chaos.Solver.Joint.MaxSolverStiffness` | `1` | 最后一次迭代的解算器刚度，自MinSolverStiffness起增加每次迭代。 |
| `p.Chaos.Solver.Joint.MinParentMassRatio` | `0.2` | 6Dof关节MinParentMassRatio（如果>0） |
| `p.Chaos.Solver.Joint.MinSolverStiffness` | `1` | 第一次迭代的解算器刚度，增加每次迭代，直至MaxSolverStiffness。 |
| `p.Chaos.Solver.Joint.NumIterationsAtMaxSolverStiffness` | `1` | 在MaxSolverStiffness时需要多少迭代次数。 |
| `p.Chaos.Solver.Joint.NumShockPropagationIterations` | `0` | 启用SHockProagation需要多少迭代次数。 |
| `p.Chaos.Solver.Joint.PositionTolerance` | `0.025` | PositionTolerance。 |
| `p.Chaos.Solver.Joint.Priority` | `0` | 设置约束优先级。稍后对较大的值求值[默认值：0] |
| `p.Chaos.Solver.Joint.ShockPropagation` | `-1` | 6Dof关节冲击传播重载（如果>=0）。 |
| `p.Chaos.Solver.Joint.SolvePositionLast` | `true` | 是应按照先位置后旋转的顺序（false）还是先旋转后位置的顺序（true，默认）解析关节？ |
| `p.Chaos.Solver.Joint.TransferCollisions` | `true` | 当Joints TransferCollisionScale不为0时，允许关节从子级向父级应用碰撞[默认：true] |
| `p.Chaos.Solver.Joint.TransferCollisionsDebugTestAgainstMaxClamp` | `false` | 将所有关节碰撞约束设置强制设置为最大限制值，以验证稳定性[默认：false] |
| `p.Chaos.Solver.Joint.TransferCollisionsKinematicScale` | `1` | 应用于运动学对象之间的碰撞传输的比例[默认值：1.0] |
| `p.Chaos.Solver.Joint.TransferCollisionsLimit` | `2147483647` | 允许传输到父级的约束的数量上限。降低此值会提高性能，但会降低精确度。[默认值：INT_MAX] |
| `p.Chaos.Solver.Joint.TransferCollisionsStiffnessClamp` | `1` | 刚度限制的最大限制值[默认值：1.0] |
| `p.Chaos.Solver.Joint.UseLinearSolver` | `true` | 使用线性版本的关节解算器。（默认值为true |
| `p.Chaos.Solver.Joint.UsePBDDrives` | `true` | 是在解算器的位置还是速度相位解析驱动（默认为true |
| `p.Chaos.Solver.OneWayPairCollisionMode` | `2` | 如何处理两个单向交互粒子之间的碰撞。请参见EOneWayInteractionPairCollisionMode（0：忽略碰撞；1：作为法线碰撞；2：作为球体碰撞） |
| `p.Chaos.Solver.ParticlePoolNumFrameUntilShrink` | `30` | 直到可以缩小池时的帧数量 |
| `p.Chaos.Solver.PersistentGraph` | `true` |  |
| `p.Chaos.Solver.ShrinkArrays` | `false` | 在主场景中启用/禁用粒子数组缩小 |
| `p.Chaos.Solver.Sleep.AngularSleepThresholdSize` | `0` | 根据大小缩放角度阈值（0表示禁用基于大小的缩放） |
| `p.Chaos.Solver.Sleep.Defaults.AngularSleepThreshold` | `0.0087` | 休眠的默认角度阈值。[默认值：0.0087] |
| `p.Chaos.Solver.Sleep.Defaults.LinearSleepThreshold` | `0.001` | 休眠的默认线性阈值。[默认值：0.001] |
| `p.Chaos.Solver.Sleep.Defaults.SleepCounterThreshold` | `20` | 休眠的默认计数器阈值。[默认值：20] |
| `p.Chaos.Solver.Sleep.Enabled` | `true` |  |
| `p.Chaos.Solver.Sleep.IsolatedParticle.AngularMultiplier` | `1` | 应用于浮动粒子的SleepAngularThreshold的乘数 |
| `p.Chaos.Solver.Sleep.IsolatedParticle.CounterMultiplier` | `1` | 应用于浮动粒子的SleepCounterThreshold的乘数 |
| `p.Chaos.Solver.Sleep.IsolatedParticle.LinearMultiplier` | `1` | 应用于浮动粒子的SleepLinearThreshold的乘数 |
| `p.Chaos.Solver.Suspension.Priority` | `0` | 设置约束优先级。稍后对较大的值求值[默认值：0] |
| `p.Chaos.Solver.TestMode.Enabled` | `false` |  |
| `p.Chaos.Solver.TestMode.ShowInitialTransforms` | `false` |  |
| `p.Chaos.Solver.TestMode.Step` | `0` |  |
| `p.Chaos.Solver.UseCCD` | `true` | 用于打开或关闭CCD的全局标记。默认值为true（打开） |
| `p.Chaos.Solver.UseMACD` | `true` | 用于打开或关闭运动感知碰撞检测（MACD）的全局标记。默认值为true（打开） |
| `p.Chaos.Solver.UseParticlePool` | `true` | 是否使用脏粒子池（优化） |
| `p.Chaos.Spherical.ISPC` | `true` | 是否在球体约束中使用ISPC优化 |
| `p.Chaos.Spring.ISPC` | `true` | 是否在弹性约束中使用ISPC优化 |
| `p.Chaos.Spring.ParallelConstraintCount` | `100` | 如果有更多约束，在Apply中使用parallel-for。 |
| `p.Chaos.SQ.DrawDebugVisitorQueries` | `0` | 在场景查询中绘制访客所访问对象的边界。 |
| `p.Chaos.Suspension.DebugDraw.Hardstop` | `false` | 调试绘制暂停硬停流形 |
| `p.Chaos.Suspension.Hardstop.Enabled` | `true` | 启用/禁用暂停约束的硬停部分 |
| `p.Chaos.Suspension.MaxPushout` | `5` | Chaos暂停最大推出值 |
| `p.Chaos.Suspension.MaxPushoutVelocity` | `100` | Chaos暂停最大推出速度值 |
| `p.Chaos.Suspension.SlopeSpeedBlendThreshold` | `10` | 低于此速度将启动斜面混合机制上的抗滑功能 |
| `p.Chaos.Suspension.SlopeSpeedThreshold` | `1` | 低于此速度将全面采用斜面机制上的抗滑功能 |
| `p.Chaos.Suspension.SlopeThreshold` | `0.707` | 低于此斜面阈值将采用斜面机制上的抗滑功能，值=Cos(AlopeAngle)，即50度斜面=0.6428，30度斜面=0.866 |
| `p.Chaos.Suspension.Spring.Enabled` | `true` | 启用/禁用暂停约束的弹性部分 |
| `p.Chaos.Suspension.VelocitySolve` | `true` | 启用/禁用VelocitySolve |
| `P.Chaos.SyncKinematicOnGameThread` | `-1` | 如果设置为1，运动学对象将始终将它们的变换发送回游戏线程，遵循模拟步骤/结果。如果为0，则它们从不会执行此操作，并且设置运动学目标后，将立即更新运动。任何其他值（例如默认值-1）意味着，行为是基于BodyInstance中的UpdateKinematicFromSimulation标记在每个对象上确定的。 |
| `p.Chaos.Thread.DesiredHz` | `60` | 专用物理线程所需的更新速率，以Hz/FPS为单位（默认60.0f） |
| `p.Chaos.Thread.WaitThreshold` | `0` | 在游戏线程停止等待同步物理并获取最后结果之前，所需的等待时间，以毫秒为单位。（默认值16毫秒） |
| `p.Chaos.Timestep.VariableCapped.Cap` | `0.0667` | 当使用Chaos的范围时间步长时，设置为上限的时间，以秒为单位。 |
| `p.Chaos.TriangleIntersections.MaxDelta` | `0.01` | 用于解析三角形相交的最大增量位置。 |
| `p.Chaos.TriangleMesh.ISPC` | `true` | 是否在三角形网格体计算中使用ISPC优化 |
| `p.Chaos.TriMeshPerPolySupport` | `true` | 禁用将移除三角形网格体上顶点贴图的内存开销。注意：在运行时更改将不起作用。 |
| `P.Chaos.UpdateKinematicsOnDeferredSkelMeshes` | `1` | 是否延迟骨骼网格体的运动学更新。 |
| `p.chaos.UseContactSpeedForStrainEval` | `true` | 更新群集张力时是否使用接触点速度丢弃接触点（true：使用速度，false：使用冲量） |
| `p.Chaos.UseRBANForDefaultPhysicsAssetSolverType` | `false` | 布尔值，用于使用RBAN作为默认物理资产解算器类型（默认为false） |
| `p.Chaos.VD.CompressBinaryData` | `false` | 如果为true，序列化二进制数据将在追踪前使用动态Oodle进行压缩 |
| `p.Chaos.VD.CompressionMode` | `2` | 要使用的Oodle压缩模式，4为默认值，它相当于ECompressionLevel::VeryFast |
| `p.Chaos.VD.TimeBetweenFullCaptures` | `10` | 时间间隔，以秒为单位，在此间隔之后应记录完整捕获（不仅仅是增量变化） |
| `p.Chaos.VD.Tool.BroadcastGameFrameUpdateEvenIfNotChanged` | `false` | 如果为true，每次获得控制器数据更新事件时，将触发游戏帧更新，即使帧不变…… |
| `p.Chaos.VD.Tool.DisableUVsSupport` | `true` | 如果为true，生成的网格体将没有UV数据 |
| `p.Chaos.VD.Tool.ForceStaticMeshComponentUse` | `false` | 如果为true，在为每个粒子重新创建几何体时，将使用静态网格体组件，而不是实例化静态网格体组件 |
| `p.Chaos.VD.Tool.GeometryToProcessPerTick` | `200` | 在CVD工具中加载teace文件时，每次刷新要处理的生成几何体数量。 |
| `p.Chaos.VD.Tool.MaxDebugDrawLinesPerFrame` | `300000` | 设置在单帧中CVD允许在所有实例之间绘制的最大行数。 |
| `p.Chaos.VD.Tool.PlayAllPreviousFrameSteps` | `true` | 如果为true，每次在特定阶段中播放解算器帧时，将按顺序播放该帧的所有之前步骤，以确保对该帧发生的事件有正确的可视化。 |
| `p.Chaos.VD.Tool.QueueAndCombineSceneOutlinerEvents` | `true` | 如果设置为true，场景大纲视图事件将排队并每帧发送一次。如果某个项目存在未处理事件，最后一个排队的事件将替换它 |
| `p.Chaos.VD.Tool.UseComponentsPool` | `true` | 设置为false，将禁用网格体组件的池系统的使用。 |
| `p.Chaos.VD.Tool.UseCVDDynamicMeshGenerator` | `true` | 如果为true，当从网格体生成器创建动态网格体时，CVD将使用其自己的网格体创建逻辑，其中包括尝试修复断开几何体的错误处理 |
| `p.Chaos.VelocityField.ISPC` | `true` | 是否在速度场计算中使用ISPC优化 |
| `p.Chaos.VelocityField.MaxVelocity` | `0` | 处理气动力的最大相对速度。 |
| `p.Chaos.VisualDebuggerEnable` | `1` | 启用/禁用向视觉调试器推送/保存数据 |
| `p.Chaos.XPBDBending.ISPC` | `true` | 是否在XPBD弯曲约束中使用ISPC优化 |
| `p.Chaos.XPBDBending.ISPC.MinNumParallelBatches` | `1028` | 调用parallelFor ISPC XPBDBending约束的最小批处理数 |
| `p.Chaos.XPBDBending.ISPC.ParallelBatchSize` | `1028` | ISPC XPBDBending约束的并行批处理大小 |
| `p.Chaos.XPBDBending.ParallelConstraintCount` | `100` | 如果有更多约束，在Apply中使用parallel-for。 |
| `p.Chaos.XPBDBending.SplitLambdaDamping` | `true` | 使用拆分的双通道阻尼模型（较慢，但在高阻尼级别下不会使布料过软）。 |
| `p.Chaos.XPBDSpring.ISPC` | `true` | 是否在XPBD弹性约束中使用ISPC优化 |
| `p.Chaos.XPBDSpring.ParallelConstraintCount` | `100` | 如果有更多约束，在Apply中使用parallel-for。 |
| `p.Chaos.XPBDSpring.SplitDamping` | `4` | 测试xpbd弹性拆分阻尼模式。0=单个lambda，1=之后与阻尼交错（仅非ispc），2=之前与阻尼交错（仅非ispc），3=之后双通道阻尼（仅非ispc），4=之前双通道阻尼（默认）。 |
| `p.Chaos.XPBDStretchBias.ISPC` | `true` | 是否在XPBD拉伸偏差约束中使用ISPC优化 |
| `p.ChaosCloth.DebugDrawAmimNormals` | `false` | 是否调试绘制动画/运动学布料法线 |
| `p.ChaosCloth.DebugDrawAnimDrive` | `false` | 是否调试绘制Chaos布料动画驱动 |
| `p.ChaosCloth.DebugDrawAnimMeshWired` | `false` | 是否调试绘制动画/运动学布料线框网格体 |
| `p.ChaosCloth.DebugDrawBackstopDistances` | `false` | 是否调试绘制Chaos布料逆止距离 |
| `p.ChaosCloth.DebugDrawBackstops` | `false` | 是否调试绘制Chaos布料逆止 |
| `p.ChaosCloth.DebugDrawBendingConstraint` | `false` | 是否调试绘制Chaos布料弯曲约束 |
| `p.ChaosCloth.DebugDrawBounds` | `false` | 是否调试绘制Chaos布料边界 |
| `p.ChaosCloth.DebugDrawCollision` | `false` | 是否调试绘制Chaos布料碰撞 |
| `p.ChaosCloth.DebugDrawEdgeConstraint` | `false` | 是否调试绘制Chaos布料边缘约束 |
| `p.ChaosCloth.DebugDrawFaceNormals` | `false` | 是否调试绘制Chaos布料面法线 |
| `p.ChaosCloth.DebugDrawGravity` | `false` | 是否调试绘制Chaos布料重力加速度向量 |
| `p.ChaosCloth.DebugDrawInversedFaceNormals` | `false` | 是否调试绘制Chaos布料反向面法线 |
| `p.ChaosCloth.DebugDrawLocalSpace` | `false` | 是否调试绘制Chaos布料局部空间 |
| `p.ChaosCloth.DebugDrawLongRangeConstraint` | `false` | 是否调试绘制Chaos布料长距离约束（即系链约束） |
| `p.ChaosCloth.DebugDrawMaxDistances` | `false` | 是否调试绘制Chaos布料最大距离 |
| `p.ChaosCloth.DebugDrawPhysMeshWired` | `false` | 是否调试绘制Chaos布料线框网格体 |
| `p.ChaosCloth.DebugDrawPointNormals` | `false` | 是否调试绘制Chaos布料点法线 |
| `p.ChaosCloth.DebugDrawPointVelocities` | `false` | 是否调试绘制Chaos布料点速度 |
| `p.ChaosCloth.DebugDrawSelfCollision` | `false` | 是否调试绘制Chaos布料自碰撞信息 |
| `p.ChaosCloth.DebugDrawSelfIntersection` | `false` | 是否调试绘制Chaos布料自相交信息 |
| `p.ChaosCloth.DebugDrawWindForces` | `false` | 是否调试绘制Chaos布料风力 |
| `p.ChaosCloth.GravityMultiplier` | `1` | 在布料重力公式化的最后阶段应用的标量乘数。 |
| `p.ChaosCloth.LegacyDisablesAccurateWind` | `true` | 是使用旧版风模型关闭准确的风模型，还是增加它 |
| `p.ChaosCloth.Solver.DebugHitchInterval` | `0` | 卡顿间隔，以帧为单位。创建人工卡顿以调试模拟抖动。0表示禁用 |
| `p.ChaosCloth.Solver.DebugHitchLength` | `0` | 卡顿长度，以毫秒为单位。创建人工卡顿以调试模拟抖动。0表示禁用 |
| `p.ChaosCloth.Solver.DisableCollision` | `false` | 禁用所有碰撞粒子。需要重置模拟（p.ChaosCloth.Reset）。 |
| `p.ChaosCloth.Solver.DisableTimeDependentNumIterations` | `false` | 使迭代次数独立于时间步长。 |
| `p.ChaosCloth.Solver.MaxVelocity` | `0` | 布料粒子相对于其动画位置等效的最大相对速度。0表示禁用。 |
| `p.ChaosCloth.Solver.MinParallelBatchSize` | `1000` | 解算器在并行批处理中要处理的粒子数下限。 |
| `p.ChaosCloth.Solver.ParallelClothPostUpdate` | `true` | 并行预变换每块布料的布料粒子。 |
| `p.ChaosCloth.Solver.ParallelClothPreUpdate` | `true` | 并行预变换每块布料的布料粒子。 |
| `p.ChaosCloth.Solver.ParallelClothUpdate` | `true` | 对物理网格体进行蒙皮，并为每个布料并行执行其他布料更新。 |
| `p.ChaosCloth.Solver.UseVelocityScale` | `true` | 使用速度范围补偿对MaxPhysicsDelta的限制，以避免在卡顿期间算错速度。 |
| `p.ChaosCloth.UseOptimizedTaperedCapsule` | `true` | 使用优化的TaperedCapsule代码，而不是使用锥形圆柱体和两个球体 |
| `p.ChaosCloth.UseTimeStepSmoothing` | `true` | 使用时间步长平滑，避免时间步长剧烈变化时发生抖动。 |
| `p.ChaosClothEditor.DebugDrawAnimDrive` | `false` | 绘制当前蒙皮引用网格体用于模拟，如果启用，动画驱动将尝试达到 |
| `p.ChaosClothEditor.DebugDrawAnimMeshWired` | `false` | 绘制线框中的当前动画网格体输入 |
| `p.ChaosClothEditor.DebugDrawAnimNormals` | `false` | 绘制动画网格体的当前点法线 |
| `p.ChaosClothEditor.DebugDrawBackstopDistances` | `false` | 绘制每个模拟粒子的逆止距离偏移 |
| `p.ChaosClothEditor.DebugDrawBackstops` | `false` | 绘制每个模拟粒子的逆止半径和位置 |
| `p.ChaosClothEditor.DebugDrawBendingConstraint` | `false` | 绘制弯曲弹性约束 |
| `p.ChaosClothEditor.DebugDrawCollision` | `false` | 绘制模拟当前正在使用的碰撞对象 |
| `p.ChaosClothEditor.DebugDrawEdgeConstraint` | `false` | 绘制边缘弹性约束 |
| `p.ChaosClothEditor.DebugDrawElementIndices` | `false` | 按照被解算器实例化的方式绘制元素（三角形或其他）索引 |
| `p.ChaosClothEditor.DebugDrawLocalSpace` | `false` | 绘制局部空间参考骨骼 |
| `p.ChaosClothEditor.DebugDrawLongRangeConstraint` | `false` | 绘制长距离附加约束距离 |
| `p.ChaosClothEditor.DebugDrawMaxDistances` | `false` | 将模拟粒子的当前最大距离绘制为沿法线的线条 |
| `p.ChaosClothEditor.DebugDrawMaxDistanceValues` | `false` | 将当前最大距离绘制为数字 |
| `p.ChaosClothEditor.DebugDrawParticleIndices` | `false` | 按照被解算器实例化的方式绘制粒子索引 |
| `p.ChaosClothEditor.DebugDrawPhysMeshShaded` | `false` | 将当前物理结果绘制为双面扁平阴影网格体 |
| `p.ChaosClothEditor.DebugDrawPhysMeshWired` | `false` | 绘制线框中的当前物理网格体结果 |
| `p.ChaosClothEditor.DebugDrawPointNormals` | `false` | 绘制模拟网格体的当前点法线 |
| `p.ChaosClothEditor.DebugDrawPointVelocities` | `false` | 绘制模拟网格体的当前点速度 |
| `p.ChaosClothEditor.DebugDrawSelfCollision` | `false` | 绘制自碰撞厚度/调试信息 |
| `p.ChaosClothEditor.DebugDrawSelfIntersection` | `false` | 绘制自相交轮廓/区域信息 |
| `p.ChaosClothEditor.DebugDrawWindAndPressureForces` | `false` | 绘制风阻力、升力和压力 |
| `p.ChaosClothVisualization.AnisoSpringDrawMode` | `0` | 拉伸绘制模式，0=并行图表颜色，1=各向异性 |
| `p.ChaosClothVisualization.BendingDrawMode` | `0` | 弯曲绘制模式，0=BuckleStatus，1=并行图表颜色，2=各向异性，3=RestAngle |
| `p.ChaosClothVisualization.DrawSkinnedLattice` | `0` | 绘制蒙皮格栅，0=无，1=充满，2=空，3=两者 |
| `p.ChaosClothVisualization.StretchBiasDrawMode` | `0` | 拉伸绘制模式，0=并行图表颜色，1=扭曲拉伸，2=纬向拉伸，3=BiasStretch |
| `p.ChaosClothVisualization.StretchBiasDrawOutOfRange` | `true` | 绘制超出范围元素（当绘制扭曲/纬向拉伸时） |
| `p.ChaosClothVisualization.StretchBiasDrawRangeMax` | `1` | 绘制颜色范围的最大拉伸。负值=已压缩，0=没有变形，正值=已拉伸。（当绘制扭曲/纬向拉伸时） |
| `p.ChaosClothVisualization.StretchBiasDrawRangeMin` | `-1` | 绘制颜色范围的最小拉伸。负值=已压缩，0=没有变形，正值=已拉伸。（当绘制扭曲/纬向拉伸时） |
| `p.ChaosClothVisualization.WeightMapName` |  | 要可视化的权重贴图名称 |
| `p.ChaosNumContactIterationsOverride` | `-1` | 如果>=0，重载接触点迭代次数。[默认值：-1] |
| `p.ChaosNumPushOutIterationsOverride` | `-1` | 如果>=0，重载推出迭代次数[默认值：-1] |
| `p.ChaosRigidsEvolutionApplyAllowEarlyOut` | `1` | 当解析时，允许Chaos刚体演变应用迭代提前退出。[默认值：1] |
| `p.ChaosRigidsEvolutionApplyPushoutAllowEarlyOut` | `1` | 当解析时，允许Chaos刚体演变应用-推出迭代提前退出。[默认值：1] |
| `p.ChaosSolverEnableJointConstraints` | `true` | 启用物理资源编辑器中定义的关节约束 |
| `p.CharacterStuckWarningPeriod` | `1` | 允许多久记录一条有关几何体卡住的消息，以秒为单位。 <0：禁用，>=0：启用并按此频率记录，以秒为单位。 |
| `p.checkbox` | `1` |  |
| `p.ClientAuthorityThresholdOnBaseChange` | `0` | 当Pawn移向或移离移动基座时，这可能会导致突然校正。在这些情况下，信任客户端到服务器组件位置的距离。 |
| `p.ClosestIntersectionStepSizeMultiplier` | `0.5` | 当光线投射时，使用此乘数沿着光线分步行进距离。数值越小，精度越高，开销越高 |
| `p.Cloth.DefaultClothingSimulationFactoryClass` | `ChaosClothingSimulationFactory` | 默认布料模拟工厂的类名称。 已知提供者为： ChaosClothingSimulationFactory |
| `p.Cloth.MaxDeltaTimeTeleportMultiplier` | `1.5` | MaxPhysicsDelta时间的乘数，此时，自动将布料传送到其新位置 默认值：1.5 |
| `p.Cloth.MaxVelocityScale` | `1` | 所有布料上允许的最大组件感应速度。 使用1.0表示完全感应速度（默认），或者使用0.0表示无感应速度，介于两者之间的任何其他值表示降低的感应速度。 当设置为0.0时，它还提供一种强制布料在局部空间进行模拟的方式。 默认值：1.0 |
| `p.Cloth.ResetAfterTeleport` | `true` | 需要p.Cloth.TeleportOverride。在移动布料位置后重置布料（调用了传送）。 默认值：true。 |
| `p.Cloth.TeleportDistanceThreshold` | `300` | 需要p.Cloth.TeleportOverride。如果在1帧中角色的移动大于此阈值，将执行传送。 零或负值将跳过此检查。 默认值：300. |
| `p.Cloth.TeleportOverride` | `false` | 强制控制台变量传送重载值优先于骨架网格属性。 默认值：false。 |
| `p.Cloth.TeleportRotationThreshold` | `0` | 需要p.Cloth.TeleportOverride。旋转阈值，范围为0到180，以度为单位。 如果在1帧中角色的旋转大于此阈值，将执行传送。 零或负值将跳过此检查。 默认值为0。 |
| `p.ClothPhysics` | `1` | 如果为1，物理布料将用于模拟。 |
| `p.ClothPhysics.UseTaskThread` | `1` | 如果为1，在任务线程上运行布料。如果为0，在游戏线程上运行。 |
| `p.ClothPhysics.WaitForParallelClothTask` | `0` | 如果为1，始终等待布料刷新函数中布料任务的完成。如果为0，如果组件设置允许，等待帧结束时更新 |
| `p.ClusterDistanceThreshold` | `100` | 群集子级必须距离接触点多近才会断开 |
| `p.Clustering.ParticleReleaseThrottlingMaxCount` | `-1` | 在所有释放群集立即禁用所有释放粒子之前，要达到的激活几何体集合的数量上限 |
| `p.Clustering.ParticleReleaseThrottlingMinCount` | `-1` | 在群集开始禁用每个群集一定百分比释放粒子之前，要达到的激活几何体集合的数量下限 |
| `p.ClusterSnapDistance` | `1` |  |
| `p.ClusterUnion.SyncBodiesMoveNewComponents` | `true` | 启用修复以确保在添加时移动群集并集中的新组件（即使群集没有移动）。 |
| `p.CollisionAngularFriction` | `-1` | 如果>=0，所有接触点的碰撞角摩擦 |
| `p.CollisionBaseFrictionImpulse` | `-1` | 如果>=0，所有接触点的碰撞基础位置冲量 |
| `p.CollisionCanAlwaysDisableContacts` | `0` | 碰撞剔除将始终能够永久禁用接触点 |
| `p.CollisionCanNeverDisableContacts` | `0` | 碰撞剔除将始终无法永久禁用接触点 |
| `p.CollisionDisableCulledContacts` | `0` | 如果被剔除，允许PBDRigidsEvolutionGBF碰撞约束丢弃接触点mid解析。 |
| `p.CollisionFriction` | `-1` | 如果>=0，所有接触点的碰撞摩擦 |
| `p.CollisionParticlesBVHDepth` | `4` | 碰撞粒子bvh的最大深度 |
| `p.CollisionParticlesMax` | `2000` | 单纯裁剪后的粒子数量上限 |
| `p.CollisionParticlesMin` | `10` | 单纯裁剪后的粒子数量下限（假设一开始有更多） |
| `p.CollisionParticlesPerObjectFractionDefault` | `1` | 顶点部分 |
| `p.CollisionParticlesSpatialDivision` | `10` | 用于剔除碰撞粒子的空间分桶。 |
| `p.CollisionParticlesUseImplicitCulling` | `0` | 使用隐式剔除内部顶点。 |
| `p.CollisionRestitution` | `-1` | 如果>=0，所有接触点的碰撞恢复 |
| `p.CollisionRestitutionThreshold` | `-1` | 如果>=0，碰撞恢复阈值重载（加速单位） |
| `p.ComNudgeAffectsInertia` | `true` |  |
| `p.ComputeClusterCollisionStrains` | `1` | 处理群集时是否使用碰撞约束。 |
| `p.ConstraintAngularDampingScale` | `100000` | 模拟中约束角阻尼的乘数。默认值：100000 |
| `p.ConstraintAngularStiffnessScale` | `100000` | 模拟中约束角刚度的乘数。默认值：100000 |
| `p.ConstraintBPBVHDepth` | `2` | 约束bvh的最大深度 |
| `p.ConstraintLinearDampingScale` | `1` | 模拟中约束线性阻尼的乘数。默认值：1 |
| `p.ConstraintLinearStiffnessScale` | `1` | 模拟中约束线性刚度的乘数。默认值：1 |
| `p.ContactOffsetFactor` | `-1` | 乘以对象的最小尺寸，用于计算对象在距离多近之后才会产生接触。< 0表示使用项目设置。默认值：0.01 |
| `p.CVarGeometryCollectionImpulseWorkAround` | `true` | 它启用了一种允许将冲量应用于几何体集合的解决办法。 |
| `p.DeactivateClusterChildren` | `0` | 如果子级损坏，是否应将子级取消激活并将其放入另一个群集中。 |
| `p.DebugTimeDiscrepancy` | `0` | 是否记录testing0的详细运动时间差异值：禁用，1：启用检测日志记录，2：启用检测和解决方案日志记录 |
| `p.DefaultCollisionFriction` | `0` | 碰撞摩擦默认值（如果未找到材质）。 |
| `p.DefaultCollisionRestitution` | `0` | 碰撞恢复默认值（如果未找到材质）。 |
| `p.DeferCharacterMeshMovement` | `false` | 优化-启用后延迟CharacterMesh移动传播，直到更大范围移动结束。网格体仍会移动，但所有附加组将等待，直到范围内所有网格体移动完成。 |
| `p.DeferCharacterMeshMovementForAllCorrections` | `true` | 优化-启用后延迟所有校正的CharacterMesh移动传播，直到更大范围移动结束。需要 `bDeferCharacterMeshMovement=true` 。 |
| `p.DisableEditorPhysicsHandle` | `false` | 当为true时，禁用在PIE中拖动对象的物理弹性。改用传送。 |
| `p.DisableParticleUpdateVelocityParallelFor` | `0` | 禁用粒子更新速度ParallelFor，并在单个线程上运行更新 |
| `p.DisableQueryOnlyActors` | `0` | 如果使用QueryOnly，将Actor标记为模拟禁用。目前，这与原点偏移不兼容。 |
| `p.DisableThreshold2` | `5` | 禁用阈值帧以过渡到休眠 |
| `p.EnableCollisions` | `1` | 在Chaos解算器中启用/禁用碰撞。 |
| `p.EnableDeferredPhysicsCreation` | `0` | 启用/禁用延迟物理创建。 |
| `p.EnableDynamicPerBodyFilterHacks` | `0` | 启用/禁用一组游戏集中破解方法的使用-允许用户动态修改骨架体碰撞（更改每个骨架体碰撞过滤的行为）。 |
| `p.EnableFastOverlapCheck` | `1` | 针对扫描命中，启用快速重叠检查，避免UpdateOverlaps（对于扫描组件）。 |
| `p.EnableKinematicDeferralPrePhysicsCondition` | `1` | 如果为1且由于EUpdateTransformFlags不允许延迟，如果在PrePhysics刷新中将允许。如果为0，条件将不变。 |
| `p.EnableKinematicDeferralStartPhysicsCondition` | `1` | 如果为1，start physics中将允许延迟运动学（可能仅从复制刷新调用）。如果为0，startphysics中将没有延迟。 |
| `p.EnableMeshClean` | `1` | 在烘焙期间启用/禁用网格体清理。 |
| `p.EnableMultiplayerWorldOriginRebasing` | `0` | 启用多玩家世界原点基址重置，这意味着服务器和客户端可以有不同的世界原点位置。 |
| `p.EnableOverrideSolverDeltaTime` | `true` | 如果为true，可以使用重载解算器增量时间的设置。 False，将禁用此功能。 |
| `p.EnableSkeletalMeshConstraints` | `true` | 启用物理资源编辑器中定义的骨骼网格体约束 |
| `p.EncroachEpsilon` | `0.15` | 在形状组件侵占检查期间使用的Epsilon值 0：使用全尺寸的形状。>0：按此数量缩小形状大小（世界单位） |
| `p.EnsureUnweldModifiesGTOnly` | `0` | 确保开焊是否修改物理线程共享的几何体 |
| `p.ErrorAccumulationDistanceSq` | `-1` |  |
| `p.ErrorAccumulationSeconds` | `-1` |  |
| `p.ErrorAccumulationSimilarity` | `-1` |  |
| `p.ErrorPerAngularDifference` | `-1` |  |
| `p.ErrorPerLinearDifference` | `-1` |  |
| `p.FindAllIntersectionsSingleThreaded` | `1` |  |
| `p.FixBadAccelerationStructureRemoval` | `1` |  |
| `p.FixReplayOverSampling` | `1` | 如果为1，删除由于过采样（以比物理更快的速率进行采样）而可能发生的无效重播示例。 |
| `p.ForceDisableAsyncPhysics` | `0` | 是否强制关闭异步物理，而无论其他设置如何 |
| `p.ForceJumpPeakSubstep` | `1` | 如果为1，强制跳跃分步始终达到跳跃的峰值位置，这通常会随着帧率的降低而被中断。 |
| `p.ForceNoCollisionIntoSQ` | `0` | 启用后，所有粒子将以sq结构结束，没有碰撞的粒子也不例外 |
| `p.ForceStandardSQ` | `0` | 启用后，即使启用了自定义SQ结构，也会强制执行标准场景查询 |
| `p.fracture.ValidateResultsOfEditOperations` | `0` | 打开后，这将实现破裂工具编辑操作的结果验证（对于大型几何图形收集可能很慢）[默认值：0] |
| `p.gc.BuildGeometryForChildrenOnGT` | `true` | 如果为true，将在初始化时在游戏线程上构建所有子几何体，否则将等到销毁。 |
| `p.gc.BuildGeometryForChildrenOnPT` | `true` | 如果为true，将在初始化时在物理线程上构建所有子几何体，否则将等到销毁。 |
| `p.gc.CreateGTParticlesForChildren` | `true` | 如果为true，将在初始化时创建所有子粒子，否则将等到销毁。 |
| `p.gc.GlobalMaxSimulatedLevel` | `100` | 允许为几何体集合设置全局最大模拟级别。将使用MaxSimulatedLevel与GlobalMaxSimulatedLevel之间的最小值。 |
| `p.gc.logcachereduction` | `0` | 记录处理后从缓存中删除的数据量 |
| `p.gc.RemoveImplicitsInDynamicCollections` | `false` | 此控制台变量仅在没有为子级添加几何体时才有影响。它从动态集合中删除隐式，并从其余集合中重新创建。如果从GT上的动态集合更新几何体，使用此控制台变量可能会产生影响，这些更改将不会传输到PT上。 |
| `p.gc.ReportHighParticleFraction` | `-1` | 报告任何粒子部分超过此阈值的对象 |
| `p.gc.ReportNoLevelsetCluster` | `0` | 报告任何没有关卡集的群集对象 |
| `p.gc.UseLargestClusterToComputeRelativeSize` | `false` | 使用最大群集作为相对大小的参考，而不是最大子级（默认值：false） |
| `p.gc.UseVolumeToComputeRelativeSize` | `false` | 使用体积计算RelativeSize，而不是立方体积的边（默认值：false） |
| `p.GeometryCollection.AlwaysGenerateConnectionGraph` | `false` | 启用后，始终生成群集的连接图表，而不是使用存储的其余集合-注意：这仅应用于故障排除。[默认值：false] |
| `p.GeometryCollection.AlwaysGenerateGTCollisionForClusters` | `true` | 启用后，始终为群集生成游戏线程侧面碰撞[默认值：true] |
| `p.GeometryCollection.AreaBasedDamageThresholdMode` | `0` | 基于区域的伤害阈值计算模式（0：区域的总和，1：区域的最大值，2：区域的最小值，3：区域的平均值）[默认值：0] |
| `p.GeometryCollection.EnabledNestedChildTransformUpdates` | `true` | 启用驱动、禁用和子级对象的更新。用于针对几何体集合的线路追踪结果。[默认值：true] |
| `p.GeometryCollection.ForceOverrideGCCollisionSetupForTraces` | `-1` | 当创建新的垃圾回收物理表示时，对游戏线程上的追踪强制使用特定类型的碰撞（-1：使用属性的值；0：强制使用SM碰撞，1：强制使用垃圾回收碰撞）[默认值：-1] |
| `p.GeometryCollection.LocalInertiaDropOffDiagonalTerms` | `0` | 当为true时，通过简单地丢弃非对角项，就可以在垃圾回收的局部空间中强制垃圾回收的对角惯性 |
| `p.GeometryCollection.PositionUpdateTolerance` | `0.0001` | 当PT同步到GT时，用于检测粒子位置是否改变的公差已经改变 |
| `p.GeometryCollection.PropagateInternalClusterDisableFlagToChildren` | `true` | 启用后，禁用的内部群集将在缓冲时将它们的禁用标记传播给它们的子群集，而不是隐式激活子群集。 |
| `p.GeometryCollection.RotationUpdateTolerance` | `0.0001` | 当PT同步到GT时，用于检测粒子旋转是否改变的公差已经改变 |
| `p.GeometryCollection.ScaleClusterGeometry` | `true` | 启用后，如果比例发生改变，将更新群集几何体 |
| `p.GeometryCollection.TransformTolerance` | `0.001` | 用于检测变换是否改变的公差 |
| `p.GeometryCollection.UseRootBrokenFlag` | `true` | 启用后，检查代理中的根变换是否损坏，如果是，将禁用GT粒子。应启用-控制台变量是恢复行为的故障安全 |
| `p.GeometryCollectionAlwaysRecreateSimulationData` | `false` | 始终重新创建模拟数据，即使模拟数据没有标记为脏数据-这在编辑器中有运行时开销-仅在默认值有问题时才用作最后的手段[默认值：false] |
| `p.GeometryCollectionAssetForceStripOnCook` | `false` | 当所有形体都已缓存以供播放时，将绕过模拟属性的构造。 |
| `p.GeometryCollectionCollideAll` | `false` | 将绕过碰撞矩阵，让几何体集合与所有对象碰撞 |
| `p.GeometryCollectionDisableGravity` | `false` | 禁用几何体集合的重力 |
| `p.GeometryCollectionEnableForcedConvexGenerationInSerialize` | `true` | 允许在旧的销毁文件上生成凸包几何体。[默认值：true] |
| `p.GeometryCollectionHardMissingUpdatesSnapThreshold` | `20` | 确定在触发硬对齐之前有多少更新缺失 |
| `p.GeometryCollectionHardsnapThresholdMs` | `20` | 确定自上次硬对齐以来经过多少毫秒才触发新的硬对齐 |
| `p.GeometryCollectionNavigationSizeThreshold` | `20` | 用于阈值的大小，此阈值用于确定是否收集和导出集合中的几何体以用于寻路，以厘米为单位。以叶节点边界的对角线测量。 |
| `p.GeometryCollectionRepAngularMatchTime` | `0.5` | 角度与复制的目标角度匹配的速度，以秒为单位 |
| `p.GeometryCollectionRepLinearMatchStrength` | `50` | 单位可以解释为%/s^2-线性校正百分比的加速度 |
| `p.GeometryCollectionRepMaxExtrapolationTime` | `3` | 对于垃圾回收外插值速度，复制的物理数据将持续存在的秒数 |
| `p.GeometryCollectionSingleThreadedBoundsCalculation` | `false` | [仅调试]单线程边界计算。[默认值：false] |
| `p.GraphPropagationBasedCollisionFactor` | `1` | 当p.GraphPropagationBasedCollisionImpulseProcessing打开时，分配到连接件的剩余损坏的百分比[0-1] |
| `p.GraphPropagationBasedCollisionImpulseProcessing` | `0` | 当处理碰撞冲量计算张力时，从碰撞点选择最近的子级，并使用连接图表进行传播[默认值：0] |
| `p.HackMaxAngularVelocity` | `1000` | 角速度的最大限制：rad/s。这仅是临时解决方案，不应作为一项功能进行依赖。-1.f，禁用 |
| `p.HackMaxVelocity2` | `-1` | 速度的最大限制：cm/s。这仅是临时解决方案，不应作为一项功能进行依赖。-1.f，禁用 |
| `p.HitDistanceTolerance` | `0` | PrimitiveComponent移动中重叠测试的命中距离公差。 将忽略小于此距离的命中。 |
| `p.IgnoreAnalyticCollisionsOverride` | `0` | 重载忽略分析碰撞的默认值。 |
| `p.InitialOverlapTolerance` | `0` | PrimitiveComponent移动中初始重叠测试的公差。 如果移出对象，将忽略此公差范围内的法线。 移动方向和表面法线的点积。 |
| `p.IterationsPerTimeSlice` | `4000` |  |
| `p.KinematicDeferralCheckValidBodies` | `true` | 如果为true，不要尝试更新正在等待删除的延迟运动学骨骼网格体。 |
| `p.KinematicDeferralLogInvalidBodies` | `false` | 如果为true，且p.KinematicDeferralCheckValidBodies为true，在运动学更新时记录发现无效对象的时间。 |
| `p.KinematicDeferralUpdateExternalAccelerationStructure` | `false` | 如果为true，在执行延迟的运动学更新之前，处理PendingSpatialOperations_External中的任何操作。 |
| `p.LevelSetAvgAngleErrorTolerance` | `1` | 网格体法线和计算法线在关卡集中的平均误差。 |
| `p.LevelSetAvgDistErrorTolerance` | `1` | 三角形和生成关卡集之间的平均距离的容错度。 注意，这是平均边界框尺寸的一小部分。 |
| `p.LevelSetFailureOnHighError` | `0` | 在解算器中将高误差的关卡集设置为空 |
| `p.LevelsetGhostCells` | `1` | 向关卡集网格增加此数量的重影单元 |
| `p.LevelSetMaxDistErrorTolerance` | `1` | 从关卡集生成的最高误差三角形的最大误差。 注意，这是平均边界框尺寸的一小部分。 |
| `p.LevelSetOutputFailedDebugData` | `0` | 当容错过高时，输出关卡集和网格体的调试obj文件 |
| `p.LevelsetOverlapCapsuleSamples` | `24` | 为关卡集-胶囊体重叠生成的螺旋点数量 |
| `p.LevelsetOverlapSphereSamples` | `16` | 为关卡集-球体重叠生成的螺旋点数量 |
| `p.LinearEtherDragOverride` | `-1` | 设置重载线性以太阻力值。-1.f，禁用 |
| `p.LinearVelocityCoefficient` | `-1` |  |
| `p.LogCorruptMap` | `0` |  |
| `p.LogDirtyParticles` | `0` | 记录每帧哪些粒子是脏的 |
| `p.LogPhysicsReplicationHardSnaps` | `0` |  |
| `p.MaxBoundsForTree` | `10000` | 将对象移动到大型对象结构之前的最大边界。仅在注册对象时应用 |
| `p.MaxChildrenInLeaf` | `5` |  |
| `p.MaxContactOffset` | `-1` | 接触偏移的最大值，可控制对象在产生接触之前的靠近程度。< 0表示使用项目设置。默认值：1.0 |
| `p.MaxDirtyElements` | `2147483647` | 脏元素的最大数量。这将强制清空，此操作的开销极大 |
| `p.MaxFallingCorrectionLeash` | `0` | 在空中时，服务器和客户端位置之间可能会保持一定距离，以避免客户端从移动基地跳起时突然进行校正。此值为最大允许距离。 |
| `p.MaxFallingCorrectionLeashBuffer` | `10` | 为了避免不断进行校正，当空中服务器与客户端之间的距离超过p.MaxFallingCorrectionLeash厘米时，它们将被拉到该距离减去此值的位置。 |
| `p.MaxLevelsetDimension` | `20` | 单个水平集轴上的单元数上限 |
| `p.MaxLinearHardSnapDistance` | `-1` |  |
| `p.MaxPayloadSize` | `100000` |  |
| `p.MaxRestoredStateError` | `-1` |  |
| `p.MaxTreeDepth` | `200` |  |
| `p.MinCleanedPointsBeforeRemovingInternals` | `10` | 如果只有这么多干净的点，就不要费心移除内部点，因为对象可能非常小 |
| `p.MinLevelsetDimension` | `4` | 单个水平集轴上的单元数下限 |
| `p.MinLevelsetSize` | `50` | 使用水平集的最小轴上的最小尺寸 |
| `p.MoveIgnoreFirstBlockingOverlap` | `0` | 是否忽略SafeMoveUpdatedComponent中的第一个阻挡重叠（如果从对象移出并开始穿透）。 ‘p.InitialOverlapTolerance’设置将决定‘移出’规则，但默认情况下，始终先尝试取消穿透（不忽略命中）。 0：禁用（不忽略），1：启用（忽略） |
| `p.net.CmdOffsetEnabled` | `true` | 启用旧版处理物理帧偏移的已废弃（5.4）逻辑。推荐做法：将值设置为0，停止已废弃物理帧偏移流。 |
| `p.net.ForceFault` | `0` | 强制服务器端输入错误 |
| `p.net.ForceInputDrop` | `0` | 强制客户端丢弃输入。用于模拟去同步 |
| `p.net.LerpTargetNumBufferedCmdsAggresively` | `0` | 主动向TargetNumBufferedCmds插值。减少服务器端缓冲，但可能导致更多瑕疵。 |
| `p.net.MaxBufferedCmds` | `16` | 缓冲服务器端命令的最大数量 |
| `p.net.MaxTargetNumBufferedCmds` | `5` | 服务器对每个客户端定位的缓冲输入的数量上限。 |
| `p.net.MaxTimeDilationMag` | `0.01` | 客户端用于减慢/跟上服务器的最大时间膨胀 |
| `p.net.TargetNumBufferedCmds` | `1.9` | 发生输入故障时要增加TargetNumBufferedCmds的数量 |
| `p.net.TargetNumBufferedCmdsAlpha` | `0.005` | TargetNumBufferedCmds的插值强度 |
| `p.net.TargetNumBufferedCmdsDeltaOnFault` | `1` | 发生输入故障时要增加TargetNumBufferedCmds的数量 |
| `p.net.TimeDilationAlpha` | `0.1` | 滑动客户端时间膨胀的插值强度 |
| `p.net.TimeDilationEnabled` | `0` | 启用客户端时间膨胀 |
| `p.NetCorrectionLifetime` | `4` | 可视化网络校正持续时长。 每项可视化网络校正的持续时长，以秒为单位。 |
| `p.NetEnableListenServerSmoothing` | `1` | 是否在监听服务器上启用网格体平滑，用于远程客户端的本地视图。 0：禁用，1：启用 |
| `p.NetEnableMoveCombining` | `1` | 是否在客户端启用移动合并，以通过合并类似的移动来减少带宽。 0：禁用，1：启用 |
| `p.NetEnableMoveCombiningOnStaticBaseChange` | `1` | 是否允许在静态几何体之间移动时合并客户端移动。 0：禁用，1：启用 |
| `p.NetEnableSkipProxyPredictionOnNetUpdate` | `1` | 如果bNetworkSkipProxyPredictionOnNetUpdate在移动组件上也为true，是否允许代理跳过具有网络位置更新的帧的预测。 0：禁用，1：启用 |
| `p.NetForceClientAdjustmentPercent` | `0` | 无论实际错误如何，ServerCheckClientError检查的百分比都会返回true。 对测试客户端校正代码很有帮助。 <=0：禁用，0.05：5%的检查将返回失败，1.0：始终发送客户端调整 |
| `p.NetForceClientServerMoveLossDuration` | `0` | 当NetForceClientServerMoveLossPercent检查通过时，客户端丢弃ServerMove调用的时长，以秒为单位。 对测试服务器强制校正代码很有帮助。 时长为零表示单帧丢失。 |
| `p.NetForceClientServerMoveLossPercent` | `0` | 客户端未发送的ServerMove调用百分比。 对测试服务器强制校正代码很有帮助。 <=0：禁用，0.05：5%的检查将返回失败，1.0：永不发送服务器移动 |
| `p.NetMoveCombiningAttachedLocationTolerance` | `0.01` | 合并移动时相对位置附件变化的容差。较小容差允许由于变换更新而产生的非常轻微的抖动。 |
| `p.NetMoveCombiningAttachedRotationTolerance` | `0.01` | 合并移动时相对旋转附件变化的容差。较小容差允许由于变换更新而产生的非常轻微的抖动。 |
| `p.NetPackedMovementMaxBits` | `4096` | 每个打包移动RPC中允许的最大位数。用于防止不良数据导致服务器分配过多内存。 |
| `p.NetPingExtrapolation` | `-1` |  |
| `p.NetPingLimit` | `-1` |  |
| `p.NetShowCorrections` | `0` | 是否绘制客户端位置校正（红色表示不正确，绿色表示已校正）。 0：禁用，1：启用 |
| `p.NetStationaryRotationTolerance` | `0.1` | 当发生小的控制旋转变化时，GetClientNetSendDeltaTime()的容差保持受限。 |
| `p.NetUseBaseRelativeAcceleration` | `1` | 启用后，角色加速将被视为与动态运动基础相关。 |
| `p.NetUseBaseRelativeVelocity` | `1` | 启用后，角色速度校正将被视为与动态运动基础相关。 |
| `p.NetUseClientTimestampForReplicatedTransform` | `1` | 启用后，使用客户端时间戳更改来跟踪重复的变换时间戳，否则使用服务器函数更新时间作为时间戳。 如果在运行时更改，通常需要重新启动游戏会话。 0：禁用，1：启用 |
| `p.NetUsePackedMovementRPCs` | `1` | 是否使用较新的移动RPC参数打包序列化。禁用后，将改用旧的已废弃移动RPC。 0：禁用，1：启用 |
| `p.NetVisualizeSimulatedCorrections` | `0` | 0：禁用，1：启用 |
| `p.NormalAveraging2` | `0` |  |
| `p.NumActiveChannels` | `1` |  |
| `p.PenetrationOverlapCheckInflation` | `0.1` | 检查某个位置是否没有阻挡碰撞时，膨胀被添加到对象。 在穿透重叠检查中，距离被添加到膨胀。 |
| `p.PenetrationPullbackDistance` | `0.125` | 从对象的穿透中拉出此额外距离。 距离被添加到穿透修复中。 |
| `p.PhysDrawing.SkinnedLatticeBoneWeight` | `-1` | 绘制蒙皮格栅骨骼权重。-1 = 所有格栅点 |
| `p.PhysicalMaterial.ShowExperimentalProperties` | `false` |  |
| `p.PhysicsAnimBlendUpdatesPhysX` | `1` | 是否用物理动画混合的结果更新PhysX模拟 |
| `p.PhysicsRunsOnGT` | `0` | 如果为true，物理线程会在游戏线程上运行，但遇到碰撞检测等任务时仍将扩大运行范围 |
| `p.PositionLerp` | `-1` |  |
| `p.PreventInvalidBodyInstanceTransforms` | `true` | 如果为true，则尝试创建具有无效变换的BodyInstance将失败并显示警告 |
| `p.PreventNonVerticalOrientationBlock` | `1` | 启用后，即使有RotationRate设置阻止，也会允许应该保持垂直的角色对齐到垂直方向。参见@ShouldRemainVertical和@RotationRate。 |
| `p.PrimitiveComponent.ReplicatePhysicsObject` | `true` | 当图元组件没有BodyInstance时，允许基于PhysicsObject复制 |
| `p.RagdollPhysics` | `1` | 如果为1，将使用布偶物理。否则仅模拟根主体 |
| `p.RemoveFarBodiesFromBVH` | `0` | 将远离场景的主体从bvh中移除 0：保留，1：删除 |
| `p.ReplayLerpAcceleration` | `0` |  |
| `p.ReplaySQs` | `0` | 启用后，会针对Chaos重新运行sq |
| `p.ReportTooManyChildrenNum` | `-1` | 当单个群集中存在的子项超过指定值时发出警告 |
| `p.Resim.AllowRewindToResimulatedFrames` | `false` | 允许倒回到之前属于某个重新模拟的一部分的某一帧。如果在第100至110帧之间执行了重新模拟，则允许在必要时在第105至115帧进行新的重新模拟，否则下一个重新模拟将从第111帧开始。 |
| `p.Resim.IncompleteHistory` | `false` | 如果找不到有效的重新模拟帧，则使用请求的重新模拟帧并使用不完整的数据执行重新模拟。 |
| `p.Resim.InterpolateTargetGaps` | `5` | 通过在前一个目标和新接收的目标之间进行插值，我们要在复制目标中填补多少帧间隙。插值的最大帧数值，设置为0即停用。 |
| `p.Resim.ResimFrameValidation` | `1` | 0 = 无宽限，所有脏粒子均需有效目标。1 = 岛状区宽限，重新模拟岛状区中的所有粒子均需有效目标。2 = 完全宽限，仅触发重新模拟的粒子才需有效目标。 |
| `p.RestoreBreakingMomentumPercent` | `0.5` | 当刚性群集断裂时，与其接触的对象将接收冲量以恢复断裂前动量的百分比。 |
| `p.RigidBodyLODThreshold` | `-1` | 允许刚体节点运行的最大LOD。提供一个全局阈值，可重载每个节点的LODThreshold属性。-1表示无重载。 |
| `p.RigidBodyNode` | `true` | 启用/禁用整个刚体节点系统。禁用后，将避免所有分配和运行时开销。可用于禁用低端平台上的RB节点。 |
| `p.RigidBodyNode.ComponentAppliedLinearAccClamp` | `-1` | ComponentAppliedLinearAccClamp重载 |
| `p.RigidBodyNode.ComponentLinearAccScale` | `-1` | ComponentLinearAccScale重载 |
| `p.RigidBodyNode.ComponentLinearVelcale` | `-1` | ComponentLinearVelcale重载 |
| `p.RigidBodyNode.DebugDraw` | `false` | 是否调试绘制刚体模拟状态。还需要p.Chaos.DebugDraw.Enabled 1才能运行。 |
| `p.RigidBodyNode.DeferredSimulationDefault` | `false` | 刚体模拟是否对未选择特定模拟时间的资产延迟一帧 |
| `p.RigidBodyNode.DeferredSimulationForceDefault` | `false` | 当为true时，刚体模拟将始终使用p.RigidBodyNode.DeferredSimulationDefault的值来确定是否延迟模拟工作，忽略单个节点中的设置。 |
| `p.RigidBodyNode.EnableComponentAcceleration` | `true` | 启用/禁用用于组件或骨骼空间模拟的简单加速度传输系统 |
| `p.RigidBodyNode.EnableSimulation` | `1` | 运行时启用/禁用RB节点模拟以进行调试和测试（即使禁用，也会初始化节点并且会创建主体和约束。） |
| `p.RigidBodyNode.EnableTimeBasedReset` | `true` | 如果为true，则刚体节点将在一段时间未更新时被重置（默认为true） |
| `p.RigidBodyNode.GravityScale` | `1` | 乘以所有RBAN上的重力 |
| `p.RigidBodyNode.IncludeClothColliders` | `true` | 将布料碰撞物作为运动体纳入即时物理模拟中。 |
| `p.RigidBodyNode.InitializeBoneReferencesRangeCheckEnabled` | `true` |  |
| `p.RigidBodyNode.MaxSubSteps` | `4` | 设置更新循环中的模拟步数上限 |
| `p.RigidBodyNode.Space.MaxAngularAcceleration` | `-1` | RBAN SimSpaceSettings重载 |
| `p.RigidBodyNode.Space.MaxAngularVelocity` | `-1` | RBAN SimSpaceSettings重载 |
| `p.RigidBodyNode.Space.MaxLinearAcceleration` | `-1` | RBAN SimSpaceSettings重载 |
| `p.RigidBodyNode.Space.MaxLinearVelocity` | `-1` | RBAN SimSpaceSettings重载 |
| `p.RigidBodyNode.Space.Override` | `false` | 强制启用高级模拟空间运动力 |
| `p.RigidBodyNode.Space.VelocityScaleZ` | `-1` | RBAN SimSpaceSettings重载 |
| `p.RigidBodyNode.Space.WorldAlpha` | `-1` | RBAN SimSpaceSettings重载 |
| `p.RigidBodyNode.TaskPriority.Simulation` | `0` | 运行刚体节点模拟任务的任务优先级（0 = 前景/高，1 = 前景/正常，2 = 背景/高，3 = 背景/正常，4 = 背景/低）。 |
| `p.RigidBodyNode.WorldObjectExpiry` | `4` | 经过指定次数测试后仍未检测到的世界对象将从模拟中删除 |
| `p.RK4SpringInterpolator.MaxIter` | `4` | RK4弹簧插值器的最大迭代次数 |
| `p.RK4SpringInterpolator.UpdateRate` | `60` | RK4弹簧插值器的更新率 |
| `p.RootMotion.Debug` | `0` | 是否绘制根骨骼运动源调试信息。 0：禁用，1：启用 |
| `p.RootMotion.DebugSourceLifeTime` | `6` | 可视化根骨骼运动源的持续时间。 每个可视化根运动源的持续时间，以秒为单位。 |
| `p.SampleMinParticlesForAcceleration` | `2048` | 取样时使用加速结构前所需的粒子数下限 |
| `p.SecondChannelDelay` | `0.05` |  |
| `p.SensitiveSleepThresholdMultiplier` | `0.05` | 用于使用敏感睡眠系列主体的休眠阈值乘数。 |
| `p.SerializeBadSQs` | `0` | 启用后，每当Chaos和PhysX出现分歧时，都会创建sq捕获 |
| `p.SerializeEvolution` | `0` |  |
| `p.SerializeSQs` | `0` | 启用后，给每个耗时超过所提供微秒值的SQ创建SQ捕获。开销可能非常高，因为整个场景都被保存下来 |
| `p.SerializeSQSampleCount` | `100` | 如果查询超过持续时长阈值，我们将在序列化之前按照指定的次数重新测量SQ。值过大会导致卡顿。 |
| `p.SerializeSQsOverlapEnabled` | `1` | 禁用后，p.SerializeSQs将不考虑重叠 |
| `p.SerializeSQsRaycastEnabled` | `1` | 禁用后，p.SerializeSQs将不考虑光线投射 |
| `p.SerializeSQsSweepEnabled` | `1` | 禁用后，p.SerializeSQs将不考虑扫描 |
| `p.ShallowCopyOnClusterUnionUpdate` | `1` | 如果为1，则在群集联合的根联合几何体更新时对其进行浅复制，否则深复制几何体层级 |
| `p.ShowInitialOverlaps` | `0` | 显示移动组件时的初始重叠，包括预估的‘退出’方向。 0：关闭，否则为开启 |
| `p.SimCollisionEnabled` | `1` | 如果为0，则不使用模拟碰撞 |
| `p.simDelay` | `0` |  |
| `p.SkipDesyncTest` | `0` | 跳过硬去同步测试，这意味着所有粒子都被视为干净，只是在不同时间产生。这对于性能下限有用，但不具有实际准确性 |
| `p.SkipPhysicsReplication` | `0` |  |
| `p.SkipShapeCreationForEmptyBodySetup` | `false` | 如果为true，并且主体设置没有任何几何体，CreateShapesAndActors将不会尝试为所有实例创建Actor和形状。 |
| `p.SkipSkeletalRepOptimization` | `1` | 如果为true，不在复制期间移动骨骼网格体组件。这样是没问题的，因为骨骼网格体在其结果之后已轮询PhysX |
| `p.SkipUpdateOverlapsOptimEnabled` | `1` | 启用后，缓存是否需要在某些组件上调用UpdateOverlaps |
| `p.SQHitchDetection` | `0` | 是否检测场景查询卡顿。0为关闭。1为重复一次缓慢的场景查询并打印更多信息。2+为重复慢查询n次且不记录（分析时有用） |
| `p.SQHitchDetectionForceNames` | `0` | 名称解析是否脱离游戏线程强制执行。这并非100%安全，但在查看GT卡顿时很有用 |
| `p.SQHitchDetectionThreshold` | `0.05` | 确定场景查询卡顿的阈值，以毫秒为单位。 |
| `p.ToleranceScale_Length` | `100` | 模拟中对象的近似大小。默认值：100 |
| `p.ToleranceScale_Speed` | `1000` | 模拟中对象速度的常规值。默认值：1000 |
| `p.UnionsHaveCollisionParticles` | `0` |  |
| `p.UseAccumulationArray` | `1` |  |
| `p.UseAsyncInterpolation` | `1` | 启用异步模式时是否进行插值 |
| `p.UseBoundingBoxForConnectionGraphFiltering` | `0` | 开启时，在连接图生成期间使用边界框重叠来过滤连接[默认值：0] |
| `p.UseConnectivity` | `1` | 拆分簇时是否使用连接图 |
| `p.UseDeprecatedBehaviorUpdateMassScaleChanges` | `0` | 允许FBodyInstanceCore::bUpdateMassWhenScaleChanges默认为false。这存在潜在问题，但允许现有项目保留旧行为 |
| `p.UseLastGoodRotationDuringCorrection` | `1` | 启用后，在校正期间，如果服务器未指定旋转，则在重新模拟保存移动之前恢复最后一次良好旋转。这样可以通过随时间旋转的选项（如bOrientToMovement或bUseControllerDesiredRotation）来提高视觉质量。 |
| `p.UseLevelsetCollision` | `0` | 联合对象是否使用水平集 |
| `p.UseTargetVelocityOnImpact` | `1` | 禁用后，通过比较移动前后的位置来重新计算撞击后的速度。与物理对象发生碰撞时，此方法无法正常工作，因此将其设置为1可修复撞击对象正在移动的情况。 |
| `p.ValidateSceneComponentAttachmentDetailLevel_High` | `true` | 启用后，会确认烘焙的目标细节级别为高，并且删除不需要的组件不会删除任何组件的父项。 |
| `p.ValidateSceneComponentAttachmentDetailLevel_Low` | `true` | 启用后，会确认烘焙的目标细节级别为低，并且删除不需要的组件不会删除任何组件的父项。 |
| `p.ValidateSceneComponentAttachmentDetailLevel_Medium` | `true` | 启用后，会确认烘焙的目标细节级别为中，并且删除不需要的组件不会删除任何组件的父项。 |
| `p.ValidateSceneComponentAttachmentEditorOnlySettings` | `true` | 启用后，会确认仅限编辑器的组件没有非仅限编辑器的附加组件 |
| `p.VisualizeMovement` | `0` | 是否绘制角色移动的世界内调试信息。 0：禁用，1：启用 |

## Perforce

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `p4.AlwaysBranchFilesOnCopy` | `false` | 采用复制时始终在perforce中使文件分支的旧行为。 |

## 程序包

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Package.Relocation` | `0` | 定义何时应运行程序包依赖项的重定位逻辑。请注意，在运行时更改此值不会更新资产注册表中的缓存依赖项。 0：关闭（永不应用重定位）。对其他重定位程序包的引用将导致错误并且无法解析。 1：重定位EUnrealEngineObjectUE5Version::ADD_SOFTOBJECTPATH_LIST (5.1)之后保存的资产。新项目的默认值。 |
| `PackageReload.EnableFastPath` | `true` | 当为"true"时，将使用优化的代码路径来加速重新加载包（试验性）。 |
| `PackageTools.UnloadPackagesUnloadsPrimaryAssets` | `true` | 在卸载包期间，还会卸载主资产 |
| `pak.ReaderReleaseDelay` | `5` | 如果> 0，则将删除更早的同步pak读取器。 |

## 性能警告

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `PerfWarn.CoarseMinFPS` | `20` | FPS阈值，低于该阈值时，发出粗粒度取样警告。 |
| `PerfWarn.CoarsePercentThreshold` | `80` | 低于最小FPS的样本百分比，高于该阈值时，发出警告。 |
| `PerfWarn.CoarseSampleTime` | `600` | 对粗粒度最小FPS的百分比进行取样的秒数。 |
| `PerfWarn.FineMinFPS` | `10` | FPS阈值，低于该阈值时，发出细粒度取样警告。 |
| `PerfWarn.FinePercentThreshold` | `80` | 低于最小FPS的样本百分比，高于该阈值时，发出警告。 |
| `PerfWarn.FineSampleTime` | `30` | 细粒度最小FPS的百分比进行取样的秒数。 |

## 放置模式

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `PlacementMode.AllowNonPrimitiveComponentHits` | `true` | 在放置模式下对世界进行光线投射时，允许击中未与UPrimitiveComponent绑定的物理对象（与非Actor工作流程一起使用）。 |
| `PlacementMode.ItemInternalsInTooltip` | `false` | 在提示文本中显示可放置项内部信息 |

## 玩家控制器

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `PlayerController.LevelVisibilityDontSerializeFileName` | `false` | 如果为true，始终跳过通过FUpdateLevelVisibilityLevelInfo's序列化FileName。当游戏不需要两者时，这样可节省带宽。 |
| `PlayerController.NetResetServerPredictionDataOnPawnAck` | `1` | 当Pawn确认握手完成时，是否重置所拥有Pawn的服务器预测数据。 0：禁用，1：启用 |

## 插件管理器

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `PluginManager.LeakedAssetTrace.MaxReportCount` | `10` | 发现泄漏的资产时，要报告的最大资产数。 |
| `PluginManager.LeakedAssetTrace.RenameLeakedPackages` | `true` | 卸载或解除挂载游戏功能插件之后是否应追踪发生泄漏的包。 |
| `PluginManager.LeakedAssetTrace.Severity` | `2` | 当引擎检测到游戏功能插件中的资产在卸载或解除挂载期间发生泄漏时，控制日志记录的严重性。 0-禁用所有引用追踪和日志记录 1-记录错误 2-保证 3-致命错误 |
| `PluginManager.LeakedAssetTrace.TraceMode` | `1` | 当引擎检测到游戏功能插件中的资产在卸载或解除挂载期间发生泄漏时，控制引用追踪的细节级别。 0-仅直接引用 1-完整引用追踪 |
| `PluginManager.VerifyUnload` | `true` | 验证插件资产在卸载时不再在内存中。 |

## 渲染

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `PurgeOldLightmaps` | `1` | 如果非零，则在重新编译光照时清除旧的光照贴图数据。 |
| `r.AllowCachedUniformExpressions` | `1` | 允许缓存统一表达式。 |
| `r.AllowClearLightSceneExtentsOnly` | `1` |  |
| `r.AllowDepthBoundsTest` | `1` | 如果为true，则在渲染延迟光源时使用启用深度边界测试。 |
| `r.AllowGlobalClipPlane` | `0` | 使网格着色器能够支持平面反射所需的全局裁剪平面，这会给PS4增加约15%的BasePass GPU开销。 |
| `r.AllowHDR` | `0` | 创建与HDR兼容的交换链并启用HDR显示输出。0：禁用（默认） 1：如果平台和显示器支持HDR，则允许HDR |
| `r.AllowLandscapeShadows` | `1` | 允许地形阴影 |
| `r.AllowOcclusionQueries` | `true` | 启用硬件遮挡剔除。 |
| `r.AllowPointLightCubemapShadows` | `1` | 当为0时，将阻止使用点光源立方体贴图阴影，并且光源将不受阴影影响。 |
| `r.AllowPrecomputedVisibility` | `1` | 如果为零，则不会使用预先计算的可视性来剔除图元。 |
| `r.AllowSimpleLights` | `1` | 如果为true，则允许简单（即粒子）光源 |
| `r.AllowStaticLighting` | `1` | 是否允许生成并使用任何静态光照，如光照贴图和阴影贴图。 仅使用动态光照的游戏应将其设置为0，节省一些静态光照开销。 |
| `r.AllowSubPrimitiveQueries` | `1` | 启用子图元查询，当前仅供分层实例化静态网格体使用。1：启用，0禁用。禁用后，整个代理将使用一个查询。 |
| `r.AllowTexture2DArrayCreation` | `1` | 启用UTexture2DArray资产 |
| `r.AnisotropicMaterials` | `1` | 是否对具有各向异性的材质使用各向异性BRDF。 |
| `r.AntiAliasingMethod` | `4` | AntiAliasingMethod的引擎默认值（项目设置）为（后期处理体积/摄像机/游戏设置仍然可以重载） 0：关闭（无抗锯齿） 1：快速近似抗锯齿（FXAA） 2：时间抗锯齿（TAA） 3：多重采样抗锯齿（MSAA，仅在台式机前向渲染器上可用） 4：时间超级分辨率（TSR，默认） |
| `r.AreShaderErrorsFatal` | `true` | 启用后，当默认材质或全局着色器编译失败时，将发出"致命"错误。 否则只是"错误"。 默认值：true |
| `r.BackbufferQuantizationDitheringOverride` | `0` | 重载量化抖动所针对的后缓冲区每个通道的位深度，以位为单位。默认禁用。通过FSceneViewFamily::RenderTarget的后缓冲区像素格式自动找到。 |
| `r.BadDriverWarningIsFatal` | `false` | 如果非零，则在检测到拒绝名单上的驱动程序时触发致命错误。 r.WarnOfBadDrivers必须为非零才会发生致命错误。 0：关闭（默认） 1：过期的驱动程序消息被忽略后，会发生致命错误（仅限非发布版） |
| `r.BasePassOutputsVelocity` | `-1` | 控制台变量已废弃。改用r.VelocityOutputPass。 |
| `r.BasePassWriteDepthEvenWithFullPrepass` | `0` | 0为允许只读基本通道，跳过MSAA深度解析，并允许遮罩材质获取EarlyZ（执行clip()时写入深度会禁用EarlyZ）（默认） 1为强制在基本通道中进行深度写入。 当预通道和基础通道与渲染的内容不匹配时，这对调试很有帮助。 |
| `r.bFlushRenderTargetsOnWorldCleanup` | `1` |  |
| `r.BlackBorders` | `0` | 在渲染图像周围绘制黑色边框（防止在图像之外读取的后期处理通道出现瑕疵，例如PostProcessAA） 以像素为单位，0：关闭 |
| `r.CatmullRomEndParamOffset` | `0.1` | Catmull rom端点的参数偏移。 |
| `r.chaos.ReflectionCaptureStaticSceneOnly` | `1` | 0为关闭，1为打开（默认） |
| `r.CheckSRVTransitions` | `0` | 测试当设置SRV时，渲染目标会正确转换到SRV。 |
| `r.ClearCoatNormal` | `0` | 0为禁用透明涂层法线。 0：关闭 1：开启 |
| `r.ClearGBufferDBeforeBasePass` | `1` | 是否在基础通道之前清除GBuffer D |
| `r.ClearSceneMethod` | `1` | 选择在游戏模式下如何清除GBuffer（仅影响延迟着色）。 0：不清除 1：RHIClear（默认） 2：四边形，最大z时 |
| `r.CloudDefaultTexturesNoFastClear` | `1` | 删除默认云纹理的快速清除 |
| `r.CompileMaterialsForShaderFormat` |  | 启用后，除了编译用于运行平台的材质外，还会编译此着色器格式的材质。 请注意，这些着色器被编译后会立即被丢弃。这仅在通过r.DebugDumpShaderInfo直接检查输出时有用。 |
| `r.CompileShadersForDevelopment` | `1` | 将其设置为0允许发布具有更优着色器的游戏，因为某些编辑器和开发功能不再编译到着色器中。 注意：这将在发布时完成，但目前还不是自动完成（功能需要完善，并且着色器编译速度会更慢，因为开发中的着色器缓存不共享）。 无法在运行时更改 - 可以放入BaseEngine.ini 0：关闭，着色器可以运行得更快 1：开启（默认） |
| `r.Composite.TemporalUpsampleDepth` | `2` | 用于深度测试编辑器图元的深度缓冲区的时间上采样因子。 |
| `r.CookOutUnusedDetailModeComponents` | `0` | 设置后，与当前细节模式不相关的组件将被剔除。 0：即使与当前细节模式无关的组件也保留。 1：剔除与当前细节模式不相关的组件。 |
| `r.CreateShadersOnLoad` | `0` | 是否在加载时创建着色器，这样可以减少卡顿，但会占用更多内存。 否则将根据需要创建着色器。 |
| `r.CullBeforeFetch` | `0` | 为支持Cull-Before-Fetch优化的平台启用它。 0：禁用（默认） 1：启用 |
| `r.CullInstances` | `1` | 剔除实例。 |
| `r.DBuffer` | `1` | 启用DBuffer贴花材质混合模式。 Dbuffer贴花在基础通道之前渲染，使得它们能够正确影响静态光照和天空光照。 启用后，将强制执行完整预通道，这会增加CPU/GPU开销。 将在基础通道中进行数次纹理查找，以获取贴花属性，这会增加像素工作。 0：关闭 1：开启（默认） |
| `r.Deferred.UsesLightFunctionAtlas` | `0` | 是否在渲染局部光源时对光源函数图集进行取样。 |
| `r.DeferredMeshPassSetupTaskSync` | `1` | 启用后，网格体通道设置任务的同步点将（从RDG设置期间开始）延迟到RDG执行，从而显著增加重叠的可能性。 |
| `r.DeferSkeletalDynamicDataUpdateUntilGDME` | `0` | 如果> 0，则骨骼网格体动态数据更新将延迟到GDME。试验性选项。 |
| `r.DeferUniformExpressionCaching` | `1` | 是否延迟统一表达式的缓存，直到渲染命令需要缓存更新。 延迟更新更有效，因为一帧中的多次SetVectorParameterValue调用只会产生一次更新。 |
| `r.DeferUpdateRenderStates` | `1` | 是否在参数发生变化时延迟更新材质参数集合的渲染状态，直到渲染命令需要渲染状态更新。 延迟更新更有效，因为一帧中的多次SetVectorParameterValue和SetScalarParameterValue调用只会产生一次更新。 |
| `r.DemosaicVposOffset` | `0` | 该偏移被添加到移动色调映射着色器中用于去马赛克的光栅化位置。它的存在是为了解决某些存在半像素偏移的Android设备上的驱动程序漏洞。 |
| `r.DemotedLocalMemoryWarning` | `1` | 如果设置为1，则当本地内存降级为系统内存时将显示警告。 |
| `r.DetailedMipAlphaLogging` | `0` | 当纹理图像处理期间alpha被移除/引入时，打印额外的日志消息以用于追踪。 |
| `r.DetailMode` | `3` | 当前细节模式；确定是否应该更新/刷新Actor的组件。 0：低，显示DetailMode为低的对象 1：中，显示DetailMode为中或以下的对象 2：高，显示DetailMode为高或以下的对象 3：超高，显示所有对象（默认） |
| `r.DisableDistortion` | `0` | 防止渲染产生失真效果。 节省全屏帧缓冲区的内存价值。 |
| `r.DisableEngineAndAppRegistration` | `0` | 如果为true，则禁用引擎和应用程序注册，以在调试和开发期间禁用GPU驱动程序优化 更改仅在新游戏/编辑器实例中生效 - 无法在运行时更改。 |
| `r.DisableLandscapeNaniteGI` | `1` | 禁用地形Nanite GI |
| `r.DisableLODFade` | `0` | 禁用距离剔除的消退 |
| `r.DiscardUnusedQuality` | `0` | 是否保留或丢弃内存中未使用的质量级别着色器贴图。 0：在内存中保存所有质量级别。（默认） 1：加载时丢弃未使用的质量级别。 |
| `r.DisplayInternals` | `0` | 允许启用显示引擎/渲染器内部情况的屏幕打印输出 这主要用于说明为什么屏幕截图看起来不同。 0：关闭（默认） 1：启用 |
| `r.DistanceFadeMaxTravel` | `1000` | 玩家在消退时间内可以行进的最大距离。 |
| `r.DontLimitOnBattery` | `0` | 0：限制带电池设备的性能。（默认） 1：不因设备带电池而限制性能。 |
| `r.DoTiledReflections` | `1` | 使用平铺计算着色器计算反射环境。 0：关闭 1：开启（默认） |
| `r.DownsampledOcclusionQueries` | `0` | 是否向下采样深度缓冲区发出遮挡查询 |
| `r.DrawRectangleOptimization` | `1` | 控制DrawRectangle()的优化。启用后，在某些情况下可以使用三角形绘制四边形（视口大小的四边形）。 使用三角形可以在较低分辨率下实现稍快的后期处理速度，但并非总是可用。 0：禁用优化，DrawDenormalizedQuad始终使用四边形进行渲染 1：启用优化，可以在指定位置渲染三角形（默认） |
| `r.DriverDetectionMethod` | `5` | 定义使用哪种实现方案来检测GPU驱动程序（检查旧驱动程序、日志和统计数据） 0：迭代注册表中的可用驱动程序并选择具有相同名称的驱动程序，如果有问题，请使用下一个方法（发生） 1：获取主适配器的驱动程序（处理多个适配器时可能不正确） 2：使用DirectX LUID（最好的方案，但尚未实现） 3：使用Windows功能，使用主设备（当API使用另一个适配器时可能会出错） 4：使用Windows功能，使用DirectX Device（最新、最具前景）这类名称 5：使用Windows SetupAPI函数 |
| `r.DumpingMovie` | `0` | 允许将每个渲染的帧转储到磁盘（慢速fps，名为MovieFrame）。 <=0：关闭（默认），<0：保持开启，>0：n帧保持开启（n为指定数字） |
| `r.DumpShaderDebugInfo` | `2` | 将已编译着色器的调试信息转储到GameName/Saved/ShaderDebugInfo 当设置为1时，将转储所有已编译着色器的调试信息 当设置为2时，限于存在编译错误的着色器 当设置为3时，限于存在编译错误或警告的着色器 调试信息取决于平台，但通常包含着色器源的预处理版本。 如果启用了r.ShaderDevelopmentMode，全局着色器会自动转储调试信息，此控制台变量不是必需的。 在iOS上，如果PowerVR图形SDK安装到默认路径，则会调用PowerVR着色器编译器，并且烘焙期间会报告错误。 |
| `r.DumpShaderDebugShortNames` | `0` | 仅当r.DumpShaderDebugInfo > 0时有效。 设置为1时，将缩短工厂名称和着色器类型文件夹名称，以避免长路径问题。 |
| `r.DumpShaderDebugWorkerCommandLine` | `0` | 仅当r.DumpShaderDebugInfo > 0时有效。 设置为1时，会生成一个可以与ShaderCompileWorker's -directcompile一起使用的文件。 |
| `r.DumpShaderOutputCacheHits` | `false` | 转储着色器输出字节码并缓存引用了原始输出的命中。 转储所有编译着色器的着色器输出字节码还需要控制台变量r.DumpShaderDebugInfo=1。 |
| `r.DumpTransitionsForResource` |  | 当给定资源过渡时打印调用堆栈。目前仅针对DX11实现。要转储的资源的名称 |
| `r.DX12NVAfterMathDumpWaitTime` | `10` | 等待NV Aftermath完成处理GPU崩溃转储的时间。 |
| `r.DX12NVAfterMathEnabled` | `0` | 在D3D12中使用NV Aftermath进行GPU崩溃分析 |
| `r.DX12NVAfterMathTrackResources` | `0` | 在D3D12中启用NV Aftermath资源追踪 |
| `r.DynamicGlobalIlluminationMethod` | `1` | 0 - 无。 全局光照可以烘焙到光照贴图中，但动态全局光照不会使用任何技术。 1 - Lumen。 将Lumen全局光照用于所有光源、自发光材质投射光源和天空光照遮蔽。 需要为软件光线追踪启用‘生成网格体距离场（Generate Mesh Distance Fields）’，并为硬件光线追踪启用‘支持硬件光线追踪（Support Hardware Ray Tracing）’。 2 - SSGI。 独立屏幕空间全局光照。 低成本，但受限于屏幕空间信息。 3 - 插件。 使用全局光照的插件。 |
| `r.FBlueprintContext.VirtualStackAllocator.DecommitMode` | `0` | 当通过ThreadSingleton使用时，为FVirtualStackAllocator指定DecommitMode。值来自EVirtualStackAllocatorDecommitMode。 |
| `r.FBlueprintContext.VirtualStackAllocatorStackSize` | `8388608` | FBlueprintContext的FVirtualStackAllocator的默认大小 |
| `r.FeatureLevelPreview` | `0` | 如果值为1，快速设置菜单将包含一个选项用来启用功能级别预览模式 |
| `r.FilmGrain` | `1` | 是否启用胶片颗粒。 |
| `r.FilmGrain.CacheTextureConstants` | `1` | 是否应该缓存与胶片颗粒相关的常量。 |
| `r.FilmGrain.SequenceLength` | `97` | 胶片颗粒随机序列的长度（最好是质数，默认值=97）。 |
| `r.Filter.LoopMode` | `0` | 控制何时使用动态或展开的循环来迭代高斯滤波。 此通道用于高斯模糊、泛光和景深。动态循环最多允许128个样本，而展开的循环最多允许32个样本，但每次迭代时都会为循环的停止测试增加额外开销。 0：仅展开的循环（默认；限制为32个样本）。 1：如果需要超过32个样本，则回退到动态循环。 2：仅动态循环。 |
| `r.Filter.SizeScale` | `1` | 允许缩小或增加用于泛光和高斯景深的样本数（限制比例以提供合理的结果）。 低至0.6的值很难被注意到 1全品质（默认） >1更多样本（较慢） <1样本减少（较快，HDR内容的瑕疵或具有GaussianDOF的盒状结果） |
| `r.FinishCurrentFrame` | `0` | 如果开启，当前帧将被强制完成并渲染到屏幕而不是被缓冲。 这样可以改善延迟，但会降低整体性能。 |
| `r.FlushRHIThreadOnSTreamingTextureLocks` | `0` | 如果设置为0，不对流送纹理进行清空。这是安全的，因为纹理流送器显式处理这些危险。 |
| `r.Fog` | `1` | 0：禁用 1：启用（默认） |
| `r.FogUseDepthBounds` | `true` | 允许在雾全屏通道上启用深度边界优化。 false：禁用 true：启用（默认） |
| `r.ForceAllCoresForShaderCompiling` | `0` | 当设置为1时，将忽略INI设置并根据可用核启动尽可能多的ShaderCompileWorker实例。 提高着色器吞吐量，但对于大型项目来说，它可能会使机器内存不足 |
| `r.ForceDebugViewModes` | `0` | 0：设置没有影响。 1：强制调试视图模式可用，即使在已烘焙构建本中也是如此。2：强制调试视图模式不可用，即使在编辑器构建中也是如此。 删除许多着色器Permutation，以加快着色器迭代。 |
| `r.ForceHighestMipOnUITextures` | `0` | 如果设置为1，UI组中的纹理将强制使用其最高Mip级别。 |
| `r.ForceLOD` | `-1` | 要强制实施的LOD级别，-1为关闭。 |
| `r.ForceLODShadow` | `-1` | 仅强制用于阴影贴图生成的LOD级别，-1为关闭。 |
| `r.ForceRetileTextures` | `0` | 如果在项目设置中启用了共享线性纹理编码，这将强制要重新编译的平铺编译步骤，但允许从缓存中获取线性纹理。 |
| `r.ForceSceneHasDecals` | `0` | 是否始终假定场景具有贴花，这样不会有条件地切换深度状态。这样能以较小的GPU开销显著减少PSO总数。 |
| `r.Forward.LightGridDebug` | `0` | 是否在屏幕上显示每个图块的剔除光照。 0：关闭（默认） 1：开启 - 显示深度缓冲区上的光源计数 2：开启 - 显示每个切片（最后一个切片除外）每个图块的最大光源计数（此处剔除过于保守） 3：开启 - 显示每个切片（包括最后一个切片）每个图块的最大光源计数 |
| `r.Forward.LightGridPixelSize` | `64` | 光源网格中单元的大小，以像素为单位。 |
| `r.Forward.LightGridSizeZ` | `32` | 光源网格中的Z切片数。 |
| `r.Forward.LightLinkedListCulling` | `1` | 使用反转链表来存储被剔除的光源，去除了对多少光源可影响单元的固定限制 - 而是变成了全局限制。 |
| `r.Forward.MaxCulledLightsPerCell` | `32` | 控制为每个单元分配多少内存用于光源剔除。 当启用r.Forward.LightLinkedListCulling时，它用于计算全局最大值，而不是被剔除光源的每单元限制。 |
| `r.ForwardShading` | `0` | 是否在台式机平台上使用正向着色 - 需要Shader Model 5硬件。 正向着色的恒定开销较低，但支持的功能较少。0：关闭，1：开启 此渲染路径尚在进行中，具有许多未实现的功能，特别是每个对象仅应用一次反射捕获，并且没有半透明动态阴影接收。 |
| `r.ForwardShading.ForceSkyLightCubemapBlending` | `0` | 强制着色器天空盒体混合以进行正向着色。开销更高但质量也更高。这类似于在所有前向材质上将混合天空光照立方体贴图（Blend Sky Light Cubemaps）设置为true。 |
| `r.FramesToExpandNewlyOcclusionTestedBBoxes` | `2` | 如果不对r.GFramesNotOcclusionTestedToExpandBBoxes帧进行遮挡测试，那么在对此数量的帧进行遮挡测试时扩展BBox。另请参阅r.GFramesNotOcclusionTestedToExpandBBoxes、r.ExpandNewlyOcclusionTestedBBoxesAmount |
| `r.FreeSkeletalMeshBuffers` | `0` | 控制骨骼网格体缓冲区是否保存在CPU内存中以支持骨骼网格体的合并。 0：保留缓冲区（默认） 1：释放缓冲区 |
| `r.FreezeMouseCursor` | `0` | 释放鼠标光标位置，面向用它显示调试信息的通道。 0：默认 1：在当前位置冻结鼠标光标位置 |
| `r.FullScreenMode` | `1` | 定义在请求时如何全屏显示（例如命令行选项-fullscreen或者ini [SystemSettings] fullscreen=true） 0：正常全屏（渲染速度更快、对垂直同步的控制更多、GPU内存更少、可行的情况下使用10位颜色） 1：窗口式全屏（在应用程序和窗口模式之间快速切换，性能略有损失） 任何其他数字，行为都和0一样 |
| `r.FXAA.Quality` | `4` | 选择FXAA的质量Permutation。 0：主机 1：PC中度抖动3样本 2：PC中度抖动5样本 3：PC中度抖动8样本 4：PC低抖动12样本（默认值） 5：PC极致质量12样本 |
| `r.Gamma` | `1` | 输出Gamma |
| `r.GaussianBloom.Cross` | `0` | 试验性功能赋予泛光核更亮的中心样本（值介于1和3之间，不会引起锯齿） 现有泛光会降低以匹配相同亮度 <0，用于变形镜头眩光外观（仅限X） 0关闭（默认） >0，用于交叉外观（X和Y） |
| `r.GBufferDiffuseSampleOcclusion` | `0` | Gbuffer是否包含各个漫反射样本的遮挡信息。 |
| `r.GBufferFormat` | `1` | 定义用于GBuffer的内存布局。 （影响性能，主要通过带宽、法线质量和材质属性影响）。 0：较低精度（每组件8位，用于分析） 1：低精度（默认） 3：高精度法线编码 5：高精度 |
| `r.GeneralPurposeTweak` | `1` | 适用于低级别着色器开发，无需更改任何c++代码即可获得快速迭代时间。 值映射到着色器内部的Frame.GeneralPurposeTweak。 示例用法：对某些值进行乘数调整，切换不同的算法（默认值：1.0) 请勿将其用于已签入的任何内容。在SHIPPING中编译出来，加大作弊难度。 |
| `r.GeneralPurposeTweak2` | `1` | 适用于低级别着色器开发，无需更改任何c++代码即可获得快速迭代时间。 值映射到着色器内部的Frame.GeneralPurposeTweak2。 示例用法：对某些值进行乘数调整，切换不同的算法（默认值：1.0) 请勿将其用于已签入的任何内容。在SHIPPING中编译出来，加大作弊难度。 |
| `r.GenerateMeshDistanceFields` | `1` | 是否编译静态网格体的距离场，这是Lumen软件光线追踪和距离场环境光遮蔽所需的，用于实现可移动天空光照（Movable SkyLight）阴影。 启用后将增加网格体编译时间和内存使用量。 更改此值将导致重新编译所有静态网格体。 |
| `r.GeometryCollection.CustomRenderer.ForceBreak` | `-1` | 强制要单独渲染的指定片段数量，替换它们的根代理网格体。 |
| `r.GeometryCollection.Nanite` | `1` | 使用Nanite渲染几何体集。 |
| `r.GeometryCollectionSetDynamicData.ISPC` | `true` | 是否使用ISPC优化来设置几何体集中的动态数据 |
| `r.GeometryCollectionTripleBufferUploads` | `1` | 是否对几何体集上传进行三重缓冲，这会允许Lock_NoOverwrite上传，在GPU上处理大量数据时，上传速度会更快。 |
| `r.GFramesNotOcclusionTestedToExpandBBoxes` | `5` | 如果不对这么多帧的图元进行遮挡测试，则在对几帧进行遮挡测试时扩展BBox。另请参阅r.ExpandNewlyOcclusionTestedBBoxesAmount、r.FramesToExpandNewlyOcclusionTestedBBoxes |
| `r.GlobalDistanceField.Debug.DrawModifiedPrimitives` | `0` | 是否绘制导致全局距离场更新的图元修改（添加、删除、更新变换）。 这对于追踪为何更新全局距离场总是开销很高很有帮助，因为大部分内容被缓存。 |
| `r.GlobalDistanceField.Debug.ForceMovementUpdate` | `0` | 是否强制在X、Y和Z轴上对N纹素边界进行每帧更新。 |
| `r.GlobalDistanceField.Debug.LogModifiedPrimitives` | `0` | 是否记录导致全局距离场更新的图元修改（添加、删除、更新变换）。 这对于追踪为何更新全局距离场总是开销很高很有帮助，因为大部分内容被缓存。 通道2仅记录非可移动对象的更新。 |
| `r.GlobalDistanceField.Debug.ShowStats` | `false` | 全局距离场的调试绘制。 |
| `r.GlobalDistanceFieldHeightFieldThicknessScale` | `4` | 进入全局距离场时高度场的厚度，以距离场体素为单位。默认为4，表示厚度为体素大小的4倍。 |
| `r.GraphicsAdapter` | `-1` | 用户请求选择特定的图形适配器（例如，当将集成显卡与独立显卡结合使用时） 对于Windows D3D，除非选择特定的适配器，否则拒绝Microsoft适配器，因为不需要软件模拟。 这优先于 `-prefer{AMD\\\|NVidia\\\|Intel}` when the value is >= 0. -2: Take the first one that fulfills the criteria -1: Favour non integrated because there are usually faster (default) 0: Adapter #0 1: Adapter #1, ... |
| `r.grass.DensityQualityLevel` | `-1` | 草的质量级别（低、中、高、超高）。 |
| `r.grass.ShowBothPerQualityAndPerPlaformProperties` | `false` | 在编辑器中显示每平台和每质量属性。 |
| `r.HFShadowAverageObjectsPerCullTile` | `16` | 确定在高度场对象剔除数据结构中应分配多少内存。 太多 = 浪费内存，太少 = 因缓冲溢出而闪烁。 |
| `r.HFShadowQuality` | `2` | 定义允许质量或性能调整的高度场阴影方法。 0：关闭，1：低（8步），2：中（16步，默认），3：高（32步，洞感知） |
| `r.HighQualityLightMaps` | `1` | 如果设置为1，则允许高质量光照贴图，不会烘焙固定光源的直接光照 |
| `r.HighResScreenshot.AdditionalCmds` |  | 当请求高分辨率屏幕截图时要执行的附加命令。 |
| `r.HighResScreenshotDelay` | `4` | 当请求高分辨率截图时，会出现短暂的延迟以允许时间效应收敛。 默认值：4.使用低于默认值的值将禁用时间抗锯齿以改善图像质量。 |
| `r.Histogram.UseAtomic` | `1` | 使用原子来加速柱状图的生成。 |
| `r.HitProxy.CaptureNextUpdate` | `0` | 在下次更新时启用命中代理渲染的GPU捕获。 |
| `r.HLOD.DistanceOverride` | `0.0` | 如果非零，则重载HLOD级别索引处所有对象发生HLOD过渡的距离，格式如下： ‘r.HLOD.DistanceOverride 5000, 10000, 20000’将导致HLOD级别0、1和2分别在5000、1000和20000处过渡。 |
| `r.HLOD.DistanceOverrideScale` |  | 缩放r.HLOD.DistanceOverride中的值，默认关闭。 这是一个可选比例，旨在允许游戏逻辑在不影响可伸缩性的情况下动态修改。 |
| `r.HLOD.DitherPauseTime` | `0.5` | HLOD抖动暂停时间，以秒为单位 |
| `r.HLOD.ForceDisableCastDynamicShadow` | `0` | 如果非零，则将为所有LODActor将bCastDynamicShadow设置为false，无论其子Actor的阴影设置如何。 |
| `r.HLOD.MaximumLevel` | `-1` | LOD层级允许显示的深度（可用于限制高可伸缩性设置中的质量损失和流送纹理内存使用情况） -1：无最高级别（默认） 0：防止显示HLOD群集而非单个网格体 1：仅允许显示第一级HLOD群集 2+：允许显示最多第N级HLOD群集 |
| `r.HZB.BuildUseCompute` | `1` | 选择是否要使用计算来编译HZB。 |
| `r.HZBOcclusion` | `0` | 定义使用哪种遮挡系统。 0：硬件遮挡查询 1：使用HZB遮挡系统（默认，GPU和CPU开销更低，结果更保守） 2：强制HZB遮挡系统（重载渲染平台偏好设置） |
| `r.IESAtlas.Debug` | `0` | 启用IES图集调试信息。 |
| `r.IESAtlas.ForceUpdate` | `0` | 强制IES图集每帧更新。 |
| `r.IESAtlas.MaxProfileCount` | `32` | 可存储的IES配置文件的数量上限。 |
| `r.IESAtlas.Resolution` | `256` | 用于存储IES纹理的分辨率。 |
| `r.IgnorePerformanceModeCheck` | `false` | 忽略性能模式检查 |
| `r.IncludeNonVirtualTexturedLightmaps` | `0` | 如果启用了‘r.VirtualTexturedLightmaps’，则控制是否同时生成/保存非VT光照贴图。 包含非VT光照贴图将限制光照贴图集大小，从而消除VT光照贴图的一些优势。 0：不包括。 1：包括。 |
| `r.IndirectLightingCache` | `1` | 是否在动态对象上使用间接光照缓存。 0为关闭，1为打开（默认） |
| `r.InstanceCulling.AllowBatchedBuildRenderingCommands` | `1` | 是否允许批处理BuildRenderingCommands以进行GPU实例剔除 |
| `r.InstanceCulling.AllowInstanceOrderPreservation` | `1` | 是否允许实例使用GPU压缩来保留实例绘制顺序。 |
| `r.InstanceCulling.ForceInstanceCulling` | `0` | 是否强制执行每实例遮挡剔除。 |
| `r.InstanceCulling.OcclusionCull` | `0` | 是否针对GPU实例剔除执行每实例遮挡剔除。 |
| `r.InstanceCulling.OcclusionQueries` | `0` | 试验性：使用每实例软件遮挡查询来执行比单独使用HZB保守性更小的可视性测试 |
| `r.InstanceData.MinInstanceCountToOptimize` | `2` | 执行优化构建的实例数下限（如果启用），可用于禁用小型ISM的优化构建，因为这样做会产生一些开销。 |
| `r.InstanceData.ResetTrackingOnRegister` | `1` | 如果这样会导致问题，请使用Chicken开关禁用新代码以在OnRegister期间重置跟踪和实例计数。 TODO：移除。 |
| `r.InstancedStaticMeshes.AllowCreateEmpty` | `0` | 是否允许创建空的ISMS。 |
| `r.InstancedStaticMeshes.ConservativeBounds.Threshold` | `30` | 在开始使用保守边界之前ISM中的实例数。设置为-1时禁用保守边界。 |
| `r.InstancedStaticMeshes.FetchInstanceCountFromScene` | `1` | 启用数据路径，允许从场景而不是网格绘制命令（MDC）获取实例计数，这样当实例计数发生变化时就无需重新缓存MDC。 |
| `r.InstancedStaticMeshes.ForceRemoveAtSwap` | `0` | 从ISM中删除实例时强制执行RemoveAtSwap优化。 |
| `r.InstancedStaticMeshes.GpuLod` | `1` | 是否在InstancedStaticMesh上启用GPU LOD选择。 |
| `r.InstanceUpdateTaskDebugDelay` | `0` | 实例更新调试延迟，以秒为单位。 |
| `r.IrisNormal` | `0` | 设置为0可禁用Iris法线。 0：关闭 1：开启 |
| `r.ISMPool.ComponentFreeListTargetSize` | `50` | 回收空闲列表中ISM组件数量的目标大小。 |
| `r.ISMPool.ComponentKeepAlive` | `true` | 当所有ISM组件的实例都被删除时，保持组件处于活动状态。 |
| `r.ISMPool.ComponentRecycle` | `true` | 当ISM组件的所有实例都被删除后，将组件回收到空闲列表中以供重新使用。 |
| `r.ISMPool.ShadowCopyCustomData` | `false` | 保留自定义实例数据的副本，以便在删除并重新添加实例时可以恢复。 |
| `r.KeepOverrideVertexColorsOnCPU` | `1` | 保留重载顶点颜色的CPU副本。 某些蓝图/对象生成可能需要。 |
| `r.KeepPreCulledIndicesThreshold` | `0.95` |  |
| `r.LandscapeLOD0DistributionScale` | `1` | 地形LOD0DistributionSetting属性的乘数 |
| `r.LandscapeLODDistributionScale` | `1` | 地形LODDistributionSetting属性的乘数 |
| `r.LandscapeUseAsyncTasksForLODComputation` | `1` | 使用异步任务计算每地形组件的LOD偏差。 |
| `r.LensFlareQuality` | `2` | 0：关闭，但性能最佳 1：质量低但性能良好 2：质量良好（默认） 3：质量非常好但性能差 |
| `r.LightCulling.MaxDistanceOverrideKilometers` | `-1` | 用于重载光源网格中可存储数据的最大远距离。 如果值增加，你可能需要根据用例的光源数和分布将r.Forward.LightGridSizeZ更新为合理的值。<=0：关闭 >0：最远距离，以公里为单位。 |
| `r.LightCulling.Quality` | `1` | 是否运行计算光源剔除通道。 0：关闭 1：开启（默认） |
| `r.LightFunctionAtlas` | `1` | 试验性：在运行时启用光源函数图集生成。仅当其他系统在运行时使用该图集时才会生成。 |
| `r.LightFunctionAtlas.Format` | `0` | 0：灰阶，范围为[0,1]。1：彩色，范围为[0,1] |
| `r.LightFunctionAtlas.MaxLightCount` | `-1` | 试验性：限制可以对光源函数图集取样的光源数量。-1表示光源数量不受限制。 |
| `r.LightFunctionAtlas.Size` | `4` | 试验性：2D纹理图集边缘的图集插槽计数的默认大小。 |
| `r.LightFunctionAtlas.SlotResolution` | `128` | 试验性：每个图集插槽的分辨率。 |
| `r.LightFunctionQuality` | `1` | 定义光源函数质量，以便调整质量或性能。 <=0：关闭（最快） 1：低质量（例如分辨率减半，模糊，尚未实现） 2：正常质量（默认） 3：高质量（例如，超级采样或着色，尚未实现） |
| `r.LightMaxDrawDistanceScale` | `1` | 应用于光源MaxDrawDistance的比例。 有助于在某些平台上更激进地淡出局部光源。 |
| `r.LightShaftAllowTAA` | `1` | 允许对光束进行时间过滤。 0：关闭 1：开启（默认） |
| `r.LightShaftBlurPasses` | `3` | 光束模糊通道数。 |
| `r.LightShaftDownSampleFactor` | `2` | 光束的下采样因子。范围：1..8 |
| `r.LightShaftFirstPassDistance` | `0.1` | 第一次径向模糊通道上到光源模糊的分数形式距离。 |
| `r.LightShaftNumSamples` | `12` | 每光束径向模糊通道的样本数量。 还会影响每通道模糊距离增加的速度。 |
| `r.LightShaftQuality` | `1` | 定义光束质量（移动和非移动）。 0：关闭 1：开启（默认） |
| `r.LightShaftRenderToSeparateTranslucency` | `0` | 启用后，光束将被渲染到单独的半透明缓冲区。 这样可确保在光束之前应用具有BL_BeforeTranslucnecy的后期处理材质 |
| `r.LimitRenderingFeatures` | `0` | 允许快速减少渲染功能以提高渲染性能。 这只是一种快速改变游戏中多个显示标记和控制台变量的方法 禁用的功能越多，数字越大 <=0：关闭，顺序在代码中定义（确定顺序时可以在此记录） |
| `r.LODFadeTime` | `0.25` | LOD消退所需的时间（以秒为单位）。 |
| `r.LogShaderCompilerStats` | `0` | 设置为1时，记录详细的着色器编译器统计信息。 |
| `r.LUT.Size` | `32` | 胶片LUT的大小 |
| `r.LUT.UpdateEveryFrame` | `0` | 控制是否每帧都执行色调映射LUT通道。 |
| `r.MaxAnisotropy` | `8` | MaxAnisotropy的范围应为1至16。当使用各向异性过滤时，值越高意味着纹理质量越好，但性能会受到影响。默认值为4。 |
| `r.MaxCSMRadiusToAllowPerObjectShadows` | `8000` | 仅CSM半径小于此值的固定光源才会为动态对象创建每对象阴影。 |
| `r.MaxQualityMode` | `0` | 如果设置为1，则将某些系统设置重载为最高质量，而不考虑性能影响 |
| `r.MaxVertexBytesAllocatedPerFrame` | `33554432` | 在开始紧急记录谁在进行分配之前要分配的临时顶点缓冲区字节数上限 |
| `r.MinRoughnessOverride` | `0` | 警告：这是一个试验性功能，可能随时会发生变更。 设置在直接光照计算中使用时的粗糙度全局限制。 这可用于限制由于低粗糙度引起的萤火虫数量，特别是在未使用抗锯齿时。 0.0：无变更（默认） |
| `r.MinScreenRadiusForCSMDepth` | `0.01` | 低于该阈值的网格体将会从CSM深度通道中被剔除。 |
| `r.MinScreenRadiusForDepthPrepass` | `0.03` | 低于该阈值的网格体将会从仅深度通道中被剔除。 |
| `r.MinScreenRadiusForLights` | `0.03` | 低于该阈值的光源将被剔除。 |
| `r.MinYResolutionFor3DView` | `360` | 定义要在3D视图中支持的最小Y分辨率 |
| `r.MinYResolutionForUI` | `720` | 定义在UI中支持的最小Y分辨率（默认为720） |
| `r.MipMapLODBias` | `0` | 对所有2D纹理应用额外的Mip贴图偏差，范围为-15.0到15.0 |
| `r.MotionVectorSimulation` | `0` | 控制是否在镜头切换帧上的场景组件、几何体缓存和蒙皮网格体上允许模拟的运动向量。 |
| `r.MrMesh.BrickCullingDebugState` | `0` | MR网格体砖块剔除调试状态：0=关闭，1=开启，2=暂停 |
| `r.MSAA.CompositingSampleCount` | `4` | 影响编辑器3D对象的渲染质量。 1：无MSAA，最低质量 2：2x MSAA，中等质量（中等GPU内存消耗） 4：4x MSAA，高质量（高GPU内存消耗） 8：8x MSAA，极高质量（GPU内存消耗惊人） |
| `r.MSAACount` | `4` | 与前向渲染器一起使用的MSAA样本数量。 仅在渲染项目设置中启用MSAA时使用。 0：MSAA已禁用（启用时间抗锯齿） 1：MSAA已禁用 2：使用2x MSAA 4：使用4x MSAA8：使用8x MSAA |
| `r.MultithreadedLightmapEncode` | `1` | 重新编译光照贴图后的光照贴图编码采用多线程完成。 |
| `r.MultithreadedShadowmapEncode` | `1` | 重新编译光照贴图后的阴影贴图编码采用多线程完成。 |
| `r.NeverOcclusionTestDistance` | `0` | 当视点与边界球体中心之间的距离小于此值时，永不进行遮挡剔除。 |
| `r.NormalCurvatureToRoughnessBias` | `0` | 对于启用了NormalCurvatureToRoughness的材质，让屏幕空间法线变化所导致的粗糙度产生偏差。 有效范围[-1, 1] |
| `r.NormalCurvatureToRoughnessExponent` | `0.333` | 对于启用了NormalCurvatureToRoughness的材质，屏幕空间法线变化所致粗糙度的指数。 |
| `r.NormalCurvatureToRoughnessScale` | `1` | 对于启用了NormalCurvatureToRoughness的材质，偏屏幕空间法线变化所致的粗糙度缩放。 有效范围[0, 2] |
| `r.NormalMapsForStaticLighting` | `0` | 是否允许任何静态光照使用法线贴图进行光照计算。 |
| `r.NumBufferedOcclusionQueries` | `1` | 缓冲遮挡查询的帧数（包括当前渲染线程帧）。 帧越多，CPU停滞等待结果的可能性就越小，但过期查询瑕疵会变多。 |
| `r.NumFramesUnusedBeforeReleasingGlobalResourceBuffers` | `30` | 超过此数量的帧后，丢弃未使用的全局资源分配。设置为0时忽略。（默认=30） |
| `r.OcclusionFeedback.Blending` | `1` | 0：不透明 1：启用混合 （默认） 2：启用像素丢弃 |
| `r.OcclusionFeedback.Enable` | `0` | 是否根据渲染反馈启用遮挡系统。目前仅适用于移动渲染 |
| `r.OcclusionQueryDispatchOrder` | `0` | 0：先分组查询，再单独查询（默认） 1：分组前的单独查询 |
| `r.OIT.SortedPixels` | `0` | 启用OIT渲染（项目设置，运行时无法更改） |
| `r.OIT.SortedPixels.Debug` | `0` | 为OIT启用调试渲染。1：为标准半透明启用调试 2：为单独的半透明启用。 |
| `r.OIT.SortedPixels.Enable` | `1` | 启用OIT渲染（运行时设置，选择着色器Permutation） |
| `r.OIT.SortedPixels.MaxSampleCount` | `4` | 最大样本数。 |
| `r.OIT.SortedPixels.Method` | `1` | 切换OIT方法 0：常规alpha混合（即无OIT） 1：MLAB |
| `r.OIT.SortedPixels.PassType` | `3` | 启用OIT渲染。0：禁用 1：针对标准半透明启用OIT 2：针对单独的半透明度启用OIT 3：针对标准和单独的半透明度启用（默认） |
| `r.OIT.SortedPixels.TransmittanceThreshold` | `0.05` | 当累积透射比低于此阈值时，删除半透明渲染表面 |
| `r.OIT.SortedTriangles` | `1` | 启用每实例三角形排序，以避免无效的三角形排序。 |
| `r.OIT.SortedTriangles.Debug` | `0` | 启用每实例三角形排序调试渲染。 |
| `r.OIT.SortedTriangles.Pool` | `0` | 启用索引缓冲池分配，通过重复使用缓冲减少创建/删除时间。 |
| `r.OIT.SortedTriangles.Pool.ReleaseFrameThreshold` | `100` | 超过此数量的帧后，释放未使用的缓冲。 |
| `r.OneFrameThreadLag` | `1` | 是否允许渲染线程落后于游戏线程一帧（0：禁用，否则启用） |
| `r.OpenGL.DisableTextureStreamingSupport` | `0` | 禁用OpenGL上的纹理流送支持。 0 = 如果设备支持，将使用纹理流送[默认] 1 = 纹理流送将被禁用。 |
| `r.OpenGL.ForceDXC` | `1` | 强制所有OpenGL着色器使用DirectX着色器编译器（DXC），代替hlslcc。 0：禁用 1：强制所有着色器使用新编译器（默认） |
| `r.OptimizedWPO.AffectNonNaniteShaderSelection` | `false` | 每个图元WPO标记是否应影响非Nanite图元的着色器选择。这增加了选择仅位置深度VS的机会，但代价是每当WPO标记改变时缓存绘制命令更新。 |
| `r.Ortho.AllowNearPlaneCorrection` | `true` | 正交近平面可能位于摄像机位置的后面，这会导致虚幻引擎在解析摄像机位置后面的光照时出现一些问题。此控制台变量使正交摄像机能够全局自动更新摄像机位置以匹配近平面位置，并强制将伪摄像机位置作为投影矩阵计算的替换近平面位置。这意味着虚幻可以正确解析摄像机后面的光照。 |
| `r.Ortho.AutoPlanes` | `true` | 全局允许正交摄像机使用自动近/远平面求值。 |
| `r.Ortho.AutoPlanes.ClampToMaxFPBuffer` | `1` | 对裁剪平面自动求值时，确定是否应使用16位深度缩放。16位缩放对于发生的任何深度缩减都是有利的（例如，HZB缩减采用16位纹理而不是32位）。此功能将根据虚幻单位（默认为厘米）与像素比计算所需的最大深度比例。它将假定我们不需要32位深度范围来处理较小的场景，因为大多数Actor都会在合理的可见视锥体内。但是它仍然可以扩展到最大值UE_OLD_WORLD_MAX，这是深度缓冲的典型全范围，因此更大的场景仍然有效。 |
| `r.Ortho.AutoPlanes.DepthScale` | `-1` | 允许从默认的+FP16最大值（66504.0f）调整16位深度缩放。如果远平面不需要那么远，此变量就很有用，将改善深度增量 |
| `r.Ortho.AutoPlanes.ScaleIncrementingUnits` | `true` | 在按单位增加像素比时，选择是否要缩放近/远平面的最小和最大值（例如，从厘米到米到千米）。 |
| `r.Ortho.AutoPlanes.ShiftPlanes` | `0` | 沿Z方向移动整个视锥体。例如，如果你需要近平面更靠近摄像机，此变量会很有用，可以通过减少远平面值实现（例如，在水平2.5D场景中）。 |
| `r.Ortho.CalculateDepthThicknessScaling` | `1` | 是否自动从近平面/远平面差异派生深度厚度测试比例。 0：禁用（使用r.Ortho.DepthThicknessScale指定的缩放） 1：启用（默认） |
| `r.Ortho.CameraHeightAsViewTarget` | `true` | 设置是否使用摄像机高度作为伪摄像机来查看目标。 主要有助于VSM裁剪图选择，并避免过度校正近平面。 |
| `r.Ortho.Debug.ForceAllCamerasToOrtho` | `false` | 调试强制场景中的所有摄像机使用正交视图 |
| `r.Ortho.Debug.ForceCameraFarPlane` | `2.09715e+06` | 调试创建新摄像机Actor时强制使用正交远平面 |
| `r.Ortho.Debug.ForceCameraNearPlane` | `-768` | 调试创建新摄像机Actor时强制使用正交近平面 |
| `r.Ortho.Debug.ForceOrthoWidth` | `1536` | 调试创建新摄像机Actor时强制使用正交宽度 |
| `r.Ortho.Debug.ForceUseAutoPlanes` | `true` | 调试强制使用布尔值，用于确定是否对近平面和远平面自动求值 |
| `r.Ortho.DefaultUpdateNearClipPlane` | `0` | 使用正交近裁剪校正时要校正的正交近裁剪平面值 |
| `r.Ortho.DepthThicknessScale` | `0.001` | 正交场景深度的缩放比例低于透视视角，通常为1/100。使用此值可同时在各个屏幕追踪通道中调整深度厚度测试值的比例 |
| `r.Ortho.EditorDebugClipPlaneScale` | `1` | 仅影响光照（Lit）模式下的编辑器正交视口。 设置按比例缩放以根据当前设置的正交宽度按比例改变近平面。 当场景中的几何体因正交缩放发生变化而裁剪时，此项将发生变化。对于改变网格体大小很有帮助。 当该值发生变化时，可能会出现其他光源瑕疵，目前这是不可避免的。 |
| `r.Ortho.VSM.ClipmapLODBias` | `0` | LOD设置用于根据基于OrthoWidth的值调整第一级VSM。 |
| `r.Ortho.VSM.EstimateClipmapLevels` | `true` | 启用/禁用根据当前摄像机OrthoWidth计算FirstLevel VSM |
| `r.Ortho.VSM.ProjectViewOrigin` | `true` | 启用/禁用移动VSM裁剪图的WorldOrigin以聚焦ViewTarget（如果存在） |
| `r.Ortho.VSM.RayCastViewOrigin` | `true` | 如果ViewTarget不存在（即独立摄像机），则启用/禁用是否应使用光线投射来估计ViewOrigin |
| `r.OverrideShaderDebugDir` |  | 重载着色器调试文件的输出位置 空：使用默认位置Saved\\ShaderDebugInfo。 |
| `r.Paper2D.DrawTwoSided` | `1` | 将Sprite绘制为双面。 |
| `r.Paper2D.UsePrebuiltVertexBuffers` | `1` | 使用预编译顶点缓冲绘制Sprite。 |
| `r.ParallelBasePass` | `1` | 切换并行基础通道渲染。必须启用并行渲染才能产生效果。 |
| `r.ParallelCmdListInheritBreadcrumbs` | `1` | 是否将操作记录继承到并行cmd列表 |
| `r.ParallelGatherNumPrimitivesPerPacket` | `256` | 每个数据包的图元数量。 仅在禁用r.Shadow.UseOctreeForCulling时使用。 |
| `r.ParallelGatherShadowPrimitives` | `1` | 切换并行采集阴影图元。0：关闭；1：开启 |
| `r.ParallelGeometryCollectionBatchSize` | `1024` | 单个集合中每线程分派的顶点数。 |
| `r.ParallelInitDynamicShadows` | `1` | 切换并行动态阴影初始化。0：关闭；1：开启 |
| `r.ParallelPrePass` | `1` | 切换并行zprepass渲染。必须启用并行渲染才能产生效果。 |
| `r.ParallelShadows` | `1` | 切换并行阴影渲染。必须启用并行渲染才能产生效果。 |
| `r.ParallelShadowsNonWholeScene` | `0` | 切换非全场景阴影的并行阴影渲染。必须启用r.ParallelShadows才能产生效果。 |
| `r.ParallelSingleLayerWaterPass` | `1` | 切换并行单层水通道渲染。必须启用并行渲染才能产生效果。 |
| `r.ParallelTranslucency` | `1` | 切换并行半透明渲染。必须启用并行渲染才能产生效果。 |
| `r.ParallelVelocity` | `1` | 切换并行速度渲染。必须启用并行渲染才能产生效果。 |
| `r.ParticleLightQuality` | `2` | 0：无光源。1：仅限简单光源。2：简单+HQ光源 |
| `r.ParticleLODBias` | `0` | 粒子系统的LOD偏差，默认值为0 |
| `r.Photography.Available` | `1` | （只读）如果为1，则摄影系统可能可供用户使用。 否则，无法使用正常运行的后端。 |
| `r.PrecomputedVisibilityWarning` | `0` | 如果设置为1，则在没有预计算可视性的视点渲染场景时将显示警告。 |
| `r.PreTileTextures` | `1` | 如果设置为1，纹理将在烘焙过程中平铺，并预计在运行时进行烘焙 |
| `r.PreventInvalidMaterialConnections` | `1` | 控制用户是否可以在材质编辑器中建立连接（如果系统确定这些连接可能会导致编译错误） 0：允许所有连接 1：防止无效连接 |
| `r.PrimitiveHasTileOffsetData` | `1` | 1：将低精度的tileoffset图元数据上传到GPU，0：使用更高精度的双精度浮点数。 |
| `r.PurgeEditorSceneDuringPIE` | `0` | 0：在PIE期间保持编辑器场景完全初始化（默认） 1：在PIE期间从内存中清除编辑器场景并在会话完成时恢复。 |
| `r.RenderCaptureDraws` | `0` | 为接下来的N次绘制启用捕获渲染捕获纹理 |
| `r.RenderCommandPipe.Cable` | `true` | 是否启用电缆渲染命令管道 0：关闭；1：开启（默认） |
| `r.RenderCommandPipe.NiagaraDynamicData` | `true` | 是否启用NiagaraDynamicData渲染命令管道 0：关闭；1：开启（默认） |
| `r.RenderCommandPipe.SkeletalMesh` | `true` | 是否启用SkeletalMesh渲染命令管道 0：关闭；1：开启（默认） |
| `r.RenderCommandPipeMode` | `2` | 控制主渲染线程命令管道的行为。0：渲染命令作为任务单独启动； 1：渲染命令仅被排队到渲染线程的渲染命令管道中； 2：渲染命令被排队到所有声明管道的渲染命令管道中； |
| `r.RenderLastFrameInStreamingPause` | `1` | 如果为1，则在流送暂停期间显示前一帧。如果为零，则屏幕为黑色。 |
| `r.RenderTargetPoolMin` | `400` | 如果渲染目标池大小（以MB为单位）低于此值，则不会取消分配渲染目标。默认值为200 MB。 |
| `r.RenderThreadTimeIncludesDependentWaits` | `0` | 0：RT统计数据仅包括非空闲时间，1：RT统计数据包括依赖等待（匹配RenderThreadTime_CriticalPath） |
| `r.RenderTimeFrozen` | `0` | 允许冻结基于时间的效果，以提供更具确定性的渲染分析。 0：关闭 1：开启（注意：这也会禁用遮挡查询） |
| `r.Roughness.Max` | `1` | 通过将粗糙度1重新映射到新值（0..1）来进行快速材质测试，仅适用于非发布构建阶段！ 1：（默认值） |
| `r.Roughness.Min` | `0` | 通过将粗糙度0重新映射到新值（0..1）来进行快速材质测试，仅适用于非发布构建阶段！ 0：（默认值） |
| `r.SafeStateLookup` | `1` | 强制进行新样式安全状态查找，以便轻松进行运行时性能比较 |
| `r.SaveEXR.CompressionQuality` | `1` | 定义如何以EXR格式保存HDR屏幕截图。 0：无压缩 1：默认压缩，但速度可能较慢（默认） |
| `r.ScreenPercentage` | `100` | 在较低分辨率和分辨率修改的情况下进行渲染，可以获得更好的性能（结合可混合的后期处理设置）。 对于低锯齿和性能来说，70是一个合适的值，可以通过‘显示TestImage’以百分比验证，>0且<=100，数值可以更大（超级采样），但下采样质量可改进。<=0，计算的屏幕百分比由r.ScreenPercentage.Default控制台变量决定。 |
| `r.ScreenPercentage.Auto.PixelCountMultiplier` | `1` |  |
| `r.ScreenPercentage.Default` | `100` |  |
| `r.ScreenPercentage.Default.Desktop.Mode` | `1` |  |
| `r.ScreenPercentage.Default.Mobile.Mode` | `0` |  |
| `r.ScreenPercentage.Default.PathTracer.Mode` | `0` |  |
| `r.ScreenPercentage.Default.VR.Mode` | `0` |  |
| `r.ScreenPercentage.MaxResolution` | `0` | 控制任何分辨率修改之前渲染像素的绝对数量上限，使得不会超过此变量的16:9指定分辨率。例如，将此值设置为1440，这样你就不会渲染超过2560x1440 = 3.6M像素。在PC端，在项目的DefaultEditor.ini中进行此项设置非常有用，这样你在PC端PIE中渲染的像素就不会比在使用项目特定动态分辨率设置在主机端平均渲染的像素多。 |
| `r.ScreenPercentage.MinResolution` | `0` | 控制渲染像素的绝对数量下限。 |
| `r.ScreenshotDelegate` | `1` | ScreenshotDelegates阻止处理传入的屏幕截图请求并中断某些功能。允许禁用它们。 理想情况下，重新编写委托代码以避免这种情况。 0：关闭 1：委托开启（默认） |
| `r.SecondaryScreenPercentage.GameViewport` | `0` | 重载游戏视口的辅助屏幕百分比。 0：自动计算辅助屏幕百分比 = 100/DPIScalefactor（默认）； 1：重载辅助屏幕百分比。 |
| `r.SelectiveBasePassOutputs` | `0` | 使着色器仅导出到相关的渲染目标。 0：导出到所有渲染目标。 1：仅导出到相关的渲染目标。 |
| `r.SeparateTranslucency` | `1` | 允许禁用单独的半透明功能（如果材质中未另行指定，则所有半透明度将在单独的RT中渲染并在景深之后合成）。 0：关闭（半透明度受景深影响） 1：开启会消耗GPU性能和内存，但保持半透明度不受景深影响。（默认值） |
| `r.SeparateTranslucencyScreenPercentage` | `100` | 以此全分辨率百分比渲染单独的半透明度。 以百分比表示，>0且<=100，数字可以更大（超级采样）。<0则被视为100。 |
| `r.SeparateTranslucencyUpsampleMode` | `1` | 用于单独半透明度的上采样方法。 仅当r.SeparateTranslucencyScreenPercentage小于100时才使用这些方法。 0：双线性 1：最近深度邻算法（仅当r.SeparateTranslucencyScreenPercentage为50时） |
| `r.SetRes` | `2560x1440wf` | 设置当前游戏视图的显示分辨率。在编辑器中没有影响。 例如，1280x720w用于窗口模式 1920x1080f用于全屏模式 1920x1080wf用于窗口式全屏模式 |
| `r.ShaderCodeLibrary.AsyncIOAllowDontCache` | `0` |  |
| `r.ShaderCodeLibrary.DefaultAsyncIOPriority` | `3` |  |
| `r.ShaderCodeLibrary.MaxShaderGroupSize` | `1048576` | 要一起压缩/解压缩的一组着色器的最大（未压缩）大小。如果一个组超出了该大小，将被均匀地分成几个力求不超过该大小的子组。然而，如果着色器组只剩一个着色器但仍然超出限制，则该限制将被忽略。 |
| `r.ShaderCodeLibrary.MaxShaderPreloadWaitTime` | `0.001` | 如果等待着色器预加载的时间超过此秒数，则将其作为警告记录。 |
| `r.ShaderCodeLibrary.SeparateLoadingCache` | `0` | 如果>0，则每个着色器代码库都有自己的加载缓存。 |
| `r.ShaderCodeLibrary.VisualizeShaderUsage` | `0` | 如果为1，则在退出时保存包含所使用着色器（针对每个着色器库数据块）的位图。仅适用于独立游戏。 |
| `r.ShowMaterialDrawEvents` | `0` | 是否在每个网格体绘制调用附近发出绘制事件，并附带所用资产的信息。 启用后会产生严重的CPU和GPU开销，但对调试有帮助。 |
| `r.ShowPrecomputedVisibilityCells` | `0` | 如果非零，则绘制所有预计算可视性单元。 |
| `r.ShowRelevantPrecomputedVisibilityCells` | `0` | 如果非零，则仅绘制相关的预计算可视性单元。 |
| `r.ShowShaderCompilerWarnings` | `0` | 当设置为1时，将显示所有警告。 |
| `r.SingleLayerWater.UsesLightFunctionAtlas` | `0` | 启用对SingleLAyer Water材质上的光源函数图集的取样。 |
| `r.SkinnedMesh.ReleasePreviousLODInfoOnInitialization` | `true` | 是否在重新初始化时清空渲染线程（导致游戏线程停顿）并清理现有的LOD信息。 |
| `r.SkinnedMesh.UpdateBoundsNotifyStreamingRadiusChangeRatio` | `0.1` | 当半径自上次更新以来的变化超过此比例时，更新流送管理器。负值将禁用更新。 |
| `r.SkipDrawOnPSOPrecaching` | `0` | 当PSO仍在编译时跳过网格体绘制调用（默认值为0）。 |
| `r.SkipInvalidDXTDimensions` | `1` | 如果设置，将跳过创建小于4x4或其他无效尺寸的DXT纹理。 |
| `r.SkipRedundantTransformUpdate` | `1` | 如果代理允许，则跳过更新UpdatePrimitiveTransform将被重复调用。 |
| `r.StencilForLODDither` | `0` | 是否在预通道中使用模板测试，在基础通道中使用深度相等测试来实现LOD抖动。 禁用后，LOD抖动将通过预通道和基础通道中的clip()指令完成，这会禁用EarlyZ。 启用后，强制执行完整的预通道。 |
| `r.StencilLODMode` | `2` | 指定抖动LOD模板模式。 0：图形通道。 1：计算通道（在受支持的平台上）。 2：计算异步通道（在受支持的平台上）。 |
| `r.TrackCsvNamedEvents` | `false` | 是否在csv分析器中记录具名事件 |
| `r.TriangleOrderOptimization` | `1` | 控制在优化后变换缓存的三角形顺序时使用的算法。 0：使用NVTriStrip（较慢） 1：使用Forsyth算法（最快）（默认）2：无三角形顺序优化。（效率最低，仅用于调试目的） |
| `r.UITextureLODBias` | `0` | 将额外的LOD偏差应用于UI纹理。（默认值=0） |
| `r.UniformBufferPooling` | `1` | 如果在RHICreateUniformBuffer中池化对象，则创建缓冲区的实际API调用会减少 0：关闭（用于调试）1：开启（优化） |
| `r.UniformExpressionCacheAsyncUpdates` | `1` | 是否允许异步更新统一表达式缓存。 |
| `r.Upscale.Panini.D` | `0` | 允许并配置以将Panini失真应用于已渲染的图像。0到1之间的值可以消退效果（插值）。 Panini研究文章中的实现方案：用于渲染广角透视图像的新投影" 0：关闭（默认） >0：启用（如果不使用上采样，则需要额外的后期处理通道 - 参见r.ScreenPercentage） 1：Panini圆柱立体投影" |
| `r.Upscale.Panini.S` | `0` | Panini投影的硬垂直压缩因子。 0：无垂直压缩因子（默认） 1：硬垂直压缩 |
| `r.Upscale.Panini.ScreenFit` | `1` | Panini投影屏幕适配效果因子（插值）。 0：垂直适配 1：水平适配（默认） |
| `r.Upscale.Quality` | `3` | 定义ScreenPercentage和WindowedFullscreen缩放3D渲染的质量。 0：最近过滤 1：简单双线性 2：使用不锐化遮罩上采样的定向模糊。 3：5抽头Catmull-Rom双三次，近似于Lanczos 2。（默认） 4：13抽头Lanczos 3。 5: 36抽头高斯滤波不锐化遮罩（开销非常高，但适合极端上采样）。 |
| `r.Upscale.Softness` | `1` | 高斯不锐化滤波器的锐化量（r.UpscaleQuality=5）。如果振铃可见则减少 1：正常锐化（默认） 0：无锐化（纯高斯）。 |
| `r.UseClusteredDeferredShading` | `0` | 为支持群集延迟着色的光源切换使用此功能。0为关闭（默认），1为开启（还需要SM5才能实际开启）。 |
| `r.UseFastDebugObjectDiscovery` | `1` | 启用新的优化调试对象发现 |
| `r.UseLegacyMaintainYFOVViewMatrix` | `false` | 当纵横比约束为垂直时，是否使用旧方法计算透视图矩阵 |
| `r.Velocity.EnableLandscapeGrass` | `true` | 指定是否要为WPO的草组件输出速度。 True（默认） False |
| `r.Velocity.EnableVertexDeformation` | `2` | 使带有世界位置偏移和/或世界置换的材质能够在速度通道期间输出速度，即使Actor没有移动时也不例外。 0=关闭，1=开启，2=自动（默认）。 如果r.VelocityOutputPass=2，则自动设置关闭，否则开启。 当r.VelocityOutputPass=2时，由于额外的绘制调用，这可能会导致性能开销本。 |
| `r.Velocity.ForceOutput` | `0` | 强制在所有图元上输出速度。 除非r.VelocityOutputPass=1，否则这可能会导致性能开销。 但这对于测试速度输出未按预期启用的情况很有用。 0：禁用（默认） 1：启用 |
| `r.VelocityOutputPass` | `0` | 何时写入速度缓冲区。 0：在深度通道期间渲染。这会将深度通道分为2个阶段：有速度和无速度。 1：在常规基础通道期间渲染。这会在基础通道渲染过程中添加一个额外GBuffer目标。2：在常规基础通道之后渲染。 |
| `r.VelocityTest` | `0` | 允许为速度渲染启用一些低级别测试代码（影响对象运动模糊和时间抗锯齿）。0：关闭（默认） 1：向存储骨骼网格体骨骼数据的缓冲区添加随机数据来测试代码是否（也适合在暂停状态下测试）。 |
| `r.VertexDeformationOutputsVelocity` | `-1` | 控制台变量已废弃。改用r.Velocity.EnableVertexDeformation。 |
| `r.VertexFoggingForOpaque` | `1` | 使不透明材质使用逐顶点雾效，这样成本更低，并且能与MSAA完美集成。 仅支持用于正向着色。 |
| `r.ViewHasTileOffsetData` | `1` | 1：将低精度的tileoffset视图数据上传到GPU，0：仅使用更高精度的双精度浮点数。 |
| `r.ViewRectUseScreenBottom` | `0` | 警告：这是一项不受支持的试验性功能，并不适用于所有后期处理（例如DOF和DFAO） 启用后，视图矩形将使用左下角而不是左上角 |
| `r.ViewTextureMipBias.Min` | `-2` | 自动视图Mip偏差的最小值（默认为-2）。 |
| `r.ViewTextureMipBias.Offset` | `-0.3` | 自动视图Mip偏差的常量偏移（默认为-0.3）。 |
| `r.VisualizeLightingOnProbes` | `0` | 启用调试探针渲染，以可视化散布在世界中的简单球体上的漫反射/高光度光照（直接和间接）。0：禁用。 1：仅限摄像机探头。 2：仅限世界探头。 3：摄像机和世界探头。 |
| `r.VisualizeOccludedPrimitives` | `0` | 为所有被遮挡图元绘制盒体 |
| `r.VisualizeTexture.AllowBlinking` | `1` | 在可视化NaN或inf时是否允许闪烁，因为随着时间的推移，这些闪烁可能会变得恼人。 |
| `r.VolumetricLightmap.VisualizationMinScreenFraction` | `0.001` | 体积光照贴图可视化球体的最小屏幕尺寸 |
| `r.VolumetricLightmap.VisualizationRadiusScale` | `0.01` | 缩放用于可视化体积光照贴图示例的球体大小。 |
| `r.VolumetricRenderTarget` | `1` |  |
| `r.VolumetricRenderTarget.MinimumDistanceKmToEnableReprojection` | `0` | 这是在启用前一帧数据的重新投影之前 `云表面` 必须达到的距离，以公里为单位。可以从4公里这个值开始。这有助于隐藏由于云深度近似为单一前表面时不完美而导致的重新投影问题，尤其是在穿过云层时明显可见。虽然方法并不完美，但在很多情况下会有帮助。使用此方法的问题是：当距离较近时，云会显得噪点更多。 |
| `r.VolumetricRenderTarget.Mode` | `0` | [0]四分之一分辨率追踪 + 以半分辨率重构 + 上采样[1]半分辨率追踪 + 全分辨率重构 + 上采样[2]以四分之一分辨率追踪 + 全分辨率重构（不能与不透明网格体相交并强制执行UpsamplingMode=2 [3] Cinematic模式，在渲染目标中以全分辨率完成追跟踪，以便云也可以应用于半透明。） |
| `r.VolumetricRenderTarget.PreferAsyncCompute` | `0` | 是否优先使用异步计算来生成体积云渲染目标。 |
| `r.VolumetricRenderTarget.ReprojectionBoxConstraint` | `0` | 重新投影的数据是否应限制为新传入的云数据相邻值。 |
| `r.VolumetricRenderTarget.UpsamplingMode` | `4` | 用于在场景中合成体积RT。[0]双线性[1]双线性 + 抖动[2]最近 + 深度测试[3]双线性 + 抖动 + 保持最近[4]双边上采样 |
| `r.VolumetricRenderTarget.UvNoiseSampleAcceptanceWeight` | `20` | 当r.VolumetricRenderTarget.UpsamplingMode处于使用抖动的模式时使用 - 此值根据噪声云样本的相似性控制其接受度。值越高表示较大的差异将不太容易被接受用于混合。 |
| `r.Voxel` | `0` |  |
| `r.VoxelLevel2` | `1` |  |
| `r.VoxelMethod` | `0` |  |
| `r.VSync` | `0` | 0：VSync已禁用。 （默认） 1：VSync已启用。 |
| `r.VSyncEditor` | `0` | 0：在编辑器中禁用VSync。(默认) 1：在编辑器中启用VSync。 |
| `r.WarningOnRedundantTransformUpdate` | `0` | 当重复调用UpdatePrimitiveTransform时发出警告。 |
| `r.WarnOfBadDrivers` | `1` | 在引擎启动时检查当前的GPU驱动程序，警告用户有关问题并建议使用特定版本。 驱动程序拒绝列表用于根据发布日期和/或驱动程序版本检查不良驱动程序。 0：关闭 1：检查驱动程序，如果驱动程序被列入拒绝列表，则显示弹出消息（默认） |
| `r.WarpCulling` | `0` | 为支持扭曲剔除（Warp Culling）优化的平台启用该优化。 0：禁用（默认） 1：启用 |
| `r.WideCustomResolve` | `0` | 启用MSAA时使用宽自定义解析过滤器 0：禁用[硬件盒体过滤器]1：宽（r=1.25，12个样本）2：较宽（r=1.4，16个样本）3：最宽（r=1.5，20个样本） |
| `r.WireframeCullThreshold` | `5` | 正交线框视图中低于该阈值的对象将被剔除。 |
| `r.XGEController.AvoidUsingLocalMachine` | `1` | XGE任务是否应避免在本地机器上运行（以减少本地异步和进程外工作的超额订阅）。 0：不要避免。分布式任务将在所有可用的XGE代理上生成。可能导致发起方机器的超额订阅。 1：避免在本地（启动器）机器上生成任务，除非运行commandlet或传递-buildmachine（默认）。 2：避免在本地（启动器）机器上生成任务。 |
| `r.XGEController.Enabled` | `1` | 启用或禁用在引擎中针对各种编译任务使用XGE。 0：仅限本地构建。 1：使用XGE分发构建（默认）。 |
| `r.XGEController.Timeout` | `2` | 所有任务完成后关闭控制器前要等待的时间，以秒为单位。（默认值：2秒）。 |
| `r.XGEShaderCompile.MinBatchSize` | `50` | 此控制台变量已弃用，请使用r.ShaderCompiler.DistributedMinBatchSize |
| `rContextMenu.PercentageMatchWeightMultiplier` | `1` | 一个乘数，用于根据匹配的百分比给予某对象多少权重 |
| `ref.AllowParallelCollection` | `1` | 用于控制并行引用集合。 |

### 环境光遮蔽

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.AmbientOcclusion.AsyncComputeBudget` | `1` | 定义使用哪个级别的EAsyncComputeBudget来平衡AsyncCompute工作和Gfx工作。 仅当SSAO的计算版本处于活动状态时才有影响（需要CS支持、由控制台变量启用、单通道、无法线） 这是一项低级别开发者调整，可在支持AsyncCompute的硬件上获得最佳性能。 0：最少AsyncCompute 1：..（默认） 2：.. 3：.. 4：最多AsyncCompute |
| `r.AmbientOcclusion.Compute` | `0` | SSAO使用ComputeShader（并非所有平台上都可用）或PixelShader。 [Async]Compute Shader版本处于WIP阶段，尚未优化，需要硬件支持（非移动/DX10/OpenGL3），不使用法线，使它可以在EarlyZPass之后立即运行（与AyncCompute一起使用时性能更佳） AyncCompute目前仅适用于PS4。 0：PixelShader（默认） 1：（WIP）如果可行，使用ComputeShader，否则回退到‘0’ 2：（WIP）如果高效，使用AsyncCompute，否则回退到‘1’ 3：（WIP）如果可行，使用AsyncCompute，否则回退到‘1’ |
| `r.AmbientOcclusion.Compute.Smooth` | `1` | 当TAA禁用时是否平滑SSAO输出 |
| `r.AmbientOcclusion.Denoiser` | `2` | 选择降噪算法。 0：禁用； 1：强制使用渲染器的默认降噪器；2：GScreenSpaceDenoiser，可能会被第三方插件重载（默认值）。 |
| `r.AmbientOcclusion.Denoiser.HistoryConvolution.KernelSpreadFactor` | `7` | 应用于核样本偏移的乘法因子（默认值=7）。 |
| `r.AmbientOcclusion.Denoiser.HistoryConvolution.SampleCount` | `1` | 用于历史记录后滤波器的样本数量（默认值=16）。 |
| `r.AmbientOcclusion.Denoiser.KernelSpreadFactor` | `4` | 预卷积通道的扩散因子。 |
| `r.AmbientOcclusion.Denoiser.PreConvolution` | `2` | 预卷积通道的数量（默认值=1）。 |
| `r.AmbientOcclusion.Denoiser.ReconstructionSamples` | `16` | 重构通道的样本数量上限（默认值=16）。 |
| `r.AmbientOcclusion.Denoiser.TemporalAccumulation` | `1` | 在多个帧上累积样本。 |
| `r.AmbientOcclusion.DepthBoundsTest` | `1` | 是否在环境光遮蔽通道期间使用深度边界测试剔除远距离像素。此选项仅在使用像素着色器路径(r.AmbientOcclusion.Compute=0)且不进行上采样时有效。 |
| `r.AmbientOcclusion.FadeRadiusScale` | `1` | 允许缩放环境光遮蔽消退半径（SSAO）。 0.01：最小..1.0：正常（默认），<1：较小，>1：较大 |
| `r.AmbientOcclusion.Method` | `0` | 选择SSAO方法 0：SSAO（默认） 1：GTAO |
| `r.AmbientOcclusionLevels` | `-1` | 定义在环境光遮蔽计算期间使用多少个Mip级别。这在调整算法时很有用。 <0：根据后期处理设置/体积中的质量设置和r.AmbientOcclusionMaxQuality（默认）决定 0：无（禁用AmbientOcclusion） 1：一 2：二（额外性能开销，软添加） 3：三（半径越大开销越低，但可能会闪烁） |
| `r.AmbientOcclusionMaxQuality` | `100` | 定义ScreenSpace环境光遮蔽后期处理体积质量级别的最大限制值 100：不重载后期处理体积的质量级别（默认） 0..99：将后期处理体积的质量级别限制为由此控制台变量设置的最大值 -100..0：即使后期处理体积要求较低的质量，也会强制执行不同的质量（绝对值）。 |
| `r.AmbientOcclusionMipLevelFactor` | `0.4` | 根据SSAO步骤id控制mipmap级别 0：始终查看HZB mipmap级别0（内存缓存破坏） 0.5：样本数取决于后期处理设置（默认） 1：进入更高的mipmap级别（质量损失） |
| `r.AmbientOcclusionRadiusScale` | `1` | 允许缩放环境光遮蔽半径（SSAO）。 0：关闭，1.0：正常，<1：较小，>1：较大 |
| `r.AmbientOcclusionStaticFraction` | `-1` | 允许重载环境光遮蔽静态分数（参见后期处理体积）。分数介于0和1之间。 <0：使用默认设置（默认-1） 0：对静态光照没有影响，0为自由，表示没有额外的渲染通道 1：环境光遮蔽影响静态光照 |
| `r.AOApplyToStaticIndirect` | `0` | 是否将DFAO作为间接阴影应用于静态间接源（光照贴图 + 固定天空光照 + 反射捕获） |
| `r.AOAsyncBuildQueue` | `1` | 是否从网格体异步编译距离场体积数据。 |
| `r.AOAverageObjectsPerCullTile` | `512` | 确定在距离场对象剔除数据结构中应分配多少内存。 太多 = 浪费内存，太少 = 因缓冲溢出而闪烁。 |
| `r.AOClearHistory` | `0` |  |
| `r.AOComputeShaderNormalCalculation` | `0` | 是否使用距离场法线计算的计算着色器版本。 |
| `r.AOGlobalDFClipmapDistanceExponent` | `2` | 用于派生每个裁剪图大小的指数，与r.AOInnerGlobalDFClipmapDistance结合使用。 |
| `r.AOGlobalDFResolution` | `128` | 全局距离场的分辨率。 值越高，保真度越高，但内存和合成开销也越高。 |
| `r.AOGlobalDFStartDistance` | `100` | 沿椎体轨迹的世界空间距离可切换到使用全局距离场，而不是对象距离场。 这个值必须足够大才能隐藏全局距离场的低分辨率特性，但较小的值会加速椎体追踪。 |
| `r.AOGlobalDistanceField` | `1` | 是否使用全局距离场来优化遮挡椎体追踪。 全局距离场通过将对象距离场合成到裁剪图中来创建，因为观看者会在关卡中移动。 |
| `r.AOGlobalDistanceField.AverageCulledObjectsPerCell` | `512` | 每个剔除网格单元的平均预期对象数，用于为剔除网格预分配内存。 |
| `r.AOGlobalDistanceField.CameraPositionVelocityOffsetDecay` | `0.7` |  |
| `r.AOGlobalDistanceField.DetailedNecessityCheck` | `1` | 是否在FSceneRenderer::ShouldPrepareGlobalDistanceField()中执行详细的必要性检查。 |
| `r.AOGlobalDistanceField.FastCameraMode` | `0` | 是否更新全局SDF以实现快速摄像机移动 - 质量降低，更新速度加快，以便光照可以跟上摄像机的步伐。 |
| `r.AOGlobalDistanceField.ForceRecacheForStreaming` | `0` | 当检测到裁剪图有待处理流送时，这对于调试或分析发生的完整裁剪图更新很有用。 |
| `r.AOGlobalDistanceField.Heightfield` | `1` | 是否将高度场体素化到全局距离场中。 |
| `r.AOGlobalDistanceField.MinMeshSDFRadius` | `20` | 将从全局SDF中剔除世界空间半径小于此值的网格体。 |
| `r.AOGlobalDistanceField.MinMeshSDFRadiusInVoxels` | `0.5` | 将从全局SDF中剔除半径小于此体素数量的网格体。 |
| `r.AOGlobalDistanceField.MipFactor` | `4` | 距离场裁剪图的Mip贴图的分辨率分频器。 |
| `r.AOGlobalDistanceField.NumClipmaps` | `4` | 全局距离场中的裁剪图数量。 目前仅Lumen支持将其设置为4以外的值。 |
| `r.AOGlobalDistanceField.OccupancyRatio` | `0.3` | 页面图集分配的预期稀疏全局距离场占用率。0.25表示25%已填充，75%为空。 |
| `r.AOGlobalDistanceField.RecacheClipmapsWithPendingStreaming` | `1` | 是否回读由于流送而缓存了不完整网格体SDF的裁剪图，并在后续帧中重新缓存裁剪图。修复传送或加载新关卡后摄像机周围不准确的全局SDF。 |
| `r.AOGlobalDistanceFieldCacheMostlyStaticSeparately` | `1` | 是否将大多数静态图元与可移动图元分开缓存，从而降低修改可移动图元时的全局DF更新开销。 添加另外12Mb的体积纹理。 |
| `r.AOGlobalDistanceFieldClipmapUpdatesPerFrame` | `2` | 每帧更新多少裁剪图。 如果值小于2，则第一个裁剪图仅每隔一帧更新一次，这可能会导致移动过程中不正确的自我遮挡。 |
| `r.AOGlobalDistanceFieldForceFullUpdate` | `0` | 是否强制每帧更新完整的全局距离场。 |
| `r.AOGlobalDistanceFieldForceUpdateOnce` | `0` | 是否强制执行一次完整的全局距离场。 |
| `r.AOGlobalDistanceFieldPartialUpdates` | `1` | 是否允许部分更新全局距离场。 在进行分析时，禁用此功能并获取镜头切换时发生的最坏情况合成时间很有用。 |
| `r.AOGlobalDistanceFieldRepresentHeightfields` | `1` | 是否将地形放入全局距离场中。 更改此项在全局距离场重新缓存（飞离并返回）之前不会产生影响。 |
| `r.AOGlobalDistanceFieldStaggeredUpdates` | `1` | 是否允许较大的裁剪图以较低的频率更新。 |
| `r.AOHistoryDistanceThreshold` | `30` | 丢弃最后一帧的DFAO结果所需的世界空间距离阈值。 值越低，靠近墙壁时角色的重影越少，但闪烁瑕疵会越多。 |
| `r.AOHistoryStabilityPass` | `1` | 是否采集稳定的结果以填补时间重投影中的洞。 这会增加一些GPU开销，但会提高植被的时间稳定性。 |
| `r.AOHistoryWeight` | `0.85` | 最后一帧的环境光遮蔽量将插值到最终结果中。 值越高，稳定性越高；值越低，遮挡物移动时的纹路越少。 |
| `r.AOJitterConeDirections` | `0` |  |
| `r.AOMaxViewDistance` | `20000` | 计算环境光遮蔽的最大距离。 |
| `r.AOObjectDistanceField` | `1` | 确定是否使用对象距离场来计算环境光遮蔽。 禁用此选项时，将仅使用全局距离场。 |
| `r.AOOverwriteSceneColor` | `0` |  |
| `r.AOQuality` | `2` | 定义允许质量或性能调整的距离场环境光遮蔽方法。 0：关闭，1：中等，2：高（默认） |
| `r.AOSampleSet` | `1` | 0 = 原始集，1 = 松弛集 |
| `r.AOScatterTileCulling` | `1` | 是否使用光栅器将遮挡物对象合并到屏幕空间图块中。 |
| `r.AOSpecularOcclusionMode` | `1` | 确定高光度应如何被DFAO遮挡 0：将非方向性环境光遮蔽应用于高光度。 1：（默认）将反射椎体与DFAO产生的未遮挡椎体相交。 与0相比，这可以提供更准确的遮挡，但可能会产生DFAO取样瑕疵。 |
| `r.AOStepExponentScale` | `0.5` | 用于沿椎体方向分布环境光遮蔽样本的指数。 |
| `r.AOUpdateGlobalDistanceField` | `1` | 是否更新全局距离场，对调试有帮助。 |
| `r.AOUseHistory` | `1` | 是否将时间滤波器应用于距离场环境光遮蔽，这会减少闪烁，但也会在遮挡物移动时添加尾迹。 |
| `r.AOUseJitter` | `1` | 是否将4倍时间超级取样与屏幕网格DFAO结合使用。 禁用抖动后，可以使用较短的历史记录，但会出现更多空间锯齿。 |
| `r.AOViewFadeDistanceScale` | `0.7` | 环境光遮蔽在接近r.AOMaxViewDistance时高出该值即淡出的距离，r.AOMaxViewDistance的分数值。 |
| `r.ApproximateOcclusionQueries` | `0` | 即使有可移动网格体，也要对静态和骨骼网格体进行批量遮挡。一般来说，对所有网格体进行批量遮挡查询更有利 |

### Android

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.Android.DisableASTCSupport` | `0` | 如果OpenGL驱动程序支持ASTC纹理压缩，则禁用对ASTC纹理压缩的支持。（仅限Android） 0 = 如果驱动程序支持，将使用ASTC纹理压缩[默认] 1 = 不使用ASTC纹理压缩。 |
| `r.Android.DisableOpenGLES31Support` | `0` | 禁用对OpenGLES 3.1 API的支持。（仅限Android） 0 = 将使用OpenGLES 3.1 API（前提是设备和项目支持）[默认] 1 = 将禁用OpenGLES 3.1，使用Vulkan。 |
| `r.Android.DisableVulkanSM5Support` | `0` | 禁用对Vulkan API的支持。（仅限Android） 0 = 将使用Vulkan SM5 API（前提是设备和项目支持）[默认] 1 = 将禁用VulkanSM5，使用Vulkan或OpenGL回退。 |
| `r.Android.DisableVulkanSupport` | `0` | 禁用对Vulkan API的支持。（仅限Android） 0 = 将使用Vulkan API（前提是设备和项目支持）[默认] 1 = 将禁用Vulkan，使用OpenGL回退。 |
| `r.Android.OverrideExternalTextureSupport` | `0` | 重载对OpenGLES API的外部纹理支持。（仅限Android） 0 = 使用法线检测[默认] 1 = 禁用外部纹理支持 2 = 强制使用ImageExternal100（版本#100，带GL_OES_EGL_image_external） 3 = 强制使用ImageExternal300（版本#300，带GL_OES_EGL_image_external） 4 = 强制使用ImageExternalESSL300（版本#300，带GL_OES_EGL_image_external_essl3） |
| `r.AndroidDisableThreadedRendering` | `0` | 设置是否允许特定Android设备配置文件进行线程渲染。 0 = 允许线程渲染[默认] 1 = 启动时禁用渲染线程的创建 |
| `r.AndroidDisableThreadedRenderingFirstLoad` | `0` | 设置在初始加载时是否允许特定Android设备配置文件进行线程渲染。 0 = 允许在初始加载时进行线程渲染[默认] 1 = 禁用在初始加载时进行线程渲染 |

### 异步

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.AsyncCacheMaterialUniformExpressions` | `1` | 材质统一表达式缓存被卸载到异步任务。 |
| `r.AsyncCacheMeshDrawCommands` | `1` | 网格体绘制命令缓存被卸载到异步任务。 |
| `r.AsyncCreateLightPrimitiveInteractions` | `1` | 轻量级图元交互是在异步任务中脱离渲染线程创建的。 |
| `r.AsyncPipelineCompile` | `1` | 0：在请求时创建PSO 1：异步创建管线状态对象（默认） 2：仅异步创建预编译PSO 3仅异步创建非预编译PSO |

### 自动曝光

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.AutoExposure.IgnoreMaterials` | `false` | （试验性）是否在假定每个表面都使用完全漫反射白色材质的情况下计算自动曝光。 （默认值：false） |
| `r.AutoExposure.IgnoreMaterials.Debug` | `false` |  |
| `r.AutoExposure.IgnoreMaterials.DownscaleFactor` | `2` |  |
| `r.AutoExposure.IgnoreMaterials.EvaluationPositionBias` | `10` |  |
| `r.AutoExposure.IgnoreMaterials.LuminanceScale` | `0.18` |  |
| `r.AutoExposure.IgnoreMaterials.MinBaseColorLuminance` | `0.01` |  |
| `r.AutoExposure.IgnoreMaterials.ReconstructFromSceneColor` | `true` |  |
| `r.AutoExposure.IgnoreMaterials.UsePrecalculatedIlluminance` | `true` |  |
| `r.AutoExposure.LuminanceMethod` | `0` | 0 - 统一。 1 - NSTC。 2 - Rec709。 |

### 泛光

| 列 1 | 列 2 | 列 3 |
| --- | --- | --- |
| `r.Bloom.ApplyLocalExposure` | `true` | 在计算泛光时是否应用局部曝光，默认值：true |
| `r.Bloom.AsyncCompute` | `1` | 是否在异步计算时运行FFT泛光。 |
| `r.Bloom.CacheKernel` | `1` | 是否在谱域中缓存内核。 |
| `r.Bloom.ScreenPercentage` | `50` | 控制用于泛光的FFT卷积的轴分辨率。 |
| `r.Bloom.WarnKernelResolution` | `1` | 是否在核分辨率过高时发出警告。 0：禁用； 1：在主机上发出警告（默认）； 2：在所有平台上发出警告； |
| `r.BloomQuality` | `5` | 0：关闭，没有性能影响。 1：质量一般，性能影响最小。 2：质量一般，性能影响最小。 3：质量良好。 4：质量良好。 5: 质量最佳，性能影响最大。（默认） >5：在移动端强制执行试验性更高质量（在某些硬件上可能会很慢） |

### 缓冲区可视化

| 列 1 | 列 2 | 列 3 |
| --- | --- | --- |
| `r.BufferVisualizationDumpFrames` | `0` | 当请求屏幕截图或影片转储时，还保存当前缓冲区可视化材质的转储 0：关闭（默认） 1：开启 |
| `r.BufferVisualizationDumpFramesAsHDR` | `0` | 当以支持HDR的格式保存缓冲区可视化材质时 0：不重载默认保存格式。 1：强制缓冲区可视化材质采用HDR格式。 |
| `r.BufferVisualizationOverviewTargets` |  | 指定可在缓冲区可视化概览中使用的后期处理材质列表。在逗号之间不输入任何内容，留出空隙。从以下选项中选择：BaseColor、CustomDepth、CustomStencil、FinalImage、ShadingModel、MaterialAO、Metallic、Opacity、Roughness、Anisotropy、SceneColor、SceneDepth、SeparateTranslucencyRGB、SeparateTranslucencyA、Specular、SubsurfaceColor、WorldNormal、WorldTangent、AmbientOcclusion、CustomDepthWorldUnits、SceneDepthWorldUnits、Velocity、PreTonemapHDRColor、PostTonemapHDRColor。例如：`r.BufferVisualizationOverviewTargets = "BaseColor,Specular,SubsurfaceColor,WorldNormal,SeparateTranslucencyRGB,,,WorldTangent,SeparateTranslucencyA,,,Opacity,SceneDepth,Roughness,Metallic,ShadingModel,,SceneDepthWorldUnits,SceneColor,PreTonemapHDRColor,PostTonemapHDRColor"` |
| `r.BufferVisualizationTarget` |  | 当视口视图模式设置为‘缓冲区可视化’时，此命令指定显示其中哪一个通道。除下面所示允许值之外的输入值将被忽略。 BaseColor CustomDepth CustomStencil FinalImage ShadingModel MaterialAO Metallic Opacity Roughness Anisotropy SceneColor SceneDepth SeparateTranslucencyRGB SeparateTranslucencyA Specular SubsurfaceColor WorldNormal WorldTangent AmbientOcclusion CustomDepthWorldUnits SceneDepthWorldUnits Velocity PreTonemapHDRColor PostTonemapHDRColor |

### 缓存

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.Cache.DrawDirectionalShadowing` | `0` | 是否绘制由Lightmass生成的直接阴影样本点。 0为关闭（默认），1为开启 |
| `r.Cache.DrawInterpolationPoints` | `0` | 是否绘制间接光照更新时的插值位置，这些位置存储在缓存中。 可能还需要‘r.CacheUpdateEveryFrame 1’才能发挥作用，否则点在更新时会闪烁。 0为关闭（默认），1为开启 |
| `r.Cache.DrawLightingSamples` | `0` | 是否绘制由Lightmass生成的间接光照样本点。 0为关闭（默认），1为开启 |
| `r.Cache.LightingCacheDimension` | `64` | 光照缓存的尺寸。 为减少浪费，这应该是r.LightingCacheMovableObjectAllocationSize的倍数。 |
| `r.Cache.LightingCacheMovableObjectAllocationSize` | `5` | 用于照亮动态对象的插值样本体积的分辨率。 值为1或2将产生每个对象单个插值示例，这在运动时不会提供连续光照，因此会随时间的推移进行插值。 值为3或更高时，支持必要的填充，以在运动时提供连续结果。 |
| `r.Cache.LimitQuerySize` | `1` | 0为关闭，1为打开（默认） |
| `r.Cache.QueryNodeLevel` | `3` | 光照示例八叉树的级别，其节点范围应为八叉树查询的目标大小。 如果图元块大于此值，则将被分解为多个八叉树查询。0为根，12为叶级 |
| `r.Cache.ReduceSHRinging` | `1` | 是否修改间接光照缓存SH样本以减少振铃。 0为关闭，1为打开（默认） |
| `r.Cache.SampleTransitionSpeed` | `800` | 使用单样本光照时，控制两个点样本之间的过渡速度（随时间消退）。 |
| `r.Cache.UpdateEveryFrame` | `0` | 是否每帧更新间接光照缓存分配，即使它们已被缓存。 0为关闭（默认），1为开启 |
| `r.Cache.UpdatePrimsTaskEnabled` | `1` | 启用ILC图元更新线程。 将与InitViews末尾的其余部分重叠。 |
| `r.CalcLocalPlayerCachedLODDistanceFactor` | `1` | 是否应该根据当前视野计算LOD距离因子。 没有必要，因为LOD已经是基于屏幕尺寸的。 |

### 摄像机

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.CameraAnimation.LegacyPostProcessBlending` | `true` | 将摄像机动画后期处理设置混合在主摄像机之下，而不是摄像机之上 |
| `r.CameraCutTranslationThreshold` | `10000` | 自动插入镜头切换之前，两帧之间允许的最大摄像机平移距离，以厘米为单位。 |
| `r.CameraShake.LegacyPostProcessBlending` | `false` | 将摄像机晃动后期处理设置在主摄像机之下而不是之上混合 |
| `r.CameraShakeDebug` | `false` | 显示摄像机晃动的额外调试信息（需要 `showdebug CAMERA`） |
| `r.CameraShakeDebug.InfoRecordLimit` | `2` | 记录摄像机晃动调试信息时保留多少秒（默认为2秒） |
| `r.CameraShakeDebug.LargeGraph` | `false` | 为摄像机晃动调试信息绘制更大的图表 |
| `r.CameraShakeDebug.Location` | `true` | 是否显示摄像机晃动的位置修改（默认为true） |
| `r.CameraShakeDebug.Rotation` | `true` | 是否显示摄像机晃动的旋转修改（默认为true） |

### 胶囊体

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.CapsuleDirectShadows` | `1` | 是否允许在启用bCastCapsuleDirectShadow的情况下在蒙皮组件上产生胶囊体直接阴影。 |
| `r.CapsuleIndirectConeAngle` | `0.392699` | 间接阴影方向根据预计算间接光照（不存在固定天空光照）得出时使用的光源角度 |
| `r.CapsuleIndirectShadows` | `1` | 是否允许在启用bCastCapsuleIndirectShadow的情况下在蒙皮组件上产生胶囊体间接阴影。 |
| `r.CapsuleMaxDirectOcclusionDistance` | `400` | 胶囊体直接阴影的最大投射距离。 这样对性能的影响很大。 |
| `r.CapsuleMaxIndirectOcclusionDistance` | `200` | 胶囊体间接阴影的最大投射距离。 这样对性能的影响很大。 |
| `r.CapsuleMinSkyAngle` | `15` | 根据预计算的未遮挡天空向量（存在固定天空光照）得出的最小光源角度 |
| `r.CapsuleShadowFadeAngleFromVertical` | `1.0472` | 从垂直向上开始淡出间接阴影的角度，以避免自阴影瑕疵。 |
| `r.CapsuleShadows` | `1` | 是否允许在启用bCastCapsuleDirectShadow或bCastCapsuleIndirectShadow的情况下在蒙皮组件上产生胶囊体阴影。 |
| `r.CapsuleShadowsFullResolution` | `0` | 是否以全分辨率计算胶囊体阴影。 |
| `r.CapsuleSkyAngleScale` | `0.6` | 缩放根据预计算未遮挡天空向量（存在固定天空光照）得出的光源角度 |

### 捕获

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.CaptureNextDeferredShadingRendererFrame` | `-1` | 0为使用RenderDoc或PIX等捕获紧邻的下一帧。 > 0：N帧延迟 < 0：禁用 |
| `r.CaptureNextSceneCullingUpdate` | `-1` | 0为使用RenderDoc或PIX等捕获紧邻的下一帧。 > 0：N帧延迟 < 0：禁用 |

### 颜色

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.Color.Grading` | `1` | 控制是否应应用后期处理设置的颜色分级设置。 |
| `r.Color.Max` | `1` | 允许定义色彩分级之后颜色通道中的值1.0的映射位置。 值应在1左右，值越小，高光越暗，值越大，会有更多颜色趋向白色，默认值：1 |
| `r.Color.Mid` | `0.5` | 允许定义色彩分级之后颜色通道中的值0.5的映射位置（这类似于伽马校正）。 值应在0.5左右，值越小，中间色调越暗，值越大，中间色调越亮，默认值：0.5 |
| `r.Color.Min` | `0` | 允许定义色彩分级之后颜色通道中的值0的映射位置。 该值应在0左右，正值：向暗色添加灰度，负值：更多暗色值变为黑色，默认值：0 |

### 接触阴影

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.ContactShadows` | `1` | 0：禁用。 1：启用。 |
| `r.ContactShadows.Bend.OverrideSurfaceThickness` | `0.005` | 在确定光线是否与表面相交时，假定像素所代表的表面有多厚。 |
| `r.ContactShadows.Intensity.FadeLength` | `800` | 从NonCastingIntensity到CastingIntensity的消退间隔的长度。 仅在r.ContactShadows.Intensity.Mode=1时使用 |
| `r.ContactShadows.Intensity.FadeStart` | `1600` | 接触阴影开始从NonCastingIntensity到CastingIntensity的消退的深度值。 仅在r.ContactShadows.Intensity.Mode=1时使用 |
| `r.ContactShadows.Intensity.Mode` | `0` | 控制如何计算接触阴影强度： 0 - 遵循图元组件上的bCastContactShadow标记。 1 - 基于深度的近似。 2 - 使用投射强度。 |
| `r.ContactShadows.NonShadowCastingIntensity` | `0` | 已废弃。请改为直接使用光源组件上的参数。 |
| `r.ContactShadows.OverrideLength` | `-1` | 允许重载所有定向光源的接触阴影长度。 < 0时禁用。 一般应在非调试的情况下保持禁用状态。 |
| `r.ContactShadows.OverrideLengthInWS` | `false` | r.ContactShadows.OverrideLength是采用世界空间单位还是屏幕空间单位。 |
| `r.ContactShadows.OverrideNonShadowCastingIntensity` | `-1` | 允许重载所有定向光源的接触阴影非投射强度。 < 0时禁用。 一般应在非调试的情况下保持禁用状态。 |
| `r.ContactShadows.OverrideShadowCastingIntensity` | `-1` | 允许重载所有定向光源的接触阴影投射强度。 < 0时禁用。 一般应在非调试的情况下保持禁用状态。 |
| `r.ContactShadows.Standalone.Method` | `0` | 用于计算接触（屏幕空间）阴影的技巧： 0 - 随机抖动。 1 - 弯曲屏幕空间阴影。 |

### 自定义深度

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.CustomDepth` | `1` | 0：功能已禁用 1：功能已启用，纹理按需创建 2：功能已启用，纹理在需要时才发布（功能不停顿时的项目设置） 3：功能已启用，模板写入已启用，纹理在需要时才发布（功能不停顿时的项目设置） |
| `r.CustomDepth.Order` | `2` | 当CustomDepth（和CustomStencil）被渲染时 0：基础通道之前（允许在DBuffer通道中进行取样。使用AsyncCompute可以提高效率。） 1：基础通道之后 2：默认（如果启用了DBuffer，则在基础通道之前。） |
| `r.CustomDepthEnableFastClear` | `false` | 在自定义深度缓冲区上启用HTile（默认值：false）。 |
| `r.CustomDepthTemporalAAJitter` | `1` | 禁用后，引擎将从自定义深度通道中移除TemporalAA抖动。仅在使用时间抗锯齿时有效。 |
| `r.CustomUnsafeZones` |  | 允许你设置自定义不安全区域。对于"直立"的设备，基于纵向（P）或横向（L）定义。不安全区域可能是固定的，也可能是自由的，这取决于它们是否随着设备的旋转而移动。格式为（P：固定[x1, y1][宽, 高]），每个自定义不安全区域用分号分隔。+值从0开始增加，-值从高度或宽度扣减 |

### D3D

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.D3D.CheckedForTypedUAVs` | `1` | 是否不允许使用类型化UAV负载，因为负载在Windows 7 D3D 11.0中不可用。 0：允许使用类型化的UAV负载。 1：不允许使用类型化的UAV负载。（默认值） |
| `r.D3D.ForceDXC` | `0` | 强制所有D3D着色器使用DirectX着色器编译器（DXC）。使用此选项编译的着色器仅与D3D12兼容。 0：禁用（默认） 1：强制所有着色器使用新编译器 |
| `r.D3D12.AllowAsyncCompute` | `1` | 允许使用异步计算 |
| `r.D3D12.AllowPayloadMerge` | `true` | 是否尝试将命令列表合并到单个有效负载中，以节省性能开销。 主要应用于QueueAsyncCommandListSubmit。 （默认值=1） |
| `r.D3D12.AutoAttachPIX` | `0` | 启动时自动附加PIX |
| `r.D3D12.BreadCrumbs` | `1` | 启用最小开销GPU操作记录来追踪当前GPU状态，并记录GPU最后执行的操作的信息。 |
| `r.D3D12.Depth24Bit` | `0` | 0：使用32位浮点深度缓冲区 1：使用24位固定点深度缓冲区（默认） |
| `r.D3D12.DiagnosticBufferExtraMemory` | `0` | 为诊断缓冲区额外分配内存 |
| `r.D3D12.DRED` | `0` | 启用DRED GPU崩溃调试模式，用来跟踪当前GPU状态并记录GPU最后执行的操作的信息。具有GPU开销，但在崩溃或挂起时提供有关当前GPU状态的最多信息。 |
| `r.D3D12.DXR.MinimumDriverVersionAMD` | `0` | 设置在AMD GPU上启用光线追踪所需的最低驱动程序版本。 |
| `r.D3D12.DXR.MinimumDriverVersionNVIDIA` | `0` | 设置在NVIDIA GPU上启用光线追踪所需的最低驱动程序版本。 |
| `r.D3D12.DXR.MinimumWindowsBuildVersion` | `0` | 设置启用光线追踪所需的最低Windows构建版本。 |
| `r.D3D12.EnableD3DDebug` | `0` | 0为禁用d3ddebug层（默认） 1为启用错误日志记录(-d3ddebug) 2为启用错误和警告日志记录(-d3dlogwarnings) 3为启用错误和警告中断(-d3dbreakonwarning) 4为对错误启用CONTINUING(-d3dcontinueonerrors) |
| `r.D3D12.ExperimentalShaderModels` | `0` | 控制是否允许D3D12试验性着色器模型。在发布构建中不可用。（默认值=0）。 |
| `r.D3D12.ExplicitDescriptorHeap.DeduplicateSamplers` | `1` | 生成着色器绑定表时，使用详尽搜索来删除重复的取样器描述符。以牺牲一些CPU时间为代价来减少取样器堆的使用。（默认值=1） |
| `r.D3D12.ExplicitDescriptorHeap.ViewDescriptorHeapSize` | `250000` | 每个显式视图描述符堆的描述符数量上限。（默认值 = 250k，每堆约8MB） 大型场景中测得的常规描述符堆使用量约为50k。达到此限制时会报告错误，并跳过后续对象的着色器绑定。 |
| `r.D3D12.GPUTimeFromTimestamps` | `0` | 首选使用时间戳而不是GetHardwareGPUFrameTime来计算GPU帧时间 |
| `r.D3D12.GPUTimeout` | `1` | 0：禁用GPU超时；谨慎使用，因为可能会让电脑死机！ 1：启用GPU超时；GPU上花费时间过长的操作将失败（默认） |
| `r.D3D12.LightweightDRED` | `1` | 启用轻量级DRED GPU崩溃调试模式来跟踪当前GPU状态，并记录GPU最后执行的操作的信息。当GPU在所有PC硬件上崩溃或挂起时，提供有关当前GPU状态的基本信息。 |
| `r.D3D12.NvAfterMath` | `1` | 启用NvAftermath来跟踪当前GPU状态，并记录GPU最后执行的操作的信息。 仅适用于nVidia硬件，并且还会转储GPU崩溃转储。 |
| `r.D3D12.RayTracing.AllowCompaction` | `1` | 是否自动对静态加速结构执行压缩以节省GPU内存。（默认值=1） |
| `r.D3D12.RayTracing.AllowSpecializedStateObjects` | `1` | 是否使用已创建的专用RTPSO。这是为了进行性能测试，如果r.D3D12.RayTracing.SpecializeStateObjects为0则无效。（默认值=1） |
| `r.D3D12.RayTracing.CacheShaderRecords` | `1` | 自动缓存并重新使用SBT命中组记录。这将显著提高具有许多相同网格体实例的大型场景中的CPU性能。（默认值 = 1） 此模式假定统一缓冲区的内容在光线追踪资源绑定期间不会改变。 |
| `r.D3D12.RayTracing.DebugForceBuildMode` | `0` | 强制特定的加速结构编译模式（运行时不可调整）。 0：使用高级代码请求的编译模式（默认） 1：强制快速编译模式 2：强制快速追踪模式 |
| `r.D3D12.RayTracing.GPUValidation` | `0` | 是否在GPU上执行光线追踪几何体和其他结构的验证。需要着色器模型6。（默认值=0） |
| `r.D3D12.RayTracing.MaxBatchedCompaction` | `64` | 每帧压缩请求和重新编译的最大数量。（默认值=64） |
| `r.D3D12.RayTracing.SpecializeStateObjects` | `0` | 是否为每个光线生成着色器创建专门的唯一光线追踪管线状态对象。（默认值 = 0） 此选项可以为GPU生成更高效的PSO，但代价是创建时间更长和占用内存更多。需要DXR 1.1。 |
| `r.D3D12.SubmissionTimeout` | `5` | 在RHI报告GPU挂起之前，提交的GPU命令列表允许花费的最长时间，以秒为单位 |
| `r.D3D12.UseAllowTearing` | `1` | 使用d3d12启用新的dxgi翻转模式 |
| `r.DBuffer` | `1` | 启用DBuffer贴花材质混合模式。 Dbuffer贴花在基础通道之前渲染，使得它们能够正确影响静态光照和天空光照。 启用后，将强制执行完整预通道，这会增加CPU/GPU开销。 将在基础通道中进行数次纹理查找，以获取贴花属性，这会增加像素工作。 0：关闭 1：开启（默认） |

### 调试

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.Debug.DrawCurrentDebugTargetBoundingBox` | `1` | 绘制当前选定的调试目标的边界框（默认：1） |
| `r.DebugActionZone.ActionRatio` | `1` | 在没有定义安全区的平台上，FDisplayMetrics::GetDisplayMetrics将返回操作区比率（0..1） 默认值：1.0 |
| `r.DebugLightDiscardProp` | `0` | [0,1]：为了调试/性能分析目的而丢弃的光源比例。 |
| `r.DebugSafeZone.MaxDebugTextStringsPerActor` | `128` | 可以附加到给定Actor的调试字符串数量上限（<=0：无限制） |
| `r.DebugSafeZone.Mode` | `0` | 安全区域可视化模式（0..2） 0：禁用（默认） 1：显示图块安全区 2：显示操作安全区 |
| `r.DebugSafeZone.OverlayAlpha` | `0.2` | 安全区覆层的alpha值（0..1） 默认：0.2 |
| `r.DebugSafeZone.TitleRatio` | `1` | 在没有定义安全区的平台上，FDisplayMetrics::GetDisplayMetrics将返回安全区比率（0..1） 默认值：1.0 |

### 贴花

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.Decal.FadeDurationScale` | `1` | 缩放每贴花的消退时长。值越低，生命周期和消退时长越短。默认为1.0f。 |
| `r.Decal.FadeScreenSizeMult` | `1` | 控制每贴花的消退屏幕大小。与每贴花的屏幕尺寸消退阈值相乘。 尺寸越小，贴花消退越柔和。 |
| `r.Decal.NormalReprojectionEnabled` | `false` | 如果为true，则允许在DBuffer贴花上的SceneTexture节点中从前一帧进行法线重新投影，前提是深度预通道中的运动也已启用（r.VelocityOutputPass=0）。否则，回退为从深度缓冲区中提取的法线。 |
| `r.Decal.NormalReprojectionThresholdHigh` | `0.995` | 从DBuffer贴花着色器中的SceneTexture节点读取法线时，法线是几何体法线（从深度缓冲区中提取）和重新投影的前一帧法线的混合。当几何体和重新投影的法线的点积低于r.Decal.NormalReprojectionThresholdLow时，使用几何体法线。当该值高于r.Decal.NormalReprojectionThresholdHigh时，将使用重新投影的法线。否则使用两者之间的插值。 |
| `r.Decal.NormalReprojectionThresholdLow` | `0.99` | 从DBuffer贴花着色器中的SceneTexture节点读取法线时，法线是几何体法线（从深度缓冲区中提取）和重新投影的前一帧法线的混合。当几何体和重新投影的法线的点积低于r.Decal.NormalReprojectionThresholdLow时，使用几何体法线。当该值高于r.Decal.NormalReprojectionThresholdHigh时，将使用重新投影的法线。否则使用两者之间的插值。 |
| `r.Decal.StencilSizeThreshold` | `0.1` | 控制每贴花模板通道，以便更快地获得较大的（屏幕空间）贴花。这会增加每贴花的开销，因此 <0：优化被禁用 0：无论贴花有多小（屏幕空间），优化都会启用 0..1：优化已启用，值定义触发优化的最小尺寸（屏幕空间）（默认值为0.1） |
| `r.Decal.Visibility.Multithreaded` | `true` | 是否使用多线程编译可见贴花列表。0=禁用，1=启用（默认） |
| `r.DecalDepthBias` | `0.005` | 网格体贴花使用的全局深度偏差。默认值为0.005 |

### 默认值

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.DefaultBackBufferPixelFormat` | `4` | 定义默认的后缓冲区像素格式。 0：8位 RGBA 1：16位 RGBA 2：浮点RGB 3：浮点RGBA 4：10位RGB，2位Alpha |
| `r.DefaultFeature.AmbientOcclusion` | `1` | AmbientOcclusion的引擎默认值（项目设置）（后期处理体积/摄像机/游戏设置仍然可以重载） 0：关闭，将AmbientOcclusionIntensity设置为0 1：开启（默认） |
| `r.DefaultFeature.AmbientOcclusionStaticFraction` | `1` | AmbientOcclusion的引擎默认值（项目设置）（后期处理体积/摄像机/游戏设置仍然可以重载） 0：关闭，将AmbientOcclusionStaticFraction设置为0 1：开启（默认，需要额外通道，仅在存在一些烘焙光照时才有用） |
| `r.DefaultFeature.AutoExposure` | `1` | AutoExposure的引擎默认值（项目设置）（后期处理体积/摄像机/游戏设置仍然可以重载） 0：关闭，将AutoExposureMinBrightness和AutoExposureMaxBrightness设置为1 1：开启（默认） |
| `r.DefaultFeature.AutoExposure.Bias` | `1` | AutoExposure曝光偏差的引擎默认值（项目设置）（后期处理体积/摄像机/游戏设置仍然可以重载） |
| `r.DefaultFeature.AutoExposure.ExtendDefaultLuminanceRange` | `1` | AutoExposure的默认值是否应支持扩展的场景亮度范围。 这还会将PostProcessSettings.Exposure.MinBrightness、MaxBrightness、HistogramLogMin和HisogramLogMax更改为以EV100值表示，而不是以Luminance和Log2 Luminance表示。 0：旧版范围（UE4默认值） 1：扩展后的范围（UE5默认值） |
| `r.DefaultFeature.AutoExposure.Method` | `0` | AutoExposure方法的引擎默认值（项目设置）（后期处理体积/摄像机/游戏设置仍然可以重载） 0：基于柱状图（需要计算着色器，默认） 1：基础AutoExposure |
| `r.DefaultFeature.Bloom` | `1` | 泛光的引擎默认值（项目设置）（后期处理体积/摄像机/游戏设置仍然可以重载） 0：关闭，将BloomIntensity设置为0 1：开启（默认） |
| `r.DefaultFeature.LensFlare` | `0` | LensFlare的引擎默认值（项目设置）（后期处理体积/摄像机/游戏设置仍然可以重载） 0：关闭，将LensFlareIntensity设置为0 1：开启（默认） |
| `r.DefaultFeature.LightUnits` | `1` | 点光源、聚光源和矩形光源使用的默认单位 0：无单位 1：坎德拉（默认） 2：流明 |
| `r.DefaultFeature.LocalExposure.HighlightContrastScale` | `0.8` | 局部曝光高光对比度的引擎默认值（项目设置）（后期处理体积/摄像机/游戏设置仍然可以重载） |
| `r.DefaultFeature.LocalExposure.ShadowContrastScale` | `0.8` | 局部曝光阴影对比度的引擎默认值（项目设置）（后期处理体积/摄像机/游戏设置仍然可以重载） |
| `r.DefaultFeature.MotionBlur` | `1` | MotionBlur的引擎默认值（项目设置）（后期处理体积/摄像机/游戏设置仍然可以重载） 0：关闭，将MotionBlurAmount设置为0 1：开启（默认） |

### 景深

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.DepthOfField.DepthBlur.Amount` | `1` | 此比例乘数仅影响CircleDOF DepthBlur功能（值定义为半径达到50%的公里数）。 x：将现有的深度模糊量与x相乘 -x：用x（以公里为单位）重载现有的深度模糊量 1：无调整（默认） |
| `r.DepthOfField.DepthBlur.ResolutionScale` | `1` | 此比例乘数仅影响CircleDOF DepthBlur功能。这是一个临时的破解方法。 它通过分辨率增加超过1920（宽度）来线性缩放DepthBlur，只会影响大于该值的分辨率。 实际数学运算：浮点因子 = 最大值(ViewWidth / 1920 - 1, 0)；DepthBlurRadius x= 1 + 因子 x （控制台变量 - 1） 1：无调整（默认） x：如果分辨率为1920，则没有变化，如果比1920大2倍，则按x缩放半径 |
| `r.DepthOfField.DepthBlur.Scale` | `1` | 此比例乘数仅影响CircleDOF DepthBlur功能。这在r.DepthOfField.DepthBlur.ResolutionScale之后应用。 0：禁用深度模糊 x：将现有的深度模糊半径与x相乘 -x：用x重载现有的深度模糊半径 1：无调整（默认） |
| `r.DepthOfField.MaxSize` | `100` | 允许限制高斯景深半径（以获得更好的性能），默认值：100 |
| `r.DepthOfField.NearBlurSizeThreshold` | `0.01` | 设置强制禁用效果前的最小近模糊尺寸。目前仅影响Gaussian DOF。 （默认值：0.01） |
| `r.DepthOfFieldQuality` | `2` | 允许调整景深质量。目前仅完全影响BokehDOF。GaussianDOF为0表示关闭，否则为开启。 0：关闭 1：低 2：高质量（默认，自适应，速度可放慢4倍） 3：质量非常高，用于非实时过场动画，仅限CircleDOF（慢） 4：极高质量，用于非实时过场动画，仅限CircleDOF（非常慢） |
| `r.DOF.Gather.AccumulatorQuality` | `1` | 控制采集累加器的质量。 |
| `r.DOF.Gather.EnableBokehSettings` | `0` | 是否在前景和背景采集上应用散景设置。 0：禁用； 1：启用（默认）。 |
| `r.DOF.Gather.PostfilterMethod` | `1` | 用于对采集通道进行后期过滤的方法。 0：无； 1：每RGB通道中值为3x3（默认）； 2：每RGB通道最大值为3x3。 |
| `r.DOF.Gather.ResolutionDivisor` | `2` | 选择采集通道的分辨率除数。 1：以全分辨率进行通道采集； 2：以半分辨率进行通道采集（默认）。 |
| `r.DOF.Gather.RingCount` | `4` | 采集核的环数[[3; 5]]。默认值为5。 |
| `r.DOF.Kernel.MaxBackgroundRadius` | `0.025` | 屏幕空间中背景模糊半径的最大尺寸（默认值=0.025）。 |
| `r.DOF.Kernel.MaxForegroundRadius` | `0.025` | 屏幕空间中前景模糊半径的最大尺寸（默认值=0.025）。 |
| `r.DOF.Recombine.EnableBokehSettings` | `0` | 是否在重新组合通道对轻微失焦应用散景设置。 0：禁用； 1：启用（默认）。 |
| `r.DOF.Recombine.MinFullresBlurRadius` | `0.1` | 当启用轻微失焦时，在全分辨率像素宽度中使用的最小模糊半径实际上可以实现景深（默认值 = 0.1）。 |
| `r.DOF.Recombine.Quality` | `1` | 配置重组通道的质量。 0：无轻微失焦； 1：轻微失焦24spp； 2：轻微失焦32spp（默认）。 |
| `r.DOF.Scatter.BackgroundCompositing` | `2` | 背景混合散射的合成模式。 0：禁用； 1：叠加； 2：采集遮挡（默认）。 |
| `r.DOF.Scatter.EnableBokehSettings` | `1` | 是否在散射时启用散景设置。 0：禁用； 1：启用（默认）。 |
| `r.DOF.Scatter.ForegroundCompositing` | `1` | 前景混合散射的合成模式。 0：禁用； 1：叠加（默认）。 |
| `r.DOF.Scatter.MaxSpriteRatio` | `0.1` | 散射像素四边形作为Sprite的最大比例，可用于控制景深的散射上限。 1将允许散射100%像素四边形，而0.2将仅允许20%（默认值 = 0.1）。 |
| `r.DOF.Scatter.MinCocRadius` | `3` | 散射所需的最小Coc半径（默认值 = 3）。 |
| `r.DOF.Scatter.NeighborCompareMaxColor` | `10` | 控制在比较像素颜色和邻近颜色之前应用的线性颜色限制上限。太低可能散射得不够；太高可能会在高光中散射过多（默认：10)。 |
| `r.DOF.TemporalAAQuality` | `1` | 在景深中完成的时间抗锯齿通道的质量。 0：速度更快，但质量更低；1：质量更高的通道（默认）。 |

### 距离场

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.DFDistanceScale` | `1` | 缩放定向光源属性‘DistanceField Shadows Distance’的因子，限制为[0.0001, 10000]。 即：DistanceFieldShadowsDistance *= r.DFDistanceScale. [0.0001,1)：距离更短 1：正常（默认） (1,10000]：距离更大。) |
| `r.DFFarTransitionScale` | `1` | 用于修改距离场阴影的远过渡（淡出）的长度。 1.0：（默认）按照和其他级联相同的方式计算。0.0：禁用淡出。 |
| `r.DFFullResolution` | `0` | 1 = 全分辨率距离场阴影，0 = 双边上采样的半分辨率。 |
| `r.DFShadow.TwoSidedMeshDistanceBiasScale` | `1` | 计算双面网格体的距离场阴影时应用于距离偏差的比例。这对于使树阴影与标准阴影贴图相匹配非常有用。 |
| `r.DFShadowAsyncCompute` | `0` | 是否使用异步计算渲染距离场阴影（如果可以） |
| `r.DFShadowAverageObjectsPerCullTile` | `128` | 确定在距离场对象剔除数据结构中应分配多少内存。 太多 = 浪费内存，太少 = 因缓冲溢出而闪烁。 |
| `r.DFShadowCompactCulledObjects` | `1` | 使用散射图块剔除时，是否压缩已剔除的对象索引。请注意，当不使用压缩时，每个图块最多只能容纳r.DFShadowAverageObjectsPerCullTile个对象。 |
| `r.DFShadowCullTileWorldSize` | `200` | 用于剔除定向光源的图块的世界空间大小。 |
| `r.DFShadowQuality` | `3` | 定义允许质量或性能调整的距离场阴影方法。 0：关闭，1：低（20步，无SSS），2：中（32步，无SSS），3：高（64步，SSS，默认） |
| `r.DFShadowScatterTileCulling` | `1` | 是否使用光栅化器将对象散射到图块网格上进行剔除。 |
| `r.DistanceFieldAO` | `1` | 是否允许距离场环境光遮蔽功能，该功能用于实现来自静态网格体的可移动天空光照的阴影。 |
| `r.DistanceFieldAO.MultiView` | `1` | 渲染多个视图时是否允许距离场环境光遮蔽功能。 |
| `r.DistanceFieldAO.TraverseMips` | `1` | 是否在针对对象SDF追踪环境光遮蔽椎体时遍历Mip。 |
| `r.DistanceFields` | `1` | 启用距离场渲染。 0：禁用。 1：启用。 |
| `r.DistanceFields.BlockAllocatorSizeInBricks` | `16` | 距离场块分配器的分配粒度。数值越高，填充时耗费的内存越多，但分配速度越快。 |
| `r.DistanceFields.BrickAtlasMaxSizeZ` | `32` | 网格体距离场图集的最大深度目标，以8^3块为单位。 32 => 128 x 128 x 32 x 8^3 = 256Mb。 由于mip2始终处于加载状态，因此实际图集大小可能会超出范围。 |
| `r.DistanceFields.BrickAtlasSizeXYInBricks` | `128` | 控制图集的分配粒度，在Z方向上增加。 |
| `r.DistanceFields.Debug.ForceNumMips` | `0` | 设置为> 0时，将重载流送所需的Mip数量。 1 = 仅加载最低分辨率Mip，3 = 加载所有Mip。 Mip仍将受到图集中可用空间的限制。 |
| `r.DistanceFields.Debug.ResizeAtlasEveryFrame` | `0` | 是否每帧调整距离场图集的大小，这对于调试很有用。 |
| `r.DistanceFields.DefaultVoxelDensity` | `0.2` | 确定网格体的默认刻度如何转换成距离场体素维度。 更改此值将导致重新编译所有距离场。 值越大，内存的占用速度可能会越快！ |
| `r.DistanceFields.DefragmentIndirectionAtlas` | `1` | 当距离场间接图集需要调整大小时，是否对其进行碎片清理。 |
| `r.DistanceFields.LogAtlasStats` | `0` | 设置为1以转储图集统计数据，设置为2以转储图集和SDF资产统计数据。 |
| `r.DistanceFields.MaxIndirectionAtlasSizeXYZ` | `512` | 间接图集纹理的最大尺寸 |
| `r.DistanceFields.MaxObjectBoundingRadius` | `100000` | 大于此尺寸的对象将不会包含在网格体距离场场景中，以提高性能。 |
| `r.DistanceFields.MaxPerMeshResolution` | `256` | 单个静态网格体资产允许的最高分辨率（在一个维度上），用于限制大规模网格体的内存使用量。 更改此值将导致重新编译所有距离场。 值越大（如512），内存的占用速度可能会越快！（512时，一个资产占用64Mb） |
| `r.DistanceFields.MinIndirectionAtlasSizeXYZ` | `64` | 间接图集纹理的最小尺寸 |
| `r.DistanceFields.OffsetDataStructure` | `0` | 存储偏移的数据结构，0 - 基类，1 - 缓冲区，2 - 纹理 |
| `r.DistanceFields.ParallelUpdate` | `0` |  |
| `r.DistanceFields.ReverseAtlasAllocationOrder` | `0` |  |
| `r.DistanceFields.SupportEvenIfHardwareRayTracingSupported` | `1` | 当支持硬件光线跟踪时，是否支持距离场。 当支持硬件光线跟踪时，将其设置为0将跳过距离场开销。 |
| `r.DistanceFields.SurfaceBiasExpand` | `0.25` | 网格体SDF体素的分数用于在相交期间扩展表面。 扩展表面可提高呈现质量，但代价是过度遮挡。 |
| `r.DistanceFields.TextureUploadLimitKBytes` | `8192` | 通过流送请求每帧上传的距离场纹理数据的最大KB数。 |
| `r.DistanceFieldShadowing` | `1` | 是否允许距离场阴影功能。 |

### 漫反射

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.DiffuseColor.Max` | `1` | 通过将漫反射颜色1重新映射到新值(0..1)来进行快速材质测试，仅适用于非发布编译阶段！ 1：（默认值） |
| `r.DiffuseColor.Min` | `0` | 通过将漫反射颜色1重新映射到新值(0..1)来进行快速材质测试，仅适用于非发布编译阶段！ 1：（默认值） |
| `r.DiffuseIndirect.Denoiser` | `1` | 降噪选项（默认值 = 1） |
| `r.DiffuseIndirect.HalfRes` | `1` | TODO(Guillaume) |
| `r.DiffuseIndirect.RayPerPixel` | `6` | TODO(Guillaume) |
| `r.DiffuseIndirectForceCopyPass` | `false` | 强制使用复制通道而不是双源混合。（用于调试） |
| `r.DiffuseIndirectOffUseDepthBoundsAO` | `true` | 当禁用DiffuseIndirect时，应用环境光遮蔽时使用深度边界。 |

### 转储GPU

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.DumpGPU.Buffer` | `2` | 是否转储缓冲区。 0：忽略所有缓冲区 1：仅转储缓冲区的描述符 2：转储缓冲区的描述符和二进制文件（默认） |
| `r.DumpGPU.CameraCut` | `0` | 是否在转储的第一帧上发出镜头切换。 |
| `r.DumpGPU.ConsoleVariables` | `1` | 是否转储渲染控制台变量（默认启用）。 |
| `r.DumpGPU.Delay` | `0` | 转储帧前的延迟，以秒为单位。 |
| `r.DumpGPU.Directory` |  | 转储的目标目录。 |
| `r.DumpGPU.Draws` | `0` | 是否在每次单独的绘制调用后转储资源（默认情况下禁用）。 |
| `r.DumpGPU.DumpOnScreenshotTest` | `0` | 允许在使用r.DumpGPU命令时过滤树，模式匹配区分大小写。 |
| `r.DumpGPU.Explore` | `1` | 是否在完成时打开文件资源管理器到GPU转储的位置（默认启用）。 |
| `r.DumpGPU.FixedTickRate` | `0` | 重载引擎的函数更新率，使每转储帧的值固定（默认值=0）。 |
| `r.DumpGPU.FrameCount` | `1` | 要转储的连续帧数（默认值=1）。 |
| `r.DumpGPU.Mask` | `1` | 是否在每个通道的名称中包含GPU掩码（除非系统有多个GPU，否则无效）。 |
| `r.DumpGPU.MaxStagingSize` | `64` | 说明资源的最大大小，以MB为单位）（默认值=64）。 |
| `r.DumpGPU.PassParameters` | `1` | 是否转储通道参数。 |
| `r.DumpGPU.Root` | `*` | 允许在使用r.DumpGPU命令时过滤树，模式匹配区分大小写。 |
| `r.DumpGPU.Screenshot` | `1` | 是否截取最终屏幕截图。 |
| `r.DumpGPU.Stream` | `0` | 从GPU异步读回到磁盘。 0：从GPU同步复制到磁盘，并格外小心以避免内存不足（默认）； 1：使用专用暂存资源池，从GPU异步复制到磁盘。可能会导致内存不足。请考虑使用r.DumpGPU.Root来最小化流送通道的数量，并使用r.Test.SecondaryUpscaleOverride来减少资源大小，从而最小化每帧出现内存不足磁盘带宽瓶颈的情况。 |
| `r.DumpGPU.Test.EnableDiskWrite` | `1` | 主开关，是否应将任何文件写入磁盘，用于r.DumpGPU自动化测试以免填满工作人员的硬盘。 |
| `r.DumpGPU.Test.PrettifyResourceFileNames` | `0` | 资源文件名是否应包含资源名称。可能会增加遇到Windows文件路径限制的可能性。 |
| `r.DumpGPU.Texture` | `2` | 是否转储纹理。 0：忽略所有纹理 1：仅转储纹理的描述符 2：转储纹理的描述符和二进制文件（默认） |
| `r.DumpGPU.Upload` | `1` | 如果设置，允许自动上传GPU转储。 |
| `r.DumpGPU.Upload.CompressResources` | `1` | 是否压缩资源二进制文件。 0：禁用（默认） 1：Zlib 2：GZip |
| `r.DumpGPU.Viewer.Visualize` |  | 在转储查看器中自动打开的RDG输出资源的名称。 |

### 动态分辨率

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.DynamicRes.ChangePercentageThreshold` | `2` | 更改分辨率时允许的最小增加百分比阈值。 |
| `r.DynamicRes.DynamicFrameTime` | `1` | 当帧速率受CPU限制时，r.DynamicRes.FrameTimeBudget是否应自动增加。 |
| `r.DynamicRes.DynamicFrameTime.ErrorMarginPercent` | `10` | CPU和GPU之间应留出多少余量。 |
| `r.DynamicRes.DynamicFrameTime.RoundUpToVSyncError` | `10` | 用于将动态帧时间四舍五入到垂直同步边界的误差（默认值=10%）。 |
| `r.DynamicRes.DynamicFrameTime.Track` | `1` | 跟踪什么来控制预算 0：帧时（但对于GPU受限和VSync情形，可以创建反馈循环）；1：线程时间（默认）； |
| `r.DynamicRes.FrameTimeBudget` | `33.3` | 帧的时间预算，以毫秒为单位。 |
| `r.DynamicRes.FrameWeightExponent` | `0.9` | 第N-1帧对第N帧的递归权重。 |
| `r.DynamicRes.GPUTimingMeasureMethod` | `0` | 选择用于测量GPU时间的方法。 0：与统计单位相同（默认）； 1：时间戳查询。 |
| `r.DynamicRes.HistorySize` | `16` | 历史记录中保存的帧数。 |
| `r.DynamicRes.IncreaseAmortizationBlendFactor` | `0.9` | 当比例分辨率备份以减少分辨率分数振荡时的分摊混合因子。 |
| `r.DynamicRes.MaxConsecutiveOverBudgetGPUFrameCount` | `2` | GPU预算容忍的连续帧数上限。 |
| `r.DynamicRes.MaxScreenPercentage` | `100` | 最大主屏幕百分比。重要的是，此设置将控制渲染器渲染所需的预分配显存。 |
| `r.DynamicRes.MinResolutionChangePeriod` | `8` | 分辨率变化之间的最小帧数，这对于避免TAA上采样中的输入样本位置干扰很重要。 |
| `r.DynamicRes.MinScreenPercentage` | `50` | 最小主屏幕百分比。 |
| `r.DynamicRes.OperationMode` | `0` | 选择动态分辨率的操作模式。 0：禁用（默认）； 1：根据游戏用户设置启用； 2：无论游戏用户设置如何均启用。 |
| `r.DynamicRes.OverBudgetGPUHeadRoomPercentage` | `0` | 所需的GPU余量，若超过该量，则认为帧超出预算。这适用于不支持可控VSync撕裂的平台（以r.DynamicRes.FrameTimeBudget的百分比表示）。 |
| `r.DynamicRes.TargetedGPUHeadRoomPercentage` | `10` | 目标GPU余量（以r.DynamicRes.FrameTimeBudget的百分比表示）。 |
| `r.DynamicRes.TestScreenPercentage` | `0` | 使用动态分辨率强制将屏幕百分比设置为特定值。 0：禁用（默认）；> 0：屏幕百分比已启用。 |
| `r.DynamicRes.ThrottlingMaxScreenPercentage` | `0` | 启用后，将启发法允许的主屏幕百分比限制为此最大值。这对预分配的显存没有影响。 例如，当视频游戏想要在不调整内部渲染器的渲染目标大小（可能导致弹出）的情况下限制非活动状态下的功耗时，这很有用 |
| `r.DynamicRes.UpperBoundQuantization` | `0` | 用于上限屏幕百分比的量化步数。 如果非零，则渲染目标将根据动态分辨率分数调整大小，从而节省清除和解析期间的GPU时间。 仅推荐（在支持的平台上）搭配附带大容量临时纹理缓存的临时分配器使用（例如RHI.TransientAllocator.TextureCacheSize=512）。 |
| `r.EarlyInitDynamicShadows` | `1` | 提早在帧中开始阴影剔除任务。 |
| `r.EarlyZPass` | `3` | 是否使用仅深度通道来初始化基础通道的Z剔除。无法在运行时更改。 注意：另请查看r.EarlyZPassMovable 0：关闭 1：仅限良好遮挡物：未遮罩，且在屏幕上较大 2：全部不透明（包括遮罩） x：使用内置启发法（默认值为3） |
| `r.EarlyZPassOnlyMaterialMasking` | `0` | 是否仅在早期Z通道中计算材质的遮罩不透明度。更改此设置需要重启编辑器。 注意：需要r.EarlyZPass == 2 && r.EarlyZPassMovable == 1 |
| `r.EarlyZSortMasked` | `1` | 将EarlyZ掩码绘制排序到绘制顺序的末尾。 |

### 编辑器

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.Editor.2DGridFade` | `0.15` | 调整以定义2D视口中的网格渲染。 |
| `r.Editor.2DSnapFade` | `0.3` | 调整以定义2D视口中的网格渲染。 |
| `r.Editor.2DSnapMin` | `0.25` | 调整以定义2D视口中的网格渲染。 |
| `r.Editor.2DSnapScale` | `10` | 调整以定义2D视口中的网格渲染。 |
| `r.Editor.3DGridFade` | `0.5` | 调整以定义3D视口中的网格渲染。 |
| `r.Editor.3DSnapFade` | `0.35` | 调整以定义3D视口中的网格渲染。 |
| `r.Editor.AlignedOrthoZoom` | `1` | 仅影响编辑器正交视口。 0：每个正交视口放大由视口宽度定义 1：所有正交视口缩放都相互锁定，以允许轴线相互对齐。 |
| `r.Editor.ArcballDragLimit` | `2` | 弧形球旋转多长时间后切换到屏幕空间旋转，默认值为1.0，等于弧形球的大小 |
| `r.Editor.ArcballSize` | `1` | 5.1中已废弃） |
| `r.Editor.HideLightStaticMobilityWhenStaticLightingDisabled` | `false` | 当项目禁用静态光照时，隐藏光源组件上的静态移动性。 |
| `r.Editor.MaxNumInstancesDetails` | `512` | 细节面板中显示的实例数上限。超过此值时，实例默认隐藏。 < 0：无最大值 |
| `r.Editor.NeverStartInPreviewMode` | `0` | 0：编辑器可以在预览模式下启动，1：编辑器永不在预览模式下启动 |
| `r.Editor.NewLevelGrid` | `2` | 是否显示新的编辑器级别网格 0：关闭 1：分析抗锯齿 2：基于纹理（默认） |
| `r.Editor.SkipSourceControlCheckForEditablePackages` | `0` | 是否跳过可编辑包的修订控制状态检查，0：禁用（默认），1：启用 |
| `r.Editor.Viewport.HighDPI` | `1` | 控制编辑器和PIE视口是否能以高DPI显示。 |
| `r.Editor.Viewport.InvalidateEachSIEFrame` | `1` | SIE运行时，使每一帧上的视口无效。禁用此控制台变量（设置为0）可能会提高性能，但会影响单击视口中移动对象的能力。 |
| `r.Editor.Viewport.MaxRenderingResolution` | `2160` | 控制编辑器视口中渲染像素的绝对数量上限。 |
| `r.Editor.Viewport.MinRenderingResolution` | `720` | 控制编辑器视口中默认渲染像素的数量下限。 |
| `r.Editor.Viewport.OverridePIEScreenPercentage` | `1` | 将编辑器视口的默认屏幕百分比设置应用于PIE中的游戏视口客户端。 |
| `r.Editor.Viewport.ScreenPercentage` | `100` | 当使用r.Editor.Viewport.ScreenPercentageMode=0时，控制编辑器视口的默认屏幕百分比。 |
| `r.Editor.Viewport.ScreenPercentageMode.Mobile` | `2` | 控制使用移动渲染器的实时编辑器视口的默认屏幕百分比模式。 |
| `r.Editor.Viewport.ScreenPercentageMode.NonRealTime` | `2` | 控制非实时编辑器视口的默认屏幕百分比模式。 |
| `r.Editor.Viewport.ScreenPercentageMode.PathTracer` | `0` | 控制路径追踪视口的默认屏幕百分比模式。 |
| `r.Editor.Viewport.ScreenPercentageMode.RealTime` | `1` | 控制使用台式机渲染器的实时编辑器视口的默认屏幕百分比模式。 |
| `r.Editor.Viewport.ScreenPercentageMode.VR` | `0` | 控制VR编辑器视口的默认屏幕百分比模式。 |
| `r.EmitMeshDrawEvents` | `0` | 对每个绘制策略绘制调用发射GPU事件。 /n对于查看每个绘制调用的统计数据很有用，但它会极大地扭曲总时间和每个绘制调用的时间。 |

### 发射器

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.Emitter.FastPoolEnable` | `0` | 是否对发射器使用快速池。 0：不池化任何内容 1：池化发射器bro（默认） |
| `r.Emitter.FastPoolMaxFreeSize` | `2097152` | 无需清理即可保留的最大空闲池大小。 |
| `r.Emitter.SkipRibbonSpawnInterp` | `1` | 插值时忽略基于速度的偏移。这可防止色带四边形相互重叠（默认值=1） |
| `r.EmitterSpawnRateScale` | `1` | 发射器生成速率的全局比例。发射器可以选择通过其bApplyGlobalSpawnRateScale属性应用或忽略它。 |
| `r.EnableAsyncComputeTranslucencyLightingVolumeClear` | `0` | 是否使用异步计算清除半透明度光照体积。 |
| `r.EnableComputeBuildHZB` | `1` | 如果为零，则使用图形管线编译HZB。 |
| `r.EnableDebugSpam_GetObjectPositionAndScale` | `1` | 启用或禁用FParticleSystemSceneProxy::GetObjectPositionAndScale()中漏洞的调试日志垃圾邮件 |
| `r.EnableMorphTargets` | `1` | 启用变形目标 |
| `r.EnableMultiGPUForkAndJoin` | `1` | 是否允许未使用的GPU通过共享工作来加速渲染。 |
| `r.EnableStereoEmulation` | `0` | 模拟立体渲染 |
| `r.ExpandAllOcclusionTestedBBoxesAmount` | `0` | 所有遮挡测试边界的扩展量。 |
| `r.ExpandNewlyOcclusionTestedBBoxesAmount` | `0` | 如果不对r.GFramesNotOcclusionTestedToExpandBBoxes帧的图元进行遮挡测试，则在对几帧进行遮挡测试时，会将BBox扩展这个量。另请参阅r.FramesToExpandNewlyOcclusionTestedBBoxes、r.GFramesNotOcclusionTestedToExpandBBoxes。 |
| `r.ExposureOffset` | `0` | 用于在后期处理设置和眼部适应的基础上调整曝光。0：默认值 |
| `r.ExrReadAndProcessOnGPU` | `true` | 允许将大型未压缩的EXR文件直接读入结构化缓冲区。 并在GPU上进行处理 |
| `r.ExrReaderGPU.ForceTileDescBuffer` | `true` | 计算CPU上的图块描述和偏移量并提供结构化缓冲区。 用于访问GPU上的图块描述 |
| `r.ExrReaderGPU.UseUploadHeap` | `true` | 利用上传堆并异步复制原始exr缓冲区。 需要重新启动引擎。 |

### 眼部适应

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.EyeAdaptation.BlackHistogramBucketInfluence` | `0` | 此参数控制对曝光柱状图中完全暗的0.0值应用多少权重。 设置为1.0时，完全暗的像素将正常累积，而设置为0.0时，完全暗的像素将不会产生影响。 |
| `r.EyeAdaptation.ExponentialTransitionDistance` | `1.5` | 自动曝光呈线性移动，但当它获取远离目标曝光的ExponentialTransitionDistance F值时，会切换到较慢的指数函数。 |
| `r.EyeAdaptation.LensAttenuation` | `0.78` | 摄像机镜头衰减(q)。将此数字设置为0.78，使光照无单位（1.0cd/m^2，EV100时变为1.0）或设置为0.65，以匹配以前的版本（1.0cd/m^2，EV100时变为1.2）。 |
| `r.EyeAdaptation.MethodOverride` | `-1` | 重载后期处理体积中设置的摄像机测光方法 -2：使用自定义设置重载（用于测试基本模式） -1：不重载 1：基于柱状图自动 2：基本自动 3：手动 |
| `r.EyeAdaptation.PreExposureOverride` | `0` | 使用自定义值重载场景预曝光。 = 0：无重载 > 0：重载PreExposure |
| `r.EyeAdaptation.VisualizeDebugType` | `0` | 启用显示->可视化->HDR（眼部适应）后，此标记可控制场景颜色。 0：色调映射后的场景颜色（默认）。 1：柱状图调试 |
| `r.EyeAdaptationQuality` | `2` | 定义眼部适应质量，以便调整质量或性能。 <=0：关闭（最快） 1：低质量（例如，非基于柱状图，尚未实现） 2：正常质量（默认） 3：高质量（例如，屏幕位置本地化，尚未实现） |
| `r.FastBlurThreshold` | `100` | 定义高斯模糊优化开始的半径（估计速度提高25% - 40%）。 优化占用的内存略微减少，但模糊半径较小时质量会有所损失。 0：始终使用优化（最快，质量最低） 3：从3像素半径开始使用优化（相当快） 7：从7像素半径开始使用优化（默认） >15：几乎从不使用优化（高质量） |

### FAST Build

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.FASTBuild.JobProcessor.MaxTimeWithPendingJobs` | `10` | 指定将等待多少秒才能获得最少量的待处理作业。过了这个时间，构建无论如何都会开始。 默认值=10 |
| `r.FASTBuild.JobProcessor.MinBatchSize` | `100` | 使用FASTBuild编译的着色器的数量下限。 默认值=100 |
| `r.FASTBuild.JobProcessor.SleepTimeBetweenActions` | `0.1` | 作业处理器线程在操作之间应休眠多长时间。 |
| `r.FASTBuildController.Enabled` | `1` | 启用或禁用使用FASTBuild编译着色器。 0：将不使用控制器（着色器将在本地编译或使用其他控制器）。 1：使用FASTBuild分发构建。 |
| `r.FASTBuildController.SendAllPossibleShaderDependencies` | `1` | 将着色器的所有可能依赖项发送到远程机器。0：使用任务结构中报告的依赖项数组。 1：强力发现所有可能的依赖项。 |
| `r.FASTBuildController.SendSCWDebugSymbols` | `0` | 当分布式着色器编译器工作器崩溃时启用。 0：不在FASTBuild中发送调试信息。 1：在FASTBuild中发送调试信息。 |

### Fast VRAM

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.FastVRam.Bloom` | `1` |  |
| `r.FastVRam.BokehDOF` | `1` |  |
| `r.FastVRam.CircleDOF` | `1` |  |
| `r.FastVRam.CombineLUTs` | `1` |  |
| `r.FastVRam.CustomDepth` | `0` |  |
| `r.FastVRam.DBufferA` | `0` |  |
| `r.FastVRam.DBufferB` | `0` |  |
| `r.FastVRam.DBufferC` | `0` |  |
| `r.FastVRam.DBufferMask` | `0` |  |
| `r.FastVRam.DistanceFieldAOBentNormal` | `0` |  |
| `r.FastVRam.DistanceFieldAODownsampledBentNormal` | `1` |  |
| `r.FastVRam.DistanceFieldAOHistory` | `1` |  |
| `r.FastVRam.DistanceFieldAOScreenGridResources` | `1` |  |
| `r.FastVRam.DistanceFieldCulledObjectBuffers` | `1` |  |
| `r.FastVRam.DistanceFieldIrradiance` | `0` |  |
| `r.FastVRam.DistanceFieldNormal` | `1` |  |
| `r.FastVRam.DistanceFieldShadows` | `1` |  |
| `r.FastVRam.DistanceFieldTileIntersectionResources` | `1` |  |
| `r.FastVRam.Distortion` | `1` |  |
| `r.FastVRam.DOFPostfilter` | `1` |  |
| `r.FastVRam.DOFReduce` | `1` |  |
| `r.FastVRam.DOFSetup` | `1` |  |
| `r.FastVRam.Downsample` | `1` |  |
| `r.FastVRam.EyeAdaptation` | `1` |  |
| `r.FastVRam.ForwardLightingCullingResources` | `1` |  |
| `r.FastVRam.GBufferA` | `0` |  |
| `r.FastVRam.GBufferB` | `1` |  |
| `r.FastVRam.GBufferC` | `0` |  |
| `r.FastVRam.GBufferD` | `0` |  |
| `r.FastVRam.GBufferE` | `0` |  |
| `r.FastVRam.GBufferF` | `0` |  |
| `r.FastVRam.GBufferVelocity` | `0` |  |
| `r.FastVRam.GlobalDistanceFieldCullGridBuffers` | `1` |  |
| `r.FastVRam.Histogram` | `1` |  |
| `r.FastVRam.HistogramReduce` | `1` |  |
| `r.FastVRam.HZB` | `1` |  |
| `r.FastVRam.MotionBlur` | `1` |  |
| `r.FastVRam.PostProcessMaterial` | `1` |  |
| `r.FastVRam.SceneColor` | `1` |  |
| `r.FastVRam.SceneDepth` | `1` |  |
| `r.FastVRam.ScreenSpaceAO` | `0` |  |
| `r.FastVRam.ScreenSpaceShadowMask` | `1` |  |
| `r.FastVRam.SeparateTranslucency` | `0` |  |
| `r.FastVRam.SeparateTranslucencyModulate` | `0` |  |
| `r.FastVRam.ShadowCSM` | `0` |  |
| `r.FastVRam.ShadowPerObject` | `0` |  |
| `r.FastVRam.ShadowPointLight` | `0` |  |
| `r.FastVRam.SSR` | `0` |  |
| `r.FastVRam.Tonemap` | `1` |  |
| `r.FastVRam.Upscale` | `1` |  |
| `r.FastVRam.VelocityFlat` | `1` |  |
| `r.FastVRam.VelocityMax` | `1` |  |
| `r.FastVRam.VolumetricFog` | `1` |  |

### 全局光照

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.GlobalIllumination.Denoiser.HistoryConvolution.KernelSpreadFactor` | `3` | 应用于核样本偏移的乘法因子（默认值=3）。 |
| `r.GlobalIllumination.Denoiser.HistoryConvolution.SampleCount` | `1` | 用于历史记录后滤波器的样本数量（默认值=1）。 |
| `r.GlobalIllumination.Denoiser.PreConvolution` | `1` | 预卷积通道的数量（默认值=1）。 |
| `r.GlobalIllumination.Denoiser.ReconstructionSamples` | `16` | 重构通道的样本数量上限（默认值=16）。 |
| `r.GlobalIllumination.Denoiser.TemporalAccumulation` | `1` | 在多个帧上累积样本。 |

### GPU

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.gpucrash.collectionenable` | `1` | 当适用的崩溃调试系统可用时，存储来自范围事件的GPU崩溃数据。 |
| `r.gpucrash.datadepth` | `-1` | 将为GPU崩溃调试记录的标识范围深度量限制为给定的范围深度。 |
| `r.GPUCrashDebugging` | `0` | 启用特定于供应商的GPU崩溃分析工具 |
| `r.GPUCrashDebugging.Aftermath.Callstack` | `0` | 在Aftermath转储中启用调用堆栈捕获 |
| `r.GPUCrashDebugging.Aftermath.Markers` | `0` | 在Aftermath转储中启用绘制事件标识 |
| `r.GPUCrashDebugging.Aftermath.ResourceTracking` | `0` | 为Aftermath转储启用资源跟踪 |
| `r.GPUCrashDebugging.Aftermath.TrackAll` | `1` | 为Aftermath转储启用最大跟踪 |
| `r.GPUCrashDump` | `0` | 启用特定于供应商的GPU崩溃转储 |
| `r.GPUCrashOnOutOfMemory` | `0` | 在GPU内存不足时启用崩溃报告 |
| `r.GPUCsvStatsEnabled` | `0` | 启用或禁用GPU统计信息记录到CSV |
| `r.GPUDefrag.AllowOverlappedMoves` | `1` | 允许碎片清理部分重叠的重定位。 |
| `r.GPUDefrag.EnableTimeLimits` | `1` | 限制进行GPU碎片清理所花费的CPU时间。 |
| `r.GPUDefrag.MaxRelocations` | `10` | 限制一帧中的总重定位数量，无论移动的字节数是多少。 |
| `r.GPUMessage.LogAllMessages` | `0` | 将所有消息记录到控制台。 0：禁用 1：启用 |
| `r.GPUMessage.MaxBufferSize` | `64` | 指定GPU消息缓冲区的最大大小，以KiB为单位。 默认值：64 |
| `r.GPUParticle.FixDeltaSeconds` | `0.0333333` | GPU粒子修复增量秒。 |
| `r.GPUParticle.FixTolerance` | `0.1` | 切换到固定增量秒之前的增量秒容差。 |
| `r.GPUParticle.MaxNumIterations` | `3` | 使用固定增量秒时的最大迭代次数。 |
| `r.GPUParticle.Simulate` | `1` | 启用或禁用GPU粒子模拟 |
| `r.GpuProfilerMaxEventBufferSizeKB` | `32` | 临时缓冲区的大小，以kB为单位。 |
| `r.GPUScene.DebugDrawRange` | `-1` | 绘制实例边界的最大距离，默认值为-1.0 <=>无限范围。 |
| `r.GPUScene.DebugMode` | `0` | 调试渲染模式： 0 -（不显示任何内容，默认） 1 - 绘制全部 2 - 绘制选定内容（在编辑器中） 3 - 绘制更新内容（更新此帧） 你可以使用r.GPUScene.DebugDrawRange来限制范围 |
| `r.GPUScene.MaxPooledUploadBufferSize` | `256000` | 最大化要池化的GPU场景上传缓冲区大小。 |
| `r.GPUScene.ParallelUpdate` | `0` |  |
| `r.GPUScene.UploadEveryFrame` | `0` | 是否每帧上传整个场景的图元数据。 适合用于调试。 |
| `r.GPUScene.UseGrowOnlyAllocationPolicy` | `0` | 5.3中已废弃。如果设置为1，用于GPU场景实例和类似实例的分配器将使用仅增长分配策略来模仿5.2及更早版本中的行为。 默认情况下禁用，这意味着缓冲区可以缩小和增大。 |
| `r.GPUSkin.AlwaysUseDeformerForUnlimitedBoneInfluences` | `false` | 任何使用无限制骨骼影响的网格体都将始终使用网格体变形器进行渲染。这减少了骨骼网格体材质所需的着色器Permutation数量，以牺牲性能为代价节省内存。如果禁用无限制骨骼影响（Unlimited Bone Influences）或变形器图（Deformer Graph），则没有影响。无法在运行时更改。 |
| `r.GPUSkin.CopyBones.ISPC` | `false` | 复制骨骼进行GPU蒙皮时是否使用ISPC优化 |
| `r.GPUSkin.Limit2BoneInfluences` | `0` | 是否使用2个骨骼影响而不是默认的4/8个骨骼影响进行GPU蒙皮。无法在运行时更改。 |
| `r.GpuSkin.Pool` | `1` | 是否池化GPU皮肤。 0：不池化任何内容 1：池化GPU皮肤bro（默认） |
| `r.GPUSkin.Support16BitBoneIndex` | `0` | 启用后，导入的新网格体将使用8位（如果骨骼数量不超过256）或16位（如果骨骼数量大于256）骨骼索引来渲染。 |
| `r.GPUSkin.UnlimitedBoneInfluences` | `0` | 是否使用无限制骨骼影响代替默认的4/8进行GPU蒙皮。无法在运行时更改。 |
| `r.GPUSkin.UnlimitedBoneInfluencesThreshold` | `8` | 如果启用r.GPUSkin.UnlimitedBoneInfluences，则无限制骨骼影响阈值使用无限制骨骼影响缓冲。应为无符号整型。无法在运行时更改。 |
| `r.GPUStatsChildTimesIncluded` | `0` | 启用后，子项统计计时将包含在父项的时间中。 如果期望非层级统计数据合计出总GPU时间，那么这会给非层级统计数据带来问题，因此可能需要禁用此功能。 |
| `r.GPUStatsEnabled` | `1` | 启用或禁用GPU统计记录 |
| `r.GPUStatsMaxQueriesPerFrame` | `8192` | 限制每帧分配的时间戳数。-1 = 无限制 |
| `r.GPUTracingStatsEnabled` | `1` | 启用或禁用GPU统计数据记录到追踪分析器 |

### GTAO

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.GTAO.Combined` | `1` | 为GTAO启用空间过滤器 0：关闭 1：开启（默认） |
| `r.GTAO.Downsample` | `0` | 以Halfres执行GTAO 0：关闭 1：开启（默认） |
| `r.GTAO.FalloffEnd` | `200` | 遮挡完成衰减时的距离。 |
| `r.GTAO.FalloffStartRatio` | `0.5` | 开始衰减时r.GTAO.FalloffEnd值的比率。 必须介于0和1之间。 |
| `r.GTAO.FilterWidth` | `5` | 噪点模式的大小和滤波器宽度 5：5x5模式（默认） 4: 4x4模式 |
| `r.GTAO.NumAngles` | `2` | 每像素选择的角度数 必须介于1到16之间。 |
| `r.GTAO.PauseJitter` | `0` | 时间滤波器关闭时是否暂停抖动 |
| `r.GTAO.SpatialFilter` | `1` | 为GTAO启用空间过滤器 0：关闭 1：开启（默认） |
| `r.GTAO.TemporalFilter` | `1` | 为GTAO启用时间过滤器 0：关闭 1：开启（默认） |
| `r.GTAO.ThicknessBlend` | `0.5` | 对薄或厚对象进行偏差遮挡的启发法。 0 ：关闭 >0：开启 - 值越大，遮挡越少 0.5：开启（默认） |
| `r.GTAO.Upsample` | `1` | 为GTAO启用简单或深度感知上采样滤波器 0：简单 1：DepthAware（默认） |
| `r.GTAO.UseNormals` | `0` | 是否使用GBuffer法线或深度派生法线 0：关闭 1：开启（默认） |
| `r.GTSyncType` | `0` | 确定游戏线程如何与渲染线程、RHI线程和GPU同步。 同步到GPU交换链翻转可降低帧延迟。 0 - 将游戏线程与渲染线程同步（默认）。 1 - 将游戏线程与RHI线程同步。 2 - 将游戏线程与GPU交换链翻转同步（仅在受支持的平台上）。 |

### 毛发发束

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.HairStrands.Binding` | `1` | 启用/禁用毛发绑定，即将毛发附着到骨骼网格体。 |
| `r.HairStrands.Cards` | `1` | 启用/禁用毛发发片渲染。引擎启动时需要打开此变量。 |
| `r.HairStrands.Components.GlobalScattering` | `1` | 启用/禁用毛发BSDF组件全局散射 |
| `r.HairStrands.Components.LocalScattering` | `1` | 启用/禁用毛发BSDF组件局部散射 |
| `r.HairStrands.Components.R` | `1` | 启用/禁用毛发BSDF组件R |
| `r.HairStrands.Components.TRT` | `1` | 启用/禁用毛发BSDF组件TRT |
| `r.HairStrands.Components.TT` | `1` | 启用/禁用毛发BSDF组件TT |
| `r.HairStrands.Components.TTModel` | `0` | 选择毛发TT模型 |
| `r.HairStrands.ComposeAfterTranslucency` | `1` | 0：在半透明对象之前合成毛发。1：在半透明对象之后，但在单独的半透明对象之前合成毛发。2：在所有/单独的半透明对象之后合成毛发，3：在半透明对象之后，但在景深之后的半透明渲染之前合成毛发（这允许针对毛发深度进行深度测试） |
| `r.HairStrands.ContinuousDecimationReordering` | `0` | 启用发束重新排序以允许连续LOD。试验性 |
| `r.HairStrands.DeepShadow.AABBScale` | `1` | 松开/收紧深阴影包围体的缩放值 |
| `r.HairStrands.DeepShadow.DebugDOMIndex` | `0` | 要绘制的DOM纹理的索引 |
| `r.HairStrands.DeepShadow.DebugDOMScale` | `20` | 绘制深阴影统计数据时DeepOpacityMap的缩放值 |
| `r.HairStrands.DeepShadow.DebugMode` | `0` | 深阴影的颜色调试模式 |
| `r.HairStrands.DeepShadow.DensityScale` | `2` | 设置密度比例以补偿资产中毛发纤维的缺失 |
| `r.HairStrands.DeepShadow.DepthBiasScale` | `0.05` | 设置深度偏差比例以进行透射率计算 |
| `r.HairStrands.DeepShadow.GPUDriven` | `1` | 使深阴影能够由GPU边界框（而不是CPU边界框）驱动。这允许更稳健的行为 |
| `r.HairStrands.DeepShadow.InjectVoxelDepth` | `0` | 注入体素内容以生成深度阴影图，而不是光栅化Groom。这是一条试验性路径 |
| `r.HairStrands.DeepShadow.KernelAperture` | `1` | 设置使用PCSS核时核用于毛发透射率求值的光圈角度，以度为单位 |
| `r.HairStrands.DeepShadow.KernelType` | `2` | 设置用于毛发透射率求值的核类型，0：线性，1：PCF_2x2，2：PCF_6x4，3：PCSS，4：PCF_6x6_Accurate |
| `r.HairStrands.DeepShadow.MaxFrustumAngle` | `90` | 最大深度阴影视锥体角度以避免强烈变形。默认值：90 |
| `r.HairStrands.DeepShadow.MinResolution` | `64` | 用于深度不透明度图渲染的阴影图集图块的最小阴影分辨率。（默认值=64） |
| `r.HairStrands.DeepShadow.MipTraversal` | `1` | 使用mip-map遍历进行透射率求值（更快）。 |
| `r.HairStrands.DeepShadow.RandomType` | `2` | 更改遍历抖动的初始化方式。有效值为0、1和2。每种类型都有不同类型的权衡。 |
| `r.HairStrands.DeepShadow.Resolution` | `2048` | 深度不透明度贴图渲染的阴影分辨率。（默认值=2048） |
| `r.HairStrands.DeepShadow.ShadowMaskKernelType` | `4` | 设置用于过滤不透明几何体上毛发投射阴影的核类型（0:2x2、1:4x4、2:Gaussian8、3:Gaussian16、4:Gaussian8，具有透射率。默认值为4 |
| `r.HairStrands.DeepShadow.ShadowMaskPassType` | `1` | 更改从毛发到不透明几何体的阴影遮罩生成方式。0：每个毛发组一个通道，1：所有组一个通道。 |
| `r.HairStrands.DeepShadow.SuperSampling` | `0` | 使用超级采样进行透射率求值。开销高昂，仅用于过场动画模式。 |
| `r.HairStrands.DOFDepth` | `1` | 通过基于毛发不透明度对毛发深度进行插值，用景深合成毛发。 |
| `r.HairStrands.DualScatteringRoughness` | `0` | 重载双散射求值的所有粗糙度。0表示无重载。默认值：0 |
| `r.HairStrands.Enable` | `1` | 启用/禁用整个发束系统。这会影响所有几何呈现（即，发束、发片和网格体）。 |
| `r.HairStrands.HairLUT.AbsorptionCount` | `16` | 更改毛发LUT用于吸收轴的切片数 |
| `r.HairStrands.HairLUT.IncidentAngleCount` | `64` | 更改毛发LUT用于入射角轴的切片数 |
| `r.HairStrands.HairLUT.RoughnessCount` | `64` | 更改毛发LUT用于粗糙度轴的切片数 |
| `r.HairStrands.HairLUT.SampleCountScale` | `1` | 更改用于计算毛发LUT的样本数量。这是一个乘数，默认值为1。 |
| `r.HairStrands.HoldoutMode` | `1` | 更改使用维持（Holdout）渲染时样本的合并方式。 |
| `r.HairStrands.LightFunction` | `1` | 启用毛发上的光源函数 |
| `r.HairStrands.Lighting.AllowOneTransmittancePass` | `1` | 允许单透射通道，使发束光照具有更好的性能（试验性）。 |
| `r.HairStrands.LightSampleFormat` | `1` | 定义用于存储毛发样本光照的格式（0：RGBA-16位，1：RGB-11.11.10位） |
| `r.HairStrands.LODMode` | `1` | 默认启用发束自动LOD模式。否则使用手动LOD模式。自动LOD模式根据屏幕覆盖范围调整毛发曲线。手动LOD模式依赖于每个Groom资产手动设置的LOD。可以根据每个Groom资产重载此全局行为。 |
| `r.HairStrands.MaterialCompaction.DepthThreshold` | `1` | 材质压缩深度值的压缩阈值（以厘米为单位）。默认为1厘米。 |
| `r.HairStrands.MaterialCompaction.TangentThreshold` | `10` | 材质压缩切线值的压缩阈值（以度为单位）。默认为10度。 |
| `r.HairStrands.Meshes` | `1` | 启用/禁用毛发网格体渲染。引擎启动时需要打开此变量。 |
| `r.HairStrands.PathTracing.InvalidationDebug` | `0` | 为导致路径追踪器失效的Groom元素启用边界框绘制 |
| `r.HairStrands.PathTracing.InvalidationThreshold` | `0.05` | 定义Groom变化时使路径追踪器输出无效的最小距离（以厘米为单位，默认值：0.5毫米） 设置为负值可禁用此功能 |
| `r.HairStrands.PlotBsdf` | `0` | 用于可视化毛发BSDF的调试视图。 |
| `r.HairStrands.PlotBsdf.BaseColor` | `1` | 更改调试BSDF图的基础颜色/吸收。 |
| `r.HairStrands.PlotBsdf.Exposure` | `1.1` | 更改图的曝光。 |
| `r.HairStrands.PlotBsdf.Roughness` | `0.3` | 更改调试BSDF图的粗糙度。 |
| `r.HairStrands.RasterizationScale` | `0.5` | 将发束对齐到像素的光栅化比例 |
| `r.HairStrands.Raytracing` | `1` | 启用/禁用发束光线追踪几何体。这是一个每Groom资产/Groom实例可选选项。 |
| `r.HairStrands.RectLightingOptim` | `1` | 毛发可视性使用投影视图矩形仅照亮相关像素 |
| `r.HairStrands.ScatterSceneLighting` | `1` | 启用场景颜色光照散射到毛发中（仅对短毛发有效）。 |
| `r.HairStrands.Selection.CoverageThreshold` | `0` | 使发束轮廓选择更细的覆盖阈值 |
| `r.HairStrands.Shadow.CastShadowWhenNonVisible` | `1` | 启用即使从主视图中剔除也能为发束投射阴影 |
| `r.HairStrands.Shadow.CullPerObjectShadowCaster` | `1` | 启用CPU剔除投射逐对象阴影的对象（静止对象） |
| `r.HairStrands.ShadowRasterizationScale` | `1` | 将发束对齐到阴影视图中像素的光栅化比例 |
| `r.HairStrands.Simulation` | `1` | 启用/禁用毛发模拟 |
| `r.HairStrands.SkyAO` | `1` | 在毛发上启用（天空）环境光遮蔽。 |
| `r.HairStrands.SkyAO.DistanceThreshold` | `10` | 遮挡搜索的最大距离。 |
| `r.HairStrands.SkyAO.SampleCount` | `4` | 用于毛发环境光遮蔽求值的样本数（默认值为16）。 |
| `r.HairStrands.SkyLighting` | `1` | 在毛发上启用天空光照。 |
| `r.HairStrands.SkyLighting.ConeAngle` | `3` | 用于追踪毛发上天空光照的椎角。 |
| `r.HairStrands.SkyLighting.DebugSample` | `0` | 启用调试视图以可视化用于天空集成的样本 |
| `r.HairStrands.SkyLighting.DistanceThreshold` | `10` | 遮挡搜索的最大距离。 |
| `r.HairStrands.SkyLighting.IntegrationType` | `2` | 毛发环境光照集成类型（0：临时，1：统一）。 |
| `r.HairStrands.SkyLighting.SampleCount` | `16` | 用于多重散射和可见区域求值的样本数量（默认设置为16）。 |
| `r.HairStrands.SkyLighting.TransmissionDensityScale` | `10` | 用于控制天空光照传输量的密度比例。 |
| `r.HairStrands.SkyLighting.UseViewHairCount` | `1` | 使用视图毛发数量纹理来估计背景透射光源（默认启用）。 |
| `r.HairStrands.StableRasterizationScale` | `1` | 将发束对齐到‘稳定’毛发选项像素的光栅化比例。此值不能低于1。 |
| `r.HairStrands.Strands` | `1` | 启用/禁用发束渲染 |
| `r.HairStrands.Strands.UseTriangleStrips` | `1` | 对发束渲染启用三角形条带几何体。这样可以提高性能，但会删除每条曲线的最后几段。 |
| `r.HairStrands.VelocityMagnitudeScale` | `100` | 毛发在运动情况下达到其图片速度光栅化比例以减少锯齿的速度值（以像素为单位）。默认值为100。 |
| `r.HairStrands.VelocityRasterizationScale` | `1.5` | 高速下将发束对齐到像素的光栅化比例 |
| `r.HairStrands.VelocityThreshold` | `1` | 超过此阈值（以像素为单位）后，像素将被强制使用响应式抗锯齿进行解析（以避免出现污迹）。默认值为3。 |
| `r.HairStrands.VelocityType` | `1` | 速度过滤类型（0：平均，1：最近，2：最大）。默认值为1。 |
| `r.HairStrands.Visibility.Clear` | `0` | 清理发束可视性缓冲区 |
| `r.HairStrands.Visibility.Compute.MeanSamplePerPixel` | `0.75` | 缩放逐像素样本数以限制内存分配（0..1，默认值为0.5f） |
| `r.HairStrands.Visibility.Compute.SamplePerPixel` | `1` | 发束可视性样本数（2、4或8） |
| `r.HairStrands.Visibility.ComputeRaster` | `0` | 毛发可视性使用光栅计算。试验性 |
| `r.HairStrands.Visibility.ComputeRaster.ContinuousLOD` | `1` | 使用计算光栅化时启用连续LOD。试验性 |
| `r.HairStrands.Visibility.ComputeRaster.Culling` | `0` | 将剔除缓冲区与计算光栅化结合使用。 |
| `r.HairStrands.Visibility.ComputeRaster.Debug` | `0` | 调试计算光栅输出 |
| `r.HairStrands.Visibility.ComputeRaster.MaxTiles` | `65536` | 用于计算光栅化的图块数量上限。8192为默认值 |
| `r.HairStrands.Visibility.ComputeRaster.NumBinners` | `32` | 在分箱计算光栅化过通道中使用的分箱器数量。32为默认值 |
| `r.HairStrands.Visibility.ComputeRaster.NumRasterizers` | `256` | 用于计算光栅化的光栅器数量。256为默认值 |
| `r.HairStrands.Visibility.ComputeRaster.NumRasterizersNaive` | `256` | 用于简单计算光栅化的光栅器数量。256为默认值 |
| `r.HairStrands.Visibility.ComputeRaster.TileSize` | `32` | 用于计算光栅化的图块大小。试验性 - 目前仅支持32的大小 |
| `r.HairStrands.Visibility.FullCoverageThreshold` | `0.98` | 定义像素被视为完全覆盖的覆盖阈值。 |
| `r.HairStrands.Visibility.HairCount.DistanceThreshold` | `30` | 距离阈值定义不透明深度是否被注入到‘view-hair-count’缓冲区。 |
| `r.HairStrands.Visibility.HWSWClassifaction` | `0` | 启用对要使用硬件光栅器或软件光栅器进行光栅化的毛发片段进行分类。 |
| `r.HairStrands.Visibility.MSAA.MeanSamplePerPixel` | `0.75` | 缩放逐像素样本数以限制内存分配（0..1，默认值为0.5f） |
| `r.HairStrands.Visibility.MSAA.SamplePerPixel` | `4` | 发束可视性样本数（2、4或8） |
| `r.HairStrands.Visibility.NonVisibleShadowCasting.CullDistance` | `2000` | 对不可见的发束实例开始禁用阴影投射的剔除距离。 |
| `r.HairStrands.Visibility.NonVisibleShadowCasting.Debug` | `0` | 为不可见的发束实例启用调试渲染，投射阴影。 |
| `r.HairStrands.Visibility.NumClassifiers` | `32` | 毛发片段分类通道中使用的工作组数量。32为默认值 |
| `r.HairStrands.Visibility.PPLL` | `0` | 毛发可见性使用逐像素链表 |
| `r.HairStrands.Visibility.PPLL.Debug` | `0` | 绘制调试逐像素光源列表渲染。 |
| `r.HairStrands.Visibility.PPLL.MeanSamplePerPixel` | `1` | 缩放所有链表元素允许的节点数上限（0..1，默认值为1）。将为width*height*SamplerPerPixel*Scale。 |
| `r.HairStrands.Visibility.PPLL.SamplePerPixel` | `16` | 逐像素允许独立着色和合成的节点数上限。节点总量为width*height*VisibilityPPLLMaxRenderNodePerPixel。最后一个节点用于将所有最远发束聚合为一条。 |
| `r.HairStrands.Visibility.SortByDepth` | `0` | 按深度对毛发片段进行排序，并根据有序透射率更新其覆盖范围。 |
| `r.HairStrands.Visibility.TileCompaction` | `0` | 启用压缩通道以在毛发软件光栅化分箱通道的输出上运行。 |
| `r.HairStrands.Visibility.UseCoverageMappping` | `0` | 将毛发数量用于覆盖传递函数。 |
| `r.HairStrands.Visibility.UseHWRaster` | `0` | 切换硬件光栅器以实现发束可视性渲染。 |
| `r.HairStrands.Visibility.UseNaiveSWRaster` | `0` | 切换软件光栅器的初级版本，用于发束可视性渲染。 |
| `r.HairStrands.Visibility.WriteVelocityCoverageThreshold` | `0` | 定义像素写入其毛发速度的覆盖阈值（默认值：0，即为所有像素写入） |
| `r.HairStrands.Voxelization` | `1` | 启用毛发体素化以进行透射率求值 |
| `r.HairStrands.Voxelization.AABBScale` | `1` | 缩放毛发宏组边界框 |
| `r.HairStrands.Voxelization.DensityScale` | `2` | 缩放计算体素透射率时的毛发密度。默认值为2（任意） |
| `r.HairStrands.Voxelization.DensityScale.AO` | `-1` | 缩放计算体素环境光遮蔽时的毛发密度。（默认值：-1，将使用全局密度比例 |
| `r.HairStrands.Voxelization.DensityScale.Environment` | `-1` | 缩放计算体素环境时的毛发密度。（默认值：-1，将使用全局密度比例 |
| `r.HairStrands.Voxelization.DensityScale.Raytracing` | `-1` | 缩放计算体素光线追踪时的毛发密度。（默认值：-1，将使用全局密度比例 |
| `r.HairStrands.Voxelization.DensityScale.Shadow` | `-1` | 缩放计算体素阴影时的毛发密度。（默认值：-1，将使用全局密度比例 |
| `r.HairStrands.Voxelization.DensityScale.Transmittance` | `-1` | 缩放计算体素透射率时的毛发密度。（默认值：-1，将使用全局密度比例 |
| `r.HairStrands.Voxelization.DepthBiasScale.Environment` | `1.8` | 设置环境光源体素射线行进的深度偏差。将原点位置向光源偏移 |
| `r.HairStrands.Voxelization.DepthBiasScale.Light` | `3` | 设置分析光源体素光线行进的深度偏差。将原点位置向光源偏移，以计算透射率 |
| `r.HairStrands.Voxelization.DepthBiasScale.Shadow` | `2` | 设置分析光源体素光线行进的深度偏差。将原点位置向光源偏移，以计算阴影 |
| `r.HairStrands.Voxelization.DepthBiasScale.Transmittance` | `3` | 设置分析光源体素光线行进的深度偏差。将原点位置向光源偏移，以计算透射率 |
| `r.HairStrands.Voxelization.ForceTransmittanceAndShadow` | `0` | 使用密度体积计算透射率和阴影。这需要启用体素化。 |
| `r.HairStrands.Voxelization.GPUDriven` | `1` | 启用GPU驱动型体素化。 |
| `r.HairStrands.Voxelization.GPUDriven.MaxPageIndexResolution` | `64` | 页面索引的最大分辨率。当启用GPU驱动型分配时，此变量用于分配保守页面索引缓冲区。 |
| `r.HairStrands.Voxelization.GPUDriven.MinPageIndexResolution` | `32` | 页面索引的最小分辨率。当启用GPU驱动型分配时，此变量用于分配保守页面索引缓冲区。 |
| `r.HairStrands.Voxelization.InjectOpaque.BiasCount` | `3` | 注入不透明深度的偏差，以体素数量表示。 |
| `r.HairStrands.Voxelization.InjectOpaque.MarkCount` | `6` | 沿着不透明表面下方的视图方向开始标记为不透明的体素数量。 |
| `r.HairStrands.Voxelization.InjectOpaqueDepth` | `1` | 将不透明几何体深度注入体素体积以充当遮挡物。 |
| `r.HairStrands.Voxelization.Raymarching.SteppingScale` | `1.15` | 用于对阴影体素结构进行光线行进的步进比例。 |
| `r.HairStrands.Voxelization.Raymarching.SteppingScale.Environment` | `-1` | 用于光线行进体素结构的步进比例，重载环境光照的比例（默认值为-1）。 |
| `r.HairStrands.Voxelization.Raymarching.SteppingScale.Raytracing` | `-1` | 用于光线行进体素结构的步进比例，重载光线追踪的比例（默认值为-1）。 |
| `r.HairStrands.Voxelization.Raymarching.SteppingScale.Shadow` | `-1` | 用于光线行进体素结构的步进比例，重载阴影的比例（默认值为-1）。 |
| `r.HairStrands.Voxelization.Raymarching.SteppingScale.Transmission` | `-1` | 用于光线行进体素结构的步进比例，重载透射率的比例（默认值为-1）。 |
| `r.HairStrands.Voxelization.Virtual` | `1` | 启用双体素层级。 |
| `r.HairStrands.Voxelization.Virtual.Adaptive` | `1` | 启用自适应体素分配（默认值=1） |
| `r.HairStrands.Voxelization.Virtual.Adaptive.CorrectionSpeed` | `0.1` | 定义分配适应的运行速度（值在0..1之间，默认值=0.25）。数字越大，适应速度就越快，但存在振荡风险，即分配过多或不足 |
| `r.HairStrands.Voxelization.Virtual.Adaptive.CorrectionThreshold` | `0.9` | 定义分配边界以限制超量分配（值在0..1之间，默认值=0.95） |
| `r.HairStrands.Voxelization.Virtual.ComputeRasterMaxVoxelCount` | `32` | 对于给定毛发片段进行光栅化的最大体素数量。此变量仅用于调试目的。 |
| `r.HairStrands.Voxelization.Virtual.DebugTraversalType` | `0` | 遍历模式（0：线性，1：Mip）用于调试体素可视化。 |
| `r.HairStrands.Voxelization.Virtual.InvalidateEmptyPageIndex` | `1` | 无效的体素页面索引，不含体素化数据。 |
| `r.HairStrands.Voxelization.Virtual.Jitter` | `1` | 改变体素化/遍历的抖动。0：无抖动 1：常规随机抖动：2：恒定抖动（默认值=1） |
| `r.HairStrands.Voxelization.Virtual.VoxelPageCountPerDim` | `14` | 逐纹理维度的体素页面数。体素页内存分配有3D纹理。此值提供此纹理的分辨率。 |
| `r.HairStrands.Voxelization.Virtual.VoxelPageResolution` | `32` | 体素页面的分辨率。 |
| `r.HairStrands.Voxelization.Virtual.VoxelWorldSize` | `0.3` | 体素的世界大小，以厘米为单位。 |
| `r.HairStrands.Voxelization.VoxelSizeInPixel` | `1` | 目标体素大小，以像素为单位 |
| `r.HairStrands.WriteGBufferData` | `1` | 在后期处理运行之前，将毛发材质数据写入GBuffer。0：不写入，1：虚拟写入GBuffer A/B（Normal/ShadingModel），2：写入GBuffer A/B（Normal/ShadingModel）。2：写入完整GBuffer数据。（默认值1）。 |
| `r.HalfResDepthNoFastClear` | `1` | 删除半分辨率深度缓冲区（棋盘格和上下限）的快速清除 |

### HDR

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.HDR.Aces.GamutCompression` | `0` | BlueCorrection的HDR等效值：亮蓝色去饱和，而不是变成紫色 |
| `r.HDR.Aces.SceneColorMultiplier` | `1.5` | 应用于场景颜色的乘数。有帮助 |
| `r.HDR.Display.ColorGamut` | `0` | 输出显示的色域： 0：Rec709/sRGB，D65（默认值） 1：DCI-P3，D65 2：Rec2020/BT2020，D65 3：ACES，D60 4：ACEScg，D60 |
| `r.HDR.Display.MaxLuminance` | `0` | 配置的显示输出尼特级别，假定已启用HDR输出。 |
| `r.HDR.Display.MidLuminance` | `15` | 配置的18%灰度显示输出尼特级别 |
| `r.HDR.Display.MinLuminanceLog10` | `-4` | 配置的最低显示输出尼特级别（log10值） |
| `r.HDR.Display.OutputDevice` | `0` | 输出显示设备格式： 0：sRGB (LDR) 1：Rec709 (LDR) 2：显式伽马映射（LDR） 3：ACES 1000尼特ST-2084（olby PQ）（HDR） 4：ACES 2000尼特ST-2084（olby PQ）（HDR） 5：ACES 1000尼特ScRGB（HDR） 6：ACES 2000尼特ScRGB（HDR） 7：线性EXR（HDR） 8：线性最终颜色，无色调曲线（HDR） 9：线性最终颜色，有色调曲线 |
| `r.HDR.EnableHDROutput` | `0` | 创建与HDR兼容的交换链并启用HDR显示输出。0：禁用（默认） 1：启用硬件特定实现 |
| `r.HDR.UI.CompositeMode` | `1` | 合成UI层时使用的模式： 0：标准合成 1：改善HDR混合的着色器通道 |
| `r.HDR.UI.Level` | `1` | 合成到HDR帧缓冲区时UI元素的亮度级别（默认值：1.0）。 |
| `r.HDR.UI.Luminance` | `300` | 合成到HDR帧缓冲区时UI元素的基本亮度，以尼特为单位。与r.HDR.UI.Level相乘 |

### 高度场

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.HeightFields.AtlasDimInTiles` | `16` | 图集在一个维度的图块数量 |
| `r.HeightFields.AtlasDownSampleLevel` | `2` | 子分配可以向下采样的最大次数 |
| `r.HeightFields.AtlasTileSize` | `64` | 子分配粒度 |
| `r.HeightFields.VisibilityAtlasDimInTiles` | `8` | 图集在一个维度的图块数量 |
| `r.HeightFields.VisibilityAtlasDownSampleLevel` | `2` | 子分配可以向下采样的最大次数 |
| `r.HeightFields.VisibilityAtlasTileSize` | `64` | 子分配粒度 |
| `r.HeightFieldShadowing` | `0` | 是否允许高度场阴影功能。 |

### 异类体积

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.HeterogeneousVolumes` | `1` | 启用异类体积集成器（默认值=1） |
| `r.HeterogeneousVolumes.ApplyFogInscattering` | `1` | 确定应用雾散射的方法（默认值=1） 0：关闭 1：参考（逐光线行进步长求值）2：随机（逐光线求值一次） |
| `r.HeterogeneousVolumes.CLOD` | `1` | 使用连续细节级别加速渲染（默认值=1） |
| `r.HeterogeneousVolumes.CLOD.Bias` | `0` | 计算连续细节级别时的偏差求值结果（默认值=0.0） > 0：较粗糙 <0：较清晰 |
| `r.HeterogeneousVolumes.CompositeWithTranslucency.Refraction.TransmittanceThreshold` | `0.9` | 应用失真的最小透射率阈值（默认值=0.9） 需要启用异类体积项目设置：‘与半透明度复合’ |
| `r.HeterogeneousVolumes.CompositeWithTranslucency.Refraction.UseAVSM` | `1` | 启用AVSM查找（默认值=1） 需要启用异类体积项目设置：‘与半透明度复合’ |
| `r.HeterogeneousVolumes.Composition` | `0` | 更改异类体积复合的顺序（默认值=0） 0：半透明度之前 1：半透明度之后 需要启用异类体积项目设置：‘与半透明度复合’ |
| `r.HeterogeneousVolumes.Debug` | `0` | 创建用于调试的辅助输出缓冲区（默认值=0） |
| `r.HeterogeneousVolumes.Debug.MarchingMode` | `1` | 行进模式（默认=0） 0：光线行进（dt=步长大小） 1：简单DDA 2：优化DDA 3：优化DDA，有位掩码 |
| `r.HeterogeneousVolumes.DepthSort` | `1` | 根据质心，按深度排序顺序对体积进行迭代（默认值=1） |
| `r.HeterogeneousVolumes.FrustumGrid` | `1` | 启用视锥体体素网格（默认值=1） |
| `r.HeterogeneousVolumes.FrustumGrid.DepthSliceCount` | `512` | 深度切片的数量（默认值=512） |
| `r.HeterogeneousVolumes.FrustumGrid.FarPlaneDistance` | `-1` | 设置视锥体网格的远平面距离（默认值=-1.0） |
| `r.HeterogeneousVolumes.FrustumGrid.MaxBottomLevelMemoryInMegabytes` | `128` | 最小体素大小（默认值=128） |
| `r.HeterogeneousVolumes.FrustumGrid.NearPlaneDistance` | `1` | 设置视锥体网格的近平面距离（默认值=1.0） |
| `r.HeterogeneousVolumes.FrustumGrid.ShadingRate` | `4` | 像素空间中的体素曲面细分率（默认值=4.0） |
| `r.HeterogeneousVolumes.HardwareRayTracing` | `0` | 启用硬件光线追踪加速（默认值=0） |
| `r.HeterogeneousVolumes.HeightFog` | `1` | 将高度雾应用于异类体积（默认值=1） |
| `r.HeterogeneousVolumes.IndirectLighting` | `0` | 启用间接光照（默认值=0） |
| `r.HeterogeneousVolumes.Jitter` | `1` | 光线行进时启用抖动（默认值=1） |
| `r.HeterogeneousVolumes.LightingCache` | `2` | 启用优化的预通道，缓存某些体积渲染光照量（默认值=2） 0：禁用 1：缓存透射率 2：缓存内散射 |
| `r.HeterogeneousVolumes.LightingCache.BoundsCulling` | `1` | 填充光照缓存时启用边界剔除（默认值=1） |
| `r.HeterogeneousVolumes.LightingCache.DownsampleFactor` | `0` | 重载光照缓存下采样因子，相对于预着色体积分辨率（默认值=0） 0：禁用，使用逐体积属性 >0：重载光照缓存下采样因子 |
| `r.HeterogeneousVolumes.LightingCache.UseAVSM` | `1` | 在求值自阴影时启用使用AVSM（默认值=1） |
| `r.HeterogeneousVolumes.MaxShadowTraceDistance` | `30000` | 最大阴影追踪距离（默认值=30000） |
| `r.HeterogeneousVolumes.MaxStepCount` | `512` | 最大光线行进步数（默认值=512） |
| `r.HeterogeneousVolumes.MaxTraceDistance` | `30000` | 直接体积渲染的最大追踪视图距离（默认值=30000） |
| `r.HeterogeneousVolumes.OrthoGrid` | `1` | 启用正交体素网格（默认值=1） |
| `r.HeterogeneousVolumes.OrthoGrid.MaxBottomLevelMemoryInMegabytes` | `128` | 最小体素大小（默认值=128） |
| `r.HeterogeneousVolumes.OrthoGrid.ShadingRate` | `4` | 体素化率（默认值=4.0） |
| `r.HeterogeneousVolumes.OrthoGrid.VoxelizationMode` | `1` | 体素化模式（默认值=1） 0：屏幕空间体素大小（旧行为） 1：世界空间体素大小 |
| `r.HeterogeneousVolumes.Preshading` | `0` | 在渲染结果之前将材质求值为规范的预着色体积（默认值=0） |
| `r.HeterogeneousVolumes.Preshading.MipLevel` | `0` | 静态确定求值预着色体积数据时的MIP级别（默认值=0） |
| `r.HeterogeneousVolumes.Shadows` | `0` | 启用异类体积投射阴影（默认值=0） |
| `r.HeterogeneousVolumes.Shadows.AbsoluteErrorThreshold` | `0` | 体积阴影压缩的绝对误差阈值（默认值=0.0） |
| `r.HeterogeneousVolumes.Shadows.CameraDownsampleFactor` | `2` | 控制摄像机体积阴影贴图的下采样因子（默认值=2） |
| `r.HeterogeneousVolumes.Shadows.DebugTweak` | `0` | 调试调整值（默认值=0） |
| `r.HeterogeneousVolumes.Shadows.Jitter` | `0` | 构建阴影时启用抖动（默认值=0） |
| `r.HeterogeneousVolumes.Shadows.MaxSampleCount` | `8` | 编译体积阴影贴图时的最大样本数（默认值=8） |
| `r.HeterogeneousVolumes.Shadows.Mode` | `0` | 0：实时着色（默认值）1：预着色体素网格 |
| `r.HeterogeneousVolumes.Shadows.OutOfFrustumShadingRate` | `2` | 调试调整值（默认值=0） |
| `r.HeterogeneousVolumes.Shadows.RelativeErrorThreshold` | `0.05` | 体积阴影压缩的相对误差阈值（默认值=0.05） |
| `r.HeterogeneousVolumes.Shadows.Resolution` | `512` | 编译体积阴影贴图时的分辨率（默认值=512） |
| `r.HeterogeneousVolumes.Shadows.ShadingRate` | `2` | 调试调整值（默认值=0） |
| `r.HeterogeneousVolumes.Shadows.StepSize` | `2` | 编译体积阴影图时的光线行进步长大小（默认值=2.0） |
| `r.HeterogeneousVolumes.Shadows.UseAVSMCompression` | `1` | 启用AVSM压缩（默认值=1） |
| `r.HeterogeneousVolumes.ShadowStepSize` | `-1` | 阴影光线的光线行进步长大小重载（默认值=-1.0，禁用） |
| `r.HeterogeneousVolumes.SparseVoxel` | `0` | 使用稀疏体素渲染算法（默认值=0） |
| `r.HeterogeneousVolumes.SparseVoxel.GenerationMipBias` | `3` | 确定稀疏体素生成的MIP偏差（默认值=3） |
| `r.HeterogeneousVolumes.SparseVoxel.PerTileCulling` | `1` | 使用平铺渲染时启用稀疏体素剔除（默认值=1） |
| `r.HeterogeneousVolumes.SparseVoxel.Refinement` | `1` | 使用分层细化来合并相邻的稀疏体素（默认值=1） |
| `r.HeterogeneousVolumes.StepSize` | `-1` | 光线行进步长大小重载（默认值=-1.0，禁用） |
| `r.HeterogeneousVolumes.Tessellation.BottomLevelGrid.HomogeneousAggregation` | `1` | 启用底层体素同质聚合（默认值=1） |
| `r.HeterogeneousVolumes.Tessellation.BottomLevelGrid.HomogeneousAggregationThreshold` | `0.001` | 底层体素同质聚合阈值（默认值=1.0e-3） |
| `r.HeterogeneousVolumes.Tessellation.BottomLevelGrid.Resolution` | `4` | 确定图块内底层网格分辨率（默认值=4） |
| `r.HeterogeneousVolumes.Tessellation.BottomLevelGrid.VoxelHashing` | `0` | 启用底层体素哈希以去重（默认值=0） |
| `r.HeterogeneousVolumes.Tessellation.BottomLevelGrid.VoxelHashingMemoryInMegabytes` | `64` | 启用底层体素哈希以去重（默认值=64） |
| `r.HeterogeneousVolumes.Tessellation.FarPlaneAutoTransition` | `1` | 启用根据投影的最小体素大小自动过渡远平面距离（默认值=1） |
| `r.HeterogeneousVolumes.Tessellation.IndirectionGrid` | `1` | 启用底层内存的惰性分配（默认值=1） |
| `r.HeterogeneousVolumes.Tessellation.IndirectionGrid.Resolution` | `4` | 确定图块内间接网格分辨率（默认值=4） |
| `r.HeterogeneousVolumes.Tessellation.Jitter` | `1` | 在曲面细分加速网格时启用抖动（默认值=1） |
| `r.HeterogeneousVolumes.Tessellation.MajorantGrid` | `1` | 启用编译强级网格以加速体积跟踪（默认值=0） |
| `r.HeterogeneousVolumes.Tessellation.MajorantGrid.Max` | `0` | 启用编译强级网格以加速体积跟踪（默认值=0） |
| `r.HeterogeneousVolumes.Tessellation.MinimumVoxelSizeInFrustum` | `1` | 最小体素大小（默认值=1.0） |
| `r.HeterogeneousVolumes.Tessellation.MinimumVoxelSizeOutsideFrustum` | `100` | 最小体素大小（默认值=100.0） |
| `r.HeterogeneousVolumes.Tessellation.TopLevelBitmask` | `0` | 启用顶层位掩码以加速网格遍历（默认值=0） |
| `r.HeterogeneousVolumes.Velocity` | `0` | 将异类体积速度写入功能缓冲区（默认值=0） |
| `r.HeterogeneousVolumes.VolumeResolution.X` | `0` | 重载X轴的预着色和光照体积分辨率（默认值=0）0：禁用，使用逐体积属性 >0：重载X轴分辨率 |
| `r.HeterogeneousVolumes.VolumeResolution.Y` | `0` | 重载X轴的预着色和光照体积分辨率（默认值=0）0：禁用，使用逐体积属性 >0：重载Y轴分辨率 |
| `r.HeterogeneousVolumes.VolumeResolution.Z` | `0` | 重载X轴的预着色和光照体积分辨率（默认值=0）0：禁用，使用逐体积属性 >0：重载Z轴分辨率 |
| `r.HeterogeneousVolumes.VolumetricFog` | `1` | 将体积雾应用于异类体积（默认值=1） |

### 局部曝光

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.LocalExposure` | `1` | 是否支持局部曝光 |
| `r.LocalExposure.VisualizeDebugMode` | `0` | 当启用显示->可视化->局部曝光时，此标记可控制使用哪种模式。 0：局部曝光 1：基础亮度 2：细节亮度 3：有效双边网格查找 |

### 局部雾体积

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.LocalFogVolume` | `1` | 不为0时，会渲染LocalFogVolume组件，否则会忽略。 |
| `r.LocalFogVolume.ApplyOnTranslucent` | `0` | 此项目设置允许对半透明元素上的局部雾体积进行取样。 |
| `r.LocalFogVolume.GlobalStartDistance` | `2000` | 局部雾体积开始出现时的起始距离，以厘米为单位。 |
| `r.LocalFogVolume.HalfResolution` | `0` | 设置为1将以一半的分辨率渲染局部雾体积，稍后再上采样到全分辨率。目前仅适用于移动路径。 |
| `r.LocalFogVolume.MaxDensityIntoVolumetricFog` | `0.01` | LocalFogVolume高度雾模式在底部的密度可呈指数级增长。由于密度高，VolumetricFog时间重投影可能会发生泄漏。限制密度即可控制视觉瑕疵。 |
| `r.LocalFogVolume.RenderDuringHeightFogPass` | `0` | LocalFogVolume将在高度雾通道中进行渲染，跳过特定的平铺渲染通道。仅在非移动路径上作为试验性功能应用。 |
| `r.LocalFogVolume.RenderIntoVolumetricFog` | `1` | 当该值不为0时，LocalFogVolume将被体素化到体积雾中，否则它将保持孤立状态。 |
| `r.LocalFogVolume.TileCullingUseAsync` | `1` | 如果我们想尝试在异步管道上使用剔除，则为True。 |
| `r.LocalFogVolume.TileDebug` | `0` | 调试平铺渲染数据的复杂性。1：显示逐图块LFV计数为颜色；2：与1相同，但也显示像素丢弃/剪切的效果。 |
| `r.LocalFogVolume.TileMaxInstanceCount` | `32` | 逐视图（以及逐图块，以确保一致性）所考虑的局部雾体积数量上限。 |
| `r.LocalFogVolume.TilePixelSize` | `128` | 屏幕上的图块大小（以像素为单位），我们以此大小剔除局部雾体积。 |
| `r.LocalFogVolume.UseHZB` | `1` | 使用HZB剔除局部雾体积。 |

### Lumen

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.Lumen.AsyncCompute` | `1` | Lumen是否应使用异步计算（如果支持）。 |
| `r.Lumen.DiffuseIndirect.Allow` | `1` | 是否允许Lumen全局光照。 Lumen GI已在项目设置中启用，此控制台变量只能禁用它。 |
| `r.Lumen.DiffuseIndirect.AsyncCompute` | `1` | 是否在计算管道上运行Lumen漫反射间接通道（如果可以）。 |
| `r.Lumen.DiffuseIndirect.CardInterpolateInfluenceRadius` | `10` | 。 |
| `r.Lumen.DiffuseIndirect.CardTraceEndDistanceFromCamera` | `4000` |  |
| `r.Lumen.DiffuseIndirect.CullGridDistributionLogZOffset` | `1` |  |
| `r.Lumen.DiffuseIndirect.CullGridDistributionLogZScale` | `0.01` |  |
| `r.Lumen.DiffuseIndirect.CullGridDistributionZScale` | `4` |  |
| `r.Lumen.DiffuseIndirect.CullGridPixelSize` | `64` | 发片网格中单元的大小，以像素为单位。 |
| `r.Lumen.DiffuseIndirect.MeshSDF.AverageCulledCount` | `512` |  |
| `r.Lumen.DiffuseIndirect.MeshSDF.DitheredTransparencyStepThreshold` | `0.1` | 逐步长随机半透明度阈值，用于追踪启用了抖动透明度的用户，用于包含大部分双面材质（植被）的网格体SDF |
| `r.Lumen.DiffuseIndirect.MeshSDF.NotCoveredExpandSurfaceScale` | `0.6` | 缩放用于主要包含双面材质（植被）的网格体SDF的表面扩展 |
| `r.Lumen.DiffuseIndirect.MeshSDF.NotCoveredMinStepScale` | `32` | 缩放用于主要包含双面材质（植被）的网格体SDF的最小步长以提高性能 |
| `r.Lumen.DiffuseIndirect.MeshSDF.RadiusThreshold` | `30` |  |
| `r.Lumen.DiffuseIndirect.MinSampleRadius` | `10` | 。 |
| `r.Lumen.DiffuseIndirect.MinTraceDistance` | `0` | 。 |
| `r.Lumen.DiffuseIndirect.SSAO` | `0` | 是否仅当禁用r.Lumen.ScreenProbeGather.ShortRangeAO时，渲染并将SSAO应用于Lumen GI。 当Lumen的屏幕弯曲法线由于可伸缩性而被禁用时，这对于提供短距离遮挡很有用，但是屏幕半径等SSAO设置来自用户的后期处理设置。 |
| `r.Lumen.DiffuseIndirect.SurfaceBias` | `5` | 。 |
| `r.Lumen.DiffuseIndirect.TraceStepFactor` | `1` | 。 |
| `r.Lumen.HardwareRayTracing` | `0` | 使用硬件光线追踪实现Lumen功能（如果可用）。 否则，Lumen将重新使用软件光线追踪。 注意：对于具有超过10万个实例的场景，硬件光线追踪将产生显著的场景更新开销。 |
| `r.Lumen.HardwareRayTracing.FarFieldBias` | `200` | 确定远场追踪的偏差。默认值=200 |
| `r.Lumen.HardwareRayTracing.HitLighting.ReflectionCaptures` | `0` | 是否在使用命中光照（Hit Lighting）时将反射捕获应用于光线命中。 |
| `r.Lumen.HardwareRayTracing.Inline` | `1` | 将硬件内联光线追踪用于选定的Lumen通道（如果可用）。 |
| `r.Lumen.HardwareRayTracing.LightingMode` | `0` | 确定光照模式（默认值=0） 0：从表面缓存内插最终光照 1：对材质求值，并从表面缓存内插辐照度和间接辐照度 2：对材质和直接光照求值，并从表面缓存中内插间接辐照度 3：对命中点的材质、直接光照和无阴影天空光照求值 |
| `r.Lumen.HardwareRayTracing.MaxIterations` | `8192` | 限制受支持平台上光线追踪遍历迭代的次数。 不完整的未击中将被视为击中黑色表面（可能导致过度遮挡）。 不完整的命中将被视为命中（可能导致泄漏）。 |
| `r.Lumen.HardwareRayTracing.MinTraceDistanceToSampleSurfaceCache` | `10` | 我们可以开始对表面缓存进行取样以修复反馈回路的光线命中距离，在反馈回路中，表面缓存纹素命中自身并传播光照。 |
| `r.Lumen.HardwareRayTracing.PullbackBias` | `8` | 确定恢复屏幕追踪光线时的拉回偏差（默认值=8.0） |
| `r.Lumen.HardwareRayTracing.SkipBackFaceHitDistance` | `5` | 启用背面剔除的追踪距离，当光线追踪几何体与GBuffer（Nanite代理几何体）不匹配时很有用。 |
| `r.Lumen.HardwareRayTracing.SkipTwoSidedHitDistance` | `1` | 启用SkipBackFaceHitDistance后，将跳过此距离内的第一个双面材质命中。这对于避免与植被上的Nanite回退网格体发生自相交很有用，因为SkipBackFaceHitDistance不适用于双面材质。 |
| `r.Lumen.IrradianceFieldGather` | `0` | 是否使用辐照度场最终采集，此为试验性不透明最终采集，从探头的预计算辐照度进行插值，开销更低，但全局光照质量较低。 |
| `r.Lumen.IrradianceFieldGather.ClipmapDistributionBase` | `2` | Pow()的基类可控制每个连续裁剪图相对于第一个的大小。 |
| `r.Lumen.IrradianceFieldGather.ClipmapWorldExtent` | `5000` | 第一个裁剪图的世界空间范围 |
| `r.Lumen.IrradianceFieldGather.GridResolution` | `64` | 每个裁剪图中探头放置网格的分辨率 |
| `r.Lumen.IrradianceFieldGather.IrradianceProbeResolution` | `6` | 探头二维辐照度布局的分辨率。 |
| `r.Lumen.IrradianceFieldGather.NumClipmaps` | `4` | 辐射率缓存裁剪图的数量。 |
| `r.Lumen.IrradianceFieldGather.NumMipmaps` | `1` | 辐射率缓存mipmap的数量。 |
| `r.Lumen.IrradianceFieldGather.NumProbesToTraceBudget` | `200` | 下采样之前可以在一帧中更新的探头数量。 |
| `r.Lumen.IrradianceFieldGather.OcclusionProbeResolution` | `16` | 探头二维遮挡布局的分辨率。 |
| `r.Lumen.IrradianceFieldGather.ProbeAtlasResolutionInProbes` | `128` | 一维探头图集缓存纹理的探头数量。 此变量可以控制缓存的内存使用情况。 当前溢出会导致渲染不正确。 |
| `r.Lumen.IrradianceFieldGather.ProbeOcclusionNormalBias` | `20` | 沿法线偏移，以减少探头遮挡造成的自遮挡瑕疵 |
| `r.Lumen.IrradianceFieldGather.ProbeOcclusionViewBias` | `20` | 沿视图方向偏移，以减少探头遮挡造成的自遮挡瑕疵 |
| `r.Lumen.IrradianceFieldGather.ProbeResolution` | `16` | 探头二维辐射布局的分辨率。 探头追踪的光线数量为ProbeResolution ^ 2 |
| `r.Lumen.IrradianceFieldGather.RadianceCache.Stats` | `0` | GPU打印出辐射率缓存更新统计数据。 |
| `r.Lumen.Ortho.LumenSceneMinCardResolution` | `1` | 如果存在正交视图，则强制将SurfaceCache MinCard设置为OrthoMinCardResolution，否则使用标准的MinCardResolution。0为禁用，值更高时，将强制使用正交视图中的分辨率 |
| `r.Lumen.Ortho.OverrideMeshDFTraceDistances` | `1` | 使用正交视图中的全屏视图矩形大小来确定SDF追踪距离，而不是手动设置值。 |
| `r.Lumen.ProbeHierarchy.SamplePerPixel` | `8` | 全分辨率逐像素进行的取样数。 |
| `r.Lumen.RadianceCache.DownsampleDistanceFromCamera` | `4000` | 与摄像机的距离超过此值的探头始终会进行下采样。 |
| `r.Lumen.RadianceCache.ForceFullUpdate` | `0` |  |
| `r.Lumen.RadianceCache.ForceUniformTraceTileLevel` | `-1` | 设置为>=0时，强制使用统一的跟踪图块级别进行调试，并重载追踪图块BRDF重要性取样。 有效范围[0, 2]。 0=半分辨率，1=全分辨率，2=超级采样 |
| `r.Lumen.RadianceCache.HardwareRayTracing` | `1` | 为Lumen辐射率缓存启用硬件光线追踪（默认值=1） |
| `r.Lumen.RadianceCache.HardwareRayTracing.Retrace.FarField` | `1` | 确定是否为远场贡献触发第二次追踪（默认值=1） |
| `r.Lumen.RadianceCache.HardwareRayTracing.TemporaryBufferAllocationDownsampleFactor` | `8` | 硬件光线追踪辐射率缓存使用的临时缓冲区的下采样因子。 下采样因子超高，可以节省越多的临时分配器内存，但可能会导致溢出和瑕疵。 |
| `r.Lumen.RadianceCache.NumFramesToKeepCachedProbes` | `8` | 在缓存中保留未使用探头的帧数。值越高，帧之间可以进行的重用越多，但是值过高将导致过期探头的过滤。 |
| `r.Lumen.RadianceCache.OverrideCacheOcclusionLighting` | `0` |  |
| `r.Lumen.RadianceCache.ShowBlackRadianceCacheLighting` | `0` |  |
| `r.Lumen.RadianceCache.SortTraceTiles` | `0` | 是否在追踪之前按方向对追踪图块进行排序以提取一致性 |
| `r.Lumen.RadianceCache.SpatialFilterMaxRadianceHitAngle` | `0.2` | 以度为单位。 较大角度允许过滤附近特性，但泄漏也越多。 |
| `r.Lumen.RadianceCache.SpatialFilterProbes` | `1` | 是否过滤邻域之间的探头辐射率 |
| `r.Lumen.RadianceCache.SupersampleDistanceFromCamera` | `2000` | 只有与摄像机的距离小于此值的探头才能进行超级采样。 |
| `r.Lumen.RadianceCache.SupersampleTileBRDFThreshold` | `0.1` | BRDF值[0-1]，高于该值时将追踪更多光线，以对探头辐射率进行超级采样。 |
| `r.Lumen.RadianceCache.Update` | `1` | 是否每帧更新辐射率缓存 |
| `r.Lumen.RadianceCache.Visualize` | `0` |  |
| `r.Lumen.RadianceCache.VisualizeClipmapIndex` | `-1` | 选择要可视化的辐射率缓存裁剪图。-1，一次显示所有裁剪图。 |
| `r.Lumen.RadianceCache.VisualizeProbeRadius` | `0` | 是否显示辐射率缓存探头半径 |
| `r.Lumen.RadianceCache.VisualizeRadiusScale` | `0.05` | 缩放用于可视化辐射率缓存样本的球体大小。 |
| `r.Lumen.Reflections.Allow` | `1` | 是否允许Lumen反射。 Lumen反射已在项目设置中启用，此控制台变量只能禁用它。 |
| `r.Lumen.Reflections.AsyncCompute` | `0` | 是否在计算管道上运行Lumen反射通道（如果可以）。 |
| `r.Lumen.Reflections.BilateralFilter` | `1` | 是否执行双边滤波器作为去除Lumen反射噪点的最后一步。 |
| `r.Lumen.Reflections.BilateralFilter.DepthWeightScale` | `10000` | 缩放双边滤波器的深度权重 |
| `r.Lumen.Reflections.BilateralFilter.NormalAngleThresholdScale` | `1` | 缩放双边滤波器的法线角度阈值 |
| `r.Lumen.Reflections.BilateralFilter.NumSamples` | `4` | 双边滤波器样本数量。 |
| `r.Lumen.Reflections.BilateralFilter.SpatialKernelRadius` | `0.002` | 空间核半径，为视口大小的分数形式 |
| `r.Lumen.Reflections.BilateralFilter.StrongBlurVarianceThreshold` | `0.5` | 空间解析滤波器的方差高于此值的像素会有更强的双边模糊。 |
| `r.Lumen.Reflections.Contrast` | `1` | 非物理上正确的Lumen反射对比度。建议保持在1。 |
| `r.Lumen.Reflections.DistantScreenTraces` | `1` | 是否从Lumen场景结束的地方开始进行线性屏幕追踪，以处理远距离反射。 |
| `r.Lumen.Reflections.DistantScreenTraces.DepthThreshold` | `2` | 在其他追踪未命中的地方完成的线性屏幕追踪的深度阈值。 |
| `r.Lumen.Reflections.DistantScreenTraces.MaxTraceDistance` | `200000` | 远距离屏幕追踪的追踪距离。 |
| `r.Lumen.Reflections.DownsampleFactor` | `1` |  |
| `r.Lumen.Reflections.FixedStateFrameIndex` | `-1` | 是否重载View.StateFrameIndex以调试Lumen反射。 |
| `r.Lumen.Reflections.GGXSamplingBias` | `0.1` |  |
| `r.Lumen.Reflections.HairStrands.ScreenTrace` | `1` | 是否根据毛发深度进行追踪，以便将毛发阴影投射到不透明对象上。 |
| `r.Lumen.Reflections.HairStrands.VoxelTrace` | `1` | 是否根据毛发体素结构进行追踪，以便将毛发阴影投射到不透明对象上。 |
| `r.Lumen.Reflections.HardwareRayTracing` | `1` | 为Lumen反射启用硬件光线追踪（默认值=1） |
| `r.Lumen.Reflections.HardwareRayTracing.BucketMaterials` | `1` | 确定是否将次要追踪分桶以便进行一致的材质访问（默认值=1） |
| `r.Lumen.Reflections.HardwareRayTracing.Retrace.FarField` | `1` | 确定是否为远场贡献触发第二次追踪（默认值=1） |
| `r.Lumen.Reflections.HardwareRayTracing.Retrace.HitLighting` | `0` | 确定是否针对无效的表面缓存命中触发第二次命中光照追踪（默认值=0） |
| `r.Lumen.Reflections.HardwareRayTracing.Translucent.MaxRefractionBounces` | `0` | 要追踪的折射事件的最大数量。 |
| `r.Lumen.Reflections.HardwareRayTracing.Translucent.Refraction.EnableForProject` | `1` | 是否在使用硬件光线追踪和命中光照时使用来自表面的Lumen折射追踪。这将需要重新编译着色器，以编译半透明发片捕获Lumen着色器。启用后会增加GPU开销。 |
| `r.Lumen.Reflections.HierarchicalScreenTraces.HistoryDepthTestRelativeThickness` | `0.01` | HZB追踪命中与允许命中的前一帧场景深度之间的距离，作为相对深度阈值。 |
| `r.Lumen.Reflections.HierarchicalScreenTraces.MaxIterations` | `50` | HZB追踪的最大迭代次数。 |
| `r.Lumen.Reflections.HierarchicalScreenTraces.MinimumOccupancy` | `0` | 中止追踪之前仍在追踪的线程数下限。 可用于可伸缩性以放弃具有不成比例开销的追踪。 |
| `r.Lumen.Reflections.HierarchicalScreenTraces.RelativeDepthThickness` | `0.005` | 确定HZB追踪命中对象的深度厚度，作为相对深度阈值。 |
| `r.Lumen.Reflections.HiResSurface` | `1` | 反射是否应该对最高可用表面数据进行取样或使用最低分辨率始终驻留页面。 |
| `r.Lumen.Reflections.MaxBounces` | `0` | 设置递归反射反弹的次数上限。值大于0时将重载后期处理体积设置。1表示单次反射光线（镜子中没有二次反射）。目前仅支持带有命中光照的硬件光线追踪。 |
| `r.Lumen.Reflections.MaxRayIntensity` | `100` | 限制最大光线光照强度（使用PreExposure）以减少萤火虫。 |
| `r.Lumen.Reflections.MaxRoughnessToTrace` | `-1` | Lumen仍可追踪专用反射光线的最大粗糙度值。当设置为>=0的值时，重载后期处理体积设置。 |
| `r.Lumen.Reflections.MaxRoughnessToTraceClamp` | `1` | Lumen仍可追踪专用反射光线的最大粗糙度值的可伸缩性限制。项目和后期处理体积设置被限制为此值。适用于可伸缩性。 |
| `r.Lumen.Reflections.MaxRoughnessToTraceForFoliage` | `0.4` | Lumen仍可追踪来自植被像素的专用反射光线的最大粗糙度值。其中植被像素为具有双面或次表面着色模型的像素。 |
| `r.Lumen.Reflections.RadianceCache` | `0` | 是否重复使用Lumen的ScreenProbeGather辐射率缓存（可用时）。 启用后，粗糙表面的反射光线会缩短，远距离光照来自辐射率缓存的插值，从而加快追踪速度。 |
| `r.Lumen.Reflections.RadianceCache.AngleThresholdScale` | `1` | 控制何时使用辐射率缓存进行远距离光照。 值为1表示仅在适合反射椎体时使用辐射率缓存，值越低，越激进。 |
| `r.Lumen.Reflections.RadianceCache.ReprojectionRadiusScale` | `10` | 当从辐射率缓存进行插值时，缩放与视差校正相交的每个辐射率缓存探头周围球体的半径。 |
| `r.Lumen.Reflections.RoughnessFadeLength` | `0.1` |  |
| `r.Lumen.Reflections.SampleSceneColorAtHit` | `1` | 是否对反射光线命中时的SceneColor进行取样（SWRT和HWRT）。适用于隐藏当屏幕追踪到达前景对象后面时放弃的区域。0 - 禁用。1 - 仅当启用屏幕空间追踪时才启用。2 - 始终启用。 |
| `r.Lumen.Reflections.SampleSceneColorNormalTreshold` | `85` | 以度为单位的法线阈值，可控制在允许SceneColor取样之前，光线命中法线和屏幕法线的距离。0 - 仅允许完全匹配的法线。180 - 允许全部法线。 |
| `r.Lumen.Reflections.SampleSceneColorRelativeDepthThickness` | `0.05` | 深度阈值，可控制在允许SceneColor取样之前，光线命中与深度缓冲区的距离。 |
| `r.Lumen.Reflections.ScreenSpaceReconstruction` | `1` | 是否使用屏幕空间BRDF重加权重构 |
| `r.Lumen.Reflections.ScreenSpaceReconstruction.KernelRadius` | `8` | 屏幕空间反射过滤器核半径，以像素为单位 |
| `r.Lumen.Reflections.ScreenSpaceReconstruction.NumSamples` | `5` | 用于屏幕空间BRDF重新加权重构的样本数量 |
| `r.Lumen.Reflections.ScreenSpaceReconstruction.RoughnessScale` | `1` | 值高于1时，允许相邻追踪更激进地模糊在一起，但物理上并不正确。 |
| `r.Lumen.Reflections.ScreenSpaceReconstruction.TonemapStrength` | `0` | 在空间解析过程中，对反射辐射率值进行平均时是否对其进行色调映射。 这样可减少噪点，但也会消除反射中明亮相关的特性。 |
| `r.Lumen.Reflections.ScreenTraces` | `1` | 是否在回退到其他方法之前根据屏幕反射进行追踪。 |
| `r.Lumen.Reflections.SmoothBias` | `0` | 值大于0时，对Lumen反射应用全局材质粗糙度偏差，其中1表示完全镜面。 |
| `r.Lumen.Reflections.SpecularScale` | `1` | 非物理上正确的Lumen高光度反射比例。建议保持在1。 |
| `r.Lumen.Reflections.SurfaceCacheFeedback` | `1` | 是否允许从反射光线写入虚拟表面缓存反馈缓冲区。 |
| `r.Lumen.Reflections.Temporal` | `1` | 是否使用时间滤波器 |
| `r.Lumen.Reflections.Temporal.DistanceThreshold` | `0.03` | 丢弃最后一帧的光照结果所需的世界空间距离阈值。 值越低，靠近墙壁时角色的重影越少，但闪烁瑕疵会越多。 |
| `r.Lumen.Reflections.Temporal.MaxFramesAccumulated` | `32` | 值较低时会导致时间滤波器更快地传播光照变化，但也会增加噪点引起的闪烁。 |
| `r.Lumen.Reflections.Temporal.MaxRayDirections` | `16` | 可能的逐像素随机方向数量。应根据MaxFramesAccumulated进行调整。 |
| `r.Lumen.Reflections.Temporal.NeighborhoodClampExpandWithResolveVariance` | `0.1` | 用于扩大邻域方差的解析方差分数。 这允许在噪点区域出现一些重影，以避免摄像机静止时出现闪烁。 仅在双边滤波器启用时有效。 |
| `r.Lumen.Reflections.TraceCompaction.GroupSizeInTraceTiles` | `16` | 追踪压缩线程组的大小。 组越大=压缩追踪的一致性越佳。 目前仅受WaveOps路径支持。 |
| `r.Lumen.Reflections.TraceCompaction.WaveOps` | `1` | 是否使用Wave Ops路径进行追踪压缩。 |
| `r.Lumen.Reflections.TraceMeshSDFs` | `1` |  |
| `r.Lumen.Reflections.VisualizeTraces` | `0` | 是否从光标位置可视化反射追踪，适用于调试 |
| `r.Lumen.Reflections.VisualizeTracingCoherency` | `0` | 设置为1以捕获来自随机波前的追踪并将其绘制在屏幕上。再次设置为1可以重新捕获。 着色器必须先启用支持，请参阅DEBUG_SUPPORT_VISUALIZE_TRACE_COHERENCY |
| `r.Lumen.ReSTIRGather` | `0` | 是否使用原型ReSTIR最终采集器。 默认禁用，因为目前质量比LumenScreenProbeGather低得多，并且支持的功能更少。 |
| `r.Lumen.ReSTIRGather.BilateralFilter` | `1` | 是否执行双边滤波器，作为去除Lumen ReSTIRGathers噪点的最后一步。 |
| `r.Lumen.ReSTIRGather.BilateralFilter.DepthWeightScale` | `10000` | 缩放双边滤波器的深度权重 |
| `r.Lumen.ReSTIRGather.BilateralFilter.NormalAngleThresholdScale` | `0.2` | 缩放双边滤波器的法线角度阈值 |
| `r.Lumen.ReSTIRGather.BilateralFilter.NumSamples` | `8` | 双边滤波器样本数量。 |
| `r.Lumen.ReSTIRGather.BilateralFilter.SpatialKernelRadius` | `0.002` | 空间核半径，为视口大小的分数形式 |
| `r.Lumen.ReSTIRGather.BilateralFilter.StrongBlurVarianceThreshold` | `0.5` | 空间解析滤波器的方差高于此值的像素会有更强的双边模糊。 |
| `r.Lumen.ReSTIRGather.DownsampleFactor` | `2` | 从主视口下采样因子以追踪光线，创建并重采样蓄水池。 这是算法追踪/重采样部分的主要性能控制。 |
| `r.Lumen.ReSTIRGather.FixedJitterIndex` | `-1` | 当值为0或更大时，使用常量重载帧索引以进行调试 |
| `r.Lumen.ReSTIRGather.MaxRayIntensity` | `100` | 限制最大光线光照强度（使用PreExposure）以减少萤火虫。 |
| `r.Lumen.ReSTIRGather.ResamplingAngleThreshold` | `25` | 蓄水池重采样期间允许的两个蓄水池之间的最大角度，以度为单位 |
| `r.Lumen.ReSTIRGather.ResamplingDepthErrorThreshold` | `0.01` | 蓄水池采样期间允许的两个蓄水池之间的最大深度误差 |
| `r.Lumen.ReSTIRGather.ShortRangeAO` | `1` | 是否计算短距离、全分辨率环境光遮蔽来添加ReSTIR GI由于空间滤波而缺少的高频遮挡（接触阴影）。 |
| `r.Lumen.ReSTIRGather.ShortRangeAO.MaxScreenTraceFraction` | `0.02` | 短距离环境光遮蔽追踪距离，为屏幕尺寸的分数形式。 |
| `r.Lumen.ReSTIRGather.SpatialResampling` | `1` | 是否对蓄水池使用空间重采样通道 |
| `r.Lumen.ReSTIRGather.SpatialResampling.KernelRadius` | `0.05` | 空间重采样核的半径，为屏幕的分数形式。 |
| `r.Lumen.ReSTIRGather.SpatialResampling.NumPasses` | `2` | 要使用的空间重采样通道数 |
| `r.Lumen.ReSTIRGather.SpatialResampling.NumSamples` | `4` | 每个重采样通道的空间样本数量。 |
| `r.Lumen.ReSTIRGather.SpatialResampling.OcclusionScreenTraceDistance` | `0.2` | 遮挡屏幕追踪的长度，用于在重复使用之前验证邻近蓄水池命中位置，以减少泄漏。 为屏幕尺寸的分数形式。 |
| `r.Lumen.ReSTIRGather.Temporal` | `1` | 是否使用时间滤波器 |
| `r.Lumen.ReSTIRGather.Temporal.ClearHistoryEveryFrame` | `0` | 是否每帧清除历史记录以便调试 |
| `r.Lumen.ReSTIRGather.Temporal.DistanceThreshold` | `0.005` | 丢弃最后一帧的光照结果所需的相对距离阈值。 值越低，靠近墙壁时角色的重影越少，但闪烁瑕疵会越多。 |
| `r.Lumen.ReSTIRGather.Temporal.MaxFramesAccumulated` | `10` | 值较低时会导致时间滤波器更快地传播光照变化，但也会增加噪点引起的闪烁。 |
| `r.Lumen.ReSTIRGather.TemporalResampling` | `1` | 是否对蓄水池执行时间重采样通道 |
| `r.Lumen.ReSTIRGather.TemporalResampling.DistanceThreshold` | `0.005` |  |
| `r.Lumen.ReSTIRGather.TemporalResampling.ResetHistory` | `0` |  |
| `r.Lumen.ReSTIRGather.TemporalResampling.ValidateEveryNFrames` | `0` | 通过重新追踪光线并每N帧比较命中位置和辐射率来验证时间蓄水池。 用于减少光照变化的滞后，但会引入噪点。 |
| `r.Lumen.ReSTIRGather.Upsample.KernelSize` | `3` | 上采样核大小，以蓄水池纹素为单位 |
| `r.Lumen.ReSTIRGather.Upsample.Method` | `1` | 上采样方法，当根据下采样蓄水池辐射率计算全分辨率辐照度时 0 - 当抖动位置位于同一平面时，抖动双线性样本，当所有样本失败时，回退到非抖动 1 - 螺旋样本模式 2 - 调试直通。 由于未计算方差，因此也能有效地禁用双边滤波器。 |
| `r.Lumen.ReSTIRGather.Upsample.NumSamples` | `16` | 上采样时要采集的蓄水池样本数量。仅当r.Lumen.ReSTIRGather.Upsample.Method设置为螺旋模式（Spiral Pattern）时使用。 |
| `r.Lumen.SampleFog` | `0` | 对Lumen追踪中的雾贡献进行取样。默认禁用。 |
| `r.Lumen.ScreenProbeGather` | `1` | 是否使用屏幕探头最终采集器 |
| `r.Lumen.ScreenProbeGather.AdaptiveProbeAllocationFraction` | `0.5` | 均匀探头分数，以允许自适应探头放置。 |
| `r.Lumen.ScreenProbeGather.AdaptiveProbeMinDownsampleFactor` | `4` | 屏幕探头将被放置在需要下至此GBuffer下采样因子的位置。 |
| `r.Lumen.ScreenProbeGather.DiffuseIntegralMethod` | `0` | 球面谐波=0，重要性样本BRDF=1，数值积分参考=2 |
| `r.Lumen.ScreenProbeGather.DirectLighting` | `0` | 启用后，是否通过Lumen的最终采集器渲染所有局部光源。 这样产生的直接光照开销低但质量也低。 |
| `r.Lumen.ScreenProbeGather.DownsampleFactor` | `16` | 将在其上放置屏幕探头的屏幕图块的像素大小。 |
| `r.Lumen.ScreenProbeGather.Filtering.WaveOps` | `1` | 是否使用Wave Ops路径进行屏幕探头过滤。 |
| `r.Lumen.ScreenProbeGather.FixedJitterIndex` | `-1` | 如果值为零或更大，则用固定索引重载时间抖动索引。 适用于调试和检查取样模式。 |
| `r.Lumen.ScreenProbeGather.FullResolutionJitterWidth` | `1` | 应用于屏幕探头上采样的全分辨率抖动的大小，为屏幕图块的分数形式。 宽度为1会导致DownsampleFactor像素数的抖动。 |
| `r.Lumen.ScreenProbeGather.GatherNumMips` | `1` | 为漫反射集成准备的Mip贴图数量 |
| `r.Lumen.ScreenProbeGather.GatherOctahedronResolutionScale` | `1` | 将发生探头过滤和集成的分辨率，以TracingOctahedronResolution为比例 |
| `r.Lumen.ScreenProbeGather.HairStrands.ScreenTrace` | `0` | 是否根据毛发深度进行追踪，以便将毛发阴影投射到不透明对象上。 |
| `r.Lumen.ScreenProbeGather.HairStrands.VoxelTrace` | `1` | 是否根据毛发体素结构进行追踪，以便将毛发阴影投射到不透明对象上。 |
| `r.Lumen.ScreenProbeGather.HardwareRayTracing` | `1` | 0. 来自Lumen立方体贴图树的漫反射间接软件光线追踪。1.启用漫反射间接硬件光线追踪。（默认值） |
| `r.Lumen.ScreenProbeGather.HardwareRayTracing.NormalBias` | `0.1` | 沿着色法线偏移，当光线追踪几何体与GBuffer（Nanite代理几何体）不匹配时很有用 |
| `r.Lumen.ScreenProbeGather.HardwareRayTracing.Retrace.FarField` | `1` | 确定是否为远场贡献触发第二次追踪（默认值=1） |
| `r.Lumen.ScreenProbeGather.ImportanceSample` | `1` | 是否使用重要性取样来生成探头追踪方向。 |
| `r.Lumen.ScreenProbeGather.ImportanceSample.BRDFOctahedronResolution` | `8` | 逐探头BRDF PDF八面体的分辨率。 |
| `r.Lumen.ScreenProbeGather.ImportanceSample.HistoryDistanceThreshold` | `30` |  |
| `r.Lumen.ScreenProbeGather.ImportanceSample.IncomingLighting` | `1` | 是否对传入光照进行重要性采样，以生成探头追踪方向。 禁用后，仅对BRDF进行重要性采样。 |
| `r.Lumen.ScreenProbeGather.ImportanceSample.MinPDFToTrace` | `0.1` | 用于追踪光线的最小标准化BRDF PDF。 值较大会导致黑角，但可以减少噪点，因为更多的光线能够被重新分配到重要方向。 |
| `r.Lumen.ScreenProbeGather.ImportanceSample.NumLevels` | `1` | 用于屏幕探头重要性取样的细化级别数。 目前仅ScreenProbeGenerateRaysCS中的串行参考路径支持。 |
| `r.Lumen.ScreenProbeGather.ImportanceSample.ProbeRadianceHistory` | `1` | 是否从最后一帧的过滤追踪中对传入光照进行重要性取样，以生成探头追踪方向。 禁用后，将改用辐射率缓存。 |
| `r.Lumen.ScreenProbeGather.InjectLightsToProbes` | `0` | 是否将局部光源注入探头。 试验性 - 速度很快，但由于缺乏方向性和SH振铃而导致环绕光照。 |
| `r.Lumen.ScreenProbeGather.IntegrationTileClassification` | `1` | 是否在漫反射集成期间使用图块分类。 为了实现更好的占用，图块分类通过VGPR分割计算调度，但如果实现不正确，可能会引入误差。 |
| `r.Lumen.ScreenProbeGather.IrradianceFormat` | `0` | 预滤波器辐照度格式 0 - SH3较慢 1 - 八面体探头。速度更快，但启用ShortRangeAO.ApplyDuringIntegration时会恢复为SH3 |
| `r.Lumen.ScreenProbeGather.LightSampleResolutionXY` | `2` | 每个屏幕探头的一维光源样本数量。 当重叠像素的灯光数量较多时，直接光照中的噪点将增加。 |
| `r.Lumen.ScreenProbeGather.MaterialAO` | `1` | 是否将材质环境光遮蔽或材质弯曲法线应用于Lumen GI。 |
| `r.Lumen.ScreenProbeGather.MaxRayIntensity` | `40` | 限制最大光线光照强度（使用PreExposure）以减少萤火虫。 |
| `r.Lumen.ScreenProbeGather.MaxRoughnessToEvaluateRoughSpecular` | `0.8` | 用于对屏幕探头采集器中粗糙高光度求值的最大粗糙度值。 值较低可降低GPU集成开销，但也会丢失粗糙高光度。 |
| `r.Lumen.ScreenProbeGather.RadianceCache` | `1` | 是否启用持久世界空间辐射率缓存 |
| `r.Lumen.ScreenProbeGather.RadianceCache.ClipmapDistributionBase` | `2` | Pow()的基类可控制每个连续裁剪图相对于第一个的大小。 |
| `r.Lumen.ScreenProbeGather.RadianceCache.ClipmapWorldExtent` | `2500` | 第一个裁剪图的世界空间范围 |
| `r.Lumen.ScreenProbeGather.RadianceCache.GridResolution` | `48` | 每个裁剪图中探头放置网格的分辨率 |
| `r.Lumen.ScreenProbeGather.RadianceCache.NumClipmaps` | `4` | 辐射率缓存裁剪图的数量。 |
| `r.Lumen.ScreenProbeGather.RadianceCache.NumMipmaps` | `1` | 辐射率缓存mipmap的数量。 |
| `r.Lumen.ScreenProbeGather.RadianceCache.NumProbesToTraceBudget` | `300` |  |
| `r.Lumen.ScreenProbeGather.RadianceCache.ProbeAtlasResolutionInProbes` | `128` | 一维探头图集缓存纹理的探头数量。 此变量可以控制缓存的内存使用情况。 当前溢出会导致渲染不正确。 |
| `r.Lumen.ScreenProbeGather.RadianceCache.ProbeResolution` | `32` | 探头二维辐射布局的分辨率。 探头追踪的光线数量为ProbeResolution ^ 2 |
| `r.Lumen.ScreenProbeGather.RadianceCache.ReprojectionRadiusScale` | `1.5` |  |
| `r.Lumen.ScreenProbeGather.RadianceCache.Stats` | `0` | GPU打印出辐射率缓存更新统计数据。 |
| `r.Lumen.ScreenProbeGather.ReferenceMode` | `0` | 启用后，每探头追踪1024条均匀光线，无需过滤、重要性取样或辐射率缓存。 |
| `r.Lumen.ScreenProbeGather.RoughSpecularSamplingMode` | `0` | 模式0：将漫反射SH样本用作镜面反射。模式1：沿主GGX高光度反射向量对SH进行取样。 |
| `r.Lumen.ScreenProbeGather.ScreenTraces` | `1` | 是否在回退到其他追踪方法之前根据屏幕进行追踪。 |
| `r.Lumen.ScreenProbeGather.ScreenTraces.HZBTraversal` | `1` | 是否对SSGI使用HZB追踪而非固定步长数相交。 HZB追踪更加准确，特别是不会遗漏细小特征，但速度大约慢3倍。 |
| `r.Lumen.ScreenProbeGather.ScreenTraces.HZBTraversal.FullResDepth` | `1` | HZB遍历是否应该一直进行到全分辨率深度，这样更准确，但会增加内循环的不一致性。 |
| `r.Lumen.ScreenProbeGather.ScreenTraces.HZBTraversal.HistoryDepthTestRelativeThickness` | `0.01` | HZB追踪命中与允许命中的前一帧场景深度之间的距离，作为相对深度阈值。 |
| `r.Lumen.ScreenProbeGather.ScreenTraces.HZBTraversal.MaxIterations` | `50` | HZB追踪的最大迭代次数。 |
| `r.Lumen.ScreenProbeGather.ScreenTraces.HZBTraversal.NumThicknessStepsToDetermineCertainty` | `4` | 用于确定命中特征是否较稀薄且应被忽略的线性搜索步长数。 |
| `r.Lumen.ScreenProbeGather.ScreenTraces.HZBTraversal.RelativeDepthThickness` | `0.02` | 确定HZB追踪命中对象的深度厚度，作为相对深度阈值。 |
| `r.Lumen.ScreenProbeGather.ScreenTraces.HZBTraversal.SkipFoliageHits` | `1` | 是否允许屏幕追踪击中次表面和双面植被着色模型。 可用于解决高频草地几何体的锯齿问题。 |
| `r.Lumen.ScreenProbeGather.ScreenTraces.MinimumOccupancy` | `0` | 中止追踪之前仍在追踪的线程数下限。 可用于可伸缩性以放弃具有不成比例开销的追踪。 |
| `r.Lumen.ScreenProbeGather.ScreenTraces.ThicknessScaleWhenNoFallback` | `2` | 当没有距离场来恢复被遮挡光线时，比例较大可以有效地将深度缓冲区表面视为对屏幕追踪而言更厚。 |
| `r.Lumen.ScreenProbeGather.ShortRangeAO` | `1` | 是否计算短距离、全分辨率环境光遮蔽来添加屏幕探头由于下采样而缺少的高频遮挡（接触阴影）。 |
| `r.Lumen.ScreenProbeGather.ShortRangeAO.ApplyDuringIntegration` | `0` | 是否应在BRDF集成期间应用屏幕空间弯曲法线，其质量更高但在时间滤波器之前，因此会导致移动对象上出现条纹。 |
| `r.Lumen.ScreenProbeGather.ShortRangeAO.HairScreenTrace` | `0` | 是否根据毛发深度进行追踪，以便将毛发阴影投射到不透明对象上。 |
| `r.Lumen.ScreenProbeGather.ShortRangeAO.HairVoxelTrace` | `1` | 是否根据毛发体素结构进行追踪，以便将毛发阴影投射到不透明对象上。 |
| `r.Lumen.ScreenProbeGather.ShortRangeAO.HardwareRayTracing` | `0` | 0. 全分辨率弯曲法线（定向遮挡）的屏幕空间追踪。1. 启用全分辨率弯曲法线（定向遮挡）的硬件光线追踪。（默认值） |
| `r.Lumen.ScreenProbeGather.ShortRangeAO.HardwareRayTracing.NormalBias` | `0.1` | HWRT弯曲法线偏置以避免自相交 |
| `r.Lumen.ScreenProbeGather.ShortRangeAO.MaxMultibounceAlbedo` | `0.5` | 用于环境光遮蔽多次反弹近似的最大反射率。 用于强制近白色反射率以产生一些遮挡。 |
| `r.Lumen.ScreenProbeGather.ShortRangeAO.ScreenSpace.FoliageOcclusionStrength` | `0.7` | 植被和次表面像素上ScreenSpaceBentNormal遮挡的最大强度。 有助于减少最大遮挡以模拟次表面散射。 |
| `r.Lumen.ScreenProbeGather.ShortRangeAO.ScreenSpace.SlopeCompareToleranceScale` | `0.5` | 缩放屏幕空间追踪用来确定是否有命中的斜率阈值。 |
| `r.Lumen.ScreenProbeGather.SpatialFilterHalfKernelSize` | `1` | 试验性 |
| `r.Lumen.ScreenProbeGather.SpatialFilterMaxRadianceHitAngle` | `10` | 以度为单位。 角度越大，过滤效果越好，但会失去接触阴影。 |
| `r.Lumen.ScreenProbeGather.SpatialFilterNumPasses` | `3` | 空间滤波器通道数 |
| `r.Lumen.ScreenProbeGather.SpatialFilterPositionWeightScale` | `1000` | 确定探头在世界空间中可以到达多远，同时仍然滤光 |
| `r.Lumen.ScreenProbeGather.SpatialFilterProbes` | `1` | 是否在空间上过滤探头追踪以降低噪点。 |
| `r.Lumen.ScreenProbeGather.StochasticInterpolation` | `0` | 在何处随机（1个样本）或双线性（4个样本）内插屏幕探头 |
| `r.Lumen.ScreenProbeGather.Temporal` | `1` | 是否使用时间滤波器 |
| `r.Lumen.ScreenProbeGather.Temporal.ClearHistoryEveryFrame` | `0` | 是否每帧清除历史记录以便调试 |
| `r.Lumen.ScreenProbeGather.Temporal.DebugForceTracesMoving` | `0` |  |
| `r.Lumen.ScreenProbeGather.Temporal.DistanceThreshold` | `0.005` | 丢弃最后一帧的光照结果所需的相对距离阈值。 值越低，靠近墙壁时角色的重影越少，但闪烁瑕疵会越多。 |
| `r.Lumen.ScreenProbeGather.Temporal.FastUpdateModeUseNeighborhoodClamp` | `0` | 是否将历史记录值限制在当前帧的屏幕空间邻域中，即移动对象周围的区域。 |
| `r.Lumen.ScreenProbeGather.Temporal.FractionOfLightingMovingForFastUpdateMode` | `0.1` |  |
| `r.Lumen.ScreenProbeGather.Temporal.MaxFastUpdateModeAmount` | `0.9` | 当追踪击中移动对象时，使用的快速响应时间滤波器的最大数量。 值越接近1，噪点越多，但对场景变化的反应也越快。 |
| `r.Lumen.ScreenProbeGather.Temporal.MaxFramesAccumulated` | `10` | 值较低时会导致时间滤波器更快地传播光照变化，但也会增加噪点引起的闪烁。 |
| `r.Lumen.ScreenProbeGather.Temporal.MaxRayDirections` | `8` | 可能的逐像素随机方向数量。应根据MaxFramesAccumulated进行调整。 |
| `r.Lumen.ScreenProbeGather.Temporal.NormalThreshold` | `45` | 历史纹素法线与当前像素之间可接受历史光照的最大角度，以度为单位。 |
| `r.Lumen.ScreenProbeGather.Temporal.RejectBasedOnNormal` | `0` | 是否根据法线拒绝历史光照。 会增加时间滤波器的开销，但可以减少条纹，尤其是在角色脚部周围。 |
| `r.Lumen.ScreenProbeGather.Temporal.RelativeSpeedDifferenceToConsiderLightingMoving` | `0.005` |  |
| `r.Lumen.ScreenProbeGather.TemporalFilterProbes` | `0` | 是否在时间上过滤探头追踪以降低噪点。 |
| `r.Lumen.ScreenProbeGather.TemporalFilterProbes.HistoryDistanceThreshold` | `30` |  |
| `r.Lumen.ScreenProbeGather.TemporalFilterProbes.HistoryWeight` | `0.5` |  |
| `r.Lumen.ScreenProbeGather.TileDebugMode` | `0` | 显示Lumen屏幕探头图块分类。 |
| `r.Lumen.ScreenProbeGather.TraceMeshSDFs` | `1` | 是否针对Lumen的屏幕探头采集器根据网格体有向距离场进行追踪。 |
| `r.Lumen.ScreenProbeGather.TracingOctahedronResolution` | `8` | 追踪八面体的分辨率。 确定每个探头完成的追踪数。 |
| `r.Lumen.ScreenProbeGather.TwoSidedFoliageBackfaceDiffuse` | `1` | 是否沿双面植被着色模型的背面采集光照，这会增加一些GPU开销。 然后，最终光照为DiffuseColor x FrontfaceLighting + SubsurfaceColor x BackfaceLighting。 禁用后，SubsurfaceColor将简单地被添加到DiffuseColor。 |
| `r.Lumen.ScreenProbeGather.VisualizeTraces` | `0` | 是否可视化屏幕中央探头的追踪，这对调试很有用 |
| `r.Lumen.ScreenProbeGather.VisualizeTracesFreeze` | `0` | 是否冻结更新可视化追踪数据。 请注意，在解冻之前，控制台变量或着色器的任何更改都不会传播。 |
| `r.Lumen.SkylightLeaking.Roughness` | `0.3` | 用于对天空光照泄漏立方体贴图进行取样的粗糙度。 值为0时，不会对天空光照泄漏进行预过滤，而值更大时，则可用于隐藏泄漏中的天空特征。 |
| `r.Lumen.StereoOptimizations` | `1` | 是否在实例化的立体渲染期间在视图之间共享某些Lumen状态。 |
| `r.Lumen.Supported` | `1` | 无论平台如何，该项目是否支持Lumen。 此变量可以用来避免编译着色器和其他加载时间开销。 |
| `r.Lumen.SurfaceCache.HeightfieldCaptureMargin` | `100` | 出于发片捕获目的，扩大高度场组件bbox的量。 |
| `r.Lumen.ThreadGroupSize32` | `1` | 是否优先在支持它的硬件上以32线程组进行调度（而不是标准的64线程）。 |
| `r.Lumen.TraceDistanceScale` | `1` | 缩放所有追踪方法和Lumen功能的追踪距离，供可伸缩性使用。 |
| `r.Lumen.TraceMeshSDFs` | `0` | Lumen是否应该根据网格体有向距离场进行追踪。 启用后，Lumen的软件追踪将更加准确，但实例密度高（重叠网格）的场景将具有较高的追踪开销。 禁用后，将改用较低分辨率的全局有向距离场。 |
| `r.Lumen.TraceMeshSDFs.Allow` | `1` | Lumen是否应该根据网格体有向距离场进行追踪。 启用后，Lumen的软件追踪将更加准确，但实例密度高（重叠网格）的场景将具有较高的追踪开销。 禁用后，将改用较低分辨率的全局有向距离场。 |
| `r.Lumen.TraceMeshSDFs.TraceDistance` | `180` | 针对网格体距离场和高度场的最大追踪距离。 |
| `r.Lumen.TranslucencyReflections.ClipmapFadeSize` | `4` | 裁剪图之间的抖动过渡区域的辐射率缓存探头大小 |
| `r.Lumen.TranslucencyReflections.FrontLayer.Allow` | `1` | 是否在半透明表面的最前层渲染Lumen反射。 其他层将使用只能生成光滑反射的较低质量的辐射率缓存方法。 |
| `r.Lumen.TranslucencyReflections.FrontLayer.DepthThreshold` | `1024` | 深度测试阈值用于确定正在渲染的片段是否与计算反射的单层匹配。以浮点ULP单位表示。 |
| `r.Lumen.TranslucencyReflections.FrontLayer.Enable` | `0` | 是否在半透明表面的最前层渲染Lumen反射。 其他层将使用只能生成光滑反射的较低质量的辐射率缓存方法。 |
| `r.Lumen.TranslucencyReflections.FrontLayer.EnableForProject` | `0` | 是否在半透明表面的最前层渲染Lumen反射。 其他层将使用只能生成光滑反射的较低质量的辐射率缓存方法。 |
| `r.Lumen.TranslucencyReflections.MarkDownsampleFactor` | `4` | 用于在Lumen辐射率缓存中标记半透明表面的下采样因子。 因子太低将导致辐射率缓存覆盖不正确。 应是2的幂。 |
| `r.Lumen.TranslucencyReflections.RadianceCache` | `1` | 是否使用辐射率缓存在半透明表面上提供Lumen反射。 |
| `r.Lumen.TranslucencyReflections.ReprojectionRadiusScale` | `10` | 值越大，辐射率缓存光照的距离越远。 |
| `r.Lumen.TranslucencyVolume.Enable` | `1` |  |
| `r.Lumen.TranslucencyVolume.EndDistanceFromCamera` | `8000` |  |
| `r.Lumen.TranslucencyVolume.GridCenterOffsetFromDepthBuffer` | `0.5` | 以网格单位偏移，将网格中心样本沿Z方向移出深度缓冲区。-1表示禁用。这会减少追踪全局距离场缓冲区时样本与几何体的相交，从而减少这些区域的闪烁，并且有时会减少泄漏。 |
| `r.Lumen.TranslucencyVolume.GridDistributionLogZOffset` | `1` |  |
| `r.Lumen.TranslucencyVolume.GridDistributionLogZScale` | `0.01` |  |
| `r.Lumen.TranslucencyVolume.GridDistributionZScale` | `4` |  |
| `r.Lumen.TranslucencyVolume.GridPixelSize` | `32` | 半透明网格中单元格的大小，以像素为单位。 |
| `r.Lumen.TranslucencyVolume.HardwareRayTracing` | `1` | 为Lumen半透明度体积启用硬件光线追踪（默认值=1） |
| `r.Lumen.TranslucencyVolume.MaxRayIntensity` | `20` | 。 |
| `r.Lumen.TranslucencyVolume.OffsetThresholdToAcceptDepthBufferOffset` | `1` | 网格单位偏移，用于接受在深度缓冲区前面向前移动的样本。这是为了避免将深度缓冲区后面的所有样本向前移动，因为这会影响网格体边缘的半透明和体积的光照。 |
| `r.Lumen.TranslucencyVolume.RadianceCache` | `1` | 是否将辐射率缓存用于半透明度 |
| `r.Lumen.TranslucencyVolume.RadianceCache.ClipmapDistributionBase` | `2` | Pow()的基类可控制每个连续裁剪图相对于第一个的大小。 |
| `r.Lumen.TranslucencyVolume.RadianceCache.ClipmapWorldExtent` | `2500` | 第一个裁剪图的世界空间范围 |
| `r.Lumen.TranslucencyVolume.RadianceCache.FarField` | `0` | 是否根据FarField呈现进行追踪 |
| `r.Lumen.TranslucencyVolume.RadianceCache.GridResolution` | `24` | 每个裁剪图中探头放置网格的分辨率 |
| `r.Lumen.TranslucencyVolume.RadianceCache.NumMipmaps` | `3` | 辐射率缓存mipmap的数量。 |
| `r.Lumen.TranslucencyVolume.RadianceCache.NumProbesToTraceBudget` | `200` |  |
| `r.Lumen.TranslucencyVolume.RadianceCache.ProbeAtlasResolutionInProbes` | `128` | 一维探头图集缓存纹理的探头数量。 此变量可以控制缓存的内存使用情况。 当前溢出会导致渲染不正确。 |
| `r.Lumen.TranslucencyVolume.RadianceCache.ProbeResolution` | `8` | 探头二维辐射布局的分辨率。 探头追踪的光线数量为ProbeResolution ^ 2 |
| `r.Lumen.TranslucencyVolume.RadianceCache.ReprojectionRadiusScale` | `10` |  |
| `r.Lumen.TranslucencyVolume.RadianceCache.Stats` | `0` | GPU打印出辐射率缓存更新统计数据。 |
| `r.Lumen.TranslucencyVolume.RadianceCache.Visualize` | `0` |  |
| `r.Lumen.TranslucencyVolume.SpatialFilter` | `1` | 是否在体积追踪上使用空间滤波器。 |
| `r.Lumen.TranslucencyVolume.SpatialFilter.NumPasses` | `2` | 空间滤波器要执行的通道数 |
| `r.Lumen.TranslucencyVolume.Temporal.HistoryWeight` | `0.9` | 每帧的历史值应加权多少。 这是可见抖动和响应性之间的权衡。 |
| `r.Lumen.TranslucencyVolume.Temporal.Jitter` | `1` | 是否对每帧的半透明度全局光照计算应用抖动，实现时间超级采样。 |
| `r.Lumen.TranslucencyVolume.TemporalReprojection` | `1` | 是否使用时间重投影。 |
| `r.Lumen.TranslucencyVolume.TraceFromVolume` | `1` | 是否从半透明度体积的体素进行光线追踪以采集间接光照。 仅当启用了TranslucencyVolume.RadianceCache时禁用才有意义。 |
| `r.Lumen.TranslucencyVolume.TraceStepFactor` | `2` | 。 |
| `r.Lumen.TranslucencyVolume.TracingOctahedronResolution` | `3` | 追踪八面体的分辨率。 确定半透明度光照体积的每个体素完成多少次追踪。 |
| `r.Lumen.TranslucencyVolume.VoxelTraceStartDistanceScale` | `1` | 。 |
| `r.Lumen.UsesLightFunctionAtlas` | `1` | 是否针对Lumen场景光照对光源函数图集进行取样。 |
| `r.Lumen.Visualize` | `0` | Lumen场景可视化模式。 0 - 禁用 1 - 概览 2 - 性能概览 3 - Lumen场景 4 - 反射视图 5 - 表面缓存覆盖率 6 - 几何体法线 7 - 专用反射光线 8 - 反射率 9 - 法线 10 - 自发光 11 - 不透明度（禁用alpha遮罩） 12 - 发片权重 13 - 直接光照 14 - 间接光照 15 - 本地位置（仅限硬件光线追踪） 16 - 速度（仅限硬件光线追踪） 17 - 直接光照更新 18 - 间接光照更新 19 - 上次使用的页面 20 - 上次使用的高分辨率页面 |
| `r.Lumen.Visualize.CardGenerationCluster` | `0` |  |
| `r.Lumen.Visualize.CardGenerationClusterScale` | `1` |  |
| `r.Lumen.Visualize.CardGenerationMaxSurfel` | `-1` |  |
| `r.Lumen.Visualize.CardGenerationSurfels` | `0` |  |
| `r.Lumen.Visualize.CardGenerationSurfelScale` | `1` |  |
| `r.Lumen.Visualize.CardInterpolateInfluenceRadius` | `10` |  |
| `r.Lumen.Visualize.CardPlacement` | `0` |  |
| `r.Lumen.Visualize.CardPlacementDirection` | `-1` | 仅可视化单个发片方向。 |
| `r.Lumen.Visualize.CardPlacementDistance` | `5000` |  |
| `r.Lumen.Visualize.CardPlacementIndex` | `-1` | 每个网格体仅可视化单一发片。 |
| `r.Lumen.Visualize.CardPlacementLOD` | `0` | 0 - 全部 1 - 仅限图元 2 - 仅限合并实例 3 - 仅限合并组件 4 - 仅限远场 |
| `r.Lumen.Visualize.CardPlacementPrimitives` | `0` | 是否可视化图元边界框。 |
| `r.Lumen.Visualize.ConeAngle` | `0` | 可视化椎体角度，以度为单位。 |
| `r.Lumen.Visualize.ConeStepFactor` | `2` | 基于球体半径步长大小的椎体步长比例。 |
| `r.Lumen.Visualize.GridPixelSize` | `32` |  |
| `r.Lumen.Visualize.HardwareRayTracing` | `1` | 启用硬件光线追踪的可视化（默认值=1） |
| `r.Lumen.Visualize.HardwareRayTracing.BucketMaterials` | `1` | 确定是否将次要追踪分桶以便进行一致的材质访问（默认值=1） |
| `r.Lumen.Visualize.HardwareRayTracing.Compact` | `1` | 确定在遍历之前是否压缩第二次追踪（默认值=1） |
| `r.Lumen.Visualize.HardwareRayTracing.DeferredMaterial` | `1` | 启用延迟材质管线（默认值=1） |
| `r.Lumen.Visualize.HardwareRayTracing.DeferredMaterial.TileDimension` | `64` | 确定材质分类的图块尺寸（默认值=64） |
| `r.Lumen.Visualize.HardwareRayTracing.GroupCount` | `4096` | 确定调度光线生成着色器时的活动组数（默认值=4096） |
| `r.Lumen.Visualize.HardwareRayTracing.Retrace.FarField` | `1` | 确定是否为远场贡献触发第二次追踪（默认值=1） |
| `r.Lumen.Visualize.HardwareRayTracing.Retrace.HitLighting` | `0` | 确定是否针对无效的表面缓存命中触发第二次命中光照追踪（默认值=1） |
| `r.Lumen.Visualize.HardwareRayTracing.ThreadCount` | `64` | 确定调度光线生成着色器时的活动组数（默认值=64） |
| `r.Lumen.Visualize.HiResSurface` | `1` | 可视化是否应该对最高可用表面数据进行取样或使用最低分辨率始终驻留页面。 |
| `r.Lumen.Visualize.IndirectDiffuse` | `0` | 可视化Lumen间接漫反射。 |
| `r.Lumen.Visualize.MaxMeshSDFTraceDistance` | `-1` | Lumen场景可视化光线的最大追踪距离。值低于0时，将自动根据椎体角度推导出此值。 |
| `r.Lumen.Visualize.MaxTraceDistance` | `100000` |  |
| `r.Lumen.Visualize.MinTraceDistance` | `0` |  |
| `r.Lumen.Visualize.RayTracingGroups` | `0` | 可视化光线追踪组的边界。使用r.Lumen.Visualize.CardPlacementDistance控制可视化距离。 0 - 禁用 1 - 所有组 2 - 具有单个实例的组 |
| `r.Lumen.Visualize.SurfaceCacheFeedback` | `1` | 可视化是否应该将表面缓存反馈请求写入反馈缓冲区。 |
| `r.Lumen.Visualize.TraceMeshSDFs` | `1` | 是否将网格体SDF追踪用于Lumen场景可视化。 |
| `r.Lumen.Visualize.TraceRadianceCache` | `0` | 是否将辐射率缓存用于Lumen场景可视化。 |
| `r.Lumen.Visualize.UseShaderPrintForTraces` | `1` | 是否将ShaderPrint或自定义线渲染器用于追踪可视化。 |
| `r.Lumen.Visualize.ViewMode` |  | 当视口视图模式设置为‘Lumen可视化’时，此命令指定显示其中哪个通道。除下面所示允许值之外的输入值将被忽略。 Overview PerformanceOverview LumenScene GeometryNormals ReflectionView SurfaceCache DedicatedReflectionRays |
| `r.LumenScene.DirectLighting` | `1` | 是否计算表面缓存的直接光照。 |
| `r.LumenScene.DirectLighting.BatchShadows` | `1` | 是否启用批处理Lumen光源阴影通道。此控制台变量主要用于调试。 |
| `r.LumenScene.DirectLighting.CloudTransmittance` | `1` | 是否在可用时对云阴影取样。 |
| `r.LumenScene.DirectLighting.GlobalSDF.ShadowRayBias` | `1` | 用于追踪全局SDF阴影光线的偏差。 |
| `r.LumenScene.DirectLighting.HardwareRayTracing` | `1` | 为Lumen直接光照启用硬件光线追踪（默认值=1） |
| `r.LumenScene.DirectLighting.HardwareRayTracing.HeightfieldProjectionBias` | `0` | 应用投影偏差，使得遮挡光线从光线追踪高度场表示开始。 |
| `r.LumenScene.DirectLighting.HardwareRayTracing.HeightfieldProjectionBiasSearchRadius` | `256` | 确定高度场投影偏差的搜索半径。搜索半径越大，遍历开销越高（默认值=256）。 |
| `r.LumenScene.DirectLighting.HardwareRayTracing.ShadowRayBias` | `1` | 用于硬件光线追踪阴影光线的偏差。 |
| `r.LumenScene.DirectLighting.Heightfield.ShadowRayBias` | `2` | 用于追踪高度场阴影光线的偏差。 |
| `r.LumenScene.DirectLighting.MaxLightsPerTile` | `8` | 每个图块基于强度和衰减选择的最大光源数量。有效值为4/8/16/32。增加此值将导致更多的内存占用，并使Lumen表面缓存直接光照通道放缓速度。 |
| `r.LumenScene.DirectLighting.MeshSDF.ShadowRayBias` | `2` | 用于追踪网格体SDF阴影光线的偏差。 |
| `r.LumenScene.DirectLighting.OffscreenShadowing.TraceMeshSDFs` | `1` | 是否就屏幕外阴影根据网格体有向距离场进行追踪，或者根据较低分辨率的全局SDF进行追踪。 |
| `r.LumenScene.DirectLighting.OffscreenShadowingTraceStepFactor` | `5` |  |
| `r.LumenScene.DirectLighting.UpdateFactor` | `32` | 控制每帧更新多少纹素直接光照。纹素=SurfaceCacheTexels/因子。 |
| `r.LumenScene.DumpStats` | `0` | 是否在下一帧记录Lumen场景统计数据。2 - 转储网格体DF。3 - 转储LumenScene对象。 |
| `r.LumenScene.FarField` | `0` | 启用/禁用Lumen远场光线追踪。 |
| `r.LumenScene.FarField.FarFieldDitherScale` | `200` | 以世界空间单位表示的近场和远场之间的抖动区域。 |
| `r.LumenScene.FarField.MaxTraceDistance` | `1e+06` | Lumen远场光线追踪的最大命中距离（默认值=1.0e6）。 |
| `r.LumenScene.FarField.ReferencePos.Z` | `100000` | Z轴上的远场参考位置（默认值=100000.0） |
| `r.LumenScene.FastCameraMode` | `0` | 是否为快速摄像机移动更新Lumen场景 - 质量降低，更新速度加快，以便光照可以跟上摄像机的步伐。 |
| `r.LumenScene.GlobalSDF.ClipmapExtent` | `2500` | 启用Lumen时的全局距离场第一个裁剪图范围。 |
| `r.LumenScene.GlobalSDF.CoveredExpandSurfaceScale` | `1` | 缩放全局SDF使用的半体素SDF扩展，以重构比两个体素之间的距离更薄的表面，避免过度遮挡。 |
| `r.LumenScene.GlobalSDF.DitheredTransparencyStepThreshold` | `0.5` | 逐步长随机半透明度阈值，用于追踪启用了抖动透明度的用户，针对仅包含双面网格体SDF的空间区域。 |
| `r.LumenScene.GlobalSDF.DitheredTransparencyTraceThreshold` | `0.9` | 逐追踪随机半透明度阈值，用于追踪启用了抖动透明度的用户，针对仅包含双面网格体SDF的空间区域。 任何小于1的值都会引起泄漏。 |
| `r.LumenScene.GlobalSDF.NotCoveredExpandSurfaceScale` | `0.6` | 缩放全局SDF使用的半体素SDF扩展，以重构比两体素之间的距离更薄的表面，针对仅包含双面网格体SDF的空间区域。 |
| `r.LumenScene.GlobalSDF.NotCoveredMinStepScale` | `4` | 缩放最小步长大小以提高性能，针对仅包含双面网格体SDF的空间区域。 |
| `r.LumenScene.GlobalSDF.Resolution` | `252` | 启用Lumen时的全局距离场分辨率。 |
| `r.LumenScene.GlobalSDF.SimpleCoverageBasedExpand` | `0` | 是否使用基于简单覆盖的表面扩展。精度更低，但不会对覆盖纹理进行取样。 |
| `r.LumenScene.GPUDrivenUpdate` | `0` | 是否使用GPU更新Lumen场景。发开中。 |
| `r.LumenScene.Heightfield.CullForView` | `1` | 启用高度场剔除（默认值=1） |
| `r.LumenScene.Heightfield.FroxelCulling` | `1` | 启用高度场视锥体素视图剔除（默认值=1） |
| `r.LumenScene.Heightfield.MaxTracingSteps` | `32` | 设置高度场（地形）软件光线追踪的最大步长数（默认值=32） |
| `r.LumenScene.Heightfield.ReceiverBias` | `0.01` | 地形表面点的额外偏差。有助于修复表面缓存和地形CLOD中固定LOD之间不匹配的LOD瑕疵。 |
| `r.LumenScene.Heightfield.Tracing` | `1` | 启用高度场（地形）软件光线追踪（默认值=1） |
| `r.LumenScene.Lighting.AsyncCompute` | `1` | 是否在计算管道上运行LumenSceneLighting（如果可以）。 |
| `r.LumenScene.Lighting.Feedback` | `1` | 是否根据反馈优先处理表面缓存光照更新。 |
| `r.LumenScene.Lighting.ForceLightingUpdate` | `0` | 强制每帧更新全Lumen场景光照。适用于调试 |
| `r.LumenScene.Lighting.Stats` | `0` | GPU打印出Lumen光照更新统计数据。 |
| `r.LumenScene.MeshCardsPerTask` | `128` | 每个表面缓存更新任务需要处理多少网格体发片。 |
| `r.LumenScene.ParallelUpdate` | `1` | 是否并行运行Lumen场景更新。 |
| `r.LumenScene.PrimitivesPerTask` | `128` | 每个表面缓存更新任务需要处理多少图元。 |
| `r.LumenScene.PropagateGlobalLightingChange` | `1` | 是否检测大型场景光照变化并加速这些帧的Lumen更新。 |
| `r.LumenScene.Radiosity` | `1` | 是否启用辐射度（Radiosity），辐射度是从表面缓存采集的间接光照，可提供多次反射漫反射。 |
| `r.LumenScene.Radiosity.DistanceFieldSurfaceBias` | `10` | 。 |
| `r.LumenScene.Radiosity.DistanceFieldSurfaceSlopeBias` | `10` | 。 |
| `r.LumenScene.Radiosity.HardwareRayTracing` | `1` | 针对辐射度启用硬件光线追踪（默认值=1）。 |
| `r.LumenScene.Radiosity.HardwareRayTracing.SlopeSurfaceBias` | `0.2` | 。 |
| `r.LumenScene.Radiosity.HardwareRayTracing.SurfaceBias` | `0.1` | 。 |
| `r.LumenScene.Radiosity.HemisphereProbeResolution` | `4` | 一维半球体探头布局的追踪数量。 |
| `r.LumenScene.Radiosity.MaxRayIntensity` | `40` | 相对于当前视图曝光限制辐射度追踪强度。 有助于减少来自小型明亮自发光源的瑕疵，但会损失能量并增加视图依赖性。 |
| `r.LumenScene.Radiosity.ProbeOcclusion` | `1` | 在插值和过滤期间是否根据探头命中深度进行深度测试以减少泄漏。 由于不精确，无法用于软件光线追踪。 |
| `r.LumenScene.Radiosity.ProbeOcclusionStrength` | `0.5` | 探头遮挡的强度。 0=无探头遮挡，1=尝试阻止所有泄漏，但有自遮挡瑕疵，0.5（默认）=极端情况之间的权衡。 |
| `r.LumenScene.Radiosity.ProbePlaneWeighting` | `1` | 是否按平面距离对辐射度探头进行加权，有助于防止泄漏。 |
| `r.LumenScene.Radiosity.ProbeSpacing` | `4` | 探头之间的距离，以表面缓存纹理像素为单位 |
| `r.LumenScene.Radiosity.SpatialFilterProbes` | `1` | 是否在空间上滤波辐射度探头。 过滤会降低噪点，但会增加泄漏。 |
| `r.LumenScene.Radiosity.SpatialFilterProbes.KernelSize` | `1` | 较大的核可减少噪点，但会增加泄漏。 |
| `r.LumenScene.Radiosity.SpatialFilterProbes.PlaneWeightingDepthScale` | `-100` | 控制探头可以内插的距离。 值过高会引起泄漏。 |
| `r.LumenScene.Radiosity.Temporal` | `1` | 是否对辐射度使用时间超级采样。 可提高质量，但也会增加光照变化传播速度的延迟，以及在结果中出现动画噪点。 |
| `r.LumenScene.Radiosity.Temporal.FixedJitterIndex` | `-1` | 如果值为零或更大，则用固定索引重载时间抖动索引。 适用于调试和检查取样模式。 |
| `r.LumenScene.Radiosity.Temporal.MaxFramesAccumulated` | `4` | 值较低时会导致时间滤波器更快地传播光照变化，但也会增加噪点引起的闪烁。 |
| `r.LumenScene.Radiosity.UpdateFactor` | `64` | 控制每帧更新多少个纹素辐射度。纹素=SurfaceCacheTexels/因子。 |
| `r.LumenScene.Radiosity.VisualizeProbeRadius` | `10` | 可视化辐射度探头的半径。 |
| `r.LumenScene.Radiosity.VisualizeProbes` | `0` | 是否可视化辐射度探头。 |
| `r.LumenScene.Stats` | `0` | 显示各种Lumen GPU场景统计数据以供调试。 |
| `r.LumenScene.SurfaceCache.AtlasSize` | `4096` | 表面缓存发片图集大小。 |
| `r.LumenScene.SurfaceCache.CardCaptureEnableInvalidation` | `1` | 是否通过InvalidateSurfaceCacheForPrimitive()启用手动发片重新捕获。 |
| `r.LumenScene.SurfaceCache.CardCaptureFactor` | `64` | 控制每帧可捕获多少个纹素。纹素=SurfaceCacheTexels/因子。 |
| `r.LumenScene.SurfaceCache.CardCaptureMargin` | `0` | 从Lumen场景范围多远开始捕获发片。 |
| `r.LumenScene.SurfaceCache.CardCaptureRefreshFraction` | `0.125` | 允许花费发片捕获预算的一部分来重新捕获现有页面，以刷新表面缓存材质。 0禁用发片刷新。 |
| `r.LumenScene.SurfaceCache.CardCapturesPerFrame` | `300` |  |
| `r.LumenScene.SurfaceCache.CardFixedDebugResolution` | `-1` | Lumen发片分辨率 |
| `r.LumenScene.SurfaceCache.CardMaxResolution` | `512` | Lumen场景中的最大发片分辨率 |
| `r.LumenScene.SurfaceCache.CardMaxTexelDensity` | `0.2` | 每世界空间距离的Lumen发片纹素 |
| `r.LumenScene.SurfaceCache.CardMinResolution` | `4` | Lumen场景中可见的最小网格体发片尺寸分辨率 |
| `r.LumenScene.SurfaceCache.CardTexelDensityScale` | `100` | 每世界空间距离的Lumen发片纹素 |
| `r.LumenScene.SurfaceCache.Compress` | `1` | 是否对表面缓存使用运行时压缩。 0 - 禁用 1 - 使用UAV锯齿进行压缩（如果支持） 2 - 使用CopyTexture进行压缩（在某些RHI上可能非常慢） |
| `r.LumenScene.SurfaceCache.FarField.CardDistance` | `40000` | 远场Lumen发片剔除距离 |
| `r.LumenScene.SurfaceCache.FarField.CardTexelDensity` | `0.001` | 每世界空间单位的远场Lumen发片纹素 |
| `r.LumenScene.SurfaceCache.Feedback` | `1` | 是否使用表面缓存反馈来选择性地映射更高质量的表面缓存页面。 |
| `r.LumenScene.SurfaceCache.Feedback.MinPageHits` | `16` | 需要新页面的最小页面点击数。 |
| `r.LumenScene.SurfaceCache.Feedback.ResLevelBias` | `-0.5` | 按需表面缓存页面的偏差分辨率。 |
| `r.LumenScene.SurfaceCache.Feedback.TileSize` | `16` | 将逐图块写出一个表面缓存反馈元素。对齐到2的幂。 |
| `r.LumenScene.SurfaceCache.Feedback.UniqueElements` | `1024` | 唯一表面缓存反馈元素的限制。用于调整缓冲区大小。 |
| `r.LumenScene.SurfaceCache.ForceEvictHiResPages` | `0` | 逐出所有可选的高分辨率表面缓存页面。 |
| `r.LumenScene.SurfaceCache.Freeze` | `0` | 冻结表面缓存更新以进行调试。 |
| `r.LumenScene.SurfaceCache.FreezeUpdateFrame` | `0` | 持续更新表面缓存的相同子集以进行调试和分析。 |
| `r.LumenScene.SurfaceCache.LogUpdates` | `0` | 是否记录Lumen表面缓存更新。 2 - 将记录网格体名称。 |
| `r.LumenScene.SurfaceCache.MeshCardsCullFaces` | `1` |  |
| `r.LumenScene.SurfaceCache.MeshCardsDebugSingleCard` | `-1` | 在网格体上仅生成指定发片。适合用于调试。 |
| `r.LumenScene.SurfaceCache.MeshCardsMergeComponents` | `1` | 是否将具有相同RayTracingGroupId的所有组件合并到单个MeshCards中。 |
| `r.LumenScene.SurfaceCache.MeshCardsMergedCardMinSurfaceArea` | `0.05` | 生成合并发片的最小区域。 |
| `r.LumenScene.SurfaceCache.MeshCardsMergedMaxWorldSize` | `10000` | 由于Lumen场景流送依赖于对象粒度，因此仅考虑任何轴上小于此尺寸的合并边界。 |
| `r.LumenScene.SurfaceCache.MeshCardsMergedResolutionScale` | `0.3` | 合并MeshCards的分辨率计算比例。 此变量可以补偿由于靠近观看者而分配到更高分辨率的合并盒体。 |
| `r.LumenScene.SurfaceCache.MeshCardsMergeInstances` | `0` | 是否将实例化静态网格体组件的所有实例合并到单个MeshCards中。 |
| `r.LumenScene.SurfaceCache.MeshCardsMergeInstancesMaxSurfaceAreaRatio` | `1.7` | 仅当（组合盒体表面面积）/（总实例盒体表面面积） |
| `r.LumenScene.SurfaceCache.MeshCardsMinSize` | `10` | Lumen场景中包含的最小网格体发片世界空间大小。 |
| `r.LumenScene.SurfaceCache.MeshTargetScreenSize` | `0.15` | 控制使用哪个LOD级别将静态网格体捕获到表面缓存中。 |
| `r.LumenScene.SurfaceCache.NaniteLODScaleFactor` | `1` | 控制使用哪个LOD级别将Nanite网格体捕获到表面缓存中。 |
| `r.LumenScene.SurfaceCache.NaniteMultiView` | `1` | 切换多视图Lumen Nanite发片捕获以进行调试。 |
| `r.LumenScene.SurfaceCache.NumFramesToKeepUnusedPages` | `256` | 在表面缓存中保留未使用页面的帧数。 |
| `r.LumenScene.SurfaceCache.RecaptureEveryFrame` | `0` |  |
| `r.LumenScene.SurfaceCache.RemovesPerFrame` | `512` | 每帧可以移除多少网格体发片。 |
| `r.LumenScene.SurfaceCache.ResampleLighting` | `1` | 重新分配发片时是否对发片光照重新取样。 这对于辐射度时间累积是必需的，但可以为了调试而禁用。 |
| `r.LumenScene.SurfaceCache.Reset` | `0` | 重置所有图集和捕获发片。 |
| `r.LumenScene.SurfaceCache.ResetEveryNthFrame` | `0` | 每N帧连续重置所有图集和捕获发片。 |
| `r.LumenScene.UpdateViewOrigin` | `1` | 是否更新体素光照和全局距离场的视图原点。适合用于调试。 |
| `r.LumenScene.UploadEveryFrame` | `0` | 是否每帧上传整个Lumen场景的数据。适合用于调试。 |
| `r.LumenScene.VisualizePrimitiveGroups` | `0` | 可视化Lumen GPU场景图元组。 |

### 多个光源

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.ManyLights` | `0` | 是否启用多个光源。试验性功能，利用光线追踪来随机对光源进行重要性采样。 1 - 所有使用光线追踪阴影的光源都将被随机取样 2 - 所有光源都将被随机取样 |
| `r.ManyLights.Debug` | `0` | 是否启用调试模式，打印来自着色器的各种额外调试信息。0 - 禁用 1 - 可视化取样 2 - 可视化追踪 |
| `r.ManyLights.Debug.LightId` | `-1` | 显示哪个光源的调试信息。当设置为-1时，使用编辑器中当前选定的光源。 |
| `r.ManyLights.FixedStateFrameIndex` | `-1` | 是否重载View.StateFrameIndex以进行调试。 |
| `r.ManyLights.HairVoxelTraces` | `1` | 是否追踪毛发体素。 |
| `r.ManyLights.HardwareRayTracing` | `1` | 是否将硬件光线追踪用于阴影光线。 |
| `r.ManyLights.HardwareRayTracing.AvoidSelfIntersections` | `true` | 是否避免自相交。 目前与Lumen共享配置： - r.Lumen.HardwareRayTracing.SkipBackFaceHitDistance - r.Lumen.HardwareRayTracing.SkipTwoSidedHitDistance |
| `r.ManyLights.HardwareRayTracing.Bias` | `1` | 硬件光线追踪阴影光线的常量偏差。 |
| `r.ManyLights.HardwareRayTracing.Inline` | `1` | 将硬件内联光线追踪用于光线追踪光照（如果可用）。 |
| `r.ManyLights.HardwareRayTracing.MaxIterations` | `8192` | 限制受支持平台上光线追踪遍历迭代的次数。可提高性能，但可能会增加过度遮挡。 |
| `r.ManyLights.HardwareRayTracing.NormalBias` | `0.1` | 硬件光线追踪阴影光线的法线偏差。 |
| `r.ManyLights.IESProfiles` | `1` | 是否在光源上支持IES配置文件。 |
| `r.ManyLights.LightFunctions` | `0` | 是否支持光源函数。 |
| `r.ManyLights.MaxShadingTilesPerGridCell` | `32` | 每个网格单元的着色图块数量上限。 |
| `r.ManyLights.NumSamplesPerPixel` | `4` | 半分辨率逐像素样本数（阴影光线）。 1 - 0.25逐像素追踪 2 - 0.5逐像素追踪 4 - 1逐像素追踪 |
| `r.ManyLights.Reset` | `0` | 重置历史记录以进行调试。 |
| `r.ManyLights.ResetEveryNthFrame` | `0` | 每N帧重置一次历史记录以进行调试。 |
| `r.ManyLights.Sampling.MinWeight` | `0.001` | 确定对最终像素的最小样本影响。用于跳过对最终图像影响最小的样本，即使光源完全可见。 |
| `r.ManyLights.ScreenTraces` | `1` | 是否对阴影光线使用屏幕空间追踪。 |
| `r.ManyLights.ScreenTraces.MaxIterations` | `50` | HZB追踪的最大迭代次数。 |
| `r.ManyLights.ScreenTraces.MinimumOccupancy` | `0` | 中止追踪之前仍在追踪的线程数下限。可用于可伸缩性以放弃具有不成比例开销的追踪。 |
| `r.ManyLights.ScreenTraces.RelativeDepthThickness` | `0.005` | 确定HZB追踪命中对象的深度厚度，作为相对深度阈值。 |
| `r.ManyLights.Spatial` | `1` | 降噪器是否应运行空间滤波器。 |
| `r.ManyLights.Spatial.DepthWeightScale` | `10000` | 缩放空间滤波器的深度权重。值越小，允许越多的样本重复使用，但也会在不相关表面之间引入更多模糊。 |
| `r.ManyLights.Temporal` | `1` | 是否对阴影遮罩使用时间累加。 |
| `r.ManyLights.Temporal.MaxFramesAccumulated` | `8` | 累加帧时的最大历史记录长度。值越低，重影越少，但噪点越多。 |
| `r.ManyLights.Temporal.NeighborhoodClampScale` | `2` | 缩放邻域限制的宽容程度。值越高，重影越多，但时间累加越平滑。 |
| `r.ManyLights.TexturedRectLights` | `0` | 是否支持纹理矩形光源。 |
| `r.ManyLights.WaveOps` | `1` | 是否使用Wave Ops。适合用于调试。 |
| `r.ManyLights.WorldSpaceTraces` | `1` | 是否对样本追踪世界空间阴影光线。适合用于调试。 |

### 材质

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.Material.CullIntermediateUniformExpressions` | `true` | 启用中间统一表达式的剔除，减少预着色器数量，节省性能 |
| `r.Material.EnableTranslationLogFile` | `false` | 启用材质转译日志文件生成，以追踪材质转译时间（写入ShaderDebugInfo/MaterialTranslationLog-X.csv”）。” |
| `r.Material.EnergyConservation` | `0` | 对旧材质启用节能（项目设置，只读）。请注意，当启用Substrate时，将强制启用节能。 |
| `r.Material.ExcludeNonPipelinedShaders` | `1` | 如果!=0，则不会编译作为FShaderPipeline一部分的独立着色器（默认）。 |
| `r.Material.ExperimentalMaterialCachedDataAnalysisEnabled` | `false` | 用户基于材质缓存数据试验性图表的分析 |
| `r.Material.PedanticErrorChecksEnabled` | `false` | 启用材质编译严格错误检查 |
| `r.Material.PreshaderGapInterval` | `32` | 在预着色器缓冲区中每隔指定数量的元素插入一个空元素。 着色器编译器寄存器溢出漏洞解决方案。 |
| `r.Material.RoughDiffuse` | `0` | 启用粗糙漫反射材质。 |
| `r.Material.ShaderMapDump` |  | 输出针对给定命名材质（由路径指定）找到的所有着色器贴图的文本转储。 请注意，这将包括由MaterialInstance创建的所述材质的任何实例。 文件（.txt扩展名）将被转储到以DDC密钥哈希命名的Saved\\MaterialShaderMaps。 |
| `r.MaterialEditor.AllowIgnoringCompilationErrors` | `true` | 允许忽略平台着色器和派生材质的编译误差。 |
| `r.MaterialEditor.AnalyticDeriv` | `1` | 启用分析导数代码生成。 |
| `r.MaterialEditor.AnalyticDeriv.DebugEmitInvalidDerivTokens` | `0` | 调试：发出“$”标记来标记具有无效导数的表达式。 |
| `r.MaterialEditor.AnalyticDeriv.DebugGenerateAllFunctions` | `0` | 调试：生成所有导函数。 |
| `r.MaterialEditor.AnalyticDeriv.DebugTextureSample` | `0` | 调试：使用可以通过r.GeneralPurposeTweak/r.GeneralPurposeTweak2控制的模式进行仪器纹理采样。 |
| `r.MaterialEditor.ContextMenu.CategoryWeight` | `4` | 与用户输入内容相匹配的类别所占的权重额 |
| `r.MaterialEditor.ContextMenu.DescriptionWeight` | `4` | 与用户输入内容相匹配的说明所占的权重额 |
| `r.MaterialEditor.ContextMenu.KeywordWeight` | `30` | 在搜索项关键字上放置的权重额 |
| `r.MaterialEditor.ContextMenu.NodeTitleWeight` | `20` | 在搜索项标题上放置的权重额 |
| `r.MaterialEditor.ContextMenu.PercentageMatchWeightMultiplier` | `1` | 一个乘数，用于根据匹配的百分比给予某对象多少权重 |
| `r.MaterialEditor.ContextMenu.ShorterMatchWeight` | `10` | 增大此权重会让较短的词语更受欢迎 |
| `r.MaterialEditor.ContextMenu.StartsWithBonusWeightMultiplier` | `4` | 如果关键字以用户键入的词语开头，则给出乘数 |
| `r.MaterialEditor.ContextMenu.WholeMatchLocalizedWeightMultiplier` | `0.5` | 如果存在与搜索词的精确本地化匹配，则给出乘数 |
| `r.MaterialEditor.ContextMenu.WholeMatchWeightMultiplier` | `0.5` | 如果存在与搜索词的精确匹配，则给出乘数 |
| `r.MaterialEditor.LWCEnabled` | `1` | 在材质中启用LWC值的生成。禁用后，材质将以浮点精度执行所有操作 |
| `r.MaterialEditor.LWCTruncateMode` | `2` | 材质编译器是否遵循截断LWC节点或自动变换。 0：不截断（即使要求截断也始终使用LWC） 1：遵循截断LWC节点 2：遵循截断LWC节点和自动变换 |
| `r.MaterialEditor.MaxDerivedMaterialInstances` | `-1` | 限制平台统计数据中显示的派生材质实例数量。使用负数来禁用限制。如果材质编辑器在运行时发生变化，必须重新打开。 |
| `r.MaterialEditor.PreshaderDumpToHLSL` | `true` | 控制是否将预着色器表达式和参数引用计数附加到HLSL源窗口（作为代码末尾的注释）。 |
| `r.MaterialEditor.UseDevShaders` | `1` | 切换材质编辑器是否使用包含编辑器产生的额外开销的着色器。如果材质编辑器在运行时发生变化，必须重新打开。 |
| `r.MaterialEnableNewHLSLGenerator` | `0` | 启用新的（WIP）材质HLSL生成器。 0 - 不允许 1 - 材质启用时允许 2 - 强制所有材质使用新生成器 |
| `r.MaterialLogErrorOnFailure` | `false` | 启用后，当材质编译失败时，将发出错误而非警告。 默认值：false |
| `r.MaterialParameterLegacyChecks` | `0` | 启用后，根据旧路径对新材质参数逻辑进行健全性检查。 请注意，速度可能会很慢 |
| `r.MaterialQualityLevel` | `1` | 0对应于低质量材质，由材质中的质量开关定义，1对应高质量，2对应中等质量，3对应超高质量。 |
| `r.MaterialsDuplicateVerbatim` | `false` | 启用后，当材质或材质函数被复制时，不会预先更改StateId（影响DDC键）。 默认值：false |

### 网格体

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.MeshCardRepresentation` | `1` |  |
| `r.MeshCardRepresentation.Async` | `1` | 。 |
| `r.MeshCardRepresentation.Debug` | `0` | 启用网格体发片调试。跳过DDC并附加额外的调试数据。 |
| `r.MeshCardRepresentation.Debug.SurfelDirection` | `-1` | 仅为指向特定方向的表面元素生成发片。 |
| `r.MeshCardRepresentation.MinDensity` | `0.2` | 需要多少填充区域才能生成发片，范围是[0;1]。 |
| `r.MeshCardRepresentation.NormalTreshold` | `0.25` | 表面元素将聚集在一起的法线阈值。 |
| `r.MeshCardRepresentation.ParallelBuild` | `1` | 是否使用任务进行网格体发片编译。 |
| `r.MeshDeformerMaxLOD` | `-1` | 不将MeshDeformers应用于高于此LOD的SkinnedMesh。 默认值为-1（禁用）。 |
| `r.MeshDrawCommands.AllowOnDemandShaderCreation` | `1` | 如何创建RHI着色器： 0：在执行其他MDC任务之前，始终在渲染线程上创建着色器。 1：如果RHI支持多线程着色器创建，则在提交绘制时根据需要在任务线程上创建着色器。 |
| `r.MeshDrawCommands.BatchSize` | `12` | 启用多线程绘制命令缓存时，缓存网格体绘制命令的批处理大小 |
| `r.MeshDrawCommands.CacheMultithreaded` | `1` | 启用静态网格体的绘制命令缓存的多线程处理。0=禁用，1=启用（默认） |
| `r.MeshDrawCommands.DynamicInstancing` | `1` | 是否将多个兼容的可见网格体绘制命令动态组合成支持它的顶点工厂上的一个实例化绘制。 |
| `r.MeshDrawCommands.LogDynamicInstancingStats` | `0` | 是否在下一帧记录动态实例化统计数据 |
| `r.MeshDrawCommands.LogMeshDrawCommandMemoryStats` | `0` | 是否在下一帧记录网格体绘制命令内存统计数据 |
| `r.MeshDrawCommands.ParallelPassSetup` | `1` | 是否并行设置网格体绘制命令通道。 |
| `r.MeshDrawCommands.Stats` | `0` | 显示屏幕上的网格体绘制命令统计数据。 可视三角形的统计数据是GPU剔除后的统计数据。 1=显示每通道的统计数据。 2...N=显示与ini文件中的‘Collection’参数匹配的统计数据集合。 你还可以使用'统计剔除'来查看全局剔除统计数据。 |
| `r.MeshDrawCommands.UseCachedCommands` | `1` | 是否从缓存的网格体绘制命令进行渲染（在支持它的顶点工厂上），或每帧生成绘制命令。 |
| `r.MeshMerge.StoreImposterInfoInUVs` | `0` | 确定是否在合并的网格体UV通道中存储替代物信息（UV2中的position.xy、UV3中的position.z + scale） 0：不在UV中存储替代物信息（默认） 1：在UV中存储替代物信息（旧版） |
| `r.MeshParticle.MinDetailModeForMotionBlur` | `-1` | 设置网格体粒子发射动态模糊之前的最小细节模式（低=0，中=1，高=2，最大=3）。设置为-1可完全禁用网格体粒子动态模糊。默认为-1。 |
| `r.MeshReductionModule` | `QuadricMeshReduction` | 要选择的网格体缩减模块的名称。如果为空，则选择任何存在的模块。 |
| `r.MeshStreaming` | `0` | 试验性 - 如果非零，启用网格体流送。 |

### 移动端

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.Mobile.AdrenoOcclusionMode` | `0` | 0：在基础通道之后渲染遮挡查询（默认）。 1：在半透明度和清空之后渲染遮挡查询，这对GL模式下的Adreno设备有帮助。 |
| `r.Mobile.AllowDeferredShadingOpenGL` | `0` | 0：不允许在OpenGL上使用延迟着色（默认） 1：允许在OpenGL上使用延迟着色 |
| `r.Mobile.AllowDistanceFieldShadows` | `1` | 0：不生成着色器Permutation来渲染来自静止定向光源的距离场阴影。 1：生成着色器Permutation来渲染来自静止定向光源的距离场阴影。（默认值） |
| `r.Mobile.AllowDitheredLODTransition` | `0` | 是否在移动平台上支持‘抖动LOD过渡（Dithered LOD Transition）’材质选项 |
| `r.Mobile.AllowMovableDirectionalLights` | `1` | 0：不生成着色器Permutation来渲染可移动定向光源。 1：生成着色器Permutation来渲染可移动定向光源。（默认值） |
| `r.Mobile.AllowPerPixelShadingModels` | `1` | 是否在移动功能级别的材质中允许‘逐像素着色器模型（来自材质表达式）’。 |
| `r.Mobile.AllowPixelDepthOffset` | `1` | 是否对移动功能级别在材质中允许‘像素深度偏移’。像素着色器中的深度修改可能会降低GPU性能 |
| `r.Mobile.AmbientOcclusion` | `0` | 注意：启用移动环境光遮蔽后，移动基础通道像素着色器中将占用一个额外的取样器。 0：在移动平台上禁用环境光遮蔽。[默认] 1：在移动平台上启用环境光遮蔽。 |
| `r.Mobile.AmbientOcclusionDepthBoundsTest` | `1` | 是否在环境光遮蔽通道期间使用深度边界测试剔除远距离像素。此选项仅在使用像素着色器路径时有效 |
| `r.Mobile.AmbientOcclusionQuality` | `1` | 移动平台上屏幕空间环境光遮蔽的质量。 0：禁用。 1：低。（默认） 2：中。 3：高。 |
| `r.Mobile.AmbientOcclusionShaderType` | `2` | 0：ComputeShader。 1：单独的ComputeShader。 2：PixelShader。 |
| `r.Mobile.AmbientOcclusionTechnique` | `0` | 0：GTAO（默认）。 1：SSAO。 |
| `r.Mobile.AntiAliasing` | `1` | 移动端默认AntiAliasingMethod 0：关闭（无抗锯齿） 1：FXAA（默认，比TemporalAA更快，但在非静态情况下更加闪烁）2：TemporalAA（如果禁用SupportsGen4TAA，会回退到FXAA） 3：MSAA |
| `r.Mobile.CustomDepthForTranslucency` | `1` | 是否渲染自定义深度/模板（如果场景中的任何透明度使用自定义深度/模板）。 0=关闭 1=开启[默认] |
| `r.Mobile.DBuffer` | `0` | 使用移动前向渲染器时，启用DBuffer贴花材质混合模式。 Dbuffer贴花在基础通道之前渲染，使得它们能够正确影响静态光照和天空光照。 启用后，将强制执行完整预通道，这会增加CPU/GPU开销。 将在基础通道中进行数次纹理查找，以获取贴花属性，这会增加像素工作。 0：关闭（默认） 1：开启 |
| `r.Mobile.DesiredResX` | `0` | 所需的移动X分辨率（最长轴）（非零==用于X，计算Y以保留纵横比） |
| `r.Mobile.DesiredResY` | `0` | 所需的移动Y分辨率（最短轴）（非零==用于Y，计算X以保留纵横比） |
| `r.Mobile.DisableVertexFog` | `1` | 如果为true，顶点雾将从大部分移动基础通道着色器中省略。相反，雾将在单独的通道中应用，并且仅在场景有雾组件时应用。 |
| `r.Mobile.EarlyZPass` | `0` | 是否使用仅深度通道来初始化移动基础通道的Z剔除。更改此设置需要重启编辑器。 0：关闭 1：全部不透明 2：仅限遮罩图元 |
| `r.Mobile.EnableCloth` | `true` | 如果启用，则编译布料着色器permutation并在移动平台上渲染模拟布料，在PC端渲染移动模式。无法在运行时更改 |
| `r.Mobile.EnableMovableLightCSMShaderCulling` | `1` | 0：所有可移动定向光源照亮的图元均使用CSM渲染。 1：可移动定向光源照亮的图元将在确定位于CSM范围内时使用CSM着色器渲染。（默认值） |
| `r.Mobile.EnableMovableSpotlightsShadow` | `0` | 如果为1，则启用可移动聚光源阴影支持 |
| `r.Mobile.EnableNoPrecomputedLightingCSMShader` | `1` | 0：除非r.AllowStaticLighting为0，否则不会生成用于没有任何预计算光照的场景的CSM着色器。（默认） 1：始终生成用于没有任何预计算光照的场景的CSM着色器。 |
| `r.Mobile.EnableOcclusionExtraFrame` | `true` | 是否允许额外帧用于遮挡剔除（默认启用） |
| `r.Mobile.EnableStaticAndCSMShadowReceivers` | `1` | 0：图元只能接收来自固定光源的静态阴影。 1：图元只能接收来自固定光源的CSM和静态阴影。（默认值） |
| `r.Mobile.EyeAdaptation` | `1` | 适用于移动平台的EyeAdaptation。 0：禁用 1：启用（默认） |
| `r.Mobile.FloatPrecisionMode` | `0` | 0：使用半精度（默认） 1：半精度，但材质表达式的全精度除外 2：强制在像素着色器中使用高精度。 |
| `r.Mobile.ForceDepthResolve` | `0` | 0：深度缓冲区通过切换渲染目标来解析。（默认） 1：深度缓冲区通过切换渲染目标和使用深度纹理进行绘制来解析。 |
| `r.Mobile.Forward.EnableClusteredReflections` | `0` | 是否在移动前向时启用群集反射，在移动延迟上始终受支持。 |
| `r.Mobile.Forward.EnableLocalLights` | `1` | 0：禁用局部光源（默认） 1：启用局部光源 2：启用局部光源缓冲区 |
| `r.Mobile.Forward.LocalLightsSinglePermutation` | `0` | 是否使用相同的Permutation，无论局部光源状态如何。这可能会提高RT时间，但会牺牲一些GPU时间 |
| `r.Mobile.GTAOPreIntegratedTextureType` | `2` | 0：无纹理。 1：Texture2D LUT。 2：体积LUT（默认）。 |
| `r.Mobile.IgnoreDeferredShadingSkyLightChannels` | `0` | 在移动延迟着色中应用天空光照时是否忽略图元光照通道。 这可能会提高GPU性能，但代价是非默认光照通道的图元会出现不正确的光照 |
| `r.Mobile.MaxVisibleMovableSpotLightShadows` | `8` | 可投射阴影的可视聚光源的最大数量按屏幕尺寸排序，出于性能原因应尽可能少 |
| `r.Mobile.MeshSortingMethod` | `0` | 如何在移动端对网格体命令进行排序： 0：按状态排序，大致从前到后（默认）。 1：严格从前到后排序。 |
| `r.Mobile.MobileSupportBloomSetupRareCases` | `0` | 0：不为BloomSetup罕见情形生成Permutation。（默认，如Sun+MetalMSAAHDRDecode、Dof+MetalMSAAHDRDecode、EyeAdaptaion+MetalMSAAHDRDecode及其任何组合） 1：为BloomSetup罕见情形生成Permutation。 |
| `r.Mobile.PixelFogDepthTest` | `1` | 是否使用深度和模板测试进行雾渲染 |
| `r.Mobile.PixelFogQuality` | `1` | 指数高度雾渲染质量。 0 - 基本逐像素雾 1 - 所有逐像素雾特征（次级雾、定向内散射、空中视角） |
| `r.Mobile.PixelProjectedReflectionQuality` | `1` | 移动平台上像素投影反射的质量。 0：禁用 1：性能最佳，但在某些视角下可能会有一些瑕疵。[默认] 2：质量更佳，性能更合理，并可以修复一些瑕疵。 3：质量最好，但会重得多。 |
| `r.Mobile.PlanarReflectionMode` | `0` | PlanarReflection在移动平台的不同模式下会有不同的工作方式，请根据需要选择适当的模式。 0：PlanarReflection Actor在所有平台照常工作。[默认] 1：PlanarReflection Actor仅用于移动像素投影反射，不会影响PC/主机。副作用是MobileMSAA将被禁用。 2：PlanarReflection Actor在PC/主机平台上照常工作，并用于移动平台上的移动像素投影反射。副作用是MobileMSAA将被禁用。 |
| `r.Mobile.PropagateAlpha` | `0` | 0：禁用；1：传播完整的Alpha |
| `r.Mobile.SceneColorFormat` | `0` | 重载用于移动渲染器场景颜色的内存布局（RGBA）。 不受支持的重载格式将静默使用默认格式 0：（默认）根据项目设置和设备支持自动选择适当的格式。 1：PF_FloatRGBA 64Bit 2：PF_FloatR11G11B10 32Bit 3：PF_B8G8R8A8 32Bit |
| `r.Mobile.SceneDepthAux` | `1` | 1：16F SceneDepthAux格式 2：32F SceneDepthAux格式 |
| `r.Mobile.ShadingModelsMask` | `-1` | 指示在移动平台上启用了哪些着色模型的遮罩。 |
| `r.Mobile.ShadingPath` | `0` | 0：正向着色（默认值） 1：延迟着色（延迟着色需要移动HDR） |
| `r.Mobile.Shadow.CSMShaderCullingDebugGfx` | `0` |  |
| `r.Mobile.Shadow.CSMShaderCullingMethod` | `1` | 用于确定哪些图元将接收CSM着色器的方法： 0 - 禁用（所有图元将接收CSM） 1 - 光源视锥体，边界框在CSM接收距离内的所有图元。（默认） 2 - 投射器组合边界、边界在CSM接收距离内的所有图元以及所有投射器组合边界的胶囊体。 3 - 光源视锥体 + 投射器边界，边界在CSM接收距离内且胶囊体至少有一个投射器的所有图元。（最慢） 4 - 剔除全部。防止图元接收CSM阴影。 5 - 如果所有视图都使用了移动距离场阴影，则禁用剔除。 与16结合将图元边界测试更改为球体而不是盒体。（即18==组合投射器+球体测试） |
| `r.Mobile.ShadowmapRoundUpToPowerOfTwo` | `0` | 在移动平台上将阴影贴图向上取整为2的幂，以防出现任何兼容性问题。 0：禁用（默认） 1：启用 |
| `r.Mobile.SkyLightPermutation` | `0` | 0：生成天空光照和非天空光照Permutation。（默认） 1：仅生成非天空光照Permutation。 2：仅生成天空光照Permutation |
| `r.Mobile.SSAOHalfResolution` | `0` | 是否以半分辨率计算SSAO。 0：禁用。 1：采用双线性上采样的半分辨率 2：采用4抽头双边上采样的半分辨率 3：采用9抽头双边上采样的半分辨率 |
| `r.Mobile.SupportGPUScene` | `0` | 是否支持GPU场景，自动实例化所需（仅限移动功能级别） |
| `r.Mobile.SupportsGen4TAA` | `1` | 支持桌面Gen4 TAA和移动渲染 0：回退到FXAA1：支持桌面Gen4 TAA（默认） |
| `r.Mobile.TonemapSubpass` | `0` | 是否启用移动色调映射贴图子通道 0=关闭[默认] 1=开启 |
| `r.Mobile.UseClusteredDeferredShading` | `0` | 为支持群集延迟着色的光源切换使用此功能。0为关闭（默认），1为开启。（需要LightGrid: r.Mobile.Forward.EnableLocalLights=1） |
| `r.Mobile.UseCSMShaderBranch` | `0` | 0：对CSM和非CSM着色使用两个着色器Permutation。（默认） 1：使用着色器中有分支的单一着色器Permutation来应用CSM（仅限r.AllowStaticLighting=0） |
| `r.Mobile.UseHWsRGBEncoding` | `0` | 0：在着色器中写入sRGB编码 1：使用GPU HW自动将线性转换为sRGB（设备必须支持sRGB写入控制） |
| `r.Mobile.UseLightStencilCulling` | `1` | 是否使用模板来剔除局部光源。0为关闭，1为打开（默认） |
| `r.Mobile.VirtualTextures` | `0` | 是否在移动平台上启用虚拟纹理流送。还需要启用r.VirtualTextures。 |
| `r.MobileContentScaleFactor` | `1` | 内容比例乘数（相当于iOS的contentScaleFactor，用于支持Retina显示屏） |
| `r.MobileHDR` | `1` | 0：移动端在LDR伽马空间中进行渲染。（建议用于低端手机的无光照游戏） 1：移动端在HDR线性空间中进行渲染。（默认值） |
| `r.MobileMaxLoadedMips` | `15` | 用于非流送移动平台的加载Mip数量上限。 |
| `r.MobileReduceLoadedMips` | `0` | 减少非流送移动平台的加载纹理Mipmap。 |

### 变形目标

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.MorphTarget.ForceUpdate` | `0` | 强制每帧计算变形目标增量。 0：默认 1：强制更新 |
| `r.MorphTarget.MaxBlendWeight` | `5` | 作为变形目标混合权重接受的最大值。 将根据此值检查混合目标权重以进行验证。小于此数字的值将被限制。 |
| `r.MorphTarget.Mode` | `1` | 使用GPU计算变形目标。 0：使用原始CPU方法（逐变形循环，然后按顶点循环） 1：启用GPU方法（默认） |
| `r.MorphTarget.WeightThreshold` | `1e-08` | 设置MorphTarget权重阈值（默认值：0.000000）。 |

### 动态模糊

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.MotionBlur.AllowExternalVelocityFlatten` | `1` | 是否允许运动模糊的速度平坦化到其他通道。 |
| `r.MotionBlur.Amount` | `-1` | 允许重载后期处理设置（运动模糊的比例） -1：重载（默认） |
| `r.MotionBlur.Directions` | `1` | 模糊方向的数量（默认值=1）。 |
| `r.MotionBlur.HalfResGather` | `0` | 在重度运动下是否以半分辨率动态执行动态模糊过滤。 |
| `r.MotionBlur.HalfResInput` | `1` | 动态模糊是否也以半分辨率输入模糊。 |
| `r.MotionBlur.Max` | `-1` | 允许重载后期处理设置（运动模糊的最大长度，以屏幕宽度的百分比表示） -1：重载（默认） |
| `r.MotionBlur.Scale` | `1` | 允许缩放后期处理中的后期处理强度/数量设置。 1：不进行任何缩放（默认） |
| `r.MotionBlur.TargetFPS` | `-1` | 允许重载后期处理设置（运动模糊速度长度缩放的目标FPS）。 -1：重载（默认值） 0：使用移动平均值的目标当前帧速率 [1,120]：运动模糊速度缩放的目标FPS |
| `r.MotionBlur2ndScale` | `1` |  |
| `r.MotionBlurDebug` | `0` | 定义是否记录动态模糊渲染的调试输出。 0：关闭（默认） 1：开启 |
| `r.MotionBlurFiltering` | `0` | 有用的开发者变量 0：关闭（默认，着色器期望值，可获得更好的质量） 1：开启 |
| `r.MotionBlurQuality` | `4` | 定义允许调整质量或性能的动态模糊方法。 0：关闭，1：低；2：中度，3：高（默认），4：非常高 |
| `r.MotionBlurScatter` | `0` | 强制基于散射的最大速度方法（较慢）。 |
| `r.MotionBlurSeparable` | `0` | 添加第二个动态模糊通道，可平滑噪点，从而获得更高质量的模糊。 |

### Nanite

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.Nanite` | `1` | 使用Nanite渲染静态网格体。 |
| `r.Nanite.AllowComputeMaterials` | `1` | 是否启用对Nanite计算材质的支持 |
| `r.Nanite.AllowLegacyMaterials` | `1` | 是否启用对Nanite旧版材质的支持 |
| `r.Nanite.AllowMaskedMaterials` | `1` | 是否允许使用遮罩材质的网格体使用Nanite进行渲染。 |
| `r.Nanite.AllowSplineMeshes` | `1` | 是否启用对Nanite样条线网格体的支持 |
| `r.Nanite.AllowTessellation` | `0` | 是否启用对（高度试验性）Nanite运行时曲面细分的支持 |
| `r.Nanite.AllowWPODistanceDisable` | `1` | 是否允许禁用距离摄像机较远的Nanite实例的世界位置偏移。 |
| `r.Nanite.AsyncRasterization` | `1` | 如果可用，将Nanite计算光栅化作为异步计算运行。 |
| `r.Nanite.AsyncRasterization.ShadowDepths` | `0` | 如果可用，将Nanite计算阴影光栅化作为异步计算运行。 |
| `r.Nanite.BarrierTest` | `1` |  |
| `r.Nanite.BinningTechnique` | `0` |  |
| `r.Nanite.Builder.FallbackTriangleThreshold` | `0` | 三角形数量<=此阈值时，使用不变的源网格体作为回退。 |
| `r.Nanite.Bundle.Emulation` | `0` | 是否强制着色器束调度模拟 |
| `r.Nanite.Bundle.Shading` | `0` | 是否对着色启用Nanite着色器束调度 |
| `r.Nanite.CoarseMeshStreaming` | `0` | 根据代理的TLAS使用情况，生成2个Nanite粗糙网格体LOD，并在更高质量的LOD中动态流送。 |
| `r.Nanite.CoarseMeshStreamingMode` | `0` | 流送模式： 0：使用TLAS代理来驱动在预算范围内流送什么内容（默认） 1：向内流送所有已注册的网格体 2：不向内流送任何粗糙LOD |
| `r.Nanite.CoarseStreamingMeshMemoryPoolSizeInMB` | `220` | 用于对粗糙Nanite网格体的渲染网格体和BLAS数据进行向内流送的池大小（默认200MB） 此预算将成为网格体流送池大小的一部分。 在主机上，实际的BLAS内存将是其中一部分，在PC端，仅限顶点数据，因为BLAS依赖于GPU和驱动程序。 |
| `r.Nanite.ComputeMaterials` | `1` | 是否启用Nanite计算材质 |
| `r.Nanite.ComputeMaterials.Sort` | `1` |  |
| `r.Nanite.ComputeRasterization` | `1` | 是否允许计算光栅化。禁用后，所有光栅化都将通过硬件路径。 |
| `r.Nanite.Culling.DrawDistance` | `1` | 设置为0可测试因实例绘制距离而禁用Nanite剔除。 |
| `r.Nanite.Culling.Frustum` | `1` | 设置为0可测试因超出视锥体范围而禁用Nanite剔除。 |
| `r.Nanite.Culling.GlobalClipPlane` | `1` | 设置为0可测试因超出全局裁剪平面而禁用Nanite剔除。 注意：如果r.AllowGlobalClipPlane=0则无效。 |
| `r.Nanite.Culling.HZB` | `1` | 设置为0可测试由于分层深度缓冲区遮挡而禁用Nanite剔除。 |
| `r.Nanite.Culling.TwoPass` | `1` | 设置为0可测试禁用两通道遮挡剔除。 |
| `r.Nanite.Culling.WPODisableDistance` | `1` | 设置为0可测试对Nanite实例禁用‘世界位置偏移禁用距离’。 |
| `r.Nanite.CustomDepth` | `1` | 是否允许Nanite在CustomDepth通道中进行渲染 |
| `r.Nanite.CustomDepth.ExportMethod` | `1` | 0 - 通过PS将深度/模板导出到单独的目标 1 - 通过CS将深度/模板直接导出到目标（需要HTILE支持） |
| `r.Nanite.Debug.ValidateShadeBinning` | `0` |  |
| `r.Nanite.DecompressDepth` | `0` |  |
| `r.Nanite.DicingRate` | `2` | Nanite曲面细分将切割成的微多边形尺寸，以像素为单位。 |
| `r.Nanite.EmitMaterialPerformanceWarnings` | `0` | 当Nanite材质可编程并使用掩蔽或像素深度偏移（PDO）时，发出日志和屏幕消息进行警告。 |
| `r.Nanite.ExportDepth` | `1` |  |
| `r.Nanite.FastTileClear` | `1` | 是否启用Nanite快速图块清除 |
| `r.Nanite.FastTileClear.SubTiles` | `1` | 是否启用Nanite快速图块清除（针对4x4子图块） |
| `r.Nanite.FastTileVis` | `-1` | 允许在可视化中仅显示单个目标，或为-1时显示所有累加内容 |
| `r.Nanite.FastVisBufferClear` | `1` | 是否启用快速清除优化。设置为2进行图块清理。 |
| `r.Nanite.FilterPrimitives` | `1` | 是否启用逐视图图元过滤。 |
| `r.Nanite.ForceEnableMeshes` | `0` | 无论资产上的启用标记如何，强制使所有网格体也能编译Nanite数据。 |
| `r.Nanite.ImposterMaxPixels` | `5` | 以像素为单位测量的替代物的最大尺寸。 |
| `r.Nanite.IsNaniteStaticMeshSettingsInitiallyCollapsed` | `false` | 如果Nanite设置最初在静态网格体编辑器工具中的细节面板中折叠。 |
| `r.Nanite.IsolateInvalidCoarseMesh` | `0` | 调试模式仅渲染错误引用粗糙静态网格体资产的非Nanite代理。 |
| `r.Nanite.LargePageRectThreshold` | `128` | 在统计数据中记录为大型的候选群集的虚拟页面重叠数量大小的阈值。 |
| `r.Nanite.MaterialBuffers.AsyncUpdates` | `true` | 如果非零，Nanite材质数据缓冲区更新将异步更新。 |
| `r.Nanite.MaterialBuffers.Defrag` | `true` | 是否允许对Nanite材质数据缓冲区进行碎片清理。 |
| `r.Nanite.MaterialBuffers.Defrag.Force` | `0` | 0：不强制进行完全碎片清理。 1：下次更新时强制进行一次完整的碎片清理。 2：强制对每帧进行完全碎片清理。 |
| `r.Nanite.MaterialBuffers.Defrag.LowWaterMark` | `0.375` | 使用内存与分配内存的比率，用于决定对Nanite材质数据缓冲区进行碎片清理。 |
| `r.Nanite.MaterialBuffers.ForceFullUpload` | `0` | 0：不强制进行完整上传。 1：下次更新时强制进行一次完整上传。 2：强制每帧进行完整上传。 |
| `r.Nanite.MaterialBuffers.MaterialDataMinSizeBytes` | `4096` | Nanite材质数据缓冲区的最小大小（以字节为单位）。 |
| `r.Nanite.MaterialBuffers.PrimitiveDataMinSizeBytes` | `4096` | Nanite逐图元材质数据缓冲区的最小大小（以字节为单位）。 |
| `r.Nanite.MaterialOverrides` | `1` | 启用对Nanite特定材质重载的支持。 |
| `r.Nanite.MaterialSortMode` | `4` | 对Nanite材质绘制进行排序的方法。0=禁用，1=着色器，2=排序键，3=引用计数 |
| `r.Nanite.MaterialVisibility` | `0` | 是否启用Nanite材质可视性测试 |
| `r.Nanite.MaterialVisibility.Async` | `1` | 是否启用Nanite材质可视性测试的并行化 |
| `r.Nanite.MaterialVisibility.Instances` | `0` |  |
| `r.Nanite.MaterialVisibility.Primitives` | `1` |  |
| `r.Nanite.MaterialVisibility.RasterBins` | `1` |  |
| `r.Nanite.MaterialVisibility.ShadingBins` | `1` |  |
| `r.Nanite.MaxCandidateClusters` | `16777216` | 群集剔除前Nanite群集的数量上限。 |
| `r.Nanite.MaxCandidatePatches` | `2097152` | 考虑分割的Nanite补丁数量上限。 |
| `r.Nanite.MaxNodes` | `2097152` | 剔除通道中遍历的Nanite节点数量上限。 |
| `r.Nanite.MaxPatchesPerGroup` | `5` | 每个补丁光栅器组要处理的补丁数量上限。 |
| `r.Nanite.MaxPixelsPerEdge` | `1` | Nanite运行时所针对的三角形边长，以像素为单位。 |
| `r.Nanite.MaxVisibleClusters` | `4194304` | 可视Nanite群集的数量上限。 |
| `r.Nanite.MaxVisiblePatches` | `2097152` | 可视Nanite补丁的数量上限。 |
| `r.Nanite.MeshDrawCommands.CacheMultithreaded` | `1` | 对Nanite材质启用绘制命令缓存多线程。0=禁用，1=启用（默认） |
| `r.Nanite.MeshShaderRasterization` | `1` | 如果可用，将网格体着色器用于硬件光栅化。 |
| `r.Nanite.MinPixelsPerEdgeHW` | `32` | Nanite开始使用硬件光栅器的三角形边长，以像素为单位。 |
| `r.Nanite.MultipleSceneViewsInOnePass` | `1` | 尽可能支持渲染多个视图（FSceneView）。目前仅支持ISR立体渲染。 |
| `r.Nanite.OccludedInstancesBufferSizeMultiplier` | `1` | 调试 |
| `r.Nanite.ParallelBasePassBuild` | `1` |  |
| `r.Nanite.PersistentThreadsCulling` | `0` | 使用持久线程在一个组合核中执行节点和群集剔除。它不会根据GPU大小缩放线程并且依赖于调度程序行为，因此不推荐用于非固定硬件平台。 |
| `r.Nanite.Picking.Crosshair` | `0` |  |
| `r.Nanite.Picking.Domain` | `0` |  |
| `r.Nanite.PrimaryRaster.PixelsPerEdgeScaling` | `30` | 超出预算时缩放Nanite主光栅MaxPixelsPerEdge值的下限百分比。 |
| `r.Nanite.PrimaryRaster.TimeBudgetMs` | `0` | Nanite主光栅的帧时间预算，以毫秒为单位。 |
| `r.Nanite.PrimShaderRasterization` | `1` | 如果可用，请使用图元着色器进行硬件光栅化。 |
| `r.Nanite.ProgrammableRaster` | `1` | 是否允许可编程光栅。禁用后，所有光栅化都将通过固定函数路径。 |
| `r.Nanite.ProjectEnabled` | `1` | 此设置允许你在支持的平台上禁用Nanite，以减少着色器数量。不能用于在不支持的平台上强制启用Nanite。 |
| `r.Nanite.ProxyRenderMode` | `0` | 如果不支持Nanite，则渲染代理网格体。 0：如果不支持Nanite，则回退到渲染Nanite代理网格体。（默认） 1：如果Nanite在网格体上启用但不受支持，则禁用渲染。 2：如果在网格上启用了Nanite但不受支持，则禁用渲染，静态网格体编辑器开关除外。 |
| `r.Nanite.RasterIndirectionMultiplier` | `3` |  |
| `r.Nanite.RasterSetupCache` | `1` |  |
| `r.Nanite.RasterSetupTask` | `1` |  |
| `r.Nanite.ResummarizeHTile` | `1` |  |
| `r.Nanite.ShadeBinningMode` | `0` | 0：自动 1：强制到像素模式 2：强制到四边形模式 |
| `r.Nanite.ShadowRaster.PixelsPerEdgeScaling` | `100` | 超出预算时缩放Nanite阴影光栅MaxPixelsPerEdge值的下限百分比。 |
| `r.Nanite.ShadowRaster.TimeBudgetMs` | `0` | Nanite阴影光栅的帧时间预算，以毫秒为单位。 |
| `r.Nanite.ShowMeshDrawEvents` | `0` | 发出Nanite光栅化和材质的绘制事件。 |
| `r.Nanite.ShowStats` | `0` |  |
| `r.Nanite.ShowUnsupportedError` | `1` | 指定Nanite不支持屏幕错误消息的行为。 0：禁用 1：如果Nanite存在于场景中但不受支持，并且不使用回退网格体进行渲染，则显示错误；（默认） 2：如果Nanite存在于场景中但不受支持，即使使用回退网格体进行渲染，也显示错误 |
| `r.Nanite.SoftwareVRS` | `1` | 是否在计算中启用Nanite软件可变速率着色。 |
| `r.Nanite.StatsFilter` |  | 设置要从中捕获统计数据的特定Nanite光栅通道的名称 - 使用 `NaniteStats List` cmd枚举可用的过滤器。 |
| `r.Nanite.Streaming.Async` | `1` | 在异步工作线程而非渲染线程上执行大部分Nanite流送。 |
| `r.Nanite.Streaming.AsyncCompute` | `1` | 在异步计算队列中安排GPU工作。 |
| `r.Nanite.Streaming.BandwidthLimit` | `-1` | 流送带宽限制，以兆字节/秒为单位。负值表示无限制。 |
| `r.Nanite.Streaming.Debug.ExplicitRequests` | `1` | 处理来自对RequestNanitePages()明确调用的请求。 |
| `r.Nanite.Streaming.Debug.GPURequests` | `1` | 处理来自GPU渲染反馈的请求 |
| `r.Nanite.Streaming.Debug.Prefetch` | `1` | 通过调用PrefetchResource()来处理资源预取请求。 |
| `r.Nanite.Streaming.DynamicallyGrowAllocations` | `1` | 确定根页面和替代物分配是否允许从r.Nanite.Streaming.NumInitialRootPages和r.Nanite.Streaming.NumInitialImposters设置的初始分配动态增加 |
| `r.Nanite.Streaming.DynamicPageUploadBuffer` | `0` | 在页面上传缓冲区上设置动态标记。这可以消除某些平台上的缓冲区副本，但也可能使转码着色器变慢。 |
| `r.Nanite.Streaming.Imposters` | `1` | 加载用于更快渲染远距离对象的替代物。需要额外的内存，对于具有HLOD或没有远距离对象的场景可能不值得。 |
| `r.Nanite.Streaming.MaxPageInstallsPerFrame` | `128` | 每帧可以安装的页数上限。限制此值可以限制流送开销。 |
| `r.Nanite.Streaming.MaxPendingPages` | `128` | 等待安装的页数上限。 |
| `r.Nanite.Streaming.NumInitialImposters` | `2048` | 初始分配中的替代物数量。启用r.Nanite.Streaming.DynamicallyGrowAllocations后，允许按需增加。 |
| `r.Nanite.Streaming.NumInitialRootPages` | `2048` | 初始分配中的根页面数量。启用r.Nanite.Streaming.DynamicallyGrowAllocations后，允许按需增加。 |
| `r.Nanite.Streaming.ReservedResources` | `0` | 允许将Nanite GPU资源分配为保留资源，以提高内存利用率，并更高效地调整大小（试验性） |
| `r.Nanite.Streaming.StreamingPoolSize` | `512` | 流送池的大小，以MB为单位。不包括用于根页面的内存。 |
| `r.Nanite.Streaming.TranscodeWaveSize` | `0` | 重载用于转码的波形大小。 0：自动（默认值）； 4：波形大小4； 8：波形大小8； 16：波形大小16； 32：波形大小32； 64：波形大小64； 128：波形大小128； |
| `r.Nanite.StreamOut.CacheTraversalData` | `true` | 在计数通道期间缓存遍历数据，以便能够在向外流送通道期间跳过遍历。 |
| `r.Nanite.Tessellation` | `0` | 是否启用（高度试验性）运行时曲面细分。 |
| `r.Nanite.TestPrecacheDrawSkipping` | `0` | 设置为1可假定所有可编程光栅绘制都还未预缓存。 |
| `r.Nanite.UseSceneInstanceHierarchy` | `1` | 控制Nanite对场景实例剔除层级的使用。除非r.SceneCulling也启用，否则无效。 |
| `r.Nanite.ViewMeshLODBias.Enable` | `1` | 应用于主视口的栅格化Nanite网格体的LOD偏移是否应基于TSR的ScreenPercentage（默认启用）。 |
| `r.Nanite.ViewMeshLODBias.Min` | `-2` | 用于主视口光栅化Nanite网格体的最小LOD偏移（默认值=-2）。 |
| `r.Nanite.ViewMeshLODBias.Offset` | `0` | 使用TSR时，适用于主视口的光栅化Nanite网格体的LOD偏移（默认值=0）。 |
| `r.Nanite.Visualize` |  | 当视口视图模式设置为‘Nanite可视化’时，此命令指定显示其中哪个通道。除下面所示允许值之外的输入值将被忽略。 Overview Mask Triangles Patches Clusters Primitives Instances Overdraw MaterialID LightmapUV EvaluateWPO PixelProgrammable Picking Groups Pages Hierarchy RasterMode RasterBins ShadingBins SceneZMin SceneZMax SceneZDelta SceneZDecoded MaterialZMin MaterialZMax MaterialZDelta MaterialZDecoded MaterialCount MaterialMode MaterialIndex HitProxyID LightmapUVIndex LightmapDataIndex PositionBits VSMStatic ShadingWriteMask NoDerivativeOps FastClearTiles Tessellation DisplacementScale |
| `r.Nanite.Visualize.Advanced` | `0` |  |
| `r.Nanite.Visualize.ComplexityOverhead` | `7400` |  |
| `r.Nanite.Visualize.ComplexityScale` | `80` |  |
| `r.Nanite.Visualize.Composite` | `-1` |  |
| `r.Nanite.Visualize.EdgeDetect` | `1` |  |
| `r.Nanite.Visualize.OverdrawScale` | `15` |  |
| `r.Nanite.Visualize.PixelProgrammableVisMode` | `0` | 0：显示遮罩、像素深度偏移和动态置换材质。 1：仅显示遮罩材质。 2：仅显示像素深度偏移。 3：仅显示动态置换。 |
| `r.Nanite.VisualizeOverview` | `"Triangles,Clusters,Instances,Primitives,,,,,,,,,Overdraw,MaterialID,RasterBins,EvaluateWPO"` | 指定可在Nanite可视化概览中使用的模式列表。在逗号之间不输入任何内容，留出空隙。从以下选项中选择：Overview、Mask、Triangles、Patches、Clusters、Primitives、Instances、Overdraw、MaterialID、LightmapUV、EvaluateWPO、PixelProgrammable、Picking、Groups、Pages、Hierarchy、RasterMode、RasterBins、ShadingBins、SceneZMin、SceneZMax、SceneZDelta、SceneZDecoded、MaterialZMin、MaterialZMax、MaterialZDelta、MaterialZDecoded、MaterialCount、MaterialMode、MaterialIndex、HitProxyID、LightmapUVIndex、LightmapDataIndex、PositionBits、VSMStatic、ShadingWriteMask、NoDerivativeOps、FastClearTiles、Tessellation、DisplacementScale。 |
| `r.Nanite.VSMInvalidateOnLODDelta` | `0` | 试验性：群集若未向内流送到与计算出的Nanite LOD估算相匹配的LOD中，会触发VSM失效，其在流送完成时会被重新渲染。 注意：当流送器难以跟上时，可能会导致无效化大幅增加（未来版本将需要限制无效化和/或增加阈值）。 |

### 路径追踪

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.PathTracing` | `1` | 启用路径追踪渲染器（以保护路径追踪器特定材质Permutation的编译） |
| `r.PathTracing.AdaptiveSampling` | `0` | 确定是否启用自适应取样。如果非零，路径追踪器将尝试跳过低于指定错误阈值的像素计算。 0：关闭（均匀取样 - 默认） 1：开启（自适应取样） |
| `r.PathTracing.AdaptiveSampling.ErrorThreshold` | `0.001` | 此为目标感知误差阈值。一旦像素误差低于此值，将不会再次取样（默认：0.001） |
| `r.PathTracing.AdaptiveSampling.Visualize` | `0` | 选择一种可视化模式来帮助理解自适应取样的工作原理。 0：关闭 1：使用热图可视化活动像素（收敛像素按原样显示） 2：可视化样本计数热图（针对当前最大样本值） 3-7：可视化方差mip级别 |
| `r.PathTracing.AdjustMultiGPUPasses` | `true` | 当多个GPU处于活动状态时，每帧运行额外通道，以随着GPU的添加提高性能缩放（默认值=true） |
| `r.PathTracing.ApproximateCaustics` | `1` | 如果非零，路径追踪器将近似焦散路径以减少噪点。这样可以减少低粗糙度玻璃和金属产生的斑点和噪点。（默认值=1（启用）） |
| `r.PathTracing.AtmosphereOpticalDepthLUTNumSamples` | `16384` | 在编译用于路径追踪器在参考大气模式下进行透射率计算的透射率查找纹理时，使用的光线行进样本数量。 （默认值=16384） |
| `r.PathTracing.AtmosphereOpticalDepthLUTResolution` | `512` | 在参考大气模式下，路径追踪器用于透射率计算的方形查找纹理的大小。 （默认值=512） |
| `r.PathTracing.CameraMediumTracking` | `1` | 启用自动摄像机介质跟踪，以自动检测摄像机何时在水中或固体玻璃内启动（默认值=1） 0：关闭 1：开启（默认） |
| `r.PathTracing.Compaction` | `1` | 启用路径压缩以提高路径追踪器的GPU占用率（默认值：1（启用）） |
| `r.PathTracing.DecalGrid.Visualize` | `0` | 启用贴花网格密度的可视化模式，其中红色表示已达到最大贴花数（默认值=0） 0：关闭（默认） 1：贴花数热图（红色 - 接近溢出，增加r.RayTracing.DecalGrid.MaxCount） 2：唯一贴花列表（颜色与哪些贴花占据每个单元相关） |
| `r.PathTracing.DecalRoughnessCutoff` | `0.15` | 不对超出此粗糙度级别的贴花求值，以提高性能（默认值=0.15） |
| `r.PathTracing.Denoiser` | `-1` | 启用路径追踪输出的降噪（如果降噪插件处于活动状态）（默认值=-1（由后处理体积驱动）） -1：从PostProcessVolume继承 0：禁用降噪器 1：启用降噪器（如果降噪插件处于活动状态） |
| `r.PathTracing.Denoiser.NormalSpace` | `0` | 空间法线位于 0：世界空间（默认） 1：摄像机空间。有些降噪器需要摄像机空间法线 |
| `r.PathTracing.Denoiser.Prepass.OutputVarianceTexture` | `1` | 0：方差仅用于降噪器 1：输出到后处理材质，通常由MRQ使用 |
| `r.PathTracing.Denoiser.Prepass.VarianceType` | `1` | 选择逐像素方差类型：0：辐射率的多通道（RGB）方差 1：辐射率、反射率和法线的组合单通道方差 |
| `r.PathTracing.DispatchSize` | `2048` | 控制渲染图像时使用的图块大小。降低此值可能会防止繁重渲染导致的GPU超时。（默认值=2048） |
| `r.PathTracing.EnableCameraBackfaceCulling` | `1` | 如果非零，路径追踪器在追踪来自摄像机的主光线时将跳过背面三角形。（默认值=1（启用）） |
| `r.PathTracing.EnableEmissive` | `-1` | 指示自发光材质是否影响场景光照（默认值=-1（由后处理体积驱动） |
| `r.PathTracing.Experimental` | `0` | 启用路径追踪渲染器的一些试验性功能，这些功能需要编译路径追踪器的额外Permutation。 |
| `r.PathTracing.FilterWidth` | `3` | 设置抗锯齿滤波器宽度（默认值=3.0，对应于标准偏差为1/2像素的高斯） |
| `r.PathTracing.FlushDispatch` | `2` | 启用调度后清空命令列表以降低Windows上出现TDR的可能性（默认值：2） 0：关闭 1：每次调度后清空 2：每图块后清空 |
| `r.PathTracing.FrameIndependentTemporalSeed` | `1` | 表示对跨帧的每个样本使用不同的时间种子，而不是在每帧开始时重置序列 0：关闭 1：开启（默认） |
| `r.PathTracing.HeterogeneousVolumes.RebuildEveryFrame` | `1` | 每帧重新编译体积加速度结构（默认值=1） |
| `r.PathTracing.IndirectDispatch` | `0` | 启用间接调度（如果硬件支持）以进行压缩路径追踪（默认值：0（禁用）） |
| `r.PathTracing.LightFunctionColor` | `0` | 启用光源函数为彩色化而非灰度（默认值=0） 0：关闭（默认值） 1：开启（直接使用光源函数材质输出，而不转换为灰度） |
| `r.PathTracing.LightGridMaxCount` | `128` | 控制二维光源网格中每个单元的光源数量上限。使用该值和场景中光源数量的最小值。（默认值=128） |
| `r.PathTracing.LightGridResolution` | `256` | 控制用于从光照计算中剔除不相关光源的2D光源网格的分辨率（默认值=256） |
| `r.PathTracing.LightGridVisualize` | `0` | 启用光源网格密度的可视化模式，其中红色表示已达到最大光源数量（默认值=0） 0：关闭（默认） 1：光源数量热图（红色 - 接近溢出，增加r.PathTracing.LightGridMaxCount） 2：唯一光源列表（颜色与哪些光源占用每个单元相关） 3：区域光源可视化（绿色：仅点光源，蓝色：部分区域光源） |
| `r.PathTracing.MaxBounces` | `-1` | 设置路径追踪反弹的最大值（默认值=-1（由后处理体积驱动）） |
| `r.PathTracing.MaxPathIntensity` | `-1` | 当为正值时，大于该值的光源路径将被限制以防止萤火虫（默认值=-1（由后期处理体积驱动）） |
| `r.PathTracing.MaxRaymarchSteps` | `256` | 体积中光线行进步数的上限。大多数情况下不会达到这个限制，但如果达到，提高这个限制可以减少偏差。（默认值=256）。 |
| `r.PathTracing.MaxSSSBounces` | `256` | 设置次表面材质内的反弹次数上限。降低此值可能会使次表面散射渲染太暗，而将其设置得太高可能会导致渲染时间过长。 （默认值=256） |
| `r.PathTracing.MeshDecalBias` | `1` | 应用于网格贴花光线的偏差，用于避免与几何体相交（默认值=1.0f） |
| `r.PathTracing.MeshDecalRoughnessCutoff` | `0.15` | 不对超出此粗糙度级别的网格体贴花求值，以提高性能（默认值=0.15） |
| `r.PathTracing.MISCompensation` | `1` | 激活天空光照重要性取样的MIS补偿。（默认=1（启用）） 此选项仅在r.PathTracing.MISMode=2时生效 |
| `r.PathTracing.MISMode` | `2` | 选择光集成的取样技术（默认值=2（启用MIS）） 0：材质取样 1：光源取样 2：材质和光源取样之间的MIS（默认） |
| `r.PathTracing.MultiGPU` | `0` | 启用后使用所有可用GPU运行路径追踪器（默认值=0） 在编辑器中使用此功能需要在命令行上设置-MaxGPUCount=N |
| `r.PathTracing.OutputPostProcessResources` | `1` | 将路径追踪资源输出至后期处理通道 0：关闭 1：开启（缓冲区包括原始/去噪辐射率、反射率、法线和方差） |
| `r.PathTracing.Override.Depth` | `1` | 通过路径跟踪深度z重载场景深度 0：关闭 1：开启（默认情况下，半透明材质通过后期处理景深获得更好的景深。） |
| `r.PathTracing.ProgressDisplay` | `1` | 启用帧内显示达到定义的逐像素样本限制的进度。达到最大值且样本累积停止时，指示器消失（默认值=1） 0：关闭 1：开启（默认） |
| `r.PathTracing.SamplerType` | `0` | 控制路径追踪器生成随机数的方式 0：逐像素使用不同的高质量随机序列（默认） 1：优化跨像素的随机序列，以减少目标样本数的可见误差 |
| `r.PathTracing.SamplesPerPixel` | `-1` | 设置逐像素的样本数上限（默认值=-1（由后期处理体积驱动）） |
| `r.PathTracing.SkylightCaching` | `1` | 尝试在帧之间重新使用天空光照数据。（默认值=1（启用）） 设置为0时，天空光照纹理和重要性取样数据将每帧重新生成。这主要是用作基准测试和调试辅助 |
| `r.PathTracing.SpatialDenoiser` | `1` | 启用路径追踪输出的空间降噪 -1：从PostProcessVolume继承 0：禁用降噪器 1：启用降噪器（如果降噪插件处于活动状态） |
| `r.PathTracing.SpatialDenoiser.Type` | `0` | 空间降噪器类型 0：使用仅空间降噪器插件 1：使用空间降噪插件，该插件还提供时间降噪 |
| `r.PathTracing.SSSGuidingRatio` | `0.5` | 设定经典随机行走和引导至表面行走之间的比率。值为0.0对应于纯粹的经典随机行走，而值为1.0则完全引导至表面（以影响模型非平坦区域的萤火虫为代价）。（默认值=0.5） |
| `r.PathTracing.Substrate.CompileSimplifiedMaterials` | `0` | 编译简化的Substrate材质表示，将所有Slab合并为一个。这主要用于调试目的。启用此项可使路径跟踪着色器Permutation的数量加倍。 0：关闭（默认） 1：开启 |
| `r.PathTracing.Substrate.UseSimplifiedMaterials` | `0` | 不对所有层求值，而是使用已合并所有Slab的优化材质。这主要用于调试，并且要求r.PathTracing.Substrate.CompileSimplifiedMaterials为true。 0：关闭（默认） 1：开启 |
| `r.PathTracing.TemporalDenoiser` | `0` | 启用路径追踪输出的时间降噪 -1：从PostProcessVolume继承（试验性阶段外TODO） 0：禁用降噪器 1：启用降噪器（如果降噪插件处于活动状态） |
| `r.PathTracing.TemporalDenoiser.alpha` | `1` | 指数平均值中的历史记录权重 |
| `r.PathTracing.TemporalDenoiser.DeltaE` | `5` | 将低频CIE DeltaE的历史权重切断为零。 1.0：最小可觉差（JND）， 2.0：近距离观察即可察觉 10.0：一眼即可察觉，这可以作为kappa的替代控制。2为默认值。 |
| `r.PathTracing.TemporalDenoiser.DeltaE.HighFrequency` | `2.1` | 当使用高频逐像素差异时，将历史权重切断为零。 仅当源图像为平滑或已去噪时才应启用。 |
| `r.PathTracing.TemporalDenoiser.DenoiseSourceImageFirst` | `0` | 使用IntelImageDenoisier对源图像进行降噪 |
| `r.PathTracing.TemporalDenoiser.DistanceMetrics` | `2` | 0：基于亮度的指标，用于估计距离。具有相同亮度的颜色将在运动和历史权重估计中产生误差。1：直接颜色差异 2：基于CIELAB2000色差的视觉色差。 |
| `r.PathTracing.TemporalDenoiser.EnableSubPixelOffset` | `1` | 合并时启用子像素偏移 -1：从PostProcessVolume继承 0：禁用降噪器 1：启用降噪器（如果降噪器插件处于活动状态） |
| `r.PathTracing.TemporalDenoiser.eta` | `1` | Eta参数。低于此值的误差距离将具有最大历史权重。如果为-1，则使用DeltaE导出Eta |
| `r.PathTracing.TemporalDenoiser.kappa` | `-1` | 缩放参数用于确定历史权重下降的速度以及切点归零的速度。如果为-1，则使用DeltaE导出kappa |
| `r.PathTracing.TemporalDenoiser.mode` | `1` | 0：禁用 1：仅离线渲染 2：在线渲染（用于调试） |
| `r.PathTracing.TemporalDenoiser.MotionOperation` | `1` | 0：使用直接估计的运动向量 1：运动向量之间相减 |
| `r.PathTracing.TemporalDenoiser.MotionVector.Type` | `0` | 运动向量估计算法的类型 0：内置运动向量估计器 1：插件中的运动向量估计器 |
| `r.PathTracing.TemporalDenoiser.PatchCount` | `1` | 通过非局部平均值找到的用于时间降噪的相似补丁的数量 1：默认。以指数方式累加距离最小的那个。.>1 && < 16：使用双边过滤来累加多个补丁。 |
| `r.PathTracing.TemporalDenoiser.source` | `0` | 0：已降噪的辐射率（可行时）（默认） 1：法线 2：反射率 3：原始辐射率，否则：特征融合（TODO） |
| `r.PathTracing.TemporalDenoiser.SubPixelOffset.StartMip` | `8` | 从0到此Mip，我们将执行子像素偏移 |
| `r.PathTracing.TemporalDenoiser.TotalVariation` | `1` | !=0：如果局部补丁中的总变差很大，则使用较少的历史记录 |
| `r.PathTracing.TemporalDenoiser.Type` | `0` | 时间降噪器类型 0：使用内置时间降噪器 1：使用插件中的时间降噪器 |
| `r.PathTracing.TemporalDenoiser.VisualizeMotionVector` | `0` | 1：对比光栅运动向量，可视化运动向量 |
| `r.PathTracing.TemporalDenoiser.VisWarp` | `0` | 0：禁用 1：通过运动向量可视化扭曲源 2：权重、扭曲源和组合 |
| `r.PathTracing.UseAnalyticTransmittance` | `-1` | 确定在对透射率求值时使用分析或null跟踪估计 -1：如果存在异类体积，则使用null跟踪估计，否则使用分析估计（默认） 0：关闭（改用null跟踪估计） 1：开启（使用分析估计） |
| `r.PathTracing.UseDBuffer` | `1` | 是否支持DBuffer功能（默认=1） |
| `r.PathTracing.VisibleLights` | `0` | 光源是否对摄像机光线可见？（默认=0（关闭）） 0：隐藏来自摄像机光线的光源（默认） 1：使所有光源对摄像机可见 2：使天幕仅对摄像机可见 |
| `r.PathTracing.VolumeMISMode` | `1` | 选择局部光照体积集成的取样技术（默认值=1） 0：密度取样 1：光源取样（默认） |
| `r.PathTracing.WiperMode` | `0` | 启用雨刮器模式，仅在屏幕的某个区域使用路径追踪器进行渲染，以便进行调试（默认值=0，禁用雨刮器模式） |

### 物理场

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.PhysicsField.BuildClipmap` | `1` | 编译物理场裁剪图 |
| `r.PhysicsField.ClipmapCount` | `4` | 用于物理场的裁剪图数量 |
| `r.PhysicsField.ClipmapDistance` | `10000` | 距裁剪图中心的最大距离 |
| `r.PhysicsField.ClipmapExponent` | `2` | 用于导出每个裁剪图大小的指数，与r.PhysicsField.ClipmapDistance结合使用 |
| `r.PhysicsField.ClipmapResolution` | `32` | 物理场的分辨率。 值越高，保真度越高，但内存和合成开销也越高。 |
| `r.PhysicsField.EnableCulling` | `1` | 根据字段节点边界启用空间剔除 |
| `r.PhysicsField.EnableField` | `1` | 启用/禁用物理场裁剪图 |
| `r.PhysicsField.Rendering.EvalType` | `0` | 物理场布尔值，用于检查我们是否在准确求值（0）或取样（1）物理场以进行可视化。 |
| `r.PhysicsField.Rendering.SystemType` | `0` | 物理场布尔值，用于检查是否要显示CPU（0）或GPU（1）字段。 |
| `r.PhysicsField.Rendering.TargetType` | `20` | 要在视口显示选项中使用的物理场目标。 |
| `r.PhysicsField.Rendering.TransientLifetime` | `3` | 用于渲染的物理场临时命令生命周期。 |
| `r.PhysicsField.SingleTarget` | `0` | 将物理场编译限制至仅一个目标，即线性力 |

### 后期处理

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.PostProcessAllowBlendModes` | `1` | 在后期处理材质中启用混合模式。 0：禁用混合模式。使用替换 1：允许混合模式 |
| `r.PostProcessAllowStencilTest` | `1` | 在后期处理材质中启用模板测试。 0：禁用模板测试 1：允许模板测试 |
| `r.PostProcessing.DisableMaterials` | `0` | 允许禁用后期处理材质。 |
| `r.PostProcessing.DownsampleChainQuality` | `1` | 定义在场景颜色链中用于场景颜色下采样的质量。 0：低质量 1：高质量（默认） |
| `r.PostProcessing.DownsampleQuality` | `0` | 定义在后期处理链中将场景颜色下采样至一半或四分之一分辨率所使用的质量。 0：低质量（默认） 1：高质量 |
| `r.PostProcessing.ForceAsyncDispatch` | `0` | 将强制对可用实现的后期处理计算着色器进行异步调度。 仅适用于非发布构建中的测试。 |
| `r.PostProcessing.GBufferPicking` | `0` | 出于调试目的对GBuffer值求值。 |
| `r.PostProcessing.PreferCompute` | `0` | 在实现可用的情况下，将计算着色器用于后期处理。 |
| `r.PostProcessing.PropagateAlpha` | `0` | 0为在后期处理中禁用场景alpha通道支持。 0：禁用（默认）； 1：在线性色彩空间中启用； 2：与1相同，但也通过色调映射器启用。色调映射器之后合成是不正确的，因为对alpha通道进行色调映射没有任何意义。这仅适用于不支持线性颜色空间合成和色调映射的广播硬件。 |
| `r.PostProcessing.QuarterResolutionDownsample` | `0` | 使用四分之一分辨率下采样代替二分之一分辨率来输入到曝光/泛光。 |
| `r.PostProcessingColorFormat` | `0` | 定义用于大多数后期处理链缓冲区的内存布局（RGBA）。 0：默认 1：强制执行PF_A32B32G32R32F 128Bit（不合理但适用于测试） |

### 配置文件GPU

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.ProfileGPU.AssetSummaryCallOuts` |  | 在最终摘要中值得特别提及的子字符串的逗号分隔列表（例如，LOD \| HeroName" r.ProfileGPU.PrintAssetSummary must be true to enable this feature" |
| `r.ProfileGPU.Pattern` | `*` | 允许在使用ProfileGPU时过滤条目，模式匹配区分大小写。 结尾可以使用 `*` 来获取以该字符串开头的所有条目。没有任何前导字符的 `*` 将禁用模式匹配并改为使用时间阈值（默认）。 ‘?’允许忽略一个字符。 例如 `AmbientOcclusionSetup, AmbientOcclusion*, Ambient???lusion*, *` |
| `r.ProfileGPU.PrintAssetSummary` | `0` | 是否应该打印按资产拆分的摘要（也强烈建议使用r.ShowMaterialDrawEvents）。 |
| `r.ProfileGPU.Root` | `*` | 允许在使用ProfileGPU时过滤树，模式匹配区分大小写。 |
| `r.ProfileGPU.Screenshot` | `1` | 分析GPU时是否应截屏。0：关闭，1：开启（默认） |
| `r.ProfileGPU.ShowEventHistogram` | `0` | 是否应该显示事件柱状图。 |
| `r.ProfileGPU.ShowLeafEvents` | `1` | 允许profileGPU显示没有关联绘制的仅事件叶节点。 |
| `r.ProfileGPU.ShowTransitions` | `0` | 允许profileGPU显示资源过渡事件。 |
| `r.ProfileGPU.ShowUI` | `1` | 是否在分析GPU后显示用户界面分析器。 结果将始终进入日志/控制台 0：关闭，1：开启（默认） |
| `r.ProfileGPU.Sort` | `0` | 以各种模式在树的每个级别上独立地对TTY转储进行排序。 0：按时间顺序 1：按耗时 2：按图元数 3：按顶点数 |
| `r.ProfileGPU.ThresholdPercent` | `0` | 事件需要大于待打印的总执行时长的百分比。 |

### 代理LOD

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.ProxyLODChartColorVerts` | `0` | 按UV图对顶点着色。 默认关闭。 0：禁用 1：启用。 |
| `r.ProxyLODCorrectCollapsedWalls` | `0` | ProxyLOD系统是否尝试纠正具有互穿面的墙壁 0：禁用（默认） 1：可结束，可能会导致裂缝。 |
| `r.ProxyLODMaterialInParallel` | `1` | 0：禁用与网格体简化并行进行材质工作 1：启用 - 默认 |
| `r.ProxyLODMaxDilationSteps` | `7` | 出于性能原因，限制用于间隙填充的膨胀步长数 这可能会影响间隙填充的质量，因为将使用较大的膨胀步长，而最大值较小 0：将禁用间隙填充 7：默认 |
| `r.ProxyLODMeshReductionModule` | `ProxyLODMeshReduction` | 要选择的代理LOD缩减模块的名称。如果为空，则选择任何存在的模块。 |
| `r.ProxyLODRemeshOnly` | `0` | 仅限重新网格化。 无需简化或材质。默认关闭。 0：禁用 - 将简化并生成材质 1：启用 - 不会简化或生成材质。 |
| `r.ProxyLODSingleThreadSimplify` | `0` | 使用单线程代码路径。默认关闭。 0：多线程 1：单线程。 |
| `r.ProxyLODTransfer` | `1` | 0：双向射击 1：偏好向前（默认） |
| `r.ProxyLODUseTangentSpace` | `1` | ProxyLOD系统是否在每个顶点处生成真正的切线空间 0：每个顶点处的世界空间 1：每个顶点处的切线空间（默认） |

### PSO

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.pso.CreateOnRHIThread` | `false` | 0：在任务线程上运行PSO创建 1：在RHI线程上运行PSO创建。 |
| `r.pso.evictiontime` | `60` | 从缓存中删除陈旧对象的检查间隔时间。0=无逐出（最终可能会导致内存不足……） |
| `r.pso.PrecompileThreadPoolPercentOfHardwareThreads` | `75` | 如果>0，则将此百分比的核心（向上舍入）用于PSO预编译线程池 用此为r.pso.PrecompileThreadPoolSize的替代方案 0为在预编译PSO时禁用线程池使用。（默认为75%） |
| `r.pso.PrecompileThreadPoolSize` | `0` | 可用于并发PSO预编译的线程数。 0为在预编译PSO时禁用线程池使用。（默认值） |
| `r.pso.PrecompileThreadPoolSizeMax` | `2147483647` | 可用于并发PSO预编译的线程数上限。 除非指定了r.pso.PrecompileThreadPoolPercentOfHardwareThreads，否则忽略 默认没有最大值（INT_MAX） |
| `r.pso.PrecompileThreadPoolSizeMin` | `2` | 可用于并发PSO预编译的线程数下限。 除非指定了r.pso.PrecompileThreadPoolPercentOfHardwareThreads，否则忽略 0=无最小值（默认为2） |
| `r.pso.PrecompileThreadPoolThreadPriority` | `2` | PSO预编译池的线程优先级 |
| `r.PSO.RuntimeCreationHitchThreshold` | `20` | 运行时PSO创建被计为卡顿的阈值（以毫秒为单位）（默认值为20） |
| `r.PSOPrecache.Components` | `1` | 在Postload期间预缓存组件可能使用的所有PSO（如果启用了PSOPrecaching，则默认值为1）。 |
| `r.PSOPrecache.CustomDepth` | `1` | 还预缓存用于自定义深度通道的PSO。0：未针对此通道编译PSO。 1：针对明确请求自定义深度渲染的所有图元编译PSO（默认）。 2：针对还请求常规深度渲染的所有图元编译PSO。 |
| `r.PSOPrecache.DitheredLODFadingOutMaskPass` | `0` | 针对DitheredLODFadingOutMaskPass预缓存PSO。 0：此通道未编译任何PSO（默认）。 1：针对渲染到深度通道的所有图元编译PSO。 |
| `r.PSOPrecache.GlobalComputeShaders` | `0` | 启动期间预缓存所有全局计算着色器（默认值为0）。 |
| `r.PSOPrecache.LightMapPolicyMode` | `1` | 定义在基础通道PSO预缓存期间应检查哪些光照贴图策略。 0：将检查所有可能的LMP。 1：仅预缓存LMP_NO_LIGHTMAP（默认）。 |
| `r.PSOPrecache.PrecacheAlphaColorChannel` | `1` | 还预缓存启用了场景颜色alpha通道的PSO。平面反射和场景捕获稍后会使用此变量来合成到不同的场景中。 |
| `r.PSOPrecache.ProjectedShadows` | `1` | 还使用投影阴影预缓存PSO。0：未针对此通道编译PSO。 1：针对渲染到深度通道的所有图元编译PSO（默认）。 |
| `r.PSOPrecache.ProxyCreationDelayStrategy` | `0` | 当用于预缓存的请求PSO仍在编译时，控制组件代理创建策略。如果r.PSOPrecache.ProxyCreationWhenPSOReady=0则忽略。 0：延迟创建直到PSO准备就绪（默认） 1：使用默认材质创建代理，直到PSO准备就绪。目前已针对静态和蒙皮网格体实现 - Niagara组件将延迟创建 |
| `r.PSOPrecache.ProxyCreationWhenPSOReady` | `1` | 当用于预缓存的请求PSO仍在编译时，延迟组件代理创建。 0：无论PSO状态如何始终创建（默认） 1：根据r.PSOPrecache.ProxyCreationDelayStrategy控制的特定策略延迟创建渲染代理 |
| `r.PSOPrecache.Resources` | `0` | 在Postload期间预缓存源可能使用的所有PSO（如果启用了PSOPrecaching，则默认值为0）。 |
| `r.PSOPrecache.TranslucencyAllPass` | `0` | 针对TranslucencyAll通道预缓存PSO。 0：此通道未编译任何PSO（默认）。 1：针对渲染到半透明度通道的所有图元编译PSO。 |
| `r.PSOPrecache.UseBackgroundThreadForCollection` | `1` | 将后台线程用于网格体通道处理器上的PSO预缓存数据集合。 |
| `r.PSOPrecaching` | `1` | 0为禁用PSO预缓存 1为启用PSO预缓存 |
| `r.PSOPrecaching.WaitForHighPriorityRequestsOnly` | `0` | 0为在加载期间等待所有待处理的PSO预缓存请求（默认） 1为在加载期间仅等待高优先级PSO预缓存请求 |

### 光线追踪

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.RayTracing` | `0` | 0为禁用光线追踪。 0：关闭 1：开启 |
| `r.RayTracing.AllowInline` | `1` | 如果支持，允许使用内联光线追踪（默认值=1）。 |
| `r.RayTracing.AllowPipeline` | `1` | 如果支持，允许使用光线追踪管线（默认值=1）。 |
| `r.RayTracing.AmbientOcclusion` | `-1` | -1：由后期处理体积驱动的值（默认值） 0：光线追踪环境光遮蔽关闭 1：启用光线追踪环境光遮蔽 |
| `r.RayTracing.AmbientOcclusion.EnableMaterials` | `0` | 启用 |
| `r.RayTracing.AmbientOcclusion.EnableTwoSidedGeometry` | `0` | 追踪阴影光线时启用双面几何体（默认值=0） |
| `r.RayTracing.AmbientOcclusion.SamplesPerPixel` | `-1` | 设置环境光遮蔽的每像素样本数（默认值=-1（由后期处理体积驱动）） |
| `r.RayTracing.AsyncBuild` | `0` | 是否在异步计算队列上编译光线追踪加速结构。 |
| `r.RayTracing.AutoInstance` | `1` | 是否自动实例化静态网格体 |
| `r.RayTracing.CompileMaterialAHS` | `1` | 0：跳过对材质的任何命中着色器的编译（不需要alpha遮罩或半透明材质时很有用） 1：为所有光线追踪材质编译任何命中着色器（默认） |
| `r.RayTracing.CompileMaterialCHS` | `1` | 0：跳过材质的最近命中着色器的编译（仅需阴影或环境光遮蔽效果时很有用） 1：为所有光线追踪材质编译最近的命中着色器（默认） |
| `r.RayTracing.Culling` | `3` | 对摄像机后方的对象启用光线追踪中剔除 0：禁用剔除（默认） 1：启用按距离和方位角剔除。仅剔除摄像机后面的对象。 2：启用按距离和方位角剔除。剔除摄像机前后的对象。 3：启用按距离或方位角剔除。剔除摄像机前后的对象。 |
| `r.RayTracing.Culling.Angle` | `1` | 在光线追踪效果中，对摄像机后方投射角度小于此阈值的对象进行摄像机剔除（默认值=1度） |
| `r.RayTracing.Culling.PerInstance` | `1` |  |
| `r.RayTracing.Culling.Radius` | `30000` | 在光线追踪效果中，对摄像机后方处于此半径之外的对象进行摄像机剔除（默认值=30000（300米）） |
| `r.RayTracing.Culling.UseGroupIds` | `0` | 在定义后使用聚合光线追踪组ID边界剔除，而不是图元或实例边界。 |
| `r.RayTracing.Culling.UseMinDrawDistance` | `1` | 使用最小绘制距离进行剔除 |
| `r.RayTracing.Debug.InstanceOverlap.BoundingBoxScale` | `1.001` | 实例边界框范围的比例因子，用于避免z轴冲突。（默认值=1.001） |
| `r.RayTracing.Debug.InstanceOverlap.Scale` | `16` | 用于实例遍历热图可视化的比例因子。（默认值=16） |
| `r.RayTracing.Debug.InstanceOverlap.ShowWireframe` | `1` | 在实例重叠模式下显示线框中的实例边界框。（默认值=1） |
| `r.RayTracing.Debug.PickerDomain` | `0` | 更改选择器域以突出显示： 0 - 三角形（默认） 1 - 实例 |
| `r.RayTracing.DebugDisableTriangleCull` | `0` | 通过禁用背面剔除，强制所有光线追踪几何体实例为双面。对于调试和分析非常实用。（默认值=0） |
| `r.RayTracing.DebugForceOpaque` | `0` | 强制所有光线追踪几何实例为不透明，从而有效禁用任何命中着色器。对于调试和分析非常实用。（默认值=0） |
| `r.Raytracing.DebugForceRuntimeBLAS` | `0` | 在运行时强制编译BLAS。 |
| `r.RayTracing.DebugTimingScale` | `1` | 用于光线时间热图可视化的比例因子。（默认值=1） |
| `r.RayTracing.DebugTraversalScale.Box` | `150` | 用于盒体遍历热图可视化的比例因子。（默认值=150） |
| `r.RayTracing.DebugTraversalScale.Cluster` | `2500` | 用于群集遍历热图可视化的比例因子。（默认值=2500） |
| `r.RayTracing.DebugTraversalScale.Triangle` | `30` | 用于三角形遍历热图可视化的比例因子。（默认值=30） |
| `r.RayTracing.DebugTriangleHitCount.MaxThreshold` | `6` | 调试光线追踪三角形命中数热图可视化的最大命中数阈值。（默认值=6） |
| `r.RayTracing.DebugTriangleHitCount.TopKMostHits` | `10` | 在视图中突出显示前k个命中实例。（默认值=10） |
| `r.RayTracing.DebugTriangleHitCountPerInstance.MaxThreshold` | `100000` | 每个实例热图可视化的调试光线追踪命中数的最大命中数阈值。（默认值=100000） |
| `r.RayTracing.DebugVisualizationMode` |  | 设置光线追踪调试可视化模式（默认=无 - 由视口菜单驱动）。 |
| `r.RayTracing.DebugVisualizationMode.OpaqueOnly` | `1` | 设置视图模式是否仅渲染不透明对象（默认值=1，仅渲染不透明对象，0=渲染所有对象） |
| `r.RayTracing.DebugVisualizationMode.ProceduralPrimitives` | `0` | 是否在可视化模式中包含程序图元。 目前仅在内联重心模式下支持Nanite图元。 |
| `r.RayTracing.DecalGrid.MaxCount` | `128` | 控制二维贴花网格中每个单元的贴花数量上限。使用此值和场景中贴花数量的最小值。（默认值=128） |
| `r.RayTracing.DecalGrid.Resolution` | `256` | 控制用于从计算中剔除不相关贴花的2D贴花网格的分辨率（默认值=256） |
| `r.RayTracing.DynamicGeometry.SharedVertexBufferGarbageCollectLatency` | `30` | 当不使用时，堆被删除之前的更新周期数（默认值为30）。 |
| `r.RayTracing.DynamicGeometry.SharedVertexBufferSizeInMB` | `4` | 动态几何体的BLAS更新期间使用的单个共享顶点缓冲区的大小（默认4MB） |
| `r.RayTracing.DynamicGeometryLastRenderTimeUpdateDistance` | `5000` | 在此距离内的动态几何体将更新其LastRenderTime，以便当组件在视图中不直接可见（而是反射）时，基于可见性的函数更新（如骨骼网格体）可以工作。 |
| `r.RayTracing.Enable` | `1` | 用于打开/关闭光线追踪的运行时切换（试验性）。 |
| `r.RayTracing.EnableInEditor` | `1` | 控制运行编辑器时光线追踪效果是否默认可用。当只有部分人需要光线追踪功能时，此功能才有助于提高编辑器性能。（默认值=1） |
| `r.RayTracing.EnableInGame` | `1` | 控制运行游戏时光线追踪效果的默认状态。此设置将被GameUserSettings.ini中的对应项（如果存在）重载，以允许通过游戏内UI控制。（默认值=1） |
| `r.RayTracing.EnableMaterials` | `1` | 0：绑定输出占位符数据的默认材质着色器 1：绑定真实材质着色器（默认） |
| `r.RayTracing.EnableOnDemand` | `0` | 控制是否可以在运行时根据需要切换光线追踪功能而无需重新启动游戏（试验性）。 需要r.RayTracing=1并将重载游戏中的GameUserSettings。编辑器中需要r.RayTracing.EnableInEditor=1。具有较小的性能和内存开销。 0：关闭（默认） 1：开启 |
| `r.RayTracing.ExcludeDecals` | `0` | 此开关可以修改光线追踪BVH中贴花的包含情况。 0：在光线追踪BVH中包含贴花（默认） 1：在光线追踪BVH中排除贴花 |
| `r.RayTracing.ExcludeSky` | `1` | 此开关可以控制在光线追踪场景中天空几何体的包含情况（排除天空可以加快光线追踪速度）。路径追踪器会忽略此设置。 0：在光线追踪场景中包含天空对象 1：在光线追踪场景中排除天空对象（默认） |
| `r.RayTracing.ExcludeTranslucent` | `0` | 此开关可以修改光线追踪场景中不透明贴花的包含情况。 0：在光线追踪场景中包含半透明对象（默认值） 1：在光线追踪场景中排除半透明对象 |
| `r.RayTracing.ForceAllRayTracingEffects` | `-1` | 强制开启/关闭所有光线追踪效果。 -1：不强制（默认） 0：禁用所有光线追踪效果 1：启用所有光线追踪效果 |
| `r.RayTracing.Geometry.Cable` | `1` | 在光线追踪效果中包含电缆网格体（默认值=1（在光线追踪中启用电缆网格体）） |
| `r.RayTracing.Geometry.Cable.WPO` | `1` | 在光线追踪效果中启用使用EvaluateWPO对电缆网格体进行世界位置偏移求值。 0：光线追踪中世界位置偏移可见的电缆网格体，禁用WPO求值。 1：光线追踪中世界位置偏移可见的电缆网格体，启用WPO求值（默认）。 |
| `r.RayTracing.Geometry.Cable.WPO.Culling` | `1` | 对光线追踪中的电缆网格体启用WPO求值剔除（默认值=1（启用剔除）） |
| `r.RayTracing.Geometry.Cable.WPO.CullingRadius` | `12000` | 在光线追踪效果中，不对此半径之外的电缆网格体进行世界位置偏移求值（默认值=12000（120米）） |
| `r.RayTracing.Geometry.GeometryCache` | `1` | 在光线追踪效果中包含几何体缓存图元（默认值=1（在光线追踪中启用几何体缓存）） |
| `r.RayTracing.Geometry.GeometryCollection` | `0` | 在光线追踪效果中包含几何体集合代理网格体（默认值=0（在光线追踪中禁用几何体集合网格体）） |
| `r.RayTracing.Geometry.HierarchicalInstancedStaticMesh` | `1` | 在光线追踪效果中包含HISM（默认值=1） |
| `r.RayTracing.Geometry.InstancedStaticMeshes` | `1` | 在光线追踪效果中包含静态网格体实例（默认值=1（在光线追踪中启用实例）） |
| `r.RayTracing.Geometry.InstancedStaticMeshes.CullAngle` | `2` | 用于测试剔除实例边界的方位角（默认为2度） -1=>使用基于距离的剔除 |
| `r.RayTracing.Geometry.InstancedStaticMeshes.CullClusterMaxRadiusMultiplier` | `20` | 最大实例大小的乘数（默认值=20） |
| `r.RayTracing.Geometry.InstancedStaticMeshes.CullClusterRadius` | `10000` | 忽略光线追踪效果中此半径之外的实例（默认值=10000（100米）） |
| `r.RayTracing.Geometry.InstancedStaticMeshes.Culling` | `1` | 对光线追踪中的实例启用剔除（默认值=1（启用剔除）） |
| `r.RayTracing.Geometry.InstancedStaticMeshes.EvaluateWPO` | `0` | 是否对实例化静态网格体进行WPO求值 0 - 关闭（默认） 1 - 对所有具有WPO的网格体开启 -1 - 仅对启用了WPO求值的网格体开启 |
| `r.RayTracing.Geometry.InstancedStaticMeshes.LowScaleCullRadius` | `1000` | 小型实例的剔除半径（默认值=1000（10米）） |
| `r.RayTracing.Geometry.InstancedStaticMeshes.LowScaleRadiusThreshold` | `50` | 将实例分类为小型的阈值（默认值=50cm） |
| `r.RayTracing.Geometry.InstancedStaticMeshes.MinLOD` | `0` | 将最小LOD限制为此值（默认值=0，可使用最高分辨率LOD） |
| `r.RayTracing.Geometry.InstancedStaticMeshes.SimulationClusterRadius` | `500` | 根据与摄像机的距离对实例进行分组，以模拟WPO（默认值=500（5米），如果<=0则禁用） |
| `r.RayTracing.Geometry.InstancedStaticMeshes.SimulationCount` | `1` | 每个实例化静态网格体模拟的实例数上限，目前上限为256 |
| `r.RayTracing.Geometry.Landscape` | `1` | 在光线追踪效果中包括地形（默认值=1（在光线追踪中启用地形）） |
| `r.RayTracing.Geometry.Landscape.DetectTextureStreaming` | `1` | 如果开启，则当纹理流送状态改变时，更新光线追踪几何体。当地形材质中使用WorldPositionOffset时很有用 |
| `r.RayTracing.Geometry.Landscape.FractionalLODUpdateThreshold` | `0` | 最新编译/缓存的光线追踪几何体与用于渲染的最新值之间的分数LOD的最小差异（默认值为0） 0.1表示分数LOD发生10%的变化，例如从LOD级别1.1变为1.2 值较大时，将减少地形图块更新数，但会在光线追踪和光栅表示之间引入更多错误 |
| `r.RayTracing.Geometry.Landscape.LODsUpdateEveryFrame` | `0` | 如果启用，低于指定级别的LOD将每帧更新，如果你在地形上使用WorldPositionOffset，这可以用于解决纹理流送引起的一些瑕疵 |
| `r.RayTracing.Geometry.LandscapeGrass` | `0` | 在光线追踪效果中包含地形草地（默认值=1） |
| `r.RayTracing.Geometry.MaxBuiltPrimitivesPerFrame` | `-1` | 根据每帧的三角形数量上限设置光线追踪加速结构编译预算（<=0则禁用，并立即编译所有加速结构 - 默认） |
| `r.RayTracing.Geometry.NaniteProxies` | `1` | 在光线追踪效果中包含Nanite代理网格体（默认值=1（在光线追踪中启用Nanite代理网格体）） |
| `r.RayTracing.Geometry.NiagaraMeshes` | `1` | 在光线追踪效果中包含Niagara网格体（默认值=1（在光线追踪中启用Niagara网格体）） |
| `r.RayTracing.Geometry.NiagaraRibbons` | `0` | 在光线追踪效果中包含Niagara条带（默认值=1（在光线追踪中启用Niagara条带）） |
| `r.RayTracing.Geometry.NiagaraSprites` | `1` | 在光线追踪效果中包含Niagara Sprite（默认值=1（在光线追踪中启用Niagara Sprite）） |
| `r.RayTracing.Geometry.PendingBuildPriorityBoostPerFrame` | `0.001` | 增加该帧中未安排的所有待处理编译请求的优先级（0.001 - 默认值） |
| `r.RayTracing.Geometry.ProceduralMeshes` | `1` | 在光线追踪效果中包含程序化网格体（默认值=1（在光线追踪中启用程序化网格体）） |
| `r.RayTracing.Geometry.SkeletalMeshes` | `1` | 在光线追踪效果中包含骨骼网格体（默认值=1（在光线追踪中启用骨骼网格体）） |
| `r.RayTracing.Geometry.SkeletalMeshes.LODBias` | `0` | 光线追踪中骨骼网格体的全局LOD偏差。 如果非零，将使用除预测LOD级别之外的其他LOD级别进行光线追踪。变形目标和布料模拟等高级功能可能无法正常工作。 光线追踪中使用的最终LOD级别是此全局偏差与每个骨架网格资产上设置的偏差的总和。 |
| `r.RayTracing.Geometry.SplineMeshes` | `1` | 在光线追踪效果中包含样条线网格体（默认值=1（在光线追踪中启用样条线网格体）） |
| `r.RayTracing.Geometry.StaticMeshes` | `1` | 在光线追踪效果中包含静态网格体（默认值=1（在光线追踪中启用静态网格体）） |
| `r.RayTracing.Geometry.StaticMeshes.WPO` | `1` | 在光线追踪效果中启用EvaluateWPO的静态网格体的世界位置偏移求值。 0：光线追踪中世界位置偏移隐藏的静态网格体。 1：光线追踪中世界位置偏移可见的静态网格体，启用WPO求值（默认）。 2：光线追踪中世界位置偏移可见的静态网格体，禁用WPO求值。 |
| `r.RayTracing.Geometry.StaticMeshes.WPO.Culling` | `1` | 对光线追踪中的静态网格体启用WPO求值剔除（默认值=1（启用剔除）） |
| `r.RayTracing.Geometry.StaticMeshes.WPO.CullingRadius` | `12000` | 在光线追踪效果中，不对此半径之外的静态网格体进行世界位置偏移求值（默认值=12000（120米）） |
| `r.RayTracing.Geometry.SupportSkeletalMeshes` | `1` | 项目是否在光线追踪效果中支持骨骼网格体。关闭此项将禁用所有骨骼网格体光线追踪GPU资源的创建，从而节省GPU内存和时间。此设置在运行时为只读。（默认值：1） |
| `r.RayTracing.Geometry.Text` | `1` | 在光线追踪效果中包含文本网格体（默认值=1（在光线追踪中启用文本网格体）） |
| `r.RayTracing.LightFunction` | `1` | 是否在光线追踪效果中支持光材质函数。（默认值=1） |
| `r.RayTracing.LightGridMaxCount` | `128` | 控制二维光源网格中每个单元的光源数量上限。使用该值和场景中光源数量的最小值。（默认值=128） |
| `r.RayTracing.LightGridResolution` | `256` | 控制用于从光照计算中剔除不相关光源的2D光源网格的分辨率（默认值=256） |
| `r.RayTracing.MeshDrawCommands.CacheMultithreaded` | `1` | 启用光线追踪图元网格体命令缓存的多线程。0=禁用，1=启用（默认） |
| `r.RayTracing.MultiGpuMaskTLAS` | `1` | 对于多GPU，控制TLAS和材质管线更新在哪些GPU上运行。 （默认值=1） 0：在所有GPU上运行TLAS和材质管线更新。 原始行为，可能对调试有用。 1：运行遮罩在活动视图GPU上的TLAS和材质管线更新以提高性能。 BLAS更新仍在所有GPU上运行。 |
| `r.RayTracing.Nanite.BLASScratchSizeMultipleMB` | `64` | 将BLAS编译临时缓冲区的大小四舍五入为此值的倍数。 这有助于保持一致的内存使用并防止内存使用量激增。 默认值=64 MB。 |
| `r.RayTracing.Nanite.CutError` | `0` | 当使用程序化光线追踪几何体处理Nanite网格体时，全局目标切割误差可控制质量。 |
| `r.RayTracing.Nanite.ForceUpdateVisible` | `false` | 强制在下一帧更新可见图元的BLAS。 |
| `r.RayTracing.Nanite.MaxBuiltPrimitivesPerFrame` | `8388608` | 根据以三角形数量上限定义的预算来限制每帧编译的BLAS数量。 |
| `r.RayTracing.Nanite.MaxStagingBufferSizeMB` | `1024` | 限制向外流送期间使用的暂存缓冲区的大小（较低的值可能会导致更新受到限制） 默认值=1024 MB。 最大值=2048 MB。 |
| `r.RayTracing.Nanite.Mode` | `0` | 0 - 回退网格体（默认）； 1 - 向外流送网格体； |
| `r.RayTracing.Nanite.ProfileStreamOut` | `false` | [仅限开发]每帧向外流送待处理的请求以测量性能。 |
| `r.RayTracing.Nanite.StreamOut.MaxNumIndices` | `67108864` | 每帧向外流送的最大索引数。 |
| `r.RayTracing.Nanite.StreamOut.MaxNumVertices` | `16777216` | 每帧向外流送的最大顶点数。 |
| `r.RayTracing.Nanite.Update` | `true` | 是否处理Nanite RayTracing更新请求。 |
| `r.RayTracing.NonBlockingPipelineCreation` | `1` | 启用后台光线追踪管线创建，而不会阻塞RHI或渲染线程。 同时，将回退不透明黑色材质用于缺失的着色器。 0：关闭（渲染将始终使用正确的请求材质） 1：开启（默认情况下，非闭锁模式有时可能会在离线渲染场景之外使用回退不透明黑色材质） |
| `r.RayTracing.NormalBias` | `0.1` | 设置用于沿法线偏移光线起始位置的最大法线偏差（默认值=0.1，即1毫米） |
| `r.RayTracing.ParallelMeshBatchSetup` | `1` | 是否通过并行作业设置光线追踪材质。 |
| `r.RayTracing.ParallelMeshBatchSize` | `1024` | 光线追踪材质并行作业的批处理大小。 |
| `r.RayTracing.PSOCacheSize` | `50` | 要保留在缓存中的光线追踪管线数量（默认值=50）。设置为0可禁用逐出。 |
| `r.RayTracing.RequireSM6` | `1` | 光线追踪着色器和功能是否仅在定向并运行SM6时可用。禁用后，光线追踪着色器在SM5模式下运行时也将可用。（默认值=1，仅允许SM6） |
| `r.RayTracing.SceneCaptures` | `-1` | 在场景捕获中启用光线追踪。 -1：使用场景捕获设置（默认） 0：关闭 1：开启 |
| `r.RayTracing.SceneUpdateOnce` | `0` | 试验性： 通过更新一次光线追踪场景来提高GPU性能，但可能会造成瑕疵（主要针对nDisplay） |
| `r.RayTracing.Shadows` | `0` | 0：使用传统光栅化阴影贴图（默认） 1：使用光线追踪阴影 |
| `r.RayTracing.Shadows.AcceptFirstHit` | `1` | 是否允许阴影光线在第一个相交图元上提前终止。在某些情况下，这可能会导致降噪质量变差。（默认值=0） |
| `r.RayTracing.Shadows.AvoidSelfIntersectionTraceDistance` | `0` | 为避免自相交，epsilon追踪的最大追踪距离。如果设置为0，则不会使用epsilon追踪。 |
| `r.RayTracing.Shadows.EnableHairVoxel` | `1` | 启用使用毛发体素数据来追踪阴影（默认值=1） |
| `r.RayTracing.Shadows.EnableMaterials` | `1` | 对阴影光线启用材质着色器绑定。如果禁用此项，则使用默认的简单着色器。（默认值=1） |
| `r.RayTracing.Shadows.EnableTwoSidedGeometry` | `1` | 追踪阴影光线时启用双面几何体（默认值=1） |
| `r.RayTracing.Shadows.HairOcclusionThreshold` | `1` | 定义在进行遮挡之前需要交叉的毛发数量（默认值=1） |
| `r.RayTracing.Shadows.Lights.Directional` | `1` | 对定向光源启用光线追踪阴影（默认值=1） |
| `r.RayTracing.Shadows.Lights.Point` | `1` | 对点光源启用光线追踪阴影（默认值=1） |
| `r.RayTracing.Shadows.Lights.Rect` | `1` | 对矩形光源启用光线追踪阴影（默认值=1） |
| `r.RayTracing.Shadows.Lights.Spot` | `1` | 对聚光源启用光线追踪阴影（默认值=1） |
| `r.RayTracing.Shadows.LODTransitionEnd` | `5000` | LOD过渡范围的结束（默认值=5000） |
| `r.RayTracing.Shadows.LODTransitionStart` | `4000` | LOD过渡范围的开始（默认值=4000） |
| `r.RayTracing.Shadows.MaxBatchSize` | `8` | 同时追踪的阴影数量上限。 |
| `r.RayTracing.Shadows.MaxTranslucencyHitCount` | `-1` | -1：对所有交点求值（默认）。0：禁用半透明阴影测试。>0：限制交点数量。 |
| `r.RayTracing.Shadows.SamplesPerPixel` | `-1` | 设置用于定向光源遮挡的每像素样本数（默认值=1） |
| `r.RayTracing.Shadows.Translucency` | `0` | 0：半透明材质不会投射阴影（默认情况下）。1：半透明材质根据不透明度投射近似半透明阴影（开销非常高）。 |
| `r.RayTracing.Sky.HairOcclusionThreshold` | `1` | 定义在进行遮挡之前需要交叉的毛发数量（默认值=1） |
| `r.RayTracing.SkyLight` | `0` | 启用光线追踪天空光照（默认值=0） |
| `r.RayTracing.SkyLight.DecoupleSampleGeneration` | `1` | 将样本生成与光线遍历解耦（默认值=1） |
| `r.RayTracing.SkyLight.Denoiser` | `1` | 降噪选项（默认值 = 1） |
| `r.RayTracing.SkyLight.EnableMaterials` | `1` | 对阴影光线启用材质着色器绑定。如果禁用此项，则使用默认的简单着色器。（默认值=1） |
| `r.RayTracing.SkyLight.EnableTwoSidedGeometry` | `1` | 追踪阴影光线时启用双面几何体（默认值=1） |
| `r.RayTracing.SkyLight.HairVoxel` | `1` | 包含毛发体素表示以估计天空遮挡 |
| `r.RayTracing.SkyLight.MaxRayDistance` | `1e+07` | 设置光线追踪天空光照的最大光线距离（默认值=1.0e7） |
| `r.RayTracing.SkyLight.MaxShadowThickness` | `1000` | 设置光线追踪天空光照半透明材质的最大阴影厚度（默认值=1.0e3） |
| `r.RayTracing.SkyLight.SamplesPerPixel` | `-1` | 设置光线追踪天空光照的每像素样本数（默认值=-1） |
| `r.RayTracing.SkyLight.Sampling.StopLevel` | `0` | 设置MIP采样的停止级别（默认值=0） |
| `r.RayTracing.SkyLight.ScreenPercentage` | `100` | 对天空遮挡求值的屏幕百分比 |
| `r.RayTracing.Translucency` | `-1` | -1：由后期处理体积驱动的值（默认值） 0：光线追踪半透明度关闭（使用光栅） 1：光线追踪半透明度启用 |
| `r.RayTracing.Translucency.DirectLighting` | `1` | 启用光线追踪半透明度直接光照（默认值=1） |
| `r.RayTracing.Translucency.EmissiveAndIndirectLighting` | `1` | 启用光线追踪半透明度自发光和间接光照（默认值=1） |
| `r.RayTracing.Translucency.HeightFog` | `1` | 在光线追踪半透明度中启用高度雾（默认值=1） |
| `r.RayTracing.Translucency.MaxRayDistance` | `-1` | 设置光线追踪半透明度光线的最大光线距离。使用光线缩短功能时，天空盒将不会在光线追踪半透明通道中取样，并将在稍后与本地反射捕获一起合成。负值为关闭此优化。（默认值=-1（无限光线）） |
| `r.RayTracing.Translucency.MaxRefractionRays` | `-1` | 设置光线追踪半透明度的折射光线数量上限（默认值=-1（由后期处理体积驱动的反弹次数上限） |
| `r.RayTracing.Translucency.MaxRoughness` | `-1` | 设置光线追踪反射可见的最大粗糙度（默认值=-1（最大粗糙度由后期处理体积驱动）） |
| `r.RayTracing.Translucency.MinRayDistance` | `-1` | 设置光线追踪半透明度光线的最小光线距离。实际半透明度光线长度计算为Lerp(MaxRayDistance, MinRayDistance, Roughness)，即从更粗糙的表面追踪时半透明度光线会变短。（默认值=-1（无限光线）） |
| `r.RayTracing.Translucency.PrimaryRayBias` | `1e-05` | 设置光线追踪半透明度中要从主光线TMax中减去的偏差。偏差较大时会降低不透明对象在光线遍历中相交的机会，从而节省性能开销，但存在跳过不透明对象附近一些薄的半透明对象的风险。（建议范围：0.00001 - 0.1）（默认值=0.00001） |
| `r.RayTracing.Translucency.Refraction` | `-1` | 在光线追踪半透明度中启用折射（默认值=1） |
| `r.RayTracing.Translucency.SamplesPerPixel` | `1` | 设置半透明度的每像素样本数（默认值=1） |
| `r.RayTracing.Translucency.Shadows` | `-1` | 在光线追踪半透明度中启用阴影） -1：阴影由后期处理体积驱动（默认值）0：禁用阴影 1：硬阴影 2：软区域阴影 |
| `r.RayTracing.Transmission.MeanFreePathType` | `0` | 0：将次表面轮廓的消光比例用作MFP。1：使用次表面轮廓的最大MFP生成透射样本（不支持Substrate）。 |
| `r.RayTracing.Transmission.RejectionSamplingTrials` | `0` | 确定拒绝取样试验的次数（默认值=0） |
| `r.RayTracing.Transmission.SamplingTechnique` | `1` | 0：使用不断跟踪无限均匀介质 1：使用不断跟踪有限均匀介质，其范围由传输取样距离决定（默认） |
| `r.RayTracing.Transmission.TransmissionSamplingDistanceCulling` | `1` | 启用可视性测试以剔除传输取样距离（默认=1） |
| `r.RayTracing.UseTextureLod` | `0` | 为光线追踪材质着色器启用自动纹理Mip级别选择。 0：将最高分辨率Mip级别用于所有纹理（默认值）。 1：纹理LOD基于总光线长度、输出分辨率和击中点处的纹理密度取近似值（光线椎体方法）。 |

### RDG

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.RDG.AsyncCompute` | `1` | 控制异步计算策略。 0：禁用，不使用异步计算；*1：为标记了异步计算的通道而启用（默认值）；* 2：为能够使用计算命令列表而实现的所有计算通道而启用； |
| `r.RDG.Breakpoint` | `0` | 满足特定条件时调试器中的断点。 0：关闭（默认值）；1：出现RDG警告时；2：匹配调试筛选器的图表/通道编译时；3：匹配调试筛选器的图表/通道执行时；4：匹配调试筛选器的图表/通道/资源被创建或销毁时； |
| `r.RDG.ClobberResources` | `0` | 在分配时间使用请求的清除颜色清除所有渲染目标和纹理/缓冲区UAV。适合用于调试。 0：关闭（默认值）；1：RGBA通道上为1000；2：RGBA通道上为NaN；3：RGBA通道上为+INFINITY。 |
| `r.RDG.CullPasses` | `1` | 图表会剔除存在未使用输出的通道。 0：关闭； 1：打开（默认）； |
| `r.RDG.Debug` | `0` | 允许针对连接和执行通道期间找到的效率低下情况输出警告。 0：禁用；1：发送一次警告（默认值）；2：每次检测到问题时都发送警告。 |
| `r.RDG.Debug.DisableTransientResources` | `0` | 从临时分配器中筛选掉临时资源。使用r.rdg.debug.resourcefilter指定筛选器。启用后默认为所有资源。 |
| `r.RDG.Debug.ExtendResourceLifetimes` | `0` | 拓展资源的资源生命周期（或由r.RDG.Debug.ResourceFilter指定的特定资源筛选器），从而使其无法与图表中的其他资源重叠内存。适合用于在临时锯齿导致问题时进行调试。 0：禁用（默认值）1：启用； |
| `r.RDG.Debug.FlushGPU` | `0` | 使得在每次通过后清空GPU。设置后，将禁用异步计算（r.RDG.AsyncCompute=0）和并行执行（r.RDG.ParallelExecute=0）。 0：禁用（默认值）1：启用。 |
| `r.RDG.Debug.GraphFilter` |  | 将特定调试事件筛选到特定图表。设置为"None"以重置。 |
| `r.RDG.Debug.PassFilter` |  | 将特定调试事件筛选到特定通道。设置为"None"以重置。 |
| `r.RDG.Debug.ResourceFilter` |  | 将特定调试事件筛选到特定资源。设置为"None"以重置。 |
| `r.RDG.Events` | `1` | 控制如何发射RDG事件。 0：禁用；1：启用事件且遵循RDG_EVENT_SCOPE_FINAL（默认值）；2：启用所有事件（忽略RDG_EVENT_SCOPE_FINAL）； |
| `r.RDG.ImmediateMode` | `0` | 通道一创建就执行。适合用于在通道的lambda中崩溃时获得连接代码的调用堆栈。 |
| `r.RDG.MergeRenderPasses` | `1` | 图表将完全相同的连续渲染通道合并为单个渲染通道。 0：关闭； 1：打开（默认）； |
| `r.RDG.OverlapUAVs` | `1` | RDG将在请求时与UAV工作重叠；如果禁用，则会始终插入UAV屏障。 |
| `r.RDG.ParallelDestruction` | `1` | RDG将使用异步任务销毁图表。0：同步销毁图表；1：可异步销毁图表（默认值）； |
| `r.RDG.ParallelExecute` | `1` | 支持时是否启用通道的并行执行。0：关闭；1：打开（默认） |
| `r.RDG.ParallelExecute.PassMax` | `32` | 可供并行执行的连续通道的最大跨度，用于将跨度分担给任务。 |
| `r.RDG.ParallelExecute.PassMin` | `1` | 可供并行执行的连续通道的最小跨度，用于将跨度分担给任务。 |
| `r.RDG.ParallelExecuteStress` | `0` | 通过逐通道启动一个任务来对并行执行路径进行压力测试。同时禁用渲染通道融合。 |
| `r.RDG.ParallelSetup` | `1` | RDG将在受到FRDGBuilder::FlushSetupQueue的调用提示时并行设置通道。0：用AddPass同步设置通道；1：异步设置通道（默认值）； |
| `r.RDG.TransientAllocator` | `1` | RDG将使用RHITransientResourceAllocator分配所有临时资源。0：禁用临时分配器；1：启用临时分配器（默认值）；2：仅为有FastVRAM标记的资源启用临时分配器 |
| `r.RDG.TransientAllocator.IndirectArgumentBuffers` | `0` | 间接参数缓冲区是否应该使用临时资源分配器。默认值：0 |
| `r.RDG.TransientExtractedResources` | `1` | 除非资源被用户明确标记为非临时，否则RDG会将提取的资源分配为临时资源。0：禁用外部临时资源；1：启用外部临时资源（默认值）；2： 强制启用所有外部临时资源（不推荐）； |
| `r.RDG.TransitionLog` | `0` | 将资源过渡记录到控制台。 0：禁用（默认值）>0：为N帧启用；<0：启用； |
| `r.RDG.Validation` | `1` | 对API调用和通道参数依赖性启用正确性验证。 0：禁用；1：启用（默认值）； |
| `r.RDG.VerboseCSVStats` | `0` | 控制RDG的CSV分析统计数据的冗长度。 0：为图表执行发送一份CSV文件；1：为图表执行的每个阶段都发送一份CSV文件。 |

### 读取缓冲区

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.ReadBuffer.AlignSize` | `65536` | 为渲染读取缓冲区的区块所分配的对齐大小（以实例为单位）。例如为浮点缓冲区分配64*1024 = 256k的大小 |
| `r.ReadBuffer.MaxRenderingBytesAllocatedPerFrame` | `33554432` | 要分配的临时渲染读取缓冲区字节数上限，超过该数值则需要开始紧急记录谁在进行分配 |
| `r.ReadBuffer.MinSize` | `262144` | 为渲染读取缓冲区的区块所分配的最小大小（以实例为单位）。例如为浮点缓冲区分配256*1024 = 1mb的大小 |

### 矩形光源图集

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.RectLightAtlas.Debug` | `0` | 启用矩形光源图集调试信息。 |
| `r.RectLightAtlas.Debug.MipLevel` | `0` | 设置MIP级别以在调试模式下将图集纹理可视化。 |
| `r.RectLightAtlas.FilterQuality` | `1` | 决定用于过滤纹理的过滤质量（0：箱式过滤器；1：高斯过滤器）。 |
| `r.RectLightAtlas.ForceUpdate` | `0` | 强制逐帧更新矩形光源图集。 |
| `r.RectLightAtlas.MaxResolution` | `4096` | 用于存储矩形光源纹理的最大分辨率。 |
| `r.RectLightAtlas.MaxTextureRatio` | `2` | 决定纹理的最大宽高比或高宽比。 |

### 反射

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.ReflectionCapture.EnableDeferredReflectionsAndSkyLighting` | `1` | 在渲染反射捕获时，是否对延迟反射和天空贡献求值。 |
| `r.ReflectionCapture.EnableLightFunctions` | `0` | 0：禁用反射/天空光照捕获的光源函数（默认值）。 其他：启用光源函数。 |
| `r.ReflectionCaptureResolution` | `128` | 设置所有反射捕获立方体贴图的分辨率。应通过项目的渲染设置项进行设置。必须是2的幂。默认为128。 |
| `r.ReflectionCaptureSupersampleFactor` | `1` | 渲染反射捕获时的超级取样系数。 默认值=1，即无超级取样，最大值为8。 |
| `r.ReflectionCaptureUpdateEveryFrame` | `0` | 设置后，反射捕获将持续计划更新。 |
| `r.ReflectionEnvironment` | `1` | 是否渲染反射环境功能，该功能会利用反射捕获Actor实现局部反射。 0：关闭；1：打开，且与场景混合（默认值）2：打开并覆盖场景（仅限非发布构建）。 |
| `r.ReflectionEnvironmentBeginMixingRoughness` | `0.1` | 开始将反射捕获与光照贴图间接漫反射混合的最小粗糙度值。 |
| `r.ReflectionEnvironmentEndMixingRoughness` | `0.3` | 停止将反射捕获与光照贴图间接漫反射混合的最小粗糙度值。 |
| `r.ReflectionEnvironmentLightmapMixBasedOnRoughness` | `1` | 是否为非常光滑的表面减少反射捕获的光照贴图混合。 这适合用于确保反射捕获匹配SSR/平面反射的亮度。 |
| `r.ReflectionEnvironmentLightmapMixing` | `1` | 是否为粗糙表面混合来自于反射捕获的间接高光度和来自于光照贴图的间接漫反射。 |
| `r.ReflectionEnvironmentLightmapMixLargestWeight` | `10000` | 值为1时，可用于限制光照贴图的混合，从而仅让来自光照贴图的暗化效果应用到反射捕获。 |
| `r.ReflectionMethod` | `1` | 0 - 无。 反射可以来自放置的反射捕获、平面反射和天空光照，但不会使用全局反射方法。 1 - Lumen。 使用Lumen反射，它同时支持屏幕/软件/硬件光线追踪，并与Lumen全局光照集成，实现粗糙反射以及反射中看到的全局光照。 2 - SSR。 独立屏幕空间反射。 低成本，但受限于屏幕空间信息。 |
| `r.Reflections.Denoiser` | `2` | 选择降噪算法。 0：禁用； 1：强制使用渲染器的默认降噪器；2：GScreenSpaceDenoiser，可能会被第三方插件重载（默认值）。 |
| `r.Reflections.Denoiser.PreConvolution` | `1` | 预卷积通道的数量（默认值=1）。 |
| `r.Reflections.Denoiser.ReconstructionSamples` | `8` | 重构通道的样本数量上限（默认值=8）。 |
| `r.Reflections.Denoiser.TemporalAccumulation` | `1` | 在多个帧上累积样本。 |

### 折射

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.Refraction.Blur` | `1` | 启用粗糙折射，即背景模糊。 |
| `r.Refraction.Blur.MaxExposedLuminance` | `10` | 将场景预曝光亮度限制为此最大值。有助于减少明亮的高光闪烁，即使r.Refraction.Blur.TemporalAA=1。 |
| `r.Refraction.Blur.MaxStandardDeviationInScreenRatio` | `5` | 这将限制屏幕最大折射模糊的半径。 |
| `r.Refraction.Blur.TemporalAA` | `1` | 启用场景颜色缓冲区的时间抗锯齿，以避免在粗糙折射中出现闪烁。 |
| `r.Refraction.OffsetQuality` | `1` | 启用后，偏移缓冲区将浮动以提高质量。这对保持模糊场景缓冲区的柔和度非常重要。 |
| `r.RefractionQuality` | `2` | 决定失真/折射的质量，用于调整质量或性能。 <=0：关闭（最快）； 1：低质量（尚未实现）； 2：正常质量（默认值）； 3：高质量（例如彩边等，尚未实现）。 |

### RHI

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.RHICmdBufferWriteLocks` | `1` | 仅适用于RHI线程。用于诊断缓冲锁问题的调试选项。 |
| `r.RHICmdBypass` | `0` | 是否绕过RHI命令列表并立即发送RHI命令。 0：禁用（对多线程渲染器而言必须）；1：启用（适合调试低级图形API调用，可抑制多线程渲染器代码中的瑕疵） |
| `r.RHICmdFlushRenderThreadTasks` | `0` | 如果值为true，则逐通道清空渲染线程任务。用于诊断问题。这是更精细的控制台变量的主开关。 |
| `r.RHICmdFlushRenderThreadTasksBasePass` | `0` | 等待基础通道末端的并行渲染线程任务完成。是r.RHICmdFlushRenderThreadTasks的更精细版本。如果r.RHICmdFlushRenderThreadTasks或r.RHICmdFlushRenderThreadTasksBasePass大于0，则清空。 |
| `r.RHICmdFlushRenderThreadTasksPrePass` | `0` | 等待预通道末端的并行渲染线程任务完成。 是r.RHICmdFlushRenderThreadTasks的更精细版本。如果r.RHICmdFlushRenderThreadTasks或r.RHICmdFlushRenderThreadTasksPrePass大于0，则清空。 |
| `r.RHICmdFlushRenderThreadTasksShadowPass` | `0` | 等待各阴影通道末端的并行渲染线程任务完成。 是r.RHICmdFlushRenderThreadTasks的更精细版本。如果r.RHICmdFlushRenderThreadTasks或r.RHICmdFlushRenderThreadTasksShadowPass大于0，则清空。 |
| `r.RHICmdFlushRenderThreadTasksSingleLayerWater` | `0` | 等待单层水末端的并行渲染线程任务完成。是r.RHICmdFlushRenderThreadTasks的更精细版本。如果r.RHICmdFlushRenderThreadTasks或r.RHICmdFlushRenderThreadTasksSingleLayerWater大于0，则清空。 |
| `r.RHICmdFlushRenderThreadTasksTranslucentPass` | `0` | 等待半透明通道末端的并行渲染线程任务完成。 是r.RHICmdFlushRenderThreadTasks的更精细版本。如果r.RHICmdFlushRenderThreadTasks或r.RHICmdFlushRenderThreadTasksTranslucentPass大于0，则清空。 |
| `r.RHICmdFlushRenderThreadTasksVelocityPass` | `0` | 等待速度通道末端的并行渲染线程任务完成。 是r.RHICmdFlushRenderThreadTasks的更精细版本。如果r.RHICmdFlushRenderThreadTasks或r.RHICmdFlushRenderThreadTasksVelocityPass大于0，则清空。 |
| `r.RHICmdMaxOutstandingMemoryBeforeFlush` | `256` | 以千字节为单位。RHI强制清空前的剩余内存量。一般来说应将该值设得足够高，以避免在典型帧上发生这种情况。 |
| `r.RHICmdMergeSmallDeferredContexts` | `1` | 在可以确定时，根据r.RHICmdMinDrawsPerParallelCmdList合并小型并行转译任务。 |
| `r.RHICmdMinCmdlistForParallelSubmit` | `1` | 要提交的并行转译命令列表的数量下限。如果小于此数值，则只在RHI线程和直接上下文中运行。 |
| `r.RHICmdMinDrawsPerParallelCmdList` | `64` | 每个命令列表的绘制次数下限。如果总绘制数少于此值，则不会进行并行操作。此规则并不总是能被遵守或正确执行。 |
| `r.RHICmdWidth` | `8` | 控制并行渲染器中大量任务的粒度。 |
| `r.RHIRenderPasses` | `0` |  |
| `r.RHIValidation.DebugBreak.Transitions` | `1` | 控制调试器是否在遇到验证错误时中断。 0：禁用；1：如果遇到验证错误则中断调试器。 |

### 场景

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.SceneCapture.AllowRenderInMainRenderer` | `true` | 是否允许在主渲染器中渲染场景深度（SceneDepth）和设备深度（DeviceDepth）场景捕获以作为优化。 0：作为独立渲染器渲染。 1：如果场景捕获组件启用了"在主渲染器中渲染"功能，则让该渲染器将作为主渲染器的一部分进行渲染。 |
| `r.SceneCapture.CullByDetailMode` | `true` | 是否根据当前细节模式阻止场景捕获更新 |
| `r.SceneCapture.DepthPrepassOptimization` | `0` | 为2D场景捕获进行深度预通道捕获时，是否应用优化的渲染路径。试验性！ 警告：开启则意味着深度预通道（如SingleLayerWater）后的渲染将被忽略，因此结果与关闭控制台变量时不同。 |
| `r.SceneCapture.EnableOrthographicTiling` | `false` | 在N帧（即TileCount）内渲染场景 - 在透视模式下被忽略，仅在正交模式下且启用r.SceneCapture.OverrideOrthographicTilingValues时有效。 |
| `r.SceneCapture.OrthographicNumXTiles` | `4` | 要渲染的X图块数量。在透视模式下被忽略，仅在正交模式下且启用r.SceneCapture.OverrideOrthographicTilingValues时有效。 |
| `r.SceneCapture.OrthographicNumYTiles` | `4` | 要渲染的Y图块数量。在透视模式下被忽略，仅在正交模式下且启用r.SceneCapture.OverrideOrthographicTilingValues时有效。 |
| `r.SceneCapture.OverrideOrthographicTilingValues` | `false` | 重载SceneCaptureComponent2D中定义的正交值 - 在透视模式下被忽略。 |
| `r.SceneColorFormat` | `4` | 决定场景颜色使用的内存布局（RGBA）（主要通过带宽和质量影响性能，特别是半透明度）。 0：PF_B8G8R8A8 32Bit（主要用于测试，可能不适用于HDR） 1：PF_A2B10G10R10 32Bit 2：PF_FloatR11G11B10 32Bit 3：PF_FloatRGB 32Bit 4：PF_FloatRGBA 64Bit（默认值，可能矫枉过正，特别是半透明主要使用SeparateTranslucency的情况） 5：PF_A32B32G32R32F 128Bit（不合理，但适合测试） |
| `r.SceneColorFringe.Max` | `-1` | 可以限制后期处理的设置（以百分比为单位，用场景色差/彩边来模拟真实世界镜头中出现的瑕疵，在图像边角中最为明显）。-1：不限制（默认值）；-2：测试极端边缘 |
| `r.SceneColorFringeQuality` | `1` | 0：关闭，但性能最佳；1：3个纹理取样（默认值）。 |
| `r.SceneCulling` | `1` | 启用或禁用场景剔除。 启用后，将仅在由任何系统使用时才会编译实例层级，目前相当于启用Nanite。 强制重新创建所有渲染状态，因为（目前而言）只存在增量更新路径。 |
| `r.SceneCulling.Async.Query` | `1` | 启用或禁用异步场景剔除的查询。 |
| `r.SceneCulling.Async.Update` | `1` | 启用或禁用异步场景剔除的更新。 |
| `r.SceneCulling.DbgPattern` |  |  |
| `r.SceneCulling.DebugRenderMode` | `0` | 场景剔除调试渲染模式。 0=禁用（默认）；1=启用 |
| `r.SceneCulling.ExplicitCellBounds` | `1` | 启用后，可通过在场景更新时处理实例边界来构建明确的单元格边界。这会使更新增加一些GPU成本，但这通常会被改进的剔除效果所抵消。 |
| `r.SceneCulling.MaxCellSize` | `1.04858e+06` | 层级最大单元格大小。较大边界的对象将被归类为不可剔除对象。 |
| `r.SceneCulling.MinCellSize` | `4096` | 设置层级中单元格的最小尺寸和级别，四舍五入到最接近的兴趣点。限制对象占用空间的级别。 用构建成本和内存占用换取剔除效率。 将用最小单元大小预计算静态ISM的关键帧。 当前为只读，因为一旦发生变更就会重新编译个结构。 |
| `r.SceneCulling.Precomputed` | `0` | 启用或禁用用于场景剔除的预计算空间哈希。 |
| `r.SceneCulling.SmallFootprintSideThreshold` | `16` | 沿基于占用空间的路径进行占用空间（最大值）侧（以最底层的单元格数量为单位）较小的查询。 默认值16<=>占用空间为16x16x16个单元格或8个区块 |
| `r.SceneCulling.TreatInstancedDynamicAsUnCullable` | `1` | 如果打开此选项（默认），则具有实例的动态图元将被视为不可剔除（不放入层级，而是在GPU上暴力搜索）。 这大大降低了CPU的层级更新开销，且对静态元素占很大比例的场景而言，也不会增加GPU开销。 |
| `r.SceneCulling.ValidateAllInstanceAllocations` | `0` | 对网格中存储的所有实例ID进行验证。速度非常慢。 |
| `r.SceneCulling.ValidateGPUData` | `0` | 根据CPU副本对上传的GPU数据进行回读和验证。速度很慢，且强制CPU/GPU同步。 |
| `r.SceneDepthHZBAsyncCompute` | `0` | 选择是否应使用异步计算编译场景深度缓冲区的HZB。 0：不使用异步计算（默认值）；1：使用异步计算且尽早开始；2：使用异步计算，但在ComputeLightGrid.CompactLinks通道后开始 |
| `r.SceneRenderCleanUpMode` | `2` | 决定何时清理场景渲染器。 0：在渲染线程上进行渲染后立即执行清理。 1：在渲染线程上开始下一个场景的渲染时再执行清理。 2：在渲染线程上开始下一个场景的渲染时再执行清理，并将部分工作分发给异步任务。（默认值） |
| `r.SceneRenderTargetResizeMethod` | `0` | 控制场景渲染目标大小调整的方法： （该值仅用于游戏模式和窗口平台，除非启用了 'r.SceneRenderTargetsResizingMethodForceOverride' 。） 0：调整大小以匹配所需的渲染尺寸（默认值）（占用内存最少，当尺寸发生变化时可能导致卡顿，例如ScreenPercentage）；1：固定为屏幕分辨率。 2：扩展到所要求的最大渲染尺寸。（占用内存最多，最不容易出现分配卡顿。） |
| `r.SceneRenderTargetResizeMethodForceOverride` | `0` | 强制所有配置遵守 'r.SceneRenderTargetResizeMethod' 。 0：禁用。 1：启用。 |

### 着色器

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.ShaderCompiler.AllowDistributedCompilation` | `1` | 如果值为0，则只使用本地（由引擎生成）ShaderCompileWorker。如果值为1，则从多个可选后端中选择一个（XGE、FASTBuild、SN-DBS）来分发SCW。 |
| `r.ShaderCompiler.CrashOnHungShaderMaps` | `0` | 如果值为1，着色器编译器将在着色器贴图挂起时崩溃。 |
| `r.ShaderCompiler.DebugDDCKeyAsset` |  | 设置后，包含此名称的资产将在被请求时打印完整的DDC密钥哈希信息 |
| `r.ShaderCompiler.DebugDiscardCacheOutputs` | `0` | 如果!= 0，则缓存输出将被丢弃（不添加到输出映射中），以便进行调试。 可消除缓存的作用，但允许重复触发相同的作业以进行压力测试（例如，在材质编辑器中快速撤销/重做）。 |
| `r.ShaderCompiler.DebugDumpDetailedShaderSource` | `false` | 如果值为true，并且启用了预处理作业缓存，则会为启用了调试输出的作业转储着色器源的多份副本： 1.由IShaderFormat的PreprocessShader实现构建的预处理步骤的未修改输出（Preprocessed_.usf）2.上述的精简版本（删除了注释、行指令和仅包含空格的行），即在启用预处理作业缓存后用于包含在作业输入哈希中的哈希版本（Stripped_.usf）3.传递给平台编译器的最终源（如果IShaderFormat编译函数在预处理后对源应用了进一步的修改，情况将会有所不同；否则将与上面的2相同(即.usf)）。如果值为false，或禁用了预处理作业缓存，则将仅转储被传递给编译器的源（相当于1或3，取决于IShaderFormat实现是否在编译步骤中修改了源。） |
| `r.ShaderCompiler.DebugDumpJobDiagnostics` | `false` | 如果值为true，则所有着色器作业的所有诊断消息（错误和警告）都将与其他调试数据一起转储（以Diagnostics.txt格式）。 |
| `r.ShaderCompiler.DebugDumpJobInputHashes` | `false` | 如果值为true，作业输入哈希将与其他调试数据一起转储（以InputHash.txt格式）。 |
| `r.ShaderCompiler.DebugDumpShaderCode` | `false` | 如果值为true，则每个着色器作业都会转储一个ShaderCode.bin文件，其中包含输出着色器代码对象的内容（每种着色器格式的内容可能不同；注意这些数据经过哈希处理后将生成OutputHash.txt文件）。 |
| `r.ShaderCompiler.DebugDumpWorkerInputs` | `false` | 如果值为true，则各编译作业的工作程序输入文件将与其他调试数据一起保存（注意，还需要启用r.DumpShaderDebugInfo才会生效）。 |
| `r.ShaderCompiler.DebugStallDDCQuery` | `0` | 用于调试，DDC完成回调中的停顿值（以毫秒为单位），用于重现线程漏洞，或模拟更高延迟的DDC，以进行性能测试。 |
| `r.ShaderCompiler.DebugStallSubmitJob` | `0` | 用于调试，SubmitJob中的停顿值（以毫秒为单位），用于重现线程漏洞。 |
| `r.ShaderCompiler.DebugValidateJobCache` | `false` | 启用作业缓存的调试模式，该模式将完全执行所有作业，并验证与输入哈希值匹配的作业输出是否匹配。 |
| `r.ShaderCompiler.DistributedControllerTimeout` | `900` | 期望所分配控制器完成任务所需的最长间隔秒数（用于检测分配控制器的问题）。 |
| `r.ShaderCompiler.DistributedMinBatchSize` | `50` | 使用所分配控制器编译着色器的数量下限。 着色器数量较少时，将在本地编译。 |
| `r.ShaderCompiler.DumpCompileJobInputs` | `0` | 如果!= 0，着色器编译器作业的未处理输入将被转储到调试目录，以便进行进一步检查。此调试功能默认禁用。 |
| `r.ShaderCompiler.DumpDDCKeys` | `false` | 如果!= 0，各着色器贴图的DDC密钥将被转储到项目的保存目录中（即ShaderDDCKeys子目录）。 |
| `r.ShaderCompiler.DumpDebugInfoForCacheHits` | `true` | 如果为true，则输出所有作业的调试信息（通过IShaderFormat::OutputDebugData），包括重复作业和缓存/DDC命中。如果为false，则只有实际执行编译的作业才会转储调试信息。 |
| `r.ShaderCompiler.EmitWarningsOnLoad` | `0` | 如果值1，所有着色器在被加载时都会向日志发送着色器编译器警告。 |
| `r.ShaderCompiler.JobCache` | `1` | 如果!= 0，则着色器编译器缓存（基于未预处理的输入哈希）将被禁用。默认启用。 |
| `r.ShaderCompiler.JobCacheDDC` | `true` | 跳过材质和材质实例加载后的所有着色器编译。依靠按需着色器编译来进行编译。 |
| `r.ShaderCompiler.JobCacheDDCCookEnableRemotePolicy` | `false` | 如果为true，单个着色器作业将被缓存到所有Cook Commandlet中的远程/共享DDC实例中；如果为false，则只会缓存到本地计算机上的DDC实例中。 |
| `r.ShaderCompiler.JobCacheDDCEnableRemotePolicy` | `false` | 如果为true，单个着色器作业将被缓存到所有操作模式中的远程/共享DDC实例中；如果为false，则只会缓存到本地计算机上的DDC实例中。 |
| `r.ShaderCompiler.JobCacheOverflowReducePercent` | `80` | 当着色器编译器作业缓存内存溢出时，将内存减少到最大值的指定百分比。 与在最大预算下每次清理一个项目相比，可减少开销。 |
| `r.ShaderCompiler.MaxDumpedShaderSources` | `10` | 当着色器编译出错时，作为构建瑕疵转储的预处理着色器源的数量上限。默认值为10。 |
| `r.ShaderCompiler.MaxJobCacheMemoryMB` | `16384` | 如果!= 0，此值为着色器编译器缓存的最大值（兆字节，默认值为16GB）。如果值为0则不限制使用。适用此值的最小值或r.ShaderCompiler.MaxJobCacheMemoryPercent。 |
| `r.ShaderCompiler.MaxJobCacheMemoryPercent` | `5` | 如果!= 0，着色器编译器缓存的最大值为可用物理RAM的此百分比（默认值为5%）。如果值为0则不限制使用。适用此值的最小值或r.ShaderCompiler.MaxJobCacheMemoryMB。 |
| `r.ShaderCompiler.ParallelInProcess` | `false` | 试验性- 如果为true，着色器编译将在进程中并行执行。注意，若启用旧版预处理器，将导致序列化。 |
| `r.ShaderCompiler.ParallelSubmitJobs` | `1` | 如果!= 0，FShaderJobCache::SubmitJobs将在多个并行任务中运行，而不是在游戏线程中运行。 |
| `r.ShaderCompiler.PerShaderDDCAsync` | `true` | 如果!= 0，逐着色器DDC查询将异步运行，而不是在SubmitJobs任务中运行。 |
| `r.ShaderCompiler.PerShaderDDCCook` | `false` | 如果为true，则在烘焙过程中启用逐着色器DDC缓存。 |
| `r.ShaderCompiler.PerShaderDDCGlobal` | `1` | 如果!= 0，则为全局和默认着色器启用逐着色器DDC查询。 |
| `r.ShaderCompiler.PreprocessedJobCache` | `true` | 启用后，着色器编译作业将在提交时在烘焙过程中进行预处理（作业排队时），并根据预处理后的源生成作业输入的哈希值。 |
| `r.ShaderCompiler.PrintIndividualProcessStats` | `false` | 如果为true，在多进程烘焙中，将为各进程单独打印统计信息（以及所有进程的汇总信息）。 |
| `r.ShaderCompiler.RecompileShadersOnSave` | `false` | 启用后，编辑器将尝试重新编译在保存时发生更改的着色器文件。 适用于在编辑器中迭代着色器。 默认值：false |
| `r.ShaderCompiler.ShadermapCompilationTimeout` | `7200` | 单个着色器贴图（可由多个作业组成）被视为挂起后可编译的最长秒数。 |
| `r.ShaderCompiler.StatsPrintoutInterval` | `180` | 打印调试统计信息的最小间隔时间（秒）（默认情况下不超过每分钟一次）。 |
| `r.ShaderCompiler.ThreadLocalPreprocessBuffer` | `1310720` | 为各工作线程预分配的预处理输出量，以节省预处理器的重新分配开销。 |
| `r.ShaderCompiler.TooLongIOThresholdSeconds` | `0.3` | 默认情况下，ShaderCompileWorker（SCW）的任务文件将按顺序读取/写入，但如果花费的时间超过了指定时间（默认0.3秒），则切换到并行方式。不会默认为并行写入，因为这会增加着色器编译器的CPU开销。 |
| `r.ShaderComplexity.Baseline.Deferred.PS` | `111` | 延迟着色时像素着色器的指令数下限（默认值=111） |
| `r.ShaderComplexity.Baseline.Deferred.UnlitPS` | `33` | 延迟着色时无光照材质像素着色器的指令数下限（默认值=33） |
| `r.ShaderComplexity.Baseline.Deferred.VS` | `41` | 延迟着色时顶点着色器的指令数下限（默认值=41） |
| `r.ShaderComplexity.Baseline.Forward.PS` | `635` | 正向着色时像素着色器的指令数下限（默认值=635） |
| `r.ShaderComplexity.Baseline.Forward.UnlitPS` | `47` | 正向着色时无光照材质像素着色器的指令数下限（默认值=47） |
| `r.ShaderComplexity.Baseline.Forward.VS` | `134` | 正向着色时顶点着色器的指令数下限（默认值=134） |
| `r.ShaderComplexity.CacheShaders` | `0` | 如果非零，则将着色器复杂度着色器存储在材质着色器贴图中，以防止编译时出现延迟。（默认值=0） |
| `r.ShaderComplexity.MobileMaskedCostMultiplier` | `1.5` | 如果在早期Z优化中不使用遮罩材质，则需要付出的额外遮罩材质开销 |
| `r.ShaderDevelopmentMode` | `0` | 0：默认值；1：启用各种着色器开发工具，例如在着色器编译失败时重试的功能，以及编译着色器时的额外日志记录。 |
| `r.ShaderLibrary.PrintExtendedStats` | `1` | 如果!= 0，着色器库将生成扩展的统计信息，包括文字表述 |
| `r.ShaderPipelineCache.AlwaysGenerateOSCache` | `1` | 如果值为1，在每次运行时生成缓存；如果值为0，只在缺少缓存时才生成缓存。 |
| `r.ShaderPipelineCache.AutoSaveTime` | `30` | 当记录的PSO数量小于r.ShaderPipelineCache.SaveAfterPSOsLogged时，对记录的PSO进行保存的时间。当r.ShaderPipelineCache.SaveAfterPSOsLogged为0时禁用 |
| `r.ShaderPipelineCache.AutoSaveTimeBoundPSO` | `2147483647` | 当命令行中出现-logpso时，对记录的PSO进行保存的时间。 |
| `r.ShaderPipelineCache.BackgroundBatchSize` | `1` | 在后台编译时，单次批量编译PipelineStateObject的数量。默认为每帧最多1个，但由于文件IO是异步的，实际数量会更少。 |
| `r.ShaderPipelineCache.BackgroundBatchTime` | `0` | 在后台预编译各帧所花费的目标时间（毫秒）。设为0.0以禁用。预编译速度越快，批次大小越大，速度越慢，批次大小越小，以尽量占满数量。默认值为0.0（关闭）。 |
| `r.ShaderPipelineCache.BatchSize` | `50` | 编译任务优先级时，单次批量编译PipelineStateObject的数量。默认为每帧最多50个，但由于文件IO是异步的，实际数量会更少。 |
| `r.ShaderPipelineCache.BatchTime` | `16` | 编译任务优先级时，预编译各帧所花费的目标时间（毫秒）。设为0.0以禁用。预编译速度越快，批次大小越大，速度越慢，批次大小越小，以尽量占满数量。默认值为16.0（预编译的最大毫秒/每帧）。 |
| `r.ShaderPipelineCache.ClearOSCache` | `0` | 若值为1，则在安装后启用操作系统级别的清除；若值为0则禁用。 |
| `r.ShaderPipelineCache.DoNotPrecompileComputePSO` | `0` | 启动时，禁用（从已录制文件重播的）计算PSO的预编译。作为预防问题的安全开关 |
| `r.ShaderPipelineCache.Enabled` | `0` | 1表示启用PipelineFileCache；0表示禁用。 |
| `r.ShaderPipelineCache.ExcludePrecachePSO` | `0` | 1表示不将运行时预缓存的图形PSO保存在文件缓存中，0（默认值）表示将其保存在文件缓存中。目前，排除预缓存PSO要求r.PSOPrecaching = 1且r.PSOPrecache.Validation!= 0。 |
| `r.ShaderPipelineCache.GameFileMaskEnabled` | `0` | 若值不为零，则在PSO预编译时使用GameFileMask - 录制时应始终保存使用遮罩，以便在有需要时使用相关数据。 |
| `r.ShaderPipelineCache.GlobalShadersOnlyWhenPSOPrecaching` | `0` | 在启用运行时PSO预缓存时，仅从GlobalShader缓存中编译PSO（默认禁用） |
| `r.ShaderPipelineCache.LazyLoadShadersWhenPSOCacheIsPresent` | `0` | 如果非零：若加载PSO缓存，则从着色器代码库中进行延迟加载。这假定PSO缓存或多或少是完整的。仅适用于支持library+Hash CreateShader API的RHI。（GRHISupportsLazyShaderCodeLoading == true） |
| `r.ShaderPipelineCache.LogPSO` | `0` | 1表示将新的PSO条目记录到文件缓存中并允许保存。 |
| `r.ShaderPipelineCache.MaxPrecompileTime` | `0` | 进行PSO预编译的最长时间。 如果值大于0，则表示允许进行PSO预编译，然后切换到后台处理的时钟时间。 |
| `r.ShaderPipelineCache.MinBindCount` | `0` | 进行PSO预编译的最小绑定数。 更改此值不会影响已不做考虑的PSO。 |
| `r.ShaderPipelineCache.OnlyOpenUserCache` | `0` | 如果值>0，则只打开用户缓存文件，不打开静态文件缓存。默认为0。 |
| `r.ShaderPipelineCache.PrecompileBatchSize` | `50` | 预优化缓存时，单次批量编译PipelineStateObject的数量。默认为每帧最多50个，但由于文件IO是异步的，实际数量会更少。 |
| `r.ShaderPipelineCache.PrecompileBatchTime` | `0` | 进行预优化时，预编译各帧所花费的目标时间（毫秒）。设为0.0以禁用。预编译速度越快，批次大小越大，速度越慢，批次大小越小，以尽量占满数量。默认值为10.0（关闭）。 |
| `r.ShaderPipelineCache.PreCompileMask` | `-1` | 用于预编译缓存的遮罩。默认-1，针对所有PSO |
| `r.ShaderPipelineCache.PreOptimizeEnabled` | `0` | 若值不为零，则进行PSO预优化，从而在进入游戏前在前台编译部分PSO |
| `r.ShaderPipelineCache.PrintNewPSODescriptors` | `0` | 1表示在日志/控制台中打印所有新PSO条目的说明，0表示禁用。2表示打印图形PSO的额外细节。默认为0。 |
| `r.ShaderPipelineCache.ReportPSO` | `0` | 1表示通过委托报告新的PSO条目，但不记录或修改任何缓存文件。 |
| `r.ShaderPipelineCache.SaveAfterPSOsLogged` | `0` | 自动保存前需要记录的PipelineStateObjects数量。0表示禁用自动保存（目前为默认值，因为自动保存功能无法正常工作）。 |
| `r.ShaderPipelineCache.SaveBoundPSOLog` | `0` | 如果值>0，则将程序运行时所有绑定PSO日志保存到可写入的用户缓存文件中。默认值为0，但可以用-logpso强制启用。 |
| `r.ShaderPipelineCache.SaveUserCache` | `0` | 如果值>0，则所有遗漏的PSO都将被保存到可写入的用户缓存文件中，以便在后续运行时加载，从而避免游戏卡顿。仅在macOS上默认启用。 |
| `r.ShaderPipelineCache.StartupMode` | `1` | 设置PSO缓存的启动模式，决定缓存在初始化后的作用： 0：暂停预编译，调用ResumeBatching()前不进行任何编译。 1：在"快速（Fast）"模式下启用预编译。 2：在"后台（Background）"模式下启用预编译。 默认值为1。 |
| `r.ShaderPipelineCache.UserCacheUnusedElementCheckPeriod` | `-1` | 对用户缓存中未使用的PSO进行垃圾回收的间隔天数。设为负值以禁用。 |
| `r.ShaderPipelineCache.UserCacheUnusedElementRetainDays` | `30` | 在缓存中保留未使用PSO条目的天数。 |
| `r.ShaderPipelineCacheTools.IgnoreObsoleteStableCacheFiles` | `0` | 当设为默认值0时，如果无法加载.spc文件，那么缓存（通常是整个烘焙过程）的编译就会失败，从而阻止进一步测试。 将值设置为1后，项目可选择忽略该选项（但仍将发出警告）。 |
| `r.ShaderPipelineCacheTools.IncludeComputePSODuringCook` | `2` | 0表示禁用烘焙时间加法；1表示启用烘焙时间加法；2表示仅添加Niagara PSO。 |
| `r.ShaderPipelines` | `1` | 启用着色器管线。 |
| `r.ShaderPrint` | `0` | ShaderPrint调试开关。 |
| `r.ShaderPrint.DrawOccludedLines` | `1` | 是否使用棋盘格和低不透明度绘制遮蔽线。 |
| `r.ShaderPrint.FontSize` | `8` | ShaderPrint字体大小。 |
| `r.ShaderPrint.FontSpacingX` | `0` | ShaderPrint符号之间的水平间距。 |
| `r.ShaderPrint.FontSpacingY` | `8` | ShaderPrint符号之间的垂直间距。 |
| `r.ShaderPrint.Lock` | `0` | 锁定线条绘制。 |
| `r.ShaderPrint.MaxCharacters` | `2000` | ShaderPrint输出的缓冲区大小。 |
| `r.ShaderPrint.MaxLine` | `32` | ShaderPrint线条数量上限。 |
| `r.ShaderPrint.MaxTriangle` | `32` | ShaderPrint三角形数量上限。 |
| `r.ShaderPrint.MaxWidget` | `32` | ShaderPrint控件数量上限。 |
| `r.ShaderPrint.Zoom` | `0` | 启用光标周围的放大功能。 |
| `r.ShaderPrint.Zoom.Corner` | `3` | 选择在哪个角显示放大镜（0：左上角；1：右上角；2：右下角；3：左下角）。 |
| `r.ShaderPrint.Zoom.Factor` | `8` | 光标周围的放大系数。 |
| `r.ShaderPrint.Zoom.Pixel` | `16` | 光标周围放大的像素数量。 |
| `r.Shaders.AllowCompilingThroughWorkers` | `1` | 允许通过外部着色器编译器工作程序进程进行着色器编译。 1 - （默认值）允许外部着色器编译器工作程序。0 - 不允许外部着色器编译器工作程序。将在虚幻引擎进程中运行着色器编译。 |
| `r.Shaders.AllowUniqueSymbols` | `0` | 启用后，受支持的着色器编译器会根据源文件生成符号。 启用后会导致符号文件数量急剧增加。请仅在绝对必要时启用。 此设置可由[ShaderCompiler]分段下的Engine.ini文件重载。 |
| `r.Shaders.BoundsChecking` | `1` | 是否对着色器中的缓冲区读写执行边界检查和清空为零或忽略。默认值为1（启用）。并非所有着色器语言都能跳过边界检查。 |
| `r.Shaders.CheckLevel` | `1` | 0 => DO_CHECK=0、DO_GUARD_SLOW=0；1 => DO_CHECK=1、DO_GUARD_SLOW=0；2 => DO_CHECK=1、DO_GUARD_SLOW=1，适用于所有着色器。 |
| `r.Shaders.ExtraData` | `0` | 启用可在运行时使用的额外着色器数据生成。这包括着色器名称和其他特定于平台的数据。 这会增加已编译的着色器的臃肿度，并妨碍着色器的重复使用。 此设置可由[ShaderCompiler]分段下的Engine.ini文件重载。 |
| `r.Shaders.FastMath` | `1` | 是否对着色器使用快速数学优化。 |
| `r.Shaders.FlowControlMode` | `0` | 决定着色器编译器应保留还是展开着色器代码的流量控制。 主要作为调试辅助工具，如果不为默认值（0），则会重载基于着色器或基于材质的设置。 0：关闭（默认值）- 完全由平台编译器或指定的着色器/材质决定。 1：首选项 - 尝试保留流量控制。 2：避免 - 尝试展开并扁平化流量控制。 |
| `r.Shaders.ForceDXC` | `1` | 如果可行，则强制所有着色器使用DirectX着色器编译器（DXC），而不是HLSLcc。 1：强制所有着色器使用新编译器（默认值）；0：禁用 |
| `r.Shaders.GenerateSymbols` | `0` | 启用在编译着色器时为着色器调试生成数据。这将明确不会将任何着色器符号写入磁盘。 此设置可由[ShaderCompiler]分段下的Engine.ini文件重载。 |
| `r.Shaders.Optimize` | `1` | 是否优化着色器。 使用Nsight等图形调试器时，最好在启动时禁用此功能。 此设置可由[ShaderCompiler]分段下的Engine.ini文件重载。 |
| `r.Shaders.PropagateLocalWorkerOOMs` | `false` | 设置后，本地着色器编译工作程序中的内存不足情况将被视为常规内存不足情况，并被传播到主进程中。 当在有硬性内存限制的环境中运行时，这一点非常有用，因为在此时，具体是哪个进程违反了内存限制并不重要。 |
| `r.Shaders.RemoveDeadCode` | `1` | 运行预处理步骤，会在编译着色器之前删除未引用的代码。 这可以提高包含大量大型工具头文件的着色器的编译速度。 0：保留所有输入源代码。 1：在编译前删除未引用的代码（默认值） |
| `r.Shaders.RemoveUnusedInterpolators` | `1` | 启用在编译着色器管线时删除未使用的插值器模式。 0：禁用（默认） 1：启用删除未使用的插值器模式 |
| `r.Shaders.SkipCompression` | `0` | 编译后跳过着色器压缩。使用调试着色器时，着色器压缩时间可能相当可观。此控制台变量仅在非发布构建/测试构建中有效。 |
| `r.Shaders.SymbolPathOverride` |  | 重载着色器符号的输出位置。如果路径中包含文本"{Platform}"，则将其替换为着色器平台字符串。 若为空：使用默认位置Saved/ShaderSymbols/{Platform}。此设置可由[ShaderCompiler]分段下的Engine.ini文件重载。 |
| `r.Shaders.Symbols` | `0` | 允许在特定于平台的图形调试器中调试着色器。这将生成并写入着色器符号。 这将启用r.Shaders.GenerateSymbols和r.Shaders.WriteSymbols的行为。 启用需要重新编译着色器的着色器调试功能。这将编译带有符号的着色器，并包含额外的运行时信息，比如着色器名称。使用图形调试器时，最好在启动时启用此功能。 此设置可由[ShaderCompiler]分段下的Engine.ini文件重载。 |
| `r.Shaders.SymbolsInfo` | `0` | 为代替全套的平台着色器PDB，可保存较精简的ShaderSymbols.Info，其中包含着色器平台哈希值和着色器调试信息。 无法一直为着色器保存PDB时可使用此选项。 此设置可由[ShaderCompiler]分段下的Engine.ini文件重载。 |
| `r.Shaders.UseGBufferRefactor` | `0` | 是否使用重构后可自动生成编码/解码函数的GBuffer。将在虚幻引擎5推出前删除。 |
| `r.Shaders.Validation` | `1` | 启用着色器编译器验证警告和错误。 |
| `r.Shaders.WarningsAsErrors` | `0` | 是否在编译着色器时将警告视为错误。（0：禁用（默认值）；1：仅全局着色器；2：所有着色器）。在旧平台上可能会忽略此设置。 |
| `r.Shaders.WriteSymbols` | `0` | 若平台支持，可将着色器符号写入磁盘。请注意，此选项明确并不能生成着色器符号。 此设置可由[ShaderCompiler]分段下的Engine.ini文件重载。 |
| `r.Shaders.WriteSymbols.Zip` | `0` | 0：导出为零散文件。 1：导出为一份未压缩的存档。 |
| `r.Shaders.ZeroInitialise` | `1` | 是否强制对着色器中图元类型的局部变量进行归零初始化。默认值为1（启用）。并非所有着色器语言都能跳过归零初始化。 |
| `r.ShaderSource.CompressionLevel` | `1` | 存储在内存中的着色器源的压缩级别。支持的值见FOodleDataCompression::ECompressionLevel的枚举值。默认值为SuperFast。 |
| `r.ShaderSource.CompressionMethod` | `2` | 存储在内存中的着色器源的压缩方法。支持的值见FOodleDataCompression::ECompressor的枚举值。默认值为Mermaid。 |
| `r.Shading.EnergyConservation` | `1` | 设为0以禁用着色模型节能。 0：关闭 1：开启 |
| `r.Shading.EnergyConservation.Format` | `1` | 节能表格式 0：16位；1：32位。 |
| `r.Shading.EnergyPreservation` | `1` | 0表示禁用着色模型节能，即由高光反射引起的漫反射照明的能量衰减。要求启用节能功能。0：关闭；1：打开 |
| `r.Shading.FurnaceTest` | `0` | 启用或禁用着色验证的熔炉。 |
| `r.Shading.FurnaceTest.SampleCount` | `64` | 熔炉测试采用的逐像素取样器数量。 |

### 阴影

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.Shadow.AlwaysAllocateMaxResolutionAtlases` | `0` | 启用后，将始终以最大分辨率分配阴影贴图图集，而不会按未使用空间修剪。会浪费更多内存，但可能减少渲染目标池的碎片和垃圾。 |
| `r.Shadow.CachedShadowsCastFromMovablePrimitives` | `1` | 可移动图元是否应从缓存的整个场景阴影（可移动点光源和聚光光源）中投射阴影。 禁用此选项可用于删除缓存阴影贴图的副本。 |
| `r.Shadow.CachePreshadow` | `1` | 是否可以缓存预阴影来进行优化 |
| `r.Shadow.CacheWholeSceneShadows` | `1` | 启用后，将缓存来自静态图元的可移动点光源和聚光光源全场景阴影深度，从而进行优化。 |
| `r.Shadow.CacheWPOPrimitives` | `0` | 对缓存的阴影贴图而言，其材质使用世界位置偏移的图元是否应被视为的可移动图元。 启用后，可以让使用世界位置偏移的材质产生更正确但速度较慢的全场景阴影。 |
| `r.Shadow.CSM.MaxCascades` | `10` | 用于渲染动态定向光源阴影的级联数上限。 |
| `r.Shadow.CSM.TransitionScale` | `1` | 允许缩放级联阴影贴图的过渡区域。值的范围在0至2之间。 0：无过渡（最快）；1：遵照光源设置（默认值）；2：光源设置的2倍 |
| `r.Shadow.CSMCaching` | `0` | 0：逐帧渲染CSM。 1：启用CSM缓存。（默认值） |
| `r.Shadow.CSMDepthBias` | `10` | CSM使用的恒定深度偏差、 |
| `r.Shadow.CSMDepthBoundsTest` | `1` | 是否为CSM边界使用深度边界测试，而不是模板测试 |
| `r.Shadow.CSMReceiverBias` | `0.9` | CSM使用的接收偏差。值为0到1之间。 |
| `r.Shadow.CSMScissorOptim` | `false` | 计算优化的剪切矩形尺寸，以排除视锥体之外的CSM切片部分 |
| `r.Shadow.CSMScrollingOverlapAreaThrottle` | `0.75` | CSM滚动重叠区域的最小比例。 |
| `r.Shadow.CSMShadowDistanceFadeoutMultiplier` | `1` | CSM距离消退的乘数 |
| `r.Shadow.CSMSlopeScaleDepthBias` | `3` | CSM使用的斜面缩放深度偏差 |
| `r.Shadow.CSMSplitPenumbraScale` | `0.5` | 应用于级联阴影贴图分割的半影尺寸的比例，适用于将分割之间的过渡最小化 |
| `r.Shadow.Denoiser` | `2` | 选择降噪算法。 0：禁用（默认）； 1：强制使用渲染器的默认降噪器；2：GScreenSpaceDenoiser，可能会被第三方插件重载。 |
| `r.Shadow.Denoiser.HistoryConvolutionSamples` | `1` | 用于卷积时间历史数据的取样数。 |
| `r.Shadow.Denoiser.MaxBatchSize` | `4` | 同时降噪的阴影数量上限。 |
| `r.Shadow.Denoiser.PreConvolution` | `1` | 预卷积通道的数量（默认值=1）。 |
| `r.Shadow.Denoiser.ReconstructionSamples` | `8` | 重构通道的样本数量上限（默认值=16）。 |
| `r.Shadow.Denoiser.TemporalAccumulation` | `1` |  |
| `r.Shadow.DetectVertexShaderLayerAtRuntime` | `1` | 强制编译Vslayer着色器排列，即使平台（RHI）未通过RHISupportsVertexShaderLayer声明编译时间支持。Windows/SM5默认启用，因为DX11在运行时几乎普遍支持此功能。 |
| `r.Shadow.DistanceScale` | `1` | 定向光源的可伸缩性选项，可在阴影距离与性能之间进行权衡（有合理的范围限制）。 <1：较短的距离；1：正常（默认值）；>1：较长的距离 |
| `r.Shadow.DrawPreshadowFrustums` | `0` | 在启用阴影视锥体显示标志时，将预阴影视锥体可视化 |
| `r.Shadow.EnableModulatedSelfShadow` | `0` | 允许被调制的阴影影响阴影投射物。（限移动端） |
| `r.Shadow.FadeExponent` | `0.25` | 控制阴影的淡出速度 |
| `r.Shadow.FadeResolution` | `64` | 以纹素表示的分辨率，低于该值时阴影会淡出 |
| `r.Shadow.FarShadow.LODDistanceFactor` | `1` | 渲染远距离阴影时LOD选择距离的乘数 |
| `r.Shadow.FarShadowDistanceOverride` | `0` | 重载所有定向光源的远距离阴影距离 |
| `r.Shadow.FarShadowStaticMeshLODBias` | `0` | 注意：仅选定的几何体类型（静态网格体和地形）会遵循此值。 |
| `r.Shadow.FilterMethod` | `0` | 选择阴影的筛选方法。 0：统一百分比渐近筛选（PCF）（默认值）；1：百分比渐进柔和阴影（PCSS）（试验性） |
| `r.Shadow.ForceSerialSingleRenderPass` | `0` | 强制在单通道中进行串行阴影渲染。 |
| `r.Shadow.ForceSingleSampleShadowingFromStationary` | `0` | 是否强制将所有组件的行为设定为仿佛启用了bSingleSampleShadowFromStationaryLights。 这有助于在禁用动态阴影时提高可伸缩性。 |
| `r.Shadow.FreezeCamera` | `0` | 允许从外部观察系统以调试投影方法。 0：默认值；1：在当前位置冻结摄像机 |
| `r.Shadow.LightViewConvexHullCull` | `1` | 允许剔除与光源凸包外壳和视图视锥体不相交的阴影投射物。 |
| `r.Shadow.LODDistanceFactor` | `1` | 渲染常规阴影时LOD选择距离的乘数（全局） |
| `r.Shadow.LODDistanceFactor.CascadeScale` | `0` | 渲染常规阴影时LOD选择距离的乘数（随级联索引而缩放） |
| `r.Shadow.MaxCSMResolution` | `2048` | 渲染级联阴影深度时所允许的最大正方形尺寸（以纹素为单位）。范围为4至硬件极限。值越高，阴影质量越高，但性能开销也会越高。 |
| `r.Shadow.MaxCSMScrollingStaticShadowSubjects` | `5` | 滚动CSM时需要绘制的额外静态阴影主体的数量上限。 |
| `r.Shadow.MaxNumFarShadowCascades` | `10` | 可由定向光源投射的最大远距离阴影级联数 |
| `r.Shadow.MaxNumPointShadowCacheUpdatesPerFrame` | `-1` | 每帧允许的点光源阴影缓存更新次数上限。仅影响由分辨率变化引起的更新。-1表示无限制。 |
| `r.Shadow.MaxNumSpotShadowCacheUpdatesPerFrame` | `-1` | 每帧允许的聚光光源阴影缓存更新次数上限。仅影响由分辨率变化引起的更新。-1表示无限制。 |
| `r.Shadow.MaxResolution` | `2048` | 渲染阴影深度时所允许的最大正方形尺寸（以纹素为单位）。范围为4至硬件极限。值越高，阴影质量越高，但性能开销也会越高。 |
| `r.Shadow.MaxSoftKernelSize` | `40` | 软化核的最大尺寸，以像素为单位。 |
| `r.Shadow.MinDirectionalLightAngleForRTHF` | `27` |  |
| `r.Shadow.MinPreShadowResolution` | `8` | 渲染预阴影深度时所允许的最小尺寸（以纹素为单位） |
| `r.Shadow.MinResolution` | `32` | 渲染预阴影主体深度时所允许的最小尺寸（以纹素为单位） |
| `r.Shadow.Nanite` | `1` | 启用来自Nanite网格体的阴影。 |
| `r.Shadow.NaniteLODBias` | `1` | Nanite几何体在阴影中的LOD偏差。0=全细节。>0=较少细节。 |
| `r.Shadow.NaniteUpdateStreaming` | `1` | 从阴影贴图渲染中生成Nanite几何体流送的请求。 |
| `r.Shadow.NaniteUseHZB` | `1` | 为Nanite阴影启用HZB。 |
| `r.Shadow.OcclusionCullCascadedShadowMaps` | `0` | 是否为级联阴影贴图使用遮蔽剔除。 默认禁用，因为视图高速变化会导致新区域显示过快，进而导致潜在遮蔽查询无法对其进行处理。 |
| `r.Shadow.PerObject` | `1` | 是否逐对象渲染阴影（角色对世界的投影）。0：关闭；1：打开（默认） |
| `r.Shadow.PerObjectCastDistanceMin` | `32768` | 逐对象阴影的最小投影距离，即CastDistDance = Max(r.Shadow.PerObjectCastDistanceRadiusScale x object-radius, r.Shadow.PerObjectCastDistanceMin)。 默认值：UE_FLOAT_HUGE_DISTANCE / 32.0f |
| `r.Shadow.PerObjectCastDistanceRadiusScale` | `8` | 乘以对象半径的缩放系数，能计算出逐对象定向阴影所能达到的最大距离。只有在达到一定（较大）半径后才会生效。默认值为对象半径的8倍。 |
| `r.Shadow.PerObjectDirectionalDepthBias` | `10` | 由定向光源造成的逐对象阴影所使用的恒定深度偏差。值越低，阴影接触越好，但自投射阴影的瑕疵越多 |
| `r.Shadow.PerObjectDirectionalSlopeDepthBias` | `3` | 由定向光源造成的逐对象阴影所使用的斜面缩放深度偏差。值越低，阴影接触越好，但自投射阴影的瑕疵越多 |
| `r.Shadow.PerObjectSpotLightDepthBias` | `3` | 应用于深度通道的深度偏差，用于由聚光光源造成的逐对象投射阴影 |
| `r.Shadow.PerObjectSpotLightSlopeDepthBias` | `3` | 应用于深度通道的斜面缩放深度偏差，用于由聚光光源造成的逐对象投射阴影 |
| `r.Shadow.PointLightDepthBias` | `0.02` | 应用于深度通道的深度偏差，用于由点光源造成的阴影（值为0.03时能避免悬浮现象，但会造成一些阴影失真） |
| `r.Shadow.PointLightSlopeScaleDepthBias` | `3` | 应用于深度通道的斜面缩放深度偏差，用于由点光源造成的阴影。 |
| `r.Shadow.PreshadowExpand` | `0.15` | 渲染缓存预阴影时边界的扩大程度（0.15 = 扩大15%）。 |
| `r.Shadow.PreShadowFadeResolution` | `16` | 以纹素表示的分辨率，低于该值时预阴影会淡出 |
| `r.Shadow.PreShadowResolutionFactor` | `1` | 预阴影分辨率的乘数 |
| `r.Shadow.Preshadows` | `1` | 是否允许预阴影（世界对角色的静态投影） |
| `r.Shadow.PreshadowsForceLowestDetailLevel` | `0` | 启用后，静态网格体将以最低细节级别渲染为预阴影深度贴图。 默认禁用，因为这会导致质量较差的LOD（如树形公告板）出现瑕疵。 |
| `r.Shadow.RadiusThreshold` | `0.01` | 剔除过小的阴影投射物。值为最小屏幕空间边界的球体半径 |
| `r.Shadow.RecordInteractionShadowPrimitives` | `1` |  |
| `r.Shadow.RectLightDepthBias` | `0.025` | 应用于深度通道的深度偏差，用于由矩形光源造成的阴影。（值为0.03时能避免悬浮现象，但会造成一些阴影失真） |
| `r.Shadow.RectLightReceiverBias` | `0.3` | 矩形光源使用的接收偏差。值为0到1之间。 |
| `r.Shadow.RectLightSlopeScaleDepthBias` | `2.5` | 应用于深度通道的斜面缩放深度偏差，用于由矩形光源造成的阴影 |
| `r.Shadow.ResolutionScaleZeroDisablesSm` | `1` | 已废弃：如果值为1（默认值），那么阴影分辨率比例尺为0时，将禁用光源的阴影贴图。 |
| `r.Shadow.Scene.DebugDrawLightActiveStateTracking` | `0` | 。 |
| `r.Shadow.Scene.LightActiveFrameCount` | `10` | （被更新或发生变换改变的）移动光源进入非激活状态前需经过的帧数。 这将决定MobilityFactor归零的帧数，因此数值越高，无效化需要的时间越长。 |
| `r.shadow.ShadowMapsRenderEarly` | `0` | 启用后，阴影将在帧中提前渲染。这有助于某些平台上的异步计算调度。注意：与虚拟阴影贴图（VSM）不兼容 |
| `r.Shadow.ShadowMaxSlopeScaleDepthBias` | `1` | 用于所有光源阴影的最大斜面深度偏差。数值越高，自投射阴影效果越好，但自投射阴影瑕疵也越多 |
| `r.Shadow.ShouldBeginDeferredCullingAfterShadowRendering` | `1` | 临时：开启后，会在阴影深度渲染后直接开启新的实例剔除延迟范围（如果启用了实例遮蔽剔除），以绕过漏洞。 |
| `r.Shadow.SkipCullingNaniteMeshes` | `1` | 启用后，CPU剔除会忽略Nanite网格体。 |
| `r.Shadow.SpotLightDepthBias` | `3` | 应用于深度通道的深度偏差，用于由聚光光源造成的全场景投射阴影 |
| `r.Shadow.SpotLightReceiverBias` | `0.5` | 聚光光源使用的接收偏差。值为0到1之间。 |
| `r.Shadow.SpotLightSlopeDepthBias` | `3` | 应用于深度通道的斜面缩放深度偏差，用于由聚光光源造成的全场景投射阴影 |
| `r.Shadow.SpotLightTransitionScale` | `60` | 聚光光源的过渡比例 |
| `r.Shadow.StencilCulling` | `1` | 在投影期间是使用模板光源剔除（默认），还是仅使用深度。 |
| `r.Shadow.StencilOptimization` | `1` | 在测试期间将模板清零，从而消除投影之间的模板清理效果 |
| `r.Shadow.TexelsPerPixel` | `1.27324` | 逐对象阴影的主体像素和阴影纹素的比例 |
| `r.Shadow.TexelsPerPixelPointlight` | `1.27324` | 点光源的主体像素和阴影纹素的比例 |
| `r.Shadow.TexelsPerPixelRectlight` | `1.27324` | 矩形光源的主体像素和阴影纹素的比例 |
| `r.Shadow.TexelsPerPixelSpotlight` | `2.54648` | 聚光光源的主体像素和阴影纹素的比例 |
| `r.Shadow.TransitionScale` | `60` | 这将控制投射物与其阴影显示位置之间的"淡入"区域。 值越大，区域越小，自投射阴影瑕疵越多 |
| `r.Shadow.TranslucentPerObject.ProjectEnabled` | `0` | 逐项目启用或禁用半透明阴影。如果项目中存在大量半透明材质，则关闭此选项可显著减少排列数量。 |
| `r.Shadow.UnbuiltNumWholeSceneDynamicShadowCascades` | `4` | 使用CSM时要使用的动态阴影级联，以预览由定向光源产生的未编译光照 |
| `r.Shadow.UnbuiltPreviewInGame` | `1` | 是否渲染游戏中未编译的预览阴影。 若启用且未编译光照，则游戏中将渲染高成本的预览阴影。 禁用后，游戏和编辑器中的阴影将不匹配，从而造成漏洞。 |
| `r.Shadow.UnbuiltWholeSceneDynamicShadowRadius` | `200000` | 使用CSM时要使用的全场景动态阴影半径，以预览由定向光源产生的未编译光照 |
| `r.Shadow.UseOctreeForCulling` | `1` | 是否为阴影主体剔除使用图元八叉树。 八叉树可一次剔除大量图元，但会在数据结构中导致缓存缺失。 |
| `r.Shadow.Virtual.AccumulateStats` | `0` | 启用后，将在多个帧上收集VSM统计数据并写入CSV文件 |
| `r.Shadow.Virtual.AllocatePagePoolAsReservedResource` | `1` | 将VSM页面池分配为保留/虚拟的纹理，并辅以N个小型物理内存分配，以减少碎片化。 |
| `r.Shadow.Virtual.Cache` | `1` | 开启以启用缓存 |
| `r.Shadow.Virtual.Cache.AllocateViaLRU` | `0` | 在分配新请求时，优先保留最近请求的缓存物理页。 |
| `r.Shadow.Virtual.Cache.ClipmapPanning` | `1` | 启用对定向光源的平移缓存裁剪图页面的支持，从而在摄像机移动时再利用缓存数据。请在非调试的情况下保持启用此项。 |
| `r.Shadow.Virtual.Cache.DebugSkipDynamicPageInvalidation` | `0` | 在几何体移动时跳过缓存页的无效化，以便进行调试。禁用后将产生明显的视觉瑕疵。 |
| `r.Shadow.Virtual.Cache.DeformableMeshesInvalidate` | `1` | 启用后，标记为具有可变换网格体（HasDeformableMesh() == true）的图元代理会导致无效化，无论其变换是否更新。 |
| `r.Shadow.Virtual.Cache.DrawInvalidatingBounds` | `0` | 打开调试渲染缓存以使实例边界无效，并按无效页数映射热量。 1=绘制所有边界。 2=仅绘制使静态缓存页无效化的边界 3=仅绘制使动态缓存页无效化的边界 |
| `r.Shadow.Virtual.Cache.ForceInvalidateDirectional` | `0` | 强制使裁剪图始终无效，适用于模拟移动的太阳，以避免篡改缓存性能。 |
| `r.Shadow.Virtual.Cache.InvalidateUseHZB` | `1` | 启用后，将根据HZB测试实例无效化。被完全遮蔽的实例不会导致页面无效化。 |
| `r.Shadow.Virtual.Cache.MaxPageAgeSinceLastRequest` | `3` | 当前帧中可存在的未被请求缓存页的帧数上限。0 = 禁用。 |
| `r.Shadow.Virtual.Cache.StaticSeparate` | `1` | 启用后，将分别用单独的页面缓存静态对象和动态对象。 可以提高大部分静态场景的性能，但会使物理页面池的内存开销翻倍。 |
| `r.Shadow.Virtual.Cache.StaticSeparate.FramesStaticThreshold` | `100` | 对象过渡到静态缓存之前的无失效帧帧数。 |
| `r.Shadow.Virtual.Clipmap.FirstCoarseLevel` | `15` | 用于标记粗页的裁剪图的第一级。值越低，摄像机周围的粗页分辨率越高，但总页数也会越多。 |
| `r.Shadow.Virtual.Clipmap.FirstLevel` | `6` | 虚拟裁剪图的第一级。值越低，离摄像机越近的粗页分辨率越高，但总页数也可能越多。 |
| `r.Shadow.Virtual.Clipmap.GreedyLevelSelection` | `0` | 启用后，如果恰好映射了更详细的裁剪图级别，则允许对其进行充分取样。 这可以提高某些视角上的阴影质量，但会使裁剪图边界不稳定，从而加剧低阴影分辨率下的视觉瑕疵。 |
| `r.Shadow.Virtual.Clipmap.LastCoarseLevel` | `18` | 用于标记粗页的裁剪图的最后一级。值越高，可提供密集裁剪图数据的半径越大，但总页数也越多。 |
| `r.Shadow.Virtual.Clipmap.LastLevel` | `22` | 虚拟裁剪图的最后一级。间接决定裁剪图覆盖的半径。每增加一级，最大范围就翻倍一次，但可能会增加页数。 |
| `r.Shadow.Virtual.Clipmap.MinCameraViewportWidth` | `0` | 如果值大于零，则限制用于调整裁剪图分辨率的摄像机视口尺寸。 这有助于避免让动态分辨率将阴影分辨率间接地降得太低。 |
| `r.Shadow.Virtual.Clipmap.UseConservativeCulling` | `0` | 保守地剔除可移除VSM渲染的非Nanite几何体的视锥体裁剪剔除体积。这意味着被提交几何体的数量将增加，并被标记为已渲染。 有助于诊断是否因为追踪代码中的错误而导致虚拟阴影贴图裁剪图中出现了剔除瑕疵。 |
| `r.Shadow.Virtual.Clipmap.WPODisableDistance` | `1` | 启用后，将根据图元的WPO禁用距离和r.Shadow.Virtual.Clipmap.WPODisableDistance.LodBias的设置，在裁剪图级别中禁用WPO动画。 |
| `r.Shadow.Virtual.Clipmap.WPODisableDistance.LodBias` | `3` | 距离大于实例动画的裁剪图级别的数量，以允许阴影动画。 一般适合用2-4的值，但可能需要针对具有大幅WPO运动的极低光源角度进行调整。 |
| `r.Shadow.Virtual.Clipmap.ZRangeScale` | `1000` | 相对于半径的裁剪图级别深度范围的比例。影响阴影贴图在Z轴上的靠近和拉远。通常应至少为10，否则会导致过多的缓存失效。值过大会导致深度失准和阴影闪烁。 |
| `r.Shadow.Virtual.CoarsePagePixelThresholdDynamic` | `16` | 如果动态（非Nanite）实例的预计像素占用空间小于此值，则不将其绘制到粗页中。值越高，剔除的实例越多。 |
| `r.Shadow.Virtual.CoarsePagePixelThresholdDynamicNanite` | `4` | 如果动态Nanite实例的预计像素占用空间小于此值，则不将其绘制到粗页中。值越高，剔除的实例越多。 此值一般低于非Nanite实例所用的值，因为Nanite在绘制小型对象时的开销较低。 |
| `r.Shadow.Virtual.CoarsePagePixelThresholdStatic` | `1` | 如果静态（非Nanite）实例的预计像素占用空间小于此值，则不将其绘制到粗页中。值越高，剔除的实例越多。 此值一般低于非静态实例所用的值，因为静态页面的缓存更好。 |
| `r.Shadow.Virtual.CullBackfacingPixels` | `1` | 启用后，不会为背对光源的像素生成阴影数据。 |
| `r.Shadow.Virtual.DebugSkipMergePhysical` | `0` | 跳过将静态VSM缓存合并到动态VSM缓存的步骤。禁用后将产生明显的视觉瑕疵。 |
| `r.Shadow.Virtual.DistantLightForceCacheFootprintFraction` | `0` | 小数，表示占用空间的大小。低于该小数时将强制缓存被无效化（即移动或再次添加）的光源。值越大越能提高性能，但造成的可见瑕疵也越多。基础占用空间取决于页面大小。 0.0==从不强制缓存（默认值）；1.0==总是强制缓存。 |
| `r.Shadow.Virtual.DistantLightMode` | `1` | 控制是否为局部光源开启远光源模式。 0==关闭；1==打开（默认值）；2==全部强制。 开启后，像素占用空间低于阈值的光源将被标记为远光源。远光源的更新受到限制（强制缓存），它们使用更简单的页表逻辑，并且内存开销更低。 |
| `r.Shadow.Virtual.DynamicRes.MaxPagePoolLoadFactor` | `0.85` | 如果分配量超出了页面池总容量的指定系数，阴影分辨率将会向下调整。0=禁用 |
| `r.Shadow.Virtual.DynamicRes.MaxResolutionLodBias` | `2` | 随着页面分配量接近池容量，通过向上调整LOD来降低VSM分辨率。这就类似于 'ResolutionLodBiasDirectional' 的方式。 这是针对全局动态阴影分辨率下降而限制的最大LOD偏差。0=禁用 |
| `r.Shadow.Virtual.Enable` | `1` | 启用虚拟阴影贴图。将几何体渲染到虚拟化阴影深度贴图中以投射阴影。 为次世代项目提供高质量阴影以及简化的设置。搭配Nanite使用时能高效剔除。 |
| `r.Shadow.Virtual.ForceFullHZBUpdate` | `0` | 强制逐帧进行完整的HZB更新，而不仅仅是更新脏页。 |
| `r.Shadow.Virtual.ForceOnlyVirtualShadowMaps` | `1` | 启用后，则禁止为任何具有虚拟阴影贴图的光源创建传统的非虚拟阴影贴图。 这可以提高性能并节省内存，但任何无法渲染到虚拟阴影贴图中的几何图元都将无法投射阴影。 |
| `r.Shadow.Virtual.ForcePerLightShadowMaskClear` | `0` | 用于调试。启用后，将在投影通道写入前就清除阴影遮罩纹理。投影通道写入所有相关像素，因此不需要进行清除。 |
| `r.Shadow.Virtual.MarkCoarsePagesDirectional` | `1` | 在定向光源虚拟阴影贴图中标记粗页，从而让低分辨率数据随处可用。保留禁用功能主要是为了分析和调试。 |
| `r.Shadow.Virtual.MarkCoarsePagesLocal` | `1` | 在局部光源虚拟阴影贴图中标记粗页，从而让低分辨率数据随处可用。保留禁用功能主要是为了分析和调试。 |
| `r.Shadow.Virtual.MarkPixelPages` | `1` | 根据深度缓冲区像素在虚拟阴影贴图中标记页面。保留禁用功能主要是为了分析和调试。 |
| `r.Shadow.Virtual.MarkPixelPagesMipModeLocal` | `0` | 启用后，将使用Mip的子集来减少VSM中的实例重复。能够提高性能，但Mip过渡的衰减会更严重。 0 - 禁用：使用所有8个Mip；1 - 质量模式：使用4个高分辨率Mip（16k、4k、1k、256）；2 - 性能模式：使用4个低分辨率Mip（8k、2k、512、128） |
| `r.Shadow.Virtual.MaxDistantUpdatePerFrame` | `1` | 每帧更新的远光源数量上限。可在后续帧中更新错过的无效光源（循环）。 |
| `r.Shadow.Virtual.MaxPhysicalPages` | `4096` | 池中的物理页数上限。 页数越大则内存占用越大，但阴影分辨率越高。 理想情况下，值应该会大到足以容纳场景中所有光源的足够页数，但又不能大到浪费内存的地步。 启用"ShowStats"以查看目前分配到池中的页数。 更多关于页面池控制的信息，见"ResolutionLodBias*"、"DynamicRes.*"和"Cache.StaticSeparate"等控制台变量。 |
| `r.Shadow.Virtual.Nanite.MaterialVisibility` | `0` | 启用Nanite CPU端对绘制命令的可见性过滤。需要启用r.Nanite.MaterialVisibility。 |
| `r.Shadow.Virtual.NonNanite.Batch` | `1` | 。 |
| `r.Shadow.Virtual.NonNanite.CulledInstanceAllocationFactor` | `1` | 用于存储剔除后实例的缓冲区的分配大小比例因子。 总大小需考虑最坏情况，即所有实例都被发射到了所有裁剪或Mip级别中。 这将远远超出合理的预期，因此请使用此调整系数来减少内存压力。 由于剔除会针对每个重叠的裁剪/Mip级别发射一个实例，因此无法知道CPU端实际数量。 设为1.0是完全保守的。除非确定缓冲区不会溢出，否则降低该值可能会产生瑕疵。 |
| `r.Shadow.Virtual.NonNanite.IncludeInCoarsePages` | `1` | 在粗页中包含非Nanite几何体。将非Nanite几何体渲染到大型粗页中的开销较高。禁用此功能可以显著提高性能。 |
| `r.Shadow.Virtual.NonNanite.LargeInstancePageAreaThreshold` | `-1` | 将多大的面积算做"大"占用空间，计入所有重叠关卡，如果设为-1，则将物理页池大小除以8。 用作在存储页面区域覆盖率统计数据时的诊断阈值。 |
| `r.Shadow.Virtual.NonNanite.MaxCulledInstanceAllocationSize` | `134217728` | 可从剔除通道输出到所有VSM Mip/裁剪级别的实例的数量上限。以每个实例引用12字节计算，这代表着1.5GB的限制。 |
| `r.Shadow.Virtual.NonNanite.NumPageAreaDiagSlots` | `0` | 诊断中用于报告页面面积覆盖范围最大的非Nanite实例的插槽数量。若值小于0，使用最大数量，等于0则禁用。 |
| `r.Shadow.Virtual.NonNanite.SinglePassBatched` | `1` | 。 |
| `r.Shadow.Virtual.NonNanite.UseHZB` | `2` | 使用HZB剔除非Nanite实例。 值为0时禁用。 值为1时，使用上一帧的HZB。某些情况下可能会因数据过时而导致剔除错误。 值为2时，使用当前帧的HZB进行双通道Nanite剔除。 |
| `r.Shadow.Virtual.NonNaniteVSM` | `1` | 启用对非Nanite虚拟阴影贴图的支持。只读且需在配置文件中设置（要求重启）。 |
| `r.Shadow.Virtual.NormalBias` | `0.5` | 接收器沿表面法线的偏移，可用于查找阴影。根据与摄像机的距离而调整。较大的值可避免在几乎与光线平行的表面上产生瑕疵，也可以避免可视性偏移阴影，并增加击中未映射页面的几率。 |
| `r.Shadow.Virtual.OnePassProjection` | `1` | 在单个通道中投射所有局部光源虚拟阴影贴图，以实现更好的性能。 |
| `r.Shadow.Virtual.OnePassProjection.MaxLightsPerPixel` | `16` | 使用单通道投影和集群着色时，获得完全过滤的逐像素最大光源数量。一般值为8（32bpp）、16（64bpp）或32（128bpp）。值越低，在光照通道期间需要的临时VRAM越少。 |
| `r.Shadow.Virtual.OnePassProjection.SkipScreenShadowMask` | `1` | 允许在仅单个虚拟阴影贴图写入屏幕空间阴影遮罩时，完全跳过屏幕空间阴影遮罩。 通常应该在非调试的情况下保持启用。 |
| `r.Shadow.Virtual.PageDilationBorderSizeDirectional` | `0.05` | 如果屏幕像素落在定向光源页面边框的这一部分内，则相邻页面也将被映射。值越高越能减少屏幕边缘或去遮挡处的页面缺失，但会增加总页数。 |
| `r.Shadow.Virtual.PageDilationBorderSizeLocal` | `0.05` | 如果屏幕像素落在局部光源页面边框的这一部分内，则相邻页面也将被映射。值越高越能减少屏幕边缘或去遮挡处的页面缺失，但会增加总页数。 |
| `r.Shadow.Virtual.PageMarkingPixelStrideX` | `2` | 在页面标记期间，测试每第N个像素，而不是测试每个屏幕像素。 用来自屏幕像素的页面标记确定摄像机可以看到并需要渲染的VSM页面。 增加此值可以减少页面标记开销，但可能会因缺少页面而导致瑕疵。 如果值足够低，则相邻像素很可能会标记所需的页面。 |
| `r.Shadow.Virtual.PageMarkingPixelStrideY` | `2` | 与PageMarkingPixelStrideX相同，但作用于屏幕的垂直轴上。 |
| `r.Shadow.Virtual.ResolutionLodBiasDirectional` | `-1.5` | 对定向光源的LOD计算应用的偏差值。值为-1.0则将分辨率翻倍；值为1则将其减半，依次类推。 |
| `r.Shadow.Virtual.ResolutionLodBiasDirectionalMoving` | `-1.5` | 对移动中定向光源的LOD计算应用的偏差值。值为-1.0则将分辨率翻倍；值为1则将其减半，依次类推。 当光源过渡为非移动状态时，偏差值会平稳过渡回ResolutionLodBiasDirectional的值。详见"r.Shadow.Scene.LightActiveFrameCount"。 |
| `r.Shadow.Virtual.ResolutionLodBiasLocal` | `0` | 对局部光源的LOD计算应用的偏差值。值为-1.0则将分辨率翻倍；值为1则将其减半，依次类推。 |
| `r.Shadow.Virtual.ResolutionLodBiasLocalMoving` | `1` | 对移动中局部光源的LOD计算应用的偏差值。值为-1.0则将分辨率翻倍；值为1则将其减半，依次类推。 当光源过渡为非移动状态时，偏差值会平稳过渡回ResolutionLodBiasLocal的值。详见"r.Shadow.Scene.LightActiveFrameCount"。 |
| `r.Shadow.Virtual.ScreenRayLength` | `0.015` | 在VSM/SMRT查找之前远离接收器表面的屏幕空间阴影追踪的长度（智能阴影偏差）。 |
| `r.Shadow.Virtual.ShowClipmapStats` | `-1` | 请将值设置为要显示统计信息的裁剪图的数量（-1==关闭）。 |
| `r.Shadow.Virtual.ShowLightDrawEvents` | `0` | 启用虚拟阴影贴图的逐光源绘制事件 - 可能会影响性能，尤其是当场景中有许多小型光源时。 |
| `r.Shadow.Virtual.ShowStats` | `0` | 显示VSM统计数据。 |
| `r.Shadow.Virtual.SMRT.AdaptiveRayCount` | `1` | 对完全阴影和无阴影区域发射更少的光线。目前仅支持OnePassProjection。 |
| `r.Shadow.Virtual.SMRT.ExtrapolateMaxSlopeDirectional` | `5` | 在定向光源的遮挡物后方外插值时的深度倾斜率上限。 值越高，半影边缘越柔和，但可能会在第二个遮挡物后面造成漏光。 值为0时可禁用倾斜率外插值，从而略微提高投影性能，代价是半影质量会降低。 |
| `r.Shadow.Virtual.SMRT.ExtrapolateMaxSlopeLocal` | `0.05` | 在局部光源的遮挡物后方外插值时的深度倾斜率上限。 值越高，半影边缘越柔和，但可能会在第二个遮挡物后面造成漏光。 值为0时可禁用倾斜率外插值，从而略微提高投影性能，代价是半影质量会降低。 |
| `r.Shadow.Virtual.SMRT.MaxRayAngleFromLight` | `0.03` | 对于局部光源而言，光线从光源角度可扩散的最大角度（以弧度为单位）。角度越小，阴影半影的屏幕空间大小越小。角度越大，噪点越多。 |
| `r.Shadow.Virtual.SMRT.MaxSlopeBiasLocal` | `50` | 深度倾斜率上限。如果阴影分辨率不足，若值过低，则会产生瑕疵。若值过高，则可能加剧遮挡物附近的漏光和阴影区域中像素的闪烁。 |
| `r.Shadow.Virtual.SMRT.RayCountDirectional` | `8` | 定向光源阴影贴图追踪的光线数量。0=禁用。 |
| `r.Shadow.Virtual.SMRT.RayCountLocal` | `8` | 局部光源阴影贴图追踪的光线数量。0=禁用。 |
| `r.Shadow.Virtual.SMRT.RayLengthScaleDirectional` | `1.5` | 定向光源发射的光线长度，根据与相机的距离进行调整。光线越短，阴影半影的屏幕空间尺寸越小。光线越长，需要的取样越多，以避免阴影与接触点失去连接。 |
| `r.Shadow.Virtual.SMRT.SamplesPerRayDirectional` | `4` | 定向光源的逐光线阴影贴图取样数 |
| `r.Shadow.Virtual.SMRT.SamplesPerRayLocal` | `4` | 局部光源的逐光线阴影贴图取样数 |
| `r.Shadow.Virtual.SMRT.TexelDitherScaleDirectional` | `2` | 对定向光源的阴影贴图光线投射应用抖动，以帮助隐藏由于阴影分辨率不足而导致的锯齿。 将值设置得过高可能导致遮挡物附近出现阴影漏光。 |
| `r.Shadow.Virtual.SMRT.TexelDitherScaleLocal` | `2` | 对局部光源的阴影贴图光线投射应用抖动，以帮助隐藏由于阴影分辨率不足而导致的锯齿。 将值设置得过高可能导致遮挡物附近出现阴影漏光。 |
| `r.Shadow.Virtual.SubsurfaceShadowMinSourceAngle` | `5` | 用于拥有定向光源的次表面材质阴影和透光率的最小光源角度（以度为单位）。 为了给拥有次表面的材质模拟光的漫反射，VSM可以根据材质的不透明度扩大光源半径。 值越高，这些材质的阴影就越弥散。 |
| `r.Shadow.Virtual.TranslucentQuality` | `0` | 有光照半透明表面的阴影质量。这将应用于所有半透明表面，并带来很大的性能影响。 将值设为1以启用高质量模式。 |
| `r.Shadow.Virtual.UseFarShadowCulling` | `1` | 开关VSM远距离阴影剔除逻辑的实现。 |
| `r.Shadow.Virtual.UseHZB` | `2` | 为（Nanite）虚拟阴影贴图启用HZB - 非Nanite虚拟阴影贴图有不同语意的单独标记：r.Shadow.Virtual.NonNanite.UseHZB。 0 - 无HZB遮蔽剔除；1 - 近似单通道HZB遮蔽剔除（使用前一帧HZB）；2 - 双通道遮蔽剔除（默认值）。 |
| `r.Shadow.Virtual.Visualize` |  | 当视口的查看模式为"虚拟阴影贴图可视化（Virtual Shadow Map Visualization）"时，此命令指定具体显示哪一条通道。除下面所示允许值之外的输入值将被忽略。 mask、mip、vpage、cache、naniteoverdraw、raycount、dirty、invalid、merged、debug、clipmapvirtual |
| `r.Shadow.Virtual.Visualize.Advanced` | `0` | 启用以在可视化UI菜单中显示高级VSM调试模式。 |
| `r.Shadow.Virtual.Visualize.Layout` | `0` | 启用虚拟阴影贴图可视化时的覆层布局： 0：全屏；1：缩略图；2：分屏 |
| `r.Shadow.Virtual.Visualize.LightName` |  | 设置待可视化的指定光源的名称（供开发人员在非发布构建中使用）。 |
| `r.Shadow.WholeSceneShadowCacheMb` | `150` | 可用于缓存全场景阴影的内存量。 单帧中的阴影贴图分配可能会导致溢出。 |
| `r.Shadow.WholeSceneShadowUnbuiltInteractionThreshold` | `500` | 单个光源可以拥有的未编译的光源-图元交互次数，超过此次数后，光源将切换为全场景阴影 |
| `r.ShadowQuality` | `5` | 定义允许调整质量或性能的阴影方法。 0：关闭；1：低（不过滤）；2：低……5：最高（默认值） |

### 骨骼网格体

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.SkeletalMesh.KeepMobileMinLODSettingOnDesktop` | `0` | 如果非零，则移动端最小LOD的设置将存储在桌面平台的烘焙数据中 |
| `r.SkeletalMesh.LODMaterialReference` | `1` | 材质是否需要被至少一个未精简的网格体LOD引用才会被视为已使用。 |
| `r.SkeletalMesh.MinLodQualityLevel` | `-1` | 最小精简LOD的质量级别。 |
| `r.SkeletalMesh.StripMinLodDataDuringCooking` | `0` | 启用后，会在烘焙过程中删除目标平台最小可渲染LOD下的骨骼网格体LOD。 |
| `r.SkeletalMeshClothBlend.Enabled` | `true` | 启用由骨骼网格体组件设置的布料混合权重值。启用后，所有布料混合的权重将变为0。 |
| `r.SkeletalMeshLODBias` | `0` | 骨骼网格体的LOD偏差值（不影响动画编辑器视口）。 |
| `r.SkeletalMeshLODRadiusScale` | `1` | 用于计算骨骼网格体的离散LOD的屏幕半径的比例系数。（0.25-1） |
| `r.SkeletalMeshReductionModule` | `SkeletalMeshReduction` | 要选择的骨骼网格体缩减模块的名称。如果为空，则选择任何存在的模块。 |

### 皮肤缓存

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.SkinCache.Allow` | `true` | 是否允许启用GPU皮肤缓存系统。 |
| `r.SkinCache.AllowDupedVertsForRecomputeTangents` | `0` | 0：关闭（默认值）；1：强制对同一位置的顶点进行不同的处理，可能在顶点分割时导致裂缝。 |
| `r.SkinCache.Capture` | `0` | 为下一次皮肤缓存调度触发渲染捕获。 |
| `r.SkinCache.CompileShaders` | `0` | 是否编译GPU计算蒙皮缓存着色器。 这将编译着色器，以便在计算作业上蒙皮，而不在顶点着色器上蒙皮。 如果发生变化，则需要修改GPUSkinVertexFactory.usf以进行重新编译。 0表示关闭（默认值），1表示开启 |
| `r.SkinCache.Debug` | `1` | 传递给SkinCache着色器的缩放常数，适用于调试 |
| `r.SkinCache.DefaultBehavior` | `1` | 所有骨骼网格体都被包含在皮肤缓存中或从皮肤缓存中排除时的默认行为。如果在网格体上启用"支持光线追踪（Support Ray Tracing）"，将在该网格体上强制采用包容行为。 互斥（0）：所有骨骼网格体都从皮肤缓存中排除。每个网格体必须单独选择加入。 兼容（1）：所有骨骼网格体都包含到皮肤缓存中。每个网格体必须单独选择退出。（默认值） |
| `r.SkinCache.MaxDispatchesPerCmdList` | `0` | 被批量处理到单个命令列表中的计算着色器调度的数量上限，用于修复潜在的超时检测和恢复（TDR）。 |
| `r.SkinCache.MaxRayTracingPrimitivesPerCmdList` | `-1` | 被批量处理到单个命令列表中的图元数量上限，用于修复潜在的超时检测和恢复（TDR）。 |
| `r.SkinCache.MemoryLimitForBatchedRayTracingGeometryUpdates` | `512` |  |
| `r.SkinCache.Mode` | `1` | 是否使用GPU计算蒙皮缓存。 这将在计算作业上蒙皮，而不在顶点着色器上蒙皮。 要求r.SkinCache.CompileShaders=1且r.SkinCache.Allow=1。0：关闭；1：开启（默认值） |
| `r.SkinCache.NumTangentIntermediateBuffers` | `1` | 重新计算切线时要使用多少个中间缓冲区来存储中间结果；值越大越可能让GPU重叠计算作业。 |
| `r.SkinCache.PrintMemorySummary` | `0` | 打印内存占用明细。0：关闭（默认值）；1：内存不足时打印；2：逐帧打印 |
| `r.SkinCache.RayTracingUseTransientForScratch` | `0` | 使用临时内存进行BLAS临时分配，以减少内存占用和分配开销。 |
| `r.SkinCache.RecomputeTangents` | `2` | 此选项允许用GPU重新计算顶点切线。 可在运行时更改，要求both r.SkinCache.CompileShaders=1、r.SkinCache.Mode=1且r.SkinCache.Allow=1。0：关闭；1：开启，强制所有蒙皮对象重新计算切线；2：开启，仅重新计算勾选了"重新计算切线（Recompute Tangents）"复选框的蒙皮对象的切线（默认值） |
| `r.SkinCache.RecomputeTangentsParallelDispatch` | `0` | 此选项可以启用重新计算切线的并行调度。 0：关闭（默认值），三角形通道与顶点通道交叉存取，要求中间存在资源屏障。 1：开启，一起调度三角形通道、资源屏障和顶点通道。消耗更多内存。 |
| `r.SkinCache.SceneMemoryLimitInMB` | `128` | 每个世界/场景可分配的内存上限，以兆字节为单位 |
| `r.SkinCache.SkipCompilingGPUSkinVF` | `false` | 削减GPU皮肤顶点工厂的着色器排列。关闭皮肤缓存时，无法禁用此选项。 False（0）：编译所有GPU皮肤顶点工厂变体。 True（1）：不编译所有GPU皮肤顶点工厂变体。 |
| `r.SkinCache.Visualize` |  | 指定要显示的可视化模式："概览（Overview）"、"内存（Memory）"。 |

### 天空大气

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.SkyAtmosphere` | `1` | 若值不为0，则渲染天空大气组件，否则忽略。 |
| `r.SkyAtmosphere.AerialPerspective.DepthTest` | `1` | 启用后，将使用深度测试，从而避免写入比StartDepth更接近摄像机的像素，进而有效提高性能。 |
| `r.SkyAtmosphere.AerialPerspectiveLUT.Depth` | `96` | LUT的长度，以公里为单位（默认值=96km，能为默认天空带来良好的远处云/大气互动）。距离大于此值时，将使用最后的切片。 |
| `r.SkyAtmosphere.AerialPerspectiveLUT.DepthResolution` | `16` | 用于空中透视体积纹理的深度切片的数量。 |
| `r.SkyAtmosphere.AerialPerspectiveLUT.FastApplyOnOpaque` | `1` | 启用后，包含大气雾的低分辨率摄像机视锥体/Froxel体积（通常用于半透明表面的雾）将用于渲染不透明物体上的雾。 这样速度更快，但是假如有一些高频细节，例如地面阴影或散射光晕，则可能导致视觉瑕疵。 |
| `r.SkyAtmosphere.AerialPerspectiveLUT.SampleCountMaxPerSlice` | `4` | 每个切片中用于对空气透视求值的取样数。有效取样数通常较低，具体取决于组件上的SampleCountScale以及.ini文件，以及 摄像机视锥体空间Froxel中的散射和透光率。 |
| `r.SkyAtmosphere.AerialPerspectiveLUT.Width` | `32` |  |
| `r.SkyAtmosphere.DistanceToSampleCountMax` | `150` | 以公里为单位的距离，超出此距离后将使用SampleCountMax取样对大气进行光线行进。 |
| `r.SkyAtmosphere.DistantSkyLightLUT` | `1` | 支持生成天空环境光照值。 |
| `r.SkyAtmosphere.DistantSkyLightLUT.Altitude` | `6` | 采集天空样本以融合天空光照的高度。默认为6km，即典型卷云的高度。 |
| `r.SkyAtmosphere.EditorNotifications` | `1` | 启用编辑器内通知的渲染，向用户警告画面上缺少天空球像素的情况。最好将其保持启用，发售时将删除。 |
| `r.SkyAtmosphere.FastSkyLUT` | `1` | 启用后，将使用查找纹理来渲染天空。 这样速度更快，但假如天空中有一些高频细节，例如地面阴影或散射光晕，则可能导致视觉瑕疵。 |
| `r.SkyAtmosphere.FastSkyLUT.DistanceToSampleCountMax` | `150` | 以公里为单位的快速天空距离，超出此距离后，将使用SampleCountMax取样对大气进行光线行进。 |
| `r.SkyAtmosphere.FastSkyLUT.Height` | `104` |  |
| `r.SkyAtmosphere.FastSkyLUT.SampleCountMax` | `128` | 用于计算天空/大气散射和透光率的快速天空取样数上限。 用于计算FastSkyLUT散射的取样数上限。有效取样数通常较低，具体取决于组件上的距离和SampleCountScale以及.ini文件。 最小值限定为r.SkyAtmosphere.FastSkyLUT.SampleCountMin+1。 |
| `r.SkyAtmosphere.FastSkyLUT.SampleCountMin` | `4` | 用于计算天空/大气散射和透光率的快速天空取样数下限。 最小值限定为1。 |
| `r.SkyAtmosphere.FastSkyLUT.Width` | `192` |  |
| `r.SkyAtmosphere.LUT32` | `0` | 为所有天空LUT使用完整的32位逐通道精度。 |
| `r.SkyAtmosphere.MultiScatteringLUT.Height` | `32` |  |
| `r.SkyAtmosphere.MultiScatteringLUT.HighQuality` | `0` | 启用后，将使用64个取样数，而非2个，从而获得更精确的多重散射近似（但开销也更高）。 |
| `r.SkyAtmosphere.MultiScatteringLUT.SampleCount` | `15` | 用于对多重散射求值的取样数。 |
| `r.SkyAtmosphere.MultiScatteringLUT.Width` | `32` |  |
| `r.SkyAtmosphere.SampleCountMax` | `128` | 用于计算天空/大气散射和透光率的取样数上限。有效取样数通常较低，具体取决于组件上的距离和SampleCountScale以及.ini文件。 最小值限定为r.SkyAtmosphere.SampleCountMin+1。 |
| `r.SkyAtmosphere.SampleCountMin` | `4` | 用于计算天空/大气散射和透光率的取样数下限。 最小值限定为1。 |
| `r.SkyAtmosphere.SampleLightShadowmap` | `1` | 启用大气光源阴影贴图的取样，以便生成体积阴影。 |
| `r.SkyAtmosphere.TransmittanceLUT` | `1` | 启用天空透光率的生成。 |
| `r.SkyAtmosphere.TransmittanceLUT.Height` | `64` |  |
| `r.SkyAtmosphere.TransmittanceLUT.SampleCount` | `10` | 用于对透光率的取样数求值。 |
| `r.SkyAtmosphere.TransmittanceLUT.UseSmallFormat` | `0` | 若为true，透光率LUT将使用较小的R8BG8B8A8格式，以较低质量存储数据。 |
| `r.SkyAtmosphere.TransmittanceLUT.Width` | `256` |  |
| `r.SkyAtmosphereASyncCompute` | `0` | 异步计算时的SkyAtmosphere（默认值为false）。在异步管线上运行时，SkyAtmosphere的LUT的生成将与遮蔽通道重叠。 |

### 天空光照

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.SkyLight.CubemapMaxResolution` | `-1` | 强制使用天空光照立方体贴图最大分辨率（默认值为-1：使用USkyLightComponent::CubeMapResolution的默认属性值）。 |
| `r.SkyLight.RealTimeReflectionCapture` | `1` | 确保不会在超出预算的平台上运行天空光照实时捕获。无法在运行时更改。 |
| `r.SkyLight.RealTimeReflectionCapture.DepthBuffer` | `1` | 启用后，实时天空光捕获将拥有深度缓冲区，从而使多个网格体能够正确地相互覆盖。同时将根据深度缓冲区应用高度雾。 |
| `r.SkyLight.RealTimeReflectionCapture.ShadowFromOpaque` | `0` | 启用后，不透明网格体会将定向光源造成的阴影投射到天空和云层上。 |
| `r.SkyLight.RealTimeReflectionCapture.TimeSlice` | `1` | 启用后，实时天空光捕获和卷积将分布到多个帧上，以降低每帧的开销。 |
| `r.SkyLight.RealTimeReflectionCapture.TimeSlice.SkyCloudCubeFacePerFrame` | `6` | 启用后，（被时间切片后的）实时天空光照捕获不会在单帧中渲染立方体所有面上的云，而是每帧渲染一个面。这是为了进一步分摊云追踪的成本。但这会增加延迟，并且如果太阳移动得很快，还可能导致不同面之间出现光照差异。取值范围为[1,6]。 |
| `r.SkylightCapture.LODDistanceScale` | `1` | 天空光照捕获的LODDistanceScale。默认值为1，负值将被限定为1 |
| `r.SkyLightingQuality` | `1` | 天空光照的质量，可用于调整性能。 <=0：关闭（最快）；1：开启 |
| `r.SkylightIntensityMultiplier` | `1` | 固定和可移动天空光照的强度等级。 适用于控制游戏的整体光照对比度，这种游戏应用了动态光照，且附带可禁用环境光遮蔽的可伸缩性级别。 例如，若中等质量设置会禁用SSAO和DFAO，则降低天空光照的强度。 |
| `r.SkylightUpdateEveryFrame` | `0` | 是否逐帧更新所有天空光照。 适合用于调试。 |
| `r.SkySpecularOcclusionStrength` | `1` | DFAO的天空光照高光度遮蔽强度（默认值为1.0） |

### 稀疏体积纹理

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.SparseVolumeTexture.RemoteDDCBehavior` | `0` | 控制稀疏体积纹理（SVT）对远程DDC的用法。0：bLocalDDCOnly属性控制逐SVT的缓存行为，1：强制所有SVT仅使用本地DDC；2：强制所有SVT使用本地+远程DDC |
| `r.SparseVolumeTexture.Streaming.AsyncCompute` | `1` | 在异步计算队列中安排GPU工作。 |
| `r.SparseVolumeTexture.Streaming.AsyncThread` | `1` | 用异步工作线程执行大部分SVT流送，而不是用渲染线程。 |
| `r.SparseVolumeTexture.Streaming.BandwidthLimit` | `512` | SVT流送的带宽限制，单位为兆字节每秒（MiB/s）。当请求超过此限制时，系统将改用较低的Mip级别进行流送。 |
| `r.SparseVolumeTexture.Streaming.DDCChunkSize` | `2` | 流送数据在被分割为DDC数据块后的大小（单位为MiB）。数值越小，请求越多，但流送性能越高。默认值：2 MiB |
| `r.SparseVolumeTexture.Streaming.EmptyPhysicalTileTextures` | `0` | 向外流送所有物理图块纹理的所有可流送图块。 |
| `r.SparseVolumeTexture.Streaming.ForceBlockingRequests` | `0` | 启用后，所有SVT流送请求将在完成时被拦截，以保证请求的Mip级别在请求的同一帧中可用（如果流送的内存足够）。 |
| `r.SparseVolumeTexture.Streaming.ForceEstimateFrameRate` | `0` | 强制流送系统始终估计SVT的播放帧率，而不是使用流送请求所传入的指定帧率。适用于进行调试。 |
| `r.SparseVolumeTexture.Streaming.InstanceCleanupThreshold` | `5` | 在未使用的流送实例被清理前，SVT流送系统可等待的更新次数。流送实例是一种内部记录对象，用于跟踪SVT资产在给定上下文中的播放。默认值：5 |
| `r.SparseVolumeTexture.Streaming.InstanceWindowSize` | `5` | SVT帧中的窗口期长度，该窗口期内，对该SVT的请求将被视为属于同一实例。流送实例是一种内部记录对象，用于跟踪SVT资产在给定上下文中的播放。默认值：5.0 |
| `r.SparseVolumeTexture.Streaming.LogVerbosity` | `1` | 0：不记录；1：基本记录；2：额外记录（可能导致垃圾记录）；3：记录一切（必定导致垃圾记录） |
| `r.SparseVolumeTexture.Streaming.MaxPendingRequests` | `8192` | 可等待安装的IO请求数上限。 |
| `r.SparseVolumeTexture.Streaming.PrintMemoryStats` | `0` | 打印流送系统中注册的所有SVT的所有帧的内存大小。 |
| `r.SparseVolumeTexture.Streaming.RequestMipBias` | `1` | 将计算出的Mip级别应用于流送的偏差。可用于解释为何根据投影屏幕空间大小进行的Mip预估数值非常保守。根据经验，默认值1.0将导致体素与像素的比率大致为1：1。 |
| `r.SparseVolumeTexture.Streaming.RequestSize` | `-1` | 以千字节（KiB）为单位的IO请求大小。SVT流送管理器将尝试大致以此大小创建IO请求。默认值：-1（无限制） |
| `r.SparseVolumeTexture.Streaming.RequestSizeGranularity` | `131072` | 将计算出的流送请求大小向上舍入为该值的倍数（以字节为单位）。这能让系统在发送多个非常小的请求时避免出现性能问题。 |
| `r.SparseVolumeTexture.Streaming.ReservedResourcesMemoryLimit` | `-1` | 使用预留资源时，流送池纹理的内存上限（以MiB为单位）。如果不设限，则理论上可以分配巨量的内存。设为-1即可禁用限制。默认值：-1 |
| `r.SparseVolumeTexture.Streaming.ShowDebugInfo` | `0` | 将有关流送SVT实例的调试信息打印到屏幕上。 |
| `r.SparseVolumeTexture.Streaming.UseReservedResources` | `1` | 将SVT图块数据纹理（流送池）分配为保留/虚拟的纹理，并辅以N个小型物理内存分配，以减少碎片化。这将解除2GB的资源大小限制，并能在分配纹理时更好地管理GPU内存。 |

### 样条线网格体

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.SplineMesh.NoRecreateProxy` | `1` | 优化功能。如果值为true，则不会在样条网格体代理每次发生更改时重新创建。而是仅仅更新。 |
| `r.SplineMesh.RenderNanite` | `1` | 如果值为true且网格体上启用，则允许将样条线网格体作为Nanite渲染（否则使用退却网格体）。 |
| `r.SplineMesh.SceneTextures` | `1` | 是否将场景中的所有样条线网格体的样条缓存到纹理中（性能优化选项）。 |
| `r.SplineMesh.SceneTextures.CaptureNextUpdate` | `0` | 将值设为1以捕获下一个样条网格体纹理的更新。若值大于1，则捕获之后的第N个更新。 |
| `r.SplineMesh.SceneTextures.ForceUpdate` | `0` | 若值为true，则逐帧强制更新整个样条线网格体的场景纹理（用于调试）。 |
| `r.SplineMesh.SceneTextures.InstanceIDUploadCopy` | `true` | 若值为true，则将在缓冲区上传时复制已注册的实例ID。 |
| `r.SSGI.LeakFreeReprojection` | `1` | 是否使用开销更大但无泄漏的前一帧场景颜色重新投影。 |
| `r.SSGI.MinimumLuminance` | `0.5` |  |
| `r.SSGI.Quality` | `3` | 质量设置项，用于控制使用SSGI拍摄的光线数量，值在1到4之间（默认值为4）。 |
| `r.SSGI.RejectUncertainRays` | `1` | 如果屏幕空间光线因为位于屏幕几何体之后而出现不确定性，则拒绝屏幕空间光线。 |
| `r.SSGI.SkyDistance` | `1e+07` | 天空的距离，单位为公里。 |
| `r.SSGI.TerminateCertainRay` | `1` | 优化项。如果屏幕空间光线确定且未找到任何几何体，则不回退到任何其他追踪技术。 |
| `r.SSProfiles.Transmission.UseLegacy` | `1` | 0：使用物理效果更为正确的透射轮廓。 1.使用旧版透射轮廓（默认值）。 |
| `r.SSProfilesPreIntegratedTextureForceUpdate` | `0` | 0：仅按需更新预集成的纹理。 1：强制更新预集成的纹理，以进行调试。 |
| `r.SSProfilesPreIntegratedTextureResolution` | `64` | 次表面轮廓预集成纹理的分辨率。 |
| `r.SSProfilesSamplingChannelSelection` | `1` | 0：根据最大DMFP选择取样通道。 1：根据最大MFP选择取样通道。 |
| `r.SSR.ExperimentalDenoiser` | `0` | 用降噪器替换SSR的TAA通道。 |
| `r.SSR.HalfResSceneColor` | `0` | 用半分辨率场景颜色作为SSR的输入。在不造成太多视觉质量损失的情况下提高性能。 |
| `r.SSR.MaxRoughness` | `-1` | 允许重载后期处理设置项ScreenSpaceReflectionMaxRoughness。 将决定淡化屏幕空间反射的粗糙度临界值。0.8是合适的值，值越小运行越快。 （可用于测试，无可伸缩性或项目设置）。0至1：使用指定的最大粗糙度（重载PostprocessVolume的设置）；-1：不重载（默认值） |
| `r.SSR.Quality` | `3` | 是否使用屏幕空间反射以及使用何种质量设置。 （限制后期处理设置中比例不同的设置）（会降低性能，增加视觉效果真实度，但该技术有局限性）。0：关闭（默认值）；1：低（无光泽）；2：中（无光泽）；3：高（有光泽/使用粗糙度，取样数少）；4：非常高（可能对实时而言过慢） |
| `r.SSR.Stencil` | `0` | 是否为屏幕空间反射应用模板预通道。0表示关闭（默认值），1表示开启 |
| `r.SSR.Temporal` | `0` | 是否为屏幕空间反射应用时间平滑。0表示关闭（用于调试），1表示开启（默认值） |
| `r.SSR.TiledComposite` | `0` | 启用屏幕空间反射的平铺优化。 |
| `r.SSR.TiledComposite.MinSpecular` | `0` | 忽略高光反射贡献非常小的像素，以防最大粗糙度无法将其过滤 |
| `r.SSR.TiledComposite.OverrideMaxRoughness` | `-1` | 忽略粗糙度大于此值的像素。值<0：使用由FinalPostProcessSettings的ScreenSpaceReflectionMaxRoughness派生的值。 |
| `r.SSR.TiledComposite.TwoSidedFoliage` | `0` | 0：若启用了平铺，则禁用植被的SSR。 |
| `r.SSR.TiledComposite.Visualize` | `false` | 1：将平铺区域可视化。 |
| `r.SSS.Burley.AlwaysUpdateParametersFromSeparable` | `0` | 0：当程序加载时，不更新参数。（默认值）1：当程序加载时，始终从可分离部分更新。（仅当次表面颜色为1时更正）。 |
| `r.SSS.Burley.BilateralFilterKernelFunctionType` | `1` | 0：仅深度。性能更好（近景快2倍）。1：深度和法线。提高眼睑等区域的质量。（默认值） |
| `r.SSS.Burley.EnableProfileIdCache` | `1` | 0：禁用取样通道中使用的轮廓ID缓存。 1：每像素多消耗1字节内存，从而加速Burley通道。（默认值） |
| `r.SSS.Burley.MinGenerateMipsTileCount` | `4000` | 4000.（默认值）。可触发次表面辐射Mip生成的图块数量下限。将值设为0以始终生成Mip（试验性数值） |
| `r.SSS.Burley.NumSamplesOverride` | `0` | 如果为零，Burley次表面散射（SSS）将自适应地确定取样数。如果非零，此数值将重载取样数。 |
| `r.SSS.Burley.Quality` | `1` | 0：退却模式。为了改善性能，Burley会退回到在可分离部分中运行带Burley透射的散射。将自动匹配可分离参数。1：自动。次表面将仅转换为折半分辨率的可分离部分。（默认值） |
| `r.SSS.Checkerboard` | `2` | 启用或禁用棋盘格渲染进行次表面轮廓渲染。 如果SceneColor不包含浮点Alpha通道（如32位格式），则必需启用。0: 禁用（高质量）。若渲染目标格式无Alpha通道（如PF_FloatR11G11B10），则会造成次表面散射过度褪色。 1：启用（低质量）。表面光照将使用被降低的分辨率。 2：自动。如果存在合适的渲染目标格式，则应用非棋盘格光照 |
| `r.SSS.Checkerboard.NeighborSSSValidation` | `0` | 启用或禁用棋盘格邻域次表面散射验证。 此项验证可以消除泄漏到次表面散射中的边界光源，从而创建颜色正确的清晰边界。0：禁用（默认） 1：启用。添加1次次表面轮廓ID查询/像素（低质量），为重组通道添加4次ID查询/像素（高质量） |
| `r.SSS.Filter` | `1` | 定义屏幕空间次表面散射功能的过滤方法。 0：点过滤器（适用于测试，可以更干净）；1：双线性过滤器 |
| `r.SSS.HalfRes` | `0` | 0：完整质量（结合了Burley和可分离通道。不优化可分离部分，而是将其作为引用）；1：部分算法以折半分辨率运行，质量更低但速度更快（默认值，仅可分离部分） |
| `r.SSS.Quality` | `1` | 使用SubsurfaceScatteringProfile着色模型时的重组通道的质量。0：低（更快，默认值）；1：高（细节更清晰但更慢）；-1：自动，若禁用时间抗锯齿则为1（不使用时间抗锯齿时质量更显而易见） |
| `r.SSS.SampleSet` | `2` | 定义可分离屏幕空间次表面散射功能的取样数。 0：最低质量（6*2+1）；1：中等质量（9*2+1）；2：高质量（13*2+1）（默认值） |
| `r.SSS.Scale` | `1` | 影响屏幕空间可分离次表面散射的通道（使用着色模型SubsurfaceProfile，靠近对象，因为默认是人体皮肤，只散射约1.2厘米）。0：关闭（如果屏幕上没有对象使用此通道，则自动禁用后期处理通道）；<1：缩小散射半径（用于测试）；1：使用次表面散射资产的给定半径（默认值）；>1：扩大散射半径（用于测试） |
| `r.SSS.SubSurfaceColorAsTansmittanceAtDistance` | `0.15` | 规格化的距离（0至1），在此距离上，表面颜色被解译为透光颜色，以计算消光系数。 |

### 静态网格体

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.StaticMesh.DisableThreadedBuild` | `0` | 激活以强制用单线程编译静态网格体。 |
| `r.StaticMesh.EnableSaveGeneratedLODsInPackage` | `0` | 启用将生成的LOD保存到包中的功能。 0 - 不保存（并隐藏此菜单选项）[默认值]。 1 - 启用此选项并将LOD保存到包中。 |
| `r.StaticMesh.KeepMobileMinLODSettingOnDesktop` | `0` | 如果非零，则移动端最小LOD的设置将存储在桌面平台的烘焙数据中 |
| `r.StaticMesh.MinLodQualityLevel` | `-1` | 最小精简LOD的质量级别。 |
| `r.StaticMesh.StripDistanceFieldDataDuringLoad` | `0` | 如果非零，则在加载时丢弃距离场的数据。待办：改为在烘焙期间丢弃！ |
| `r.StaticMesh.StripMinLodDataDuringCooking` | `0` | 如果非零，则在烘焙时丢弃低于最小LOD的静态网格体LOD级别数据 |
| `r.StaticMesh.UpdateMeshLODGroupSettingsAtLoad` | `0` | 启用后，将在加载时应用静态网格体的LODGroup设置。 |
| `r.StaticMeshLODDistanceScale` | `1` | 用于计算静态网格体的离散LOD的距离的比例系数。（默认值为1）（值越高LOD过渡越早，例如值为2时速度加倍/距离减半） |

### 流送

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.Streaming.AllowFastForceResident` | `0` | 是否允许尽快为快速强制驻留资产加载缺失的Mip。有利于加速强制驻留的进程，但有可能干扰流送指标的计算。即使超出预算，也不能牺牲快速强制驻留Mip，所以请谨慎使用。 |
| `r.Streaming.AllowParallelStreamingRenderAssets` | `0` | 是否允许使用ParallelFor执行UpdateStreamingRenderAssets，以使用更多核心。 |
| `r.Streaming.AllowUpdateResourceSize` | `false` | 允许更新资源大小 |
| `r.Streaming.AmortizeCPUToGPUCopy` | `0` | 若设置，且r.Streaming.MaxNumTexturesToStreamPerFrame大于0，则限制每帧从CPU内存流向GPU内存的2D纹理数量 |
| `r.Streaming.Boost` | `1` | =1.0：正常；<1.0：降低需要的Mip级别；>1.0：提高需要的Mip级别 |
| `r.Streaming.CheckBuildStatus` | `0` | 如果非零，则引擎将检查是否需要重新编译纹理流送。 |
| `r.Streaming.DefaultNoRefLODBias` | `0` | 无引用网格体的默认LOD偏差 |
| `r.Streaming.DeferredRemoveDynamicInstances` | `1` | 是否推迟从动态实例管理器中移除组件，以避免组件注销时游戏线程出现卡顿。 |
| `r.Streaming.DefragDynamicBounds` | `1` | 如果非零，未使用的动态边界将从更新循环中删除 |
| `r.Streaming.DropMips` | `0` | 0：不丢弃任何Mip；1：丢弃缓存的Mip；2：丢弃缓存的和隐藏的Mip；3：丢弃缓存的Mip和无引用网格体的非内联LOD |
| `r.Streaming.EnableAutoDetectNoStreamableTextures` | `1` | 在烘焙时间自动检测无可流送纹理的图元组件。也可在运行时关闭，以跳过优化。 |
| `r.Streaming.FlushDeferredMipLevelChangeCallbacksBeforeGC` | `1` | 是否在垃圾回收前清空延迟的Mip级别更改回调。 |
| `r.Streaming.FlushTimeOut` | `3` | 清空流送前的超时时间（默认值=3）。 |
| `r.Streaming.FramesForFullUpdate` | `5` | 逐帧对纹理流送进行时间切片。该值表示访问所有纹理所需的帧数。 |
| `r.Streaming.FullyLoadMeshes` | `0` | 如果非零，则向内流送所有网格体LOD。这样即可无需重新烘焙就半禁用网格体LOD流送。 |
| `r.Streaming.FullyLoadUsedTextures` | `0` | 如果非零，则将尽快向内流送所有使用过的纹理 |
| `r.Streaming.HiddenPrimitiveScale` | `0.5` | 定义不在范围内时需应用的分辨率比例。 0.5：丢弃1个Mip；1：忽略可视性 |
| `r.Streaming.HLODStrategy` | `0` | 定义HLOD流送策略。 0：流送；1：仅流送Mip 0；2：禁用流送 |
| `r.Streaming.LimitPoolSizeToVRAM` | `0` | 如果非零，则纹理池大小将被限制为可用的GPU内存大小。 |
| `r.Streaming.LowResHandlingMode` | `0` | 如何处理缺失了过多Mip或LOD的资产。0（默认值）：不处理；1：在正常流送请求前加载；2：在异步加载预缓存请求之前加载。 |
| `r.Streaming.MaxEffectiveScreenSize` | `0` | 0：使用当前实际垂直屏幕尺寸；>0：将所需的Mip尺寸计算限制为垂直屏幕尺寸组件的指定值。 |
| `r.Streaming.MaxHiddenPrimitiveViewBoost` | `1.5` | 可影响隐藏图元的最大视图增强率。 可防止临时小型视野向各自的最高Mip流送所有纹理。 |
| `r.Streaming.MaxNumTexturesToStreamPerFrame` | `0` | 每帧可从CPU内存流向GPU内存的2D纹理的数量上限。<=0表示无限制。如果不设置r.Streaming.AmortizeCPUToGPUCopy，则不生效 |
| `r.Streaming.MaxReferenceChecksBeforeStreamOut` | `2` | 引擎在强制向外流送前等待引用释放的次数。（默认值=2） |
| `r.Streaming.MaxTempMemoryAllowed` | `50` | 向内或向外流送纹理Mip时使用的临时内存大小上限。 此内存包含更新后的纹理所用的Mip。 内存量应够大，以避免影响流送速度。 |
| `r.Streaming.MaxTextureUVDensity` | `0` | 如果非零，则表示静态条目的最大UV密度。 用于按MinLevelTextureScreenSize优化关卡剔除。 拥有更大条目的组件将按动态组件处理。 |
| `r.Streaming.MinBoost` | `0` | r.Streaming.Boost的最小限制值 |
| `r.Streaming.MinLevelRenderAssetScreenSize` | `100` | 如果非零，则只有当关卡所引用的纹理需要为此大小时，才会对该关卡进行处理。请对关卡的数据使用保守的指标。 |
| `r.Streaming.MinMipForSplitRequest` | `10` | 如果非零，则表示加载请求优先加载可见Mip时的最小隐藏Mip |
| `r.Streaming.MipBias` | `0` | 值为0至X。表示按浮点数降低流送的纹理质量。 0：使用完整分辨率（默认值）；1：丢弃1个Mip；2：丢弃两个Mip |
| `r.Streaming.MipCalculationEnablePerLevelList` | `1` | 如果非零，则计算被流送纹理的Mip大小时，将使用与之相引用的关卡（而非逐关卡进行迭代）。 |
| `r.Streaming.NoRefLODBiasQualityLevel` | `-1` | 无引用网格体流送LOD偏差的质量级别 |
| `r.Streaming.NumStaticComponentsProcessedPerFrame` | `50` | 如果非零，则表示在关卡可见前，引擎为增量插入关卡而将逐帧处理的组件数量 |
| `r.Streaming.OverlapAssetAndLevelTicks` | `0` | 用游戏线程更新关卡的同时，在高优先级任务线程上对渲染资产流送信息进行更新（Tick）的更新数 |
| `r.Streaming.ParallelRenderAssetsNumWorkgroups` | `2` | 更新ParellelRenderAsset所用的工作组数量。可以进一步细分工作，从而减少等待时间。但是值过高会增加游戏线程的开销。 |
| `r.Streaming.PerTextureBiasViewBoostThreshold` | `1.5` | 将增加逐纹理偏差的视图增强率上限。 可防止临时小型视野永久性地降低纹理质量。 |
| `r.Streaming.PoolSize` | `1000` | -1：默认纹理池大小，否则为以MB表示的大小 |
| `r.Streaming.PoolSize.VRAMPercentageClamp` | `1024` | 使用PoolSizeVRAMPercentage时，预留内存的最大容量（单位为MB）。 能避免拥有大量VRAM的系统预留过多内存。（默认值=1024） |
| `r.Streaming.PoolSizeForMeshes` | `-1` | <0：网格体和纹理共用一个池。否则为网格体专用池的大小。 |
| `r.Streaming.PrioritizeMeshLODRetention` | `1` | 是否优先保留网格体LOD |
| `r.Streaming.ProcessAddedRenderAssetsAfterAsyncWork` | `1` | 完成异步工作后，是否在随后的UpdateResourceStreaming阶段调用ProcessAddedRenderAssets。 |
| `r.Streaming.StressTest` | `0` | 将值设为非零，即可对流送更新进行压力测试。 负值也将减慢IO的速度。 |
| `r.Streaming.StressTest.ExtaIOLatency` | `10` | 在进行压力测试时，每个数据流送输入请求的额外延迟（毫秒）。 |
| `r.Streaming.StressTest.ExtraAsyncLatency` | `0` | 在进行压力测试时，每个异步任务的额外延迟（毫秒）。 |
| `r.Streaming.StressTest.FramesForFullUpdate` | `1` | 在进行压力测试时，更新纹理状态所需的帧数。 |
| `r.Streaming.SyncStatesWhenBlocking` | `0` | 如果值为true，则调用SyncStates，以在清空未完成的流送请求之前完全更新异步状态。由影片渲染队列使用，确保每一帧都能处理所有流送请求，从而避免弹出。 |
| `r.Streaming.UseAllMips` | `0` | 如果非零，则使用所有可用的Mip |
| `r.Streaming.UseAsyncRequestsForDDC` | `1` | 是否使用异步DDC请求，从而对取消和暂停渲染请求做出快速反应（默认值=0） |
| `r.Streaming.UseBackgroundThreadPool` | `1` | 如果值为true，则为Mip计算使用后台线程池。 |
| `r.Streaming.UseFixedPoolSize` | `0` | 如果非零，则不允许在运行时更改池的大小。 |
| `r.Streaming.UseGenericStreamingPath` | `0` | 控制何时使用Mip数据提供者的实现：（默认值=0）0表示若存在自定义资产重载，则使用。 1表示始终使用。 2表示从不使用。 |
| `r.Streaming.UseMaterialData` | `1` | 如果非零，则使用材质纹理比例和坐标 |
| `r.Streaming.UseMobileLODBiasOnDesktopES31` | `1` | 设置后，在ES31模式下运行时，在桌面平台上应用移动端最小LOD偏差 |
| `r.Streaming.UseNewMetrics` | `1` | 如果非零，则使用优化的度量标准和启发法。 |
| `r.Streaming.UsePerTextureBias` | `1` | 如果非零，每个纹理将按需分配一个介于0和MipBias之间的Mip偏差，以适应预算。 |
| `r.Streaming.UseTextureStreamingBuiltData` | `1` | 打开或关闭纹理流送编译数据的使用（0表示关闭）。 |

### Substrate

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.Substrate` | `0` | 启用Substrate材质（Beta）。 |
| `r.Substrate.AllocationMode` | `1` | Substrate资源分配模式。 0：按视图要求分配资源；1：按视图要求分配资源，但只能随帧数增长，以尽量减少资源重新分配和卡顿；2：按平台设置分配资源。 |
| `r.Substrate.AsyncClassification` | `1` | 异步运行Substrate材质的分类（带阴影）。 |
| `r.Substrate.BytesPerPixel` | `80` | Substrate为存储材质数据而逐像素分配的字节数量。值越高，可表示的材质越复杂。 |
| `r.Substrate.ClosuresPerPixel` | `8` | 可逐像素约束的Substrate封装数量。不仅有助于减少基础通道中写入的字节数，还能限制前向封装的数量。值越高，可表示的材质越复杂。 |
| `r.Substrate.DBufferPass` | `0` | 在基础通道后应用单独的DBuffer通道。只读，因为更改后需要重新编译所有着色器。 |
| `r.Substrate.DBufferPass.DedicatedTiles` | `0` | 启用DBuffer通道后，为DBuffer应用程序使用专用图块。 |
| `r.Substrate.Debug.AdvancedVisualizationShaders` | `0` | 启用高级Substrate材质调试可视化着色器。基础通道着色器可以输出此类高级数据。 |
| `r.Substrate.Debug.PeelLayersAboveDepth` | `0` | Substrate调试控制，可逐层渐进式剥离材质。 |
| `r.Substrate.Debug.RoughnessTracking` | `1` | 用于禁用粗糙度追踪的Substrate调试控制，例如让顶层粗糙度影响底层粗糙度，从而模拟光源的散射。 |
| `r.Substrate.Glints` | `1` | 为Substrate Slab启用闪光（Glint）的支持。更改后，着色器需要进行重新编译。 |
| `r.Substrate.Glints.LevelBias` | `0` | 持续调整闪光等级。负值加强闪光效果，正值减弱闪光效果。请谨慎对待，应该这可能造成锯齿。 |
| `r.Substrate.Glints.LevelMin` | `0` | 用于渲染闪光的最小闪光等级。主要影响远距离表面。如果数值大于0，则会强制让闪光始终可见，而不是使用解析BSDF。请谨慎对待，应该这可能造成锯齿。 |
| `r.Substrate.Glints.LUT` | `1` | 选择一个闪光渲染LUT进行测试。 |
| `r.Substrate.OpaqueMaterialRoughRefraction` | `0` | 启用Substrate不透明材质上层对下层的粗糙折射效果。 |
| `r.Substrate.OpaqueMaterialRoughRefraction.BlurScale` | `1` | 调整不透明粗糙折射强度，以便进行调试。 |
| `r.Substrate.RoughDiffuse` | `1` | 启用Substrate粗糙漫反射模型（要求在项目设置中启用r.Material.RoughDiffuse）。可在运行时切换 |
| `r.Substrate.ShadingQuality` | `1` | Substrate着色质量（1：精确光照；2：近似光照）。此变量为只读。 |
| `r.Substrate.SheenQuality` | `1` | Substrate光泽质量（1：基于Disney的光泽；2：基于Charlie的光泽）。r.Substrate.ShadingQuality=2将使光泽质量强制为2。此变量为只读。 |
| `r.Substrate.SpecularProfile` | `1` | 为Substrate Slab启用高光度轮廓的支持。更改后，着色器需要进行重新编译。 |
| `r.Substrate.SpecularProfile.ForceUpdate` | `0` | 0：仅按需更新高光度轮廓。 1：强制逐帧更新高光度轮廓，以便进行调试。 |
| `r.Substrate.SpecularProfile.Resolution` | `64` | 高光度轮廓纹理的分辨率。 |
| `r.Substrate.TileCoord8bits` | `0` | 图块坐标的格式。此变量为只读。 |
| `r.Substrate.UseClosureCountFromMaterial` | `1` | 启用后，可根据材质数据缩放多重曝光像素的Lumen层数。否则使用r.Substrate.ClosuresPerPixel。 |
| `r.Substrate.UseCmaskClear` | `0` | 测试。 |
| `r.SubstrateBackCompatibility` | `0` | 禁用Substrate多重散射，并用Lambert替换Chan漫反射。 |
| `r.SubsurfaceScattering` | `1` | 0：禁用 1：启用（默认） |

### 支持

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.SupportAllShaderPermutations` | `0` | 本地用户配置重载，强制开启所有着色器排列功能。 |
| `r.SupportCloudShadowOnForwardLitTranslucent` | `0` | 使云阴影可以影响所有半透明表面，且不依赖半透明光照体积。 |
| `r.SupportDepthOnlyIndexBuffers` | `1` | 启用仅深度索引缓冲区。能节省少量时间，但索引缓冲区的大小会翻倍。 |
| `r.SupportLocalFogVolumes` | `1` | 启用局部雾体积渲染和着色器代码。 |
| `r.SupportLowQualityLightmaps` | `1` | 支持低质量光照贴图着色器排列 |
| `r.SupportPointLightWholeSceneShadows` | `1` | 启用投影点光源。 |
| `r.SupportReversedIndexBuffers` | `1` | 启用反向索引缓冲区。能节省少量时间，但索引缓冲区的大小会翻倍。 |
| `r.SupportSkyAtmosphere` | `1` | 启用天空大气渲染和着色器代码。 |
| `r.SupportSkyAtmosphereAffectsHeightFog` | `1` | 允许天空大气影响高度雾。要求r.SupportSkyAtmosphere为true。 |
| `r.SupportStationarySkylight` | `1` | 启用静态和动态天空光照着色器排列。 |
| `r.SupportsTexture2DArrayStreaming` | `true` | 启用Texture2DArray流送的支持 |
| `r.SupportsVolumeTextureStreaming` | `true` | 启用体积纹理流送的支持 |

### 时间抗锯齿

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.TemporalAA.Debug.OverrideTemporalIndex` | `-1` | 重载时间索引，以便进行调试。 |
| `r.TemporalAA.HistoryScreenPercentage` | `100` | 时间抗锯齿历史记录的大小。 |
| `r.TemporalAA.Mobile.UseCompute` | `1` | 0：使用像素着色器，在平铺GPU上通过FBC节省带宽；1：使用计算着色器（默认值）； |
| `r.TemporalAA.Quality` | `2` | 主要时间抗锯齿通道的质量。 0：禁用输入过滤；1：启用输入过滤；2：启用更多输入过滤，并启用基于移动性的抗重影（默认值）；3：质量1的输入过滤，并启用抗重影 |
| `r.TemporalAA.R11G11B10History` | `1` | 选择历史记录的位宽。 |
| `r.TemporalAA.Upsampling` | `1` | 是否使用时间抗锯齿执行主屏幕百分比。 0：使用独立于时间抗锯齿的空间分辨率修改通道；1：时间抗锯齿将时间和空间分辨率修改作为屏幕百分比方法（默认值）。 |
| `r.TemporalAA.Upscaler` | `1` | 选择分辨率修改算法。 0：强制使用渲染器的默认时间分辨率修改器；1：GTemporalUpscaler，可能会被第三方插件重载（默认值）。 |
| `r.TemporalAA.UseMobileConfig` | `0` | 1表示使用移动端TAA配置。这将禁用颜色和深度缓冲区的组共享缓存。 0：禁用（默认值）； 1：启用； |
| `r.TemporalAACatmullRom` | `0` | 是否使用Catmull-Rom过滤器核心。应该略微比高斯过滤器锐利。 |
| `r.TemporalAACurrentFrameWeight` | `0.04` | 当前帧对历史记录贡献的权重。 低值会造成模糊和重影，高值会无法隐藏抖动。 |
| `r.TemporalAAFilterSize` | `1` | 过滤器核心的大小。（1.0=更平滑；0.0=更锐利，但存在锯齿）。 |
| `r.TemporalAAPauseCorrect` | `1` | 在暂停时更正时间抗锯齿。能更长时间地保留渲染目标，防止重复使用，但会消耗更多内存。 |
| `r.TemporalAASamples` | `8` | 时间抗锯齿抖动位置的数量（4、8=默认值、16、32、64）。 |

### 测试

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.Test.Aplha.OpaqueLerpWorldRange` | `100` | 以世界单位设置梯度长度，用于将不透明像素插值为半透明像素，以便进行测试。 |
| `r.Test.Aplha.OpaqueWorldDistance` | `0` | 距离世界距离，超过此距离后将不透明像素插值为半透明像素，以便进行测试。 |
| `r.Test.CameraCut` | `0` | 强制启用镜头切换，以便进行测试。 0：禁用（默认值）；1：启用。 |
| `r.Test.ConstrainedView` | `0` | 允许测试使用过场动画或编辑器时可能发生的不同视口矩形配置（限游戏中）。 0：关闭（默认值）；1至7：各种配置 |
| `r.Test.DynamicResolutionHell` | `0` | 为所有存在动态分辨率难题的视图族重载屏幕百分比界面。 0：关闭（默认值）；1：动态分辨率难题。 |
| `r.Test.EditorConstrainedView` | `0` | 允许测试使用过场动画或编辑器时可能发生的不同视口矩形配置（限游戏中）。 0：关闭（默认值）；1至7：各种配置 |
| `r.Test.ForceBlackVelocityBuffer` | `0` | 强制让速度缓冲区不包含运动向量，以便进行调试。 |
| `r.Test.FreezeTemporalHistories` | `0` | 冻结所有时间历史记录和时间序列。 |
| `r.Test.FreezeTemporalHistories.Progress` | `0` | 修改后，将时间历史记录向前推进一帧。 |
| `r.Test.FreezeTemporalSequences` | `0` | 冻结所有时间序列。 |
| `r.Test.OverrideTimeMaterialExpressions` | `-1` | 用于冻结材质表达式的数值。 |
| `r.Test.PrimaryScreenPercentageMethodOverride` | `0` | 为所有视图族重载屏幕百分比方法。 0：由视图族的屏幕百分比界面选择（默认值）；1：在UI前的最末端进行老式的分辨率修改处理；2：时间抗锯齿向上取样。 |
| `r.Test.SecondaryUpscaleOverride` | `0` | 重载二级分辨率修改。 0：禁用（默认值)；1：使用0.5作为二级视图分数和最接近的二级分辨率修改。 |
| `r.Test.ViewRectOffset` | `0` | 在渲染器的内部渲染目标中移动视图矩形。 0：禁用（默认值）； |
| `r.TexelDebugging` | `0` | 在编辑器中按T+鼠标左键是否会选择光照贴图纹素，以便调试Lightmass。 必须重新编译Lightmass并启用 ALLOW_LIGHTMAP_SAMPLE_DEBUGGING，才能使其正常工作。 |

### 纹理

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.TextureProfiler.EnableRenderTargetCSV` | `true` | 将值设为true以为所有渲染目标启用CSV分析器。 |
| `r.TextureProfiler.EnableTextureCSV` | `true` | 将值设为true以为所有纹理启用CSV分析器。 不包括渲染目标。 |
| `r.TextureProfiler.MinRenderTargetSizeMB` | `0` | 待报告渲染目标的最小合计尺寸。 小于此阈值的合计尺寸将被报告为其他（Other）。 |
| `r.TextureProfiler.MinTextureSizeMB` | `16` | 待报告纹理的最小尺寸。 小于此阈值的所有纹理将被报告为其他（Other）。 |
| `r.TextureReferenceRevertsLastRenderContainer` | `1` |  |
| `r.TexturesComputeChannelMinMaxDuringSave` | `0` | 是否由纹理决定在保存早期格式计算时各通道的最小/最大值。 |
| `r.TexturesCookToDerivedDataReferences` | `0` | 是否使用派生数据引用对烘焙纹理进行序列化。 |
| `r.TextureStreaming` | `1` | 允许决定是否启用纹理流送，可以在运行时更改此设置。 0：关闭 1：打开（默认） |

### 色调映射器

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.Tonemapper.Quality` | `5` | 色调映射器的质量，范围为0至5。可按所选的设置选择更快的着色器排列。0：仅基本色调映射器，最低质量；2：+渐晕；4：+粒度；5：+粒度抖动=完整质量（默认值） |
| `r.Tonemapper.Sharpen` | `-1` | 色调映射器的锐化（移动端不可用），实际实现仍处于开发中，值上限为10。<0：继承PostProcessVolume的设置（默认值）；0：关闭；0.5：一半强度；1：完整强度 |
| `r.TonemapperGamma` | `0` | 0：默认行为；#：使用固定的伽马数值，而不是sRGB或Rec709的变换 |

### 半透明

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.Translucency.AutoBeforeDOF` | `0.5` | 如果在焦距之后，自动将景深之后的半透明放入景深之前（试验性）。 |
| `r.Translucency.DynamicRes.ChangePercentageThreshold` | `2` | 改变半透明分辨率时允许的最小增加百分比阈值。 |
| `r.Translucency.DynamicRes.MaxScreenPercentage` | `100` | 半透明的最大屏幕百分比。 |
| `r.Translucency.DynamicRes.MinScreenPercentage` | `50` | 半透明的最小屏幕百分比。 |
| `r.Translucency.DynamicRes.TargetedHeadRoomPercentage` | `5` | 半透明的目标GPU余量（占r.DynamicRes.DynamicRes.TimeBudget的百分比）。 |
| `r.Translucency.DynamicRes.TimeBudget` | `0` | 帧的半透明渲染时间预算，以毫秒为单位。 |
| `r.Translucency.DynamicRes.UpperBoundQuantization` | `0` | 用于上限屏幕百分比的量化步数。 如果非零，则渲染目标将根据动态分辨率分数调整大小，从而节省清除和解析期间的GPU时间。 仅推荐（在支持的平台上）搭配附带大容量临时纹理缓存的临时分配器使用（例如RHI.TransientAllocator.TextureCacheSize=512）。 |
| `r.Translucency.HeterogeneousVolumes` | `0` | 在渲染半透明时启用异类体积合成（默认值=0） |
| `r.Translucency.ScreenPercentage.Basis` | `0` | 半透明屏幕百分比的基础（试验性）。 0：使用主视图的分辨率（特别是使用r.ScreenPercentage和r.DynamicRes.*进行缩放） 1：使用二级视图的分辨率（时间分辨率修改输出的分辨率） |
| `r.Translucency.StandardSeparated` | `0` | 在不同于场景颜色的独立缓冲区中渲染半透明网格体。 可以防止这些网格体的自我折射，或在本应受透光色影响的边缘处泄漏场景颜色。 当r.SeparateTranslucency为0时强制禁用。 |
| `r.Translucency.Velocity` | `1` | 是否可绘制半透明深度或速度（默认启用） |
| `r.TranslucencyLightingVolumeDim` | `64` | 半透明光照所用体积纹理的尺寸。 纹理越大，分辨率越高，但性能越低。 |
| `r.TranslucencyLightingVolumeInnerDistance` | `1500` | 第一个体积级联结束时与摄像机的距离 |
| `r.TranslucencyLightingVolumeOuterDistance` | `5000` | 第二个体积级联结束时与摄像机的距离 |
| `r.TranslucencyVolumeBlur` | `1` | 是否模糊半透明光照体积。 0：关闭，否则打开，默认值为1 |
| `r.Translucent.UsesIESProfiles` | `0` | 为半透明表面启用IES描述文件的支持。启用后，将为像素着色器添加一个外部取样器（对基于DX11的系统限定为16） |
| `r.Translucent.UsesLightFunctionAtlas` | `0` | 启用使用正向着色对半透明材质上的光源函数图集进行取样。 |
| `r.Translucent.UsesRectLights` | `0` | 为半透明表面启用矩形光源的支持。启用后，将为像素着色器添加一个外部取样器（对基于DX11的系统限定为16） |
| `r.TranslucentLightingVolume` | `1` | 是否允许更新半透明光照体积。 0：关闭，否则打开，默认值为1 |
| `r.TranslucentSortPolicy` | `0` | 0：根据摄像机中心点到边界球体中心点的距离进行排序。（默认值，最适合3D游戏）；1：根据与摄像机的投影距离进行排序。 2：根据在固定轴上的投影进行排序。（最适合2D游戏） |
| `r.TranslucentVolumeFOVSnapFactor` | `10` | 计算体积边界前，视野会被调整为本数值的系数。 |
| `r.TranslucentVolumeMinFOV` | `45` | 半透明光照体积的最小视野。 防止在放大时照明突然光照。 |

### 时间超级分辨率

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.TSR.16BitVALU` | `1` | 是否在具有bSupportRealTypes=RuntimeDependent的平台上使用16位VALU |
| `r.TSR.16BitVALU.AMD` | `1` | 重载是否在AMD桌面GPU上使用16位VALU |
| `r.TSR.16BitVALU.Intel` | `1` | 重载是否在英特尔桌面GPU上使用16位VALU |
| `r.TSR.16BitVALU.Nvidia` | `0` | 重载是否在英伟达桌面GPU上使用16位VALU |
| `r.TSR.AplhaChannel` | `-1` | 控制TSR是否应该处理场景颜色的Alpha通道。 -1：基于r.PostProcessing.PropagateAlpha（默认值）；0：禁用。1：启用。 |
| `r.TSR.AsyncCompute` | `2` | 决定TSR如何在异步计算上运行。一些TSR通道可以与之前的通道重叠。 0：禁用； 1：在仅异步计算的通道上运行，这些通道完全独立于此帧的任何中间资源，即ClearPrevTextures和ForwardScatterDepth；2：在仅异步计算的通道上运行，这些通道完全独立或仅依赖于深度和速度缓冲区，缓冲区可以重叠，例如半透明和景深。关键路径上的通道都保留在图形队列中（默认值）；3：在所有通道上运行异步计算； |
| `r.TSR.Debug.ArraySize` | `1` | TSR.Debug的数组大小。*RGD纹理 |
| `r.TSR.ForceSeparateTranslucency` | `1` | 若启用TSR则始终重载r.SeparateTranslucency（默认启用）。 |
| `r.TSR.History.R11G11B10` | `1` | 选择历史记录的位深度。若r.TSR.History.R11G11B10=1，则通过在前一帧的历史记录重新投影以及输出和新历史记录的写出时节省内存，来节省内存带宽，这对于TSR的UpdateHistory运行时性能特别重要。 r.PostProcessing.PropagateAlpha=1时不支持此优化。 另外请注意，由于从TSR历史分辨率到TSR输出分辨率的降级通道，如果将r.TSR.History.ScreenPercentage增加到200，那么与TSR输出的位深度相比，会在历史记录中增加2个额外的隐式编码位。 |
| `r.TSR.History.SampleCount` | `16` | 历史记录中单个输出像素的取样数上限。值越高，静态图像上的高光越稳定，但可能会在某些VFX萤火虫样式上造成额外的重影。由于之前的TSR版本为5.0和5.1，支持的最小值为8.0。由于TSR.History.Metadata的编码原因，最大值为32.0。默认值为16.0。 使用命令"r.TSR.Visualize 0"即可查看屏幕上的TSR历史记录区域累积的取样数。 |
| `r.TSR.History.ScreenPercentage` | `200` | 基于输出分辨率的TSR历史记录的分辨率乘数。提高分辨率会增加TSR的运行时开销，但可以在整个重新投影过程中保持历史记录存储细节的锐度和稳定性。 若值为200即可得到一个特定的属性，该属性依赖NyQuist-Shannon取样定理，为历史记录累积细节的取样率建立了充分条件。因此，仅支持100到200之间的值。 此值默认由抗锯齿可伸缩性组控制。超高（Epic）和电影级（Cinematic）质量级别为200，而其他质量级别为100。 |
| `r.TSR.History.UpdateQuality` | `3` | 选择TSRHistoryUpdate通道中历史记录更新质量的着色器排列。目前由sg.AntiAliasingQuality可伸缩性组驱动。如需详细了解各组提供的内容，请参阅TSRUpdateHistory.usf中的DIM_UPDATE_QUALITY，并按需进行自定义。 |
| `r.TSR.RejectionAntiAliasingQuality` | `2` | 当需要拒绝历史记录时，决定TSR内置空间抗锯齿技术的质量。当渲染分辨率未比显示分辨率低太多时，这一点并不重要，但这种技术对于隐藏较低的渲染分辨率至关重要，原因有二：一是锯齿的屏幕空间大小与渲染分辨率成反比；二是若以较低的分辨率渲染，则需要花费更多帧，才能让每个显示像素至少对应一个渲染像素。使用命令"r.TSR.Visualize 6"即可在屏幕上查看空间抗锯齿选项以绿色快速显示的位置。默认情况下，仅在低抗锯齿可伸缩性组中默认禁用。 |
| `r.TSR.Resurrection` | `1` | 允许TSR恢复很多帧之前丢弃的细节。 启用后，TSR的所有帧都会存储在唯一的Texture2DArray中，其中包括可配置数量的持久帧。（具体由r.TSR.Resurrection.PersistentFrameCount决定）。这些帧会被按周期记录（具体由r.TSR.Resurrection.PersistentFrameInterval决定）。 然后TSR将逐帧尝试重新投影前一帧，或与当前帧最匹配的最早持久帧。当TSR之前看到的内容再次出现时（不管是视差解除遮挡、着色变化还是半透明视觉特效移动），就会出现后一种情况。这样做的好处是，只需恢复之前积累的细节，就不必重新做第二次积累。 使用命令"r.TSR.Visualize 4"即可以绿色显示TSR正在恢复的部分屏幕。 使用命令"r.TSR.Visualize 5"即可查看可恢复的最早帧。 目前为试验性功能，默认禁用。 |
| `r.TSR.Resurrection.PersistentFrameCount` | `2` | 配置记录到历史记录中的持久帧的数量，以便将来恢复历史记录。这会增加整个TSR历史记录的内存占用。此值必须是大于或等于2的偶数。（默认值=2） |
| `r.TSR.Resurrection.PersistentFrameInterval` | `31` | 配置（以帧数为单位）持久帧应在历史记录中记录的频率，以便将来恢复历史记录。对TSR历史记录的内存占用没有影响。此值必须是大于或等于1的奇数。使用显示标志"VisualizeTSR"和r.TSR.Visualize=5按内容调整此参数。（默认值=31） |
| `r.TSR.ShadingRejection.ExposureOffset` | `3` | 着色拒绝需要对线性颜色像素最终向用户显示的亮度有一个具象的理解。通过与MeasureBackbufferLDRQuantizationError()进行比较，着色拒绝可以检测颜色何时变为在后缓冲区中可见。 必须让TSR的MeasureBackbufferLDRQuantizationError()在颜色强度范围内均匀分布，否则可能会忽略导致重影的一些细微VFX。 此变量仅在TSR的拒绝启发法中调整线性颜色空间的曝光。高值会提升阴影的LDR强度，意味着MeasureBackbufferLDRQuantizationError()会在这些阴影中减少，而在高光中增加，并直接控制。 验证这一点的最佳TSR内部缓冲区是TSR.Flickering.Luminance，可以使用显示" VisualizeTemporalUpscaler" 命令，或在DumpGPU中使用RGBLinear[0;1]，将源颜色空间与sRGB源颜色空间中的色调映射器输出进行比较。 |
| `r.TSR.ShadingRejection.Flickering` | `1` | TSR输出的不稳定性在99%的时候都源自着色拒绝的不稳定性，其原因是多样的：- 最常见的不稳定来源是结构化几何体和渲染像素网格之间的摩尔纹，由于抖动像素网格偏移，摩尔纹每帧都会发生变化。- 另一来源是由于时间历史记录的先有鸡还是先有蛋的问题而导致的极端几何体复杂性，而这个问题无法通过TSR的RejectionHistory通道中的其他机制来克服，例如，如果帧中可用的细节量尚未存在于历史记录中，那么历史记录如何与渲染的帧相同？或者，如果历史记录与渲染帧的差别太大，历史记录如何累积细节？启用后，在 `TSR.Flickering.Luminance` 资源中存储的任何半透明绘制在连续帧中演变之前，此闪烁时间分析功能会监视场景的亮度在连续帧中的变化情况。如果检测到图像会定期持续闪烁，且闪烁频率高于 `r.TSR.ShadingRejection.Flickering.*` 控制台变量定义的阈值，则启发式将尝试稳定图像，即尝试在与闪烁幅度相关的亮度边界内释放重影。使用命令"r.TSR.Visualize 7"即可查看此启发法在屏幕上快速显示为橙色和红色的位置。粉色即启发法禁用的区域。这种启发法的缺点是，凡是具有不正确运动向量的不透明几何体，都可能使像素看起来与闪烁相同，从而导致这种启发式法启动，并在上述几何体上留下不应存在的重影效果。当发生这种情况时，推荐用VisualizeMotionBlur显示标志验证运动向量，并检查这些运动向量如何使用VisualizeReprojection显示标志重新投影前一帧。此变量可控制在帧中使用 `r.TSR.ShadingRejection.Flickering.Period` 来定义像素被视为闪烁并需要使用此启发法保持稳定的帧频率。例如，如果 `r.TSR.ShadingRejection.Flickering.Period=3`，则每帧中任何像素的亮度变化等于或大于该值均被视为闪烁。 闪烁像素与动画像素之间的另一个区别是：闪烁的发生与帧率无关，而视觉效果是或应该是基于时间的，因此与帧率无关。这可能意味着，在60hz下表现平稳的视觉效果在较低帧率（如24hz）下可能表现为"闪烁"。 为了避免美术师创作的视觉效果出现重影，控制台变量 `r.TSR.ShadingRejection.Flickering.AdjustToFrameRate` 会默认启用，当帧率下低于 `r.TSR.ShadingRejection.Flickering.FrameRateCap` 的刷新率时，帧率边界会自动调整。`r.TSR.ShadingRejection.Flickering` 可根据可伸缩性设置进行控制，在低端或高端GPU上打开/关闭此启发法，而其他 `r.TSR.ShadingRejection.Flickering.*` 可在项目的 `DefaultEngine.ini` 中进行正交设置，以便在所有平台上实现一致的行为。此控制台变量默认在高、超高和电影级抗锯齿可伸缩性组中启用。 |
| `r.TSR.ShadingRejection.Flickering.AdjustToFrameRate` | `1` | 当低于r.TSR.ShadingRejection.Flickering.FrameRateCap时，r.TSR.ShadingRejection.Flickering.Period设置是否应调整到该帧率。详情请参阅r.TSR.ShadingRejection.Flickering的帮助信息。（默认启用）。 |
| `r.TSR.ShadingRejection.Flickering.FrameRateCap` | `60` | 以赫兹为单位的帧率上限，当渲染帧率过低时，会自动调整r.TSR.ShadingRejection.Flickering.Period。详情请参阅r.TSR.ShadingRejection.Flickering的帮助信息。（默认为60hz） |
| `r.TSR.ShadingRejection.Flickering.MaxParallaxVelocity` | `10` | 某些材质可能使用视差遮蔽映射，例如CitySample的建筑窗口内饰。通常无法准确渲染这种伪造内饰几何体的运动向量，从而导致启发法误认为它出现了闪烁。 此变量将定义1080p像素时的视差速度，帧率由r.TSR.ShadingRejection.Flickering.FrameRateCap定义，此时应禁用启发法，以免造成重影。 （默认值为10像素1080p）。 |
| `r.TSR.ShadingRejection.Flickering.Period` | `2` | 帧中亮度振荡频率相等或更大的周期被视为闪烁，并且应产生重影以稳定图像。详情请参阅r.TSR.ShadingRejection.Flickering的帮助信息。（默认值为3帧）。 |
| `r.TSR.ShadingRejection.SampleCount` | `2` | 完全拒绝着色后历史记录中每个输出像素的取样数上限。 值越低，意味着在历史记录中着色拒绝后的图像的越清晰，但后续帧中像素的不稳定性也将越高，导致累积新的细节，并在视觉上可能显得分散（默认值为2.0）。 |
| `r.TSR.ShadingRejection.TileOverscan` | `3` | 着色拒绝在GPU上运行卷积网络，所有卷积均为单个32x32的大小，无需往返主显存。然而，在图块中链接许多卷积意味着周围边缘的某些卷积会损坏，因此需要稍微重叠图块以将其隐藏。值越高，越不容易出现平铺瑕疵，但性能会有所损失。 |
| `r.TSR.Velocity.WeightClampingPixelSpeed` | `1` | 历史记录高频的贡献权重受到限制时的输出像素速度。基本上是为了在像素速度小于r.TSR.Velocity.WeightClampingPixelSpeed时对r.TSR.Velocity.WeightClampingSampleCount的效果进行插值。（默认值=1.0f）。 |
| `r.TSR.Velocity.WeightClampingSampleCount` | `4` | 当输出像素的速度达到 `r.TSR.Velocity.WeightClampingPixelSpeed` 时，在历史记录像素中计数以限制历史记录的取样数。值越高，运动稳定性越高，但由于每次历史重新投影产生连续卷积，会更模糊。使用命令 `r.TSR.Visualize 0` 即可查看屏幕上的TSR历史记录区域累积的取样数。请注意，这将限制历史像素中的取样数，而非输出像素。因此值越低， `r.TSR.History.ScreenPercentage` 越高时，效果越不明显。这样做的目的是，无论设置如何，单方面自动增加 `r.TSR.History.ScreenPercentage` 的值能提供更多的时间稳定性，同时保持细节重新投影的锐度，但会产生额外的运行时开销。 叙事类游戏可能更偏向将此值保持为4.0，以获得"电影级观感"，而像《堡垒之夜》这样的竞技类游戏则更偏向于将值降到2.0。（默认值=4.0f）。 |
| `r.TSR.Visualize` | `-1` | 选择TSR内部可视化模式。 -2：显示概览网格，无视VisualizeTSR显示标志；-1：根据VisualizeTSR显示标志显示概览网格（默认值，运行时用 `show VisualizeTSR` 命令打开，或在编辑器视口中找到显示（Show） > 可视化（Visualize） > TSR）；0：历史记录中的累积取样数。尤其适合调整r.TSR.ShadingRejection.SampleCount和r.TSR.Velocity.WeightClampingSampleCount；1：基于深度和速度缓冲区的视差解除遮挡；2：历史记录被拒绝的遮罩；3：历史记录被限制的遮罩；4：历史记录被恢复的遮罩（需r.TSR.Resurrection=1）；5：历史记录在恢复帧中被恢复的遮罩（需r.TSR.Resurrection=1），尤为适合调整r.TSR.Resurrection.PersistentFrameInterval；6：计算空间抗锯齿处的遮罩；7：闪烁时间分析启发法生效处的遮罩（需r.TSR.ShadingRejection.Flickering=1）； |
| `r.TSR.WaveOps` | `1` | 是否在着色拒绝启发法中使用波动操作来加速卷积。 着色拒绝启发法优化对于着色器编译器来说可能很难，遇到漏洞时会导致损坏或质量损失。 注意，此优化目前在SPIRV平台（主要是Vulkan和Metal）上禁用。因为DXC的SPIRV后端编译时间超过了5分钟，而这不利于编辑器的启动。 |
| `r.TSR.WaveSize` | `0` | 重载要使用的WaveSize。 0：自动（默认值）； 16：WaveSizeOps 16；32：WaveSizeOps 32；64：WaveSizeOps 64； |

### 视野距离

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.ViewDistanceScale` | `1` | 控制视野距离的比例。图元的MaxDrawDistance按此值调整。 值越大，视野距离越远，但会造成性能开销。 默认值=1。 |
| `r.ViewDistanceScale.ApplySecondaryScale` | `0` | 如果值为true，则为图元绘制距离应用二级视野距离比例。 默认值=0。 |
| `r.ViewDistanceScale.FieldOfViewAffectsHLOD` | `0` | 启用后，为HLOD绘制距离和非HLOD绘制距离应用视野缩放。 |
| `r.ViewDistanceScale.FieldOfViewMaxAngle` | `90` | 用摄像机视野来调整场景视野距离的比例。 混合范围的最大角度。 当摄像机位于或高于此角度时，应用最大比例。 |
| `r.ViewDistanceScale.FieldOfViewMaxAngleScale` | `1` | 用摄像机视野来调整场景视野距离的比例。 当摄像机位于或高于最大角度时，应用此值。 |
| `r.ViewDistanceScale.FieldOfViewMinAngle` | `45` | 用摄像机视野来调整场景视野距离的比例。 混合范围的最小角度。 当摄像机位于或低于此角度时，应用最小比例。 |
| `r.ViewDistanceScale.FieldOfViewMinAngleScale` | `1` | 用摄像机视野来调整场景视野距离的比例。 当摄像机位于或低于最小角度时，应用此值。 |
| `r.ViewDistanceScale.SecondaryScale` | `1` | 控制二级视野距离的比例，默认值=1.0。 为可选比例，可搭配某些功能或游戏模式。 |
| `r.ViewDistanceScale.SkeletalMeshOverlay` | `1` | 控制骨骼网格体覆层的距离比例。默认值=1.0。 数值越大，骨骼网格体覆层的绘制距离就越长。此值与r.ViewDistanceScale同时应用 |

### 虚拟纹理

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.VirtualTexture` | `1` | 如果值为1，纹理将使用虚拟内存，从而实现部分驻留。 |
| `r.VirtualTexturedLightmaps` | `0` | 控制是否使用虚拟纹理流送光照贴图。 0：禁用。 1：启用。 |
| `r.VirtualTextureReducedMemory` | `0` | 如果值为 1，则使用更紧凑的布局降低虚拟纹理的开销。 |
| `r.VirtualTextures` | `0` | 是否启用虚拟纹理流送？ |

### 可视性

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.Visibility.DynamicMeshElements.NumMainViewTasks` | `4` | 控制视图可见性期间异步运行的收集动态网格体元素任务的数量。 |
| `r.Visibility.DynamicMeshElements.NumShadowViewTasks` | `4` | 控制阴影可见性期间异步运行的收集动态网格体元素任务的数量。 |
| `r.Visibility.DynamicMeshElements.Parallel` | `true` | 启用收集动态网格体元素可见性阶段的并行处理。 |
| `r.Visibility.FrustumCull.Enabled` | `true` | 启用视锥体剔除。 |
| `r.Visibility.FrustumCull.NumPrimitivesPerTask` | `0` | 为各视锥体剔除任务分配固定数量的图元。0：自动；>0：每项任务的固定图元数量（上限固定）； |
| `r.Visibility.FrustumCull.UseFastIntersect` | `1` | 如果有8个被排列的平面，则使用优化的8平面快速交叉代码。 |
| `r.Visibility.FrustumCull.UseOctree` | `false` | 使用八叉树进行可视性计算。 |
| `r.Visibility.FrustumCull.UseSphereTestFirst` | `false` | 性能调整项。除盒体外，还提前为视锥体剔除使用球体剔除。 |
| `r.Visibility.OcclusionCull.MaxQueriesPerTask` | `0` | 为各遮蔽剔除任务分配固定次数的遮蔽查询。0：自动；>0：各任务的固定遮蔽查询次数； |
| `r.Visibility.Relevance.NumPrimitivesPerPacket` | `0` | 为各视相关性包分配固定数量的图元。0：自动；>0：各包的固定图元数量（上限固定）； |
| `r.Visibility.SkipAlwaysVisible` | `1` | 可视性通道是否应跳过标记为始终可见的图元。0：可视性通道处理所有图元；1：可视性通道仅处理未被标记为bAlwaysVisible的图元 |
| `r.Visibility.TaskSchedule` | `1` | 控制可视性任务图表的计划方式。0：主要在渲染线程上完成工作，但有可能使用并行帮助；1：在异步任务图表上完成工作（如果平台支持）； |

### 体积云

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.VolumetricCloud` | `1` | 若值不为0，则渲染体积云组件，否则忽略。 |
| `r.VolumetricCloud.DisableCompute` | `0` | 不将计算着色器用于云追踪。 |
| `r.VolumetricCloud.DistanceToSampleMaxCount` | `15` | 光线取样总数将均匀分布的距离，以公里为单位。在此值之前，光线取样数范围为1至SampleCountMax，追踪距离范围为0至DistanceToSampleCountMax（公里）。 |
| `r.VolumetricCloud.EmptySpaceSkipping` | `0` | 启用或禁用跳过空白区域功能，以加速通过空白区域的云追踪。试验性 |
| `r.VolumetricCloud.EmptySpaceSkipping.SampleCorners` | `1` | 0表示仅中心取样，>0表示也对角落取样。 |
| `r.VolumetricCloud.EmptySpaceSkipping.StartTracingSliceBias` | `0` | 用于偏移起始深度的切片数。-1的值表示向视点偏移一个切片。 |
| `r.VolumetricCloud.EmptySpaceSkipping.VolumeDepth` | `40` | 以公里为单位，设置可对空白区域求值的距离。 |
| `r.VolumetricCloud.EnableAerialPerspectiveSampling` | `1` | 启用或禁用云层上的空中视角贡献。 |
| `r.VolumetricCloud.EnableAtmosphericLightsSampling` | `1` | 启用或禁用云层上的大气光源贡献。 |
| `r.VolumetricCloud.EnableDistantSkyLightSampling` | `1` | 启用或禁用云层上的远距离天空光照贡献。 |
| `r.VolumetricCloud.EnableLocalLightsSampling` | `0` | [试验性]启用或禁用云层上的局部光源贡献。高开销！仅在必要时为过场动画使用。 |
| `r.VolumetricCloud.HighQualityAerialPerspective` | `0` | 启用或禁用在云层上逐像素追踪空中视角的二级通道，而不是使用空中视角纹理。仅在r.VolumetricCloud.EnableAerialPerspectiveSampling=1时可用，且仅在r.VolumetricRenderTarget=1时用于提供额外质量。 |
| `r.VolumetricCloud.LocalLights.ShadowSampleCount` | `12` | [试验性]设置对局部光源求值时的体积阴影取样数。高开销！仅在必要时为过场动画使用。 |
| `r.VolumetricCloud.ReflectionRaySampleMaxCount` | `80` | 对反射的主光线进行光线行进时采集的取样数上限。 |
| `r.VolumetricCloud.SampleMinCount` | `2` | 沿一条光线采集的取样数下限。这有助于提高靠近摄像机的体积的质量。例如将云层也作为低海拔雾的场景。SampleMinCount的值应该保持相对较低，因为它会被应用到所有追踪进程中。 |
| `r.VolumetricCloud.Shadow.ReflectionRaySampleMaxCount` | `24` | 对反射的阴影光线进行光线行进时采集的取样数上限。 |
| `r.VolumetricCloud.Shadow.SampleAtmosphericLightShadowmap` | `1` | 启用大气光源阴影贴图的取样，以便生成体积阴影。 |
| `r.VolumetricCloud.Shadow.ViewRaySampleMaxCount` | `80` | 对阴影光线进行光线行进时采集的取样数上限。 |
| `r.VolumetricCloud.ShadowMap` | `1` | 启用或禁用阴影贴图，前提是场景中包含启用了投射云阴影的定向光源组件。 |
| `r.VolumetricCloud.ShadowMap.Debug` | `0` | 打印信息以调试云阴影贴图。 |
| `r.VolumetricCloud.ShadowMap.MaxResolution` | `2048` | 云阴影贴图的最大分辨率。活动分辨率由定向光源组件的CloudShadowMapResolutionScale属性控制。 |
| `r.VolumetricCloud.ShadowMap.RaySampleHorizonMultiplier` | `2` | 当大气光源到达地平线时应用的取样数乘数。需要追踪的阴影贴图像素更少，但光线需要经过的距离更长。 |
| `r.VolumetricCloud.ShadowMap.RaySampleMaxCount` | `128` | 对阴影光线进行光线行进时采集的取样数上限，以便对云阴影贴图求值。 |
| `r.VolumetricCloud.ShadowMap.SnapLength` | `20` | 以公里为单位的云阴影贴图位置对齐尺寸，以便避免闪烁。 |
| `r.VolumetricCloud.ShadowMap.SpatialFiltering` | `1` | 启用或禁用阴影贴图膨胀/平滑空间过滤器。大于0时启用，表示模糊的迭代次数（最大值限为4）。 |
| `r.VolumetricCloud.ShadowMap.TemporalFiltering.LightRotationCutHistory` | `10` | 当大气光照旋转的度数大于此值时，重新开始时间积累。 |
| `r.VolumetricCloud.ShadowMap.TemporalFiltering.NewFrameWeight` | `1` | 试验性，还需要更多开发工作，因此默认禁用。介于[0.0和1.0]之间的值，代表当前帧的贡献权重。值过低可能造成精度问题，导致深度无法随时间收敛。设为1以禁用。 |
| `r.VolumetricCloud.SkyAO` | `1` | 启用或禁用云的天空环境光遮蔽。场景必须包含一个启用了云环境遮蔽功能的天空光照组件。 |
| `r.VolumetricCloud.SkyAO.Debug` | `0` | 打印信息以调试云天空环境光遮蔽贴图。 |
| `r.VolumetricCloud.SkyAO.Filtering` | `1` | 启用或禁用天空环境光遮蔽膨胀/平滑过滤器。 |
| `r.VolumetricCloud.SkyAO.MaxResolution` | `2048` | 为来自天空光照的环境光照存储环境光遮蔽信息的纹理的最大分辨率。活动分辨率由天空光照组件的CloudAmbientOcclusionMapResolutionScale属性控制。 |
| `r.VolumetricCloud.SkyAO.SnapLength` | `20` | 以公里为单位的云层环境光遮蔽纹理位置对齐尺寸，以便避免闪烁。 |
| `r.VolumetricCloud.SkyAO.TraceSampleCount` | `10` | 为对地面光照遮蔽求值而采集的取样数。 |
| `r.VolumetricCloud.SoftBlendingDistanceOnTranslucent` | `0.5` | 以公里为单位的软混合距离，用于从求值的起始深度开始对半透明云进行软混合。 |
| `r.VolumetricCloud.StepSizeOnZeroConservativeDensity` | `1` | 出现保守密度为零的样本时，光线行进的步进大小。如果值>1，可以改善性能，但如果步长过大则可能导致条纹瑕疵。 |
| `r.VolumetricCloud.ViewRaySampleMaxCount` | `768` | 对视图主光线进行光线行进时采集的取样数上限。 |

### 体积雾

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.VolumetricFog` | `1` | 是否启用体积雾功能。 |
| `r.VolumetricFog.ConservativeDepth` | `0` | [试验性]是否允许体积使用保守深度来加速计算。 |
| `r.VolumetricFog.DepthDistributionScale` | `32` | 调整切片深度的分布。 |
| `r.VolumetricFog.Emissive` | `1` | 是否启用体积雾自发光组件。 |
| `r.VolumetricFog.GridPixelSize` | `8` | 体素网格中单元格的XY大小，以像素为单位。 |
| `r.VolumetricFog.GridSizeZ` | `128` | Z轴中使用的体积雾单元格的数量。 |
| `r.VolumetricFog.HistoryMissSupersampleCount` | `4` | 对于历史值不可用的体素，需要计算的光照取样数。 这可以减少平移或镜头切换时的噪点，但会给体积雾计算带来可变成本。 有效范围为[1至16]。 |
| `r.VolumetricFog.HistoryWeight` | `0.9` | 每帧的历史值应加权多少。 这是可见抖动和响应性之间的权衡。 |
| `r.VolumetricFog.InjectRaytracedLights` | `0` | 是否将带有光线追踪阴影的光源注入体积雾 |
| `r.VolumetricFog.InjectShadowedLightsSeparately` | `1` | 是否启用体积雾功能。 |
| `r.VolumetricFog.InverseSquaredLightDistanceBiasScale` | `1` | 对平方反比衰减分母的添加量进行调整。 能有效消除导致极度锯齿的平方反比衰减产生的峰值。 |
| `r.VolumetricFog.Jitter` | `1` | 是否对每一帧的体积雾计算应用抖动，从而实现时间超级取样。 |
| `r.VolumetricFog.LightFunction` | `1` | 此项为别名，请使用r.VolumetricFog.UsesLightFunctionAtlas。 |
| `r.VolumetricFog.LightFunction.DirectionalLightSupersampleScale` | `2` | 调整切片深度的分布。 |
| `r.VolumetricFog.LightScatteringSampleJitterMultiplier` | `0` | 随机偏移值的乘数，用于在生成3D雾体积时抖动所有世界取样的位置。使用r.VolumetricFog.Jitter启用或禁用 |
| `r.VolumetricFog.RectLightTexture` | `0` | 是否允许体积雾使用矩形光源纹理。 |
| `r.VolumetricFog.TemporalReprojection` | `1` | 是否对体积雾使用时间重新投影。 |
| `r.VolumetricFog.UpsampleJitterMultiplier` | `0` | 随机偏移值的乘数，用于抖动3D雾体积的取样位置，以隐藏由于从较低分辨率纹理取样而导致的雾像素化。 |
| `r.VolumetricFog.UsesLightFunctionAtlas` | `1` | 是否在渲染局部光源时对光源函数图集进行取样。 |
| `r.VolumetricFog.VoxelizationShowOnlyPassIndex` | `-1` | 如果值大于等于0，则表示渲染单个体素化通道，以便进行调试。 |
| `r.VolumetricFog.VoxelizationSlicesPerGSPass` | `8` | 单个体素化通道中要渲染的深度切片数量（最大几何体着色器扩展）。 必须重新编译体素化着色器才能传播更改。 |

### VSR

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.VRS.BasePass` | `2` | 为基础通道启用可变速率着色。0：禁用；1：完全；2：保守（默认值） |
| `r.VRS.ContrastAdaptiveShading` | `0` | 根据上一帧后期处理输出的亮度，启用可变速率着色功能 |
| `r.VRS.ContrastAdaptiveShading.ConservativeEdgeThreshold` | `0.1` |  |
| `r.VRS.ContrastAdaptiveShading.EdgeThreshold` | `0.2` |  |
| `r.VRS.ContrastAdaptiveShading.HDR10CorrectionMultiplier` | `0.55` | 近似乘数，用于计算SDR与HDR10中感知值的扩散情况 |
| `r.VRS.ContrastAdaptiveShading.Preview` | `1` | 是否在VRS预览覆层中包含CAS。0：关闭；1：开启（默认值） |
| `r.VRS.DebugForceRate` | `-1` | -1：无；0：强制1x1；1：强制1x2；2：强制2x1；3：强制2x2；4：强制2x4；5：强制4x2；6：强制4x4 |
| `r.VRS.Decals` | `2` | 为贴花启用可变速率着色，0: 禁用；1：完全；2：保守（默认值） |
| `r.VRS.Enable` | `false` | 切换以启用可变速率着色。 |
| `r.VRS.EnableImage` | `false` | 切换以启用基于图像的可变速率着色。 |
| `r.VRS.EnableSoftware` | `0` | 尽可能生成2x2图块大小的软件着色速率图像，以供Nanite CS使用。即使r.VRS.Enable=0，或硬件不支持二级VRS，也能生效。0：关闭；1：开启 |
| `r.VRS.LightFunctions` | `1` | 为光源函数启用可变速率着色。0：禁用；1：完全（默认值）；2：保守 |
| `r.VRS.NaniteEmitGBuffer` | `2` | 启用附带Nanite EmitGBuffer渲染功能的VRS。 0：禁用；1：完全；2：保守（默认值） |
| `r.VRS.Preview` | `0` | 显示VRS着色速率图像纹理的调试可视化。保守图像和软件图像仅可通过对比度自适应着色获得。0：关闭；1：完全（硬件）；2：保守（硬件）；3：完全（软件）；4：保守（软件） |
| `r.VRS.ReflectionEnvironmentSky` | `2` | 启用附带ReflectionEnvironmentAndSky（PS）的VRS。 0：禁用；1：完全；2：保守（默认值） |
| `r.VRS.SSAO` | `0` | 启用附带SSAO渲染的VRS。 0：禁用；1：完全；2：保守（默认值） |
| `r.VRS.SSR` | `2` | 启用附带SSR（PS）渲染的VRS。 0：禁用；1：完全；2：保守（默认值） |
| `r.VRS.Translucency` | `1` | 启用附带半透明渲染的VRS。 0：禁用；1：完全（默认值）；2：保守 |

### 虚拟纹理

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.VT.AnisotropicFiltering` | `0` | 是否启用了虚拟纹理的各向异性过滤？ |
| `r.VT.AsyncPageRequestTask` | `1` | 在异步任务中执行虚拟纹理页面请求。 |
| `r.VT.AVT.AgeToFree` | `60` | 分配被视为空闲之前所未使用的帧数 |
| `r.VT.AVT.LevelIncrement` | `3` | 每次增加分配的虚拟纹理时增加的级别数 |
| `r.VT.AVT.MaxAllocPerFrame` | `1` | 每帧为自适应虚拟纹理分配的虚拟纹理数量上限 |
| `r.VT.AVT.MaxFreePerFrame` | `1` | 每帧为自适应虚拟纹理释放的虚拟纹理数量上限 |
| `r.VT.AVT.MaxPageResidency` | `75` | 在开始释放空间之前要分配的页面表百分比 |
| `r.VT.Borders` | `0` | 如果值>0，则启用调试边框 |
| `r.VT.CodecAgeThreshold` | `120` | 虚拟纹理编解码器在可能报废前必须未使用的最少帧数 |
| `r.VT.CodecNumThreshold` | `100` | 一旦虚拟纹理编解码器的数量超过此数，尝试报废最近未使用的编解码器 |
| `r.VT.CsvStats` | `1` | 将虚拟纹理统计数据发送至CSV分析器。0：关闭；1：开启；2：冗长 |
| `r.VT.EnableAutoImport` | `1` | 在纹理导入时启用虚拟纹理 |
| `r.VT.EnableFeedback` | `1` | 启用处理GPU生成的反馈缓冲区。 |
| `r.VT.EnableLossyCompressLightmaps` | `0` | 启用虚拟纹理光照贴图的有损压缩。与普通颜色纹理相比，有损压缩往往会降低光照贴图纹理的质量。 |
| `r.VT.EnablePlayback` | `1` | 启用回放已记录的反馈请求。 |
| `r.vt.FeedbackFactor` | `16` | 将渲染分辨率除以此系数计算得出虚拟纹理反馈缓冲区的大小。此处设置的值在使用前会四舍五入为最接近2的幂的值。 |
| `r.VT.ForceContinuousUpdate` | `0` | 强制持续更新所有虚拟纹理。 |
| `r.VT.IOPriority_HighPagePri` | `2` | 高优先级虚拟纹理I/O请求的优先级 |
| `r.VT.IOPriority_NormalPagePri` | `1` | 默认优先级虚拟纹理I/O请求的优先级 |
| `r.VT.MaskedPageTableUpdates` | `1` | 遮罩页面表更新四边形，以降低像素填充成本 |
| `r.VT.MaxAnisotropy` | `8` | 虚拟纹理取样的最大各向异性设置。 |
| `r.VT.MaxContinuousUpdatesPerFrame` | `1` | 已映射页面的上传页数上限。 |
| `r.VT.MaxContinuousUpdatesPerFrameInEditor` | `8` | 编辑器中已映射页面的上传页数上限。 |
| `r.VT.MaxReleasedPerFrame` | `0` | 每帧待释放的已分配虚拟纹理的数量上限 |
| `r.VT.MaxTilesProducedPerFrame` | `30` | 每帧可制作的页数上限 |
| `r.VT.MaxUploadMemory` | `64` | 限制虚拟纹理流送请求前，待分配的上传内存容量上限，以MB为单位。 由于不限制高优先级请求，因此分配峰值可能会超过此值。 |
| `r.VT.MaxUploadRequests` | `2000` | 可以同时进行的虚拟纹理切片上传请求的数量上限。 |
| `r.VT.MaxUploadsPerFrame` | `8` | 游戏中每帧上传页面的数量上限 |
| `r.VT.MaxUploadsPerFrame.Streaming` | `0` | 若为正值，表示游戏中为流送虚拟纹理而每帧上传页面的数量上限。负值表示无限制。 如果为零，则不对SVT单独做预算限制。将与其他类型的虚拟纹理一起受到r.VT.MaxUploadsPerFrame的限制。这是旧行为。 如果流送页面较慢，则此限值应较高，以免I/O请求被限流，导致获取页面数据的延迟时间过长。 |
| `r.VT.MaxUploadsPerFrameInEditor` | `32` | 编辑器中每帧上传页面的数量上限 |
| `r.VT.MenuRestricted` | `0` | 限定虚拟纹理的菜单选项 |
| `r.VT.Mobile.ManualTrilinearFiltering` | `1` | 是否对移动平台上的虚拟纹理使用手动三线性过滤。 这种开销较高的过滤方法一般用于不支持时间抗锯齿的移动平台。 |
| `r.VT.NumFeedbackTasks` | `1` | 为读取虚拟纹理反馈而创建的任务数。 |
| `r.VT.NumGatherTasks` | `1` | 为组合虚拟纹理反馈而创建的任务数。 |
| `r.VT.PageFreeThreshold` | `60` | 自上次使用虚拟纹理页面以来，其被视为空闲页面的帧数。 每次GPU访问虚拟纹理页面时，CPU不一定会将其标记为已使用。 提高此阈值可降低使用中的帧被视为空闲帧的几率。 |
| `r.VT.PageUpdateFlushCount` | `8` | 在尝试使用锁来清空缓冲区之前的页面更新次数。 |
| `r.VT.ParallelFeedbackTasks` | `0` | 为虚拟纹理反馈任务使用工作线程。 |
| `r.VT.ParallelTileCompression` | `1` | 启用宏图块的并行压缩 |
| `r.VT.PlaybackMipBias` | `0` | 回放录制的反馈请求时应用的Mip偏差。 |
| `r.VT.PoolAutoGrow` | `false` | 启用超额订阅时的物理池增长功能。 |
| `r.VT.PoolSizeScale` | `1` | 虚拟纹理物理池大小的缩放因子。 |
| `r.VT.ProduceLockedTilesOnFlush` | `1` | 清空缓存时是否应（重新）生成锁定的图块 |
| `r.VT.RefreshEntirePageTable` | `0` | 逐帧刷新整个页面表的纹理 |
| `r.VT.RenderCaptureNextPagesDraws` | `0` | 在下一次RVT RenderPages绘制调用中触发渲染捕获。 |
| `r.VT.Residency.AdjustmentRate` | `0.2` | 由于虚拟纹理池的驻留，调整Mip偏差的速率。 默认值为0.2 |
| `r.VT.Residency.LockedUpperBound` | `0.65` | 虚拟纹理池锁定页面的驻留，超过该值则销毁Mip偏差。 这是因为锁定的页面永远不会受到Mip偏差设置的影响。因此基本不可能将池限制在预算范围内。 默认值为0.65 |
| `r.VT.Residency.LowerBound` | `0.95` | 虚拟纹理池的驻留，低于该时间则降低Mip偏差。 默认值为0.95 |
| `r.VT.Residency.MaxMipMapBias` | `4` | 用于防止虚拟纹理池驻留超额订阅的最大Mip偏差。 默认值为4 |
| `r.VT.Residency.Notify` | `0` | 在屏幕上显示虚拟纹理物理池的驻留通知 |
| `r.VT.Residency.Show` | `0` | 在屏幕上显示虚拟纹理物理池的驻留HUD |
| `r.VT.Residency.UpperBound` | `0.95` | 虚拟纹理池的驻留，超过该时间则增加Mip偏差。 默认值为0.95 |
| `r.VT.RVT.DirectCompress` | `1` | 在支持的平台上，直接将纹理数据压缩到物理纹理中。 |
| `r.VT.RVT.DirtyPagesKeptMappedFrames` | `8` | 当RVT页面失效化时，如果它们在最后N个帧中给出了反馈，则保留映射状态。 |
| `r.VT.RVT.HighQualityPerPixelHeight` | `1` | 在渲染到运行时虚拟纹理时，使用更高质量的逐像素高度贴图取样。 |
| `r.VT.RVT.MipColors` | `false` | 将Mip颜色渲染为RVT BaseColor。 |
| `r.VT.RVT.StreamingMips` | `1` | 为RVT启用流送Mip |
| `r.VT.RVT.TileCountBias` | `0` | 应用于运行时虚拟纹理大小的偏差。 组0 |
| `r.VT.RVT.TileCountBias.Group0` | `0` | 应用于运行时虚拟纹理大小的偏差。 组0 |
| `r.VT.RVT.TileCountBias.Group1` | `0` | 应用于运行时虚拟纹理大小的偏差。 组1 |
| `r.VT.RVT.TileCountBias.Group2` | `0` | 应用于运行时虚拟纹理大小的偏差。 组2 |
| `r.VT.SplitPhysicalPoolSize` | `0` | 按格式创建多个物理池，以限制池的最大尺寸（以图块为单位）。 数值为64图块时，将强制使用16位页面表。这可以优化大型物理池的页面表内存。 默认值为0（关闭）。 |
| `r.VT.Support16BitPageTable` | `true` | 启用对16位页面表项的支持。 当只需要16位寻址时，可以节省页面表内存。 但在需要混合使用16位和32位寻址时，这会增加所需的页面表容量。 默认开启。 |
| `r.VT.SyncProduceLockedTiles` | `1` | 生产锁定的图块时是否应同步加载 |
| `r.VT.TileBorderSize` | `4` | 虚拟纹理图块边框的大小（以像素数量表示，四舍五入为下一个2的幂） |
| `r.VT.TileSize` | `128` | 虚拟纹理图块的大小（以像素数量表示，四舍五入为下一个2的幂） |
| `r.VT.TranscodeRetireAge` | `60` | 如果虚拟纹理转码请求在此帧数后未被接收，则将其丢弃，并将请求作为空闲请求放入缓存中。默认值为60 |
| `r.VT.UploadMemoryPageSize` | `4` | 单页虚拟纹理上传内存的大小（以MB为单位）。 |
| `r.VT.ValidateCompressionOnLoad` | `0` | 从DDC加载时，验证虚拟纹理数据是否包含压缩错误。虽然速度慢，但可用于调试损坏的虚拟纹理数据（并从损坏的DDC中恢复） |
| `r.VT.ValidateCompressionOnSave` | `0` | 保存到DDC前，验证虚拟纹理数据是否包含压缩错误。虽然速度慢，但可用于调试损坏的虚拟纹理数据 |
| `r.VT.Verbose` | `0` | 严格检查特定事项，这些事物出现就说明存在错误。这可能会导致每帧100行的大量日志垃圾。 |

### 水

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `r.Water.SingleLayer` | `1` | 启用单一水体渲染系统。 |
| `r.Water.SingleLayer.DepthPrepass` | `1` | 对单层水启用深度预通道。对虚拟阴影贴图的适当支持而言是必须的。 |
| `r.Water.SingleLayer.DistanceFieldShadow` | `1` | 使用延迟时，单层水支持距离场阴影追踪。可用此控制台变量在运行时开启或关闭该功能。 |
| `r.Water.SingleLayer.OptimizedClear` | `1` | 启用优化后的深度清除 |
| `r.Water.SingleLayer.Reflection` | `1` | 用于单层水的反射技术。0：禁用，1：启用（同场景剩余部分一致）；2：强制反射捕获和天空反射；3：强制SSR |
| `r.Water.SingleLayer.RefractionDownsampleFactor` | `1` | 水折射缓冲区的分辨率除数。 |
| `r.Water.SingleLayer.ShadersSupportDistanceFieldShadow` | `1` | 编译单层水材质着色器时是否支持距离场阴影，即用单独的渲染目标输出主定向光源的亮度。前提条件是在项目中启用延迟着色和距离场支持。 |
| `r.Water.SingleLayer.ShadersSupportVSMFiltering` | `0` | 编译单层水材质着色器时是否支持虚拟阴影贴图过滤器，即用单独的渲染目标输出主定向光源的亮度。前提条件是在项目中启用延迟着色和虚拟阴影贴图支持。 |
| `r.Water.SingleLayer.SSRTAA` | `1` | 为单层水渲染系统启用使用TAA的SSR降噪。 |
| `r.Water.SingleLayer.TiledComposite` | `1` | 为单层水反射渲染系统启用平铺优化。 |
| `r.Water.SingleLayer.UnderwaterFogWhenCameraIsAboveWater` | `false` | 即使摄像机高于水面，也在水面后渲染高度雾。这可以避免在场景中有强高度雾的情况下，在进出水面时出现瑕疵，但会导致从远处看水面时出现瑕疵。 |
| `r.Water.SingleLayer.VSMFiltering` | `0` | 使用延迟时，单层水支持虚拟阴影贴图过滤。可用此控制台变量在运行时开启或关闭该功能。 |
| `r.Water.SingleLayerWater.SupportCloudShadow` | `0` | 在单层水材质上启用云阴影。 |
| `r.Water.WaterInfo.DilationOverwriteMinimumDistance` | `128` | 当允许在水面上写入膨胀时，距离地面的最小地下距离 |
| `r.Water.WaterInfo.RenderCaptureNextWaterInfoDraws` | `0` | 为在接下来的N次绘制启用捕获水的信息纹理 |
| `r.Water.WaterInfo.UndergroundDilationDepthOffset` | `64` | 当允许在水面上写入膨胀时，距离地面的最小地下距离 |

## Render Doc

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `renderdoc.AutoAttach` | `0` | 在启动时附加RenderDoc。 |
| `renderdoc.BinaryPath` |  | 要使用的主RenderDoc可执行文件的路径。 |
| `renderdoc.CaptureAllActivity` | `0` | 0：RenderDoc将仅从当前视口捕获数据。1：将捕获整个帧的所有视口和编辑器窗口中的所有活动。 |
| `renderdoc.CaptureCallstacks` | `1` | 0：RenderDoc不会捕获调用堆栈。1：捕获每个API调用的调用堆栈。 |
| `renderdoc.CaptureDelay` | `0` | 如果值>0，RenderDoc将在指定时间（或帧数，如果CaptureDelayInSeconds为false）过后才触发捕捉。 |
| `renderdoc.CaptureDelayInSeconds` | `1` | 0：捕获延迟以帧为单位。1：捕获延迟以秒为单位。 |
| `renderdoc.CaptureFrameCount` | `0` | 如果值>0，RenderDoc的捕获将包含多个帧。注意：这意味着所有视口和编辑器窗口中的所有活动都将被捕获（即与CaptureAllActivity相同） |
| `renderdoc.EnableCrashHandler` | `0` | 0：将崩溃处理完全委托给引擎。1：使用RenderDoc崩溃处理程序（仅当你知道问题出在RenderDoc上，并希望通知RenderDoc开发者时才使用此选项！）。 |
| `renderdoc.ReferenceAllResources` | `0` | 0：仅纳入实际使用的资源。1：在捕获中纳入所有渲染资源，即使是在帧期间未使用的资源。请注意，这样做会显著增加捕获的大小。 |
| `renderdoc.SaveAllInitials` | `0` | 0：忽略资源的初始状态。1：始终捕获所有渲染资源的初始状态。请注意，这样做会显著增加捕获的大小。 |
| `renderdoc.ShowHelpOnStartup` | `0` | 0：问候语显示后，启动时不再出现。1：问候语将在下次启动时出现。 |
| `Replay.UseReplayConnection` | `false` |  |

## RHI

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `rhi.Bindless.Resources` | `Disabled` | 设为"Enabled"以对所有着色器类型启用。设为"RayTracingOnly"以限定为仅针对光线追踪着色器。 |
| `rhi.Bindless.Samplers` | `Disabled` | 设为"Enabled"以对所有着色器类型启用。设为"RayTracingOnly"以限定为仅针对光线追踪着色器。 |
| `rhi.EnableConsole120Fps` | `0` | 如果显示器支持，且游戏主机设置正确，则启为游戏主机启用120FPS |
| `RHI.GPUHitchThreshold` | `100` | 检测GPU卡顿的阈值（以毫秒为单位）。 |
| `rhi.PresentThreshold.Bottom` | `0` | 指定允许撕裂存在的屏幕底部百分比。 仅对支持的平台生效。 范围：0.0 - 1.0 |
| `rhi.PresentThreshold.Top` | `0` | 指定允许撕裂存在的屏幕顶部百分比。 仅对支持的平台生效。 范围：0.0 - 1.0 |
| `rhi.ResourceTableCaching` | `1` | 如果值为1，RHI将缓存一帧内的资源表内容。否则每次绘制调用时都会重建资源表。 |
| `rhi.SyncAllowEarlyKick` | `1` | 当值为1时，如果错过了垂直同步，则允许RHI垂直同步线程提前启动下一帧。 |
| `rhi.SyncAllowVariable` | `1` | 当值为1时，如果输出硬件支持，则允许RHI使用可变刷新率。 |
| `rhi.SyncInterval` | `1` | 决定支持的RHI中的垂直同步频率。 在60hz的显示器上是16.66的倍数，但某些平台支持更高的刷新率。 假设60fps，对应的值分别是： 0：解锁（立刻呈现）；1：每次Vblank间隔时呈现；2：每2次Vblank间隔时呈现；3：依此类推…… |
| `rhi.SyncSlackMS` | `10` | 将输入延迟增加此毫秒数，以提高性能（权衡可调）。游戏线程将在垂直同步前的此毫秒数内启动 |
| `RHI.TransientAllocator.BufferCacheSize` | `64` | 垃圾回收前每个堆上缓存的RHI缓冲区数上限。 |
| `RHI.TransientAllocator.GarbageCollectLatency` | `16` | 内存回收之前的更新周期数。 |
| `RHI.TransientAllocator.MinimumHeapSize` | `128` | RHI临时堆的大小下限（以MB为单位）。堆将默认为此大小，并根据第一次分配增长到最大值（默认值为128）。 |
| `RHI.TransientAllocator.TextureCacheSize` | `64` | 垃圾回收前每个堆上缓存的RHI纹理数上限。 |
| `rhi.UseSubmissionThread` | `2` | 是否启用RHI提交线程。 0：否；1：是，但多GPU运行时不使用。 2：始终启用 |
| `RHIPoolAllocator.DefragMaxPoolsToClear` | `1` | 在单次分配器碎片整理调用期间尝试清除的池数量上限（默认值：1：若为负数则尝试清除所有池并且不进行时间切片）。 |
| `RHIPoolAllocator.DefragSizeFraction` | `0.9` | 如果占用超过给定比例，则跳过池碎片整理（默认值：0.9f）。 |
| `RHIPoolAllocator.ValidateLinkedList` | `0` | 在每次操作期间验证所有RHIPoolAllocators的所有内部链表数据。 |

## 绑定虚拟机

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `RigVM.DisableExecutionAll` | `0` | 如果非零，则禁用绑定虚拟机的所有执行。 |
| `RigVM.DisableNativizedVMs` | `1` | 如果非零，则禁用切换为原生化的虚拟机。 |
| `RigVM.EnableDrawInterfaceInShipping` | `0` | 将值设为1以在发布构建中启用控制绑定绘制接口 |
| `RigVM.EnablePostLoadHashing` | `true` | 如果值为true，当哈希与序列化的哈希匹配时，跳过RigVMGraphs的刷新。 |
| `RigVM.EnablePreLoadFiltering` | `true` | 如果值为true，在预加载期间跳过RigVMGraphs，以缩短加载时间。 |
| `RigVM.Graph.DisableCompactNodes` | `false` | 如果值为true，所有节点都将被绘制为完整节点。 |
| `RigVM.NameCacheMaxSize` | `4096` | 更改此数值，以控制每个虚拟机实例可缓存的名称数量。 |
| `RigVM.StackDetailedLabels` | `false` | 将值设为true以打开执行堆栈控件的详细标签 |
| `RigVM.UInterfaceSupport` | `true` | 如果值为true，RigVMCompiler将允许UInterface。 |
| `RigVM.UObjectSupport` | `true` | 如果值为true，RigVMCompiler将允许UObject。 |
| `RunAsyncTraceOnWorkerThread` | `1` | 是否为异步追踪功能使用工作线程。要求FApp::ShouldUseThreadingForPerformance设为true。否则始终使用游戏线程。 0：使用游戏线程；1：使用工作线程 |

## 可伸缩性

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `s.AdaptiveAddToWorld.AddToWorldTimeSliceMax` | `6` | 自适应AddToWorld时间切片上限 |
| `s.AdaptiveAddToWorld.AddToWorldTimeSliceMin` | `1` | 自适应AddToWorld时间切片下限 |
| `s.AdaptiveAddToWorld.Enabled` | `0` | 启用自适应AddToWorld时间切片（替代s.LevelStreamingActorsUpdateTimeLimit）（默认：关闭） |
| `s.AdaptiveAddToWorld.Method` | `1` | 用于自适应时间切片的启发法。0：根据剩余工作时间计算目标时间切片；1：根据运行的关卡总工作时间计算目标时间切片（避免在关卡完成前减速） |
| `s.AdaptiveAddToWorld.TargetMaxTimeRemaining` | `6` | 目标剩余最大时间（以秒为单位）。如果预计的完成时间大于此时间，则增加时间切片。值越低，越激进 |
| `s.AdaptiveAddToWorld.TimeSliceMaxIncreasePerSecond` | `0` | 自适应AddToWorld时间切片增加的最大速率。将值设为0可进行瞬时增加 |
| `s.AdaptiveAddToWorld.TimeSliceMaxReducePerSecond` | `0` | 自适应AddToWorld时间切片减少的最大速率。将值设为0可进行瞬时减少 |
| `s.AllowLevelRequestsWhileAsyncLoadingInMatch` | `1` | 当匹配已在进行中且没有加载屏幕时，在异步加载（任何内容）时启用关卡流送请求。 |
| `s.AllowParseObjectLoading` | `true` | 如果值为true，则允许ParseObject根据需要和请求加载完全适用的对象。 |
| `s.AllowUnversionedContentInEditor` | `0` | 如果值为true，则允许编辑器加载无版本控制的内容。 |
| `s.AsyncLoadingAlwaysProcessPackages` | `0` | 清空时，处理所有包，而不是仅处理所需的包。（用于避免难以重现的潜在死锁） |
| `s.AsyncLoadingPrecachePriority` | `0` | 异步加载预缓存请求的优先级 |
| `s.AsyncLoadingThreadEnabled` | `1` | 控制台变量占位符，目前未在运行时使用。 |
| `s.AsyncLoadingTimeLimit` | `5` | 异步加载可花费的最长时间（毫秒每帧）。 |
| `s.AsyncLoadingUseFullTimeLimit` | `0` | 是否即使在I/O屏蔽的情况下，也使用完整时间限制。 |
| `s.CheckRootComponentReplicationOnAttachedChildren` | `true` | 场景组件OnRep_AttachedChildren： False：修复所有缺少父项的子项；True：修复所有子项，非副本的根组件除外（默认值） |
| `s.ContinuouslyIncrementalGCWhileLevelsPendingPurge` | `1` | 当仍有等待清除的关卡时，是否重复进行增量垃圾回收。 |
| `s.DebugPackageNames` |  | 为所有列出的包名称添加调试断点，并自动添加到s.VerbosePackageNames。 |
| `s.EditorLoadPrecacheSizeKB` | `0` | 在编辑器中加载包时预缓存的大小（以KB为单位）。 |
| `s.EnforcePackageCompatibleVersionCheck` | `1` | 如果值为true，那么若包的头文件中存储的版本比当前引擎版本新，则包加载失败 |
| `s.EventDrivenLoaderEnabled` | `1` | 控制台变量占位符，目前未在运行时使用。 |
| `s.FlushStreamingOnExit` | `1` | 控制台变量占位符，目前未在运行时使用。 |
| `s.ForceGCAfterLevelStreamedOut` | `1` | 是否在关卡向外流送后强制进行垃圾回收，从而以卡顿为代价立刻回收内存。 |
| `s.ForceRouteActorInitializeNextFrame` | `0` | 是否在路由Actor的自身帧中强制执行初始化阶段。 |
| `s.ForceVerifyLevelsGotRemovedByGC` | `0` | 是否对存在于垃圾回收后关卡包中的对象进行强制验证（在发布构建中忽略）。 |
| `s.IoDispatcherBufferAlignment` | `4096` | IoDispatcher读取缓冲区对齐。 |
| `s.IoDispatcherBufferMemoryMB` | `8` | IoDispatcher缓冲区内存大小（以兆字节为单位）。 |
| `s.IoDispatcherBufferSizeKB` | `256` | IoDispatcher读取缓冲区大小（以千字节为单位）。 |
| `s.IoDispatcherCacheSizeMB` | `0` | IoDispatcher缓存内存大小（以兆字节为单位）。 |
| `s.IoDispatcherDecompressionWorkerCount` | `4` | IoDispatcher解压缩工作程序数量。 |
| `s.IoDispatcherForceSynchronousScatter` | `0` | 强制分散作业在IODispatcher线程上同步进行。 这可以避免后台任务等待I/O且后台任务线程无法满足解压缩请求时出现死锁。 |
| `s.IoDispatcherMaintainSortingOnPriorityChange` | `1` | 如果s.IoDispatcherSortRequestsByOffset大于0且本变量大于0，那么即使切换了优先级，IoDispatcher也会记住上次读取的文件句柄或偏移。 |
| `s.IoDispatcherMaxForwardSeekKB` | `0` | 如果启用s.IoDispatcherSortRequestsByOffset，且本变量大于0，那么如果下一个循序访问的请求距离上一个请求的偏移量大于本偏移量，则读取最早的请求 |
| `s.IoDispatcherRequestLatencyCircuitBreakerMS` | `0` | 如果启用s.IoDispatcherSortRequestsByOffset，且本变量大于0，那么如果最早的请求已在队列中停留了这么长时间，则读取该请求，而不读取最佳请求 |
| `s.IoDispatcherSortRequestsByOffset` | `1` | 如果本变量大于0，那么IoDispatcher将按偏移量而非序列对未完成的请求队列进行排序。 |
| `s.IoDispatcherTocsEnablePerfectHashing` | `1` | 为iostore tocs启用完美Hashmap查找 |
| `s.LargeMemoryDataMaxPoolLength` | `2` | 将LargeMemoryData池的大小限制为给定的元素数量。 |
| `s.LevelStreamingActorsUpdateTimeLimit` | `5` | 关卡流送期间用于Actor注册步骤的最长允许时间（毫秒/帧）。 |
| `s.LevelStreamingAddPrimitiveGranularity` | `120` | 在关卡流送期间注册Actor组件时，用于向场景并行添加图元的批量粒度。 |
| `s.LevelStreamingComponentsRegistrationGranularity` | `10` | 关卡流送期间用于注册Actor组件的批量粒度。 |
| `s.LevelStreamingComponentsUnregistrationGranularity` | `5` | 关卡取消流送期间用于注销Actor组件的批量粒度。 |
| `s.LevelStreamingLowMemoryPendingPurgeCount` | `2147483647` | 系统内存不足时，如果待清除的流送关卡数达到或超过此值，则执行"软"垃圾回收。 |
| `s.LevelStreamingRouteActorInitializationGranularity` | `10` | 关卡流送期间用于初始化Actor的批量粒度。如果本变量为0，则一次性处理所有Actor和舞台。 |
| `s.MaxIncomingRequestsToStall` | `100` | 在停止pak预缓存器前，控制未处理IO请求的数量上限，从而让CPU赶上进度。 |
| `s.MaxLevelRequestsAtOnceWhileInMatch` | `0` | 如果加载了指定数目的关卡且已主动匹配，则不再允许任何请求，直到完成其中一个关卡。 设置为零以禁用。 |
| `s.MaxPrecacheRequestsInFlight` | `2` | 控制正在进行的预缓存请求的最大数量。 |
| `s.MaxReadyRequestsToStallMB` | `30` | 在停止pak预缓存器前，控制未处理IO请求的最大内存数量，从而让CPU赶上进度（以兆字节为单位）。 |
| `s.MinBulkDataSizeForAsyncLoading` | `131072` | 触发超时告警的最小时间。 |
| `s.OnlyProcessRequiredPackagesWhenSyncLoading` | `true` | 同步加载包时，只处理该包及其导入包 |
| `s.OptimizeActorRegistration` | `1` | 启用对Actor组件注册函数的优化，比如PostRegisterAllComponents。 0：禁用依赖于注册函数冗余调用的旧代码的优化 1：启用优化并假定代码正常运行 2：启用优化逻辑，但确保其在非发布构建中正常运行 |
| `s.PriorityAsyncLoadingExtraTime` | `15` | 高优先级加载期间进行异步加载所需的额外时间。 |
| `s.PriorityLevelStreamingActorsUpdateExtraTime` | `5` | 高优先级加载期间进行Actor注册步骤所需的额外时间。 |
| `s.ProcessPrestreamingRequests` | `0` | 如果非零，则在烘焙后的构建中处理预流送请求。 |
| `s.RandomizeLoadOrder` | `0` | 如果值大于0，则使用此种子随机化待处理包的加载顺序，而非使用最高效的顺序。这可以用于查找漏洞。 |
| `s.RemoveUnreachableObjectsOnGT` | `false` | 从垃圾回收回调NotifyUnreachableObjects（慢）中删除游戏线程上GlobalImportStore中的不可达对象。 |
| `s.RouteActorInitializationWorkUnitWeighting` | `0.5` | 计算工作单位时应用于RouteActorInitialization的权重（相对于组件初始化）。 |
| `s.SkipChangelistCompatibilityVersionCheck` | `0` | 如果值为true，那么引擎版本兼容性检查将不使用更改列表的编号来确定兼容性。注意：被许可用户构建自动跳过变更列表兼容性检查。 |
| `s.StorageServerIoDispatcherBatchSize` | `16` | StorageServer IoDispatcher的批量大小。 |
| `s.StorageServerIoDispatcherMaxActiveBatchCount` | `4` | StorageServer IoDispatcher的最大提交批次数量。 |
| `s.StreamableDelegateDelayFrames` | `1` | StreamableManager委托延迟的帧数 |
| `s.StreamableFlushAllAsyncLoadRequestsOnWait` | `false` | 等待可流送句柄时，清空无特定请求ID的异步加载。 |
| `s.TimeLimitExceededMinTime` | `0.005` | 触发超时告警的最小时间。 |
| `s.TimeLimitExceededMultiplier` | `1.5` | 超时告警时间阈值的乘数。 |
| `s.UnregisterComponentsTimeLimit` | `1` | 关卡流送期间用于Actor注销步骤的最长允许时间（毫秒/帧）。如果值为零，则不进行时间切片 |
| `s.UseBackgroundLevelStreaming` | `1` | 是否允许后台关卡流送。 |
| `s.VerbosePackageNames` |  | 将详细日志记录限制为列出的包名称。 |
| `s.VerifyObjectLoadFlags` | `false` | 完成从垃圾回收回调NotifyUnreachableObjects（慢）的加载后，对所有对象运行AsyncFlags校验。 |
| `s.VerifyUnreachableObjects` | `false` | 为来自于垃圾回收回调NotifyUnreachableObjects（慢）的不可达对象运行GlobalImportStore校验。 |
| `s.WarnIfTimeLimitExceeded` | `0` | 启用时间切片包流送超时时的日志警告。 |
| `s.World.SkipPerfTrackerForUninitializedWorlds` | `true` | 设置后，将禁止为未初始化的世界分配InGamePerformanceTracker。 |

## 安全区

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `SafeZone.EnableScale` | `false` | 是否启用了安全区缩放？ |
| `SafeZone.Scale` | `1` | 安全区缩放。 |

## 保存

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `save.FixupStandaloneFlags` | `0` | 如果非零，当包的UAsset缺失RF_Standalone时，将添加该标记。如果为零，则不更改标记且保存失败。 |

## 场景图表

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `SceneGraph.EnablePropertyBagPlaceholderObjectSupport` | `false` | 如果为true，则允许在加载时创建占位符类型来代替缺失的类型，以便将序列化重定向到属性包中。 |

## 场景大纲视图

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `SceneOutliner.AutoRepresentingWorldNetMode` | `3` | 选择"自动（Auto）"时，场景大纲视图中显示的世界首选网络模式：0=独立、1=专用服务器、2=监听服务器、3=客户端 |
| `SceneOutliner.AutoRepresentingWorldNetModeForObjectMixer` | `3` | 选择"自动（Auto）"时，场景大纲视图中显示的世界首选网络模式：0=独立、1=专用服务器、2=监听服务器、3=客户端 |
| `SceneOutliner.ProcessingBudgetPerFrame` | `5` | 处理逐帧操作的最大时间，以毫秒为单位 |

## Sequencer

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Sequencer.AddKeepStateDeterminismFences` | `true` | Sequencer编译器是否应为KeepState分段的最后一帧自动添加确定性栅栏。这样可以确保无论帧速率如何，都能对该分段的最后可能值进行一致的求值，但代价是要对跨越KeepState分段结束时间的帧进行额外求值。 |
| `Sequencer.Audio.IgnoreAudioSyncDuringWorldTimeDilation` | `true` | 如果存在世界时间膨胀，则忽略校正音频。 |
| `Sequencer.Audio.MaxDesyncTolerance` | `0.5` | 控制音轨在序列中不同步多少秒后，才尝试进行时间校正。 |
| `Sequencer.Audio.PlayAudioWhenPlaybackJumps` | `false` | 在播放跳转时播放音频。 |
| `Sequencer.Audio.UseAudioClockForAudioDesync` | `0` | 若为1，则直接使用音频渲染线程来查询音频是否与序列不同步。 |
| `Sequencer.AutoScrub` | `false` | 启用/禁用自动推移 |
| `Sequencer.AutoScrubCurveExponent` | `2` | 自动推移时，推移速度的增减幅度 |
| `Sequencer.AutoScrubSpeed` | `6` | 自动推移时，向前/向后推移的速度 |
| `Sequencer.AutoTangentNew` | `2` | 如果为2，Sequencer将以无过冲的方式拉平切线；如果为1，则自动切线将使用新算法逐步拉平最大/最小关键帧；如果为0，则自动切线将平均所有关键帧（4.23之前的行为）。 |
| `Sequencer.CachedChannelEvaluationParityThreshold` | `0` | 用已缓存/未缓存的例程进行求值奇偶校验的阈值。 |
| `Sequencer.CompilerVersion` | `7D4B98092FAC4A6B964ECF72D8279EF8` | 定义电影场景编译逻辑的全局标识符。 |
| `Sequencer.CustomTaskScheduling` | `true` | （默认值：true。）提高异步Sequencer求值自定义任务调度的效率。 |
| `Sequencer.DeferMovementUpdates` | `false` | （默认值：false）启用将所有场景组件移动更新推迟到Sequencer求值结束时进行，以避免过多调用UpdateOverlaps或对所附组件进行级联变换更新。 |
| `Sequencer.DrawMeshTrails` | `true` | 显示或隐藏关卡序列VR编辑器尾迹的开关 |
| `Sequencer.DuplicateLinkedAnimSequence` | `false` | 如果为true，当复制有链接动画序列的关卡序列时，则复制并链接该动画序列；如果为false，则忽略任何链接。 |
| `Sequencer.EnableCachedChannelEvaluation` | `true` | 决定通道求值是使用有缓存求值还是无缓存求值的开关。 |
| `Sequencer.IgnoreDependenciesWhenNotThreading` | `true` | （默认值：true）当没有线程时，是否忽略任务依赖性。 |
| `Sequencer.LinearCubicInterpolation` | `1` | 如果为1，则线性关键帧将作为具有线性切线的三次方插值，如果为0，则线性关键帧将强制线性插值到下一关键帧。 |
| `Sequencer.MaterialParameterBlending` | `true` | （默认值：true）决定是否启用材质参数混合。 |
| `Sequencer.MaterialParameterEntityLifetimeTracking` | `false` | （默认值：false）确保销毁时已清理所有实体。因为可能会导致误报（当连接器和材质系统被一起清理时），所以默认不启用。 |
| `Sequencer.MaxLatentActionLoops` | `100` | 定义一帧中可运行的潜在操作循环数上限。 |
| `Sequencer.NetSyncThreshold` | `200` | （默认值：200毫秒。决定播放过程中客户端和服务器必须被强制重新同步的阈值。 |
| `Sequencer.Outliner.CompactHeight` | `22` | （默认值：22.f。）定义紧凑模式下大纲视图项目的高度。 |
| `Sequencer.Outliner.RelaxedHeight` | `28` | （默认值：28.f。）定义宽松模式下大纲视图项目的高度。 |
| `Sequencer.OutputDeferredMovementMode` | `0` | 整型值，指定如何从Sequencer输出具有延迟移动更新的场景组件：（0-默认值）不输出、（1-转储一次）在下一次求值时请求一次输出、（2-逐帧转储）逐帧转储所有移动更新 |
| `Sequencer.RelativeTimecodeSmoothing` | `1` | 如果非零，则从时间码相等时开始与平台时间累加。 |
| `Sequencer.SecondsPerFrame` | `1` | 逐帧播放模式下的每帧等待秒数。 |
| `Sequencer.SmartAutoBlendLocationPercentage` | `0.8` | 切线与相邻切线混合时接近下一个值的百分比，如果超过1.0则不混合。默认值为0.8 |
| `Sequencer.SmoothedMaxNetSyncSampleAge` | `5000` | （默认值：5000.执行平滑网络同步所需的取样范围（以毫秒为单位）。设为0可禁用平滑。 |
| `Sequencer.SmoothedMaxNetSyncSampleCount` | `50` | （默认值：50.内存中保存的取样数上限。 |
| `Sequencer.SmoothedNetSyncDeviationThreshold` | `200` | （默认值：200毫秒。定义平滑网络同步取样的可接受偏差值。超出此偏差值的取样将被丢弃。 |
| `Sequencer.StartTransformOffsetInBoneSpace` | `true` | 如果为true，则在骨骼空间中进行骨骼动画匹配的起始偏移；如果为false，则在根空间中进行。默认为true |
| `Sequencer.TagSaturation` | `0.6` | 定义饱和对象绑定标签在Sequencer UI中的出现方式。 |
| `Sequencer.ThreadedEvaluation.AllocationThreshold` | `32` | （默认值：32）实体分配碎片化的阈值，超过该阈值则使用线程化求值。 |
| `Sequencer.ThreadedEvaluation.EntityThreshold` | `256` | （默认值：256）定义启用线程化求值的实体数量。 |
| `Sequencer.TickIntervalGroupingResolutionMs` | `50` | 定义Actor刷新间隔分组的最大分辨率。当Actor有自定义的刷新间隔时，数值越大，则分组到一起的Actor越多，但t刷新间隔将越不精确。 |
| `Sequencer.TimeUndo` | `false` | 启用/禁用进行更改时撤消时间的功能 |
| `Sequencer.UseOldSequencerTrails` | `true` | 如果为true，则显示旧的运动尾迹，如果为false，则使用新的可编辑运动尾迹。 |
| `Sequencer.UseSoftObjectPtrsForPreAnimatedMaterial` | `true` | 定义是否使用软对象指针 (soft-object-ptrs) 来引用动画前状态（默认值），或使用强TObjectPtrs。 |
| `Sequencer.VolatileSequencesInEditor` | `1` | （默认值：1）如果非零，所有资产在编辑器中都将被视为易变资产。可以禁用，以绕过编辑器中的易变性检查，从而获得更具代表性的运行时性能指标。 |

## 序列化

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Serialization.AllowSidecarSyncing` | `false` | 为true时，如果首次加载失败，那么FEditorBulkData将尝试通过源控制同步其.upayload文件 |
| `Serialization.ApplyBulkDataOffsetFix` | `true` | 如果为true，则将尝试修复潜在的不良批量数据偏移 |
| `Serialization.LoadFromSidecar` | `false` | 如果为true，FEditorBulkData将从sidecar文件加载 |
| `Serialization.LoadFromTrailer` | `false` | 如果为true，FEditorBulkData将通过包标尾而非包本身加载负载 |
| `Serialization.RehydrateOnSave` | `false` | 如果为true，FVirtualizedUntypedBulkData虚拟化负载将在保存到包时进行水合并存储到本地 |
| `SettingsEditor.HideSetAsDefaultButton` | `false` | 隐藏保存到默认配置的设置编辑器（Settings Editor）按钮。 |

## 可伸缩性质量

| 列 1 | 列 2 | 列 3 |
| --- | --- | --- |
| `sg.AntiAliasingQuality` | `3` | 可伸缩性质量状态（可伸缩性系统内部使用，ini加载/保存或使用可伸缩性控制台命令）0：低、1：中、2：高、3：超高、4：电影级。默认值：3 |
| `sg.AntiAliasingQuality.NumLevels` | `5` | sg.AntiAliasingQuality中的质量级别设置数量。默认值：5 (0..4) |
| `sg.EffectsQuality` | `3` | 可伸缩性质量状态（可伸缩性系统内部使用，ini加载/保存或使用可伸缩性控制台命令）0：低、1：中、2：高、3：超高、4：电影级。默认值：3 |
| `sg.EffectsQuality.NumLevels` | `5` | sg.EffectsQuality中的质量级别设置数量。默认值：5 (0..4) |
| `sg.FoliageQuality` | `3` | 可伸缩性质量状态（可伸缩性系统内部使用，ini加载/保存或使用可伸缩性控制台命令）0：低、1：中、2：高、3：超高、4：电影级。默认值：3 |
| `sg.FoliageQuality.NumLevels` | `5` | sg.FoliageQuality中的质量级别设置数量。默认值：5 (0..4) |
| `sg.GlobalIlluminationQuality` | `3` | 可伸缩性质量状态（可伸缩性系统内部使用，ini加载/保存或使用可伸缩性控制台命令）0：低、1：中、2：高、3：超高、4：电影级。默认值：3 |
| `sg.GlobalIlluminationQuality.NumLevels` | `5` | sg.GlobalIlluminationQuality中的质量级别设置数量。默认值：5 (0..4) |
| `sg.LandscapeQuality` | `3` | 可伸缩性质量状态（可伸缩性系统内部使用，ini加载/保存或使用可伸缩性控制台命令）0：低、1：中、2：高、3：超高、4：电影级。默认值：3 |
| `sg.LandscapeQuality.NumLevels` | `5` | sg.LandscapeQuality中的质量级别设置数量。默认值：5 (0..4) |
| `sg.PostProcessQuality` | `3` | 可伸缩性质量状态（可伸缩性系统内部使用，ini加载/保存或使用可伸缩性控制台命令）0：低、1：中、2：高、3：超高、4：电影级。默认值：3 |
| `sg.PostProcessQuality.NumLevels` | `5` | sg.PostProcessQuality中的质量级别设置数量。默认值：5 (0..4) |
| `sg.ReflectionQuality` | `3` | 可伸缩性质量状态（可伸缩性系统内部使用，ini加载/保存或使用可伸缩性控制台命令）0：低、1：中、2：高、3：超高、4：电影级。默认值：3 |
| `sg.ReflectionQuality.NumLevels` | `5` | sg.ReflectionQuality中的质量级别设置数量。默认值：5 (0..4) |
| `sg.ResolutionQuality` | `100` | 可伸缩性质量状态（可伸缩性系统内部使用，ini加载/保存或使用可伸缩性控制台命令）10..100，默认值：100 |
| `sg.ShadingQuality` | `3` | 可伸缩性质量状态（可伸缩性系统内部使用，ini加载/保存或使用可伸缩性控制台命令）0：低、1：中、2：高、3：超高、4：电影级。默认值：3 |
| `sg.ShadingQuality.NumLevels` | `5` | sg.ShadingQuality中的质量级别设置数量。默认值：5 (0..4) |
| `sg.ShadowQuality` | `3` | 可伸缩性质量状态（可伸缩性系统内部使用，ini加载/保存或使用可伸缩性控制台命令）0：低、1：中、2：高、3：超高、4：电影级。默认值：3 |
| `sg.ShadowQuality.NumLevels` | `5` | sg.ShadowQuality中的质量级别设置数量。默认值：5 (0..4) |
| `sg.Test.CPUPerfIndexOverride` | `0` | GPU Benchmark返回的CPU性能指数的自定义重载。 |
| `sg.Test.GPUPerfIndexOverride` | `0` | GPU Benchmark返回的GPU性能指数的自定义重载。 |
| `sg.TextureQuality` | `3` | 可伸缩性质量状态（可伸缩性系统内部使用，ini加载/保存或使用可伸缩性控制台命令）0：低、1：中、2：高、3：超高、4：电影级。默认值：3 |
| `sg.TextureQuality.NumLevels` | `5` | sg.TextureQuality中的质量级别设置数量。默认值：5 (0..4) |
| `sg.ViewDistanceQuality` | `3` | 可伸缩性质量状态（可伸缩性系统内部使用，ini加载/保存或使用可伸缩性控制台命令）0：低、1：中、2：高、3：超高、4：电影级。默认值：3 |
| `sg.ViewDistanceQuality.NumLevels` | `5` | sg.ViewDistanceQuality中的质量级别设置数量。默认值：5 (0..4) |
| `shaderpipeline.MinPrecompileTasksInFlight` | `10` | 注意：仅在线程池PSO预编译处于活动状态时使用。 提交另一批作业前，正在进行的活动PSO预编译作业的数量。 即如果正在进行的预编译任务数量低于此阈值，那么可以添加下一批预编译任务。 这是为了防止预编译批次之间出现空挡，也是为了避免调度饱和。 |

## 显示标志

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `ShowFlag.ActorColoration` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.AmbientCubemap` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.AmbientOcclusion` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.AntiAliasing` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Atmosphere` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.AudioRadius` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.BillboardSprites` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Bloom` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Bones` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Bounds` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Brushes` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.BSP` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.BSPSplit` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.BSPTriangles` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.BuilderBrush` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.CameraAspectRatioBars` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.CameraFrustums` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.CameraImperfections` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.CameraInterpolation` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.CameraSafeFrames` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.CapsuleShadows` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Cloud` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Collision` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.CollisionPawn` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.CollisionVisibility` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.ColorGrading` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.CompositeEditorPrimitives` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Constraints` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.ContactShadows` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Cover` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.DebugAI` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.DebugDrawDistantVirtualSMLights` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Decals` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.DeferredLighting` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.DepthOfField` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Diffuse` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.DirectionalLights` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.DirectLighting` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.DisableOcclusionQueries` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.DistanceCulledPrimitives` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.DistanceFieldAO` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.DynamicShadows` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.EditingLevelInstance` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Editor` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.EyeAdaptation` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Fog` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.ForceFeedbackRadius` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Game` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.GameplayDebug` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.GBufferHints` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.GlobalIllumination` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Grain` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Grid` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.HeterogeneousVolumes` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.HighResScreenshotMask` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.HISMCClusterTree` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.HISMCOcclusionBounds` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.HitProxies` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.HLODColoration` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.HMDDistortion` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.IndirectLightingCache` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.InputDebugVisualizer` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.InstancedFoliage` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.InstancedGrass` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.InstancedStaticMeshes` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Landscape` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.LargeVertices` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.LensFlares` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.LightComplexity` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.LightFunctions` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.LightInfluences` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Lighting` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.LightingOnlyOverride` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.LightMapDensity` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.LightRadius` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.LightShafts` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.LocalExposure` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.LOD` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.LODColoration` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.LumenDetailTraces` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.LumenFarFieldTraces` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.LumenGlobalIllumination` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.LumenGlobalTraces` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.LumenReflections` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.LumenScreenTraces` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.LumenSecondaryBounces` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.LumenShortRangeAmbientOcclusion` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.MassProperties` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Materials` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.MaterialTextureScaleAccuracy` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.MediaPlanes` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.MeshEdges` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.MeshUVDensityAccuracy` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.ModeWidgets` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.MotionBlur` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.NaniteMeshes` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.NaniteStreamingGeometry` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Navigation` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Niagara` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.OcclusionMeshes` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.OnScreenDebug` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.OpaqueCompositeEditorPrimitives` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.OutputMaterialTextureScales` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.OverrideDiffuseAndSpecular` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Paper2DSprites` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Particles` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.PathTracing` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.PhysicalMaterialMasks` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.PhysicsField` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Pivot` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.PointLights` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.PostProcessing` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.PostProcessMaterial` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.PrecomputedVisibility` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.PrecomputedVisibilityCells` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.PreviewShadowsIndicator` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.PrimitiveDistanceAccuracy` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.QuadOverdraw` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.RayTracedDistanceFieldShadows` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.RayTracingDebug` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.RectLights` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.ReflectionEnvironment` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.ReflectionOverride` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Refraction` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Rendering` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.RequiredTextureResolution` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.SceneColorFringe` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.ScreenPercentage` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.ScreenSpaceAO` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.ScreenSpaceReflections` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Selection` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.SelectionOutline` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.SelectionOutlineColor0` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.SelectionOutlineColor1` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.SelectionOutlineColor2` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.SelectionOutlineColor3` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.SelectionOutlineColor4` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.SelectionOutlineColor5` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.SeparateTranslucency` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.ServerDrawDebug` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.ShaderComplexity` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.ShaderComplexityWithQuadOverdraw` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.ShaderPrint` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.ShadowFrustums` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.SkeletalMeshes` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.SkyLighting` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Snap` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Specular` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Splines` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.SpotLights` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.StaticMeshes` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.StationaryLightOverlap` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.StereoRendering` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.StreamingBounds` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.SubsurfaceScattering` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.TemporalAA` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.TestImage` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.TextRender` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.TexturedLightProfiles` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.ToneCurve` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Tonemapper` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Translucency` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VectorFields` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VertexColors` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Vignette` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VirtualShadowMapPersistentData` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VirtualTexturePendingMips` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VirtualTexturePrimitives` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VirtualTextureResidency` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisLog` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeBuffer` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeCalibrationColor` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeCalibrationCustom` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeCalibrationGrayscale` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeDistanceFieldAO` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeDOF` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeGlobalDistanceField` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeGPUSkinCache` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeGroom` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeHDR` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeInstanceOcclusionQueries` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeInstanceUpdates` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeLevelInstanceEditing` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeLightCulling` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeLightFunctionAtlas` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeLightingOnProbes` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeLocalExposure` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeLumen` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeMeshDistanceFields` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeMotionBlur` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeMotionVectors` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeNanite` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeOutOfBoundsPixels` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizePostProcessStack` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeReprojection` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeSenses` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeShadingModels` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeSkyAtmosphere` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeSkyLightIlluminance` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeSSR` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeSSS` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeSubstrate` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeTemporalUpscaler` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeTSR` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeVirtualShadowMap` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeVolumetricCloudConservativeDensity` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeVolumetricCloudEmptySpaceSkipping` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VisualizeVolumetricLightmap` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VolumeLightingSamples` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Volumes` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VolumetricFog` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VolumetricLightmap` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.VREditing` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.WidgetComponents` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |
| `ShowFlag.Wireframe` | `2` | 允许重载特定的显示标志（在编辑器和游戏中均可用，"显示（Show）"仅在游戏中可用，而UI仅在编辑器中可） 适合用相同的显示标志多次运行同一构建（如比在consolevariables.ini中设"showflag.abc=0"） 0：强制将显示标志设为OFF。 1：强制将显示标志设为ON。 2：不重载此显示标志（默认值）。 |

## Sig Man

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `SigMan.FilterTag` |  | 仅显示有指定过滤标签的对象。 如果为空，则显示具有任何标签的对象。 |
| `SigMan.ObjectsToShow` | `15` | 启用ShowDebug SignificanceManager时显示的对象数量。 |

## 骨骼网格体

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `SkeletalMesh.UseExperimentalChunking` | `0` | 编译LODModel时，是否为骨骼网格体使用试验性的分块算法。 |
| `SkinWeightProfileManager.AllowCPU` | `1` | 是否允许生成CPU缓冲区 |

## Slate

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Slate.AbsoluteIndices` | `0` | 0：0：每个元素的第一个顶点索引将从0开始（默认值）、1：使用绝对索引，简化不支持BaseVertex的RHI上的绘制调用设置 |
| `Slate.AccessibleWidgetsProcessedPerTick` | `100` | 为降低性能峰值，生成可访问控件树时，每次刷新可更新的控件数将被限为此数目。 |
| `Slate.AllowBackgroundBlurWidgets` | `1` | 如果为0，则不渲染后台模糊控件 |
| `Slate.AllowPerUserHitTesting` | `1` | 在以下两者之间切换：控件映射到用户ID，且输入事件需要匹配用户ID；或允许所有用户与控件交互 |
| `Slate.AllowSlateToSleep` | `0` | 当不存在激活的定时器且用户处于空闲状态时，Slate是否应进入休眠状态 |
| `Slate.AlwaysInvalidate` | `false` | 强制无效面板进行缓存，但始终进行无效化。 |
| `Slate.ApplyDisabledEffectOnWidgets` | `true` | 如果为true，则被禁用的游戏层控件的Alpha值将被乘以0.45。 |
| `Slate.BackgroundBlurDownsample` | `1` |  |
| `Slate.BackgroundBlurMaxKernelSize` | `255` | 允许的最大核大小。 注意：过大的数值可能导致性能大幅下降 |
| `Slate.bAllowNotifications` | `true` | 如果为false，则不向用户显示通知。 |
| `Slate.bAllowThrottling` | `1` | 允许Slate对引擎进行部分限制以确保UI响应 |
| `Slate.CheckUObjectRenderResources` | `true` |  |
| `Slate.CheckUObjectShapedGlyphSequence` | `true` |  |
| `Slate.Contrast` | `1` | 要应用于UI的对比度（默认值为1）。 |
| `Slate.CopyBackbufferToSlatePostRenderTargets` | `0` | 试验性。设为true即可将最终后台缓冲区复制到Slate渲染线程中，用于Slate的后期处理和材质使用 |
| `Slate.CullingSlackFillPercent` | `0.25` | 按指定大小缩放剔除框，以便为真实边界大于容器中根子控件大小的控件提供额外的回转余地。 |
| `Slate.CursorSignificantMoveDetectionThreshold` | `0` | 从上一个光标位置到下一个光标位置的距离，超过该距离的移动将被视为显著移动（用于触发提示文本的显示）。 |
| `Slate.Debug.TraceNavigationConfig` | `false` | 如果为true，则可将寻路配置和调用堆栈的跟踪记录到日志中。 |
| `Slate.DebugCulling` | `false` | 决定是否忽略裁剪框并仅使用剔除。 |
| `Slate.DefaultEnablePostRenderTarget_0` | `1` | 试验性。设为true即可启用Slate后期渲染目标0 |
| `Slate.DefaultTextFlowDirection` | `0` | 0：自动（默认），1：从左至右，2：从右至左。 |
| `Slate.DefaultTextShapingMethod` | `0` | 0：自动（默认），1：仅字距调整，2：完全塑形。 |
| `Slate.DeferRetainedRenderingRenderThread` | `0` | 是否推迟被保留的渲染，以使其与其余Slate渲染线程工作同时进行 |
| `Slate.DeferWindowsMessageProcessing` | `1` | 将窗口消息处理推迟到刷新时进行，或立即处理 |
| `Slate.DemoMode.KeyEvent` | `false` | 将按键行为可视化，以便进行演示录制。 |
| `Slate.DemoMode.MouseEvent` | `false` | 将光标事件可视化，以便进行演示录制。 |
| `Slate.DrawBatchNum` | `-1` | 。 |
| `Slate.DrawToVRRenderTarget` | `1` | 如果在VR中启用，则Slate UI将被绘制到渲染目标纹理中，正是在该纹理中渲染了任一侧眼睛的VR图像，从而让头戴式显示器的用户看到UI界面（无论好坏）。 如果启用了镜像，则该渲染目标纹理将被裁剪/缩放到后台缓冲区中。 禁用后，在镜像纹理被裁剪/缩放到后台缓冲区后，Slate UI将被绘制到后台缓冲区（而非头戴式显示器）之上。 |
| `Slate.DumpFontCacheStats` | `false` | 转储关于字体缓存使用情况的统计数据。 |
| `Slate.EnableCrashHandler` | `true` | Slate会将状态添加到崩溃报告器中。 |
| `Slate.EnableCursorQueries` | `true` |  |
| `Slate.EnableDeleteUnusedPostProcess` | `0` | 大于0的值意味着后期处理渲染目标在n帧后未被使用时将被删除。 |
| `Slate.EnableDesignerRetainedRendering` | `true` | 决定是否在设计器中渲染限位器；0 - 从不；1 - 按控件属性 |
| `Slate.EnableDrawEvents` | `1` | 。 |
| `Slate.EnableFastWidgetPath` | `false` | 是否启用快速控件路径控制。 此模式需依赖父指针才能正常运作。 |
| `Slate.EnableFontAntiAliasing` | `1` | 为字体渲染启用或禁用抗锯齿（0=禁用，1=启用）。默认启用。 |
| `Slate.EnableGamepadEditorNavigation` | `true` | True意味着允许游戏视口外的手柄寻路。 |
| `Slate.EnableGlobalInvalidation` | `false` |  |
| `Slate.EnableInvalidationPanels` | `true` | 是否尝试通过无效化面板缓存控件。 |
| `Slate.EnableLayoutLocalization` | `1` | 控制启用或禁用本地化布局，影响从左到右或从右到左的文化检测。 |
| `Slate.EnableLegacyFontHinting` | `0` | 是否启用旧版字体微调？（0/1）。 |
| `Slate.EnableRawInputSimulationOverRDP` | `1` |  |
| `Slate.EnableRetainedRendering` | `1` | 是否先在SRetainerWidgets进行渲染以尝试渲染目标。 |
| `Slate.EnableRetainedRenderingWithLocalTransform` | `true` | 此控制台变量已无用，因为由它解决的SRetainerWidget渲染漏洞已被修复。之后将删除此变量。 |
| `Slate.EnableSlateWidgetTracker` | `0` | 是否启用通过Slate控件追踪器追踪控件。 |
| `Slate.EnableSyntheticCursorMoves` | `true` |  |
| `Slate.EnableTooltips` | `true` | 是否允许生成提示文本。 |
| `Slate.EnsureAllVisibleWidgetsPaint` | `false` | 确保如果子控件在OnPaint之前可见，则在OnPaint之后的这一帧中绘制该控件（如果仍标记为可见）。 仅对FastPaintPath生效。 |
| `Slate.EnsureOutgoingLayerId` | `false` | 确保子控件通过OnPaint返回正确的图层ID。 |
| `Slate.FlushFontCache` | `false` | 清空字体缓存。 |
| `Slate.Font.AsyncLazyLoad` | `false` | 对延迟加载的未加载字体进行异步加载，在此之前字体无法被正确地测量。 一旦完成，UI将失效化。 |
| `Slate.ForceBackgroundBlurLowQualityOverride` | `0` | 是否强制使用Slate笔刷，而不是直接将背景模糊化 |
| `Slate.ForceRawInputSimulation` | `0` |  |
| `Slate.GameLayer.AllCanvasesVisible` | `true` | 显示/隐藏视口插槽、玩家画布以及调试画布。 |
| `Slate.GameLayer.DebugCanvasVisible` | `true` | 显示/隐藏调试画布。 |
| `Slate.GameLayer.PlayerCanvasVisible` | `true` | 显示/隐藏玩家画布。 |
| `Slate.GameLayer.ViewportSlotVisible` | `true` | 显示/隐藏视口中的插槽 |
| `Slate.GlobalScrollAmount` | `32` | 每点击一次鼠标滚轮所滚动的距离（使用Slate屏幕单位）。 |
| `Slate.GrowFontAtlasFrameWindow` | `1` | 字体图集将调整大小而非清空的帧数。 |
| `Slate.GrowFontNonAtlasFrameWindow` | `1` | 大字体字形池将调整大小而非清空的帧数。 |
| `Slate.GrowSVGAtlasFrameWindow` | `1` | 图集将调整大小而非清空的帧数。 |
| `Slate.GrowSVGNonAtlasFrameWindow` | `1` | 大型池将调整大小而非清空的帧数。 |
| `Slate.HitTestGridDebugging` | `false` | 是否将命中测试网格中所有内容可视化 |
| `Slate.Input.MotionFiresUserInteractionEvents` | `true` | 如果false，则不会根据运动输入触发LastUserInteractionTimeUpdateEvent事件，也不会更新LastInteractionTime。有些运动设备会不断报告不经过滤的微小变化，因此运动输入对确定用户的活动而言毫无帮助 |
| `Slate.InvalidationDebugging` | `false` | 已废弃 - 请使用SlateDebugger.Invalidate.Enable |
| `Slate.InvalidationList.EnableReindexLayerId` | `false` | 无效化系统中，当绘制的控件返回比之前更大的LayerId时，则重新索引其他控件。 |
| `Slate.InvalidationList.MaxArrayElements` | `64` | 无效化系统中，首选元素数组的大小。 |
| `Slate.InvalidationList.NumberElementLeftBeforeSplitting` | `40` | 无效化系统中，拆分数组时，只有当剩余元素数小于指定值时才进行拆分。 |
| `Slate.InvalidationRoot.DumpPostInvalidationList` | `false` | 逐帧记录更新后阶段所处理的控件。 |
| `Slate.InvalidationRoot.DumpPreInvalidationList` | `false` | 逐帧记录更新前阶段所处理的控件。 |
| `Slate.InvalidationRoot.DumpPrepassInvalidationList` | `false` | 逐帧记录预通道阶段所处理的控件。 |
| `Slate.InvalidationRoot.DumpUpdateList` | `false` | 逐帧记录待更新的控件。 |
| `Slate.InvalidationRoot.DumpUpdateListOnce` | `false` | 记录将在本帧更新的控件。 |
| `Slate.InvalidationRoot.VerifyHittestGrid` | `false` | 每次刷新时，验证命中测试网格。 |
| `Slate.InvalidationRoot.VerifySlateAttribute` | `false` | 每次刷新时，验证已注册属性的控件是否被正确地更新了一次，以及列表是否包含所有的控件。 |
| `Slate.InvalidationRoot.VerifyValidWidgets` | `false` | 每次刷新时，验证所有WidgetProxy是否具有生效的SWidget。 |
| `Slate.InvalidationRoot.VerifyWidgetHeapContains` | `false` | 验证在添加控件前控件是否不在列表中。 |
| `Slate.InvalidationRoot.VerifyWidgetList` | `false` | 每次刷新时，验证更新后的列表匹配新建的列表。 |
| `Slate.InvalidationRoot.VerifyWidgetsAreUpdatedOnce` | `false` | 验证控件是否每次刷新仅被绘制一次。 |
| `Slate.InvalidationRoot.VerifyWidgetsIndex` | `false` | 每次刷新时，验证所有控件对应的索引是否正确。 |
| `Slate.InvalidationRoot.VerifyWidgetUpdateList` | `false` | 每次刷新时，验证更新前后的列表包含正确的信息，而且已排序。 |
| `Slate.InvalidationRoot.VerifyWidgetVisibility` | `false` | 每次刷新时，验证是否正确设置了控件的缓存可视性。 |
| `Slate.InvalidationRoot.VerifyWidgetVolatile` | `false` | 每次刷新时，验证易变控件是否被正确标记了且位于正确的列表中。 |
| `Slate.LogPaintedText` | `false` | 如果为true，则用户可见的所有文本都将在绘制时被记录。将记录待绘制的完整文本，而不是基于UI限制的截断或剪切版本。 |
| `Slate.MaxFontAtlasPagesBeforeFlush` | `1` | 若纹理图集已满，在清空字体缓存前，被创建和使用的字体图集纹理数量 |
| `Slate.MaxFontNonAtlasTexturesBeforeFlush` | `1` | 大字形字体纹理的初始数量。 |
| `Slate.MaxSVGAtlasPagesBeforeFlush` | `1` | 若纹理图集已满，在清空缓存前，被创建和使用的图集纹理数量 |
| `Slate.MaxSVGNonAtlasTexturesBeforeFlush` | `1` | 大型纹理的初始数量。 |
| `Slate.MemorylessDepthStencil` | `0` | 是否为Slate使用无内存的DepthStencil目标。这将减少内存占用，并意味着DepthStencil的状态无法在Slate渲染通道之间被保存 |
| `Slate.OutlineFontRenderMethod` | `0` | 更改轮廓字体的渲染方法。 0 = 由Freetype完成所有工作并为基本字形生成位图（默认值）。 1 = 重载Freetype光栅器。 这有助于解决部分复杂字体的渲染异常问题。 |
| `Slate.OverrideScissorRect` | `1` | 是否允许Slate对UI元素应用剪刀裁剪，以防止出现某些瑕疵。 在VR环境中通过镜像后台缓冲区绘制UI时，可能需要禁用此功能。 |
| `Slate.PreventDuplicateMouseEventsForTouchForWindows7` | `0` | 破解方法，对Windows 7及更低版本，可避免因触摸事件触发复数鼠标事件的问题。 启用此功能将让数位板无法使用Windows 7，因为在切换到Windows 8 SDK（并能使用WM_POINTER*事件）之前，无法检测两者之间的区别 |
| `Slate.RequireFocusForGamepadInput` | `false` | 如果应用程序当前未激活，引擎是否应忽略游戏手柄的输入 |
| `Slate.ResourceManager.LockResourceDuringGC` | `true` | 在进行垃圾回收和加载屏幕拥有所有权时，锁定Slate RHI资源管理器，以防止多线程资源访问。 |
| `Slate.ShouldFollowCultureByDefault` | `0` | 是否应该首先遵循窗口级别的文化流动方向。 |
| `Slate.ShowBatching` | `0` | 0：不显示批处理、1：显示批处理 |
| `Slate.ShowClipping` | `false` | 是否渲染裁剪区域轮廓。 黄色=轴剪刀框裁剪（低耗）。 红色=模板裁剪（高耗）。 |
| `Slate.ShowOverdraw` | `0` | 0：不显示过度绘制、1：显示过度绘制 |
| `Slate.ShowTextDebugging` | `0` | 显示文本渲染的调试绘制。 |
| `Slate.ShowWireFrame` | `0` |  |
| `Slate.SleepBufferPostInput` | `0` | 无用户操作时，Slate进入休眠状态所需的时间（前提是无激活的定时器）。 |
| `Slate.SoftwareCursorScale` | `1` | 应用至软件光标的缩放系数。要求光标控件具有缩放感知功能。 |
| `Slate.TargetFrameRateForResponsiveness` | `35` | 编辑器响应速度满足"流畅的UI体验"所需的最小持续平均帧率 |
| `Slate.ThrottleWhenMouseIsMoving` | `0` | 是否尝试根据光标的移动来提高UI的响应速度。 |
| `Slate.TooltipIntroDuration` | `0.1` | 提示文本动画进入视图所需的时间，以秒为单位。 |
| `Slate.TooltipSummonDelay` | `0.15` | 光标悬停在提供提示文本数据的控件上时，在光标附近显示提示文本的延迟秒数。 |
| `Slate.ToolTipWrapWidth` | `1000` | Slate提示文本进行换行前的宽度 |
| `Slate.Transform.FullscreenMouseInput` | `true` | 设为true可转换鼠标输入，以便在显示器非原生支持的全屏分辨率下，处理视口的拉伸问题。 |
| `Slate.UnloadFreeTypeDataOnFlush` | `1` | 清空字体缓存时，释放空闲的类型数据 |
| `Slate.UseFixedDeltaTime` | `false` | True表示在每次控件刷新时使用恒定的增量时间。 |
| `Slate.VerifyParentChildrenRelationship` | `false` | 每次刷新时，验证一个控件是否只具有一个父项。 |
| `Slate.VerifyWidgetLayerId` | `false` | 每次刷新时，验证控件的LayerId范围是否与其兄弟项和父项一致。 |
| `Slate.WorldWidgetIgnoreNotVisibleWidgets` | `false` | 如果世界控件不可见，是否不更新它们的位置，以防止不必要地使整个图层无效化 |
| `Slate.WorldWidgetZOrder` | `1` | 是否按视点距离对投射到屏幕上的世界控件进行重新排序。0：禁用重新排序。1：按距离重新排序（默认值，减少控件重叠时的批处理和瑕疵） |
| `SlateDebugger.bCaptureRootInvalidationCallstacks` | `0` | 只要控件是导致无效化的根本原因，就捕获Slate Insights的调用堆栈。 |
| `SlateDebugger.Event.CaptureStack` | `false` | 是否在发生事件时捕获堆栈？ |
| `SlateDebugger.Event.InputRoutingModeEnabled` | `false` | 是否输出输入事件所用的路径？ |
| `SlateDebugger.Event.LogAttemptNavigationEvent` | `true` | 记录尝试寻路事件 |
| `SlateDebugger.Event.LogCaptureStateChangeEvent` | `true` | 记录光标状态更改事件 |
| `SlateDebugger.Event.LogCursorChangeEvent` | `true` | 记录光标更改事件 |
| `SlateDebugger.Event.LogExecuteNavigationEvent` | `true` | 记录执行寻路事件 |
| `SlateDebugger.Event.LogFocusEvent` | `true` | 记录焦点事件 |
| `SlateDebugger.Event.LogInputEvent` | `true` | 记录输入事件 |
| `SlateDebugger.Event.LogWarning` | `true` | 记录警告事件 |
| `SlateDebugger.Invalidate.bLogInvalidatedWidget` | `false` | 将无效控件记录到控制台的选项。 |
| `SlateDebugger.Invalidate.bShowLegend` | `false` | 显示颜色图例的选项。 |
| `SlateDebugger.Invalidate.bShowWidgetList` | `true` | 显示被无效化控件名称的选项。 |
| `SlateDebugger.Invalidate.bUsePerformanceThreshold` | `false` | 仅在性能低于阈值（以毫秒为单位）时，才显示被无效化的控件和/或将其记录。 |
| `SlateDebugger.Invalidate.Enabled` | `false` | 开始/停止无效化控件调试工具。显示被无效化的控件。 |
| `SlateDebugger.Invalidate.ThresholdPerformanceMS` | `1.5` | 针对bUsePerformanceThreshold，记录和/或显示被无效化的控件前要达到的阈值，以毫秒为单位。 |
| `SlateDebugger.InvalidationRoot.Enable` | `false` | 开始/停止无效化根控件调试工具。在无效化根控件使用慢速路径或快速路径时显示。 |
| `SlateDebugger.Paint.Enable` | `false` | 开始/停止被绘制的控件调试工具。在控件被绘制时显示。 |
| `SlateDebugger.Paint.LogWarningIfWidgetIsPaintedMoreThanOnce` | `true` | 记录警告的选项，如果控件在单个帧中被绘制多次，则记录警告。 |
| `SlateDebugger.Paint.MaxNumberOfWidgetDisplayedInList` | `20` | DisplayWidgetNameList处于激活状态时将显示的最大控件数量。 |
| `SlateDebugger.Paint.OnlyGameWindow` | `true` | 仅调试游戏窗口的选项 |
| `SlateDebugger.Update.Enable` | `false` | 开始/停止被绘制的控件调试工具。在控件被更新时显示。 |
| `SlateDebugger.Update.OnlyGameWindow` | `true` | 仅调试游戏窗口的选项 |
| `SlateDebugger.Update.SetInvalidationRootIdFilter` | `-1` | 仅显示属于无效根控件的选项。 |
| `SlateSdfText.Enable` | `false` | 在Slate中启用基于MSDF的文本渲染 |
| `SlateSdfText.GeneratorPoolSize` | `1` | 设置为Slate文本字形生成多通道距离场时并发任务的数量上限 |

## 源码管理

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `SourceControl.LoginDialog.ForceModal` | `false` | 强制SourceControl的"登录对话框"始终为模态对话框。 |
| `SourceControl.P4.AllowNonTicketLogins` | `false` | 是否允许直接从Perforce对话框使用密码登录。默认关闭，因为该选项并不安全。Perforce通常会在环境变量中将密码设为纯文本 |
| `SourceControl.Perforce.IdleConnectionDisconnectSeconds` | `3600` | Perforce连接在无活动的情况下保持连通再自动断开的秒数 |
| `SourceControl.Revert.EnableFromSceneOutliner` | `false` | 允许由SceneOutliner触发SourceControl的"还原"操作。 |
| `SourceControl.Revert.EnableFromSubmitWidget` | `false` | 允许由SubmitWidget触发SourceControl的"还原"操作。 |
| `SourceControl.RevertUnsaved.Enable` | `false` | 允许由未保存的资产触发SourceControl的"还原"操作。 |
| `SourceControlAssetDataCache.MaxAsyncTask` | `8` | 并行运行以获取AssetData信息的任务数上限。 |

## 旁观者信标

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `spectatorbeacon.DelayCancellationResponse` | `0` | 从收到取消响应到通知之间的延迟时间，以秒为单位 |
| `spectatorbeacon.DelayFullResponse` | `0` | 从收到全面响应到通知之间的延迟时间，以秒为单位 |
| `spectatorbeacon.DelayReservationResponse` | `0` | 从收到响应到通知之间的延迟时间，以秒为单位 |
| `spectatorbeacon.DelayUpdateResponse` | `0` | 从收到更新响应到通知之间的延迟时间，以秒为单位 |

## 喷涌动画

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `SpewAnimRateOptimization` | `0` | 设为true以喷出整体动画率优化的刷新率。 |

## 样条线

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `splines.blockall` | `0` | 强制样条线始终使用BlockAll碰撞配置文件，而不是CollisionProfileName属性中存储的配置文件 |
| `StallDetector.ForceLogOnStall` | `false` | 即使禁用了报告模式，也强制StallDetector在verbosity=Log时向LogStall发送日志 |

## 统计数据

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `stats.AutoEnableNamedEventsWhenProfiling` | `false` | 如果为1，则在检测到分析器并进行捕获时，打开具名事件。如果为0或分析停止时，则关闭具名事件。 |
| `stats.MaxPerGroup` | `25` | 群组中可显示的统计数据的最大行数 |
| `stats.SpewSpam` | `0` | 如果为1，则定期打印进入统计系统的消息概述。应尽量减少消息以减少开销。 |

## 时间

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `t.DumpHitches.AllThreads` | `0` | 执行Stat Dumphitch时转储所有线程 0：仅游戏线程和渲染线程（默认值） 1：所有线程 |
| `t.FPSChart.DoCsvProfile` | `0` | 记录FPS图表数据时，是否记录CSV文件。默认值：0 |
| `t.FPSChart.ExcludeIdleTime` | `0` | 绘制FPS图表时，是否应排除空闲时间（即休眠时间）？ 默认值：0 |
| `t.FPSChart.InterestingFramerates` | `30,60,120` | 以逗号分隔的特定帧率列表。默认值：30,60,120 |
| `t.FPSChart.MaxFrameDeltaSecsBeforeDiscarding` | `10` | FPS图表分箱时应考虑的帧的最大长度（以秒为单位）（默认为1.0秒；如果小于等于0.0，则不考虑最大长度）。 |
| `t.FPSChart.OpenFolderOnDump` | `1` | 转储完成后，是否应打开包含.log等文件的文件夹？ 在自动测试时可禁用此选项。默认值：1 |
| `t.FPSChart.RoundFPSBeforeBinning` | `0` | 绘制FPS图表时，是否应该先将原始FPS值四舍五入，然后再将其阈值化为分箱数值？ 默认值：0 |
| `t.HitchDeadTimeWindow` | `200` | 记录新卡顿前经过的最短时间（以毫秒为单位）。默认值：200.0毫秒 |
| `t.HitchFrameTimeThreshold` | `60` | 卡顿帧的定义（以毫秒为单位）。默认值：60.0毫秒 |
| `t.HitchVersusNonHitchRatio` | `1.5` | 当前帧必须比前一帧慢至少此倍数才会被视为卡顿。 实际比率被限制在此值和t.HitchFrameTimeThreshold/t.TargetFrameTimeThreshold之间。默认值：1.5 |
| `t.IdleWhenNotForeground` | `0` | 防止引擎在不作为前台应用程序时占用CPU或GPU时间。 |
| `t.MaxFPS` | `0` | 将FPS上限限制为给定数值。 小于等于0时将禁用限制。 |
| `t.OverrideFPS` | `0` | 这样就可以用固定的FPS数值重载帧时间的测量（游戏运行速度可能更快，也可能更慢）。 <=0：关闭，单位为帧每秒，例如60 |
| `t.SlowFrameLoggingThreshold` | `0` | 帧的速度必须多慢（以秒为单位）才会被记录（小于等于0即禁用）。 |
| `t.TargetFrameTimeThreshold` | `33.9` | 目标帧时间（以毫秒为单位）。低于此值将绘制为绿色，高于此值将绘制为黄色或红色，视严重程度而定。默认值：33.9毫秒 |
| `t.TickComponentLatentActionsWithTheComponent` | `1` | 是否应该在组件触发的同时刷新组件的潜在操作？ 0：在帧的较后部分刷新组件的潜在操作（4.16之前的行为，为依赖旧行为的游戏提供，但将来会删除）。1：在组件触发的同时刷新组件的潜在操作（默认值）。 |
| `t.UnacceptableFrameTimeThreshold` | `50` | 被视为完全不可接受的帧时间阈值（以毫秒为单位）。超过此值将绘制为红色。默认值：50.0毫秒 |
| `t.UnsteadyFPS` | `0` | 使FPS在8-32范围内随机跳动。 |

## 镜头试拍录制器

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `TakeRecorder.AllowMenuExtensions` | `true` |  |
| `TakeRecorder.SaveRecordedAssetsOverride` | `0` | 0：根据用户设置保存录制的资产。1：重载保存录制的资产，以始终在"启用"时开始 |

## 任务图表

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `TaskGraph.EnableForkedMultithreading` | `true` | 为false时，将阻止任务图表在分叉进程上以多线程运行。 |
| `TaskGraph.ForkedProcessMaxWorkerThreads` | `2` | 如果分叉进程允许多线程运行，则配置分叉进程应生成的工作线程数。 |
| `TaskGraph.IgnoreThreadToDoGatherOn` | `0` | 已废弃！如果为1，那么忽略SetGatherThreadForDontCompleteUntil提供的提示，直接在AnyHiPriThreadHiPriTask上运行。 |
| `TaskGraph.NumForegroundWorkers` | `2` | 前台工作线程的数量。需重新启动调度程序才能生效 |
| `TaskGraph.PrintBroadcastWarnings` | `1` | 如果值>0，那么任务图表将在等待广播时发出警告 |
| `TaskGraph.RenderThreadPollPeriodMs` | `1` | 渲染线程轮询周期，以毫秒为单位。如果值<0，那么任务图表任务将唤醒渲染线程，否则渲染线程将轮询任务。 |
| `TaskGraph.TaskPriorities.AsyncEndOfFrameGameTasks` | `hnn` | 试验性异步末端帧任务的任务和线程优先级。 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.AsyncEndOfFrameGameTasks bnh |
| `TaskGraph.TaskPriorities.AsyncTraceTask` | `nnn` | 异步追踪的任务和线程优先级。 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.AsyncTraceTask bnh |
| `TaskGraph.TaskPriorities.ClearAudioChunkCacheReadRequest` | `bnn` | 清除FCacheElement::ReadRequest的异步任务的任务和线程优先级。参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.ClearAudioChunkCacheReadRequest bnh |
| `TaskGraph.TaskPriorities.CompilePipelineStateTask` | `hnn` | FCompilePipelineStateTask的任务和线程优先级。 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.CompilePipelineStateTask bnh |
| `TaskGraph.TaskPriorities.FMeshDrawCommandPassSetupTask` | `nnn` | FMeshDrawCommandPassSetupTask的任务和线程优先级。 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.FMeshDrawCommandPassSetupTask bnh |
| `TaskGraph.TaskPriorities.GatherShadowPrimitives` | `hnn` | GatherShadowPrimitives任务的任务和线程优先级。 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.GatherShadowPrimitives bnh |
| `TaskGraph.TaskPriorities.HiPriAsyncTickTaskPriority` | `hnn` | 高优先级异步刷新的任务和线程优先级。 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.HiPriAsyncTickTaskPriority bnh |
| `TaskGraph.TaskPriorities.IoDispatcherAsyncTasks` | `bnn` | IoDispatcher解压缩的任务和线程优先级。 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.IoDispatcherAsyncTasks bnh |
| `TaskGraph.TaskPriorities.NavTriggerAsyncQueries` | `bnn` | UNavigationSystemV1::PerformAsyncQueries的任务和线程优先级。 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.NavTriggerAsyncQueries bnh |
| `TaskGraph.TaskPriorities.NormalAsyncTickTaskPriority` | `nnn` | 非高优先级异步刷新的任务和线程优先级。 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.NormalAsyncTickTaskPriority bnh |
| `TaskGraph.TaskPriorities.ParallelAnimationEvaluationTask` | `hnn` | FParallelAnimationEvaluationTask的任务和线程优先级。参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.ParallelAnimationEvaluationTask bnh |
| `TaskGraph.TaskPriorities.ParallelAnimCompletionTaskHighPriority` | `true` | 让并行动画完成任务在游戏线程上获得优先权，以便提前启动进一步的工作（如有需要）。 |
| `TaskGraph.TaskPriorities.ParallelBlendPhysicsTask` | `hnn` | FParallelBlendPhysicsTask的任务和线程优先级。 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.ParallelBlendPhysicsTask bnh |
| `TaskGraph.TaskPriorities.ParallelClothTask` | `hnn` | 并行布料的任务和线程优先级。 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.ParallelClothTask bnh |
| `TaskGraph.TaskPriorities.ParallelTranslateCommandList` | `nnn` | FParallelTranslateCommandList的任务和线程优先级。 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.ParallelTranslateCommandList bnh |
| `TaskGraph.TaskPriorities.ParallelTranslateCommandListPrepass` | `nnn` | 用于预通道的FParallelTranslateCommandList的任务和线程优先级。应该将其尽快送到GPU。 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.ParallelTranslateCommandListPrepass bnh |
| `TaskGraph.TaskPriorities.ParticleAsyncTask` | `hnn` | FParticleAsyncTask的任务和线程优先级。 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.ParticleAsyncTask bnh |
| `TaskGraph.TaskPriorities.ParticleManagerAsyncTask` | `hnn` | FParticleManagerAsyncTask的任务和线程优先级。 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.ParticleManagerAsyncTask bnh |
| `TaskGraph.TaskPriorities.PhysicsTickTask` | `hnn` | Chaos物理系统刷新后的任务和线程优先级。参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.PhysicsTickTask bnh |
| `TaskGraph.TaskPriorities.RHIThreadOnTaskThreads` | `nnn` | 在任何线程上运行"RHI线程"时的任务和线程优先级。 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.RHIThreadOnTaskThreads bnh |
| `TaskGraph.TaskPriorities.SceneRenderingTask` | `nnn` | 各种场景渲染任务的任务和线程优先级。 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.SceneRenderingTask bnh |
| `TaskGraph.TaskPriorities.TickCleanupTaskPriority` | `nnn` | 刷新清扫的任务和线程优先级。 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.TickCleanupTaskPriority bnh |
| `TaskGraph.TaskPriorities.TickDispatchTaskPriority` | `hnn` | 刷新任务调度的任务和线程优先级。 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.TickDispatchTaskPriority bnh |
| `TaskGraph.TaskPriorities.UpdateCachePrimitivesTask` | `hnn` | FUpdateCachePrimitivesTask的任务和线程优先级。 参数为三个字符：[ThreadPriority][TaskPriority][TaskPriorityIfForcedToNormalThreadPriority]，其中，ThreadPriority为'h'、'n'或'b'（高/正常/后台），TaskPriority为'h'或'n'（高/正常）。示例：TaskGraph.TaskPriorities.UpdateCachePrimitivesTask bnh |
| `TaskGraph.TestCriticalLockFree` | `0` | 如果>0，那么将在无锁列表的临界点定期休眠。线程不能发生饥饿......这将鼓励它们在正确的位置发生饥饿，以找到活锁。 |
| `TaskGraph.TestDontCompleteUntilForAlreadyComplete` | `1` | 如果值为1，那么在生成采集任务前，只需检查是否已完成所有子任务，若情况如此则可跳过采集任务。 |
| `TaskGraph.UseBackgroundThreads` | `1` | 如果值>0则使用后台线程，否则请用正常优先级任务线程运行后台任务。用于性能调整。 |
| `TaskGraph.UseDynamicPrioritization` | `true` | 逐任务调整线程优先级，从而避免在后台线程上运行的高优先级任务被轻易抢占。在高负载时尤为有效。 |
| `TaskGraph.UseHiPriThreads` | `1` | 如果值>0则使用高优先级线程，否则请用正常优先级任务线程运行后台任务。用于性能调整。 |

## Tex

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Tex.AsyncDXTBlocksPerBatch` | `2048` | DXT压缩的并行压缩块数。 |

## 刷新

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `tick.AllowAsyncComponentTicks` | `1` | 用于控制异步组件的刷新。 |
| `tick.AllowAsyncTickCleanup` | `0` | 如果为true，则在任务线程中清扫刷新。 |
| `tick.AllowAsyncTickDispatch` | `0` | 如果为true，则在任务线程中调度刷新。 |
| `tick.AllowConcurrentTickQueue` | `1` | 如果为true，则将刷新同时排队。 |
| `tick.AnimationDelaysEndGroup` | `1` | 如果值>0，那么不依赖物理模拟的骨骼网格体会将其动画末端刷新组设置为TG_PostPhysics。 |
| `tick.DoAsyncEndOfFrameTasks` | `0` | 与HUD渲染并发运行各种任务的试验性选项。 |
| `tick.DoAsyncEndOfFrameTasks.Randomize` | `0` | 用于向tick.DoAsyncEndOfFrameTasks添加随机休眠，以摆脱任一线程上的漏洞。还能用游戏线程进行随机的渲染线程清空。 |
| `tick.DoAsyncEndOfFrameTasks.ValidateReplicatedProperties` | `0` | 如果为true，则验证复制的属性在Slate刷新期间未发生变化。如果同时启用了demo.ClientRecordAsyncEndOfFrame，结果将无效。 |
| `tick.HiPriSkinnedMeshes` | `1` | 如果值>0，则将蒙皮组件的更新排在同组其他刷新之前。 |
| `tick.LightweightTimeguardThresholdMS` | `0` | 刷新时间保护的阈值，以毫秒为单位 |
| `tick.LogTicks` | `0` | 喷出用于调试的刷新。 |
| `tick.MinimizedSyncDrawToGPU` | `1` | True表示在最小化时等待GPU空闲。防止最小化时因CPU发布的绘制比GPU进程更快而导致的内存泄漏。 |
| `tick.SecondsBeforeEmbeddedAppSleeps` | `1` | 以嵌入式方式编译时，在休眠前要执行的刷新次数 |
| `tick.ShowPrerequistes` | `1` | 显示记录刷新时的前置条件；调试。 |

## 时间码

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `timecode.UseDropFormatTimecodeByDefaultWhenSupported` | `true` | 默认情况下，当帧率支持丢帧格式时，是否应该生成丢帧格式的时间码。 |

## 定时器管理器

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `TimerManager.BuildTimerSourceList` | `0` | 如果非零，逐帧追踪过期的定时器。在关机时或标记变回0时将其转储。 0：关闭 1：开启 - 按类将定时器分组（适合聚焦于整个系统，尤其针对需要考虑聚合的不平稳帧）。2：开启 - 不按类将定时器分组（适合单个实例有问题的情况）。 |
| `TimerManager.DumpAllTimerLogsThreshold` | `-1` | 将所有活动定时器信息转储到日志的阈值（以活动定时器的数量为单位）。-1即禁用。注意：每次进程启动时只会转储一次。 |
| `TimerManager.DumpTimerLogResolveVirtualFunctions` | `1` | 在记录定时器信息时尽可能解决虚拟函数问题。 |
| `TimerManager.DumpTimerLogsThreshold` | `0` | 以毫秒为单位的阈值。超过该阈值后将记录定时器信息，以尝试帮助追踪定时器代码中的峰值。设为0以禁用 |
| `TimerManager.DumpTimerLogSymbolNames` | `1` | 如果值为1，则在记录计时器信息时将包含符号名称。 |
| `TimerManager.MaxExpiredTimersToLog` | `30` | 若单帧内的TimerData数量上限超出阈值，需进行记录的数量。 |

## 追踪

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Trace.SlowTaskMaxRegionDepth` | `2` | 在Insights中作为追踪区域创建的嵌套慢速任务的最大深度 |

## 追踪异步加载请求

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `TrackAsyncLoadRequests.Dedupe` | `0` | 如果值>0，则删除报告中异步加载相同包的重复请求。 |
| `TrackAsyncLoadRequests.DumpAfterCsvProfiling` | `1` | 如果值>0，则在csv分析结束时将追踪到的异步加载请求转储到文件中。 |
| `TrackAsyncLoadRequests.Enable` | `0` | 如果值>0，则删除计数进程中的别名。这实际上是合并具有相同人工可读字符串的地址。它更慢。 |
| `TrackAsyncLoadRequests.RemoveAliases` | `1` | 如果值>0，则删除计数进程中的别名。这实际上是合并具有相同人工可读字符串的地址。它更慢。 |
| `TrackAsyncLoadRequests.StackIgnore` | `5` | 从堆栈帧顶部丢弃的项目数。 |
| `TrackAsyncLoadRequests.StackLen` | `12` | 要保留的堆栈帧项目的数量上限。这将改进聚合，因为从不同位置发出但最终到达同一位置的调用将一起计算。 |
| `TrackAsyncLoadRequests.Threshhold` | `0` | 报告中要包含的命中数下限。 |

## 事务缓冲区

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `TransBuffer.DumpObjectMap` | `false` | 是否在每次为调试目的写入事务时转储对象映射。 |

## 类型元素

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `TypedElements.EnableElementsCopyAndPaste` | `0` | 是否启用对元素复制和粘贴的支持？ |
| `TypedElements.EnableFoliageInstanceElements` | `0` | 是否对植被拥有的实例启用静态网格体实例元素支持？ |
| `TypedElements.EnableReferenceTracking` | `0` | 是否启用对元素引用追踪的支持？ |
| `TypedElements.EnableSMInstanceElements` | `1` | 是否启用对静态网格体实例元素的支持？ |
| `TypedElements.EnableViewportSMInstanceSelection` | `1` | 启用在关卡编辑器视口中直接选择"实例化静态网格体组件（ISMC）实例"的功能 |

## UMG

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `UMG.AnimationBudgetMs` | `0` | （默认值：0.0）试验性：用于对本帧所有UMG动画进行求值的逐帧动画预算。 |
| `UMG.AnimationMarkers` | `false` | （默认值：false）是否在启动和停止UMG动画时发出分析帧标识。 |
| `UMG.AsyncAnimationControlFlow` | `true` | （默认值：true）是否异步执行动画控制流功能（如播放、暂停、停止等）。 |
| `UMG.Editor.EnableWidgetDesignerTools` | `1` | 开关对控件设计器工具的处理。必须在打开控件设计器前进行设置。 |
| `UMG.EnablePreviewMode` | `false` | 是否启用UMG预览模式。 |
| `UMG.FlushAnimationsAtEndOfFrame` | `1` | 是在帧末端自动清空所有未完成的动画，还是等到下一帧。 |
| `UMG.ThumbnailRenderer.Enable` | `true` | 启用或禁用略缩图渲染的选项。 |

## 虚拟资产

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `VA.AllowPkgVirtualization` | `true` | 当值为true时，在编辑器中提交包将不再触发虚拟化进程 |
| `VA.DisableSystem` | `false` | 当值为true时，禁用虚拟资产系统，就像"SystemName"为"None"一样。 |
| `VA.LazyInitConnections` | `false` | 当值为true时，虚拟资产后端将推迟创建连接，直到被首次使用 |
| `VA.LazyInitSystem` | `false` | 当值为true时，虚拟资产系统将在首次使用时进行延迟初始化 |

## VI

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `VI.ActorSnap` | `0` | 是否对齐到场景中的Actor。默认禁用。设为1以启用。 |
| `VI.AlignCandidateDistance` | `2` | 候选Actor与可变换对象之间的距离（以可变换对象大小的倍数表示） |
| `VI.AllowCarryingCertainObjects` | `1` | 启用后，用户只需单手拖动即可自由移动和旋转某些选定对象。 |
| `VI.AllowLaserSmooth` | `1` | 允许使用一欧元进行激光平滑处理 |
| `VI.AllowVerticalWorldMovement` | `1` | 是否能将追踪空间从原点移开 |
| `VI.AllowWorldRotationPitchAndRoll` | `0` | 启用后可以进行偏转，还可以在旋转时通过双手抓握来进行俯仰和滚动世界 |
| `VI.CarrySmoothingLerpAlpha` | `1` | 使所携带对象的移动更为平稳的程度。 |
| `VI.DragAtLaserImpactInterpolationDuration` | `0.1` | 在激光碰撞点下方拖动对象时，在不同位置之间内插对象需要多长时间 |
| `VI.DragAtLaserImpactInterpolationThreshold` | `5` | 强制激活插值模式前，不同帧之间跳转的最小距离 |
| `VI.DragHapticFeedbackStrength` | `1` | 开始拖动对象时触觉反馈的默认强度 |
| `VI.DragScale` | `1` | 调整拖动自己穿越世界时的平移距离 |
| `VI.DragTranslationVelocityStopEpsilon` | `0.0001` | 当拖动惯性低于此值（厘米/帧）时，停止惯性并完成拖动 |
| `VI.ElasticSnap` | `1` | 启用网格对齐后，可将对象从其对齐位置上稍稍"拉"开 |
| `VI.ElasticSnapStrength` | `0.3` | 网格对齐启用弹性对齐时，对象应向其未对齐位置"移动"多远的距离 |
| `VI.ForceGizmoPivotToCenterOfObjectsBounds` | `0` | 启用后，小工具的枢轴点将始终以所选对象为中心。 否则将使用最后一个选定对象的枢轴点。 |
| `VI.ForceShowCursor` | `0` | 是否启用镜像窗口的光标。默认禁用。设为1以启用。 |
| `VI.ForceSnapDistance` | `25` | 导线指示Actor对齐的距离（以可变换对象大小的百分比表示） |
| `VI.GizmoHandleHoverAnimationDuration` | `0.1` | 小工具握柄悬停状态的动画绘制速度 |
| `VI.GizmoHandleHoverScale` | `1.5` | 悬停在小工具上时，变换小工具握柄的放大程度 |
| `VI.GizmoScaleInDesktop` | `0.35` | 变换小工具在桌面模式下的大小 |
| `VI.GizmoSelectionAnimationCurvePower` | `2` | 决定选定对象后小工具的动画曲线 |
| `VI.GizmoSelectionAnimationDuration` | `0.15` | 选择对象后，小工具的动画时长 |
| `VI.GizmoShowMeasurementText` | `0` | 启用后，小工具的测距值将始终可见。 否则将仅在悬停在缩放/拉伸小工具握柄上时才可见 |
| `VI.GrabberSphereOffset` | `2` | 抓取器球体应以控制器原点为中心的偏移距离 |
| `VI.GrabberSphereRadius` | `12` | 径向模式下，用于选择和交互的球体半径 |
| `VI.GridHapticFeedbackStrength` | `0.4` | 跨网格点移动时触觉反馈的默认强度 |
| `VI.HighSpeedInertiaDamping` | `0.99` | 高速惯性阻尼乘数 |
| `VI.InertiaVelocityBoost` | `0.5` | 在模拟模式下释放拖动的模拟对象时，对象速度的缩放比例 |
| `VI.LaserPointerMaxLength` | `30000` | 激光指针线段的最大长度 |
| `VI.LaserPointerRetractDuration` | `0.2` | 激光指针伸出或收回的速度 |
| `VI.LaserSmoothLag` | `0.007` | 激光平滑的延迟 |
| `VI.LaserSmoothMinimumCutoff` | `0.9` | 激光平滑的延迟 |
| `VI.LowSpeedInertiaDamping` | `0.94` | 低速惯性阻尼乘数 |
| `VI.MaxFlightSpeed` | `11` | 最大超人速度 |
| `VI.MinVelocityForInertia` | `1` | 释放对象（或世界）时，启用惯性前的最小速度（在未缩放的房间空间中，以厘米/帧为单位） |
| `VI.NavigationMode` | `0` | VR寻路模式 |
| `VI.OculusLaserPointerRotationOffset` | `0` | 相对于控制器的前向向量，激光指针的旋转（俯仰）幅度（Oculus） |
| `VI.OculusLaserPointerStartOffset` | `2.8` | 为避免与手部网格体的几何体发生重叠而设置的激光指针起点的偏移距离（Oculus） |
| `VI.PivotGizmoAimAtAnimationSpeed` | `0.15` | 瞄准小工具时，将其放大到全尺寸的动画的速度 |
| `VI.PivotGizmoAimAtShrinkSize` | `0.3` | 未瞄准小工具时的最小尺寸（0到1） |
| `VI.PivotGizmoDistanceScaleFactor` | `0.0035` | 随着远离摄像机，为便于选择，小工具的握柄应放大的尺寸 |
| `VI.PivotGizmoMinDistanceForScaling` | `0` | 摄像机需要离对象多远，才会开始根据距离缩放该对象 |
| `VI.PivotGizmoPlaneTranslationPivotOffsetYZ` | `40` | 平面平移相对枢轴点的偏移量 |
| `VI.PivotGizmoScalePivotOffsetX` | `120` | 非均匀缩放相对枢轴点的偏移量 |
| `VI.PivotGizmoTranslationHoverScaleMultiply` | `0.75` | 乘以平移握柄悬停的比例 |
| `VI.PivotGizmoTranslationPivotOffsetX` | `30` | 平移圆柱体相对枢轴点的偏移量 |
| `VI.PivotGizmoTranslationScaleMultiply` | `2` | 乘以平移握柄的比例 |
| `VI.PlacementInterpolationDuration` | `0.6` | 应该将新放置的对象插值到目标位置的时间。 |
| `VI.PlacementOffsetScaleWhileSimulating` | `0.25` | 启用模拟模式时，从放置碰撞点额外偏移对象的距离（以小工具边界的标量百分比表示） |
| `VI.ScaleMax` | `6000` | 最大世界场景比例，以厘米为单位 |
| `VI.ScaleMin` | `10` | 最小世界场景比例，以厘米为单位 |
| `VI.ScaleSensitivity` | `0.005` | 缩放敏感度 |
| `VI.SelectionHapticFeedbackStrength` | `0.5` | 选择对象时触觉反馈的默认强度 |
| `VI.SFXMultiplier` | `1.5` | 默认音效音量乘数 |
| `VI.ShowTransformGizmo` | `1` | 是否显示所选对象的变换小工具 |
| `VI.SmoothSnap` | `1` | 启用网格对齐后，变换后的对象将平滑地移动到新位置（而不是瞬时传送）。 |
| `VI.SmoothSnapSpeed` | `30` | 启用网格对齐后，对象插值到新位置的速度 |
| `VI.SnapGridLineWidth` | `3` | 对齐网格上网格线的宽度 |
| `VI.SnapGridSize` | `3` | 对齐网格的大小。 值为1.0时即是小工具边界框的最大值，也是当前网格对齐尺寸的倍数 |
| `VI.SweepPhysicsWhileSimulating` | `0` | 启用后，在模拟模式下被拖动时，模拟对象将无法穿透其他对象 |
| `VI.TriggerDeadZone_Rift` | `0.25` | 扳机的死区。 在触发新一次"轻按"前，必须完全松开扳机 |
| `VI.TriggerDeadZone_Vive` | `0.25` | 扳机的死区。 在触发新一次"轻按"前，必须完全松开扳机 |
| `VI.TriggerFullyPressedThreshold_Rift` | `0.99` | 将扳机视为"完全按下"前所需的最小触发阈值 |
| `VI.TriggerFullyPressedThreshold_Vive` | `0.9` | 将扳机视为"完全按下"前所需的最小触发阈值 |
| `VI.TriggerTouchThreshold_Rift` | `0.15` | 将扳机视为"被触碰"前所需的最小触发阈值 |
| `VI.TriggerTouchThreshold_Vive` | `0.025` | 将扳机视为"被触碰"前所需的最小触发阈值 |
| `VI.ViveLaserPointerRotationOffset` | `0` | 相对于控制器的前向向量，激光指针的旋转（俯仰）幅度（Vive）。 |
| `VI.ViveLaserPointerStartOffset` | `1.25` | 为避免与手部网格体的几何体发生重叠而设置的激光指针起点的偏移距离（Vive）。 |
| `VI.WorldRotationDragThreshold` | `8` | 让世界旋转前，你自身必须进行的旋转动作角度。 |
| `VI.WorldScalingDragThreshold` | `7` | 让世界缩放前，你自身必须进行的缩放动作程度。 |

## 虚拟内存

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `vm.BatchPackedVMOutput` | `1` | 如果值>0，将对输出元素进行打包，并被无分支分批处理。 |
| `vm.BatchVMInput` | `0` | 如果值>0，输入元素将被分批处理。 |
| `vm.BatchVMOutput` | `0` | 如果值>0，输出元素将被分批处理。 |
| `vm.ChunkSizeInBytes` | `32768` | 每块虚拟内存数据块的字节数。理想大小是小于等于L1。（默认值=32768） |
| `vm.DetailedVMScriptStats` | `0` | 如果值>0，向量虚拟内存将为内部模块调用发布统计信息。 |
| `vm.FreeUnoptimizedByteCode` | `1` | 优化虚拟内存字节代码后，是否应释放未经优化的原始字节代码？ |
| `vm.InstancesPerChunk` | `128` | 每块虚拟内存数据块的实例数量。（默认值=128） |
| `vm.MaxThreadsPerScript` | `8` | 每个脚本的线程数上限。设为0即"视需要而定" |
| `vm.OptimizeVMByteCode` | `1` | 如果值>0，向量虚拟内存代码优化将在运行时启用。 |
| `vm.PageSizeInKB` | `64` | 按虚拟内存实例分配的最小分配量。 有64个这样的实例，因此将GVVMPageSizeInKB x 64 x 1024，即可得到VVM使用的总字节数 |
| `vm.Parallel` | `1` | 如果值>0，将在向量虚拟内存数据块的级别上启用并行性。 |
| `vm.ParallelChunksPerBatch` | `4` | 并行运行时每个任务要处理的数据块数量。 |
| `vm.SafeOptimizedKernels` | `1` | 如果值>0，优化后的向量虚拟内存字节代码将使用安全版本的核。 |
| `vm.UseOptimizedVMByteCode` | `1` | 如果值>0，优化后的向量虚拟内存字节代码将在运行时执行。 |

## 语音

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `voice.debug.PrintAmplitude` | `0` | 若值为1，屏幕上将显示VOIP引擎的当前输入振幅。 0：禁用。1：启用。 |
| `voice.DefaultPatchBufferSize` | `4096` | 以样本形式更改为VOIP补丁缓冲的音频量。 |
| `voice.DefaultPatchGain` | `1` | 以线性增益改变音频补丁的默认增益。 |
| `voice.JitterBufferDelay` | `0.3` | 播放音频之前缓冲的默认音频量，以秒为单位。此值越低，延迟越少，但越可能发生欠载。 值：缓冲的音频的秒数。 |
| `voice.MicInputGain` | `1` | 线性幅度的默认增益量。 值：增益的乘数。 |
| `voice.MicNoiseAttackTime` | `0.05` | 可设置噪声门的淡入时间。 值：淡入所花的秒数。 |
| `voice.MicNoiseGateThreshold` | `0.08` | 输入噪声门的阈值，以线性幅度表示。与voice.SilenceDetectionThreshold类似，但比噪声门阈值更安静的音频仍会输出静音。 值：缓冲的音频的秒数。 |
| `voice.MicNoiseReleaseTime` | `0.3` | 可设置噪音门的淡出时间。 值：淡出所花的秒数。 |
| `voice.MicStereoBias` | `0` | 会让左声道或右声道出现衰减。 0.0：居中。1.0：仅右声道。-1.0：仅左声道。 |
| `voice.MuteAudioEngineOutput` | `0` | 值非零时，音频引擎的输出将被静音。 |
| `voice.NumChannels` | `1` | 由麦克风输入捕获、编码到Opus并输出的默认通道数量。值可以为1或2。 值：用于VOIP输入和输出的通道数。 |
| `voice.playback.ResyncThreshold` | `0.3` | 如果缓冲的音频量大于此值，则丢弃最早的音频，并进行同步，获取数量为voice.JitterDelay值的缓冲音频。 |
| `voice.playback.ShouldResync` | `1` | 如果值为1，则一旦延迟超过voice.playback.ResyncThreshold，重新同步VOIP音频。 |
| `voice.SilenceDetectionAttackTime` | `2` | VOIP麦克风静音检测算法的起音时间，以毫秒为单位。 |
| `voice.SilenceDetectionReleaseTime` | `1100` | VOIP麦克风静音检测算法的释音时间，以毫秒为单位。 |
| `voice.SilenceDetectionThreshold` | `0.08` | 为VOIP麦克风的静音检测算法设置的阈值。 |

## 虚拟现实

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `vr.AllowMotionBlurInVR` | `0` | 针对启用了动态模糊的项目，在VR中启用动态模糊。 |
| `vr.EnableMotionControllerLateUpdate` | `1` | 此命令允许你指定是否应用运动控制器的后期更新。 0：不使用后期更新。1：使用后期更新（默认值） |
| `vr.InstancedStereo` | `0` | 若值为0，禁用实例化立体声（默认值），1则启用。 |
| `vr.MobileMultiView` | `0` | 若值为0，禁用移动端多视图，1则启用。 |
| `vr.RoundRobinOcclusion` | `0` | 若值为0，禁用立体渲染的循环遮蔽查询（默认值），1则启用。 |

## 虚拟现实编辑器

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `VREd.AllowPlay` | `1` | 允许开始播放。 |
| `VREd.AllowResetScale` | `1` | 允许将世界重置为米的默认比例尺 |
| `VREd.AssetEditorUIResolutionX` | `1920` | 用于VR编辑器的资产编辑器UI渲染目标的水平分辨率 |
| `VREd.AssetEditorUIResolutionY` | `1080` | 用于VR编辑器的资产编辑器UI渲染目标的垂直分辨率 |
| `VREd.CameraPreviewUISize` | `50` | 摄像机预览UI的大小 |
| `VREd.CentralWidgetX` | `512` | 用于VR编辑器的径向UI渲染目标的水平分辨率 |
| `VREd.CentralWidgetY` | `512` | 用于VR编辑器的径向UI渲染目标的垂直分辨率 |
| `VREd.DefaultCameraUIResolutionX` | `1400` | 用于VR编辑器的UI渲染目标的水平分辨率 |
| `VREd.DefaultCameraUIResolutionY` | `787` | 用于VR编辑器的UI渲染目标的垂直分辨率 |
| `VREd.DefaultEditorUIResolutionX` | `1024` | 用于VR编辑器的UI渲染目标的水平分辨率 |
| `VREd.DefaultEditorUIResolutionY` | `1024` | 用于VR编辑器的UI渲染目标的垂直分辨率 |
| `VREd.DefaultRadialElementResolutionX` | `350` | 用于VR编辑器的径向UI渲染目标的水平分辨率 |
| `VREd.DefaultRadialElementResolutionY` | `350` | 用于VR编辑器的径向UI渲染目标的垂直分辨率 |
| `VREd.DefaultVRNearClipPlane` | `5` | 用于VR的近裁剪平面 |
| `VREd.DefaultWorldToMeters` | `100` | 默认为米的世界比例尺 |
| `VREd.DockUIDragSmoothingAmount` | `0.85` | 拖动UI时平滑运动的程度（对帧率敏感） |
| `VREd.DockUIFadeAnimationDuration` | `0.15` | 淡入淡出动画的完成速度 |
| `VREd.DockUIHoverAnimationDuration` | `0.15` | 悬停动画的完成速度 |
| `VREd.DockUIHoverScale` | `1.1` | 悬停在选择栏上时，选择栏的大小 |
| `VREd.DockUISelectionBarVerticalOffset` | `2` | 选择栏和UI之间的Z轴距离 |
| `VREd.DockUISmoothingAmount` | `0.75` | UI变换的平滑运动的程度（对帧率敏感） |
| `VREd.DockWindowTickness` | `1` | 窗口的厚度 |
| `VREd.DragHapticFeedbackStrength` | `1` | 开始拖动对象时触觉反馈的默认强度 |
| `VREd.EditorUIScale` | `2` | 为VR放大（或缩小）编辑器UI的程度 |
| `VREd.EditorUISize` | `70` | 编辑器UI的大小 |
| `VREd.FoliageOpacity` | `0.02` | 植被笔刷的不透明度。 |
| `VREd.GridFadeMultiplier` | `3` | 网格的淡入淡出速度，以"每秒消退次数"为单位 |
| `VREd.GridFadeStartVelocity` | `10` | 网格消退时长 |
| `VREd.GridHeightOffset` | `0` | 世界运动网格的高度偏移。 适用于未进行正确追踪空间校准的情况 |
| `VREd.GridMaxFade` | `0.8` | 网格的最大不透明度 |
| `VREd.GridMovementTolerance` | `0.1` | 网格必须消失时的移动公差 |
| `VREd.GridScaleMultiplier` | `35` | 网格的比例 |
| `VREd.HeadLocationMaxVelocity` | `25` | 头部速度指示器的最大位置速度，单位为厘米/秒 |
| `VREd.HeadLocationVelocityOffset` | `X=20, Y=0, Z=5` | 位置速度调试指示器相对于头部的偏移 |
| `VREd.HeadRotationMaxVelocity` | `80` | 头部速度指示器的最大旋转速度，单位为度/秒 |
| `VREd.HeadRotationVelocityOffset` | `X=20, Y=0, Z=5` | 旋转速度调试指示器相对于头部的偏移 |
| `VREd.HeadVelocityMaxLineThickness` | `0.4` | 头部速度环线的粗细 |
| `VREd.HeadVelocityMaxRadius` | `10` | 头部速度环线外圈的大小 |
| `VREd.HeadVelocityMinLineThickness` | `0.05` | 头部速度环线的粗细 |
| `VREd.HeadVelocityMinRadius` | `0` | 头部速度环线内圈的大小 |
| `VREd.HeadVelocitySmoothing` | `0.95` | 平滑头部速度数据的程度 |
| `VREd.HelpLabelFadeDistance` | `30` | 控制器帮助标签的显示距离（单位为厘米） |
| `VREd.HelpLabelFadeDuration` | `0.4` | 控制器帮助标签淡入淡出的时长 |
| `VREd.HoverBallRadiusScaleWhenOverUI` | `0.4` | 悬浮球在UI上时的缩小程度 |
| `VREd.HoverHapticFeedbackStrength` | `0.1` | 悬停时触觉反馈的默认强度 |
| `VREd.HoverHapticFeedbackTime` | `0.2` | 悬停时触觉反馈的最短间隔时间 |
| `VREd.InvertTrackpadVertical` | `0` | 切换反转触摸板垂直轴 |
| `VREd.LaserPointerHoverBallRadius` | `1` | 沿激光指针光线悬停对象时的视觉提示半径 |
| `VREd.LaserPointerLightPullBackDistance` | `2.5` | 悬浮光源和撞击面的拉远距离 |
| `VREd.LaserPointerRadius` | `0.5` | 激光指针线段的半径 |
| `VREd.LaserPointLightRadius` | `10` | 悬浮光源的大小 |
| `VREd.LaserRadiusScaleWhenOverUI` | `0.25` | 激光指针半径在UI上时的缩小程度 |
| `VREd.MaxDockWindowSize` | `250` | 可停靠窗口的最大尺寸 |
| `VREd.MinDockWindowSize` | `40` | 可停靠窗口的最小尺寸 |
| `VREd.MinJoystickOffsetBeforeFlick` | `0.4` | 运动控制器上轻拂动作的死区 |
| `VREd.MinJoystickOffsetBeforeRadialMenu` | `0.4` | 切换反转触摸板垂直轴 |
| `VREd.MinTrackpadOffsetBeforeRadialMenu` | `0.5` | 在扣动扳机立刻放置对象之前，需要将手柄举高的距离 |
| `VREd.MinUIScrollDeltaForInertia` | `0.25` | 启用惯性UI滚动前，触摸板的最小输入量 |
| `VREd.MinVelocityForMotionControllerInertia` | `1` | 释放对象（或世界）时，启用惯性前的最小速度（在未缩放的房间空间中，以厘米/帧为单位） |
| `VREd.PivotPointTransformGizmo` | `1` | 是否使用枢轴点变换小工具，而不是边界框小工具 |
| `VREd.QuickMenuUIResolutionX` | `1200` | 用于快捷菜单VR UI渲染目标的水平分辨率 |
| `VREd.QuickMenuUIResolutionY` | `1075` | 用于快捷菜单VR UI渲染目标的垂直分辨率 |
| `VREd.RadialMenuFadeDelay` | `0.2` | 选择按钮后径向菜单的延迟 |
| `VREd.RadialUIBrightness` | `1.5` | UI的亮度 |
| `VREd.RadialUIFadeSpeed` | `6` | UI淡入淡出的速度 |
| `VREd.ScaleProgressBarLength` | `50` | 缩放时显示的进度条的长度 |
| `VREd.ScaleProgressBarRadius` | `1` | 缩放时显示的进度条的半径 |
| `VREd.SequencerScrubMax` | `2` | 最大快进或快退的幅度 |
| `VREd.SequencerUIResolutionX` | `960` | 用于Sequencer UI渲染目标的水平分辨率 |
| `VREd.SequencerUIResolutionY` | `600` | 用于Sequencer UI渲染目标的垂直分辨率 |
| `VREd.SFXMultiplier` | `1.5` | 默认音效音量乘数 |
| `VREd.ShowControllerHelpLabels` | `0` | 当控制器靠近观看者时，启用帮助文本覆层 |
| `VREd.ShowHeadVelocity` | `0` | 是否绘制显示头部加速度的调试指示器 |
| `VREd.SlateDragDistanceOverride` | `40` | 在VR中开始拖放操作前需要拖动多少像素 |
| `VREd.SteamVRTrackpadDeadzone` | `0.3` | Vive运动控制器手柄的死区 |
| `VREd.TeleportAllowPushPull` | `1` | 允许沿激光推拉传送点。 |
| `VREd.TeleportAllowScaleBackToDefault` | `1` | 缩放回默认为米的世界比例尺 |
| `VREd.TeleportAnimateSpeed` | `3` | 传送点淡入的速度 |
| `VREd.TeleportDistance` | `500` | 未命中任何对象时的默认瞬移距离 |
| `VREd.TeleportDragSpeed` | `0.3` | 传送点在激光所瞄准位置后的拖移速度 |
| `VREd.TeleportEnableChangeScale` | `0` | 传送时是否将世界比例尺变为米 |
| `VREd.TeleportLaserPointerLength` | `500000` | 用于传送的激光指针的距离 |
| `VREd.TeleportLerpTime` | `0.1` | 传送的插值时间 |
| `VREd.TeleportOffset` | `100` | 由命中结果朝向控制器的偏移量 |
| `VREd.TeleportOffsetMultiplier` | `0.3` | 传送偏移的乘数 |
| `VREd.TeleportScaleSensitivity` | `0.05` | 将世界传送至米级的触摸板灵敏度 |
| `VREd.TeleportSlideBuffer` | `0.01` | 用手柄进行推拉操作或改变比例尺的最小滑动量。 |
| `VREd.TrackpadAbsoluteDragSpeed` | `80` | 当携带对象并用触摸板拖动对象时，对象靠近或远离的速度 |
| `VREd.TrackpadRelativeDragSpeed` | `8` | 当携带对象并用模拟摇杆按住一个方向时，对象靠近或远离的速度 |
| `VREd.TrackpadStopImpactAtLaserBuffer` | `0.4` | 停止激光末端变换所需的滑动量输入 |
| `VREd.UIAbsoluteScrollSpeed` | `8` | 拖动触摸板时UI的滚动速度 |
| `VREd.UIAssetEditorSummonedOnHandHapticFeedbackStrength` | `1` | 用于提醒用户资产编辑器在哪只手上生成的触觉强度 |
| `VREd.UIFadeSpeed` | `6` | UI淡入淡出的速度 |
| `VREd.UIOnArmRotationOffset` | `0` | 使停靠在手臂上的UI与控制器对齐的旋转偏移量 |
| `VREd.UIOnHandRotationOffset` | `45` | 使停靠在手上的UI更容易握持的旋转偏移量 |
| `VREd.UIPanelOpenDistance` | `20` | 手上生成的面板与手距离，以厘米为单位 |
| `VREd.UIPanelOpenRotationPitchOffset` | `45` | 在运动控制器前方生成面板时的俯仰旋转偏移量，以度为单位 |
| `VREd.UIPressHapticFeedbackStrength` | `0.4` | 点击UI时的触觉强度 |
| `VREd.UIRelativeScrollSpeed` | `0.75` | 按住模拟摇杆时UI的滚动速度 |
| `VREd.WorldMovementFogEndDistance` | `800` | "世界移动"模式下，完成雾渲染的距离 |
| `VREd.WorldMovementFogOpacity` | `0.8` | 雾在"末端距离"处的不透明度（0.0-1.0） |
| `VREd.WorldMovementFogSkyboxDistance` | `20000` | 超过此距离的东西都会被雾化且变得不可见 |
| `VREd.WorldMovementFogStartDistance` | `300` | "世界移动"模式下开始渲染雾的距离 |

## 控件

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `Widget.MaxAnimationLatentActions` | `100` | 定义一帧中可运行的潜在操作数上限。 |
| `Widget.TemplatePreviewInEditor` | `0` | 是否应在运行时为控件编辑器生成动态模板？ 适用于模版的调试。 |
| `Widget.UseParallelAnimation` | `true` | 为控件动画使用多线程求值。 |
| `WidgetComponent.MaximumRenderTargetHeight` | `2160` | 可设置控件组件所用渲染目标的最大高度。 |
| `WidgetComponent.MaximumRenderTargetWidth` | `3840` | 可设置控件组件所用渲染目标的最大宽度。 |
| `WidgetComponent.UseAutomaticTickModeByDefault` | `false` | 为true时，控件组件默认禁用刷新；为false时，默认启用刷新。 |

## 窗口

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `WindowsApplication.EnableFirstTouchEvent` | `false` | 启用FirstTouch事件，可防止在某些触摸输入设备上弹出小窗口 |
| `WindowsCursor.UseInvisibleCursorForNoneCursorType` | `false` | 启用后，当鼠标光标类型为"无（None）"时，将平台HCursor设为透明光标，而不是空值。 |
| `WindowsPlatformCrashContext.ForceCrashReportDialogOff` | `false` | 如果值为true，则在发生崩溃时强制不显示崩溃报告对话框。 |
| `WindowTitleBar.ForceWindowButtonsHidden` | `false` | 如果值为true，则强制隐藏窗口标题栏按钮。 |

## 世界分区

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `wp.Editor.DisableLevelInstanceEditorPartialLoading` | `false` | 允许在编辑器中禁用部分关卡实例的加载。 |
| `wp.Editor.EnableSpatialHashValidation` | `false` | 是否启用世界分区编辑器的空间哈希验证 |
| `wp.Editor.HLOD.AllowShowingHLODsInEditor` | `true` | 允许在编辑器中显示世界分区HLOD。 |
| `wp.Editor.LoadingRangeBugItGo` | `12800` | BugItGo命令的加载范围。 |
| `wp.Editor.WorldExtentToEnableStreaming` | `400000` | 配合启用流送后的世界延伸。 |
| `wp.Runtime.BlockOnSlowStreaming` | `1` | 设置是否需要在流送速度太慢时进行阻断。 |
| `wp.Runtime.BlockOnSlowStreamingRatio` | `0.25` | 用于确定是否需要阻断世界分区流送的DistanceToCell/LoadingRange的比率 |
| `wp.Runtime.BlockOnSlowStreamingWarningFactor` | `2` | 希望开始通知用户的wp.Runtime.BlockOnSlowStreamingRatio的系数 |
| `wp.Runtime.DebugDedicatedServerStreaming` | `false` | 打开/关闭以进行服务器流送调试。 |
| `wp.Runtime.DrawContentBundles` | `true` | 启用以绘制内容数据包的调试显示。 |
| `wp.Runtime.EnableServerStreaming` | `0` | 值为1时则启用服务器流送，为2时则仅在PIE中启用。 在游戏运行过程中更改数值将无法生效。 |
| `wp.Runtime.EnableServerStreamingOut` | `false` | 打开/关闭以允许或禁止服务器向外流送关卡（仅在启用服务器流送时有效）。在游戏运行过程中更改数值将无法生效。 |
| `wp.Runtime.EnableSimulationStreamingSource` | `1` | 若值为0，则禁用模拟/弹出式摄像机流送源。 |
| `wp.Runtime.FilterRuntimeSpatialHashGridLevel` | `-1` | 用于选择过滤单个世界分区运行时的哈希网格关卡。 |
| `wp.Runtime.ForceRuntimeSpatialHashZCulling` | `-1` | 用于强制执行运行时哈希单元Z轴剔除的行为。设为0以强制关闭，设为1以强制开启，设置为其他值以遵循运行时哈希设置。 |
| `wp.Runtime.HashSet.ShowDebugDisplayLevel` | `0` | 用于在显示运行时分区时，选择要显示的关卡。 |
| `wp.Runtime.HashSet.ShowDebugDisplayLevelCount` | `1` | 用于在显示运行时分区时，选择要显示的关卡数量。 |
| `wp.Runtime.HashSet.ShowDebugDisplayMode` | `0` | 用于在显示运行时分区时，选择要显示的模式（0=关卡流送状态、1=数据层，2=内容包）。 |
| `wp.Runtime.HLOD.ForceDisableShadows` | `0` | 强制禁用针对世界分区HLOD Actor的CastShadow标志 |
| `wp.Runtime.HLOD.WarmupDebugDraw` | `0` | 绘制预热请求的调试显示 |
| `wp.Runtime.HLOD.WarmupEnabled` | `1` | 启用HLOD资产预热。延迟wp.Runtime.HLOD.WarmupNumFrames帧的单元格卸载和向HLOD的过渡。 |
| `wp.Runtime.HLOD.WarmupNanite` | `1` | 为HLOD资产启用Nanite预热。要求wp.Runtime.HLOD.WarmupEnabled的值为1。 |
| `wp.Runtime.HLOD.WarmupNumFrames` | `5` | 将单元格的卸载时间按此帧数延迟，从而确保以适当的分辨率显示HLOD资产。设为0以强制禁用预热。 |
| `wp.Runtime.HLOD.WarmupVT` | `1` | 为HLOD资产启用虚拟纹理预热。要求wp.Runtime.HLOD.WarmupEnabled的值为1。 |
| `wp.Runtime.HLOD.WarmupVTScaleFactor` | `2` | 按此系数缩放要求预取的虚拟纹理（VT）大小。 |
| `wp.Runtime.HLOD.WarmupVTSizeClamp` | `2048` | 限制虚拟纹理预热请求，以确保安全。 |
| `wp.Runtime.LevelStreamingContinuouslyIncrementalGCWhileLevelsPendingPurgeForWP` | `64` | 当待清除关卡超过指定数量时，强制更新垃圾回收。 |
| `wp.Runtime.MaxLoadingStreamingCells` | `4` | 用于限制并发加载的世界分区流送单元的数量。 |
| `wp.Runtime.PlayerController.ForceUsingCameraAsStreamingSource` | `0` | 是否强制将摄像机作为世界分区的流送源。默认使用玩家Pawn。 0：将Pawn作为流送源。1：将摄像机作为流送源 |
| `wp.Runtime.RecordReplayStreamingSources` | `1` | 设为1以在记录重放时记录流送源。 |
| `wp.Runtime.RuntimeSpatialHashCellToSourceAngleContributionToCellImportance` | `0.4` | 接受0到1之间的值，用于调节流送源到单元的向量与源前向向量之间的角度对单元重要性的影响。值越接近0，该角度对单元重要性的影响就越小。 |
| `wp.Runtime.RuntimeSpatialHashPlacePartitionActorsUsingLocation` | `true` | 将RuntimeSpatialHashPlacePartitionActorsUsingLocation设为true，从而用Actor的位置（而非边界框）将被分区的Actor放入相应的单元格中。 |
| `wp.Runtime.RuntimeSpatialHashPlaceSmallActorsUsingLocation` | `false` | 将RuntimeSpatialHashPlaceSmallActorsUsingLocation设为true，从而用Actor的位置（而非边界框）将小于单元格大小的Actor放入相应的单元格中。 |
| `wp.Runtime.RuntimeSpatialHashSnapNonAlignedGridLevelsToLowerLevels` | `true` | 将RuntimeSpatialHashSnapNonAlignedGridLevelsToLowerLevels设为false，以避免将高级单元格与子单元格对齐。仅在GRuntimeSpatialHashUseAlignedGridLevels为false时可用。 |
| `wp.Runtime.RuntimeSpatialHashSortUsingCellExtent` | `true` | 若值为1，那么在按重要性对单元格进行排序时，将使用单元格范围，而非单元格网格关卡。 |
| `wp.Runtime.RuntimeSpatialHashSortUsingCellPriority` | `true` | 若值为1，那么在按重要性对单元格进行排序时，将优先使用单元格优先级，然后再使用离源的距离/角度作为一部分的排序标准。 |
| `wp.Runtime.RuntimeSpatialHashUseAlignedGridLevels` | `true` | 将RuntimeSpatialHashUseAlignedGridLevels设为false，从而帮助拆分因世界分区将Actor提升到上层网格关卡而造成的模式，因为上层网格总是与子网格对齐。 |
| `wp.Runtime.ServerDisallowStreamingOutDataLayers` |  | 以逗号分隔的数据层名称列表，这些名称不允许在服务器上卸载或停用 |
| `wp.Runtime.ServerStreamingSourceMinimumExtraAngle` | `1` | 服务器使用的流送源形状扇形角度的最小添加值（单位为度）。 |
| `wp.Runtime.ServerStreamingSourceMinimumExtraRadius` | `400` | 服务器使用的流送源半径的最小添加值（单位为虚幻单位）。 |
| `wp.Runtime.ShowRuntimeSpatialHashCellStreamingPriority` | `0` | 启用后，根据优先级（0=禁用，1=热图，2=灰度）显示运行时空间哈希网格单元的热图。 |
| `wp.Runtime.ShowRuntimeSpatialHashGridLevel` | `0` | 用于选择在显示世界分区运行时哈希时要显示的网格关卡。 |
| `wp.Runtime.ShowRuntimeSpatialHashGridLevelCount` | `1` | 用于选择在显示世界分区运行时哈希时要显示的网格关卡数量。 |
| `wp.Runtime.UpdateStreaming.EnableOptimization` | `true` | 设为1以启用一种优化方法，即如果上次更新后没有发生任何相关变化，则跳过世界分区的流送更新。 |
| `wp.Runtime.UpdateStreaming.ForceUpdateFrameCount` | `0` | 即使未检测到变化，也执行世界分区流送更新的频率（以帧为单位）。 |
| `wp.Runtime.UpdateStreaming.LocationQuantization` | `400` | 用于量化流送源位置的距离（使用虚幻单位），以判断是否需要进行世界分区流送更新。 |
| `wp.Runtime.UpdateStreaming.RotationQuantization` | `10` | 用于量化流送源旋转的角度（以度为单位），以判断是否需要进行世界分区流送更新。 |
| `wp.Runtime.UpdateStreamingSources` | `1` | 设为0以停止更新（冻结）世界分区流送源。 |
| `wp.Runtime.UpdateStreamingStateTimeLimit` | `0` | 执行世界分区更新流送状态所花费的最长时间（毫秒每帧）。 |
| `wp.Runtime.UseMakingInvisibleTransactionRequests` | `false` | 客户端是否应等待服务器确认可视性更新后，才将分区世界流送关卡设为不可见。 在游戏运行过程中更改数值将无法生效。 |
| `wp.Runtime.UseMakingVisibleTransactionRequests` | `false` | 客户端是否应等待服务器确认可视性更新后，才将分区世界流送关卡设为可见。 在游戏运行过程中更改数值将无法生效。 |
| `wp.Runtime.UseReplayStreamingSources` | `1` | 设为1以在重放时使用录制的流送源。 |
| `XInput.ForceControllerStateUpdate` | `0` | 强制逐帧刷新控制器X输入的状态。 0：未启用，1：启用 |

## 扩展现实

| **变量** | **默认值** | **说明** |
| --- | --- | --- |
| `xr.VRS.DynamicFoveation` | `0` | 是否应根据GPU利用率调整注视点级别。0：禁用（默认）； 1：启用 |
| `xr.VRS.FoveationLevel` | `0` | 待应用的注视点可变速率着色（VRS）水平（需VRS为可用）。0：禁用（默认）； 1：低；2：中；3：高；4：最高； |
| `xr.VRS.FoveationPreview` | `1` | 在VRS调试覆层中包含注视点VRS。0：禁用； 1：启用（默认） |
| `xr.VRS.GazeTrackedFoveation` | `0` | 为注视点VRS启用视线追踪。0：禁用（默认）； 1：启用 |
