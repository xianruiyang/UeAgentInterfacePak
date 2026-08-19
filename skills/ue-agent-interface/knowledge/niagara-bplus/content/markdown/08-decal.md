# 08 制作 decal 主材质

# 08 制作 decal 主材质

## 关键术语

- `Color`、`Alpha`、`Scale Color`、`Material`、`UV`、`Multiply`、`Power`、`Base Color`、`Emissive`、`Texture`、`Sequencer`、`Niagara`、`Normalized Age`、`Decal`、`Translucent`、`Photoshop`、`Niagara System`、`Emitter`

## 分段知识

### 00:00:05-00:04:55 Material、UV、Decal

- 本段定位：Material、UV、Decal。
- 知识点：你好,再次在八強中問好 上次我们設置了序列器 并在第二个制作之前 并且简单看了一下鐵花演員 并在粒子中进行了测试。
- 知识点：这次后续会继续制作鐵花大師自動现實 然后再下次進入粒子制作 上次的接下来設置的序列器是这樣的 首先得創建一个将作为Master Material使用的材料。
- 知识点：那麼这里創建一个新的材料 命名为Lander和Decal 1 然后打開这个 看一下 然后表面如上次所做的那樣 改为Differ Decal。
- 知识点：改为Translucent 看一下 我们首先要獲取将使用的纹理 然后开始吧 我们基本上将使用这个纹理和髮線。
- 知识点：反正是粒化使用 所以 看其他纹理也没關係 这纹理将用於遮罩用途 现在需要用这纹理在頁縫之间表達某种圖像。
- 知识点：这纹理将被转换为纹理对象 可以简单制作Decal材料 这次制作的主材料将使用稱为 Parallax Occlusion Mapping的功能。
- 知识点：功能的作用是什么 比如說我们使用了平民網格 将该網格的高度值表達 得像是模型化的多邊形 可以認为是從UV形状印設出来的东西 因此在髮線印設中表现出的立体感較強。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Material`、`Decal`、`Translucent`、`纹理`、`粒子`、`序列`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: p09 开始时的关卡与资源基线
> - 组成部分: Level Viewport + Content Browser + Outliner + Sequencer
> - 所属: `02_Earth_Explosion`
> - 目的: 在制作 Decal 主材质前，确认上一节留下的 Sequencer、角色、关卡和粒子资源状态。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | 当前关卡 | `02_Earth_Explosion*` |
> | Content Browser | `Particles/Ex_02_Earth_Explosion` 文件夹 |
> | 资源 | `Exp_01` Niagara System、`Trail_01` Niagara System |
> | Viewport | Greystone 角色位于灰色网格地面上，画面为 Sequencer 镜头预览 |
> | Outliner | `01_Swing_Trail`、`Cine Camera Actor`、`Floor`、`Greystone`、`PlayerStart`、`PostProcessVolume`、`SpotLight` |
> | Details | 未选中对象，显示 `Select an object to view details.` |
> | Sequencer | `02_Earth_Explosion` 时间线打开，播放头在 `0000` 附近，Camera Cuts 和 Cine Camera Actor 轨道可见 |
> | 字幕 | 说明上次已经设置了序列器，并在第二个制作前进行准备 |
>
> 该图记录 p09 的起点：Sequencer 场景和前一节测试资源仍在，接下来会创建用于地面 Decal 的主材质。
> 图表转写（UE-GTXT v4）
> - 类型: `M_Decal_01` 材质图初始纹理节点
> - 组成部分: Content Browser + Material Editor + Material Graph + Details
> - 所属: `M_Decal_01`
> - 目的: 创建主 Decal 材质后，放入会用于裂缝/遮罩表达的纹理采样节点。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Material Editor | `M_Decal_01*` |
> | Graph 标题 | `M_Decal_01 > Material Graph` |
> | 左侧 Content Browser | `Texture` 文件夹，显示多种纹理资源 |
> | 当前 Details | `Material Expression Texture Sample` |
> | Texture | `T_RockPullDecal02_N` |
> | Sampler Type | `Normal` |
> | MipValueMode | `None (use computed mip level)` |
> | Sampler Source | `From texture asset` |
> | Graph 中节点 | 多个 Texture Sample 节点散布在图中，当前鼠标悬停提示 `Texture Sample` |
> | Stats | Texture samplers `0/16`，Texture Lookups 可见 |
> | 字幕 | 说明会用该纹理在裂缝之间表达图像 |
>
> 该图记录 `M_Decal_01` 主材质初期节点布局，当前重点是把裂纹相关纹理作为后续 Decal/POM 网络的输入资源。
> 图表转写（UE-GTXT v4）
> - 类型: `T_Radial_Cracks_D` 高度/遮罩纹理查看
> - 组成部分: Texture Editor + Content Browser + Details
> - 所属: `T_Radial_Cracks_D`
> - 目的: 查看用于 Parallax/Decal 裂缝表达的径向裂纹灰度纹理。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | 打开资源 | `T_Radial_Cracks_D` |
> | 通道按钮 | R/G/B/A 可见，当前画面为灰度裂纹图 |
> | 纹理内容 | 中央为深色圆形区域，周围有放射状裂纹、灰度渐变和碎裂边缘 |
> | Imported / Displayed | `2048x2048` |
> | Max In-Game | `2048x2048` |
> | Resource Size | `2731 KB` |
> | Has Alpha Channel | `False` |
> | Source Alpha Detected | `False` |
> | Level Of Detail | Mip Gen Settings `FromTextureGroup`；LOD Bias `0`；Texture Group `World` |
> | Compression | `Compress Without Alpha` 未勾选；`Editor Show Final Encode` 勾选 |
> | Adjustments | Brightness `1.0`、Brightness Curve `1.0`、Vibrance `0.0`、Saturation `1.0`、RGBCurve `1.0`、Hue `0.0` |
> | 字幕 | 说明黑色部分对应较靠后的部分 |
>
> 该图记录 `T_Radial_Cracks_D` 的灰度内容和基础 Texture Details。结合上下文，它作为高度/遮罩类输入，用明暗值参与后续 Parallax Occlusion Mapping 的深度感计算。

### 00:04:58-00:09:50 UV、SD

- 本段定位：UV、SD。
- 知识点：可以这樣理解 这个像素值好像是 從相機向亮看的方向 與物体方向对齊的那个向亮上 白色像素值較靠前 黑色值較靠後 这个原理就可以理解 所以按下選項卡。
- 知识点：Souls of Parallax Occlusion 会这樣制作成函數 在虛幻引擎中提供 只看得懂 感覺到性能層有點高 所以这是細節差異 可以感受一下应用後的感覺。
- 知识点：即使没有特别应用 你能實现一定程度的細節表现 在生成鐵花的情况下 使用简单版本 把这个排除 然后适当 在相機中很好地照射到 演出或这种地方。
- 知识点：使用这些也可以吧 但是我们现在是个人項目 制作并进行中 所以 需要使用 那麼让我开始适当構成一下制作吧 并且这里使用的參數 需要簡要解釋一下。
- 知识点：首先这些遮擋方面的參數 需要尝试输入數值纹理 如之前所說的那樣 会起到这种作用 这也可以实际上转换为 转换參數使用 将參數转换稱为高度圖。
- 知识点：需要命名为高度纹理 創建兩个標 一个是16 另一个是64 可以放入最大值和最小值 这些转换为參數 部长所表示的是 在表達这一層时 重複表達的次數。
- 知识点：这个數值变高时 反復的次數就会增加 成本会变得更貴 这就是这一步 數值可以挪動一些 来優化也好 并且 然后这个稱为高度比例 这将是深度感的數值強度。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `ParallaxOcclusionMapping` 函数初始连接
> - 组成部分: Material Editor + Material Graph + Details
> - 所属: `M_Decal_01`
> - 目的: 将高度纹理对象接入 UE 提供的 `ParallaxOcclusionMapping` 材质函数。
>
> 节点与连接:
> | 节点 | 类型/名称 | 可读 Pin / 值 | 连接 |
> |---|---|---|---|
> | `Height_Tex` | Param Tex Object | `UVs 0`、`Apply View MipBias`、预览为灰度裂纹纹理 | 输出连接到 `ParallaxOcclusionMapping.Heightmap Texture (T2d)` |
> | `ParallaxOcclusionMapping` | 材质函数 | 输入: `Heightmap Texture (T2d)`、`Height Ratio (S)`、`Min Steps (S)`、`Max Steps (S)`、`UVs (V2)`、`Heightmap Channel (V4)`、`Reference Plane (S)` | 当前至少接入高度图输入 |
>
> 可见材质设置:
> | 设置 | 值 |
> |---|---|
> | Material Domain | `Deferred Decal` |
> | Blend Mode | `Translucent` |
> | Shading Model | `Default Lit` |
> | Cast Ray Traced Shadows | 勾选 |
>
> 该图记录主 Decal 材质已经设置为 Deferred Decal + Translucent，并将 `Height_Tex` 作为 POM 的高度纹理输入。
> 图表转写（UE-GTXT v4）
> - 类型: POM 步数与高度强度参数
> - 组成部分: Material Graph + Details
> - 所属: `M_Decal_01 / ParallaxOcclusionMapping`
> - 目的: 给 POM 节点接入最小/最大步数和高度强度，控制视差采样成本与凹凸深度感。
>
> 节点与连接:
> | 节点 | 类型/名称 | 值/状态 | 连接到 |
> |---|---|---|---|
> | `16` | Scalar Parameter/常量参数 | Value `16.0` | `ParallaxOcclusionMapping.Min Steps (S)` |
> | `64` | Scalar Parameter/常量参数 | Value `64.0` | `ParallaxOcclusionMapping.Max Steps (S)` |
> | `Height_Str` | Scalar Parameter | Param `0.05`，Default Value `0.05` | `ParallaxOcclusionMapping.Height Ratio (S)` |
> | `Height_Tex` | Texture Object 参数 | 裂纹高度纹理 | `Heightmap Texture (T2d)` |
> | 常量向量 | `1,0,0,0` | 红色通道向量 | 连接到 `Heightmap Channel (V4)` |
> | Static Bool | `Static Bool (True)` | Value 勾选 | 接入布尔输入区 |
>
> POM 输出可见:
> | 输出 Pin | 状态 |
> |---|---|
> | `Parallax UVs` | 可见 |
> | `Offset Only` | 可见 |
> | `Shadow` | 可见 |
> | `Pixel Depth Offset` | 可见 |
> | `World Position` | 可见 |
> | `Tangent Light Vector` | 可见 |
> | `Material Complexity - Steps Debug` | 可见 |
>
> 该图记录 POM 主要参数已经连入：步数越高采样成本越高，`Height_Str` 控制高度/深度感强度。
> 图表转写（UE-GTXT v4）
> - 类型: POM 阴影/光向量相关输入
> - 组成部分: Material Graph + Details
> - 所属: `M_Decal_01 / ParallaxOcclusionMapping`
> - 目的: 记录 POM 函数中用于遮蔽/阴影方向的布尔和向量输入准备。
>
> 可见节点:
> | 节点 | 值/状态 | 连接关系 |
> |---|---|---|
> | `Height_Str` | Default Value `0.05` | 接入 `Height Ratio (S)` |
> | `16` | Value `16.0` | 接入 `Min Steps (S)` |
> | `64` | Value `64.0` | 接入 `Max Steps (S)` |
> | `1,0,0,0` Constant | 红色通道向量 | 接入 `Heightmap Channel (V4)` |
> | `Static Bool (True)` | Value 勾选 | 接入 POM 的布尔输入区 |
> | `ParallaxOcclusionMapping` | 输入区显示 `Render Shadows (Occlusion Mapping) (SB)`、`Light Vector (V3)`、`Shadow Steps (S)`、`Shadow Penumbra (S)`、`Transform To VertexNormal (SB)` | 当前图强调右侧可搜索/连接的阴影相关输入 |
>
> 可见材质设置:
> | 设置 | 值 |
> |---|---|
> | Material Domain | `Deferred Decal` |
> | Blend Mode | `Translucent` |
> | Shading Model | `Default Lit` |
>
> 该图记录 POM 节点中阴影相关输入的可见状态。当前课程语境说明这些输入将来可用于其他材质方向性/遮蔽计算，本例只保留基础理解和必要连接。

### 00:09:50-00:12:52 UV

- 本段定位：UV。
- 知识点：是否表達陰影 或表達遮蔽陰影 选择的話可以这樣理解 所以查找右方向时可以搜索 这里天空熱氣圈右方向 所以将系連接到光相量 在我们的例子中。
- 知识点：这不会展示出有意義的結果 但知道这些将来在其他部分 也能用得上 这里光这个指數所指的是 與正在使用的方向 光的指數向聯繫的部分 可以理解为将光相量的方向性。
- 知识点：提取計算 然后在貼花的那个部分 額外生成陰影 一个連接到陰影步驟 另一个是陰影区域 需要把數值放進来 而后续会使用的輸出 獲取已经应用的Pilax的UA值。
- 知识点：用於材质的優 然后也取一个陰影 在慢反射基礎色上再进行一次計算 基本的UV設置就是这樣 那麼我们從基礎颜色部分。
- 知识点：再来配置一次 首先将UV連接到这里 简单的区域调整和亮度调整的運算 參數可以适当去掉就好了 所以可以对功率值和成法 进行一次運算 我现在使用这个快節鍵創鍵节点。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 获取 POM 处理后的 `Parallax UVs`
> - 组成部分: Material Graph + Details
> - 所属: `M_Decal_01`
> - 目的: 从 `ParallaxOcclusionMapping` 输出中取出已经应用视差的 UV，供后续纹理采样使用。
>
> 节点与连接:
> | 节点 | Pin / 状态 | 连接 |
> |---|---|---|
> | `ParallaxOcclusionMapping` | 输出 `Parallax UVs` | 从右侧输出拖出连线 |
> | 新建节点占位 | `Place a new node.` | 正准备把 `Parallax UVs` 连接到后续节点 |
>
> 可见输出:
> | 输出 Pin | 说明 |
> |---|---|
> | `Parallax UVs` | 本图正在拖出的输出 |
> | `Offset Only`、`Shadow`、`Pixel Depth Offset`、`World Position`、`Tangent Light Vector`、`Material Complexity - Steps Debug` | 其他可用输出可见，但本图未接入后续网络 |
>
> 该图记录基础 UV 部分完成后，下一步要把 `Parallax UVs` 接到材质纹理采样链路，用同一组视差 UV 驱动 Base Color 等贴花纹理。
> 图表转写（UE-GTXT v4）
> - 类型: Base Color 纹理采样与亮度调整前置网络
> - 组成部分: Material Graph + Details
> - 所属: `M_Decal_01`
> - 目的: 用 POM 输出的 `Parallax UVs` 驱动基础颜色纹理采样，再通过 Power 和 Multiply 做区域/亮度调整。
>
> 节点与连接:
> | 节点 | 可读 Pin / 值 | 连接关系 |
> |---|---|---|
> | `ParallaxOcclusionMapping` | 输出 `Parallax UVs` | 连接到上方 Texture Sample 的 `UVs` |
> | Texture Sample | 预览为灰褐色岩石/裂纹纹理；输出 `RGB`、`R`、`G`、`B`、`A` | `RGB` 输出连接到 `Power.Base` |
> | Scalar `0` | Value `0.0` | 连接到 `Power.Exp` |
> | `Power` | 输入 `Base`、`Exp` | 输出连接到 `Multiply.A` |
> | Scalar `0` | Value `0.0` | 连接到 `Multiply.B` |
> | `Multiply` | 输入 `A`、`B` | 作为后续基础颜色/阴影调整链路的一部分 |
> | 右下 Texture Sample | 预览为紫蓝法线/纹理资源 | 本图中未进入当前上方链路 |
>
> 该图记录基础颜色链路的初始计算：视差 UV 驱动纹理采样，纹理 RGB 先经过 Power，再与标量相乘，用于后续可调亮度/阴影混合。
> 图表转写（UE-GTXT v4）
> - 类型: Base Color 前置网络的默认节点状态
> - 组成部分: Material Graph + Details
> - 所属: `M_Decal_01`
> - 目的: 记录基础颜色纹理、Power 和 Multiply 节点刚创建时的默认值状态，为后续转成参数和命名提供依据。
>
> 可见节点:
> | 节点 | 可读值/Pin | 状态 |
> |---|---|---|
> | Texture Sample | `UVs` 输入、`RGB/R/G/B/A/RGBA` 输出 | 预览为灰褐色纹理，使用 POM 处理后的 UV |
> | `Power` | `Base` 接 Texture Sample 输出，`Exp` 接标量 | 位于 Texture Sample 后方 |
> | Scalar `0` | Value `0.0` | 接入 `Power.Exp` |
> | `Multiply` | `A` 接 Power 输出，`B` 接标量 | 位于 Power 后方 |
> | Scalar `0` | Value `0.0` | 接入 `Multiply.B` |
> | 右下 Texture Sample | 紫蓝纹理预览 | 仍作为另一路纹理节点保留 |
>
> 该图显示 Power 与 Multiply 的默认标量仍为 `0.0`，下一步会把这些节点转换为参数并命名，避免主材质实例中无法调节基础颜色强度。

### 00:12:57-00:15:53 Color、Alpha、UV

- 本段定位：Color、Alpha、UV。
- 知识点：兩个都改为參數 名字也要改为纹理 改为converted parameter 命名为base color texture。
- 知识点：同时将base power 命名为power base strand 然后連接一个成法 再进行一次運算 用做陰影 让強度降低到0.5做的颜色。
- 知识点：創建一个手動插值 这里陰影部分的輸出丟失区域 我用alpha写 所以在进行成法之前 将这个陰影強度和未成法值 視为原始亮度 然后一次降低的聯想值。
- 知识点：可以區別为陰影 区域部分并以这种混合方式處理 最後生成这个 颜色通道的像量 如果将其更改为參數 变成为颜色。
- 知识点：需要稱之为基礎颜色 默認指示为1111 那麼这一部分 现在将輸出为基礎颜色 并且需要相同的UV用於法線纹理。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Color`、`Alpha`、`Texture`、`纹理`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Base Color 前置标量转参数
> - 组成部分: Material Graph + Details + 右键菜单
> - 所属: `M_Decal_01`
> - 目的: 将基础颜色链路中的常量改为可在材质实例中调节的参数。
>
> 节点与连接:
> | 节点 | 可读值/Pin | 连接关系 |
> |---|---|---|
> | Texture Sample | 输出 `RGB/R/G/B/A/RGBA` | `RGB` 连接到 `Power.Base` |
> | `Power` | 输入 `Base`、`Exp` | 输出连接到 `Multiply.A` |
> | Scalar Parameter | 名称显示为 `Param`，Default Value `1.0` | 连接到 `Power.Exp` |
> | Constant `1` | Value `1.0` | 连接到 `Multiply.B`，右键菜单选中 `Convert to Parameter` |
> | `Multiply` | 输入 `A`、`B` | 输出继续接后续颜色链路 |
>
> Details:
> | Owner | 字段 | 值 |
> |---|---|---|
> | Material Expression Constant | `Value` | `1.0` |
>
> 该图记录基础颜色纹理经过 `Power` 和 `Multiply` 前，常量节点正在转换为参数。后续会把这些参数命名为基础颜色强度/幂次相关字段，便于实例中调节。
> 图表转写（UE-GTXT v4）
> - 类型: Base Color 亮度与阴影混合网络
> - 组成部分: Material Graph + Details
> - 所属: `M_Decal_01`
> - 目的: 用基础纹理、幂次、强度和阴影强度构造 Base Color 的混合前置结果。
>
> 节点与连接:
> | 节点 | 可读值/Pin | 连接关系 |
> |---|---|---|
> | `BaseColor_Tex` | Texture Sample，输出 `RGB/R/G/B/A/RGBA` | `RGB` 连接到 `Power.Base` |
> | `Base_Pow` | Scalar Parameter，Default Value `1.0` | 连接到 `Power.Exp` |
> | `Power` | 输入 `Base`、`Exp` | 输出连接到第一个 `Multiply.A` |
> | `Base_Str` | Scalar Parameter，Default Value `1.0` | 连接到第一个 `Multiply.B` |
> | 第一个 `Multiply` | 输出基础亮度调整结果 | 一路连接到 `Lerp.A`，另一路进入第二个 `Multiply.A` |
> | `Shadow_Str` | Scalar Parameter，Default Value `0.5` | 连接到第二个 `Multiply.B`，并作为 `Lerp.Alpha` 输入 |
> | 第二个 `Multiply` | 将基础亮度结果与阴影强度相乘 | 输出连接到 `Lerp.B` |
> | `Lerp(1.)` | `A` 接未降低亮度结果，`B` 接阴影降低结果，`Alpha` 接 `Shadow_Str` | 输出继续到右侧颜色链路 |
>
> 联动关系:
> - `Base_Pow` 控制纹理幂次，`Base_Str` 控制基础强度。
> - `Shadow_Str=0.5` 同时参与阴影乘法和 Lerp Alpha，使基础亮度与降低后的阴影亮度混合。
> 图表转写（UE-GTXT v4）
> - 类型: Base Color 参数输出与 Normal 纹理链路
> - 组成部分: Material Graph + Details
> - 所属: `M_Decal_01`
> - 目的: 将混合后的基础颜色乘以颜色参数，并开始复用同一 UV 处理法线纹理。
>
> 节点与连接:
> | 节点 | 可读值/Pin | 连接关系 |
> |---|---|---|
> | `Lerp` | 输出基础颜色/阴影混合结果 | 连接到右侧 `Multiply.A` |
> | `Base_Color` | Vector Parameter，Default Value 为白色 | 连接到右侧 `Multiply.B` |
> | 右侧 `Multiply` | 输入 `A/B` | 输出作为 Base Color 方向的颜色结果继续连接 |
> | 下方 Texture Sample | 紫蓝法线纹理预览，输出 `RGB/R/G/B/A/RGBA` | `RGB` 连接到 `FlattenNormal.Normal (V3)` |
> | Constant `0` | Value `0.0` | 连接到 `FlattenNormal.Flatness (S)` |
> | `FlattenNormal` | 输入 `Normal (V3)`、`Flatness (S)`；输出 `Result` | 作为 Normal 链路的一部分 |
>
> 可见材质设置:
> | 设置 | 值 |
> |---|---|
> | Material Domain | `Deferred Decal` |
> | Blend Mode | `Translucent` |
> | Shading Model | `Default Lit` |
>
> 该图记录 Base Color 参数颜色已经加入，同时法线纹理开始接入 `FlattenNormal`，默认平坦度为 `0.0`。

