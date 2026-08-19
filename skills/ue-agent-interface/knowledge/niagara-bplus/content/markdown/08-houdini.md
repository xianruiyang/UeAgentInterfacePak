# 08.Houdini破坏模拟制作

# 08.Houdini破坏模拟制作

## 关键术语

- `Material`、`UV`、`Houdini`、`VAT`、`RBD`、`材质`、`粒子`、`渲染器`、`网格`、`碰撞`、`Niagara`、`Normalized Age`、`Renderer`、`贴图`、`系统`、`蓝图`、`Niagara System`、`Emitter`

## 分段知识

### 00:00:06-00:04:59 Houdini、材质、网格

- 本段定位：Houdini、材质、网格。
- 知识点：我们上节课导出的资源现在要用上了 现在导入这些资源重点是那个十项形状的物体 导入那个项模型后,就用来动手做一个真实的破碎模拟 点开这里的Film。
- 知识点：FBX导入时,名字可能有点奇怪 不过基本都默认勾选了 我们只用到需要的部分,这本来就是静态网格没有骨骼也不用担心 灯光不用管材质也基本不用考虑。
- 知识点：勾着也无所谓,直接导入就行 这样就搞定了,就能导入FBX模型了 现在就设置好了,里面也有材质。
- 知识点：来看看颜色是怎么进来的,原来是这样 原来是这样,这个黑色区域大概是因为 大概是碰撞盒,导致外层被包裹导出后,就这样显示出来了 这其实是承载真实网格的主体结构了。
- 知识点：Merge的节点 这个节点能导入位于不同空间或网络中的几何体或对象 当前正在使用的,导入到这里,就相当于用来导入的节点,应该可以。
- 知识点：用当前,以这个物体本身带的数据为准来用 保持原样的话,原来的网格就按它原本的位置直接进来了 这么一开就能看到重叠了,挺明显的 不过现在Unreal用的是SIM。
- 知识点：Houdini用的是M尺度,差异非常明显 这一点很明显,先看一下这个网格 导入情况还算正常,位置也可能是按世界坐标方式导入的 中心点,基本对得上。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Houdini`、`材质`、`颜色`、`碰撞`。

**关键画面：**

这一步在 Houdini 中开启新的制作场景，正式开始使用上一课已经导出的模型资源。画面中央的对象网络还是空的，显示 `Empty Network / Press Tab to Add Nodes`，左侧视口也只有默认网格地面，说明此时还没有把任何几何节点接入，只是在准备搭建后续破坏模拟所需的基础网络。

结合字幕“上节课导出的资源现在派上用场了”，这张图表达的是流程切换点：从上一节的 Unreal 资源准备与导出，转入当前这节的 Houdini 破坏模拟制作。复现时可先进入 `/obj` 层级，保持一个空对象网络，随后再逐步导入上节导出的 FBX 或相关几何资源。
这一步完成了上节导出模型的初次导入。左侧视口已经能看到雕像网格立在默认地面上；中间的对象网络里同时存在一个名为 `Stature_01_fbx` 的 `Subnet` 节点，以及一个普通 `geo1` 节点，说明当前导入的 FBX 已经被 Houdini 作为独立对象层节点载入场景。

右侧参数面板显示当前选中的是 `Geometry geo1` 的 `Transform` 页签，所有平移、旋转和缩放都还保持默认值。结合本段正文关于“名字可能有点奇怪、默认勾选即可导入”的说明，这张图对应的操作是：把从 Unreal 导出的雕像 FBX 直接导入 Houdini，对象层确认能正常显示网格即可，暂时不需要先做复杂的材质或灯光处理。
这一步进入 `geo1` 的 SOP 网络，对导入后的雕像网格做最初的几何整理。图中当前可确认的节点链为：

- `object_merge1`
- `convert1`
- `polyfill1`
- `normal1`

连线关系为：

- `object_merge1 -> convert1`
- `convert1 -> polyfill1`
- `polyfill1 -> normal1`

其中 `object_merge1` 的来源路径可读为 `/obj/Stature_01_fbx/statue_scan_free`，说明这里不是直接在原始 FBX 子网里破坏，而是通过 `Object Merge` 把导入网格引用到当前工作网络。右侧参数面板当前停在 `normal1`，能确认它启用了 `Compute Normals`，`Add Normals to` 为 `Vertices`，`Cusp Angle` 为 `60`。因此本图的含义是：先把导入网格 merge 进专用 SOP 流程，再做格式转换、孔洞处理和法线重建，为后续 RBD 破坏模拟建立干净的基础几何。

### 00:04:59-00:09:41 Material、UV、RBD

- 本段定位：Material、UV、RBD。
- 知识点：现在看到它对齐到中心了吧 移完中心后,对应数值会自动填在这里 移完中心再做模拟计算,才更稳定 因为这样算起来更稳定,所以和DinDin常这么处理。
- 知识点：变换也弄好了,再点一下中键看看这个几何体都包含哪些信息 顶点上都有各种数据 这个UV2属性现在用不着了 就当它是不用的就行,反正UV已经展开了。
- 知识点：留第一个UV就行,要是还有叫UV2的第二组UV后面做顶点贴图烘焙时容易出错 所以一定要把UV2重命名为MyUV2 开始烘焙了,因为没法烘焙所以。
- 知识点：就按这样设置吧 加个叫Clean的节点能帮你把网格适当整理一下 差不多就是这个意思 按这个距离范围把多余的点和顶点合并成一点的功能也有。
- 知识点：相当于,可以这么看 就差不多这样 先说下现在用匹配尺寸放得太靠中间了 所以我们得调一下歪轴的一直 以色为让其识别下方为地面 现在破碎的准备工作差不多就续了。
- 知识点：准备以基本就续,差不多就续了 进行破碎前需从Unreal导入的物体中保留关键部分 有两个要点必须保留 UV必须保留 还有一个是材质槽破碎后再设置。
- 知识点：只要保留这两项,就能复用Unreal中的材质和UV Rampant破碎后的动画直接继承原有的贴图效果 现在放入 接下来破碎的准备工作基本就续了。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Material`、`材质`、`贴图`、`颜色`。

