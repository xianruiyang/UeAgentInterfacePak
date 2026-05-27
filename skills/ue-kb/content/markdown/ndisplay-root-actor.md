# nDisplay Root Actor使用参考

---
title: "nDisplay Root Actor使用参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/ndisplay-root-actor-reference-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "使用nDisplay在多显示屏上进行渲染", "nDisplay Root Actor使用参考"]
---

# nDisplay Root Actor使用参考

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 使用nDisplay在多显示屏上进行渲染 / nDisplay Root Actor使用参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/ndisplay-root-actor-reference-for-unreal-engine

借助 **nDisplay Root Actor**，当nDisplay群集已经启动并渲染到所有节点上时，你可以修改它的设置。这样你就能迅速对nDisplay渲染器作出更改，而无需通过 **nDisplay 3D配置编辑器（nDisplay 3D Config Editor）** 修改nDisplay的配置。

通常，在创建好nDisplay拓扑结构之后，你就不必再作更改。由于nDisplay Root Actor是 **nDisplay配置资产（nDisplay Configuration Asset）** 的实例，因此nDisplay Root Actor设置能让你更改特定节点的nDisplay渲染器效果，同时无需改动配置资产。

要创建nDisplay Root Actor，需要将nDisplay配置资产拖入关卡中。这样会在项目中创建nDisplay Cluster的预览，你就能看到群集渲染设置下的内容外观。

本页面包含了在编辑器中预览与在实时环境下使用物理nDisplay群集时需要对nDisplay Root Actor使用的全部设置。

## nDisplay Root Actor设置

要使用nDisplay Root Actor的设置，在 **世界大纲视图** 中选中nDisplay Root Actor，找到其 **细节** 面板。

以下部分说明了nDisplay Root Actor的设置。

### 视口

| 参数 | 说明 |
| --- | --- |
| **视口屏幕百分比系数（Viewport Screen Percentage Multiplier）** | 该参数定义了视口的分辨率。1.0表示全分辨率。 在复杂的大型群集渲染设置下，我们建议降低这一数值，以提升编辑器在预览过程中的帧率。降低数值会降低显示内容的分辨率。 |
| **视口屏幕百分比（Viewport Screen Percentage）** | 显示了nDisplay群集的所有视口的下拉菜单部分。设置每个视口的视口屏幕百分比。每个视口的屏幕百分比设置会与 **视口屏幕百分比系数** 结合，以确定分辨率。 对于仅在镜头内视效摄制时用于光照的视口而言非常实用。你通常要为天花板显示屏选择较低的分辨率，除非场景中需要它们的高质量反射。 |
| **视口过扫描（Viewport Overscan）** | 启用视口过扫描后，虚幻引擎渲染的帧数将高于视口的指定帧数，以便在使用后期处理效果时确保各个屏幕之间的连续性。请参考[过扫描支持](../ndisplay-overscan/index.md)，了解nDisplay过扫描支持的详细信息。 展开下拉菜单，显示nDisplay群集中所有的视口，并更改每一个视口的过扫描设置。请浏览下文的各视口过扫描设置，以了解各个视口的选项。 |
| **冻结视口（Freeze Viewports）** | 冻结显示外部视锥体的视口的渲染。禁用后可以提高性能。 |
| **对整体群集隐藏内容（Content Hidden from Entire Cluster）** | 添加到此数组中的内容不会显示在群集的任何显示器中，如果启用也不会显示在内视锥体上。内容可以通过指定[图层](../../../../building-virtual-worlds/level-editor/layers-panel/index.md)添加，或通过单独的Actor添加。 适合在项目中拥有不想通过nDisplay显示的Actor时使用。例如，如果你要在镜头内视效摄制期间使用Actor进行追踪、不想让Actor显示出来，但需要使用Composure进行合成的时候。 |
| **对视口隐藏内容（Content Hidden from Viewports）** | 添加到此数组中的内容不会显示在外部视锥体上，但如果启用则可以显示在内视锥体上。内容可以通过指定[图层](../../../../building-virtual-worlds/level-editor/layers-panel/index.md)添加，或通过单独的Actor添加。 |

