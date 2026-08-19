# 04 Stylized Tornado

# 04 Stylized Tornado

## 关键术语

- `Emitter`、`System`、`Spawn`、`Lifetime`、`Color`、`Alpha`、`Material`、`Material Instance`、`Depth Fade`、`UV`、`Add`、`Niagara`、`Normalized Age`、`Texture`、`Curve`、`Vortex Force`、`Niagara System`、`Particle`

## 分段知识

### 00:00:06-00:04:07 Color、Add、Texture

- 本段定位：Color、Add、Texture。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Color` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Color`、`Alpha`、`Opacity`、`Texture`、`Add`、`Panner`、`Emissive`、`Photoshop`。

**关键画面：**

在 Photoshop 中创建龙卷风风纹的基础贴图画布，并先用纯黑背景作为发光纹理的底色

- 当前文档为一个正方形贴图画布，画面中央可见完整黑色方块，作为后续绘制风纹的底图
- 左下角状态栏显示文档尺寸约为 `1024 px x 1024 px`
- 右侧 `Layers` 面板中可见两层：
  - `Background`：已填充为纯黑色并处于锁定状态
  - `Layer 1`：位于其上方，用于继续绘制亮部纹理
- 左侧色轮当前选中白色，说明接下来会在黑底上用白色或高亮灰度绘制风纹
- 这一步的目的，是先建立一张黑底灰度贴图，让后续绘制出的亮纹能够在材质里作为高对比的风向发光遮罩使用
在 Photoshop 中开始绘制龙卷风风纹的亮部形状，用白色在黑底上做出多条尖锐、朝上拉伸的风刃条带

- 当前放大查看灰度贴图，背景保持纯黑
- 白色主体由多条相邻的高亮尖峰组成，每一条都从底部较宽区域向上收尖，形成类似风切割出的锋利锥形笔触
- 左侧两条尖峰边缘带有轻微羽化过渡，说明作者不是只用硬边选区填充，而是在绘制后保留一定柔化，方便后续形成更自然的流动纹理
- 中间与右侧的白色大尖峰高度更高、边缘更直，作为主导形状建立龙卷风内部旋转气流的强对比节奏
- `Layers` 面板显示当前编辑层为 `Layer 2`，说明这些白色风纹是叠加在黑底上的独立绘制内容
- 这一步的目标，是先做出多组尖锐的亮条，后续再继续平滑、拉扯或重复这些形状，把它们发展成围绕龙卷风旋转的攻击性风纹贴图
继续细化同一张灰度风纹贴图，在白色主条带边缘加入更多回勾和锯齿，使气流轮廓更有攻击性

- 画面仍是黑底白纹的灰度贴图，并保持在高倍放大状态下编辑
- 多条竖向白色主条带的侧边已经不再是简单直线，而是被切出连续的三角形缺口和向外突出的尖刺
- 左侧细长条带的左边缘、中部宽条带的左边缘、右侧宽条带的左边缘都出现重复的锯齿状轮廓，说明作者在统一强化“被风撕裂”的视觉语言
- 这些锯齿边缘依然保留轻微软化过渡，没有变成完全硬边，因此后续映射到材质时会更像发光烟风而不是纸片切口
- 右下角还能看到一条独立的斜向细尖峰，表明作者会在主条带之外补充次级风刃，增加纹理节奏变化
- 这一步的目的，是把之前较平滑的亮条进一步雕刻成更锋利、更不规则的风纹边界，供后续在材质里表现龙卷风环绕气流的侵略性形态

### 00:04:07-00:08:57 Spawn、Add、Texture

- 本段定位：Spawn、Add、Texture。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Spawn` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：is fine. Move the texture.。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Spawn`、`Alpha`、`Opacity`、`Texture`、`Add`、`Panner`、`Emissive`、`材质`。

**关键画面：**

在 Photoshop 中继续修整龙卷风风纹贴图，用大号硬边画笔削减底部白色区域，只保留上方尖刺状风刃轮廓

- 当前仍在编辑黑底白纹的灰度贴图，活动层为 `Layer 2`
- 左侧画笔面板显示使用圆形画笔，`Size` 约为 `123 px`，`Hardness` 为 `100%`
- 画面下半部原本连成一片的白色区域仍然存在，但上缘已经被切出多组向下插入的黑色尖角，形成一排高低不同的锯齿状风刃
- 左半部分的窄尖峰边缘更碎、更有毛刺；右半部分则保留几根更高、更整齐的三角形主峰，用来维持整体节奏
- 当前操作意图是“减少这一部分”，也就是压缩底部大面积纯白，让纹理从大块填充改为更清晰的条带与尖峰结构
- 这一步完成后，贴图会更接近适合平移滚动的风向条纹，而不是一整块难以读出流向的亮面
继续细化风纹贴图的条带边缘与间距，使纹理在保留尖锐节奏的同时更适合无缝平铺

- 画面中能看到多根从上方垂下的黑色尖刺切入白色区域，每根尖刺侧边都带有连续的小锯齿，形成更丰富的细节层级
- 中间位置有一条向右倾斜的细长黑色裂口，底端正在用软圆笔刷处理，说明作者在手动修正条带间距与连接关系
- 左下画笔设置显示当前 `Size` 约为 `40 px`，`Hardness` 为 `0%`，说明这一阶段开始用软边笔刷做柔和过渡，而不再只靠硬边切割
- 字幕中明确提到 `it seamless` 与 `soft transitions`，可结合当前画面理解为：先把尖刺和层次做出来，再通过柔化边缘减少平铺接缝感
- 当前编辑层仍为 `Layer 2`，背景保持纯黑，说明所有白色风纹与黑色切口都在同一张灰度贴图内持续雕刻
- 这一步的目的，是让风纹既有攻击性的锯齿轮廓，又能在横向或纵向平移时维持较自然的无缝循环效果
缩回整张贴图检查无缝效果，并通过偏移纹理位置来观察中央接缝是否需要继续抹平

- 当前文档以较小缩放比例显示整张方形灰度贴图，能一次看到完整边界
- 上半部分是黑底向下切出的多组白色尖峰，下半部分则是一整片白区，其最底边出现一条模糊、锯齿状的黑色过渡带
- 右侧 `Layers` 面板显示当前活动层为 `Layer 3`，说明作者可能在新图层上继续做接缝修整或插入补丁形状
- 字幕里出现 `Move the texture. 512. The seam must be smoothed`，可结合当前画面理解为：将贴图按约半张宽度偏移，用中央位置暴露出原始边界，再专门处理缝线
- 中央区域没有明显硬直切线，而是保留模糊过渡，说明本步关注的是让拼接处在循环滚动时不出现突然的明暗断层
- 这一步的目标，是把已经完成的风纹贴图整理成可平铺资源，确保后续在材质里使用 `Panner` 或其他 UV 平移时不会因为接缝而露出重复边界

### 00:08:57-00:13:47 Add、Texture