**关键画面：**

这一步在前面预处理链的末端新增了 `transform1`，用来把雕像网格的中心和后续模拟参考位置调整到更稳定的状态。当前节点链已经扩展为：

- `object_merge1 -> convert1 -> polyfill1 -> normal1 -> transform1`

右侧参数面板当前停在 `transform1`，可确认它的 `Uniform Scale` 仍为 `1`，平移/旋转/缩放分量表格可直接用于手动输入中心校正值；同时面板中还能看到 `Move Centroid to Origin` 和 `Move Pivot to Centroid` 这类按钮，说明作者此时正在围绕“把对象中心移到合适位置”进行调整。结合正文，本步的目标是在正式做 RBD 计算前先把模型中心对齐好，因为这样更利于后续模拟稳定。
这一步在中心调整之后继续补充导入网格的清理链。当前可见的节点链已经扩展为：

- `object_merge1`
- `convert1`
- `polyfill1`
- `normal1`
- `transform1`
- `attribdelete1`
- `clean1`
- `matchsize1`

连线关系为顺序串联：`object_merge1 -> convert1 -> polyfill1 -> normal1 -> transform1 -> attribdelete1 -> clean1 -> matchsize1`。

右侧参数面板当前停在 `matchsize1`。可确认其 `Target Position` 为 `(0, 0, 0)`，`Target Size` 为 `(1, 1, 1)`，并启用了 `Translate` 匹配；`Justify X / Y / Z` 均是把当前几何按中心方式对齐到目标基准。结合正文里“对齐到中心”“准备破碎前需保留关键部分”“加个 Clean 节点整理网格”的说明，这张图对应的操作是：先删除暂时不用的属性，再用 `Clean` 清理点/顶点问题，最后通过 `Match Size` 把模型规范到统一的中心和尺寸参考，方便后续继续设置地面方向与破碎逻辑。
这一步进入正式的破碎准备网络。当前可见的下游结构为：

- `matchsize1` 之后分出两路
- 一路直接接入 `rbdmaterialfracture1`
- 另一路接入 `blast1`，再进入 `scatter1`
- `scatter1` 的结果作为辅助输入送入 `rbdmaterialfracture1`

从连线和节点命名可以确认，这里是在先保留主体几何，再通过一部分筛选与散点分布来控制后续碎裂区域或碎片分布。

右侧参数面板当前停在 `scatter1`，能确认的关键设置包括：

- `Generate` 为 `By Density`
- `Force Total Count` 已启用，数量为 `100`
- `Max Point Limit` 已启用，值为 `1000000`
- `Randomize Point Order` 已启用
- `Relax Iterations` 为 `10`
- `Scale Radii By` 为 `1`
- `Max Relax Radius` 为 `10`

左侧视口当前只显示一小团离散黑点，说明作者此时是在检查散点分布，而不是直接显示完整雕像网格。结合正文关于“保留 UV 和材质槽”“开始破碎前的准备工作基本完成”的说明，这张图的含义是：在不丢失原始材质与 UV 前提下，先为 `RBD Material Fracture` 建立用于控制碎裂密度和区域的散点输入，再进入真正的雕像破坏模拟阶段。

