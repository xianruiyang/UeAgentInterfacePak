# 13-2.Houdini FLIP模拟VAT制作

# 13-2.Houdini FLIP模拟VAT制作

## 关键术语

- `Alpha`、`Houdini`、`VAT`、`PS`、`粒子`、`系统`、`网格`、`碰撞`、`生命周期`、`Niagara`、`Emitter`、`Particle`、`Spawn Rate`、`Spawn`、`Particle Spawn`、`Lifetime`、`Niagara System`、`Initialize Particle`

## 分段知识

### 00:00:00-00:04:40 缓存

- 本段定位：缓存。
- 知识点：现在的动态效果明显更生动了,计算准确度提升带来的变化很明显。
- 知识点：这些区域的飞箭水花也得到了充分呈现,缓存部分就做到这一步收尾。
- 知识点：现在要生成VT资源,得先创建检查流体表面,建议设的偏低一些。
- 知识点：Separation仍设到约5,数值会偏高一些。
- 知识点：只需确认是否能满足VT渲染要求即可。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`流体`。

**关键画面：**

这一帧承接上一节的流体缓存结果，先在 `Character` 网络里把缓存出来的流体表面与角色重新合并预览，确认当前版本的水花和扰动已经足够生动，可以作为后续生成 VT 资源的基础。视口里角色跪在蓝色流体面上，周围浅蓝/白色飞溅区域已经明显展开，说明缓存阶段的目标是先把动态效果稳定到可用状态。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点链路：
  - `filecache1`
  - `particlefluidsurface1`
  - `merge1`
- 当前选中节点：
  - `filecache1`
- 当前 `filecache1` 可见缓存设置：
  - `Base Name = Ex_03.filecache1`
  - `Base Folder = $HIP/geo`
  - `Version = 1`
  - `Start/End/Inc = 1 / 150 / 1`
  - `Substeps = 1`
- 当前视口状态：
  - 角色模型已与流体表面一起显示
  - 角色膝部周围的亮色飞溅和浅色扰动带已经成型
  - 底部时间轴约在第 `78` 帧
- 当前画面结论：
  - 这一帧说明缓存阶段的最终目标已经达到：关键动作区域的飞溅水花被充分呈现，而不是只有一块平淡的速度热区
  - 这与正文里“动态效果明显更生动了”“这些区域的飞箭水花也得到了充分呈现，缓存部分就做到这一步收尾”一致
- 结果含义：
  - 到这一步，基础流体缓存已经可以收尾，后续工作重点将从“让模拟更对”转向“把现有结果转换成适合 VT/VAT 渲染和资源导出的形式”。
这一帧已经从单纯看缓存结果，转到为 VT/VAT 资源准备可用流体表面数据的阶段。中央网络显示缓存输出先进入两级 `particlefluidsurface` 处理，再通过 `delete1` 做点级清理；左侧视口当前没有直接显示结果，说明这里关注的是数据筛选链本身，而不是即时视觉效果。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点链路：
  - `filecache1`
  - `particlefluidsurface1`
  - `merge1`
  - `particlefluidsurface2`
  - `delete1`
- 当前选中节点：
  - `delete1`
- 当前 `delete1` 可见设置：
  - `Entity = Points`
  - `Geometry Type = All Types`
  - `Enable` 已开启
  - `Operation = Delete by Expression`
  - `Filter Expression = @P.y < 0.12`
  - `Delete Unused Groups` 已开启
- 当前时间线状态：
  - 底部时间轴约在第 `78` 帧
- 当前画面结论：
  - 这一帧说明教程已经开始为后续 VT 资源导出做表面清理，不再直接沿用原始缓存结果
  - 这与正文里“现在要生成 VT 资源，得先创建检查流体表面”“只需确认是否能满足 VT 渲染要求即可”一致
- 结果含义：
  - 在生成 VT/VAT 资源前，先用 `particlefluidsurface` 和 `delete` 这类节点筛掉不需要的低位点或噪声点，可以让后续导出的流体表面更干净、更适合贴图化处理。
这一帧已经把流体表面清理链继续推进到减面阶段，目的是让处理后的流体网格更适合后续 VT/VAT 资源生成。视口里角色和流体表面都变成灰色网格态，说明当前不再看粒子，而是在直接检查网格密度与轮廓保留情况；中央网络则显示 `particlefluidsurface -> delete -> polyreduce` 的资源化链路。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点链路：
  - `filecache1`
  - `particlefluidsurface1`
  - `merge1`
  - `particlefluidsurface2`
  - `delete1`
  - `polyreduce1`
