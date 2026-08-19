# 05Post Process 后期处理材质

# 05Post Process 后期处理材质

## 关键术语

- `Alpha`、`Material`、`Post Process`、`Post Process Volume`、`Depth Fade`、`UV`、`Sequencer`、`Camera`、`Camera Shake`、`Substance`、`Niagara`、`Normalized Age`、`Noise`、`材质`、`纹理`、`系统`、`Niagara System`、`Emitter`

## 分段知识

### 00:00:05-00:04:47 后期处理、后处理

- 本段定位：后期处理、后处理。
- 知识点：这次后续会一起使用后期处理功能, 所以需要理解后期处理。
- 知识点：它是在渲染管线中场景渲染完成后, 然后额外应用视觉效果的过程。
- 知识点：简单来看这张图片, 其实这是一张真实的渲染结果图。
- 知识点：简单来说, 就是简化音调做成漫画, 感觉提取边缘这部分, 效果就像这样调整图形。
- 知识点：后期处理的名字为什么叫后期处理呢? 因为它是制作到渲染过程的原文件, 所以叫后面的意思,叫后期。
- 知识点：被理解为后处理渲染的后处理过程, 所以叫后期处理,后就处理, 就叫这样说。
- 知识点：还理解后处理, 简单的渲染管线也要知道, 内部我也会解释。

**关键画面：**

这是本页 `05 Post Process 后期处理材质` 章节的开场标题画面。

- 画面中央只有一行大标题：`Post Process`。
- 背景为纯黑底，说明这是从具体编辑器操作切回到章节讲解页，用来明确当前主题已经进入“后期处理”部分。
- 结合本段正文，可将这张图理解为：后续内容将围绕“场景渲染完成后，再额外叠加视觉效果”的后处理流程展开，而不是继续讲前一页的 Sequencer 或 Niagara 生命周期控制。

这张图的作用是主题锚点：提醒读者接下来的内容重点是 `Post Process / 后期处理`，即在渲染结果之上追加风格化、边缘提取、色调调整等屏幕后处理效果。
这是一张用于解释后期处理位置的 `Render Pipeline` 总览图，说明 `Post Process` 是渲染管线靠后的阶段，而不是模型或材质最前面的输入阶段。

渲染流程从左到右依次分成四段：

- `Data Input / Vertex Shading / Positioning`
  - 表示最初的数据输入、顶点着色与顶点定位阶段。
- `Rasterization / Space Transform / Triangle Rasterization / Clip, Culling`
  - 表示几何经过空间变换后，进入三角形光栅化、裁剪与剔除处理。
  - 上方配图是一个线框球体，用来示意几何体和空间变换。
- `Pixel Shading / Texturing / Material / Lighting`
  - 表示像素着色阶段会应用纹理、材质和光照计算。
  - 上方配图是一个红色球体材质示例，用来说明材质与光照后的外观结果。
- `Depth Test / Alpha Test / Post Process`
  - 表示在更靠后的图像阶段，会继续进行深度测试、透明度测试，最后才进入后期处理。
  - 上方配图是场景中的球体和几何体，用来说明最终屏幕结果是在前面各阶段处理后形成的。

图中橙色箭头把四个大模块串起来，表达的是线性流程：数据和几何先被处理，随后做材质和光照，最后才到屏幕结果相关的深度、Alpha 与后处理阶段。

这张图的核心结论是：`Post Process` 不直接替代建模、贴图或光照，而是发生在这些主要渲染步骤之后，对已经生成的画面结果再进行额外视觉加工。
这张图继续使用同一张 `Render Pipeline` 流程图，但讲解重点从“后处理在什么位置”转向“当输入基准发生变化时，渲染链路中哪些部分需要重新计算”。

- 流程图仍保持四段结构：
  - `Data Input / Vertex Shading / Positioning`
  - `Rasterization / Space Transform / Triangle Rasterization / Clip, Culling`
  - `Pixel Shading / Texturing / Material / Lighting`
  - `Depth Test / Alpha Test / Post Process`
- 上方三张示意图依然分别对应几何线框、材质着色球体、以及最终场景结果，说明这是在用同一套流程图反复解释渲染阶段之间的依赖关系。
- 结合字幕“基准变了、需要重新计算的部分”，可将这张图理解为：
  - 越靠前的阶段一旦发生变化，后面依赖它的阶段通常都要跟着重新计算。
  - 后处理虽然在流程最后，但它依赖的是前面已经生成的画面结果，因此前面渲染结果改变时，最终后处理结果也会一起变化。

这张图的核心用途是补充因果关系：后处理不是孤立的单独效果，而是挂在整条渲染链路末端的结果处理阶段；如果前面的几何、材质、光照或深度结果改变，后面的屏幕效果也必须基于新结果重新生成。

