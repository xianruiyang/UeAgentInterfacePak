# 01 Stylized Ice Spikes

# 01 Stylized Ice Spikes

## 关键术语

- `Emitter`、`System`、`Module`、`Spawn`、`Spawn Rate`、`Lifetime`、`Color`、`Material`、`UV`、`Multiply`、`Add`、`Normal`、`Niagara`、`Normalized Age`、`Curve`、`Noise`、`Niagara System`、`Particle`

## 分段知识

### 00:00:05-00:02:58 Smoke

- 本段定位：Smoke。
- 知识点：参考素材应按效果类型、颜色、运动方式和用途打标签，便于后续复现 VFX 风格。
- 知识点：烟雾效果通常依赖较长 Lifetime、透明度衰减、噪声扰动和柔和的材质混合。
- 知识点：本段围绕 `Particle` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Particle`、`Lifetime`、`材质`、`颜色`、`透明度`、`噪声`、`烟雾`。

**关键画面：**

这张图是浏览器中的参考作品页面，不是 Unreal 或 Niagara 编辑界面。教程在正式制作 `Stylized Ice Spikes` 之前，先回顾冰系技能参考作品，用来确定冰刺、蓝白能量和烟雾氛围的整体风格方向。

图中可确认的参考信息：
- 当前页面来源于 `magesbox.com`
- 页面主体展示一组蓝白色冰系技能概念图/成品图
- 上方大图中可见：
  - 左侧为人物挥动时形成的弧形冰蓝能量
  - 右侧为地面法阵中心爆出冰刺与强蓝白发光的效果
- 下方还能看到另一张以蓝白火焰/冰焰轮廓为主的参考图

从这些参考图能总结出的可复现风格目标：
- 主色调偏冷色：蓝白、高亮青蓝、少量深蓝阴影
- 冰刺或能量爆发中心亮度很高，外围带柔和烟雾/雾化边缘
- 地面常配合法阵线条、辉光或冲击纹理，强化技能落点
- 烟雾不是厚重灰雾，而是更轻、更干净的蓝白雾气或寒气感

这张图的用途是风格锚定：后续做 `Smoke` 时，应优先向“冰蓝、干净、带辉光的寒气/烟雾”靠拢，而不是普通火焰烟或尘土烟。
这张图继续展示浏览器中的参考作品，但这次已经聚焦到一个非常接近目标的“冰刺爆发 + 大范围寒雾”案例。相较上一张的综合风格板，这张更适合作为 `Smoke` 段的直接视觉参照。

图中可确认的参考特征：
- 中心主体是一圈从地面向上爆出的冰刺群，形状尖锐、层次分明
- 冰刺核心区域亮度最高，颜色集中在蓝白和青蓝之间
- 冰刺周围包裹着一大圈低饱和、柔和扩散的白雾/寒气
- 外围散落着小型冰屑、碎片和少量微粒
- 地面可见冰裂、冰面反光或法阵式的破碎纹理

对后续 `Smoke` 复现最有价值的结论：
- 烟雾应围绕冰刺底部向四周铺开，形成贴地的环形寒雾，而不是笔直向上冒
- 颜色以白雾为主，内部混入蓝色辉光，让烟雾和冰刺中心统一到同一冷色系
- 透明度需要柔和过渡，边缘发散，不要出现厚重脏灰感
- 可以辅以少量碎片或微粒，但主体仍应是“亮中心 + 大范围低对比寒雾”

这张图的用途是把 `Smoke` 的目标形态从抽象的“冷色烟雾”收敛到更具体的“冰刺周围的贴地寒雾爆发”。
这张图继续使用参考作品页面，但这次展示的是一个更偏“成片镜头”的冰刺聚合效果：大量蓝白冰晶从中心向外爆开，外围包着体积雾和闪烁粒子。它进一步补充了 `Smoke` 段除了白雾本体之外，还应带有冷色辉光和少量发光碎屑。

图中可确认的视觉特征：
- 主体是一大团向外张开的冰蓝晶体/冰刺簇
- 中心发光极强，形成白色核心和蓝色外缘过渡
- 冰刺外层包裹着柔和的大面积雾气，雾层并非纯白，而是被蓝色中心光照亮
- 背景和外围散布着很多小型闪烁粒子/星点
- 地面或背景整体很暗，使冰刺核心和雾层的亮度对比更突出

对 `Smoke` 段复现的补充结论：
- 烟雾除了做贴地扩散，还应允许一部分体积向上包围冰刺主体
- 中心冷光应能够穿透烟雾，让雾层呈现“内亮外柔”的层次
- 可以加入少量小型发光颗粒，让寒气边缘更有灵动感，而不是只有一团静态软雾
- 冰刺与烟雾应共享同一套冷色调和高亮中心，否则会分离成两个无关元素

这张图的用途是完善风格目标：`Stylized Ice Spikes` 的烟雾应既有贴地寒雾，也有环绕冰晶主体的发光体积感，并配合少量闪烁粒子强化魔法冰系氛围。

### 00:03:02-00:06:09 System、Color、Material

- 本段定位：System、Color、Material。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Particle` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Blender` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Particle`、`Color`、`Alpha`、`Opacity`、`Material`、`Panner`、`Emissive`、`Blender`。

**关键画面：**

这张图仍在参考作品页面，但字幕已经从“看风格”进入“拆实现”。作者明确说明冰块需要先做成独立的 `3D` 模型，而不是只靠一张材质贴图，因此这张图是后续 `System、Color、Material` 段最关键的结构前提。

图中可确认的信息：
- 参考画面左下角只出现一个小型冰蓝能量/冰片主体，外围有柔和弧形轨迹和少量发光粒子
- 整体不是平面法阵，而更像由实体冰片或冰刃构成的立体元素
- 字幕明确表达：
  - 需要“为每一块冰创建一个 3D 模型”
  - 不是“仅仅是材质”

