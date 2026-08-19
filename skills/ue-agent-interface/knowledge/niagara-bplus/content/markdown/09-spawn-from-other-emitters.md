# 09 Spawn From Other Emitters

# 09 Spawn From Other Emitters

## 关键术语

- `Emitter`、`Spawn`、`Spawn Burst`、`Color`、`Scale Color`、`Ribbon`、`Beam`、`速度`、`+Add`、`Niagara`、`Spawn Rate`、`Lifetime`、`Renderer`、`Add`、`材质`、`Niagara System`、`Particle`、`Initialize Particle`

## 分段知识

### 00:00:06-00:04:40 Emitter、Spawn、Color

- 本段定位：Emitter、Spawn、Color。
- 知识点：现在需要說說Ribbon和Beam的分別 这里有一个準備Ribbon的特殊 Ribbon是由爆破或是爆破的分別 而Beam是由始始和結局分別。
- 知识点：没有爆破、爆破、結局、开始點和結局 我们来看看这部分的材料 我们来看看結果 这里有个颜色的管理,需要把它取走。
- 知识点：有其他设置 任何Ribbon可以变成Beam 这些设置很特别 需要按下Fix,Fix,Fix 可以也可转换这个 转换这个選項给Beam。
- 知识点：本段围绕 `Emitter`、`Spawn`、`Color`、`Scale Color` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：设置了开始點 Beam Start是开始點 开始點在演示开始 这就是演示开始點 我们设置了結局 首先我们设置了开始點 需要设置在X-axis的500个部份。
- 知识点：需要加Spawn Beam 也要加Beam Width来控制它的Width 更新Beam来更新 特别的模組 这里现在控制了这个Width。
- 知识点：我们控制了它透过Beam Width 但如果没有这个模組 可以设置Width控制在这里 现在这就像是一个反应 在实际上更加精確地展示。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 核对对象：`Emitter`、`Spawn`、`Color`、`Scale Color`、`颜色`。

**关键画面：**

这是 `### 00:00:06-00:04:40 Emitter、Spawn、Color` 段的模板选择图，用来从 Niagara 发射器模板库里挑选新的基础发射器，进入 Ribbon 与 Beam 的演示。

- 当前系统标签仍是 `NS_RibbonTest`，但画面中央弹出了 `Add Emitter to your System` 选择窗口。
- 左侧分类树可见：
  - `Recent`
  - `All`（当前选中）
  - `Template`
  - `Learning Content`
- 中间模板网格里可见多个 Niagara Emitter 模板，包括：
  - `BlowingParticles`
  - `CompletelyEmpty`
  - `ConfettiBurst`
  - `DirectionalBurst`
  - `DynamicBeam`
  - `Empty`
  - `Fountain`
  - `GridLocation`
- 底部左侧有 `Add Empty Niagara Emitter` 按钮，右下角有 `Add` 和 `Cancel`。

这张图的作用，是说明新一章从“选什么发射器模板开始”切入：如果要演示 Ribbon 与 Beam 的差异，可以直接从模板库选择像 `DynamicBeam` 这类带 Beam 语义的发射器，或者从 `Empty` / `CompletelyEmpty` 之类的空模板起步再手动搭建模块链。
这是 `### 00:00:06-00:04:40 Emitter、Spawn、Color` 段中的场景锚点图，用来说明 Beam 的“起点与方向”概念，而不是展示 Ribbon 拖尾结果。

- 当前选中对象是 `NS_RibbonTest (Instance)`。
- 右侧 `Transform` 可见：
  - `Location = (1112.0, -647.4, 150.32)`
  - `Rotation = (0.0, 0.0, 0.0)`
  - `Scale = (1.0, 1.0, 1.0)`
- 视口中央最明显的是控制器和一根沿正右方向伸出的绿色箭头，画面中没有可见的长 Ribbon 拖尾。
- 结合本段正文关于 `Beam Start`、起点、终点以及 X 轴方向设置的说明，这张图承担的是“先确定 Beam/发射方向语义”的作用：发射效果会从当前控制点出发，沿指定方向或朝向参数延伸。

这张图本身没有给出 Beam 长度、宽度或颜色的面板数值，只能确认教程正在把注意力从 Ribbon 的路径残留转到 Beam 的起点/方向控制。
这是 `### 00:00:06-00:04:40 Emitter、Spawn、Color` 段中的 Beam 结果验证图，用来确认教程已经把效果从单纯的起点方向演示推进到“终点可控”的 Beam 形态。

- 当前选中对象是 `NS_RibbonTest (Instance)`。
- 右侧 `Transform` 可见：
  - `Location = (1112.0, -647.4, 150.32)`
  - `Rotation = (0.0, 0.0, 0.0)`
  - `Scale = (1.0, 1.0, 1.0)`
- 右侧 `User Parameters` 中可见：
  - `BeamEnd = (500.0, 0.0, 0.0)`
- 视口中可见一条从控制点向右延伸的橙红色发光束体，外侧黄色包围框勾出了一段近似长方形的 Beam 区域。
- 字幕明确说 “Now we can control the endpoint.”，说明本图的核心就是：Beam 不再只是沿某个方向发射，而是已经通过显式的终点参数控制长度和终止位置。

结合正文中“起点”“终点”“X-axis 的 500”描述，可复建为：将 Beam 的终点偏移设置到 X 轴正方向 `500` 单位，生成一条从当前控制点指向该终点的稳定直线 Beam。

### 00:04:40-00:09:32 Spawn、Spawn Burst、Ribbon

- 本段定位：Spawn、Spawn Burst、Ribbon。
- 知识点：可以用用家的分析 现在Beam移动了这个 pivot 如果我设置了这个Beam End 然后我开始移动了开始點 它会继续在这里 因为现在所有的位置。
- 知识点：都设置在开始點上 目标是它们是絕对的 这里有一个很重要的部分 就是Beam End 现在有个很重要的部分 可以控制 絕对的意思是它现在在世界的位置。
- 知识点：如果我设置了0.0 如果我设置了任何一个部份 设置、形状、形状 需要设置0 按照世界的指標 这里是世界的指標中心 世界中心 如果我再加上500个部份。
- 知识点：它会变成3个部份 现在它是对世界的指標相对的計算 在这里需要设置 絕对的Beam End 如果我开始移动这个Beam 这个點会继续在这里。
- 知识点：这个Beam会开始伸延 可以改变颜色 Beam有其他功能 Spawn Burst设置了 为甚麼Spawn。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 核对对象：`Spawn Burst`、`Spawn`、`颜色`。

**关键画面：**

