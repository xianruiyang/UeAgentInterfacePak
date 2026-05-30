# LYRA：修复 UE4 手部重定向

# LYRA：修复 UE4 手部重定向

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/bZqv/unreal-engine-lyra-fix-ue4-hand-retargeting

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 829 字符。

## 摘要

当重定向到基于 UE4 骨架的角色时，如何解决 Lyra 中的交叉双手问题。

## 中文整理

### 概览

这个作为草稿坐了很长时间。不知道除了觉得时间太短之外是否还有其他原因？但这很重要。 5.0之后，UE4重定向器丢失了一些东西，导致UE4模型和相关手部混乱。 （见下文。）但这很容易解决。

### 简单如🥧

打开 **RTG_UE5Manny_UE4Manny** 设置预览场景动画以使用 MM_Pistol_Idle_Break 这样您就可以看到问题是什么以及我们如何修复它。放大 UE4 Manny 的双手上方，您会发现它们交叉得太多。所以... **将 IK 调整 > 混合到源更改为 1：LeftArm、RightArm、LeftLeg、RightLeg **(v5.4：IK > 混合到源) 您会看到它们全部移动。如果您打开 Lyra 5.0，您会看到它的设置方式是这样的。

### 比较

![教程图片](assets/unreal-engine-lyra-fix-ue4-hand-retargeting/image-01.jpg)

![教程图片](assets/unreal-engine-lyra-fix-ue4-hand-retargeting/image-02.jpg)

