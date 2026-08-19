# 02 Fire Wisp

# 02 Fire Wisp

## 关键术语

- `Spawn`、`Velocity`、`Alpha`、`UV`、`Lerp`、`Add`、`Texture`、`Substance`、`Substance Designer`、`Photoshop`、`Fire`、`粒子`、`Niagara`、`Normalized Age`、`Translucent`、`Additive`、`Niagara System`、`Emitter`

## 分段知识

### 00:00:05-00:00:54 关键流程 01

- 本段定位：关键流程 01。
- 知识点：在这系列影片中,后续会在画面上設立能量泡泡,但在我们的情况下,它们将是能量泡泡 不同的能量泡泡,火,光,水 在我们的情况下,它们将像Legion的例子一樣。
- 知识点：简单,不太有語言的群体,类似Legion的风格 后续会也会分析一个例子,如何從风格变成现實 在这系列影片中,后续会分析一个例子,如何從风格变成现實。
- 知识点：在我们情况下,它们将像Legion的风格一樣,类似Legion的风格 在我们的情况下,它们将像Legion的风格一樣,类似Legion的风格一樣。

**关键画面：**

这是一张用于说明“魔法效果需要明确价值中心”的案例对比页，来自外部视觉设计示例，而不是 Niagara 编辑器截图。

- 页面标题：`SECTION III // VALUE`
- 主标题：`ENHANCING MAGICAL EFFECTS BY USING PROPER VALUE RANGE`
- 左侧说明文字提到 `Master Arcanist Ziggs's Bouncing Bomb`，强调把魔法效果的亮度/价值推向中心区域，能让效果看起来更强、更有魔法感。
- 左下示例标记为 `INACCURATE REPRESENTATION`
  - 画面中的蓝色能量球整体发光较均匀，但缺少一个明确的亮度中心。
  - 配文含义：如果效果没有清晰的视觉“中心”，玩家会更难判断伤害最集中的位置，因为它更容易融入地图背景。
- 右上示例标记为 `ACCURATE REPRESENTATION`
  - 同样的蓝紫色能量球在中心加入了更强的白蓝高亮核心，外圈保留较弱的紫色轨迹和次级光点。
  - 配文含义：把数值/亮度推向炸弹中心后，法术的关注焦点更明确，团队战斗里玩家更容易注意到效果。

这张图在本段承担的是审美基准说明：后续制作 `Fire Wisp` 时，不只是做一个会发光的球，而是要让最重要的能量和亮度集中在视觉中心，外围再用较弱的拖尾、环带和噪声去衬托主体。
这张图延续上一帧的外部案例页，核心画面没有变化，新增的信息主要来自底部字幕：作者明确说明本系列会先做偏 `League of Legends` 风格的能量球，再分析如何从这种风格化效果过渡到更写实的表现。

- 页面主体仍为 `ENHANCING MAGICAL EFFECTS BY USING PROPER VALUE RANGE` 的对比页。
- 左右对比关系不变：
  - 左侧是缺少明确亮度核心的 `INACCURATE REPRESENTATION`
  - 右侧是中心高亮更强、焦点更集中的 `ACCURATE REPRESENTATION`
- 底部字幕可确认的教程意图：
  - 当前目标风格是类似 `League of Legends` 的风格化能量效果。
  - 后续还会专门分析一个“从风格化到更现实/更写实”的转换案例。

这一帧的作用是把视觉参考从单纯的“好看/不好看”对比，进一步落实成项目方向选择：当前 `Fire Wisp` 的第一阶段不是追求真实火焰，而是先建立清晰、夸张、可读性强的风格化价值结构。
这张图仍是同一张“价值范围”对比页，新增的有效信息来自字幕：作者强调，在真正制作一项技能效果时，需要越来越主动地关注这些视觉元素，尤其是焦点、中心亮度和读图优先级。

- 页面标题与主体示例保持不变：
  - `SECTION III // VALUE`
  - `ENHANCING MAGICAL EFFECTS BY USING PROPER VALUE RANGE`
  - 左侧 `INACCURATE REPRESENTATION`
  - 右侧 `ACCURATE REPRESENTATION`
- 字幕传达的制作原则：
  - 当你开始制作一个技能效果时，必须持续关注这些视觉要素。
  - “这些元素”在当前语境下指向的就是前两张图反复说明的价值中心、视觉焦点和可读性。
- 画面对比仍然给出明确结论：
  - 左侧蓝球由于亮度分布过散，主体不够突出。
  - 右侧蓝球把最亮的白蓝核心压到中心，同时保留外围紫色环流作为辅助信息，因此更容易被玩家快速识别。

这一帧相当于给后文的所有实际制作步骤立了一条总规则：无论后面调的是透明度、颜色、贴图还是 Niagara 粒子系统，判断标准都应回到“是否强化了中心主体，是否提升了第一眼可读性”。

### 00:03:43-00:07:01 透明度

- 本段定位：透明度。
- 知识点：在这系列影片中,后续会分析一个例子,如何從风格变成现實 在我们情况下,它们将像Legion的风格一樣,类似Legion的风格一樣。
- 知识点：在我们的情况下,它们将像Legion的风格一樣,类似Legion的风格一樣 在这系列影片中,后续会分析一个例子 这会是我们的主色,让我们选择一个。
- 知识点：我们必须选择一个按照优点的色彩 我们还需要一个色彩图纸 我们还需要一个色彩图纸 我们还需要一个色彩图纸 我们选择一个正常的 我们选择一些需要选择的色彩图纸。
- 知识点：我们必须有0.99的分数 因为色彩图纸是从0到1的一个乘数 有时候会有一个色彩图纸 我会打开 左边是0,右边是1 如果有1,它可以从这里到左边。
- 知识点：我记得的地方,我已经展示过了 因此,必须要数0.99 因此,边界在这里 因此,最后没有图纸 这是一个技巧 记得要总是数0.99 并且把任何东西都放进色彩图纸。
- 核对对象：`透明度`。

**关键画面：**

这是开始制作 `Fire Wisp` 前的工程准备画面，作者先在内容浏览器中定位材质资源目录，准备新建本段会用到的材质或材质实例。

- 当前关卡/工程窗口：`Stylized_Wisps`
- 当前打开标签可见 `NS_Wisp_Fire*`
- Outliner 中可见场景主体：
  - `Env`
  - `DirectionalLight`
  - `ExponentialHeightFog`
  - `Floor`
  - `Gideon_Inquisitor`
  - `PointLight`
  - `PostProcessVolume`
  - `SkyAtmosphere`
  - `SkyLight`
  - `WorldDataLayers`
- 内容浏览器当前路径：
  - `Content / VFX_Library / Materials / MM`
- 左侧目录树可见 `VFX_Library` 下至少包含：
  - `Blueprints`
  - `Curves`
  - `Maps`
  - `Materials`
  - `Functions`
  - `Instances`
  - `MM`
  - `MPC`
  - `Meshes`
  - `Misc`
  - `Niagara`
- 当前 `MM` 文件夹为空，底部显示 `0 items`
- 右侧详情面板当前没有选中对象，显示 `Select an object to view details.`

这张图的作用是给出制作起点：作者并不是先改 Niagara 参数，而是先在 `VFX_Library/Materials/MM` 下准备本效果所需的材质资源，后面的透明度控制会依赖这里创建的材质网络。
这是 `M_UberMaterial` 的材质图编辑画面，作者正在给第二个纹理采样参数节点选择一张蓝色 `ColorMap`，为后续透明度和颜色控制准备渐变贴图。

- 当前材质：`M_UberMaterial`
- 当前图中可见的材质节点：
  - `T_Main`：`Param2D`
    - 预览图是一个白色圆形渐变
    - 可见输出 `RGB`、`R`、`G`、`B`、`A`
  - `Colormap`：`Param2D`
    - 当前被选中高亮
    - 可见输出 `RGB`、`R`、`G`、`B`、`A`
  - 材质输出节点 `M_UberMaterial`
    - `Emissive Color` 已可用
    - `Opacity = 1.0`
    - `World Position Offset = (0.0, 0.0, 0.0)`
- 当前操作：为 `Colormap` 节点打开资源选择面板，并在搜索框输入 `colormap`
- 资源面板中可见候选贴图：
  - `VFX_T_ColorMap_Blue_05`
  - `VFX_T_ColorMap_Blue_06`
  - `VFX_T_ColorMap_Blue_07`
- 左下详情面板显示当前节点属于 `Material Expression Texture Sample Parameter 2D`，可见：
  - `Sampler Source = From texture asset`
  - `Const Coordinate = 0`
  - `Sampler Type = Color`

这一帧说明作者的透明度做法不是只靠纯数学值，而是先准备两类纹理输入：一张主体形状纹理 `T_Main`，再叠加一张控制颜色/透明过渡的 `ColorMap`，后面再用 `0.99` 一类 UV 边界技巧去采样这张渐变图。
这是 `M_UberMaterial` 当前阶段的已连线材质图，作者把主体遮罩纹理和颜色渐变纹理组合起来，同时用 `0.99` 缩放采样坐标，避免颜色渐变在 1.0 边界取样时出现不需要的末端颜色。

- 节点定义集
  - `T_Main`：`Param2D`
    - 预览图为白色圆形渐变遮罩
    - 当前选中
  - `Multiply(0.99)`：乘法节点
    - 可见 `B = 0.99`
  - `Colormap`：`Param2D`
    - 预览图为蓝青色径向渐变
  - `M_UberMaterial`：材质输出节点
    - 使用到的输出插槽为 `Emissive Color` 与 `Opacity`
- 连线集
  - `T_Main` 的单通道输出接入 `Multiply(0.99)` 的 `A`
  - `Multiply(0.99)` 输出接入 `Colormap` 的 `UVs`
  - `Colormap` 的 `RGB` 输出接入 `M_UberMaterial.Emissive Color`
  - `T_Main` 的单通道输出直接接入 `M_UberMaterial.Opacity`
- 设置/参数
  - 乘法常量：`0.99`
  - `T_Main` 在左下详情中可见：
    - `Parameter Name = T_Main`
    - `Sort Priority = 32`
    - `Sampler Source = From texture asset`
    - `Const Coordinate = 0`
- 输出/预览
  - 左侧预览球体显示为中心更亮、外围更淡的蓝青色发光球。
  - 说明当前材质已经实现：
    - 形状由 `T_Main` 的灰度遮罩决定
    - 发光颜色由 `Colormap` 的渐变决定
    - 透明度仍由 `T_Main` 直接控制

这一帧对应本段“透明度”专题里的关键技巧：把 `0-1` 的遮罩值在送入 `Colormap` 采样前乘以 `0.99`，就能避免 UV 正好打到最右端 1.0 时采到不想要的边缘颜色，同时保留几乎完整的渐变范围。

### 00:07:11-00:11:48 Lerp、粒子、系统

