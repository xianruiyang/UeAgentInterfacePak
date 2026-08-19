# 18制作RibbonTrail主材

# 18制作RibbonTrail主材

## 关键术语

- `Alpha`、`Ribbon`、`Material`、`UV`、`Multiply`、`Add`、`Opacity`、`Sequencer`、`材质`、`粒子`、`渲染器`、`Niagara`、`Emitter`、`Spawn Rate`、`Spawn`、`Lifetime`、`Niagara System`、`Particle`

## 分段知识

### 00:00:05-00:04:46 Ribbon、Sequencer、材质

- 本段定位：Ribbon、Sequencer、材质。
- 知识点：这部分制作Ribbon用了主材质, 连接到简单的Ribbon Render和Niagara使用方法。
- 知识点：打开像子磁砖,打开Agra粒子看一下。
- 知识点：首先配置一个Ribbon, 和再制作,材质会更好。
- 知识点：设置好后进行材质工作, 同时观察变化。
- 知识点：现在这个粒子, 是这样,向前移动的。
- 知识点：圆的概念是, 这个移动的粒子的轨迹上, 会有这种丝带生成的方式。
- 知识点：如果搜索other会有 从其他发射器放置粒子。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Niagara`、`Sequencer`、`材质`、`粒子`、`发射器`、`序列`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 本图显示第 18 课开场环境：UE 关卡视口为默认地面和天空光照，Outliner 中可见 `Untitled (Editor)`、`Lighting` 文件夹及若干默认光照/天空对象；Content Browser 位于 `Content/Tutorial`，包含 `Level`、`Material`、`Particle`、`Sequencer` 文件夹。字幕说明上一课已经进行第一个 Ribbon Trail 示例，本课继续制作 Ribbon Trail 主材。
> 图表转写（UE-GTXT v4）
> 截图打开 `Projectile_01` Niagara System。System Overview 中只有 `Empty` 发射器，包含 `Emitter State Self/Once`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Add Velocity Linear`、`Particle State`、`Solve Forces and Velocity`、`Scale Color`、`Sprite Renderer`。右侧选择 `Empty` 的 `Emitter Properties`，可见 `Local Space` 勾选、`Sim Target=CPUSim`、Scalability 档位按钮等；底部 Sequencer/时间轴显示该系统处于早期播放位置。该图用于说明在制作 Ribbon 前先确认基础发射器堆栈。
> 图表转写（UE-GTXT v4）
> `Projectile_01` 中已有两个发射器：`Source` 与 `Ribbon`。`Ribbon` 发射器堆栈中可见 `Spawn Particles from Other Emitter`、`Sample Particles from Other Emitter`，右侧面板显示 `Spawn Particles from Other Emitter` 参数，`Emitter` 字段为 `Source`，`Spawn Rate=10.0`，并有 `Calculate Spawn...`、`Spawn Rate Per...=100.0` 等可见字段。左侧预览和关卡视口出现沿路径分布的白色粒子，字幕提示“位置不匹配，可能是本地空间不同”。

### 00:04:46-00:09:25 UV、材质、粒子