对后续复现的直接结论：
- `Stylized Ice Spikes` 的主体冰块应优先按网格/模型思路处理
- 材质负责颜色、发光和透明层次，但不能取代冰块本身的立体体积
- 如果后续在 Niagara 中实例化这些冰块，则每个粒子更可能驱动一个冰片网格，而不是单纯 Sprite

这张图的作用是把制作路线定死：先准备冰块 3D 形体，再讨论系统、颜色和材质表现。
这张图切到 Unreal 的静态网格编辑器，说明教程已经把前面提到的冰块 `3D` 模型正式导入工程。当前打开的资源名是 `SM_Ice_01`，画面中可见一个细长尖锐的冰片/冰刺网格，右侧则是该网格的基础属性面板。

可确认的网格资源信息：
- 当前静态网格资源：`SM_Ice_01`
- 网格外形：单个尖锥状、不规则冰片，顶部尖锐、底部较厚
- 右上角可见当前处于静态网格查看器/编辑器环境

左上角信息覆盖层可见参数：
- `LOD = 0`
- `Current Screen Size = 0.168199`
- `Triangles = 224`
- `Vertices = 153`
- `UV Channels = 4`
- `Approx Size = 7x6x23`
- `Num Collision Primitives = 0`

右侧详情面板中可确认的设置：
- `Material Slots` 里只有 `1 Material Slot`
- `Element 0` 当前材质为 `WorldGridMaterial`
- `LOD Picker = LOD Auto`
- `Number of LODs = 1`

字幕能直接确认的制作意图：
- “导入了它”
- “这是我们的 3D 模型”
- “让我们看看轴心在哪里”

这张图支持的复现结论是：`Stylized Ice Spikes` 的冰刺主体已经作为独立静态网格 `SM_Ice_01` 导入 UE，且作者接下来会重点检查它的轴心/枢轴位置，以便后续在 Niagara 中正确实例化、旋转和缩放。
这张图切回 `Blender 3.6.0`，说明教程开始从建模端解释冰刺网格的来源。当前画面是 Blender 默认启动场景，中央弹出欢迎面板，字幕明确说明“转到 Blender，我们将创建一个 3D 物体”，并准备先删除默认对象。

图中可确认的环境信息：
- 软件：`Blender 3.6.0`
- 模式：`Object Mode`
- 当前视图：`User Perspective`
- 默认场景对象可见：
  - `Camera`
  - `Cube`
  - `Light`
- 当前选中对象：`Cube`

欢迎面板中可见信息：
- `New File` 预设包括：
  - `General`
  - `2D Animation`
  - `Sculpting`
  - `VFX`
  - `Video Editing`
- `Recent Files` 中可见若干近期文件名，包括：
  - `untitled.blend`
  - `spikes.blend`
  - `leaf.blend`
  - `Chain.blend`

结合字幕能确认的制作意图：
- 接下来会在 Blender 中创建冰刺用的 `3D` 物体
- 第一步通常是清理默认场景中的 `Cube`

这张图支持的复现结论是：教程的冰刺网格并不是外部直接拿来的黑盒资源，而是会在 Blender 中从默认场景开始手工建立；因此后续 `System、Color、Material` 的基础之一，是先完成一个可导入 UE 的冰刺静态网格。

### 00:06:11-00:10:36 Material、UV、Add

