# 15 - 10-1HoodiniMessi资源生产02

# 15 - 10-1HoodiniMessi资源生产02

## 关键术语

- `UV`、`Mesh`、`Curve`、`材质`、`网格`、`拖尾`、`纹理`、`曲线`、`这次我将介绍几种制作稍微复杂形状的曲线的方法`、`Niagara`、`Normalized Age`、`生命周期`、`颜色`、`Niagara System`、`Emitter`、`Particle`、`Spawn Rate`、`Spawn`

## 分段知识

### 00:00:07-00:04:09 纹理、曲线、这次我将介绍几种制作稍微复杂形状的曲线的方法

- 本段定位：纹理、曲线、这次我将介绍几种制作稍微复杂形状的曲线的方法。
- 知识点：上次我们主要制作了一些相对简单的模型,比如说,这次需要介绍几种制作适当复杂形状的曲线的方法。
- 知识点：同时也会介绍几种建模节点,比如说, 那么首先,我们来进行一下关于螺旋曲线的讲解。
- 知识点：先来创建一个矩阵,在可以使用的节点中搜索螺旋即可找到。
- 知识点：如果后续会使用这种形状的线条,利用这里的选项来制作这个形状,然后并将模型覆盖在这条绘制的线上,这种话, 可以认为这是在创造纹理流动的路径,然后那么这个纹理就会沿着那个方向轻柔地波动,然后形成流动的形态。
- 知识点：需要先看看这些选项,然后进行控制。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`纹理`、`曲线`。

**关键画面：**

本图是本节的开场画面，Houdini 当前停留在对象层空场景，视口里只有默认地面网格，中间网络区尚未创建任何对象节点，界面提示 `Press Tab to Add Nodes`。它的作用不是展示某个具体节点设置，而是明确这一节会从空工程开始，介绍“制作稍微复杂形状曲线”的方法。

从画面可直接确认：

- 当前层级位于对象层 `obj`
- 网络视图为空，尚未放入建模节点
- 右侧参数区显示 `No Operator Selected`
- 左下 Render Scheduler 为空，没有正在执行的输出任务

按教程语义，这一步是在进入具体曲线节点前先重置工作起点。复建时，可以先在对象层保持空场景，再通过 `Tab` 搜索并添加后续要用的曲线/建模节点，从零开始搭建螺旋或其他复杂曲线的生成流程。
本图开始正式进入 `geo1` 几何网络，当前只有一个 `Spiral` 节点 `helix1`。左侧视口显示出一条竖向抬升、带轻微回旋的白色曲线，用来作为后续更复杂曲线路径的基础形态；中间网络也只有 `helix1` 单节点，说明教程先从最基础的螺旋/螺线生成开始讲解。

右侧参数面板中可直接确认 `helix1` 的当前设置：

- 节点类型：`Spiral`
- 节点名：`helix1`
- `Primitive Type`：`Polygon`
- `Family`：`Archimedean`
- `Mode`：`Turns`

`Height` 区：

- `Height`：`2`
- `Turns`：`1`

`Radius` 区：

- `Radius Mode`：`Change per Turn`
- `Start Radius`：`1`
- `Increase per Turn`：`0`
- `Radius Scale`：`1`

`Construction` 区：

- `Direction`：`Counterclockwise`
- `Start Angle`：`0`
- `Divisions Mode`：`Divisions per Turn`
- `Divisions per Turn`：`50`
- `Uniform Division Spacing`：未勾选
- `Spiral Count`：`1`

`Transform` 区：

- `Translate`：`0, 0, 0`
- `Rotate`：`0, 0, 0`
- `Uniform Scale`：`1`

这一步的作用是先得到一条最标准的单圈阿基米德螺线，并把圈数控制在 `1`，方便后续基于它去讲解曲线朝向、弯曲幅度和覆盖网格的方法。按图复建时，可先用 `Spiral/helix` 节点建立这条基础曲线，再继续调整曲线形态或将模型沿线铺设。
本图继续在 `geo1/helix1` 上细调同一条螺旋曲线。左侧视口中的白色曲线相比上一张更明显地表现出“起点贴近中心、向外逐步展开”的趋势；右侧参数面板则显示，教程已经开始用 `Radius Ramp` 和每圈增量来控制曲线半径的变化节奏，而不是保持固定半径。

当前可直接确认的 `helix1` 参数包括：

- `Primitive Type`：`Polygon`
- `Family`：`Archimedean`
- `Mode`：`Turns`
- `Height`：`2`
- `Turns`：`1`

`Radius` 区当前值：

- `Radius Mode`：`Change per Turn`
- `Start Radius`：`0`
- `Increase per Turn`：`1`
- `Radius Scale`：`1`
- `Radius Ramp`：已启用

从展开的 `Radius Ramp` 面板还能读到：

- 当前选中的 Ramp 点 `Point No.`：`1`
- `Position`：`0`
- `Value`：`0.666667`
- `Interpolation`：`Linear`

`Construction` 区仍可确认：

- `Direction`：`Counterclockwise`
- `Start Angle`：`0`
- `Divisions Mode`：`Divisions per Turn`
- `Divisions per Turn`：`50`
- `Spiral Count`：`1`

这一步的重点是让螺旋线不再只是匀速半径变化，而是开始通过半径曲线塑造“哪一段收、哪一段放”的轮廓感。按图复建时，可把起始半径降到 `0`、每圈增长量设为 `1`，再打开 `Radius Ramp` 调整半径分布，从而得到更适合做拖尾流向或纹理流动路径的曲线。

### 00:04:12-00:07:03 网格、曲线、也可以这样表达

- 本段定位：网格、曲线、也可以这样表达。
- 知识点：是开始点,这里是结束点。
- 知识点：可以用曲线平缓地表达。
- 知识点：这就取决于形状的形式。
- 知识点：这个转弯可以形成这种形状。
- 知识点：而且根据中间点的选择,这个喷建也可以用曲线来表现。
- 核对对象：`曲线`。

**关键画面：**

本图进入下一小节“也可以这样表达”，但仍然在同一个 `geo1/helix1` 节点上调整曲线形态。左侧视口中的曲线保持单圈上升的整体走向，不过拐弯位置和展开节奏正在通过 `Radius Ramp` 做另一种分布控制；教程想表达的是，同一条基础螺旋可以通过半径曲线变化得到不同的弯折感和过渡方式。

图中可直接确认的 `helix1` 参数仍为：

