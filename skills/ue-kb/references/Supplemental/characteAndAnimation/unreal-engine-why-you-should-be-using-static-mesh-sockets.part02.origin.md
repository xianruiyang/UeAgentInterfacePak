# 🔌 为什么你应该使用静态网格套接字（续 2）

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/KZXp/unreal-engine-why-you-should-be-using-static-mesh-sockets
- 原始文件：unreal-engine-why-you-should-be-using-static-mesh-sockets.origin.md
- 分段：第 2/2 段

## 中文整理

### 执行跟踪

假设我们想为一把巨剑定义一个碰撞箱。我们可以创建 3 个套接字 Socket.Hitbox.Origin、Socket.Hitbox.Radius 和 Socket.Hitbox.Length 来定义刀片周围的胶囊。这个工作流程使我们能够非常紧密地配合武器的损坏部件。使用 [Offset Sockets](https://dev.epicgames.com/community/learning/tutorials/KZXp/unreal-engine-why-you-should-be-using-static-mesh-sockets#offsetsockets) 中的代码，我们可以提供一个小型 C++ 实用程序来获取套接字之间所需的距离：

```cpp
TOptional<float> GetDistanceBetweenSockets(const USceneComponent* Component, const FName FromSocket, const FName ToSocket)
{
    if (const auto From = GetSocketTransform(Component, FromSocket))
    {
        if (const auto To = GetSocketTransform(Component, ToSocket))
        {
            return FVector::Distance(From->GetLocation(), To->GetLocation());
        }
    }
    return NullOpt;
```

现在我们可以获取胶囊的属性并执行跟踪：

```cpp
const FGameplayTag OriginSocket = FGameplayTag::RequestGameplayTag(TEXT("Socket.Hitbox.Origin"));
const FGameplayTag RadiusSocket = FGameplayTag::RequestGameplayTag(TEXT("Socket.Hitbox.Radius"));
const FGameplayTag LengthSocket = FGameplayTag::RequestGameplayTag(TEXT("Socket.Hitbox.Length"));

const FTransform CapsuleOrigin = GetSocketTransform(WeaponMeshComponent, OriginSocket.GetTagName());
const float CapsuleRadius = GetDistanceBetweenSockets(WeaponMeshComponent, OriginSocket.GetTagName(), RadiusSocket.GetTagName());
const float CapsuleLength = GetDistanceBetweenSockets(WeaponMeshComponent, OriginSocket.GetTagName(), LengthSocket.GetTagName());

FHitResult Hit;
const FCollisionShape Capsule = FCollisionShape::MakeCapsule(CapsuleRadius, CapsuleLength);
```

这在蓝图中同样很容易实现，但我“强烈”建议在 C++ 中执行频繁的 hitbox 跟踪。现在我们已经有了一个碰撞箱追踪系统，我们可以将其集成到我们的战斗系统中并查看结果。我们从这种方法中获得了多种优势：

### 与目标系统的兼容性

在我的项目中，我使用 Unreal 的 TargetingSystem 插件。它通过创建 UTargetingPreset 资产提供数据驱动的跟踪方法。这些资产指定：并允许满足任何跟踪需求的非常强大的数据驱动工作流程以及出色的调试工具。最重要的是，我们可以自定义这些任务的许多方面。我们的碰撞盒形状追踪可以通过子类化 UTargetingSelectionTask_Trace 并覆盖相关方法来完全自动化。但这是另一天的话题！

### 其他类型的插座

我们已经确定，虚幻引擎中的套接字实际上只不过是相对的设计时转换。所有这些技术也适用于骨架网格物体套接字，尽管我们必须考虑到这些技术可以进行动画、物理模拟等。但列表并没有结束。

### 代理演员

术语“代理”意味着某事物或某人的“替身”。游戏开发中有一种常见技术，将“代理演员”放置在关卡中，而不是直接放置实际演员。通过这样做，我们告诉关卡：“有些东西可以在这里生成，但我们还不会告诉你它是什么”。从某种意义上说，代理参与者只是关卡本身的套接字，我们可以使用它们在运行时向其中生成任何内容。现在我们不会详细说明为什么要这样做，但这里只是一些优点：它还有更多优点。我在这里想说的是：“套接字”不需要看起来像或被称为“套接字”。它一路向下转变。好吧，你现在明白了。非常有用的东西。

### 变换 MakeEditWidget

虚幻引擎中的另一个相关隐藏功能是使用带有 MakeEditWidget 元属性的普通 FTransform（或蓝图中的 Transform）变量。

```cpp
UPROPERTY(EditAnywhere, meta=(MakeEditWidget))
FTransform MyTransformSocket;
```

在蓝图中，可以通过声明 Transform 变量、将其公开并在变量的详细信息面板中选中“显示 3D 部件”来实现相同的效果。这为我们提供了关卡中的一个小部件，例如在一个演员身上。我们可以拖动它并在视觉上放置它，这比在详细信息面板中猜测变换属性要好。这个实用程序可以很好地与产生其他东西的隐形 actor 配合使用，比如触发器形状或者我们的代理 actor。我们不直接使用 actor 的变换，而是指定一个或多个命名变换（或者“套接字”，如果您愿意的话）来生成其他 actor。这为我们提供了另一个有用的数据驱动工作流程，并在设计关卡时提供了更大的灵活性。整洁的！

### 最后的想法

电子游戏渴望变形。我们在设计时定义的越多，就越不用担心运行时计算、定制管理系统和代码复杂性。我们是视觉生物，而计算机不是。这些技术帮助我们弥合差距。感谢您的阅读！新教程*首先*出现在我的[网站](https://mugenmelon.github.io/)上。您可以在 [Kanban](https://mugenmelon.github.io/kanban) 页面上查看计划中和正在进行的教程，并在 [𝕏](https://x.com/mugenmelon) 上关注我以获取更新。
