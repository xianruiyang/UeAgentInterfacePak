# 07 Stylized Ice Spikes

# 07 Stylized Ice Spikes

## 关键术语

- `UV`、`Lerp`、`Multiply`、`Add`、`Clamp`、`Texture`、`Substance`、`Substance Designer`、`PS`、`AE`、`Noise`、`速度`、`Niagara`、`颜色`、`透明度`、`Niagara System`、`Emitter`、`Particle`

## 分段知识

### 00:00:05-00:05:02 Multiply、Add、Texture

- 本段定位：Multiply、Add、Texture。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Substance Designer` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Noise` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Noise`、`Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：参考素材应按效果类型、颜色、运动方式和用途打标签，便于后续复现 VFX 风格。
- 知识点：本段围绕 `Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Opacity`、`Texture`、`Noise`、`Multiply`、`Add`、`Panner`、`Emissive`。

**关键画面：**

该图是 `p72` 新一页的开场结果预览。教程在这里先回到已经做好的冰刺镜头，并口头说明接下来会在 `Substance Designer` 中制作新的纹理

当前可直接确认的画面信息有：

- 镜头只截到冰刺主体的右侧局部，冰刺尖端沿画面右上方向延伸
- 深蓝背景中仍有少量蓝白色亮点和漂浮粒子
- `Outliner` 中当前仍选中 `PointLight`
- 下方 `Sequencer` 时间线停在约 `0.78`

右侧 `Details` 面板可确认点光源仍保持：

- `Location = (0.0, 0.0, 550.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Intensity = 300.0 cd`
- `Intensity Units = Candelas`
- `Attenuation Radius = 16384.0`

字幕直接说明“我们将学习新技术并在 Substance Designer 中创建纹理”，因此这张图的作用不是给出具体参数，而是明确本页新的工作重心已经从 Niagara 参数切换到纹理制作流程
该图是 `Adobe Substance 3D Designer` 中正在搭建的灰度裂纹/噪声纹理图。当前被选中的是 `Fractal Sum Base` 系列噪声节点，教程在用多路噪声、模糊、Warp 和 Blend 叠加出更复杂的冰裂表面基础图

节点定义集

- `Fractal Sum Base`：当前选中噪声节点，输出 `2048x2048 - L16` 灰度图
- `Clouds 2`：上方噪声源，输出 `2048x2048 - L16`
- `Blur HQ Grayscale`：对 `Clouds 2` 做高质量灰度模糊，输出 `2048x2048 - L16`
- `Non Uniform Blur Grayscale`：左下方已存在的裂纹/边缘图，输出 `2048x2048 - L16`
- `Blend`（中间）：把左路裂纹图与另一输入混合，输出黑底白裂纹图
- `Warp`：使用噪声扭曲中间裂纹图，输出被扰动后的裂纹图
- `Blend`（右侧）：把 `Warp` 输出与下方模糊噪声继续混合
- `Fractal Sum 2`：下方第二路噪声源，输出 `2048x2048 - L16`
- `Safe Transform Grayscale`：对 `Fractal Sum 2` 做安全变换
- `Blur HQ Grayscale`（下方）：对变换后的噪声做模糊

连线集

- `Non Uniform Blur Grayscale -> Blend`（中间输入之一）
- 左上已有节点输出 -> `Blend`（中间另一路输入）
- `Blend -> Warp`
- `Fractal Sum Base -> Warp`（作为扭曲输入）
- `Warp -> Blend`（右侧）
- `Fractal Sum 2 -> Safe Transform Grayscale -> Blur HQ Grayscale`（下方链路）
- `Blur HQ Grayscale`（下方） -> `Blend`（右侧）
- `Clouds 2 -> Blur HQ Grayscale`（上方链路，当前画面可见但未直接接到中央结果链）

设置/参数

- 当前图中多个关键节点输出分辨率均为 `2048x2048`
- 输出位深显示为 `L16`
- 选中节点右侧属性标题为 `fractal_sum_base_2 - PROPERTIES`
- `Parent Size = 2048 x 2048`
- `Pixel Size = 1 x 1`
- `Random Seed = 0`
- `Category = Generator`
- `Author = Adobe`
- `Instance Parameters` 中当前可读值：
- `Roughness = 0.77`
- `Global Opacity = 0.98`
- `Min Level = 6`
- `Max Level = 5`
- `Non Square Expansion = True`

输出/预览

- 左侧 `2D VIEW` 正在预览 `Fractal_sum_base_2`，可见一张大面积软化、云雾状的灰度噪声图
- 中央图表中间结果已经出现黑底白裂纹网络，说明噪声正在被用来打散和扭曲裂纹边缘
- 左下角 3D 预览球体/立方体仍是默认灰色材质，表示当前重点还在制作基础灰度贴图，而不是最终材质着色
该图继续在 `Adobe Substance 3D Designer` 中搭建裂纹纹理，不过这次重点从噪声扭曲转到 `Tile Sampler` 排布。教程用一个细长高光形状在黑底上随机散布，再把两路结果混合成交叉裂纹线

节点定义集

- `Polygon 2`：当前作为基础图案输入的白色细长菱形/尖刺形状，输出 `2048x2048 - L16`
- `Tile Sampler`（上方）：使用 `Polygon 2` 作为图案源，随机散布出第一组线状裂纹
- `Tile Sampler`（下方）：同样使用 `Polygon 2` 作为图案源，生成第二组分布不同的线状裂纹
- `Blend`：把上下两路 `Tile Sampler` 结果叠加，得到更密集的交叉裂纹网络

连线集

- `Polygon 2 -> Tile Sampler`（上方）
- `Polygon 2 -> Tile Sampler`（下方）
- `Tile Sampler`（上方） -> `Blend`
- `Tile Sampler`（下方） -> `Blend`

设置/参数

- 所有当前可见节点输出均为 `2048x2048 - L16`
- 右侧属性标题为 `tile_sampler - PROPERTIES`
- `Non Square Expansion = True`

Pattern

- `Pattern = Pattern Input`
- `Pattern Input Number = 1`
- `Pattern Input Distribution = Random`
- `Pattern Input Filtering = Bilinear + Mipmaps`
- `Rotation = 0`
- `Rotation Random = 0`
- `Symmetry Random = 0`
- `Symmetry Random Mode = Horizontal + Vertical`

Size

- `Size Mode = Normal`
- `Size X = 0.04`
- `Size Y = 1`
- `Size Random X = 0.8`
- `Size Random Y = 0.49`
- `Scale = 10`
- `Scale Random = 1`
- `Scale Map Multiplier = 0`
- `Scale Vector Map Multiplier = 0`
- `Scale Map Parametrization Affect = X and Y`

输出/预览

- 左侧 `2D VIEW` 当前预览 `tile_sampler` 输出，可见黑底上分布着大量细长、斜向交错的白色裂纹线
- 中央图中上下两个 `Tile Sampler` 的预览都已经出现稀疏线状裂纹，说明两路随机分布正在被叠加
- 右侧 `Blend` 预览比单一路径更密集，表明教程正通过双层线状采样制造更复杂的裂纹方向变化
- 左下角 3D 预览仍是默认灰色材质球/立方体，说明当前重点仍在生成灰度裂纹贴图本身

### 00:05:02-00:09:41 AE

- 本段定位：AE。
- 知识点：It randomly selects these numbers. 然后在这里一樣,拿了一个很像的,就把种子改成一樣的 这里有相当相似的價值。
- 知识点：需要给你这个檔案,看看 我剛剛拿了它 然后混合它,选择了最多的兩种 然后给它们一点點 以光澤的幫助 然后塗上了Baevel,就这樣 它们看起来不見了,但其實它们剛好軟化了。
- 知识点：它们变得很... 很難看,我用了EGEDETECT 用这些價值来調校它们 然后再一次 可能可以这樣做 基本上,我只是示範 調校,然后Baevel,再一次,它再次变化了,这里一点點。
- 知识点：用光澤来加,这个調校 让我们看看 这里是直的 然后光澤 它变化了一点 然后慢速的淋漓,加上更多的細節,让我们看到所有的聲音 可观察到 一点點亮度。
- 知识点：我用了一个Polygon 用这些设置来放在TileSampler 可能不需要,因为它们很難看 这是为了加更多的 我设置了一个方向的弧度。
- 知识点：在需要要的方向中,设置了強度 然后我们可观察到結果 这里是,例如 在这个 部分 它是直的 用弧度来調校 让我们看到所有的弧度 然后 我设置了 这里我用了这个聲音。
- 知识点：这是我们的聲音 会像雪一樣 用LV的調校来調校 不需要,这里有詳細的 然后我用了Purlin,类似的 用LV的調校来調校,让它们分開一点點。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

