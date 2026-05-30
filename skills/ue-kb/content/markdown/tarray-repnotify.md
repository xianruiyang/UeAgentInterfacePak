# 技术说明：复制的 TArray Repnotify 未被调用

# 技术说明：复制的 TArray Repnotify 未被调用

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/xar1/unreal-engine-tech-note-replicated-tarray-repnotify-not-being-called

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 5688 字符。

## 摘要

技术说明：Replicated TArray Repnotify 未被调用 由 Alex K 撰写的文章。 描述 这与此未决问题相关：https://issues.unrealengine.com/issue/UE-119459 用于复制的 RepNotify 函数...

## 中文整理

### 概览

*文章作者：[Alex K.](https://dev.epicgames.com/community/profile/ZvMA/akoumandarakis)*

### 描述

这与此未决问题相关：[https://issues.unrealengine.com/issue/UE-119459](https://issues.unrealengine.com/issue/UE-119459) 如果在从服务器接收更新时至少发生以下一项更改，则应在客户端上调用复制 TArray 的 RepNotify 函数： - 添加新项目 - 删除现有项目 - 以某种方式更改现有项目 但是，有报告如果仅更改数组中的现有项目而数组的维度保持不变，则不会调用此 OnRep。如果数组的大小是在构造后设置的（例如在 PostLoad 或 OnConstruction 中），或者客户端预测性地将项目添加到数组中，则可能会发生这种情况。当确定是否应该调用 Repnotify 时，引擎会将接收到的属性与影子状态进行比较。该影子状态是使用对象的原型进行初始化的，本质上是客户端和服务器之间期望相同的对象状态（类似于其类默认对象）。该原型在 PostLoad 或 OnConstruction 等调用之前初始化，这意味着如果复制数组的初始值和大小在默认构造函数之外设置，则数组的原型（及其影子状态）将不会具有这些值。如果客户端预测性地将项目添加到数组中，也可能会发生这种情况，因为这些更改不会反映在影子数组中。这似乎是问题的根本原因：数组的维度在客户端/服务器上是相同的，但这些项并不处于数组的影子状态。当客户端收到对数组属性的更改时，该类的 RepLayout 首先将客户端上本地数组的大小与从服务器发送的大小进行比较（请参阅 RepLayout.cpp 中的 PrepRecievedArray）。由于数组大小相同，因此 RepNotify 函数不会添加到要调用的列表中。这就是为什么如果数组的维度发生更改（或属性的 RepNotify 条件设置为 REPNOTIFY_Always），则会调用 RepNotify。检查尺寸后，RepLayout 会迭代数组中的各个项目，通过将其与影子数组中的相应项目进行比较来检查每个项目是否已更改。对于每个项目，它首先检查 ShadowArray 中的索引是否有效，然后如果项目不相同，则将数组的 RepNotify 添加到要调用的列表中。来自 RepLayout.cpp 中的 ReceiveProperties_r：

```cpp
// If ShadowArrayBuffer is valid, then we know that our ShadowArray pointer is also valid and pointing to a valid array.
// So we just need to make sure we’re not going outside the bounds of the array.
ArrayStackParams.ShadowData = (ShadowArrayBuffer && i < ShadowArray->Num()) ? (ShadowArrayBuffer + ElementOffset) : nullptr;
ArrayStackParams.RepNotifies = ArrayStackParams.ShadowData ? StackParams.RepNotifies : nullptr;
```

由于 ShadowArray 中不存在这些项，因此当引擎迭代数组时，这些索引将被视为无效，并且会跳过 RepNotify。

### 潜在影响

中等：未调用复制属性的 RepNotify 函数可能会以多种方式影响游戏玩法，具体取决于 OnRep 的实现，当客户端收到复制值时，某些参与者的行为不符合预期。

### 解决方案

虽然此问题的原因可能尚不清楚，但这种行为并非完全出乎意料。更改客户端上复制属性的值实际上并不是受支持的操作，并且可能会导致复制过程中出现此类问题。如果可能，建议避免修改客户端上的复制属性。如果数组的初始值是在 PostLoad 或 OnConstruction 等函数中设置的，则最好在类的构造函数中处理此初始化。这样，类的原型将具有正确的数组初始长度和值，并且可以使用属性的预期初始值来初始化复制器和影子状态。根据数组初始化的时间，另一个选项可能是检测当前实例是否具有权限，如果不是，则避免对数组进行更改。如果问题是由于客户端在从服务器接收复制值之前预测性地将项目添加到数组而导致的，则将此预测项目添加到单独的非复制数组可能会有所帮助。然后，复制数组的 RepNotify 函数可以根据需要清理该数组中的预测项。最简单的解决方法是将属性的 RepNotify 条件设置为 REPNOTIFY_Always，这将确保每当从服务器收到更新时始终调用属性的 RepNotify 函数。不过，这可能并不适合所有情况，因为即使更新实际上并未更改属性，也会调用 RepNotify 函数。最后，另一个选择是使用快速 TArray 复制（有关详细信息，请参阅 NetSerialization.h）。快速数组为更改、添加和删除提供单独的回调，并且使用快速数组复制可以提高大型集合的性能，但需要注意的是，不能保证数组元素的顺序在服务器和客户端之间保持一致。在[知识库！](https://forums.unrealengine.com/docs) 中获取更多答案

