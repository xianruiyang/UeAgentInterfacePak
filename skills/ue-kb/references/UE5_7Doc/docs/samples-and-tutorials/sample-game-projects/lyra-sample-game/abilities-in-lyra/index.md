---
title: "Lyra中的技能"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/abilities-in-lyra-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "示例与教学", "游戏示例项目", "Lyra示例游戏", "Lyra中的技能"]
---

# Lyra中的技能

> 路径：虚幻引擎5.7文档 / 示例与教学 / 游戏示例项目 / Lyra示例游戏 / Lyra中的技能

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/abilities-in-lyra-in-unreal-engine

Lyra使用[Gameplay技能系统](../../../../gameplay-systems/gameplay-ability-system/index.md)（**GAS**）来精心策划大部分游戏玩法内容。技能可以是英雄所固有的数据，比如跳跃技能，也可以通过某个Game Feature获得，或通过经验获得，或通过装备获得的。

## 什么是GAS以及为何要使用它？

Gameplay技能系统是一个插件，为快速实现和迭代Gameplay机制提供了框架。在为可能包括多个玩家的复杂Gameplay机制编写代码时，你可能会编写大量适用于许多不同游戏类型的常见样板功能。

GAS试图将机制提取为通用的游戏设计模式，并提供框架来解决常见的Gameplay实现问题，同时使上下文因项目而异。

编写样板代码通常易出错且耗时，尤其是对于多人游戏而言。例如，你不希望花费大量时间来确保你的生命（Health）值正确复制，或者在你决定具有相同行为的能量（Energy）值时，复制相同的代码行。

GAS通过提供尽可能实现常见Gameplay功能的基础来解决这些问题，同时保持机制中立。GAS并非强制使用诸如生命值（Health）、弹药（Ammo）、近战攻击（Melee Attack）或毒药减益（Poison Debuff）之类的概念，而是提供了能够定义、复制和使用 **属性（Attributes）** 、 **技能（Abilities）** 和 **效果（Effects）** 的工具，然后你可以将这些工具专用于满足给定Gameplay机制的需求。

Lyra可实现常见操作技能，例如使用武器、与移动相关的动作（例如跳跃和冲刺），以及被动监听动作（例如在死后触发重生）。技能也用于没那么明确的用途，例如召唤比赛信息UI或管理Gameplay阶段。这些内容将在下面的小节中予以详细介绍。

GAS围绕以下核心类构建。为了提供更多功能，Lyra扩展了其中的许多类：

| 核心类 | 说明 |
| --- | --- |
| UAbilitySystemComponent | 一种 **技能系统组件** （ **ASC** ），可以添加到Actor，以便为其提供GAS功能。这会跟踪特定Actor的状态，并处理复制。 |
| UAttributeSet | 在游戏机制中具有特定含义的一系列属性或数值。属性可以代表游戏资源，例如"生命值（Health）"、可以影响其他游戏规则的参考值，例如"基础攻击力（Base Attack Power）"，甚至可以代表无状态量，例如"施加的伤害（Applied Damage）"。属性集（Attribute Sets）负责定义、管理、复制一个或多个属性（Attribute）的属性值。 |
| FGameplayTag | 可以应用于游戏对象的任意层级标识符。这些标签可用于识别、分类、筛选游戏实体。 它们可以通过Gameplay效果和技能来赋予或取消，并且可以影响其行为。比如 `Gameplay.DamageImmunity` 标签，它可以防止对所有者的头像/Pawn造成伤害。 |
| UGameplayAbility | 一种游戏操作，可以赋予支持GAS的Actor并由其执行，附带用于确定其需求、开销和其他行为的信息。 示例包括基本的近战攻击到独立的游戏菜单流，再到由另一个游戏操作引起的触发行为。 |
| UGameplayEffect | 游戏操作的效果。效果可以临时或永久修改属性、赋予或取销标签、启用对其他技能的访问等等。 Gameplay效果是支持GAS的Actor相互交互的最常见方式。 |

GAS的主要优势是：

- **网络复制（Network Replication）：** 不必担心你的属性或减益效果得不到妥善地应用或复制。GAS会为你处理内部逻辑。
- **模块化（Modularity）：** 添加或更改游戏机制通常与实现和赋予新技能一样简单。通过将Gameplay功能分解为单独的资产，技能系统可以在完全不同的游戏对象或机制之间提供通用的通信层。例如，生命值（Health）可以划分到自己的属性集，并通过来自各种系统的Gameplay效果进行交互。
- **快速迭代（Fast iteration）：** GAS可以轻松更改单个游戏规则，而无需修改整个系统。用于计算游戏的数据源可以轻松交换，并且可以从相应的Gameplay效果中修改动作效果。

## ULyraAbilitySystemComponent

**Lyra技能系统组件** （ **ULyraAbilitySystemComponent** )）扩展了 **技能系统组件**（ **UAbilitySystemComponent** ）功能，以便与Lyra框架交互。它已添加到所有 **LyraPlayerState** 实例中，并且可以在你的c:Lyra\Source\LyraGame\AbilitySystem\LyraAbilitySystemComponent.h文件目录中找到。