该图继续在 `Adobe Substance 3D Designer` 中编辑裂纹线生成用的 `Tile Sampler`。和上一批相比，这里重点展示的是 `Rotation` 与 `Color` 相关属性，用于控制线状裂纹的朝向随机性以及前景/背景颜色

节点定义集

- `Polygon 2`：作为输入图案的细长白色尖刺形状，输出 `2048x2048 - L16`
- `Tile Sampler`（上方）：接收 `Polygon 2` 生成第一组裂纹线
- `Tile Sampler`（下方）：接收 `Polygon 2` 生成第二组裂纹线
- `Blend`：把上下两路裂纹线叠加

连线集

- `Polygon 2 -> Tile Sampler`（上方）
- `Polygon 2 -> Tile Sampler`（下方）
- `Tile Sampler`（上方） -> `Blend`
- `Tile Sampler`（下方） -> `Blend`

设置/参数

- 当前可见节点输出均为 `2048x2048 - L16`
- 右侧属性标题为 `tile_sampler - PROPERTIES`

Rotation

- `Rotation = 0`
- `Rotation Random = 1`
- `Rotation Map Multiplier = 0`
- `Vector Map Multiplier = 0`

Color

- `Mask Map Threshold = 0`
- `Mask Map Invert = False`
- `Mask Map Sampling Technique = Pattern Center`
- `Mask Random = 0`
- `Invert Mask = False`
- `Blending Mode = Max`
- `Color = 白色`
- `Color Random = 0`
- `Color Parametrization Mode = Color Input`
- `Color Parametrization Multiplier = 0`
- `Global Opacity = 1`
- `Background Color = 黑色`
- `Reverse Rendering Order = False`

输出/预览

- 左侧 `2D VIEW` 当前预览仍是黑底上多条斜向、交错的白色裂纹线
- 上下两个 `Tile Sampler` 预览都已生成稀疏线条，`Blend` 预览比单一路更复杂
- 左下角 3D 预览仍是默认灰色材质球/立方体，说明当前仍在做灰度线稿层，而不是最终着色
该图展示在 `Substance Designer` 中用 `Levels` 从噪声图里筛选出稀疏亮斑。教程在这里不是继续画裂纹线，而是额外生成一层黑底白点/白斑细节，用来补充冰面中的微小颗粒与亮点

节点定义集

- `Perlin Noise`：上方基础噪声源，输出 `2048x2048 - L16`
- `Levels`（上方）：对 `Perlin Noise` 的亮暗分布进行重映射
- `BnW Spots 1`：下方黑白斑点噪声源，输出 `2048x2048 - L16`
- `Levels`（中下，当前选中）：从 `BnW Spots 1` 中筛出少量高亮区域
- `Blur HQ Grayscale`：右下方节点，对筛出的亮斑结果进一步模糊

连线集

- `Perlin Noise -> Levels`（上方）
- `BnW Spots 1 -> Levels`（中下）
- `Levels`（中下） -> `Blur HQ Grayscale`
- `Levels`（上方）与 `Levels`（中下）都继续向右侧后续链路输出

设置/参数

- 当前可见节点输出均为 `2048x2048 - L16`
- 右侧属性标题为 `Levels - PROPERTIES`
- `Output Size` 仍跟随输入
- `Pixel Size = 1 x 1`
- `Random Seed = 0`
- `Levels Histogram` 使用 `Luminance Channel`

输出/预览

- 左侧 `2D VIEW` 当前预览 `Levels` 结果，可见黑底上零散分布少量白色亮斑和碎点
- 相比原始 `BnW Spots 1` 的满幅噪声，`Levels` 已把大部分灰度压成黑色，只保留少量最亮区域
- 右下 `Blur HQ Grayscale` 说明这些亮斑后续还会被软化，用于形成更自然的冰面颗粒/高光点
- 左下角 3D 预览仍是默认灰色材质球/立方体，表明当前仍在制作单独的灰度细节图层
该图回到 Unreal Engine，展示新纹理思路在冰刺效果中的整体观感，同时在内容浏览器里定位到 `IceSpikes` 材质资源。教程在这里把 Substance 里生成的裂纹/亮斑思路和 UE 里的冰刺材质联系起来

当前可直接确认的画面信息有：

- 冰刺主体沿画面右侧向左后方延伸，占据大部分视口
- 主体表面和周围可见大量蓝白色亮点、雪花和细碎发光颗粒
- `Outliner` 中当前仍选中 `PointLight`
- 下方 `Content Browser` 定位在 `Content / VFX_Library / Materials / MM / Special / IceSpikes`

当前可见的材质资产有：

- `MI_Ice`
- `M_IceGround`

右侧 `Details` 面板仍能确认点光源保持：

- `Location = (0.0, 0.0, 550.0)`
- `Rotation = (0.0, 0.0, 0.0)`
- `Scale = (1.0, 1.0, 1.0)`
- `Intensity = 300.0 cd`
- `Intensity Units = Candelas`
- `Attenuation Radius = 16384.0`

这张图表达的结论是：当前页前半段在 Substance Designer 里制作的裂纹线和亮斑噪声，最终服务的是 `IceSpikes` 相关材质层。教程此时已经把注意力从单纯的噪声生成，转回到 UE 中的实际材质资产与最终冰刺观感上

### 00:09:43-00:13:03 关键流程 03

- 本段定位：关键流程 03。
- 知识点：需要 從重點進入 因此 我们现在 会 讨论这个題目 调整的改变 讨论 哪些是 重點 和 重點 以及 拆解 拆解 什么是 例如 需要 增加 量 到材料 到某个物体 以及 到組合。
- 知识点：用一定的助力 準備了數學功能 把工作简单化得正確 需要 调整 重點 可以控制 在基本的深度 重點 这是更简单的 可以设置 某些層次会領導 其他層次会跟進。
- 知识点：设置 也包括黑色和白色的质感 基本上可以 例如 在这种情况下 例如 这里 有些 物体 它们 在 前方 有些 在後方 我现在 还没 需要展示一种 对於看起来的。
- 知识点：旋律的样子 它是複雜的 它看起来更好 可以想像 它们是否在那里 但用改動的助力 这些 可以擴展 可以加深度 在層次上 擴展 这些層次 会造成深度。
- 知识点：我们可观察到 这里 只是塗鴉 塗鴉 也包括黑色和白色 在这里 加深度 在 这里 是的 这些物体 有深度 不舒服 我们需要 從这件事 加入黑色和白色的 塗鴉 非常。

**关键画面：**

该图切到 Unreal Engine 的材质编辑器，当前打开的是地面材质 `M_IceGround`。教程在这里先展示材质的基础模式与整体图表规模，再准备继续往材质里加入纹理和位移相关控制

可直接确认的对象与位置为：

- 当前材质标签：`M_IceGround`
- 编辑区域：`M_IceGround > Material Graph`
- 左侧预览球显示为一个纯黑圆球，说明当前材质输出仍处于早期或尚未把可见颜色/透明效果调到合适状态

左侧 `Details` 面板中可读到的材质基础设置为：

- `Material Domain = Surface`
- `Blend Mode = Translucent`
- `Shading Model = Unlit`
- `Two Sided` 未开启
- `Use Material Attributes` 未开启
- `Cast Ray Traced Shadows` 已开启
- `Subsurface Profile = None`

Translucency 区域当前可见设置为：

- `Screen Space Reflections` 未开启
- `Contact Shadows` 未开启
- `Lighting Mode = Volumetric NonDirectional`
- `Directional Lighting Intensity = 1.0`
- `Apply Fogging` 已开启
- `Apply Cloud Fogging` 未开启

底部统计信息可直接读到：

