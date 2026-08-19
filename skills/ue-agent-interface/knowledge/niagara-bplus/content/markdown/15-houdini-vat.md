# 15.Houdini 表面体积模拟VAT制作

# 15.Houdini 表面体积模拟VAT制作

## 关键术语

- `UV`、`Houdini`、`VAT`、`粒子`、`碰撞`、`破碎`、`布料`、`所以现在我们从虚幻引擎开始，先创建一个角色静态网格`、`Niagara`、`材质`、`系统`、`颜色`、`Niagara System`、`Emitter`、`Particle`、`Spawn Rate`、`Spawn`、`Initialize Particle`

## 分段知识

### 00:00:06-00:04:39 Houdini

- 本段定位：Houdini。
- 知识点：大家好,地狮巫講,大家好,这是第一部分 所以现在我们從虛幻引擎开始,先創建一个角色靜態網格 本来想用一个现成的雕像类靜態網格,但覺得用角色模型会更有趣。
- 知识点：決定換成角色模型 既然这樣,那就先選这个角色了 这个角色就是格雷克斯 现在在动画剪輯窗口里,打開了角色的默認姿態 接下来就把这个角色的姿態直接轉成靜態網格,直接拿来用。
- 知识点：素材文件夾里,網格文件夾已经提前建好了 已将靜態網格保存在此處 打開後可確認它已有谷歌網格轉为靜態網格 接下来處理这部分内容 现在導出并導入Houdini。
- 知识点：先設置好模拟类型,这樣操作即可 当前無动画,会自動以靜態網格形式導入 接下来把網格導入Houdini,正式开始操作 对,测试用的靜態網格已存入資源庫。
- 知识点：啊,我不小心點開文件了 抱歉,剛才操作失誤 电影用的FBX文件已提前設置好 路徑是 我直接按原樣導入 找到路徑後,把相機、灯光、關節这些不要的元素取消勾选。
- 核对对象：`Houdini`。

**关键画面：**

这一帧是新章节 `15.Houdini 表面体积模拟VAT制作` 的起始界面，教程先不进入 Houdini，而是在 Unreal Engine 里确定要导出的角色和姿态。当前打开的是角色动画资源 `Idle` 的预览界面，目的是先找到一个合适的角色默认姿势，再把这个姿势转换成静态网格，作为后续导入 Houdini 的基础模型。

当前界面可确认的信息如下：

- 当前资源标签：`Idle`
- 角色预览主体：`Grux`
  - 角色持双武器，处于站立待机姿态
- 左侧 `Asset Details`
  - `Platform Target Frame Rate = 30 fps`
  - `Number Of Sampled... = 731`
  - `Number Of Sampled F... = 730`
  - `Rate Scale = 1.0`
  - `Loop` 选项可见
  - `Skeleton = Grux_Skeleton`
- 中央预览窗口统计
  - `LOD: 0`
  - `Triangles: 46,920`
  - `Vertices: 26,919`
  - `UV Channels: 5`
  - `Approx Size: 256x278x261`
  - `Kinematic Particles: 24`
  - `Dynamic Particles: 126`
  - `Framerate: 30 fps`
- 右下 `Asset Browser`
  - 当前高亮资源名为 `Idle`
  - 所在路径可见为 `Grux` 角色动画目录中的条目

结合正文“先创建一个角色静态网格”“决定换成角色模型”“现在在动画剪辑窗口里打开了角色的默认姿态”，这张图表达的操作顺序是：

1. 先在 UE 中选定一个角色，而不是直接用现成雕像。
2. 打开该角色的默认待机动画/姿态作为导出基准。
3. 之后会把这一帧姿态冻结并转换成静态网格，再拿去做 Houdini 的后续破碎、布料和 VAT 流程。
这一帧已经切到 Houdini，在空的 `obj` 网络中通过 `FBX Import Options` 导入从 UE 导出的角色 FBX。教程这里的重点不是复杂建模，而是把电影用的 FBX 按“只保留后续模拟真正需要的内容”的方式导入，去掉相机、灯光、关节等无关元素。

当前可确认的导入界面信息如下：

- 导入文件路径
  - 路径栏可见文件名：`Ex_04_Grux_01.FBX`
  - 前部路径可见 `Static_Mesh/Part_08/Test/...`
- 顶层导入类别
  - `Geometry`：勾选
  - `Animation`：勾选
  - `Materials`：勾选
  - `Cameras`：未勾选
  - `Lights`：未勾选
  - `Joints and Skin`：未勾选
- `Animation Options`
  - `Resample = TCB Curves Only`
  - `Every 1 frames`
  - `Override FBX Frame Rate`：未勾选
  - `Override Scene Frame Range`：未勾选
- `Character Options`
  - `Hide Joints Attached to Skin`：勾选
  - `Convert Joints To ZYX Rotation Order`：未勾选
  - `Create Sibling Bones for Visualization`：勾选
- `Material Options`
  - `Import Materials As = Principled Shaders`
- `Compatibility Options`
  - `Compatibility Mode = Compatible with Maya`
  - `Triangulate NURBS and Patches`：未勾选
  - `Import Global Ambient Light`：未勾选
- `General Options`
  - `File Paths = Convert to Relative`
  - `Convert to Y-up Coordinate System`：勾选
  - `Convert Units`：未勾选
