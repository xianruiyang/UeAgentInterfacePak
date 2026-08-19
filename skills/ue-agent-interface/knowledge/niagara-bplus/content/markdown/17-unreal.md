# 17.Unreal粘性液体效果制作

# 17.Unreal粘性液体效果制作

## 关键术语

- `Alpha`、`Lerp`、`Opacity`、`Roughness`、`Sequencer`、`VAT`、`SD`、`Fluid`、`Mesh`、`材质`、`后期处理`、`Niagara`、`纹理`、`贴图`、`系统`、`蓝图`、`Niagara System`、`Emitter`

## 分段知识

### 00:00:05-00:04:41 Sequencer、VAT、SD

- 本段定位：Sequencer、VAT、SD。
- 知识点：先建一个Mesh文件夹 建一个4号的Vat文件夹 接下来先导入FBX 这次同样 同样第一件事就是检查动画 大概就是这样了 FBX导入好了。
- 知识点：纹理也一起导入了 通常都是先做这个 先看看设置 把Night Knight关掉 纹理尺寸现在超过1万了。
- 知识点：尺寸超过8K也不一定出问题 不过出问题的概率会高些 所以我拿更重的烘焙资源试了一下 所以上次做模拟时 最后尺寸还是超了8K 之前改过那部分。
- 知识点：这部分是直接拿来没改过的 就当是没改过的版本就行 差不多了 脚本动作里选SDR 其余都选HDR就好 这次我们用的是第二部用过的Fluid。
- 知识点：Mesh Period 这部分复制过来 然后应用上还挺适合的 有些地方能复用 不过这处已经用遮罩设成不透明了 这次要做的是像果冻一样微微透光的半透明材质。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Sequencer`、`材质`、`纹理`、`贴图`、`序列`。

**关键画面：**

这张图处在本页 `00:00:05-00:04:41 Sequencer、VAT、SD` 小节开头，展示的是把上一页做好的 VAT 流体资源整理到本节工程目录中的准备画面。当前主体不是 Niagara 或材质节点，而是一个打开在 Unreal 编辑器前景上的 Windows 资源管理器窗口。

已确认信息：
- 后景是 Unreal Editor 主界面，左侧 `Content Browser` 当前位于 `Content > Signature > Course_07`。
- `Course_07` 目录下已预先建好 4 个子文件夹：`Mesh`、`Particles`、`Sequencer`、`Texture`，说明本节会把不同类型资源分别整理到这些目录。
- 前景资源管理器当前路径可见为 `Coloso > Part_07 > REC > 강의자료 > 17`。
- 该外部目录中只有 3 个待导入子目录：
  - `data`
  - `geo`
  - `tex`
- 其中 `tex` 文件夹图标带有 `EXR` 标记，说明这里至少包含一组用于 VAT 的高动态范围贴图资源。

这一步的作用是确认本节需要从课程原始资料里取回上一阶段导出的 VAT 结果，再分别导入到 Unreal 的 `Mesh`、`Texture`、`Sequencer` 和粒子工程目录中，作为后续半透明果冻液体材质和时序驱动的基础资源。
这张图仍属于本页第一个小节，展示的是 VAT 资源导入到 `Course_07` 后在 Unreal 内容浏览器里的实际落位情况。当前重点是资源组织，而不是特效实例预览。

已确认信息：
- Unreal 内容浏览器当前位于 `Content > Signature > Course_07`。
- `Course_07` 下已经建立并展开多个子目录：
  - `Level`
  - `Material`
  - `Mesh`
  - `Ex_01_VAT`
  - `Ex_02_VAT`
  - `Ex_03_VAT`
  - `Ex_04_VAT`
  - `Particles`
  - `Sequencer`
  - `Texture`
- 当前高亮选中的是材质资源 `M_FluidVA...`，缩略图呈现为一条细长的红色液体形体，说明它已经绑定到 VAT 网格预览或材质预览球上。
- 上方同一列还能看到已导入的资源类型包括：
  - `Blood_0...` 静态网格
  - `Blood_02_pos` 位置贴图
  - `Blood_02_rot` 旋转贴图
- 右侧视口是空测试关卡，当前只有基础灯光和默认控制器图标，`Outliner` 显示 `0 actors`，说明此时还没有把 VAT 特效正式拖进场景。

这一步可以理解为：先把上一页从 Houdini 导出的网格、位置贴图、旋转贴图和配套材质整理进 `Course_07` 的独立目录，再从这些资源开始构建后续的 Sequencer 播放和半透明果冻液体材质效果。
这张图是第一个小节的落地检查画面：教程已经把一组 VAT 液体资源拖进测试关卡，并同时打开材质实例和至少一张驱动贴图，用来确认导入结果是否正常。

已确认信息：
- 内容浏览器仍位于 `Content > Signature > Course_07`，当前可见的资源已切换到 `Liquid_01` 这一组。
- 可辨认的资源包括：
  - `Liquid_01_mesh`，类型为 `Static Mesh`
  - `Liquid_01_pos`，类型为 `Texture`
  - `Liquid_01_rot`，类型为 `Texture`
  - `M_FluidVAT_02_Ins_...`，类型为 `Material Instance`
- 右侧场景视口里已经放入一个被橙色描边选中的细长液体网格，底部显示移动 Gizmo，说明当前正在直接检查静态网格实例 `Liquid_01_mesh` 的场景表现。
- 右侧 `Details` 面板顶部对象名为 `Liquid_01_mesh`，下方实例层级显示为 `Liquid_01_mesh (Instance)`，证明当前选中的确是场景中的网格实例。
- 底部资源编辑器标签可见同时打开了：
  - `M_FluidVAT_02`
  - `M_FluidVAT_02_Ins_01`
  - `Liquid_01_lookup`
  - `Liquid_01_pos`
  - `Liquid_01_rot`
- 当前前景打开的是 `Liquid_01_pos` 贴图，右侧详情可读到：
  - `Displayed: 4096x11175`
  - `Max In-Game: 4096x11175`
  - `Format: B8G8R8A8`
  - `Format Supports Alpha: True`
  - `Source Alpha Detected: True`

这张图的意义是把“VAT 资源已经导入”推进到“VAT 网格、材质实例和位置/旋转贴图已经在工程里联动可见”。后续做半透明果冻材质时，就是在这套已落场的 `Liquid_01` 资源上继续改材质和时序表现。

### 00:04:41-00:09:18 Alpha、Lerp、Roughness

- 本段定位：Alpha、Lerp、Roughness。
- 知识点：先存一下 然后 接着 这个材质原本设为不透明 现在改成半透明 改一下 直接用上 表面直接沿用 差不多调成半透明其他地方基本不用大改 说不定也差不多就这样了。
- 知识点：毕竟之前那款液体材质做得挺像样的 最关键的一点还得补上 这儿得加个有镀射效果 所以把Lerp模式导入使用用 用Bastiness接Alpha。
- 知识点：填个数 输入数值大概设成1.1 接下来我们用交互功能创建参数并插入 这样大部分效果基本就齐了 高光也是手动添加的 是手动做好的 还有边缘部分边缘颜色也调好了。
- 知识点：再加一个参数用来控制Stretch的强度 因为现在Metallic Specular Roughness还没启用 所以这里 能启用Metallic。
- 知识点：Specular Roughness的 换成Transverse Notch Volume Eye Adaption节点也确实给删掉了 现在基础关卡根本没法精细控制后期处理。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Lerp`、`材质`、`序列`、`颜色`。

