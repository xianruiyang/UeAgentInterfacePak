---
title: "模块属性"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/module-properties-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "用虚幻构建管线", "虚幻编译工具", "模块属性"]
---

# 模块属性

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 用虚幻构建管线 / 虚幻编译工具 / 模块属性

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/module-properties-in-unreal-engine

**模块**是**虚幻引擎（UE）**的构建块。 引擎本质上就是众多模块组成的大规模集合，游戏则提供自己的模块来扩充这个集合。 每个模块都封装了一组功能，并且可以提供公共接口和编译环境（包括宏、路径等）供其他模块使用。

模块通过C#源文件进行声明，这些文件的扩展名为`.build.cs`，存储在你的项目的`Source`目录下。 属于某个模块的C++源代码与`.build.cs`文件并列存储，或者存储在它的子目录中。 每个`.build.cs`文件都会声明一个衍生于`ModuleRules`基类的类，并设置属性来控制应如何通过其构造函数进行编译。 这些`.build.cs`文件由**虚幻编译工具（UBT）**编译并构造，同时决定了整体编译环境。

`.build.cs` 文件的典型结构如下。

C++

```
using UnrealBuildTool;	using System.Collections.Generic;	public class MyModule : ModuleRules	{		public MyModule(ReadOnlyTargetRules Target) : base(Target)		{			// Properties and settings go here		}	}
```

### 只读属性

$ IsPlugin (Boolean)：如果插件包含此模块，则为True

$ Logger (ILogger)：目标记录器的访问器

$ HasPackageOverride (Boolean)：如果在此模块上指定了重载类型，则返回True

$ ForceIncludeFiles (List<String>)：此模块中所有源文件都必须强制包含的头文件列表。

$ SDKVersionRelevantPlatforms (List<UnrealTargetPlatform>)：如果此属性包含了某个平台，且项目重载了其默认SDK版本，则将此模块编译为项目模块，而非共享的引擎模块

$ StaticAnalyzerCheckers (HashSet<String>)：应该启用的静态分析器检查器，弃用默认设置。 仅支持Clang。 请参阅https://clang.llvm.org/docs/analyzer/checkers.html，查看完整列表。 或运行：'clang -Xclang -analyzer-checker-help'或：'clang -Xclang -analyzer-checker-help-alpha'，查看试验性检查器的列表。

$ StaticAnalyzerDisabledCheckers (HashSet<String>)：应该禁用的静态分析器默认检查器。 如果填充了StaticAnalyzerCheckers，则不使用。 仅支持Clang。 请参阅https://clang.llvm.org/docs/analyzer/checkers.html，查看完整列表。 或运行：'clang -Xclang -analyzer-checker-help'或：'clang -Xclang -analyzer-checker-help-alpha'，查看试验性检查器的列表。

$ StaticAnalyzerAdditionalCheckers (HashSet<String>)：应该启用的静态分析器非默认检查器。 如果填充了StaticAnalyzerCheckers，则不使用。 仅支持Clang。 请参阅https://clang.llvm.org/docs/analyzer/checkers.html，查看完整列表。 或运行：'clang -Xclang -analyzer-checker-help'或：'clang -Xclang -analyzer-checker-help-alpha'，查看试验性检查器的列表。

$ StaticAnalyzerPVSDisabledErrors (HashSet<String>)：应该禁用的PVS Studio分析错误。

$ AutoSdkDirectory (String)：活动中主机平台的AutoSDK目录

$ EngineDirectory (String)：当前引擎目录

$ PluginDirectory (String)：包含此插件的目录的属性。 适合用于添加第三方依赖项的路径。

$ ModuleDirectory (String)：包含此模块的目录的属性。 适合用于添加第三方依赖项的路径。

$ TestsDirectory (String)：返回模块的低级别测试目录"Tests"。

$ IsVcPackageSupported (Boolean)：返回编译配置是否支持VcPkg。

