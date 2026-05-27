# Instanced Static Mesh Component

---
title: "Instanced Static Mesh Component"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/instanced-static-mesh-component-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "静态网格体", "Instanced Static Mesh Component"]
---

# Instanced Static Mesh Component

> 路径：虚幻引擎5.7文档 / 管理内容 / 静态网格体 / Instanced Static Mesh Component

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/instanced-static-mesh-component-in-unreal-engine

虽然在关卡中放置大量 **static mesh actor** 在虚幻引擎中很常见，但 Actor 数量会影响性能成本。与其在关卡中重复放置 static mesh actor（增加计算成本），不如将相同网格体分组到一个 Actor 中，作为 **instanced static mesh（ISM）component**.

本概述说明 ISM 对优化的重要性，以及用于创建和编辑此组件类型的各种工具。

![undefined](../../../../assets/images/42/424553667be1042779ae331bd5717705b29dc32163a86b68fc13b1198307aaa5.jpg)

Valley of the Ancient 示例项目使用 ISM 拼装大型组合体来填充世界。有关该示例项目以及创建 ISM 工具的更多信息，请参阅 Valley of the Ancient Sample 文档，以及本页的“创建和编辑 ISM”部分。

## 前置知识

继续阅读本页前，建议先了解以下主题：

- [虚幻引擎术语](../../../understanding-the-basics/foundational-knowledge-in/unreal-engine-terminology/index.md)
- [资产](../../../understanding-the-basics/assets-and-content-packs/index.md)
- [Static Mesh Actor（静态网格体 Actor）](../../../understanding-the-basics/actors-and-geometry/unreal-engine-actors-reference/static-mesh-actors/index.md)

## Instanced Static Mesh（实例化静态网格体）

ISM 是包含一组相同 static mesh 的组件。组件中的每个 static mesh 都表示该 static mesh asset 的一个实例（副本）。

可以将 ISM 作为重复网格体的性能优化技术。此方法会合并相同 static mesh component 的 [draw call](../../../designing-visuals-rendering-and-graphics/optimizing-and-debugging-projects-for-realtime-rendering/guidelines-for-optimizing-rendering-for-real-time/index.md#drawcalls) 。该过程可帮助提升性能，例如减少 `UOBjects`。例如，在 GPU 上，一个 primitive 使用的内存约为基础 instance 的十倍（672 字节对 64 字节）。

| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/344ea79e-ad7b-4a1f-b4e4-6417824f78a9/books-static-mesh-component.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/6d521ee9-dc3e-4ba4-9488-43fbe0acea37/books-instanced-static-mesh-component.png) |
| --- | --- |
| Static Mesh Component 统计 | Instanced Static Mesh Component 统计 |

200 个非 Nanite 书本分别作为单独 static mesh actor，以及作为带 instanced static mesh component 的单个 Actor 时的统计对比。

> [!TIP]
> 对任何项目而言，理解目标平台和性能预算都很重要。有关优化和 stat 命令的更多信息，请参阅 [实时渲染优化指南](../../../designing-visuals-rendering-and-graphics/optimizing-and-debugging-projects-for-realtime-rendering/guidelines-for-optimizing-rendering-for-real-time/index.md) and [Stat 命令](../../../testing-and-optimizing-content/stat-commands/index.md).

### Details 面板