- 本段定位：Lerp、粒子、系统。
- 知识点：Lerp的意思是什么 这是线性的解决 第一个值是0 第二个值是1 在这里设定 当然,如果0是色彩图纸 1是所得的 其中的中间值是什么 如果完全是0。
- 知识点：那只有这个 如果1,那只有这个 如果我们设定,例如,色彩图纸 那就是色彩图纸 需要创造和示范 我正在创造一个体验 需要把它放在外面 这里我们有用色彩图纸。
- 知识点：我们需要这个 如果1是,那是用色彩图纸 如果0是,那是用色彩图纸 必须改变 这里有一个限制 可以去到更远 但我们不想去到更远 我们改变位置。
- 知识点：通过选择,这个是B 这个是A 太好了 现在我们已经选择 用色彩图纸或否 我们需要 既然在用色彩图纸 我们应该选择 我们需要用色彩图纸 在粒子系统里。
- 知识点：色彩图纸是我们的 色彩图纸 这很棒 给我们机会 在用色彩图纸 我们叫做预计 在用色彩图纸 再次处理 现在需要展示 这不是做过的事 在粒子里。
- 知识点：需要加一个 这样色彩图纸会变成白色 为了强化 需要加一个粒子 我可以复制 现在需要制作新名字 用预计色彩图纸 如果需要复制 需要用这个 如果不是,那一个。
- 知识点：因为复制一个是一样的 白色没有改变 这是在数量上的方式 如果是0 那一切都会是白色 如果我们加一个粒子。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Lerp`、`粒子`、`系统`、`颜色`。

**关键画面：**

这是 `M_UberMaterial` 中加入 `Lerp` 控制后的材质图，作者开始把“是否使用渐变色图”做成一个可切换参数，用于在纯白发光和 `ColorMap` 染色结果之间插值。

- 节点定义集
  - `Multiply(0.99)`
    - `B = 0.99`
  - `Colormap`：`Param2D`
  - `Lerp(,0.5)`：线性插值节点
    - 当前被选中
    - `Alpha = 0.5`
  - `Use Colormap?`：`Param(0)`
    - `Default Value = 0.0`
  - `M_UberMaterial`：材质输出节点
- 连线集
  - 上游遮罩/采样坐标仍先经过 `Multiply(0.99)` 再驱动 `Colormap.UVs`
  - `Colormap` 的颜色输出接入 `Lerp` 的一个颜色输入端
  - 另一条白色连线从下方基础颜色/遮罩链路接入 `Lerp` 的另一个输入端
  - `Lerp` 输出接入 `M_UberMaterial.Emissive Color`
  - 下方基础遮罩链路仍直接接入 `M_UberMaterial.Opacity`
- 设置/参数
  - `Use Colormap?` 默认值为 `0.0`
  - 当前 `Lerp` 节点在详情中可见：
    - `Const A = 0.0`
    - `Const B = 1.0`
    - `Const Alpha = 0.5`
- 输出/预览
  - 左侧预览球体仍显示为中心亮、边缘淡出的蓝青色发光球。
  - 字幕说明可确认作者正在解释 `Lerp` 的含义：`0` 代表一端，`1` 代表另一端，中间值则在两种结果之间线性过渡。

这一帧的核心是把颜色控制从“固定使用 `Colormap`”升级成“可参数化切换”：后续只要修改 `Use Colormap?`，就能在未染色的基础发光结果与渐变色图版本之间平滑选择。
这是 `M_UberMaterial_Inst` 的材质实例界面，作者开始在实例层验证前面做好的颜色开关与贴图参数，并强调该材质使用 `Translucent` 混合模式，因此可以利用更暗的色调做半透明过渡。

- 当前材质实例：`M_UberMaterial_Inst`
- 参数组 `Global Scalar Parameter Values`
  - `Use Colormap? = 0.0`
- 参数组 `Global Texture Parameter Values`
  - `Colormap = VFX_T_ColorMap_Blue_06`
  - `T_Main = T_Glow3`
- `General`
  - `Parent = M_UberMaterial`
- `Material Property Overrides`
  - `Opacity Mask Clip Value = 0.3333`
  - `Blend Mode = Translucent`
  - `Shading Model = Unlit`
  - `Two Sided` 未启用
  - `Dithered LOD Transition` 未启用
  - `Output Translucent Velocity` 未启用
  - `Has Pixel Animation` 未启用
  - `Enable Tessellation` 未启用
  - `Cast Dynamic Shadow as Masked` 未启用
- 预览结果
  - 左侧预览网格上显示一个较柔和的白色发光斑点，说明在 `Use Colormap? = 0.0` 时，实例目前更接近未染色或弱染色的基础发光版本。
  - 字幕明确指出：因为使用了 `Translucent`，可以给效果加入更暗的色阶。

这一帧表达的关键点是：颜色开关不只服务于“蓝色还是白色”的切换，它与 `Translucent` 混合模式配合后，还决定了能否在同一个发光材质里保留较暗的半透明层次，而不是被纯加色结果全部冲白。
这是同一材质实例 `M_UberMaterial_Inst` 的进一步测试图，作者把混合模式切换成 `Additive`，同时增加了 `Premultiply Color?` 参数，用来对比不同发光叠加方式下的颜色和亮度表现。

- 当前材质实例：`M_UberMaterial_Inst`
- `Global Scalar Parameter Values`
  - `Premultiply Color? = 1.0`
  - `Use Colormap? = 0.0`
- `Global Texture Parameter Values`
  - `Colormap = VFX_T_ColorMap_Blue_06`
  - `T_Main = T_Glow3`
- `General`
  - `Parent = M_UberMaterial`
- `Material Property Overrides`
  - `Opacity Mask Clip Value = 0.3333`
  - `Blend Mode = Additive`
  - `Shading Model = Unlit`
  - 其他开关保持未启用状态
- 预览结果
  - 左侧预览球体的中心高亮明显更强，整体更接近纯白发光柱状斑点。
  - 与上一张 `Translucent` 版本相比，暗部和半透明层次被削弱，表现更偏“直接加亮”。

这一帧说明本段不仅在讲 `Lerp` 和颜色开关，也在比较材质混合策略的差异：`Translucent` 更适合保留暗色与层次，`Additive` 更容易得到强烈、纯净的发光结果；`Premultiply Color?` 则用于配合这种混合方式进一步控制颜色是否先受透明度影响。

### 00:11:48-00:16:42 Texture、颜色

- 本段定位：Texture、颜色。
- 知识点：让这些功能来自于 以例子来说 它会更清楚 这些功能 就足够了 可以拥有 我还会用涂纹 在一般来说 我建议很高推荐把它们取得 这很适合用涂纹。
- 知识点：后续会谈论 涂纹的详细 这里是颜色的指示 几个颜色 比较好 当然比较好 我们的功能会更好 涂纹是如何 涂纹会影响反射 颜色的颜色。
- 知识点：在很多情况之下 这不是必要 它非常好地涂纹 我把它拿了 效果已经 几乎半了 你也不会感觉它有所不同 我非常推荐做这个 保留到关闭 需要有这么一种基本的材料。
- 知识点：需要有个instances 需要制作一个分开的folder 为instances 我们把这里放下 好 首先我们需要名字 因为会有火的。
- 知识点：火软的 它会软的 强化的 我们已经制作了一个instance的材料 我们再次发动 而且我们需要 火的 预计 现在我不会用火的 需要用一些软的 以为它强化了。
- 知识点：需要有点烟 需要去到Textures 这里需要写烟 我们需要软的形状 记得我说的 如果是现实 那它们会用很沉悶的形状 我们需要软的形状 所以需要建议用一些简单的形状。
- 知识点：可能是 虽然不是 你看看它们的区别 这里有很多噪音 另一边也很简单 它们很软 简单 但这里可以问 这是一个Texture。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Texture`、`颜色`。

**关键画面：**

这是 `M_UberMaterial_Inst` 的保存与预览阶段画面，作者在继续确认 `Additive` 版本材质实例的显示效果，并口头强调还会推荐启用 `ApplyFogging` 一类的渲染选项。

- 当前材质实例：`M_UberMaterial_Inst`
- `Global Scalar Parameter Values`
  - `Premultiply Color? = 1.0`
  - `Use Colormap? = 0.0`
- `Global Texture Parameter Values`
  - `Colormap = VFX_T_ColorMap_Blue_06`
  - `T_Main = T_Glow3`
- `General`
  - `Parent = M_UberMaterial`
- `Material Property Overrides`
  - `Opacity Mask Clip Value = 0.3333`
  - `Blend Mode = Additive`
  - `Shading Model = Unlit`
- 预览结果
  - 左侧预览网格上是一个非常亮的白色竖向发光斑，外围过渡柔和，说明当前材质更偏强化后的纯发光版本。
  - 由于 `Use Colormap? = 0.0`，此时并未强调蓝色渐变，而是以近白色高亮为主。
- 字幕可确认的信息
  - 作者建议保存当前设置。
  - 作者额外提到通常也会启用 `ApplyFogging`。

这一帧的意义是给出一个“基础可用材质实例”的中间状态：先确定强化版发光表现可以成立，再逐步补足更细的渲染兼容项，例如雾效相关设置。
这是在内容浏览器中为火焰材质挑选形状贴图的画面。作者进入 `Shapes` 贴图库并搜索 `smoke`，目的是找一张更软、更简单的烟雾/云团轮廓，而不是噪声很重、过于写实的形状。

- 当前工程/关卡：`Stylized_Wisps`
- 顶部已打开标签可见：
  - `NS_Wisp_Fire*`
  - `MI_FireSoft_01*`
  - `T_Smoke11_2x2`
- 内容浏览器当前路径：
  - `Content / VFX_Library / Textures / Shapes`
- 左侧目录树可见 `Textures` 下至少包含：
  - `ColorMaps`
  - `Distortion_Normals`
  - `Gradients`
  - `Noises`
  - `Others`
  - `Shapes`
  - `Trails`
- 搜索框关键字：`smoke`
- 搜索结果数量：`17 items`
- 可见候选贴图示例：
  - `T_Smoke`
  - `T_Smoke3`
  - `T_Smoke4`
  - `T_Smoke5`
  - `T_Smoke6`
  - `T_Smoke7`
  - `T_Smoke8`
  - `T_Smoke10_2x2`
  - `T_Smoke11_2x2`
  - `T_Smoke12_2x2`
  - `T_Smoke13_2x2`
  - `T_Smoke14_2x2`
  - `T_Smoke15_2x2`
  - `T_Smoke16_2x2`
  - `T_Smoke17_2x2`
  - `T_Smoke_2x2`
- 场景视口仍保持角色站在空场景中心，说明此时主要是资源筛选，不是场景效果调试。

这张图对应本段“Texture、颜色”的关键判断：做风格化火焰时，作者优先选择边缘柔和、结构简洁的烟雾形状贴图，让发光团看起来更软；如果目标是更写实的火焰或烟雾，则会倾向使用噪声更多、更浑浊的形状。
这是 `NS_Wisp_Fire` 的初始 Niagara 系统图，作者已经把选好的软形状材质接回粒子系统，开始搭建一个最小可见的火焰发射器，并先调节 `Initialize Particle` 的生命周期范围。

- 系统：`NS_Wisp_Fire`
- 系统结构
  - `NS_Wisp_Fire`
    - `Properties`
    - `User Parameters`
    - `System Spawn`
    - `System Update`
    - `System State`
  - 发射器：`Empty`
    - `Properties`
    - `Emitter Summary`
    - `Emitter Spawn`
    - `Emitter Update`
      - `Emitter State`
      - `Spawn Rate`
    - `Particle Spawn`
      - `Initialize Particle`
    - `Particle Update`
      - `Particle State`
    - `Render`
      - `Sprite Renderer`
- 当前选中模块：`Initialize Particle`
- `Initialize Particle` 中当前可见参数
  - `Point Attributes`
    - `Lifetime Mode = Random`
    - `Lifetime Min = 0.5`
    - `Lifetime Max = 1.0`
    - `Color Mode = Unset`
    - `Position Mode = Simulation Position`
    - `Position Offset = (0.0, 0.0, 0.0)`
    - `Mass Mode = Unset / (Mass of 1)`
  - `Sprite Attributes`
    - `Sprite Size Mode = Unset`
    - `Sprite Rotation Mode = Unset`
    - `Sprite UV Mode = Unset`
  - `Mesh Attributes`
    - `Mesh Scale Mode = Unset`
    - `Mesh Renderer Array Visibility Mode = Unset`
  - `Ribbon Attributes`
    - `Ribbon Width Mode = Unset`
    - `Ribbon Facing Mode = Unset`
    - `Ribbon Twist Mode = Unset`
- 预览结果
  - 左侧预览窗口里已经出现一个小型橙白色火团，说明当前材质与 Sprite Renderer 组合已能稳定显示风格化火焰雏形。
  - 时间轴停在约 `1.60s`，当前发射器显示 `20 Particles`。

这一帧把本段“Texture、颜色”的选择真正落回 Niagara：先用柔和的烟雾形状材质做出一个最小火焰粒子，再通过 `Lifetime Min/Max = 0.5~1.0` 控制每个火团的停留时间，为后续继续加颜色、速度和层次打基础。

### 00:16:42-00:21:34 UV、速度

