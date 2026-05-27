---
title: "Groom组件和资产"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/groom-components-and-assets-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "毛发渲染与模拟", "Groom组件和资产"]
---

# Groom组件和资产

> 路径：虚幻引擎5.7文档 / 管理内容 / 毛发渲染与模拟 / Groom组件和资产

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/groom-components-and-assets-in-unreal-engine

传统上，在创建用于实时游戏和项目的毛发时，需要使用基于发片的技术或其他类似技术。基于发片的工作流程使用许多标记薄片（或发片）来提供大量单根毛发的大致形状和运动。虚幻引擎的Groom系统和工具提供了工作流程，供你使用基于发束的技术渲染毛发，这显著提高了实时用例中模拟毛发的视觉逼真度。

虽然毛发Groom目前还没有标准文件格式，但虚幻引擎的Groom系统提供了一种基于命名规范的方案，使用Alembic文件类型将从建模应用程序导出的数据提取到虚幻引擎中。这种基于规范的命名支持单个文件中的多个毛发组，例如头发、汗毛、胡须、睫毛和眉毛。该Groom系统还可使用自身的毛发着色器和渲染系统，以及由[Niagara](../../../visual-effects/index.md)驱动的动态物理集成。

在虚幻引擎中为角色设置Groom需要具备以下几个内容：

- Groom

  资产，用于存储从Alembic文件导入的Groom数据。
- 将Groom绑定到骨骼网格体的

  Groom绑定

  资产。
- 代表Groom资产实例的

  Groom组件

  。

> [!NOTE]
> 虚幻引擎的Groom系统提供了基于发束的Groom导入、编辑、渲染和模拟的最简可行实现方案。该系统不提供毛发Groom解决方案，例如能够塑造毛发形状。这需使用[XGen](https://knowledge.autodesk.com/support/maya/learn-explore/caas/CloudHelp/cloudhelp/2015/ENU/Maya/files/GUID-47644337-40F0-4766-BD3B-4104F9F9B7E2-htm.html)、[Ornatrix](https://ephere.com/plugins/autodesk/max/ornatrix/)、[Yeti](https://peregrinelabs.com/yeti/)、[Shave and a Haircut](https://www.unrealengine.com/en-US/programs/shave-and-a-haircut?sessionInvalidated=true)或者[Houdini](https://www.sidefx.com/docs/houdini/fur/workflow.html)工具在Maya等应用程序中完成。

## Groom资产

当你导入Alembic (*.abc)文件时，会创建 **Groom** 资产。这些资产保存在内容浏览器中，并且可以在 **Groom资产编辑器（Groom Asset Editor）** 中打开。

![Groom资产编辑器](../../../../assets/images/68/68422c164642bd3f0c73b90b2bd478fb49aedca3826e968121f2671c667f4667.jpg)

当你打开Groom资产时，你可以在Groom资产编辑器中进行以下操作：

- 指定材质
- 定义呈现发束、发片或网格体的细节级别设置
- 启用和配置物理设置
- 使用不同的视图模式调试你的Groom

如需详细了解此资产编辑器的用法，请参阅[Groom资产编辑器](../groom-asset-editor-user-guide/index.md)。

## Groom绑定

**Groom绑定** 资产用于将Groom资产绑定到骨骼网格体。通过此绑定资产，可以将皮肤运动和变形应用到毛发。打开Groom绑定资产，会显示Groom资产及其与骨骼网格体的绑定。可以在Groom资产编辑器中预览Groom绑定。

![Groom绑定资产编辑器](../../../../assets/images/63/630b62b3ca38b15292312bcf7d1c549a69b8c367b09330a90adcdef92135fc29.jpg)

如需详细了解此资产类型，请参阅[Groom绑定](../setting-up-bindings-for-grooms/index.md)。

## Groom组件

**Groom组件** 代表关卡中的Groom资产实例。Groom组件可以重载Groom资产的某些属性，例如其毛发半径和LOD偏差。

![Groom组件](../../../../assets/images/23/233788b059e7d7f95e8e73188251b9ede77591cb8b43326a91dda425e5d07ffc.jpg)

| 属性 | 说明 |
| --- | --- |
| Groom组说明（Groom Group Desc） |  |
| **毛发宽度（Hair Width）** | 重载毛发宽度（以厘米为单位）。 |
| **毛发根部比例（Hair Root Scale）** | 毛发根部的毛发宽度比例。 |
| **毛发梢部比例（Hair Tip Scale）** | 毛发梢部的毛发宽度比例。 |
| **毛发阴影密度（Hair Shadow Density）** | 控制毛发密度，在阴影渲染期间增减毛发数量。可在发束数量不符合实际情况时增/减毛发阴影。 |
| **毛发光线追踪半径比例（Hair Raytracing Radius Scale）** | 缩放毛发几何体半径以实现光线追踪效果，例如阴影。 |
| **使用毛发光线追踪几何体（Use Hair Raytracing Geometry）** | 使毛发几何体可与光线追踪功能结合使用。 |
| **LOD偏差（LOD Bias）** | 设置所选细节级别（LOD）的偏差。大于0的值将逐步选择较低的LOD。启用 'r.HairStrands.Cluster.Culling' 后可使用此属性。 |
| **使用稳定光栅化（Use Stable Rasterization）** | 启用后，可确保毛发不会出现锯齿。启用后，成组的毛发可能看起来更浓密，而孤立的毛发则仍然稀疏。 |
| **散射场景光照（Scatter Scene Lighting）** | 启用后，毛发会被照亮成场景颜色。该属性用于汗毛/短毛（如绒毛），以便从周围表面（如皮肤）吸收光线。 |
| **毛发长度比例（Hair Length Scale）** | 启用后，允许缩放毛发的长度。 |
| 材质（Materials） |  |
| **元素[N]（Element [N]）** | 将你的毛发材质指定到此资产插槽。 |
| Groom |  |
| **Groom资产（Groom Asset）** | 用于渲染此Actor的Groom资产。 |
| **绑定资产（Binding Asset）** | 可选的绑定资产，用于将Groom绑定到骨骼网格体上。如果未指定绑定资产，则投影将在运行时完成，这意味着启动时会产生大量GPU开销。 |
| **使用发片（Use Cards）** | 启用后，此选项强制Groom使用发片/网格体几何体而不是发束。 |
| **附着名称（Attachment Name）** | 当Groom组件作为骨骼网格体的子级时，附着Groom组件处的可选名称。 |
| Groom缓存（Groom Cache） |  |
| **Groom缓存（Groom Cache）** | 在此组件上播放的Groom动画。它必须与Groom资产兼容。 |
| **运行（Running）** | 启用该属性可播放动画。 |
| **循环（Looping）** | 当耗时超出动画范围时，启用该属性可循环播放动画。 |
| **手动更新（Manual Tick）** | 启用该属性可仅通过Sequencer播放。 |
| **耗时（Elapsed Time）** | 这是一个只读值，显示自播放动画起的已用时间。 |
| 模拟（Simulation） |  |
| **物理资产（Physics Asset）** | 启用物理模拟时要用于此Groom的物理资产。 |