- 本段定位：Add、Texture。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Opacity`、`Texture`、`Add`、`Panner`、`Emissive`、`材质`、`纹理`。

**关键画面：**

继续修整龙卷风风纹贴图，在底部交界处加入阴影和透明层次，让白色主体向黑色背景的过渡更自然

- 当前编辑层为 `Layer 3`
- 上方仍保留多根从黑区向下切入白区的尖刺形风刃，整体结构与前一段制作的攻击性纹理一致
- 画面下方白色主体与最底部黑色区域之间，不再是单一硬切边，而是形成一条带有模糊锯齿的过渡带
- 左侧画笔面板显示当前画笔 `Size` 约为 `70 px`，`Hardness` 为 `0%`，说明作者正用软边笔刷叠加灰阶或擦除边缘
- 字幕提到 `add some shadows`、`erase a bit`、`reduce transparency`，可结合当前画面理解为：通过局部压暗、轻微擦除和调整透明感，让纹理内部出现更丰富的明暗层次
- 这一步的目标，是避免风纹贴图只有纯黑与纯白两级对比，使其在材质里既能保留尖锐形态，又能产生更柔和、更立体的烟风层次
将纹理偏移约半张宽度后检查平铺效果，确认尖刺条带在重复排列时的接缝是否自然

- 画面中同一组黑白风纹上下各出现一排，说明作者正通过偏移或复制后的预览检查贴图重复效果
- 字幕明确提到 `move it to 512`，可理解为将贴图按约 `512 px` 的半幅距离移动，使原始边界落到中间区域，便于直接观察拼缝
- 中央下方有一个蓝色矩形选区框，表明作者正在选定一块区域进行移动、合并或对齐
- 上下两排纹理都保留一致的尖刺节奏：黑色尖刺从上方向下切入白区，白区底边再以柔和模糊过渡回黑色，这种结构有助于平移时维持连续流动感
- 右侧弹出的图层菜单和字幕中的 `combine`、`turn off the pattern` 表明此时正在准备合并、隐藏某些辅助图层或对比层，以便单独检查最终灰度贴图效果
- 这一步的目的，是在正式导出前验证纹理重复后的视觉连续性，避免在材质里平铺时出现明显断线或周期痕迹
完成最终模糊与接缝检查后，确认这张风纹灰度贴图已经可以保存并导入 Unreal Engine

- 画面中央蓝色选区框内展示的是最终要保留的主要风纹结构：多根向上倾斜的白色风刃被黑色背景分隔，边缘带有连续的锯齿和局部模糊过渡
- 纹理左右两侧还能看到同类尖刺结构延续到画面外，说明作者正在检查边界连续性，而不是只看中间一小块局部形状
- 左下画笔设置显示仍使用较小的软边画笔，说明最后一步是在局部轻微模糊或抹平，而不是再做大幅度重画
- 字幕中明确提到 `blur`、`our texture is ready`、`Save it and throw it into Unreal Engine`，可结合当前画面理解为：在做完必要的模糊和接缝修整后，这张灰度风纹已经达到可用状态
- 右侧图层区只保留一个可见的纹理层，说明辅助检查步骤基本结束，当前看到的就是接近导出状态的最终结果
- 这一步的结论是：龙卷风用的滚动风纹贴图已经完成，可保存为纹理资源并在 Unreal 材质中配合 `Panner`、Opacity/Alpha 或 Emissive 流程继续使用

### 00:13:47-00:16:35 Emitter、System、Spawn

- 本段定位：Emitter、System、Spawn。
- 知识点：从基础材质创建 Material Instance 后，用实例参数控制颜色、透明度和纹理变体。；材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Particle` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Emitter`、`Particle`、`Spawn` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：Lifetime 决定粒子存活时间，需要和 Spawn 数量、速度以及透明度曲线一起调。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Emitter`、`Particle`、`Spawn`、`Lifetime`、`Color`、`Alpha`、`Opacity`、`Material`。

**关键画面：**

在 Photoshop 中把已经完成的龙卷风风纹灰度贴图导出为 `PNG`，准备导入 Unreal Engine

- 前景弹出 `Save As` 窗口，`Save as type` 明确为 `PNG (*.png)`
- 文件名输入框当前为 `Untitled-1.png`，说明作者正在为最终纹理执行保存导出
- 背后仍能看到已经完成的黑白风纹贴图：黑色尖刺从上方切入白色主体，底部边缘则带有模糊过渡，保持无缝循环所需的连续结构
- 画面中部还能看到蓝色选区框，说明导出前最后一次检查的区域仍停留在编辑界面中
- 字幕继续强调 `our texture is ready` 与 `Import into Unreal`，可结合当前画面理解为：贴图制作阶段已经结束，接下来转入引擎侧导入与应用
- 这一步的结果，是把可平铺的风纹灰度贴图正式输出为外部纹理文件，供后续材质实例与 Niagara 效果使用
在 Unreal Engine 的材质实例中接入导入后的风纹贴图，并开始为地面风柱效果调节主纹理、溶解和失真参数

- 当前打开的资源标签为 `MI_TornadoGroundWin...`，说明这是龙卷风地面风纹用的 `Material Instance`
- 左侧预览球体/平面上已经显示出刚制作的白色尖刺风纹，证明新贴图已成功接入材质
- 右侧 `Parameter Groups` 中可见 `Base Texture`
  - `T_Main = T_GroundWind_01`
  - `T_Mask = WhiteSquareTexture`
  - `Use Colormap? = 0.0`
- `Main (Scale/Scroll)` 已启用，当前通道值可见：
  - `R = 1.0`
  - `G = 1.0`
  - `B = -0.859428`
  - `A = 0.0`
- `Dissolve` 组已启用：
  - `T_Dissolve = T_Voronise007`
  - `Dissolve (Scale/Scroll)` 中可见 `R = 1.0`、`G = 2.0`、`B = 1.5`、`A = 0.0`
  - `Smoothness = 1.0`
- `Distortion` 组也已出现，并挂接 `T_Distortion = T_Voronise002`
- 这一步的目的，是把 Photoshop 导出的灰度风纹作为主形状贴图送入材质实例，再用溶解纹理和失真纹理为后续的 `Emitter/System/Spawn` 驱动效果准备可调参数
在 `NS_Tornado` 的 Niagara 发射器中配置地面风纹层的生成方式，让该层只生成一次并维持一个长寿命粒子

- 当前系统窗口为 `NS_Tornado`
- 中央选中的发射器名为 `Empty`
- 该发射器堆栈可见模块顺序：
  - `Emitter State`
  - `Spawn Burst Instantaneous`
  - `Initialize Particle`
  - `Particle Update`
  - `Particle State`
  - `Mesh Renderer`
- 右侧 `Initialize Particle` 面板中可见关键设置：
  - `Lifetime Mode = Direct Set`
  - `Lifetime = 10.0`
  - `Color Mode = Unset`
  - `Position Mode = Simulation Position`
- 字幕明确说明 `emitter will spawn once` 与 `single particle with a lifetime of 10 seconds`，可结合堆栈中的 `Spawn Burst Instantaneous` 理解为：该层不会持续刷出大量粒子，而是一次性生成一个持续存在的载体
- 左侧预览窗口中已经能看到龙卷风底部附近的青色风纹层，说明该单粒子网格层已在系统里参与最终效果预览
- 这一步的目的，是把导入的地面风纹材质绑定到一个稳定的 Niagara 网格粒子上，用单次生成和长寿命维持持续存在的地面风切层

### 00:16:35-00:20:39 Color、Alpha、Material

- 本段定位：Color、Alpha、Material。
- 知识点：本段围绕 `Alpha` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Blender` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Color` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Color`、`Alpha`、`Opacity`、`Material`、`Panner`、`Emissive`、`Blender`、`材质`。

**关键画面：**

在 `NS_Tornado` 中基于现有风纹层复制出新的发射器，并开始调整该层的颜色与尺寸控制方式

- 系统中同时可见两个相关发射器：左侧为 `TornadoWinds`，右侧为当前选中的 `Empty`
- 左侧预览窗口已经显示龙卷风底部的青色环形风纹层，说明复制出的层正在参与整体效果叠加
- 当前查看的是右侧 `Empty` 发射器的 `Initialize Particle` 细节面板
- 关键可见设置：
  - `Lifetime Mode = Direct Set`
  - `Lifetime = 10.0`
  - `Color Mode = Direct Set`
  - `Position Mode = Simulation Position`
- 中央发射器堆栈包含：
  - `Spawn Burst Instantaneous`
  - `Initialize Particle`
  - `Particle Update`
  - `Particle State`
  - `Mesh Renderer`
- 字幕提到 `change the color`、`It can be copied`、`edit the size`，可结合当前画面理解为：先复制一层已有风纹发射器，再通过修改颜色和尺寸得到另一层视觉变体
- 这一步的目的，是为龙卷风底部风切层建立第二个可独立调色、调尺度的 Niagara 网格粒子层
切到 Blender 导入地面圆柱壳体的 `FBX`，准备对网格方向做反转或清理不需要的部分

- 当前界面为 Blender 的 `File View` 导入窗口
- 文件列表中高亮选中的资源是 `SM_GroundCylinder_01.fbx`
- 同目录还能看到与本段相关的其他网格文件：
  - `SM_Ring_01.FBX`
  - `SM_Ring_01_Inverted.fbx`
- 右侧导入选项面板中可见：
  - `Custom Normals` 勾选
  - `Subdivision Data` 勾选
  - `Custom Properties` 勾选
  - `Import Enums As ...` 处于开启状态
  - `Scale = 1.00`
  - `Decal Offset = 0.00`
  - `Apply Transform` 可见但未启用
  - `Manual Orientation` 中显示 `Forward = Z Forward`、`Up = Y Up`
- 底部主按钮为 `Import FBX`
- 字幕提到 `go to Blender in order to invert`、`delete`、`look at direction`，可结合当前画面理解为：作者需要把 Unreal 里的地面壳体导回 Blender，检查朝向并删除不需要的面或做内外翻转处理
把反转后的地面壳体重新接回 Niagara，并在 `Back Face` 渲染器中绑定网格与材质后微调高度、尺寸和明暗

- 当前系统仍为 `NS_Tornado`
- 右侧 Details 明确显示正在编辑 `Back Face (Mesh Renderer)`
- `Meshes` 配置中：
  - `Index [0] = SM_GroundCylinder_01_Inverted`
- `Override Materials` 中：
  - `Explicit Mat = MI_TornadoGroundWindL_01`
  - `Source Mode = Particles`
- 下方 `Bindings` 可见关键绑定：
  - `Position Binding = PARTICLES Position`
  - `Color Binding = PARTICLES Backface Color`
  - `Velocity Binding = PARTICLES Velocity`
  - `Mesh Orientation Binding = PARTICLES MeshOrientation`
  - `Scale Binding = PARTICLES Scale`
- 左侧预览窗口能看到龙卷风底部出现一圈更暗的青色地面风纹壳体，说明反转网格已经正确贴附到龙卷风底部并形成环状承托层
- 字幕提到 `raise it a little`、`increase its size`、`make it even darker`，可结合当前画面理解为：在网格和材质接通后，还要继续微调位置高度、整体缩放以及颜色/明度，让这一层更贴合主风柱并退到次要亮度层级

### 00:20:39-00:24:03 Spawn、Color、Add

- 本段定位：Spawn、Color、Add。
- 知识点：本段围绕 `Color` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：角色或镜头演示需要导入 FBX/骨骼/动画，并用 Sequencer 校准触发时机。
- 知识点：本段围绕 `Spawn`、`Curve`、`Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Curve` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Spawn`、`Color`、`Curve`、`Sequencer`、`Add`。

