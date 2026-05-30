# 技术说明：FWindowsPlatformStackWalk 中的 SymGetSymFromAddr64 崩溃

# 技术说明：FWindowsPlatformStackWalk 中的 SymGetSymFromAddr64 崩溃

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/5kOO/unreal-engine-tech-note-crash-in-symgetsymfromaddr64-from-fwindowsplatformstackwalk

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1633 字符。

## 摘要

文章由 Branden T 撰写。 描述：4.26 和 4.25Plus 有时会在从 FWindowsPlatformStackWalk 调用的 SymGetSymFromAddr64 中出现崩溃。这种情况发生在 Visual Studio 的几个最新版本上......

## 中文整理

### 概览

*文章由 [Branden T.](https://dev.epicgames.com/community/profile/Kzq2/Branden.Turner) 撰写* **描述：** 4.26 和 4.25Plus 有时会在从 FWindowsPlatformStackWalk 调用的 SymGetSymFromAddr64 中出现崩溃。这种情况发生在 Visual Studio 的几个最新版本的 WindowsPlatformStackWalk::ProgramCounterToSymbolInfo 函数中。这是由于 Epic 与 UE4 一起打包的 dll 已过期。这通常表现为如下所示的崩溃：

```cpp
Access violation reading location 0x0000000000000000 

UnrealEditor-Core-Win64-Debug.dll!FWindowsPlatformStackWalk::ProgramCounterToSymbolInfo(unsigned __int64 ProgramCounter, FProgramCounterSymbolInfo & out_SymbolInfo) Line 450 C++
```

### 潜在影响

**中等** 这可能会影响在最新几个版本的 Visual Studio 上使用 4.25Plus 或 4.26 的任何人。这些崩溃的一些位置包括但不限于 lambda 内的项目测试日志记录、打开的会话前端窗口以及获取程序堆栈的崩溃日志记录的一些实例。 **解决方案：** 此 dll 已更新，应该从 4.26.1 起可用，但要在此版本之前修复：使用附加的 dll 更新 [UE_Root]/Engine/Binaries/ThirdParty/DbgHelp/DbgHelp.dll，或集成来自 //UE4/Main 的 CL 14913031，其作用相同。 UE 版本 4.25、4.26 [dbghelp.dll](/uploads/short-url/wEOJpGoADRlYD6oKiPFpJSzduej.dll) (1.8 MB)

