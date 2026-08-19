# 07 Character Aura VFX

# 07 Character Aura VFX

## 关键术语

- `Renderer`、`Mesh Renderer`、`Material`、`UV`、`Mesh`、`粒子`、`发射器`、`速度`、`透明度`、`Niagara`、`Emitter`、`Spawn Rate`、`Spawn`、`Lifetime`、`材质`、`系统`、`Niagara System`、`Particle`

## 分段知识

### 00:00:04-00:05:02 粒子、发射器、速度

- 本段定位：粒子、发射器、速度。
- 知识点：我们先用锁面计算器制作第一个发射器。
- 知识点：我们只需要把它们的颜色调整。
- 知识点：如果我们把影响分成部分, 需要有一个魔法和幻觉的圈子, 这是我们的第一发射器。
- 知识点：接下来是线条, 第三个,需要有小的粒子, 第四个,需要有一个中间的光, 可以加上,可以增加了影响。
- 知识点：可以按F,以便它们中间的粒子。
- 知识点：我们有一个有趣的组织, 叫做,调整和调整粒子。
- 知识点：可以设定它们的速度是最高, 可以设定它们的最低和最高的伸展在X和Y。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`粒子`、`发射器`、`速度`、`颜色`。

**关键画面：**

这是角色光环教程的起始关卡画面，主要用于确认当前工作区中的 Niagara 资源位置和目标系统名称。

- 关卡场景：
  - 视口中央站立的是角色 `Gideon_Inquisitor`。
  - 角色背后已经能看到一圈圆环式 Aura 轮廓，说明本教程围绕角色背后的光环系统展开。
- 内容浏览器定位：
  - 当前路径位于 `Content > VFX_Library > Niagara`
  - 搜索框中正在筛选 `Niagara`
  - 当前可见 2 个 Niagara System 资源：
    - `NS_Fire`
    - `NS_ItemAura_01`
- 教程语义：
  - 本图还未进入具体模块编辑，更像是开场确认资源目录和将要制作/讲解的目标系统。
  - 结合文档小节“粒子、发射器、速度”，可理解为接下来会从这个角色 Aura 系统拆解出多个发射器层。
- 本图结论：
  - 本段教程使用 `VFX_Library/Niagara` 下的 `NS_ItemAura_01` 作为主要角色 Aura 系统，`NS_Fire` 只是同目录中的另一份对照资源。
这是 `NS_MagicAura_01` 的单发射器总览画面，当前只保留一个 `Fountain` 发射器，用来搭建角色 Aura 的第一层基础喷发粒子。

- 当前系统与发射器：
  - 系统名：`NS_MagicAura_01`
  - 发射器名：`Fountain`
  - 当前粒子数：`142 Particles`
- `Fountain` 可见模块结构：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Shape Location Sphere`
  - `Add Velocity in Cone`
  - `Particle State`
  - `Gravity Force`
  - `Drag`
  - `Scale Color`
  - `Solve Forces and Velocity`
  - `Sprite Renderer`
- 右侧 `Emitter Properties` 已确认设置：
  - `Interpolated Spawning = True`
  - `Sim Target = CPUSim`
  - `Calculate Bounds Mode = Dynamic`
- 右侧 `Emitter State` 已确认设置：
  - `Life Cycle Mode = System`
  - `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
  - `Loop Behavior = Infinite`
  - `Loop Duration = 2.0`
  - `Scalability Mode = System`
- 右侧 `Spawn Rate` 已确认设置：
  - `SpawnRate = 90.0`
- 右侧 `Initialize Particle` 当前可见部分：
  - `Lifetime Mode = Random`
  - `Lifetime Min = 1.4`
  - `Lifetime Max = 1.75`
- 预览结果：
  - 左侧预览可见一小簇白色粒子从中心区域向上/向外散开，符合 `Sphere + Cone Velocity` 组合形成的基础喷发层。
- 本图结论：
  - 角色 Aura 的第一层是一个连续循环的 `Fountain` 精灵喷发器：以 `90` 的 Spawn Rate 不断生成寿命约 `1.4-1.75` 秒的粒子，再通过后续速度、重力和拖拽模块形成向外散开的动势。
这是 `NS_MagicAura_01` 的 `Fountain` 发射器继续调试画面，作者新增了 `Scale Sprite Size by Speed` 模块，用速度去驱动精灵尺寸拉伸，从而让高速粒子更细长、更像能量喷流。

- `Fountain` 当前模块结构：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Shape Location Sphere`
  - `Add Velocity in Cone`
  - `Particle State`
  - `Gravity Force`
  - `Drag`
  - `Scale Color`
  - `Solve Forces and Velocity`
  - `Scale Sprite Size by Speed`
  - `Sprite Renderer`
- 右侧 `Scale Sprite Size by Speed` 已确认设置：
  - `Min Scale Factor = (0.1, 10.0)`
  - `Max Scale Factor = (0.2, 1.0)`
  - `Velocity Threshold = 1000.0`
  - `Sample Scale Factor By Curve = False`
- 预览区效果：
  - 左侧预览中同一束喷发粒子已经出现更明显的细长拖尾和速度感，不再只是均匀大小的小圆点。
  - 这与“按速度缩放精灵尺寸”模块的用途一致。
- 讲解语境：
  - 字幕说明“没有这个模块”和“有了这个模块”的对比，表明这一步的目标就是展示该模块带来的视觉差异。
- 本图结论：
  - `Scale Sprite Size by Speed` 被用来强化 `Fountain` 粒子的动势表现：当粒子速度接近或超过 `1000` 阈值时，尺寸会按设定比例发生拉伸，让角色 Aura 的第一层喷发看起来更有流向感。

### 00:05:02-00:09:34 粒子、发射器、速度

- 本段定位：粒子、发射器、速度。
- 知识点：可以加上双轮, 从两到三, 它们必须在它们的速度中, 它会更好看。
- 知识点：可以想象我们有双轮, 如果它们会往这个方向下降, 可以增加, 例如, 它们的速度增加60度, 因此它们会向旁边更多的反向。
- 知识点：如果没有调整方向, 它们会伸向一个直线, 它会看起来很差。
- 知识点：如果我们调整速度, 它们会看到完全不同的结果。
- 知识点：我们有一个速度调整方向, 需要把它按停。
- 知识点：如果需要它们的粒子 一直向它们的方向移动, 在这个情况下, 需要把它们转向, 它们会向它们的速度移动。
- 知识点：这就是为什么我把 比如说, 在速度调整方向里面, 让它们能看到它们在转向中。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`粒子`、`发射器`、`速度`、`颜色`。

**关键画面：**

这是 `NS_MagicAura_01` 中 `Fountain` 发射器的继续调试画面，作者在现有喷发粒子基础上准备启用 `Gravity Force`，让粒子轨迹不再只是直线外冲，而会出现下坠趋势。

- 当前发射器模块链：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Shape Location Sphere`
  - `Add Velocity in Cone`
  - `Particle State`
  - `Gravity Force`
  - `Drag`
  - `Scale Color`
  - `Solve Forces and Velocity`
  - `Scale Sprite Size by Speed`
  - `Sprite Renderer`
- 操作状态：
  - 鼠标停在 `Gravity Force` 这一行的启用勾选区域。
  - 字幕明确说明 “Let's add gravity.”，可确认这一步的目标是为该发射器加入重力影响。
- 右侧 `Initialize Particle` 已确认参数：
  - `Lifetime Mode = Random`
  - `Lifetime Min = 1.4`
  - `Lifetime Max = 1.75`
  - `Color Mode = Direct Set`
  - `Position Mode = Simulation Position`
  - `Mass Mode = Random`
  - `Mass Min = 0.75`
  - `Mass Max = 1.25`
  - `Sprite Size Mode = Random Uniform`
  - `Uniform Sprite Size Min = 6.0`
  - `Uniform Sprite Size Max = 12.0`
- 本图结论：
  - `Fountain` 的基础出生参数已经定好，接下来通过启用 `Gravity Force`，粒子会从单纯的锥形速度喷射过渡为带下坠弧线的运动，更符合魔法喷泉式 Aura 粒子的层次感。
这是 `Fountain` 发射器在启用速度拉伸后的效果预览。作者把精灵进一步沿速度方向拉长，让每个粒子不再像短白点，而更像有方向性的能量线段。

