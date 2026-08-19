# 06 Stylized Ice Spikes

# 06 Stylized Ice Spikes

## 关键术语

- `Alpha`、`GPU`、`CPU`、`UV`、`速度`、`透明度`、`Niagara`、`发射器`、`颜色`、`Niagara System`、`Emitter`、`Particle`、`Spawn Rate`、`Spawn`、`Initialize Particle`、`Lifetime`、`Color`、`Opacity`

## 分段知识

### 00:00:05-00:05:00 关键流程 01

- 本段定位：关键流程 01。
- 知识点：歡迎收看,在这段影片中继续,需要为了冰影加上不同的雪花 但首先需要要剪輯这个場景 把點灯關掉,然后再換上另一个 新的 我们把它選起来,就像其他一樣。
- 知识点：我们设置最高的重量,300,我们增加了高度 我们把它设置到最高,溫度是色,我改变了颜色。
- 知识点：或者,越小的價值,越溫暖 或者,越大的價值,越冷 可以把他转换到这个 folder 现在,我们不找他,我们找他 點灯光,他們把灯光關掉。
- 知识点：可以移动和改变颜色 但这點很有趣的是,我们有烟 现在,需要教大家如何把烟關掉 把灯光關掉 这也是很简单的 在某些情况下,如果您在制作现實的效果。
- 知识点：您需要把烟關掉,把陽光關掉 例如,一个人照亮一盞灯光 它会把光线的颜色關掉 我们去到物件 我把它錯誤了 我们把它转换到这个 folder。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

该图是新一页教程开场时的整体效果预览。画面中仍然是蓝白高亮的冰刺主体，周围保留少量烟雾与碎片细节，当前重点不是 Niagara 参数本身，而是先调整场景布光

右侧 Outliner 可见当前场景里包含：

- `PointLight`
- `SkyLight`
- `LS_IceSpikes` 相机与 Niagara 相关对象

字幕明确说明“先编辑场景，移除点光源并用另一个替换它”，因此这张图的作用是交代本段第一步不是继续叠加粒子，而是先处理关卡中的灯光设置，避免当前点光源对冰刺颜色和整体氛围产生不理想影响
该图切换到材质实例 `MI_SmokeFrost_01` 的参数面板，教程在这里直接调整烟雾霜冻材质的渲染模式与贴图参数

可确认的 `Global Scalar Parameter Values` 为：

- `Depth Fade = 200.0`
- `Dissolve Smoothness = 1.0`
- `Mask Exp = 1.0`
- `Smoke Mask Influence = 0.0032`

`Global Texture Parameter Values` 中可确认：

- `T_Dissolve = T_NoiseSoft_01`
- `T_Distortion = T_Noise14`
- `T_Smoke = T_Smoke3`

`Global Vector Parameter Values` 中可见一项：

- `Dissolve(Scale|Scroll)` 已启用，但当前截图未展开具体分量数值

`Material Property Overrides` 中可确认：

- `Opacity Mask Clip Value = 0.3333`
- `Blend Mode = Additive`
- `Shading Model = Unlit`
- `Two Sided` 未启用

父材质显示为：

- `Parent = M_Smoke`

左侧预览球显示为一层大范围、柔和的白色发光烟雾。字幕说明“这里我们可以改成 unlit”，与右侧 `Shading Model = Unlit` 的设置一致，说明本段的关键点是让烟雾材质脱离受光照影响的表面着色方式，转为更稳定的自发光叠加表现
该图打开了一张雪花/颗粒噪声贴图 `T_SpotsNoise_01`，教程在这里查看用于雪点或细碎高亮分布的纹理资源

可确认的贴图内容与属性为：

- 贴图主体是黑底白点的高对比噪声图
- 白点分布稀疏且大小不一，适合用作雪花、霜点或细小高亮颗粒的遮罩来源
- 当前显示分辨率为 `1024 x 1024`

右侧 `Details` 面板中可确认：

- `Imported = 1024x1024`
- `Displayed = 1024x1024`
- `Max In-Game = 1024x1024`
- `Resource Size = 683 KB`
- `Has Alpha Channel = False`
- `Source Alpha Detected = False`
- `Method = Streamed`
- `Format = DXT1`
- `Combined LOD Bias = 0`
- `Number of Mips = 11`
- `Encode Speed = Fast`

常规设置中还能确认：

- `LOD Bias = 0`
- `Texture Group = World`
- `Compression Settings = Default (DXT1/5, BC1/3 on DX11)`
- `sRGB` 已启用
- `X-axis Tiling Method = Wrap`
- `Y-axis Tiling Method = Wrap`

这张图的作用是明确本段将使用一张专门的斑点噪声图来提供雪花/亮点分布，而不是继续沿用烟雾的大面积软边贴图。读者可据此理解后续“不同的雪花”来自新的点状纹理资源

### 00:05:00-00:09:40 Alpha

- 本段定位：Alpha。
- 知识点：我们把它增加到3F3 现在我们看到小點 我提升了它们,现在就看到點像这个 我们需要加多一点溶解 加一点调整 我们把这个位置改变了 我们把它移到旁邊。
- 知识点：有些非常小的调整價值 但需要加動作 我们不需要颜色圖案 我们把它轉掉 可以用溶解的方法 比如說,把溶解減少一点 因为需要覺得它太多了。
- 知识点：需要把其他东西都放在標準上 我们把这个物件删除 然后把它删除,需要有我们的雪花 可以,比如說,把遙控器删除 我認为这里会太多了。
- 知识点：需要把它弄得很大 然后我们把尺寸 大概 这里,我们看看它们是怎樣的 现在它们很難看 因此我们需要改变颜色和alpha。
- 知识点：很小的,因此它们没有显示 需要把一些明亮的东西放在这里 我们把明亮點增加 我们把少一点的溶解減少一点 这里是一樣的选择 我只会把一些东西放在这里。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`颜色`。

**关键画面：**

该图打开雪花材质实例 `MI_Snowflakes_01` 的 `Layer Parameters` 面板，教程在这里开始针对雪花点状材质调整颜色、溶解、扭曲和遮罩参数

`Base Texture` 部分可确认：

- `Colormap = VFX_T_ColorMap_Blue_06`
- `Main (Scale|Scroll)`：`R = 3.0`、`G = 3.0`、`B = 0.0`、`A = 0.0`
- `Premultiply Color? = 1.0`
- `T_Main = T_SpotsNoise_01`
- `Use Colormap = 0.0`

`Dissolve` 部分可确认：

- `T_Dissolve = T_Gradient15`
- `Dissolve (Scale|Scroll)` 已启用，但当前未展开具体分量数值
- `Smoothness = 1.0`

