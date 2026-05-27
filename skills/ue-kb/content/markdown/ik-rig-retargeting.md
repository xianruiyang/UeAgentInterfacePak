# IK Rig Retargeting

---
title: "IK Rig Retargeting"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/ik-rig-animation-retargeting-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "动画资产和功能", "IK Rig", "IK Rig Retargeting"]
---

# IK Rig Retargeting

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / 动画资产和功能 / IK Rig / IK Rig Retargeting

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/ik-rig-animation-retargeting-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

可以使用 **IK Rig** 在不同 **skeletal mesh**之间创建 animation retargeting。这与 Unreal Engine 传统的 [Animation Retargeting](../../skeletons/animation-retargeting/index.md) 功能不同，因为它可以在 bone 数量、bone 名称和朝向各不相同的 skeleton 之间传递动画，同时还可选择使用 IK 保持精确的手部或脚部接触点。

Retargeting animation 提供了一种在多个不同 skeleton 之间共享动画数据的方法，不需要在 UE 外部创建和管理新动画。

本页概述 **IK Retargeter**.

> [!TIP]
> 有关使用 UE 自动 retargeting 工具的信息，请参阅 [IK Retargeter](auto-retargeting/index.md) 文档。

#### 前提条件

- 项目中有两个不同的 skeletal mesh，可用于评估 retargeting 流程。
- 已经创建 IK Rig asset，并在其中定义了 retargeting chain。具体做法请参阅 [Retargeting Bipeds with IK Rig](../../../animation-workflow-guides-and-examples/retargeting-bipeds-with-ik-rig/index.md) 页面。

## 创建与概览

要创建 IK retargeter，请点击 **Add（+）** ，该按钮位于 Content Browser，然后选择 **Animation > IK Rig > IK Retargeter**。随后会出现对话框，必须选择要从中重定向动画的 IK rig。选择后，命名并打开 **IK Retargeter asset**.

![create ik retargeter](../../../../../../assets/images/bb/bbcb43f9bb973b99463f7f48eb44af65d5e0e6cad8cd8fb53566f43d6035106f.png)

IK Retargeter 包含以下工具和选项：

![ik retargeter editor](../../../../../../assets/images/46/46e28f6f491d6a21c95c4fd71e86ed3e382f2f8706e9970068b9849b028841e9.png)

> [!NOTE]
> **Play** 按钮现在位于工具栏上，点击 **Run Retarget** 可播放重定向后的动画。

1. **Toolbar（工具栏）**：可在此保存更改、浏览关联资产等。

   1. **Run Retarget** 和 **Show Retarget Pose** 切换开关；用于在 retarget pose 选项之间切换。
   2. **Asset Settings**；点击可直接在 editor 中显示所选 operation 和总执行成本。
2. **Op Stack** 和 **Hierarchy** 面板：

   - 当设置为 **Op Stack** 时，默认 operation stack 会显示在面板中。选择 **Add New Op**可添加新 operation。高亮 stack 中的 operation 会在 Details 面板中打开该 operation 的设置。
   - 当设置为 **Hierarchy** 时，会显示 character bone 列表。选择角色后，可从 bone 列表中过滤 bone 及其分配的 chain。
3. **Asset Browser**：可在此从 source 中选择动画，在 editor 中预览并导出所选动画。
4. **Retarget Output Log**：显示 debug information、warning 和 error，用于指示 IK Retargeter 的当前状态。
5. **Details** 和 **Preview Settings** 面板：

   - 当设置为 **Details**时，一组设置会显示在面板中。
   - 当设置为 **Preview Settings**时，重定向动画的不同预览会显示在 editor 和 viewport 中。
6. **Viewport**：可在此预览并调试正在重定向的 source 与 target 角色。

## Retarget Chain（重定向链）

在 retarget 流程中要传递的四肢和其它附肢，必须同时在 source 与 target IK rig 上定义. This is a process similar to "characterizing" rig，类似 Autodesk MotionBuilder 或 Maya 等应用中的角色化流程. 主要区别在于这里按 joint chain 定义，而不是按单个 bone 定义. 这样可为骨骼结构差异很大的角色重定向提供灵活性.

例如，如果 target 角色的手臂关节比 source 更多，retargeting 行为仍会正常工作，因为定义的是整条 arm chain，而不依赖 bone 数量。

![retarget chains example](../../../../../../assets/images/d9/d95c6de5b4e76c28a0a11bc313983e6ad7f73b614874f4fa514567d46db898a6.png)