- 当前选中节点：
  - `polyreduce1`
- 当前 `polyreduce1` 可见设置：
  - `Target = Percentage of Input Polygon Count`
  - `Percent To Keep = 30`
  - `Use Only Original Point Positions` 未开启
  - `Preserve Quads` 未开启
  - `Equalize Lengths = 1e-10`
  - `Boundaries = 1`
  - `Vertex Attribute Seams = 1`
  - `Attributes = * ^N`
  - `Soft Points Weight = 1`
  - `Soft Edges Weight = 1`
- 当前视口状态：
  - 角色和流体表面都以网格形态显示
  - 流体表面已经形成可见的大块网格面，而不是粒子点
  - 底部时间轴约在第 `58` 帧
- 当前画面结论：
  - 这一帧说明教程已经从“清理可用表面”进一步进入“把表面减到适合资源输出的复杂度”这一步
  - 这与正文里“只需确认是否能满足 VT 渲染要求即可”一致
- 结果含义：
  - 在 VT/VAT 资源制作前，适度减面可以显著降低后续烘焙和运行负担，但仍需保住角色周围主要飞溅轮廓；这正是这里 `polyreduce1` 要平衡的目标。

### 00:04:40-00:09:15 粒子、纹理、缓存

- 本段定位：粒子、纹理、缓存。
- 知识点：150针不算少,控制在10万左右没问题。
- 知识点：嗯,确实挺久的,所以…… 平时一定要提前仔细检查,做这种重任务时,最好先把别的事安排好。
- 知识点：去忙别的事时,先把随机值设好就行。
- 知识点：下班或去开会时,直接设置好,就去忙别的就行。
- 知识点：现在应该用动态重彩样来处理VT资源。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`粒子`。

**关键画面：**

这一帧继续停在 VT 资源准备链的减面阶段，但重点从“是否减面”转成“减完之后整体几何规模是否还可接受”。左侧视口里流体和角色都保持网格态，中央网络仍停在 `polyreduce1`，同时弹出的节点信息面板直接给出了当前几何规模，便于判断 150 帧级别的缓存资源是否还能控制在合理范围内。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点链路：
  - `filecache1`
  - `particlefluidsurface1`
  - `merge1`
  - `particlefluidsurface2`
  - `delete1`
  - `polyreduce1`
- 当前选中节点：
  - `polyreduce1`
- 当前 `polyreduce1` 可见设置：
  - `Target = Percentage of Input Polygon Count`
  - `Percent To Keep = 30`
  - `Boundaries = 1`
  - `Vertex Attribute Seams = 1`
  - `Attributes = * ^N`
- 当前节点信息面板可见统计：
  - `Points = 97,859`
  - `Primitives = 162,557`
  - `Vertices = 520,740`
  - `Polygons = 162,557`
  - `Geometry Memory = 13.27 MB`
  - `Last Cook Time = 5.87`
- 当前时间线状态：
  - 底部时间轴约在第 `60` 帧
- 当前画面结论：
  - 这一帧说明教程已经开始以实际几何数量和内存占用来评估 VT 资源是否可承受，而不只是凭视觉判断
  - 这与正文里“150 帧不算少，控制在 10 万左右没问题”一致
- 结果含义：
  - 在 VT/VAT 资源化阶段，减面不是越狠越好，而是要把轮廓保住的同时，把单帧网格复杂度控制在后续烘焙和运行能接受的区间。
这一帧已经正式切到 VAT 输出节点，说明本段工作重点从“整理流体表面网格”转为“把结果打包成 Unreal 可用的 Vertex Animation Textures”。中央网络只保留一个 `vertex_animation_textures1`，右侧参数面板则完整展示了当前导出模式、输入几何、贴图格式和查找表尺寸等关键信息。

- 当前网络位置：
  - `/out`
- 当前可见节点：
  - `vertex_animation_textures1`
    - 类型：`Labs Vertex Animation Textures`
- 当前 `Render All` 关键设置：
  - `Mode / Target Engine = Dynamic Remeshing (Fluid)`
  - 目标引擎：`Unreal Engine`
  - `Start/End = 1 / 150`
  - `Input Geometry = /obj/Character/OUT_Render`
- 当前 `Dynamic Remeshing` 可见设置：
  - `Render Pass = First Pass (Geometry, Lookup Table, Data/Material)`
  - `Export Compressed Normals in Position Alpha` 未开启
  - `Export Surface UVs in Position Alpha and Color Alpha` 未开启
  - `Export Surface UVs in Color Red and Green` 未开启
