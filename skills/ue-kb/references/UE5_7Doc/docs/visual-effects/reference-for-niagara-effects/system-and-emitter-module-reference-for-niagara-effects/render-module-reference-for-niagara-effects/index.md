---
title: "Niagara渲染器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/render-module-reference-for-niagara-effects-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建视觉效果", "Niagara参考页面", "Niagara系统和发射器模块参考", "Niagara渲染器"]
---

# Niagara渲染器

> 路径：虚幻引擎5.7文档 / 创建视觉效果 / Niagara参考页面 / Niagara系统和发射器模块参考 / Niagara渲染器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/render-module-reference-for-niagara-effects-in-unreal-engine

Niagara渲染器说明虚幻引擎应该如何显示每个生成的粒子。注意，这不一定是可视的。与模块不同，渲染器在堆栈中的位置不一定与绘制顺序相关。目前支持五种渲染器类型：

- 组件渲染器（Component Renderer）
- 光源渲染器（Light Renderer）
- 网格体渲染器（Mesh Renderer）
- 条带渲染器（Ribbon Renderer）
- Sprite渲染器（Sprite Renderer）
- 贴花渲染器（Decal Renderer）

![在Niagara编辑器中添加渲染模块](../../../../../assets/images/36/36aa3e0d494eea5429273d39ad907f9c0da5205b84f17464c96b8bfbca5d84cd.jpg)

以下部分列出了每种渲染器类型中可用的参数，以及该参数的作用说明。

## 组件渲染器

> [!WARNING]
> 功能有时是实验版的，因此你可以试用，提供反馈，并了解我们的计划。 **我们不推荐发布包含实验性功能的项目。**请记住，我们不保证在实验阶段创建的资产向后兼容，这些功能的API可能会改变，我们可能会根据自身判断删除整个实验版功能或特定功能。

**组件渲染器（Component Renderer）** 可生成任何类型的组件，并使用粒子模拟中的数据更新其属性。

使用 **组件类型（Component Type）** 设置粒子模拟使用的组件（例如，点光源），并在 **细节（Details）** 面板的 **组件属性（Component Properties）** 类别下显示与之相关的属性和设置。可以直接从此列表中编辑属性，所有由渲染器生成的组件都将基于这些属性构建。

要将粒子数据注入到组件中，请使用属性右侧的下拉菜单，并选择要绑定到该属性的粒子属性（见下例）。某些组件类型需要特殊的类作为父项，这意味着不能与组件渲染器一起工作，它们必须是 **SceneComponent** 的子类，可以是C++类或蓝图。以 **地形组件（Landscape Component）** 为例，它需要 **LandscapeProxy Actor** 作为父项。

![组件属性下拉菜单](../../../../../assets/images/d9/d9325adf7a1e5c9f25ea0ffd599b7fa31730d4b5d61d4caabc02afa4faa589f6.jpg)

显示的示例使用点光源组件。显示的属性会随所选组件而异。

因为配置的绑定会在粒子模拟完成后的每一个更新函数结束时进行评估和更新，所以组件渲染器的运行开销会很大。要谨慎使用。

> [!NOTE]
> 目前仅可绑定基本的Niagara数据类型（浮点、布尔、向量等）结构体、对象和枚举属性都可动态设置。

在Niagara系统中使用组件时，最好保留尽可能少的组件数（除非所在工作环境并不太注重性能，例如用Sequencer渲染的过场动画）。由于除了Niagara系统之外，每个组件在每一帧都有自己的更新函数，因此使用组件渲染器生成大量效果时会影响性能。

如果组件没有公开属性，或者要绑定到的组件位于嵌套结构体内，则可创建该组件的自定义子类并自己添加属性。例如，因为使用了自定义的FLightingChannels结构体而不能将某个值绑定到点光源组件的光照通道。

![无合适的绑定可用消息](../../../../../assets/images/3a/3a07afdff3369541ddbd9c26212f5fc383e9a09f7d1384971a9a921b1a9fe82e.png)

但是，你可以将点光源组件作为子类，并自己添加通道属性，然后在组件的更新函数上设置活动的光照通道，如下例：

![Adding channel properties in a blueprint](../../../../../assets/images/4b/4b38bdafb993c29769a57cfe99acfafcd86fce2355cfb7c7df193ed48816e651.jpg)

点击查看大图。

这样你就可以把粒子值绑定到组件渲染器中的属性上。

以下属性是设置 **组件类型（Component Type）** 之前组件渲染器的一部分。

