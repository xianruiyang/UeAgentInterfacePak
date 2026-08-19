# 26-2 Sequencer设置和模板缓冲区表现制作

# 26-2 Sequencer设置和模板缓冲区表现制作

## 关键术语

- `Color`、`Alpha`、`Material`、`Multiply`、`Sequencer`、`材质`、`粒子`、`发射器`、`网格`、`速度`、`Niagara`、`Emitter`、`Particle`、`Spawn Rate`、`Spawn`、`Lifetime`、`Niagara System`、`Initialize Particle`

## 分段知识

### 00:00:00-00:03:03 材质、粒子、网格

- 本段定位：材质、粒子、网格。
- 知识点：使用customdex作为路径 允许自定义深度写 这里是说话customdeep 所以这样就变成这样了 网格即使渲染不出也没关系 需要关闭主路径和死亡路径。
- 知识点：是透明的但存在 但是这样看起来是透明的 接下来这里给粒子用的材质 命名为space boiler 现在后续会在余法节点中使用custom。
- 知识点：stencil 将这个颜色传过来使用 这也会改成无光的半透明 取出一个mask component mask节点 因为是用作不透明度的通道。
- 知识点：叫R通道 然后暂时用蓝色颜色 需要把它应用到这里 这种话现在有点卡顿 刚才如果说屏幕填满了 到这里 现在是通过放置在这个角色前面的。
- 知识点：才行 现在这个粒子正在被画 我认为正在描绘使用这个材料的演员是正确的 所以需要用缓冲区确认一下 所以这个计划本身是要画模板缓冲器。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`粒子`、`颜色`、`透明度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Material `M_Stencil_01` Custom Depth Writes 核对截图
> - 组成部分: Material Preview + Details + Material Graph 主节点
> - 所属: Material `M_Stencil_01`
> - 目的: 核对透明平面材质是否允许写入 Custom Depth，并说明当前截图中该开关尚未启用。
>
> 可见设置:
> | 区域 | 字段 | 值/状态 |
> |---|---|---|
> | Material 标签 | 打开资产 | `M_Stencil_01*` |
> | Content Browser | 选中资源 | `M_Stencil_0...`，类型 `Material` |
> | Material Graph | 主节点 | `M_Stencil_01`，可见 `Emissive Color`、`Opacity`、`World Position Offset`、`Ambient Occlusion` 等输入 |
> | Graph | 节点状态 | 未见额外节点或连线 |
> | Details | 搜索词 | `depth` |
> | Translucency | `Output Depth and Velocity` | 未勾选 |
> | Advanced | `Disable Depth Test` | 未勾选 |
> | Advanced | `Allow Custom Depth Writes` | 未勾选，鼠标悬停提示 `False` |
> | Refraction | `Refraction Depth Bias` | `0.0` |
> | Preview | 结果 | 黑色矩形平面预览 |
> | 字幕 | 文本 | “允许自定义深度写，这里是说画custom-depth。” |
>
> 联动关系: 该图处于讲解/核对 Custom Depth 写入的步骤，当前 `Allow Custom Depth Writes` 仍为未勾选状态；后续需要启用它，使透明材质应用到平面时也能写入 Custom Depth。
> 验证方式: 在 `M_Stencil_01` Details 中搜索 `depth`，核对 `Allow Custom Depth Writes` 的勾选状态和悬停提示。
> 图表转写（UE-GTXT v4）
> - 类型: Material Graph `M_Space_01` 初始节点截图
> - 组成部分: Material Preview + Details + Material Graph
> - 所属: Material `M_Space_01`
> - 目的: 新建用于空间/遮罩的材质，并开始从 `CustomStencil` 读取模板缓冲。
>
> 可见设置与节点:
> | 区域/节点 | 字段/Pin | 值/状态 |
> |---|---|---|
> | Material 标签 | 打开资产 | `M_Space_01*` |
> | Material | `Material Domain` | `Surface` |
> | Material | `Blend Mode` | `Translucent` |
> | Material | `Shading Model` | `Unlit` |
> | Preview | 结果 | 黑色圆形预览 |
> | N01 | `SceneTexture:CustomStencil` | 输出 `Color`、`Size`、`InvSize`；鼠标从 `Color` 拉线准备放置新节点 |
> | N02 | `M_Space_01` 主材质节点 | 可见 `Emissive Color`、`Opacity`、`World Position Offset` 等输入 |
> | 字幕 | 文本 | “现在后续会在余法节点中使用custom” |
>
> 联动关系: `M_Space_01` 设置为透明无光材质，并从 `SceneTexture:CustomStencil.Color` 拉出数据流，后续会用模板缓冲值控制平面/粒子空间显示。
> 验证方式: 打开 `M_Space_01`，核对材质属性为 `Surface / Translucent / Unlit`，并确认图中存在 `SceneTexture:CustomStencil` 节点。
> 图表转写（UE-GTXT v4）
> - 类型: Level Viewport `Custom Stencil` 验证截图
> - 组成部分: Content Browser + Level Viewport + View Mode 菜单 + Outliner + Plane Details + Niagara 窗口边缘
> - 所属: 关卡 `08_Constellation`，对象 `Plane`
> - 目的: 在 `Custom Stencil` 视图中确认平面区域正在写入模板值 `001`。
>
> 可见设置:
> | 区域 | 字段 | 值/状态 |
> |---|---|---|
> | Content Browser | 可见资源 | `M_Space_01`、`M_Stencil_01` |
> | Viewport | 当前视图标签 | `Custom Stencil` |
> | View Mode 菜单 | 可见选项 | `Lit`、`Unlit`、`Wireframe`、`Detail Lighting`、`Lighting Only`、`Reflections`、`Player Collision`、`Visibility Collision`、`Buffer Visualization` 等 |
> | Viewport | 平面显示 | 大块黄色区域，重复标注 `001` |
> | Viewport | 选中对象 | `Plane`，黄色边框；旋转 gizmo 可见 |
> | Outliner | 选中对象 | `Plane` |
> | Details | 搜索词 | `render` |
> | Details | 可见字段 | `Overlay Material`、`Visible in Reflection Captures`、`Visible in Real Time Sky Capt...`、`Visible in Ray Tracing`、`Render in Main Pass` 等 |
> | Niagara 窗口 | `Space_01` | `Empty` 选中，显示 `1 Particles` |
> | 字幕 | 文本 | “这个计划作为口罩用途感觉像窗口一样。” |
>
> 联动关系: `Custom Stencil` 视图把平面区域显示为模板值 `001`，说明前面的 `Plane`/材质设置可作为遮罩窗口参与后续 Niagara/材质混合；当前截图不记录未显示的其他 Stencil 通道。
> 验证方式: 将视口 View Mode 切换到 `Custom Stencil`，确认平面区域以黄色显示并重复标注 `001`。

### 00:03:07-00:06:05 Color、Alpha、Material

- 本段定位：Color、Alpha、Material。
- 知识点：在这个材料的情况下 下次时间完成一下会很好 该结构本身先放着 只保存几颗 而且particle这里是可以成为星星的。
- 知识点：particle先设计好比较好 这个材料并不复杂 这也就是空间材料一个复制 然后 需要使用 这个是star需要删掉 那么再做一个发射器。
- 知识点：后续会以视力的方式来看一次实际应用 星座是非常多的 那应该出来 所以用gp 需要使用它 现在self换成infinite 大约15秒 还有rate的话会多生成一些。
- 知识点：毕竟需要填充更多的空间 然后把创建的materials连接一下 再从这个材料大致设计一下 虽然是很简单的材料 纹理中使用圆形的方形纹理。
- 知识点：用这个纹理提取一个particle color 成法处理后 删掉 计算alpha 并在发光部分使用这个。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Particle`、`Color`、`Alpha`、`Material`、`纹理`、`发射器`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Material Graph `M_Space_01` 蓝色遮罩材质截图
> - 组成部分: Material Preview + Material Graph + Details
> - 所属: Material `M_Space_01`
> - 目的: 用蓝色向量作为发光颜色，并用 `CustomStencil` 的 R 通道控制透明度。
>
> 节点与连线:
> | ID | 节点 | 关键 Pin/值 | 角色 |
> |---|---|---|---|
> | N01 | Constant3Vector | `R=0.0, G=0.0, B=1.0`，蓝色 | 提供材质显示颜色 |
> | N02 | `SceneTexture:CustomStencil` | 输出 `Color`、`Size`、`InvSize` | 读取模板缓冲 |
> | N03 | `Mask(R)` | 输入来自 N02 `Color` | 只取 R 通道作为遮罩值 |
> | N04 | `M_Space_01` 主材质节点 | `Emissive Color`、`Opacity` | 输出透明无光材质 |
>
> 连线覆盖检查:
> | From | To |
> |---|---|
> | `N01.RGB` -> `N04.Emissive Color` |
> | `N02.Color` -> `N03.Input` |
> | `N03.Output` -> `N04.Opacity` |
>
> 联动关系: 蓝色向量负责可见发光色，`CustomStencil` 的 R 通道负责透明度；因此材质只会在模板缓冲命中的区域显示蓝色。
> 验证方式: 在 `M_Space_01` 中核对 `SceneTexture:CustomStencil -> Mask(R) -> Opacity`，并确认蓝色向量连接到 `Emissive Color`。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara System `Space_01` 双发射器结构截图
> - 组成部分: Niagara Preview + System Overview + Details + Timeline
> - 所属: Niagara System `Space_01`
> - 目的: 复制/新增发射器，准备将一个发射器改为持续生命周期，另一个用于一次性 Burst 或基础星点结构。
>
> Niagara 结构:
> | 区域 | 字段 | 值/状态 |
> |---|---|---|
> | System Overview | 发射器 | `Empty001`、`Empty` 两列可见 |
> | `Empty001` | Sim Target | `GPU` 标记可见 |
> | `Empty001` | 模块 | `Emitter State`、`Initialize Particle`、`Particle State`、`Sprite Renderer` |
> | `Empty` | Sim Target | `CPU` 标记可见 |
> | `Empty` | `Emitter State` | `Self`、`Once` 可见 |
> | `Empty` | `Emitter Spawn` | `Spawn Burst Instantaneous` 可见 |
> | `Empty` | `Particle Spawn` | `Initialize Particle`、`Camera Offset` |
> | `Empty` | `Particle Update` | `Particle State`，带无限符号 |
> | Details | 当前选择 | `Empty001` |
> | Details | `Emitter State > Life Cycle Mode` | `System` |
> | Details | `Scalability Mode` | `System` |
> | Timeline | 轨道 | `Empty`、`Empty001` 两条轨道 |
> | Timeline | 当前时间 | 约 `7.18`，帧率 `240 fps` |
> | 字幕 | 文本 | “现在 self 换成 infinite 使用” |
>
> 联动关系: `Space_01` 从单发射器扩展为双发射器结构；`Empty001` 以系统生命周期运行，`Empty` 仍保留一次性 Burst 结构，为后续星点/空间粒子填充提供基础。
> 验证方式: 打开 `Space_01`，确认 System Overview 中有 `Empty001` 与 `Empty`，并核对 `Empty001` 的 `Life Cycle Mode=System`。
> 图表转写（UE-GTXT v4）
> - 类型: Material Graph `M_Star_01` 星点粒子材质截图
> - 组成部分: Content Browser 纹理列表 + Material Preview + Material Graph
> - 所属: Material `M_Star_01`
> - 目的: 用圆形衰减贴图乘以 `Particle Color` 形成星点发光，并继续用 `CustomStencil` R 通道控制透明度。
>
> 节点与资源:
> | ID/区域 | 节点/资源 | 关键 Pin/值 | 角色 |
> |---|---|---|---|
> | Content Browser | `falloff_circle` | 类型 `Texture`，被选中 | 星点圆形衰减贴图 |
> | Content Browser | 其他可见纹理 | `D_Ocean...`、`dust_thick...`、`fx_liquid...`、`fxEtn_thunder...` | 纹理目录上下文 |
> | N01 | Texture Sample | 左侧边缘可见，输出 `RGB/R/G/B/A/RGBA` | 读取圆形衰减贴图 |
> | N02 | `Particle Color` | 输出 `RGB`、`R`、`G`、`B`、`A`、`RGBA` | 接收 Niagara 粒子颜色 |
> | N03 | `Multiply(1)` | `B=1.0` 可见；输入来自贴图/Particle Color 分支 | 组合贴图与粒子颜色 |
> | N04 | `SceneTexture:CustomStencil` | 输出 `Color`、`Size`、`InvSize` | 读取模板缓冲 |
> | N05 | `Mask(R)` | 输入来自 N04 `Color` | 提取模板 R 通道 |
> | N06 | `M_Star_01` 主材质节点 | `Emissive Color`、`Opacity` | 输出星点材质 |
>
> 连线覆盖检查:
> | From | To |
> |---|---|
> | Texture Sample 输出 -> `Multiply(1).A` |
> | `Particle Color.RGB` -> `Multiply(1).B` |
> | `Multiply(1).Output` -> `M_Star_01.Emissive Color` |
> | `SceneTexture:CustomStencil.Color` -> `Mask(R).Input` |
> | `Mask(R).Output` -> `M_Star_01.Opacity` |
>
> 联动关系: 星点亮度/颜色由贴图衰减和 Niagara `Particle Color` 相乘得到，透明度仍由模板缓冲 R 通道控制，因此星点只在 Custom Stencil 命中的遮罩区域内显示。
> 验证方式: 在 `M_Star_01` 中核对 `falloff_circle` 贴图分支与 `Particle Color` 进入 `Multiply`，并确认 `CustomStencil -> Mask(R)` 接到 `Opacity`。

