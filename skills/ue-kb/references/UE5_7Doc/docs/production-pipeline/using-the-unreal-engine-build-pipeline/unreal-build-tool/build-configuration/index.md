---
title: "编译配置"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/build-configuration-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "用虚幻构建管线", "虚幻编译工具", "编译配置"]
---

# 编译配置

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 用虚幻构建管线 / 虚幻编译工具 / 编译配置

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/build-configuration-for-unreal-engine

除了被添加到`Config/UnrealBuildTool`文件夹下所生成的**虚幻引擎（UE）**项目中之外，在Windows上，**Unreal Build Tool（UBT）**还会从以下位置的XML配置文件中读取设置:

- `Engine/Saved/UnrealBuildTool/BuildConfiguration.xml`
- `<USER>/AppData/Roaming/Unreal Engine/UnrealBuildTool/BuildConfiguration.xml`
- `我的文档/Unreal Engine/UnrealBuildTool/BuildConfiguration.xml`
- `<PROJECT_DIRECTORY>/Saved/UnrealBuildTool/BuildConfiguration.xml`

在Mac上，则使用以下路径:

- `/Users/<USER>/.config/Unreal Engine/UnrealBuildTool/BuildConfiguration.xml`
- `<PROJECT_DIRECTORY>/Saved/UnrealBuildTool/BuildConfiguration.xml`

在Linux上，则使用以下路径:

- `/home/<USER>/.config/Unreal Engine/UnrealBuildTool/BuildConfiguration.xml`
- `/home/<USER>/Documents/Unreal Engine/UnrealBuildTool/BuildConfiguration.xml`
- `<PROJECT_DIRECTORY>/Saved/UnrealBuildTool/BuildConfiguration.xml`

针对特定于项目的编译配置，请使用`<PROJECT_DIRECTORY>/Saved/UnrealBuildTool/BuildConfiguration.xml`目录，其中`<PROJECT_DIRECTORY>`即前往项目目录的路径。

继续阅读，详细了解以下有助于设置和自定义编译配置的属性。

### BuildConfiguration

$ bIgnoreOutdatedImportLibraries：编译目标时是否忽略过期的导入库文件。 将此设置为true即可缩短迭代时间。 默认情况下，如果仅依赖项.lib发生了更改，我们不必费心重新连接目标，这是因为，除非此目标的依赖项头文件也更改了，否则导入库可能实际上并没有什么不同，在这种情况下，目标会自动重新编译。

$ bPrintDebugInfo：是否应将调试信息写入控制台。

$ bAllowHybridExecutor：是否使用混合执行器（远程执行器和本地执行器）。 不再支持。

$ RemoteExecutorPriority：远程执行器（XGE、SNDBS、FASTBuild、UBA）的优先级顺序。

$ bAllowUBAExecutor：是否使用性UnrealBuildAccelerator执行器。

$ bAllowUBALocalExecutor：是否使用性UnrealBuildAccelerator（仅限本地）执行器。

$ bAllowXGE：是否在可用时使用XGE，默认为true。

$ bAllowFASTBuild：是否在可用时使用FASTBuild，默认为true。

$ bAllowSNDBS：是否在可用时使用SN-DBS，默认为true。

$ bUseUBTMakefiles：通过缓存目标数据来支持非常快速的迭代编译。 启用此选项会导致虚幻编译工具在首次编译目标时为目标发出 'UBT Makefile' 。 随后的编译将加载这些Makefile，并非常快速地开始检查过时和编译调用。 需要注意的是，如果在项目中添加或删除了源文件，UBT将需要采集有关这些文件的信息，以便你的编译成功完成。 目前，你必须在添加/删除了源文件后运行项目文件生成器，以便告知UBT重新采集此信息。

可能导致"UBT Makefile"无效的事件：

添加/删除.cpp文件

使用UObjects添加/删除.h文件

将新的UObject类型添加到此前缺少该类型的文件

更改全局编译设置（此文件中的大多数设置都符合条件）

更改了影响虚幻头文件工具运行方式的代码

你可以通过传递"-gather"参数来强制重新生成"UBT Makefile"，或者直接重新生成项目文件。

这也实现了快速包含文件依赖性扫描和缓存系统，让虚幻编译工具可以非常快速地检测过时的依赖性。 启用后，不必生成深度C++包含图表，相反，我们仅在发现依赖项编译产品已过期后才扫描和缓存间接包含项。 在下一次编译期间，我们将加载那些缓存的间接包含项并检查是否过时。

$ MaxParallelActions：可以并行执行的操作数。 如果为0，则代码将根据可用的核心数和内存选择默认值。 适用于ParallelExecutor、HybridExecutor和LocalExecutor

$ bAllCores：在判断有多少可用CPU核心的时候算上逻辑核心。

$ bCompactOutput：如果执行器支持，则指示执行器写入简洁输出（比如 仅输出错误信息）。 该字段用于在从指令行或者XML指示时暂存数值

$ bArtifactRead：若设置，则读取构件

$ bArtifactWrites：若设置，则写入构件

$ bLogArtifactCacheMisses：若为true，则将所有构件缓存未命中记录为资讯信息

$ ArtifactDirectory：构件的存放位置。

$ bUseUnityBuild：是否将C++代码统一到更大的文件中，从而加快编译。

$ bForceUnityBuild：是否强制将C++源文件合并为更大的文件，从而加快编译速度。

$ DefaultWarningLevel：未分类警告的默认处理方式

$ DeprecationWarningLevel：将废弃警告报告为错误的级别。

$ bShowIncludes：打印出每个源文件包含的文件

$ bDebugBuildsActuallyUseDebugCRT：为调试构建启用调试C++运行时（CRT）。 默认情况下，我们始终使用发布运行时，因为调试版本在调试虚幻引擎项目时并不是特别有用，并且连接到调试CRT库会强制我们的第三方库依赖性也使用调试CRT进行编译（并且通常执行速度会更慢）。 通常，仅仅为了调试程序代码而要求第三方静态库调试版本的单独副本，可能很不方便。

$ bLegalToDistributeBinary：此目标的输出是否可以公开发布，即使它依赖某些模块，而这些模块存在于带有特殊限制的文件夹中（例如 CarefullyRedist、NotForLicensees、NoRedist）。

$ bForceNoAutoRTFMCompiler：是否使用强制关闭AutoRTFM Clang编译器。

$ bUseAutoRTFMVerifier：是否启用发送AutoRTFM验证元数据

$ bUseInlining：为所有模块启用内联。

$ bUseDebugLiveCodingConsole：是否启用对实时编码的支持

$ bUseXGEController：引擎构建中是否应包含XGE控制器的工作程序和模块。 这些是使用XGE拦截接口进行分布式着色器编译所必需的。

$ bUseAdaptiveUnityBuild：使用启发法确定当前正在迭代哪些文件，并将它们从Unity Blob中排除，从而加快增量编译。 当前实现使用只读标记区分工作集，假定文件在被修改时将被源代码控制系统设为可写。 这对Perforce有效，但对Git则不然。

$ bAdaptiveUnityDisablesOptimizations：禁止优化位于自适应非Unity工作集中的文件。

$ bAdaptiveUnityDisablesPCH：禁用对位于自适应非Unity工作集中的文件强制包含PCH。

$ bAdaptiveUnityDisablesProjectPCHForProjectPrivate：bAdaptiveUnityDisablesProjectPCH的备份存储。

