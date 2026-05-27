# Niagara编辑器UI参考

---
title: "Niagara编辑器UI参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/editor-ui-reference-for-niagara-effects-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建视觉效果", "Niagara参考页面", "Niagara编辑器UI参考"]
---

# Niagara编辑器UI参考

> 路径：虚幻引擎5.7文档 / 创建视觉效果 / Niagara参考页面 / Niagara编辑器UI参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/editor-ui-reference-for-niagara-effects-in-unreal-engine

## 概述

你可以双击Niagara发射器，或右键点击Niagara发射器或系统，然后并在快捷菜单中选择 **编辑（Edit）** ，即可打开Niagara编辑器。此文档定义并介绍了Niagara编辑器的各个部分。由于发射器和系统编辑器的界面基本相同，所以本文同时介绍了这两者。

![Editor Fullscreen](../../../../assets/images/76/76ec359b6f2b8c9bd9f061dc25fefce7701c4d981777bf7998a7e25f5a4ec665.jpg)

点击查看大图。

1. 菜单栏
2. 工具栏
3. 预览面板
4. 参数面板
5. 系统概览
6. 暂存区面板
7. 选择面板（堆栈）
8. 曲线面板
9. Niagara日志面板
10. 时间轴面板

## 菜单

![Menu Bar](../../../../assets/images/18/18f1658054ae2d8a5162872c5d93f1f1778cb81ceb1352d724abd8be52e8cb41.png)

点击查看大图。

> [!NOTE]
> 下表仅描述了适用于Niagara编辑器的命令； 在那些打开资产编辑器或虚幻编辑器其他部分的菜单中，可能还会显示其他命令。

### 文件

![File Menu](../../../../assets/images/3e/3ed6e5baa1aec6378e041de09a1cc753c0b0909dd000c4e33276c026bcf29499.jpg)

点击查看大图。

| 命令 | 说明 |
| --- | --- |
| **保存（Save）** | 保存当前发射器。 |
| **另存为（Save As）** | 以其他命名保存当前发射器。 |
| **打开资产（Open Asset）** | 显示用于选择其他资产的窗口。 |
| **全部保存（Save All）** | 保存该项目中的所有资产和关卡。 |
| **选择要保存的文件（Choose Files to Save）** | 显示内含保存资产和关卡选项的对话框。 |
|  |  |

### 编辑

![Edit Menu](../../../../assets/images/f9/f9617e5ebb462f83b23b285b596610f7e83a20863e9347d7bb7fa8cac8354a10.jpg)

点击查看大图。

| 命令 | 说明 |
| --- | --- |
| **撤销（Undo）** | 撤销上一个操作。 |
| **恢复（Redo）** | 恢复未完成的操作。 |
| **撤销历史记录（Undo History）** | 显示列出所有撤销操作的对话框。 |
| **编辑器偏好设置（Editor Preferences）** | 打开编辑器偏好窗口可以让你调整编辑器的偏好设置。 |
| **项目设置（Project Settings）** | 允许你调整项目设置。 |
| **插件（Plugins）** | 启用或禁用插件。 |
|  |  |

### 资产

![Asset Menu](../../../../assets/images/8b/8b377e139b6cefee2d3191e42bf77b8a743b7dbecdbc0bd20699e6913ee6fdfa.jpg)

点击查看大图。

| 命令 | 说明 |
| --- | --- |
| **在内容浏览器中查找（Find in Content Browser）** | 切换到最近使用的内容浏览器，并选择该内容浏览器中的当前资产。 |
| **引用查看器（Reference Viewer）** | 显示展示所有当前资产引用的对话框。 |
| **大小贴图（Size Map）** | 显示展示资产大致尺寸及其引用内容的交互式贴图。 |
| **审计资产（Audit Assets）** | 打开资产审计UI，显示选定资产的相关信息。 |
| **着色器烘焙统计数据（Shader Cook Statistics）** | 显示着色器烘焙统计数据。 |
|  |  |

### 窗口

![Window Menu](../../../../assets/images/11/113271494ca94b6a0e08ca37d8c64a012e49973c8024bfd8269a7c5c2ba30d2c.jpg)

点击查看大图。