**关键画面：**

在 `NS_Tornado` 的 `Empty` 发射器中直接调暗背面颜色，并同步观察该地面风纹层的位置与缩放

- 当前打开的是 `Initialize Particle` 面板，`Color Mode = Direct Set`
- 颜色字段弹出了 `Color Picker`
  - `Hex Linear = 000404FF`
  - `Hex sRGB = 00221FFF`
  - 颜色预览显示为非常暗的青绿色
- 中央发射器堆栈里当前层仍使用 `PARTICLES Backface Color`
- 左侧预览窗口可见龙卷风底部的环形风纹层已经明显比主体更暗，说明本次调色目标是把承托层压到次要亮度
- 右侧同一面板还能看到：
  - `Position Offset` 的 `Z = -200.0`
  - 下方缩放相关字段可见一组较大的值，约为 `3.5` 与 `4.5`
- 这一步的作用，是通过直接设置粒子颜色并配合位置、尺度微调，让底部反转壳体形成更低、更暗、更贴地的地面风切层
在关卡 Sequencer 的实际镜头里继续试色，边播放龙卷风镜头边微调地面风纹层的颜色

- 当前界面回到关卡编辑器，底部打开了 `Sequencer`
- 时间线中可见轨道：
  - `CameraActor`
  - `NS_Tornado`
  - `NiagaraComponent0`
  - `System Life Cycle`
- 当前播放头约在 `0.9833` 秒位置，说明作者正在真实镜头时机下检查颜色变化
- 右侧弹出的 `Color Picker` 仍处于激活状态，说明颜色调整并非只在 Niagara 预览窗完成，而是需要在最终场景光照和相机视角下确认
- 本帧颜色参数可见为更深的青绿色：
  - `Hex Linear = 010202FF`
  - `Hex sRGB = 0B1917FF`
- 视口中央地面位置只留下很弱的风纹痕迹，说明这一层被有意压暗到接近环境阴影，只在龙卷风底部提供轻微承托感
- 这一步的目的，是在 Sequencer 驱动的最终演示镜头中直接比对颜色，避免在 Niagara 预览里看起来合适、但进入真实场景后过亮或抢主效果
为 `TornadoGround` 发射器调整网格缩放曲线，让底部风纹层在更短时间内长到目标尺寸

- 当前选中的发射器名为 `TornadoGround`
- 发射器堆栈中已高亮 `Scale Mesh Size` 模块
- 右侧 `Scale Factor` 使用 `Vector from Curve`
- 曲线编辑器标题显示为 `Curve for Vector3's`
- 三个轴向曲线 `X`、`Y`、`Z` 同时可见，说明网格缩放由一组向量曲线共同驱动，而不是单纯的标量倍增
- `CurveIndexer = EMITTER Age`，表示缩放曲线随发射器年龄推进
- 下方 `Scale Curve` 初值显示为 `1.0, 1.0, 1.0`
- 字幕提到 `I want it to be faster` 与 `Let's try in half a second for it to spawn`，可结合当前画面理解为：作者要把原本较慢的尺寸增长过程压缩到约半秒内完成，以更快形成地面风纹层
- 左侧预览窗口中的地面环形风纹依旧贴附在龙卷风底部，说明曲线调整是在保持现有视觉结构的前提下优化生成节奏

### 00:24:03-00:27:02 Spawn、Material、Add

- 本段定位：Spawn、Material、Add。
- 知识点：本段围绕 `Spawn`、`Curve` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Curve`、`Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Spawn` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Spawn`、`Alpha`、`Opacity`、`Material`、`Curve`、`Add`、`Panner`、`Emissive`。

**关键画面：**

在关卡 Sequencer 中验证加快生成后的地面风纹层，确认它能在更短时间内包住龙卷风底部

- 视口中龙卷风主体已经完全建立，底部新增的深色碗状风纹壳体明显向上包裹，边缘露出青色高光风切片
- 底部壳体不再只是平贴在地面，而是形成一圈抬起的立体包边，说明前面调过的反转网格、颜色和尺寸已经共同生效
- 底部时间线为 `Sequencer`，播放头约在 `0.8253` 秒位置
- 字幕继续强调 `I want it to be faster` 和 `Let's try in half a second for it to spawn`，可结合当前画面理解为：作者正在检查把该层的生成压缩到约半秒后，镜头里是否能更及时出现
- 右侧 `Details` 中当前关卡序列为 `LS_StylizedTornado`
- 这一步的目标，是在最终镜头中直接确认底部风纹层的出现场时、包裹高度和视觉存在感都与主风柱匹配
确认 `TornadoGround` 的缩放曲线已经达到可用状态，并准备复制出第二个变体层

- 当前选中的发射器为 `TornadoGround`
- 右侧仍在编辑 `Scale Mesh Size`
- `Scale Factor = Vector from Curve`
- 曲线面板中可见一个用于控制加速生成的向量曲线，三轴曲线整体在前半段快速抬升，之后趋于平缓
- `CurveIndexer` 显示为 `Divide Float`
  - `A = EMITTER Age`
  - `B = 0.5`
- 这一组设置说明发射器年龄被除以 `0.5` 后再去采样曲线，也就是把原本更长的缩放过程压缩到约半秒完成
- `Scale Curve` 基础值仍为 `1.0, 1.0, 1.0`
- 左侧预览中底部地面风纹层已经以较稳定的高度与尺寸包住龙卷风底部
- 字幕提到 `this part is ready` 与 `You can copy it so that there are two variations`，可结合当前画面理解为：这一层的生成曲线和形态已经满意，下一步要复制它做出两个略有差异的版本叠加
在最终镜头里复核地面风纹层的整体成像，并准备继续复制材质/变体扩展出更多底部层次

- 视口中龙卷风主体下方的碗状地面风纹层已经完整成形，顶部亮青色条带沿壳体边缘环绕，说明网格、材质、颜色和生成曲线已联合作用
- 底部壳体整体比主风柱更暗，但边缘仍保留清晰的发光切片，不会完全淹没在地面阴影里
- 底部 `Sequencer` 播放头约在 `0.9833` 秒位置，说明这是在接近 1 秒时对成像结果做最终镜头检查
- 右侧 `Details` 仍指向 `LS_StylizedTornado`，表明这一帧不是孤立预览，而是在正式关卡序列里看整体效果
- 字幕开始转向 `create the material`、`We can copy here`，可结合当前画面理解为：当前这个地面风纹版本已经可用，接下来要基于它复制材质或实例，构造更多变化层
- 这一帧的结论是：第一层地面风纹包裹效果已达到可接受状态，并为后续叠加第二变体或更多材质版本提供了基准

### 00:27:02-00:31:56 System、Spawn、Color