- 本段定位：UV、速度。
- 知识点：让它们变成中心 太多了 我还想加上反转转向,因此在逐一转动 接下来目标是给它们速度,以免它们飞离。
- 知识点：因为它们会火灾,让它们散开 这里需要调整 需要它们在所有方向都散开,可以从点开始 还有另一个选项,可以拿起它们,然后把它们做出来。
- 知识点：它们跟从点一样 从点开始,记得这是x,y,z的构图 三个图形式都可以 但如果我们做一个测试,它们会同时影响x,y,z 这里可以做一个逐一的游行。
- 知识点：我们需要在-20,20的地区做一些调整 现在它们在所有方向都在飞 需要加上它们仍然在生命期间旋转 我们有反转转向,可以逐一从-50,50设定。
- 知识点：从开始它会显示,然后它们会慢慢地消失 到现在它们都不太像 它们都很像,它们都很重叠 这种图形有不同的变化会很棒 这里,您可观察到,这种2x2叫做Freebook。
- 知识点：只是帮助我们,当我说是实际的 这是一个构图 您可以在一个图形里焖制,它们有不同的变化 现在我们有一个调整的 如果您想创造一个实际的版本,需要学到。
- 知识点：如何在下一个图形里创造一个特别的程序 这种模型,它们是焖制的 您可以逐个选择,或者选择一个图形 有多少是10x10的图形 100个图形,您可以逐个选择。
- 核对对象：`速度`。

**关键画面：**

这是 `NS_Wisp_Fire` 中加入 `Shape Location` 后的第一版分布设置。作者先把火团从单点生成改成球形体积分布，让粒子不再完全重叠在中心，而是向周围散开。

- 系统：`NS_Wisp_Fire`
- 当前发射器：`Empty`
- 发射器模块链可见为：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Shape Location`
  - `Particle State`
  - `Sprite Renderer`
- 当前选中模块：`Shape Location`
- `Shape Location` 参数
  - `Shape Primitive = Sphere`
  - `Sphere Radius = 100.0`
  - `Sphere Distribution = Random`
  - `Sphere Surface Distribution = 0.0`
  - `Hemisphere Distribution = (1.0, 1.0)`
  - `Transform Order = Scale / Rotate / Offset`
  - `Scale Mode = Default`
  - `Non Uniform Scale = (1.0, 1.0, 1.0)`
  - `Rotation Mode = Default`
  - `Rotation Coordinate Space = Local`
  - `Offset Mode = None`
  - `Shape Origin = STACKCONTEXT.Position`
- 预览结果
  - 左侧预览中多个橙白色火团已经离开同一点，围绕中心形成一团向外膨开的分布。
  - 时间轴停在约 `3.13s`。

这一帧对应本段“UV、速度”的第一步：先用 `Shape Location` 把生成位置打散，再继续叠加速度和旋转。当前做法是从半径 `100` 的球体内部随机取点，因此粒子已经具备“向四周扩散”的基础空间分布。
这是 `NS_Wisp_Fire` 在加入速度、求解和颜色衰减后的中间状态图。作者已经让火团获得外扩速度、尺寸变化、旋转以及基于生命周期的透明衰减，效果从静态堆叠变成更像飘散火焰的一组运动粒子。

- 当前发射器：`Empty`
- 发射器模块链可见为：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Shape Location`
  - `Add Velocity Linear`
  - `Particle State`
  - `Solve Forces and Velocity`
  - `Scale Sprite Size`
  - `Sprite Rotation Rate`
  - `Scale Color`
  - `Sprite Renderer`
- 当前选中模块：`Scale Color`
- `Scale Color` 参数
  - `Scale Mode = RGB and Alpha Separately`
  - `Scale RGB = (1.0, 1.0, 1.0)`
  - `Scale Alpha = Float from Curve`
  - 曲线驱动对象：`PARTICLES.NormalizedAge`
  - `Scale Curve = 1.0`
  - 可见曲线形状：
    - 开头先快速抬升到较高值
    - 中段持续下降
    - 末端收敛到接近消失的低值
- 预览结果
  - 左侧预览中多个火团已有明显的拖动和错位，不再全部堆在中心。
  - 粒子边缘更柔和，视觉上带有逐渐熄灭的过渡。
  - 时间轴停在约 `6.05s`，当前显示 `18 Particles`。

这一帧表达的关键做法是：先用 `Add Velocity Linear` 让粒子飞散，再用 `Scale Color` 的 Alpha 曲线按 `NormalizedAge` 控制“出现后逐渐减弱”的透明度变化，从而避免所有火团在整个生命周期里都保持同样的亮度和厚重感。
这是 `M_UberMaterial` 中为 `2x2` 图集做 UV 分块预览的基础节点图。作者用最小的坐标运算把一整张贴图切成四个区域，为后面在单张纹理里选择不同火焰变化做准备。

- 节点定义集
  - `TexCoord[0]`
    - `Coordinate Index = 0`
  - `Multiply(2)`
    - `B = 2.0`
  - `Frac`
    - 当前处于 `Previewing` 状态
- 连线集
  - `TexCoord[0]` 输出接入 `Multiply(2)` 的 `A`
  - `Multiply(2)` 输出接入 `Frac`
- 输出/预览
  - 左侧预览窗口显示一个被分成 `2x2` 四格的彩色方块。
  - 这说明当前 UV 已经被放大两倍后再取小数部分，从而把 `0-1` 空间重复为四个象限。
- 与上方现有材质网络的关系
  - 该局部节点块位于现有材质图的独立框选区域内，属于新增的 UV 子流程。
  - 上方仍可看到已有的透明度/颜色链路连接到材质输出节点，但这张图的焦点明确是 `2x2` 分块逻辑本身。

这一帧的关键公式是：`Frac(TexCoord * 2)`。它会把一张完整 UV 平面重复成 `2x2` 四块，从而让后续材质或粒子系统能够在同一张图集里访问四种不同的火焰形状变化，而不是只用单一形状。

### 00:21:34-00:24:28 UV、Substance、Substance Designer

- 本段定位：UV、Substance、Substance Designer。
- 知识点：它们都会分开,您可以选择不同的 需要在Photoshop或是Substance Designer里 展示您如何选择各种图形 想象会图形分成了细节。
- 知识点：会每个细节都取出 您要准备的细节是多少,都要自己决定 这里有四个细节 这里有四个 好,现在后续会它们分开 这是什么问题? 让我来取出所有的细节。
- 知识点：我们不需要其他东西 让它们有少许 这样就能让我们明白它是怎么回事 看起来奇怪吗?它们会分开四个图形 需要怎么分开呢? 在细节上,我们需要指示我们有多少。
- 知识点：可以用一张图形,1和1 我们的图形是2和2 2是直,2是直 2和2,我们取得了0 0图形,这是它 让我给你们看看 转向转向 让它们明白它是什么。
- 知识点：这是它 可以随意取出 我们怎么做? 可以在与与粒子的更新 在与与粒子的更新中取得了一种叫做Sub-UV。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Sequencer`、`Substance Designer`、`Photoshop`、`粒子`、`系统`。

**关键画面：**

这是纹理资源 `T_Smoke8_2x2` 的查看界面，用来说明所谓 `2x2` 图集并不是一张单独形状，而是把一张贴图划分成四个独立单元格，每个格子放一种不同的烟雾/火焰轮廓。

- 当前资源标签：`T_Smoke8_2x2`
- 纹理主预览
  - 画面被分为 `2x2` 四个象限。
  - 每个象限都有一团不同形状、不同重心分布的灰白烟雾块。
  - 背景为黑色，说明主要利用亮度/透明遮罩来表现形状。
- 右侧 `Details` 中可见的纹理信息
  - `Imported = 512x512`
  - `Displayed = 512x512`
  - `Max In-Game = 512x512`
  - `Resource Size = 171 KB`
  - `Has Alpha Channel = False`
  - `Method = Streamed`
  - `Format = DXT1`
  - `Number of Mips = 10`
  - `Encode Speed = Fast`
- `Level of Detail`
  - `Mip Gen Settings = FromTextureGroup`
  - `LOD Bias = 0`
  - `Texture Group = World`
- `Compression`
  - `Editor Show Final Encode` 已启用
  - `Compression Settings = Default (DXT1/5, BC1/3 on DX11)`
- 字幕给出的关键解释
  - “想象一下你已经将纹理分割成了细胞（cells）。”

这张图承担的是 SubUV 基础概念说明：后续粒子系统并不是随机切换四张独立贴图，而是在同一张 `2x2` 图集里，通过 UV 分块或 SubUV 索引去访问四个不同单元格，从而让火焰粒子获得形状变化。
这张图继续停留在 `T_Smoke8_2x2` 的查看界面，新增的关键信息来自字幕：作者建议先关闭粒子旋转，才能更清楚地辨认 `2x2` 图集中每个单元格各自是什么形状。

- 当前查看资源仍为：`T_Smoke8_2x2`
- 图集结构保持不变：
  - 贴图被分为 `2x2` 四个独立格子
  - 每个格子里是一种不同的灰白烟雾/火焰轮廓
- 右侧纹理基础信息保持一致：
  - `512x512`
  - `Has Alpha Channel = False`
  - `Format = DXT1`
  - `Number of Mips = 10`
- 字幕可确认的教程意图：
  - “关闭旋转，清楚地看它是什么。”
  - 也就是在观察 SubUV 图集时，先不要让粒子在系统里持续旋转，否则会难以判断每个格子的原始轮廓差异。

这一帧补充的是工作方法而不是新节点：当你要从一张图集里挑选或验证某个子图形时，必须先把旋转等干扰视觉识别的运动去掉，这样才能判断四个单元格分别更适合做中心火团、边缘火花，还是次级烟雾形状。
这是把 `2x2` 图集正式接回 `NS_Wisp_Fire` 的关键一步：作者在发射器里加入 `Sub UVAnimation` 模块，让每次重启系统时，粒子能从图集的四个单元格里随机取一种形状。

- 系统：`NS_Wisp_Fire`
- 当前发射器：`Empty`
- 发射器模块链可见为：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Shape Location`
  - `Add Velocity Linear`
  - `Sub UVAnimation`
  - `Solve Forces and Velocity`
  - `Particle State`
  - `Scale Sprite Size`
  - `Sprite Rotation Rate`
  - `Scale Color`
  - `Sprite Renderer`
- 当前选中模块：`Sub UVAnimation`
- `Sub UVAnimation` 参数
  - `SubUV Animation Mode = Random`
  - `Start Frame Range Override` 未启用，数值显示 `0`
  - `End Frame Range Override` 已启用，数值为 `3`
  - `Renderer Type = Sprite`
  - `Sprite Renderer = Sprite Renderer`
  - `Evaluation Type = Every Frame`
  - `Output Alternate Renderer Binding` 未启用
- 预览结果
  - 左侧预览中，火焰团块已经出现更明显的形状变化，不再是完全一致的单一软球。
  - 时间轴停在约 `4.43s`。
- 字幕可确认的信息
  - 作者说明重新启动粒子系统后，它现在会随机“抽到”不同峰值/形状。

这一帧把前两张图的 `2x2` 图集概念落成了实际粒子行为：通过 `Sub UVAnimation` 的 `Random` 模式，并把可用帧范围设为 `0-3`，同一发射器的不同粒子就能在四个图块间随机选取形状，从而显著减少火焰团的重复感。

### 00:24:33-00:26:59 Spawn、UV、粒子

- 本段定位：Spawn、UV、粒子。
- 知识点：需要问 您可观察到某些缺点 它选择的什么 让我估计让它延伸 让它更加显示 缺点是5 这里可观察到 它们扣出不同的缺点 您可以加转向 而问题是。
- 知识点：选择选择在Spawn 但我们还可以在更新中 继续玩 您可以在更新中 放置UV动作 在粒子的生命中。
- 知识点：它会继续玩 可以这样做 粒子是继续继续 从0-3失去 因为3是我们最后的 现在它们在生命中变化了 计算起来 它们有4个 不太多 它们慢慢地变化了。
- 知识点：让我留下一个 需要把速度也转掉 它们在生命中 变化了这4个变化 在这种情况下 我们没有它们 每个构图 它们都变化了 它们只有4个不同的颜色。
- 知识点：它们变化了 我们不需要那样 然后给它们选择 选择这4个 计算速度 Spawn的速度 会被回到25 改变速度。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Spawn`、`粒子`、`速度`、`颜色`。

**关键画面：**

这是 `NS_Wisp_Fire` 在引入 SubUV 变化之后回头调整生成密度的画面。作者先降低 `Spawn Rate`，避免当前火焰粒子过于拥挤、图块变化被视觉噪声掩盖。

- 系统：`NS_Wisp_Fire`
- 当前发射器：`Empty`
- 发射器模块链可见为：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Shape Location`
  - `Add Velocity Linear`
  - `Sub UVAnimation`
  - `Solve Forces and Velocity`
  - `Particle State`
  - `Scale Sprite Size`
  - `Sprite Rotation Rate`
  - `Scale Color`
  - `Sprite Renderer`