$ bAdaptiveUnityCreatesDedicatedPCH：为工作集中的每个源文件创建专用PCH，从而对仅限cpp的更改实现更快的迭代。

$ bAdaptiveUnityEnablesEditAndContinue：为工作集中的每个源文件创建专用PCH，从而对仅限cpp的更改实现更快的迭代。

$ bAdaptiveUnityCompilesHeaderFiles：为工作集中的每个头文件创建专用源文件，以便检测头文件中缺少的包含项。

$ MinGameModuleSourceFilesForUnityBuild：为某模块激活Unity构建之前，该游戏模块中的源文件数量。 这允许小型游戏模块加快对单个文件的迭代编译，但代价是完全重新编译会更慢。 此设置可以由模块的Build.cs文件中的bFasterWithoutUnity选项重载。

$ bRequireObjectPtrForAddReferencedObjects：需要FReferenceCollector API的TObjectPtr。 （兼容增量GC所需。）

$ bValidateFormatStrings：针对不正确的UE_LOG格式字符串发出编译错误。

$ bWarningsAsErrors：是否将全部警告作为错误启用。 UE已经将大多数警告作为错误启用，但禁用了一些警告（例如废弃警告）。

$ UnsafeTypeCastWarningLevel：指示在支持的平台上，将不安全类型转换视成什么警告/错误级别（例如，double->float或int64->int32）。

$ bUndefinedIdentifierErrors：强制将条件表达式中对未定义标识符的使用视为错误。

$ UndefinedIdentifierWarningLevel：指示将条件表达式中使用的未定义标识符视为何种警告/错误级别。

$ PCHPerformanceIssueWarningLevel：指示将潜在PCH性能问题视为何种警告/错误级别。

$ ModuleIncludePathWarningLevel：如何处理一般模块包含路径验证消息

$ ModuleIncludePrivateWarningLevel：如何处理私有模块包含路径验证消息，其中模块会添加暴露私有头文件的包含路径

$ ModuleIncludeSubdirectoryWarningLevel：如何处理不必要的模块子目录包含路径验证消息

$ bRetainFramePointers：强制保留帧指针。通常在你需要可靠的调用堆栈时需要这么做（例如 mallocframeprofiler）

$ bUseFastMonoCalls：新的单块图形驱动程序具有可选的"快速调用"，替换各种D3d函数

$ NumIncludedBytesPerUnityCPP：要包含在单个统一C++文件中的目标C++代码的大致字节数。

$ bDisableModuleNumIncludedBytesPerUnityCPPOverride：禁用由模块设置的重载项

$ bStressTestUnity：是否将所有C++文件包含在来自单个统一文件的项目中，以此对C++ Unity构建的健壮性进行压力测试。

$ bDetailedUnityFiles：是否为Unity文件添加额外信息，如文件名中的'_of_X'。 不推荐使用。

$ bDisableDebugInfo：是否全局禁用调试信息生成；已废弃，请改用TargetRules.DebugInfoMode

$ DebugInfo：应该生成多少调试信息。 详情请参阅DebugInfoMode枚举

$ DebugInfoLineTablesOnly：如果对于支持此操作的编译器，调试信息中只应该发出调试行号表，则为true。 这将重载TargetRules.DebugInfo。请参阅https://clang.llvm.org/docs/UsersManual.html#cmdoption-gline-tables-only了解详情

$ bDisableDebugInfoForGeneratedCode：是否针对已生成文件禁用调试信息生成。 对于具有大量已生成粘合代码的模块，此操作可加快连接并缩小pdb。

$ bOmitPCDebugInfoInDevelopment：是否对PC/Mac上的开发构建禁用调试信息（以便加快开发者迭代，因为在禁用调试信息后，连接时间会非常快）。

$ bUsePDBFiles：是否应该将PDB文件用于Visual C++构建。

$ bUsePCHFiles：是否应该使用PCH文件。

$ bDeterministic：设置确定性编译和链接所需的标记。 为msvc启用确定性模式会禁用代码生成的多线程化，因此编译会变慢

$ bChainPCHs：使用Clang编译时，是否应该链接PCH。

$ bForceIncludePCHHeadersForGenCppFilesWhenPCHIsDisabled：禁用PCH时，是否应强制将PCH头文件包含在gen.cpp文件中。

$ bPreprocessDepends：通过预处理生成依赖文件。 建议仅在发布构建时使用，因为这会增加性能开销。

$ StaticAnalyzer：是否启用静态代码分析。

$ StaticAnalyzerOutputType：静态分析器使用的输出类型。 仅支持Clang。

$ StaticAnalyzerMode：静态分析器所使用的模式。 仅支持Clang。 浅层模式速度更快，但通常不建议使用。

$ StaticAnalyzerPVSPrintLevel：使用PVS-Studio分析时所打印的警告级别

$ bStaticAnalyzerProjectOnly：仅针对项目模块运行静态分析，跳过引擎模块

$ bStaticAnalyzerIncludeGenerated：启用后，将分析被生成的源文件

$ MinFilesUsingPrecompiledHeader：必须使用预编译头文件的最小文件数，超过此数量之后才会创建和使用预编译头。

$ bForcePrecompiledHeaderForGameModules：启用后，即使模块中只有几个源文件，也会始终为游戏模块生成预编译头文件。 这样可以大幅缩短项目中一些文件迭代更改的编译时间，但代价是小型游戏项目的完全重新编译会更慢。 这可以通过在模块的Build.cs文件中设置MinFilesUsingPrecompiledHeaderOverride来重载。

$ bUseIncrementalLinking：是否使用增量链接。 进行小更改时，增量链接可以加快迭代。 当前默认禁用，因为它在某些计算机上容易出现一些错误（与PDB相关的编译错误）。

$ bAllowLTCG：是否允许使用链接时间代码生成（LTCG）。

$ bPreferThinLTO：启用链接时间代码生成（LTCG）时，是否在支持的平台上优先使用更轻量级的版本。

$ ThinLTOCacheDirectory：在支持的平台上放置ThinLTO缓存的目录。

$ ThinLTOCachePruningArguments：在支持的平台上清理ThinLTO缓存时所应用的参数。 只有设置了ThinLTOCacheDirectory，才会应用参数。

$ bPGOProfile：是否在此构建中启用"按配置优化"（PGO）工具。

$ bPGOOptimize：是否使用"按配置优化"（PGO）优化此构建。

$ bCodeCoverage：目标是否需要代码覆盖编译和链接。

$ bSupportEditAndContinue：是否支持编辑并继续。

$ bOmitFramePointers：是否省略帧指针。 举例说明，适合禁用的情况包括 PC上的内存分析等。

$ bShaderCompilerWorkerTrace：如为true，则在着色器编译器工作程序的构建中启用Unreal Insights（utrace）分析（定义USE_SHADER_COMPILER_WORKER_TRACE=1）。

$ bUseSharedPCHs：启用"共享PCH"，该功能通过在UBT检测到包含某些PCH头文件的模块之间共享这些PCH文件，可以显著加快编译。

$ bUseShippingPhysXLibraries：如果开发构建和发布构建应使用PhysX/APEX的发布配置，则为True。

$ bUseCheckedPhysXLibraries：如果开发构建和发布构建应使用已检查的PhysX/APEX配置，则为True。 如果bUseShippingPhysXLibraries为true，则忽略此选项。

