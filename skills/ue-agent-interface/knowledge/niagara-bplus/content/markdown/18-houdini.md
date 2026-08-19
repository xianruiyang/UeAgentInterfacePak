# 18.Houdini碰撞环境设置

# 18.Houdini碰撞环境设置

## 关键术语

- `Sequencer`、`Houdini`、`SD`、`网格`、`碰撞`、`贴图`、`纹理`、`破碎`、`ASY_BPP_ChasmStairs_Angled_C+Add`、`VAT`、`Niagara`、`Add`、`材质`、`系统`、`蓝图`、`用户参数`、`Niagara System`、`Emitter`

## 分段知识

### 00:00:06-00:04:49 Houdini、网格、碰撞

- 本段定位：Houdini、网格、碰撞。
- 知识点：大家好,这是18号课程的问候 这次是最后一个实例,得把桥模型带过来整理一下 所以这次我们直接从这里开始 把模型带过来后,应用破坏模拟和物理模拟。
- 知识点：再重新导入Vet 之前我们也做过类似的墙体破坏操作 之前没给周边背景加碰撞体 这次需要一并带上背景的碰撞体 让破坏效果更完整 需要同步演示位置参数和Houdini与Unreal的联动流程。
- 知识点：这样大家理解起来会更轻松 所以我特意准备了这个案例 天上落下一颗陨石,砸中桥梁的瞬间 桥体便轰然坍塌,营造出强烈的视觉冲击 视角可以自由调整。
- 知识点：只不过这边就用一个远距离俯瞰的视角来制作 周围下方的岩石也要加上碰撞体 让它们在倒塌时能真实的碎裂,配合模拟效果 处理好旧型背景网格现在特别复杂。
- 知识点：这些杂乱的部分 还有,底下那些误效、灯光之类的都关掉或隐藏起来 顺便把场景也清理一下 这里误效太多,全都移除掉 按之前做法设为不可见。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Houdini`、`碰撞`。

**关键画面：**

这一帧是新案例开始时的场景整理画面。教程先在 Unreal 里定位桥梁区域，确认后续要做坍塌模拟的主体网格和周围碰撞体都处于可管理状态，然后再把这部分导出到 Houdini 做破碎与物理模拟。

当前主视口可直接确认：

- 视图模式为 `Perspective`
- 画面中心是通往桥体的台阶/桥面区域
- 场景里已经显示出大量白色线框和体积边界，用于辅助确认碰撞或场景范围
- 地面下方有明显的绿色发光/雾效区域，说明场景里还残留需要后续清理或隐藏的环境效果

左侧内容浏览器当前定位在：

- `Course_08`

其下可直接看到的目录包括：

- `Cache`
- `Material`
- `Mesh`
- `Particles`
- `Sequencer`
- `Test`
- `Texture`
- `VAT`

右侧 `Outliner` 当前可直接确认：

- 当前层级位于 `Main (Editor) > Chasm`
- 展开了 `Chasm_BlockingVolumes`
- 其中可见多项 `BlockingVolume`，说明教程正在关注桥周围背景碰撞体的整理
- 另一个相关文件夹为 `Chasm_BPs`

当前选中的对象是：

- `ASY_BPP_ChasmStairs_Angled_C...`

右侧 `Details` 面板可直接确认：

- 对象实例为 `ASY_BPP_ChasmStairs_Angled_01_N1 (Self)`
- `Transform`：
  - `Location = (8299.52, 1287.77, 942.799)`
  - `Rotation = (0.0, 0.0, 0.0)`
  - `Scale = (1.0, 1.0, 1.0)`
- `Mobility = Static`
- `Visible = true`

这张图可以直接还原出的操作是：

1. 先在桥梁场景中选中关键桥体/楼梯蓝图实例，确认这是本次坍塌案例的主体区域。
2. 同时检查 `BlockingVolumes` 层级，准备把周边背景碰撞体也一起纳入后续整理和导出流程。
3. 在正式做 Houdini 破碎前，先把场景里与主体无关的杂项效果、灯光或环境残留逐步筛掉，避免干扰后续模拟与镜头搭建。
这一帧展示的是场景清理中的“误效排除”步骤。教程已经从桥体本身切到下方的环境雾效/遮罩平面，准备把镜头里无关、又会干扰后续坍塌表现的场景特效先隐藏掉，而不是直接删除。

当前主视口可直接确认：

- 视图仍为 `Perspective`
- 左侧能看到桥梁台阶边缘
- 下方与中部充满亮绿色雾光效果
- 场景里仍存在大量辅助线和边界线框，说明当前仍在编辑/筛选阶段
- 一个大尺寸矩形平面被橙色描边选中，覆盖在绿色雾效区域前方

右侧 `Outliner` 当前可直接确认：

- 当前层级位于 `Main (Editor) > Chasm`
- 已展开 `Chasm_Fog`
- 其中可见：
  - `Labyrinth_Fog`
  - `LocalFogVolume`
  - `LocalFogVolume2`
  - `LocalFogVolume3`
  - 多个 `Plane` 对象

当前选中的对象是：

- `Plane46`

右侧 `Details` 面板可直接确认：

- 对象实例为 `Plane46 (Instance)`
- 组件为 `StaticMeshComponent`
- `Rendering` 分类下：
  - `Visible = true`
  - `Hidden in Game = false`

这张图可以直接还原出的操作是：

1. 进入 `Chasm_Fog` 层级，专门挑出构成绿色环境雾效或遮罩的平面物体。
2. 当前先选中单个 `Plane46` 检查它的可见性控制项，而不是直接销毁对象。
3. 通过逐个或成组关闭这类雾效平面的 `Visible` / 游戏内显示状态，把桥梁坍塌案例中不需要的背景特效先隐藏，避免它们抢镜或影响后续镜头判断。
这一帧继续同一轮场景清理，但对象已经从雾效平面切换到灯光。教程当前在 `Chasm_Lights` 层级里直接选中一盏聚光灯，并检查其 `Visible` 开关，准备把桥下这类会干扰坍塌案例观感的原场景照明逐步关闭或隐藏。

当前主视口可直接确认：

- 视图仍为 `Perspective`
- 桥梁台阶通向远处桥体的主体构图保持不变
- 画面里出现明显的白色扇形灯光可视化锥体，说明当前选中的是一盏 `SpotLight`
- 下方绿色环境发光仍存在，说明这一阶段仍在持续清除旧场景中的视觉干扰项

右侧 `Outliner` 当前可直接确认：

- 当前层级位于 `Main (Editor) > Chasm`
- 已展开 `Chasm_Lights`
- 其中可见一组按序编号的聚光灯：
  - `Chasm_SpotLight_10`
  - `Chasm_SpotLight_11`
  - `...`
  - `Chasm_SpotLight_19`
  - `Chasm_SpotLight_20`
  - `Chasm_SpotLight_21`
  - `Chasm_SpotLight_22`

当前选中的对象是：

- `Chasm_SpotLight_19`

右侧 `Details` 面板可直接确认：

- 对象实例为 `Chasm_SpotLight_19 (Instance)`
- 组件为 `SpotLightComponent`
- `Rendering` 分类下：
  - `Visible = true`
  - `Actor Hidden In Game = false`

这张图可以直接还原出的操作是：

1. 从 `Chasm_Lights` 层级逐盏筛查原场景灯光，而不是只处理网格和碰撞。
2. 先选中具体的聚光灯实例 `Chasm_SpotLight_19`，确认它确实还在参与照明。
3. 通过 `Visible` / `Actor Hidden In Game` 这类显示控制项，把会干扰后续陨石击桥和坍塌镜头表现的原场景灯光逐步关掉，为后面重新搭镜头和特效留出干净基础。

### 00:04:49-00:09:45 Sequencer、网格、贴图

- 本段定位：Sequencer、网格、贴图。
- 知识点：摄像机视角会这样设定,先建好序列器和摄像机 画面范围会拉得更宽 可能需要这样,为了更宽的视野,先大致定在这里 后续再聚焦到这边就行。
- 知识点：我先暂存一下 序列器先搁一边,这里的样条线对象先临时隐藏一下 还有墙上这些带纹理的图案也都是贴图。
- 知识点：这些碎片之后会碎裂并移动,到时候贴图会显得特别突兀 所以全部贴图都设为隐藏 我打算直接清掉,一个个手动选太费劲了,另外得检查一下物效。
- 知识点：看起来像是承担了物效功能,地面空洞显得杂乱,反正摄像机看不到 从这个角度,这部分根本不会进镜头,只要保持这个仕图范围就不会有问题。
- 知识点：接下来也打算继续隐藏着操作删了的话以后万一还要用,就不好找了 万一后面用得上,先关掉可见性 连同这部分现在就得挑出真正需要的网格体了。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Sequencer`、`纹理`、`贴图`、`序列`。

