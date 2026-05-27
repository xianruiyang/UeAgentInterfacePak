---
title: "创建捆绑的PSO缓存"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/manually-creating-bundled-pso-caches-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "PSO缓存", "创建捆绑的PSO缓存"]
---

# 创建捆绑的PSO缓存

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / PSO缓存 / 创建捆绑的PSO缓存

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/manually-creating-bundled-pso-caches-in-unreal-engine

虽然[运行时PSO预缓存系统](../pso-precaching/index.md)应足以避免你的游戏在PSO编译期间发生卡顿，但某些情况下，你可能需要将预先创建的PSO缓存与游戏捆绑起来。

本文将档描述PSO缓存的生成过程。本文档中的信息仅涉及图形PSO采集。烘焙项目时，计算着色器会自动生成计算PSO（遵照受r.ShaderPipelineCacheTools.IncludeComputePSODuringCook控制台变量管控的过滤规则），且不支持捆绑用于光线追踪PSO的缓存。

### 记录缓存和稳定缓存

PSO中的最重要数据为着色器信息。然而，在开发人员调整材质时，虚幻引擎中的着色器可以在多个构建间变更。为避免在长时间运行游戏后丢弃完整PSO缓存，PSO缓存文件被分为两类：

- **记录的PSO缓存** （ `.upipelinecache` 文件）。这些内容在运行应用程序构建时记录。

  所记录缓存中的着色器由由其字节码的SHA哈希标识。
- **稳定的PSO缓存** （ `.spc` 文件）。这些缓存文件在烘焙贴图文件时生成，并且包含当开发人员更改项目中的贴图或着色器时会发生可预见变化的着色器信息。

这些缓存文件由稳定的概要描述标识，预期在多个构建之间保持相同，例如材质名称、顶点工厂名称或着色器类型。此描述称为 *稳定密钥* ，由 `.shk` 文件表示（在虚幻引擎5.x之前的版本中，由 `.scl.csv` 文件表示）。

这样可确保在频繁更改的情况下，记录的数据相对稳健。如果应用程序有极其大规模的更改，你可能仍然需要重新记录PSO缓存，应用程序的整体内容最终确定后，你可以不用再管它们。

## 不同平台和图形API上的PSO

本文档中介绍的缓存包含PSO简要描述，位于引擎中 `FGraphicsPipelineStateInitializer` 的代码贴图中。然而，PSO数据不通用。虚幻引擎中的每个 **渲染硬件接口（RHI）** 都具有不同的属性，并且可能执行不同的渲染路径。

这会导致不同平台和渲染关卡之间的PSO缓存内容不同。这些PSO缓存间的信息不可互换。例如，运行D3D12 RHI的游戏所采集的缓存不能用于在Vulkan上运行的相同游戏。

如果你在可以使用多个图形API的平台上发布，并且你可以让应用程序在它们之间进行选择，则你需要在构建中包含多个缓存文件（每个API一个）。例如，对于采用Android的设备，在编写时，OpenGL ES仍是相关API。如果你在采用GLES和Vulkan的Android设备上发布应用程序，你需要采集并包含两个单独的缓存文件，每个RHI一个缓存文件。

> [!NOTE]
> GLES并没有PSO概念。但它使用了一个类似的概念，叫做 *程序对象* 。

采用固定硬件的平台通常既不需要这种简要描述的PSO缓存，也不会从中受益，它们有自己的解决方案，或者能够完全避免运行时性能损失。如果为此类平台开发，请参阅特定平台的相关文档。

旧版API（如D3D11）也不受此缓存支持。

## 采集流程

本小节假定你从头开始采集PSO缓存的数据，采用的构建中不包含预记录缓存。PSO缓存的采集过程是可迭代的，也就是说你不用从头开始，你可以不断添加，而不会丢失此前的数据。然而，如果缓存文件较旧，通常建议重新生成PSO缓存，因为自最初采集以来更改了大量代码或内容后，缓存的内容可能不相关。在缓存中使用老旧的PSO将导致加载时间无谓增加，因为这些PSO将被编译但永远不会使用。