这是 `### 00:04:40-00:09:32 Spawn、Spawn Burst、Ribbon` 段中的 Beam 结果验证图，用来说明当 BeamEnd 采用世界空间绝对坐标时，移动 pivot 后 Beam 会重新指向那个固定终点。

- 当前选中对象是 `NS_RibbonTest (Instance)`。
- 右侧 `Transform` 可见：
  - `Location = (1112.0, -647.4, 150.32)`
  - `Rotation = (0.0, 0.0, 0.0)`
  - `Scale = (1.0, 1.0, 1.0)`
- 右侧 `User Parameters` 中可见 `BeamEnd` 已被设置为一组非零三维值，读图可确认大致为：
  - `X ≈ 1000`
  - `Y ≈ -1006`
  - `Z ≈ 603`
- 视口中可见一条橙红色 Beam 从左下近角色位置斜向上延伸到右上方。
- 字幕明确说 “Now the Beam moves with this pivot.”，结合正文里关于“绝对 Beam End”“世界位置”的说明，可以确认这里正在对比 BeamEnd 作为世界坐标时的行为：起点跟随当前实例移动，但终点仍保持在指定世界位置，因此 Beam 会实时拉伸并重新对准该点。

这张图的核心不是 Ribbon，而是 Beam 的世界空间终点控制逻辑。
这是 `### 00:04:40-00:09:32 Spawn、Spawn Burst、Ribbon` 段中的 Beam 模块链参数图，说明本段已经从普通发射器结构切换到带专用 Beam 模块的配置。

- 当前系统：`NS_RibbonTest`
- 当前发射器：`Empty`
- 发射器状态栏可见：`50 Particles`
- 左下 `User Parameters` 中可见：
  - `BeamEnd = (500.0, 0.0, 0.0)`

当前可见模块链：
- `Emitter State`
- `Beam Emitter Setup`
- `Spawn Burst Instantaneous`
- `Spawn Per Unit`（灰显/未启用）
- `Spawn Rate`（灰显/未启用）
- `Initialize Particle`
- `Add Velocity Linear`
- `Spawn Beam`
- `Beam Width`
- `Solve Forces and Velocity`
- `Particle State`
- `Scale Ribbon Width`
- `Scale Color`
- `Update Beam`
- `Ribbon Renderer`

右侧当前仍停在 `Scale Color`，可确认：
- `Scale Mode = RGB and Alpha Separately`
- `Scale RGB = Make Vector from Linear Color RGB`
- `Color = Color from Curve`
- `ColorCurve` 为接近统一白色的分布
- `Scale Alpha = 1.0`

这张图的重点不在 `Scale Color` 本身，而在 Beam 专用模块已经成型：
- `Beam Emitter Setup` 负责 Beam 语义初始化
- `Spawn Burst Instantaneous` 说明这里更偏向一次性生成，而不是持续时间频率生成
- `Spawn Beam` 与 `Update Beam` 负责真正把粒子组织成 Beam
- `Beam Width` 独立控制光束宽度

也就是说，本段已经进入“用 Burst 生成 Beam，而不是用 Ribbon 持续拖尾”的工作流。
这是 `### 00:04:40-00:09:32 Spawn、Spawn Burst、Ribbon` 段中的 Beam 最终结果验证图，用来说明 `BeamEnd` 用户参数改变后，会统一影响当前 Beam 的终点方向。

- 当前选中对象是 `NS_RibbonTest (Instance)`。
- 右侧 `Transform` 可见：
  - `Location = (-51.06, -806.5, 120.99)`
  - `Rotation = (0.0, 0.0, 0.0)`
  - `Scale = (1.0, 1.0, 1.0)`
- 右侧 `User Parameters` 可见：
  - `BeamEnd = (0.0, 500.0, 0.0)`
- 视口中角色左侧发出一条偏白、带轻微能量纹理的长 Beam，整体沿水平方向向右延伸。
- 字幕明确说 “This module controls all beams simultaneously.”，说明当前被调的是会统一作用于 Beam 集合的终点控制模块/参数，而不是单独只改某一条局部段。

这张图验证了两点：
- `BeamEnd` 改到不同轴向分量后，Beam 的指向会随之改变。
- 这种控制是集中式的，适合作为 Beam 系统的统一终点驱动，而不是像 Ribbon 那样依赖路径残留逐段生成。

### 00:09:32-00:14:22 Niagara、Ribbon、Beam

- 本段定位：Niagara、Ribbon、Beam。
- 知识点：用於Beam的部份 现在需要要 改善一下这个效果 加上一个Ribbon,它会变成Twist 可能会变成相似 这是我们的测试 可以從这層次提升。
- 知识点：并开启这个效果 在最後一集做过的 需要改善 我们去到Niagara 然后製造新的發電機 我们来製造一个空氣的發電機 Self 它会存在不一定。
- 知识点：我们来把它的体積为25公分 一个氣体 需要展示一个Node 叫 轉圈點 它会做什么 轉圈是推動力 也有一个範圍 範圍100,轉圈1 一顆氣体轉向中间。
- 知识点：中间從0 轉圈是推動力 这里改变 轉圈是0 轉圈點它会控制 开始點会是 0是0度,1是3.6度 另一邊是0.5度 我控制它会出现什么 这是一个酷的东西。
- 知识点：例如 加緩速度 形状位置 緩速25公分 需要让它们还在轉 我会展示这个模式的意義 緩速1公分 發電機会存在1秒 但氣体会永遠活動 我把氣体的状态轉了。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 核对对象：`Niagara`、`速度`。

**关键画面：**

这是 `### 00:09:32-00:14:22 Niagara、Ribbon、Beam` 段中的 Beam 发射器结构图，重点是把上一段的 Beam 基础结构继续整理成可扩展的 Niagara 模块链。

- 当前系统：`NS_RibbonTest`
- 当前发射器：`Empty`
- 左下用户参数可见：
  - `BeamEnd = (500.0, 0.0, 0.0)`

当前可见模块链：
- `Emitter State`
- `Beam Emitter Setup`
- `Spawn Burst Instantaneous`
- `Spawn Per Unit`（灰显）
- `Spawn Rate`（灰显）
- `Initialize Particle`
- `Spawn Beam`
- `Add Velocity Linear`（灰显）
- `Beam Width`（灰显）
- `Solve Forces and Velocity`
- `Particle State`
- `Scale Ribbon Width`（灰显）
- `Scale Color`（灰显）
- `Update Beam`
- `Scale Beam Width`
- `Ribbon Renderer`

