# 技术说明：WinGDK PSO 缓存修复

# 技术说明：WinGDK PSO 缓存修复

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/Oaa8/unreal-engine-tech-note-wingdk-pso-cache-fix

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1865 字符。

## 摘要

文章作者：Jon C. 描述：在 D3D12 上发布的游戏通常需要包含 PSO 缓存，以确保从一开始就流畅的帧速率。然而，由于引擎代码中的遗漏，预编译......

## 中文整理

### 概览

*文章作者：[Jon C.](https://dev.epicgames.com/community/profile/33lq/Jon.Cain)* 描述：在 D3D12 上发布的游戏通常需要[包括 PSO 缓存](https://docs.unrealengine.com/4.26/en-US/SharingAndReleasing/PSOCaching/)，以确保从一开始就流畅的帧速率。然而，由于引擎代码中的遗漏，从缓存中预编译 PSO 的功能仅适用于 Windows 平台，而不适用于 WinGDK。潜在影响：严重：在 WinGDK 平台上运行时，尤其是第一次运行时，游戏可能会卡顿（体验卡顿）。此问题可能会影响 4.25Plus、4.26、4.27 和 4.27.1。解决方案：此解决方案假设已根据[有关收集和传送 PSO 缓存的文档](https://docs.unrealengine.com/4.26/en-US/SharingAndReleasing/PSOCaching/) 收集了缓存，唯一的问题是 Windows 和 WinGDK 平台之间缺乏奇偶校验。对于 4.27，在 CL 17925294 中添加了修复程序，该修复程序将包含在修补程序 4.27.2 中。在 4.25Plus 和 4.26 中，要解决此问题，请修改 WinGDKDynamicRHI.cpp 中从第 20 行开始的代码，即在创建 D3D12 RHI 之前（由 #if !WITH_EDITOR 包围的新代码）：

```cpp
else
{
#if !WITH_EDITOR
// Enable -psocache by default on DX12. Since RHI is selected at runtime we can't set this at compile time with PIPELINE_CACHE_DEFAULT_ENABLED.

auto PSOFileCacheEnabledCVar = IConsoleManager::Get().FindTConsoleVariableDataInt(TEXT("r.ShaderPipelineCache.Enabled"));

*PSOFileCacheEnabledCVar = 1;

auto PSOFileCacheReportCVar = IConsoleManager::Get().FindTConsoleVariableDataInt(TEXT("r.ShaderPipelineCache.ReportPSO"));
```

