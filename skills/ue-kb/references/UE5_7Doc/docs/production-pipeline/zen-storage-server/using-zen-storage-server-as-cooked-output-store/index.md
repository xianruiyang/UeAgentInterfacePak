---
title: "将Zenserver作为烘焙输出存储"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-zen-storage-server-as-cooked-output-store-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Zen存储服务器", "将Zenserver作为烘焙输出存储"]
---

# 将Zenserver作为烘焙输出存储

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Zen存储服务器 / 将Zenserver作为烘焙输出存储

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-zen-storage-server-as-cooked-output-store-for-unreal-engine

将Zenserver作为烘焙输出存储的目的如下：

- 在大型项目中，将一百万个以上文件作为烘焙输出时，减少文件系统的开销，提高烘焙时效率。
- 在将来实现可靠的增量烘焙。
- 通过使用[Zen流送](../how-to-use-zenserver-streaming-to-play-on-target/index.md)功能实现更快的暂存和部署。该功能以作为烘焙输出存储的Zenserver为基础编译。
- 通过使用[烘焙数据快照](../cooked-data-snapshots-with-zen-storage-server/index.md)功能实现已烘焙状态的轻松导入。该功能以作为烘焙输出存储的Zenserver为基础编译。
- 在将来更高效地表示烘焙输出数据中包含的派生数据。
- 让我们能够用游戏加载的同一个存储进行烘焙，而无需在中间进行大量的数据转换，从而在未来实现更直接、更高效的目标工作流。

## 理解烘焙输出

要了解如何将Zenserver作为烘焙输出存储，首先要了解默认情况下如何处理烘焙输出，以及烘焙输出如何融入虚幻引擎的烘焙、暂存和部署数据等更广泛的流程管线。

请看下图，了解虚幻引擎5.4的烘焙、暂存和部署管线。

![undefined](../../../../assets/images/57/572e87f523e03991031764de26fa2c903ae0fa241e2ffffaae84fe87408ae516.jpg)

其中数据的数量和大小是假设的，但均处于大型游戏项目的范畴之内。

如果从左到右查看管线，可以看到第一步是烘焙（Cook）操作，这时会加载 `.uasset` 文件以及来自派生数据缓存（DDC）的数据。从虚幻引擎5.4开始，DDC数据被单独存储在名为Zenserver的独立进程中。如图所示，该进程与虚幻编辑器同时运行。Zenserver将在内部决定如何在磁盘上表示和存储这些数据。

按照默认配置，烘焙输出文件会以大量独立文件的形式写入项目的 `Saved/Cooked/<Platform>` 文件夹中。文件的数量可能极大，写入的字节数也可能极大。

![undefined](../../../../assets/images/f8/f84a9127dd1834dc73c1cb2127c035b62b02450f169025feff67f1b4bb09fc89.jpg)

此等数量的文件会导致文件系统出现性能瓶颈。具体表现如下：

- 删除烘焙输出的操作冗长（15分钟以上）。即使是异步操作，也会导致文件系统写入缓存清空，从而影响其他I/O操作。
- 端点安全软件（如Windows Defender）会参与所有文件的打开/关闭操作，从而减慢运行速度。
- 文件系统元数据（如最后访问时间追踪）会导致文件系统写入缓存满额，从而不得不清空磁盘，进而降低烘焙的运行速度。

对于小型项目而言，这些问题不会花费太多时间，但随着项目规模的扩大，这些问题会越来越显著。

若改用将Zenserver作为烘焙输出存储，那么烘焙输出可以被存储在Zenserver中，而非零散文件中。

Zenserver会负责将烘焙输出以选定的表示形式写入磁盘。这意味着，如果小块数据的大小低于设定的阈值，那么它们就会被聚合到更大的文件块中。因此，在示例中，尽管存储的数据还是一百万条， **但文件系统看到的文件数量可能要小得多** 。

![undefined](../../../../assets/images/f4/f4af25cbbdf36b3fdcbd2af51f60e3fb797f0dd17b33ad5705e55612ff5d3fe7.jpg)

## 将Zenserver启用为烘焙输出存储