- 当前发射器模块链仍为：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Shape Location Sphere`
  - `Add Velocity in Cone`
  - `Particle State`
  - `Gravity Force`
  - `Drag`
  - `Scale Color`
  - `Solve Forces and Velocity`
  - `Scale Sprite Size by Speed`
  - `Sprite Renderer`
- 右侧 `Scale Sprite Size by Speed` 已确认设置：
  - `Min Scale Factor = (0.1, 10.0)`
  - `Max Scale Factor = (0.2, 2.0)`
  - `Velocity Threshold = 1000.0`
  - `Sample Scale Factor By Curve = False`
- 与上一张图相比的关键变化：
  - `Max Scale Factor` 的第二个分量已从 `1.0` 调整到 `2.0`。
  - 这意味着高速粒子会被拉得更长，速度方向的视觉指向性更强。
- 预览结果：
  - 左侧粒子已明显变成细长白色线段，且大多沿各自飞行方向伸展。
  - 画面字幕也明确说明“只需要拉伸它们，它们就会朝着自己的速度方向”。
- 本图结论：
  - 这一帧的重点是强化 `Scale Sprite Size by Speed` 的拉伸效果，让 `Fountain` 粒子根据速度方向形成更强的线性感，避免无方向的小点状喷发看起来过于平淡。
这是一张外部视觉参考检索画面，不是 Niagara 参数编辑图。作者在浏览器中搜索 Aura 类游戏特效，用来给后续“地面法阵/魔法圆环”的第一阶段找视觉方向。

- 检索环境：
  - 浏览器中搜索关键词为 `aura game effect`
  - 页面展示的是 Google 图片结果
- 参考方向：
  - 结果中包含多种 Aura/魔法圈参考，例如：
    - 角色脚下的环形 Aura
    - 发光符文圆盘
    - 竖向能量柱与底部圆环组合
    - 不同颜色和层次的游戏技能特效
  - 右侧大图预览是一张蓝色科幻/魔法传送门式参考图，特征包括：
    - 底部同心圆环
    - 中心高亮核心
    - 向上延伸的多条垂直光束
    - 整体呈“地面法阵 + 立柱能量”构图
- 讲解语境：
  - 字幕提到“让我们来到地球魔法阵的第一阶段”，说明作者准备从外部参考中抽取“地面魔法圈”的基础构图，再回到 Niagara 中实现。
- 本图结论：
  - 本步骤的作用是确定视觉目标，而不是直接修改节点。后续制作的第一阶段应重点围绕“地面圆环、中心发光、上升光束”这类 Aura/魔法阵元素展开。

### 00:09:34-00:13:24 关键流程 03

- 本段定位：关键流程 03。
- 知识点：需要设置最初的模式, 需要增加缩射率。
- 知识点：我们制作物质, 我把所有的模式 都转到一个阶段。
- 知识点：需要名字 并转到模式阶段, 这样它会清楚 哪些模式 和哪些主要材料。
- 知识点：可以制作这些材料。
- 知识点：需要展示一个 其他模式的模式。

**关键画面：**

这是在 `NS_MagicAura_01` 中新建一个名为 `Empty` 的发射器后的初始配置画面。作者正在往空发射器里添加基础模块，但 `Spawn Rate` 被放在了错误的分组位置，导致 Niagara 提示依赖顺序错误。

- 当前系统与发射器：
  - 系统名：`NS_MagicAura_01`
  - 当前发射器名：`Empty`
  - 时间线上也只显示这一条 `Empty` 轨道，说明正在从空白模板搭建一个新层。
- `Empty` 当前模块结构：
  - `Spawn Rate`
  - `Emitter State`
  - `Initialize Particle`
  - `Particle Update`
  - `Particle State`
  - `Sprite Renderer`
- 右侧 `Spawn Rate` 报错信息：
  - 模块提示存在未满足的依赖关系。
  - 具体说明：`The following pre-dependency is not met: EmitterLifeCycle.`
  - 建议修复方式：`Move module SpawnRate After EmitterState`
  - 面板提供了 `Fix issue` 与 `Dismiss issue` 两个按钮。
- 当前 `Spawn Rate` 数值：
  - `SpawnRate = 0.0`
  - `Spawn Probability = 1.0`
- 操作含义：
  - 这一步不是调整视觉参数，而是在建立新发射器的最小可用骨架。
  - 正确顺序应先有 `Emitter State`，再放 `Spawn Rate`，否则生成模块拿不到生命周期依赖。
- 本图结论：
  - 新建 `Empty` 发射器后，首先要修正模块顺序：把 `Spawn Rate` 移到 `Emitter State` 之后，确保 `EmitterLifeCycle` 依赖满足，再继续补其它生成与渲染模块。
这是 `Empty` 发射器在补齐基础模块后的渲染设置画面。作者已经给这个新发射器指定了一个专用材质实例 `MI_MagicArea_01`，并开始讲解 Sprite 的对齐与朝向语义。

- 当前发射器状态：
  - 发射器名仍为 `Empty`
  - 当前粒子数：`5 Particles`
  - 可见模块链：
    - `Emitter State`
    - `Spawn Rate`
    - `Initialize Particle`
    - `Particle Update`
    - `Particle State`
    - `Sprite Renderer`
- 右侧 `Sprite Renderer` 已确认设置：
  - `Material = MI_MagicArea_01`
  - `Material User Param Binding = None`
  - `Source Mode = Particles`
  - `Alignment = Automatic`
  - `Facing Mode = Automatic`
  - `Macro UVRadius = 0.0`
  - `Default Pivot in UV Space = (0.5, 0.5)`
  - `Pixel Coverage Mode = Automatic`
  - `Pixel Coverage Blend = 1.0`
  - `Sort Mode = None`
  - `Renderer Visibility = 0`
- 预览结果：
  - 左侧能看到一个淡白色环形轮廓，说明该材质已经被用来显示地面法阵/圆环类图案。
- 讲解语境：
  - 字幕说明 `Alignment defines how the sprite is oriented relative to its plane.`，明确这一段在解释精灵贴片的平面对齐方式。
- 本图结论：
  - 新发射器的核心工作已从“补基础模块”转向“确定渲染形态”：通过 `MI_MagicArea_01` 作为精灵材质，并使用自动对齐/自动朝向，让这一层开始承担地面魔法圈或环形贴片的显示职责。
这是回到关卡视口中验证 `NS_MagicAura_01` 新增圆环层显示效果的画面。作者通过观察魔法圈相对摄像机位置和角度的变化，来确认 `Sprite Renderer` 的对齐/朝向设置是否符合预期。

- 场景与目标对象：
  - 右侧 Outliner 选中的是 `NS_MagicAura_01`。
  - Details 面板显示选中实例为 `NS_MagicAura_01 (Instance)`。
  - 当前实例位置约为 `Location = (-458.2, -706.0, 50.043)`。
- 可见效果：
  - 地面上出现一个小型白色圆环/符文圈。
  - 圆环位于角色附近但与角色本体拉开了距离，便于单独观察它的贴片朝向。
  - 当前从俯视偏斜角度看过去，圆环仍保持稳定可见。
- 讲解语境：
  - 字幕明确提到“相对于摄像头位置和角度”。
  - 结合上一张中 `Alignment` 与 `Facing Mode` 的讲解，可确认这一帧是在检查精灵贴片是否按预期面对相机或保持正确平面方向。
- 本图结论：
  - 新增的魔法圈层已经能在关卡中单独显示；此步的重点是通过实际视角检查 `Sprite Renderer` 的朝向策略，确保地面圆环在不同相机角度下不会出现错误翻转或不可见问题。

### 00:13:34-00:17:07 关键流程 04

- 本段定位：关键流程 04。
- 知识点：相机位置 改变了 相机位置 只在我们 把相机位置改变了。
- 知识点：如果我改变了 相机颜度 把对角度的 相机位置 时不需要 把对角度 当相机位置改变了 它们是非常相似的。
- 知识点：相机位置 它改变了方向,设置了距離,最小,最大 它增加了距離 基本上,所有东西都一樣 它都一直对着我们 现在需要展示 例如,我们想它只对着鏡頭。
- 知识点：它不看着鏡頭 可以控制它 我只会留给它 这里所有东西都標準 它就自動定義了我们该设置的模式 我說了,这里有模式,这里有鏡頭,面对模式。
- 知识点：我写了它,但它现在不在 或是例如,有调整,但它们不在 加上一條模式叫鏡頭面对鏡頭和调整 它们会给我们更多的模式 现在我写了 现在我们有鏡頭面对鏡頭。

**关键画面：**

这是 `NS_MagicAura_01` 在关卡中的视角验证画面。作者把角色和独立魔法圈分开摆放，专门从当前相机位置观察圆环贴片的显示方式，确认其在斜视角下的可见性与朝向表现。

- 场景与对象：
  - 右侧 Outliner 选中的是 `NS_MagicAura_01`。
  - Details 中实例位置约为 `Location = (-458.2, -706.0, 50.043)`。
  - 角色站在画面左侧，地面魔法圈被放在画面下方中央，二者刻意分离便于单独观察圆环层。
- 视觉结果：
  - 地面上可见一圈白色符文圆环。
  - 当前相机是较高、较远的俯视斜角，圆环仍能保持完整轮廓，没有消失或明显翻转。
- 本图结论：
  - 这一步不是继续改节点，而是先用实际视角检查魔法圈贴片在场景中的显示稳定性；当前结果说明该圆环层在远距离斜视角下仍能正常读取。
这是 `Empty` 发射器继续完善朝向控制的画面。作者在模块添加面板里搜索 `sprite`，准备给当前圆环层加入 `Sprite Facing and Alignment` 模块，以获得比 `Automatic` 更明确的精灵朝向模式。

- 当前发射器：
  - 发射器名：`Empty`
  - 当前粒子数：`5 Particles`
- 右侧 `Sprite Renderer` 当前已确认设置：
  - `Material = MI_MagicArea_01`
  - `Source Mode = Particles`
  - `Alignment = Automatic`
  - `Facing Mode = Automatic`
  - `Default Pivot in UV Space = (0.5, 0.5)`
  - `Sort Mode = None`
  - `Renderer Visibility = 0`
- 当前操作：
  - 打开 `Add new Module` 面板并搜索关键字 `sprite`
  - 可见候选模块中包括：
    - `Facing and Alignment`（位于 `Sprite` 分类）
    - 以及若干 Mesh 相关条目
  - 结合本段上下文，可确认作者此步想添加的重点就是 `Sprite Facing and Alignment`
- 操作意图：
  - 默认 `Automatic` 模式已经可用，但作者需要更多明确的“面向相机/按某轴对齐”控制。
  - 因此先通过单独模块把 Sprite 的 Facing 与 Alignment 逻辑显式暴露出来，再做进一步设置。
- 本图结论：
  - 本步骤的关键不是调整材质，而是给圆环贴片补一个专门的 `Sprite Facing and Alignment` 模块，为后续精确控制相机朝向模式打基础。
这是 `NS_MagicAura_01` 中魔法圈贴片的空间朝向验证图。作者在关卡里直接选中这张 Sprite，观察其所在平面与局部方向轴，确认它不是简单平躺在地面，而是按当前 Facing/Alignment 规则建立了一个倾斜的显示平面。

- 已确认对象：
  - 选中实例仍为 `NS_MagicAura_01 (Instance)`。
  - 右侧位置约为 `Location = (-458.2, -706.0, 50.043)`。
- 空间可见信息：
  - 魔法圈贴片外侧显示出一个黄色矩形选框，表示当前 Sprite 所在的二维显示平面。
  - 该平面明显相对地面倾斜，并非完全与地面重合。
  - 贴片中心显示变换 gizmo，绿色箭头沿其中一条局部轴指向右上方。
- 语义判断：
  - 这张图是对前面 `Sprite Facing and Alignment` 调整结果的直接可视化检查。
  - 目标是确认圆环精灵如何相对于相机和自身平面定向，而不是继续修改其它生成参数。
- 本图结论：
  - 当前魔法圈层已经建立了明确的 Sprite 显示平面与局部朝向；通过在关卡中直接查看选框与轴向，可以验证其 Facing/Alignment 设置确实改变了贴片的空间取向。

### 00:17:23-00:21:53 关键流程 05

- 本段定位：关键流程 05。
- 知识点：它总是会向这方向轉 如果我改变面对鏡頭 现在它会向Y方向轉 它会向Y方向轉 之前它会向X方向轉 现在它的方向是與X有關 这就是X方向的方向。
- 知识点：这是Y方向的方向 Z方向是向上向下的 如果Z是正確的,它会向上向 现在我们的鏡頭是兩面 按照標準,它是兩面 如果我选择兩面 它会向前向 它会向後向。
- 知识点：如果兩面是关闭的 只有一面会显示 我设置了X方向的圖表 X方向有兩种方向 正確和正確 在这情况下,鏡頭向右方向轉 我们不能看到後面 如果我改变面对鏡頭。
- 知识点：我写Y,它会向右方向轉 现在它只会向右方向轉 我们只会看到右方向轉 例如,如果需要它向右方向轉 而不是向正向轉 如果我改变面对鏡頭向右方向轉。
- 知识点：我必须设置-1 它会改变它的方向 它也会向Z向 这是上方向 这是上方向 这是我们需要的 B,它不在下面 如果需要它只在下面 如果我们不看到上方向。
- 知识点：但只在下面 我们也有这樣的选择 我改变面对鏡頭向右方向轉 如果我们必须看到兩面 它会向右方向轉 如果我们必须设置-2 它会向右方向轉 但我可以從下面看到。
- 知识点：需要增加它的尺寸 Sprite Size Mod会均衡 我不会隨意设置 需要设置200 它会向右方向轉 它不会向鏡頭向右方向轉 它只会向右方向轉。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。

**关键画面：**

这是 `Empty` 发射器中 `Sprite Facing and Alignment` 模块已经加入后的设置画面。作者开始用显式的朝向向量替代纯自动模式，控制圆环贴片相对于相机和局部轴的朝向。

- 当前发射器模块链：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Sprite Facing and Alignment`
  - `Particle Update`
  - `Particle State`
  - `Sprite Renderer`
