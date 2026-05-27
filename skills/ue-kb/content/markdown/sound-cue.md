# Sound Cue参考

---
title: "Sound Cue参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/sound-cue-reference-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "处理音频", "Sound Source", "Sound Cue", "Sound Cue参考"]
---

# Sound Cue参考

> 路径：虚幻引擎5.7文档 / 处理音频 / Sound Source / Sound Cue / Sound Cue参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/sound-cue-reference-for-unreal-engine

在 **虚幻引擎** 中，**Sound Cue** 是一种音频资产，它内含一个节点式图表，其中封装了复杂的声音设计逻辑。有了Sound Cue，音效设计人员只需通过排列和修改音效节点，就能自由地对音效各个部分进行动态更改，从而创建复杂有趣的效果。

在Sound Cue Editor编辑器中，各种不同的声音节点类型会罗列在 **控制板（Palette）** 面板中。而当你在 **视口（Viewport）** 面板中选中节点后，**细节（Details）** 面板中会显示该节点相关的属性。

![Sound Cue编辑器控制板面板](../../../../../assets/images/bd/bd3b9d9cc5dbc180ab4eb9e9ce91dbcffc524eaaed10062fe71db2b571ada255.jpg)

> [!NOTE]
> 更多使用Sound Cue的相关信息，请参考[Sound Cue编辑器](../sound-cue-editor/index.md) 和 [Sound Cue编辑器界面](../sound-cue-editor-ui/index.md)文档。

## 命名参数

在一些声音节点中，你可以通过输入新的参数名来声明参数。在节点中输入一个参数名称，便会以该名称创建一个参数。

![命名的参数示例](../../../../../assets/images/6c/6c53a814fa8e16607c06be159152cbc36f1f58bf709d7395bf9dfb183780b6d5.jpg)

你可以随意命名参数。然而，当你使用 **音效组件函数（audio component function）** 设置该参数的数值时，其 **名称（In name）** 字段必须完全匹配你提供的参数名称。

> [!NOTE]
> 你无法从Sound Cue内设置命名参数的值。推荐的工作流程为：
>
> - 添加一个声音节点。
> - 在节点的
>
>   参数名（Parameter Name）
>
>   字段中输入一个名称。
> - 使用适应的设置[名称]参数函数在蓝图或代码中调用相关的音效组件函数。
> - 将相同的名称添加到
>
>   名称（In Name）
>
>   类别中。这将使Sound Cue按预期响应。

![设置音波参数蓝图示例](../../../../../assets/images/de/de964a64a499cf55eac58b175613a9eb05ac8ac22934349a6839e3ee3b3d1b6f.jpg)

下表提供了可使用参数的节点和相应的参数设置函数。

| 节点类型 | 对应函数 |
| --- | --- |
| 分支 | 设置布尔值参数（Set Boolean Parameter） |
| 连续调制器 | 设置浮点型参数（Set Float Parameter） |
| 按参数交叉淡化 | 设置浮点型参数（Set Float Parameter） |
| 音效类 | 设置音波参数（Set Wave Parameter） |
| 切换 | 设置整数型参数（Set Integer Parameter） |
| 声波参数 | 设置音波参数（Set Wave Parameter） |

## 输出节点

每个Sounc Cue都需要一个 **输出（Output）** 节点来作为节点图表中音频信号的终止点。输出节点的属性是相对的，并且能够影响Sound Cue中所包含的所有音频输出。

![输出声音节点](../../../../../assets/images/0d/0dcfada5201d64b7ff0c6a880ad2ea93361f7b7e183389b0b5c81fa3f13a19ea.jpg)

