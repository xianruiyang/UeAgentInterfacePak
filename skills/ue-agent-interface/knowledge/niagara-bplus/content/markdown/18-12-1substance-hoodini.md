# 18 - 12-1Substance纹理和Hoodini网格资源

# 18 - 12-1Substance纹理和Hoodini网格资源

## 关键术语

- `Spawn`、`Ribbon`、`UV`、`Substance`、`Photoshop`、`Curve`、`材质`、`网格`、`拖尾`、`透明度`、`纹理`、`Niagara`、`Normalized Age`、`Renderer`、`生命周期`、`颜色`、`Niagara System`、`Emitter`

## 分段知识

### 00:00:00-00:02:48 Spawn、UV、材质

- 本段定位：Spawn、UV、材质。
- 知识点：制作第二个所需的资源。
- 知识点：需要在霍提尼制作一个简单的半球网格带回去。
- 知识点：呢,我打算用Subsistence Designer制作大约三张纹理。
- 知识点：这个反正是一个非常简单的网格, 然后很快就能完成。
- 知识点：需要制作一种像保护膜一样的护盾效果。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Spawn`、`材质`、`纹理`。

**关键画面：**

本图是本节开场的工作环境说明画面，软件已经切到 Houdini 的 `/obj` 层级，准备开始制作“第二个所需资源”。左侧是空白透视视口，中央网络区显示 `Empty Network - Press Tab to Add Nodes`，右侧参数面板也还没有选中任何操作节点，说明此时还没有真正开始搭建几何体或材质网络。

从界面可直接确认的状态有：

- 顶部标签位于 Houdini 的对象层级环境
- 当前路径栏显示在 `/obj`
- 中央网络视图为空网络
- 右侧提示 `No Operator Selected`

结合本段正文“需要在霍提尼制作一个简单的半球网格带回去”“制作一种像保护膜一样的护盾效果”，这张图的作用是交代接下来资源制作的起点：先在 Houdini 里新建并组织网格，而不是直接进入 Niagara 或材质编辑。按图复建时，可把它理解为后续网格资源制作的零状态起点。
这张图展示了在 Houdini 里把基础球体裁成后续护盾网格的步骤。中央网络区当前只有两级几何链：

- `sphere1`
- `clip1`

即先创建一个球体，再用 `Clip` 节点按平面裁切。左侧视口中能看到一个接近球体上半部的形体，说明当前已经在用裁切平面去掉一部分球面，为“半球/护罩”轮廓做准备。

右侧当前选中的是 `clip1`，能直接确认的参数有：

- 节点类型：`Clip`
- `Clip Attribute`：`P`
- `Keep`：`Primitives Above the Plane`
- `Orient Plane with`：`Direction`
- `Origin`：`0, 0, 0`
- `Direction`：`0, 1, 0`
- `Distance`：`0`
- `Snapping Tolerance`：`1e-05`
- `Fill Polygons along Clipping Plane`：未勾选
- `Output Groups > Replace Existing`：已勾选

结合字幕“所以我们会用它来填补这个空间”，这一步的可复建含义是：教程先以完整球体为基础，再通过 `clip1` 沿指定方向切掉不需要的部分，为后续进一步整理网格厚度、开口或 UV 打基础。当前图中还没有出现更复杂的拓扑操作，重点就是“球体 + 裁切平面”这条最初几何链。
这张图说明半球网格在 Houdini 中已经进入 UV 整理阶段。中央网络区可见当前几何链为：

- `sphere1`
- `clip1`
- `uvtexture1`
- `uvedit1`

即在裁切球体之后，先生成 UV，再用 `uvedit1` 手动调整布局。左侧视口已经切到 `UV View`，能看到一整块矩形 UV 壳铺在 0-1 区域内，当前操作手柄是一根沿水平方向的红色箭头；字幕“这里先对齐左右放置”也说明此时正在做左右方向的对齐和平移。

右侧当前选中的是 `uvedit1`，从参数面板能直接确认：

- 节点类型：`UV Edit`
- `Group`：`0-575`
- `Group Type`：`Primitives`
- `UV Attribute`：`uv`
- `Transform Order`：`Scale Rot Trans`
- 轴顺序：`Rx Ry Rz`
- `Translate`：`-0.0183188, 0, 0`
- `Rotate`：`0, 0, 0`
- `Scale`：`1, 1, 1`
- `Shear`：`0, 0, 0`
- `Pivot`：`0.520833, 0.676059, 0.403987`

`Soft Settings` 分区还可见：

- `Soft Radius`：`1`
- `Soft Type`：`Cutoff`

因此这张图的重点不是新增几何，而是把生成出来的 UV 壳往左右方向对位，确保后续纹理沿球面/护盾展开时位置更可控。按图复建时，应先保证 `uvtexture1` 已经提供基础 UV，再在 `uvedit1` 中用平移对齐当前这整块 UV。

### 00:02:57-00:05:49 UV

- 本段定位：UV。
- 知识点：按按键可以以现况模式来查看。
- 知识点：这个程度应该没有什么影响。
- 知识点：这样制作UV就可以带走了。
- 知识点：我们来看一下UV。
- 知识点：结果是怎样的呢? 从0到1转了一圈,然后这里是0。

**关键画面：**

这张图进入正文标注的 `UV` 段，仍然停在 `uvedit1` 的 UV 调整界面，但当前操作方向已经从左右平移变成了上下方向的对位。左侧 `UV View` 里，整块 UV 壳仍然占据大部分 0-1 区域，手柄变成一根竖直的紫色箭头，说明当前在沿 `V` 方向移动整块 UV。

中央网络区保持同一条链：

- `sphere1`
- `clip1`
- `uvtexture1`
- `uvedit1`

右侧 `uvedit1` 参数中，可直接确认当前变换值为：

- `Translate`：`0, -0.15065, 0`
- `Rotate`：`0, 0, 0`
- `Scale`：`1, 1, 1`
- `Pivot`：`0.500219, 0.67606, 0.403987`
- `Group`：`0-575`
- `UV Attribute`：`uv`

`Soft Settings` 仍可见：

- `Soft Radius`：`1`
- `Soft Type`：`Cutoff`

结合本段正文“按按键可以以现况模式来查看”“这样制作UV就可以带走了”，这一步的可复建目的就是把整块 UV 在纵向位置上再校正一次，避免展开后顶部/底部落点不理想。也就是说，这张图表达的是同一块 UV 壳的第二次对位：前一张偏重左右，这一张偏重上下。
这张图把 UV 检查切回了三维模型视口。左侧能看到一个带彩色分区的球体/半球测试模型：表面覆盖了数字方格测试纹理，颜色从红、黄过渡到绿色，说明教程正在用可视化贴图检查 UV 在模型上的分布方向与环绕关系，而不是继续只看平面 UV 壳。

中央网络区当前链条已经在 `uvedit1` 后追加了一个属性处理节点：

- `sphere1`
- `clip1`
- `uvtexture1`
- `uvedit1`
- `vertexvop1`

右侧当前选中的是 `vertexvop1`，从参数面板可直接确认：

- 节点类型：`Attribute VOP`
- 节点名：`vertexvop1`
- `Group Type`：`Guess from Group`
- `Run Over`：`Vertices`
- `Vex Source`：`Myself`
- `Enable Multithreading`：已勾选

视口中的颜色与数字方格验证了本段正文“从 0 到 1 转了一圈，然后这里是 0”的说法：当前 UV 是沿球面周向连续展开并绕了一整圈，绿色分区附近与另一侧的接缝位置一起帮助判断 `U` 坐标从起点到终点的回绕方式。按图复建时，这一步的重点是确认 UV 的环绕方向与接缝位置是否符合后续护盾纹理的流动需求。
这张图仍然是 UV 结果的三维检查，但相机角度已经切得更低、更正面，能更清楚看到当前几何体实际是一个开口朝下的半球护罩，而不是完整球体。左侧视口里，测试贴图沿半球表面连续铺开：顶部接近红色，主体大部分为黄绿色，右侧有一条更集中的绿色接缝区域。这说明教程此时是在确认半球版本的 UV 是否已经足够稳定，可以暂时不再继续调整。

中央网络链保持不变：

- `sphere1`
- `clip1`
- `uvtexture1`
- `uvedit1`
- `vertexvop1`

右侧当前仍选中 `vertexvop1`，可确认的参数与上一张一致：

- `Run Over`：`Vertices`
- `Vex Source`：`Myself`
- `Enable Multithreading`：已勾选

结合字幕“暂时不做更改”，这张图的关键结论不是新增节点，而是一次验收判断：

- 当前 UV 在半球护罩上的分布已经基本可用
- 周向接缝位置已能被清楚识别
- 顶部到侧面的颜色/数字过渡连续，没有明显断裂

按图复建时，可以把这一步视为 UV 阶段的暂时收口点：先接受这套展开结果，后续再把资源带去 Substance 或材质阶段继续使用。

### 00:05:59-00:08:58 Substance、材质、破碎

- 本段定位：Substance、材质、破碎。
- 知识点：因为有单独提取的消息。
- 知识点：因为有单独保留的没吸。
- 知识点：我们就来切换到substance这个工作。
- 知识点：需要从最简单的材质开始制作。
- 知识点：将使用circle gradation的方法。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`。