### 00:15:58-00:18:49 材质、纹理与透明度控制

- 本段定位：材质、纹理与透明度控制。
- 知识点：創建三个標量 个子 粗糙度 鏡面 金屬 需要把这个也做成參數 金屬 鏡面 粗糙度 关于这个數值 我記得在第一篇中簡要介紹过 怎樣的感覺 數值是如何工作。
- 知识点：我記得曾經向大家展示过一次 这與data色彩匹配 看看会给人什么感覺 也不錯 可以了 首先就到这里 就保存资源 好的一保存 那麼 接下来简单檢查一下材质是否正常工作。
- 知识点：我们现在用的例子是axp 然后我把这个detail材质做成实例使用 放入0.2號文件夾并連接 然后打開实例先把所有選項打開 因为现在没有遮罩纹理。
- 知识点：没有連接 所以这樣显示先大致連接遮罩 試試看 先連接到不透明度 參數們适当看一下 将生命周期設置为大約5秒 首先基本色纹理进行亮度调整。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`、`生命周期`、`透明度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 材质主输入接线和基础标量输出
> - 组成部分: Material Graph + Details
> - 所属: `M_Decal_01`
> - 目的: 将 Base Color、Normal、Roughness、Specular、Metallic 等主材质输入接好，并把多个标量改为实例可调参数。
>
> 节点与连接:
> | 节点/输出 | 连接到主材质输入 |
> |---|---|
> | Base Color 颜色链路输出 | `M_Decal_01.Base Color` |
> | Metallic 标量 | `M_Decal_01.Metallic` |
> | Specular 标量 | `M_Decal_01.Specular` |
> | Roughness 标量 | `M_Decal_01.Roughness` |
> | `FlattenNormal.Result` | `M_Decal_01.Normal` |
>
> 可见标量:
> | 标量节点 | 当前值 |
> |---|---|
> | 上方标量 | `0.0` |
> | 中间标量 | `0.0` |
> | 下方标量 | `0.0` |
>
> 主材质节点可见输入:
> `Base Color`、`Metallic`、`Specular`、`Roughness`、`Emissive Color`、`Opacity`、`Normal`、`World Position Offset`、`Ambient Occlusion` 等。
>
> 该图记录主 Decal 材质的基础输出已经接入，金属度、镜面和粗糙度准备转为参数，默认值当前均为 `0.0`。
> 图表转写（UE-GTXT v4）
> - 类型: 材质实例应用后的关卡预览
> - 组成部分: Content Browser + Level Viewport + Details + Material Graph 窗口
> - 所属: `02_Earth_Explosion / M_Decal_01`
> - 目的: 保存主材质后，将材质或实例接到 Decal 测试效果上，检查贴花是否在场景中正常工作。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Content Browser 路径 | `Material` 文件夹 |
> | 资源 | `01`、`02` 文件夹，`M_Decal_01` Material，`M_SwordTrail_01` Material |
> | Viewport | Greystone 附近的地面上出现大块裂纹/泥土状 Decal 贴花 |
> | Outliner | `Floor` 被选中；可见 `01_Swing_Trail`、`Cine Camera Actor`、`Exp 01`、`Floor`、`Greystone` |
> | Floor Transform | Location `0.0, 0.0, -0.5`；Rotation `0.0, 0.0, 0.0`；Scale `8.0, 8.0, 8.0` |
> | Floor Material | `MI_ProcGrid` |
> | 下方窗口 | `M_Decal_01 > Material Graph` 仍打开 |
> | 字幕 | 说明接下来简单检查材质是否正常工作 |
>
> 该图记录主 Decal 材质接入测试后的场景效果：地面出现裂纹/泥土贴花，用于确认材质和 Decal 渲染链路可见。
> 图表转写（UE-GTXT v4）
> - 类型: Niagara Decal Renderer 绑定材质实例与预览
> - 组成部分: Niagara Stack + Details + Level Viewport + Outliner
> - 所属: `Exp_01 / Empty / Decal Renderer`
> - 目的: 将 `M_Decal_01_Ins_02` 绑定到 Niagara 的 Decal Renderer，并把粒子生命周期调到约 5 秒用于场景检查。
>
> Niagara 模块栈:
> | 组 | 模块/项 | 状态 | 可读信息 |
> |---|---|---|---|
> | `Emitter Spawn` | `Emitter State` | Enabled | `System` 标记可见 |
> | `Emitter Spawn` | `Spawn Burst Instantaneous` | Enabled | 一次性生成测试粒子 |
> | `Particle Spawn` | `Initialize Particle` | Enabled | 保留初始化模块 |
> | `Particle Spawn` | `Set: PARTICLES DecalSize / PARTICLES DecalOrientation` | Enabled | 设置 Decal 尺寸和朝向属性 |
> | `Render` | `Sprite Renderer` | Disabled/未启用 | 灰显 |
> | `Render` | `Decal Renderer` | Enabled | 当前选中 |
>
> Decal Renderer Details:
> | 字段 | 值 |
> |---|---|
> | Material | `M_Decal_01_Ins_02` |
> | Source Mode | `Particles` |
> | Renderer Visibility | `0` |
> | Decal Screen Size | `0.0` |
> | Position Binding | `PARTICLES Position` |
> | Decal Orientation Binding | `PARTICLES DecalOrientation` |
> | Decal Size Binding | `PARTICLES DecalSize` |
> | Decal Fade Binding | `PARTICLES DecalFade` |
> | Decal Sort Order Binding | `PARTICLES UniqueID` |
> | Decal Color Binding | `PARTICLES Color` |
> | Decal Visible Binding | `PARTICLES DecalVisible` |
> | Renderer Visibility Tag | `PARTICLES VisibilityTag` |
>
> Viewport:
> - 地面上可见较大的裂纹 Decal 贴花，边缘有灰雾/淡出感。
> - Outliner 中 `Floor` 被选中，`Exp 01`、`Exp 02`、`Exp 03` 仍在场景内。
>
> 该图记录 Decal 主材质实例已经由 Niagara `Decal Renderer` 输出，粒子属性绑定决定 Decal 的位置、朝向、尺寸、颜色和可见性。

