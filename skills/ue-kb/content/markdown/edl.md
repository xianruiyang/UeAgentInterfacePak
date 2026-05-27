# 导入和导出编辑决策表（EDL）

---
title: "导入和导出编辑决策表（EDL）"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/import-and-export-edl-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "过场动画流程指南和示例", "导入和导出编辑决策表（EDL）"]
---

# 导入和导出编辑决策表（EDL）

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / 过场动画流程指南和示例 / 导入和导出编辑决策表（EDL）

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/import-and-export-edl-in-unreal-engine

虚幻引擎中的序列器不仅允许你渲染和导出整个过场动画，还可以导出分割成每一个镜头的过场动画以及一个 **编辑决策表（Edit Decision List）**(**EDL**)，这是一个适用于大多数视频编辑应用程序（例如Premiere、Avid或Final Cut）的文件。

EDL包含一个由卷盘和时间码数据构成的有序列表，该列表反映了每个视频片段可在何处获得以生成最终剪辑。 在本指南中，我们将导出一个过场动画和EDL文件，将其导入一个外部程序（如Premiere）中，对其进行编辑，并将编辑后的过场动画连同这些更改一起重新导入UE4。

## 步骤

> [!NOTE]
> 对于本指南，我们使用的是 **蓝图第三人称模板（Blueprint Third Person Template）**，同时创建了一个示例过场动画；但是，你可以使用自己的项目和过场动画序列。 我们还使用Adobe Premiere Pro CS6作为我们的外部编辑软件；但是，你可以使用任何支持EDL导入的软件。

1. 确保要导出的过场动画包括含有你的镜头的 **镜头轨迹（Shot Track）**，然后单击 **渲染影片（Render Movie）** 按钮。
2. 将 **输出格式（Output Format）** 设置为 **视频序列（Video Sequence）**，使用 **{shot}** 标记选择 **输出目录（Output Directory）** 和 **文件名格式（Filename Format）**，然后启用 **写入编辑决策表（Write Edit Decision List）**。

   在这里，我们将显示要导出的示例过场动画（以及EDL），然后单击 **渲染影片（Render Movie）** 按钮，以打开设置对话框窗口。在设置窗口中，我们将创建一个作为该过场动画导出目标的新文件夹，并在 **{shot}** 标记前面加上该过场动画的名称。通过使用 **{shot}** 标记，我们的每个镜头将作为单独的视频文件同整个过场动画一起导出。

   > [!NOTE]
   > 你必须将 **输出格式（Output Format）** 设置为 **视频序列（Video Sequence）** 才能使其生效，因为它不适用于单独的帧。
3. 将上一步导出的 **EDL** 文件导入到你的外部视频编辑软件中。

   在Premiere Pro中，你可以在窗口左下角单击右键，选择 **导入（Import）**，然后指向该EDL文件。
4. 将EDL中的数据链接到外部视频编辑软件中的导出媒体文件。

   在Premiere Pro中，你可以右键单击媒体文件夹，选择 **链接媒体（Link Media）**，然后将每个文件指向对应的媒体文件。
5. 在外部视频编辑软件中根据需要修改镜头，然后 **导出（Export）** 为 **EDL**。

   对于我们的示例场景，我们将调整镜头的长度，并重新排列它们在序列中的位置。
6. 回到UE中的序列，右键单击 **镜头轨迹（Shot Track）** 和 **导入EDL（Import EDL）**。

   我们在外部所做的更改现在反映在UE4中的序列中。

## 最终结果

Sequencer中的导入/导出EDL选项使你能够灵活地决定要在何处进行编辑。 你可以在Sequencer中进行大部分的设置，然后将序列传递到外部应用程序的编辑器（如Premiere）来执行最后的修饰，编辑器可以随后将其传回给你以在Sequencer进行调整。 通过将序列导出为EDL并在外部进行处理，你能够在渲染最终过场之前向场景添加后期制作效果（或后期效果）。

另外，在渲染序列并导出EDL时，你可以向每个镜头自动添加 **帧柄（Frame Handles）**，并定义要包含在其中的帧数。

这些额外的帧填充每个镜头并由EDL切进切出，EDL可用于在外部视频编辑包中调整镜头之间的切换。