**关键画面：**

这张图虽然已经进入正文标注的 `Substance、材质、破碎` 段，但画面本身仍停留在 Houdini 里对基础护罩网格做收尾整理。左侧视口继续显示带数字方格测试贴图的半球护罩，说明当前主要是在确认网格与 UV 的最终输出状态，而不是已经进入 Substance 节点图制作。

中央网络区可直接确认当前几何链在前一批基础上又追加了两个节点：

- `sphere1`
- `clip1`
- `uvtexture1`
- `uvedit1`
- `vertexvop1`
- `transform1`
- `OUT`

右侧当前选中的是最终输出节点 `OUT`，参数面板显示：

- 节点类型：`Null`
- 节点名：`OUT`
- `Copy Input`：已勾选
- `Cache Input`：未勾选

这张图表达的重点是：教程先把半球护罩网格的 UV 检查链封装成一个可导出的几何输出，再进入后续纹理制作流程。按图复建时，可以把 `transform1 -> OUT` 理解为网格资源导出前的最后整理与命名出口，而不是新的材质步骤。
本图正式切到 `Adobe Substance 3D Designer`，开始制作本段提到的最简单基础纹理。当前图里还没有形成复杂节点链，中央图表区只有一个起始节点：

- `Shape`，分辨率标注为 `1024x1024 - L16`

当前可确认的节点状态与参数如下：

- 节点类型：`Shape`
- 右上预览显示为一张纯白形状输出
- 左侧 `shape - PROPERTIES` 中可见 `Tiling Mode`
- `Random Seed`：`0`
- `INSTANCE PARAMETERS > Tiling`：`1`
- `Pattern` 下拉框已展开，当前选择高亮在 `Disc`
- 其余可见候选包括 `Square`、`Paraboloid`、`Bell`、`Gaussian`、`Brick`、`Gradation`、`Waves`

输出/预览：

- 右上 2D 预览窗口当前显示一整块白色结果
- 预览分辨率标注为 `1024 x 1024 | Grayscale 16bpp`
- 底部状态提示 `No output node defined`

这张图的可复建结论是：教程先用 `Shape` 节点生成一个最基础的圆盘型灰度遮罩，作为后续护盾纹理的原始轮廓输入。按图操作时，重点是先把 `Pattern` 切到 `Disc`，得到一个干净的圆形基底，再考虑后面的细节变化与破碎处理。
这张图已经进入一个可复建的基础 Substance 灰度节点图，用来把圆形基底处理成带细微层次的环形护盾纹理。

节点定义集：

- `Blur HQ Grayscale`：输入是一张圆环轮廓，节点缩略图显示黑底上的细白环，用作后续被斜坡模糊的主灰度形状。
- `Shape`：输出一个中心亮、边缘渐暗的模糊圆盘，作为 `Slope Blur` 的扰动/斜坡输入。
- `Slope Blur Grayscale`：当前选中节点，作为合成输出节点，缩略图与右上预览都显示黑底上的多层细环。

连线集：

- 左上游节点输出 -> `Blur HQ Grayscale`
- `Blur HQ Grayscale.Output` -> `Slope Blur Grayscale.Grayscale`
- `Shape.Output` -> `Slope Blur Grayscale.Slope`

设置/参数：

- 所有当前可见节点分辨率均标为 `1024x1024 - L16`
- 当前选中 `slope_blur_grayscale_2`
- `Height`：`0`
- `Output Format`：`16 Bits per Channel`
- `Pixel Size`：`Width 1`、`Height 1`
- `Pixel Ratio`：`Square`
- `Random Seed`：`0`
- `INSTANCE PARAMETERS > Samples`：`8`
- `Intensity`：`10`
- `Mode`：下拉项可见但当前具体值未完整显示

输出/预览：

