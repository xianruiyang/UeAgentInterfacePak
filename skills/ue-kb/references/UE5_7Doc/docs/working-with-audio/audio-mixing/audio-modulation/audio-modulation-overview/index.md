---
title: "音频调制概述"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/audio-modulation-overview-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "处理音频", "音频混音", "音频调制", "音频调制概述"]
---

# 音频调制概述

> 路径：虚幻引擎5.7文档 / 处理音频 / 音频混音 / 音频调制 / 音频调制概述

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/audio-modulation-overview-in-unreal-engine

**音频调制（Audio Modulation）** 允许对蓝图和组件系统中的一些常见参数（浮点类型）进行控制。与老版本 **虚幻引擎** 相比，该系统包含更优秀、更直观且动态的功能集，用于混合音频源以及动态控制和参数化音频属性。

此系统：

- 公开了一种通用、灵活、解耦的泛型参数调制和混音系统。
- 打造了一套更强大的试听和调试游戏混音的工具。
- 提供的API可以轻松扩展，并用于通过插件进一步调制源、效果、子混合和各种其他音频类型。

音频调制是调制虚幻音频引擎中几乎所有基于浮点或基于缓冲区的参数的强大方案。在最基本的调制形式中，用户可以将调制源连接到[调制目标](#%E8%B0%83%E5%88%B6%E7%9B%AE%E6%A0%87)。如果没有引用源，则由[调制参数](#%E8%B0%83%E5%88%B6%E5%8F%82%E6%95%B0)提供的[默认值](#%E8%B0%83%E5%88%B6%E5%80%BC)与作为默认调制目标值提供的值混合在一起（请参阅[调制源和混音级](#%E8%B0%83%E5%88%B6%E6%BA%90%E5%92%8C%E6%B7%B7%E9%9F%B3%E7%BA%A7)）。这种场景可以被视为将传统的硬件跳线插入调制输入，输出端连接到已知量，例如接地或电压源。

## 启用音频调制

所有调制功能都封装在 **音频调制（Audio Modulation）** 插件中，并实现轻量级引擎端API。

![Enable the Audio Modulation Plugin](../../../../../assets/images/d8/d83c31d879ebf25a21d9f9ca05a2f9e70de0227aefba1c98a643ef57af3670b1.jpg)

要启用音频调制（Audio Modulation）插件，请前往 编辑（Edit）>插件（Plugin） ，点击左侧面板中的 音频（Audio） ，然后选中 启用 音频调制。

启用插件，然后重新启动编辑器或在Visual Studio中重新构建，可以完成虚幻引擎音频调制系统的本机实现。

## 调制值

所有调制值都可以在两个值空间之间变换，即 **单元** 值空间和 **规格化** 值空间。单元空间作为一种便捷方式在编辑器中显示和提供，而规格化空间提供了统一的方式来传递和混合总线值。所有调制值都映射到规格化的[0.0f, 1.0f]范围。与硬件合成器将控制电压（CV）用作将值从源传递到目标的标准类似，调制系统将使用始终包含了规格化浮点范围内值的 **控制总线** 。

以音量为例，单元空间可能在-60 dB（静音阈值（可通过[调制参数](#%E8%B0%83%E5%88%B6%E5%8F%82%E6%95%B0)配置）和0 dB（全音量）之间的范围，其中规格化值以对数方式映射到0.0f和1.0f的规格化空间。半音是另一个示例，可以在其各自的调制参数（Modulation Parameter）设置中配置单元空间+/-12的最小值和最大值。规格化空间始终在0.0f和1.0f之间映射。对于最基本的情况，单元和值空间相同，即所有单元值对应于0.0f和1.0f之间的同一规格化值。

## 调制参数

**调制参数** 为与总线、总线混音、目标和接线关联的值如何显示、混合以及如何在单元和规格化（无单位）[0.0, 1.0]值之间转换提供上下文。其中包括 **单元显示名称（Unit Display Name）** 属性以及默认参数值，而属性将指示如何向引用它们的所有调制器显示单元。该值应设置为在引用此参数的调制器与另一个调制器混合时不会改变输入的值。（从数学上讲，选择的值应该使得在设置为输入时将混音函数有效地简化为[恒等函数](https://zh.wikipedia.org/wiki/%E6%81%86%E7%AD%89%E5%87%BD%E6%95%B8)）。

例如，音量默认调制参数（Volume Default Modulation Parameter）在规格化空间中的默认值为1.0f（在单元空间中为0 dB），当用乘法混合时，这导致输出没有变化（这意味着将输入与该值混合会导致输出的值相同）。

![Sound Modulation Parameter Volume](../../../../../assets/images/41/41091622e7c9195084f2df016204083ee4336567e60fc3d7555810e03f76cac7.png)

当用乘法混合时，音量默认参数值不会导致输出发生变化。

同样，音高规范化后的默认值为0.5f（单元空间为0.0个半音），因为添加0个半音会产生与其混合的值相同的值。

> [!NOTE]
> **面向开发人员的参数说明：** 在代码中，基类 `USoundModulationParameter` 可以继承，可以提供重载函数，以便混和值（`GetMixFunction`），以及转换（单元空间和规格化空间）数值（分别为 `GetUnitConversionFunction` 和 `GetNormalizedConversionFunction` ）。 `GetMixFunction` 将返回 `FModulationMixFunction` ，它会与两个浮点缓冲区组一同传递（ `InValueBuffer` 混合到 `OutValueBuffer` 中），其中 `InValueBuffer` 包含规格化空间中的值。

## 调制目标

调制目标（`FModulationDestination` 位于引擎模块中找到）是为音频源或效果提供浮点值的端点，并且可以通过引用的调制源调制。

![Modulation Destination Properties](../../../../../assets/images/2b/2baef35e22466355b22c6e6309e3878250dda64e043f57290ebc5c45f6470cae.png)

1) 可以调制的基值； 2) 勾选可以启用或禁用调制； 3) 要调制的源对象。