### 00:06:10-00:09:05 Color、速度、颜色

- 本段定位：Color、速度、颜色。
- 知识点：最后将这个stancel color和 进行成法处理 使用random uniform制作 大小设置为2到2.5 需要创建一个形状位置 形状位置将使用盒子。
- 知识点：空间设置为30000 1000 3000 希望能够填充这个区域 所以现在这里 这里现在少了 所以不好看 先放大一下再看看 然后 然后我们先提高。
- 知识点：虽然有些挤疤 现在这个空间本身 比前面更偏向后面显示 我们先把这个关掉 看一下particle也一样。
- 知识点：在这里的窗口中 这样显示 当画面有转动时 这个particle位置确实在前面 因为这个plane只是post pass 所以存在于这里的白色。
- 知识点：颜色值与成以后 只在这个空间显示 是的 没错 那我再大致整理一下 慢慢创造出那种 飘荡的星星的感觉 就会不错 加速度按cc。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Particle`、`Color`、`速度`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Material Graph `M_Star_01` 保存与乘法链截图
> - 组成部分: Content Browser 纹理列表 + Material Graph + Details + 保存进度弹窗
> - 所属: Material `M_Star_01`
> - 目的: 保存星点材质，并确认贴图、`Particle Color`、`CustomStencil` 遮罩经过多级乘法后输出到材质主节点。
>
> 可见节点与状态:
> | 区域/节点 | 字段/Pin | 值/状态 |
> |---|---|---|
> | Content Browser | 选中资源 | `falloff_circle`，类型 `Texture` |
> | N01 | `Particle Color` | 输出 `RGB`、`R`、`G`、`B`、`A`、`RGBA` |
> | N02 | `SceneTexture:CustomStencil` | 输出 `Color`、`Size`、`InvSize` |
> | N03 | `Mask(R)` | 输入来自 N02 `Color` |
> | N04-N06 | `Multiply` 节点 | 多级乘法链，输入来自贴图、`Particle Color` 和模板遮罩分支 |
> | N07 | `M_Star_01` 主材质节点 | `Emissive Color`、`Opacity` 接入可见 |
> | Details | Material | `Material Domain=Surface`、`Blend Mode=Translucent`、`Shading Model=Unlit` |
> | 保存弹窗 | 文本 | `Saving asset /Game/Tutorial/Material/08/M_Star_01` |
> | 保存弹窗 | 进度 | `67%` |
> | 字幕 | 文本 | “进行乘法处理。” |
>
> 联动关系: `M_Star_01` 使用 `Particle Color` 与贴图/遮罩分支相乘，保存过程中可见最终输出接向 `Emissive Color` 和 `Opacity`；这是后续 Niagara 星点发射器的材质基础。
> 验证方式: 打开 `M_Star_01`，核对材质属性为 `Surface / Translucent / Unlit`，并确认乘法链输出接主节点。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara `Sprite Renderer` 材质接入截图
> - 组成部分: Niagara Preview + System Overview + Details + Timeline
> - 所属: Niagara System `Space_01`
> - 目的: 为发射器的 Sprite Renderer 指定空间材质，并提高渲染相关设置的优先级。
>
> Niagara 设置:
> | 区域 | 字段 | 值/状态 |
> |---|---|---|
> | System Overview | 发射器 | `Empty001`、`Empty` |
> | `Empty001` | 状态 | `Emitter State Self Infinite`，含 `Spawn Rate`、`Initialize Particle`、`Shape Location Box / Plane`、`Particle State`、`Sprite Renderer` |
> | `Empty` | 状态 | `Emitter State Self Once`，含 `Spawn Burst Instantaneous`、`Camera Offset`、`Sprite Renderer` |
> | Details | 当前选择 | `Empty`，显示 `1 Particles` |
> | Details > Sprite Renderer | Material | `M_Space_01` |
> | Details > Sprite Renderer | Material User Param | `None` |
> | Details > Sprite Renderer | Source Mode | `Particles` |
> | Details > Sprite Renderer | Alignment | `Automatic` |
> | Details > Sprite Renderer | Facing Mode | `Automatic` |
> | Details > Sprite Renderer | Default Pivot in UV Space | `0.5 / 0.5` |
> | Sorting | Sort Mode | `None` |
> | Timeline | 当前时间 | 约 `3.49`，`240 fps`，轨道 `Empty` 与 `Empty001` 可见 |
> | 字幕 | 文本 | “然后我们先提高渲染优先级吧” |
>
> 联动关系: Sprite Renderer 的 Material 指向 `M_Space_01`，意味着该发射器的粒子会使用前面基于 Custom Stencil 的空间材质；发射器结构中 `Empty001` 负责持续发射，`Empty` 保留一次性发射结构。
> 验证方式: 在 `Space_01` 中选中 `Sprite Renderer`，核对 `Material=M_Space_01`、`Source Mode=Particles` 和 `Pivot=0.5/0.5`。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara `Shape Location` Box 参数截图
> - 组成部分: Niagara System Overview + Details + Timeline
> - 所属: Niagara System `Space_01`，发射器 `Empty001`
> - 目的: 通过 Box/Plane 形状位置把星点分布到大范围空间区域。
>
> Niagara 设置:
> | 区域 | 字段 | 值/状态 |
> |---|---|---|
> | Details | 当前选择 | `Empty001`，`7,450 Particles` |
> | System Overview | `Empty001` | 启用；`Emitter State Self Infinite`、`Spawn Rate`、`Initialize Particle`、`Shape Location Box / Plane` |
> | System Overview | `Empty` | 灰色 Disabled 状态 |
> | Shape Location | Shape Primitive | `Box / Plane` |
> | Shape Location | Box / Plane Mode | `Box` |
> | Shape Location | Box Size | `3000.0 / 1000.0 / 3000.0` |
> | Shape Location | Box Midpoint | `0.5 / 0.5 / 0.5` |
> | Distribution | Surface Only Band | `0.0` |
> | Transform | Transform Order | `Scale / Rotate / Offset` |
> | Transform | Scale Mode | `Default` |
> | Transform | Non Uniform Scale | `1.0 / 1.0 / 1.0` |
> | Transform | Rotation Mode | `Default` |
> | Transform | Rotation Coordinate | `Local` |
> | Transform | Offset Mode | `None` |
> | Transform | Shape Origin | `STACKCONTEXT Position` |
> | Timeline | 当前时间 | 约 `9.01`，`240 fps` |
> | 字幕 | 文本 | “慢慢创造出飘荡的星星的感觉会不错。” |
>
> 联动关系: `Shape Location` 使用大尺寸 Box 生成粒子位置，`Empty001` 持续发射以填充空间；`Empty` 被禁用，避免一次性发射器干扰当前观察。
> 验证方式: 在 `Empty001` 中选中 `Shape Location`，核对 `Shape Primitive=Box / Plane`、`Box Mode=Box` 和 `Box Size=3000/1000/3000`。

### 00:09:20-00:12:09 Alpha、Multiply、粒子

- 本段定位：Alpha、Multiply、粒子。
- 知识点：拿一个缩放颜色 现在也得换一下颜色 总是通过multiply vector by float 来控制我们很多 颜色适当是蓝色。
- 知识点：但会用些绿色 那种混合的颜色 这种感觉的某种向前移动 现在正在来 为了给人置身于空间的感觉 然后将alpha改为propeller曲线。
- 知识点：调用这个预设曲线 然后再制作一个0.1变为10.91 现在太无聊了 所以当这个动作 将让色彩变化的随机性 快门速度大约是ISO200。
- 知识点：现在相机非常靠近这里 所以看起来速度感很快 需要再加一个旋转感觉的 vortex这样使用 所以会非常慢地旋转 虽然向前移动 但慢慢旋转 当粒子首次生成时。
- 知识点：因为填充道这样需要时间 所以会用时间的臂膀 然后在5秒后就开始 这样准备星座基本就完成了 表达宇宙的素材 一起完成会比较好 我给它取名为空间 在进行这个视力时。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Multiply`、`粒子`、`速度`、`颜色`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Niagara `Scale Color` 初始设置截图
> - 组成部分: Niagara Preview + System Overview + Details + Timeline
> - 所属: Niagara System `Space_01`，发射器 `Empty001`
> - 目的: 在星点发射器中加入 `Scale Color`，为后续颜色/Alpha 曲线调整提供基础。
>
> Niagara 设置:
> | 区域 | 字段 | 值/状态 |
> |---|---|---|
> | Details | 当前选择 | `Empty001`，提示 `No running preview...` |
> | System Overview | `Empty001` 模块 | `Emitter State Self Infinite`、`Spawn Rate`、`Initialize Particle`、`Shape Location Box / Plane`、`Add Velocity Linear`、`Particle State`、`Solve Forces and Velocity`、`Scale Color`、`Sprite Renderer` |
> | System Overview | `Empty` | 灰色 Disabled 状态 |
> | Scale Color | Scale Mode | `RGB and Alpha Separately` |
> | Scale Color | Scale RGB | `1.0 / 1.0 / 1.0`，启用勾选 |
> | Scale Color | Scale Alpha | `1.0`，启用勾选 |
> | Timeline | 当前时间 | 约 `4.98`，`240 fps` |
>
> 联动关系: 当前 `Scale Color` 仍保持默认 `RGB=1/1/1`、`Alpha=1`，它不会改变颜色/透明度，但为下一步添加随机色彩、Alpha 曲线或亮度缩放提供插入点。
> 验证方式: 在 `Empty001` 中选中 `Scale Color`，确认 `Scale Mode=RGB and Alpha Separately`，并核对 RGB 与 Alpha 均为 1。
> 图表转写（UE-GTXT v4）
> - 类型: Level Viewport 星空预览 + Plane Transform 截图
> - 组成部分: Content Browser + Level Viewport + Outliner + Details + Niagara 窗口边缘
> - 所属: 关卡 `08_Constellation`，对象 `Plane`，Niagara System `Space_01`
> - 目的: 验证星点粒子在放大的平面/遮罩区域内形成空间背景，并观察当前速度感。
>
> 可见设置:
> | 区域 | 字段 | 值/状态 |
> |---|---|---|
> | Content Browser | 选中纹理 | `falloff_circle` |
> | Level Viewport | 选中对象 | 大型矩形 `Plane`，黄色边框 |
> | Level Viewport | 结果 | 平面区域出现大量白色星点，局部有青绿色发光点；部分粒子形成短线状拖影 |
> | Level Viewport | 场景 | 角色位于平面前方/中央附近，地面网格可见 |
> | Outliner | 选中对象 | `Plane` |
> | Details | 对象 | `Plane (Instance)` |
> | Transform | Location | `0.0 / 130.0 / 20.0` |
> | Transform | Rotation | `89.999 / 0.0 / 0.0` |
> | Transform | Scale | `10.0 / 10.0 / 10.0` |
> | Static Mesh | Static Mesh | `Plane` |
> | Niagara 窗口 | `Empty001` | `2,300 Particles` |
> | 字幕 | 文本 | “所以看起来速度感很快。” |
>
> 联动关系: 放大的 `Plane` 与 `Space_01` 粒子结合后形成可见星空背景；粒子拖影和密度说明当前运动/分布已经生效，但速度感偏快，需要后续通过速度、Alpha 或力场继续调整。
> 验证方式: 在关卡中选中 `Plane`，核对 Scale 为 `10/10/10`，并观察星点是否只在平面区域内形成密集背景。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara System Warmup + 运动模块截图
> - 组成部分: Niagara Preview + System Overview + Parameters + Details + Timeline
> - 所属: Niagara System `Space_01`
> - 目的: 通过 Curl/Vortex 力和系统 Warmup，让星点在播放开始时已经填充并带有缓慢旋转/漂浮感。
>
> Niagara 设置:
> | 区域 | 字段 | 值/状态 |
> |---|---|---|
> | System Overview | `Empty001` 模块 | `Emitter State Self Infinite`、`Spawn Rate`、`Initialize Particle`、`Shape Location Box / Plane`、`Add Velocity Linear`、`Particle State`、`Curl Noise Force`、`Vortex Force`、`Solve Forces and Velocity`、`Scale Color`、`Sprite Renderer` |
> | System Overview | `Empty` | `Emitter State Self Once`、`Spawn Burst Instantaneous`、`Camera Offset`、`Particle State`、`Sprite Renderer` |
> | Details | 当前对象 | `Space_01` 系统属性 |
> | System | Effect Type | `None` |
> | System | Fixed Tick Delta | `0.01667 s` 可见 |
> | Warmup | Warmup Time | `4.933333 s` |
> | Warmup | Warmup Tick Count | `74` |
> | Warmup | Warmup Tick Delta | `0.066667 s` |
> | Performance | Require Current Frame Data | 已勾选 |
> | Performance | Auto Deactivate | 已勾选 |
> | Timeline | 当前时间 | 约 `0.28`，`240 fps` |
> | 字幕 | 文本 | “一起完成会比较好。” |
>
> 联动关系: `Curl Noise Force` 和 `Vortex Force` 负责让星点有噪声漂动和旋转感；Warmup 让系统在开始播放时提前模拟约 4.93 秒，减少刚生成时空间未填满的问题。
> 验证方式: 在 `Space_01` 系统属性中核对 Warmup 三个字段，并确认 `Empty001` 的 Particle Update 栈包含 `Curl Noise Force`、`Vortex Force` 和 `Solve Forces and Velocity`。

