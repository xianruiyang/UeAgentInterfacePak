# UE5.0中的NeighborGrid3D变化

# UE5.0中的NeighborGrid3D变化

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/7xdb/unreal-engine-neighborgrid3d-changes-in-ue5-0

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 937 字符。

## 摘要

从 UE4 到 UE5，NeighborGrid3D 发生了一些变化。现在它是一个更加灵活的系统，但需要一些工作才能使用。

## 中文整理

### 概览

NeighborGrid3D 不再在数据接口本身上指定 x、y、z 中的单元格数量或世界网格大小。它已被更灵活的模块取代，称为“邻居网格 3D 设置分辨率”。进行此更改的原因是我们现在可以链接各种发射器参数来驱动分辨率，而不是在数据接口本身上对其进行硬编码。要查看其实际效果，请查看 SandSystem。 /NiagaraFluids/Templates/Sand/Systems/SandSystem 下图包含您需要集成的重要更改的屏幕截图。设置 NeighborGrid（红色）后，必须调用 Neighbor Grid 3D Set Resolution（绿色）。蓝色部分，您可以看到控制模块上 NeighborGrid 的各种参数。请注意，您必须在 Emitter Spawn 中执行此操作。

![教程图片](assets/unreal-engine-neighborgrid3d-changes-in-ue5-0/image-01.jpg)