### 00:09:42-00:14:42 UV、速度、噪声

- 本段定位：UV、速度、噪声。
- 知识点：设为冲击点并定义为冲击区域 完成设置相当于这样设置,大致如此 我们以冲击点为中心设定速度分布。
- 知识点：速度分布会让这一侧的碎片飞得更远,这样设置比较合理 所以不妨从这里开始模拟爆炸引发崩裂的效果 让十项碎裂的过程更有冲击感 这样就完成了设置,第一个直接用平行噪波替代。
- 知识点：第二个则用斯佩尔,体积和卷积噪波,用来做效果确认 第一个则获取音符点数据 这样一来这里就会碎成大量细小碎片,实现碎片的精准分布 能看到效果了。
- 知识点：我再把数量调高一点,调到大约50个这样设置 第二步是进入主体积调整,第二组噪声参数 简单确认下现在也还行 虽然效果尚可,但为了加快计算速度,可以适当减化噪声。
- 知识点：尤其是上半部分,调高噪声强度,能让碎片分得更细 上半部分就会碎得更细更多了 上半部分碎片块头大些,上面这部分就更 碎得更细一点,可能会更自然些,可能会更自然些。
- 知识点：这类碎片可以适当调节参数试试 不妨试着调出自己喜欢的效果,另外针对Edge Detail 可以这样查看,然后加上边缘细节 可以清楚看到边缘细节已成功加入。
- 知识点：从视图看结面处还带有一点点杂质感 比起下半身,上半身中心位置的碎片更密集一些 碎得适当细一点,看起来更自然,毕竟这部分的碎片就该这样弹出来。
- 核对对象：`速度`、`噪声`。

**关键画面：**

这一步开始为雕像破碎建立带方向性的碎裂控制区域。左侧视口中，雕像已经被分成多块彩色区域，说明当前正在检查不同分区或不同碎裂簇的空间分布；画面字幕同时指出“以冲击点为中心设定速度分布”，因此这里的彩色分区可理解为后续冲击扩散和碎片速度分配的基础。

当前可见节点关系为：

- `matchsize1` 分出两路
- 一路直接进入 `rbdmaterialfracture1`
- 另一路进入 `blast1 -> scatter1`
- `scatter1` 的输出作为辅助输入连到 `rbdmaterialfracture1`

右侧参数面板当前停在 `blast1`，能确认：

- `Group Type` 为 `Primitives`
- `Delete Non Selected` 已启用
- `Fill Simple Holes` 已启用
- `Delete Unused Groups` 已启用

因此本图对应的操作是：先通过 `blast1` 从雕像表面筛出一组特定 primitive 区域，再把这组区域送去生成散点和后续破碎控制输入。这样可以让冲击点附近的碎裂与速度分布更集中、更符合“从命中位置向外爆裂”的效果。
这一步开始直接检查 `rbdmaterialfracture1` 的碎裂结果，并在下游接入 `explodedview1` 便于观察每个碎块的切分质量。当前可见节点关系为：

- `matchsize1 -> rbdmaterialfracture1`
- `matchsize1 -> blast1 -> scatter1`
- `scatter1 -> rbdmaterialfracture1`
- `rbdmaterialfracture1 -> explodedview1`

左侧视口中，雕像已经被切成大量不规则彩色碎块，说明 `RBD Material Fracture` 已成功按 piece 划分。右侧参数面板当前停在 `explodedview1`，可确认：

- `Piece Attribute` 为 `name`
- `Piece Elements` 为 `Primitive`
- `Centroid Method` 为 `Center of Mass`
- `Uniform Scale` 为 `1`

这张图的作用是对碎裂后的分块密度与空间分布做第一次整体检查。结合正文关于“上半部分碎得更细、中心区域更密集”的说明，可据此判断当前分块已经开始具备由冲击点驱动的密度变化，接下来可以继续围绕噪声和细节分布微调破碎效果。
这一步在破碎结果下游新增了 `uvunwrap1`，开始为碎裂后暴露出来的内部切面准备单独的 UV。当前可见节点关系为：

- `rbdmaterialfracture1 -> explodedview1`
- `rbdmaterialfracture1 -> uvunwrap1`

右侧参数面板当前停在 `uvunwrap1`，能确认：

- `UV Attribute` 为 `uv`
- `Group` 为 `inside`
- `Layout` 为 `Square`
- `Scale` 为 `Uniform`
- `Spacing` 为 `2`
- `Rotate Order` 为 `Rx Ry Rz`