![undefined](../../../../assets/images/72/728eb65d8c92600bb51839cab9f310e00affc8a0920dea59b4a56b506e5555d0.jpg)

描述PSO缓存采集周期的流程图。点击查看大图。

下面的小节包含采集PSO缓存并在项目中实施缓存所需的步骤。

### 设置和所需设置

要设置你的项目以记录PSO缓存，请执行以下步骤：

1. 打开项目的

   DefaultEngine.ini

   或其

   (Platform)Engine.ini

   。

> [!TIP]
> `(Platform)Engine.ini` 文件通常位于 `(Project)/Config/(Platform)` 目录下。使用此目录可以防止其他可能无需使用PSO缓存的平台获取设置。

1. 在 `Engine.ini` 文件中设置以下值：

   ```
   		         [DevOptions.Shaders]         NeedsShaderStableKeys=true		
   ```
2. 在 `DefaultGame.ini` 文件中，设置以下值：

   ```
   		         [/Script/UnrealEd.ProjectPackagingSettings]         bShareMaterialShaderCode=True         bSharedMaterialNativeLibraries=True		
   ```
3. 如果你是从头开始，请确保 `(Project)/Build/(Platform)/PipelineCaches` 中没有文件。烘焙器会在这个位置寻找记录的缓存文件。如果这是你首次采集PSO，此文件夹可能根本不存在。
4. 确保控制台变量 `r.ShaderPipelineCache.Enabled` 设置为1。

### 采集记录的PSO缓存

要记录PSO缓存，请遵循以下步骤：

1. 使用 `-logPSO` 命令行开关运行打包应用程序。
2. 在应用程序中执行尽可能多的路径。例如，运行应用程序的所有关卡，并更改图形设置。
3. 你每次运行应用程序时，系统将在 `Saved/CollectedPSOs` 下生成记录的缓存文件。采集它们并将它们放到计算机的任意位置的新目录。本指南使用目录 `C:\PSOCache` 。

采集记录的PSO缓存时，你的最终目录是了解用户在应用程序中能看到的每种可能的材质或视觉效果，因此你应该全面访问尽可能多的位置，并使用许多不同的图形设置组合进行访问。

请注意，你无需通过单次运行采集所有PSO缓存。你可以在开发应用程序的过程中执行多次运行，或者你可以将此任务分配多个人员。记录的PSO缓存不会删除，除非你手动删除，因此你可以在开发过程中逐渐累加缓存。

### 转换PSO缓存

要将前述步骤中的PSO数据转换为有用的格式（也称为扩展），请遵循以下步骤：

1. 烘焙项目内容。你可以通过打包应用程序完成此操作。
2. 打开 `(Project)/Saved/Cooked/(Platform)/(ProjectName)/Metadata/PipelineCaches` 。 从此目录将稳定的着色器密钥（`.shk`）文件复制到你放置 `rec.pipelinecache` 文件的文件夹中。例如 `C:\PSOCache` 。
3. 使用下面的参数运行 `ShaderPipelineCacheTools` 命令（假定你当前的目录是引擎安装目录）：

   ```
            Engine\Binaries\Win64\UnrealEditor-Cmd.exe [ProjectName] -run=ShaderPipelineCacheTools expand C:\PSOCache\*.rec.upipelinecache C:\PSOCache\*.shk C:\PSOCache\[YourPrefix][ProjectName][ShaderFormatName].spc
   ```

文件名应包含以下元素：

- (YourPrefix)：任意字符串，通常指定采集发生的时间。例如，这可能是当前构建的变更列表。
- (ProjectName)：项目的名称或

  .uproject

  文件的路径。例如：ShooterGame。这必须与你的项目名称完全匹配，否则无法选取。
- (ShaderFormatName)：项目的着色器格式，必须与着色器格式的名称完全匹配。例如：

  SF_VULKAN_ES31_ANDROID

  。

