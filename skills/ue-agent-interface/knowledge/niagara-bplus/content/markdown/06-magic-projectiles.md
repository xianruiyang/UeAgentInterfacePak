# 06 Magic Projectiles

# 06 Magic Projectiles

## 关键术语

- `System`、`Lifetime`、`Color`、`Alpha`、`Bounds`、`Dynamic Parameter`、`Material`、`Depth Fade`、`UV`、`Lerp`、`Add`、`Clamp`、`Niagara`、`Multiply`、`Niagara System`、`Emitter`、`Particle`、`Spawn Rate`

## 分段知识

### 00:00:05-00:03:42 Color、Dynamic Parameter、Material

- 本段定位：Color、Dynamic Parameter、Material。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。；User Parameter 要保持命名和类型稳定，便于蓝图、材质或系统级控制复用。
- 知识点：本段围绕 `Color`、`Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：User Parameter 要保持命名和类型稳定，便于蓝图、材质或系统级控制复用。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Color`、`Alpha`、`Opacity`、`Material`、`Texture`、`Dynamic Parameter`、`User Parameter`、`Noise`。

**关键画面：**

这是新章节 `06 Magic Projectiles` 的关卡成片目标画面。左侧站着角色，右侧是白色 `Cylinder` 受击体，中间一束由两股主要紫色能量拖尾组成的弹道正命中圆柱，命中点出现明亮的白紫色核心亮斑，地面上也能看到明显的紫色反光与雾化辉光

这张图说明本章一开始的目标视觉不是单一 Ribbon，而是由多层材质共同组成的魔法投射物：主拖尾负责能量束形状，命中点负责高亮爆发，地面反射和周围雾化负责补足体积感与发光范围

下方 `Content Browser` 当前定位在 `Content/VFX_Library/Materials/MM`，可见正在使用或对照的一组材质资源：
- `_Special` 文件夹
- `M_MagicRibbon`
- `M_SceneRadialBlur`
- `M_UberMaterial`
- `M_Shock`

因此这张图还能确认本段后续的 `Color`、`Dynamic Parameter`、`Material` 调整会围绕这些主材质展开，尤其是 Ribbon、径向模糊和冲击材质之间的配合。当前图没有展开具体材质节点或参数，所以这里只能把它作为章节目标效果与所涉材质集合的总览依据
这是材质 `M_Shockwave` 的 `Material Graph` 局部截图，当前在搭建一段基于 UV 坐标和噪声纹理的流动控制逻辑。字幕也明确说明“添加逻辑来控制这个，这将是一个 UV 坐标”，说明这一段的重点是给纹理采样增加可调的坐标驱动

可见节点定义集：
- `Panner`
- `Texture Sample`
- `Multiply(1)`
- 标量参数 `Coor`
- 左下角还有一个上游节点连接到 `Panner` 与 `Texture Sample`，但节点标题被截断，无法可靠辨认

可见连线集：
- 左侧一条上游白线接入 `Panner.Coordinate`
- `Panner` 输出连接到 `Texture Sample.UVs`
- 左下角上游节点的输出连接到 `Texture Sample.Tex`
- `Texture Sample` 的红通道 `R` 输出连接到 `Multiply(1).A`
- `Multiply(1).B = 1.0`
- `Coor` 目前单独放在右下方，尚未接线

设置/参数：
- `Coor` 是一个参数节点，`Default Value = 0.0`
- 左侧 `Details` 面板可见它当前的 `Parameter Name = Param`
- `Multiply(1)` 的 `B = 1.0`
- `Texture Sample` 预览是一张浅灰色噪声/云纹贴图

输出/预览：
- 左侧预览窗口当前是一整块黑色圆盘，说明这段网络此时还处在搭建过程，尚未形成最终的可见冲击波图样

从这张图可以确认，本段材质工作不是直接改颜色，而是先建立一个能控制 UV 坐标流动的基础链路：通过 `Panner` 推动纹理坐标，读取噪声贴图，再把其中一个通道送入后续计算。`Coor` 参数显然准备用作额外的坐标控制量，但由于还未接线，不能推断它最终接到哪个输入端
这是 `M_Shockwave` 材质图中同一段 UV/噪声控制网络的更完整视图。相比上一张图，这里已经能确认最终目标是生成一个名为 `Color Noise UV_1` 的中间结果，并且噪声影响强度由 Niagara 的 `Dynamic Parameter` 驱动

节点定义集：
- 两个 `Append`
- 两个未命名的 `Multiply`
- `Panner`
- `Texture Sample`
- `T_Noise`，`Param Tex Object`
- `Opacity Noise Influence` 参数，`Default Value = -1.0`
- `Dynamic Parameter`
- 命名重路由输出 `Color Noise UV_1`

连线集：
- 上方 `Append` 输出连接到左上 `Multiply` 的一个输入
- 左上 `Multiply` 输出连接到 `Panner.Coordinate`
- 下方 `Append` 输出连接到 `Panner.Speed`
- `T_Noise` 输出连接到 `Texture Sample.Tex`
- `Panner` 输出连接到 `Texture Sample.UVs`
- `Texture Sample` 的 `R` 通道输出连接到右上 `Multiply.A`
- `Opacity Noise Influence` 输出连接到右下 `Multiply.A`
- `Dynamic Parameter` 的蓝色输出 `Noise Influence` 连接到右下 `Multiply.B`
- 右下 `Multiply` 输出连接到右上 `Multiply.B`
- 右上 `Multiply` 输出连接到 `Color Noise UV_1`

设置/参数：
- `Opacity Noise Influence = -1.0`
- `Dynamic Parameter`：
  - `Parameter Index = 0`
  - 可见输出包括 `Param1`、`Param2`、`Noise Influence`、`Param4`
- 左侧 `Details` 面板显示当前选中的命名重路由节点名称被写成 `Opacity No...`，但主图中黄色输出节点清楚显示结果名是 `Color Noise UV_1`

输出/预览：
- 左侧预览仍是一整块黑色圆盘，表示这一段是材质中的中间 UV/遮罩控制逻辑，本身并不直接生成最终可见颜色

从这张图可以明确本段的核心逻辑：先用两个 `Append` 组织 UV 坐标与滚动速度，经 `Panner` 推动噪声贴图采样，再将噪声红通道乘上 `Opacity Noise Influence` 与 Niagara `Dynamic Parameter.Noise Influence` 的乘积，最终输出为 `Color Noise UV_1`。这说明章节一开始就把噪声扰动暴露给 Niagara 系统控制，而不是把噪声强度写死在材质里

### 00:03:42-00:08:07 Color、Material、UV

- 本段定位：Color、Material、UV。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。；User Parameter 要保持命名和类型稳定，便于蓝图、材质或系统级控制复用。
- 知识点：本段围绕 `Color` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Color`、`Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Color`、`Noise` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Color`、`Add` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`Particle`、`Color`、`Alpha`、`Opacity`、`Material`、`Texture`、`User Parameter`、`Noise`。

**关键画面：**

这是 `M_Shockwave` 的更大范围材质图视图。左侧依旧是前一段建立的噪声 UV 控制网络，右侧已经把主材质输出节点一并放进画面，因此这张图的作用是确认“颜色建立”会接到哪些材质输出槽

可见节点定义集：
- 两个 `Append`
- 一个上游 `Multiply`
- `Panner`
- `Texture Sample`
- `T_Noise`
- 一个下游 `Multiply`
- 命名重路由输出 `Color Noise UV`
- 主材质输出节点

可见连线/结构：
- 左侧网络仍保持“`Append -> Multiply -> Panner -> Texture Sample -> Multiply -> Color Noise UV`”这一条主链
- 右侧主材质输出节点当前可见的关键输入槽包括：
  - `Emissive Color`
  - `Opacity`
  - `World Position Offset`
  - 底部 `PixelNormalWS`
- 当前截图里还看不到从 `Color Noise UV` 直接连到这些输出槽的线，说明这一帧更多是在组织布局并准备进入颜色部分，而不是已经完整接好最终输出

左侧 `Details` 面板可见材质级属性：
- `Material Domain = Surface`
- `Blend Mode = Translucent`
- `Shading Model = Unlit`
- `Two Sided` 未启用
- `Use Material Attributes` 未启用
- `Cast Ray Traced Shadows` 已启用
- `Lighting Mode = Volumetric NonDirectional`
- `Directional Lighting Intensity = 1.0`

这张图能够确认本段材质是一个半透明、非受光照模型驱动的冲击波材质，后续颜色主要会走 `Emissive Color` 与 `Opacity` 路径，而不是依赖传统表面光照。字幕“Let’s create the color”也说明下一步将从现有噪声 UV 结果出发，真正构建颜色输出
这是 `M_Shockwave` 材质图里“创建颜色”的核心网络。当前画面已经不再只是处理噪声 UV，而是把颜色贴图、色差函数和一个向量参数组合起来，生成可调的颜色结果

可见节点定义集：
- `Color Noise UV`
- `Panner`
- `Add`
- `T_Color`
- `MF_ChromaticAbberation`
- `Desaturation`
- `Multiply`
- 向量参数 `Color Control`

可见连线集：
- `Color Noise UV` 输出连接到 `Add.A`
- `Panner` 输出连接到 `Add.B`
- `Add` 输出连接到 `MF_ChromaticAbberation.UV (V2)`
- `T_Color` 输出连接到 `MF_ChromaticAbberation.In (T2d)`
- `Color Control` 的蓝色输出 `Chroma` 连接到 `MF_ChromaticAbberation.Influence (S)`
- `MF_ChromaticAbberation.Result` 输出连接到 `Desaturation` 的颜色输入
- `Color Control` 的红色输出 `Desaturation` 连接到 `Desaturation.Fraction`
- `Desaturation` 输出连接到右侧 `Multiply.A`
- `Color Control` 的绿色输出 `Multiply` 连接到右侧 `Multiply.B`

设置/参数：
- 当前选中的参数节点是 `Color Control`
- 左侧 `Details` 可见：
  - `Parameter Name = Color Control`
  - `Desaturation = 0.0`
  - `Multiply = 1`
  - `Chroma = 0.0`
  - `A = 0.0`
- `Color Control` 节点本身把这些通道分别命名为：
  - `Desaturation`
  - `Multiply`
  - `Chroma`

输出/预览：
- 左侧预览仍然是一块黑色矩形，说明当前预览的是一个中间 `Multiply` 结果，还没有接入完整材质输出显示

从这张图可以确认本段的颜色控制方案：先用 `Color Noise UV + Panner` 生成动态采样坐标，再用 `T_Color` 输入到 `MF_ChromaticAbberation` 产生色差变化，之后由 `Color Control` 统一控制去饱和、亮度乘数和色差强度。字幕里提到“multiply needs a standard one”，也与这里 `Multiply` 默认值设为 `1` 完全对应
这张图继续停留在 `M_Shockwave` 材质图，但重点转到 `Dynamic Parameter` 的命名与 UV 偏移控制。左侧 `Details` 面板已经展开参数名数组，因此可以直接确认 Niagara 传入材质的参数语义，而不是只看未命名通道

可见节点定义集：
- `TexCoord[0]`
- `Add(1)`，`B = 1.0`
- `Dynamic Parameter`
- 上方仍可见一部分前一张图中的颜色控制网络，包括一个 `Append` 和 `Color Control` 参数节点的边缘

可见连线/结构：
- `TexCoord[0]` 输出连接到 `Add(1).A`
- `Dynamic Parameter` 当前放在下方准备参与这一段 UV 偏移逻辑，但本截图里还看不到它到 `Add(1)` 或上方网络的完整连线

`Dynamic Parameter` 可见命名与设置：
- `Parameter Index = 0`
- 左侧 `Details > Param Names` 明确显示：
  - `Index [0] = Offset`
  - `Index [1] = Param2`
  - `Index [2] = Noise Influence`
  - `Index [3] = Param4`
- 节点右侧对应输出名也显示为：
  - `Offset`
  - `Param2`
  - `Noise Influence`
  - `Param4`
- `Default Value` 通道值可见为：
  - `R = 0.0`
  - `G = 0.0`
  - `B = 0.0`
  - `A = 1.0`

从这张图可以确认本段最关键的一点：章节前面材质里提到的 UV 控制并不是写死值，而是通过 Niagara `Dynamic Parameter` 的第一个通道 `Offset` 进入材质，用于驱动坐标偏移；第三个通道 `Noise Influence` 则继续负责噪声强度控制。字幕里的 “Offset just like that” 与这里的参数命名完全一致，因此这是一个明确的跨 Niagara 到材质的参数约定证据

### 00:08:09-00:11:00 System、UV、Add

- 本段定位：System、UV、Add。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Particle` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Particle`、`Alpha`、`Opacity`、`Texture`、`Add`、`Panner`、`Emissive`、`材质`。

**关键画面：**

这张图位于 `M_Shockwave` 材质图中，当前在给纹理采样前的 UV 输入增加一段可由粒子系统驱动的偏移量。左侧预览窗口显示材质平面几乎全黑，说明此时主要在改 UV 偏移链，尚未得到稳定可视结果。