| 命令 | 说明 |
| --- | --- |
| **预览（Preview）** | 显示或隐藏预览面板。 |
| **曲线（Curves）** | 显示或隐藏曲线面板。 |
| **时间轴（Timeline）** | 显示或隐藏时间轴面板。 |
| **参数（Parameters）** | 显示或隐藏参数面板。 |
| **Legacy Parameters** | 打开旧有参数窗口。 |
| **选择（Selection）** | 显示或隐藏选择面板。 |
| **属性表（Attribute Spreadsheet）** | 显示或隐藏属性表。 |
| **预览场景设置（Preview Scene Settings）** | 显示或隐藏预览场景设置。 |
| **生成代码（Generated Code）** | 显示或隐藏生成代码面板。 |
| **Niagara日志（Niagara Log）** | 显示或隐藏Niagara日志面板。 |
| **系统概览（System Overview）** | 显示或隐藏系统概览面板。 |
| **暂存区（Scratch Pad）** | 显示或隐藏暂存区面板。 |
| **脚本统计数据（Script Stats）** | 显示或隐藏脚本统计数据面板。 |
| **烘焙器（Baker）** | 打开烘焙器窗口。 |
| **过场动画（Cinematics）** | 在新窗口中打开 **序列记录器（Sequence Recorder）** 面板。 |
| **内容浏览器（Content Browser）** | 用新窗口打开选定的内容浏览器。 |
| **设备输出日志（Device Output Log）** | 打开设备输出日志窗口。 |
| **交换结果浏览器（Interchage Results Browser）** | 打开交换结果浏览器窗口。 |
| **消息日志（Message Log）** | 打开消息日志窗口。 |
| **输出日志（Output Log）** | 打开输出日志窗口。 |
| **开放虚幻商城（Open Marketplace）** | 打开开放虚幻商城。 |
| **Quixel Bridge** | 打开Quixel Bridge。 |
| **加载布局（Load Layout）** | 点击布局可加载此前保存的布局。 |
| **保存布局（Save Layout）** | 保存新布局。 |
| **删除布局（Remove Layout）** | 点击布局可删除此前保存的布局。 |
| **启用全屏（Enable Fullscreen）** | 点击可切换全屏模式。 |
|  |  |

## 工具栏

![Tools Menu](../../../../assets/images/8a/8a2c979a929551c56444ce33982ba638e112b18a13590ee23c1f3168b9a35cd1.jpg)

点击查看大图。

| 命令 | 说明 |
| --- | --- |
| **新建C++类（New C++ Class）** | 将C++代码添加到项目。仅在你已安装Visual Studio的情况下才能编译该代码。 |
| **生成Visual Studio项目（Generate Visual Studio Project）** | 在Visual Studio中生成你的C++代码项目。 |
| **在蓝图中查找（Find in Blueprints）** | 在新窗口中打开选择的"在蓝图中查找"面板。 |
| **缓存统计数据（Cache Statistics）** | 显示派生数据缓存统计数据窗口。 |
| **类查看器（Class Viewer）** | 显示此项目中存在的所有类。 |
| **CSV至SVG（CSV to SVG）** | 用于通过从CSV配置文件生成的逗号分隔值文件生成向量线图的工具。 |
| **本地化操作面板（Localization Dashboard）** | 打开试验性本地化操作面板窗口。 |
| **合并Actor（Merge Actors）** | 打开合并Actor窗口。 |
| **Nanite工具（Nanite Tools）** | 显示用于审核和优化Nanite资产窗口的工具。 |
| **项目启动程序（Project Launcher）** | 打开项目启动程序窗口。 |
| **资源使用（Resource Usage）** | 显示派生数据资源使用窗口。 |
| **会话前端（Session Frontend）** | 打开会话前端窗口。 |
| **结构体查看器（Struct Viewer）** | 显示此项目中存在的所有结构体。 |
| **虚拟资产（Virtual Assets）** | 打开虚拟资产统计数据。 |
| **调试（Debug）** | 你可以打开各种不同的调试工具。 |
| **配置文件（Profile）** | 你可以打开各种不同的配置文件工具。 |
| **审核（Audit）** | 你可以打开各种不同的审核工具。 |
| **平台（Platforms）** | 查看和管理已连接设备。 |
| **查看变更列表（View Changelists）** | 打开显示当前变更列表的对话框。 |
| **提交内容（Submit Content）** | 打开一个对话框，其中包含内容和关卡的签入选项。 |
| **连接至源控制（Connect to Source Control）** | 显示一个你可连接至源控制的对话框，允许对内容执行源控制功能。 |
| **运行Unreal Insights（Run Unreal Insights）** | 运行Unreal Insights独立应用程序。 |
|  |  |

## 工具栏