| 参数 | 说明 |
| --- | --- |
| **组件类型（Component Type）** | 使用此渲染器生成的场景组件类。 |
| **组件数限制（Component Count Limit）** | 此发射器每帧会生成或更新的最大组件数。 |
| **启用绑定（Enabled Binding）** | 确定使用哪个属性来检查是否应该为粒子启用组件渲染。这可以用来控制每个粒子的生成速率。如果绑定不存在，所有粒子都生成一个组件。 |
| **按粒子ID分配组件（Assign Components on Particle ID）** | 如果为true，则组件不会自动分配到第一个可用粒子，而是尝试始终关联到一个特定粒子。禁用此选项可以加快速度，但粒子可能每次更新函数都会获得一个不同的组件，这可能带来动态模糊或闪烁等问题。 |
| **仅在生成的粒子上创建组件（Only Create Components on Particle Spawn）** | 如果为true，则新组件仅可在新生成的粒子上创建。如果一个粒子不能在第一个帧上创建组件（例如，因为达到了组件上限），则它将被阻止在后续帧上生成组件。 |
| **可视化组件（Visualize Components）** | 如果为true，则将为该组件启用编辑器可视化；此参数对已发布的游戏无影响。例如，启用此选项后，光照组件会在编辑器视口中显示活动边界。 |

## 光源渲染器

Niagara光源渲染模块拥有下列基本参数。

| 参数 | 描述 |
| --- | --- |
| 光源渲染 |  |
| **使用平方反比（Use Inverse Squared）** | 此参数定义是否使用基于物理的从光源平方反比衰减。如未选中此参数，则使用 **光源指数绑定（Light Exponent Binding）** 的值。 禁用 **平方反比衰减（Inverse Squared Falloff）** 时，将使用线性衰减。线性衰减使用起来往往比较简单，但可能造成过于明亮的结果。平方反比衰减可产生更逼真的亮度水平。 |
| **影响半透明度（Affects Translucence）** | 此参数确定此渲染器中的光源是否会影响半透明度。谨慎使用：如启用此参数，只可创建少数粒子光源；光源越大、数量越多，开销就越高。 |
| **半径缩放（Radius Scale）** | 此因子用于缩放每个粒子光源的半径。 |
| **颜色增益（Color Add）** | 这是应用于每个渲染光源的静态色移。可设置 **X** 、 **Y** 和 **Z** 轴的值。这些轴对应 **R** 、 **G** 和 **B** 颜色值（ **X=R，Y=G，Z=B** ），而不表示位置。 |
| 排序顺序 |  |
| **排序顺序提示（Sort Order Hint）** | 默认情况下将按发射器添加到Niagara系统中堆栈的顺序来绘制发射器。可以用 **排序顺序提示（Sort Order Hint）** 值来以更精细的方式控制绘制顺序。相同类型的材质将按照系统中的排序顺序值从低到高绘制。默认值为 **0** 。 |
| 绑定 |  |
| **光源渲染启用绑定（Light Rendering Enabled Binding）** | 此参数定义用于检查是否应该为某个粒子启用光源渲染的属性。默认情况下，此参数使用 **Particles.LightEnabled** 变量，如该变量不存在，则使用默认值 **None** 。 |
| **光源指数绑定（Light Exponent Binding）** | 此参数定义禁用 **平方反比衰减** 时用于光源指数的属性。默认情况下，此参数使用变量 **Particles.LightExponent** ，如该变量不存在，则使用默认值 **10** 。 |
| **位置绑定（Position Binding）** | 此参数定义在生成光源时用于定位的属性。默认情况下，此参数使用 **Particles.Position** 变量，如该变量不存在，则使用默认变量 **Engine.Owner.Position** 。可以使用其他任何兼容类型的属性，但下拉菜单中的可用选项对此绑定可能有作用，也可能没有作用。 |
| **颜色绑定（Color Binding）** | 此参数定义在生成光源时用于颜色的属性。默认情况下，此参数使用 **Particles.Color** 变量，如该变量不存在，则使用默认值 **R:1, G:1, B:1, A:1** 。 |
| **半径绑定（Radius Binding）** | 此参数定义在生成光源时用于光源半径的属性。默认情况下，此参数使用 **Particles.LightRadius** 变量，如该变量不存在，则使用默认值 **100** 。可以使用其他任何兼容类型的属性，但下拉菜单中的可用选项对此绑定可能有作用，也可能没有作用。 |
| **体积散射绑定（Volumetric Scattering Binding）** | 此参数定义用于此光源的体积散射强度的属性。其可调整光源强度和颜色的比例。默认情况下，此参数使用 **Particles.LightVolumetricScattering** 变量，如该变量不存在，则使用默认值 **1** 。 |

## 网格体渲染器

网格体渲染器拥有下列基本参数。

