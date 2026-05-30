# 根运动动画重定向（Manny 到 MetaHuman）

# 根运动动画重定向（Manny 到 MetaHuman）

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/l0mK/unreal-engine-root-motion-animation-retargeting-manny-to-metahuman

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1225 字符。

## 摘要

如何正确地重新定位根部运动动画并避免根部骨骼锁定到位或骨盆不随身体其他部分移动的问题。

## 中文整理

### 概览

Manny 或超人类的默认 IK 重定目标 BP 对于就地动画来说足够了。但是，如果您希望使用根运动动画，则必须进行一些修改。首先，IK 装备将骨盆作为“重定目标根”。 1. 右键单击​​根骨骼并将其设置为源和目标 IK Rig 中的重定位根。

![教程图片](assets/unreal-engine-root-motion-animation-retargeting-manny-to-metahuman/image-01-jpeg.jpg)

2. 接下来选择并右键单击骨盆骨骼并为其添加重定向链。这将使骨盆能够在目标骨架上正确平移 4. 保存两个 IK 装备后，打开 IK 重新定位器并确保设置源和目标 ik 资源（源是自动填充的）。还设置目标预览网格以供参考并能够进行调整。

![教程图片](assets/unreal-engine-root-motion-animation-retargeting-manny-to-metahuman/image-02-jpeg.jpg)

5. 从“Chain Mapping”选项卡中选择根链，然后在“Details Panel”->“FK Adjustments”中，将“Translation Mode”设置为“Globally Scaled”。对骨盆链重复步骤 4，并确认源链设置正确（可能值为“none”）

![教程图片](assets/unreal-engine-root-motion-animation-retargeting-manny-to-metahuman/image-03-jpeg.jpg)

![教程图片](assets/unreal-engine-root-motion-animation-retargeting-manny-to-metahuman/image-04-jpeg.jpg)

现在您应该能够切换到资源浏览器并查看您的动画之一。