调制目标可以在子混合效果预设（Submix Effect Preset）、源效果预设（Source Effect Preset）或声音类型（例如SoundWave、MetaSound以及通常从SoundBase类继承的内容）的属性中找到。声音类型调制的标准调制目标包括音量、音高、高通和低通。

调制目标包括三个基本属性：

- 可以调制的

  基值

  （以单元为单位）。
- 指示是否启用调制的

  布尔值

  。
- 调制源对象

  ，可以是控制总线、调制发生器或调制接线。

## 调制源和混音级

音频调制（Audio Modulation）插件提供了多种调制源资产类型（`USoundModulatorBase` 的所有继承类型，引擎模块中的基类）。每个都可以由调制目标引用，甚至可以在特定情况下相互引用。这些类型包括[控制总线](#%E6%8E%A7%E5%88%B6%E6%80%BB%E7%BA%BF_usoundcontrolbus_)、[调制发生器](#%E8%B0%83%E5%88%B6%E5%8F%91%E7%94%9F%E5%99%A8_usoundmodulationgenerator_)和[调制接线](#%E8%B0%83%E5%88%B6%E6%8E%A5%E7%BA%BF_usoundmodulationpatch_)。请注意，[控制总线混音](#%E8%AE%BE%E7%BD%AE%E6%8E%A7%E5%88%B6%E6%80%BB%E7%BA%BF%E6%B7%B7%E9%9F%B3)虽然不是调制源，但可以驱动控制总线使用的值。

在下面的流程图中，每个箭头代表混音级，其中一种类型的数组可以混合在一起，并将使用代码中指定的输入[调制参数](#%E8%B0%83%E5%88%B6%E5%8F%82%E6%95%B0)混音函数修改结果值（请参阅 `USoundModulationParameter::GetMixFunction`）。默认混音函数是所有结果值的简单乘法。换言之，总线混音（或总线混音数组）和/或调制发生器（或发生器数组）可用于 *驱动* 总线，而总线（或总线数组）可用于驱动接线。然后，调制发生器、总线或接线可以驱动调制目标，如下所示（多个箭头表示调制器数组可以如何影响另一种类型）：

![Modulation Parameter Flowchart](../../../../../assets/images/4f/4f6437bada1a7c35f55add09089c13aebbff4264f918f63bbb5c4cf59b964277.png)

1) 总线混音； 2) 发生器； 3) 总线； 4) 接线； 5) 目标

