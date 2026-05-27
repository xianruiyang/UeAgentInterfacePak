# DMX Pixel Mapping

---
title: "DMX Pixel Mapping"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/dmx-pixel-mapping-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "与媒体组件通信", "DMX", "DMX Pixel Mapping"]
---

# DMX Pixel Mapping

> 路径：虚幻引擎5.7文档 / 使用媒体 / 与媒体组件通信 / DMX / DMX Pixel Mapping

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/dmx-pixel-mapping-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

像素映射是分析输入图像或视频的过程：定义感兴趣区域，计算每个区域的平均像素值，然后使用某种协议（例如 DMX）将这些值发送到另一个系统，以控制物理设备。

使用 Unreal Engine 中的 DMX Pixel Mapping 工具采样指定纹理的像素，并将颜色样本作为 DMX 输出。该工具会与 Unreal Engine 中其他 DMX 插件集成，并使用 **DMX Library** 资产和 **DMX Protocol** 功能。

## 工作流

### 创建新的 Pixel Mapping 资产

要创建新的 **Pixel Mapping** 资产，请执行以下步骤：

1. 在

   Content Browser

   中右键点击，导航到

   DMX

   分类并选择

   DMX Pixel Mapping

   .

在 **Content Browser** 中双击 Pixel Mapping 资产，在 Pixel Mapping 编辑器中打开它。

### 添加 Input Source

创建新的 DMX Pixel Mapper 资产时，会自动创建一个默认 Input Source。可以编辑该 Input Source，也可以点击顶部菜单栏中的 **Add Source** 创建新的 Input Source。

创建并选择 Source 后，可以在 **Input Texture** 中设置 **Details** 面板下的 **Render Settings**。可以使用任何可用纹理或实时渲染目标。

![Input Texture under Render settings](../../../../../assets/images/4b/4b3a6c8904bb3d6b82ec60b7fe9f81b0ad9f1da7bc993ecca8a30d144fca3bfa.png)

还可以调整以下设置：

- Pixel Format

  ：设置 Pixel Mapper 的内部精度：

  - Auto

    ：自动调整 Pixel Mapper 内部缓冲区精度，使其匹配输入纹理精度。
  - Low

    ：强制低精度（8-bit RGBA8 整数格式）。
  - High

    ：强制高精度（16-bit RGBA16F 浮点格式）。
- Exposure

  ：调整输入纹理值范围，以适配更宽的动态范围数据。例如，曝光值 0.25f 可将 0-4 范围重新映射到 0-1。由于 DMX 会以高精度整数格式将值转换回 0-1 范围，因此这样可以增加可用值范围。

### 过滤 Input Source

Pixel Mapper 可对其 Input Source 应用降采样 pass，并添加 2D 过滤器。

![The Filtering section](../../../../../assets/images/f8/f86431811e21cfe6b702195beaf9086f58906237a3598d5de0045f4bb34128ea.jpg)

要对输入源应用降采样 pass 和过滤器，请使用以下设置：

- Num Down Sample Passes

  ：在宽度和高度方向上将输入纹理尺寸减半的次数。该数值越大，所应用模糊过滤材质的效果越强。
- Output Size Mode

  ：是否对最终渲染目标应用自定义分辨率。
- Filter Material

  ：在每次降采样 pass 中应用的材质。
- Apply Material each pass

  ：是在每次降采样 pass 中应用材质，还是仅在最后一个 pass 中应用。
- Blur Distance

  ：设置材质上的 BlurDistance 参数。

### 引用 DMX Library

要添加 Fixture Group 并引用 DMX Library，请执行以下步骤：

1. 在 DMXLibrary 部分，点击

   + Add Fixture Group

   .
2. 从

   DMXLibrary

   下拉菜单中选择一个 DMX Library。

![Select a DMX Library](../../../../../assets/images/17/178e71b8d955a23abf929bd0984ea9f38bf775778da59d30dd088ea44f52eedb.png)

DMX Library 中的 Patch 现在会列在 DMXLibrary 部分。

