# 05 Stylized Tornado

# 05 Stylized Tornado

## 关键术语

- `后处理`、`系统`、`速度`、`根据这个，我将使用..我已经创建了类似的东西`、`现在让我们仔细地涂抹所有这些细节`、`Niagara`、`颜色`、`Niagara System`、`Emitter`、`Particle`、`Spawn`、`Initialize Particle`、`Lifetime`、`Color`、`Alpha`、`Opacity`、`Renderer`、`SubUV`

## 分段知识

### 00:00:06-00:05:05 后处理

- 本段定位：后处理。
- 知识点：大家好 在这次视频中,后续会在Fotoshop中制作了闪光和雕塑 和雕塑相互相似的感觉 我已经在这里制作了一些相似的东西 但现在需要示范在这些雕塑上制作的自己的版本。
- 知识点：以产生将来的闪光和雕塑相似的感觉 在这些情况下,我们首先需要在云上制作一些照片 我们把它复制 接下来,我们去Fotoshop,创造一张照片。
- 知识点：我们先制作一张相片 它会变得两倍大 我们创造 我特别想要增加它的幅度 我觉得会更好 认为后续会使用的3D物体 我们把它放在这里 按下 Shift。
- 知识点：来调整它的大小 然后我们需要把它转为黑和白的相片 我们转成了它 现在我们需要选择这些小雕塑 我们需要选择 而这里是选择 选择这种光线 可以做到这种事情。
- 知识点：我们看看结果 Ctrl X 我真的不喜欢 所以我把它转回来 我再选择 我们看看会不会更好 我们把这个部分切掉 这是我们的雕塑 可以立刻用Blur。

**关键画面：**

展示一张黑白云层参考纹理，作为后续在 Photoshop 中制作闪光/雕塑感贴图的基础视觉来源

- 当前窗口打开的图片文件名为 `T_Clouds_02.png`
- 画面主体是一张横向铺开的黑白云层图：
  - 白色部分表现为成团的云块和较亮的边缘
  - 黑色部分形成大片空隙和深色区块
  - 中间与边缘都能看到不同尺寸的云团与涡旋形阴影
- 整体对比强烈，天然带有大块明暗分区和柔软翻卷边界，适合被二次加工成烟雾、闪光或雕塑质感遮罩
- 字幕提到 `Based on this I will use... I've already created something similar`，可结合当前画面理解为：作者不是完全凭空绘制，而是先拿现成的云层图作参考或底图，再做自己的版本
- 这一步的作用，是先确定后处理贴图的视觉基础，让后续 Photoshop 制作能够沿着“云层转雕塑/闪光”的方向展开
在 Photoshop 中通过 `Color Range` 选择高光区域，把云层图提炼成更适合后处理贴图的黑白遮罩

- 当前文档尺寸约为 `2048 x 1024`
- 画布中可见已经被强化成黑白分离效果的云层图：
  - 白色区域代表被选出的高亮云块
  - 黑色区域代表被压成背景或空隙的暗部
- 前景弹出的 `Color Range` 对话框显示：
  - `Select = Highlights`
  - `Fuzziness = 4`
  - `Range = 165`
  - `Selection Preview = Grayscale`
- 预览框中的黑白分布与主画布一致，说明作者正在用高光选择直接分离云层的亮面结构
- 右侧图层面板显示当前活动层为 `Layer 1`，下方保留锁定的 `Background`
- 这一步的目的，是先从原始云层图里抽出最有体积感的亮部轮廓，为后续做黑白雕塑感、切割、模糊和叠加提供干净的基础遮罩
在高倍放大下继续手工涂抹和整理黑白云层遮罩，把过渡细节塑造成更统一的雕塑感亮面

- 当前文档缩放约为 `200%`
- 画布中只保留黑白两类主要区域：
  - 白色块面构成被保留下来的云团亮面
  - 黑色区块构成大面积空洞和分割缝隙
- 白色边缘并非完全硬切，而是在部分位置保留灰度羽化与烟状拖尾，说明作者正在逐步控制“硬边雕塑感”和“柔和云气感”的平衡
- 左下画笔区显示当前使用柔和圆刷，`Size` 约为 `45 px`
- 右侧图层面板中可见：
  - `Layer 4`
  - 当前活动的 `Layer 3`
  - 锁定的 `Background`
- 字幕提到 `Now let's smear all these details, carefully`，可结合当前画面理解为：作者在放大后沿边缘细致抹开、切除或重塑局部云块，让所有碎细节朝同一视觉语言收敛
- 这一步的目标，是把从云层高光提取出来的原始形状进一步清理成可用的后处理贴图基础，避免云块边缘杂乱无章，方便后续继续模糊、切割和叠加

### 00:05:05-00:08:37 关键流程 02

- 本段定位：关键流程 02。
- 知识点：可能可以提高亮度 这是如何遮掩一个线 我们用柔软的刀 我们把色彩的色彩改变 我真的不喜欢这个色彩 可以把它修正 我们把这个部分切掉 把它编辑成亮面。
- 知识点：我们需要把它编辑成一点 然后从这里做出一个亮面 这就是我们的组合 现在可以把所有色彩都组合 可以分开,然后组合 现在所有色彩都很平行。
- 知识点：现在我们需要把它编辑成亮面 可以看看预测 我们看到所有色彩都很平行 我们有一个问题 需要把所有色彩都编辑成亮面 基本上 这里一切都很好。
- 知识点：这一点在耽误我们 可以复制 这个部分 编辑成亮面 降低一点 再编辑成亮面 进行一个轻松的转移 再混合,全部都一体 再选择编辑成亮面 因为我们可能有问题。
- 知识点：在这里 我们看看一点 我们操怀一下 我们没有线吗? 太好了 可以用offset。

**关键画面：**

复制并拖动一块亮云层区域去覆盖接缝，同时准备压低这块补丁的亮度，让拼接更自然

- 当前文档缩放约为 `130%`
- 画面中央上方有一个自由变换框，框内选中的亮云层片段被单独拖出，用来覆盖原图中的一条拼接线
- 主画布仍是黑底白云遮罩，能看到中央偏右存在一条较明显的垂直接缝线，而当前操作正是针对这条线做遮盖
- 右侧图层面板显示：
  - `Layer 4`
  - `Layer 3`
  - 锁定的 `Background`
- 字幕提到 `Maybe reduce the brightness. This is how to mask a seam.`，可结合当前画面理解为：复制出的补丁不能原样硬贴，需要适当降低亮度，避免因为补丁过亮反而暴露拼接痕迹
- 这一步的作用，是通过局部复制和亮度修正，把原图的明显接缝先用相似云形盖住，为后续进一步混合、抹匀和平铺做准备
使用大号软边画笔继续把补丁边缘和周围云层抹匀，让接缝区域更难被识别

- 当前文档缩放约为 `60.3%`
- 画布中央只剩一张较小的黑白云层遮罩，说明作者正在退远观察整体是否还有明显拼接痕迹
- 中央偏上的接缝位置已不再是生硬直线，而是被重新整理成顺着云层分布延伸的黑白过渡区
- 左侧画笔设置显示当前使用柔和圆刷：
  - `Size = 150 px`
  - `Hardness = 0%`
  - `Spacing = 25%`
- 当前活动层为 `Layer 4`
- 大软刷的用途不是再切割出新形状，而是把补丁和原图边缘缓慢融合，使高光团块与黑色空隙之间的过渡更连贯
- 这一步的目标，是在缩小视图后先确认整体无明显拼接线，再继续做后续的亮度、偏移和无缝处理
把处理后的补丁和原始云层区域放在同一视图里整体比对，检查接缝、亮度和层次是否已经协调

- 当前文档缩放约为 `112%`
- 画布中上下各摆放了一块黑白云层区域：
  - 上方区域更像整理后的连续云带
  - 下方区域保留了先前那块大亮云团和被修补过的局部结构