- 底部操作按钮
  - `Import As New Scene`
  - `Import`
  - `Cancel`

结合正文“电影用的 FBX 文件已提前设置好”“找到路径后，把相机、灯光、关节这些不要的元素取消勾选”，这张图表达的实操结论是：

1. 角色 FBX 是从 UE 侧先准备好的单独文件，导入 Houdini 时并不是整场景全收。
2. 导入时只保留几何、动画和材质，去掉 `Cameras`、`Lights`、`Joints and Skin`，避免把后续模拟无关的场景对象带进来。
3. 同时开启 `Convert to Y-up Coordinate System`，保证导入后的坐标方向与 Houdini 工作环境一致，减少后续姿态和模拟朝向出错的风险。
这一帧说明角色 FBX 已经成功进入 Houdini，并且教程开始在 `VAT` 几何网络中做第一次清理。左侧视口里已经能看到导入后的 `Grux` 静态姿态模型，中央网络则显示出一个非常简单的处理链：先把外部角色几何 `object_merge` 进来，再做 `transform`，最后用 `blast` 删除当前不需要的几何部分。

当前可确认的 Houdini 结构如下：

- 当前几何容器：`VAT`
- 网络路径显示：`/obj/VAT`
- 节点链
  - `object_merge1`
    - 来源路径可见为 `/obj/Ex_04_Grux_01_FBX/StaticMes...`
  - `transform1`
  - `blast1`
    - 当前处于选中状态
    - 下方有蓝色注释：`selection`
- `blast1` 参数面板
  - `Group Type = Primitives`
  - `Delete Non Selected`：未勾选
  - `Fill Simple Holes`：未勾选
  - `Delete Unused Groups`：勾选
  - `Group` 输入框中已经写入一串 primitive 编号，表示当前删除操作是基于手工圈选后的具体面片集合

左侧视口结果也能确认几个关键事实：

- 导入对象是角色 `Grux` 的静态姿态网格，而不是带骨骼动画播放的骨架体
- 视口中的模型已经处在 Houdini 的几何场景里，可直接进行面级选择和删除
- 当前删除目标集中在角色下半身前方垂落的布条/带状区域附近，说明教程已经开始做“保留需要的形体、去掉不需要部分”的前期网格清理

结合正文“素材文件夹里，网格文件夹已经提前建好了”“接下来处理这部分内容，现在导出并导入 Houdini”“类似条带的部分也一并选中”，这张图表达的是进入 Houdini 后的首个标准操作：

1. 用 `object_merge1` 把从 UE 导出的角色静态网格引入当前 `VAT` 处理网络。
2. 经过 `transform1` 做基础朝向/位置整理。
3. 再用 `blast1` 按 primitive 选择集删掉不需要的面片，为后面破碎、Vellum 或体积模拟保留更干净的输入网格。

### 00:04:39-00:09:31 碰撞、破碎、布料

- 本段定位：碰撞、破碎、布料。
- 知识点：类似條带的部分也一併選中 選完後檢查下是否还有殘留,这樣差不多了 可以,耳飾这类細節保留就好 接着用粘性工具提高深度,让點數顯着增多。
- 知识点：按空格加3切換到前視圖,接着選下身 现在是匹配选择模式,改成原始點模式試試 改成點类型并推出模式後,拖拽就能直選點 再切回透視視圖,按住Ctrl鍵移除不需要的部分確認無誤。
- 知识点：確認無誤後按Delete,就能刪掉下半身 網格清理完後,用邊緣破碎切分 約10个切塊,先粗略切出大約5000个碎片,試運行一下效果。
- 知识点：这次我们想做出类似溶解的效果,让面像被撕開一樣 碎片紛紛飛散開来 切換到爆炸視圖,就很清楚看到碎片的分佈状态 接下来我们要用Valum模拟来操作。
- 知识点：得先给物体加上Valum屬性,記得去查找布料材质 给物体加上衣物屬性,再套上預設的布料材质。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`材质`、`系统`、`碰撞`。

**关键画面：**

这一帧仍在 Houdini 的 `VAT` 几何网络中使用 `blast1` 清理角色网格，但比上一段更进一步：教程已经进入逐块检查残留几何的阶段，要求把不需要的条带、下半身或零散碎块继续选出来，同时确认耳饰等细小但有用的特征不要误删。

当前可确认的操作状态如下：

- 当前节点链保持为：
  - `object_merge1`
  - `transform1`
  - `blast1`
- 当前选中节点：`blast1`
- `blast1` 参数面板
  - `Group Type = Primitives`
  - `Delete Non Selected`：未勾选
  - `Delete Unused Groups`：勾选
  - `Group` 输入框中已有多段 primitive 范围，说明当前删除集已经累积了多轮手工选择结果
- 左侧视口
  - 角色以三角面线框方式显示
  - 进入了组/岛选择模式，视口中有一个列出 `Island 0`、`Island 96`、`Island 2755` 等条目的浮动选择面板
  - 当前镜头集中在角色头部和上半身侧面，说明此时正在检查顶部和细节区域是否还有误留的孤立片段

字幕“选完后检查下是否还有残留，这样差不多了”和正文“类似条带的部分也一并选中”“耳饰这类细节保留就好”共同说明这张图的操作目标：

