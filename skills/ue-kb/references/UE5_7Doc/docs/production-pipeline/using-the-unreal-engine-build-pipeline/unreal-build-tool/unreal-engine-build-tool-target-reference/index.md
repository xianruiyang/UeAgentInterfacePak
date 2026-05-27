---
title: "目标"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-build-tool-target-reference"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "用虚幻构建管线", "虚幻编译工具", "目标"]
---

# 目标

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 用虚幻构建管线 / 虚幻编译工具 / 目标

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-build-tool-target-reference

**虚幻编译工具（UBT）**支持编译数个目标类型：

- **游戏（Game）**：需要烘焙数据才能运行的单机游戏。
- **客户端（Client）**：与游戏（Game）相同，但不包含服务器代码。 适用于联网游戏。
- **服务器（Server）**：与游戏（Game）相同，但不包含客户端代码。 适用于联网游戏中的专用服务器。
- **编辑器（Editor）**：可扩展虚幻编辑器的目标。
- **程序（Program）**：基于虚幻引擎打造的独立工具程序。

目标通过C#源文件进行声明，这些文件的扩展名为`.target.cs`，存储在项目的根目录下。 每个`.target.cs`文件都会声明一个衍生于`TargetRules`基类的类，并设置属性来控制其通过构造函数编译的方式。 收到编译目标的要求时，虚幻编译工具会编译你的`.target.cs`文件，并在其中构造类来确定其设置。

类的名称必须与在文件内部声明该类的文件的名称相匹配，后跟 'Target'（例如，`MyProject.target.cs`将定义类`MyProjectTarget`）。

目标文件的典型结构如下:

C++

```
using UnrealBuildTool;	using System.Collections.Generic;	public class MyProjectTarget : TargetRules	{		public MyProjectTarget(TargetInfo Target) : base(Target)		{			Type = TargetType.Game;			// Other properties go here		}	}
```

### 只读属性

$ OriginalName (String)：返回无重载或装饰的原始目标名称

$ IsTestTarget (Boolean)：此目标是否为低级测试目标。

$ ExplicitTestsTarget (Boolean)：此目标是否为显式定义的测试目标。 显式定义的测试目标始终继承自TestTargetRules并定义其自身的测试。 隐式测试目标在使用-Mode=Test编译时从现有目标创建，并且包括来自所有依赖项的测试。

$ WithLowLevelTests (Boolean)：控制WITH_LOW_LEVEL_TESTS的值，该值指示是否编译模块特有的低级别测试。

$ Architecture (UnrealArch)：在架构中只有单一架构的正常情况下获取该架构（如果指定了多个架构，此属性将引发异常）。

$ bIWYU (Boolean)：默认为此目标中的模块启用"包含你所使用的内容（include what you use）"。 将此项目中所有模块的默认PCH模式更改为PCHUsageMode.UseExplicitOrSharedPCHs。

$ DisableDebugInfoModules (HashSet<String>)：应该禁用调试信息的模块

$ DisableDebugInfoPlugins (HashSet<String>)：应该禁用调试信息的插件

$ DebugInfoLineTablesOnlyModules (HashSet<String>)：对于支持这样做的编译器，应该发出行号表而不是完整调试信息的模块。 重载DisableDebugInfoModules

$ DebugInfoLineTablesOnlyPlugins (HashSet<String>)：对于支持这样做的编译器，应该发出行号表而不是完整调试信息的插件。 重载DisableDebugInfoPlugins

$ MergePlugins (List<String>)：试验性：需要被分别合并入单独库中的插件（及其依赖项）的列表。 要求启用bMergeModules

$ MergePluginsShared (Dictionary<String, HashSet<String>>)：试验性：负责将常用依赖项移动到共享库的已合并插件的列表。需要MergePlugins。 可以被链接

$ MergePluginsLaunch (List<String>)：试验性：负责移动到主要可执行文件的已合并插件的列表。需要MergePlugins。 针对所有共享引擎模块，请用"Engine"，针对共享项目模块，请用"Common"。

$ GlobalDefinitions (List<String>)：在整个目标中全局定义的宏。

$ ProjectDefinitions (List<String>)：要在项目中的所有宏之间定义的宏。

$ ExtraModuleNames (List<String>)：要编译到目标中的额外模块的列表。

$ ManifestFileNames (List<FileReference>)：为此目标输出清单的路径

$ DependencyListFileNames (List<FileReference>)：预编译时，此目标的依赖项列表的路径

$ PreBuildTargets (List<TargetInfo>)：指定目标列表，其中的目标应该在此目标之前编译。

$ PreBuildSteps (List<String>)：在主机平台的shell上下文中，指定编译此目标前应执行的步骤的列表。 执行前将展开下列变量：$(EngineDir)、$(ProjectDir)、$(TargetName)、$(TargetPlatform)、$(TargetConfiguration)、$(TargetType)、$(ProjectFile)。

$ PostBuildSteps (List<String>)：在主机平台的shell上下文中，指定编译此目标后应执行的步骤的列表。 执行前将展开下列变量：$(EngineDir)、$(ProjectDir)、$(TargetName)、$(TargetPlatform)、$(TargetConfiguration)、$(TargetType)、$(ProjectFile)。

$ AdditionalBuildProducts (List<String>)：指定作为此目标的一部分而生成的额外构建产品。

$ HostPlatform (UnrealTargetPlatform)：获取作为编译基础的主机平台