- 两块区域之间留有明显黑色间隔，说明作者是在做视觉对比，而不是简单重叠混合
- 下方亮云团顶部中间仍能看见一块较亮的修补区，表示作者正重点观察补丁是否过亮、边缘是否突兀
- 右侧图层面板显示当前活动层为 `Layer 5`，说明这是进一步整合或评估后的新对比层
- 左侧画笔仍是软边大刷，`Size` 约 `45 px`、`Hardness = 0%`，便于继续局部柔化
- 字幕提到 `Let's see how it all looks`，可结合当前画面理解为：在完成接缝遮盖后，作者退回到整体视角重新审查整个遮罩的平衡，而不是只盯住某一条线
- 这一步的目的，是确认补丁处理后的云层整体读感已经统一，后续才能放心进入 offset、平铺或进一步亮面细修

### 00:08:42-00:11:36 关键流程 03

- 本段定位：关键流程 03。
- 知识点：回到正常的情况 这里是1024 还有-512 我们已经看到了 这张照片已经非常好 已经没有线了 这里有一个小线 我们要小心 需要把pattern。
- 知识点：preview关掉 需要开始编辑线 这里应该有更多 再看看 看看有没有线 我认为所有东西都很棒 噢,我找到了另一个问题 我们要小心 我认为照片已经准备好了。
- 知识点：我们再看看 可以把这一层编辑编辑 调整 转过来,然后伸出 调整 编辑 再编辑 来加一些详细。

**关键画面：**

把云层遮罩平铺重复出来检查无缝效果，专门寻找还残留的接缝和规律性重复痕迹

- 当前文档缩放约为 `72.7%`
- 画布中同一块黑白云层图被横向与纵向重复排列成多宫格平铺预览
- 最下方有一个带变换边框的区域，说明作者正通过选区/偏移后的单块图来对照整张平铺结果
- 通过平铺后可以直接观察：
  - 云层亮块在左右边界衔接是否自然
  - 上下边界的黑白过渡是否会形成横向断线
  - 某些高亮云团是否因重复过于整齐而暴露周期感
- 右侧图层面板中当前活动层为 `Layer 5`
- 这一步对应上下文里提到的 `1024` 与 `-512` 偏移思路，目的就是把原本在边缘的接缝挪到画面中间，借由大面积平铺更容易发现还没处理干净的线和块状重复
在 Photoshop 中用 `Offset` 滤镜把贴图边界移到画面中央，继续精确暴露和检查接缝

- 前景弹出 `Offset` 对话框
- 可见关键设置：
  - `Horizontal = +563 pixels right`
  - `Vertical = +512 pixels down`
  - `Preview` 开启
  - `Undefined Areas = Wrap Around`
- `Wrap Around` 说明贴图会循环回卷，这正是检查平铺无缝时需要的模式
- 主画布中能看到原本在边缘的黑白云层分布已经被重新拼接到中央区域，使潜在接缝和亮度跳变更容易被发现
- 当前活动层仍为 `Layer 5`
- 这一步的目的，是通过精确偏移把边界问题转移到最显眼的位置，再决定是否还需要补亮、抹匀或继续复制局部云块修线
在偏移检查后继续局部补细节和压灰，让处理过的云层贴图在亮白团块之外拥有更自然的中间层次

- 当前文档缩放约为 `77.3%`
- 主画布中的云层贴图不再只有纯黑和纯白两级：
  - 大块高光云团仍保持白色
  - 云层之间新增了成片的中灰色区域
  - 黑色空隙依然保留，用于形成结构分割
- 这些中灰色块主要分布在画面中上部和中央，说明作者在 offset 暴露出问题后，并不是只抹掉接缝，而是顺势补入过渡层，减弱亮暗跳变
- 左侧画笔设置显示仍在使用软边圆刷：
  - `Size = 173 px`
  - `Hardness = 0%`
  - `Spacing = 25%`
- 右侧图层面板可见：
  - 当前活动层为 `Layer 6`
  - 下方还有 `Layer 5`
  - 锁定的 `Background`
- 这一步的目标，是把已经基本无缝的云层遮罩继续做出更丰富的灰阶层次，让它后续作为后处理或雕塑感贴图时，不会显得过于生硬或只有剪影效果

### 00:11:46-00:14:43 关键流程 04

- 本段定位：关键流程 04。
- 知识点：编辑 我们需要它有柔软的线条 加blur 雕像已经准备好了 我们把它们编辑 把照片编辑到8bit 然后编辑 我把两个线条编辑到雕像里 这是我们做的。
- 知识点：还有我之前做的另一个编辑 我们要制作一个材料 我们需要雕像 首先 我们先看看这个选项 看看它会有什么不同的编辑 首先需要改变线条 3.4 需要加一些动作。
- 知识点：为了编辑 需要选择vortinoid 和增加线条 我们改变动作 让我们再加一些轻松 这些线条可以改变 现在需要加一些编辑 需要做一个小动作。
- 知识点：需要用另一个声音 看看编辑有什么影响。

**关键画面：**

在 Photoshop 中准备给已经整理好的黑白云层雕塑遮罩施加模糊滤镜，让边缘更柔和并形成可用于材质的过渡

- 当前活动层为 `Layer 6`
- 画布中是已经做过接缝修补和灰阶过渡的黑白云层遮罩
- 顶部菜单已展开 `Filter`
  - 子菜单停留在 `Blur`
  - 可见选项包括 `Average`、`Blur`、`Blur More`、`Box Blur...`、`Gaussian Blur...`、`Lens Blur...`、`Motion Blur...`、`Radial Blur...`、`Shape Blur...`、`Smart Blur...`、`Surface Blur...`
- 左侧画笔设置显示当前仍保留软边圆刷，`Size = 300 px`、`Hardness = 0%`，说明手工柔化与滤镜柔化会配合使用
- 字幕和上下文都提到需要“柔软的线条”和 `blur`，可结合当前画面理解为：在无缝和层次已经基本就绪后，下一步重点是让云层边界从硬切蒙版过渡到更适合后处理材质的柔和形状
- 这一步的目的，是在正式进入材质/系统阶段前，先把遮罩贴图处理成既有结构又不生硬的灰度资源
在 Unreal Engine 的材质实例中接入处理后的云层贴图，作为网格风纹的新主纹理进行预览

- 当前打开的资源标签为 `MI_TornadoMeshWind...`
- 左侧预览中可见一块竖直平面上重复分布着许多白色小云团，说明新贴图已经被送入材质并作为可见主形状参与显示
- 右侧 `Base Texture` 参数组中：
  - `T_Main = T_Clouds_02`
  - `Use Colormap? = 0.0`
- `Main (Scale/Scroll)` 已启用，当前参数可见：
  - `R = 3.0`
  - `G = 4.0`
  - `B = 0.0`
  - `A = 0.0001`
- `Dissolve` 组中：
  - `T_Dissolve = T_Voronise007`
  - `Dissolve (Scale/Scroll)` 的可见值为 `R = 1.0`、`G = 1.0`、`B = 1.5`、`A = 0.0`
  - `Smoothness = 1.0`
- `Distortion` 组仍挂接 `T_Distortion = T_Voronise002`
- `Global Scalar Parameter Values` 中可见 `Depth Fade = 100.0`
- 这一步的目的，是把 Photoshop 里制作好的黑白云层雕塑贴图真正投到材质实例中，检查它在网格上的密度、重复节奏和被溶解/失真后是否适合作为新的风纹层
继续在材质实例里强化云团漂浮感，重新调整溶解和失真纹理，使云层从平面贴图更接近可用的体积风纹效果

- 当前仍在 `MI_TornadoMeshWind...` 材质实例中预览
- 左侧预览面板里的白色云团已明显更分散、更轻盈，排列成多层漂浮片状结构，说明参数调整正朝“悬浮云雾/雕塑风纹”方向推进
- `T_Main` 仍使用 `T_Clouds_02`
- `Dissolve` 组中可见新的关键设置：
  - `T_Dissolve = T_Voronise005`
  - `Dissolve (Scale/Scroll)` 为 `R = 5.0`、`G = 5.0`、`B = 0.0`、`A = 0.0`
  - `Smoothness = 2.0`
- `Distortion` 组中可见：
  - `Distortion (Scale/Scroll)` 为 `R = 2.0`、`G = 1.0`、`B = -0.01`、`A = -0.02`
  - `Distortion Influence = 0.001`
  - `T_Distortion = T_Noise_6`