- 当前选中模块：`Spawn Rate`
- `Spawn Rate` 参数
  - `SpawnRate = 15.0`
  - `Spawn Probability = 1.0`
- 预览结果
  - 左侧预览中的火焰团块数量明显减少，形体更容易分辨，不再像前面那样过度叠在一起。
  - 时间轴停在约 `2.22s`
  - 当前显示 `11 Particles`

这一帧对应本段“Spawn、UV、粒子”的首个控制点：当 UV 图集和粒子变化已经加入后，如果屏幕密度过高，就要先回到 `Spawn Rate` 降低生成数量，否则四个不同子图形的差异会被过多重叠粒子淹没。
这是为了单独观察 `SubUV` 四种变化而做的极简测试图。作者把 `Spawn Rate` 进一步降到几乎单粒子演示级别，并在原有随机子图选择之外，又加入一个线性 `Sub UVAnimation` 变体来观察生命周期中的帧变化。

- 当前发射器：`Empty`
- 当前选中模块：`Spawn Rate`
- `Spawn Rate` 参数
  - `SpawnRate = 1.0`
  - `Spawn Probability = 1.0`
- 发射器模块链可见为：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Shape Location`
  - `Add Velocity Linear`
  - `Sub UVAnimation Random`
  - `Solve Forces and Velocity`
  - `Particle State`
  - `Scale Sprite Size`
  - `Sprite Rotation Rate`
  - `Scale Color`
  - `Sub UVAnimation 001 Linear`
  - `Sprite Renderer`
- 预览结果
  - 左侧预览只剩很少量的红橙色火焰团，更便于肉眼追踪单个粒子的图块变化。
  - 时间轴停在约 `1.38s`。
- 字幕可确认的信息
  - 作者强调“它改变了这四个变体”。

这一帧说明本段正在做的不是单纯减粒子数，而是为了看清 `2x2` 图集的四种子图如何被使用：把 `Spawn Rate` 压低后，可以更直观地区分“随机挑一格”和“在粒子生命周期里顺序播放四格”这两类 SubUV 行为。
这张图回到 `Shapes` 贴图库，作者把搜索词改成 `fire`，开始对比不同火焰贴图以及更高变体数量的图集。字幕强调其中一张图集包含 `16` 种变化，说明后续不必局限在 `2x2` 的四帧结构里。

- 当前内容浏览器路径：
  - `Content / VFX_Library / Textures / Shapes`
- 搜索关键字：`fire`
- 当前结果数量：`26 items (1 selected)`
- 可见资源类型
  - 单张火焰轮廓贴图：如 `T_Fire2`、`T_Fire3`、`T_Fire4`、`T_Fire5`、`T_Fire6`、`T_Fire7`、`T_Fire8`、`T_Fire9`、`T_Fire10`
  - `2x2` 图集：如 `T_Fire1_2x2`、`T_Fire2_2x2`
  - 更大变体图集：可见被选中的 `T_Embers3_4x4`
  - 其他集合贴图：如 `T_Embers2_2x2`
- 当前选中资源：`T_Embers3_4x4`
  - 预览缩略图显示被切分成 `4x4` 的许多小火星/火焰轮廓
- 字幕可确认的信息
  - “这里有 16 种变体。”

这一帧的关键结论是：SubUV 变化数量由图集分块数决定，不必停留在 `2x2=4` 帧。像 `4x4` 图集就能提供 `16` 种不同轮廓，适合在更复杂或更长生命周期的粒子里减少重复感，但也会提高管理和索引选择的复杂度。

### 00:29:32-00:33:59 颜色

- 本段定位：颜色。
- 知识点：例如这个 哦,我没有加在那里 必须改变到 光亮的变化 我们保持 选择这里 选择这里 选择自己 需要 调节变化 现在有点亮 但调节变化 需要调节 一秒的生命时间。
- 知识点：2个变化 每秒变化 为了提升变化 也要选择 200-300的变化 如果变化成了 变化 那样就不太好 我们也需要 在变化时 先调节变化 但是它消失了。
- 知识点：因此 我们的颜色 也需要改变 变化 调节颜色 调节颜色 调节颜色 它会慢慢变化 然后它会变化 现在看看 中间的 光亮的变化 有点亮 我们需要 在中间 加上亮亮的。
- 知识点：光亮的 如果我们 看看这个例子 我们可观察到 中间有更多的 更具体的 更具体的 更有魅力 现在我们加 可以直接 复制 我觉得你也可以用 一样的材料。
- 知识点：我们只会 把它们的大小 剪辑 这种选择很适合我们 我只会把它们 单独删掉 按S在键盘上 缩尽率是正常的 首先 我们先调节 生命值的变化 从1-2秒。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这是红色发光材质实例 `MI_Glow_Red_01` 的调参画面。作者开始把之前的通用发光材质具体化为红橙色火焰版本，并重新启用 `Colormap`，让发光从中心高亮过渡到外围更深的暖色。

- 当前材质实例：`MI_Glow_Red_01`
- `Global Scalar Parameter Values`
  - `Premultiply Color? = 1.0`
  - `Use Colormap? = 1.0`
- `Global Texture Parameter Values`
  - `Colormap = VFX_T_ColorMap_Red_01`
  - `T_Main = T_Glow3`
- `General`
  - `Parent = M_UberMaterial`
- `Material Property Overrides`
  - `Opacity Mask Clip Value = 0.3333`
  - `Blend Mode = Translucent`
  - `Shading Model = Unlit`
- 预览结果
  - 左侧预览中可见一块半透明的红橙色弧形/边缘片段，说明当前材质已经不是纯白高亮，而是在渐变图控制下带有更明显的暖色层次。
  - 预览窗口底部提示正在把 `preview mesh` 设为平面 primitive，更便于观察纹理在平面上的真实色彩过渡。

这一帧对应本段“颜色”的第一步：不是先改 Niagara 粒子数量，而是先把基础发光材质实例染成更接近火焰的红橙色，并确保中间亮、边缘暗的色彩图逻辑已经生效。
这是 `NS_Wisp_Fire` 拆分发射器层次后的系统图。作者把原来的火焰层复制出一个新的中心发光层 `Glow_Main`，用来单独加强火焰核心的亮度和可读性。

- 系统：`NS_Wisp_Fire`
- 当前可见发射器
  - `Center_Fires`
  - `Glow_Main`
- `Center_Fires` 模块链可见为：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Shape Location Sphere`
  - `Add Velocity Linear`
  - `Sub UVAnimation Random`
  - `Solve Forces and Velocity`
  - `Particle State`
  - `Scale Sprite Size`
  - `Sprite Rotation Rate`
  - `Scale Color`
  - `Sprite Renderer`
- `Glow_Main` 模块链可见为：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Particle State`
  - `Scale Sprite Size`
  - `Scale Color`
  - `Sprite Renderer`
- 当前选中发射器/模块：`Glow_Main -> Scale Color`
- `Scale Color` 参数
  - `Scale Mode = RGB and Alpha Separately`
  - `Scale RGB = (1.0, 1.0, 1.0)`
  - `Scale Alpha = Float from Curve`
  - 曲线驱动为 `PARTICLES.NormalizedAge`
  - 曲线形状与前面火焰层相似：前期抬升，中后期逐步衰减
- 预览结果
  - 左侧预览里火焰中心出现更亮、更集中的红橙色核心。
  - 时间轴停在约 `6.96s`，当前 `Glow_Main` 显示 `2 Particles`。
- 字幕可确认的信息
  - 作者明确表示“我们可以直接复制它”。

这一帧的关键做法是：不在单一发射器里硬塞所有视觉职责，而是复制一个简化版本专门负责中心发光。这样 `Center_Fires` 处理外层火焰形状和变化，`Glow_Main` 则专注于中间最亮、最吸睛的内核层。
这是材质实例与 Niagara 系统并排调整的验证图，作者一边确认 `MI_Glow_Red_01` 的资源位置，一边在 `Glow_Main` 发射器里设置中心发光粒子的基础生命周期、颜色与尺寸，让火焰中间出现更稳定的亮核。

- 左侧内容浏览器
  - 当前路径：`Content / VFX_Library / Materials / Instances / Wisps`
  - 可见实例资源：
    - `MI_FireSoft_01`
    - `MI_Glow_Red_01`
  - 场景预览中可见一团更集中、更明亮的橙红色火焰核心
- 右侧系统：`NS_Wisp_Fire`
  - 当前发射器：`Glow_Main`
  - 当前选中模块：`Initialize Particle`
  - `Glow_Main` 当前显示 `2 Particles`
- `Initialize Particle` 中当前可见参数
  - `Lifetime Mode = Direct Set`
  - `Lifetime = 1.0`
  - `Color Mode = Direct Set`
  - `Color = (R 1.0, G 1.0, B 1.0, A 0.5)`
  - `Position = Simulation Position`
  - `Mass Mode = Unset / (Mass = 1)`
  - `Sprite Size Mode = Random Uniform`
  - `Uniform Min = 200.0`
  - `Uniform Max = 300.0`
  - `Sprite Rotation Mode = Unset`
  - `Sprite UV Mode = Unset`
- 预览/场景结果
  - 中心亮核比外层火焰更平滑、更大块，说明 `Glow_Main` 用的是更简单、更稳定的 Sprite 发光层。
  - 时间轴停在约 `5.43s`。
- 字幕可确认的信息
  - 作者还希望继续增加一些变化（variation）。

这一帧给出的核心做法是：中心发光层不需要复杂的 SubUV 或大幅飞散，只要用较大的 `Sprite Size = 200~300`、较低 `Alpha = 0.5` 和固定 `1.0s` 生命周期，就能先建立一个柔和的亮核心，再在后续继续叠加额外变化。

### 00:34:04-00:38:43 颜色、曲线、火焰

- 本段定位：颜色、曲线、火焰。
- 知识点：可以试试 但中间 它比较优势 可以也 例如 调节颜色 更亮 再调节颜色 现在中间 太亮了 光线来自中间 中间太亮了 调节颜色。
- 知识点：应该比较高 让这里 15 14会在这里 有点少 但比光亮大 这是中间 中间太亮了 太棒了 已经是很棒了 需要加个圆形 在边缘上 让效果更圆 首先我把这个。
- 知识点：Ctrl C Ctrl V 重新拥有 圆形 火圆可以叫什么 你想叫什么 我们还需要什么 我们需要选择圆形 圆形 我们有不同的变化 可以搅拌 试试 更具体的。
- 知识点：在这个情况下 这种东西 需要做 因为火是有强烈的特征 需要选择这种圆形 有软的 这种比较像魔术 我觉得是比较 实际的效果 这种可能是 自然的效果。
- 知识点：或者是光亮 需要看一看 这个颜色 明白它是什么 我们来拿这个 我们看到了不同的变化 它是比较软的 这里我转移到 这个颜色。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`、`曲线`、`火焰`。

**关键画面：**

这是 `NS_Wisp_Fire` 中 `Center_Fires` 发射器的细化图，作者正在压低中心层的尺寸和透明度波动，避免内核过亮、过大，同时保留一定的随机变化。

- 左侧内容浏览器路径：
  - `Content / VFX_Library / Materials / Instances / Wisps`
  - 可见实例资源：`MI_FireSoft_01`、`MI_Glow_Red_01`
- 右侧系统：`NS_Wisp_Fire`
  - 当前可见发射器：`Center_Fires`、`Glow_Main`
  - 当前选中发射器/模块：`Center_Fires -> Initialize Particle`
  - `Center_Fires` 当前显示 `17 Particles`
- `Initialize Particle` 当前可见参数
  - `Lifetime Mode = Random`
  - `Lifetime Min = 0.5`
  - `Lifetime Max = 1.0`
  - `Color Mode = Random Range`
  - 第一组颜色值：
    - `Red = 1.0`
    - `Green = 1.0`
    - `Blue = 1.0`
    - `Alpha = 0.5`
  - 第二组颜色值：
    - `Red = 1.0`
    - `Green = 1.0`
    - `Blue = 1.0`
    - `Alpha = 0.75`
  - `Link RGB` 已启用
  - `Position = Simulation Position`
  - `Mass Mode = Unset / (Mass = 1)`
  - `Sprite Size Mode = Random Uniform`
  - `Uniform Min = 50.0`
  - `Uniform Max = 100.0`
  - `Sprite Rotation Mode = Unset`
  - `Sprite UV Mode = Unset`
