# 在 UEFN 中创建大型景观

# 在 UEFN 中创建大型景观

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/B9RD/unreal-engine-fortnite-creating-large-landscapes-in-uefn

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 6657 字符。

## 摘要

在 UEFN 中创造广阔的世界

## 中文整理

### 概览

在 UEFN 中创建大型景观

![在 UEFN 中创建大型景观](assets/unreal-engine-fortnite-creating-large-landscapes-in-uefn/image-01.jpg)

你好！本教程将介绍使用 Gaea 在 UEFN 中创建大型、高效景观的过程。我们使用这种技术来构建星球大战工具包中包含的起始群岛的景观。您可以在您想要构建的任何世界上使用此技术 - 它不仅限于星球大战工具包。 UEFN 中大世界的主要挑战是景观参与者对记忆的相对较大的影响。经过一些实验，我们最终选择了景观和静态网格体的组合，在高性能包中创建了宽敞的游戏空间和广阔的视野。在较高的层面上，我们使用 Gaea 创建一个程序地形。然后，我们使用下面概述的过程来创建一个由 4K 静态网格物体包围的 2K 景观。我们使用《星球大战》工具包之外提供的远景山脉来完成幻觉。景观和静态网格物体并未完美对齐，但它们足够接近。在我们的测试中，2K 风景实在是太占用内存了。相反，我们使用 1K 景观，将其长度和宽度放大 200%。为了创建 4K 静态网格物体 vista 网格物体，我们直接从 Gaea 导出 4K 网格物体，并移除内部 50% 的面，在中心留下一个 2K 孔。网格和景观在引擎中对齐。让我们更详细地看看这个过程。首先，您需要在盖亚中创建一个程序景观。对于此示例，我将使用 Canyon 节点和 EasyErosion 生成一个简单的景观。如果您是 Gaea 新手，我有一个介绍性教程系列[此处](https://www.youtube.com/watch?v=AaKrTiJhqbc&list=PLpoXxlr0idMkhrSRlGcD38DDbpGsSmP1y)。

![盖亚景观](assets/unreal-engine-fortnite-creating-large-landscapes-in-uefn/image-02.jpg)

![峡谷设置](assets/unreal-engine-fortnite-creating-large-landscapes-in-uefn/image-03.jpg)

当您准备好导出高度图和网格时，设置构建目标。这是您的文件将导出到的位置。打开构建设置和区域菜单。选择地形选项卡，并将宽度设置为 4032，高度设置为 2500。

![教程图片](assets/unreal-engine-fortnite-creating-large-landscapes-in-uefn/image-04.jpg)

将 Mesher 节点和 Unreal 节点添加到网络末端。对于 Mesher 节点，将格式设置为 FBX，将比例设置为千米，将拓扑设置为四边形，并将每边的顶点设置为 512。256 将用于测试 - 请参见下图进行比较。对于 Unreal 节点，可以接受默认设置。设置导出目录并构建网格和高度图。

![教程图片](assets/unreal-engine-fortnite-creating-large-landscapes-in-uefn/image-05.jpg)

导出网格后，您将需要删除内部 50% 的面，为景观腾出空间。我们编写了一个 Maya Python 脚本来处理此任务。如果您是 Maya 用户，欢迎您使用该脚本，该脚本包含在本文的底部。将网格导入 Maya，打开脚本编辑器，然后将代码粘贴到 Python 选项卡中。选择网格并运行代码。

![教程图片](assets/unreal-engine-fortnite-creating-large-landscapes-in-uefn/image-06.jpg)

除了移除内部面外，枢轴的位置还便于与 UEFN 中的景观对齐。将网格导出为 FBX。一旦确认网格有效，您可以选择将其分成更小的部分以帮助剔除。网格将细分为 12 个正方形部分，但您需要手动执行此操作。确保将枢轴保持在同一位置。对于高度图，我们需要将图像裁剪为其原始大小的 50%，然后再次将该图像缩小 50%。高度图的工作原理是将每个像素值应用于地形的每个顶点。换句话说，您需要 1 - 1 的像素与顶点比率。因为我们要将 1k 景观放大到 2k，所以我们需要从 1k 高度图开始。在 Gaea 中，分辨率会有意义地改变输出。我们不能只生成 2k 的高度图并将其裁剪为 1k - 我们必须同时获取 4k 的网格和高度图。在 Photoshop 中打开高度图。将画布大小设置为宽度和高度的 50%。目标是剪辑图像。

![教程图片](assets/unreal-engine-fortnite-creating-large-landscapes-in-uefn/image-07.jpg)

您现在有一个尺寸为 2033 x 2033 的图像。使用图像大小，将其宽度和高度减小 50% 至 1009x1009。将高度图另存为 PNG 格式。

![教程图片](assets/unreal-engine-fortnite-creating-large-landscapes-in-uefn/image-08.jpg)

您已准备好设置您的景观。在 UEFN 中开启新的关卡。删除所有默认网格体和水体 actor。选择横向模式 -> 管理 -> 从文件导入。选择高度图，确认分辨率为 1009x1009，然后选择导入。

![景观导入选项](assets/unreal-engine-fortnite-creating-large-landscapes-in-uefn/image-09.jpg)

您需要先保存关卡，然后才能更改景观的材质实例。预配置的生物群系景观材质实例可在 /Fortnite/Materials/Landscape/MaterialInstances 中找到 - 火山 - FNEC_MI_Biome_Volcanic_Landscape_A - 沙漠 - FNEC_MI_Biome_Desert_Landscape_A - 雪 - FNEC_MI_Biome_Snow_Landscape_A 您需要在材质实例上设置一个使用标志，以便它能够与您的网格一起使用- 右键单击上面的材质之一，然后选择“创建材质实例”。将新材料保存在项目文件中。打开新材质，过滤*标志*，然后启用 Nanite。

![启用 Nanite 使用标志](assets/unreal-engine-fortnite-creating-large-landscapes-in-uefn/image-10.jpg)

启用选择模式。在大纲视图中选择根景观 actor 并应用新的材质实例。景观的枢轴将位于其中一个角，并且可能会从实际角垂直偏移。这与高度图如何修改Landscape有关。目前，景观的默认位置（X=-100800.0，Y=100800.0，Z=0.0）就可以了。导入您的 vista 网格，应用材质实例，然后将其拖动到关卡中。在 X、Y 和 Z 方向上将其缩放 1000。复制景观的位置并将其粘贴到 vista 网格的位置。它应该位于景观上方或下方。移动 vista 网格，使角与景观对齐。远景网格和景观可能无法在其他地方对齐 - 我们很快就会修复这个问题。景观的垂直延伸可能远低于 0，这会给游戏玩法带来问题。要确定景观的位置，请在原点添加一个缩放至 10 倍的球体。选择根景观 actor 和 vista 网格物体，然后垂直移动它们，使景观与球体相交。在我们的测试中，有时远景网格与景观对齐，有时需要调整。将角对齐后，选择 vista 网格并擦洗 Y 比例值，直至其与景观对齐。缩放网格，而不是景观。由于景观 actor 处理 LOD 的方式以及高度图和几何体之间的转换存在差异，因此两者可能无法完美对齐。您应该能够使用岩石、悬崖或远景网格覆盖小接缝。在下图中，您可以看到 2K 景观，使用 Sandcrawler 进行缩放，与 vista 网格清晰对齐。使用 Gaea 的另一个好处是它能够根据地形数据生成图层蒙版，这对于奠定基础景观绘画有很大帮助。我希望这对您有所帮助：）请随时在评论部分留下问题或建议。

**Maya Python - 删除内部面**

```
# Maya Python script to remove interior faces on mesh exported from Gaea

import maya.cmds as cmds

def return_face_center(face, pivot = False):
    """
    Return face center
    """
    vertices = cmds.ls(cmds.polyListComponentConversion(face, ff = True, tv = True), flatten = True)
    sum_x = sum_y = sum_z = 0.0
```