- 本段定位：System、Spawn、Color。
- 知识点：本段围绕 `Noise` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：本段围绕 `Add`、`Additive` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Depth Fade` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Particle` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Color` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Particle`、`Spawn`、`Color`、`Alpha`、`Opacity`、`Material`、`Noise`、`Depth Fade`。

**关键画面：**

在 Unreal 内容浏览器中复制地面风纹用的材质实例，准备做第二个视觉变体

- 当前仍在关卡视口中预览龙卷风，底部碗状地面风纹层已经稳定可见
- 底部内容浏览器定位到 `Content / VFX_Library / Materials / Instances / Tornado`
- 可见的材质实例缩略图包括：
  - `MI_TornadoGroundWindL_01`
  - `MI_TornadoMeshWind_01`
  - 若干 `MI_TornadoStylized_0x`
- 当前新选中的实例名称显示为 `indWind_02`，从缩略图内容看仍是同类黑白风纹材质实例，结合字幕可判断这是复制后准备重命名/派生的新版本
- 字幕提到 `create the material` 与 `We can copy here`，可结合当前画面理解为：不直接从零重做，而是复制现有地面风纹材质实例，再在副本上修改颜色、贴图或附加参数
- 这一步的目的，是为龙卷风底部地面层建立第二套可独立调整的材质实例，从而形成两个风纹版本叠加
选用简单圆盘静态网格作为新的 3D 载体，准备把复制出的材质实例测试到另一种地面形状上

- 视口中央选中了一个扁平圆盘网格，当前对象名为 `SM_Circle_01`
- 该圆盘位于龙卷风底部下方，作为独立测试平面存在，用于观察把风纹材质铺到简单几何体上的结果
- 底部内容浏览器当前定位到 `Content / VFX_Library / Meshes`
- 可见相关网格资源包括：
  - `SM_Circle_01`
  - `SM_Cone_01`
  - `SM_Cylinder_01`
  - `SM_CylinderBowl_01`
  - `SM_CylinderHeight_01`
  - `SM_GroundCylinder_01`
  - `SM_GroundCylinder_01_`
  - `SM_Ring_01`
  - `SM_Ring_01_Inverted`
- 右侧 `Transform` 面板可见：
  - `Location = (1337.0, 1152.0, 27.0)`
  - `Rotation = (0.0, 0.0, 0.0)`
  - `Scale = (5.0, 5.0, 5.0)`
- 当前 `Static Mesh` 字段确认是 `SM_Circle_01`
- 字幕提到 `Here is the circle and if we apply this material here`，可结合当前画面理解为：作者正在尝试不用碗状壳体，而改用圆盘平面来承载新复制出的风纹材质，比较不同 3D 载体的效果
把复制出的第二个地面风纹版本接回 Niagara，形成 `TornadoGround001` 变体，并继续评估其高度与尺寸

- 中央系统图中可见新的发射器 `TornadoGround001`
- 原有的 `Empty` 发射器仍在右侧保留，说明当前是在现有地面风纹系统基础上增加第二变体，而不是直接替换原版本
- `TornadoGround001` 的堆栈与前一层相似，仍包含：
  - `Spawn Burst Instantaneous`
  - `Initialize Particle`
  - `Particle State`
  - `Scale Mesh Size`
  - `Dynamic Material Parameters`
  - `Front Face`
  - `Back Face`
- 右侧 `Initialize Particle` 面板中可见当前颜色分量为很暗的青绿色：
  - `Red = 0.000828`
  - `Green = 0.009672`
  - `Blue = 0.0098`
  - `Alpha = 1.0`
- 左侧预览窗口里，龙卷风底部除原有碗状承托层外，还能看到一圈更薄、更外扩的尖刺风纹，说明第二变体已经开始提供额外的边缘形状变化
- 字幕提到 `It should be big enough and still need to raise it`，可结合当前画面理解为：第二版本的大致尺寸已接近可用，但仍需继续上移或微调位置，避免与主底层重叠得过死
- 这一步的结果，是在底部风纹系统中正式建立第二个变体层，为后续通过 `Noise`、`Add`、`Depth Fade` 或颜色差异叠加出更丰富的地面扰动做准备

### 00:31:56-00:36:43 Spawn、Color、Add

