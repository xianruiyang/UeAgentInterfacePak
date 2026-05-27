# Mirroring Animation

---
title: "Mirroring Animation"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/mirroring-animation-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "动画资产和功能", "Mirroring Animation"]
---

# Mirroring Animation

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / 动画资产和功能 / Mirroring Animation

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/mirroring-animation-in-unreal-engine

动画镜像会将角色一侧的动画复制到另一侧，使同一个动画可在不同情境中复用。使用 **Mirror Data Table**以及其他镜像工作流，不仅可以镜像 Animation Sequence，还可以镜像曲线、同步标记和 Notify。此外，Unreal Engine 内部的镜像功能提供了一种创建镜像动画的方式，而无需管理第二份副本。

本文概述如何使用 Mirror Data Table 和 Animation Blueprint 镜像动画。

#### 前提条件

- 项目中已包含要镜像的

  Skeletal Mesh

  和

  动画

  。
- 你已了解如何创建和使用

  Animation Blueprint

  .

## Mirror Data Table

要开始镜像动画，必须先创建一个 **Mirror Data Table**资产。Mirror Data Table 会为要镜像的 Skeleton 中所有元素提供镜像分配和指令。

要创建它，请点击 **Add (+)** ，位置在 Content Browser 中，然后选择 **Animation > Mirror Data Table**。随后会出现一个对话框，必须在其中选择要镜像的 Skeleton。选择一个并点击 **Accept**.

![create mirror data table](../../../../../assets/images/9e/9e7fc6a9a10686ea7f71e127e193108b982747295ca53b2c78a25a1e4b428fd9.png)

打开 Mirror Data Table，可在编辑器中看到以下主要区域：

![mirror data table editor](../../../../../assets/images/1d/1d95304e6de190372011c271d2187cb6feefb304b0b394dfb095245d51d650e6.png)

1. Data Table

   ，包含要镜像的元素列表。该列表会根据骨骼、notify 和其他元素名称自动填充；这些名称可以在

   Data Table Details

   .
2. Data Table Details

   中配置。该区域包含镜像行为的配置设置。
3. Row Editor

   ，为所选条目提供设置，可在其中编辑元素名称、镜像名称和元素类型。

### 添加和编辑条目

要添加新的表条目，请点击 **Add (+)** 工具栏按钮，并在 **Row Editor** 面板中填写四个属性。

- Row Name

  ，即条目的名称。
- Name

  ，即要镜像的第一个骨骼名称。
- Mirrored Name

  ，即要镜像的第二个骨骼名称。左侧或右侧骨骼可以放在任一属性中，但这些属性必须包含对称骨骼。
- Mirror Entry Type

  ，即要镜像的元素类型。可选择以下类型：

  - Bone
  - Animation Notify
  - Curve
  - Sync Marker
  - Custom，为通过 C++ 添加其他类型来扩展 Mirror Data Table 提供代码基础。

![add mirror entry](../../../../../assets/images/b4/b44b8a864ffa7d3efbb7197b777a270d0fd397b08e0c638583f655d8c476d16f.png)

> [!NOTE]
> 为了得到完整镜像的角色，该表必须包含大多数蒙皮骨骼，包括 **pelvis**, **spine**, **neck**和 **head**等中央骨骼。这样镜像操作才能沿镜像轴正确翻转这些骨骼的旋转。对于这些条目， **Name**和 **Mirrored Name** 应保持匹配。
>
> ![mirror central bones](../../../../../assets/images/16/1621a485bda87deb7fc8d1f70a8afc3ca20971317e56dba60a12c7ef5e28ec5b.png)

### Data Table Details

Data Table Details 面板包含镜像行为的配置和其他设置：

![data table details](../../../../../assets/images/4b/4bc2bf20ab331897344316f4bf5243de23d5609683ec594a53a2d57a57177c26.png)