- 本段定位：Material、UV、Add。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Opacity`、`Material`、`Texture`、`Noise`、`Add`、`Panner`、`Emissive`。

**关键画面：**

这张图在 `Blender 3.6.0` 中继续搭建冰刺基础网格。当前对象仍是 `Cylinder`，但左下角创建参数已经显示作者在简化这个圆柱体：把边数降低，并且不再保留封盖，从而更适合继续拉伸、扭曲成冰片形状。

当前可确认的设置：
- 软件：`Blender 3.6.0`
- 模式：`Object Mode`
- 当前选中对象：`Cylinder`
- 左下角 `Add Cylinder` 面板显示：
  - `Vertices = 16`
  - `Radius = 1 m`
  - `Depth = 2 m`
  - `Cap Fill Type = Nothing`
  - `Generate UVs` 已勾选
  - `Align = World`
  - `Location X/Y/Z = 0 m`
  - `Rotation X/Y/Z = 0°`

字幕能直接确认的操作意图：
- “把数量减少，比如设置为 16”
- 说明这里在减少圆柱分段数，而不是追求高精度平滑圆柱

能可靠得到的复现结论：
- 冰刺基础体使用开口圆柱而不是带盖圆柱
- 分段数被压到 `16`，说明作者希望保留足够的侧面棱线，方便后续做出更低模、更有切面感的冰片

不确定点：
- 本图没有显示后续是否立刻进入编辑模式或对顶点做了哪一步变形，因此不能仅凭此图推断具体的挤压、缩放或删除流程顺序
这张图进入 `Blender` 的材质/着色检查阶段。作者已经给冰刺模型分配了一张测试纹理，用来观察 UV 分布是否正常；字幕明确指出“上面部分已经被拉伸了”，说明当前重点是发现并修正冰刺顶部的 UV 拉伸问题。

当前可确认的工作区状态：
- 软件：`Blender 3.6.0`
- 当前对象仍是 `Cylinder`，但视口中形体已经被拉成细长尖锥状冰刺
- 左侧文件浏览区可见多张测试贴图，包含：
  - `checker.png`
  - `Circle21.png`
  - 多张 `Noise*.png`
  - `SmokeTrai...`
- 当前被用于材质测试的贴图节点名称为 `checker.png`

材质节点区可见结构：
- 一个 `Image Texture` 节点：`checker.png`
- 一个 `Principled BSDF`
- `BSDF` 输出连接到 `Material Output`

从图中和字幕可确认的结论：
- 作者先“分配一个纹理”来检查模型表面贴图分布
- 检查结果是顶部区域已经出现拉伸，不适合直接用作最终冰刺 UV
- 这说明冰刺建模流程不仅要做形体，还要校正 UV，避免材质在尖端变形

这张图支持的复现结论是：冰刺网格完成初步造型后，应立刻用测试纹理做一次 UV 体检；当前这一步已经发现尖端区域的贴图拉伸问题，后续需要通过展开或重新调整几何来修正。
这张图继续在 `Blender` 中细化冰刺模型，但重点已经从 UV 检查转到表面形体破碎感的塑造。右侧属性栏显示当前对象挂有 `Displace` 与 `Texture` 两个修改器/纹理项，选中的 `Texture` 类型为 `Voronoi`，作者正通过它来打散表面，让冰刺不再是过于平滑的几何体。

当前可确认的对象与面板信息：
- 当前对象：`Cylinder`（已被进一步编辑成多切面的冰刺群局部）
- 右侧修改器/纹理区可见：
  - `Displace`
  - `Texture`
- `Texture` 的 `Type = Voronoi`

`Voronoi` 纹理当前可见参数：
- `Distance Metric = Actual Distance`
- `Exponent = 2.500`
- `Coloring = Intensity`
- `Intensity = 10.000`
- `Size = 0.25`
- `Nabla = 0.03`

`Feature Weights` 当前可见值：
- `First = 1.000`
- `Second = 0.000`
- `Third = 0.000`
- `Fourth = 0.000`

字幕能直接确认的操作意图：
- “这是我们的强度”
- “我们需要调整大小”
- 说明作者在围绕 `Intensity` 和 `Size` 这两个量继续试错，以得到合适的冰面破碎纹理

这张图支持的复现结论是：冰刺模型在 Blender 中会通过 `Displace + Voronoi Texture` 做二次形体噪声处理，其中当前测试的一组关键值是 `Intensity 10.0` 与 `Size 0.25`；目标是让表面出现更自然的切面和碎裂感，而不是保持规则光滑。

### 00:10:38-00:13:18 Add、Noise

- 本段定位：Add、Noise。
- 知识点：本段围绕 `Noise`、`Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 核对对象：`Noise`、`Add`。

**关键画面：**

这张图继续在 `Blender` 中处理冰刺基础网格，当前重点已经从前一批的纹理测试切到真正的位移修改器调参。模型表面仍带有棋盘格测试纹理，用来直观看形体膨胀和表面切面是否自然；右侧可见当前挂载的是 `Displace` 修改器。

当前对象状态：
- 软件：`Blender 3.6.0`
- 模式：`Object Mode`
- 当前对象：`Cylinder`
- 视口中的模型已经从细长尖刺，变成中段鼓起、两端收尖的不规则冰晶坯体

右侧 `Displace` 修改器当前可见设置：
- `Texture` 已指定
- `Coordinates = Local`
- `Direction = Normal`
- `Strength = 0.400`
- `Midlevel = 0.500`
- `Vertex Group` 为空

从画面可直接确认的结果：
- 位移已经让圆柱原有的规则侧面被打散成大小不一的鼓包和切面
- 模型两端仍保持尖形，说明当前位移强度主要改变中段体积，而不是完全破坏冰刺的大轮廓
- 棋盘格测试纹理仍然覆盖在表面，便于同时观察 UV 和表面变形后的面分布

这张图支持的复现结论是：在 `Add、Noise` 阶段，冰刺网格会通过 `Displace` 修改器按法线方向施加局部噪声位移；当前示例参数至少包含 `Local + Normal + Strength 0.400 + Midlevel 0.500`，目的是把基础圆柱快速打散成更像冰晶的切面体。
这张图把工作切到 `Blender` 的 `Edit Mode`，说明作者不满足于只用 `Displace` 自动打散，而是开始手工推拉几何点位，微调冰刺的外轮廓。字幕明确说“稍微移动一下、减少这个，或者反过来”，表示这里的核心不是固定参数，而是围绕目标轮廓做人工修形。

当前可确认的编辑状态：
- 软件：`Blender 3.6.0`
- 模式：`Edit Mode`
- 当前对象：`Cylinder`
- 模型仍保留棋盘格测试纹理，可继续观察面分布和形体变化
- 画面中能看到大量顶点/边点，说明当前正在直接编辑网格

当前形体状态：
- 模型整体已经接近一枚细长冰刺
- 上半部收尖，底部也收拢，但中段保留较大的棱面和体积
- 左右轮廓并不完全对称，说明作者在刻意保留自然的冰晶不规则感

从字幕能直接确认的操作思路：
- 可以“把这个稍微移一下”
- 可以“减少这个，或者反过来”
- 调整标准以最终视觉结果为准，而不是严格遵循某个数值模板

这张图支持的复现结论是：自动位移只负责生成基础切面，最终冰刺外形还需要在编辑模式下手工移动顶点/边环，微调宽窄、鼓起位置和尖端走势，直到轮廓看起来更像天然冰晶。
这张图回到 Unreal 的静态网格查看器，再次查看 `SM_Ice_01`。和前面第一次导入相比，当前模型已经变成更细长、更尖锐的冰刺，说明作者把在 Blender 中做的拉伸和手工修形结果重新导回 UE 进行验证。