- 本段定位：Spawn、Color、Add。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Color` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Spawn` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：You can still add more revolutions.。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Spawn`、`Color`、`Add`。

**关键画面：**

这张图展示第二种地面风圈材质实例已经被选中并参与场景预览，作者接下来准备给这层风纹加入随时间旋转的方向控制

- 当前视图位于关卡 `Stylized_Tornado`
- 中央视图
  - 龙卷风底部已经同时存在主体碗状风圈和外围更薄的一层风痕
  - 画面里最明显的是底部青绿色亮圈以及围绕主体的半透明风纹
  - 说明第二材质实例已经不仅停留在资源浏览器中，而是开始影响场景效果
- 下方 `Content Browser`
  - 当前路径位于：
    - `Content > VFX_Library > Materials > Instances > Tornado`
  - 当前搜索词仍是：
    - `Tornado`
  - 可见材质实例包括：
    - `MI_TornadoGroundWind_01`
    - `MI_TornadoGroundWind_02`
    - `MI_TornadoMeshWind_01`
    - `MI_TornadoStylized_01`
    - `MI_TornadoStylized_02`
    - `MI_TornadoStylized_03`
  - 当前选中的是：
    - `MI_TornadoGroundWind_02`
- 右侧 `Outliner`
  - 可见：
    - `CameraAct`
    - `LS_Stylize...`
    - `NS_Tornado`
- 字幕直接给出下一步方向：
  - “Maybe add it so that it rotates over time.”
  - “Add mesh orientation. Here is Z.”

这一步本身更像是状态确认：第二版地面风圈材质已经准备好，可以作为独立变体参与特效。下一步将不是单纯改颜色，而是把 `Mesh Orientation` 或类似旋转控制接进来，让这层风纹随时间绕 `Z` 轴变化，增加地面气流的活性
这张图是在关卡 Sequencer 中直接暴露第二版地面风纹的问题：当前镜头里只能看到地面上一块被吸收或被压暗的痕迹，而看不到预期的清晰风纹形状

- 当前视图位于关卡 `Stylized_Tornado`
- 中央视图
  - 整个场景几乎只剩深蓝灰色背景和地面
  - 画面下方中间能看到一块较浅的模糊亮斑或暗吸收区域
  - 但看不到前面那种清晰的锯齿风纹边界
  - 这说明当前第二材质/旋转方案在镜头里表现不理想
- 下方 `Sequencer`
  - 当前序列是 `LS_StylizedTornado`
  - 当前时间明确显示为：
    - `0.45`
  - 可见轨道仍包括：
    - `CameraActor`
    - `NS_Tornado`
    - `NiagaraComponent0`
    - `System Life Cycle`
  - `System Life Cycle` 红色区段覆盖当前时刻
- 右侧 `Outliner`
  - 当前可见：
    - `CameraAct`
    - `LS_Stylize...`
    - `NS_Tornado`
- 字幕直接说明观察结果：
  - “We see what is absorbed.”
  - “Here you can see the problem.”

这一步不是在展示成功效果，而是在做问题定位。当前可确认的结论是：这版地面风纹进入镜头后更像一片被吸收的地面痕迹，而不是可读的旋转风线，因此后续需要回到材质、朝向或颜色/透明度设置里继续修正
这张图把时间线拉到更早的位置继续检查，结果是第二版地面风纹几乎完全消失，只剩一块很弱的地面痕迹，进一步证明当前方案在镜头里不可读

- 当前视图仍在关卡 `Stylized_Tornado`
- 中央视图
  - 画面里看不到清晰的龙卷风底部风圈或旋转片状纹理
  - 地面中部只剩一块很淡的亮斑/雾状痕迹
  - 说明当时间提前到特效刚开始阶段时，这层效果的存在感更弱
- 下方 `Sequencer`
  - 当前序列仍是 `LS_StylizedTornado`
  - 当前时间明确显示为：
    - `0.0333`
  - 左侧还能看到更大的时间范围，说明作者正在把播放头往极早阶段拖动做排查
  - `System Life Cycle` 红色区段从当前时刻开始覆盖后续时间
- 右侧 `Outliner`
  - 当前可见：
    - `CameraAct`
    - `LS_Stylize...`
    - `NS_Tornado`

这一步延续上一张的问题判断，但证据更强：不仅在 `0.45s` 时效果不理想，在更早的 `0.0333s` 时几乎完全不可见。也就是说，问题不只是某一帧的角度或对比度，而是这版地面风纹从生成初期开始就缺乏可读性，后续必须回到发射逻辑、材质表现或旋转方案上重新调整

### 00:36:43-00:41:01 Emitter、Spawn、Color

- 本段定位：Emitter、Spawn、Color。
- 知识点：本段围绕 `Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。；烟雾效果通常依赖较长 Lifetime、透明度衰减、噪声扰动和柔和的材质混合。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：烟雾效果通常依赖较长 Lifetime、透明度衰减、噪声扰动和柔和的材质混合。
- 知识点：本段围绕 `Emitter` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Spawn` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Particle` 进行设置，需结合关键画面核对真实节点和参数。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Emitter`、`Particle`、`Spawn`、`Lifetime`、`Color`、`Alpha`、`Opacity`、`Material`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Niagara Stack
> - 组成部分: 粒子预览 + Niagara Stack + `Update Mesh Orientation` 属性图 + Parameters 面板
> - 所属: `NS_Tornado`
> - 目的: 在保留 `Mesh Renderer` 的前提下，通过 `Update Mesh Orientation` 继续增加网格粒子的自旋，让龙卷风片状网格绕竖直轴扭转
>
> 模块栈:
> | 顺序 | 组 | 模块/项 | 状态 | 关键设置 | 作用 |
> |---:|---|---|---|---|---|
> | 1 | Emitter | `Empty` | Enabled | `CPU` | 当前发射器运行在 CPU |
> | 2 | Emitter Update | `Emitter State` | Enabled | `Self Once` | 发射器只播放一次 |
> | 3 | Emitter Update | `Spawn Burst Instantaneous` | Enabled | 图中未显示具体数量 | 一次性生成一批粒子 |
> | 4 | Particle Spawn | `Initialize Particle` | Enabled | 图中未展开参数 | 初始化粒子基础属性 |
> | 5 | Particle Spawn | `Initial Mesh Orientation` | Enabled | 模块存在，参数未展开 | 设定初始朝向 |
> | 6 | Particle Update | `Particle State` | Enabled | 图中未展开参数 | 维持粒子更新状态 |
> | 7 | Particle Update | `Update Mesh Orientation` | Enabled | `Orientation Method=Rotation Rate` | 在更新阶段持续旋转网格朝向 |
> | 8 | Particle Update | `Scale Color` | Enabled | 图中未展开参数 | 继续控制颜色/透明度缩放 |
> | 9 | Render | `Mesh Renderer` | Enabled | 渲染器存在，参数未展开 | 用网格而不是 Sprite 渲染龙卷风片段 |
>
> 设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Update Mesh Orientation.Orientation Method` | `Rotation Rate` | enum | Details | 旋转由角速度驱动 |
> | `Update Mesh Orientation.Rotation Vector` | `(0.0, 0.0, 1.0)` | Vector3 | Details | 围绕 Z 轴旋转 |
> | `Update Mesh Orientation.Rotation Rate` | `-0.2` | float | Details | 让网格沿负方向缓慢旋转 |
> | `Update Mesh Orientation.Rotation Coordinate Space` | `Mesh` | enum | Details | 按网格自身坐标解释旋转 |
>
> 参数面板:
> - 左下 `Parameters` 停在 `System Attributes` 分组，可见 `Age`、`bCompleteOnInactive`、`CurrentLoopDuration`、`ExecutionState`、`LoopCount`、`NormalizedLoopAge` 等系统属性
> - 当前截图没有展示新增 `User.*` 参数，说明这一步主要修改模块属性而不是暴露用户参数
>
> 预览结果:
> - 左侧预览中的龙卷风由多片发光的青绿色网格片组成，片状元素沿竖直方向缠绕
> - 底部中文字幕说明可以把旋转次数继续加到 `0.2`、`0.5`，并建议朝相反方向旋转；当前画面对应先把 `Rotation Rate` 设为 `-0.2` 的试调结果
> 图表转写（UE-GTXT v4）
> - 类型: Niagara Stack
> - 组成部分: 粒子预览 + Niagara Stack + `Spawn Rate` 属性图 + Parameters 面板
> - 所属: `NS_Tornado`
> - 目的: 把发射方式改成持续生成，并把 `Spawn Rate` 先设为 `0.0` 以演示“每秒生成数量”这一控制位
>
> 模块栈:
> | 顺序 | 组 | 模块/项 | 状态 | 关键设置 | 作用 |
> |---:|---|---|---|---|---|
> | 1 | Emitter | `Empty` | Enabled | `CPU` | 当前发射器 |
> | 2 | Emitter Update | `Emitter State` | Enabled | `Self Once` | 维持单次播放 |
> | 3 | Emitter Update | `Spawn Rate` | Enabled | 当前选中该模块 | 以“每秒粒子数”持续生成 |
> | 4 | Particle Spawn | `Initialize Particle` | Enabled | 图中未展开参数 | 初始化粒子 |
> | 5 | Particle Update | `Particle State` | Enabled | 图中未展开参数 | 更新粒子状态 |
> | 6 | Render | `Sprite Renderer` | Enabled | 已切换为 Sprite 渲染器 | 用贴图精灵而不是网格绘制烟雾 |
>
> 设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Spawn Rate.SpawnRate` | `0.0` | float | Details | 当前每秒不连续生成粒子 |
> | `Spawn Rate.Spawn Probability` | `1.0` | float | Details | 生成概率保持 100% |
>
> 参数面板:
> - 左下仍停在 `System Attributes`，说明此步没有新增参数面板操作
>
> 预览结果:
> - 左侧预览仍能看到青绿色龙卷风底部片状体，便于对比后续从 Burst 改为 Rate 后的生成效果
> - 画面字幕举例说明 `9` 秒或固定速率会“生成一定数量的粒子，例如 100 个”，对应本图强调 `Spawn Rate` 的语义而非最终数值
> 图表转写（UE-GTXT v4）
> - 类型: Niagara Stack
> - 组成部分: 顶视粒子预览 + Niagara Stack + `Initialize Particle` 属性图 + Parameters 面板
> - 所属: `NS_Tornado`
> - 目的: 在烟雾版发射器中设置粒子寿命、随机颜色透明度、环形出生位置和较大的 Sprite 尺寸，让烟雾先在地面形成一圈淡色雾环
>
> 模块栈:
> | 顺序 | 组 | 模块/项 | 状态 | 关键设置 | 作用 |
> |---:|---|---|---|---|---|
> | 1 | Emitter Update | `Emitter State` | Enabled | `Self Once` | 发射器单次播放 |
> | 2 | Emitter Update | `Spawn Rate` | Enabled | 当前已启用持续生成 | 控制每秒生成数量 |
> | 3 | Particle Spawn | `Initialize Particle` | Enabled | 当前选中 | 设置寿命、颜色、位置和 Sprite 尺寸 |
> | 4 | Particle Spawn | `Sub UV Animation` | Enabled | `Random` | 随机选择序列帧 |
> | 5 | Particle Spawn | `Add Velocity` | Enabled | `Linear` | 给予初速度 |
> | 6 | Particle Spawn | `Shape Location` | Enabled | `Ring / Disc` | 在圆环或圆盘范围内出生 |
> | 7 | Particle Update | `Solve Forces and Velocity` | Enabled | 图中未展开参数 | 求解速度和受力 |
> | 8 | Particle Update | `Particle State` | Enabled | 图中未展开参数 | 维持粒子更新 |
> | 9 | Render | `Sprite Renderer` | Enabled | 图中未展开参数 | 以 Sprite 绘制烟雾 |
>
> 设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Initialize Particle.Lifetime Mode` | `Direct Set` | enum | Details | 直接指定寿命 |
> | `Initialize Particle.Lifetime` | `5.0` | float | Details | 粒子持续 5 秒 |
> | `Initialize Particle.Color Mode` | `Random Range` | enum | Details | 在最小值和最大值之间随机颜色 |
> | `Initialize Particle.Color Minimum` | `R 0.020436, G 0.238839, B 0.221741, A 0.025` | LinearColor | Details | 更深、更透明的青绿色下限 |
> | `Initialize Particle.Color Maximum` | `R 0.009486, G 0.110863, B 0.102926, A 0.05` | LinearColor | Details | 更浅但仍低透明度的上限 |
> | `Initialize Particle.Position Mode` | `Simulation Position` | enum | Details | 以模拟位置作为出生基准 |
> | `Initialize Particle.Sprite Size Mode` | `Random Uniform` | enum | Details | 随机统一缩放 Sprite |
> | `Initialize Particle.Uniform Sprite Size Min` | `500.0` | float | Details | Sprite 最小尺寸 |
> | `Initialize Particle.Uniform Sprite Size Max` | `1200.0` | float | Details | Sprite 最大尺寸 |
>
> 预览结果:
> - 左侧顶视预览中，粒子在地面形成一圈很淡的青色烟雾环，中心区域留空
> - 字幕明确指出此时需要继续调整透明度并补上旋转，说明这一帧主要是在建立“环形生成 + 低透明烟雾底层”的基础状态

