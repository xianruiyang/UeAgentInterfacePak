# 13-1-Unreal导弹爆炸特效制作

# 13-1-Unreal导弹爆炸特效制作

## 关键术语

- `Alpha`、`Material`、`UV`、`Blueprint`、`Actor`、`Static Mesh`、`Mesh`、`Noise`、`蓝图`、`材质`、`Niagara`、`Emitter`、`Spawn Rate`、`Spawn`、`Lifetime`、`纹理`、`Niagara System`、`Opacity`

## 分段知识

### 00:00:04-00:04:41 Material、Mesh、蓝图

- 本段定位：Material、Mesh、蓝图。
- 知识点：这次要做的事情有点多,所以从蓝图设置开始,快速开始吧。
- 知识点：我先去拿纹理资料,总共导入了5张纹理。
- 知识点：标着AXD-1的纹理,就是我们上次制作的那个爆炸纹理。
- 知识点：标着AXP的纹理,是我之前做好的纹理这部分。
- 知识点：我们制作这个纹理时,为了使用从下往上的烟雾方向的摄像机视角, 在速度方向上使用,所以就制作了这个纹理。
- 知识点：这个纹理的话可以认为是使用从顶部视角向下看的这种摄像机视角进行渲染的方式。
- 知识点：这个纹理是为了更容易遞使用,在精灵粒子形态上。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Material`、`纹理`、`贴图`、`粒子`、`蓝图`、`速度`、`烟雾`。

**关键画面：**

本图展示本节在 Unreal 工程中的起始资源准备状态。主视口里是一个海岸/岩石场景，作者准备在这个环境里继续搭建导弹爆炸效果；下方 `Content Browser` 当前定位在：

`Content / Signature / Course_05 / Material`

该目录下当前可直接看到的关键资源包括：
- `Houdini_Flipbook`
- `M_Additive_01`
- `M_Additive_01_Ins_01`
- `M_Additive_01_Ins_02`
- `M_Fire_01`
- `M_Fire_01_Ins_01`
- `M_Fire_01_Ins_02`
- `M_SmokeMV_01`
- `M_SmokeMV_01_Ins_01`
- `M_SmokeMV_01_Ins_02`

这些缩略图里既有单帧或图集形式的爆炸/烟雾纹理，也有对应的材质与材质实例，说明教程一开始就在已有爆炸贴图资产基础上继续搭建，而不是从零生成程序纹理。右侧 `Outliner` 则显示当前场景为 `Beach` 相关环境，并加载了大量雾卡等静态网格对象，作为后续特效测试场景。

对复现而言，这张图确认了第一步不是先做 Niagara，而是先把纹理和材质资源整理到固定目录，并区分基础材质与实例材质。这样后续在蓝图或 Niagara 中引用时，才能直接切换火焰、烟雾和翻页纹理的不同版本。
本图展示作者在 Unreal 中直接检查一张用于爆炸/烟雾效果的图集纹理资源。当前打开的是纹理编辑器，顶部标签可见资源名包括：
- `Exp_01*`
- `Arial_Exp_Smoke_01*`

主预览窗口显示的是一张黑底白烟的多帧图集，单张图里按规则排布了大量烟雾帧，明显是给 Flipbook/SubUV 类材质或粒子动画使用的 sprite sheet，而不是单帧贴图。右侧 `Details` 面板当前可确认的纹理信息为：
- `Imported: 4096x4096`
- `Displayed: 4096x4096`
- `Max In-Game: 4096x4096`
- `Resource Size: 21845 KB`
- `Source Alpha Detected: True`
- `Method: Streamed`
- `Format: DXT5`
- `Format Supports Alpha: True`
- `Combined LOD Bias: 0`
- `Number of Mips: 13`
- `Encode Speed: Final`

下方当前还能看到部分纹理设置：
- `Use Improved Image ...` 启用
- `Flip Green Channel` 关闭
- `Filter = Default (from Texture Group)`
- `Mip Load Options = Default`
- `sRGB Use Legacy Gam...` 关闭
- `Min Alpha = 0.0`

这张图的关键意义是：教程明确依赖已经做好的高分辨率图集纹理，并且这类资源需要保留 Alpha。对复现而言，至少要保证纹理以支持 Alpha 的格式导入，并确认图集尺寸足够容纳多帧烟雾，否则后续材质里的透明边缘和翻页动画都会出问题。
本图补充说明这些爆炸相关材质资源在工程目录中的实际落盘方式。屏幕中央打开的是系统文件管理器，当前路径为：

`Content / Signature / Course_05 / Material`

目录里当前可直接看到的 `.uasset` 文件包括：
- `Houdini_FlipbookUVs.uasset`
- `M_Additive_01.uasset`
- `M_Additive_01_Ins_01.uasset`
- `M_Additive_01_Ins_02.uasset`
- `M_Fire_01.uasset`
- `M_Fire_01_Ins_01.uasset`
- `M_Fire_01_Ins_02.uasset`
- `M_SmokeMV_01.uasset`
- `M_SmokeMV_01_Ins_01.uasset`
- `M_SmokeMV_01_Ins_02.uasset`
- `M_Translucent_01.uasset`
- `M_Translucent_01_Ins_01.uasset`

这说明本节并不是只在 Content Browser 里浏览资源缩略图，而是明确要求把已有的材质、材质实例和用于翻页 UV 的辅助资源统一放进 `Material` 目录。字幕也明确说“Base Over, Material 文件夹里放进去就行”，可理解为将这批基础材质资源整体放到该目录后，再在工程中引用。

对复现而言，这一步的关键不是某个参数，而是目录规范：先保证 `Material` 目录内同时包含基础材质、实例材质以及 `Houdini_FlipbookUVs` 之类的配套资源，后续蓝图、Niagara 或材质函数引用时才不会因为路径或依赖缺失而断开。

### 00:04:41-00:09:18 Alpha、UV、蓝图

- 本段定位：Alpha、UV、蓝图。
- 知识点：但你们没有这个参数集合,所以会显示断开的。
- 知识点：现在可以正确保存材质了。
- 知识点：那部分要怎么添加呢? 在材质中创建一个参数集。
- 知识点：添加一个标量参数。
- 知识点：在参数名中输入二卡。
- 知识点：把现在做的材质参数函数导入使用。
- 知识点：把材质放进去就行了。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Alpha`、`材质`、`发射器`、`蓝图`。