$ bCheckLicenseViolations：命令UBT检查当前正在编译的模块是否违反EULA。

$ bBreakBuildOnLicenseViolation：如果当前正在编译的模块违反EULA，则命令UBT中断编译。

$ bUseFastPDBLinking：使用/DEBUG编译时是否使用：FASTLINK选项，从而在Windows设备上创建本地PDB。 速度很快，但目前在调试器中查找符号时似乎存在问题。

$ bCreateMapFile：将地图文件作为构建的一部分输出。

$ bAllowRuntimeSymbolFiles：针对某些平台，如果运行时符号文件应作为编译后步骤生成，则为True。 引擎使用这类文件解析日志中调用堆栈回溯的符号名称。

$ PackagePath：链接时用于保存输入文件的文件包完整路径（目录+文件名）。通常用来在支持的平台上调试连接器崩溃

$ CrashDiagnosticDirectory：在支持的平台上保存崩溃报告文件的目录

$ bCheckSystemHeadersForModification：在确定过时操作时，是否检查系统路径中的头文件是否有修改。

$ bFlushBuildDirOnRemoteMac：是否在编译之前清理远程Mac上的Builds目录。

$ bPrintToolChainTimingInfo：是否从编译器和连接器写入详细的计时信息。

$ bParseTimingInfoForTracing：是否将计时数据解析成与chrome://tracing兼容的跟踪文件。

$ bPublicSymbolsByDefault：是否在POSIX平台上默认公开所有符号

$ MSVCCompileActionWeight：MSVC编译操作的权重（CPU/内存利用率）

$ ClangCompileActionWeight：Clang编译操作的权重（CPU/内存利用率）

$ CppStandardEngine：编译此目标时所用的C++标准（针对引擎模块）

$ CppStandard：编译此目标时所用的C++标准（针对非引擎模块）

$ CStandard：编译该目标时所用的C标准

$ MinCpuArchX64：在支持的x64平台上，命令编译器在使用SSE或AVX固有属性的所有地方生成AVX指令。 对arm64忽略。 请注意，启用此项后，会更改目标平台的minspec，由此得到的可执行文件在不支持AVX的计算机上会崩溃。

$ ActionStallReportTime：未完成操作的时间达到多少秒之后触发操作停滞报告。 如果为零，不会启用停滞报告。

$ ActionStallTerminateTime：未完成操作的时间达到多少秒之后会触发队列终止。 如果为零，不会启用强制终止。

$ bStopSNDBSCompilationAfterErrors：启用后，在发生编译错误时，SN-DBS将停止编译目标。 推荐启用，因为可为其他内容节省计算资源。

$ bXGENoWatchdogThread：是否使用no_watchdog_thread选项以防止VS2015工具链停滞。

$ bShowXGEMonitor：是否显示XGE编译监视器。

$ bStopXGECompilationAfterErrors：启用后，在发生编译错误时，XGE将停止编译目标。 推荐启用，因为可为其他内容节省计算资源。

$ BaseLogFileName：指定用于日志记录的文件。

$ IWYUBaseLogFileName：指定用于日志记录的文件。

$ bStripSymbols：是否剥离iOS符号（由发布配置表示）。

$ bUseDSYMFiles：启用.dsym文件的生成。 禁用后可以在开发期间实现更快的迭代。

$ bSkipClangValidation：禁用对静态库的Clang构建验证检查

$ bEnableAddressSanitizer：启用地址清理程序（ASan）。 仅支持Visual Studio 2019 16.7.0及更高版本。

$ bEnableLibFuzzer：启用LibFuzzer。 仅支持Visual Studio 2022 17.0.0及更高版本。

$ bEnableThreadSanitizer：启用线程清理程序（TSan）。

$ bEnableUndefinedBehaviorSanitizer：启用未定义行为的清理程序（UBSan）。

$ bEnableMemorySanitizer：启用内存清理程序（MSan）。

$ bTuneDebugInfoForLLDB：打开LLDB的调试信息调整

$ bDisableDumpSyms：是否全局禁用调用dump_syms

$ bWriteSolutionOptionFile：是否写入sln的解决方案选项（suo）文件。

$ bVsConfigFile：是否在sln旁边写入一个.vsconfig文件来表示要安装的组件。

$ bAddFastPDBToProjects：是否默认添加-FastPDB选项来编译命令行。

$ bUsePerFileIntellisense：是否生成逐个文件的智能感知数据。

$ bEditorDependsOnShaderCompileWorker：为编辑器生成项目文件时，是否包含对ShaderCompileWorker的依赖性。

$ TempDirectory：如果设定，TMP\TEMP将被重载为此目录，每个进程都会在此文件夹中创建唯一的子目录。

$ bDeleteTempDirectory：如果设定，仅当使用单个实例互斥锁运行时，应用程序temp目录才会在退出时被删除。

### UEBuildConfiguration

$ bForceHeaderGeneration：如果为true，则强制重新生成头文件。 专用于编译机器。

$ bDoNotBuildUHT：如果为True，则不编译UHT，并假设它已经编译。

$ bFailIfGeneratedCodeChanges：如果为True，则在生成的头文件过期时失败。

$ bAllowHotReloadFromIDE：如果允许从IDE热重载，则为True。

$ bForceDebugUnrealHeaderTool：如果为True，则将编译并运行UnrealHeaderTool的调试版本，而不是开发版本。

$ bUseBuiltInUnrealHeaderTool：如为True，则使用UBT内部的C# UHT

$ bWarnOnCppUnrealHeaderTool：如为True，则在使用C++ UHT时生成警告

### WindowsPlatform

$ MaxRootPathLength：建议的最大根路径长度。

$ MaxNestedPathLength：相对于根目录的最大路径长度。 在Windows设备上用于确保路径在机器之间可移植。

$ bIgnoreStalePGOData：如果指定了-PGOOptimize，但连接器标记自上次-PGOProfile以来已更改，则发出警告，并在不使用PGO的情况下编译，而不是在使用LNK1268链接期间失败。

$ bUseFastGenProfile：如果随-PGOProfile指定，则使用/FASTGENPROFILE，而不是/GENPROFILE。 这通常意味着，PGO数据会更快生成，但生成的数据可能不会产生-PGOOptimize期间那样高效的优化

$ PreMergedPgdFilename：如果随-PGOOptimize指定，则使用指定的逐个合并的PDG文件，而不是通常使用零散PGC文件的PDG文件。

$ bPGONoExtraCounters：如果随-PGOProfile指定，则防止使用额外的计数器。 请注意，默认情况下，/FASTGENPROFILE不使用额外计数器

$ bSampleBasedPGO：如果随-PGOProfile指定，则使用基于取样的（而不是仪表化的）PGO。 目前仅限Intel oneAPI 2024.0+。

$ Compiler：在Windows平台上使用的编译器工具链版本。 在UBT启动时，"默认"值将改为特定的版本。

$ CompilerVersion：要使用的特定编译器版本。 这可以是具体的版本号（例如，"14.13.26128"），而使用字符串"Latest"会选择最新的可用版本，使用字符串"Preview"会选择最新的可用预览版本。 默认情况下，如果可用，我们使用WindowsPlatform.DefaultToolChainVersion指示的工具链版本（否则使用最新版本）。