### 00:18:56-00:22:09 关键流程 06

- 本段定位：关键流程 06。
- 知识点：如果平面给出負值 可以让下面的髮線感覺更強 相反 当指位一时髮線強度会适当平緩 默認設置为0 看高度強度 如果给0.2值 可以感覺到更深入。
- 知识点：给0值 可以平坦吊大 所以比起太強的指 因为太撕裂 就適度感覺比較好 这樣看有凹陷的感覺 反过来看有點突出 但有些不正常的比喻 所以不自然。
- 知识点：而且金屬像的情况也可以调整數值 名稱 这樣可以更加強化鐵的感覺 可观察到像珠子一樣高光 那种变窄的感覺 適度 这是个人喜好問題 当愚蠢变得高时。
- 知识点：鏡面影响減少 高光反射区域的強度 会变得更強和更清晰 这种东西现在不是很好 適度 我覺得这樣 相比於石頭过於閃亮的东西 是当地适当有一点光的感覺。
- 知识点：吧 那麼運作似乎都很好 如果现在做的話 如果感覺这个功能 似乎没有正常工作 您可以尝试斷開这些參數的連接 然后再重新連接 請尝试重新構建此节点一次。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: `M_Decal_01_Ins_02` 实例参数调整
> - 组成部分: Material Instance Details + Level Viewport + Outliner
> - 所属: `M_Decal_01_Ins_02`
> - 目的: 通过材质实例参数调整 Decal 的高度强度、法线平坦度、金属度、粗糙度、镜面和纹理输入。
>
> 实例参数:
> | 分组 | 参数 | 值/资源 |
> |---|---|---|
> | Global Scalar Parameter Values | `Base_Pow` | `1.0` |
> | Global Scalar Parameter Values | `Base_Str` | `1.0` |
> | Global Scalar Parameter Values | `Flatten_Str` | 当前输入 `-1.0` |
> | Global Scalar Parameter Values | `Height_Str` | `0.05` |
> | Global Scalar Parameter Values | `Metallic` | `0.0` |
> | Global Scalar Parameter Values | `Roughness` | `0.0` |
> | Global Scalar Parameter Values | `Shadow_Str` | `0.5` |
> | Global Scalar Parameter Values | `Specular` | `0.0` |
> | Global Texture Parameter Values | `BaseColor_Tex` | `T_RockPullDecal02_D` |
> | Global Texture Parameter Values | `Height_Tex` | `T_Radial_Cracks_D` |
> | Global Vector Parameter Values | `Base_Color` | 白色 |
> | General | Parent | `M_Decal_01` |
>
> Viewport/Details:
> - 右侧 `Floor` 仍被选中，Floor Location `0.0, 0.0, -0.5`、Scale `8.0, 8.0, 8.0` 可见。
> - 字幕说明当值为 `1` 时法线强度会稍微平滑；本图正在调整 `Flatten_Str`。
>
> 该图记录材质实例可调参数的初始检查，尤其是 `Flatten_Str` 对法线强度/平滑程度的控制。
> 图表转写（UE-GTXT v4）
> - 类型: 实例参数对贴花可见性的影响检查
> - 组成部分: Material Instance Details + Level Viewport + Outliner
> - 所属: `M_Decal_01_Ins_02`
> - 目的: 调整材质实例标量参数时，在关卡视口中检查 Decal 贴花是否过强、过平或不可见。
>
> 实例参数:
> | 分组 | 参数 | 值/资源 |
> |---|---|---|
> | Global Scalar Parameter Values | `Base_Pow` | `1.0` |
> | Global Scalar Parameter Values | `Base_Str` | `1.0` |
> | Global Scalar Parameter Values | `Flatten_Str` | `0.0` |
> | Global Scalar Parameter Values | `Height_Str` | `0.05` |
> | Global Scalar Parameter Values | `Metallic` | 正在输入 `1.0` |
> | Global Scalar Parameter Values | `Roughness` | `0.0` |
> | Global Scalar Parameter Values | `Shadow_Str` | `0.5` |
> | Global Scalar Parameter Values | `Specular` | `0.0` |
> | Global Texture Parameter Values | `BaseColor_Tex` | `T_RockPullDecal02_D` |
> | Global Texture Parameter Values | `Height_Tex` | `T_Radial_Cracks_D` |
> | Global Vector Parameter Values | `Base_Color` | 白色 |
>
> Viewport:
> - 当前视口中主要可见灰色网格地面，贴花效果不明显或处在镜头外/被当前参数状态弱化。
> - 右侧 `Floor` 被选中，材质仍为 `MI_ProcGrid`。
>
> 该图记录在实例中将 `Flatten_Str` 设回 `0.0`，并测试 `Metallic=1.0` 时的状态；用于判断金属度和法线/高度参数是否造成不自然或不可见结果。
> 图表转写（UE-GTXT v4）
> - 类型: `M_Decal_01` 主材质图总览
> - 组成部分: Material Graph + Details + Content Browser
> - 所属: `M_Decal_01`
> - 目的: 检查主 Decal 材质整体网络是否保存并正常工作，必要时断开并重连参数节点。
>
> 图中可见网络:
> | 区域 | 节点/参数 | 连接/用途 |
> |---|---|---|
> | 左侧 POM 输入 | `Height_Tex` Texture Object | 连接 `ParallaxOcclusionMapping.Heightmap Texture` |
> | 左侧 POM 输入 | `Height_Str` Default Value `0.05` | 连接 `Height Ratio` |
> | 左侧 POM 输入 | `16`、`64` | 分别连接 Min Steps / Max Steps |
> | 左侧 POM 输入 | `1,0,0,0` 常量向量 | 连接 Heightmap Channel |
> | 左侧 POM 输入 | `Static Bool (True)`、`Light Intensity 0`、`3.0`、`1.0` 等 | 接入 POM 阴影/光照相关输入 |
> | 中央 | `ParallaxOcclusionMapping` | 输出 `Parallax UVs`、`Offset Only`、`Shadow` 等 |
> | 右上 Base Color | `BaseColor_Tex`、`Base_Pow`、`Base_Str`、`Shadow_Str`、`Power`、`Multiply` | 由 `Parallax UVs` 驱动基础颜色和阴影混合 |
> | 右下 Normal | Texture Sample + `FlattenNormal` / 平坦度参数 | 构造 Normal 输出 |
>
> 可见材质设置:
> | 设置 | 值 |
> |---|---|
> | Material Domain | `Deferred Decal` |
> | Blend Mode | `Translucent` |
> | Shading Model | `Default Lit` |
>
> Stats:
> | 项 | 值 |
> |---|---|
> | Base pass shader | `301 instructions` |
> | Base pass vertex shader | `287 instructions` |
> | Texture samplers | `6/16` |
> | Texture Lookups | `VS(3), PS(3)` |
>
> 该图记录 `M_Decal_01` 主材质的阶段性总览：POM 输出驱动 Base Color 和 Normal 等链路，若参数连接异常，可按这些关键连线重新断开/连接检查。