**关键画面：**

本图展示 `M_Refraction_01` 材质的实际图表连接，用来补证本段提到的 `Alpha / UV / 参数` 关系。当前打开的是 `M_Refraction_01 > Material Graph`，左侧 `Details` 面板可确认基础材质设置为：
- `Material Domain = Surface`
- `Blend Mode = Additive`
- `Shading Model = Unlit`
- `Two Sided` 关闭
- `Use Material Attributes` 关闭
- `Cast Ray Traced Shadows` 启用

当前图中可直接辨认的节点与连接关系为：
- `TexCoord[0]`
  - 输出接到 `BreakOutFloat2Components`
- `BreakOutFloat2Components`
  - 其分量继续送入下游插值/计算节点
- `Append`
  - 常量值显示为 `A=0.0, B=1.0`
- 两个 `Lerp`
  - 第一个 `Lerp` 的 `Alpha` 输入由左侧绿色标量参数控制，参数名可见为 `Dissolve`
  - 第二个 `Lerp` 的 `Alpha` 输入来自 `Dynamic Parameter`
- `Dynamic Parameter`
  - 至少启用 `Param1`
- 一个红色纹理采样节点
  - 输出接入材质的 `Normal`
- 一个黑色常量颜色节点
  - 连接到材质右侧的 `Emissive Color`

材质输出节点 `M_Refraction_01` 当前可见已接入的属性包括：
- `Emissive Color`
- `Opacity`
- `Normal`
- `Refraction`

从当前可见结构可以判断，这个材质并不是简单贴图显示，而是通过 `TexCoord`、拆分 UV、`Lerp` 插值和 `Dynamic Parameter` 驱动透明度/折射相关输出。对复现而言，这张图确认了两个关键点：一是本段材质确实依赖粒子传入的动态参数控制效果变化；二是 `Opacity / Refraction / Normal` 都在同一个材质里被联动处理，而不是各自独立的简单常量。
本图展示另一个材质图 `PP_ZoomBlur_02`，它是屏幕空间的后处理材质，而不是普通粒子表面材质。左侧预览球显示出明显的中心模糊/发光边缘；左下 `Details` 面板当前可确认：
- `Material Domain = Post Process`
- `Blend Mode = Translucent`
- `Shading Model = Unlit`
- `Two Sided` 关闭
- `Use Material Attributes` 关闭
- `Cast Ray Traced Shadows` 启用

当前图中可直接确认的节点结构为：
- `ScreenPosition`
  - 输出接到 `SceneTexture:PostProcessInput0` 的 `UVs`
  - 同时分出一路送到中部计算节点
- `SceneTexture:PostProcessInput0`
  - 颜色输出送入上方的运算节点，再进入最终 `Lerp`
- `Alpha` 纹理相关节点 2 个
  - 其中一个是黑底预览
  - 另一个红底预览节点把结果送入中部主计算节点
- `Lerp 360RotFunction`
  - 与 `Alpha`/屏幕位置相关结果共同驱动中部主计算
- 一个中心主函数节点
  - 输入端可见 `Uv`、`angle of entrance`、`intensity`、`Amount`、`Mask exponent`、`DistortionStart`
- `ScreenAlignedUVs`
  - 下游接入一个径向渐变/圆形遮罩函数节点
- 一个径向渐变函数节点
  - 输入端可见 `UVs`、`CenterPosition`、`Radius`、`Density`
- 两个 `Multiply`
  - 分别把中部结果和径向遮罩结果送入最终 `Lerp`
- 最终 `Lerp`
  - 输出连接到材质输出节点 `PP_ZoomBlur_02` 的 `Emissive`

图中还能直接读到的参数值包括：
- 一个标量参数 `Intensity`，`Default Value = 0.0`
- 一个标量参数 `Step`，`Default Value = 32.0`
- 若干常量值 `1.0`