- 当前 `All Modes` 可见设置：
  - `Input Geometry Is Cached to Integer Frames` 已开启
  - `Lookup Table Format = Non-HDR`
  - 查找表图片格式：`.png`
  - `Texture Format = HDR`
  - 纹理格式扩展：`.exr`
  - `Include Hidden Debug Plane in Geometry` 已开启
- 当前自定义导出尺寸：
  - `Lookup Table Width = 8192`
  - `Target Texture Width = 1`
  - 底部提示：`Input Geometry Limit 147456 Triangles per Frame`
- 当前视口状态：
  - 左侧显示的是已经网格化的流体表面，用于对照即将导出的几何输入
- 当前画面结论：
  - 这一帧能确认教程已经不再停留在 Houdini 内部表面处理，而是进入 VAT 输出环节，并选择了专门针对流体的 `Dynamic Remeshing` 模式
  - 这与正文里“现在应该用动态重采样来处理 VT 资源”一致
- 结果含义：
  - 后续在 Unreal 里复原这套流体动画，依赖的就是这里导出的查找表、纹理和几何约束；因此导出模式、帧范围和三角面上限都必须先在这一层确认清楚。
这一帧继续在资源输出准备链里往下走，但已经从单纯的流体表面处理切到白水源预览。中央网络显示缓存结果一方面送往 `particlefluidsurface` 链，另一方面直接分支到 `whitewatersource1`；右侧面板的参数也明确表明，这一步是先用可视化方式观察白水发射源的大致范围和密度，而不是最终定稿数值。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点链路：
  - `fluidcompress1`
  - `filecache1`
  - `whitewatersource1`
  - `particlefluidsurface1`
  - `particlefluidsurface2`
  - `delete1`
- 当前选中节点：
  - `whitewatersource1`
- 当前 `whitewatersource1` 在 `Visualization` 页签下可见设置：
  - `Visualize Emission Volume` 已开启
  - `Whitewater Scale = 0.01`
  - `Emission Amount = 5`
  - `Max Point Limit = 1000000`
  - `Output Point Velocity` 未开启
  - `Output Emission Attributes` 未开启
- 当前可见颜色映射：
  - `Curvature Color` 设为红通道
  - `Acceleration Color` 设为绿通道
  - `Vorticity Color` 设为蓝通道
- 当前视口状态：
  - 左侧视口当前没有直接显示结果网格，重点放在节点与可视化参数确认
- 当前画面结论：
  - 这一帧说明教程已经开始用白水源节点把不同触发条件可视化出来，作为后续粒子/纹理资源生成的前置判断
  - 这与正文里“现在这个阶段就当是可视化预览用的，不用太在意”一致
- 结果含义：
  - 在真正把白水或附加粒子带入 Niagara 之前，先确认这里的发射源规模和颜色分层逻辑是否合理，可以避免后面把错误的触发条件直接带进引擎侧。

### 00:09:15-00:14:03 粒子、系统、网格

- 本段定位：粒子、系统、网格。
- 知识点：飞箭剧烈的区域分别显示覆盖层、加速度和波动性三种颜色,他们各自代表不同的效果。
- 知识点：这三种颜色的出现,是因为白水生成的触发条件,分为覆盖层、加速度和波动性三种。
- 知识点：分别依据覆盖层、加速度和波动性三种条件划分,因此,用三种颜色表示。
- 知识点：我们先用预览查看一下,现在仅在空中显示,可能不太清晰,但效果就是这样,不过预览速度太慢了。
- 知识点：这相当于决定是否生成园的条件,只有当速度范围在2到4之间时,才会进行二次筛选。
- 知识点：夹速度直接作为判定依据,而速度则偏向于带有轻微旋转感的粒子。
- 知识点：碰撞时会产生完全相反的速度,计算逻辑较复杂,只要理解这个基本原理就够了。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`粒子`、`系统`、`速度`、`颜色`、`碰撞`。

**关键画面：**

这一帧进入白水触发条件的预览分支。中央网络表明 `filecache1` 一方面仍供给流体表面链，另一方面分支到 `whitewatersource1`，并接了一个仅用于中转/显示的 `null2`；状态栏显示当前正在执行白水源体积相关计算，说明这一步的目标是先把白水触发结果可视化出来，而不是立即输出最终粒子。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点链路：
  - `fluidcompress1`
  - `filecache1`
  - `whitewatersource1`
  - `null2`
  - `particlefluidsurface1`
  - `particlefluidsurface2`
  - `delete1`
