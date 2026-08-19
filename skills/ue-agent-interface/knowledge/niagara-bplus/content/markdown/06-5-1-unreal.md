# 06 - 5-1创造unreal的丝带步道效应

# 06 - 5-1创造unreal的丝带步道效应

## 关键术语

- `Color`、`Ribbon`、`Material`、`Multiply`、`Opacity`、`Normal`、`Texture`、`Actor`、`材质`、`后处理`、`粒子`、`速度`、`Niagara`、`Particle`、`Renderer`、`纹理`、`Niagara System`、`Emitter`

## 分段知识

### 00:00:00-00:04:38 Material、材质、后处理

- 本段定位：Material、材质、后处理。
- 知识点：这次后续会接着上次制作的材质资源来进行。
- 知识点：需要利用在Foxsense中制作的资源来创建一个主台制。
- 知识点：在此之前,有些人需要适当设置一下,所以需要先解释那部分。
- 知识点：首先,我们来看看这次势力所用的资源。
- 知识点：我们现在进行中的这个项目是从第一部分开始生成并进行的。
- 知识点：在这里可观察到可以创建材质并放入的选项。
- 知识点：在这里渲染特性中,添加后处理材质之后,将其更改为资传引用。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Material`、`材质`。

**关键画面：**

- 画面说明：该画面用于引入本节主题或展示阶段性效果目标，不包含需要单独复现的 Niagara 参数、模块顺序或节点关系；本节复现以正文中的模块、参数和检查项为准。
这是一张 Unreal Editor 场景准备界面截图，用来说明本节将在现有工程里继续补充材质与后处理资源，而不是展示具体 Niagara 节点。

可见界面与状态：

- 主视口中是一个空白测试关卡，地面为棋盘格 `Floor`，右侧 `Outliner` 中可见：
  - `Lighting`
  - `DirectionalLight`
  - `SkyLight`
  - `Floor`
  - `PlayerStart`
- 当前选中对象是 `Floor`，右侧 `Details` 面板显示其基础信息：
  - `Location: (0.0, 0.0, -0.5)`
  - `Rotation: (0.0, 0.0, 0.0)`
  - `Scale: (8.0, 8.0, 8.0)`
- `Materials` 区域可见 `Element 0` 已指定一个材质实例，名称开头显示为 `MI_Proc...`

当前操作意图：

- 底部 `Content Browser` 已定位到 `Content > Signature > Course_02 > Material`
- 画面下方可见多个材质缩略图，字幕说明“在这个级别上，我们将添加一个帖子功能”，结合本段标题可判断作者正在为后处理/材质演示准备测试场景与资源目录。

输出/结果理解：

- 这张图的作用是交代工程场景、资源目录和材质准备位置。
- 由于正文已明确此类画面不包含需要单独复现的 Niagara 参数、模块顺序或节点关系，因此复现重点不是照抄场景数值，而是确认后续材质资源确实放在对应工程目录并能在该测试关卡里调用。
这张图继续说明本节使用的材质资源路径，并强调后处理材质文件要放在正确目录中，便于后续在场景里的 `PostProcessVolume` 调用。

可见界面与状态：

- `Content Browser` 位于 `Content > Signature > Course_02 > Material`
- 资源缩略图区可见至少 3 个材质资源：
  - `PP_...`
  - `PP_...`
  - `UVTest`
- 同时打开了一个系统文件资源管理器窗口，路径与编辑器一致，列表中可见：
  - `05_Material`（压缩包）
  - `PP_Sharpen_Material.uasset`
  - `PP Sharpen Material Ins 01.uasset`
  - `UVTest.uasset`

场景侧状态：

- 右侧 `Outliner` 当前选中 `PostProcessVolume`
- `Details` 面板定位到该对象的后处理设置区域
- `Post Process Materials` 区域可见 `1 Array element`，说明当前体积里已经准备挂接后处理材质

当前操作意图：

- 字幕明确提示“确保路径准确无误是非常重要的”
- 结合本段“Material、材质、后处理”的主题，这一步是在核对外部导入或复制进来的材质文件是否落在 UE 工程正确目录，并确认场景中的 `PostProcessVolume` 能引用这些资源

输出/结果理解：

- 复现时需要保证材质资产在工程内容路径下真实存在，且 `PostProcessVolume` 的 `Post Process Materials` 数组能正确引用目标后处理材质。
- 这张图依然不提供 Niagara 模块参数，重点是资源路径和场景挂接关系。

### 00:04:38-00:09:33 材质、后处理、粒子

- 本段定位：材质、后处理、粒子。
- 知识点：这是用后期功能制作的一个效果材质。
- 知识点：这里一个是主材质,一个是实力材质。
- 知识点：我们把这个实力材质放到这个箭头里。
- 知识点：现在不要试图理解这个材质,只要把它当作一种效果。
- 知识点：我们上次制作的材质已经这样拖过来了。
- 知识点：这个材质是我们上次第一部分制作的材质。
- 知识点：,所以这是和第一部分的纹理一起制作的人。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`材质`、`纹理`、`贴图`、`粒子`、`颜色`、`动态参数`。

**关键画面：**

这是 `PP_Sharpen_Material` 的材质图，属于后处理材质。当前截图展示的是一个典型的“以屏幕 UV 为基准，做多次偏移采样，再把采样结果累加平均”的锐化/邻域采样结构。

节点定义集：

- `TexCoord[0]`
  - 提供基础屏幕 UV。
- 4 个绿色常量节点
  - 可见数值包括 `0.0`、`0.001`、`-0.001`、`-0.001`，用于构造采样偏移。
- 4 个 `Append`
  - 把两路标量组合成二维偏移向量。
- 4 个 `Add`
  - 将 `TexCoord` 与各自偏移向量相加，得到 4 组偏移 UV。
- 多个 `SceneTexture:PostProcessInput0`
  - 用不同 UV 读取后处理输入画面颜色。
- 右侧 3 个 `Add`
  - 逐步把多路采样结果相加。
- 1 个 `Divide`
  - 将累加结果除以一个常量。
- 绿色常量 `4.0`
  - 作为 `Divide` 的分母。

连线集：

- 若干标量常量两两进入 `Append`
- `TexCoord[0]` 同时连接到多组 `Add`
- 每个 `Append` 输出分别进入对应 `Add` 的另一输入端
- 各组 `Add` 结果进入不同的 `SceneTexture:PostProcessInput0` 的 `UVs`
- 多个 `SceneTexture:PostProcessInput0` 的 `Color` 输出依次进入右侧 `Add`
- 累加结果进入 `Divide`
- 常量 `4.0` 进入 `Divide` 的分母输入

设置/参数：

- 左侧 `Details` 面板可确认：
  - `Material Domain: Post Process`
  - `Blend Mode: Opaque`
  - `Shading Model: Default Lit`
- 材质预览球可见，说明当前正在直接编辑后处理材质资源本体而不是实例
- 截图未完整显示最终输出端名称，无法可靠确认最终接到 `Emissive Color`、`Base Color` 还是 `Post Process` 专用输出引脚；只能确认右侧仍有后续连接

输出/预览：

- 从节点形态和命名可确认，这是一种基于 `PostProcessInput0` 的屏幕采样材质，用来制作后处理锐化或边缘增强类效果。
- 本图对应正文“利用后期功能制作的一个效果材质”，重点是先理解它基于多次屏幕采样，而不是立即拆解每个公式细节。
这张图展示的是纹理资源 `T_Ribbon_03` 的查看界面。画面中央是一张横向细长、中心最亮、向两端渐暗的灰度条纹纹理，适合给 Ribbon 或细长拖尾类效果作为亮度/透明度遮罩。

资源与预览信息：

- 资源名称：`T_Ribbon_03`
- 顶部通道按钮可见 `R / G / B / A`，当前在纹理查看器中检查通道内容
- 中央预览分辨率比例明显为横向长条，视觉上是“中间亮、两端暗、边缘柔和过渡”的细带状纹理

右侧可确认设置：

- `Imported: 512x64`
- `Displayed: 512x64`
- `Max In-Game: 512x64`
- `Resource Size: 21 KB`
- `Has Alpha Channel: False`
- `Source Alpha Detected: False`
- `Number of Mips: 10`
- `Encode Speed: Final`
- `Texture Group: World`
- `Compression Settings: Default (DXT1/5, BC1/3 on DX11)`
- `sRGB: True`
- `X-axis Tiling Method: Wrap`
- `Y-axis Tiling Method: Wrap`

用途理解：

- 这正对应正文中“像细线一样的这个材质/纹理是上次第一部分制作的内容”
- 复现时可把它理解为一张为丝带材质准备的基础亮度贴图：中心提供主亮带，两端自然衰减，方便在材质里接到 `Opacity`、`Emissive` 或颜色调制链上使用
这是 `M_Ribbon_01` 材质图中的一段局部连接，作用是在材质里读取 `Dynamic Parameter`，并把其中一路参数拼成二维偏移，只沿 `U` 方向影响纹理坐标。

节点定义集：

- `Dynamic Parameter`
  - 材质输入节点，提供来自 Niagara 或粒子系统的动态参数。
  - 画面中可见：
    - `Parameter Index: 0`
    - `Param2` 输出已接线
- 绿色常量 `0`
  - 数值为 `0.0`
- `Append`
  - 将动态参数的一路输出与常量 `0` 组合成二维向量
- `TexCoord[0]`
  - 提供基础纹理坐标
- `Add(1)`
  - 用于把 `TexCoord[0]` 与偏移结果相加，字幕说明此偏移“只在 U 方向”

连线集：

- `Dynamic Parameter` 的 `Param2` -> `Append.A`
- 常量 `0.0` -> `Append.B`
- `TexCoord[0]` -> `Add(1).A`
- 由 `Append` 形成的二维偏移向量应接入 `Add(1)` 的另一输入端，但截图中该段连接末端未完整落入画面，只能根据当前可见走线确认其用途

设置/参数：

- 左侧 `Details` 面板可确认该材质当前为：
  - `Material Domain: Surface`
  - `Blend Mode: Opaque`
  - `Shading Model: Default Lit`
- 材质预览窗口当前只有一个基础平面预览，说明作者在局部编辑 UV 控制逻辑而不是看最终复杂效果

输出/预览：

- 结合字幕“我会把它连接到第一个，只在 U 方向”，可确认这里的核心意图是把动态参数映射成水平 UV 偏移，用于后续控制丝带纹理在 U 轴上的滚动、随机位移或拉伸变化。
- 这也对应正文提到的“动态参数命名和类型必须稳定”，因为材质已经开始直接消费粒子侧传入的动态值。

### 00:09:33-00:14:05 Opacity、Normal、Texture

- 本段定位：Opacity、Normal、Texture。
- 知识点：为了让随机值适当不同, 需要把这个随机粒子使用。
- 知识点：命名为Plastic. 四代应该使用这种横向的材质。
- 知识点：如果你想调整这一部分,也可以将其制作成参数。
- 知识点：后续会在这里的Opacity线连接。
- 知识点：需要把它统一成立为Opacity,不叫Beep。
- 知识点：查看参数时,可以对每个参数进行分组。
- 知识点：当我们打开实地窗的插件, 我们可观察到它们的参数。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Opacity`、`Texture`、`材质`、`纹理`、`粒子`、`透明度`。