右侧当前可确认的关键参数：
- `Emitter Properties`
  - `Interpolated Spawning = true`
  - `Sim Target = CPUSim`
  - `Calculate Bounds Mode = Dynamic`
- `Emitter State`
  - `Life Cycle Mode = Self`
  - `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
  - `Loop Behavior = Infinite`
  - `Loop Duration = 1.0`
- `Beam Emitter Setup`
  - `Beam Start = Simulation Position`
  - `Absolute Beam Start = true`
  - `Beam End` 使用 `Convert Vector to Position`
  - `Input Position = USER.BeamEnd`
  - `Absolute Beam End = true`
  - `Use Beam Targets = false`
- `Spawn Burst Instantaneous`
  - `Spawn Count = 100`

这张图说明本段正在把 Beam 的起终点控制和一次性生成逻辑固定下来：
- 起点直接取当前模拟位置
- 终点取用户参数 `BeamEnd`
- 起点和终点都按绝对世界空间解释
- 通过 `Spawn Burst Instantaneous` 一次性生成 `100` 个粒子组织成 Beam

这为后续叠加 Ribbon、旋转力或速度类模块打下了稳定的 Beam 基础。
这是 `### 00:09:32-00:14:22 Niagara、Ribbon、Beam` 段中的参考发射器结构图。教程此时切到现成系统 `NS_MagicAura_01`，借它演示“围绕点旋转”的粒子工作流，而不是继续停留在前面的 Beam 测试系统。

- 当前打开的系统标题为 `NS_MagicAura_01`。
- 当前选中发射器：`Empty`
- 发射器状态栏可见：`1 Particles`
- 左下 `User Parameters` 可见：
  - `Scale Mult = 1.0`

当前发射器可见模块链：
- `Emitter State`
- `Spawn Burst Instantaneous`
- `Initialize Particle`
- `Particle State`
- `Rotate Around Point`
- `Sprite Renderer`

右侧当前停在 `Emitter State`，可确认：
- `Life Cycle Mode = System`
- `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
- `Loop Behavior = Infinite`
- `Loop Duration Mode = Fixed`
- `Loop Duration = 1.0`

底部时间轴中还能看到同一系统里存在多个发射器轨道：
- `AuraMesh`
- `Empty`
- `Glows`
- `MagicCircle`
- `MagicGlow_Ground`
- `Rays`

这张图的价值在于说明本段的思路转变：
- 不再只讨论 Beam 的起终点
- 而是引用一个真实的多发射器 Niagara 系统，重点观察 `Rotate Around Point` 这类力学/轨道模块如何驱动粒子围绕中心旋转
- 之后可以把这种旋转或轨道思路迁移回 Beam / Ribbon 效果里做增强
这是 `### 00:09:32-00:14:22 Niagara、Ribbon、Beam` 段中的资源锚定图，用来明确教程正在参考哪一个现成 Niagara 系统，而不是继续停留在某个局部模块细节。

- 视口中当前选中对象是 `NS_MagicAura_01`。
- 右侧 `NS_MagicAura_01 (Instance)` 的 `Transform` 可见：
  - `Location = (-5.661, 0.0, -0.0)`
  - `Rotation = (0.0, 0.0, 0.0)`
  - `Scale = (1.0, 1.0, 1.0)`
- `User Parameters` 可见：
  - `Scale Mult = 1.0`
- 底部内容浏览器当前路径位于 `Content / VFX_Library / Niagara`。
- 可见的 Niagara System 资源包括：
  - `NS_Fire`
  - `NS_ItemAura_01`
  - `NS_MagicAura_01`（当前高亮）
  - `NS_RibbonTest`

这张图的意义在于把本段的“参考来源”固定下来：教程不是凭空构造旋转思路，而是直接借 `NS_MagicAura_01` 这类现成系统观察其发射器结构，再从中提取可复用的旋转/轨道模块思路去增强 Beam 或 Ribbon 效果。

### 00:14:22-00:17:27 关键流程 04

- 本段定位：关键流程 04。
- 知识点：它必须要设置 地點 现在它能够轉向 在这个位置 需要增加轉圈點 我们把所有东西放在標準 你不需要觸碰它 我会展示你能够 從这个位置 把氣体轉向。
- 知识点：需要製造另一个發電機 空氣發電機 需要加一个視像 让它们都在同一时间 这些都是其他人的 我们不需要 我们不需要自我 需要把它轉向 我们要製造一條圈。
- 知识点：需要设置它的發電機 雖然我不想它 跟着这个氣体 需要加一个文件 叫做 可以從另一个發電機 發電 可以點这里 它会给我们更多的 電子模組。
- 知识点：我们點这里 我们點这里 我们需要定義發電機的名字 從哪里需要發電 需要把它名字 需要問它 这里有个發電率的定義 我们把它设置为100 把它放在这里。
- 知识点：我们把生命值变成0.5 现在看看它有多酷 而且这就是我们 把空氣放在这里 这很重要 因为如果我把它拿走。

**关键画面：**

这是 `### 00:14:22-00:17:27 关键流程 04` 段中的场景锚点图，用来确认参考系统 `NS_MagicAura_01` 在角色附近的基础粒子位置，以及接下来要以它为源继续派生发射行为。

- 当前选中对象是 `NS_MagicAura_01 (Instance)`。
- 右侧 `Transform` 可见：
  - `Location = (-5.661, 0.0, 40.833)`
  - `Rotation = (0.0, 0.0, 0.0)`
  - `Scale = (1.0, 1.0, 1.0)`
- `User Parameters` 可见：
  - `Scale Mult = 1.0`
- 视口中在角色腿部旁边能看到一个被黄色边框包围的白色发光球体，说明当前参考发射器的核心可见对象是单个亮点/球状粒子。
- 底部内容浏览器仍位于 `Content / VFX_Library / Niagara`，当前高亮 `NS_MagicAura_01`，同目录还可见 `NS_Fire`、`NS_ItemAura_01`、`NS_RibbonTest`。

这张图的意义，是把“从哪个现成系统继续做二次发射或环绕效果”固定下来：后续新增发射器或从其他发射器取样时，会围绕这个参考系统里的粒子位置和运动语义展开。
这是 `### 00:14:22-00:17:27 关键流程 04` 段中的发射器编辑图，表示教程已经在 `NS_MagicAura_01` 里新增了一个发射器，并准备给它补上新的生成模块。

- 当前系统标题仍是 `NS_MagicAura_01`。
- 时间轴中新增并选中了一个发射器轨道：`Empty001`。
- 画布中央同时可见两个发射器卡片：
  - `Empty`
  - `Empty001`