- 节点定义集：
  - `TexCoord[0]`
    - `Coordinate Index = 0`
    - 作为基础 UV 输入
  - `Constant`
    - 数值可见为 `0`
    - 输出接到 `Append` 的一个输入，用作补齐另一个 UV 分量
  - `Dynamic Parameter`
    - `Parameter Index = 0`
    - 参数名列表可见：
      - `Index [0] = Offset`
      - `Index [1] = Param2`
      - `Index [2] = Noise Influence`
      - `Index [3] = Param4`
    - 当前使用的是红色通道 `Offset`
  - `Append`
    - 用来把单通道动态参数和常量拼成二维偏移向量
  - `Add`
    - 节点标题显示 `Add`
    - `B` 端默认值可见为 `1.0`
    - 用于把基础 `TexCoord` 与偏移结果合成
- 连线集：
  - `TexCoord[0] -> Add.A`
  - `Constant(0) -> Append.A`
  - `Dynamic Parameter.Offset -> Append.B`
  - `Append -> Add` 的另一个输入端，用作 UV 偏移量
- 设置/参数：
  - 这一段的关键不是直接改颜色，而是先把 Niagara/粒子侧传来的 `Offset` 动态参数转成可参与 UV 计算的二维向量
  - 由于只有一个动态参数分量可见，作者用 `Append` 把它与常量 `0` 组合，表示只沿一个 UV 轴移动，另一个轴保持不变
- 输出/预览：
  - 左侧预览平面几乎是纯黑状态
  - 说明当前截图关注点是“UV 偏移如何接入材质”，不是最终颜色或亮度结果

按图复建时，可先取 `TexCoord[0]` 作为基础 UV，再把 `Dynamic Parameter` 的 `Offset` 与常量 `0` 经过 `Append` 组合成二维向量，最后用 `Add` 把这组偏移叠加回原始 UV，供后续纹理采样或遮罩计算继续使用。
这张图仍在 `M_Shockwave` 材质图中，作者把上一张的 UV 偏移结果正式接到了一个纹理采样器上，开始直接检查偏移后的采样结果。左侧预览平面已经出现从绿色到黄色、再到橙红的渐变，说明当前正在验证 UV 位移对颜色纹理的滚动/拉伸效果。

- 节点定义集：
  - `TexCoord[0]`
    - `Coordinate Index = 0`
  - `Constant`
    - 数值可见为 `0`
  - `Dynamic Parameter`
    - 红色通道为 `Offset`
    - 其余参数名仍可见 `Param2`、`Noise Influence`、`Param4`
  - `Append`
    - 把单通道偏移和常量补成二维 UV 偏移
  - `Add`
    - 蓝色高亮，当前正在预览这个节点的结果
    - 其输出作为纹理采样坐标
  - `Texture Sample / TextureSampleParameter2D`
    - 左侧详情面板显示为纹理采样表达式
    - 可见设置：
      - `MipValueMode = None (use computed mip level)`
      - `Sampler Source = From texture asset`
      - `Const Coordinate = 0`
      - `Const Mip Value = -1`
      - `Sampler Type = Color`
      - `Texture Base -> Param = None`
- 连线集：
  - `TexCoord[0] -> Add.A`
  - `Constant(0) -> Append`
  - `Dynamic Parameter.Offset -> Append`
  - `Append -> Add.B`
  - `Add -> Texture Sample.UVs`
- 设置/参数：
  - 这一帧的关键变化是：`Add` 的输出已经从“仅做 UV 计算”推进到“直接驱动采样器坐标”
  - 因为采样器类型是 `Color`，当前预览主要用于检查颜色带/渐变纹理在偏移后的移动和压缩情况
- 输出/预览：
  - 左侧预览平面出现大面积黄绿色到橙红色渐变
  - 说明材质已经不再是空白 UV 调试，而是进入“观察偏移后纹理外观”的阶段

按图复建时，可把 `Add` 的输出直接接到颜色纹理采样器的 `UVs` 输入，然后在材质预览中检查渐变纹理是否会随 `Offset` 参数产生预期的位移效果。
这张图是同一段 `00:08:09-00:11:00 System、UV、Add` 的场景验证结果。作者从材质图回到 Unreal 关卡，直接观察 `M_Shockwave` 应用到特效后的实际表现，用来确认前面加入的 UV 偏移和 `Add` 调整已经让冲击波/拖尾材质产生更明显的流动感。

- 场景对象：
  - 视口左侧有一个角色参考体
  - 中间有一个白色圆柱体作为受击/命中位置参考
  - 右侧 Outliner 中可见多个 `NS_MagicProjectiles...` Niagara 相关对象
  - 内容浏览器当前选中材质 `M_Shockwave`
- 可见效果：
  - 两条紫粉色能量带从左向右汇入圆柱前方的亮点区域
  - 能量带内部带有明亮的白紫色中心和较暗的紫色外缘，呈现明显的纹理流动与拉丝感
  - 地面和圆柱表面都被紫色自发光照亮，说明材质的发光输出已经参与整体视觉结果
- 与前两张的对应关系：
  - 前两张在材质图中做的是 UV 偏移和采样接线
  - 这一张确认这些改动已经作用到实际特效，体现为拖尾/冲击波纹理不再静止贴图，而是具有方向性流动和更强的亮部聚焦
- 结果定位：
  - 这一帧不是新增节点步骤，而是对 `M_Shockwave` 在系统中的最终外观做可视检查
  - 如果场景里没有出现这种沿运动方向被拉开的紫色能量带，通常需要回头检查 `Offset` 驱动、UV 偏移接线和材质发光强度

按图复建时，应在材质改完后回到 Niagara/关卡场景直接验证：特效主体应呈现沿运动方向展开的紫粉色流动带，中心更亮、边缘更暗，并且会对周围地面和模型产生明显的自发光观感。

### 00:11:03-00:14:18 UV、Multiply、Power