- `Global Scalar Parameter Values` 里 `Depth Fade = 100.0` 仍保留
- 这一步的目的，是让原本偏平的云层贴图在材质里通过更强的溶解噪声和更细的失真扰动，变成适合后续 Niagara 系统使用的分层漂浮云片效果

### 00:14:52-00:17:44 系统、颜色

- 本段定位：系统、颜色。
- 知识点：需要展示可以用一个已经制作的3D物件 这是这个桥 需要把它转过来 再提升15次 再调整到Z 然后需要用这个材料给它 我们需要再加一个线条。
- 知识点：两个编辑都必须有关 这是它 改变线条在Z的角度 需要做一个面具 这样才能让轻松的转折 我们选择了一些编辑 让它是这个 上面会有更亮的颜色。
- 知识点：它们会慢慢地下降 可以加更多动作 为了我们的规模 你看它像雕像 我把它放在中间 因为镜头在这里 可以把雕像放在不同的位置 例如,增长在大小。
- 知识点：我展示了主要的理念 这个数字在这里有点差 但需要展示一下这个理念 现在它像雕像一样 让我删除这个3D物件 并在一个组成的系统里删除 我们继续。
- 知识点：这是一个3D物件 立即改变线条 需要重新编辑 需要开始用一个组成的物件。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`系统`、`颜色`。

**关键画面：**

回到关卡场景中，准备用现成 3D 网格承载新做的云层材质，演示“雕塑感”体积物件的基本思路

- 视口中央仍是龙卷风主效果和底部地面风纹层
- 底部内容浏览器当前定位到 `Content / VFX_Library / Meshes`
- 可见的候选静态网格包括：
  - `SM_Circle_01`
  - `SM_Cone_01`
  - `SM_Cylinder_01`
  - `SM_CylinderBowl_01`
  - `SM_CylinderHeight_01`
  - `SM_CylinderHeightHighPoly`
  - `SM_CylinderTwist_01`
  - `SM_GroundCylinder_01`
  - `SM_GroundCylinder_01_`
  - `SM_Ring_01`
  - `SM_Ring_01_Inverted`
  - `SM_TorusHighPoly_01`
- 顶部标签同时打开了 `T_Clouds_02`、`T_Clouds_01` 与 `MI_TornadoMeshWind...`，说明当前工作正在把新云层贴图和材质思路带回实际 3D 载体
- 字幕与上下文说明“需要展示可以用一个已经制作的 3D 物件”，可结合当前画面理解为：此时不再只看平面预览，而要把材质应用到真实网格上验证雕塑感的三维表现
在 `MI_TornadoMeshWind...` 材质实例中继续加入渐变贴图，用它控制云层雕塑材质的额外过渡和层次

- 左侧预览中，一块竖直平面上分布着许多白色小云团，说明云层贴图仍以重复网格形式被查看
- 右侧参数面板当前停留在材质实例较下方区域，可见：
  - `Distortion Influence = 0.01`
  - `T_Distortion = T_Noise_6`
  - `Depth Fade = 100.0`
  - `T_Mask = WhiteSquareTexture`
- `Material Property Overrides` 中至少可见：
  - `Blend Mode = Translucent`
  - `Shading Model = Unlit`
  - `Two Sided` 已启用
- 当前打开了一个资源选择下拉框，搜索词为 `gradient`
- 下方候选列表里可见多张渐变纹理，例如：
  - `T_Gradient17`
  - `T_Gradient19`
  - `T_Gradient20`
- 字幕提到 `Here we choose some gradient, let it be this one`，可结合当前画面理解为：作者正在为这套云层材质补入一张渐变贴图，用来进一步塑造上下消隐、亮度过渡或局部遮罩变化
- 这一步的目的，是让云层雕塑材质不只依赖主贴图和噪声，而增加一层可控的渐变分布，方便后续在系统中表现“上亮下淡”或沿高度衰减的效果
把新云层材质思路放回 `NS_Tornado` 系统总览中，检查它与现有地面风纹、烟雾和火花模块的组合关系

- 当前界面为 `NS_Tornado` 的 System Overview
- 上方可见系统里的主要模块/发射器列：
  - `TornadoMain`
  - `TornadoGlow`
  - `TornadoDark`
  - `TornadoWinds`
  - `TornadoGround`
  - `TornadoGround001`
  - `GroundWinds`
- 下方还能看到辅助模块：
  - `Smoke_Far`
  - `Smoke_Vortex`
  - `Sparks_Vortex`
- 时间线当前播放头约在 `3.5876` 秒位置
- 左侧预览窗口中，龙卷风主体仍维持青色旋涡形态，底部带有地面风纹层，说明新材质和新模块的尝试并没有脱离整套系统，而是在现有系统结构里逐步插入
- 底部时间线里多个绿色条块同时展开，表示这些模块在同一时间段共同参与最终效果
- 这一步的目的，是在系统级视角下确认“云层雕塑材质”的新想法应该挂到哪一类发射器或层次中，并确保它能与地面风、远处烟雾、旋涡烟和火花模块协同工作

### 00:17:56-00:20:55 关键流程 06

- 本段定位：关键流程 06。
- 知识点：我们选择了这个3D物件 然后是材料 让我们增长它的大小 例如,25倍 怎么可能 这很有趣 需要编绕3个物件 它们会编绕在一个随机的位置 把这个3D物件适当翻过来。
- 知识点：需要改变线条 现在它正在下降 现在需要随机地在这里 在Z组成的位置从0到1 需要编绕3个物件 在随机的位置 为了增加一些综合性 需要把这个物件的重量加到一些。
- 知识点：我们需要它们在上面 为了增加一些综合性 需要把它们移到一个随机的位置 从1800到2000 现在我们看看它们是怎么看的 如果它们是同一个高度。
- 知识点：那是不好的 所以需要它们移到一个随机的高度 为了让它们有些综合性 我们需要改变色彩和生命时间 约11秒 它们会比火炉更长 可以这样做。
- 知识点：可能会更黑 可以怎么做 这是一个随机的大小 需要把随机的综合性 调到加综合性 15 15 15。

**关键画面：**

这一帧在 Unreal Engine 的材质实例 `MI_TornadoMeshWind...` 中检查龙卷风网格材质的主要贴图与滚动参数，左侧视口里能看到一层贴地的浅色扭曲片状效果，说明作者正一边调实例参数一边观察场景中的实际表现

可确认的材质槽与参数如下

- `Base Texture`：
  - `colormap` 贴图为 `VFX.T_ColorMap_Blue_06`
  - `Main (Scale/Scroll)` 当前可见数值为 `R=3.0`、`G=4.0`、`B=0.0`、`A=0.129`
  - `T_Main` 贴图为 `T_Clouds_02`
- `Dissolve`：
  - `T_Dissolve` 贴图为 `T_VoronoiSet005`
  - `Dissolve (Scale/Scroll)` 当前可见数值为 `R=5.0`、`G=5.0`、`B=0.0`、`A=0.0`
  - `Smoothness=2.0`
- `Distortion`：
  - `Distortion (Scale/Scroll)` 当前可见数值为 `R=2.0`、`G=1.0`、`B=-0.01`、`A=-0.02`
  - `Distortion Influence=0.01`
  - `T_Distortion` 贴图为 `T_Noise_6_V`
- `Mask`：
  - `T_Mask` 贴图为 `T_Gradient17`

这一图传达的操作重点是：把前面做好的云纹理 `T_Clouds_02` 接回龙卷风网格材质实例，再配合溶解噪声、扭曲噪声和渐变遮罩一起观察实际显示效果，确认龙卷风底部片层在场景里已经开始出现云状细节与扭曲过渡
这一帧回到 Niagara System `NS_Tornado`，作者新建并选中了一个名为 `Empty` 的发射器，用来补充龙卷风底部外围的片层体积。左侧预览里可以看到几张半透明环状网格围绕中心竖向主体展开，字幕也明确说明当前目的为“为了增加体积，我们将它们移动到随机距离”

可确认的发射器结构如下

- 发射器：`Empty`
- `Emitter State`：可见为 `Self`、`Once`
- `Spawn Burst Instantaneous`：
  - `Spawn Count = 3`
  - `Spawn Time = 0.0`
  - `Loop Count Limit = 1`