**关键画面：**

这张图位于 `00:04:41-00:09:18 Alpha、Lerp、Roughness` 小节，主体是材质 `M_FluidVAT_02` 的 `Material Graph`。当前截图能够可靠确认的是材质域设置和主要连线方向，但中部若干节点名、Pin 文本和部分常量值过小，不能无依据补全，因此本条只记录已确认信息。

可确认的材质设置：
- 左侧 `Details > Material` 中可直接读到：
  - `Material Domain = Surface`
  - `Blend Mode = Masked`
  - `Shading Model = Subsurface`
  - `Two Sided` 未勾选
  - `Use Material Attributes` 未勾选
  - `Cast Ray Traced Shadows` 已勾选
  - `Subsurface Profile = None`
- 底部 `Stats` 区域可读到：
  - `Base pass shader: 206 instructions`
  - `Resources Used: 4`
  - `Resource Limit: 64`
  - `Samplers Used: 1`
  - `Sampler Limit: 32`

节点定义集（仅记录可辨认主体）：
- 左侧有一个 VAT 相关函数/封装节点，输出一组与颜色、Alpha、法线、位移和自定义数据相关的结果，随后被送往右侧材质主输出。
- 中部可辨认出一组用于边缘/高光控制的基础节点，包含：
  - `Fresnel`
  - `Power`
  - 至少一个 `Multiply`
  - 至少一个 `Add`
  - 一组绿色参数节点与白色常量/颜色节点
- 右侧是 Unreal 标准 `Material Output`，可见被连入的插槽至少包括：
  - `Base Color`
  - `Metallic`
  - `Specular`
  - `Roughness`
  - `Opacity`
  - `Opacity Mask`
  - `Normal`
  - `World Position Offset`
  - `Subsurface Color`

连线集（仅记录可确认关系）：
- 顶部几组白色/参数节点直接送入 `Base Color`、`Metallic`、`Specular`、`Roughness` 一带，用于建立液体的基础表面外观。
- VAT 函数节点输出的几路数据分别进入 `Normal`、`World Position Offset` 以及不透明度相关链路，说明该材质仍依赖 VAT 数据驱动形体播放。
- 中部由 `Fresnel` 等节点组成的链路最终并入不透明度或边缘表现相关输入，用于补强液体边缘的视觉层次。

输出/预览：
- 当前截图是在总览缩放很远的材质图状态，重点是“开始从上一页的 VAT 基础材质上继续改外观”，尤其围绕 `Alpha`、`Lerp`、`Roughness` 和边缘高光做处理。
这张图把上一张总览里的材质局部放大到了边缘高光/折射控制链，能够直接读到几组关键参数，说明教程这里正在把原本不透明的 VAT 液体材质改出更像果冻的边缘亮边和折射感。

节点定义集：
- `Edge_Pow`：标量参数，`Default Value = 2.0`
- `Fresnel`：使用 `Edge_Pow` 驱动指数输入
- 常量节点：`Value = 0.0`
- 两个连续的 `Multiply`
- `Edge_Color`：颜色参数，标题可见为 `Param (1,1,1)`，默认是白色
- `SSS_Color`：颜色参数，标题可见为 `Param (1,1,1)`，默认也是白色
- `Refraction_Sti...`：标量参数，标题被截断，但可确认是折射强度相关参数，默认值显示为 `1.1`

连线集：
- `Edge_Pow` 连接到 `Fresnel` 的指数输入，用来控制边缘 Fresnel 过渡有多硬。
- `Fresnel` 的输出进入第一个 `Multiply`。
- 常量 `0.0` 也并入这一段乘法链，说明这里预留了一个可由常量或其他值参与调制的边缘强度入口。
- `Edge_Color` 连接到后续乘法链，把 Fresnel 结果着色成白色边缘光。
- 右上方 `SSS_Color` 也接入同一片区域上方的输出链，用于次表面颜色或表面散射色。
- 右下方 `Refraction_Sti...` 单独作为一条标量控制支路，显然用于后续折射强度输入。

设置/参数：
- `Edge_Pow = 2.0`
- `Edge_Color = (1,1,1)` 默认白色
- `SSS_Color = (1,1,1)` 默认白色
- `Refraction_Sti... = 1.1`

输出/预览：
- 这条局部链的意图很明确：用 `Fresnel` 生成边缘遮罩，用 `Edge_Color` 给边缘加亮色，再配合 `SSS_Color` 和折射强度参数，做出半透明果冻液体在边缘更亮、内部更柔和的观感。
这张图把本节的 VAT 液体资源接入到了关卡时序里。当前打开的是 Sequencer `Ex_04_Fluid`，左侧挂的是角色 `Crunch`，右侧时间轴里已经放入一段攻击动画，并保留了角色生成与 Transform 轨道，说明教程开始把液体效果与角色动作时机同步。

已确认信息：
- 中央窗口标题显示为 `Sequencer*`，右上角序列名为 `Ex_04_Fluid`。
- 顶部时间单位为 `30 fps`。
- 左侧对象树当前主体是角色 `Crunch`，其下展开出：
  - `Animation`
  - `Spawned`
  - `Transform`
- `Spawned` 轨道当前被勾选启用。
- `Animation` 轨道中放入了一段动画片段，名称可辨认为 `Ability_Combo_01_Slow`。
- 该动画片段从时间轴起点附近开始，长度大约覆盖到 `0015` 到 `0030` 左右的刻度区间之后结束。
- 下方 `Transform` 轨道横向贯穿整段时间轴，说明角色位置/旋转在整个序列期间都可以继续做对齐或保持。
- 左侧内容浏览器同时定位在 `ParagonGreystone > Characters > Heroes > Crunch` 附近，可见 `Animations`、`Materials`、`Meshes` 等资源目录，表明当前 Sequencer 驱动的就是这套角色资源。

这一步的作用是把前面准备好的 VAT 液体材质和网格，放到一个有具体角色动作的播放上下文中。也就是说，教程不再只看静态网格和材质，而是开始用 `Ability_Combo_01_Slow` 这段动作来校准液体出现的时机、持续时长和后续果冻效果的节奏。

### 00:09:18-00:13:54 网格、液体