- 本段定位：UV、Multiply、Power。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Opacity`、`Texture`、`Multiply`、`Panner`、`Emissive`、`材质`、`纹理`。

**关键画面：**

这张图仍位于 `M_Shockwave` 材质图，但关注点已经从上一段的颜色流动转到透明遮罩纹理 `T_WaveMask`。当前是在把前面的 UV 偏移结果与一个名为 `Opacity Noise UV` 的附加偏移叠加后，送入遮罩采样器做预览。

- 节点定义集：
  - `TexCoord[0]`
    - `Coordinate Index = 0`
    - 作为基础 UV 来源
  - `Append`
    - 把前面的单通道偏移组合成二维 UV 偏移
  - `Add`（第 1 个）
    - 接收基础 `TexCoord` 与 `Append` 输出
    - 用于形成第一层 UV 位移
  - `Add`（第 2 个）
    - 把上一层 UV 结果继续与下方参数相加
  - 参数节点 `Opacity Noise UV`
    - 用作第二层附加 UV 扰动
  - `TextureSampleParameter2D`
    - 参数名可见为 `T_WaveMask`
    - 当前处于 `Previewing`
    - 可见设置：
      - `MipValueMode = None (use computed mip level)`
      - `Sampler Source = From texture asset`
      - `Const Coordinate = 0`
      - `Const Mip Value = -1`
- 连线集：
  - `TexCoord[0] -> Add(1)`
  - `Append -> Add(1)`
  - `Add(1) -> Add(2).A`
  - `Opacity Noise UV -> Add(2).B`
  - `Add(2) -> T_WaveMask.UVs`
- 设置/参数：
  - 这一帧的关键是“遮罩 UV 不是只用一层偏移”，而是在原始偏移基础上，再叠加一层独立的 `Opacity Noise UV`
  - 这样做的目的，是让后续透明遮罩边缘具备更强的破碎和不规则感，而不是均匀、静止的圆环
- 输出/预览：
  - 左侧预览窗口显示一个白底黑边、中心略暗的圆形冲击波遮罩
  - 外圈边缘有不规则毛边，说明这套 UV 处理已经作用到透明/明暗分布，而不是只影响颜色纹理

按图复建时，可把基础 `TexCoord` 与第一组偏移先做一次 `Add`，再额外叠加 `Opacity Noise UV`，最后把结果送进 `T_WaveMask` 的 `UVs` 输入，用于驱动冲击波遮罩的边缘噪声和透明变化。
这张图继续停留在 `M_Shockwave` 的遮罩采样链，但作者开始直接调 `Dynamic Parameter`，观察同一套 UV 组合在不同参数值下对 `T_WaveMask` 采样结果的影响。左侧预览已经变成一团更厚、更亮的白色能量块，边缘保留不规则噪声。

- 节点定义集：
  - `TexCoord[0]`
  - `Append`
  - `Add`（第 1 个）
  - `Add`（第 2 个）
  - 参数节点 `Opacity Noise UV`
  - `TextureSampleParameter2D`
    - 参数名：`T_WaveMask`
    - 当前仍在 `Previewing`
  - `Dynamic Parameter`
    - 当前被选中
    - 参数名列表可见：
      - `Offset`
      - `Param2`
      - `Noise Influence`
      - `Param4`
    - 面板可见默认值：
      - `R = 0.370286`
      - `G = 0.0`
      - `B = 0.260571`
      - `A = 1.0`
- 连线集：
  - 图中连线关系与上一张保持一致：
    - `TexCoord[0] + Append -> Add(1)`
    - `Add(1) + Opacity Noise UV -> Add(2)`
    - `Add(2) -> T_WaveMask.UVs`
- 设置/参数：
  - 这一帧的关键变化不是新增节点，而是通过 `Dynamic Parameter` 的默认值来试看遮罩 UV 取样范围和偏移量
  - 因为 `T_WaveMask` 仍在预览，所以能直接观察参数变化如何让遮罩从细边环状变成大面积亮核
- 输出/预览：
  - 左侧预览呈黑底白色冲击团，中心大面积发白，边缘仍有噪声破碎感
  - 说明当前遮罩已经不仅仅控制一个窄边，而是在为后续更厚、更强的冲击波不透明区做形状准备

按图复建时，可保持上一张的 UV 接线不变，优先调 `Dynamic Parameter` 中参与偏移/噪声控制的分量，直接观察 `T_WaveMask` 预览是否从细环过渡到更厚的白色主体，并保留边缘毛刺感。
这张图继续在 `M_Shockwave` 材质图中处理同一张遮罩，但重点已经从单纯 UV 扰动转到“怎样用 `Multiply`、`Power` 和 `Lerp` 重塑遮罩分布”。左侧预览显示一个中心挖空、外围发白的圆环形冲击波，边缘带不规则噪声。

- 节点定义集：
  - 参数节点 `Wave Mask Control`
    - 预览值为白色
    - 可见输出命名：
      - `Power`
      - `MultiplyPower`
      - `Multiply`
      - `Lerp`
  - `Multiply`（上方）
    - 接收来自上游遮罩/指数链和控制参数的输入
  - `Multiply`（中间）
    - 继续对遮罩结果做强度或范围缩放
  - `Lerp`
    - 当前处于 `Previewing`
    - 输入端为 `A`、`B`、`Alpha`
    - 左侧详情面板可见默认常量：
      - `Const A = 0.0`
      - `Const B = 1.0`
      - `Const Alpha = 0.5`
  - 上游还可见一个 `Exp` 节点标题，说明这段链路里已有指数型处理参与遮罩分布塑形
- 连线集：
  - `Wave Mask Control` 的多路输出分别送入两个 `Multiply` 节点
  - 两个 `Multiply` 的结果再汇入 `Lerp`
  - `Wave Mask Control` 还有一路直接连到 `Lerp.Alpha`
- 设置/参数：
  - 这一帧的核心不是新增纹理，而是通过一组可调控制量，把同一张 `WaveMask` 的明暗分布做指数强化、范围乘算和插值混合
  - `Lerp` 的存在说明作者在两种遮罩结果之间做混合，而不是只用单一路径硬裁切
- 输出/预览：
  - 左侧预览呈现中心黑洞、外围大面积白色的圆环状冲击波
  - 外圈边缘依旧保留粗糙噪声，说明 `Multiply/Power` 调整后没有把原本的破碎感抹平

按图复建时，可把 `Wave Mask Control` 暴露成一组材质参数，用 `Multiply` 和可能的 `Exp/Power` 调整遮罩强弱，再用 `Lerp` 在两种遮罩形态之间混合，目标是得到中心空、外圈亮、边缘粗糙的冲击波环。

### 00:14:22-00:17:31 Multiply、Add、Power

- 本段定位：Multiply、Add、Power。
- 知识点：本段围绕 `Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。；User Parameter 要保持命名和类型稳定，便于蓝图、材质或系统级控制复用。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Alpha`、`Opacity`、`Texture`、`User Parameter`、`Multiply`、`Add`、`Panner`、`Emissive`。

**关键画面：**

这张图仍在 `M_Shockwave` 材质图中，继续细调上一段的 `Wave Mask Control`。当前重点是直接提高 `Power`，让冲击波遮罩从柔和过渡变成更硬、更亮的环状分布。

- 节点定义集：
  - `T_WaveMask`
    - 当前作为上游遮罩采样来源
  - `Add`
    - 位于 `T_WaveMask` 左侧，继续提供遮罩 UV 输入
  - `Power`
    - 当前处于 `Previewing`
    - `Base` 接来自 `T_WaveMask`
    - `Exp` 接来自控制参数
  - `Multiply`（上）
  - `Multiply`（下）
  - `Lerp`
  - 向量参数 `Wave Mask Control`
    - 当前被选中
    - 可见通道命名：
      - `Power`
      - `MultiplyPower`
      - `Multiply`
      - `Lerp`
    - 当前可见默认值：
      - `Power = 5`
      - `MultiplyPower = 25.0`
      - `Multiply = 1.0`
      - `Lerp = 0.5`
- 连线集：
  - `T_WaveMask -> Power.Base`
  - `Wave Mask Control.Power -> Power.Exp`
  - `Power` 输出与其他控制参数一起送入两个 `Multiply`
  - 两个 `Multiply` 结果继续汇入 `Lerp`
- 设置/参数：
  - 这一帧的关键动作是把 `Power` 调高到 `5`
  - 同时 `MultiplyPower = 25.0`、`Multiply = 1.0`、`Lerp = 0.5` 保持作为当前组合值
  - 说明作者在用“指数强化 + 乘法放大 + 线性混合”三步法压缩中间灰度，让遮罩边缘更锐利
- 输出/预览：
  - 左侧预览是黑底亮白圆环，中心基本纯黑
  - 环带比上一段更集中、更高对比，边缘仍保留粗糙噪声

按图复建时，可先保持前一段的 `Power/Multiply/Lerp` 结构不变，把 `Wave Mask Control.Power` 提到 `5` 左右，再观察 `Power` 预览是否得到中心更空、亮环更集中的冲击波遮罩。
这张图还是 `M_Shockwave` 中同一组 `Wave Mask Control` 链路，但作者把前面强化过的参数重新拉回基础值，用来建立一个更中性的默认模板。左侧预览中的亮环明显缩小，整体分布比上一张更均匀、更“标准化”。

- 节点定义集：
  - `TexCoord[0]`
  - `Dynamic Parameter`
    - 可见输出仍包括 `Offset`、`Param2`、`Noise Influence`、`Param4`
  - `Append`
  - `Add`（两级 UV 偏移）
  - 参数节点 `Opacity Noise UV`
  - `T_WaveMask`
  - `Power`
  - `Multiply`（上）
  - `Multiply`（下）
  - `Lerp`
  - 向量参数 `Wave Mask Control`
    - 当前被选中
    - 可见默认值：
      - `Power = 1.0`
      - `MultiplyPower = 1.0`
      - `Multiply = 1.0`
      - `Lerp = 0.5`
- 连线集：
  - 整体连线未变：
    - `TexCoord[0] + Dynamic Parameter/Append + Opacity Noise UV -> T_WaveMask.UVs`
    - `T_WaveMask -> Power -> Multiply -> Lerp`
    - `Wave Mask Control` 四个分量分别驱动 `Power`、两个 `Multiply` 和 `Lerp`
- 设置/参数：
  - 这一帧的关键不是新结构，而是把控制参数恢复到“标准值”：
    - 指数强化从 `5` 回到 `1`
    - 乘法放大也回到 `1`
    - `Lerp` 仍保持 `0.5`
  - 这说明作者希望先得到一套可复用的默认环形遮罩，再按需要继续加强
- 输出/预览：
  - 左侧预览变成更小、更柔和的黑心白环
  - 说明当 `Power/Multiply` 不再强行拉高时，遮罩会回到相对自然、过渡更平稳的基础形态

按图复建时，可先把 `Wave Mask Control` 四个分量都归到 `1 / 1 / 1 / 0.5` 这一类中性值，确认遮罩能稳定输出一圈基础白环，再根据镜头需要额外提高 `Power` 或 `MultiplyPower`。
这张图仍在 `M_Shockwave` 材质图，但镜头回到更上游的 UV 组织阶段。作者通过一个二维常量先把 `TexCoord` 做非等比拉伸，再叠加动态偏移和 `Opacity Noise UV`，让 `T_WaveMask` 的原始采样形态就具备更强的旋涡感和破碎感。

- 节点定义集：
  - `TexCoord[0]`
    - `Coordinate Index = 0`
  - `Constant2Vector`
    - 当前被选中
    - 可见数值：
      - `X = 15.0`
      - `Y = 1.0`
  - `Multiply`
    - 用于把基础 `TexCoord` 与 `Constant2Vector` 做分量缩放
  - `Constant`
    - 数值为 `0.0`
  - `Dynamic Parameter`
    - 当前可见仍包含 `Offset`、`Param2`、`Noise Influence`、`Param4`
  - `Append`
    - 把动态参数与常量拼成二维偏移
  - `Add`（第 1 个）
    - 接收 `Multiply` 结果与 `Append`
  - 参数节点 `Opacity Noise UV`
  - `Add`（第 2 个）
    - 继续叠加 `Opacity Noise UV`
  - `T_WaveMask`
    - 由两级 `Add` 的结果驱动 `UVs`
  - 下游仍可见 `Power` 与 `Wave Mask Control`
- 连线集：
  - `TexCoord[0] -> Multiply.A`
  - `Constant2Vector(15,1) -> Multiply.B`
  - `Constant(0) -> Append`
  - `Dynamic Parameter.Offset -> Append`
  - `Multiply -> Add(1).A`
  - `Append -> Add(1).B`
  - `Add(1) -> Add(2).A`
  - `Opacity Noise UV -> Add(2).B`
  - `Add(2) -> T_WaveMask.UVs`
- 设置/参数：
  - 关键变化是用 `Constant2Vector (15, 1)` 先把 UV 沿一个方向大幅拉伸
  - 这样同一张遮罩贴图在采样时就不再是均匀圆形噪声，而会形成更长、更偏向单方向的纹理结构
  - 之后再叠加 `Offset` 和 `Opacity Noise UV`，把规整拉伸进一步打散
- 输出/预览：
  - 左侧预览不再是单纯干净圆环，而是一个白灰旋涡状冲击团，外圈边缘破碎明显
  - 说明当前调的不是最终发光强度，而是决定遮罩基础纹理走向和拉伸感的 UV 源结构

按图复建时，可先用 `TexCoord * float2(15, 1)` 拉伸基础 UV，再叠加 `Offset` 和 `Opacity Noise UV`，最后送入 `T_WaveMask`。这样能先在采样阶段得到带方向性和破碎感的基础冲击波纹理，再交给后续 `Power/Multiply` 做强度塑形。

### 00:17:33-00:20:50 Material、Multiply、Add

- 本段定位：Material、Multiply、Add。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：参考素材应按效果类型、颜色、运动方式和用途打标签，便于后续复现 VFX 风格。
- 知识点：本段围绕 `Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Opacity`、`Material`、`Texture`、`Multiply`、`Add`、`Panner`、`Emissive`。

**关键画面：**

这张图仍位于 `M_Shockwave` 材质图中，继续调整 `T_WaveMask` 的上游 UV 生成链。和上一批相比，作者把基础 UV 的横向拉伸从更大的比例收回到中等比例，同时把动态偏移加大，让遮罩呈现更厚重的旋涡云团，而不是过度拉长的条带感。

- 节点定义集：
  - `TexCoord[0]`
    - `Coordinate Index = 0`
  - `Constant2Vector`
    - 可见数值：
      - `X = 5.0`
      - `Y = 1.0`
  - `Multiply`
    - 用于 `TexCoord * float2(5,1)`
  - `Constant`
    - 数值 `0.0`
  - `Dynamic Parameter`
    - 当前被选中
    - 参数名列表可见：
      - `Offset`
      - `Param2`
      - `Noise Influence`
      - `Param4`
    - 面板可见默认值：
      - `R = 3.825321`
      - `G = 0.0`
      - `B = 1.0`
      - `A = 1.0`
  - `Append`
    - 由动态参数与常量组成二维偏移
  - `Add`（第 1 个）
    - 把 `Multiply` 结果与 `Append` 相加
  - 参数节点 `Opacity Noise UV`
  - `Add`（第 2 个）
    - 继续叠加 `Opacity Noise UV`
  - `T_WaveMask`
  - 下游仍可见 `Power`、`Multiply`、`Wave Mask Control`
- 连线集：
  - `TexCoord[0] -> Multiply.A`
  - `Constant2Vector(5,1) -> Multiply.B`
  - `Dynamic Parameter.Offset + Constant(0) -> Append`
  - `Multiply -> Add(1)`
  - `Append -> Add(1)`
  - `Add(1) + Opacity Noise UV -> Add(2)`
  - `Add(2) -> T_WaveMask.UVs`
- 设置/参数：
  - 当前截图可确认两个关键调整：
    - UV 预拉伸改为 `float2(5,1)`，比上一组更克制
    - `Dynamic Parameter` 的偏移分量明显加大，特别是红色通道接近 `3.825321`
  - 这代表作者不再主要依赖极端拉伸，而是改用更强的偏移和噪声来制造内部流动感
- 输出/预览：
  - 左侧预览是大面积灰白旋涡状冲击团，中心仍保留破洞，外围有浓重的烟状纹理
  - 相比单纯白环，这一版更像厚重的体积云或能量漩涡底图

按图复建时，可先把基础 UV 拉伸控制在 `float2(5,1)` 这类中等比例，再提高 `Offset` 参数幅度，并继续叠加 `Opacity Noise UV`，让 `WaveMask` 的采样结果先形成厚重、旋涡化的底层纹理。
这张图仍在 `M_Shockwave` 材质图中，但重点已经从单纯生成 `T_WaveMask` 的 UV，推进到把这份结果送入一个材质函数 `MF_TextureCrop` 做区域裁切。左侧预览显示大白圆盘中只剩中心一块黑色区域，说明当前在测试“只保留某一块遮罩区域”的效果。

- 节点定义集：
  - `TexCoord[0]`
  - `Constant2Vector`
    - 数值仍为 `X = 5.0`、`Y = 1.0`
  - `Multiply`
  - `Constant`
    - 数值 `0.0`
  - `Dynamic Parameter`
    - 当前可见通道仍为 `Offset`、`Param2`、`Noise Influence`、`Param4`
  - `Append`
  - `Add`（第 1 个）
  - 参数节点 `Opacity Noise UV`
  - `Add`（第 2 个）
  - `T_WaveMask`
  - `Constant2Vector`
    - 右上新增输入，数值为 `X = 0.0`、`Y = 1.0`
  - 材质函数 `MF_TextureCrop`
    - 当前处于 `Previewing`
    - 可见输入：
      - `Clamp (V2)`
      - `UV (V2)`
    - 可见输出：
      - `Result`
- 连线集：
  - `TexCoord[0] -> Multiply.A`
  - `float2(5,1) -> Multiply.B`
  - `Dynamic Parameter.Offset + Constant(0) -> Append`
  - `Multiply + Append -> Add(1)`
  - `Add(1) + Opacity Noise UV -> Add(2)`
  - `Add(2) -> T_WaveMask.UVs`
  - `float2(0,1) -> MF_TextureCrop.Clamp`
  - `T_WaveMask` 的输出继续连到 `MF_TextureCrop` 的另一个输入路径
- 设置/参数：
  - 这一帧新增的关键结构是 `MF_TextureCrop`
  - `float2(0,1)` 作为裁切/夹取范围输入，说明作者开始限制遮罩的可用区域，而不是整张纹理全量参与后续混合
  - 左侧细节面板还能确认当前材质设置：
    - `Material Domain = Surface`
    - `Blend Mode = Translucent`
    - `Shading Model = Unlit`
- 输出/预览：
  - 左侧预览几乎是纯白圆盘，中间保留一块不规则黑斑
  - 说明当前材质函数更像是在“切出一块遮罩区域”而不是直接呈现最终冲击波完整形状

按图复建时，可在 `T_WaveMask` 采样之后插入 `MF_TextureCrop` 一类的区域裁切函数，并提供一组 `float2` 裁切参数，例如图中的 `float2(0,1)`，用来限制遮罩参与后续混合的范围。
这张图仍然停在 `M_Shockwave` 的 `T_WaveMask` UV 生成链上，但作者把基础横向拉伸进一步提高到极强比例，用来观察遮罩纹理在极端拉伸下形成的放射状细丝结构。左侧预览已经不再是普通圆环，而是大面积白色放射纹理团。

- 节点定义集：
  - `TexCoord[0]`
    - `Coordinate Index = 0`
  - `Constant2Vector`
    - 当前可见数值：
      - `X = 25.0`
      - `Y = 1.0`
  - `Multiply`
    - 用于执行 `TexCoord * float2(25,1)`
  - `Constant`
    - 数值 `0.0`
  - `Dynamic Parameter`
    - 仍提供 `Offset`、`Param2`、`Noise Influence`、`Param4`
  - `Append`
  - `Add`（第 1 个）
  - 参数节点 `Opacity Noise UV`
  - `Add`（第 2 个）
  - `T_WaveMask`
    - 当前被选中
    - 详情面板可见：
      - `Sampler Source = Shared: Wrap`
      - `Const Coordinate = 0`
      - `Const Mip Value = -1`
  - 右上仍保留 `Constant2Vector(0,1)`，延续上一张用于裁切/辅助输入的结构
- 连线集：
  - `TexCoord[0] -> Multiply.A`
  - `float2(25,1) -> Multiply.B`
  - `Dynamic Parameter.Offset + Constant(0) -> Append`
  - `Multiply + Append -> Add(1)`
  - `Add(1) + Opacity Noise UV -> Add(2)`
  - `Add(2) -> T_WaveMask.UVs`
- 设置/参数：
  - 这一帧的关键变化是把横向拉伸从中等值继续加大到 `25`
  - 作者显然是在测试：当 UV 被极端压缩/拉伸后，同一张遮罩纹理是否能转化成更密的放射状条纹，而不是只有块状噪声
  - `Sampler Source = Shared: Wrap` 也说明当前采样希望允许纹理在大范围 UV 偏移/重复下继续平铺
- 输出/预览：
  - 左侧预览是一团白色放射状纹理，中心略暗，边缘被不规则裁掉
  - 说明该结构更适合拿来做高速冲击、能量喷薄或径向拉丝感的底层遮罩，而不是柔和均匀的圆盘

按图复建时，可在需要更强径向拉丝感时，把基础 UV 拉伸提高到 `float2(25,1)` 这类极端值，并保持后续 `Offset` 与 `Opacity Noise UV` 的叠加。这样 `T_WaveMask` 的采样结果会从普通块状噪声转成放射状细丝底图。

### 00:20:55-00:23:47 Color、Multiply、Add

- 本段定位：Color、Multiply、Add。
- 知识点：User Parameter 要保持命名和类型稳定，便于蓝图、材质或系统级控制复用。
- 知识点：本段围绕 `Color` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Color`、`Alpha`、`Opacity`、`Texture`、`User Parameter`、`Multiply`、`Add`、`Panner`。

