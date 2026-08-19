# 02 Aoe Magic Fire Breakdown

# 02 Aoe Magic Fire Breakdown

## 关键术语

- `Alpha`、`Dynamic Parameter`、`UV`、`Opacity`、`Normal`、`Decal`、`Houdini`、`VAT`、`Substance`、`Fire`、`Mesh`、`粒子`、`Niagara`、`EmberGen`、`Substance Designer`、`系统`、`Niagara System`、`Emitter`

## 分段知识

### 00:00:04-00:04:53 Alpha、Houdini、Substance

- 本段定位：Alpha、Houdini、Substance。
- 知识点：嘿,在这段影片中,需要展示如何创建我的变化 需要看看我用的Houdini和 Substance Designer的物品 来创建我的变化。
- 知识点：,磁場從中间移动 首先,我们来看看真實的效果 首先,你必须找到 首先,標準版本会像这个样子 磁場很直,我们来看看原本版本 它有各种控制的功能。
- 知识点：这是用来创建变化的 如果我把它打開,它不会再存在 还有磁場 这里它更加詳細,它会再创建这种东西 这是一个質料 用这个物品来创建 这里是那个質料。
- 知识点：我已经展示过了 我告訴你哪个頻道負責什么 这是主要的 还有另外一个 这里有其他缺點 我们来看看这个现象 我们来找一个裝飾 这是更詳細的版本,这是用来创建磁場。
- 知识点：来创建深度 这是透明度 这是濃度 这是轉移的alpha 它们会合成 这里有个有趣的點 可观察到 在磁場上,有不同的氣体,火 这里有这些不同的东西。
- 知识点：我把磁場打開 这里是磁場在蝴蝶的圖像中 磁場上有很多有趣的东西 现在我们来談談 我们来談談 我们来看看火 我只用一个火 可观察到它开始在这里。
- 知识点：慢慢地过去 我们如何取得这些磁場的位置? 我们用3D物件来取得它们 基本上,我们有一个3D物件 这里完全是不見了的 因为有些部分是向右方向的。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Houdini`、`Substance Designer`、`透明度`。

**关键画面：**

这一帧先给出最终 AOE 火焰地裂效果的真实示例，用来说明后续 Houdini、Substance 和 Substance Designer 的工作到底服务于什么结果

- 当前场景
  Unreal 视口处于 `Fire_AOE` 关卡
  角色站在画面中上部偏中位置
  地面围绕角色向外扩散出多条熔岩般的裂纹和火焰带
  裂纹整体从中心向四周分叉，亮黄色高温区域位于裂缝内部，外侧过渡到橙红色边缘
  多个火柱或火焰喷口沿圆周分布，说明这不是单一 decal，而是裂纹、地面中心效果和火柱共同叠加
- 时间线与对象
  下方 `Sequencer` 选中 `AOE`
  轨道下可见多条 `NS_FX_FirePillar01_*`
  同时可见 `NS_FX_GroundCenterCrack` 与 `NS_FX_GroundHit01`
  当前时间约 `5.60`
- 对后续制作的约束
  裂纹不是均匀粗细的环，而是从中心开始分岔的多条不规则路径
  亮部集中在裂缝内部，外围伴随更暗的烧灼地表和火花点缀
  说明后续贴图与 alpha 需要同时承担主裂纹形状、明暗分层和渐变推进，而不是只提供一张简单黑白遮罩
这一帧回到 Unreal 编辑器，重点不是看最终效果，而是确认地裂线上挂了哪些 Niagara 系统，以及这些系统如何按裂纹位置分别生成粒子和火焰

- 当前对象
  右侧 `Details` 选中 `NS_FX_GroundLineCrack`
  其下是 `NiagaraComponent0`
  右下可见 `Location ≈ (-2020.1, 326.0, 0.0)`
  `Scale = 1.0, 1.0, 1.0`
- 内容浏览器
  当前路径位于 `VFX_Library/Projects/MagicFireAOE`
  可见多个 Niagara 资源
  `NS_FX_FireSword`
  `NS_FX_FirePillar01`
  `NS_FX_FireSlash01`
  `NS_FX_FireSlash02`
  `NS_FX_FireSlash03`
  `NS_FX_GroundCenterCrack`
  `NS_FX_GroundHit01`
  `NS_FX_GroundLineCrack`
- 画面信息
  主视口中的裂纹本体几乎不可见，说明作者此时主要在单独检查地裂线系统的生成位置与构成
  字幕明确提到“Spawn on the crack different particles, fire”
- 可确认的制作结论
  地面裂纹并不是单个 Niagara 系统包办所有内容
  至少拆分出地裂线、中心裂纹、命中和火焰等独立系统
  然后把它们按裂纹路径或关键位置布置到关卡中
这一帧切到静态网格查看器，重点是说明裂纹路径本身不是只靠贴图推断，而是有一条实际的 3D 几何或样条状网格承载路径信息，并且顶点颜色已被记录下来供后续材质或特效读取

- 当前对象
  顶部标签显示对象为 `SM_FX_Anchor...`
  视口中只看到一条细长弯曲的线状网格
  主干自上向下延伸
  中部和下部各分出一条短支线
  轮廓与前面地面裂纹的分叉走势一致
- 左上统计
  `Triangles: 1320`
  `Vertices: 1330`
  `UV Channels: 1`
  `Distance Field: 126x126x7`
  说明这不是简单两三点的样条预览，而是已经生成过一定分段密度的可用网格
- 右侧信息
  `Material Slots` 只有 1 个材质槽
  当前材质是 `WorldGridMaterial`
  字幕明确提到“it has the colors of its vertices recorded”
- 可确认的制作结论
  这条裂纹路径网格除了提供空间形状，还记录了顶点颜色
  顶点颜色后续可用于控制沿路径的颜色分布、渐变权重、出现顺序或局部遮罩
  这也解释了为什么教程会把 Houdini 和 Substance 放进同一流程里
  一个负责生成可控路径和属性载体，另一个负责生成贴图与表面细节

### 00:04:53-00:09:49 Houdini、Substance、Substance Designer

- 本段定位：Houdini、Substance、Substance Designer。
- 知识点：色彩是在3D的色彩上写的 为甚麼? 为了让可以做出转换 可以用这些色彩的色彩 来做出一个慢慢的转换 首先它们会开始在这里 然后慢慢变成在这里。
- 知识点：它们從哪里来? 我们把它们錄製了 这Noda要用的位置 它们要用的色彩 我们要從哪里来處理? 在一种叫做殺死物質的Node 这就是它们的名字。
- 知识点：我们把它们拆除 如果我拿它们 它们都会在一个地方 我们不切任何东西 如果我慢慢地按鍵 我们就开始动画了 我们有了 色彩的色彩的色彩 这里 在这个色彩的色彩的色彩。
- 知识点：我们切掉最小的價值 在这里动画的东西 在一秒鐘內 我们用一條圆形的圖 来动画这些價值 它们都在动画 在这里 我们先把这些色彩 我们不需要的东西拆掉。
- 知识点：我们慢慢地拆掉 然后我们有一个階段 我们设置了这个位置 这是我们如何減少或增加 影响的大小 这里是0.6 如果我设置2 或1,它会有點縮小。
- 知识点：这就是可以改变大小 这里是它減少的地方 它是这里的特定的地方 因为它的色彩 所以它们都很好 这个位置也设置在这里 这里有一个位置 如果我把它拆掉。
- 知识点：它会是結果 它特别地移动了 它的方向是设置在这里 所以它们都会向上移动 我们也适当移动它们 这里也有一个減少的地方 色彩也慢慢地改变 它的位置也很動。
- 核对对象：`Houdini`、`EmberGen`、`Substance Designer`。

**关键画面：**

这一帧继续停留在裂纹路径网格查看器里，但画面已经从“有一条路径”推进到“这条路径上的属性会被用来做渐变过渡”

- 路径形状
  视口中是一条更完整的纵向裂纹主干
  从上到下有多处分叉
  右侧中上部、左侧中部、右侧中下部和左下部都能看到短支线
  整体比上一张更接近最终地裂从中心向外蔓延的布局
- 画面与字幕能确认的信息
  字幕明确说“to make a gradual transition. First they start here and gradually here”
  说明路径上记录的颜色或权重不是静态装饰，而是用于定义某种沿线推进的过渡
- 右侧与左上信息
  仍是单材质槽 `WorldGridMaterial`
  统计仍为 `1320` 个三角形、`1330` 个顶点、`1` 个 UV 通道
- 可确认的制作结论
  这条网格至少承担两层职责
  一层是空间路径本身
  另一层是沿路径分布的属性数据
  后续材质或 Niagara 可以读取这些属性，让裂纹、火焰或亮度从某一端开始，沿主干和分支逐步过渡到另一端
这一帧切到材质实例参数面板，说明作者没有完全依赖 EmberGen 新做火焰，而是先用现成材质，通过多层纹理、平移和扰动把火焰片调到可用状态

- 左侧预览
  视口中是一团竖直上升的火焰
  底部更宽更亮，顶部逐渐收窄并分成数个火舌
  背景是模糊的室外建筑场景，说明这里主要看材质动画而不是关卡布置
- 参数组 `01. Texture_01`
  `Texture_01_Tex = T_FX_TilingMask_VoronoiNoise01`
  `Texture_01_Emissive_Power = 1.0`
  `Texture_01_Emissive_Multiply = 1.0`
  `Pan_V_01 = 0.3`
  `Tile_U_01 = 1.5`
  `Tile_V_01 = 2.0`
  `Random_Offset_Texture_01` 已启用
- 参数组 `01. Texture_01_Distort`
  `Texture_01_Distort_Use` 已启用
  `Texture_01_Distort_Use_NormalTex` 已启用
  `Texture_01_Distort_Normal = T_FX_Normal_Noise01`
  `Texture_01_Distort_Power = 1.0`
  `Texture_01_Distort_Intensity_U = 0.25`
  `Texture_01_Distort_Intensity_V = 0.05`
- 可确认的制作结论
  主火焰层至少由一张平铺噪声遮罩加一张法线噪声做 UV 扰动
  通过纵向 `Pan`、U/V 平铺和随机偏移，让火焰片产生持续上升和不完全重复的运动
  这张图对应的重点不是节点连线本身，而是材质实例参数如何驱动火焰动画
这一帧把地面中心裂纹系统的内部结构直接展开出来，说明最终地裂并非单层 emitter，而是至少用两条裂纹发射器共同叠加

- 系统与发射器
  当前系统名为 `NS_FX_GroundCenterCrack`
  中央 `System Overview` 面板里有两个 emitter
  `Crack`
  `Crack_Add`
  两者的模块顺序基本一致，都包含
  `Emitter State`
  `Spawn Burst Instantaneous`
  `Initialize Particle`
  `Sprite Facing and Alignment`
  `Particle State`
  `Color`
  `Dynamic Material Parameters`
  `Sprite Renderer`
- 右侧 `Sprite Renderer` 设置
  当前选中的是 `Crack`
  材质为 `MI_FX_GroundCenterCrack_01`
  `Source Mode = Particles`
  `Alignment = Custom Alignment`
  `Facing Mode = Custom Facing Vector`
  `Default Pivot in UV Space = (0.5, 0.5)`
  `Sort Mode = None`
- 左侧预览
  预览窗中能看到几条从中心向外分叉的亮裂纹
  说明该系统负责裂纹主体可见形状，而不是火柱或烟雾
- 可确认的制作结论
  `Crack` 与 `Crack_Add` 很可能分别承担主裂纹和附加亮层或补充细节
  两者共享相近的生成流程，但通过不同材质或参数叠加，做出更复杂的中心地裂观感

### 00:09:49-00:13:13 Alpha、Houdini、Mesh

- 本段定位：Alpha、Houdini、Mesh。
- 知识点：这是全然 这是高光 这是我们慢慢的轉移的alpha 这是一个更多的alpha 更加詳細的 这是对於perilax的重量 是濃密的 看到这里有更多的瘤。
- 知识点：有更多的 更多的詳細的 再加上轉移 全部都放在一起 这是alpha 需要展示这一刻 这是結果 我把这些都切掉了 從中间开始 我们慢慢地 發出很多火和其他物質。
- 知识点：我为它们設立了 另一个3D物体 这里有 另外,为它们設立了黑色 慢慢地,变成白色 在頂端里 需要展示一下 我为它们設立的方式 首先,在Houdini。
- 知识点：首先,在Houdini 这大小的 grid 是创建的 Remesh 它是怎麼做的? 它是分開了物体 更加詳細的 分開了成分 再加上用来編写的 这樣一个东西。
- 知识点：可以控制的 它是怎麼创建的? 選項 这里的文字是編写的 Chargpt 做了这件事 請他自行创建一件东西 請他自行创建一件东西 这里的 vector。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Houdini`。