- 当前操作点位于 `Empty001` 的 `Emitter Update` 区段，正在点击 `+` 添加模块。

模块添加弹窗当前可确认的信息：
- 启用了 `Library Only`
- 来源过滤包含：
  - `Niagara`
  - `Game`
  - `Plugins`
  - `Developer`
- 搜索结果建议项包括：
  - `New Scratch Pad Module`
  - `Set new or existing parameter directly`
  - `Spawn Burst Instantaneous`
  - `Spawn Per Unit`
  - `Spawn Rate`
- 左侧分类树可见：
  - `Audio`
  - `Beam`
  - `Default`
  - `Emitter`
  - `Location`
  - `MAXScripts`
  - `Math`
  - `Skeletal Mesh`
  - `Spawning`
  - `Sprite`
  - `SubUV`
  - `Utility`

这张图说明当前关键步骤是：在新发射器 `Empty001` 里重新选择合适的生成模块，而不是直接复用旧发射器配置。结合正文“从另一个发射器发电/发射”“定义发射率 100”的描述，可以判断后续会给这个新发射器加上与二次生成相关的模块或生成率设置。
这是 `### 00:14:22-00:17:27 关键流程 04` 段中的完整配置图，展示了如何让新发射器 `Empty001` 从另一个发射器 `Source_Ribbon` 读取粒子并据此生成自己的效果。

- 当前系统：`NS_MagicAura_01`
- 当前选中发射器：`Empty001`
- 画布中可见两个核心发射器：
  - `Source_Ribbon`
  - `Empty001`

`Source_Ribbon` 当前可见模块链：
- `Emitter State`
- `Spawn Burst Instantaneous`
- `Initialize Particle`
- `Shape Location Sphere`
- `Particle State`
- `Rotate Around Point`
- `Sprite Renderer`

`Empty001` 当前可见模块链：
- `Emitter State`
- `Spawn Particles from Other Emitter`
- `Initialize Particle`
- `Sample Particles from Other Emitter`
- `Solve Forces and Velocity`
- `Particle State`
- `Ribbon Renderer`

右侧 `Empty001` 可确认的参数：
- `Emitter Properties`
  - `Local Space = true`
  - `Interpolated Spawning = true`
  - `Sim Target = CPUSim`
  - `Calculate Bounds Mode = Dynamic`
- `Emitter State`
  - `Life Cycle Mode = System`
  - `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
  - `Loop Behavior = Infinite`
  - `Loop Duration = 1.0`
- `Spawn Particles from Other Emitter`
  - `Attribute Reader = Particle Attribute Reader`
  - `Emitter Binding = Other`
  - 绑定的源发射器是 `Source_Ribbon`
  - `Spawn Rate = 100.0`
  - `Calculate Spawn Rate Per Particle = true`
  - `Spawn Rate Per Particle Cap = 100.0`
  - `Spawning Enabled = true`
  - `Minimum Age Spawn Threshold ≈ 0.3333`
  - `Maximum Age Spawn Threshold = 1.0`

结合字幕 “this is how we put local space here.”，本图要表达的是：
- `Empty001` 不是独立随便发射，而是从 `Source_Ribbon` 粒子流中二次发射
- 通过打开 `Local Space`，让这个二次发射器在局部空间中跟随源发射器/宿主移动
- 通过 `Spawn Particles from Other Emitter` 与 `Sample Particles from Other Emitter` 组合，实现“从另一个发射器继承并继续生成 Ribbon/粒子”的工作流

这就是本段关键流程的核心结构。

### 00:19:44-00:24:29 速度

- 本段定位：速度。
- 知识点：需要把它轉向 需要把它轉向 需要減少生命值 從0.1到0.2 或從0.1到0.5 需要把空氣 轉向这个位置 现在它们会这樣發生 看看結果 需要減少生命值。
- 知识点：这很重要 可以把原物 換成新的 把某个質料 我们把颜色換成 我们把它变得更亮 现在它已经显示了 需要增加它的尺寸 需要增加它的尺寸 我还会加速度。
- 知识点：需要加速度 點这里 它应该 应该变成 这是你能做的 我们有这个鋼鋼旋轉 然后鋼鋼是被这个光光 所以它们会從原物 可以轉向它们 它们会变成 它们都会变成。
- 知识点：我们有这个鋼鋼旋轉 可以加速度 所以它们会升上去 需要把它们都換掉 目标是它们会升上去 需要把它都轉向 需要把它減少。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`速度`、`颜色`。

**关键画面：**

这是 `### 00:19:44-00:24:29 速度` 段中的新发射器结构图，说明教程已经从前面的 `Empty001` / `Source_Ribbon` 进一步扩展出一个用于发光粒子的从属发射器 `Glows_FromEmitter`。

- 当前系统：`NS_MagicAura_01`
- 当前选中发射器：`Glows_FromEmitter`
- 左下 `User Parameters` 可见：
  - `Scale Mult = 1.0`

画布中可见的关联发射器：
- `Empty001`
- `Glows_FromEmitter`

`Glows_FromEmitter` 当前可见模块链：
- `Emitter State`
- `Spawn Particles from Other Emitter`
- `Initialize Particle`
- `Sample Particles from Other Emitter`
- `Shape Location`
- `Add Velocity`
- `Particle State`
- `Scale Sprite Size`
- `Scale Color`
- `Curl Noise Force`
- `Drag`
- `Solve Forces and Velocity`
- `Sprite Renderer`

右侧当前停在 `Shape Location`，可确认参数如下：
- `Shape Primitive = Ring / Disc`
- `Ring / Disc Mode = Circle`
- `Ring Radius = 50.0`
- `Ring / Disc Distribution Mode = Random`
- `Disc Coverage = 0.0`
- `U Distribution = 0.0`
- `Transform Order = Scale / Rotate / Offset`
- `Scale Mode = Default`
- `Non Uniform Scale = (1.0, 1.0, 1.0)`
- `Rotation Mode = Default`
- `Rotation Coordinate Space = Local`
- `Offset Mode = None`
- `Shape Origin = STATICCONTEXT.Position`

左侧预览里能看到一圈细小的发光点，说明这个发射器不是直接生成 Ribbon，而是从源发射器粒子位置出发，在一个半径 `50` 的圆形分布上再生成一层 Glows 粒子。

这张图是本段的关键起点：在“从其他发射器生成”的基础上，再通过 `Shape Location + Add Velocity + Curl Noise Force + Drag` 这组模块，让二次粒子围绕源位置形成带速度感的动态光点层。
这是 `### 00:19:44-00:24:29 速度` 段中的发射器细化图，用来说明参考系统里不同发射器的职责分工，以及源发射器当前精灵渲染的朝向设置。

