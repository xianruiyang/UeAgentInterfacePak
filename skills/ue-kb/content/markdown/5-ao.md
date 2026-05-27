# 虚幻引擎 5 中的材质环境光遮挡 (AO)

# 虚幻引擎 5 中的材质环境光遮挡 (AO)

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/bOEy/material-ambient-occlusion-ao-in-unreal-engine-5

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 2407 字符。

## 摘要

默认情况下，虚幻引擎使用 Lumen 方法作为全局照明和反射。通过利用和使用材质环境光遮挡，您可以...

## 中文整理

### 概览

- 什么是环境光遮挡？

什么是环境光遮挡？

环境光遮挡是全局照明的近似值，它再现了每个表面位置发生的自遮挡的平均量（由标量值表示）。

它计算表面上的点对附近光源的隐藏程度。

除了增加光照的真实感之外，它还模拟自阴影以及间接光源（例如天空和场景中其他物体）的效果。

通常，环境光遮挡纹理由 3D 建模包（例如 Blender、3ds Max 或 ZBrush）或纹理创作软件（例如 Substance Designer、Substance Painter 和 Photoshop）生成。

环境光遮挡纹理可以与其他纹理集一起在材质中使用。

传统方法之一是将基色和 AO 贴图结合起来，在 PBR 材质中创建更真实的光照，这至今仍然是一种有效的技术。

然而，这种技术在物理上并不准确。

这是一种静态外观，与间接光源没有任何相互作用。

- 使用环境光遮挡的传统方法 使用环境光遮挡的传统方法 - 空间屏幕环境光遮挡 - 传统 PBR 结合材质中的 AO - 虚幻引擎 5 中的工作材质 AO 虚幻引擎 5 中的工作材质 AO 默认情况下，虚幻引擎使用 Lumen 方法作为全局照明和反射。

通过使用材质环境光遮挡，您可以为场景、对象和角色带来真实感，并将视觉效果提升到一个新的水平。

您需要按照以下步骤操作才能使 Lumen 使用 Material Ambient Occlusion。

- 在项目设置中禁用“允许静态照明”以在 GBuffer 中创建空间。

在项目设置中禁用“允许静态照明”以在 GBuffer 中创建空间。

- 设置材质中适当的 AO 纹理贴图并将其分配给环境光遮挡输入。

设置材质中适当的 AO 纹理贴图并将其分配给环境光遮挡输入。

- 材质 AO 示例 材质 AO 示例 - 材质 AO 比较 材质 AO 比较 以下是材质环境光遮挡的比较示例。

您可以单击每组比较来放大它们以查看差异。

P.S：模型的 3D 模型归功于 Daily Art https://sketchfab.com/D.art - 灯光 - 材料 - 电影

![空间屏幕环境遮挡通行证 (SSAO) - Matinee 地铁示例项目 - Epic Games](assets/material-ambient-occlusion-ao-in-unreal-engine-5/image-01.jpg)


![环境光遮挡纹理 - Quixel Megascans - Epic Games](assets/material-ambient-occlusion-ao-in-unreal-engine-5/image-02.jpg)


![PBR 材质 - 基色 + 粗糙度 + 法线纹理贴图](assets/material-ambient-occlusion-ao-in-unreal-engine-5/image-03.jpg)


![PBR 材质 - 基色未结合环境光遮挡纹理](assets/material-ambient-occlusion-ao-in-unreal-engine-5/image-04.jpg)


![PBR 材质 - 基色 + AO + 粗糙度 + 法线纹理贴图](assets/material-ambient-occlusion-ao-in-unreal-engine-5/image-05.jpg)


![PBR 材质 - 基色 + AO + 粗糙度 + 法线纹理贴图](assets/material-ambient-occlusion-ao-in-unreal-engine-5/image-06.jpg)


![教程图片](assets/material-ambient-occlusion-ao-in-unreal-engine-5/image-07.jpg)


![教程图片](assets/material-ambient-occlusion-ao-in-unreal-engine-5/image-08.jpg)


![Beauty Pass - 材质环境光遮挡开启](assets/material-ambient-occlusion-ao-in-unreal-engine-5/image-09.jpg)


![Beauty Pass - 材质环境光遮挡关闭](assets/material-ambient-occlusion-ao-in-unreal-engine-5/image-10.jpg)


## 相关链接

- [https://sketchfab.com/D.art](https://sketchfab.com/D.art)