$ bGenerateProjectFiles (Boolean)：将bGenerateProjectFiles标记公开给目标，从而让我们可以修改行为，以获得更好的智能感知

$ bShouldTargetRulesTogglePlugins (Boolean)：指示是否应使用目标规则来显式启用或禁用插件。 除非项目文件指明是否应该编译引用插件，否则在项目生成过程中并非必需。

$ bIsEngineInstalled (Boolean)：公开是否已安装引擎的设置

### 读写属性

$ BuildPlugins (List<String>)：为此目标类型编译但未启用的额外插件。

$ AdditionalPlugins (List<String>)：需要被包含在此目标中的额外插件的列表。 此属性让你能引用无法禁用的非可选插件模块，并让你能针对程序目标中不属于ModuleHostType下类别的具体模块进行编译。

$ EnablePlugins (List<String>)：应为此目标包含的额外插件。

$ DisablePlugins (List<String>)：需要为此目标禁用的插件的列表。 请注意，项目文件仍可能引用这些插件，因此应该将它们标记为可选，避免在运行时找不到。

$ OptionalPlugins (List<String>)：应该为此目标包含的额外插件（如果被发现）。

$ InternalPluginDependencies (List<String>)：可以作为依赖项存在，但未在uplugin描述符中定义的插件名称的列表

$ DisableMergingModuleAndGeneratedFilesInUnityFiles (String[])：禁用在同一Unity文件中合并模块和被生成的cpp文件的模块的列表。

$ bShowIncludes (Boolean)：打印出各源文件所包含的文件

$ DisableUnityBuildForModules (String[])：需要禁用Unity构建的模块的列表

$ EnableOptimizeCodeForModules (String[])：需要启用优化的模块的列表

$ DisableOptimizeCodeForModules (String[])：需要禁用优化的模块的列表

$ OptimizeForSizeModules (String[])：需要优化大小的模块的列表。 这将允许目标重载模块优化级别。请注意，如果未提供私有PCH，这可能会禁用PCH

$ OptimizeForSizeAndSpeedModules (String[])：需要优化大小和速度的模块的列表。 这将允许目标重载模块优化级别。请注意，如果未提供私有PCH，这可能会禁用PCH

$ OptedInModulePlatforms (UnrealTargetPlatform[])：如果此属性非空，那么未列出的平台都将被禁止在其目录中创建模块

$ Name (String)：此目标的名称

$ Logger (ILogger)：与此目标相关的输出的记录器。 在运行构造函数之前设置

$ AdditionalData (Object)：通用可空对象，让用户可以在项目的TargetRule中设置额外数据，并在项目的ModuleRule中设置访问权限，而无需在发布后添加新的属性。 例如：

* in .Target.cs: AdditionalData = "data";

* in .Build.cs: if ((Target.AdditionalData as string) == "data") { ... }

$ Platform (UnrealTargetPlatform)：要为哪个平台编译此目标。

$ Configuration (UnrealTargetConfiguration)：正在编译的配置。

$ Architectures (UnrealArchitectures)：要为哪个架构编译此目标（默认值为空字符串）。

$ IntermediateEnvironment (UnrealIntermediateEnvironment)：中间环境。 确定中间文件是否位于与正常情况不同的文件夹中。

$ ProjectFile (FileReference)：通往包含此目标的项目的项目文件路径。

$ Version (ReadOnlyBuildVersion)：当前构建版本

$ Type (TargetType)：目标的类型。

$ DefaultBuildSettings (BuildSettingsVersion)：指定用于维护向下兼容的默认编译设置的引擎版本（例如， DefaultSettingsVersion.Release_4_23、DefaultSettingsVersion.Release_4_24)。 指定DefaultSettingsVersion.Latest始终使用当前引擎版本的默认值，但有可能在升级时引入构建错误。

$ ForcedIncludeOrder (Nullable<EngineIncludeOrderVersion>)：将包含顺序强制指定为具体版本。 重载所有目标和模块规则。

$ IncludeOrderVersion (EngineIncludeOrderVersion)：编译此目标时使用哪个版本的包含顺序。 可以在命令行中使用-ForceIncludeOrder来重载。 ModuleRules.IncludeOrderVersion具有优先权。

$ OutputFile (String)：主可执行文件的输出文件路径（相对于引擎或项目目录）。 此设置通常仅适用于非虚幻引擎程序，因为引擎会使用相对于可执行文件的路径来查找其他已知文件夹（例如 Content）。

$ bUsesSteam (Boolean)：目标是否使用Steam。

$ bUsesCEF3 (Boolean)：目标是否使用CEF3。

$ bUsesSlate (Boolean)：项目是否使用可视的Slate UI（与始终可用的低级视窗/消息传递相反）。

$ bUseStaticCRT (Boolean)：强制与静态CRT链接。 由于需要共享分配器实现（举例而言），并且TPS库彼此一致，所以此功能并非完全受整个引擎支持，但可用于实用程序。

$ bDebugBuildsActuallyUseDebugCRT (Boolean)：为调试构建启用调试C++运行时（CRT）。 默认情况下，我们始终使用发布运行时，因为调试版本在调试虚幻引擎项目时并不是特别有用，并且连接到调试CRT库会强制我们的第三方库依赖性也使用调试CRT进行编译（并且通常执行速度会更慢）。 通常，仅仅为了调试程序代码而要求第三方静态库调试版本的单独副本，可能很不方便。

