# Spawnables and Possessables

---
title: "Spawnables and Possessables"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/spawn-temporary-actors-in-unreal-engine-cinematics"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "Sequencer概述", "Spawnables and Possessables"]
---

# Spawnables and Possessables

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / Sequencer概述 / Spawnables and Possessables

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/spawn-temporary-actors-in-unreal-engine-cinematics

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

在 Sequencer 中，可以选择引用场景中当前已存在的 Actor，这称为 **Possessable**；也可以生成新的 Actor，这称为 **Spawnable**。本文概述这些概念，并介绍如何在场景中使用它们。

#### 前提条件

- 需要了解 **[Sequencer](../../how-to-make-movies/index.md)** 及其 **[界面](../sequencer-editor/sequencer-cinematic-toolbar/index.md)**.
- 需要知道如何创建和使用 **[轨道](../sequencer-track-list/index.md)**.

## Possessable 和 Spawnable

### Possessable

可以通过将关卡中的既有 Actor 添加到序列来 possess 这些 Actor。该链接会形成为 [软对象路径](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/CoreUObject/UObject/FSoftObjectPath?application_version=5.5)。在大多数情况下，这可能是可接受甚至更适合的工作流。如果场景需要与 **Level Sequence**中当前已存在的 Actor 进行高度交互，那么 possessing 很可能是引用 Actor 的最佳选择。

可以通过选中 Actor，或从 **Add Actor to Sequencer** 列表中选择 Actor，将任意 Actor 添加到序列。也可以从 **Outliner** 拖拽 Actor 到 Sequencer 中的空白区域。 **Sequencer**.

![Actor to sequencer possessable](../../../../../assets/images/77/77e4ec0700cef15f284498dbd7f0aa19f39d7c8b8b1e33d35b181c0bbc77c044.jpg)

### Spawnable

如果场景需要在场景持续期间临时存在的 Actor，可以使用 **Spawnables**。默认情况下，包含 Spawnable Actor 的序列开始时会生成该 Actor；序列结束时，该 Actor 会被销毁并移除。也可以使用 Spawn Track 显式控制 Actor 生成和销毁所在的帧。

#### 创建 Spawnable

生成 Actor 有两种方法：拖拽 Actor，或添加 Actor。

如果有一个不在 **Sequencer** 中的既有 Actor，并希望将其转换为 **Spawnable**，请先将其作为 **Sequencer** 添加到 **Possessable** ，然后将该 Actor 转换为 **Spawnable**.

可以通过将其拖入 Sequencer 来创建 **Spawnable** 。从 **[Content Browser](../../../../understanding-the-basics/content-browser/index.md)**, **[Outliner](https://dev.epicgames.com/documentation/assets/building-virtual-worlds/level-editor/world-outliner)**或 **[Place Actors](../../../../understanding-the-basics/actors-and-geometry/placing-actors/index.md)** 面板将 Actor 拖入 Sequencer Outliner 的空白区域。

> 动图已省略：Drag actor from Content Browser to Sequencer

从 Content Browser 将 Actor 拖到 Sequencer

> 动图已省略：Drag actor from Place Actors to Sequencer

从 Place Actors 将 Actor 拖到 Sequencer

要将 **Possessable** 转换为 **Spawnable**，请按以下步骤操作：

1. 在 Viewport 中或从 Outliner 中选择要生成的 Actor。
2. 在 Sequencer 中点击 **Track > Add Actor to Sequencer > Add '{name of selected actor}'**。此操作会将 Actor 添加到 Sequencer，但它还不是 Spawnable。
3. 在 Sequencer 中右键单击该 Actor 并选择 **Convert to Spawnable**.

> [!NOTE]
> Spawnable Actor 可以转换回 Possessable。发生转换时，该 Actor 会在关卡中重新创建，轨道会绑定到它，并移除 Spawnable Actor。

#### 在 Sequencer 中识别 Spawnable

Actor 生成后， **闪电图标叠加标记** 会显示在 Sequencer 和 **Outliner**.

![Possessable and Spawnable](../../../../../assets/images/c8/c81b4dc572fec99192ab6befb8f2f15b61c6b37dd58af585462a948aaefae192.png)

Possessable Actor / Spawnable Actor

![Spawned actors in Outliner](../../../../../assets/images/77/779af9058d035b8f87e7fc4147dbecf2ba1c65960305a71d3fe05b5e1ed65eb8.png)

Outliner 中生成的 Actor

## Spawnable 属性

Spawnable Actor 拥有多种属性，用于控制其行为以及与 Sequencer 的交互。右键单击绑定到 Spawnable 的轨道，并找到 **Spawnable** 分类，即可访问这些属性。

| 属性名称 | 说明 |
| --- | --- |
| **Spawned Object Owner** | 指定哪个 Level Sequence 拥有该 Actor，这也会决定自动生成行为。**This Sequence** 是默认设置，会使 Actor 只在当前序列持续期间生成和销毁。**Root Sequence** 如果使用了主序列，会使 Actor 在主序列持续期间生成和取消生成。这会让 Actor 在当前序列边界之外生成和销毁。**External** 会使 Actor 在序列开始时生成，但不会在结束时销毁。可以改为通过蓝图销毁该 Actor，使用 **[Sequencer Tags 和 Groups](../cinematic-tags-and-groups/index.md)**. |
| **Spawnable Level** | 指定 Actor 要生成到哪个 Level。此列表由 **[Levels](../../../../understanding-the-basics/levels/index.md)** 窗口中存在的 Level 决定。不能指定 World Partition 或 Data Layers。 |
| **Change Class** | 此选项提供一种更改要生成类的方法，同时保留已添加到该 Spawnable 的所有 Sequencer 轨道。它不会保留对象属性等非 Sequencer 数据。 |
| **Continuously Respawn** | 启用后，会每 tick 检查该 Actor 是否仍然存在（基于 Spawn 轨道状态）。如果外部销毁事件确实销毁了该 Actor，它会重新生成。 |
| **Evaluate Tracks When Not Spawned** | 启用后，即使 Actor 未生成，来自该 Actor 的所有轨道仍会求值。如果 Actor 在生成前需要预处理，这会很有用。 |
| **Net Addressable** | 启用后，此 Spawnable Actor 会使用唯一名称生成，使服务器和客户端都能引用它。 |
| **Save Default State** | 保存此 Spawnable Actor 的当前状态。通常不需要点击此项，因为 Unreal Engine 会尝试自动保存对 Spawnable Actor 的任何更改。 |
| **Convert to Possessable** | 将 Actor 转换为 Possessable Actor。发生转换时，该 Actor 会在关卡中重新创建，Actor 轨道会绑定到它，并移除 Spawnable Actor。 |

## 工作流

Spawnable Actor 可帮助你在内容组织和管理方面创建更有条理的场景。

### 灯光场景

与其在关卡中放置多个必须按镜头手动启用或禁用的灯光，不如将所需灯光作为 Spawnable Actor 添加到镜头中。它们只会在该镜头中存在，不会用不必要的灯光弄乱关卡。

![Lighting scenes](../../../../../assets/images/58/58bbe240af25cbf1d3e0b8501232b3509dff877172a6b6ab46997b37325430ee.jpg)

> [!NOTE]
> 该工作流也可用于任何临时 Actor，例如粒子，这样就能创建其实例。