其中 `Group = inside` 很关键，说明这里只对破碎后新生成的内部面做 UV 展开，而不是重做整个雕像的原始 UV。结合正文中“加上边缘细节”“让原本连在一起的部分适当松开一些”的说明，这张图的目的就是为后续内部材质、切面细节和边缘噪声表现准备独立的内部 UV。

### 00:14:42-00:19:38 材质、粒子、速度

- 本段定位：材质、粒子、速度。
- 知识点：接下来创建一个材质节点用来设定材质 之前在当前层级设置材质 现在在几何阶段也能在节点网络层面直接指定 因此可以在节点网络中直接指定材质。
- 知识点：接下来在材质面板里新建两个Principal的材质 分别设置,可在其中查看设置效果 一个设为In,一个设为Out 这样调整后确认一下效果。
- 知识点：In这边来试试加点红色 Out这边也一样可以添加标签页来设置参数 所以可以这么操作 这里外部的情况就在材质里选外。
- 知识点：选好外后内部就选内 内部就加个内材质设置也完成了 接着用破碎模块把粒子也打好了 这样就能看到内部是红色,外面是绿色 碎片地形一变这个属性就会短暂变成碎块状飞走。
- 知识点：能看到它变的样子 能看到不过材质槽主要是为了开孔用的 视觉上不用太在意 这样破碎就弄好了,接下来得调一下速度场。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`粒子`、`速度`。

**关键画面：**

这一步开始在破碎后的几何流程里直接指定材质。当前可见节点关系已经扩展为：

- `rbdmaterialfracture1 -> uvunwrap1 -> material1`
- 同时保留 `rbdmaterialfracture1 -> explodedview1`

右侧参数面板当前停在 `material1`，能确认：

- `Attributes` 使用的是 `Primitive Attributes`
- `Number of Materials` 为 `1`

左侧视口切换到了 UV 视图，能看到大量内部展开后的线框与 UV 岛，说明作者此时是在边检查内部 UV 的分布，边准备给这些几何面挂上材质。结合正文“在几何阶段也能在节点网络层面直接指定材质”的说明，本图的操作重点是：不要只在对象层设置材质，而是把材质指定节点直接放在破碎后的 SOP 链里，便于后面分别控制 inside / outside 的材质表现。
这一步继续细化破碎后 inside / outside 的材质分配，并准备在下游加入 `assemble1`。当前节点关系可见为：

- `rbdmaterialfracture1 -> uvunwrap1 -> material1`
- `explodedview1` 仍保留在旁路用于检查结果
- `material1` 下游准备继续接 `assemble1`

右侧参数面板当前停在 `material1`，能够明确读到：

- `Number of Materials` 为 `2`
- 当前显示的第 1 组材质规则中，`Group` 为 `inside`
- 该组 `Material` 指向 `/mat/In`

这说明作者已经开始把破碎后内部切面单独指定为内部材质 `In`。结合正文“内部选内、外部选外”的说明，本图对应的操作就是：在 `material1` 里至少建立两条材质规则，其中一条专门针对 `inside` 分组，把内部切面绑定到 `/mat/In`，后续再为外表面指定另一套外部材质，从而形成破碎后“里面和外面颜色不同”的效果。
这一步完成了破碎几何的材质指定，并开始搭建后续速度场/粒子控制用的辅助点阵。当前可见节点关系已经扩展为：

- `rbdmaterialfracture1 -> uvunwrap1 -> material1 -> assemble1`
- `material1` 旁路仍保留 `explodedview1` 结果用于检查
- `assemble1 -> transform2 -> copytopoints1`
- 上游 `blast1` 还额外分出一路到 `add1`

右侧参数面板当前停在 `add1`，能确认：

- 位于 `Points` 选项卡
- `Delete Geometry But Keep the Points` 已启用
- `Number of Points` 为 `1`
- 该点的位置表达式使用了 `$CEX`、`$CEY`、`$CEZ`

左侧视口里可以看到规则排列的黑色点阵，而不是完整雕像，说明作者已经在用辅助点或采样点准备下一个“速度分布/复制控制体”的阶段。结合正文“破碎就弄好了，接下来得调一下速度场”的说明，这张图对应的操作是：在完成 inside / outside 材质处理后，用 `assemble1` 把碎块重新组织，再从选择区域生成一个中心参考点，并通过后续 `transform` 与 `copy to points` 链搭建速度控制的辅助结构。

### 00:19:38-00:24:23 速度