当前可确认的网格结果：
- 当前资源：`SM_Ice_01`
- 冰刺整体由下部较厚、上部收尖的主轮廓组成
- 中段仍保留几块较明显的切面鼓起
- 顶部已经被明显拉长，形成更接近冰锥/冰刺的尖端
- 视口中可见模型本地坐标轴，轴心位于模型下部附近

左上角信息覆盖层当前可见：
- `LOD = 0`
- `Current Screen Size = 0.571325`
- `Triangles = 224`
- `Vertices = 153`
- `UV Channels = 4`
- `Approx Size = 7x6x23`
- `Num Collision Primitives = 0`

右侧搜索框中输入了 `unifor`，可见的相关设置包括：
- `Support Uniformly Distributed Sampling`
- `Support GPU Uniformly Distributed Sampling`
- `Import Uniform Scale = 1.0`

字幕能直接确认的调整方向：
- “延长顶部部分”
- “现在它很相似了”

这张图支持的复现结论是：冰刺模型经过 Blender 中的位移和手工修形后，需要回 UE 重新检查轮廓是否更接近目标参考；当前回导结果已经把顶部拉长，并获得了更接近最终参考的冰刺比例。

### 00:13:43-00:17:42 Emitter、System、Spawn

- 本段定位：Emitter、System、Spawn。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：角色或镜头演示需要导入 FBX/骨骼/动画，并用 Sequencer 校准触发时机。
- 知识点：本段围绕 `Particle` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：使用 Empty System 时需要手动添加 Emitter，再补齐 Spawn、Update 与 Renderer。
- 知识点：本段围绕 `Spawn` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Emitter`、`Particle`、`Spawn Rate`、`Spawn`、`Alpha`、`Opacity`、`Renderer`、`Material`。

**关键画面：**

这张图继续在 `Blender` 的 `Edit Mode` 中手工修冰刺网格。与上一批的“整体推拉”不同，这里更明确地进入局部切线和补点阶段，用额外顶点/边线去控制冰刺表面的折角与切面走向。

当前可确认的编辑状态：
- 软件：`Blender 3.6.0`
- 模式：`Edit Mode`
- 当前对象：`Cylinder`
- 模型外轮廓已经形成上尖下尖、中部有多处折面鼓起的冰晶形态
- 画面中可见大量顶点和边线，说明当前是在直接编辑网格拓扑

字幕能直接确认的操作意图：
- “这里你可以看到我是怎么切割的”
- “你也可以添加额外的顶点，以便稍后选择它们”
- “再次移动它”
- “我蛮喜欢这个版本的”

能可靠得到的复现结论：
- 作者会通过切割网格、增加顶点，再手动移动这些点位来调整局部折线
- 这种做法的目的不是增加平滑度，而是制造更多不规则切面，使冰刺更像天然结晶
- 结果判断完全依赖最终轮廓观感，作者会在多个版本之间取一个“更像冰晶”的版本

这张图支持的复现结论是：`Add、Noise` 段不只靠修改器自动生成表面噪声，还要手动切线和补点来增强切面层次，尤其是中段的转折和外轮廓的断面感。
这张图回到 Unreal 关卡编辑器，作者开始正式建立 `Stylized Ice Spikes` 的 Niagara 资源骨架。当前已经在 `VFX_Library/Niagara/IceSpikes` 下创建了一个名为 `NS_IceSpikes` 的系统，并把它作为实例拖进了关卡，但系统里还没有任何发射器或可见效果。

资源与层级信息：
- 当前目录：`Content > VFX_Library > Niagara > IceSpikes`
- 当前选中的资源：`NS_IceSpikes`
- 资源类型：`Niagara System`
- 关卡右侧 `Outliner` 中也可见一个 `NS_IceSpikes` 的 `NiagaraActor`

右侧详情面板中可确认的实例信息：
- 当前对象：`NS_IceSpikes (Instance)`
- 挂载组件：`NiagaraComponent`
- `Transform`
  - `Location = (0.0, 27.0, 0.0)`
  - `Rotation = (0.0, 0.0, 0.0)`
  - `Scale = (1.0, 1.0, 1.0)`

字幕能直接确认的流程：
- “创建一个文件夹和一个空的系统”
- “把系统移到关卡中，这样我们就能看到结果”
- “这里什么都没有，它完全是空的”

这张图支持的复现结论是：`IceSpikes` 章节先从一个空的 Niagara System 开始，在内容目录中单独建 `IceSpikes` 文件夹，并立即把空系统实例放进关卡中作为调试锚点，后续再往系统里逐步添加发射器和模块。
这张图进入 `NS_IceSpikes` 的 Niagara System 编辑界面，作者开始给空发射器补最基础的生成链，并重点说明生成位置要使用系统本地坐标来控制。当前画面能确认的是：系统里已经有一个名为 `Empty` 的发射器，预览窗口中出现了单个冰刺网格，右侧正在查看 `System Location` 模块的参数。

当前画面可确认的模块结构：
- 发射器：`Empty`
- `Emitter Update` 中可见：`Emitter State`
- `Particle Spawn` 中可见：`Spawn Rate`
- `Particle Update / 初始化链` 区域可见：`Initialize Particle`、`System Location`、`Particle State`
- 渲染模块可见：`Mesh Renderer`

右侧 `Details` 面板中当前能直接确认的参数：
- 当前模块：`System Location`
- `Offset = (0.0, 0.0, 0.0)`
- `Offset Coordinate Space = Local`

字幕能直接确认的设置意图：
- “最初，我想将其设置为本地坐标”
- “为了防止它们出现，我们可以使用一种叫做系统本地化的东西”
- “只需要让它们沿着 X 坐标移动”
- “所以我们不触及 Z 和 Y，我们只触及 X”

这张图支持的复现结论是：
- 冰刺生成位置不是直接在世界空间里乱偏移，而是通过 `System Location` 模块在 `Local` 坐标空间下做位移控制
- 位移方向当前只计划沿 `X` 轴推进，`Y` 和 `Z` 保持不改
- 这样后续无论整个系统实例怎样摆放，冰刺的生成前进方向都会稳定跟随系统本地朝向，而不会因为世界坐标差异导致朝向失控

### 00:17:47-00:22:42 Emitter、Lifetime、Multiply

- 本段定位：Emitter、Lifetime、Multiply。
- 知识点：User Parameter 要保持命名和类型稳定，便于蓝图、材质或系统级控制复用。
- 知识点：本段围绕 `Multiply` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Emitter` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：Lifetime 决定粒子存活时间，需要和 Spawn 数量、速度以及透明度曲线一起调。
- 知识点：本段围绕 `Emitter`、`Curve` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Curve` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`Emitter`、`Spawn`、`Lifetime`、`User Parameter`、`Curve`、`Multiply`、`材质`、`粒子`。

**关键画面：**

这张图继续在 `NS_IceSpikes` 的 `Empty` 发射器里设置 `System Location`，重点已经从“启用本地坐标偏移”推进到“让偏移值随粒子时间变化”。作者把 `Offset.X` 接成一个基于曲线的数值，再用乘法把曲线输出放大成可见位移距离，用来驱动冰刺沿本地 `X` 轴逐步推出。

当前画面可确认的模块与层级：
- 系统：`NS_IceSpikes`
- 发射器：`Empty`
- 可见模块链：`Emitter State`、`Spawn Rate`、`Initialize Particle`、`System Location`、`Particle State`、`Mesh Renderer`
- 当前右侧 `Details` 正在编辑：`System Location`

`System Location` 中当前能直接确认的结构：
- `Offset` 使用 `Make Vector`
- 只有 `X` 分量被展开并接入表达式
- `X` 的输入为 `Float from Curve`
- 曲线资源类型显示为 `Curve for Floats`
- `CurveIndex = PARTICLES.NormalizedAge`
- `Scale Curve = 1.0`
- `Y = 0.0`
- `Z = 0.0`
- `Offset Coordinate Space = Local`

字幕能直接确认的设置逻辑：
- “我们用一条曲线来随时间改变这些参数”
- “这里例如可以选一条线性的曲线”
- “它的值会从 0 到 1”
- “再乘一下”
- “它就会从 0 变到 1500”

这张图支持的复现结论是：
- 冰刺前推不是常量位移，而是让 `Offset.X` 跟随 `Particles.NormalizedAge` 从 `0` 线性增长到 `1`
- 曲线本身只提供 0 到 1 的归一化变化，实际移动距离要再乘一个系数放大到约 `1500`
- `Y/Z` 保持 0，说明这一步只建立单轴前推，不在这一张图里加入侧向或竖向偏移
这张图切到 `Initialize Particle` 模块，作者开始同时处理粒子寿命和网格尺寸，并准备继续使用曲线来控制数值随时间变化。当前截图能确认 `Mesh Scale` 的至少一个分量已经接入曲线，但字幕提到的“X、Y 设为 55”没有在截图可见区域中完整显示，因此最终尺寸常量需要当前帧未确认。

当前画面可确认的信息：
- 系统：`NS_IceSpikes`
- 发射器：`Empty`
- 当前选中模块：`Initialize Particle`
- `Lifetime Mode = Direct Set`
- `Lifetime = 5.0`
- `Position Mode = Simulation Position`
- `Mesh Scale Mode = Non-Uniform`
- `Mesh Scale` 使用 `Make Vector`
- 当前展开的是 `X` 分量
- `X` 的输入为 `Float from Curve`
- 曲线资源类型显示为 `Curve for Floats`
- `CurveIndex = EMITTER.NormalizedLoopAge`
- `Scale Curve = 1.0`

字幕能直接确认但需要结合后续画面复核的意图：
- “还会使用标准化发射器的曲线”
- “这样它会是一个半秒的爆发”
- “现在我们来设置大小，让它线性增加”
- “我会在所有地方设置”
- “X 和 Y 都设为 55”

当前不确定点：
- 当前截图下半部分被裁切，`Mesh Scale` 的 `Y`、`Z` 最终输入结构和可见数值不完整
- 字幕提到的 `X = 55`、`Y = 55` 没有在本张图中被完整显示，无法仅凭当前截图确认这两个值已经实际写入到哪个引脚或常量槽位
这张图把 `Initialize Particle > Mesh Scale` 的三轴设置完整展开，明确了冰刺网格的尺寸不是统一缩放，而是 `X/Y` 用同一套线性曲线控制横向尺度，`Z` 再用另一条更有变化的曲线单独控制纵向拉伸。预览区里已经能看到一排沿地面推出、前后高低不同的冰刺，说明这组缩放曲线已经开始直接影响造型节奏。

当前画面可确认的结构：
- 当前模块仍是 `Initialize Particle`
- `Mesh Scale Mode = Non-Uniform`
- `Mesh Scale` 使用 `Make Vector`
- `X`、`Y`、`Z` 三个分量都分别接入 `Float from Curve`
- 三个分量的曲线资源类型都显示为 `Curve for Floats`
- 三个分量的 `CurveIndex` 都使用 `EMITTER.NormalizedLoopAge`

当前能直接确认的参数：
- `X.Scale Curve = 55.0`
- `Y.Scale Curve = 55.0`
- `X` 曲线形态：从较小值线性上升到较大值
- `Y` 曲线形态：与 `X` 同样是线性上升
- `Z` 曲线形态：前段保持较低值，中后段继续抬升，末端有更明显的上冲

字幕能直接确认的意图：
- “我们已经有了大小”
- “为什么我设置了这样一条有趣的曲线？”
- “因为我希望 `Z` 轴逐渐增加”

这张图支持的复现结论是：
- 冰刺横截面尺寸主要由 `X/Y` 两轴同步放大，且两轴使用相同倍率 `55.0`，保证宽度与厚度一起增长
- 冰刺高度不与 `X/Y` 同步，而是让 `Z` 单独走一条更有节奏变化的曲线，从而形成由矮到高、末端更尖更长的纵向变化
- 三轴都绑定 `Emitter.NormalizedLoopAge`，说明这一段的尺寸演化是按发射器循环阶段统一驱动，而不是按单粒子年龄随机变化

### 00:22:42-00:25:58 Module、Curve

- 本段定位：Module、Curve。
- 知识点：本段围绕 `Curve` 进行设置，需结合关键画面核对真实节点和参数。
- 核对对象：`Curve`。

**关键画面：**

这张图仍在 `Initialize Particle > Mesh Scale` 中讲解三轴曲线的造型作用，作者明确说明：`X`、`Y` 在整个生命周期中做线性变化，而 `Z` 则采用“前段慢涨、末段快速冲高”的曲线。这种差异化缩放是让冰刺从一排低矮形体逐步长成尖高造型的关键。

当前画面可确认的设置：
- 当前模块：`Initialize Particle`
- `Mesh Scale Mode = Non-Uniform`
- `Mesh Scale` 使用 `Make Vector`
- `X`、`Y`、`Z` 都接入 `Float from Curve`
- 三个分量的 `CurveIndex` 都是 `EMITTER.NormalizedLoopAge`
- `X.Scale Curve = 55.0`
- `Y.Scale Curve = 55.0`

当前曲线形态可确认的信息：
- `X` 曲线：整体线性上升
- `Y` 曲线：整体线性上升，与 `X` 节奏一致
- `Z` 曲线：前段缓慢抬升，中后段出现明显陡升，末端增长幅度大于前面各段

字幕能直接确认的说明：
- “这里可以看到，`X`、`Y` 在整个生命周期中线性变化”
- “但 `Z` 是逐渐、逐渐、逐渐地增长”
- “然后突然一下就长起来了”
- “最后这部分增长比其他部分更多”

这张图支持的复现结论是：
- `X/Y` 负责稳定地把冰刺横向尺寸从小放大到大
- `Z` 单独使用非线性曲线，目的是让高度在生命周期尾段快速拔高，形成更锐利、更具爆发感的生长节奏
- 同一组冰刺因此不会只是等比放大，而是会在后段表现出明显的“拉尖”感
这张图开始给冰刺补朝向变化。作者在 `Particle Spawn` 里新增并选中了 `Initial Mesh Orientation` 模块，通过“朝向向量 + 旋转随机范围”的组合，让整排冰刺在保持总体前推方向的同时出现轻微倾斜，不至于全部笔直一致。

当前画面可确认的模块结构：
- 发射器：`Empty`
- `Particle Spawn` 中当前可见模块：`Initialize Particle`、`System Location`、`Initial Mesh Orientation`
- 当前右侧 `Details` 正在编辑：`Initial Mesh Orientation`

`Initial Mesh Orientation` 中当前能直接确认的参数：
- `Mesh Orientation Mode = Orient to Vector`
- `Orientation Vector = (1.0, 0.0, 0.0)`
- `Orientation Coordinate Space = Simulation`
- `Mesh Axis To Orient = (1.0, 0.0, 0.0)`
- `Rotation` 使用 `Random Range Vector`
- `Rotation.Minimum = (0.0, 0.15, 0.0)`
- `Rotation.Maximum = (0.0, 0.2, 0.0)`
- `Rotation Coordinate Space = Mesh`

字幕能直接确认的结果判断：
- “我们已经得到了一个非常有趣的结果”
- “它们已经倾斜了”

这张图支持的复现结论是：
- 冰刺基础朝向仍然锁定在 `+X` 方向，和前面 `System Location` 的推进方向一致
- 在此基础上，只对中间轴分量加入一个很小的随机旋转区间，使每根冰刺都有轻微偏斜
- 这种处理避免了阵列感过强，同时不会破坏整排冰刺整体朝前生长的阅读方向
这张图回到关卡视口检查当前 `NS_IceSpikes` 的整体结果。前面关于 `Mesh Scale` 曲线和 `Initial Mesh Orientation` 的调整已经汇总成一整条更自然的冰刺带：前段是连续较小的尖刺，末端逐步汇聚成更长、更粗、更尖的主刺，整体外轮廓比之前更顺，也更符合作者想要的造型节奏。

当前画面可确认的场景信息：
- 当前回到 Unreal 关卡编辑器主视口
- `Outliner` 中选中对象：`NS_IceSpikes`
- 内容目录位置：`Content > VFX_Library > Niagara > IceSpikes`
- 当前资源：`NS_IceSpikes` `Niagara System`
- 视口里能直接看到一整排贴地生长的冰刺形体，尾端有更大的主刺结构

字幕能直接确认的判断：
- “我不太喜欢这个曲线，也许可以像这样改一下”
- “我喜欢这个结果”
- “看起来稍微更合适一点”
- “我们暂时保留这个结果，继续”

这张图支持的复现结论是：
- 作者不是机械照搬曲线，而是根据视口里的整体轮廓反复微调曲线形状
- 当前保留下来的版本强调“前段密集小刺 + 后段更高更长主刺”的层级关系
- 这一帧的意义是确定当前曲线方案已经达到可接受的视觉结果，后续教程会在这个基础上继续往下搭建系统

### 00:25:58-00:30:20 System、Module、Lifetime

- 本段定位：System、Module、Lifetime。
- 知识点：角色或镜头演示需要导入 FBX/骨骼/动画，并用 Sequencer 校准触发时机。
- 知识点：本段围绕 `Particle` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Curve` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：Lifetime 决定粒子存活时间，需要和 Spawn 数量、速度以及透明度曲线一起调。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Particle`、`Spawn`、`Lifetime`、`Curve`、`Sequencer`、`Add`、`粒子`、`速度`。

**关键画面：**

这张图开始回到发射节奏本身，作者选中 `Spawn Rate`，用一条曲线控制一轮发射周期内的生成密度变化。画面说明这组冰刺不是从头到尾以固定速率均匀生成，而是先高、后降、末尾再略回升，从而塑造更自然的生长节奏。

当前画面可确认的信息：
- 发射器：`Empty`
- 当前选中模块：`Spawn Rate`
- `SpawnRate` 输入为 `Float from Curve`
- 曲线资源类型：`Curve for Floats`
- `CurveIndex = EMITTER.NormalizedLoopAge`
- `Scale Curve = 50.0`
- `Spawn Probability = 1.0`

当前曲线形态可确认的趋势：
- 开头位于较高值
- 中段持续下降到较低平台
- 后段末尾有一小段回升

这张图支持的复现结论是：
- `Spawn Rate` 不是常量，而是绑定在发射器归一化循环时间上
- 一轮爆发开始时生成更密，中段减缓，尾段再做轻微补量
- 这种节奏更适合冰刺由主刺带出细刺的连续生长感，而不是机械匀速排布
这张图进入 `Particle Update` 阶段，作者开始给冰刺添加受力/速度相关模块。当前能确认已经加入了 `Scale Mesh Size`、`Gravity Force` 和 `Solve Forces and Velocity`，并且正在 `Gravity Force` 上尝试把默认重力输入改造成自定义向量表达式；但弹出的动态输入选择面板遮住了具体连接方式，无法仅凭本图可靠还原完整设置。

当前画面可确认的信息：
- 发射器：`Empty`
- `Particle Update` 中当前可见模块：
  - `Particle State`
  - `Scale Mesh Size`
  - `Gravity Force`
  - `Solve Forces and Velocity`
- 当前右侧选中模块：`Gravity Force`
- 当前默认重力值可见为：`(0.0, 0.0, -980.0)`
- 右侧已打开动态输入搜索面板，搜索词为 `make`
- 搜索结果里可见 `Vector` / `Make` 相关动态输入选项

字幕能直接确认但不足以恢复完整连线的意图：
- “我们也会把它分解”
- “这里只会是 `Z`”
- “然后我们将取曲线”
- “假设我们把它设成 `0.5`”

当前不确定点：
- `Gravity Force` 最终是否改为 `Make Vector + Float from Curve` 的结构，在本图里没有完整显示
- 只有 `Z` 轴会被驱动这一点能从字幕推断，但具体常量、曲线倍率和接线端点被弹窗遮挡，不能可靠复原
这张图表明系统已经拆成至少两个发射器：`Spikes_Center` 和 `Spikes_Sides`。作者当前在 `Spikes_Sides` 上单独调整 `Initial Mesh Orientation`，意图是让侧边冰刺带有随机倾斜，而中心主刺保持另一套姿态规则。但当前截图里可见的旋转分量与字幕中的轴向描述不完全一致，因此具体“绕哪一轴随机旋转”的最终设置需要当前帧未确认。

当前画面可确认的信息：
- 系统内可见两个发射器：
  - `Spikes_Center`
  - `Spikes_Sides`
- 两个发射器都包含：
  - `Spawn Rate`
  - `Initialize Particle`
  - `System Location`
  - `Initial Mesh Orientation`
  - `Scale Mesh Size`
  - `Gravity Force`
  - `Solve Forces and Velocity`
  - `Mesh Renderer`
- 当前右侧选中的是 `Spikes_Sides > Initial Mesh Orientation`
- 可见参数：
  - `Mesh Orientation Mode = Orient to Vector`
  - `Orientation Vector = (1.0, 0.0, 0.0)`
  - `Orientation Coordinate Space = Simulation`
  - `Mesh Axis To Orient = (1.0, 0.0, 0.0)`
  - `Rotation` 使用 `Random Range Vector`
  - `Rotation.Minimum = (0.0, 0.15, 0.0)`
  - `Rotation.Maximum = (0.0, 0.0, 0.0)`
  - `Rotation Coordinate Space = Mesh`

字幕能直接确认的意图：
- “会有横向的尖刺”
- “一个尖刺是直的”
- “这里只编辑这一部分”
- “它将随机旋转”

当前不确定点：
- 字幕提到“在 `Z` 轴上随机旋转”，但当前可见数值变化位于中间分量，和字幕描述不完全一致
- 由于本图没有展示修改前后完整轴标签对应关系，不能仅凭这一帧可靠断定最终随机倾斜到底落在教程语义中的哪一根轴上

### 00:30:20-00:34:33 Emitter、Module、Material

- 本段定位：Emitter、Module、Material。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Emitter`、`Alpha`、`Opacity`、`Material`、`Panner`、`Emissive`、`材质`、`纹理`。