### 00:04:47-00:09:43 Alpha、Depth Fade、UV

- 本段定位：Alpha、Depth Fade、UV。
- 知识点：在这个恢复过程里就是 再次以视图空间为基准。
- 知识点：这些位置是如何定位的, 这种过程也会经历。
- 知识点：现在这个过程是在这个像素阴影之前, 正是把这个指油点组成的位置 分去索引,这样连接成线。
- 知识点：表面就形成了 这样表面现在叫做三角中间, 可以看作是像素化的过程, 依赖于顶点。
- 知识点：虽然表面是创建的, 但表面这些部分现在就是像素应该如何表现的这种采样过程。
- 知识点：在这个过程中,当过渡到像素阴影时, 这个物体所拥有的UV信息和法线信息, 然后基于这些信息进行纹理处理。
- 知识点：在材质上赋予我们制作的材质属性, 直就是观察光照反应, 然后促成光照反应。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Depth Fade`、`材质`、`纹理`、`透明度`。

**关键画面：**

这张图继续使用 `Render Pipeline` 总览图，但这一次重点不再是“后处理在最后”，而是解释像素形成之前的位置定位过程。

- 流程图仍从左到右分成四段：
  - `Data Input / Vertex Shading / Positioning`
  - `Rasterization / Space Transform / Triangle Rasterization / Clip, Culling`
  - `Pixel Shading / Texturing / Material / Lighting`
  - `Depth Test / Alpha Test / Post Process`
- 结合本段正文，这张图强调的是前两段：
  - 顶点先经过 `Vertex Shading` 和 `Positioning`
  - 随后在 `Space Transform` 与 `Triangle Rasterization` 阶段被组织成三角形并投到屏幕相关空间
- 上方左侧线框球体示意的是几何体在空间中的结构；它对应“位置如何被确定、如何从顶点组织成表面”的概念。
- 这张图与本段后续 `Alpha / Depth Fade / UV` 的关系在于：只有前面的几何定位、光栅化和像素落点成立后，后面材质里的透明度、深度衰减和 UV 采样才有作用对象。

这张图要表达的核心是：`Alpha`、`Depth Fade` 和 `UV` 这些后续材质层面的控制，并不是脱离渲染管线独立存在的；它们建立在前面顶点定位、空间变换和三角形光栅化已经把“像素该落在哪里”计算出来的前提之上。
这张图继续使用同一张 `Render Pipeline` 流程图，但讲解重心已经回到最右侧的 `Post Process` 阶段。

- 四段主流程仍保持不变：
  - `Data Input / Vertex Shading / Positioning`
  - `Rasterization / Space Transform / Triangle Rasterization / Clip, Culling`
  - `Pixel Shading / Texturing / Material / Lighting`
  - `Depth Test / Alpha Test / Post Process`
- 结合字幕“然后进入这次要使用的后期处理过程”，这张图的含义是：
  - 前面的几何、材质和光照步骤先把场景渲染结果准备好
  - 后面才轮到当前教程真正要使用的 `Post Process`
- 右侧最后一个模块把 `Depth Test`、`Alpha Test` 和 `Post Process` 放在一起，也说明后处理并非最早参与材质采样的部分，而是贴近最终屏幕合成结果的后段处理。
- 这对本页后续 `Alpha / Depth Fade / UV` 的衔接意义在于：这些信息会先参与材质或透明度表现，而屏幕后处理则是在它们已经影响画面之后，再对整张图像做附加处理。

这张图要传达的结论是：本教程接下来讲的“后期处理材质”，虽然名称里有材质，但它工作的时机属于渲染结果靠后阶段，核心不是改几何本体，而是对已经形成的画面做进一步视觉加工。
这张图是从原理图切回 Unreal 编辑器后的实际操作入口，展示后处理效果在场景中的挂载位置。

- 当前 `Outliner` 中选中的是 `PostProcessVolume`。
- 右侧 `Details` 面板显示的是该 `PostProcessVolume` 的属性。
- 在 `Rendering Features` 区域下，可以看到 `Post Process Materials` 分类，当前显示：
  - `Array`
  - `1 Array element`
  - 该元素的权重约为 `1.0`
  - 右侧已经挂入一个以 `PP_` 开头的后处理材质/材质实例资源
- 这说明当前场景里已经不是只讲概念，而是实际把一个后处理材质塞进了 `PostProcessVolume` 的材质数组中。
- 场景视图中能看到一个简单测试场景：地面、黑色背景、一个 `SM_SkySphere` 等基础对象，以及 `PostProcessVolume` 的选中状态，用于观察后处理材质对整张屏幕结果的影响。
- 下方 `Content Browser` 已定位到 `Content > Signature > Course_03`，说明相关资源就在当前课程内容目录中管理。

这张图的关键操作结论是：如果要让后处理材质真正生效，核心入口不是普通网格材质球，而是把 `PP_` 类后处理材质加入 `PostProcessVolume -> Post Process Materials` 数组；之后整张画面都会按该后处理材质进行屏幕后处理。

### 00:09:43-00:14:16 材质、纹理与透明度控制

- 本段定位：材质、纹理与透明度控制。
- 知识点：还有爆炸、毛发、遮罩, 色差等等很多。
- 知识点：颜色分级啊,镜头光运那些,也有很多。
- 知识点：这样应用到相机的方法, 通过后期处理卷来应用的方法, 就是可以分为这两种。
- 知识点：这个后处理,现在我在PVT上展示的 像素阴影,到深度测试、 深度测试、Alpha测试,直接之前的所有 处理结果值,就是现在获取的节点是 叫做场景纹理这个节点。
- 知识点：这里的场景纹理节点是我们托放纹理 使用的,我们导入纹理文件。
- 知识点：但场景纹理是把渲染的结果变成纹理。
- 知识点：现在我们看到了这个失口画面,就是这个结果值的意思是说, 就在这,我觉得场景纹理节点的这个选项看一下。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`材质`、`纹理`、`颜色`、`透明度`。

**关键画面：**

这张图展示的是：`PostProcessVolume` 除了可以挂 `Post Process Materials`，本身还自带大量内建后处理分类选项。

- 当前 `Outliner` 中选中对象仍是 `PostProcessVolume`。
- 右侧 `Details` 面板已经滚动到内建后处理设置列表，可见的分类包括：
  - `Bloom`
  - `Exposure`
  - `Chromatic Aberration`
  - `Dirt Mask`
  - `Camera`
  - `Local Exposure`
  - `Lens Flares`
  - `Image Effects`
  - `Depth of Field`
  - `Color Grading`
  - `Temperature`
  - `Global`
  - `Shadows`
- 场景中还是一个基础测试关卡：地面、黑背景和一个被选中的 `PostProcessVolume`，用于观察这些屏幕后处理项对最终画面的影响。
- 结合字幕可知，这张图的意图是强调“像相机一样也有很多处理选项”，即后处理并不只是一张自定义材质，还包括大量引擎内置的视觉调节模块。

这张图的关键结论是：后处理工作流有两条路，一条是使用 `Post Process Materials` 做自定义屏幕材质，另一条是直接在 `PostProcessVolume` 的内建分类里调节现成的后处理效果，如 Bloom、色差、景深、调色和镜头光晕等。
这是一个后处理材质 `PP_Sharpen_Material` 的材质图，作者在这里说明 `SceneTexture` 节点并不是读取外部贴图，而是读取已经渲染好的场景结果或 GBuffer 信息。

节点定义集：

- `SceneTexture` 节点的搜索菜单处于展开状态，可见可选项包括：
  - `SceneColor`
  - `SceneDepth`
  - `DiffuseColor`
  - `SpecularColor`
  - `SubsurfaceColor`
  - `BaseColor`
  - `Specular`
  - `Metallic`
  - `WorldNormal`
  - `SeparateTranslucency`
  - `Opacity`
  - `Roughness`
  - `MaterialAO`
  - `CustomDepth`
  - `PostProcessInput0`
  - `PostProcessInput1`
  - `PostProcessInput2`
  - `PostProcessInput3`
  - `PostProcessInput4`
  - `PostProcessInput5`
- 左下属性面板中，当前选中的 `SceneTexture` 节点 `Scene Texture Id` 为 `PostProcessInput0`。
- 图中间能明确看到 4 个红色 `SceneTexture: PostProcessInput0` 节点，说明同一份后处理输入被重复采样多次。
- 每一路采样前面都有 `Append` 与 `Add` 一类绿色运算节点，用来构造不同的 UV 偏移。
- 多路采样结果在右侧通过若干 `Add`、`ABS` 汇合，最后再经过一个 `Divide` 节点。
- `Divide` 的其中一个输入来自常量 `4.0`，表示最终结果会被按 4 进行归一化或平均。

连线集：

- 多组 `Append -> Add -> SceneTexture(PostProcessInput0)` 构成 4 路平行采样链。
- 上方两路采样结果先汇总到一个 `Add`。
- 下方两路采样结果汇总到另一个 `Add`。
- 两组汇总结果再进入 `ABS` 后，与常量 `4.0` 一起进入 `Divide`。

设置/参数：

- 材质名为 `PP_Sharpen_Material`。
- 当前画面没有展示完整材质输出端，无法可靠确认最终接到 `Emissive` 还是其他后处理输出口，因此这一部分不猜测。
- 从命名和结构看，这里是在对同一场景输入做多次邻域采样与差值/叠加运算，用于锐化或边缘增强类效果。

输出/预览：

- 左侧预览球显示的是材质编辑器默认球体预览，仅用于查看材质变化。
- 真正被处理的数据源不是球体贴图，而是 `PostProcessInput0` 所代表的屏幕渲染结果。

这张图的核心信息是：后处理材质里最关键的输入节点是 `SceneTexture`。它能把当前场景渲染结果或 GBuffer 数据当作“纹理”读出来，再通过多次偏移采样和数学运算生成锐化、描边或其他屏幕后处理效果。
这张图展示的是：作者从后处理材质图切到材质实例参数界面，把复杂节点图封装成可直接调节的实例参数。

- 当前打开的是 `PP_Sharpen_Material` 对应的材质实例界面。
- 右侧 `Details` 中 `Parameter Groups -> Global Scalar Parameter Values` 下只显示一个关键参数：
  - `Sharpness = 1.0`
- `Parent` 明确指向 `PP_Sharpen_Material`，说明这个实例继承自前一张图里的后处理母材质。
- 左侧预览区域显示一个简单的平面棋盘格预览，这里主要用于观察实例参数变化，而不是最终屏幕效果。
- 右侧还能看到 `Material Property Overrides`、`Previewing` 等常规实例面板区域，但当前真正被讲解和暴露出来的只有 `Sharpness` 这个锐化强度参数。

这张图要表达的实操结论是：后处理材质的复杂采样和计算逻辑应放在母材质里完成，而实际使用时最好再做一个材质实例，只把像 `Sharpness` 这种需要频繁调节的强度参数暴露出来。这样挂到 `PostProcessVolume` 后，就能更方便地直接调节后处理锐化效果，而不必每次回到材质图改节点。
### 00:14:16-00:19:03 Material、UV、蓝图

- 本段定位：Material、UV、蓝图。
- 知识点：这种亮度对这个边缘的亮度越来越强。
- 知识点：可以认为这是个处理过的图像补正功能。
- 知识点：这种材料的使用, 我们把这个材料这个领域放在这里后处理使用。
- 知识点：类似这样, 现在PostProcess这种材质单独定制后, 这样使用时一定要把这个域对准PostProcess, 否则就无法运作。
- 知识点：可以看作是这个Post效果要用还是不用。
- 知识点：现在我们没有半透明元素。
- 知识点：基础颜色就是字面意思的颜色。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Material`、`材质`、`蓝图`、`颜色`。

