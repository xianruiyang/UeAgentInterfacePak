# 12-2-Houdini爆炸模拟设置

# 12-2-Houdini爆炸模拟设置

## 关键术语

- `Alpha`、`GPU`、`CPU`、`Roughness`、`Houdini`、`Smoke`、`粒子`、`速度`、`纹理`、`缓存`、`Niagara`、`Material`、`颜色`、`烟雾`、`Niagara System`、`Emitter`、`Particle`、`Spawn`

## 分段知识

### 00:00:00-00:04:41 Roughness、速度、缓存

- 本段定位：Roughness、速度、缓存。
- 知识点：这样速度变慢的话,其实是有点问题的。
- 知识点：这时候不要继续模拟,停下来把选项调弱一点, 确认数值,然后再重新缓存。
- 知识点：这样看缓存的时候,也要有效率地思考有机地应对。
- 知识点：现在为了更快地检查第二个缓存, 我只跑了大约50帧。
- 知识点：我们最初设置的值是1,然后 通过这些针,现在可观察到与膨胀的带位穷四区相关的选项。
- 核对对象：`速度`。

**关键画面：**

本图延续上一页的缓存过程，但重点转成了“当数值异常时，不要继续模拟”。当前选中节点仍是 `filecache1` 的 `v2` 版本，右侧参数显示：
- `Base Name = Ex_03_Explosion_01.filecache1`
- `Version = 2`
- `Base Folder = $HIP/geo`
- `Evaluate As = Frame Range`
- `Start/End = 1 到 70`
- `Simulation` 启用

中央 `Interrupt` 窗口显示当前进度为 `render frame 16 (16 of 70)`，状态为 `Paused...`，说明作者已经主动暂停缓存过程，而不是任由错误的数值继续跑完。左侧视口中可见一个明显过亮、过曝的火焰团，字幕也指出“模拟的数值有点不正常”。因此这一帧传达的核心规则是：一旦缓存中途发现速度、膨胀或火焰数值异常，应立即暂停求解，先回头减弱参数并核对数值，再重新缓存，而不是继续浪费整段求解时间。
本图展示在暂停缓存后回到 `pyrosolver_fireball` 继续下调关键数值。当前右侧参数面板能看到以下模块与参数：
- `Buoyancy`
  - `Buoyancy Scale = 0.25`
  - `Ambient Temp (K) = 300`
  - `Reference Temp (K) = 3000`
- `Gravity`
  - `Gravity Acceleration = 9.8`
  - `Gravity Direction = (0, -1, 0)`
- `Disturbance`
  - `Disturbance = 5`
  - `Mode = Block-Based`
  - `Base Block Size = 0.2`
  - `Roughness = 0.75`
  - `Pulse Length = 0.2`
  - `Max Octaves = 3`
  - `Lacunarity = 2.1`
  - `Threshold Field = density`
  - `Threshold Range = 0.01 到 0`
  - `Use Control Field` 启用，`Control Field = speed`
  - `Control Range = 1 到 2`
- `Turbulence`
  - `Noise Type = Analytic Fast Simplex Noise`
  - `Turbulence = 5`
  - `Swirl Size = 10`
  - `Roughness = 0.5`
  - `Pulse Length = 0.5`
  - `Max Octaves = 3`
  - `Seed = 0`
  - `Threshold Field = temperature`
  - `Threshold Range = 0.1 到 0`

左侧视口此时几乎没有可见爆炸体积，只剩空场景和包围盒，说明这些减弱后的参数已经显著压低了原先过强的火焰/膨胀效果。字幕提到“降低数值，然后和之前一样用补偿数值代替一些选项”，对应的就是这里：先整体削弱浮升、扰动、湍流等高敏感项，再通过后续更精确的补偿参数去把需要的形态一点点加回来。
本图展示在 Houdini 中切到手动输入模式来精确控制 `pyrosolver_fireball` 的参数。左上方打开了 `Animation Editor`，左侧 `Channel List` 中当前选中通道为 `geo1/pyrosolver_fireball` 下的 `Turbulence`，当前值显示约为 `2.9375`。右侧参数面板中的 `Turbulence` 模块也同步显示：
- `Turbulence = 2.9375`
- `Swirl Size = 2`
- `Roughness = 0.5`
- `Pulse Length = 0.5`
- `Max Octaves = 3`
- `Seed = 0`
- `Threshold Field = temperature`
- `Threshold Range = 0.1 到 0`

字幕明确说明“想自由输入数值时，切换到手动模式”。这张图的关键价值不在于某个最终效果，而在于操作方法：当拖拽滑条容易导致频繁重算或难以精确输入时，应切到动画编辑器/手动通道输入方式，直接给 `Turbulence` 这类敏感参数设定具体数值。这样既能减少不必要的卡顿，也更适合快速对比不同缓存版本的细微差异。