对复现而言，这张图说明教程里的“Alpha、UV”并不只服务于粒子贴图本身，还包含独立的屏幕空间后处理材质：先取 `PostProcessInput0` 的屏幕颜色，再结合 `ScreenPosition/ScreenAlignedUVs`、Alpha 贴图和径向遮罩混合出中心放大/模糊效果，最后从 `Emissive` 输出整张后处理结果。
本图展示材质与蓝图资源已经被放回到第一人称测试流程中。主视口当前处于 `Main (Play In Editor)`，玩家以第一人称拿着武器站在海岸测试场景中，说明这一阶段已经开始在实际可玩环境里验证特效绑定位置和触发逻辑，而不只是编辑材质。

下方 `Content Browser` 当前定位到：

`Content / FirstPerson / Blueprints`

当前可直接看到并参与该流程的蓝图资源有：
- `BP_FirstPersonCharacter`
- `BP_FirstPersonGameMode`
- `BP_FirstPersonProjectile`
- `BP_Pickup_Rifle`
- `BP_Weapon_Component`

其中当前选中的是：
- `BP_Pickup_Rifle`

右侧 `World Settings / Game Mode` 区域还能确认：
- `GameMode Override = BP_FirstPersonGame...`（标签被截断，但明确指向第一人称 GameMode 蓝图）

这张图与前两张材质图配合，说明本段的工作链路是：
1. 先准备或修正材质/纹理/后处理资产
2. 再回到第一人称蓝图测试环境
3. 用武器拾取或武器组件蓝图验证这些资产最终如何挂到实际玩法对象上

对复现而言，这一步确认了“蓝图”不是泛指后续可能会用到，而是已经明确落在 `FirstPerson/Blueprints` 这组武器与角色蓝图里。要让导弹爆炸或枪口相关效果正确触发，至少需要检查 `BP_Pickup_Rifle`、`BP_Weapon_Component` 与第一人称 GameMode/Character 的配套关系。

### 00:09:18-00:13:55 Blueprint、Actor、蓝图