**关键画面：**

这一帧在 Unreal 纹理查看器中展示一张用于中心裂纹或地裂过渡的灰度遮罩，重点是说明教程把透明度、高光和渐变过渡拆成独立纹理层使用

- 当前纹理内容
  中央是一张接近圆形的灰度图
  中心最暗，向外逐步过渡到中灰，再到边缘接近白色
  整体是平滑径向渐变，不包含明显裂纹形状
  这种结构更像“过渡 alpha”或范围遮罩，而不是主裂纹贴图本体
- 通道状态
  顶部 `A` 通道按钮处于激活状态
  说明当前查看的是 alpha 通道
- 右侧可确认参数
  `Imported: 2048x2048`
  `Displayed: 2048x2048`
  `Has Alpha Channel: True`
  `Format: BC7`
  `Texture Group = World`
  `sRGB` 已勾选
  `X-axis Tiling Method = Wrap`
  `Y-axis Tiling Method = Wrap`
- 可确认的制作结论
  这张图对应字幕中提到的“alpha for our gradual transition”
  用途是给裂纹、火焰或中心地面效果提供由内到外的渐变控制
  也就是说，主形状、高光层和透明过渡并不是混在一个通道里，而是拆成不同资源或不同通道分别控制
这一帧进入 Houdini，开始解释中心裂纹路径是怎样从基础平面上生成出来的。当前还处于流程起点，只建立底层网格并接上第一次重建拓扑

- 左侧视口
  黑色网格平面上分布多条从中心向外辐射的白色裂纹曲线
  裂纹整体呈放射状，和前面 AOE 中心裂纹的布局一致
  视口右下角能看到当前几何规模约为 `62,274 prims`、`1,771 points`
- 右上参数面板
  当前节点是 `grid1`
  `Primitive Type = Polygon`
  `Connectivity = Quadrilaterals`
  `Orientation = ZX Plane`
  `Size = 50, 50`
  `Rows = 100`
  `Columns = ch("rows")`
  即先创建一个 `50x50`、`100x100` 分段的基础网格
- 下方节点图
  目前可见的流程起点只有两个节点
  `grid1`
  `remesh1`
  表示先建立规则平面，再交给 `remesh` 做后续重建或均匀化
- 下方表格
  `Geometry Spreadsheet` 正在显示 `grid1` 的点坐标
  可见 `P[x] / P[y] / P[z]` 等位置字段
- 可确认的制作结论
  裂纹并不是手画在一张贴图上起步，而是先在 Houdini 中准备可运算的平面几何
  后续所有裂纹分布、点采样、距离场或属性记录，都是在这块高分段网格上继续加工
这一帧继续在 Houdini 中处理裂纹底层网格，目标是通过随机阈值删除部分点，为后续更稀疏、更可控的裂纹分布做准备

- 当前节点
  选中节点为 `Attribute Wrangle`，名称 `control_crack`
  上游可见 `remesh1`
  右下还能看到后续节点 `sphere1`
- 当前可见代码
  ```c
  vector random_point = rand(@ptnum * chf("Seed"));

  if(random_point < chf("Threshold"))
  {
      removepoint(0, @ptnum);
  }
  ```
  代码语义很明确：对每个点生成随机值，小于阈值的点直接删除
- 参数
  `Run Over = Points`
  `Seed = 0.2634`
  `Threshold = 0`
- 左侧视口
  视口中仍是一块经过重建的密集平面
  当前没有明显裂纹线，说明这一步还在准备点分布，不是最终可视裂纹阶段
- 可确认的制作结论
  教程在这里用最简单的随机删点方式先打散均匀网格
  `Seed` 用来改变随机分布
  `Threshold` 决定删除强度，值越大，保留下来的点越少
  这一步为后续生成更自然的裂纹起点、分支点或采样点提供基础

### 00:13:57-00:18:42 UV

