---
title: "Gameplay效果"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/gameplay-effects-for-the-gameplay-ability-system-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "Gameplay技能系统", "Gameplay效果"]
---

# Gameplay效果

> 路径：虚幻引擎5.7文档 / Gameplay系统 / Gameplay技能系统 / Gameplay效果

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/gameplay-effects-for-the-gameplay-ability-system-in-unreal-engine

Gameplay技能系统会利用 **Gameplay效果** 更改Gameplay技能所针对Actor的属性。Gameplay效果包含你可以应用到Actor属性的函数库。这些效果可以是即时效果，比如施加伤害，也可以是持续效果，比如毒杀，在一定的时间内对角色造成伤害。

- 你可以使用Gameplay效果进行增益和减益。

  - 根据你的游戏设计，让你的角色变得更强或更弱。
- Gameplay效果属于资产，因此在运行时不可变。

  - 也有例外情况，例如，当在运行时创建Gameplay效果，但未在创建和配置时修改数据的情况。
- **Gameplay效果规格** 是Gameplay效果的运行时版本。

  - 它们是Gameplay效果的实例数据封装器（这是一种资产）。通常，在运行时使用Gameplay效果时（如创建蓝图图标），你需要处理Gameplay效果规格，而非Gameplay效果。例如，技能系统蓝图库（Ability System Blueprint Library）广泛使用了Gameplay效果规格。

  蓝图功能本身关注的是Gameplay效果规格，而不是Gameplay效果，这反映在技能系统蓝图库中。

## Gameplay效果生命周期

Gameplay效果的 **时长（Duration）** 可设置为 **即时（Instant）** 、 **无限（Infinite）** 或 **有持续时间（Has Duration）** 。 具有持续时间的Gameplay效果将添加到 **激活Gameplay效果容器（Active Gameplay Effects Container）** 。激活Gameplay效果容器是技能系统组件的一部分。

> [!TIP]
> - 即时的Gameplay效果声明为"已执行（Executed）"。 它永远不会进入激活Gameplay效果容器。
> - 对于即时和持续时间两者均适用的情况，使用的术语是"已施加（Applied）"。 例如，方法
>
>   CanApplyGameplayEffect
>
>   不会考虑是即时还是有持续时间。
> - 周期性效果在每个周期执行；因此，同时为"已添加（Added）"和"已执行（Executed）"。

下表列出了你可以调整的Gameplay效果的属性。

