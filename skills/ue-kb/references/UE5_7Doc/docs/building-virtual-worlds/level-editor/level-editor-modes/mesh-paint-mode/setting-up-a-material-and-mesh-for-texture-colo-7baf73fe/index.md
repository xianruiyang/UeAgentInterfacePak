---
title: "为纹理颜色绘制设置材质和网格体"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/setting-up-a-material-and-mesh-for-texture-color-painting-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "关卡编辑器", "关卡编辑器模式", "网格体绘制模式", "为纹理颜色绘制设置材质和网格体"]
---

# 为纹理颜色绘制设置材质和网格体

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 关卡编辑器 / 关卡编辑器模式 / 网格体绘制模式 / 为纹理颜色绘制设置材质和网格体

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/setting-up-a-material-and-mesh-for-texture-color-painting-in-unreal-engine

纹理颜色绘制模式为静态网格体组件使用生成的网格体绘制纹理。为了在网格体上正确显示它们，需要在材质中使用MeshPaintTextureObject材质表达式进行一些额外的设置，并且对于静态网格体来说，需要有一个适合网格体纹理颜色绘制的UV设置。

以下小节将展示如何设置材质和网格体，以很好地处理纹理颜色绘制。

## 设置纹理绘制材质

按照以下小节设置材质以使用 **MeshPaintTextureObject** 和 **MeshPaintTextureReplace** 材质表达式。

> [!NOTE]
> 要详细了解纹理着色和网格体绘制纹理，请参阅[网格体纹理颜色绘制快速入门](../getting-started-with-mesh-texture-color-painting/index.md)。

### 向材质中添加网格体绘制纹理对象

**MeshPaintTextureObject** 材质表达式与Texture Sample节点配合使用，用于对静态网格体组件的生成网格体绘制纹理取样。此材质逻辑可以集成到现有材质中，也可以单独使用。

按照以下步骤设置材质，从而对与网格体关联的网格体绘制纹理取样：

1. 创建新的材质或打开现有材质。
2. 右键点击材质图表，并添加

   纹理取样

   节点。
3. 右键点击材质图表，并添加一个 **MeshPaintTextureObject** 节点。将其连接到 **Texture Sample** 节点的 **纹理**（Texture）** 输入。
4. 在Texture Sample节点上，将 **UV（UVs）** 字段设置为与静态网格体上的 **网格体绘制纹理坐标索引（Mesh Paint Texture Coordinate Index）** 或静态网格体组件上的 **重载网格体绘制纹理坐标索引（Overridden Mesh Paint Texture Coordinate Index）** 匹配。