**关键画面：**

这张图展示的是：把锐化型后处理材质挂进 `PostProcessVolume` 后，直接在场景视图里观察 `Sharpness` 参数对边缘亮度的影响。

- 当前 `Outliner` 里选中的仍是 `PostProcessVolume`。
- 场景画面只保留基础地面网格和黑背景，便于观察后处理对边缘线条的影响。
- 地面网格的白色分隔线和远处地平线边界都显得更清晰、对比更高，说明后处理锐化已经在整张屏幕上生效。
- 画面底部的参数面板中可以看到实例参数 `Sharpness`，当前值为 `20.0`。
- 结合字幕“边缘的亮度越来越强”，可确认这个参数越高，屏幕中边缘附近的增强/提亮感越明显。

这张图的关键结论是：后处理锐化材质并不是作用在单个网格上，而是对整张屏幕结果做边缘增强；因此像地面格线、轮廓线和远处高对比边界，都会随着 `Sharpness` 提高而整体变得更突出。
这张图展示的是：后处理材质可读取的并不只是最终彩色画面，还可以读取渲染管线里的多种 GBuffer/场景通道结果。

- 编辑器视口切换到了 `Overview` 类缓冲区查看模式，屏幕被分成多个小窗格。
- 当前能直接看到的通道标签包括：
  - `Base Color`
  - `Specular`
  - `Subsurface Color`
  - `World Normal`
  - `Separate Translucency RGB`
  - `Separate Translucency Alpha`
  - `World Tangent`
  - `Opacity`
