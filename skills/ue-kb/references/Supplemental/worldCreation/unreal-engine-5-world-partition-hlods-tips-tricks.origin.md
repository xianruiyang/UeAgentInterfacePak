# 虚幻引擎 5 世界分区 HLOD 提示和技巧

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/z050/unreal-engine-5-world-partition-hlods-tips-tricks

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 5977 字符。

## 摘要

有关如何处理虚幻引擎 5 世界分区 HLOD 的一些提示和技巧。

## 中文整理

### 概览

大家好！

这些是我在使用虚幻引擎 5 世界分区 HLOD 时在一张相当大的地图上发现的随机提示和技巧，其中包含大量内容，可以对所有遇到 HLOD 问题的人有所帮助。

*免责声明 - 该信息在虚幻引擎 5.3.2 中是真实的，并且某些内容可能会在下一个 UE 版本中得到修复/变得更加损坏。

有些东西可能是“wtf 老兄？”解决方案，所以不要忘记始终独立思考，我只是建议在我的特定案例中可行的方法。* 1.

如果您在 HLOD 烘焙过程中遇到与版本控制相关的错误和崩溃，请确保在开始构建新的 HLOD 之前，您已在版本控制系统（SVN、Perforce 等）中提交或恢复了最后烘焙的 HLOD。

由于某些原因，有时您无法构建新的 HLOD/删除以前的 HLOD，直到您提交/完全恢复它们。

此外，如果您使用 Perforce，您可以尝试协调离线工作以查找应检出的 HLOD 文件。

2.

HLOD 在烘焙时需要大量内存。

将虚拟内存大小至少增加到 150GB。

它还将帮助您处理大量 PCG 生成问题，因为它们也存在一些内存问题。

我将其设置为 512GB，一般情况下我没有遇到任何内存不足崩溃的情况。

如何做到这一点 - [https://answers.microsoft.com/en-us/windows/forum/all/how-do-i-increase-virtual-ram-in-windows-10/4e98f34b-9bf7-4b45-b6c3-a6c9ba326294] （https://answers.microsoft.com/en-us/windows/forum/all/how-do-i-increase-virtual-ram-in-windows-10/4e98f34b-9bf7-4b45-b6c3-a6c9ba326294） 3.

从用户的角度来看，网格和图层如何工作： 1.

网格的加载范围 - 当我们进一步达到这个距离时，分配给该网格的所有 actor 都会被卸载（如果它们启用了“Is Spatially Loaded”），并且默认的 HLOD 层（或每个 actor HLOD 层的覆盖）被启用。

2.

HLOD 的加载范围 - 当我们进一步达到这个距离时，HLOD 将被卸载（如果该图层启用了“空间加载”）并且父图层（也是 HLOD）将被启用。

4.

您可以将关卡演员分成 2 个网格/HLOD 系统 - 树叶演员和其他一切。

创建第二个名为“Foliage”的网格，增加其加载范围，并通过在其“运行时网格”参数中手动键入“Foliage”来将所有树叶演员设置为该网格。

5.

对于树叶，使用 Impostors，使它们能够使用不允许的 Nanite 的实例化 HLOD。

您可以尝试“近似网格”图层类型 - 它适用于纳米树，但形状会很大。

对于常见的建筑物和道具，请使用以下 HLOD 序列：实例→合并/简化网格（如果非 Nanite）或近似（如果 Nanite）。

6.

确保您没有在近似 HLOD 中构建非纳米树叶，否则您将在 HLOD 中出现阴影伪影。

7.

构建近似 HLOD 后，用它们固定文件夹（RMB - Pin），打开 HLOD 的网格 → 材质并禁用粗糙度、金属、镜面使用，设置粗糙度值 = 1。

它消除了 HLOD 的光泽度。

由于某种原因，近似图层类型不使用您在 HLOD 图层文件中准备的设置，它无论如何都会弄乱粗糙度、金属度、镜面反射。

至少就我而言。

或者，您可以尝试更改 HLOD 主材质内的默认粗糙度/金属/镜面值，并将引擎的 HLODBuilderMeshApproximate.cpp 8 中的 Options.bUsePackedMRS 从 true 更改为 false。

禁用 HLOD 生成中的所有小网格 - 无论如何你都不会从远处看到它们。

这与小的 PCG 网格、不同的内部材料、外部盒子/石头等有关。

您可以创建一个简单的编辑器实用程序小部件工具，以禁用小型静态网格物体组件/角色的“包含在 HLOD 中”。

您可以使用节点“获取组件边界”及其输出值“球体半径”。

9.

如果您构建了 HLOD，并且某些演员未包含在 HLOD 中，您可以尝试： 1.

检查演员是否启用了“在 HLOD 中包含演员”参数。

2.

检查参与者的组件是否启用了“在 HLOD 中包含组件”。

3.

将这些演员向上移动一点，然后再返回。

保存、提交更改并尝试再次烘焙 HLOD。

4.

将所有演员（包括景观，您可以为此导出/导入高度图和图层蒙版）移动到新的空开放世界地图，并尝试在那里构建 HLOD。

5.

检查您的关卡中是否有小地图体积。

如果您没有 - 将世界分区迷你地图 act​​or 放置到您的关卡中，缩放它以覆盖整个地图。

单击“构建”→“构建世界分区编辑器小地图”。

有些人说这会有帮助。

10.

取消选中景观的“在 HLOD 中包含演员”。

同时禁用它的“Is Spatially Loaded”参数。

看起来 Nanite Landscape 是目前优化大型景观的最佳方式。

但在某些情况下，您可以看到构建中缺少景观 - 在这种情况下，我可以建议为景观烘焙单独的实例化 HLOD（使其在空间上加载，包含在 HLOD 中，为其分配实例化 HLOD 层。

您也可以为其制作一个单独的网格）。

11.

您可能想通过带有关闭编辑器的命令行开关来烘焙 HLOD。

在这种情况下，您有更多的可用 RAM，您可以看到进度，并且可以将 Visual Studio 调试器附加到它以查看更多详细信息。

文档 - https://dev.epicgames.com/documentation/en-us/unreal-engine/world-partition---hierarchical-level-of-detail-in-unreal-engine#generatehlods 模板 - C:/UE_5.3/Engine/Binaries/Win64/UnrealEditor.exe ../../../ProjectName/ProjectName.uproject -BaseDir=C:/UE_5.3/Engine/Binaries/Win64/ -Unattended -AllowCommandletRendering -AbsLog=D:/ProjectName/Saved/Logs/WorldPartition/WorldPartitionHLODsBuilder-1.log /Game/Maps/MapName -run=WorldPartitionBuilderCommandlet -Builder=WorldPartitionHLODsBuilder -SetupHLODs -BuildHLODs 非常感谢所有描述他们尝试的人修复不同论坛上的 HLOD。

请随时分享您有关构建适当 HLOD 的技巧。