- 当前选中节点：
  - `null2`
- 当前 `null2` 可见状态：
  - `Copy Input` 已开启
  - `Cache Input` 未开启
- 当前视口状态：
  - 左侧视口暂时没有显示明确几何结果，说明当前重点是节点计算与中间结果预览
- 当前执行状态：
  - 状态栏显示正在执行 `whitewatersource1` 相关体积/VEX 计算
- 当前画面结论：
  - 这一帧说明白水系统的三类触发条件结果正在被单独拉出来做预览，而不是直接混进最终流体表面
  - 这与正文里“我们先用预览查看一下”“不过预览速度太慢了”一致
- 结果含义：
  - 后续要区分覆盖层、加速度和波动性三种白水发射条件时，首先依赖的就是这类从 `whitewatersource1` 分出的中间结果视图，而不是最终 Niagara 里看到的混合效果。
这一帧是白水触发条件三色预览的核心视图。左侧视口里，灰色流体网格周围已经出现红/绿/蓝三类点状标记，用来分别表示不同的白水发射依据；右侧参数面板则明确显示这些颜色对应的其实是 `Curvature`、`Acceleration` 和 `Vorticity` 三组发射源，并且每组都有独立的范围阈值。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点链路：
  - `whitewatersource1`
  - `null2`
  - `particlefluidsurface1`
  - `merge1`
  - `particlefluidsurface2`
  - `delete1`
  - `polyreduce1`
  - `filecache2`
  - `merge2`
  - `OUT_Render`
- 当前选中节点：
  - `whitewatersource1`
- 当前 `whitewatersource1` 在 `Visualization` 页签下可见分组：
  - `Curvature`
    - `Emit from Curvature` 已开启
    - `Max Velocity Angle = 45`
    - `Curvature Range = 8 - 10`
  - `Acceleration`
    - `Emit from Acceleration` 已开启
    - `Acceleration Range = 30 - 60`
  - `Vorticity`
    - `Emit from Vorticity` 已开启
    - `Vorticity Range = 20 - 40`
  - 还可见但未展开的分组：
    - `Pressure`
    - `Splash`
- 当前视口状态：
  - 灰色流体网格作为背景形体
  - 红、绿、蓝三类点分散出现在不同区域，作为三种触发条件的可视化覆盖
  - 底部时间轴约在第 `60` 帧
- 当前画面结论：
  - 这一帧直接证明三种颜色不是随便染色，而是三种不同白水发射条件的独立可视化层
  - 这与正文里“飞溅剧烈的区域分别显示覆盖层、加速度和波动性三种颜色”“分别依据三种条件划分，因此用三种颜色表示”一致
- 结果含义：
  - 后续在 Niagara 里拆分不同类型的附加粒子效果时，可以把这里的三组发射条件理解为三类不同触发掩码来源，而不是把所有白水都当成同一种粒子处理。
这一帧继续停留在 `whitewatersource1` 的三色预览阶段，但把白水源分支和后续资源输出链同时放进一个视图里，便于确认“白水触发结果”会如何继续流向后面的表面、减面和缓存节点。左侧视口里依然能看到红/绿/蓝三类触发点分布在灰色流体网格周围，说明当前讲解重点仍然是三种生成条件本身，而不是新建别的求解器逻辑。

- 当前网络位置：
  - `/obj/Character`
- 当前可见节点链路：
  - `fluidcompress1`
  - `filecache1`
  - `whitewatersource1`
  - `null2`
  - `particlefluidsurface1`
  - `particlefluidsurface2`
  - `delete1`
  - `polyreduce1`
  - `filecache2`
- 当前选中节点：
  - `whitewatersource1`
- 当前 `whitewatersource1` 在 `Visualization` 页签下仍可见的关键设置：
  - `Emit from Curvature` 已开启
  - `Curvature Range = 8 - 10`
  - `Emit from Acceleration` 已开启
  - `Acceleration Range = 30 - 60`
  - `Emit from Vorticity` 已开启
  - `Vorticity Range = 20 - 40`
- 当前视口状态：
  - 灰色流体网格上方和边缘仍能看到红、绿、蓝三色触发点
  - 三色分布集中在飞溅更明显、速度/曲率变化更剧烈的位置
  - 底部时间轴约在第 `60` 帧