- 本段定位：Blueprint、Actor、蓝图。
- 知识点：现在把步枪数值调好。
- 知识点：那时候思维掉得有点沉重。
- 知识点：现在换成更亮的环境。
- 知识点：步枪没什么要动的。
- 知识点：我们讲蓝图客使用过的方法。
- 知识点：内饰也做过导弹发射器时的发射电。
- 知识点：有些节点需要在拉出节点线的状态下。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Blueprint`、`发射器`、`蓝图`。

**关键画面：**

本图展示进入 `Blueprint、Actor、蓝图` 段后，作者先在场景里整理光照环境，而不是立刻写节点。主视口仍是海岸测试场景，地面上放着一把武器模型；右侧 `Outliner` 搜索框输入了 `light`，说明当前是在快速筛出所有灯光 Actor，准备把测试环境调亮。

`Outliner` 中当前可直接看到并与场景照明相关的条目包括：
- `Dungeon_Lights`
  - `Dungeon_SpotLight12`
  - `Dungeon_SpotLight13`
- `GlobalLighting`
  - `DirectionalLight`
  - `ExponentialHeightFog`
  - `SkyAtmosphere`
  - `SkyLight`
- `MainCorridor`
  - `MainCorridor_Lights`
  - `FirstRoom_SpotLight_1`
- `RitualCorridor`
  - `RitualCorridor_Lights`
  - 多个 `RitualCorridor_SpotLight_*`
  - `PointLight`

下方 `Content Browser` 仍定位在：

`Content / FirstPerson / Blueprints`

并可见这批蓝图资源：
- `BP_FirstPersonCharacter`
- `BP_FirstPersonGameMode`
- `BP_FirstPersonProjectile`
- `BP_Pickup_Rifle`
- `BP_Weapon_Component`

这张图对应的流程含义是：在讲武器或发射器蓝图前，先把场景灯光调到更容易观察特效的位置和亮度。对复现而言，这一步很重要，因为如果测试环境过暗，后续判断枪口、发射、爆炸或命中反馈是否正常会非常困难，容易把照明问题误判成材质或 Niagara 问题。
本图展示 `BP_Weapon_Component` 的 `Event Graph`，核心是在开火输入时做一次射线检测，为后续命中特效或发射逻辑提供位置数据。当前蓝图页签显示：

`BP_Weapon_Component > Event Graph`

左侧 `My Blueprint` 面板可确认：
- 图表
  - `EventGraph`
  - `Event Begin Play`
  - `EnhancedInputAction IA_Shoot`
- 组件/变量
  - `Hit Component`
  - `FirstPersonCharacter`
  - `ProjectileOffset`

当前可见蓝图节点链为：
1. 一个输入事件节点
   - 可见执行引脚 `Pressed / Released`
2. `Get Player Camera Manager`
3. `Get Actor Location`
4. `Get Actor Forward Vector`
5. `Make Literal Int`
   - `Value = 5000`
6. 两个数学运算节点
   - 一个把前向向量与 `5000` 相乘
   - 一个把结果与起点位置相加，用于得到射线终点
7. `Line Trace by Channel`
   - `Trace Channel = Visibility`
   - `Trace Complex` 关闭
   - `Draw Debug Type = For Duration`
   - `Ignore Self` 启用
   - `Trace Color = Red`
   - `Trace Hit Color = Green`
   - `Draw Time = 5.0`
8. `Break Hit Result`
   - 当前至少能看到输出包含 `Blocking Hit`、`Location`、`Impact Point`、`Normal`、`Hit Actor`、`Hit Component` 等

上方还可见一个 `Play Sound at Location` 节点，说明该武器组件在同一套逻辑里还会配合播放开火声音，但当前画面重点仍是命中检测链。

对复现而言，这张图明确了本段蓝图的基本思路：不是直接生成爆炸 Actor，而是先从第一人称武器组件发起一条 `Visibility` 射线，利用 `Get Actor Location + Forward Vector * 5000` 计算检测范围，再从 `Break Hit Result` 里取命中位置、命中对象或法线，供后面的特效生成、命中反馈或蓝图分支判断使用。
本图展示作者把蓝图逻辑放回关卡实例里验证。主视口中已经在地面上选中了一个武器拾取对象，黄色轮廓框包住模型；右侧 `Details` 面板当前选中的对象是：

- `BP_Pickup_Rifle (Self)`
- 其组件中可见 `SkeletalMesh`

下方 `Content Browser` 当前定位到：

`Content / Signature / Course_05 / Blueprint`

该目录下当前可见一个蓝图资源：
- `NewBlueprint`

右侧 `Details` 面板当前还能直接确认一部分 Actor 级设置：
- `Collision`
  - `Generate Overlap Events ...` 可见
  - `Update Overlaps Method During Level Streaming = Use Config Default`
  - `Default Update Overlaps Method = Only Update Movable`
- `HLOD`
  - `Include Actor in HLOD` 启用

这张图与上一张事件图连起来说明了一个完整工作流：
1. 在 `BP_Weapon_Component` 内实现射线/命中逻辑
2. 在关卡里实际放置或选中 `BP_Pickup_Rifle` 这类武器 Actor
3. 再检查它的组件与碰撞相关属性，确认可以在场景里被正确拾取、触发或响应交互

对复现而言，这一步很关键，因为仅有蓝图函数图还不够，还要确保关卡中的武器 Actor 实例、组件层级和碰撞设置与逻辑图配套，否则即使命中检测写对了，也可能因为拾取对象本身没有正确组件或碰撞响应而无法进入后续流程。

### 00:13:55-00:18:36 Mesh、粒子、发射器

- 本段定位：Mesh、粒子、发射器。
- 知识点：组件好像可以没有。
- 知识点：现在首先需要的是。
- 知识点：后续会用作静态网格的对象是。
- 知识点：Tile Mesh也在这个Mesh放进去。
- 知识点：碰撞组件好像不用单独做。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`粒子`、`发射器`、`速度`、`碰撞`。

**关键画面：**

本图展示 `Mesh、粒子、发射器` 段一开始创建或检查导弹投射物蓝图时的默认结构。当前打开的蓝图页签为：

`BP_Missile_Projectile_01`

右上角明确显示：
- `Parent class: Actor`

左侧 `Components` 面板当前只有：
- `BP_Missile_Projectile_01 (Self)`
- `DefaultSceneRoot`

这与正文“组件好像可以没有”“碰撞组件好像不用单独做”相呼应，说明此时作者先建立一个非常轻量的投射物 Actor 外壳，而不是一开始就往里塞大量静态网格、碰撞器或粒子组件。

左侧 `My Blueprint` 面板当前可确认：
- 图表
  - `EventGraph`
  - `Event BeginPlay`
  - `Event ActorBeginOverlap`
  - `Event Tick`
  - `Construction Script`
- 变量/组件
  - `DefaultSceneRoot`

右侧 `Class Defaults / Details` 里当前可见的设置包括：
- `Actor Tick`
  - `Start with Tick Enabled` 启用
  - `Tick Interval (secs) = 0.0`
- `Replication`
  - `Net Load on Client` 启用
  - `Replicates` 关闭
  - `Net Dormancy = Awake`
  - `Net Cull Distance Squared = 225000000.0`
  - `Net Update Frequency = 100.0`
  - `Min Net Update Frequency = 2.0`
  - `Net Priority = 1.0`
- `Collision`
  - `Generate Overlap Events During Level...` 可见
  - `Update Overlaps Method During Level... = Use Config Default`
  - `Default Update Overlaps Method ... = Only Update Movable`
- `Actor`
  - `Can be Damaged` 启用

对复现而言，这张图确认了一个重要思路：导弹或发射器蓝图的第一步可以只是一个空的 Actor 壳体，先保留 `DefaultSceneRoot` 和必要事件入口，等逻辑与资源关系明确后，再逐步挂载 Static Mesh、Niagara 或其他组件。这样更容易控制碰撞、移动和命中逻辑，不会被一开始的复杂组件层级拖慢定位。
本图展示 `BP_Missile_Projectile_01` 从空壳体 Actor 进入可运动投射物阶段后的组件与参数设置。与上一张相比，左侧 `Components` 面板已经变为：
- `BP_Missile_Projectile_01 (Self)`
  - `Sphere`
  - `ProjectileMovement`

中间视口里也能看到一个简单的黄色球体预览，说明此时作者先用最基础的球形碰撞/占位几何来验证投射物运动，而不是直接套用最终导弹网格。

右侧当前选中的是 `ProjectileMovement` 组件，`Details` 面板可确认的参数包括：
- `Variable Name = ProjectileMovement`
- `Editable when Inherited` 启用
- `Projectile`
  - `Initial Speed = 0.0`（当前输入框处于编辑状态）
  - `Max Speed = 0.0`
  - `Rotation Follows Velocity` 关闭
  - `Rotation Remains Vertical` 关闭
  - `Initial Velocity in Local Space` 启用
  - `Projectile Gravity Scale = 1.0`
- `Projectile Bounces`
  - `Should Bounce` 关闭
  - `Bounciness = 0.6`
  - `Friction = 0.2`
  - `Bounce Velocity Stop Simulating Threshold = 5.0`
- `Projectile Simulation`
  - `Simulation Enabled` 启用
  - `Sweep Collision` 启用
  - `Max Simulation Time Step = 0.05`
  - `Max Simulation Iterations = 4`
  - `Bounce Additional Iterations = 1`

字幕直接说明“初始速度大约 3000”，因此本图对应的实际操作是：在 `ProjectileMovement` 上把导弹/投射物的初始飞行速度调到约 `3000`，并配合 `Sphere` 作为基础碰撞体先验证运动行为。虽然画面里输入框此刻仍显示 `0.0`，但教程语义已经明确这一参数目标值是后续需要填入的关键设置。
本图对应本段投射物蓝图阶段的收尾确认。当前仍然是 `BP_Missile_Projectile_01`，左侧组件结构保持为：
- `BP_Missile_Projectile_01 (Self)`
  - `Sphere`
  - `ProjectileMovement`

中间视口里只显示一个简单的黄色球形占位物，说明到这个阶段作者并没有继续往里叠加复杂网格或额外效果组件，而是认为这个投射物蓝图的基础外壳已经足够进入下一步。

右侧当前选中的是 Actor 自身类默认值，当前可见设置包括：
- `Rendering`
  - `Actor Hidden In Game` 关闭
  - `Editor Billboard Scale = 1.0`
- `Collision`
  - `Generate Overlap Events During Level...` 关闭
  - `Update Overlaps Method During Level... = Use Config Default`
  - `Default Update Overlaps Method ... = Only Update Movable`
- `Actor`
  - `Can be Damaged` 启用
  - `Initial Life Span = 0.0`
  - `Spawn Collision Handling Method = Always Spawn, Ignore Collisions`
- `Input`
  - `Block Input` 关闭
  - `Auto Receive Input = Disabled`
  - `Input Priority = 0`
- `HLOD`
  - `Include Actor in HLOD` 启用
  - `HLOD Layer = None`
- `Physics`
  - `Async Physics Tick Enabled` 关闭
- `Events`
  - `On Take Any Damage`

字幕“我们做的这个 BP 连到这里用就行”与当前结构一致，说明教程在这里的结论是：这个导弹投射物蓝图只需要最小组件集合和基础运动/生成规则，不必额外添加单独碰撞组件或复杂静态网格，后续效果更多会在命中逻辑、Niagara 或材质侧继续补上。对复现而言，这能帮助避免把投射物蓝图做得过重，先保证它能稳定生成、移动和被命中逻辑引用即可。

### 00:18:36-00:23:12 UV、Static Mesh、Mesh

- 本段定位：UV、Static Mesh、Mesh。
- 知识点：我们被击中时需要效果。
- 知识点：放个Component进去就行。
- 知识点：为了获取Hit的Location值。
- 知识点：就取了Hit的Resolve。
- 知识点：现在最简单的排列系统生成的那个 位置。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`粒子`、`系统`、`蓝图`。

**关键画面：**

本图展示如何在 `BP_Weapon_Component` 中真正生成前一段做好的导弹投射物蓝图。当前画面仍在：

`BP_Weapon_Component > Event Graph`

左侧 `My Blueprint` 当前可确认：
- 图表
  - `EventGraph`
  - `Event Begin Play`
  - `EnhancedInputAction IA_Shoot`
  - `F`
- 变量/组件
  - `Hit Component`
  - `Hit Component2`
  - `FirstPersonCharacter`
  - `ProjectileOffset`

当前可见的关键蓝图节点为：
- `SpawnActor BP Missile Projectile 01`
  - `Class = BP Missile Proj...`
  - `Collision Handling Override = Default`
  - 具有 `Spawn Transform` 输入
  - 输出 `Return Value`
- 一个 `Hit Component` 变量节点
- 下方可见的声音相关节点
  - `Play firing sound`
  - `Play Sound at Location`

最关键的是：作者正从 `SpawnActor BP Missile Projectile 01` 的 `Return Value` 引脚拖出一根线，并在右键动作搜索框里输入 `pr`。上下文菜单当前筛出的结果几乎都围绕 `ProjectileMovement`，例如：
- `Move Interpolation Target (ProjectileMovement)`
- `Reset Interpolation (ProjectileMovement)`
- `Set Interpolated Component (ProjectileMovement)`
- `Is Velocity Under Simulation Threshold (ProjectileMovement)`
- `Limit Velocity (ProjectileMovement)`
- `Set Velocity in Local Space (ProjectileMovement)`
- `Stop Simulating (ProjectileMovement)`

这说明本图对应的真实操作不是单纯生成 Actor，而是生成 `BP_Missile_Projectile_01` 后，立刻从返回的对象引用继续调用与 `ProjectileMovement` 相关的方法，去补上导弹的速度、插值或运动行为。对复现而言，这一步把前一段独立做好的投射物蓝图和武器开火蓝图真正接起来，是从“有投射物蓝图资源”过渡到“开火时会实际生成并运动”的关键环节。
本图展示命中反馈真正落到投射物蓝图内部的实现方式。当前页签为：

`BP_Missile_Projectile_01 > Event Graph`

左侧 `My Blueprint` 面板当前可确认：
- 图表
  - `EventGraph`
  - `Event BeginPlay`
  - `Event Tick`
  - `On Component Hit (Sphere)`
- 变量/组件
  - `ProjectileMovement`
  - `Sphere`

当前可见的命中处理蓝图链为：
1. `On Component Hit (Sphere)`
   - 这是球形碰撞体的命中事件入口
2. `Break Hit Result`
   - 输入直接来自 `On Component Hit` 的 `Hit`
   - 当前可见输出至少包括：
     - `Blocking Hit`
     - `Location`
     - `Impact Point`
     - `Normal`
     - `Impact Normal`
     - `Phys Mat`
     - `Hit Actor`
     - `Hit Component`
     - `Hit Bone Name`
     - `Bone Name`
     - `Hit Item`
     - `Element Index`
3. `Spawn System at Location`
   - `Location = (0,0,0)` 当前为默认待接入状态
   - `Rotation = (0,0,0)`
   - `Scale = (1,1,1)`
   - `Auto Destroy` 启用
   - `Auto Activate` 启用
   - `Pooling Method = None`
   - `Pre Cull Check` 启用

从当前连线可以确认：`On Component Hit (Sphere)` 的执行流已经直接连到 `Spawn System at Location`，而 `Break Hit Result` 正是为了从命中信息里提取位置值。字幕也明确说明“在 hit 位置生成一次确认一下”，所以本图对应的目标就是把 `Break Hit Result` 的 `Location` 或 `Impact Point` 接到 `Spawn System at Location`，让 Niagara 或其他特效系统在真正的碰撞点触发，而不是固定在投射物原点或世界原点生成。
本图展示命中测试回到关卡视图后的资源与目标验证状态。主视口里当前选中的是一块大型海滩岩石静态网格，黄色描边包住整块地形部件；右侧 `Details` 面板当前对象名可见为：

- `SM_Nordic_Beach_Rock_Formation_vfkaijyga_01_N2 (Instance)`

其组件类型明确为：
- `StaticMeshComponent`

画面中同时还能看到地面上的武器模型，说明作者是在真实关卡里用武器/投射物去测试命中静态网格后的特效位置表现。

下方 `Content Browser` 当前定位到：

`Content / Signature / Course_05 / Particles`

当前可直接看到的粒子资源包括：
- `Ex_01_Campfire`
- `Ex_02_Smoke Plume`
- `Ex_03_Explosion`

其中当前选中的是：
- `Ex_03_Explosion`

这张图与上一张命中事件图配套，说明作者已经把“命中点生成系统”的逻辑对应到具体资源选择上：当导弹或射线命中像 `SM_Nordic_Beach_Rock_Formation...` 这样的静态网格时，准备用 `Ex_03_Explosion` 作为实际生成的粒子/系统资源。结合正文“为了获取 Hit 的 Location 值”和“最简单的排列系统生成的那个位置”，可以推断这一阶段的重点是验证系统确实出现在目标静态网格的正确命中位置，而不是偏到网格中心或错误偏移点。

### 00:23:12-00:27:56 UV、Blueprint、Noise

- 本段定位：UV、Blueprint、Noise。
- 知识点：刚才一开始我 预先添加了蓝图节点。
- 知识点：可以用F键设定目标点。
- 知识点：就能到你想去的地方。
- 知识点：如果是 静态网格。
- 知识点：就会到 静态网格的中心。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Noise`、`Blueprint`、`蓝图`。