- `Base pass shader without light map: 148 instructions`
- `Base pass vertex shader: 310 instructions`
- `Texture samplers: 3/16`
- `Texture Lookups (Est.): VS(0), PS(3)`
- `Shader Count: 4`
- `Preshaders: 3 (3 param fetches, 5 ops)`

这张图表达的重点是：`M_IceGround` 被设置成一个 `Translucent + Unlit` 的表面材质，后续要加入的裂纹、位移和纹理效果都将建立在这个地面冰材质框架上
该图切到浏览器搜索结果页，说明教程在实现冰面材质时额外查找了 `Parallax Occlusion Mapping` 与 `Bump Offset` 的参考案例，用来比较不同伪位移/视差表现

当前可直接确认的页面信息有：

- 浏览器打开的是 Google 图片搜索
- 搜索关键词包含 `parallax occlusion mapping`
- 另一个标签页标题可见 `bump offset`
- 搜索结果顶部标签包含 `Unreal`、`Ue4`、`Normal mapping`、`3ds max`、`Shader`、`Displacement mapping`、`Bump mapping`

右侧预览面板当前选中的参考图为：

- 来源：`BlenderNation`
- 标题：`Setting up Parallax Occlusion Mapping using Shader Nodes - BlenderNation`
- 预览图内容是一块带明显高低起伏错觉的平面材质

当前可见的结果卡片还包括：

- `UE5 Parallax Occlusion Mapping`
- `Parallax Mapping | Babylon.js Documentation`
- `Old UE4 Wiki` 相关 `Parallax Occlusion Mapping`
- 多张地面、石块、砖面和高度图的视差映射对比图

这张图的作用不是给出 UE 材质参数，而是说明教程在制作 `M_IceGround` 时，有意识地参考了 `Parallax Occlusion Mapping`、`Parallax Mapping` 和 `Bump Offset` 这些与表面深度错觉相关的方法，帮助决定冰面纹理应该用怎样的位移/深度表现
该图继续停留在浏览器参考检索，但关键词已经切换到 `bump offset`。教程在这里进一步缩小参考范围，专门查 Unreal 材质里用高度图制造浅层视差错觉的实现案例

当前可直接确认的页面信息有：

- Google 图片搜索框中的关键词为 `bump offset`
- 顶部相关标签包含 `Texture coordinate`、`Decal`、`Texture coordinates`、`Bump map`、`Parallax occlusion mapping`、`Parallax mapping`、`Epic developer`、`Parallax effect`

右侧预览面板当前选中的参考图为：

- 来源：`Benjamin Ford`
- 标题：`Benjamin Ford - Crystal using Bump Offset Material`
- 预览图内容是一套 Unreal 材质节点与紫色水晶效果示例

当前可见的搜索结果还包括：

- `Working with Bump Offset (Parallax) - UE4`
- `Bump Offset - Rendering - Epic Developer Community Forums`
- `How to use BUMP OFFSET in Unreal Engine`
- `UE4 Bump Offset (Parallax Maps)`
- `Bump Offset Node | 5-Minute Materials [UE4]`
- `Parallax with Bump Offset in UE5`

这张图说明教程已经从泛化的 `Parallax Occlusion Mapping` 参考，进一步聚焦到 Unreal 里更常用、更轻量的 `Bump Offset` 做法。对于地面冰材质而言，这意味着后续更可能采用贴图驱动的浅层视差/深度错觉，而不是真正高成本的几何位移

### 00:13:07-00:17:46 Clamp、Texture、PS