- `Particle Spawn`：
  - `Initialize Particle`
  - `Initial Mesh Orientation Vector`
- `Render`：
  - `Mesh Renderer`

时间线中能看到该系统与现有多个发射器并列工作，至少包含 `GroundWinds`、`Smoke_Far`、`Smoke_Vortex` 等条目，而当前 `Empty` 发射器被放在最上方单独调整。结合字幕与预览效果，这一步的核心是先用一次性生成的 3 个网格粒子搭出外围体积，再在后续步骤里通过随机距离、朝向或尺寸控制让这些片层不要全部挤在中心
这一帧继续编辑 `NS_Tornado` 中的 `Empty` 发射器，并把右侧详情面板切到 `Initialize Particle`，用于给那 3 个网格粒子设置生成高度、寿命、颜色和网格尺寸。左侧主视口已经能看到龙卷风底部外围出现更明显的蓝绿色片层，说明这些附加网格已经被放到主体四周参与显示

当前图中可确认的 `Initialize Particle` 设置如下

- `Lifetime Mode = Direct Set`
- `Lifetime = 11.0`
- `Color Mode = Direct Set`
- `Color` 为浅青蓝色
- `Position Mode = Simulation Position`
- `Position` 使用 `Random Range Vector`
  - `Minimum = (0.0, 0.0, 1800.0)`
  - `Maximum = (0.0, 0.0, 2000.0)`
- `Position Offset Mode = Simulation`
- `Mass Mode = Unset / (Mass of 1)`
- `Mesh Attributes`：
  - `Mesh Scale Mode = Uniform`
  - `Mesh Uniform Scale = 25.0`
  - `Mesh Renderer = Unset`

从这张图可以明确看出作者给 `Empty` 发射器的 3 个网格粒子限制了固定的 XY 中心位置，只在 Z 方向 `1800-2000` 范围内随机分布。这样做的目的，是让额外的云片集中出现在龙卷风中上段的环形区域，再配合统一的浅蓝色和较大的网格缩放值 `25.0`，把外围体积层先堆出来，避免粒子散落到地面或偏离主体

### 00:20:58-00:23:42 关键流程 07

- 本段定位：关键流程 07。
- 知识点：我记错了 这里可以增加 20 25 反过来 可能反过来 我还会增加大小 可能这里也增加到18 20 这些数字可以改变 已经有很多有趣的雕像了 可以加一个。
- 知识点：Z 综合性的转向 这里没有视觉 因为它必须在随机里 应该有一个阻力 它太强了 看起来很酷 一切都像一场烂炸 而且雕像会转向 所以我们也选择选择。
- 知识点：我们有三个雕像 会有一个选择的转向 这是数字 需要适当移到旁边 我们需要加强 它们仍然有趣 可以加一个 D 综合性的转向 我们加一个强度。
- 知识点：它会升起来 首先会有一个烂炸 然后它会用烂炸来烧毁 然后在最后 它会消失的同样 我们把它转过来 它有10秒 但我们增加到12秒。

**关键画面：**

这一帧继续编辑 `NS_Tornado` 中 `Empty` 发射器的 `Initialize Particle`，重点从上一段的固定高度随机，推进到外围云片的尺寸随机化。左侧主视口里能看到龙卷风中上段出现多层发亮的蓝绿色片状结构，说明这些附加网格已经开始形成更明显的体积层次

当前图中可确认的初始化参数如下

- `Lifetime Mode = Direct Set`
- `Lifetime = 11.0`
- `Color Mode = Direct Set`
- `Color` 为浅青蓝色
- `Position Mode = Simulation Position`
- `Position Offset` 使用 `Random Range Vector`
  - `Minimum = (0.0, 0.0, 1800.0)`
  - `Maximum = (0.0, 0.0, 2000.0)`
- `Position Offset Coordinate Space = Simulation`
- `Mass Mode = Unset / (Mass of 1)`
- `Mesh Attributes`
  - `Mesh Scale Mode = Random Non-Uniform`
  - `Mesh Scale Min = (15.0, 15.0, 13.0)`
  - `Mesh Scale Max = (18.0, 18.0, 25.0)`
  - `Mesh Renderer Array Visibility Mode = Unset`

这一图表达的关键调整是：作者不再让所有外围网格用统一尺寸，而是把 `Mesh Scale` 改为非统一随机缩放，并且让 Z 方向的伸展范围明显大于上一段的固定值。这样生成出来的 3 个附加网格会在高度相近的前提下拥有不同长宽厚度，从而让龙卷风外围体积不再像完全重复的同一片网格
这一帧继续在 `NS_Tornado` 的 `Empty` 发射器中补充旋转控制。字幕明确说明“我们有三朵云，我们会有一个随机旋转”，右侧详情面板显示作者正在编辑 `Update Mesh Orientation` 模块，让这 3 个外围云片在持续更新阶段拥有旋转速率，而不是静止地贴在同一朝向

当前图中可确认的模块与参数如下

- 模块：`Update Mesh Orientation`
- `Orientation Method = Rotation Rate`
- `Rotation Vector = (0.0, 0.0, 1.0)`
- `Rotation Rate = 1.0`
- `Rotation Coordinate Space = Mesh`

从这些可见设置可以判断，这一步是沿网格自身的 Z 轴持续旋转外围云片。配合上一图已经做好的非统一随机缩放，三片云在同一高度带里会以不同外形加上持续转动的方式围绕龙卷风主体变化，从而减少静态复制感，让体积层更像被卷入风场中的漂浮碎云
这一帧继续在 `Empty` 发射器里补充材质动态参数控制，作者打开的是 `Dynamic Material Parameters` 模块，用一条随生命周期变化的浮点曲线去驱动材质里的 `Dissolve`。左侧预览中能看到外围云片已经以较大尺寸挂在龙卷风侧面，这说明当前不是再调几何位置，而是在控制这些网格片从出现到消失时的溶解节奏

当前图中可确认的设置如下

- 模块：`Dynamic Material Parameters`
- 选中的参数页：`All`
- `Dynamic Parameter Index 0`
  - `Write Parameter Index 0` 已启用
  - 参数名为 `Dissolve`
  - 写入方式为 `Float from Curve`
  - `FloatCurve = Curve for Floats`
  - `CurveIndex = PARTICLES.NormalizedAge`
  - `Scale Curve = 1.0`
  - `Param1-0 = 0.0`
  - `Param2-0 = 0.0`
  - `Param3-0 = 0.0`
- 曲线形状可见为：
  - 起点接近 `0`
  - 前段迅速下降到较低值
  - 中段长时间保持低位近水平
  - 末段再抬升回接近 `1`

这一步的作用是把外围三片云的溶解参数绑定到粒子归一化生命周期。按图中的曲线趋势，它们会在生成后较快进入更明显的可见状态，在生命周期中段维持一段稳定外观，接近结束时再回到高溶解值并逐渐消失。这样可以让这些附加体积片先爆开出现、停留片刻，再自然退场，而不是整段时间都以同一可见度硬性悬挂在龙卷风周围

### 00:23:57-00:26:55 颜色

- 本段定位：颜色。
- 知识点：它会消失 需要改变镜头 我们把它放下 我们还要看它会怎么样 还蛮好 可能比较近烂炸 我们把镜头移动 可以在本体上 加强更多的综合性 我们去尼亚哥。
- 知识点：这是我们的第一个雕像 然后我们再加强其他综合性 可能需要更改色彩 更加更暗 就这样 可以适当调整尺寸 它会在后面展示 也许是更加有透明性。
- 知识点：在这里 可以加强一个材料 名字必须改变 我们再加一张新的位置 然后我们再加一张新的位置 然后我们再转移它 这里 颜色有点不一样。
- 知识点：最后一张 它会是0.2 需要改变名字 我把它写在这里。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这一帧处于关卡视口与 Sequencer 联动预览阶段，作者暂时不再打开 Niagara 参数面板，而是把镜头停在龙卷风场景中较暗的一段位置，直接观察刚才新增的外围云片在时间线上播放后的可见效果。字幕“Let’s drop. We still have to see what it will look like”也说明当前动作是先把镜头和播放位置放下来，再检查整体外观

