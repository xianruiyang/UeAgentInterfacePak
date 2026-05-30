# 技术说明：无法从构造脚本中设置骨架网格体组件上的骨架网格体资源

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/JPve/unreal-engine-tech-note-skeletal-mesh-asset-on-skeletal-mesh-component-cannot-be-set-from-construction-script

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 655 字符。

## 摘要

在 5.5.0 中，无法通过构造脚本在骨架网格体组件上设置骨架网格体资源

## 中文整理

### 概览

**描述：**5.5.0 中发现了一个问题，这意味着无法通过构造脚本在骨架网格体组件上设置骨架网格体资源属性。 **潜在影响：** [中等] 尝试在骨架网格体组件上设置骨架网格体资源属性的构造脚本将会失败。 **解决方案：** 5.5.0 中唯一的解决方法是以另一种方式设置骨架网格体资源 - 例如。通过详细信息面板手动或通过事件图或编辑器实用程序蓝图程序化。该问题将在 5.5.2 修补程序版本中得到解决。
