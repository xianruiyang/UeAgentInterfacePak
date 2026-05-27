---
title: "Dataprep选择参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/dataprep-selection-reference-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Datasmith", "Dataprep导入自定义", "Dataprep选择参考"]
---

# Dataprep选择参考

> 路径：虚幻引擎5.7文档 / 管理内容 / Datasmith / Dataprep导入自定义 / Dataprep选择参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/dataprep-selection-reference-in-unreal-engine

本页将介绍Visual Dataprep系统中各个 **Select By** 方法块的作用；它们将帮助你确定哪些场景元素需要执行操作。

不同类型的 **Select By** 块提供不同的条件组（可设置）。Visual Dataprep系统执行Dataprep图表中的各项作业时，首先会假定该作业中定义的所有操作都应该用于场景中已导入的所有Actor和资源。但若作业包含本页中所述的任何 **Select By** 块，则Visual Dataprep系统会检查这些场景元素，看是否与 **Select By** 块中设置的条件匹配。对于为当前操作应用了作业的场景元素，若场景元素不满足条件，Visual Dataprep系统会从场景元素列表中删除该元素。更多背景信息请参见[Dataprep导入自定义](../index.md)。

> [!NOTE]
> 如欲了解可对按 **Select By** 条件标识的场景元素执行的操作，参见[Dataprep操作参考](../dataprep-operation-reference/index.md)。

## 按条件选择

场景元素的既定条件为true时，才可使用 **按条件选择（Select By Condition）** 块选择该元素。

### Is Class Of

仅在导入虚幻引擎中的场景元素的类与 **类（Class）** 设置中指定的类名称匹配时，才可使用 **Is Class Of** 块选择该元素。

此过滤器可以选择资产、Actor和组件。

![Is Class Of](../../../../../assets/images/49/498a96a8aaf6bdc9c4d6126780b3241096dc65b4dcc6ed32f2d3e0ad1c9c6611.png)

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **类（Class）** | 场景元素在可供该块选择之前必须匹配的类。 |
| **应包括子类（Should Include Child Class）** | 若某场景元素的虚幻引擎类派生自 **类（Class）** 设置中设定的类，确定此块是否应将该场景元素视为匹配成功。 默认启用，此块将接受上述场景元素。 若禁用，则此块仅接受与 **类（Class）** 设置完全匹配的场景元素。 例如，假设将 **类（Class）** 设置设为 **Actor**，且场景元素被视为拥有类 **StaticMeshActor**。在这种情况下，**StaticMeshActor** 派生自 **Actor** 基类，因此 **Is Class Of** 块将仅在已启用 **应包括子类（Should Include Child Class）** 设置后才会选择该场景元素。 |

### 包壳/选择隐藏项

> [!NOTE]
> 此过滤器要求你启用 **Dataprep几何体操作** 插件。

在选中一组Actor后，你可以用 **包壳/选择隐藏项（Jacketing / Select Hidden）** 过滤器来选中这些Actor内部的元素。

![Jacketing / Select Hidden](../../../../../assets/images/b2/b244b5f60fd6a603738e7113251400c4aba47acb269cd605c77361164975e366.png)

点击查看大图

| 设置 | 描述 |
| --- | --- |
| **精度（Accuracy）** | 定义体素网格的精度。Datasmith会使用这些体素网格来确定哪些元素位于Actor的边框内（外）。 |
| **合并距离（Merge Distance）** | 设置遮挡体积（遮挡测试判定的要填充的内容）中的间隙的最大尺寸。 |

## 按浮点选择

场景元素的某些数值属性为 **小于（Less Than）**、**大于（Greater Than）** 或 **约等于（Is Nearly Equal）** 给定阈值时，**按浮点选择（Select By Float）** 块才会选择这些场景元素。

> [!TIP]
> 若两个数字之差小于 `0.0001`，则 **Select By Float** 块会将这两个数字视为 **约等于（Is Nearly Equal）**。

### 边界体积

仅在场景元素在3D空间中有实际范围（从而有边界框），且该边界框的总体积满足设置中指定的比较时，才可使用 **边界体积（Bounding Volume）** 块选择该场景元素。

此过滤器可以选择资产、Actor和组件。

![Bounding Volume](../../../../../assets/images/6e/6e7f1ccb52204026014bb2f1821ce9fd78f833550e2db90162b56a54fcacafae.png)

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **下拉菜单（Dropdown Menu）** | 要在对象的包围体与指定体积之间执行的数学比较的类型：**小于（Less Than）**、**大于（Greater Than）** 或 **约等于（Is Nearly Equal）**。 |
| **浮点值（Float Value）** | 要与对象的包围体进行比较的体积，单位为立方厘米。 |