![Toolbar](../../../../assets/images/d8/d8b1e370450389f1e71b33e8301e3606ef56daac8d8a643f17c303a90529cf22.jpg)

点击查看大图。

| 工具名称 | 说明 |
| --- | --- |
| **保存（Save）** 保存图标 | 保存当前发射器。 |
| **浏览（Browse）** 浏览图标 | 切换至最近的内容浏览器并选择当前发射器。 |
| **编译（Compile）** 编译图标 | 此设置编译发射器中的所有模块。你也可以点击下拉箭头来更改自动编译设置。 \|单击下拉列表以选择以下选项： **完全构建（Full Build）** ：此选项会导致系统完全重构，并忽略更改跟踪。 **自动编译（Auto-Compile）** ：在图表更改时自动编译。 |
| **缩略图（Thumbnail）** 缩略图图标 | 生成资产的缩略图。 |
| **边界（Bounds）** 边界图标 | 在预览面板中显示场景边界。点击下拉菜单可 **设置固定边界（Set Fixed Bounds）** 。 |
| **性能** 性能图标 | 点击下拉箭头，查看下列性能选项： **清除统计数据（Clear Stats）** ：清除所有现有统计数据捕获。 **GPU性能分析（GPU Profiling）** : 启用此功能可测量脚本的GPU运行时开销。对于具有大量迭代的模拟阶段，性能压力可能会很大。 **显示平均数据（Display Average）** : 启用此功能可显示捕获的统计数据的平均值。 **显示最大数据（Display Maximum）** : 启用此选项可显示捕获的统计数据的最大值。 **显示相对值（Display Relative Values）** : 启用此功能后，将以父脚本的百分比显示采集的统计数据。 **显示绝对值（Display Absolute Values）** ：启用此选项可以直接显示捕获模块的统计时间。 |
| **调试（Debug）** 调试图标 | 点击下拉菜单可查看以下调试选项： **调试HUD（Debug HUD）** ：打开Niagara调试HUD。 **FX大纲视图（FX Outliner）** ：打开Niagara FX大纲视图。 **属性电子表格（Attribute Spreadsheet）** ：打开Niagara调试大纲视图。 |
| **模拟（Simulation）** 模拟图标 | 点击下拉菜单可查看以下模拟选项： **自动运行（Auto-Play）** ：启用此选项后，当你在Niagara编辑器中打开资产以及当你修改资产时，可使模拟自动运行。 **更改时重置（Reset on Change）** ：启用此选项后，每当你在Niagara 编辑器中更改资产时都会重置模拟。 **暂停时重新模拟（Resimulate When Paused）** ：启用该选项后，当你在模拟暂停的情况下做出更改时，可让模拟重新运行到当前时间。 |
| **烘焙器（Baker）** 烘焙器图标 | 点击下拉菜单可查看以下烘焙器选项： **打开烘焙器选项卡（Open Baker Tab）** ：打开动画书窗口。 **烘焙（Bake）** ：运行烘焙过程。 |
|  |  |

## 预览面板

> 图片已省略：Preview panel

点击查看大图。

