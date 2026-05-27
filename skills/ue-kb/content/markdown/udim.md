# 使用 UDIM 烘烤静态网格物体的材料

# 使用 UDIM 烘烤静态网格物体的材料

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/BJVk/unreal-engine-bake-out-materials-for-static-mesh-with-udims

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 3500 字符。

## 摘要

这是使用 UDIM 在静态网格物体上烘焙材质的解决方法。

## 中文整理

### 概览

最近，有人问我如何使用 UDIM 烘焙静态网格物体的材质。在 UE5.3 和 UE5.4 中，烘焙材质不适用于 UDIMS。这意味着它只会烘焙 UDIM 1001 或 UV 空间 0-1 中的内容。 Epic Games 工程师正在研究解决方案；同时，这里有一个解决方法。主要技巧是应用纹理 UV 偏移来烘焙每个 UDIM。如果您不熟悉 UE 中的 UDIM 支持，请阅读本文档。为了说明此解决方法，我使用一个简单的平面，其 UV 覆盖 16 个 UDIM 块。它是一种简单的材质，具有 UDIM 虚拟纹理、程序噪声和可平铺纹理。两个纹理都有一个共享的偏移 UV 参数，这是此解决方法的关键组成部分。

![教程图片](assets/unreal-engine-bake-out-materials-for-static-mesh-with-udims/image-01.jpg)


![教程图片](assets/unreal-engine-bake-out-materials-for-static-mesh-with-udims/image-02.jpg)


### 烘焙UDIM 1001

准备好烘焙材质后，请转到所需资源的静态网格体编辑器。

在“资源”菜单下，单击“烘焙材料”。将弹出“材质烘焙选项”菜单。

- 选择最终代理材料的混合模式。

选择最终代理材料的混合模式。

- 选择要支持的所需 LOD。

选择要支持的所需 LOD。

- 如果您在材质图上使用程序纹理，则通过选中“使用网格数据”可以获得更准确的结果。如果您在材质图上使用程序纹理，则通过选中“使用网格数据”可以获得更准确的结果。 - 选择要烘焙的纹理坐标。

选择要烘焙的纹理坐标。

- 选择您想要烘焙的一个或多个材质通道。

选择要烘焙的一个或多个材质通道。

- 以及材质烘焙的输出分辨率。

以及材质烘焙的输出分辨率。

单击“确认”后，指定材质通道的 UDIM 1001 将被烘焙并应用于瞬态材质。

如果您尝试浏览到新的临时材料的位置，它将指向内容浏览器中您的关卡 (umap) 的位置。

您将无法轻松找到该材料。

如果您浏览工具提示中的路径，您将找不到新材料。

双击该瞬态材料。

烘焙后的 1001 UDIM 的瞬态纹理将出现在 BaseColorTexture 上。

接下来，另存为瞬态烘焙的 UDIM 1001 纹理，以便稍后导出。

在文件名末尾添加相应的 UIDM 值。

现在您已将 UDIM 1001 烘焙材质作为 uasset 纹理。

![教程图片](assets/unreal-engine-bake-out-materials-for-static-mesh-with-udims/image-03.jpg)


![教程图片](assets/unreal-engine-bake-out-materials-for-static-mesh-with-udims/image-04.jpg)


![教程图片](assets/unreal-engine-bake-out-materials-for-static-mesh-with-udims/image-05.jpg)


![教程图片](assets/unreal-engine-bake-out-materials-for-static-mesh-with-udims/image-06.jpg)


![教程图片](assets/unreal-engine-bake-out-materials-for-static-mesh-with-udims/image-07.jpg)


![教程图片](assets/unreal-engine-bake-out-materials-for-static-mesh-with-udims/image-08.jpg)


![教程图片](assets/unreal-engine-bake-out-materials-for-static-mesh-with-udims/image-09.jpg)


### 烘焙UDIM 1002

返回所需资源的静态网格物体编辑器，并将瞬态材质替换为原始材质。打开材质实例，以便您可以更改纹理 UV 偏移参数。对于 UDIM 1002，我们将 U 参数偏移 1 个单位。重复您之前使用的材料烘焙选项。对您的资产拥有的尽可能多的 UDIM 重复这些步骤。

![教程图片](assets/unreal-engine-bake-out-materials-for-static-mesh-with-udims/image-10.jpg)


### 批量导出纹理

烘烤完材料后。您将需要批量导出纹理。

### 将烘焙的 UDIM 纹理导入为虚拟纹理。

当您导入一张UDIM格式的纹理（纹理名称以大于1001的值结尾）时，UE会自动将其转换为虚拟纹理UDIM资源。现在，您可以复制原始材质并用单次烘焙纹理替换所有纹理图，或者使用烘焙纹理创建更简单的材质。下面，您可以看到左侧具有复杂材质图的平面与右侧具有烘焙材质的平面进行了比较。注意：渲染的差异是由于高光击中左下角造成的。 - 材料 - 环境艺术

## 相关链接

- [Baking UDIM 1001](https://dev.epicgames.com/community/learning/tutorials/BJVk/unreal-engine-bake-out-materials-for-static-mesh-with-udims#bakingudim1001)
- [Baking UDIM 1002](https://dev.epicgames.com/community/learning/tutorials/BJVk/unreal-engine-bake-out-materials-for-static-mesh-with-udims#bakingudim1002)
- [Bulk export textures](https://dev.epicgames.com/community/learning/tutorials/BJVk/unreal-engine-bake-out-materials-for-static-mesh-with-udims#bulkexporttextures)
- [Import your baked UDIM textures as Virtual Textures.](https://dev.epicgames.com/community/learning/tutorials/BJVk/unreal-engine-bake-out-materials-for-static-mesh-with-udims#importyourbakedudimtexturesasvirtualtextures)