- 本段定位：网格、液体。
- 知识点：我们烘焙到约75帧为止 因此只保留到75帧 我来把长度裁减到75帧 接着我在Codyne里把动作速率缩放到0.8倍 让动作整体变慢 略微拉长了10成。
- 知识点：没错 就是这么处理的 这里也得在最后动作上添加保持 复制一份 接着 把这里对齐到结束帧拉长后 哪怕只用一个动画片段 在第二种方案里角色也能正常播放。
- 知识点：位置参数的话 没必要特意移动可以吧 隐藏关键帧里也免没太大位移 所以不用动 现在就是这个状态了 网格部分就先这样预设好实力化 对齐好了 存一下。
- 知识点：拿画笔我来关掉自动播放 打开喷射帧一下 接下来从这帧开始一点一点把缓动拉过来 播放预览帧一直到第75帧 放进去吧 改成线性模式先试试效果。
- 知识点：现在大小比例对不上得调小点 感觉的这么处理 或者干脆把液体网格放大点试试 把网格本身放大点试试差不多两倍大了 那时候 在后丁尼里顺得很 这效果太带感了。

**关键画面：**

这张图位于 `00:09:18-00:13:54 网格、液体` 小节，展示的是在 Sequencer 中重新校准角色动作节奏，使 VAT 液体播放长度更贴合已经裁到约 75 帧的流体缓存。当前核心不是材质，而是角色动画时间轴。

已确认信息：
- 当前打开的序列仍是 `Ex_04_Fluid`，时间单位为 `30 fps`。
- 左侧主体对象是角色 `Crunch`，其下仍保留：
  - `Animation`
  - `Spawned`
  - `Transform`
- `Animation` 轨道中的动画片段名称仍为 `Ability_Combo_01_Slow`。
- 这段动画片段当前从序列起点附近开始，结束位置大约落在 `0030` 刻度附近。
- 画面字幕明确说明此步是在把动作速率缩放到 `0.8` 倍。
- 绿色播放头位于序列起始区域，而白色垂线停在 `0075` 左右位置，用来对照后续液体播放结束点。

这一步的作用是先把角色动作整体放慢，让角色挥击或身体位移的节奏能够和 75 帧左右的 VAT 液体播放长度更自然地对上，避免液体特效过早结束或与动作错拍。
这张图继续位于 `网格、液体` 小节，主体切换到静态网格编辑器中的 `Liquid_01_mesh`。教程这里在确认 VAT 液体网格本身的规模、材质挂接和几何复杂度，以判断是否需要继续缩放或优化。

已确认信息：
- 打开的资源标签是 `Liquid_01_mesh`。
- 视口中显示的是一团细长、向下拖尾的白色液体形体，说明当前查看的是 VAT 流体网格的某一帧静态形态。
- 左上统计信息可直接读到：
  - `Triangles: 202,874`
  - `Vertices: 608,620`
  - `UV Channels: 2`
  - `Approx Size: 423x331x54`
  - `Num Collision Primitives: 1`
  - `Estimated Compressed Disk Size: 5.05 MB`
- 右侧 `Material Slots` 区域显示：
  - 当前只有 `1 Material Slots`
  - `Element 0` 绑定的材质实例是 `M_FluidVAT_02_Ins_01`
- 右侧 `Nanite Settings` 中 `Enable Nanite Support` 未勾选。
- 底部 `LOD 0` 汇总也再次显示：
  - `Triangles: 202874`
  - `Vertices: 608620`

这一步的作用是从纯几何层面确认当前液体网格已经是一份体量不小的 VAT 结果，并且已经挂上了用于果冻材质调试的 `M_FluidVAT_02_Ins_01`。后面无论是放大网格，还是调半透明/次表面材质，本质上都是在这份网格上继续做表现校准。
这张图是 `网格、液体` 小节的场景级联调画面：角色 `Crunch`、VAT 液体网格 `Liquid_01_mesh` 和 Sequencer `Ex_04_Fluid` 已经放在同一个测试关卡里，可以直接观察液体与角色动作的贴合程度。

已确认信息：
- 场景视口中可见绿色机器人角色 `Crunch` 正处于挥击姿态。
- 一团白色液体网格从角色手臂附近甩出并拖向左侧地面，说明当前 VAT 网格已经被放回角色动作上下文中做同步检查。
- 右侧 `Outliner` 中可见关键对象：
  - `Crunch`
  - `Ex_04_Fluid`
  - `Liquid_01_mesh`
  - `Floor`
- `Outliner` 底部显示当前关卡共有 `11 actors (1 selected)`。
- 下方 Sequencer 仍为 `Ex_04_Fluid`，时间单位 `30 fps`。
- Sequencer 里 `Crunch` 轨道下可见两段同名动画片段 `Ability_Combo_01_Slow`，后一段接在前一段之后，说明教程这里通过复制/延长动画片段来把动作时长铺到更靠后时间。
- `Spawned` 轨道继续启用。
- `Liquid_01_mesh` 已作为独立轨道加入 Sequencer，其下还能看到：
  - `StaticMeshComponent0`
  - `Material Slot Material_0`

这一步的作用是把前面的“动作放慢”和“液体网格检查”合并成一次实际贴合测试：通过在同一个序列里同时控制 `Crunch` 和 `Liquid_01_mesh`，观察液体轨迹的大小、位置和持续时长是否跟角色挥击节奏一致。如果仍不合适，就要继续调动作长度或液体网格尺度。

### 00:13:54-00:18:49 Opacity、颜色、透明度

