# 19-2.Houdini 破碎模拟资源制作

# 19-2.Houdini 破碎模拟资源制作

## 关键术语

- `Material`、`Material Instance`、`Houdini`、`粒子`、`系统`、`网格`、`碰撞`、`生命周期`、`速度`、`透明度`、`Niagara`、`Particle`、`Normalized Age`、`材质`、`贴图`、`蓝图`、`Niagara System`、`Emitter`

## 分段知识

### 00:00:01-00:04:37 网格、碰撞、缓存

- 本段定位：网格、碰撞、缓存。
- 知识点：可以认为时机已调好,让物体缓缓下落,就在那儿,先看看下落点。
- 知识点：简单模拟下30帧左右第一次撞击,到70帧左右时以脱离模拟控制。
- 知识点：还有没有漏掉的地方在动? 哦,这次动了,再确认一遍。
- 知识点：抱歉,一次陨石冲击多少能裂开些,但刚才那块粘在一起的地方还没碎透。
- 知识点：会再碎的刚才这个碰撞网格分组,就是为后面烘焙缓存后好删。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`碰撞`。

**关键画面：**

这一帧是在第一次撞击测试前检查整体网络。主破碎链、两颗陨石撞击体分支，以及限制破坏范围的盒体分支都已经汇入同一套 RBD 求解流程。

- 主破碎链可见：
  - `normal1`、`normal2` 汇入 `merge1`
  - `merge1 -> color1 -> attribute1 -> transform1 -> rbdmaterialfracture1 -> rbdpack1`
  - `rbdmaterialfracture1` 旁边保留 `explodeview1` 作为预览支路
- 第一颗陨石分支可见：
  - `sphere1 -> transform2 -> attribwrangle1 -> group1 -> name1 -> rbdpack2`
- 第二颗陨石分支可见：
  - `sphere2 -> transform7 -> attribwrangle2 -> group2 -> name2 -> rbdpack3`
- 合流与求解链：
  - `rbdpack1`、`rbdpack2`、`rbdpack3` 一起汇入 `merge2`
  - `merge2 -> rbdunpack1 -> rbdconfigure1 -> rbdconstraintproperties1 -> rbdbulletsolver1`
  - 右下方限制分支仍为多组 `box -> transform -> merge3`
- 当前选中节点：`group2`
- `group2` 参数面板可确认：
  - `Group Name = meteor_01`
  - `Group Type = Primitives`
  - `Initial Merge = Replace Existing`
  - `Geometry Filter = All Types`
- 视口结果：
  - 左侧可见桥体上方悬着一颗撞击球，桥体周围仍保留多个透明盒体，说明当前是在碰撞分组与受限区域都接好后，准备继续看掉落点与撞击结果。
这一帧是在测试第二次撞击后的掉落结果，同时把第二颗陨石的分组名独立出来，避免与第一颗陨石继续共用同一组名。

- 当前可见求解链：
  - `merge2 -> rbdunpack1 -> rbdconfigure1 -> rbdconstraintproperties1 -> rbdbulletsolver1`
  - 右上限制分支可见 `box1/box2 -> transform... -> merge3`
- 当前选中节点：`group2`
- `group2` 参数面板可确认：
  - `Group Name = meteor_02`
  - `Group Type = Primitives`
  - `Initial Merge = Replace Existing`
  - `Geometry Filter = All Types`
- 视口结果：
  - 时间轴位于大约第 `84` 帧。
  - 左侧桥体顶部已经明显碎裂，大块碎块正向下掉落。
  - 透明包围盒仍保留在横梁两侧与立柱周边，说明局部限制区域继续生效；教程语义是让该大块落地后还能再发生一次破碎。
这一帧专门回到两颗陨石分支，确认它们已经使用不同的分组名，并重新摆正第二颗球的位置与尺寸，以便控制第二次撞击的落点。

- 左侧第一颗陨石分支：
  - `sphere1 -> transform2 -> attribwrangle1 -> group1 -> name1 -> rbdpack2`
  - `group1` 下方标注为 `meteor_01`
- 右侧第二颗陨石分支：
  - `sphere2 -> transform7 -> attribwrangle2 -> group2 -> name2 -> rbdpack3`
  - `group2` 下方标注为 `meteor_02`
- 当前选中节点：`transform7`
- `transform7` 可确认参数：
  - `Translate = (107.15, 70, 51.5)`
  - `Rotate = (0, 0, 0)`
  - `Scale = (0.5, 0.5, 0.5)`
  - `Uniform Scale = 1`
  - `Transform Order = Scale Rot Trans`
  - 旋转顺序显示为 `Rx Ry Rz`
- 视口结果：
  - 左侧视口只显示第二颗球和桥面局部，说明此时是在近距离核对第二颗陨石撞击球的落点与大小，而不是看整段模拟结果。