**关键画面：**

本图回到 `Main (Play In Editor)` 第一人称测试视角，用实际开火/投射物飞行结果来验证前面蓝图节点是否按预期工作。画面中可以直接看到：
- 前景右下是玩家手中的武器
- 场景中有一个黄色球形投射物/调试占位物
- 有一条红色调试线从武器前方向前延伸
- 调试线前段附近有一个红色方块样的目标点标记

右侧 `Outliner` 仍然保留 `light` 过滤，说明作者没有切换到别的测试关卡，而是在同一个已经调亮的场景中继续验证。下方 `Content Browser` 还停在：

`Content / Signature / Course_05 / Particles`

并且 `Ex_03_Explosion` 仍处于选中状态，这意味着当前测试所对应的命中爆炸资源没有换掉，重点改的是蓝图目标点和定位方式。

结合字幕“刚才一开始我预先添加了蓝图节点，可以用 F 键设定目标点”，这张图对应的逻辑含义是：
- 先在蓝图里预埋一个用于指定或更新目标点的节点
- 运行时通过调试线和目标标记直接观察目标位置是否正确
- 再据此判断投射物是否朝着期望命中点飞行，或后续特效是否会在正确点位触发

对复现而言，这张图强调的不是材质或粒子参数，而是蓝图调试手段：先把目标点和飞行/命中方向可视化，再继续调 `Noise`、Static Mesh 中心或生成位置，否则很容易在看不见目标点的情况下误判蓝图是否工作。
本图展示 `Noise` 相关效果实际上落在一个相机震动资源里。当前打开的页签为：