- 预览结果
  - 左侧场景中火焰核心更紧凑，亮度集中但没有上一批那样过度膨胀。
  - 时间轴停在约 `5.13s`。

这一帧的核心做法是：把中心层 `Center_Fires` 做得更小、更透明，并在 `Alpha 0.5~0.75` 范围内给一点随机波动。这样中心仍然足够亮，但不会把整团火焰洗成一团纯亮斑。
这是圆环形状贴图 `T_Circle23` 的查看画面。作者为火焰外围补充一个更圆、更完整的边缘层，目的是让整团火焰不只由中心和散开的火舌构成，还能带有一圈更清晰的环状轮廓。

- 当前资源标签：`T_Circle23`
- 纹理主预览
  - 黑底白色单通道风格。
  - 主体是一圈不规则但整体闭合的圆环，边缘带有燃烧感和毛刺状细节。
  - 中间区域基本为空，说明这是一张适合做边缘轮廓/外圈辉光的遮罩。
- 右侧 `Details` 中可见的基础信息
  - `Imported = 512x512`
  - `Displayed = 512x512`
  - `Max In-Game = 512x512`
  - `Resource Size = 171 KB`
  - `Has Alpha Channel = False`
  - `Method = Streamed`
  - `Format = DXT1`
  - `Number of Mips = 10`
  - `Encode Speed = Fast`
- 其他可见设置
  - `Texture Group = World`
  - `Editor Show Final Encode` 已启用
  - `Availability = GPU`
  - `sRGB` 已启用
  - `X-axis Tiling Method = Wrap`
  - `Y-axis Tiling Method = Wrap`

这张图对应正文里“给边缘加个圆形，让效果更圆”的资源依据：`T_Circle23` 不是中心火焰贴图，而是一个带噪声边缘的圆环遮罩，适合做外围火圈、边缘辉光或包裹轮廓层。
这是把圆环边缘层接回 `NS_Wisp_Fire` 后的系统图。作者新增了 `FireRing_Main` 发射器，让火焰外围出现一圈更完整的圆形包边，同时保留 `Glow_Main`、`Glow_Center` 和 `Center_Fires` 作为内部发光层。

- 当前系统：`NS_Wisp_Fire`
- 当前可见发射器
  - `Center_Fires`
  - `FireRing_Main`
  - `Glow_Center`
  - `Glow_Main`
- 当前选中发射器/模块：`FireRing_Main -> Scale Color`
- `FireRing_Main` 模块链可见为：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Particle State`
  - `Scale Sprite Size`
  - `Scale Color`
  - `Sprite Renderer`
- `Scale Color` 参数
  - `Scale Mode = RGB and Alpha Separately`
  - `Scale RGB = (1.0, 1.0, 1.0)`
  - `Scale Alpha = Float from Curve`
  - 曲线驱动为 `PARTICLES.NormalizedAge`
  - 可见曲线：
    - 起始很低
    - 很快升到接近峰值
    - 随后沿生命周期逐步衰减回低值
- 预览结果
  - 左侧预览中，火焰外围已经出现一圈很淡的圆形发光包边，使整体轮廓更接近“中心亮核 + 外圈火环”的结构。
  - 时间轴停在约 `6.54s`。

这一帧把本段“颜色、曲线、火焰”的思路落成了结构化分层：`Center_Fires` 负责主体火舌，`Glow_Main/Glow_Center` 负责内部高亮，而 `FireRing_Main` 专门负责外围圆环。这样能用独立曲线控制边缘层的出现和消失，不会把所有视觉任务都塞进同一个发射器里。

### 00:38:48-00:41:33 颜色、曲线

- 本段定位：颜色、曲线。
- 知识点：我们的α有这种曲线 我还会加一个刷率 我还会加一个刷率 需要它会随机逃跑 我还会加一个随机 这里让它有变化 首先 需要增加逃跑的刷率 第二。
- 知识点：需要加转移的刷率 让在生命中 会有随机转移 我需要改变颜色 需要把它变成红色 加个随机 再加个红色 变成第二个软色 可以玩色彩 可以刷α。
- 知识点：0.6 这样它不会太亮 因为我们需要 它不要太有趣 所以它会比较中间 太棒了 需要改变它 看起来很棒 它会有点抖动 这里的刷率开始 慢慢地变色 需要有这种曲线。
- 知识点：从形状开始 已经很清楚 这是我们的球场 完美 体积是正常的 对于角色。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`、`曲线`。

**关键画面：**

这是 `NS_Wisp_Fire` 当前多层结构的再次验证图，作者还没有开始下一层的具体参数设置，但字幕已经明确接下来还会额外添加一个 `sprite` 层，用来继续丰富火焰的层次变化。

- 当前系统：`NS_Wisp_Fire`
- 当前可见发射器
  - `Center_Fires`
  - `FireRing_Main`
  - `Glow_Center`
  - `Glow_Main`
- 当前选中发射器/模块：`FireRing_Main -> Scale Color`
- `FireRing_Main`
  - 当前显示 `1 Particles`
  - `Scale Color` 仍使用 `RGB and Alpha Separately`
  - `Scale Alpha = Float from Curve`
  - 曲线驱动对象为 `PARTICLES.NormalizedAge`
  - 可见曲线仍是“快速升高后逐步衰减”的形态
- 预览结果
  - 左侧场景中已能清楚看到一圈淡橙色外环包围中心亮核。
  - 整体层次已经具备：
    - 中间亮核
    - 外层火焰主体
    - 更淡的外围圆环
  - 时间轴停在约 `2.97s`
- 字幕可确认的信息
  - 作者表示“我还会添加一个 sprite”。

这一帧的意义在于确认当前三层火焰结构已经站得住，然后再继续叠加新的 Sprite 层。此时能确认的是“还要加层”，但还不能从这张图可靠判断新层的名称、参数或具体贴图。
这是 `FireRing_Main` 的 `Initialize Particle` 调色图，作者正在直接调整外圈火环的颜色和透明度，让它保持暖橙色但不要过亮、过抢眼。

- 当前系统：`NS_Wisp_Fire`
- 当前可见发射器
  - `Center_Fires`
  - `FireRing_Main`
  - `Glow_Center`
  - `Glow_Main`
- 当前选中发射器/模块：`FireRing_Main -> Initialize Particle`
- `Initialize Particle` 当前可见关键信息
  - `Lifetime Mode = Random`
  - `Lifetime Min = 0.5`
  - `Lifetime Max = 1.0`
  - `Color Mode = Random Range`
  - 颜色字段正在编辑中，且已打开 `Color Picker`
  - 当前颜色选择器可见值：
    - `R = 1.0`
    - `G ≈ 0.143194`
    - `B ≈ 0.007736`
    - `A = 1.0`（颜色选择器当前值）
    - `Hex Linear = FF2502FF`
    - `Hex sRGB = FF6A15FF`
- 字幕可确认的信息
  - 作者明确说“可以编辑 alpha 为 `0.6`”。
- 预览状态
  - 左侧预览窗口此时基本没有显著火焰形态，说明当前重点是参数编辑，而不是展示完整结果。
  - 时间轴停在约 `0.27s`。

这一帧说明外圈火环需要单独调色和压透明度：虽然颜色本身仍是偏红橙的暖色，但作者希望把它的 `alpha` 调到约 `0.6`，这样环形层只作为边缘辅助，不会比中心亮核更吸引注意力。
这是 `NS_Wisp_Fire` 放回场景中的验证图，用来确认外圈圆环、中心亮核和整体体积在角色尺度下是否协调。

- 当前关卡/场景：`Stylized_Wisps`
- Outliner 当前选中对象：`NS_Wisp_Fire`
- 详情面板对象：`NS_Wisp_Fire (Instance)`
  - `Location = (-195.28, 50.9843, 134.913)`
  - `Rotation = (0.0, 0.0, 0.0)`
  - `Scale = (1.0, 1.0, 1.0)`
  - `Niagara System Asset = NS_Wisp_Fire`
  - `Niagara Tick Behavior = Use Prereqs`
  - `Allow Scalability` 已启用
- 场景结果
  - 角色左侧地面上方悬浮着一团小型橙红色火焰。
  - 中心是一颗更亮的发光核。
  - 外围包着一圈较淡、较软的圆环边缘，说明 `FireRing_Main` 已经生效。
  - 整体体积相对角色较小，符合前文“不要太大、不要太亮”的调整方向。

这一帧的作用是做比例和可读性校验：在素材窗口里调出来的颜色与曲线，只有放回真实角色旁边才能判断是否过大、过亮或轮廓过硬；当前结果表明这团火焰已经具备清晰中心、柔和外环和合适体积。

### 00:41:37-00:46:34 颜色、曲线、火焰

- 本段定位：颜色、曲线、火焰。
- 知识点：接下来 我还想要这个曲线 它比较多 但可以加几种变化 例如 火焰曲线 需要慢慢地 变成一个软球 我们怎么做呢 首先 需要它们变得更少 第二 最初的尺寸是随机。
- 知识点：125cm 不 太大了 125cm和135cm 可能会变成 最小的变化 最重要的是 要改变光线 这些会是 更多的详细 我们需要 变得很少 变成更多的软球。
- 知识点：需要再次 调整软球的转化 你必须要试试 看看它是如何 我还想把它们 从中间增加 这会很酷 我们调整一点 让它们在最后 慢慢地变化 可能需要 再改变它。
- 知识点：需要再多做 需要做另一个 大小 它会变成 1秒 它会变得 比起最初的一样 需要再次 变成更长的 第二 增加它的尺寸 我们看看它是如何 需要把颜色。
- 知识点：调整得更少 更少 需要改变 变成 每两秒 需要再次 调整它的 超级 它是很酷的 很酷 可以 调整到 更多的颜色。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`、`曲线`、`火焰`。

**关键画面：**

这是 `NS_Wisp_Fire` 中 `FireRing_Main` 发射器的节奏细化图。作者在这一段开始压低外圈火环的生成数量，并继续保留较短生命周期，让边缘层更像一圈柔和、偶发的火焰轮廓，而不是持续存在的粗重光环。

- 当前系统：`NS_Wisp_Fire`
- 当前可见发射器
  - `Center_Fires`
  - `FireRing_Main`
  - `Glow_Center`
  - `Glow_Main`
- 当前选中发射器：`FireRing_Main`
  - 当前显示 `3 Particles`
- `Emitter Properties`
  - `Interpolated Spawning = true`
  - `Sim Target = CPUSim`
  - `Calculate Bounds Mode = Dynamic`
- `Emitter State`
  - `Life Cycle Mode = Self`
  - `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
  - `Loop Behavior = Infinite`
  - `Loop Duration = 1.0`
  - `Loop Delay = 0.0`
- `Spawn Rate`
  - `SpawnRate = 4.0`
  - `Spawn Probability = 1.0`
- `Initialize Particle` 中当前可见参数
  - `Lifetime Mode = Random`
  - `Lifetime Min = 0.5`
  - `Lifetime Max = 1.0`
- 预览结果
  - 左侧预览里外围圆环比前一段更克制，中心亮核仍保留。
  - 时间轴停在约 `8.93s`。

这一帧体现的是“颜色、曲线、火焰”之外的密度控制：外圈环形层如果数量太多，会让火焰显得僵硬且过度装饰，因此先把 `Spawn Rate` 压到 `4.0`，再通过后续颜色和曲线去调细节。
这是 `NS_Wisp_Fire` 放回角色旁边后的阶段性验证图。当前火焰已经形成“中心亮点 + 柔和外环”的清晰层次，字幕说明作者还会再做一层，意味着这个结果已经足够稳定，可以继续叠加更多变化。

- 当前场景：`Stylized_Wisps`
- Outliner 当前选中对象：`NS_Wisp_Fire`
- 详情面板对象：`NS_Wisp_Fire (Instance)`
  - `Location = (-195.28, 50.9843, 134.913)`
  - `Rotation = (0.0, 0.0, 0.0)`
  - `Scale = (1.0, 1.0, 1.0)`
  - `Niagara System Asset = NS_Wisp_Fire`
  - `Niagara Tick Behavior = Use Prereqs`
  - `Allow Scalability` 已启用