### 00:22:16-00:25:16 Alpha、UV、Decal

- 本段定位：Alpha、UV、Decal。
- 知识点：接着看 现在口罩也简单 地就只挑了这个感覺 面具也要使用 相同的紫白線 而且除了这个口罩 需要再给你加一个区域 用球体面 制作一个球形面具。
- 知识点：EUV協調器在这里連接 并且中心值是0.5对齊 創建一个半徑參數 叫做decalibur 给它命名 因此这个歐萊 乘以以下 最後需要再乘一次。
- 知识点：我们常在尼亞加拉里 與物質關聯时使用的是粒子颜色 鐵花有鐵花颜色 因此鐵花这个颜色的alpha。
- 知识点：和乘法連接到透明度 然后现在最後剩下的 是發光颜色这一纹理要用 所以这个EUV也会用同樣的EUV 来使用 还有一个叫mask parameter。
- 知识点：參數这个叫做cap 需要把这个HB連接到这里 那麼在实例中会用R通道 用G通道 用B通道选择可以的呢 这里也需要一个 一个加上可以調節亮度的。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Decal`、`纹理`、`粒子`、`颜色`、`透明度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Opacity/Mask 纹理节点加入
> - 组成部分: Material Graph + Details
> - 所属: `M_Decal_01`
> - 目的: 在已有 Base Color/Normal/Roughness 链路之外，加入用于透明度或面具控制的贴花遮罩纹理。
>
> 可见节点与参数:
> | 节点 | 可读值/Pin | 连接/用途 |
> |---|---|---|
> | Texture Sample | Details 中 Texture 为 `falloff_circle`，Sampler Type `Color` | 图中用于圆形/软边遮罩；输出线连接到右侧链路 |
> | Texture Sample | 预览为紫色发光/花状纹理 | 位于遮罩节点旁，作为后续发光或纹理链路候选 |
> | `FlattenNormal` | `Normal (V3)`、`Flatness (S)`；Result 输出 | 法线链路继续保留 |
> | `Metallic` / `Specular` / `Roughness` 参数 | Default Value `0.0` 可见 | 继续连接主材质输入方向 |
>
> Details:
> | Owner | 字段 | 值 |
> |---|---|---|
> | Material Expression Texture Sample | `MipValueMode` | `None (use computed mip level)` |
> | Material Expression Texture Sample | `Sampler Source` | `From texture asset` |
> | Material Expression Texture Sample | `Automatic View Mip Bias` | 勾选 |
> | Texture Base | `Texture` | `falloff_circle` |
> | Texture Base | `Sampler Type` | `Color` |
>
> 该图记录透明度/面具部分开始加入 `falloff_circle` 纹理，用于在后续 Opacity 计算中提供软边或范围遮罩。
> 图表转写（UE-GTXT v4）
> - 类型: Opacity/SphereMask 节点准备
> - 组成部分: Material Graph + Details + 节点搜索菜单
> - 所属: `M_Decal_01`
> - 目的: 在 Opacity 链路中准备 Multiply 和球形遮罩相关节点，用于限制 Decal 可见区域。
>
> 可见节点:
> | 节点 | 可读值/Pin | 状态 |
> |---|---|---|
> | `FlattenNormal` | Result 输出仍接出 | Normal 链路保留 |
> | `Roughness` | Default Value `0.0` | 继续作为材质属性参数 |
> | `Multiply` | 输入 `A/B`、输出 | 作为 Opacity/Mask 链路的乘法节点 |
> | `Multiply(0.1)` | Const A `0.0`、Const B `1.0` | 当前被选中，Details 显示 Material Expression Multiply |
> | Texture Sample | 位于下方，预览为圆形/遮罩纹理 | 等待接入 Multiply 或后续遮罩链路 |
> | 搜索菜单 | `SphereMask` 类别未展开，菜单列出 `Atmosphere`、`Blends`、`Color`、`Coordinates` 等 | 正在添加遮罩/相关节点 |
>
> Details:
> | Owner | 字段 | 值 |
> |---|---|---|
> | Material Expression Multiply | `Const A` | `0.0` |
> | Material Expression Multiply | `Const B` | `1.0` |
>
> 该图记录 Opacity 链路中用于叠加遮罩的 Multiply 节点和搜索新节点的状态；后续会把圆形遮罩、Decal Color Alpha 等共同乘入透明度。
> 图表转写（UE-GTXT v4）
> - 类型: Emissive 与 Decal Color Alpha 链路
> - 组成部分: Material Graph + Details
> - 所属: `M_Decal_01`
> - 目的: 为发光纹理选择通道、设置发光强度，并引入 `DecalColor` 的 Alpha 用于粒子颜色控制。
>
> 节点与连接:
> | 节点 | 可读值/Pin | 连接/用途 |
> |---|---|---|
> | Texture Sample | 紫色发光纹理，输出 `RGB/R/G/B/A/RGBA` | 连接到 `Channel` 节点输入 |
> | `Channel` | Default Value 显示红色通道预览 | 输出连接到 `Power.Base` |
> | `Power` | 输入 `Base`、`Exp` | 输出连接到 `Multiply.A` |
> | `Emissive_Pow` | Scalar Parameter，Default Value `0.0` | 连接到 `Power.Exp` |
> | Constant `0` | Value `0.0` | 连接到 `Multiply.B` |
> | `Multiply` | 输出继续进入右侧发光/输出链路 |
> | `DecalColor` | Input Data，输出 `RGB/R/G/B/A/RGBA` | `A` 输出连接到右侧长线，用于透明度/颜色相关控制 |
>
> Details:
> | Owner | 字段 | 值 |
> |---|---|---|
> | `Emissive_Pow` Scalar Parameter | Parameter Name | `Emissive_Pow` |
> | `Emissive_Pow` Scalar Parameter | Default Value | `0.0` |
> | Material Expression | Sort Priority | `32` |
>
> 该图记录发光链路的基本形式：发光纹理先经通道选择和 Power，再与强度值相乘；`DecalColor.A` 为后续粒子颜色 Alpha 参与透明度提供输入。