1. 用 primitive/island 级别的选择把不需要的独立几何块继续加入 `blast1` 的删除组。
2. 清理时不是一味删光，而是要人工判断哪些属于噪声残留、哪些属于角色造型应保留的细节。
3. 这一轮的重点是把网格清理到“足够干净但不丢特征”，为后面的下身删除、破碎和 Vellum 设置提供稳定输入。
这一帧说明网格清理已经基本完成，教程开始把保留下来的角色上半身送入破碎链，目标是做出“像被撕开、逐步溶解”的碎裂效果。视口左上已经明确显示当前查看节点为 `Edge Fracture`，而中央网络也能看出清理链之后接上了细分和边缘破碎。

当前可确认的 Houdini 网络结构如下：

- 当前容器仍为 `VAT`
- 已可见的处理链：
  - `blast1`
  - `blast2`
  - `blast3`
  - `subdivide1`
    - 标注：`Depth: 2`
  - `blast4`
  - `edgefracture1`
- 当前选中节点：`edgefracture1`
- 左侧视口结果
  - 角色下半身已被删除，只保留上半身、双臂和头部区域
  - 当前显示的是未完全炸开的整体形体，说明破碎节点已经挂上，但此时主要在准备切块参数

右侧 `Edge Fracture edgefracture1` 参数面板可确认：

- `Initial Pieces = 5000`
- `Resample Accuracy` 滑条可见
- `Point Cost Attribute`：未勾选
- `Show Guide Geometry`：未勾选
- `Output`
  - `Original Point Group = origpts`
  - `New Point Group = newpts`

结合正文“接着用粘性工具提高深度，让点数显著增多”“网格清理完后，用边缘破碎切分，约10个切块，先粗略切出大约5000个碎片”“这次我们想做出类似溶解的效果”，这张图表达的操作逻辑是：

1. 先通过多次 `blast` 把不需要的身体部分和杂项几何删掉。
2. 用 `subdivide1` 提高网格密度，让后面的破碎有足够细节。
3. 再进入 `edgefracture1`，以较高的初始碎片数 `5000` 先粗做一次切分，为后面“碎片像被撕开后飞散”的视觉方向打底。
这一帧说明教程已经从“几何清理与破碎”正式过渡到 Vellum 布料模拟准备阶段。中央网络里出现了 `vellumcloth1` 和 `vellumsolver1`，右侧当前选中的是 `group1`，并且使用一个可视化的包围球在前视图里圈定区域，说明此时正在为布料约束或后续求解指定一块受影响的 primitive 组。

当前可确认的网络结构如下：

- 当前可见节点
  - `explodedview1`
  - `vellumcloth1`
    - 标签：`Vellum Constraints`
    - 子标签：`cloth`
  - `group1`
  - `vellumsolver1`
- 节点关系
  - `group1` 从 `vellumcloth1` 的输出侧分出一支
  - `vellumsolver1` 接在 `vellumcloth1` 下游，说明布料约束已经开始接入求解器流程

右侧 `Group Create group1` 参数面板可确认：

- `Group Name = group1`
- `Group Type = Primitives`
- `Initial Merge = Replace Existing`
- `Base Group`
  - `Enable`：未勾选
- `Keep in Bounding Regions`
  - `Enable`：勾选
  - `Bounding Type = Bounding Sphere`
  - `Size = (1, 1, 1)`
  - `Center = (0, 0, 0)`
  - `Initialize to Input Bounds` 按钮可见
  - `Include Partially Contained Entities`：未勾选
- 其他筛选方式
  - `Keep by Normals`：未勾选
  - `Include by Edges`：未勾选
  - `Keep by Random Chance`：未勾选

左侧前视图中的白色圆形包围线与角色上半身位置对应，说明当前正在以前视方式用一个球形区域选择模型中的局部 primitive。结合正文“切换到前视图，接着选下身”“接下来我们要用 Vellum 模拟来操作”“得先给物体加上 Vellum 属性”，这张图表达的实际步骤是：

1. 在破碎后的角色网格上建立 Vellum 布料约束节点 `vellumcloth1`。
2. 通过 `group1` 先选出要参与或重点控制的 primitive 区域，而不是让整块几何无差别进入后续控制。
3. 用前视图下的 `Bounding Sphere` 辅助选组，便于快速圈定角色下身或某个局部区域，随后再把这组结果送入 `vellumsolver1` 做布料化求解。

### 00:09:31-00:14:26 VAT、粒子

- 本段定位：VAT、粒子。
- 知识点：动画播放时,这部分区域才会开始發揮作用 动画播放时,只有这組碎片会陸續散開飛離 这就是實现漸進解体的关键原理 接下来我们用颜色标记一下,創建一个叫Inside的組。
- 知识点：也得同步改名,用紅色标记後,效果就是这樣的 效果就像被輕石般,溶解区域会以紅礦標出 接下来通过Attribute Create节点設置激活值。
- 知识点：Activate,屬精,在物理模拟中应用廣泛,是核心控制參數 将Grouping設为Inside,只有屬於该Grouping的元素,其屬性值才会被設为1。
- 知识点：在Spray Sheet中查看Activate为0的地方是默認状态 变为1的区域則对应紅色显示,这些区域均显示为紅色 其餘部分則保持白色显示。
- 知识点：設置完成後,通过Null节点,将该屬性值傳入力模拟流程 雙擊Reporation,Generate节点進入模拟,即可再次添加力場。
- 知识点：用Popforce节点发射噪點粒子,再写个简单的Vex腳本,實现分組 为让粒子沿X轴向兩側散開,提前把风場強度設为1.5左右。
- 知识点：振幅設为2左右,漩渦尺寸保持默認 这里看一下Input,我们選了第二个子节点,作为输入 把之前建好的空节点路徑指定好,接着写代碼。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`粒子`、`颜色`。