- `Primitive Type`：`Polygon`
- `Family`：`Archimedean`
- `Mode`：`Turns`
- `Height`：`2`
- `Turns`：`1`
- `Radius Mode`：`Change per Turn`
- `Start Radius`：`0`
- `Increase per Turn`：`1`
- `Radius Scale`：`1`
- `Direction`：`Counterclockwise`
- `Divisions per Turn`：`50`
- `Spiral Count`：`1`

这一张与上一张的关键差别在于展开的 `Radius Ramp` 当前选中点参数已经变为：

- `Point No.`：`1`
- `Position`：`0`
- `Value`：`1`
- `Interpolation`：`Linear`

从这个设置可以判断，教程正在通过把某个半径控制点抬高到满值，尝试得到更直接、更饱满的半径变化，从而让曲线转折形成另一种轮廓。按图复建时，可在保留基础螺旋参数不变的前提下，继续调 `Radius Ramp` 的点值，对比不同曲线轮廓对后续网格覆盖路径的影响。
本图继续在 `helix1` 上把曲线改造成更适合“平缓表达转弯”的形态。左侧视口里，白色曲线已经不再是完整一圈螺旋，而更像一条由下向上轻柔摆动的 S 型路径；这与当前把圈数缩短、并用多控制点半径坡道塑形的做法一致。

当前可直接确认的 `helix1` 关键参数为：

- `Primitive Type`：`Polygon`
- `Family`：`Archimedean`
- `Mode`：`Turns`
- `Height`：`2`
- `Turns`：`0.7`

`Radius` 区：

- `Radius Mode`：`Change per Turn`
- `Start Radius`：`0`
- `Increase per Turn`：`1`
- `Radius Scale`：`1`
- `Radius Ramp`：已启用，且已有多个控制点

展开的 `Radius Ramp` 当前选中点信息可读为：

- `Point No.`：`3`
- `Position`：`0.778736`
- `Value`：`0.703704`
- `Interpolation`：`B-Spline`

`Construction` 区仍保持：

- `Direction`：`Counterclockwise`
- `Divisions Mode`：`Divisions per Turn`
- `Divisions per Turn`：`50`
- `Spiral Count`：`1`

这一步的核心是把原本偏“螺旋”的形态，压缩成更像单次转弯路径的曲线，以便表达喷射、拖尾或路径引导时常见的柔和弯折。按图复建时，可先把 `Turns` 降到 `0.7`，再通过多点 `Radius Ramp` 用 `B-Spline` 平滑半径变化，得到近似图中这种自然弯折的线条。
本图在同一个 `helix1` 节点上进一步把单条弯曲路径扩展成多股交叉曲线。左侧视口已经能看到三条细线从底部汇聚、向上分开并彼此交叉，形成适合拿来做“控制线”或多束流向路径的基础结构；这正对应教程里“根据中间点选择，可以用曲线来表现”的说明。

图中可直接确认的参数为：

- `Height`：`2`
- `Turns`：`0.7`
- `Radius Mode`：`Change per Turn`
- `Start Radius`：`0`
- `Increase per Turn`：`1`
- `Radius Scale`：`1`
- `Radius Ramp`：保持启用
- `Direction`：`Counterclockwise`
- `Divisions Mode`：`Divisions per Turn`
- `Divisions per Turn`：`30`
- `Uniform Division Spacing`：未勾选
- `Spiral Count`：`3`
- `Uniform Scale`：`1`

从视口效果可进一步确认：

- 当前输出不再是单股螺旋，而是三股同时生成的曲线
- 曲线间在中部发生交叉，底部则收束到接近同一点
- 每条曲线都保留了上一张那种平缓的弯折轮廓，而不是完整圆环

这一步的作用，是把单条可控曲线扩展成多条成组控制线，为后续覆盖网格、做多瓣火焰、花形拖尾或成束流动路径提供基础。按图复建时，可在前一张的参数基础上把 `Spiral Count` 提升到 `3`，并把 `Divisions per Turn` 调到 `30`，先得到这种三股交叉的控制线结构，再根据需要继续细调分布和平滑度。

### 00:07:06-00:11:48 Mesh、Curve、网格

