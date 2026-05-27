---
title: "世界分区构建器命令参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/world-partition-builder-commandlet-reference"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "世界分区", "世界分区构建器命令参考"]
---

# 世界分区构建器命令参考

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 世界分区 / 世界分区构建器命令参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/world-partition-builder-commandlet-reference

**世界分区**通过**UWorldPartitionBuilderCommandlet**和**UWorldPartitionBuilder**基类引入了一个编译器Commandlet框架。

这些Commandlet用于完成自动化批处理，以及生成/修改世界分区关卡中的数据。 大型世界不必一次性全部加载，就能完成HLOD、AI导航数据的生成，或重新保存大量Actor等操作。

## 世界分区HLOD构建器

HLOD是使用**世界分区HLOD编译器**commandlet生成的。 运行该Commandlet会根据你在HLOD层中指定的生成设置，为你的世界分区单元创建HLOD Actor。

命令：`UnrealEditor.exe "C:\Users\user.name\Documents\Unreal Projects\MyProject\MyProject.uproject" "/Game/ThirdPersonBP/Maps/OpenWorldTest" -run=WorldPartitionBuilderCommandlet -AllowCommandletRendering -builder=WorldPartitionHLODsBuilder`

如需详细了解在世界分区中使用HLOD和世界分区HLOD编译器Commandlet，请参阅[世界分区 - 分层细节级别](../world-partition---hierarchical-level-of-detail/index.md)文档。

## 世界分区小地图构建器

**世界分区小地图编译器（World Partition MiniMap Builder）**commandlet可以生成或更新在世界分区编辑器窗口中显示的小地图。

命令：`UnrealEditor.exe "C:\Users\user.name\Documents\Unreal Projects\MyProject\MyProject.uproject" "/Game/ThirdPersonBP/Maps/OpenWorldTest" -run=WorldPartitionBuilderCommandlet -AllowCommandletRendering -builder=WorldPartitionMiniMapBuilder`

## 世界分区重命名复制构建器

**世界分区重命名复制编译器（World Partition Rename Duplicate Builder）**commandlet可以自动重命名或复制现有的世界分区关卡及其所有Actor。

命令：`UnrealEditor.exe "C:\Users\user.name\Documents\Unreal Projects\MyProject\MyProject.uproject" "/Game/ThirdPersonBP/Maps/OpenWorldTest" -run=WorldPartitionBuilderCommandlet -SCCProvider=None -builder=WorldPartitionRenameDuplicateBuilder -NewPackage=/Game/ThirdPersonBP/Maps/NewPackage`

该命令会为**OpenWorldTest**地图创建一个名为**NewPackage**的世界分区关卡副本，而不会改动原始地图。

如需重新命名你的世界分区地图，而非创建副本，请添加`-Rename`参数。

## 世界分区重新保存Actor构建器

**世界分区重新保存Actor编译器（World Partition Resave Actors Builder）**commandlet可以重新保存世界分区关卡中的所有Actor，同时支持类筛选器，以便只重新保存一部分Actor。

命令：`UnrealEditor.exe "C:\Users\user.name\Documents\Unreal Projects\MyProject\MyProject.uproject" "/Game/ThirdPersonBP/Maps/OpenWorldTest" -run=WorldPartitionBuilderCommandlet -SCCProvider=None -builder=WorldPartitionResaveActorsBuilder`

在执行上面这段命令后，OpenWorldTest中所有的Actor都会被重新保存。

你可以使用`-ActorClass`参数，指定只保存一部分Actor。 例如，添加`-ActorClass=StaticMeshActor`即可只重新保存指定关卡中的静态网格体Actor。

## 世界分区植被构建器

在世界分区地图中，默认的实例化植被网格大小为256米。 **世界分区植被编译器（World Partition Foliage Builder）**commandlet可以改变现有世界分区关卡中的实例化植被网格大小。

命令： `UnrealEditor.exe QAGame Playground.umap -run=WorldPartitionBuilderCommandlet -Builder=WorldPartitionFoliageBuilder -NewGridSize=Value`