| 菜单项 | 说明 |
| --- | --- |
| 视口选项 |  |
| **实时（Realtime）** | 在视口中切换实时渲染。即使未编译发射器，发射器堆栈中的修改也将立即显示在视口中。 |
| **显示统计数据（Show Stats）** | 在视口中切换显示统计数据。若未启用 **实时** ，则 **显示统计数据** 会自动启用。 |
| **显示FPS（Show FPS）** | 在视口中显示FPS。如果没有启用 **显示统计数据（Show Stats）** ，打开 **显示FPS（Show FPS）** 会自动启用它。 |
| **视野(Field of View)** | 更改视口摄像机的视野。此选项实际上能拉远和拉近摄像机镜头。 |
| **远视平面（Far View Plane）** | 允许你选择要用作远视平面的距离。将此项设置为零会得到无穷远的远视平面。 |
| **屏幕百分比（Screen Percentage）** | 设置预览面板使用的屏幕百分比。 |
| 视点类型 |  |
| **视角（Perspective）** | 视口中使用的默认视点。 |
| **正交（Orthographic）** | 可选择 **顶部（Top）** 、 **底部（Bottom）** 、 **左侧（Left）** 、 **右侧（Right）** 、 **正面（Front）** 或 **背面（Back）** 。选择任一项会将视图模式更改为 **线框（Wireframe）** 。 |
| 视图模式 |  |
| **光照（Lit）** | 默认设置，使用正常光照渲染场景。 |
| **无光照（Unlit）** | 此设置不使用光源渲染场景。无光照贴图、动态光源、静态光源或自发光材质，不影响场景。 |
| **笔刷线框（Brush Wireframe）** | 在笔刷线框中渲染场景。此模式将在视口中显示所有内容的原始三角形，并关闭背面，使场景更加可读。 |
| **细节光照（Detail Lighting）** | 此设置仅使用细节光照渲染场景。这意味着仅使用法线数据提取自材质的光照。从光源发出的颜色将影响场景。 |
| **仅光照（Lighting Only）** | 此设置仅用光照渲染场景，而无纹理。仅考虑场景的顶点法线。 |
| **反射（Reflections）** | 此设置仅使用反射渲染场景。这包括反射采集和屏幕空间反射。 |
| **玩家碰撞（Player Collision）** | 渲染玩家或Pawn的可碰撞对象的颜色编码视图。静态网格体碰撞显示为绿色，体积为粉红色，笔刷为灰紫色。 |
| **可见性碰撞（Visibility Collision）** | 此设置渲染场景中阻止可见性追踪的Actor的颜色编码视图。静态网格体碰撞显示为绿色，体积为粉红色，笔刷为灰紫色。 |
| **优化视图模式（Optimization Viewmodes）** | 从以下选项中进行选择： **光照复杂度（Light Complexity）** ：此设置渲染显示原始光源重叠之处的视图。 **光照贴图密度（Lightmap Density）** ：此设置渲染场景中光照贴图密度的视图，其中蓝色表示密度最低，红色表示密度最高。 **固定光照重叠（Stationary Light Overlap）** ：此设置渲染固定光照重叠之处的视图。 **着色器复杂度（Light Complexity）** ：此设置渲染场景中着色器复杂度的视图。浅绿色表示复杂度最低，绿色越深复杂度越高，红色表示最高复杂度。 **着色器复杂度和四边形（Shader Complexity and Quads）** ：此设置使用显示的着色器复杂度和四边形过度绘制来渲染视图。 **四边形过度绘制（Quad Overdraw）** ：此设置只使用显示的四边形过度绘制复杂度来渲染视图。 **材质纹理比例（Material Texture Scales）** : 显示用于纹理流送的材质纹理比例的精度。 **要求的纹理分辨率（Required Texture Resolution）** : 显示当前流送纹理的分辨率和GPU所需的分辨率之间的比例。 |
| **细节层级着色（Level of Detail Coloration）** | 从以下选项中进行选择： **网格体LOD着色（Mesh LOD Coloration）** ：使用LOD颜色可视化来渲染场景。 **层级LOD着色（Hierarchical LOD Coloration）** ：使用HLOD颜色可视化来渲染场景。 |
| **玩家碰撞（Player Collision）** | 渲染玩家碰撞可视化。 |
| **可视性碰撞（Visibility Collision）** | 渲染可视性碰撞可视化。 |
| **自动（Auto）** | 启用后，启用自动曝光。 |
| **EV100** | 使用特定的EV100设定摄像机的曝光值。 |
| 显示 |  |
| **网格（Grid）** | 此设置切换视口的网格。 |
| **指令数（Instruction Counts）** | 切换视口左上角的指令数显示。 |
| **粒子数（Particle Counts）** | 此设置切换视口中粒子计数的显示。 |
| **发射器执行顺序（Emitter Execution Order）** | 在视口中切换显示发射器的执行顺序。 |
|  |  |

## 参数面板

> 图片已省略：Parameters Panel

点击查看大图。

此面板列出活动发射器或系统使用的所有用户公开、系统、发射器、粒子和引擎提供参数（也称为 *属性* ）。

在 **参数（Parameters）** 面板中，你可以将参数拖放到系统概览中的任何适当节点，或拖放到选择面板中的任何适当模块参数。参数的引用次数显示于右侧，这使你能够发现错误并决定变量的更改方式。如果你打开了其他发射器，则此面板将从打开的发射器获取数据。用户可借此在发射器之间共享数据。参数的命名空间以突出图标显示，而且当你将鼠标悬停在图标上时，你会看到用于解释该命名空间的提示文本。如需了解更为高级的命名空间，例如参数集，请点击搜索栏旁边的 **眼睛** 图标。

### 系统概览面板

> 图片已省略：System Overview

点击查看大图。