instanced static mesh 是 Actor 的一个组件。可以在 **Details** 面板中查看其层级。Actor 类型取决于用于创建 ISM 的工具。有关选择和创建 ISM 的更多信息，请参阅本页 [创建和编辑 ISM](#creatingandeditingisms) 部分。

此外，可以在 Details 面板中查看和修改以下内容：

- 应用到 Actor 组件的 static mesh asset。
- 组件内的 instance 数量。

  - 包含添加、删除或复制 instance 的选项。
- 该组件生成的所有 instance 使用的材质。
- 每个 instance 的自定义数据。更多信息请参阅 [Custom Data](#customdata) 部分。
- 细节级别（LOD）。更多信息请参阅 [Hierarchical Instanced Static Mesh](#hierarchicalinstancedstaticmesh) 部分。
- instance 剔除距离。更多信息请参阅 [Visibility and Occlusion Culling](../../../designing-visuals-rendering-and-graphics/optimizing-and-debugging-projects-for-realtime-rendering/visibility-and-occlusion-culling/index.md).
- 面板中常见的其它属性。更多信息请参阅 [Level Editor Details 面板](../../../building-virtual-worlds/level-editor/level-editor-details-panel/index.md).

![undefined](../../../../assets/images/6e/6e8b1cd76c457e2806ac52a735cc2f341ec7afe06f87cb909df985645c981d8c.jpg)

Details 面板中高亮的 instanced static mesh component 及对应设置。

如果点击单个组件 instance，Details 面板中只会显示 transform 属性。此限制是因为该组件会共享所有其它属性，例如 [材质](../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/index.md)，以创建一个高效的单一组件。

## ISM 与 Static Mesh Component 的区别

将 **static mesh asset** 拖入 Level Editor 时，会自动创建一个引用该资产的 **static mesh actor** 。Actor 中的每个 static mesh 都通过一个组件引用。默认情况下，将 static mesh asset 拖入关卡时会应用 **static mesh component** 。

下表显示 **static mesh component** 和 **instanced static mesh component**.

| **Static Mesh 类型** | **行为** |
| --- | --- |
| **Static Mesh Component（静态网格体组件）** | 单个 static mesh 表示，拥有自己的 transform、material 和 collision。 |
| **Instanced Static Mesh Component（实例化静态网格体组件）** | 表示指定 static mesh 的多个 instance，它们共享相同的 material 和 collision 属性。 此组件常用于以不同 transform 更高效地渲染同一个 static mesh。许多属性（如 collision、material 和 shadow）仅存在于组件级，不能按 instance 单独编辑。 |

| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/6a08b9ac-7566-4314-9b8a-cb765fa931ce/static-mesh-component.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/b614de74-09ab-41f8-b83a-9ab2712bc074/instanced-static-mesh-component.png) |
| --- | --- |
| Static Mesh Component（静态网格体组件） | Instanced Static Mesh Component（实例化静态网格体组件） |

> [!TIP]
> 一个 Actor 可以包含多个 ISM component 和 static mesh component。与在关卡中放置重复的相同 static mesh actor 类似，使用 ISM 通常比在 Actor 中复制 static mesh component 更高效。

## Hierarchical Instanced Static Mesh

传统上， **hierarchical instanced static mesh** （HISM）会按 instance 单独应用细节级别（LOD），而 ISM 会将 LOD 应用到整个组件边界。不过，对于 5.4 或更高版本创建的项目，ISM 也可以按 instance 使用 LOD。

LOD 是同一个网格体在不同三角形数量下的一组版本，会根据其在视口中的屏幕空间使用。较低三角形数量有助于减少计算时间并提升优化效果。可以在 Details 面板中调整 ISM 和 HISM component 的 LOD 属性。有关 LOD 的更多信息，请参阅 [创建和使用 LOD](../creating-and-using-lods/index.md).

HISM 和 ISM 之间有一些需要注意的区别。不过，在项目中选择 ISM 还是 HISM 取决于项目本身，并且需要测试。要了解项目性能需求，请参阅 [测试并优化内容](../../../testing-and-optimizing-content/index.md).

以下是需要注意的一些区别：

- 如果有数千个不会移动的 instance，HISM 可能更合适。在这种情况下，会使用静态层级来加速剔除和 LOD 流程。

  - 如果有许多并非完全静态的 instance，使用 HISM 可能在项目中产生错误。
- ISM 没有静态层级，因此必须在 GPU 上对每个 instance 进行剔除和 LOD，这在性能较低的平台上可能成本较高。
- 如果希望 LOD 匹配 static mesh 行为，不能依赖 HISM，因为它按 instance 组处理。HISM 最适合单个 LOD 不太重要的场景，例如三角形较少的网格体。
- 如果项目只使用 Nanite，则始终应选择 ISM，因为 Nanite 拥有自己的剔除和 LOD 系统。对于使用 Nanite 和 fallback mesh 的项目，在适当情况下使用 HISM。

> [!NOTE]
> 除非需要区分二者，本页会将 ISM 和 HISM 统称为 instanced static mesh。

## 实例化系统

虚幻引擎提供了可对网格体应用实例优化的系统。这些系统（如 Nanite）的使用取决于项目和目标平台。

| 系统 | 说明 |
| --- | --- |
| **Dynamic Instancing** | 通过合并具有相同 material 和 mesh 的 static mesh draw 来减少 draw call。更多信息请参阅 [Mesh Drawing Pipeline](../../../designing-visuals-rendering-and-graphics/graphics-programming/mesh-drawing-pipeline/index.md). |
| **Nanite** | 虚拟化几何体系统，使帧预算不再受多边形数量、draw call 和 mesh 内存使用量约束。可以在 ISM 和 HISM component 中引用启用 Nanite 的 mesh。更多信息请参阅 [Nanite 虚拟化几何体](https://dev.epicgames.com/documentation/404). |
| **Procedural Content Generation** | 用于生成 instance 以程序化生成内容的框架。更多信息请参阅 [Procedural Content Generation](../../../building-virtual-worlds/procedural-content-generation/index.md). |
| **Niagara** | 用于创建视觉效果的系统。可以在渲染时实例化粒子网格体。更多信息请参阅 [Niagara Renderer](../../../visual-effects/reference-for-niagara-effects/system-and-emitter-module-reference-for-niagara-effects/render-module-reference-for-niagara-effects/index.md). |

> [!NOTE]
> instanced static mesh 有助于创建高效管线，并确保不会破坏引擎的自动实例化。也可以使用启用 Nanite 的 mesh 创建 ISM。

## 使用 ISM

ISM 的主要作用是提升项目性能。如果逐个复制每个植被来绘制森林，速度会非常慢。借助 Foliage Mode 等工具，可以同时放置多个分组 instance，从而节省工作流时间和计算时间。

### 预制化

将相同 static mesh 分组到一个组件中，是设计优化关卡的有价值工作流。ISM 可帮助完成关卡设计，例如在环境中放置背景道具，或重复建筑 instance 来创建塔楼。

这种预制化不同于合并网格体以创建新 static mesh asset 的工作流：每个 instance 都相同、可选择，并且更新一个 instance 会更新所有 instance。要创建预制 instance，请参阅 [创建和编辑 ISM](#creatingandeditingisms) 部分。

### Custom Data

使用 ISM 时，可以使用 **Custom Primitive Data（自定义图元数据）** and **Per Instance Custom Data（每实例自定义数据）** 通过传递数据进一步减少 draw call，而无需为每个 mesh 生成新的 **dynamic material instance** 。这两组数据都可在 Details 面板中使用。可以将数据读入材质，并使用 Blueprint 操作它。

- **Custom Primitive Data：** 存储在 primitive 上的额外 float 数据。更多信息请参阅 [按 Primitive 在材质中存储自定义数据](../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/storing-custom-data-in-unreal-engine-materials-5286ff29/index.md).
- **Per Instance Custom Data：** 每个 instance 的额外 float 数据。更多信息请参阅 [nDisplay 中 Material Per Instance Random 的确定性替代方案](https://dev.epicgames.com/community/learning/tutorials/wdMm/unreal-engine-deterministic-replacement-for-material-perinstancerandom-for-ndisplay).

> [!TIP]
> 可以对项目进行性能分析，以了解性能瓶颈以及适合引入 ISM 的潜在区域。更多信息请参阅 [Unreal Insights](../../../testing-and-optimizing-content/unreal-insights/index.md).

## 创建和编辑 ISM

以下是用于创建和编辑 ISM 的各种引擎内工具。

> [!NOTE]
> 选择多个唯一 static mesh 并将其分组到单个 Actor 时，会为每个唯一 static mesh asset 创建一个 instanced static mesh component。

### Instance 选择

可以使用以下方法选择 ISM 的 instance：

- The console command `TypedElements.EnableViewportSMInstanceSelection`. Where true (1) is the default value.
- 位于 **Instances** 部分，该部分在 **Details** 面板中。
- [ISM Editor](#ismeditor).

<h3 id="blueprints">Blueprint（蓝图）</h3>

**Blueprint Visual Scripting 系统** 是基于节点的脚本接口。可以使用 Blueprint actor 添加 ISM 或 HISM，然后加入逻辑，例如在书架上生成书本。有关创建 Blueprint 的更多信息，请参阅 [Blueprint 简介](../../../blueprints-visual-scripting/introduction-to-blueprints-visual-scripting/index.md).

要向 Blueprint actor 添加 ISM，请执行以下步骤：

1. 打开 Blueprint actor。有关如何创建和打开 Blueprint class，请参阅 [创建 Blueprint Class](../../../blueprints-visual-scripting/specialized-blueprint-visual-scripting-node-groups/types-of-blueprints/blueprint-class-assets/creating-blueprint-classes/index.md).
2. 点击 **+ Add** 位于 **Components** 选项卡中。
3. 搜索“Instanced”，并选择所需的 instanced component。
4. 在 **Static Mesh** 类别中，该类别位于 **Details** 面板，添加 static mesh asset。
5. 在 **Instance** 类别中，点击 **+** 图标来添加一个 instance。

此时 static mesh 应显示在 Blueprint Viewport 中。

有关在脚本中使用 instanced static mesh component 的示例，请参阅 Deterministic Replacement 教程中的 [实例化静态网格体蓝图方案（Blueprint ISM Solution）](https://dev.epicgames.com/community/learning/tutorials/wdMm/unreal-engine-deterministic-replacement-for-material-perinstancerandom-for-ndisplay) 部分。

### Merge Actors

**Merge Actors** 工具包含多种合并 static mesh actor 的方法。其中一个选项是 **Batch** 方法，它会将 static mesh 分组以创建 ISM。

要批处理 Actor，请执行以下步骤：

1. 选择所需 Actor。
2. 从 [菜单栏](../../../building-virtual-worlds/level-editor/index.md#menubar)选择 **Actor > Merge Actors > Merge Actors Settings**.
3. 将方法更改为 **Batch** 并按需调整设置。
4. 点击 **Merge Actors**.

![undefined](../../../../assets/images/01/01e06125520dbf42b9d034fdeaf6789866efbbd5d1d815b71c799cc108d46a47.png)

用于创建 instanced static mesh component 的 Batch 方法。

> [!NOTE]
> 定义首选设置后，可以从 **Batch** 下拉菜单中选择 **Merge Actor** 选项来再次运行该命令，而不是选择 **Merge Actors Settings**.

有关该工具的更多信息，请参阅 [Merge Actor](../../../understanding-the-basics/actors-and-geometry/merging-actors/index.md).

### Harvest Instances 工具

可以使用 **Harvest Instances**工具选择一组 static mesh actor，并批处理它们以创建 ISM 或 HISM component。

要访问 Harvest Instances 工具，请点击 **XForm** 类别，该类别位于 **Modeling Mode**。有关 Modeling Mode 及其访问方式的更多信息，请参阅 [Modeling Mode 概述](../../modeling-and-geometry-scripting/getting-started-with-modeling-mode/modeling-mode/index.md).

### Foliage Mode

**Foliage Mode** 是一套用于放置 static mesh foliage 和 actor foliage 的工具，可快速填充大型环境。可以使用**Static Mesh Foliage** 类型在绘制时批处理 mesh。

使用 Foliage 工具绘制 instanced static mesh component。

更多信息请参阅 [Foliage Mode](../../../building-virtual-worlds/open-world-tools/foliage-mode/index.md).

### Packed Level Actor

批处理 Actor 的另一种方式是使用 level-instancing 工作流。此工作流会从 Blueprint 创建 packed level actor，有助于创建预制对象。

![undefined](../../../../assets/images/a0/a06ea39fabfb90e72e2b86d78c8d6d3834d25ab2873d8a8e193aeecfee44edf6.jpg)

Valley of the Ancient 示例项目使用 Create Packed Level Actor 工具创建 ISM。

要创建 packed level actor，请执行以下步骤：

1. 选择所需 Actor。
2. 右键点击所选内容打开上下文菜单，并点击 **Level > Create Packed Level Actor**.
3. 选择 pivot 类型和 Actor。
4. 点击 **OK**.
5. 命名关卡并点击 **Save**.
6. 命名 Blueprint 并点击 **Save**.

> [!NOTE]
> 使用此方法时，Actor 会自动分组到一个 HISM 中。要编辑组件属性，请打开 Blueprint actor。

有关 packed level actor 的更多信息，请参阅 [Level Instancing](../../../building-virtual-worlds/world-partition/level-instancing/index.md).

### Pattern Tool

**Pattern Tool** 会通过 pattern 技术创建 mesh，并可将其输出为 ISM。可以沿线、网格或圆形在可移动 3D 平面上平铺一个或多个所选 mesh。每种平铺 pattern 都有多种参数，包括插值平移、旋转、缩放和抖动。该工具可帮助构建重复对象，并在环境中散布 mesh。工具包含以下输出类型：single actor、dynamic mesh 和 instanced static mesh。

要访问 Pattern 工具，请点击 **XForm** 类别，该类别位于 **Modeling Mode**。有关 Modeling Mode 及其访问方式的更多信息，请参阅 [Modeling Mode 概述](../../modeling-and-geometry-scripting/getting-started-with-modeling-mode/modeling-mode/index.md).

### ISM Editor

**ISM Editor** 可选择 ISM component 的 instance 并执行变换。也可以添加、替换和删除 instance。

> [!NOTE]
> 用新的 static mesh asset 替换某个 instance 时，会添加第二个 ISM component。

要访问 ISM Editor，请点击 **XForm** 类别，该类别位于 **Modeling Mode**。有关 Modeling Mode 及其访问方式的更多信息，请参阅 [Modeling Mode 概述](../../modeling-and-geometry-scripting/getting-started-with-modeling-mode/modeling-mode/index.md).

