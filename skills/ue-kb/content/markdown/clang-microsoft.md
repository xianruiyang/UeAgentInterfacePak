# 使用Clang构建Microsoft平台

---
title: "使用Clang构建Microsoft平台"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/use-clang-to-build-microsoft-platforms-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "用虚幻构建管线", "虚幻编译工具", "使用Clang构建Microsoft平台"]
---

# 使用Clang构建Microsoft平台

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 用虚幻构建管线 / 虚幻编译工具 / 使用Clang构建Microsoft平台

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/use-clang-to-build-microsoft-platforms-in-unreal-engine

**虚幻引擎（UE）** 支持在Windows上使用 **Clang** 编译器来构建[受支持的Microsoft平台](../../../../sharing-and-releasing-projects/index.md#microsoftwindows%E5%92%8Cxbox%E4%B8%BB%E6%9C%BA)。你可以通过以下方式启用Clang：

- 构建配置
- 命令行参数
- 引擎配置

此页面还包括一个附加选项表，例如指定：

- Clang连接器
- Clang版本
- MSVC版本
- 工具链版本

详见下文的[额外选项](#%E9%A2%9D%E5%A4%96%E9%80%89%E9%A1%B9)小节。自UE 5.3起，受支持的最新Clang版本为[Clang 16](https://releases.llvm.org/16.0.0/tools/clang/docs/index.html)。

## 什么是Clang

Clang是一款前端编译器，可以将C、C++、Objective-C和Objective-C++编译成机器码。Clang是MSVC（Microsoft Visual C++）编译器的替代品。

## 安装Clang

你可以通过[Visual Studio](https://learn.microsoft.com/en-us/cpp/build/clang-support-msbuild?view=msvc-170)安装Clang，或直接从[LLVM下载](https://releases.llvm.org/download.html)页面进行安装。

## 启用Clang

安装Clang之后，按照下方任一方法在虚幻项目中启用Clang。

### 构建配置

要在[构建配置](../build-configuration/index.md)中启用Clang，找到引擎 `BuildConfiguration.xml` 文件，并添加以下代码：

```
<?xml version="1.0" encoding="utf-8" ?><Configuration xmlns="https://www.unrealengine.com/BuildConfiguration">	...	<WindowsPlatform>      		<Compiler>Clang</Compiler>	</WindowsPlatform>...</Configuration>
```

### 命令行参数

要使用[命令行参数](../../../../cpp-programming/programming-in-the-unreal-engine-architecture/command-line-arguments/index.md)启用Clang，略过 `-Compiler=Clang` 选项。

### 引擎配置

要在[引擎配置](../../../../cpp-programming/programming-in-the-unreal-engine-architecture/configuration-files/index.md)中启用Clang，找到一个引擎配置文件，例如 `DefaultEngine.ini` ，然后添加以下代码：

```
[/Script/WindowsTargetPlatform.WindowsTargetSettings]CompilerVersion=Clang
```

## 额外选项

以下选项假定：

- 构建配置（Build Configuration）选项被添加到

  BuildConfiguration.xml

  的

  <WindowsPlatform>...</WindowsPlatform>

  分段中。
- 引擎配置（Engine Configuration）选项被添加到引擎配置文件的

  [/Script/WindowsTargetPlatform.WindowsTargetSettings]

  分段，例如

  DefaultEngine.ini

  。

| **选项** | **构建配置** | **命令行参数** | **引擎配置** |
| --- | --- | --- | --- |
| Clang连接器（Clang linker） | `<bAllowClangLinker>true</bAllowClangLinker>` | `-ClangLinker` | `bAllowClangLinker=true` |
| Clang编译器版本（Clang Compiler Version） | `<CompilerVersion>Latest</CompilerVersion>` | `-CompilerVersion=Latest` | `CompilerVersion=Latest` |
| MSVC版本（MSVC Version） | `<Toolchain>VisualStudio2022</VisualStudio>` | `-VCToolchain=VisualStudio2022` | `Toolchain=VisualStudio2022` |
| 工具链版本（Toolchain Version） | `<ToolchainVersion>Latest</ToolchainVersion>` | `-VCToolchainVersion=Latest` | `ToolchainVersion=Latest` |

### Clang连接器

Clang连接器（Clang Linker）是一个布尔选项，决定了使用Clang进行编译时是否使用Clang连接器。

> [!WARNING]
> Epic并未对Microsoft平台使用Clang连接器，目前也并未进行相关测试。

### Clang编译器版本

Clang编译器版本（Clang compiler version）是一个字符串选项，决定了使用的指定编译器版本。选项包括：

- 具体版本号（Specific version number）：使用指定的确切版本，例如"16.0.0"。
- 最新（Latest）：使用最新安装的版本。

### MSVC版本

MSVC工具链是一个字符串选项，决定了使用哪个工具链。选项包括：

- VisualStudio2022

### 工具链版本

工具链版本（Toolchain version）是一个字符串选项，决定了使用的MSVC工具链版本。选项包括：

- 具体版本号（Specific version number）：使用指定的确切版本，例如"14.37.32822"。
- 最新（Latest）：使用最新安装的版本。
- 预览：使用最新安装的预览版本。

## 更多信息

点击这些链接可获取以下相关信息：

- 构建配置

  的

  Windows平台

  小节
- 命令行参数
- 引擎配置文件