**系统概览（System Overview）** 面板将图表缩放视图与精简版系统或发射器堆栈相结合，可在较高的层面概览正在编辑的系统或发射器。此面板使浏览数据的不同部分更加容易，而且当你第一次打开发射器或系统时，它将为你提供高级视图。

在系统中，在 **时间轴（Timeline）** 面板中选择发射器，系统将在 **选择（Selection）** 面板中显示此发射器的完整堆栈。在完整堆栈视图中，顶部是系统信息，紧接着是发射器模块组。你也可以单击系统概览面板中的发射器节点或系统节点，以获取该节点的完整堆栈视图。但是，如果你希望视图更简洁或更集中，则可以在系统概览中选择发射器节点中的单个组或模块，以使选择面板中仅显示该组或模块。

### 系统节点

> 图片已省略：System Node

点击查看大图。

**系统（System）** 节点不仅具有用于标识每个模块组的图标，而且在模块旁边还具有可标识该模块或参数所影响对象的彩色圆点。

### 发射器节点

> 图片已省略：Emitter Node

点击查看大图。

**发射器属性（Emitter Properties）** 具有用于标识模拟是在CPU还是在GPU上运行的图标。发射器节点上的其他图标和彩色圆点有助于你快速识别组、模块或参数。

## 暂存区面板

> 图片已省略：Scratch Pad

点击查看大图。

借助 **暂存区** ，你可以创建可重复使用的模块或动态输入，这些模块或输入会以本地形式包含在活跃发射器或系统资产中。这使设计和执行新的自定义模块或动态输入变得更加轻松，因为你可以在发射器或系统中立即查看结果。你可以随意保留或丢弃它们。获得所需结果后，你可以将脚本导出到现有资产，或将其另存为新资产。你也可以右键点击 **暂存脚本选择器（Scratch Script Selector）** 并选择 **创建资产（Create Asset）** 将它保存为一个新资产。你还可以通过暂存区制作出非常适用于活动发射器或系统的内容，而无需将其做成自有资产。

有两种方法可以在Niagara编辑器中打开暂存区面板。你可以从 **窗口（Windows）** 菜单中打开暂存区面板，这种方式可显示或隐藏任何其他面板。这种方式的缺点是，当你使用暂存区构建自定义模块时，你需要将该模块手动添加到系统概览中的总发射器或系统脚本中。而且，你还必须自己添加模块或动态输入启动外壳，方法是点击 **模块（Modules）** 或 **动态输入（Dynamic Inputs）** 旁边的 **加号** 图标（ **+** ）。

> 图片已省略：Scratch Pad from Windows Menu

点击查看大图。

打开暂存区面板的第二种方式是使用 **加号** 图标（ **+** ），并选择 **新建暂存区模块（New Scratch Pad Module）** 。这样会将暂存区模块放置在堆栈中（新模块所属位置），该模块会自动添加到脚本中。你还将看到新模块或动态输入的外壳会自动添加到暂存区图表中。

> 图片已省略：New Scratch Pad Module

点击查看大图。

## 选择面板（堆栈）

> 图片已省略：Selection Panel

点击查看大图。

在发射器节点和 **选择** 面板中，不同的组会采用颜色编码。

- 橙色（Orange）

  用于发射器级模块。橙色部分：

  - 发射器设置（Emitter Settings）

    ：

    发射器属性

    项目位于本组中。
  - 发射器生成（Emitter Spawn）

    ：首帧中发生的情况。
  - 发射器更新（Emitter Update）

    ：发射器更新时，首帧后发生的情况。
- 绿色（Green）

  用于粒子级模块。绿色部分：

  - 粒子生成（Particle Spawn）

    ：创建粒子时发生的情况。
  - 粒子更新（Particle Update）

    ：粒子生命周期内发生的情况。
  - 更新年龄（Update Age）

    和

    解算力和速度（Solve Forces and Velocity）

    通常为所有人均可使用的低级样板模板。可移除此类完全可选的模板。
- 红色（Red）

  用于渲染项目。Niagara将模拟与渲染解耦。这意味着可一次性创建模拟行为，然后将多个渲染器指定到该模拟。

当你在系统总览中选择 **系统（System）** 节点时，你会看到系统相关的组以 **蓝色（Blue）** 标记。

- 系统设置（System Settings）

  ：此分组包括用户参数（User Parameters）和系统属性（System Properties）项目。
- 系统生成（System Spawn）

  ：创建系统时发生的情况。
- 系统更新（System Update）

  ：系统生命周期内发生的情况。