### 00:12:20-00:13:39 材质、粒子

- 本段定位：材质、粒子。
- 知识点：不太常用什么命名之类的 现在如果个人工作时用命名之类的 养成习惯会比较好 现在有 现在有点精神不集中 有时候会乱七 我整体会保存一次 那么这个静态缓冲区的。
- 知识点：结构简单设置就好了 现在这里继续 制作视觉 这次的内容到此为止会比较好 下次会用这个角色消失了溶解 我们一直使用的方法来一起应用 角色消失并出现透明效果的材质。
- 知识点：运动的进行 以及宇宙材质的表现 对粒子的完成 以及计划的序列设置 需要进行这些内容 那么这次就跟着我辛苦了 谢谢。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`粒子`、`序列`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Level Viewport 空间材质/粒子最终预览截图
> - 组成部分: Content Browser + Level Viewport + Outliner + Details + Niagara 窗口边缘
> - 所属: 关卡 `08_Constellation`，对象 `Plane`，Niagara System `Space_01`
> - 目的: 观察空间粒子与蓝色平面遮罩材质叠加后的最终基础效果。
>
> 可见设置:
> | 区域 | 字段 | 值/状态 |
> |---|---|---|
> | Content Browser | 选中资源 | `falloff_circle`，类型 `Texture` |
> | Level Viewport | 选中对象 | 大型矩形 `Plane`，黄色选择边框 |
> | Level Viewport | 平面显示 | 平面区域为均匀蓝色，覆盖角色后方的大面积区域 |
> | Level Viewport | 粒子显示 | 地面/平面前方可见白色星点和青绿色发光点 |
> | Outliner | 选中对象 | `Plane` |
> | Details | 对象 | `Plane (Instance)` |
> | Transform | Location | `0.0 / 130.0 / 20.0` |
> | Transform | Rotation | `89.999 / 0.0 / 0.0` |
> | Transform | Scale | `10.0 / 10.0 / 10.0` |
> | Static Mesh | Static Mesh | `Plane` |
> | 字幕 | 文本 | “现在如果个人工作时用命名之类的” |
>
> 联动关系: 蓝色平面来自遮罩/空间材质，白色和青绿色点来自 `Space_01` 粒子；该图用于确认空间材质、Plane 缩放和粒子系统已在关卡中共同生效。
> 验证方式: 在关卡中选中 `Plane`，核对 Transform 为 `0/130/20`、`89.999/0/0`、`10/10/10`，并观察蓝色平面与星点粒子同时可见。
> 图表转写（UE-GTXT v4）
> - 类型: Level Viewport + Sequencer 边缘预览截图
> - 组成部分: Content Browser + Level Viewport + Outliner + Details + Sequencer
> - 所属: 关卡 `08_Constellation`
> - 目的: 继续确认当前空间材质、粒子和 Sequencer 播放位置的组合状态。
>
> 可见设置:
> | 区域 | 字段 | 值/状态 |
> |---|---|---|
> | Content Browser | 选中资源 | `falloff_circle` |
> | Level Viewport | 平面显示 | 蓝色矩形 `Plane`，黄色边框，位于角色后方 |
> | Level Viewport | 粒子显示 | 平面前方和地面附近分布白色星点，少量青绿色发光点 |
> | Outliner | 选中对象 | `Plane` |
> | Details | 对象 | `Plane (Instance)` |
> | Transform | Location | `0.0 / 130.0 / 20.0` |
> | Transform | Rotation | `89.999 / 0.0 / 0.0` |
> | Transform | Scale | `10.0 / 10.0 / 10.0` |
> | Static Mesh | Static Mesh | `Plane` |
> | Materials | Element 0 | `M_Stencil_01` 可见 |
> | Sequencer | 当前帧 | 约 `0021`，显示 `22 of 220` |
> | 字幕 | 文本 | “现在这里继续” |
>
> 联动关系: `Plane` 保持 `M_Stencil_01` 与 `Scale=10`，Sequencer 停在早期帧位，空间粒子在该视角下仍可见；本图用于确认序列播放点与关卡效果对齐。
> 验证方式: 核对 `Plane` 的材质槽为 `M_Stencil_01`，并确认 Sequencer 当前帧约为 `0021` 时仍能看到星点和蓝色平面。
> 图表转写（UE-GTXT v4）
> - 类型: Level Viewport + 材质编辑器边缘收尾截图
> - 组成部分: Content Browser + Level Viewport + Outliner + Details + `M_Stencil_01` 材质窗口边缘
> - 所属: 关卡 `08_Constellation`，Material `M_Stencil_01`
> - 目的: 记录本段完成时的空间粒子、Plane 材质和后续 Sequencer 讲解入口。
>
> 可见设置:
> | 区域 | 字段 | 值/状态 |
> |---|---|---|
> | Level Viewport | 平面显示 | 蓝色矩形 `Plane`，黄色边框，覆盖角色后方 |
> | Level Viewport | 粒子显示 | 白色星点分布在平面前方/地面附近，多个青绿色发光点可见 |
> | Outliner | 选中对象 | `Plane` |
> | Details | 对象 | `Plane (Instance)` |
> | Transform | Location | `0.0 / 130.0 / 20.0` |
> | Transform | Rotation | `89.999 / 0.0 / 0.0` |
> | Transform | Scale | `10.0 / 10.0 / 10.0` |
> | Static Mesh | Static Mesh | `Plane` |
> | 下方材质窗口 | 标签 | `M_Stencil_01`，鼠标悬停提示 `Asset: M_Stencil_01` |
> | 字幕 | 文本 | “对粒子的完成；以及计划的序列设置。” |
>
> 联动关系: 本图是 p42 收尾状态，说明空间粒子效果和 Plane 材质已经完成到可用于后续 Sequencer 设置的程度；下方 `M_Stencil_01` 窗口仍作为遮罩材质相关上下文存在。
> 验证方式: 在关卡中确认 `Plane`、星点和 `M_Stencil_01` 材质窗口同时可见，并核对 Transform 仍为 `10/10/10` 缩放。