- 当前画面结论：
  - 这一帧强调的是：白水触发条件并不是独立于资源导出链之外的临时可视化，而是会直接决定后续附加粒子资源从哪些区域发射
  - 这与正文里“只有当速度范围在 2 到 4 之间时，才会进行二次筛选”“速度则偏向于带有轻微旋转感的粒子”一致
- 结果含义：
  - 在后续 Niagara 侧做白水、泡沫或飞溅细分时，这里看到的三色分布可以直接作为理解发射来源和调优触发阈值的依据，而不必等到引擎里再盲调。

### 00:14:03-00:18:47 粒子、碰撞、生命周期

- 本段定位：粒子、碰撞、生命周期。
- 知识点：接下来将正式连接求解器,开始生成白水模拟。
- 知识点：首先请关闭碰撞体显示。
- 知识点：弹性值的比例也可调节,最大值和初始速度建议设为0.3左右。
- 知识点：生命周期参数值粒子生成后的存活时长设为0.3左右即可。
- 知识点：立场参数可参考重力与浮力的设定,一般保持相近数值即可。
- 知识点：浮力的强度和缩放系数,建议设一设为100左右,其他参数可保持默认。
- 知识点：曲线形态无需精细调节,重点调整缩放系数,浮力和重力即可。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`粒子`、`生命周期`、`速度`、`曲线`、`碰撞`。

**关键画面：**

这一帧仍在展示白水发射源 `whitewatersource1` 的预览结果与可视化筛选参数，还没有进入后续粒子求解器的详细参数调节。中间网络视图可见主链从 `filecache1` 分出一支进入 `whitewatersource1`，其输出接到 `null2` 作为当前预览节点；右侧主链同时继续流向后面的 `particlefluid...`、`delete1`、`polyreduce...` 和 `filecache2`。左侧视口显示白水候选点分布在浪头和飞溅区域，彩色点主要附着在波峰、卷曲和破碎位置，用来直观看发射区域是否覆盖到需要生成泡沫的位置。

右侧参数面板打开的是 `Whitewater Source > Visualization`。当前启用三组发射依据：

- `Curvature`
  - 勾选 `Emit from Curvature`
  - `Max Velocity Angle = 45`
  - `Curvature Range = 8 -> 10`
- `Acceleration`
  - 勾选 `Emit from Acceleration`
  - `Acceleration Range = 30 -> 60`
- `Vorticity`
  - 勾选 `Emit from Vorticity`
  - `Vorticity Range = 20 -> 40`

这一帧的作用是确认默认可视化筛选已经能在浪尖和飞溅边缘抓到足够的白水发射区域，因此本段教程强调这些阈值不用大改，先保持可用的默认质量，再进入后面的粒子、碰撞和生命周期调节。
这一帧进入白水求解器 `whitewatersolver1`。网络视图可见它位于 `filecache3` 下游，并把结果继续送往后面的合并链路；左侧视口几乎没有可见粒子，说明教程此时主要是在先整理求解器的基础可视化和缓存属性，而不是展示最终泡沫形态。

右侧打开的是 `Whitewater Solver > Visualization` 页面，可确认的参数如下：

- `General`
  - `Whitewater Scale = 0.01`
  - `Voxel Size = 0.5`
  - `Foam Location = 0`
  - `Depth Range = 0.8`
  - 勾选 `Keep Attributes`
  - 保留属性文本可见为：`v pscale id bubble foam spray life age d...`
  - 勾选 `Add State Attributes`
  - 勾选 `Add Relative Density Attribute`
- `Simulation`
  - `Substeps = 1`
  - `Cache Memory (MB) = 5000`

结合本段正文，这一帧表达的是先把白水求解器放到稳定可缓存的基础状态：缩放仍保持很小的 `0.01`，分步数先维持 `1`，缓存内存给到 `5000 MB`，并保留粒子状态相关属性，方便后续继续调碰撞、寿命、浮力和速度等行为参数。
这一帧继续停留在 `whitewatersolver1`，但参数页已经切到泡沫聚集、侵蚀、排斥和贴附控制，用来决定白水粒子在水面附近是更自然地散开，还是形成更明显的网状泡沫痕迹。左侧视口仍为空场景预览，说明教程强调的是参数逻辑，而不是当前帧的外观展示。

右侧当前可见参数如下：

- `Clumping`
  - 勾选 `Enable Density Control`
  - `Depth Range = -0.75 -> 0.25`
  - `Constraint Stiffness = 1`
  - 未勾选 `Variable Stiffness`