- 不同窗格的内容也符合这些语义：
  - `Base Color` 中能看到灰色地面棋盘格
  - `World Normal` 是偏蓝紫色的法线可视化结果
  - `Opacity`、`Separate Translucency` 等通道则显示为纯黑、纯白或单独颜色块
- 右侧 `Details` 当前选中的是 `Floor`，说明此时场景里只有非常基础的测试对象，因此不同缓冲区内容很容易对应到地面材质本身。

这张图的核心意义是：后处理材质里通过 `SceneTexture` 读取的内容，不一定非要是最终颜色图，也可以是 `Base Color`、`World Normal`、`Opacity` 等缓冲区数据。这样就能基于法线、透明度、基础颜色或半透明信息，做更有针对性的屏幕后处理效果。
这张图展示的是：作者回到 `Content Browser` 管理当前测试资源，为后续基于蓝图或其他资源组织后处理与特效逻辑做准备。

- 当前内容浏览器路径位于 `Content > Signature > Test`。
- 资源列表里能明确看到多种资源类型混合放在这个测试目录中，包括：
  - 一个名为 `Test` 的 `Blueprint Class`
  - `NewLevelSequence`
  - `NewMaterial`
  - 多个 `Niagara System` 资源，例如 `NewNiagaraSystem`、`NewNiagaraSystem1`、`NewNiagaraSystem2` 等
  - 一个 `Ribbon_Test`
  - 还有一个 `Mesh_Test_01`