`Distortion` 部分可确认：

- `Distortion (Scale|Scroll)` 已启用
- `Distortion Influence = 0.0`
- `T_Distortion = T_VoronoiSet02`

`Global Scalar Parameter Values` 与 `Mask` 部分可确认：

- `Depth Fade = 100.0`
- `Mask (Scale|Scroll)` 已启用
- `T_Mask = WhiteSquareTexture`

`General` 区域可确认：

- `Parent = M_UberMaterial`

左侧预览中能看到天空和地面前景上散布着细小白点，说明 `T_SpotsNoise_01` 已经作为雪花主分布贴图参与显示。结合本段上下文，这张图的重点是：雪花层将不再使用烟雾那种大块软边纹理，而是基于斑点噪声、渐变溶解和基础遮罩来生成细碎雪点
该图切回 Niagara System `NS_IceSpikes`，当前选中新的雪花发射器 `Snowflakes_Drops`，并打开其 `Particle Spawn -> Initialize Particle` 模块。教程在这里为雪花点设置随机寿命与随机颜色

当前可确认的设置为：

- `Lifetime Mode = Random`
- `Lifetime Min = 5.5`
- `Lifetime Max = 6.25`
- `Color Mode = Random Range`

当前打开的颜色选择器可确认一组颜色值为：

- `R = 2.025`
- `G = 3.413333`
- `B = 5.0`
- `A = 1.0`
- `H = 212.0`
- `S = 0.595`
- `V = 5.0`
- `Hex Linear = FFFFFFFF`
- `Hex sRGB = FFFFFFFF`

右侧当前还可见：

