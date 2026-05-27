---
title: "Color Grading Panel"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/color-grading-panel-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "后期处理效果", "颜色分级和胶片色调映射器", "Color Grading Panel"]
---

# Color Grading Panel

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 后期处理效果 / 颜色分级和胶片色调映射器 / Color Grading Panel

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/color-grading-panel-in-unreal-engine

**Color Grading（颜色分级）** 面板是用于调整场景颜色的专用界面。它使用可以执行 [颜色分级操作](../index.md)的 Actor，例如 Post Process Volume 和 Color Correction Region。

可以使用此面板直接配置颜色分级属性和设置，而无需通过每个 Actor 各自的 Details 面板。这样可以让美术人员更直接地完成配置。

## 颜色分级面板界面

可以从编辑器主菜单打开 **Color Grading（颜色分级）** 面板，方法是选择 **Window > Color Grading**。该面板会在关卡视口底部打开。

颜色分级面板界面包含以下部分：

1. 工具栏
2. Object Mixer 面板
3. 颜色分级属性

### 工具栏

可以使用 **工具栏** 为场景配置不同元素。

在工具栏中可以执行以下操作：

- 向场景添加支持颜色分级的 Actor。
- 按名称筛选和搜索支持颜色分级的 Actor。
- 切换 Outliner 与 Object Mixer 面板之间的 Actor 同步选择。
- 添加文件夹以在 Object Mixer 中组织 Actor。
- 为支持颜色分级的 Actor 添加和管理 Collection。

### Object Mixer 面板

**Object Mixer** 会列出场景和关卡中所有具备颜色分级控制项的 Actor 类型。列表中的 Actor 可以建立父子关系，也可以在文件夹内分组。文件夹会映射这些 Actor 在 Outliner 列表中的显示方式。

Object Mixer 列表支持以下 Actor 类型：

- Post Process Volume（后期处理体积）
- Cine Camera Actor（电影摄影机 Actor）
- Camera Actor（摄影机 Actor）
- nDisplay Root Actor（nDisplay 根 Actor）
- Color Correction Region（颜色校正区域）
- Color Correction Window（颜色校正窗口）

> [!NOTE]
> 某些 Actor 类型只有在项目启用对应插件后才可用。例如， **nDisplay** 插件必须启用，nDisplay Root Actor 类型才会出现在列表中。可以从编辑器主菜单选择以下项来启用插件： **Edit > Plugins**.

在此面板中，可以查看信息并执行以下操作：

- 排序列可以按升序或降序排列。
- 切换固定、Actor 可见性和 Actor 隔离等操作。
- 识别存在尚未保存更改的对象。
- 使用设置菜单显示或隐藏列表项。

### 颜色分级属性

颜色分级面板的主要区域会显示色调颜色分级属性，以及带通道值的色轮。这些设置通常位于可执行颜色分级的 Actor 的 Details 面板中。当在 Object Mixer 面板或 Outliner 中选择受支持的颜色分级 Actor 类型时，会显示这些颜色分级属性。

| 列 1 | 列 2 |
| --- | --- |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/0f98d677-ce8d-4c72-a925-acbccfafc981/cg-colorwheelandproperties.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/387f40ad-2c4b-4bbd-940f-0d20b27ffcae/cg-detailsproperties.png) |
| 颜色分级面板和附加属性。 | Details 面板中的 Post Process Volume 颜色分级属性。 |

点击图片查看完整尺寸。

该界面可分为两部分：

1. 包含色调范围、色轮和值滑块的颜色分级面板。
2. 颜色分级属性覆盖项。

颜色分级面板包含以下属性：

1. 当前选中且可进行颜色分级的 Actor 名称。
2. 一组 Tonal Range，每个范围都有自己的 Saturation、Contrast、Gamma、Gain 和 Offset 颜色分级属性。
3. 颜色模型选择，用于以 RGB（Red、Green、Blue）或 HSV（Hue、Saturation、Value）显示颜色值。
4. 色轮及其值滑块。

每个 Tonal Range（2），包括 **Global（全局）**, **Shadows（阴影）**, **Midtones（中间调）**和 **Highlights（高光）** 都有自己的 Color Wheel（4），用于 **Saturation（饱和度）**, **Contrast（对比度）**, **Gamma**, **Gain**和 **Offset**。每个色轮都有自己的值滑块，并对应各自的色调范围。

选择颜色模型（3）后，值滑块会变化以匹配所选模型。下表展示了一个示例。

| 列 1 | 列 2 |
| --- | --- |
|  |  |
| RGB 颜色模型 | HSV 颜色模型。 |

色轮和滑块右侧是通用属性覆盖面板，其中包含通用颜色分级属性：

有关这些设置以及在项目中使用颜色分级的更多信息，请参阅 [颜色分级设置](../index.md).

## 管理颜色分级 Actor

颜色分级面板用于管理和编辑场景中所有符合条件的 Actor。

### 筛选颜色分级 Actor