### 读写属性

$ StaticAnalyzerRulesets (HashSet<FileReference>)：筛选警告所应该采用的静态分析器规则集。 仅支持MSVC。 详情请参阅https://learn.microsoft.com/zh-cn/cpp/code-quality/using-rule-sets-to-specify-the-cpp-rules-to-run

$ AllowedRestrictedFolders (List<String>)：编译此二进制文件时允许引用的文件夹列表，不含传播受限的文件夹名称

$ AliasRestrictedFolders (Dictionary<String, String>)：一组使用别名的受限文件夹引用

$ PublicIncludePathModuleNames (List<String>)：包含头文件的模块名称列表（不需要路径），我们模块的公共头文件需要访问这些头文件，但是不需要"导入"或链接它们。

$ PublicDependencyModuleNames (List<String>)：公共依赖性模块名称的列表（不需要路径）（自动执行私有/公共包含）。 这些是我们的公共源文件所需要的模块。

$ PrivateIncludePathModuleNames (List<String>)：包含头文件的模块名称列表（不需要路径），我们模块的私有代码文件需要访问这些头文件，但是不需要"导入"或链接它们。

$ PrivateDependencyModuleNames (List<String>)：私有依赖性模块名称的列表。 我们的私有代码依赖这些模块，但我们的公共包含文件的内容均不依赖这些模块。

$ CircularlyReferencedDependentModules (List<String>)：仅因旧版而存在，不应在新代码中使用。 应视为循环引用的模块依赖性列表。 该模块必须已经添加至公共或私有依赖模块列表中。

$ PublicSystemIncludePaths (List<String>)：系统/库包含路径列表 - 通常用于外部（第三方）模块。 这些是公共的稳定头文件目录，在解析头文件依赖性时不会受到检查。

$ PublicIncludePaths (List<String>)：（当前不需要此设置，因为我们会从'Public'文件夹中发现所有文件）公开给其他模块，且通往包含文件的所有路径的列表

$ InternalIncludePaths (List<String>)：（当前不需要此设置，因为我们会从'Internal'文件夹发现所有文件）公开给其他内部模块，且通往包含文件的所有路径的列表

$ PrivateIncludePaths (List<String>)：通往此模块内部包含文件的所有路径的列表，不向其他模块公开（至少有一项包含通往'Private'路径，如果要避免相对路径，则会更多）

$ PublicSystemLibraryPaths (List<String>)：系统库路径的列表（.lib文件的目录），对于外部（第三方）模块，请改用PublicAdditionalLibaries

$ PrivateRuntimeLibraryPaths (List<String>)：运行时各个库的搜索路径列表（例如 .so文件）

$ PublicRuntimeLibraryPaths (List<String>)：运行时各个库的搜索路径列表（例如 .so文件）

$ PublicAdditionalLibraries (List<String>)：额外库的列表（.lib文件的名称，包括扩展名） - 通常用于外部（第三方）模块

$ PublicDebugVisualizerPaths (List<String>)：额外调试查看器的列表（.natvis和.natstepfilter）公开给其他模块 - 通常用于外部（第三方）模块

$ DependenciesToSkipPerArchitecture (Dictionary<String, List<UnrealArch>>)：供链接忽略的逐架构依赖性列表（适用于需要构建多个架构，且一个架构仅需要一个库的情况），是否使用此属性取决于工具链

$ PublicPreBuildLibraries (List<String>)：其他预编译库的列表（.lib文件的名称，包括扩展名），通常用于仍会编译但使用TargetRules.PreBuildSteps或TargetRules.PreBuildTargets的其他目标。

$ PublicSystemLibraries (List<String>)：要使用的系统库的列表 - 这些库一般通过名称引用并通过系统路径查找。 如果你需要引用.lib文件，请改用PublicAdditionalLibraries

$ PublicFrameworks (List<String>)：XCode框架的列表（iOS和MacOS）

