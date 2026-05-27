# IES光源描述文件

---
title: "IES光源描述文件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-ies-light-profiles-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "为场景设置光照", "直接光照", "IES光源描述文件"]
---

# IES光源描述文件

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 为场景设置光照 / 直接光照 / IES光源描述文件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-ies-light-profiles-in-unreal-engine

照明工程学会（IES）定义了一种文件格式，以使用真实世界测量数据描述光源的光照分布。此类IES光度文件或 **IES描述文件** 是一类照明行业标准方法，对特定真实照明灯具散发出光线亮度和光线衰减进行图解。其可使光照考虑灯具的反光表面、灯泡的形状以及发生的透镜效应。此类光度照明主要运用于企业领域（如媒体和娱乐或建筑和制造），但也常在游戏制作中用于获取逼真的光照效果。

IES光源描述文件是一种1D纹理（梯度）。但其实际并非纹理文件。曲线以弧形定义光强度，该弧形"扫过"轴，并根据提供的真实世界数据，使点光源、聚光源和矩形光源投射逼真光线。此曲线的工作原理与光总亮度的乘数类似，例如从光源投射纹理时，不会产生使用纹理的开销，也不会在某些角度发生错误。

在以下范例中，IES描述文件被指定到点光源，各面板左上角的图表显示给定IES描述文件的形状。

![undefined](../../../../../assets/images/92/928c570cb48d130b9a62bc7d628e11627941446e14801df796667d205b30e3a3.jpg)

点击查看大图。

如在文本编辑器中打开IES描述文件，可发现其为包含各式元数据的ASCII文件，如Lithonia TE_150S_E17_C范例所示：

```
	IESNA:LM-63-2002	[TEST] 11915	[TESTDATE] 1/31/2008	[ISSUEDATE] 1/24/2014	[TESTLAB] ACUITY BRANDS LIGHTING CONYERS LAB	[TESTMETHOD] IES LM-46:2004	[MANUFAC] Lithonia Lighting	[LUMCAT] TE 150S E17 C (SC=1.0)	[LUMINAIRE] PREMIUM ENCLOSED HIGHBAY INDUSTRIAL WITH ALUMINUM REFLECTOR, CLEAR TEMPERED GLASS LENS, AND CONCENTRATING DISTRIBUTION	[LAMPCAT] LU150	[LAMP] ONE 150-WATT CLEAR ET-23.5 HIGH PRESSURE SODIUM, VERTICAL BASE-UP POSITION	[BALLAST]	[BALLASTCAT]	[DISTRIBUTION] DIRECT, SC-0=1.05, SC-90=1.05	[_LAMPPOSITION] 0 , 0	[_LAMPTYPE] HIGH PRESSURE SODIUM	[_LAMPWATTAGE] 150	[_LAMPLUMENS] 16000	[_MOUNTING] Suspended	[_FAMILY] TE E17	[_PRODUCTID] 69f8c24f-2e1c-4665-820d-92d61687bd9f	[_INFOLINK] www.lithonia.com/visual/ies/ies.asp?vfile=	[_PRODUCTGROUP] INDOOR HID	[_TERCAT] Highbay, Nonlinear	[_TER] 41	TILT=NONE	1  16000  1  11  1  1  1  -1.4  0  0	1  1  189	0  5  15  25  35  45  55  65  75  85  90	0	8461  8664  10082  7108  4474  1272  330  106  54  39  35
```

## 使用方法

按照以下步骤在中使用你的IES描述文件：

### 导入和指定到光源

1. 要导入IES描述文件，可使用可用[纹理导入方法](../../../../working-with-content/datasmith/datasmith-import-options/index.md)之一：使用 **新增（Add New）** 按钮，拖放操作，或使用右键菜单。
2. 选择场景中的[点光源](../../light-types-and-their-mobility/point-lights/index.md)、[聚光源](../../light-types-and-their-mobility/spot-lights/index.md)或[矩形光源](../../light-types-and-their-mobility/rectangular-area-lights/index.md)。在 **细节** 面板中，将光源描述文件指定到 **光源描述文件（Light Profiles）** 下的 **IES纹理（IES Texture）** 插槽。

   ![Assigning the light profile to the IES Texture](../../../../../assets/images/f8/f8816c34701eadf01c945ede38c51e9734a7f65c9e6b0e71923f3c95a200dad9.png)