**关键画面：**

这是 `M_Ribbon_01` 材质图里用于“给每条丝带一个随机 U 向偏移”的局部节点连接。作者在这里把粒子传进来的动态参数组合成二维偏移，再加到原始纹理坐标上，避免每条 Ribbon 采样同一段纹理而显得过于一致。

节点定义集：

- `Dynamic Parameter`
  - 材质输入节点，用来接收粒子系统传来的动态值。
  - 当前画面可见：
    - `Parameter Index: 0`
    - `Param2` 已接线使用
- 绿色常量 `0`
  - 数值 `0.0`
- `Append`
  - 把 `Param2` 与 `0` 组合成二维向量，形成“只在一个方向生效”的偏移量
- `Add`
  - 将该偏移量叠加到另一组坐标输入上，右侧可见 `A`、`B` 两个输入都已接线

连线集：

- `Dynamic Parameter.Param2` -> `Append.A`
- 常量 `0.0` -> `Append.B`
- `Append` 输出 -> `Add` 的一侧输入
- `Add` 的另一侧输入来自画面外左下角已有连线，结合前后图可判断它是基础纹理坐标链

设置/参数：

- 左侧 `Details` 面板可确认当前材质仍为：
  - `Material Domain: Surface`
  - `Blend Mode: Opaque`
  - `Shading Model: Default Lit`
- 字幕语义明确指出这里的用途是“为了给随机的偏移值”，并说明如果没有这个偏移，不同丝带会显得非常相似

输出/预览：

- 这一段逻辑的核心不是立刻改变材质颜色，而是先改变后续采样使用的 UV 坐标。
- 复现时应把它理解为：为每个粒子或每条 Ribbon 提供独立的 U 方向随机采样起点，使同一张横向条纹贴图在不同丝带上看起来不完全重复。
这一张继续展开 `M_Ribbon_01` 的纹理坐标控制链，重点是把横向平铺参数、滚动速度参数和时间输入组合起来，驱动 `Opacity` 贴图在 U 方向平铺并滚动。

节点定义集：

- 左侧 `Add`
  - 承接上一段的基础 UV 偏移结果。
- `Opacity_Tile_U`
  - 标量参数，当前显示 `Default Value: 1.0`
  - 用于控制 `Opacity` 纹理在 U 方向的平铺倍率
- 绿色常量 `1`
  - 数值 `1.0`
- `Append`
  - 将 `Opacity_Tile_U` 与常量 `1.0` 组合成二维缩放向量
- `Multiply`
  - 用来把左侧 UV 与该平铺向量相乘