- 右侧 `Sprite Facing and Alignment` 已确认设置：
  - `Sprite Facing = (0.0, 1.0, 0.0)`
  - `Facing Coordinate Space = Simulation`
  - `Sprite Alignment = (0.0, 1.0, 0.0)`（当前显示为灰态/未重点编辑）
- 预览结果：
  - 左侧原本的圆环贴片已经变成一条细长竖向条带，说明当 Facing/Alignment 改成某个固定轴向后，精灵不再像俯视法阵那样平铺，而会沿指定方向竖起或转向。
- 本图结论：
  - 这一帧的重点是把圆环贴片的朝向控制显式化：当前以 `Simulation` 空间中的 `Y` 轴方向 `(0,1,0)` 作为朝向基准，为后续测试 X/Y/Z 不同方向、以及与相机关系的差异做准备。
这是 `Sprite Facing and Alignment` 继续切换朝向轴的画面。作者把 `Sprite Facing` 从之前的 `Y` 轴方向改成 `Z` 轴方向，用来观察圆环贴片在“朝上/朝下”语义下的显示结果。

- 右侧 `Sprite Facing and Alignment` 已确认设置：
  - `Sprite Facing = (0.0, 0.0, 1.0)`
  - `Facing Coordinate Space = Simulation`
  - `Sprite Alignment = (0.0, 1.0, 0.0)`（仍保持未重点修改状态）
- 与上一张图的关键变化：
  - `Sprite Facing` 已从 `(0,1,0)` 改为 `(0,0,1)`。
  - 即从沿 `Y` 方向面向，切换成沿 `Z` 方向面向。
- 预览结果：
  - 左侧预览中的贴片重新表现为接近平铺的圆环，不再像上一张那样被拉成细长竖向条带。
  - 这说明 `Z` 轴朝向更接近作者期望的“地面法阵”显示方式。
- 本图结论：
  - 通过把 `Sprite Facing` 切到 `Z` 轴，作者验证了不同基向量会直接改变贴片在场景中的可读形态；对于这种地面圆环层，`Z` 方向比 `Y` 方向更接近正确朝向。
这是将魔法圈层重新放回角色脚下后的关卡验证画面，用来确认朝向、尺寸和位置都已经调整到可作为正式地面法阵使用的状态。

- 场景与对象：
  - 右侧选中实例仍为 `NS_MagicAura_01 (Instance)`。
  - 当前实例位置约为 `Location = (52.631, -191.4, 30.425)`。
  - 魔法圈已经与角色脚下位置重合，不再像前几张那样单独摆在一旁测试。
- 可见结果：
  - 白色双环符文圈完整包住角色脚下区域。
  - 黄色选框显示出 Sprite 贴片的实际显示平面，整体面积已明显增大，足以覆盖角色站立范围。
  - 绿色局部轴箭头沿贴片平面伸出，方便确认当前朝向不是错误翻折。
- 验证结论：
  - 当前圆环既能保持地面法阵的俯视观感，又能正确贴合角色脚下。
  - 这说明前面关于 `Sprite Facing and Alignment` 的方向设置，以及尺寸放大，已经达到可用结果。
- 本图结论：
  - 本段最终得到的是一个可正式挂在角色脚下的地面魔法圈层：方向已修正为适合平铺显示，尺寸也已扩大到覆盖角色周围区域。

### 00:23:00-00:26:35 关键流程 06

- 本段定位：关键流程 06。
- 知识点：现在很難看到 需要改变它到200和500 200在X和500在Y的方向 它的質料现在是向X向向 现在是向Y向向 也能够设置在Z向向 但这会很難看到。
- 知识点：它是向Z向向 而In is sprite facing 这会造成冲突 如果兩者是一樣的 它不会很容易合成 而我会用Orientation。
- 知识点：来让它轉動 现在没有方向 它是一樣的 它向鏡頭向右方向轉 但现在是向Y向向轉 我开始轉動 可观察到結果 如果向X向轉 它就会向反方向轉 现在它会轉向这條角向。
- 知识点：我为什么会这樣 这是必须的 有些效果 需要创建Volume的幻想 我们有一个文件的盒子 需要把这火扔在这里 它伸延了 需要再伸延到Y向向 它开始轉動。
- 知识点：创建Volume的幻想 如果我们选择这种调整 它是想向鏡頭向向轉 但现在它不会显示 Volume效果创建了 如果需要它向上向轉 然后变得很有趣。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。

**关键画面：**

这是 `NS_MagicAura_01` 中地面魔法圈层的尺寸与朝向联调画面。作者把圆环贴片改成明显的非均匀长宽比，用来观察当贴片被拉长后，Facing/Orientation 的方向差异会如何影响最终形态。

- 当前发射器：
  - 发射器名：`Empty`
  - 左侧关卡视口中，圆环贴片已被拉成长椭圆/长条法阵，覆盖角色脚下较大区域。
- 右侧 `Initialize Particle` 已确认设置：
  - `Lifetime Mode = Direct Set`
  - `Lifetime = 5.0`
  - `Position Mode = Simulation Position`
  - `Mass Mode = Unset / (Mass of 1)`
  - `Sprite Size Mode = Non-Uniform`
  - `Sprite Size = (200.0, 500.0)`
  - `Sprite Rotation Mode = Unset`
- 场景观察：
  - 黄色选框清楚显示出当前 Sprite 平面已经被拉成一个长矩形。
  - 白色符文圈不再接近圆形，而是沿其中一条轴被大幅拉长。
  - 绿色局部轴箭头与长轴方向的关系清晰可见，便于后续比较 X/Y/Z 或 Orientation 对形态的影响。
- 本图结论：
  - 通过把贴片尺寸改成 `200 x 500` 的非均匀比例，作者把“朝向是否正确”的问题放大了；后续任何 Facing/Orientation 的变化都会更明显地体现在这张被拉长的魔法圈上。
这是 `Sprite Facing and Alignment` 模块继续细化轴向控制的画面。作者不再只依赖 Facing，而是开始直接指定 `Sprite Alignment` 轴，让这张被拉长的法阵贴片围绕某个明确方向旋转。

- 右侧 `Sprite Facing and Alignment` 已确认设置：
  - `Sprite Alignment = (1.0, 0.0, 0.0)`
  - `Alignment Coordinate Space = Simulation`
  - `Sprite Facing` 行存在但未作为当前重点编辑项，画面不足以可靠补全其数值
- 可见结果：
  - 左侧长椭圆法阵贴片明显处于一个倾斜平面上，不再是简单平铺在角色脚下。
  - 绿色局部轴箭头与贴片长边方向形成清晰对照，便于观察绕指定轴旋转后的姿态。
- 讲解语境：
  - 字幕说明“现在它将相对于这个轴旋转”。
  - 这与 `Sprite Alignment = (1,0,0)` 的设置一致，说明作者正在用 `X` 轴作为对齐/旋转参考。
- 本图结论：
  - 当贴片被拉成长法阵后，`Sprite Alignment` 的作用会非常明显：这里通过指定 `X` 轴对齐，让法阵围绕一条明确轴线倾斜或旋转，以制造更强的空间体积感。
这是当前朝向与拉伸策略应用后的结果验证图。原本的法阵贴片已经不再只表现为地面圆环，而是被观察成一条强烈的竖向发光体，从而制造出更明显的“体积/光柱”错觉。

- 画面结果：
  - 屏幕左侧出现一条非常亮的黄白色竖向发光带。
  - 光带中心接近纯白，外缘过渡到黄色和橙色，说明当前材质与贴片在该视角下被读成了高亮体积面。
  - 背景中的地面和远处环境仍可见，说明这是同一关卡中对法阵贴片不同朝向结果的直接观察。
- 与前两张图的关系：
  - 前两张图通过 `Sprite Size = 200 x 500` 和 `Sprite Facing/Alignment` 的轴向调整，把一张二维贴片变成了长矩形平面。
  - 当前这张图展示的正是这种长矩形贴片在特定朝向下，从侧面或斜侧面观察时形成的“竖向能量柱”视觉。
- 本图结论：
  - 这一段的目的不是得到一个稳定的地面法阵，而是演示：通过非均匀拉伸加上 Facing/Alignment 轴向控制，同一张 Sprite 也能被塑造成类似体积光柱的效果，用来营造 Volume 幻觉。

### 00:26:47-00:31:31 粒子

- 本段定位：粒子。
- 知识点：如果我把它们都移開 需要依照標準 依照所有的方向 你看它向鏡頭向向 我们需要效果 向鏡頭向向向 從某个角度 这光亮面向和面向是用的 好的,这已经處理好了。
- 知识点：我们再換回圆形材料 它不需要向上向轉 它需要向地向向向向 面向向向向 面向向向 按鍵 我们设置了Y向向的调整 我们認为它是同樣的 我们选择了X和Y向向。
- 知识点：我们选择了哪个 我们換个尺寸 我们放上一面 把它貼在角色上 可以提升效果 或把它放在正常的位置 可以提升效果 而不是增加效果 可以提升濃度。
- 知识点：当它與地面接觸 它会增加 transparency 我们不需要它 我们把它设置为0 主要的就是 亮度不会消失 我们设置點色 需要把色調在这里。
- 知识点：需要开启文件 用聲效果 需要把这个效果 我们设置为一般的 需要把色調在这里 需要把色調在这里 押上和押上 需要把色調在这里 在这里有一点點明顯。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`粒子`。

**关键画面：**

这是 `NS_MagicAura_01` 中长贴片法阵层的结果验证图。当前这张被非均匀拉长并经过 Facing/Alignment 调整的 Sprite，已经不再像地面圆环，而是表现成紧贴角色一侧的竖向光幕/光刃。

- 可见结果：
  - 屏幕中央偏左是一条细长的黄白色竖向发光带。
  - 发光带中心高亮接近白色，边缘呈黄色与橙色渐变，说明材质在当前朝向下读成了侧立的发光面。
  - 角色主体被这条发光带部分遮挡，只在右侧露出少量轮廓，进一步证明贴片当前已经立起来并贴近角色。
- 场景关系：
  - 右侧 Details 仍显示选中实例为 `NS_MagicAura_01 (Instance)`。
  - 这说明当前亮带并不是新的独立资源，而是同一个 Niagara 系统里那张被拉长的法阵贴片在不同朝向下的视觉结果。
- 本图结论：
  - 这一帧证明了同一张法阵贴片可以被塑造成“立体光幕”效果：当长轴贴片朝向相机侧面时，它会从平面法阵转变成一条窄而亮的垂直能量带。
这是回到关卡与内容浏览器总览后的确认画面。作者把当前完成到这个阶段的法阵层结果挂回角色脚下，同时在资源目录中保留 `NS_MagicAura_01`，用于和其他 Niagara 系统并列管理。

- 关卡结果：
  - 角色脚下可见一圈白色符文法阵。
  - 当前这个结果相比前一张的竖向光幕，更接近最终要保留的“地面光环/法阵”形态。
