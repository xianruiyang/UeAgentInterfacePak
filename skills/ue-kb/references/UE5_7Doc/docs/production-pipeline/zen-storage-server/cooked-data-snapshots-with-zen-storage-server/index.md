---
title: "Zenserver烘焙数据快照"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/cooked-data-snapshots-with-zen-storage-server-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Zen存储服务器", "Zenserver烘焙数据快照"]
---

# Zenserver烘焙数据快照

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Zen存储服务器 / Zenserver烘焙数据快照

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/cooked-data-snapshots-with-zen-storage-server-for-unreal-engine

在采取步骤使用烘焙数据快照之前，请确保你已按照[将Zenserver作为烘焙输出存储](../using-zen-storage-server-as-cooked-output-store/index.md)中的描述，将Zen存储服务器（Zenserver）启用为烘焙输出存储。

使用烘焙数据快照的目如下：

- 避免对自动化系统在他处编译的数据进行重复烘焙。
- 在未来以自动化系统在他处生成的构建为基础，进行增量烘焙。
- 高效地对尚未拥有的烘焙数据片段进行Delta下载。

总的来说，达成这些目的的方法在于为用户提供便捷的方式，让他们针对自己的构建获取在他处生成的烘焙数据，并在此基础上对本地修改进行烘焙。

归根结底，烘焙数据快照的概念很简单。若Zenserver作为烘焙输出存储，你应该可以从Zenserver中的源位置导出项目和目标平台的烘焙输出，并将其导入至目标位置。

这种导出/导入行为应该具备以下特点：

- **完整：** 在目标位置执行的任何操作，其结果都应与在进行烘焙的源位置执行的操作相同，具体包括：

  - 暂存为容器文件（ `.pak`/`.utoc`/`.ucas` ）。
  - 使用[Zenserver流送](../how-to-use-zenserver-streaming-to-play-on-target/index.md)运行游戏。
  - 对源位置烘焙数据集时不属于数据集的其他更改进行增量烘焙。
- **高效：** 只会复制目的地尚不存在的数据。
- **灵活：** 可以将数据存储在以下任意一种存储机制中：

  - 虚幻云DDC
  - 虚幻Zenserver
  - 文件档案

## 快照描述符

快照中的烘焙数据可使用 **描述符** 结构进行引用，该结构包含烘焙数据的存储方式、位置以及所含内容。快照描述符一般用JSON表示为文件系统或其他存储媒介中的文件。以JSON表示的描述符示例如下：

JSON描述符

```
	{ 		"snapshots": [ 			{ 				"name": "lyra.lyra-package-and-test.lyra-cl-35690018.e0ebea.ece6.windows", 				"type": "cloud", 				"targetplatform": "Windows", 				"host": "https://cloud-ddc.example.com", 				"namespace": "myproject.oplog", 				"bucket": "ue5-main.windows", 				"key": "4302aee18444cb9e9cff59fc079319cc9ac27c0e" 			} 		] 	}
```

## 将自动化构建中的烘焙数据导出至快照

### 使用引擎提供的BuildAndTestProject.xml构建图表

引擎附带的示例构建图表位于 `Engine\Build\Graph\Tasks\BuildAndTestProject.xml` 。它包含用于导出快照的基础结构。如果你已经用过该构建图表来生成自动化构建，那么你可以利用它将快照导出，并按照下文各节所述的存储机制进行存储。

无论烘焙输出数据使用哪种存储机制，快照都会创建一个小型快照描述符文件，并写入到指定的 `NetworkSnapshotDescFileRoot` 位置下的子目录。**快照描述符文件包含用户以后获取快照所需的所有信息** 。

### 虚幻云DDC存储的快照

1. 选择一个命名空间来存储快照（例如 `myproject.oplog` ）。务必确保该命名空间由虚幻云DDC管理员创建。
2. 将构建图表中的 `NetworkSnapshotDescFileRoot` 属性设置为将用于存储快照描述符文件的网络文件服务器位置的路径。例如，`\\myfileshare\Builds\Snapshots` 。
3. 运行构建图表时，将 `PublishCloudSnapshot` 选项设置为True。
4. 将环境变量 `UE-CloudPublishHost` （或Mac或Linux的 `UE_CloudPublishHost` ）设置为快照导出目标虚幻云DDC服务器的主机名和模式。例如 `https://cloud-ddc.example.com`
5. 将环境变量 `UE-CloudPublishNamespace` （或Mac或Linux的 `UE_CloudPublishNamespace`）设置为在步骤1所选的命名空间。例如 `myproject.oplog` 。

在使用虚幻云DDC存储的快照时，最好能够确定快照的最新/基础版本，以作为组成和存储新快照时的参考。这有助于最大限度地消除连续快照之间的重复存储。为实现这一点， `BuildAndTestProject.xml` 构建图表会使用虚幻Horde构建系统提供的环境变量：

- `UE_HORDE_JOBID`
- `UE_HORDE_STEPID`
- `UE_HORDE_TEMPLATEID`
- `UE_HORDE_LAST_WARNING_CL`

