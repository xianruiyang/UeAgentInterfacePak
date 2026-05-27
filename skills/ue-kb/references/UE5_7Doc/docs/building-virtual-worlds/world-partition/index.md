---
title: "世界分区"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/world-partition-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "世界分区"]
---

# 世界分区

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 世界分区

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/world-partition-in-unreal-engine

以往开发者在制作大型地图时，需要手动将其分为多个子关卡，然后在玩家穿越地形时使用关卡流送系统加载和卸载子关卡。 这样的方法往往导致多用户共用文件的问题，并且使得开发者难以同时审视整个地图。

![《Fortnite》中的世界分区](../../../assets/images/dd/ddc9bbaf595671c8af58bcf5814804886e81fd54be1a5ccf828f0d0a0e5732f2.jpg)

点击查看大图。

世界分区是一种自动数据管理和基于距离的关卡流送系统，为大型世界管理提供了完整的解决方案。 以前需要将单个持久关卡中的世界存储到网格单元格中，以便将大型关卡划分成子关卡，但现在的系统已经不需要如此操作，并且你能够使用自动流送系统，根据与流送源的距离来加载和卸载这些单元格。

世界分区常常与以下功能搭配使用:

- [一Actor一文件](../one-file-per-actor/index.md)
- [世界分区 - 数据层](world-partition---data-layers/index.md)
- [关卡实例](level-instancing/index.md)
- [世界分区 - 分层细节级别](world-partition---hierarchical-level-of-detail/index.md)

## 启用世界分区

在虚幻引擎中启用世界分区的三种方法：

- 使用**游戏（Games）**类别下的模板创建新项目。
- 使用开放世界（Open World）模板创建新关卡。
- 转换已有的关卡来使用世界分区。

### 使用游戏模板创建你的项目

在**游戏（Games）**类目下的很多项目模板中，世界分区默认启用。

点击查看大图。

为了在创建新项目时化繁为简并提供可伸缩的解决方案，可使用**世界设置（World Settings）**下的**启用流送（Enable Streaming）**选项来启用或禁用网格单元格流送。

点击查看大图。

以下模板使用世界分区，但默认禁用**启用流送（Enable Streaming）**选项：

- 空白（Blank）
- 第一人称（First Person）
- 第三人称（Third Person）
- 俯视角（Top Down）
- 高级载具（Vehicle Advanced）

### 使用开放世界默认地图

默认的开放世界（Open World）地图被设计为创建大型开放世界地图的起始参考，并且默认启用以下功能：

- 世界分区
- 一Actor一文件
- 数据层
- 分层细节级别

点击查看大图。

该地图包括一个2km x 2km的地形示例，采用户外环境的地形材质和光照设定。 包括天空大气系统、天空光照、定向光源、指数高度雾、体积云。

点击查看大图。

在你的项目中使用默认的开放世界（Open World）类型地图：

1. 打开**文件（File）**菜单并选择**新关卡（New Level）**。
2. 选择**开放世界（Open World）**地图类型。
3. 点击**创建（Create）**按钮创建新地图。

### 转换已有的关卡来使用世界分区

你可以使用**工具（Tools）> 转换关卡（Convert Level）**选项向任何关卡添加世界分区，或者使用世界分区转换Commandlet。

使用世界分区转换Commandlet的步骤如下：

点击查看大图。

命令：`UnrealEditor.exe QAGame -run=WorldPartitionConvertCommandlet Playground.umap -AllowCommandletRendering`

转换现有关卡以使用世界分区的方法如下：

1. 在Windows中，打开"命令提示符"窗口。
2. 先在提示符下找到`UnrealEditor.exe`可执行文件的位置。 在上述示例中即：`c:\Builds\Home_UE5_Engine\Engine\Binaries\Win64`。
3. 接下来，开始输入命令，以运行Commandlet的.exe文件名开始，即`UnrealEditor.exe`。
4. 添加项目的名称。 此处即`QAGame`。
5. 接着输入待运行Commandlet的名称，即`-run=WorldPartitionConvertCommandlet`。
6. 加入将要转换的地图文件名。 在上述示例中为`Playground.umap`。
7. 最后给命令加上附加参数`-AllowCommandletRendering`。
8. 按下**回车（Enter）**键，Commandlet会转换地图以使用世界分区。

