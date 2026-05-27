---
title: "动画通知"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/animation-notifies-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "动画资产和功能", "动画序列", "动画通知"]
---

# 动画通知

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / 动画资产和功能 / 动画序列 / 动画通知

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/animation-notifies-in-unreal-engine

**动画通知（Animation Notifications）**（简称通知）可用于创建同步到 **动画序列（Animation Sequences）** 的可重复事件。这些事件可以是声音（例如，行走或奔跑动画的脚步声）、生成粒子和其他类型。动画通知有许多不同的用途，并且可以使用自定义类型进行扩展。

本文介绍了不同类型的动画通知、创建方法以及各种使用方法。

#### 先决条件

- 动画通知在

  动画序列

  中创建，因此你的项目需要

  骨骼网格体（Skeletal Mesh）

  和

  动画序列（Animation Sequence）

  。

## 入门指南

动画通知通常在动画序列中访问和创建。首先，打开 **动画序列资产（Animation Sequence Asset）** ，然后在时间轴中找到 **通知（Notifies）** 轨道。

![通知轨道](../../../../../../assets/images/a9/a9bb6594dfb85e73d126d2ac522b766cd8229f5a549437cfa877b4fd76166a57.png)

通知轨道本身是下面各个子轨道的父组，这些子轨道包含实际的通知关键帧。默认情况下，应该存在单个子轨道（名为 **1** ）。如果不存在子轨道，或者你想添加额外的通知轨道，请在通知轨道上点击 **添加轨道（Add Track (+)）> 添加通知轨道（Add Notify Track）** 。

![子通知轨道](../../../../../../assets/images/85/8561d86d6ca114238bee2af6cf383faf8c26c39c0d9a44eea4e06c28aa179517.png)

> [!NOTE]
> 你还可以插入或删除通知轨道，只需在子轨道本身上点击 **添加轨道（Add Track (+)）** 下拉菜单，并选择 **插入通知轨道（Insert Notify Track）** 或 **删除通知轨道（Remove Notify Track）** 即可。
>
> ![插入和删除通知轨道](../../../../../../assets/images/d6/d6edce73cf6846d528024374ba2ed68dd864890a51622b04abe007cfbe951cd1.png)

要重命名通知轨道，请三击轨道文本以启用文本编辑。

> 动图已省略：重命名通知轨道

## 动画通知类型

可创建的动画通知有多种类型，创建通知时右键点击通知轨道的时间轴区域，即会显示这些类型。

![动画通知类型](../../../../../../assets/images/f9/f99de2678c1a659dfff0d32cb1268a4d986b66384379a5dec490839ac2f502d2.png)

### 通知

你可以创建的最基本的动画通知类型称为 **通知（Notify）** ，它会使不同的预制事件在指定时间触发。查看 **添加通知…（Add Notify…）** 菜单时，可以找到以下通知。选择其中一项将在光标处创建通知关键帧。

![通知](../../../../../../assets/images/9a/9aff780baf59489c64d2ce27d5e310b8ddc0f27389b4836385cfbff64e9a7e77.png)

在时间轴中拖动通知关键帧可进行编辑。你还可以按住 **Shift** 键，这会将 **播放头（Playhead）** 与通知同步移动，方便将通知与动画中的特定时间对齐。

> 动图已省略：与通知交互

#### 粒子效果

**粒子效果（Particle Effect）** 通知用于生成和播放非循环粒子系统。你可以选择以下任一项：

- 播放Niagara粒子效果（Play Niagara Particle Effect）

  ，它会生成

  Niagara粒子

  。
- 播放粒子效果（Play Particle Effect）

  ，它会生成

  旧版级联粒子

  。

此通知适合用于创建可重复的粒子效果，例如角色跳跃后着地时的效果，骨骼网格体武器的射击效果，或其他类似效果。

> 动图已省略：粒子通知

选择粒子通知关键帧时，以下相关属性位于 **细节（Details）** 面板中：

![粒子通知属性](../../../../../../assets/images/91/913c608ff6be161a5a6da1d45c10f2c27aea5c92c582de4475f919784d4dc451.png)