$ PublicWeakFrameworks (List<String>)：弱框架的列表（用于操作系统版本过渡）

$ PublicAdditionalFrameworks (List<Framework>)：附加框架列表 - 通常用于Mac和iOS上的外部（第三方）模块

$ AdditionalBundleResources (List<BundleResource>)：应复制到Mac或iOS应用程序数据包的附加资源列表

$ TypeLibraries (List<TypeLibrary>)：需要生成头文件的类型库列表（仅限Windows）

$ PublicDelayLoadDLLs (List<String>)：延迟加载DLL列表 - 通常用于外部（第三方）模块

$ PrivateDefinitions (List<String>)：此模块的私有编译器定义

$ PublicDefinitions (List<String>)：此模块的公共编译器定义

$ DynamicallyLoadedModuleNames (List<String>)：此模块在运行时可能需要的附加模块

$ RuntimeDependencies (RuntimeDependencyList)：此模块在运行时所依赖的文件的列表。 这些文件将与目标一同暂存。

$ AdditionalPropertiesForReceipt (ReceiptPropertyList)：需要被添加到编译回执中的额外属性列表

$ ExternalDependencies (List<String>)：修改后会使makefile无效的外部文件。 相对路径相对于.build.cs文件进行解析。

$ SubclassRules (List<String>)：修改后会使makefile无效的子类规则文件。

$ GenerateHeaderFuncs (List<ValueTuple<String, Action<ILogger, DirectoryReference>>>)：为生成头文件而调用的子目录名称和函数的列表。 子目录名称会被附加到生成的代码目录，以形成在其中生成头文件的新目录。

$ Name (String)：此模块的名称

$ Type (ModuleType)：模块类型

$ OverridePackageType (PackageOverrideType)：将设置不同程序包标记的模块的重载类型。 不能用于作为插件组成部分的模块，因为这已在 `.uplugin` 文件中设置。

$ BinariesSubFolder (String)：Binaries/PLATFORM文件夹的子文件夹，用于在编译DLL时放入此模块。 这仅应该由通过搜索找到的模块使用，例如TargetPlatform或ShaderFormat模块。 如果未使用FindModules查找定位，则找不到这些模块。

$ OptimizeCode (CodeOptimization)：应在何时优化此模块的代码。

$ OptimizationLevel (OptimizationMode)：允许微调优化级别，以提高速度和/或优化代码大小。 要求私有PCH（或NoPCHs，但不推荐）

$ FPSemantics (FPSemanticsMode)：允许重载此模块的FP语意。 要求私有PCH（或NoPCHs，但不推荐）

$ PrivatePCHHeaderFile (String)：该模块的显式私有PCH。 意味着该模块将不会使用共享的PCH。

$ SharedPCHHeaderFile (String)：该模块提供的共享PCH的头文件名。 必须为公共C++头文件的有效相对路径。 应该仅为被大量其它C++模块包含的头文件设置此属性。

$ ShortName (String)：为该模块的中间目录和中间文件指定一个替代名称。 适合在路径长度达到上限时使用。

$ PCHUsage (PCHUsageMode)：此模块的预编译头文件的用法

$ bTreatAsEngineModule (Boolean)：是否应将此模块视为引擎模块（例如， 使用引擎定义、PCH、在DebugGame配置中启用优化的情况下进行编译等）。 根据用于创建它的规则程序集初始化为默认值。

$ bValidateFormatStrings (Boolean)：针对不正确的UE_LOG格式字符串发送编译错误。

$ bValidateInternalApi (Boolean)：对于针对非引擎模块的内部API使用，发出废弃警告\错误

$ DefaultBuildSettings (BuildSettingsVersion)：默认使用哪个引擎版本的编译设置。

$ IncludeOrderVersion (EngineIncludeOrderVersion)：编译此模块时使用哪个版本的包含顺序。 可在命令行中或在模块规则中使用-ForceIncludeOrder来重载。