### 00:41:09-00:45:50 Lifetime、Color、Alpha

- 本段定位：Lifetime、Color、Alpha。
- 知识点：本段围绕 `Curve` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Point Attraction Force`、`Add` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Depth Fade` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Particle`、`Alpha` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Particle` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：烟雾效果通常依赖较长 Lifetime、透明度衰减、噪声扰动和柔和的材质混合。
- 知识点：Lifetime 决定粒子存活时间，需要和 Spawn 数量、速度以及透明度曲线一起调。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Particle`、`Spawn`、`Lifetime`、`Color`、`Alpha`、`Curve`、`Vortex Force`、`Point Attraction Force`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Niagara Stack
> - 组成部分: 顶视粒子预览 + Niagara Stack + `Scale Color` 曲线属性图
> - 所属: `NS_Tornado`
> - 目的: 用 `Scale Color` 的 Alpha 曲线让烟雾粒子随寿命衰减并被吸收，而不是始终保持同样透明度
>
> 模块栈:
> | 顺序 | 组 | 模块/项 | 状态 | 关键设置 | 作用 |
> |---:|---|---|---|---|---|
> | 1 | Particle Update | `Solve Forces and Velocity` | Enabled | 图中未展开参数 | 更新速度 |
> | 2 | Particle Update | `Particle State` | Enabled | 图中未展开参数 | 维持粒子状态 |
> | 3 | Particle Update | `Sprite Rotation Rate` | Enabled | 已加入旋转速率 | 让 Sprite 持续旋转 |
> | 4 | Particle Update | `Scale Color` | Enabled | 当前选中 | 通过颜色和 Alpha 曲线做随时间变化 |
> | 5 | Render | `Sprite Renderer` | Enabled | 图中未展开参数 | 输出烟雾 Sprite |
>
> 设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Scale Color.Scale Mode` | `RGB and Alpha Separately` | enum | Details | 分别控制颜色与透明度 |
> | `Scale Color.Scale RGB` | `(1.0, 1.0, 1.0)` | Vector3 | Details | 不额外缩放颜色通道 |
> | `Scale Color.Scale Alpha` | `Float from Curve` | enum | Details | Alpha 由曲线决定 |
> | `Scale Color.CurveIndex` | `Particles.NormalizedAge` | Niagara attribute | Details | 以粒子归一化寿命驱动曲线 |
> | `Scale Color.Scale Curve` | `1.0` | float | Details | 使用当前浮点曲线原值 |
>
> 曲线:
> - 红色浮点曲线从寿命起点附近接近 `1.0`，随后持续下滑
> - 到寿命后半段时数值约降到 `0.5` 以下，并在终点附近接近 `0.0`
> - 这意味着粒子出生时较明显，随着 `NormalizedAge` 增加逐步淡出
>
> 预览结果:
> - 左侧雾环仍然很淡，但字幕明确说“改变曲线，我希望它们被吸收”，对应本图的目标就是让外圈烟雾逐步消散
> 图表转写（UE-GTXT v4）
> - 类型: Niagara Stack
> - 组成部分: 预览 + 多发射器 Niagara Stack + `Smoke_Vortex / Shape Location` 属性图
> - 所属: `NS_Tornado`
> - 目的: 为 `Smoke_Vortex` 发射器加入与前一组烟雾相同寿命体系下的环形出生区域，让涡流烟雾从龙卷风底部圆环位置出现
>
> 模块栈:
> | 顺序 | 组 | 模块/项 | 状态 | 关键设置 | 作用 |
> |---:|---|---|---|---|---|
> | 1 | 发射器 | `Smoke_Far` | Enabled | 左侧可见同类烟雾发射器 | 作为远处烟层对照 |
> | 2 | 发射器 | `Smoke_Vortex` | Enabled | 当前选中 | 配置围绕龙卷风底部的近景烟雾 |
> | 3 | `Smoke_Vortex` / Emitter Update | `Emitter State` | Enabled | `Self Once` | 发射器单次播放 |
> | 4 | `Smoke_Vortex` / Emitter Update | `Spawn Rate` | Enabled | 已启用 | 控制持续生成 |
> | 5 | `Smoke_Vortex` / Particle Spawn | `Initialize Particle` | Enabled | 图中未展开参数 | 初始化粒子 |
> | 6 | `Smoke_Vortex` / Particle Spawn | `Sub UV Animation` | Enabled | `Random` | 随机帧序列 |
> | 7 | `Smoke_Vortex` / Particle Spawn | `Add Velocity` | Enabled | `Linear` | 添加线速度 |
> | 8 | `Smoke_Vortex` / Particle Spawn | `Shape Location` | Enabled | `Ring / Disc` | 在圆环范围内出生 |
> | 9 | `Smoke_Vortex` / Particle Update | `Vortex / Attraction` | Enabled | 文本可见 `...Attraction Force` | 让烟雾围绕中心旋转并受吸引 |
> | 10 | `Smoke_Vortex` / Particle Update | `Solve Forces and Velocity`、`Particle State`、`Sprite Rotation Rate`、`Scale Color` | Enabled | 图中均启用 | 解算烟雾运动与淡出 |
> | 11 | `Smoke_Vortex` / Render | `Sprite Renderer` | Enabled | 图中未展开参数 | 输出烟雾 Sprite |
>
> 设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Shape Location.Shape Primitive` | `Ring / Disc` | enum | Details | 用圆环或圆盘作为出生形状 |
> | `Shape Location.Ring / Disc Mode` | `Circle` | enum | Details | 使用圆形而不是六边形 |
> | `Shape Location.Ring Radius` | `2000.0` | float | Details | 扩大地面烟圈半径 |
> | `Shape Location.Ring / Disc Distribution Mode` | `Random` | enum | Details | 在范围内随机采样出生点 |
> | `Shape Location.Disc Coverage` | `0.0` | float | Details | 当前没有额外填充圆盘覆盖 |
> | `Shape Location.U Distribution` | `0.0` | float | Details | 当前未额外偏置角向分布 |
> | `Shape Location.Transform Order` | `Scale / Rotate / Offset` | enum | Details | 形状变换顺序 |
> | `Shape Location.Non Uniform Scale` | `(1.0, 1.0, 1.0)` | Vector3 | Details | 保持均匀尺度 |
> | `Shape Location.Rotation Coordinate Space` | `Local` | enum | Details | 在本地空间解释旋转 |
> | `Shape Location.Shape Origin` | `StackContext Position` | enum | Details | 以发射器上下文位置为原点 |
>
> 预览结果:
> - 左侧预览中，龙卷风底部周围开始出现一圈更清楚的旋涡烟线，而不是单纯的淡色雾环
> - 字幕说明“这里也需要 shape location，生命周期在这里是一样的”，表示当前发射器沿用前一个烟雾层的寿命逻辑，只新增环形出生位置
> 图表转写（UE-GTXT v4）
> - 类型: Niagara Stack
> - 组成部分: 透视预览 + `Smoke_Vortex` 发射器 Stack + `Initialize Particle` 属性图
> - 所属: `NS_Tornado / Smoke_Vortex`
> - 目的: 调整 `Smoke_Vortex` 粒子的寿命、透明度和尺寸，让底部涡流烟雾更贴地、更快消散，减少像“尘土仍在乱飞”的感觉
>
> 模块栈:
> | 顺序 | 组 | 模块/项 | 状态 | 关键设置 | 作用 |
> |---:|---|---|---|---|---|
> | 1 | Particle Spawn | `Initialize Particle` | Enabled | 当前选中 | 重新设定寿命、颜色和尺寸 |
> | 2 | Particle Spawn | `Sub UV Animation` | Enabled | `Random` | 随机动画帧 |
> | 3 | Particle Spawn | `Add Velocity` | Enabled | `Linear` | 添加线速度 |
> | 4 | Particle Spawn | `Shape Location` | Enabled | `Ring / Disc` | 保持环形出生 |
> | 5 | Particle Update | `Particle State` | Enabled | 图中未展开参数 | 更新状态 |
> | 6 | Particle Update | `Vortex Force` | Enabled | 已加入旋涡力 | 让烟雾围绕中心旋转 |
> | 7 | Particle Update | `Sprite Rotation Rate` | Enabled | 已启用 | 旋转 Sprite |
> | 8 | Particle Update | `Scale Color` | Enabled | 已启用 | 随寿命淡出 |
> | 9 | Particle Update | `Solve Forces and Velocity` | Enabled | 已启用 | 解算运动 |
> | 10 | Render | `Sprite Renderer` | Enabled | 图中未展开参数 | 输出近地烟雾 |
>
> 设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Initialize Particle.Lifetime Mode` | `Random` | enum | Details | 在最小寿命和最大寿命之间随机 |
> | `Initialize Particle.Lifetime Min` | `1.5` | float | Details | 最短寿命 |
> | `Initialize Particle.Lifetime Max` | `3.0` | float | Details | 最长寿命 |
> | `Initialize Particle.Color Mode` | `Random Range` | enum | Details | 随机颜色范围 |
> | `Initialize Particle.Color Minimum` | `R 0.020436, G 0.238839, B 0.221741, A 0.01` | LinearColor | Details | 更透明的下限颜色 |
> | `Initialize Particle.Color Maximum` | `R 0.009486, G 0.110863, B 0.102926, A 0.02` | LinearColor | Details | 上限颜色仍保持较低 Alpha |
> | `Initialize Particle.Position Mode` | `Simulation Position` | enum | Details | 使用模拟位置 |
> | `Initialize Particle.Sprite Size Mode` | `Random Uniform` | enum | Details | 随机尺寸 |
> | `Initialize Particle.Uniform Sprite Size Min` | `500.0` | float | Details | 最小尺寸 |
> | `Initialize Particle.Uniform Sprite Size Max` | `1000.0` | float | Details | 最大尺寸比上一组更收敛 |
>
> 预览结果:
> - 左侧透视预览中，龙卷风底部保留一圈薄的旋涡烟带，但整体比前面更轻、更低、更不遮挡主体
> - 中文字幕说明还要继续过滤粒子数量，因为画面“看起来像尘土还在飞扬”，对应当前这一步是在压低寿命和透明度