**关键画面：**

这张图继续细化 `Spikes_Sides` 的 `Initial Mesh Orientation`。与上一批“先加一点随机倾斜”不同，这里已经把随机旋转明确收束到 `Rotation` 向量的最后一个分量上，用来打散侧边冰刺的朝向一致性，同时保持前两个分量不变。

当前画面可确认的信息：
- 系统中可见两个发射器：`Spikes_Center`、`Spikes_Sides`
- 当前右侧选中：`Spikes_Sides > Initial Mesh Orientation`
- `Mesh Orientation Mode = Orient to Vector`
- `Orientation Vector = (1.0, 0.0, 0.0)`
- `Orientation Coordinate Space = Simulation`
- `Mesh Axis To Orient = (1.0, 0.0, 0.0)`
- `Rotation` 使用 `Random Range Vector`
- `Rotation.Minimum = (0.0, 0.0, 0.0)`
- `Rotation.Maximum = (0.0, 0.0, 1.0)`
- `Rotation Coordinate Space = Mesh`

当前预览结果可确认的信息：
- 视口中的冰刺不再是一整排统一横向姿态
- 画面里出现明显被拉开的纵向/侧向差异，说明随机旋转已经开始影响单根侧刺的朝向

这张图支持的复现结论是：
- `Spikes_Sides` 的随机旋转范围已被重设为只作用在最后一个旋转分量上
- 这样可以在不破坏主朝向的前提下，为侧边冰刺增加每根都不同的转角
- `Spikes_Center` 与 `Spikes_Sides` 的朝向策略开始分离，说明系统已经进入“中心主刺 + 两侧辅刺”分角色控制阶段
这张图回到关卡视口验证 `Spikes_Center` 和 `Spikes_Sides` 组合后的整体效果。当前系统还没有进入最终冰刺成品阶段，更像是在先确认“中心主刺 + 两侧辅助刺”的运动结构和空间关系是否成立。画面里能看到中间一根更高更大的主体，旁边有几根较小的辅刺，与前面拆分发射器的思路一致。