> [!NOTE]
> 由于光源描述文件遮罩和低光照贴图分辨率，因此使用拥有预计算 **静态** 光照构建的光源描述文件可能会导致较差效果。提高接收表面的光照贴图分辨率或使用 **静止** 或 **可移动** 光源可获得最佳效果。

### 描述文件光源强度

也可选择使用IES描述文件的光源强度，而非光源本身的 **强度**：

![Setting up IES intensity options](../../../../../assets/images/56/5645c80b3dbd92ac4128d0535f6a02f3198822cec44c528b77db6c9a0327c3ef.png)

- **使用IES强度（Use IES Intensity）** 将使用描述文件中的光源亮度；禁用时，则会使用选定光源的强度值。
- **IES强度比例（IES Intensity Scale）** 整体调整描述文件的亮度贡献。仅在启用 **使用IES强度（Use IES Intensity）** 时才可设置该数值。

### 纹理属性

打开IES描述文件时，[纹理编辑器](../../../../designing-visuals-rendering-and-graphics/textures/texture-asset-editor/index.md)在 **纹理光源描述文件（Texture Light Profiles）** 下提供若干可供设置的选项：

![undefined](../../../../../assets/images/a1/a11896e2668a3f70d6bac4d21d002ceabcb898b4e23b38aecf139426f46cc310.png)

Click the image for full size.

| 属性 | 说明 |
| --- | --- |
| **亮度（Brightness）** | 从IES描述文件导入的光源亮度（以烛光计）。在光源上启用 **使用IES强度（Use IES Intensity）**，且该值小于等于0时，描述文件仅用于遮罩，导致光源完全被描述文件遮住。此外，该选项应与光源的 **平方反比衰减（Inverse Square Falloff）** 设置结合使用。 |
| **纹理乘数（Texture Multiplier）** | 此不可编辑值为乘数，用于将纹理值映射到整合为1.0f球体的结果。 |

### 3D光源描述文件可视化

选择已指定IES纹理的光源时，将显示可视化光源代表。

![未选中光源](../../../../../assets/images/16/16e43acbd042b1f291830a4d02c202616dfac3fad1746b598b5b79c6f2a7707f.jpg)

![选中光源](../../../../../assets/images/24/2458a43ada0e075d103764400a5b5a2f1ecb247653015c908b274ed94630b516.jpg)

未选中光源

选中光源

## 附加说明

### 性能

IES描述文件的渲染速度极快，不会对性能造成显著影响，因此相较于[光源函数](../using-light-functions/index.md)，其是塑造光源形态的理想选择。

### 聚光源

在任何点光源或矩形光源上使用IES描述文件时，会在视觉上将此类光源转化为聚光源，而在聚光源上使用此类光源则造成类似效果，唯一区别是聚光源锥体会遮住IES描述文件效果。但由于聚光源的投射区为179度弧形（最大角度），因此通过该点的IES数据将丢失。

![选中光源](../../../../../assets/images/f7/f7afde45bb9a31318274172e352ce1837de0c8f93f0790834523c243a12a43a3.jpg)

![未选中光源](../../../../../assets/images/57/5718915111882b63363462f29735873420d94ba91b58f0f586167a2abd2e5a9f.jpg)

选中光源

未选中光源

在此比较中，IES描述文件朝所有方向发射光线。聚光源使用IES数据时，将以聚光源的 **锥体角度** 裁剪该数据。点光源使用IES数据时，不会裁剪IES描述文件。

### 获取和预览光源描述文件

由于几乎所有主流照明制造商均免费提供IES描述文件，因此最简单的获取方法便是访问制造商网站进行下载。以下为部分链接：

- Lithonia Lighting
- Philips

要查看光源IES描述文件，可使用光度查看器，如免费可用的IESviewer。利用其可选择光源描述文件，显示描述文件并预览效果，以便之后决定是否导入到Unreal Engine中。

> 图片已省略：IESviewer

图像来源Andrey Legotin。

> [!NOTE]
> 某些制造商网站（如Lithonia网站）拥有内置描述文件查看器，可在网页浏览器中使用，而无需下载描述文件进行预览。