- 本段定位：UV、材质、粒子。
- 知识点：您可观察到, 这样圆粒子经过的位置, 这个位置就会是 实地生成在那。
- 知识点：这个喷发粒子来自其他发射器的概念。
- 知识点：这里的喷发速率 可以调节数量, 设为20个就会增加。
- 知识点：现在我们用精灵渲染器 来表达这个。
- 知识点：是填写发射器, 名称的部分喷发速率。
- 知识点：我来试试设定为10, 这样就会限制最大粒子数。
- 知识点：而且这个样本粒子发射器 使用了原粒子的属性。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`、`粒子`、`发射器`、`渲染器`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 截图继续显示 `Source` 与 `Ribbon` 两个发射器。右侧仍为 `Spawn Particles from Other Emitter` 设置，`Emitter=Source`、`Spawn Rate=10.0` 等字段可见。预览区和关卡视口中的白色粒子沿一条轨迹生成，字幕说明这些位置会实时生成粒子。该图强调 Ribbon 发射器不是独立运动，而是按 Source 粒子的位置/生成采样产生轨迹点。
> 图表转写（UE-GTXT v4）
> 右侧选择 `Sample Particles from Other Emitter` 模块，面板显示 `Emitter Sampling` 为 `Sequential`，`Position Sampling` 为 `Apply to Attribute`，Applied Position 的 `X/Y/Z` 均为 `0.0`；`Velocity Sampling`、`Color Sampling`、`Age Sampling`、`Lifetime Sampling`、`Mass Sampling`、`Material Random`、Sprite/Mesh/Ribbon 相关采样项多为 `Disabled`。预览区显示 Ribbon 当前粒子计数约为 `46 Current, 49 Max(est.)`，关卡视口中仅保留一段亮点/轨迹效果。
> 图表转写（UE-GTXT v4）
> 画面切到 `M_Ribbon_01` 材质图。材质编辑器左侧预览为黑色平面；图中只有一个 `TexCoord[0]` 节点，Details 面板显示 `Coordinate Index=0`、`UTiling=1.0`、`VTiling=1.0`，`Un Mirror U/V` 未勾选。底部 Content Browser 位于 `Content/Tutorial/Material`，可见 `M_Ribbon_01`、`M_RadialUV_01`、`M_RadialBlur_01` 等资源。该图用于说明 Ribbon 主材先从基础纹理坐标开始。

### 00:09:28-00:14:23 UV、材质、贴图

- 本段定位：UV、材质、贴图。
- 知识点：很简单的纹理映射。
- 知识点：这个纹理可能不包含在资源中。
- 知识点：需要放入4代材质。
- 知识点：生成的4代的长度一定。
- 知识点：如果这里是 Tile by segment Land。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`、`贴图`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `M_Ribbon_01` 材质属性页可见：`Material Domain=Surface`、`Blend Mode=Translucent`、`Shading Model=Unlit`，`Two Sided` 未勾选，`Cast Ray Traced Shadows` 勾选。Material Graph 中仍只有 `TexCoord[0]`，左侧预览为黑色平面，Content Browser 中 `M_Ribbon_01` 被选中。该图确认 Ribbon 材质的基础混合/光照模型为透明、自发光式材质。
> 图表转写（UE-GTXT v4）
> Niagara 中 `Ribbon` 发射器选中 `Ribbon Renderer`。右侧 `Ribbon Rendering` 显示 `Material=M_Ribbon_01`、`Material User Param Binding=None`、`Facing Mode=Screen`；`UV0 Settings` 中 `UV Mode=Tiled (By Segment Length)`，`Leading/Trailing Edge Transition=Locked`，`Tiling Length=100.0`，`Offset=0.0/0.0`，`Scale=1.0/1.0`；`UV1 Settings` 的 `Draw Direction=Front to Back`。`Ribbon Shape` 中 `Shape=Plane`，`Width Segmentation=1`；Bindings 可见 `Position Binding=PARTICLES Position`、`Color Binding=PARTICLES Color`、`Velocity Binding=PARTICLES Velocity`。预览中 Ribbon 材质出现红白箭头贴图效果。
> 图表转写（UE-GTXT v4）
> `Ribbon Renderer` 的 `UV Mode` 下拉菜单展开，当前候选项包括 `Uniform Scale (By Segment)`、`Non-Uniform Scale (By Total Length)`、`Tiled (By Segment Length)`、`Tiled By Distance (By Particles.RibbonUVDistance)`。右侧面板仍显示 `Material=M_Ribbon_01`、`Facing Mode=Screen`、`Draw Direction=Front to Back`、`Shape=Plane`，下方 Bindings 继续使用 `PARTICLES` 的 Position/Color/Velocity 等属性。该图用于说明教程在对比 Ribbon UV 沿段、总长或距离贴图的映射方式。

### 00:14:23-00:17:53 UV、材质、颜色