- 本段定位：Opacity、颜色、透明度。
- 知识点：现在动作和节奏基本都对上了 现在太白了 得给果冻调点质感 先调一下颜色 让效果更真实些 基础色最关键 必须优先处理 通常偏暗一点的色调会更好。
- 知识点：因此加点红 效果就差不多了 还有边缘高光 暂时先关掉 先关掉 看看现在效果是这种 先调到4左右 这种果冻的色泽可以随意调整 挺合适的 可以试试偏紫一点。
- 知识点：带点颜料润染的感觉 这样处理还能做出类似入射光的光影效果 也能营造出类似的光影氛围 还能带出一点逆光的氛围 呈现出来 应该能实现 比蓝色更合适。
- 知识点：我们先 先用Opacity调低透明度 看看会是什么样的视觉效果 效果好像有点出来了 折射也微微有点明显 再调强一点 感觉可能跟透明度强度有关。
- 知识点：我来试试打开次表面 发现看一下效果 现在次表面是关着的 不过我还是先开一下实际测试下效果 不太确定会不会出问题 感觉可能会有点怪。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Opacity`、`颜色`、`透明度`。

**关键画面：**

这张图进入 `00:13:54-00:18:49 Opacity、颜色、透明度` 小节后的第一次实机观察。教程此时没有再展示材质图本身，而是在 Sequencer 里边播放边看场景效果，判断当前液体是否“太白”，是否需要通过透明度和材质参数把果冻质感拉出来。

已确认信息：
- 视口中 `Crunch` 的挥击动作已经与液体网格同步，液体紧贴角色前臂和身体一侧向外甩出。
- 画面中的液体整体仍呈高亮白色，缺少明显染色和半透明层次，这与字幕里“现在太白了，得给果冻调点质感”一致。
- 当前 Sequencer 仍是 `Ex_04_Fluid`，时间单位 `30 fps`。
- `Crunch` 轨道下仍可见两段 `Ability_Combo_01_Slow` 动画片段。
- `Liquid_01_mesh` 已作为独立轨道加入序列，其下可见：
  - `StaticMeshComponent0`
  - `Material Slot: Material_0`
  - `Display Fram...`
  - `Spawned`
  - `Transform`
- `Display Fram...` 轨道当前显示的值约为 `60.503796`，说明教程正在用帧索引驱动 VAT 网格播放到指定液体形态。
- 白色播放头位于 `0060` 左右位置，对应当前场景中液体已经甩开、但仍附着在角色附近的时刻。

这一步的作用是用场景结果反推材质还需要继续调 `Opacity`、颜色和边缘表现。也就是说，当前不是改动作节奏，而是确认“液体网格虽然对上了，但视觉上还过白、过实，需要进一步调成更像果冻的半透明表现”。
这张图打开的是材质实例 `M_FluidVAT_02_Ins_01` 的参数面板，教程在这里直接调实例参数，把之前偏白的液体改成更偏红紫、带边缘高光和折射感的果冻材质。

设置/参数：
- `Global Scalar Parameter Values`
  - `Edge_Pow = 4.0`
  - `Edge_Str = 1.0`
  - `Metalic = 0.0`
  - `Opacity = 1.0`
  - `Refraction_Str = 1.1`
  - `Roughness = 0.0`
  - `Spec = 0.0`
  - `Spec_Intensity = 1.0`
  - `Spec_Pow = 1.0`
- `Global Vector Parameter Values`
  - `Base_Color`
    - `R = 0.05`
    - `G = 0.0`
    - `B = 0.1`
    - `A = 1.0`
  - `Edge_Color`
    - `R = 1.0`
    - `G = 0.0`
    - `B = 0.0`
    - `A = 1.0`
  - `Spec_Color`
    - `R = 0.0`
    - `G = 0.0`
    - `B = 0.0`
    - `A = 1.0`
- 下方还能看到 `SSS_Color` 参数组标题，但具体值在这张图里没有完整露出。

输出/预览：
- 左侧预览窗中的液体不再是纯白，而是出现了明显的红紫主体和亮红边缘，说明本次调参已经把颜色重心从白色改到了更像果冻/血浆的暖色系方向。
- 结合参数看，当前材质思路是：
  - 用深紫红的 `Base_Color` 控制主体内部颜色
  - 用纯红 `Edge_Color` 强调边缘亮带
  - 保持 `Roughness = 0.0` 和 `Refraction_Str = 1.1`，让表面更光滑、更有折射感
  - 把 `Edge_Pow` 提到 `4.0`，让边缘 Fresnel 效果更集中

这一步可以直接作为实例参数复建基线：如果场景里的液体仍偏白或层次不足，可以先把参数调到这组值，再继续微调透明度和次表面表现。
这张图是上一张材质实例调参后的场景结果回看。液体已经不再是纯白，而是整体转成了偏紫红的半透明色调，并且沿着角色挥击轨迹形成一整条拖曳带，用来判断颜色、透明度和次表面方向是否接近教程想要的“果冻感”。

已确认信息：
- 视口中 `Crunch` 正处于同一段挥击动作中，液体仍从角色手臂和身体一侧甩向左后方地面。
- 液体整体颜色已经明显变成深紫/紫红色，不再是前面白色高亮的状态。
- 液体内部出现大量细长丝状、碎裂状结构，边缘和中空区域更明显，说明在提高颜色与透明表现后，网格细节被更直接地暴露出来。
- 左侧内容浏览器中仍能看到当前这组资源：
  - `Liquid_01_mesh`
  - `Liquid_01_pos`
  - `Liquid_01_rot`
  - `M_FluidVAT_02_Ins_01`
- 底部前景窗口仍停在 `M_FluidVAT_02_Ins_01*`，说明场景结果是直接由刚才那组实例参数驱动出来的。

输出/预览：
- 这张图说明调完 `Base_Color`、`Edge_Color`、`Refraction_Str` 和边缘参数后，液体的颜色氛围已经更接近果冻或染色液体。
- 但从实际视口效果看，当前结果也带来了更明显的线状、稀薄和孔洞感，因此后续还需要继续围绕 `Opacity`、次表面或其他表面参数做平衡，避免液体看起来过于干瘦或破碎。

### 00:18:49-00:23:17 Opacity、颜色、透明度

- 本段定位：Opacity、颜色、透明度。
- 知识点：折射值好像太深了 有种层层叠叠的感觉 要不调低一点试试 感觉有点频次 表面还是关了吧 感觉实在不太理想 有点让人摸不清 感觉有点不太对劲 先说一下Opacity现在太白了。
- 知识点：我适当调高一点数值加点透明感就行 我来调一下 这么一看 射到0.9透明度 也看得出来 不过0.8左右可能更合适 感觉0.8左右可能还更顺眼些。
- 知识点：这种接缝处裂纹还挺明显的 裂得挺深的 但以紧贴表面看 看着反倒没那么明显 差不多 就这个程度 刚好合适 差不多了 或者再微调一下1.1左右就是上限了。
- 知识点：感觉可以了 但如果加的太猛 现在的立体感反而不够 会显得有些单薄 提高高光强度 把基础高光值适当提升 略微上调后反射明显 增强立体感也立刻凸显出来。
- 知识点：加上0.5的高光值质感会偏向橡胶 完全没反光了 现在就是这种效果 带点反光效果的 带点反光的质感和液体感更搭 模糊值差多少 差别其实不大。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Opacity`、`颜色`、`透明度`。

**关键画面：**

这张图位于 `00:18:49-00:23:17 颜色` 小节，主体是材质实例 `M_FluidVAT_02_Ins_01` 的参数面板。教程在这里继续从“偏红紫”的上一版往下调，把液体主体保留在紫色系，同时把边缘色改成更冷的青绿色，并同步降低透明度强度。

设置/参数：
- `Global Scalar Parameter Values`
  - `Edge_Pow = 4.0`
  - `Edge_Str = 1.0`
  - `Metalic = 0.0`
  - `Opacity = 0.5`
  - `Refraction_Str = 1.05`
  - `Roughness = 0.0`
  - `Spec = 0.0`
  - `Spec_Intensity = 1.0`
  - `Spec_Pow = 1.0`