项目ShooterGame使用上述规范的全名如下：CL11122333_ShooterGame_SF_VULKAN_ES31_ANDROID

### 在应用程序中包含PSO缓存

1. 将前一小节中生成的 `.spc` 文件放到 `Build/[PlatformName]/PipelineCaches` 文件夹中。例如：`Build/Windows/PipelineCaches` 。
2. 再次烘焙或打包你的项目。PSO缓存文件应该被烘焙器选取，日志记录靠近末尾部分应该包含以下类似内容：

   ```
   		     LogCook: Display: ---- Running UShaderPipelineCacheToolsCommandlet for platform WindowsClient  shader format PCD3D_SM6       LogCook: Display:   With Args: build "../../../TestGame/Build/Windows/PipelineCaches/*TestGame_PCD3D_SM6.spc"  "d:/build/++Test/Sync/TestGame/Saved/Cooked/WindowsClient/TestGame/Metadata/PipelineCaches/ShaderStableInfo-Global-PCD3D_SM6.shk" "d:/build/++Test/Sync/TestGame/Saved/Cooked/WindowsClient/TestGame/Metadata/PipelineCaches/ShaderStableInfo-TestGame-PCD3D_SM6.shk" "d:/build/++Test/Sync/TestGame/Saved/Cooked/WindowsClient/TestGame/Content/PipelineCaches/Windows/TestGame_PCD3D_SM6.stable.upipelinecache"       LogShaderPipelineCacheTools: Display: Sorting input stable cache files into chronological order for merge processing...       LogShaderPipelineCacheTools: Display: Loading d:/build/++Test/Sync/TestGame/Saved/Cooked/WindowsClient/TestGame/Metadata/PipelineCaches/ShaderStableInfo-Global-PCD3D_SM6.shk...       LogShaderPipelineCacheTools: Display: Loading d:/build/++Test/Sync/TestGame/Saved/Cooked/WindowsClient/TestGame/Metadata/PipelineCaches/ShaderStableInfo-TestGame-PCD3D_SM6.shk...       LogShaderPipelineCacheTools: Display: Loaded 3554 shader info lines from d:/build/++Test/Sync/TestGame/Saved/Cooked/WindowsClient/TestGame/Metadata/PipelineCaches/ShaderStableInfo-Global-PCD3D_SM6.shk.       LogShaderPipelineCacheTools: Display: Loaded 3833694 shader info lines from d:/build/++Test/Sync/TestGame/Saved/Cooked/WindowsClient/TestGame/Metadata/PipelineCaches/ShaderStableInfo-TestGame-PCD3D_SM6.shk.       LogShaderPipelineCacheTools: Display: Loaded 3837248 unique shader info lines total.      LogShaderPipelineCacheTools: Display: Loaded 13238 stable PSOs from ../../../TestGame/Build/Windows/PipelineCaches/++Test+GoldMaster-CL-17412694-TestGame_PCD3D_SM6.spc. 2329 PSOs rejected, 5840141 PSOs merged       LogShaderPipelineCacheTools: Display: Re-deduplicated into 35084 binary PSOs [Usage Mask Merged = 3].       LogShaderPipelineCacheTools: Display: Running sanity check (consistency of vertex format).       LogShaderPipelineCacheTools: Display: 0 vertex shaders are used with an inconsistent vertex format       LogShaderPipelineCacheTools: Display: === Sanitizing results ===       LogShaderPipelineCacheTools: Display: Before sanitization: ....................................................................  35382 PSO       LogShaderPipelineCacheTools: Display: Filtered out due to inconsistent vertex declaration for the same vertex shader:..........      0 PSO       LogShaderPipelineCacheTools: Display: Filtered out due to VS being possibly incompatible with an empty vertex declaration:.....      1 PSO       LogShaderPipelineCacheTools: Display: -----       LogShaderPipelineCacheTools: Display: Number of PSOs after sanity checks:......................................................  35381 PSO       LogShaderPipelineCacheTools: Display: Wrote 35381 binary PSOs (graphics: 34834 compute: 547 RT: 0), (18453KB) to d:/build/++Test/Sync/TestGame/Saved/Cooked/WindowsClient/TestGame/Content/PipelineCaches/Windows/TestGame_PCD3D_SM6.stable.upipelinecache       LogCook: Display: ---- Done running UShaderPipelineCacheToolsCommandlet for platform WindowsClient		
   ```

