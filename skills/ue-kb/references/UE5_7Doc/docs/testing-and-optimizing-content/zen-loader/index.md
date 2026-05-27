---
title: "Zen Loader"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/zen-loader-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "Zen Loader"]
---

# Zen Loader

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / Zen Loader

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/zen-loader-in-unreal-engine

**Zen Loader** 是 **虚幻引擎5（Unreal Engine 5）** (**UE5**)的新运行时加载程序。Zen Loader使用经过优化的软件包和在预演阶段脱机计算的object依赖项图表来降低CPU开支。Zen Loader不是将所有资产打包到一个或多个.pak文件，而是将所有软件包数据、批处理数据和着色器数据打包到一组 `.utoc` 和 `.ucas` 容器文件。

`.Pak` 文件用于较少访问的松散文件。挂载Pak文件之后，也会挂载对应的容器文件。`.Utoc` 文件描述了容器文件，包括数据块大小和偏移、压缩格式以及是否加密数据块。`.Uca` 文件包含实际数据。使用容器文件可以避免文件系统提取，让加载程序能够使用名为I/O调度程序的新I/O提取层，以最低的CPU开始查找数据块。它使用特定于平台的后端来享受硬件功能和API带来的优势。

![Zenloader预演阶段](../../../assets/images/bd/bd1a93245e06a521286d9b635e495a7268ea5c58dbb064130a6ac9870e584423.png)

## 使用Zen Loader

容器文件是在预演过程中由 **虚幻自动化工具（Unreal Automation Tool）** (**UAT**)默认生成的，只要具有这些容器文件就可以在运行时激活Zen Loader。

> [!NOTE]
> 如需详细了解如何为项目运行命令，请参阅[虚幻自动化概述](../../production-pipeline/using-the-unreal-engine-build-pipeline/unreal-automation-tool/unreal-automation-tool-overview/index.md)。

**事件驱动型加载程序（Event Driven Loader）** (**EDL**)运行时加载程序已废弃，并且会在将来的版本中被移除，但在语言阶段仍然可以使用以下命令将其用于UAT：

```
		-SkipIoStore 
```

或者，可以导航至 `C:\MyProject\Config\DefaultGame.ini` 文件，然后在[ProjectPackagingSettings]部分中添加以下行：

```
	[/Script/UnrealEd.ProjectPackagingSettings]	bUseIoStore=False 
```

> [!NOTE]
> 将 `bUseIoStore` 布尔值设置为值 `False` 将会指示Zen Loader不使用IOStore。

### 限制

**I/O调度程序（I/O Dispatcher）** 是新的I/O提取层，加载按数据块ID提供的数据，这意味着无法使用基于I/O API的标准文件/目录格式来加载或搜索数据。[资产注册表](../../cpp-programming/programming-in-the-unreal-engine-architecture/asset-registry/index.md)支持使用类似的功能来搜索目录中的资产。 使用Zen Loader时，Bulkdata无法在初始序列化完成之后加载内联数据，这意味着数据一旦卸载就无法再检索。任何需要频繁访问的数据都需要在烘焙阶段存储为非内联数据。 Zen Loader在预演时执行对象依赖项的脱机预处理。这会防止任何必须的软件包在运行时重定向，核心重定向和代理解析器等系统在加载阶段将会被忽略。

## 检查容器文件的内容

在下表中，可以查看兼容容器文件的UnrealPak支持的命令。

| 命令 |  | 说明 |
| --- | --- | --- |
| -list | 列出容器中的数据块。 |  |
| -diff | 比较两个容器的组件。 |  |
| -extract | 提取容器的内容。 |  |
| IoStore -describe | 提供与容器的依赖项、软件包和导入/导出有关的详细信息。描述命令采用 `global.ucas` 文件的路径并为 `.uasset` 文件使用类似于 PkgInfo 命令集中的某个命令的输出格式： `UnrealPak.exe IoStore -Describe=MyProject/Saved/StagedBuilds/Windows/MyProject/Content/Paks/Global.ucas -DumpToFile=Output.txt -CryptoKeys=MyProject/Saved/Cooked/Windows/MyProject/Metadata/Crypto.jsonactive_button_content` |  |

## 故障排除

下面提供了一些有帮助的故障排除命令，帮助你发现每个阶段的错误或警告：

### 加载

在加载阶段，Zen Loader使用 **LogStreaming** 日志通道，并且可以使用以下命令在命令行中临时启用Verbose/VeryVerbose日志记录：

```
	-LogCmds="LogStreaming veryverbose" 
```

对于较大的项目，日志记录可能会非常耗时。你可以使用以下命令设置选定的软件包名称或软件包ID，以筛选特定软件包中的日志：

```
	-s.VerbosePackageNames="/Game/PackageA/Game/PackageB0xABCD1234ABCD1234" 
```

如果使用附加的调试程序来运行，则可以使用以下命令：

```
	-s.DebugPackageNames 
```

这将在指定软件包的特定加载阶段提供自动断点。

### 预演

在预演阶段，**UAT** 将生成一个或多个响应文件的命令列表，此类文件使用以下命令指定每个容器中存储的所有软件包：

```
		-ScriptsForProject= "C:\MyProject\MyProject.uproject" 
```

你可以在以下目录路径中的 **UAT** 日志文件中找到此命令和其他命令：

```
		c:Engine\Programs\AutomationTool\Saved\Logs\Log.txt 
```

## Zen Loader间隔

Zen Loader基于 **事件驱动型加载程序（Event Driven Loader）** (**EDL**)，并要求使用烘焙程序中的相同输出类型，例如名称表、导入/导出贴图和预加载依赖项。旧EDL运行时逻辑已经变成脱机，并在预演阶段生成。

> [!NOTE]
> 这种对脱机预处理的优化将缩短处理运行时软件包依赖项跟踪所需的时间，一般从几秒缩短到几毫秒。

其他更改包括：

- 将软件包摘要、导出块、批处理数据和着色器放入了容器文件。
- 最重要的软件包元数据和所有软件包相互依赖项都被收纳在按照软件包ID建立索引的软件包商店中。
- .uasset软件包标头转换成了经过优化的软件包摘要。

  - 利用外部链导入贴图的操作已经被移除，替换成直接按导出object散列进行引用。
  - 名称表具有新的经过优化的批量格式。
  - 预加载依赖项已经平铺到每个软件包的导出批处理节点中，每个依赖项都指定 `CreateExport` 和 `SerializeExport` 调用序列和对其他导出批处理节点的依赖项。

### Zen存储

Zen存储是试验性功能，让你可以将烘焙过的资产存储到本地存储服务器，而不是作为松散文件存储到本地文件系统中。请参阅[Zen Store](https://dev.epicgames.com/documentation/404)了解详情。