- `Global Vector Parameter Values`
  - `Base_Color`
    - `R = 0.05`
    - `G = 0.0`
    - `B = 0.1`
    - `A = 1.0`
  - `Edge_Color`
    - `R = 0.0`
    - `G = 0.05`
    - `B = 0.02`
    - `A = 1.0`
  - `Spec_Color`
    - `R = 0.0`
    - `G = 0.0`
    - `B = 0.0`
    - `A = 1.0`

输出/预览：
- 左侧预览里的液体已经从上一批的暖红边缘，转成了“紫色主体 + 青绿色边缘”的冷暖对比。
- `Opacity` 从前面的 `1.0` 降到 `0.5` 后，预览中的液体层次更轻，边缘和内部条带的分离感更明显。
- `Refraction_Str` 也从 `1.1` 微调到 `1.05`，说明教程在颜色切换的同时，略微收敛折射强度，避免画面过分夸张。

这一步可以直接作为这一小节的颜色版基线：主体保留深紫，边缘转为微亮青绿，再配合较低 `Opacity`，让果冻液体更接近带冷色反光的半透明质感。
这张图是上一张颜色参数修改后的场景结果检查。液体已经从前一批的偏红紫观感，转成以更冷的紫色为主体，并沿 `Crunch` 的手臂和身体一侧形成更明显的果冻拖挂感。

已确认信息：
- 场景中的 `Crunch` 仍处于挥击中段，液体大面积附着在右臂、胸腹和大腿附近，并向右前方地面拖出长条状痕迹。
- 液体整体主色已明显偏向深紫/紫罗兰色，和上一批偏暖红的版本相比更冷。
- 地面上能看到被拉长的细线状残留和液滴状碎片，说明当前透明度降低后，液体的内部空洞和细条结构更加显眼。
- 左侧内容浏览器里仍是同一组 `Liquid_01_mesh`、`Liquid_01_pos`、`Liquid_01_rot`、`M_FluidVAT_02_Ins_01` 资源。
- 底部窗口仍停留在 `M_FluidVAT_02_Ins_01*`，表明当前场景效果直接对应刚才那组实例参数。

输出/预览：
- 这张图说明主体颜色切换已经生效，液体的整体气质从“白色/红色果冻”转向“偏紫的魔法液体”。
- 不过从实际视口看，青绿色边缘在当前光照和透明度下并不特别强，画面主要还是由紫色主体主导；同时线状拖丝和地面残线感更明显，因此后续仍需要继续平衡高光、透明度和边缘色强度。
这张图是 `颜色` 小节末尾的再一次平衡结果：上半部分是场景里紫色液体挂在角色身上的实机表现，下半部分则继续停在 `M_FluidVAT_02_Ins_01` 的参数面板，说明教程此时是一边看场景，一边微调透明度和高光。

可确认的参数变化：
- `Global Scalar Parameter Values` 中当前能直接读到：
  - `Edge_Pow = 4.0`
  - `Edge_Str = 1.0`
  - `Metalic = 0.0`
  - `Opacity = 0.8`
  - `Refraction_Str = 1.1`
  - `Roughness = 0.0`
- 下方 `Spec` 行的值栏正在被编辑，当前画面可见值为 `1.0`，说明这一阶段已经开始把高光强度往上补，而不再保持前一张图里的低高光状态。

场景结果：
- 紫色液体仍主要集中在 `Crunch` 的右臂、胸腹和腿部附近，并拖出一串向右下方延伸的丝状残线。
- 与上一张相比，当前液体主体看起来更饱满一些，不像 `Opacity = 0.5` 时那样过于稀薄；这和此处把 `Opacity` 提回 `0.8` 一致。
- 细丝和残线依然明显，说明高透明和点位稀疏的问题还在，但主块体已经比上一张更有厚度。

输出/预览：
- 这一步反映的是“颜色定下来之后，再把透明度和高光稍微拉回去”，避免液体因为过于透明而只剩下很多空心丝线。
- 因此这一张可以理解为从 `Opacity = 0.5` 的试验版，回调到更可用的中间值，并开始重新补高光，让紫色果冻既有色相，也保留一定体量和反光感。

### 00:23:17-00:26:23 颜色

- 本段定位：颜色。
- 知识点：高光适当调高一点对比更明显 对比出来了边缘色有点淡 适当提亮一点颜色 带点青绿色的光泽 我心想这样试试看怎么样 嗯 边缘色先这么着吧 还有。
- 知识点：加点看看不合适 随时改 为了多点立体感 我们把之前随便做的高光加进来 把之前随便做的高光加进来 因为刚才颜色被压低了。
- 知识点：调低了 给压下去了 这部分适当带点粉感一加就亮得不得了 毕竟亮度值现在是1 毕竟亮度值现在是1 调高一点 得再调高点高光 适当调一下就行 这玩意儿多少还是有点微微发颤。
- 知识点：主要是VT资源本身的点位本来就有点少 因为地图真的点位所以一直在变 所以一直会有轻微晃动 再加上这种果冻一样的特性本来就会有点晃 这类东西晃得更明显。
- 知识点：这部分确实有点可惜 不过 能做出这种感觉也就凑合了 效果应该不错 所以建议优先从视频角度来处理 这类资源用起来更顺手 先加了点高光 别把高光调得太猛 别太夸张 别加太多 反而更出效果。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这张图进入 `00:23:17-00:26:23 透明度` 小节后的第一张场景检查。当前仍是一边看角色身上的液体形态，一边在 `M_FluidVAT_02_Ins_01` 参数面板里微调表面属性，用来判断透明层次是否过头，以及块体感是否足够。

可确认的参数：
- `Global Scalar Parameter Values` 中可见：
  - `Edge_Pow = 4.0`
  - `Edge_Str = 1.0`
  - `Metalic = 0.2`
  - `Opacity = 0.8`
  - `Refraction_Str = 1.1`
  - `Roughness = 0.0`

场景结果：
- 视口里液体集中附着在 `Crunch` 右臂外侧，形成一块较厚的紫色主团，前缘像被甩出的块状果冻，而不是纯细丝。
- 与前一张相比，这一帧的主体块体感更强，中间的半透明体积也更明显，说明透明度并没有继续往更低方向走。
- 右下方仍保留一些下垂和拖丝结构，表明网格细节与点位稀疏问题仍会在边缘处暴露出来。

这一步可以理解为：在维持 `Opacity = 0.8` 的前提下，尝试提升一点表面金属/反光属性，让液体团块更有“压实感”和表面质感，而不是过于空心发飘。
这张图是 `透明度` 小节中的材质实例精调界面，当前重点已经从整体透明度转向“高光不要太弱、但也不能太夸张”的平衡。教程直接在 `M_FluidVAT_02_Ins_01` 里大幅提高高光强度，并把边缘色偏到更亮的黄绿色。