- `Time`
  - 时间输入节点
- `Diff_Speed`
  - 标量参数，当前为选中状态
  - `Parameter Name: Diff_Speed`
  - `Default Value: 0.0`
- 绿色常量 `0`
  - 数值 `0.0`
- 右下 `Append`
  - 把 `Diff_Speed` 与 `0.0` 组合成二维速度向量
- `Panner`
  - 用上方 `Coordinate` 输入和下方 `Time`、`Speed` 输入驱动 UV 滚动
- 右侧 `Add(1)`
  - 将 `Panner` 结果再与另一组偏移值叠加后送往后续采样链

连线集：

- 左侧 `Add` -> `Multiply.A`
- `Opacity_Tile_U` -> 左下 `Append.A`
- 常量 `1.0` -> 左下 `Append.B`
- 左下 `Append` -> `Multiply.B`
- `Multiply` -> `Panner.Coordinate`
- `Time` -> `Panner.Time`
- `Diff_Speed` -> 右下 `Append.A`
- 常量 `0.0` -> 右下 `Append.B`
- 右下 `Append` -> `Panner.Speed`
- `Panner` -> `Add(1)` 的一侧输入
- `Add(1)` 的另一输入来自上一段的随机偏移链

设置/参数：

- 左侧 `Details` 当前显示的是 `Diff_Speed` 参数详情：
  - `Parameter Name: Diff_Speed`
  - `Default Value: 0.0`
  - `Slider Min: 0.0`
  - `Slider Max: 0.0`
- 从节点命名和接法可确认：
  - `Opacity_Tile_U` 负责横向平铺
  - `Diff_Speed` 负责滚动速度
  - `Panner` 只在 U 方向运动，因为速度向量的第二维被固定为 `0`

输出/预览：

- 这段链路直接对应正文中“后续会在这里的 Opacity 线连接”“如果想调整这一部分，也可以将其制作成参数”。
- 复现时应把它理解为：先用参数控制横向重复次数，再用 `Panner` 控制贴图沿 U 方向流动，从而让 Ribbon 的透明遮罩具有可调的平铺与动态效果。
这一张继续展示 `M_Ribbon_01` 的贴图采样区，但焦点已经从单纯的 `Opacity` 平铺转到“哪一组 UV 应该接到哪张贴图”上。字幕“啊不是这个，应该放这个”说明作者正在调整接线，把正确的 UV 链路接到上方的 `DistorTex` 贴图参数。

节点定义集：

- `DistorTex`
  - `Param2D` 贴图参数节点，缩略图为纯蓝色，说明它很可能用于法线/扭曲类纹理采样
  - 右侧提供 `RGB`、`R`、`G`、`B`、`A`、`RGBA` 输出
- 上方 `Multiply`
  - 用于把一组平铺向量与坐标链相乘后，送入 `DistorTex.UVs`
- 上方 `Append`
  - 将两路标量合成二维向量
- `Normal_Tile_V`
  - 标量参数，当前可见 `Default Value: 1.0`
  - 结合命名可知它负责法线/扭曲纹理在 V 方向的平铺控制
- 中部 `Append`
  - 一路输入来自画面外左侧，另一路接绿色常量 `0`
- 绿色常量 `0`
  - 数值 `0.0`
- 中部 `Add`
  - 把中部 `Append` 结果与另一组基础坐标相加
- 下方 `Opacity_Tile_U`
  - 标量参数，`Default Value: 1.0`
- 下方 `Append`
  - 将 `Opacity_Tile_U` 与另一速度参数组合
- `Opacity_Speed`
  - 标量参数节点，位于右下，当前只看到名称
- `Time`
  - 时间输入节点
- 右下 `Multiply`
  - 接在中部 `Add` 后方
- `Panner`
  - 位于最右下，继续接收 `Coordinate`、`Time`、`Speed` 三类输入

连线集：

- `Normal_Tile_V` -> 上方 `Append` 的一侧输入
- 上方 `Append` -> 上方 `Multiply`
- 上方 `Multiply` -> `DistorTex.UVs`
- 中部 `Append` -> 中部 `Add` 的一侧输入
- 绿色常量 `0.0` -> 中部 `Append` 的一侧输入
- 中部 `Add` -> 右下 `Multiply`
- `Opacity_Tile_U` -> 下方 `Append` 的一侧输入
- `Opacity_Speed` -> 下方速度相关链路
- `Time` -> `Panner.Time`
- 右下 `Multiply` -> `Panner.Coordinate`
- `Panner.Speed` 来自下方参数拼接链

设置/参数：

- 左侧 `Details` 仍显示当前材质为：
  - `Material Domain: Surface`
  - `Blend Mode: Opaque`
  - `Shading Model: Default Lit`
- 可明确识别到的参数名：
  - `Normal_Tile_V`
  - `Opacity_Tile_U`
  - `Opacity_Speed`
  - `DistorTex`
- 由于截图处在“改接线”的瞬间，部分导线来源与终点超出画面边界；只能确认作者正在把合适的 UV 链接到 `DistorTex`，而不能可靠补写完整的最终采样网络

输出/预览：

- 这张图说明该材质不只处理透明遮罩，还在并行准备另一张扭曲/法线类贴图的 UV 控制。
- 复现时应把它理解为：`Opacity` 和 `DistorTex/Normal` 各自有独立但相似的平铺、偏移、滚动控制链，作者正在把正确的那条 UV 输出接给正确的贴图参数。

### 00:14:05-00:17:36 Color、Ribbon、Multiply

