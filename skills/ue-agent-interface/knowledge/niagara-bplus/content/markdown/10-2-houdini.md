# 10-2-Houdini烟雾模拟设置

# 10-2-Houdini烟雾模拟设置

## 关键术语

- `Color`、`UV`、`Normal`、`Houdini`、`材质`、`粒子`、`生命周期`、`速度`、`纹理`、`Niagara`、`Normalized Age`、`Material`、`序列`、`颜色`、`曲线`、`烟雾`、`Niagara System`、`Emitter`

## 分段知识

### 00:00:02-00:05:02 Color、Normal、粒子

- 本段定位：Color、Normal、粒子。
- 知识点：从15帧开始到80帧,应该可以烘焙纹理了。
- 知识点：用Sunlight解开键之后,需要适当调整一下光的方向。
- 知识点：烟雾的方向,光的方向是从这边来的。
- 知识点：根据我们现在用的地图来看,这样烟雾落下来会更明显。
- 知识点：制作翻书纹理节点。
- 知识点：再次也利用翻书纹理节点来继续工作。
- 知识点：运动实量纹理的作用是。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Color`、`纹理`、`粒子`、`生命周期`、`烟雾`。

**关键画面：**

这一帧处在“从 15 帧烘焙到 80 帧”的烘焙准备阶段，画面重点是用 `cam1` 视角检查主烟柱构图，并直接调 `sunlight1` 的方向，让烟雾的明暗朝向更符合后续要做的 Color、Normal 和翻书纹理输出。结合正文“应该可以烘焙纹理了”“用 Sunlight 解开键之后，需要适当调整一下光的方向”，这里不是继续做模拟，而是在对象层确定烘焙用的拍摄与受光关系。

`对象层级`

- 当前网络位于 `/obj`
- 可见对象包括：
  - `Geometry Smoke_01`
  - `Light sunlight1`
  - `Environment Light skylight1`
  - `cam1`

`当前对象`

- 当前选中对象：`sunlight1`
- 右侧参数面板位于 `Transform` 页签
- `Translate` 可见数值约为：
  - `X = -8.65956e-16`
  - `Y = 7.07107`
  - `Z = 7.07107`
- `Rotate` 可见数值约为：
  - `X = -45`
  - `Y = -7.01671e-15`
  - `Z = 0`

`视角与取景`

- 左侧视口当前通过 `cam1` 观察烟柱
- 时间轴停在 `80` 帧
- 烟柱主体已经形成完整上升轮廓，顶部团块、中段翻卷和底部细柱都进入镜头
- 画面中还可见一个被高亮选中的圆盘状辅助几何，位置在烟柱左前方偏中段，说明作者在烘焙前仍在对照场景中的辅助对象或发射体位置

`灯光`

- `sunlight1` 被明确选中，说明这一帧的操作核心是调主方向光
- 场景里同时保留 `skylight1`，说明作者使用“主方向光 + 环境光”的基础照明组合
- 当前 `sunlight1` 的平移和旋转都已偏离默认值，说明光照方向已经被专门摆到适合观察烟柱体积层次的位置

`输出/预览`

- 烟柱整体处于偏左受光、右侧偏暗的状态，能较清楚地区分顶部亮面与中下段阴影，这正是为后续 Color / Normal 烘焙做准备的典型检查方式
- 画面底部字幕可确认当前口述内容为“应该可以烘焙纹理了。用 Sunlight …”，与正文关于开始烘焙纹理、调整光方向的描述一致
- 这一帧没有显示材质节点或 Niagara 粒子栈本体，因此当前图能安全确认的是烘焙视角与灯光关系，而不是翻书纹理节点内部结构

`结果理解`

- 本图给出的关键信息是：在真正制作翻书纹理和运动矢量纹理前，作者先把烟柱在 `cam1` 下的构图与 `sunlight1` 的受光方向固定下来
- `80` 帧时间位置和已经成形的主烟柱说明前面的模拟结果已足够稳定，可以进入纹理烘焙阶段
- 这张图对应的安全结论是：本段开头先用对象层的相机与灯光确定烟雾朝向和明暗关系，为后续 Color、Normal 与翻书纹理输出建立统一的烘焙基准
这一帧正式切到翻书纹理输出节点，开始配置 `Labs Flipbook Textures` 的渲染输入与图集分辨率。结合正文“制作翻书纹理节点”“再次也利用翻书纹理节点来继续工作”，这里能直接确认作者已经不再只是观察烟柱，而是把相机、Pyro Bake Volume 和图集尺寸绑定到一个专门的翻书烘焙节点上。

`节点`

- 当前节点：`Labs Flipbook Textures`
- 节点名：`Smoke_01`
- 节点所在层级为 `out`
- 当前右侧参数面板停留在 `Render` 标签页

`Render Intermediate Images`

- `Start/End/Inc = 1 / 100 / 1`
- `Camera = /obj/SmokeCam_01`
- `Pyro Bake Volume Path = /obj/Smoke_01/pyrolook_billowy_smoke`

`图集分辨率`

- `Total Resolution = 4096 x 4096`
- `Resolution Per Frame = 512 x 512`
- `Columns/Rows = 8 / 8`

`输出路径与色彩`

- `Intermediate Directory = $HIP/render/${HIPNAME}.$OS/01/intermediate/`
- `3D Resolution Limit` 显示为针对 `4-11GB Graphics Cards` 的档位
- `Color Space = ACES sRGB (Best for Pyro)`

`视口与取景`

- 左上主视口使用 `SmokeCam_01` 观察烟柱
- 左下辅视口仍保留 `sunlight1` 视角，用来对照光向与体积受光关系
- 时间轴停在 `80` 帧，说明作者继续以已经定好的中后期烟柱形态为烘焙基准
- 主视口中的烟柱已经完整填充在烘焙边界框内，符合翻书贴图需要稳定占满输出框的要求

`输出/预览`

- 这张图同时给出了“烘焙相机”“体积来源”“单帧分辨率”“图集总分辨率”和“行列切片数”五类关键信息，已经足以复建基础翻书输出配置
- `512 x 512` 单帧搭配 `8 x 8` 行列，意味着图集中最多可容纳 64 帧切片；而当前渲染区间设为 `1-100`
- 因为本图没有展开后续重排或抽帧逻辑，所以只能确认当前中间图像阶段的输出范围，不应额外推断最终成品一定保留全部 100 帧

`结果理解`

- 这一帧标志着流程从“场景准备”进入“翻书纹理节点实际输出设置”，关键是把 `SmokeCam_01` 与 `pyrolook_billowy_smoke` 接到 `Labs Flipbook Textures`
- `4096` 总图集、`512` 单帧和 `8x8` 排布说明作者在以较高分辨率准备 Color/Normal 等翻书贴图的中间结果
- 这张图对应的安全结论是：作者使用 `Labs Flipbook Textures` 节点，以 `SmokeCam_01` 作为烘焙相机、`pyrolook_billowy_smoke` 作为体积来源，输出 ACES sRGB 工作流下的高分辨率中间翻书图集
这一帧继续停留在 `Labs Flipbook Textures` 节点，但重点已经从基础输出分辨率切到“当前到底要烘焙哪些通道”。结合本段标题里的 `Color、Normal`，这张图直接展示了翻书节点的 `Render Pass Control`：作者把颜色、法线、运动矢量和深度等多个输出通道并列列出，并在独立预览窗口中检查其中一个已经烘焙出的结果。

`节点`

- 当前节点：`Labs Flipbook Textures`
- 节点名：`Smoke_01`
- 当前页签：`Render`
- 关注区域：`Render Pass Control`

`Render Pass Control`

- 可见的通道条目包括：
  - `Render Final Color`
  - `Render Non-emissive Color`
  - `Render MDC / MDC Normal`
  - `Render Surface Normal`
  - `Render Motion Vector`
  - `Render Depth`
- 每一行左侧都显示 `Viewport` 或 `OpenGL ROP` 类型的输出来源选择
- 顶部按钮显示为 `Render All Passes`

`烘焙范围`

- `Start/End/Inc = 15 / 80 / 1`
- `Camera = /obj/SmokeCam_01`
- `Pyro Bake Volume Path = /obj/Smoke_01/pyrolook_billowy_smoke`

`图集分辨率`

- `Total Resolution = 4096 x 4096`
- `Resolution Per Frame = 512 x 512`
- `Columns/Rows = 8 / 8`
- `Color Space = ACES sRGB (Best for Pyro)`

`预览窗口`

- 中央弹出的独立场景窗口显示一张黑底、带蓝绿黄颜色分布的烟雾图像
- 这类伪彩色预览明显不是普通最终颜色烟雾，更像法线类或运动/方向信息类的中间输出检查画面
- 由于当前截图没有高亮指示究竟选中了哪一行通道，不能武断指定它一定是 `MDC Normal`、`Surface Normal` 或 `Motion Vector` 中的某一个

`视口与时间`

- 左上视口仍挂在 `SmokeCam_01` 视角
- 左下小视口继续保留 `sunlight1` 视角作为辅助参照
- 时间轴当前停在 `32` 帧，底部状态栏显示正在 `Flipbooking frame 29 (15 to 78)`，说明作者正在区间内逐帧烘焙或预览翻书序列，而不是只静态看一帧

`结果理解`

- 与上一张相比，这里新增的关键信息是：翻书节点并不是只输出一套最终颜色贴图，而是并行准备了颜色、法线、运动矢量、深度等多种通道
- `15 -> 80` 的烘焙范围与正文前面“从 15 帧开始到 80 帧”完全对上，说明作者已经把输出区间从早期的宽泛测试值收束到教程实际采用的帧段
- 这张图对应的安全结论是：本段第三张图用 `Labs Flipbook Textures` 的 `Render Pass Control` 统一管理多通道翻书输出，并通过中间预览窗口检查至少一个非最终颜色通道的结果是否可用

### 00:05:02-00:09:50 材质、速度、颜色

- 本段定位：材质、速度、颜色。
- 知识点：只有在需要运动实量纹理时这样渲染。
- 知识点：如果不是特殊情况, 一般情况下只用最后颜色。
- 知识点：现在皮革颜色就是从这个方向打光。
- 知识点：绿色颜色就是从这个方向打光的通道。
- 知识点：获取纹理路径的话。
- 知识点：现在这个会生成从上和从下照说的纹理。
- 知识点：把这些纹理的方向按通道获取。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`、`速度`、`颜色`、`烟雾`。