**关键画面：**

这一帧仍在 `group1` 节点里继续做局部分组，但重点已经从单纯“选一块区域做 Vellum”转向为后续渐进解体准备一个明确的内部作用区。视口切到前视图后，包围球被放大并上移，覆盖角色头顶和上半身上缘附近，说明教程正在精确限定哪一片 primitive 会被归入后续要特殊处理的组。

当前可确认的信息如下：

- 当前网络仍位于 `VAT`
- 可见节点关系
  - `explodedview1`
  - `vellumcloth1`
  - `group1`
  - `vellumsolver1`
- 当前选中节点：`group1`
- `Group Create group1` 参数
  - `Group Name = group1`
  - `Group Type = Primitives`
  - `Initial Merge = Replace Existing`
  - `Keep in Bounding Regions = Enable`
  - `Bounding Type = Bounding Sphere`
  - `Size = (2.5, 2.5, 2.5)`
  - `Center = (0.760467, 3.12985, 0)`
  - `Include Partially Contained Entities`：未勾选

左侧前视图中还能确认：

- 当前包围球的圆弧轮廓已经覆盖角色头部和肩背上方区域
- 角色下半身已经被删去，只保留上半身及手臂，说明这一组的目的不是控制整个人体，而是从剩余几何中继续提取局部区域

结合正文“动画播放时，只有这组碎片会陆续散开飞离，这就是实现渐进解体的关键原理”“接下来我们用颜色标记一下，创建一个叫 Inside 的组”，这张图对应的步骤是：

1. 先用 `group1` 通过包围球圈定一个局部 primitive 区域。
2. 这块区域后面会被重新命名并作为“逐步激活、逐步散开”的核心内部组使用。
3. 渐进解体不是整块模型同时飞散，而是依赖这种先分组、再局部触发的方式逐段展开。
这一帧已经把前一张图里圈出的局部区域推进成一条明确的“内部激活控制链”。网络中可以直接读到 `inside`、`color1`、`attribcreate... activate` 和 `null1`，说明教程正在把这个局部分组可视化，并写入一个供后续物理/粒子流程读取的 `activate` 属性。

当前可确认的网络结构如下：

- 上游仍来自 `vellumsolver1`
- 当前可见控制链：
  - `inside`
  - `color1`
  - `attribcreate...`
    - 下方蓝色标签：`activate`
  - `null1`
- 当前选中节点：`null1`

从这张图可以稳定确认的含义：

- `inside`
  - 这是前一阶段局部 primitive 分组整理后的正式命名结果
  - 它代表“动画播放时会被逐步触发和散开的那部分区域”
- `color1`
  - 其作用是把 `inside` 组做颜色可视化
  - 结合正文“用红色标记后，效果就是这样”，这里的颜色节点用于在视口中直接看出哪些碎片属于内部作用区
- `attribcreate... activate`
  - 这是关键属性写入节点
  - 教程要创建的属性名为 `activate`
  - 该属性会作为后续模拟中常用的激活控制参数
- `null1`
  - 用作链路输出锚点
  - 字幕“通过 null 节点将该属性值传入独立模拟流程”说明这里不是为了显示，而是为了给后续节点网络提供一个稳定引用路径

结合正文“接下来我们用颜色标记一下，创建一个叫 Inside 的组”“通过 Attribute Create 节点设置激活值”“在物理模拟中应用广泛，是核心控制参数”“设置完成后，通过 Null 节点将该属性值传入力模拟流程”，这张图表达的操作顺序是：

1. 把局部作用区正式命名为 `Inside`。
2. 用 `color1` 先把该组在视口里标出来，便于验证分组是否正确。
3. 在 `Attribute Create` 中为该组写入 `activate` 值，使属于 `Inside` 的元素拥有后续可被读取的激活标记。
4. 最后通过 `null1` 把这条带有分组与属性的几何结果导出给后续独立模拟或粒子发射流程。
这一帧已经双击进入 `vellumsolver1` 内部的 `forces` 动力网络，说明教程开始把上一步输出的 `activate` 属性真正接到力场控制逻辑里。当前可见的网络非常短：`popforce1 -> popwrangle1 -> Output FORCE`，其中 `popwrangle1` 通过第二输入读取外部几何上的 `activate` 值，用它决定哪些碎片会被后续力场推动。

当前可确认的 DOP/POP 结构如下：

- 当前路径面包屑可见：
  - `vellumsolver1`
  - `dopnet1`
  - `forces`
- 可见输入占位：
  - `Input 1`
  - `Input 2`
  - `Input 3`
- 当前可见节点链：
  - `popforce1`
  - `popwrangle1`
  - `Output FORCE`（`Output #0`）
  - 旁边还有 `Output SOURCE`（`Output #1`）