### 控制总线(USoundControlBus)

默认情况下，总线采用引用参数属性设置的值。如果设置了 **旁通（Bypass）** ，总线会被忽略并且不会混入由它驱动的输入。

![Sound Control Bus](../../../../../assets/images/bb/bb02915ddcf81d9df81a7442cd49a0b280394995c99d08dddd9fd5b65b0da5bc.png)

启用 旁通（Bypass） 将导致总线被忽略并且不会混入由它驱动的输入。

通过总线混音（或总线混音数组）驱动总线时，客户端可以使用OSC样式的寻址来调整混音值（请参阅[按过滤器设置控制总线混音](#%E6%8C%89%E8%BF%87%E6%BB%A4%E5%99%A8%E8%AE%BE%E7%BD%AE%E6%8E%A7%E5%88%B6%E6%80%BB%E7%BA%BF%E6%B7%B7%E9%9F%B3)）。

你还可以提供一组[调制发生器](#modulationgenerator_usoundmodulationgenerator_)，通过算法驱动总线。

### 调制发生器(USoundModulationGenerator)

调制发生器是调制器的子类，可以随时间按程序生成值。发生器可以被[控制总线](#controlbus_usoundcontrolbus_)或[调制目标](#%E8%B0%83%E5%88%B6%E7%9B%AE%E6%A0%87)直接引用并驱动。**LFO** 和 **包络跟踪器（Envelope Follower）** 在音频调制（Audio Modulation）插件中实现。

### LFO(USoundModulationGeneratorLFO)

LFO调制器是音频调制（Audio Modulation）插件中可用调制发生器的最简单示例。

每个LFO形状都遵循提供的 **振幅（Amplitude）** 、 **频率（Frequency）** 和 **偏移（Offset）** 。LFO总线调制器可以是从形状（Shape）下拉列表中选择的以下任何基本形状：

- 正弦波
- 锯齿波（上）
- 锯齿波（下）
- 方形波
- 三角波
- 指数波
- 随机

周期性函数是否循环具体取决于是否启用了 **循环（Looping）** 。将调制器设置为 **旁通（Bypass）** 将计算生成的值，但不会驱动或混合到引用它的总线或目标。

### 包络跟踪器(USoundModulationGeneratorEnvelopeFollower)

![The Envelope Follower Settings](../../../../../assets/images/bc/bcfc319b8e8d1efd342caa6ca9ae0b059cbdb8bedf60f310673c6c3b75290357.png)

**包络跟踪器（Envelope Follower）** 将根据引用的 **音频总线** 输入的振幅生成不断更新的包络值。**增益（Gain）** 属性提供了一种通过提供的标量抑制传入包络的方法。 **启动时间（Attack Time）** 和 **释放时间（Release Time）** 提供了有效平滑生成包络的能力。将调制器设置为 **旁通（Bypass）** 将计算生成的值，但不会驱动或混合到监听它的总线或目标。

## 创建自定义发生器

为 `USoundModulationGenerator` 类提供了代码生成模板，允许开发人员快速轻松地创建自己的调制发生器。代码生成创建了创建和注册发生器所需的所有样板。前往 **工具（Tools）>新C++类（New C++ Class）** ，并从 **选择父类（Choose Parent Class）** 模式对话框中选择 **显示全部类（Show All Classes）** ，你可以找到它。

![Choose Parent Class](../../../../../assets/images/64/647ab321b664f8c8e3005f12b6dbb9fb57cb75a3ca351ecc0d8f8bbdd455503a.png)

前往 文件（File）>新C++类（New C++ Class）。以上操作将打开 选择父类（Choose Parent Class） 对话框。选中 显示全部类（Show All Classes） 可以启用。

开发人员只需实现 `GetValue` 和 `Update` 函数。`GetValue` 将返回 0.0f 和 1.0f 之间的缓存、规格化、无单位值。

`Update` 函数是计算下一帧缓存值的地方。该值通过 `Update` 调用每帧生成一次，并通过 `GetValue` 调用提供给正在监听的调制目标。

你也可以选择实现 `IsBypassed` 、 `GetDebugValues` 和 `GetDebugCategories` 。 `IsBypassed` 将返回发生器值是否应该包含在目标计算中。默认情况下，它会将生成的 `USoundModulationGenerator` 旁通属性提供的值转发给虚幻音频引擎。`GetDebugValues` 为每个发生器实例提供了字符串数组，以便在运行时使用非发布版本中的 `au.Debug.SoundModulators` 系列调试命令显示。`GetDebugCategories` 应该提供与这些实例值提供的值相对应的字段名称的静态数组。

## 调制接线(USoundModulationPatch)

虚幻调制接线（Modulation Patch）类似于硬件调制中的接线湾，但更强大之处在于，它提供了在功能上重新映射输入总线值的能力。

它能抽象又有趣地将 **参数（Parameter）** 总线值重路由和混音到目标，但与将级并行应用于总线数组的 **控制总线混音（Control Bus Mixes）** 不同，接线旨在组合总线值，然后将它们串行混合到一个或多个目标。

![Modulation Patches](../../../../../assets/images/7b/7bf09d03c3f98f0a34d41289c0f0108602aa98312afc7eb4be9d7a0c06d73d39.jpg)

接线将组合总线值并将它们串行混合到一个或多个目标。

接线由一组总线 **输入插槽** 组成，每个插槽都包含总线引用和变换信息。如果没有订阅总线，接线引用参数的 **默认输入值（Default Input Value）** 将发送到接线输出。

每个输入提供 **取样并保持（Sample-And-Hold）** 属性，这会导致接线在接线初始化后立即捕获总线值，并在接线的生命周期内保留。每一个订阅的总线转换值中的的输出都使用接线[调制参数](#%E8%B0%83%E5%88%B6%E5%8F%82%E6%95%B0)混音函数混合。每个输入都可以使用 **共享曲线资产** 、 **自定义曲线** （存储在接线资产中）或 **表达式** （下面列有示例）映射：

> 图片已省略：Patch Modulation Parameter Mix Function

（红）对数；2. （绿）指数（反向）；3. （蓝）正弦；4. （橙）S曲线；5. （紫）指数

## 控制总线混音（USoundControlBusMix）

控制总线混音是一种运行时动态驱动和分组控制总线值的方法。多个混音可以驱动单个总线，单个混音可以同时驱动多个总线。

> 图片已省略：Sound Control Bus Mix

借助控制总线混音功能，多个混音可以驱动单个总线，单个混音可以同时驱动多个总线。

每个控制总线混音都有 **混音级（Mix Stages）** 数组。混音级可以被视为类似于传统硬件混音器上的通道条。然而，控制总线混音是动态的，这意味着它们可以有任意数量的条目，这与传统混音器不同，并且几乎可以控制所有参数类型，而不仅仅是混音器上的那些规范值，例如音量、音高、HPF截止、LPF截止和修剪。

混音级总是与单个[调制值](#%E8%B0%83%E5%88%B6%E5%80%BC)关联，并且与音频中通道的传统定义没有直接关系（即音频文件集中的通道数，例如单声道、立体声或环绕）。*混音级（Mix Stage）* 这个名称更多地与音量混音链中的传统增益级相关，但不限于音量。

每个混音级都提供 **值** （以单元和规格化空间显示）、 **启动时间** 和 **释放时间** 。启动时间是混音级值从默认值（如该总线的[调制参数](#%E8%B0%83%E5%88%B6%E5%8F%82%E6%95%B0)中定义）到混音激活时提供的值所需的时间。释放时间是混音级值从其当前值变回默认值所需的时间。

编辑控制总线混音（Control Bus Mix）资产时，无数函数将在细节（Details）面板中作为工具公开。你可以使用提供的函数测试激活和停用。此外，混音可以独奏，或者你可以停用所有正在测试的混音。

**混音分析** 可以用于测试保存为松散配置文件的不同设置。对于开发人员来说，这对于测试未发布版本中的混音非常有用，可以在完善时快速迭代，或在开发过程中测试新的混音。它甚至可以用于在交付版本中加载用户创建的混音。使用 `Load Mix from Profile` 和 `Save Mix to Profile` 函数加载混音配置文件并将其保存到位于 `<ProjectDirectory>Saved\Config\AudioModulation\`< `RelativeContentPathToObject`> 的.ini文件。混音配置文件使用 `配置文件索引（Profile Index）` 属性进行索引。

## 调制器激活

所有 **调制源（Modulation Sources）** 都会在对象被实例化时激活，其中包含引用它们的目标。例如，如果音频组件播放引用了[控制总线](#%E6%8E%A7%E5%88%B6%E6%80%BB%E7%BA%BF_usoundcontrolbus_)的声波，并且该控制总线当前未处于激活状态，则它将变为激活状态，该过程有效地将代理实例化到音频渲染线程上的控制总线。当对该控制总线的所有引用都被销毁时，控制总线将停用，向音频渲染线程发送消息以销毁相应的代理。

调制源也可以由引用它们的另一个源激活。例如，如果接线被[调制目标](#%E8%B0%83%E5%88%B6%E7%9B%AE%E6%A0%87)引用，并且该接线引用给定的控制总线，则控制总线可能会激活。

或者，客户端系统可以从蓝图保留[调制器](#_de_activatebus/busmix/modulator)的句柄，强制激活总线，而不管调制目标引用是否实例化。这种显式管理风格的好处是允许用户向调制器提供值，而不管它是否被订阅。但是，使用显式管理可能需要增加客户端系统的工作，以便密切关注调制器的生命周期。可能有帮助的示例包括将角色的法术强度通过总线传输到音频引擎，而不管目标是否主动注册到调制器。

## 蓝图API

### (De)ActivateBus/BusMix/Modulator

这些调用提供了手动激活和停用控制总线、总线混音和调制器的能力（请参阅[调制器激活](#%E8%B0%83%E5%88%B6%E5%99%A8%E6%BF%80%E6%B4%BB)）。如果已经处于请求状态（激活或停用），它们各自不运行（什么都不做）。

### UpdateModulator

为了保持线程安全，必须通过 `UpdateModulator` 提交对 `USoundModulatorBase` 继承类型（例如 `USoundControlBus` 、 `USoundControlBusMix` 和 `USoundBusModulatorLFO` )的更改。当提供类型时，对 `USoundModulatorBase` 实例的所有适用更改都将反映在相应的运行时实例中。例如，如果音量控制总线被 `USoundBase` 类型引用并处于激活状态（未应用混音），则更新默认值将立即更新该总线提供给该 `USoundBase` 实例的增益级。

### CreateLPFBus/HPFBus/PitchBus/VolumeBus/BusMix/LFO

这些是用于创建相应类型、设置默认值和提供立即激活选项的便捷函数。

### 将控制总线混音保存到配置文件

将控制总线混音保存到配置文件，序列化为.ini文件。如果加载混音，它将使用当前代理的状态。如果没有加载，它使用默认的 `UObject` 表示。

### 从配置文件加载控制总线混音

从配置文件将控制总线混音加载到 `Uobject` 混音定义中，从.ini文件反序列化。

### 设置控制总线混音

如果在混音的激活实例代理中提供级，则使用提供的级数据设置混音。不更新混音的 `UObject` 定义。

### 按过滤器设置控制总线混音

将给定类的过滤级设置为提供给混音激活实例的目标值。除非指定，否则不更新混音的 `UObject` 定义。

### 更新控制总线混音

将总线混音的 `UObject` 定义的更新提交到音频渲染线程中的激活代理。如果混音未激活，则忽略

### 更新调制器

将来自调制器（例如总线、总线混音、LFO）的 `UObject` 定义的更新提交到音频渲染线程中的激活代理。