**关键画面：**

这一帧延续上一批的场景清理，但这里已经直接执行到“关闭原场景灯光”的动作。教程继续在 `Chasm_Lights` 目录里逐个筛查聚光灯，针对桥下绿色深渊区域中会进入镜头或影响气氛判断的灯，直接关闭其可见性，而不是保留默认照明。

当前主视口可直接确认：

- 视图仍为 `Perspective`
- 镜头俯看桥面与下方深渊区域
- 画面中心存在一组从一点向四周发散的白色灯光可视化射线，说明当前选中的仍是一盏 `SpotLight`
- 桥下仍是明显的绿色发光环境，说明旧场景光效尚未完全清理干净

右侧 `Outliner` 当前可直接确认：

- 当前层级位于 `Main (Editor) > Chasm > Chasm_Lights`
- 可见一组连续编号的 `Chasm_SpotLight_17` 到 `Chasm_SpotLight_25`
- 下方还能看到另一个文件夹 `Chasm_SMS`

当前选中的对象是：

- `Chasm_SpotLight_23`

右侧 `Details` 面板可直接确认：

- 对象实例为 `Chasm_SpotLight_23 (Instance)`
- 组件为 `SpotLightComponent`
- `Rendering` 分类下：
  - `Visible = false`
  - `Actor Hidden In Game = false`