- 资源目录：
  - 当前路径位于 `Content > VFX_Library > Niagara`
  - 可见 3 个 Niagara System：
    - `NS_Fire`
    - `NS_ItemAura_01`
    - `NS_MagicAura_01`
  - 鼠标当前位于 `NS_ItemAura_01` 缩略图上，但右侧 Outliner 选中的关卡实例是 `NS_MagicAura_01`
- 右侧实例信息：
  - `NS_MagicAura_01 (Instance)`
  - `Location = (0.0, 0.0, 0.0)`
  - `Scale = (1.0, 1.0, 1.0)`
- 本图结论：
  - 当前阶段的魔法圈已经整理为独立系统资源 `NS_MagicAura_01`，并能作为地面法阵稳定显示在角色脚下；教程也开始把它放回资源库语境中，准备继续往完整 Aura 系统扩展。
这是 `NS_MagicAura_01` 当前阶段整合回角色身上的结果图。教程此时已经不再单独展示地面法阵或竖向光幕，而是把这层重新并入角色 Aura 整体构图中，检查叠加后的视觉密度和位置关系。

- 场景结果：
  - 角色背后可见一圈较亮的金黄色环形 Aura。
  - 相比前面的单独法阵测试，这里更关注完整角色效果而不是某一张贴片的局部朝向。
  - 角色脚下地面法阵在这个视角下不明显，说明当前画面强调的是背后主光环层与整体轮廓。
- 右侧实例信息：
  - 当前仍选中 `NS_MagicAura_01 (Instance)`。
  - `Location = (0.0, 0.0, 0.0)`
  - `Scale = (1.0, 1.0, 1.0)`
- 语义判断：
  - 本段前两张图展示了如何把同一张贴片在“地面法阵”和“竖向体积错觉”之间切换。
  - 这一张则说明作者开始把这一层按需要叠回角色 Aura 里，用于提升整体亮度、层次或包裹感，而不是孤立地展示测试平面。
- 本图结论：
  - 到这一帧为止，`NS_MagicAura_01` 的新增贴片层已经具备可回收进正式角色 Aura 的条件；它既可以单独作为法阵/体积光测试层，也能回到角色整体效果中作为增强层使用。

### 00:31:31-00:35:56 粒子

- 本段定位：粒子。
- 知识点：这不夠了 我们来做一点不同的事情 改变形状 现在变得更好 我認为三秒就夠了 每秒都在生 现在它很快就在生 因为没有透明性的控制 需要加強颜色和透明性。
- 知识点：我们来加一个形状 来控制它在时间內 它在生 然后它到達它的最高 然后就在生 这里 然后它会长长的見到 只要它这樣 可以改变它的光景 很亮亮的 我们不会把它太亮。
- 知识点：你也可以把质感改变 如果它不喜欢 可以把这材料拿成一塊 插这里 輪流圈会不一樣 但这不太行 可以自己做一个质感 我们来拿一个简单的圈 很简单的质感。
- 知识点：有一个展示方法 我们製造雷 这是下一步 我们製造新的发射器 我们叫它 我们製造发射器 会有無限的发射 发射量会產生2个粒子。
- 知识点：粒子会存在1-2个粒子 后续会用廣角式的 发射器来伸延 然后在圆形中 在圆形中緩解範圍 但在它们中间的扭圍 所以它会这樣发射 我们要将扭圍向Y方向移动。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`粒子`、`发射器`、`颜色`。

**关键画面：**

这是 `NS_MagicAura_01` 中地面圈层样式调整后的关卡结果。作者不再使用前面那种复杂符文法阵，而是换成了更简单、更柔和的双层发光圆环，并开始观察它在角色脚下的亮度与存在感。

- 可见结果：
  - 角色脚下出现两圈浅金黄色发光环。
  - 外圈较大、内圈较小，二者都呈柔和波纹状边缘，没有复杂符文细节。
  - 整体亮度比白色符文圈更柔和，但覆盖面积更清晰，适合作为 Aura 底层基础形状。
- 场景语义：
  - 这一变化与正文中“换一个更简单的圈”“控制亮度和透明度”的描述一致。
  - 当前重点不在朝向，而在更换贴图/材质风格，并重新评估它与角色脚下区域的匹配程度。
- 本图结论：
  - 本步骤已经把地面层从“符文法阵”转向“简化双环 Aura”，为后续进一步做亮度、透明度和新发射器叠加打底。
这是一张外部视觉参考检索画面，不是 Niagara 参数编辑图。作者再次在浏览器中搜索 `aura game effect`，这次重点锁定“地面圆环 + 竖向光柱/能量柱”的参考方向。

- 检索环境：
  - 浏览器搜索关键词仍是 `aura game effect`
  - 页面为 Google 图片结果
- 当前关注的主参考：
  - 右侧大图预览是一张蓝色的传送门/光柱参考图。
  - 可见特征包括：
    - 底部发光圆环
    - 多层同心结构
    - 中央亮点
    - 数条向上延伸的蓝色光束
    - 整体呈“底盘 + 竖向能量柱”的舞台化构图
- 语义作用：
  - 结合正文里“下一步做雷/新的发射器”的描述，这张参考显然是在为后续加入竖向线条、能量柱或上升光束寻找构图依据。
- 本图结论：
  - 本步骤的作用是确定后续新增层的视觉方向：在已有地面双环 Aura 之外，再叠加竖向光束或能量柱，让效果从平面光圈提升到更具体积感的 Aura/传送门形态。
这是 `NS_MagicAura_01` 继续拆分层级后的系统总览画面。系统中已经同时存在 `MagicCircle` 和 `Empty` 两个发射器，作者正在给当前选中的发射器调 `Scale Color` 的 Alpha 曲线，让该层先快速显现，再逐步衰减。

- 当前系统内可见发射器：
  - `MagicCircle`
  - `Empty`
- 可见模块结构：
  - `MagicCircle` 发射器包含：
    - `Emitter State`
    - `Spawn Rate`
    - `Initialize Particle`
    - `Sprite Facing and Alignment`
    - `Particle State`
    - `Scale Sprite Size`
    - `Scale Color`
    - `Sprite Renderer`
  - `Empty` 发射器可见：
    - `Emitter State`
    - `Spawn Rate`
    - `Initialize Particle`
    - `Shape Location Ring / Disc`
    - `Particle State`
    - `Scale Color`
    - `Sprite Renderer`
- 右侧当前所选模块已确认设置：
  - 模块为 `Scale Color`
  - `Scale Mode = RGB and Alpha Separately`
  - `Scale RGB = (1.0, 1.0, 1.0)`，当前不改颜色值
  - `Scale Alpha = Float from Curve`
  - 曲线索引来源：`PARTICLES.NormalizedAge`
  - `Scale Curve = 1.0`
  - 曲线形状表现为：开始阶段快速升到较高值，随后随生命周期缓慢下降到较低值
- 本图结论：
  - 到这一帧为止，系统已经开始分层组织地面圈与其它 Aura 层；当前通过 `Scale Color` 的 Alpha 曲线控制其中一层的显隐节奏，避免光圈一出现就过亮或全程保持同一强度。

### 00:35:56-00:40:49 透明度

