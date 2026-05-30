# 技术说明：关卡实例和关卡排序器

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/rm4x/unreal-engine-tech-note-level-instances-and-level-sequencer

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1072 字符。

## 摘要

本文由 Ryan B 撰写。 描述：目前不支持关卡实例内的关卡序列。潜在影响：[中]：在关卡实例内使用关卡序列可能无法正常工作......

## 中文整理

### 概览

*本文由 [Ryan B.](https://dev.epicgames.com/community/profile/23wL/RyanBickell) 撰写* **说明：** 目前不支持关卡实例内的关卡序列。 **潜在影响：** [中]：在关卡实例内使用关卡序列可能无法按预期工作，例如使用关卡序列来插值演员的变换时。 **解决方案：** 虽然并不理想，但当前的解决方法是手动指定绑定覆盖，可以在编辑关卡实例时在 LevelSequenceActor 的详细信息面板中找到绑定覆盖。这将创建从原始源关卡路径到该关卡序列 Actor 的实例化路径的绑定。可以在[此处](https://issues.unrealengine.com/issue/UE-180753)跟踪此问题。在[知识库！](https://forums.unrealengine.com/docs) 中获取更多答案