当前图中可确认的信息如下

- 主界面为 Unreal 关卡视口，场景名可见为 `LS_StylizedTornado`
- 右侧 `Outliner` 中可见：
  - `CameraAct`
  - `LS_Stylized...`
  - `NS_Tornado`
- 下方 `Sequencer` 正在预览：
  - `CameraActor`
  - `NS_Tornado`
  - `NiagaraComponent0`
  - `System Life Cycle`
- `System Life Cycle` 轨道使用 `Desired Age`
- 当前时间指针位于约 `9.8333` 秒

从画面结果来看，这一步不是继续创建新模块，而是在已有参数基础上查看龙卷风主体与外围附加云片是否在镜头里显得过暗、过淡或过于贴近地面。它为后续“颜色”段的材质与透明度调整提供视觉参照
这一帧切回 Niagara System，并选中了名为 `Clouds_01001` 的发射器。右侧仍在 `Initialize Particle` 模块里调基础属性，但这次重点已经转向颜色与尺寸微调，以便让其中一片外围云和前一组云片形成不同的亮度与体积感

当前图中可确认的设置如下

- 发射器：`Clouds_01001`
- `Initialize Particle`
  - `Lifetime Mode = Direct Set`
  - `Lifetime = 11.0`
  - `Color Mode = Direct Set`
  - `Color` 为较暗的青绿色
  - `Position Mode = Simulation Position`
- `Mesh Attributes`
  - `Mesh Scale Mode = Random Non-Uniform`
  - `Mesh Scale Min = (20.0, 18.0, 18.0)`
  - `Mesh Scale Max = (25.0, 25.0, 20.0)`
  - `Mesh Renderer Array Visibility Mode = Unset`

图中还打开了 `Position Mode` 的提示面板，说明作者正在确认该发射器仍以模拟空间位置初始化，然后在同一发射器内继续调颜色和网格比例。和上一组更亮、更拉长的外围云相比，这一组参数把尺寸重心改得更偏宽厚，同时把颜色压暗，用来打破三片云完全同色同形的重复感
这一帧回到关卡视口直接查看颜色调整后的整体效果。字幕说明“云彩有些不同”，画面中龙卷风底部周围的几片附加云已经明显不是同一亮度和同一青色强度，说明作者前面针对不同发射器或不同材质实例所做的颜色区分已经开始在场景里生效

当前图中可确认的信息如下

- 关卡中选中对象为 `NS_Tornado`
- 顶部已打开多个相关资源标签：
  - `NS_Tornado`
  - `T_Clouds_02`
  - `T_Clouds_01`
  - `MI_TornadoClouds_01`
  - `MI_TornadoClouds_02`
- 下方内容浏览器位于 `Content / VFX_Library / Materials / Instances / Tornado`
- 可见至少存在两套云材质实例资源：
  - `MI_TornadoClouds_01`
  - `MI_TornadoClouds_02`

这张图传达的重点不是具体数值，而是结果验证：作者通过为不同云片使用不同的材质实例或不同的颜色参数，让龙卷风底部外围的附加云在亮度、色调和存在感上不再完全一致。这样做能避免三片云看起来像同一张贴图的复制品，使外围体积层更自然，也更容易在后续继续单独微调某一片云的透明度或颜色

### 00:26:59-00:29:55 颜色

- 本段定位：颜色。
- 知识点：需要把它加强 它会比较小 它会是一块 它会是最高 可以在这里改变 我们看看它怎么样 很难看 因为颜色很暗。
- 知识点：应该会比较明亮 它会是一个明亮的颜色 可以放7 它会在所有东西上展示 更加专门在这两个地方 -1 需要有-1 0 它会是-2 可以去到-资格。
- 知识点：这是-3 亮度应该提升 再调整 一点点 太多了 我看到面膜有问题 这是通过MIP模式 可以做什么 我们来看看这个面膜 问题在哪里 这些颜色的最后一张。
- 知识点：它会是最高 可以做的几个选项 首先 像这个。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这一帧在 Niagara System `NS_Tornado` 中新增并选中了一个名为 `Clouds_Glow` 的发射器，用来制作更亮、更发光的一层附加云。字幕明确说明“我将使它具有可加性，它们的尺寸将更小”，因此这一段的核心目标是做一组体积更小、混合效果更亮的补充云层，而不是继续沿用前面较暗的大块外围云

当前图中可确认的信息如下

- 当前系统内可见并列发射器至少包括：
  - `Clouds_01`
  - `Clouds_02`
  - `Clouds_Glow`
  - `GroundWinds`
  - `Smoke_Far`
  - `Smoke_Vortex`
  - `Sparks_Vortex`
- 选中的发射器为 `Clouds_Glow`
- `Clouds_Glow` 的模块结构与前面外围云发射器相近，包含：
  - `Emitter State`
  - `Spawn Burst Instantaneous`
  - `Initialize Particle`
  - `Initial Mesh Orientation`
  - `Update Mesh Orientation`
  - `Dynamic Material Parameters`
  - `Mesh Renderer`
- 右侧详情面板可见：
  - `Sim Target = CPUSim`
  - `Calculate Bounds Mode = Dynamic`
  - `Emitter State` 处于 `Life Cycle` 页面
  - `Loop Duration = 1.0`
  - `Spawn Burst Instantaneous` 中 `Spawn Count = 3`
  - `Spawn Time = 0.0`
  - `Loop Count Limit = 1`

这一步的意义是先复制出一套和前面云片结构相似的发射器骨架，然后基于它把材质混合方式与尺寸往“更亮、更小、更像高光碎云”的方向调整，为龙卷风外围增加一层有发光感的细碎云片
这一帧回到关卡视口与 Sequencer，直接观察 `Clouds_Glow` 加入后的场景结果。龙卷风底部周围的几片附加云明显更亮，中心柱体附近也出现了更突出的浅蓝色高光云带，说明作者正在一边播放时间线，一边检查这层加亮云片是否已经把“发光感”带出来

当前图中可确认的信息如下

- 选中对象仍为 `NS_Tornado`
- Sequencer 里正在预览：
  - `CameraActor`
  - `NS_Tornado`
  - `NiagaraComponent0`
  - `System Life Cycle`
- `System Life Cycle` 使用 `Desired Age`
- 当前时间指针约为 `3.70` 秒
- 字幕明确给出一个数值调整线索：`0. It will be minus 2`

由于这一帧没有展开具体参数面板，无法直接确认这个 `-2` 对应的是哪一个材质或发射器字段，因此这里只能可靠记录其结果导向：作者正在把某个与亮度、偏移或颜色相关的值往负方向压低，并立即回到场景里观察龙卷风外围发光云片的整体对比度是否更自然。就当前画面而言，这一层 `Clouds_Glow` 已经比前面的普通云片更亮、更集中于主体周围
这一帧继续检查 `Clouds_Glow` 发射器，但已经定位到 `Mesh Renderer` 的具体渲染设置。字幕“这里有什么问题”说明作者正在排查这层发光云的显示异常，而右侧面板已经给出最直接的证据：它使用了单独的云材质实例，并且手动设置了渲染排序值

当前图中可确认的 `Mesh Renderer` 设置如下

- 发射器：`Clouds_Glow`
- 当前粒子数：`1 Particles`
- `Mesh Renderer`
  - `Meshes` 只有 `1 Array element`
  - `Index [0]` 网格为 `SM_CylinderBowl_01`
  - `Enable Material Overrides` 已启用
  - `Override Materials` 只有 `1 Array element`
  - `Index [0] -> Explicit Mat = MI_TornadoClouds_03`
  - `User Param Binding = None`
  - `Source Mode = Particles`
  - `Facing Mode = Default`
- `Visibility`
  - `Renderer Visibility = 0`
- `Rendering`
  - `Cast Shadows` 已启用
  - `Sort Order Hint = -2`
  - `Motion Vector Setting = Auto Detect`

结合上一张字幕里提到的 `minus 2`，这里可以可靠确认作者把问题追到了 `Clouds_Glow` 的渲染排序，并把 `Sort Order Hint` 设为 `-2`。同时这层发光云明确使用 `MI_TornadoClouds_03` 材质实例和 `SM_CylinderBowl_01` 网格。也就是说，本段最后一步是在检查发光云是否因为材质覆盖或排序层级而与其它云片发生遮挡、混合或显示先后异常