### ALyraPlayerState

**Lyra玩家状态**（**ALyraPlayerState**）拥有用于所有玩家特定技能和行为的技能系统组件。人类玩家和人工智能机器人各有一个。你可以在c:\Lyra\Source\LyraGame\Player\LyraPlayerState.h文件目录中访问此类。将技能系统组件添加到玩家状态（Player State）类的主要优势是，它有助于将GAS状态逻辑与底层 **Pawn** 数据分开。

如果玩家的Pawn需要经常在游戏中重生，或者玩家需要在多个Pawn之间切换控制，或者玩家在当前的游戏实例中可能没有Pawn，那么分离此逻辑很有用。

这样保证了它的一些技能、属性、效果在未控制Pawn时持续存在。此逻辑提供了更简单的过程来保持游戏阶段变化之间的GAS状态。但是，每次你 **控制** 或 **未控制** Pawn 时，在初始化和取消初始化特定于Pawn的GAS状态时都需要特别小心。

Lyra通过 **ULyraHeroComponent** 和 the **ULyraPawnExtensionComponent** 来处理此问题。当有效控制器控制PlayerState的AbilitySystemComponent时，这类组件负责将一组特定的技能、属性、Gameplay效果赋予它。当Pawn被淘汰、未控制或以其他方式从游戏中移除时，这些效果将自动取销。

> [!NOTE]
> 你可以在 `c:\ReleaseWorkspace\Samples\Games\Lyra\Source\LyraGame\Hero\LyraHeroComponent.h` 目录中找到ULyraHeroComponent，在 `c:\Lyra\Source\LyraGame\Pawn\LyraPawnExtensionComponent.h` 文件目录找到ULyraPawnExtensionComponent。

### ALyraGameState

高级游戏逻辑由 **Lyra游戏状态**（**ALyraGameState**）类在服务器端进行管理，该类位于你的 `C:\Lyra\Source\LyraGame\LyraGameState.h` 文件中。游戏状态同时存在于客户端和服务器上，并会用到技能系统组件，其中游戏阶段将作为技能实现。这些游戏阶段将受到激活和停用，以影响Gameplay事件的处理方式。 例如，ShooterCore实现了三个阶段：

| 阶段 | 说明 |
| --- | --- |
| 热身（Warmup） | 在此阶段，对所有玩家应用伤害免疫Gameplay效果，然后复制的倒计时启动，免疫移除，并转换到运行中（Playing）状态。 |
| 运行中（Playing） | 在此阶段，游戏已经开始并且正在运行中。跟踪得分和时间限制，并在适当时转换到PostGame。 |
| 游戏后（PostGame） | 此阶段重新应用伤害免疫，并禁用对所有玩家的控制，然后过渡到下一轮比赛。 |

> [!NOTE]
> 虽然 **游戏状态（Game States）** 存在于客户端和服务器上，但 **游戏模式（Game Mode）** 仅适用于服务器

### 游戏阶段技能

游戏阶段技能扩展自 **ULyraGamePhaseAbility** 类，每个技能都封装了单独的状态。游戏状态逻辑假设技能激活是阶段开始，技能结束是阶段结束。这使你能够使用 **Gameplay标签（Gameplay Tag）** `GamePhaseTag` 监听特定阶段的开始或结束。

```
	| */ 定义此游戏阶段技能所属的游戏阶段。  例如，如果你的游戏阶段是GamePhase.RoundStart，那么它将取消所有相关阶段。 	因此，如果你有一个激活的阶段，例如GamePhase.WaitingToStart，启动RoundStart的技能部分将结束WaitingToStart。但是，要获取嵌套行为，你还可以嵌套阶段。例如，GamePhase.Playing.NormalPlay是父GamePhase.Playing的子阶段，因此将子阶段更改为GamePhase.Playing.SuddenDeath，将停止与GamePhase.Playing绑定的所有技能。* 但不会结束与GamePhase.Playing阶段绑定的所有技能。 		UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Lyra|Game Phase")		FGameplayTag GamePhaseTag;	 | 
```

你可以使用 **Lyra游戏阶段子系统**（**ULyraGamePhaseSubsytem**）从蓝图切换阶段，这会结束前一个阶段技能（如果它正在运行）并激活新技能。

### 输入标签激活支持

如果从[Lyra的输入系统](../lyra-input-settings/index.md)收到匹配的 **输入标签（Input Tag）** ，通过 **Gameplay技能集** （ **UGameplayAbilitySet** ）赋予的技能将自动检查激活。这样可简化技能激活，而无需依赖不透明的 **输入ID（Input ID）** 数字，或手动处理 **输入操作（Input Action）** 事件。示例包括跳跃（GA_Hero_Jump）和武器射击（GA_Weapon_Fire），如下所述。

### 扩展的标签关系系统

GAS技能和效果提供了阻止或取消特定技能的功能，然后通常由其他技能或Gameplay效果基于该功能将Gameplay标签赋予其所有者。

此信息归属于每个特定的技能和效果，对这些关系进行总体更改可能有些麻烦。例如，随着你的游戏不断升级，规则会变得更加复杂，在更新游戏规则时，可能会导致错误和不一致。