| 属性 | 描述 |
| --- | --- |
| **内存（Memory）** |  |
| 加载时准备（Prime on Load） | 启用后，会在该Sound Cue加载时将所有的声波加载进缓存。 |
| 禁用随机分支剔除（Disable Random Branch Culling） | 启用后，所有每个平台的随机节点剔除都会被忽略。 |
| **音效（Sound）** |  |
| 音量乘数（Volume Multiplier） | 基础音量乘数。 |
| 音高乘数（Pitch Multiplier） | 基础音高乘数。 |
| 类（Class） | 该Sound Cue所属的 声音类（Sound Class） 资产。 |
| **衰减（Attenuation）** |  |
| 重载衰减（Override Attenuation） | 启用后，现有的衰减设置会被提供的数值覆盖。参考该页面的[衰减节点](#attenuationnode)小节来了解更多信息。 |
| 衰减设置（Attenuation Settings） | 该项可以设置为已有的 音效衰减（Sound Attenuation） 资产来使用该资产的设置。 |
| **效果（Effects）** |  |
| �� 源（Source） |  |
| 启用总线发送（Enable Bus Sends） | 启用后，音频输出会被发送至总线。 |
| 源效果链（Source Effect Chain） | 为该Sound Cue使用的 **源效果预设链（Source Effect Preset Chain）** 资产。 |
| 后效果总线发送（Post-Effect Bus Sends） | 在源效果处理之后有总线实例播放的情况下，会将音频输出发送至这一数组的总线。 |
| 前效果总线发送（Pre-Effect Bus Sends） | 在源效果处理之前有总线实例播放的情况下，会将音频输出发送至这一数组的总线。 |
| �� 子混合（Submix） |  |
| 启用基础子混合（Enable Base Submix） | 启用后，声音会在默认情况下路由至主要子混合，或者在指定的情况下路由至基础子混合。禁用后，声音会仅路由至子混合发送或者总线发送。 |
| 基础子混合（Base Submix） | 为该Sound Cue使用的 子混合（Submix） 资产。 |
| 启用子混合发送（Enable Submix Sends） | 启用将音频发送至额外的子混合。 |
| 子混合发送（Submix Sends） | 一个数组的子混合，用来接收指定数量的（详见 发送等级（Send Level））来自该Sound Cue的音频输出。 |
| **语音管理** |  |
| 虚拟化模式（Virtualization Mode） | 设置虚拟化行为，来决定一个声音是否要生成，以及由于循环声音限制而被剔除或者逐出时要如何继续播放。 |
| �� 优先级（Priority） |  |
| 字幕优先级（Subtitle Priority） | 字幕的优先级。更高的数值会比较低的优先显示。 |
| 优先级的旁通音量缩放（Bypass Volume Scale for Priority） | 启用后，评估音效是否应该在达到最大通道数量的情况下保持激活时，会绕开音量权重优先级。 |
| 优先级（Priority） | 用于判定达到通道限制时声音是否可以继续播放。较高的数值会比较低的数值优先播放。除非被绕过，值将以音效的最终音量进行权重，由此生成最终的运行时优先级值。 |
| �� 并发性（Concurrency） |  |
| 重载并发性（Override Concurrency） | 启用后，会用提供的数值替代已有的并发性设置。启用后能够修改 并发性重载（Concurrency Overrides） 数值。 |
| 并发性集（Concurrency Set） | 包含要应用的并发性设置的数组（如果重载设为false）。音效必须通过所有并发性设置才能够播放。 |
| �� 并发性（Concurrency） �� 并发性重载（Concurrency Overrides） |  |
| 最大数量（Max Count） | 在此并发性组中所允许的最大并发音效数量。 |
| 限制到拥有者（Limit to Owner） | 启用后，并发设置会应用到播放音效的Actor。如果音效没有所有者，将退回使用全局并发设置。 |
| 分辨率规则（Resolution Rule） | 达到最大声音数后使用的并发分辨率规则。 |
| 二次触发时间（Retrigger Time） | 并发播放的不同音效之间等待的时间（秒）。拒绝的音效将忽略虚拟化设置。 |
| 音量缩放（Volume Scale） | 每个较旧的声音实例要应用的回避因子，基于缩放模式混合，并且会在它们停止时根据提供的启动/释放时间来恢复它们。 |
| 音量缩放模式（Volume Scale Mode） | 用于指定如何根据组中集合的成员音效的数量来缩放声音音量。 |
| 闪避时间（Duck Time） | 使用音量标量应用闪避所需的时间。（秒） |
| 可恢复（Can Recover） | 启用后，当并发组音效停止时，音量缩放可以恢复音量回避行为。该项仅在 音量缩放模式（Volume Scale Mode） 设置为 默认（Default） 时有效。 |
| 恢复时间（Recover Time） | 从音量标量回避恢复所花费的时间（秒）。仅在启用 可恢复（Can Recover） 时可用。 |
| 语音窃取释放时间（Voice Steal Release Time） | 声音因组内其它声音开始播放而被驱逐或剔除时，淡出所需的时间（秒）。 |
| **高级** |  |
| 资产用户数据（Asset User Data） | 随资产保存的用户数据的数组。 |
| **开发者** |  |
| 调试（Debug） | 启用后，会在可听到音效时绘制此音效的衰减形状。仅用于调试。 |
| 时长（Duration） | 音效的时长（秒）。 |
| 最大距离（Max Distance） | 资产的最大距离，有衰减设置确定。 |
| 总采样（Total Samples） | 采样的总数量（以千计）。可以用于分析指定资产的相对大小。在 资产浏览器（Content Drawer） 中将光标悬停在Sound Cue上面，该数值也会显示在弹出的菜单中。 |

## 衰减节点

**衰减（Attenuation）** 节点基于声音源和听者之间的距离来控制音效的音量。

**衰减设置（Attenuation Settings）** 可以设置到一个已有的 **声音衰减（Sound Attenuation）** 资产或者在节点的属性中启用 **重载衰减（Override Attenuation）** 设置后手动调节。

> [!NOTE]
> 要了解衰减及其工作方式，请参考[声音衰减](../../../spatialization-and-sound-attenuation/sound-attenuation/index.md)文档。

![衰减声音节点](../../../../../assets/images/81/81b8b261ee2b271f98791ba7538d3fd805fd4d4fb36aeb4d6471162918c3e8ae.png)

| 属性 | 描述 |
| --- | --- |
| **衰减** |  |
| 衰减设置（Attenuation Settings） | 该项可以设置到已有的 **声音衰减（Sound Attenuation）** 资产来使用该资产的设置。 |
| 重载衰减（Override Attenuation） | 启用后，已有的衰减设置会被提供的数值覆盖。 |
| **衰减（音量）** |  |
| 启用音量衰减（Enable Volume Attenuation） | 启用或禁用基于距离的音量衰减。 |
| 衰减函数（Attenuation Function） | 可使用的衰减函数类型：线性、对数、反转、对数反转、自然声音或者自定义。 |
| 最大衰减（分贝）（Attenuation At Max (dB)） | (在 **衰减函数** 为自然声音时可用) 在衰减距离处的衰减量，以分贝为单位。 |
| 衰减模式（Falloff Mode） | （在 **衰减函数** 为自然声音时可用）控制超过衰减边界时继续衰减、变为静音、还是保持最后的音量值。仅在 **最大衰减（分贝）** 设置的值大于-60dB时可编辑。 |
| 衰减形状（Attenuation Shape） | 非自定义衰减函数的形状：球体、胶囊体、盒体或者锥体。 |
| 内部半径（Inner Radius） | （在 **衰减形状** 为球体时可用）定义音效衰减起始位置（或者自定义衰减曲线开始）的半径。播放距离小于此半径的音效将不会衰减。 |
| 胶囊体半高（Capsule Half Height） | （在 **衰减形状** 为胶囊体时可用）衰减胶囊体的半高。 |
| 胶囊体半径（Capsule Radius） | （在 **衰减形状** 为胶囊体时可用）衰减胶囊体的半径。 |
| 范围（Extents） | （在 **衰减形状** 为锥体时可用）衰减锥体的尺寸。 |
| 锥体半径（Cone Radius） | （在 **衰减形状** 为锥体时可用）衰减锥体的半径。 |
| 锥体角度（Cone Angle） | （在 **衰减形状** 为锥体时可用）衰减锥体的角度。 |
| 锥体衰减角（Cone Falloff Angle） | （在 **衰减形状** 为锥体时可用）衰减锥体的衰减外边角。 |
| 锥体偏移（Cone Offset） | （在 **衰减形状** 为锥体时可用）衰减锥体的偏移。 |
| 衰减距离（Falloff Distance） | 音量衰减发生的距离。 |
| **衰减（空间化）** |  |
| 启用空间化（Enable Spatialization） | 启用后，允许源为空间3D化。 |
| 空间化方法（Spatialization Method） | 以下方法用于空间化音效： **平移（Panning）：** 空间化的标准平移方法（项目设置中定义的线性或等效方法）。 **双声道（Binaural）：** 双声道空间化方法（需要耳机，由插件启用）。 |
| 双耳半径（Binaural Radius） | 在音效开始播放是切换非霜儿音频的最小半径。 |
| 非空间化半径（Non-Spatialized Radius） | 低于此距离，声音将为非空间化（2D）。这能防止音频在穿过听者位置时发生反转。 |
| 3D立体声扩散（3D Stereo Spread） | 立体资产被3D空间化时左右声道之间的场景空间距离。 |
| 标准化3D立体声音效（Normalize 3D Stereo Sounds） | 启用后，会将一个-6 dB的衰减应用到3D空间化的立体资产。避免在资产因声道加总而出现0.0传播时出现裁剪现象。 |
| 空间化插件设置（Spatialization Plugin Settings） | 数组中多个用于空间化插件的设置。 |
| **衰减（遮挡）** |  |
| 启用遮蔽（Enable Occlusion） | 启用实时遮挡追踪。 |
| 遮蔽检测通道（Occlusion Trace Channel） | 用于音效遮挡检查的追踪通道。 |
| 遮蔽低通过滤频率（Occlusion Low Pass Filter Frequency） | 此音效组件正在播放的音效被遮挡时应用的低通滤波频率（以赫兹为单位）。它将覆盖代码或蓝图中的 `LowPassFilterFrequency` 中设置的频率。频率0.0为设备采样频率。这将绕过滤波器。 |
| 遮蔽音量衰减（Occlusion Volume Attenuation） | 应用于被遮挡音效的音量衰减量。 |
| 遮蔽内插时间（Occlusion Interpolation Time） | 音效被遮挡时内插到目标 **遮蔽低通过滤频率（Occlusion Low Pass Filter Frequency）** 的时间量（以秒为单位）。 |
| 使用遮蔽的复杂碰撞（Use Complex Collision for Occlusion） | 执行遮挡追踪时启用对复杂碰撞的追踪。 |
| 遮蔽插件设置（Occlusion Plugin Settings） | 数组中多个用于遮蔽插件的设置。 |
| **衰减（子混合）** |  |
| 启用副路混合发送（Enables Submix Send） | 启用基于距离的副路混合发送。 |
| 副路混合发送设置（Submix Send Settings） | 该功能启用时，副路混合发送设置会展开为一系列参数。 |
| **衰减（混响）** |  |
| 启用混响发送（Enable Reverb Send） | 基于距离启用混响发送调整。 |
| 混响发送方法（Reverb Send Method） | 用于控制主混响发送的方法： **线性（Linear）：** 基于距离和发送等级范围之间线性插值的混响发送。 **自定义曲线（Custom Curve）：** 基于所提供曲线的混响发送。可以直接在 **细节面板（Details Panel）** 中设置或者点击参数名称旁的三角形，使用展开的 **外部曲线（External Curve）** 选项来设置到一个外部曲线。 **手动（Manual）：** 使用下述手动设置的混响发送等级。对2D音效很有用。 |
| 混响最小发送等级（Reverb Min Send Level） | 当音效距离等于混响最小发送距离中指定的值时，发送到主混响的量。 |
| 混响最大发送等级（Reverb Max Send Level） | 当音效的距离等于混响最大发送距离中指定的值时，发送到主混响的量。 |
| 混响最小发送距离（Reverb Min Send Distance） | 发送至主混响时使用的最小距离。 |
| 混响最大发送距离（Reverb Max Send Distance） | 发送至主混响的最大距离。 |
| 混响插件设置（Reverb Plugin Settings） | 数组中多个用于混响插件的设置。 |
| **衰减（聚焦）** |  |
| 启用聆听者聚焦（Enable Listener Focus） | 启用基于聆听者聚焦的调整。 |
| 聚焦方位（Focus Azimuth） | 相对于倾听者前向矢量的方位角度（以度为单位），定义音效的聚焦区域。在此区域播放的音效将在焦点内。 |
| 非聚焦方位（Non Focus Azimuth） | 相对于倾听者前向矢量的方位角度（以度为单位），定义音效的非聚焦区域。在此区域外播放的音效将失焦。 |
| 对焦距离缩放（Focus Distance Scale） | 焦点内音效的距离计算的缩放量。可使这些音效看起来比实际距离更近或更远。 |
| 非对焦距离缩放（Non Focus Distance Scale） | 非焦点内音效的距离计算的缩放量。可使焦点内音效看起来比实际距离更近或更远。 |
| 聚焦优先级缩放（Focus Priority Scale） | 焦点内音效的优先级的缩放量。可以用于提高焦点内音效的优先级。 |
| 非聚焦优先级缩放（Non Focus Priority Scale） | 非焦点内音效的优先级的缩放量。可以用于降低非焦点内音效的优先级。 |
| 聚焦音量衰减（Focus Volume Attenuation） | 焦点内音效的衰减量。可以在音效级别覆盖。 |
| 非聚焦音量衰减（Non Focus Volume Attenuation） | 非焦点内音效的衰减量。可以在音效级别覆盖。 |
| 启用聚焦插值（Enable Focus Interpolation） | 启用聚焦插值，以在焦点内外实现平稳过渡。 |
| 聚焦出动插值速度（Focus Attack Interp Speed） | 用于增大插值速度的标量值，最大增至目标聚焦值。需要 **启用聚焦插值** 才能控制该选项。 |
| 聚焦释放插值速度（Focus Release Interp Speed） | 用于增大插值速度的标量值，最大降至目标聚焦值。需要 **启用聚焦插值** 才能控制该选项。 |
| **衰减（优先级）** |  |
| 启用优先级衰减（Enable Priority Attenuation） | 根据距离启用音效优先级的衰减。 |
| 优先级衰减方法（Priority Attenuation Method） | 用于控制优先级衰减的方法： **线性（Linear）：** 基于距离和优先级衰减范围之间线性插值的优先级衰减。 **自定义曲线（Custom Curve）：** 基于所提供曲线的优先级衰减。 可以直接在 **细节面板（Details Panel）** 中设置或者点击参数名称旁的三角形，使用展开的 **外部曲线（External Curve）** 选项来设置到一个外部曲线。 **手动（Manual）：** 使用下面指定的手动设置的 **衰减优先级** 等级。对2D音效很有用。 |
| 最小距离处的优先级衰减（Priority Attenuation At Min Distance） | 声音处在最近聆听者的最小优先级衰减距离时，针对优先级进行调整的内插值。 |
| 最大距离处的优先级衰减（Priority Attenuation At Max Distance） | 声音处在最近聆听者的最大优先级衰减距离时，针对优先级进行调整的内插值。 |
| 优先级衰减最小距离（Priority Attenuation Min Distance） | 衰减优先级的最小距离。 |
| 优先级衰减最大距离（Priority Attenuation Max Distance） | 衰减优先级的最大距离。 |
| 衰减优先级（Attenuation Priority） | (用于 **优先级衰减方法**设为手动时）使用的静态优先级标量，不随距离而更改。 |
| **衰减（空气吸收）** |  |
| 启用空气吸收（Enable Air Absorption） | 将带截止频率的滤波器应用为距离函数，模拟空气吸收。 |
| 最小距离范围（Min Distance Range） | 应用低通频率过滤的最小距离。 吸收频率切断在 **最小距离范围** 和 **最大距离范围** 之间的过滤频率范围之间进行插值。 |
| 最大距离范围（Max Distance Range） | 应用低通频率过滤的最大距离。吸收频率切断在 **最小距离范围** 和 **最大距离范围** 之间的过滤频率范围之间进行插值。 |
| 最小低通截止频率（Low Pass Cutoff Frequency Min） | 低通吸收滤波器的最小截止频率（以赫兹为单位）范围。 |
| 最大低通截止频率（Low Pass Cutoff Frequency Max） | 低通吸收滤波器的最大截止频率（以赫兹为单位）范围。 |
| 高通切断最小频率（High Pass Cutoff Frequency Min） | 高通吸收滤波器的最小截止频率范围（Hz）。 |
| 高通切断最大频率（High Pass Cutoff Frequency Max） | 高通吸收滤波器的最大截止频率范围（Hz）。 |
| 启用对数频率缩放（Enable Log Frequency Scaling） | 启用后，向频率值应用对数缩放，因此产生感知上的线性频率扫描。 |
| 吸收方法（Absorption Method） | 此方法用于将距离值映射到频率吸收值： **线性（Linear:）** 空气吸收遵照线性距离函数。 **自定义曲线（Custom Curve:）** 空气吸收遵照自定义距离曲线。可以直接在 **细节面板（Details Panel）** 中设置或者点击参数名称旁的三角形，使用展开的 **外部曲线（External Curve）** 选项来设置到一个外部曲线。 |
| **衰减（源数据重载）** |  |
| 启用源数据重载（Enable Source Data Override） | 使用源数据重载插件来重载WaveInstance数据。 |
| 源数据重载插件设置（Source Data Override Plugin Settings） | 数组中多个用于源数据重载插件的设置。 |

立体声文件在左右声道上均匀播放，并进行衰减以使音量在半径最小值和最大值之间衰减，但它们不会空间化。

不包含Attenuation节点的Sound Cue未进行本地化，并且始终按Sound Cue音量设置播放。

## 分支节点

**分支（Branch）** 根据布尔参数值 **True**、**False** 或 **未设置参数（Parameter Unset）** 选择子节点。

未设置参数（Parameter Unset）是指命名参数的值未设置时会运行的输出。例如，如果参数在Branch节点中另存为 `Name` ，但用户尚未调用 `SetBooleanParam(Name, [true or false])` 则Sound Cue将使用未设置参数输入引脚，而不是True或False引脚。。

更多关于命名参数的相关信息，请参考该页面的[命名参数](#namedparameters)小节。

![分支声音节点](../../../../../assets/images/d9/d9033855d6b2c61dea9a71bf3dd36b69e1ed8281d5222d33735c400be5ae8258.png)

| 属性 | 描述 |
| --- | --- |
| **布尔参数名称（Bool Parameter Name）** | 决定使用哪个子节点的布尔参数名称。 |

## 串联器节点

**串联器（Concatenator）** 节点用于按顺序播放音效（例如，创建播放一系列指定曲目的简单BGM播放列表）。当此节点处理顺序播放时，它还将在每个资产之间增加小延迟。

该节点最初有两个输入引脚。点击 **添加输入（Add input）** 添加更多。 也可以右键点击然后选择 "删除输入（Delete Input）" 来移除。

![串联器声音节点](../../../../../assets/images/9e/9e9955206f63980bc4006093dcc6f866c8fed350180cd2b880a3639d5c4f382f.png)

| 属性 | 描述 |
| --- | --- |
| 输入音量（Input Volume） | 为附加到串联器的每个音效资产提供音量设置。 |

## 连续调制器节点

**连续调制器（Continuous Modulator）** 节点提供了一种实时控制音量和音高调制游戏进程参数的方式。典型示例是用车辆的速度对应引擎音效的音高。该调制器需要连接代码或者蓝图才能工作，并且不能在Sound Cue编辑器中单独运行。但是，你可以在Sound Cue编辑器中更改音高和音量。

通过设置最大值和最小值，你可以确定随机范围。

> [!NOTE]
> 输入音效的音高和音量将默认为均匀分布，但是你可以在Sound Cue编辑器中将其更改为任何其他类型。

更多关于命名参数的相关信息，请参考该页面的[命名参数](#namedparameters)小节。

![连续调制器声音节点](../../../../../assets/images/8b/8b97a0d7e2697241141065bf18e97dec0e0ad20d4a650509bd01202d6278ad57.png)

| 属性 | 描述 |
| --- | --- |
| **音高调制参数** |  |
| 参数名称（Parameter Name） | 用于控制音高的参数。 |
| 默认值（Default） | 找不到参数时使用的默认音高值。 |
| 最小输入（Min Input） | 最小输入音高值。数值将限定在 `[MinInput, MaxInput]` 范围内。 |
| 最大输入（Max Input） | 最大输入音高值。数值将限定在 `[MinInput, MaxInput]` 范围内。 |
| 最小输出（Min Output） | 最小输出音高值。数值在 `[MinInput, MaxInput]` 和 `[MinOutput, MaxOutput]` 范围内缩放。 |
| 最大输出（Max Output） | 最大输出音高值。数值在 `[MinInput, MaxInput]` 和 `[MinOutput, MaxOutput]` 范围内缩放。 |
| 参数模式（Param Mode） | 参数应用模式： **正常模式（Normal）：** 将输入值限制在范围（最小输入，最大输入），然后映射到范围（最小输出，最大输出）。 **绝对模式（Absolute）：** 与正常模式相同，只是输入值被视为绝对值。 **直接模式（Direct）：** 直接使用输入值，无需缩放或参考最小或最大输入或输出值。 |
| **音量调制参数** |  |
| 参数名称（Parameter Name） | 用于控制音量的参数。 |
| 默认值（Default） | 找不到参数时使用的默认值。 |
| 最小输入（Min Input） | 最小输入音量值。值将限定在 `[MinInput, MaxInput]` 范围内。 |
| 最大输入（Max Input） | 最大输入音量值。值将限定在 `[MinInput, MaxInput]` 范围内。 |
| 最小输出（Min Output） | 最小输出音量值。数值在 `[MinInput, MaxInput]` 和 `[MinOutput, MaxOutput]` 范围内缩放。 |
| 最大输出（Max Output） | 最大输出音量值。数值在 `[MinInput, MaxInput]` 和 `[MinOutput, MaxOutput]` 范围内缩放。 |
| 参数模式（Param Mode） | 参数应用模式： **正常模式（Normal）：** 将输入值限制在范围（最小输入，最大输入），然后映射到范围（最小输出，最大输出）。 **绝对模式（Absolute）：** 与正常模式相同，只是输入值被视为绝对值。 **直接模式（Direct）：** 直接使用输入值，无需缩放或参考最小或最大输入或输出值。 |

## 按距离交叉淡化节点

**按距离交叉淡化（Crossfade by Distance）** 节点提供在两个或多个输入音效之间实现消退效果的功能，具体根据从Sound Cue的原点到倾听者的距离而定。

例如，远距离枪声与近距离枪声听起来会不一样。该节点可以计算倾听者距镜头的距离，并根据短距离或长距离或两者混合的情况播放音效。

该节点与衰减节点的不同之处在于，只有在它位于最小和最大距离设置范围内时，音效才会播放。

声音节点可以直接连接到按距离交叉淡化节点，但是你也可以在它们之间添加节点，以便对每个层级进行独立控制。

默认情况下，节点最初有两个输入引脚。点击 **添加输入（Add input）** 添加更多引脚。

![按距离交叉淡化节点(crossfade-by-distance-sound-node.png)

| 属性 | 描述 |
| --- | --- |
| **交叉淡化输入** |  |
| 淡入距离起点（Fade in Distance Start） | 可以开始听到音效的，与听者位置的距离。 |
| 淡入距离终点（Fade in Distance End） | 音效达到满音量时，与听者位置的距离。 |
| 淡出距离起点（Fade Out Distance Start） | 音效开始出现淡出效果时，与听者位置的距离。 |
| 淡出距离终点（Fade Out Distance End） | 无法再听到音效时，与听者位置的距离。 |
| 音量（Volume） | 输入声音的最大音量。 |

> [!TIP]
> 如果想要近距离听音，可以将 **淡入距离起点（Fade in Distance Start）** 设置为0。

可以为每种附加音效独立设置这些值。

## 按参数交叉淡化节点

**按参数交叉淡化（Crossfade by Param）** 节点的工作方式与 **按距离交叉淡化** 节点的工作原理类似，不同之处在于 **按参数交叉淡化** 节点为你提供了一种以编程方式（使用代码或蓝图）操纵可控制交叉消退的参数值的方式。

该节点最初有两个输入引脚。点击 **添加输入（Add input）** 添加更多。 也可以右键点击然后选择 "删除输入（Delete Input）" 来移除。

更多关于命名参数的相关信息，请参考该页面的[命名参数](#namedparameters)小节。

> 图片已省略：按参数交叉淡化节点

| 属性 | 描述 |
| --- | --- |
| 参数名称（Param Name） | 用于控制交叉消退的参数名称。 |
| **交叉淡化输入** |  |
| 淡入参数值起点（Fade In Param Value Start） | 开始听到此音效的参数值。 |
| 淡入参数值终点（Fade In Param Value End） | 音效达到最大音量的参数值。 |
| 淡出参数值起点（Fade Out Param Value Start） | 音效开始淡出的参数值。 |
| 淡出参数值终点（Fade Out Param Value End） | 音效停止的参数值。 |
| 音量（Volume） | 输入声音的最大音量。 |

> [!TIP]
> 如果想要近距离听音，可以将 **淡入参数值起点（Fade in Param Value Start）** 设置为0。

> [!WARNING]
> **Crossfade by Param** 节点不支持负值。

### Crossfade by Param案例

> 图片已省略：undefined

点击查看大图。

上图显示了，在根据各种属性值设定完两个参数后，随时间产生的预期结果。

## 延迟节点

**延迟（Delay）** 节点在音效节点链中插入延迟操作，以便在输入音效传递到输出之前引发暂停。延迟量是 **细节（Details）** 面板中指定的 **最小延迟（Delay Min）** 和 **最大延迟（Delay Max）** 之间的随机值。

> 图片已省略：延迟声音节点

| 属性 | 描述 |
| --- | --- |
| 最小延迟（Delay Min） | 设置暂停的时间下限（以秒为单位）。 |
| 最大延迟（Delay Max） | 设置上限（以秒为单位）。 |

## 对话播放器节点

The **对话播放器（Dialogue Player）** 节点可用于在特定条件下播放 **对话音波（Dialogue Wave）** 音效资产。

由于对话音波设计为仅用于语音对话，因此对话音波节点要求你同时指定说话者和正在播放对话的目标。这使对话音波可以根据说话者的声音以及为实现本地化目的而需要进行的任何性别/复数格/尊称处理播放正确的音效资产。

> 图片已省略：对话播放器节点

| 属性 | 描述 |
| --- | --- |
| 对话音波（Dialogue Wave） | 节点将播放的对话音波。点击下拉菜单，浏览你要使用的资产。 |
| 情景（Context） | 谁在说话，以及在和谁说话。请注意，只有输入有效的对话音波后才能使用此功能。 |
| 循环（Looping） | 启用后，将循环播放对话。 |

## 多普勒节点

**多普勒（Doppler）** 节点模拟多普勒效果，其中音效的音高随着与听者之间的相对运动而变化。声源接近听者时音高增加，远去时降低。

> [!NOTE]
> 常见的现实场景示例为警笛声效，声音靠近然后远去。

> 图片已省略：多普勒声音节点

| 属性 | 描述 |
| --- | --- |
| 多普勒强度（Doppler Intensity） | 用于表现听到的多普勒效果强度的乘数值。增加该值可使效果更加明显。 |
| 使用平滑（Use Smoothing） | 启用时，节点对多普勒效果进行平滑内插。 |
| 平滑内插速度（Smoothing Interp Speed） | 内插音高范围的速度。 |

## Envelope器节点

**Envelope器（Enveloper）** 节点是一种创建具有可选循环功能包络的方法，该功能可以通过分布曲线不断控制音效的音量和音高。这些曲线可以使用嵌入式 **曲线编辑器（Curve Editors）** 编辑，也可以基于 **内容浏览器（Content Browser）** 中现有浮点曲线资产中定义的曲线编辑。

可以选择让envelope循环指定次数或者无限循环。

> [!NOTE]
> 你可以使用 **调制（Modulation）** 类别中的属性，在包络上的所有定义点随机化预定义值。

> 图片已省略：Envelope器声音节点

| 属性 | 描述 |
| --- | --- |
| **循环** |  |
| 循环起点（Loop Start） | Envelope循环开始的时间（以秒为单位）。 |
| 循环终点（Loop End） | Envelope循环结束的时间（以秒为单位）。 |
| 循环后时长（Duration After Loop） | 最后一个循环完成后，Envelope淡出的时间（以秒为单位）。 |
| 循环计数（Loop Count） | 启用循环并且Envelope未设置为无限循环时，Envelope应循环的次数。 |
| 无限循环（Loop Indefinitely） | 启用后，Envelope将继续无限循环，而与 **循环计数** 值无关。 |
| 循环（Loop） | 启用后，Envelope将使用在此节点中输入的设置循环。 |
| **包络（Envelope）** |  |
| 音量曲线（Volume Curve） | 定义音量Envelope的分布曲线。可以直接在 **细节面板（Details Panel）** 中设置或者点击参数名称旁的三角形，使用展开的 **外部曲线（External Curve）** 选项来设置到一个外部曲线。 |
| 音高曲线（Pitch Curve） | 定义音高Envelope的分布曲线。可以直接在 **细节面板（Details Panel）** 中设置或者点击参数名称旁的三角形，使用展开的 **外部曲线（External Curve）** 选项来设置到一个外部曲线。 |
| **调制** |  |
| 最小音高（Pitch Min） | 输入音效的最小音高。 |
| 最大音高（Pitch Max） | 输入音效的最大音高。 |
| 最小音量（Volume Min） | 输入音效的最小音量。 |
| 最大音量（Volume Max） | 输入音效的最大音量。 |

## 组控制节点

**组控制（Group Control）** 节点根据正在播放的音效的数量控制要播放的声波，优先第一个可用的组。

该节点最初有两个输入引脚。点击 **添加输入（Add input）** 添加更多。 也可以右键点击然后选择 "删除输入（Delete Input）" 来移除。

> 图片已省略：组控制节点

| 属性 | 描述 |
| --- | --- |
| 组大小（Group Sizes） | 组中允许的最大声波资源数减1（第一个声波节点为节点 **0**）。 |

## 循环节点

**循环（Looping）** 节点用于循环声波指定次数或者无限循环。

> [!TIP]
> 与 **混音器（Mixer）** 节点结合使用时，可以独立循环多个音效文件。

> 图片已省略：循环声音节点

| 属性 | 描述 |
| --- | --- |
| 循环计数（Loop Count） | 循环特定音效的次数。仅当禁用 **无限循环（Loop Indefinitely）** 选项时，才可以编辑此属性。 |
| 无限循环（Loop Indefinitely） | 启用后，无论 **循环计数** 值如何，都会无限循环。 |

> [!NOTE]
> **循环节点** 仅应用于逻辑或过程循环，例如引入延迟，因为这些音效将无法无缝播放。如果你想要音效无缝且无限循环，请在音效的 **声波播放器（Wave Player）** 节点（参阅以下内容）使用 **循环（Looping）** 标记。

## 成人节点

借助 **成人（Mature）** 节点，可用标记输入节点仅限制成人使用。该节点使用 `UEngine:bAllowMatureLanguage` 来判断是否应该播放节点。

该节点最初有两个输入引脚。点击 **添加输入（Add input）** 添加更多。 也可以右键点击然后选择 "删除输入（Delete Input）" 来移除。

> 图片已省略：成人声音节点

## 混音器节点

**混音器（Mixer）** 节点定义了Sound Cue中的并发音效如何混合在一起，每个输入的音量可以独立设置。

该节点最初有两个输入引脚。点击 **添加输入（Add input）** 添加更多。

> 图片已省略：混音器声音节点

| 属性 | 描述 |
| --- | --- |
| 输入音量（Input Volume） | 用于每种输入音效的音量列表，从而可以标准化具有不同源音量的音效。在细节面板中，节点的顶部输入为0，按顺序增加。 |

## 调制器节点

**调制器（Modulator）** 节点用于添加随机音量和音高调制。通过设置最大值和最小值，你可以确定随机范围。触发Sound Cue时，它会随机选择在该范围内的值。

> [!TIP]
> 要为音量或音高设置一致水平，请将最小值和最大值设置为相同的数值。此节点还可以用于调整Sound Cue中包含的多个声波节点的相对音量。

> [!NOTE]
> 如果将 **调制器（Modulator）** 节点与 **循环（Looping）** 节点结合使用，它将基于Sound Cue重新触发（而不是按循环旋转）随机选择。

> 图片已省略：调制器声音节点

| 属性 | 描述 |
| --- | --- |
| 最小音高（Pitch Min） | 设置输入音效的最小音高。 |
| 最大音高（Pitch Max） | 设置输入音效的最大音高。 |
| 最小音量（Volume Min） | 设置输入音效的最小音量。 |
| 最大音量（Volume Max） | 设置输入音效的最大音量。 |

## 振荡器节点

**振荡器（Oscillator）** 节点用于不断添加连续音高和音量振荡。当循环音效以产生更大程度的持续运动时，此属性很有用。

通过设置最大值和最小值，你可以确定随机范围。

> 图片已省略：振荡器声音节点

| 属性 | 描述 |
| --- | --- |
| 调制音量（Modulate Volume） | 选中可启用音量调制。 |
| 调制音高（Modulate Pitch） | 选中可启用音高调制。 |
| 振幅最小值（Amplitude Min） | 正弦波调制的最小振幅，集中于中心最小值和中心最大值设置的值。比如，振幅0.25会导致其在0.75到1.25之间振荡。 |
| 振幅最大值（Amplitude Max） | 正弦波调制的最小振幅，集中于中心最小值和中心最大值设置的值。比如，振幅0.25会导致其在0.75到1.25之间振荡。 |
| 最小频率（Frequency Min） | 正弦波调制的最小频率，该值除以2等于赫兹率。例如，频率20将在10Hz处振荡。 |
| 最大频率（Frequency Max） | 正弦波调制的最大频率，该值除以2等于赫兹率。例如，频率20将在10Hz处振荡。 |
| 最小偏移（Offset Min） | 进入正弦波的最小偏移值，通常称为 相位。 在此输入的任何值都将乘以2π。 |
| 最大偏移（Offset Max） | 进入正弦波的最大偏移值，通常称为 相位。 在此输入的任何值都将乘以2π。 |
| 中心最小值（Center Min） | 中心最小值和中心最大值均默认为0。由于默认值为0（而不是1），因此，如果振幅为0.2，则样本的相乘范围将在-0.2和0.2（而不是0.8和1.2）之间。 |
| 中心最大值（Center Max） | 参见中心最小值。 |

## 质量级别节点

默认情况下，没有质量级别。设计人员必须将它们添加到项目设置中，以便填充节点输入。填充后，可以使用节点分支在SoundCue图表复杂度的各个级别之间切换。这为设计人员提供了在配置较低的平台上使用更简单SoundCue图表的方法。

> 图片已省略：质量级别声音节点

**质量级别（Quality Level）** 节点利用 `GameUserSettings AudioQualityLevel` （或编辑器覆盖）选择要播放的分支。

在运行时，此节点仅将连接到选定分支的声波加载到内存中。

## 随机节点

**随机（Random）** 节点用于从一组可能的节点中随机触发节点。权重值可控制相对于连接到随机节点的其他节点触发节点的可能性。

当一个输入节点被随机选中时，Sound Cue会播放该输入的整个数据流。

该节点最初有两个输入引脚。点击 **添加输入（Add input）** 添加更多。 也可以右键点击然后选择 "删除输入（Delete Input）" 来移除。

> 图片已省略：随机声音节点

| 属性 | 描述 |
| --- | --- |
| 权重（Weights） | 每个输入音效的权重列表，用于确定选中特定音效的机率。数组中的每个项目都可以指定自己的权重值。 |
| 关卡加载时预选（Preselect at Level Load） | 若大于0，那么在每个关卡加载时会随机提前选择输入并且清空其余的。可以用于在大型随机Cue中减少内存使用。请注意，在编辑器内运行或模拟期间此设置不适用；它仅适用于虚幻编辑器以外的游戏构建。 |
| 应从分支剔除中排除（Should Exclude from Branch Culling） | 若设为true，在项目设置中设置了预加载随机分支最大数量的平台上，该随机节点加载时不会被剔除。 |
| 无替换随机化（Randomize Without Replacement） | 启用后，则将在播放完所有输入声音节点之前阻止再次播放输入。 |

## 音效类节点

**音效类（SoundClass）** 节点提供了一种重新映射与输入节点一起使用的 **音效类（Sound Class）** 资产的方法。

更多关于命名参数的相关信息，请参考该页面的[命名参数](#namedparameters)小节。

> 图片已省略：音效类声音节点

| 属性 | 描述 |
| --- | --- |
| **音效类覆盖（Sound Class Override）** | 音效类资产，将覆盖输入节点的当前音效类。 |

## 切换节点

**切换（Switch）** 节点根据整数参数的值选择输入节点。指定的参数必须用代码或者蓝图声明。

该节点最初有两个输入引脚。点击 **添加输入（Add input）** 添加更多。 也可以右键点击然后选择 "删除输入（Delete Input）" 来移除。

更多关于命名参数的相关信息，请参考该页面的[命名参数](#namedparameters)小节。

> 图片已省略：切换声音节点

| 属性 | 描述 |
| --- | --- |
| **Switch** |  |
| **整形参数名称（Int Parameter Name）** | 决定使用哪个输入的整数参数名称。 |

## 声波参数节点

**声波参数（Wave Param）** 节点使用命名参数确定是否播放与输入引脚的声波不同的声波。如果将指定的参数名称设置为有效的声波资产，则播放该资产，而不是Sound Wave输入节点。

如果连接了可选的输入节点并且命名参数有效，那么声波参数节点会在Sound Cue播放时覆盖输入节点。

更多关于命名参数的相关信息，请参考该页面的[命名参数](#namedparameters)小节。

> [!TIP]
> 一种可能的使用场景为在固定的提示音之间播放动态的对话台词，以此来模拟无线电中的对话。这样可以大量重复使用同一个Sound Cue。

> 图片已省略：声波参数声音节点

| 属性 | 描述 |
| --- | --- |
| **声波参数名称（Wave Parameter Name）** | 用于确定播放哪个声波的参数。如果该参数不存在，或者它指向无效的声波，则将评估由连接到输入节点的树指定的声波，以便确定播放哪个声波。 |

## 声波播放器节点

**声波播放器（Wave Player）** 节点包含对要播放的声波资产的引用。

> 图片已省略：声波播放器声音节点

> 图片已省略：循环声波播放器声音节点

| 属性 | 描述 |
| --- | --- |
| 声波（Sound Wave） | 要在此节点中使用的声波资产。 |
| 循环（Looping） | 启用后，声波将循环播放。另外，声音节点图表中显示的节点类型会变成 "循环声波播放器（Looping Wave Player）。" |

## 添加注释

可以在Sound Cue上的任何位置添加注释。它们不影响输出，而是用于提醒或解释节点布置或使用的细节。

注释显示在顶部栏中。注释没有长度限制，但应尽可能简短。

> 图片已省略：添加注释框

注释框的尺寸可以通过拖动右下角的线条来改变，直接拖动注释框可以移动其位置。无论注释位于Sound Cue的什么位置，它都将出现在节点后面。

> [!TIP]
> 如果移动一个注释框，会将其中完全包裹的声音节点一同移动。
>
> 选中多个节点，右键点击其中之一，然后选择 **从选中项创建注释（Create Comment from Selection）**。这样也可以创建注释。

## 示例

下面是较复杂的Sound Cue布局示例。点击图片可以查看大图。

> 图片已省略：undefined

如果将参数设置为True，则此Sound Cue播放一种音效，如果将其设置为False，则播放另一种音效。

> 图片已省略：undefined

此Sound Cue会更改声波的音效类。

> 图片已省略：undefined

此Sound Cue将具有各种属性的声波混合在一起，属性包括衰减、随机化、循环和延迟。