1. Source arm chain。
2. Target arm chain。

### 创建 Chain

可从 [IK Rig Editor](../ik-rig/index.md) 工具栏点击 **Auto Create Retarget Chains**自动创建 retargeting chain。要创建 chain，请打开两个角色的 IK Rig asset，导航到 IK Retargeting 面板，然后执行以下操作：

1. 点击**Add New Chain（+）**.

   ![Select Add New chain from the IK Retargeting panel to add a new chain to your target character](../../../../../../assets/images/4b/4becb40138593144c6fce24d204986039326e9320811df226867beafc519aeff.png)

   Add New Chain
2. 在 **Add New Retarget Chain** 对话框中，确保 **Chain Name** 设置正确，然后点击 **Add Chain**。多数情况下，IK rig 会从其 [common chain names](https://dev.epicgames.com/documentation/en-us/unreal-engine/ik-rig-animation-retargeting-in-unreal-engine#chainpropertiesandnames).

   ![Provide a new name for the Chain Name then select Add Chain.](../../../../../../assets/images/24/24297a846d2df25c7b20c14bf6b9fde161c21760d3d38e81abf7166675a49501.png)

   Add Chain

   > [!NOTE]
   > 通常不需要添加 [IK goal](https://dev.epicgames.com/documentation/en-us/unreal-engine/ik-rig-in-unreal-engine#ikgoals) ，除非 retargeting 需要额外 IK 调整，例如 **Speed Planting**, **Stride Warping**或 **Blend to Source**。选择 **Add Chain and Goal**可向新的 retarget chain 添加 IK goal。之后，系统会提示创建 [IK solver](../ik-rig/index.md#create-solvers) 并决定 solver 的行为。

也可以选择目标 chain 中的每个 bone，在 **Hierarchy** 面板中右键点击它们，然后选择 **New Retarget Chain…**

![Create a new chain from the Hierarchy panel by right-clicking to open the hierarchy dropdown menu and selecting New Retarget Chain...](../../../../../../assets/images/63/63995efb59322abf9693b4051b690dce6cb2e1ae16a0a4e970d26c7b99b45165.jpg)

New Retarget Chain...

### Chain 属性和名称

Chain 需要设置以下 parameter：

| Name | 说明 |
| --- | --- |
| **Chain Name** | 此 chain 的名称。名称可以任意，但应与另一个 IK rig 中目标 retarget chain 的名称匹配。chain 名称匹配过程由 [fuzzy](https://en.wikipedia.org/wiki/Approximate_string_matching) string match. 因此，虽然每个 IK rig 中的 chain 名称不必完全一致，仍应尽量匹配. 例如，chain 名称 `ArmLeft` 可以匹配到 `left_arm`，只要不存在更准确的名称。 |
| **Start Bone** | retarget chain 的起始 Bone。如果正在重定向手臂，通常在这里选择上臂 bone。 |
| **End Bone** | retarget chain 的结束 Bone。如果正在重定向手臂，通常在这里选择手部 bone。 |
| **IK Goal** | 可以选择性地在此选择 [IK Goal](../ik-rig/index.md#ik-goals) ，以便 [稳定 limb 或 chain](index.md) ，这些 limb 或 chain 可能无法准确 retarget。这意味着还需要创建 [Solver（求解器）](../ik-rig/ik-rig-solvers/index.md) 用于这些 goal，并在 retargeting 流程后执行求解. |

**Chain Name** 属性会根据创建 chain 时所选 bone 的名称自动填充。系统会查找常用 bone 名称，然后选择与所选 bone 最匹配的名称。映射列表如下：

| Chain Name Mapping | 要搜索的 Bone 名称 |
| --- | --- |
| **Head（头）** | `head` |
| **Neck（颈）** | `neck` |
| **Leg（腿）** | `leg` `hip` `thigh` `calf` `knee` `foot` `ankle` `toe` |
| **Arm（手臂）** | `arm` `clavicle` `shoulder` `elbow` `wrist` `hand` |
| **Spine（脊柱）** | `spine` |
| **Jaw（颌）** | `jaw` |
| **Tail（尾）** | `tail` `tentacle` |
| **Thumb（拇指）** | `thumb` |
| **索引** | `index` |
| **Middle（中指）** | `middle` |
| **Ring（无名指）** | `ring` |
| **Pinky（小指）** | `pinky` |
| **Root（根）** | `root` |

对于手臂和腿等对称 chain，自动命名功能会比较 chain 中 bone 的平均位置，然后分配前缀 **Left** or **Right**。如果所选 bone 大多位于负 X 侧，则为“Left”；正 X 侧为“Right”；如果它们相对居中于 X 轴，则视为“Center”，不应用前缀。

> [!NOTE]
> 如果为名称相似的 bone 创建多个 chain，后续每条 chain 都会应用数字后缀。例如，如果重定向一个有多个头的生物，结果 chain 会显示为 **Head_1**, **Head_2**和 **Head_3**。可以按需要手动命名 chain，但此约定有助于建立标准命名规范，并使用其它 IK Rig 快速 retarget。

### Pelvis（骨盆）

除了定义 chain，还必须定义 **pelvis（骨盆）** bone。这样可以按比例定义并传递角色的 root motion。

与 chain 一样，pelvis 在 IK Rig Editor 中定义。为此，打开两个角色的 **IK Rig asset** ，导航到 **Hierarchy**面板中右键点击 bone 并选择 **Set Pelvis**.

![Right-click on the Pelvis bone in the HIerarchy panel and select Set Pelvis from the dropdown menu.](../../../../../../assets/images/56/5616d3bd61bdd97fbea720d6d5f9082d723136e867c8c7b72efc0eee8a1e51f4.jpg)

Set Pelvis

完成后，pelvis 会在 **Hierarchy**and the **IK Retargeting** 面板中显示为所选 bone。

![pelvis indication](../../../../../../assets/images/48/48ef36001253a4bf050d4a0568f7d38acdd8b52224824bc578abea53fcd72a57.jpg)

## Retargeting Stack Framework（重定向栈框架）

retarget stack framework 是一组 modular operation，会在从 bone hierarchy 中选择的 bone chain 上求值。retargeting operation 是编辑 skeletal mesh 和重定向动画的更高性能方式。

> 图片已省略：Retargeting Operation Stack

可以通过只选择并排列所选 bone chain 在 retarget pose 或 animation 时所需的 operation，为 retargeter 添加 custom operation。每个 operation 都可在 stack 中重新排序。

某些 operation 具有 operation sub-stack，用于按特定顺序或方法应用 custom logic 和 evaluation，以扩展现有 operation。

所有 retargeting operation 都支持设置 custom LOD threshold。custom LOD threshold 按 operation 设置，可在更高 LOD 下自动跳过高成本步骤。某些 operation 的设置中还包含 debugging 能力。

> [!TIP]
> 可以使用 C++ 创建自己的 op。

请访问 **Retarget Operation Stack** 页面，了解 retargeting operation stack 和各个 operation 的更多信息。

## Retarget Pose（重定向姿势）

根据被 retarget 角色的 reference pose，可能需要以基础 Retarget Pose 的形式编辑该姿势。通常在 target 角色的 reference pose 与 source 不同时需要这样做，例如 target 是 T-pose 而 source 是 A-pose。匹配这些 retarget pose 可以提高 retargeting 精度。

> 图片已省略：retarget pose comparison

1. Source 角色的 reference pose 是 A-Pose。
2. Target 角色的 reference pose 是 T-Pose。

可以通过在工具栏中切换到 **Editing Retarget Pose** 来解决 reference pose 差异，然后使用 **Retarget Pose（重定向姿势）** 工具编辑、导入或导出不同 pose，该工具位于 **Hierarchy** panel.

> 图片已省略：Running Retarget

> 图片已省略：Editing Retarget Pose

Running Retarget（运行重定向）

Editing Retarget Pose

> [!NOTE]
> 点击 **Source** or **Target** 会将 Retarget Pose 工具和 Hierarchy 面板的焦点切换到 source 或 target 角色。

### 创建和编辑 Pose

虽然可以编辑任意 retarget 角色的 **Default Pose** ，但如果需要调整，建议创建新的 retarget pose。为此，请点击 **Create（+）> Create**，为新的 retarget pose 命名，然后点击 **Ok**.

> 图片已省略：create new retarget pose

接下来，确保 **Current Retarget Pose** 设置为新 pose，然后 **启用 Edit Mode**。现在可以在 viewport 中选择并修改 bone，使 pose 匹配。完成后， **禁用**Edit Mode。

> [!NOTE]
> 为了获得额外精度，可以在 **Details**面板中以数值方式修改 retarget pose，其中 rotation 值 0, 0, 0 会将 bone 恢复到 reference pose。

### 导入和导出 Pose

除了手动创建新的 retarget pose，也可以从以下来源导入： [Animation Sequence](../../animation-sequences/index.md) or [Pose Asset](../../animation-pose-assets/index.md).

要从 **Animation Sequence**导入，请点击 **Create（+）> Import from Animation Sequence**。在对话框中，选择要从中导入的 sequence，并设置以下 parameter：

- **Sequence Frame** 定义 animation sequence 中用于生成导入 pose 的具体帧。默认情况下会设置为 **0**，表示使用动画第一帧。
- **Pose Name** 定义导入时 Retarget Pose 的名称。

> 图片已省略：import pose from animation

要从 **Pose Asset**导入，请点击 **Create（+）> Import from Pose Asset**。在对话框中，选择要从中导入的 pose，点击下拉菜单设置要使用的具体 pose 名称，然后选择 **Import Retarget Pose**.

> 图片已省略：import pose from pose asset

也可以将 retarget pose 导出为 **Pose asset** ，以便与项目中的其它 IK Retargeting asset 共享。为此，请点击 **Create（+）> Export Pose Asset**，为资产命名，然后点击 **Save**.

> 图片已省略：export pose asset

### 其它工作流

Retarget Pose 区域还包含以下其它工具，用于辅助创建和编辑 Retarget Pose：

| Name | 说明 |
| --- | --- |
| **Current Retarget Pose** | 显示 Source 或 Target 角色当前使用的 Retarget Pose。初始时只会列出 **Default Pose**，创建新 pose 后会填充列表。可点击下拉菜单选择不同 pose。 |
| **Running Retargeter / Edit Retarget Pose** | 启用后会激活 retargeter，使你可以使用 animation sequence 预览当前 retarget pose 的结果。禁用后会切回 Edit Retarget Pose mode，可在必要时继续细化调整。viewport 会以蓝色轮廓高亮，表示 Edit Retarget Pose mode 已启用。 |
| **Retarget Pose Blend** | 对 retarget pose 进行多处编辑时，预览哪些 bone 发生了哪些变化会很有帮助。为此，可以编辑 Retarget Pose Blend slider。 将其设置为 **0** 会将 pose 改回 Skeletal Mesh 的默认 reference pose。将其设置为 **1** 会将 pose 改为当前 Retarget Pose。 |
| **Reset（重置）** | 可以使用 **Reset（重置）** 菜单将 retarget pose 重置回 skeletal mesh 的默认 reference pose。可选择以下选项：**Reset Selected Bones** 仅重置在 viewport 或 Hierarchy 中选中的 bone。**Reset Selected and Children Bones** 仅重置在 viewport 或 Hierarchy 中选中的 bone 及其子 bone。**Reset All** 重置所有 bone。 |
| **Auto Align** | 自动将 source skeleton 上的 bone 对齐到 target，或将 target skeleton 的 bone 对齐到 source。可选择以下选项： **Align All Bones** 重置 retarget pose，然后使用指定方法自动对齐所有 retargeted bone。**Align Selected** 使用指定方法对齐所选 bone。**Align Selected and Children** 使用指定方法自动对齐所选 bone 及其子 bone（递归）。**Alignment Method** 根据所选方法对齐 bone：**Direction** 对齐 bone 的方向，使其匹配另一个 skeleton 中等效 bone 的方向。使用 chain hierarchy 定义方向向量。**Local Rotation Axes** 对齐 bone 的 local axis，使其匹配另一个 skeleton 中等效 bone 的 local axis。对于旋转方向不同的 skeleton，可能产生无意义结果。**Global Rotation Axes** 对齐 bone 的 global axis，使其匹配另一个 skeleton 中等效 bone 的 global axis。对于旋转方向不同的 skeleton，可能产生无意义结果。**Mesh** 基于加权到该 bone 的顶点主轴，为 bone 生成方向向量。**Snap Character to Ground** 垂直平移整个 skeleton，以恢复其相对地面的原始高度。使用所选 bone 作为落地 limb 的参考点；否则会搜索最低的 retargeted bone。 |
| **Duplicate（复制）** | 可以点击 **Create（+）** > **Duplicate Current**复制当前 retarget pose，然后为新 pose 命名。 |
| **Rename（重命名）** | 可以点击 **Rename（重命名）**，输入新名称，然后点击，以重命名当前 retarget pose。 **Ok**. |

## Hierarchy 显示

Hierarchy 面板会根据启用对象显示 source 或 target 角色的 skeletal hierarchy。Bone 名称会指示它们是否用于 [Retarget Chain（重定向链）](index.md#retarget-chains) ，方式是高亮显示，同时 retarget chain 列会显示正在使用的 chain 名称。

> 图片已省略：hierarchy panel

可以搜索以定位并过滤特定 bone 名称或 retarget chain。

> 图片已省略：hierarchy search

也可以点击 filter 下拉菜单设置以下过滤器：

- **Hide Bones Not in a Chain**：隐藏未在 chain 中使用的 bone，不管 IK retargeter 是否正在使用该 chain。
- **Hide Bones Not Retargeted**：隐藏 IK Retargeter 未使用的所有 bone。
- **Hide Retargeted Bones**：隐藏 IK retargeter 使用的 bone。

> 图片已省略：hierarchy filter

## 预览动画和导出

**Asset Browser** 面板用于在不同资产上预览和导出 retargeting 效果。双击资产可播放。

当 target 角色上的 retargeting 结果令人满意后，可以将动画导出为兼容该角色 Skeleton 的 [Animation Sequence](../../animation-sequences/index.md) 。为此，在 **Asset Browser** 面板中选择要导出的动画，然后点击 **Export Selected Animations**.

> 图片已省略：export selected animations

在导出对话框中选择导出文件夹，然后可选择指定以下重命名属性：

- **Add Prefix**，在新资产名称前添加文本。
- **Add Suffix**，在新资产名称后添加文本。
- **Search for** 和 **Replace with**，搜索文件名中的现有名称，并将其替换为指定名称。搜索和替换不区分大小写。

点击 **Export**以保存 retargeted Animation Sequence。

> 图片已省略：export retargeted animations

## Retargeter 属性和设置

### Asset Settings

当按下 **Asset Settings** 按钮且 **Profile Ops** 已在 Details 面板启用时，每个 operation 的 runtime 会显示在 Details 面板中。

> 图片已省略：Asset Settings

| Name | 说明 |
| --- | --- |
| **Source IKRig Asset** | 要从中复制动画的 source IK rig。 |
| **Source Preview Mesh（源预览网格体）** | source skeletal mesh。可以更改此项，IK retargeting system 会使用名称匹配，尝试让 IK rig 兼容不同 mesh 和 skeleton。 |
| **Target IKRig Asset** | 要将动画复制到的 target IK rig。 |
| **Target Preview Mesh（目标预览网格体）** | target skeletal mesh。可以更改此项，IK retargeting system 会使用名称匹配，尝试让 IK rig 适配所提供的 skeleton 和比例。不兼容项会作为 warning 或 error 打印到 **retarget output log**. |
| **Target Mesh Offset** | 可应用到 target skeletal mesh 的位置 offset，用于使其相对 source 偏移。这有助于同时预览两个角色；如果 target 角色很大，需要更大 offset 时也很有用。 |
| **Target Mesh Scale（目标网格体缩放）** | preview scale modifier，可用于增大或减小 target 角色的 scale。如果 target 相对 source 很小或很大，更改此值可以更方便地让二者尺寸更接近。 |
| **Source Mesh Offset** | 类似于 **Target Mesh Offset**，这是可应用到 source Skeletal Mesh 的位置 offset，用于使其相对 target 偏移。 |
| **Show Source Mesh** | 在 editor viewport 中显示或隐藏 source skeleton mesh。 |
| **Show Target Mesh** | 在 editor viewport 中显示或隐藏 target skeleton mesh。 |
| **Show Source Skeleton** | 在 editor viewport 中显示或隐藏 source skeleton。viewport 必须显示 bone，才能看到 skeleton。 |
| **Show Target Skeleton** | 在 editor viewport 中显示或隐藏 target skeleton。viewport 必须显示 bone，才能看到 skeleton。 |
| **Override Source Skeleton Color** | 覆盖 editor viewport 中 source skeleton 的颜色。 |
| **Source Override Color** | 选择新的 skeleton 颜色。 |
| **Override Target Skeleton Color** | 覆盖 editor viewport 中 target skeleton 的颜色。 |
| **Target Override Color** | 选择新的 skeleton 颜色。 |
| **Ignore Root Lock in Preview** | 当设置为 true 时，带有 **Force Root Lock** 启用的 animation sequence 会表现得像该设置被禁用一样。这只影响 retarget editor 中的预览。使用 ExportRootLockMode 控制导出动画行为。此设置对 runtime retargeting 没有影响，因为 root motion 会从 source 复制。 |
| **Debug Draw** | 提供一种面向 chain 的调试方式。工具按 operation 独立，并通过 op stack 控制。 |
| **Profile Ops** | 切换 op stack 的 performance profiling。 |