Lyra通过引入 **Lyra技能标签关系映射**（**ULyraAbilityTagRelationshipMapping**）数据资产来改进此工作流。其中包含一系列的阻止、取消和所需标签关系。你可以通过 **内容浏览器（Content Browser）** > **添加（Add）** > **杂项（Miscellaneous）** > **数据资产（Data Asset）** 创建这些关系。

你可以将 **技能标签关系映射（Ability Tag Relationship Mapping）** 资产指定为 **ULyraPawnData** 资产的一部分，并在Pawn被控制时，将该资产分配给相应的Lyra技能系统组件。当技能系统组件包含对有效标签关系映射的引用时，它会将这些内容应用为技能激活的附加激活和取消条件层。

## ULyraGlobalAbilitySystem

**Lyra全局技能系统** （ **ULyraGlobalAbilitySystem** ）提供了一种快速跟踪关卡中所有Lyra技能系统组件并与之交互的方法。

Lyra技能系统组件将在初始化期间自动使用子系统注册。目前，该子系统提供可调用蓝图函数来赋予或移除所有已注册技能系统组件的技能和Gameplay效果。

例如，Lyra的淘汰（Elimination）模式在比赛的热身阶段全局应用Gameplay效果（GE_PregameLobby）。它向所有玩家赋予伤害免疫标签，并触发Gameplay提示，该提示将启用一个UI元素，用来表明比赛尚未开始。

## ULyraAbilitySet

**Lyra技能集** （ **ULyraAbilitySet** ）是一种可以从内容浏览器创建的 **数据资产（Data Asset）** 类型。它包含一系列Gameplay技能、Gameplay效果和属性集，当应用技能集时，这些技能集将赋予Lyra角色。

赋予Lyra技能集（例如游戏功能或设备）的各方负责跟踪被赋予技能集的Actor。辅助结构体FLyraAbilitySet_GrantedHandles用于簿记和删除。

| 方法 | 说明 |
| --- | --- |
| 赋予的Gameplay技能（Granted Gameplay Abilities） | 一系列要赋予的Lyra Gameplay技能，以及赋予该技能的默认关卡和与该技能相关联的可选输入标签。 |
| 赋予的Gameplay效果（Granted Gameplay Effects） | 一系列要赋予的Gameplay效果，以及赋予该效果的默认关卡。 |
| 赋予的属性（Granted Attributes） | 一系列要赋予的属性集。 |

可以通过多种方式赋予技能集：

| 赋予技能集的方法 | 说明 |
| --- | --- |
| ULyraExperienceDefinition ULyraPawnData | 一系列在 **ULyraPawnData** 资产中定义的技能集。这些资产可以从 **ULyraExperience Definition** 中引用，且其技能集将在初始化时被自动赋予玩家的Pawn。这是在体验加载时，由ULyraPlayerStateA介导的。 这些技能赋予到玩家状态，而不是它控制的Pawn。它们可以在Pawn被控制之前被赋予，并且即使被控制的Pawn发生变化，也会持续存在。在控制Pawn本身之前，即使它们的激活策略设置为生成时（On Spawn），它们也不会被激活。需相应地计划。 |
| 游戏功能操作（Game Feature Actions） | **UGameFeatureAction_AddAbilities** 可以在激活时将技能集赋予Actor。这些操作可以添加到游戏功能插件或体验定义（Experience Definition）本身。 |
| 设备（Equipment） | **ULyraEquipmentDefinitions** 还可以将AbilitySets赋予要添加到的目标Actor。这在加载体验时由 **ULyraPlayerState** 介导。 这些技能会被赋予玩家状态，而不是其占据的Pawn。它们可能在Pawn被占据前就被赋予，并在被占据的Pawn发生变化后持续存在。在Pawn本身被占据前，它们不会被激活，哪怕其激活策略被设置为了生成时（On Spawn）激活。需相应地计划。 |

## ULyraGameplayAbility

**Lyra Gameplay技能** （ **ULyraGameplayAbility** ）从UGameplayAbility类扩展而来，可提供额外的实用程序和与Lyra框架连接的接口。

### 激活组

激活组决定技能是否可以自由激活，或者该技能是否会阻止或打断其他专有技能。你可以使用以下标签关系资产实现其他复杂的阻止行为：

| 激活组 | 说明 |
| --- | --- |
| 独立（Independent） | 该技能不会阻止或取代其他技能。默认情况下，大多数技能都应设置为此标签。 |
| 专有可替换（Exclusive Replaceable） | 该技能不会阻止其他专有技能，但如果另一个专有技能被激活，则会被取消。 |
| 专有阻止（Exclusive Blocking） | 当技能运行时，不能激活其他专有技能。 |

大多数游戏操作，例如射击、切换武器和近战攻击都设置为独立（Independent）和阻止（Blocking）。并发（Concurrency）和取消（Cancellation）由标签关系调节。排行榜和其他游戏内菜单设置为专有阻止，以便确保一次只能看到一个菜单。

### 激活策略