**关键画面：**

这一帧进入下一小节“材质、速度、颜色”，但画面仍在 `Labs Flipbook Textures` 节点内，说明作者先用翻书输出结果来解释不同光向/通道对应的颜色信息，而不是马上切回材质图。结合正文“只有在需要运动矢量纹理时这样渲染”“一般情况下只用最后颜色”“绿色颜色就是从这个方向打光的通道”，这里可安全确认作者正在对多通道翻书序列做逐帧预览，重点观察非最终颜色通道在整段烟柱上的分布变化。

`节点`

- 当前节点：`Labs Flipbook Textures`
- 节点名：`Smoke_01`
- 当前页签：`Render`
- 关注区域仍为 `Render Pass Control`

`Render Pass Control`

- 当前仍可见以下通道条目：
  - `Render Final Color`
  - `Render Non-emissive Color`
  - `Render MDC / MDC Normal`
  - `Render Surface Normal`
  - `Render Motion Vector`
  - `Render Depth`
- 顶部按钮仍为 `Render All Passes`

`烘焙范围与来源`

- `Start/End/Inc = 15 / 80 / 1`
- `Camera = /obj/SmokeCam_01`
- `Pyro Bake Volume Path = /obj/Smoke_01/pyrolook_billowy_smoke`
- `Total Resolution = 4096 x 4096`
- `Resolution Per Frame = 512 x 512`
- `Columns/Rows = 8 / 8`
- `Color Space = ACES sRGB (Best for Pyro)`

`预览窗口`

- 中央独立预览窗口仍显示黑底烟雾图像，但这次烟柱已经拉得更高、更完整
- 图像中绿色占据主体大面积区域，顶部和边缘则混有蓝色与少量暖色
- 这说明当前作者关注的是一个方向性很强的辅助通道，而不是普通最终颜色输出
- 由于截图没有明确指示当前激活的是哪一行输出，仍不能把它武断指认为 `Motion Vector`、`MDC Normal` 或 `Surface Normal` 的唯一一种

`视口与时间`

- 左上主视口仍挂在 `SmokeCam_01`
- 左下辅视口继续保留 `sunlight1` 视角
- 时间轴当前停在 `70` 帧
- 底部状态栏显示正在 `Flipbooking frame 70 (15 to 78) -> Rendering`
- 与上一张的中前段帧相比，这里已经推进到区间后半段，说明作者在检查整段翻书序列而不是只抽看前几帧

`结果理解`