- 右侧 `Details` 当前仍选中场景中的 `Floor`，说明这张图的重点不是场景参数本身，而是项目资源的组织与命名。
- 字幕里提到“取名为 shake”，但当前画面尚未直接显示改名完成后的资源名，因此这里只能确认作者正在测试目录里整理一个蓝图类及相关效果资源，不能进一步断言具体重命名后的最终对象。

这张图的实际意义是：在后处理、相机或特效演示中，除了材质图本身，还需要把蓝图、关卡序列、Niagara 系统和测试资源整理到清晰的目录下。这样后面无论是通过蓝图触发、通过相机使用，还是与序列联动，都更容易定位和复用这些资源。

### 00:19:03-00:23:46 UV、Substance、Noise

- 本段定位：UV、Substance、Noise。
- 知识点：现在这里会写着关于平行噪声的相机。
- 知识点：这个名字本身只要重新关闭再打开一次。
- 知识点：在Substance中也经常使用过。
- 知识点：利用这种噪音的随机性来控制摄像机的移动。
- 知识点：这条线的意思是, 对白色和黑色部分的曲线立体地表现时, 会呈现这种形状。
- 知识点：这里的摄像机, 如果上下的Z轴噪音模式是这个样子, 那么摄像机的高度就会这样变化。
- 知识点：有点这样来回走动呢? 这个点和这个点来回走动呢? 这个可以一直偏移您认为的横着流动。
- 核对对象：`Noise`、`曲线`、`噪声`。

**关键画面：**

这张图展示的是：作者开始创建一个相机抖动资源 `TestShake`，并把其根抖动模式切换为基于 Perlin Noise 的相机抖动模式。

- 当前打开的是一个名为 `TestShake` 的蓝图/相机抖动资源，顶部明确显示 `Parent class: Default Camera Shake Base`。
- 右侧 `Details` 面板中，`Camera Shake Pattern` 下的 `Root Shake Pattern` 正在打开下拉选择菜单。
- 下拉菜单中可见的可选模式包括：
  - `None`
  - `Composite Camera Shake Pattern`
  - `Perlin Noise Camera Shake Pattern`
  - `Sequence Camera Shake Pattern`
  - `Wave Oscillator Camera Shake Pattern`
- 当前高亮/目标选择的是 `Perlin Noise Camera Shake Pattern`，与正文中关于噪声驱动相机移动的讲解一致。
- `Timing` 区域下可见基础时长参数：
  - `Duration = 1.0`
  - `Blend In = 0.2`
  - `Blend Out = 0.2`

这张图的关键操作结论是：要做随机感更强、自然抖动的相机效果，可以从 `Default Camera Shake Base` 继承一个相机抖动资源，然后把 `Root Shake Pattern` 设为 `Perlin Noise Camera Shake Pattern`，后续再继续调整位置、旋转和时间参数。
这张图是 `Camera Shake` 的概念示意页，用来解释 Perlin Noise 相机抖动的控制方式。

- 画面标题为 `Camera Shake`。
- 左侧是一张灰度噪声图，表示相机抖动的随机来源可以理解为一张连续变化的 Noise。
- 中间是一条上下起伏的曲线，表示把噪声采样结果沿时间展开后，会形成一条连续变化的位移/旋转趋势曲线，而不是完全跳变的离散抖动。
- 右侧是按 `X / Y / Z` 三个轴拆分的参数面板，每个轴下都包含两项：
  - `Amplitude`
  - `Frequency`
- 结合正文可理解为：
  - `Amplitude` 决定某个轴抖动幅度有多大
  - `Frequency` 决定变化有多快
  - 不同轴可以分别设置，因此相机可以在上下、左右、前后方向表现出不同的抖动特征

这张图的关键意思是：Perlin Noise 相机抖动并不是简单的随机乱跳，而是通过噪声生成一条连续曲线，再按 `X/Y/Z` 各轴的 `Amplitude` 和 `Frequency` 去控制相机在不同方向上的抖动幅度与节奏。
这是一个 `Substance 3D Designer` 中用于生成噪声曲线的节点图，作者借它解释相机抖动里“Noise 转连续曲线”的来源。

节点定义集：

