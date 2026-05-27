# 为nDisplay创建次级UV

---
title: "为nDisplay创建次级UV"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/creating-secondary-uvs-for-ndisplay-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "使用nDisplay在多显示屏上进行渲染", "为nDisplay创建次级UV"]
---

# 为nDisplay创建次级UV

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 使用nDisplay在多显示屏上进行渲染 / 为nDisplay创建次级UV

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/creating-secondary-uvs-for-ndisplay-for-unreal-engine

> [!NOTE]
> 本指南仅适用于投影网格体的UV1。[UV信道0仅用于nDisplay中采用网格体投影策略的扭曲映射。](../projection-policies-in-ndisplay/index.md)

鉴于 **nDisplay** 对投影网格体应用"2D风格"特效的方式，我们会使用二级UV信道，并希望网格体上的所有UV外壳都具有相同的纹素密度，且所有UV外壳都不存在重叠。

另外还需要考虑舞台的形状。以一面非常宽的连续LED墙体为例，即便墙体由不同的独立网格体组成，也应该始终使用一组连续的UV，就像现实中的墙体那样。 我们将使用 **ICVFXExample项目** 中的舞台网格体。如果你愿意遵照本指南，请转到 `/Content/nDisplayConfigs/Meshes` ，将相关静态网格体Actor导出为 **FBX** ，然后用你选用的数字内容创建软件继续。

虽然上图似乎没有充分利用UV空间，但让次级UV组中的外壳能代表现实中对应事物的构造才是重点。本例中，这两个网格体的接缝位于弧形墙的中段。此配置下的棋盘格纹理布置正确。这对 **nDisplay** 的 **色键（Chroma key）** 模式非常重要，因为不正确的布局和不均匀的纹素密度会导致标识被截断，并在体积各处出现尺寸不统一。

上方示例就更好地利用了UV空间，但并不适合摄像机内视效编辑器的需求。可以看到棋盘格的布置并不正确。穿过中段接缝的 **UV发光板** 看起来也不正确。

对天花板等 **公共平面的面板组** 而言，如果平面存在任何突出的特征（例如间隙），最好进行 **平面投影** 处理。间隙必须与现实中的间隙成比例，否则将无法正确转换 **UV空间特效** 。在下方示例中，你可以看到 **UV发光板** 是如何在编辑器视口nDisplay预览中保持了正确的比例。

处理前：在视口nDisplay预览中移动时，UV发光板无法保持正确的比例。

处理后：在视口nDisplay预览中移动时，UV发光板保持了正确的比例。

同时还必须考虑UV外壳的布局和方向。外壳在UV中翻转会造成反直觉的反馈，比如感觉功能按钮变得"朝后"。

请看上图，当发光板"超出"弧形墙体顶部时，它会有一部分被显示在天花板上。最好将天花板的UV1外壳移到离UV1墙体更远的地方，这样当UV发光板位于墙体UV外壳的边缘外时，会有空间供其"隐藏"。

所列网格体应彼此分离，因此导出时不要将它们合并。你可以在打开数字内容创建软件的UV布局编辑器时，单独选择各网格体，对它们同时进行处理。