- 右上预览窗口显示一张黑底细环纹理，中心完全镂空，外圈由多层非常接近的暗灰细线组成
- 预览分辨率标注为 `1024 x 1024 | Grayscale, 16bpc`
- 当前图表底部仍提示 `No output node defined`

这张图的核心做法是：先得到一个平滑环形，再用 `Shape` 作为 `Slope` 输入驱动 `Slope Blur Grayscale`，把原本较干净的圆环边缘打出多层细微起伏。按图复建时，至少要保证 `Grayscale` 和 `Slope` 两个输入端的连接关系与图中一致，否则无法得到这种多圈叠出的暗环效果。

### 00:09:01-00:12:30 Curve、材质、网格

- 本段定位：Curve、材质、网格。
- 知识点：不过这里不是模糊的。
- 知识点：有种层次感更丰富的感觉。
- 知识点：可能是因为单元格适当小了些。
- 知识点：反正这里是飘散的颜色。
- 知识点：让这个手表的边缘不那么明显。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Curve`、`材质`、`颜色`。

**关键画面：**

这张图继续停在同一套 Substance 灰度节点图上，但重点已经从“搭结构”转到“调环形层次”。图表区仍然只显示三块关键节点：

节点定义集：

- `Blur HQ Grayscale`：提供细白圆环作为主灰度输入。
- `Shape`：提供白色圆盘作为 `Slope` 输入。
- `Slope Blur Grayscale`：当前选中，用来把结果整理成更厚、更均匀的环形层。

连线集：

- `Blur HQ Grayscale.Output` -> `Slope Blur Grayscale.Grayscale`
- `Shape.Output` -> `Slope Blur Grayscale.Slope`

设置/参数：

- 当前选中 `slope_blur_grayscale_2`
- `Output Format`：`16 Bits per Channel`
- `Pixel Size`：`Width 1`、`Height 1`
- `Pixel Ratio`：`Square`
- `Random Seed`：`0`
- `INSTANCE PARAMETERS > Samples`：`32`
- `Intensity`：`10`
- `Mode` 下拉框已展开，可见候选包括 `Blur`、`Min`、`Max`
- 当前字段框内可见值为 `Blur`

输出/预览：

- 右上预览显示黑底上的粗暗环，已经比上一张的多层细线更厚、更平滑
- 预览分辨率仍为 `1024 x 1024 | Grayscale, 16bpc`

结合字幕“不过这里不是模糊的”，这张图表达的是作者正在对 `Slope Blur Grayscale` 的工作模式和采样强度做比较，尝试让环形既保留层次，又不要只剩普通模糊圈。按图复建时，至少要先把 `Samples` 提高到 `32`，再围绕 `Mode` 做对比观察，比较哪一种更接近目标护盾边缘。
这张图把前面的环形灰度结果继续送进 `Curve` 节点，目的是重新抬亮边缘层次。中央图表区当前可见的主链为：

节点定义集：

- 左侧上游灰度节点：缩略图已被截去名字，但输出是一个左亮右暗的弧形片。
- `Blur HQ Grayscale`：把弧形轮廓进一步处理成较平滑的圆环。
- `Curve`：当前选中，用曲线重映射灰度亮度。

连线集：

- 左侧上游节点 `Output` -> `Blur HQ Grayscale.Input`
- `Blur HQ Grayscale.Output` -> `Curve.Input`

设置/参数：

- 当前选中 `Curve`
- 节点分辨率显示为 `1024x1024 - L16`
- 右侧 `Curve - PROPERTIES` 处于 `Luminance` 模式
- 曲线编辑器中可见多控制点，当前曲线在右上端被明显上提，说明高亮区被增强
- 左侧竖向黑白条作为输入亮度参考，底部刻度可见约 `0.18`

输出/预览：

- 右上预览显示黑底上的亮环，环边比前一张更清晰，外圈也带有轻微雾化层次
- 预览分辨率为 `1024 x 1024 | Grayscale, 16bpc`

结合字幕“因为这个亮度太低了”，这张图的可确认作用是：作者认为上一步的环形结果整体偏暗，所以在 `Curve` 中把高亮区域往上提，让主环边缘更显眼。按图复建时，应把重点放在曲线后段的提升，而不是误把这一步当成新增形状节点。
这张图给出了当前环形护盾纹理的完整 Substance 输出链，已经从单纯的灰度处理推进到带颜色映射并接出正式 `Output`。

节点定义集：

- `Blur HQ Grayscale`：上游环形模糊节点，提供主环轮廓。
- `Shape`：白色圆盘形状，作为 `Slope Blur` 的辅助输入。
- `Slope Blur Grayscale`：把基础圆环打出层次变化。
- `Blur HQ Grayscale`：第二个模糊节点，对 `Slope Blur` 后结果再做平滑整理。
- `Curve`：提升亮环亮度与对比。
- `Auto Levels`：自动拉伸明暗范围。
- `Gradient Map`：把灰度结果映射到颜色输出。
- `Output`：最终输出节点。

连线集：

- `Blur HQ Grayscale(上游).Output` -> `Slope Blur Grayscale.Grayscale`
- `Shape.Output` -> `Slope Blur Grayscale.Slope`
- `Slope Blur Grayscale.Output` -> `Blur HQ Grayscale(下游).Input`
- `Blur HQ Grayscale(下游).Output` -> `Curve.Input`
- `Curve.Output` -> `Auto Levels.Input`
- `Auto Levels.Output` -> `Gradient Map.Input`
- `Gradient Map.Output` -> `Output.Input`

设置/参数：

- 左侧大部分灰度节点分辨率显示为 `1024x1024 - L16`
- `Gradient Map` 节点分辨率显示为 `512x512 - C16`
- `Output` 节点分辨率显示为 `512x512 - C16`
- 当前选中的是 `output`
- 右侧 `output - PROPERTIES` 可见 `Identifier`：`output`
- `Description`、`Label`、`User Data`、`Group` 当前为空

输出/预览：

- 右上预览显示黑底上的亮白圆环，边缘更锐利，外圈仍保留一层柔和雾化
- 预览分辨率标注为 `512 x 512 (RGBA, 16bpc)`

这张图的意义是把前面做出的灰度护盾环，经过 `Curve` 和 `Auto Levels` 调整后，再通过 `Gradient Map` 变成可直接输出的颜色纹理。按图复建时，除了保证灰度链本身正确，还要注意最终输出已切换为 `RGBA`、`512x512` 的颜色结果，而不是停留在中间灰度图。

### 00:12:33-00:15:32 关键流程 05

- 本段定位：关键流程 05。
- 知识点：需要再制作一个部分。
- 知识点：我打算以这种形式进行。
- 知识点：拿出一个尾影造波。
- 知识点：做过波动形状对吧。
- 知识点：会以那种形式来制作。

**关键画面：**

这张图展示的是前面那条环形护盾纹理流程被整理成正式 Substance 图谱后的状态。左侧 `EXPLORER` 已经不是未命名包，而是一个名为 `Shield.sbs` 的工程；其下有一个图谱条目 `Circle`，说明作者把当前这套圆环纹理单独保存成了可复用图。

节点定义集：

- `Blur HQ Grayscale`：上游灰度环形节点
- `Shape`：圆盘形状节点
- `Slope Blur Grayscale`
- 第二个 `Blur HQ Grayscale`
- `Curve`
- `Auto Levels`
- `Gradient Map`
- `output`

连线集：

- `Blur HQ Grayscale(上游)` 与 `Shape` 一起驱动 `Slope Blur Grayscale`
- `Slope Blur Grayscale -> Blur HQ Grayscale(下游) -> Curve -> Auto Levels -> Gradient Map -> output`

设置/参数：

- 当前打开的图谱名：`Circle - GRAPH`
- 右侧当前显示的是 `Circle - PROPERTIES`
- `BASE PARAMETERS > Output Size`：`Width 0 (Parent x 1)`、`Height 0 (Parent x 1)`
- `Output Format`：`8 Bits per Channel`
- `Pixel Size`：`Width 1`、`Height 1`
- `Pixel Ratio`：`Square`
- `Tiling Mode`：`H and V Tiling`
- `Random Seed`：`0`

输出/预览：

- 右上预览仍显示黑底亮白圆环
- 预览分辨率为 `512 x 512 (RGBA, 16bpc)`

这张图的重点不是新增纹理结构，而是把当前圆环材质流程固定为名为 `Circle` 的图谱，便于后面继续派生其他护盾/尾影用纹理。按图复建时，应注意这里已经从“临时节点实验”进入“保存并命名图谱”的阶段。
这张图表明作者已经在同一个 `Shield.sbs` 包里新开了第二张图谱 `Circle_1`，准备制作另一类基础纹理。与前面的圆环图不同，这张图的核心起点是噪声，而不是 `Shape + Slope Blur` 的环形结构。

节点定义集：

- `Perlin Noise`：当前选中的起始节点，缩略图显示一张柔和的灰度云纹。
- `Gradient Map`
- `output`

连线集：

- 当前可明确看到 `Gradient Map.Output -> output.Input`
- `Perlin Noise` 与右侧链条之间在本图中尚未出现可见连线

设置/参数：

- 当前打开图谱名：`Circle_1 - GRAPH`
- 当前选中节点：`perlin_noise`
- 节点分辨率：`1024x512 - L16`
- 右侧 `perlin_noise - PROPERTIES` 可见：
- `Pixel Ratio`：`Square`
- `Tiling Mode`：`H and V Tiling`
- `Random Seed`：`0`
- `INSTANCE PARAMETERS > Scale`：`1`
- `Disorder`：`0`
- `Non Square Expansion`：`True`

输出/预览：

- 右上预览窗口显示一张横向拉伸的浅灰云状噪声
- 预览分辨率标注为 `1024 x 512 (Grayscale, 16bpc)`

这张图的可确认重点是：新图谱不再从圆环形状出发，而是先生成一张横向比例的 Perlin 灰度噪声，作为后续尾影波纹或飘散纹理的底图。按图复建时，应先建立 `Perlin Noise` 这一独立起始输入，再接后面的颜色或输出链。
这张图把 `Circle_1` 图谱推进成一条可复建的横向波形灰度流程，结果已经不再是云状噪声，而是一条上下起伏的黑白带。

节点定义集：

- `Perlin Noise`：提供横向灰度噪声底图。
- `Cross Section`：把噪声切成一条波浪状截面。
- `Invert Grayscale`：把黑白关系翻转。
- `Levels`：当前选中，用直方图压缩/调整对比。

连线集：

- `Perlin Noise.Output` -> `Cross Section.Input`
- `Cross Section.Output` -> `Invert Grayscale.Input`
- `Invert Grayscale.Output` -> `Levels.Input`

设置/参数：

- 所有当前可见节点分辨率均为 `1024x512 - L16`
- 当前选中节点：`Levels`
- 右侧 `Levels - PROPERTIES` 可见：
- `Random Seed`：`0`
- `SPECIFIC PARAMETERS > Levels Histogram`：`Luminance Channel`
- 直方图调节条上可见多个控制点，说明正在压缩亮暗区间

输出/预览：

- 右上预览显示一条横向延展的波形带：上方是黑色实体波峰，下方有一层模糊过渡的灰白拖影
- 预览分辨率为 `1024 x 512 (Grayscale, 16bpc)`

这张图的意义是把最初的随机噪声约束成“单条波动形状”，与正文里“拿出一个尾影造波”“会以那种形式来制作”相对应。按图复建时，关键不是保留原噪声细节，而是通过 `Cross Section` 抽出一条横向波纹，再用 `Invert Grayscale` 和 `Levels` 把黑白边界整理到适合拖尾/尾影使用的形态。

### 00:15:37-00:18:36 材质、拖尾、透明度

- 本段定位：材质、拖尾、透明度。
- 知识点：按住Rushid并调整大小。
- 知识点：需要适当缩小一点。
- 知识点：因为会通过模糊效果来强调。
- 知识点：在这个level之后再用一次invert。
- 知识点：需要这样进行处理。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`透明度`、`拖尾`。

**关键画面：**

这张图继续在 `Circle_1` 图谱里加工那条横向波形，并且把它送进了一个二维变换节点，用来整体缩放或重排拖尾形状。

节点定义集：

- `Cross Section`
- `Invert Grayscale`
- `Levels`
- `Transformation 2D`：当前选中，用于在 2D 视图中直接变换图像范围

连线集：

- `Cross Section.Output` -> `Invert Grayscale.Input`
- `Invert Grayscale.Output` -> `Levels.Input`
- `Levels.Output` -> `Transformation 2D.Input`

设置/参数：

- 当前选中节点：`Transformation 2D`
- 节点分辨率：`1024x512 - L16`
- `Random Seed`：`0`
- `SPECIFIC PARAMETERS > Transform matrix`
- `Rotation Angle`：`0.00`
- `Stretch > Width`：`100.00%`
- `Stretch > Height`：`100.00%`
- 面板中可见快捷操作：`Hori Mirror`、`Vert Mirror`、`x2`、`/2`

输出/预览：

- 右上预览中显示一条黑色波形带及其下方的模糊灰白拖影
- 预览上叠加了变换框和控制点，说明此时正通过 2D 交互框直接调整位置/尺寸
- 预览分辨率为 `1024 x 512 (Grayscale, 16bpc)`

结合字幕“我会稍微缩小一点”，这张图的重点是：作者认为当前波形过大，于是通过 `Transformation 2D` 先做整体缩放，而不是回到噪声或截面节点重做波形。按图复建时，可以先保持前面灰度链不变，再在 `Transformation 2D` 中直接压小当前波带。
这张图已经把原来的横向波形处理成更适合“拖尾/尾影”读取的流动纹理，方法是使用多方向扭曲，让亮带边缘变得更自然。

节点定义集：

- `Perlin Noise`：上方噪声节点，作为扭曲驱动输入之一。
- 下方灰度条带节点：名称在截图中被截掉，但缩略图显示为黑白波带，是当前主要的波形输入。
- `Multi Directional Warp Grayscale`：当前选中，把波带按噪声方向扭曲。
- `Gradient Map`
- `output`

连线集：

- 上方 `Perlin Noise.Output` -> `Multi Directional Warp Grayscale` 的一个输入
- 下方灰度波带节点 `Output` -> `Multi Directional Warp Grayscale` 的另一个输入
- `Multi Directional Warp Grayscale.Output` 继续送往右侧颜色/输出链
- `Gradient Map.Output -> output.Input`

设置/参数：

- 当前选中节点：`multi_directional_warp_grayscale`
- 节点分辨率：`1024x512 - L16`
- `Pixel Ratio`：`Square`
- `Tiling Mode`：`H and V Tiling`
- `Random Seed`：`0`
- `INSTANCE PARAMETERS > Intensity`：`100`
- `Warp Angle`：`Turns 0`、`Degrees 0`
- `Mode`：`Average`

输出/预览：

- 右上预览显示一条亮白主带，边缘已经被扭曲成更自然的起伏与散开形态，背景里还保留了模糊的暗灰噪声层
- 预览分辨率为 `1024 x 512 (Grayscale, 16bpc)`

图中央还打开了节点搜索框，输入了 `cu`，列表顶部高亮 `Curve`，说明作者下一步可能准备继续用曲线节点调亮度或对比。但就当前这张图本身而言，可确定的重点是：通过 `Multi Directional Warp Grayscale` 用噪声去扭曲波带，让拖尾边缘不再过于规整。
这张图继续沿着拖尾纹理链往后处理，目标已经从“生成一条连续亮带”变成“只保留少量零散高亮碎片”。右上预览几乎全黑，只剩几段细小亮痕，说明当前节点正在用阈值筛选方式把大部分灰度信息压掉。

节点定义集：

- 左侧上游节点：名称在截图中被截断，缩略图显示为黑底白色流动亮带，应为前一步拖尾变形结果。
- `RT Caustics Grayscale`：把流动亮带进一步打散成更破碎的亮纹。
- `Histogram Scan`：当前选中，用阈值方式截取亮区。
- `Gradient Map`
- `output`

连线集：

- 左侧上游节点 `Output` -> `RT Caustics Grayscale.Input`
- `RT Caustics Grayscale.Output` -> `Histogram Scan.Input`
- 右侧仍保留 `Gradient Map -> output` 这条颜色输出链

设置/参数：

- 当前选中节点：`histogram_scan`
- `Pixel Ratio`：`Square`
- `Tiling Mode`：`H and V Tiling`
- `Random Seed`：`0`
- `INSTANCE PARAMETERS > Position`：`0.32`
- `Contrast`：`0`
- `Invert Position`：`False`

输出/预览：

- 右上预览显示黑底上少量细小亮痕，主体只剩几段高亮碎片
- 预览分辨率为 `1024 x 512 (Grayscale, 16bpc)`

这张图的核心意义是：通过 `Histogram Scan` 把前面那条较宽的拖尾波带切成更稀疏的高亮片段，让纹理更接近“破碎发光拖尾”而不是整块白带。按图复建时，应重点调 `Position` 阈值，观察亮片保留的多少；阈值一旦提高，整张图会迅速从连续亮带变成少量零散碎光。

### 00:18:49-00:21:43 Ribbon、纹理

- 本段定位：Ribbon、纹理。
- 知识点：因为下面的那个shape就是。
- 知识点：这就像上次在这里。
- 知识点：我觉得这样拿走比较好。
- 知识点：不如适当地这样处理。
- 知识点：要不要以白色为背景重新制作呢? 这样制作。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`。