- 本段定位：UV。
- 知识点：它是将种子轉移到这个位置 这就是这个样子 它是轉移的 这里有一个开始點 和一个結局點 这里所有种子都是標準的 在这个方式 在这些點上 会有类似的碎片。
- 知识点：它会做到这些事 如果需要 例如改种 它会每次 每次做出不同的变化 比較少 为什么我们需要这个? 因为这里有一个問題 有些點很接近 它们都会分開。
- 知识点：很多种子都会分開 在这个點上 它们都删除了 它们变得很少 它们的数字就这樣 我们把它们切掉 这就是後来的一种 接下来我加了一种順滑的种子 它们变得很均勻。
- 知识点：它们变得很均勻 它们变得很均勻 我加了一种 你能够更均勻的种子 我加了一种 我用这个种子 看看它们会不会变得很均勻 我把这些價值交给它 我把这个價值交给它。
- 知识点：它们会变成一开始 然后 我再次連接这个點 因为它们有很多种子 它们会互相反彈 这个點删除了 它们变得很少 它们变得很少 之后我再加了它们 你看到它们的距離嗎。
- 知识点：这个點加了更多點 我再加了它们 但它们又有反彈的問題 现在需要解決它们 这个點删除了什么呢 它们反彈了地圖 我们需要地圖 我反彈了平面地圖。
- 知识点：你能够做得到 这是我们的 它们看起来像一條橫幅 很多點 我用这个种子 我把它们删除了 我用这个种子删除了 现在我们有很多點 我们有很多點 我们有很多點。

**关键画面：**

这一帧已经从随机删点推进到“把起点和终点连成裂纹路径”的阶段，核心节点是 Houdini 的 `Find Shortest Path`

- 左侧视口
  网格平面上布满大量白色折线路径
  路径从多个方向向中部汇聚，同时又向外继续分叉
  目前数量很多、分布偏密，明显还处于筛选前的中间态
- 右上参数面板
  当前节点名为 `wire`
  节点类型为 `Find Shortest Path`
  `Start Points = start`
  `End Points = end`
  `Output Paths = From any start to each end`
  `Cost Attribute = cost`
  `Point Number Attribute = origpt`
- 下方节点链
  可见流程顺序为
  `Group Create start`
  `Group by Range end`
  `Find Shortest Path wire`
  `Fuse fuse1`
  `Smooth smooth1`
  说明先定义起点组和终点组，再求路径，之后还会做焊接与平滑
- 下方表格
  `Geometry Spreadsheet` 中可见 `origpt` 等属性列
  说明路径追踪后仍保留原始点索引，便于后续继续处理
- 可确认的制作结论
  教程不是直接随机连线，而是显式指定 `start` 和 `end` 两个点组，再让 `Find Shortest Path` 沿网格按代价属性求出路径
  这样能得到更接近自然蔓延的裂纹主干，同时为后续筛点、平滑和均匀化保留可控基础
这一帧已经进入对裂纹折线做清理和重新连接的阶段，当前节点是第二次 `Fuse`，用于把相近点重新焊接，减少过密和断裂问题

- 左侧视口
  画面只展示局部裂纹网络
  白色折线仍沿黑色网格前进，但数量比上一张少，视野也更聚焦于单条路径的连接质量
  可见部分顶点附近有淡紫色辅助点，说明正在处理点连接关系
- 右上参数面板
  当前节点是 `fuse2`
  `Snap Distance = 0.005`
  `Output Positions = Average Value`
  `Fuse Snapped Points` 已启用
  `Remove Repeated Vertices and Degenerate Primitives` 已启用
  `Remove Unused Points from Degenerate Primitives` 已启用
  `Recompute Affected Normals` 已启用
- 下方节点链
  可见当前阶段已经经过
  `wire`
  `fuse1`
  `smooth1`
  一个名称显示为 `GROW` 的中间节点
  `fuse2`
  后续还能看到 `resample1`、`sweep1`
- 可确认的制作结论
  教程在求出初始最短路径后，并没有直接拿去做最终几何
  而是通过多次 `Fuse` 和中间平滑/生长步骤，把彼此靠近或断开的点重新焊成更连续的裂纹线
  这一步主要解决字幕提到的“点很多，需要重新连接”的问题
这一帧开始给裂纹路径写入“离中心有多远”的属性，后续可用它在 Unreal 或 Substance Designer 中做从中心向外的归一化渐变控制

- 当前节点
  节点名为 `Get_Point_Distance`
  类型是 `Attribute Wrangle`
  `Run Over = Points`
- 当前可见代码
  ```c
  // Define the center of the scene (you can adjust if needed)
  vector center = {0, 0, 0};

  // Calculate the distance of each point from the center
  float dist = distance(@P, center);

  // Store the distance in an attribute for each point
  f@dist = dist;
  ```
  代码含义是：以场景原点为中心，给每个点写一个 `dist` 浮点属性
- 下方节点链
  上游可见 `blast1`、`uvproject1`
  当前节点后面依次是
  `Get_Max_Distance`
  `Gradient_By_Distance`
  `triangulate1`
  说明计算距离后还会求最大距离，并进一步转成梯度
- 左侧视口与表格
  视口中只聚焦一小段裂纹带状几何，并在点上标出编号
  `Geometry Spreadsheet` 中可见属性列
  `cost`
  `dist`
  `origpt`
  说明距离值已经真正写进点属性表
- 可确认的制作结论
  这一步正对应本段关于“点越远，距离中心越大”的说明
  后续只要再用最大距离归一化，就能得到从中心 `0` 到外缘 `1` 的连续权重
  这个权重既能驱动裂纹显示顺序，也能驱动颜色、透明度或其他沿半径变化的效果

### 00:18:42-00:23:35 Normal、Houdini、VAT

- 本段定位：Normal、Houdini、VAT。
- 知识点：它们都在記錄 它们都把整个點數 都写下来 这是最大距離 为甚麼呢 为了设计一种距離 后续会格局作为我们的位置 后续会中心作为中心 然后后续会最大距離作为中心。
- 知识点：这是后续会格局分成 并将中心的0從中心的 1的最後一端作为中心 并将中心的0從中心的 1的最後一端作为中心 这是后续会順利的转换方式 格局将色彩作为中心。
- 知识点：这是色彩在中心的 CD的錄影 这是Houdini的 正常色彩 这是距離 这是最大距離 并将中心的價值 正常化为價值 因此后续会價值 從0到1写上。
- 知识点：我们来这里,我们来到點 这里是我们的點 我们的價值 这里是錄影的 之后需要它们切成圆形 根據原則上,你可能不会做到 这件事 这件事没有什么可担心的。
- 知识点：Unreal Engine可以自行调整 自動调整 之后需要它们 增加100 以为它们可以 在Unreal Engine裏进行进行 需要它们 在Unreal。
- 知识点：Engine裏 使用3D物理 以及在Substance Designer裏 如何使用它们 我正在移动 在Node Object裏 我正在加一个鏡頭。
- 知识点：需要这个鏡頭的位置 需要它们的位置 需要它们转换到现在 需要它们放在上面 在这个物理上 在做一个錄影的时刻 需要去这里 我找到我们需要的鏡頭。
- 核对对象：`Houdini`、`Substance Designer`。

**关键画面：**

这一帧紧接上一张 `dist` 写入之后，开始在 Houdini 中统计整套裂纹点集的最大半径，用作后续归一化梯度的分母

- 当前节点
  选中节点为 `Get_Max_Distance`
  类型是 `Attribute Wrangle`
  `Run Over = Points`
- 当前可见代码
  ```c
  // Initialize the maximum distance
  float max_dist = 0;

  // Get the number of points in the geometry
  int num_points = npoints(0);

  // Loop through all points and find the maximum distance
  for (int i = 0; i < num_points; i++) {
      float dist = point(0, "dist", i);
      max_dist = max(max_dist, dist);
  }

  // Store the maximum distance in a detail attribute
  setdetailattrib(0, "max_dist", max_dist, "set");
  ```
  代码作用是遍历所有点，读取前一步写入的 `dist`，把最大值存成 detail 级属性 `max_dist`
- 节点链
  上游是 `Get_Point_Distance`
  下游紧接 `Gradient_By_Distance`
  再往后是 `triangulate1`
- 左侧与下方信息
  视口显示中心向外辐射的裂纹线网络
  `Geometry Spreadsheet` 中仍能看到 `cost`、`dist`、`origpt` 等属性列
- 可确认的制作结论
  这一步的目的不是修改形状，而是为“把距离归一化到 0 到 1”准备最大值基准
  只有拿到 `max_dist`，后续才能把每个点的绝对距离转换成统一可用的渐变权重
这一帧从 SOP 细节跳到 Houdini 对象级，重点是为后续输出或烘焙准备一台正上方相机，让裂纹网络以固定投影视角渲染成贴图

- 左侧视口
  裂纹网络以俯视方式铺在方形网格区域中
  主干从中心向上下左右和斜向分叉，构图已经接近最终要输出的中心裂纹图案
  视口右下角提示当前处于 `2 objects, 1 selected`