如需详细了解如何使用世界分区的植被模式，请参阅[植被模式](https://dev.epicgames.com/documentation/assets/building-virtual-worlds/open-world-tools/foliage-mode)文档。

## 世界分区导航数据构建器

**世界分区导航数据编译器（World Partition Navigation Data Builder）**commandlet可以重新生成世界分区关卡的寻路网格体。

命令：`UnrealEditor.exe "C:\Users\user.name\Documents\Unreal Projects\MyProject\MyProject.uproject" "/Game/ThirdPersonBP/Maps/OpenWorldTest" -run=WorldPartitionBuilderCommandlet -AllowCommandletRendering -builder=WorldPartitionNavigationDataBuilder -SCCProvider=None`

该Commandlet接受以下参数：

| 可选参数 | 说明 |
| --- | --- |
| **-SCCProvider** | 指定要使用的源码控制提供方。 若要不带源码控制运行，输入`-SCCProvider=None`。 |
| **-Verbose** | 显示详细日志记录。 |
| **-Log** | 将日志输出到一个指定文件。 |
| **-CleanPackages** | 擦除所有的寻路数据包，而不是构建它们。 |

## 世界分区智能对象集合构建器

世界分区智能对象集合构建器命令（World Partition Smart Object Collection Builder）可以基于世界分区关卡中的所有智能对象组件，重建智能对象集合。

命令：`UnrealEditor.exe "C:\Users\user.name\Documents\Unreal Projects\MyProject\MyProject.uproject" "/Game/ThirdPersonBP/Maps/OpenWorldTest" -run=WorldPartitionBuilderCommandlet -builder=WorldPartitionSmartObjectCollectionBuilder`

在执行上面的命令时，OpenWorldTest关卡中的所有智能对象集合都会被重新构建。 你可以在该commandlet中使用`-SCCProvider`参数来指定使用哪个版本控制提供商。

## 世界分区PCG构建器

**世界分区PCG编译器（World Partition PCG Builder）**commandlet可以完全加载关卡，等待异步进程完成（例如静态网格体构建），然后在匹配的PCG组件上安排生成。 所有生成完成后，进程会保存世界分区关卡并退出。

命令行：`UnrealEditor.exe "C:\Users\user.name\Documents\Unreal Projects\MyProject\MyProject.uproject" "/Game/ThirdPersonBP/Maps/OpenWorldTest" -Unattended -AllowCommandletRendering -run=WorldPartitionBuilderCommandlet -Builder=PCGWorldPartitionBuilder -IncludeGraphNames=PCG_GraphA;PCG_GraphB`

控制台命令：`pcg.BuildComponents -IncludeGraphNames=PCG_GraphA;PCG_GraphB`

该Commandlet接受以下参数：

| 可选参数 | 说明 |
| --- | --- |
| **-IncludeGraphNames** | 在生成中包括图表名称的列表，以`;`分隔。 如果提供，系统将安排分配有第一个图表的所有PCG组件的生成，然后是分配有第二个图表的组件，以此类推。 如果省略，则PCG组件不会按图表筛选。 |
| **-GenerateComponentEditingModeLoadAsPreview** | 当使用此参数时，将考虑生成使用编辑器模式**加载为预览（Load As Preview）**保存的组件。 |
| **-GenerateComponentEditingModeNormal** | 生成编辑模式为**正常（Normal）**的组件。 默认情况下，仅生成使用编辑模式**加载为预览（Load As Preview）**保存的组件。 |
| **-GenerateComponentEditingModePreview** | 生成编辑模式为**预览（Preview）**的组件。 默认情况下，仅生成使用编辑模式**加载为预览（Load As Preview）**保存的组件。 |
| **-IgnoreGenerationErrors** | 将结果提交到源码控制，忽略错误（但错误仍会报告，并且作业状态仍将为失败（Failed））。 这可以在有错误的情况下使作业保持在线，但应该谨慎使用。 默认情况下，组件正包含成时发生的错误将向构建器注册，并将使构建作业失败，并且结果不会提交。 |
| **-IncludeActorIDs** | 包括以`;`分隔的唯一Actor ID的列表。 如果提供，将仅生成匹配的Actor上的PCG组件。 尤其适合用于调试单个组件/Actor。 |
| **-OneComponentAtATime** | 安排一次生成一个组件，并在每个生成完成后再安排新组件。 调试时很有用，可确保异步进程不会彼此干扰。 |
| **-PCGBuilderSettings** | 指定在设置编译器commandlet时使用的**PCGBuilderSettings**资产。 所有命令参数都将重载PCGBuilderSettings资产中设置的参数。 |
| **-IterativeCellLoading** | 使用指定的单元格大小处理世界，以避免一次性加载所有内容。 加载的组件将被生成并保存。 然后，它们会被卸载，构建器将移动到下一个单元格。 这对于大型世界非常有用，因为一次加载整个世界会导致内存问题。 |
| **-IterativeCellSize** | 重载使用**IterativeCellLoading**时默认的单元格大小。 默认值为`25600`。 |
| **-Unattended** | 避免初始化编辑器UI，改为在控制台中运行。 |
| **-AllowCommandletRendering** | 初始化渲染子系统。 很有用，因为PCG有一些利用GPU的功能。 |
| **-AutoSubmit** | 尝试将结果提交到源码控制（如果可用）。 |
| **-AssetGatherAll** | 为项目中的所有资产构建完整资产注册表。 构建器需要访问关卡中未引用的资产时为必需。 |