- 这张图补足了一个关键事实：作者会沿着 `15-80` 帧整段播放或渲染辅助通道，确认颜色/方向信息在烟柱生命周期内是否连续稳定
- 结合正文里“只有在需要运动矢量纹理时这样渲染”“一般情况下只用最后颜色”，可以安全理解为：这些附加通道属于按需输出，不是每次都作为最终游戏贴图主输出
- 这张图对应的安全结论是：本小节开头先通过 `Labs Flipbook Textures` 的多通道翻页预览，检查方向性颜色通道在后段帧上的表现，为后续解释材质、速度和颜色纹理各自用途做铺垫
这一帧继续位于 `Labs Flipbook Textures` 的多通道输出阶段，但与上一张相比，这次可以更明确地确认作者正在检查 `motion_vector` 结果。结合正文“只有在需要运动矢量纹理时这样渲染”“把这些纹理的方向按通道获取”，这里展示的是：在同样的 `15-80` 帧翻书区间内，作者打开运动矢量贴图对应的预览窗口，观察烟柱整体运动方向在贴图中的颜色编码是否连贯。

`节点`

- 当前节点：`Labs Flipbook Textures`
- 节点名：`Smoke_01`
- 当前页签：`Render`
- 关注区域仍为 `Render Pass Control`

`Render Pass Control`

- 当前仍可见以下通道条目：
  - `Render Final Color`
  - `Render Non-emissive Color`
  - `Render MDC / MDC Normal`
  - `Render Surface Normal`
  - `Render Motion Vector`
  - `Render Depth`
- 顶部按钮仍为 `Render All Passes`

`烘焙范围与来源`

- `Start/End/Inc = 15 / 80 / 1`
- `Camera = /obj/SmokeCam_01`
- `Pyro Bake Volume Path = /obj/Smoke_01/pyrolook_billowy_smoke`
- `Total Resolution = 4096 x 4096`
- `Resolution Per Frame = 512 x 512`
- `Columns/Rows = 8 / 8`
- `Color Space = ACES sRGB (Best for Pyro)`

`预览窗口`

- 中央独立预览窗口顶部标签中可直接见到 `motion_vector`
- 黑底预览中的烟柱以亮绿色为主体，并混有红色暗部与局部较暗区域
- 这种强烈的方向性色彩分布更符合运动矢量类贴图的检查方式，而不是最终颜色烟雾或普通非自发光颜色
- 预览里的烟柱已经形成完整的上升主干和顶部扩散团块，说明作者是在中后期帧段检查整团烟的运动方向编码，而不是只看源头附近的小范围速度

`视口与时间`

- 左上主视口仍挂在 `SmokeCam_01`
- 左下辅视口继续保留 `sunlight1` 视角
- 时间轴当前停在 `68` 帧
- 底部状态栏显示正在 `Flipbooking frame 68 (15 to 78)` 且后续有 `Loading geometry`/渲染过程提示
- 这说明作者仍在逐帧回放或生成整段运动矢量序列，而不是只查看单张静态输出

`结果理解`

- 这张图把上一张“辅助方向通道”的判断进一步具体化为 `motion_vector`，因此能直接支持正文里关于“只有需要运动矢量纹理时才这样渲染”的说明
- 运动矢量贴图并不是总要随最终颜色一起交付，而是为了需要方向速度信息的特殊材质或后处理用途才额外输出
- 这张图对应的安全结论是：作者在 `Labs Flipbook Textures` 内单独检查 `motion_vector` 通道，确认 `15-80` 帧烟柱在翻书贴图里的方向编码随动画推进保持连续可用
这一帧是第二小节的收束图，画面已经从 `Labs Flipbook Textures` 切回 `Smoke_02` 内部的烟雾求解链，说明作者在讲完颜色/速度类贴图用途后，又回到实际模拟参数上确认当前烟雾版本是否成立。结合正文“材质、速度、颜色”到下一段“纹理、烟雾、缓存”的过渡，这里可安全确认：当前 `pyrosolver_billowy_smoke` 的细分辨率、缓存链和一组关键流体参数已经被拿来作为后续缓存与纹理流程的基础版本。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `filecache1`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 当前层级位于 `Smoke_02`
- 选中节点：`pyrosolver_billowy_smoke`
- 当前右侧参数页签：`Output`
- 节点下方可见求解尺度 `0.05`

`缓存链`

- `pyrosolver_billowy_smoke` 后面已经接入 `filecache1`
- `filecache1` 下方可见缓存文件名样式：`Ex_01_SmokePlume_01.filecache1`
- 文件名下方还能看到版本化缓存片段 `v2.$F4.bgeo.sc`
- 这说明当前流程不是单纯实时预览，而是已经进入“求解结果 -> 缓存 -> 外观/渲染”的稳定生产链

`当前可见参数`

- `Buoyancy Scale = 0.3`
- `Ambient Temp (K) = 300`
- `Reference Temp (K) = 3000`
- `Gravity Acceleration = 9.8`
- `Gravity Direction = (0, -1, 0)`
- `Wind Speed = 1`
- `Wind Direction = (1, 0, 0)`
- `Disturbance = 5`
- `Mode = Block-Based`
- `Base Block Size = 0.1`
- `Roughness = 0.5`
- `Pulse Length = 0.2`
- `Max Octaves = 3`
- `Lacunarity = 2.1`
- `Threshold Field = density`
- `Threshold Range = 0.05 -> 0`
- `Use Control Field` 已启用
- `Control Field = speed`
- `Control Range = 0 -> 5`
- 下方还能看到 `Turbulence` 分组，且 `Noise Type = Analytic Fast Simplex Noise`

`视口与时间`

- 左上主视口仍挂在 `SmokeCam_01`
- 左下辅视口继续保留 `sunlight1` 视角
- 两个视口当前都没有显示烟体，说明这张图的关注点已经不是翻书预览画面本身，而是网络与求解器参数
- 时间轴停在 `80` 帧，和前文整段烘焙/检查区间保持一致

`结果理解`

- 这张图给出的关键证据是：在讲解颜色通道、速度纹理用途之后，作者把最终可用的烟雾版本落回到一个细分辨率 `0.05`、已接缓存链的 Pyro Solver 配置上
- `filecache1` 与版本化 `v2.$F4.bgeo.sc` 文件名说明这一阶段已经不是临时试验，而是在为后续缓存、纹理和外观流程准备可复用版本
- 这张图对应的安全结论是：第二小节末尾通过回看 `pyrosolver_billowy_smoke` 的关键浮力、风场、扰动和控制场参数，确认当前 `Smoke_02` 求解结果可以作为后续缓存与纹理处理的基础烟雾版本

### 00:09:55-00:14:33 纹理、烟雾、缓存