- `Advanced > Erosion`
  - `Enable Erosion` 未开启，因此侵蚀相关数值保持灰置
- `Repellants`
  - 勾选 `Enable Repellants`
  - `Reseed Frames = 5`
  - `Feature Size Range = 0.5 -> 0.9`
  - `Strength Range = 10 -> 15`
  - `Noise Range = 0 -> 1`
  - `Pulse Frequency Range = 0`
  - `Life Range` 与 `Density Threshold` 区域可见但当前未作为重点调节项展示
- `Advanced > Adhesion`
  - 勾选 `Enable Depth Control`
  - 勾选 `Upper Surface Only`
  - `Control Range = -0.6`
  - `Off Velocity Angle = 30`
  - 下方 `Stiffness by Depth` 曲线用于按深度分配贴附强度

结合正文“调高后会出现网状纹理”的说明，这一页对应的就是白水求解器里控制泡沫聚团和排斥花纹的核心区域：开启密度控制、排斥与深度贴附后，泡沫不会只按自然破裂方式随机消散，而会在表面形成更明显的网状、拉丝状残留纹理。

### 00:18:51-00:23:16 Niagara、粒子、速度

- 本段定位：Niagara、粒子、速度。
- 知识点：海浪冲击后,泡沫破裂消散时,会形成类似网状的纹理。
- 知识点：当波浪拍打时,泡沫散开的痕迹会呈现网状纹理。
- 知识点：这个就是用来生成这种网状纹理的设置。
- 知识点：关掉的话就看不到这种纹理了。
- 知识点：关掉就是自然破裂的样子,调高后,这个值就会出现网状纹理。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Niagara`、`纹理`、`粒子`、`速度`。

**关键画面：**

这一帧继续展示白水求解器 `whitewatersolver1` 中决定泡沫是否形成网状残留的行为参数。网络视图里当前节点仍位于 `filecache3` 下游，并向下游 `merge2` 输送结果；左侧视口没有启用强调性的粒子显示，说明这一帧重点依旧是参数结构本身。

右侧当前可见参数如下：

- `Clumping`
  - 勾选 `Enable Density Control`
  - `Depth Range = -0.75 -> 0.25`
  - `Constraint Stiffness = 1`
  - 未勾选 `Variable Stiffness`
- `Advanced > Erosion`
  - `Enable Erosion` 处于未启用状态，侵蚀相关数值仍灰置
- `Repellants`
  - 勾选 `Enable Repellants`
  - `Reseed Frames = 5`
  - `Feature Size Range = 0.5 -> 0.9`
  - `Strength Range = 10 -> 15`
  - `Noise Range = 0 -> 1`
  - `Pulse Frequency Range = 0`
  - `Life Range` 输入框当前可见但未作为主要调节目标强调
  - `Density Threshold = -0.75`
- `Advanced > Adhesion`
  - 勾选 `Enable Depth Control`
  - 勾选 `Upper Surface Only`
  - `Control Range = -0.6`
  - `Off Velocity Angle = 30`
  - 下方 `Stiffness by Depth` 曲线保持启用

结合本段“这种效果您应该见过不少了”的说明，这一帧说明教程正在利用求解器内部的密度聚团、排斥噪声和表面贴附，把白水从普通自然消散调整成更常见的海浪泡沫网状纹理效果。
这一帧从 `whitewatersolver1` 切到了下游缓存输出节点，网络里可以看到白水链路为 `whitewatersource1 -> whitewatersolver1 -> attribdelete1 -> filecache4 -> merge2`。右侧当前选中的是 `File Cache filecache4`，说明教程开始把求解后的白水粒子整理成可落盘、可并回主链的缓存资源。

右侧 `File Cache` 面板当前可确认的信息：

- 顶部按钮：
  - `Load from Disk`
  - `Reload Geometry`
- 基础路径
  - `File Path = Constructed`
  - `Base Name = $HIPNAME.$OS`
  - `Base Folder = $HIP/geo`
  - `Version = 1`
- `Caching > Sequence`
  - `Evaluate As = Frame Range`
  - 勾选 `Simulation`
  - `Start/End/inc = 1 / 150 / 1`
- `Load`
  - 下拉框当前为 `All Geometry`

左侧视口里已经能看到一小团黑色粒子，这表示白水求解结果已从纯参数阶段进入实际缓存后的粒子形态检查。结合本段正文“再把角色一起融合看看”，这一帧的作用是先确认白水缓存区间和文件命名有效，再把它与其他结果合并到最终输出链里。
这一帧继续检查 `filecache4` 的缓存结果，但时间线已经来到中段帧，左侧视口放大显示出白水粒子的实际形态：大量黑色粒子沿着浪头边缘和飞溅断裂带聚成弯曲、串联、网状的泡沫纹路，说明前面在 `whitewatersolver1` 中调的密度控制、排斥和贴附参数已经开始产生目标效果。

网络结构仍然是 `whitewatersolver1 -> attribdelete1 -> filecache4 -> merge2`，右侧 `File Cache filecache4` 面板当前可见信息包括：

- `File Path = Constructed`
- 勾选 `Time Dependent Cache`
- `Base Name = Ex_03.filecache4`
- `Base Folder = $HIP/geo`
- `Version = 1`
- `Sequence`
  - `Evaluate As = Frame Range`
  - 勾选 `Simulation`
  - `Start/End/inc = 1 / 150 / 1`
- `Load = All Geometry`

与上一张小范围粒子预览相比，这一帧已经能确认最终白水不是简单散点，而是更贴近海浪泡沫的团簇加网状分布。结合紧接着正文“控制到这个程度就行，接下来进入 Flip 环节”，这里表达的验收标准就是：白水缓存结果已经足够圆润、成团，点数也不算夸张，可以停止继续细调，转入后续导入和翻页流程。

### 00:23:16-00:27:00 Alpha、PS、粒子

- 本段定位：Alpha、PS、粒子。
- 知识点：开启聚类后,这些区域会更圆润的聚成团,我们再把角色一起融合看看。
- 知识点：我们来确认下效果,把这两个资源导入虚幻引擎,同步后就能完成。
- 知识点：类型可以不用,CD和Alpha值也不需要传入。
- 知识点：不需要,Pscale也不需要,包含一些CD或Alpha值也可以。
- 知识点：控制到这个程度就行,开始渲染点数不多,渲染速度很快,接下来进入Flip环节。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Alpha`、`粒子`、`速度`、`碰撞`。