- 本段定位：Color、Ribbon、Multiply。
- 知识点：接下来要进行扭曲 关于这个的强度将在这个桥的动画里控制 也就是说在Nibiru Particle中控制。
- 知识点：这样来定 并且关于这个强度的部分在这里 Color Texture也会适当加一点进去 而且这个Dynamic也给Parameter起个名字。
- 知识点：看起来更有意义吧 Rotation 需要把它命名为Random U 就是Instruction的默认值为0 然后这样看起来就会更整齐 先插入到MF。
- 知识点：Color中 R已设置为Stress Res 在Instance中改为Edited 这样放进去应该没问题 这样设置后我先保存资源 已经保存了。
- 知识点：这里的Color部分 稍后再做就是先处理Occasity的部分 在上次的前两节课中介绍过 Ribbon Tiling的方法 Tiling是如何在某种标准下变成Webbing的。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Particle`、`Color`、`Texture`、`Multiply`、`透明度`。

**关键画面：**

这是 `M_Ribbon_01` 材质图中更靠右的一段采样与强度控制链。当前画面同时展示了两条并行逻辑：下方是 `Opacity_Tex` 的 UV 滚动采样链，上方是蓝紫色扭曲/法线贴图经 `Mask(RG)` 后再乘强度的链路。

节点定义集：

- 上方蓝紫色贴图采样节点
  - 截图未完整显示参数名，但可明确看到它是一张带 `UVs` 输入和 `RGB/R/G/B/A/RGBA` 输出的贴图参数采样节点
  - 预览缩略图是蓝紫色法线/扰动纹理
- `Mask (R G)`
  - 从该贴图采样中提取 `R`、`G` 两个通道
- 右上 `Multiply`
  - 当前被选中，用于把 `Mask(RG)` 结果与另一条强度输入相乘
- 中下 `Add`
  - 接在下方 UV 链起点位置
- 下方 `Append`
  - 为平铺/速度向量提供二维组合
- 下方 `Multiply`
  - 将平铺向量与 UV 链相乘
- `Time`
  - 时间输入节点
- `Opacity_Speed`
  - 标量参数，当前可见 `Default Value: 0.0`
- 右下 `Append`
  - 将速度参数与另一维常量拼成二维速度向量
- `Panner`
  - 负责驱动 `Opacity_Tex` 的 UV 滚动
- `Add(1)`
  - 在 `Panner` 输出后继续叠加偏移
- `Opacity_Tex`
  - `Param2D` 贴图参数节点，缩略图可见一条白色能量丝带

连线集：

- 上方蓝紫色贴图采样 -> `Mask (R G)` -> 右上 `Multiply`
- 一条来自画面外左侧的长连线进入右上 `Multiply` 的另一输入，作为扭曲强度控制
- 中下 `Add` -> 下方 `Multiply`
- 左下参数拼接链 -> 下方 `Multiply` 的另一输入
- 下方 `Multiply` -> `Panner.Coordinate`
- `Time` -> `Panner.Time`
- `Opacity_Speed` 所在链 -> `Panner.Speed`
- `Panner` -> `Add(1)` -> `Opacity_Tex.UVs`

设置/参数：

- 左侧 `Details` 当前显示为 `Material Expression Multiply`
  - `Const A: 0.0`
  - `Const B: 1.0`
- `Opacity_Speed` 参数当前默认值可见为 `0.0`
- 字幕“关于这个的强度将在桥的动画里控制”可与右上 `Multiply` 的结构对应，说明扭曲/法线贴图强度会由外部动画或粒子侧参数驱动

输出/预览：

- 下方链负责让 `Opacity_Tex` 这张白色丝带纹理能够平铺、滚动并带随机偏移。
- 上方链则把一张蓝紫色扭曲纹理压成 `RG` 向量，再乘一个外部强度，为后续对丝带进行扭曲或法线扰动做准备。
这一张把 `M_Ribbon_01` 的中段 UV 控制图拉得更完整，核心信息是：作者已经把动态参数正式命名为 `Distortion` 和 `Random_U`，并让它们分别参与扭曲强度与随机 U 偏移控制。

节点定义集：

- `Dynamic Parameter`
  - 当前画面中清楚显示了两个已命名输出：
    - `Distortion`
    - `Random_U`
  - 其中 `Random_U` 已接入下方 `Append`，`Distortion` 以一条长连线送往右侧上方链路
- 绿色常量 `0`
  - 数值 `0.0`
- 中部 `Append`
  - 将 `Random_U` 与 `0.0` 组合成二维偏移向量
- `TexCoord[0]`
  - 基础纹理坐标输入，当前被选中
- 中部 `Add`
  - 将 `TexCoord[0]` 与随机偏移相加
- `Opacity_Tile_U`
  - 标量参数，默认值 `1.0`
- 绿色常量 `1`
  - 数值 `1.0`
- 下方 `Append`
  - 将 `Opacity_Tile_U` 与常量 `1.0` 拼成二维平铺向量
- 下方 `Multiply`
  - 用平铺向量缩放上一步 UV
- `Time`
  - 时间输入
- `Opacity_Speed`
  - 标量参数，默认值 `0.0`
- 右下 `Append`
  - 把 `Opacity_Speed` 与常量 `0.0` 组合成二维速度向量
- `Panner`
  - 驱动 `Opacity_Tex` 的 UV 滚动
- 上方 `Normal_Tile_V`
  - 标量参数，默认值 `1.0`
- 上方 `Append` + `Multiply`
  - 构成另一条给 `DistorTex` 使用的平铺链
- `DistorTex`
  - 蓝紫色 `Param2D` 贴图参数
- `Mask (R G)`
  - 取 `DistorTex` 的 `RG` 通道
- 右侧 `Multiply`
  - 把 `Mask(RG)` 结果与 `Distortion` 强度相乘

连线集：

- `Dynamic Parameter.Random_U` -> 中部 `Append.A`
- 常量 `0.0` -> 中部 `Append.B`
- 中部 `Append` -> 中部 `Add.B`
- `TexCoord[0]` -> 中部 `Add.A`
- 中部 `Add` -> 下方 `Multiply.A`
- `Opacity_Tile_U` -> 下方 `Append.A`
- 常量 `1.0` -> 下方 `Append.B`
- 下方 `Append` -> 下方 `Multiply.B`
- 下方 `Multiply` -> `Panner.Coordinate`
- `Time` -> `Panner.Time`
- `Opacity_Speed` 链 -> `Panner.Speed`
- 上方 `Normal_Tile_V` 所在链 -> 上方 `Multiply` -> `DistorTex.UVs`
- `DistorTex` -> `Mask (R G)` -> 右侧 `Multiply`
- `Dynamic Parameter.Distortion` -> 右侧 `Multiply` 的另一输入

设置/参数：

- 左侧 `Details` 当前显示 `TexCoord[0]`：
  - `Coordinate Index: 0`
  - `UTiling: 1.0`
  - `VTiling: 1.0`
- 这张图最关键的命名信息是：
  - 动态参数一路命名为 `Distortion`
  - 另一路命名为 `Random_U`
- 这与正文“强度在 Niagara Particle 中控制”“Rotation 需要命名为 Random U”直接对应

输出/预览：

- 左侧材质预览已经出现黑底白色丝带效果，说明当前链路足以驱动实际可见结果。
- 复现时可以把这张图当作本段的命名与职责总图：
  - `Random_U` 负责每条 Ribbon 的横向随机采样起点
  - `Opacity_Tile_U` 与 `Opacity_Speed` 负责遮罩贴图的平铺与流动
  - `Distortion` 负责蓝紫扭曲贴图的干预强度
这一张聚焦在 `Opacity` 贴图采样结果进入亮度/透明度整形的局部。作者把 `Opacity_Tex` 的采样结果送进 `Power`，再乘一个常量，用参数来控制整条丝带遮罩的锐利程度或对比强度。

节点定义集：

- `Opacity_Tex`
  - 左侧可见部分贴图参数采样节点，预览缩略图是黑底白色丝带
  - 当前使用其 `RGB` 输出
- `Opacity_Pl`
  - 标量参数节点，当前被选中
  - `Default Value: 1.0`
- `Power`
  - 使用贴图结果作为 `Base`，使用 `Opacity_Pl` 作为 `Exp`
  - 作用是通过指数调节改变遮罩亮部与暗部的分布
- 绿色常量 `1`
  - 数值 `1.0`
- `Multiply`
  - 将 `Power` 输出与常量相乘，再送往更右侧的后续链

连线集：

- `Opacity_Tex.RGB` -> `Power.Base`
- `Opacity_Pl` -> `Power.Exp`
- `Power` -> `Multiply.A`
- 常量 `1.0` -> `Multiply.B`
- `Opacity_Tex.RGB` 另有一条长连线继续送往画面外右侧上方，说明同一采样结果还被复用在其他输出链

设置/参数：

- 左侧 `Details` 当前显示 `Opacity_Pl` 的参数属性：
  - `Parameter Name: Param`
  - `Default Value: 1.0`
  - `Slider Min: 0.0`
  - `Slider Max: 0.0`
- 从节点名称可读到作者想把它作为 `Opacity` 相关指数参数使用，但截图中左侧详情里的正式参数名尚未同步改成更语义化名称，因此当前可确认信息以节点标题 `Opacity_Pl` 为准

输出/预览：

- 这段结构对应正文里“如果你想调整这一部分，也可以将其制作成参数”“先处理 Opacity 的部分”。
- 复现时可把 `Opacity_Pl` 理解为一个用来压缩或放大遮罩对比度的指数参数：
  - 指数变大时，白色主线会更集中、更硬
  - 指数接近 `1` 时，基本保持原始 `Opacity_Tex` 的灰度分布

### 00:17:39-00:22:20 Normal、材质、粒子

- 本段定位：Normal、材质、粒子。
- 知识点：用这个可以进行很多应用 还可以制作图像 除了这种构成 尝试创作您自己的构成 也一定会对您有所帮助 嗯 我这样做并不意味着这是唯一正确的答案。
- 知识点：需要再添加一点渐变感觉 嗯 我又进行了渐变运算 现在最后是粒子颜色 嗯 然后这样这样这样这样 现在最后是粒子颜色。
- 知识点：我用个透明度连接了 嗯 现在透明的纹理抖动就这样出来了嘛 嗯 那么颜色部分也会接着连接 这里需要添加一次分组 就是normal 这种事情就有点麻烦。
- 知识点：不过如果做的话以后会方便很多 嗯 然后我就会把这个陈述样式结构复制过来 这里引入相同的坐标 进行添加 外框值将具有相同的透明度和相同的外框值。
- 知识点：需要连接到颜色纹理上 嗯 这个已经更改了默认值 嗯 这是调节颜色纹理饱和度的 这个是必须要加上的 这个默认值应该是0 然后在调节这个颜色的时候。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`、`粒子`、`颜色`、`透明度`。