| **属性** | **说明** |
| --- | --- |
| 持续时间（Duration） | Gameplay效果可以立即应用（比如受到攻击时生命值减少），在有限的持续时间内应用（比如持续几秒的移速提升），或无限应用（比如角色随着时间的推移自然再生魔法值）。具有非即时持续时间的效果本身能以不同的时间间隔应用。对于Gameplay和影音效果的时机而言，这种间隔可能会改变效果的运行方式。 |
| 组件（Components） | 定义Gameplay效果如何呈现的Gameplay效果组件。如需可用组件的完整列表，请参阅[#Gameplay效果组件] |
| 修饰符（Modifiers） | 决定Gameplay效果如何与属性交互的修饰符。其中包括与属性本身的数学交互，例如将护甲等级属性按其基础值的5%提升，并包括执行该效果的Gameplay标签要求。 |
| 执行（Executions） | 使用UGameplayEffectExecutionCalculation定义Gameplay效果执行时的自定义行为。对于定义修饰符未充分覆盖的复杂方程来说，执行尤其有用。 |
| Gameplay提示（Gameplay Cues） | Gameplay提示是一种管理装饰效果（如粒子或声音）的网络高效方式，你可以使用Gameplay技能系统进行控制。Gameplay技能和Gameplay效果可以触发Gameplay提示。 Gameplay提示通过四个主要函数起作用，这些函数可以在原生代码或蓝图代码中重载： On Active While Active Removed Executed（仅通过Gameplay效果使用）。 所有Gameplay提示必须与以 `GameplayCue` 开头的Gameplay标签关联，如 `GameplayCue.ElectricalSparks` 或 `GameplayCue.WaterSplash.Big` 。 |
| 堆叠（Stacking） | 堆叠是指将增益或减益（或Gameplay效果）应用于已携带效果的目标的策略。堆叠还涵盖处理溢出，其中新Gameplay效果应用于原始Gameplay效果已经完全饱和的目标（例如，不断累积的毒药计，仅在溢出后产生一定时间内的毒药伤害）。 该系统支持各种堆叠行为，如： 累积效果直到突破阈值。 维持"堆叠计数"，该计数随着每个新应用程序增加，直至达到最大限值。 重置或附加限时效果的时间。 使用单独的计时器独立应用效果的多个实例。 |

## Gameplay效果组件

Gameplay效果包含用于确定Gameplay效果如何呈现的 **Gameplay效果组件** （GEComponents）。 Gameplay效果可以：

- 更改对其应用Gameplay效果的Actor的[Gameplay标签](https://dev.epicgames.com/documentation/404)，或根据条件删除其他激活的Gameplay效果。
- 你可以创建自己的游戏才有的Gameplay效果组件，组件有助于扩展Gameplay效果的可用性。 Gameplay效果组件的实现者必须仔细阅读Gameplay效果流程，并注册全部所需的回调以实现所需效果，而非提供适用于所有所需功能的更大型API。这样会将Gameplay效果组件的实现限制到原生代码。
- GEComponents存在于Gameplay效果中，Gameplay效果是一种仅限数据的蓝图资产。因此，和Gameplay效果一样，所有应用实例仅存在一个GEComponent。

下表包含完整的可用Gameplay效果组件列表：

| **Gameplay效果组件** | **说明** |
| --- | --- |
| UChanceToApplyGameplayEffectComponent | 应用Gameplay效果的概率。 |
| UBlockAbilityTagsGameplayEffectComponent | 根据所有者Gameplay效果目标Actor的Gameplay标签，进行Gameplay技能激活阻止处理。 |
| UAssetTagsGameplayEffectComponent | Gameplay效果资产拥有的标签。这些标签 *不会* 转移到Actor。 |
| UAdditionalEffectsGameplayEffectComponent | 添加尝试在特定条件下激活（或任何条件下都不激活）的其他Gameplay效果。 |
| UTargetTagsGameplayEffectComponent | 将标签授予Gameplay效果的目标（有时指所有者）。 |
| UTargetTagRequirementsGameplayEffectComponent | 指定如果此GE须应用或继续执行，目标（Gameplay效果的拥有者）必须具备的标签要求。 |
| URemoveOtherGameplayEffectComponent | 基于某些条件移除其他Gameplay效果。 |
| UCustomCanApplyGameplayEffectComponent | 处理CustomApplicationRequirement函数的配置，以查看是否应该应用此Gameplay效果。 |
| UImmunityGameplayEffectComponent | 免疫会阻止其他GameplayEffectSpecs的应用。 |

## Gameplay属性

**Gameplay属性（Gameplay Attribute）** 包含Actor当前状态的测量值，当前状态可通过浮点值描述，如：

- 生命值
- 物理力量
- 移速
- 魔抗

等等。属性在属性集中声明为FGameplayAttributeData类型的UProperties，属性集包含各种属性并监督所有对属性进行修改的尝试。

> [!NOTE]
> 属性和属性集必须以原生代码创建，无法在蓝图中创建。

### 创建属性集

遵照以下步骤创建属性集

1. 从UAttributeSet继承类，然后添加标记为UPROPERTY的Gameplay属性数据成员。例如，属性集仅包含类似如下的"生命值"属性：
2. 创建属性集后，你必须通过技能系统组件注册属性集。你可以将属性集添加为技能系统组件拥有Actor的子对象，或将其传递给技能系统组件的GetOrCreateAttributeSubobject函数。

## 编程效果和属性交互

可以重载属性集的函数有多个，这些函数可用于处理Gameplay效果尝试修改属性时属性的响应方式。例如，示例USimpleAttributeSet中的"生命值"属性可以存储浮点值，该值可以通过Gameplay技能系统访问或更改。目前，当生命值降至零后，实际上什么也不会发生，也没有什么会阻止其下降至零以下。

要使"生命值"属性以你想要的方式呈现，属性集本身可通过重载多个虚拟函数来介入，虚拟函数负责处理对其属性的修改尝试。

以下函数通常由属性集重载：

| 函数名称 | 用途 |
| --- | --- |
| PreAttributeChange / PreAttributeBaseChange | 这些函数在即将修改属性之前调用。函数旨在实施关于属性值的规则，例如，"生命值必须介于0和最大生命值"之间，并且不得对属性更改触发游戏内响应。 |
| PreGameplayEffectExecute | 在即将修改属性值之前，此函数可以拒绝或更改拟定修改。 |
| PostGameplayEffectExecute | 在修改属性值后，此函数可立即对更改做出响应。这通常包括限制属性的最终值或触发对新值的游戏内响应，例如当"生命值"属性降至零时死亡。 |