$ bLegalToDistributeBinary (Boolean)：此目标的输出是否可以公开发布，即使它依赖某些模块，而这些模块存在于带有特殊限制的文件夹中（例如 CarefullyRedist、NotForLicensees、NoRedist）。

$ UndecoratedConfiguration (UnrealTargetConfiguration)：指定二进制文件不需要"-Platform-Configuration"后缀的配置。

$ DecoratedSeparator (String)：指定二进制文件名的分隔符字符。

$ bAllowHotReload (Boolean)：此目标是否支持热重载

$ bBuildAllModules (Boolean)：编译对此目标类型有效的所有模块。 用于CIS以及创建已安装引擎的构建。

$ VSTestRunSettingsFile (FileReference)：将此属性设为可引用生成的项目中的VSTest运行设置文件。

$ bRuntimeDependenciesComeFromBuildPlugins (Boolean)：如果为true，则使用BuildPlugins列表填充RuntimeDependencies，而非EnablePlugins

$ bAllowEnginePluginsEnabledByDefault (Boolean)：如果为False，则不加载未被项目或目标文件显式启用的"默认启用"的引擎插件。

$ DisablePluginsConflictWarningLevel (WarningLevel)：如何处理已禁用的插件被引用它的另一个插件启用而造成的冲突

$ PakSigningKeysFile (String)：内嵌到可执行文件中的pak签名密钥集的路径。

$ SolutionDirectory (String)：允许程序目标指定自身的解决方案文件夹路径。

$ bGenerateProgramProject (Boolean)：强制将目标视为程序，以便生成项目文件。

$ bExplicitTargetForType (Boolean)：若为True，则GetTargetNameByType将无视此目标，从而对-TargetType=X消除歧义。

$ bBuildInSolutionByDefault (Nullable<Boolean>)：目标是否应被包含在默认解决方案编译配置中。如果将此属性设为False，那么在IDE中运行时将跳过编译

$ bShouldCompileAsDLL (Boolean)：是否应将此目标编译为DLL。 需要将LinkType设置为TargetLinkType.Monolithic。

$ CustomConfig (String)：用于加载配置文件的额外子目录，用于在同一平台上制作多种类型的构建。这将作为CUSTOM_CONFIG被烘焙到游戏可执行文件中，并在被暂存到筛选文件和设置时使用

$ ExeBinariesSubFolder (String)：用于放置可执行文件的子文件夹（相对于默认位置）。

$ GeneratedCodeVersion (EGeneratedCodeVersion)：允许目标模块重载UHT代码生成版本。

$ bEnableMeshEditor (Boolean)：是否启用网格体编辑器。

$ bUseVerseBPVM (Boolean)：是否使用BPVM运行Verse。

$ bUseAutoRTFMCompiler (Boolean)：是否使用AutoRTFM Clang编译器。

$ bForceNoAutoRTFMCompiler (Boolean)：是否使用强制关闭AutoRTFM Clang编译器。

$ bUseAutoRTFMVerifier (Boolean)：是否启用发送AutoRTFM验证元数据

$ bCompileChaos (Boolean)：是否编译Chaos物理系统插件。

$ bUseChaos (Boolean)：是否使用Chaos物理系统接口。 此属性将重载PhysX标记以禁用APEX和NvCloth

$ bUseChaosChecked (Boolean)：是否在勾选的Chaos功能中编译以进行调试

$ bUseChaosMemoryTracking (Boolean)：是否在Chaos内存跟踪功能中编译

$ bCompileChaosVisualDebuggerSupport (Boolean)：是否在Chaos视觉调试器（CVD）支持功能中编译，以记录物理模拟的状态

$ bCustomSceneQueryStructure (Boolean)：场景查询加速是否由虚幻引擎完成。 仍会创建PhysX场景查询结构，但我们不会使用它。

$ bCompilePhysX (Boolean)：是否要包含PhysX支持。

$ bCompileAPEX (Boolean)：是否要包含PhysX APEX支持。

$ bCompileNvCloth (Boolean)：是否要包含NvCloth。

$ bCompileICU (Boolean)：是否在Core中包含ICU unicode/i18n支持。

$ bCompileCEF3 (Boolean)：是否编译CEF3支持。

$ bCompileISPC (Boolean)：是否使用ISPC编译。

$ bCompileIntelMetricsDiscovery (Boolean)：是否要编译IntelMetricsDiscovery。

$ bCompilePython (Boolean)：是否在python支持中编译

$ bUseGameplayDebugger (Boolean)：是否在引擎的所有默认Gameplay调试器类别启用WITH_GAMEPLAY_DEBUGGER的情况下编译。

$ bUseGameplayDebuggerCore (Boolean)：当bUseGameplayDebugger为false，但需要GameplayDebugger的核心部分时，将此属性设为True。

$ bCompileIoStoreOnDemand (Boolean)：是否按需使用I/O存储

$ bUseIris (Boolean)：是否使用Iris。

$ bTrackRHIResourceInfoForTest (Boolean)：是否为配置Test而追踪RHI资源的所有者（资产名称）。 适用于ListShaderMaps和ListShaderLibraries命令。

$ bBuildEditor (Boolean)：是否编译编辑器代码。 首选改用更显式的bCompileAgainstEditor。

$ bBuildRequiresCookedData (Boolean)：是否编译与编译资产相关的代码。 主机通常无法编译资产。 但桌面平台一般都可以。