> [!NOTE]
> 要详细了解如何设置此项，请参阅下文["为纹理颜色绘制设置网格体"](#%E4%B8%BA%E7%BA%B9%E7%90%86%E9%A2%9C%E8%89%B2%E7%BB%98%E5%88%B6%E8%AE%BE%E7%BD%AE%E7%BD%91%E6%A0%BC%E4%BD%93)小节。

在材质图表中完成这部分设置后，你可以将 **Texture Sample** 节点的 **RGB** 输出连接到主材质节点的 **基础颜色（Base Color）** 输入。此设置将仅使用网格体绘制纹理作为网格体的材质。

或者，如果你想将此工作流程集成到与网格体已使用的现有材质中，可以使用一个 **Multiply** 节点，将材质逻辑连接到主材质节点的基础颜色输入。在此设置中，网格体绘制纹理将用于为底层基础材质的绘制区域着色。

此设置可以如下所示：

### 为网格体绘制纹理材质设置回退逻辑

有时，材质应用于没有网格体绘制纹理的网格体，或者平台不支持网格体绘制纹理所需的虚拟纹理。在这些情况下，你需要为材质设置一个回退选项，以便正确渲染。

请按照以下步骤在材质图表中设置一些逻辑，以便在无法对网格体绘制纹理取样时使用替代方式：

1. 右键点击材质图表，并添加

   MeshPaintTextureReplace

   节点。
2. 在带有 **MeshPaintTextureObject** 节点的 **Texture Sample** 节点上，拖移 **RGB** 输出并将其连接到 **MeshPaintTextureReplace** 节点的 **MeshPaintTexture** 输入。
3. 在MeshPaintTextureReplace的 **默认（Default）** 输入上，你可以接入其他材质逻辑，以替代MeshPaintTexture路径使用。为了简单起见，你可以使用Texture Sample节点或ConstantVector3设置颜色。

在材质图表中完成这部分设置后，你可以将 **MeshPaintTextureReplace** 节点的输出引脚连接到主材质节点的 **基础颜色（Base Color）** 输入。这就提供了两条简单的路径：如果使用该材质的网格体有一个网格体绘制纹理，则使用该路径；否则将使用默认路径。

或者，你可以将反射率输出拆分为两条路径，将这一逻辑集成到现有的材质图表中：一条是未更改的路径，将其接入默认输入；另一条是MeshPaintTexture路径，利用MeshPaintTextureObject逻辑，带有一个Multiply节点。

此设置可以如下所示：

以下是上述两种材质图表的示例，每个示例都显示了一个网格体，一个有网格体绘制纹理，一个没有网格体绘制纹理，但它们都使用了相同的材质。

| 列 1 | 列 2 |
| --- | --- |
|  |  |
| 最基础的MeshPaintTextureReplace。左边是MeshPaintTexture路径，右边是默认路径。 | MeshPaintTextureReplace设置与现有材质集成，作为默认纹理。左边是MeshPaintTexture路径，右边是默认路径。 |

## 为纹理绘制材质设置网格体

按照以下小节设置网格体，以正确使用纹理颜色绘制和网格体绘制纹理。这些小节将详细介绍如何设置和指定合适的UV，以及应如何将它们应用于网格体的材质，以很好地处理纹理颜色绘制。

### 静态网格体要求

使用 **MeshPaintTextureObject** 材质表达式的 **Texture Sample** 节点上的 **UV（UVs）** 值应与静态网格体的 **网格体绘制纹理坐标索引（Mesh Paint Texture Coordinate Index）** 匹配。这确保了静态网格体的材质使用正确的UV，从而绘制到生成的网格体绘制纹理。

如需详细了解MeshPaintTextureObject材质表达式，请参阅上文的["设置纹理绘制材质"](#%E8%AE%BE%E7%BD%AE%E7%BA%B9%E7%90%86%E7%BB%98%E5%88%B6%E6%9D%90%E8%B4%A8)。

### 检查网格体UV

要检查用于纹理颜色绘制的网格体UV坐标，请执行以下步骤：

1. 从内容浏览器打开一个静态网格体资产。
2. 在静态网格体编辑器工具栏中，使用 **UV** 下拉菜单查看有哪些可用的UV通道。从列表中选择一个项目进行检查。

在检查UV是否适合纹理颜色绘制时，你需要查看是否存在重叠、平铺或重复的UV。如果存在这些问题，你需要创建一个UV通道来布置UV图表，使得几何体的每个部分都有一个唯一ID。

以下方虚幻引擎自带的 **立方体** 形状的UV为例：

- UV通道0存在面重叠的情况，其中立方体的每一个面相互叠加，填满了整个UV空间。
- UV通道1是在静态网格体编辑器中生成的，因此没有UV图表相互重叠，立方体的六个面在UV空间中都有各自独立的位置。

| 列 1 | 列 2 |
| --- | --- |
|  |  |
| 不适用于纹理颜色绘制的UV。 | 适用于纹理颜色绘制的UV。 |

为了理解为何这些UV不适用或适用，下面展示了在网格体上使用重叠、重复或平铺的UV进行绘制的效果，并且与网格体的每个面都有唯一ID的UV进行了对比。

| 列 1 | 列 2 |
| --- | --- |
|  |  |
| 不适用于纹理颜色绘制的UV的效果。 | 适用于纹理颜色绘制的UV的效果。 |

### 为纹理颜色绘制生成UV

要在静态网格体编辑器中生成一个新的UV集，请执行以下操作：

1. 转到

   细节（Details）

   面板，向下滚动到

   LOD 0

   类别，并展开

   构建设置（Build Settings）

   的选项。
2. 勾选 **生成光照贴图UV（Generate Lightmap Uvs）** 旁边的复选框。
3. 在生成UV时，还可以更改一些对网格体有好处的其他可选设置：

   - 最低光照贴图分辨率（Min Lightmap Resolution）

     可设置UV的目标分辨率。此设置用于确定UV图表在可用UV空间中的布局间距。例如，分辨率为64时，UV图表之间的间距会比分辨率为256时更大。这意味着UV图表可以排列得更为紧密，并且部分图表能够可以放大。
   - 源光照贴图索引（Source Lightmap Index）

     使用此UV通道生成新UV。某些网格体可能拥有多个UV，因此你可以选择最适合的UV来生成新UV。在大多数情况下，UV0是生成新UV的最佳选择。
4. 使用 **目标光照贴图索引（Destination Lightmap Index）** 设置你想要为其生成光照贴图UV的值（UV通道）。

   > [!NOTE]
   > 此值应自动设置为下一个可用的UV通道插槽，以避免影响已为网格体创建的UV通道。你可以根据网格体的需求更改此值或使用此值。
5. 点击

   应用更改（Apply Changes）

   。

要查看结果，你可以使用静态网格体编辑器工具栏中的 **UV（UVs）** 下拉菜单。选择你要查看的UV通道。

### 为纹理颜色绘制设置UV

要设置用于纹理颜色绘制的UV，请执行以下操作：

1. 在

   细节（Details）面板

   中，找到

   通用设置（General Settings）

   类别。
2. 在 **网格体绘制纹理坐标索引（Mesh Paint Texture Coordinate Index）** 的文本字段中，输入一个与你想要用于网格体纹理绘制的UV通道对应的 **数字** 。例如，UV通道输入0，UV通道1输入1，依此类推。

要正确使用此设置，需要在使用 **MeshPaintTextureObject** 材质表达式的 **Texture Sample** 节点的 **UV（UVs）** 输入上设置此坐标索引，请参阅上文的["设置纹理绘制材质"](#%E8%AE%BE%E7%BD%AE%E7%BA%B9%E7%90%86%E7%BB%98%E5%88%B6%E6%9D%90%E8%B4%A8)开始操作。

> [!TIP]
> 如果你发现绘制效果存在与UV相关的不一致问题，请检查 **网格体绘制纹理坐标索引（Mesh Paint Texture Coordinate Index）** 和带有 **MeshPaintTextureObject** 表达式的 **Texture Sample** 节点是否使用了相同的UV坐标。