- 本段定位：速度。
- 知识点：我们来看看总共有多少个点,大概有532个 选中第532个点,再切换到点模式查看 这里显示有532个点 切换到点模式后,由于从0开始编号次后一个就是531。
- 知识点：接下来,可观察到这里已经被删除了 这样除了中间那个中心点,其他所有点都已删除 在这里这样连接一下 在这个位置我们把大小调得非常小 放进去一个缩小的十项。
- 知识点：是第二个 将该位置输入第N个参数接着进入外部空间生成速度 需使用第二个点因此建立Input Point Attribute 此处从Vector3的Second。
- 知识点：Input提取P值并使用 将第一个点位与第二个点位输入Dists节点 接下来设置场域范围 当前星系参数值。
- 知识点：按Y轴方向查看 点击属性后可选择按最高值或最低值排序 按降序或升序排列 有升序与降序选项 当前最大值约为5.8将影响范围限制在3以内。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`速度`。

**关键画面：**

这一步正式进入速度控制网络的搭建。当前可见节点关系已经在上一段材质与破碎流程基础上继续扩展为：

- `blast1 -> add1 -> blast2`
- `assemble1 -> transform2 -> copytopoints1`
- 破碎几何主链仍保留 `rbdmaterialfracture1 -> uvunwrap1 -> material1 -> assemble1`

左侧视口中显示的是一个由大量黑色点组成的竖向点阵，说明作者当前主要在操作辅助点而不是直接观察碎块网格。右侧参数面板当前停在 `blast2`，虽然组内容未填写，但可确认它用于继续从 `add1` 生成的点/几何里筛选需要保留或激活的部分。

结合本段正文关于“方向是 0，给个 -5 左右的力试试”“先新建标记点”“中间部分受力最均衡”的说明，这张图对应的操作可理解为：先用 `add1` 建立速度场的中心或参考点，再用 `blast2` 对辅助结构做一次筛选，准备把这套点阵用于后续速度方向、受力范围和激活区域的控制。
这一步进入 `pointvop1`，开始用 VOP 方式根据参考点到碎片的距离生成速度影响权重。图中当前可确认的 VOP 结构为：

- `geometryvopglobal1`
- `importpoint1`
- `distance1`
- `fit1`

连线关系为：

- `geometryvopglobal1.P -> distance1.p1`
- `importpoint1.result -> distance1.p2`
- `distance1.dist -> fit1.value`

右侧参数面板当前停在 `fit1`，能确认：

- `Source Min = 0`
- `Source Max = 1`
- `Destination Min = 0`
- `Destination Max = 1`

结合字幕和正文“当前最大值约为 5.8，将影响范围限制在 3 以内”“沿样条线让破裂方向略微向上一点”的说明，这张图的作用是先把点到冲击中心的距离计算出来，再用 `Fit Range` 把距离值重新映射成 0 到 1 的控制权重。后续无论是给速度、曲线偏移还是噪声强弱，这个权重都可以作为统一的衰减基础。
这一步继续完善 `pointvop1` 中的速度权重生成逻辑，当前可确认的 VOP 结构包含：

节点定义集：

- `distance1`
- `fit1`
- `aanoise1`
- `parm1`
- `add1`
- `parm2`
- `ramp1`
- `multiply1`
- `geometryvopoutput1`

连线集：

- `distance1.dist -> fit1.val`
- `fit1.shift -> ramp1.input`
- `parm1.bound_dirv -> add1.input1`
- `aanoise1.noise -> add1.input2`
- `add1.sum -> multiply1.input1`
- `parm2.bound_str -> multiply1.input2`
- `ramp1.ramp -> multiply1.input3`
- `multiply1.product -> geometryvopoutput1` 的输出链

设置/参数：

- 右侧当前显示的是参数节点 `parm2`
- 该参数 `Name` 为 `str`
- `Label` 为 `Str`
- `Type` 为 `Float (float)`
- 默认值为 `1`
- 范围为 `0..1`

输出/预览：

- 左下方表格能看到每个 piece 点的数值数据，说明当前网络正在按 piece 级别计算控制值
- 左侧视口仍是雕像整体预览，用于边调 VOP 参数边观察结果

这张图的含义是：先用 `distance1 + fit1 + ramp1` 建立距离衰减，再叠加 `aanoise1` 噪声，并用强度参数 `str` 统一缩放，最终把结果作为速度或后续驱动力的控制值输出。这样可以同时得到“离冲击中心越近影响越大”和“碎片运动带一点自然抖动”的效果。

### 00:24:23-00:29:12 VAT、速度、曲线