- 场景结果
  - 角色左侧悬浮着一团小型火焰球。
  - 中间是一颗橙白色高亮核心。
  - 外围是一圈淡红橙色软边圆环，比上一段更平衡，不会过厚也不会抢走主体。
  - 整体体积与角色相比偏小，符合“作为 wisps / 小火团”的尺度。
- 字幕可确认的信息
  - 作者表示“我们会再做一个”。

这一帧的作用是确认当前球形火焰已经有了足够清楚的体积和轮廓，因此下一步不是修补基础结构，而是在现有基础上继续复制/派生新的层次，增加变化但不破坏整体比例。
这是另一张圆环类贴图的查看界面，用来为下一层更软、更大的火焰外环提供备选资源。相比前面那张边缘较细的圆环，这张贴图整体更亮、更厚，适合做更明显的包裹层或软球式外轮廓。

- 当前资源标签：`T_Circle21`
- 纹理主预览
  - 黑底白色单通道风格。
  - 主体是一圈更厚、更亮的圆环。
  - 环边缘存在较多向外扩散的辉光状尖刺与模糊羽化。
  - 中间仍然留空，保持典型环形遮罩结构。
- 右侧 `Details` 可见信息
  - `Imported = 256x256`
  - `Displayed = 256x256`
  - `Max In-Game = 256x256`
  - `Resource Size = 43 KB`
  - `Has Alpha Channel = False`
  - `Method = Streamed`
  - `Format = DXT1`
  - `Number of Mips = 9`
  - `Encode Speed = Fast`
- 其他可见设置
  - `Texture Group = World`
  - `Editor Show Final Encode` 已启用
  - `Availability = GPU`
  - `sRGB` 已启用
  - `X-axis Tiling Method = Wrap`
  - `Y-axis Tiling Method = Wrap`

这张图对应正文里“需要再做另一个、变成更多的软球”的资源选择思路：`T_Circle21` 比前面的环更厚、更柔，可以用于派生第二个外围层，帮助火焰从单一薄环过渡成更柔和、更有体积感的包裹外轮廓。

### 00:46:34-00:51:04 Spawn、Alpha、UV

- 本段定位：Spawn、Alpha、UV。
- 知识点：围绕当前效果继续调整 Niagara 系统，需结合关键画面确认实际节点和参数。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Spawn`、`Alpha`、`Add`、`Translucent`、`Additive`、`颜色`。

**关键画面：**

这一帧显示在 `NS_Wisp_Fire` 系统内新增并选中发射器 `Smoke_Main`，用于给当前火焰核外侧补一层柔和烟雾。界面下方时间轴时间约为 `8.54s`，当前系统中可见的发射器依次包括 `Center_Fires`、`FireRing_Main`、`FireRing_Scale`、`FireRing_ScaleBig`、`Glow_Center`、`Glow_Main` 和 `Smoke_Main`。

`Smoke_Main` 当前统计为 `2 Particles`。堆栈中可见模块顺序为：`Emitter Spawn`、`Emitter Update`、`Emitter State`、`Spawn Rate`、`Initialize Particle`、`Particle State`、`Scale Sprite Size`、`Scale Color`、`Renderer`、`Sprite Renderer`。这说明本段开始进入烟雾层的生成节奏、透明度和尺寸控制，而不是继续修改前面的火环发射器。

右侧 `Sprite Renderer` 详情面板可确认的渲染设置如下：

- `Material = MI_SmokeSoft_01`
- `Material User Param Binding = None`
- `Source Mode = Particles`
- `Alignment = Automatic`
- `Facing Mode = Automatic`
- `Macro UVRadius = 0.0`
- `Default Pivot in UV Space = (0.5, 0.5)`
- `Remove HMD Roll` 未启用
- `Pixel Coverage Mode = Automatic`
- `Pixel Coverage Blend = 1.0`
- `Min Facing Camera Blend Distance = 0.0`
- `Max Facing Camera Blend Distance = 0.0`
- `Sort Mode = None`
- `Enable Camera Distance Culling` 未启用
- `Renderer Visibility = 0`

左侧预览窗口可见效果是：中心仍然保留高亮橙白火核，外围开始出现一圈很淡的红橙烟雾晕边，说明 `Smoke_Main` 的职责是把原本偏硬的火焰外轮廓过渡得更柔和。
这一帧切到内容浏览器，展示 `VFX_Library/Materials/Instances/Wisps` 文件夹中用于当前效果的几张材质实例，说明本段除了调整 `Spawn` 外，也在对火焰与烟雾层的 `Alpha` 表现做素材准备和挑选。当前可见的 4 个实例分别是：

- `MI_FireRingSoft_Red_01`
- `MI_FireSoft_01`
- `MI_Glow_Red_01`
- `MI_SmokeSoft_Alpha_01`

当前高亮选中的资源是 `MI_FireSoft_01`，缩略图显示为数个发红发橙的软边火斑，适合给主体火焰粒子使用。当前打开的顶部标签则是 `MI_SmokeSoft_Alpha_01`，右上 `Details` 面板能确认到两项全局标量参数：

- `Premultiply Color? = 1.0`
- `Use Colormap? = 0.0`

从这组资源可以读出本段材质分工：火环、火点、中心发光和烟雾分别使用独立的材质实例控制透明度与颜色表现。尤其 `MI_SmokeSoft_Alpha_01` 的命名和参数状态表明，烟雾层更依赖 Alpha 软边，而不是高强度加色发光。
这一帧回到 `NS_Wisp_Fire` 的 `Smoke_Main` 发射器，开始细化烟雾粒子的旋转与消散节奏。时间轴约为 `3.73s`，左侧预览能看到一团偏灰黑的软烟贴在火焰中心上方，说明烟雾已经从单纯的发光晕边转为更明确的体积遮罩层。

`Smoke_Main` 当前可见的模块顺序比上一帧更完整，除原有发射与渲染模块外，还新增或显示出以下粒子模块：

- `Sub UVAnimation`，模式可见为 `Random`
- `Add Velocity`，模式可见为 `Linear`
- `Solve Forces and Velocity`
- `Sprite Rotation Rate`
- `Scale Sprite Size`
- `Scale Color`

右侧当前展开的是 `Sprite Rotation Rate` 模块，其 `Rotation Rate` 输入被设置为 `Float from Curve`。曲线编辑器可确认：

- 曲线类型：`Curve for Floats`
- `CurveIndex = PARTICLES.NormalizedAge`
- `Scale Curve = 1.0`
- `Delta Time = ENGINE.DeltaTime`
- 曲线形状为从粒子生命前段的较高值，线性下降到生命末段接近 `0` 的一条斜线

这意味着烟雾精灵在出生时旋转更明显，随后随着 `NormalizedAge` 增长逐渐减慢，配合 `Scale Color` 或材质 Alpha 一起衰减。对复现而言，本段的关键不是单独调一个常数，而是让旋转速度跟随粒子生命周期衰减，这样烟雾会更自然，不会始终以同样速度打转。

### 00:51:04-00:55:40 Spawn、Velocity、速度

- 本段定位：Spawn、Velocity、速度。
- 知识点：在生命中,它们已经是从1到0 但我们也会再次数150 它们会是从150到0 或是200到0 它们会随时在这个时段中选择 它们会很快速的飞向。
- 知识点：随时飞向 我喜欢这个颜色 您必须想想这个Sprite Size 需要把它编辑成 Spawn。
- 知识点：比较大 或者更小的,还有一个很棒的东西 叫做Scale Velocity 它会做什么? 我们有一个速度,可以编辑。
- 知识点：用Scale Velocity 编辑 X Y Z 如果我把所有数字都编辑成0 那么X 会变成0 为什么0? 因为它只会升起降落,因为 Z 还留下了 您可以理解。
- 知识点：您可以分开编辑速度 在生命中的一个体 我们把最初的编辑编辑成0 然后可以编辑 让它从图线上飞向 让它们都在同一个角度 我们加一个弧度。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 核对对象：`Spawn`、`Velocity`、`速度`、`颜色`。

**关键画面：**

这一帧继续编辑 `NS_Wisp_Fire` 中 `Smoke_Main` 发射器的 `Sprite Rotation Rate` 模块，重点不再是曲线形状，而是给旋转速率增加出生时的随机强度范围。界面下方时间轴约为 `1.63s`，当前 `Smoke_Main` 统计为 `45 Particles`，左侧预览可见一团向上飘散的深色烟雾。

右侧 `Rotation Rate` 输入仍为 `Float from Curve`，并保持：

- `CurveIndex = PARTICLES.NormalizedAge`
- `Delta Time = ENGINE.DeltaTime`

在此基础上，`Scale Curve` 被改成一个 `Random Range Float`，可确认参数为：

- `Minimum = 150.0`
- `Maximum = 200.0`
- `Evaluation Type = Spawn Only`

结合上方曲线从生命周期起点较高值下降到末尾接近 `0` 的形状，这一设置的含义是：每个烟雾粒子在出生时会随机抽取一个 `150` 到 `200` 之间的初始旋转强度，然后再随着 `NormalizedAge` 逐步减速到接近停止。这样同一批烟雾不会整齐一致地旋转，而是带有更自然的离散感。
这一帧继续在 `Smoke_Main` 发射器中调速度，但目标从“给多少初速度”转成“生命周期内如何缩放速度”。时间轴约为 `8.99s`，左侧预览能看到一团较深的烟雾向上聚拢，说明当前关注点是烟雾运动轨迹，而不是颜色或贴图。

当前选中的模块是 `Scale Velocity`，它位于 `Add Velocity` 与 `Solve Forces and Velocity` 之间。可确认的设置有：

- `Coordinate Space = Local`
- `Velocity Scale = Vector from Float`
- `Value = Float from Curve`
- 曲线类型为 `Curve for Floats`
- `CurveIndex = PARTICLES.NormalizedAge`
- `Scale Curve = 1.0`

曲线形状可见为三段式：

- 粒子出生时从 `0` 起步
- 很快抬升到前段峰值
- 随后随着生命周期推进持续衰减，并在尾段回到接近 `0`

这表示烟雾不会一出生就以满速飞散，而是先短暂加速，再逐步减速收尾。由于 `Velocity Scale` 使用的是单个浮点曲线去驱动向量缩放，当前截图只能确认 X/Y/Z 速度会统一乘上同一条生命周期曲线；没有显示单独拆开的轴向系数，因此不能把它写成分别控制某一轴。
这一帧显示教程在保留 `Smoke_Main` 的同时，又新增了一个结构非常接近的烟雾发射器 `Smoke_Top`，用于补充火焰上方的烟雾层。时间轴约为 `1.86s`，左侧预览可以看到橙色火焰核心外侧已有一层暗色烟雾，说明新发射器是在现有效果上继续叠层，而不是替换原来的烟雾。

画面中央同时可见两个发射器：

- 左侧：`Smoke_Main`
- 右侧：`Smoke_Top`

两者可见模块结构基本一致，`Smoke_Top` 也包含：

- `Emitter State`
- `Spawn Rate`
- `Initialize Particle`
- `Sub UVAnimation`（`Random`）
- `Add Velocity`（`Linear`）
- `Scale Velocity`
- `Solve Forces and Velocity`
- `Particle State`
- `Sprite Rotation Rate`
- `Scale Sprite Size`
- `Scale Color`
- `Sprite Renderer`

右侧详情面板当前选中的是 `Smoke_Top` 的 `Spawn Rate`，可确认：

- `SpawnRate = 150.0`
- `Spawn Probability = 1.0`

这说明 `Smoke_Top` 的第一步改动是先给顶部烟雾设定一个较高而稳定的持续生成率，再沿用与 `Smoke_Main` 类似的速度、旋转和尺寸衰减逻辑去塑形。仅从当前截图能确认它是“新增顶部烟雾层并设置 Spawn Rate”，还不能把它写成已经改了颜色、材质或单独的速度数值，因为这些参数在本帧没有展开显示。

### 00:55:40-01:00:38 粒子

- 本段定位：粒子。
- 知识点：它是必须让它飞上去的 可以不利于加速 做一个有趣的事情 加速力,它会把它拉上去 不止下降,而是升上去 让它升到500,现在它没什么。
- 知识点：需要有烧烧 您可以随意把烧烧弄到1到3 我认为其他东西都很好 例如您可以改变烧烧的额外 您可以让它飞得更高 您可以用重量调整到800。
- 知识点：您也可以用选项重量调整 我还是想加个位置 让它有些生产的变化 有趣的是,我为什么 把烧烧的黑色分成了红色 我们做了一个效果 烧烧被烧烧的灯光。
- 知识点：而成功的效果是黑色的 我还会改变烧烧额外 或者需要降落 我还会改变烧烧的波逊 您可以依旧试试看烧烧 这里有很多细节 可能太大了 或者它飞得太快了。
- 知识点：看起来很酷 可以加点粒子 像是石头 石头飞上去 需要把烧烧写上去 然后再写下来 我们要知道 如果我们有这种东西 在涂料本体上 去到形状 我们有什么相似的东西吗。
- 核对对象：`粒子`。

**关键画面：**

这一帧继续编辑顶部烟雾发射器 `Smoke_Top`，当前打开的是 `Initialize Particle` 模块，用来决定顶部烟雾粒子出生时的寿命、颜色和基础尺寸。时间轴约为 `1.15s`，`Smoke_Top` 当前统计为 `28 Particles`；左侧预览可见火焰核心上方已有一层较淡的灰烟，与外圈红橙发光层分离。

画面中央同时保留 `Smoke_Main` 和 `Smoke_Top` 两个发射器，说明这里是在复制已有烟雾方案后，再单独重调顶部层参数，而不是回头修改主烟雾层。

右侧 `Initialize Particle` 面板当前可确认的设置有：

- `Lifetime Mode = Random`
- `Lifetime Min = 0.5`
- `Lifetime Max = 1.0`
- `Color Mode = Random Range`
- `Color Channel Mode = Link RGB / Link A`
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 0.0)`
- `Mass Mode = Unset / ((Mass of 1))`
- `Sprite Size Mode = Random Uniform`
- `Uniform Sprite Size Min = 50.0`
- `Uniform Sprite Size Max = 70.0`
- `Sprite Rotation Mode = Random`
- `Sprite UV Mode = Unset`

