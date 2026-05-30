# 循环依赖的解决方法

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/kj4B/unreal-engine-workaround-for-circular-dependencies

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2661 字符。

## 摘要

文章作者：Branden T。在开发过程中，您可能会在构建时遇到错误，例如： UnrealBuildTool : error : 检测到 ModuleA.Build.cs 的循环依赖。完整路线：目标 -> ModuleA.Build.cs …

## 中文整理

### 概览

*文章作者：[Branden T.](https://dev.epicgames.com/community/profile/Kzq2/Branden.Turner)* 在开发过程中，您可能会在构建时遇到错误，例如：

```cpp
UnrealBuildTool : error : Circular dependency on ModuleA.Build.cs detected.

Full Route: Target -> ModuleA.Build.cs -> ModuleB.Build.cs -> ModuleA.Build.cs
Cycled Route: is ModuleA -> ModuleB -> ModuleA.
```

通过将依赖项移至单独的模块或使用 Private/PublicIncludePathModuleNames 引用声明来打破此循环。目标是通过将循环引用的功能移动到单独的模块来尽可能消除循环依赖，以便最初相互依赖的两个模块都将依赖于这个新模块。如果由于某种原因这是不可能的，UBT 提供了一种显式声明循环依赖关系的方法来消除此错误。为了实现这一点，您需要利用普通 PrivateDependencyModuleNames 或 PublicDependencyModuleNames 顶部的 CircularlyReferencedDependentModules 列表。示例（模块 A 和 B 循环依赖）：***ModuleA.Build.cs***

```cpp
using UnrealBuildTool;
public class ModuleA : ModuleRules
{
	public ModuleA(ReadOnlyTargetRules Target) : base(Target)
	{		
		PrivateDependencyModuleNames.AddRange(
			new string[]
			{
				"ModuleB"
			}
```

***模块B.Build.cs***

```cpp
using UnrealBuildTool;

public class ModuleB : ModuleRules
{
	public ModuleB(ReadOnlyTargetRules Target) : base(Target)
	{		
		PrivateDependencyModuleNames.AddRange(
			new string[]
			{
				"ModuleA"
```

引擎代码中有这样的例子，所以我们也犯了这样的错误，尽管我们仍在努力消除循环引用以缩短构建时间和模块化程度。示例位于 [UERoot]\Engine\Source\Runtime\AIModule\AIModule.Build.cs 中。如果您想了解更多信息，可以通过在引擎代码中搜索 CircularlyReferencedDependentModules 找到更多示例。如果您想了解如何检测和处理循环，请查看 [UERoot]\Engine\Source\Programs\UnrealBuildTool\ 中的代码（尝试在该目录的文件中搜索 CircularlyReferencedDependentModules 以及循环依赖以查看围绕循环引用的代码），即在 [UERoot]\Engine\Source\Programs\UnrealBuildTool\Configuration\UEBuildModule.cs 中，在CheckForCycles 块下的 RecursivelyCreateModules 方法。我们的总体建议是尽可能消除循环依赖。