![The list of Patches in the DMXLibrary section](../../../../../assets/images/1d/1dfa85168d862fedce64aaf6127a86bc5f7ac77bdeb877ae9082eb74e6a81c98.jpg)

### 将 Patch 添加到网格

要将 Fixture Patch 添加到 Grid，可以点击 Add Selected Patches 或 Add All Patches。Patch 添加到 Grid 后，也会添加到 Hierarchy 面板列表中。

![Add patches to the grid](../../../../../assets/images/19/19105b1f2b0b9ab171b7181b0be50bcea2170511dec9c27229d55933f3c088b8.png)

一个 Patch 只能添加到一个像素映射中一次。这可防止像素映射创建冲突的 DMX 数据。

在 **Details** 面板中，可以启用 **Children Follow Size** 复选框，使现有 Patch 在纹理大小改变时跟随纹理尺寸。

### 更改 Patch 布局

将 Patch 添加到 Grid 后，可以自动或手动更改 Patch 布局。

#### 自动更改布局

要按网格布局自动排列 Patch，请执行以下步骤：

1. 选择

   Fixture Group

   中设置

   Hierarchy

   面板。
2. 在

   Layout

   面板中，将

   Layout Script Class

   设置为

   Grid Layout

   .
3. 使用

   Layout Settings

   更改列数、行数、填充，以及单元格的对齐和分布方式。

![Set auto layout](../../../../../assets/images/f4/f439bcda8dd3102d6968b41ff1622a5c175e2d3e52a7f2e61931ad49f945056c.jpg)

![Auto layout result](../../../../../assets/images/71/710fc0b6860032d28d60f250c16ff4ddde49c7a891a219c764a0681ee5b9c4df.png)

#### 手动更改布局

可以在 **Designer**中手动移动和调整 Fixture Patch 大小。点击 Fixture Patch 选中它，点击并拖拽 Fixture Patch 可移动它，点击并拖拽 Fixture Patch 边缘上的点可调整大小。

要旋转 Patch，请在 **Designer** 中右键点击 Patch 并选择 **Rotate Mode**。点击并拖拽 Fixture Patch 角上的点即可旋转它。

可以在 **Designer** 或 **Hierarchy** 面板中选择多个 Fixture Patch，并将它们作为组移动或调整大小。

### 播放 Pixel Mapping 资产

#### 在编辑器中播放 Pixel Mapping 资产

![Playing a Pixel Mapping Asset in the Editor](../../../../../assets/images/89/89dcb6888b94f713d51516241e9ecbcac9f16078aa4c0e9f5e9d5ffbd890e1be.png)

Pixel Mapping 资产可以在编辑器中播放。点击 **Play** 按钮可在每个 tick 发送 DMX 数据。 **Stop** 按钮可根据以下设置执行不同操作：

- Stop sends Default Values

  ：按下 Stop 时，Pixel Mapping 会为所有 Patch 发送一次默认值。缓冲区会记住这些值，直到另一个对象向相同 DMX 地址发送数据。
- Pause

  ：按下 Stop 时，Pixel Mapping 会为所有 Patch 发送一次零值。缓冲区会记住这些值，直到另一个对象向相同 DMX 地址发送数据。
- Stop keeps last Values

  ：按下 Stop 时，Pixel Mapping 不发送特殊值。

#### 在游戏中播放 Pixel Mapping 资产

1. 创建一个 Actor 类型的新 Blueprint。
2. 添加新的

   Get DMX Pixel Mapping Renderer Component

   节点。
3. 从该节点的 Out Component 引脚拖出，并输入“Render and Send DMX”。
4. 添加 **Render and Send DMX** 节点，并将其执行引脚连接到 Actor Blueprint 的 Tick 节点。

   > 图片已省略：The Actor Blueprint
5. 将 Actor 放入关卡并启动游戏。

   > 图片已省略：The pixel mapping playing in the game

## 设置

### Designer 设置

Designer 视口工具栏中的 Settings 菜单包含以下选项：