- 本段定位：UV、材质、颜色。
- 知识点：就正式开始制作 煮水材质吧。
- 知识点：我现在觉得我们上次制作了这个 煮水材质。
- 知识点：我们的断带煮水材质 也有这个扭曲 要使用的普通纹理。
- 知识点：扭曲对下的反射纹理部分 将用于不透明度。
- 知识点：并且将用于颜色混合的部分 会保持一致。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`、`颜色`、`透明度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 画面仍是 `Ribbon Renderer` 的 `UV Mode` 下拉菜单，候选项与上一图一致，当前面板中 `UV Mode` 显示为 `Tiled By Distance (By Particles.RibbonUVDistance)`，`Tiling Length`、`Offset`、`Scale` 等字段可见。预览区中 Ribbon 贴图已经不再明显拉伸，字幕说明这些上面的 UV 模式使用关系不大。该图补充确认最终更倾向按距离驱动 Ribbon 贴图铺展。
> 图表转写（UE-GTXT v4）
> `M_Ribbon_01` 材质图已扩展为多段节点网络。可见一个红色 `Dynamic Parameter` 节点，输出名包括 `Param1`、`Direction`、`Width`、`ColorFade`；周围有 `Multiply`、`Append`、`Mask`、`Add`、`0.15` 常量、贴图采样节点以及若干参数节点。右侧可见材质主输出方向的长连线，左侧 Details 仍显示材质为 `Surface / Translucent / Unlit`。该图表示开始把上一段材质逻辑复制/组合到 Ribbon 主材中，用动态参数参与方向、宽度和颜色衰减控制。
> 图表转写（UE-GTXT v4）
> 材质图聚焦在 UV 与法线贴图输入：`TexCoord[0]` 输出分到 `Mask(R)` 与 `Mask(G)`，`Mask(R)` 接入 `1-x` 节点用于翻转一轴；`Normal_Tile_U Param(0.75)` 与 `Normal_Tile_V Param(0.3)` 接入 `Append`，再连到右侧 `Normal_Tex` 贴图采样的 `UVs`。右侧还露出 `Diff_Tile_U`、`Diff_Tile_V` 参数节点。该图说明 Ribbon 主材把 TexCoord 拆分后做方向翻转，并用参数化 Tile 控制 Normal/Diffuse 贴图 UV。

### 00:18:03-00:22:55 UV、纹理

- 本段定位：UV、纹理。
- 知识点：我们用这个纹理 确认UV是否倒过来输出。
- 知识点：保存了之后反转了呢。
- 知识点：刚才这个地方在这个方向上 这样反转着写吧。
- 知识点：在 RadioUV中用过的 后面的函数部分。
- 知识点：这部分可能会是 动态参数中的重要部分。
- 知识点：第二个就是 需要写那个Random。
- 知识点：这个Random在 基本UV格式中 加上去。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`纹理`、`动态参数`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `M_Ribbon_01` 材质图显示从左侧 `Texture Sample`、`Normal_Tex` 到右侧 `Diff_Tex` 的 UV/贴图组合链。可见 `Normal_Tile_U/V` 参数经 `Append` 输入 `Normal_Tex` 的 `UVs`；`Normal_Tex` 的输出经过 `Mask(G)`、`Multiply`、`Add` 等节点继续与下方 `0` 常量、`Append`、另一组 `Multiply` 组合；右侧 `Diff_Tex` 贴图采样露出输入端。该图用于说明在颜色/纹理阶段，先把法线纹理产生的扰动链路接入 Diffuse 贴图采样。
> 图表转写（UE-GTXT v4）
> 回到 `Projectile_01` Niagara System 预览，左侧可见红白 Ribbon 轨迹和白色 Source 粒子。System Overview 中 `Source` 发射器包含 `Shape Location Sphere`，`Ribbon` 发射器包含 `Spawn Particles from Other Emitter`、`Sample Particles from Other Emitter`、`Ribbon Renderer`。右侧选择 `Source` 的 `Spawn Burst Instantaneous`，可见 `Spawn Count=3`、`Spawn Time=0.0`、`Loop Behavior=Once`、`Loop Duration=1.0`，粒子计数显示 Source 当前 3 个、Ribbon 当前约 6 个。该图用于验证材质接入后少量 Source 粒子会生成对应 Ribbon 条带。
> 图表转写（UE-GTXT v4）
> `Ribbon` 发射器的 `Ribbon Renderer` 参数再次打开，预览区显示多条红白 Ribbon 条带。右侧可见 `Material=M_Ribbon_01`、`Facing Mode=Screen`、`UV Mode=Tiled By Distance (By Particles.RibbonUVDistance)`、`Tiling Length=300.0`、`Offset=0.0/0.0`、`Scale=1.0/1.0`、`Draw Direction=Front to Back`、`Shape=Plane`、`Width Segmentation=1`。下方 Bindings 使用 `PARTICLES Position`、`PARTICLES Color`、`PARTICLES Velocity`。该图记录阶段性验证：材质贴图按距离铺展后，Ribbon 条带呈红白方向性纹理。

### 00:22:55-00:27:40 粒子、纹理