**关键画面：**

这一帧再次选中 `whitewatersolver1`，但左侧视口同时显示了已经成形的白水粒子结果，因此这一画面是在“看结果同时回调参数”。可见粒子沿浪头边缘形成大面积团簇和网状断裂带，说明教程正在微调这些表面泡沫纹理的细碎程度与聚散密度。

网络结构仍为 `whitewatersolver1 -> attribdelete1 -> filecache4 -> merge2`。右侧当前可见的是 `Whitewater Solver` 中与网状泡沫细节直接相关的参数：

- `Clumping`
  - 勾选 `Enable Density Control`
  - `Depth Range = -0.75 -> 0.25`
  - `Constraint Stiffness = 1`
  - 未勾选 `Variable Stiffness`
- `Advanced > Erosion`
  - `Enable Erosion` 未开启
- `Repellants`
  - 勾选 `Enable Repellants`
  - `Reseed Frames = 5`
  - `Feature Size Range = 0.02 -> 0.1`
  - `Strength Range = 10 -> 15`
  - `Noise Range = 0 -> 1`
  - `Pulse Frequency Range = 0`
- `Advanced > Adhesion`
  - 勾选 `Enable Depth Control`
  - 勾选 `Upper Surface Only`
  - `Control Range = -0.6`
  - `Off Velocity Angle = 30`
  - 下方 `Stiffness by Depth` 曲线保持启用

与前面 `0.5 -> 0.9` 的较大特征尺度相比，这一帧把 `Feature Size Range` 缩小到了 `0.02 -> 0.1`，因此目标已经从“形成明显块状聚团”转向“把块状泡沫细化成更碎、更贴近海浪表面花纹的网状结构”。
这一帧进入将白水缓存导出为 Niagara 可用数据的阶段。网络中可见 `filecache4` 的输出接入 `niagara1`，再与旁边的 `merge2`、`filecache2`、`color1`、`OUT_Render` 一起组成最终导出链；左侧还弹出了 `filecache4` 的节点信息面板，用来确认当前缓存内实际有哪些点属性。

左侧 `filecache4` 信息面板可确认：

- 节点：`/obj/Character/filecache4`
- 统计：
  - `Points = 10,159`
  - `Primitives = 0`
  - `Vertices = 0`
  - `Unconnected Points = 10,159`
