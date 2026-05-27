# Slay

---
title: "Slay"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/slay-sample-project-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "示例与教学", "引擎功能示例", "Slay"]
---

# Slay

> 路径：虚幻引擎5.7文档 / 示例与教学 / 引擎功能示例 / Slay

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/slay-sample-project-for-unreal-engine

虚幻引擎为用户提供了多种过场动画工具、渲染功能和工作流，以此支持用户的虚拟制片流程。 Slay示例是一款由**[Mold3D Studio](https://www.mold3dstudio.com/)**打造的演示短片，用于演示虚幻引擎为虚拟制片提供的各类技术、渲染功能和工作流。

本文介绍了Slay的查阅方式，以及Slay在制作中用到的各种工作流程和制片技巧。

#### 先决条件

- Slay示例中的场景包含大量的图形内容。 它要求你的配置至少为**Intel Core i9 Series**处理器和**GeForce RTX 2080 Ti**或类似配置。
- 首次打开项目或关卡时，加载时间可能很长，因为许多资产皆是首次加载和编译。

## 设置

用Slay示例设置项目的步骤如下：

1. 通过**Fab**访问[Slay示例](https://fab.com/s/6066e5de148a)，点击**添加到我的库（Add to My Library）**，让项目文件出现在**Epic Games启动器**中。

   1. 或者，你也可以在启动程序的Fab中或UE的Fab插件中搜索该示例项目。
2. 在**Epic Games启动器**中，找到**虚幻引擎 > 库 > Fab库**以访问项目。

   > [!NOTE]
   > 只有在你安装了兼容的引擎版本时，示例项目才会出现在**Fab库**中。
3. 点击**创建项目（Create Project）**并按照屏幕上的提示下载示例并启动新项目。
4. 在虚幻编辑器中打开新项目。

要了解有关从Fab访问示例内容的更多信息，请参阅[示例与教程](../../index.md)。

## 查看Slay中的序列

要查看Slay中的序列，请点击主工具栏中的**过场动画**按钮并选择**TF_Edit**。

![打开Slay过场动画](../../../../assets/images/e8/e8e36bfabe86bf6add59fbb05ffab47491fe65ef629cdaebe9aa20c575382716.png)

这将打开Slay过场动画的**[主序列](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/sequences-shots-and-takes/index.md)**。 在这个视图中可以看到组成整个序列的多个镜头。

![Slay主序列](../../../../assets/images/e9/e91c1f8cef8756ddd5f72126cf11f221554ba73db0c9971cb2df78f662cb61da.jpg)

选择镜头轨道上的**摄像机**按钮，查看每个镜头的**[摄像机](../../../animating-characters-and-objects/cinematics-and-movie-making/movie-and-cinematic-cameras/cinematic-cameras/index.md)**，并点击**播放**按钮来播放序列。

![播放Slay序列](../../../../assets/images/d2/d294e9169b0ae058dc69f0ec59b695338addacefebe663204a6145e76232693a.png)

## Quixel Megascan资产

神庙关卡同时采用了大量特有资产和**[Quixel Megascan](https://quixel.com/megascans/home)**资产。 这些资产被用作Slay中的背景细节、道具和植被。 在项目中使用Quixel Megascan资产有助于你在创建大型场景时节约大量时间和资源。

![Slay quixel megascan](../../../../assets/images/67/6723e0e58e033473652364d385c0ba6d25dbb8c378e4b91b129c718b012a0bbe.png)

打开**[Quixel Megascan](https://quixel.com/megascans/home)**网站，你可以找到一些Slay示例中使用的Quixel Megascan资产。 一些比较有趣的资产包括：

- 神庙庭院中的**[墓碑](https://quixel.com/megascans/home?category=3D%20asset&category=historical&category=feudal%20japan&category=gravestone&search=gravestone)**。

  ![quixel megascan grave](../../../../assets/images/78/7838d83aa1b2c63638b5a3bd7ac65a10d937a51cc681c6c8581c5735b9ab59cf.png)
- 关卡周围放置的**[特定地点或时代道具](https://quixel.com/megascans/home?category=3D%20asset&search=japan)**。

  ![quixel megascan japan props](../../../../assets/images/ed/ed50674b5408d3ec89073813f4f8588595334e82e3b92d3d8bf216e9c9b45278.png)
- 花园和其他区域放置的**[草](https://quixel.com/megascans/home?category=3D%20plant&category=grass)**和其他植被。

  ![quixel megascan grass](../../../../assets/images/7b/7b48bae4100b5cf9dcf6072c0d9d7c652d570d0b4596a75eeabb214fcbd1bcf2.png)

## 基于镜头的工作流

Slay序列是使用**[Sequencer](https://dev.epicgames.com/documentation/assets/animating-characters-and-objects/Sequencer/)**及其**[基于镜头](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/sequences-shots-and-takes/index.md)**的工作流创建的。 这样做是为了让每个镜头只包含最低限度所需的内容，而不必把所有镜头安排在单个超大序列中。 此设置允许对整个序列进行快速修改，镜头可以被**[编辑、删剪、重新组织](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/sequences-shots-and-takes/index.md)**，类似其他非线性编辑软件。

在主序列**TF_Edit**中，你可以看到**镜头轨道**中排列的所有镜头。 此外还包含**[音频轨道](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/sequencer-track-list/cinematic-audio-track/index.md)**，用于播放与序列编辑同步的音频，以及**[渐变轨道](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/sequencer-track-list/cinematic-color-fade-track/index.md)**，用于控制黑场淡入淡出效果。

![Slay主序列](../../../../assets/images/3a/3a34f56f85c7375c1b98db0af29ac44bb40eb28b00629a95599e6e418bd33fce.jpg)

双击镜头可以打开并查看其内容。

### 关卡可视性

Slay的第一个镜头是神庙的外景。 由于角度比较特殊，我们需要专门创建一个自定义的**[地形](../../../building-virtual-worlds/landscape-outdoor-terrain/index.md)**和资产，以便专门在**Shot TF0010_02**镜头中的某个关卡中显示。 关卡的可视性由**[关卡可视性轨道](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-t-fa6b165a/sequencer-track-list/cinematic-level-visibility-track/index.md)**控制，该轨道可以在**TF0010_02**（镜头1）中看到

关卡可视性轨道添加到镜头中后，它只会在镜头的持续时长内进行相关计算。 在这个例子中，在进入神庙内部时，包含低分辨率地形的关卡将被隐藏，而包含高分辨率地形和其他资产的关卡将被显示。

> 图片已省略：Slay关卡可视性地形

> [!NOTE]
> 你可以导航到**[关卡](../../../understanding-the-basics/levels/working-with-levels/index.md)**面板，手动预览高分辨率的地形关卡，方法是启用**Terrain_TF0010**，禁用**Terrain**。

### 使用可生成物

**[动态生成对象（Spawnables）](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/spawn-temporary-actors-in-unreal-engine-cinematics/index.md)**是指动态生成的Actor，通常只存在于单一序列中。 在Slay中，许多镜头中都用到了动态生成对象，以此解决各个镜头特有的需求。 由于每个镜头都相当于单独的序列，可生成物会只存在于单个镜头中，这使得管理这些Actor更容易。

**Shot TF0020_01**（Shot 2）中有一个可生成Actor的示例。 在这个镜头中，原来的静态网格体门已隐藏，并被一个可生成的**骨架网格体**门所替换，包含与角色开门动作匹配的动画。 当镜头播放完成后，这扇门会自动消失。

> 图片已省略：Slay可生成门Actor

### 美术师协作

在Slay示例中，每个镜头自身都相当于一个序列，因此其自身就是一个资产。 镜头还包含**[Subscene轨道](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/sequencer-track-list/cinematic-subscequences-track/index.md)**，同样是它们自身的序列资产。 由于这种资产的划分，让多个美术师同时处理一个序列或镜头会简单许多，而不会出现文件冲突。 Subscene还可以复制，从而在多个实例之间重复使用和共享相同的内容。

在几个镜头中，你可以看到用于**光照**和**视效**的子场景轨道，这使得这两方面的美术师能够在这些序列中工作，而非在主镜头序列中工作。 通过这种方式，子场景不仅有助于限制文件冲突，而且有助于Sequencer组织。

> 图片已省略：Slay多用户子场景

你可以双击"子场景"部分将其打开并查看其内容。

> 图片已省略：子场景内容

从父序列中打开一个镜头或子场景时，它将显示在主序列的上下文中。 这意味着即使你只看到一个子场景，来自主序列和当前镜头的所有轨道也仍然可见。 你可以编辑灯光、添加视觉效果，并用场景的完整视觉上下文执行其他操作。

> [!NOTE]
> 从Sequencer的[播放菜单](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/sequencer-editor/sequencer-cinematic-toolbar/index.md)切换**求值孤立的子序列（Evaluate Sub Sequences In Isolation）**，可以启用或禁用此上下文视图。

### 摄像机动画

Slay的摄像机动画完全在Sequencer中**[创建](../../../animating-characters-and-objects/cinematics-and-movie-making/how-to-make-movies/how-to-animate-cinematic-cameras/index.md)**。 在某些情况下，additive摄像机动画也被用于增强摄像机运动。 这是使用**[摄像机动画序列](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/template-sequences/index.md)**完成的，是一种**[模板序列](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/template-sequences/index.md)**的形式。

> 图片已省略：叠加摄像机动画

双击这些**模板动画**将打开相应的模板序列，在那里你可以看到使用中的动画。

> 图片已省略：摄像机动画序列

## 灯光和材质

灯光、材质和特效在Slay中扮演着重要作用。 只要善用主序列（Master Sequence）和镜头（Shot）系统，美术师就能更高效地打光，并应用每个镜头的材质调整。

### 灯光工作流

正如[上文](index.md)所述，子场景（Subscene）中可以包含光源和其他工作流。 常见的打光流程是将必要的**光源Actor**作为**[可生成物](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/spawn-temporary-actors-in-unreal-engine-cinematics/index.md)**添加到序列中。 这样做是为了让光源仅在镜头播放时保持可见，并且不需要手动打开或关闭。

> 图片已省略：可生成光源

你可以借助其他打光技术来处理你的镜头效果，如使用**遮光物（Light Blockers）**让场景的部分区域接收不到来自主关卡的光照。 然后，你可以使用可生成光源来更直接地控制镜头的灯光效果。

例如在**Shot TF0020_01**（Shot 2）中，如果禁用**摄像机**按钮以停止它的导航，然后在视口中移动到神庙入口区域，你应该会看到一个巨大的**遮光物**。 它可以为镜头创建一个更可控的灯光环境。

> 图片已省略：遮光物

有了遮光物后，可以继续生成其他光源，更好地增强此镜头中的灯光效果，比如聚光灯穿过附近的点阵，在门上投下柔和的阴影。

> 图片已省略：Slay光照

在某些情况下，可能需要隐藏某些网格体，让光线穿过并照射到Actor上。 在**Shot TF0080_01**中，为了让阳光照射在角色Oni身上，神庙的部分结构被隐藏了起来。

> 图片已省略：为光源隐藏关卡

Slay还使用了**[光照通道](../../../building-virtual-worlds/lighting-the-environment/features-and-properties-of-lights/using-lighting-channels/index.md)**来控制光照对环境和角色的影响。 在这个示例中，可生成光源只会影响**通道2**。 所有角色都启用了这个通道，因此他们会被这些光源照亮。 环境不受影响，因为场景网格体只启用了**通道0**。

> 图片已省略：光照通道

### 材质工作流程

如果某个**[材质](https://dev.epicgames.com/documentation/assets/designing-visuals-rendering-and-graphics/materials/)**通过**参数**来设置，你可以在Sequencer中引用这些参数来进行重载，以便调整材质参数。 在Slay中，这样做是为了根据每个镜头的需求微调材质。 与之前的打光流程以及基于镜头的工作流相似，这些编辑可以只针对单个镜头，不必持续到下个镜头。

在**TF00110_01 Lighting Subsequence**这个镜头中，你可以看到Oni铠甲材质上的**粗糙度（Roughness）**和其他参数通过**材质元素轨道（Material Element Tracks）**被调整过了。 材质元素的编号对应于网格体上的材质元素的ID。

> 图片已省略：材质参数轨道

点击**添加参数(+)**将显示该元素可用材质参数的列表。 选择一个参数，为其添加为轨道。

> 图片已省略：添加材质

## 渲染设置

Slay示例被创建为渲染为**最终像素**，展示了可以用虚幻引擎来渲染的高质量图像。 因此正在对几个重要参数进行设置，以提高在视口中及使用进行渲染时场景的保真度。

### 后期处理体积

**[后期处理](../../../designing-visuals-rendering-and-graphics/post-process-effects/index.md)**可用于在场景中控制**光线追踪**相关的效果，例如**全局光照、反射**和**阴影**。 颜色校正也可以通过**[颜色分级和胶片色调映射器](../../../designing-visuals-rendering-and-graphics/post-process-effects/color-grading-and-the-filmic-tonemapper/index.md)**属性应用。

要查看Slay中使用的后期处理属性，请在关卡中选择**后期处理体积**。 可以通过在中搜索找到它。

> 图片已省略：后期处理体积

你可以启用或禁用细节面板中的**已启用（Enabled）**属性，来预览各种后期处理体积的效果。 使用后期处理能够让你的场景效果更加生动。

> 图片已省略：关闭后期处理

> 图片已省略：开启后期处理

关闭后期处理

开启后期处理

### 视口优化

由于Slay包含大量图形内容，所以有必要优化编辑器视口，确保虚幻引擎能够流畅运行。 这是通过在**[配置文件](../../../cpp-programming/setting-up-your-development-environment-for-cplusplus/index.md)****DefaultEngine.ini**中设置某些[控制台变量](../../../animating-characters-and-objects/cinematics-and-movie-making/movie-render-pipeline/cinematic-render-settings-and-formats/cinematic-rendering-image-bb951eea/index.md)来完成的。

可调整的变量包括：

C++

```
r.HairStrands.Enable 1.0	r.HairStrands.DeepShadow.Resolution 512.0	r.RayTracing.Shadows.AcceptFirstHit 1.0	r.RayTracing.SkyLight.ScreenPercentage 55.0
```

> [!NOTE]
> 如需查看其他使用中的控制台变量，请打开Slay项目安装位置的**Config**文件夹，然后用文本编辑器打开**DefaultEngine.ini**。

### 影片渲染队列设置

Slay的最终画面是由虚幻引擎的**[影片渲染队列工具](https://dev.epicgames.com/documentation/assets/animating-characters-and-objects/Sequencer/movie-render-pipeline#movierenderqueue)**渲染。 影片渲染队列支持多种功能，可以输出高质量的渲染效果，例如它的时序子采样（temporal subsampling），可以产生高品质的径向动态模糊效果。 此外，Slay中还使用了控制台变量来提升渲染过程中的图形保真度。

要打开影片渲染队列窗口，请点击Sequencer工具栏中的**渲染**按钮。

> 图片已省略：打开影片渲染队列

Slay中使用的渲染设置会被保存为**影片管线主配置资产（Movie Pipeline Master Config Asset）**。 要将此预设应用到渲染画面，请点击**设置**下拉菜单并选择**Slay_MovieRenderQueue_Preset**。

> 图片已省略：渲染设置预设

要查看采用设置后的效果，请点击**Slay_MovieRenderQueue_Preset**设置文本。 这会打开**[渲染设置](https://dev.epicgames.com/documentation/assets/animating-characters-and-objects/Sequencer/movie-render-pipeline/RenderSettings)**窗口，其中包含了渲染过程中所采用的各种输出、质量和其他设置。

> 图片已省略：渲染设置

#### 抗锯齿

为减少图像噪点，形成平滑的边缘和动态模糊，示例采用了[抗锯齿](../../../animating-characters-and-objects/cinematics-and-movie-making/movie-render-pipeline/cinematic-render-settings-and-formats/cinematic-rendering-image-bb951eea/index.md)，并且将**时序采样数（Temporal Sample Count）**设为**19**。

> 图片已省略：Slay抗锯齿渲染设置

#### 控制台变量

为了从多个方面提升画面的真实度，包括**动态模糊**、**次表面散射**和**光线追踪**等，Slay如下设置了[控制台变量](../../../animating-characters-and-objects/cinematics-and-movie-making/movie-render-pipeline/cinematic-render-settings-and-formats/cinematic-rendering-image-bb951eea/index.md)：

> 图片已省略：Slay控制台变量渲染设置

C++

```
r.MotionBlurQuality 4.0
	r.MotionBlurSeparable 1.0
	r.DepthOfFieldQuality 4.0
	r.ScreenPercentage 125.0
	r.ViewDistanceScale 50.0
	r.SSS.Quality 1.0
	r.SSR.Quality 4.0
	r.Shadow.DistanceScale 10.0
	r.ShadowQuality 5.0
	r.Shadow.RadiusThreshold 0.001
```