- 本段定位：粒子、纹理。
- 知识点：后期序是非常重要的。
- 知识点：正在使用第二个参数。
- 知识点：那箭头纹理得再用一次。
- 知识点：这个现在看起来最合适。
- 知识点：连接到安德格格点色。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`粒子`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `M_Ribbon_01` 材质图聚焦在 UV 随机部分。`Dynamic Parameter` 节点的输出名可见为 `Distortion`、`RandomU`、`Dissolve`、`Param4`；左侧 Details 的 Param Names 也列出这 4 个参数。`TexCoord[0]` 分到 `Mask(R)` 与 `Mask(G)`，`Mask(R)` 经 `1-x` 后与 `Mask(G)` 组成 `Append`；`RandomU` 参与后续 `Add`，再与 `Normal_Tile_U/V` 组成的 `Append` 结果经 `Multiply` 接入 `Normal_Tex` 采样的 UV 链路。该图说明第二个动态参数 `RandomU` 被用来偏移 Ribbon 纹理采样。
> 图表转写（UE-GTXT v4）
> `Projectile_01` Niagara System 预览区显示 `Compilation Failed!`。System Overview 中 `Ribbon` 发射器选中 `Dynamic Material Parameters`。右侧 `Dynamic Parameter Index 0` 已勾选 `Write Parameter Index 0`；`Param0` 值为 `0.0`，`RandomU` 由 `Random Range Float` 驱动，`Minimum=0.0`、`Maximum=1.0`、`Evaluation Type=Spawn Only`、`Randomness Mode=Deterministic`，`Random Seed` 字段可见；`Param2` 与 `Param3` 仍显示未使用且值为 `0.0`。该图记录 Niagara 侧把材质的 `RandomU` 动态参数改成出生时随机值，但此时预览编译失败。
> 图表转写（UE-GTXT v4）
> 材质图继续显示 `Dynamic Parameter` 的 `RandomU` 输出进入 `Append`，同时 `TexCoord[0]` 的 `Mask(R)` 经 `1-x` 与 `Mask(G)` 组合形成基础 UV；两路 UV 经过 `Add` 输入红白箭头贴图 `Texture Sample`。预览窗口显示大幅红白箭头纹理，表示当前偏移链路正在直接影响贴图采样位置。图中还保留 `Normal_Tile_U/V`、`Normal_Tex` 等后续法线纹理链路。

### 00:27:40-00:32:37 UV、Opacity、材质

- 本段定位：UV、Opacity、材质。
- 知识点：我也会使用这个颜色部分。
- 知识点：只用不透明度纹理。
- 知识点：我们制作的粒子中。
- 知识点：连接opacity纹理。
- 知识点：用动态参数管理过。
- 知识点：但会单独创建参数。
- 知识点：图像的颜色怎么表现。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`Opacity`、`材质`、`纹理`、`粒子`、`颜色`、`透明度`、`动态参数`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> Niagara 中 `Ribbon` 发射器仍选中 `Dynamic Material Parameters`。预览区显示多条红白 Ribbon 条带。右侧 `Dynamic Parameter Index 0` 中 `RandomU` 使用 `Random Range Float`，`Minimum=0.0`、`Maximum=3.0`、`Evaluation Type=Spawn Only`、`Randomness Mode=Deterministic`，并启用 `Random Seed`，种子来源显示为 `Particles.RibbonID`；`Param0=0.0`，`Param2=0.0`、`Param3=0.0` 可见。该图记录随机 U 偏移范围扩大到 3，并按 RibbonID 稳定随机。
> 图表转写（UE-GTXT v4）
> 材质图显示 Opacity 纹理链路。`Texture Sample`（红白箭头图）与 `Normal_Tex`、`Opacity_Tex` 同屏可见；`Texture Sample` 的输出经 `Add` 后进入右侧采样链，`Normal_Tile_U/V` 通过 `Append` 供给 `Normal_Tex`，`Diff_Tile_U` 等参数仍在下方。`Normal_Tex` 的通道通过 `Mask(G)`、`Multiply`、`Add` 等节点参与到右侧 `Opacity_Tex` 的 UV/强度链路。该图用于说明此阶段开始把不透明度纹理接入材质，而不是只使用箭头颜色贴图。
> 图表转写（UE-GTXT v4）
> Niagara 中选中 `Ribbon / Initialize Particle`。右侧可读设置：`Lifetime Mode=Direct Set`，`Lifetime=2.0`；`Color Mode=Unset`；`Position Mode=Simulation Position`；`Sprite Size/Rotation/UV` 均为 `Unset`；`Ribbon Width Mode=Direct Set`，`Ribbon Width=50.0`，`Ribbon Facing Mode=Unset`，`Ribbon Twist Mode=Unset`。预览区显示白色点状粒子，粒子计数显示 Source 当前 5 个、Ribbon 当前 15 个左右。该图确认 Ribbon 初始寿命和宽度还处于较窄状态。