Niagara编辑器的UI有些复杂。接下来的两节将重点介绍某些可能让新用户感到困惑的特定UI元素。

## 选择面板中的组

> 图片已省略：Groups in Selection Panel

点击查看大图。

当你单击发射器或系统节点中的组时，整个组将显示在选择面板中。在组名称的右侧，你会看到一个 **加号** 图标（ **+** ），其颜色与该组相匹配。当你单击该图标后，可用模块类别的列表随即显示。单击类别名称旁边的三角形以将其展开，然后查看该类别中的模块。选择模块的名称会将该模块添加到组中。

> [!NOTE]
> 你也可以直接在系统概览中点击发射器或系统节点中的 **加号** 图标。上述列表随即显示。

## 选择面板中的模块

> 图片已省略：Modules in Selection Panel

点击查看大图。

视模块而定，你可能需要根据模块修改参数值，以获得特定结果。若要添加动态输入、表达式或指向另一属性的链接，你可以单击位于要修改值字段右侧的下拉箭头。可用类别的列表随即显示。展开类别后，你可以从可用选项列表中进行选择，并且所选选项将应用于该值字段。例如，若要随机化值，你可以单击下拉列表，然后选择 **动态输入 > 随机范围浮点（Dynamic Inputs > Random Ranged Float）** 。

> [!TIP]
> 如果你未找到你在列表中创建的模块或动态输入，请尝试取消勾选 **仅库（Library Only）** 。

## 时间轴面板

> 图片已省略：Timeline Panel

点击查看大图。

使用 **时间轴** 面板可管理循环、循环数、迸发、随机开始和停止，以及生成速率。所有此类元素都可在时间轴上交互。

在系统中，时间轴面板列出了系统中所有活跃发射器，并提供所用渲染器种类的相关元数据，并可切换活跃发射器。使用时间轴可控制循环行为，也可在时间轴内设置生成迸发关键帧。此操作由模块元数据（用户可按需扩展）驱动。

欲了解使用Sequencer的更多信息，参阅[Sequencer编辑器](../../../animating-characters-and-objects/cinematics-and-movie-making/index.md)。

## 曲线面板

> 图片已省略：Curves

点击查看大图。

此面板提供了曲线编辑器，可用于在粒子或发射器生命周期中调整需要变更的值。如需在曲线编辑器中编辑属性，该属性需拥有利用曲线的分布数据类型，如 *FloatfromCurve* 。欲了解使用曲线编辑器的更多详情，参阅[曲线编辑器用户指南](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/animation-curve-editor/index.md)页面。

## Niagara日志面板

> 图片已省略：Niagara Log

点击查看大图。

脚本、发射器或系统在编译时出现的所有警告或错误都会显示在此处。其中，许多错误和警告只要在Niagara日志面板中点击，就能跳转到Niagara编辑器中发生错误的位置。

## 其他可选面板

有些面板默认状况下不会显示，但可通过 **窗口（Window）** 菜单打开。默认情况下，这些面板会以选项卡形式出现在 **选择（Selection）** 面板的显示区域中，你可以通过拖放将它们停靠在其他位置。

### 属性表面板

> 图片已省略：Attribute Spreadsheet

点击查看大图。

使用 **属性表（Attribute Spreadsheet）** ，你可以过滤和调试来自CPU或GPU模拟的信息。对于所有基于CPU VM的效果，都可利用属性调试器。属性调试器可用于查看模拟的输入以及每个粒子计算得出的值。

属性表的目标为预览面板中预览的发射器或系统。你也可以将关卡内系统设置为 **Force Solo** ，然后在属性表中选择该系统作为目标，从而将关卡中的系统作为目标。

### 预览场景设置面板

> 图片已省略：Preview Scene Settings

点击查看大图。

此面板包含用于修改预览面板的设置。

### 生成代码面板

> 图片已省略：Generated Code Panel

点击查看大图。

此面板显示所选发射器和所属系统生成的HLSL和汇编代码。这使你能够查看和搜索该代码。某些高级用户在查找问题时可能会遇到障碍，此时可考虑使用此工具来调试问题。

你可以使用脚本下拉菜单来选择要显示的HLSL或汇编代码。若要查看特定发射器的生成HLSL或汇编代码，请遵循下列步骤。

1. 在

   系统概览（System Overview）

   或

   时间轴（Timeline）

   面板中，选择发射器。
2. 在

   生成代码（Generated Code）

   面板中的

   脚本（Scripts）

   下拉菜单中，选择所需脚本。