### 00:04:41-00:08:26 缓存

- 本段定位：缓存。
- 知识点：只需快速进行数值计算, 并用缓存烘焙确认时。
- 知识点：手动模式可以减少不必要的卡顿。
- 知识点：从5开始, 6帧初期只用强一点的旅行。
- 知识点：现在旅行包尺寸变小了, 整体感觉也小了一些。
- 知识点：不过现在问题是, 缩小了距离感尺寸。

**关键画面：**

本图继续围绕“手动模式减少缓存阶段卡顿”这一操作方法展开。左上依旧打开 `Animation Editor`，右侧参数面板仍显示 `pyrosolver_fireball` 的 `Turbulence` 模块，当前值保持在 `2.9375`；但画面右下角额外弹出了更新模式菜单，可见三个选项：
- `Auto Update`
- `On Mouse Up`
- `Manual`

字幕明确说“手动模式可以减少不必要的卡顿”，对应的就是这里：在频繁调 `Turbulence`、`Disturbance` 这类高敏感参数时，不要让 Houdini 在每次微小拖动时都立刻重算，而是切换到 `Manual` 或至少 `On Mouse Up`。这样可以先连续输入或拖完一组数值，再统一触发更新，大幅减少缓存烘焙前试值阶段的无效等待。
本图展示在手动减弱参数后重新观察缓存结果。左侧视口中的爆炸体积已经恢复可见，但整体看起来团块凹陷、表面起伏不均，字幕也直接评价“看起来有点塌陷的体积形状不太好看”。当前时间轴约位于第 `53` 帧附近，说明这是在中后段帧检查调整后形态是否仍成立。

右侧 `pyrosolver_fireball` 参数面板当前可见的关键值包括：
- `Disturbance = 5`
- `Mode = Block-Based`
- `Base Block Size = 1.5`
- `Roughness = 0.5`
- `Pulse Length = 0.2`
- `Max Octaves = 3`
- `Lacunarity = 2.1`
- `Turbulence = 0.02`
- `Swirl Size = 2`
- `Roughness = 0.5`
- `Pulse Length = 0.5`
- `Max Octaves = 3`
- `Threshold Field = temperature`
- `Threshold Range = 0.1 到 0`

这说明虽然把 `Turbulence` 大幅压低确实减少了过强抖动，但也可能让体积失去足够的内部支撑与卷曲层次，导致烟火团块变得发塌。对复现而言，这一帧是典型的负面案例：当目标是更稳定的缓存时，不能只一味减小扰动和湍流，还要观察中后段帧里体积是否因此失去饱满度。
本图继续在 `pyrosolver_fireball` 中检查火焰发射与温度相关数值是否已经正确输入。左侧视口几乎只有空场景和包围盒，说明当前这组参数在此时刻还没有形成足够可见的体积结果；字幕也明确提示“检查下有没有输入数值”，因此这张图的重点是核对参数输入状态，而不是展示最终外观。

右侧当前可见参数块为：
- 控制场曲线：
  - `Control Field = temperature`
  - `Control Range = 0 到 1`
  - `Remap Control Field` 启用，曲线从左高右低衰减
- 第一组 `Emit From Flame`
  - `Operation = Maximum`
  - `Emission Scale = 1`
  - `Flame Range = 0.1 到 0.75`
  - `Remap Flame Range` 启用，曲线中段隆起
- `Temperature`
  - `Diffusion = 0`
  - `Cooling Rate = 0.5`
- 第二组 `Emit From Flame`
  - `Operation = Add`
  - `Emission Scale = 0.1`
  - `Flame Range = 0.6 到 1`
- `Flame`
  - `Flame Lifespan = 2`

这张图反映的是缓存前的核对动作：当把湍流、膨胀等高影响参数压弱之后，还要回头确认 `Emit From Flame`、`Temperature`、`Flame Lifespan` 这类基础数值是否仍在合理区间，避免因为漏输或误改而出现“几乎什么都不生成”的空结果。

### 00:08:31-00:13:19 速度、颜色、缓存

- 本段定位：速度、颜色、缓存。
- 知识点：现在再试一次缓存。
- 知识点：那么, 好的, 现在缓存都完成了。
- 知识点：现在缓存烘焙速度时间变长了很多。
- 知识点：确实体速的数量增加了。
- 知识点：这时候为了正确了解动画的进展, 感觉现在可以试试用这种翻页书。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`速度`、`颜色`。

**关键画面：**

本图展示在重新缓存完成后回看 `pyrosolver_fireball` 的参数状态。左侧视口几乎只有空场景和边界框，字幕则说明“现在缓存都完成了”，这表明当前缓存虽然已经跑完，但结果在这个时间点明显偏弱，不足以形成稳定可读的爆炸体积。