**关键画面：**

这是 `M_Ribbon_01` 中 `Opacity` 采样结果进入最终透明度整形的一段清晰局部。与上一段相比，这张图额外确认了材质本体已经切到适合特效丝带的透明无光照设置。

节点定义集：

- 左侧 `Add`
  - 为 `Opacity_Tex` 提供最终 `UVs` 输入，具体上游偏移链在画面外
- `Opacity_Tex`
  - `Param2D` 贴图参数，缩略图为黑底白色丝带
  - 当前使用其 `RGB` 输出
- `Opacity_Pow`
  - 标量参数，`Default Value: 1.0`
  - 接入 `Power.Exp`
- `Power`
  - `Base` 来自 `Opacity_Tex.RGB`
  - `Exp` 来自 `Opacity_Pow`
  - 用于调节透明遮罩的明暗分布和边缘硬度
- `Opacity_Str`
  - 标量参数，`Default Value: 1.0`
  - 接入后续 `Multiply`
- `Multiply`
  - 将 `Power` 输出乘以 `Opacity_Str`
  - 结果继续送往画面外右侧的最终输出链

连线集：

- 左侧 `Add` -> `Opacity_Tex.UVs`
- `Opacity_Tex.RGB` -> `Power.Base`
- `Opacity_Pow` -> `Power.Exp`
- `Power` -> `Multiply.A`
- `Opacity_Str` -> `Multiply.B`
- `Opacity_Tex.RGB` 另有一条长连线直通右侧画面外，表示同一贴图采样还被其他链路复用

设置/参数：

- 左侧 `Details` 可明确确认当前材质本体为：
  - `Material Domain: Surface`
  - `Blend Mode: Translucent`
  - `Shading Model: Unlit`
- 这说明作者已经把原先用于搭图的材质切换成真正的特效渲染模式，后续透明度、颜色和发光都将基于无光照透明材质输出
- 可确认参数：
  - `Opacity_Pow = 1.0`
  - `Opacity_Str = 1.0`

输出/预览：

- 左侧预览是黑底白色丝带，说明当前 `Opacity` 链已经能驱动可见的透明拖尾轮廓。
- 复现时可把这段理解为两个可调旋钮：
  - `Opacity_Pow` 控制遮罩对比与边缘收紧程度
  - `Opacity_Str` 控制整体透明强度
这一张展示的是作者把前面用于透明抖动/扭曲的坐标结构复制出来，并继续叠加到另一张纹理采样上的过程。重点不在新增全新算法，而在“复用同一套坐标链，再做一次 Add 叠加”。

节点定义集：

- 上方 `Texture Sample`
  - 预览缩略图是一张灰白色噪声/云纹贴图
  - 带 `UVs` 输入和 `RGB/R/G/B/A/RGBA` 输出
- `Add(0,1)`
  - 当前被选中，左侧 `Details` 显示：
    - `Const A: 0.0`
    - `Const B: 1.0`
  - 它位于上方 `Texture Sample` 之前，用于对该贴图采样坐标做额外偏移
- 中部 `Mask (R G)`
  - 从上游扭曲/法线类采样中提取 `RG`
- 中部 `Multiply`
  - 对 `Mask(RG)` 结果与另一条控制量相乘
- 下方 `Add`
  - 把中部 `Multiply` 结果叠加到另一组 UV 链
- `Opacity_Tex`
  - 位于右下，继续作为白色丝带贴图采样节点
  - 当前通过 `UVs` 接收来自下方 `Add` 的结果

连线集：

- 一条来自画面外左侧上方的连线进入 `Add(0,1)`，再进入上方 `Texture Sample.UVs`
- 另一条来自左侧的曲线输入进入 `Mask (R G)`
- `Mask (R G)` -> 中部 `Multiply`
- 中部 `Multiply` -> 下方 `Add`
- 下方 `Add` -> `Opacity_Tex.UVs`
- `Opacity_Tex.RGB` 继续向右侧画面外输出

设置/参数：

- 左侧 `Details` 当前显示 `Add(0,1)`：
  - `Const A: 0.0`
  - `Const B: 1.0`
- 从正文“复制过来，引入相同的坐标，进行添加”以及字幕“进行添加”可以确认：
  - 这里的核心操作是把已存在的坐标/扭曲结构复用到另一张纹理上
  - 外框值、透明度或颜色相关输入会沿用同类参数体系，而不是重新另起一套完全不同的坐标逻辑