- 本段定位：VAT、速度、曲线。
- 知识点：看看速度是怎么设置出来的 新建标记点全设为相量轨迹数值 显示异常可能是0导致的 延长试图看看 现在方向是0 0给个-5左右的力试试 施加力后中间部分受力最均衡。
- 知识点：能明显看出来就清楚了 调一下就能画出平滑曲线 沿着这条样条线让破裂方向 略微往上一点 视觉上会更自然针对噪波部分 适当提高噪波强度着 制造出微微弹跳的视觉效果。
- 知识点：至于噪波参数就按这种方式调整 不断调整偏移值实时查看效果 这样调整后效果就差不多了 连出速度参数也都已设置好。
- 知识点：新建一个组 用来放置将要激活的对象这个组 就叫Activate组 换成边界框来用 不如用球体来扩大范围 适当放大点这样被选中的部分 就相当于已经激活了。
- 知识点：属于这组的碎片以躯干为主 以躯干部分为主 我们来设置一下按这个效果调整即可 用Attribute,Create创建属性名称设为Active。
- 核对对象：`速度`、`曲线`。

**关键画面：**

这一步开始直接可视化速度向量，并同时调节 `pointvop1` 暴露出来的控制参数。画面中央弹出的 `Edit Visualizer` 窗口用于检查属性 `v`：

- `Name` 为 `v`
- `Label` 为 `v`
- `Type` 为 `Marker`
- `Style` 为 `Vector Trail`
- `Visibility` 为 `Always Visible`
- `Length Scale` 为 `1`
- `Unit Length` 为 `1`

右侧参数面板当前停在 `pointvop1` 暴露出的 ramp/控制参数区域，可明确读到：

- `Interpolation` 为 `Linear`
- `Direction` 当前为 `(0, 0, 0)`
- `Frequency` 为 `(1, 1, 1)`
- `Offset` 为 `(0, 0, 0)`
- `Amplitude` 数值约为 `1`
- `Roughness` 为 `0.5`
- `Str` 为 `1`

左下角表格中还能看到各个 piece 当前的 `v[x]`、`v[y]` 等列基本为 `0`。这与字幕“显示异常可能是 0 导致的”一致，说明此时作者是在先打开速度向量可视化，再确认默认方向和强度参数是否让速度属性有效输出；如果全是 0，就需要继续给方向或强度一个非零值。
这一步开始建立后续需要被激活的碎片分组。当前可见节点关系为：

- `assemble1 -> transform2 -> copytopoints1 -> pointvop1 -> group1`
- `assemble1` 还额外直接连到 `pointvop1`

左侧视口中，雕像周围已经显示出大束黄色向量轨迹，说明速度向量 `v` 的可视化已经生效；雕像底部同时出现一个蓝色边界框，表示作者正在用包围区域筛选一部分碎片。

右侧参数面板当前停在 `group1`，能确认：

- `Group Name` 为 `activate`
- `Group Type` 为 `Primitives`
- `Keep in Bounding Regions` 已启用
- `Bounding Type` 为 `Bounding Box`
- `Size` 为 `(1, 1, 1)`
- `Center` 为 `(0, 0, 0)`

这张图对应的操作是：在速度已经建立之后，再用 `Group Create` 结合包围盒挑出将要被激活的碎片集合，并把该组命名为 `activate`。结合正文“属于这组的碎片以躯干为主”的说明，这个包围区域主要用于选中雕像躯干附近的破碎块，为后续给 `Active` 属性赋值做准备。
这一步把激活组真正接入 Bullet 模拟。当前节点关系已经形成：

- `pointvop1 -> group1`
- `group1 (activate) -> attribcreate1`
- `attribcreate1 (active) -> rbdbulletsolver1`

也就是说，先用 `group1` 选中需要被激活的碎片，再用 `attribcreate1` 创建名为 `active` 的属性，最后把结果送入 `rbdbulletsolver1`。

左侧视口中已经能看到雕像部分碎块被激活后向右侧飞散，黄色向量轨迹也仍在显示，说明当前速度与激活逻辑已经共同驱动了实际破碎模拟。右侧参数面板当前停在 `rbdbulletsolver1` 的 `Simulation` 区域，可确认：

- `Global Substeps` 为 `1`
- `Bullet Substeps` 为 `10`
- `Constraint Iterations` 为 `10`
- `Cache Memory (MB)` 为 `5000`

这张图对应的操作结论是：以 `activate` 组为筛选范围，给组内碎片写入 `active` 属性后交给 `RBD Bullet Solver`，从而只让选中的躯干附近碎块先进入动态状态，其余部分保持未激活或后续再触发。

### 00:29:12-00:33:52 速度、破碎、缓存

