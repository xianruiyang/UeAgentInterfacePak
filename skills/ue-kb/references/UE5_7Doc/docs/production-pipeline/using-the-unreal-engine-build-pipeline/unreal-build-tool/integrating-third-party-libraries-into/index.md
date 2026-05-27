---
title: "第三方库"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/integrating-third-party-libraries-into-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "用虚幻构建管线", "虚幻编译工具", "第三方库"]
---

# 第三方库

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 用虚幻构建管线 / 虚幻编译工具 / 第三方库

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/integrating-third-party-libraries-into-unreal-engine

本文档介绍集成第三方库的方法，包括库标准添加模式、动态库特殊注意事项、依赖性暂存，以及将第三方库集成到虚幻项目时可能遇到错误的相关帮助信息。

> [!NOTE]
> **虚幻引擎（UE）** 的源代码包括多个第三方库，均库存储在 `UnrealEngine/Engine/Source/ThirdParty/..`下。此为引擎模块的规则，并非必要条件。开发使用第三方库的插件时，将第三方软件纳入插件目录将十分便利。

## 第三方插件模板

编辑器中的插件浏览器拥有集成第三方库的模板。要使用该模板新建插件，在插件浏览器窗口中选择 **新建插件（New Plugin）**，然后向下滚动到 **第三方插件（Third Party Plugin）** 模板。

## 模块设置

一般使用 `.build.cs` 文件配置常规虚幻引擎C++模块，第三方库也不例外。要创建无源代码且可供其他模块消耗的模块，则如下所示创建插件的 `.build.cs`：

```
	using System;	using System.IO;	using UnrealBuildTool; 	public class MyThirdPartyLibrary : ModuleRules	{		public MyThirdPartyLibrary(ReadOnlyTargetRules Target) : base(Target)		{			Type = ModuleType.External; 			// 添加需要设置的宏			PublicDefinitions.Add("WITH_MYTHIRDPARTYLIBRARY=1"); 			// 添加插件的包含路径			PublicIncludePaths.Add(Path.Combine(ModuleDirectory, "inc")); 			// 添加导入库或静态库			PublicAdditionalLibraries.Add(Path.Combine(ModuleDirectory, "lib", "foo.a"));		}	} 
```

`.build.cs` 应位于普通文件夹中，引擎在其中查找如 `Engine/Source` 或 `MyProject/Source` 等模块。

**ModuleType.External** 设置告知引擎不要查找（或编译）源代码。通过将列出的包含路径添加到编译环境，设置相关宏并关联到给定静态库，其将使用在该文件中定义的其他设置。

## 动态库

### Windows

Windows拥有较为固化的DLL加载模型。各可执行文件或DLL将其所依赖的DLL列表存储在其_import table_中，加载模块时OS将扫描该列表来满足此类依赖性。

仅按命名存储依赖性DLL的命名（例如无路径信息），操作系统将搜索短路径列表查找命名。由于发生这种情况时应用程序无法指定依赖性DLL的位置，因此可能为启动时发生模糊错误的根源。

#### FPlatformProcess::GetDllHandle

由引擎显式触发的DLL加载将使用 `FPlatformProcess::GetDllHandle()` 函数。其在加载各DLL导入前使用特殊逻辑读取此类导入，并尝试将DLL依赖性解析到引擎的搜索路径列表中的文件（例如整个项目、引擎和插件的"二进制"目录）。

操作系统开始加载新DLL时，若内存中已存在同名DLL，其将关联到该DLL，而非在硬盘中加载新模块。

若 `GetDllHandle` 函数无法加载依赖性，其会向日志生成大量冗长输出，这在追踪错误时将十分有用。

#### 延迟加载DLL

若DLL存在于引擎通常无法搜索到的路径中，则另一种策略则是延迟加载DLL。由于操作系统仅在首次调用其中函数时尝试加载DLL，因此可显式执行逻辑以在特定位置中进行加载。操作系统最终执行延迟加载时，其将找到已加载到进程中的现有同名DLL，并解析到该DLL，而非在硬盘上搜索。

将导入函数指向加载实际DLL的形实转换函数以进行延迟加载。加载实际DLL后导入表将变更为指向实际DLL函数地址，而非形实转换函数，同时照常继续执行。

若存取DLL中的变量，则无法使用该机制。若尝试延迟加载利用此方式引用的DLL，连接器将发出错误。

使用以下类似声明，可在 `build.cs` 文件中指定延迟加载的DLL：

```
	PublicDelayLoadDLLs.Add("foo.dll") 
```

注意：由于连接器并不关注操作系统如何解析其添加到导入表的DLL依赖性，因此DLL的路径并非必需（仅使用命名）。

#### 调试DLL加载问题