- 本段定位：Mesh、Curve、网格。
- 知识点：出错的原因是,现在交叉节面接头提供,交叉节面接头数没有提供。
- 知识点：设置成第二输入交叉节面模式,可能是这个原因。
- 知识点：在这里除了管装网格,也可以做成方形网格。
- 知识点：和刚才在曲线中看到的一样,可以改变起始点和结束点的粗细。
- 知识点：这样做会很简单,就只需生成数值。
- 知识点：在max中,位置曲线已生成螺旋网格。
- 知识点：因为这里已经提供了像预设一样的曲线值。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Curve`、`纹理`、`曲线`。

**关键画面：**

本图展示教程把前面生成的螺旋/曲线路径接入 `Sweep` 节点时出现的错误状态。中间网络里只有 `helix1` 接到 `sweep1`，而 `sweep1` 旁边出现红色警告图标；左侧视口为空，没有生成任何网格，说明当前只提供了扫掠的骨架曲线，还没有提供可用于扫掠的截面形状，因此无法得到表面。

当前网络关系可直接确认：

- `helix1` 输出连接到 `sweep1`
- `sweep1` 被选中
- 目前只看到一条输入连线，没有第二输入的截面几何

右侧 `Sweep/sweep1` 参数面板可辨认内容包括：

- `Backbone Curve Group`：空
- `Cross Section Group`：空
- `Surface Shape`：`Second Input Cross Sections`
- `Surface Type`：`Quadrilaterals`
- `Scale Cross Sections`：`1`
- `Reverse Cross Sections`：未勾选
- `Stretch Around Turns`：已勾选
- `Max Stretch`：`10`
- `End Cap Type`：`None`

`Scale` 区与 `Rotation` 区还能确认：

- `Apply Scale Along Curve`：未勾选
- `Scale Ramp` 面板已展开，但当前没有有效几何结果
- `Rotate Order`：`Pitch, Yaw, Roll`
- `Apply Roll or Twist`：已勾选
- `Roll`：`0`
- `Full Twists`：`0`
- `Partial Twist`：`0`

这张图的重点是说明：仅有路径曲线还不足以生成螺旋网格，`Sweep` 还需要第二输入提供截面轮廓。按图复建时，应先把 `helix1` 作为骨架输入 `sweep1`，如果视口为空并出现红色警告，优先检查是否缺少第二输入的截面曲线。
本图显示 `sweep1` 已经调整为可直接生成带状表面的状态。左侧视口里能看到三股交叉曲线被扫成了细长的螺旋/扭转带面，表面由规则四边形网格组成，说明教程没有再依赖第二输入的截面轮廓，而是直接用 `Sweep` 的 `Ribbon` 形态沿骨架曲线生成条带网格。

当前网络关系仍是：

- `helix1 -> sweep1`
- `sweep1` 被选中

右侧 `Sweep/sweep1` 参数面板中可直接确认：

- `Surface Shape`：`Ribbon`
- `Surface Type`：`Quadrilaterals`
- `Columns`：`3`
- `Width`：`0.3`
- `Reverse Cross Sections`：未勾选
- `Stretch Around Turns`：已勾选
- `Max Stretch`：`10`
- `End Cap Type`：`None`

`Scale` 区可确认：

- `Apply Scale Along Curve`：已勾选
- `Scale Ramp` 已展开
- 当前选中点 `Point No.`：`2`
- `Position`：`1`
- `Value`：`1.5`
- `Interpolation`：`Linear`

`Rotation` 区可确认：

- `Rotate Order`：`Pitch, Yaw, Roll`
- `Apply Roll or Twist`：已勾选
- `Roll`：`0`
- `Full Twists`：`0`
- `Partial Twist`：`0`

这一步的核心是把控制线真正转成可用网格，并通过 `Ribbon` 模式快速得到适合特效贴图承载的带面。按图复建时，可把 `Sweep` 的表面形状切到 `Ribbon`，把宽度设为 `0.3`、列数设为 `3`，再启用 `Apply Scale Along Curve`，让条带沿路径产生更自然的宽度变化。
本图把上一张生成的三股 `Ribbon` 带面与其控制曲线参数放在同一画面里核对。左侧视口清楚显示三条条带从底部汇聚、在中上段交叉并向外展开；中间网络仍是 `helix1 -> sweep1`，而右侧参数面板此时切回 `helix1`，说明教程在强调：这类交叉网格的主体轮廓首先由螺旋/曲线参数决定，`Sweep` 只是把它转成表面。

当前 `helix1` 可直接确认的参数为：

- `Turns`：`0.7`
- `Radius Mode`：`Change per Turn`
- `Start Radius`：`0`
- `Increase per Turn`：`1`
- `Radius Scale`：`1`
- `Radius Ramp`：已启用

展开的 `Radius Ramp` 当前选中点信息为：

- `Point No.`：`3`
- `Position`：`0.778736`
- `Value`：`0.703704`
- `Interpolation`：`B-Spline`

`Construction` 区还可确认：

- `Direction`：`Counterclockwise`
- `Divisions Mode`：`Divisions per Turn`
- `Divisions per Turn`：`30`
- `Spiral Count`：`3`

`Transform` 区：

- `Translate`：`0, 0, 0`
- `Rotate`：`0, 0, 0`
- `Uniform Scale`：`1`

从视口效果与参数对应关系可确认：

- `Spiral Count = 3` 对应三股带面
- `Turns = 0.7` 让每股带面保持单次弯折而不是完整环绕
- `Radius Ramp` 的平滑变化决定了中段交叉和顶部展开的轮廓

这张图的重点是把“控制线参数”与“最终带面形态”一一对应起来。按图复建时，应先用 `helix1` 把三股交叉控制线的圈数、分段和半径变化调到位，再用 `Sweep` 输出网格，这样更容易稳定复现图中的结构。

### 00:11:49-00:14:36 材质、网格、颜色

- 本段定位：材质、网格、颜色。
- 知识点：,只要计算机检查这个优位, 生成就会很顺利。
- 知识点：,我们还需要用颜色再确认一下。
- 知识点：颜色看起来也很清晰, 然后,这里是0,这里是1的点。
- 知识点：设置成这样,然后, 在这种情况下,制作了网格, 然后,纹理的方向性, 要使用这样横向排列的纹理。
- 知识点：,当在U方向上流动时, 就会这样流动。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`、`颜色`。

**关键画面：**

本图进入“材质、网格、颜色”段，左侧视口中的三股带面已经挂上测试纹理。可以直接看到条带表面出现了沿宽度方向分布的浅色条纹/格纹，这说明教程开始检查贴图方向是否与网格流向匹配，而不再只是看裸网格结构。中间网络仍是 `helix1 -> sweep1`，右侧参数停在 `helix1`，表示当前材质方向问题的前提仍是先保证路径形态正确。

右侧 `helix1` 参数可直接确认：

- `Turns`：`0.7`
- `Radius Mode`：`Change per Turn`
- `Start Radius`：`0`
- `Increase per Turn`：`1`
- `Radius Scale`：`1`
- `Radius Ramp`：启用
- 当前选中点 `Point No.`：`3`
- `Position`：`0.778736`
- `Value`：`0.703704`
- `Interpolation`：`B-Spline`
- `Direction`：`Counterclockwise`
- `Divisions per Turn`：`30`
- `Spiral Count`：`3`

从视口中还能确认：

- 三股带面仍保持底部汇聚、中段交叉、顶部展开的结构
- 条纹纹理沿带面长度方向发生弯折和流向变化
- 左侧一股带面的局部出现较暗区域，适合用来判断 UV 或贴图方向是否正确

这张图的核心是开始用测试纹理和亮暗变化检查网格承载面的方向性。按图复建时，应先保证三股 `Ribbon` 网格成形，再赋予一张具有明确横纵方向的测试纹理，通过视口观察纹理是沿 `U` 还是沿 `V` 方向流动。
本图进入 `geo1/vertexvop1` 的内部，用最简 Attribute VOP 结构直接检查几何上的方向和颜色结果。左侧视口里，三股带面不再显示条纹纹理，而是改为明显的颜色渐变：从紫蓝、青绿到黄橙，说明当前正在用几何属性或坐标分量直接驱动可视化颜色，以便确认 `0` 到 `1` 的方向是否正确。

中间 `vertexvop1` 内部当前可辨认的节点非常简单：

- `geometryvopglobal1`
- `geometryvopoutput1`

两者之间只有一条直接连线，且可以从端口位置确认：

- `geometryvopglobal1` 的 `P` 输出接到了 `geometryvopoutput1` 的 `P` 输入

从右侧参数栏标签还能确认当前选中的是：

- 节点类型：`Geometry VOP Global Parameters`
- 节点名：`geometryvopglobal1`
- 所在上级网络：`geo1 / vertexvop1`

视口效果可直接说明：

- 条带沿长度和宽度方向都出现连续颜色变化
- 底部汇聚区颜色最暗，往上和往外逐步变化到亮色
- 这种颜色分布适合拿来观察 UV 或位置方向是否与预期一致