| 参数 | 描述 |
| --- | --- |
| 网格体渲染 |  |
| **粒子网格体（Particle Mesh）** | 此参数确定在渲染网格体粒子时将被实体化的静态网格体。默认情况下将使用该静态网格体的材质。该材质必须选中 **Niagara网格体粒子（Niagara Mesh Particles）** 标志。 |
| **覆盖材质（Override Materials）** | 被选中时，此参数定义一个代替静态网格体的材质使用的材质排列。所有覆盖材质都必须选中 **Niagara网格体粒子（Niagara Mesh Particles）** 标志。如果粒子网格体需要的材质多于此排列中存在的材质，或此排列中有任意条目被设为 **无（None）** ，则发射器将使用粒子网格体的现有材质取代之。 |
| **朝向模式（Facing Mode）** | 此设置确定实例化网格体如何相对于摄像机调整自身朝向： **默认（Default）** ：完全忽略摄像机。按 **Particles.Transform** 向量（如果存在）变换后，网格体将其本地空间X轴与粒子的本地空间X轴对齐。 **速度（Velocity）** ：网格体将其本地空间X轴与粒子的 **Particles.Velocity** 向量对齐。 **摄像机位置（Camera Position）** ：网格体本地空间X轴指向摄像机。 **摄像机平面（Camera Plane）** ：网格体本地空间X轴指向摄像机视平面上最近的点。 |
| 排序 |  |
| **排序模式（Sort Mode）** | 此参数确定渲染前如何对粒子排序。选项有： **无（None）** ：不进行粒子排序。 **查看深度（View Depth）** ：按到摄像机近端平面的深度来排序。 **查看距离（View Distance）** ：按到摄像机原点的距离来排序。 **自定义升序（Custom Ascending）** ：按每个粒子的属性排序，值较低者先于值较高者渲染。 **自定义降序（Custom Descending）** ：按每个粒子的属性排序，值较高者先于值较低者渲染。 |
| **仅在半透明时进行排序（Sort Only When Translucent）** | 如选中此项，则仅在使用半透明材质时对粒子排序。 |
| 绑定 |  |
| **位置绑定（Position Binding）** | 此参数定义在生成实例化网格体时用于定位的属性。默认情况下，此参数使用 **Particles.Position** 变量，如该变量不存在，则使用默认变量 **Engine.Owner.Position** 。可以使用其他任何兼容类型的属性，但下拉菜单中的可用选项对此绑定可能有作用，也可能没有作用。 |
| **颜色绑定（Color Binding）** | 此参数定义在生成实例化网格体时用于颜色的属性。默认情况下，此参数使用 **Particles.Color** 变量，如该变量不存在，则使用默认值 **R:1, G:1, B:1, A:1** 。 |
| **速度绑定（Velocity Binding）** | 此参数定义在生成实例化网格体时用于速度的属性。默认情况下，此参数使用 **Particles.Velocity** 变量，如该变量不存在，则使用默认值 **X:0, Y:0, Z:0** 。可以使用其他任何兼容类型的属性，但下拉菜单中的可用选项对此绑定可能有作用，也可能没有作用。 |
| **网格体朝向绑定（Mesh Orientation Binding）** | 此参数定义在生成实例化网格体时用于网格体朝向的属性。默认情况下，此参数使用 **Particles.MeshOrientation** 变量，如该变量不存在，则使用默认值 **X:0, Y:0, Z:0, W:1** 。 |
| **缩放绑定（Scale Binding）** | 此参数定义在生成实例化网格体时用于缩放的属性。默认情况下，此参数使用 **Particles.Scale** 变量，如该变量不存在，则使用默认值 **X:1, Y:1, Z:1** 。可以使用其他任何兼容类型的属性，但下拉菜单中的可用选项对此绑定可能有作用，也可能没有作用。 |
| **动态材质绑定（Dynamic Material Binding）** | 此参数定义在生成实例化网格体时用于动态材质参数的属性。默认情况下，此参数使用 **Particles.DynamicMaterialParameter** ，如该变量不存在，则使用默认值 **X:1, Y:1, Z:1, W:1** 。 |
| **动态材质1绑定（Dynamic Material 1Binding）** | 此参数定义在生成实例化网格体时用于动态材质参数的属性。默认情况下，此参数使用 **Particles.DynamicMaterialParameter1** ，如该变量不存在，则使用默认值 **X:1, Y:1, Z:1, W:1** 。 |
| **动态材质2绑定（Dynamic Material 2Binding）** | 此参数定义在生成实例化网格体时用于动态材质参数的属性。默认情况下，此参数使用 **Particles.DynamicMaterialParameter2** ，如该变量不存在，则使用默认值 **X:1, Y:1, Z:1, W:1** 。 |
| **动态材质3绑定（Dynamic Material 3Binding）** | 此参数定义在生成实例化网格体时用于动态材质参数的属性。默认情况下，此参数使用 **Particles.DynamicMaterialParameter3** ，如该变量不存在，则使用默认值 **X:1, Y:1, Z:1, W:1** 。 |
| **材质随机绑定（Material Random Binding）** | 此参数定义在生成实例化网格体时用于材质随机的属性。默认情况下，此参数使用 **Particles.MaterialRandom** 变量，如该变量不存在，则使用默认值 **0** 。可以使用其他任何兼容类型的属性，但下拉菜单中的可用选项对此绑定可能有作用，也可能没有作用。 |
| **自定义排序绑定（Custom Sorting Binding）** | 此参数定义用于自定义排序的属性。默认情况下，此参数使用 **Particles.NormalizedAge** 变量，如该变量不存在，则使用默认值 **0** 。可以使用其他任何兼容类型的属性，但下拉菜单中的可用选项对此绑定可能有作用，也可能没有作用。 |
| **标准化年龄绑定（Normalized Age Binding）** | 此参数定义用于标准化年龄的属性。默认情况下，此参数使用 **Particles.NormalizedAge** 变量，如该变量不存在，则使用默认值 **0** 。可以使用其他任何兼容类型的属性，但下拉菜单中的可用选项对此绑定可能有作用，也可能没有作用。 |
| 排序顺序 |  |
| **排序顺序提示（Sort Order Hint）** | 默认情况下将按发射器添加到Niagara系统中堆栈的顺序来绘制发射器。可以用 **排序顺序提示（Sort Order Hint）** 值来以更精细的方式控制绘制顺序。相同类型的材质将按照系统中的排序顺序值从低到高绘制。默认值为 **0** 。 |