- 本段定位：纹理、烟雾、缓存。
- 知识点：就可以根据需要从需要这种形态相似的形态开始。
- 知识点：通过模拟测试各种形式,你的个人库就会变得更广。
- 知识点：这种序列形式的纹理不需要经常使用。
- 知识点：而且那些储备了大量纹理的人不需要进行那么多模拟。
- 知识点：只在需要时根据合适的形式制作合适的感觉。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`序列`、`烟雾`。

**关键画面：**

这一帧进入“纹理、烟雾、缓存”小节后，仍然停留在 `Smoke_02` 的求解网络里，但关注点已经从上一段的颜色/速度通道说明，转到“怎样把一个可用的烟雾版本整理成后续可复用的基础模板”。结合正文“根据需要从形态相似的形态开始”“通过模拟测试各种形式，个人库会更广”，这里能确认作者正在回看 `pyrosolver_billowy_smoke` 的通用与模拟级参数，强调今后遇到相似需求时，可以从这套已验证的基础形态继续调整，而不必每次从零开始。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `filecache1`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 当前层级位于 `Smoke_02`
- 选中节点：`pyrosolver_billowy_smoke`
- 节点下方可见求解尺度 `0.05`
- 当前右侧参数区域显示的是 `Setup` 下的通用与 `Simulation` 参数

`General`

- `Voxel Size = 0.05`
- `Velocity Voxel Scale = 1`
- `Time Scale = 1`

`Simulation`

- `Simulation Type = Sparse`
- `Global Substeps = 1`
- `Min Substeps = 1`
- `Max Substeps = 1`
- `CFL Condition = 1`
- `Advection-Reflection = Single-Project`
- `Reflection Amount = 0.95`
- `Cache Memory (MB) = 5000`

`缓存链`

- `pyrosolver_billowy_smoke` 后接 `filecache1`
- `filecache1` 下方可见 `Ex_01_SmokePlume_01.filecache1`
- 文件名下方还能看到 `v2.$F4.bgeo.sc`
- 说明当前不是单纯口头回顾，而是正在基于已经缓存化的版本讨论“哪些模拟形态值得保留做库存”

`视口与时间`

- 左上主视口仍挂在 `SmokeCam_01`
- 左下辅视口继续保留 `sunlight1` 视角
- 两个视口都未显示当前烟体预览，说明这张图的核心是参数与缓存流程，而不是即时视觉效果
- 时间轴停在 `80` 帧
- 底部字幕可读到“接下来同样的情况 时间尺度可以看得更快一点”，这和当前画面中 `Time Scale` 参数直接对应

`结果理解`

- 这张图补足的关键点是：作者并不把烟雾序列纹理当成一次性产物，而是把已经验证过的模拟版本保留为“相似形态的起点”
- `Voxel Size = 0.05`、`Simulation Type = Sparse`、固定的 `Substeps` 与 `Cache Memory = 5000` 这些参数共同说明，这是一套偏稳定、可重复复用的基础求解配置
- 这张图对应的安全结论是：本小节开头先回看 `pyrosolver_billowy_smoke` 的通用求解设置和缓存链，把当前 `Smoke_02` 版本当作后续同类烟雾形态可复用的模板与库存来源
这一帧从求解器参数回切到缓存后的外观节点 `pyrolook_billowy_smoke`，说明作者已经认为当前模拟本身基本完成，接下来重点是把烟雾的上下层次和视觉块感整理成可直接带到虚幻里的效果。结合底部字幕“完成就可以了，现在我们是把部分分成块感，带到虚幻里做一个效果”，这里能确认当前讨论的是缓存结果的渲染外观拆分，而不是继续改模拟。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `filecache1`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 当前层级显示为 `Smoke_01`
- 选中节点：`pyrolook_billowy_smoke`
- 节点类型标题：`Pyro Bake Volume`
- 顶部 `Assign Material` 已启用
- 材质路径为 `matnet/Pyro_Shader`

`当前页签`

- 当前位于 `Smoke` 页签

`Smoke`

- `Density Scale = 5`
- `Smoke Color` 三个数值框为 `0.5 / 0.5 / 0.5`
- `Smoke Color` 模式为 `Constant`
- `Shadow Color` 三个数值框为 `0.9 / 0.9 / 1`
- `Shadow Density = 1`
- `Ambient Shadow Scale = 0.5`

`缓存链`

- `pyrosolver_billowy_smoke` 下方仍可见求解尺度 `0.05`
- 中间 `filecache1` 仍显示缓存名 `Ex_01_SmokePlume_01.filecache1`
- 文件版本片段可见为 `v1.$F4.bgeo.sc`
- 说明当前外观节点读入的是一个已经落盘的缓存版本，再在其上调视觉表现

`视口与形态`

- 左上主视口使用 `SmokeCam_01` 观察完整烟柱
- 左下辅视口保留 `sunlight1` 视角
- 烟柱已经形成明显的“顶部团块 + 中段主柱 + 底部块状堆积”分层结构
- 这与字幕里提到的“分成块感”相吻合，说明作者关注的是把烟柱拆成适合游戏内组合使用的视觉段落，而不是单一连续体

`结果理解`

- 这张图给出的关键证据是：在确定模拟和缓存之后，作者会回到 `Pyro Bake Volume` 节点直接控制烟雾密度、颜色和阴影关系，以便把烟雾外观整理成更适合资产化的形态
- 这里强调的“块感”并不是重新做一套新模拟，而是基于当前缓存结果，通过外观与分层理解去提炼出可带入虚幻的上部/下部烟块结构
- 这张图对应的安全结论是：本小节第二张图用 `pyrolook_billowy_smoke` 的 Smoke 外观参数和已缓存烟体结果，确认当前烟柱已经可以按块状层次拆解并带入 Unreal 做后续效果组合
这一帧继续停留在缓存后的生产链上，但关注点已经从 `pyrolook_billowy_smoke` 的外观调节，进一步收束到 `filecache1` 本身。结合底部字幕“现在不能碰烟帽球，得做个新相机”，这里可以确认作者一边检查缓存读取版本，一边意识到当前 `SmokeCam_01` 的取景已经不适合继续处理烟柱顶部区域，因此需要为后续纹理/镜头工作单独再建一个相机视角。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `filecache1`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 当前层级位于 `Smoke_02`
- 选中节点：`filecache1`
- 节点类型标题：`File Cache`
- `Load from Disk` 已启用
- `Time Dependent Cache` 已启用

`缓存路径与命名`

- `File Path = Constructed`
- `Base Name = Ex_01_SmokePlume_01.filecache1`
- 文件扩展名为 `bgeo.sc`
- `Base Folder = $HIP/geo`
- `Version = 2`