若缺乏这些环境变量，那么由虚幻自动化工具（UAT）调用的 `BuildAndTestProject.xml` 仍会生成快照，并将其存储到虚幻云DDC中，但连续快照之间会出现更多重复数据，进而导致数据存储需求随着时间的推移而变大。

### 虚幻Zenserver存储的快照

1. 将构建图表中的 `NetworkSnapshotDescFileRoot` 属性设置为将用于存储快照描述符文件的网络文件服务器位置的路径。例如，`\\myfileshare\Builds\Snapshots` 。
2. 运行构建图表时，将 `PublishZenSnapshot` 选项设置为True。
3. 将环境变量 `UE-ZenPublishHost` （或Mac或Linux的 `UE_ZenPublishHost` ）设置为快照导出目标虚幻Zen服务器的主机名和模式。例如 `https://shared-zen.example.com:8558`

## 使用自定义构建图表

如果你使用自有构建图表，而不用引擎提供的 `BuildAndTestProject.xml` 图表，那么你可以使用自有构建图表中的 `ZenExportSnapshot` 任务，将存储在构建机器本地Zenserver中的烘焙输出导出至以下任一目标：

- 虚幻云DDC服务器
- 另一个Zenserver
- 文件档案

摘自 `BuildAndTestProject.xml` 的使用示例：

BuildAndTestProject.xml

```
	<ZenExportSnapshot 	Project="$(TargetProject)" Platform="$(CookPlatform)" 	DestinationStorageType="Cloud" 	DestinationCloudHost="$(UE-CloudPublishHost)" 	DestinationCloudHttpVersion="$(UE-CloudPublishHttpVersion)" 	SnapshotDescriptorCloudHost="$(UE-CloudPublishDescriptorHost)" 	SnapshotDescriptorCloudHttpVersion="$(UE-CloudPublishDescriptorHttpVersion)" 	DestinationCloudNamespace="$(UE-CloudPublishNamespace)" 	DestinationCloudBucket="$(EscapedBranch).$(CookPlatform)" DestinationIdentifier="$(SnapshotIdentifier)" 	SnapshotDescriptorFile="$(SnapshotLocalDir)/$(StagedPlatformFolder)/$(SnapshotFilenamePrefix)-cloud.json" 	SnapshotBaseDescriptorFile="$(SnapshotBaseDescriptorFile)" 	/>
```

`Engine\Source\Programs\AutomationTool\BuildGraph\Tasks\ZenExportSnapshotTask.cs` 源文件中记录了该任务的所有参数。

> [!NOTE]
> 尽管并非必须，但还是强烈建议你这样做：在将快照存储到虚幻云DDC时，使用 SnapshotBaseDescriptorFile参数，以便在制作新快照时尽可能多地与上一个快照发生重叠和去重。这将有助于减少虚幻云DDC中快照对磁盘的占用。

## 从快照导入烘焙数据

### 通过ushell

#### 使用.zen命令

你可以在ushell中使用 `.zen` 命令来导入由快照描述符文件所描述的快照。例如，如果你导出了项目变更列表/修订版777中Android烘焙数据的快照，那么快照描述符可能被写入以下位置：

文件位置

```
	\\myserver\myshare\CloudSnapshots\mystream\myproject\Android_ETC2\777\name-cloud.json
```

此快照描述符的内容包含了导入烘焙输出数据所需的充足信息。在ushell命令提示符中，发出以下命令即可导入：

ushell命令

```
	.zen importsnapshot \\myserver\myshare\CloudSnapshots\mystream\myproject\Android_ETC2\777\name-cloud.json
```

导入快照后，烘焙输出目录将只包含单个名为 `ue.projectstore` 的文件，如图所示：

![包含ue.projectstore文件的烘焙输出目录](../../../../assets/images/8b/8bfcaad87728bce146c64cd50841a4ce5c5345ae9306b9e563d5127dc0c79e9f.png)

其余数据将被存储在Zenserver中。这时，你就相当于亲自在变更列表777中为Android平台烘焙了项目。接下来你可以：

- 用容器（ `.pak`/`.utoc`/`.ucas` ）或用[Zen流送](../how-to-use-zenserver-streaming-to-play-on-target/index.md)进行构建的暂存/部署/运行。
- 未来：进行增量烘焙，以应用位于本地但不属于变更列表777的其他更改。

下面是导入快照、编译游戏可执行文件并在Android上暂存/部署/运行构建所需的端到端命令示例：

ushell命令

```
	.zen importsnapshot \\myserver\myshare\CloudSnapshots\mystream\myproject\Android_ETC2\777\name-cloud.json 	.build game android 	.stage game android 	.deploy game android 	.run game android
```

如果你的游戏使用的构建包含了独立的客户端和服务器运行时可执行文件，则该命令将被改为运行客户端运行时，而不是游戏运行时。具体如下：

ushell命令

```
	.zen importsnapshot \\myserver\myshare\CloudSnapshots\mystream\myproject\Android_ETC2Client\777\name-cloud.json 	.build client android 	.stage client android 	.deploy client android 	.run client android
```