### 00:45:50-00:50:04 Color、Material、Smoke

- 本段定位：Color、Material、Smoke。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 知识点：角色或镜头演示需要导入 FBX/骨骼/动画，并用 Sequencer 校准触发时机。
- 知识点：本段围绕 `Color` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Vortex Force` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：本段围绕 `Particle` 进行设置，需结合关键画面核对真实节点和参数。
- 知识点：烟雾效果通常依赖较长 Lifetime、透明度衰减、噪声扰动和柔和的材质混合。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Particle`、`Lifetime`、`Color`、`Alpha`、`Opacity`、`Material`、`Vortex Force`、`Sequencer`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: Niagara Stack
> - 组成部分: 透视预览 + `Smoke_Vortex` 发射器 Stack + `Vortex Force` 属性图
> - 所属: `NS_Tornado / Smoke_Vortex`
> - 目的: 通过 `Vortex Force` 把近地烟雾进一步卷入中心，形成更明显的底部旋涡，而不是平铺在地面上
>
> 模块栈:
> | 顺序 | 组 | 模块/项 | 状态 | 关键设置 | 作用 |
> |---:|---|---|---|---|---|
> | 1 | Particle Update | `Particle State` | Enabled | 图中未展开参数 | 基础粒子更新 |
> | 2 | Particle Update | `Vortex Force` | Enabled | 当前选中 | 对粒子施加旋涡力 |
> | 3 | Particle Update | `Sprite Rotation Rate` | Enabled | 图中未展开参数 | 让烟雾贴图持续旋转 |
> | 4 | Particle Update | `Scale Color` | Enabled | 图中未展开参数 | 继续按寿命淡出 |
> | 5 | Particle Update | `Solve Forces and Velocity` | Enabled | 图中未展开参数 | 计算受力后的速度 |
> | 6 | Render | `Sprite Renderer` | Enabled | 图中未展开参数 | 输出烟雾表现 |
>
> 设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Vortex Force.Vortex Force Amount` | `10000.0` | float | Details | 增强围绕中心轴的旋涡强度 |
> | `Vortex Force.Vortex Axis` | `(0.0, 0.0, 1.0)` | Vector3 | Details | 围绕竖直 Z 轴旋转 |
> | `Vortex Force.Vortex Axis Coordinate Space` | `Simulation` | enum | Details | 在模拟空间解释旋涡轴 |
> | `Vortex Force.Vortex Origin` | `Simulation Position` | enum | Details | 以模拟位置作为旋涡中心 |
> | `Vortex Force.Origin Pull Amount` | `5000.0` | float | Details | 把粒子向中心拉拢 |
> | `Vortex Force.Origin Pull Only On Vortex Axis` | 已勾选 | bool | Details | 只沿旋涡轴方向应用中心拉力 |
> | `Vortex Force.Use Distance Falloff` | 未启用 | bool | Details | 当前不按距离衰减涡流力 |
>
> 预览结果:
> - 左侧预览中，龙卷风底部的烟带更贴着主体边缘回旋，整体形态比前一张更集中
> - 截图加了播放蒙层，但仍可确认当前步骤是在用 `Vortex Force` 替代单纯位置分布，让底部烟雾更像被卷入龙卷风
> 图表转写（UE-GTXT v4）
> - 类型: Niagara Stack
> - 组成部分: 透视预览 + `Sparks_Vortex` 发射器 Stack + `Sprite Renderer` 属性图
> - 所属: `NS_Tornado / Sparks_Vortex`
> - 目的: 为龙卷风底部的亮点或火花层指定发光 Sprite 材质，并检查渲染朝向与排序设置，避免亮点在旋涡中乱跳
>
> 模块栈:
> | 顺序 | 组 | 模块/项 | 状态 | 关键设置 | 作用 |
> |---:|---|---|---|---|---|
> | 1 | Emitter Update | `Emitter State` | Enabled | `Self Once` | 发射器单次播放 |
> | 2 | Emitter Update | `Spawn Rate` | Enabled | 已启用 | 控制火花连续生成 |
> | 3 | Particle Spawn | `Initialize Particle` | Enabled | 图中未展开参数 | 初始化粒子 |
> | 4 | Particle Spawn | `Add Velocity` | Enabled | `Linear` | 添加初速度 |
> | 5 | Particle Spawn | `Shape Location` | Enabled | `Ring / Disc` | 沿底部圆环出生 |
> | 6 | Particle Update | `Particle State`、`Vortex Force`、`Sprite Rotation Rate`、`Scale Color`、`Solve Forces and Velocity` | Enabled | 图中均启用 | 让亮点围绕龙卷风运动并淡出 |
> | 7 | Particle Update | `Scale Sprite Size by Speed` | Enabled | 当前可见于栈中 | 随速度调整亮点尺寸 |
> | 8 | Render | `Sprite Renderer` | Enabled | 当前选中 | 设置发光材质和朝向行为 |
>
> 设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `Sprite Renderer.Material` | `MI_GlowAdd_01` | Material | Details | 使用发光加色材质绘制亮点 |
> | `Sprite Renderer.Material User Param Binding` | `None` | binding | Details | 没有额外用户材质覆盖 |
> | `Sprite Renderer.Source Mode` | `Particles` | enum | Details | 从粒子属性读取渲染数据 |
> | `Sprite Renderer.Alignment` | `Automatic` | enum | Details | 自动决定对齐方式 |
> | `Sprite Renderer.Facing Mode` | `Automatic` | enum | Details | 自动决定朝向 |
> | `Sprite Renderer.Default Pivot in UV Space` | `(0.5, 0.5)` | Vector2 | Details | 以贴图中心作为枢轴 |
> | `Sprite Renderer.Sort Mode` | `None` | enum | Details | 不做额外排序 |
> | `Sprite Renderer.Cast Shadows` | 已勾选 | bool | Details | 允许该渲染器投射阴影 |
> | `Sprite Renderer.Sort Order Hint` | `3` | int | Details | 用较高顺序提示参与渲染排序 |
> | `Sprite Renderer.Motion Vector Setting` | `Auto Detect` | enum | Details | 运动向量自动检测 |
>
> 预览结果:
> - 左侧预览中，龙卷风主体周围能看到一些更亮的小点或细碎高光，说明这一层不是烟雾而是额外的发光粒子
> - 中文字幕提到“它们移动得太混乱，需要不要换方向”，对应当前对 `Sparks_Vortex` 的材质与渲染层排查
> 图表转写（UE-GTXT v4）
> - 类型: 视口效果图 + Sequencer 时间线
> - 组成部分: 龙卷风视口预览 + Outliner + Sequencer
> - 所属: 关卡 `LS_StylizedTornado` 中的 `NS_Tornado`
> - 目的: 在 Sequencer 里回看烟雾靠近底座时的画面，判断底部烟圈是否扩散过大，并据此继续减小该层的烟雾量
>
> Sequencer:
> - 当前时间游标停在约 `6.5295`
> - 轨道层级可见 `Camera Cuts`、`CameraActor`、`NS_Tornado`、`NiagaraComponent0`
> - `NiagaraComponent0` 下展开了 `System Life Cycle`，其模式为 `Desired Age`
> - 视口缩略条显示从龙卷风靠近镜头到底部烟圈明显外扩的连续片段，便于逐帧判断扩散范围
>
> Outliner:
> - 当前关卡树中可见 `Stylized_Tornado` 世界、环境目录 `Env`、`Floor`、`PostProc`、`SkyAtmo`、`SkyLight`
> - 可见相机对象 `CameraAct` / `LS_StylizedTornado` 以及 Niagara 物体 `NS_Tornado`
>
> 预览结果:
> - 视口中央显示完成度较高的青绿色龙卷风，底部有一圈较厚的烟雾/碎片带围绕底座
> - 中文字幕明确说“如果烟雾像这样扩散得更开，你可以在这里减少它”，说明这张图的作用不是新增模块，而是用 Sequencer 观察最终效果并决定继续收紧底部烟层

### 00:50:04-00:51:14 Photoshop

- 本段定位：Photoshop。
- 知识点：本段围绕 `Photoshop` 进行设置，需结合关键画面核对真实节点和参数。
- 核对对象：`Photoshop`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> - 类型: 视口效果图 + Sequencer 时间线
> - 组成部分: 龙卷风视口预览 + Outliner + Sequencer
> - 所属: `LS_StylizedTornado / NS_Tornado`
> - 目的: 在转到 Photoshop 之前，先在 Sequencer 中锁定一个较稳定的预览帧，作为后续微调贴图或亮度的参考画面
>
> Sequencer:
> - 当前时间游标停在约 `2.3833`
> - 仍在 `Camera Cuts > CameraActor > NS_Tornado > NiagaraComponent0 > System Life Cycle` 这一层级下预览
> - 上方缩略轨显示多个龙卷风关键帧，当前位于前半段较靠近起始的位置
>
> 预览结果:
> - 画面中龙卷风主体已经形成连续的青绿色螺旋体，底部烟圈较上一组收敛，没有明显大面积外扩
> - 字幕说明“接下来演示这里还能再做一点调整”，表示这张图是进入 Photoshop 处理前的效果基准帧
> 图表转写（UE-GTXT v4）
> - 类型: 视口效果图 + 关卡后处理设置
> - 组成部分: 龙卷风视口预览 + Outliner + `PostProcessVolume` 属性图 + Sequencer
> - 所属: 关卡 `LS_StylizedTornado`
> - 目的: 不在 Niagara 内继续加模块，而是通过关卡后处理增强发光和整体观感，让龙卷风在最终镜头里更亮、更有能量感
>
> Outliner:
> - 右侧选中了 `PostProc`，对应下方 `Details` 的 `PostProcessVolume`
>
> 设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `PostProcessVolume.Location` | `(1150.0, 7750.0, 760.0)` | Vector3 | Details | 关卡中后处理体的位置 |
> | `PostProcessVolume.Rotation` | `(0.0, 0.0, 0.0)` | Rotator | Details | 无额外旋转 |
> | `PostProcessVolume.Scale` | `(1.0, 1.0, 1.0)` | Vector3 | Details | 默认缩放 |
> | `Bloom.Method` | `Convolution` | enum | Details | 使用卷积式 Bloom |
> | `Bloom.Intensity` | `20.0` | float | Details | 大幅提高高亮扩散强度 |
> | `Bloom.Threshold` | `-1.0` | float | Details | 允许更广泛的亮区进入 Bloom |
> | `Bloom.Size Scale` | `1.0` | float | Details | 保持基础 Bloom 尺度 |
>
> Sequencer:
> - 当前时间游标停在约 `2.4483`
> - `CameraActor` 轨道提示范围为 `0 - 600 (600 frames)`，说明当前镜头处于整段序列的中前段
>
> 预览结果:
> - 视口中的青绿色龙卷风已经明显更亮，发光螺旋体与底部亮面被 Bloom 强化
> - 中文字幕说明还会“再调得更好一些”，对应本图展示从 Niagara 调整转向场景级后处理微调
> 图表转写（UE-GTXT v4）
> - 类型: 视口效果图 + 关卡后处理设置
> - 组成部分: 龙卷风最终基准预览 + `PostProcessVolume` 属性图 + Sequencer
> - 所属: `LS_StylizedTornado`
> - 目的: 确认经过 Bloom 加强后的龙卷风已经具备可继续扩展的基础版本，作为后续继续制作其他效果前的阶段性结果
>
> 设置:
> | Owner.Property | 值 | 类型/单位 | 来源 | 作用 |
> |---|---|---|---|---|
> | `PostProcessVolume.Location` | `(1150.0, 7750.0, 760.0)` | Vector3 | Details | 与上一张保持一致 |
> | `PostProcessVolume.Rotation` | `(0.0, 0.0, 0.0)` | Rotator | Details | 无旋转 |
> | `PostProcessVolume.Scale` | `(1.0, 1.0, 1.0)` | Vector3 | Details | 默认缩放 |
> | `Bloom.Method` | `Convolution` | enum | Details | 继续使用卷积 Bloom |
> | `Bloom.Intensity` | `20.0` | float | Details | 保持高强度发光扩散 |
> | `Bloom.Threshold` | `-1.0` | float | Details | 保持低阈值 |
> | `Bloom.Size Scale` | `1.0` | float | Details | 不改 Bloom 尺寸比例 |
>
> Sequencer:
> - 当前时间游标停在约 `5.5375`
> - `System Life Cycle` 红色条带仍覆盖该时刻，表示 Niagara 在这一段持续生效
>
> 预览结果:
> - 龙卷风主体亮度更统一，螺旋体从中段到底部都带有柔和的发光边缘，底座烟圈也被整体包进同一色调
> - 中文字幕说明“现在我们已经有了这样的龙卷风基础，接下来再继续做其他效果”，表明这一帧是本节最终基准效果

## 补充视觉证据

### S05 00:19:01

> 图表转写（UE-GTXT v4）
> - 类型: 建模视口截图
> - 组成部分: Blender 视口 + Outliner + Transform 面板
> - 所属: `SM_GroundCylinder_01`
> - 目的: 为地面龙卷风底座准备一个倒扣的圆柱/碗形静态网格，后续导入 Unreal 作为承载材质或特效的几何体
>
> 对象信息:
> - 当前只选中了一个对象 `SM_GroundCylinder_01`
> - 左上统计显示该模型约有 `396` 个顶点、`1100` 条边、`704` 个面，三角面数也为 `704`
> - 视口中的模型是一个上口朝上的碗状体，内侧显示蓝色、外侧显示红色，说明作者开启了法线朝向可视化，用来确认翻面或内外朝向
>
> Transform:
> | 属性 | 值 |
> |---|---|
> | `Location` | `X=0 m, Y=0 m, Z=0 m` |
> | `Rotation` | `X=0°, Y=0°, Z=0°` |
> | `Scale` | `X=0.010, Y=0.010, Z=0.010` |
> | `Mode` | `XYZ Euler` |
>
> 使用意图:
> - 字幕说明会把这个“反过来的”物体丢进 Unreal Engine，并且会有两个 3D 物体做同类处理
> - 因此这张补充图的关键信息是：先在 Blender 中确认网格形状和法线方向，再按当前缩放导出到 Unreal 参与地面材质/烟圈效果

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。