**关键画面：**

这张图位于 `M_Shockwave` 材质图的 `Color、Multiply、Add` 段，但当前调整的核心仍是 `T_WaveMask` 采样器本身。作者把采样底图切换成渐变类纹理后，继续沿用前面的 `Offset + Opacity Noise UV + TextureCrop` 链，得到一个黑心、白边、带旋涡感的遮罩结果。

- 节点定义集：
  - `TexCoord[0]`
    - 直接送入第一层 `Add`
  - `Constant`
    - 数值 `0.0`
  - `Dynamic Parameter`
    - 可见通道：
      - `Offset`
      - `Param2`
      - `Noise Influence`
      - `Param4`
  - `Append`
    - 用于把 `Offset` 与常量拼成二维偏移
  - `Add`（第 1 个）
    - 把基础 `TexCoord` 与 `Append` 偏移相加
  - 参数节点 `Opacity Noise UV`
  - `Add`（第 2 个）
    - 继续叠加 `Opacity Noise UV`
  - `T_WaveMask`
    - 当前被选中并处于 `Previewing`
    - 详情面板可见：
      - `Sampler Source = Shared: Wrap`
      - `Const Coordinate = 0`
      - `Const Mip Value = -1`
      - `Texture Base = T_Gradient20`
      - `Sampler Type = Color`
  - `Constant2Vector(0,1)`
    - 继续提供给右上角的 `MF_TextureCrop`
  - `MF_TextureCrop`
    - 仍接在后方做区域裁切
- 连线集：
  - `Dynamic Parameter.Offset + Constant(0) -> Append`
  - `TexCoord[0] + Append -> Add(1)`
  - `Add(1) + Opacity Noise UV -> Add(2)`
  - `Add(2) -> T_WaveMask.UVs`
  - `T_WaveMask` 输出继续进入 `MF_TextureCrop`
  - `float2(0,1) -> MF_TextureCrop.Clamp`
- 设置/参数：
  - 这一帧最关键的变化不是改连线，而是把 `T_WaveMask` 的底图切到 `T_Gradient20`
  - 因为采样器类型仍为 `Color`，所以渐变贴图在偏移、噪声和裁切后，会直接决定后续颜色/明暗分布的总体轮廓
- 输出/预览：
  - 左侧预览为黑色中心、外圈白灰旋涡包裹的圆盘
  - 与前一段使用高拉伸噪声纹理时的放射感不同，这里更像“渐变被扭曲和卷吸”后的漩涡遮罩

按图复建时，可在 `T_WaveMask` 采样器里尝试替换为类似 `T_Gradient20` 的渐变贴图，再复用已有的 `Offset`、`Opacity Noise UV` 和 `TextureCrop` 结构，让基础遮罩从噪声条纹转成更适合颜色分层的渐变漩涡底图。
这张图是 `M_Shockwave` 材质图的远景总览截图，节点区域被缩得很小，无法可靠辨认每个节点名称和完整连线，因此不适合编造具体节点链。当前只能确认以下信息：

- 已确认信息：
  - 画面仍位于 `M_Shockwave > Material Graph`
  - 当前预览的是一个 `Add` 节点，左侧详情面板显示：
    - `Material Expression Add`
    - `Const A = 0.0`
    - `Const B = 1.0`
  - 左侧预览窗口几乎是纯黑圆盘，说明当前被预览的结果更接近遮罩/中间混合值，而不是最终发光颜色
  - 中间图面能看出材质图被分成上下两块较大的节点组，右侧还有一条纵向节点列，说明作者正在从整体层面整理多个子链之间的关系，而不是只调单一纹理采样器
  - 底部字幕明确提到 `Mask`，可以确认这一帧与遮罩整理有关
- 不确定点：
  - 各子图中具体节点名称、连接方向、输入输出含义在当前缩放下无法可靠辨认
  - 右侧纵向节点列的节点类型和最终输出口都看不清
  - 无法确认本帧是否在做颜色混合、透明遮罩混合，还是将多个中间结果汇总到最终材质输出

按图复建时，应回到更近的局部截图或实际材质图，优先核对这几组子图的真实节点名和输出去向；当前这张图只能作为“本段开始整理整体 Mask 结构”的定位证据。
这张图是 `Color、Multiply、Add` 段的收尾过渡帧。作者把画面切到材质主输出区域，准备把前面已经做好的遮罩/纹理结果接入最终材质输出，并开始搜索下一步要添加的节点。底部字幕明确提到“带上我们的多彩纹理”，说明这一帧的目标是从纯遮罩过渡到真正带颜色的材质输出。

- 当前可见节点/界面：
  - 左侧正在 `Previewing MaterialExpressionTextureSampleParameter2D_1`
  - 预览结果是一个中心黑、外圈白的平滑圆环遮罩
  - 中间打开了右键搜索菜单，能看到分类列表：
    - `Named Reroutes`
    - `Atmosphere`
    - `Blends`
    - `Chromakeying`
    - `Color`
    - `Constants`
    - `Coordinates`
    - `Cubemaps`
    - `Custom`
    - `Debug`
    - 以及其他材质节点分类
  - 右侧是材质输出节点 `M_Shockwave`
    - 可见输入口包括：
      - `Emissive Color`
      - `Opacity`
      - `World Position Offset`
    - `Opacity` 当前显示默认值 `1.0`
- 已确认设置：
  - 左侧详情面板仍可见当前材质属性：
    - `Material Domain = Surface`
    - `Blend Mode = Translucent`
    - `Shading Model = Unlit`
- 结构含义：
  - 前面几张图主要在做 `T_WaveMask` 的遮罩与 UV 组织
  - 这一帧说明作者已经完成一版基础遮罩，接下来要把它与“彩色纹理”结合，并送向 `Emissive Color` 或 `Opacity` 等正式输出口
  - 由于搜索菜单尚未选定具体节点，所以不能可靠判断下一步一定是 `Texture Sample`、`Multiply` 还是颜色参数节点
- 输出/预览：
  - 当前预览仍是平滑白环遮罩
  - 说明彩色部分还未真正接入主输出，当前只是进入“把遮罩结果并入最终材质”的准备阶段

按图复建时，可先保留这张图里已得到的平滑白环遮罩结果，再回到材质主输出区域，将后续颜色纹理或颜色参数与该遮罩做乘法/混合，然后接入 `Emissive Color` 与需要的 `Opacity` 通道。

### 00:23:50-00:27:13 System、Color、Bounds

- 本段定位：System、Color、Bounds。
- 知识点：本段围绕 `Particle`、`Color`、`Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Opacity` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Bounds`、`Lerp`、`Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Color`、`Depth Fade` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Dynamic Parameter`、`Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Color`、`Noise` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Particle`、`Color`、`Alpha`、`Opacity`、`Material`、`Dynamic Parameter`、`Noise`、`Bounds`。

**关键画面：**

这张图位于 `M_Shockwave` 材质图靠近主输出的区域，开始把粒子颜色控制接入最终材质。当前可确认的结构是：先把一张颜色纹理与基础透明度做乘法，再准备把 `Particle Color` 叠加到主输出链上。

- 节点定义集：
  - `Color Texture`
    - 作为颜色贴图输入
  - `Base Opacity`
    - 紫色参数节点，作为基础透明度/强度控制
  - `Multiply`
    - 接收 `Color Texture` 与 `Base Opacity`
  - `Multiply(1)`
    - 第二个乘法节点
    - `B` 端默认值可见为 `1.0`
  - `Particle Color`
    - 当前被选中
    - 可见输出：
      - `RGB`
      - `R`
      - `G`
      - `B`
      - `A`
      - `RGBA`
  - 材质输出节点 `M_Shockwave`
    - 可见输入口：
      - `Emissive Color`
      - `Opacity`
      - `World Position Offset`
    - `Opacity` 当前显示默认值 `1.0`
- 连线集：
  - `Color Texture -> Multiply.A`
  - `Base Opacity -> Multiply.B`
  - `Multiply -> Multiply(1).A`
  - `Multiply(1)` 位于通往材质输出的路径上
  - `Particle Color` 已放置在旁边，准备参与主输出链，但当前截图里还未看到明确接线完成
- 结构含义：
  - 这一帧说明作者已经从“遮罩塑形”进入“粒子实例颜色与材质颜色叠加”的阶段
  - `Color Texture * Base Opacity` 先形成一份带基础亮度/透明控制的颜色结果
  - `Particle Color` 的出现意味着后续会让 Niagara 粒子颜色参与调色，而不是材质颜色完全固定
- 输出/预览：
  - 左侧仍在预览一个 `TextureSampleParameter2D` 结果，显示为中心黑、外圈白的平滑圆环
  - 说明当前画面主要是在整理主输出附近的颜色节点，预览窗口还未切到最终彩色发光结果

按图复建时，可先把 `Color Texture` 与 `Base Opacity` 相乘，再预留一个与 `Particle Color` 做乘法或混合的位置，把 Niagara 粒子侧的颜色控制引入 `Emissive Color` 主链。
这张图继续停在 `M_Shockwave` 主输出附近，但关注点已经转到透明度链。底部字幕明确说明“在透明度方面，把它乘以动态参数”，而图中也能看到 `Saturate`、多个 `Multiply` 和 `Depth Fade` 一起作用到材质输出。

- 节点定义集：
  - `Saturate`
    - 位于透明度链左侧中段
  - `Multiply`（下方，当前高亮）
    - 接收 `Saturate` 的输出
    - 另一输入来自下方一个未完整显示的参数/输入节点
  - `Multiply`（中上）
    - 接收上方颜色/粒子相关结果与下方乘法链结果
  - `Depth Fade`
    - 材质节点，输入端可见：
      - `Opacity`
      - `FadeDistance`
  - 参数节点 `Depth Fade`
    - 绿色参数节点
    - `Default Value = 100.0`
  - 材质输出节点 `M_Shockwave`
    - 当前可见 `Emissive Color`、`Opacity`、`World Position Offset`
- 连线集：
  - `Saturate -> Multiply(下方)`
  - `Multiply(下方) -> Multiply(中上)` 的一个输入
  - 上方颜色/粒子结果 -> `Multiply(中上)` 的另一个输入
  - `Multiply(中上) -> Depth Fade.Opacity`
  - 参数 `Depth Fade(100)` -> `Depth Fade.FadeDistance`
  - `Depth Fade` 输出接回材质主输出区域，并参与 `Opacity`
- 设置/参数：
  - 当前唯一可明确读出的参数值是 `Depth Fade = 100.0`
  - 结合字幕，可确认透明度不是固定值，而是先经过 `Multiply`，再叠加 `Depth Fade`，这样既能受动态参数控制，又能在与场景表面接近时做柔和衰减
- 输出/预览：
  - 左侧预览是一个浅绿色半透明环状效果，边缘有轻微噪声和模糊衰减
  - 说明这一步已经不只是黑白遮罩，而是把颜色和透明度一起带到更接近最终效果的材质预览中

按图复建时，可先把透明度遮罩经 `Saturate` 限幅，再与动态参数或额外强度控制做 `Multiply`，最后送入 `Depth Fade`，用如图的 `FadeDistance = 100` 左右的参数处理与场景表面的过渡，并把结果接入 `Opacity`。
这张图完整展示了 `M_Shockwave` 中的 `Color Texture` 子图。作者把颜色贴图的 UV 缩放、滚动、噪声扰动、色散和反饱和控制组织成一条独立处理链，再输出到一个名为 `Color Texture` 的结果节点。

- 节点定义集：
  - 向量参数 `Color Texture(Scale/Scroll)`
    - 当前被选中
    - 参数名：`Color Texture(Scale/Scroll)`
    - 可见默认值：
      - `R = 1.0`
      - `G = 1.0`
      - `B = 0.0`
      - `A = 0.0`
    - `Group = Color Noise`
  - `Append`（上）
    - 用于从参数中拼出一组 UV 缩放量
  - `Append`（下）
    - 用于从参数中拼出一组滚动速度或偏移量
  - `TexCoord[0]`
    - `Coordinate Index = 0`
  - `Multiply`
    - 用于 `TexCoord * Scale`
  - `Panner`
    - 用于滚动 UV
  - 参数节点 `Color Noise UV`
  - `Add`
    - 把 `Panner` 结果与 `Color Noise UV` 叠加
  - `T_Color`
    - 颜色贴图采样器
  - 材质函数 `MF_ChromaticAberration`
    - 可见输入：
      - `In (T2d)`
      - `UV (V2)`
      - `Influence (S)`
    - 输出：
      - `Result`
  - 向量参数 `Color Control`
    - 预览值为亮绿色
    - 可见通道命名：
      - `Desaturation`
      - `Multiply`
      - `Chroma`
  - `Desaturation`
    - 接收色散后的颜色结果
    - `Fraction` 由 `Color Control.Desaturation` 驱动
  - `Multiply`
    - 最后把颜色结果与强度控制相乘
  - 结果节点 `Color Texture`
- 连线集：
  - `Color Texture(Scale/Scroll) -> Append(上) -> Multiply.B`
  - `TexCoord[0] -> Multiply.A`
  - `Color Texture(Scale/Scroll) -> Append(下) -> Panner.Speed`
  - `Multiply -> Panner.Coordinate`
  - `Panner + Color Noise UV -> Add`
  - `T_Color -> MF_ChromaticAberration.In`
  - `Add -> MF_ChromaticAberration.UV`
  - `Color Control.Chroma -> MF_ChromaticAberration.Influence`
  - `MF_ChromaticAberration.Result -> Desaturation`
  - `Color Control.Desaturation -> Desaturation.Fraction`
  - `Desaturation -> Multiply`
  - `Color Control.Multiply -> Multiply`
  - `Multiply -> Color Texture`
- 设置/参数：
  - 这条链把颜色处理拆成四个独立控制维度：
    - `Scale/Scroll`：控制贴图缩放与滚动
    - `Color Noise UV`：控制额外噪声扰动
    - `Chroma`：控制色散强度
    - `Desaturation / Multiply`：控制去饱和和最终亮度
  - 这种组织方式说明作者希望把颜色纹理做成可参数化、可实例化的模块，而不是写死在单张贴图上
- 输出/预览：
  - 左侧预览是一个偏绿色的半透明能量环
  - 说明这条颜色链已经不是单纯遮罩，而是能直接生成接近最终效果的色彩与亮度分布

按图复建时，可先建立一条独立的 `Color Texture` 子图：`TexCoord -> Scale -> Panner -> Noise Add -> Texture Sample -> Chromatic Aberration -> Desaturation -> Multiply`，并把缩放滚动、色散强度、去饱和和亮度都暴露成参数，便于 Niagara 实例侧统一调色。

### 00:27:30-00:30:31 Color、Alpha、Material

- 本段定位：Color、Alpha、Material。
- 知识点：本段围绕 `Opacity`、`Noise` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Opacity` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：User Parameter 要保持命名和类型稳定，便于蓝图、材质或系统级控制复用。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Noise`、`Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Noise` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Color`、`Alpha`、`Opacity`、`Material`、`User Parameter`、`Noise`、`Depth Fade`、`Add`。