允许Lyra框架自动处理技能激活。

| 激活策略 | 说明 |
| --- | --- |
| 无（None） | 激活由游戏代码或蓝图手动完成。 |
| 生成时（On Spawn） | 当有效的头像分配到PlayerState时，该技能就会激活。武器填弹Gameplay技能（ **GA_Weapon_AutoReload** ）设置为生成时（On Spawn）。它将立即激活并被动运行，定期检查当前弹匣是否为空。该技能在Pawn未被控制之前不会结束。 |
| 输入触发时（On Input Triggered） | 触发关联的输入标签后，该技能就会激活一次。 **瞄准射击** （ **ADS** ）、手榴弹和其他类似技能设置为输入触发时（On Input Triggered）。它们将被激活一次，如果按住按钮，它们不会自动重新激活。 |
| 输入处于激活状态时（While Input Active） | 只要触发关联的输入标签，该技能就会持续处于激活状态。 **GA_Weapon_Fire_Shotgun** 等武器射击技能设置为输入处于激活状态时（While Input Active）。它们将播放一个发射动画蒙太奇，然后等到重新射击时间过去，随后该技能结束。这是因为重新触发实例化技能（Retrigger Instanced Ability）设置为false，冗余激活消息将被忽略，直到技能完成。 如果设置了重新触发实例化技能（Retrigger Instanced Ability），我们建议谨慎使用此激活，否则会导致垃圾信息激活并产生不良影响。 |

### K2_CanActivateAbility

一些Lyra技能使用 **K2_CanActivateAbility** 函数在蓝图中而不是C++中实现激活检查。该函数将返回true或false以允许激活，并为你提供上下文Gameplay标签，以便确定可能阻止激活的原因。这对所有Gameplay技能公开，而不仅仅是Lyra技能。

### 其他开销

普通Gameplay技能只支持单一开销和冷却Gameplay效果。**其他开销（Additional Costs）** 列表为你提供了你可以指定的其他开销，而无需将它们设置为Gameplay效果，从而启用更复杂的激活条件。

其他开销集成到标准开销流中，你可以使用相应的 **Check Cost** 和 **Commit Cost** 节点或 **提交技能（Commit Ability）** 手动检查和提交（如果你还想提交冷却）。

实际成本实现为 **ULyraAbilityCost** 对象。你可以通过在C++中扩展此类并覆盖 **CheckCost** 和 **ApplyCost** 虚函数来创建自定义开销。

Lyra使用 **ULyraAbilityCost_PlayerTagStack** 实现几个额外开销，消耗来自玩家状态（Player State）上指定Gameplay标签的多个堆栈。这些内容假设它们从派生自 **ULyraGameplayAbility_FromEquipment** 的技能调用。

| Lyra技能开销 | 说明 |
| --- | --- |
| ULyraAbilityCost_InventoryItem | 消耗角色物品栏中给定数量的关联项目。这用于物品栏中的消耗品。 |
| ULyraAbilityCost_ItemTagStack | 消耗角色物品栏中指定项目的堆栈数。如果无法支付开销，这会将Gameplay标签报告给其他技能以处理开销。这在Lyra中用于弹药消耗和装填跟踪。GA_Weapon_Fire_Shotgun和类似技能将使用设置为 `Lyra.ShooterGame.Weapon.MagazineAmmo` 的项目标签堆栈额外开销。每次武器射击时，MagazineAmmo堆栈都会基于消耗量减少。如果玩家用完当前武器弹匣中的弹药，这可以防止它们激活。 |

### 添加和删除的事件

Lyra技能提供了额外的蓝图事件，能够处理添加到角色或从角色中移除而无需依赖激活的技能。这些对于初始设置和清理很有用。

| 蓝图事件 | 说明 |
| --- | --- |
| 添加技能时（On Ability Added） | 赋予该技能后立即调用该事件。头像（Avatar）或输入组件（Input Component）可能尚未生效，因此请注意你访问的内容。 |
| Pawn头像集有效时（On Pawn Avatar Set） | 当Pawn完全初始化并且其头像和输入组件都有效时调用。 |
| 移除技能时（On Ability Removed） | 当该技能即将从ASC中移除时（通常是由于Pawn未被控制或被摧毁）调用此事件 |

### 摄像机模式

Lyra技能可以通过Set Camera Mode和Clear Camera Mode Blueprint节点覆盖摄像机模式。例如，在Pawn死亡时使用死亡摄像机模式，由 **GA_Hero_Death** 技能触发。

### 类型标签

Lyra的技能通常在其"技能标签（Ability Tags）"属性中包含一个类型Gameplay标签，以将它们按层级分类。这种类型的标签广泛用于管理阻止、取消和其他技能所需的标签设置，或通过标签关系系统使用。

例如，以角色为中心的操作技能包括类型标签，例如 'Ability.Type.Action.Dash' 和 'Ability.Type.Action.Jump' 。但也有一些被动技能比带有 'Ability.Type.Passive.AutoRespawn' 等标签的角色更持久。 角色死亡将取消所有其他角色操作技能，而不会影响其他一些技能。

### 原生技能子类

