---
title: "Mutable纹理流送"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/mutable-texture-streaming-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Mutable骨骼网格体生成", "Mutable优化和调试", "Mutable纹理流送"]
---

# Mutable纹理流送

> 路径：虚幻引擎5.7文档 / 管理内容 / Mutable骨骼网格体生成 / Mutable优化和调试 / Mutable纹理流送

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/mutable-texture-streaming-in-unreal-engine

Mutable实例可以逐步生成纹理。这会产生以下影响：

- 对象可以更快地准备渲染，但质量较低。
- 对象占用的内存更少，因为不会生成不需要的较大纹理mipmap，也不会占用CPU或GPU内存。
- 对象生成总时间更长，因为每次mipmap更新都会重复一些工作。
- 更新纹理mipmap时会有明显的过渡，就像标准的虚幻引擎纹理流送一样。
- Mutable运行时更频繁地处于忙碌状态，这可能会延迟其他对象的更新。

一般建议（也即默认行为）是，在游戏进行时开启纹理流送功能，而当玩家正在自定义对象时关闭纹理流送功能，以防止mipmap更新时出现纹理闪烁现象。

Mutable会将 **纹理压缩策略（Texture Compression Strategy）** 设置为 **无（None）** ，根据[状态](../using-customizable-states-in-mutable/index.md)切换纹理流送。这是一种启发法，假设未压缩的纹理仅用于那些优先考虑低更新延迟且不允许纹理闪烁的可自定义对象状态，例如在大厅中更改皮肤颜色时。

此外，可以使用控制台变量 `mutable.EnableMutableProgressiveMipStreaming` 切换全局Mutable纹理流送。

在运行时，可以使用以下方法对它进行控制：`UCustomizableObjectSystem::SetProgressiveMipStreamingEnabled(bool bIsEnabled)` 。