**关键画面：**

这张图完整展示了 `M_Shockwave` 中的 `Opacity Noise UV` 子图。作者把一张噪声贴图做缩放、滚动，再叠加密度与动态参数调制，最后输出为 `Opacity Noise UV`，用于后续透明度遮罩的扰动输入。

- 节点定义集：
  - 向量参数 `Opacity Noise(Scale/Scroll)`
    - 当前被选中
    - 参数名：`Opacity Noise(Scale/Scroll)`
    - 面板里可见分组下拉项包含：
      - `Color Noise`
      - `Opacity Mask`
      - `Opacity Noise`
    - 当前用于控制噪声缩放与滚动
  - `TexCoord[0]`
    - `Coordinate Index = 0`
  - `Append`（上）
    - 从参数中拼出 UV 缩放量
  - `Append`（下）
    - 从参数中拼出滚动速度
  - `Multiply`
    - 负责 `TexCoord * Scale`
  - `Panner`
    - 负责让噪声在时间上滚动
  - `Texture Sample`
    - 中上采样节点，用于主噪声采样
  - `T_Noise`
    - 下方贴图对象采样器，作为噪声纹理源
    - 当前被选中，面板可见：
      - `Texture = DefaultTexture`
      - `Sampler Type = Color`
  - 标量参数 `Density Noise Influence`
    - `Default Value = 1.0`
  - `Dynamic Parameter`
    - 可见通道命名：
      - `Offset`
      - `Refraction`
      - `Noise Influence`
      - `Param4`
  - `Multiply`（下）
    - 用于组合 `Density Noise Influence` 与 `Dynamic Parameter.Noise Influence`
  - `Multiply`（右）
    - 用于把主噪声结果乘上影响强度
  - 结果节点 `Opacity Noise UV`
- 连线集：
  - `Opacity Noise(Scale/Scroll) -> Append(上) -> Multiply.B`
  - `TexCoord[0] -> Multiply.A`
  - `Opacity Noise(Scale/Scroll) -> Append(下) -> Panner.Speed`
  - `Multiply -> Panner.Coordinate`
  - `T_Noise -> Texture Sample.Tex`
  - `Panner -> Texture Sample.UVs`
  - `Density Noise Influence -> Multiply(下).A`
  - `Dynamic Parameter.Noise Influence -> Multiply(下).B`
  - `Texture Sample -> Multiply(右).A`
  - `Multiply(下) -> Multiply(右).B`
  - `Multiply(右) -> Opacity Noise UV`
- 设置/参数：
  - 这条链把透明度噪声拆成三层控制：
    - `Scale/Scroll`：控制噪声图案缩放和滚动
    - `Density Noise Influence`：控制基础权重
    - `Dynamic Parameter.Noise Influence`：让 Niagara 粒子实例动态驱动噪声强度
- 输出/预览：
  - 左侧预览依然是浅绿色半透明能量环，说明这份 `Opacity Noise UV` 会进一步作用到最终透明度结果
  - 当前截图的重点不是最终环形造型，而是透明度噪声的内部来源和可调参数

按图复建时，可单独建立 `Opacity Noise UV` 子图：`TexCoord -> Scale -> Panner -> Noise Texture Sample -> (Density Influence * Dynamic Noise Influence) -> Multiply`，再把输出送回主材质的透明度链。
这张图切换到了材质实例 `M_Shockwave_Inst`，作者直接在实例面板里集中检查前面做好的参数分组和默认值。左侧视口中已经能看到一圈浅绿色半透明冲击波落在地面上，说明当前参数至少能驱动出一版可用结果。

- 参数分组与可见值：
  - `Color Noise`
    - `Color Control`
    - `Color Noise Influence = 0.0`
    - `Color Noise(Scale/Scroll)`
    - `Color Texture(Scale/Scroll)`
    - `T_Color = DefaultTexture`
  - `Global Scalar Parameter Values`
    - `Depth Fade = 100.0`
  - `Opacity Mask`
    - `Mask Exp = 1.0`
    - `Mask Mult = 1.0`
    - `T_OpacityMask = T_Gradient21`
  - `Opacity Noise`
    - `Opacity Noise Influence = 1.0`
    - `Opacity Noise(Scale/Scroll)`
    - `T_Noise = DefaultTexture`
  - `Wave Mask`
    - `T_WaveMask = T_Gradient20`
    - `Wave Mask Control`
- 其他已确认设置：
  - 实例父材质：`Parent = M_Shockwave`
  - 窗口底部仍能看到材质属性覆盖区，说明这是对正式实例而不是主材质图做的检查
- 结构含义：
  - 这一帧把之前分散在材质图各子图中的参数，正式整理成实例可调面板
  - 参数命名已经按功能分成：
    - 颜色噪声
    - 全局标量
    - 透明遮罩
    - 透明噪声
    - 波形遮罩
  - 这也意味着后续 Niagara、蓝图或美术调参时，可以直接在实例级完成大部分工作，而不用频繁改主材质
- 输出/预览：
  - 左侧视口能看到薄薄一圈绿色发光环贴在地面
  - 说明实例参数已经和前面的材质结构正确连通，至少能还原出基础冲击波外观

按图复建时，可在主材质完成后立刻创建实例，并至少建立这五类参数组：`Color Noise`、`Global Scalar Parameter Values`、`Opacity Mask`、`Opacity Noise`、`Wave Mask`。其中 `Depth Fade = 100`、`Mask Exp = 1`、`Mask Mult = 1`、`Opacity Noise Influence = 1` 可作为一套基础起点。
这张图继续在材质实例 `M_Shockwave_Inst` 中调参，但已经从“基础绿色环”推进到一版明显的彩虹色边缘效果。左侧视口里，冲击波出现粉、青、黄等多色叠层，说明颜色控制、色散和噪声都被显著增强。

- 已确认参数分组与数值：
  - `Color Noise`
    - `Color Control`
      - `Desaturation = 3.0`
      - `Multiply = 2.0`
      - `Chroma = 25.0`
      - `A = 1.0`
    - `Color Noise Influence = 0.0`
    - `Color Noise(Scale/Scroll)`
    - `Color Texture(Scale/Scroll)`
    - `T_Color = DefaultTexture`
  - `Global Scalar Parameter Values`
    - `Depth Fade = 100.0`
  - `Global Texture Parameter Values`
    - `Refraction Noise = T_refractionNoise_B`
  - `Opacity Mask`
    - `Mask Exp = 1.0`
    - `Mask Mult = 1.0`
    - `T_OpacityMask = T_Gradient21`
  - `Opacity Noise`
    - `Opacity Noise Influence = -1.0`
    - `Opacity Noise(Scale/Scroll)`
    - `T_Noise = DefaultTexture`
  - `Wave Mask`
    - `T_WaveMask = T_Gradient20`
    - `Wave Mask Control`
- 结构含义：
  - 与上一张相比，这一帧的核心变化是：
    - `Color Control` 整组值被大幅调高，尤其是 `Chroma = 25`
    - 额外引入了 `Refraction Noise = T_refractionNoise_B`
    - `Opacity Noise Influence` 被改为负值 `-1`
  - 这说明作者在实例层同时强化了：
    - 色散分离
    - 整体亮度
    - 透明噪声的反向影响
    - 折射/扰动纹理来源
- 输出/预览：
  - 左侧视口出现一圈发光较柔和、但颜色非常丰富的能量环
  - 环体内部能看到粉、蓝、青、黄等条带交错，明显不是单色冲击波
  - 说明这套实例参数已经能把同一主材质推进到更风格化、偏魔法感的表现

按图复建时，可先保持 `Depth Fade = 100`、`Mask Exp = 1`、`Mask Mult = 1` 不变，再重点提高 `Color Control` 中的 `Desaturation`、`Multiply`、`Chroma`，并尝试给 `Opacity Noise Influence` 负值以及指定一张 `Refraction Noise` 贴图，以获得这种多彩、带折射感的能量环效果。

### 00:30:38-00:33:55 Color、Material、Depth Fade

- 本段定位：Color、Material、Depth Fade。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Depth Fade` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Noise` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Opacity` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Color`、`Alpha`、`Opacity`、`Material`、`Texture`、`Noise`、`Depth Fade`、`Multiply`。

**关键画面：**

这张图继续在材质实例 `M_Shockwave_Inst` 中调参，但这次聚焦的是 `Color Noise(Scale/Scroll)`。作者在保持彩色环整体风格不变的前提下，只做少量移动/滚动幅度调整，让彩色噪声在环体上的分布更自然。

- 已确认参数分组与数值：
  - `Color Noise`
    - `Color Control`
      - `Desaturation = 3.0`
      - `Multiply = 2.0`
      - `Chroma = 25.0`
      - `A = 1.0`
    - `Color Noise Influence = 1.0`
    - `Color Noise(Scale/Scroll)`
      - `R = 0.6`
      - `G = 0.21`
      - `B = 0.007`
      - `A = 0.0`
    - `Color Texture(Scale/Scroll)`
    - `T_Color = DefaultTexture`
  - `Global Scalar Parameter Values`
    - `Depth Fade = 100.0`
  - `Global Texture Parameter Values`
    - `Refraction Noise = T_refractionNoise_B`
  - `Opacity Mask`
    - `Mask Exp = 1.0`
    - `Mask Mult = 1.0`
    - `T_OpacityMask = T_Gradient21`
  - `Opacity Noise`
    - `Opacity Noise Influence = -1.0`
    - `Opacity Noise(Scale/Scroll)`
    - `T_Noise = DefaultTexture`
  - `Wave Mask`
    - `T_WaveMask = T_Gradient20`
    - `Wave Mask Control`