此Commandlet中还可以加入以下参数：

| 可选参数 | 说明 |
| --- | --- |
| **-SCCProvider=(None,Perforce...)** | 指定要使用的源码控制提供方。 若要不带源码控制运行，输入`-SCCProvider=None`。 |
| **-Verbose** | 显示详细日志记录。 |
| **-ConversionSuffix** | 在转换后的地图名后面添加_WP后缀。 这在转换关卡以供测试时很有用，可避免更改源关卡。 |
| **-DeleteSourceLevels** | 在转换后删除源关卡。 |
| **-ReportOnly** | 报告转换期间发生的事情。 不进行转换。 |
| **-GenerateIni** | 针对此地图生成一个默认的`.ini`转换文件。 不进行转换。 |
| **-SkipStableGUIDValidation** | 跳过不稳定Actor GUIDs的验证过程。 带有不稳定Actor GUIDs的关卡在多次转换时会产生不同的输出结果。 重新保存关卡可以解决该问题。 |
| **-OnlyMergeSubLevels** | 在不使用世界分区的情况下将关卡与子关卡转换并合并至一Actor一文件。 转换后的关卡可以在使用世界分区的关卡中作为关卡实例。 |
| **-FoliageTypePath=[Path]** | 将植被类型作为资产提取到指定路径。 若关卡包含嵌入的植被类型，使用此参数。 |

如果要更改转换设置，请在Commandlet中使用默认的转换`.ini`文件。 `.ini`文件需要与地图文件位于同一文件夹，且与地图文件名同名，但使用`.ini`扩展名。 例如，为`FirstPersonExampleMap.umap`写的`.ini`文件将被命名为`FirstPersonExampleMap.ini` 。

以下是一个默认`.ini`转换文件的示例：

C++

```
[/Script/UnrealEd.WorldPartitionConvertCommandlet]
	EditorHashClass=Class'/Script/Engine.WorldPartitionEditorSpatialHash
	RuntimeHashClass=Class'/Script/Engine.WorldPartitionRuntimeSpatialHash
	LevelsGridPlacement=(("/Game/Maps/Highrise_Audio", Bounds),("/Game/Maps/Highrise_Collisions_Temp", Bounds),("/Game/Maps/Highrise_Gameplay", Bounds),("/Game/Maps/Highrise_Lights", Bounds),("/Game/Maps/Highrise_Vista", AlwaysLoaded))
	HLODLayerAssetsPath=
	DefaultHLODLayerName=

	[/Script/Engine.WorldPartitionEditorSpatialHash]
	CellSize=51200
	WorldImage=None
```

## 使用世界分区

世界分区系统将创建的世界储存在一个持久关卡文件中，并且使用可配置的运行时网格将空间划分为可流送的网格单元。 这些网格单元在运行时由流送源（比如玩家）控制加载和卸载。 这样一来，虚幻引擎只加载关卡中玩家能看到并与之互动的部分。

### 世界分区中的Actor

编辑世界时，Actor可以被加入到任何地点，并根据其**空间化加载（Is Spatially Loaded）**的设置被自动分配至网格单元。该选项位于Actor**细节（Details）**面板的**世界分区（World Partition）**分段。

点击查看大图。

| 选项 | 说明 |
| --- | --- |
| 运行时网格（Runtime Grid） | 判定Actor被放置在哪一个分区网格。 如果为**无（None）**，网格将会由分区系统决定。 |
| 空间化加载（Is Spatially Loaded） | 确定Actor是否为空间化加载：若启用，该Actor将会在进入任何流送源的范围内且并未被分配至禁用的数据层时加载。若禁用，则只要没有被分配至禁用的数据层，该Actor就会被加载。 |