例如，假设某静态网格体的包围体为100厘米 x 100厘米。其边界框体积为100x100，即10000立方厘米。因此，若将静态网格体设为 **小于** 任何大于10000的数字，或 **大于** 任何小于10000的数字，此块将选择该静态网格体。

## 按整数选择

只有在场景元素的某些数值属性为 **小于（Less Than）**、**大于（Greater Than）** 或 **约等于（Is Nearly Equal）** 给定阈值时，**按整数选择（Select By Integer）** 块才会选择这些场景元素。

### 三角形数量

使用 **三角形数量（Triangle Count）** 块，只选择三角形数量满足设置中指定对比的静态网格体Actor和静态网格体资产。

此过滤器可以选择资产、Actor和组件。

![Triangle Count](../../../../../assets/images/0c/0cf493bd9ae94acb150cc9299e32d299cc815137186b7bd7175edf227b8cac1f.png)

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **下拉菜单（Dropdown Menu）** | 要在网格体中三角形数量和指定数量之间执行的数学对比的类型：**小于（Less Than）**、**大于（Greater Than）** 或 **约等于（Is Nearly Equal）**。 |
| **整数值（Integer Value）** | 要与对象的三角形数量进行对比的数量。 |

举例而言，如果将块的条件设置为 **小于** 任何大于2000的数字，或 **大于** 任何小于2000的数字，那么如果静态网格体Actor或资产拥有2000个三角形，则此块将选择该对象。

### 顶点数量

使用 **顶点数量（Vertex Count）** 块，只选择顶点数量满足设置中指定对比的静态网格体Actor和静态网格体资产。

此过滤器可以选择资产、Actor和组件。

![Vertex Count](../../../../../assets/images/79/7965de721b96a1bc7b18751d5d1469bc1e199a4db7927445f369d1e31d166dea.png)

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **下拉菜单（Dropdown Menu）** | 要在网格体中顶点数量和指定数量之间执行的数学对比的类型：**小于（Less Than）**、**大于（Greater Than）** 或 **约等于（Is Nearly Equal）**。 |
| **整数值（Integer Value）** | 要与对象的顶点数量进行对比的数量。 |

举例而言，如果将块的条件设置为 **小于** 任何大于5000的数字，或 **大于** 任何小于5000的数字，那么如果静态网格体Actor或资产拥有5000个顶点，则此块将选择该对象。

## 按字符串选择

场景元素的给定字符串属性与指定字符串模式匹配时，**按字符串选择（Select By String）** 块才会选择这些场景元素。

所有的字符串条件都能接受单个字符串或字符串数组。切换时，请点击 **切换成单个字符串/切换成字符串数组（Switch to Single / Switch to Array）** 按钮。如果是字符串数组，过滤器会返回所有 **至少符合一个** 数组中元素的对象（Actor、资产和/或组件，取决于过滤器限制）。

![Switching between a string and an array of strings](../../../../../assets/images/a4/a4fdca5d789736d5c0b876b07e0010a049a14a4ce48b3476da52c70a2a062f85.png)

点击查看大图

这些块提供三种字符串比较：

| 设置 | 说明 |
| --- | --- |
| **包含（Contains）** | 若提供的字符串完全在相关场景元素的字符串属性值内，则此比较成功。此类比较不可使用通配符；`*` 和 `?` 字符按字面意思处理。 |
| **匹配通配符（Matches Wildcard）** | 当提供的字符串全长与相关场景元素的字符串属性全长匹配时，此比较成功。可使用以下通配符： 此模式中，星号(`*`)可表示字符串属性中任意数量的字符。 此模式中，问号(`?`)可表示字符串属性中的零个或一个字符。 此模式必须匹配字符串全长。若要提供可能位于待比较字符串属性值的任意位置的部分字符串，用星号(`*`)做字符串模式的开头和结尾。例如，若字符串属性值为 `MyActorName`，则模式 `A*tor` 不匹配，而 `*A*tor*` 可匹配。 |
| **完全匹配（Exact Match）** | 仅当提供的字符串完全匹配相关场景元素的字符串属性值，此比较才成功。长度必须相同，且必须包含同一组字符，字符顺序也完全相同。 |

### Actor标签

仅当指定字符串与指派给 **世界大纲视图预览（World Outliner Preview）** 中的Actor的名称匹配时，才可使用 **Actor标签（Actor Label）** 块在Dataprep预览场景中选择这些Actor，也即 **世界大纲视图预览（World Outliner Preview）** 面板中显示的任何项目。