**关键画面：**

这张图继续在 `Circle_1` 图谱里细化拖尾高亮的保留方式。与上一批末尾只剩几段零散亮片不同，这一帧中的 `Histogram Scan` 已经把亮区重新组织成一条更细、更连贯的横向亮带，同时仍保留上下少量碎光，符合正文“像做了 Masking 然后删除过一样”的描述。

节点定义集：

- `Multi Directional Warp Grayscale`
- `RT Caustics Grayscale`
- `Histogram Scan`：当前选中，用于进一步筛选亮区
- `Gradient Map`
- `output`

连线集：

- `Multi Directional Warp Grayscale.Output` -> `RT Caustics Grayscale.Input`
- `RT Caustics Grayscale.Output` -> `Histogram Scan.Input`
- 右侧仍保留 `Gradient Map -> output` 颜色输出链

设置/参数：

- 当前选中节点：`Histogram Scan`
- 节点分辨率：`1024x512 - L16`
- `Pixel Ratio`：`Square`
- `Tiling Mode`：`H and V Tiling`
- `Random Seed`：`0`
- `INSTANCE PARAMETERS > Position`：`0.69`
- `Contrast`：`0.14`
- `Invert Position`：`False`

输出/预览：

- 右上预览显示黑底上一条细长的中部亮带，边缘有轻微雾化，同时上下保留少量细碎亮片
- 预览分辨率为 `1024 x 512 (Grayscale, 16bpc)`