使用 **Search Filter（搜索筛选器）** （位于 Object Mixer 顶部）筛选支持颜色分级的 Actor 类型。

> [!TIP]
> 对于包含许多支持颜色分级 Actor 的大型场景，可以通过搜索筛选来加快工作流。

### 添加支持颜色分级的 Actor

可以使用 **Add（+）** 按钮，可以从此面板向场景添加支持颜色分级的 Actor。

### Sync Selection（同步选择）

**Sync Selection（同步选择）** 切换项会将 Object Mixer 面板中选中的 Actor 与关卡 [Outliner](../../../../building-virtual-worlds/level-editor/outliner/index.md).

当 **启用**时，颜色分级面板和 Outliner 会像一个整体一样工作。这意味着具备颜色分级属性的选中对象会同时在两个面板中被选中。

当 **禁用**时，每个面板会独立工作，只选择自身面板内的项目。当希望在颜色分级面板中保持选中某个支持颜色分级的 Actor，同时又想在场景中进行与颜色分级无关的其它修改时，禁用同步选择很有用。

> [!TIP]
> Sync Selection 切换项还配合 **Alt + Click** 热键使用。启用时，使用此热键只会从当前选择 Actor 的面板中选择项目；禁用时，使用此热键会在两个面板中同步选择。

### 组织层级

Object Mixer 的 Actor 列表可以通过文件夹、Actor 父子关系，或两者结合来组织。

**Add Folder（添加文件夹）** 图标会在 Object Mixer 中为选中的 Actor 创建新文件夹。此图标不会向 Object Mixer 面板添加空文件夹。

可以在列表中拖放 Actor，使其成为彼此的父子关系。Outliner 会镜像所有父子组织结构。

> 动图已省略：a42935766d510dbec30163619855dc78b1639c55f129932bb9ce66d4170f1e33

> [!NOTE]
> 当移动或重新指定 Actor 父级导致某个文件夹为空时，该文件夹会从 Object Mixer 面板移除，但不会从 Outliner 中移除。

### Actor 可见性

可以切换 **Visibility（可见性）** ，方法是点击任意支持颜色分级 Actor 名称旁边的 **Eye（眼睛）** 图标。这会设置该 Actor 在场景中是否可见，或是否被静音。睁眼图标表示 Actor 可见，闭眼图标表示它在场景中被静音。可以使用此工作流检查场景的特定部分，而不对其进行实际更改。

### Actor 隔离

可以切换 **Solo（独显）** 选项，方法是点击任意支持颜色分级 Actor 名称旁边的 **Headphones（耳机）** 图标。

切换 Solo 图标会禁用 Object Mixer 中所有其它颜色分级 Actor 的可见性，只保留选中的颜色分级 Actor 可见。可以使用此工作流单独检查场景中的特定 Actor。

> 动图已省略：d0b4442a00a8bb37eae5fd934f1e1ece4aa6cfce57dcc062dfa016c9ce875325

### Settings 菜单

**Settings（设置）** 菜单包含用于配置 Actor 在 Object Mixer 面板中显示方式的选项。可以在工具栏中点击 **Gear（齿轮）** 图标打开此菜单。

该菜单的主要功能包括：

- 展开和折叠 Object Mixer 层级的设置。
- Object Mixer 面板中 Actor 的显示/隐藏选项。
- 是否在 Object Mixer 面板中显示文件夹。
- 不同 world（关卡）的选择选项；使用 World Partition 时，可仅显示来自这些关卡的 Actor。

## 使用颜色分级 Collection

[Collection](../../../../understanding-the-basics/content-browser/filters-and-collections/index.md) 用于将资产组织成用户自定义集合组。在 Object Mixer 面板中，可以将相似或经常编辑的 Actor 添加到分组，以便更快访问其属性。出于编辑目的，可以将 Object Mixer 中的 Actor 分到一个或多个 Collection 中。

Object Mixer 中列出的所有符合颜色分级条件的颜色 Actor 都属于一个默认 Collection： **All（全部）**。该 Collection 类别只有在创建自定义 Collection 后才会出现，且不能编辑或移除。

### 创建颜色分级 Collection

要创建 Collection：

1. 选择 Object Mixer 面板中列出的一个或多个 Actor。
2. 右键点击要为其创建 Collection 的 Actor，然后将鼠标悬停在

   Select or Add Collection

   上下文菜单项上。
3. 在文本字段中输入此 Collection 的名称。
4. 按

   Enter

   创建 Collection。

新创建的 Collection 会显示在工具栏的搜索筛选器下方，并位于 Object Mixer 排序列正上方。可创建的 Collection 数量没有限制。

> 动图已省略：36617aaaab51c6b92dbec79fea055228450118cdd986a1a7d720faa7a37fbf54

### 查看颜色分级 Collection

要查看某个 Collection，请在工具栏的 Collection 区域点击其名称。选择该 Collection 后，只会显示其中支持颜色分级的 Actor。 **All（全部）** Collection 会将所有 Actor 恢复到 Object Mixer 列表。