输出/预览：

- 左侧材质预览中的白色丝带已经出现更明显的断续与局部亮部变化，说明这次额外叠加正在改变最终纹理内部细节。
- 复现时可把这张图理解为“复制同类 UV 扭曲结构到另一张采样纹理上，再做一次 Add 混合”，为后续颜色纹理接入做准备。
这一张把“Normal 这一组参数”和“颜色纹理接入后的去饱和控制”同时放到了画面里。它证明作者已经开始整理参数分组与命名，而不是只顾着把节点连通。

节点定义集：

- `Normal_Tile_U`
  - 标量参数，当前被选中
  - `Default Value: 0.5`
- `Normal_Tile_V`
  - 标量参数
  - `Default Value: 0.5`
- `Append`
  - 将 `Normal_Tile_U` 与 `Normal_Tile_V` 组合成二维平铺向量
- 上方 `Multiply`
  - 用平铺向量作用在颜色/噪声纹理的采样坐标上
- 上方 `Add`
  - 将上一步结果与另一条坐标输入继续相加后送往右侧 `Texture Sample`
- 右侧 `Texture Sample`
  - 缩略图为灰白色噪声贴图，代表颜色纹理或其调制底图
- `DistorTex`
  - 左下蓝紫色 `Param2D` 贴图参数
- `Mask (R G)`
  - 从 `DistorTex` 提取 `RG` 通道
- 下方 `Multiply`
  - 将 `Mask(RG)` 结果继续放大或调制，然后送往上方坐标链
- `Desaturation`
  - 标量参数，`Default Value: 0.0`
  - 接到右侧一个名为 `Des...` 的颜色处理节点，显然用于控制颜色纹理的去饱和程度

连线集：

- `Normal_Tile_U` -> `Append.A`
- `Normal_Tile_V` -> `Append.B`
- `Append` -> 上方 `Multiply`
- 上方 `Multiply` -> 上方 `Add`
- 上方 `Add` -> 右侧 `Texture Sample.UVs`
- `DistorTex` -> `Mask (R G)` -> 下方 `Multiply`
- 下方 `Multiply` 的输出向上送入上方 `Add`，参与颜色纹理的 UV 扰动
- 右侧 `Texture Sample` 输出继续送往右侧画面外的颜色处理链
- `Desaturation` 参数 -> 右侧 `Des...` 处理节点

设置/参数：

- 左侧 `Details` 当前明确显示：
  - `Parameter Name: Normal_Tile_U`
  - `Default Value: 0.5`
  - `Slider Min: 0.0`
  - `Slider Max: 0.0`
  - `Group: Normal`
- 画面中 `Normal_Tile_V` 也同样设置为 `0.5`
- 字幕“这里需要改一下名字”与正文“需要添加一次分组，就是 normal”相互印证，说明作者此时正在规范参数命名与分组，方便后续做材质实例

输出/预览：

- 左侧预览中的丝带已经开始带有轻微暖色与更复杂的内部层次，说明颜色纹理链已经接进来了，不再只是单纯的透明遮罩。
- 复现时可把这张图理解为两件事同时完成：
  - 用 `Normal_Tile_U/V` 把扭曲/法线类坐标参数归入 `Normal` 组
  - 给颜色纹理额外增加一个 `Desaturation` 参数，便于后续在实例里调节颜色饱和度

### 00:22:20-00:27:17 Opacity、Texture、材质

