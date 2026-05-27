# Sequencer 中的 Niagara 模拟缓存

# Sequencer 中的 Niagara 模拟缓存

- 来源: https://dev.epicgames.com/community/learning/tutorials/Rk9v/unreal-engine-niagara-simulation-caching-in-sequencer
- 原文标题: Niagara Simulation Caching in Sequencer

## 序列器中的尼亚加拉模拟缓存

## 先决条件

要在序列器中捕获和使用仿真缓存，需要启用 NiagaraSimCaching 插件。请注意，该插件仍处于实验阶段，可能会有所更改。

## 序列器缓存

在尼亚加拉模型中，有两种不同的方法来获取模拟结果：

在音序器中插入缓存轨道并使用其录制功能

## 使用尼亚加拉演员作为录音机的音源

它们各有优势，下面将详细解释。 Niagara caches in sequencer by default are saved as part of the track properties,

默认情况下，Niagara 缓存会在音序器中保存为轨道属性的一部分，但也可以创建并保存为独立资源。这在需要将其添加到版本控制或处理非常大的缓存文件时尤其有用。此外，还可以使用 Baker 工具或通过蓝图独立于音序器创建缓存。

## 贝克·西姆·卡什

这些尼亚加拉模拟缓存资源随后可用于缓存轨道：

## 序列器轨道中的缓存资产

## 缓存模拟时推荐的序列器工作流程

添加一个 Niagara 组件并附加一个生命周期轨道。在生命周期轨道上，将“ 年龄更新模式 ”设置为“ 期望年龄 ”。

## 期望的年龄更新模式

缓存数据记录完成后，它将在序列中显示为单独的轨道。当使用缓存中的数据而不是运行系统模拟时，此缓存轨道会禁用生命周期轨道并显示状态图标。

## 缓存已激活

要重新启用生命周期轨道并迭代序列中的某个效果，可以先将缓存轨道静音。对更改满意后，取消缓存轨道静音并重新录制。

## 静音轨道

右键单击缓存轨道并编辑该部分，以更改许多属性，例如录制属性、播放速率或缓存反转。

缓存记录完成后，您还可以使用“将缓存保存到资源”选项将关卡序列中的数据移动到单独的资源中。这在使用版本控制时尤其有用，因为缓存文件可能会变得非常大。

## 缓存属性

可以通过节句柄更改缓存轨道的大小。由于缓存中的帧数是固定的，因此可以用它来减慢缓存播放速度或重复播放缓存。编辑节时可以更改拉伸行为的设置。

曲目选项中的 “段拉伸模式” 属性会改变缓存播放期间拉伸段的使用方式。

拖拽部分手柄

## 直接使用缓存轨道进行记录

向 Niagara 组件添加缓存轨道

单击新增轨道上的录制按钮，以捕获组件的数据。

默认情况下，数据仅记录在生命周期轨道的时间范围内。如果不存在生命周期轨道，缓存将扩展到所选序列播放范围。

## 这种记录方法具有以下优点：

无需打开录制器即可快速迭代和重新缓存

录制选项（例如捕获的属性）可以在捕获缓存之前在赛道上进行编辑。

在选项中选择缓存资源后，录制时数据将直接写入该资源。请注意，使用此选项会删除现有资源数据。切勿在未进行源代码控制的情况下使用此功能。

使用序列的目标帧速率作为时钟周期，因此每个模拟帧都具有固定的增量时间，而不是可变的编辑器时钟周期。这也是更改缓存中记录帧数的绝佳方法——只需在记录缓存之前调整序列的目标显示速率即可。

## 使用录音机进行录音

录音机以非破坏性的方式记录数据，因此在录制时总是会创建新的缓存轨道或电平序列。

首先，将尼亚加拉演员添加为来源

选择添加的源时，您可以在 Actor 属性中启用/禁用缓存录制。

## 然后按下红色大按钮开始录制！

请注意，默认情况下，录制的序列会将尼亚加拉角色添加为新的可生成对象，而不是可占据对象。要仅查看缓存版本，请在大纲视图中禁用原始尼亚加拉角色的可见性。

这种记录方法的优点在于，它可以同时记录多个来源和缓存（不仅仅是尼亚加拉）。

## 使数据接口可缓存

默认情况下，录制时只有绑定到渲染器的粒子属性才会写入缓存。如果自定义数据接口也需要记录其状态才能正确显示特效，则可以实现 INiagaraSimCacheCustomStorageInterface 接口。

## UObject* SimCacheBeginWrite ()

```cpp
bool SimCacheWriteFrame ()
bool SimCacheEndWrite ()
bool SimCacheReadFrame ()
void SimCachePostReadFrame ()
```

## TArray GetSimCacheRendererAttributes ()

## UObject* SimCacheBeginWrite()

```cpp
bool SimCacheWriteFrame()
bool SimCacheEndWrite()
bool SimCacheReadFrame()
void SimCachePostReadFrame()
```

## TArray GetSimCacheRendererAttributes()

要了解如何实现这些功能，可以使用 UNiagaraDataInterfaceRenderTargetVolume 和 UNiagaraDataInterfaceHairStrands 作为示例。

## 尼亚加拉贝克 Sequencer Basics 音序器基础知识