$ bUseRTTI (Boolean)：使用运行时类型信息

$ bVcRemoveUnreferencedComdat (Boolean)：是否命令MSVC删除未引用的COMDAT函数和数据。

$ bCodeCoverage (Boolean)：启用代码覆盖编译/链接支持。

$ bUseAVX (Boolean)：已废弃：在支持的平台上，命令编译器在使用SSE或AVX固有属性的所有地方生成AVX指令。 请注意，启用此项后，会更改PC平台的minspec，由此得到的可执行文件在不支持AVX的计算机上将会崩溃。

$ MinCpuArchX64 (Nullable<MinimumCpuArchitectureX64>)：在支持的x64平台上，命令编译器在使用SSE或AVX固有属性的所有地方生成AVX指令。 请注意，启用此项后，会更改PC平台的minspec，由此得到的可执行文件在不支持AVX的计算机上将会崩溃。

$ bEnableBufferSecurityChecks (Boolean)：启用缓冲区安全检查。 此属性通常应启用，因为它可以防止严重的安全风险。

$ bEnableExceptions (Boolean)：启用异常处理

$ bEnableObjCExceptions (Boolean)：启用Objective C异常处理

$ bEnableObjCAutomaticReferenceCounting (Boolean)：启用Objective C自动引用计数（ARC）。如果将此属性设为true，则不应为此模块使用共享PCH。 引擎短期内不会广泛采用ARC。不这样做将导致编译错误，因为共享PCH是使用与消费者不同的标记编译的

$ DeterministicWarningLevel (WarningLevel)：如何处理确定性警告（试验性）。

$ ShadowVariableWarningLevel (WarningLevel)：如何处理阴影变量警告

$ bWarningsAsErrors (Boolean)：是否将全部警告作为错误启用。 UE已经将大多数警告作为错误启用，但禁用了一些警告（例如废弃警告）。

$ UnsafeTypeCastWarningLevel (WarningLevel)：如何处理不安全的隐式类型转换警告（例如，double转换为float或int64转换为int32）。

$ UndefinedIdentifierWarningLevel (WarningLevel)：指示将条件表达式中使用的未定义标识符视为何种警告/错误级别。

$ bEnableUndefinedIdentifierWarnings (Boolean)：启用在#if表达式中对未定义辨识符的使用发出警告

$ ModuleIncludePathWarningLevel (WarningLevel)：如何处理一般模块包含路径验证消息

$ ModuleIncludePrivateWarningLevel (WarningLevel)：如何处理私有模块包含路径验证消息，其中模块会添加暴露私有头文件的包含路径

$ ModuleIncludeSubdirectoryWarningLevel (WarningLevel)：如何处理不必要的模块子目录包含路径验证消息

$ bDisableStaticAnalysis (Boolean)：禁用所有静态分析，包括Clang、msvc、pvs-studio等。

$ bStaticAnalyzerExtensions (Boolean)：启用使用EspXEngine插件的额外分析器扩展警告。 仅支持MSVC。 详情请参阅https://learn.microsoft.com/zh-cn/cpp/code-quality/using-the-cpp-core-guidelines-checkers默认情况下，此属性将添加大量警告。 如果启用此属性，建议使用StaticAnalyzerRulesets。

$ bUseUnity (Boolean)：如果启用了Unity构建，则可以使用此属性在此特定模块将使用Unity构建时进行重载。 此属性的设置会使用BuildConfiguration中的逐模块配置。

$ bMergeUnityFiles (Boolean)：是否合并模块和被生成的Unity文件以加快编译速度。

$ MinSourceFilesForUnityBuildOverride (Int32)：为模块激活Unity构建之前，该模块中的源文件数量。 如果设置为-1以外的值，则重载由MinGameModuleSourceFilesForUnityBuild控制的默认设置

$ MinFilesUsingPrecompiledHeaderOverride (Int32)：如果不为零，则重载BuildConfiguration.MinFilesUsingPrecompiledHeader。