- 本段定位：透明度。
- 知识点：它们会出现很快 我们改变它 它会发射的比例会更高 改变它 我们来拿點材料 我们需要什么材料 我们要用什么材料 我们来想想 我们来把它当作基礎。
- 知识点：我们叫它 我们把它丟掉 我们把它的发射量当作基礎 我们把发射量拿出来 然后把它伸延 找发射量 后续会将它伸延在Y方向 我们需要测试 看看它会如何。
- 知识点：我们拿这个 我们把材料丟掉 这个位置让它看起来不好 需要做它不同 让它在中间縫隙 需要增加它的尺寸 它從下面不見了 需要增加尺寸更多。
- 知识点：120 我们来设置一些颜色 颜色模式随机 分別会在0.7的透明度 材料不太适合 我们来換一件 可以用某些軟件 看看它会如何 可以試試这个。
- 知识点：已经需要设置 一个更大的尺寸 这里会有很多 900 增加深度的遺失 让邊緣更軟 很简单 可以試試这个。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`、`透明度`。

**关键画面：**

这是 `NS_MagicAura_01` 中 `Empty` 发射器的 `Scale Sprite Size` 曲线调节画面。虽然正文标题是“透明度”，但当前截图直接显示的是尺寸曲线，因此这里只记录图中能确认的尺寸变化逻辑。

- 当前系统内可见发射器：
  - `MagicCircle`
  - `Empty`
- 当前选中发射器：
  - 选中的是 `Empty`
- 右侧 `Scale Sprite Size` 已确认设置：
  - `Scale Sprite Size Mode = Uniform Curve`
  - 曲线数据类型：`Curve for Floats`
  - 曲线索引来源：`PARTICLES.NormalizedAge`
  - `Uniform Curve Scale = 1.0`
  - 当前曲线形状：
    - 出生阶段从较低值起步
    - 很快抬升到中高值
    - 中后段继续缓慢爬升并接近平台
- 讲解语境：
  - 字幕明确说明“我们改变曲线”。
  - 结合当前界面，可确认作者正在通过生命周期曲线控制该层贴片的尺寸增长节奏，而不是固定大小。
- 本图结论：
  - 这一层的 Sprite 不再恒定尺寸，而是会随 `NormalizedAge` 逐步放大；这样能让光圈或贴片先较小出现，再成长到更稳定的可见尺寸。
这张图展示的是为 `NS_MagicAura_01` 试选发光材质实例的资源浏览过程，而不是 Niagara 模块参数细调。可确认信息如下：

- 当前打开的资源页签包括：
  - `MI_MagicArea_01`
  - `NS_MagicAura_01`
  - `MI_AuraGlow_02`
  - `T_Flare13`
- 内容浏览器路径位于：
  - `Content > VFX_Library > Materials > Instances`
- 当前高亮选择的材质实例是：
  - `MI_AuraGlow_02`
- 同目录可见多种可替换的 Aura/Glow 类材质实例，包括：
  - `MI_CircleAura_01`
  - `MI_Glow_01`
  - `MI_Glow_02`
  - `MI_GlowAura_01`
  - `MI_MagicArea_01`
  - `MI_RayAura_01`
  - `MI_StarAura_01`
- 视口中右侧仍选中：
  - `NS_MagicAura_01 (Instance)`
  - `Location = (0, 0, 0)`
  - `Scale = (1, 1, 1)`

- 本图结论：
  - 作者此步正在 `Materials/Instances` 目录中挑选更适合 Aura 的发光材质实例，准备替换当前光圈层的材质表现。
  - 截图没有显示具体绑定到哪个 Renderer 材质槽，也没有显示材质实例参数面板，因此不要据此补写未显示的透明度、颜色或贴图参数。
这是 `NS_MagicAura_01` 中 `Empty` 发射器的 `Initialize Particle` 参数设置图，重点是随机寿命、随机颜色范围和 Sprite 初始尺寸范围。可确认信息如下：

- 当前系统内可见发射器：
  - `MagicCircle`
  - `Empty`
- 当前选中发射器：
  - `Empty`
- 当前模块：
  - `Initialize Particle`
- `Point Attributes`
  - `Lifetime Mode = Random`
  - `Lifetime Min = 1.0`
  - `Lifetime Max = 2.0`
- `Color Mode`
  - `Color Mode = Random Range`
  - `Color Channel Mode = Link RGB / Link A`
  - `Color Minimum`
    - `Red = 3.0`
    - `Green = 1.970382`
    - `Blue = 0.497768`
    - `Alpha = 0.5`
  - `Color Maximum`
    - `Red = 3.0`
    - `Green = 1.970382`
    - `Blue = 0.497768`
    - `Alpha = 0.7`
- 颜色含义：
  - RGB 最小值和最大值相同，因此随机范围实际只作用在 Alpha 上。
  - 这一层粒子会保持固定的暖黄色发光色，但每个粒子的透明度会在 `0.5` 到 `0.7` 之间随机分布。
- `Sprite Attributes`
  - `Sprite Size Mode = Random Non-Uniform`
  - `Sprite Size Min = (200.0, 700.0)`
  - `Sprite Size Max = (250.0, 900.0)`

- 本图结论：
  - 这一层 Aura 通过 `Initialize Particle` 直接建立随机寿命、随机透明度和长条形非均匀尺寸范围，用来做更柔和、厚度不同的发光贴片。
  - 结合本段正文，可把“透明度约 0.7”具体落实为：Alpha 上限约 `0.7`，下限约 `0.5`，并以随机区间而非固定值使用。

### 00:40:49-00:45:37 发射器生成与粒子初始化

- 本段定位：发射器生成与粒子初始化。
- 知识点：它会往下走 再往上走 这里它会往上走 我们再增加它 这些是发射量 我们来改变它的设置 不錯 需要增加发射位置 需要让它长时间 從2到4秒 不錯 如果我從上到下。
- 知识点：会有什么問題 它会轉向相關的鏡頭 会看起来很奇怪 它会從这个角度看起来好 但如果我從这个角度看 它会看起来不好 这会幫助我们调整 需要把它從Z的角度。
- 知识点：调整到它会一直向上看 会很酷 它们的鏡頭不会改变 它们会一直向上看 它们会一直向上看 如果我從Y的角度看 它们会看起来完全不同 如果從上到下会看起来好。
- 知识点：增加了发射量的数量 需要改变它 可以試試这个 现在我们来做发射量的升幅 我非常推薦你做这个 如果我做发射量的影响 可以把星星作为基礎。
- 知识点：让它從开始做出来 但可以这樣做 比如說 我们用幅圖 后续会它们写上一个系统 然后它们都会完成 这是可以的 但在这个情况下 后续会它從开始做出来 需要把这顆发射器。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`粒子`、`发射器`、`系统`。

**关键画面：**

这张图是外部参考检索画面，用来确定下一步“向上升起的光束/粒子柱”应做成什么视觉方向，不是 Niagara 参数设置图。可确认信息如下：

- 浏览器搜索关键词是：
  - `aura game effect`
- 右侧大图预览是一张蓝色传送门/光柱参考图，主要特征包括：
  - 地面有发光圆环底座
  - 多条竖向蓝色光束从圆环中心和边缘向上延伸
  - 光束高度明显高于前面参考图中的短光柱
  - 底部区域有额外的小光点和雾化发光
- 字幕提示：
  - “这里它们升得更高。”

- 本图结论：
  - 作者此步在找“更高的竖向光束”视觉参考，用来指导后续发射器把粒子或光带做成明显向上拉伸、向上延展的形态。
  - 这张图没有提供可直接复建的 Niagara 模块、参数或材质绑定信息，因此这里只记录参考目标，不推断未显示的实现细节。
这是 `NS_MagicAura_01` 中新增竖向光束发射器后的朝向设置画面。当前可确认信息如下：

- 当前系统内可见发射器：
  - `MagicCircle`
  - `Rays`
- 当前选中发射器：
  - `Rays`
- 当前操作：
  - 正在 `Add new Module` 搜索框中输入 `fac`
  - 搜索结果里可见 `Sprite Facing and Alignment`
  - 字幕说明目标是“相对于 Z 轴对齐，使它们始终朝上”
- 右侧 `Sprite Renderer` 已显示的渲染设置：
  - `Material = MI_AuraGlow_02`
  - `Source Mode = Particles`
  - `Alignment = Custom Alignment`
  - `Facing Mode = Automatic`
  - `Default Pivot in UV Space = (0.5, 0.5)`
  - `Pixel Coverage Blend = 1.0`
  - `Sort Mode = None`

- 朝向语义：
  - 本图中的“始终朝上”不是面向摄像机，而是把光束贴片的方向约束到系统使用的竖直轴，也就是字幕里明确提到的 `Z` 轴。
  - 这样做的目的，是避免从不同观察角度看时，竖向光束因为默认面向相机而出现方向飘动或侧看变扁的问题。

- 本图结论：
  - 这一层新增的是 `Rays` 发射器，并准备通过 `Sprite Facing and Alignment` 把贴片朝向锁定到竖直方向，让光束始终保持向上拉伸的观感。
这是 `NS_MagicAura_01` 中新建 `Stars` 发射器后的系统总览图，作者没有复用旧发射器，而是从头搭建一套新的星点层。可确认信息如下：

- 当前系统内可见发射器：
  - `Rays`
  - `Stars`
- 当前选中发射器：
  - `Stars`
- `Stars` 发射器的可见模块链：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Shape Location Sphere`
  - `Add Velocity From Point`
  - `Add Velocity 001 Linear`
  - `Particle State`
  - `Scale Sprite Size`
  - `Drag`
  - `Scale Color`
  - `Solve Forces and Velocity`
  - `Sprite Renderer`
- 右侧 `Emitter Properties`
  - `Local Space` 已启用
  - `Interpolated Spawning` 已启用
  - `Sim Target = CPUSim`
  - `Calculate Bounds Mode = Dynamic`
- 右侧 `Emitter State`
  - `Life Cycle Mode = Self`
  - `Loop Behavior = Infinite`
  - `Loop Duration = 2.0`
- 右侧 `Spawn Rate`
  - `SpawnRate = 2.0`
  - `Spawn Probability = 1.0`
- `Initialize Particle` 当前可见寿命参数
  - `Lifetime Mode = Random`
  - `Lifetime Min = 2.0`
  - `Lifetime Max = 4.0`

- 本图结论：
  - 作者此步开始单独搭建一个 `Stars` 粒子层，用较低的持续生成速率和 `2-4` 秒随机寿命，让少量星点在 Aura 周围持续存在。
  - 模块链同时包含 `Shape Location Sphere`、速度、阻力和尺寸/颜色缩放，说明这层不是静态贴片，而是准备做成从球形区域发射、带运动和衰减的星点粒子。

### 00:45:37-00:50:18 发射器、速度、颜色

- 本段定位：发射器、速度、颜色。
- 知识点：随机设置 让它们同樣往Y和X的角度看 需要将它们的调整離開 需要更换成一种 可以创造或是用其中一个 需要重新认为这个发射器。
- 知识点：形状位置是在链子上 我们需要它们飞起来 我们需要增加速度 和粹粹的力量 现在它们还在升起来 加上链声 它们会很散开 需要少了一点 可能需要提升尺寸。
- 知识点：并增加亮度 这里也有透明性 你也可以把一个直接的颜色 放在一边 这样它们会是同样的颜色 我们把它们放在一边 放一个 可以加亮度 这里有一个魔法圈。
- 知识点：我还想用这个圈 让它们在地上光亮 我把颜色改变了 并加了亮度 慢慢增加 可以增加全体尺寸 加上随机的线 增加和减少 每秒一次增加 这就是它们的整个样子。
- 知识点：可以把圈的颜色改变了 比如说这样 它太亮了 可以玩它 既然这个颜色太亮了 我们需要改变整体亮度 还需要减少 改变透明度 甚至少 我认为 它应该比较亮。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`发射器`、`速度`、`颜色`、`透明度`。

**关键画面：**

这张图是 `NS_MagicAura_01` 在关卡中的阶段性效果预览，不是 Niagara 内部参数设置图。可确认信息如下：

- 当前场景中选中了：
  - `NS_MagicAura_01 (Instance)`
- 右侧实例 Transform 仍为默认值：
  - `Location = (0, 0, 0)`
  - `Rotation = (0, 0, 0)`
  - `Scale = (1.0, 1.0, 1.0)`
- 视口中已经能看到的效果层包括：
  - 角色脚下两圈浅金白色发光圆环
  - 圆环内部与角色周围出现多条竖向金色光束
  - 光束从地面向上延伸，覆盖角色脚部到身体中上部附近
  - 地面底座仍保持较亮的环状发光中心
- 视觉关系：
  - 竖向光束不是单根居中柱，而是分布在角色周围的多条窄光带
  - 光束颜色与地面光环统一为暖金色，而不是上一段参考图里的冷蓝色

- 本图结论：
  - 到这一步，`Rays` 一类的竖向发光层已经加入系统，并与原有地面双环 Aura 成功叠加。
  - 这一层的目标是强化角色周围“向上升起”的能量感，而不是替代底部光圈。
这是 `NS_MagicAura_01` 的系统总览调整图，重点是发射器结构发生了重组。可确认信息如下：

- 当前系统内可见发射器列表：
  - `Glows`
  - `MagicCircle`
  - `MagicCircle001`
  - `Rays`
- 当前选中发射器：
  - `Glows`