这张图的重点不是复杂节点逻辑，而是建立一种最直接的方向验证方式。按图复建时，可在 `vertexvop1` 内先保持极简结构，再把需要核对的向量/属性映射成颜色显示，通过视口确认网格从起点到终点、从内侧到外侧的属性变化方向。
本图展示这组带面在进一步拆分和合并后的组织方式。左侧视口里仍然是三股交叉条带，并继续使用从蓝紫到黄红的颜色渐变检查方向；中间网络则比前一张更完整，能看到教程把同一条 `helix1` 派生出两路 `Sweep` 结果，再通过 `merge1` 汇总，说明后续可能会针对不同条带做不同处理后再统一输出。

当前可直接确认的网络结构为：

- `helix1` 分别连接到 `sweep1` 和 `sweep2`
- `sweep1` 输出接到 `vertexvop1`
- `sweep1` 与 `sweep2` 同时接入 `merge1`
- `merge1` 当前被选中

右侧 `Merge/merge1` 参数面板中可直接确认输入列表：

- `sweep1`
- `sweep2`

从视口结果还能确认：

- 合并后的条带仍保留连续的颜色渐变，可用于检查整体方向一致性
- 前景主条带颜色从底部蓝绿逐步过渡到顶部黄红，说明属性可视化没有因为合并而丢失
- 背后的细条带仍然可见，表明多个扫掠结果可以同时参与最终几何

这张图的重点是说明：当同一类控制线需要生成多路带面时，可以先分别 `Sweep`，再用 `Merge` 汇总，同时继续保留颜色/方向检查。按图复建时，可把不同的 `Sweep` 输出单独保留，必要时先做各自的 UV 或颜色验证，再在 `merge1` 中统一组合成最终结果。

### 00:14:40-00:17:45 材质

