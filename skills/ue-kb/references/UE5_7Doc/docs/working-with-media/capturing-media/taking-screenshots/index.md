---
title: "获取截图"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/taking-screenshots-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体捕获", "获取截图"]
---

# 获取截图

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体捕获 / 获取截图

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/taking-screenshots-in-unreal-engine

在虚幻引擎 4（UE4）中，可以多种不同方式获取项目的游戏截图。 本文档将说明用于 UE4 截图的工具及其使用方法。

## 默认保存路径

截图画面会被默认保存到项目文件夹的以下路径中。

**Saved\Screenshots\Windows**

捕获截图画面时，屏幕的右下角将显示以下消息。

![Showing the save location of your high resolution screenshot](../../../../assets/images/50/50b407f206266f0c199c5d69c22cd2fcf0b61dfe8ea51b5337a39b5c92daf57a.png)

点击该消息可直接打开截图所在的目录。

## 标准截图

标准截图功能通过控制台命令 **Shot**（默认按键绑定为 **F9**）来执行。 将根据屏幕分辨率大小（如游戏在窗口模式下运行则根据窗口分辨率）生成屏幕截图。

## 高分辨率截图

高分辨率截图是一个强大的跨平台功能，可获取分辨率极高的截图。 它可基于屏幕分辨率（如游戏在窗口模式下运行则根据窗口分辨率）生成任意尺寸的截图。 高分辨率截图控制台命令对游戏单帧画面进行多次渲染，每次渲染完整分辨率的一部分，在所有部分完成后将它们拼接为一个单独的图像文件。

默认将获得当前游戏分辨率四倍的截图，并在 Screenshot 目录中创建截图文件。

在编辑器窗口内（PIE）或以 standalone 模式运行游戏时，点击 **~** 按键打开命令控制台并输入：

```
     HighResShot    
```

### 参数

HighResShot 控制台命令接受一系列可选参数，以控制截图的方式：

```
     HighResShot filename=PATH (XxY OR Multiplier) CaptureX CaptureY CaptureW CaptureH bMaskUsingCustomDepth bDumpBufferVisualizationTargets bCaptureHDR bDateTimeAsFilename 
```