右侧当前可确认的关键参数为：
- `Disturbance`
  - `Disturbance = 5`
  - `Mode = Block-Based`
  - `Base Block Size = 1.5`
  - `Roughness = 0.5`
  - `Pulse Length = 0.2`
  - `Max Octaves = 3`
  - `Lacunarity = 2.1`
  - `Threshold Field = density`
  - `Threshold Range = 0.01 到 0`
  - `Use Control Field` 启用，`Control Field = speed`
  - `Control Range = 1 到 2`
- `Turbulence`
  - `Turbulence = 5`
  - `Swirl Size = 2`
  - `Roughness = 0.5`
  - `Pulse Length = 0.5`
  - `Max Octaves = 3`
  - `Seed = 0`
  - `Threshold Field = temperature`
  - `Threshold Range = 0.1 到 0`
  - `Use Control Field` 启用，`Control Field = density`
  - `Control Range = 0 到 1`
- `Flame Expansion`
  - `Expansion Rate = 1`
  - `Flame Range = 0.35 到 1`

这张图可以理解为一次完整缓存后的数值复盘：虽然通过降低参数避免了过曝和异常膨胀，但同时也把火焰与烟雾体积压得过弱。对复现而言，这意味着缓存完成并不等于参数正确，还需要回头根据结果强度继续修正速度、膨胀和颜色相关设置。
本图展示作者用 `MPlay` 翻页书同步复核缓存结果的状态：左侧是 Houdini 视口，中央是 `MPlay` 播放窗口，右侧仍停留在 `Pyro Solver > Fields`。与上一张“结果过弱”的状态相比，这里已经能明显看到主体火团在两个视图里都形成了较完整的体积，说明当前调整至少让速度驱动后的火焰运动和主体轮廓变得可读，可以进入逐帧检查阶段。

右侧当前仍能确认的参数包括：
- `Buoyancy`
  - `Buoyancy Scale = 0.2`
  - `Ambient Temp (K) = 300`
  - `Reference Temp (K) = 3000`
- `Gravity`
  - `Gravity Acceleration = 9.8`
  - `Gravity Direction = (0, -1, 0)`
- `Disturbance`
  - `Disturbance = 5`
  - `Mode = Block-Based`
  - `Base Block Size = 1.5`
  - `Roughness = 0.5`
  - `Pulse Length = 0.2`
  - `Max Octaves = 3`
  - `Lacunarity = 2.1`
  - `Threshold Field = density`
  - `Threshold Range = 0.01 到 0`
  - `Use Control Field` 启用，`Control Field = speed`
  - `Control Range = 1 到 2`
- `Turbulence`
  - `Noise Type = Analytic Fast Simplex Noise`
  - `Turbulence = 5`
  - `Swirl Size = 2`
  - `Roughness = 0.5`
  - `Pulse Length = 0.5`
  - `Max Octaves = 3`

对复现而言，这一帧的重点不是新增某个参数，而是确认当前这组 `Disturbance + Turbulence` 数值已经能把爆炸主体推到可观察范围，并且需要借助翻页书逐帧判断运动节奏、体积膨胀和颜色变化是否自然。
本图说明作者已经从求解阶段切到体积外观整理阶段。中间网络视图可见当前链路为：
- `pyroburstsource`
- `volumerasterizeattributes1`
- `pyrosolver_fireball`
- `filecache1`
- `pyrolook_fireball`
- `Null RENDER_Simple_Fireball`

左侧视口中，爆炸已经呈现为偏灰的烟团，底部和边缘保留少量偏暖色发光，说明这里正在利用 `Pyro Bake Volume` 调整烟雾散射、模糊和遮罩，让缓存结果更接近最终渲染外观，而不是继续改流体运动。

右侧 `Pyro Bake Volume > pyrolook_fireball` 当前可确认的参数为：
- `General`
  - `Assign Material = matnet/Pyro_Shader`
- `Scatter`
  - `Intensity Scale = 50`
  - `Hot Core Scale = 0`
  - `Color Mode = Color Ramp`
  - `Source Range = 0.015 到 1`
  - `Scatter Color Ramp` 为深棕到浅橙的渐变，用于把烟体边缘与内部热区染成暖色
- `Blur`
  - `Use Blur Steps` 启用
  - `Number of Blur Steps = 3`
  - `Blur Step Falloff = 1`
  - `Use World Space Radius Units` 启用
  - `Filter Voxel Radius = 10`
  - `Blur Iterations = 1`
  - `Downsample = 2x`
- `Masking`
  - `Mask Center = 0.52`
  - `Mask Width = 1`

对复现而言，这一张图的作用是把“速度量感已经够用”往后推进到“外观怎么烘焙和着色”。如果要重建同样结果，应先保持上游缓存链路不变，再在 `pyrolook_fireball` 中通过 `Scatter` 暖色渐变、`Blur` 和 `Masking` 把烟团压成更厚重、更接近成品的火球烟雾。