由于使用一Actor一文件功能，Actor都储存在各自独立的文件中，因此你不必从源码控制中签出关卡文件就能更改世界中的Actor。 这样你在编辑Actor时，团队的其他成员仍然可以使用关卡文件。

如需详细了解一Actor个文件（One File Per Actor）系统和虚幻引擎的集成源码控制，请参阅[一Actor一文件](../one-file-per-actor/index.md)文档。

> [!NOTE]
> 关卡中引用其他Actor的Actor将会被捆绑并且同时加载。

### 流送源

运行时网格中单元的流送由两个因素判定：

- 流送源
- 运行时网格设置

前者为关卡中流送源的位置。

> 动图已省略：流送源

*点击查看大图。*

流送源组件在世界中确定一个位置并且触发其周围网格单元的加载。 玩家的控制器便是一种流送源。 使用**世界分区流送源（World Partition Streaming Source）**组件也可以添加其他流送源。 比如，如果玩家要传送至某个位置，此处的流送源组件便会启动，这样可以加载其周围的网格单元。 当网格单元加载完毕，玩家到达此位置，该流送源组件便会停用。 玩家原本所在位置已经没有流送源，所以那里的网格单元会从内存中卸载。

### 将玩家作为流送源

使用**启用流送源（Enable Streaming Source）**选项即可将所有玩家控制器都用作世界分区中的流送源。 该选项默认启用：

点击查看大图。

### 使用世界分区流送源组件

世界分区流送也是通过世界分区流送源组件完成的：

点击查看大图。

该组件有以下选项：

| 选项 | 说明 |
| --- | --- |
| **默认可视化器加载范围（Default Visualizer Loading Range）** | 决定可视化器启用时，调试可视化器网格的大小。 |
| **目标网格（Target Grid）** | 决定受此源影响的流送网格。 |
| **调试颜色（Debug Color）** | 决定调试时使用的颜色。 |
| **目标HLOD层（Target HLOD Layer）** | 决定受流送源影响的HLOD层。 |
| **形状（Shapes）** | 决定用于为此流送源构件自定义形状的形状列表。 如果为空，将使用半径等于网格加载范围的球体。 |
| **优先级（Priority）** | 设置流送源的优先级。 如果一个网格单元与多个流送源相交，其优先级将是所有流送源中的最高优先级。 |
| **流送源已启用（Streaming Source Enabled）** | 决定组件是否启用。 |
| **目标状态（Target State）** | 确定相交的网格单元应处于哪种状态（已加载或已激活）。 如果一个网格单元与多个流送源相交，目标状态将是最高的目标数值（激活的大于加载的）。 |

蓝图函数**Enable Streaming Source**和**Disable Streaming Source**用于启用和禁用该组件的流送。

点击查看大图。

当组件流送完与之相交的所有网格单元后，蓝图函数**Is Streaming Completed**会返回true。

### 运行时网格设置

决定网格单元在运行时是否加载/卸载的第二个因素是运行时网格本身的设置。 运行时网格设置位于**世界设置（World Settings）**面板的**世界分区设置（World Partition Setup）**分段。

系统会默认提供一个**2D运行时哈希（2D Runtime Hash）**网格。 超过一个网格时，可能会降低运行性能。