### 00:04:37-00:09:14 粒子、网格、碰撞

- 本段定位：粒子、网格、碰撞。
- 知识点：大致掉到这个范围就行,这次把质量网格也调进来,一起做一次缓存烘焙。
- 知识点：我来调一下环境模型,网格之前已经缩过比例,直接用就行。
- 知识点：还有,用多边形简化,把点数减一点,用起来更顺手。
- 知识点：生成了大概10万多个,再减一点也行对比下效果,这样和那样差别不大。
- 知识点：看轮廓边缘线,针数调至10%也差不多缓存已提前保存,现在先给粒子网格绑定缓存。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`粒子`、`碰撞`。

**关键画面：**

这一帧是在确认两颗撞击球的大致落点范围，并准备把质量/碰撞网格一起纳入同一次缓存烘焙。画面重点仍是第二颗球的位置微调，以及主破碎链、撞击体链和碰撞限制链的合流关系。

- 当前可见主链：
  - `attribute1 -> transform1 -> rbdmaterialfracture1 -> rbdpack1 -> merge2 -> rbdunpack1 -> rbdconfigure1 -> rbdconstraintproperties1 -> rbdbulletsolver1`
  - `rbdmaterialfracture1` 旁边保留 `explodeview1`
- 右侧可见限制区域分支：
  - 多组 `box -> transform -> merge3`
- 当前选中节点：`transform7`
- `transform7` 可确认参数：
  - `Translate = (108, 70, 51.5)`
  - `Rotate = (0, 0, 0)`
  - `Scale = (0.5, 0.5, 0.5)`
  - `Uniform Scale = 1`
  - `Transform Order = Scale Rot Trans`
  - 旋转顺序显示为 `Rx Ry Rz`
- 视口结果：
  - 左侧场景中两颗撞击球都悬在桥体上方，分别对应不同撞击点。
  - 桥体周围仍保留透明盒状限制区域，说明当前是在确定撞击范围后，准备连同质量/碰撞网格一起做缓存烘焙。
这一帧展示把环境/质量网格单独接到简化与缓存链上，为后续粒子或碰撞引用准备一个更轻量的缓存版本。

- 左侧主模拟链仍可见：
  - `rbdconfigure1 -> rbdconstraintproperties1 -> rbdbulletsolver1`
- 右侧新增环境网格缓存链：
  - `object_merge4 -> polyreduce1 -> filecache2`
- 可确认节点标注：
  - `object_merge4` 下方路径显示为 `/obj/Env/OUT_ENV`
  - `polyreduce1` 标注 `Reduced To: 20.00%`
- 当前选中节点：`filecache2`
- `filecache2` 参数面板可确认：
  - `File Path = Constructed`
  - `Time Dependent Cache` 已勾选
  - `Base Name = $HIPNAME.$OS`
  - `Base Folder = $HIP/geo`
  - `Sequence > Evaluate As = Frame Range`
  - `Simulation` 已勾选
  - `Start/End/Inc = 1, 250, 1`
  - `Load = All Geometry`
- 视口结果：
  - 左侧显示的是岩体环境网格的三角面线框效果，说明这里关注的是环境碰撞/质量网格的面数压缩与缓存输出，而不是桥体破碎结果本身。
这一帧是在 `rbdbulletsolver1` 上检查碰撞几何显示效果，并把主模拟结果接到 `filecache1` 准备落盘缓存。

- 当前可见主链：
  - `rbdconfigure1 -> rbdconstraintproperties1 -> rbdbulletsolver1 -> filecache1`
- `rbdconstraintproperties1` 旁边仍可见两条约束分组标注，至少包含：
  - `@constraint_tag=concrete_fracture1`
  - 第二条 `@constraint_tag=concrete_fractu...` 在画面中被截断
- 当前选中节点：`rbdbulletsolver1`
- 当前面板：`Output`
- 可确认显示设置：
  - `Visualize Geometries` 已启用
  - `Ground = Wireframe`
  - `Collision Geometry > Show Geometry` 已勾选
  - `Collision Geometry` 颜色为蓝色
  - `Constraint Geometry > False Color Mode = None`
  - `Constraint Geometry > Show Guides` 未勾选
- 底部输入列表可见：
  - 3 个 `rbdconstraintproperties1`
  - 1 个 `filecache2`
- 视口结果：
  - 左侧场景中的岩体/环境碰撞几何以蓝色整体显示，桥体与限制盒体仍可见。
  - `filecache1` 节点已接在求解器下方，说明当前阶段是在确认碰撞显示无误后，准备把主模拟结果烘焙成缓存。

### 00:09:14-00:13:59 网格、碰撞、破碎