- `Color Channel Mode = Link RGB / Link A`
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 0.0)`
- `Mass Mode = Unset / (Mass of 1)`

画面左侧系统总览能看到这一阶段已经同时存在 `Smoke_Ground`、`Snowflakes_Drops` 等发射器，说明教程正在把雪花层并入已有烟雾结构中。字幕强调“稍微少一点饱和度”，对应这里把雪花颜色维持在偏冷的高亮蓝白色，但避免过度鲜艳
该图切到雪花发射器 `Snowflakes_Drops` 的 `Particle Update -> Drag` 模块，教程在这里通过随机阻力和一条衰减曲线控制雪花速度，让它们不会一直以固定速度飞行

当前可确认的设置为：

- `Drag` 使用 `Multiply Float`
- 输入 `A = Random Range Float`
  - `Minimum = 5.0`
  - `Maximum = 25.0`
  - `Evaluation Type = Spawn Only`
- 输入 `B = Float from Curve`

曲线部分可确认：

- 横轴使用 `Particles.NormalizedAge`
- 起点接近 `0.9`
- 随生命周期持续下降
- 末端接近 `0`
- `Scale Curve = 1.0`

此外还可确认：

- `Rotational Drag = 1.0`

这表示每个雪花粒子会在出生时先随机拿到一组 `5-25` 的阻力基础值，再乘上一条随年龄递减的曲线。这样雪花既有个体差异，又会在生命周期内逐渐减小阻力影响，形成更自然的飘散和减速节奏

### 00:09:40-00:14:16 速度

- 本段定位：速度。
- 知识点：现在需要改变所有东西 在这里可以把一个更大的曲線 让它们快速的下降 我認为我们不需要这樣 它们会飛到旁邊 需要增加它们的速度。
- 知识点：让它们快速地飛上去 再加一个曲線 它们会從一开始开始 需要增加它们的速度 最初它们没有,然后它们飛上去 增加在旁邊 我们来调整它的穩定。
- 知识点：需要选择这个價值 它们会很快地快速地飛上去 我们把穩定值转换成1 像这樣它们会改变 需要选择滅掉和其他模式 需要增加它们的轉折率。
- 知识点：让它们在旁邊 但小價值,这是我们有的雪 现在我们来看看 这个物料 我现在明白問題的問題 我们没有面具,看看問題的問題 可观察到在这里 看起来一切都很好。
- 知识点：但实际上,一切都不太好 因为我没有面具 看起来很长 例如需要把一塊面具 放在一塊 需要加上一些面具 来把它们在邊緣上擦一擦 当它们有很多塊面。
- 核对对象：`速度`。

**关键画面：**

该图是调整布光后的阶段性结果预览。冰刺主体仍然保持高亮蓝白色，但背景和周围空间里已经出现大量细小雪点，说明雪花层已被加入并开始参与整体观感

右侧当前选中的是场景里的 `PointLight`，可确认参数为：

- `Location = (0.0, 0.0, 550.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Intensity = 300.0 cd`
- `Intensity Units = Candelas`
- `Light Color` 为白色
- `Attenuation Radius = 16384.0`
- `Source Radius = 1.0`
- `Soft Source Radius = 1.0`

这张图的重点不在 Niagara 单个模块，而在整体节奏与布光关系：点光源被保留下来并抬高到场景上方后，冰刺边缘仍然明亮，雪点则更容易在深蓝背景里被看见。由此可知本段“速度”并不只是改雪花运动本身，也在配合灯光和场景对比度来检查雪花可见性
该图是雪花层密度测试时的结果预览。当前镜头几乎完全被大量细小亮点覆盖，右半边尤其密集，说明此时雪花粒子的生成量、速度分布或停留时间已经高到接近“雪幕”效果

可直接确认的画面特征有：

- 细小白点数量极多，且集中出现在画面右侧与上半部
- 相比前一张的零星雪点，这里已经从“辅助细节”变成高密度的连续粒子层
- 冰刺主体几乎被移出画面，只保留雪点层的可见性测试环境

字幕提到“例如，我将生成一个粒子”，更像是在讲解生成逻辑或举例说明；但从当前结果图本身可知，教程实际正在观察高密度雪花状态下的可视效果，并据此判断后续需要如何继续调整速度、生成量或分布，让雪点既明显又不至于糊成整片噪声
该图是本段速度调整后的收束结果预览。镜头重新回到完整冰刺主体，雪花不再像前一张那样堆满整个画面，而是退回到环境层和前景点缀层，说明教程已经把过强的雪点覆盖效果压回到更适合作为氛围细节的状态

当前可直接确认的场景信息有：

- 主要视觉主体仍是 `LS_IceSpikes` 冰刺模型，最长的主冰刺位于画面右上方向
- 雪点数量明显少于上一张高密度测试图，只在冰刺周围和背景空间里零散分布
- `Outliner` 中当前仍选中 `PointLight`
- 下方 `Sequencer` 时间线停在约 `2.12`

右侧 `Details` 面板仍能读到当前点光源的关键参数：

- `Location = (0.0, 0.0, 550.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Intensity = 300.0 cd`
- `Intensity Units = Candelas`
- `Attenuation Radius = 16384.0`
- `Source Radius = 1.0`
- `Soft Source Radius = 1.0`

结合前一张高密度测试图，这张图表达的结论是：雪花速度或相关分布参数经过回调后，粒子已经从遮挡主体的“雪幕”状态恢复为服务整体镜头的辅助层，既保留寒冷漂浮感，又不会破坏冰刺主体的轮廓识别

### 00:14:16-00:18:45 UV

- 本段定位：UV。
- 知识点：它会把邊緣擦一擦 改变價值 需要它会飛得更遠 改变價值 我不喜欢它会飛到这里 开始點必须改变 这里太高了 你仍然需要把邊緣擦一擦 这里必须改变。
- 知识点：我改变了前面的邊緣 这里太高了 我改变了它在这里的原價 这里我把邊緣擦一擦 往下降到Z線 我们加了雪 可以改变價值 你喜欢的东西 它已经太多雪了。
- 知识点：但我们会再设计 需要展示它设计 这是一个2x2的圖像 我们隨意选择 一个这四个圖像 用SUB-UV 需要展示可以设计 开始时我们设计一个FOTOSHOP。
- 知识点：是设置 我们按下雪 需要找到很多不同的圖像 例如我选择这个圖像 去FOTOSHOP 设置一个新圖像 需要选择这个圖像 我们需要设置圖像 然后我选择颜色的圖像。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

该图展示的是 Niagara 系统 `NS_IceSpikes` 中发射器 `Snowflakes_Drops` 的 `System Location` 模块设置，教程在这里不是继续改颜色，而是开始用位置偏移曲线重新约束雪花生成区域，让粒子不要长时间漂到不合适的高度或距离

可确认的堆栈位置为：

- `Snowflakes_Drops -> Particle Spawn -> System Location`
- `Offset` 使用 `Make Vector`
- 当前画面主要展开并编辑的是 `X` 与 `Z` 两个分量，二者都来自 `Float from Curve`

当前可读到的 `X` 轴偏移设置为：

- `X -> FloatCurve = Curve for Floats`
- 曲线索引使用 `EMITTER.NormalizedLoopAge`
- `Scale Curve = 1.0`
- 曲线整体为随时间逐步上升的斜线，起点接近 `0`，到右端接近 `1000`

当前可读到的 `Z` 轴偏移设置为：

- `Z -> FloatCurve = Curve for Floats`
- 曲线索引使用 `EMITTER.NormalizedLoopAge`
- `Scale Curve = 700.0`
- `Offset Coordinate Space = Local`
- 曲线在前段接近低位，约在 `Key Data = 0.9`、`Value = 0.35` 处有一个关键点，随后继续抬升，并在末段明显上扬到更高位置

结合左侧预览窗可知，这一步是在保持冰刺主体可见的同时，利用发射器循环归一化时间去驱动雪花偏移范围，使雪粒的出生区域和漂移轨迹随发射过程发生变化，而不是始终固定在单一盒体位置
该图是调整 `System Location` 之后的结果侧视检查图，用来判断从当前视角看雪花覆盖量是否已经过多

从画面可直接确认的信息有：

- 镜头仍对准整组 `LS_IceSpikes` 冰刺主体
- 冰刺周围和右上区域漂浮着明显增多的雪点与雾状颗粒
- 右侧 `Outliner` 中当前仍选中 `PointLight`
- `Sequencer` 时间线停在约 `1.57`

字幕直接说明“这会变成太多雪，但如果你喜欢的话也可以，我们从这一侧看看”，因此这张图的作用不是给出新的参数值，而是建立一个可视判断标准：当侧视角里雪点已经明显抢占主体周围空间、开始削弱冰刺轮廓时，当前生成区域或偏移范围就已经偏大，需要继续回调

这也说明上一张图里的位置曲线调整会直接影响镜头中的雪花堆积区域，教程正在通过切换观察角度来确认雪花是否只是增加氛围，还是已经开始把主体包住
该图切到 Photoshop，展示为雪花粒子准备 2D 贴图形状的过程。当前画布中央是一张白底黑色雪花图案，教程正在通过颜色范围选择把需要的黑色图形从背景中提取出来

可直接确认的画面信息有：

- 文档标签显示当前编辑对象为 `Layer 1, RGB/16`
- 画布分辨率栏可见宽高约为 `1024 px x 1024 px`
- 图像主体是一枚居中的六向雪花图形，黑色图案位于白色方形底板上，四周外围为黑色背景
- 右侧 `Layers` 面板中当前选中的是 `Layer 1`
- 顶部打开的是 Photoshop `Filter` 菜单

字幕明确说明“先高亮选中我们的图层，然后选择颜色范围”，因此这一步的实际操作目的可以整理为：

1. 选中包含雪花图案的目标图层 `Layer 1`
2. 使用 `Color Range` 按颜色选择图像中的目标区域
3. 以颜色选区的方式把雪花形状与背景分离，供后续清理、反选、擦除或导出成粒子贴图使用

这张图对应的是雪花纹理来源制作流程，而不是 Niagara 模块参数本身。它说明教程接下来会通过手工处理 2D 形状，生成更适合 `SubUV` 或雪花 sprite 使用的源贴图

### 00:18:45-00:23:43 关键流程 05

- 本段定位：关键流程 05。
- 知识点：我选择黑色圖像 然后控制这个圖像 可以用刷子 畫出这个圖像 这应该在新圖像里完成 我可以把它關掉 这时候我畫出我需要的圖像 按Ctrl-D再按D去刷。
- 知识点：这就是我正在刷的 一條雪是準備的 我们需要设置好圖像 雖然我们不会这樣 我们按下Ctrl-D 然后按OK 这樣可以设置好圖像 我们按下增加圖像。
- 知识点：在中间设置好圖像 我们正在找下一个圖像 可以选择这个圖像 但如果我开始选择圖像 就更好再选择其他圖像 这樣圖像都会一樣 我们找个很像的圖像。
- 知识点：我们还在搜尋圖像 可能是这个圖像 这里有一个圖像 很難分辨 所以我们正在找到 不像这个圖像的圖像 我们正在找到更合適的圖像 比如說需要要这个圖像。
- 知识点：需要再按下Ctrl-D去刷 需要选择这个圖像 需要刷掉其他圖像 如果不需要的話 Ctrl-X 按下Ctrl-D 就像我们之前一樣 按下高光圖像。

**关键画面：**

该图是 Photoshop 中执行 `Color Range` 之后的选区结果。当前雪花图案和白色底板都已被纳入活动选区，说明教程已经把需要处理的图像区域整体框出来，准备继续反选、删除或清理不需要的部分

可直接确认的信息有：

- 当前文档标签为 `Untitled-1 @ 180% (Layer 1, RGB/16)`
- 右侧 `Layers` 面板中选中的是 `Layer 1`
- `Layer 1` 的尺寸为 `1024 px x 1024 px`
- 画布中央仍是黑色雪花图案叠在白色方形底板上
- 选区虚线不仅包围雪花轮廓，也沿白色方形外边缘形成完整矩形，说明当前被选中的不是单独雪花形状，而是颜色范围筛出的整块目标区域

这一步的意义是先把需要参与后续编辑的亮色区域统一选出来。由于雪花图案位于白色底板中央，教程接下来可以基于这个选区继续做反选、擦除边缘、复制到新图层或删除背景，逐步把粒子贴图整理成更干净的雪花 alpha 图形
该图切到浏览器搜索页，说明教程在继续寻找可用于雪花粒子贴图的替代参考图案，而不是只使用当前那一枚雪花形状

可直接确认的信息有：

- 浏览器打开的是 Google 图片搜索，关键词为 `snowflake`
- 搜索结果页顶部带有 `Png`、`Transparent background`、`Vector`、`Shape`、`Snow flakes` 等筛选标签
- 右侧预览区当前选中的是一张包含多枚黑白雪花图标的素材图
- 预览标题可见为 `Snowflakes Svg Bundle...`

结合本段上下文，这一步的意图是继续搜集更多雪花轮廓来源，让后续 `SubUV` 或 sprite 贴图不只包含单一雪花，而是拥有多种不同外形可供轮播或随机使用。教程此时正在比较候选图案，挑选更适合做黑白遮罩和粒子贴图的雪花形状
该图回到 Photoshop，展示将多枚雪花图案整理成 2x2 排列贴图的步骤。这正对应后面要做 `SubUV` 的准备工作：先把不同雪花轮廓放进同一张贴图的不同分块里

可直接确认的画面信息有：

- 画布仍为 `1024 x 1024`
- 当前画布被参考线均分成四个方格
- 四个格子里各放置一枚白色雪花图案，背景为黑色
- 左侧两枚属于较圆润、分枝更复杂的雪花形状
- 右侧两枚属于六角结构更规整的雪花形状
- 右侧 `Layers` 面板中存在多层白色图层，右键菜单已展开，并高亮在 `Merge Layers`

这一步可以按结果理解为：

1. 把不同雪花轮廓分别摆进 2x2 网格的四个象限
2. 保持统一黑底白形状，便于后续作为透明度或遮罩贴图使用
3. 在排列确认后执行 `Merge Layers`，把当前多图层素材合并成一张统一的雪花序列表

这张图给出的核心结论是：教程正在把单张雪花图扩展为多帧雪花表，为后续 Niagara 中使用 `SubUV` 随机切换不同雪花外形做准备

### 00:23:43-00:28:34 UV

- 本段定位：UV。
- 知识点：把它们拆除 然后可以需要把它们变成8bit 这就只能是为了 让你能够儲存和儲存自己的圖像 我们再回到原位 我们有了这个圖像 可以把圖像调整到这个位置。
- 知识点：我们不需要再调整了 需要选择另一个圖像 像这樣 可以选择 可以选择一张圖像 我们需要加上 sub uv 我们需要加上 sub uv 这樣我们就能有更多的圖像。
- 知识点：需要选择2x2 需要先让它们再加一些圖像 需要加一个圖像 需要让颜色不太亮 需要改变生命的时间 它们不会太大 我们需要減少它的大小。
- 知识点：它们会有很多的,但它们会很小 可以改变它的圖像位置 这樣它们会变得更高 需要回到0 需要把它们留在这里 它们会飛起来 但可以減少它的大小。
- 知识点：它们还会轉動 一方向 这里没有問題 需要这樣做 我们来看看結果 我们来看看雪花 你还需要改变生命的时间。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

该图展示的是在 Photoshop 中为 2x2 雪花序列表添加发光效果的步骤。当前四枚白色雪花已经排在黑底网格内，教程正在给选中的雪花图层应用 `Outer Glow`，让贴图在作为粒子 sprite 时自带更柔和的亮边

可直接确认的画面信息有：

- 画布仍是 2x2 分格布局，四个象限中各放置一枚白色雪花
- 当前选中图层为 `Layer 8`
- 右侧 `Layers` 面板显示该图层已带有 `Effects -> Outer Glow`
- 屏幕中央打开的是 `Layer Style` 对话框，并选中 `Outer Glow`

可读到的 `Outer Glow` 关键设置为：

- `Blend Mode = Screen`
- `Opacity = 100%`
- 发光颜色为白色
- `Noise = 0%`
- `Technique = Softer`
- `Spread = 0%`
- `Size = 43 px`
- `Range = 100%`
- `Jitter = 0%`
- 轮廓使用默认的平滑曲线，`Anti-aliased` 已开启

这一步的作用是把原本纯白硬边的雪花图案扩展成带柔光边缘的粒子贴图。这样导入 Niagara 后，即使雪花尺寸较小，也能更容易在深色背景中显现出来，并减少纯硬边 sprite 的生硬感
该图展示在 Niagara 系统 `NS_IceSpikes` 中单独调节发射器 `Snowflakes` 的生成速率，让雪花先生成得更多。画面中的 `Snowflakes_Drops` 和 `Snowflakes` 两个发射器并列显示，当前选中并展开的是后者的 `Spawn Rate`

可直接确认的堆栈位置为：

- `Snowflakes -> Emitter Update -> Spawn Rate`
- `SpawnRate` 输入使用 `Float from Curve`
- 曲线资源类型显示为 `Curve for Floats`

当前可读到的曲线信息有：

- 曲线索引区域处于标准浮点曲线编辑器
- 红色曲线整体从左向右缓慢上升，而不是恒定值
- 选中的关键点当前数值栏显示约 `0.675`
- 右键菜单已展开，并高亮 `Straighten`，说明教程正在整理该关键点切线或曲线平滑方式

同一张图里还能确认发射器结构已经加入了与雪花序列表对应的模块：

- `Snowflakes -> Particle Update` 中可见 `Sub UV Animation`
- 该模块当前显示模式为 `Random`
- `Render` 仍使用 `Sprite Renderer`

结合字幕“先让它们生成更多”，这一步的实质是先把 `Snowflakes` 发射器的出生频率拉高，再配合后面的 `SubUV`、尺寸、生命周期等设置，形成数量更多但单体更小的雪花层
该图是 `Snowflakes` 发射器 `Spawn Rate` 曲线调整后的更清晰状态。教程已经把雪花发射率设置成随发射器循环时间逐步增加，而不是固定不变，从而让后段雪花数量高于前段

可直接确认的堆栈位置与参数为：

- `Snowflakes -> Emitter Update -> Spawn Rate`
- `SpawnRate = Float from Curve`
- `FloatCurve = Curve for Floats`
- `CurveIndex = EMITTER.NormalizedLoopAge`
- `Scale Curve = 100.0`
- `Spawn Probability = 1.0`

当前曲线的可见形态为：

- 左侧起点位于约 `0.65` 附近
- 中段缓慢爬升
- 末端接近 `1.0`
- 整体是一条持续上扬的生成率曲线，而不是突变式台阶

同图还能确认当前发射器结构中已存在：

- `Particle Spawn -> Initialize Particle`
- `Particle Spawn -> System Location`
- `Particle Spawn -> Shape Location (Box / Plane)`
- `Particle Spawn -> Add Velocity (Linear)`
- `Particle Update -> Sub UV Animation (Random)`
- `Render -> Sprite Renderer`

这一步表达的结果是：雪花发射数量已经与 `NormalizedLoopAge` 挂钩，随着发射器推进，后续时段会生成更多雪花，为下一段继续调粒子初始化、生命周期和尺寸提供基础

### 00:28:34-00:33:25 发射器生成与粒子初始化

- 本段定位：发射器生成与粒子初始化。
- 知识点：需要它们飛得更遠 需要把終點移动 可以把它移动到- 它们太低了,需要改变 我们改变了它的圖像 我喜欢它更多 我们再把它升高一点 可以減少它的亮度。
- 知识点：或者減少它的明顯 我们再增加它的数字 可以把終點移动到 它们这樣飛起来 看起来很棒 可能更高一点 需要它们仍然会從一邊移动 它们现在只是在下降。
- 知识点：需要增加它的力量 我们看到它们现在 從一邊移动到另一邊 它们现在只是在下降 它们现在仍然從一邊移动到另一邊 需要要更多雪花 它们会發光 我们来创建一种材料。
- 知识点：我们来创建这个 我们来用其他光感 像是这个转换的前提 我们把所有东西都放在这里 我们来创建这个发射器。
- 知识点：我们不需要用減速電池 我们把它拿走,我们把材料转换 需要有很高的損害 需要有很多損害 我们把電池的生命值 都放在这里 它们会很快 一顆是这个颜色 它们会很小。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`粒子`、`发射器`、`颜色`。

**关键画面：**

该图是雪花发射器调整后的阶段性结果预览。相比前面的细小雪点层，这里已经能明显看到较大的雪花 sprite 从画面右侧向左前方穿过镜头，说明教程正在把雪花从单纯下落改成带横向漂移、带亮边的更显眼粒子

当前可直接确认的画面信息有：

- 冰刺主体 `LS_IceSpikes` 仍占据镜头中央与右侧区域
- 画面右半部出现多枚尺寸较大的亮蓝白色雪花片，形状已不再只是点状，而更接近拉长的 sprite
- 背景上方仍保留一层更细密的小雪点，用来补充远景氛围
- `Outliner` 中当前选中的是 `PointLight`
- 下方 `Sequencer` 时间线停在约 `1.30`

右侧 `Details` 面板仍能读到当前点光源参数：

- `Location = (0.0, 0.0, 550.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Intensity = 300.0 cd`
- `Intensity Units = Candelas`
- `Attenuation Radius = 16384.0`
- `Source Radius = 1.0`
- `Soft Source Radius = 1.0`

这张图表达的重点是视觉结果：雪花已经不再只是垂直落下，而是在镜头前形成从一侧掠过的运动感；同时由于贴图本身带有发光边缘，近景雪花的存在感比之前更强
该图是同一段发射器调整过程中的另一帧结果预览。与上一张相比，近景大雪花数量略少，更多雪花被压回到主体周围和背景空间里，说明教程正在继续平衡“可见的大雪花”和“不会抢主体”的关系

当前可直接确认的画面信息有：

- 冰刺主体仍完整位于画面中央偏右，轮廓比上一张更清晰
- 背景和冰刺上方仍存在大量细小雪点，形成持续的远景雪雾层
- 近景较大的雪花 sprite 仍然可见，但数量少于上一张，主要分布在右上和主体右侧
- `Outliner` 中当前仍选中 `PointLight`
- 下方 `Sequencer` 时间线停在约 `1.23`

右侧 `Details` 面板可确认点光源仍保持：

- `Location = (0.0, 0.0, 550.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Intensity = 300.0 cd`
- `Intensity Units = Candelas`

这张图对应的结论是：雪花系统已经同时包含两层表现，一层是背景中的细小雪点，另一层是镜头前更亮、更大的雪花片；教程此时正在把近景大雪花控制在“有动势但不过量”的范围内
该图展示教程新增并编辑发射器 `Snowflakes_GlowSparks` 的 `Initialize Particle` 设置，用来做更亮、更短命、更小颗粒的发光雪花火花层

可直接确认的堆栈位置为：

- 发射器名称：`Snowflakes_GlowSparks`
- 模块位置：`Snowflakes_GlowSparks -> Particle Spawn -> Initialize Particle`

当前 `Initialize Particle` 中可读到的参数为：

- `Lifetime Mode = Random`
- `Lifetime Min = 1.5`
- `Lifetime Max = 3.0`
- `Color Mode = Direct Set`
- `Position Mode = Simulation Position`
- `Position Offset = (0.0, 0.0, 0.0)`
- `Mass Mode = Unset / Mass`

颜色选择器当前显示值为：

- `R = 0.137`
- `G = 0.4696`
- `B = 1.0`
- `A = 1.0`
- `H = 228.0`
- `S = 0.663`
- `V = 1.0`
- `Hex Linear = 5678FFFF`
- `Hex sRGB = 9DB6FFFF`

同模块里还能确认的粒子尺寸参数有：

- `Sprite Size Mode = Random Uniform`
- `Uniform Sprite Size Min = 15.0`
- `Uniform Sprite Size Max = 25.0`
- `Sprite Rotation Mode = Unset`

这一步的含义是：在原有 `Snowflakes` 发射器之外，再单独建立一层偏蓝白色、寿命较短、尺寸较小的 `GlowSparks` 粒子，用来补充冰刺周围更亮的闪烁雪花或碎光效果

### 00:33:25-00:36:18 Alpha、GPU、CPU

- 本段定位：Alpha、GPU、CPU。
- 知识点：我们来看看它们现在是怎樣 它们还没亮 我用了一顆A,我把最初的減速掉了 现在我们要把它们的光亮增加 现在我们要把它们的光亮增加 需要把鏡頭的開關掉。
- 知识点：需要它们在中间 我们需要設置一个重要的东西 我们要把它们的光亮增加 需要先控制光亮 这里是光亮增加的量 它们会增加,并会慢慢地增加。
- 知识点：在某一段时间內 它们会增加 同樣的情况是透明度 從0.5到这里我们把所有东西都删除 它们会慢慢地增加 我们不需要转换的量 它的质量是圆的。
- 知识点：但我们把它们獨自放下 我们需要它们很快地從旁邊移动 像这个 非常好,它们可能不太顯眼 我现在把光亮增加到25 因为它们有很多的光亮 我们来看看它的表现。
- 知识点：现在这里你看到一点 在光亮的量度上 我设置了一个大量 它有一个很大的效果 我们把CPU和GPU都換掉 我们把Fixed设置在这里 然后我们把1000增加到所有的位置。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Alpha`、`GPU`、`CPU`、`颜色`、`透明度`。

**关键画面：**

该图是调整 `Alpha / GPU / CPU` 相关效果前后的低亮度结果检查图。当前画面几乎只剩深蓝背景，原本冰刺主体和雪花层都非常不明显，说明教程此时正在排查发光、透明度或模拟方式导致的可见性过低问题

当前可直接确认的画面信息有：

- 视口中几乎看不到冰刺主体，只能看到一层非常弱的深蓝背景渐变
- `Outliner` 中当前仍选中 `PointLight`
- 下方 `Sequencer` 时间线停在约 `1.90`

右侧 `Details` 面板仍能确认点光源保持：

- `Location = (0.0, 0.0, 550.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Intensity = 300.0 cd`
- `Intensity Units = Candelas`
- `Attenuation Radius = 16384.0`

字幕提到“我已经减少了最初的那个”，结合本段标题可知，这一帧的作用是观察在降低初始亮度或初始值之后，粒子系统是否变得过暗。当前结果说明可见性已经被压得太低，后续需要继续把发光或透明度强度拉回来
该图展示发射器 `Snowflakes_GlowSparks` 的 `Scale Color` 设置。教程在这里不是改 RGB 颜色本身，而是在用 Alpha 曲线控制粒子随生命周期逐步减弱，从而避免发光雪花一直保持同样亮度

可直接确认的堆栈位置为：

- `Snowflakes_GlowSparks -> Particle Update -> Scale Color`

当前模块中可读到的设置为：

- `Scale Mode = RGB and Alpha Separately`
- `Scale RGB = (1.0, 1.0, 1.0)`
- `Scale Alpha` 已启用 `Float from Curve`
- `FloatCurve = Curve for Floats`
- `CurveIndex = PARTICLES.NormalizedAge`
- `Scale Curve = 1.0`

当前可见的 Alpha 曲线特征为：

- 曲线以 `Particles.NormalizedAge` 为横轴
- 前半段在约 `0.5` 附近保持较高值
- 后半段持续下降
- 末端降到较低值而不是抬高

这表示粒子在生命前段保持较明显的可见度，随后逐渐淡出。这样做可以让发光雪花先被看到，再自然消失，避免所有粒子都以固定强度悬在画面里
该图继续停留在发射器 `Snowflakes_GlowSparks` 的颜色缩放调节阶段，但已经切到 Niagara 的 `Performance` 视图，用来同时观察模块结构和各模块的开销占比

当前可直接确认的信息有：

- 顶部已切到 `Performance` 模式
- 视图中并排显示两个发射器的模块耗时/占比条
- 当前选中的是 `Snowflakes_GlowSparks -> Particle Update -> Scale Color 001`

右侧 `Details` 面板中 `Scale Color 001` 的设置可直接读到：

- `Scale Mode = RGB and Alpha Separately`
- `Scale RGB = (1.0, 1.0, 1.0)`
- `Scale Alpha = 1.0`

这说明与上一张使用 `Float from Curve` 的淡出方案相比，教程这里又检查了一次更直接的常量透明度写法，把 Alpha 固定为 `1.0`，以便观察亮度变化是否来自曲线衰减，还是来自其他材质、模拟或发光参数

左侧性能条还能看出当前发射器在 `Particle Update` 阶段包含：

- `Drag`
- `Gravity Force`
- `Particle State`
- `Scale Sprite Size`
- `Scale Color`
- `Sprite Rotation Rate`
- `Curl Noise Force`
- `Solve Forces and Velocity`

这张图的核心作用是把可见性调整和性能观察放在一起检查：先确认 `Scale Color` 是否把粒子压暗，再结合性能视图查看当前发射器更新链条中哪些模块正在参与计算

### 00:36:26-00:41:07 速度

- 本段定位：速度。
- 知识点：在数字上需要做Sine 需要一直重複 用生命的幫助 不只是发射器 而是氣体 例如,一顆先发射 第二顆後发射 每顆都会有自己的生命 需要加一个小的调整。
- 知识点：需要加一个小的调整 需要加一个小的调整 然后Sine 需要隨意设置数字 從0到1来选择 需要隨意设置数字 需要隨意设置数字 一些傳送的氣体。
- 知识点：它馬上会开始在这里 因为它们的價值是從0到1来的 例如,一顆傳送开始生命 而它们会從0到1来的 例如,它们馬上会开始在这里 一顆开始在这里,另一顆在这里。
- 知识点：每顆都会开始在这个随机设置中 每顆都会开始在这个随机设置中 然后需要加一个小的调整 这是它们的色彩的控制 需要從0到10来选择 然后需要從0到10来选择。
- 知识点：因为我们的Sine是重複的 因为我们的Sine是重複的 我们来看看結果 我们看到它们发射 因为我们有重複的色彩 我们来看看結果 需要把控制關掉。
- 知识点：我可观察到更好 它们会因为重量而下降 需要把重量關掉 然后把速度關掉 它们会站立,它们会慢慢地发射 越短时间越快 它们就会发射 我们把它放在標準位置。
- 知识点：可以把这个写上 可以把这个写上 但这里它们不是從0来的 因为它们会消失 这会很糟糕 我们需要從0.5来的 我们来看看2 这是我们的角度。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`发射器`、`速度`、`颜色`。

**关键画面：**

该图展示发射器 `Snowflakes_GlowSparks` 的 `Scale Color 001` 模块被进一步改造成随生命周期起伏的亮度曲线。教程这里不是调 Alpha 淡出，而是在 `Scale RGB` 上挂一条先升后降的曲线，让粒子在生命中段最亮，形成脉冲式发光效果

可直接确认的堆栈位置为：

- `Snowflakes_GlowSparks -> Particle Update -> Scale Color 001`

当前模块中的可读设置为：

- `Scale Mode = RGB and Alpha Separately`
- `Scale RGB` 使用 `Vector from Float`
- `Value` 输入来自 `Float from Curve`
- `FloatCurve = Curve for Floats`
- `CurveIndex = PARTICLES.NormalizedAge`
- `Scale Curve = 1.0`
- `Scale Alpha = 1.0`

当前可见的亮度曲线特征为：

- 起点接近 `0`
- 中段上升到接近 `1`
- 末端再次下降到接近 `0`
- 曲线整体呈单峰脉冲形，而不是持续上升或持续下降

这表示每个粒子会在出生后逐渐变亮，到生命中段达到最强，再在结束前衰减。这样即使不同粒子错开发射，也能形成交替闪烁的发光雪花层，而不是整层一起恒定发亮
该图展示发射器 `Snowflakes_GlowSparks` 的 `Scale Sprite Size 001` 模块。教程在这里通过粒子生命周期曲线，让同一颗粒子在生命过程中逐渐变大，而不是从出生到消失都维持固定尺寸

可直接确认的堆栈位置为：

- `Snowflakes_GlowSparks -> Particle Update -> Scale Sprite Size 001`

当前模块中可读到的设置为：

- `Scale Sprite Size Mode = Uniform Curve`
- `Uniform Curve Sprite Scale = Curve for Floats`
- `Uniform Curve Index = PARTICLES.NormalizedAge`
- `Uniform Curve Scale = 1.0`

当前尺寸曲线的可见特征为：

- 起点接近 `0`
- 曲线从左到右持续上升
- 末端接近 `1`
- 整体是一条近似线性增大的曲线

这表示每个发光雪花粒子在刚生成时更小，随后随着生命周期推进逐步变大。配合上一张的亮度脉冲曲线，这种“先亮起来、同时慢慢放大”的变化可以让粒子看起来更有能量感，而不是静态的小点
该图切到发射器 `Spikes_Sparks` 的 `Sprite Renderer` 设置，并同时在左侧预览中观察冰刺周围的雪花/亮点效果。教程这里在检查一类“生成初期出现、随后很快消失”的粒子层是否已经符合预期

可直接确认的堆栈位置为：

- 发射器名称：`Spikes_Sparks`
- 模块位置：`Spikes_Sparks -> Render -> Sprite Renderer`

右侧 `Sprite Renderer` 中可读到的设置为：

- `Material = MI_GlowAdd_01`
- `Source Mode = Particles`
- `Alignment = Automatic`
- `Facing Mode = Automatic`
- `Macro UVRadius = 0.0`
- `Default Pivot in UV Space = 0.5`
- `Pixel Coverage Mode = Automatic`
- `Pixel Coverage Blend = 1.0`
- `Min Facing Camera Blend Distance = 0.0`
- `Max Facing Camera Blend Distance = 0.0`
- `Sort Mode = None`
- `Enable Camera Distance Culling` 未开启
- `Renderer Visibility = 0`

左侧预览画面中可直接确认：

- 冰刺主体被拉近到近景
- 画面周围存在大量小雪点和少量较亮粒子
- 冰刺表面与边缘附近能看到零散的亮斑/雪花片，说明渲染器已经在输出这一层短寿命粒子

字幕明确说明“它们在生成开始时出现，然后很快就消失”。结合当前渲染器和近景结果可知，这一层粒子不是持续背景雪，而是依附在冰刺或其周围短暂闪现的火花/雪片，用来增强瞬时能量感

### 00:41:07-00:45:58 关键流程 10

- 本段定位：关键流程 10。
- 知识点：它们应该会在3D的物品後面 所以我们放一个 这也是很重要的物品 在最初 需要有少許烟 需要有少許烟 所有的氣球 所有的烟会有100 这烟在地上会有低限。
- 知识点：需要设置小的数字 这里会变大 它们会比这个大 它们会在雪花上 我们放一点201 它们可以增加一个價值 主要是数字变大 在雪花上 我们也会 我忘了。
- 知识点：我们来看看 现在可能会有點難看 可以增加最初的数字 太多了 如果我们加攝影 它们会在前方显示 如果你喜欢它 可以放下它们 跟着鏡頭可观察到它们。
- 知识点：但需要放它们 在中间 我已经喜欢了 这里有很多雪花 它们飛得太高 我们来編輯位置 我们減少它们 需要它们会更快 更小的價值。

**关键画面：**

该图展示发射器 `Spikes_Pieces` 的 `Mesh Renderer` 设置。教程在这里不是继续调雪花，而是把冰刺碎片作为网格粒子渲染出来，用来补充靠近主体的碎块飞散层

可直接确认的堆栈位置为：

- 发射器名称：`Spikes_Pieces`
- 模块位置：`Spikes_Pieces -> Render -> Mesh Renderer`

右侧 `Mesh Renderer` 中可读到的设置为：

- `Meshes` 数组包含 2 个元素
- `Index [0] = SM_IcePiece_01`
- `Index [1] = SM_IcePiece_02`
- `Enable Material Overrides` 已开启
- `Override Materials -> Explicit Mat = MI_IceSpikes_02`
- `User Param Binding = None`
- `Source Mode = Particles`
- `Facing Mode = Default`
- `Sort Mode = None`
- `Enable Frustum Culling` 未开启
- `Enable Camera Distance Culling` 未开启
- `Renderer Visibility = 0`
- `Cast Shadows` 已开启
- `Motion Vector Setting = Auto Detect`
- `Sub UV Blending Enabled` 已开启
- `Sub Image Size = (1.0, 1.0)`

左侧预览窗可以直接看到：

- 冰刺主体被近距离观察
- 周围除了雪点外，还混入更大、更厚的白蓝色碎片颗粒
- 这些碎片比普通雪花更接近固体块状外观，说明该层确实是冰刺碎块而不是 sprite 雪片

这一步的作用是让 `Spikes_Pieces` 使用真实网格碎片和冰刺材质参与粒子效果，从而在雪花之外增加更重、更立体的近景碎块层
该图展示发射器 `Snowflakes_GlowSparks` 的 `Camera Offset` 设置。教程在这里通过相机偏移把这一层发光雪花向镜头前方推送，使其更容易显示在主体前面，而不是被 3D 物体遮住

可直接确认的堆栈位置为：

- `Snowflakes_GlowSparks -> Particle Spawn -> Camera Offset`

当前模块中的可读设置为：

- `Camera Offset Amount = Float from Curve`
- `FloatCurve = Curve for Floats`
- `CurveIndex = EMITTER.NormalizedLoopAge`
- `Scale Curve = 300.0`

当前曲线的可见特征为：

- 起点接近 `0`
- 随着发射器归一化循环时间持续上升
- 末端接近 `1`
- 整体是平滑上升曲线

字幕直接说明“如果加上摄像机偏移，它会显示在前面”，因此这一步的作用可以明确整理为：

1. 使用 `Camera Offset` 改变粒子相对相机的前后层次
2. 让 `Snowflakes_GlowSparks` 更容易落在主体前景，而不是埋进冰刺模型后方
3. 通过 `EMITTER.NormalizedLoopAge` 逐步增强这种前移效果，而不是一开始就给固定偏移

左侧预览中也能看到近景雪花和发光点层已经明显覆盖到冰刺前方区域，说明这类前景粒子确实被推到了更靠近镜头的位置
该图是关键流程 10 调整后的结果预览。前景雪花、发光点和主体后方的细小雪雾已经被整合到同一镜头中，整体效果比前面几张更稳定，既有前后层次，又没有把主体完全遮住

当前可直接确认的画面信息有：

- 冰刺主体 `LS_IceSpikes` 仍完整占据画面中央偏右区域
- 前景中可见多枚较大的亮蓝白色雪花/碎片，从画面底部和右侧掠过镜头
- 主体周围与后方存在一层更细密的小雪点和亮点，形成中远景漂浮层
- `Outliner` 中当前仍选中 `PointLight`
- 下方 `Sequencer` 时间线停在约 `1.37`

右侧 `Details` 面板仍能确认点光源保持：

- `Location = (0.0, 0.0, 550.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Intensity = 300.0 cd`
- `Intensity Units = Candelas`
- `Attenuation Radius = 16384.0`

结合前两张图里对 `Mesh Renderer` 和 `Camera Offset` 的调整，这张结果图表达的结论是：

1. 网格碎片层已经能在主体附近补充更厚重的近景细节
2. 发光雪花层已经被推到更靠近镜头的位置
3. 主体、前景粒子和背景雪雾之间形成了更清晰的空间层次

这使整组冰刺特效同时具备近景掠过感、主体边缘闪烁感和远景寒冷氛围，而不会只剩单一的平面雪花层

### 00:45:58-00:49:07 关键流程 11

- 本段定位：关键流程 11。
- 知识点：已经看起来不錯了 可以編輯一点 这里的数字变大了 这个價值设置 如果我把鏡頭的关闭设置 鏡頭不设置会更好 看起来很好 需要把最初的数字 放到旁邊。
- 知识点：或是变小 还有什么可以做 例如增加光亮 变大約25 或是15 再增加損傷 你喜欢的 可以改变 5000是可能的 或是3000 需要把它放在这里 这就是我现在的計畫。
- 知识点：接下来需要把各种細節 放在地上 需要把石頭放在地上 我们来處理一些 有趣的新技巧 謝謝你觀看 我们下次見。

**关键画面：**

该图展示发射器 `Snowflakes_Drops` 的 `Emitter State` 设置。教程在收尾阶段重新检查发射器生命周期，让雪花层按固定节奏循环，而不是无节制地持续堆积

可直接确认的堆栈位置为：

- `Snowflakes_Drops -> Emitter Update -> Emitter State`

右侧 `Emitter State` 中可读到的设置为：

- `Life Cycle Mode = Self`
- `Inactive Response = Complete (Let Particles Finish then Kill Emitter)`
- `Loop Behaviour = Multiple`
- `Loop Duration Mode = Fixed`
- `Loop Duration = 0.45`
- `Loop Delay` 已启用但当前值未清晰显示

从同一画面还能确认：

- 左侧预览中冰刺主体周围仍有大量前景雪花、亮点和少量碎片粒子
- 画面中央并排可见 `Smoke_Ground`、`Snowflakes_Drops`、`Snowflakes` 三个发射器

这一步的作用是把 `Snowflakes_Drops` 控制在一个较短的重复周期内，使这层雪花能够频繁刷新、保持节奏感，同时利用 `Inactive Response` 让已生成的粒子自然走完生命周期再结束，避免切断时出现生硬消失
该图是关键流程 11 后段的结果预览。此时画面已经不再强调大量前景雪花，而是回到更均衡的整体镜头：主体轮廓清楚，前景亮点仍在，但数量被控制在不会抢走主视觉的位置

当前可直接确认的画面信息有：

- 冰刺主体 `LS_IceSpikes` 完整占据画面中央偏右区域
- 主体右侧和前景底部仍有少量蓝白色亮点与粒子，但密度明显低于前面几个强化前景的镜头
- 主体后上方保留一层稀疏的小雪点，用来维持寒冷氛围
- `Outliner` 中当前仍选中 `PointLight`
- 下方 `Sequencer` 时间线停在约 `2.90`

右侧 `Details` 面板仍能确认点光源保持：

- `Location = (0.0, 0.0, 550.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Intensity = 300.0 cd`
- `Intensity Units = Candelas`
- `Attenuation Radius = 16384.0`

这张图表达的结论是：教程在最后阶段把之前偏强的前景粒子重新压回到辅助层，让冰刺主体重新成为最亮、最稳定的视觉中心，同时保留足够的漂浮粒子来支撑氛围
该图是本页结尾处的过渡镜头。画面里已经看不到冰刺主体，只保留深蓝背景和一条远处的蓝色亮痕，教程用这一帧把当前 Niagara 部分收尾，并口头引出下一步“在地面上加冰面”的内容

当前可直接确认的画面信息有：

- 视口中主体几乎全部移出画面，只剩深蓝色背景渐变
- 右上偏中位置保留一条短小的蓝色亮痕
- `Outliner` 中当前仍选中 `PointLight`
- 下方 `Sequencer` 时间线停在约 `5.00`

右侧 `Details` 面板仍能确认点光源保持：

- `Location = (0.0, 0.0, 550.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Intensity = 300.0 cd`
- `Intensity Units = Candelas`

字幕明确说明“我们会在地面上添加冰面”，因此这张图的作用主要是章节收束与下一步承接，而不是继续展示当前页面中的具体 Niagara 参数。就当前画面本身能确认的内容而言，现有冰刺与粒子部分已经结束，下一阶段将转向地面冰层相关处理

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。