- 当前系统：`NS_MagicAura_01`
- 当前选中发射器：`Source_Ribbon`
- 时间轴中可见的相关发射器包括：
  - `Empty001`
  - `Glows`
  - `Glows_FromEmitter`
  - `MagicCircle`
  - `MagicGlow_Ground`
  - `Rays`
  - `Source_Ribbon`

`Source_Ribbon` 当前可见模块链：
- `Emitter State`
- `Spawn Burst Instantaneous`
- `Initialize Particle`
- `Shape Location Sphere`
- `Particle State`
- `Rotate Around Point`
- `Solve Forces and Velocity`
- `Scale Sprite Size by Speed`
- `Sprite Renderer`

旁边还能看到 `Empty001` 继续保留：
- `Spawn Particles from Other Emitter`
- `Initialize Particle`
- `Sample Particles from Other Emitter`
- `Solve Forces and Velocity`
- `Particle State`
- `Scale Color`
- `Scale Ribbon Width`
- `Ribbon Renderer`

右侧 `Sprite Renderer` 可确认的参数：
- `Material = MI_AuraGlow_02`
- `Source Mode = Particles`
- `Alignment = Velocity Aligned`
- `Facing Mode = Automatic`
- `Macro UVRadius = 0.0`
- `Default Pivot in UV Space = (0.5, 0.5)`
- `Remove HMD Roll = false`
- `Pixel Coverage Mode = Automatic`
- `Pixel Coverage Blend = 1.0`
- `Min Facing Camera Blend Distance = 0.0`
- `Max Facing Camera Blend Distance = 0.0`
- `Sort Mode = None`
- `Renderer Visibility = 0`

这张图的重点不是场景结果，而是确认：
- 源发射器 `Source_Ribbon` 的精灵朝向是 `Velocity Aligned`
- 教程正在通过速度对齐的精灵、随后叠加速度与尺寸变化，来让粒子在运动方向上更有流动感
- 新的 Ribbon/从发射器生成层，建立在这个源发射器运动与朝向语义之上
这是 `### 00:19:44-00:24:29 速度` 段的场景结果验证图，用来检查速度、亮度和附加粒子层叠加后，角色脚下的魔法光环是否形成完整可读的效果。

- 当前选中对象是 `NS_MagicAura_01 (Instance)`。
- 右侧 `Transform` 可见：
  - `Location = (-5.661, 0.0, 0.0)`
  - `Rotation = (0.0, 0.0, 0.0)`
  - `Scale = (1.0, 1.0, 1.0)`
- `User Parameters` 可见：
  - `Scale Mult = 1.0`
- 视口中角色脚下已经出现完整的金黄色效果层：
  - 地面有一圈明亮的圆环
  - 脚边向上延伸出数道竖向半透明光柱/光幕
  - 光柱内部可见更亮的核心区域，整体亮度明显高于地面环境
- 结合前两张图的发射器结构，可以判断这些视觉层来自多个发射器协同：源粒子、二次生成粒子、Glows 层与地面/环形层共同叠加，速度和颜色设置让它们不只是静态光斑，而更接近持续流动的魔法立场。

这张图完成了本段闭环：在引入速度相关模块、速度对齐精灵和二次发射结构后，最终得到的是一个围绕角色底部展开、带向上动势的金色魔法光环效果。

### 00:24:29-00:26:40 关键流程 06

- 本段定位：关键流程 06。
- 知识点：这鋼鋼旋轉 它会变成它们会出现 当我开始移动它 目标是它会变成这个样子 要做的就是,有个很棒的东西叫sign。
- 知识点：现在需要展示它如何行动。
- 知识点：首先,需要展示转向中心。
- 知识点：需要把它只移动在Kornati。
- 知识点：我们需要把这个位置移到一个极端。

**关键画面：**

这是 `### 00:24:29-00:26:40 关键流程 06` 段中的“场景结果 + 局部参数”对照图，用来说明角色脚下的魔法光环效果已经结合 `Source_Ribbon` 的形状/朝向控制，并开始讨论如何把粒子推向某个中心或极端位置。

- 场景中当前仍选中 `NS_MagicAura_01 (Instance)`。
- 右侧 `Transform` 可见：
  - `Location = (-5.661, 0.0, 0.0)`
  - `Rotation = (0.0, 0.0, 0.0)`
  - `Scale = (1.0, 1.0, 1.0)`
- `User Parameters` 可见：
  - `Scale Mult = 1.0`

左侧主视口可见的结果：
- 角色脚下保持一圈金色光环与数道竖直光柱。
- 效果已经具有明显的“向上抬升”和围绕中心聚拢的趋势。

中间小窗显示的是 `NS_MagicAura_01` 的编辑界面，当前选中发射器为 `Source_Ribbon`。右侧可辨认的局部设置包括：
- `Radius = 100.0`
- `Rotation = (0.0, 0.0, 108...)`
- `Derive the ... = true`（完整字段名未完全显示）
- `X Axis = (1.0, 0.0, 0.0)`
- `Y Axis = (0.0, 1.0, 0.0)`

这张图可可靠表达的重点是：
- 本段开始在源发射器的形状/旋转基准上做调整
- 半径级别在 `100` 左右
- 通过旋转与轴向设置，把粒子分布推向中心周围的某个方向性布局
- 目标是让角色脚下的环状/柱状效果更有“转向中心”和“被拉向极端位置”的动态感
这是 `### 00:24:29-00:26:40 关键流程 06` 段中的 `Rotate Around Point` 核心参数图，教程在这里把旋转中心的位置做成随时间变化的函数，而不是固定常量。

- 当前系统：`NS_MagicAura_01`
- 当前选中发射器：`Source_Ribbon`
- `Empty001` 当前被临时禁用，说明此时在单独调试源发射器的旋转行为。

`Source_Ribbon` 当前可见模块链：
- `Emitter State`
- `Spawn Burst Instantaneous`
- `Initialize Particle`
- `Particle State`
- `Rotate Around Point`
- `Solve Forces and Velocity`
- `Sprite Renderer`

右侧 `Rotate Around Point` 可确认的设置：
- `Rotation Amount`
  - `Rotation Phase = 0.0`
  - `Rotation Rate = 1.0`
- `Setup`
  - `Set Particle Position = true`
  - `Radius = 100.0`