## 条带渲染器

Niagara条带渲染器拥有下列基本参数。

| 参数 | 描述 |
| --- | --- |
| 条带渲染 |  |
| **材质（Material）** | 选择用于渲染条带的材质。 |
| **朝向模式（Facing Mode）** | 此设置确定条带如何相对于摄像机调整自身朝向： **屏幕（Screen）** ：条带面向屏幕。 **自定义（Custom）** ：使用 **Particles.RibbonFacing** 作为朝向向量。 **自定义边向量（Custom Side Vector）** ：使用 **Particles.RibbonFacing** 作为边向量，并根据它计算朝向向量。 不支持在此模式下使用条带扭转。 |
| **UV0平铺距离（UV0 Tiling Distance）** | 此设置根据条带遍历的距离平铺UV通道0。这会按年龄来禁用UV的偏移。 |
| **UV0缩放（UV0 Scale）** | 此设置定义使用 **平铺距离（Tiling Distance）** 时UV通道0的缩放。 |
| **UV0偏移（UV0 Offset）** | 此设置定义使用 **平铺距离（Tiling Distance）** 时用于UV通道0的偏移。 |
| **UV0年龄偏移模式（UV0 Age Offset Mode）** | 此设置定义按年龄偏移UV通道0时使用的模式。在条带末端添加和删除粒子时，这可以实现平滑的纹理运动。使用 **条带链接顺序绑定（Ribbon Link Order Binding）** 或使用 **平铺距离（Tiling Distance）** 时，不会使用此参数。 |
| **UV1平铺距离（UV1 Tiling Distance）** | 此设置根据条带遍历的距离平铺UV通道1。这会按年龄来禁用UV的偏移。 |
| **UV1缩放（UV1 Scale）** | 此设置定义使用平铺距离（Tiling Distance）时UV通道1的缩放。 |
| **UV1偏移（UV1 Offset）** | 此设置定义使用平铺距离（Tiling Distance）时UV通道1的偏移。 |
| **UV1偏移模式（UV1 Offset Mode）** | 此设置定义按年龄偏移UV通道1时使用的模式。在条带末端添加和删除粒子时，这可以实现平滑的纹理运动。使用 **条带链接顺序绑定（Ribbon Link Order Binding）** 或使用 **平铺距离（Tiling Distance）** 时，不会使用此参数。 |
| **绘制方向（Draw Direction）** | 绘制方向决定是从前向后（从远离摄像机的点到靠近摄像机的点）还是从后向前（从靠近摄像机的点到远离摄像机的点）渲染条带。但这通常只有在材质是半透明的，以及条带折叠时才有区别。 |
| 曲面细分 |  |
| **曲线张力（Curve Tension）** | 此设置定义曲线张力，即曲线切线的长度。设置范围是 **0** 到 **1** 。该值越高，曲线越尖锐。 |
| **模式（Mode）** | 此设置定义允许自定义曲面细分参数的曲面细分模式，或完全禁止曲面细分： **自动（Automatic）** ：使用默认曲面细分参数。 **自定义（Custom）** ：允许自定义的曲面细分参数。 **已禁用（Disabled）** ：禁用曲面细分。 |
| **最大曲面细分因子（Max Tessellation Factor）** | 如 **模式（Mode）** 设为 **自定义（Custom）** ，则此参数将定义自定义曲面细分因子。设置范围是 **1** 到 **16** 。增加该值会增加曲面细分量。 |
| **使用常量因子（Use Constant Factor）** | 如选中此项，则使用 **最大曲面细分因子（Max Tessellation Factor）** 。否则会根据下面的参数相应选择曲面细分因子。 |
| **曲面细分角度（Tessellation Angle）** | 此设置定义发生曲面细分的角度（单位为度）。设置范围是 **1** 到 **180** 。减小该值会增加曲面细分量。如设为 **0** ，则会使用 **最大曲面细分因子（Max Tessellation Factor）** 。 |
| **屏幕空间（Screen Space）** | 如选中此项，则使用条带的屏幕空间比例相应调整曲面细分因子。 |
| 排序顺序 |  |
| **排序顺序提示（Sort Order Hint）** | 默认情况下将按发射器添加到Niagara系统中堆栈的顺序来绘制发射器。可以用 **排序顺序提示（Sort Order Hint）** 值来以更精细的方式控制绘制顺序。相同类型的材质将按照系统中的排序顺序值从低到高绘制。默认值为 **0** 。 |
| 绑定 |  |
| **位置绑定（Position Binding）** | 此参数定义在生成条带时用于定位的属性。默认情况下，此参数使用 **Particles.Position** 变量，如该变量不存在，则使用默认变量 **Engine.Owner.Position** 。可以使用其他任何兼容类型的属性，但下拉菜单中的可用选项对此绑定可能有作用，也可能没有作用。 |
| **颜色绑定（Color Binding）** | 此参数定义在生成条带时用于颜色的属性。默认情况下，此参数使用 **Particles.Color** 变量，如该变量不存在，则使用默认值 **R:1, G:1, B:1, A:1** 。 |
| **速度绑定（Velocity Binding）** | 此参数定义在生成条带时用于速度的属性。默认情况下，此参数使用 **Particles.Velocity** 变量，如该变量不存在，则使用默认值 **X:0, Y:0, Z:0** 。可以使用其他任何兼容类型的属性，但下拉菜单中的可用选项对此绑定可能有作用，也可能没有作用。 |
| **标准化年龄（Normalized Age）** | 此参数定义在生成条带时用于标准化年龄的属性。默认情况下，此参数使用 **Particles.NormalizedAge** 变量，如该变量不存在，则使用默认值 **0** 。可以使用其他任何兼容类型的属性，但下拉菜单中的可用选项对此绑定可能有作用，也可能没有作用。 |
| **条带扭转绑定（Ribbon Twist Binding）** | 此参数定义在生成条带时用于条带扭转的属性。默认情况下，此参数使用 **Particles.RibbonTwist** 变量，如该变量不存在，则使用默认值 **0** 。可以使用其他任何兼容类型的属性，但下拉菜单中的可用选项对此绑定可能有作用，也可能没有作用。 |
| **条带宽度绑定（Ribbon Width Binding）** | 此参数定义在生成条带时用于条带宽度的属性。默认情况下，此参数使用 **Particles.RibbonWidth** 变量，如该变量不存在，则使用默认值 **1** 。可以使用其他任何兼容类型的属性，但下拉菜单中的可用选项对此绑定可能有作用，也可能没有作用。 |
| **条带朝向绑定（Ribbon Facing Binding）** | 此参数定义在生成条带时用于条带朝向的属性。默认情况下，此参数使用 **Particles.RibbonFacing** 变量，如该变量不存在，则使用默认值 **X:0, Y:0, Z:1** 。可以使用其他任何兼容类型的属性，但下拉菜单中的可用选项对此绑定可能有作用，也可能没有作用。 |
| **条带ID绑定（Ribbon Id Binding）** | 此参数定义在生成条带时用于条带ID的属性。如存在 **Particles.RibbonID** 变量则使用它，否则使用默认值 **Index:0 AcquireTag:0** 。 |
| **条带链接顺序绑定（Ribbon Link Order Binding）** | 此参数定义在生成条带时用于条带链接顺序的属性。默认情况下，此参数使用 **Particles.RibbonLinkOrder** 变量，如该变量不存在，则使用默认值 **0** 。可以使用其他任何兼容类型的属性，但下拉菜单中的可用选项对此绑定可能有作用，也可能没有作用。 |
| **材质随机绑定（Material Random Binding）** | 此参数定义在生成条带时用于材质随机的属性。默认情况下，此参数使用 **Particles.MaterialRandom** 变量，如该变量不存在，则使用默认值 **0** 。可以使用其他任何兼容类型的属性，但下拉菜单中的可用选项对此绑定可能有作用，也可能没有作用。 |
| **动态材质绑定（Dynamic Material Binding）** | 此参数定义在生成实例化条带时用于动态材质参数的属性。如存在 **Particles.DynamicMaterialParameter** 则使用它，否则使用默认值 **X:1, Y:1, Z:1, W:1** 。 |
| **动态材质1绑定（Dynamic Material 1Binding）** | 此参数定义在生成实例化条带时用于动态材质参数的属性。如存在 **Particles.DynamicMaterialParameter1** 则使用它，否则使用默认值 **X:1, Y:1, Z:1, W:1** 。 |
| **动态材质2绑定（Dynamic Material 2Binding）** | 此参数定义在生成实例化条带时用于动态材质参数的属性。如存在 **Particles.DynamicMaterialParameter2** 则使用它，否则使用默认值 **X:1, Y:1, Z:1, W:1** 。 |
| **动态材质3绑定（Dynamic Material 3Binding）** | 此参数定义在生成实例化条带时用于动态材质参数的属性。如存在 **Particles.DynamicMaterialParameter3** 则使用它，否则使用默认值 **X:1, Y:1, Z:1, W:1** 。 |