颜色最小值与最大值都显示为深灰到棕黑之间的色块，说明 `Smoke_Top` 这一层的粒子不是做高亮火苗，而是做偏暗、偏脏的烟尘。结合 `50` 到 `70` 的随机统一尺寸，它会生成一批中等大小、寿命较短、旋转随机的顶部烟雾粒子，用来给火焰上方增加更自然的烧灼感。
这一帧继续调整 `Smoke_Top`，重点从单个粒子属性转到“顶部烟雾如何生成并受力运动”。时间轴约为 `0.11s`，右侧展开的是 `Spawn Rate`，可确认：

- `SpawnRate = 40.0`
- `Spawn Probability = 1.0`

相比上一批中 `Smoke_Top` 初始建立时显示的 `SpawnRate = 150.0`，这里明显把顶部烟雾的持续生成密度压低，避免顶部层过厚。

同时，`Smoke_Top` 当前可见模块结构也已经与 `Smoke_Main` 拉开差异。除了 `Initialize Particle`、`Sub UVAnimation`、`Particle State`、`Sprite Rotation Rate`、`Scale Sprite Size`、`Scale Color`、`Sprite Renderer` 外，还能确认以下变化：

- `Add Velocity` 仍存在，但当前显示为关闭状态
- 新增 `Shape Location`，模式可见为 `Sphere`
- 新增 `Gravity Force`
- 新增 `Drag`
- 保留 `Solve Forces and Velocity`

这说明 `Smoke_Top` 不再只是简单复制主烟雾层，而是开始用球形分布和受力模块去塑造“向上漂、逐渐受阻”的顶部烟雾运动。仅从这一帧可确认的是模块结构与发射密度变化，还不能写出 `Gravity Force` 或 `Drag` 的具体数值，因为参数面板没有展开这些模块。
这一帧回到关卡 `Stylized_Wisps` 中检查整体结果，确认前面为 `Smoke_Top` 增加的粒子层已经在场景里形成更完整的火焰加烟雾效果。画面中央左侧是 `NS_Wisp_Fire` 实例，右侧有一个角色模型用于对比粒子尺度。

场景中的当前效果特征可以直接确认：

- 中心是高亮的橙白火核
- 外侧保留一圈偏红橙的柔和环形发光
- 火核上方叠加了更暗、更脏的烟雾晕层
- 整体体量仍然偏小，适合作为 wisp 类悬浮火焰

右侧 `Details` 面板当前对象是 `NS_Wisp_Fire (Instance)`，可确认：

- `Location = (-195.28, 50.9843, 134.9131)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Niagara System Asset = NS_Wisp_Fire`
- `Niagara Tick Behavior = Use Prereqs`
- `Allow Scalability` 已启用

下方内容浏览器仍停留在 `VFX_Library/Materials/Instances/Wisps` 文件夹，能看到当前效果用到的是一组火环、火点、发光和烟雾 Alpha 材质实例，其中包含若干 `Add` 版本以及 `SmokeSoft_Alpha` 版本。当前高亮选中的资源是一个 `SmokeSoft_Alpha` 材质实例，说明本段最后是在场景中连同材质实例一起做整体观感核对，而不是只在 Niagara 堆栈里孤立调参数。

### 01:00:38-01:04:14 颜色

- 本段定位：颜色。
- 知识点：让我们来看看这个颜色 让我们放在这里 我们不会用颜色圖 因为会有两种变化 黑色和亮色 我们看看颜色。
- 知识点：仍然有边线 但这里它们不容易被显示 我们用了变色 可观察到结果的变化 它不会再变色 而且变得更亮 可以做两种变化 一种是α 另一种是加 一种会亮。
- 知识点：另一种会黑 我们选择这个颜色 把它换掉 这里的所有东西都在设计 但这些块子很大 它们必须小 你必须改变它们的尺寸 我们叫它 我们选择颜色比较深。
- 知识点：增加颜色的刷新 这里会变成红 需要尽力 应该比较深 红和橙色之间 看起来很酷 我选择DW 让它变成0 太高了 太快了 你能让它们飞向边缘 你能让它们飞向上。
- 知识点：让它们飞向上 形状位置 加速 预算从图中 选择选择-70,70 这是第一个项目 这是开始 突然之间它们已经飞向了 第三个项目 需要不想它们飞得太快。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这一帧打开的是材质实例 `MI_Pieces_Alpha_01`，用于给碎片类粒子准备颜色和透明度表现。左侧预览可见若干白色碎片形状，说明当前关注的是碎片贴图本身的可见轮廓；右侧 `Details` 面板可确认以下实例参数：

- `Premultiply Color? = 1.0`
- `Use Colormap? = 0.0`

全局纹理参数：

- `Colormap = VFX_T_ColorMap_Red_02`
- `T_Main = T_Pieces_01_2x2`

通用与材质覆盖设置：

- `Parent = M_UberMaterial`
- `Blend Mode = Translucent`
- `Shading Model = Unlit`
- `Two Sided` 未启用
- `Dithered LODTransition` 未启用
- `Output Translucent Velocity` 未启用
- `Has Pixel Animation` 未启用
- `Enable Tessellation` 未启用
- `Preview Mesh = None`

从这些设置可以确认本段是在准备“偏 Alpha 的碎片材质”而不是加色发光材质。`T_Pieces_01_2x2` 提供碎片形状，`VFX_T_ColorMap_Red_02` 提供红橙色带，但因为 `Use Colormap?` 当前是 `0.0`，所以这一帧更像是在对比是否启用色带映射，以及让碎片保持更干净的明暗轮廓，再决定后续颜色走向。
这一帧在 `NS_Wisp_Fire` 中新增并选中发射器 `Pieces_Top_Glow`，开始给顶部碎片层设置更亮的暖色调。时间轴约为 `0.33s`，画面中央同时可见：

- 左侧发射器：`Smoke_Top`
- 右侧发射器：`Pieces_Top_Glow`

`Pieces_Top_Glow` 当前统计为 `10 Particles`。其模块结构与 `Smoke_Top` 接近，当前可见：

- `Initialize Particle`
- `Sub UVAnimation`，模式可见为 `Random`
- `Shape Location`，模式可见为 `Sphere`
- `Gravity Force`
- `Drag`
- `Solve Forces and Velocity`
- `Particle State`
- `Sprite Rotation Rate`
- `Scale Sprite Size`
- `Scale Color`
- `Sprite Renderer`

右侧展开的是 `Initialize Particle`，可确认：

- `Lifetime Mode = Random`
- `Lifetime Min = 0.5`
- `Lifetime Max = 1.0`
- `Color Mode = Random Range`
- `Color Channel Mode = Link RGB / Link A`

当前打开了颜色选择器，正在编辑 `Color Minimum`。颜色选择器里能直接确认的新颜色为：

- `R = 0.935268`
- `G = 0.254057`
- `B = 0.094859`
- `A = 0.2`
- `Hex Linear = EE411833`
- `Hex sRGB = F8BA5733`

右侧 `Color Minimum` 与 `Color Maximum` 色条都落在橙红到橙黄范围内，说明 `Pieces_Top_Glow` 不是黑灰烟雾层，而是更亮、更热的顶部碎片/余烬层。左侧预览里也能看到火核上方出现更偏橙红的细小亮点，符合“在烟雾上方补一层发光碎片”的用途。
这一帧继续停留在 `Pieces_Top_Glow` 的 `Initialize Particle` 模块，但颜色和尺寸参数已经明确写成具体数值。时间轴约为 `0.06s`，左侧预览可见顶部碎片层已经变成一批细小的红橙色发光颗粒，叠在火核与烟雾上方。

当前可确认的 `Color Mode` 仍为 `Random Range`，并且最小/最大颜色分别是：

- `Color Minimum`
  - `Red = 1.0`
  - `Green = 0.301843`
  - `Blue = 0.0`
  - `Alpha = 0.1`
- `Color Maximum`
  - `Red = 0.94122`
  - `Green = 0.0`
  - `Blue = 0.01281`
  - `Alpha = 0.2`

`Color Channel Mode = Link RGB / Link A`，因此每个粒子会在这组暖色范围内随机取色，同时 Alpha 也只在 `0.1` 到 `0.2` 之间浮动。这会让碎片保持发亮，但不会因为透明度太高而变成大片实心色块。

同一面板中还能确认的粒子初始化参数包括：

- `Lifetime Mode = Random`
- `Lifetime Min = 0.5`
- `Lifetime Max = 1.0`
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 0.0)`
- `Mass Mode = Unset / ((Mass of 1))`
- `Sprite Size Mode = Random Uniform`
- `Uniform Sprite Size Min = 5.0`
- `Uniform Sprite Size Max = 10.0`
- `Sprite Rotation Mode = Random`
- `Sprite UV Mode = Unset`

与前面烟雾层 `50-70` 的尺寸相比，这里把粒子尺寸压到 `5-10`，说明 `Pieces_Top_Glow` 的目标是做细小余烬，而不是大块烟雾或软边贴片。结合 `Shape Location`、`Add Velocity`、`Gravity Force` 和 `Drag` 这些已可见模块，它会形成一批向上散开的暖色小碎片。

### 01:04:21-01:07:03 速度、颜色

- 本段定位：速度、颜色。
- 知识点：不错 如果我们有项目亮 需要有项目黑 有些会是黑 有些会是黑 我们就把颜色改成黑 这是黑黑的 但他们肯定比较有色彩 在看黑黑的 这些是黑黑的和黑黑的混合。
- 知识点：在整体上 你能让黑黑的人 不知道 但如果是火 需要很感激 它们飞向直上 但如果是黑黑的 需要很感激 它们飞向直上 但我认为 必须加上 首先加上更多的颜色。
- 知识点：2.5 因为它们必须停止 最后 不要飞太快 还有飞行速度 哦,是 飞行速度 然后我们 是的 飞行速度 影响了重量 以及一切的影响 这可能是 我还是拿了。
- 知识点：而在黑黑的时间后 可能会让它们 往旁边散发 再往旁边散发 再往旁边散发 以及由重量增加 所以它们不会飞上 但在旁边 一些往上 一些往旁边 是的 让我们看看。
- 知识点：我们还是这样 我还是这样 这种煤气 也是这样 我真的不喜欢 可能是 线位25 看看它会 跟所有东西一样 是的,不 线位25 可能需要 简单地增加 最初颜色。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`速度`、`颜色`。

**关键画面：**

这一帧在 `NS_Wisp_Fire` 中复制或派生出了一个新的顶部碎片发射器 `Pieces_Top_Dark`，用于和前面的亮色碎片层 `Pieces_Top_Glow` 形成冷暖、明暗对比。画面中央同时可见两个结构接近的发射器：

- `Pieces_Top_Glow`
- `Pieces_Top_Dark`

当前选中的是 `Pieces_Top_Dark`。右侧面板可确认的发射器级设置包括：

- `Interpolated Spawning` 已启用
- `Sim Target = CPUSim`
- `Calculate Bounds Mode = Dynamic`
- `Life Cycle Mode = Self`
- `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
- `Loop Behavior = Infinite`
- `Loop Duration = 1.0`
- `Loop Delay = 0.0`