### 00:13:19-00:18:02 粒子、烟雾

- 本段定位：粒子、烟雾。
- 知识点：在粒子中也能调节。
- 知识点：就是让感觉来着色。
- 知识点：还有就是要调整相机角度吧。
- 知识点：70帧作为最大值来看吧。
- 知识点：先用控制加个摄像头。
- 核对对象：`粒子`、`烟雾`。

**关键画面：**

本图进入“粒子、烟雾”段后的第一帧，但画面仍然停留在 `pyrolook_fireball` 的体积烘焙阶段。与上一张相比，左侧视口中的烟团已经明显抬升并向上散开，主体不再是紧凑火球，而是开始转成较轻的烟柱与残焰，说明作者正在通过时间轴直接观察当前烟雾外观在后续帧里的衰减和扩散是否自然。

中间网络链路没有变化，仍是：
- `pyroburstsource`
- `volumerasterizeattributes1`
- `pyrosolver_fireball`
- `filecache1`
- `pyrolook_fireball`
- `Null RENDER_Simple_Fireball`

右侧 `Pyro Bake Volume > Scatter`、`Blur`、`Masking` 面板中当前可见的关键值仍为：
- `Assign Material = matnet/Pyro_Shader`
- `Intensity Scale = 50`
- `Hot Core Scale = 0`
- `Color Mode = Color Ramp`
- `Source Range = 0.015 到 1`
- `Number of Blur Steps = 3`
- `Blur Step Falloff = 1`
- `Filter Voxel Radius = 10`
- `Blur Iterations = 1`
- `Downsample = 2x`
- `Mask Center = 0.52`
- `Mask Width = 1`

这张图的作用不是展示新参数，而是强调要在相同的烘焙设置下查看烟雾生命周期后段。如果后续帧里烟体抬升过快、太薄或残留过少，就需要回头继续改 `Scatter` 色阶、模糊半径或上游模拟强度，而不是只盯住爆炸最亮的前几帧。
本图已经切到对象级取景与布光检查。中间网络中可见 4 个对象：
- `geo1`
- `cam1`
- `sunlight1`
- `skylight1`

左上视口当前锁定在 `cam1` 视角，画面几乎全黑，只能看到中心的操作控件，说明作者正在直接从摄影机画面判断主体是否能完整入镜。左下视口则保留普通透视观察，用来同步看烟雾模型在场景中的实际位置与尺寸。字幕“尽量刚好符合相机尺寸”也对应这一操作目的，即让爆炸体积在镜头里既不要过小，也不要超出构图边界。

右侧当前选中的是 `Environment Light skylight1`，在 `Light` 面板里可确认的设置包括：
- `Light Color = (1, 1, 1)`
- `Light Intensity = 1`
- `Light Exposure = 0`
- `Light Enabled` 启用
- `Enable Sky Environment Map` 启用
- `Resolution = 128`
- `Use = Rotate Angles`
- `Angular Size = 1`
- `Rotate = (-45, 180, 0)`
- `Direction = Away from Sun`

对复现而言，这张图说明“粒子、烟雾”段并不只改模拟本身，还要同步建立镜头和环境光。正确流程是：先在 `cam1` 里把爆炸体积卡到合适构图，再用 `sunlight1 + skylight1` 检查烟雾明暗层次，避免成品渲染时主体太暗、太平，或者体积超出镜头安全范围。
本图展示相机和灯光确认后，作者切到输出阶段验证最终渲染。中间网络位于 `out` 上下文，只保留一个 `mantra1` 输出节点；左上窗口则开始执行渲染，状态栏显示正在从 `/out/mantra1` 渲染当前帧。左下透视视口里仍能看到带暖色内核的烟团外观，用来和渲染窗口的结果互相对照。

右侧当前选中的是 `Mantra mantra1`，可确认的关键输出设置包括：
- `Render Current Frame`
- `Camera = /obj/cam1`
- `Output Picture = $HIP/render/$HIPNAME.$OS.$F4.exr`
- `Output Device = Infer from filename`
- `Create Intermediate Directories` 启用
- `Export Components` 当前包含：
  - `diffuse`
  - `reflect`
  - `coat`
  - `refract`
  - `volume`
  - `sss`
- `Extra Image Planes = 3`
- 当前额外通道之一的 `VEX Variable = pyro_smoke`
- `VEX Type = Vector Type`
- `Quantize = 16 bit float`

这张图对应的流程含义是：当灯光设置和相机尺寸都确认完毕后，不要只停留在视口预览，还要到 `mantra1` 用正式相机和 EXR 输出规则做一次渲染检查。这样才能确认烟雾体积、光照层次以及需要导出的体积通道都能进入最终成片或后期合成流程。

### 00:18:02-00:21:53 GPU、CPU、纹理