$ NumIncludedBytesPerUnityCPPOverride (Int32)：如果不为零，则重载Target.NumIncludedBytesPerUnityCPP。

$ bBuildLocallyWithSNDBS (Boolean)：模块使用#import，因此在使用SN-DBS编译时，必须在本地编译

$ bEnableNonInlinedGenCppWarnings (Boolean)：启用在匹配的手写cpp文件中可能内联了.gen.cpp文件时发出警告

$ IsRedistributableOverride (Nullable<Boolean>)：该模块的再发行重载标记。

$ bLegalToDistributeObjectCode (Boolean)：是否可以公开发布此模块的输出，不管它是否拥有不公开发布的模块的代码/依赖项（例如 CarefullyRedist、NotForLicensees、NoRedist）。 当你计划发布二进制文件而非源时，应使用此属性。

$ bEnforceIWYU (Boolean)：当PCHUsage被设置为ExplicitOrSharedPCH时，强制执行"包含你所使用的内容（include what you use）"规则；使用单块头文件（Engine.h、UnrealEd.h等）时发出警告，并首先检查源文件是否包含了与其匹配的头文件。

$ IWYUSupport (IWYUSupport)：允许"包含你所使用的内容（include what you use）"，以在运行时修改源代码。 bEnforceIWYU必须为True，此变量才能起作用。

$ bAddDefaultIncludePaths (Boolean)：是否将所有默认包含路径添加到模块（例如， Source/Classes文件夹、Source/Public下的子文件夹）。

$ bIgnoreUnresolvedSymbols (Boolean)：是否忽略模块中的悬挂符号（即 未解析的外部符号）

$ bPrecompile (Boolean)：是否应预编译此模块。 默认为目标的bPrecompile标记。 清除此标记可避免预编译该模块。

$ bUsePrecompiled (Boolean)：此模块是否应该使用预编译数据。 对从已安装的程序集创建的模块而言，始终为true。

$ bAllowConfidentialPlatformDefines (Boolean)：此模块是否可以使用PLATFORM_XXXX样式来定义，其中XXXX即保密的平台名称。 此属性用于确保引擎或其他共享代码不会泄露#if PLATFORM_XXXX块内的机密信息。 但被许可方游戏代码最好考虑到这种情况。

$ bDisableAutoRTFMInstrumentation (Boolean)：仅当启用AutoRTFMCompiler时，才禁用此模块的AutoRTFM工具

$ PrecompileForTargets (PrecompileTargetsType)：应该为哪些目标预编译此模块

$ bRequiresImplementModule (Nullable<Boolean>)：此模块的实现是否需要IMPLEMENT_MODULE宏。 大多数虚幻引擎模块都有此需要，因为我们使用IMPLEMENT_MODULE宏执行其他全局重载（例如 运算符新建/删除朝向GMalloc的转发）。

$ bLegacyPublicIncludePaths (Boolean)：此模块是否相对于其他模块的'Public'文件夹根目录，限定其包含的头文件。 这可以减少需要传递给编译器的搜索路径的数量，从而提高性能并缩短编译器命令行的长度。

$ bLegacyParentIncludePaths (Boolean)：此模块是否相对于父目录限定所包含的来自其他模块的头文件。 这可以减少需要传递给编译器的搜索路径的数量，从而提高性能并缩短编译器命令行的长度。

$ bValidateCircularDependencies (Boolean)：是否根据白名单验证循环模块依赖项。循环模块依赖项会导致编译速度减慢。 强烈建议不要禁用此选项。 对于始终根据白名单验证的引擎模块，将忽略此选项。

$ CppStandard (Nullable<CppStandardVersion>)：使用哪个标准编译此模块

$ CStandard (Nullable<CStandardVersion>)：使用哪个标准编译此模块

$ ModuleSymbolVisibility (SymbolVisibility)：控制符号的可视性