某些Lyra技能具有C++实现，可以强制执行特定的激活条件、执行复杂的数学逻辑（在蓝图中实现会很麻烦），或者与敏感的低级别Gameplay系统交互。有关一些示例技能，请参见下表。

| Gameplay技能 | 说明 |
| --- | --- |
| ULyraGameplayAbility_Death | 自动配置为触发死亡Gameplay事件。取消所有其他技能，并向Pawn的生命值组件发出信号以开始死亡过程（这反过来会触发其余的游戏通知和状态更改）。 视觉效果由此类的BP技能扩展执行（GA_Hero_Death）。 |
| ULyraGameplayAbility_Jump | 提供在Pawn的角色移动组件上触发Jump和StopJumping输入的功能，同时检查技能所有者是否是有效的、本地控制的Pawn。 |
| ULyraGameplayAbility_Reset | 激活后，此技能会立即将所有权玩家重置为初始生成状态的新Pawn，并取消所有其他技能。 |
| ULyraGameplayAbility_FromEquipment | 提供与Lyra的设备系统交互并检索该技能关联项目的功能。 |
| ULyraGameplayAbility_RangedWeapon | 武器射击的本地实现。与关联武器交互，以便确定弹药数量、命中精度等。提供射线投射功能，以便计算发射椎体内的子弹轨迹，查找和验证命中目标。 |

### 蓝图技能子类

这些是蓝图子类如何利用Lyra中的扩展技能功能的一些示例。

