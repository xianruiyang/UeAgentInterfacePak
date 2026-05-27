---
title: "移动设备性能指南"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/performance-guidelines-for-mobile-devices-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "移动端开发工具", "移动设备性能指南"]
---

# 移动设备性能指南

> 路径：虚幻引擎5.7文档 / 移动端开发 / 移动端开发工具 / 移动设备性能指南

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/performance-guidelines-for-mobile-devices-in-unreal-engine

在为移动平台进行开发的过程中，当针对特定设备时您应该牢记一些事项，或者根据您想要发布标题的设备列表， 应该牢记一些通用的良好做法。这包括使用特定照明层进行开发以最大限度地利用设备上的性能， 以及特定照明层可能最适合您的目标受众的原因。您还会找到一些建议来记住您所从事的任何 会使用移动平台进行开发的项目。

## 性能层

虚幻引擎4(UE4)支持移动设备上的各种照明功能。使用这些功能会降低性能，并且可能导致您的游戏在较慢的移动设备上表现不佳。虽然 可以混合和匹配UE4的大多数移动照明功能，但是将这些功能划分为以下几层是很有用的。在构建移动游戏时，您应该基于游戏所需要的 图像质量以及您需要支持的设备类型来决定使用哪些功能。请查看[iOS开发](https://dev.epicgames.com/documentation/404)和[Android 开发](https://dev.epicgames.com/documentation/404)相关开发要求， 以了解更多关于在Epic测试过的设备以及我们认为最适合该设备的层。

### LDR（低动态范围）

**低动态范围（Low Dynamic Range）** (LDR)模式是UE4中支持的最低性能层，推荐用于不需要照明或后期处理功能的游戏。

要使用此模式，您必须在[项目设置（Project Settings）](../../../understanding-the-basics/project-settings/index.md)中的渲染（Rendering）部分下禁用 **移动HDR（Mobile HDR）**。

| 优点 | 缺点 | 建议 |
| --- | --- | --- |
| 为移动设备提供最快和最低的可用系统占用模式，使您的游戏能够在较慢的移动设备上运行良好。 仍提供对材质编辑器的完全访问，用于定义自定义着色器甚至执行可用于假照明的简单着色。 | 场景的颜色在伽玛空间中写出，且每个种颜色通道固定[0,1]的范围内。 半透明原语混合在伽马空间中。在大多数情况下，这需要您制作的半透明纹理和材质不同于您在HDR中的或适用于普通的PC标题。 在此模式下，后期处理（Post Processing）功能不可用。 | 确保您所有材质的着色模型都设置为 **无光照（Unlit）**，以获得最大性能。 当依靠最大性能时，不应在场景中使用设置的照明。 考虑在材质 **顶点着色器（Vertex Shader）** 中执行尽可能多的操作。您可以通过启用 **自定义UV（Customized UV）**，将节点连接到它们，然后在像素着色器中使用 **纹理坐标（Texture Coordinate）** 节点锁定自定义UV，来做到这一点。 |

### 基本照明

在这一层，您将利用静态照明和完全粗糙的材质创建包含有趣照明的场景，同时将性能最大化，以覆盖更广泛的移动设备。

要使用此模式，您必须在[项目设置（Project Settings）](../../../understanding-the-basics/project-settings/index.md)中的渲染（Rendering）部分下启用 **移动HDR（Mobile HDR）**。

| 优点 | 缺点 | 建议 |
| --- | --- | --- |
| 访问静态照明（Static Lighting）和全局照明（Global Illumination）功能。 全HDR管道，包含对色调映射（Tone Mapping）等一些后期处理（Post Processing）功能的访问。 半透明混合在线性空间中，使您可以像平常为桌面创作一样创作内容。 | 因为所有材质都需要标注为 **完全粗糙（Fully Rough）**，所以您的材质不会有有趣的镜面反射。 如果您选择禁用 **光照图方向性（Lightmap Directionality）**，法线贴图将没有效果。 | 创作所有材质时设置 **完全粗糙（Fully Rough）** 标记。 考虑禁用材质中 **光照图方向性（Lightmap Directionality）** 的标记，以获得更高的性能。 在图上只使用静态照明。 禁用 **泛光（Bloom）** 等一些后期处理（Post Processing）功能。另外，应仅使用薄膜和颜色控制的基本集。 |

### 全HDR（高动态范围）照明

在这一层中，您可以利用UE4中适合移动的大多数HDR照明功能，以及一些后期处理（Post Processing）功能。使用这些功能需要相当大的性能， 以换取高质量的照明功能。

要使用此模式，您必须在[项目设置（Project Settings）](../../../understanding-the-basics/project-settings/index.md)中的渲染（Rendering）部分下启用 **移动HDR（Mobile HDR）**。

| 优点 | 建议 |
| --- | --- |
| 访问静态照明（Static Lighting）和全局照明（Global Illumination）功能。 全HDR管道，包含对一些后期处理（Post Processing）功能的访问。 半透明混合在线性空间中，使您可以像平常为桌面创作一样创作内容。 表面逼真的镜面反射，支持各种粗糙度。 | 考虑启用 **泛光（Bloom）** 以充分利用HDR照明管道。 逼真的镜面反射结合HDR照明可能会导致镜面失真。为了减少这种影响，为 **Normal Curvature to Roughness** 启用此材质属性，以减少由于法线贴图中的高频信息而造成的镜面失真。您还可以考虑通过 **项目设置（Project Settings）> 渲染（Rendering）** 启用抗锯齿，以帮助减少穿帮。 花些时间考虑反射采集Actor的位置，以获得最佳结果。请参阅[反射：放置反射采集](../../../samples-and-tutorials/index.md#placingreflectioncaptures)了解更多信息。 在场景中仅使用静态照明（Static Light）和光照图（Lightmap）以获得最好的效果。 |

### 包含来自太阳的逐像素照明的全HDR照明

在这一层中，您可以利用UE4中适合移动的所有HDR照明功能。这一层与[全HDR照明](#%E5%85%A8hdr%EF%BC%88%E9%AB%98%E5%8A%A8%E6%80%81%E8%8C%83%E5%9B%B4%EF%BC%89%E7%85%A7%E6%98%8E)相同，具有相同的优点 和建议，不同的是在此处您可以在场景中添加一个定向光源，定向光源会自动使用逐像素光源从而提高质量。

要使用此模式，您必须在[项目设置（Project Settings）](../../../understanding-the-basics/project-settings/index.md)中的渲染（Rendering）部分下启用 **移动HDR（Mobile HDR）**。

| 优点 | 建议 |
| --- | --- |
| 为[全HDR](#%E5%85%A8hdr%EF%BC%88%E9%AB%98%E5%8A%A8%E6%80%81%E8%8C%83%E5%9B%B4%EF%BC%89%E7%85%A7%E6%98%8E)层列示的所有功能和优点。 单个定向光源的逐像素漫反射和镜面照明。 单个定向光源的高质量预计算距离场阴影。 | [全HDR](#%E5%85%A8hdr%EF%BC%88%E9%AB%98%E5%8A%A8%E6%80%81%E8%8C%83%E5%9B%B4%EF%BC%89%E7%85%A7%E6%98%8E)层的所有建议和优点。 除单个定向光源（应设置为固定）之外，仅使用静态光源。 |

## 着色器复杂性视图模式

[移动预览器](../using-the-mobile-previewer/index.md)中的[着色器复杂性](../../../building-virtual-worlds/level-editor/editor-viewports/viewport-modes/index.md#shadercomplexity)视图模式， 用于了解您所针对的特定设备的材质成本是多少。屏幕上显示的颜色会告诉您这种材质对于您的目标设备有多贵； 绿色表示性能好，鲜红色表示非常贵，白色或粉色表示材质非常贵。

要使用它，在主视口中单击 **视图模式（View Modes）** 列表，选择 **优化视图模式（Optimization Viewmodes）**，选择 **着色器复杂性（Shader Complexity）**，或者使用键盘快捷键 **Alt + 8**。

下面是一些来自移动太阳神庙（Mobile Sun Temple）的例子，当您使用着色器复杂性查看时，这些例子可以让您对材质成本有一个概念：

|  |  |  |
| --- | --- | --- |
|  |  |  |
| 支柱材质在这里相当昂贵，半透明的体积片 **极为** 昂贵。在这个场景中，我要求去掉半透明片，因为它们太贵了。 | 这里的柱子是相当昂贵的，因为它们使用所有五个纹理查找并且做相当多的分层。否则，这对于30fps来说已经足够有效了。 | 这里，树导致像素 **极其** 昂贵。如果玩家能够近距离接触或用这种材质覆盖屏幕，成本将是巨大的。 |

## 移动内容缩放系数

**移动内容缩放系数（Mobile Content Scale Factor）** 是一种缩放项目分辨率的方法，以最佳地契合用于查看项目的移动设备屏幕分辨率。 您可以通过在您的项目配置文件夹中创建一个名为 **DefaultDeviceProfiles.ini** 的新配置(.ini)文件来[创建和存储多个设备配置文件](../../../sharing-and-releasing-projects/tools-for-general-platform-support/setting-up-device-profiles/index.md) 。

在这个文件中，您可以通过输入以下命令，后跟以下iOS和Android部分中的一个值，以指定特定设备的项目分辨率将发生什么情况：

```
	r.MobileContentScaleFactor 
```

在下图中，您可以看到在配置文件中设置移动内容缩放系数的示例：

![undefined](../../../../assets/images/37/377c13b0f7d446c8ae742ca985cce0116221d4e18a4ad5b5cadf517c5c6ffdbc.png)

单击显示全图。

这个特定配置文件来自Tappy Chicken项目，它显示了在各种移动设备上游玩Tappy Chicken时会对分辨率产生什么影响。该文件的顶部部分 处理iOS设备的分辨率缩放，底部部分处理Android设备的分辨率缩放。注意每个 **r.MobileContentScaleFactor** 后面有一个数字。该数字 用于命令之后，以确定项目的分辨率应该放大还是缩小。

### iOS的移动内容缩放系数

对于iOS设备，输入以下数字将产生以下结果：

> [!NOTE]
> iOS的缩放系数与Apple的缩放系数系统直接相关，除0.0外的任何缩放系数的实际分辨率都将被校正，以匹配屏幕的纵横比并限制到 设备的本机分辨率。

| 值 | 结果 |
| --- | --- |
| **0.0** | 这将使用设备的本机分辨率。 |
| **1.0** | 视网膜设备上的是非视网膜分辨率。 |
| **2.0** | iPhone 5S、iPad Air等的全本机分辨率。 |
| **3.0** | iPhone 6+的全本机分辨率。 |

### Android的移送内容缩放系数

对于Android设备，输入以下数字将产生以下结果：

> [!NOTE]
> 请注意，如果输入的值不是0.0，则将根据设备的方向使用该值作为标准1280x720或720x1280分辨率的缩放系数。

| 值 | 结果 |
| --- | --- |
| **0.0** | 这将使用设备的本机分辨率。 |
| **1.0** | 这将尝试给您一个横向1280 x 720和纵向720 x 1280的分辨率。 |
| **2.0** | 这将尝试给您一个横向2560 x 1440和纵向1440 x 2560的分辨率。 |

## 移动材质质量设置

当为一个将在低端和高端移动设备上运行的UE4项目构建内容时，您经常会遇到这样的问题：某个功能或您的作品只在一组设备上工作， 而无法在另一组设备上工作。虽然有很多方法可以解决这类问题，但其中许多方法都是时间和资源密集型的，有时容易出错。要解决这些类型的问题 UE4拥有 **材质质量水平（Material Quality Level）** 系统。该系统使您能够构建一个单一材质，然后可以在广泛的设备上使用， 使您能够完全控制哪些设备使用哪些功能。

在下面的部分中，我们将介绍这些系统以及如何在您自己的UE4项目中使用它们：

### 预览材质质量水平

您可以在编辑器中查看不同的材质质量水平（Material Quality Level）设置，方法是打开 **主工具栏（Main Toolbar）**，然后 选择 **设置（Settings）** > **材质质量水平（Material Quality Level）**， 选择要预览的水平。

下面的图片显示了当材质质量水平（Material Quality Level）设置为低（Low）、中（Medium）、高（High）时材质的外观。

![拖动滑块将显示当材质质量水平从低（Low）到中（Medium）到高（High）时发生了什么变化](../../../../assets/images/5f/5f34d0a3c268fed05f2bab2f0cc1024e261be6a927f8d6285715d87144539ae9.png)

拖动滑块将显示当材质质量水平从低（Low）到中（Medium）到高（High）时发生了什么变化

### 设置材质质量水平

要为您的设备设置材质质量水平（Material Quality Level），您可以采用以下方法：

##### 从控制台

按 **`**（反引号）键并输入 **r.MaterialQualityLevel**，后跟以下值，以调出控制台：

| 材质质量水平编号 | 设置 |
| --- | --- |
| **0** | 低 |
| **1** | 高 |
| **2** | 中 |
| **3** | 超高 |

> [!NOTE]
> 请注意，1代表高，2代表中，这是正确的，不是打印错误。

##### 从设备配置文件

通过使用配置(.ini)文件，您可以在编辑器中使用以下方法为计划目标设备设置材质质量：

1. 从主工具栏（Main Toolbar）转到 **Windows** > **开发人员工具（Developer Tool）**，然后单击 **设备配置文件（Device Profiles）**。
2. 在设备配置文件中找到 **Android_Low** 配置文件，单击第一个 **扳手** 图标打开配置文件选项。
3. 在 **渲染（Rendering）** 选项下的 **控制台变量（Console Variables）** 部分中，单击 **加号** 图标，在弹出的输入窗口中输入 **R.MaterialQualityLevel**，然后按回车（Enter）键将该命令添加到列表中。
4. 添加新条目后，将默认值从 **1** 更改为 **0**，以便在低端Android设备上查看此项目时使用尽可能快的材质（Material）设置。

### 预览不同质量关卡

通过调整 **预览渲染关卡**，您可以使用虚幻引擎4编辑器查看项目在不同硬件上运行时的外观。您可以通过切换到 **主工具栏（Main Toolbar）**，然后选择 **设置（Settings）** > **预览渲染关卡（Preview Rendering Level）**，并选择您想要使用的预览关卡来进行调整。

### 材质质量水平开关

**质量开关（Quality Switch）** 材质表达式允许您在单个材质中定义不同的复杂性水平。例如，如果您有一个要在高端而非低端移动设备上运行的复杂数学运算， 或者大量的纹理读取作业。您可以使用此节点指定要在低端移动设备上显示的简化版本，这些设备没有能力显示高端图形。

要在材质中使用质量开关，首先需要将 **质量开关材质表达式（Quality Switch Material Expression）** 节点添加到材质图表中，然后将其输出插入到主材质（Main Material）节点上的任何输入中。在下图中，设置M_Brick_Clay_Old材质（可以在初学者内容包中找到），这样在切换质量水平时，材质的复杂性就会降低。

![undefined](../../../../assets/images/03/03203f026330e6442949762d87c03d6c91e2a07bdd57d186747c8f5635f9ba02.jpg)

单击显示全图。

### 移动材质选项

如果您打开任何 **材质（Material）** 并单击主材质（Main Material）节点，然后查看 **移动（Mobile）** 部分下的细节（Details）面板，您将发现以下两个属性：

| 属性 | 设置 |
| --- | --- |
| **浮点精度模式（Float Precision Mode）** | 如何在像素着色器中使用全 **（highp）** 精度。**Highp** 的速度比默认的 **(mediump)** 要慢，但可以绕过精度相关的渲染错误。如果你还想以.ush/.usf为单位保持一半的精度，请使用 **仅为材质表达式使用全精度（Full-Precision for MaterialExpressions Only）**。此设置对不支持高精度的旧移动设备没有影响。 |
| **使用光照贴图方向性（Use Lightmap Directionality）** | 使用光照贴图方向性和逐像素法线。如果禁用，光照贴图看起来会更平坦，而使用开销更低。 |
| **移动端高质量BRDF（Mobile High Quality BRDF）** | 在移动设备上使用高质量BRDF功能，以获得更好的视觉效果，但会增加GPU开销。 |
| **使用Alpha覆盖（Use Alpha to Coverage）** | 对移动端上的被遮罩材质使用Alpha覆盖，需要同时启用MSAA。 |

使用这些属性可以彻底消除这些功能的渲染路径，这有助于降低在低端移动设备上查看材质时的渲染开销。

### 移动材质渲染重载

通过调整位于 **项目设置（Project Settings）**>**平台（Platforms）** 下的不同目标设备的材质质量（Material Quality）设置，您可以重载平台将使用的可用渲染选项。

您可以通过调整列出的 **质量选项（Quality Options）** 来覆盖平台将使用的可用渲染选项。为了使用覆盖，您必须首先单击 **启用质量覆盖（Enable Quality Overrides）** 选项， 然后为给定的质量水平选择要覆盖的选项。

一旦您想要的所有选项都被选中，按 **更新预览着色器（Update Preview Shaders）** 按钮来重新编译所有的材质以使用指定的选项。

## 移动渲染选项

在 **渲染（Rendering）** 部分下的 **项目设置（Project's Settings）** 菜单中，您会发现许多属性， 用于控制如何在您的移动项目中处理照明和优化。在下面的部分中，我们将了解这些设置以及它们对项目的影响。

### 访问您的项目设置

打开项目设置（Project Settings）菜单后，找到 **引擎（Engine）** 分段，然后单击 **渲染（Rendering）** 类别。使用以下分段调整下面的设置：

- 移动（Mobile）
- 杂项光照（Misc Lightning）
- VR
- 移动着色器置换减少（Mobile Shader Permutation Reduction）

### 移动渲染选项

在 **移动（Mobile）** 类别下，您可以设置直接影响您的移动项目的照明和外观的属性。请阅读下面的文章，为您自己的项目探索这些设置。

| 属性名称 | 说明 |
| --- | --- |
| **移动（Mobile）** | 项目设置（Project Settings）中 **移动（Mobile）** 分段下列出的选项应该根据移动性能进行调整。 **在移动着色器上禁用顶点成雾（Disable Vertex Fogging in mobile shaders）**：如果为True，所有移动着色器都将忽略顶点武器。如果你的游戏未使用雾气，应该选择此设置以提升着色性能。 **渲染的最大CSM级联数量（Maximum number of CSM cascades to render）**：在使用移动渲染器时，用于渲染动态定向光源阴影的最大级联数量。 **移动抗锯齿方法（Mobile Anti-Aliasing Method）**：此为移动端上使用的多采样抗锯齿（MSAA）设置。如果MSAA不可用，将使用当前默认的AA方法。 |
| **VR** | 项目设置（Project Settings）中 **VR（VR）** 分段下列出的选项应该根据移动性能进行调整。 **移动HDR(Mobile HDR)**：如果为True，移动渲染器将使用权HDR。为不需要光照功能的游戏禁用此项可以在低端设备上获得更好的性能。 |

## 移动着色器减少设置

在 **照明（Lighting）** 和 **移动着色器置换减少（Mobile Shader Permutation Reduction）** 部分下，您会发现有很多不同的选项可以被启用或禁用来影响为材质生成的着色器， 这反过来会减少应用程序的大小，节省内存并加快加载速度。

| 属性名称 | 说明 |
| --- | --- |
| **杂项光照（Misc Lightning）** | 项目设置（Project Settings）中 **杂项光照（Misc Lightning）** 部分下列出的选项应该根据移动性能进行调整。 **允许静态光照（Allow Static Lighting）**：是否允许生成和使用任何静态光照，如光照贴图和阴影贴图。只使用动态光照或无光照的游戏应设置为0，以节省一些静态光照系统占用。 |
| **移动着色器置换减少（Mobile Shader Permutation Reduction）** | 在 **移动着色器置换减少（Mobile Shader Permutation Reduction）** 下找到的列示选项应该根据移动性能进行调整。 **支持静态和CSM组合阴影（Support Combined Static and CSM Shadowing）**：允许原语从固定光源接收静态和CSM阴影。禁用将释放一个移动纹理采样器。 **不启用"强制无预计算光照"的情况下支持关卡中CSM（Support CSM on levels with Force No Precomputed Lighting enabled）**：在启用允许静态光照（Allow Static Lighting）时，通常不会在没有任何预计算光照的情况下生成支持CSM的着色器。此设置允许在此情况下支持CSM ，代价是产生额外的着色器置换开销。 **支持预烘焙距离场阴影贴图（Support Pre-baked Distance Field Shadow Maps）**：为静态图元生成着色器，通过固定定向光源渲染烘焙了Lightmass的距离场阴影贴图。 **支持可移动定向光源（Support Movable Directional Light）**：为图元生成着色器以接收可移动定向光源。 **最大可移动点光源数（Max Movable Point Lights）**：移动设备上支持的动态点光源数量。对于不需要动态点光源的游戏，将其设置为0将减少生成着色器的数量。 **支持可移动聚光源（Support Movable Spotlights）**：为图元生成着色器以接收来自可移动聚光源的光线。在处理可移动光源时，这会产生额外的开销。 |

> [!NOTE]
> 更改这些设置中的任何一个都需要重新启动编辑器才能生效。

> [!WARNING]
> 如果您禁用了照明设置需要的某个着色器置换，您的照明或阴影将不会正确渲染，并且屏幕上将显示消息， 表明该设置需要重新启用，使其正常工作。

## 其他建议

以下建议将帮助您在移动平台上设置内容以获得最佳性能。排列顺序为从影响最大到影响最小。

- 在设备上运行之前，请确保已经构建了照明。
- 大多数后期处理功能在移动平台上是禁用的，因为它们太昂贵了，比如晕映或屏幕空间反射。一些GPU密集型功能，如泛光（Bloom）和景深（Depth of Field），在默认情况下是启用的，这样PC和移动设备看起来是一样的，但在某些设备上，许多功能的默认设置可能需要耗费60毫秒甚至更长时间。控制台命令

  showflag.PostProcessing 0

  可以用来关闭这些功能，从而大致了解它们的成本。
- 确保使用预计算可视性（Precomputed Visibility）并正确设置它。为此，将

  预计算可视性体积（Precomputed Visibility Volumes）

  放置在玩家可以行走或跳跃的区域周围，然后构建照明。您需要确保将它们放置在构建照明和运行游戏时使用的固定关卡中，因此不要自己构建子关卡。通过在设备上或关卡预览器中输入控制台命令

  Stat Initviews

  ，并确保

  静态遮挡的原语（Statically Occluded Primitives）

  大于0，可以验证预计算可视性（Precomputed Visibility）是否正常工作。使用控制台命令

  r.ShowPrecomputedVisibilityCells 1

  在编辑器中可视化单元格。
- 尽量少用遮罩和透明材质。只在覆盖屏幕一小部分的地方使用它们。iOS设备在对不透明表面进行遮光处理方面是非常理想的，因为它们只对每个像素进行一次遮光处理，但是对于遮罩和半透明，每一层都必须进行遮光处理。通过过度绘制，帧的总GPU时间可以增加一倍或更多。使用

  着色器复杂性（Shader Complexity）

  视图模式来调查任何热点。
- 对于任何单个视图，整个场景的绘制调用应该为<=700。遮挡程度较差的地区，比如俯瞰大片地形，将是最大的挑战。这可以在设备上的

  Stat OpenGLRHI

  或PC上的预览器中的

  Stat D3D11RHI

  中看到。
- 对于任何视图，整个场景的三角形计数应为<=500k。这已经被确定为在iPad4和iPad Air上都可达到30fps的最大多边形计数。这可以在设备上的

  Stat OpenGLRHI

  或PC上的预览器中的

  Stat D3D11RHI

  中看到。
- 材质应该使用尽可能少的纹理查找和指令。您有五个纹理采样器可用，但使用所有这些采样器相当于使用相当昂贵的材质。现在，使用PC指令计数来优化， 使用预览器着色器复杂性来可视化总成本。
- 仅在材质中使用独立纹理获取。这意味着像素着色器中的UV（基本颜色（BaseColor）、粗糙度（Roughness）等）不能以任何方式操纵，比如缩放。使用

  自定义UV（CustomizedUV）

  功能在顶点着色器中进行缩放。一些特殊的功能，比如环境映射，需要在UV上进行数学运算，这对于特殊情况来说是可行的。
- 建议使用正方形纹理，因为它们浪费的内存更少。始终对其使用二维的幂（256x256、512x512、1024x1024）。在预览器中使用控制台命令

  列出纹理（ListTextures）

  查看所有纹理内存的去向。