- 可见点属性共 `11 Point Attributes`，面板中明确列出：
  - `age`
  - `bubble`
  - `depth`
  - `foam`
  - `id`
  - `life`
  - `P`
  - `pscale`
  - `relativedensity`
  - `spray`
  - `v`

右侧 `Labs Niagara ROP niagara1 > General` 面板当前可见配置：

- `ROP Settings`
  - `Frame Range / Time... = Render Frame Range`
  - `Start/End/inc = 1 / 150 / 1`
  - `Render with Take = (no...)`
  - 勾选 `Create Intermediate Directories`
  - `Output Path = $HIP/$OS.hbjson`
- `Attributes`
  - `Number of Renames = 0`
  - 未勾选 `Overwrite Existing Attributes`
  - `Keep Attributes` 当前写入：`P id time v life Cd Alpha age pscale`
  - `Cast Attributes = 2`
  - 勾选 `Clamp Attributes That Are Outside Type Range`

结合正文“类型可以不用，Cd 和 Alpha 值也不需要传入；pscale 也不需要”，这一帧表达的是导出前先核对源缓存里有哪些属性，再在 `Keep Attributes` 里决定真正传给 Niagara 的最小属性集合，避免把无关字段一起带进 Unreal。
这一帧继续停留在 `Labs Niagara ROP niagara1`，但画面比上一张更适合看最终导出链的整体关系。中间网络图可见白水链 `whitewatersource1 -> whitewatersolver1 -> attribdelete1 -> filecache4 -> niagara1` 已经独立整理完成；右侧同时保留了液面网格链 `particlefluidsurface2 -> delete1 -> polyreduce1 -> filecache2 -> color1 -> OUT_Render`，说明教程在结束前把“给 Niagara 的白水粒子缓存”和“给渲染/导出的液面结果”都整理到了可交付状态。

右侧 `Labs Niagara ROP niagara1 > General` 面板当前可确认信息：

- `ROP Settings`
  - `Frame Range / Time... = Render Frame Range`
  - `Start/End/inc = 1 / 150 / 1`
  - 勾选 `Create Intermediate Directories`
  - `Output Path = $HIP/$OS.hbjson`
- `Attributes`
  - `Number of Renames = 0`
  - `Keep Attributes` 当前收缩为：`P id time v life Cd Alpha age`
  - `Cast Attributes = 2`
  - 勾选 `Clamp Attributes That Are Outside Type Range`

和上一张相比，`Keep Attributes` 已经去掉了 `pscale`，表明教程把导出字段进一步压缩到了真正准备传给 Niagara 的最小集合。结合正文“控制到这个程度就行……接下来进入 Flip 环节”与字幕“接下来就用这些准备好的资源”，这一帧的含义是：本页所有 Houdini 侧白水资源已经整理完成，后续只需拿这些缓存和 `.hbjson` 导出结果进入 Unreal/后续章节继续组装完整效果。

## 补充视觉证据

### S01 00:01:26

这张补充图单独记录了液面重建节点 `particlefluidsurface2` 的参数页，用来补足主线截图里没有完整露出的表面化设置。网络图可见当前节点位于 `particlefluidsurface1` 下游，并把结果送入 `merge1`；左侧视口为空场景，底部状态栏显示该节点正在执行 `Computing Fluid Density`，说明这是在表面重建计算过程中截取的参数证据图。

右侧 `Particle Fluid Surface particlefluidsurface2 > Surfacing` 当前可见设置如下：

- `Method = Average Position`
- `Particle Separation = 0.005`
- `Voxel Scale = 0.75`
- `Influence Scale = 3`
- `Droplet Scale = 0.7`
- `Limit Refinement` 未启用
- 勾选 `Union Compressed Fluid Surface`
- `Erosion Scale = 0.8`

`Output` 区域当前可见设置：

- `Convert To = Surface Polygon Soup`
- `Isovalue = 0`
- `Adaptivity = 0.1`
- 勾选 `Transfer Attributes`
- `Transfer Attributes` 内容：`v vorticity rest rest2`
- `Attribute Radius = 2`
- `Attribute Samples = 10`
- `Visualize = None`

这张图的作用是明确液面网格从粒子转成可渲染表面的关键参数组合：先用较小的 `Particle Separation` 和 `Voxel Scale` 保证重建精度，再通过 `Influence Scale`、`Droplet Scale`、`Erosion Scale` 控制表面厚度、飞滴保留和侵蚀感，最后把 `v / vorticity / rest / rest2` 这些后续材质或运动相关属性一起转移到输出表面上。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。