### 00:32:37-00:37:27 Alpha、UV、Multiply

- 本段定位：Alpha、UV、Multiply。
- 知识点：需要把想要使用的参数。
- 知识点：这个参数现在进来了零纸。
- 知识点：并且在这个不透明度部分。
- 知识点：与纹理由于连接起来。
- 知识点：部分透明度是死的样子。
- 知识点：而这个颜色部分也可以。
- 知识点：在水材质中再减少一次。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Multiply`、`Add`、`材质`、`纹理`、`颜色`、`透明度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 仍选中 `Ribbon / Initialize Particle`，基础字段与上一图相同，但 `Ribbon Width=150.0`。预览区只显示若干白色粒子点，Ribbon 当前粒子计数为 0，Timeline 光标在起点附近。该图记录将 Ribbon 宽度从 50 提高到 150 的设置点，尚未展示完整宽条带结果。
> 图表转写（UE-GTXT v4）
> Niagara 仍在 `Ribbon / Initialize Particle` 参数面板，`Ribbon Width=150.0` 保持可见。预览区出现多条宽的灰白 Ribbon 纹理带，Source 当前约 5 个粒子，Ribbon 当前约 43 个粒子。右侧 `Ribbon` 发射器堆栈仍包含 `Spawn Particles from Other Emitter`、`Sample Particles from Other Emitter`、`Dynamic Material Parameters` 与 `Ribbon Renderer`。该图用于验证更宽 Ribbon 宽度和材质透明链路已经在预览中产生条带形态。
> 图表转写（UE-GTXT v4）
> 材质图切到颜色采样区域。左侧预览显示灰白 Ribbon 外观。图中可见 `Append`、`Multiply`、常量 `0.1`、`RGB_Offset Param(0.01)`、`Add`、`Subtract`、三组 `Color_Tex` 采样、`MakeFloat3`、`Desaturation Param(-1)`、`Desaturation`、`Power`、`Color_Str Param(1)` 等节点。字幕指出“这一部分应该是 add 而不是 multiply”，对应当前鼠标停留在一个 `Multiply` 节点上。该图记录颜色通道偏移/合成链路中有一处节点类型需要改为 `Add` 的修正点。

### 00:37:27-00:42:11 Material、UV、Multiply

- 本段定位：Material、UV、Multiply。
- 知识点：就像我们以前在材质中使用的。
- 知识点：用于颜色通道偏移的。
- 知识点：这一部分可以保持一致。
- 知识点：将这一部分设置为0。
- 知识点：与之前使用的不透明度。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Material`、`Multiply`、`材质`、`粒子`、`颜色`、`透明度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 材质图中颜色采样链路继续展开：`RGB_Offset Param(0.01)` 参与两个 `Add` 节点，分别偏移三组 `Color_Tex` 采样；三组 `Color_Tex` 的通道输出汇入 `MakeFloat3`，再接到 `Desaturation`，其 `Fraction` 输入来自 `Desaturation Param(-1)`；右侧继续接入 `Power`。左侧预览显示灰白 Ribbon 中带有淡色边缘。该图说明颜色纹理通过偏移采样和去饱和处理形成 Ribbon 的颜色基础。
> 图表转写（UE-GTXT v4）
> 材质主输出区域可见 `Particle Color` 节点。上方颜色链经 `Add`、`Multiply` 后连入材质输出 `M_Ribbon_01` 的 `Emissive Color`；`Particle Color` 的白色输出接入一个 `Multiply`，与颜色链相乘后进入 `Emissive Color`。`Particle Color` 的 Alpha 输出接入下方另一个 `Multiply`，再连到材质主输出的 `Opacity`。该图说明粒子颜色同时控制发光颜色强度和透明度，材质输出仍使用 `Emissive Color` 与 `Opacity` 两个关键输入。
> 图表转写（UE-GTXT v4）
> 材质图聚焦 Opacity/边缘遮罩链路。`Normal_Tex` 的 `Mask(R)` 输出经 `Multiply`、`Add` 与其他链路合成后进入 `Opacity_Tex` 附近；右侧可见 `Black_Slit Param(1)` 接入 `Power`/`Clamp(Min=0 Max=1)` 方向，`Edge_Slit Param(1)`、`Edge_Pow Param(1)` 接入另一组 `Power` 与 `Multiply`，`Opacity_Tex` 采样参与底部透明度计算。预览中 Ribbon 呈暗灰主体和亮边。该图说明黑色缝隙、边缘强度和 Opacity 纹理共同塑造 Ribbon 透明度与边缘。