- `Perlin Noise`
  - 分辨率显示为 `1024x1024`
  - 位深显示为 `L16`
  - 作为整张图的原始随机噪声输入
- `Cross Section`
  - 分辨率显示为 `1024x1024`
  - 位深显示为 `L16`
  - 用于从二维噪声里切出一条剖面曲线
- `Histogram Scan`
  - 红色节点
  - 接在 `Cross Section` 后面，用于把剖面结果进一步阈值化/强化
- `Histogram Range`
  - 红色节点
  - 从 `Histogram Scan` 输出继续分支，用于调整结果的范围
- `Sharpen`
  - 画面下方可见其标题，但当前只露出节点顶部，无法可靠确认它与当前主链路的完整连接关系

连线集：

- `Perlin Noise` 输出连接到 `Cross Section` 输入。
- `Cross Section` 输出连接到 `Histogram Scan` 输入。
- `Histogram Scan` 输出至少分成两路：
  - 一路继续向下连接到 `Histogram Range`
  - 另一路向右下方延伸到画面外的后续节点
- 当前截图未完整展示最右侧或最下方终点，因此不补写不可见输出端。

设置/参数：

- 右侧属性面板当前选中的是 `cross_section` 节点。
- `INSTANCE PARAMETERS` 中可见参数包括：
  - `Cross section coordinate = 0.29`
  - `Section axis = X`
  - `Show Helper = False`
  - `Height scale = 0.25`
  - `Height offset = 0`
  - `Drawing style = Line`
  - `Segment amount = 256`
  - `Line thickness = 0.01`

输出/预览：

- 右下预览窗口显示的是一条白色起伏曲线，黑底背景，分辨率为 `1024x1024 (Grayscale, 16bpc)`。
- 这条曲线正对应 `Cross Section` 从 Perlin 噪声中切出的连续变化结果，可直接类比成相机某个轴上的噪声驱动轨迹。

这张图的核心信息是：相机抖动里提到的 Noise 并不只是抽象概念，它可以像 Substance 里这样从 `Perlin Noise` 开始，经 `Cross Section` 抽出一条连续曲线，再通过 `Histogram` 类节点做后处理。最终得到的就是适合拿来驱动相机位移或旋转变化的连续噪声曲线。

### 00:23:46-00:28:17 UV、Camera、Camera Shake

- 本段定位：UV、Camera、Camera Shake。
- 知识点：如果您理解的话, 需要很快就能理解该如何给Shake数值。
- 知识点：在这里, 我们要测验证效果应用到我们的训列器上吗? 是的, 测试中我们曾经制作过级别训列器的部分。
- 知识点：如果您查看现在正在制作的测试Shake部分, 其实还有一个要了解的选项。
- 知识点：一开始Duration是我们设定的旋转值几乎不会给出。
- 知识点：这一部分就把Ampute认识为0。
- 知识点：这个Location值的变化最多。
- 知识点：摇动最明显是这个Z轴上下移动的时候。

**关键画面：**

这是上一批同一张 `Substance 3D Designer` 噪声图的继续说明，这次重点从 `Cross Section` 切到了 `Perlin Noise` 节点本身的参数。

节点定义集：

- `Perlin Noise`
  - 分辨率 `1024x1024`
  - 位深 `L16`
  - 作为整条链路的原始二维噪声源
- `Cross Section`
  - 接在 `Perlin Noise` 后，用于从二维噪声中切出一条剖面曲线
- `Histogram Scan`
  - 接在 `Cross Section` 后，用于强化/筛选输出
- `Histogram Range`
  - 从 `Histogram Scan` 继续分支
- `Sharpen`
  - 画面下方仍只露出顶部，无法可靠确认完整连接终点

连线集：

- `Perlin Noise -> Cross Section`
- `Cross Section -> Histogram Scan`
- `Histogram Scan` 输出继续分支到下游节点，其中一支连到 `Histogram Range`

设置/参数：

- 当前右侧属性面板选中的是 `perlin_noise`。
- `INSTANCE PARAMETERS` 中清晰可见：
  - `Scale = 6`
  - `Disorder = 0`
  - `Non Square Expansion = True`
- 上方 `PROPERTIES` 区域还能看到基础尺寸/平铺相关选项，如 `Width`、`Height`、`Pixel Ratio`、`Tiling Mode`、`Random Seed`，但截图中没有显示这些值被修改，因此不追加具体数值。

输出/预览：

- 右下预览窗显示的是一条更平滑的白色起伏曲线，黑底背景，标注为 `1024x1024 (Grayscale, 16bpc)`。
- 结合字幕“同样时间内，移动的频率会增加很多”，可确认这里在用 `Scale` 调整噪声细节密度，进而影响最终曲线变化频率。

