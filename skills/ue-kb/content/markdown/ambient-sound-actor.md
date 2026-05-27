# 环境声（Ambient Sound）Actor用户指南

---
title: "环境声（Ambient Sound）Actor用户指南"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/ambient-sound-actor-user-guide-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "处理音频", "音频体积Actor", "环境声（Ambient Sound）Actor用户指南"]
---

# 环境声（Ambient Sound）Actor用户指南

> 路径：虚幻引擎5.7文档 / 处理音频 / 音频体积Actor / 环境声（Ambient Sound）Actor用户指南

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/ambient-sound-actor-user-guide-in-unreal-engine

虚幻引擎通过使用 **环境声Actor（Ambient Sound Actor）** 简化了你产生或修改环境声的过程。在关卡中放置 **声波（Sound Wave）** 或 **Sound Cue** 资产时，将创建带有声音资产的环境声Actor。环境声Actor有多个属性，允许你修改玩家接收声音的方式，本页介绍了这些属性。

如需详细了解如何将文件导入为[声波](../../sound-source/sound-waves/importing-audio-files/index.md)或通过[Sound Cue](../../sound-source/sound-cue/sound-cue-editor/index.md)修改文件，请参阅相应页面，查阅更多文档。

## 环境声Actor

![环境声Actor](../../../../assets/images/3f/3f98c5be9fd444d9575833c1104aa58fd132433792bf34c81ecfcb4102604f6a.jpg)

环境声（Ambient Sound）Actor（其图标如左侧图中所示）可被用于多个目的，例如，环境循环声音以及非循环声音。 通常，环境声（Ambient Sound）Actor遵循现实世界中的规律——距离声音越近，可以听到的声音越大。相比之下，如果声音本身不是大得过分，那么距它越远它听起来越小。

如果将环境声（Ambient Sound）Actor设置为 **自动激活（Auto Activate）** ，它将在被创建（游戏开始时或生成时）后立即开始播放，即使玩家在所处的位置上听不到它也不例外。

每次触发时，环境声（Ambient Sound）Actor指向的声音资源仅会播放一次，除非你在声波中将它指定为 **循环（Looping）** 或将它定义为Sound Cue资源的一部分。

你可以通过多种方法向关卡中添加环境声（Ambient Sound）Actor：

1. 在

   放置Actor（Place Actors）

   面板的

   所有类（All Classes）

   选项卡中选择环境声（Ambient Sound）Actor，并将其拖放到关卡中，如下图中所示。

![从放置Actor面板添加环境声Actor](../../../../assets/images/56/568a4ad35533c6a6ca2fba2f8fbc7b6eb95d0f2237fe83f8f8f88f387422bebc.png)

1. 右键点击关卡并从上下文菜单选择

   放置Actor（Place Actor）

   。

![从上下文菜单添加环境声Actor](../../../../assets/images/78/78bd04004093659660332b0c21c5ef2ed0d5b3c1008c2168157f332614a2f6ff.jpg)

1. 在菜单栏中打开

   Actor

   菜单并选择

   放置Actor（Place Actor）

   。

![从Actor菜单添加环境声Actor](../../../../assets/images/70/705cf8f61e94e777b75be58ca68946228ce83e1f0ab1a0ad0c83a52719f48b89.png)

1.将声波或Sound Cue从 **内容浏览器（Content Browser）** 拖入你的关卡中。

![从内容浏览器拖动声音](../../../../assets/images/c9/c95dddd87d255457a16d7887b458353971fcf59b750854592ee0ef85178e0c15.jpg)

### 声音属性

如果没有相关的声音资源，环境声（Ambient Sound）Actor没有任何作用。 你可以在 **细节（Details）** 面板中指定声音资源，方法有两种，从 **声音（Sound）** 设置的下拉菜单中选择资源，或者在 **内容浏览器** 中使某个声音资源突出显示，然后单击箭头按钮 按钮。

![Assign a Sound Asset to the Sound Actor](../../../../assets/images/59/591c540f9ac2ebfc7a935097bedfeda78663e4e773425a5b5f5b3e77d5eab302.png)

点击查看大图。

在将Sound Cue资源指定为相关的声音后，**编辑（Edit）** 选项将处于可用状态，然后，你就可在 **Sound Cue编辑器** 中打开Sound Cue资源以进行编辑。 或者，你可以选择 **新建（New）** 选项，该选项将创建新Sound Cue资源并在 **Sound Cue编辑器** 中将它打开以供你编辑，而非指定声音资源。

**播放（Play）** 和 **停止（Stop）** 选项可用于在编辑器中预览指定的声音，它们可分别启动声音播放和停止声音播放。

![Sound Section Properties](../../../../assets/images/2a/2aa3d1f4d8970758928855c99a45b0759af7fcb07d2e7a9a42dce5d2e5754288.png)

点击查看大图。

下面我们将解释 **细节（Details）** 面板的 **声音（Sound）** 部分中的其他选项。

