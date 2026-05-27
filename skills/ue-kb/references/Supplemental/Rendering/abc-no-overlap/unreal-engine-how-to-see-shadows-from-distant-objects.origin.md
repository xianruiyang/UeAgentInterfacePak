# 如何看到远处物体的阴影

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/q5Po/unreal-engine-how-to-see-shadows-from-distant-objects

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 5187 字符。

## 摘要

Matt O 撰写的文章。如何看到远处物体的阴影 假设您正在制作一座大城市或大型开放世界景观，并且您有一个...

## 中文整理

### 概览

文章由马特·O.

### 如何看到远处物体的阴影

假设您正在制作一个大城市或一个大型开放世界景观，并且您在远处有一个应该投射阴影的大型特征。但出于某种原因，你的高楼或山并没有投射阴影！让我们了解一下如何从定向光计算动态阴影，以及我们有哪些系统可以确保远处的物体能够以高性能的方式投射阴影。以下是定向光如何在光栅（非光线追踪）中投射动态阴影的高级概述：

### 级联阴影贴图

定向光投射的动态阴影使用称为级联阴影贴图的系统。

系统根据灯光使用的级联数量，将场景从摄像机向外划分为动态阴影距离可移动或动态阴影距离固定（取决于灯光的移动性设置）的级联。

这些级联之间的分布和过渡可以通过灯光本身的设置来控制。

您可以在我们的定向光文档中阅读更多相关信息。

然后，灯光将从灯光的角度渲染一张深度图，以投射阴影，每个部分都有一个阴影。

因此，如果灯光的动态阴影距离为 15000，并且有 3 个级联，则第一个级联保存距相机 0 到 4999 个单位的所有阴影信息，下一个级联将覆盖距相机 5000 到 9999 个单位的所有内容，最后一个级联将覆盖 10000 到 15000 个单位。

级联阴影贴图还有一个额外的好处，即可以按原样渲染所有内容的阴影。

如果树摇摆，影子也会摇摆。

如果角色变形或动画，阴影也会相应地变形和动画。

缺点是这种绘制阴影的方法渲染成本可能很高，并且费用随着使用的级联数量和必须绘制到阴影贴图中的对象数量（随着动态阴影距离的函数而增加）而增加。

级联阴影贴图具有固定的分辨率（由 cvar r.Shadow.MaxCSMResolution 设置），因此随着动态阴影距离的增加，每个级联的有效纹素密度将减少，从而导致模糊阴影。

您可以增加级联数量，但如前所述，这可能会对性能产生不利影响。

那么，我们如何才能确保远处的物体投射阴影而不牺牲动态阴影分辨率或 GPU 性能呢？

### 距离场阴影

第一个选项是使用距离场阴影，我们在距离场软阴影和使用距离场阴影的文档中对此进行了更深入的讨论。距离场阴影覆盖动态阴影距离和距离场阴影距离设置之间的距离，因此它们在级联阴影贴图阴影之后开始。距离场会增加内存和烹饪成本，因为我们必须为每个静态网格物体生成网格距离场，并在物体移动时更新全局距离场。然而，由于这些阴影是基于几何图形的静态和数学表示来计算的，因此与基于深度的动态阴影相比，它们的计算成本要低得多。由于静态网格体的距离场表示是不变形的（即不受世界位置偏移的影响），因此树投射的距离场阴影不会摇摆。然而，由于这些阴影距离很远，因此这种缺乏运动的现象不太可能被注意到。注意：单面或薄网格不会投射距离场阴影，因为不会生成这些部分的距离场。 CAD 导出的曲面可能会发生这种情况。

### 远瀑布

对于特别远的阴影或投射阴影的非常大的对象，您可以使用的另一个选项是使用远级联。这是一个附加的级联阴影贴图，但必须将 actor 设置为在远级联中投射阴影。性能优势是我们只需要计算离散数量的演员的阴影，我们知道这些演员需要投射那些大的阴影。例如，摩天大楼将能够在远处的瀑布中投射阴影，但其前门外的垃圾桶则不能。远级联还有一个额外的好处，可以覆盖远离摄像机的数十万个单位。您可以考虑使用距离场阴影和远级联来满足您的所有需求。如何启用远级联 - 确保您使用的是可移动定向光 确保您使用的是可移动定向光 - 在灯光的级联阴影贴图设置中，将远影计数设置为 1： 在灯光的级联阴影贴图设置中，将远影计数设置为 1： 如何选择加入远级联 - 选择要在远级联中投射阴影的静态网格物体 Actor。请记住，这些网格应该非常大，可以从很远的距离看到。选择要在远级联中投射阴影的静态网格物体 Actor。请记住，这些网格应该非常大，可以从很远的距离看到。 - 在静态网格物体 actor 的光照集中，单击“Far Shadow”复选框： 在静态网格物体 actor 的光照集中，单击“远阴影”复选框： - unreal-engine

## 相关链接

- [Directional Lights](https://docs.unrealengine.com/en-US/BuildingWorlds/LightingAndShadows/LightTypes/Directional/index.html)
- [Distance Field Soft Shadows](https://docs.unrealengine.com/en-US/BuildingWorlds/LightingAndShadows/RayTracedDistanceFieldShadowing/index.html)
- [Using Distance Field Shadows](https://docs.unrealengine.com/en-US/BuildingWorlds/LightingAndShadows/MeshDistanceFields/HowTo/DFHT_1/index.html)
- [How to see shadows from distant objects](https://dev.epicgames.com/community/learning/knowledge-base/q5Po/unreal-engine-how-to-see-shadows-from-distant-objects#howtoseeshadowsfromdistantobjects)
- [Cascading Shadow Maps](https://dev.epicgames.com/community/learning/knowledge-base/q5Po/unreal-engine-how-to-see-shadows-from-distant-objects#cascadingshadowmaps)
- [Distance Field Shadows](https://dev.epicgames.com/community/learning/knowledge-base/q5Po/unreal-engine-how-to-see-shadows-from-distant-objects#distancefieldshadows)
- [Far Cascades](https://dev.epicgames.com/community/learning/knowledge-base/q5Po/unreal-engine-how-to-see-shadows-from-distant-objects#farcascades)