| Name | 说明 |
| --- | --- |
| **Mirror Find Replace Expressions** | 一组表达式数组，用于使用常见镜像条目自动填充表。请参阅 [查找和替换表达式](#findandreplaceexpressions) 章节以了解更多信息。 |
| **Mirror Axis** | 镜像轴，即穿过角色正面的轴。大多数情况下应为 **X**. mirror axis |
| **Skeleton** | 镜像操作要使用的 Skeleton 资产。 |
| **Row Struct** | 表中每一行要使用的结构体。若要扩展此结构，必须继承自 `FTableRowBase` 。 |
| **Strip from Client Builds** | 启用后，此 Data Table 不会 cook 到客户端构建中。如果制作只有服务器应知道的机密表，这会很有用。 |

### 查找和替换表达式

**Find**和 **Replace Expressions** 是可添加到 Data Table Details 的数组条目，会自动搜索并替换 Skeleton 中元素的特定字符串文本。创建或重新导入 Skeleton 时，这些表达式随后用于确定自动填充哪些元素。

![find and replace expression properties](../../../../../assets/images/c8/c8e2eeedc6cd45b6485d90eb4627dcb4ddd42c3e1aabc89b1fc6cb59640b7ffe.png)

每个数组需要以下表达式：

| Name | 说明 |
| --- | --- |
| **Find Expression** | 要搜索的文本。大多数情况下，这可能是元素名称中的对称修饰符，例如 `_l`, `left_`, or `_left_`. |
| **Replace Expression** | 要替换的文本。大多数情况下，这可能是元素名称中的对称修饰符，例如 `_r`, `right_,` or `_right_`. |
| **Find Replace Method** | 替换文本时要使用的搜索方法。可从以下选项中选择： **Prefix**，只在名称开头搜索文本。 **Suffix**，只在名称末尾搜索文本。 **Regular Expression**，可在其中编写用于查找和替换名称的自定义表达式。 |

> [!NOTE]
> 使用 **Regular Expression** 作为方法时，可以为 [正则表达式](https://en.wikipedia.org/wiki/Regular_expression) 编写自定义 **Find Expression** 和 **Replace Expression**.
>
> 例如， **Index 12** 默认数组中的条目包含以下表达式，用于搜索常见中央骨骼名称并分配给 **Name**和 **Mirrored Name** 属性：
>
> - Find Expression：
>
>   ((?:^[sS]pine|^[rR]oot|^[pP]elvis|^[nN]eck|^[hH]ead|^ik_hand_gun).*)
> - Replace Expression：
>
>   $1
>
> 如果对称文本修饰符位于元素名称中间，例如 `finger_left_index1`，可以编写以下表达式以正确搜索和替换：
>
> - Find Expression：
>
>   (\S*)_left_(\S*)
> - Replace Expression：
>
>   $1_right_$2

该数组预填充了常见表达式，例如搜索并替换作为前缀或后缀的多种对称修饰符排列。可以从 [Project Settings](../../../../understanding-the-basics/project-settings/index.md)中更改此默认数组。在 Unreal Engine 主菜单栏中选择 **Edit > Project Settings**，然后导航到 **Engine > Animation**部分并找到 **Mirroring**属性部分。

![expression project settings](../../../../../assets/images/f8/f88676f0f76086b8a6908af9edf1d6a11858142a95931481e18676b887405844.png)

## 镜像动画

创建并填充 Mirror Data Table 后，就可以在 [Animation Blueprint](../../animation-blueprints/index.md)中镜像动画。此操作使用 **Mirror**AnimGraph 节点完成。

要创建该节点，请在 AnimGraph 中右键单击，并从 **Mirroring**分类中选择你的表。

![mirror animation blueprint](../../../../../assets/images/61/61d598015f78ae6fc4dacfa0a79a94c8446452b007a0f0202c6bbcf1ca55cf81.jpg)

可以通过提供输入姿势和 bool 变量来启用或禁用镜像，从而预览镜像效果。

> 动图已省略：enable or disable mirroring

Mirror 节点包含以下属性：

> 图片已省略：mirror properties

| Name | 说明 |
| --- | --- |
| **Mirror** | 启用或禁用镜像效果。默认情况下，此项会暴露为引脚。 |
| **Mirror Data Table** | The [Mirror Data Table](#mirrordatatable) ，用于镜像。 |
| **Blend Time on Mirror State Change** | 当 **Mirror** 启用或禁用时，在镜像状态之间混合的时长。使用此项还要求在 Mirror 节点之后使用 [Intertialization](../../animation-blueprints/animation-blueprint-nodes/animation-blueprint-blend-nodes/index.md#intertialization) 节点。 blend time on mirror state change |
| **Reset Child on Mirror State Change** | 启用后，当镜像状态变化时会重新初始化源姿势。 |
| **Bone** | 是否在镜像中包含骨骼数据。 |
| **Curve** | 是否在镜像中包含曲线数据。 |
| **Attributes** | 是否在镜像中包含 notify 和同步标记数据。 |

### 在蓝图 Notify 中检测镜像动画

如果正在使用 [Custom Notify States](../animation-sequences/animation-notifies/index.md#customnotifystates)，可能希望根据镜像状态改变其行为。可以在 Notify 蓝图中使用 **Is Triggered By Mirrored Animation** 节点区分镜像状态。

在此示例中，它用于 **Received Notify Function** 中分支逻辑，检查该 notify 是否来自镜像动画。

> 图片已省略：is triggered by mirrored animation