自虚幻引擎5.5起，默认不会将Zenserver作为烘焙输出存储。我们计划在未来版本中改变这一情况。至于现在，要转为在项目中使用Zenserver作为烘焙输出存储，请启动虚幻编辑器，选择[编辑（Edit） > 项目设置（Project Settings）](../../../understanding-the-basics/project-settings/index.md)菜单项，然后选择[项目（Project） > 打包（Packaging）](../../../understanding-the-basics/project-settings/project-section-of-the-unreal-engine-project-settings/index.md#%E6%89%93%E5%8C%85-2)分段。在该分段中，你会发现一个名为 **使用Zenserver作为烘焙输出存储（Use Zenserver as cooked output store）** 且默认禁用的设置项。

![Zenserver设置项](../../../../assets/images/66/6696aa2ec150a15070acbe124195a52bbd6fd30182e2aba9988974cb145c9921.png)

你可以启用该设置，并确保同时启用了 **使用Io存储（Use Io Store）** （默认启用）。如果这两项都启用了，请确保保存设置（如果你使用了源码控制，那么你可能还需要检查文件以保存设置的更改）。至此，你就会将Zenserver作为烘焙输出存储了。

## 将Zen作为烘焙输出存储时的烘焙数据位置

将Zen作为烘焙输出存储时，虚幻引擎仍会创建一些数据并写入项目的 `Saved/Cooked/<Platform>` 文件夹，但写入的数据 **数量会小得多** ，因为所有的烘焙资产数据都会被存储在Zenserver中。按照预计，此时的 `Saved/Cooked/<Platform>` 文件夹中应该 **不再包含** 任何 `.uasset` 、`.ubulk` 或 `.uexp` 文件。此位置应该仅会存在一个 `ue.projectstore` 文件，它是一个小型的内部描述符，用来说明烘焙数据的存储位置。引擎需要该文件才能找到并访问烘焙数据。

![ue.projectstore文件](../../../../assets/images/84/84276e536561290a5925fbd63ba7c453a43ab9c425e2935b03104885dff8cc6e.png)

那么，烘焙资产数据被存储到了哪里？ Zenserver会将数据保存在Zenserver数据目录下的文件中（其中部分为聚合文件）。这包括 **本地DDC和烘焙输出** 的数据。

Zenserver数据的默认位置如下：

- **Windows：** `%LOCALAPPDATA%\UnrealEngine\Common\Zen\Data`
- **Mac：** `~/Library/Application Support/Epic/UnrealEngine/Common/Zen/Data`
- **Linux：** `~/.config/Epic/UnrealEngine/Common/Zen/Data`

由于Zenserver也用于存储本地DDC，因此其数据存储位置将根据DDC的配置机制重载默认值：

- 虚幻编辑器DDC设置中设置了一个全局本地DDC路径。
- 用环境变量（ `UE-LocalDataCachePath` ）重载了本地DDC路径。
- 用命令行参数（ `-LocalDataCachePath=<path>` ）重载本地DDC路径。

最后，Zenserver专门的路径配置还将重载默认路径和本地的DDC路径配置选项：

- 用环境变量（ `UE-ZenDataPath` ）重载Zenserver路径。
- 用命令行参数（ `-ZenDataPath=<path>` ）重载Zenserver路径。

要为Zenserver数据（包括DDC和烘焙输出）选择适当的路径，建议使用[编辑（Edit） > 编辑器偏好设置（Editor Preferences）](../../../understanding-the-basics/foundational-knowledge-in/unreal-editor-preferences/index.md)菜单项设置全局本地DDC路径，然后选择通用（General） > 全局（Global）分段。

![编辑器偏好设置 > 通用 > 全局菜单选项](../../../../assets/images/28/28f8117e65249cd1f513246f9e6530ce42ed2768ba191aacd07d199c87a17bc9.jpg)

建议选择的全局本地DDC路径（以及潜在的Zenserver路径）符合以下条件：

- 快速、 **本地** 的驱动器。
- 非网络驱动器。
- 非虚拟驱动器，如Google Drive。

## 多个烘焙输出平台、项目和工作空间的存储

Zenserver为所有烘焙平台、项目和工作空间提供单一存储服务。它被设计为适用于不同平台、项目和工作空间，并存储单个或复数烘焙输出的数据，且不会让一处的数据覆盖另一处的数据。在内部，数据使用内容可寻址存储进行存储，从而具有去重优势。这意味着，如果你有两个项目烘焙同一段数据，并为目标平台生成相同的输出字节，那么Zenserver只会用你的硬盘将这些字节存储一次，且每个项目在底层内容可寻址存储层中都有对该Blob的引用。

## 数据删除和清理

在Zenserver中，烘焙输出数据会通过引用被存储到内容可寻址的存储层中。只要被引用，那么数据就会被保留。

Zenserver会定期执行垃圾回收。若在垃圾回收期间发现有数据不再有任何引用，那么该数据就会被删除，从而让你收回数据所占用的磁盘空间。

烘焙输出数据的引用由 `ue.projectstore` 文件控制。如果你向Zen存储烘焙了数据，它就会生成一个 `ue.projectstore` 文件，该文件将作为标识，表明对已烘焙数据的引用。在Zenserver内进行垃圾回收时，如果存在以下情况：

- `ue.projectstore` 文件已被删除
- `ue.projectstore` 文件的修改时间已超过14天

那么将视为烘焙数据对该烘焙输出不具有引用。如果所有烘焙输出都不包含对某一段数据的引用，那么该数据将被垃圾回收程序删除，磁盘上的占用空间将被收回。

## 检查和调试

存储在Zenserver中的烘焙输出数据在调试和检查能力方面存在限制。

与此同时，一个名为"虚幻Zen操作面板"（程序名：ZenDashboard）的小工具可用于检查Zenserver的基本统计数据，并发布一些基本的控制命令。要访问该工具，请点击编辑器右下方的 **衍生数据（Derived Data）** 按钮，然后选择 **启动Zen Dashboard（Launch Zen Dashboard）** 。

![undefined](../../../../assets/images/0a/0ac37e99155a5e059b9452eacc4462db84c8f01267eb4f5754b95c7d50af62ab.jpg)

如果你已将Zenserver启用为烘焙输出存储，那么你可能会遇到这样的情况：你想在文件系统中对零散文件运行烘焙，而不是将其存储在Zenserver中。为此，你可以在调用烘焙Commandlet时传递以下参数：

烘焙Commandlet

```
-skipzenstore
```

使用命令提示符工具与本地Zenserver交互，即可访问低级的调试功能。通过Zen Dashboard的 **工具（Tools） > 启动工具命令提示符（Launch Utility Command Prompt）** 菜单序列，即可访问该工具。

![启动工具命令提示符菜单选项](../../../../assets/images/5b/5bfde209d0d17773244b7ec9ea880199e11304237de98abbd34fdc677d41808e.jpg)

这样你就可以使用多个命令与本地Zenserver中的数据进行交互。

> 图片已省略：undefined

# 对暂存数据的影响

暂存（Staging）是内容管线中继烘焙后的下一步。暂存既可以由虚幻自动化工具（UAT）直接调用，也可以通过编辑器调用。这使得数据可以被暂存为下列文件：

- **容器文件** ：烘焙输出数据会被聚合并（可选）压缩成数个 `*.pak` 、 `*.utoc` 和 `*.ucas` 文件，文件位于项目的 `Saved/StagedBuilds/<Platform>` 目录下。
- **零散文件** ：烘焙输出数据会被一对一地复制到项目的 `Saved/StagedBuilds/<Platform>` 目录下的子目录中。

至于是暂存为容器文件还是零散文件，则取决于调用虚幻自动化工具时是否存在命令行参数 `-pak` 。将Zenserver用作烘焙输出存储会影响烘焙步骤的输出，这意味着暂存步骤也必须按照下文所述进行调整。

## 暂存为容器文件

将Zenserver作为烘焙输出存储时，若暂存为容器（ `*.pak` 、 `*.utoc` 、 `*.ucas` ）文件，将导致虚幻自动化工具（及其生成的UnrealPak可执行文件）从Zenserver获取烘焙输出数据，而不是从文件系统获取。

如果需要启动Zenserver来获取数据，虚幻自动化工具和UnrealPak都可以将其自动启动。若从Zenserver获取烘焙输出数据，那么数据将按照过去的方式进行聚合（以及可能的压缩）。这意味着暂存的输出与将Zenserver启用为烘焙输出存储之前的输出完全相同： `Saved/StagedBuilds/<Platform>` 目录将在相同的文件（包括相同的 `*.pak` 、 `*.utoc` 和 `*.ucas` 文件）中包含相同的数据，就如同你将Zenserver启用为烘焙输出存储前一样。

注意，暂存的构建目录将 **不** 包含 `ue.projectstore` 文件。

将Zenserver作为烘焙输出存储时，暂存为容器文件的整体内容管线如下：

> 图片已省略：undefined

## 暂存为零散文件（不含容器）

使用Zenserver作为烘焙输出存储时，暂存为零散文件的行为将大不相同。

暂存构建将不会复制烘焙输出文件，且完全不包含烘焙输出数据。这将大大缩小游戏在暂存目录和目标平台上的部署大小。相反，暂存构建将使用ue.projectstore文件，其中将包含用于存储烘焙输出数据的Zenserver的信息。

有了这个 `ue.projectstore` 文件，游戏运行时就能连接到Zenserver，并按需流送烘焙数据。如需更多信息，请参阅[Zen流送](../how-to-use-zenserver-streaming-to-play-on-target/index.md)文档。

使用Zenserver流送时的整体内容管线如下：

> 图片已省略：undefined