$ bBuildWithEditorOnlyData (Boolean)：是否编译禁用的WITH_EDITORONLY_DATA。 仅Windows会使用此属性，其他平台会强制此项为False。

$ bBuildDeveloperTools (Boolean)：是否编译开发者工具。

$ bBuildTargetDeveloperTools (Boolean)：是否编译用于目标平台或连接设备的开发者工具（默认为bBuildDeveloperTools）。

$ bForceBuildTargetPlatforms (Boolean)：是否强制编译目标平台模块，即使它们通常不会被编译。

$ bForceBuildShaderFormats (Boolean)：是否强制编译着色器格式模块，即使它们通常不会被编译。

$ bNeedsExtraShaderFormatsOverride (Nullable<Boolean>)：重载以包含额外着色器格式

$ bNeedsExtraShaderFormats (Boolean)：是否应该包含任何额外的着色器格式。 默认仅为程序和编辑器目标启用此属性。

$ bCompileCustomSQLitePlatform (Boolean)：应使用自定义"虚幻"平台（true）还是使用原生平台（false）编译SQLite。

$ bUseCacheFreedOSAllocs (Boolean)：是否用MallocBinned来利用缓存释放的操作系统分配

$ bCompileAgainstEngine (Boolean)：为所有包含引擎项目的构建启用。 仅在编译仅与Core链接的独立应用时禁用。

$ bCompileAgainstCoreUObject (Boolean)：为所有包含CoreUObject项目的构建启用。 仅在编译仅与Core链接的独立应用时禁用。

$ bCompileAgainstApplicationCore (Boolean)：为需要初始化ApplicationCore模块的构建启用。 命令行实用程序通常不需要此属性。

$ bEnableTrace (Boolean)：为要针对Trace模块使用以进行分析和诊断的构建启用。

$ bForceEnableTrace (Boolean)：强制启用追踪 - 用于让测试程序验证追踪功能是否按预期正常运行。

$ bCompileAgainstEditor (Boolean)：为编辑器构建（TargetType.Editor）启用。 对于需要根据编辑器代码进行编译的程序（TargetType.Program），可以重载。 不可用于其他目标类型。 主要驱动WITH_EDITOR的值。

$ bCompileRecast (Boolean)：是否编译Recast寻路网格体生成。

$ bCompileNavmeshSegmentLinks (Boolean)：是否使用寻路网格体片段链接进行编译。

$ bCompileNavmeshClusterLinks (Boolean)：是否使用寻路网格体群集链接进行编译。

$ bCompileSpeedTree (Boolean)：是否应该编译对SpeedTree的支持。

$ bForceEnableExceptions (Boolean)：为所有模块启用异常。

$ bUseInlining (Boolean)：为所有模块启用内联。

$ bForceEnableObjCExceptions (Boolean)：为所有模块启用异常。

$ bForceEnableRTTI (Boolean)：为所有模块启用RTTI。

$ bEnablePrivateBuildInformation (Boolean)：启用BuildSettings，以包含关于构建的私有信息。 例如机器名、用户名和用户域名等（在BuildSettings.h中公开）

$ bEnablePIE (Boolean)：启用位置无关可执行文件（PIE）。 有间接开销

$ bEnableStackProtection (Boolean)：启用堆栈保护。 有间接开销

$ bWithClientCode (Boolean)：编译仅客户端代码。

$ bWithServerCode (Boolean)：编译仅服务器代码。

$ bFNameOutlineNumber (Boolean)：在FName将数字部分存储在名称表的情况下进行编译。 当大多数名称未编号且已编号的名称被多次引用时，可节省内存。 游戏和引擎必须确保它们重复使用类似于名称字符串的编号名称，以避免内存泄漏。

$ bWithPushModel (Boolean)：启用后，将编译推送模型网络支持。 这有助于减少网络的CPU开销，但内存开销更大。 始终在编辑器构建中启用。

$ bCompileWithStatsWithoutEngine (Boolean)：是否包含统计数据支持，即使没有引擎也不例外。

$ bCompileWithPluginSupport (Boolean)：是否要包含插件支持。

$ bIncludePluginsForTargetPlatforms (Boolean)：是否允许支持所有目标平台的插件。

$ bCompileWithAccessibilitySupport (Boolean)：是否在Slate和OS层中均允许无障碍代码。

$ bWithPerfCounters (Boolean)：是否要包含对PerfCounters的支持。

$ bWithLiveCoding (Boolean)：是否启用对实时编码的支持

$ bUseDebugLiveCodingConsole (Boolean)：是否启用对实时编码的支持

$ bWithDirectXMath (Boolean)：是否启用对DirectX Math LWC_TODO的支持：不再支持。 需要删除。

$ bWithFixedTimeStepSupport (Boolean)：是否在引擎中启用对FixedTimeStep的支持

$ bUseLoggingInShipping (Boolean)：是否为测试/发布编译开启日志记录功能。

$ bUseConsoleInShipping (Boolean)：是否为发布构建开启控制台。

$ bLoggingToMemoryEnabled (Boolean)：是否为测试/发布构建开启记录到内存功能。

$ bUseLauncherChecks (Boolean)：是否检查进程是否由外部启动程序启动。

$ bUseChecksInShipping (Boolean)：是否为测试/发布构建开启检查（断言）功能。

$ bAllowProfileGPUInTest (Boolean)：是否为测试构建开启GPU标识功能。

$ bAllowProfileGPUInShipping (Boolean)：是否为发布构建开启GPU标识功能。

