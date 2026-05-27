# Debugging the Shader Compile Process

---
title: "Debugging the Shader Compile Process"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/debugging-the-shader-compile-process-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "图形编程", "着色器开发", "Debugging the Shader Compile Process"]
---

# Debugging the Shader Compile Process

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 图形编程 / 着色器开发 / Debugging the Shader Compile Process

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/debugging-the-shader-compile-process-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

开发期间，最好检查虚幻引擎究竟向平台着色器编译器发送了什么。本页信息可帮助你调试与此相关的问题。

## 以 Debug 模式构建 ShaderCompileWorker

默认情况下， [UnrealBuiltTool](../../../../production-pipeline/using-the-unreal-engine-build-pipeline/unreal-build-tool/index.md) （UBT）为工具生成项目时，这些工具始终以 **Development**模式编译。为了调试，你需要以 **Debug** 模式构建引擎和项目。此模式包含用于调试项目代码的符号。

要以 **Debug** 模式构建项目，请执行以下操作：

1. 在 Visual Studio（IDE） 中使用 **Solution** 更改解决方案属性： **Configuration Manager**，它可从 **Build**菜单打开。
2. 将 **ShaderCompileWorker（SCW）** 下拉项设置为 **Debug_Program**.

> [!NOTE]
> 有关这些目标的更多信息，请参阅 [构建配置参考。](../../../../get-started/install/downloading-source-code/build-configurations-reference/index.md)

## 生成着色器调试信息文件

要调试着色器，首先需要生成可用于调试编译流程的文件。这需要启用转储中间着色器的控制台变量，使后续编译能够转储生成的文件。

可以在 **ConsoleVariables.ini**配置文件中找到一些预定义控制台变量，该文件位于 `Engine/Config`folder.

以下是启用调试信息所需的相关变量：

Config

```
; Dump shaders in the Saved folder;  Mode 1: dump all. WARNING: leaving this on for a while will fill your hard drive with many small files and folders.;  Mode 2: dump on compilation failure only (default).;  Mode 3: dump on compilation failure or warnings.r.DumpShaderDebugInfo=1
```

如上方注释所示，默认情况下，调试信息会为任何着色器编译任务写出，这会导致生成错误。不过，也可以选择始终写出调试信息（1），或在遇到警告或错误时写出（3）。

修改控制台变量不会刻意使着色器失效，因此更改此值后不会自动重新编译。你需要手动强制重建想要获取调试信息的着色器。

可以通过生成一个 GUID 并替换以下文件中的 GUID 来强制重建所有着色器： `Engine/Shaders/Public/ShaderVersion.ush`。然后重新运行编辑器（或 cook，或任何其它会编译着色器的流程）来完成此过程。版本变化会触发编辑器运行期间遇到的所有着色器重新编译，并将所有中间文件转储到项目的 `Saved/ShaderDebugInfo` folder.

也可以向任意着色器源文件添加如下临时代码行，以强制重建包含该文件的所有着色器：

C++

```
#pragma message("UESHADERMETADATA_VERSION 3F6B6BB8-21E5-42E7-BB92-4105AC3B7F02")
```

## 着色器调试信息文件夹结构

转储着色器生成的文件夹路径包含相关信息，可帮助你快速定位到特定着色器。各种日志消息也会包含特定任务的调试信息路径引用，例如某个任务失败时。

下面是一些转储着色器路径示例。

控制台输出

```
D:\UE5\Samples\Games\Lyra\Saved\ShaderDebugInfo\PCD3D_SM6\Global\FClusteredShadingPS\0D:\UE5\Samples\Games\Lyra\Saved\ShaderDebugInfo\PCD3D_SM6\M_Sparks_Base_2bc7668f760b8ef1\Default\FLocalVertexFactory\TBasePassPSFNoLightMapPolicy\0_6bf23011a88a16c6D:\UE5\Samples\Games\Lyra\Saved\ShaderDebugInfo\PCD3D_SM6\M_Sparks_Base_2bc7668f760b8ef1\Default\VelocityPipeline\FLocalVertexFactory\FVelocityPS\0_6bf23011a88a16c6
```

分析这些数据可以看到，所有路径都共享一些公共部分：

- 着色器调试信息根路径 `D:\UE5\Samples\Games\Lyra\Saved\ShaderDebugInfo`

  - 字符串形式的着色器格式 `PCD3D_SM6`.

    - 为此着色器格式编译的所有着色器调试信息都会保存在此文件夹结构中。如果一次编译多个着色器格式，会在这里看到多个文件夹。
  - 注意，也可以通过设置以下控制台变量来覆盖此位置： `r.OverrideShaderDebugDir`.

从此处开始， **Global**和 **Material** 着色器的文件夹结构不同。先看 Global shader 示例：

控制台输出

