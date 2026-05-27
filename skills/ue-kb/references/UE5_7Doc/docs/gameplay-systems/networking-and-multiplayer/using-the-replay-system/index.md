---
title: "重播系统"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-the-replay-system-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "联网和多人游戏", "重播系统"]
---

# 重播系统

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 联网和多人游戏 / 重播系统

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-the-replay-system-in-unreal-engine

**虚幻引擎（UE）** 拥有一个用于录制游戏以便稍后查看的 **重播** 系统。此功能适用于所有游戏，包括在专用服务器上运行的实时多人游戏、单人游戏、甚至包括在编辑器中运行的会话。概括来说，重播系统的工作原理是使用 `DemoNetDriver` 从内置复制系统读取数据，类似于 `NetDriver` 在实时联网游戏环境中的工作方式。任何设置为复制数据的项目，即使项目实际上没有多人模式，无需进一步修改即可兼容重播系统。

该系统的工作方式是用 `DemoNetDriver` 将网络数据传递到重播流送器，后者处理过滤和存储数据的过程。查看重播时，`DemoNetDriver` 将可以访问实时游戏期间可用的所有复制信息（以及指定为仅与重播有关的特殊数据字段），因此它可以根据该数据重构游戏事件。

## 重播系统功能

重播系统的基本功能是启动和停止录制演示，或者回放先前录制的演示。在回放模式下，重播系统支持暂停、更改回放速度或跳转至特定时刻等命令。该系统的更多高级用法包括向重播添加文本标记（通常是游戏中涉及的元标记或玩家名称），或者根据显示的文本标记或版本信息查询现有重播。重播系统可以从C++代码使用，主要是通过 `UGameInstance` 和 `UWorld` 类，或通过控制台命令或命令行参数。

| 函数或变量名称 | 等效的控制台命令 | 效果 |
| --- | --- | --- |
| `UGameInstance::StartRecordingReplay` | "demorec (ReplayName)" | 开始录制播放。如果不提供(ReplayName)参数，则重播系统可以自己生成名称。 |
| `UGameInstance::StopRecordingReplay` | "demostop" | 停止当前正在录制的重播。 |
| `UGameInstance::PlayReplay` | "demoplay (ReplayName)" | 播放指定的重播。 |
| `UDemoNetDriver::GotoTimeInSeconds` | "demoscrub (ReplayTime)" | 跳转至重播中提供的时间（以秒为单位）。 |
| `UWorld::Pauser` (variable) | "demopause" | 场景的 `DemoNetDriver->ServerConnection` 有一个 `OwningActor` 变量。将 `Pauser` 设置到该值将暂停重播。将它恢复为 `null` 将恢复重播。"demopause" 控制台命令将自动设置或清除该变量。 |
| `WorldSettings->DemoPlayTimeDilation` (variable) | "demospeed (ReplaySpeed)" | 通过设置时间比例因子加速或放慢回放。值1.0表示正常速度。 |
| `AGameMode::bHandleDedicatedServerReplays` (variable) | N/A | 将该变量设置为 `true` 可以使专用服务器自动录制游戏。 |

## DemoNetDriver和流送器

`DemoNetDriver` 是一个专用的网络驱动器，能将复制好的数据传送给 **流送器（Streamers）**，后者会录制信息用于之后的播放。有关的 `DemoNetDriver` 的详细用途以及引擎中的流送器详情，请参阅[DemoNetDriver与流送器](demonetdriver-and-streamers/index.md)主页。

## 向后兼容性

重播系统支持到4.13版本的向后兼容性。这意味着，你可以对构建版进行修改，例如添加或移除复制属性，但仍加载和查看原始构建版录制的重播。在大多数情况下，将自动处理这个过程，因为重播系统将跳过已经删除的旧复制字段，或对已经添加的新复制字段使用默认值。请注意，重载了 `NetSerialize` 的结构体将要求手动处理这些数据格式上的差异。

因此，`FArchive` 现在提供 `EngineNetVer` 和 `GameNetVer` 函数，它们分别定义引擎和游戏版本，使你能够调整传入的重播数据以便适用于你的当前构建版本。`FNetworkVersion` 中的委托 `GetLocalNetworkVersionOverride` 可以绑定到一个返回你所选的 `uint32` 版本号的函数。如果不需要为了兼容而完全匹配，则 `FNetworkVersion` 有一个委托叫做 `IsNetworkCompatibleOverride`，通过重载这个委托，可以比较两个版本号并判断它们是否兼容。