#### 各视口过扫描设置

| 参数 | 说明 |
| --- | --- |
| **启用（Enable）** | 启用或禁用视口的过扫描。 |
| **模式（Mode）** | 选择过扫描的单位，选项包括： 百分比 像素 |
| **适应分辨率（Adapt Resolution）** | 启用时，渲染输出的分辨率会根据以下设置而提高。 禁用时，渲染输出会根据视口的原分辨率进行缩放，以达到下列设置中的尺寸。 该选项默认启用。 |
| **左侧（Left）** | 如果启用过扫描，使渲染器 **左侧** 的分辨率提高这一数值。取决于选择的 **模式**，单位为像素或百分比。 |
| **右侧（Right）** | 如果启用过扫描，使渲染器 **右侧** 的分辨率提高这一数值。取决于选择的 **模式**，单位为像素或百分比。 |
| **顶部（Top）** | 如果启用过扫描，使渲染器 **顶部** 的分辨率提高这一数值。取决于选择的 **模式**，单位为像素或百分比。 |
| **底部（Bottom）** | 如果启用过扫描，使渲染器 **底部** 的分辨率提高这一数值。取决于选择的 **模式**，单位为像素或百分比。 |

### 镜头内视效

| 参数 | 说明 |
| --- | --- |
| **启用内视锥体** | 如果你希望使用nDisplay设置的内视锥体，则可启用该选项。禁用该选项将覆盖单个ICVFX摄像机的[内视锥体设置](#icvfxcamcomp)。 拥有多个摄像机时，禁用该选项会禁用所有的内视锥体。 |
| **内视锥体优先级** | 当显示器中拥有多个ICVFX摄像机，并且内视锥体为重叠式，该列表确定了在顶部渲染的摄像机内视锥体。优先级由列表的顺序决定，第一个摄像机拥有最高优先级。 |

### 颜色分级

该部分说明了nDisplay中的颜色分级设置。请查看[nDisplay的颜色管理](../color-management-in-ndisplay/index.md)，了解如何在项目中实用颜色分级。

| 参数 | 说明 |
| --- | --- |
| **启用整体群集颜色分级** | 启用时，对所有nDisplay视口与内视锥体应用 **整体群集** 部分的颜色分级设置。 颜色分级仅应用于nDisplay渲染器。不会更改编辑器中的项目颜色，或是[影片渲染队列](https://dev.epicgames.com/documentation/404)中的渲染器颜色。 |
| **整体群集（Entire Cluster）** | 展开该部分可查看颜色分级选项。查看[颜色校正](../../../../designing-visuals-rendering-and-graphics/post-process-effects/color-grading-and-the-filmic-tonemapper/index.md#colorcorrection)了解公开的颜色分级选项。 |
| **每个视口的颜色分级（Per-Viewport Color Grading）** | 参阅[每个视口的颜色分级](#per-viewportcolorgrading)了解详细信息。 |

#### 各视口颜色分级

你可以对单个视口或视口群组应用颜色分级设置。添加数组元素并修改下表中的设置，便可对特定视口应用颜色分级。

| 参数 | 说明 |
| --- | --- |
| **启用视口颜色分级** | 启用时，对所有 **视口应用颜色分级** 中的视口应用 **颜色分级** 的设置。 如果启用，颜色分级不会对显示在节点上的内视锥体应用。要只对一个内视锥体应用颜色分级，请查看ICVFX摄像机设置的[颜色分级](#innerfrustumcolorgrading)部分。 |
| **包括整体群集颜色分级** | 启用时，对特定视口应用 **整体群集** 中定义的颜色设置，随后应用 **颜色分级** 中定义的设置。 禁用时，**整体群集** 中定义的颜色分级设置不会被应用到视口中。如果启用了 **启用视口颜色分级**，**颜色分级** 中定义的设置依然会被应用到视口中。 |
| **颜色分级** | 展开该部分可查看颜色分级选项。查看[颜色校正](../../../../designing-visuals-rendering-and-graphics/post-process-effects/color-grading-and-the-filmic-tonemapper/index.md#colorcorrection)了解公开的颜色分级选项。 |
| **对视口应用颜色分级** | 颜色分级设置可以应用到多个视口中。为每个需要应用颜色设置的视口添加一个数组元素。 下拉菜单中显示的视口列表和nDisplay配置资产中定义的列表一致。 |

### OCIO

该部分说明了nDisplay中OpenColorO（OCIO）颜色管理系统的可用设置。查看[nDisplay的颜色管理](../color-management-in-ndisplay/index.md)，了解在项目中使用OpenColorIO的方法。

| 参数 | 说明 |
| --- | --- |
| **启用视口OCIO** | 启用时，对所有nDisplay视口应用OCIO配置。 如果启用，配置不会对显示在节点上的内视锥体应用。要只对一个内视锥体应用一个OCIO配置，请查看ICVFX摄像机组件中设置的[OCIO](#ocio_params)部分。 此处设置的OpenColorIO配置仅应用于nDisplay渲染器。不会更改编辑器中的项目颜色，或是[影片渲染队列](https://dev.epicgames.com/documentation/404)中的渲染器颜色。 如果你已经对项目应用了OCIO配置，这会覆盖nDisplay视口的设置。 |
| **所有视口颜色配置** | 展开该部分以设置 **配置源**，**源颜色空间** 和 **目标颜色空间**。查看[OpenColorIO的颜色管理](../../../managing-color/color-management-with-opencolorio/index.md)，了解在项目中使用OpenColorIO的详情。 |
| **各视口OCIO覆盖** | 你可以对单个视口或视口群组应用OCIO设置。添加数组元素并修改各视口数组元素的设置，便可对特定视口应用颜色分级。 |

#### 逐视口OCIO覆盖数组元素

| 参数 | 说明 |
| --- | --- |
| **启用各视口OCIO** | 启用后，对所有对 **视口应用OCIO（Apply OCIO to Viewports）** 中的视口应用 **视口OCIO（Viewport OCIO）** 的设置。 如果你已经对项目或所有nDisplay视口应用了OCIO配置，这会覆盖 **视口应用OCIO（Apply OCIO to Viewports）** 中定义的nDisplay视口的设置。 如果启用，配置不会对显示在节点上的内视锥体应用。要只对一个内视锥体应用OCIO配置，请查看ICVFX摄像机组件设置的[OCIO](#ocio_params)部分。 |
| **视口OCIO** | 展开该部分以设置 **配置源**，**源颜色空间** 和 **目标颜色空间**。查看[OpenColorIO的颜色管理](../../../managing-color/color-management-with-opencolorio/index.md)，了解在项目中使用OpenColorIO的详情。 |
| **视口应用OCIO** | OCIO设置可以应用于多个视口。为每个需要应用OCIO设置的视口添加一个数组元素。 下拉菜单中显示的视口列表和nDisplay配置资产中定义的列表一致。 |

### 发光板

| 参数 | 说明 |
| --- | --- |
| **启用发光板（Enable Light Cards）** | 启用时，所有发光板内容中定义的发光板都会显示在nDisplay视口中。 |
| **混合模式（Blending Mode）** | 与内视锥体重叠时，发光板有两种渲染模式： **发光板在视锥体上：**重叠时，发光板渲染器覆盖在内视锥体上。 **发光板在视锥下：**重叠时，发光板渲染器隐藏在内视锥体下。 |
| **发光板内容（Light Cards Content）** | 发光板可以通过指定[图层](../../../../building-virtual-worlds/level-editor/layers-panel/index.md)添加，或通过单独的Actor添加。 |

### 编辑器预览

| 参数 | 说明 |
| --- | --- |
| **启用编辑器预览** | 启用时，虚幻项目的预览会出现在关卡视口的nDisplay Root Actor网格体上。nDisplay Root Actor中定义的颜色管理选项和其他设置都会出现在预览中。 该选项默认启用。如果你无需再关卡视口中预览并需要改善性能，我们建议禁用该选项。 |
| **预览屏幕百分比** | 该参数定义了预览纹理分辨率的缩放值。 |
| **启用后期处理** | 启用后，会将后期处理设置应用到关卡视口的nDisplay预览中。 |
| **冻结编辑器预览** | 启用后，nDisplay的视口渲染会在关卡视口中冻结。 |
| **启用摄像机视锥体** | 启用后，将能看到内部视锥体，以ICVFXCamera为原点。 |
| **摄像机视锥体距离** | 该参数定义·内部视锥体能够渲染的最大距离。 |
| **预览节点** | 该参数定义了关卡视口中预览的节点。选项包括 **无**、**全部** 或nDisplay群集中的特定群集节点。 |
| **渲染模式** | 该参数定义了nDisplay群集预览的渲染模式。选项包括： 单个（Mono） 立体：并排 立体：垂直排列 查看[nDisplay中的立体渲染](../stereoscopic-rendering-with-ndisplay/index.md)，了解更多关于选项的信息。 |
| 高级 |  |
| **每帧Tick数** | 该参数定义了编辑器预览的更新时间间隔。 |
| **每帧视口数** | 该参数定义了编辑器预览中每帧渲染的视口数。如果设定值比群集中的视口少，那么该参数指定的视口数会逐帧更新。 例如，如果每帧视口数设为1，而群集有两个视口（VP0, VP1)，那么预览视口会用多个帧来更新：第0帧是VP0，第1帧是VP1，第2帧是VP0，以此类推。 如果每帧视口数值比群集中的视口多，那么在一帧中每个视口都会更新一次。对于比较大的群集，更新每一个视口可能会消耗大量资源，所以可以通过修改该参数来改善性能。 |
| **预览材质最大大小** | 该参数定义了预览纹理的最大大小。默认值为2048。当你的视口较大时，修改该参数可以节约内存。 |

## 镜头内视效摄像机组件设置

要使用nDisplay Root Actor的ICVFX摄像机组件设置：

- 在

  世界大纲视图

  中选择nDisplay Root Actor，打开

  细节

  面板。
- 在nDisplay Root Actor的

  细节

  面板中，在组件部分下选中

  ICVFX摄像机组件

  ，打开其

  细节

  面板。

以下部分明了nDisplay Root Actor的ICVFX摄像机组件的设置。

### 镜头内视效

| 参数 | 说明 |
| --- | --- |
| **启用内视锥体** | 启用时，在nDisplay群集中显示这一ICVFX摄像机的内视锥体。 |
| **电影摄像机Actor** | 为该参数分配电影摄像机Actor时，该摄像机将用于渲染内视锥体，而非默认的nDisplay摄像机。 |
| **内视锥体百分比** | 该参数定义了内视锥体分辨率的比例系数。1.0等同于全分辨率。 |
| **Inner Frustum Overscan** | Refer to [Inner Frustum Overscan](#innerfrustumoverscan) for more details. |
| **柔化边缘** | 这些参数定义了羽化的边缘比例。你可以分别设置边缘的 **顶部与底部** 和 **侧边**。 可以在镜头内视效摄制中羽化内视锥体的边缘，使反射中不会出现硬线。 |
| **Inner Frustum Border** | These parameters create a border around the inner frustum. You can set Border Width and Border Color to customize the border's appearance. |
| **内视锥体旋转** | 应用于内视锥体的旋转偏移。 |
| **内视锥体偏移** | 应用于内视锥体的平移偏移。 |
| **Mipmap** | 当内视锥体较小时，对于LED幕墙像素，相比于配置nDisplay进行渲染的分辨率，可以生成mipmap以产生更好地小型内视锥体。为内视锥体生成mipmap可能会轻微地影响性能。 要对内视锥体使用mipmap，需启用 **自动生成Mip**。你可以选择使用以下mip采样过滤： 最近 双线性 三线性 默认（来自纹理组） ICVFX摄像机默认选择 **自动生成Mip** 和 **三线性** 采样过滤。 |
| **摄像机运动模糊** | 查看[Camera Motion Blur](#cameramotionblur)了解详情。 |
| **对内视锥体隐藏内容** | 此处添加的所有Actor不会显示在内视锥体中。内容可以通过指定[图层](../../../../building-virtual-worlds/level-editor/layers-panel/index.md)添加，或通过单独的Actor添加。 |

#### 内视锥体过扫描

你可以按照方向指定内视锥体过扫描。对于摄像机内视效来说，该功能可以用于在特定方向上延申内视锥体来弥补运动摄像机的延迟，或者在内视锥体被部分阻挡的情况下减少其渲染大小。它的分辨率可选为自适应来保持同样的视觉质量。参考[过扫描支持](../ndisplay-overscan/index.md)来了解哪些功能支持过扫描。

| 参数 | 描述 |
| --- | --- |
| **预计过扫描分辨率（Estimated Overscan Resolution）** | 该参数显示输出的分辨率，不一定符合比例。修改以下过扫描设置时，该分辨率会显示变动。 例如，如果渲染目标分辨率为3840 x 2160，**过扫描乘数（Overscan Multiplier）** 设为2，那么 **预计过扫描分辨率（Estimated Overscan Resolution）** 为7680 x 4320。 |
| **内视锥体分辨率（Inner Frustum Resolution）** | 该参数显示渲染目标的分辨率，在nDisplay配置资产中定义。启用自适应分辨率（Adapt Resolution）后，该分辨率会显示以下过扫描设置进行的宽高比变动。 |
| **启用内视锥体过扫描（Enable Inner Frustum Overscan）** | 启用后，会将过扫描应用到内视锥体上。 |
| **自适应分辨率（Adapt Resolution）** | 启用后，渲染目标的分辨率会按照以下的过扫描设置变化。 禁用后，渲染输出会以原始分辨率为基础进行缩放来达到以下设置的大小。 该选项默认禁用。 |
| **过扫描倍数（Overscan Multiplier）** | 按照该倍数设置ICVFX摄像机的视野大小。这样可以扩大内视锥体的大小来为移动摄像机造成的延迟提供缓冲。 |
| **过扫描单位（Overscan Units）** | 选择过扫描的单位，选项包括： 百分比 像素 |
| **左侧（Left）** | 如果启用过扫描，使渲染器左侧的分辨率提高这一数值。取决于选择的过扫描单位（Overscan Units），单位为像素或百分比。 |
| **右侧（Right）** | 如果启用过扫描，使渲染器右侧的分辨率提高这一数值。取决于选择的过扫描单位（Overscan Units），单位为像素或百分比。 |
| **顶部（Top）** | 如果启用过扫描，使渲染器顶部的分辨率提高这一数值。取决于选择的过扫描单位（Overscan Units），单位为像素或百分比。 |
| **底部（Bottom）** | 如果启用过扫描，使渲染器底部的分辨率提高这一数值。取决于选择的过扫描单位（Overscan Units），单位为像素或百分比。 |

#### 摄像机运动模糊

在nDisplay渲染中设置运动模糊。参考[摄像机运动模糊](../camera-motion-blur-with-ndisplay/index.md)来了解如何在项目中使用运动模糊。

| 参数 | 说明 |
| --- | --- |
| **运动模糊模式** | 指定内视锥体的运动模糊模式，以及对摄像机运动的修正方式。如果已经对内视锥体应用了摄像机模糊，摄像机运动产生的模糊将在物理曝光图像中错误地翻倍。 模式共有三种： **ICVFX摄像机模糊关闭：**去除ICVFX摄像机相对于nDisplay根的运动产生的模糊，但保留对象运动和nDisplay根移动产生的模糊，可以通过动画表现出载具在环境中的运动。 **ICVFX摄像机模糊开启：**允许摄像机运动产生的模糊。该选项通常不会用于摄像机设置，但可以用于问题诊断。 **所有摄像机模糊关闭：**去除ICVFX摄像机的所有全局运动产生的模糊，但保留对象运动产生的模糊。 默认选择 **ICVFX摄像机模糊关闭**。 |
| **平移缩放** | 该参数定义了用于生成运动模糊所需缩放的平移比例。 |
| **运动模糊设置覆盖** |  |
| **启用设置覆盖** | 如果启用，将覆盖当前后期处理体积或动画摄像机的综合运动模糊设置， |
| **量** | 该参数定义了运动模糊的强度。 |
| **最大** | 该参数定义了运动模糊产生的最大失真，形式为屏幕宽度百分比。 |
| **逐对象尺寸** | 该参数定义了在velocity pass中绘制图元时最低的投射屏幕半径。该参数的形式为屏幕宽度百分比。数字越小，绘制调用就越多。 默认值为 **4%**。 |

### 内视锥体颜色分级

| 参数 | 说明 |
| --- | --- |
| All Nodes |  |
| **启用全部节点颜色分级** | 启用时，对内视锥体应用 **颜色分级** 部分的颜色分级设置。 颜色分级仅用于 nDisplay 渲染画面。 |
| **包括整体群集颜色分级** | 启用时，对内视锥体应用nDisplay Root Actor的[整体群集](#entirecluster)部分的颜色分级设置。 |
| **颜色分级** | 展开该部分可查看颜色分级选项。查看[颜色校正](../../../../designing-visuals-rendering-and-graphics/post-process-effects/color-grading-and-the-filmic-tonemapper/index.md#colorcorrection)了解公开的颜色分级选项。 |
| Per-Node Color Grading |  |
| **Enable Per-Node Color Grading** | 启用时，当内视锥体出现在 **对节点应用颜色分级** 定义的群集节点上时，对内视锥体应用 **颜色分级** 部分的颜色分级设置。 在nDisplay群集中控制内视锥体的最精细的尺度为各个节点。这是因为启用mGPU时，内视锥体可以在多个视口中共享。 颜色分级仅应用于nDisplay渲染器。 |
| **包括整体群集颜色分级** | 启用时，当内视锥体出现在 **对节点应用颜色分级** 定义的群集节点上时，对内视锥体应用nDisplay Root Actor的[整体群集](#entirecluster)部分的颜色分级设置。 |
| **包括全部节点颜色分级** | 启用时，当内视锥体出现在 **对节点应用颜色分级** 定义的群集节点上时，对内视锥体应用ICVFX摄像机组件的[所有节点](#allnodes)部分的颜色分级设置。 |
| **颜色分级** | 展开该部分可查看颜色分级选项。查看[颜色校正](../../../../designing-visuals-rendering-and-graphics/post-process-effects/color-grading-and-the-filmic-tonemapper/index.md#colorcorrection)了解公开的颜色分级选项。 |
| **对节点应用颜色分级** | 颜色分级设置可应用于多个群集节点。为每个需要应用颜色分级设置的群集节点添加一个数组元素。 下拉菜单中显示的群集节点列表和nDisplay配置资产中定义的列表一致。 |

### OCIO

| 参数 | 说明 |
| --- | --- |
| **启用内视锥体OCIO** | 启用时，对内视锥体应用 **所有节点颜色配置** 部分的OCIO配置。 如果你已经对项目应用了OCIO配置，这会覆盖内视锥体的设置。 OCIO设置仅应用于nDisplay渲染器。 |
| **所有节点颜色配置** | 展开该部分以设置 **配置源**、**源颜色空间** 和 **目标颜色空间**。查看[OpenColorIO的颜色管理](../../../managing-color/color-management-with-opencolorio/index.md)，了解在项目中使用OpenColorIO的详情。 |
| **各节点OCIO覆盖** | OCIO设置可应用于多个群集节点。为每个需要应用OCIO设置的群集节点添加一个数组元素。 下拉菜单中显示的群集节点列表和nDisplay配置资产中定义的列表一致。 在nDisplay群集中控制内视锥体的最精细的尺度为各个节点。这是因为启用mGPU时，内视锥体可以在多个视口中共享。 |

#### 逐节点OCIO覆盖

| 参数 | 说明 |
| --- | --- |
| **启用各节点OCIO** | 启用时，当内视锥体出现在 **对节点应用OCIO** 定义的群集节点上时，对内视锥体应用 **内视锥体OCIO** 部分的OCIO配置。 如果你已经对项目或所有群集节点的内视锥体应用了OCIO配置，这会覆盖对节点应用OCIO中定义的、会显示在群集节点上的内视锥体设置。 OCIO设置仅应用于nDisplay渲染器。 |
| **内视锥体OCIO** | 展开该部分以设置 **配置源**、**源颜色空间** 和 **目标颜色空间**。查看[OpenColorIO的颜色管理](../../../managing-color/color-management-with-opencolorio/index.md)，了解在项目中使用OpenColorIO的详情。 |
| **对节点应用OCIO** | OCIO配置可以应用于多个群集节点。为每个需要应用这些设置的群集节点添加一个数组元素。 下拉菜单中显示的群集节点列表和nDisplay配置资产中定义的列表一致。 |

### 色键抠像

| 参数 | 说明 |
| --- | --- |
| **启用内视锥体色键抠像（Enable Inner Frustum Chromakey）** | 启用时，将整个内视锥体变为 **色键抠像颜色** 中定义的纯色。如果启用 **色键抠像标记** 则对其应用。 通常使用该设置，在镜头内视效摄制期间，为显示屏应用绿幕和追踪标记。由于只改变了内视锥体，外视锥可以在摄制期间继续用于反射。 |
| **色键抠像颜色（Chromakey Color）** | 该参数定义了色键抠像使用的颜色。 |
| **色键抠像标记** |  |
| **启用色键抠像标记（Enable Chromakey Markers）** | 启用时，对内视锥体的色键抠像内容生成并应用追踪标记。 |
| **标记颜色（Marker Color）** | 该参数定义了追踪标记的颜色。 |
| **标记平铺RGBA（Marker Tile RGBA）** | 该参数定义了追踪标记使用的纹理。默认分配带有加号图表的纹理。 |
| **标记缩放（Marker Scale）** | 该参数定义了追踪标记的尺寸。 |
| **标记平铺距离（Marker Tile Distance）** | 该参数定义了追踪标记之间的距离。 |
| **标记平铺偏移（Marker Tile Offset）** | 该参数定义了应用于追踪标记默认位置的偏移。 |
| **自定义色键抠像** |  |
| **使用自定义色键抠像（Use Custom Chromakey）** | 启用时，仅将 **自定义色键抠像** 定义的内容变为 **色键抠像颜色**，并且内容出现在内视锥体上时应用 **色键抠像标记**。内容在外视锥上隐藏，只出现在内视锥体上。 该设置用于绿幕光晕。 |
| **自定义色键抠像内容（Custom Chromakey Content）** | 内容可以通过指定[图层](../../../../building-virtual-worlds/level-editor/layers-panel/index.md)，添加，或通过单独的Actor添加。 |
| **后期处理模糊（Post Process Blur）** | 你可以选择对 **自定义色键抠像** 内容中定义的内容应用模糊。 **后期处理模糊** 可以设置为三种模式： 无 高斯 膨胀 对于 **高斯** 和 **膨胀**，你可以设置 **内核半径** 和 **缩放** 来改变效果外观。 |

### 纹理替换

| 参数 | 说明 |
| --- | --- |
| **启用视口纹理替换** | 启用时，使用 **源纹理** 定义的纹理替换内视锥体。纹理会跟随摄像机移动。 如果将整个内视锥体用于色键抠像，则无法看见替换效果。 |
| **源纹理** | 勾选 **启用视口纹理替换** 时应用于内视锥体的纹理。 |
| **使用纹理裁剪** | 启用时，仅使用 **源纹理** 的 **纹理裁剪** 所定义的长方形。 |
| **纹理裁剪** |  |
| **纹理裁剪原点** | 使用 **X** 和 **Y** 参数定义长方形的左上角。 |
| **纹理裁剪尺寸** | 使用 **W** 和 **H** 参数定义长方形起点处的宽度和高度。 |