如需详细了解2D运行时哈希网格的推荐设定和设置，请参阅[城市示例](https://www.fab.com/listings/4898e707-7855-404b-af0e-a505ee690e68)项目的**Big City**地图。

点击查看大图。

| 选项 | 说明 |
| --- | --- |
| **网格名称（Grid Name）** | 包含运行时网格的名称。 |
| **单元大小（Cell Size）** | 确定用于生成流送关卡的网格单元的大小。 示例中的**单元大小**为256m x 256m x 256m。 |
| **加载范围（Loading Range）** | 决定流送源周围多少范围内的单元需要加载。 在上图中，**加载范围**是围绕流送源的768米半径范围。 |
| **阻塞缓慢流送（Block on Slow Streaming）** | 在网格单元加载速度不够快的情况下阻塞加载。 |
| **优先级（Priority）** | 设置流送源的优先级。 如果一个网格单元与多个流送源相交，其优先级将是所有流送源中的最高优先级。 |
| **调试颜色（Debug Color）** | 决定启用**预览网格（Preview Grids）**后显示的网格线框的颜色。 |
| **预览网格（Preview Grids）** | 启用后在视口中显示网格线框。 |

### 在编辑器中加载和卸载网格单元

为了便于开发大型世界，世界初始都是卸载状态。 关卡打开后，编辑器只会加载那些**空间化加载（Is Spatially Loaded）**设置项为**False**的Actor，例如环境背景和管理类。 这有助于开发大型世界，因为在这种情况下通常无法在编辑器中同时加载整个地图。

#### 使用世界分区窗口加载和卸载区域

在"世界分区"窗口中，你可以手动选择要在哪些网格单元中工作。 在主菜单中选择**窗口（Window） > 世界分区（World Partition）**来打开该窗口。

点击查看大图。

在窗口中，点击并拖出区域。 然后，右键点击所选内容打开快捷菜单，并选中**按所选项加载区域（Load Region from Selection）**。

点击查看大图。

#### 使用位置体积加载和卸载区域

区域也可以通过**位置体积（Location Volume）**来加载和卸载。

位置体积是编辑器专用体积，可以被放置在关卡中，在世界分区窗口中表示地图的一个区域。

要将位置体积添加到关卡，请执行以下操作：

1. 如果尚未打开**放置Actor（Place Actors）**窗口，则将其打开。
2. 搜索**位置体积（Location Volume）**。 点击它并将其拖放到关卡中。
3. 保存关卡。

保存过关卡后，世界分区窗口中将出现一个与位置体积同名的新区域。

点击查看大图。

选中该区域，右键点击打开快捷菜单。 点击**加载所选区域（Load Selected Region）**以加载区域。 拖动选择或Ctrl+点击多个区域可以一次性加载或卸载多个区域。

位置体积支持以下设置：

点击查看大图。

**笔刷设置（Brush Settings）**

| 设置 | 说明 |
| --- | --- |
| **显示着色体积（Display Shaded Volume）** | 显示带着色体积的笔刷。 |
| **着色体积不透明度值（Shaded Volume Opacity Value）** | 使用0.0-1.0之间的值设置着色体积的不透明度。 |

> [!NOTE]
> **笔刷设置（Brush Settings）**分段下的许多选项都取决于你所选的**笔刷形状（Brush Shape）**。

**世界分区（World Partition）**

| 设置 | 说明 |
| --- | --- |
| **加载/卸载（Load and Unload）** | 加载/卸载所选体积内的区域。 |

### 为世界分区窗口生成小地图

你可以使用**编译（Build）**菜单中世界分区（World Partition）分段下的**编译小地图（Build Minimap）**选项，或者使用世界分区小地图编译器Commandlet来生成小地图，从而让世界分区窗口中的导航更容易。

点击查看大图。

运行这个Commandlet可以为世界分区世界创建一个小地图，并将其放在世界分区窗口中。

> [!WARNING]
> 如果你生成了小地图，但它没有出现在世界分区窗口中，你需要在项目中启用虚拟纹理支持。 要启用虚拟纹理，请转到主菜单，点击**编辑（Edit） > 项目设置（Project Settings）**。 然后勾选**启用虚拟纹理支持（Enable virtual texture support）**复选框。

### 世界分区窗口中的实用快捷键与选项

| 热键 | 说明 |
| --- | --- |
| **Shift+拖曳** | 将所选对象与当前运行时网格大小对齐。 |
| **双击** | 将所有视口中摄像机移动到该位置。 |
| **Shift+双击** | 在点击位置发起PIE会话。 |
| **Ctrl+双击** | 加载点击位置周围的区域。 |
| **鼠标中键+拖拽** | 显示从点击起始点到末端的距离（以虚幻单位计）。 |

### 生成HLOD

生成HLOD需要用到编译菜单中世界分区分段的编译LOD选项，或使用世界分区HLOD编译器（World Partition HLODs Builder）Commandlet来生成。

点击查看大图。

运行该Commandlet会根据你在HLOD层中指定的生成设置，为你的世界分区单元创建HLOD Actor。 如需详细了解在世界分区中使用HLOD和世界分区HLOD编译器Commandlet，请参阅[世界分区 - 分层细节级别](world-partition---hierarchical-level-of-detail/index.md)文档。

### 烘焙世界分区世界

烘焙世界分区地图需要用到烘焙Commandlet：

点击查看大图。

命令：`UnrealEditor.exe QAGame -run=cook -targetplatform=WindowsNoEditor -Unversioned -map=Playground`

要烘焙世界分区地图，请执行以下操作：

1. 在Windows中，打开"命令提示符"窗口。
2. 先在提示符下找到`UnrealEditor.exe`可执行文件的位置。
3. 接下来，开始输入命令，以运行Commandlet的.exe文件名开始，即`UnrealEditor.exe`。
4. 添加项目的名称。 此处即`QAGame`。
5. 接着输入待运行Commandlet的名称，即`-run=cook`。
6. 添加以下参数，完成命令：

   - `-targetplatform=WindowsNoEditor`，表示为Windows平台烘焙项目。
   - `-UnVersioned`负责以无版本模式保存所有烘焙过的包。 这些包在加载时被视为当前版本。
   - `-map=Playground`指定地图的名称，在本例中为`Playground.umap`。

如需详细了解烘焙Commandlet的使用，请参阅[内容烘焙](../../sharing-and-releasing-projects/index.md)。

### 使用世界分区与蓝图

在"世界分区"世界中，蓝图类和关卡蓝图都受到支持。 不过首选是蓝图类，因为在关卡蓝图中引用的Actor都会被标记为始终加载。

## 测试分区世界

### 调试和运行时重载

系统提供了一些控制台命令，用于在运行时调试世界分区世界。

| 控制台命令 | 说明 |
| --- | --- |
| **wp.Runtime.ToggleDrawRuntimeHash2D** | 开关世界分区运行时哈希的2D调试显示。 |
| **wp.Runtime.ToggleDrawRuntimeHash3D** | 开关世界分区运行时哈希的3D调试显示。 |
| **wp.Runtime.ShowRuntimeSpatialHashGridLevel** | 选择在显示世界分区运行时哈希时显示的网格级别。 |
| **wp.Runtime.ShowRuntimeSpatialHashGridLevelCount** | 选择在显示世界分区运行时哈希时要显示多少个网格级别。 |
| **wp.Runtime.ShowRuntimeSpatialHashGridIndex** | 显示世界分区运行时哈希时，显示指定的网格。 无效的索引将导致显示所有网格。 |
| **wp.Runtime.RuntimeSpatialHashCellToSourceAngleContributionToCellImportance** | 取0到1之间的值，用于调节"流送源-单元网格"向量和"流送源-单元网格"向量之间的角度对单元网格重要性的贡献。 该值越接近于0，角度对单元重要性的贡献就越小。 |
| **wp.Runtime.OverrideRuntimeSpatialHashLoadingRange** | 设置运行时加载范围。 接受以下参数：`-grid=[index]`：设置你想影响的运行时网格。`-range=[override_loading_range]`：设置新的运行时加载范围 |
| **wp.Runtime.MaxLoadingLevelStreamingCells** | 限制并发加载的世界分区流送单元的数量。 |
| **wp.Runtime.HLOD 0** | 使用`wp.Runtime.HLOD`显示无HLOD的世界。 |

## 世界分区编译器Commandlet

世界分区通过**UWorldPartitionBuilderCommandlet**和**UWorldPartitionBuilder**基类引入了一个编译器Commandlet框架。

这些Commandlet用于完成自动化批处理，以及生成/修改世界分区关卡中的数据。 大型世界不必一次性全部加载，就能完成HLOD、AI导航数据的生成，或重新保存大量Actor等操作。

如需详细了解世界分区编译器Commandlet，请参阅[世界分区编译器Commandlet参考](world-partition-builder-commandlet-reference/index.md)。