- `Rotation Center = Convert Vector to Position`
  - `Input Position = Make Vector`
  - `X = 0.0`
  - `Y = 0.0`
  - `Z = Sine`
    - `Normalized Angle = EMITTER.Age`
    - `Period = 1.0`
    - `Scale = 25.0`
    - `Bias = 0.0`
  - `Conversion Operation = Passthrough as Non Large World Position`
  - `Derive the Rotation Axis = true`
  - `X Axis = (1.0, 0.0, 0.0)`
  - `Y Axis = (0.0, 1.0, 0.0)`

这张图的关键意义是：
- 旋转中心本来在 `(0,0,0)`，现在只让 `Z` 轴由 `Sine(EMITTER.Age)` 驱动
- 这样旋转中心会随时间在上下方向往复移动，振幅由 `Scale = 25.0` 控制
- 粒子围绕这个“会上下波动的中心”旋转，因此整体效果会出现更有生命感的升降和摆动，而不是死板地绕固定圆心打转
这是 `### 00:24:29-00:26:40 关键流程 06` 段里的辅助说明图，不是 Unreal 界面，而是作者用 `Desmos` 演示 `sin` 函数如何驱动发射器/旋转中心位置随时间变化。

图中可见的函数与变量：
- 主公式写成近似形式：
  - `(sin(t) + b) * s`
- 下面提供了可调变量滑块：
  - `t = 0`
  - `b = 0`
  - `s = 1`
  - `p = 1`
- 还单独列出了 `sin(t)`。

这张图要表达的是：
- `t` 可理解为时间推进，对应前一张 Niagara 里 `EMITTER.Age`
- `sin(t)` 会在一个周期内从正到负来回变化，因此适合做“上下摆动”“往复偏移”这类运动
- `b` 相当于偏移量（Bias），可以整体抬高或压低曲线
- `s` 相当于缩放量（Scale），控制振幅大小
- `p` 相当于周期/频率控制，用来决定摆动快慢

把这层含义映射回 Niagara，就是前一张 `Rotate Around Point` 里对 `Z = Sine` 的设置：
- 用 `EMITTER.Age` 作为输入时间
- 用 `Period` 控制循环快慢
- 用 `Scale` 控制上下波动幅度
- 用 `Bias` 控制中心基线位置

因此，本图的作用是帮助理解：为什么把旋转中心的 `Z` 值接到 `Sine` 后，粒子会围绕一个不断上下起伏的中心运动。

### 00:27:53-00:32:31 关键流程 07

- 本段定位：关键流程 07。
- 知识点：我们逐渐过时, 和时间一样,从-1到1。
- 知识点：这是我们的Sign。
- 知识点：有一个sign的方法。
- 知识点：在这个方法中,有一个时间,一个数字和一个数字。
- 知识点：这是数字,数字,这是数字。
- 知识点：我们有这个sign。
- 知识点：在数字上,这是加数。

**关键画面：**

这是 `### 00:27:53-00:32:31 关键流程 07` 段中的 Desmos 辅助图，继续说明作者如何用简单函数理解 Niagara 中随时间变化的数值。

- 当前公式仍写成近似形式：
  - `(sin(t) + b) * s`
- 左侧可见当前滑块与变量值：
  - `t = 78.796`
  - `b = 0`
  - `s = 1`
  - `p = 1`
- 页面中央显示的是一条标准正弦曲线，当前取值点对应的函数结果约为 `-0.233...`。

这张图的重点不是 Unreal 参数本身，而是帮助理解几个基础事实：
- `sin(t)` 的输出天然落在 `-1` 到 `1` 之间。
- 当 `b = 0`、`s = 1` 时，曲线保持标准正弦形态，不做额外偏移和振幅放大。
- 这意味着如果直接把这样的值接到 Niagara 某个位置或速度分量上，得到的就是一个会在正负区间内往复变化的驱动值。

结合本段正文里对 `sign`、时间和数字区间的讨论，这张图承担的是数学直觉铺垫：先确认正弦本身如何在正负之间变化，后面再引入符号函数或区间映射，把这个来回变化的值转换成更可控的方向选择。
这是 `### 00:27:53-00:32:31 关键流程 07` 段中的第二张 Desmos 辅助图，重点在于说明给正弦结果加偏移量后，整个输出区间会整体平移。

图中当前可确认的参数值：
- 公式仍是：
  - `(sin(t) + b) * s`
- `t = 0`
- `b = 1`
- `s = 1`
- `p = 1`
- 当前函数结果显示为 `1`

从图像关系可以直接读出：
- 原本 `sin(t)` 的输出范围是 `[-1, 1]`
- 当 `b = 1` 时，整条曲线整体上移 `1`
- 因此新的输出范围会变成 `[0, 2]`

这张图的用途，是帮助理解 Niagara 里为什么要加 `Bias` 或类似的偏移参数：
- 不加偏移时，数值会在正负区间来回切换
- 加上偏移后，可以把整个函数推到全正区间，避免某些位置、速度或缩放值落到负数
- 这为后面用 `sign` 或用偏移后的周期函数去控制旋转中心、方向翻转或位置极值提供了更稳定的数值基础
这是 `### 00:27:53-00:32:31 关键流程 07` 段回到 Unreal 的参数接线图，表示教程已经把前两张 Desmos 里的数学思路真正落到 Niagara 的 `Rotate Around Point` 输入上。

- 当前系统：`NS_MagicAura_01`
- 当前选中发射器：`Source_Ribbon`
- 右侧仍处于 `Rotate Around Point` 模块的 `Rotation Center -> Input Position` 配置区域。

当前能可靠确认的参数结构：
- `Input Position = Make Vector`
- `X = 0.0`
- `Y = 0.0`
- `Z` 不再直接接 `Sine`，而是改成了 `Multiply Float`
- `Multiply Float` 当前可见两个输入端：
  - `A = 1.0`
  - `B` 尚未完整展示，正在通过右键菜单准备粘贴/接入新的输入
- `Conversion Operation = Passthrough as Non Large World Position`
- `Derive the Rotation Axis = true`
- `X Axis = (1.0, 0.0, 0.0)`
- `Y Axis = (0.0, 1.0, 0.0)`

右键菜单当前停在 `Paste`，说明作者正在把先前推导好的函数或节点输入粘贴到这里，而不是手工重新搭一遍。

这张图与前两张数学示意图对应起来，可以确定本段的真实目标是：
- 不只用单纯的 `Sine`
- 而是把 `Sine`、`Sign`、缩放或偏移等组合成一个新的浮点表达式
- 再把这个表达式接到 `Rotation Center` 的 `Z` 分量上

这样做的结果，会让旋转中心的上下运动不再只是平滑正弦，而是带有方向翻转、分段变化或更强烈的极值切换特征。