- 本段定位：材质。
- 知识点：需要带走它,然后。
- 知识点：不过,现在是一层材质, 与同样的方向重叠在一起。
- 知识点：, 所以需要对这个进行旋转。
- 知识点：需要把它折叠起来。
- 知识点：如果用这种材质的话, 而且呢, 无论是用四边形,还是三角形。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`。

**关键画面：**

本图继续处理三股带面的材质方向问题。左侧视口里，交叉条带表面已经挂上横向条纹测试纹理，但当前两层或多层条带在部分区域沿相同方向叠在一起，因此教程开始检查其中一路 `Sweep` 的朝向是否需要旋转或翻转。中间网络已扩展为一条完整链路：`helix1` 同时驱动 `sweep1` 和 `sweep2`，再经过 `merge1` 汇总，最后进入 `vertexvop1`。

当前可直接确认的网络结构为：

- `helix1 -> sweep1`
- `helix1 -> sweep2`
- `sweep1 -> merge1`
- `sweep2 -> merge1`
- `merge1 -> vertexvop1`

右侧参数面板当前选中的是 `Sweep/sweep2`，可确认设置：

- `Surface Shape`：`Ribbon`
- `Surface Type`：`Quadrilaterals`
- `Columns`：`3`
- `Width`：`0.3`
- `Reverse Cross Sections`：未勾选
- `Stretch Around Turns`：已勾选
- `Max Stretch`：`10`
- `End Cap Type`：`None`

`Scale` 区：

- `Apply Scale Along Curve`：已勾选
- `Point No.`：`2`
- `Position`：`1`
- `Value`：`1.5`
- `Interpolation`：`Linear`

`Rotation` 区：

- `Rotate Order`：`Pitch, Yaw, Roll`
- `Apply Roll or Twist`：已勾选
- `Roll`：`0`
- `Full Twists`：`0`
- `Partial Twist`：`0`

这张图的重点是指出：即使几何已经生成，条带材质仍可能因为不同 `Sweep` 输出方向一致而发生重叠感或流向重复。按图复建时，应分别检查 `sweep1` 和 `sweep2` 的贴图朝向、法线朝向与旋转参数，必要时对其中一路做方向修正。
本图切回 Houdini 对象层，对当前螺旋条带结果做整体观察。左侧视口中已经能看到一组更完整、更厚实的螺旋带面，从底部汇聚向上展开，并带有从绿色到黄色再到红色的连续渐变；说明教程暂时离开单个节点内部，转而从对象级管理不同形态的螺旋资源。

中间对象网络当前可辨认出两个几何对象：

- `Helix`
- `Spiral`

其中：

- `Spiral` 当前被选中
- `Helix` 位于上方，作为另一组对象并列存在

右侧对象级 `Transform` 面板当前显示的是 `Geometry Hel`（对象标签显示为 `Helix`），可直接确认默认变换值：

- `Translate`：`0, 0, 0`
- `Rotate`：`0, 0, 0`
- `Scale`：`1, 1, 1`
- `Uniform Scale`：`1`

从视口结果还能确认：

- 当前带面比前面 `Ribbon` 测试阶段更厚、更接近最终特效承载形态
- 三股或多股螺旋面围绕中心缠绕，顶部外翻，底部收束
- 黑色细线/深色条带仍可见，适合继续核对材质流向与层次重叠关系

这张图的重点是说明教程已经把不同螺旋方案拆成独立对象来管理，而不是继续把所有尝试都堆在同一网络里。按图复建时，可将不同版本的螺旋条带分别放在对象层的独立 Geometry 节点下，便于单独预览、旋转、隐藏和比较。
本图开始尝试另一种更接近平面卷曲的螺旋形状。左侧视口中只有一条白色平面螺旋曲线，从中心向外逐圈展开；中间网络里当前有两条 `Spiral` 路径 `spiral1` 与 `spiral2`，但后续的 `sweep1`、`merge1`、`vertexvop1` 仍带有红色警告，说明教程正在重新搭建新的形状方案，暂时还没有把这条平面螺旋完整转成网格。

当前网络结构可直接确认：

- `spiral1` 位于左上并被选中
- `spiral2` 位于右上
- `spiral1` 下方连接着 `sweep1`
- `sweep2` 位于右下
- `sweep1` 与 `sweep2` 都接向 `merge1`
- `merge1` 再接到 `vertexvop1`
- `sweep1`、`merge1`、`vertexvop1` 旁都有报错警告

右侧 `Spiral/spiral1` 参数面板可直接确认：

- `Primitive Type`：`Polygon`
- `Family`：`Archimedean`
- `Mode`：`Turns`

`Height` 区：

- `Height`：`0`
- `Turns`：`2.65`

`Radius` 区：

- `Radius Mode`：`Change per Turn`
- `Start Radius`：`0`
- `Increase per Turn`：`0.8`
- `Radius Scale`：`0.93`
- `Radius Ramp`：已启用
- 当前选中点 `Point No.`：`2`
- `Position`：`1`
- `Value`：`1`
- `Interpolation`：`Linear`

`Construction` 区：

- `Direction`：`Counterclockwise`
- `Start Angle`：`0`
- `Divisions Mode`：`Divisions per Turn`
- `Divisions per Turn`：`50`
- `Uniform Division Spacing`：未勾选
- `Spiral Count`：`1`

这张图的重点是说明：除了立体缠绕条带，也可以从纯平面的阿基米德螺旋入手，再逐步生成新的拖尾或卷曲形状。按图复建时，可先独立调好 `spiral1` 的平面参数，确认曲线轮廓满意后，再去修复后续 `Sweep/Merge/VOP` 链路。

### 00:17:48-00:20:29 网格、拖尾

- 本段定位：网格、拖尾。
- 知识点：可以用这个来制作形状。
- 知识点：这次我们试试这个吧。
- 知识点：Loop是旋转和次数。
- 知识点：Rotation就是整体角度。
- 知识点：Tail可能会成为不必要的点。
- 核对对象：`拖尾`。

**关键画面：**

本图进入“网格、拖尾”段，展示新的拖尾形状方案还处在搭建中的中间状态。左侧视口为空，说明当前网络还没有成功输出可显示的几何；中间网络则能看到以 `spiral2` 为上游输入，经过 `sweep1`、`sweep2`、`merge1` 和 `vertexvop1` 组成的处理链，但其中多个节点都带有红色警告，表示这套拖尾网格尚未完成。

当前可直接确认的网络结构为：

- `spiral2` 位于上方
- `sweep1` 位于左下，带红色警告
- `sweep2` 位于右下
- `sweep1` 与 `sweep2` 都接入 `merge1`
- `merge1` 带红色警告
- `merge1` 输出接到 `vertexvop1`
- `vertexvop1` 也带红色警告

右侧参数面板当前选中的是 `Merge/merge1`，可确认其输入列表：

- `sweep1`
- `sweep2`

从画面状态还能确认：

- 当前问题不是视口角度，而是几何链路尚未产出有效结果
- 新方案仍沿用 “曲线生成 -> 双路 sweep -> merge -> 属性处理” 的整体结构
- 这一节的重点会转向拖尾形状本身，而不是前面那种多股立体螺旋条带

这张图的作用是交代新拖尾方案的起点：先沿用熟悉的网络骨架，再逐步调通各节点。按图复建时，可先把 `spiral2`、`sweep1`、`sweep2`、`merge1`、`vertexvop1` 的关系搭起来，即使暂时报错也没关系，之后再逐个修正输入和参数。
本图显示这组拖尾网格已经开始形成可见体积。左侧视口里，条带被卷成近似圆筒/卷壳状的螺旋结构，顶部开口、侧面重叠，说明教程正在通过 `Sweep` 的旋转控制把平面带面卷起来，做出更接近拖尾或卷曲能量壳的形态。

当前网络关系可直接确认：

- `spiral2` 同时连到 `sweep1` 和 `sweep2`
- `sweep1` 与 `sweep2` 都接入 `merge1`
- `merge1` 输出接到 `vertexvop1`
- `vertexvop1` 仍有红色报错警告
- `merge1` 当前只有黄色提示，不再是红色报错

右侧参数面板当前选中的是 `Sweep/sweep1`，可确认设置：

- `Surface Shape`：`Ribbon`
- `Surface Type`：`Quadrilaterals`
- `Columns`：`3`
- `Width`：`0.3`
- `Reverse Cross Sections`：未勾选
- `Stretch Around Turns`：已勾选
- `Max Stretch`：`10`
- `End Cap Type`：`None`

`Scale` 区：

- `Apply Scale Along Curve`：已勾选
- `Point No.`：`2`
- `Position`：`1`
- `Value`：`1.5`
- `Interpolation`：`Linear`

`Rotation` 区：

- `Rotate Order`：`Pitch, Yaw, Roll`
- `Apply Roll or Twist`：已勾选
- `Roll`：`90`
- `Full Twists`：`0`
- `Partial Twist`：`0`

从视口结果可直接推断：

- `Roll = 90` 把原本的带面朝向扭到更接近卷壳/立起的状态
- 同一条螺旋路径经过扫掠后，不再只是平面拖尾，而可以生成包裹感更强的立体截面

这张图的重点是说明 `Sweep` 的旋转参数对拖尾形状影响很大。按图复建时，可先保持宽度和缩放不变，只调 `Roll` 到 `90`，观察条带如何从平铺状态转为卷曲包裹状。
本图回到对象层，展示已经成形的单体螺旋拖尾结果。左侧视口中可见一个从外圈向内卷起的带状螺旋壳，颜色从外缘的红橙逐步过渡到中心的绿色，形态像一片被卷起的能量拖尾或火焰舌片；这说明教程已经把前面在 `Sweep` 中测试的卷曲带面整理成一个可独立使用的对象结果。

中间对象网络当前可辨认出两个 Geometry 对象：

- `Helix`
- `Spiral`

其中：

- `Helix` 当前被选中
- `Spiral` 作为另一套方案保留在下方

右侧对象级 `Transform` 面板可直接确认 `Helix` 当前保持默认值：

- `Translate`：`0, 0, 0`
- `Rotate`：`0, 0, 0`
- `Scale`：`1, 1, 1`
- `Uniform Scale`：`1`

从视口结果还能直接确认：

- 当前拖尾不是多股交叉结构，而是单个连续卷壳
- 外圈宽、内圈紧，整体呈平面内向中心收卷
- 表面颜色渐变便于继续检查从尾部到中心的方向性

这张图的作用是总结这一小节的目标形态：螺旋曲线不仅能做多股立体条带，也能做成单片卷起的拖尾壳。按图复建时，可把卷曲完成的方案单独保存在 `Helix` 这类对象里，与 `Spiral` 的其他尝试并列管理，方便后续挑选最适合的拖尾基础网格。

### 00:20:32-00:23:28 拖尾、颜色

- 本段定位：拖尾、颜色。
- 知识点：需要删除这个名字。
- 知识点：我们曾经使用过磁盘生成器。
- 知识点：大约180度左右。
- 知识点：虽然是摆动拖尾节点。
- 知识点：高度设置为大约0.2。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`、`拖尾`。

**关键画面：**

本图是“拖尾、颜色”段的起始画面。Houdini 当前停留在对象层，场景里已经保留了两个现有几何对象 `Helix` 与 `Spiral`，同时中间弹出了 `Tab Menu`，说明教程准备在对象层继续新建一个基础几何对象，用于后续给拖尾补颜色、补截面或增加新的辅助形状。