### 00:42:11-00:46:19 粒子、颜色、透明度

- 本段定位：粒子、颜色、透明度。
- 知识点：后面的黑色区域会更宽广。
- 知识点：这一部分是头部对应的。
- 知识点：颜色平铺的情况下。
- 知识点：施针处理正在运行。
- 知识点：扩散平铺是最重要的。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`粒子`、`颜色`、`透明度`、`动态参数`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 打开材质实例 `M_Ribbon_01_Ins_01`。右侧 Details 的 `Global Scalar Parameter Values` 中可见：`Black_Bias=2.0`、`Color_Tile_U=0.5`、`Color_Tile_V=0.5`、`Desaturation=0.0`、`Diff_Tile_U=1.0`、`Edge_Pow=0.5`、`Edge_Str=1.0`、`Normal_Tile_U=0.5`、`Normal_Tile_V=0.5`、`Opacity_Pow=0.5`、`Opacity_Str=5.0`、`RGB_Offset=0.01`。`Global Texture Parameter Values` 中 `Color_Tex` 使用 `T_CloudScape_08_Details`，`Normal_Tex` 使用 `T_CloudScape_08_Details_N`，`Opacity_Tex` 使用一个黑白贴图槽。预览中 Ribbon 头部区域有暗灰主体、淡蓝/淡彩边缘和半透明尖端。
> 图表转写（UE-GTXT v4）
> 仍在 `M_Ribbon_01_Ins_01`，右侧参数与上一图基本相同，但 `Black_Bias=3.0`、`Edge_Pow=1.0` 可见；`Color_Tile_U/V=0.5`、`Diff_Tile_U=1.0`、`Opacity_Str=5.0`、`RGB_Offset=0.01` 仍保留。预览中 Ribbon 的黑色/暗部区域更宽，边缘更收紧。该图用于对比材质实例参数调整后，黑色缝隙和边缘衰减对透明度形态的影响。
> 图表转写（UE-GTXT v4）
> 回到 `Projectile_01` Niagara System，`Ribbon` 发射器选中 `Dynamic Material Parameters`。右侧 `Distortion` 使用 `Float from Curve`，曲线面板可见 `Curve for Floats`，横轴 0 到 1，红色曲线随生命周期缓慢上升；`CurveIndex` 绑定 `PARTICLES NormalizedAge`，`Scale Curve=1.0`。下方 `RandomU` 仍为 `Random Range Float`，`Minimum=0.0`、`Maximum=3.0`、`Evaluation Type=Spawn Only`、`Randomness Mode=Deterministic`，`Random Seed=Particles.RibbonID`；`Dissolve=1.0`，`Param3=0.0`。预览区显示灰白 Ribbon 条带，说明动态参数已从材质实例参数回到 Niagara 曲线控制。

## 补充视觉证据

### S01 00:01:49

> 图表转写（UE-GTXT v4）
> 补充截图显示 `Ex_Projectile_01` 关卡与 `Projectile_01` Niagara System 并排打开。左侧关卡视口处于 `Pilot Active - Cine Camera Actor`，Sequencer 中可见 `Cine Camera Actor / CameraComponent` 参数轨道，字段包括 `Current Aperture=2.8`、`Current Focal Length=35.0`、`Intensity(Post Proce)=3.0`、`Manual Focus Distance=100000.0`、`Size scale(Post Proc)=2.0`；下方还有 `Phase GDC`、`Projectile 01`、多个 `Projectile Exp 01` 轨道及 `Spawned` 子轨。右侧 `Projectile_01` 中选中 `Empty` 发射器的 `Sprite Renderer`，预览区为 1 个白色 Sprite 粒子；Selection 面板可读 `Material=DefaultSpriteMaterial`、`Source Mode=Particles`、`Material User Param Binding=None`、`Alignment=Unaligned`、`Facing Mode=Face Camera`、`Sort Mode=None`，Bindings 使用 `PARTICLES Position`、`PARTICLES Color`、`PARTICLES Velocity`、`PARTICLES SpriteRotation`、`PARTICLES SpriteSize`、`PARTICLES SpriteFacing`、`PARTICLES SpriteAlignment` 等属性。该图补充说明 p18 开始阶段仍保留上一阶段 Projectile 序列、摄像机轨道与基础 Sprite Renderer 状态。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。

