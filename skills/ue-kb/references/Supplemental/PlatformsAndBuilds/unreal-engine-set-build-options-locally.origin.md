# 在本地设置构建选项

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/GD59/unreal-engine-set-build-options-locally

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 990 字符。

## 摘要

在本地设置构建选项 由 Epic Games 工作人员撰写的文章 在 Documents/Unreal Engine/UnrealBuildTool 中创建“BuildConfiguration.xml”文件可让您手动覆盖 UBT 中的许多构建/编译器选项。参见 B…

## 中文整理

### 概览

*由 Epic Games 工作人员撰写的文章* 在 Documents/Unreal Engine/UnrealBuildTool 中创建“BuildConfiguration.xml”文件可让您手动覆盖 UBT 中的许多构建/编译器选项。有关选项的完整列表，请参阅 BuildConfiguration.cs 和 TargetRules.cs。

```cpp
<?xml version="1.0" encoding="utf-8" ?>
<Configuration xmlns="https://www.unrealengine.com/BuildConfiguration">
  <BuildConfiguration>
    <bUseUnityBuild>true</bUseUnityBuild>
    <bAdaptiveUnityDisablesOptimizations>true</bAdaptiveUnityDisablesOptimizations>
    <bUseAdaptiveUnityBuild>true</bUseAdaptiveUnityBuild>
    <bAllowXGE>true</bAllowXGE>
  </BuildConfiguration>
</Configuration>
```

如需了解更多信息，请访问虚幻构建工具[文档](https://docs.unrealengine.com/4.27/en-US/ProductionPipelines/BuildTools/UnrealBuildTool/)