这张图可以直接还原出的操作是：

1. 继续在 `Chasm_Lights` 中逐盏处理旧场景灯光。
2. 当前针对 `Chasm_SpotLight_23`，已经把 `Visible` 取消勾选，使它不再参与编辑器中的照明显示。
3. 这样做的目的是尽快把桥体坍塌案例里不需要的环境打光清掉，让后续搭远景镜头和破碎表现时，画面只保留真正需要的照明与特效。
这一帧已经从灯光清理切换到墙面/岩面贴图清理。教程明确在 `Chasm_Decals` 层级里逐个处理 Decal 贴图，因为这些表面贴图一旦挂在后续会被破碎、移动的碎片上，就会在镜头中显得非常突兀，所以要先整体隐藏。

当前主视口可直接确认：

- 视图仍为 `Perspective`
- 当前镜头对着桥对面的岩壁与桥拱区域
- 右下可见一个带绿色线框的 Decal 投射盒体，说明当前选中的对象是贴花投射器
- 场景中仍能看到零散绿色裂纹式发光细节，但整体亮度已比前面清理灯光时更克制

右侧 `Outliner` 当前可直接确认：

- 当前层级位于 `Main (Editor) > Chasm > Chasm_Decals`
- 其中存在大量同名/同类的 Decal 条目：
  - `MI_D_Rock_Patch_ui2lcaufw ...`
- 当前高亮选中的也是这一组岩面补丁贴图中的一个实例

当前选中的对象与细节面板可直接确认：

- 顶部对象名：`MI_D_Rock_Patch_ui2lcaufw_4_...`
- 实例名：`MI_D_Rock_Patch_ui2lcaufw_4_N15 (Instance)`
- 组件类型：`Decal (NewDecalComponent)`
- `Decal Material` 使用的是 `MI_D_Rock_Pat...`
- `Sort Order = 0`

这张图可以直接还原出的操作是：

1. 进入 `Chasm_Decals` 层级，把桥梁周边岩壁上的贴花/贴图对象单独筛出来。
2. 当前先选中一块 `MI_D_Rock_Patch...` Decal，确认它确实是通过 Decal 投射到场景表面的贴图补丁。
3. 按正文所说，把这类贴图整体设为隐藏，避免它们在后续桥体破碎、碎片位移后继续黏在碎片表面，导致画面出现不合理的贴图残留。
这一帧已经从隐藏灯光、隐藏贴图，推进到“挑出真正需要保留的网格体”这一步。教程开始在 `Chasm_SMs` 中直接多选桥梁相关静态网格，按镜头是否真的会看到、以及后续是否需要参与破碎或保留结构，来决定哪些网格继续保留、哪些先排除。

当前主视口可直接确认：

- 视图仍为 `Perspective`
- 镜头正对桥体的一段栏杆/边缘结构
- 一组桥梁构件被橙色轮廓同时选中，说明当前不是单个对象，而是多选筛选状态
- 画面中的背景岩壁已经相对干净，说明前面的灯光与贴图清理已经起到作用

右侧 `Outliner` 当前可直接确认：

- 当前层级位于 `Main (Editor) > Chasm > Chasm_SMs`
- 列表中可见多种桥体相关静态网格名称，例如：
  - `SM_SpikeNose_01_N3`
  - `SM_SpikeNose_01_N4`
  - `SM_SpikeNose_01_N5`
  - `SM_SpikeNose_01_N6`
  - `SM_SpikeNose_01_N7`
  - `SM_SpikeNose_01_N8`
  - `SM_SpikeNose_01_N9`
  - `SM_SpikeNose_01_N15`
  - `SM_SpikeNose_01_N29`
  - `SM_StairArch_01_N2`
  - `SM_StairArch_01_N3`

右侧 `Details` 面板可直接确认：

- 当前为 `12 objects` 的多选状态
- `Transform` 的 `Location / Rotation / Scale` 均显示为 `Multiple`
- `Mobility = Static`
- `Static Mesh` 显示为 `Multiple Values`
- `Materials` 区域可见 `Display 5 materials`

这张图可以直接还原出的操作是：

1. 从 `Chasm_SMs` 中开始按批筛选桥梁结构网格，而不是继续处理特效辅助对象。
2. 当前一次多选了 12 个桥梁相关静态网格，说明教程在按结构分组整理可见对象。
3. 这一步的目标是只保留镜头里真正会用到、并且后续需要导出到 Houdini 或参与破碎的网格，为下一阶段的分组、导出所选和碰撞整理做准备。

### 00:09:45-00:14:41 Houdini、SD、网格

