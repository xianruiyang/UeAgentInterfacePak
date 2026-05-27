# 将媒体转换为EXR格式

---
title: "将媒体转换为EXR格式"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/convert-media-into-the-exr-format-with-the-process-exr-tool-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "The Media Plate Actor", "将媒体转换为EXR格式"]
---

# 将媒体转换为EXR格式

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / The Media Plate Actor / 将媒体转换为EXR格式

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/convert-media-into-the-exr-format-with-the-process-exr-tool-in-unreal-engine

![处理EXR窗口](../../../../../assets/images/57/574b34078ac0a02bc4e14b43d8e016d429752720146ba503d253fe9f81ad7264.jpg)

对于EXR视频和序列，虚幻引擎支持EXR图块和mip。当你使用[媒体板Actor](https://dev.epicgames.com/documentation/404)来播放你的EXR序列时，Actor的球体和平面网格体会自动优化性能，在给定时间只流动对摄像机可见的图块，并为这些图块选择合适的mip级别。这项技术与群集渲染兼容，因此对于给定显示量，PC数量越多，每台PC的性能改善幅度就越大。

通过使用处理EXR（Process EXR）工具，你可以将现有经纬度360视频和2D板转换为EXR格式。该工具会将EXR图像划分成多个小块区域，这些区域由内含mip的图块组成。

要将媒体源转换为虚幻引擎EXR格式：

- 转到

  内容浏览器（Content Browser）

  >

  ImgMedia

  >

  处理EXR（Process EXR）

  。此操作会打开处理EXR（Process EXR）窗口，你可以在其中配置自己的

  .exr

  文件。

> [!NOTE]
> 如果你想在虚幻引擎之外转换自己的媒体，可以使用离线工具oiiotool。如果你想使用该工具，必须禁用压缩。以下命令行是转换媒体的示例： `oiiotool source.exr --ch R,G,B --compression none --tile 256 256 -otex result.exr`

## 处理EXR窗口

处理EXR（Process EXR）窗口包含以下可供你配置的选项：

### 序列

| 属性 | 说明 |
| --- | --- |
| 输入路径（Input Path） | 你想转换为EXR格式的文件的源文件夹。 |
| 输出路径（Output Path） | 你想用来存储转换后的 `.exr` 文件的目标文件夹。 |
| 启用mip映射（Enable Mip Mapping） | 启用EXR图块mipmap链的计算和处理。默认情况下启用。 |

### 图块

| 属性 | 说明 |
| --- | --- |
| 启用平铺（Enable Tiling） | 在可以确定网格细分处启用图块拆分。默认情况下启用。 当你设置图块和mip的数量时，有一个潜在的取舍：如果你的微小图块过多，你的计算成本会增加。如果你的图块过大，流送成本会增加。默认值为256。 |
| X轴图块大小（Tile Size X） | 沿X轴的每个图块的大小。 |
| Y轴图块大小（Tile Size Y） | 沿Y轴的每个图块的大小。 |
| X轴图块数量（Num Tiles X） | X轴上的图块数量。 |
| Y轴图块数量（Num Tiles Y） | Y轴上的图块数量。 |

### 处理

| 属性 | 说明 |
| --- | --- |
| 线程数量（Num Threads） | 指定你的系统中将使用的并发进程线程的数量。 |
| 使用播放器（Use Player） | 使用播放器进行解码。此属性上限为每帧1个图像。 |

> [!TIP]
> 对于大型图像，这是速度更快的选项。对于较小图像，上限会使它成为速度较慢的选项。

|

### 调试

| 属性 | 说明 |
| --- | --- |
| 启用mip级别色调（Enable Mip Level Tint） | 将mipmap着色烘焙到 `.exr` 文件中，以用于调试目的。 |
| Mip级别色调（Mip Level Tints） | 选择你想烘焙到mip中的色调。 |