设置/参数：
- 顶部当前可见的标量参数：
  - `Spec = 1.0`
  - `Spec_Intensity = 10.0`
  - `Spec_Pow = 1.0`
- `Global Vector Parameter Values`
  - `Base_Color`
    - `R = 0.05`
    - `G = 0.0`
    - `B = 0.1`
    - `A = 1.0`
  - `Edge_Color`
    - `R = 0.03`
    - `G = 0.05`
    - `B = 0.0`
    - `A = 1.0`
  - `Spec_Color`
    - `R = 0.0`
    - `G = 0.0`
    - `B = 0.0`
    - `A = 1.0`
  - `SSS_Color`
    - `R = 0.0`
    - `G = 0.0`
    - `B = 0.0`
    - `A = 1.0`

输出/预览：
- 左侧预览中的液体不再主要显示深紫，而是被更亮的浅黄绿高光和浅色边缘大幅提亮，说明当前高光调得已经非常猛。
- 边缘色从前一张的偏青绿，进一步推向了带黄感的亮绿色，符合字幕里“稍微带点粉感/一加就亮得不得了”的试验语境。
- `Spec_Intensity = 10.0` 是这张图的核心变化，它说明教程正在故意把高光拉高到一个偏激进的值，先看上限，再决定是否回调。

这一步的作用不是给出最终值，而是验证“高光拉高后会亮到什么程度”。后续如果场景结果显得过曝或塑料感过重，就需要再把这组高光和边缘亮度适当收回来。
这张图是 `透明度` 小节末尾的进一步强化版参数快照。当前画面同时保留了场景上方的紫色液体结果，以及下方 `M_FluidVAT_02_Ins_01` 的参数面板，说明教程在继续把边缘强度和高光集中度往上推，测试更强烈的表面表现。

设置/参数：
- `Global Scalar Parameter Values`
  - `Edge_Pow = 4.0`
  - `Edge_Str = 5.0`
  - `Metalic = 0.2`
  - `Opacity = 0.8`
  - `Refraction_Str = 1.1`
  - `Roughness = 0.0`
  - `Spec = 1.0`
  - `Spec_Intensity = 10.0`
  - `Spec_Pow = 100.0`
- `Global Vector Parameter Values`
  - `Base_Color`
    - `R = 0.05`
    - `G = 0.0`
    - `B = 0.1`
    - `A = 1.0`
  - `Edge_Color`
    - `R = 0.03`
    - `G = 0.05`
    - `B = 0.0`
    - `A = 1.0`

输出/预览：
- 左下预览中的液体已经被拉成非常亮的浅黄绿边缘，并伴随尖锐的高光过渡，说明 `Edge_Str = 5.0` 和 `Spec_Pow = 100.0` 会让边缘光和镜面反射高度集中。
- 上方场景里仍能看到角色右侧附着的紫色液体，但本图更强调参数极值试验，而不是最终场景审美结果。

这一步的作用是验证高光和边缘强化后的上限效果：
- `Edge_Str = 5.0` 让边缘表现显著增强。
- `Spec_Intensity = 10.0` 配合 `Spec_Pow = 100.0`，会得到更尖锐、更集中的高光。
- 在保持 `Opacity = 0.8` 不变的前提下，这套参数会把液体推向更亮、更有硬表面反射感的方向，后续需要根据场景结果决定是否回调，避免失去果冻的柔软感。

### 00:26:27-00:29:37 透明度

- 本段定位：透明度。
- 知识点：接下来叠加的部分最关键就是3s色加进去大概就是紫色 方向光得往看的方向反方向打压力感才更明显 看起来有点太过了 比我们原本设想的 还适当偏强了些。
- 知识点：带点红调 所以打算压低一点显然受光面 亮得非常明显 这种果冻质感的效果我们设为0.01的分离度 虽然已经设为0.01左右的分离度 但适当调高一点再简化处理效果可能更好。
- 知识点：这种在各部位像珠网般蔓延开来的效果 特别神奇是个绝佳的参考范例 差不多快完成了透明度再降一点的话 就会更柔和些 这感觉有点别扭 倒是真有那么点。
- 知识点：还真是有点 这个感觉其实挺到位的 差0.1就差这么多。
- 核对对象：`透明度`。

**关键画面：**

这张图位于 `00:26:27-00:29:37 透明度` 段末，主体仍是材质实例 `M_FluidVAT_02_Ins_01` 的参数面板。教程这里继续做最后一轮细调，把高光颜色改成偏粉白，同时核对 Houdini VAT 相关播放开关是否按预期启用。

设置/参数：
- `Global Vector Parameter Values`
  - `Base_Color`
    - `R = 0.05`
    - `G = 0.0`
    - `B = 0.1`
    - `A = 1.0`
  - `Edge_Color`
    - `R = 0.03`
    - `G = 0.05`
    - `B = 0.0`
    - `A = 1.0`
  - `Spec_Color`
    - `R = 1.0`
    - `G = 0.8`
    - `B = 1.0`
    - `A = 1.0`
  - `SSS_Color`
    - `R = 0.0`
    - `G = 0.0`
    - `B = 0.0`
    - `A = 1.0`
- `Houdini VAT`
  - `Auto Playback` 已勾选
  - `Display Frame = 1.0`
  - `Two Sided Normals` 已勾选
  - `Support Surface Normal Maps` 未勾选
  - `Positions Require Two Textures` 未勾选

输出/预览：
- 左侧预览中的液体仍保持浅黄绿边缘高光，但高光色本身已经从纯白/无色高光转成了带粉感的亮色，这和正文里“稍微带点粉感”的描述一致。
- 这说明教程不是只调强度，也在通过 `Spec_Color` 的色相把高光从机械反光拉向更有风格化质感的彩色高光。

这一步的作用是完成材质实例的收尾校准：主体仍是紫色液体，边缘保留黄绿色调，同时给高光加入一层偏粉白色彩，并确认 VAT 材质实例会自动播放、默认从第 1 帧开始。
这张图是材质与灯光联调后的场景结果检查。教程此时不再只盯着材质实例参数，而是直接在关卡里观察液体挂到 `Crunch` 身上后的整体镜头效果，同时选中方向光作为主要补光对象。

已确认信息：
- 视口中 `Crunch` 呈大幅前倾姿态，紫色液体仍主要附着在右臂、肩部、胸腹和腿部，并向左后方地面拖出长条状残迹。
- 当前选中对象是 `DirectionalLight`，右侧 `Details` 面板顶部显示 `DirectionalLight (Instance)`。
- `Outliner` 中可见关键对象仍包括：
  - `Crunch`
  - `Ex_04_Fluid`
  - `Liquid_01_mesh`
  - `DirectionalLight`