`Shake_01`

右上角明确显示：
- `Parent class: Legacy Camera Shake`

中间主区域是空的 `Event Graph`，顶部提示 `Right-Click to Create New Nodes.`，说明当前这个资源并不依赖复杂事件图逻辑，而是主要通过右侧参数面板配置抖动曲线。左侧 `My Blueprint` 当前只有：
- `EventGraph`

右侧 `Details` 面板当前可直接确认的震动参数分组与默认值包括：
- 顶部一组旋转抖动参数
  - `Amplitude = 0.0`
  - `Frequency = 0.0`
  - `Initial Offset = Random`
  - `Waveform = Sine Wave`
- `Loc Oscillation`
  - `X`
    - `Amplitude = 0.0`
    - `Frequency = 0.0`
    - `Initial Offset = Random`
    - `Waveform = Sine Wave`
  - `Y`
    - `Amplitude = 0.0`
    - `Frequency = 0.0`
    - `Initial Offset = Random`
    - `Waveform = Sine Wave`
  - `Z`
    - `Amplitude = 0.0`
    - `Frequency = 0.0`
    - `Initial Offset = Random`
    - `Waveform = Sine Wave`
- `FOVOscillation`
  - `Amplitude = 0.0`
  - `Frequency = 0.0`
  - `Initial Offset = Random`
  - `Waveform = Sine Wave`
