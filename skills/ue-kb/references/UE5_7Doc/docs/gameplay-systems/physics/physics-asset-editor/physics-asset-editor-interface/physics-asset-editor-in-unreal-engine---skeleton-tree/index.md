---
title: "物理资产编辑器 - 骨架树"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/physics-asset-editor-in-unreal-engine---skeleton-tree"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "物理", "物理资产编辑器", "物理资产编辑器界面", "物理资产编辑器 - 骨架树"]
---

# 物理资产编辑器 - 骨架树

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 物理 / 物理资产编辑器 / 物理资产编辑器界面 / 物理资产编辑器 - 骨架树

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/physics-asset-editor-in-unreal-engine---skeleton-tree

![物理资产编辑器中的骨架树面板显示了当前骨架资产的骨骼层级](../../../../../../assets/images/ed/edc0b36d8c9cfe56ca7399126c32efc9f6359288c210cb34099fc0aec4a1b639.jpg)

**骨架树** 面板位于[物理资产编辑器（Physics Asset Editor）](../../index.md)中，用于显示当前[骨架](index.md)资产的骨骼层级以及碰撞体、图元和约束等其他资源。在骨架树中，你可以执行以下操作：

- 在骨骼层级中选中并查看特定骨骼及其关联的形体（Body）和约束。
- 创建和编辑形体、图元和约束。你可以在视口中模拟它们以查看布偶动画、约束和碰撞交互的结果。
- 创建临时绑定的预览资产。它们非常有用，比如可用于预览武器拿在角色手中的效果。

## 界面详细介绍

![界面详细介绍](../../../../../../assets/images/13/13f43e60c60ee7981dfe90f26b518c90d67bab0b57ad1b2f60c8f008b448401e.jpg)

1. 搜索行
2. 骨骼层级列表
3. 骨架选项

### 搜索行

![可以使用搜索行快速筛选骨骼层级，方法是筛选层级，仅包含基于所输入文本的名称](../../../../../../assets/images/75/753fa83728d182543514d1b4a9565b2d0e205a55d278a985063992992e200d6d.png)

**搜索** 行使你能够快速对骨骼层级进行过滤，从而仅过滤出包含基于输入文本的名称的层级。

![Pelvis](../../../../../../assets/images/7d/7d5702d7e3de159a09128fce1b0f909a84c2d9db8d2b160875537c54122499f7.jpg)

如上图所示，我们对层级进行了过滤，使其仅显示包含文本 Pelvis 的所有骨骼名称、形体或约束。

### 骨骼层级列表

![骨骼层级列表](../../../../../../assets/images/46/4653a3776190db0aaf5921ab5bb1298e3199210755a432847648f0c21b0c4b73.jpg)

该窗口显示所选物理资产当前使用的所有骨骼、形体、约束、图元和预览对象。 在该窗口中，你可以添加和指定碰撞形体、图元、约束和预览对象。 在骨骼层级列表中进行的大部分调整都通过右击快捷菜单进行，菜单选项因右键单击的对象而异（请参阅下方的各个快捷菜单部分）。

### 选择快捷菜单

在骨骼层级列表中，当你在骨骼、形体、图元或约束上右键单击时，可以访问特定于选择对象的快捷菜单。

以下是可用的快捷菜单及其相关选项。

#### 骨骼快捷菜单

当你在某个骨骼上右键单击时，将会看到以下快捷菜单：

![点击骨骼即可看到以下上下文菜单](../../../../../../assets/images/f8/f8345e62ee3ca0216387763574b63f48b477d60302dd3a3430de672b1c7975d7.jpg)