这张图的核心意思是：相机抖动里说的 `Frequency` 可以类比成这里对 `Perlin Noise` 细节密度的调节。`Scale` 提高后，单位区间内噪声变化更密，切出的曲线起伏也会更频繁，因此映射到相机上时会表现为更密集的抖动节奏。
这张图展示的是：`TestShake` 的 `Perlin Noise Camera Shake Pattern` 已经展开到具体轴向参数，作者开始直接设置位置抖动和时间过渡。

- 当前资源仍是 `TestShake`，父类为 `Default Camera Shake Base`。
- `Root Shake Pattern = Perlin Noise Camera Shake Pattern`。
- `Location` 段下可见整体乘数：
  - `Location Amplitude Multiplier = 1.0`
  - `Location Frequency Multiplier = 1.0`
- 三个轴向的位置抖动参数当前显示为：
  - `X`
    - `Amplitude = 1.0`
    - `Frequency = 1.0`
  - `Y`
    - `Amplitude = 1.0`
    - `Frequency = 1.0`
  - `Z`
    - `Amplitude = 10.0`
    - `Frequency = 1.0`
- 这说明当前设置明显强化了 `Z` 轴的上下位移抖动，符合正文“摇动最明显是这个 Z 轴上下移动”的说明。
- `Timing` 区域可见：
  - `Duration = 1.0`
  - `Blend In Time = 0.1`
  - `Blend Out Time = 0.2`

这张图的关键含义是：如果希望镜头抖动主要表现为上下震动，可以把 `Z` 轴 `Amplitude` 设得明显高于 `X/Y`。而 `Duration`、`Blend In Time`、`Blend Out Time` 则控制这次相机抖动持续多久、进入多快、结束多快。
这张图继续展示 `TestShake` 的 Perlin Noise 相机抖动设置，但参数已经从“轻微上下抖动”进一步调成了更强烈的 Z 轴震动。

- 当前资源仍是 `TestShake`，`Root Shake Pattern = Perlin Noise Camera Shake Pattern`。
- `Location` 下 `X`、`Y` 轴仍保持较小值：
  - `X Amplitude = 1.0`
  - `X Frequency = 1.0`
  - `Y Amplitude = 1.0`
  - `Y Frequency = 1.0`
- `Z` 轴被显著放大为：
  - `Amplitude = 50.0`
  - `Frequency = 10.0`
- 这表示相机将主要沿上下方向发生更大幅、更高频的抖动。
- `Timing` 仍保持：
  - `Duration = 1.0`
  - `Blend In Time = 0.2`
  - `Blend Out Time = 0.2`

这张图的关键结论是：相机抖动的“强弱”和“密度”可以集中在单一轴向上强化。把 `Z` 轴同时设成高 `Amplitude` 和高 `Frequency` 后，镜头会表现为更剧烈、更急促的垂直震动，这类设置更适合爆炸、重击或强烈冲击感的演出。

### 00:28:21-00:28:36 关键流程 07

- 本段定位：关键流程 07。
- 知识点：下次我们正式一起制作后期材料, 进行一下时间会很好。

**关键画面：**

这张图展示的是：前面创建好的 `TestShake` 相机抖动资源已经被真正挂进 `Sequencer`，作用到当前 `Cine Camera Actor` 上。

- 序列顶部仍是 `Camera Cuts` 与 `Cine Camera Actor` 轨道。
- `Cine Camera Actor -> CameraComponent` 下新增了一条 `Camera Shake` 轨道。
- `Camera Shake` 轨道上已经出现一个片段，片段标题能辨认出以 `TestShake_C...` 开头，说明它引用的正是前面创建的 `TestShake` 相机抖动资源实例。
- 这段相机抖动片段被放置在当前镜头时间范围内，与上方相机片段重叠，表示它会在该镜头播放期间生效。
- 同一相机下仍保留原有参数轨：
  - `Current Aperture = 2.8`
  - `Current Focal Length = 35.0`
  - `Manual Focus Distance = 100000.0`
  - `Spawned`
  - `Transform`
- 画面下方同时仍开着 `TestShake` 的类默认值界面，说明作者是一边调 `TestShake` 参数，一边在 `Sequencer` 中验证实际镜头效果。

这张图的关键操作结论是：相机抖动资源并不是做完就自动生效，必须把它添加到 `Cine Camera Actor` 的 `Camera Shake` 轨道里，并放在需要的时间段上，才会在 Sequencer 播放对应镜头时真正作用到相机。
这张图继续展示 `Camera Shake` 接入 Sequencer 后的状态，但重点更清楚地强调了“相机自身关键帧动画”和“相机抖动片段”可以同时存在。