### 00:30:00-00:32:50 颜色

- 本段定位：颜色。
- 知识点：现在它不会是 最简单的选项 它开始重新开始 最后一张就会变圆 可能会有这种问题 我做了一个很快的解决 你还是可以尝试把它运行 可以提升它大小。
- 知识点：可能会比其他更快 我们还是会调整它 我喜欢这个 主要是颜色和亮度 和大小 可以提升它 并提升亮度 说明结果 我认为我可以加更多的烟。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这一帧打开了纹理资源 `T_Gradient17`，说明作者已经把前一段怀疑的显示问题追到了用作遮罩或渐变控制的贴图本身，而不是继续只在 Niagara 发射器里调数值。左侧预览能看到一张从上黑到下白的纵向渐变贴图，右侧则是该贴图的导入与压缩设置

当前图中可确认的贴图与设置如下

- 资源：`T_Gradient17`
- 预览：
  - 一张自上而下由黑过渡到白的垂直渐变
  - 当前缩放显示约为 `336%`
- 基本信息：
  - `Imported = 512x512`
  - `Displayed = 512x512`
  - `Max In-Game = 512x512`
  - `Resource Size = 171 KB`
  - `Has Alpha Channel = False`
  - `Format = DXT1`
  - `Number of Mips = 10`
- 纹理设置：
  - `Padding and Resizing = None`
  - `Availability = GPU`
  - `sRGB` 已启用
- 高级设置：
  - `X-axis Tiling Method = Clamp`
  - `Y-axis Tiling Method = Clamp`
  - `Filter = Default (from Texture Group)`
  - `Mip Load Options = Default`
- `Adjustments` 当前可见值：
  - `Brightness = 1.0`
  - `Brightness Curve = 1.0`
  - `Vibrance = 0.0`
  - `Saturation = 1.0`
  - `RGBCurve = 1.0`
  - `Hue = 0.0`
  - `Min Alpha = 0.0`
  - `Max Alpha = 1.0`

这一图传达的重点是：作者在检查云片遮罩所依赖的渐变贴图是否因为 Mip、Clamp、sRGB 或亮度设置而造成边缘过渡不理想。由于这张图只展示贴图资源与其导入参数，能可靠确认的结论是本段已经进入“从源贴图排查显示问题”的阶段
这一帧切回材质实例 `MI_TornadoClouds_03`，作者一边在球面预览上观察云片图案，一边核对遮罩、溶解和扭曲相关参数。左侧预览里已经能看到一块横向分布的小型云纹区域，说明 `Clouds_Glow` 使用的材质实例正在被压到更小、更亮的显示结果

当前图中可确认的材质实例设置如下

- 材质实例：`MI_TornadoClouds_03`
- `Base Texture`
  - `colormap = VFX_T_ColorMap_Blue_06`
  - `Main (Scale/Scroll)`：
    - `R = 3.0`
    - `G = 4.0`
    - `B = 0.0`
    - `A = 0.129`
  - `T_Main = T_Clouds_02`
- `Dissolve`
  - `T_Dissolve = T_VoronoiSet005`
  - `Dissolve (Scale/Scroll)`：
    - `R = 5.0`
    - `G = 5.0`
    - `B = 0.0`
    - `A = 0.0`
  - `Smoothness = 2.0`
- `Distortion`
  - `Distortion (Scale/Scroll)`：
    - `R = 2.0`
    - `G = 1.0`
    - `B = -0.01`
    - `A = -0.02`
  - `Distortion Influence = 0.01`
  - `T_Distortion = T_Noise_6_V`
- `Mask`
  - `T_Mask = T_Gradient17`

这张图把上一张排查出的渐变贴图问题重新落回到了实际材质实例上。可以确认 `T_Gradient17` 已经作为 `Mask` 接入 `MI_TornadoClouds_03`，也就是 `Clouds_Glow` 这一层云片的上下裁切、淡出或纵向过渡正在直接受这张渐变贴图影响
这一帧再次回到关卡视口与 Sequencer，直接检查 `Clouds_Glow` 经材质和渐变贴图调整后的实际效果。画面里龙卷风底部周围的几片发光云已经比前几段更亮、更清晰，中心柱体中部也有更明显的高光卷带，说明作者正在用时间线预览来确认“亮度更高、尺寸更小”的这层云片是否已经成立

当前图中可确认的信息如下

- 选中对象仍为 `NS_Tornado`
- Sequencer 当前可见轨道包括：
  - `CameraActor`
  - `NS_Tornado`
  - `NiagaraComponent0`
  - `System Life Cycle`
- `System Life Cycle` 使用 `Desired Age`
- 当前时间指针约为 `3.3667` 秒

这一图传达的是结果判断而不是新参数：在 `T_Gradient17` 接入 `MI_TornadoClouds_03` 之后，`Clouds_Glow` 这层附加云在场景里已经形成了更小、更亮的发光碎云效果，并且与主龙卷风柱体的高光带衔接得更自然。结合本段上下文，作者此时主要是在确认颜色、亮度和尺寸三者的平衡是否足以支撑继续往系统中加入更多烟雾层

### 00:32:59-00:35:57 速度、颜色

- 本段定位：速度、颜色。
- 知识点：或者是灰灰 接近边界 现在我们看看它怎么样 首先,需要改变颜色的主要 第二,提升边界的线条 约500 还很难看到 我们再提升一点 我们必须提升10。
- 知识点：现在它明显显示在上面 可能需要提升它大小 我们再把它降低一点 50 我们再看看 需要提升速度。
- 知识点：但要在前面 让它从中间 它们会从边界散开 我们再提升500 然后再提升中间 如果我们再提升它 它们会飞起来,这不是好事 我们再提升-50 可以提升轻松。
- 知识点：有一个问题 它们在后面显示 因为它们在前面显示 可以提升它很快 现在需要展示 我们看看 我把部分切成这样 只有这部分显示 我把项目向我们转向。
- 知识点：以此为主要的方式 可以说 它是为了这种一个不游戏效果 一半被切除了 我还可以把这一半切成这样 我们把项目向我们转向。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`速度`、`颜色`。

**关键画面：**

这一帧转到烟雾层的速度调整，作者在 `NS_Tornado` 中选中了 `Smoke_Vortex001` 发射器，并直接编辑 `Add Velocity` 模块。结合本段标题“速度、颜色”，这里的重点已经从前几段的云材质切换到烟雾粒子的上升速度和扩散表现

当前图中可确认的信息如下

- 当前系统中可见并列发射器至少包括：
  - `Smoke_Far`
  - `Smoke_Vortex`
  - `Smoke_Vortex001`
  - `Sparks_Vortex`
- 选中的发射器为 `Smoke_Vortex001`
- `Smoke_Vortex001` 的可见模块结构包括：
  - `Emitter State`
  - `Spawn Rate`
  - `Initialize Particle`
  - `Sub UVAnimation`
  - `Add Velocity`
  - `Shape Location Ring / Disc`
  - `Particle State`
  - `Sprite Rotation Rate`
  - `Scale Color`
  - `Solve Forces and Velocity`
  - `Sprite Renderer`
- `Add Velocity` 模块当前可见设置：
  - `Velocity Mode = Linear`
  - `Velocity` 使用 `Random Range Vector`
  - `Minimum = (0.0, 0.0, 500.0)`
  - `Maximum = (0.0, 0.0, 1000.0)`
  - `Velocity Speed Scale = 1.0`
  - `Rotation Mode = Default`
  - `Rotation Coordinate Space = Local`

这一步明确是在给烟雾粒子一个沿本地 Z 轴向上的随机初速度范围 `500-1000`。这样可以让烟雾从龙卷风外围更快地抬升，同时避免所有粒子用完全相同的上升速率，形成更自然的高低差和卷吸感
这一帧切换到 `Smoke_AroundGroundWind` 发射器，并在 `Initialize Particle` 中调整地面环风附近那层烟雾的基础属性。字幕“再看一遍”说明作者是在改完一组参数后重新检查结果，因此这一图主要用于细调寿命、颜色、贴地偏移和粒子尺寸