| 蓝图子类 | Gameplay AbilityDescription |
| --- | --- |
| GA_AbilityWithWidget | 所有提供额外UI功能的技能的基类。这样可以管理技能的控件状态，因此它可以显示状态、冷却和其他技能信息。例如，Lyra的近战技能，它具有用于移动平台的自定义触控输入控件。**OnAbilityAdded** 事件将使用UI扩展子系统注册控件扩展，这将保存扩展句柄。**OnAbilityRemoved** 事件取消注册并清除扩展句柄。 |
| GA_Melee | 包含 `Ability.Type.Action.Melee` 的资产标签，在激活时赋予Event.Movement.Melee标签。此技能由标签 `InputTag.Ability.Melee` 触发，当此标签被激活时，激活时（On Activation）事件将按以下顺序提交技能开销： 找到当前装配好的武器，并运行其相关的动画蒙太奇。 检查权限（仅限服务器），然后在玩家面前执行胶囊体追踪。 如果追踪命中Pawn，则会运行其他检查，例如团队比较，以便避免误伤友军，以及会运行辅助检查来确保目标没有被关卡几何体遮挡。 如果记录了有效命中，则角色通过RootMotion力向目标移动。 接下来，对目标施加近战伤害Gameplay效果，并在拥有者身上触发近战命中Gameplay提示。 最后，通过多播RPC在所有客户端上播放近战冲击（Melee Impact）声音。 |
| GA_Weapon_Fire | 拾取相关武器时，通过 **Lyra设备定义** （ **ULyraEquipmentDefinition** ）类中的技能集（Ability Set）赋予射击和填弹技能。激活需求由ULyraGameplayAbility_RangedWeapon类处理，目标逻辑由同一类在C++中完成。武器射击Gameplay技能由标签 `InputTag.Weapon.FireAuto`（输入绑定）和 `Input.Weapon.Fire` 标签（Gameplay事件）激活。如果弹匣是空的，它会被填弹技能设置的 `Ability.Weapon.NoFiring` 标签所禁止。`Ability.Type.Action.WeaponFire` 的资产标签将赋予 `Event.Movement.WeaponFire` 标签。当标签处于激活状态时，添加技能时（On Ability Added）事件将为 `Ability.PlayMontageOnActivateFail.Message` 标签设置监听器。当玩家在没有弹药的情况下尝试射击时，触发此事件。收到消息时，它会运行未能射击蒙太奇（空枪射击）。仅当玩家还活着时才会运行此蒙太奇，并且仅在经过一定时间后才会重新触发动画，以便防止产生动画垃圾信息。当调用 **激活时（On Activation）** 时，如果角色为本地控制，它将执行本地目标追踪并按以下顺序构建目标数据： 技能开销（弹药消耗）为本地提交。 目标数据由网络预测并发送到服务器，由 **ULyraWeaponStateComponent* 验证和确认。 如果服务器确认了目标数据，则调用BP事件 **OnRangedWeaponTargetDataReady**，传递所有找到的目标。这样可实现施加伤害的技能，发挥命中效果。 运行射击动画蒙太奇。 将计时器设置为射击延迟（Fire Delay），这是射击间歇的有效延迟。 当射击延迟或定时器结束时，该技能终止。额外的射击尝试由激活逻辑处理。 **远程武器目标数据就绪时（On Ranged Weapon Target Data Ready）** 当所有被武器击中的目标都经过验证时，从C++调用。这会触发武器所有者的射击Gameplay提示，然后将第一次命中作为参数传递。提示遍历所有命中目标，在每个目标位置运行影响Gameplay提示。如果该技能具有权限（在服务器上执行），它将对每个命中目标施加伤害Gameplay效果。 |
| GA_Weapon_ReloadMagazine | 此Gameplay技能由 `InputTag.Weapon.Reload` 激活，它是 `Ability.Type.Action.Reload` 标签的资产。这将赋予 `Event.Movement.Reload` 标签。激活时，它将限制移动选项。填弹逻辑围绕相关武器上的三个Gameplay标签堆栈展开。`Lyra.ShooterGame.Weapon.MagazineSize` 是当前武器每个弹匣允许的最大弹药量。`Lyra.ShooterGame.Weapon.MagazineAmmo` 是当前弹匣中的剩余弹药量。数量为零时，武器必须填弹才能继续射击。`Lyra.ShooterGame.Weapon.SpareAmmo` 是未处于当前弹匣中的剩余弹药量它将覆盖 `K2_CanActivateAbility` 函数，该函数是以下激活检查逻辑的蓝图实现： 检查 `MagazineAmmo` 是否小于 `MagazineSize` 。如果为false，则弹匣已满，不应继续填弹。 检查 `SpareAmmo` 是否大于零。如果为false，则玩家没有此武器的弹药。 技能激活时（On Activation）： 检查关联项目的 `MagazineAmmo` 堆栈计数。如果当前弹匣中没有剩余弹药，它会应用一个标签来禁止激活武器射击技能。 运行武器填弹动画蒙太奇，然后监听 `GameplayEvent.ReloadDone` 事件。此事件通过人体模型蒙太奇上的动画通知（Animation Notify）发送。 收到事件后，检查权限（服务器），然后执行填弹逻辑，这只是更改角色物品栏关联武器中 `Lyra.ShooterGame.Weapon.MagazineAmmo` 和 `Lyra.ShooterGame.Weapon.SpareAmmo` 的值。然后终止技能。 如果由于某种原因未处理该事件，则该技能会在蒙太奇停止或中断后在本地终止。调用终止技能时（On End Ability），以便移除在激活时设置的射击禁止标签（如果早先已设置）。 |
| GA_Grenade | 此技能由 `Ability.Type.Action.Grenade` 的 `InputTag.Weapon.Grenade` 资产标签激活。这将使用 **GE_Grenade_Cooldown** 作为冷却效果。Pawn头像集生效时（On Pawn Avatar Set）会使用本地客户端上的UI扩展子系统注册控件，确保每个技能实例仅添加一个控件。激活时（On Activation）将检查技能开销和冷却并提交它们。如果任一检查失败，该技能将终止。然后，它将在以下过程中执行： 提交技能开销和冷却。 计算手榴弹生成位置和旋转。 检查权限。如果权限在服务器上，则它会以计算出的值生成手榴弹Actor，并将所有权Lyra角色设置为发起者。 生成的B_Grenade Actor负责进行爆炸检查并应用相关的Gameplay效果。 B_Grenade在与敌方Pawn碰撞时自动引爆。它会误伤发起角色（即投掷手榴弹的角色），但不会误伤队友。 运行投掷手榴弹蒙太奇，然后通过Gameplay消息子系统广播剩余的冷却时间，因此相关控件可以同步其冷却显示。 立即终止技能，无需等待蒙太奇完成。 技能移除时（On Ability Removed）将取消注册并清除UI扩展。 |
| GA_ADS （瞄准射击(Aim Down Sights)） | 从 **GA_AbilityWithWidget** 继承，以便处理HUD显示按钮。此技能由 `InputTag.Weapon.ADS` 标签激活，该标签是 `Ability.Type.Action.ADS` 的资产标签，赋予的是 `Event.Movement.ADS 标签。激活时，它是本地预测的，这意味着它会立即在客户端上运行，然后服务器同步跟进。激活时（On Activation）： 应用自定义摄像机模式来缩小视野（FOV）。 缓存并覆盖角色的步行速度。因为该技能是在本地预测的，所以它将在所有权客户端和服务器上运行，然后复制到非本地客户端。 应用临时输入映射上下文，将移动输入覆盖为具有较低乘数的输入。通过降低输入级，任何进一步的移动输入都会产生较低的加速度，并以较低的加速度值复制到服务器，从而强制角色在瞄准时行走。 对于本地玩家，会更新UI并播放"瞄准开始"的音效。 等待直到输入按钮释放，一旦释放，技能就会终止。 技能终止时： 清除自定义摄像机模式。 如果在本地控制，UI会更新并播放"瞄准结束"的音效。 恢复受控角色的步行速度，并移除输入映射上下文，以便恢复正常的移动速度。 |
| GA_Hero_Dash | 从GA_AbilityWithWidget继承。此技能由 `InputTag.Ability.Dash` 激活，该标签是 `Ability.Type.Action.Dash` 的资产标签。 这样可赋予 `Event.Movement.Dash`。 激活时它会使用冷却效果：**GE_HeroDash_Cooldown**：激活时冷却： 检查技能开销。如果可以支付开销，则提交开销，否则该技能终止。 检查本地控制，并在服务器上终止技能。 在本地客户端中，根据输入和视线方向选择冲刺方向。如果没有移动输入，则该技能在客户端上终止（只有在有冲刺方向输入时，才会发生冲刺）。 根据移动方向和角色的方向选择要播放的动画蒙太奇。 如果角色蹲伏，则使角色解除蹲伏。 如果该技能没有权限（本地客户端），则通过服务器RPC复制冲刺方向和选择的蒙太奇。 在所有权客户端和服务器上，运行所选的蒙太奇，然后在冲刺方向上施加根骨骼运动。 通过消息传递子系统发送消息，以便客户端UI可以同步其冷却时间。 在服务器上，触发冲刺效果Gameplay提示，以便将其复制到所有客户端 当根骨骼运动力完成后，再延迟一段时间，然后该技能终止。这可以使赋予的技能标签保留更长时间，并禁止其他动作，例如射击或跳跃。 |
| GE_InstantHeal | 由 **B_AbilitySpawner** 赋予，它有一个ALyraWeaponSpawner类，该类将覆盖 **GiveWeapon** 函数，以便将Gameplay效果应用到接收Pawn并应用即时治疗Gameplay效果。 |

## FLyraGameplayEffectContext

**Lyra Gameplay效果上下文（Lyra Gameplay Effect Context）** 将扩展自GAS提供的默认 **Gameplay效果上下文（Gameplay Effect Context）** （ **FGameplayEffectContext** ）结构体，用于定义要发送到 **Gameplay提示通知（Gameplay Cue Notifies）** 的附加数据成员和函数。 因为FGameplayEffectContext是结构体类型，所以需要虚幻和Gameplay技能系统（Gameplay Ability System）都能正确识别的替换类型。Lyra Gameplay效果上下文将覆盖多个函数：

| 函数 | 说明 |
| --- | --- |
| Duplicate() | 执行HitResults和其他无法进行内存复制的成员的深拷贝。 |
| GetScriptStruct() | 返回 `FLyraGameplayEffectContext::StaticStruct()`，以便向蓝图提供正确的反射数据。 |
| NetSerialize() | 为定义的所有额外成员添加复制。 |

为Lyra Gameplay效果上下文定义结构体模板（`TStructOpsTypeTraits<>`）。这个辅助结构体将绑定复制和序列化功能，并使它们可用于复制系统。

**Lyra技能系统全局** （ **ULyraAbilitySystemGlobals** )类可扩展 **技能系统全局** （ **UAbilitySystemGlobals** ）类，并覆盖 `AllocGameplayEffectContext()` 函数，以便构造和返回Lyra Gameplay效果上下文结构体。

这样可确保无论何时创建新Gameplay效果上下文对象，Gameplay技能系统都会分配扩展后的结构。

#### 包括哪些额外数据？

目前，Gameplay效果上下文结构体提供了与射击游戏核心（Shooter Core）的远程武器命中相关的唯一子弹ID，并提供了额外的实用程序来访问物理材质和技能源对象。

#### 如何访问额外的数据？

因为它是一种结构体，Lyra Gameplay效果上下文（Lyra Gameplay Effect Context）结构体不能直接包含访问其数据的蓝图公开函数。

解决此限制的一种方法是将访问器（accessor）作为蓝图函数库中的静态函数实现，将上下文句柄作为输入参数传递，然后在内部将其转换为派生结构体类型。

辅助函数 `FLyraGameplayEffectContext::ExtractEffectContext` 负责将上下文指针转换为专用类型。目前，这在 `FLyraGameplayAbilityTargetData_SingleTargetHit` 结构中使用。

你可以使用类似方法来转换通过 `FGameplayCueParameters` 传递给Gameplay提示（Gameplay Cue）的效果上下文句柄（Effect Context Handle），从而允许访问额外的功能。

## ULyraAttributeSet

**Lyra属性集** （ **ULyraAttributeSet** ）从默认的属性集类扩展而来。此Lyra特定基类提供了方便的 `ATTRIBUTE_ACCESSORS` 宏来自动化Gameplay属性（Gameplay Attribute）的属性值和获取（Get）、设置（Set）和初始化（Initialize）功能的值。

`FLyraAttributeEvent` 用于在属性集（Attribute Set）级别简化属性更改事件。

| 函数 | 说明 |
| --- | --- |
| GetWorld() | 用于引用世界的便捷getter函数。 |
| GetLyraAbilitySystemComponent() | 用于引用Lyra技能系统组件的便捷getter函数。 |

Lyra提供了两个专门的属性集类：

### ULyraHealthSet

**Lyra生命值集** （ **ULyraHealthSet** ）包括以下管理角色当前和最大生命值的属性：

| 属性 | 说明 |
| --- | --- |
| 生命值（Health） | 当前生命值，上限为MaxHealth。 |
| 最大生命值（MaxHealth） | 确定允许的最大生命值。 |
| 治疗（Healing） | 累加应用于角色的治疗量。将影响生命值，然后自动重置为零。 |
| 伤害（Damage） | 累积施加到角色的伤害量。将影响生命值。 |

此属性集还负责将当前生命值限制为MaxHealth，并跟踪生命值何时耗尽。它实现了 `FLyraAttributeEvent` 委托，此托会在生命值耗尽时触发。

其他类绑定到此委托以便接收生命值不足通知，例如 `ULyraHealthComponent` ，它负责处理死亡并将生命值公开给游戏。

### ULyraCombatSet

**Lyra战斗设置** （ **ULyraCombatSet** ）提供伤害和治疗支持。Gameplay效果将负责修改这些属性之一，或依靠Lyra的自定义执行来调整总生命值。

| 属性 | 说明 |
| --- | --- |
| BaseDamage： | 伤害执行中要造成的基本伤害量。它将作为输入值馈送给伤害执行计算过程，从而确定实际造成的伤害。 |
| BaseHeal： | 执行运行时要恢复的生命值量。 |

### 治疗和伤害的运行机制

默认情况下，生命值属性对修饰符是隐藏的，因此它不能像常规属性那样直接通过Gameplay效果（Gameplay Effects）更改。相反，它的值是通过治疗（Healing）属性和自定义执行 **ULyraHealExecution** 和 **ULyraDamageExecution** 间接设置的。

将伤害和治疗视为属性的优势在于，你可以将单个伤害实例与修改后的属性分离，并使伤害值更容易使用。它有助于防止意外修改重要属性。因为生命值对Gameplay效果修饰符是隐藏的，所以不存在在其基础值之上应用定时或无限效果的风险，从长远来看，这种风险可能会导致问题。

#### 治疗执行

ULyraHealExecution对源上的 **BaseHeal** 属性拍快照，然后将其限制为零，以防止负治疗。最后，它会修改 **目标（Target）** 的生命值（Health）属性。因为这是在源代码中完成的，所以修改生命值不会出现问题。

#### 伤害执行

ULyraDamageExecution将计算 **基础伤害（BaseDamage）** 和 **生命值（Health）** 属性值。BaseDamage在源捕获并生成快照，而生命值在目标捕获。然后它将检查影响位置（从而知道产生伤害数字效果的位置）。

它会检查目标团队的友军误伤情况，并根据距离和物理材质应用衰减。最后，它会修改目标（Target）的生命值（Health）属性。因为这是在源代码中完成的，所以修改生命值不会出现问题。

伤害数字Gameplay提示设置为将生命值（Health）属性的变化作为其幅度接收，并从其原始（未标准化）值导出显示。

## 其他信息

### 伤害数字如何工作？

当一个损害技能被激活时，它会运行测试来确定击中对象，然后该技能会对目标Actor施加伤害Gameplay效果。

**GameplayEffectParent_Damage_Basic**（或所有继承自它的子项）由武器投射和手榴弹施加。然后，通过执行（Execution）施加伤害，执行将基础伤害转换到生命值，并过滤友军火力，然后Gameplay提示 `GameplayCue.Character.DamageTaken` 按幅度应用于 `LyraHealthSet.Health` 提示。

在客户端上调用 **GCN_Character_DamageTaken** 。仅当效果发起者是本地玩家时才会显示。伤害由Gameplay提示的原始幅度决定。 位置由命中结果的位置值确定，这些值被传递给本地控制器的ULyraNumberPopComponent。该组件将处理显示和池化问题，并在命中位置生成和配置Niagara发射器以显示实际伤害。

### Lyra角色如何初始化？

由于Pawn的控制流程、游戏功能注册和各种复制的游戏框架值之间存在交互，可操作角色的初始化流程并非始终可预测：事件可能会次序颠倒，而客户端仍在等待服务器数据。

Lyra通过实现 **UPawnExtensionComponent** 解决了此问题。其主要作用是确保在赋予Pawn的AbilitySet和激活出生时（On Spawn）Lyra技能之前满足Pawn的所有相关初始化条件。

Pawn扩展组件还将跟踪由于Pawn而被赋予的所有技能，并在角色被摧毁或未被控制时，将其从控制者的玩家状态中删除。

你可以通过 **ULyraPawnData** 资产将技能集指定给Pawn。这些可以从内容浏览器创建，默认的Pawn数据由[体验定义](https://docs.google.com/document/u/0/d/1GmJTjn6aeoXnn-eszLfWH25ysW_ps574bB2e64kgtl8/edit)决定。

要初始化Pawn并指定其技能，必须满足以下条件：

- 默认Pawn数据有效。
- Pawn由有效的本地控制器控制或具有服务器权限。
- 相关的玩家状态和输入组件已复制到Pawn，并且为有效状态。

## 蓝图资产命名规范

| 缩写 | 含义 |
| --- | --- |
| GA_ | Gameplay技能 |
| GE_ | Gameplay效果 |
| GCN_ | Gameplay提示通知（UGameplayCueNotify） |
| GCNL_ | 潜在Gameplay提示通知（继承自AGameplayCueNotify_Actor和子类。） |
| Phase_ | 游戏阶段技能 |
| AbilitySet_ | 技能集 |
| IA_ | 输入操作 |
| InputData_ | Lyra输入配置 |
| W_ | 控件UI |
| B_ | 所有其他蓝图，例如Pawn类型、项目生成器等。 |