- 右侧 `Transform` 可读到方向光当前：
  - `Location = (0.0, 0.0, 400.0)`
  - `Rotation ≈ (112.360, -49.5171, -120.306)`
  - `Scale = (1.0, 1.0, 1.0)`
- 视口上方能看到方向光 Gizmo 的一部分，说明教程确实在直接调整光线方向，而不是仅靠材质参数改变观感。

输出/预览：
- 这张图说明最终液体效果不只靠材质值本身，还依赖方向光角度来把边缘高光和体积层次“打出来”。
- 在当前角度下，液体仍保持深紫主体和细丝残线，但角色手臂和液体接触区域的亮面已经更容易被读出来，因此教程才会在最后阶段把灯光也纳入调节范围。
这张图是上一张灯光联调后的近景结果观察。镜头几乎贴到液体主团前方，液体在角色身前形成一大块厚实的紫色胶状体，用来确认最终镜头下是否真的有“果冻块体”而不只是远景丝线。

已确认信息：
- 视口前景被一大块紫色半透明液体占据，液体块体已经遮住了 `Crunch` 身体的大半部分，只剩角色右侧和后方局部仍可见。
- 液体表面能看到明暗分层和局部高亮区，说明当前材质与方向光组合已经足以在近景里表现出体积厚度。
- 右侧 `Outliner` 仍保持：
  - `DirectionalLight`
  - `Crunch`
  - `Ex_04_Fluid`
  - `Liquid_01_mesh`
- 右侧当前选中对象仍是 `DirectionalLight (Instance)`，说明这张图延续的是上一张的灯光角度，而不是又切回纯材质参数测试。

输出/预览：
- 这张图证明当前这套液体不只是线状残迹，在某些播放帧和镜头角度下，确实能形成一个足够厚、足够占屏的果冻主团。
- 对教程来说，这一步相当于验证最终“看镜头”的结果：如果近景成立，后面就可以把它当作一个足够 usable 的演示版 `Fluid` 结果收尾。

### 00:29:41-00:30:42 Fluid

- 本段定位：Fluid。
- 知识点：这程度就先到这里 再加个镜头 加上后这效果就差不多了 反正Claus和Fluid模拟也就做个简单演示到这程度就差不多了 接下来再说 下次课我们就用这些技巧把画面做得更有质感。
- 知识点：像电影一样 要是能做出可导演的示范案例 到时候就来个高质量的视觉呈现 到那时不再拘泥于游戏资源的限制 放手用上所有能用的资源 全力提升画面质量。

**关键画面：**

这张图进入 `00:29:41-00:30:42 Fluid` 收尾段，主体重新回到 Sequencer `Ex_04_Fluid`。教程在这里不是再改材质，而是在最终演示阶段整理时间轴、液体播放帧以及镜头节奏，准备把这一段 fluid 演示作为一个完整镜头收尾。

已确认信息：
- Sequencer 名称仍为 `Ex_04_Fluid`，时间单位 `30 fps`。
- `Crunch` 轨道下仍保留两段 `Ability_Combo_01_Slow` 动画片段。
- `Liquid_01_mesh` 轨道已加入序列，其下可见：
  - `StaticMeshComponent0`
  - `Material Slot: Material_0`
  - `Display Fram...`
  - `Spawned`
  - `Transform`
- 当前 `Display Fram...` 行可读到数值约为 `33.649174`，说明此时正在直接用帧索引定位液体主团出现的具体时刻。
- 白色播放头位于 `0033` 左右，绿色起始线仍在 `0000`。
- 字幕明确提到“再加个镜头”，说明这一段重点是把已有角色动作和液体播放组织成更完整的镜头展示，而不是新增模拟内容。

这一步的作用是把前面所有材质、灯光和流体形态调整，真正落到一个可播放的收尾镜头上。也就是说，教程认为当前 fluid 演示已经够用，接下来只需要在 Sequencer 里把时间点和镜头衔接好。
这张图把“再加个镜头”真正落到了 Sequencer 中。当前视口左上角显示已进入 `Pilot Actor: CineCameraActor`，下方时间轴也新增了 `Camera Cuts` 轨道，说明教程已经把最终 fluid 展示切换到电影机位视角来做收尾。

已确认信息：
- 视口顶部显示 `Pilot Actor: CineCameraActor`，表示当前正在直接从电影机位观察画面，而不是普通编辑器透视视角。
- `Outliner` 中新增并可见：
  - `CineCameraActor`
  - `Crunch`
  - `Ex_04_Fluid`
  - `Liquid_01_mesh`
- `Outliner` 底部显示当前场景共有 `12 actors (1 selected)`，比前面多出一个相机对象。
- 下方 Sequencer 仍为 `Ex_04_Fluid`，时间单位 `30 fps`。
- 时间轴最上方新增：
  - `Camera Cuts`
  - `CineCameraActor`
- 当前 `CineCameraActor` 片段从序列起始处延续到后方，白色播放头位于 `0048` 左右。
- 右侧仍选中 `DirectionalLight (Instance)`，说明镜头接入后，灯光仍然是当前在微调或保留的关键对象。

输出/预览：
- 这张图说明教程最终不是把 fluid 当成单纯的编辑器演示，而是进一步包装成一个有相机切换的镜头段落。
- 在这个电影机位下，液体拖痕、附着块体和角色动作关系都被压缩进更明确的构图里，因此更接近最终展示用的成片视角。
这张图是 `p22.md` 主关键画面的最终收尾效果。当前仍处于 `Pilot Actor: CineCameraActor` 视角下，角色、液体主团、地面拖痕和灯光方向都已经整理到一个稳定的最终展示状态。

已确认信息：
- 视口左上角仍显示 `Pilot Actor: CineCameraActor`。
- `Outliner` 中仍同时存在：
  - `CineCameraActor`
  - `DirectionalLight`
  - `Crunch`
  - `Ex_04_Fluid`
  - `Liquid_01_mesh`
- 右侧当前选中对象仍是 `DirectionalLight (Instance)`，说明镜头和灯光方案已经一起固定下来。
- 画面中 `Crunch` 的右臂和身体一侧被紫色液体包裹，液体向左侧地面甩出大量细长残痕，并在角色脚边留下更厚的淤积块体。
- 这一帧的液体没有像 `S07_3` 那样完全占满近景，而是回到一个更容易读出角色动作和液体关系的中景构图。

输出/预览：
- 这张图可以视为本页主流程的最终成片视角：角色动作仍清楚可辨，液体既有附着块体，也有拖挂残痕，颜色保持为深紫主体，符合前面多轮材质与灯光调整后的最终方向。
- 对当前教程来说，这一帧已经足以作为“简单 fluid 演示完成”的总结性结果，后面再往上提升就属于下一课想做的更高质量镜头包装，而不是本页必须继续修改的基础流程。

## 补充视觉证据