- 本段定位：Opacity、Texture、材质。
- 知识点：比如说再添加一个组 然后现在大部分似乎都在定型中 我们用这个来创建实例看看效果吧 已经创建了实例 在我们创建的这个组内 这个参数被分类。
- 知识点：呢 所以才创建了参数组 而且如果想让材质 总是在其他参数之上 如果想让其他的在上面 比如说 如果想让其他的在上面 其他的确实在上面 如果改变。
- 知识点：需要尝试提高它 较小的数字 变为0号 就这样定位 不常用这些东西的话常常会搞混 因为需要了解很多部分 那么基本的材质制作。
- 知识点：这可以说是我默认使用的方式 也有一些人使用外国的二重三重 这种OpacityTexture。
- 知识点：有太多不必要的运算 如果需要的话当然要加进去 为了那种表现 其实这种计算是必不可少的 增加纹理样等也是。
- 知识点：对性能来说并不是很好 所以如果能在这里感性地表现出来 优先使用最简化的马斯克材质 如果感觉无法表达时 可以开发新的马斯克材质。
- 知识点：可以更进一步开发新的集箱物材质 但是基本的结构是 不会限于这个框架太多 材质制作就这样进行过了。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Opacity`、`Texture`、`材质`、`纹理`、`粒子`、`拖尾`。

**关键画面：**

这一张把颜色纹理链的参数化结构完整摆出来了：作者开始给颜色贴图单独提供 `U/V` 平铺参数、去饱和参数，并继续复用下方 `DistorTex -> Mask(RG)` 的扭曲链来扰动颜色纹理的 UV。

节点定义集：

- `Color_Tile_U`
  - 标量参数，`Default Value: 0.5`
- `Color_Tile_V`
  - 标量参数，`Default Value: 0.5`
- `Append`
  - 将 `Color_Tile_U` 与 `Color_Tile_V` 组合成二维平铺向量
- 上方 `Multiply`
  - 用颜色平铺向量去缩放颜色纹理采样坐标
- 上方 `Add`
  - 把缩放后的坐标与下方扭曲偏移继续相加
- `Color_Tex`
  - `Param2D` 贴图参数，缩略图为灰白色云纹/噪声纹理
- 右侧 `Desaturation`
  - 实际的去饱和处理节点
- 下方 `Desaturation`
  - 标量参数，`Default Value: 0.0`
  - 作为去饱和处理的控制量
- `DistorTex`
  - 左下蓝紫色 `Param2D` 贴图参数
- `Mask (R G)`
  - 从 `DistorTex` 提取 `RG`
- 下方 `Multiply`
  - 将 `Mask(RG)` 结果与其他控制量相乘，再送入上方 `Add`

连线集：

- `Color_Tile_U` -> `Append.A`
- `Color_Tile_V` -> `Append.B`
- `Append` -> 上方 `Multiply`
- 上方 `Multiply` -> 上方 `Add.A`
- 下方扭曲链输出 -> 上方 `Add.B`
- 上方 `Add` -> `Color_Tex.UVs`
- `Color_Tex.RGB` -> 右侧 `Desaturation.Input`
- 参数 `Desaturation` -> 右侧 `Desaturation.Fraction`
- `DistorTex` -> `Mask (R G)` -> 下方 `Multiply` -> 上方 `Add`

设置/参数：

- 左侧 `Details` 当前显示的被选参数默认值是 `0.5`
- `Group` 仍显示为 `Normal`
- `Parameter Name` 里还能看到旧名 `Multiple Values`
- 结合画面中的节点标题 `Color_Tile_U / Color_Tile_V` 与正文“需要连接到颜色纹理上”“这是调节颜色纹理饱和度的”可判断：
  - 作者正在把旧的、不语义化的参数重命名为颜色链专用参数
  - 同时开始整理参数分组，但此刻仍可能存在尚未完全改完的旧名/旧组

输出/预览：

- 左侧材质预览已经出现带微弱暖色和层次变化的丝带，说明颜色纹理链已真正参与最终结果。
- 复现时可把这张图理解为颜色链的总入口：
  - `Color_Tile_U/V` 控制颜色纹理平铺
  - 下方 `DistorTex` 扭曲链控制颜色纹理扰动
  - `Desaturation` 参数控制颜色纹理的饱和度衰减
这一张把 `M_Ribbon_01` 的中后段总图拉出来了，能够同时看到三条关键链路：颜色纹理链、透明遮罩链、以及最终和 `Particle Color` 相乘的输出汇总。

节点定义集：

- 颜色纹理链
  - `Color_Tex`
  - `Desaturation` 处理节点
  - 右侧 `Multiply`
  - 负责把颜色纹理经过去饱和处理后送入最终颜色合成
- 扭曲/法线链
  - `DistorTex`
  - `Mask (R G)`
  - `Multiply`
  - 为颜色链和透明链提供共同的 UV 扰动来源
- 透明遮罩链
  - `Panner`
  - `Opacity_Tex`
  - `Power`
  - `Opacity_Pow`
  - `Opacity_Str`
  - 多个 `Multiply`
  - 负责生成最终透明度/遮罩强度
- 粒子颜色链
  - `Particle Color`
  - 位于右侧中部，作为来自 Niagara 粒子的颜色输入
- 最终汇总乘法节点
  - 右侧可见多组 `Multiply`
  - 分别将颜色纹理结果、粒子颜色、透明遮罩结果组合后送往最终输出

连线集：

- `DistorTex` -> `Mask (R G)` -> `Multiply` -> 同时影响上方颜色纹理链和下方 `Opacity_Tex` 的 UV 链
- `Panner` -> `Opacity_Tex.UVs`
- `Opacity_Tex.RGB` -> 一路进入 `Power`
- `Opacity_Pow` -> `Power.Exp`
- `Power` -> `Multiply`
- `Opacity_Str` -> 同一透明度乘法链
- `Color_Tex.RGB` -> `Desaturation`
- `Desaturation` 结果 -> 右侧颜色乘法链
- `Particle Color.RGBA` -> 右侧另一条乘法链
- 颜色结果、粒子颜色结果、透明遮罩结果在右侧多级 `Multiply` 中汇总

设置/参数：

- 左侧 `Details` 再次确认当前材质本体为：
  - `Material Domain: Surface`
  - `Blend Mode: Translucent`
  - `Shading Model: Unlit`
- 这一张没有放大单个参数详情，重点在于结构已经定型，并且材质实例 `M_Ribbon_01_Ins_01` 标签也出现在顶部，说明作者正在边搭边准备验证实例效果

输出/预览：

- 左侧预览中的丝带已经带有明显的明暗层次和轻微色偏，表明颜色链与透明链已共同工作。
- 复现时可把这张图理解为“最终合成草图”：
  - 颜色纹理提供基础色相/明暗变化
  - `Particle Color` 提供粒子级颜色控制
  - `Opacity_Tex` 及其参数链提供可调透明度
  - 这些结果最终通过乘法方式汇总为丝带材质输出
这一张已经离开材质编辑器，进入 Niagara 系统 `Ex_01_RibbonTrail` 的总览界面，说明本段材质搭建到这里基本告一段落，接下来开始把材质真正挂到粒子和 Ribbon 轨迹效果上。

可见系统结构：

- 当前打开的 Niagara 资源：`Ex_01_RibbonTrail`
- 左侧是 `Preview` 预览面板
  - 当前显示：
    - `Particle Counts`
    - `0 Current, 0 Max (est.) - [Empty] [Active]`
- 中央 `System Overview` 里有两个主要面板：
  - 系统面板 `Ex_01_RibbonTrail`
    - `Properties`
    - `User Parameters`
    - `System Spawn`
    - `System Update`
    - `System State`
  - 发射器面板 `Empty`
    - `Properties`
    - `Emitter Summary`
    - `Emitter Spawn`
    - `Emitter Update`
    - `Emitter State`
    - `Particle Spawn`
    - `Initialize Particle`
    - `Particle Update`
    - `Particle State`
    - `Render`
    - `Sprite Renderer`

当前阶段理解：

- 这是一个从空白发射器开始的 Niagara System 骨架
- 现阶段还没有生成粒子，所以预览里计数为 `0`
- 字幕“移动的粒子的轨迹”明确指出接下来要利用运动中的粒子路径来构造拖尾/Ribbon 效果

设置/参数：

- 本图不展示具体模块参数值，重点是系统层级和接下来工作的载体
- 可确认当前发射器仍是 `Empty` 模板，渲染器里暂时看到的是 `Sprite Renderer`，后续很可能会继续改为或补充 `Ribbon Renderer`

输出/预览：

- 这张图的作用是建立从“材质制作”切到“Niagara 粒子系统搭建”的上下文边界。
- 复现时应理解为下一阶段会围绕这个 `Empty` 发射器，配置粒子生成、速度、生命周期以及 Ribbon/拖尾渲染，让刚刚完成的丝带材质真正出现在运动粒子的轨迹上。
### 00:27:17-00:30:15 粒子、速度

- 本段定位：粒子、速度。
- 知识点：不如在这里做一个毛 作为这个角色 来尝验证效果也不错 但它有点太大了 适度一些 这样这样 在这里在这里 其他粒子也会一起占据一些位置。
- 知识点：要远一些 好的需要记住这一点 好的需要注意这一点 然后这个也拿出来吧 原来不是Malinas啊 是的 就在前面 这样做 可以把它看作是角色。
- 知识点：如果散上层像魔法一样 扩放开了就好了 对吧 如果Particle直接生产出来的话 就有点无聊了 像是某种施法一样 像施法一样 积聚力量后瞬间爆发出来。
- 知识点：我来试着做一个有趣的演出 首先需要有剧绩的效果 先用Self做一次 这个设定为每2秒一次 试试看 在Rest时 大约看Cedar。
- 知识点：从Initialize开始验证效果 大约0.5秒的速度 因为瞬间想要剧绩 所以积分均匀 适当有点长调行地移动 评论加速 适当有点长调行地移动。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Particle`、`粒子`、`速度`。

**关键画面：**

这张图回到 Unreal Editor 关卡视图，作者在 `Content Browser` 中定位到粒子资源目录，准备把刚搭好的 `Ex_01_RibbonTrail` Niagara System 拿到场景里做角色/轨迹效果测试。

可见界面与状态：

- `Content Browser` 当前路径：
  - `Content > Signature > Course_02 > Particle`
- 资源区当前只明显显示一个 Niagara 资源：
  - `Ex_01_RibbonTrail`
  - 资源类型标签可见为 `Niagara Sys...`