这张图的重点是通过提高 `Histogram Scan` 的阈值与少量对比，把前一步较散的亮片重新“收”成一条更适合做拖尾主纹理的细亮带。按图复建时，应以 `Position 0.69` 附近为起点，观察亮带从碎片化向连续带状收束的过程。
这张图在 `Circle_1` 图谱里引入了外部遮罩资源，准备把前面做好的灰度拖尾与额外的 mask 做混合。当前画面中，上方仍保留拖尾灰度主链，而下方新增加了一条资源拆分链。

节点定义集：

- 上方主链：`Multi Directional Warp Grayscale -> RT Caustics Grayscale -> Histogram Scan`
- `Bitmap`：读取一张外部资源图，缩略图显示纯白画面
- `RGBA Split`：当前选中，用于把位图拆成多个通道输出

连线集：

- `Bitmap.Output` -> `RGBA Split.Input`
- 上方 `Histogram Scan` 结果当前尚未在本图中与下方链条完成可见连接

外部资源：

- 左侧 `Resources` 分区可见两个资源条目：
- `Mask`
- `Mask2`

设置/参数：

- `Bitmap` 节点分辨率：`1024x512 - C8`
- `RGBA Split` 节点分辨率：`1024x512 - L8`
- 当前选中节点：`rgba_split`
- 右侧 `rgba_split - PROPERTIES` 可见：
- `BASE PARAMETERS > Output Size`：`Width 0 (Input x 1)`、`Height 0 (Input x 1)`
- `Output Format`：`8 Bits per Channel`
- `Pixel Size`：`Width 1`、`Height 1`
- `Pixel Ratio`：`Square`
- `Tiling Mode`：`H and V Tiling`
- `Random Seed`：`0`