### S01 00:01:11

这是第一个小节的补充视觉证据图，用来补强 `Liquid_01_mesh` 在静态网格编辑器里的原始参数状态。它不是最终果冻材质效果，而是更早一步的网格资源检查画面。

已确认信息：
- 当前打开的资源是 `Liquid_01_mesh`。
- 视口中显示的是一团尚未套用最终液体材质外观的灰色/噪点状网格形态。
- 左上统计信息可直接读到：
  - `Nanite Enabled`
  - `Current Screen Size: 0.915426`
  - `Nanite Triangles: 202,874`
  - `Nanite Vertices: 608,620`
  - `Fallback Triangles: 256`
  - `Fallback Vertices: 766`
  - `UV Channels: 2`
  - `Distance Field: 84x63x28`
  - `Approx Size: 423x315x154`
  - `Num Collision Primitives: 1`
  - `Estimated Compressed Disk Size: 3.01 MB (2.99 MB Nanite)`
- 右侧 `Material Slots` 中当前：
  - 只有 `1 Material Slots`
  - `Element 0` 绑定的是 `WorldGridMaterial`
- 右侧 `Nanite Settings` 中可直接看到：
  - `Enable Nanite Support` 已勾选
  - `Lerp UVs` 已勾选
  - `Position Precision = Auto`
  - `Normal Precision = Auto (8 bits)`
  - `Keep Triangle Percent = 100.0`
  - `Trim Relative Error = 0.0`

这张补图的关键补充点是：教程最初检查 `Liquid_01_mesh` 时，已经启用了 `Nanite`，但材质槽里仍只是默认 `WorldGridMaterial`。也就是说，这一步主要是在验证原始 VAT 网格资源本身的几何规模和 Nanite 状态，最终的 `M_FluidVAT_02_Ins_01` 材质挂接是在后续步骤里完成的。

### S02 00:06:01

这是 `00:04:41-00:09:18 Alpha、Lerp、Roughness` 小节的补充材质局部图，补强的是 `M_FluidVAT_02` 中高光颜色、次表面颜色和一条 `Lerp` 混合支路的实际连线位置。

节点定义集：
- `Spec_Color`：颜色参数，标题可见为 `Param (1,1,1)`，默认白色
- `SSS_Color`：颜色参数，标题可见为 `Param (1,1,1)`，默认白色
- `Multiply`
- 常量节点：`Value = 0.0`
- `Lerp(1)`：
  - `A = 1.0`
  - `B` 输入已连接
  - `Alpha` 输入已连接
- 右侧是材质主输出局部，可见：
  - `Ambient Occlusion = 1.0`
  - `Refraction (IOR, from Material F0 if Unplugged) = 1.0`
  - `Customized UV0 = (0.0, 0.0)`
  - `Customized UV1 / UV2 / UV3` 均有连线接入
- 底部 `Stats` 可读到：
  - `Base pass vertex shader: 558 instructions`
  - `Resources Used: 12`
  - `Samplers Used: 5`
  - `Sampler Limit: 32`

连线集：
- `Spec_Color` 的输出接入上方一组白线网络，用于控制高光颜色分支。
- `SSS_Color` 的输出单独接入一条指向右侧材质输出的白线，说明它直接参与次表面或散射颜色相关输出。
- 中部 `Multiply` 的输出进入 `Lerp(1)` 的 `B` 端。
- 常量 `0.0` 接到 `Lerp(1)` 的 `Alpha` 端。
- `Lerp(1)` 的输出再送往右侧材质主输出链。

设置/参数：
- 当前这个补图最关键的显式参数是：
  - `Spec_Color = (1,1,1)`
  - `SSS_Color = (1,1,1)`
  - `Lerp(1).A = 1.0`
  - 常量 `0.0`

输出/预览：
- 这张补图说明教程并不是只靠 `Base_Color` 和 `Edge_Color` 做最终外观，材质里还额外保留了 `Spec_Color` 与 `SSS_Color` 两路颜色参数，用于分别控制高光与次表面相关表现。
- 同时，这条 `Multiply -> Lerp(1)` 支路也证明材质里确实存在一段可调的混合逻辑，而不是所有值都直接硬连到输出端。

### S02 00:07:32

这是同一段材质图的进一步补充局部，主要补强 `Metallic`、`Spec`、`Roughness`、`Opacity` 四个标量参数与材质主输出之间的直接连接关系，同时给出当前半透明材质的部分面板设置。

节点定义集：
- `Metalic`：标量参数，`Default Value = 0.0`
- `Spec`：标量参数，`Default Value = 0.0`
- `Roughness`：标量参数，`Default Value = 0.0`
- `Opacity`：标量参数，`Default Value = 1.0`
- 多个 `Multiply`
- `Add`
- `Spec_Color`：颜色参数，`Param (1,1,1)`，默认白色
- `SSS_Color`：颜色参数，`Param (1,1,1)`，默认白色
- 右侧材质主输出可见插槽：
  - `Base Color`
  - `Metallic`
  - `Specular`
  - `Roughness`
  - `Emissive Color`
  - `Opacity`
  - `Normal`
  - `World Position Offset`
  - `Subsurface Color`
  - `Ambient Occlusion = 1.0`
  - `Refraction (IOR, from Material F0 if Unplugged)`
  - `Customized UV0 / UV1 / UV2 / UV3`

连线集：
- `Metalic` 直接连接到主输出 `Metallic`。
- `Spec` 直接连接到主输出 `Specular`。
- `Roughness` 直接连接到主输出 `Roughness`。
- `Opacity` 直接连接到主输出 `Opacity`。
- 中部两级 `Multiply` 后接一个 `Add`，再并入这片输出网络，说明除基础标量值外，还存在一组额外叠加的表面控制支路。
- `Spec_Color` 与 `SSS_Color` 仍通过多条白线接入高光和次表面相关分支。

设置/参数：
- 左侧 `Details` 中当前可见的半透明相关设置为：
  - `Lighting Mode = Surface TranslucencyVolume`
  - `Directional Lighting Intensity = 1.0`
  - `Apply Fogging` 已勾选
  - `Apply Cloud Fogging` 未勾选
  - `Compute Fog Per Pixel` 未勾选
  - `Translucency Pass = After DOF`
- 底部 `Stats` 仍可读到：
  - `Base pass vertex shader: 558 instructions`
  - `Resources Used: 12`
  - `Samplers Used: 5`

输出/预览：
- 这张补图把前一张里还不够明确的“哪些值直接进材质主输出”补全了，证明教程这里确实是用显式参数去控制 `Metallic / Specular / Roughness / Opacity` 四个核心表面属性。
- 结合左侧 `Lighting Mode = Surface TranslucencyVolume`，可以确认这套果冻液体材质最终是按半透明体积表面去做，而不是简单不透明或纯加法发光材质。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。

