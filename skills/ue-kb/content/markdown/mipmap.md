# 可视化（调试）Mipmap 级别

# 可视化（调试）Mipmap 级别

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/moZb/unreal-engine-visualizing-debug-mipmap-level

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1901 字符。

## 摘要

本文介绍了一种调试视图模式，该模式将可视化当前流式纹理 mipmap 并将其与 GPU 对当前屏幕尺寸的预期进行比较。注意：您一次只能查看一个纹理并且......

## 中文整理

### 概览

本文介绍了一种调试视图模式，该模式将可视化当前流式纹理 mipmap 并将其与 GPU 对当前屏幕尺寸的预期进行比较。 *注意：您一次只能查看一个纹理，选择该纹理将在步骤 3 中进行说明。*

### 步骤1

在视口左上角的视口“视图模式”按钮下，选择“优化视图模式”>“所需的纹理分辨率”。

![可视化Mipmaps1](assets/unreal-engine-visualizing-debug-mipmap-level/image-01.jpg)

### 步骤2

选择场景中的演员。在此示例中，我选择了屏幕中间的塔。它使用了砖漫反射，我想更详细地可视化。

![可视化Mipmaps2.PNG](assets/unreal-engine-visualizing-debug-mipmap-level/image-02.jpg)

### 步骤3

单击“纹理”按钮并选择您想要可视化的纹理。这将显示所选网格当前正在使用的纹理。在此示例中，我选择“T_Plains_ExtCastle_StoneWall_01_D”纹理。

![可视化Mipmaps3.PNG](assets/unreal-engine-visualizing-debug-mipmap-level/image-03.jpg)

关键位于视口的底部。暖色意味着纹理定义不明确，并且可能显得分辨率较低。蓝色/绿色等较冷的颜色意味着 GPU 传输的分辨率高于屏幕尺寸所需的分辨率。白色是一个很好的比例。

### 接下来是什么？

You can modify the ‘LOD Bias’ or ‘Maximum Texture Size’ to change this globally.在此示例中，将 LOD 偏差设置为“4”将最大纹理尺寸减小至 128x128，并导致该用例的过度定义纹理少得多。 Or for local per material instance control, you can build a LOD Bias variable into the master material.

![可视化Mipmaps4.PNG](assets/unreal-engine-visualizing-debug-mipmap-level/image-04.jpg)

![可视化Mipmaps5](assets/unreal-engine-visualizing-debug-mipmap-level/image-05.jpg)

*在这些文档页面上查看更多信息：* - [纹理属性](https://docs.unrealengine.com/4.27/en-US/RenderingAndGraphics/Textures/Properties/) - [纹理支持和设置](https://docs.unrealengine.com/4.27/en-US/RenderingAndGraphics/Textures/SupportAndSettings/)