当前图中可确认的设置如下

- 发射器：`Smoke_AroundGroundWind`
- 当前粒子数：`224 Particles`
- `Initialize Particle`
  - `Lifetime Mode = Random`
  - `Lifetime Min = 1.5`
  - `Lifetime Max = 3.0`
  - `Color Mode = Random Range`
  - `Color Minimum` 与 `Color Maximum` 都是青蓝色系，最大值更亮
  - `Color Channel Mode = Link RGB / Link A`
  - `Position Mode = Simulation Position`
  - `Position Offset = (0.0, 0.0, -50.0)`
  - `Position Offset Coordinate Space = Simulation`
  - `Mass Mode = Unset / (Mass of 1)`
- `Sprite Attributes`
  - `Sprite Size Mode = Random Uniform`
  - `Uniform Sprite Size Min = 400.0`
  - `Uniform Sprite Size Max = 600.0`
  - `Sprite Rotation Mode = Unset`
  - `Sprite UV Mode = Unset`

这一步的意图很明确：让地面环风烟雾在较短寿命内随机出现，并通过 `-50` 的 Z 偏移把烟雾整体稍微压低到更贴近地面的位置，再配合 `400-600` 的随机精灵尺寸，形成一圈大小不完全一致的近地烟雾层
这一帧继续编辑 `Smoke_AroundGroundWind`，但焦点从粒子初始化转到了 `Shape Location`。字幕提到“我仍然可以扭动这一半”，说明作者正在把地面烟雾的环形发射区域裁成局部扇区，而不是完整一圈都平均发烟，以便让烟雾更集中地出现在镜头前方或指定方向

当前图中可确认的 `Shape Location` 设置如下

- 发射器：`Smoke_AroundGroundWind`
- 当前粒子数：`223 Particles`
- 模块：`Shape Location`
- `Shape Primitive = Ring / Disc`
- `Ring / Disc Mode = Circle`
- `Ring Radius = 600.0`
- `Ring / Disc Distribution Mode = Random`
- `Disc Coverage = 0.0`
- `U Distribution = 0.5`
- `Transform`
  - `Transform Order = Scale / Rotate / Offset`
  - `Scale Mode = Default`
  - `Non Uniform Scale = (1.0, 1.0, 1.0)`
  - `Rotation Mode = Default`
  - `Rotation Coordinate Space = Local`
  - `Offset Mode = None`
  - `Shape Origin = STACKCONTEXT Position`

这一步的核心是通过环形位置分布来限制烟雾出现的位置范围。`Ring Radius = 600` 给出地面烟雾围绕龙卷风中心扩散的大致半径，而 `U Distribution = 0.5` 则表明作者没有让整圈均匀发射，而是保留其中一半区域，便于把烟雾更多地摆到镜头需要的方向，减少背面无效烟雾和前后遮挡问题

### 00:36:01-00:38:54 速度

- 本段定位：速度。
- 知识点：这是如何调整 是的,这必须的 这25,看看现在是如何看起来 从观众观看的角度 镜头,这是这种应用 是的,我们把它这样 可能需要提升速度。
- 知识点：或者选择选择300 这是这种 这里面 风格会是这种 目标是它们不会飞走 它们不想要 有些原因 不足以阻止 镜头太快了 现在它们 当然会飞很高。
- 知识点：需要把它们降低 所以它们不会飞这样 我们知道了 现在它们会飞向旁边 是同样的250 我们把镜头拿起来 我们看看 它们全部看起来 是2 很多人都很可能知道。
- 知识点：50多,这是什么样的增长 这里 数量 这是这种 我们没有看到任何人 在这里 看起来不像是 更有趣 可能再改变它 一点速度 200,300 加速转过1000。
- 核对对象：`速度`。

**关键画面：**

这一帧继续编辑 `Smoke_AroundGroundWind` 的 `Shape Location`，但重点已经从上一段的“保留半圈发射区域”推进到“把这半圈旋转到镜头需要的方向”。左侧预览里能看到一团偏蓝绿色的近地烟雾只出现在局部区域，说明作者正在通过环形分布的旋转参数控制烟雾集中在哪个方位

当前图中可确认的设置如下

- 发射器：`Smoke_AroundGroundWind`
- 当前粒子数：`8 Particles`
- 模块：`Shape Location`
- `Shape Primitive = Ring / Disc`
- `Ring / Disc Mode = Circle`
- `Ring Radius = 600.0`
- `Ring / Disc Distribution Mode = Random`
- `Disc Coverage = 0.0`
- `U Distribution = 0.5`
- `Transform`
  - `Transform Order = Scale / Rotate / Offset`
  - `Scale Mode = Default`
  - `Non Uniform Scale = (1.0, 1.0, 1.0)`
  - `Rotation Mode = Axis Angle`
  - `Rotation Axis = (0.0, 0.0, 1651.6)`
  - `Rotation Angle` 当前未见非零值
  - `Rotation Angle Type = Normalized Angle (0-1)`
  - `Rotation Coordinate Space = Local`
  - `Offset Mode = None`
  - `Shape Origin = STACKCONTEXT Position`

这一步的作用是把本来只覆盖半圈的地面烟雾发射区域进一步按本地空间方向旋转，从而让近地烟雾更多地落在镜头前方或指定侧面，而不是平均分布在龙卷风四周。这样既能减少背面无效烟雾，也能让观众视角下的地面烟尘更集中、更有层次
这一帧继续处理 `Smoke_AroundGroundWind`，但从 `Shape Location` 转到了 `Add Velocity`。左侧预览中地面附近的烟雾已经沿局部区域散开，说明作者不只是让它们静态出现在半圈位置上，而是进一步为这些烟雾增加从某个中心点向外扩散的速度

当前图中可确认的 `Add Velocity` 设置如下

- 发射器：`Smoke_AroundGroundWind`
- 当前粒子数：`126 Particles`
- 模块：`Add Velocity`
- `Velocity Mode = From Point`
- `Velocity Speed` 使用 `Random Range Float`
  - `Minimum = 500.0`
  - `Maximum = 600.0`
  - `Constrain To Radius = 0.0`
- `Offset`
  - `Velocity Origin = SimulationPosition`
  - `Origin Offset = (0.0, 0.0, -1000.0)`
  - `Origin Offset Coordinate Space = Local`

这一步的作用是把地面环风烟雾从一个位于发射器下方 `1000` 单位的位置向外推开，而不是单纯向上抛升。这样粒子会更像沿地面附近被风场推出、扩散，而不会一下子飞得过高；同时 `500-600` 的速度范围也比上一段 `Smoke_Vortex001` 的上升速度更克制，更适合地表烟雾层
这一帧继续细调 `Smoke_AroundGroundWind` 的 `Add Velocity`，但相较上一张图已经明显降低了向外推散的力度，同时把速度起点的参考位置上移。结合本段字幕里反复提到“不希望它们飞走”“需要把它们降低”，可以看出作者在压低地面烟雾的扩散强度，避免烟雾被推得过快、过远

当前图中可确认的 `Add Velocity` 设置如下

- 发射器：`Smoke_AroundGroundWind`
- 当前粒子数：`43 Particles`
- 模块：`Add Velocity`
- `Velocity Mode = From Point`
- `Velocity Speed` 使用 `Random Range Float`
  - `Minimum = 200.0`
  - `Maximum = 300.0`
  - `Constrain To Radius = 0.0`
- `Offset`
  - `Velocity Origin = SimulationPosition`
  - `Origin Offset = (0.0, 0.0, -250.0)`
  - `Origin Offset Coordinate Space = Local`

与上一张图相比，这一步把地面烟雾的外推速度从 `500-600` 降到了 `200-300`，同时把速度源点从 `-1000` 提回到 `-250`。结果上，这会让烟雾更贴近龙卷风周围缓慢散开，而不是被远距离原点强烈抛射，从而更符合“近地环风带起烟尘”的视觉目标

### 00:39:03-00:41:37 关键流程 13