## Sprite渲染器

Niagara Sprite渲染器拥有下列基本参数。

| 参数 | 描述 |
| --- | --- |
| Sprite渲染 |  |
| **材质（Material）** | 选择用于渲染粒子的材质。选择的材质必须勾选 **结合Niagara Sprite使用（Use with Niagara Sprites）** 标记。 |
| **对齐（Alignment）** | 此设置定义其他参数如何影响粒子对齐。举例而言，如设为 **未对齐（Unaligned）** ，则说明只有 **Particle.SpriteRotation** 和 **FacingMode** 参数会影响粒子的对齐。 |
| **朝向模式（Facing Mode）** | 此设置定义Sprite粒子如何相对于摄像机调整自身朝向。举例而言，如设为 **朝向摄像机（Face Camera）** ，则说明粒子的原点将固定尝试使其轴与摄像机的轴对齐。 |
| **自定义朝向向量遮罩（Custom Facing Vector Mask）** | 此参数作为逐轴插值因子配合 **CustomFacingVector** 模式使用，确定Sprite粒子如何使自身朝向摄像机。可单独设置 **X** 、 **Y** 和 **Z** 轴。设为 **1.0** 意味着Sprite粒子完全朝向自定义向量。设为 **0.0** 将使用标准朝向策略。 |
| **UV空间中的枢轴（Pivot in UVSpace）** | 此设置确定此粒子的枢轴点位置。其跟随虚幻引擎的UV空间，图像的左上角位于 **0,0** ，图像的右下角位于 **1,1** ，中点位于 **0.5,0.5** 。 |
| **移除头戴显示器Roll（Remove HMD Roll）** | 勾选此框即可移除VR中头戴显示器的Roll。 |
| **朝向相机最小混合距离（Minimum Facing Camera Blend Distance）** | FacingCameraDistanceBlend完全为FacingCamera的距离。 |
| **朝向相机最大混合距离（Maximum Facing Camera Blend Distance）** | FacingCameraDistanceBlend完全为FacingCameraPosition的距离。 |
| 排序 |  |
| **排序模式（Sort Mode）** | 此参数确定渲染之前粒子的排序方式。选项有： **无（None）** ：不进行粒子排序。 **查看深度（View Depth）** ：按到摄像机近端平面的深度来排序。 **查看距离（View Distance）** ：按到摄像机原点的距离来排序。 **自定义升序（Custom Ascending）** ：按每个粒子的属性排序，值较低者先于值较高者渲染。 **自定义降序（Custom Descending）** ：按每个粒子的属性排序，值较高者先于值较低者渲染。 |
| **仅在半透明时进行排序（Sort Only When Translucent）** | 如选中此项，则仅在使用半透明材质时对粒子排序。 |
| 子UV |  |
| **子图像尺寸（Sub Image Size）** | 对粒子使用子图像查找时，此设置提供列数（ **X** ）和行数（ **Y** ）。 |
| **启用子UV混合（Sub UV Blending Enabled）** | 如选中此项，则使用SubImageIndex浮点值的小数部分作为线性插值因子（插值）将子图像UV查找与其下个相邻成员混合。 |
| 绑定 |  |
| **位置绑定（Position Binding）** | 此参数定义生成Sprite时用于定位的属性。默认情况下，此参数使用 **Particles.Position** 变量；如该变量不存在，则使用默认变量 **Engine.Owner.Position** 。下拉菜单会显示和 **Particles.Position** 拥有相同数据类型的变量；但这些选项用在此处可能没有作用。 |
| **颜色绑定（Color Binding）** | 此参数定义在生成Sprite时用于颜色的属性。默认情况下，此参数使用 **Particles.Color** 变量，如该变量不存在，则使用默认值 **R:1, G:1, B:1, A:1** 。如要自定义填入此渲染器中的数据，可使用其他任何类型的兼容属性代替。 |
| **速度绑定（Velocity Binding）** | 此参数定义生成Sprite时用于速度的属性。默认情况下此参数使用 **Particle.Velocity** 变量，如果该变量不存在，则使用默认值 **X:0, Y:0, Z:0** 。可以使用其他任何兼容类型的属性，但下拉菜单中的可用选项对此绑定可能有作用，也可能没有作用。 |
| **Sprite旋转绑定（Sprite Rotation Binding）** | 此参数定义生成Sprite时用于旋转（以度为单位）的属性。默认情况下，此参数使用 Particles.SpriteRotation，如该变量不存在，则使用默认值0。可以使用其他任何兼容类型的属性，但下拉菜单中的可用选项对此绑定可能有作用，也可能没有作用。 |
| **Sprite大小绑定（Sprite Size Binding）** | 此参数定义在生成Sprite时用于大小的属性。默认情况下，此参数使用 **Particle.SpriteSize** 变量，如该变量不存在，则使用默认值 **X:50, Y:50** 。如要自定义填入此渲染器中的数据，可使用其他任何类型的兼容属性代替。 |
| **Sprite朝向绑定（Sprite Facing Binding）** | 此参数定义在生成Sprite时用于朝向的属性。默认情况下，此参数使用 **Particles.SpriteFacing** 变量，如该变量不存在，则使用默认值 **X:1, Y:0, Z:0** 。可以使用其他任何兼容类型的属性，但下拉菜单中的可用选项对此绑定可能有作用，也可能没有作用。 |
| **Sprite对齐绑定（Sprite Alignment Binding）** | 此参数定义在生成Sprite时用于对齐的属性。默认情况下，此参数使用 **Particles.SpriteAlignment** 变量，如该变量不存在，则使用默认值 **X:1, Y:0, Z:0** 。可以使用其他任何兼容类型的属性，但下拉菜单中的可用选项对此绑定可能有作用，也可能没有作用。 |
| **子图像索引绑定（Sub Image Index Binding）** | 此参数定义在生成Sprite时用于Sprite子图像索引的属性。默认情况下，此参数使用 **Particles.SubImageIndex** 变量，如该变量不存在，则使用默认值 **0** 。可以使用其他任何兼容类型的属性，但下拉菜单中的可用选项对此绑定可能有作用，也可能没有作用。 |
| **动态材质绑定（Dynamic Material Binding）** | 此参数定义在生成Sprite时用于动态材质参数的属性。默认情况下，此参数使用 **Particles.DynamicMaterialParameter** ，如该变量不存在，则使用默认值 **X:1, Y:1, Z:1, W:1** 。 |
| **动态材质1绑定（Dynamic Material 1Binding）** | 此参数定义在生成Sprite时用于动态材质参数的属性。默认情况下，此参数使用 **Particles.DynamicMaterialParameter1** ，如该变量不存在，则使用默认值 **X:1, Y:1, Z:1, W:1** 。 |
| **动态材质2绑定（Dynamic Material 2Binding）** | 此参数定义在生成Sprite时用于动态材质参数的属性。默认情况下，此参数使用 **Particles.DynamicMaterialParameter2** ，如该变量不存在，则使用默认值 **X:1, Y:1, Z:1, W:1** 。 |
| **动态材质3绑定（Dynamic Material 3Binding）** | 此参数定义在生成Sprite时用于动态材质参数的属性。默认情况下，此参数使用 **Particles.DynamicMaterialParameter3** ，如该变量不存在，则使用默认值 **X:1, Y:1, Z:1, W:1** 。 |
| **摄像机偏移绑定（Camera Offset Binding）** | 此参数定义在生成Sprite时用于摄像机偏移的属性。默认情况下，此参数使用 **Particles.CameraOffset** 变量，如该变量不存在，则使用默认值 **0** 。可从下拉菜单选择其他兼容属性。 |
| **UV比例绑定（UVScale Binding）** | 此参数定义在生成Sprite时用于UV比例的属性。默认情况下，此参数使用 **Particles.UVScale** 变量，如该变量不存在，则使用默认值 **X:1, Y:1** 。可从下拉菜单选择其他兼容属性。 |
| **材质随机绑定（Material Random Binding）** | 此参数定义在生成Sprite时用于材质随机的属性。默认情况下，此参数使用 **Particles.MaterialRandom** ，如该变量不存在，则使用默认值 **0** 。可从下拉菜单选择其他兼容属性。 |
| **自定义排序绑定（Custom Sorting Binding）** | 此参数定义用于自定义排序的属性。默认情况下，此参数使用 **Particles.NormalizedAge** 变量，如该变量不存在，则使用默认值 **0** 。可从下拉菜单选择其他兼容属性。 |
| **标准化年龄绑定（Normalized Age Binding）** | 此参数定义用于自定义排序的属性。默认情况下，此参数使用 **Particles.NormalizedAge** 变量，如该变量不存在，则使用默认值 **0** 。可从下拉菜单选择其他兼容属性。 |
| 剪切 |  |
| **使用材质剪切纹理（Use Material Cutout Texture）** | 如选中此项，则使用材质不透明蒙版中的剪切纹理；如没有材质不透明蒙版，则使用材质不透明度中的剪切纹理。 |
| **剪切纹理（Cutout Texture）** | 选择要从中创建边界几何体的纹理。 |
| **边界模式（Bounding Mode）** | 设置边界顶点的数量。增加边界顶点可减少过度绘制，但会增加三角形开销。当子UV纹理有许多要剔除的空间无法被四顶点模式捕获时，以及使用纹理的粒子很少且很大时，使用八顶点模式最佳。 |
| **不透明度源模式（Opacity Source Mode）** | 此设置拥有下列选项： **OSM透明度** **OSM颜色亮度** **OSM红色通道** **OSM绿色通道** **OSM蓝色通道** |
| **透明度阈值（Alpha Threshold）** | 大于阈值的透明度通道值将视为被占据，将包含在边界几何体之中。稍稍提高此阈值可减少使用此动画资源的粒子中的过度绘制。 |
| 排序顺序 |  |
| **排序顺序提示（Sort Order Hint）** | 默认情况下将按发射器添加到Niagara系统中堆栈的顺序来绘制发射器。可以用 **排序顺序提示（Sort Order Hint）** 值来以更精细的方式控制绘制顺序。相同类型的材质将按照系统中的排序顺序值从低到高绘制。默认值为 **0** 。 |