当前画面可确认的信息：
- 当前回到 Unreal 关卡编辑器主视口
- `Outliner` 中选中对象：`NS_IceSpikes`
- 内容目录位置：`Content > VFX_Library > Niagara > IceSpikes`
- 当前资源：`NS_IceSpikes` `Niagara System`
- 视口中可见：
  - 一根居中的大主刺
  - 周围若干较小、方向各异的辅刺
  - 当前仍偏灰白测试外观，还不是最终冰材质表现

字幕能直接确认的判断：
- “每次我现在选择这两个模块”
- “它们一起给了我们一个非常有趣的结果”
- “一个放在中间”
- “它和这个连接”
- “我们还没有尖刺，只是在展示运动应该如何发生”
- “如果这个结果适合你就可以”

这张图支持的复现结论是：
- `Spikes_Center` 与 `Spikes_Sides` 已经能共同形成一个完整的冰刺运动骨架
- 当前阶段主要验证布局、运动关系和主次层级，而不是最终材质质感
- 作者允许这一阶段保留一定随机性，只要每次生成都能维持“中央主刺 + 周边辅刺”的整体阅读关系即可
这张图是本段的总结状态。系统已经稳定为两个发射器：`Spikes_Center` 负责主刺，`Spikes_Sides` 负责侧刺；预览里能看到一整排由小到大推进、末端汇成更高主刺的冰刺带。作者明确表示这一阶段先完成“冰刺骨架准备”，下一步才进入材质与后处理。