- `Glows` 发射器的可见模块链：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Shape Location Ring / Disc`
  - `Add Velocity Linear`
  - `Particle State`
  - `Scale Sprite Size`
  - `Scale Color`
  - `Curl Noise Force`
  - `Solve Forces and Velocity`
  - `Sprite Renderer`
- 与上一批相比可直接确认的变化：
  - 先前截图里的 `Stars` 发射器，此时已经不存在于可见列表中
  - 系统新增了一个 `MagicCircle001`
  - 另有一个新的发射器被命名为 `Glows`
- 结构语义：
  - `Glows` 仍从 `Ring / Disc` 区域生成，而不是球形区域
  - 相比上一批 `Stars` 的 `Shape Location Sphere` 与 `Drag` 组合，这里改成了 `Add Velocity Linear + Curl Noise Force + Solve Forces and Velocity`
  - 说明作者把这一层从“球形星点漂浮”方向，重新组织成更适合地面或环形区域发光粒子漂移的结构

- 本图结论：
  - 这一阶段作者已经重新考虑发射器职责，把原先的试验层改造成 `Glows`，并通过独立的 `MagicCircle001` 与 `Rays` 分层协作。
  - 截图没有展开具体数值参数，因此这里只记录模块结构变化，不补写速度、颜色或透明度数值。
这张图展示的是 `NS_MagicAura_01` 在内容浏览器中切换发光材质实例后的效果预览。可确认信息如下：

- 当前场景中选中了：
  - `NS_MagicAura_01 (Instance)`
- 内容浏览器路径位于：
  - `Content > VFX_Library > Materials > Instances`
- 当前高亮选择的材质实例是：
  - `MI_GlowAura_01`
- 同目录仍可见其他候选材质实例，包括：
  - `MI_AuraGlow_02`
  - `MI_CircleAura_01`
  - `MI_Glow_01`
  - `MI_Glow_02`
  - `MI_MagicArea_01`
  - `MI_RayAura_01`
  - `MI_StarAura_01`
- 视口中的实时效果变化：
  - 地面原本较细的双环，已经变成更厚、更柔和的暖黄色发光底座
  - 外圈边缘出现更明显的模糊辉光，而不是清晰锐利的线框
  - 角色周围的竖向金色光束仍然保留

- 本图结论：
  - 作者此步在尝试用 `MI_GlowAura_01` 替换或对比当前 Aura 材质，以得到更柔和、更有体积感的地面发光层。
  - 截图没有显示 Niagara 内部具体绑定到哪个 `Sprite Renderer`，也没有显示材质实例参数面板，因此这里只记录材质候选切换与视口结果，不补写未显示的亮度或透明度数值。

### 00:50:18-00:54:59 Material、UV、粒子

- 本段定位：Material、UV、粒子。
- 知识点：我只会把深度浪放在它上 因为在地上没有必要浪浪 需要减少亮度 编辑得很好 可能需要增加了 全体的数量 比如说亮度 可以加点拉锋 让它们慢慢减少。
- 知识点：现在我们来谈谈锋面 这个也很有趣 需要加一张锋面 已经有锋面的锋面 但需要用一个空的 我们不需要锋面 这里我们有一个锋面的选项 需要把它们改成自己。
- 知识点：我只会提示它 让锋面改成自己 我们把锋面刷到一秒 看看它们的等级 我们把3D的锋面刷到一秒 我们换一个标题 Ctrl 去到锋面刷 它这里有双方。
- 知识点：这将会是一个锋面的系数 可以加更多的物件 但我们需要一个 我们不需要更多 可以加几笔3D物件 并选择一个 就是这些3D物件 我们通常都不需要。
- 知识点：根据普通的标题 我们有一个3D物件 它们可以展示一个地球 可以选择这个圆形或任何一个定位的物体 或是会飛翔的磚椅 所有东西都跟粒子一樣。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Material`、`粒子`。

**关键画面：**

这张图展示的是 `NS_MagicAura_01` 在内容浏览器中继续切换地面光晕材质实例后的效果预览。可确认信息如下：

- 当前场景中选中了：
  - `NS_MagicAura_01 (Instance)`
- 内容浏览器路径位于：
  - `Content > VFX_Library > Materials > Instances`
- 当前高亮选择的材质实例是：
  - `MI_GlowAuraGround_01`
- 顶部已打开的资源页签可见：
  - `MI_GlowAura_01`
  - `MI_GlowAuraGround_01`
- 视口中的实时效果变化：
  - 角色脚下的底部发光层由偏环状轮廓，变成更实心、更饱满的圆形光斑
  - 发光底座中心亮度更高，外缘向外平滑衰减
  - 原本较清晰的双环结构在视觉上被更大面积的地面辉光覆盖
  - 角色周围的竖向暖金色光束仍然保留

- 本图结论：
  - 作者此步在尝试把地面 Aura 材质切换到 `MI_GlowAuraGround_01`，以获得更适合贴地的圆形辉光，而不是只保留细线圆环。
  - 截图没有显示具体 Renderer 绑定槽位或材质实例内部参数，因此这里只记录材质候选切换与结果变化，不补写未显示的数值。
这是 `NS_MagicAura_01` 的系统结构调整图，重点是新增了一个使用 `Mesh Renderer` 的发射器。可确认信息如下：

- 当前系统内可见发射器列表：
  - `Empty`
  - `Glows`
  - `MagicCircle`
  - `MagicGlow_Ground`
  - `Rays`
- 当前选中发射器：
  - `Empty`
- `Empty` 发射器的可见模块链：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Particle State`
  - `Mesh Renderer`
- 右侧 `Mesh Renderer` 已显示的设置：
  - `Meshes` 只有 `1 Array element`
  - `Index [0]` 绑定的网格是 `S_Gnomon`
  - `Enable Material Overrides` 未启用
  - `Source Mode = Particles`
  - `Locked Axis Enable` 未启用
  - `Enable Mesh Flipbook` 未启用
  - `Facing Mode = Default`
  - `Sort Mode = None`
- 结构语义：
  - 这一层不是 Sprite 渲染，而是改用 Mesh 渲染路径
  - 当前所用的 `S_Gnomon` 更像是一个方向/坐标轴测试网格，用于先确认 Mesh Renderer 能否正常实例化与朝向

- 本图结论：
  - 作者此步开始测试 `Mesh Renderer` 粒子层，为后续把 Aura 中某一层改成 3D 网格表现做准备。
  - 由于截图没有展开 `Initialize Particle` 或网格缩放/旋转参数，这里只记录已确认的渲染器类型与测试网格，不补写未显示的 UV 或 Mesh 参数。
这是 `NS_MagicAura_01` 中 `Empty` 网格发射器继续成形后的设置图，作者已经把调试网格替换成圆柱体，并给它指定了发光材质。可确认信息如下：

- 当前系统内可见发射器列表：
  - `Empty`
  - `Glows`
  - `MagicCircle`
  - `MagicGlow_Ground`
  - `Rays`
- 当前选中发射器：
  - `Empty`
- `Empty` 发射器当前可见模块链：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Add Velocity Linear`
  - `Particle Update`
  - 当前正在通过 `Add new Module` 搜索 `scale`
- `Mesh Renderer` 已显示的设置：
  - `Meshes[Index 0] = SM_Cylinder_01`
  - `Enable Material Overrides` 已启用
  - `Override Materials` 有 `1 Array element`
  - `Explicit Mat = MI_Flame_01`
  - `User Param Binding = None`
  - `Source Mode = Particles`
  - `Locked Axis Enable` 未启用
  - `Enable Mesh Flipbook` 未启用
  - `Facing Mode = Default`
  - `Sort Mode = None`
- 视口中的即时结果：
  - 左侧预览里能看到一列暖色小圆环/截面，说明当前网格粒子已开始在空间中按一定间距生成
- 当前操作语义：
  - 字幕明确说明“现在我们有了用我们的材料生成的圆柱体”
  - 搜索结果中可见作者准备继续添加 `Scale Mesh Size`、`Scale Mesh Size by Speed` 或 `Scale Sprite Size` 一类的尺寸控制模块

- 本图结论：
  - 这一层已经从“Mesh Renderer 测试”推进到“用 `SM_Cylinder_01` + `MI_Flame_01` 生成实际圆柱光束/柱体”的阶段。
  - 下一步明显是在补尺寸缩放逻辑，但本图还没显示最终采用哪一个 `scale` 模块，因此这里只记录当前可见的网格、材质覆盖和模块补充动作。

### 00:54:59-00:58:49 Renderer、Mesh Renderer、Mesh

- 本段定位：Renderer、Mesh Renderer、Mesh。
- 知识点：但它会是Scale Mesh Size 它是叫做不同的 Mesh是三个元素,它有一个三角形的Scale 我们需要将这个三角形的物体轉为一條浮動。
- 知识点：可以控制三个元素的位置 可以在这里设置一个彎曲,然后可以Scale 鏡頭飛了,我按下F,它飛了上去 在这里可以设置Scale。
- 知识点：Mod,设置它的Size 1是一樣的標準,可以选择15 变成巨大,可以被转换,全部都一樣 可以改变存在的时间 LODs,不要注意它。
- 知识点：可以分別控制Scale的角度 可以增加,例如,也可以转换 可以改变它的Pivot,Pivot现在在下面 它的颜色可以被控制,如果物体有颜色控制。
- 知识点：我们使用这个圖案,準備好了 然后就是結果 它減少了,然后慢慢地消失了 可以存在3D物体,標準的3D物体 它们并不看着鏡頭 它们并不看着鏡頭,它们是無限的。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 核对对象：`Mesh Renderer`、`Renderer`、`颜色`。

**关键画面：**

这是 `NS_MagicAura_01` 中 `Empty` 网格发射器的 `Scale Mesh Size` 设置图，当前重点是把网格尺寸控制改成可动态输入的向量缩放。可确认信息如下：

- 当前系统内可见发射器列表：
  - `Empty`
  - `Glows`
  - `MagicCircle`
  - `MagicGlow_Ground`
  - `Rays`
- 当前选中发射器：
  - `Empty`
- `Empty` 发射器当前可见模块链：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Add Velocity Linear`
  - `Solve Forces and Velocity`
  - `Particle State`
  - `Scale Mesh Size`
  - `Mesh Renderer`
- 右侧 `Scale Mesh Size` 当前已显示：
  - `Scale Factor = (1.0, 1.0, 1.0)`
  - `Initial Mesh Scale` 正在切换为动态输入
- 动态输入搜索状态：
  - 搜索框输入的是 `f`
  - 候选项里可见：
    - `Vector from Curve`
    - `Vector from Float`
    - `Multiply Vector by Float`
    - `Scale Float by Curve`
    - `Select Vector From Array`
    - `Transform Vector`
    - `Transform Vector by Matrix`

- 尺寸语义：
  - 当前操作不是简单把网格整体统一放大，而是在为 `Initial Mesh Scale` 选择一个向量输入来源，准备分别控制 Mesh 在多个轴向上的尺寸比例。
  - 结合本段标题和字幕语境，可确定作者在把原本测试用的网格柱体变成可按轴拉伸的 3D 发光柱。

- 本图结论：
  - `Empty` 的 Mesh 粒子已经进入 `Scale Mesh Size` 阶段，下一步是用向量型缩放输入控制柱体长宽高，而不是继续停留在默认 `(1,1,1)` 尺寸。
这是 `NS_MagicAura_01` 中 `Empty` 网格发射器的 `Scale Color` 模块设置图，当前重点是把颜色保持不变、只用曲线控制透明度衰减。可确认信息如下：

- 当前选中发射器：
  - `Empty`
- 当前系统内仍可见的发射器列表：
  - `Empty`
  - `Glows`
  - `MagicCircle`
  - `MagicGlow_Ground`
  - `Rays`
- `Empty` 发射器当前可见模块链：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Add Velocity Linear`
  - `Solve Forces and Velocity`
  - `Particle State`
  - `Scale Mesh Size`
  - `Scale Color`
  - `Mesh Renderer`
- 右侧 `Scale Color` 已显示的设置：
  - `Scale Mode = RGB and Alpha Separately`
  - `Scale RGB = (1.0, 1.0, 1.0)`
  - `Scale Alpha = Float from Curve`
  - 曲线数据类型：`Curve for Floats`
  - 曲线索引来源：`PARTICLES.NormalizedAge`
  - `Scale Curve = 1.0`
- Alpha 曲线形状：
  - 出生后先快速升高到较高可见度
  - 随后在生命周期后段持续缓慢下降
  - 末尾接近低值或接近消失

- 透明度语义：
  - 因为 RGB 缩放固定为 `1.0`，这一层不会在生命周期内改色，只会通过 Alpha 曲线控制出现和消散节奏。
  - 这正对应本段讲的 3D 物体“会慢慢消失”的结果，而不是一直保持同样亮度。

