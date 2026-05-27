# 在Composure中使用OpenColorIO转换颜色

---
title: "在Composure中使用OpenColorIO转换颜色"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/converting-colors-in-composure-with-opencolorio-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "Real-Time Compositing with Composure", "在Composure中使用OpenColorIO转换颜色"]
---

# 在Composure中使用OpenColorIO转换颜色

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / Real-Time Compositing with Composure / 在Composure中使用OpenColorIO转换颜色

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/converting-colors-in-composure-with-opencolorio-in-unreal-engine

本文介绍了如何在[Composure](https://dev.epicgames.com/documentation/404)中，将[OpenColorIO](../../../managing-color/color-management-with-opencolorio/index.md) (**OCIO**)颜色转换应用至输入和输出媒体。

## 先决条件

你必须在项目中设置以下内容才能完成后续内容：

- 一个 **OpenColorIO配置资产（OpenColorIO Configuration Asset）** 。请参阅[OpenColorIO快速入门](../../../managing-color/color-management-with-opencolorio/opencolorio-quick-start/index.md)了解创建此资产的步骤。
- 含有效 **媒体源（Media Source）** 和 **输出（Output）** 的 **Composure元素（Composure Element）** 。请参阅[实时合成快速入门](../realtime-compositing-quick-start/index.md)了解设置这些要素的步骤。

## 在Composure中转换媒体元素

此过程旨在说明如何为Composure元素创建新的 **变换通道（Transform Pass）** ，以及如何设置该变换通道，以便将元素媒体源的颜色空间从一种颜色配置文件转换为另一种。

1. 在 **大纲视图（Outliner）** 中，选择 **Composure元素（Composure Element）** 以打开其 **细节（Detail）** 面板。
2. 在 **细节（Detail）** 面板中的 **Composure > 变换/合成通道（Transform/Compositing Passes）** 分段下，点击 **添加(+)（Add (+)）** 添加新的变换通道条目。

   ![添加新变换通道](../../../../../assets/images/9b/9b42fdc33ab2b6c1c44b50c4b14c20bc3d347c2af44fb9292a4f6e736f5614da.png)
3. 在新 **变换通道（Transform Pass）** 的设置中，打开 **下拉菜单**，然后从列表中选择 **OpenColorIO通道（OpenColorIO Pass）** 。

   ![将变换通道设置为OpenColorIO通道](../../../../../assets/images/cc/cc5a1512258ea92db24032a4d9c989eb35d66bf408c08a38cc9d4e4c5cfb60a0.png)
4. 展开你的 **变换通道（Transform Pass）** 的设置，然后展开其 **颜色转换设置（Color Conversion Settings）** 。

   ![展开颜色转换设置](../../../../../assets/images/62/624e61893c9b68ee18ebfafa97a12aa1df5f01b66a3b0f570d9acf6470285981.png)
5. 在颜色转换设置（Color Conversion Settings）下：

   1. 将 **配置源（Configuration Source）** 参数设置为指向 **OpenColorIO配置资产（OpenColorIO Configuration Asset）** 。
   2. 将 **源颜色空间（Source Color Space）** 参数设置为作为转换源的颜色配置文件。这通常是最初捕获媒体源的颜色空间。
   3. 将 **目标颜色空间（Destination Color Space）** 参数设置为要转换到的颜色配置文件。通常情况下，你可能需要使用 **线性** 颜色空间，以便媒体与虚幻引擎中使用的线性颜色空间相匹配。
   4. 勾选 **启用（Enabled）** 设置。

   ![设置颜色转换设置](../../../../../assets/images/45/45d3dd4f4f2c8ab6637c31e25a029d7a98882de08b2a039c4eb19c3146f26148.png)
6. 为变换通道设置了源和目标颜色空间后，你立刻可以在Composure元素预览和关卡视口中看到媒体源中的颜色发生变化。

## 在Composure中转换媒体输出

此过程展示了如何使用新的色彩校正通道设置Composure的输出，该通道将合成媒体的颜色从一个OCIO颜色配置文件转换为另一个。

1. 在 **大纲视图（Outliner）** 中，选择 **Composure元素（Composure Element）** 以打开其 **细节（Detail）** 面板。
2. 在 **细节（Detail）** 面板中的 **Composure > 输出（Output）** 下 ，展开 **输出通道（Output Pass）** 。

   ![展开输出通道](../../../../../assets/images/0d/0d98655232f05f77af8d9f56dcca72ca48bd79aed8871f1f5346e084752fb788.jpg)
3. 在新 **输出通道（Output Pass）** 的设置中，打开 **下拉菜单**，然后从列表中选择 **OpenColorIO通道（OpenColorIO Pass）** 。

   ![将输出通道设置为OpenColorIO通道](../../../../../assets/images/d6/d626a21c1d5546f62c1dd48e79dc47add1d6fbc86ef13ca9a32260b0ceed0271.png)
4. 展开 **输出通道（Output Pass）** 的 **颜色转换（Color Conversion）** **设置（Settings）** 。在颜色转换设置（Color Conversion Settings）下：

   1. 将 **配置源（Configuration Source）** 参数设置为指向 **OpenColorIO配置资产（OpenColorIO Configuration Asset）** 。
   2. 将 **源颜色空间（Source Color Space）** 参数设置为作为转换源的颜色配置文件。通常情况下，你可能需要使用 **线性** 颜色空间，以便媒体与虚幻引擎中使用的线性颜色空间相匹配。
   3. 将 **目标颜色空间（Destination Color Space）** 参数设置为要转换到的颜色配置文件。通常情况下，你可能需要匹配监控器所使用的颜色空间才能显示结果，或者匹配你需要的另一个目标颜色空间。
   4. 开启 **启用（Enabled）** 设置。

   ![设置颜色转换设置](../../../../../assets/images/45/45d3dd4f4f2c8ab6637c31e25a029d7a98882de08b2a039c4eb19c3146f26148.png)
5. 在显示合成媒体时，颜色会发生变化。

