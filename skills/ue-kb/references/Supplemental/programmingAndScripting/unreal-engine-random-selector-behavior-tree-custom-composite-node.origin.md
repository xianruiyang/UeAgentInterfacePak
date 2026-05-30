# 随机选择器 |行为树自定义复合节点

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/8JL3/unreal-engine-random-selector-behavior-tree-custom-composite-node

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 478 字符。

## 摘要

UBTComp_SelectorRandom 是一个自定义虚幻引擎行为树节点，它随机选择并执行子节点，无需重复，直到尝试完所有子节点。如果任何子级成功，它会返回成功，并在所有子级失败后重置。

## 中文整理

### 概览

UBTComp_SelectorRandom 是一个自定义虚幻引擎行为树节点，它随机选择并执行子节点，无需重复，直到尝试完所有子节点。如果任何子级成功，它会返回成功，并在所有子级失败后重置。

**.h 文件**

```cpp
#pragma once

#include "CoreMinimal.h"
#include "BehaviorTree/BTCompositeNode.h"
#include "BTComp_SelectorRandom.generated.h"

UCLASS()
class ENEMIES_API UBTComp_SelectorRandom : public UBTCompositeNode
{
    GENERATED_BODY()
```

**.cpp 文件**

```cpp
#include "BTComp_SelectorRandom.h"

UBTComp_SelectorRandom::UBTComp_SelectorRandom(const FObjectInitializer& ObjectInitializer)
    : Super(ObjectInitializer), LastSuccessfulChildIdx(INDEX_NONE)
{
    NodeName = "Selector Random";
}

void UBTComp_SelectorRandom::InitializeMemory(UBehaviorTreeComponent& OwnerComp, uint8* NodeMemory, EBTMemoryInit::Type InitType) const
{
```