当前画面可确认的信息：
- 当前系统概览中可见两个发射器：
  - `Spikes_Center`
  - `Spikes_Sides`
- `Spikes_Center` 当前可见模块：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `System Location`
  - `Initial Mesh Orientation`
  - `Particle State`
  - `Scale Mesh Size`
  - `Gravity Force`
  - `Solve Forces and Velocity`
  - `Mesh Renderer`
- `Spikes_Sides` 当前可见模块：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `System Location`
  - `Initial Mesh Orientation`
  - `Initial Mesh Orientation 002`
  - `Particle State`
  - `Scale Mesh Size`
  - `Gravity Force`
  - `Solve Forces and Velocity`
  - `Mesh Renderer`
- 左侧预览可见最终当前阶段的白模效果：前段多根较矮侧刺，后段形成更高更长的主刺

字幕能直接确认的流程结论：
- “我想现在就这些了”
- “下个视频我们会创建材质”
- “然后把它转移到这里”
- “我们会微调发射器，让它看起来更好”
- “我还会告诉你后期处理，以及它如何帮助我们创建这个效果”

这张图支持的复现结论是：
- 当前 `Niagara` 侧已经完成了冰刺结构、出生节奏、尺寸曲线、重力/速度和中心/侧边分工的基础搭建
- 真正决定“冰”的视觉质感的材质与后处理，还没有在本段展开
- 因此这一页的交付状态应理解为“可用的发射器骨架”，而不是最终成品效果

## 补充视觉证据

### S01 00:01:09

这张补充图不是 `Niagara` 参数界面，而是外部成片参考画面，用来说明本页冰刺系统最终希望达到的构图和视觉方向。画面中一名角色站在冰刺中心，地面向四周炸开成碎裂冰面，外围伴随冷蓝色发光和细碎粒子，形成“冻结/禁锢”类技能的完成态氛围。

当前画面可确认的视觉信息：
- 主体是站在中心的角色
- 角色脚下和周围向外生长出一圈冰刺
- 地面同步出现放射状裂冰/碎冰平面
- 画面主色是冷蓝与白色高光
- 冰刺外围可见少量上升的亮点/碎屑粒子
- 整体构图是“中心目标 + 环形爆发 + 向外扩展的冰面装饰”

这张图对本页复现的指导意义是：
- `p66.md` 当前搭建的双发射器冰刺骨架，只是最终效果中的立体主体部分
- 真正完整的技能表现还需要地面裂冰、冷色发光、环境粒子和角色/命中构图共同配合
- 因此后续材质、附加粒子和后处理的目标，不是单独让冰刺更漂亮，而是让整套效果接近这张参考图的“中心冻结爆发”观感

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。