## 贴花渲染器

使用 **贴花渲染器（Decal Renderer）** 生成贴花并将其投影到表面上。贴花渲染器使用与贴花Actor相同的技术。如需了解更多信息，请参阅[贴花Actor](../../../../understanding-the-basics/actors-and-geometry/unreal-engine-actors-reference/decal-actors/index.md)。

由于贴花仅在投影到表面上时才会显现，因此当你添加贴花渲染器（Decal Renderer）时，在预览（Preview）窗口中看不到任何内容。有两种方法可以解决这个问题。

1. 将Niagara系统添加到你的关卡。
2. 在预览（Preview）窗口中添加地板。

如果将Niagara系统添加到你的关卡，就可以在单独的窗口中打开Niagara编辑器，并将Niagara编辑器和关卡编辑器并排放置，以方便调整数值。

![Level Editor and Niagara Editor side by side](../../../../../assets/images/d9/d9f5610bd187a1b5b16f8b9b3627211db3ffc6383295088aa45a6226cc1fa51f.jpg)

点击查看大图。

如果你要将地板添加到预览窗格，请从Niagara编辑器中选择 **窗口（Window）> 预览场景设置（Preview Scene Settings）** 。你可以在其中添加地板并调整预览的其他视觉参数。然后，只要将贴花指向地板，便可将其投影到地板上。