$ ToolchainVersion：编译器不是msvc时要使用的具体msvc工具链版本。 这可以是具体的版本号（例如，"14.13.26128"），而使用字符串"Latest"会选择最新的可用版本，使用字符串"Preview"会选择最新的可用预览版本。 默认情况下，如果可用，我们使用WindowsPlatform.DefaultToolChainVersion指示的工具链版本（否则使用最新版本）。

$ bVCFastFail：如果应该将/fastfail传递到msvc编译器和连接器，则为True

$ bVCExtendedWarningInfo：如果/d2ExtendedWarningInfo应被传递到编译器，而且/d2:-ExtendedWarningInfo应被传递到连接器，则为True

$ bClangStandaloneDebug：如果应该禁用减小调试信息大小的优化项，则为True。请参阅https://clang.llvm.org/docs/UsersManual.html#cmdoption-fstandalone-debug了解详情

$ bAllowClangLinker：如果我们在使用Clang或Intel oneAPI编译时应使用Clang连接器（LLD），则为True，否则使用MSVC连接器。

$ WindowsSdkVersion：要使用的Windows SDK具体版本。 这可能是具体的版本号（例如，"8.1"、"10.0"或"10.0.10150.0"），也可以使用字符串"Latest"选择最新的可用版本。 默认情况下，如果可用，我们使用由WindowsPlatform.DefaultWindowsSdkVersion指示的Windows SDK版本（否则，我们使用最新版本）。

$ bWriteSarif：包含错误和警告的.sarif文件在支持的情况下是否随每个.obj一起写入

