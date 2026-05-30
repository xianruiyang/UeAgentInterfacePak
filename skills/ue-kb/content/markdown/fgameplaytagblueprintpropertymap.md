# FGameplayTagBlueprintPropertyMap - 标签观察者

# FGameplayTagBlueprintPropertyMap - 标签观察者

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/n2nJ/unreal-engine-fgameplaytagblueprintpropertymap-the-tag-watcher

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1033 字符。

## 摘要

FGameplayTagBlueprintPropertyMap 是一个大名鼎鼎的小宝石。它监视 ASC 的标记更改并自动更新另一个类的属性。您可以在 Lyra 中看到它的实际效果。这是一篇简短的文章，旨在强调其功能。

## 中文整理

### 概览

如何声明：

```cpp
UPROPERTY(EditDefaultsOnly, Category = "GameplayTags")
	FGameplayTagBlueprintPropertyMap GameplayTagPropertyMap;
```

如何初始化它：

```cpp
void ULyraAnimInstance::InitializeWithAbilitySystem(UAbilitySystemComponent* ASC)
{
	check(ASC);

	GameplayTagPropertyMap.Initialize(this, ASC);
}
```

如何设置：你可以在Lyra的ABP_Mannequin_Base中看到它。属性映射配置为将游戏标签 Event.Movement.ADS 映射到 bool 属性 GameplayTag_IsADS。然后在 AnimGraph 中读取该属性。

![教程图片](assets/unreal-engine-fgameplaytagblueprintpropertymap-the-tag-watcher/image-01.jpg)

摘要：FGameplayTagBlueprintPropertyMap 设置监听 ASC 上标签更改的委托。这些委托更新指定的属性以反映标签值。在实践中，它很容易设置和使用，并避免任何不必要的轮询标签查询。