### 00:25:20-00:28:15 Emissive、Substance、Photoshop

- 本段定位：Emissive、Substance、Photoshop。
- 知识点：乘法放入圖像颜色中 主材质似乎已经完成 那麼我们现在使用的 这种基礎颜色或雜線纹理和零式纹理。
- 知识点：各自制作的方式都不同 有的人是用3D制作 还有的人是使用现成的素材 但是从头到尾教您如何制作这种素材 需要太多时间 所以我们暫时覺得这也是免費資源。
- 知识点：将PALA工資源拿来使用 可以看作 这樣構成竹水材质後 高度圖其實可以简单構成区域 所以也可以简单用Photoshop制作 这种面具纹理也是一樣的。
- 知识点：这种基礎颜色的情况下 作为背景使用的那种擴散纹理 那种东西导入使用使用也可以 你一定要这樣列文明確遞留着 某种程度上或者是列文形状的东西。
- 知识点：拿来做面具纹理一次乘法使用也是 这也是一般背景擴散纹理其中一种方法 这种方式不如一定要堅持 可以把这个格式更好 遞定制给自己使用 如果有这种坑形的髮線最好。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Emissive`、`Photoshop`、`材质`、`纹理`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 完整 Opacity/Emissive 局部链路
> - 组成部分: Material Graph + Details
> - 所属: `M_Decal_01`
> - 目的: 查看面具纹理、SphereMask、Emissive 纹理、通道选择、DecalColor 和材质输出之间的局部关系。
>
> 可见节点组:
> | 节点/组 | 可读信息 | 连接/用途 |
> |---|---|---|
> | `SphereMask` | `A`、`B`、`Radius`、`Hardness`，Hardness 可见 `100.0` | 参与范围/圆形遮罩控制 |
> | 上方 Texture Sample | 白色圆形遮罩纹理 | 经 Multiply 接入透明度链路 |
> | 下方 Texture Sample | 紫色发光纹理 | 接到 `Channel` 节点 |
> | `Channel` | Details 中 Parameter Name `Channel`，Mask Channel 为 `Red` | 选择纹理通道 |
> | `Power` + `Emissive_Pow` | `Emissive_Pow` Default Value `0.0` | 控制发光纹理强度/幂次 |
> | `DecalColor` | Input Data，输出 `RGB/R/G/B/A/RGBA` | `A` 与透明度/乘法链路相连 |
> | 右侧主输出方向 | 可见多条线接到材质主节点方向 | 连接 Base/Opacity/Emissive 等后续输出 |
>
> Stats:
> | 项 | 值 |
> |---|---|
> | Texture samplers | `4/16` |
> | Texture Lookups | `VS(3), PS(4)` |
> | Shader Count | `3` |
>
> 该图记录主材质接近完成时的遮罩和发光局部网络：SphereMask 与遮罩纹理控制范围，Emissive 纹理通过通道和强度参数进入输出，DecalColor 提供粒子颜色/Alpha 数据。
> 图表转写（UE-GTXT v4）
> - 类型: BaseColor 纹理参数和 POM UV 复用
> - 组成部分: Material Graph + Details
> - 所属: `M_Decal_01`
> - 目的: 确认基础颜色纹理参数 `BaseColor_Tex` 使用 POM 输出 UV，并与 Base Power/Base Strength/Shadow Strength 链路相连。
>
> 节点与连接:
> | 节点 | 可读值/Pin | 连接/用途 |
> |---|---|---|
> | `ParallaxOcclusionMapping` | 输出 `Parallax UVs`、`Offset Only`、`Shadow` 等 | `Parallax UVs` 分叉连接到多个 Texture Sample 的 `UVs` |
> | `BaseColor_Tex` | Param2D，Details 中 Parameter Name `BaseColor_Tex` | `RGB` 输出进入 `Power.Base` |
> | `Base_Pow` | Default Value `1.0` | 接 `Power.Exp` |
> | `Base_Str` | Default Value `1.0` | 接第一个 Multiply |
> | `Shadow_Str` | Default Value `0.5` | 接阴影乘法和 Lerp Alpha |
> | 法线 Texture Sample | 紫蓝纹理 | 同样使用 POM 输出的 UV，连接 `FlattenNormal` |
> | `Flatten_Str` | Default Value `0.0` | 连接 `FlattenNormal.Flatness` |
>
> Details:
> | Owner | 字段 | 值 |
> |---|---|---|
> | `BaseColor_Tex` | Parameter Name | `BaseColor_Tex` |
> | Texture Sample | MipValueMode | `None (use computed mip level)` |
> | Texture Sample | Sampler Source | `From texture asset` |
> | Texture Sample | Automatic View Mip Bias | 勾选 |
>
> 该图记录多个纹理采样共享 POM 后的 UV，基础颜色纹理不一定必须保持明确裂纹形状，可替换为适合背景/扩散的纹理。
> 图表转写（UE-GTXT v4）
> - 类型: 主 Decal 材质阶段性完整网络
> - 组成部分: Material Graph + Details
> - 所属: `M_Decal_01`
> - 目的: 展示 `M_Decal_01` 已完成基础颜色、法线、遮罩、发光和 Decal Color 的主要连接。
>
> 可见网络:
> | 分支 | 关键节点 | 输出/用途 |
> |---|---|---|
> | POM/UV | `ParallaxOcclusionMapping` | `Parallax UVs` 分叉给 BaseColor、Normal、Opacity、Emissive 等纹理采样 |
> | Base Color | `BaseColor_Tex`、`Base_Pow`、`Base_Str`、`Shadow_Str`、`Power`、`Multiply`、`Lerp`、`Base_Color` | 形成基础颜色输出 |
> | Normal | 法线 Texture Sample、`Flatten_Str`、`FlattenNormal` | 形成 Normal 输出 |
> | Opacity/Mask | `SphereMask`、白色圆形 `Opacity_Tex`、Multiply | 形成透明度/范围遮罩 |
> | Emissive | `Emissive_Tex`、`Channel`、`Power`、`Emissive_Pow`、Multiply | 形成发光输出 |
> | Particle/Decal Color | `DecalColor` Input Data | 提供颜色和 Alpha 控制 |
>
> 可见材质设置:
> | 设置 | 值 |
> |---|---|
> | Material Domain | `Deferred Decal` |
> | Blend Mode | `Translucent` |
> | Shading Model | `Default Lit` |
>
> Stats:
> | 项 | 值 |
> |---|---|
> | Texture samplers | `4/16` |
> | Texture Lookups | `VS(3), PS(4)` |
> | User interpolators | `2/4 Scalars (1/4 Vectors)` |
>
> 该图记录主 Decal 材质已形成较完整结构，可作为下一步 Niagara 粒子颜色和缩放颜色控制的材质基础。

### 00:28:22-00:31:16 Color、Scale Color、Decal

- 本段定位：Color、Scale Color、Decal。
- 知识点：现在鐵花颜色和现在連接的 就是可能没出现 这个颜色就我们下次要做的試力 只制作这个鐵花粒子。
- 知识点：也不錯先做好再进行 想隱去隨命名 就删除spray 颜色部分适当调整一下就可以 如果用縮放颜色。
- 知识点：鐵花減少的默認值不是0 而是0.5 这里在主材这里 这种錯覺也会浪費时间 需要修正 那麼现在零食纹理也是这樣出来的。
- 知识点：现在紅色通道是默認的 纹理也会參數化 不透明度纹理 纹理这个是圖像纹理挺好的 哦这樣看这个纹理打開看看。
- 知识点：这个是现在R通道G通道B通道每个 这个裂縫的零食布的形状是不同的 所以可以选择使用的方式 需要取綠色通道来使用 而且如果区域太大就不行了。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Color`、`Scale Color`、`Decal`、`纹理`、`粒子`、`颜色`、`透明度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Niagara 粒子颜色控制前的系统状态
> - 组成部分: Niagara System Overview + Emitter Stack + Parameters + Details + Timeline
> - 所属: `Exp_01 / Empty`
> - 目的: 准备下一步通过 Niagara 粒子颜色控制 Decal 材质颜色和透明度。
>
> Niagara 模块栈:
> | 组 | 模块/项 | 状态 | 可读信息 |
> |---|---|---|---|
> | System | `Properties`、`User Parameters`、`System Spawn`、`System Update`、`System State` | 可见 | 系统基础结构 |
> | Emitter | `Emitter State` | Enabled | `System` 标记 |
> | Emitter | `Spawn Burst Instantaneous` | Enabled | 一次性生成 |
> | Particle Spawn | `Initialize Particle` | Enabled | 初始化粒子 |
> | Particle Spawn | `Set: PARTICLES DecalSize / PARTICLES DecalOrientation` | Enabled | 设置 Decal 相关属性 |
> | Particle Update | `Particle State` | Enabled | 右侧 Details 当前选中 |
> | Render | `Sprite Renderer` | Disabled/灰显 | 不作为当前输出 |
> | Render | `Decal Renderer` | Enabled | 输出 Decal |
>
> Parameters:
> | 分组 | 可见变量 |
> |---|---|
> | System Attributes | `SYSTEM Age`、`SYSTEM bCompleteOnInactive`、`SYSTEM CurrentLoopDelay`、`SYSTEM CurrentLoopDuration`、`SYSTEM ExecutionState` |
>
> Details:
> | Owner | 字段 |
> |---|---|
> | `Particle State` | `Kill Particles When` 勾选/可见 |
>
> 该图记录材质完成后回到 `Exp_01` Niagara 系统，下一步要用粒子侧颜色/Scale Color 控制 Decal Color。
> 图表转写（UE-GTXT v4）
> - 类型: Opacity/Emissive 纹理与通道参数
> - 组成部分: Material Graph + Preview + Details
> - 所属: `M_Decal_01`
> - 目的: 检查 Opacity 和 Emissive 纹理在材质图中的连接，并确认通道选择参数。
>
> 可见节点与连接:
> | 节点 | 可读值/Pin | 连接/用途 |
> |---|---|---|
> | `Opacity_Tex` | Param2D，预览为白色圆形遮罩，输出 `RGB/R/G/B/A/RGBA` | `RGB` 输出连接到 Multiply |
> | `Emissive_Tex` | Param2D，预览为紫色发光纹理，输出 `RGB/R/G/B/A/RGBA` | 输出进入 `Channel` |
> | `Channel` | Mask Channel 为 `Red`，红色通道预览可见 | 输出用于发光链路 |
> | `Emissive_Pow` | Scalar Parameter | 位于发光 Power/Multiply 链路下游 |
> | `Flatten_Str` | Default Value `0.0` | 继续控制 `FlattenNormal` |
>
> Preview:
> - 左侧材质预览窗口显示灰底上白色烟雾/云团状预览，用于检查遮罩与发光纹理组合效果。
>
> Stats:
> | 项 | 值 |
> |---|---|
> | Base pass shader | `317 instructions` |
> | Texture samplers | `7/16` |
> | Texture Lookups | `VS(3), PS(4)` |
> | Shader Count | `25` |
>
> 该图记录 Opacity 使用圆形遮罩纹理，Emissive 使用紫色纹理并通过 `Channel=Red` 选择通道；这些参数可在实例中替换和调整。
> 图表转写（UE-GTXT v4）
> - 类型: Scale Color 关联的 Opacity/Emissive 参数状态
> - 组成部分: Material Graph + Preview + Details
> - 所属: `M_Decal_01`
> - 目的: 明确材质中 `Opacity_Tex`、`Emissive_Tex`、`Channel` 和 `Emissive_Pow` 会在粒子侧通过颜色/Alpha 进行动态控制。
>
> 可见节点:
> | 节点 | 可读值/Pin | 连接/用途 |
> |---|---|---|
> | `Opacity_Tex` | Param2D，白色圆形遮罩，输出 `RGB/R/G/B/A/RGBA` | `RGB` 进入 Multiply，用于透明度遮罩 |
> | `Emissive_Tex` | Param2D，紫色发光纹理，输出 `RGB/R/G/B/A/RGBA` | 进入 `Channel` |
> | `Channel` | Mask Channel `Red` | 选择发光纹理通道 |
> | `Emissive_Pow` | Scalar Parameter，Default Value 可见为 `0.0` | 控制发光链路强度/幂次 |
> | `Flatten_Str` | Default Value `0.0` | 仍连接 Normal 平坦度 |
>
> Preview:
> - 左侧预览显示灰底白色云团/贴花形态，用于检查当前遮罩和纹理组合。
>
> 字幕语义:
> - 教程说明如果在粒子中控制临时部值，可用 `ScaleColor` 值影响材质侧 Decal Color / Alpha。
>
> 该图记录 p09 当前材质与 Niagara 粒子颜色控制的交界：材质提供可调的 Opacity/Emissive/Channel 参数，后续粒子侧通过颜色与 Alpha 控制出现和消失。

### 00:31:21-00:34:10 Alpha、Multiply、AE

- 本段定位：Alpha、Multiply、AE。
- 知识点：现在有點閃閃發光然后消失 所以为了让它自然消失 需要调整Alpha 出来是生成时适当突然一点也没關係 消失时自然会消失 因为出来是会伴隨一些爆炸。
- 知识点：本段围绕 `Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：Koo Jou C Dum 改为真摯 将这个浮動值做成曲線 一开始适当明亮地閃爍 然后慢慢消失会更好。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Multiply`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Decal 结果预览与 Scale Color 入口
> - 组成部分: Level Viewport + Content Browser + Niagara Details
> - 所属: `02_Earth_Explosion / Exp_01 / Decal`
> - 目的: 检查多个 Decal 爆炸贴花的最终外观，并准备通过 `Scale Color` 让发光/透明度自然消失。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Content Browser | `Material/02` 中可见 `M_Decal_01` 和材质实例 |
> | Viewport | 地面上有 3 个裂纹/坑洞状 Decal 区域，中心带白色发光裂纹，边缘为暗色碎裂和灰色淡出 |
> | Outliner | `Floor` 被选中；`Exp 01`、`Exp 02`、`Exp 03` 仍存在 |
> | Floor Transform | Location `0.0, 0.0, -0.5`；Scale `8.0, 8.0, 8.0` |
> | Niagara Details | 选中 `Decal` 模块，`Scale Color` 可见，Scale Mode 为 `RGB and Alpha Separately` |
> | 字幕 | 说明为了让它自然消失 |
>
> 该图记录材质和 Niagara Decal Renderer 已能输出连续的地裂贴花；后续通过 `Scale Color` 分别控制 RGB 与 Alpha 的衰减。
> 图表转写（UE-GTXT v4）
> - 类型: `Scale Color` RGB/Alpha 曲线设置
> - 组成部分: Niagara Stack + Details + Curve Editor + Timeline
> - 所属: `Exp_01 / Decal / Scale Color`
> - 目的: 用曲线控制 Decal 的颜色强度和透明度随 `Particles.NormalizedAge` 衰减。
>
> 模块栈:
> | 组 | 模块/项 | 状态 |
> |---|---|---|
> | Particle Spawn | `Initialize Particle` | Enabled |
> | Particle Spawn | `Set: PARTICLES DecalSize / DecalOrientation` | Enabled |
> | Particle Update | `Particle State` | Enabled |
> | Particle Update | `Scale Color` | 当前选中 |
> | Render | `Decal Renderer` | Enabled |
>
> Scale Color Details:
> | 字段 | 值 |
> |---|---|
> | Scale Mode | `RGB and Alpha Separately` |
> | Scale RGB | `Multiply Vector by Float`；Vector `10.0, 4.0, 3.0` |
> | Scale RGB Float | `Float from Curve` |
> | RGB CurveIndex | `PARTICLES NormalizedAge` |
> | RGB Scale Curve | `1.0` |
> | Scale Alpha | `Float from Curve` |
> | Alpha CurveIndex | `PARTICLES NormalizedAge` |
> | Alpha Scale Curve | `1.0` |
>
> Curve Editor:
> - 左侧 `Scale RGB` 曲线从 Time `0.1`、Value `450` 附近向后下降，到生命周期后段接近 `0`。
> - 右侧 `Scale Alpha` 曲线在前段保持接近 `1.0`，后段下降到 `0`。
>
> 该图记录 RGB 发光强度和 Alpha 透明度分开控制：RGB 可以先亮再衰减，Alpha 在末尾自然淡出。
> 图表转写（UE-GTXT v4）
> - 类型: `Initialize Particle` 寿命与尺寸设置
> - 组成部分: Niagara Stack + Details + Curve Editor + Timeline
> - 所属: `Exp_01 / Decal / Initialize Particle`
> - 目的: 设置 Decal 粒子的寿命与基础尺寸，使 Scale Color 曲线有足够时间完成淡出。
>
> Details:
> | 分组 | 字段 | 值 |
> |---|---|---|
> | Point Attributes | Lifetime Mode | `Direct Set` |
> | Point Attributes | Lifetime | `3.0` |
> | Point Attributes | Color Mode | `Unset` |
> | Point Attributes | Position Mode | `Simulation Position` |
> | Sprite Attributes | Sprite Size Mode | `Uniform` |
> | Sprite Attributes | Uniform Sprite | `200.0` |
> | Sprite Attributes | Sprite Rotation Mode | `Unset` |
> | Sprite Attributes | Sprite UV Mode | `Unset` |
> | Mesh/Ribbon Attributes | 多项为 `Unset` |
>
> 关联状态:
> - 左侧 Curve Editor 仍显示 `Scale Color` 曲线，RGB 曲线前段约 `500` 后迅速降至 `0`。
> - Timeline 中 `Decal` 轨道可见，播放头约 `0.39`。
>
> 该图记录 Decal 粒子 Lifetime 被设为 `3.0`，基础 Sprite Size 为 `200.0`；虽然渲染器为 Decal Renderer，Initialize Particle 仍提供粒子寿命和基础属性。

### 00:34:25-00:35:00 关键流程 11

- 本段定位：关键流程 11。
- 知识点：Do this 这个设置为大約五零 制作过一次 接着下一次时间 爆炸的整体感覺 元素們再加上其他灰塵和碎片的时间 一次进行一下 到此为止 辛苦了。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Scale Color 曲线收尾检查
> - 组成部分: Niagara System Overview + Curve Editor + Timeline
> - 所属: `Exp_01 / Decal / Scale Color`
> - 目的: 在课程收尾前再次确认 Decal 的颜色强度曲线。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Curve Editor | `Decal Emitter > Scale Color > Scale RGB > Float` 被选中 |
> | 曲线形态 | 曲线从约 `500` 迅速下降到 `0`，后段保持接近 `0` |
> | System Overview | `Exp_01` 系统节点和 `Decal` 发射器节点可见 |
> | Timeline | `Decal` 轨道可见，播放头约 `6.67` |
> | 字幕 | 说明这个设置约为 `500` |
>
> 该图记录 RGB 强度曲线的高起始值和快速衰减，用于制造爆发瞬间较亮、随后消失的 Decal 发光表现。
> 图表转写（UE-GTXT v4）
> - 类型: Scale RGB 曲线与时间线复查
> - 组成部分: Niagara Curve Editor + System Overview + Timeline
> - 所属: `Exp_01 / Decal`
> - 目的: 复查 `Scale RGB` 曲线在播放时间线中的效果区间。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Curve Editor 列表 | `Decal Emitter`、`Scale Color`、`Scale Alpha`、`Scale RGB`、`Float` |
> | 曲线 | 起始约 `500`，很短时间内降至 `0`，后段保持为 `0` |
> | System Overview | `Exp_01` 和 `Decal` 发射器节点可见 |
> | Timeline | `Decal` 片段从 `0.00` 开始，播放头约 `5.63` |
> | Details | 右侧 Details 搜索框为空，未显示具体字段 |
>
> 该图作为 S11 收尾复查，确认颜色强度曲线已经设置为快速衰减，符合爆炸贴花短暂闪亮后消失的目标。
> 图表转写（UE-GTXT v4）
> - 类型: p09 结尾状态
> - 组成部分: Niagara System Overview + Curve Editor + Timeline
> - 所属: `Exp_01 / Decal`
> - 目的: 记录本课结束前的 Niagara Decal 发射器和 Scale Color 曲线状态。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | System Overview | `Exp_01` 系统节点位于上方，`Decal` 发射器节点位于下方 |
> | Curve Editor | 仍选中 `Scale RGB` 的 `Float` 曲线，起始高值后快速降为 `0` |
> | Timeline | `Decal` 轨道片段可见，播放头约 `6.20` |
> | 字幕 | 说明本节到这里执行一次/完成一次 |
>
> 该图记录 p09 最终工作状态：`M_Decal_01` 主材质已经配置完成，Niagara Decal 发射器通过 `Scale Color` 曲线控制短暂发光和淡出。

## 补充视觉证据

### S01 00:02:52

> 图表转写（UE-GTXT v4）
> - 类型: `M_Decal_01` 初期材质图补充证据
> - 组成部分: Content Browser + Material Graph + Details
> - 所属: `M_Decal_01`
> - 目的: 补充 p09 开头创建 Decal 主材质时的基础设置和高度纹理节点位置；该图实际为 Material Graph，不是 Niagara Graph。
>
> 可见信息:
> | 区域 | 值/状态 |
> |---|---|
> | Content Browser | `Texture` 文件夹，选中 `T_Radial...` 纹理；周围可见 `T_Depth_01`、`T_Lightning...`、`T_RockPull...` 等 |
> | Material Editor | `M_Decal_01 > Material Graph` |
> | Graph | 画面中央可见一个 Texture Object/Texture Sample 节点，预览为黑白径向裂纹纹理；右侧边缘可见另一个紫蓝纹理节点局部 |
> | Details | Material Domain `Deferred Decal`；Blend Mode `Translucent`；Shading Model `Default Lit`；`Cast Ray Traced Shadows` 勾选 |
> | Stats | Texture samplers `0/16`；Texture Lookups `VS(0), PS(3)`；Shader Count `0` |
> | 字幕 | 说明可以简单制作 Decal 材料 |
>
> 该补充图用于确认 `M_Decal_01` 初期已经设置为 Deferred Decal + Translucent，并准备使用径向裂纹纹理作为高度/遮罩输入。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。