- 本段定位：速度、破碎、缓存。
- 知识点：适当减少帧数 现在就是这效果了 这里能明显感觉到爆裂感从中心向外迸发 能看到效果了 接着可以试着调节这些速度参数。
- 知识点：多试几次看看 也可以试着调出更逼真的碎裂效果 可以试试看 可以试着让碎块往上弹得更明显些 基础动画设定已经差不多了 差不多了 确实按我们设想的那样。
- 知识点：运行了现在可以调高全局或分离子步骤的迭代次数 把迭代次数调高一点验证效果更精细的效果 试试看 好像可以感觉有点 这里弹跳的有点别扭 偶尔确实会这样突出来。
- 知识点：调高这些子步骤能让这种问题稍好一点 反弹把反弹值调低点 我验证效果 感觉有点弱了不能太轻飘要像石头一样有分量 再加强一点弹跳感 感觉不对就反过来调了。
- 知识点：要不试试调到这个程度 把Bounce值压低点效果明显更稳了 反应也变弱了 几乎完全没反应了 感觉就是射为一的时候 确实有点弹跳感但 现在模拟速度飞快根本不用等。
- 核对对象：`速度`。

**关键画面：**

这一步进入对 Bullet 模拟结果的实播检查。当前节点链可见的关键部分仍为：

- `pointvop1 -> group1 (activate) -> attribcreate1 (active) -> rbdbulletsolver1`

左侧视口中，雕像的激活碎块已经向右侧铺开，黄色速度向量轨迹仍然可见，说明当前是在边播放模拟边观察受力后的飞散方向和幅度。结合正文“把 Bounce 值压低点效果更稳”“反应也会变弱”的说明，这张图的作用是判断当前激活碎块是否弹跳过强、是否需要继续压低反弹或碰撞响应。

右侧参数面板当前停在 `rbdbulletsolver1` 的 `Simulation` 区域，可确认当前仍使用：

- `Global Substeps = 1`
- `Bullet Substeps = 10`
- `Constraint Iterations = 10`
- `Cache Memory (MB) = 5000`

因此本图的操作重点不是新增节点，而是基于当前求解器设置检查碎片飞散和反弹表现是否稳定，为后面进一步微调求解器属性或碰撞参数提供依据。
这一步转到 `rbdbulletsolver1` 的 `Properties` 页签，直接微调碎块的物理属性，让破坏后的石像看起来不要“太轻飘”。右侧参数面板当前能明确读到：

- `Collision Padding = 0.02`
- `Density = 1000`
- `Rotational Stiffness = 0.1`
- `Bounce = 0.25`
- `Friction = 1`
- 睡眠阈值中 `Linear Threshold = 0.8`
- `Angular Threshold = 1`

左侧视口显示的是当前播放到中后段的碎块散落状态，碎片已经在地面上大范围铺开。结合字幕“不能太轻飘，要像石头一样有分量”和正文“把 Bounce 压低点效果更稳”的说明，这张图对应的调整逻辑是：降低反弹、保持较高摩擦，并用较高密度让碎块更像真实石块，从而避免碎片在模拟里出现过于轻快或弹跳过度的表现。
这一步把当前 RBD 模拟链整理到输出节点。当前可见的关键链路为：

- `pointvop1 -> group1 (activate) -> attribcreate1 (active) -> rbdbulletsolver1 -> null1`

其中 `null1` 被放在 `rbdbulletsolver1` 下游，作为这一阶段破坏模拟的明确输出口。左侧视口中，雕像当前回到接近初始的静立状态，并保留底部方向箭头辅助显示，说明作者此时已经不是在继续调某个中间参数，而是在为这一阶段的结果收口，方便后续节点或缓存阶段直接引用 `null1`。

右侧参数面板当前停在 `null1`，没有额外求解参数需要调整，也说明这里的重点是建立干净的网络出口。结合本段结尾“现在模拟速度飞快，根本不用等”的说明，这张图的结论是：速度、激活和 Bullet 破坏流程已经基本定型，用 `null1` 作为本阶段的标准输出，便于后面进入渲染器或缓存流程。

### 00:33:52-00:35:04 渲染器

- 本段定位：渲染器。
- 知识点：现在只要保留烘焙的时间 完全够用 100帧已经完全没问题了 本来还想过加到120帧 没必要加到120帧 任选一个渲染器添加进来。
- 知识点：再周旋实时实力化 就这样 现在开始渲染就基本完成了 差不多就结束了 渲染估计很快就能出结果了 好这节课我们就先做到这里 谢谢大家的观看 这节课就到这里 谢谢观看。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 核对对象：`渲染器`。

**关键画面：**

这一步进入本节最后的渲染输出整理阶段。当前可见节点主链已经收束为：

- `pointvop1 -> group1 -> attribcreate1 -> rbdbulletsolver1 -> OUT_Render`

其中下游输出节点不再是普通 `null1`，而是明确命名为 `OUT_Render` 的 `Null`，说明作者已经把这一整套 Houdini 破坏结果整理成供后续渲染、缓存或导出引用的正式输出口。