## 补充视觉证据

### S01 00:01:36

> 图表转写（UE-GTXT v4）
> - 类型: Material Graph `M_Space_01` Mask Component 补充截图
> - 组成部分: Material Preview + Material Graph + Details
> - 所属: Material `M_Space_01`
> - 目的: 补充说明从 `CustomStencil` 取出 Mask Component 时勾选了 R/G 通道。
>
> 节点与设置:
> | 区域/节点 | 字段/Pin | 值/状态 |
> |---|---|---|
> | Material 标签 | 打开资产 | `M_Space_01*` |
> | Preview | 结果 | 黑色圆形预览 |
> | N01 | `SceneTexture:CustomStencil` | 输出 `Color`、`Size`、`InvSize` |
> | N02 | `Mask(RG)` | 输入来自 N01 `Color`，输出单一结果 |
> | N03 | `M_Space_01` 主材质节点 | `Emissive Color`、`Opacity`、`World Position Offset` 等输入可见 |
> | Details | `Material Expression Component Mask` | `R` 勾选、`G` 勾选、`B` 未勾选、`A` 未勾选 |
> | 字幕 | 文本 | “取出一个Mask Component Mask节点” |
>
> 连线覆盖检查:
> | From | To |
> |---|---|
> | `SceneTexture:CustomStencil.Color` -> `Mask(RG).Input` |
>
> 联动关系: `Mask(RG)` 将 `CustomStencil` 的 R/G 分量取出，作为后续材质遮罩数据来源；本补充图只显示到 Mask 节点，未显示其最终输出端连接到主材质哪个 Pin。
> 验证方式: 选中 `Mask(RG)`，核对 Details 中 R/G 勾选、B/A 未勾选，并确认输入来自 `SceneTexture:CustomStencil.Color`。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。

