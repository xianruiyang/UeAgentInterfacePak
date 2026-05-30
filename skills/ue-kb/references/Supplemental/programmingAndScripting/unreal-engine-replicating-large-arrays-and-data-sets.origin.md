# 复制大型数组和数据集

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/D771/unreal-engine-replicating-large-arrays-and-data-sets

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2607 字符。

## 摘要

文章由 Alex K 撰写。虚幻引擎中的复制系统是针对维护动作游戏模拟状态所需的相对少量的实时数据而构建和优化的。不幸的是，这……

## 中文整理

### 概览

*文章由 [Alex K.](https://dev.epicgames.com/community/profile/ZvMA/akoumandarakis) 撰写* 虚幻引擎中的复制系统是针对维护动作游戏模拟状态所需的相对少量的实时数据而构建和优化的。不幸的是，这意味着该系统对于其他一些用例来说并不是最佳的，例如同步更大的数据集或更大的数组，并且我们不建议为此目的大量使用虚幻复制。即便如此，这是一些项目可能会遇到的用例，并且可以调整一些设置和限制来帮助解决这种情况。首先，如果您使用的是 4.26 之前的版本，建议提高带宽限制。这些可以在 *Engine.ini 文件中配置：

```cpp
ConfiguredInternetSpeed=
ConfiguredLanSpeed=

[/Script/Engine.NetDriver]
MaxClientRate=
MaxInternetClientRate=
```

这些值在 4.26 中全部提升到 100,000 字节。还值得注意的是，您可能必须为子类指定 NetDriver 设置，例如 [/Script/OnlineSubsystemUtils.IpNetDriver]。如果为子类设置了相同的值，则这些值优先。您还应该增加 net.PartialBunchReliableThreshold CVar 的值。使用此阈值，如果属性或 RPC 参数复制超过最大传输单元 (MTU) 大小的特定倍数，则部分束将被视为可靠，从而在复制较大数组或其他数据结构时提高鲁棒性。该值默认为 0，建议一开始尝试将其设置为 4。如果您使用的是 4.25 或更低版本，则可以在 *Engine.ini 文件中或在项目设置 → 引擎 → 网络下的编辑器中设置最大复制数组大小限制。在版本 4.26 中，这些值已被弃用并且不再使用，因为引擎现在使用以前的值的最大值。您还可能会在日志中收到错误消息，指出“已收到超过最大允许大小的部分束”或“尝试发送超过最大允许大小的束”。当发送或接收一堆时，UChannel 将根据 NetMaxConstructedPartialBunchSizeBytes 检查其大小。如果您的束太大，您可能需要调整 net.MaxConstructedPartialBunchSizeBytes CVar。值得注意的是，这个值已经相当大了，所以除非完全必要，否则不建议增加它。