要验证这是否有效，请检查显示写入的二进制PSO数量的行，该行写在日志的结尾处。该行的图形PSO数量必须大于0。

```
 	LogShaderPipelineCacheTools: Display: **Wrote 35381 binary PSOs** (graphics: 34834 compute: 547 RT: 0), (18453KB) to d:/build/++Test/Sync/TestGame/Saved/Cooked/WindowsClient/TestGame/Content/PipelineCaches/Windows/TestGame_PCD3D_SM6.stable.upipelinecache LogCook: Display: ---- Done running UShaderPipelineCacheToolsCommandlet for platform WindowsClient 
```

### 测试PSO覆盖范围

要确定PSO缓存是否有足够的覆盖范围，请使用 `-logpso` 命令运行新打包的应用程序，并观察日志输出。你应该会看到类似于以下内容的行：

```
 	[2021.10.06-20.06.22:848][  0]LogRHI: Opened FPipelineCacheFile: ../../../ShooterGame/Content/PipelineCaches/Windows/ShooterGame_PCD3D_SM6.stable.upipelinecache (GUID: EA50968D47BDE9A04A8524BCEB51615D) with 269 entries. 
```

该数量必须与打包日志中写入的二进制PSO数量匹配。例如，如果日志报告写了35381个二进制PSO，预期可以看到35381个条目。

你还应该检查构建是否在日志中打印"Encountered a new graphics PSO"。如果你在与缓存采集期间相同的条件下（例如相同的可扩展性设置）看到相同的内容，则不应出现此种情况。

## 缓存分区

对于此写入，生成的PSO缓存是游戏构建中包含的单个单块文件。游戏的默认行为是尝试在启动时打开它，并开始从中编译PSO。然而，并非所有PSO始终都相关。例如，有些可能是从不同关卡采集，有些使用不同的图形设置记录。

为了避免对缓存进行不必要的编译，每个PSO当前都与称为 **游戏使用掩码** 的位掩码关联。该应用程序使用 `SetGameUsageMaskWithComparison` 函数避免编译记录在不同关卡或具有不同图形（质量）设置的PSO。以下是此类函数的示例：

```
 	void SetPSOCacheUsageMask(int32 QualityLevel, int32 MapIndex) 	{ 		uint64 GameMask = 0;				const int32 kMaxQualityLevels = 4;				GameMask |= (1ULL << static_cast<uint64>(QualityLevel));				check(MapIndex < 64 - kMaxQualityLevels);				GameMask |= (1ULL << static_cast<uint64>(kMaxQualityLevels + MapIndex));				// 默认按位AND比较将起作用，无需重载比较函数		FShaderPipelineCache::SetGameUsageMaskWithComparison(GameMask);	 	} 
```

如果游戏中有超过60张贴图，或者你要编码粒度更细的质量设置，你可以用不同的方式生成掩码，例如将uint64视为几个位段的结构，然后使用自定义比较函数来比较它们。例如：

```
 	union	{		uint64 Packed;		struct		{			uint64 MaterialQuality : 4;			uint64 ShadowQuality : 4;			uint64 MapIndex : 16;		};	}; 
```

此函数需要应用程序在启动初期设置，例如在加载/保存用户设置（ `UGameUserSettings` **）** 时。它适用于以下各种情况：

- 在记录过程中 – 记录的PSO将与当前使用掩码关联。
- 编译期间 – 仅匹配当前使用掩码的PSO才会从缓存中编译。

