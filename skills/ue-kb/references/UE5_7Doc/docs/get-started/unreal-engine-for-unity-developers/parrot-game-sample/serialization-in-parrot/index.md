---
title: "Parrot中的序列化"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/serialization-in-parrot-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "为Unity开发者准备的虚幻引擎指南", "Parrot游戏示例", "Parrot中的序列化"]
---

# Parrot中的序列化

> 路径：虚幻引擎5.7文档 / 入门指南 / 为Unity开发者准备的虚幻引擎指南 / Parrot游戏示例 / Parrot中的序列化

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/serialization-in-parrot-in-unreal-engine

为游戏设置保存和加载功能的方式会因游戏的复杂度而变化。 虚幻引擎[支持序列化](../../../../gameplay-tutorials/saving-and-loading-your-game/index.md)以处理保存和加载。 虚幻引擎的**SaveGame**对象类可以在蓝图或C++中派生，可以用于保存简单的变量。 如果你的游戏要求更复杂的保存和加载行为，请参阅这份关于 [序列化的最佳实践和技巧](https://dev.epicgames.com/community/learning/talks-and-demos/4ORW/unreal-engine-serialization-best-practices-and-techniques) 的讲座。 如果你需要编写可由用户配置的设置，请使用`UGameUserSettings`工具类。

Parrot中的`UParrotGameUserSettings`派生自 `UGameUserSettings`。 它可为Parrot保存并加载可由玩家配置的设置。

## 音频设置示例

玩家可以在Parrot中配置音频设置。 Parrot会保存以下浮点值：

- 主音量（Main Volume）
- 音乐音量（Music Volume）
- 音效音量（SFX Volume）

请确保项目使用正确的游戏用户设置类。 如需对其进行配置，请转到**编辑（Edit）** > **项目设置（Project Settings）** > **引擎（Engine） - 一般设置（General Settings）**，并将**游戏用户设置类（Game User Settings Class）**设置为**ParrotGameUserSettings**。

![指向ParrotGameUserSettings的游戏用户设置类字段](../../../../../assets/images/eb/eb6326ff8646b0381aa34d3aa7317fc5bbde986d7887fcd169eb979cc25e8c78.jpg)

然后将用户设置转换为**UParrotGameSettings**类型并调用保存函数。 这在`UParrotAudioSubsystem`中有所表露，详情请参阅[Parrot中的音频引擎实现方案](../unreal-engine-audio-implementation-in-parrot/index.md)。

使用`UGameUserSettings`派生类的另一个好处是避免了去序列化的问题。 用户设置会在游戏启动时自动被读取并应用。