- 本段定位：Houdini、SD、网格。
- 知识点：在这种状态下再继续选 继续选择那些嵌在中间深处的石头 直接删掉更省事,这次也照这个方法做 反复切换隐藏与显示,就能清楚看到哪些没被选中做到这一步就够了。
- 知识点：把桥及关联对象选好后,右键点击,直接分组,这样就会生成组演员 选中这个组演员后,就能一键全选,操作起来也更方便 直接隐藏即可 接下来,分组后还会剩下一些。
- 知识点：或是之前因重复而未被选中的对象,那些也一并合并到一组,就分成了两个组 桥的部分则单独管理,这样处理比较合适,这个对象仅做遮蔽用途。
- 知识点：这些已选对象直接通过导出所选功能导出 作为圆,将设置网格命名为BridgesDot出 导入后,把这些图案都分成两组 或许,在Houdini中可直接选择所需部分使用即可。
- 知识点：我们用导出所选把这组网格导入,位置信息会完整保留到Houdini中 所以背景物体的位置信息必须保留,这点很关键 先隐藏掉 接下来要处理的是下方这些将作为碰撞体的部分。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`Houdini`、`碰撞`。

**关键画面：**

这一帧继续桥体静态网格筛选，但选择范围已经从栏杆边缘推进到真正要参与桥梁主体管理的一组结构件。教程此时是在把桥面、桥柱和关联支撑件按组整理出来，准备后面做分组、隐藏和导出所选。

当前主视口可直接确认：

- 视图仍为 `Perspective`
- 画面中心是一段横向桥体主体结构
- 桥体下方能看到支撑岩石/立柱区域
- 当前没有再显示大面积灯光锥体或 Decal 投射盒，说明焦点已经转到纯网格筛选

右侧 `Outliner` 当前可直接确认：

- 当前层级位于 `Main (Editor) > Chasm > Chasm_SMs`
- 当前高亮区域包含一组桥梁主结构相关静态网格：
  - `SM_BridgeColumn_01_N2`
  - `SM_BridgeColumn_01_N3`
  - `SM_BridgeColumn_03_N2`
  - `SM_BridgeColumn_03_N3`
- 上方还能看到其他环境网格名称，例如：
  - `SM_Beach_Boulder_...`
  - `SM_Beach_Rock_...`

右侧 `Details` 面板可直接确认：

- 当前为 `12 objects` 的多选状态
- `Transform` 的 `Location / Rotation / Scale` 均显示为 `Multiple`
- `Mobility = Static`
- `Static Mesh = Multiple Values`
- `Materials` 区域可见 `Display 5 materials`

这张图可以直接还原出的操作是：

1. 在 `Chasm_SMs` 中把桥体主体网格从环境岩石等杂项网格里单独拎出来。
2. 当前一次选中了 12 个对象，核心是桥柱/桥身类静态网格，说明教程在建立“桥体主组”的候选集合。
3. 这一步的目的，是为后面的右键分组、整体隐藏和 `Export Selected` 做准备，让桥梁主体与背景碰撞体、遮挡体分开管理。
这一帧已经从单纯筛选网格推进到“分组后导出所选”。教程把桥体相关对象整理成组后，直接调用 Unreal 的导出窗口，把当前选中的那一组静态网格导出为 FBX，供 Houdini 后续导入，并保留原始世界位置。

当前可直接确认的导出窗口信息：

- 窗口标题：`Export`
- 当前保存路径位于：
  - `Ultra Touch (F:) > Resource > Static_Mesh > Part_08 > Test`
- 文件类型：`FBX File (*.fbx)`
- 文件名输入框当前前缀可见为：
  - `Ex_05_Br...`

右侧 `Outliner` 当前可直接确认：

- 当前层级位于 `Main (Editor) > Chasm > Chasm_SMs`
- 列表中可见两个 `GroupActor`
- 当前还可见桥体相关静态网格条目，如：
  - `SM_ArchTop_01_N3`
  - `SM_ArchWay_01_N4`
  - `SM_BasicSpike_01_N2`
  - `SM_BasicSpike_01_N3`

右侧 `Details` 面板可直接确认：

- 当前为 `19 objects` 的多选状态
- `Transform` 的 `Location / Rotation / Scale` 均为 `Multiple`
- `Actor Hidden In Game = false`
- `Collision` 分类当前处于可见状态，说明这批对象后面还会继续用于碰撞相关整理

这张图可以直接还原出的操作是：

1. 先把桥体及其关联网格通过分组方式整理成可整体管理的对象集合。
2. 在组整理完成后，直接执行 `Export Selected`，把当前所选桥体结构导出成 FBX。
3. 导出目录被单独放在 `Static_Mesh/Part_08/Test` 下，说明教程在为 Houdini 准备一份独立的桥体输入文件，用于后续只处理真正需要的网格，同时保留原始位置信息。
这一帧已经从桥体主体导出，切换到“下方将作为碰撞体的部分”筛选。教程当前多选的是一批下方岩石/尖岩网格，这些对象并不是桥本体的一部分，但它们的位置需要保留，并作为 Houdini 里物理碰撞或遮挡参考使用。

当前主视口可直接确认：

- 视图仍为 `Perspective`
- 画面中央是一块高耸的尖岩/岩柱结构
- 该岩石轮廓被橙色描边，说明它属于当前多选集合中的一个代表对象
- 画面中仍有世界辅助线与边界线，说明此时仍在精筛碰撞候选网格

