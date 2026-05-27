---
title: "Parrot中的子系统"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/subsystems-in-parrot-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "为Unity开发者准备的虚幻引擎指南", "Parrot游戏示例", "Parrot中的子系统"]
---

# Parrot中的子系统

> 路径：虚幻引擎5.7文档 / 入门指南 / 为Unity开发者准备的虚幻引擎指南 / Parrot游戏示例 / Parrot中的子系统

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/subsystems-in-parrot-in-unreal-engine

Parrot使用了虚幻引擎中的 [子系统](../../../../cpp-programming/programming-in-the-unreal-engine-architecture/programming-subsystems/index.md)。 子系统提供了由引擎管理的生命周期，并为常用函数添加了拓展点。 就好比你在Unity中使用过的[单例模式](https://en.wikipedia.org/wiki/Singleton_pattern)，子系统也能满足类似的需求。 子系统与引擎中的以下范畴直接相关联：

- 引擎
- 编辑器
- 游戏实例
- 世界
- 本地玩家

当以上范畴进入不同的状态时，子系统也会随之变化，并做出相应的反应。

之所以要使用子系统，一个常见原因是，你需要向蓝图公开常见的C++功能，同时你也知道预期的生命周期。

## 音频子系统示例

Parrot使用[音频子系统](../unreal-engine-audio-implementation-in-parrot/index.md)的原因如下：

- 该子系统与游戏实例的生命周期相绑定，但并不依附于游戏实例本身。
- 该子系统对C++和蓝图均可用。
- 在游戏中可以随时随地更改各项声音设置，比如音量。
- 你可以通过子系统调整音频设置，从而在集中的接入点进行调试。
- 可随时使用外部系统保存音频设置。

要了解该子系统的实际使用情况，请参阅`UParrotAudioSubsystem`。 音频子系统主要与UI系统交互，因为玩家会通过UI调整音频。 不过，如果需要在其他位置更改音频，也可以灵活变通。 在你需要为游戏添加系统时，可以考虑使用子系统。