- Always select Group

  ：启用后，选择子组件时也会同时选择父组件。
- Scale Children with Parent

  ：启用后，调整父组件大小时其子组件也会同时调整大小。
- Show Component Names

  ：是否显示 Fixture Patch 和 Group 组件名称。
- Show Patch Info

  ：是否显示 Patch ID 和编号。
- Show Matrix Cells

  ：是否显示 Matrix 单元格。
- Show Cell IDs

  ：是否显示 Matrix 单元格 ID。
- Show Pivot

  ：显示所选组件的轴心。
- Font Size

  ：设置 Designer 中的字体大小。
- Display Exposure

  ：设置 Input Source 纹理的显示方式。不影响计算数据。

### Grid 设置

Grid 设置允许 Patch 在 **Designer**.

> 图片已省略：The grid settings button

- Enable Grid Snapping

  ：切换网格吸附功能。
- Num Columns (X)

  ：设置水平网格单元数。
- Num Columns (Y)

  ：设置垂直网格单元数。
- Color

  ：设置网格显示颜色。

### Editor 设置

使用 **Editor 设置** 部分，可在 **Details** 面板中设置 **Editor Color**，它会自动应用到 **Designer**.

如果在 Designer 中选择一个或多个 Patch，可以取消选择 **Use Patch Color** 并为所选 Patch 提供独特轮廓颜色。

> 图片已省略：The editor settings

### Matrix 设置

使用 **Matrix** 部分，可在 **Details** 面板中反转矩阵的单元格顺序。当硬件灯具背向屏幕时，这很有用。

- Invert Cells X

  ：沿 X 轴反转单元格顺序。当硬件灯具背向屏幕时很有用。
- Invert Cells Y

  ：沿 Y 轴反转单元格顺序。

### Color Space

使用 **Color Space** 部分，可在 **Details** 面板中定义 Pixel Mapping 发送输出时使用的色彩空间。Unreal Engine 内部使用 RGB 值以及工作色彩空间来定义颜色。某些物理 DMX 灯具会使用或允许其他格式。

#### 输出模式

可用 Output Mode 如下：

- RGB/CMY

  ：默认模式，根据所提供渲染目标中的 RGB 值生成 RGB DMX 值。可以设置 Destination Color Space；随后引擎 Working Color Space 会转换为所提供的 Destination Color Space。
- CIE 1931 xyY

  ：引擎 Working Color Space 会自动转换为 xyY 色彩空间。如果取消勾选 Use Working Color Space for Input，则引擎 Working Color Space 会被解释为 RGB 色彩空间。
- CIE 1931 XYZ

  ：引擎 Working Color Space 会自动转换为 XYZ 色彩空间。如果取消勾选 Use Working Color Space for Input，则引擎 Working Color Space 会被解释为 RGB 色彩空间。

#### Output Gamma

使用此设置为将作为 DMX 发送的采样颜色值应用 gamma 曲线。该设置包含以下选项：

- Linear

  ：不应用传递函数。
- As Output Color Space

  ：使用 Output Color Space 的传递函数。例如，当

  Output Color Space

  设为

  sRGB

  时，会应用 sRGB 的传递函数。
- Custom

  ：可指定自定义传递函数。

### RGB Mode

这里定义读取的 RGB 值如何实际映射到当前 Patch 的 DMX 通道。通常会将红色纹理值映射到 Red DMX 通道，绿色和蓝色同理。不过，也可以将 alpha 值映射到 Pan/Tilt 或其他可用通道以实现其他用途。

### Luminance

可以查询读取像素计算出的亮度值，并用它驱动 Dimmer 通道或任何其他可用通道。或者，也可以强制将 Dimmer 通道设为常量值，只驱动上方 RGB 值。

### Quality

这是输入纹理计算平均值的质量控制。可用质量值如下：

- High

  ：每个 Patch 9 个样本
- Medium

  ：每个 Patch 5 个样本
- Low

  ：每个 Patch 1 个样本

样本数量越高，结果值越平滑，因为它们会在形成最终使用值前进行平均。