右侧参数面板当前停在 `OUT_Render`，没有额外功能参数，表明它的职责就是作为终点引用节点。结合正文“任选一个渲染器添加进来”“100 帧已经完全够用”的说明，这张图的核心意思是：在模拟链稳定后，把最终结果明确接到 `OUT_Render`，后面无论是给渲染器、做缓存还是输出到下游流程，都统一从这个节点取数据。
这一步打开了 `Labs Vertex Animation Textures` 输出节点 `Ex_01_Statue`，开始准备最终的 VAT 烘焙设置。右侧参数面板当前清楚显示：

- `Mode / Target Engine` 为 `Rigid-Body Dynamics (Rigid)` 到 `Unreal Engine`
- `Start/End` 为 `1` 到 `100`
- `Pivot Accuracy` 为 `Very High (Best Quality at Low Memory Footprint)`
- `Rotation Interpolation` 为 `Accurate Multi-RPF Slerp with Angular Velocity`
- `Texture Format` 为 `HDR EXR/TIFFs RGBA16/32 in Engine`
- `Target Texture Width` 为 `1024`

同时还能看到：

- `Input Geometry Is Cached to Integer Frames` 已启用
- `Include Hidden Debug Plane in Geometry` 已启用
- 面板底部提示当前 `Input Geometry Limit` 为 `82944 Packed Points per Frame`

结合字幕“100 帧已经完全没问题了，本来还想过加到 120 帧”的说明，这张图对应的操作就是：把前面整理好的 `OUT_Render` 结果送入 Houdini Labs 的 VAT 输出节点，并把刚体模式、目标引擎、导出帧范围和纹理规格先固定下来，其中本例最终采用 `1-100` 帧作为足够的烘焙时间范围。
这张图展示的是最终的 `/out` 输出网络，当前只保留一个 `Labs Vertex Animation Textures` 节点 `Ex_01_Statue` 作为本节的正式导出器。右侧参数面板进一步确认了它的输入和实时导出相关设置：

- `Input Geometry` 指向 `/obj/geo1/OUT_Render`
- `Mode / Target Engine` 仍为 `Rigid-Body Dynamics (Rigid)` 到 `Unreal Engine`
- `Start/End` 仍为 `1` 到 `100`

在当前页签中还能确认：

- `Allow Exporting Real-Time Data JSON File (Legacy)` 已启用
- `Support Real-Time Shading` 已启用

这说明此时作者已经把前面完整的破坏模拟链正式接到 `/out` 层的 VAT 导出节点上，并打开了适配实时着色/实时流程所需的选项。结合本段正文“现在开始渲染就基本完成了”的说明，本图可以作为本节收尾结论：网络已经整理完毕，后续只需从 `Ex_01_Statue` 执行 VAT 导出即可进入 Unreal 侧使用。

## 补充视觉证据

### S01 00:01:17

这张补充图对应导入 FBX 后，对 `Stature_01_fbx` 子网内部组成的核对，用来解释为什么导入结果里会额外看到一层包裹结构。当前可确认的对象级结构如下。

节点定义集：

- `statue_scan_free`：雕像主体网格，左侧视口中当前可见的白色雕像就是这一路真实主体。
- `materials`：导入时一并带入的材质网络对象。
- `UCX_statue_scan_free`：与主体网格同名规则对应的 UCX 碰撞几何对象，通常来自 Unreal/FBX 的碰撞壳导出约定。

连线集：

- 当前对象层级中这三个对象是并列存在的子对象，没有可见连线，说明它们属于同一个 FBX 子网下的独立对象，而不是 SOP 级串联处理链。

设置/参数：

- 右侧当前选中的是 `Geometry UCX_statue_scan_free`
- 其 `Transform` 参数可读为：
  - `Translate = (-2370, 90, -650)`
  - `Rotate = (0, 0, 90)`
  - `Scale = (1, 1, 1)`
- 下方还能确认：
  - `fbx_node_path = UCX_statue_scan_free`
  - `Pre Rotate = (-90, 0, 0)`

输出/预览：

- 左侧视口里只显示雕像主体，没有显示材质网络和碰撞壳，但结合子网中的对象名可以确认：导入 FBX 时不仅带入了主体网格，也带入了碰撞几何 `UCX_...`。
- 因此字幕中提到的“碰撞盒导致外层被包裹，导出后这样显示出来”可以具体落到这张图上理解为：若不区分主体网格与 `UCX_statue_scan_free` 这种碰撞壳对象，就可能把碰撞壳一并当成可见几何导入，造成外层包裹感。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。

