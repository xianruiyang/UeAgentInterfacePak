# 技术说明：由于 5.5.x 中的 TInlineAllocator 设置，编辑器中可能存在内存开销

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/2Xdy/unreal-engine-tech-note-potential-memory-overhead-in-editor-due-to-tinlineallocator-setting-in-5-5-x

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 480 字符。

## 摘要

由于 5.5.x 中 TInlineAllocator 的更改，在具有许多网格的项目中，编辑器中可能会使用几 GB 的临时内存开销。

## 中文整理

### 概览

描述：5.5.x 中发现了一个问题，由于之前引入了 TInlineAllocator 设置来帮助骨架网格物体绘制命令缓存，因此在具有许多网格物体的项目中，可能会导致编辑器中产生数 GB 的开销。潜在影响：[中等] 在具有许多网格的项目中，编辑器中可能会出现几 GB 的临时内存开销。解决方案：集成 CL#40762249 5dd​​153f 修复缓存 MDC 时的高峰值内存使用情况。 - 内存 - 性能和分析

## 相关链接

- 未识别到明确相关链接。

