# 如何修复：“BP_ThirdPersonCharacter”蓝图中的“CollisionCylinder”不是静态的，因此“CameraBoom”（静态）无法附加。正在中止。

# 如何修复：“BP_ThirdPersonCharacter”蓝图中的“CollisionCylinder”不是静态的，因此“CameraBoom”（静态）无法附加。正在中止。

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/1VRj/unreal-engine-how-to-fix-collisioncylinder-in-bp_thirdpersoncharacter-blueprint-isn-t-static-so-cameraboom-which-is-static-can-t-attach-aborting

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 426 字符。

## 摘要

您好，如果人们仍然遇到这个问题，有一个非常简单的解决方案可以解决这个问题。

## 中文整理

### 概览

以下是要遵循的步骤： 1. 转到包含相机和连接到相机的“springarm”的蓝图

![(2)](assets/unreal-engine-how-to-fix-collisioncylinder-in-bp-thirdpersoncharacter-blueprint-isn-t-static-so-cameraboom-which-is-static-can-t-attach-aborting/image-01.jpg)

2. 删除两者 3. 单击“添加”并添加“springarm” 4. 再次单击“添加”，选择“springarm”并添加“相机” 您已更正了错误，只需用相机等重做设置...

