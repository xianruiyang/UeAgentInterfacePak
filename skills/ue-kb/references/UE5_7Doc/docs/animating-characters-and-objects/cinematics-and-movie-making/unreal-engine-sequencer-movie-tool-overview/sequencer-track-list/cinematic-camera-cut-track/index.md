---
title: "镜头切换轨道"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/cinematic-camera-cut-track-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "Sequencer概述", "轨道", "镜头切换轨道"]
---

# 镜头切换轨道

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / Sequencer概述 / 轨道 / 镜头切换轨道

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/cinematic-camera-cut-track-in-unreal-engine

在 **Sequencer** 中创建过场动画的关键操作之一是选择需要在序列期间激活的摄像机。**镜头切换轨道（Camera Cut Track）** 可用于控制此行为，并提供了将摄像机混合在一起或往返于Gameplay的工具。

本文概要介绍如何在Sequencer中创建和使用镜头切换轨道。

#### 先决条件

- 已了解

  Sequencer

  。
- 已熟悉如何

  将摄像机添加到Sequencer

  。

## 创建

有多种方法可以创建镜头切换轨道：

- 单击 **添加轨道（+）（Add Track (+)）> 镜头切换轨道（Camera Cut Track）**。
- 单击[Sequencer工具栏](../../sequencer-editor/sequencer-cinematic-toolbar/index.md)中的 **摄像机（Camera）** 按钮，此操作会创建一个镜头切换轨道和一个[可生成](https://dev.epicgames.com/documentation/404)的[电影摄像机Actor](../../../movie-and-cinematic-cameras/cinematic-cameras/index.md)，然后会将摄像机绑定到轨道。
- 通过单击 **添加轨道（+）（Add Track (+)）> 向Sequencer添加Actor（Actor To Sequencer）> 摄像机Actor（Camera Actor）**，将当前存在的摄像机Actor添加到序列中。执行此操作时，将自动创建镜头切换轨道并将其绑定到该摄像机。

### 绑定摄像机

要使Sequencer使用特定摄像机呈现视图，必须将该摄像机绑定到镜头切换轨道。在上面详述的大多数创建方法中，摄像机已绑定。如果没有，则可以通过单击 **添加摄像机（+）（Add Camera (+)）** 并选择以下选项进行绑定：

1. 如果已将摄像机添加到序列中，则可以在此处从

   现有绑定（Existing Bindings）

   类目中选择一个摄像机。
2. 如果要添加新摄像机，则可以从关卡列表中选择一个摄像机（位于

   新建绑定（New Binding）

   下）。

选择摄像机后，系统将创建一个镜头切换分段并绑定到选定摄像机。启用镜头切换轨道上的 **摄像机锁定（Camera Lock）** 按钮可以通过视口呈现激活的摄像机的视图。

> [!NOTE]
> 将视图锁定到镜头切换轨道后，视口摄像机的功能选项处于禁用状态。如果想要移动当前激活的摄像机或为其设置关键帧，则需要先启用该镜头切换轨道。

## 进行切换

要在摄像机之间切换，请将 **播放头** 移动到时间轴中希望切换镜头的时间点。接下来，单击镜头切换轨道上的 **添加摄像机（+）（Add Camera (+)）**，然后选择要切换到的摄像机。这样便会在播放头处创建一个镜头切换，使新的镜头切换分段绑定到选定摄像机。

> 动图已省略：7ee505fdf4ab0f3680a37026fb4c902cbc34f39ad0f30681df2c8b230d6c12d6

要更改切换时间，请单击任何接触分段的边缘并拖动到其他时间。与大多数其他[分段](../../creating-animation-keyframes/index.md#%E5%88%86%E6%AE%B5)不同，"镜头切换（Camera Cut）"分段在默认情况下不允许镜头切换之间有任何间隙或重叠。

> 动图已省略：7bbcf255d91cdd6f8b581c92f00f2ad2e8223e267e4f5092670d2255c1b2d10a

> [!NOTE]
> 在大多数过场动画情况中，我们不建议使用多个摄像机和镜头切换来构建整个过场动画序列， 而是应该使用[镜头（Shot）](../../sequences-shots-and-takes/index.md)构建过场动画序列，为每个镜头（Shot）划分单个摄像机和镜头切换。

## 混合摄像机

不要在摄像机之间进行硬切换，可以选择在摄像机之间进行混合，这样会混合变换和摄像机组件属性（"景深（Depth of Field）"、"焦距（Focal Length）"和其他属性）。要进行此操作，请右键单击镜头切换轨道并启用 **可以混合（Can Blend）**。

启用后，现在可以[混合](../../creating-animation-keyframes/index.md#%E6%B7%B7%E5%90%88)镜头切换分段，类似于正常分段的用法。例如：

- 可以重叠两个镜头切换分段，从序列中的一个摄像机混合到另一个摄像机。

  > 动图已省略：a945e540896343d13a6d300d288fd30cfee7099276a6428459a937ebf1a59b18
- 可以拖动某个分段的上角以将其混入和混出。以这种方式混合镜头切换分段可以使序列摄像机混入或混出到Gameplay。

  > 动图已省略：69897b78a04d9a073959cbff782ed0bca126590da665669edb4d486d78f8b684

混合摄像机在构建复杂镜头（Shot）时非常有用。在此处的示例中，不受约束的"自由"摄像机与一个用于跟踪快速移动对象的固定摄像机进行混合。使用单个摄像机创建和维持这种运动可能很乏味，但使用混合摄像机可能会轻松很多。

> 动图已省略：0435c12f37b9d92b810e2ea7384ab9d9a101d303b8e30f03ef1f0e2c1903219c

## 属性

右键单击某个分段时，可以看到以下特定于镜头切换的属性：

| 名称 | 描述 |
| --- | --- |
| **锁定前一个摄像机（Lock Previous Camera）** | 启用此选项可确保在从Gameplay中混合时切出的摄像机不会切换。如果游戏包含混合期间可能发生的摄像机切换逻辑，则启用此选项将非常有用。启用此选项会将上次使用的摄像机锁定为要混合的源视图。 |
| **摄像机混合ID（Camera Binding ID）** | 此镜头切换分段呈现视图所用的摄像机。 |

### 缩略图

与[镜头（Shot）](../../sequences-shots-and-takes/index.md)类似，镜头切换分段会显示摄像机视图的缩略图预览。可以通过右键单击该分段并导航到 **缩略图（Thumbnails）** 菜单来对缩略图的显示进行自定义。

| 名称 | 描述 |
| --- | --- |
| **刷新（Refresh）** | 重新生成该分段的缩略图。如果缩略图图像已过期或显示不正确，此选项将非常有用。 |
| **将缩略图时间设置为...（Set Thumbnail Time to...）** | 如果启用了 **绘制单个缩略图（Draw Single Thumbnail）**，则选择此选项会选取当前序列的特定帧以用作单个缩略图图像。 |
| **全部刷新（Refresh All）** | 重新生成所有镜头切换分段的缩略图。如果缩略图图像已过期或显示不正确，此选项将非常有用。 |
| **绘制缩略图（Draw Thumbnails）** | 控制所有镜头（Shot）的缩略图显示。如果禁用，则不显示缩略图，并且轨道大小会减小。 |
| **绘制单个缩略图（Draw Single Thumbnail）** | 启用此选项会在镜头切换分段的起始区域仅显示单个缩略图。 |
| **缩略图大小（Thumbnail Size）** | 控制缩略图的宽度和高度。调整缩略图的高度将增大或减小轨道大小。 |
| **质量（Quality）** | 缩略图图像的渲染质量。 |

> [!NOTE]
> 生成缩略图会有性能成本。如果发现虚幻编辑器在序列打开时运行缓慢，请尝试禁用 **绘制缩略图（Draw Thumbnails）**。