- 当前选中节点：`popwrangle1`

右侧 `POP Wrangle popwrangle1` 参数可确认：

- `Activation = 1`
- `Use Timestep`：勾选
- `Time Scale = 1`
- `Attributes to Create = *`
- `VEXpression` 中可读到：

```c
i@activate_piece = point(1, "activate", @ptnum);
```

这条语句的含义可以直接从截图中确认：

- 从第 `1` 号输入读取名为 `activate` 的点属性
- 按当前 `@ptnum` 对应的点索引取值
- 将结果写到当前粒子/碎片上的 `i@activate_piece`

结合正文“通过 Null 节点，将该属性值传入力模拟流程”“用 Popforce 节点发射噪点粒子，再写个简单的 Vex 脚本，实现分组”“这里看一下 Input，我们选了第二个子节点，作为输入”，这张图表达的实际流程是：

1. 先在外部几何链里生成 `activate` 属性。
2. 进入 `vellumsolver1` 的 `forces` 网络，把 `popforce1` 作为实际施力节点接到 `FORCE` 输出。
3. 在 `popwrangle1` 中通过第二输入读取外部的 `activate`，把它转换成当前求解阶段可直接使用的 `activate_piece` 标记。
4. 后续力场就可以只对被激活的碎片施加作用，从而实现“只有内部组先开始散开”的渐进解体效果，而不是所有碎片同时受力飞散。

### 00:14:26-00:18:50 VAT、粒子

- 本段定位：VAT、粒子。
- 知识点：还得調一下FloatMath这个屬性值,用集群材质創建时自動带过来的Math值直接用了。
- 知识点：现在下面用Eve語句来處理,之前用分組把真假分別標成0和1 现在就拿这个分組当條件用就行 填上Piece值,在Else里的大括號之间,输入AttributeMath值。
- 知识点：符合條件的那些Else里的值一幀,結果就直接变成这樣 而且,第二个設成0,这樣就对上了,现在報了个錯 可能是我打字哪里錯了,我找找看,乾脆把电脑關了,这樣就没錯了。
- 知识点：现在我们從外部指定分組并導入了 随着幀數推進,進入该区域的对象,将Activate值設为1 處於選中状态的对象会将Activate值設为1。
- 知识点：因此在模拟運行时,系统会实时同步更新这一數值 因为将條件語句中Activate片段的值直接替換为外部设置的分組Activate值。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`粒子`、`系统`。

**关键画面：**

这一帧仍然位于 `vellumsolver1/dopnet1/forces` 的 `popwrangle1` 中，但操作已经从“单纯读取 activate”推进到“把读取到的组值进一步转成可参与条件判断和数值运算的中间变量”。教程此处正对应正文中“还得调一下 FloatMath 这个属性值”“现在下面用 if 语句来处理，之前用分组把真假分别标成 0 和 1，现在就拿这个分组当条件用”。

当前可确认的 DOP/POP 结构未变：

- 路径仍为：
  - `vellumsolver1`
  - `dopnet1`
  - `forces`
- 节点链仍为：
  - `popforce1`
  - `popwrangle1`
  - `Output FORCE`
  - 旁侧 `Output SOURCE`
- 当前选中节点：`popwrangle1`

右侧 `POP Wrangle popwrangle1` 中可可靠读到的 VEX 片段：

```c
i@activate_piece = point(1, "activate", @ptnum);
float ma... = point(1, "...");
```

能稳定确认的含义：

- 第一行仍在从第 `1` 号输入读取 `activate` 属性，并写入 `i@activate_piece`
- 第二行新增了一个 `float` 类型的中间变量
- 该变量同样通过 `point(1, ...)` 从外部输入几何读取某个属性值
- 从正文“FloatMath 这个属性值”“用集群材质创建时自动带过来的 Math 值直接用了”来看，这一行是在为后续条件分支准备一个数值驱动量

当前无法从截图中完全确认的点：

- 第二行变量名在截图中只看到 `ma...`
- 被读取的属性名同样未完整显示
- 因此不能可靠断言它的精确变量名或属性名

这张图能可靠说明的流程是：

1. 继续在 `popwrangle1` 中从外部输入读取控制属性，而不是手动在 DOP 内写死数值。
2. 除了 `activate` 这种布尔/整型激活标记，还额外读取一个浮点型数值，作为接下来 `if/else` 判断和 `AttributeMath` 结果写入的依据。
3. 也就是说，这一步是在把外部几何组和属性同步映射成内部求解可用的“条件变量 + 数值变量”。
这一帧回到 `VAT` 外层网络，说明前面在 `popwrangle1` 中处理的激活逻辑已经重新反馈到主流程。这里最关键的变化是：原来的 `null1` 已经被正式命名为 `REF_Activate`，变成一条明确的外部引用输出；同时左下方几何表格里能直接看到 `activate_piece` 等字段，表明激活状态已经被写回并参与求解更新。

当前可确认的外层网络结构如下：

- 上游可见：
  - `explodedview1`
  - `vellumcloth1`
  - `vellumsolver1`
- 旁侧激活控制链：
  - `group1`
    - 蓝色标签：`inside`
  - `color1`
  - `attribcreate1`
    - 蓝色标签：`activate`
  - `Null REF_Activate`