- 结构含义：
  - 相比上一张，这一帧主要变化不是颜色强度，而是颜色噪声的缩放与滚动参数
  - 结合字幕“移动，就一点点”，可推断作者在做较小幅度的运动微调，而不是大改整体风格
  - `Color Noise Influence = 1.0` 说明彩色噪声此时已经被真正启用，而不再是关闭或仅作占位
- 输出/预览：
  - 左侧视口里能量环保持粉、青、黄等多色叠层
  - 与上一张相比，彩色条带分布更均匀、更连贯，没有明显断裂的大块色斑

按图复建时，可在得到基础彩虹环后，再微调 `Color Noise(Scale/Scroll)` 的四个分量，尤其是缩放和很小的滚动值，目标不是改变颜色种类，而是让色带在环体上分布得更柔和、更连续。
这张图继续在材质实例 `M_Shockwave_Inst` 中调参，但作者把观察重点放到最终折射/彩色扭曲效果上。左侧视口里，整片建筑背景被拉成大面积彩虹色流动条纹，底部字幕也明确说“最后会有这种折射”，说明这一步是在验证强折射噪声是否真正生效。

- 已确认参数分组与数值：
  - `Color Texture(Scale/Scroll)`
    - `R = 1.0`
    - `G = 0.25`
    - `B = 0.014`
    - `A = 0.01`
  - `T_Color = T_PerlinNoise3`
  - `Global Scalar Parameter Values`
    - `Depth Fade = 0.0`
  - `Global Texture Parameter Values`
    - `Refraction Noise = T_DistortionNoise1`
  - `Opacity Mask`
    - `Mask Exp = 1.0`
    - `Mask Mult = 1.0`
    - `T_OpacityMask = T_Gradient21`
  - `Opacity Noise`
    - `Opacity Noise Influence = -1.0`
    - `Opacity Noise(Scale/Scroll)`
    - `T_Noise = DefaultTexture`
  - `Wave Mask`
    - `T_WaveMask = T_Gradient20`
    - `Wave Mask Control`
  - 其他可见：
    - 实例父材质仍为 `M_Shockwave`
    - `Refraction Depth Bias = 0.0`
- 结构含义：
  - 这一帧的关键变化是：
    - `T_Color` 从普通默认贴图切到 `T_PerlinNoise3`
    - 折射贴图明确指定为 `T_DistortionNoise1`
    - `Depth Fade` 被压到 `0.0`
  - 这说明作者在做更激进的屏幕扭曲测试，让颜色噪声与折射噪声共同放大可见的折射拉扯感
- 输出/预览：
  - 左侧视口中的背景建筑被扭曲成大面积粉、青、黄、绿混合的垂直流纹
  - 已经不只是“环体上有彩边”，而是明显影响到背景画面采样，符合折射材质的最终表现逻辑

按图复建时，可在需要明显折射时，给 `T_Color` 选一张高频噪声图如 `T_PerlinNoise3`，再把 `Refraction Noise` 指定为类似 `T_DistortionNoise1` 的失真贴图，并把 `Depth Fade` 暂时压低到 `0` 附近进行可视化验证，确认屏幕背景确实被扭曲采样。
这张图仍在材质实例 `M_Shockwave_Inst` 中做最终折射/遮罩调试。左侧视口里，背景建筑被折射成竖向彩色条带，说明折射和噪声已经明显生效；但底部字幕提到的目标值与当前面板可见值并不一致，因此不能直接把字幕内容当成已经落地的最终参数。

- 已确认面板值：
  - `Opacity Mask`
    - `Mask Exp = 1.0`
    - `Mask Mult = 1.0`
    - `T_OpacityMask = T_Gradient20`
  - `Opacity Noise`
    - `Opacity Noise Influence = 1.0`
    - `Opacity Noise(Scale/Scroll)`
      - `R = 3.0`
      - `G = 0.22`
      - `B = 0.01`
      - `A = 0.05`
    - `T_Noise = T_PerlinNoise`
  - `Wave Mask`
    - `T_WaveMask = T_Gradient21`
    - `Wave Mask Control`
      - `Power = 1.0`
      - `MultiplyPower = 1.0`
      - `Multiply = 1.0`
      - `Lerp = 0.5`
  - 其他可见：
    - `Parent = M_Shockwave`
    - `Refraction Depth Bias = 0.0`
    - `Blend Mode = Additive`
    - `Shading Model = Unlit`
- 已确认效果：
  - 视口左侧能看到一列明显的彩色折射条纹，颜色包括黄、青、粉、绿
  - 说明此时材质已从“柔和彩环”转向“强折射/强屏幕扭曲”的表现
- 不确定点：
  - 字幕说“Set power to 100. Multiply power by 25”，但当前可见 `Wave Mask Control` 数值仍显示为 `1.0 / 1.0 / 1.0 / 0.5`
  - 因此无法确认：
    - 是字幕在描述下一步准备输入的数值
    - 还是画面没有停在参数真正生效后的瞬间
  - 不能据此把 `Power=100`、`MultiplyPower=25` 当作本帧已经应用的可靠事实

按图复建时，应以当前可见面板值作为这张图的可靠依据；如果要采用字幕提到的更高强度参数，必须回到更清晰的后续画面或实际实例中再次验证其是否真的被输入并生效。

### 00:33:56-00:36:52 System、Color、Material

- 本段定位：System、Color、Material。
- 知识点：本段围绕 `Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Color` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：User Parameter 要保持命名和类型稳定，便于蓝图、材质或系统级控制复用。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Translucent` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Color`、`Alpha`、`Opacity`、`Material`、`User Parameter`、`Multiply`、`Add`、`Panner`。

**关键画面：**

这张图继续在材质实例 `M_Shockwave_Inst` 中做强折射版本调试，而且这一次面板里已经能明确看到上一批字幕提到的高强度参数真正被输入并生效。左侧视口中，能量环不再是平面环，而是被拉成一面竖立的、强烈折射背景的彩色能量墙。

- 已确认参数分组与数值：
  - `T_Color = T_PerlinNoise3`
  - `Global Scalar Parameter Values`
    - `Depth Fade = 0.0`
  - `Global Texture Parameter Values`
    - `Refraction Noise = T_DistortionNoise1`
  - `Opacity Mask`
    - `Mask Exp = 1.0`
    - `Mask Mult = 1.0`
    - `T_OpacityMask = T_Gradient20`
  - `Opacity Noise`
    - `Opacity Noise Influence = 0.075`
    - `Opacity Noise(Scale/Scroll)`
      - `R = 3.0`
      - `G = 0.22`
      - `B = 0.01`
      - `A = 0.05`
    - `T_Noise = T_PerlinNoise`
  - `Wave Mask`
    - `T_WaveMask = T_Gradient21`
    - `Wave Mask Control`
      - `Power = 100.0`
      - `MultiplyPower = 25.0`
      - `Multiply = 15.0`
      - `Lerp = 0.35`
- 结构含义：
  - 这一帧证明前一批里不确定的目标值已经真正落地：
    - `Power` 不再是 `1`，而是被推到 `100`
    - `MultiplyPower` 为 `25`
    - `Multiply` 也被进一步推高到 `15`
  - 同时 `Opacity Noise Influence` 被压到很小的正值 `0.075`，说明作者在增强波形/遮罩主导性的同时，降低透明噪声本身的主导程度
- 输出/预览：
  - 左侧视口里效果像一面竖立的彩色折射幕墙，底部边缘呈尖锐锯齿状
  - 背景建筑被明显拉伸扭曲，彩虹色折射条纹非常强
  - 说明这组参数更适合做“高能量冲击墙/折射屏障”类风格，而不是柔和的地面冲击波

按图复建时，如果需要强折射屏障感，可直接把 `Wave Mask Control` 提到这组高值：`Power = 100`、`MultiplyPower = 25`、`Multiply = 15`、`Lerp = 0.35`，再把 `Opacity Noise Influence` 压到较小正值，如 `0.075`，以避免噪声把主轮廓冲散。
这张图从材质实例窗口切回 Unreal 场景实景，直接验证 `M_Shockwave_Inst` 挂到特效后的最终表现。画面中心是白色圆柱命中体，左右拉出两条紫粉色能量带，说明作者此时已经不再看单个材质球，而是在检查材质实例与 Niagara/场景的整体匹配。

- 场景对象：
  - 左侧有角色参考体
  - 中间有白色圆柱 `SM_Circle_01` 一类的命中/碰撞参考物
  - 右侧 Outliner 中能看到多个 `NS_MagicProjectile...` 相关对象
  - 内容浏览器当前选中材质实例 `M_Shockwave_Inst`
- 已确认外观特征：
  - 两条紫粉色能量带从左向右汇入圆柱前方亮点
  - 能量带内部有明显的亮白中心、紫粉外缘和局部噪声拖尾
  - 地面和圆柱表面被明显染上紫色发光，说明 `Emissive` 结果与屏幕观感已经稳定
  - 与前面仅看材质预览球不同，这里能确认材质在真实世界空间中的方向感、长度感和贴地关系
- 结构含义：
  - 这一帧的用途是把前面在 `M_Shockwave_Inst` 中调好的颜色、折射、透明度、遮罩参数，放回系统里做最终验收
  - 如果材质实例只在预览球上好看、但在场景里失真，这一步就会暴露问题；当前画面说明它已经能稳定支撑一道向前冲击的魔法拖尾
- 输出/预览：
  - 结果不再是彩色折射墙，而是收束成两条更可控的紫色能量拖尾
  - 说明作者已经把先前“极端折射测试”的材质收回到适合正式特效镜头的强度范围

按图复建时，材质实例调完后必须回到关卡或 Niagara 预览场景核对：能量带应沿攻击方向拉出，主体以紫粉色为主，中心更亮，地面和命中体要能看到明显的发光映射感。
这张图切换到了 Niagara 系统 `NS_MagicProjectiles_Impact`，当前选中发射器是 `Shockwave_Start`。重点不再是材质参数，而是把前面做好的材质实例真正挂到 `Mesh Renderer` 上，并确认网格渲染方式。

- 系统结构：
  - 当前系统总览中可见多个发射器卡片：
    - `Flare`
    - `RingChroma`
    - `GlowCenter_Start`
    - `GlowCenter_Multiple`
    - `Flare_Start`
    - `SceneBlurImpact`
    - `Shockwave_Start`
  - 当前选中发射器：`Shockwave_Start`
- `Shockwave_Start` 当前模块链可见：
  - `Emitter Spawn`
  - `Emitter Update`
  - `Particle Spawn`
  - `Initialize Particle`
  - `Particle Update`
  - `Render`
    - `Mesh Renderer`
- `Mesh Renderer` 已确认设置：
  - `Mesh Rendering`：
    - `Index [0] = SM_Circle_01`
  - `LODLevel = 0`
  - `Scale = (1.0, 1.0, 1.0)`
  - `Rotation = (0.0, 0.0, 0.0)`
  - `Pivot Offset = (0.0, 0.0, 0.0)`
  - `Pivot Offset Space = Mesh`
  - `Enable Material Overrides` 已开启
  - `Override Materials`：
    - `Index [0] -> Explicit Mat = MI_Shockwave_01`
    - `User Param Binding = None`
    - `Source Mode = Particles`
  - `Facing Mode = Default`
  - `Sort Mode = None`
  - `Renderer Visibility = 0`
- 视口结果：
  - 左侧 Niagara 预览里，冲击波表现为一圈贴地展开的彩色光环/折射环
  - 说明 `SM_Circle_01` 网格 + `MI_Shockwave_01` 材质实例的组合已经能在系统里正常出图
- 不确定点：
  - 底部字幕提到“把 SuiteWebFacing 改成 CameraPlane”，但当前截图右侧展开的是 `Mesh Renderer`，未直接显示对应参数位置
  - 因此不能把 `CameraPlane` 当成这张图中已经在面板里可见并确认过的当前值

按图复建时，可在 `Shockwave_Start` 这类冲击波发射器上使用 `Mesh Renderer`，指定网格 `SM_Circle_01`，并启用 `Override Materials` 把 `MI_Shockwave_01` 挂上去。先确保系统侧确实能渲染出贴地彩色环，再继续细调朝向或面向相机相关选项。

### 00:36:58-00:39:53 Color、Multiply、Add