`缓存区间`

- `Evaluate As = Frame Range`
- 右侧模式为 `Simulation`
- `Start/End/Inc = 1 / 100 / 1`
- `Substeps = 1`
- `Load = All Geometry`

`关联状态`

- `pyrosolver_billowy_smoke` 下方仍可见 `0.05`
- 说明当前读取的缓存仍建立在细分辨率 `0.05` 的模拟结果之上
- `filecache1` 下方同样可见 `v2.$F4.bgeo.sc`，与右侧 `Version = 2` 相互印证

`视口与取景`

- 左上主视口仍挂在 `SmokeCam_01`
- 左下辅视口继续保留 `sunlight1` 视角
- 主视口中的烟柱已经显得较为发散、顶部靠近取景上沿，不再像前一张那样利于稳定观察顶部团块
- 字幕明确说明当前视角下“不能碰烟帽球”，因此需要新相机来重新覆盖烟柱上部区域
- 时间轴停在 `100` 帧，说明作者此时已经把关注点推进到缓存区间末端，而不是只看前面用于烘焙纹理的 `80` 帧

`结果理解`

- 这张图补足了一个关键过渡：当烟柱缓存版本确定后，后续问题不再主要是模拟或缓存命名，而是“现有相机是否还能覆盖要处理的烟柱部位”
- `Version = 2` 和 `Load from Disk` 说明作者此时已经接受当前缓存结果，接下来更多是在围绕镜头与资产使用方式做调整
- 这张图对应的安全结论是：本小节第三张图通过 `filecache1` 确认读取 `v2` 缓存版本，同时判断当前 `SmokeCam_01` 不足以处理烟柱顶部，需要新增相机视角以继续后续纹理或效果制作

### 00:14:33-00:19:28 UV、粒子、颜色

- 本段定位：UV、粒子、颜色。
- 知识点：考虑到以后修改,这样设置会更好的话。
- 知识点：现在背景色调有点亮,因为这里的天空光。
- 知识点：这部分也重新选了这个针区间,还有最终颜色。
- 知识点：刚才在编译器自断的那个比例值也适当调整一下。
- 知识点：数值弱的时候和强的时候有什么不同? 相机再拉近点也没关系。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`粒子`、`颜色`、`烟雾`。

**关键画面：**

这一帧进入 “UV、粒子、颜色” 小节后，首先落实了上一张里“得做个新相机”的判断：作者已经在对象层新建并选中了 `SmokeCam_02`，用它重新覆盖烟柱顶部和中段区域，为后续 UV、颜色与粒子效果的观察提供更合适的镜头。结合正文“考虑到以后修改，这样设置会更好”“相机再拉近点也没关系”，这里能直接确认是在做新的相机布局，而不是继续调整烟雾本体。

`对象层级`

- 当前网络位于 `/obj`
- 可见对象包括：
  - `Geometry Smoke_01`
  - `Geometry Smoke_02`
  - `Light sunlight1`
  - `Environment Light skylight1`
  - `Camera SmokeCam_01`
  - `Camera SmokeCam_02`

`当前对象`

- 当前选中对象：`SmokeCam_02`
- 右侧参数面板类型：`Camera`
- 当前页签：`View`

`相机参数`

- `Resolution = 512 x 512`
- `Pixel Aspect Ratio = 1`
- `Projection = Perspective`
- `Focal Length = 50`，单位为 `millimeters`
- `Aperture = 41.4214`
- `Near Clipping = 0.1`
- `Far Clipping = 44352.9`
- `Enable Background Image` 已启用
- `Screen Window X/Y = 0 / 0`
- `Screen Window Size = 1 / 1`
- `Left Crop = 0`
- `Right Crop = 1`
- `Bottom Crop = 0`
- `Top Crop = 1`

`视口与取景`

- 左上主视口当前使用 `SmokeCam_02`
- 左下辅视口仍保留 `sunlight1` 视角
- 新相机画面中，烟柱顶部团块与中段主柱仍在画面中心附近，但整体比先前更贴近镜头
- 背景比前几张更亮，和正文里“背景色调有点亮，因为这里的天空光”相呼应，说明当前相机设置要同时考虑天空光背景对观察颜色的影响

`结果理解`

- 这张图直接证明：面对 `SmokeCam_01` 不能继续稳定处理烟帽顶部的问题，作者没有回头重做烟雾，而是通过新增 `SmokeCam_02` 解决取景和后续观察问题
- `512 x 512` 的相机分辨率与前面翻书纹理单帧尺寸一致，说明新相机并不是随便搭的观察视角，而是明显服务于后续纹理/序列输出的一致画幅
- 这张图对应的安全结论是：本小节首图通过新增并配置 `SmokeCam_02`，把镜头重新对准需要重点处理的烟柱区域，为之后的 UV、粒子和颜色相关调试提供新的标准取景
这一帧把上一张新建的 `SmokeCam_02` 真正接入翻书输出流程：画面已经切到 `Labs Flipbook Textures` 的 `Smoke_02` 节点，并且新的烘焙区间、相机和体积来源都已改成针对这一局部烟形的配置。结合正文“这部分也重新选了这个帧区间，还有最终颜色”“刚才在编译器自断的那个比例值也适当调整一下”，这里能确认作者正在围绕新相机 `SmokeCam_02` 和新的帧段，为局部烟形重新出一套最终颜色/通道纹理。

`节点`

- 当前节点：`Labs Flipbook Textures`
- 节点名：`Smoke_02`
- 当前页签：`Render`
- 关注区域：`Render Pass Control`

`Render Pass Control`

- 当前仍可见的通道条目包括：
  - `Render Final Color`
  - `Render Non-emissive Color`
  - `Render MDC / MDC Normal`
  - `Render Surface Normal`
  - `Render Motion Vector`
  - `Render Depth`
- 顶部按钮仍为 `Render All Passes`

`烘焙范围与来源`

- `Start/End/Inc = 30 / 100 / 1`
- `Camera = /obj/SmokeCam_02`
- `Pyro Bake Volume Path = /obj/Smoke_02/pyrolook_billowy_smoke`
- `Total Resolution = 4096 x 4096`
- `Resolution Per Frame = 512 x 512`
- `Columns/Rows = 8 / 8`
- `Color Space = ACES sRGB (Best for Pyro)`

`预览窗口`

- 中央独立预览窗口顶部标签显示的是 `mdc_*` 前缀的通道窗口
- 黑底预览中只保留一个更紧凑的局部烟团，而不是之前整根烟柱
- 烟团内部仍有明显的蓝/绿/黄分布，说明当前检查的仍是方向或法线相关辅助通道，而不是单纯最终颜色
- 由于窗口标签被截断，不能把它进一步武断指定为 `MDC Normal` 的唯一确定子项，但可以确认它属于 `mdc` 系列输出