- 本段定位：GPU、CPU、纹理。
- 知识点：可以尝试关闭Bidder这个步骤来使用。
- 知识点：使用这种渲染式也可以试试。
- 知识点：或者适当调整一下Masking值。
- 知识点：也是个不错的方法。
- 知识点：或者想要更强效果的人。
- 知识点：可以在这里适当调整数值。
- 知识点：或者增加强度比例。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`GPU`、`CPU`、`纹理`。

**关键画面：**

本图展示作者在 `GPU、CPU、纹理` 段里对火球烘焙外观做最终微调并同步检查渲染结果。左上是 `/out/mantra1` 的渲染窗口，当前帧已经能看到完整的火球爆炸体积；中间网络仍停在 `geo1` 内的体积链路；左下透视视口显示原始场景观察；右侧则继续查看 `Pyro Bake Volume pyrolook_fireball` 的外观参数。

当前网络链路可确认为：
- `pyroburstsource`
- `volumerasterizeattributes1`
- `pyrosolver_fireball`
- `filecache1`
- `pyrolook_fireball`
- `Null RENDER_Simple_Fireball`

右侧当前可确认的关键设置为：
- `Assign Material = matnet/Pyro_Shader`
- `Scatter`
  - `Intensity Scale = 50`
  - `Hot Core Scale = 0`
  - `Color Mode = Color Ramp`
  - `Source Range = 0.015 到 1`
- `Blur`
  - `Use Blur Steps` 当前关闭
  - `Use World Space Radius Units` 当前关闭
  - `Filter Voxel Radius = 10`
  - `Blur Iterations = 1`
  - `Downsample = 2x`
- `Masking`
  - `Mask Center = 0.52`
  - `Mask Width = 1`

字幕说明“可以尝试关闭 `blur` 步骤来使用”，对应的就是这里把 `Blur` 相关开关关掉后，直接对比渲染窗口中的火球轮廓和亮部表现。对复现而言，这一步是在判断烟雾是否因为模糊而过于发散；如果想要更硬朗、更集中、更偏游戏贴图化的体积边缘，可以先关闭 `Blur` 再观察最终渲染差异。
本图展示作者把重点转到正式输出渲染。中间网络位于 `out` 上下文，只保留一个 `mantra1` 节点；左上渲染窗口正在输出火球画面；中央弹出的中断窗口显示当前处于 `Compositing / Rendering Image` 过程；左下透视视口保留爆炸体积的场景预览，用于和渲染结果对照。

右侧 `Mantra mantra1` 当前可确认的关键设置为：
- `Render Frame Range`
  - `Start = 1`
  - `End = 70`
  - `Inc = 1`
- `Render With Take = (Current)`
- `Camera = /obj/cam1`
- `Output Picture = $HIP/render/$HIPNAME.$OS.$F4.exr`
- `Output Device = Infer from filename`
- `Create Intermediate Directories` 启用
- `Export Components`
  - `diffuse`
  - `reflect`
  - `coat`
  - `refract`
  - `volume`
  - `sss`
- `Extra Image Planes = 3`
- 当前额外图层参数可见为：
  - `VEX Variable = pyro_smoke`
  - `VEX Type = Vector Type`
  - `Quantize = 16 bit float`

这张图对应的流程含义是：当火球外观已经基本确认后，作者开始按完整帧范围 `1-70` 进行正式渲染，而不是只看单帧。对复现而言，这一步同时验证三件事：相机 `cam1` 是否正确、序列 EXR 输出路径是否可用、以及烟雾相关的额外 AOV/图层是否被正确写出，方便后续做贴图提取或合成。
本图继续展示 `mantra1` 的整段序列渲染过程，但比上一张更强调渲染进度与机器性能差异。左上渲染窗口里火球仍已成形；中央的 `Interrupt` 窗口显示 `Compositing` 与 `Rendering Image` 进度条都在推进，总耗时已经来到 `1:52`；字幕则说明 CPU 或 GPU 配置不同会导致整体耗时不同。

当前 `mantra1` 输出节点在右侧仍能确认这些关键设置：
- `Render Frame Range = 1 到 70，步长 1`
- `Camera = /obj/cam1`
- `Output Picture = $HIP/render/$HIPNAME.$OS.$F4.exr`
- `Output Device = Infer from filename`
- `Create Intermediate Directories` 启用
- `Export Components`
  - `diffuse`
  - `reflect`
  - `coat`
  - `refract`
  - `volume`
  - `sss`
- `Extra Image Planes = 3`
- 额外图层可见项：
  - `VEX Variable = pyro_smoke`
  - `VEX Type = Vector Type`
  - `Quantize = 16 bit float`