[Dependency Walker](http://www.dependencywalker.com/)适用于检查模块中导入的DLL和函数。冗长引擎日志输出也包括"Dependency Walker"工具。

### macOS

macOS可执行文件和动态库以安装名称的形式存储它们所依赖的动态库列表。安装命名可为动态库的绝对或相对路径，也可为与以下三个安装路径之一相关的路径：`@executable_path`、`@load_path` 或 `@rpath`。此类选项中最灵活的是 `@rpath`，其正是虚幻引擎所使用的选项。

[UnrealBuildTool](../index.md)自动将 `RPATH` 搜索路径添加到其构建的所有第三方动态库的可执行文件和动态库中，均位于 `Engine/Source` 和 `MyProject/Source` 子文件以外。支持将第三方动态库存储在 `Source` 子文件夹中，但由于此类文件夹不属于打包游戏或二进制版插件，编译系统需要进行不同处理、复制到不同位置等，所以不建议进行此操作。

关联期间将在动态库中读取安装命名，因此需将第三方库的安装命名设为 `@rpath/libfoo.dylib`。可通过两种方式进行此操作：编译库时使用 `-install_name` 链接器选项；或是创建动态库后使用 `install_name_tool` 进行修改，如下所示：

```
	install_name_tool -id @rpath/libfoo.dylib /path/to/libfoo.dylib 
```

对于框架，应在 `.build.cs` 文件中使用 `PublicFrameworks` 而非 `PublicAdditionalLibraries`，此外还适用相同规则，因此框架安装命名最好同样使用 `@rpath`。

#### 延迟加载DLL

> [!WARNING]
> macOS上不完全支持延迟加载DLL。

无Windows的 `/DELAYLOAD`的等同项，因而macOS上仅支持该功能的特定用途：使用运行时可能不可用的库进行关联。为了实现这一点，UE使用弱链接。

#### 调试动态库加载问题

在命令行中，`otool` 适用于检查可执行文件或动态库并查看其运行时依赖性。调试加载问题时特别适用`-L` 和 `-l` 选项。

| 命令 | 说明 |
| --- | --- |
| `otool -L libname.dylib` | 列出可执行文件或动态库依赖的所有动态库的安装命名和版本号。对于动态库，列表中首项为其自身的安装命名。 |
| `otool -l libname.dylib` | 显示文件的所有加载命令。查找 `LC_LOAD_DYLIB` 和 `LC_RPATH`，以查看动态链接器尝试自动加载的内容及 `RPATH` 搜索路径。 |

### Linux

无法更改 `dlopen` 在运行时搜索的路径，因此将在各模块的 `RPATH` 下设置Linux的所有搜索路径。可使用 `readelf` 查找已搜索的完整 `RPATH` 列表。

#### FPlatformProcess::GetDllHandle

所有虚幻引擎（UE）模块将均作为 `RTLD_LAZY | RTLD_LOCAL` 进行dlopen，而非UE模块将首先全部作为 `LAZY | LOCAL` 加载，然后作为 `LAZY | RTLD_GLOBAL` 重新打开。此操作将导致特定问题，即多个UE模块具有相同全局符号，此类模块将与其本地符号关联，而非单个全局符号，从而导致全局系统发生类似未初始化时的崩溃。使用 `gdb` 可打印其认为的保存位置，而非拥有的全局指针。如不同，则可能拥有绑定了不同定义和模块的多个全局定义和模块。

#### 调试SO加载问题

| 工具 | Linux手册页面 | 简要说明 |
| --- | --- | --- |
| ldd | http://man7.org/linux/man-pages/man1/ldd.1.html | 此将告知运行时依赖性，以及可能丢失的依赖性。 |
| nm | http://man7.org/linux/man-pages/man1/nm.1p.html | 此与"Dependency Walker"类似，可告知有关导出符号（若需要，则告知所有符号）。 |
| readelf | http://man7.org/linux/man-pages/man1/readelf.1.html | 另一个用于转储导出符号和elf部分偏移等相关信息的工具。 |
| LD_DEBUG | http://man7.org/linux/man-pages/man8/ld.so.8.html | 另一种用于找出哪些符号正在与哪个动态库绑定的方式。 |
| strace | http://man7.org/linux/man-pages/man1/strace.1.html | 此为用于找出使用中的运行时系统调用的强大工具。其可告知正在尝试打开/读取 `dlopen` 中的些路径。 |

## 运行时依赖性

打包游戏时为在可执行文件旁暂存第三方DLL，可在 `build.cs`中声明其为运行时依赖性。

```
	RuntimeDependencies.Add(Path.Combine(PluginDirectory, "Binaries/Win64/Foo.dll")); 
```

此操作假设DLL已存在于给定目录中，插件将在该位置手动进行加载。若希望在编译时将DLL复制到可执行文件使用的相同输出目录，可通过重载 `RuntimeDependencies.Add` 方法执行。

```
	RuntimeDependencies.Add("$(TargetOutputDir)/Foo.dll", Path.Combine(PluginDirectory, "Source/ThirdParty/bin/Foo.dll")); 
```

DLL的输出路径可使用其他变量：

| 变量 | 说明 |
| --- | --- |
| `$(EngineDir)` | 引擎目录 |
| `$(ProjectDir)` | 包含项目文件的目录 |
| `$(ModuleDir)` | 包含 `.build.cs` 文件的目录 |
| `$(PluginDir)` | 包含 `.uplugin` 文件的目录 |
| `$(BinaryOutputDir)` | 包含二进制文件（该模块编译到其中）的目录（例如用于编辑器版本的DLL路径，以及用于打包版本的可执行文件（EXE）的路径） |
| `$(TargetOutputDir)` | 包含可执行文件的目录（包括在编辑器版本中） |

`RuntimeDependencies` 域并不仅限于暂存DLL；还可用于将额外文件注入暂存进程中。此类文件可存储在虚幻的[PAK文件](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/PakFile)中，也可松散保存在硬盘上。操作系统将加载DLL，因此通常不能存储在PAK文件中。

```
	RuntimeDependencies.Add(Path.Combine(PluginDirectory, "Extras/..."), StagedFileType.UFS); 
```

StagedFileType的可能值有：

| 值 | 说明 |
| --- | --- |
| `StagedFileType.UFS` | 只能通过虚幻文件系统函数访问，且可能包含在PAK文件中。 |
| `StagedFileType.NonUFS` | 必须保存为松散文件系统的一部分。 |
| `StagedFileType.DebugNonUFS` | 必须保存为松散文件系统一部分的调试文件。将调试文件设为暂存前不会包括。 |
| `StagedFileType.SystemNonUFS` | 必须保存为松散文件系统一部分的系统文件。系统文件不受平台图层的自动重映射或重命名约束。 |

## 故障排除

### Windows.h

多数UE代码中默认不包含标准Windows标头（`Windows.h`）。若第三方库需使用该标头，可通过"核心"模块中的 `WindowsHWrapper.h` 文件进行包含。

```
	#include "Windows/WindowsHWrapper.h" 
```

许多Windows函数被定义为用于ANSI和Unicode变体间切换的宏，当不相关代码定义同名符号时，其可能会导致问题。为防止发生此类情况，我们取消许多 `Windows.h` 定义的宏。建议必要时显式调用函数的 `...A` 和 `...W` 变体（例如 `GetCommandLineA()` 或 `GetCommandLineW()`）。

`TRUE` 和 `FALSE` 的Windows宏不可移植，且被重新定义了值，使用该值将导致编译错误。若需启用以用于一段代码，可将其包装在 `AllowWindowsPlatformTypes.h` 和 `HideWindowsPlatformTypes.h` 的包含中，如下所示：

```
	#include "Windows/AllowWindowsPlatformTypes.h"	int Foo = TRUE;	#include "Windows/HideWindowsPlatformTypes.h" 
```

同样，原子函数的Windows宏与 `WindowsPlatformAtomics.h` 中定义的函数命名冲突。要将此类定义恢复为其初始值，包含 `AllowWindowsPlatformAtomics.h/HideWindowsPlatformAtomics.h`：

```
	#include "Windows/AllowWindowsPlatformAtomics.h"	//使用InterlockedIncrement的代码，...	#include "Windows/HideWindowsPlatformAtomics.h" 
```

### C++警告和错误

虚幻引擎代码库默认将众多警告视作错误。为放宽第三方代码的此类限制，部分跨平台宏会临时禁用常见警告：

```
	THIRD_PARTY_INCLUDES_START	#include <openssl.h>	THIRD_PARTY_INCLUDES_END 
```

### 默认打包和对齐

由于遗留原因，虚幻引擎会强制在Win32上进行4字节打包。此设置将导致使用如双精度型或长整型等8字节类型的类中出现无法调试的对齐问题。使用以下宏，可恢复在公共结构体中定义8字节类型的第三方代码的默认打包：

```
	PRAGMA_PUSH_PLATFORM_DEFAULT_PACKING	#include <thirdparty.h>	PRAGMA_POP_PLATFORM_DEFAULT_PACKING 
```

### RTTI编译错误

在Windows上，通过使用不同RTTI（运行时类型信息）标记编译的源文件来关联二进制文件可能导致编译错误。若遇到RTTI编译错误，可定义助手宏来混合开启/关闭RTTI的模块；若利用源文件编译，可在 `TargetRules.cs` 中将 `bForceEnableRTTI` 设为 `true` 来启用整个引擎的RTTI。

#### Linux

Linux不允许RTTI模块的混合和匹配。若拥有带RTTI的模块，则需为引擎进行启用。

#### 动态类型转换错误

若RTTI关闭时在非 **UObject** 类型的对象类型上动态类型转换，由于在 `CoreUObject/Public/Templates/Casts.h` 中，`#define dynamic_cast` 重定向了 **CUObject** 模块，所以将出现 "RTTI禁用时无法使用dynamic_cast错误"。对于UObject类型，动态类型转换将使用虚幻引擎的反射系统，但对于其他类型则使用常规的 `dynamic_cast`。