由于编译很早就开始了，你可能要默认为以 *暂停* 状态启动它（见下文），并在设置正确的掩码后显式重新启用。

### 局限性与未来的工作

目前，掩码概念本质上依赖于人工采集。相比之下，在烘焙过程中自动添加到缓存中的计算PSO的掩码均为 `0xffffffffffffffff` （全为1）。实现PSO缓存的程序化填充意味着，同样将自动缓存应用于（某些）图形PSO，用户掩码概念可能会发展成不同的方法或完全停止使用。

如果你的游戏内容被拆分为多个下载项，则很难将PSO缓存拆分成块以对应独立的内容包。

> [!NOTE]
> 本文档不涉及拆分缓存。要详细了解缓存拆分，请参阅[烘焙和分块](https://dev.epicgames.com/documentation/404)。

## 控制PSO编译

缓存中包含的PSO需要编译，以便在渲染代码需要它们时准备就绪。在使用默认设置的新项目中，应用程序启动后，捆绑的PSO缓存文件会自动打开，编译自动开始。如果不适用（例如，因为你需要设置自定义使用掩码），你可以使用 `r.ShaderPipelineCache.StartupMode=0` 暂停编译，并稍后使用 `FShaderPipelineCache::ResumeBatching()` 恢复它。

编译PSO时，你可以使用数种启动模式：

| **值** | **模式** | **说明** |
| --- | --- | --- |
| 0 | 暂停（Paused） | 编译在恢复前处于暂停状态。 |
| 1 | 快速（Fast） | 建议在加载屏幕时或在游戏的其他非交互部分使用快速模式 |
| 2 | 后台（Background） | 后台模式更适合在玩家导览UI时进行编译。 |
| 3 | 预编译（Precompile） | 结合了快速模式和后台模式的属性。使用单独的预编译使用掩码（使用 `r.ShaderPipelineCache.PreCompileMask` 配置）在快速模式下编译与其匹配的PSO，但对其余部分使用后台模式（仅与常规使用掩码匹配）。 |

如果游戏要将加载屏幕保持更长的时间，你还可以通过调用 `FShaderPipelineCache::NumPrecompilesRemaining()` 来查询要编译的未完成PSO的数量，直到编译完成。

模式具有粒度更精细的设置，这意味着你可以一次性设置预编译的批处理大小以及每帧预编译的目标时间。编译PSO所需的实际时间超出了游戏的控制范围。

## 用户缓存文件

即使你为游戏提供PSO缓存，用户也可能会遇到采集过程中未涵盖的内容。有些驱动程序可以提供自己的缓存，但为了更加独立于驱动程序行为，游戏默认尝试采集错过的PSO，并将其保存到本地用户缓存文件中。这些位于游戏的 `Saved` 目录（ `FPaths::ProjectSavedDir()` ）中，即与游戏的用户设置处于同一目录。应用程序会在启动时加载这些用户缓存文件，并将其内容与构建中包含的文件合并。

用户缓存PSO文件采用记录的缓存格式。这意味着它们使用其SHA哈希值来引用着色器，并且无法在更改大量内容的大型游戏更新中使用。因此，每个文件都嵌入了 *游戏版本* ，该版本会根据正在运行的应用程序进行检查。版本在 `DefaultGame.ini` 中配置，如下例所示，每次应用程序发布可能不兼容的更新（例如包含内容更改或显著渲染代码更改的更新）时，都需要提升版本。

```
 [ShaderPipelineCache.CacheFile] GameVersion=1234 
```

默认情况下，`GameVersion` 取自 `EngineVersion` ，它反过来通常密切跟踪Perforce变更列表，使两个不同构建写入的用户缓存不兼容（即使没有相关更改）。

为了防止缓存文件无限增长，应用程序在加载时会立即对其中的条目进行垃圾回收。此操作基于条目的最后使用时间，可通过控制台变量 `r.ShaderPipelineCache.UserCacheUnusedElementRetainDays` 进行配置。默认值为30天。

> [!NOTE]
> Vulkan和OpenGL ES RHI在RHI中有自己的低等级管线缓存。编译PSO后（无论源代码是缓存还是由代码创建），它将保存到该缓存中，并在下一次启动时选取。使用这些图形API时可能无需启用用户缓存文件。

## 手动PSO缓存和运行时PSO预缓存之间的交互

启用运行时[PSO预缓存系统](../pso-precaching/index.md)后，你可能会发现不再需要构建手动收集的缓存。但某些情况下，收集和发布手动构建的PSO缓存可能仍然有益。启用PSO预缓存时，可使用以下选项微调手动缓存系统的行为：

| **控制台变量** | **说明** | **默认设置** |
| --- | --- | --- |
| `r.ShaderPipelineCache.ExcludePrecachePSO` | 控制缓存是否仅收集PSO预缓存系统缺失的PSO。这样可以使缓存更精简，只针对缺失的PSO。注意，此选项需要设置 `r.PSOPrecache.Validation` 。 | 禁用 |
| `r.ShaderPipelineCache.OnlyOpenUserCache` | 禁用加载任何捆绑的缓存，但仍打开用户缓存。如果你发布时不打算附带PSO缓存文件，但仍然想要让用户可以在玩游戏时收集PSO缓存，那么这是一个不错的选择。 | 禁用 |

## 常见问题解答

**我需要多久采集一次PSO？**

理想情况下，你应该在每次大幅添加、更新或更改内容时，重新捕获项目的PSO数据。然而，在实践中，由于发展迅速，这无法实现。由于每个项目都有不同的PSO采集要求，因此无法建立严格的时间表。根据以往经验，如果你觉得构建开始经常出现卡顿，则需要更新PSO缓存。特别是，如果某个构建没有最新的缓存，那就永远不要测量它的性能，或者说至少不要将这些测量值用于比较。

**我是否需要制作特别的PSO缓存关卡？**

虽然你可以从项目的标准关卡捕获所有需要的PSO数据，但某些项目可能会从创建特殊的PSO捕获关卡中受益。你可以设置这些关卡，以便它们生成特定类型的所有资产，然后捕获其PSO数据。如果项目包含需要时间解锁或动态生成的内容，则尤其如此。

**我没有采集任何PSO，但我的构建有PSO缓存，为什么？！**

如果有Niagara内容，这是必然的。计算PSO在烘焙过程中会自动添加到缓存（如果你已为项目启用缓存）。

**我的构建中有PSO缓存，但游戏仍然卡顿。**

首先，验证以下内容：

- 游戏在缓存支持的图形API上运行（例如 D3D12，但 *不是* D3D11），
- 该文件在游戏开始时打开。
- 正确的PSO正在后台编译。

为此，请检查日志文件，并查找 **LogRHI** 日志记录类别。你应看到如下行：

LogRHI: Opened FPipelineCacheFile: ../../../TestGame/Content/PipelineCaches/Windows/TestGame_PCD3D_SM6.stable.upipelinecache (GUID: 91C5586843C2B5CEE3F4F7BE47E71253) with 908 entries.

LogRHI: Display: Opened pipeline cache after state change and enqueued 908 of 908 tasks for precompile.

条目和任务的数量会有所不同，但不应为0。

其次，检查发现多少新的PSO。为此，使用-logPSO命令行开关（或启用用户缓存文件）运行构建，并查看你遇到如下行的频率：

LogRHI: Display: Encountered a new graphics PSO: 4233039161

`PSO:` 后面的数字会有所不同。如果你看到数字很大，并且它们看起来与卡顿相符，则缓存可能存在问题。请再次采集当前内容的缓存。你甚至可能需要从头开始。

如果没有出现这些行，或者你在D3D11上运行，但你的构建仍然卡顿，则卡顿可能并非与PSO直接相关。对于这种情况，我们建议使用CPU分析器分析游戏，以便了解卡顿的特性。