这张图的核心信息不是新增节点，而是给出实际流程判断：火球翻页或纹理烘焙前，往往需要先把整段体积渲染完，而这一步对硬件很敏感。对复现而言，应预留足够渲染时间，不要把教程中的时长当成固定值；如果机器较慢，仍应以输出的 EXR 序列和通道完整性为准，而不是以耗时长短判断流程是否正确。

### 00:21:56-00:24:22 Alpha、Smoke、纹理

- 本段定位：Alpha、Smoke、纹理。
- 知识点：总共大概花了25分钟。
- 知识点：这个现在可能会根据电脑配置有所不同。
- 知识点：我们来看看制作纹理资源的过程。
- 知识点：这些在这里是Explosion, -1M,-1C。
- 知识点：接下来还要做成纹理表的形式。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`纹理`。

**关键画面：**

本图是“Alpha、Smoke、纹理”段开头的过渡帧，但画面内容仍然停留在体积渲染输出阶段。中间网络依旧位于 `out`，只有 `mantra1` 一个输出节点；左上渲染窗口显示已得到可用的火球结果；左下透视视口保留了体积在场景中的原始外观；右侧继续停在 `Mantra mantra1` 的输出设置页。

当前仍能直接确认的输出设置有：
- `Render Frame Range = 1 到 70，步长 1`
- `Camera = /obj/cam1`
- `Output Picture = $HIP/render/$HIPNAME.$OS.$F4.exr`
- `Output Device = Infer from filename`
- `Create Intermediate Directories` 启用
- `Export Components`
  - `diffuse`
  - `reflect`
  - `coat`
  - `refract`
  - `volume`
  - `sss`
- `Extra Image Planes = 3`
- 当前可见额外图层：
  - `VEX Variable = pyro_smoke`
  - `VEX Type = Vector Type`
  - `Quantize = 16 bit float`

字幕里只明确出现了“刚才大概 0.07 左右”的数值结论，但该数值对应的具体参数名在本图中不可见，因此不能据此补写成某个确定设置。就本图能确认的信息而言，它的作用是说明：进入纹理制作前，作者仍在确认火球 EXR 序列与烟雾相关输出通道是否已经准备好，为后续抽帧、制作 Alpha/Smoke 纹理提供来源。
本图展示纹理制作正式开始后的第一步：把渲染出来的 EXR 序列读入 `img/img1` 合成网络，并准备通过 `Trim` 节点裁掉开头不需要的帧。中间网络中当前可见：
- 上游 `File` 节点，文件名显示为 `Ex_03_Explosion_01_mantra1_F4.exr`
- 下游 `trim1` 节点

左上图像查看器当前打开的也是 `$HIP/render` 目录下的这一张 EXR，文件名可读为 `Ex_03_Explosion_01_mantra1_F4.exr`，分辨率为 `512x512`。中间网络里，`File` 节点正准备连接到 `trim1`，而 `trim1` 当前带有 `Error` 标记，说明这一步还在搭建或调整中，尚未得到稳定输出。

右侧 `Trim trim1` 的当前可见参数为：
- `Trim = Relative to Current Start/End`
- `Units = Frames`
- `Start = 0`
- `End = 0`

字幕明确提到“把开始时间提前到 5 帧左右”，因此这张图对应的实际操作目标是：先读入渲染序列，再用 `Trim` 把有效爆炸开始前的空帧裁掉，使后续制作 `Alpha/Smoke` 纹理表时，序列从更有表现力的时间点起始。由于图中此刻参数框里仍显示 `0/0`，只能确认作者正在准备这一步，不能把 `5` 写成已经落定的最终 `Start` 值。
本图展示 `img/img1` 中把火球渲染序列转换成可用于纹理/贴图处理的通道图像。中间网络已经形成完整链路：
- `File`：读取 `Ex_03_Explosion_01_mantra1_F4.exr`
- `trim1`：裁切序列起止范围
- `channelcopy1`：把不同体积通道重新映射到目标 RGBA 通道

左上查看器当前显示的是 `channelcopy1` 的结果，分辨率仍为 `512x512`，画面主体变成黑底上的绿色火焰形状，说明这里已经不再是直接查看原始 beauty 渲染，而是在检查通道重组后的中间纹理结果。左下普通视口里只剩场景中的低亮度体积，用于参照当前帧位置。

右侧 `Channel Copy channelcopy1` 的 `Channel Copy` 面板可确认如下映射：
- `Copy Controls = 4`
- 第 1 组
  - `Target = Cr`
  - `Source = Input 1 pyro_smoke`
  - 读取方式为 `Luminance`
- 第 2 组
  - `Target = Cg`
  - `Source = Input 1 pyro_scat...`
  - 读取方式为 `Luminance`
- 第 3 组
  - `Target = Cb`
  - `Source = Set to 0 (black)`
- 第 4 组
  - `Target = A`
  - `Source = Input 1 A`
  - 读取方式为 `Luminance`