| 名称 | 说明 |
| --- | --- |
| **粒子系统/Niagara系统（Particle System / Niagara System）** | 要为此通知生成的级联或Niagara系统。 |
| **位置/旋转/比例偏移（Location / Rotation / Scale Offset）** | 用于从生成点偏移系统的位置、旋转和比例变换属性的数组。 |
| **附加（Attached）** | 在[插槽](../../skeletons/skeletal-mesh-sockets/index.md)上生成时，启用该属性会使粒子系统在整个时长内跟随插槽。禁用该属性仍会在插槽位置生成粒子系统，但系统不会继续跟随该插槽。 |
| **插槽名称（Socket Name）** | 你可以在此处指定骨骼或[插槽](../../skeletons/skeletal-mesh-sockets/index.md)，在该位置生成粒子系统。如果此处没有指定任何内容，则系统会在对象的根骨骼处生成。 |

#### 声音

**声音（Sound）** 通知用于从导入的声波、[Sound Cue](../../../../../working-with-audio/sound-source/sound-cue/index.md)和[MetaSound](../../../../../working-with-audio/sound-source/metasounds/index.md)播放音效。这些通知适合用于将拟音类型的声音同步到动画，例如脚步声、布料活动声和类似的可重复声音。

选择声音通知关键帧时，以下相关属性位于 **细节（Details）** 面板中：

![声音通知](../../../../../../assets/images/8e/8ee52b8dd0345c33b4478d68fb587d3f2f453c142581ba44b38ddb21df57838d.png)

| 名称 | 说明 |
| --- | --- |
| **声音（Sound）** | 要为此通知播放的声音资产。可以选择以下资产： 声波 Sound Cue MetaSound 声音总线 |
| **音量乘数（Volume Multiplier）** | 用于提高或降低所播放声音的音量的乘数。 |
| **音高乘数（Pitch Multiplier）** | 用于提高或降低所播放声音的音高的乘数。 |
| **跟随（Follow）** | 如果启用该属性，动画网格体移动时音效源会跟随。如果禁用该属性，声音会保持在所生成位置之后。 |
| **预览忽略衰减（Preview Ignore Attenuation）** | 如果启用该属性，播放声音时会禁用[声音衰减](../../../../../working-with-audio/spatialization-and-sound-attenuation/sound-attenuation/index.md)。此设置仅限用于编辑器，不会影响播放或模拟游戏时的正常声音衰减操作。 |
| **附加名称（Attach Name）** | 如果禁用 **跟随（Follow）** ，你可以指定要附加到的骨骼或插槽。如果此处没有指定任何内容，则声音会在对象的根骨骼处生成。 |

#### 服装模拟

**服装模拟（Clothing Simulation）** 通知用于暂停、恢复和重置角色的布料模拟。如果你要在动画期间传送角色并需要暂停或重置布料求值，这些通知会很有用。如果动画导致布料模拟反应过度，这些通知也很有用。

> 动图已省略：布料通知

可以选择以下通知：

- 暂停服装模拟（Pause Clothing Simulation）

  ，这会暂停模拟。
- 恢复服装模拟（Resume Clothing Simulation）

  ，这会在暂停后恢复模拟。
- 重置服装模拟（Reset Clothing Simulation）

  ，这会将模拟初始化回默认引用姿势。

#### 重置动态效果

**重置动态效果（Reset Dynamics）** 通知可用于将此骨骼网格体上使用的任意[AnimDynamics](../../../../skeletal-mesh-an-2df34997/animation-blueprints/animation-blueprint-nodes/animation-bluep-7b8b20e5/animation-bluep-ec3334f1/index.md)恢复为原始状态。如果动画会导致AnimDynamic模拟反应过度或进入看起来破裂的状态，此通知会很有用。

### 骨架通知

**骨架（Skeleton）** 通知是[骨架资产](../../skeletons/index.md)上保存的自定义通知，然后用作[动画蓝图](../../../animation-blueprints/index.md)中的事件。这些通知适合用于创建你想让通知执行的任意蓝图逻辑。

要创建骨架通知，请右键点击通知轨道，然后选择 **添加通知（Add Notify）> 新通知…（New Notify…）**

![骨架通知](../../../../../../assets/images/dc/dcbdef030c9a877450f82eacee794cc9db0bdff107e428d950525af18f89486a.png)

系统将提示你为新创建的通知输入名称。对其命名，然后按 **Enter** 键创建骨架通知。

> 图片已省略：骨架通知创建

> [!NOTE]
> 骨架通知存储在 **骨架资产（Skeleton Asset）** 上。因此，当你创建骨架通知时，你也是在编辑[骨架](../../skeletons/index.md)，这需要你进行保存。