$ bTCHARIsUTF8 (Boolean)：是否开启UTF-8模式，将TCHAR映射到UTF8CHAR。

$ bUseEstimatedUtcNow (Boolean)：是使用EstimatedUtcNow还是PlatformUtcNow。 在PlatformUtcNow可能很慢的情况下，适合使用EstimatedUtcNow。

$ bCompileFreeType (Boolean)：如果需要FreeType支持，则设为True。

$ bUseExecCommandsInShipping (Boolean)：是否为发布构建开启允许执行命令功能。

$ bCompileForSize (Boolean)：如果要优先考虑优化的规模而非速度，则设为True。

$ OptimizationLevel (OptimizationMode)：允许微调优化级别，以提高速度和/或优化代码大小

$ FPSemantics (FPSemanticsMode)：允许设置FP语意。

$ bForceCompileDevelopmentAutomationTests (Boolean)：是否编译开发自动化测试。

$ bForceCompilePerformanceAutomationTests (Boolean)：是否编译性能自动化测试。

$ bForceDisableAutomationTests (Boolean)：是否重载自动化测试的默认值（调试/开发配置）

$ bEventDrivenLoader (Boolean)：若为True，将在烘焙构建中使用由事件驱动的加载程序。 @todoio 这需要在异步加载重构之后替换为运行时解决方案。

$ NativePointerMemberBehaviorOverride (Nullable<PointerMemberBehavior>)：用于重载控制是否允许UCLASS和USTRUCT具有原生指针成员的行为，如果不允许，那么它们将被视为UHT错误，且应该用TObjectPtr成员代替。

$ bUseXGEController (Boolean)：引擎构建中是否应包含XGE控制器的工作程序和模块。 这些是使用XGE拦截接口进行分布式着色器编译所必需的。

$ bIncludeHeaders (Boolean)：将所含模块中的头文件添加到构建中。

$ bHeadersOnly (Boolean)：若与-IncludeHeaders一起使用，则仅编译头文件。

$ bEnforceIWYU (Boolean)：强制执行"包含你所使用的内容（include what you use）"规则；使用单块头文件（Engine.h、UnrealEd.h等）时发出警告，并首先检查源文件是否包含了与其匹配的头文件。

$ bWarnAboutMonolithicHeadersIncluded (Boolean)：如果编译此目标时包含了旧样式的单块头文件，则发出警告。

$ bHasExports (Boolean)：最终的可执行文件是否应该导出符号。

$ bPrecompile (Boolean)：将所有引擎模块的静态库设为此目标的中间项。

$ bEnableOSX109Support (Boolean)：是否应在支持OS X 10.9 Mavericks的情况下进行编译。 适用于需要兼容该版OS X的某些工具。

$ bIsBuildingConsoleApplication (Boolean)：如果正在编译的是主机应用程序，则为True。

$ bBuildAdditionalConsoleApp (Boolean)：如果为true，则创建额外的主机应用程序。 在根据应用程序的调用方式，无法有条件地继承父项的主机窗口时，已为Windows做了破解；你必须将相同的可执行文件与不同的子系统设置链接。

$ bBuildConsoleAppOnly (Boolean)：如果为True，则仅创建一个额外的主机应用程序。 重载bBuildAdditionalConsoleApp。

$ bDisableSymbolCache (Boolean)：如果为某些平台缓存的调试符号不应该被创建，则为True。

$ bUseUnityBuild (Boolean)：是否将C++代码统一到更大的文件中，从而加快编译。

$ bForceUnityBuild (Boolean)：是否强制将C++源文件合并为更大的文件，从而加快编译速度。

$ bMergeModuleAndGeneratedUnityFiles (Boolean)：是否合并模块和被生成的Unity文件，以加快编译速度。

$ bUseAdaptiveUnityBuild (Boolean)：使用启发法确定当前正在迭代哪些文件，并将它们从Unity Blob中排除，从而加快增量编译。 当前实现使用只读标记区分工作集，假定文件在被修改时将被源代码控制系统设为可写。 这对Perforce有效，但对Git则不然。

$ bAdaptiveUnityDisablesOptimizations (Boolean)：禁止优化位于自适应非Unity工作集中的文件。

$ bAdaptiveUnityDisablesPCH (Boolean)：禁用对位于自适应非Unity工作集中的文件强制包含PCH。

$ bAdaptiveUnityDisablesProjectPCHForProjectPrivate (Nullable<Boolean>)：bAdaptiveUnityDisablesProjectPCH的备份存储。

$ bAdaptiveUnityDisablesPCHForProject (Boolean)：是否为自适应非Unity工作集中的项目源文件禁用强制包含的PCH。 默认为bAdaptiveUnityDisablesPCH；

$ bAdaptiveUnityCreatesDedicatedPCH (Boolean)：为工作集中的每个源文件创建专用PCH，从而对仅限cpp的更改实现更快的迭代。

$ bAdaptiveUnityEnablesEditAndContinue (Boolean)：为工作集中的每个源文件创建专用PCH，从而对仅限cpp的更改实现更快的迭代。

$ bAdaptiveUnityCompilesHeaderFiles (Boolean)：为工作集中的每个头文件创建专用源文件，以便检测头文件中缺少的包含项。

$ MinGameModuleSourceFilesForUnityBuild (Int32)：为某模块激活Unity构建之前，该游戏模块中的源文件数量。 这允许小型游戏模块加快对单个文件的迭代编译，但代价是完全重新编译会更慢。 此设置可以由模块的Build.cs文件中的bFasterWithoutUnity选项重载。