- 本段定位：Color、Multiply、Add。
- 知识点：本段围绕 `Color`、`Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：User Parameter 要保持命名和类型稳定，便于蓝图、材质或系统级控制复用。
- 知识点：本段围绕 `Noise` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`Color`、`User Parameter`、`Noise`、`Multiply`、`Add`、`材质`、`系统`、`蓝图`。

**关键画面：**

这张图继续停在 Niagara 系统 `NS_MagicProjectiles_Impact` 的 `Shockwave_Start` 发射器上，重点是把 `Mesh Renderer` 的朝向方式切到 `Camera Plane`。这正好补足了上一批里只能从字幕推测、但面板未展开确认的那一项。

- 系统与发射器：
  - 当前系统：`NS_MagicProjectiles_Impact`
  - 当前选中发射器：`Shockwave_Start`
  - 预览状态显示 `1 Particles`
- `Mesh Renderer` 已确认设置：
  - `Meshes`
    - `Index [0] = SM_Circle_01`
  - `LODLevel = 0`
  - `Scale = (1.0, 1.0, 1.0)`
  - `Rotation = (0.0, 0.0, 0.0)`
  - `Pivot Offset = (0.0, 0.0, 0.0)`
  - `Pivot Offset Space = Mesh`
  - `Enable Material Overrides` 已开启
  - `Override Materials`
    - `Index [0] -> Explicit Mat = MI_Shockwave_01`
    - `User Param Binding = None`
    - `Source Mode = Particles`
  - 额外可见参数：
    - `Locked Axis Enable` 未勾选
    - `Enable Mesh Flipbook` 未勾选
    - `Facing Mode = Camera Plane`
    - `Sort Mode = None`
    - `Renderer Visibility = 0`
    - `Enable Frustum Culling` 未勾选
    - `Enable Camera Distance Culling` 未勾选
    - `Cast Shadows` 已勾选
    - `Sort Order Hint = 11`
    - `Motion Vector Setting = Auto Detect`
- 结构含义：
  - 与上一批相比，这一帧最关键的新增确认是：
    - `Facing Mode` 明确设置为 `Camera Plane`
  - 这意味着该冲击波网格不会只按世界固定平面显示，而会在渲染时按相机平面进行朝向处理，更适合这种需要从多个角度保持可读性的环状/幕状效果
- 输出/预览：
  - 左侧预览窗口当前几乎看不到明显特效形状
  - 说明这一帧的目的不是展示外观，而是调整渲染器朝向模式

按图复建时，如果 `Shockwave_Start` 使用的是 `Mesh Renderer + SM_Circle_01 + MI_Shockwave_01` 这组组合，可把 `Facing Mode` 改为 `Camera Plane`，再继续观察相机斜视角下冲击波是否更稳定、更易读。
这张图继续在 Niagara 系统 `NS_MagicProjectiles_Impact` 的 `Shockwave_Start` 发射器上调整，但当前选中的是 `Particle Update` 里的 `Scale Mesh Size` 模块，而不是渲染器本身。字幕说明后面还要“添加位移”，说明这一阶段开始从单纯显示网格，过渡到用粒子模块控制冲击波网格的尺寸变化。

- 系统与发射器：
  - 当前系统：`NS_MagicProjectiles_Impact`
  - 当前发射器：`Shockwave_Start`
  - 右侧详情顶部显示 `No running preview`
- `Shockwave_Start` 当前模块链可见：
  - `Emitter Spawn`
  - `Emitter Update`
  - `Particle Spawn`
    - `Initialize Particle`
    - `Camera Offset`
    - `Shape Location Sphere`
  - `Particle Update`
    - `Scale Mesh Orientation Vector`
    - `Particle State`
    - `Scale Mesh Size`
    - `Scale Color`
  - `Render`
    - `Mesh Renderer`
- `Scale Mesh Size` 已确认设置：
  - 模块名：`Scale Mesh Size`
  - 参数：`Scale Factor`
  - 当前值：
    - `X = 1.0`
    - `Y = 1.0`
    - `Z = 1.0`
- 结构含义：
  - 这一帧说明冲击波网格的大小控制不完全依赖初始化，而是在 `Particle Update` 里继续保留一个可逐帧调节的网格缩放模块
  - 当前 `Scale Factor = (1,1,1)` 表示还没有对网格做额外拉伸或压缩，但模块已经放在正确位置，便于后续加入动态变化
- 输出/预览：
  - 左侧预览窗口当前几乎没有可见冲击波结果
  - 这和该帧主要关注模块结构而不是最终显示一致

按图复建时，可在 `Shockwave_Start` 的 `Particle Update` 中加入 `Scale Mesh Size`，先以 `(1,1,1)` 作为基准值，再根据镜头需要叠加随时间变化的尺寸曲线或位移逻辑。
这张图继续在 `NS_MagicProjectiles_Impact` 的 `Shockwave_Start` 发射器内工作，但重点切到了 `Particle Update` 里的 `Dynamic Material Parameters` 模块。作者在这里把粒子生命周期与材质实例参数正式对接，让 `Offset`、`Refraction`、`Noise Influence` 等值能按粒子年龄驱动。

- 系统与发射器：
  - 当前系统：`NS_MagicProjectiles_Impact`
  - 当前发射器：`Shockwave_Start`
- `Shockwave_Start` 当前模块链可见：
  - `Emitter Spawn`
  - `Emitter Update`
  - `Particle Spawn`
  - `Particle Update`
    - `Scale Mesh Orientation Vector`
    - `Particle State`
    - `Scale Mesh Size`
    - `Scale Color`
    - `Dynamic Material Parameters`
  - `Render`
    - `Mesh Renderer`
- `Dynamic Material Parameters` 已确认设置：
  - 当前查看页签：`All`
  - `Dynamic Parameter Index 0`
    - `Write Parameter Index 0` 已启用
    - 参数名：`Offset`
    - 写入方式：`Float from Curve`
    - `Curve for Floats` 使用 `PARTICLES.NormalizedAge`
    - `Scale Curve = 1.0`
    - 曲线显示为随生命周期从低值逐步升高
    - 同页还可见：
      - `Refraction = 0.0`
      - `Noise Influence = 1.0`
      - `Param3-0 (parameter not used in material) = 0.0`
  - `Dynamic Parameter Index 1`
    - `Write Parameter Index 1` 未启用
  - `Dynamic Parameter Index 2`
    - `Write Parameter Index 2` 未启用
  - `Dynamic Parameter Index 3`
    - `Write Parameter Index 3` 未启用
- 结构含义：
  - 这一帧证明 `Shockwave_Start` 并不是只依赖材质实例静态参数，而是会在粒子更新阶段直接向材质传值
  - `Offset` 明确被绑定到 `NormalizedAge` 曲线，说明随着粒子生命推进，材质中的 UV 偏移/滚动也会同步变化
  - `Refraction` 与 `Noise Influence` 当前以常量方式给出，便于在系统层统一控制每个冲击波粒子的材质表现
- 输出/预览：
  - 左侧预览窗口仍没有明显特效外形
  - 这与当前焦点是参数写入逻辑而不是最终显示一致

按图复建时，可在 `Particle Update` 中使用 `Dynamic Material Parameters`，至少把 `Offset` 绑定到 `PARTICLES.NormalizedAge` 的浮点曲线，再根据需要给 `Refraction` 和 `Noise Influence` 设定常量或额外曲线，从而把系统生命周期与材质动画真正联动起来。

### 00:40:03-00:43:02 Lifetime、Color、Multiply

- 本段定位：Lifetime、Color、Multiply。
- 知识点：本段围绕 `Color` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：角色或镜头演示需要导入 FBX/骨骼/动画，并用 Sequencer 校准触发时机。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：Lifetime 决定粒子存活时间，需要和 Spawn 数量、速度以及透明度曲线一起调。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Spawn`、`Lifetime`、`Color`、`Sequencer`、`Multiply`、`Add`、`粒子`、`速度`。

**关键画面：**

这是 `NS_MagicProjectiles_Impact` 系统的总览界面，当前选中发射器 `Shockwave_Start`，右侧展开的是它的 `Mesh Renderer`。本图用于确认冲击波圆环网格已经替代 Sprite 渲染，并在时间轴中与其他子发射器一起参与这次 Impact 效果。

已确认的发射器栈顺序如下：
- `Emitter Spawn`：`Spawn Burst Instantaneous`
- `Initialize Particle`
- `Camera Offset`
- `Apply Initial Spin`
- `Initial Mesh Orientation Vector`
- `Particle Update`
  - `Particle State`
  - `Scale Mesh Size`
  - `Scale Color`
  - `Dynamic Material Parameters`
- `Render`
  - `Mesh Renderer`

右侧 `Mesh Renderer` 已确认的关键设置如下：
- `Meshes[0] = SM_Circle_01`
- `LODMode = LODLevel`
- `LOD Level = 0`
- `Scale = (1.0, 1.0, 1.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Pivot Offset = (0.0, 0.0, 0.0)`
- `Pivot Offset Space = Mesh`
- `Enable Material Overrides` 已启用
- `Override Materials[0] -> Explicit Mat = MI_Shockwave_01`
- `User Param Binding = None`
- `Source Mode = Particles`
- `Facing Mode = Camera Plane`
- `Sort Mode = None`
- `Enable Frustum Culling` 未启用
- `Enable Camera Distance Culling` 未启用
- `Renderer Visibility = 0`
- `Cast Shadows` 已启用
- `Sort Order Hint = 11`
- `Motion Vector Setting = Auto Detect`

时间轴下方能看到本系统此时同时存在 `Background_Purple`、`Flare`、`Flare_Multiple`、`Flare_Start`、`GlowCenter_Multiple` 等轨道，说明 `Shockwave_Start` 只是整套命中特效中的一个网格圆环层。
这张图继续编辑 `NS_MagicProjectiles_Impact` 中的 `Shockwave_Start`，当前选中模块是 `Particle Update > Dynamic Material Parameters`，并停留在 `All` 页签。图中重点不是模块位置，而是材质动态参数的两条曲线已经被具体设定出来，用来驱动冲击波材质随生命周期变化。

已确认的模块位置如下：
- 所属发射器：`Shockwave_Start`
- 所属阶段：`Particle Update`
- 当前模块：`Dynamic Material Parameters`
- 下方 `Render` 仍接 `Mesh Renderer`

`Dynamic Parameter Index 0` 已启用，当前可见的参数与驱动方式如下：
- `Write Parameter Index 0` 已启用
- 参数 `Offset`
  - 写入方式：`Float from Curve`
  - `Curve for Floats` 使用 `PARTICLES.NormalizedAge`
  - 曲线形状为从负值起步后逐渐上升，左侧被选中的起始关键点 `Key Data` 显示为 `0.0 / -0.75`
  - `Scale Curve = 1.0`
- 参数 `Refraction`
  - 写入方式：`Float from Curve`
  - `Curve for Floats` 使用 `PARTICLES.NormalizedAge`
  - 曲线从左高右低，表示随生命周期推进逐步衰减
  - `Scale Curve = 2.0`
- 参数 `Noise Influence = 1.0`
- 参数 `Param3-0 = 0.0`

其他索引状态：
- `Dynamic Parameter Index 1` 未启用
- `Dynamic Parameter Index 2` 未启用
- `Dynamic Parameter Index 3` 未启用

从图中可直接复现的意图是：让冲击波材质的 `Offset` 随粒子年龄推进而向外偏移，同时让 `Refraction` 强度从初始高值衰减，从而形成扩张后逐渐消散的屏幕折射环。
这张图切回关卡预览与 Sequencer，用来验证前面设置过的命中效果在镜头中的最终表现。画面中一束紫白色能量从左向右打到白色圆柱体目标，碰撞点爆出高亮核心、外扩光晕和地面反射，说明 `NS_MagicProjectiles_Impact` 已经和主弹道、预备光效一起对齐播放。

场景中可直接确认的对象如下：
- 命中目标：白色圆柱体静态网格
- 受击位置：圆柱左侧中部，亮度最高
- 地面：深浅棋盘格地面，可看到紫色光照反射
- 视图模式：编辑器 `Perspective` 视口下直接预览

Sequencer 轨道可见的对象如下：
- `Camera Cuts`
- `CineCameraActor`
- `Gideon_Inquisitor`
- `NS_Glow_Anticipation`
- `NS_MagicProjectiles`
- `NS_MagicProjectiles_Impact`

时间轴状态：
- 当前播放头约在 `2.20` 秒
- `NS_Glow_Anticipation`、`NS_MagicProjectiles`、`NS_MagicProjectiles_Impact` 三条 Niagara 轨道存在时序重叠
- 命中帧对应 `NS_MagicProjectiles_Impact` 已在主弹道到达目标时触发，而不是单独悬空播放

从结果上可以确认这一段的调参目标：主投射物命中后，冲击波网格与材质参数变化会在实际镜头里形成一个高亮、带折射感的爆点，并与预备蓄力光效和飞行中的能量束连续衔接。

### 00:43:06-00:46:04 Lifetime、Color、Material