### 00:32:31-00:37:28 速度、颜色

- 本段定位：速度、颜色。
- 知识点：我们把1和0.5都调整成100。
- 知识点：数学会从0到100。
- 知识点：如果我调整数学会,它会更快。
- 知识点：如果我调整数学会,它会更慢。
- 知识点：我们调整数学会, 因为我特别把它拿走了。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`速度`、`颜色`。

**关键画面：**

这是 `NS_MagicAura_01` 中 `Source_Ribbon` 发射器的 `Rotate Around Point` 参数细化图，作者正在把上下摆动的结果继续放大为更明显的速度变化。

- 发射器结构：当前只高亮 `Source_Ribbon`，其模块链可见为 `Emitter State`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Particle State`、`Rotate Around Point`、`Solve Forces and Velocity`、`Sprite Renderer`；旁边的 `Empty001` 发射器处于 `Disabled` 状态。
- 当前选中模块：`Rotate Around Point`
- `Rotation Amount`
  - `Rotation Phase = 0.0`
  - `Rotation Rate = 0.0`
- `Setup`
  - `Set Particle Position = true`
  - `Radius = 100.0`
  - `Rotation Center = Convert Vector to Position`
  - `Input Position = Make Vector`
    - `X = 0.0`
    - `Y = 0.0`
    - `Z = Multiply Float`
      - `A = Sine`
        - `Normalized Angle = EMITTER.Age`
        - `Period = 1.0`
        - `Scale = 0.5`
        - `Bias = 1.0`
      - `B = 100.0`
  - `Conversion Operation = Passthrough as Non Large World Position`
  - `Derive the Rotation Axis = true`
  - `X Axis = (1.0, 0.0, 0.0)`
  - `Y Axis = (0.0, 1.0, 0.0)`
- 时间轴状态：系统时间停在约 `1.17s`，可见轨道包括 `AuraMesh`、`Empty001`、`Glows`、`Glows_FromEmitter`、`MagicCircle`、`MagicGlow_Ground`、`Rays`、`Source_Ribbon`。

这一帧表达的核心做法是：先用 `Sine(EMITTER.Age)` 产生周期值，再通过 `Scale/Bias` 调整范围，最后乘以 `100.0` 写入 `Z`，把旋转中心的上下位移幅度整体放大。
这是把前面 `Rotate Around Point` 的数值调节回到关卡视口中观察后的结果图，字幕说明“这里你可以控制速度”，指向的就是上一张图中用于驱动上下位移的数学量。

- 关卡视口：`Level_Stylized`
- 选中对象：`NS_MagicAura_01`
- Outliner 可见父级 `Gideon_Inquisitor`，当前选中的 Niagara Actor 为 `NS_MagicAura_01`
- `NS_MagicAura_01 (Instance)` 详情面板
  - `Location = (-5.305, 0.0, 0.000)`
  - `Rotation = (0.0, 0.0, 0.0)`
  - `Scale = (1.0, 1.0, 1.0)`
  - `Niagara System Asset = NS_MagicAura_01`
  - `User Parameters -> Scale Mult = 1.0`
- 画面结果：角色脚边与身体右侧可见少量发光粒子，教程此时强调的不是形状调整，而是通过前一张图里的 `Z` 向数学表达式来加快或减慢这些围绕角色运动的粒子节奏。

这一帧的用途是验证参数修改后的场景级表现，并给出控制对象锚点：速度变化通过 Niagara 系统内部数学值驱动，但观察和实例调试是在关卡中的 `NS_MagicAura_01` Actor 上完成。
这是 `NS_MagicAura_01` 的 `Glows_FromEmitter` 发射器细化图，作者开始单独调节由源发射器采样出来的发光层生成速度。

- 当前选中发射器：`Glows_FromEmitter`
- 发射器模块链（图中可见）
  - `Emitter State`
  - `Spawn Particles from Other Emitter`
  - `Initialize Particle`
  - `Sample Particles from Other Emitter`
  - `Shape Location Sphere`
  - `Add Velocity Linear`
  - `Particle State`
  - `Scale Sprite Size`
  - `Scale Color`
  - `Curl Noise Force`
  - `Drag`
  - `Solve Forces and Velocity`
- 当前选中模块：`Spawn Particles from Other Emitter`
  - `Emitter Binding = Other -> Source_Ribbon`
  - `Spawn Rate = 25.0`
  - `Calculate Spawn Rate Per Particle = true`
  - `Spawn Rate Per Particle Cap = 100.0`
  - `Spawning Enabled = true`
  - `Minimum Age Spawn Threshold = 0.3333`
  - `Maximum Age Spawn Threshold = 1.0`
- 左侧预览结果：角色脚下白色圆盘与竖向金色光条已经形成，说明 `Glows_FromEmitter` 正在跟随源发射器采样的位置持续生成发光粒子。
- 时间轴状态：系统时间约 `3.78s`，可见轨道包括 `AuraMesh`、`Glows`、`Glows_FromEmitter`、`MagicCircle`、`MagicGlow_Ground`、`Rays`，以及两个名称相近的 `Ribbon_FromSourse` 轨道。

这一帧对应的教程意图是把“速度”从 `Source_Ribbon` 的旋转中心运动，进一步落实到下游发光层的生成频率上；当前图里给出的直接控制项是 `Spawn Rate = 25.0`。

### 00:37:28-00:42:28 速度、颜色

- 本段定位：速度、颜色。
- 知识点：我们不需要加速, 圆率调整, 和生命从0.2到0.5。
- 知识点：这个是光源供应器, 另一个是0.2光源供应器。
- 知识点：把它们都提升到每个光源供应器, 这样它们都可以同时控制。
- 知识点：我可以提升转折率, 并提升游戏的游戏速度。
- 知识点：你能够在一般情况下控制速度, 但需要做一切正常。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`速度`、`颜色`。

**关键画面：**

这是 `NS_MagicAura_01` 中 `Glows001` 发射器的 `Shape Location` 设置图，作者在这里调整发光粒子的生成形状，并对比它与左侧 `Ribbon_FromSourse` 采样带状发射器的关系。

- 当前选中发射器：`Glows001`
- 左侧参考发射器：`Ribbon_FromSourse`
  - 模块链可见为 `Emitter State`、`Spawn Particles from Other Emitter`、`Initialize Particle`、`Sample Particles from Other Emitter`、`Solve Forces and Velocity`、`Particle State`、`Scale Color`、`Scale Ribbon Width`、`Ribbon Renderer`
- `Glows001` 模块链可见为：
  - `Emitter State`
  - `Spawn Rate`
  - `Spawn Particles from Other Emitter`
  - `Initialize Particle`
  - `Shape Location`
  - `Add Velocity`
  - `Sample Particles from Other Emitter`
  - `Particle State`
  - `Scale Sprite Size`
  - `Scale Color`
  - `Curl Noise Force`
  - `Drag`
  - `Solve Forces and Velocity`
  - `Sprite Renderer`
- 当前选中模块：`Shape Location`
  - `Shape Primitive = Ring / Disc`
  - 下拉菜单中可见可选形状：`Sphere`、`Cylinder`、`Box / Plane`、`Torus`、`Ring / Disc`、`Cone`
  - `Ring / Disc Distribution Mode = Uniform`
  - `Disc Coverage = 0.0`
  - `U Distribution = 0.0`
  - `Transform Order = Scale / Rotate / Offset`
  - `Scale Mode = Default`
  - `Non Uniform Scale = (1.0, 1.0, 1.0)`
  - `Rotation Mode = Default`
  - `Rotation Coordinate Space = Local`
  - `Offset Mode = None`
  - `Shape Origin = STACKCONTEXT.Position`
- 预览结果：角色脚下保留白色圆盘与竖向金色光柱，顶部还能看到一条环绕上升的细金色粒子弧线，说明该发光层正在沿环形分布生成并被后续速度模块带动。

这一帧的重点是把 `Glows001` 的生成区域限定为 `Ring / Disc`，为后续再调速度、寿命和颜色提供稳定的圆环分布起点。
这是 `NS_MagicAura_01` 中 `Source_Ribbon` 的 `Rotate Around Point` 再次细化图，作者正在把竖向运动的数学范围从上一段的简单乘法，改成“先放大再下移”的表达式，用来更精确地控制速度和高度区间。

- 当前选中模块：`Source_Ribbon -> Rotate Around Point`
- `Rotation Amount`
  - `Rotation Phase = 0.0`
  - `Rotation Rate = 1.0`
- `Setup`
  - `Set Particle Position = true`
  - `Radius = 100.0`
  - `Rotation Center = Convert Vector to Position`
  - `Input Position = Make Vector`
    - `X = 0.0`
    - `Y = 0.0`
    - `Z = Subtract Float`
      - `A = Multiply Float`
        - `A = Sine`
          - `Normalized Angle = EMITTER.Age`
          - `Period = 2.0`
          - `Scale = 0.5`
          - `Bias = 1.0`
        - `B = 150.0`
      - `B = 50.0`
  - `Conversion Operation = Passthrough as Non Large World Position`
  - `Derive the Rotation Axis = true`
  - `X Axis = (1.0, 0.0, 0.0)`
  - `Y Axis = (0.0, 1.0, 0.0)`
- 同屏可见的相关发射器
  - `Source_Ribbon02`：模块链包含 `Emitter State`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Particle State`、`Rotate Around Point`、`Solve Forces and Velocity`、`Sprite Renderer`
  - `Ribbon_FromSource0`：模块链包含 `Emitter State`、`Spawn Particles from Other Emitter`、`Initialize Particle`、`Sample Particles from Other Emitter`、`Solve Forces and Velocity`、`Particle State`、`Scale Color`、`Scale Ribbon Width`、`Ribbon Renderer`