你还可以将已有的骨架通知添加到时间轴，方法是右键点击通知轨道，然后从 **添加通知（Add Notify）> 骨架通知（Skeleton Notifies）** 菜单中选择一个通知。

> 图片已省略：添加已有骨架通知

骨架通知用作[事件图表](../../../animation-blueprints/graphing-in-animation-blueprints/index.md#%E4%BA%8B%E4%BB%B6%E5%9B%BE%E8%A1%A8)或[过渡图表](../../../animation-blueprints/transition-rules/index.md)中的动画蓝图中的 **通知事件（Notify Events）** 。要添加 **骨架通知事件（Skeleton Notify Event）** ，请右键点击你的 **动画蓝图（Animation Blueprint）** 的 **事件（Event）** 或 **过渡图表（Transition Graph）** ，并从 **添加动画通知事件（Add Anim Notify Event）** 菜单选择 **通知（Notify）** 。这会将事件节点添加到相应图表，当通知从其所在的动画调用时，将执行该图表。

!骨架通知动画蓝图事件](SkelNot4.png)(convert:false)

### 通知状态

**通知状态（Notify States）** 的运作方式类似于标准通知，但它们在一段时长内运行，而不是在单个事件内运行。因此，它们提供了三个不同的事件：**开头** 、 **更新** 和 **结尾** 。创建[通知状态子类](#%E8%87%AA%E5%AE%9A%E4%B9%89%E9%80%9A%E7%9F%A5%E7%B1%BB)时，可以访问这些事件。

与标准通知类似，它们提供了多种不同的预制类可供选择。查看 **添加通知状态…（Add Notify State…）** 菜单时，你可以找到以下通知。选择其中一项将在光标位置处创建通知关键帧。

> 图片已省略：动画通知状态

类似于普通通知，在时间轴中拖动通知状态关键帧可进行编辑。你可以拖动开头或结尾来编辑范围，或者拖动整个通知。

> 动图已省略：与状态关键帧交互

#### 定时粒子效果

类似于[粒子效果](#%E7%B2%92%E5%AD%90%E6%95%88%E6%9E%9C)通知， **定时粒子/Niagara效果（Timed Particle / Niagara Effects）** 通知用于在动画期间播放粒子。主要区别在于，如果粒子设置为循环，你还可以定义粒子的时长。可以选择以下粒子通知类型：

- 定时粒子效果（Timed Particle Effect）

  ，它会生成

  旧版级联粒子

  。
- 定时Niagara效果（Timed Niagara Effect）

  ，它会生成

  Niagara粒子

  。
- 高级定时Niagara效果（Advanced Timed Niagara Effect）

  ，它会生成Niagara粒子，并提供用于在其中驱动参数的额外选项。

定时粒子通知与普通粒子效果通知拥有相同的细节，但高级定时Niagara通知包含以下额外属性：

> 图片已省略：定时粒子通知

| 名称 | 说明 |
| --- | --- |
| **启用规格化通知进度（Enable Normalized Notify Progress）** | 启用该属性后，会导致通知状态在通知的时长内将规格化(0-1)的值输出到 **用户参数（User Parameter）** 中指定的Niagara[用户参数](../../../../../visual-effects/getting-started-in-niagara-effects/overview-of-niagara-effects/index.md#%E5%8F%82%E6%95%B0%E5%92%8C%E5%8F%82%E6%95%B0%E7%B1%BB%E5%9E%8B)。参数从 **0** 开始，并在通知完成时内插到 **1** 。如果你想将特定粒子参数链接到通知的生命周期，该属性很有用。 |
| **用户参数（User Parameter）** | 启用 **启用规格化通知进度（Enable Normalized Notify Progress）** 时要驱动的Niagara用户参数的名称。 |
| **动画曲线参数（Anim Curve Parameters）** | 这是一个数组，其中你可以将[动画曲线](../animation-curves/index.md)值链接到Niagara用户参数。你可以点击 **添加（Add (+)）** ，将项目添加到该数组中，然后指定以下属性： **动画曲线名称（Anim Curve Name）** ，这是驱动Niagara参数的动画曲线。 **Niagara用户浮点（Niagara User Float）** ，这是动画曲线控制的Niagara用户参数。 |

#### 尾迹

**尾迹（Trail）** 通知类似于定时粒子效果，会在通知的时长内生成粒子系统。其不同之处在于，它主要用于[AnimTrail级联粒子](https://youtu.be/5HkghxEIXiU)**，** 并且包含额外属性，用于控制尾迹附加和属性。

> 动图已省略：尾迹通知

选择尾迹通知将在 **细节（Details）** 面板中显示以下属性。

> 图片已省略：尾迹通知细节

| 名称 | 说明 |
| --- | --- |
| **PSTemplate** | 要使用的AnimTrail级联粒子系统。 |
| **第一个/第二个插槽名称（First / Second Socket Name）** | 你可以在此处为每个属性指定单独的骨骼或插槽，用于为AnimTrail定义附加点。这还基于这两个附加点之间的距离定义了尾迹的默认宽度。 |
| **宽度缩放模式（Width Scale Mode）** | 如果使用了 **宽度缩放曲线（Width Scale Curve）** ，这定义了尾迹宽度的相对缩放点。你可以选择以下选项： 从中心，这会相对于两个插槽之间的 **中心点** 缩放尾迹。 从第一个插槽，这会相对于 **第一个插槽** 的位置缩放尾迹。 从第二个插槽，这会相对于 **第二个插槽** 的位置缩放尾迹。 |
| **宽度缩放曲线（Width Scale Curve）** | 你可以选择在此处指定[动画曲线](../animation-curves/index.md)，可用于在动画期间对尾迹的缩放宽度制作动画。采用值 **1.0** 将维持默认宽度，采用更高数字将增加宽度，采用更低数字则降低宽度。 |
| **渲染几何体（Render Geometry）** | 启用主尾迹几何体的渲染，将该属性保持启用。 |
| **渲染生成点（Render Spawn Points）** | 为尾迹启用主生成点的调试渲染。 |
| **渲染切线（Render Tangents）** | 启用曲线切线的调试渲染。 |
| **渲染曲面细分（Render Tessellation）** | 启用曲线上所有顶点的调试渲染，显示曲线如何在生成点之间进行曲面细分。 |

### 同步标识

同步标识是用于告知[基于标识的动画同步](../../../animation-blueprints/animation-sync-groups/index.md#%E5%9F%BA%E4%BA%8E%E6%A0%87%E8%AF%86%E7%9A%84%E5%90%8C%E6%AD%A5)的通知，适合用于将动画混合在一起，并使总体运动保持同步。类似于[骨架通知](#%E9%AA%A8%E6%9E%B6%E9%80%9A%E7%9F%A5)，同步标识会保存到骨架资产，这需要你在添加它们时保存骨架。你可以在混合时想要同步的任意动画中反复使用相同的同步标识。

> 图片已省略：同步标识通知

如需详细了解如何使用同步标识，请参阅[同步组](../../../animation-blueprints/animation-sync-groups/index.md)页面。

## 蒙太奇通知

创建[动画蒙太奇](../../animation-montage/index.md)时，有更多动画通知类型可用来支持特定于蒙太奇的工作流程。蒙太奇中可以添加以下通知：

- 蒙太奇通知（Montage Notify）

  ，右键点击通知时间轴并选择

  添加通知（Add Notify）> 蒙太奇通知（Montage Notify）

  即可添加。
- 蒙太奇通知窗口（Montage Notify Window）

  ，右键点击通知时间轴并选择

  添加通知状态（Add Notify State）> 蒙太奇通知窗口（Montage Notify Window）

  即可添加。
- 禁用根骨骼运动（Disable Root Motion）

  ，右键点击通知时间轴并选择

  添加通知状态（Add Notify State）> 禁用根骨骼运动（Disable Root Motion）

  即可添加。

### 蒙太奇通知

**蒙太奇通知（Montage Notify）** 的运作方式类似于标准通知，会在到达通知关键帧时执行一个事件。到达时，**通知开始时（On Notify Begin）** 事件会在[Play Montage](../../animation-montage/animation-montage-editor/index.md#%E6%92%AD%E6%94%BE%E5%8A%A8%E7%94%BB%E8%92%99%E5%A4%AA%E5%A5%87)蓝图函数上执行。这需要使用 **Play Montage** 节点而不是 **Play Anim Montage** 节点播放蒙太奇。

> 图片已省略：蒙太奇通知

### 蒙太奇通知窗口

**蒙太奇通知窗口（Montage Notify Window）** 的运作方式类似于通知状态，即通知在你定义的时长内运行。这会导致 **通知开始时（On Notify Begin）** 和 **通知结束时（On Notify End）** 都在到达通知的开头和结尾时执行。这需要使用 **Play Montage** 节点而不是 **Play Anim Montage** 节点播放蒙太奇。

> 图片已省略：蒙太奇通知窗口

### 禁用根骨骼运动

**禁用根骨骼运动（Disable Root Motion）** 的运作方式类似于通知状态，即通知在你定义的时长内运行。此通知会抑制根骨骼运动，允许通过用户输入在相应时长内控制角色。如果你想在蒙太奇的某一段时间内允许输入控制（默认情况会锁定输入），这会很有用。

> 图片已省略：禁用根骨骼运动

## 管理通知

在你创建和使用动画通知时，有多个功能和属性可用于自定义你的工作流程和通知行为。

### 关键帧编辑

右键点击你的通知关键帧可查看其信息和命令。上下文菜单显示以下内容：

> 图片已省略：通知关键帧属性

| 名称 | 说明 |
| --- | --- |
| **通知开始时间（Notify Begin Time）** | 此通知放入动画的时间（以秒为单位）。 |
| **通知帧（Notify Frame）** | 此通知放入动画的时间（以帧为单位）。 |
| **最小触发权重（Min Trigger Weight）** | 确定动画要触发通知所需具备的权重（介于 **0** 到 **1** 之间）。仅当动画与另一个动画混合时，该属性才有意义。采用默认值 **0.00001** 时，即使此动画勉强混入，通知仍将执行。如果将其设置为更高的数字，就必须更完整地混合动画，通知才能成功执行。 |
| **动画通知状态时长（Anim Notify State Duration）** | 此通知状态的时长（以秒为单位）。 |
| **动画通知状态帧（Anim Notify State Frames）** | 此通知状态的时长（以帧为单位）。 |
| **复制（Copy）** | 复制此通知。 |
| **删除（Delete）** | 删除此通知 |
| **替换为通知（Replace with Notify…）** | 将此通知替换为同一类型的另一个通知。 |

要辅助关键帧对齐，右键点击时间轴顶部并启用 **帧（Frames）** 或 **通知（Notifies）** 可启用对齐选项。

> 动图已省略：通知关键帧对齐

### 通用通知属性

除了可以为每种类型的通知修改的属性之外，通知还可以包含以下通用属性：

| 名称 | 说明 |
| --- | --- |
| **通知颜色（Notify Color）** | 设置通知关键帧的颜色。 |
| **应在编辑器中触发（Should Fire in Editor）** | 启用在编辑器中预览时的通知执行。这不会影响正常的Gameplay或模拟。 |
| **通知触发可能性（Notify Trigger Chance）** | 定义通知成功执行的可能性。采用值 **0** 表示通知从不执行，采用 **1** 表示通知总是执行。 |
| **在专用服务器上触发（Trigger on Dedicated Server）** | 启用该属性将导致通知在专用服务器上执行。 |
| **对跟随者触发（Trigger on Follower）** | 如果启用该属性，使用[同步组](../../../animation-blueprints/animation-sync-groups/index.md)时，此通知还会在动画为跟随者时触发。默认情况下，只有"同步组"领导者动画才会执行其通知。 |
| **通知筛选器类型（Notify Filter Type）** | 定义一种方法来筛选通知，用于控制这些通知是否应该执行。你可以按[LOD](../../skeletons/skeletal-mesh-lods/index.md)筛选，并指定要从中筛选通知的最大LOD。 |
| **触发权重阈值（Trigger Weight Threshold）** | 确定动画要触发通知所需具备的权重（介于 **0** 到 **1** 之间）。仅当动画与另一个动画混合时，该属性才有意义。采用默认值 **0.00001** 时，即使此动画勉强混入，通知仍将执行。如果将其设置为更高的值，就必须更完整地混合动画，通知才能成功执行。 |
| **蒙太奇更新类型（Montage Tick Type）** | 使用蒙太奇通知时，该属性将确定如何按照通知的准确性和顺序排序来更新和执行通知。你可以选择以下任一项： **排队（Queued）** ，这种更新方法精确性更低，而且是异步执行的，但性能更高。如果你能接受通知执行时帧存在轻微程度的不准确情况，请选择该选项。 **分支点（Branching Point）** ，这种更新方法更精确，同步执行，成本更高。如果你想确保通知以最大帧准确性执行，请选择该选项。如果你要使用通知执行受控序列中的其他事件，该选项很有用。例如，分支点很适合用于做出改变Gameplay的决策，如基于此通知对决策分支。 |
| **插槽（Slot）** | 使用蒙太奇通知时，该属性将通知链接到特定插槽内的动画，因为[一些蒙太奇可能有多个插槽](../../animation-montage/animation-montage-editor/index.md#%E4%BD%BF%E7%94%A8%E5%A4%9A%E4%B8%AA%E6%8F%92%E6%A7%BD)。 |
| **链接方法（Link Method）** | 使用蒙太奇通知时，该属性定义了将通知链接到动画的方法。链接将导致通知关键帧在经过调整后跟随蒙太奇动画分段。你可以选择以下任一项： **绝对（Absolute）** ，这将禁用自动调整。 **相对（Relative）** ，这将随片段移动通知，但不会在缩放改变时进行调整。 **成比例（Proportional）** ，这将同时随片段位置和缩放而移动和调整。 |
| **链接序列（Linked Sequence）** | 一种只读属性，显示当前链接的动画序列。如果你将通知与多序列蒙太奇中的不同序列对齐，该属性会发生更改。 |

### 动画通知面板

动画通知面板可用于管理你的已有[骨架通知](#%E9%AA%A8%E6%9E%B6%E9%80%9A%E7%9F%A5)。右键点击通知时间轴区域并选择 **管理通知（Manage Notifies）** 可访问它。

> 图片已省略：动画通知面板

你可以右键点击通知并执行以下操作：

> 图片已省略：通知面板选项

| 名称 | 说明 |
| --- | --- |
| **新建（New…）** | 创建新的骨架通知。 |
| **重命名（Rename）** | 重命名当前选择的骨架通知。 |
| **删除（Delete）** | 删除当前选择的骨架通知。 |
| **查找引用（Find References）** | 打开[动画资产浏览器面板](../../../animation-editors/animation-sequence-editor/index.md#%E8%B5%84%E4%BA%A7%E6%B5%8F%E8%A7%88%E5%99%A8)，然后筛选列表，仅显示使用此通知的动画资产。 |

## 自定义通知类

如果你的项目需要的通知类不同于所提供的类，你可以创建自定义通知和通知状态，并采用其自己的预定义蓝图逻辑。通过这种方法，你可以扩展和创建不同的通知模板。

要创建新通知类，请找到[内容浏览器](../../../../../understanding-the-basics/content-browser/index.md)，然后点击 **添加（Add (+)）> 蓝图类（Blueprint Class）** 。找到 **所有类（All Classes）** 分段，选择 **AnimNotify** 创建[通知](#%E9%80%9A%E7%9F%A5)的子类，或选择 **AnimNotifyState** 创建[通知状态](#%E9%80%9A%E7%9F%A5%E7%8A%B6%E6%80%81)的子类。

> 图片已省略：创建新通知类

要开始为 **AnimNotify** 类构建唯一函数，请点击 **我的蓝图（My Blueprint）** 中的 **覆盖（Override）** 函数下拉菜单，并选择 **Received Notify** 。这会打开函数图表，其中你现在可以从 **Received Notify** 条目节点编写自定义逻辑。

> 图片已省略：覆盖received notify函数

你可以在 **AnimNotify** 或 **AnimNotifyState** 类中覆盖和实现以下函数：

| 函数 | 说明 |
| --- | --- |
| **Get Default Trigger Weight Threshold** | 该函数为此通知设置 **触发权重阈值（Trigger Weight Threshold）** 的默认值，但是，可以在[通知关键帧细节](#%E9%80%9A%E7%94%A8%E9%80%9A%E7%9F%A5%E5%B1%9E%E6%80%A7)中覆盖该值。 |
| **Get Notify Name** | 该函数设置时间轴中通知或状态关键帧的名称。 |
| **Received Notify** | 该函数用于标准通知，在到达通知关键帧时执行一次。 |
| **Received Notify Begin** | 该函数用于通知状态，在通知区域开始时执行一次。 |
| **Received Notify End** | 该函数用于通知状态，在通知区域结束时执行一次。 |
| **Received Notify Tick** | 该函数用于通知状态，在通知状态的整个时长内持续执行。 |

创建自定义通知类后，你可以从 **添加通知（Add Notify）** 或 **添加通知状态（Add Notify State）** 菜单将其添加到通知时间轴。

> 图片已省略：通知类