```
D:\UE5\Samples\Games\Lyra\Saved\ShaderDebugInfo\PCD3D_SM6\Global\FClusteredShadingPS\0
```

此路径的其余组成部分如下：

- 该着色器的调试组名称。

  - 定义这些着色器的 `FGlobalShaderType` 子类名称为 `FClusteredShadingPS`.
  - 特定着色器的整数 permutation ID `0`.

    - 这是着色器类型内的唯一 ID，表示特定 permutation 组合。 `#defines`.
  - For global shaders, this is always `Global.`

下一部分是上方示例中的 material shader：

控制台输出

```
D:\UE5\Samples\Games\Lyra\Saved\ShaderDebugInfo\PCD3D_SM6\ M_Sparks_Base_2bc7668f760b8ef1\Default\FLocalVertexFactory\TBasePassPSFNoLightMapPolicy\0_6bf23011a88a16c6D:\UE5\Samples\Games\Lyra\Saved\ShaderDebugInfo\PCD3D_SM6\M_Sparks_Base_2bc7668f760b8ef1\Default\VelocityPipeline\FLocalVertexFactory\FVelocityPS\0_6bf23011a88a16c6
```

这些路径的其余组成部分如下：

- 材质调试组名称 `M_Sparks_Base_2bc7660b8ef1`.

  - 注意，它反映的是材质状态，包括所有静态参数的值，但不包括着色器源状态。因此，修改着色器源不会生成新的调试文件夹名称。这会导致具有相同基础材质和相同静态参数值的两个材质实例产生重复的调试输出。
  - 如果存在，还会包含该着色器所属 shader pipeline 的名称。它在代码中通过以下宏定义： `IMPLEMENT_SHADERPIPELINE_TYPE_*` macros.

    - vertex factory C++ 类名为 `FLocalVertexFactory`.
    - shader type C++ 类名为 `TBasePassPSFNoLightMapPolicy`.
    - permutation ID `0` 以及基础材质 StateID GUID 的截断版本 `6bf23011a88a16c6`
    - 注意，只有第二个材质路径对应包含在 pipeline 中的着色器。Pipeline 是一种优化，用于检测并移除阶段之间未使用的插值器。
  - 质量级别设置为 `Default`.
  - 这里包含基础材质名称 **M_Sparks_Base** 以及一个反映材质或材质实例状态的哈希 **2bc7660b8ef1**.

> [!NOTE]
> 要缩短调试路径名称，可以设置控制台变量 `r.DumpShaderDebugShortNames=1` （位于 ConsoleVariables.ini 配置文件中）。它会生成如下略短的路径： `D:\UE5\Samples\Games\Lyra\Saved\ShaderDebugInfo\PCD3D_SM6\ M_Sparks_Base_2bc7668f760b8ef1\Default\LocalVF\BPVSFNoLMPol\0_6bf23011a88a16c6`

## 调试信息产物列表

对于所有着色器格式，这些文件夹默认包含以下产物：

- `<ShaderFileName>.usf`

  - The 传递给编译器的最终预处理源码。用于生成此源码的所有预处理器 define 会作为注释附加到文件顶部 — 实际编译步骤前会移除这些注释。
- `<ShaderFileName>_DebugCompile.usf`

  - 如果编译步骤修改了预处理源码，则会输出此文件，包含修改前源码的副本，适合以“debug compile”模式运行 Shader Compile Worker（通常通过调试器）。该文件还包含一些可能有用的附加调试信息：

    - 对于 material shader，它会包含生成此特定着色器时所设置的材质属性细节（usage flag、static switch）。这有助于区分哪些材质实例参数导致了此着色器。
    - `DebugCompile.in`

      - 一个二进制文件，包含使用 Shader Compile Worker debug compile（调试编译） 机制执行单个着色器编译任务，或 shader pipeline 的一组任务所需的全部输入。
    - `DebugCompileArgs.txt`

      - 可传递给 ShaderCompileWorker.exe 的参数，用于调试此着色器或包含此着色器的 pipeline 的编译过程。
    - `OutputHash.txt`

      - 包含 shader library 用于去重的着色器代码哈希。它与以下函数返回的哈希匹配： `FRHIShader::GetHash`.
    - `DebugHash_<hash>.txt`

      - 一个空哨兵文件。当可以访问最终着色器源码时，可用它快速找到某个着色器的调试信息，例如在启用 shader symbols 编译时。着色器预处理/剥离的最后一步会向源码顶部附加与此精确字符串匹配的注释，因此在所选 GPU 调试工具中查看某个着色器时，可以将此字符串粘贴到文件搜索工具中，以找到对应调试信息。例如，用于生成源码的预处理器 define 集合； 如上所述，这些内容现在会在实际编译前被剥离，以改进去重。
    - 预处理该着色器时使用的全部 #define 集合。