- 预览结果：左侧仍能看到环绕上升的金色丝带和脚下白色圆盘，说明该数学调整直接影响了 Ribbon 轨迹的上升/下降节奏。

这一帧给出的关键公式可以按 `((sin(EMITTER.Age, Period=2.0) * 150.0) - 50.0)` 理解，它把原始正弦映射到更大的 Z 位移区间，并通过减去 `50.0` 把整体中心下移。
这是把 `S09` 段参数调整放回关卡中的结果图，用来验证“速度、颜色”相关修改后的整体视觉。

- 关卡视口：`Level_Stylized`
- Outliner 当前选中对象：`Gideon_Inquisitor`
- 详情面板对象：`Gideon_Inquisitor (Instance)`
  - `Location = (-57.41, -825.5, 0.0003)`
  - `Rotation = (0.0, 0.0, 0.0)`
  - `Scale = (1.0, 1.0, 1.0)`
- 画面结果
  - 角色脚下中心保留一层高亮白金色圆盘。
  - 外圈出现多层绕角色旋转的金色环带，已经不再只是单一地面圆环，而是形成上下分层、侧向包裹的轨迹。
  - 角色身体周围有竖向金色光束和少量亮点，说明前面调整的 `Source_Ribbon` 运动范围与 `Glows` 系列发射器的生成速度共同影响了最终节奏。

这一帧的作用是确认：经过 `Ring / Disc` 形状分布、`Spawn Particles from Other Emitter` 生成频率，以及 `Rotate Around Point` 的 Z 向数学区间调整后，效果已经从脚下平面发光扩展为围绕角色身体的多层动态环流。

## 补充视觉证据

### S01 00:01:50

这是 `p35.md` 的补充视觉证据图，对应前文 `S01 00:01:50` 的早期 Beam 基础搭建阶段，用来补足 `NS_RibbonTest` 初始发射器结构与关键生成参数。

- 当前系统：`NS_RibbonTest`
- 时间轴状态：系统时间约 `2.62s`
- 可见发射器轨道：`DynamicBeam`、`Empty`
- 当前选中发射器：`Empty`
- `Empty` 发射器当前可见结构
  - `Properties`
  - `Emitter Summary`
  - `Emitter Spawn`
  - `Emitter Update`
- 正在执行的操作：在 `Emitter Update` 分组右侧点击 `+`，打开 `Add new Module` 搜索面板，搜索框已输入 `br`
- 右侧详情面板当前显示模块：`Spawn Burst Instantaneous`
  - `Spawn Count = 50`
  - `Spawn Time = 0.0`
  - `Spawn Probability = 1.0`
  - `Loop Count Limit = 1`
- 同屏参考发射器：`DynamicBeam`
  - 可见模块链包含 `Emitter State`、`Beam Emitter Setup`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Spawn Beam`、`Beam Width`、`Particle State`、`Update Beam`、`Solve Forces and Velocity`、`Ribbon Renderer`
  - 发射器当前处于 `Disabled` 状态

这张补充图的作用是把 `S01` 里“从空发射器起步并补齐 Burst/Beam 相关模块”的过程具体化：一侧给出参考用的 `DynamicBeam` 完整模块链，另一侧展示在 `Empty` 上通过模块搜索逐步补齐发射器结构的起点。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。