当前可直接确认：

- 对象层已有两个 Geometry 节点：
  - `Helix`
  - `Spiral`
- `Helix` 当前被选中
- 右侧显示的是对象级 `Transform` 面板

对象级默认变换值可直接读取：

- `Translate`：`0, 0, 0`
- `Rotate`：`0, 0, 0`
- `Scale`：`1, 1, 1`
- `Uniform Scale`：`1`

`Tab Menu` 当前可见的可选分类与候选项包括：

- 分类：`Animation`、`Cameras`、`Character FX`、`Characters`、`Dynamics`、`Environments`、`File IO`、`Geometry`、`Labs`、`Lights`、`Managers`、`Parenting`、`Render`、`Scene Graph`、`Sound`、`Utility`、`More`
- 历史项可见：`Geometry`、`Sphere`

这张图的重点是交代：在做拖尾颜色和新几何组合前，教程会先回到对象层整理入口，并从这里继续添加辅助对象。按图复建时，可先保留已有的 `Helix` 与 `Spiral`，再用 `Tab` 在对象层创建新的 Geometry/Sphere 一类对象，为后续合并或颜色渐变处理做准备。
本图切入名为 `Swingtrail` 的几何网络，开始用圆盘片来制作摆动拖尾的基础承载面。左侧视口里显示的是一块接近半圆环/扇形的薄片网格，外圈弧形完整，内圈挖空，底部有一条径向切口；中间网络当前只有两个节点：`disc_generator1` 生成原始盘面，`mirror1` 用来把这一片几何做镜像复制或对称整理。

当前网络结构可直接确认：

- `disc_generator1 -> mirror1`
- `mirror1` 当前被选中

右侧 `Mirror/mirror1` 参数面板可确认：

- `Operation`：`Mirror All Primitives`
- `Orient Plane with`：`Direction`
- `Origin`：`0, 0, 0`
- `Direction`：`1, 0, 0`
- `Distance`：`0`
- `Reverse`：`Reverse`
- `Keep Original`：已勾选
- `Consolidate Seam`：已勾选
- `Consolidate Seam` 阈值：`0.0001`
- `Only Consolidate Unshared Edges`：已勾选

从视口效果还能确认：

- 当前薄片已具有拖尾片常见的“外宽内窄、中心中空”轮廓
- 镜像后几何边界更完整，适合继续做颜色和 UV 方向处理

这张图的重点是说明：摆动拖尾不一定从螺旋曲线出发，也可以直接从圆盘片或扇形片经过镜像得到基础轮廓。按图复建时，可先用 `disc_generator1` 做出半圆片，再用 `mirror1` 按 `X` 方向镜像并保留原件，得到对称的拖尾承载面。
本图继续在 `Swingtrail` 网络中整理拖尾片网格。左侧视口里，这块镜像后的薄片已经能看出上下两层重叠和弧形边缘，但中间接缝与重复点还没有完全清理；中间网络则显示在 `disc_generator1 -> mirror1` 之后新增了 `fuse1`，并且正在通过 `Tab Menu` 继续准备下一个节点，结合字幕可知下一步会进入 UV 处理。

当前网络结构可直接确认：

- `disc_generator1 -> mirror1 -> fuse1`
- `fuse1` 当前被选中

右侧 `Fuse/fuse1` 参数面板可直接确认：

- `Position Attribute`：`P`
- `Snap To`：`Near Points`
- `Using`：`Least Target Point`
- `Snap Distance`：`0.001`
- `Output Positions`：`Average Value`
- `Fuse Snapped Points`：已勾选
- `Keep Fused Points`：未勾选
- `Remove Repeated Vertices and Degenerate Primitives`：已勾选
- `Remove Unused Points from Degenerate Primitives`：已勾选
- `Remove All Unused Points`：已勾选
- `Recompute Affected Normals`：已勾选

`Tab Menu` 当前可见信息还包括：

- 分类：`Animation`、`Attribute`、`Character FX`、`Deform`、`Dynamics`、`Environments`、`File IO`、`Geometry`、`Group`、`Labs`、`Machine Learning`、`Managers`、`Scene Graph`、`Texturing`、`Utility`、`Volume`
- 历史项：`Fuse`、`Spiral`、`Labs Spiral`、`Merge`

从视口与参数结合可以判断：

- `mirror1` 产生的对称片面需要 `fuse1` 把中缝附近的近点焊接起来
- 焊接完成后，这块拖尾片更适合继续生成统一 UV 和颜色渐变

这张图的重点是说明：镜像后的拖尾片要先清缝、去重，再做 UV。按图复建时，可在 `mirror1` 后接 `fuse1`，用很小的 `Snap Distance` 合并中线附近点位，并清理退化面与无用点，然后再进入 UV 节点。

### 00:23:32-00:26:52 UV、网格、颜色

- 本段定位：UV、网格、颜色。
- 知识点：获取一个颜色渐变值。
- 知识点：只有关于UV方向的UV。
- 知识点：因为合并了两个网格。
- 知识点：底部的网格也是一样。
- 知识点：为了将两个网格的渐变值合并成一个。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

本图进入“UV、网格、颜色”段，开始把这块摆动拖尾片的颜色渐变统一到同一个网格上。左侧视口里，拖尾片已经成为一整块连续的弧形带面，表面能看到规则格线和点位，说明镜像与焊接后的网格已经足够稳定，可以继续对 `Cd` 或 UV 对齐结果做处理。中间网络也显示：`disc_generator1 -> mirror1 -> fuse1 -> attribadjustcolor1`。

当前网络结构可直接确认：

- `disc_generator1 -> mirror1 -> fuse1 -> attribadjustcolor1`
- `attribadjustcolor1` 当前被选中
- 节点下方标有目标属性 `Cd`

右侧当前打开的是 `Labs Disc Generator/disc_generator1` 参数面板，可直接确认基础几何设置：

- `Inner Radius`：`0.5`
- `Outer Radius`：`1`
- `Sides`：`32`
- `Segments`：`4`
- `Arc Start`：`180`
- `Arc End`：`360`
- `Orientation`：`XZ Plane`
- `Translate`：`0, 0, 0`
- `Inner Height`：`0.2`
- `Outer Height`：`0`
- `Enable Ramp`：未勾选
- `Add UVs`：已勾选

从视口与网络结合可确认：

- 当前拖尾片是由单块半圆盘面镜像并焊接后得到的统一网格
- 接下来通过 `attribadjustcolor1` 会把颜色或渐变值写入 `Cd`
- 因为几何已经合并成一体，后续颜色渐变需要在整块网格范围内重新对齐，而不是分别作用在两半上