- 本图结论：
  - `Empty` 这层 Mesh 光柱的显隐方式，是先快速显现，再在剩余寿命中逐步淡出。
  - 当前截图没有显示具体 Mesh 缩放数值，但已经明确了该层的透明度曲线控制逻辑。
这是 `NS_MagicAura_01` 中 `Empty` 网格发射器继续补充朝向控制后的设置图。可确认信息如下：

- 当前选中发射器：
  - `Empty`
- 当前系统内仍可见的发射器列表：
  - `Empty`
  - `Glows`
  - `MagicCircle`
  - `MagicGlow_Ground`
  - `Rays`
- `Empty` 发射器当前可见模块链：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Add Velocity Linear`
  - `Initial Mesh Orientation`
  - `Solve Forces and Velocity`
  - `Particle State`
  - `Scale Mesh Size`
  - `Scale Color`
  - `Mesh Renderer`
- 右侧 `Initial Mesh Orientation` 已显示的设置：
  - `Mesh Orientation Mode = Random`
  - `Rotations = (0.0, 0.0, 0.0)` 当前为默认显示值
  - `Rotation Coordinate Space = Mesh`

- 朝向语义：
  - 这一层不是让 Mesh 固定保持单一方向，而是在粒子出生时给予随机初始朝向。
  - 由于 `Rotation Coordinate Space` 是 `Mesh`，可理解为围绕网格自身坐标系处理初始朝向，而不是直接按世界或相机方向锁定。

- 本图结论：
  - `Empty` 这层 3D Mesh 粒子除了速度、尺寸和透明度外，又补上了随机初始朝向，用来打破所有圆柱体完全同向时的机械感。
  - 当前截图没有展开随机角度范围的更多输入，因此这里只记录已确认的 `Random` 朝向模式，不补写未显示的旋转分布细节。

### 01:00:01-01:04:46 关键流程 14

- 本段定位：关键流程 14。
- 知识点：可以这樣轉動 这些價值分別從0到1,这些是正常價值 0是0度,1是3和60度 它是170度,它会被下降 我们稍後会處理它的擴展空间。
- 知识点：它现在不需要 这是你能够在3D物体中緩解的方式 可以轉動它,例如,如果我们想它 随机地轉向Z的位置 Range Vector,这里所有东西都会一樣。
- 知识点：它会随机地轉向 我只会随机地轉向一个物体 需要示範,随机地轉向时 它会随机地轉向 这里是一种随机地轉向 第二种随机地轉向 这里是Z的位置。
- 知识点：所有3D物体都会随机地轉向 这是你能够處理的方式 我们有这个物体 我们要注意它在这里結束 我还在編輯,0.9 可以用这个火力嗎? 需要把这个火力拼上。
- 知识点：它会被下降,需要把它拼上 需要把颜色圖案改变 我们需要的颜色会变成相似 我正在尋找适合的颜色。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这是 `NS_MagicAura_01` 中 `Empty` 网格发射器的 `Initial Mesh Orientation` 具体数值调整图。可确认信息如下：

- 当前选中发射器：
  - `Empty`
- `Empty` 发射器当前可见模块链：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Add Velocity Linear`
  - `Initial Mesh Orientation`
  - `Particle State`
  - `Scale Mesh Size`
  - `Scale Color`
  - `Mesh Renderer`
- 右侧 `Initial Mesh Orientation` 已显示的设置：
  - `Mesh Orientation Mode = None`
  - `Rotation = (0.25, 0.0, 0.0)`
  - `Rotation Coordinate Space` 已启用
- 当前输入帮助说明明确指出：
  - 旋转值采用 `0-1` 的归一化表示
  - `1` 代表绕某一轴完整旋转一周

- 旋转语义：
  - `Rotation.X = 0.25` 等价于绕对应轴旋转四分之一圈，也就是约 `90` 度。
  - 这一层因此不再依赖纯随机朝向，而是给 Mesh 柱体设定一个稳定的初始转向，用于把圆柱或环形片正确摆到需要的方向。

- 视口结果：
  - 左侧预览中可见暖金色环状/弧形片段，说明旋转改动已经直接影响当前 Mesh 粒子的可见朝向。

- 本图结论：
  - 作者开始把 `Initial Mesh Orientation` 从随机试验转向可控的固定旋转，并用归一化旋转值精确调整 3D Mesh 的摆放方向。
这是 `NS_MagicAura_01` 中新的 `AuraMesh` 发射器设置图，重点是直接在 `Initialize Particle` 里控制 Mesh 初始缩放。可确认信息如下：

- 当前系统内可见发射器列表：
  - `AuraMesh`
  - `Glows`
  - `MagicCircle`
  - `MagicGlow_Ground`
  - `Rays`
- 当前选中发射器：
  - `AuraMesh`
- `AuraMesh` 发射器当前可见模块链：
  - `Emitter State`
  - `Spawn Burst Instantaneous`
  - `Initialize Particle`
  - `Add Velocity Linear`
  - `Initial Mesh Orientation`
  - `Solve Forces and Velocity`
  - `Particle State`
  - `Scale Mesh Size`
  - `Scale Color`
  - `Mesh Renderer`
- 右侧 `Initialize Particle` 已显示的设置：
  - `Lifetime Mode = Direct Set`
  - `Lifetime = 5.0`
  - `Color Mode = Unset`
  - `Position Mode = Simulation Position`
  - `Mass Mode = Unset / (Mass of 1)`
- `Mesh Attributes`
  - `Mesh Scale Mode = Uniform`
  - `Mesh Uniform Scale = 0.9`
  - `Mesh Renderer Array Visibility Mode = Unset`

- 结构语义：
  - 这一层不再叫 `Empty`，而是被整理成更有语义的 `AuraMesh` 发射器。
  - 与后续再乘一个缩放曲线不同，这里先在 `Initialize Particle` 中给所有 Mesh 粒子统一设置一个初始基础尺寸。
  - 字幕也直接说明当前仍在编辑这个值，并临时使用 `0.9`。

- 本图结论：
  - 作者此步先把 `AuraMesh` 的网格粒子基础尺寸设为接近原始模型的 `0.9` 倍，并保持较长的 `5` 秒寿命，为后续再叠加朝向、颜色或衰减做底层基准。
这张图展示的是 `NS_MagicAura_01` 在场景中继续筛选材质实例并核对 3D Mesh 落地方向的过程，不是 Niagara 参数面板。可确认信息如下：

- 内容浏览器路径位于：
  - `Content > VFX_Library > Materials > Instances`
- 当前高亮选择的材质实例是：
  - `MI_AuraZone_01`
- 同目录仍可见的相关材质实例包括：
  - `MI_AuraGlow_02`
  - `MI_BasicMapGround_01`
  - `MI_CircleAura_01`
  - `MI_Fire_01`
  - `MI_Fire_02`
  - `MI_Flame_01`
  - `MI_Flame_02`
  - `MI_Flame_03`
  - `MI_Glow_01`
  - `MI_Glow_02`
  - `MI_GlowAura_01`
  - `MI_GlowAuraGround_01`
  - `MI_MagicArea_01`
  - `MI_RayAura_01`
  - `MI_StarAura_01`
- 视口中的可见状态：
  - 镜头拉近到角色脚边附近
  - 地面上可见一个绿色箭头形 3D 物体/调试网格，指向角色外侧
  - 画面主体是在检查该 3D 元素相对角色和地面的朝向、位置与落点

- 场景语义：
  - 结合本段前后内容，可理解为作者一边挑选更合适的 Aura/Zone 材质，一边观察 3D Mesh 元素在场景中的实际朝向是否符合预期。
  - 这张图没有显示该材质绑定到了哪个 Renderer，也没有显示 Niagara 中对应的颜色或透明度参数。

- 本图结论：
  - 当前阶段作者在 `Instances` 目录中尝试 `MI_AuraZone_01` 一类的材质候选，并通过近景视口检查 Mesh 元素的地面朝向和空间落位。
  - 截图缺少直接的绑定关系与参数面板，因此这里只记录材质候选和场景核对动作，不补写未显示的材质连接或颜色数值。

### 01:04:46-01:09:20 关键流程 15

- 本段定位：关键流程 15。
- 知识点：这顆物体在一秒內生存 就这樣 如果需要它在一秒內生存 这东西会显示 当它在一秒內生存 它会殺掉这顆物体的状态 如果我不想它殺掉 需要把这东西切掉。
- 知识点：这顆物体在一秒內生存 就这樣 它不会破坏它 它会永遠存在 需要增加深度的減少 需要增加它在这里 不均衡的減少是什么意思 这里我们把所有的颜色都放在0.9。
- 知识点：我们需要调整高度 目标是高度会变小 需要把它切成半 我只要调整高度 需要用0.7 需要用小的減少 我还会把颜色圖圖換掉。
- 知识点：可以玩玩 甚至可以把颜色改变 你还可以用3D物体 我们再增加它 在这條線上,我们再增加 这是在这区域里创建的 但有一个問題 如果我们开始移动它的影响。
- 知识点：需要有什么樣的結果 当地空间必须设置 这些物体,例如 可以设置每个單位的編碼 可以已经在它中玩了 角色移动,它的位置移动 我还会加。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`生命周期`、`颜色`。

**关键画面：**

这张图是 `NS_MagicAura_01` 在场景中继续筛选材质实例并核对 AuraMesh 落地效果的画面，不是 Niagara 参数设置图。可确认信息如下：

- 当前场景中选中了：
  - `NS_MagicAura_01 (Instance)`
- 内容浏览器路径位于：
  - `Content > VFX_Library > Materials > Instances`
- 当前高亮选择的材质实例是：
  - `MI_AuraZone_01`
- 同目录可见的相关材质实例包括：
  - `MI_AuraGlow_02`
  - `MI_BasicMapGround_01`
  - `MI_CircleAura_01`
  - `MI_Fire_01`
  - `MI_Fire_02`
  - `MI_Flame_01`
  - `MI_Flame_02`
  - `MI_Flame_03`
  - `MI_Glow_01`
  - `MI_Glow_02`
  - `MI_GlowAura_01`
  - `MI_GlowAuraGround_01`
  - `MI_MagicArea_01`
  - `MI_RayAura_01`
  - `MI_StarAura_01`
- 视口中的状态：
  - 镜头仍然靠近角色脚边区域
  - 主要是在观察地面附近的效果位置与角色脚部相对关系
  - 这一帧未展示完整光效全貌，而是偏向近景检查

- 本图结论：
  - 作者在继续对 `MI_AuraZone_01` 一类材质做场景内比对，用于判断 AuraMesh 或地面区域层的实际落地表现是否合适。
  - 由于没有显示 Niagara 模块或材质参数面板，这里只记录材质候选与场景核对动作，不推断未显示的生命周期或颜色数值。
这张图展示的是为 `NS_MagicAura_01` 的 3D 对象层挑选颜色贴图的过程，同时可观察到场景中 AuraMesh 的阶段性结果。可确认信息如下：