- `Anim Shake`
  - `Anim Play Rate = 1.0`

字幕提到“噪音图案”，结合这里全是 `Amplitude / Frequency / Waveform` 这类抖动参数，可以确认本段的 `Noise` 并不只是贴图噪声，也包括相机震动所使用的周期/噪声式运动配置。对复现而言，如果要把爆炸或命中做得更有冲击感，这个 `Shake_01` 资源就是后续可叠加到相机反馈里的噪声载体。
本图展示把前面做好的投射物蓝图与相机震动/噪声资源一起放回实际第一人称测试环境后的效果。主视口处于 `Main (Play In Editor)`，玩家右下仍持枪瞄准，地面上已经出现一团明显的红色发光命中反馈，说明导弹命中点生成的系统已经能在关卡里直观看到。

下方 `Content Browser` 当前定位到：

`Content / Signature / Course_05 / Blueprint`

当前可见并参与这一步的蓝图资源包括：
- `BP_Missile_Projectile_01`
- `Shake_01`

其中当前选中的是：
- `Shake_01`

右侧 `Outliner` 仍保留 `light` 过滤，说明作者继续在同一个调亮过的测试场景中观察结果，没有切换到新的验证环境。这样的上下文很重要，因为 `Shake_01` 这类相机噪声/震动资源只有和真实命中反馈一起看时，才能判断视觉强度是否合适。

结合前一张 `Shake_01` 的震动参数页，这张图可以理解为一次整体验证：
1. `BP_Missile_Projectile_01` 负责飞行与命中
2. 命中时在目标位置触发爆炸/发光系统
3. 同时可配合 `Shake_01` 之类的相机噪声反馈增强冲击感

对复现而言，这张图的关键不是新增节点，而是确认资源协同结果已经可见。也就是说，`Noise/Blueprint` 段的工作目标并不是孤立做一个震动资源，而是让投射物命中、爆炸显示和相机反馈最终在同一条实机测试链路里跑通。

### 00:27:56-00:30:22 速度

- 本段定位：速度。
- 知识点：还有想对动作多点控制的人。
- 知识点：刚才张力和张力越高。
- 知识点：越能把我们想要的点吸进去。
- 知识点：现在去捐的力会更强一些。
- 知识点：现在基本速度是前进时最初生成的。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`速度`。

**关键画面：**

本图展示进入“速度”段后的运行时验证状态。主视口处于 `Main (Play In Editor)`，测试场景仍是同一片海岸地形；画面中央附近保留了红色的目标/命中调试标记，说明作者没有切换到新的流程，而是在既有导弹/目标点链路上继续微调速度与动作表现。

右侧 `Outliner` 仍保留 `light` 过滤，表明环境亮度设置没有被打断。下方 `Content Browser` 当前定位到：

`Content / Signature / Course_05 / Blueprint`

此时可直接看到的关键蓝图资源只有：
- `BP_Missile_Projectile_01`
- `Shake_01`

这说明当前“速度”段的调节对象仍然围绕两件事展开：
1. `BP_Missile_Projectile_01` 的飞行/追踪/速度行为
2. `Shake_01` 这类反馈资源在命中或运动过程中的辅助表现

