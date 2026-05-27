---
title: "Clang检测工具"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-clang-sanitizers-in-unreal-engine-projects"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "Clang检测工具"]
---

# Clang检测工具

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / Clang检测工具

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-clang-sanitizers-in-unreal-engine-projects

**虚幻编译工具（Unreal Build Tool）** 支持针对Linux和安卓平台的 **Clang检测工具（Sanitizer）**。本文介绍了引擎支持的检测工具信息和用法。

## 概览

很多编程错误并不违反C++的句法，所以在编译的时候不会被编译器发现。然而即使句法是正确的，逻辑中的漏洞也会导致严重的问题，比如：

- 内存泄漏
- 竞争条件
- 未初始化的内存
- 数组中的越界访问
- 整数溢出

这些错误通常只能在运行的时候通过试错的方式来检测。有了Clang检测工具，错误日志会直接向你报告，帮助你更快速地发现这些问题。

> [!TIP]
> Clang检测工具的详细信息和优点，参阅[Clang文档](https://clang.llvm.org/docs/index.html)。

## 编译工具和检测工具一起运行

在运行虚幻编译工具时，针对要使用的检测工具添加UBT参数，然后检测工具便会链接至你的最终可执行文件。以下示例指令行会将 **Address Sanitizer (ASan)** 链接至你的编译工具：

命令行

```
	Build\BatchFiles\Build.bat MyGame Linux Development -WaitMutex -FromMsBuild -EnableASan
```

运行程序时，检测工具的检测结果会显示在日志里。你可以直接用指令行运行这些代码，也可以在 **Visual Studio** 中打开你项目的 **属性（Properties）**，然后把检测工具的指令加至 **NMake** > **创建命令行（Build Command Line）** 。

> [!NOTE]
> Clang检测工具通常会消耗多余的内存空间。取决于具体的检测工具，它会降低关联程序的运行速度2到15倍。更多信息请参考Clang对于每个检测工具的规格文档。

### 受支持的检测工具

以下是UBT支持的检测工具：

| **检测工具** | **UBT指令** | **描述** |
| --- | --- | --- |
| [Address Sanitizer (ASan)](https://clang.llvm.org/docs/AddressSanitizer.html) | -EnableASan | 检测多种内存访问的问题，包括越界访问和内存泄漏。功能自Android 14后废弃。 |
| HWASan（仅限Android） | -EnableHWASan | 针对安卓平台的ASan硬件加速版本，可以节约20-30%的内存。Android 14及更新版本推荐使用该功能，需要NDK 26.1.10909125或更高版本。 |
| [Thread Sanitizer (TSan) (Doesn't work on Android)](https://clang.llvm.org/docs/ThreadSanitizer.html) | -EnableTSan | 检测诸如竞争条件之类的线程问题。 |
| [Undefined Behavior Sanitizer (UBSan)](https://clang.llvm.org/docs/UndefinedBehaviorSanitizer.html) | -EnableUBSan | 检测任何C++不支持的行为，比如越界错误、整数溢出和未初始化内存。 |
| MinUBSan (Android only) | -EnableMinUBSan | 针对安卓平台的UBSan轻量版本。 |
| [Memory Sanitizer (MSan)](https://clang.llvm.org/docs/MemorySanitizer.html) (Linux only) | -EnableMSan | 检测试图访问未初始化内存的行为。 |