- 右上参数面板
  当前对象是 `cam1`
  `Translate = (-125, 4300, -50)`
  `Rotate = (-90, 0, 0)`
  该旋转说明相机被翻转到垂直朝下的俯视角
- 下方对象级网络
  只显示两个对象
  `center_cracks`
  `cam1`
  说明这一阶段不再新增几何节点，而是先在对象级建立拍摄关系
- 下方表格
  当前节点显示为 `UE5_Scale`
  属性表里可见
  `Cd[r]`
  `Cd[g]`
  `Cd[b]`
  `costa`
  `dist`
  `origpt`
  说明裂纹几何已经带有颜色和距离等属性，正准备用相机视角输出
- 可确认的制作结论
  教程这里的关键不是再改裂纹形状，而是找到一个稳定的正上方相机
  只有固定俯视渲染，后续法线、渐变、alpha 或其他图才能和地面 decal/贴图坐标准确对齐
这是一个 Substance Designer 灰度图加工节点图，当前目标是把 Houdini 导出的裂纹基础图继续加工成更适合自发光或亮边使用的灰度版本

- 节点定义集
  `Insert Grayscale` 节点
  输入一张裂纹灰度图，缩略图能看到黑底白裂纹
  `pow_grayscale`
  当前选中节点，用于按指数重新分布亮度
  `Shape`
  输出一张中心亮、边缘暗的圆形渐变遮罩
  `Height Blend`
  用于把噪声层混入裂纹高度/灰度结果
  `Slope Blur Grayscale`
  作为细节拉扯或边缘扰动处理
  `Grunge Map 007`
  提供斑驳噪声
  `Blend`
  用于合成裂纹层与噪声层
  右侧还能看到多个 `Insert Grayscale` 与 `Blend`/中间节点，但节点名在当前截图中不完整，只能确认它们继续参与后续合成
- 连线集
  一条上方主支路
  `Insert Grayscale(裂纹图)` -> `pow_grayscale` -> 向右输出到后续节点
  一条下方细节支路
  两个左侧输入 -> `Height Blend` -> `Slope Blur Grayscale`
  `Slope Blur Grayscale` 输出与 `Grunge Map 007` 一起进入 `Blend`
  `Blend` 输出再送入右侧的 `Insert Grayscale`
  右侧 `Insert Grayscale` 与下方另一条支路继续汇入一个后续合成节点
  `Shape` 的圆形渐变单独送往右侧分支，用作额外遮罩或调制输入
- 设置/参数
  当前选中 `pow_grayscale - PROPERTIES`
  `Output Size` 继承父级，父尺寸显示为 `2048`
  `Output Format = 8 Bits per Channel`
  `Tiling Mode = H and V Tiling`
  `Random Seed = 0`
  `Instance Parameters`
  `exponent = 4`
- 输出/预览
  左上 `2D View` 显示黑底白裂纹图
  裂纹边缘带有柔和亮边，说明经过指数和后续处理后，亮区被进一步压缩到裂纹周边
  左下 3D 预览是默认立方体，占位意义大于结果本身
- 可确认的制作结论
  这张图对应字幕里“inverted, inverted again, used exponential here, this is for emissions”
  说明作者在 Substance 中通过指数、反相及多层噪声混合，把原始裂纹图加工成更适合发光层使用的灰度贴图

### 00:23:35-00:28:13 Alpha、Opacity、Houdini

