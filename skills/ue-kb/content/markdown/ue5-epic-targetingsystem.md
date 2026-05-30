# UE5 使用 Epic 的 TargetingSystem 创建目标能力任务

# UE5 使用 Epic 的 TargetingSystem 创建目标能力任务

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/bEJV/unreal-engine-ue5-creating-a-targeting-ability-task-using-epic-s-targetingsystem

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 3209 字符。

## 摘要

使用目标系统插件实现目标能力任务

## 中文整理

### 免责声明

这是在虚幻引擎中完成的，而不是 UEFN！图标/标题图像不是我们将在本教程中创建的内容。它纯粹是为了吸引眼球，因为它看起来与目标系统调试非常相似。

### 介绍

如果你还不熟悉[目标系统](https://dev.epicgames.com/documentation/en-us/unreal-engine/gameplay-targeting-system-in-unreal-engine)，我强烈建议你看一下它，因为它确实是一个很棒的功能，可以为你的武器/能力实现不同类型的目标、过滤和评分。您可能已经注意到，该插件已经附带了一个能力任务来执行目标/过滤任务。然而，缺点是这些任务返回与大多数 GAS 元素不兼容的目标请求句柄。相反，我们希望生成实际的游戏能力目标数据，以避免每次使用目标请求句柄时都必须手动转换它。您还可以在[此处](https://gist.github.com/MajorTomAW/3cb303ddc2e443a70601de5b39d067dd)下载最终结果。

![两个能力任务的预览](assets/unreal-engine-ue5-creating-a-targeting-ability-task-using-epic-s-targetingsystem/image-01.jpg)

### 设置

确保启用 [目标系统](https://dev.epicgames.com/documentation/en-us/unreal-engine/gameplay-targeting-system-in-unreal-engine) 插件并将其模块添加到游戏模块中的 PublicDependencyModuleNames 中。

### 执行

### 标头

首先创建一个名为“UAbilityTask_WaitPerformTargeting”的新能力任务（如果您不喜欢我的名称，请选择您喜欢的任何名称）。

**目标能力任务**

```cpp
#pragma once

#include "CoreMinimal.h"
#include "Abilities/Tasks/AbilityTask.h"

// We need those headers as well
#include "Abilities/Tasks/AbilityTask_WaitTargetData.h"
#include "TargetingSystem/TargetingPreset.h"

#include "AbilityTask_WaitPerformTargeting.generated.h"
```

### 身体

必需包含路径

```cpp
#include "AbilitySystemComponent.h"
#include "AbilitySystemLog.h"
#include "TargetingSystem/TargetingSubsystem.h"
```

接下来，像这样实现构造函数

```cpp
UAbilityTask_WaitPerformTargeting::UAbilityTask_WaitPerformTargeting()
	: bForceTargetingOnServer(false)
	, bSkipReplicatingDataToServer(false)
	, bUseAsyncTargeting(false)
{
}
```

还有用于创建目标和目标过滤器任务的样板

```cpp
UAbilityTask_WaitPerformTargeting* UAbilityTask_WaitPerformTargeting::WaitPerformTargeting(
	UGameplayAbility* OwningAbility,
	FName TaskInstanceName,
	UTargetingPreset* TargetingPreset,
	bool bForceTargetingOnServer,
	bool bSkipReplicatingDataToServer,
	bool bUseAsyncTargeting,
	AActor* OverrideSourceActor)
{
	if (!IsValid(TargetingPreset))
```

现在是时候实现实际逻辑了！下面的片段可能看起来有点抽象，但我已经尽力评论好了🙏

**激活()**

```cpp
void UAbilityTask_WaitPerformTargeting::Activate()
{
	// Sanity checks
	if (!IsValid(Ability) || !IsValid(TargetingPreset))
	{
		return;
	}

	UAbilitySystemComponent* ASC = AbilitySystemComponent.Get();
	if (!ensure(IsValid(ASC)))
```

**外部取消()**

```cpp
void UAbilityTask_WaitPerformTargeting::ExternalCancel()
{
	if (ShouldBroadcastAbilityTaskDelegates())
	{
		OnCancelled.Broadcast(FGameplayAbilityTargetDataHandle());
	}

	Super::ExternalCancel();
}
```

**OnTargetDataCancelledCallback()**

```cpp
void UAbilityTask_WaitPerformTargeting::OnTargetDataCancelledCallback()
{
	// Client cancelled this Targeting Task (we're the server)
	if (ShouldBroadcastAbilityTaskDelegates())
	{
		OnCancelled.Broadcast(FGameplayAbilityTargetDataHandle());
	}

	EndTask();
}
```

**OnTargetDataReadyCallback()**

```cpp
void UAbilityTask_WaitPerformTargeting::OnTargetDataReadyCallback(
	const FGameplayAbilityTargetDataHandle& TargetData,
	FGameplayTag ApplicationTag)
{
	// Valid Target Data was replicated to use (we are server, was sent from client)
	FGameplayAbilityTargetDataHandle MutableData = TargetData;

	if (UAbilitySystemComponent* ASC = AbilitySystemComponent.Get())
	{
		ASC->ConsumeClientReplicatedTargetData(GetAbilitySpecHandle(), GetActivationPredictionKey());
```

**设置初始目标ForRequest()**

```cpp
void UAbilityTask_WaitPerformTargeting::SetupInitialTargetsForRequest(FTargetingRequestHandle RequestHandle) const
{
	if (InitialTargets.IsEmpty() ||!RequestHandle.IsValid())
	{
		return;
	}

	// Fill in initial targetin results for filtering task
	FTargetingDefaultResultsSet& TargetingResults = FTargetingDefaultResultsSet::FindOrAdd(RequestHandle);
	for (AActor* Target : InitialTargets)
```

**OnTargetingRequested()**

```cpp
void UAbilityTask_WaitPerformTargeting::OnTargetingRequested(FTargetingRequestHandle TargetingHandle)
{
	UAbilitySystemComponent* ASC = AbilitySystemComponent.Get();
	if (!ensure(IsValid(ASC)))
	{
		EndTask();
		return;
	}

	// Fill in the target data with the hit results from the targeting task
```

**应该复制数据到服务器()**

```cpp
bool UAbilityTask_WaitPerformTargeting::ShouldReplicateDataToServer() const
{
	if (!IsValid(Ability))
	{
		return false;
	}

	/* Send TargetData to server IF:
	 * - we are the client.
	 * - We don't want to skip replication to server.
```

### 信用

图标/横幅图像 *（绝对不是被盗）* 借用* Epic 的 [文章](https://dev.epicgames.com/documentation/en-us/fortnite/debug-your-game-with-debug-draw-in-verse) 关于使用 Verse 进行调试（请不要起诉我）- [代码文件](https://gist.github.com/MajorTomAW/3cb303ddc2e443a70601de5b39d067dd) - [https://dev.epicgames.com/documentation/en-us/unreal-engine/gameplay-targeting-system-in-unreal-engine](https://targeting%20system%20plugin) - [https://dev.epicgames.com/documentation/en-us/unreal-engine/gameplay-ability-system-for-unreal-engine](https://gameplay%20ability%20system)

## 相关链接

- [Code Files](https://gist.github.com/MajorTomAW/3cb303ddc2e443a70601de5b39d067dd)
- [https://dev.epicgames.com/documentation/en-us/unreal-engine/gameplay-targeting-system-in-unreal-engine](https://targeting%20system%20plugin)
- [https://dev.epicgames.com/documentation/en-us/unreal-engine/gameplay-ability-system-for-unreal-engine](https://gameplay%20ability%20system)

