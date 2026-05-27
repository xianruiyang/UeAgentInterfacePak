# 将Control Rig用于USD动画

---
title: "将Control Rig用于USD动画"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-control-rig-with-usd-files-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "通用场景描述（USD）", "将Control Rig用于USD动画"]
---

# 将Control Rig用于USD动画

> 路径：虚幻引擎5.7文档 / 管理内容 / 通用场景描述（USD） / 将Control Rig用于USD动画

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-control-rig-with-usd-files-in-unreal-engine

**USD导入器（USD Importer）** 可以使用 **Control Rig** 从打开的USD舞台烘焙并直接操控骨骼动画。接着，它可以在USD文件中保存并维护对动画的更改。本指南详细介绍了该工作流程，并提供了其中一些配置选项的参考。

## 概述

当你在 **USD舞台（USD Stage）** 窗口中将Control Rig绑定到SkelRoot图元时，USD导入器会自动执行以下过程：

- 将Control Rig轨道添加到

  Sequencer

  。
- 从头到尾运行整个动画，针对每帧动画将关键帧添加到Control Rig。
- 禁用骨骼动画分段。

因此，Control Rig针对每一帧动画有一个关键帧，并且实际上控制着动画。更改可以保存到USD文件，该文件在会话之间保留动画数据。这可减少在引擎内快速编辑动画所需的繁琐工作量。

> [!TIP]
> 如需了解如何减少此过程中自动生成的关键帧数量，请参阅下面有关[减少关键帧](#%E5%87%8F%E5%B0%91%E5%85%B3%E9%94%AE%E5%B8%A7)的小节。

## 1. 必要设置

要使用USD导入器，你需要在 **编辑（Edit）** > **插件（Plugins）** 菜单中启用 **USD导入器（USD Importer）** 插件，并在启用插件后重启编辑器。

![undefined](../../../../assets/images/9b/9b1ddaf4aaba633db3498cb732e2cbda4c8d778b1cf1d8c2e6259a0df9475a33.jpg)

点击查看大图。

本指南使用通过 **第三人称模板（Third-Person template）** 创建的新项目。这包括虚幻引擎人体模型和 `CR_Mannequin_Body` Control Rig。这两者都可在 **内容浏览器（Content Browser）** 中的 `Content/Mannequins` 文件夹中找到。

本指南使用这些资产作为演示，但是你在按指南操作时不一定要使用这些资产。你可以采用任意骨骼网格体，只要你已经为该网格体创建了Control Rig即可。如需详细了解如何使用Control Rig，请参阅[Control Rig](../../../animating-characters-and-objects/control-rig/index.md)文档。

## 2. 导出USD文件

要利用USD舞台中的功能设置Control Rig，你需要导出想要编辑的动画的USD。

1. 选择动画资产和该资产的骨骼网格体对应的Control Rig。本示例使用的是第三人称模板中的以下资产：

   - 动画资产： Content/Characters/Mannequins/Animations/Manny/MM_Walk_InPlace
   - Control Rig： Content/Characters/Mannequins/Rigs/CR_Mannequin_Body
2. 在 **内容浏览器（Content Browser）** 中右键点击 **动画** ，然后点击 **资产操作（Asset Actions）** > **导出（Export）** 。

   ![undefined](../../../../assets/images/ff/ff7e30074254df02ec3f942f06ff2f6653f6c1909e4e73fd5ee1b9c3f2136d1c.jpg)

   点击查看大图。
3. 在导出对话框中，选择 **通用场景描述文件（Universal Scene Description file (*.usda)）** 作为文件类型，然后点击 **保存（Save）** 。

   ![undefined](../../../../assets/images/27/275e4736cf7d1ab1b45949e4fca2802adafcbf18d9d7f89c9cb71b965d668a39.png)

   点击查看大图。
4. 在 **USD导出选项（USD Export Options）** 对话框中，点击 **导出（Export）** 。

   ![配置USD导出选项](../../../../assets/images/35/351d714af88bb417472ca8a01a3ba1734421170193eb2d65254a6430539cd1aa.jpg)

## 3. 在USD舞台中设置Control Rig

现在你已拥有动画的USD文件，可以使用USD舞台编辑器将其打开，并使用Control Rig进行设置了。

1. 点击 **窗口（Window）** > **虚拟制片（Virtual Production）** > **USD舞台（USD Stage)** ，打开 **USD舞台（USD Stage）** 编辑器。

   ![从“窗口 > 虚拟制片”打开USD舞台窗口](../../../../assets/images/31/31d2ae80774fee59baa59477524dcf6cad2bced4456021188116ef7da1bd94a7.jpg)
2. 在USD舞台窗口中，点击 **文件（File）** > **打开（Open）** ，然后选择你的动画的 `.usda` 文件，并在打开的文件对话框中点击 **打开（Open）** 。

   ![undefined](../../../../assets/images/04/041fca8d10a033355a7cba6c342c9cbd4817a3281eb63fb9a50dc3ae69daa632.png)

   点击查看大图。

   模型将显示在世界的原点处。
3. 在 **USD舞台（USD Stage）** 窗口中，右键点击骨架的 **根骨骼** ，然后点击 **设置Control Rig（Set Up Control Rig）** 。

   ![在USD舞台中设置Control Rig](../../../../assets/images/56/565ce376f837f4ce1a487a13bc0ad7020ba9b08fbd14917825faa60ff4f032eb.jpg)
4. **集成（Integrations）** 面板将显示在舞台层级右侧。将 **Control Rig资产** 设置为骨骼网格体的Control Rig。

   ![在集成面板中设置Control Rig资产](../../../../assets/images/72/72c16ef038309bf4f776118c7859a76cde734a09f87c5fcaa750649ae22c111e.jpg)
5. 如果你看不到Sequencer窗口，请在你的世界的 **层级（Hierarchy）** 中点击 **USD舞台Actor（USD Stage Actor）** ，然后双击 **细节（Details）** 面板中的 **关卡序列（Level Sequence）** 。

   > 图片已省略：USD舞台Actor的细节面板中的Sequencer资产
6. 在 **Sequencer** 轨道列表中点击新创建的 **Control Rig** 轨道。

   - 在本示例中，Control Rig名为称为

     CR_Mannequin_Body

     。

   > 图片已省略：undefined

   点击查看大图。

## 结果

Rig的控制点将显示在世界中的网格体上。现在你可以使用Sequencer和Control Rig编辑现有动画或从头创建新的动画了。系统只要检测到更改，就会将其写出到USD舞台，然后可以将其保存到磁盘上的文件。

## 配置

为Control Rig设置SkelRoot图元时，系统将为其提供一些属性，这些属性可以被配置为USD舞台集成面板上的以下选项。

### 正向运动学Control Rig

**使用FKControlRig（Use FKControlRig）** 设置将禁用你选择的Control Rig资产，改为使用默认的正向运动学Rig，使每个骨骼有一个控制点。你可以将其用于尚未创建国Control Rig的骨骼网格体。

### 减少关键帧

要减少自动生成的关键帧数量，请在集成面板中启用 **Control Rig关键帧缩减（Control Rig key reduction）** 设置。这会删除类似于之前关键帧的关键帧，依靠系统在保留的关键帧之间做补间动画。你可以使用 **Control Rig关键帧缩减容差（Control Rig key reduction tolerance）** 设置来更改关键帧缩减的灵敏度。该值越高，减少关键帧的数量就越多。

> 图片已省略：undefined

点击查看大图。