$ DefaultWarningLevel (WarningLevel)：未分类警告的默认处理方式

$ bRequireObjectPtrForAddReferencedObjects (Boolean)：需要FReferenceCollector API的TObjectPtr。 （兼容增量GC所需。）

$ bValidateFormatStrings (Boolean)：针对不正确的UE_LOG格式字符串发送编译错误。

$ DeprecationWarningLevel (WarningLevel)：将废弃警告报告为错误的级别

$ ShadowVariableWarningLevel (WarningLevel)：在支持的平台上强制将阴影变量警告视为错误。

$ bWarningsAsErrors (Boolean)：是否将全部警告作为错误启用。 UE已经将大多数警告作为错误启用，但禁用了一些警告（例如废弃警告）。

$ UnsafeTypeCastWarningLevel (WarningLevel)：指示在支持的平台上，将不安全类型转换视成何种警告/错误级别（例如，double转换为float或int64转换为int32）。

$ bUndefinedIdentifierErrors (Boolean)：强制将条件表达式中对未定义标识符的使用视为错误。

$ UndefinedIdentifierWarningLevel (WarningLevel)：指示将条件表达式中使用的未定义标识符视为何种警告/错误级别。

$ PCHPerformanceIssueWarningLevel (WarningLevel)：指示将潜在PCH性能问题视为何种警告/错误级别。

$ ModuleIncludePathWarningLevel (WarningLevel)：如何处理一般模块包含路径验证消息

$ ModuleIncludePrivateWarningLevel (WarningLevel)：如何处理私有模块包含路径验证消息，其中模块会添加暴露私有头文件的包含路径

$ ModuleIncludeSubdirectoryWarningLevel (WarningLevel)：如何处理不必要的模块子目录包含路径验证消息

$ bRetainFramePointers (Boolean)：强制保留帧指针。通常在你需要可靠的调用堆栈时需要这么做（例如 mallocframeprofiler）

$ bRetainFramePointersOverride (Nullable<Boolean>)：强制保留帧指针。通常在你需要可靠的调用堆栈时需要这么做（例如 mallocframeprofiler）

$ bUseFastMonoCalls (Boolean)：新的单块图形驱动程序具有可选的"快速调用"，替换各种D3d函数

$ NumIncludedBytesPerUnityCPP (Int32)：要包含在单个统一C++文件中的目标C++代码的大致字节数。

$ bDisableModuleNumIncludedBytesPerUnityCPPOverride (Boolean)：禁用模块所设的重载项

$ bStressTestUnity (Boolean)：是否将所有C++文件包含在来自单个统一文件的项目中，以此对C++ Unity构建的健壮性进行压力测试。

$ bDetailedUnityFiles (Boolean)：是否为Unity文件添加额外信息，如文件名中的'_of_X'。 不推荐使用。

$ bForceDebugInfo (Boolean)：是否强制生成调试信息。

$ bDisableDebugInfo (Boolean)：是否全局禁用调试信息生成；已废弃，请改用TargetRules.DebugInfoMode

$ DebugInfo (DebugInfoMode)：应该生成多少调试信息。 详情请参阅DebugInfoMode枚举

$ DebugInfoLineTablesOnly (DebugInfoMode)：如果对于支持此操作的编译器，调试信息中只应该发出调试行号表，则为True。 这将重载TargetRules.DebugInfo。请参阅https://clang.llvm.org/docs/UsersManual.html#cmdoption-gline-tables-only了解详情

$ bDisableDebugInfoForGeneratedCode (Boolean)：是否针对已生成文件禁用调试信息生成。 对于具有大量已生成粘合代码的模块，此操作可加快连接并缩小pdb。

$ bOmitPCDebugInfoInDevelopment (Boolean)：是否对PC/Mac上的开发构建禁用调试信息（以便加快开发者迭代，因为在禁用调试信息后，连接时间会非常快）。

$ bUsePDBFiles (Boolean)：是否应该将PDB文件用于Visual C++构建。

$ bUsePCHFiles (Boolean)：是否应该使用PCH文件。

$ bDeterministic (Boolean)：设置确定性编译和链接所需的标记。 为msvc启用确定性模式会禁用代码生成的多线程化，因此编译会变慢

$ bChainPCHs (Boolean)：使用Clang编译时，是否应该链接PCH。

$ bForceIncludePCHHeadersForGenCppFilesWhenPCHIsDisabled (Boolean)：禁用PCH时，是否应强制将PCH头文件包含在gen.cpp文件中。

$ bPreprocessOnly (Boolean)：是否只为此目标预处理源文件并跳过编译

$ bPreprocessDepends (Boolean)：通过预处理生成依赖文件。 建议仅在发布构建时使用，因为这会增加性能开销。

$ bWithAssembly (Boolean)：编译此目标时是否生成程序集数据。 目前仅用于MSVC。

$ bAllowUbaCompression (Boolean)：试验性：将压缩的对象（.obj）存储在磁盘上。 链接需要UBA，目前仅限MSVC。 切换此标记将使MSVC操作无效。 警告：此选项目前不兼容PGO或cl-clang连接器，因为它们未被绕行，因此链接将失败。

$ StaticAnalyzer (StaticAnalyzer)：是否启用静态代码分析。