右侧 `Outliner` 当前可直接确认：

- 当前层级位于 `Main (Editor) > Chasm > Chasm_SMs`
- 当前高亮的是一批名称相近的岩石网格实例：
  - `SM_venrdcgga_RM_N28`
  - `SM_venrdcgga_RM_N29`
  - `SM_venrdcgga_RM_N30`
  - `SM_venrdcgga_RM_N31`
  - `SM_venrdcgga_RM_N32`
- 上方还能看到其他环境岩石类网格，如：
  - `SM_vdssailfa_RM_N53`
  - `SM_vdssailfa_RM_N54`
  - `SM_vdssailfa_RM_N55`
  - `SM_vdssailfa_RM_N56`
  - `SM_vdsailfa_RM_N57`

右侧 `Details` 面板可直接确认：

- 当前为 `21 objects` 的多选状态
- `Transform` 的 `Location / Rotation / Scale` 均显示为 `Multiple`
- `Mobility = Static`
- `Static Mesh = Multiple Values`
- `Materials` 区域可见 `Display 4 materials`

这张图可以直接还原出的操作是：

1. 从 `Chasm_SMs` 中继续筛选桥下和周边岩石网格，专门建立碰撞参考用的环境集合。
2. 当前一次多选了 21 个岩石对象，说明教程在把一整批背景岩石整理成后续可整体导出或隐藏的组。
3. 结合正文“背景物体的位置信息必须保留”“接下来要处理的是下方这些将作为碰撞体的部分”，这批岩石的核心作用不是参与主桥体破碎，而是把真实环境位置带入 Houdini，作为碰撞体或空间参考。

### 00:14:41-00:19:33 网格

- 本段定位：网格。
- 知识点：根据是否靠看得见来选,操作更高效 到这一步基本没问题 毕竟这些网格是不需要,只需要在中间的网格中选择,然后在中间的网格中选择 到这一步基本没问题。
- 知识点：毕竟这部分在下面,带太多网格会导致顶点太多,用多边形模拟时会很卡 所以得确认是否都选好了,有没有多选这部分在内部,可以不选 这部分有点欠得深,之前怎么选的记不清了,靠近点再选一次就行。
- 知识点：其实碎片往后面飞的不多,前面飞散的多,后面基本不用管,容易让人搞混 这地方怎么突然被选上了,有点懵 去胡迪尼里删掉也行 我们需要的只有这根柱子和前面的网格,这部分留着就好,就选到这。
- 知识点：我来试选一下,再检查一遍有没有漏掉的。

**关键画面：**

这一帧是碰撞参考网格筛选的细化阶段。教程已经选中一大批桥周围岩石/地形碰撞网格，但开始根据是否真的需要参与模拟与碰撞来做删减；如果误选了对象，就按住 `Ctrl` 把它从当前多选集合里去掉。

当前主视口可直接确认：

- 视图仍为 `Perspective`
- 画面左侧是桥梁台阶与桥面边缘
- 画面右侧和前景是大块岩石/地形网格
- 多块岩石轮廓被橙色描边，说明当前正在处理一组碰撞候选网格

右侧 `Outliner` 当前可直接确认：

- 当前层级位于 `Main (Editor) > Chasm > Chasm_SMs`
- 当前高亮的是一批同类岩石网格实例：
  - `SM_ulqbb1ga_RM_N134`
  - `SM_ulqbb1ga_RM_N137`
  - `SM_ulqbb1ga_RM_N139`
  - `SM_ulqbb1ga_RM_N145`
  - `SM_ulqbb1ga_RM_N150`
  - `SM_ulqbb1ga_RM_N156`

右侧 `Details` 面板可直接确认：

- 当前为 `29 objects` 的多选状态
- `Transform` 的 `Location / Rotation / Scale` 均显示为 `Multiple`
- `Mobility = Static`
- `Static Mesh = Multiple Values`
- `Materials` 区域可见 `Display 6 materials`

这张图可以直接还原出的操作是：

1. 按批选中桥边与下方的岩石/碰撞网格，建立一份较大的候选集合。
2. 在这个基础上继续人工精简，判断哪些岩石真的需要保留为碰撞体，哪些只是内部、过深或不会影响镜头结果的冗余网格。
3. 如果误选对象，就按住 `Ctrl` 从当前多选集合中取消选择，这也是教程此时强调的具体操作方式。
这一帧说明碰撞参考网格的筛选范围还在继续扩大，但选择标准依然是“只保留真正有用、且会影响前方碎裂与碰撞结果的部分”。教程开始把更大面积的崖壁/悬崖地形也纳入候选，再从中剔除太深、太远或不会进入主要受力区域的网格。

当前主视口可直接确认：

- 视图仍为 `Perspective`
- 画面中央与上方是一大片崖壁/洞窟内壁区域
- 一整块大范围悬崖轮廓被橙色描边，说明当前选择的已不只是小块岩石，而是更大体量的地形网格
- 右下仍能看到前景岩石体块，说明教程在对近景与中景的碰撞地形一起检查