| 属性 | 说明 |
| --- | --- |
| **声音（Sound）** | 指向声波资源或Sound Cue资源。 |
| **是UI声音（Is UI Sound）** | 确定当游戏暂停时是否播放该声音资源。 |
| **音量乘数（Volume Multiplier）** | 应用的乘数，可设置声音的总体音量。 |
| **是UI声音（Is UI Sound）** | 游戏暂停时声音资产是否播放。 |
| **低通滤波器频率（Low Pass Filter Frequency）** | 启用该属性以设置低通滤波器的频率（Hz）。频率0.0是设备采样率，并将绕过滤波器。 |
| **优先级（Priority）** | 启用该属性以使用提供的值覆盖所选声音的优先级。 |
| **播放多个实例（Play Multiple Instances）** | 如果为true，音频组件将同时播放多个声音实例。 |
| **源效果链（Source Effect Chain）** | 确定源效果链，以应用于音频组件上正在播放的声音。 |

### 衰减属性

衰减是随着玩家逐渐离开，声音的音量变小的能力。它需要使用 **MinRadius** 和 **MaxRadius** 这两个半径才能正常工作。 当你从声源处开始移动并穿过MinRadius时，声音的音量为100%。当你在MinRadius和MaxRadius之间的空间中移动时，音量等级将基于 **距离算法（Distance Algorithm）** 被调整。 在MaxRadius之外，声音的音量为0%。

> [!TIP]
> 建议尽可能使用 **声音衰减（Sound Attenuation）** 对象，哪怕仅仅是为了让许多Actor对设置有更广泛的控制权。

如需详细了解衰减，请参阅[衰减概述](../../spatialization-and-sound-attenuation/sound-attenuation/index.md)页面。

![声音Actor衰减属性](../../../../assets/images/6b/6b9fa204581a1cbf3d76f1cafb5a28c99f7a693b365712183c3fa9e87706fdd9.png)

**衰减（Attenuation）** 分段下可以在 **细节（Details）** 面板中修改的选项按如下所示定义：

| 属性 | 说明 |
| --- | --- |
| **允许空间化（Allow Spatialization）** | 允许/禁止音频组件空间化。 |
| **覆盖衰减（Override Attenuation）** | 使用资源的"衰减（Attenuation）"设置还是"衰减覆盖（Attenuation Overrides）"设置。 |
| **衰减设置（Attenuation Settings）** | 指向并使用在SoundAttenuation资源中指定的设置。 |

勾选 **覆盖衰减（Override Attenuation）** 时，以下分段上的设置可以修改：

| 分段 | 说明 |
| --- | --- |
| **衰减（音量）（Attenuation (Volume)）** | 此分段中的属性定义了声音的音量如何随着聆听者远离而衰减。 |
| **衰减（空间化）（Attenuation (Spatialization)）** | 此分段中的属性定义了声音如何在游戏世界中空间化。 |
| **衰减（遮蔽）（Attenuation (Occlusion)）** | 此分段中的属性将控制实时遮蔽追踪。 |
| **衰减（子混音）（Attenuation (Submix)）** | 此分段中的属性将控制如何将声源发送到子混音。 |
| **衰减（混响）（Attenuation (Reverb)）** | 此分段中的属性定义了声音与聆听者的距离和应用于声音的混响量之间的关系。 |
| **衰减（聚焦）（Attenuation (Focus)）** | 此分段中的属性将控制一些额外处理，供你用于声音的聚焦行为。 |
| **衰减（优先级）（Attenuation (Priority)）** | 此分段中的属性将控制基于距离的声音衰减优先级。 |
| **衰减（空气吸收）（Attenuation (Air Absorbtion)）** | 此分段中的属性定义了一种算法的行为，该算法将尝试根据空气吸收对声音的影响来建模。 |

### 调制属性

> 图片已省略：声音Actor调制属性

**调制（Modulation）** 设置定义了哪些设置要用于 **音量（Volume）** 、 **音高（Pitch）** 、 **高通（Highpass）** 和 **低通（Lowpass）** 调制。有三个选项可用：

- 禁用（Disable）

  ：禁用调制路由。
- 继承（Inherit）

  ：音频组件从其父声音继承调制设置。
- 覆盖（Override）

  ：忽略继承的设置并允许你为每个参数设置基础值、启用或禁用调制并设置调制源。

如需详细了解调制，请参阅[虚幻引擎中的音频调制概述](../../audio-mixing/audio-modulation/index.md)页面。

## 向蓝图中添加"音频"组件

在 **蓝图** 的 **组件（Component）** 面板中，选择 **添加组件（Add Component）** 按钮并选择 **音频（Audio）** 组件。

> 图片已省略：在蓝图中添加音频组件

可通过蓝图引用 **音频（Audio）** 组件，并且可使用不同类型的函数修改其多个设置。

> 图片已省略：在图表编辑器中将音频组件连接到函数

**音频（Audio）** 组件拥有一个独特的事件，可供你使用。**OnAudioFinished** 事件使你能够在音频完成播放或音频由于 **停止（Stop）** 函数提前停止时触发事件。

## 音频体积

为了更好地进行控制，你可以在使用 **环境声（Ambient Sound）Actor** 的同时使用 **音频体积（Audio Volume）** 。有关如何使用"音频体积（Audio Volume）"的更多信息，请参阅[音频体积](../audio-volumes/index.md)页面。

> [!TIP]
> 对"音频体积（Audio Volume）"进行的更改不会实时在编辑器中生效。要使更改生效，你需要重新构建包含所编辑的体积的关卡的几何体。