字幕说明“然后是 `Scatter` 通道，第三个是 `Scatter Mask` 通道”，结合当前可见映射，可以确认作者正在把 EXR 中的体积辅助通道拆分并重组为贴图可用的颜色/Alpha 数据。对复现而言，这一步的关键是：不要直接拿 beauty 图当纹理，而要先从渲染出的 `pyro_smoke`、`scatter` 等体积通道里提取亮度信息，再按 RGBA 目标通道重新组织，作为后续做翻页书或纹理表的基础。

### 00:24:30-00:27:08 Alpha、纹理

- 本段定位：Alpha、纹理。
- 知识点：总共14帧来制作表格形式。
- 知识点：反而合成过程有点卡顿。
- 知识点：现在总完成的纹理表形状是这种。
- 知识点：而通道、G通道,还有沿马通道。
- 知识点：连Alpha通道也出来了。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`纹理`。

**关键画面：**

本图展示 `Alpha、纹理` 段中把爆炸序列正式拼成纹理表的阶段。中间 `img/img1` 合成网络当前链路已扩展为：
- 上游 `File`：读取 `Ex_03_Explosion_01_mantra1_F4.exr`
- `trim1`：裁切有效帧范围
- `channelcopy1`：重组通道
- `mosaic1`：把多帧图像排成表格

左上查看器当前仍显示 `channelcopy1` 的单帧结果，黑底上是偏蓝紫色的火焰形态；中间网络里可以看到 `mosaic1` 的节点缩略图已经生成一整块小图阵列，说明序列正在被排布成 sprite sheet。左下视口保留了原场景中的体积形态，只用于帧位参照。

右侧 `Mosaic mosaic1` 当前可确认的参数为：
- `Images per Line = 8`
- `Stack Vertically = Top To Bottom`
- `Stack Horizontally = Left To Right`
- `Stack Images in Rows` 启用
- `Max Images/Frame = 64`
- `Keep Full Size` 当前关闭
- `Background Color = (0, 0, 0)`

结合正文“总共 14 帧来制作表格形式”，这张图的流程含义是：先把经过 `Trim` 和通道重组后的有效帧交给 `Mosaic`，再按固定网格排成纹理表。对复现而言，这一步要重点核对每行张数、堆叠方向和背景色，否则后续在引擎里按 Flipbook/SubUV 读取时，帧顺序和透明背景都会出错。
本图展示纹理表已经拼好，并开始准备导出到外部文件。中间 `img/img1` 网络现在可见的完整链路为：
- `File`
- `trim1`
- `channelcopy1`
- `mosaic1`
- `rop_comp1`

左上查看器当前直接预览 `mosaic1` 的结果，已经是一整张黑底图集，状态栏显示分辨率为 `4096x4096`。可见图集中按固定网格摆放了多帧蓝青色火焰图像，说明从单帧体积通道到 flipbook/sprite sheet 的拼接已经完成。中间网络下方新增 `rop_comp1`，表明下一步就是把这张图集写出。

右侧打开的是输出文件选择对话框，当前定位到 `$HIP/TexOUT/`，并正在输入文件名前缀 `Expl...`。字幕同时说明“然后命名为 explosion01.tj”，因此可以确认这里正在为导出的纹理表设置目标文件名。就本图可见信息而言，扩展名部分在输入框里尚未完整显示，但“输出到 `TexOUT` 目录并按 `explosion01` 命名”这一意图是明确的。

对复现而言，这一步的关键点有两个：
- 先确认 `mosaic1` 的最终输出尺寸和排布正确，本图里是 `4096x4096`
- 再通过 `rop_comp1` 把结果导出到专门的纹理输出目录，并使用统一、可追踪的命名

这样后续在 Unreal 或其他引擎里导入时，才能直接把该图识别为爆炸用的纹理表资源。
本图对应这段纹理表制作的收尾确认。左上查看器继续显示已经完成的 `mosaic1` 纹理表，仍为 `4096x4096` 的黑底多帧图集；中间网络视图则回到 `geo1` 主链路，可见上游爆炸体积链：
- `pyroburstsource`
- `volumerasterizeattributes1`
- `pyrosolver_fireball`
- `filecache1`
- `pyrolook_fireball`
- `Null RENDER_Simple_Fireball`

右侧当前选中的是 `ROP File Output rop_comp1`，在 `Composite` 页可确认的关键导出设置为：
- `Valid Frame Range = Render Current Frame`
- `Start/End/Inc = 5 / 6 / 1`
- `Output Picture = $HIP/TexOUT/Explosion_01.tga`
- `Create Intermediate Directories` 启用
- `Color Plane = C`
- `Alpha Plane = A`
- `Output Colorspace = Autodetect from File`
- `Output LUT = Use Input If Linear`
- `Output Frames Reused in Composite` 启用
- `Reload All Files` 启用