- 本段定位：网格、碰撞、破碎。
- 知识点：只确认到100帧左右,如果碰撞没问题,就用高精度烘焙一次缓存,再检查一下。
- 知识点：感觉不错的话,现在用VT缘渲染应该没问题了。
- 知识点：我觉得问题不大,这里已经有网格了,只是要空中有物体相撞滚动,就说明碰撞正常。
- 知识点：可以认为碰撞正常了,我们先暂停一下,看看代理几何体,你看这里,碰撞效果很清楚。
- 知识点：差不多了,比起一开始所有碎片哗啦全散开。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`碰撞`。

**关键画面：**

这一帧是在正式高精度烘焙前，再次总览撞击体分组和限制区域是否接对，用来确认碰撞逻辑已经稳定。

- 左侧两颗撞击体分支可见：
  - `sphere1 -> transform2 -> attribwrangle1 -> group1 -> name1 -> rbdpack2`
  - `sphere2 -> transform7 -> attribwrangle2 -> group2 -> name2 -> rbdpack3`
- 两个分组标注可确认：
  - `group1 = meteor_01`
  - `group2 = meteor_02`
- 下方限制区域分支可见：
  - `box1 -> transform...`
  - `box2 -> transform...`
  - `box3 -> transform...`
  - `box4 -> transform6`
  - 四条分支一起汇入 `merge3`
- 当前右侧面板仍是 `rbdbulletsolver1` 的 `Output` 页面，可确认：
  - `Visualize Geometries` 已启用
  - `Ground = Wireframe`
  - `Collision Geometry > Show Geometry` 已勾选
  - 底部 `Input Operators` 列表为 3 个 `rbdconstraintproperties1` 加 1 个 `filecache2`
- 视口结果：
  - 左侧桥体在当前帧仍保持整体形态，桥体周围能看到多只透明限制盒。
  - 说明此时重点不是看最终碎裂，而是确认代理碰撞体和约束输入在求解前的组织关系。
这一帧是在确认主模拟缓存和环境缓存已经可以合并查看，便于直接判断碰撞与滚动结果是否自然。

- 当前可见主链：
  - `merge2 -> rbdunpack1 -> rbdconfigure1 -> rbdconstraintproperties1 -> rbdbulletsolver1 -> filecache1`
- 环境缓存链：
  - `object_merge4 -> polyreduce1 -> filecache2`
  - `object_merge4` 下方路径显示为 `/obj/Env/OUT_ENV`
  - `polyreduce1` 标注 `Reduced To: 10.00%`
- 合并节点：
  - `merge4` 的两个输入分别来自 `filecache1` 和 `filecache2`
  - 当前选中节点为 `merge4`
  - 右侧面板 `Input Operators` 明确列出：
    - `rbdbulletsolver1`
    - `filecache2`
- 视口结果：
  - 时间轴大约在第 `131` 帧。
  - 左侧场景中桥体已经完全碎裂成大量碎块，右上仍能看到一颗球体。
  - 环境岩体和桥体碎块一起显示，说明此时是在联合检查碎块与环境之间的碰撞、滚动和堆积效果。
这一帧回到 `rbdconstraintproperties1` 微调断裂点附近的约束参数，并整理出最终渲染输出链。教程语义是继续调冲击阻尼和约束强度，让碎块表现不要像一开始那样一下全散开。

- 当前可见主链：
  - `rbdunpack1 -> rbdconfigure1 -> rbdconstraintproperties1 -> rbdbulletsolver1 -> filecache1 -> delete1 -> OUT_Render`
  - 右侧还能看到 `merge4`，说明主模拟缓存仍可与环境缓存合流预览
- 当前节点：`rbdconstraintproperties1`
- `Constraint Group` 至少包含：
  - `constraint_tag=concrete_fracture1`
  - 第二个 `@constraint_tag=concret...` 条目在画面中被截断，无法完整确认
- 可确认参数：
  - `Constraint Type = Glue`
  - `Constraint Name = Glue`
  - `Degrees of Freedom = Position and Rotation`
  - `Switch Constraint = Enable`
  - `Next Constraint Type = Soft`
  - `Next Constraint Name = Soft`
  - `Next Constraint Degrees of Freedom = Position and Rotation`
  - `Constraint Iterations = 1`
  - `Collisions = Enable`
- `Glue` 参数：
  - `Strength = 2000`
  - `Half Life = 10`
  - `Propagation Rate = 1`
  - `Propagation Iterations = 10`
- `Soft` 参数可确认：
  - `Stiffness = 10`
  - `Damping Ratio = 1`
  - `Override Angular Soft... = Disable`
- 视口结果：
  - 时间轴大约在第 `27` 帧。
  - 左侧桥体当前保持完整，仅显示透明限制盒，说明此时是在模拟较早阶段回头调约束初始响应，而不是观察后段碎裂结果。

### 00:13:59-00:18:55 粒子、生命周期、贴图