- `REF_Activate` 的命名已经明确表明：
  - 这不是普通临时空节点，而是供外部/下游稳定引用的一条激活属性输出

左下角表格可直接确认：

- 当前节点表格中存在 `activate_piece` 列
- 旁边还可见 `airresist`、`disableexternal` 等模拟相关字段
- 表格行中当前显示的大部分 `activate_piece` 值为 `0`

这与正文“现在我们从外部指定分组并导入了，随着帧数推进，进入该区域的对象，将 Activate 值设为 1”“在模拟运行时，系统会实时同步更新这一数值”是对应的。当前截图所表达的实质是：

1. 外部的 `Inside -> activate -> REF_Activate` 控制链已经搭好，并能作为求解器内部读取的正式输入引用。
2. `activate_piece` 在求解表里默认先以 `0` 出现，表示未激活状态。
3. 当模拟按时间推进、对象进入指定分组或满足条件时，这一列的值会从 `0` 切换为 `1`，从而驱动后续碎片逐步脱离，而不是初始就全部激活。
这一帧是 `S04` 段的收束图，焦点已经从单个 VEX 语句切回整个求解主链，目的是确认 `inside -> activate -> REF_Activate` 这条外部控制链与 `vellumsolver1` 主求解链保持同步工作。教程此时要表达的是：只要外部激活组和属性链搭对了，模拟过程中激活值就会实时更新，系统便会按时间逐步让指定碎片进入受力状态。

当前可确认的主链结构如下：

- 主几何链
  - `explodedview1`
  - `vellumcloth1`
  - `vellumsolver1`
- 旁侧激活控制链
  - `group1`
    - 蓝色标签：`inside`
  - `color1`
  - `attribcreate1`
    - 蓝色标签：`activate`
  - `Null REF_Activate`
- 当前选中节点：`vellumsolver1`

右侧 `Vellum Solver vellumsolver1` 的 `Forces` 页可确认：

- `Start Frame = 1`
- `Solver Mode = Full`
- `Time Scale = 1`
- `Substeps = 1`
- `Constraint Iterations = 100`
- `Smoothing Iterations = 10`
- `Enable Collisions`：勾选
- `Self Collisions`：勾选
- `Collision Passes = 10`
- `Post Collision Passes = 3`
- `Polish Passes = 10`
- `Layer Shock = 4`

左侧视口和时间轴还能确认：

- 角色上半身模型仍作为当前求解对象存在
- 时间轴播放头已推进到 `11` 帧附近
- 当前并不是静态搭节点，而是在时间推进中观察求解结果

结合正文“随着帧数推进，进入该区域的对象，将 Activate 值设为 1”“因此在模拟运行时，系统会实时同步更新这一数值”，这张图表达的核心结论是：

1. `REF_Activate` 不是孤立的辅助输出，而是会在求解过程中持续为 `vellumsolver1` 提供外部激活状态。
2. 求解器本身并不需要手工逐帧切换碎片开关，而是依赖外部 `activate` 值在时间推进中自动更新。
3. 因此“渐进解体”真正成立的关键，是外部组、属性链、DOP 内部 wrangle 和主求解器四者已经被串成一条闭环，而不是只做了单独的分组或单独的力场。

### 00:18:50-00:23:27 UV、粒子

- 本段定位：UV、粒子。
- 知识点：现在肉眼看不出明顯分組效果,但能清楚看到碎片正按剛才大致確認的方向飛散 效果大概差不多了,就是现在飛得太快了,得把时间縮放調成一半左右,让碎片飛得慢點,这樣才更順,还要再分細些。
- 知识点：再分細一点,加些像粉末一樣的粒子,能让碎裂融合得更自然,破片数量也得多些 接下来还有什么要調的嗎?嗯,平衡模拟的參數不用大動 從緩存里挑出能用於VT的網格。
- 知识点：順便又檢查了一遍UV有没有,UV也確認了,先保存资源,然后輕緩存 调整完成後,保存到第200幀,緩存已生成完成,檢查一下可观察到粒子已造點般的轨迹飛散。
- 知识点：这部分只要渲染一下,这節課就完成了 接下来将用Waite在Outliner中进行渲染,这次選中柔体进行渲染即可 從第二幀到第二百幀,这里選好渲染設置,先用4096尺寸测验证效果渲染。
- 知识点：如果需要更大的尺寸,如果不夠用或報錯,就調高到8192尺寸再試 渲染成功後就停止,这節課就結束了 这次我们先用Vellum模拟制作用於Waite的資源,直接把模型拆成碎塊。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`粒子`。

**关键画面：**

这一帧是激活链和求解器接通后的结果检查图。当前肉眼已经不太容易直接看出 `inside` 分组本身，但能明确看到角色头顶附近有少量碎片沿既定方向飞散，说明前面搭建的“局部激活 -> 逐步受力 -> 渐进解体”逻辑已经开始生效。

当前可确认的网络和结果状态如下：

- 外层主链仍保持：
  - `explodedview1`
  - `vellumcloth1`
  - `vellumsolver1`
- 激活控制链仍保持：
  - `group1`
    - 蓝色标签：`inside`
  - `color1`
  - `attribcreate1`
    - 蓝色标签：`activate`
  - `Null REF_Activate`