这张图的重点是交代颜色处理前的几何前提。按图复建时，应先确保 `disc_generator1` 的半圆拖尾片参数与图中一致，并已完成 `mirror`、`fuse`，再用 `attribadjustcolor1` 统一写入颜色渐变。
本图聚焦 `attribadjustcolor1` 如何给摆动拖尾片写入统一颜色渐变。左侧视口里，这块拖尾片已经从亮青色逐渐过渡到深蓝绿色，说明教程没有再依赖贴图，而是直接把颜色梯度写到 `Cd` 上，用于检查合并后两半网格是否在同一方向上获得连续的 `0-1` 渐变。

当前网络结构仍为：

- `disc_generator1 -> mirror1 -> fuse1 -> attribadjustcolor1`
- `attribadjustcolor1` 当前被选中
- 目标属性为 `Cd`

右侧 `Attribute Adjust Color/attribadjustcolor1` 参数面板可直接确认：

- `Attribute Name`：`Cd`
- `Attribute Class`：`Vertex`
- `Adjust Value`：已勾选
- `Operation`：`Set Always`
- `Pattern Type`：`Bounding Box`
- `Range Values`：`Color Ramps`

`Color Ramp` 当前可见的渐变关系为：

- 左侧起点是亮青色
- 中间逐步过渡为偏蓝青色
- 右侧终点接近深绿黑色

`Bounding Box` 区可确认：

- 方向按钮中 `X` 当前被选中
- 可见 `Compute Range` 按钮，表示颜色范围基于当前包围盒计算

从视口与参数结合可判断：

- 颜色渐变是按包围盒某一方向统一投射到整块拖尾片上的
- 由于镜像后的两半已经 fuse 成一体，所以能得到连续而不是断开的色带

这张图的重点是说明：合并后的拖尾片要重新按整体包围盒生成 `Cd` 渐变。按图复建时，可在 `attribadjustcolor1` 中将 `Cd` 设为 `Vertex` 级、`Set Always`，并用 `Bounding Box + Color Ramp` 给整块网格写入从亮到暗的连续颜色。
本图切进 `Swingtrail/vertexvop1` 的内部，对拖尾片颜色分量做进一步重组。左侧视口里，这块弧形拖尾片从左下内缘的红橙色逐步过渡到右上外缘的绿色，说明当前不只是简单写入一条渐变，而是在 VOP 里重新组合了不同方向的颜色/位置分量，用来确认哪一轴真正控制了 `Cd` 的变化。

中间 `vertexvop1` 内部当前可辨认的节点为：

- `geometryvopglobal1`
- `vectofloat1`
- `vectofloat2`
- `floattovec1`
- `geometryvopoutput1`

从可见连线关系可确认：

- `geometryvopglobal1` 输出两路向量，分别送入 `vectofloat1` 和 `vectofloat2`
- `vectofloat1` 的 `fval1`、`fval2`、`fval3` 接入 `floattovec1`
- `vectofloat2` 至少有一路分量接入 `floattovec1`
- `floattovec1` 的向量输出接到 `geometryvopoutput1`

右侧当前选中的是 `Vector to Float/vectofloat2`，可确认：

- 节点类型：`Vector to Float`
- 节点名：`vectofloat2`
- `Signature`：`3D Vector`

从视口结果与节点结构可以确认：

- 当前颜色不是单一纯色，而是沿网格范围形成连续红到绿的渐变
- VOP 结构的目的，是把来自几何全局输入的向量分量拆开后重新组合，观察具体哪一轴或哪一分量在影响颜色
- 这一步对应教程中“好像只有 Y 轴有颜色值”的检查语境，用来判断合并后两个网格的渐变是否统一

这张图的重点是说明：当整块拖尾片的颜色方向不够明确时，可以进入 VOP，把向量分量拆开再组合到输出颜色中，逐轴排查。按图复建时，可用 `vectofloat -> floattovec -> output` 的最小结构，把不同输入分量分别映射到颜色通道，确认最终哪一方向最适合做拖尾的 `0-1` 颜色渐变。

### 00:26:56-00:29:46 网格、颜色

- 本段定位：网格、颜色。
- 知识点：可观察到已经对齐了。
- 知识点：我在这里连接UA-10出了点错。
- 知识点：因为这个似乎有某种快照功能。
- 知识点：三个值应该是相同的。
- 知识点：需要方向也是这样显示的。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

本图是 `Swingtrail` 拖尾片在“网格、颜色”段的对齐验收画面。左侧视口从侧面观察这块已镜像并焊接完成的拖尾片，可以看到上下两层边缘基本对齐；中间网络则补全为 `disc_generator1 -> mirror1 -> fuse1 -> attribadjustcolor1 -> vertexvop1`，说明颜色渐变之后，教程又进入 `vertexvop1` 做更细的属性核对。

当前可直接确认的网络结构为：

- `disc_generator1 -> mirror1 -> fuse1 -> attribadjustcolor1 -> vertexvop1`
- `attribadjustcolor1` 目标属性为 `Cd`
- `vertexvop1` 当前被选中

右侧 `Attribute VOP/vertexvop1` 参数面板可确认：

- `Group Type`：`Guess from Group`
- `Run Over`：`Vertices`
- `Vex Source`：`Myself`
- `Enable Multithreading`：已勾选

左下 Geometry Spreadsheet 当前可直接看到的列包括：

- `Cd[r]`
- `Cd[g]`
- `Cd[b]`
- `uv[0]`
- `uv[1]`
- `uv[2]`

从表格中的可见样例值可确认：

- 多行 `Cd[g]` 为 `0.75`
- 对应多行 `uv[1]` 也为 `0.75`
- `Cd[b]` 为 `0.0`
- `uv[2]` 多为 `0.0`

这说明当前至少有一组颜色分量已经和对应的 UV 分量对齐，符合字幕里“已经对齐了”的判断。按图复建时，可在 `attribadjustcolor1` 后接 `vertexvop1`，再打开 Spreadsheet 对照 `Cd` 和 `uv` 的各通道值，确认颜色渐变与 UV 方向是一致的。
本图从更正面的角度继续验证拖尾片的颜色渐变与 UV 对齐关系。左侧视口里，这块弧形拖尾片已经清楚显示出从左侧黄橙到右侧绿色的连续过渡；中间网络仍是 `disc_generator1 -> mirror1 -> fuse1 -> attribadjustcolor1 -> vertexvop1`，说明这一步没有再改几何，只是在确认颜色值是否已经按预期落到整块网格上。