- 本段定位：粒子、生命周期、贴图。
- 知识点：竖直本身,还有断裂点处约束的冲击阻尼值,都可以试着调一调。
- 知识点：竖直调高一点,或者反过来调低,试几次,总能找到自己满意的动画效果。
- 知识点：毕竟钢体贴图本身占用资源少,按碎片数量设置就足够了。
- 知识点：这个节点负责在裂纹间隙中散布粒子点,可以这么理解。
- 知识点：虽然叫模拟,实际是将缓存数据保存下来,记录下散布的粒子点,方便后续查看。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`贴图`、`粒子`、`生命周期`。

**关键画面：**

这一帧仍在 `rbdbulletsolver1` 的输出检查阶段，教程强调除了整体速度以外，还可以继续调整断裂点约束的冲击/阻尼相关数值，反复试到满意的动画节奏。

- 当前可见主输出链：
  - `rbdconfigure1 -> rbdconstraintproperties1 -> rbdbulletsolver1 -> filecache1 -> delete1 -> OUT_Render`
- 右侧还保留来自环境缓存的合流支路，说明最终输出前仍可继续联调碰撞环境。
- 当前选中节点：`rbdbulletsolver1`
- 当前面板：`Collision`
- 可确认显示设置：
  - `Visualize Geometries` 已启用
  - `Ground = Wireframe`
  - `Collision Geometry > Show Geometry` 已勾选
  - `Constraint Geometry > False Color Mode = None`
  - `Constraint Geometry > Show Guides` 未勾选
- 底部输入列表可见：
  - 3 个 `rbdconstraintproperties1`
  - 1 个 `filecache2`
- 视口结果：
  - 左侧桥体当前仍为完整状态，周围限制盒清晰可见。
  - 说明此时是在早期帧回看碰撞和约束输入，而不是展示后期碎裂；用于判断约束阻尼和碰撞参数是否需要继续微调。
这一帧已经切到输出网络，开始把破碎缓存导出为 Unreal 可用的 Vertex Animation Textures。教程意图是把前面保存好的模拟结果转成低资源占用的刚体动画贴图。

- 当前网络位置：`/out`
- 当前节点：`vertex_animation_textures1`
- 节点类型：`Labs Vertex Animation Textures`
- `Render All` 页签可确认：
  - `Mode / Target Engine = Rigid-Body Dynamics (Rigid)`
  - 目标引擎为 `Unreal Engine`
  - `Start/End = 1, 250`
  - `Input Geometry = /obj/Destruction/OUT_Render`
- `Settings` 页签中可确认：
  - `Pivot Accuracy = Very High (Best Quality at Low Memory Footprint)`
  - `Rotation Interpolation = Accurate Multi-RPF Slerp with Angular Velocity`
  - `Support Smoothly Interpolated Trajectories` 已勾选
  - `Input Geometry Is Cached to Integer Frames` 已勾选
  - `Texture Format = HDR (EXR/Tiff as RGBA 16/32 in Engine)`
  - 文件格式下拉显示为 `exr`
  - `Include Hidden Debug Plane in Geometry` 已勾选
  - `Target Texture Width = 4096`
- 底部状态信息可确认：
  - `Input Geometry Limit: 131072 Packed Points per Frame`
- 视口结果：
  - 左侧仍显示桥体局部和透明限制盒，说明输入几何来自前面整理好的 `OUT_Render`，当前重点已经从模拟调参转为导出动画贴图。
这一帧展示的是在裂缝或碎裂间隙里散布碎屑粒子点的 `debrissource1`。教程这里开始从刚体破碎缓存中提取可用于后续粒子表现的点数据，并把年龄、寿命、颜色变化一并写入。

- 当前可见主链：
  - `rbdconfigure1 -> rbdconstraintproperties1 -> rbdbulletsolver1 -> filecache1 -> delete1 -> OUT_Render`
- 新增粒子点提取分支：
  - `filecache1 -> debrissource1`
- 当前节点：`debrissource1`
- `General` 区域可确认：
  - `Rest Frame = 1`
  - `Cache Memory (MB) = 5000`
- `Scatter` 区域可确认：
  - `Density Scale = 1`
  - `Max Points = 1000000`
  - `Seed = 0`
- `Release` 区域可确认：
  - `Distance Threshold = 0.1`
  - 右侧模式按钮显示为 `Set Uniform`
- `Attributes` 区域可确认：
  - `Age Attribute = age`
  - `Life Span = 1`
  - `Color Over Normalized Age` 已勾选
  - 下方存在颜色渐变条，用于按归一化年龄改变点颜色
- 其他可见开关：
  - `Remove Unreleased` 未勾选
  - `Remove at Life End` 未勾选
- 视口结果：
  - 左侧桥体整体几何被淡化显示，立柱与裂缝附近出现大量细小白点。
  - 这些点不是刚体碎块本体，而是为后续 Niagara/粒子表现准备的裂缝碎屑散布点。

### 00:18:55-00:23:28 Material、Material Instance、粒子