- 左侧目录树中同级还能看到：
  - `Level`
  - `Material`
  - `Particle`
  - `Texture`

场景侧状态：

- 主视口仍是空白测试关卡，右侧 `Outliner` 当前选中的是 `PostProcessVolume`
- 右侧 `Details` 面板显示 `PostProcessVolume (Instance)` 的属性
- 这说明作者还在同一个测试关卡里，把材质、后处理和 Niagara 资源都集中在同一套验证环境中

当前操作意图：

- 字幕“不如在这里做一个……作为角色”结合正文“作为这个角色来尝试验证效果也不错”可理解为：
  - 作者准备以场景中的某个临时对象或位置作为运动主体
  - 用 `Ex_01_RibbonTrail` 来观察轨迹拖尾是否成立

输出/结果理解：

- 这张图的作用是把工作从“材质搭建完成”切换到“把 Niagara System 放进关卡做效果验证”。
- 复现时重点不是关卡数值，而是确认粒子系统资源位于 `Particle` 目录，并可从内容浏览器直接拖入或绑定到测试场景中。
这张图显示 `Ex_01_RibbonTrail` 已经被真正放进关卡场景，并开始围绕一个简单球体参照物来调位置和演出范围。

可见场景与对象：

- `Outliner` 中当前已存在：
  - `Ex_01_RibbonTrail`
  - `Floor`
  - `PlayerStart`
  - `PostProcessVolume`
  - `SkyLight2`
  - `Sphere`
- 当前选中对象为 `Ex_01_RibbonTrail`
- 视口中央可见一个小球体，明显是拿来代替角色或锚点的临时参照物

右侧可确认设置：

- 选中对象：`Ex_01_RibbonTrail (Instance)`
- `Transform`
  - `Location: (1000.0, -10.0, 160.0)`
  - `Rotation: (0.0, 0.0, 0.0)`
  - 第三个角度或附加显示处可见 `160.0`，但截图布局与滚动条遮挡使其语义不完全稳定；能可靠确认的是当前实例已经被抬离地面并移到前方区域
- `Niagara System Asset`
  - 指向 `Ex_01_Ribb...`

当前操作意图：

- 正文里提到“它有点太大了，适度一些”“要远一些”，这与当前场景摆位一致：作者在不断调系统实例与参照球体的相对位置，寻找一个更适合观察拖尾的测试距离
- 字幕“原来不是 Minus 啊”也说明此时正在细调位置数值方向

输出/结果理解：

- 这一步的重点是先把 Niagara System 放到关卡里，并和一个简单几何体一起确定测试基准位置。
- 复现时可以先用 `Sphere` 或任意简单 Actor 作为角色占位，再把 `Ex_01_RibbonTrail` 实例移到合适的前方高度，方便后续验证轨迹和速度表现。
这张图回到 Niagara `Ex_01_RibbonTrail`，开始真正搭第一个源发射器。当前发射器已经从 `Empty` 改成 `Source_01`，并且作者正在 `Initialize Particle` 中先用较短 `Lifetime` 做瞬发聚集效果测试。

可见系统结构：

- 当前 Niagara System：`Ex_01_RibbonTrail`
- 发射器名称：`Source_01`
- 左侧预览状态：
  - `Particle Counts: 0 Current, 7 Max (est.) - [Source_01] [Active]`
- 发射器栈中可见模块：
  - `Properties`
  - `Emitter Summary`
  - `Emitter Spawn`
  - `Emitter Update`
  - `Emitter State`
  - `Spawn Burst Instantaneous`
  - `Particle Spawn`
  - `Initialize Particle`
  - `Particle Update`
  - `Particle State`
  - `Render`
  - `Sprite Renderer`

设置/参数：

- `Emitter State`
  - 模式显示为 `Self`
  - 频次显示为 `Once`
- `Initialize Particle` 右侧详情中可确认：
  - `Lifetime Mode: Direct Set`
  - `Lifetime: 0.5`
  - `Color Mode: Unset`
  - `Position Mode: Simulation Position`
  - `Mass Mode: Unset / (Mass of 1)`
- `Sprite Size Mode` 下拉菜单已打开，可见候选：
  - `Unset`
  - `Uniform`
  - `Random Uniform`
  - `Non-Uniform`
  - `Random Non-Uniform`

当前操作意图：

- 正文提到“先用 Self 做一次”“设定为每 2 秒一次试试看”“从 Initialize 开始验证效果，大约 0.5 秒的速度，因为瞬间想要聚集”
- 与截图相符的已确认信息是：
  - 先使用一次性自驱的发射器状态
  - 先把 `Lifetime` 设为 `0.5`
  - 准备进一步调整粒子尺寸模式和后续运动参数，营造先聚集再爆发的演出

输出/结果理解：

- 这张图是从“只有系统骨架”进入“开始填第一批核心粒子生命周期参数”的起点。
- 复现时应先把源发射器改名为 `Source_01`，使用 `Self/Once` 的发射模式，再在 `Initialize Particle` 里用较短寿命测试聚集式爆发感，之后再继续调速度、尺寸与轨迹。

## 补充视觉证据

### S02 00:09:20

这是 `S02` 的补充节点图，用来更明确地说明 `Dynamic Parameter` 的某一路值只被接入二维向量的第一维，也就是只影响纹理坐标的 `U` 方向偏移。

节点定义集：

- `Dynamic Parameter`
  - 材质输入节点
  - 当前可见：
    - `Parameter Index: 0`
    - `Param2` 已接线
- `Append`
  - 把一维动态值和另一维常量/默认值组合成二维向量
- `TexCoord[0]`
  - 位于左下方，提供基础纹理坐标
- `Add(1)`
  - 位于右下方
  - `B` 端直接显示常量 `1.0`
  - `A` 端接收来自左侧的纹理坐标链

连线集：

- `Dynamic Parameter.Param2` -> `Append.A`
- `Append` 的另一输入 `B` 在本图中未接线，结合字幕和前后图可确认作者的意图是让第二维保持固定，不参与偏移
- `TexCoord[0]` -> `Add(1).A`
- `Add(1)` 的输出继续送往画面外后续链路

设置/参数：

- 左侧 `Details` 可确认当前材质本体仍是：
  - `Material Domain: Surface`
  - `Blend Mode: Opaque`
  - `Shading Model: Default Lit`
- 字幕明确说明：“我会把它连接到第一……只在 U 方向。”
- 因此本图的可靠结论是：
  - 动态参数只用于横向 `U` 偏移
  - 不让 `V` 方向同时变化，避免纹理在垂直方向产生不必要的漂移

输出/预览：

- 这张补图比正文主图更清楚地证明了随机偏移方案的坐标语义：只扰动第一维。
- 复现时应把粒子侧传入的随机值只接到 `U` 方向，保留 `V` 方向稳定，这样横向丝带贴图既能显得不重复，又不会破坏纵向结构。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。