- 本段定位：关键流程 13。
- 知识点：镜头转过 可能还在 所以它们会更弱 注意 这里是这种 可能更弱 现在我们看看结果 镜头的样子 可能这里 镜头还需要再加速 所以如果我提升15 这太多了。
- 知识点：5,5 这就行了 你喜欢的比较多 你能让它 有点没注意 它们应该降低了 灯光也不太亮 这种 这里它在 它会慢慢地消失 总体来说 这是我们最重要的一刻。
- 知识点：在镜头上 这是怎么做的 我还想做一些其他事情 来加点。

**关键画面：**

这一帧回到关卡视口与 Sequencer，直接查看经过前几段云片、地面烟雾和速度调整后的整体龙卷风效果。画面里主体龙卷风中部的亮色卷带已经比较稳定，底部一圈发光云片也形成了较完整的包围感，说明作者正在把“最重要的一刻”的镜头效果作为基准来判断前面各组参数是否需要继续削弱或加强

当前图中可确认的信息如下

- 选中对象仍为 `NS_Tornado`
- Sequencer 正在预览：
  - `CameraActor`
  - `NS_Tornado`
  - `NiagaraComponent0`
  - `System Life Cycle`
- `System Life Cycle` 使用 `Desired Age`
- 当前时间指针约为 `0.8631` 秒

从这张结果图可以确认，作者此时优先关注的是镜头观感而不是单个模块数值。龙卷风底部的附加云和地面烟雾没有明显脱离主体，整体亮度也比早期步骤更集中，说明此前对速度、遮罩和材质亮度的调整已经基本汇总到了这一版整体效果上
这一帧继续在关卡里观察 `NS_Tornado` 的整体表现，字幕明确说明“更多的取决于你喜欢哪个效果”，表示此时已经进入镜头风格取舍阶段，而不是再追求某个唯一正确的参数。画面里龙卷风中部的亮色卷带更明显，底部包围云片也更厚，说明作者正在比较不同强度配置在镜头中的观感差异

当前图中可确认的信息如下

- 选中对象仍为 `NS_Tornado`
- Sequencer 仍在预览 `CameraActor` 与 `NS_Tornado`
- 当前时间指针约为 `5.5167` 秒
- 顶部打开的资源标签包含：
  - `MI_TornadoClouds_01`
  - `MI_TornadoClouds_02`
  - `MI_TornadoClouds_03`

这一图传达的重点是：关键流程 13 的一部分并不是再新增模块，而是在现有多套云材质和烟雾参数之间做审美取舍。作者允许这一版效果保留一定主观空间，只要龙卷风主体、底部云片和地面烟雾在镜头里形成足够清晰的层次，就可以接受
这一帧继续保持在关卡视口中查看 `NS_Tornado` 的关键镜头结果，但时间推进到了后段，便于确认这一版龙卷风在播放中后期是否还能维持清晰的主体轮廓和逐步消散的节奏。画面里亮色卷带依然集中在龙卷风中部，底部包围云片仍然可见但没有完全抢过主体，说明作者正在检查“最重要的一刻”之后的持续可读性

当前图中可确认的信息如下

- 选中对象仍为 `NS_Tornado`
- Sequencer 仍在预览 `CameraActor` 与 `NS_Tornado`
- 当前时间指针约为 `7.8617` 秒
- 右侧 `Details` 面板仍停留在 `NS_Tornado (Instance)` 的对象级信息，而不是单独模块参数

这张图表达的是关键流程 13 的收束状态：在时间推进到后半段后，龙卷风仍保留了足够明显的亮部卷带、底部云片和地面烟雾支撑，但整体没有变得过亮或过散。结合上文“它会慢慢地消失”的说明，可以把这一帧理解为对消散节奏和主体可读性的最终目测确认

### 00:41:39-00:42:10 关键流程 14

- 本段定位：关键流程 14。
- 知识点：更多的注意 这是来加点灯光 就是 我们想象一下镜头会怎样 如果它会这样 那不太酷 必须加点证据 让它很容易显示 就是 我们想象一下 我们是一个 神奇的灯光。
- 知识点：可以做一个灯光转 然后它就会显示得很快 在下一个视频 需要做到 这就这么说 再见。

**关键画面：**

这一帧进入 `关键流程 14` 的结尾观察阶段，作者在关卡视口与 Sequencer 中查看龙卷风接近尾声时的镜头效果。画面里主体龙卷风上半段已经明显变弱，底部云片和近地烟雾也更暗，和本段上下文“需要再加点灯光”相对应，说明作者正把这个偏暗的结尾镜头当作后续补光思路的依据

当前图中可确认的信息如下

- 选中对象仍为 `NS_Tornado`
- Sequencer 正在预览：
  - `CameraActor`
  - `NS_Tornado`
  - `NiagaraComponent0`
  - `System Life Cycle`
- `System Life Cycle` 使用 `Desired Age`
- 当前时间指针约为 `9.15` 秒

这张图传达的重点不是新参数，而是问题定位：龙卷风后段在镜头里已经衰减到接近失去存在感，因此作者判断需要额外加入或增强灯光相关效果，才能让最终画面在结尾阶段依然足够可读
这一帧仍然停留在关卡视口与 Sequencer，但时间指针被拉回到更早的位置，画面中几乎只剩下地面上一块微弱的亮斑，没有明显的龙卷风主体。结合本段“必须加点灯光，让它很容易显示”的上下文，这一图相当于把当前镜头的最低可见度状态摆出来，用作后续补光的判断基线

当前图中可确认的信息如下

- 选中对象仍为 `NS_Tornado`
- Sequencer 仍在预览：
  - `CameraActor`
  - `NS_Tornado`
  - `NiagaraComponent0`
  - `System Life Cycle`
- `System Life Cycle` 使用 `Desired Age`
- 当前时间指针约为 `-0.10`

这一图说明，在某些时间位置上镜头中的龙卷风几乎完全不可读，只有很弱的地面受光残留。因此作者提出“需要加点灯光”的原因不是美化，而是为了保证镜头在最暗阶段也能让观众快速识别主体位置和能量来源
这一帧是本页教程的收尾画面。画面中依然只有非常微弱的地面亮斑，没有重新出现明显的龙卷风主体，而字幕明确说明“在下一个视频中，我们将做到这一点。现在就这些”，这表示作者在本页只把问题定位到了“需要补灯光”，但并没有在当前页内继续实现这一步

当前图中可确认的信息如下

- 选中对象仍为 `NS_Tornado`
- Sequencer 仍在预览：
  - `CameraActor`
  - `NS_Tornado`
  - `NiagaraComponent0`
  - `System Life Cycle`
- `System Life Cycle` 使用 `Desired Age`
- 当前时间指针约为 `0.0333`

这张图的意义在于给当前页面划清边界：`关键流程 14` 并没有提供具体灯光节点、Actor 或参数设置，只是通过几张极暗的镜头预览证明了补光需求真实存在，并把“补一层让主体更容易显示的神奇灯光”留到下一页或下一段教程继续处理

## 补充视觉证据

### S03 00:11:04

这是对前文 `S03 00:11:04` 的补充视觉证据，画面切到 Photoshop 中的云层黑白贴图编辑界面。字幕直接说明“你可以复制这个图层，缩小它”，因此这一张补图的核心用途是补证前面云纹理处理时的图层操作，而不是新增 Unreal 或 Niagara 参数

当前图中可确认的信息如下

- 软件界面为 Photoshop
- 中央画布是一张黑底白云的高对比度云层图：
  - 大片黑色背景
  - 多个亮白云团和灰度过渡区域
  - 底部有一层较平的云带
- 右侧 `Layers` 面板可见至少三层：
  - `Layer 6`
  - `Layer 5`
  - `Background`
- 当前选中的是普通图层而不是背景层
- 右侧 `Properties` 面板显示当前为 `Pixel Layer`
- 左侧工具栏与画笔面板展开，说明当前仍在进行贴图手工修饰或图层调整

这张补充图给出的可执行操作是：在现有云层黑白贴图里复制当前云层，再把复制层缩小，用来增加局部云团密度或制造更细的层次变化。因为这里是黑白遮罩式处理，缩小后的图层通常会作为额外高亮云块叠加到原云层之上，帮助后续材质里得到更丰富的亮云形状

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。