字幕“完成爆炸效果”与这些参数一起说明：作者已经把前面拼好的图集正式定稿为一张带 Alpha 的 `TGA` 纹理表，并写入 `TexOUT` 目录。对复现而言，这张图确认了最终交付不是 EXR 序列，而是经过裁帧、通道重组和图集拼接后的单张纹理资源，可直接进入材质或 Niagara 翻页书流程。

## 补充视觉证据

### S01 00:04:29

这张补充截图在源文档中被单独标注为 `graph` 证据，因此它的重点是补充说明教程前段查看的是哪一条 Houdini 主链，以及当前正在编辑哪一个求解器参数。中间网络当前能直接识别出：
- `volumerasterizeattributes1`
- `pyrosolver_fireball`
- `filecache1`
- `pyrolook_fireball`
- `Null RENDER_Simple_Fireball`

其中：
- `pyrosolver_fireball` 是当前参数调整的主体
- `filecache1` 位于求解器之后，说明后续结果会先缓存
- `pyrolook_fireball` 用于缓存后的体积外观整理
- 末端 `Null RENDER_Simple_Fireball` 是当前这条爆炸结果链的输出占位

配套的两个证据窗口分别补充了“当前调什么”和“调成多少”：
- `Animation Editor` 的通道列表显示当前关注的是 `geo1/pyrosolver_fireball -> Turbulence`
- 右侧 `Fields` 页中，`Turbulence = 2.9375`

因此，这张图作为 `graph` 补证的价值在于：它把参数数值放回到完整的网络上下文里，明确这不是材质节点、也不是后处理合成节点，而是爆炸模拟主链中 `pyrosolver_fireball` 的字段设置，并且该设置会沿 `filecache1 -> pyrolook_fireball -> RENDER_Simple_Fireball` 这条链继续传递到后续缓存与渲染阶段。

### S02 00:04:29

这张补充截图是 `S02 00:04:29` 的参数证据，核心目标是把 `pyrosolver_fireball` 中 `Turbulence` 的手动数值和相关上下文补得更明确。画面里同样可见：
- 中间爆炸主链上的 `pyrosolver_fireball -> filecache1 -> pyrolook_fireball -> Null RENDER_Simple_Fireball`
- 弹出的 `Animation Editor`
- 右侧 `Pyro Solver pyrosolver_fireball` 的 `Fields` 参数页

动画编辑器左侧 `Channel List` 中当前只列出一个有效通道：
- `geo1/pyrosolver_fireball`
  - `Turbulence = 2.9375`

右侧参数面板当前可直接核对到的 `Turbulence` 区域设置为：
- `Noise Type = Analytic Fast Simplex Noise`
- `Turbulence = 2.9375`
- `Swirl Size = 2`
- `Roughness = 0.5`
- `Pulse Length = 0.5`
- `Max Octaves = 3`
- `Seed = 0`
- `Threshold Field = temperature`
- `Threshold Range = 0.1 到 0`

同图还能看到与其配套的上半段场设置：
- `Buoyancy Scale = 0.25`
- `Gravity Acceleration = 9.8`
- `Disturbance = 5`
- `Control Field = speed`
- `Control Range = 1 到 2`

因此，这张图可以作为“参数侧定值补证”来使用：它明确证明 `Turbulence` 在这个时间点不是模糊的滑条大概值，而是被手动设成 `2.9375`，并与当前 `Disturbance / Buoyancy / Gravity` 组合共同作用于爆炸模拟。

### S01 00:04:29

这张补充截图在源文档中被单独标注为 `graph` 证据，因此它的重点是补充说明教程前段查看的是哪一条 Houdini 主链，以及当前正在编辑哪一个求解器参数。中间网络当前能直接识别出：
- `volumerasterizeattributes1`
- `pyrosolver_fireball`
- `filecache1`
- `pyrolook_fireball`
- `Null RENDER_Simple_Fireball`

其中：
- `pyrosolver_fireball` 是当前参数调整的主体
- `filecache1` 位于求解器之后，说明后续结果会先缓存
- `pyrolook_fireball` 用于缓存后的体积外观整理
- 末端 `Null RENDER_Simple_Fireball` 是当前这条爆炸结果链的输出占位

配套的两个证据窗口分别补充了“当前调什么”和“调成多少”：
- `Animation Editor` 的通道列表显示当前关注的是 `geo1/pyrosolver_fireball -> Turbulence`
- 右侧 `Fields` 页中，`Turbulence = 2.9375`

因此，这张图作为 `graph` 补证的价值在于：它把参数数值放回到完整的网络上下文里，明确这不是材质节点、也不是后处理合成节点，而是爆炸模拟主链中 `pyrosolver_fireball` 的字段设置，并且该设置会沿 `filecache1 -> pyrolook_fireball -> RENDER_Simple_Fireball` 这条链继续传递到后续缓存与渲染阶段。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。