- 当前选中节点：`vellumsolver1`

右侧 `Vellum Solver vellumsolver1` 的 `Forces` 页当前仍可确认：

- `Time Scale = 1`
- `Substeps = 1`
- `Constraint Iterations = 100`
- `Smoothing Iterations = 10`
- `Enable Collisions`：勾选
- `Self Collisions`：勾选

左侧前视图结果能确认：

- 角色主体仍保持上半身整体轮廓
- 头顶上方与右侧已有零散碎片脱离主体
- 碎片飞散方向总体一致，没有出现完全杂乱无序的向各方向均匀爆开

结合正文“现在肉眼看不出明显分组效果，但能清楚看到碎片正按刚才大致确认的方向飞散”，这张图表达的是：

1. 分组与激活逻辑的成功标准，不是让观众直接看见组本身，而是让碎片运动结果体现出局部、渐进、定向的飞散趋势。
2. 当前模拟已经达到“方向基本对了”的阶段，因此后续优化重点不再是重做分组，而是调速度、细节密度和粉末感。
这一帧说明模拟结果已经不再只停留在视口预览，而是正式进入缓存输出阶段。教程这里先确认 UV 没问题，再把 `vellumsolver1` 的结果接到 `filecache1`，准备把可用于后续 VAT/VT 流程的几何缓存保存到磁盘。

当前可确认的网络结构如下：

- 上游主链
  - `blast4`
  - `edgefracture1`
  - `explodedview1`
  - `vellumcloth1`
  - `vellumsolver1`
- 旁侧激活控制链仍保留：
  - `group1` -> `color1` -> `attribcreate1` -> `REF_Activate`
- 当前新增下游节点：
  - `filecache1`
    - 接在 `vellumsolver1` 输出之后

右侧 `File Cache filecache1` 参数可直接确认：

- `File Path = Constructed`
- `Time Dependent Cache`：勾选
- `Base Name = $HIPNAME.$OS`
- `Base Folder = $HIP/geo`
- `Version = 1`
- `Cache`
  - `Save to Disk`
  - `Save to Disk in Background`
- `Sequence`
  - `Evaluate As = Frame Range`
  - `Start/End/Inc = 1 / 200 / 1`
  - `Substeps = 1`
- `Load`
  - `All Geometry`

左侧视口与信息框还能确认：

- 顶部信息显示当前缓存名类似：
  - `untitled.filecache1_v1.$F4.bgeo.sc`
- 角色上半身几何作为当前缓存对象可正常显示

结合正文“顺便又检查了一遍 UV 有没有，UV 也确认了，先保存资源，然后清缓存”“调整完成后，保存到第 200 帧，缓存已生成完成”，这张图表达的流程是：

1. 在决定落盘前，先确认当前碎裂几何的 UV 仍然存在且可用。
2. 把 `vellumsolver1` 的结果直接接到 `filecache1`，作为后续 VAT/VT 使用的标准缓存输出口。
3. 缓存范围设置为 `1-200` 帧，并以 `.bgeo.sc` 形式写入 `$HIP/geo`，为后续渲染和导回 Unreal 准备稳定的模拟结果。
这一帧已经进入 `out` 输出网络，开始用 Houdini Labs 的 `vertex_animation_textures1` 导出 VAT 资源。也就是说，本节的 Vellum 模拟结果已经不只是“做完缓存”，而是正式被转换为后续要带回 Unreal 使用的网格动画贴图资源。

当前可确认的输出节点与参数如下：

- 当前输出节点：`vertex_animation_textures1`
- 当前路径已切到 `out`
- 右侧节点标题可见为 `Labs Vertex Animation T...`
- 顶部操作按钮：`Render All`
- `Mode / Target Engine`
  - 模式：`Soft-Body Deformati...`
  - 目标引擎：`Unreal Engine`
- 帧范围
  - `Start/End = 1 / 200`
- 输入几何
  - `Input Geometry = /obj/VAT/OUT_Render`
- `Settings`
  - `Export Compressed Normals in Position Alpha`：未勾选
  - `Input Geometry Is Cached to Interp Frames`：勾选
  - `Texture Format = HDR (EXR/TIFF as RGBA 16/32...)`
  - `Export Spare Color Texture`：未勾选
  - `Export Static Mesh Vertex Colors`：未勾选
  - `Include Hidden Debug Plane in Geometry`：勾选
- 输出分辨率相关
  - `Target Texture Width = 4096`
  - `Last Render's Texture Size = 0 x 0`
- 输入上限提示
  - `Input Geometry Limit: 163840 Points per Frame`

截图左下角的进度窗口还能确认：

- 当前正在执行导出流程
- 任务文本可见 `render_mesh_fbx frame 1`
- 状态文本出现 `Duplicating input`

结合正文“这部分只要渲染一下，这节课就完成了”“从第二帧到第二百帧，这里选好渲染设置，先用 4096 尺寸测验证效果渲染”“如果需要更大的尺寸，不够用或报错，就调高到 8192 再试”“这次我们先用 Vellum 模拟制作用于 VAT 的资源”，这张图表达的最终输出步骤是：