- 当前场景中选中了：
  - `NS_MagicAura_01 (Instance)`
- 内容浏览器路径位于：
  - `Content > VFX_Library > Textures > ColorMaps`
- 当前目录中可见大量颜色贴图资源，命名形态包括：
  - `VFX_T_ColorMap_Red_01` 到 `VFX_T_ColorMap_Red_11`
  - `VFX_T_ColorMap_Teal_01` 到多张 `Teal/Turquoise`
  - `VFX_T_ColorMap_Yellow_01` 到多张 `Yellow`
  - 以及白色、紫色、彩虹类 ColorMap
- 视口中的阶段性效果：
  - 角色周围保留暖金色竖向光束和地面双环
  - 角色外部多出一层较大的半透明矩形/柱状体积面，颜色偏暖金
  - 这层体积面明显是 3D 对象层，而不是普通 Sprite 面片
- 字幕明确说明：
  - “You can still use 3D objects.”

- 本图结论：
  - 作者此步在 `ColorMaps` 目录中寻找更合适的颜色渐变贴图，用于给 AuraMesh 或相关 3D 对象层换色。
  - 从当前结果看，3D Mesh 层已经参与最终效果，形成包裹角色的半透明体积光区；但截图没有显示具体是哪张贴图已绑定到哪个材质或 Renderer，因此这里只记录颜色贴图筛选与可见结果。
这是 `NS_MagicAura_01` 中 `AuraMesh` 发射器的 `Scale Mesh Size` 进阶设置图，重点是把 Mesh 缩放改成由曲线驱动，并且只沿 `Z` 轴增长。可确认信息如下：

- 当前系统内可见发射器列表：
  - `AuraMesh`
  - `Glows`
  - `MagicCircle`
  - `MagicGlow_Ground`
  - `Rays`
- 当前选中发射器：
  - `AuraMesh`
- `AuraMesh` 发射器当前可见模块链：
  - `Emitter State`
  - `Spawn Burst Instantaneous`
  - `Initialize Particle`
  - `Add Velocity Linear`
  - `Initial Mesh Orientation`
  - `Solve Forces and Velocity`
  - `Particle State`
  - `Scale Mesh Size`
  - `Scale Color`
  - `Mesh Renderer`
- 右侧 `Scale Mesh Size` 已显示的设置：
  - `Scale Factor = Vector from Float`
  - 其中 `Value = Float from Curve`
  - 曲线数据类型：`Curve for Floats`
  - `CurveIndex = PARTICLES.NormalizedAge`
  - `Scale Curve = 1.0`
  - `Initial Mesh Scale = PARTICLES.INITIAL Scale`
- 可见曲线形状：
  - 出生时从较低值起步
  - 前段快速升高
  - 后段继续缓慢爬升并趋于平台
- 字幕明确说明：
  - 可以“only along the Z coordinate”增长

- 缩放语义：
  - 这里先用单个浮点曲线驱动，再包装成向量输入，目的是把某一轴的 Mesh 尺寸做成随生命周期增长的效果。
  - 结合字幕，可确定当前重点不是整体等比放大，而是让 3D Mesh 主要沿 `Z` 方向逐步拉长。

- 视口结果：
  - 左侧预览中，角色周围的体积光柱从底部向上延伸，符合“只在高度方向增长”的目标。

- 本图结论：
  - `AuraMesh` 这层的高度增长逻辑已经建立：保留初始基础尺寸，再通过 `NormalizedAge` 曲线逐步拉高 Mesh 的 `Z` 向尺度。

### 01:09:20-01:11:24 速度

- 本段定位：速度。
- 知识点：可以把每个值分開来改变 X Y Z 做一个 vector 现在每个值都可以设置 我只想改变Z X和Y都一樣 只要Z增加,它现在永遠活着 穩定的 我们不需要这些设置。
- 知识点：FacingMode是標準的 可以控制 可以也加速度 这是FacingMode的速度。
- 知识点：有趣的結果 通常不会用到 需要用速度 现在3D Object会看着相機 相機的画面是一樣的 通常都是標準的 通常它会駕駛,然后就駕駛。
- 核对对象：`速度`。

**关键画面：**

这是 `NS_MagicAura_01` 中 `AuraMesh` 发射器的 `Scale Mesh Size` 轴向拆分设置图。可确认信息如下：

- 当前系统内可见发射器列表：
  - `AuraMesh`
  - `Glows`
  - `MagicCircle`
  - `MagicGlow_Ground`
  - `Rays`
- 当前选中发射器：
  - `AuraMesh`
- `AuraMesh` 发射器当前可见模块链：
  - `Emitter State`
  - `Spawn Burst Instantaneous`
  - `Initialize Particle`
  - `Add Velocity Linear`
  - `Initial Mesh Orientation`
  - `Solve Forces and Velocity`
  - `Particle State`
  - `Scale Mesh Size`
  - `Scale Color`
  - `Mesh Renderer`
- 右侧 `Scale Mesh Size` 已显示的设置：
  - `Scale Factor = Make Vector`
  - `X = 0.0`
  - `Y = 0.0`
  - `Z = 0.0`
  - `Initial Mesh Scale = PARTICLES.INITIAL Scale`

- 轴向语义：
  - 这里不再使用单一统一缩放值，而是把 Mesh 缩放拆成 `X/Y/Z` 三个独立分量。
  - 这样后续就可以只改变一个方向的尺寸，而让另外两个方向保持不变。
  - 结合本段正文，可确认作者的目标是只让 `Z` 方向增长，`X` 和 `Y` 保持一致或不再变化。

- 视口结果：
  - 左侧预览中，AuraMesh 已表现为少量竖向暖金光柱，符合“主要沿高度方向拉伸”的形态准备。

- 本图结论：
  - 作者此步先完成 Mesh 缩放的三轴拆分，为后续只沿 `Z` 轴控制 3D 光柱高度打基础。
这是 `NS_MagicAura_01` 中 `AuraMesh` 发射器的 `Mesh Renderer` 设置图，当前重点是把 Aura 区域材质正式绑定到圆柱 Mesh 上。可确认信息如下：

- 当前系统内可见发射器列表：
  - `AuraMesh`
  - `Glows`
  - `MagicCircle`
  - `MagicGlow_Ground`
  - `Rays`
- 当前选中发射器：
  - `AuraMesh`
- `AuraMesh` 发射器当前可见模块链：
  - `Emitter State`
  - `Spawn Burst Instantaneous`
  - `Initialize Particle`
  - `Add Velocity Linear`
  - `Initial Mesh Orientation`
  - `Solve Forces and Velocity`
  - `Particle State`
  - `Scale Mesh Size`
  - `Scale Color`
  - `Mesh Renderer`
- 右侧 `Mesh Renderer` 已显示的设置：
  - `Meshes[Index 0] = SM_Cylinder_01`
  - `Mesh Parameter Binding = None`
  - `LODMode = LODLevel`
  - `LOD Level = 0`
  - `Scale = (1.0, 1.0, 1.0)`
  - `Rotation = (0.0°, 0.0°, 0.0°)`
  - `Pivot Offset = (0.0, 0.0, 0.0)`
  - `Pivot Offset Space = Mesh`
  - `Enable Material Overrides` 已启用
  - `Override Materials[Index 0].Explicit Mat = MI_AuraZone_01`
  - `User Param Binding = None`
  - `Source Mode = Particles`
  - `Locked Axis Enable` 未启用
  - `Enable Mesh Flipbook` 未启用
  - `Facing Mode = Default`
  - `Sort Mode = None`

- 结果语义：
  - 这说明 `MI_AuraZone_01` 已不只是内容浏览器里的候选项，而是已经被直接绑定到 `AuraMesh` 的圆柱网格渲染器上。
  - 左侧预览可见包裹角色的暖色半透明体积区域，说明该材质绑定已经开始影响最终显示。

- 本图结论：
  - `AuraMesh` 这层正式采用 `SM_Cylinder_01 + MI_AuraZone_01` 作为 3D 体积光柱/区域的最终渲染组合。
这张图是把 Aura 效果放到角色实例上进行运动状态观察的结果画面，不是 Niagara 参数设置图。可确认信息如下：

- 当前视口右侧选中的对象是：
  - `Gideon_Inquisitor`
  - 详情面板显示的是该角色实例的 `SkeletalMeshComponent`
- 场景中可见的效果层：
  - 角色脚下仍保留双层暖金色发光圆环
  - 角色周围存在多条竖向暖金光束
  - 角色外部还包裹着一层半透明的矩形/柱状 AuraMesh 体积面
- 运动观察结果：
  - 角色身体和 Aura 层都有明显的运动拖影/模糊
  - 体积面与脚下光环整体仍围绕角色中心区域，没有明显脱离到远处
  - 这一帧更像是在检验角色运动或镜头变化时的整体跟随观感，而不是静态摆拍

- 结果语义：
  - 结合本段“速度”语境，这张图用于观察当角色处于移动或动态播放状态时，3D Aura 层与底部光圈是否还能保持协调。
  - 截图没有展开 Niagara 局部空间、速度向量或 Facing 参数，因此不能据此补写未显示的具体数值设置。

- 本图结论：
  - 作者此步已经把 Aura 效果放到真实角色实例上做动态验证，重点检查的是移动时的视觉跟随和整体体积感，而不是继续修改单个模块参数。

## 补充视觉证据

### S01 00:02:33

这是 `NS_MagicAura_01` 最早期 `Fountain` 发射器的补充参数截图，用来补全主时间线截图里没有拍清的基础发射配置。可确认信息如下：

- 当前系统中可见发射器：
  - `Fountain`
- `Fountain` 发射器的可见模块链：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Shape Location Sphere`
  - `Add Velocity in Cone`
  - `Particle State`
  - `Gravity Force`
  - `Drag`
  - `Scale Sprite Size`
  - `Scale Color`
  - `Solve Forces and Velocity`
  - `Sprite Renderer`
- 右侧 `Emitter Properties`
  - `Local Space` 未启用
  - `Interpolated Spawning` 已启用
  - `Sim Target = CPUSim`
  - `Calculate Bounds Mode = Dynamic`
  - `Requires Persistent IDs` 未启用
- 右侧 `Emitter State`
  - `Life Cycle Mode = System`
  - `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
  - `Loop Behavior = Infinite`
  - `Loop Duration = 2.0`
  - `Recalculate Duration Each Loop` 未启用
  - `Loop Delay = 0.0`
- 右侧 `Scalability`
  - `Scalability Mode = System`
- 右侧 `Spawn Rate`
  - `SpawnRate = 90.0`
  - `Spawn Probability = 1.0`
- 右侧 `Initialize Particle > Point Attributes`
  - `Lifetime Mode = Random`
  - `Lifetime Min = 1.4`
  - `Lifetime Max = 1.75`

- 本图结论：
  - 补充图明确了最初 `Fountain` 原型发射器是一个系统生命周期驱动、`2` 秒循环、每秒 `90` 个粒子、寿命约 `1.4-1.75` 秒的 Sprite 粒子喷泉结构。
  - 这张图主要用于复现校准基础节奏和寿命范围，避免只凭主线截图猜测这些底层参数。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。

