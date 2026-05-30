# iOS：如何更改远程构建路径

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/zerJ/unreal-engine-ios-how-to-change-remote-build-path

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1403 字符。

## 摘要

文章作者：Brantley C。 注意：此功能将在 UE 4.27 及以后版本的项目设置中提供。本指南旨在将该功能引入旧版本的引擎。获得…的最简单方法

## 中文整理

### 概览

*文章由 [Brantley C.](https://dev.epicgames.com/community/profile/BxX8/FernBlades) 撰写* *注意：此功能将在 UE 4.27 及未来版本的项目设置中提供。本指南旨在将该功能引入旧版本的引擎。* 获得整个功能的最简单方法是集成 **CL 15375484** 以进行项目设置，但如果您在这样做时遇到问题，可以按如下方式手动进行更改：在 Engine\Source\Programs\UnrealBuildTool\ToolChain\RemoteMac.cs 中，第 272 行左右，代码更改为：

```cpp
// Get the remote base directory
string RemoteServerOverrideBuildPath;
if (Ini.GetString("/Script/IOSRuntimeSettings.IOSRuntimeSettings", "RemoteServerOverrideBuildPath", out RemoteServerOverrideBuildPath) && !String.IsNullOrEmpty(RemoteServerOverrideBuildPath))
{
	RemoteBaseDir = String.Format("{0}/{1}", RemoteServerOverrideBuildPath.Trim().TrimEnd('/'), Environment.MachineName);
}
else
{
	StringBuilder Output;
	if (ExecuteAndCaptureOutput("'echo ~'", out Output) != 0)
```

这样，您可以在 DefaultEngine.ini 中添加一个条目： [/Script/IOSRuntimeSettings.IOSRuntimeSettings] RemoteServerOverrideBuildPath=/some/path/on/the/mac