- 本段定位：Clamp、Texture、PS。
- 知识点：在Pit上 需要再說,但我们先從BumpUpSet开始 需要展示 它的用途 我们先看看材料 首先,让我展示给你们看 这是BumpUpSet的Node。
- 知识点：它需要什么 这是它的指定位置 这是它的DisplacementTexture,不是Texture。
- 知识点：是黑和白的價值,我们要调整 我们要调整它的Depth和它的Value 我们要调整它的Depth和Value 让我展示给你们看 需要用1的Value来调整它的Displacement。
- 知识点：整个Texture 所有的指定位置都会变動 所以需要有1的Value在整个空间 4的Value是它的力量 我们要调整它的Displacement。
- 知识点：让我展示给你们看 我们有它的指定位置 需要用某些Texture 我们先把第一个Texture变成Galaxy。
- 知识点：让我看看 我们需要调整它的Depth和Value 如果调整到正面 它会变成在我们面前 这里是2 现在它变成了2 但很難看 我们要调整到-2。
- 知识点：现在我们有它的Depth 这是1的Layer 需要用2的Layer来调整 需要用一樣的Layer 把BumpUpSet写上 只要我改变,让它变成了某种的Spiral。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Texture`。

**关键画面：**

该图继续停留在浏览器的 `parallax occlusion mapping` 图片搜索页，但这次右侧预览聚焦在石板地面的深度错觉案例。教程在这里显然是在观察地面材质使用视差遮挡后，裂缝与石块边界会产生怎样的层次感

当前可直接确认的页面信息有：

- 搜索关键词仍是 `parallax occlusion mapping`
- 页面中可见大量地面、砖面、石块、材质节点图和高度图相关结果
- 左上区域还能看到 `Normal Mapping / Parallax Mapping / +Occlusion Mapping` 的对比图

右侧预览面板当前选中的参考图为：

- 来源：`Blender Artists`
- 标题：`Parallax Occlusion Mapping and POM Rooms in Blender - Blender Tests - Blender Artists Community`
- 预览图内容是石板路表面的前后对比，能明显看到裂缝和石块间隙的深度差异

当前可见的其它结果还包括：

- `Parallax mapping - Wikipedia`
- `Parallax Occlusion Mapping - Old UE4 Wiki`
- `Unreal Engine 5 - Parallax Occlusion Mapping`
- 多张地面砖缝、石块、雪地和节点图的视差映射案例

这张图的用途是帮助判断地面冰材质是否需要类似石板缝隙那样的表面深度错觉。就教程目标而言，它是在借真实地面材质案例来评估冰裂纹和凹凸层在平面上的可读性
该图回到 UE 材质编辑器，当前在 `M_IceGround` 中演示 `BumpOffset` 与 `Texture Sample` 的连接方式。教程用一张明显的彩色星云贴图来测试视差偏移效果，从而直观看到 UV 被推移后的变化

节点定义集

- `Constant`：左侧常量节点，当前值为 `1.0`
- `BumpOffset`（上方）：接收高度输入并输出偏移后的 UV
- `Texture Sample`（上方，当前选中）：采样彩色贴图并在预览平面上显示
- `BumpOffset`（下方）：另一组同类偏移节点，当前只露出上半部分
- `Texture Sample`（下方）：与下方 `BumpOffset` 配对的贴图采样节点，当前处于 `Previewing`

连线集

- `Constant(1.0) -> BumpOffset.Height`
- `BumpOffset`（上方）输出 -> `Texture Sample`（上方）`UVs`
- 下方同样存在一组 `BumpOffset -> Texture Sample` 的连接关系

设置/参数

- 当前材质图表位置：`M_IceGround > Material Graph`
- 上方 `BumpOffset` 当前可读参数：
- `Coordinate = 0`
- `HeightRatioInput = -1.0`
- 左侧 `Texture Sample` 详情面板可读到：
- `MipValueMode = None (use computed mip level)`
- `Sampler Source = From texture asset`
- `Automatic View Mip Bias` 已开启
- `Const Coordinate = 0`
- `Texture = T_GalaxyBackground`
- `Sampler Type = Color`

输出/预览

- 左侧预览窗当前正在 `Previewing MaterialExpressionTextureSample_0`
- 预览平面上清楚显示一张紫蓝色星云贴图，说明此时教程用高对比、高色彩纹理来测试 `BumpOffset` 的偏移效果
- 底部统计区当前可见：
- `Texture samplers: 0/16`
- `Texture Lookups (Est.): VS(0), PS(3)`
- `Shader Count: 0`
- `Preshaders: 3 (3 param fetches, 5 ops)`

这一步的核心是在 UE 材质里验证：`BumpOffset` 影响的不是纹理内容本身，而是贴图采样时的 UV 坐标。教程先用一张很夸张的 `T_GalaxyBackground` 做测试，是为了更容易观察深度偏移、正负值和强度变化的视觉结果
该图继续在 `M_IceGround` 的材质图中演示 `BumpOffset` 的用法，不过这次已经不只是单独预览一张测试贴图，而是把两组偏移后的贴图结果送进 `Max` 节点进行合成

节点定义集

- `BumpOffset`（上方）：第一组 UV 偏移节点
- `Texture Sample`（上方，当前选中）：采样一张螺旋/星系状贴图
- `BumpOffset`（下方）：第二组 UV 偏移节点
- `Texture Sample`（下方）：采样另一张纯色/深色贴图
- `Max`（中间）：把上下两路贴图结果按逐像素最大值合并
- `Max`（右侧，当前处于 `Previewing`）：继续与上方另一输入做第二次最大值合成

连线集

- `BumpOffset`（上方）输出 -> `Texture Sample`（上方）`UVs`
- `BumpOffset`（下方）输出 -> `Texture Sample`（下方）`UVs`
- `Texture Sample`（上方）输出 -> `Max`（中间）输入 `A`
- `Texture Sample`（下方）输出 -> `Max`（中间）输入 `B`
- `Max`（中间）输出 -> `Max`（右侧）输入之一
- 上方另一条链路输出 -> `Max`（右侧）另一输入

设置/参数

- 下方 `BumpOffset` 当前可读参数：
- `Coordinate = 0`
- `HeightRatioInput = -3.0`
- 左侧 `Texture Sample` 详情面板可读到：
- `MipValueMode = None (use computed mip level)`
- `Sampler Source = Shared: Clamp`
- `Automatic View Mip Bias` 已开启
- `Const Coordinate = 0`
- `Texture = T_Spiral12`
- `Sampler Type = Color`

输出/预览

- 左侧预览窗当前显示一张白色旋涡中心向外爆开的紫蓝色螺旋图，说明 `Texture Sample` 正在预览 `T_Spiral12`
- 中间图中下方贴图预览为深蓝纯色块，上方贴图预览为白色旋涡纹理
- 右侧 `Max` 节点标记为 `Previewing`，说明教程正在观察两路偏移纹理合成后的结果
- 字幕提到“在 0.25 的位置，它会在前面”，说明此处正在讨论偏移后前后层次的可见差异

这张图表达的重点是：教程不仅在测试单张贴图的 `BumpOffset`，还在尝试把多层经过不同偏移的纹理叠加起来，以构造更复杂的地面冰层深度错觉与纹理层次

### 00:17:46-00:22:36 UV、速度、透明度

- 本段定位：UV、速度、透明度。
- 知识点：它通常会增加Depth 越来越遠 这就是我们說的Depth 你看,它可能是一张卡 或者可以在这张卡上 创建一个效果 看,是一个雕塑 所以它馬上会產生这个东西。
- 知识点：我们把它轉移到透明度 然后看,我们也可以增加 这个Density,到5 哦,这就是它 很酷的效果 你甚至可以这樣创建 可以在这张卡上 选择一个不同的效果。
- 知识点：可以只设置一个 constant value 所以如果我们只是想 把它轉移,看 它就在那里 轉移 但需要它会在时间內轉移 这就是我们的速度。
- 知识点：它会轉移 我还想它会在这个空间 轉移UV的位置 让这个质感动画得很好 我们现在来做 这是UV的位置,需要從中间操作 设置UV 然后需要设置质感的位置。
- 知识点：这是一个Sine wave Sine wave從0到1 现在需要把它remap remap是一件事 例如,现在價值 從0到1 但需要把它從0.8到1。
- 知识点：因为如果我们 把这些價值轉移 它会变得很奇怪 需要设置小價值轉移 这里它应该是在規格 或是 需要它变得更大 需要把它從1到8到2 0.5到1。
- 知识点：我还加了一个小动画 可以增加它的 最小的大小 这就是你能设置的动画 所以我深深地设置了 这些设置 可以做这个用3D物品 看看它是如何看上去。
- 核对对象：`速度`、`透明度`。

**关键画面：**

该图继续在 `M_IceGround` 材质中调试 `BumpOffset` 多层合成。相比上一张，这里能更完整看到两组偏移纹理如何通过两级 `Max` 节点并入材质主链，用来构造地面冰层的深度错觉

节点定义集

- `BumpOffset`（上方）：第一组 UV 偏移节点
- `Texture Sample`（上方）：采样螺旋/星爆样式贴图
- `BumpOffset`（下方）：第二组 UV 偏移节点
- `Texture Sample`（下方）：采样深蓝纯色贴图
- `Texture Sample`（右上局部可见）：第三组贴图输入，预览为黑白放射状纹理
- `Max`（中间）：把上方与下方两路贴图结果做最大值合并
- `Max`（右侧，当前 `Previewing`）：再把中间结果与右上纹理链做第二次最大值合并
- `Material Output`：右侧主材质输出节点，可见 `Base Color`、`Emissive`、`Opacity` 等输入端口

连线集

- `BumpOffset`（上方）输出 -> `Texture Sample`（上方）`UVs`
- `BumpOffset`（下方）输出 -> `Texture Sample`（下方）`UVs`
- `Texture Sample`（上方）输出 -> `Max`（中间）输入 `A`
- `Texture Sample`（下方）输出 -> `Max`（中间）输入 `B`
- `Max`（中间）输出 -> `Max`（右侧）输入之一
- 右上 `Texture Sample` 链路输出 -> `Max`（右侧）另一输入
- `Max`（右侧）输出继续送往右侧材质主链

设置/参数

- 上下两组 `BumpOffset` 当前都能读到：
- `Coordinate = 0`
- `HeightRatioInput = -3.0`
- 左侧 `Details` 面板可见材质基础设置仍为：
- `Material Domain = Surface`
- `Blend Mode = Translucent`
- `Shading Model = Unlit`
- `Use Material Attributes` 未开启
- `Cast Ray Traced Shadows` 已开启
- `Lighting Mode = Volumetric NonDirectional`
- `Directional Lighting Intensity = 1.0`

输出/预览

- 左侧预览窗当前仍显示一张紫蓝色爆散/星系状纹理，表明教程还在用高对比测试图验证偏移效果
- 中间上方贴图预览为白色旋涡，下方贴图预览为深蓝纯色块，右上局部预览为黑白放射纹理
- 底部统计仍可见：
- `Texture samplers: 0/16`
- `Texture Lookups (Est.): VS(0), PS(3)`
- `Shader Count: 0`
- `Preshaders: 3 (3 param fetches, 5 ops)`

这张图说明教程正在把多张带不同结构的测试贴图叠成一个更复杂的视差输入结果，以观察当透明、UV 偏移和前后层次一起作用时，冰面材质会不会出现更有趣的空间感
该图展示 `M_IceGround` 中开始加入 UV 动画与时间控制的阶段。教程把 `BumpOffset` 不再当作静态深度测试，而是接入旋转、平移和正弦时间函数，让冰面纹理在材质中产生动态流动感

节点定义集

- `DebugTimeSine`：当前选中的材质函数调用节点，输出一个基于时间的正弦结果
- `ScaleUVsByCenter`：按中心缩放 UV 的函数节点
- `TexCoord[0]`（上方）：第一组基础 UV 坐标
- `Time`：引擎时间输入
- `Multiply(0.25)`：把时间值缩放到较慢速度
- `Rotator`：根据时间旋转 UV
- `BumpOffset`（中间）：接收经缩放后的 UV，并使用高度图做偏移
- `Texture Sample`（中右）：采样白色旋涡纹理
- `TexCoord[0]`（下方）：第二组基础 UV 坐标
- `Panner`：让 UV 按速度持续平移
- `BumpOffset`（下方）：下方链路的偏移节点
- `Texture Sample`（右下）：下方链路对应的贴图采样

连线集

- `DebugTimeSine.Result ->` 正在准备连接到新的数学/重映射节点
- `TexCoord[0]`（上方） -> `Rotator.Coordinate`
- `Time -> Multiply(0.25) -> Rotator.Time`
- `Rotator` 输出 -> `ScaleUVsByCenter.UVs`
- `ScaleUVsByCenter.UVs` 输出 -> `BumpOffset.Coordinate`
- `BumpOffset`（中间）输出 -> `Texture Sample`（中右）`UVs`
- `TexCoord[0]`（下方） -> `Panner.Coordinate`
- `Panner` 输出 -> `BumpOffset`（下方）`Coordinate`
- `BumpOffset`（下方）输出 -> `Texture Sample`（右下）`UVs`

设置/参数

- 中间 `BumpOffset` 当前可读参数：
- `HeightRatioInput = -3.5`
- `Multiply` 节点当前常量值为 `0.25`
- `Panner` 当前速度可读为：
- `Speed X = 0.015`
- `Speed Y = 0.025`
- 左侧 `Details` 面板当前选中材质函数：
- `Material Function = DebugTimeSine`

输出/预览

- 左侧预览窗仍显示紫蓝色爆散纹理，说明当前动画控制仍在使用高对比测试贴图观察变化
- 底部统计当前可见：
- `Base pass shader without light map: 201 instructions`
- `Base pass vertex shader: 315 instructions`
- `Texture samplers: 4/16`
- `Texture Lookups (Est.): VS(3), PS(3)`
- `Shader Count: 4`
- `Preshaders: 3 (3 param fetches, 5 ops)`

这张图的关键是：教程开始把材质里的深度错觉与 UV 动画绑定起来。旋转、平移和正弦时间函数共同作用后，冰面纹理不再只是静态的凹凸，而会出现持续运动和节奏变化
该图回到 `M_IceGround` 材质总览状态。左侧预览平面已经变成纯黑，说明教程在这一刻关闭了前面用于调试的夸张测试纹理或当前链路结果，使材质暂时失去可见颜色输出，转而准备进入下一段更正式的 UV 处理

当前可直接确认的画面信息有：

- 当前材质仍为 `M_IceGround`
- 左侧预览平面显示为纯黑色矩形
- 中央材质图当前缩得很远，只能看到一条很细的主链结构

左侧 `Details` 面板可确认材质基础设置仍保持：

- `Material Domain = Surface`
- `Blend Mode = Translucent`
- `Shading Model = Unlit`
- `Two Sided` 未开启
- `Use Material Attributes` 未开启
- `Cast Ray Traced Shadows` 已开启
- `Lighting Mode = Volumetric NonDirectional`
- `Directional Lighting Intensity = 1.0`
- `Apply Fogging` 已开启

底部统计当前可见：

- `Base pass shader without light map: 148 instructions`
- `Base pass vertex shader: 310 instructions`
- `Texture samplers: 3/16`
- `Texture Lookups (Est.): VS(0), PS(3)`
- `Shader Count: 4`
- `Preshaders: 3 (3 param fetches, 5 ops)`

这张图的意义在于阶段切换：前面用于验证 `BumpOffset`、速度和透明度的测试链路已经告一段落，教程接下来将从这个基础材质框架继续进入更正式的 UV 与模糊处理，而不是继续停留在高对比测试图的可视化阶段

### 00:22:38-00:27:19 UV

- 本段定位：UV。
- 知识点：我们要怎麼做? 需要把这个质感 把它削掉 Ctrl C,Ctrl V 把它叫做Blur 我们不会直接改变它 在物品设计上Blur它 可以在这里做到。
- 知识点：首先需要做Load Bios 把它降到这个大小 5和12x512像这樣 在这里可以选择如何把它Blur更加深 这里是Blur,现在是Blur。
- 知识点：它非常Blur 我们也会把它儲存 之后再說 2. 让我们把深度的位置做深度 需要用一个质感 把它削掉,再用另一个 这是它的高度 这是它的质感。
- 知识点：它是用来做Bump Offset 来做调整的 我忘了解了 Bump Offset 有趣的是 在这个高度上 需要把它设置为1 例如0.5 可以让它变得更顯着。
- 知识点：现在它在整个範圍中轉移 需要把它轉移 可以用这个 光影 它是柔軟的 它在这里设置 现在它只在 白色的位置轉移 如果我把它设置为增加 它会变成相反。
- 知识点：而黑色的位置 它不会变成相反 所以可以设置 它的位置轉移 这个方式 我们设置了Bump Offset的深度 但我们看到了一些弧形 这就是Bump。
- 知识点：Offset的問題 而Parallax做得更好 特别是我们设置这樣的质感 Bump Offset很好 我们只设置这樣 这很酷 但质感不太好。

**关键画面：**

本图是 `Stylized_IceSpikes` 场景中的效果预览，用来说明当前讨论的冰刺地面材质会作用在实际特效镜头里，而不是在 Substance Designer 中直接改原纹理

- 当前视口显示一排由近到远延伸的蓝白色冰刺，主体从画面右侧前景斜向左后方展开，冰刺边缘半透明并带有高亮
- 场景中同时可见大量雪花状粒子和星点状发光颗粒，说明该材质最终会和 Niagara 粒子特效一起组成冰刺攻击镜头
- 顶部标签可见当前工程同时打开了 `NS_IceSpikes`、`T_Crack_02` 和 `M_IceGround`，与正文“复制原纹理后做一个 Blur 版本，再用于后续深度/UV 调整”的讲解一致
- 左下角内容浏览器定位在 `Content/VFX_Library/Textures/Others`，当前目录内可见多张地面裂纹、六边形和背景纹理缩略图，表示后续要从现有纹理派生出新的模糊版本，而不是从零重画
- 右下角 `Details` 面板当前选中的是 `PointLight`，用于照亮冰刺模型；本图重点不是灯光参数，而是确认材质已经挂到实际场景里并能在镜头中看到地面/冰刺的整体质感
本图演示 `M_IceGround` 中最基础的一条 `BumpOffset` 测试链：先用灰度纹理提供高度，再用偏移后的 UV 去采样彩色纹理，借此观察浅层视差效果

节点定义集
- `Texture Sample`（左）：纹理为 `T_Glow3`，`Sampler Type = Color`，输出使用 `R` 通道作为高度图输入
- `Constant`：数值为 `1.0`，放在 `BumpOffset` 下方，画面中未见连线，说明此时只是备用常量或准备参与后续高度强度调试
- `BumpOffset`：`Coordinate = 0`，`HeightRatioInput = -0.5`，`Height` 端接收左侧灰度纹理的 `R`
- `Texture Sample`（右）：用于预览被偏移后的彩色纹理，缩略图是一张星云/银河风格贴图

连线集
- 左侧 `Texture Sample.R` -> `BumpOffset.Height`
- `BumpOffset` 输出 UV -> 右侧 `Texture Sample.UVs`

设置/参数
- 当前示例用单通道灰度纹理充当高度图，白亮区域代表位移较强的位置
- `HeightRatioInput = -0.5` 表示先用较浅的负向偏移测试表面凹凸方向，和正文里“把高度设成 1、0.5 等数值看效果变化”的讲解一致
- 左侧预览窗标题显示 `Previewing MaterialExpressionTextureSample_5`，说明讲解重点仍是观察纹理与偏移关系，而不是完整材质输出

输出/预览
- 左侧预览球展示的是高度纹理本身
- 右侧 `Texture Sample` 预览的是被 `BumpOffset` 扭动后的彩色贴图，用于快速比较不同高度比例下的伪深度效果
本图展示把裂纹高度贴图和可调强度参数拆开准备接入材质的中间状态，重点是先建立“高度纹理 + 标量参数”的控制入口

节点定义集
- `Scalar Parameter`：参数名显示为 `Param`，`Default Value = 0.0`，`Slider Min = 0.0`，`Slider Max = 0.0`
- `Texture Sample Parameter2D`：参数名为 `T_Crack_Height`，缩略图是一张黑底亮裂纹纹理，用来提供冰面裂缝的高度/遮罩信息

连线集
- 当前画面中两者尚未接线，说明这一帧是在讲“先把控制参数放进来，再继续接到后续 BumpOffset 或其他高度处理节点”

设置/参数
- 左侧 `Details` 面板表明当前选中的是 `Scalar Parameter`，教程正在把高度强度从写死数值改成可调参数，方便后面反复试 `0`、`0.5`、`1` 一类深度值
- 因为 `Default Value = 0.0`，这一帧更像是参数初始化而不是最终效果调好后的状态
- 底部统计为 `Base pass shader without light map: 148 instructions`、`Base pass vertex shader: 310 instructions`、`Texture samplers: 3/16`，说明此时材质仍处于较早期的搭建阶段

输出/预览
- 左侧预览模型是纯黑六边形平面，表示当前被预览的输入在默认值下尚未产生可见亮度或颜色贡献
- 右侧 `T_Crack_Height` 缩略图可见细裂纹分布，说明后续会把这张纹理接入高度或位移链，用来限定只有裂缝区域发生明显的 Bump Offset 变化

### 00:27:19-00:32:10 UV

- 本段定位：UV。
- 知识点：这是我们的主要质感 我立刻设置一个设置 这个不是滑動 但它会加上,我们稱之为 氧氣的质感 需要用这个標準的质感 然后把它轉移到UV 我还在用全球控制。
- 知识点：把它轉移到这里 然后需要加上这些东西的價值 现在可以设置 一个大小的质感 可以设置一个 全球的质感 然后把它轉移到UV 可以從这些东西开始。
- 知识点：现在我们把它轉移到这里 需要看着它会怎樣 这是我们的主要质感 这里它是 需要慢慢地加深度 用这些东西和我们的泵渦 我们需要什么?我们用泵渦。
- 知识点：我们用標準的EV 我们用这个 这个质感 我们用这个 这个质感 我们用这个 这个價值 我们把第一次泵渦轉移到这里 所以它馬上轉移到我们身上 是嗎?。
- 知识点：第一層完成了 轉移可能不需要 但它是显示的 看到嗎? 它是怎樣的? 第一層已经在这里了 它已经在主要的层面上了 需要在这裏製造 十、十二層。
- 知识点：每層都会減少它的透明性 所以它们都会減少它的透明性 我们现在来看看 每層的層次都会变化 会有更多的轉移 所以 这層会有002 那層会有004。
- 知识点：需要继续加深它的轉移 需要把这些泵渦轉移到这里 然后把它们变成10 所以1234 第五 第六 第七 第八 第十 第十九 第十十九 第十十九 第十九。

**关键画面：**

本图是 `M_IceGround` 材质图里 `UV` 注释框的远景定位，用来说明教程开始把裂纹高度贴图接入一条专门的 UV 处理链，而不是继续只看单个 `BumpOffset` 节点

节点定义集
- `Texture Sample Parameter2D`：左下与右侧各有一个 `T_Crack_Height` 节点，缩略图都是黑底亮裂纹纹理
- `UV` 注释框：框内有一条从左到右的简短节点链，最终输出到一个蓝色的小型结果节点，表示这里在单独处理某一层裂纹的 UV 偏移
- 画面中央偏左还有一个绿色标量参数节点，但当前缩放过远，参数名不可可靠辨认

连线集
- 远景可见 `UV` 注释框内部已经有多段从左向右串联的连线
- 注释框外部的 `T_Crack_Height` 节点与中央节点当前未见完整接线端点，无法仅凭本图确认它们是否已正式并入这条链路

设置/参数
- 左侧 `Details` 面板当前选中的是 `T_Crack_Height`，说明教程此时正在围绕裂纹高度纹理建立新的控制层
- 底部统计仍为 `148` / `310` 指令、`3/16` 采样器，表示这张图对应的阶段还没引入更多采样负担
- 左侧预览平面保持纯黑，说明当前镜头主要用于展示节点布局和模块分层，不是最终可视效果

输出/预览
- 这张图的主要信息是“在材质图中新增一层以 UV 为核心的裂纹处理模块”
- 由于缩放很远，框内节点名和参数值不能完全确认；可靠信息仅限于该模块存在、链路已初步串起，并与 `T_Crack_Height` 相关
本图展示裂纹高度纹理的第一层 UV 偏移接法：把原始 `UV` 和一个很小的偏移参数送入 `BumpOffset`，再用偏移后的 UV 去重新采样 `T_Crack_Height`

节点定义集
- `Texture Sample Parameter2D`（左下）：参数名 `T_Crack_Height`，作为当前层的原始裂纹高度纹理输入
- `Scalar Parameter`：参数名 `Offset`，节点标题显示 `Param (0.02)`，`Default Value = 0.02`
- `UV`：一个独立的 UV 输入节点
- `BumpOffset`：中间主节点，用来把高度纹理转换成 UV 偏移
- `Texture Sample Parameter2D`（右上）：第二个 `T_Crack_Height`，用于接收偏移后的 UV 并得到这层的裂纹采样结果
- 右侧中下方另外还有两张 `T_Crack_Height`，当前画面里尚未接线，说明教程准备继续叠更多层

连线集
- `UV` -> `BumpOffset.Coordinate`
- 左下 `T_Crack_Height.R` -> `BumpOffset.Height`
- `Offset` -> `BumpOffset.HeightRatioInput`
- `BumpOffset` 输出 -> 右上 `T_Crack_Height.UVs`

设置/参数
- 这一层的偏移强度明确设为 `0.02`，与字幕“this one will have 002”一致
- 左下 `T_Crack_Height` 的 `UVs` 槽仍是 `0`，表示它先提供未经偏移的基础裂纹分布
- 底部统计增加到 `158` / `315` 指令，`Texture samplers: 3/16`，说明只是增加了运算，没有增加新的纹理资产种类

输出/预览
- 左侧预览平面可见黑底白裂纹，说明当前预览的是裂纹高度图本身
- 这一层的作用是生成“第一份发生了轻微错位的裂纹采样结果”，为后续多层叠加制造厚度与层次变化
本图展示教程把同一种裂纹偏移方法复制成多层，形成纵向排列的多组 `UV -> BumpOffset -> T_Crack_Height`，以便后面给每层设置不同错位量并叠出冰面深度

节点定义集
- 左侧从上到下可见多枚 `UV` 节点，每一层各自提供一份基础 UV
- 中间有多枚 `Add` 节点，位于若干 `UV` 与 `BumpOffset` 之间，用于在送入 `BumpOffset` 之前继续给 UV 叠加偏移
- 右侧纵向排列了多枚 `BumpOffset`，其后分别连接对应的 `T_Crack_Height`
- 每个 `BumpOffset` 右边都有一张 `T_Crack_Height`，表示每层都会得到一份单独错位后的裂纹采样
- 当前选中的 `Add` 节点标题为 `Add(0,1)`，左侧 `Details` 面板显示 `Const A = 0.0`、`Const B = 1.0`

连线集
- 每层的 `UV` 都会先进入本层 `Add` 或直接进入本层 `BumpOffset.Coordinate`
- 每层 `BumpOffset` 输出再进入对应 `T_Crack_Height.UVs`
- 由于截图取景只覆盖中下部，最上层若干线的完整起止点未全部呈现，但可以可靠确认这是并排复制的多层同构链路

设置/参数
- 底部两层可清楚看到 `BumpOffset.HeightRatioInput = 0.05`
- 中上部的 `BumpOffset` 参数区被部分遮挡，无法仅凭本图确认它们是否也全是 `0.05`，但教程意图明确是在逐层增加或调整偏移
- 这一阶段底部统计保持 `158` / `315` 指令、`3/16` 采样器，说明仍在复用同一张裂纹纹理，通过 UV 运算制造层次

输出/预览
- 左侧预览平面依旧是黑底白裂纹，但裂纹宽窄与亮度层次比上一张更丰富，说明多层错位采样已经开始形成复合结构
- 这一步的结果是为后续 `Lerp`、`Multiply`、`Add` 等混合操作准备好多份不同 UV 偏移的裂纹输入

### 00:32:10-00:34:26 Lerp、Multiply、Add

- 本段定位：Lerp、Multiply、Add。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Lerp`、`Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：together. Here. This add to this one. Then.。
- 核对对象：`Lerp`、`Multiply`、`Add`。

**关键画面：**

本图展示在多层裂纹 `BumpOffset` 链之间加入 `Add`，让每一层的 `UV` 在进入 `BumpOffset` 前先叠一个额外位移值，从而把多层裂纹进一步错开

节点定义集
- 左上可见一个偏移参数节点，节点下方显示 `Value 0.02`
- 左侧从上到下排列了多枚 `UV` 节点，每层各自送出基础 UV
- 中间纵向分布多枚 `Add`，其中当前选中的一枚标题为 `Add(0,1)`
- 右侧每一层仍由 `BumpOffset` 接对应的 `T_Crack_Height` 组成，延续上一段的多层裂纹采样结构

连线集
- 每层 `UV` 先进入本层 `Add` 的一个输入
- 偏移参数节点通过多条长连线分发到多层 `Add`，为各层提供统一或递增的位移基准
- `Add` 输出再进入本层 `BumpOffset.Coordinate`
- 各层 `BumpOffset` 输出继续进入右侧各自的 `T_Crack_Height.UVs`

设置/参数
- 当前选中的 `Add` 在左侧 `Details` 面板中显示 `Const A = 0.0`、`Const B = 1.0`
- 画面中部和下部两枚 `BumpOffset` 的 `HeightRatioInput` 仍清楚可见为 `0.05`
- 底部统计维持 `158` / `315` 指令、`3/16` 采样器，说明这一阶段主要增加的是 UV 运算和组合关系

输出/预览
- 左侧预览平面仍是黑底白裂纹效果，但当前镜头重点已经从“单层偏移”转到“多层位移如何彼此错开”
- 这一步的作用是为后面使用 `Lerp`、`Multiply`、`Add` 混合多层裂纹结果做准备
本图是 `M_IceGround` 裂纹分层模块的远景总览，强调教程已经把“裂纹高度图 + 统一偏移参数 + 多层 Add/BumpOffset”复制成一整列可叠加的层级

节点定义集
- 左上有一张蓝色纹理参数节点，左下有一个绿色参数节点，分别作为裂纹纹理来源与统一偏移控制来源
- 中部从左到右可以看到多列重复结构：紫色小节点、黑色小节点、黄色/绿色渐变的 `BumpOffset`、蓝色 `T_Crack_Height`
- 这些节点按行排列成多层，每一行代表一份独立的裂纹错位采样

连线集
- 左侧两枚源节点分别向中部多层结构分发多条连线
- 每一行的中间节点都会接到对应 `BumpOffset`，再继续送入右侧蓝色纹理节点
- 由于缩放很远，具体某一行内部每条线的端点名称无法逐一可靠辨认，但可以明确确认这是规则复制的并行层结构

设置/参数
- 左侧 `Details` 面板此时显示的是材质本体设置：
  - `Material Domain = Surface`
  - `Blend Mode = Translucent`
  - `Shading Model = Unlit`
- 底部统计仍为 `158` / `315` 指令、`Texture samplers: 3/16`
- 这说明当前阶段主要是在已有材质设置下扩展裂纹层网络，而不是更改材质域或新增大量采样器

输出/预览
- 左侧预览平面上的裂纹已经呈现较复杂的粗细和亮度分布，说明多层采样已开始产生叠加效果
- 本图的关键作用是帮助读者定位整组网络在材质图中的规模和布局，而不是核对单个节点数值
本图展示把前面得到的多层裂纹采样开始送入 `Lerp` 做层间混合，当前镜头聚焦于“最后一层”的混合参数设置

节点定义集
- 左侧上下各有一张 `Texture Sample Parameter2D`，参数名都是 `T_Crack_Height`
- 右侧上下各有一枚 `Lerp(0,0.2)` 节点
- 当前选中的是下方 `Lerp`，左侧 `Details` 面板显示其为 `Linear Interpolate`

连线集
- 上方 `T_Crack_Height` 的输出连到上方 `Lerp`
- 下方 `T_Crack_Height` 的输出连到下方 `Lerp`
- 本图未展示 `Lerp` 右侧后续去向，也未完整显示 `Alpha` 输入来源，因此只能可靠确认“裂纹层已进入 Lerp 混合阶段”

设置/参数
- 当前选中的 `Lerp` 节点内部显示：
  - `A = 0.0`
  - `B = 0.2`
- 左侧 `Details` 面板进一步显示：
  - `Const A = 0.0`
  - `Const B = 0.2`
  - `Const Alpha = 0.5`
- 这表明教程正在用固定常量先搭出一层基础插值，再决定如何把两份裂纹结果融合

输出/预览
- 左侧预览平面仍维持黑底白裂纹外观，说明当前混合主要影响裂纹层之间的数值分布，而不是立即改变材质类型
- 本图标志着流程从“生成多份错位裂纹输入”推进到“开始对这些输入做插值混合”，为下一段的 `Multiply`、`Add` 组合做准备

### 00:35:05-00:37:12 Multiply、Add、PS

- 本段定位：Multiply、Add、PS。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 核对对象：`Multiply`、`Add`。

**关键画面：**

本图展示前面多层 `BumpOffset + T_Crack_Height + Lerp` 的结果开始通过多级 `Add` 逐层汇总，形成一张更亮、更厚、更接近最终遮罩的裂纹图

节点定义集
- 左侧仍是多层重复结构：多枚 `BumpOffset`、多张 `T_Crack_Height`、多枚 `Lerp`
- 中部到右侧出现一串串联的 `Add` 节点，把多路裂纹结果从左向右逐步累加
- 当前选中的是最右侧一枚蓝色 `Add` 预览节点
- 最右边可见 `Material Output`，说明这组累加结果已经接近材质主输出区域

连线集
- 每层 `T_Crack_Height` 结果先进入对应 `Lerp`
- 多个 `Lerp` 输出继续并入一串树状/链式 `Add`
- 当前选中的 `Add` 左侧接入多条来自前级 `Add` 的结果线，右侧尚未显示最终连到哪个材质槽位，但其位置已经紧邻 `Material Output`

设置/参数
- 左侧 `Details` 面板显示当前选中的 `Add` 仍是：
  - `Const A = 0.0`
  - `Const B = 1.0`
- 底部统计显示：
  - `Texture samplers: 0/16`
  - `Texture Lookups (Est.): VS(3), PS(1)`
  - `Shader Count: 0`
- 这表明当前预览焦点放在中间表达式结果，而不是完整材质最终编译状态

输出/预览
- 左侧预览画面标题为 `Previewing MaterialExpressionAdd_19`
- 预览中的裂纹边缘显著变粗、白色区域更强，黑白过渡里出现多层模糊条带，说明多路裂纹在相加后透明度/遮罩强度明显增大
- 与字幕“Transparency is still very large”一致，这一步是在观察累加后的遮罩是否过强，准备继续用 `Multiply` 或后续控制去压回合适范围
本图是 `M_IceGround` 裂纹合成网络的远景总览，当前预览对象切换成了 `Multiply`，表示教程开始在多层 `Add` 汇总之后，再用乘法去压缩或重新分配裂纹遮罩强度

节点定义集
- 左侧仍是一整列重复的裂纹生成结构：多枚 `BumpOffset`、多张 `T_Crack_Height`、中间若干 `Lerp`
- 中部到右侧是一串把这些层结果汇总起来的小型运算节点
- 右侧中部能看到一枚蓝色预览节点，对应当前被预览的 `Multiply` 表达式
- 最右侧依旧是 `Material Output` 纵向节点

连线集
- 多层裂纹输入先汇入中部一组连续的小型运算节点
- 这些结果继续向右送到当前的 `Multiply` 预览节点，再朝材质输出方向延伸
- 由于是远景图，`Multiply` 两个输入端分别来自哪些具体前级节点无法逐线可靠确认，但可以明确确认“乘法”已位于汇总链后段

设置/参数
- 左侧 `Details` 面板当前显示材质本体配置而不是单个表达式参数：
  - `Material Domain = Surface`
  - `Blend Mode = Translucent`
  - `Shading Model = Unlit`
  - `Lighting Mode = Volumetric NonDirectional`
- 底部统计仍显示：
  - `Texture samplers: 0/16`
  - `Texture Lookups (Est.): VS(3), PS(1)`
  - `Shader Count: 0`
- 说明这一帧仍是在表达式预览模式下审视中间结果

输出/预览
- 左侧预览标题显示 `Previewing MaterialExpressionMultiply_3`
- 裂纹依旧是亮白主脉络配合较宽的灰阶拖影，但整体比前一张的纯加总结果更集中在中心裂纹区域，表明乘法正在帮助收束过强的透明/遮罩范围
本图展示 `S09` 收束阶段更靠后的 `Add` 结果预览，此时前面的多层裂纹、插值和乘法调制已经被整合到一条更接近最终输出的遮罩链中

节点定义集
- 左侧保留若干层裂纹生成模块，可见多枚 `BumpOffset` 与多张蓝色纹理参数节点
- 中部是一串连续的小型运算节点，把多路结果逐步归并到右侧
- 当前选中节点是一枚靠近输出区的 `Add`
- 右侧依旧可见一枚蓝色中间预览节点以及 `Material Output`

连线集
- 多条来自左下和中部的结果线汇入当前这段收束链
- 当前选中的 `Add` 位于一串顺序相连的运算节点中，说明它不是单独处理某一路，而是在承接前面已经混合过的多路裂纹结果
- 选中 `Add` 的输出继续往右，朝蓝色中间节点与 `Material Output` 方向传递

设置/参数
- 左侧面板标题显示当前正在预览 `MaterialExpressionAdd_1`
- 底部统计此时变为：
  - `Texture samplers: 0/16`
  - `Texture Lookups (Est.): VS(3), PS(12)`
  - `Shader Count: 0`
  - `Preshaders: 15 (62 param fetches, 115 ops)`
- 与前两张相比，`PS(12)` 和 `Preshaders` 明显增加，说明到这一步时整条裂纹合成链的运算复杂度已经大幅上升

输出/预览
- 左侧预览标题为 `Previewing MaterialExpressionAdd_1`
- 预览中的白色主裂纹已经较为稳定，裂纹两侧保留柔和灰阶衰减和若干亮点纹理，整体更像最终要送往透明度或发光遮罩的合成结果
- 这一步说明教程已经把 `Multiply`、`Add` 调整到了可接受的裂纹层级分布，后续可以转向补充证据或更细的局部核对

## 补充视觉证据

### S01 00:02:27

本图是 `S01` 裂纹纹理节点图的补充近景，重点补足中段 `Blend -> Warp -> Blend` 链的参数和噪声来源

节点定义集
- 左侧输入是一张裂纹线稿结果图，画面中能看到其输出接入中间第一枚 `Blend`
- `Non Uniform Blur Grayscale`：位于左下，输出一张边缘较软的裂纹图，作为第一枚 `Blend` 的另一路输入
- `Blend`（中间第一枚）：把左侧两张裂纹结果合成，输出仍是黑底白裂纹图
- `Fractal Sum Base`：位于下方，输出灰度噪声，用作 `Warp` 的扭曲输入
- `Warp`：接收第一枚 `Blend` 的裂纹结果和 `Fractal Sum Base` 的噪声，对裂纹边界做形变
- `Fractal Sum 2` -> `Safe Transform Grayscale` -> `Blur HQ Grayscale`：位于底部，生成一张更柔和的大块灰度噪声
- `Clouds 2` -> `Blur HQ Grayscale`：位于右上，也是一条噪声生成支路
- `Blend`（右侧第二枚）：把 `Warp` 后的裂纹图与下方模糊噪声再次合成，得到更自然的裂纹明暗变化

连线集
- 左侧裂纹结果 + `Non Uniform Blur Grayscale` -> 第一枚 `Blend`
- 第一枚 `Blend` 输出 -> `Warp` 主输入
- `Fractal Sum Base` 输出 -> `Warp` 次输入
- `Warp` 输出 -> 右侧第二枚 `Blend` 的上方输入
- `Fractal Sum 2` -> `Safe Transform Grayscale` -> `Blur HQ Grayscale` -> 右侧第二枚 `Blend` 的下方输入
- 右上 `Clouds 2 -> Blur HQ Grayscale` 在当前画面中可见，但未完整显示其最终接入点，无法仅凭本图确认是否接到当前可见 `Blend`

设置/参数
- 右侧属性面板当前选中的是右侧第二枚 `Blend`
- `Blending Mode = Overlay`
- `Opacity = 1`
- `Cropping Area` 显示：
  - `Left = 0`
  - `Right = 1`
  - `Top = 0`
  - `Bottom = 1`
- 顶部可见当前图尺寸为 `2048 x 2048`

输出/预览
- 左上 2D 预览显示的是黑底白裂纹，裂纹边缘较细且存在轻微软化，说明当前阶段仍以生成干净的裂纹遮罩为主
- 这张补充图的作用是证明教程确实通过 `Overlay Blend`、`Warp` 和两类模糊噪声，让原始裂纹线稿产生更自然的弯曲和明暗起伏

### S04 00:14:05

本图是 `S04` 的补充证据，记录在 `M_IceGround` 材质图里给 `BumpOffset` 寻找并准备插入“位移纹理”节点的瞬间

节点定义集
- `BumpOffset`：当前画面中央唯一已放置的材质节点，能看到：
  - `Coordinate = 0`
  - `HeightRatioInput = 0.05`
- 节点搜索菜单：在材质图中央打开，顶部是搜索框，下面列出 `Atmosphere`、`Blends`、`Color`、`Constants`、`Coordinates` 等分类
- 左侧预览球当前为纯黑，表示这时还没有把有效纹理结果接到预览链上

连线集
- 当前画面中 `BumpOffset` 尚未接入任何可见连线
- 搜索菜单打开说明教程正在准备插入下一枚节点，而不是展示一条已完成的连接关系

设置/参数
- 左侧 `Details` 面板显示材质本体设置：
  - `Material Domain = Surface`
  - `Blend Mode = Translucent`
  - `Shading Model = Unlit`
  - `Lighting Mode = Volumetric NonDirectional`
- 底部统计为：
  - `Base pass shader without light map: 148 instructions`
  - `Base pass vertex shader: 310 instructions`
  - `Texture samplers: 3/16`
- 结合字幕 `This is the displacement texture`，可确认这里的操作意图是把一张位移/高度纹理接到 `BumpOffset` 相关链路中

输出/预览
- 这张图不是结果图，而是“开始插入位移纹理节点”的操作证据
- 可靠结论只有两点：当前使用的是 `BumpOffset`，且教程明确把下一步要接入的纹理视为位移纹理；搜索结果里具体选中了哪个节点，本图尚未显示

### S09 00:35:51

本图是 `S09` 多层裂纹 UV 偏移的参数补充证据，明确给出了统一偏移参数 `Offset` 的默认值，并显示它被分发到多层 `Add/BumpOffset` 链中

节点定义集
- `Texture Sample Parameter2D`：参数名 `T_Crack_Height`，其 `R` 通道向右分发到多层后续节点
- `Scalar Parameter`：参数名 `Offset`，节点标题显示 `Param (0.05)`，节点框内 `Default Value` 显示约为 `0.052`
- 左侧到右侧之间可见多枚 `UV` 节点、`Add` 节点与若干 `BumpOffset`
- 右侧下部可见至少一枚 `BumpOffset` 的彩色预览区，说明这一段仍是用同一个偏移参数驱动多层位移

连线集
- `T_Crack_Height` 的 `R` 输出通过多条长连线扇出到右侧不同层级
- `Offset` 参数也通过多条长连线同时分发给多层结构
- 每层 `UV` 与 `Offset` 一起进入本层 `Add` 或 `BumpOffset` 前级，再继续送往右侧对应的 `BumpOffset`
- 由于取景只覆盖中段，右侧各层最终的完整终点未全部显示，但“统一参数分发到多层”的结构是明确的

设置/参数
- 左侧 `Details` 面板显示当前选中的是 `Scalar Parameter`
- 可可靠读出的参数信息有：
  - `Parameter Name = Offset`
  - `Default Value = 0.05`
  - `Slider Min = 0.0`
  - `Slider Max = 0.0`
- 结合节点框上的 `Param (0.05)` 与字幕 `We set some small values for you`，可确认教程是故意给各层位移设置很小的偏移量，避免裂纹错位过度

输出/预览
- 左侧预览标题为 `Previewing MaterialExpressionMultiply_3`
- 预览中的裂纹呈现放射状拖影和较强的灰阶层次，说明这些小偏移值已经在多层叠加后产生明显的厚度变化
- 这张补充图的价值在于补足“多层裂纹位移所共用的核心参数到底是多少”这一关键信息

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。

