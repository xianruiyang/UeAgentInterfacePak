---
title: "Hybrid Non-Nanite and Nanite Content Workflows"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/hybrid-nonnanite-and-nanite-content-workflows"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "优化和调试实时渲染项目", "Nanite虚拟几何体", "Hybrid Non-Nanite and Nanite Content Workflows"]
---

# Hybrid Non-Nanite and Nanite Content Workflows

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 优化和调试实时渲染项目 / Nanite虚拟几何体 / Hybrid Non-Nanite and Nanite Content Workflows

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/hybrid-nonnanite-and-nanite-content-workflows

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

以下章节重点介绍可在启用 Nanite 的项目中使用的工作流，用于在不复制资产的情况下，同时支持 Non-Nanite 功能和平台。

## 为 Nanite 导入高分辨率网格体

可以通过 Content Browser 或 Static Mesh 编辑器，为任意既有 Non-Nanite 静态网格体导入高分辨率网格体，作为其 Nanite 表示。

在 Content Browser 中，可以右键单击静态网格体资产，选择 Level of Detail > High Res > Import High Res，然后导航到要导入的文件。

或者，可以在 Static Mesh 编辑器中使用 Details 面板中的 Nanite Settings 导入高分辨率网格体。点击 Import 并导航到要导入的文件。

使用此工作流时，既有静态网格体及其细节层级（LOD）链会成为 fallback mesh，而不是由导入流程从 Nanite 几何体自动生成 fallback mesh。

此工作流会遵循场景中静态网格体 Actor 上的 Disallow Nanite 设置。下方“Static Mesh Component Option”章节会进一步解释。

## 材质工作流

可以通过两种方式使用材质改进 Non-Nanite 和 Nanite 工作流：

- 在材质图表中使用节点拆分逻辑路径。
- 使用仅用于 Nanite 渲染的覆盖材质。

### Nanite Pass Switch 节点

Nanite Pass Switch 节点提供一种方式，可在使用 Nanite 渲染时在材质图表中定义专门行为。

渲染到 Non-Nanite pass 时使用 Default 输入，以按常规方式处理材质。对于希望简化或专门渲染到 Nanite pass 的材质逻辑，使用 Nanite 输入。例如，当材质使用 Nanite 不支持的功能时，可以为 Default 输入保留相同逻辑，并为 Nanite 输入使用更友好的逻辑。

### Nanite 覆盖材质

材质和材质实例上都提供 Nanite Override Material 插槽。设置覆盖材质后，所有分配了该材质或材质实例且启用 Nanite 的网格体都会改用引用的 Nanite 覆盖材质。这意味着可以创建专用于 Nanite 工作流的材质，而不必使用 Nanite Pass Switch 节点直接在材质图表内管理逻辑。

> [!NOTE]
> 在材质实例中，Nanite Override Material 插槽会强制默认设为 None，因此在父材质中设置覆盖材质不会导致该材质的任何子实例自动继承它。

在下方示例中，雕像静态网格体资产已启用 Nanite，并应用了材质实例。该材质实例设置了带有简单颜色变化的 Nanite 覆盖材质，用于演示。左侧静态网格体 Actor 因为使用 Nanite 渲染，所以显示 Nanite 覆盖材质。右侧静态网格体 Actor 会显示相同材质，直到在该 Actor 上设置 Disallow Nanite；此时 Nanite 覆盖材质会被禁用，并显示该材质实例的 Non-Nanite 基础材质。

## Static Mesh Component 选项：Disallow Nanite

可以通过单个场景 Actor 上的 Disallow Nanite 设置，控制启用 Nanite 的静态网格体何时使用其 Nanite 表示。这意味着可以让使用同一个静态网格体资产的 Actor 混合采用 Nanite 与 Non-Nanite。

下方示例展示一个启用 Nanite 的静态网格体资产：左侧为 Nanite 网格体表示，右侧启用了 Disallow Nanite。

## Landscape 地形

可以在 Landscape Actor 上启用 Nanite。Nanite Landscape 网格体会在后台重建，以免干扰编辑器中的用户工作流。Nanite Landscape 不会提升 Landscape 分辨率，但会让用户利用 Nanite 运行时功能，例如 GPU 剔除、自动几何体流送和 LOD。它通常会提升运行时性能，尤其适用于 VSM 等高开销功能。

要了解如何为 Landscape 启用并使用 Nanite，请参阅 [将 Nanite 与 Landscape 结合使用](../../../../building-virtual-worlds/landscape-outdoor-terrain/using-nanite-with-landscapes/index.md).

## 典型内容性能

作为对比，以下 GPU 计时数据来自 Unreal Engine 5 技术演示 [Lumen in the Land of Nanite](https://www.youtube.com/watch?v=qC5KtatMcUw) ，运行于 PlayStation 5：

- 平均渲染分辨率为 1400p，并通过时间上采样到 4K。
- 剔除并光栅化所有 Nanite 网格体约需 2.5 毫秒（ms）（本演示中几乎所有内容都是 Nanite 网格体）。

  - 几乎所有使用的几何体都是 Nanite 网格体。
  - 几乎没有 CPU 成本，因为它 100% 由 GPU 驱动。
- 为所有 Nanite 网格体计算材质约需 2ms。

  - CPU 成本较低，场景中每个材质对应 1 次 draw call。

综合这些 GPU 时间来看，总计约 4.5ms，相当于 Unreal Engine 4 中深度预通道加基础通道的工作量。这使 Nanite 非常适合目标为 60 FPS 的游戏项目。

> [!NOTE]
> 对于没有受到前文所述性能陷阱影响的内容，应能预期类似数据。极高实例数量和大量唯一材质也可能增加成本，这也是我们正在积极改进的 Nanite 开发领域。