右侧 `Outliner` 当前可直接确认：

- 当前层级位于 `Main (Editor) > Chasm > Chasm_SMs`
- 当前高亮的是一批同名悬崖类静态网格：
  - `SM_Desert_Western_Cliff_Sl...`
- 其下方还能看到：
  - `SM_Gravel_Ground_4`

右侧 `Details` 面板可直接确认：

- 当前为 `34 objects` 的多选状态
- `Transform` 的 `Location / Rotation / Scale` 均显示为 `Multiple`
- `Mobility = Static`
- `Static Mesh = Multiple Values`
- `Materials` 区域可见 `Display 7 materials`

这张图可以直接还原出的操作是：

1. 不只筛选零散岩石，还把大块崖壁/悬崖地形一起纳入碰撞候选。
2. 当前这批对象主要来自 `SM_Desert_Western_Cliff...`，说明教程在判断整块崖壁是否需要作为 Houdini 里的碰撞参考。
3. 结合正文“这部分在下面，带太多网格会导致顶点太多”“内部的可以不选”，这一步的核心是在碰撞完整性和模拟负担之间做取舍，避免把无意义的大量地形网格一股脑带进多边形模拟。
这一帧是本段筛选工作的收尾复查。教程在前面扩大并精简了一轮崖壁碰撞网格后，继续对当前集合做最后核对，确认是否还有多选、漏选，尤其检查前景和中部真正会影响碎片飞散方向的那部分岩石是否都被保留下来。

当前主视口可直接确认：

- 视图仍为 `Perspective`
- 画面中央是一整块前景至中景的岩石/崖壁结构
- 大范围岩体轮廓仍被橙色描边，说明当前仍在编辑同一批碰撞候选网格
- 前景右下还能看到额外岩石体块，说明教程正在核对周围相邻岩石是否需要一并纳入

右侧 `Outliner` 当前可直接确认：

- 当前层级仍位于 `Main (Editor) > Chasm > Chasm_SMs`
- 当前高亮对象继续来自同一组岩石网格：
  - `SM_ulqbb1ga_RM_N139`
  - `SM_ulqbb1ga_RM_N145`
  - `SM_ulqbb1ga_RM_N150`
  - `SM_ulqbb1ga_RM_N156`
  - `SM_ulqbb1ga_RM_N157`
  - `SM_ulqbb1ga_RM_N162`
  - `SM_ulqbb1ga_RM_N165`
  - `SM_ulqbb1ga_RM_N167`
  - `SM_ulqbb1ga_RM_N170`

右侧 `Details` 面板可直接确认：

- 当前为 `31 objects` 的多选状态
- `Transform` 的 `Location / Rotation / Scale` 均显示为 `Multiple`
- `Mobility = Static`
- `Static Mesh = Multiple Values`
- `Materials` 区域可见 `Display 6 materials`

这张图可以直接还原出的操作是：

1. 在上一张扩大的候选集合基础上，再做一次人工复查与删减。
2. 当前对象数从更大的候选规模回落到 `31 objects`，说明教程已经移除了部分不需要的内部或冗余崖壁网格。
3. 这一轮复查的目标，是只保留前方和关键受力方向上的碰撞网格，为后面的导出、Houdini 破碎和物理模拟提供足够但不过量的环境参考。

### 00:19:33-00:20:55 网格、破碎

- 本段定位：网格、破碎。
- 知识点：别折,我来把这里也用组网格合并一下,记得打开日志 然后像之前一样,用导出所选,把这组网格导出 之前原网格有没有打开记不清了,麻烦先取消勾选这一项再导出。
- 知识点：开了它再导出,偶尔会卡死,导出搞定了 下次在胡迪尼里导入这些网格,挑出需要的部分再做一遍精简处理 接下来做破碎处理,再进行物理模拟,先试试看这期就到这里,谢谢。

**关键画面：**

这一帧进入本篇最后一段“网格、破碎”的收尾整理。教程在前面筛完桥体与碰撞候选网格后，这里开始把最后保留下来的环境岩石集合再集中确认一遍，准备用组或统一导出的方式交给 Houdini 做后续精简、破碎和物理模拟。

当前主视口可直接确认：

- 视图仍为 `Perspective`
- 左侧还能看到桥梁台阶边缘
- 画面中央与下方是桥下的一批岩石/碰撞体区域
- 场景中仍有世界边界辅助线，说明此时还在编辑整理阶段

右侧 `Outliner` 当前可直接确认：

- 当前层级位于 `Main (Editor) > Chasm > Chasm_SMs`
- 当前高亮选中的是一组连续的岩石网格：
  - `SM_venrdcgga_RM_N28`
  - `SM_venrdcgga_RM_N29`
  - `SM_venrdcgga_RM_N30`
  - `SM_venrdcgga_RM_N31`
  - `SM_venrdcgga_RM_N32`