$ StaticAnalyzerOutputType (StaticAnalyzerOutputType)：静态分析器使用的输出类型。 仅支持Clang。

$ StaticAnalyzerMode (StaticAnalyzerMode)：静态分析器所使用的模式。 仅支持Clang。 浅层模式速度更快，但通常不建议使用。

$ StaticAnalyzerPVSPrintLevel (Int32)：使用PVS-Studio分析时所打印的警告级别

$ bStaticAnalyzerProjectOnly (Boolean)：仅针对项目模块运行静态分析，跳过引擎模块

$ bStaticAnalyzerIncludeGenerated (Boolean)：启用后，将分析被生成的源文件

$ MinFilesUsingPrecompiledHeader (Int32)：必须使用预编译头文件的最小文件数，超过此数量之后才会创建和使用预编译头。

$ bForcePrecompiledHeaderForGameModules (Boolean)：启用后，即使模块中只有几个源文件，也会始终为游戏模块生成预编译头文件。 这样可以大幅缩短项目中一些文件迭代更改的编译时间，但代价是小型游戏项目的完全重新编译会更慢。 这可以通过在模块的Build.cs文件中设置MinFilesUsingPrecompiledHeaderOverride来重载。

$ bUseIncrementalLinking (Boolean)：是否使用增量链接。 进行小更改时，增量链接可以加快迭代。 当前默认禁用，因为它在某些计算机上容易出现一些错误（与PDB相关的编译错误）。

$ bAllowLTCG (Boolean)：是否允许使用链接时间代码生成（LTCG）。

$ bPreferThinLTO (Boolean)：启用链接时间代码生成（LTCG）时，是否在支持的平台上优先使用更轻量级的版本。

$ ThinLTOCacheDirectory (String)：在支持的平台上放置ThinLTO缓存的目录。

$ ThinLTOCachePruningArguments (String)：在支持的平台上清理ThinLTO缓存时所应用的参数。 只有设置了ThinLTOCacheDirectory，才会应用参数。

$ bPGOProfile (Boolean)：是否在此构建中启用"按配置优化"（PGO）工具。

$ bPGOOptimize (Boolean)：是否使用"按配置优化"（PGO）工具优化此构建。

$ bCodeCoverage (Boolean)：目标是否需要代码覆盖编译和链接。

$ bSupportEditAndContinue (Boolean)：是否支持编辑并继续。

$ bOmitFramePointers (Boolean)：是否省略帧指针。 举例说明，适合禁用的情况包括 PC上的内存分析等。

$ bCompressDebugFile (Boolean)：如果需要压缩调试文件

$ bEnableCppModules (Boolean)：是否启用对C++20模块的支持

$ bEnableCppCoroutinesForEvaluation (Boolean)：是否启用对C++20协程的支持。提供此选项是为了便于求值。 选项名称可能会变更。 在UE中使用协程未经测试且不受支持。

$ bEnableProcessPriorityControl (Boolean)：是否启用引擎在运行时设置进程优先级的功能。 此选项需要在Linux上进行一些环境设置，因此默认禁用。 项目必须选择使用此功能，因为它必须保证设置正确。

$ bUseMallocProfiler (Boolean)：若为Ture，则在构建中启用内存分析（定义USE_MALLOC_PROFILER=1并强制bOmitFramePointers=false）。

$ bShaderCompilerWorkerTrace (Boolean)：若为true，则为着色器编译器工作程序的构建启用Unreal Insights（utrace）分析（定义USE_SHADER_COMPILER_WORKER_TRACE=1）。

$ bUseSharedPCHs (Boolean)：启用"共享PCH"，该功能通过在UBT检测到包含某些PCH头文件的模块之间共享这些PCH文件，可以显著加快编译。

$ bUseShippingPhysXLibraries (Boolean)：如果开发构建和发布构建应使用PhysX/APEX的发布配置，则为True。

$ bUseCheckedPhysXLibraries (Boolean)：如果开发构建和发布构建应使用PhysX/APEX的已检查配置，则为True。 如果bUseShippingPhysXLibraries为True，则忽略此选项。

$ bCheckLicenseViolations (Boolean)：命令UBT检查当前正在编译的模块是否违反EULA。

$ bBreakBuildOnLicenseViolation (Boolean)：如果当前正在编译的模块违反EULA，则命令UBT中断构建。

$ bUseFastPDBLinking (Nullable<Boolean>)：使用/DEBUG构建时是否使用:FASTLINK选项，从而在Windows设备上创建本地PDB。 速度很快，但目前在调试器中查找符号时似乎存在问题。

$ bCreateMapFile (Boolean)：将地图文件作为构建的一部分输出。

$ bAllowRuntimeSymbolFiles (Boolean)：针对某些平台，如果运行时符号文件应作为编译后步骤生成，则为True。 引擎使用这类文件解析日志中调用堆栈回溯的符号名称。

$ PackagePath (String)：链接时用于保存输入文件的文件包完整路径（目录+文件名）。通常用来在支持的平台上调试连接器崩溃问题

$ CrashDiagnosticDirectory (String)：在支持的平台上保存崩溃报告文件的目录。

$ BundleVersion (String)：Mac应用的数据包版本。

$ bDeployAfterCompile (Boolean)：在需要部署的平台上编译后，是否部署可执行文件。

$ bAllowRemotelyCompiledPCHs (Boolean)：启用后，允许XGE在远程计算机上编译预编译头文件。 否则，PCH将始终在本地生成。

