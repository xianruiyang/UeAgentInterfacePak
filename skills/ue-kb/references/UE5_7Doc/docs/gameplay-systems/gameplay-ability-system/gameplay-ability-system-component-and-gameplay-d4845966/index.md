---
title: "技能系统组件与属性"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/gameplay-ability-system-component-and-gameplay-attributes-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "Gameplay技能系统", "技能系统组件与属性"]
---

# 技能系统组件与属性

> 路径：虚幻引擎5.7文档 / Gameplay系统 / Gameplay技能系统 / 技能系统组件与属性

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/gameplay-ability-system-component-and-gameplay-attributes-in-unreal-engine

**技能系统组件** (`UAbilitySystemComponent`) 是Actor和 **游戏玩法技能组件（Gameplay Ability System）** 之间的桥梁。Actor需要拥有自己的技能系统组件，或访问PlayerState或Pawn上的技能系统组件，才能与游戏玩法技能系统进行互动。

在使用技能系统组件前，请确保你的项目已开启[Gameplay Ability System插件][making-interactive-experiences\GameplayAbilitySystem]。

## 基础要求

要建立你的`AActor`子类来使用游戏玩法技能系统，请先执行`IAbilitySystemInterface`接口并覆写`GetAbilitySystemComponent`函数。此函数必须返回到Actor相关的技能系统组件。在大多数情况下，Actor类会有一个变量，并且有一个`UPROPERTY`标记，其中会存储一个到技能系统组件的指向器，类似于任何Actor类型中内置的其它组件。

虽然Actor通常会有自己的技能系统组件，但是有些情况下，你会想要部分Actor，例如玩家的Pawn或角色，使用其它Actor，例如玩家状态或（在极少情况下）玩家控制器，拥有的技能系统组件。这种情况一般涉及到玩家分数或者长期存在的技能冷却计时器，因为即便是玩家的Pawn或角色被销毁并重生，或者玩家拥有一个新的Pawn或角色，这些内容也不会重置。游戏玩法技能系统便可以支持此行为；如果你需要使用它，就要编写Actor的`GetAbilitySystemComponent`函数，从而让它返回到你想要使用的技能系统组件。

## 配置示例

以下流程是一种简单而常见的模式，可以帮助你开始运用技能系统组件。

1. 将你的类声明为`AActor`的子项或子类（`APawn`和`ACharacter`都是比较常见的基础类），然后将 `IAbilitySystemInterface`加到它的标头文件定义中，例如：\

   ```
        class AMyActor : public AActor, public IAbilitySystemInterface
   ```
2. `IAbilitySystemInterface`中有一个函数是必须要覆写，那就是`GetAbilitySystemComponent`，所以要在你的类定义中声明该函数。

   ```
        //~ Begin IAbilitySystemInterface     /** Returns our Ability System Component. */     virtual UAbilitySystemComponent* GetAbilitySystemComponent() const override;     //~ End IAbilitySystemInterface
   ```
3. 在某些情况下，尤其是Actor可以被销毁和重生时，你可能需要将技能系统组件保存在其它地方，例如保存到玩家状态。为了简单起见，本示例会将它存储到Actor。

   ```
        /** Ability System Component. Required to use Gameplay Attributes and Gameplay Abilities. */     UPROPERTY(VisibleDefaultsOnly, BlueprintReadOnly, Category = "Abilities")     UAbilitySystemComponent* AbilitySystemComponent;
   ```
4. 在Actor的源文件中编写`GetAbilitySystemComponent`函数。因为技能系统组件是存储在Actor上的，所以函数会非常简短，例如：

   ```
        UAbilitySystemComponent* AMyActor::GetAbilitySystemComponent() const     {         return AbilitySystemComponent;     }
   ```

### 进阶使用场景

你可以让一个Actor去使用属于其它Actor的技能系统组件，比如让某个Pawn使用相关玩家状态的技能系统组件。为此，Actor的`GetAbilitySystemComponent`函数必须从持有者（owner）那里获取它，或者你必须提前把它缓存到Actor上。这种情况通常发生在以下项目情形：玩家控制的Actor可以被销毁并重生，而玩家需要在该过程中保留特定的游戏玩法技能系统信息，比如金币、积分或技能冷却时间。它还可以用于其他一些情况，比如Actor将其它Actor绑定到自己身上，作为装备、模块化机械装备或身体部分；在这些情况下，游戏技能系统与绑定的Actor的互动就可以路由到主Actor的技能系统组件。实现这种效果的简单办法是，将所绑定Actor的 `GetAbilitySystemComponent` 函数传递给主Actor；如果想加以优化，可以试着在Actor绑定给另一个Actor（或被另一个Actor持有）时，缓存一个指针。

> [!WARNING]
> 尽管游戏玩法技能系统支持让多个Actor共享一个技能系统组件，但它目前还不支持单个Actor拥有多个技能系统组件，因为这会导致查询模糊、更改Actor的技能系统组件，甚至会从Actor那里获取组件。