- 下方还能看到同系列其他实例：
  - `SM_venrdcgga_RM_N35`
  - `SM_venrdcgga_RM_N36`
  - `SM_venrdcgga_RM_N38`
  - `SM_venrdcgga_RM_N39`
  - `SM_venrdcgga_RM_N40`

右侧 `Details` 面板可直接确认：

- 当前为 `32 objects` 的多选状态
- `Transform` 的 `Location / Rotation / Scale` 均显示为 `Multiple`
- `Mobility = Static`
- `Static Mesh = Multiple Values`
- `Materials` 区域可见 `Display 6 materials`

这张图可以直接还原出的操作是：

1. 把已经筛选过的桥下岩石/碰撞体对象再收束成一组最终候选集合。
2. 当前这批对象主要由 `SM_venrdcgga_RM_...` 系列组成，说明教程在按同类环境网格做最后整理。
3. 这一步的目标，是在导出前确保真正需要带入 Houdini 的环境碰撞体都在当前集合里，避免遗漏关键支撑岩石或把无关对象混进去。
这一帧已经进入环境碰撞体那一组的正式导出步骤。教程不只是打开保存窗口，而是进一步弹出了 `FBX Export Options`，并明确要求把某个选项先取消勾选后再导出，以避免之前提到的导出异常或卡死问题。

当前可直接确认的 `Outliner` 状态：

- 搜索框中输入的是：`group`
- 当前只显示 `Chasm_SMs` 下的 `3` 个 `GroupActor`
- 当前高亮选中的是其中一个 `GroupActor`

右侧 `Details` 面板可直接确认：

- 当前组内为 `30 objects`
- `Transform` 的 `Location / Rotation / Scale` 均显示为 `Multiple`
- `Actor Hidden In Game = false`

中央 `FBX Export Options` 窗口可直接确认：

- 当前文件：`F:/Resource/Static_Mesh/Part_08/Test/Ex_05_Env_01.fbx`
- `Vertex Color`：勾选
- `Level Of Detail`：未勾选
- `Static Mesh > Collision`：未勾选
- `Static Mesh > Export Source Mesh`：当前处于未勾选状态
- 鼠标悬浮提示显示：`False`
- `Export Morph Targets`：勾选
- `Export Preview Mesh`：勾选
- `Map Skeletal Motion to Root`：未勾选
- `Export Local Time`：勾选
- `Bake Camera and Light Animation = Bake Transforms`

这张图可以直接还原出的操作是：

1. 先通过 `group` 过滤器快速定位前面整理好的环境碰撞体分组。
2. 对这一组执行 FBX 导出，输出文件命名为 `Ex_05_Env_01.fbx`，对应环境/碰撞参考用的那份网格。
3. 在导出前，明确把 `Export Source Mesh` 取消勾选后再导出；结合正文“麻烦先取消勾选这一项再导出”“开了它再导出，偶尔会卡死”，这一步就是为避免导出问题而做的必要设置。
这一帧是本篇主流程的结束状态。导出窗口已经关闭，教程回到场景视图，用 `group` 过滤结果再次确认当前环境碰撞体分组仍然存在，说明桥体与环境两类网格都已经整理并导出完毕，下一步就会把这些网格带到 Houdini 里做进一步精简、破碎和物理模拟。

当前主视口可直接确认：

- 视图仍为 `Perspective`
- 左侧保留桥梁台阶边缘
- 中部与右侧是已整理好的环境岩石/崖壁组
- 当前选中的环境岩石轮廓仍被橙色描边，说明导出完成后又回到组对象做最终确认

右侧 `Outliner` 当前可直接确认：

- 搜索框中仍为：`group`
- 当前只显示 `Chasm_SMs` 下的 `3` 个 `GroupActor`
- 当前高亮选中的是其中一个 `GroupActor`

右侧 `Details` 面板可直接确认：

- 当前组内为 `30 objects`
- `Transform` 的 `Location / Rotation / Scale` 均显示为 `Multiple`
- `Actor Hidden In Game = false`
- `Net Load on Client = true`
- `Collision` 分类处于可见状态

这张图可以直接还原出的结果是：

1. 环境碰撞体这一组已经整理完成，并且导出流程已经走通。
2. 教程在导出后再次回到 `GroupActor` 检查当前分组对象数和场景位置，确保没有因为导出或筛选过程把组弄乱。
3. 结合正文“导出搞定了，下次在胡迪尼里导入这些网格，挑出需要的部分再做一遍精简处理，接下来做破碎处理，再进行物理模拟”，这张图对应的就是 Unreal 侧准备工作的收尾确认。

## 补充视觉证据

### DOC 00:10:08

这张补充视觉证据图用于强调 `S03` 那一段的一个筛选原则：嵌在中间深处、不会直接影响前方坍塌和碰撞表现的石头，可以直接从当前候选集合里去掉，以减少后续带入 Houdini 的网格负担。

当前主视口可直接确认：

- 视图仍为 `Perspective`
- 画面中央是一块竖直的岩石/石柱结构
- 其上方和左侧还有更大块的岩体边缘同样被橙色描边
- 右上与左侧可见多枚带紫色箭头的小图标，说明当前区域周围仍存在编辑器辅助标记或场景对象指示