$ bUseHeaderUnitsForPch (Boolean)：将pch替换为ifc，并改用头文件单元。 这是一项试验性的功能，且仅限msvc

$ bCheckSystemHeadersForModification (Boolean)：在确定过时操作时，是否应检查系统路径中的头文件是否有修改。

$ bDisableLinking (Boolean)：是否禁用此目标的链接。

$ bIgnoreBuildOutputs (Boolean)：是否忽略跟踪此目标的构建输出。

$ bDisableEngineDeprecations (Boolean)：是否在非引擎某块中禁用UE_DEPRECATED_FORENGINE的废弃警告。 仅限短期内使用，因为这样的废弃内容日后将被删除。

$ bFormalBuild (Boolean)：表明这是被计划分发的正式构建。 若Build.version拥有变更列表集，并且是提升后的构建，那么此标记会被自动设置为True。 当前绑定到此标记的唯一行为是为每个二进制文件单独编译默认资源文件，从而正确设置OriginalFilename字段。 默认情况下，为减少编译时间，仅编译资源一次。

$ bFlushBuildDirOnRemoteMac (Boolean)：是否在构建之前清理远程Mac上的Builds目录。

$ bPrintToolChainTimingInfo (Boolean)：是否从编译器和连接器写入详细的计时信息。

$ bParseTimingInfoForTracing (Boolean)：是否将计时数据解析成与chrome://tracing兼容的跟踪文件。

$ bPublicSymbolsByDefault (Boolean)：是否在POSIX平台上默认公开所有符号。

$ bDisableInliningGenCpps (Boolean)：禁用对内联gen.cpps的支持

$ ToolChainName (String)：允许重载要为此目标创建的工具链。 这必须匹配UnrealBuildTool程序集中声明的类名称。

$ MSVCCompileActionWeight (Single)：MSVC编译操作的权重（CPU/内存利用率）。

$ ClangCompileActionWeight (Single)：clang编译操作的权重（CPU/内存利用率）。

$ bDisableUnverifiedCertificates (Boolean)：是否允许由引擎配置来决定能否加载未验证的证书。

$ bAllowGeneratedIniWhenCooked (Boolean)：是否在烘焙后的构建中加载生成的ini文件（不论如何都会加载GameUserSettings.ini）

$ bAllowNonUFSIniWhenCooked (Boolean)：是否在烘焙后的构建中加载非ufs的ini文件（不论如何都会加载GameUserSettings.ini）

$ bLegacyPublicIncludePaths (Boolean)：将所有公共文件夹添加为编译环境的包含路径。

$ bLegacyParentIncludePaths (Boolean)：将所有父文件夹添加为编译环境的包含路径。

$ CppStandardEngine (CppStandardVersion)：编译此目标时所用的C++标准（针对引擎模块）

$ CppStandard (CppStandardVersion)：编译此目标时所用的C++标准（针对非引擎模块）

$ CStandard (CStandardVersion)：编译该目标时所用的C标准

$ MinCpuArchX64 (MinimumCpuArchitectureX64)：在支持的x64平台上，命令编译器在使用SSE或AVX固有属性的所有地方生成AVX指令。 对arm64忽略。 请注意，启用此项后，会更改目标平台的minspec，由此得到的可执行文件在不支持AVX的计算机上会崩溃。

$ BuildVersion (String)：构建版本字符串

$ LinkType (TargetLinkType)：指定如何链接此目标中的模块（单块或模块化）。 这在目前受到保护以实现向后兼容性。 调用GetLinkType()访问器，直到删除对已废弃ShouldCompileMonolithic()重载项的支持。

$ bStripExports (Boolean)：试验性：从库中剥离未使用的导出项。 仅在LinkType为模块化（Modular）时应用

$ bMergeModules (Boolean)：试验性：将模块化模组合并为联合库。 请将LinkType设为模块化（Modular）并启用bStripExports

$ LaunchModuleName (String)：指定启动模块的名称。 对于模块化构建，这就是编译到目标可执行文件中的模块。

$ ExportPublicHeader (String)：指定要写入头文件的路径，该头文件包含此目标的公共定义。 适合在编译要由外部编译进程使用的DLL时使用。

$ BuildEnvironment (TargetBuildEnvironment)：指定此目标的编译环境。 参阅TargetBuildEnvironment，了解有关可用选项的更多信息。

$ bAllowSDKOverrideModulesWithSharedEnvironment (Boolean)：若为True，则在SDK被重载时，共享编译环境目标会允许任何对SDK版本敏感的模块拥有一个项目侧模块。 举例说明，如果此属性被设为True，这时IOSTargetPlatform被标记为与IOS SDK版本相关并针对一个目标被编译，而该目标重载了IOS SDK，那么这将被编译为例如 MyProject/Binaries/Win64/IOS/MyProject-IOSTargetPlatform.dll的项目

$ bOverrideBuildEnvironment (Boolean)：是否忽略对共享编译环境的违反（例如， 编辑器目标修改定义）

$ AdditionalCompilerArguments (String)：传递至编译器的额外参数

$ AdditionalLinkerArguments (String)：传递至连接器的额外参数

$ MemoryPerActionGB (Double)：每个编译操作可能需要的最大内存量。 由ParallelExecutor使用，以决定同时启动的最大并行操作数。

$ GeneratedProjectName (String)：生成项目文件时，若存在多个类型相同的目标，则指定要使用的项目文件的名称。