此过滤器可以选择资产和Actor。

![Actor Label](../../../../../assets/images/87/87e75f623a2f789d753e6aa00597a5cdbfe5cf5febee1a59564283ac07ed1512.png)

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **下拉菜单（Dropdown Menu）** | 要在Actor的标签与提供的字符串之间比较的字符串类型。详见上文[Select By String](#selectbystring)。 |
| **Actor Label（字符串）框（Actor Label (String) Box）** | 要针对Actor的标签进行测试的字符串模式。 |

### Metadata值

仅当Actor拥有Datasmith元数据及在设置中指定的 **键（Key）**，且该Datasmith元数据键值与设置中提供的字符串值匹配时，才可使用 **Metadata值（Metadata Value）** 块在Dataprep预览场景中选择Actor，也即 **大纲视图预览（Outliner Preview）** 面板中所示的任何项目。

此过滤器可以选择资产、Actor和组件。

![Metadata Value](../../../../../assets/images/73/73c4bedfb1394a4f369e5838f0a8296c438bb38ee7836e2c09efe970e8127bd7.png)

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **下拉菜单（Dropdown Menu）** | 要在Actor的Datasmith元数据值与提供的字符串之间比较的字符串类型。详见上文[Select By String](#selectbystring)。 |
| 元数据（字符串）框（Metadata (String) Box） | 要针对Actor的Datasmith元数据值进行测试的字符串模式。 |
| **键盘框（Key Box）** | 要在Actor的Datasmith元数据中查找的键值。 |

例如，假设有一个Actor，导入后分配了以下一组Datasmith元数据：

> 图片已省略：Datasmith Metadata

点击查看大图

若将 **键（Key）** 值设为 **Category**，可选择此Actor，方法是选择 **Contains** 操作并将第三列中的字符串模式设为 `Floor` 或 `Floors`。

欲了解Datasmith元数据的更多详情，参见[使用Datasmith元数据](../../using-datasmith-metadata/index.md)。

### Object Name

仅当指定字符串与指派给 **内容浏览器预览（Content Browser Preview）** 中的资源的名称匹配时，才可使用 **Object Name** 块选择这些资源，也即 **内容浏览器预览（Content Browser Preview）** 面板中列示的静态网格体、纹理、材质和动画。

此过滤器可以选择资产、Actor和组件。

> 图片已省略：Object Name

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **下拉菜单（Dropdown Menu）** | 要在场景元素的名称与提供的字符串之间比较的字符串类型。详见上文[Select By String](#selectbystring)。 |
| **Object Name（字符串）框（Object Name (String) Box）** | 要针对对象名称进行测试的字符串模式。 |

### Actor层

借助 **Actor层（Actor Layer）** 块，你可以在Dataprep预览场景的Actor中，也就是在 **大纲视图预览（Outliner Preview）** 面板中的项目中，选出符合你指定的层的Actor。

此过滤器只能选择Actor。

> 图片已省略：Actor Layer

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **下拉菜单（Dropdown Menu）** | 选择使用哪种字符串类型来比较Actor的层与你提供的字符串。详见上文[按字符串选择（Select By String）](#selectbystring)。 |
| **Actor Label（字符串）框（Actor Label (String) Box）** | 用来和Actor的图层名称进行比较的字符串内容。 |

### 标签值

当场景元素拥有 **标签值（Tag）** 设置中指定的Actor标签时，你可以用 **标签值（Tag Value）** 块来选中该场景元素。

此过滤器可以选择资产、Actor和组件。

> 图片已省略：Has Actor Tag

点击查看大图

| 设置 | 说明 |
| --- | --- |
| **下拉菜单（Dropdown Menu）** | 要在Actor的标签与提供的字符串之间比较的字符串类型。详见上文[Select By String](#selectbystring)。 |
| **标签（字符串）框（Tag (String) Box）** | 要查找的标签名称。 仅选择标签与此值完全匹配的Actor。 |

例如，若Actor导入时拥有以下一组标签：

> 图片已省略：Actor Tags list showing technical information from 3ds Max

点击查看大图

若要在 **Actor Tag** 块中选择此Actor，可将 **键（Key）** 设置设为 `Max.superclassof: GeometryClass`、`Max.classof: EditablePolyMesh`、`Max.handle: 407` 或上述列表中所示的任何其他值。

欲了解Datasmith导入的Actor标签的更多详情，参见[关于Datasmith导入流程](../../datasmith-import-process/index.md#metadata)。