- 本段定位：Material、Material Instance、粒子。
- 知识点：unrelease是指非裂缝引发的碎片生成,而是指静态产生的碎片点。
- 知识点：大约30帧后就会出现,这些粒子可作为圆,用于后续粒子系统。
- 知识点：粒子内部还会继续生成新点,从而实现持续的碎片生成效果。
- 知识点：这样就能看到,只有在碰撞发生的位置才会出现碎片。
- 知识点：大量点被生成,导致系统变得非常卡顿。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Particle`、`Material`、`粒子`、`系统`、`序列`、`生命周期`、`颜色`、`碰撞`。

**关键画面：**

这一帧继续在 `debrissource1` 上设置碎屑点源，但重点转到“未释放点”和生命周期颜色变化。教程里提到的 `unrelease` 指的是不是由裂缝瞬时触发，而是场景中持续静态存在、后续可继续被粒子系统利用的点。

- 当前可见分支：
  - `rbdbulletsolver1 -> filecache1`
  - `filecache1 -> debrissource1`
  - `filecache1 -> delete1 -> OUT_Render`
- 当前节点：`debrissource1`
- 可确认参数：
  - `Rest Frame = 1`
  - `Cache Memory (MB) = 5000`
  - `Density Scale = 1`
  - `Max Points = 1000000`
  - `Seed = 0`
  - `Distance Threshold = 0.1`
  - `Age Attribute = age`
  - `Life Span = 1`
  - `Color Over Normalized Age` 已勾选
- 颜色控制：
  - 下方 `Color Ramp` 可见 5 个关键色标，从黄绿色过渡到青色、紫色，用于让点在生命周期内按归一化年龄变化颜色。
- 其他可见开关：
  - `Remove Unreleased` 未勾选
  - `Remove at Life End` 未勾选
- 视口结果：
  - 左侧桥体几何被淡化显示，立柱与裂缝附近散布着大量白色点。
  - 这些点表示后续粒子系统可直接使用的碎屑发射位置，而不是已经渲染出来的最终粒子。
这一帧展示把 `debrissource1` 生成的点直接拿来作为后续粒子系统的源数据，并通过 `attribdelete1` 先删掉不需要带进下游的属性。

- 当前可见节点关系：
  - `rbdbulletsolver1 -> filecache1`
  - `filecache1 -> debrissource1 -> attribdelete1`
  - `filecache1 -> delete1 -> OUT_Render`
- 当前节点：`attribdelete1`
- `Attribute Delete` 面板可确认：
  - 处于 `Point Attributes`、`Vertex Attributes`、`Primitive Attributes`、`Detail Attributes` 四类属性的删除设置界面
  - `Update Local Variables` 已勾选
- 节点关系语义：
  - `debrissource1` 输出的是已经散布好的碎屑点
  - `attribdelete1` 的作用是在这些点进入后续粒子流程前，先精简属性，避免把无关属性一并带入系统
- 视口结果：
  - 左侧桥体轮廓完全由密集白点构成，说明这一步已经不再关注原始网格显示，而是直接检查“点源分布是否覆盖到需要出碎屑的位置”。
这一帧已经把前面准备好的点源送进 `popnet`，开始搭建碎屑粒子的动力学网络。当前重点是用 `popwind1` 给点云添加噪声风场扰动，让碎屑持续生成并带一点飘散感。

- 当前网络位置：`/obj/Destruction/popnet`
- 可见 POP 网络结构：
  - `POP Source source_first_input -> popwind1 -> Merge (wire_pops_into_here) -> popsolver -> gravity1 -> output`
  - 旁路还可见一个 `popobject`
- 当前节点：`popwind1`
- `popwind1` 可确认参数：
  - `Activation = 1`
  - `Wind Velocity = (0, 0, 0)`
  - `Wind Speed = 1`
  - `Air Resistance = 0.1`
  - `Ignore Mass` 已勾选
- `Noise` 区域可确认：
  - `Amplitude = 1.85`
  - `Swirl Size = 0.7`
  - `Swirl Scale = (1, 1, 1)`
  - `Pulse Length = 1`
  - `Roughness = 0.5`
  - `Attenuation = 1`
  - `Turbulence = 3`
  - `Offset = (0, 0, 0)`
- 视口结果：
  - 左侧桥体轮廓现在由蓝色粒子点构成，说明点源已经成功进入 POP 模拟，而不是只停留在静态散点阶段。
  - 时间轴大约位于第 `58` 帧，适合观察粒子在持续生成后的分布密度与整体轮廓。

### 00:23:28-00:28:28 粒子、系统、网格

- 本段定位：粒子、系统、网格。
- 知识点：两种缓存设置稍有不同,选中粒子后直接应用即可。
- 知识点：从POPNET中调取功率对象,让粒子进入缓存状态,开始烘焙粒子缓存。
- 知识点：这样差不多了现在在粒子网络里也要加载碰撞网格并应用。
- 知识点：这次把碰撞类型设为表面碰撞器,系统会自动创建节点。
- 知识点：您可以在粒子网络中看到,已自动为设定网格配置了碰撞节点。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`粒子`、`系统`、`碰撞`。

**关键画面：**

这一帧是在 `popnet` 里确认粒子动力学基础结构，准备把点源粒子进入缓存或继续叠加碰撞网格。当前还没有新增碰撞节点，重点仍是源、风、重力和求解器这条主线。

- 当前网络位置：`/obj/Destruction/popnet`
- 可见 POP 网络结构：
  - `POP Source source_first_input -> popwind1 -> Merge wire_pops_into_here -> popsolver -> gravity1 -> output`
  - 旁路节点为 `popobject`
- 当前节点：`popwind1`
- `popwind1` 可确认参数：
  - `Activation = 1`
  - `Wind Velocity = (0, 0, 0)`
  - `Wind Speed = 1`
  - `Air Resistance = 0.1`
  - `Ignore Mass` 已勾选
  - `Amplitude = 1.85`
  - `Swirl Size = 0.7`
  - `Swirl Scale = (1, 1, 1)`
  - `Pulse Length = 1`
  - `Roughness = 0.5`
  - `Attenuation = 1`
  - `Turbulence = 3`
  - `Offset = (0, 0, 0)`
- 视口结果：
  - 左侧桥体轮廓由蓝色粒子点构成，说明前面生成的碎屑点已经作为 POP 粒子进入模拟。
  - 时间轴大约位于第 `58` 帧，当前适合检查粒子总体轮廓、密度和风噪声扰动后的分布。
这一帧是在 POP 粒子网络里接入碰撞网格。教程中提到把碰撞类型设成表面碰撞器后，系统会自动创建对应的静态碰撞节点和求解分支。

- 当前网络位置：`/obj/Destruction/popnet`
- 新增的碰撞相关结构可见：
  - `Static Object Destruction -> merge2 -> staticsolver1`
  - 该静态碰撞分支随后并入下方总合流链
- 粒子主链仍为：
  - `POP Source source_first_input -> popwind1 -> Merge wire_pops_into_here -> popsolver -> gravity1`
- 最终合流结构：
  - `staticsolver1` 与粒子求解链一起汇入 `merge1 -> output`
- 当前节点：`Static Object Destruction`
- 右侧面板可确认：
  - `Creation Frame = 1`
  - `Object Name = $OS`
  - `OBJ Path = /obj/Destruction`
  - `Use Deforming Geometry` 已勾选
  - `Use Object Transform` 已勾选
  - `Display Geometry` 已勾选
- `Collisions` 页签可确认：
  - `Bounce = 0.5`
  - `Bounce Forward = 1`
  - `Friction = 1`
  - `Dynamic Friction Scale = 1`
  - `Temperature = 0`
- 视口结果：
  - 左侧场景中能看到碎裂后的大块几何体，说明 POP 网络里已经开始加载真实碰撞几何，而不是只看点云轮廓。
这一帧展示粒子缓存烘焙后的合流查看方式：把 POP 网络产出的粒子缓存与前面刚体/环境结果再次合并，直接检查碎屑点是否只在碰撞区域持续生成。

- 当前可见主链：
  - `filecache1 -> delete1 -> OUT_Render`
  - `debrissource1 -> attribdelete1 -> popnet`
  - `dopimportfield1 -> filecache3`
- 合流节点关系：
  - `merge4` 保留前面已有的合流结果
  - `merge5` 再把 `filecache3` 与 `merge4` 合并
- 当前节点：`merge5`
- `merge5` 右侧 `Input Operators` 可确认：
  - `filecache3`
  - `merge4`
- 视口结果：
  - 左侧桥体轮廓由大量白色粒子点构成，而且点主要集中在撞击与裂缝区域，不再是全桥均匀散布。
  - 时间轴大约位于第 `195` 帧，适合检查长时间播放后粒子缓存的持续生成和堆积情况。
- 节点语义：
  - `filecache3` 对应的是 POP/DOP 粒子缓存输出。
  - `merge5` 用来把粒子缓存与之前的几何/环境结果统一合流，方便在一个视图中同时检查网格与粒子效果。

### 00:28:28-00:33:24 粒子、碰撞、速度

- 本段定位：粒子、碰撞、速度。
- 知识点：这次把颜色和透明通道全部清空,这样拿过去也完全没问题。
- 知识点：可以如果希望增加粒子数量,可复制后测试,确认是否需要进一步提升。
- 知识点：可以现在看这里确实不太好判断,建议实时导入并应用弱粒子效果后再做决定。
- 知识点：现在来创建烟雾粒子将缓存设为第二个, 设置参数方面其实碰撞可以不用开启。
- 知识点：粒子数量也可适当减少重力值, 也不必太强,避免过重的物理感。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`粒子`、`速度`、`颜色`、`碰撞`、`烟雾`。

**关键画面：**

这一帧是在统一视图里同时检查刚体缓存、环境缓存和粒子缓存的叠加结果，用来判断粒子数量是否足够，以及是否需要先导入到实时引擎里配合弱粒子材质再做最终判断。

- 当前可见缓存链：
  - `filecache1 -> delete1 -> OUT_Render`
  - `debrissource1 -> attribdelete1 -> popnet`
  - `dopimportfield1 -> filecache3`
- 当前合流节点：`merge5`
- `merge5` 的 `Input Operators` 可确认：
  - `filecache3`
  - `filecache1`
  - `filecache2`
- 合流语义：
  - `filecache1`：主刚体/破碎缓存
  - `filecache2`：环境或碰撞网格缓存
  - `filecache3`：POP 粒子缓存
- 视口结果：
  - 左侧同时显示岩体/桥体碎块与大量白色粒子点。
  - 粒子主要集中在碎裂和碰撞区域，并非均匀铺满全场景。
  - 时间轴大约位于第 `195` 帧，适合检查长时间播放后粒子密度是否过多、是否需要继续减量或弱化。
这一帧回到 `popnet` 内微调粒子的整体下坠感。教程语义是把重力适当减弱，避免烟雾/碎屑点呈现过重的物理下坠效果。

- 当前网络位置：`/obj/Destruction/popnet`
- 当前可见 POP 结构：
  - `POP Source source_first_input -> popwind1 -> Merge wire_pops_into_here -> popsolver -> gravity1 -> merge1 -> output`
  - 左侧仍保留碰撞支路：`Static Object Destruction -> merge2 -> staticsolver1`
  - 旁路节点为 `popobject`
- 当前节点：`gravity1`
- `Gravity Force` 面板可确认：
  - `Force` 的 `X = 0`
  - `Force` 的 `Z = 0`
  - `Force` 的 `Y` 分量正在作为主要调节项被修改
  - `Sampling Mode = Default`
  - `Default Operation = Set Initial`
  - `Data Sharing = Do Not Share Data`
  - `Activation = 1`
  - `Group = *`
  - `Data Name = Forces/Gravity`
  - `Unique Data Name` 已勾选
  - `Input Operators` 列表中为 `popsolver`
- 视口结果：
  - 左侧当前几乎不显示粒子或几何，说明此时是在节点级别优先调力学参数，而不是查看最终叠加显示。
这一帧是在粒子缓存调完后，准备输出第二份碎屑缓存版本。教程意图是保留一个适合烟雾或弱粒子效果的独立缓存版本，便于后续在 Niagara 里直接调用。

- 当前可见缓存与导出链：
  - `rbdbulletsolver1 -> filecache1 -> delete1 -> OUT_Render`
  - `debrissource1 -> attribdelete1 -> popnet`
  - `dopimportfield1 -> filecache3`
  - `merge5` 继续承担总合流查看
- 当前节点：`filecache3`
- `filecache3` 参数面板可确认：
  - `Load from Disk` 已勾选
  - `File Path = Constructed`
  - `Time Dependent Cache` 已勾选
  - `Base Name = Ex_05.filecache3`
  - `Base Folder = $HIP/geo`
  - `Version = 2`
  - `Evaluate As = Frame Range`
  - `Simulation` 已勾选
  - `Start/End/Inc = 1, 250, 1`
  - `Substeps = 1`
  - `Load = All Geometry`
- 当前图中还能看到：
  - `filecache3` 下方接着两个 `Labs Niagara ROP` 风格节点，其中一个标签可见为 `Debris_02`
- 视口结果：
  - 左侧只显示白色粒子点组成的桥体轮廓，没有叠加实心碎块，说明这里在单独检查粒子缓存版本本身。
  - 时间轴大约位于第 `197` 帧，适合确认长时间播放后的粒子点密度与分布是否可接受。

### 00:33:24-00:35:52 粒子、碰撞、透明度

- 本段定位：粒子、碰撞、透明度。
- 知识点：加了碰撞后时间会稍长,缓存又重新生成了,但感觉还是有点不够。
- 知识点：粒子数量稍作增加后,定稿如果觉得太多,后期可通过调低透明度来优化。
- 知识点：即使看起来有点聚集,也先当试力看看,之后再逐项调整,这样更合适。
- 知识点：这部分重炫一下就行。
- 知识点：把第二阶段的那拉缓存也渲染完,这期就收工了。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`粒子`、`透明度`、`碰撞`。

**关键画面：**

这一帧是在粒子基础对象层继续检查点量和显示效果。教程语义是先把点数稍微增加做测试，如果最终觉得太多，再通过透明度或后续参数回调。

- 当前网络位置：`/obj/Destruction/popnet`
- 当前可见 POP 结构：
  - `POP Source source_first_input -> popwind1 -> Merge wire_pops_into_here -> popsolver -> gravity1 -> merge1 -> output`
  - 左侧仍保留 `Static Object Destruction -> merge2 -> staticsolver1`
- 当前节点：`popobject`
- `POP Object` 面板可确认：
  - `Creation Frame = 1`
  - `Object Name = $OS`
  - `Solve on Creation Frame` 已勾选
  - `Use Object Transform` 已勾选
- `Guides` 页签可确认：
  - `Instance Guides` 已勾选
  - 引导颜色设置为蓝色系
- 视口结果：
  - 左侧显示的是白色粒子点云，桥体轮廓已经被明显简化成粒子分布结果。
  - 粒子数量足以勾出主要破碎区域，但仍保留较多空隙，符合“先增加一点再观察是否够用”的调试阶段特征。
这一帧是在 POP 网络中启用静态碰撞后的预览。教程语义是先接受当前略显聚集的效果做一次试算，确认碰撞方向没问题，再回头逐项调透明度、点量或其它参数。

- 当前网络位置：`/obj/Destruction/popnet`
- 当前可见 POP 结构：
  - `Static Object Destruction -> merge2 -> staticsolver1`
  - `popobject` 与 `POP Source source_first_input -> popwind1 -> popsolver -> gravity1`
  - 最终一起汇入 `merge1 -> output`
- 当前节点：`staticsolver1`
- `Static Solver` 面板可确认：
  - `Make Objects Mutual Affectors` 已勾选
  - `Group = *`
  - `Input Operators` 中为 `merge2`
- 视口结果：
  - 左侧同时显示岩体/静态几何与大量白色粒子点。
  - 粒子已经不再只是空中分布，而是沿着场景几何表面和缝隙区域附着、堆叠，说明表面碰撞器已经开始参与 POP 模拟。
这一帧已经进入 Niagara 导出阶段，准备把第二份碎屑缓存版本渲染为可供后续系统直接读取的 JSON 数据。教程语义是把第二阶段的碎屑缓存也一并输出，本期到这里收尾。

- 当前可见导出链：
  - `dopimportfield1 -> filecache3`
  - `filecache3` 下游接两个 `Labs Niagara ROP` 节点：
    - `Debris_01`
    - `Debris_02`
- 当前节点：`Debris_02`
- 节点类型：`Labs Niagara ROP`
- `General` 页签可确认：
  - `Frame Range / Time... = Render Frame Range`
  - `Start/End/Inc = 1, 250, 1`
  - `Create Intermediate Directories` 已勾选
  - `Output Path = $HIP/$OS.hbjson`
- `Attributes` 区域可确认：
  - `Number of Renames = 0`
  - `Overwrite Existing Attributes` 未勾选
  - `Keep Attributes = P id time v life type age`
  - `Cast Attributes = 2`
  - `Clamp Attributes That Are Outside Type Range` 已勾选
- 运行状态可确认：
  - 画面中央弹出 `Interrupt` 窗口
  - 当前显示 `ROP frame 190 (190 of 250)`
  - 状态为 `Evaluating python`
- 视口结果：
  - 左侧当前没有叠加显示粒子或几何，说明此时重点不再是预览，而是等待第二份碎屑缓存导出完成。

## 补充视觉证据

### S02 00:07:57

这张补充图把环境碰撞网格的缓存链展示得更完整，作用是单独说明给粒子和后续系统使用的环境/碰撞代理网格是如何从原始场景对象中提取、减面并缓存下来的。

- 当前可见主模拟链：
  - `merge2 -> rbdunpack1 -> rbdconfigure1 -> rbdconstraintproperties1 -> rbdbulletsolver1 -> filecache1`
- 右侧环境碰撞缓存链：
  - `object_merge4 -> polyreduce1 -> filecache2`
- 可确认节点标注：
  - `object_merge4` 下方路径显示为 `/obj/Env/OUT_ENV`
  - `polyreduce1` 标注 `Reduced To: 10.00%`
- 当前节点：`filecache2`
- `filecache2` 参数面板可确认：
  - `File Path = Constructed`
  - `Time Dependent Cache` 已勾选
  - `Base Name = $HIPNAME.$OS`
  - `Base Folder = $HIP/geo`
  - `Version = 1`
  - `Evaluate As = Frame Range`
  - `Simulation` 已勾选
  - `Start/End/Inc = 1, 250, 1`
  - `Substeps = 1`
  - `Load = All Geometry`
- 视口结果：
  - 左侧显示的是环境岩体的三角面线框代理网格，没有桥体碎屑点或粒子叠加。
  - 说明这张补充图关注的是“环境碰撞网格如何准备给后续系统使用”，而不是主破碎或粒子最终效果。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。