- 本段定位：Alpha、Opacity、Houdini。
- 知识点：本段围绕 `Opacity` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：反轉到慢速的Blur 混合了兩种噪音 这就是需要它们混合的方式 我还创建了这樣的一个选择 從这點来看 我创建了颜色。
- 知识点：反轉 我用了Blur 然后再次重複 创建颜色 这是为了显示 这是转换的階段 我用了Shape 我提升了一点 轉了Tiling 反轉了 变成了Bass。
- 知识点：8 bits 名字的出口 可以看每个頻道 R Channel GB和Alpha 我如何创建一个細節的版本 这是我用的 我用了Blur 我还创建了颜色。
- 知识点：我创建了这些瘤 我用了这个噪音 它有小小的转换 我提升了它的大小 让它转换了 这是用了这个噪音 用了慢速Blur来加細節 用了Warp来做。
- 知识点：瘤的转换 我特别设置了这个 向左 向右 一起它们会有这种瘤 和差不多一樣的选择 有相同的價值 它们很相似 转换了價值 我再次重複它们 这个噪音再次重複。
- 知识点：这是結果 同樣的东西 再次重複这个噪音 这就是兩种变化 我再次重複 選了最大 結果我做了这麼細節的瘤 用Histogram来做了它们变白 再次重複。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Opacity`、`Houdini`、`颜色`。

**关键画面：**

这是另一张 Substance Designer 节点图，当前在制作裂纹不透明度或 `R` 通道用的灰度图，重点是把裂纹主体与两组噪声细节叠加后再做反相与模糊

- 节点定义集
  左上支路与中间主支路都由多级黑白节点组成
  当前选中节点是 `invert_grayscale`
  属性面板说明它是一个反相灰度值节点
  图中还能确认存在多组黑白噪声节点、若干中间混合节点，以及至少两个红色输出节点
  字幕明确提到 `slow blur`、`two noises`、`opacity`
- 连线集
  上半部分是一条主裂纹支路
  从左侧输入开始，经过数个黑白处理节点后，汇入右侧输出
  中间还能看到一条弯下去的支路再回接到主线上
  下半部分是另一条并行细节支路
  同样由多级黑白节点串联，最终也汇入右侧输出
  整体结构表现为
  裂纹主形状
  两条噪声细节链
  多次合成
  最终输出
- 设置/参数
  当前选中 `invert_grayscale - PROPERTIES`
  `Output Format = 8 Bits per Channel`
  `Tiling Mode = H and V Tiling`
  `Random Seed = 0`
  `Instance Parameters`
  `Invert = True`
- 输出/预览
  左上 `2D View` 当前结果是白底黑裂纹
  裂纹边缘带毛刺状噪声，说明这不是干净矢量线，而是已经混入粗糙度和细节的透明度图
  预览标题就是 `invert_grayscale - 2D VIEW`
- 可确认的制作结论
  这张图对应字幕里“in channel R... created opacity... inverted slow blur makes two noises”
  说明作者把裂纹 opacity 放在某个灰度通道中，通过反相、慢速模糊和双噪声组合，把边缘做得更自然、更有粗糙火焰感
这是同一套 Substance Designer 裂纹 opacity 制作中的中后段，重点是把两种经过噪声扰动的裂纹变体再合并成一个结果

- 节点定义集
  `Directional Warp`
  图中至少可见两处，用噪声对裂纹轮廓做方向性扭曲
  `Blend`
  中间和右侧各有一处，用于合成两组变体
  当前选中节点是 `auto_levels`
  右侧属性说明它用于自动拉伸低高值范围
  左下还能看到一个带 `Blur` 字样的节点，但完整名称在截图里不清楚
- 连线集
  上方支路
  `Directional Warp` -> 上方黑白节点 -> 右侧 `Blend`
  下方支路
  左下输入 -> `Directional Warp` -> 中间 `Blend` -> 右侧 `Blend`
  两条支路最后一起汇入最右侧的输出节点
  这正对应字幕里“Here are the two variations. Then I combined them”
- 设置/参数
  当前选中 `auto_levels - PROPERTIES`
  `Output Format = 8 Bits per Channel`
  `Tiling Mode = H and V Tiling`
  `Random Seed = 0`
  描述为 `Apply automatic Level In Low and Level In High`
- 输出/预览
  左侧 `2D View` 显示一张白色粗裂纹图
  裂纹中心较亮，边缘柔化并带轻微膨胀感
  说明在合并两种变体后，整体宽度和亮度都被抬高到更适合 opacity 使用的范围
- 可确认的制作结论
  这张图说明作者不是只用一套裂纹噪声
  而是先做出两种相近但不完全相同的变体，再通过 `Blend` 合并
  这样最终 opacity 图的边缘会更复杂，也更不容易出现机械重复
这一帧回到 Unreal 的 `Sequencer` 验收，作者把 AOE 各层拆开回看，重点强调中心冲击与地面裂纹是可单独开关、单独检查的

- 当前场景
  画面中央是非常亮的中心爆发火焰
  周围一圈地裂发光沿地面铺开，形成近圆形的裂纹环
  左上还保留一团较暗的弧形残留火焰，说明其他层并未完全关闭
- 时间线与层级
  下方 `Sequencer` 同时展开了 `Slash` 和 `AOE`
  `Slash` 下可见
  `NS_FX_FireSlash03`
  `NS_FX_FireSlash02_e`
  `NS_FX_FireSlash01_a`
  `NS_FX_FireSlash01_b`
  `AOE` 下可见多条 `NS_FX_FirePillar01_*`
  当前时间约 `2.95`
- 当前选中对象
  右侧选中的是 `NS_FX_GroundCenterCrack`
  `Location ≈ (-153.9, -583.5, 0.0)`
  `Scale = 1.0, 1.0, 1.0`
- 可确认的制作结论
  作者此时在按层复核 AOE
  中心冲击层是一个独立元素
  地面中心裂纹也是一个独立 Niagara 系统
  它们需要在最终镜头里叠加，但调试时应能单独关闭和检查
  这也对应字幕所说“turn it off for us to review... We have a central strike here”

### 00:28:13-00:33:10 UV、Decal、Houdini

- 本段定位：UV、Decal、Houdini。
- 知识点：让它们都很好 第一、第二、第三个都已经开启了 它们都已经开启了 而且它们也有一个Decal在它的核 Parlax的基礎 看一看 会很容易的。
- 知识点：最後一件事 需要說 这些石頭 如何剪輯 让我来看看 我开启了这些石頭 这里没有什么了 它们会剪輯 首先 然后它们会消失 这就是我剪輯了 很多石頭的。
- 知识点：粒子的创建 但如果你看它们 所以这是 一个3D的物体 你可能会想 如何剪輯一个碳硬物 这里有一个非常精準的技巧 在我聽了之后 他写了一个很有趣的东西。
- 知识点：他写了 我明白他在Houdini里剪輯了 他写了各个石頭的色彩 在地區的位置 我们来看看 这个石頭的色彩 很像一张普通的圖像 但在三个角落。
- 知识点：X、Z、Y 看起来很奇怪 我们来看看这个物体 这里有一个很有趣的物体 它有特質 你不会看到 他在这物体上 如何管理石頭 他在这里規則 这是一个更複雜的技巧。
- 知识点：一种物体上 可以製造更多的色彩 并且增加了 其功能 他在这里控制了色彩 在这層層製造了色彩 这叫做 三角形的圖像 很複雜的东西 像是一张圖像 简单来說。
- 知识点：很像 但我的版本 是比較一致的 基本上 这就是用了 pivot paint 这是一个体驗的技術 需要解釋 如果你想要再加上 需要给你一些物体 例子。
- 核对对象：`Decal`、`Houdini`、`粒子`。

**关键画面：**

这一帧回到 Unreal 的 AOE 总体效果验收，重点是说明沿裂纹分布的多个火柱并不是同时点亮，而是按照顺序逐步激活

- 当前场景
  画面中可见多条明亮的熔岩裂缝在地面上连接成大片区域
  多个高耸火柱沿裂纹关键点竖直喷发
  视口中每个火柱附近都能看到一个带三轴 gizmo 的实例位置
  还有一个大范围的选框轮廓，说明作者正在整体查看一组相关对象
- 时间线与层级
  `Sequencer` 当前展开 `AOE`
  可见多条 `NS_FX_FirePillar01_*`
  `NS_FX_FirePillar01_a2`
  `NS_FX_FirePillar01_a`
  `NS_FX_FirePillar01_c`
  `NS_FX_FirePillar01_b`
  `NS_FX_FirePillar01_d`
  `NS_FX_FirePillar01_b2`
  `NS_FX_FirePillar01_a3`
  `NS_FX_FirePillar01_a4`
  当前时间约 `3.80`
- 当前选中对象
  右侧仍选中 `NS_FX_GroundCenterCrack`
  `Location ≈ (-153.9, -583.5, 0.0)`
  `Scale = 1.0, 1.0, 1.0`
- 可确认的制作结论
  字幕明确说明“first, second and third were activated... gradually activated”
  也就是说火柱实例不是统一触发，而是按时间错开依次点亮
  Sequencer 的多轨排布就是为了让这些柱状爆发沿裂纹网络逐段推进
这一帧切到材质实例参数面板，说明作者在用三平面噪声和 WPO 参数控制 Houdini 碎块或地表碎片的表面分布与顶点位移

- 左侧预览
  视口中是一个球体材质预览
  表面呈黑底夹白色拉丝或云斑纹理
  说明当前主要在观察噪声贴图如何覆盖三维表面，而不是看平面 decal
- 材质层
  顶部 `Layer Asset` 显示一个材质层资源，名称可见前缀类似 `ML_...`
- `DIFFUSE` 组
  `DiffuseMask Texture = T_FX_TilingMask_RoughNoise01`
  `DiffuseMask_Texture_Power = 2.0`
  `DiffuseMask_Texture_Multiply = 1.0`
  `DiffuseMask_Texture_Tile_U = 1.0`
  `DiffuseMask_Texture_Tile_V = 1.0`
- `EMISSIVE` 组
  `EmissiveMask Texture = T_FX_TilingMask_CloudNoise01`
  `EmissiveMask_Texture_Power ≈ 10.780326`
  `EmissiveMask_Texture_Multiply ≈ 8.639699`
  `EmissiveMask_Texture_XY_Tile_U ≈ 2.896338`
  `EmissiveMask_Texture_XY_Tile_V ≈ 1.630952`
  `EmissiveMask_Texture_XZ_Tile_U ≈ 3.634223`
  `EmissiveMask_Texture_XZ_Tile_V ≈ 0.608`
  `EmissiveMask_Texture_YZ_Tile_U ≈ 1.764656`
  `EmissiveMask_Texture_YZ_Tile_V ≈ 0.303839`
  `EmissiveMask_AxisFadeContrast = 1.0`
  `EmissiveMask_Triplanar` 已启用
- `WPOSCALE` 组
  `HoudiniDebrisScaleValueMax`
  `R ≈ 23.1098`
  `G ≈ 16.1591`
  `B ≈ 20.635401`
  `A = 1.0`
  下方还能看到 `HoudiniDebrisScaleValueMin`，但当前截图只部分可见
- 可确认的制作结论
  这张图对应字幕里关于 “UV generation” 和 “rules the tops” 的说明
  作者在材质里用三平面投射避免 UV 拉伸，同时保留一组可开关的顶点/WPO 缩放控制，让 Houdini 导出的碎块或表面能按属性值产生不同位移或尺寸变化
这一帧不是作者自己的工程，而是用 SideFX Labs Pivot Painter 的示例网页做原理说明，强调可以把很多独立小物体当作一套静态物体统一管理和驱动

- 当前画面
  浏览器打开 `SideFX Labs Pivot Painter` 相关页面
  视频中间是一组由大量小块组成的螺旋或环状结构
  中心有紫色发光核心
  周围的木块或石块样单元沿曲线分布，并能整体旋转、卷曲、聚合
  画面四周还有树木、平台和云层作为场景背景
- 页面信息
  顶部能看到 `SideFX Labs - Labs Pivot Painter`
  页面正文中有外部链接与准备说明
  底部可见与 `ast_pivot_painter` 相关的资源链接
- 教程要表达的原理
  字幕明确说“we can use one static object and manage its objects”
  核心不是当前示例内容本身，而是 Pivot Painter 可以把一组看似独立的块体，编码到一套静态网格/贴图数据里，再在引擎中按统一规则驱动
- 对当前项目的意义
  作者把这个案例当成说明材料
  目的是解释为什么地面碎块、裂纹周边小块或其他 Houdini 导出的片段，也可以通过类似思路按中心关系、旋转关系或层级关系进行统一动画控制

### 00:33:10-00:36:58 Houdini

- 本段定位：Houdini。
- 知识点：某些數據 例如指紋、 pivot paint 这是我们需要的 这是Houdini 特别的一套 可以用它来管理 每个物体的3D 它们都很像 小物体。
- 知识点：可以控制它的 位置、轉動 轉動 可以用它来制作非常酷的动画 这是一个例子 也有用於樹木 你能移动它的地圖 这里展示了 如何把物体的位置。
- 知识点：放在一旁 需要用一个例子 来示範我所创建的东西 基本上,它们是非常相似的 如所見 这里是我们已经使用的石頭 我用它们作为基礎 我们移动了这个球。
- 知识点：我们分開它们 我们把它们分成一个物体 有25个物体 然后我做了一个圖 这里是一个圖圖 每个點都像一塊 的创建物 并且有一个線 與中心相關。
- 知识点：之后 这些物体 都会與中心相關 这是什么意思 因为我用了兩條圖 以25x25的價值 来做一个圖圖 还有另一个圖圖 但它是小的 需要它们创建成一塊。
- 核对对象：`Houdini`。

**关键画面：**

这一帧继续引用 SideFX Labs Pivot Painter 的网页案例，但这次强调的是“每个 3D 小物体都能被单独控制”，而不是只做整体统一运动

- 页面说明
  页面正文可见一段解释文字
  `Pivot Painter SOP` 属于 Houdini 的 `SideFXLabs`
  它会把模型的 pivot 与 rotation 信息记录到顶点数据、额外 UV 通道或纹理中
  然后这些编码信息可以在 Unreal 材质系统中被读取，用来创建交互或动画效果
- 当前视频示例
  中央仍是由大量小块拼成的螺旋结构
  每个块体沿环形轨迹排列，同时能围绕中心形成卷曲和张开效果
  字幕明确说 `We can individually control each object in the 3D`
- 对当前项目的意义
  教程在这里借这个例子说明
  如果把地裂周边的碎块或片段做成带 Pivot Painter 数据的一组物体
  就可以让每一块围绕自己的 pivot 独立旋转、位移或缩放
  同时又保持它们整体围绕中心关系运动
这一帧回到 Houdini，开始搭建用于碎块或条带状部件的基础几何。当前还是非常早期的建模阶段，用两个网格和一次布尔裁切来得到想要的条形区域

- 左侧视口
  中间是一条竖直的白色长方形网格带
  周围是黑色参考网格
  右下角显示当前几何量级约 `81 prims`、`100 points`
- 右上参数面板
  当前节点是 `grid2`
  `Primitive Type = Polygon`
  `Connectivity = Quadrilaterals`
  `Orientation = ZX Plane`
  `Size = 2, 10`
  `Rows = 10`
  `Columns = 10`
- 下方节点链
  当前可见
  `grid1`
  `grid2`
  `boolean1`
  下游还能看到 `mountain2`
  说明作者先准备两个平面，再用布尔得到裁切结果，后面会继续做形变噪声
- 字幕对应关系
  字幕明确说 `two grids ... another one, but it is smaller ... crop them with a boolean`
- 可确认的制作结论
  这一步并不是做最终碎块，而是先用两个尺寸不同的网格构出一个基础截面或条形模板
  再通过 `boolean` 裁切出需要的范围，为后续 `mountain` 扰动、分块和 Pivot Painter 数据制作提供初始几何
这一帧继续在 Houdini 中处理碎块原型，但重点已经从几何形状转到“给每个点分配一个编号，用来选择不同几何体或变体”

- 当前节点
  选中节点是 `attribwrangle1`
  类型为 `Attribute Wrangle`
  `Run Over = Points`
- 当前可见代码
  ```c
  int min_val = 0;
  int max_val = 23;

  int random_int = int(fit01(rand(@ptnum), min_val, max_val));

  s@name = itoa(random_int);
  ```
  代码作用是
  先定义编号范围 `0` 到 `23`
  再按点号 `@ptnum` 生成随机整数
  最后把这个整数转成字符串写入 `name`
- 左侧视口
  只显示一个单独的小块几何，像是前面基础条形模板经过形变后的一个样本
  说明当前正在围绕单个碎块原型准备实例化或复制逻辑
- 下方属性表
  `Geometry Spreadsheet` 中能看到
  `name`
  `scale[0]`
  `scale[1]`
  以及位置、法线等字段
  说明随机编号和缩放属性都已经真正写入点数据
- 下方节点链
  可见流程经过
  `boolean1`
  `mountain2`
  `scatter1`
  `attribrandomize1`
  `attribrandomize2`
  以及 `foreach_begin1 / foreach_end1`
  `foreach_end1` 旁还能看到 `Merge: 25`
- 可确认的制作结论
  这一步正对应字幕里“for each point I set a number”
  作者是在为每个散点随机指定一个碎块变体编号
  这样后续复制到点上时，同一套系统就能从多种几何中随机挑选，而不是所有碎块都长得一模一样

### 00:38:36-00:43:23 UV、Normal

- 本段定位：UV、Normal。
- 知识点：需要选择一个圖圖 因为它现在非常精緻 在之后需要減少它们 让它们剩下10% 现在它们的精緻度 现在是非常少的 在这里可以做一个很有趣的事情。
- 知识点：需要设置一些 我们稍後需要的價值 在这个圖圖上 这个價值是用来做圖圖的 在这里可以做圖圖 这是圖圖的數據 这是圖圖的圖圖 UV 和平的圖圖。
- 知识点：我们不需要 需要将它们创建出来 我设置每个圖圖的點數 这是它的方式 我使用了Triangulate 主要的东西在这里 是我们的圖圖的數據。
- 知识点：我们来这里 我们开启了名字的圖圖 是每个圖圖的名字 这是它设置的 從中心上 它重新包裝起来 这里没有包裝,它重新包裝起来 这里重新包裝起来。
- 知识点：这些就是很多點 它包裝起来 并且为每一个點數设置了一个名字 因为每一个點數 都必须是一顆不同的圖圖 你们記得嗎? 我们使用了一个肥件 但每个这樣的圖圖。
- 知识点：会使用偵測技巧 使用軟化的方式 使用其他某个空间 这是我们包裝成的一个只是一个 我只能在这里做一个單位 这里你不能做,我只能在这里做一个單位。
- 知识点：这就是我设置了每个位置 对於中心的位置 需要尝试示範 不 在 你看到嗎?现在標準位置是向上移动的 在这次情况下Y是頂端的位置 而它们是向上移动的。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这一帧继续在 Houdini 中准备用于 Pivot Painter 或实例化碎块的数据，重点是先把复制出来的大量碎块减面，再接法线和连接性等后续节点

- 左侧视口
  画面中是一大批白色低模碎块，按两条带状区域分布
  每块都是不规则多边形石片状形体
  右下角几何统计约为 `5,640 prims`、`3,331 points`
- 当前节点
  选中节点为 `polyreduce1`
  类型 `PolyReduce`
- 右侧可确认设置
  `Target = Percentage of Input Polygon Count`
  `Percent To Keep = 10`
  节点状态显示 `Reduced To: 10.00%`
  `Equalize Lengths = 1e-10`
  `Boundaries = 1`
  `Vertex Attribute Seams = 1`
  `Attributes = * ^N`
  `Soft Points Weight = 1`
- 下方节点链
  上游可见
  `copytopoints1`
  `unpack2`
  当前节点后面能看到
  `normal1`
  `connectivity1`
  说明减面之后还会重算法线并为每块写连接性或 piece 属性
- 可确认的制作结论
  这一步是把复制后的碎块阵列压到更低面数，方便后续做 Pivot Painter、实例化或引擎渲染
  同时字幕也说明这里会先设置以后在 Pivot Painter 中要用到的一些值
这一帧继续在 Houdini 中为散点或碎块实例写辅助方向数据，目标是让每个点都知道自己相对中心的朝外方向

- 当前节点
  选中节点是 `pointwrangle4`
  类型 `Attribute Wrangle`
  `Run Over = Points`
- 当前可见代码
  ```c
  vector centroid = set(0,0,0);

  // For each point, calculate the outward normal from the centroid to the point
  int num_points = npoints(0);
  for (int i = 0; i < numpts; ++i) {
      vector pos = point(0, "P", i);   // Get the position of the current point
      vector normal = normalize(pos - centroid);   // Calculate and normalize the vector from centroid to point

      // Set this normal to the normal attribute of the point
      setpointattrib(0, "N", i, normal, "set");
  }
  ```
  代码语义明确
  以原点 `centroid` 为中心
  读取每个点的位置 `P`
  计算从中心指向该点的归一化向量
  再写入点法线属性 `N`
- 左侧视口
  视口中只剩大量散点，沿两条区域带状分布
  说明当前处理对象已经不是完整碎块，而是用来承载实例信息的一组点
- 下方属性表
  `Geometry Spreadsheet` 能看到
  `N[0]`
  `N[1]`
  `N[2]`
  `name`
  说明法线方向和编号属性都已存在
- 下方节点链
  上游可见 `extractcentroid2`
  `pointwrangle3`
  当前节点为 `pointwrangle4`
- 可确认的制作结论
  字幕说的是“set the position for each point relative to the center”
  这里的实际做法是把每个点相对于中心的朝外方向写成 `N`
  这样后续无论是 Pivot Painter、实例朝向还是材质里的方向性控制，都能直接利用这组从中心辐射出去的向量
这一帧回到 Unreal 的静态网格查看器，作者开始直接检查自己导回引擎后的 Pivot Painter 碎块版本，并准备切换到顶点色显示

- 当前对象与外观
  视口中是一圈沿弧线排布的碎石块
  每块都是不规则尖角石片，表面已有灰白石材纹理
  整体排列方式与前面 Houdini 里的两条带状分布一致
- 视口菜单
  左上 `Show` 菜单已展开
  当前高亮项是 `Vert Colors`
  同菜单还能看到
  `Sockets`
  `Vertices`
  `Normals`
  `Tangents`
  `Binormals`
  `Show Pivot`
  等调试选项
  说明作者正准备通过顶点色检查导入的数据是否正确
- 右侧信息
  `Material Slots` 只有 1 个
  当前材质为 `MLPivotPainter`
  右下还能看到碰撞分解参数 `Hull Count = 4`、`Max Hull Verts = 16`
- 可确认的制作结论
  字幕明确说“back to Unreal... Let's see! Vertex color”
  这张图的核心不是展示最终动画，而是验证 Houdini 输出的 Pivot Painter/顶点色数据已经回到 Unreal，并且可以通过静态网格查看器的 `Vert Colors` 模式直接检查

### 00:43:23-00:48:19 Niagara、Dynamic Parameter

- 本段定位：Niagara、Dynamic Parameter。
- 知识点：我为了展示的原因 在这里我設立了Niagara系统 我正在移动 这是我的版本 这是我作者的標準版本 这里是 这里所有东西都很相似 如果我们看看。
- 知识点：有一个3D物件 一个連接物件 还有一个物件層 我設立了我的物件層 这里我作者是標準的 我开启了很多东西 但無法找到任何东西 这是他的改变,这是我的。
- 知识点：让我开启2 这里是我的 基本上,它使用了这一个功能 我们有在这里输入了一些功能 叫做 Pivot Painter Data 如果您没有它们 您可以在官方網站找到。
- 知识点：Side Effects 您可以在这里下載 这是一个例子 Pivot Painter,以我記憶之內 是標準的 或是我们已经输入了 不同的工程。
- 知识点：因此,您应该有这樣的功能 需要用Absolute World Position 是Vertex Position 然后需要用Pivot的Position。
- 知识点：需要把它轉移到这个價值 然后需要把它轉移到这里 这是本人的版本 这是我的选择 很不一樣 是在數碼上 我们来看看3D工程 这是我的工程 哦,这是錯誤的工程。
- 知识点：这是另一个 这是这个工程 这里有一个層次 我设置了我的Pivot Painter 同樣的價值 所有工程都一樣 并不一樣 所有工程都一樣 可以用Pivot。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`Niagara`、`Dynamic Parameter`、`系统`。

**关键画面：**

这一帧进入 Unreal 里的 Niagara 实例验证阶段，作者把基于 Pivot Painter 的碎块效果单独放回关卡中，对比自己的变体和原作者版本

- 当前场景
  地面上可见两条由碎块组成的弧形带
  碎块内部带有强烈的橙黄色发光，看起来像被火焰或熔岩点亮
  前景这组碎块被橙色轮廓选中
  远处左上还能看到另一组同类效果，作为对照
- 当前对象
  右侧选中的是 `NS_TestPivotPainter`
  `Location ≈ (763.0, 1909.0, 0.0)`
  `Scale = 1.0, 1.0, 1.0`
  下方 `Niagara System Asset` 也显示为 `NS_TestPivot...`
- 内容浏览器
  当前路径位于 `VFX_Library/Projects/MagicFireAOE/_Common/Niagara`
  可见 `DynamicInput Script`
  以及 `NS_TestPivotPainter`
- 可确认的制作结论
  字幕说的是“this is my variation... this is the author's standard variation”
  说明作者专门做了一个测试 Niagara，用来比较自己接入 Pivot Painter 数据后的版本与参考版本是否一致
  这一阶段关注的是系统集成是否成立，而不是最终 AOE 排布
这是一个 Unreal 材质层中的 Pivot Painter 相关材质图，当前目的是把物体的世界位置、Pivot Painter 解码结果和 Niagara 传入的动态参数结合起来，生成每个碎块的位移或缩放驱动量

- 节点定义集
  `Absolute World Position`
  使用 `XYZ` 输出当前像素/顶点的世界坐标
  `PivotPainter_PerObjectData`
  材质函数调用节点
  当前可见输出包括
  `X-Axis Vector`
  `Pivot Position`
  `Random Value Per Element`
  `Custom Alpha Values`
  `Object Scale`
  `Black Mask`
  `Subtract`
  用于计算世界位置与 Pivot 位置之间的差向量
  `Dynamic Parameter`
  当前可见参数名为 `WPOScale`
  `Multiply(3)`
  把 `WPOScale` 与常量 `-1.0` 相乘
  `Multiply`
  把上面得到的缩放因子与空间差值相乘
- 连线集
  `Absolute World Position.XYZ` -> `Subtract.A`
  `PivotPainter_PerObjectData.Pivot Position` -> `Subtract.B`
  `Subtract` 输出 -> 右侧 `Multiply.A`
  `Dynamic Parameter.WPOScale` -> `Multiply(3).A`
  常量 `-1.0` -> `Multiply(3).B`
  `Multiply(3)` 输出 -> 右侧 `Multiply.B`
  右侧 `Multiply` 输出继续连向截图右侧未显示区域
- 设置/参数
  左下 `Details` 显示当前选中的材质函数为 `PivotPainter_PerObjectData`
  `Dynamic Parameter` 的 `Parameter Index = 0`
  `Default Value` 名称显示为 `WPOScale`
- 输出/预览
  左侧球体预览只显示一层浅灰云纹材质
  说明当前截图的重点不是表面外观，而是材质内部的位移/控制逻辑
- 可确认的制作结论
  字幕里说“everything baked into a 3D object”
  这张图给出的具体做法是
  先从 Pivot Painter 数据里取出每个元素的 `Pivot Position`
  再用 `Absolute World Position - Pivot Position` 得到局部相对向量
  最后用 Niagara 的 `Dynamic Parameter.WPOScale` 统一缩放这个向量
  这样每个碎块都能围绕自己烘焙好的 pivot 做一致的 WPO 变换
这一帧把 `NS_TestPivotPainter` 的 Niagara 配置直接展开，重点是如何用 `Dynamic Material Parameters` 把时间曲线和数值传给材质中的 Pivot Painter/WPO 逻辑

- 系统结构
  当前系统名为 `NS_TestPivotPainter`
  可见两个 emitter
  `Debris_PivotPainter`
  `StaticDebri`
  两者都包含
  `Emitter State`
  `Spawn Burst Instantaneous`
  `Initialize Particle`
  `Particle State`
  `Dynamic Material Parameters`
  `Color`
  `Mesh Renderer`
  `Debris_PivotPainter` 额外还能看到
  `Scale Mesh Size`
- 当前时间
  时间线游标约在 `1.0958`
- 右侧 `Dynamic Material Parameters`
  当前选中 `Debris_PivotPainter`
  `Dynamic Parameter Index 0`
  `Write Parameter Index 0` 已启用
  `WPOScale (Multiple Aliases Found)` 使用 `Float from Curve`
  曲线索引为 `PARTICLES.NormalizedAge`
  曲线大致表现为
  起始接近 `0.9`
  很快下降到约 `0.1`
  中段长期保持低值
  末段再次抬升回接近 `0.9`
  同一组中还能看到
  `RotationMult = 0.0`
  其余未使用参数为 `0.0`
  `Dynamic Parameter Index 1`
  `Write Parameter Index 1` 已启用
  `DissapearDistanceMult = 25.0`
  其余参数仍为 `0.0`
  `Dynamic Parameter Index 2` 与 `Index 3` 未启用
- 左侧预览
  预览里是一段碎块条带
  当前是未点燃或弱发光状态，更便于观察几何本身如何受参数驱动
- 可确认的制作结论
  这张图对应字幕里“can be done more slowly... there is also rotation here”
  也就是说材质里的 Pivot Painter 变形不是写死的
  Niagara 通过 `Dynamic Material Parameters` 把 `WPOScale`、消失距离和旋转倍数等值按粒子寿命动态传给材质
  从而决定碎块展开、停留、收回或消失的时间节奏

### 00:48:19-00:52:50 UV

- 本段定位：UV。
- 知识点：但它是一个獨立的工程 我覺得这个方向是更好的 Pivot Painter是一个很酷的工程 需要告訴你 这是一个相对不同的工程 它更複雜 这里有更多的功能。
- 知识点：管理也很重要 这控制了3D的轉移 这里的Pivot Forward是用来控制方向 并且移动3D的物件 这就是这个測量的部分 測量管理就是这樣。
- 知识点：还有一个功能 这里也有Custom UV 我们有6个 以这个價值来设置 在通常的轉移上 为什么我们需要它? 因为3D的物件在轉移上 通常的圖案还在。
- 知识点：来編輯 这部分是用这兩个设置来创建的 这樣的話 如果我删除它 所有的功能都会完全運作 需要回到原本的效果 需要把它轉移到这里 可能不太显示。
- 知识点：但这里还有一些技術 如果你仍然把轉移關掉 这很實驗 如果我把它關掉 就变得很显示 如果它在你平常的圖案中 会被關掉 可以準備好 我创建了自己的变化。
- 知识点：并且展示了如何判斷石頭 我研究了一些有趣的技術 来创建这个效果 非常有趣的方法 像这樣 我创建了自己的变化 来自这效果 就这樣 需要把自己的变化。
- 知识点：相信我 如果你明白这个效果 你已经學到的东西 已经非常酷了 对於可能的工人 你已经有了一些非常酷的工作 我相信他們会很開心地找你 你交流 改变。

**关键画面：**

这一帧继续展开 `NS_TestPivotPainter`，当前重点是 `Debris_PivotPainter` 发射器的 `Mesh Renderer` 绑定，说明这套效果最终是用一套静态碎块网格配合 Pivot Painter 材质来驱动的

- 系统结构
  当前系统仍是 `NS_TestPivotPainter`
  可见两个 emitter
  `Debris_PivotPainter`
  `StaticDebri`
  当前选中 `Debris_PivotPainter` 的 `Mesh Renderer`
- 右侧 `Mesh Renderer` 设置
  `Meshes`
  `Index [0] = SM_Rock_Debris_PivotPainter`
  `Enable Material Overrides` 已启用
  `Override Materials`
  `Index [0] = MLPivotPainter`
  `User Param Binding = None`
  `Source Mode = Particles`
  `Facing Mode = Default`
  `Sort Mode = None`
  `Enable Frustum Culling` 未启用
  `Enable Camera Distance Culling` 未启用
  `Renderer Visibility = 0`
- 左侧预览
  预览中能看到两道由许多小碎块组成的弧线
  说明当前渲染器确实在用静态网格实例，而不是 sprite 或 ribbon
- 时间线
  当前时间约 `1.8167`
- 可确认的制作结论
  字幕提到“is one static object... Pivot painter is a very cool thing”
  这张图给出的具体实现是
  Niagara 发射器使用 `SM_Rock_Debris_PivotPainter` 作为实例网格
  再强制覆盖到 `MLPivotPainter` 材质
  让同一套静态网格通过材质内部的 Pivot Painter 逻辑产生运动
这是 `M_PivotPainter` 的材质图总览图，展示了作者如何把石块材质、Pivot Painter 数据、缩放控制和材质输出整合到一个可复用的默认不透明材质里

- 节点定义集
  `M_PivotPainter` 材质
  左下属性面板可确认
  `Material Domain = Surface`
  `Blend Mode = Opaque`
  `Shading Model = Default Lit`
  `Cast Ray Traced Shadows` 已启用
  中央可见一个大型 `PivotPainter_PerObjectData` 材质函数节点
  节点输出包括
  `Pivot Position`
  `Tangent Space X Vector`
  `Tangent Space Y Vector`
  `Tangent Space Z Vector`
  等多组数据
  还能看到
  `Dynamic Parameter`
  `PixelNormalWS`
  `CameraVectorWS`
  多个 `Multiply`
  `Add`
  `Subtract`
  `Lerp`
  型的中间运算节点
  右侧是主 `Material` 输出节点
- 连线集
  左侧若干贴图/参数节点先进入中部计算区
  `PivotPainter_PerObjectData` 的输出直接参与中部多条运算支路
  下方 `Dynamic Parameter` 支路也接入同一片运算网络
  多条结果线最终汇入右侧主材质输出节点
  说明石块外观与 Pivot Painter 变形是在同一张材质里统一完成的
- 设置/参数
  当前截图没有放大到足以逐个读取所有常量值
  但能确认材质预览球已使用默认灰石材外观
  下方 `Dynamic Parameter` 节点存在，说明 Niagara 会向这张材质传入运行时参数
- 输出/预览
  左侧球体显示灰白色石材表面
  说明材质不仅负责位移控制，也同时承担碎石本体的基础表面表现
- 可确认的制作结论
  这张图对应字幕里关于“showed how to scale stones”的说明
  作者把石块缩放、Pivot Painter 数据读取和材质表面表现合并进 `M_PivotPainter`
  这样 Niagara 只需要驱动少数动态参数，就能同时控制碎块运动和最终视觉结果
这一帧回到关卡里展示 `NS_TestPivotPainter` 的最终效果，同时在内容浏览器中定位 Unreal 自带的 Pivot Painter 材质函数来源，作为本节收束

- 当前场景
  关卡地面上形成一圈由地裂、火柱和发光碎块组成的完整火焰网络
  多个圆形命中点与裂纹主干相连
  零散火星和细碎粒子在空中继续上升
  说明 Pivot Painter 碎块逻辑已经能够和整个 AOE 系统共存
- 当前对象
  右侧选中的是 `NS_TestPivotPainter`
  `Location ≈ (763.0, 1909.0, 0.0)`
  `Scale = 1.0, 1.0, 1.0`
- 内容浏览器定位
  当前路径在
  `Engine/Content/Functions/Engine_MaterialFunctions02/PivotPainter`
  可见官方函数资源
  `PivotPainter_HierarchyData`
  `PivotPainter_PerObjectData`
  `PivotPainter_PerObjectData4`
  `PivotPainter_TreeData`
  `TreeAnimationSines`
  等
  其中 `PivotPainter_PerObjectData` 当前被高亮选中
- 可确认的制作结论
  这张图对应本节结尾的总结性质画面
  一方面验证了 `NS_TestPivotPainter` 在真实关卡中的运行结果
  另一方面明确指出所需的 Pivot Painter 材质函数可以直接在 Unreal 自带的 `Engine_MaterialFunctions02/PivotPainter` 路径下找到

## 补充视觉证据

### S02 00:05:29

这是 `NS_FX_GroundLineCrack` 中火焰发射器的补充图，重点是说明如何用 `Kill Particles` 按静态网格采样到的顶点色阈值，筛掉不该生成火焰的粒子

- 节点定义集
  系统名为 `NS_FX_GroundLineCrack`
  面板标题为 `Fire`
  其中有两个 emitter
  `Fire01`
  `Fire02`
  两者都包含
  `Emitter State`
  `Spawn Rate`
  `Set Emitter ThresholdMax`
  `Set Emitter ThresholdMin`
  `Initialize Particle`
  `Static Mesh Location`
  `Kill Particles`
  `Set Position`
  `Set TiltDir`
  `Set SpriteAlignment`
  `Color`
  `Dynamic Material Parameters`
  `Sprite Renderer`
- 当前选中逻辑
  右侧展开的是 `Fire01` 的 `Kill Particles`
  模块内部使用 `Boolean or Operation`
  包含两个 `Set Bool by Float Comparison`
- 连线/比较逻辑
  `Bool1`
  `A = Make Float from Linear Color(PARTICLES.STATIC MESH LOCATION.SampledVertexColor)`
  `Channel = R`
  `B = EMITTER.ThresholdMax`
  `Comparison Type = A Greater Than B`
  `Bool2`
  `A = Make Float from Linear Color(PARTICLES.STATIC MESH LOCATION.SampledVertexColor)`
  `Channel = R`
  `B = EMITTER.ThresholdMin`
  `Comparison Type = A Less Than B`
  两个比较结果经 `Boolean or Operation` 合并后用于决定是否 Kill
- 输出/预览
  左侧预览里只保留一小段细长裂纹火焰
  说明经过阈值筛选后，粒子只会出现在某个顶点色范围内
  时间线当前约 `1.10`
- 可确认的制作结论
  这张补图对应字幕里“in a node called kill particles”
  火焰不是在整条静态网格上平均生成
  而是先从 `Static Mesh Location` 采样顶点色，再把超出 `ThresholdMin` 到 `ThresholdMax` 区间的粒子直接剔除
  这样就能用同一条裂纹网格精确控制哪些位置冒火、哪些位置只保留裂纹本体

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


