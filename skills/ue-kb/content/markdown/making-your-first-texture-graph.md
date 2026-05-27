# Making your First Texture Graph

---
title: "Making your First Texture Graph"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/making-your-first-texture-graph-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "纹理", "Getting started with Texture Graph", "Making your First Texture Graph"]
---

# Making your First Texture Graph

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 纹理 / Getting started with Texture Graph / Making your First Texture Graph

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/making-your-first-texture-graph-in-unreal-engine

该 **Texture Graph Editor** 是一个基于节点的界面，用于在 Unreal Engine 中以程序化方式创建纹理。本指南将带你制作一个生成自定义 UV 棋盘图案的 texture graph。

该图表提供 tile 数量、颜色、网格线和箭头的自定义选项。构建此图表的过程会涉及 texture graph 相关的一些核心概念和工作流。

> [!NOTE]
> 在构建第一个图表之前，建议先查看 [Texture Graph Editor](../index.md) 指南，以了解编辑器概述和一些常用基础概念。

## 加载插件

Texture Graph Editor 是实验性插件，启动引擎时默认不会加载。

要启用此插件，请执行以下步骤：

1. 在

   菜单栏

   中选择

   Edit > Plugins

   .
2. 在搜索栏中输入“texture graph”。
3. 启用

   TextureGraph

   插件，并在弹出的对话框中选择

   Yes

   。
4. 重启引擎。

## Texture Graph 资产

要创建新的 texture graph，请执行以下步骤：

1. 打开

   Content Drawer

   并点击

   Add > Texture > Texture Graph

   .
2. 将新资产重命名为“TG_UVChecker”。
3. 保存资产，然后双击它以打开编辑器。

## 构建基础棋盘 Tile

此图案的基础是一个可以重复和编辑的 2x2 tile。

本指南会从头构建图案，以演示一些工作流和用户控制方式。

> [!TIP]
> 如果需要快速得到棋盘图案，可以查看 **Pattern** 节点，该节点提供多种标准图案类型选项。

要开始创建棋盘图案，请执行以下步骤：

1. 在节点面板中，进入

   Procedural

   分组，然后将

   Shape

   节点拖入图表。点击向下箭头展开该节点，以查看所有可用选项。
2. 将

   ShapeType

   改为矩形。
3. 点击并拖出

   Output

   引脚。释放选择后，节点面板会打开。搜索并选择

   Transform

   。Shape 和 Transform 节点会自动连接。

   1. 使用此技巧创建节点时，请记住连接会接到最上方的输入值。
4. 展开

   Transform

   节点，并将

   Coverage

   调整为 0.5, 0.5。在 Transform 中调整 coverage 会将输入图像（此处为简单矩形）缩放到指定值。默认情况下，填充颜色没有颜色或 alpha 值。可以在 details 中设置填充颜色。
5. 从

   Shape

   节点拖出第二个

   Transform

   节点。将

   Coverage

   在第二个 Transform 上设置为 0.5, 0.5，并将

   Offset

   设置为 0.5, 0.5。现在可以最小化 Transform 节点，使其占用更少空间。
6. 在图表视图中右键单击，并在菜单中找到

   Add

   节点，可以向下滚动到 math 分组或直接搜索。
7. 将 Transform 节点的输出值连接到 **Add** 节点的 A 和 B 输入。结果是单个四格棋盘 tile。

   ![Shape and Transform Nodes](../../../../../assets/images/03/03f446e2861863e2c47675c45827c3e34ab91dc1e5ae1d3c95c7487be8b19589.jpg)
8. 构建图表时，保持组织清晰很重要。选择所有节点，右键单击图表，然后搜索并选择

   New Comment

   。注释框会包含这四个节点。将注释命名为“CheckerBlock”。

![base checker block](../../../../../assets/images/93/9370ce1943f5d3f5a0cf1efe121f46a52e093a4c4fb1123061d3e7da4edd250f.png)

## 创建分割线

有了基础棋盘块后，可以叠加分割线，并控制线条厚度和圆角半径值。

要添加分割线，请执行以下步骤：

1. 创建

   Shape

   节点，将 shape 设置为 rectangle，并将宽度和高度设为 0.9。
2. 拖出 Shape 节点的输出引脚，然后搜索并选择

   Transform

   .
3. 在 Transform 节点中，将

   Repeat

   值设置为 2.0,2.0。
4. 拖出输出引脚，然后搜索并选择

   Invert

   。该节点会为线条遮罩提供正确值。