某些其它着色器格式还会转储额外产物。例如，多数后端会包含一个批处理文件，可使用最终源码直接重新运行平台编译器（以上方列表中提到的第一份源码副本作为输入），而不是由 ShaderCompileWorker 在进程内调用它。这类输出可用于向供应商发送着色器编译问题的复现。注意，所有这类产物都由 IShaderFormat 的编译函数实现生成；相对地，上方列出的产物由编辑器内的着色器系统本身生成。由于编辑器会对着色器编译任务去重，某些调试信息文件夹中可能不存在这类 IShaderFormat 生成的产物。在这种情况下，运行调试编译流程（见下一节）会创建这些产物。

如果某个着色器预处理失败，调试转储中出现的产物会更少；但如果错误消息未明显说明原因，仍可用这些产物深入分析预处理失败原因：

- `<ShaderFileName>.usf`

  - `DebugCompile.in`

    - `DebugCompileArgs.txt`

      - 可传递给 ShaderCompileWorker.exe 的参数，用于调试此着色器或包含此着色器的 pipeline 的编译过程。
    - 一个二进制文件，包含可由 Shader Compile Worker debug compile（调试编译） 模式读取的输入。在这种情况下，运行 debug compile SCW 时会自动在某个位置中断，此时可以检查该任务的 `FShaderCompilerInput` 结构体。
  - 包含注释，列出用于预处理该着色器的所有 #define 及其值，但不包含实际源码；由于预处理失败，源码不可用。

## 调试着色器编译流程

如果需要调试特定着色器编译步骤，通常需要直接运行并附加到 ShaderCompileWorker，因为着色器编译并不发生在主 Unreal Engine 进程中，而且实际执行需要一些额外步骤。

第一种也是最常用的方式，是使用本页“Debug Dump Artifacts”部分描述的调试信息产物来调试完整着色器编译流程，包括特定着色器格式 `IShaderFormat`实现中的任何逻辑。DebugCompileArgs.txt 文件包含如下参数，可设置到 Visual Studio（IDE） 中 ShaderCompileWorker 项目的 Command Arguments 部分。

控制台输出

```
"D:/UE5/Samples/Games/Lyra/Saved/ShaderDebugInfo/PCD3D_SM6/M_UI_Base_TeamLogo_3b79f5ba1237ace4/Default/LocalVF/BPVSFNoLMPol/0_90e31777ad10f4ef" 0 "DebugCompile" DebugCompile.in DebugCompile.out -DebugSourceFiles="BasePassVertexShader.usf" -TimeToLive=0.0f -KeepInput`
```

设置完成后，可以将 ShaderCompileWorker 设为启动项目，并启动和调试这个特定编译步骤。对于 shader pipeline 某一阶段的任务，这些 debug compile 参数始终会触发完整 pipeline 编译任务，包括所有其它阶段。由于各阶段彼此依赖，这可以确保 debug compile 的输出始终与正常编译路径的输出一致。

另一种建议的 SCW 调试方式是使用 Visual Studio（IDE） [Child Process Debugging Power Tool（子进程调试工具）](https://marketplace.visualstudio.com/items?itemName=vsdbgplat.MicrosoftChildProcessDebuggingPowerTool2022)，它允许自动附加到编辑器（或 cook）进程启动的任何子进程。当 SCW 随机遇到与特定着色器无关的问题时，这会很有用。

不过，大量子进程并不容易处理；在拥有 64 个或更多硬件线程的机器上运行 Unreal Engine 时，默认就属于这种情况。尝试此方法时，建议设置较低的核心限制。例如： `-corelmit=8` 添加到命令行，以免 Visual Studio（IDE） 卡住并抛出无关错误。

## 调试着色器预处理器

自 Unreal Engine 5.4 起，所有着色器预处理都发生在 editor/cook 进程中，而不是 ShaderCompileWorker 中。如果确实需要调试预处理器本身，请设置以下控制台变量，并在附加调试器的情况下运行 editor/cook 进程：

控制台输出

```
r.ShaderCompiler.BreakOnPreprocessJob=<job debug name filter>
```

这会在预处理函数开始处，针对调试名称包含筛选字符串的任何任务自动中断调试器。对于材质，最简单的方法是使用 debug group name 字符串（`M_Sparks_Base_2bc7668f760b8ef1`）。如果希望更精确，可以添加用正斜杠分隔的额外路径组成部分。

For example, `M_Sparks_Base_2bc7668f760b8ef1/Default/VelocityPipeline/FLocalVertexFactory/FVelocityPS/0`将只匹配这个单独的 velocity shader。 对于 global shader，要在特定 global shader permutation 上中断，可以将筛选器设置为 `<GlobalShaderTypeName>/<PermutationID>`，例如 `FClusteredShaderingPS/0`.