输出/预览：

- 右上预览当前显示整块白色结果，对应通道拆分后的单通道输出
- 预览分辨率为 `1024 x 512 (Grayscale, 8bpc)`

图中央还打开了节点搜索框，输入的是 `blend`，并高亮 `blend` 节点，说明作者下一步明确是要把拖尾主链与新引入的 mask 通道做混合。就这张图本身，可确认的重点是：先把外部 `Mask/Mask2` 资源作为 `Bitmap` 读入，再通过 `RGBA Split` 拆出可供后续混合使用的单通道遮罩。
这张图给出了 `Circle_1` 当前这条拖尾纹理的完整可导出节点链。作者已经把主灰度拖尾、外部 mask 通道、混合节点和颜色输出全部接好，因此这张图可以直接作为该纹理流程的收口参考。

节点定义集：

- `Transformation 2D`
- `Blur HQ Grayscale`
- `Perlin Noise`
- `Multi Directional Warp Grayscale`
- `RT Caustics Grayscale`
- `Histogram Scan`
- `Bitmap`
- `RGBA Split`
- `Blend`
- `Gradient Map`
- `output`

连线集：

- `Transformation 2D.Output` -> `Blur HQ Grayscale.Input`
- `Perlin Noise.Output` 与 `Blur HQ Grayscale.Output` 一起输入 `Multi Directional Warp Grayscale`
- `Multi Directional Warp Grayscale.Output` -> `RT Caustics Grayscale.Input`
- `RT Caustics Grayscale.Output` -> `Histogram Scan.Input`
- `Bitmap.Output` -> `RGBA Split.Input`
- `Histogram Scan.Output` 与 `RGBA Split` 某一单通道输出 -> `Blend`
- `Blend.Output` -> `Gradient Map.Input`
- `Gradient Map.Output` -> `output.Input`

设置/参数：

- 当前选中节点：`Gradient Map`
- `BASE PARAMETERS > Output Size`：`Width 10 -> 1024 px`、`Height 9 -> 512 px`
- `Output Format`：`8 Bits per Channel`
- `Pixel Size`：`Width 1`、`Height 1`
- `Pixel Ratio`：`Square`
- `Tiling Mode`：`H and V Tiling`
- `Random Seed`：`0`

输出/预览：

- 右上预览显示黑底上一条较细的亮白拖尾，亮带内部保留起伏变化，两端和上下边缘有轻微的散开层次
- 预览分辨率为 `1024 x 512 (RGBA, 8bpc)`

左上还打开了图谱 `Circle_1` 的右键菜单，并高亮在 `Rename` 一带；字幕也提到“拿走就可以了”，说明作者认为这条纹理已经基本可用，接下来主要是命名、导出或直接带走使用。按图复建时，应确保 `Blend` 后再进 `Gradient Map` 与 `output`，这样才能得到当前这种已成型的颜色纹理结果。

### 00:21:51-00:25:01 材质、纹理