5. 在 Invert 节点中启用 **Clamp**.

   ![Procedural Divided Lines](../../../../../assets/images/19/19f9a3edfbd3129df60ee97ee1da840fea12b49338138a3f4733e652821ad186.png)
6. 线条的基础结构创建完成后，可以添加一种机制来调整线条厚度和圆角半径。在图表中右键单击，然后搜索并选择

   Scalar

   .
7. 右键单击该节点并选择

   Rename

   ，将节点重命名为“Rounded Corners”。将该节点连接到

   Rounding

   引脚，该引脚位于

   Shape

   节点。将值设置为 .25。
8. 重复此过程 3 次，创建多个 scalar 节点，并将它们重命名为“LineThickness”、“SquareBase”和“LineMult”。然后拖出

   LineThickness

   引脚，然后搜索并选择

   Multiply

   。
9. 将

   LineMul

   t 输出连接到

   B

   引脚（位于 Multiply 节点），并将值设置为 0.1。
10. Drag out the

    SquareBase

    引脚，然后搜索并选择

    Subtract

    。
11. 将

    Multiply

    节点的输出连接到

    B

    值（位于 Subtract 节点）。
12. 将 Subtract 的输出引脚连接到

    Width

    and

    Height

    值，这些值位于

    Shape

    node.
13. 选择所有节点，并在它们周围创建新的注释框，以帮助组织图表。

![Rounded Corners](../../../../../assets/images/fd/fd476e65a82db67aee11e6c733fdff2a2d47cf6ef4ed5fbd151cf1c381dc1251.png)

## 创建箭头

为帮助辨识图案方向，可以在每个方格中心添加一些箭头。

要添加最后这个元素，请执行以下步骤：

1. 在图表中右键单击，然后搜索并选择

   Shape

   。重复此步骤以创建两个 Shape 节点。
2. 将第一个节点的 shape 设置为

   Triangle

   ，然后将宽度设置为 0.6。
3. 拖出输出引脚，然后搜索并选择

   Transform

   。将

   Offset

   值设置为 0.0,0.05。
4. 将第二个 Shape 节点设置为

   Rectangle

   ，然后将宽度设置为 0.1，高度设置为 0.4。
5. 拖出输出引脚，然后搜索并选择 Transform。将

   Offset

   值设置为 0.0,0.8。
6. 在图表中右键单击，然后搜索并选择

   Add

   。将 Transform 节点的输出引脚连接到 Add 节点。
7. 选择 **Add** 节点，然后在预览窗口中点击锁定图标。即使选择其他节点，该图标也会将预览锁定到该节点。锁定预览让你可以编辑 Transform 值并查看最终结果。

   ![Procedural Arrow](../../../../../assets/images/a8/a8892edde69cccd311f7f952f43901f63442ea5b7d094eba81293858ea86c3a1.png)
8. 将单个箭头形状转换为标准四格 tile 基础。为此，从

   Add

   节点拖出输出引脚，然后搜索并选择

   Transform

   .
9. 在 Transform 节点中，将

   Repeat

   值设置为 2.0, 2.0。
10. 取消预览锁定，以查看其他节点预览。
11. 箭头略大。将

    Zoom

    值设置为 -0.1，以缩放每个重复 tile。负值会缩小视图，因此箭头会变小。
12. 缩小后会暴露每个 tile 之间的空白区域。在

    Details

    面板中，点击

    Fill Color

    值，并将

    A

    （alpha）值设置为 1。颜色默认已经设置为黑色。调整这些值会创建实体遮罩。
13. 选择所有节点，并在它们周围创建新的注释框，以帮助组织图表。

## 连接组件并添加颜色

现在已经有了制作可缩放棋盘图案所需的核心构建块。可以添加更多类似网格线部分的控制，以便将来调整图案。

1. 从最重要的元素开始：棋盘颜色。从节点面板拖出 2 个 Color 节点。
2. 将这些节点重命名为“CheckerColorA”和“CheckerColorB”。
3. 调整

   Color

   节点，在

   Details

   面板中设为所需棋盘颜色。
4. 从

   CheckerColorA

   拖出输出引脚，然后搜索并选择

   Blend

   。Blend 节点是功能强大的函数，提供许多用于复杂混合操作的特性。本示例保持默认设置。
5. 将

   CheckerColorB

   的输出引脚连接到

   Background

   值，该值位于 Blend 节点。
6. 从

   Add

   节点（位于 CheckerBlock）输出引脚拖出新的

   Transform

   node.
7. 创建新的

   Scalar

   节点，并将其重命名为“CheckerRepeat”。
8. 将

   CheckerRepeat

   值设置为 2.0。