字幕里明确提到“还有想对那个动作再多点控制的人”，结合前文对目标点、命中位置和投射物生成的铺垫，可以确认本图的重点是进入更细的运动控制阶段，而不是新增资产。对复现而言，这张图说明速度调节必须放在实际 PIE 测试场景中做，因为只有在真实飞行和命中反馈都同时存在时，才能判断当前速度是否过快、过慢，或是否需要进一步加追踪/吸附式控制。
本图仍然处于 `Main (Play In Editor)` 的第一人称测试视角，但相比上一张，画面里不再出现明显的投射物或爆炸结果，只保留了：
- 屏幕中央的准星
- 前方地面附近的红色目标/命中调试标记
- 右侧 `Outliner` 的 `light` 过滤结果
- 底部 `Content / Signature / Course_05 / Blueprint` 下的 `BP_Missile_Projectile_01` 与 `Shake_01`

这说明作者此时更关注“目标点、朝向和速度控制的基准状态”，而不是特效爆发瞬间。换句话说，这一帧更像是速度调试里的静态参考画面：先确认准星指向、目标标记位置以及玩家当前观察角度都合理，再继续判断投射物是否朝着期望方向加速或吸附。

结合正文中“张力越高，越能把我们想要的点吸进去”和“现在基本速度是前进时最初生成的”，可以把这一帧理解为运动控制前的基准瞄准状态。对复现而言，这类空场景参考帧很重要，因为它能把“目标点是否对”“瞄准方向是否偏”“速度调节是否导致轨迹异常”这些问题拆开看，避免被爆炸亮光或相机震动掩盖。
本图把“速度”段从运行时测试拉回到 Niagara System 本体，开始在粒子发射器内部通过模块控制尺寸/时间行为。当前打开的是：

`Ex_03_Explosion`

中间 `System Overview` 里当前选中的是发射器：
- `Fire01002`

左侧预览/统计区当前可见的粒子计数信息为：
- `0 Current, 3 Max (est.) - [Fire01] [Disabled]`
- `0 Current, 3 Max (est.) - [Fire01001] [Disabled]`
- `0 Current, 1 Max (est.) - [Fire01002] [Active]`
- `0 Current, 52 Max (est.) - [Fire01006] [Disabled]`

当前 `Fire01002` 发射器中可直接确认的模块结构为：
- `Properties (CPU / +Stage)`
- `Emitter Summary`
- `Emitter Spawn`
- `Emitter Update`
- `Emitter State`
  - 模式标记可见为 `Self / Once`
- `Spawn Burst Instantaneous`
- `Spawn Rate` 当前关闭
- `Particle Spawn`
  - `Initialize Particle`
  - `Camera Offset`
- `Particle Update`
  - `Particle State`
  - `Scale Color`
  - `Sub UV Animation`
- `Render`
  - `Sprite Renderer`

右侧 `Details` 面板当前显示的正是 `Particle State` 模块，参数为：
- `Kill Particles When Lifetime ...` 启用

字幕明确提到“这里现在将尺寸值作为比例”，结合当前正选中的 `Particle Update` 区域和 `Scale Color / Sub UV Animation` 模块，可以确认这一帧的重点是开始在 Niagara 发射器内用比例化的尺寸/生命周期控制粒子表现，而不再只依赖蓝图里的投射物速度。对复现而言，这一步说明“速度”不只是投射物飞行速度，还会延伸到粒子自身随时间的显示比例、翻页节奏和存活控制。

## 补充视觉证据

### S01 00:01:54

这张补充截图用于补证本节前段所说的“顶视角向下看的烟雾/爆炸图集纹理”具体长什么样。当前打开的是纹理编辑器，顶部标签可见资源名包括：
- `Exp_01*`
- `Arial_Exp_Smoke_01*`

主预览窗口显示的是一张黑底白烟的多帧图集，可见多列多行重复排布的烟雾帧。与前文的单帧/整体资源浏览不同，这张补证更强调这些帧的形状来源一致，并且每一帧都像从上往下俯视得到的云团轮廓，而不是侧面火焰条带。

右侧 `Details` 面板当前可确认的纹理信息为：
- `Imported: 4096x4096`
- `Displayed: 4096x4096`
- `Max In-Game: 4096x4096`
- `Resource Size: 21845 KB`
- `Source Alpha Detected: True`
- `Method: Streamed`
- `Format: DXT5`
- `Format Supports Alpha: True`
- `Combined LOD Bias: 0`
- `Number of Mips: 13`
- `Encode Speed: Final`

当前还能看到的部分导入/采样设置包括：
- `Use Improved Image ...` 启用
- `Flip Green Channel` 关闭
- `Filter = Default (from Texture Group)`
- `Mip Load Options = Default`
- `Brightness = 1.0`
- `Brightness Curve = 1.0`
- `Vibrance = 0.0`
- `Saturation = 1.0`
- `RGBCurve = 1.0`
- `Hue = 0.0`
- `Min Alpha = 0.0`

字幕明确说明“这个纹理的话，可以认为是使用从顶部视角向下看的摄像机视角进行渲染的方式”，因此这张图可以作为前文纹理语义的直接证据：这里使用的不是随便找的一张烟雾贴图，而是专门按俯视摄像机角度烘焙出来的图集，适合拿来做精灵粒子、翻页动画或爆炸体积的顶部展开表现。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。