- 本段定位：材质、纹理。
- 知识点：原本最开始做的面具就可以删掉吧。
- 知识点：最后再做一个纹理就差不多就完成了。
- 知识点：需要制作一个图表。
- 知识点：我们至今制作的材质是。
- 知识点：但是现在Suchance在创建这个固定模式方面。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`。

**关键画面：**

这张图展示的是同一条横向拖尾纹理流程被整理进一个新的图谱 `Aura_Hori` 之后的整体状态。左侧 `EXPLORER` 中，原先的 `Circle_1` 已不再作为当前打开图谱；当前图谱名变成了 `Aura_Hori - GRAPH`，资源区里只保留了 `Mask2`，也与字幕“原本最开始做的面具可以删掉吧”相对应。

节点定义集：

- `Levels`
- `Invert Grayscale`
- `Transformation 2D`
- `Blur HQ Grayscale`
- `Perlin Noise`
- `Multi Directional Warp Grayscale`
- `RT Caustics Grayscale`
- `Histogram Scan`
- `Bitmap`
- `RGBA Split`
- `Blend`
- `Gradient Map`
- `output`

连线集：

- 左侧灰度起始链经 `Levels -> Invert Grayscale -> Transformation 2D -> Blur HQ Grayscale`
- `Perlin Noise` 与 `Blur HQ Grayscale` 一起驱动 `Multi Directional Warp Grayscale`
- `Multi Directional Warp Grayscale -> RT Caustics Grayscale -> Histogram Scan`
- `Bitmap -> RGBA Split`
- `Histogram Scan` 与 `RGBA Split` 输出一起进入 `Blend`
- `Blend -> Gradient Map -> output`

外部资源：

- `Resources` 下当前只可见 `Mask2`

输出/预览：

- 右上预览仍显示黑底上的细亮横向拖尾
- 预览分辨率为 `1024 x 512 (RGBA, 8bpc)`

这张图的主要信息不是某个参数细调，而是图谱级整理：作者确认当前最终保留的是以 `Mask2` 参与混合的那套横向拖尾流程，原先最早的旧 mask 可以删掉。按图复建时，应把注意力放在图谱与资源清理，而不是误认为这里又新增了新的形状节点。
这张图已经离开前面的 `Aura_Hori` 图谱，切到一个新的空白图谱 `Substance_graph`，准备开始制作“最后再做一个纹理”这一段提到的新纹理。中央工作区是空白 graph，说明此时还没有正式摆放节点，重点在于建立新的图谱入口。

当前界面可确认的信息：

- 当前工程仍是 `Shield.sbs`
- 已存在图谱：
- `Circle`
- `Aura_Hori`
- 当前选中图谱：`Substance_graph`
- `Resources` 下仍可见 `Mask2`

右侧当前显示的是 `Substance_graph - PROPERTIES`，可直接确认：

- `BASE PARAMETERS > Output Size`：`Width 0 (Parent x 1)`、`Height 0 (Parent x 1)`
- `Pixel Size`：`Width 1`、`Height 1`
- `Random Seed`：`0`

输出/预览：

- 右侧 3D 预览窗口显示默认的圆角立方体模型
- 颜色空间下拉为 `sRGB (default)`
- 中央 graph 区底部仍显示 `No output node defined`

这张图的可复建重点是：作者在同一个 `Shield.sbs` 包里再开一张新图谱，为接下来的“图表/固定模式”纹理单独留出空间，而不是继续往旧图谱里追加节点。按图操作时，应先新建并选中空白 graph，再开始后续纹理搭建。
这张图不是 Substance 节点图，而是作者在浏览器中打开素材网站 `pixabay.com`，为后续纹理制作寻找可合法使用的参考或来源图。页面显示的是 Pixabay 首页/检索流式瀑布页面，能看到多张示例图片，例如抽象叶片插画、蜂鸟照片、跑步封面、花朵、咖啡桌等。

页面可直接确认的信息：

- 网站：`pixabay.com`
- 顶部搜索框占位为 `Search Pixabay`
- 右上导航包含 `Explore`、`Log in`、`Join`、`Upload`
- 页面底部可见说明文字，强调图片与其他媒体可在商用场景中使用

字幕也明确指出：“我知道这个网站即使商业使用图像也没有问题。” 因此这张图要表达的不是某个具体贴图参数，而是素材来源策略：

- 接下来的固定模式/附加纹理不一定完全手工生成
- 可以从明确允许商业使用的图库站点挑选或借用基础图像
- 选图前先确认授权边界，再带回 Photoshop 或 Substance 做二次处理

这张图的可复建结论是：在教程的这一段里，素材收集本身也是流程的一部分；如果要复现后续纹理，除了节点制作，还需要先准备可安全商用的外部参考图或源图。

### 00:25:06-00:28:01 Photoshop、纹理

- 本段定位：Photoshop、纹理。
- 知识点：可以生存一些复杂而难以理解的文力。
- 知识点：Series的警告是吧。
- 知识点：您可能需要适当挑选一下搜索这个词。
- 知识点：总是不得不利用photoshop。
- 知识点：可能是可以付费订阅的形式使用的图片。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Photoshop`、`纹理`。

**关键画面：**

这张图继续说明外部素材收集阶段，作者仍在 `pixabay.com` 上浏览可免费使用的图片结果页。与前一批的首页/推荐流不同，这里已经是一个明确的检索结果页面，顶部出现了多项筛选器和排序方式，用来缩小素材范围。

页面可直接确认的信息：

- 网站：`pixabay.com`
- 页面标题区域显示：`1,918,471 Free images`
- 顶部筛选项包括：
- `All images`
- `Orientation`
- `Size`
- `Color`
- `Published date`
- 右上排序选项：`Editor's Choice`

当前页面中可见多张示例素材，例如：

- 山林与雪山风景
- 中央偏上的抽象水波/涟漪图
- 山脊与人物风景照
- 雾气湖面图
- 船只、摩天轮、人物、雪山等照片

字幕“这样的站点也有”说明这一步仍在强调素材来源渠道，而不是具体纹理节点。按图复建时，可理解为：当需要固定模式、复杂纹理或可二次加工的底图时，可以先在允许免费使用的图库站点做关键词检索，并结合筛选器缩小结果范围。
这张图进一步明确了作者想找的并不是普通自然照片，而是可改造的“魔法阵/几何符号”类素材。浏览器当前已经打开 `istockphoto.com` 的类似图片页面，画面中大量出现黑底金线、圆环、六芒星、几何构成的神圣图案或曼陀罗式构图。

页面可直接确认的信息：

- 当前站点：`istockphoto.com`
- 页面主体标题区为韩文界面，顶部说明在搜索大量高级图库图片与视频
- 内容区标题含义为“类似图片”
- 页面中可见大量相似素材缩略图：
- 几何法阵
- 六芒星/多边形叠加
- 圆环与线框组合
- 对称符号与曼陀罗样式

字幕“如果能部分地进行一些修改就好了”说明作者并不打算直接原样使用这些素材，而是把它们当作结构参考或二次加工底图。按图复建时，可理解为：

- 搜索关键词应朝“magic circle / sacred geometry / symbol / ornament”这类方向靠拢
- 找到后优先挑选结构清晰、线条分层明确、适合局部删改的图案
- 目标不是照搬，而是拿来裁切、删减、重组后服务于自己的材质/纹理
这张图回到了 `Substance Designer` 的空白图谱 `Substance_graph`，但此时还没有开始摆放新节点。它更像是上一段素材策略的小结：右侧预览窗口里还保留着先前横向拖尾纹理的结果，而中央 graph 仍为空，字幕则强调“尽可能使用免费的网站”。

当前界面可直接确认的信息：

- 当前工程：`Shield.sbs`
- 已存在图谱：
- `Circle`
- `Aura_Hori`
- 当前选中图谱：`Substance_graph`
- `Resources` 下仍可见 `Mask2`
- 中央 graph 区为空白，底部提示 `No output node defined`

右侧 `Substance_graph - PROPERTIES` 可确认：

- `BASE PARAMETERS > Output Size`：`Width 0 (Parent x 1)`、`Height 0 (Parent x 1)`
- `Pixel Size`：`Width 1`、`Height 1`
- `Random Seed`：`0`

输出/预览：

- 右上预览窗口仍显示上一段横向拖尾纹理的黑底亮带结果
- 预览分辨率为 `1024 x 512 (RGBA, 8bpc)`

这张图的可复建意义不在于某个节点细节，而在于工作流选择：作者已经准备好一张新的空白 graph，同时明确接下来要优先使用免费来源的素材作为输入。按图理解时，可把它看作“正式开始最后一个纹理前的准备停顿帧”。

### 00:28:06-00:29:57 关键流程 10

- 本段定位：关键流程 10。
- 知识点：我在免费的网站上提前下载的资源。
- 知识点：而且由于已经导入了资源。
- 知识点：可能无法通过链接连接。
- 知识点：因此当获取已经制作好的图像时。
- 知识点：可以将以未图的形式导入。