右侧 `Outliner` 当前可直接确认：

- 当前层级位于 `Main (Editor) > Chasm > Chasm_SMs`
- 当前高亮的是一批 `SM_vdssailfa_RM_...` 系列岩石网格：
  - `SM_vdssailfa_RM_N42`
  - `SM_vdssailfa_RM_N43`
  - `SM_vdssailfa_RM_N44`
  - `SM_vdssailfa_RM_N45`
  - `SM_vdssailfa_RM_N46`
  - `SM_vdssailfa_RM_N47`

右侧 `Details` 面板可直接确认：

- 当前为 `16 objects` 的多选状态
- `Transform` 的 `Location / Rotation / Scale` 均显示为 `Multiple`
- `Mobility = Static`
- `Static Mesh = Multiple Values`
- `Materials` 区域可见 `Display 6 materials`

这张图可以直接还原出的操作是：

1. 在桥下环境岩石筛选过程中，专门观察那些埋在中间深处的石块。
2. 当前多选的是一批同类岩石对象，用来判断哪些只是内部填充、哪些真的需要参与碰撞参考。
3. 结合字幕“继续选择那些嵌在中间深处的石头，直接删掉更省事”，这张图要表达的就是：对这类深处岩石不必全部保留，可以直接从候选集合中剔除，以降低后续 Houdini 处理的顶点和模拟负担。

### S03 00:11:57

这张补充视觉证据图补的是 `S03` 导出阶段的保存对话框信息。它说明教程在执行 `Export Selected` 时，是先从磁盘根目录进入目标盘，再准备把当前分组网格输出为 FBX；此时文件名还是临时状态，后续会继续改成更明确的导出命名。

当前可直接确认的保存窗口信息：

- 窗口标题：`Export`
- 当前所在位置：`내 PC > Ultra Touch (F:)`
- 当前目录下可见的文件夹包括：
  - `Coloso`
  - `Document`
  - `Free`
  - `Houdini`
  - `Img`
  - `Resource`
  - `Seagate`
  - `Substance`
  - `Tuatara`
  - `Unreal Projects`
  - `Work`
- 文件名输入框当前为：`Main`
- 文件类型：`FBX File (*.fbx)`

右侧 `Outliner` 当前可直接确认：

- 搜索框中为：`group`
- 当前仅显示 `Chasm_SMs` 下的 `3` 个 `GroupActor`
- 当前高亮选中的是其中一个 `GroupActor`

右侧 `Details` 面板可直接确认：

- 当前组内为 `19 objects`
- `Transform` 的 `Location / Rotation / Scale` 均显示为 `Multiple`
- `Actor Hidden In Game = false`
- `Net Load on Client = true`

这张图可以直接还原出的操作是：

1. 对分组后的网格执行导出时，先从目标磁盘根目录进入，准备再切到最终保存位置。
2. 这一时刻文件名还只是临时的 `Main`，说明教程还没完成最终导出命名，处于“先打开保存对话框，再继续指定路径与名称”的中间步骤。
3. 结合后续主截图里出现的 `Static_Mesh/Part_08/Test` 和 `Ex_05_...` 命名，这张补图的作用就是补证：导出动作确实是从 `GroupActor` 直接发起，并且保存路径与文件名是在导出过程中一步步确定下来的。

### S05 00:20:15

这张补充视觉证据图专门补的是 `S05` 导出阶段的参数状态。相比主截图，它更明确地证明了环境碰撞体分组导出时使用的是 `Ex_05_Env_01.fbx`，并且导出前确实把 `Export Source Mesh` 关闭了。

当前可直接确认的 `Outliner` 与组状态：

- 搜索框中为：`group`
- 当前仅显示 `Chasm_SMs` 下的 `3` 个 `GroupActor`
- 当前高亮选中的是一个 `GroupActor`
- 右侧 `Details` 面板显示当前组内为 `30 objects`

中央 `FBX Export Options` 窗口可直接确认：

- 当前文件：`F:/Resource/Static_Mesh/Part_08/Test/Ex_05_Env_01.fbx`
- `Vertex Color`：勾选
- `Level Of Detail`：未勾选
- `Static Mesh > Collision`：未勾选
- `Static Mesh > Export Source Mesh`：未勾选
- 悬浮提示明确显示：`False`
- `Export Morph Targets`：勾选
- `Export Preview Mesh`：勾选
- `Map Skeletal Motion to Root`：未勾选
- `Export Local Time`：勾选
- `Bake Camera and Light Animation = Bake Transforms`

这张图可以直接还原出的设置结论是：

1. 这一批环境/碰撞参考网格导出的目标文件名已经明确为 `Ex_05_Env_01.fbx`。
2. 导出前需要把 `Export Source Mesh` 设为关闭状态，即 `False`。
3. 这张补图的核心作用就是给主流程提供参数级证据，证明教程不是泛泛地“再导出一次”，而是带着这一条明确的导出选项约束来完成环境组导出。
## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。

