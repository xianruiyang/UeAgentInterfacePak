# 面板布料示例文件 (5.3)

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/r287/unreal-engine-panel-cloth-example-files-5-3

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 2787 字符。

## 摘要

该参考文档将显示 .zip 文件的下载位置以及有关新混沌面板布所提供示例文件的一些详细信息...

## 中文整理

### 示例文件参考

当使用实验性 5.3 混沌面板布料编辑器时，我们认为提供一些示例文件和教程将帮助您更好地理解虚幻引擎中新的布料模拟设置工具。以下文档详细说明了示例文件的位置、将它们放置在项目中的位置以及每个文件夹中包含哪些文件的说明。

### ⚠️重要

这些文件仅适用于 5.3 面板布料编辑器和 ML 布料生成概述教程和参考 - 请参阅文档底部的链接。如果不重建编辑器并加载适当的实验插件，这些文件将无法工作。

### 压缩文件下载

https://d1iv7db44yhgxn.cloudfront.net/post-static-files/UE-5-3-ExampleContent.7z Unzip files and place the 'ExampleContent' directory inside the Content Directory (See Content Browser below)

### 第三人称项目

使用虚幻引擎5.3，创建一个新的第三人称项目。这将加载人体模型资产所需的文件。我们将为 Quinn 使用自定义骨架网格物体，但加载默认的人体模型资源将有助于处理纹理等。

### 加载插件 - 重要！

要使用这些资源，您需要首先激活 Experimental 5.3 插件（请参阅面板布料编辑器和 ML 布料生成概述教程）解压缩并找到后，打开编辑器时您的文件夹应如下所示。

### 动画片

提供了三个动画文件。

### 布料_资产

提供了两个具有相应数据流图的布料资产。 CA_Logo_Shirt 用于面板布料编辑器教程，CA_Longsleeve_shirt 用于面板布料 ML 数据生成教程。

### 地图

提供一张地图。这是面板布料教程的最后一步，在自定义 Quinn 骨架网格物体上显示带有动画的最终 ClothAsset。

### 材料

包含用于示例的简单材料和材料实例的目录。

### 网格

使用示例时，使用自定义“SKM_Quinn_Cloth”骨架网格物体。只有 LOD0，并且没有额外的动画蓝图/姿势驱动程序连接，它有点简化。用于教程的静态网格物体还包括 SM_Quinn_shirt_TRANSFER 网格物体，它可以与连接到“Transfer Weights Collection”的 Transfer Skin Weights 节点教程一起使用

### ML_变形器

提供了 ML 变形器文件。用户需要手动创建自己的几何缓存并分配它们，因为这些缓存可能很大，而且我们无法构成提供的示例内容的一部分。此外，在生成训练步骤之前，还必须分配 ClothAsset。

### 纹理

用于 SM-Quinn_shirt 静态网格文件的纹理。

### 结论

使用这些提供的文件作为使用下面教程的参考，或作为使用虚幻引擎中的（实验 5.3）面板布料编辑器设置您自己的自定义 ClothAssets 的示例。 - 面板布料编辑器 - ML 布料数据生成 - 面板布料约束节点参考 - 面板布料转移蒙皮权重节点 - 角色 - 物理

## 相关链接

- [https://d1iv7db44yhgxn.cloudfront.net/post-static-files/UE-5-3-ExampleContent.7z](https://d1iv7db44yhgxn.cloudfront.net/post-static-files/UE-5-3-ExampleContent.7z)
- [Example Files Reference](https://dev.epicgames.com/community/learning/tutorials/r287/unreal-engine-panel-cloth-example-files-5-3#examplefilesreference)
- [⚠️ IMPORTANT](https://dev.epicgames.com/community/learning/tutorials/r287/unreal-engine-panel-cloth-example-files-5-3#%E2%9A%A0%EF%B8%8Fimportant)
- [Zip File Download](https://dev.epicgames.com/community/learning/tutorials/r287/unreal-engine-panel-cloth-example-files-5-3#zipfiledownload)
- [Third Person Project](https://dev.epicgames.com/community/learning/tutorials/r287/unreal-engine-panel-cloth-example-files-5-3#thirdpersonproject)
- [Load Plugins - Important!](https://dev.epicgames.com/community/learning/tutorials/r287/unreal-engine-panel-cloth-example-files-5-3#loadplugins-important!)
- [Animation](https://dev.epicgames.com/community/learning/tutorials/r287/unreal-engine-panel-cloth-example-files-5-3#animation)
- [Cloth_Asset](https://dev.epicgames.com/community/learning/tutorials/r287/unreal-engine-panel-cloth-example-files-5-3#cloth-asset)
- [Maps](https://dev.epicgames.com/community/learning/tutorials/r287/unreal-engine-panel-cloth-example-files-5-3#maps)
- [Materials](https://dev.epicgames.com/community/learning/tutorials/r287/unreal-engine-panel-cloth-example-files-5-3#materials)
- [Meshes](https://dev.epicgames.com/community/learning/tutorials/r287/unreal-engine-panel-cloth-example-files-5-3#meshes)
- [ML_Deformer](https://dev.epicgames.com/community/learning/tutorials/r287/unreal-engine-panel-cloth-example-files-5-3#ml-deformer)
- [Textures](https://dev.epicgames.com/community/learning/tutorials/r287/unreal-engine-panel-cloth-example-files-5-3#textures)
- [Conclusion](https://dev.epicgames.com/community/learning/tutorials/r287/unreal-engine-panel-cloth-example-files-5-3#conclusion)
- [文档与教程](https://dev.epicgames.com/community/learning/tutorials/r287/unreal-engine-panel-cloth-example-files-5-3#%E6%96%87%E6%A1%A3%E4%B8%8E%E6%95%99%E7%A8%8B)