`视口与时间`

- 左上主视口已经切到 `SmokeCam_02`
- 左下辅视口继续保留 `sunlight1` 视角
- 左上主视口当前为黑底，说明此时主工作重心已经从场景观察切到翻书输出窗口检查
- 时间轴当前停在 `37` 帧
- 底部状态栏显示正在 `Flipbooking frame 36 (30 to 93) -> Rendering`
- 这说明新的输出区间已经从原先更长的全段，收束到针对局部烟形的 `30-100` 帧范围

`结果理解`

- 这张图给出的关键证据是：新增 `SmokeCam_02` 后，作者并不是只拿它做观察，而是立刻基于它新建/切换到 `Smoke_02` 的翻书输出节点，并重设了帧区间
- `30 -> 100` 的区间与更紧凑的局部烟团取景，说明这一阶段开始针对特定局部形态单独产出纹理，而不是继续使用整根烟柱的统一翻书结果
- 这张图对应的安全结论是：本小节第二张图通过 `Labs Flipbook Textures / Smoke_02`，把新的 `SmokeCam_02` 和新的局部帧区间接入翻书输出流程，并检查 `mdc` 系列辅助通道在局部烟形上的贴图结果
这一帧是 `UV、粒子、颜色` 小节的收束图，重点已经不再是某一帧的预览，而是确认 `Smoke_02` 这套新局部翻书方案已经整理成独立输出节点并完成生成。结合底部字幕“质量也能随之提升”，这里可安全确认作者的结论是：通过重新划分局部烟形、重建相机和帧区间后，输出结果会更聚焦，贴图质量也会随之提高。

`节点`

- 当前层级位于 `out`
- 画面中可见两个翻书输出节点：
  - `Labs Flipbook Textures / Smoke_01`
  - `Labs Flipbook Textures / Smoke_02`
- 当前选中节点：`Smoke_02`
- 当前页签：`Render`

`Render Pass Control`

- 右侧仍可见通道条目：
  - `Render Final Color`
  - `Render Non-emissive Color`
  - `Render MDC / MDC Normal`
  - `Render Surface Normal`
  - `Render Motion Vector`
  - `Render Depth`
- 顶部按钮仍为 `Render All Passes`

`烘焙范围与来源`

- `Start/End/Inc = 30 / 100 / 1`
- `Camera = /obj/SmokeCam_02`
- `Pyro Bake Volume Path = /obj/Smoke_02/pyrolook_billowy_smoke`
- `Total Resolution = 4096 x 4096`
- `Resolution Per Frame = 512 x 512`
- `Columns/Rows = 8 / 8`
- `Color Space = ACES sRGB (Best for Pyro)`

`完成状态`

- 左上主视口当前为黑底空视图，没有再显示正在翻页的中间烟帧
- 中央网络中 `Smoke_02` 节点保持选中，但没有弹出单独的预览窗口
- 底部状态栏直接显示 `Flipbook generation complete`
- 这说明当前流程已经从“检查某个中间通道是否正确”推进到“这套局部翻书贴图已经生成完成”

`结构变化`

- `Smoke_01` 与 `Smoke_02` 两个输出节点并列存在
- 说明作者没有覆盖原先整段烟柱方案，而是把新的局部烟形方案作为第二套独立翻书输出保留下来
- 这样后续既可以复用原有整段烟柱，也可以单独使用新相机裁出的局部烟团版本

`结果理解`

- 这张图给出的关键证据是：通过新建 `SmokeCam_02` 和新的 `Smoke_02` 翻书节点，作者已经把“局部烟形重做一套贴图”的流程真正落地为独立产物
- 并列保留 `Smoke_01` 与 `Smoke_02` 也符合本段关于“考虑到以后修改，这样设置会更好”的思路，因为后续可在不同局部形态之间灵活切换
- 这张图对应的安全结论是：本小节末尾确认 `Smoke_02` 的局部翻书贴图已完成生成，并且新的局部方案会带来更聚焦、更高质量的纹理结果，同时保留为与 `Smoke_01` 并行的独立资产

### 00:19:28-00:22:12 材质、纹理、缓存