你可以在贴花渲染器中设置以下参数。

| 参数 | 说明 |
| --- | --- |
| **材质（Material）** | 选择要绑定到的包含贴花的材质。 |
| **材质参数绑定（Material Parameter Binding）** | 将材质绑定到变量，以便在运行时覆盖材质。 |
| **源模式（Source Mode）** | 设置为粒子（Particles）时，将为模拟中的每个粒子渲染贴花。设置为发射器（Emitter）时，将仅为发射器渲染一个贴花。 |
| **渲染器可视性（Renderer Visibility）** | 使用渲染器可视性标签显示带有该标签的粒子，并隐藏不带该标签的粒子。 |
| **贴花屏幕大小消退（Decal Screen Size Fade）** | 设置贴花屏幕大小，以减少显示的小贴花数量。 |

使用以下与贴花渲染器的绑定。每个绑定都连接到默认变量，但你可以覆盖其中任何一个。

| 绑定 | 说明 |
| --- | --- |
| **位置绑定（Position Binding）** | 定义贴花的中心。它默认绑定到变量 `Particle.Position` 。 |
| **贴花方向绑定（Decal Orientation Binding）** | 设置贴花的方向。如果变量 `Particles.DecalOrientation` 存在，则它会绑定到该变量。否则，默认绑定到方向X：-0.5，Y：0.5，Z: 0.5，W：0.5. |
| **贴花大小绑定（Decal Size Binding）** | 定义贴花的大小。如果变量 `Particles.DecalSize` 存在，则它会绑定到该变量。否则，默认绑定到X：50，Y：50，Z: 50。在这种情况下，X是垂直大小。如需了解更多信息，请参阅[贴花Actor](../../../../understanding-the-basics/actors-and-geometry/unreal-engine-actors-reference/decal-actors/index.md) |
| **贴花消退绑定（Decal Fade Binding）** | 定义贴花的消退数值。你可以使用Decal Lifetime Opacity材质节点查询该数值。如果变量 `Particles.DecalFade` 存在，则它会默认绑定到该变量。否则，默认绑定到1。 |
| **贴花颜色绑定（Decal Color Binding）** | 定义贴花的颜色。它默认绑定到变量 `Particle.Color` 。 |
| **贴花可见绑定（Decal Visible Binding）** | 定义贴花是否应可见。此绑定与 `RendererVisibilityTagBinding` 结合使用来确定可视性。如果变量 `Particles.DecalVisible` 存在，则默认绑定到该变量。否则，默认为true。 |
| **渲染器可视性标签绑定（Renderer Visibility Tag Binding）** | 当可视性标签返回数值时，系统会将这些数值与渲染器可视性标签绑定（Renderer Visibility Tag Binding）进行比较。如果变量 `Particles.VisibilityTag` 存在，则默认绑定到该变量，否则默认为0。 |