- `Cine Camera Actor -> CameraComponent -> Camera Shake` 轨道上的 `TestShake_C...` 片段仍然存在，并且覆盖在当前镜头区间内。
- `Transform` 轨道下方可见一组位置/旋转关键帧点，说明这台相机本身已经有手动机位动画。
- 这意味着当前镜头效果不是二选一：
  - 一部分来自相机 `Transform` 的基础移动或构图变化
  - 另一部分来自 `Camera Shake` 的附加噪声抖动
- 上方 `Camera Cuts` 缩略图仍显示同一镜头段内角色的连续姿态变化，说明这些相机控制都在同一条镜头时间线里叠加发生。
- 底部仍开着 `TestShake` 默认值页，表示作者一边修改抖动资源，一边直接通过序列时间线观察最终镜头组合效果。

这张图的关键结论是：`Camera Shake` 并不会替代原有的相机关键帧动画，而是叠加在 `Cine Camera Actor` 的基础运动之上。实际制作时，通常先用 `Transform` 定镜头路径，再用 `Camera Shake` 补充冲击感、手持感或爆炸震动。
这张图可以视为这一小段“关键流程 07”的收束画面：它确认了相机抖动资源已经成功接入当前镜头工作流，后续可以从参数测试阶段转入正式制作。

- `Sequencer` 中 `Cine Camera Actor -> CameraComponent -> Camera Shake` 轨道仍挂着 `TestShake_C...` 片段。
- `Camera Cuts`、相机片段缩略图、相机 `Transform` 关键帧和 `Camera Shake` 片段同时存在，说明完整镜头链路已经打通：
  - 镜头切换由 `Camera Cuts` 控制
  - 相机路径由 `Transform` 控制
  - 附加抖动由 `Camera Shake` 控制
- 底部依然保留 `TestShake` 类默认值窗口，表明此时仍处于测试与验证阶段，但从结构上看，资源连接关系已经具备可复用性。
- 结合本段正文“下次正式一起制作后期材料”，可把这张图理解为：当前章节已完成后处理相关基础概念、后处理材质入口和相机抖动接线的预备工作，下一步将进入更正式的材质制作阶段。

这张图的关键意义不是新增某个参数，而是确认流程已经闭环：`TestShake` 已经从独立资源，变成可在 Sequencer 镜头中实际播放和验证的相机抖动段，为后续把后处理材质、镜头和演出组合到一起打好了基础。

## 补充视觉证据

### S03 00:11:44

这是 `S03 00:11:44` 的补充节点图截图，用来补证 `PP_Sharpen_Material` 中 `SceneTexture` 节点到底可以切换哪些场景缓冲区输入。

节点定义集：

- 当前材质图仍是 `PP_Sharpen_Material > Material Graph`。
- 画面左侧展开了一个 `SceneTexture` 节点的下拉菜单，当前高亮项是 `Roughness`。
- 下拉菜单中本张图可直接确认的可选项包括：
  - `SceneColor`
  - `SceneDepth`
  - `DiffuseColor`
  - `SpecularColor`
  - `SubsurfaceColor`
  - `BaseColor (for lighting)`
  - `Specular (for lighting)`
  - `Metallic`
  - `WorldNormal`
  - `SeparateTranslucency`
  - `Opacity`
  - `Roughness`
  - `MaterialAO`
  - `CustomDepth`
  - `PostProcessInput0`
  - `PostProcessInput1`
  - `PostProcessInput2`
  - `PostProcessInput3`
  - `PostProcessInput4`
  - `PostProcessInput5`
- 右侧主图区域仍能看到多路 `SceneTexture:PostProcessInput0` 节点，说明当前材质主体逻辑仍以 `PostProcessInput0` 为主，只是这张图在额外说明可选来源并不止这一种。

连线集：

- 当前补图的重点是下拉菜单选项，不是新增连线。
- 画面中主链路仍维持多路 `SceneTexture(PostProcessInput0)` 并行采样后汇总的结构，但截图没有展示新的连线变化。

设置/参数：

- 左下属性面板中仍可见 `Scene Texture Id` 字段，说明这里切换的就是 `SceneTexture` 节点读取的数据源类型。
- 当前菜单高亮 `Roughness`，表明后处理材质理论上也可以直接读取粗糙度缓冲，而不仅限于最终颜色图或后处理输入。

输出/预览：

- 左侧预览球仍只是材质编辑器默认预览。
- 这张补图真正补充的信息是：后处理材质可从多种 GBuffer / 场景缓冲中选取输入，再决定用哪一种数据参与后续屏幕运算。

这张补图的核心结论是：`SceneTexture` 节点是后处理材质读取场景缓冲的统一入口。除了 `PostProcessInput0` 这种最终画面输入，还能切换到法线、深度、透明度、粗糙度、AO 等多种通道，从而为描边、锐化、遮罩或基于材质属性的后处理效果提供不同的数据基础。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。