- 本段定位：材质、纹理、缓存。
- 知识点：这样导出我像刚才一样最后烘焙纹理。
- 知识点：这样某种程度上Hodini在游戏资源制作方面。
- 知识点：但那种意愿在特效方面现在硬件上无法积极使用。
- 知识点：目前还是追求基于纹理的资源制作。
- 知识点：我们觉得能使用的纹理就是有一定限制的。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`。

**关键画面：**

这一帧进入 “材质、纹理、缓存” 小节后，延续的是上一段已经建立好的 `Smoke_02` 局部翻书方案，但当前重点进一步落到“导出后最终只需要像前面一样再烘焙一次纹理即可”。结合正文“这样导出我像刚才一样最后烘焙纹理”“目前还是追求基于纹理的资源制作”，这里能确认作者正在以 `Smoke_02` 的局部翻书输出为基础，检查导出前的辅助通道结果，并强调最终资源仍会回到基于纹理的使用方式。

`节点`

- 当前节点：`Labs Flipbook Textures`
- 节点名：`Smoke_02`
- 当前页签：`Render`
- 关注区域：`Render Pass Control`

`Render Pass Control`

- 当前可见的通道条目包括：
  - `Render Final Color`
  - `Render Non-emissive Color`
  - `Render MDC / MDC Normal`
  - `Render Surface Normal`
  - `Render Motion Vector`
  - `Render Depth`
- 顶部按钮仍为 `Render All Passes`

`烘焙范围与来源`

- `Start/End/Inc = 30 / 100 / 1`
- `Camera = /obj/SmokeCam_02`
- `Pyro Bake Volume Path = /obj/Smoke_02/pyrolook_billowy_smoke`
- `Total Resolution = 4096 x 4096`
- `Resolution Per Frame = 512 x 512`
- `Columns/Rows = 8 / 8`
- `Color Space = ACES sRGB (Best for Pyro)`

`预览窗口`

- 中央独立预览窗口顶部标签可直接读到 `motion_vector`
- 黑底预览里的局部烟团以绿色为主体，并在左侧和上缘带有明显红色/暗色区
- 这说明当前作者仍在检查运动矢量类辅助通道，而不是普通最终颜色贴图
- 与前一小节的 `Smoke_02` 一致，当前查看的是局部烟形在新相机下的方向编码结果

`视口与时间`

- 左上主视口仍挂在 `SmokeCam_02`
- 左下辅视口继续保留 `sunlight1` 视角
- 左上主视口当前保持黑底空视图，主工作重心依旧是独立翻书预览窗口
- 时间轴当前停在 `90` 帧
- 底部状态栏显示正在 `Flipbooking frame 90 (30 to 93)` 且伴随 `Loading geometry`
- 说明作者正在导出区间后段检查局部烟团的辅助通道表现

`结果理解`

- 这张图给出的关键证据是：即便进入“材质、纹理、缓存”小节，作者仍把 `Smoke_02` 的局部翻书输出作为核心中间资产，并继续检查 `motion_vector` 等辅助贴图
- 结合字幕“导出后，像刚才一样，最后烘焙纹理就可以了”，可以安全理解为这些辅助通道是导出链中的中间检查项，而最终交付仍以烘焙出的纹理资源为主
- 这张图对应的安全结论是：本小节首图延续 `Smoke_02` 的局部翻书流程，通过检查 `motion_vector` 导出结果，确认这套局部烟形可以沿用到最终的纹理烘焙与游戏资源制作流程中
这一帧把工作重心从 `Render` 页签推进到 `Export` 页签，开始定义最终会导出哪些纹理文件，以及每张导出纹理如何打包各个通道。结合正文“目前还是追求基于纹理的资源制作”“我们觉得能使用的纹理就是有一定限制的”，这里能直接确认作者已经不只是在检查中间结果，而是在整理真正准备交付到游戏资源里的贴图结构。

`节点`

- 当前节点：`Labs Flipbook Textures`
- 节点名：`Smoke_02`
- 当前页签：`Export`

`导出基础信息`

- `Export Directory = $HIP/render/${HIPNAME}.$OS/1/`
- `Asset Name = ${OS}`
- 顶部可见导出纹理页签：
  - `Tex 1`
  - `Tex 2`
  - `Tex 3`
  - `Tex 4`
  - `Tex 5`
- 页面说明文字提示：打包通道必须匹配导出分辨率，分辨率应在 `Composite` 页签中设置

`Output Texture 1`

- 输出文件名模式：`chs("expdir")` `chs("asset")` `_FC.tga`
- 通道映射：
  - `FinalColor.r`
  - `FinalColor.g`
  - `FinalColor.b`
  - `FinalColor.a`

`Output Texture 2`

- 输出文件名模式：`chs("expdir")` `chs("asset")` `_ECD.tga`
- 通道映射：
  - `Emissive.r`
  - `Emissive.g`
  - `Emissive.b`
  - `Depth`

`Output Texture 3`

- 输出文件名模式：`chs("expdir")` `chs("asset")` `_MDC1.tga`
- 通道映射：
  - `MDC1.r`
  - `MDC1.g`
  - `MDC1.b`
  - `MDC1.a`

`Output Texture 4`

- 输出文件名模式：`chs("expdir")` `chs("asset")` `_MDC2.tga`
- 通道映射：
  - `MDC2.r`
  - `MDC2.g`
  - `MDC2.b`
  - `MDC2.a`

`Output Texture 5`

- 输出文件名模式：`chs("expdir")` `chs("asset")` `_MVN.tga`
- 通道映射：
  - `MotionVector.r`
  - `MotionVector.g`
  - `Normal.r`
  - `Normal.g`

`结构状态`

- 中央网络中并列保留：
  - `Labs Flipbook Textures / Smoke_01`
  - `Labs Flipbook Textures / Smoke_02`
- 当前选中的是 `Smoke_02`
- 左上主视口仍挂在 `SmokeCam_02`
- 底部状态栏显示 `Flipbook generation complete`

`结果理解`

- 这张图给出的关键证据是：作者已经把 `Smoke_02` 的局部翻书流程明确落地为 5 张可导出的贴图文件，而不是停留在 Houdini 内部预览
- 通道打包方式也很明确：最终颜色单独导出，发光与深度合并，MDC 拆成两张，运动矢量与部分法线打包在 `_MVN.tga`
- 这张图对应的安全结论是：本小节第二张图通过 `Export` 页签定义了 `Smoke_02` 的最终贴图资产结构，为后续 Unreal 材质侧读取这些打包纹理提供了可复建的文件与通道约定
这一帧是 `材质、纹理、缓存` 小节的收束图，画面重新回到 `Smoke_02` 内部的缓存链上，说明作者已经把“局部烟形的贴图如何导出”和“缓存结果如何与材质流程配合”视为同一个完整资产生产流程。结合底部字幕“我们会和材质一起进行”，这里能直接确认：后续不是单独看缓存、也不是单独看纹理，而是把当前缓存烟体、翻书贴图与 Unreal 材质一起联动使用。

`节点链`

- `smoke_base`
- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `filecache1`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

`当前节点`

- 当前层级位于 `Smoke_02`
- 选中节点：`filecache1`
- 节点类型标题：`File Cache`
- `Load from Disk` 已启用
- `Time Dependent Cache` 已启用

`缓存路径与命名`

- `File Path = Constructed`
- `Base Name = Ex_01_SmokePlume_01.filecache1`
- 文件扩展名为 `bgeo.sc`
- `Base Folder = $HIP/geo`
- `Version = 2`

`缓存区间`

- `Evaluate As = Frame Range`
- 右侧模式为 `Simulation`
- `Start/End/Inc = 1 / 100 / 1`
- `Substeps = 1`
- `Load = All Geometry`

`关联状态`

- `pyrosolver_billowy_smoke` 下方仍可见 `0.05`
- `filecache1` 下方继续显示 `v2.$F4.bgeo.sc`
- 说明这一小节最后并没有换掉缓存版本，而是在继续沿用 `v2` 这一套已经确认可用的局部烟形结果

`视口与时间`

- 左上主视口当前仍挂在 `SmokeCam_02`
- 左下辅视口继续保留 `sunlight1` 视角
- 两个视口中都能看到当前局部烟形的体积框和烟体轮廓，说明视角、缓存与体积结果已经重新对齐
- 时间轴当前停在 `68` 帧，处于当前局部输出区间中段
- 与前一张 `Export` 页签相比，这里重新回到缓存节点，说明作者是在确认“导出的贴图未来将绑定的就是这一份缓存烟体”

`结果理解`

- 这张图给出的关键证据是：局部烟形方案并不是停留在单独的导出纹理设置里，而是要和 `filecache1` 的缓存结果一起构成可复用的完整资源链
- `Version = 2` 的缓存、`SmokeCam_02` 的新视角，以及上一张定义好的 5 张导出纹理，共同构成了后续要交给 Unreal 材质使用的一整套输入
- 这张图对应的安全结论是：本小节末尾通过回到 `filecache1`，确认当前 `Smoke_02` 的缓存烟体将与前面定义好的导出纹理一起进入材质流程，形成完整的基于纹理的游戏资源制作链

## 补充视觉证据

### S01 00:02:02

这张补充图给的是对象层级的直接证据：为了继续处理局部烟柱，作者不只是保留 `SmokeCam_01` 和 `SmokeCam_02`，而是又额外创建了一个新的相机 `Smoke_03`。结合底部字幕“这个名字好像不重复呢”，这里可确认当前操作重点是相机新增与命名管理，而不是烟雾节点、材质或翻书输出本身。

`对象层级`

- 当前网络位于 `/obj`
- 可见对象包括：
  - `Geometry Smoke_01`
  - `Light sunlight1`
  - `Environment Light skylight1`
  - `Camera Smoke_03`

`当前对象`

- 当前选中对象：`Smoke_03`
- 右侧参数面板类型：`Camera`
- 当前页签：`View`

`相机参数`

- `Resolution = 512 x 512`
- `Pixel Aspect Ratio = 1`
- `Projection = Perspective`
- `Focal Length = 50`，单位为 `millimeters`
- `Aperture = 41.4214`
- `Near Clipping = 0.0978101`
- `Far Clipping = 44352.9`
- `Enable Background Image` 已启用
- `Screen Window X/Y = 0 / 0`
- `Screen Window Size = 1 / 1`
- `Left Crop = 0`
- `Right Crop = 1`
- `Bottom Crop = 0`
- `Top Crop = 1`

`视口与取景`

- 左上主视口当前使用 `Smoke_03`
- 左下辅视口继续保留 `sunlight1` 视角
- 主视口中的烟柱仍保持完整上升轮廓，顶部团块、中段主柱和底部堆积都被收入画面
- 与此前 `SmokeCam_02` 的局部紧凑取景不同，这张补充图更像是在建立又一个可单独命名和管理的镜头位

`结果理解`

- 这张图给出的关键证据是：作者在对象层中会持续增设新的相机位，以服务不同局部烟形或不同导出任务，而不是强迫所有镜头复用一个相机
- `Smoke_03` 的命名与字幕里“名字不重复”的口述对应，说明相机管理本身已成为流程的一部分
- 这张图对应的安全结论是：本张补充图用对象层证据补足了“为不同烟柱视角持续增设独立相机”的做法，说明后续纹理、粒子或颜色方案会依赖多个命名清晰的相机位分别处理

### S02 00:06:37

这张补充图是在 `MPlay` 中检查一张已经烘焙完成的烟雾翻页纹理序列。画面主体是黑底网格中的同一团烟雾缩略帧，按从左到右、从上到下的顺序排列，用来核对整套 flipbook 的轮廓变化、颜色分布和帧间连续性。

`预览界面`

- 左上角窗口标题可见 `MPlay - ip-15:15:*`
- 左上状态文字可见：
  - `ip-15:18:17`
  - `4096x4096`
  - `fr:4`
  - `c`
- 底部时间轴当前停在第 `4` 帧

`翻页结果`

- 纹理被排成规则网格，每个单元显示同一团烟雾在不同时间切片下的形态
- 烟雾整体保持竖向上升轮廓：顶部是较圆的团块，中段有连续鼓包，底部较窄并向下拖尾
- 颜色不是最终明暗贴图，而是偏洋红、蓝、青、绿色的假彩显示，用来区分体积或法线/运动类数据分布
- 相邻单元中的烟形变化连续，没有出现明显跳帧；越往后几帧，顶部团块更饱满，底部拖尾也更长

`用途理解`

- 这张图的作用是补充证明：在导出完成后，作者会先用 `MPlay` 逐帧浏览整张大分辨率 flipbook，确认烟柱在整套序列里的运动是否平滑、每帧裁切是否完整、整列缩略图是否都保持同一观察方向
- 结合前一张对 `Export` 输出通道的设置，这里展示的是导出结果的视觉验收阶段，而不是新的节点或材质搭建步骤

### S03 00:11:08

这张补充图回到 `Smoke_02` 的节点网络与 `filecache1` 参数面板，展示烟雾序列在缓存/求解阶段的实际工作状态。画面中央的网络链路、右侧的缓存设置、左侧两个视口和中间的求解进度弹窗一起说明：作者当前正在让烟雾模拟按较长帧段持续计算，并将结果缓存到磁盘，供后续纹理或材质流程取用。

`节点链路`

- 当前对象路径位于 `/obj/Smoke_02`
- 画面中可见的主链路自上而下为：
  - `smoke_base`
  - `pyrosource1`
  - `attribadjustvector_velocity`
  - `volumerasterizeattributes`
  - `pyrosolver_billowy_smoke`
  - `filecache1`
  - `pyrolook_billowy_smoke`
  - `RENDER_Billowy_Smoke`
- 当前高亮节点是 `filecache1`
- `filecache1` 节点下方可见缓存命名：
  - `Ex_01_SmokePlume_01.filecache1`
  - `v2.$F4.bgeo.sc`

`缓存设置`

- 右侧参数面板为 `File Cache filecache1`
- `Load from Disk` 已启用
- `Time Dependent Cache` 已启用
- `Base Name = Ex_01_SmokePlume_01.filecache1`
- `Base Folder = $HIP/geo`
- `Version = 2`
- `Evaluate As = Frame Range`
- `Start/End/Inc = 1 / 100 / 1`
- 面板中可见操作按钮：
  - `Save to Disk`
  - `Save to Disk in Background`
  - `Cancel Cook`

`求解进度`

- 中央弹窗标题为 `Interrupt`
- 进度条文字可见 `render frame 57 (57 of 100)`
- 下方状态为 `Solving: GAS_Analysis`
- 弹窗底部已运行时间约为 `0:38`
- 底部状态栏同时显示当前正在 `Cook`，并提示帧位于 `56 of 100` 左右，说明这是一次正在进行中的长帧段缓存/求解，而不是静态参数展示

`视口与用途`

- 左上主视口使用 `SmokeCam_01`
- 左下辅视口使用 `sunlight1`
- 两个视口当前都只显示场景底板与空视景，说明此刻关注点不在单帧构图，而在后台缓存整段模拟
- 底部字幕明确说明：这种序列形式的纹理“不需要经常使用，只在需要时拿来用”，与当前正在生成并缓存整段烟雾序列的做法一致

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。