| 选项 | 说明 |
| --- | --- |
| **复制所选骨骼名称（Copy Selected Bone Names）** | 将选中的骨骼名称复制到剪贴板。 |
| **重置所选骨骼变换（Reset Selected Bone Transforms）** | 重置选中的骨骼的变换。 |
| **添加预览资产（Add Preview Asset）** | 打开一个菜单，其中包含能够暂时连接到某个骨骼以进行预览的所有符合条件的资源。例如，如果你希望查看某件盔甲在连接到某个骨骼时的效果，就可以使用该选项。但是请注意，这不是永久连接，仅在预览时可见。 |
| **删除所有已连接的资产（Remove All Attached Assets）** | 从骨架和网格体中删除所有已连接的资产。 |
| **添加/删除形体（Add/Replace Bodies）** | 使用[工具（Tools）](../physics-asset-editor-in-unreal-engine---tools-a-3b3e9bbb/index.md#%E5%B7%A5%E5%85%B7%E9%80%89%E9%A1%B9%E5%8D%A1)选项卡中的当前生成设置为选中的骨骼添加或替换形体。 |
| **添加形体（Add Shape）** | 将形状添加到形体。 |
| **选择所有形体（Select All Bodies）** | 选择骨架树中的所有形体。 |
| **选择模拟形体（Select Simulated Bodies）** | 选择骨架树中的所有模拟形体。 |
| **选择运动形体（Select Kinematic Bodies）** | 选择骨架树中的所有运动形体。 |
| **选择所有约束（Select All Constraints）** | 选择骨架树中的所有约束。 |

#### 形体快捷菜单

在某个形体（Body）上右键单击时，将会看到以下快捷菜单：

![点击形体即可看到以下上下文菜单](../../../../../../assets/images/78/784997205fdbe07a4305e4fbbf212f76b23a5bd3b2265cebf7c74f39e82fafe0.jpg)

| 选项 | 说明 |
| --- | --- |
| **重新生成形体（Regenerate Bodies）** | 使用[工具（Tools）](../physics-asset-editor-in-unreal-engine---tools-a-3b3e9bbb/index.md#%E5%B7%A5%E5%85%B7%E9%80%89%E9%A1%B9%E5%8D%A1)选项卡中的当前生成设置重新生成选中的形体。 |
| **添加形体（Add Shape）** | 为该形体添加形状。可以选择盒体、球体或胶囊体。 |
| **碰撞（Collision）** | 调整形体间的碰撞。 **焊接（Weld）**：将当前选中的形体焊接在一起。 **启用碰撞（Enable Collision）**：在当前选中的形体间启用碰撞。 **全部启用碰撞（Enable Collision All）**：在当前选中的形体和所有形体间启用碰撞。 **禁用碰撞（Disable Collision）**：禁用当前选中的形体间的碰撞。 **全部禁用碰撞（Disable Collision All）**用当前选中的形体和所有形体间的碰撞。 \| |
| **约束所选形体（Constraint selected bodies）** | 在作为子节点的所有选定形体与作为父节点的最后一个选定形体之间创建约束。 |
| **约束（Constraints）** | 在选中的形体和从层级列表中选择的形体间创建约束。 |
| **物理类型（Physics Type）** | 要为该形体使用的物理类型；运动或仿真。 |
| **物理材质（Physical Material）** | 选择要应用于所有形体的物理材质。 |
| **复制所选形体/约束到剪贴板（Copy Selected Bodies/Constraints To Clipboard）** | 将当前选定对象的形体/约束复制到剪贴板。 |
| **从剪贴板粘贴形体/约束（Paste Bodies/Constraints From Clipboard）** | 从剪贴板粘贴之前选定的形体/约束。 |
| **复制属性（Copy Properties）** | 将当前选中的对象的属性复制给下一个选中的对象。 |
| **粘贴属性（Paste Properties）** | 将前一个选中的对象的属性粘贴到当前选中的对象。 |
| **删除（Delete）** | 删除当前选中的形体。 |
| **删除下方全部形体（Delete All Bodies Below）** | 删除骨骼层级树中当前选中的形体下面的所有形体。 |
| **镜像（Mirror）** | 找到另一侧的形体并复制其约束和形体。 |
| **指定（Assign）** | 将选中的形体指定给当前物理动画配置文件。 |
| **取消指定（Unassign）** | 从当前物理动画配置文件取消指定选中的形体。 |
| **从静态网格体复制碰撞（Copy Collision From Static Mesh）** | 从特定静态网格体复制凸面碰撞。 |
| **选择所有形体（Select All Bodies）** | 选择骨架树中的所有形体。 |
| **选择模拟形体（Select Simulated Bodies）** | 选择骨架树中的所有模拟形体。 |
| **选择运动形体（Select Kinematic Bodies）** | 选择骨架树中的所有运动形体。 |
| **选择所有约束（Select All Constraints）** | 选择骨架树中的所有约束。 |

#### 图元快捷菜单

当你在某个图元上右键单击时，将会看到以下快捷菜单：

![点击图元即可看到以下上下文菜单](../../../../../../assets/images/f1/f1f30094f80d139f262af453791105cffcf0c3df9cb6f4932bdf0cb15483bb9c.jpg)

| 选项 | 说明 |
| --- | --- |
| **重命名（Rename）** | 重命名选定图元。 |
| **复制（Duplicate）** | 复制选中的图元。 |
| **删除（Delete）** | 删除选中的图元。 |
| **选择所有形体（Select All Bodies）** | 选择骨架树中的所有形体。 |
| **选择模拟形体（Select Simulated Bodies）** | 选择骨架树中的所有模拟形体。 |
| **选择运动形体（Select Kinematic Bodies）** | 选择骨架树中的所有运动形体。 |
| **选择所有约束（Select All Constraints）** | 选择骨架树中的所有约束。 |

#### 约束快捷菜单

当你在某个约束上右键单击时，将会看到以下快捷菜单：

> 图片已省略：点击约束即可看到以下上下文菜单

| 选项 | 说明 |
| --- | --- |
| **附着（Snap）** | 将当前选中的约束附着到骨骼。 |
| **重置（Reset）** | 将约束重置为默认状态。 |
| **轴和限制（Axes and Limits）** | 编辑轴和该约束的限制。 **循环约束朝向（Cycle Constraint Orientation）**：在不同的主轴间循环约束朝向。 **循环活动约束（Cycle Active Constraint）**：单独循环每个约束轴是否活动。 **锁定摇摆（Lock Swing）**：将摇摆1或2设置为锁定或受限。 **锁定扭曲（Lock Twist）**：将扭曲设置为锁定或受限。 |
| **转换（Convert）** | 将约束转换为不同的预置值。 球体和骨臼 铰链 棱柱体 骨骼 |
| **复制所选形体/约束到剪贴板（Copy Selected Bodies/Constraints To Clipboard）** | 将当前选定对象的形体/约束复制到剪贴板。 |
| **从剪贴板粘贴形体/约束（Paste Bodies/Constraints From Clipboard）** | 从剪贴板粘贴之前选定的形体/约束。 |
| **复制属性（Copy Properties）** | 将当前选中的对象的属性复制给下一个选中的对象。 |
| **粘贴属性（Paste Properties）** | 将前一个选中的对象的属性粘贴到当前选中的对象。 |
| **删除（Delete）** | 删除当前选中的约束。 |
| **指定（Assign）** | 将选中的约束指定给当前物理动画配置文件。 |
| **取消指定（Unassign）** | 从当前物理动画配置文件取消指定选中的约束。 |
| **从静态网格体复制碰撞（Copy Collision From Static Mesh）** | 从特定静态网格体复制凸面碰撞。 |
| **选择所有形体（Select All Bodies）** | 选择骨架树中的所有形体。 |
| **选择模拟形体（Select Simulated Bodies）** | 选择骨架树中的所有模拟形体。 |
| **选择运动形体（Select Kinematic Bodies）** | 选择骨架树中的所有运动形体。 |
| **选择所有约束（Select All Constraints）** | 选择骨架树中的所有约束。 |

#### 预览资源快捷菜单

**预览资源** 是静态网格体或骨架网格体等暂时连接到骨骼或骨臼以进行预览的资源。

当你在某个预览资源上右键单击时，将会看到以下快捷菜单：

> 图片已省略：点击即可看到以下上下文菜单

| 选项 | 说明 |
| --- | --- |
| **添加预览资产（Add Preview Asset）** | 打开一个菜单，其中包含能够暂时连接到某个骨骼以进行预览的所有符合条件的资源。例如，如果你希望查看某件盔甲在连接到某个骨骼时的效果，就可以使用该选项。但是请注意，这不是永久连接，仅在预览时可见。 |
| **删除所有已连接的资产（Remove All Attached Assets）** | 删除当前位于网格体上的所有预览资产。 |

### 骨架显示/隐藏选项

"骨架选项（Skeleton Options）"窗口使你可以显示或隐藏骨骼、形体、约束和图元。

| 选项 | 说明 |
| --- | --- |
| **UpperBodyMask** | 选中混合以便编辑。 |
| **LowerBodyMask** | 选中混合以便编辑。 |
| **FastFeet** | 选中混合以便编辑。 |
| **LeftFingersMask** | 选中混合以便编辑。 |
| **UpperBodyLowerBodySplitMask** | 选中混合以便编辑。 |
| **Clear** | 清除选中的混合。 |
| **Add Time Blend Profile** | 为此骨架添加一个新的时间混合。 |
| **Add Weight Blend Profile** | 为此骨架添加一个新的权重。 |
| **Add Blend Mask** | 为此骨架添加一个新的混合遮罩。 |
| **筛选扁平化层级（Filtering Flattens Hierarchy）** | 搜索树项时保留层级结构还是使其扁平化。 |
| **筛选时隐藏父项（Hide Parents When Filtering）** | 筛选时将父项显示为灰色还是完全隐藏它们。 |
| **显示形体（Show Bodies）** | 在树形视图中显示形体。形体是用于碰撞的一系列基本形状。 |
| **显示模拟形体（Show Simulated Bodies）** | 显示骨架树中的所有模拟形体。 |
| **显示运动形体（Show Kinematic Bodies）** | 显示骨架树中的所有运动形体。 |
| **显示约束（Show Constraints）** | 在树形视图中显示约束。约束用于控制形体相互移动的方式。 |
| **显示图元（Show Primitives）** | 在树形视图中显示基本形状（球体、盒体、胶囊体等）。 |
| **在父形体上显示约束（Show Constraints on Parent Body）** | 同时在父形体和子形体上显示约束。 |
| **显示全部骨骼（Show All Bones）** | 显示骨架中的每个骨骼。 |
| **显示网格体骨骼（Show Mesh Bones）** | 显示在网格体中使用的骨骼。 |
| **显示LOD骨骼（Show LOD Bones）** | 显示在显示的LOD（细节层级）中使用的骨骼。 |
| **显示加权骨骼（Show Weighted Bones）** | 显示具有顶点加权的骨骼。 |
| **隐藏骨骼（Hide Bones）** | 隐藏所有骨骼（骨臼和连接的资源仍将列示）。 |