**关键画面：**

这张图进入正文标注的 `关键流程 10`，核心动作已经变成“把预先下载好的外部图像直接导入 Substance”。屏幕中央弹出的是 `Import Resource(s)` 文件选择窗口，说明作者没有再从网络链接直接引用，而是准备把本地文件作为资源导入当前工程。

导入窗口可直接确认的信息：

- 当前路径：`Ultra Touch (F:) > Substance > Example > Magic_Circles.resources`
- 文件类型筛选：`All formats (*.psd *.psb *.dds ...)`
- 当前可见并可选的素材共 3 个：
- 一个圆环/边框型素材（文件名含 `frame`）
- 一个细线/文字样式素材（文件名含 `lettering_line`）
- 一个星形/法阵型素材（当前选中，文件名含 `star`）

其中当前被选中的文件缩略图显示为黑色几何花纹/法阵图案，文件名可辨认为：

- `XXXXX-star-931607_1920`

右下角按钮显示：

- `打开(O)`（Open）
- `취소`（Cancel）

结合正文“我在免费的网站上提前下载的资源”“因此当获取已经制作好的图像时，可以将以位图的形式导入”，这张图的可复建重点是：

- 先把外部参考图下载到本地
- 在 Substance 里通过 `Import Resource(s)` 统一导入
- 导入对象可以是多张候选图，而不必一次只导一张

这一步还没有开始节点连接，关键是明确素材输入方式已经从在线搜索转为本地位图导入。
这张图仍处在 `Import Resource(s)` 导入流程中，但作者开始在三张候选素材之间切换，以决定哪一张更适合当前要做的“形状”。与前一张选中星形法阵不同，这一帧选中的已经是中间那张线性/文字式纹理。

导入窗口可直接确认的信息：

- 当前路径仍为：`Ultra Touch (F:) > Substance > Example > Magic_Circles.resources`
- 可见的 3 张候选素材仍然是：
- `XXXXX-frame-8188320_1920`
- `XXXXX-lettering_line`
- `XXXXX-star-931607_1920`
- 当前高亮选中的是：`XXXXX-lettering_line`
- 底部文件名输入框同步显示：`XXXXX-lettering_line`

右侧属性面板同时可确认一张已经被 Substance 识别的资源：

- 当前右侧标题：`XXXXXX-frame-8188320_... - PROPERTIES`
- `Output Size`：`2048 px x 2048 px`
- `Output Format`：`8 Bits per Channel`
- 右上预览分辨率为 `2048 x 2048 (RGBA, 8bpc)`

这说明导入流程并不是只看一个文件，而是在多张备选位图中比较和切换。字幕“我正在制作一个形状”对应的可复建理解是：

- 当前目标是挑出适合直接作为基础图形的位图资源
- 候选资源可能分别承担边框、线条、中心法阵等不同角色
- 在真正导入并接节点前，先通过缩略图和尺寸信息判断哪张更适合当前纹理
这张图终于开始在 `Substance_graph` 中搭建新的纹理节点，目标是做出“边框形状的边缘”。画面中央已出现一个最基础的合成结构：两个 `Shape` 节点共同输入一个 `Blend`，下方还能看到刚导入的法阵位图，说明后续会把基础几何边框与导入图案结合。

节点定义集：

- `Shape`（上）
- `Shape`（下）
- `Blend`：当前选中，用于把两个形状叠加或相减得到边框
- `Bitmap`：下方已导入的外部法阵图，缩略图可见几何花纹

连线集：

- `Shape(上).Output` -> `Blend` 的一个输入
- `Shape(下).Output` -> `Blend` 的另一个输入
- 下方 `Bitmap` 当前在本图中尚未接到 `Blend`

外部资源：

- 左侧 `Resources` 中当前可见：
- `Mask2`
- `XXXXX-star-931607_1920`
- `XXXXXX-frame-8188320_1920`
- `XXXXX-lettering_line`

设置/参数：

- 两个 `Shape` 节点分辨率：`1024x1024 - L16`
- `Blend` 节点分辨率：`1024x1024 - L16`
- 当前选中节点：`Blend`
- `Random Seed`：`0`
- `SPECIFIC PARAMETERS > Opacity`：`1`
- `Blending Mode` 下拉框已展开，可见模式包括：
- `Copy`
- `Add (Linear Dodge)`
- `Subtract`
- `Multiply`
- `Add Sub`
- `Max (Lighten)`
- `Min (Darken)`
- `Switch`
- `Divide`
- `Overlay`

输出/预览：

- 右上预览当前是一整块白色结果，说明当前两个形状的混合还处于基础阶段，尚未形成明显的中空边框
- 预览分辨率为 `1024 x 1024 (Grayscale, 16bpc)`

字幕“那么就可以得到这种边框形状的边缘”说明这一步的目标是通过两个基础形状的混合先造出边框轮廓，再考虑把导入的法阵图案塞进或叠加到这个框架里。按图复建时，可先用两个 `Shape` 搭出内外轮廓，再逐个测试 `Blend` 模式，观察哪一种最适合提取边缘。

## 补充视觉证据

### S01 00:01:53

这张补充截图对应 `S01 00:01:53`，它的作用是把最早期半球护罩网格的构造关系补得更清楚。左侧视口直接显示一个被切开的半球体，底部是平切面，顶部保留完整球冠；中央网络区只有两级节点，因此这张图非常适合作为“半球就是怎么从球体裁出来的”直接证据。

节点定义集：

- `sphere1`：基础球体节点
- `clip1`：当前选中，用平面把球体裁成半球

连线集：

- `sphere1.Output` -> `clip1.Input`

设置/参数：

- 当前选中节点：`clip1`
- 节点类型：`Clip`
- `Clip Attribute`：`P`
- `Keep`：`Primitives Above the Plane`
- `Orient Plane with`：`Direction`
- `Origin`：`0, 0, 0`
- `Direction`：`0, 1, 0`
- `Distance`：`0`
- `Snapping Tolerance`：`1e-05`
- `Fill Polygons along Clipping Plane`：未勾选
- `Output Groups > Replace Existing`：已勾选

输出/预览：

- 左侧视口结果是一个开口朝下的半球体，线框能看出球面分段均匀
- 当前半球底部平整，没有填盖多边形

这张图能可靠证明：教程一开始并不是直接建“半球”原语，而是先放一个 `sphere1`，再用 `clip1` 沿 `Y` 方向、过原点的裁切平面切掉下半部分，从而得到后续护盾网格的基础形体。按图复建时，只要先完成这两级关系，就已经拿到了最核心的初始网格。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。

