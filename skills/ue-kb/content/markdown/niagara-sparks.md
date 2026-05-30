# Niagara 示例包：Sparks

# Niagara 示例包：Sparks

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/opOG/unreal-engine-niagara-examples-pack-sparks

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1028 字符。

## 摘要

Niagara 示例包中 Sparks 资产的描述。

## 中文整理

### 概览

Niagara 示例包包含 2 个父发射器，可帮助您开始使用 Spark 系统：

![教程图片](assets/unreal-engine-niagara-examples-pack-sparks/image-01.jpg)

### NE_火花

这是一个简单的发射器，支持突发和生成速率发射。根据您的需要激活一个（或两个）生成模块。

![教程图片](assets/unreal-engine-niagara-examples-pack-sparks/image-02.jpg)

### NE_SecondarySparks

MaterialRandom 属性用作可选辅助发射器的触发器。在粒子生命周期的最后一帧，MaterialRandom 的值将设置为 1.0。这将允许在主火花熄灭时发生二次爆发。

![教程图片](assets/unreal-engine-niagara-examples-pack-sparks/image-03.jpg)

在 NE_SecondarySparks 发射器上，确保 **Spawn Particles from Other Emitter** 正在从主 Spark 发射器读取。您不必使用提供的 NE_Sparks 发射器即可使用辅助 Spark 发射器。您可以将辅助发射器指向任何 GPU 发射器。使用 **Particles.MaterialRandom** 属性控制允许哪些二次火花存在。粒子只能从相同类型的发射器读取（即 GPU->GPU 或 CPU->CPU）。