$ bUpdatedCPPMacro：启用更新后的__cplusplus macro (/Zc:__cplusplus）。

$ bStrictInlineConformance：启用内联一致性（移除未引用的COMDAT）（/Zc:inline）。

$ bStrictPreprocessorConformance：启用新的预处理器一致性（/Zc:preprocessor）。 C++20模块始终启用此项。

$ bStrictEnumTypesConformance：在VS2022 17.4 Preview 4.0+中启用枚举类型一致性（/Zc:enumTypes）。

$ bStrictODRViolationConformance：在VS2022 17.5 Preview 2.0+中启用强制标准C++ ODR违规（/Zc:checkGwOdr）

$ bStripPrivateSymbols：是否请求连接器创建剥离的pdb文件以作为构建的一部分。 如果启用，完整调试pdb将使用扩展名.full.pdb

$ bNoLinkerDebugInfo：如果你提供-NoDebugInfo，Windows平台会在链接时依然创建调试信息。 将此设置为True，以在这种情况下链接时不创建调试信息

$ PCHMemoryAllocationFactor：决定编译器分配给构造预编译头文件的内存大小（/Zm）。

$ AdditionalLinkerOptions：允许目标针对此处未另外注明的链接指定额外选项

$ bReducedOptimizeHugeFunctions：是否应在指令阈值范围内缩减针对超大函数的优化操作，以缩短编译时间。详见https://devblogs.microsoft.com/cppblog/msvc-backend-updates-in-visual-studio-2019-versions-16-3-and-16-4/

$ ReducedOptimizeHugeFunctionsThreshold：对超大函数进行优化时设定的最小指令阈值，默认值为20000。

$ bClangTimeTrace：（试验性）将-ftime-trace参数附加到命令行，以便Clang输出包含编译时间轴的JSON文件。 如需了解更多信息，请参阅http://aras-p.info/blog/2019/01/16/time-trace-timeline-flame-chart-profiler-for-Clang/。

$ bCompilerTrace：输出编译计时信息，使其能被分析。

$ bSetResourceVersions：如果启用，会将Windows可执行文件和dll中嵌入的ProductVersion设置为包含BUILT_FROM_CHANGELIST，并默认为所有预编译和发布配置启用BuildVersion。 无论此设置如何，Build.version中的版本都将通过BuildSettings模块获取。注意：嵌入这些版本将导致每次更新变更列表时重新编译资源文件，这将导致二进制文件重新链接

$ InlineFunctionExpansionLevel：在启用TargetRules.bUseInlining时要使用哪个级别进行内联函数扩展

$ ToolChain：使用非msvc编译器时或查找包含路径等情况下，要在Windows平台上使用的工具链版本。

$ ToolchainVersionWarningLevel：报告不在偏好版本列表中的工具链时的警告级别

$ bStrictConformanceMode：启用严格标准一致性模式（/permissive-）。

$ bDisableVolatileMetadata：默认启用易变元数据，提升arm64上的x64模拟性能，但可能会造成一定的性能开销（/volatileMetadata-）。

### TargetRules

$ bCompileChaosVisualDebuggerSupport：是否在Chaos视觉调试器（CVD）支持功能中编译，以记录物理模拟的状态

### ModuleConfiguration

$ DisableMergingModuleAndGeneratedFilesInUnityFiles：禁用在同一Unity文件中合并模块和被生成的cpp文件的模块列表。

$ DisableUnityBuild：需要禁用Unity构建的模块的列表

$ EnableOptimizeCode：需要启用优化的模块列表

$ DisableOptimizeCode：需要禁用优化的模块列表

$ OptimizeForSize：需要优化大小的模块列表。 这将允许目标重载模块优化级别。请注意，如果未提供私有PCH，这可能会禁用PCH

$ OptimizeForSizeAndSpeed：需要优化大小和速度的模块列表。 这将允许目标重载模块优化级别。请注意，如果未提供私有PCH，这可能会禁用PCH

### UnrealBuildAccelerator

$ bStoreObjFilesCompressed：将压缩的对象（.obj）存储在磁盘上。 要求UBA在将要再次解压.obj文件的地方执行链接步骤

$ bDisableRemote：设为True时，UBA不会使用远程帮助

$ bForceBuildAllRemote：设为True时，UBA将强制所有可以远程编译的操作都远程编译。 如果没有远程代理可用，则挂起

$ bForcedRetry：设为True时，本地使用UBA执行失败的操作将在不使用UBA的情况下重试。

$ bForcedRetryRemote：设为True时，远程使用UBA执行失败的操作将在本地使用UBA的情况下重试。

$ bStrict：设为True时，来自UBA的所有错误和警告将以合适的严重性级别输出到日志（而不是被输出为"information"并仍然尝试继续）。

$ bStoreRaw：UBA应该将cas存储为压缩文件还是原始数据

$ bLinkRemote：UBA是否应该将链接分发给远程工作程序。 这需要带宽，但也可能起到优化效果

$ StoreCapacityGb：允许UBA用于存储工作集和缓存数据的千兆字节数。 最好将此项设置为>10gb

$ MaxWorkers：可以处理远程消息的工作线程的最大数量。

$ SendSize：从服务器发送到客户端的每条消息的大小上限

$ Host：UBA服务器应该对哪个IP监听连接

$ Port：UBA服务器应该对哪个端口监听连接。

$ RootDir：UBA用于存储文件的目录。

$ bUseQuic：使用Quic协议而不是Tcp（试验性）

$ bLogEnabled：启用UBA进程的日志记录

$ bPrintSummary：在编译结束时打印UBA统计数据的摘要

$ bLaunchVisualizer：启动查看器应用程序，显示编译进度

$ bResetCas：重置cas缓存

$ TraceFile：提供追踪输出文件的自定义路径

$ bDetailedTrace：向UBA追踪添加冗长详情

$ bDisableWaitOnMem：在生成新进程之前禁止UBA等待可用内存

$ bAllowKillOnMem：让UBA在内存即将耗尽时终止运行中的进程

$ OutputStatsThresholdMs：执行器应该输出进程的日志记录时的阈值。 默认值为never

$ bWriteToDisk：跳过将中间文件和输出文件写入磁盘 适合在不需要输出时用于验证构建

$ bDisableCustomAlloc：设为True以禁用mimalloc和内存分配的绕行避让。

$ Zone：用于UBA的区域。

$ bUseCrypto：设为True以在通过网络传输文件时启用加密。

$ bUseKnownInputs：设为True以向远程运行的进程提供已知输入。 这是一项试验性功能，可在ping较高时加快编译

$ ActionsOutputFile：将排队等待编译的所有操作写入yaml文件。 这可以用于使用"UbaCli.exe local file.yaml"的重播。

$ bDetailedLog:设为True以查看UBA内部事件的详情，以及来自于代理的日志输出

$ Cache：UBA缓存服务的地址。 如果连接，则自动使用缓存

$ WriteCache：将缓存设为写入，而不是读取

$ CacheMaxWorkers：可并行执行的缓存下载任务的最大数量

$ ReportCacheMissReason：报告缓存缺失事件的发生原因。 适合在搜索确定性/可能性问题时使用

$ bDisableHorde：完全禁用horde

### TestTargetRules

$ bCompileChaosVisualDebuggerSupport：是否在Chaos视觉调试器（CVD）支持功能中编译，以记录物理模拟的状态

### FASTBuild

$ FBuildExecutablePath：如果未使用分布式二进制文件，则用于指定fbuild.exe的位置

$ bEnableDistribution：控制网络构建的分布

$ FBuildBrokeragePath：用于指定中转位置。 如果为null，FASTBuild将退回到检查FASTBUILD_BROKERAGE_PATH

$ FBuildCoordinator：用于指定FASTBuild协调器IP或网络名称。 如果为null，FASTBuild将退回到检查FASTBUILD_COORDINATOR

$ bEnableCaching：控制是否使用缓存。 CachePath和FASTCacheMode仅在此项启用时才有意义。

$ CacheMode：缓存访问模式 - 仅当bEnableCaching为True时才有意义；

$ FBuildCachePath：指定缓存位置。 如果为null，FASTBuild将退回到检查FASTBUILD_CACHE_PATH

$ bForceRemote：是否强制远程

$ bStopOnError：是否在出错时停止

$ MsvcCRTRedistVersion：使用哪个MSVC CRT Redist版本

$ CompilerVersion：使用哪个MSVC编译器版本

### ParallelExecutor

$ MaxProcessorCount：本地执行的最大处理器数量。

$ ProcessorCountMultiplier：本地执行处理器数量的乘数。 设为低于1可以将CPU资源保留给其它任务。 使用本地执行器（非XGE）时，在每个CPU核心上运行一个操作。 请注意，在很多情况下，你可以将此项设为一个较大的值，从而得到稍快的编译速度，但在编译期间，计算机的响应速度会变慢很多。 如果CPU不支持超线程，则此数值会被忽略。

$ MemoryPerActionBytes：每个操作的空闲内存，以字节计，用于在内存不足时限制并行操作的数量。 设为0可以停用空闲内存检查。

$ ProcessPriority：为生成的进程设置的优先级。 有效设置：Idle、BelowNormal、Normal、AboveNormal、High Default：非对称处理器设置为BelowNormal或Normal，因为BelowNormal可能导致调度问题。

$ bStopCompilationAfterErrors：启用后，在出现编译错误时停止编译目标。

$ bShowCompilationTimes：是否在显示最严重错误时一并显示编译时间。

$ bShowPerActionCompilationTimes：是否针对每个执行的操作显示编译时间

$ bLogActionCommandLines：是否针对被执行的操作记录命令行

$ bPrintActionTargetNames：为每个被执行的操作添加目标名称

$ bUseActionWeights：在决定是否做更多工作时是否考虑操作的权重。

$ bShowCPUUtilization：工作完成后是否显示CPU利用率。

### SNDBS

$ bAllowOverVpn：为False时，如果通过VPN连接到协调器运行，则不启用SNDBS。 通过VpnSubnets参数配置VPN指定子网。

$ VpnSubnets：包含VPN所指定的IP地址的子网列表

### Horde

$ Server：Horde服务器的URI

$ Token：Horde服务器的授权令牌

$ OidcProvider：供登录使用的OIDC ID

$ Pool：在当前平台未设置重载项时，Horde代理要分配的池

$ LinuxPool：在Linux上时Horde代理要分配的池

$ MacPool：在Mac上时Horde代理要分配的池

$ WindowsPool：在Windows上时Horde代理要分配的池

$ Requirements：Horde代理要分配的要求

$ Cluster：将在Horde内使用的计算群集ID。 设为"_auto"即可让Horde服务器解析合适的群集。 在多地区设置的场景下，这可以大幅简化UBT/UBA的配置。

$ LocalHost：UBA服务器应该向代理提供的IP。 这将发生反转，以便主机监听，让代理连接

$ MaxCores：编译会话可以使用的最大核心数

$ StartupDelay：UBT应该在等待多久后请求帮助。 非常适用于在计算机可能延迟远程工作并仍获得相同的墙钟时间结果的编译配置（pch依赖项等）

$ AllowWine：允许使用Wine。 仅适用于运行Linux的Horde代理。 如果代理上未设置Wine可执行文件，仍可以忽略。

$ ConnectionMode：有效模式所用的代理/计算通信的连接模式。

$ Encryption：代理/计算通信所用的加密方式。 请注意，UBA代理会针对有效模式使用其独属的 加密方式。

$ UBASentryUrl：盒体数据将被发送到的Sentry URL。 可选。

### XGE

$ bAllowOverVpn：为False时，如果通过VPN连接到协调器运行，则不启用XGE。 通过VpnSubnets参数配置VPN指定子网。

$ VpnSubnets：包含VPN所指定的IP地址的子网列表

$ bAllowRemoteLinking：是否允许远程连接

$ bUseVCCompilerMode：是否启用VCCompiler=true设置。 此操作需要额外的VC工具许可证。

$ MinActions：使用XGE执行的最小操作数量。

$ bUnavailableIfInUse：检查并发的XGE构建，如果其处于使用中，则将XGE执行器视为不可用。 这将会让UBT回退到另一个执行器，比如并行执行器。

### BuildMode

$ bIgnoreJunk：是否跳过检查被垃圾清单所标识的文件。

### ProjectFileGenerator

$ DisablePlatformProjectGenerators：禁用针对平台的原生项目文件生成器。 具有原生项目文件生成器的平台通常需要安装IDE扩展。

$ Format：可生成的默认项目文件格式列表。

$ bGenerateIntelliSenseData：如果应该生成智能感知数据，则为True（需要更长的时间）。

$ bIncludeDocumentation：如果应该在生成的项目中包含文档，则为True。

$ bAllDocumentationLanguages：如果生成的项目中应包含所有文档语言，则为True，否则仅包含INT文件。

$ bUsePrecompiled：如果编译目标应该传递-useprecompiled参数，则为True。

$ bIncludeEngineSource：如果生成的解决方案中应该包含引擎源，则为True。

$ bIncludeShaderSource：如果生成的项目中应包含着色器源文件，则为True。

$ bIncludeBuildSystemFiles：如果应包含构建系统文件，则为True。

$ bIncludeConfigFiles：如果生成的项目中应该包含配置（.ini）文件，则为True。

$ bIncludeLocalizationFiles：如果生成的项目中应包含本地化文件，则为True。

$ bIncludeTemplateFiles：如果生成的项目中应包含模板文件，则为True。

$ bIncludeEnginePrograms：如果生成的解决方案中应该包含程序项目，则为True。

$ IncludeCppSource：是否要包含C++目标

$ bIncludeDotNetPrograms：如果生成的解决方案中应该包含csharp程序项目，则为True。 传递"-DotNet"以将其启用。

$ bIncludeTempTargets：是否包含由UAT生成的临时目标，以便支持具有非默认设置的纯内容项目。

$ bKeepSourceSubDirectories：如果应该将主项目中磁盘上的"源"子目录显示为项目目录，则为True。 这（可以说）给主要项目增加了一些视觉效果的混乱，但这更符合磁盘文件的组织方式。

$ Platforms：生成的项目文件中要包含的平台名称

$ Configurations：生成的项目文件中要包含的配置名称。 如需了解有效条目，请参阅UnrealTargetConfiguration

$ bGatherThirdPartySource：如果为true，则解析第三方项目的子目录，从而找到在生成的项目中要包含的源文件和头文件。 这可能会使生成的项目变得很大，但直接从IDE打开文件会更轻松。

$ PrimaryProjectName：主项目文件的名称，例如，Visual Studio解决方案文件的基础文件名，或Mac上的Xcode项目文件名称。

$ bPrimaryProjectNameFromFolder：如果为True，则根据其所在文件夹的名称设置主项目名称。

$ bIncludeTestAndShippingConfigs：是否应该在生成的项目中包含"测试"和"发布"的配置。 传递"-NoShippingConfigs"以将其禁用。

$ bIncludeDebugConfigs：是否应该在生成的项目中包含"调试"和"DebugGame"的配置。 传递"-NoDebugConfigs以将其禁用。

$ bIncludeDevelopmentConfigs：是否应该在生成的项目中包含"开发"的配置。 传递"-NoDevelopmentConfigs"以将其禁用。

$ bVisualStudioLinux：如果Visual Studio项目应该在Linux模式下生成，则为True。

### IOSToolChain

$ bUseDangerouslyFastMode：如果设置了此项，那么我们不会执行任何编译后步骤（将可执行文件移动到Mac上的正确位置的步骤除外）。

### WindowsTargetRules

$ ObjSrcMapFile：是否应该将包含.obj的文件导出到源文件映射。

### CLionGenerator

$ bIncludeDocumentation：如果应该在生成的项目中包含文档，则为True。

$ bUsePrecompiled：如果编译目标应该传递-useprecompiled参数，则为True。

$ bIncludeEngineSource：如果生成的解决方案中应该包含引擎源，则为True。

$ bIncludeShaderSource：如果生成的项目中应包含着色器源文件，则为True。

$ bIncludeConfigFiles：如果生成的项目中应该包含配置（.ini）文件，则为True。

$ bIncludeTemplateFiles：如果生成的项目中应包含模板文件，则为True。

$ bIncludeEnginePrograms：如果生成的解决方案中应该包含程序项目，则为True。

$ IncludeCppSource：是否要包含C++目标

$ bIncludeDotNetPrograms：如果生成的解决方案中应该包含csharp程序项目，则为True。 传递"-DotNet"以将其启用。

$ bIncludeTempTargets：是否包含由UAT生成的临时目标，以便支持具有非默认设置的纯内容项目。

$ PrimaryProjectName：主项目文件的名称，例如，Visual Studio解决方案文件的基础文件名，或Mac上的Xcode项目文件名称。

$ bPrimaryProjectNameFromFolder：如果为True，则根据其所在文件夹的名称设置主项目名称。

### CMakefileGenerator

$ bIncludeDocumentation：如果应该在生成的项目中包含文档，则为True。

$ bUsePrecompiled：如果编译目标应该传递-useprecompiled参数，则为True。

$ bIncludeEngineSource：如果生成的解决方案中应该包含引擎源，则为True。

$ bIncludeShaderSource：如果生成的项目中应包含着色器源文件，则为True。

$ bIncludeConfigFiles：如果生成的项目中应该包含配置（.ini）文件，则为True。

$ bIncludeTemplateFiles：如果生成的项目中应包含模板文件，则为True。

$ bIncludeEnginePrograms：如果生成的解决方案中应该包含程序项目，则为True。

$ IncludeCppSource：是否要包含C++目标

$ bIncludeDotNetPrograms：如果生成的解决方案中应该包含csharp程序项目，则为True。 传递"-DotNet"以将其启用。

$ bIncludeTempTargets：是否包含由UAT生成的临时目标，以便支持具有非默认设置的纯内容项目。

$ PrimaryProjectName：主项目文件的名称，例如，Visual Studio解决方案文件的基础文件名，或Mac上的Xcode项目文件名称。

$ bPrimaryProjectNameFromFolder：如果为True，则根据其所在文件夹的名称设置主项目名称。

### CodeLiteGenerator

$ bIncludeDocumentation：如果应该在生成的项目中包含文档，则为True。

$ bUsePrecompiled：如果编译目标应该传递-useprecompiled参数，则为True。

$ bIncludeEngineSource：如果生成的解决方案中应该包含引擎源，则为True。

$ bIncludeShaderSource：如果生成的项目中应包含着色器源文件，则为True。

$ bIncludeConfigFiles：如果生成的项目中应该包含配置（.ini）文件，则为True。

$ bIncludeTemplateFiles：如果生成的项目中应包含模板文件，则为True。

$ bIncludeEnginePrograms：如果生成的解决方案中应该包含程序项目，则为True。

$ IncludeCppSource：是否要包含C++目标

$ bIncludeDotNetPrograms：如果生成的解决方案中应该包含csharp程序项目，则为True。 传递"-DotNet"以将其启用。

$ bIncludeTempTargets：是否包含由UAT生成的临时目标，以便支持具有非默认设置的纯内容项目。

$ PrimaryProjectName：主项目文件的名称，例如，Visual Studio解决方案文件的基础文件名，或Mac上的Xcode项目文件名称。

$ bPrimaryProjectNameFromFolder：如果为True，则根据其所在文件夹的名称设置主项目名称。

### #EddieProjectFileGenerator

$ bIncludeDocumentation：如果应该在生成的项目中包含文档，则为True。

$ bUsePrecompiled：如果编译目标应该传递-useprecompiled参数，则为True。

$ bIncludeEngineSource：如果生成的解决方案中应该包含引擎源，则为True。

$ bIncludeShaderSource：如果生成的项目中应包含着色器源文件，则为True。

$ bIncludeConfigFiles：如果生成的项目中应该包含配置（.ini）文件，则为True。

$ bIncludeTemplateFiles：如果生成的项目中应包含模板文件，则为True。

$ bIncludeEnginePrograms：如果生成的解决方案中应该包含程序项目，则为True。

$ IncludeCppSource：是否要包含C++目标

$ bIncludeDotNetPrograms：如果生成的解决方案中应该包含csharp程序项目，则为True。 传递"-DotNet"以将其启用。

$ bIncludeTempTargets：是否包含由UAT生成的临时目标，以便支持具有非默认设置的纯内容项目。

$ PrimaryProjectName：主项目文件的名称，例如，Visual Studio解决方案文件的基础文件名，或Mac上的Xcode项目文件名称。

$ bPrimaryProjectNameFromFolder：如果为True，则根据其所在文件夹的名称设置主项目名称。

### KDevelopGenerator

$ bIncludeDocumentation：如果应该在生成的项目中包含文档，则为True。

$ bUsePrecompiled：如果编译目标应该传递-useprecompiled参数，则为True。

$ bIncludeEngineSource：如果生成的解决方案中应该包含引擎源，则为True。

$ bIncludeShaderSource：如果生成的项目中应包含着色器源文件，则为True。

$ bIncludeConfigFiles：如果生成的项目中应该包含配置（.ini）文件，则为True。

$ bIncludeTemplateFiles：如果生成的项目中应包含模板文件，则为True。

$ bIncludeEnginePrograms：如果生成的解决方案中应该包含程序项目，则为True。

$ IncludeCppSource：是否要包含C++目标

$ bIncludeDotNetPrograms：如果生成的解决方案中应该包含csharp程序项目，则为True。 传递"-DotNet"以将其启用。

$ bIncludeTempTargets：是否包含由UAT生成的临时目标，以便支持具有非默认设置的纯内容项目。

$ PrimaryProjectName：主项目文件的名称，例如，Visual Studio解决方案文件的基础文件名，或Mac上的Xcode项目文件名称。

$ bPrimaryProjectNameFromFolder：如果为True，则根据其所在文件夹的名称设置主项目名称。

### MakefileGenerator

$ bIncludeDocumentation：如果应该在生成的项目中包含文档，则为True。

$ bUsePrecompiled：如果编译目标应该传递-useprecompiled参数，则为True。

$ bIncludeEngineSource：如果生成的解决方案中应该包含引擎源，则为True。

$ bIncludeShaderSource：如果生成的项目中应包含着色器源文件，则为True。

$ bIncludeConfigFiles：如果生成的项目中应该包含配置（.ini）文件，则为True。

$ bIncludeTemplateFiles：如果生成的项目中应包含模板文件，则为True。

$ bIncludeEnginePrograms：如果生成的解决方案中应该包含程序项目，则为True。

$ IncludeCppSource：是否要包含C++目标

$ bIncludeDotNetPrograms：如果生成的解决方案中应该包含csharp程序项目，则为True。 传递"-DotNet"以将其启用。

$ bIncludeTempTargets：是否包含由UAT生成的临时目标，以便支持具有非默认设置的纯内容项目。

$ PrimaryProjectName：主项目文件的名称，例如，Visual Studio解决方案文件的基础文件名，或Mac上的Xcode项目文件名称。

$ bPrimaryProjectNameFromFolder：如果为True，则根据其所在文件夹的名称设置主项目名称。

### QMakefileGenerator

$ bIncludeDocumentation：如果应该在生成的项目中包含文档，则为True。

$ bUsePrecompiled：如果编译目标应该传递-useprecompiled参数，则为True。

$ bIncludeEngineSource：如果生成的解决方案中应该包含引擎源，则为True。

$ bIncludeShaderSource：如果生成的项目中应包含着色器源文件，则为True。

$ bIncludeConfigFiles：如果生成的项目中应该包含配置（.ini）文件，则为True。

$ bIncludeTemplateFiles：如果生成的项目中应包含模板文件，则为True。

$ bIncludeEnginePrograms：如果生成的解决方案中应该包含程序项目，则为True。

$ IncludeCppSource：是否要包含C++目标

$ bIncludeDotNetPrograms：如果生成的解决方案中应该包含csharp程序项目，则为True。 传递"-DotNet"以将其启用。

$ bIncludeTempTargets：是否包含由UAT生成的临时目标，以便支持具有非默认设置的纯内容项目。

$ PrimaryProjectName：主项目文件的名称，例如，Visual Studio解决方案文件的基础文件名，或Mac上的Xcode项目文件名称。

$ bPrimaryProjectNameFromFolder：如果为True，则根据其所在文件夹的名称设置主项目名称。

### RiderProjectFileGenerator

$ bIncludeDocumentation：如果应该在生成的项目中包含文档，则为True。

$ bUsePrecompiled：如果编译目标应该传递-useprecompiled参数，则为True。

$ bIncludeEngineSource：如果生成的解决方案中应该包含引擎源，则为True。

$ bIncludeShaderSource：如果生成的项目中应包含着色器源文件，则为True。

$ bIncludeConfigFiles：如果生成的项目中应该包含配置（.ini）文件，则为True。

$ bIncludeTemplateFiles：如果生成的项目中应包含模板文件，则为True。

$ bIncludeEnginePrograms：如果生成的解决方案中应该包含程序项目，则为True。

$ IncludeCppSource：是否要包含C++目标

$ bIncludeDotNetPrograms：如果生成的解决方案中应该包含csharp程序项目，则为True。 传递"-DotNet"以将其启用。

$ bIncludeTempTargets：是否包含由UAT生成的临时目标，以便支持具有非默认设置的纯内容项目。

$ PrimaryProjectName：主项目文件的名称，例如，Visual Studio解决方案文件的基础文件名，或Mac上的Xcode项目文件名称。

$ bPrimaryProjectNameFromFolder：如果为True，则根据其所在文件夹的名称设置主项目名称。

### VSCodeProjectFileGenerator

$ IncludeAllFiles：在生成的工作空间中包含所有文件。

$ AddDebugAttachConfig：VS代码项目生成是否应包含调试配置，以便允许附加到已在运行的进程

$ AddDebugCoreConfig：VS代码项目生成是否应包含调试配置，以便允许核心转储调试

$ NoCompileCommands：不要为每个文件创建带有编译器参数的编译命令json文件；使用VS Code扩展并采用UBT服务器模式的效果会更好。

$ UseVSCodeExtension：创建工作空间文件以用于直接与UBT通信的VS Code扩展。

$ bIncludeDocumentation：如果应该在生成的项目中包含文档，则为True。

$ bUsePrecompiled：如果编译目标应该传递-useprecompiled参数，则为True。

$ bIncludeEngineSource：如果生成的解决方案中应该包含引擎源，则为True。

$ bIncludeShaderSource：如果生成的项目中应包含着色器源文件，则为True。

$ bIncludeConfigFiles：如果生成的项目中应该包含配置（.ini）文件，则为True。

$ bIncludeTemplateFiles：如果生成的项目中应包含模板文件，则为True。

$ bIncludeEnginePrograms：如果生成的解决方案中应该包含程序项目，则为True。

$ IncludeCppSource：是否要包含C++目标

$ bIncludeDotNetPrograms：如果生成的解决方案中应该包含csharp程序项目，则为True。 传递"-DotNet"以将其启用。

$ bIncludeTempTargets：是否包含由UAT生成的临时目标，以便支持具有非默认设置的纯内容项目。

$ PrimaryProjectName：主项目文件的名称，例如，Visual Studio解决方案文件的基础文件名，或Mac上的Xcode项目文件名称。

$ bPrimaryProjectNameFromFolder：如果为True，则根据其所在文件夹的名称设置主项目名称。

### VCMacProjectFileGenerator

$ bIncludeDocumentation：如果应该在生成的项目中包含文档，则为True。

$ bUsePrecompiled：如果编译目标应该传递-useprecompiled参数，则为True。

$ bIncludeEngineSource：如果生成的解决方案中应该包含引擎源，则为True。

$ bIncludeShaderSource：如果生成的项目中应包含着色器源文件，则为True。

$ bIncludeConfigFiles：如果生成的项目中应该包含配置（.ini）文件，则为True。

$ bIncludeTemplateFiles：如果生成的项目中应包含模板文件，则为True。

$ bIncludeEnginePrograms：如果生成的解决方案中应该包含程序项目，则为True。

$ IncludeCppSource：是否要包含C++目标

$ bIncludeDotNetPrograms：如果生成的解决方案中应该包含csharp程序项目，则为True。 传递"-DotNet"以将其启用。

$ bIncludeTempTargets：是否包含由UAT生成的临时目标，以便支持具有非默认设置的纯内容项目。

$ PrimaryProjectName：主项目文件的名称，例如，Visual Studio解决方案文件的基础文件名，或Mac上的Xcode项目文件名称。

$ bPrimaryProjectNameFromFolder：如果为True，则根据其所在文件夹的名称设置主项目名称。

### VSWorkspaceProjectFileGenerator

$ bIncludeDocumentation：如果应该在生成的项目中包含文档，则为True。

$ bUsePrecompiled：如果编译目标应该传递-useprecompiled参数，则为True。

$ bIncludeEngineSource：如果生成的解决方案中应该包含引擎源，则为True。

$ bIncludeShaderSource：如果生成的项目中应包含着色器源文件，则为True。

$ bIncludeConfigFiles：如果生成的项目中应该包含配置（.ini）文件，则为True。

$ bIncludeTemplateFiles：如果生成的项目中应包含模板文件，则为True。

$ bIncludeEnginePrograms：如果生成的解决方案中应该包含程序项目，则为True。

$ IncludeCppSource：是否要包含C++目标

$ bIncludeDotNetPrograms：如果生成的解决方案中应该包含csharp程序项目，则为True。 传递"-DotNet"以将其启用。

$ bIncludeTempTargets：是否包含由UAT生成的临时目标，以便支持具有非默认设置的纯内容项目。

$ PrimaryProjectName：主项目文件的名称，例如，Visual Studio解决方案文件的基础文件名，或Mac上的Xcode项目文件名称。

$ bPrimaryProjectNameFromFolder：如果为True，则根据其所在文件夹的名称设置主项目名称。

### VCProjectFileGenerator

$ Version：需要为其生成项目文件的Visual Studio版本。

$ MaxSharedIncludePaths：将最常见的包含路径放在MSBuild项目的IncludePath属性中。 这样可显著减少Visual Studio内存占用（测量结果为1.1GB -> 500mb），但似乎会导致视觉辅助功能出现问题。 此处的值将指定包含路径列表的最大长度，以KB为单位。

$ ExcludedIncludePaths：不应被添加到项目包含路径的路径列表，以分号分隔。 适用于从智能感知建议中省略第三方头文件（例如ThirdParty/WebRTC），并减少内存占用。

$ ExcludedFilePaths：不应被添加到项目的路径列表，以分号分隔。 适用于从智能感知建议中省略第三方文件（例如ThirdParty/WebRTC），并减少内存占用。

$ bBuildUBTInDebug：强制UBT在调试配置中编译，无视解决方案的配置

$ bBuildLiveCodingConsole：在编译支持实时编码的目标时，是否包括对LiveCodingConsole的依赖性。

$ bMakeProjectPerTarget：是否为目标逐个生成项目文件，而且在配置中不包含 编辑器/客户端/服务器等项目。

$ bIncludeDocumentation：如果应该在生成的项目中包含文档，则为True。

$ bUsePrecompiled：如果编译目标应该传递-useprecompiled参数，则为True。

$ bIncludeEngineSource：如果生成的解决方案中应该包含引擎源，则为True。

$ bIncludeShaderSource：如果生成的项目中应包含着色器源文件，则为True。

$ bIncludeConfigFiles：如果生成的项目中应该包含配置（.ini）文件，则为True。

$ bIncludeTemplateFiles：如果生成的项目中应包含模板文件，则为True。

$ bIncludeEnginePrograms：如果生成的解决方案中应该包含程序项目，则为True。

$ IncludeCppSource：是否要包含C++目标

$ bIncludeDotNetPrograms：如果生成的解决方案中应该包含csharp程序项目，则为True。 传递"-DotNet"以将其启用。

$ bIncludeTempTargets：是否包含由UAT生成的临时目标，以便支持具有非默认设置的纯内容项目。

$ PrimaryProjectName：主项目文件的名称，例如，Visual Studio解决方案文件的基础文件名，或Mac上的Xcode项目文件名称。

$ bPrimaryProjectNameFromFolder：如果为True，则根据其所在文件夹的名称设置主项目名称。

### XcodeProjectFileGenerator

$ bIncludeDocumentation：如果应该在生成的项目中包含文档，则为True。

$ bUsePrecompiled：如果编译目标应该传递-useprecompiled参数，则为True。

$ bIncludeEngineSource：如果生成的解决方案中应该包含引擎源，则为True。

$ bIncludeShaderSource：如果生成的项目中应包含着色器源文件，则为True。

$ bIncludeConfigFiles：如果生成的项目中应该包含配置（.ini）文件，则为True。

$ bIncludeTemplateFiles：如果生成的项目中应包含模板文件，则为True。

$ bIncludeEnginePrograms：如果生成的解决方案中应该包含程序项目，则为True。

$ IncludeCppSource：是否要包含C++目标

$ bIncludeDotNetPrograms：如果生成的解决方案中应该包含csharp程序项目，则为True。 传递"-DotNet"以将其启用。

$ bIncludeTempTargets：是否包含由UAT生成的临时目标，以便支持具有非默认设置的纯内容项目。

$ PrimaryProjectName：主项目文件的名称，例如，Visual Studio解决方案文件的基础文件名，或Mac上的Xcode项目文件名称。

$ bPrimaryProjectNameFromFolder：如果为True，则根据其所在文件夹的名称设置主项目名称。

### SourceFileWorkingSet

$ Provider：设置用于确定工作集的提供程序。

$ RepositoryPath：设置仓库所用的路径。 如果相关，则相对于虚幻引擎根目录（Engine文件夹之上的文件夹）解译。

$ GitPath：设置Git所用的可执行文件的路径。 默认为"git"（假定它位于PATH中）。

### RemoteMac

$ ServerName：这两个变量将从XmlConfigLoader.Init()指定的XML配置文件加载。

$ UserName：远程用户名。

$ SshPrivateKey：设置后，将使用该私人密钥，而不会在通常路径（Documents/Unreal，Engine/UnrealBuildTool/SSHKeys或者Engine/Build/SSHKeys）中查找RemoteToolChainPrivate.key。

$ RsyncAuthentication：用于Rsync的身份验证（针对-e rsync标记）。

$ SshAuthentication：用于SSH的身份验证（可能类似于RsyncAuthentication）。

### 日志

$ bBackupLogFiles：是否备份现有日志文件，而不是将其重写。

$ LogFileBackupCount：需要保留的日志文件备份数。 较旧的备份将被删除。

### 遥测

$ Providers：提供者需从"ini"文件中加载选择性遥测连接信息。 如果未设置，或者提供者类别中并未包含连接信息，则不发送任何遥测信息。
