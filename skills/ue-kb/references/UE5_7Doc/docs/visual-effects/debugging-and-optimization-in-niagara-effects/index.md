---
title: "调试和优化Niagara"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/debugging-and-optimization-in-niagara-effects-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建视觉效果", "调试和优化Niagara"]
---

# 调试和优化Niagara

> 路径：虚幻引擎5.7文档 / 创建视觉效果 / 调试和优化Niagara

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/debugging-and-optimization-in-niagara-effects-for-unreal-engine

虚幻引擎提供了若干种工具来帮助你调试模拟效果。

## 优化Niagara系统


- [优化Niagara](optimizing-niagara/index.md)

## Niagara调试器

将Niagara模拟效果添加到关卡后，如果你需要进一步调试，你可以使用 **Niagara调试器**。它允许你打开一个平显界面（HUD）并显示关卡中模拟的详细信息，例如正在生成的粒子数量、内存占用量等。你还可以捕捉信息快照，然后分析该输出。


- [Niagara调试器](niagara-debugger/index.md)

## 使用效果类型管理性能预算

你可以新建一个"Niagara效果类型"资产，以便设置各种参数，帮助你在关卡中管理预算。任何使用该效果类型的Niagara系统都会继承你设置的规则。这样，你设置一套规则来提高性能，比如剔除一定距离外的粒子系统。


- [使用效果类型管理性能预算](performance-budgeting-using-effect-types-in-niagara/index.md)

## 如何修复GPU崩溃

某些Niagara效果包含大量图形效果，在Windows系统中渲染这些场景可能会导致GPU崩溃。请访问此页面，了解如何修复该问题。


- [如何修复GPU驱动程序崩溃](../../designing-visuals-rendering-and-graphics/optimizing-and-debugging-projects-for-realtime-rendering/dealing-with-a-gpu-crash-when-using/index.md)