### 向颜色分级 Collection 添加或移除 Actor

可以使用右键上下文菜单向 Collection 添加或移除符合条件的 Actor。

1. 选择 Object Mixer 面板中列出的一个或多个 Actor。
2. 右键点击 Actor，并将鼠标悬停在

   Select or Add Collection

   上下文菜单项上。
3. 在 Collection 列表中，可以：

   - Add（添加）

     通过勾选指定 Collection 旁边的复选框，将 Actor 添加到该 Collection。
   - Remove（移除）

     通过取消勾选指定 Collection 旁边的复选框，将 Actor 从该 Collection 移除。

Actor 不只属于单个 Collection，可以被添加到任意数量的 Collection 中。

> 动图已省略：e97d8679436c7b2d7e96b408263fcb623c3c53191e427eee50ffe86a5e051d19

### 删除、复制和重命名颜色分级 Collection

在列出所有 Collection 的工具栏中，右键点击任意 Collection 可打开其上下文菜单。菜单会显示 **Delete（删除）**, **Duplicate（复制）**或 **Rename（重命名）** Collection 的选项。

> [!NOTE]
> **All（全部）** Collection 是唯一不能删除、复制或重命名的 Collection。右键点击它不会显示任何选项。

### 重新排序颜色分级 Collection

可以左键点击任意已列出的 Collection，并将其拖到 Collection 行中的新位置来重新排序。 **All（全部）** Collection 不能移动。

> 动图已省略：91226c9b65ca08a9bccdf974374f0585049759ecb6123cbe0b13c2b2c8543f87

## 结合 nDisplay 使用颜色分级

对于 [nDisplay](../../../../working-with-media/integrating-media/rendering-to-multiple-displays-with-ndisplay/index.md) 内容，配合颜色分级面板使用时还提供额外的颜色分级能力。

> [!NOTE]
> 这些选项只有在项目启用 **nDisplay** 插件后才可用。可以在 **插件** 浏览器中启用它。可从编辑器主菜单打开： **Edit > Plugins**.
>
> 或者，如果想查看已设置好 nDisplay、ICVFX 与颜色分级面板的项目，可以创建一个 **InCameraVFX** 模板项目，该模板位于项目浏览器的 **Film / Video & Live Events** 选项卡下。

### 按视口和按节点进行颜色分级

可以分别对 Outer Viewport 和 In-Camera VFX（ICVFX）Camera 应用颜色分级。在 nDisplay 中，颜色分级会通过按视口和按节点分组进行叠加。

在 Object Mixer 中选择支持 nDisplay 的内容时，颜色分级面板会在色轮上方左上角显示附加选项。

#### 按视口分组

当选择 **Display Cluster Root Actor** （DCRA）后，颜色分级面板顶部会显示一个附加选项，其中包含 **Entire Cluster** 按钮、复选框和视口选择下拉菜单。

可以使用 **Add（+）** 图标创建新的按视口分组。颜色分级面板右侧会出现 Per-Viewport Settings 类别。

添加按视口分组后，可以使用视口下拉菜单选择该分组要使用的可用视口。通过勾选列表中的视口名称，可以选择一个或多个视口。

颜色分级面板右侧的属性面板现在包含 **Per-Viewport Settings** 类别。可以选择是否包含 **All Nodes** 来自 Outer Viewport 的属性，因为 ICVFX Camera 始终显示在它们之上。

#### 按节点分组

When you select an **ICVFX Camera** 组件后，颜色分级面板顶部会显示一个附加选项，其中包含 **All Nodes Color Grading** 按钮、复选框和节点选择下拉菜单。

可以使用 **Add（+）** 图标创建新的按节点分组。颜色分级面板右侧会出现 Per-Node Settings 类别。

添加按节点分组后，可以使用节点下拉菜单选择该分组要使用的可用节点。通过勾选列表中的节点名称，可以选择一个或多个节点。

颜色分级面板右侧的属性面板现在包含 **Per-Node Settings** 类别。可以选择是否包含 **All Nodes** 属性。

### In-Camera VFX Editor

由于颜色分级是舞台 [In-Camera VFX](../../../../working-with-media/integrating-media/icvfx/index.md) （ICVFX）虚拟制作工作流的组成部分，颜色分级面板会作为 ICVFX Editor 中的抽屉存在，可使用以下热键呼出和收起： **CTRL + Spacebar** 或点击 **Color Grading（颜色分级）** 编辑器底部的选项卡。

> 动图已省略：d3697d94465a1fb5a45f3fbdbda0136464e4ef734f1ccf644e5f649c68ed3fa2

颜色分级面板是 ICVFX Editor 中可停靠的面板。可以点击 **Dock in Layout** （位于面板右上角），使其自动停靠在视口下方。

> 动图已省略：80760494788c1246b87b657851fdedb954b01598ead92add6ddadfc54d292c80