9. 将

   CheckerRepeat

   的输出引脚连接到

   Repeat

   输出引脚连接到新创建 Transform 节点的引脚。单个 scalar 输入会同时应用到 X 和 Y repeat 值。
10. 将 **Transform** 节点的输出连接到 **Mask** 值，该值位于 Blend 节点。

    ![Base Checker Color](../../../../../assets/images/86/86ea7e9f889aa041921f13900ac6faeb95d443b172e6bfdae57573f0bdb737ac.jpg)

### 网格线颜色

可以对网格线重复类似工作流。当前已经有线条厚度和圆角控制，但还没有线条颜色设置。

1. 创建新的

   Color

   节点，并将其重命名为“LineColor”。
2. 调整

   LineColor

   节点，在

   Details

   面板中设为所需棋盘颜色。
3. 拖出

   LineColor

   节点拖出输出引脚，然后搜索并选择

   Blend

   .
4. 将之前棋盘 Blend 节点的输出引脚连接到

   Background

   输入（位于新的 Blend 节点）。
5. 在 GridLines 注释框中，拖出

   Invert

   节点的输出引脚，然后搜索并选择

   Transform

   .
6. 将

   CheckerRepeat

   节点的输出连接到

   Repeat

   输入（位于新的 Transform 节点）。同一个输出引脚可以多次使用。
7. 将

   Transform

   节点的输出连接到

   Mask

   输入（位于新的 Blend 节点）。

![Grid Line Color](../../../../../assets/images/95/952107d105a1c3cfe4497db5bba457b7e6076841907192c7dde8fabdafa09dbd.jpg)

### 箭头颜色

重复此过程，将箭头添加到棋盘图案上方。

1. 创建 Color 节点，并将其命名为“ArrowColor”。
2. 调整

   ArrowColor

   节点，在

   Details

   面板中设为所需棋盘颜色。
3. 拖出

   ArrowColor

   节点拖出输出引脚，然后搜索并选择

   Blend

   .
4. 将之前棋盘 Blend 节点的输出引脚连接到

   Background

   输入（位于新的 Blend 节点）。
5. 在 Arrow 注释框中，拖出

   Transform

   节点拖出输出引脚，然后搜索并选择

   Transform

   .
6. 将

   CheckerRepeat

   节点的输出连接到 新 Transform 节点的

   Repeat

   输入。
7. 将

   Transform

   节点的输出连接到

   Mask

   输入（位于新的 Blend 节点）。
8. 拖出 Blend 节点的输出引脚，然后搜索并选择

   Output

   。将 Output 节点重命名为“BaseColorOutput”。

![Arrow Color](../../../../../assets/images/8e/8eb98df0107e715ad7ce2c423400589474da60267a95754149b6e0091396be56.jpg)

## 输出与导出

该 **Output** 节点包含常用纹理属性、输出名称、文件夹路径和分辨率设置。

> 图片已省略：Color Output

可以向单个图表添加多个输出。为需要颜色、粗糙度、法线和金属度贴图的材质创建更复杂纹理集时，此工作流很有用。

要设置多个输出类型，请执行以下步骤：

1. 在 GridLines 注释框中，拖出

   Transform

   节点拖出输出引脚，然后搜索并选择

   BrightnessContrast

   .
2. 将 Brightness 调整为 0.5，以创建更平坦的灰度图像。
3. 拖出 BrightnessContrast 节点的输出，以创建新的

   Output

   节点。将该节点重命名为“RoughnessOutput”。
4. 从前一个 Transform 节点拖出输出引脚，然后搜索并选择

   NormalFromHeightMap

   .
5. 拖出

   NormalFromHeightMap

   节点的输出，以创建新的

   Output

   节点。将该节点重命名为“NormalOutput”。
6. 调整每个输出节点的输出名称和压缩设置。

   > 图片已省略：image alt text
7. 在主菜单栏中点击

   Export

   .

导出窗口会打开，并将输出节点显示为可输出的贴图。可以根据需要选择或取消选择这些贴图，以迭代其中一个或全部贴图。点击 **Export** 以在窗口中创建新的纹理贴图。

> 图片已省略：Texture Export Window

Texture Graph Editor 可用于广泛的纹理工作流，包括对现有纹理进行基础编辑、创建新纹理、打包、制作图集，或与蓝图结合使用。可以将 texture graph 作为管线工具，辅助常见流程。

要继续学习 texture graph，请查看以下页面。


- [Texture Graph 入门](../index.md)

%designing-visuals-rendering-and-graphics/textures/texture-graph-editor/texture-graph-node-referenc:topic%