- 本段定位：Lifetime、Color、Material。
- 知识点：本段围绕 `Color` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：Lifetime 决定粒子存活时间，需要和 Spawn 数量、速度以及透明度曲线一起调。；材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Spawn`、`Lifetime`、`Color`、`Alpha`、`Opacity`、`Material`、`Panner`、`Emissive`。

**关键画面：**

这张图是在关卡视口与 Sequencer 中直接观察命中特效的中段状态。画面里紫色能量束沿地面从左向右推进，已经抵达白色圆柱体附近，但冲击点的高亮爆发还没有完全展开，因此这一帧主要用于判断主弹道、接触位置和持续发光尾迹的关系。

可确认的画面状态如下：
- 命中目标仍是场景中央偏右的白色圆柱体
- 紫色能量束从左侧贴地延伸到目标脚边，内部可见亮粉色电流纹理和细小发光粒子
- 圆柱左边缘已有轻微紫色受光，但尚未出现上一组截图中那种强烈的中心白光
- 地面棋盘格上能看到能量束带来的紫色照明与反射

Sequencer 与场景关系：
- 当前视图是 `Perspective` 视口下的实时预览
- 播放头位于约 `2.6746` 秒
- 可见轨道包括 `Camera Cuts`、`CineCameraActor`、`Gideon_Inquisitor`、`NS_Glow_Anticipation`、`NS_MagicProjectiles`、`NS_MagicProjectiles_Impact`
- 此时 `NS_MagicProjectiles` 与 `NS_MagicProjectiles_Impact` 轨道都处于有效区间，说明教程正在检查主投射物与命中层之间的衔接时机

这张图对应的复现重点不是新节点，而是确认生命周期、颜色和材质调参后，飞行中的主能量束在接触目标前后仍保持紫粉色主体、流动高光和贴地延展感，不会在命中前突然熄灭或断段。
这张图继续在关卡视口中检查命中瞬间的视觉结果，但同时把 `Content Browser` 展开到 `VFX_Library > Meshes`，用于确认当前效果制作过程中涉及的静态网格资源。画面里圆柱左侧已经出现明显的命中亮斑，紫白色核心光把圆柱边缘和地面反射都提亮了。

关卡画面中可确认的信息：
- 主能量束仍从左向右撞向白色圆柱
- 命中点已经出现集中白光与淡紫色外溢光晕
- 地面反射比上一张更亮，说明命中层的发光和材质表现正在生效
- 画面左端还能看到角色身体的一小部分，说明这段预览是在完整攻击镜头中直接观察，而不是单独截取命中点

资源浏览器中可确认的信息：
- 当前路径在 `Content > VFX_Library > Meshes`
- 当前被选中的静态网格是 `SM_CylinderBowl_01`
- 同一目录还可见 `SM_Circle_01`、`SM_Cone_01`、`SM_Cylinder_01`、`SM_Ring_01`、`SM_TorusHighPoly_01` 等网格资源

这张图的用途是双重核对：
- 一方面确认 `NS_MagicProjectiles_Impact` 的颜色、亮度和材质参数在镜头里确实形成了更强的撞击发光
- 另一方面确认教程工程中用于测试或搭建场景的网格资源库已经准备好，尤其是圆柱类网格和前面用作冲击波圆环的 `SM_Circle_01`
这张图重新回到 `NS_MagicProjectiles` 的系统编辑界面，当前选中的仍是命中用发射器 `Shockwave_Start`，但右侧 `Mesh Renderer` 出现了新的明确调整：用于渲染冲击波的网格已经从之前的圆环平面切换为 `SM_CylinderBowl_01`。结合字幕“改变初始方向”，可以判断教程正在尝试通过更合适的网格形状与朝向，改善命中层的空间外观。

发射器栈可见内容：
- 发射器：`Shockwave_Start`
- `Emitter Update`
  - `Emitter State`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Shape Location Sphere`
  - `Initial Mesh Orientation`
- `Particle Update`
  - `Particle State`
  - `Scale Mesh Size`
  - `Scale Color`
  - `Dynamic Material Parameters`
- `Render`
  - `Mesh Renderer`

右侧 `Mesh Renderer` 当前能确认的关键设置：
- `Meshes[0] = SM_CylinderBowl_01`
- `LODMode = LODLevel`
- `LOD Level = 0`
- `Scale = (1.0, 1.0, 1.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Pivot Offset = (0.0, 0.0, 0.0)`
- `Pivot Offset Space = Mesh`
- `Enable Material Overrides` 已启用
- `Override Materials[0] -> Explicit Mat = MI_Shockwave_01`
- `User Param Binding = None`
- `Source Mode = Particles`
- `Facing Mode = Default`
- `Sort Mode = None`
- `Enable Frustum Culling` 未启用
- `Enable Camera Distance Culling` 未启用
- `Renderer Visibility = 0`
- `Cast Shadows` 已启用
- `Sort Order Hint = 11`
- `Motion Vector Setting = Auto Detect`

与前面 `S12`、`S13` 的截图相比，这里最重要的变化有两点：
- 网格资源从 `SM_Circle_01` 改为 `SM_CylinderBowl_01`
- 朝向模式从 `Camera Plane` 改为 `Default`

因此本图对应的复现结论是：教程在命中特效阶段不再把冲击波当作始终朝向相机的平面圆环，而是开始尝试带体积感的碗状/半环网格，并配合初始朝向设置去塑造更立体的撞击形态。

### 00:46:06-00:48:55 Material

- 本段定位：Material。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Blender` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Opacity`、`Material`、`Panner`、`Emissive`、`Blender`、`材质`、`纹理`。

**关键画面：**

这张图在关卡视口中直接观察主角施法姿态，同时弹出 `NS_MagicProjectiles` 的小窗口，当前选中发射器 `Shockwave_Start` 的 `Initial Mesh Orientation` 模块。教程这一帧的重点是调整命中网格的初始朝向，让前一批刚换成 `SM_CylinderBowl_01` 的网格不再以错误方向出现。

关卡画面可确认的信息：
- 角色 `Gideon_Inquisitor` 正在向前挥臂施法
- 手部前方出现紫色发光核心和一小段拖尾，说明仍在同一套投射物攻击镜头中
- Sequencer 播放头约在 `1.1333` 秒

`Initial Mesh Orientation` 当前可见设置：
- 模块名：`Initial Mesh Orientation`
- `Mesh Orientation Mode = Orient to Vector`
- 方向向量数值为 `(0.0, 1.0, 1.0)`
- 方向空间为 `Simulation`
- `Mesh Axis = (1.0, 0.0, 0.0)`
- 下方 `Rotation` 区域可见，但本图中未见额外旋转值被明确设置

这张图对应的复现要点是：当 `Shockwave_Start` 使用非平面圆环、而是更有体积感的网格后，需要通过 `Initial Mesh Orientation` 明确指定其朝向向量与网格轴，否则命中特效会以错误角度朝向镜头或场景空间。
这张图继续停留在 `NS_MagicProjectiles` 的系统总览，当前选中发射器仍是 `Shockwave_Start`，右侧显示的是 `Mesh Renderer`。结合字幕“Everything is fine”，这一步不是新增节点，而是在确认前面更换网格与调整方向后，渲染器当前配置没有问题，可以继续往材质层调试。

发射器栈可见结构：
- `Emitter Update`
  - `Emitter State`
  - `Spawn Burst Instantaneous`
- `Particle Spawn`
  - `Initialize Particle`
  - `Shape Location Sphere`
  - `Initial Mesh Orientation`
- `Particle Update`
  - `Particle State`
  - `Scale Mesh Size`
  - `Scale Color`
  - `Dynamic Material Parameters`
- `Render`
  - `Mesh Renderer`

右侧 `Mesh Renderer` 当前确认无误的设置：
- `Meshes[0] = SM_CylinderBowl_01`
- `LODMode = LODLevel`
- `LOD Level = 0`
- `Scale = (1.0, 1.0, 1.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Pivot Offset = (0.0, 0.0, 0.0)`
- `Pivot Offset Space = Mesh`
- `Enable Material Overrides` 已启用
- `Override Materials[0] -> Explicit Mat = MI_Shockwave_01`
- `User Param Binding = None`
- `Source Mode = Particles`
- `Facing Mode = Default`
- `Sort Mode = None`
- `Enable Frustum Culling` 未启用
- `Enable Camera Distance Culling` 未启用
- `Renderer Visibility = 0`
- `Cast Shadows` 已启用
- `Sort Order Hint = 11`
- `Motion Vector Setting = Auto Detect`

这张图的作用是把前一张的方向修正与当前网格渲染状态锚定到同一个发射器上：`Shockwave_Start` 已经稳定使用 `SM_CylinderBowl_01 + MI_Shockwave_01 + Facing Mode Default`，说明接下来材质章节的关注点会转向材质图本身，而不是继续改 Niagara 渲染器框架。
这张图已经切换到 `Blender 3.6.0`，不再显示 Unreal 或 Niagara。画面是 Blender 默认场景，用于单独观察对象在建模软件中的本地朝向和变换信息，因此这张图更像是对上一张“Initial Mesh Orientation / Mesh Axis”问题的补充说明，而不是新的 Niagara 节点配置。

图中可确认的信息如下：
- 当前软件：`Blender`
- 视口模式：`Object Mode`
- 当前视图：`User Perspective`
- 场景层级中存在默认对象：
  - `Camera`
  - `Cube`
  - `Light`
- 当前选中对象：`Cube`
- 右侧 `Transform` 面板显示：
  - `Location X/Y/Z = 0 m`
  - `Rotation X/Y/Z = 0°`
  - 旋转模式：`XYZ Euler`
  - `Scale X/Y/Z = 1.000`

从这张图能可靠得到的教程意图只有一点：作者在借助 Blender 默认立方体说明“网格自身的本地轴向/初始方向”这一概念，以便回到 Unreal 后正确理解 `Initial Mesh Orientation`、`Mesh Axis` 与网格朝向之间的关系。

不确定点：
- 本图未展示 Blender 中具体进行的操作步骤，也未直接出现 `SM_CylinderBowl_01` 的导入结果
- 因此不能仅凭这张图推断作者在 Blender 中具体修改了哪一个轴、是否旋转了真实特效网格，或是否导出过新模型

## 补充视觉证据

### S01 00:02:57

这是材质 `M_Shockwave` 的补充参数图，作用是给噪声采样链增加一个可被实例或 Niagara 动态控制的标量参数 `Opacity Noise Influence`。当前选中的就是这个参数节点，教程要求“先加进去，例如先设为 0”，用于后续按需要逐步放大噪声对透明度或颜色遮罩的影响。

节点定义集：
- `T_Noise`：`Texture Object Parameter`，作为噪声纹理输入源，节点标题可见为 `T_Noise`。
- `Append` ×2：两个 `Append` 节点，用于组合二维坐标或速度分量。
- `Multiply`（左上）：把上方 `Append` 的结果继续相乘后送入 `Panner`。
- `Panner`：对噪声采样的 UV 做平移滚动。
- `Texture Sample`：使用上方 `Panner` 输出的 `UVs`，并接入 `T_Noise` 作为 `Tex`。
- `Opacity Noise Influence`：`Scalar Parameter`，参数名明确显示为 `Opacity Noise Influence`。
- `Multiply(1)`：下方乘法节点，`B = 1.0`，一侧输入来自 `Opacity Noise Influence`。
- `Multiply`（右侧）：把 `Texture Sample` 的输出与下方乘法结果再做一次相乘。
- `Color Noise UV_1`：右侧命名好的结果节点/参数节点，接收最终乘法结果。

连线集：
- 上方 `Append` 输出连接到左上 `Multiply`。
- 左上 `Multiply` 输出连接到 `Panner` 的 `Coordinate`。
- 下方 `Append` 输出连接到 `Panner` 的另一个输入端，用于控制平移相关量。
- `Panner` 输出连接到 `Texture Sample` 的 `UVs`。
- `T_Noise` 输出连接到 `Texture Sample` 的 `Tex`。
- `Opacity Noise Influence` 输出连接到 `Multiply(1)`。
- `Multiply(1)` 输出连接到右侧 `Multiply` 的一个输入端。
- `Texture Sample` 的采样结果连接到右侧 `Multiply` 的另一个输入端。
- 右侧 `Multiply` 输出连接到 `Color Noise UV_1`。

设置/参数：
- 当前选中参数：`Opacity Noise Influence`
- `Parameter Name = Opacity Noise Influence`
- `Default Value = 0.0`
- 详情面板中 `Slider Min = 0.0`
- 详情面板中 `Slider Max = 0.0`
- 详情面板中 `Sort Priority = 32`
- `Multiply(1)` 节点常量输入 `B = 1.0`

输出/预览：
- 左侧材质预览窗口当前显示为一个黑色圆盘，说明在 `Opacity Noise Influence = 0.0` 时，这条噪声影响链对当前预览结果尚未产生可见高亮贡献。
- 底部 `Stats` 面板可见材质统计信息，包括：
  - `Base pass shader without light map: 148 instructions`
  - `Base pass vertex shader: 310 instructions`
  - `Texture samplers: 3/16`
  - `Texture Lookups (Est.): VS(0), PS(3)`
  - `Shader Count: 4`
  - `Preshaders: 3`

这张补充图能支持的复现结论是：在 `M_Shockwave` 中新增一个名为 `Opacity Noise Influence` 的标量参数，并把它乘到噪声采样结果链路上，默认值先设为 `0.0`，为后续通过材质实例或 Niagara 动态材质参数控制噪声强度预留接口。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。