| 参数 | 描述 |
| --- | --- |
| XxY | 指定截图的尺寸（宽度x高度）。 |
| 乘数（Multiplier） | 根据指定的值放大截图尺寸。 |
| CaptureX CaptureY CaptureW CaptureH | 用整数定义视口中要用于截图的区域。 |
| bMaskUsingCustomDepth | 用一个布尔值（0或1）来控制是否要用自定义深度（Custom Depth）缓冲作为捕获的遮罩。详情请参见[自定义深度遮罩](https://docs.unrealengine.com/zh-CN/WorkingWithMedia/CapturingMedia/TakingScreenshots#%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B7%B1%E5%BA%A6%E9%81%AE%E7%BD%A9)。 |
| bDumpBufferVisualizationTargets | 用一个布尔值（0或1）来控制是否要将GBuffer中的每一个通道都捕获为一张图片并将其导出。 |
| bCaptureHDR | 用一个布尔值（0或1）来控制是否要使用.EXR文件格式来捕获HDR图片。 |
| bDateTimeAsFilename | 用一个布尔值（0或1）来控制是否要在生成的文件名中加入时间戳。 |

输入以下命令获得的截图大小为屏幕分辨率的 2 倍。

```
  HighResShot 2 
```

同理，以下命令获得的截图分辨率为宽 3840，高 2160：

```
 HighResShot 3840x2160 
```

## 高分辨率截图工具

![The High Resolution Screenshot Tool](../../../../assets/images/12/12243ca8aa0ddbfbb68798d0ae272f4b630df2a8bb8b154ca35750ccb7512eb1.png)

通过高分辨率截图工具（HRSST）可指定视口中要截图的区域。还可通过它调整所获取截图的尺寸，并输出 GBuffer 的结果。

### 访问高分辨率截图工具

先点击 **视口选项（Viewport Options）**，然后选择 **高分辨率截图（High Resolution Screenshot）** 选项即可访问 HRSST。

![Opening the High Resolution Screenshot Tool](../../../../assets/images/48/48e0da23b5e5c647194d4ddec2663774a1eaa006926f5d288fb884dc8585296e.jpg)

选择 **High Resolution Screenshot** 后，HRSST 便会显示在屏幕上。

![numbered explanation of the HRSST window](../../../../assets/images/06/06c0028e4b05f59fd841240969fb9697e264293a28cc7dcb344fd116ce5d7836.png)

> [!NOTE]
> 可将 HRSST 移动至 UE4 中任意位置，但要注意它的位置，因为有时 HRSST 可能会隐藏在其他浮动窗口（如 **Content Browser**）背后。

| 数字 | 描述 |
| --- | --- |
| 1: | 用于设置截图尺寸的乘数。 |
| 2: | 在图片名称中加入日期和时间戳。 |
| 3: | 告诉工具将GBuffer中的每个通道作为导出图片。 |
| 4: | 把所有导出图片写为 .EXR 格式，并为所有可用中间渲染阶段启用全16位色彩深度（HDR）导出。 |
| 5: | 强制执行全128bpp渲染。 |
| 6: | 捕获场景中的特定对象。详情请参见[自定义深度遮罩](https://docs.unrealengine.com/zh-CN/WorkingWithMedia/CapturingMedia/TakingScreenshots#%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B7%B1%E5%BA%A6%E9%81%AE%E7%BD%A9)。 |
| 7: | 在视口中指定要捕获的区域。首先点击工具，然后按下 **鼠标左键** 在编辑器视口中拖动即可选择要捕获的区域。 |
| 8: | 清除之前创建的捕获区域。只有在已有选定区域时，该按钮才会出现。 |
| 9: | 将捕获区域扩大到整个编辑器窗口。只有在已有选定区域时，该按钮才会出现。 |
| 10: | 点击此项即可进行截图。 |

> [!WARNING]
> 由于高分辨率截图的系统要求较高，较大的乘数可能导致显卡驱动无响应或崩溃。如出现此类情况，请使用较低的分辨率。

### 使用高分辨率截图工具

要捕获高分辨率截图：

1. 启用HRSST工具。先点击

   视口选项（Viewport Options）

   ，然后选择

   高分辨率截图（High Resolution Screenshot）

   选项。
2. 工具启动后，按下

   指定区域（Specify Region）

   按钮在编辑器视口中选择需要捕获的区域。
3. 设置好捕获区域后，调整

   截图尺寸乘数（Screenshot Size Multiplier）

   设置图片文件的最终尺寸，然后按下照相机图标即可完成截图。截图将被保存到

   Saved\Screenshots\Windows

   文件夹。

### 缓冲可视

HRSST可渲染G-Buffer中的下列所有缓冲：

- BaseColor
- LightingModel
- Metallic
- Opacity
- PostTonerMapHDRColor
- PreTonerMapHDRColor
- Roughness
- SceneColor
- SceneDepth
- SceneDepthWorldUnits
- SeparateTranslucencyA
- SeparateTranslucencyRGB
- Specular
- SubsurfaceColor
- WorldNormal

如需启用 HRSST 将 G-Buffer 作为图片导出，首先启用 **包含缓冲可视化目标（Include Buffer Visualization Targets）**，然后按下捕获按钮。捕获文件夹将包含以上列出的每个 G-Buffer 截图。

### OpenEXR 图像支持

HRSST支持将图像以 OpenEXR 格式导出。 该项被启用后，将为所有可用的中间渲染阶段启用全16位色彩深度（HDR）导出。 点击捕获按钮后，HRSST 将以 OpenEXR 图像格式写出下列缓冲。

- BaseColor
- LightingModel
- Metallic
- Opacity
- PostTonerMapHDRColor
- PreTonerMapHDRColor
- Roughness
- SceneColor
- SceneDepth
- SceneDepthWorldUnits
- SeparateTranslucencyA
- SeparateTranslucencyRGB
- Specular
- SubsurfaceColor
- WorldNormal

启用 **Write HDR format visualization targets** 并按下捕获按钮即可使用OpenEXR 图像支持。此操作完成后，捕获文件夹将包含以上列出的每个G-Buffer截图。

### 自定义深度遮罩

在开发过程中，可能需要捕获游戏世界中的特定物体制作宣传材料。 但是，这需要手动从背景中剔除物体，耗时且伤神。 为加快此进程，HRSST 拥有一个名为 **使用自定义深度作为遮罩（Use custom depth as mask）** 的选项，可将世界场景中的物体分开。 工具这部分的设置和使用可通过以下步骤进行。

1. 选择需要捕获的对象，然后在

   细节（Details）

   中启用

   渲染自定义深度（Render Custom Depth）

   选项。
2. 打开 HRSST 并选择需要捕获的区域。 确保尝试捕获的区域已包含启用 **渲染自定义深度（Render Custom Depth）** 的网格体。
3. 启用 **使用自定义深度作为遮罩（Use custom depth as mask）** 选项。
4. 然后按下捕获按钮获得截图。
5. 点击屏幕右下角显示的信息查看截图。
