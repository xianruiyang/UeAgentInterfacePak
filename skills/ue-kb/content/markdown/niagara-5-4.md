# Niagara 数据通道 5.4 更新

# Niagara 数据通道 5.4 更新

- 来源: https://dev.epicgames.com/community/learning/tutorials/OpJ8/unreal-engine-niagara-data-channels-5-4-update
- 原文标题: Niagara Data Channels 5.4 Update

## 尼亚加拉数据通道 5.4 更新

本文档是对《 Niagara 数据通道简介》 的更新。请先阅读该教程，然后再继续阅读。本文档详细介绍了 UE 5.3 和 5.4 之间的变更。

需要注意的主要变化有： 1.

1. 现在某些 NDC 读取器 DI 功能需要发射器 ID。

这是因为我们允许这些 DI 在系统中的任何发射器上运行，而不是要求每个发射器都使用单独的 DI，从而避免了性能、内存和重复设置工作。

我们可以通过`Engine.Emitter.ID`从`MapGet`节点获取当前发射器的 ID。 2.

2. SpawnGroup 不再是向粒子传递其原始 NDC 索引以进行初始化的首选方式。

您应该使用 DI 函数 GetNDCSpawnData 来获取此索引。

使用 SpawnGroup 会强制每个 NDC 项作为单独的批次生成粒子，而新方法允许我们在一个批次中为每个 NDC 项生成所有粒子。

这样在 CPU 上速度更快，并且绕过了 GPU 发射器每帧生成 8 个粒子的限制。

原始功能仍然可以通过 Reader DI 上的此复选框来支持，但默认情况下是关闭的。

还有更多改进和错误修复，我们将在以后的文章中详细介绍。

