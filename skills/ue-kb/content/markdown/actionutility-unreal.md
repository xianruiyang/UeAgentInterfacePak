# 使用 ActionUtility 脚本调整磁盘上的 Unreal 纹理大小

# 使用 ActionUtility 脚本调整磁盘上的 Unreal 纹理大小

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/mPML/unreal-engine-resize-unreal-textures-size-on-disk-using-actionutility-scripts

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 7649 字符。

## 摘要

了解如何使用 ActionUtility 脚本和图像处理工具调整磁盘上的纹理大小，从而有效地缩小虚幻引擎项目。

## 中文整理

### 介绍

调整磁盘上纹理的大小对于减小虚幻项目的整体大小至关重要，特别是因为纹理通常占据大部分空间。当您的硬盘驱动器上无法访问纹理时，这一挑战就变得显而易见，从而无法重新导入它们。幸运的是，我们已经有了一个解决方案，利用虚幻中的开源图像处理工具和资产操作实用程序。要完成此任务，请按照下列步骤操作： 1- **识别纹理使用情况**：利用 [WinDirStat](https://windirstat.net/) 或等效工具来显示磁盘使用统计信息并确认纹理是否占用了大部分空间。 2- **批量导出所有纹理**：使用虚幻的批量导出功能将所有纹理导出到项目的根文件夹。 3- **创建 ActionUtilityScript**：创建一个新脚本以将纹理的路径设置为导出的图像目录。 4- **调整磁盘上图像的大小**：使用首选工具调整磁盘上图像的大小。就我而言，我使用 **[ImageMagick](https://imagemagick.org/)** 和 **Shell 脚本 ** 来自定义结果，例如忽略已经很小的纹理并保持图像纵横比。 5- **重新导入虚幻中的所有纹理**：调整大小后，将所有纹理重新导入虚幻中。 6- **验证**：将结果与初始状态进行比较，以确保尺寸减小。出于演示目的，我将使用我从市场免费获得的 [Combat Systems - Constructor](https://www.unrealengine.com/marketplace/en-US/product/combat-systems-constructor) 和 [Modular Scifi Season 2 Starter Bundle](https://unrealengine.com/marketplace/en-US/product/modular-scifi-season-2-starter-bundle) 中的资源。每月关注市场，获取令人兴奋的免费内容。

### 1- 识别纹理的使用

在第一步中，重要的是要弄清楚纹理是否是我们项目尺寸问题的主要原因。为此，我们将使用一个为我们提供详细统计数据的工具。我在本教程中使用 [WinDirStat](https://windirstat.net/download.html)，但您可以选择任何您喜欢的工具。使用 WinDirStart 并将其设置为项目的“Content”文件夹。然后，像大多数侦探一样，展开它以揭示实际的磁盘空间罪魁祸首🔎。如示例所示，一个 3.5 GB 的项目，几乎 3 GB 都归因于纹理！

![3.5GB 项目大小，重点是纹理文件夹](assets/unreal-engine-resize-unreal-textures-size-on-disk-using-actionutility-scripts/image-01.jpg)

### 2-批量导出所有纹理

现在我们已经确定纹理是罪魁祸首，让我们继续将所有纹理从虚幻导出到磁盘。我们将过滤纹理并将整个集合导出到项目的根目录。

### 在虚幻中过滤纹理

首先，单击内容浏览器顶部的三行按钮来过滤纹理。

![过滤Content文件夹中的所有纹理](assets/unreal-engine-resize-unreal-textures-size-on-disk-using-actionutility-scripts/image-02.jpg)

### 选择和导出纹理

过滤纹理后，确保选择“内容”文件夹以显示所有纹理。使用 **Ctrl + A ** 全选，然后 **右键单击 **> **AssetAction **> **BulkExport**。

![批量导出所有选定的纹理](assets/unreal-engine-resize-unreal-textures-size-on-disk-using-actionutility-scripts/image-03.jpg)

### 设置导出路径

注意导出图片的路径。将它们导出到项目的根目录非常重要。

![将纹理导出到项目的根文件夹](assets/unreal-engine-resize-unreal-textures-size-on-disk-using-actionutility-scripts/image-04.jpg)

### 导出的纹理结构

导出的纹理应模仿内容文件夹的结构，但从“游戏”开始。每个 Unreal .uasset 都应该在同一位置有一个等效的 .png。

![项目“Content”文件夹模仿导出的“Game”文件夹](assets/unreal-engine-resize-unreal-textures-size-on-disk-using-actionutility-scripts/image-05.jpg)

### 了解路径重要性

为什么路径很重要？我们将修改源路径以重新导入图像并覆盖项目中现有的图像。默认源路径看起来像这样（可能是资产所有者位置上的路径）。

![.uasset 纹理文件的默认源路径](assets/unreal-engine-resize-unreal-textures-size-on-disk-using-actionutility-scripts/image-06.jpg)

### 3-创建一个 ActionUtilityScript

现在我们了解了修改源路径的必要性，让我们通过在虚幻中创建一个新的资产操作实用程序脚本来自动化此过程。

### 创建资产操作实用程序脚本

首先从虚幻中的蓝图菜单创建一个新的资产操作实用程序。

![创建新的资产操作实用程序](assets/unreal-engine-resize-unreal-textures-size-on-disk-using-actionutility-scripts/image-07.jpg)

### 添加新功能

在资产操作实用程序脚本中，添加一个新函数。可以通过右键单击资产并导航到脚本化资产操作来访问此功能。

![演示可以从脚本化资产操作运行自定义函数。](assets/unreal-engine-resize-unreal-textures-size-on-disk-using-actionutility-scripts/image-08.jpg)

### 蓝图代码

以下是资产操作实用程序的蓝图代码。

**修改源文件路径**

```
Begin Object Class=/Script/BlueprintGraph.K2Node_FunctionEntry Name="K2Node_FunctionEntry_1" ExportPath="/Script/BlueprintGraph.K2Node_FunctionEntry'/Game/AAU_test.AAU_test:Modify Source File Path.K2Node_FunctionEntry_1'"
   MetaData=(bCallInEditor=True)
   ExtraFlags=201457664
   FunctionReference=(MemberName="Modify Source File Path")
   bIsEditable=True
   NodePosX=-160
   NodeGuid=479C0C01448AC7A05779A38BB0808184
   CustomProperties Pin (PinId=6403ADB24CF6A96BF5BB4888A1E51FF4,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_CallFunction_15 0B4548244F83F5078B21B3A15EA66361,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
Begin Object Class=/Script/BlueprintGraph.K2Node_CallFunction Name="K2Node_CallFunction_15" ExportPath="/Script/BlueprintGraph.K2Node_CallFunction'/Game/AAU_test.AAU_test:Modify Source File Path.K2Node_CallFunction_15'"
```

### 执行工具

准备好资产操作实用程序脚本后，选择要修改的所有纹理。右键单击并导航到脚本化资产操作，然后选择函数名称来运行该工具。 **RightClick **> **ScriptedAssetAction **> **NameOfYourFunction** 运行该工具的结果是修改后的源路径，允许我们从磁盘上本地修改的图像导入。

![使用导出文件位置更新的 .uasset 纹理文件的源路径](assets/unreal-engine-resize-unreal-textures-size-on-disk-using-actionutility-scripts/image-09.jpg)

### 4-调整磁盘上图像的大小

可以使用各种外部工具（例如 GIMP、Photoshop 等）调整磁盘上图像的大小，这些工具能够同时修改多个图像。在本教程中，我将使用开源工具 [ImageMagick](https://imagemagick.org/script/download.php)，因为它在终端中易于使用，并结合一些 shell 脚本。

### 验证 ImageMagick 安装

打开终端并键入以下命令，确保 ImageMagick 已正确安装：

```
magick -version
```

### 创建外壳脚本

在从 Unreal 导出的“Game”文件夹中，创建一个扩展名为“.sh”的新文本文件。启用文件扩展名的显示以对其进行修改。如果提示有关 .sh 文件扩展名，请选择“是”。就我而言，我将其命名为 **Tool.sh**

![在导出的文件夹中创建 Tool.sh 文件](assets/unreal-engine-resize-unreal-textures-size-on-disk-using-actionutility-scripts/image-10.jpg)

### 外壳脚本代码

将代码复制并粘贴到 shell 脚本文件中并保存。

**调整图像大小（使用 ImageMagick）**

```
#!/bin/bash

# Specify the maximum dimension
max_dimension=512

# Image types to search for (Uncomment to add more files types)
#image_types="jpg\|jpeg\|png\|gif"
image_types="png"

# Initialize counters
```

### 理解代码

- 代码在调整大小时考虑图像的长宽比。 - 它循环遍历图像，检查宽度或高度是否超过所需的分辨率（在本例中为 512），然后调用 resize_image 函数。 - resize_image 函数使用 ImageMagick 将调整后的图像保存到位 - 一些用于进度跟踪的打印语句。要修改的变量是“max_dimension”和“image_types”，仅设置为“png”，上面有一个示例，显示如何添加更多扩展。

### 局限性

**resize_image **函数目前存在与仅基于 X 维度调整大小有关的限制，忽略 Y 维度。这可能会导致意外的输出。限制示例： - 给定图像 1024x2048，期望值为 512。一旦我们检查 X 大于 512，计算将基于 X，结果是 512x1024，Y 仍然大于 512。相反，它应该是 256x512

### 运行脚本

通过搜索如何运行 shell 脚本来执行脚本。例如，在 GitBash 终端中，使用命令 ./Tool.sh。

### 5-重新导入全部

假设前面的所有步骤均成功，我们现在可以使用操作实用程序脚本设置的修改后的源文件路径重新导入所有图像。 **过滤 **> **全选 **> **重新导入** 通过使用调整后的源文件路径重新导入图像，Unreal 将使用磁盘上本地修改的图像，完成减小项目中纹理大小的过程。

### 6-验证

完成所有步骤后，让我们使用 [WinDirStat](https://windirstat.net/download.html) 再次检查“Content”文件夹，以比较初始状态和最终状态。 **查看项目大小** 打开 WinDirStat 并分析“Content”文件夹以观察进程开始和结束之间的大小差异。 **尺寸减小成就** 项目大小现已从 **3.5 GB** 减小到仅仅 **700 MB**，减少了** 80%**。请注意，出于本示例的目的，我们有意将纹理从 4k 减少到 512，以展示该过程的有效性。通过遵循本指南，您已成功优化并减小了虚幻项目中的纹理大小。干得好！

