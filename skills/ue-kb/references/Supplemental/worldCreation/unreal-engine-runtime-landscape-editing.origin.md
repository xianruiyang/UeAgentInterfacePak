# 运行时景观编辑

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/vzrZ/unreal-engine-runtime-landscape-editing

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 5135 字符。

## 摘要

运行时景观编辑由 Ryan B 撰写的文章。有关运行时编辑景观的信息是很常见的，本文旨在分享对实现此目标所涉及的内容的见解...

## 中文整理

### 概览

*由 [Ryan B.](https://dev.epicgames.com/community/profile/23wL/RyanBickell) 撰写的文章* 在运行时编辑景观的信息是很常见的，本文旨在分享在不实施全新系统的情况下实现这一目标所涉及的内容。

景观编辑图层是仅限编辑器使用的功能，也是实现景观程序修改的唯一方法。

没有运行时挂钩，因为中间数据（所谓的“编辑层”）完全是编辑器专用的，并且大多数代码仅在编辑器中定义。

编辑图层在 GPU 上的编辑器中折叠/合并到最终的高度图/权重图集（请参阅 LandscapeEditLayers.cpp），并且在目标平台上执行此操作本质上没有什么不可能，前提是它们实现了高于 Shader Model 5.0 的功能集（目前所有非移动平台和大多数移动平台都是这种情况），但代码量和景观的影响（导航网格、碰撞、游戏玩法等）使得将其转变为支持运行时的功能是一项巨大的努力。

这是一个大纲，希望可以作为一个很好的起点，了解在运行时可修改景观在技术上最可能需要的内容。

请注意，您可能会发现除以下步骤之外还需要其他步骤，这需要我们为您进行进一步调查。

1.

将世界位置偏移 (WPO) 添加到从另一个纹理（单个附加层）或纹理阵列（多个层）读取的材质。

这可能或多或少复杂，具体取决于 (a) 整个景观是否可以在运行时加载，并且所需的只是每个附加层的单个纹理或渲染目标，或者 (b) 景观只能部分加载，并且与当前景观类似，高度图/权重图需要拆分为多个纹理/渲染目标（很可能每个景观组件一个）。

然后，两者都会置换顶点（仅在垂直方向上，如果您希望碰撞仍然由高度场表示）并根据其邻居计算法线（请参阅 Engine\Shaders\Private\Landscape\LandscapeLayersHeightmapsPS.usf 中的 FinalizeHeightmap）。

2.

使用横向 MID 而不是 MIC 将这些纹理绑定到材质。

为此，需要在景观 actor 上将 bUseDynamicMaterialInstance 设置为 true，然后绑定高度图/权重图纹理。

在上面的 (b) 情况中，每个组件都需要接收自己的纹理。

3.

当发生以下变化时重新生成碰撞组件： 4.

从 GPU 读回合并的高度图/权重图。

这可以通过复制到暂存纹理、写入 GPU 栅栏并在 GPU 上轮询该栅栏来异步完成。

这是 FLandscapeEditLayerReadback 的目的，但 FLandscapeGrassWeightExporteror 也可以搭载，因为它也能够导出 WPO（请参阅 ULandscapeComponent::RenderWPOHeightmap）。

在这两种情况下，这都会导致至少 2 帧的延迟，因为 GPU 始终落后于 RHI 线程/渲染线程/游戏线程，并且异步读回操作涉及保持刷新率恒定，但也不会立即获取结果。

为了使进程同步，可以调用 FlushRenderingCommands()。

这会给游戏带来麻烦，因为 CPU 将等待 CPU 赶上并执行所有飞行命令（直到最后一个：回读命令）。

5.

或者，如果您的图层高度图更改源自 CPU，请连接到 ULandscapeHeightfieldCollisionComponent 并在那里重建高度场数据。

6.

如果使用程序放置草（即

该材质使用 LandscapeGrassOutput 生成不同类型的草），然后需要使草无效并生成新的草数据（即

草的密度图）。

请参阅 LandscapeGrass.cpp。

7.

如果修改权重图，则需要输出正确的物理材质指数。

与草类似，这是在编辑器中使用材质中的 LandscapePhysicalMaterialOutput 完成的，并运行景观材质的专用版本，以便正确渲染主要物理材质的索引，然后在 CPU 上异步读回并存储到 ULandscapeHeightfieldCollisionComponent 中。

8.

重新生成导航网格。

希望这些信息足以让您开始设计您的项目。

无论您选择哪种方法，都不要低估所涉及的工作。

如前所述，景观代码非常庞大，并且是许多其他游戏内系统（物理、渲染等）的源头。

它还在内存使用、渲染和流性能方面发挥着不可忽视的作用。

在运行时而不是编辑时移动它们可能需要一些工作才能使其达到可接受的状态。

在[知识库！](https://forums.unrealengine.com/docs) 中获取更多答案