当前 `Spawn Rate` 模块参数可确认：

- `SpawnRate = 20.0`
- `Spawn Probability = 1.0`

`Initialize Particle` 可见的基础寿命设置为：

- `Lifetime Mode = Random`
- `Lifetime Min = 0.5`
- `Lifetime Max = 1.0`

从堆栈结构看，`Pieces_Top_Dark` 保留了和亮色碎片层几乎相同的模块骨架：`Initialize Particle`、`Sub UVAnimation (Random)`、`Shape Location (Sphere)`、`Add Velocity (Linear)`、`Gravity Force`、`Drag`、`Solve Forces and Velocity`、`Particle State`、`Sprite Rotation Rate`、`Scale Sprite Size`、`Scale Color`、`Sprite Renderer`。差异首先出现在命名和当前更低的生成率 `20.0`，说明教程此处在建立一层数量更少、颜色更暗的顶部碎片，用来避免效果只剩单一的亮色余烬。
这一帧回到关卡 `Stylized_Wisps` 中检查顶部碎片层加入后的整体观感。右侧 `Outliner` 选中对象仍是 `NS_Wisp_Fire`，`Details` 面板可确认：

- `Location = (-195.28, 50.9843, 134.9131)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Niagara System Asset = NS_Wisp_Fire`
- `Niagara Tick Behavior = Use Prereqs`
- `Allow Scalability` 已启用

下方内容浏览器停留在 `VFX_Library/Materials/Instances/Wisps` 文件夹，当前高亮选中的是 `MI_Pieces_Alpha_01`。同一行还能看到：

- `MI_FireRingSoft_Add_01`
- `MI_FireSoft_Add_01`
- `MI_Glow_Red_Add_01`
- `MI_Pieces_Alpha_01`
- `MI_SmokeSoft_Alpha_01`

这说明教程此时在一边看场景中的粒子结果，一边对照用于火环、火点、发光、碎片和烟雾的材质实例，确认碎片层使用的是独立的 Alpha 材质，而不是直接复用前面的光晕或烟雾材质。

场景画面里，火焰本体非常弱，只能在地面中央附近看到少量偏暖的微小粒点，顶部暗色碎片层已经被压到比较克制的程度。结合画面字幕里的 “Scale velocity”，可以把这一帧理解为在检查：当碎片颜色改成更暗版本后，后续还需要靠速度缩放去决定它们是继续上升还是向两侧散开，而不是单靠颜色本身完成层次区分。
这一帧是在关卡里近距离查看 `NS_Wisp_Fire` 的阶段性结果。右侧 `Details` 面板仍显示对象为 `NS_Wisp_Fire (Instance)`，位置与系统资产信息保持不变：

- `Location = (-195.28, 50.9843, 134.9131)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Niagara System Asset = NS_Wisp_Fire`
- `Niagara Tick Behavior = Use Prereqs`
- `Allow Scalability` 已启用

从画面结果可以直接确认当前效果已经形成多层结构：

- 中心是最亮的黄白色火核
- 火核周围存在数团偏橙黄的亮色碎片/余烬斑块
- 外侧保留一圈较大的红橙色软边火环
- 火环内侧还能看到较暗的红褐色体积层，把亮色区域压出深浅变化

与前一帧相比，这一近景更清楚地证明了 `Pieces_Top_Glow` 和 `Pieces_Top_Dark` 两层顶部碎片已经共同参与画面：亮层负责把中心周边点亮，暗层则让内部不至于只有纯亮色贴片，从而把整体观感拉向“燃烧中的火团”而不是单纯的发光球。

对复现而言，这一帧的关键信息不是新的单个数值，而是验收标准：如果亮暗两套顶部碎片层工作正常，最终应该在火核附近同时看到高亮暖色斑块与较暗的红褐色过渡区，并且外圈火环仍然完整可读。

### 01:07:06-01:10:53 火焰

- 本段定位：火焰。
- 知识点：schwier 可以 aj 有hovah 都是在犹豫 所以我还是 加提前加融 看 我们 mel 我们看到 温度,我们 toxins 施 credits 如果上半点。
- 知识点：是温度 的 inform 不 SNE 像上talk 做一下 很快 但在坐下和坐下的设置上 这就是在创建效果的最重要的 例如在这里改变了质感或颜色。
- 知识点：可以做这个中心 这个火焰 可能不会增加15%的重量 不,太多了 可以在这里提升α 從0.1到0.5 来令它更亮 但这太多了 我们看到如果火焰亮了。
- 知识点：它会适当敲中心 让焦點在中心上 就是需要去到0.25 0.2 所以就这樣 因为焦點在这 可能会更少 15% Dvo 这就是 可以試試看 这可以的。
- 知识点：这会更好 可以把 焦點全部都放在一起 让它们都一樣 在这里 我们先把这个留给自己 这里我们看到我们有一个中心 就是我们有一个很神奇的东西。
- 知识点：我们有更多 这里是更清楚的 这里是更多的細節 就这樣 可以多加一点 例如多加一些 更多的焦點 让它更動 也就是 它可以变成一些裝備 可能还有其他东西。
- 知识点：这个 例如 一个磅塊 需要很快地展示给你 在暗暗的暗處上 或是暗光上 只要把焦點調到 焦點每个磅位上 記得是 然后把地點轉掉 现在Tp 当它動。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`、`火焰`。

**关键画面：**

这一帧是在关卡里近距离核对火焰本体层级。右侧 `Details` 面板对象仍为 `NS_Wisp_Fire (Instance)`，可确认：

- `Location = (-195.28, 50.9843, 134.9131)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Niagara System Asset = NS_Wisp_Fire`
- `Niagara Tick Behavior = Use Prereqs`
- `Allow Scalability` 已启用

从当前结果可以直接确认这一段“火焰”调节的目标：

- 中心黄白色火核明显比前一段更集中、更亮
- 火核外侧包着一层偏红橙的模糊过渡区，而不是只有纯黑或纯亮色
- 外圈仍然保留一整圈较大的红橙火环
- 火环内部的暗色层没有把中心完全遮住，中心视觉焦点依然成立

也就是说，本段开始强调“把注意力重新拉回中心火焰”，而不是继续增加外层元素。对复现来说，这一帧的验收标准是：中心高亮区要足够聚焦，内层红色火焰要给到厚度，但不能大到把焦点从中心推散；外环则继续作为边界轮廓存在。
这一帧回到 `NS_Wisp_Fire` 的系统堆栈，教程开始直接调整火焰主环发射器 `FireRing_Main`，而不是继续改碎片或烟雾层。时间轴约为 `5.46s`，左侧预览显示中心亮核、内层红橙火焰和外环同时可见。

画面中央当前可见并参与这一轮火焰塑形的发射器包括：

- `Glow_Center`
- `FireRing_Main`
- `FireRing_Scale`
- `Pieces_Top_Dark`
- `Pieces_Top_Glow`

当前选中的是 `FireRing_Main`，右侧展开 `Spawn Rate`，可确认：

- `SpawnRate = 4.0`
- `Spawn Probability = 1.0`

`FireRing_Main` 的可见模块顺序包括：

- `Emitter State`
- `Spawn Rate`
- `Initialize Particle`
- `Particle State`
- `Sprite Rotation Rate`
- `Scale Sprite Size`
- `Scale Color`
- `Sprite Renderer`

这说明本段“火焰”调节不是通过新增复杂模块完成，而是回到主火环发射器，用已经存在的发射、尺寸和颜色模块重新平衡中心火焰的密度与焦点。当前截图能确认的直接参数只有 `SpawnRate = 4.0`；其他亮度或 Alpha 的细调还没有在本帧展开。
这一帧把相机拉远，用角色模型和场地空间重新核对火焰成品的总体尺度。右侧 `Details` 面板对象仍是 `NS_Wisp_Fire (Instance)`，但当前实例位置已经调整到：

- `Location = (-141.219, 343.544, 190.550)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Niagara System Asset = NS_Wisp_Fire`
- `Niagara Tick Behavior = Use Prereqs`
- `Allow Scalability` 已启用

从远景画面可以确认以下结果：

- 火焰效果相对角色尺寸仍然偏小，属于小型漂浮火团
- 中心亮核在远处依然可读，没有因为外层环形和烟雾而糊成一片
- 外圈红橙火环在远景下仍保有明确轮廓
- 整体没有夸张拖尾或过大的顶部碎片，因此更像环境中的 wisp，而不是爆炸或大型火球

这张图提供的是最终比例与可读性验收标准：如果希望保留当前教程的观感，火焰在远景里应当首先被读成一个小而清晰的发光核心，外圈给出轮廓，其他碎片和烟雾只负责增加细节，而不应该把体量撑大到接近角色本体。

## 补充视觉证据

### S03 00:10:13

这是 `M_UberMaterial` 的材质图局部补充截图，目的在于补证早期主材质里 `T_Main` 贴图、颜色图开关和两路乘法输出之间的关系。由于截图只覆盖了图中央一小段，左右两侧很多节点被裁掉，最终输出口未完整出现，因此只能可靠记录当前可见局部结构。

节点定义集：

- `T_Main`：`Param2D` 纹理参数，预览是一个中心白、边缘黑的圆形贴图。
- 上方一张蓝色圆斑纹理采样节点：节点名未完整显示，标签页可见类似 `VFX_T_ColorMap_Blue_...`，应为颜色图采样，但完整资源名当前帧未确认。
- `Use Colormap?`：参数节点，`Default Value = 0.0`。
- `Lerp(1,)`：线性插值节点，可见 `A = 1.0`，`B` 与 `Alpha` 已接线。
- 两个 `Multiply` 节点：上下各一，右侧继续连向截图外的后续节点。
- 右上还有一个向量/颜色输出节点，仅能看到 `G`、`B`、`A`、`RGBA` 输出端，节点标题被裁掉，当前帧未确认。

连线集：

- `T_Main.R` 向右直接连入下方 `Multiply` 的一个输入。
- `T_Main.R` 同时向上分支，接入上方链路中的后续节点。
- 蓝色颜色图采样节点的输出向下接入 `Lerp(1,)` 的 `B` 或邻近输入区域，精确端口因遮挡当前帧未确认。
- `Use Colormap?` 参数输出接入 `Lerp(1,)` 的 `Alpha`。
- `Lerp(1,)` 输出接入上方 `Multiply` 的一个输入。
- 右上被裁切节点的输出分别接入上下两个 `Multiply`。
- 两个 `Multiply` 的输出继续向右连到截图外的材质后续部分。

设置/参数：

- 左下 `Details` 面板可确认当前材质属性：
  - `Material Domain = Surface`
  - `Blend Mode = Translucent`
  - `Shading Model = Unlit`
  - `Two Sided` 未启用
  - `Use Material Attributes` 未启用
  - `Cast Ray Traced Shadows` 已启用
- 底部 `Platform Stats` 可确认：
  - `Base pass shader without light map: 163 instructions`
  - `Base pass vertex shader: 315 instructions`
  - `Texture samplers: 3/16`
  - `Texture Lookups (Est.): VS(3), PS(2)`
  - `User interpolators: 2/4 Scalars (1/4 Vectors) (TexCoords: 2, Custom: 0)`
  - `Shader Count: 4`
  - `Preshaders: 4 (4 param fetches, 6 ops)`

输出/预览：

- 左侧材质预览窗口当前显示的是一个简单亮面片，不足以反推完整材质效果。
- 结合局部连线可确认：`Use Colormap?` 用来在基础灰度/主贴图路径和颜色图路径之间做切换或混合，再分别送入两路 `Multiply`，但两路最终分别进入 `Base Color`、`Emissive Color`、`Opacity` 还是其他材质输出口，在当前截图中不可见，当前帧未确认完整材质图。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。