右侧 `Attribute VOP/vertexvop1` 参数仍可确认：

- `Group Type`：`Guess from Group`
- `Run Over`：`Vertices`
- `Vex Source`：`Myself`
- `Enable Multithreading`：已勾选

左下 Geometry Spreadsheet 当前可见列包括：

- `Cd[r]`
- `Cd[g]`
- `Cd[b]`
- `uv[0]`
- `uv[1]`
- `uv[2]`

从图中可直接读出的样例对应关系更明确：

- `Cd[r]` 与 `uv[0]` 一致，例如可见 `1.0`、`0.96875`、`0.9375`、`0.90625`
- `Cd[g]` 为 `0.0`
- `Cd[b]` 为 `0.0`
- `uv[1]` 与 `uv[2]` 多为 `0.0`

这表明当前主要在检查 `U` 方向的渐变是否正确写到了颜色红通道上，而另外两个通道基本保持不参与。按图复建时，可优先确认 `Cd[r] == uv[0]` 这一关系成立，这样后续无论是用颜色预览还是用纹理流动，都能快速验证拖尾片的主方向。
本图是在颜色和 UV 对齐之后，继续把拖尾片的轮廓做圆润化处理。左侧视口里，这块拖尾片已经从原来的弧形带面收束成更像尖头叶片/火焰舌片的轮廓，头部尖、尾部宽，并保留了从左到右的颜色渐变；中间网络则在 `vertexvop1` 之后又新增了 `group1` 和 `smooth1`，说明教程开始选定局部区域并做平滑。

当前可直接确认的网络结构为：

- `disc_generator1 -> mirror1 -> fuse1 -> attribadjustcolor1 -> vertexvop1 -> group1 -> smooth1`
- `attribadjustcolor1` 目标属性仍为 `Cd`
- `smooth1` 当前被选中

右侧 `Smooth/smooth1` 参数面板可直接确认：

- `Constrained Boundary`：`None`
- `Attributes`：`P`
- `Method`：`Uniform`
- `Strength`：`10`
- `Filter Quality`：`2`
- `Recompute Affected Normals`：已勾选

左下 Spreadsheet 仍能看到：

- `Cd[r]`
- `Cd[g]`
- `Cd[b]`
- `uv[0]`
- `uv[1]`
- `uv[2]`

这说明即使增加了形体平滑，颜色与 UV 检查仍然保留在同一条处理链上。按图复建时，可先用 `group1` 选定需要柔化的区域，再在 `smooth1` 中只对 `P` 做 `Uniform` 平滑，并适当提高 `Strength`，让拖尾片边缘和中段过渡更顺滑。

## 补充视觉证据

### S01 00:00:24

这张补充图补足了 S01 段最开始的对象层状态。Houdini 当前完全停留在空场景：左侧只有默认地面网格，中央网络区显示 `Empty Network / Press Tab to Add Nodes`，右侧参数面板提示 `No Operator Selected`。它和正文开头“这次介绍几种稍微复杂形状的曲线制作方法”相对应，说明本节确实是从零开始起步，而不是延续前一节已有节点。

从画面可直接确认：

- 当前层级在对象层 `obj`
- 网络区没有任何对象节点
- 右侧没有选中任何 Operator
- 左下 Render Scheduler 为空，没有渲染或输出任务

这张补充图的作用是给 S01 开场建立更明确的证据：教程从空对象层开始，再逐步添加 `Helix/Spiral` 等曲线节点。按图复建时，可先保持对象层空白，再通过 `Tab` 添加第一个几何对象和内部曲线节点。

### S02 00:04:44

这张补充图补足了 S02 段 `helix1` 曲线塑形时的一个关键 `Radius Ramp` 控制点参数。左侧视口里仍是那条柔和弯折的白色曲线；中间网络只有 `helix1` 单节点；右侧参数面板则展开了 `Radius Ramp` 的点设置和插值下拉菜单，用来说明这种曲线轮廓并不是简单线性拉出来的，而是依赖特定插值模式。

当前可直接确认的 `helix1` 参数包括：

- `Height`：`2`
- `Turns`：`0.7`
- `Radius Mode`：`Change per Turn`
- `Start Radius`：`0`
- `Increase per Turn`：`1`
- `Radius Scale`：`1`
- `Radius Ramp`：已启用

当前选中的 `Radius Ramp` 控制点为：

- `Point No.`：`2`
- `Position`：`0.758621`
- `Value`：`0.555556`

插值模式下拉菜单已展开，可见选项包括：

- `Constant`
- `Linear`
- `Catmull-Rom`
- `Monotone Cubic`
- `Bezier`
- `B-Spline`
- `Hermite`

其中当前被选中的模式是：

- `Interpolation`：`Catmull-Rom`

`Construction` 区还可确认：

- `Divisions per Turn`：`50`
- `Spiral Count`：`1`

这张补充图的重点，是把 S02 段“平缓转弯曲线”的形状依据进一步具体化到某个 Ramp 点与插值模式。按图复建时，除了设置圈数和半径变化外，还应把对应控制点的插值调成 `Catmull-Rom`，以获得更自然的弯折过渡。

### S01 00:00:56

这张补充图补足了 S01 段最初创建 `helix1` 时的另一组基础参数。左侧视口里是一条非常标准的竖向螺旋线，共绕了多圈，形态比后面 S02/S03 段的压缩弯折线更原始；中间网络只有 `helix1` 单节点；右侧参数面板给出了这条基础螺旋的初始圈数和半径设置。

当前可直接确认的 `helix1` 参数为：

- 节点类型：`Spiral`
- 节点名：`helix1`
- `Primitive Type`：`Polygon`
- `Family`：`Archimedean`
- `Mode`：`Turns`

`Height` 区：

- `Height`：`1`
- `Turns`：`3`

`Radius` 区：

- `Radius Mode`：`Change per Turn`
- `Start Radius`：`1`
- `Increase per Turn`：`0`
- `Radius Scale`：`1`
- `Radius Ramp`：未展开，可见但未启用编辑

`Construction` 区：

- `Direction`：`Counterclockwise`
- `Start Angle`：`0`
- `Divisions Mode`：`Divisions per Turn`
- `Divisions per Turn`：`50`
- `Uniform Division Spacing`：未勾选
- `Spiral Count`：`1`

这张补充图的意义在于说明：教程一开始并不是直接做复杂弯折线，而是先从最基础的三圈标准螺旋开始，再逐步缩减圈数、修改半径和 Ramp。按图复建时，可先按这组基础参数得到标准螺旋，然后再进入后续各段做形态压缩与曲线塑形。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。