1. 把前面缓存好的模拟结果整理成 `OUT_Render` 几何输出。
2. 在 `vertex_animation_textures1` 中选择 `Soft-Body Deformation + Unreal Engine` 模式，将 `1-200` 帧的模拟烘焙为 VAT 贴图和配套网格资源。
3. 首次测试渲染优先用 `4096` 宽度；如果点数或质量不足，再按需要提升到 `8192`。
4. 这一步完成后，本节 Vellum 到 VAT 的资源制作就算收尾，下一节再把该 VAT 资源与粒子资源合并回 Unreal。

### 00:23:27-00:23:57 关键画面

- 本段定位：关键画面。
- 知识点：下期需要把兩种資源合併進在Unreal里,完成最終的特效效果 渲染完成了,这期就到这里,下期再見 下期,接着来,C文件保持原樣保存就行 下期还会用到,到时候見,謝謝觀看。

**关键画面：**

这一帧是本节最终输出的收尾确认图。教程已经停留在 `out` 网络的 `vertex_animation_textures1` 节点上，左下角弹出的进度窗口说明 VAT 资源正在或刚刚完成导出，字幕也直接给出“渲染完成了”的结论。

当前可确认的 VAT 输出设置仍然是：

- 输出节点：`vertex_animation_textures1`
- 当前路径：`out`
- 模式：`Soft-Body Deformation`
- 目标引擎：`Unreal Engine`
- 帧范围：`1 - 200`
- 输入几何：`/obj/VAT/OUT_Render`
- `Target Texture Width = 4096`

左下进度窗口可确认：

- 当前任务文本：`render_mesh_fbx frame 1`
- 进度条处于运行状态
- 计时已推进到约 `0:28`
- 底部状态能看到正在执行 `vertex_animation_textures1` 相关操作

结合正文“渲染成功后就停止，这节课就结束了”，这张图表达的是：

1. 本节的 Vellum 模拟结果已经正式进入 VAT 烘焙输出流程。
2. 导出任务正常运行后，不需要再继续改求解参数，本节目标已经达成。
3. 接下来工作重点将转移到把当前导出的 VAT 资源与后续粒子资源合并回 Unreal，而不是继续在 Houdini 内打磨这一版基础输出。
这一帧已经没有进度弹窗，说明 `vertex_animation_textures1` 的第一次测试导出已稳定完成。相比上一张图，此时最重要的新信息是右侧参数面板已经给出了实际输出尺寸，证明用 `4096` 作为目标宽度的 VAT 导出可以成功跑完。

当前可确认的 VAT 输出结果如下：

- 节点仍为：`vertex_animation_textures1`
- 模式仍为：`Soft-Body Deformation`
- 目标引擎：`Unreal Engine`
- 帧范围：`1 - 200`
- 输入几何：`/obj/VAT/OUT_Render`
- `Target Texture Width = 4096`
- `Last Render's Texture Size = 4096 x 16000`

其余仍可确认的导出设置：

- `Input Geometry Is Cached to Interp Frames`：勾选
- `Texture Format = HDR (EXR/TIFF as RGBA 16/32...)`
- `Include Hidden Debug Plane in Geometry`：勾选
- `Input Geometry Limit: 163840 Points per Frame`

这张图对应正文“这里选好渲染设置，先用 4096 尺寸测验证效果渲染”“如果需要更大的尺寸，不够用或报错，就调高到 8192 再试”。当前截图能得出的结论是：

1. 以 `4096` 作为测试宽度的导出已经成功完成，没有因为当前数据量直接失败。
2. 实际生成的贴图尺寸高达 `4096 x 16000`，说明当前 soft-body VAT 数据量相当大，后续如果 Unreal 侧或贴图规格受限，就需要再评估是否提高宽度、缩短帧段，或进一步优化点数。
3. 但就本节教学目标而言，这一步已经证明当前 Vellum 结果可以被正确烘焙成 VAT 输出资源。
这一帧是 `p20` 章节的最终收尾图。界面仍停留在 `out` 网络的 `vertex_animation_textures1` 节点上，但整体状态已经从“导出进行中”切换为“资源导出完成并保留工程文件”。字幕明确说明这份资源下期还会继续使用，因此本节的结束动作不是删除或重置，而是把当前 HIP 工程和 VAT 输出结果原样保存下来，留给下一节在 Unreal 中与另一类资源合并使用。

当前可确认的最终状态如下：

- 输出节点仍为：`vertex_animation_textures1`
- 模式仍为：`Soft-Body Deformation`
- 目标引擎：`Unreal Engine`
- 帧范围：`1 - 200`
- 输入几何：`/obj/VAT/OUT_Render`
- `Target Texture Width = 4096`
- `Last Render's Texture Size = 4096 x 16000`

左下状态栏还能确认：

- 出现保存成功提示：
  - `Successfully saved Ex_04.hiplc`

这张图与正文“下期需要把两种资源合并进 Unreal 里，完成最终的特效效果”“C 文件保持原样保存就行，下期还会用到”对应，实际结论是：

1. 当前章节只负责把 Vellum 模拟转成可用的 VAT 资源，不在本节内完成最终 UE 合成。
2. 已导出的 `vertex_animation_textures1` 结果就是下一节要继续调用的核心资源之一。
3. 因此正确的收尾动作是保存 `.hiplc` 工程并保留当前输出节点配置，而不是继续修改网络或清理文件。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。

