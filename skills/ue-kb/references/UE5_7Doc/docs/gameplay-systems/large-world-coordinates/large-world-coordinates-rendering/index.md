---
title: "大型世界坐标渲染介绍。"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/large-world-coordinates-rendering-in-unreal-engine-5"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "大世界坐标", "大型世界坐标渲染介绍。"]
---

# 大型世界坐标渲染介绍。

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 大世界坐标 / 大型世界坐标渲染介绍。

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/large-world-coordinates-rendering-in-unreal-engine-5

大型世界坐标（LWC）使用名为 **DoubleFloat** 的数学库，它使用成对的单精度浮点数模拟双精度浮点算术。 该库的C++/HLSL类型和运算符位于 `Math/DoubleFloat.h` 和 `DoubleFloat.ush` 源文件中。

可用的HLSL类型有：

| HLSL类型 | 说明 |
| --- | --- |
| `FDFScalar` `FDFVector2/3/4` | 这些类型是float1/2/3/4的更高精度对应项。在内部由两个floatN矢量构成：High和Low。 |
| `FDFMatrix` | 类似于float4x4，但包含一个额外的float3 PreTranslation坐标。将矢量乘以此类型时，该矢量会首先使用PreTranslation进行转译，然后再应用float4x4矩阵。此类型适合变换为世界空间（LocalToWorld）。 |
| `FDFInverseMatrix` | 类似于float4x4，但包含一个额外的float3 PostTranslation坐标。将矢量乘以此类型时，该矢量会在应用float4x4矩阵之后使用PostTranslation进行转译。此类型适合变换为世界空间（LocalToWorld）。 |

运算符带有前缀"DF"，并有多种变体，可平衡精度和性能。变体在函数名称中用前缀或后缀来标记。例如：

- DFFast*

  是一个后缀。例如，

  DFFastAdd

  是一个后缀变体。此函数更快，但精度更低。使用此变体可获得最高速度，但会牺牲精度。对于基础运算符，每个函数的文档中都提供了论文参考资料，给出了关于其精度极限的详细说明。
- DF*Demote

  是一个前缀。例如，DFFastAddDemote是一个前缀变体。此变体会返回32位结果，而不是双精度值。

  DF*Demote

  的函数可用，且类似于

  LWCToFloat

  函数。使用

  DF*Demote

  函数可免除不必要的计算，效率更高。这是首选的截断方法。

> [!WARNING]
> DoubleFloat数学库中的许多数学函数会产生大量性能成本。如需关于实现最优性能和精度的指导，请参阅本页的[转译的世界空间](#%E8%BD%AC%E8%AF%91%E7%9A%84%E4%B8%96%E7%95%8C%E7%A9%BA%E9%97%B4)小节。

## FLWCVector及相似类型

在虚幻引擎中，有多个复合类型使用专用于大型世界坐标的不同底层数学类型结构。 这些类型带有"FLWC"前缀，可在 `LargeWorldCoordinates.ush` 源文件中找到。大部分着色器现在使用DoubleFloat类型。但是，一些系统仍使用FLWC类型。

可用的HLSL类型有：

| HLSL类型 | 说明 |
| --- | --- |
| `FLWCScalar` `FLWCVector2/3/4` | 这些类型类似于float1/2/3/4，但是，它们包含额外的图块坐标。因此，FLWCVector2由float2图块和float2偏移组成。表示的值由以下公式计算：图块 * TileSize + 偏移，其中TileSize表示一个被定义为256k的常量值。 |
| `FLWCMatrix` `FLWCInverseMatrix` | 这些类型类似于float4x4，但是，它们都包含额外的float3图块坐标。 |
| `FLWCMatrix` | 乘以矩阵后将图块坐标添加到结果。 |
| `FLWCInverseMatrix` | 在乘以矩阵之前添加图块坐标。 |
| `FLWCMatrix` | 此类型适合变换为世界空间（LocalToWorld）。 |
| `FLWCInverseMatrix` | 此类型适合从世界空间进行变换（WorldToLocal）。 |

`LWCAdd` 或 `LWCRsqrt` 等运算可以在这些类型上执行。接受LWC输入值的运算将返回LWC输出（ `LWCAdd` ），而其他运算会返回常规浮点输出（ `LWCRsqrt` ）。将坐标变小的运算提供了返回常规浮点的途径。

FLWC类型提供的精度相较于DoubleFloat库更低。对于靠近图块边缘的矢量，固定图块大小意味着 **图块（Tile）** 组件中的位不被使用，而 **偏移（Offset）** 只能存储截断的坐标。在虚幻引擎5.4之前，这会导致物体在世界中移动时精度时高时低，主要表现为物体抖动和振动。DoubleFloat数学类型通过删除固定大小解决了该问题，因为无论值的量级如何，这两个组件始终会存储尽可能高的精度。这在概念上类似于定点与浮点算术之间的差异。

## 材质

材质转译器使用LWC值工作。你的材质中的一些节点将输出LWC值而不是浮点值。特别是，基于坐标的世界空间位置节点（例如WorldPosition、Object、Camera、Actor和Particle）以及TransformPosition节点将输出LWC值。此外，如果输入是LWC类型变量，大部分数学节点会输出LWC类型。

> [!WARNING]
> 在材质中使用LWC会增加性能成本。绝对世界空间使用LWC比例，但会占用性能。使用LWC的数学运算耗时更长，因此成本更高。

你可以在接受或生成世界空间值的大部分材质节点上将 **世界位置原点类型（World Position Origin Type）** 属性设置为使用 **摄像机相对世界位置（Camera Relative World Position）** （或转译的世界空间），实现最优精度和性能。

![材质设置摄像机相对世界位置](../../../../assets/images/63/636b1f42d160127d1944b8d5ab3bdc9ac3bca7c51a072f14f861045465331509.png)

尽管材质图表由于性能约束而继续使用图块-偏移系统，但在使用转译的世界空间时仍能提高精度，因为顶点工厂等后端系统已经改用了DoubleFloat。

将LWC用于材质时还需要额外注意的事项：

- 绝对世界空间使用LWC比例，但占用性能。
- 使用LWC的数学运算耗时更长，因此成本更高。
- 带前缀"FWS"的别名类型位于

  WorldSpaceMath.ush

  头文件中。它们被用作抽象，使用

  FLWC*

  或

  FDF

  类型实现。编写与材质图表交互的HLSL代码（例如，材质模板头文件）时需要用到它们。

## 从UE4到UE5的转换指南

如果你要迁移虚幻引擎4或更早版本的项目，可以将现有HLSL代码库移植到虚幻引擎5。以下建议可以确保转换成功。

- 访问世界空间（LocalToWorld，PreViewTranslation）中的值/矩阵时，将

  View

  更改为

  PrimaryView

  。
- 如果你在世界空间中执行的代码无法编译（例如，它缺少函数重载或类型转换），并且你没有资源重构你的代码库，你可以在需要时使用

  LWCHackToFloat

  函数。例如，

  LWCHackToFloat(PrimaryView.PreViewTranslation)

  。

在你的代码仍无法编译的情况下：

- 考虑将着色器代码更改为在TranslatedWorldSpace而不是WorldSpace中运行。
- 世界空间值需要LWC类型（

  FLWSVector3

  ，而不是float3）和对应的LWC函数。

LWC类型不直接纳入统一缓冲区。如果使用了FLWC*类型，变量通常被存储为它所基于的组件（例如图块和偏移）。实体常常包含可以全部使用相同图块坐标的多个数据片段（例如，WorldToLocal、LocalToWorld和AbsoluteWorldPosition）。因此，典型模式是将偏移值连同单个共享float3 TilePosition值一起存储在统一缓冲区中（例如，RelativeWorldToLocal、LocalToRelativeWorld和RelativeWorldPosition）。这些统一的数据会被"解包"为一个包括实际LWC值的新结构体类型，其中许多值使用着色器中的单个TilePosition初始化。

没有可以针对 `FDF*` 类型共享的图块坐标。如果担忧内存成本或带宽，可以存储float3引用点和多个与此点相关的非LWC值。它们可以使用 `DFTwoSum(Offset, Base)` 重新组合为着色器中的DoubleFloat值。接着你可以使用DFFastTwoSum(Offset, Base)（运算数量减少一半），只要你能保证 |Offset| 大于 |Base| 。

着色器代码中的许多变量已被切换为LWC变体。以下似乎一些重要的示例：

- SceneData.ush

  、

  FPrimitiveSceneData

  和

  FInstanceSceneData

  有各种更新的矩阵和位置矢量。
- 光源位置和反射捕获位置。
- 全局摄像机统一数据更改了各种矩阵和偏移（例如PreViewTranslation）。例如，在SceneView和FNaniteView中。

在虚幻引擎5.0之前，全局摄像机统一数据要么在渲染网格体（处理实例化立体渲染）时通过 `ResolvedView` 访问，要么在渲染后期处理和其他全局通道时通过 `View` 访问。在这些虚幻引擎版本中，`View` 会直接引用全局统一缓冲区。`PrimaryView` 已作为新别名添加，它将引用解包的全局视图结构体。因此， `View.PreViewTranslation` 等名称已更改为 `PrimaryView.PreViewTranslation`。`ResolvedView.PreViewTranslation` 会在适用的情况下继续起作用，并且对于从常规View别名访问非LWC量有效。

切换这些全局类型将提供一般指示，来表明你的着色器代码需要重构哪些地方才能支持LWC。例如：

```
		float3 WorldPosition = mul(Input.LocalPosition, View.LocalToWorld);     // 上一行不再能够编译，需要被重构为：     FDFVector3 WorldPosition = DFMultiply(Input.LocalPosition, PrimaryView.LocalToWorld);
```

> [!WARNING]
> 初始LWC通道不会执行检查来确保所有着色器都能配合LWC正常运行。你可以使用全局函数 `LWCHackToFloat` 将LWC类型转换为非LWC类型。

`LWCHackToFloat` 表现为围绕 `DFDemote` 和 `LWCToFloat` 函数的包装器。当你知道使用LWC比例可以安全转换时，将使用非包装版本。`LWCHackToFloat` 是可搜索标识。如果你没有时间重构代码库以将 `WorldPosition` 从 `float3` 切换为 `FDFVector3` ，你可以改用以下代码：

```
		float3 WorldPosition = mul(Input.LocalPosition, LWCHackToFloat(PrimaryView.LocalToWorld));
```

如果你要升级虚幻引擎5.0或更高版本的项目，并使用 `FLWC*` 类型，则函数 `DFFromTileOffset` 和 `DFToTileOffset` 会在这些类型和新的DoubleFloat类型之间转换。还有 `DFFromTileOffset_Hack` 和 `DFToTileOffset_Hack`，它们是用作标识的别名，类似于 `LWCHackToFloat`。在类型之间转换会带来性能和精度损失，因此应仅在必要时使用。

TranslatedWorldSpace是虚幻引擎着色器中使用的现有引擎概念。它在之前旨在通过相对于摄像机原点工作来提高精度。但是，此行为对LWC很有用，因为在TranslatedWorldSpace中运行时，可以使用浮点数。我们建议不要将WorldPosition转换为双精度值，而是重构函数以改用转译的世界空间，这会带来出色的性能，同时保留高精度。例如：

```
		float3 TranslatedWorldPosition = mul(Input.LocalPosition, PrimaryView.LocalToTranslatedWorld);
```

## 转译的世界空间

要获得最优性能和精度，你可以从绝对世界空间（左）转换为转译的世界空间（右），例如 **摄像机相对世界空间（Camera Relative World Space）** 。理想情况下，你应该在项目中尽快转换为转译的世界空间，以利用这些优势。

下面显示了绝对世界空间（左）、摄像机空间（中）和转译的世界空间（右）的示例。

| 绝对世界空间 | 摄像机空间 | 转译的世界空间（摄像机相对世界空间） |
| --- | --- | --- |
| 绝对世界空间 | 摄像机空间 | 转译的世界空间（摄像机相对世界空间） |

你可以使用函数 `LWCAdd(WorldPosition`, `PreViewTranslation)` 通过图块-偏移类型转换你的世界空间。在DoubleFloat库中，最快的转换方法是使用 `DFFastToTranslatedWorld()`。此方法还可以将 `XToWorld` 或 `WorldToX` 矩阵转换为 `XToTranslatedWorld` 和 `TranslatedWorldToX`。要想使用LocalToWorld矩阵将本地位置转换为转译的世界空间，最快的方法是使用 `DFTransformToTranslatedWorld()`。

> [!NOTE]
> 这些函数应用了特定优化以减少开销，比使用 `DFFastAdd` 和其他类似函数更快。

## DoubleFloat的数学背景

`FDFVector` 类型由High和Low单精度矢量构成。High组成部分等于舍入到最接近的32位float的值，而Low值会捕获在舍入中引入的（大部分）误差。

从64位double转换为 `FDFScalar` 按如下所示执行：

```
	FDFScalar(double Input)	{		float High = (float)Input;		float  Low = (float)(Input - High);	}
```

下表是数字1.1舍入到17个小数位的各种二进制表示示例：

| 列 1 | 列 2 |
| --- | --- |
| `(double)1.1` | 1.1000000000000001 |
| `(float)1.1` | 1.1000000238418579 |
| `FDFScalar.High` | 1.1000000238418579 |
| `FDFScalar.Low` | -2.3841858265427618e-08 |

> [!TIP]
> 下面是关于此主题的一些资源：
>
> - 如需学术简介，请参阅论文
>
>   Extended-Precision Floating-Point Numbers for GPU Computation by Andrew Thall (2006)
>
>   。
> - 如需更全面和严谨的资源，请参阅
>
>   Formalization of Double-Word Arithmetic, and Comments on "Tight and Rigorous Error Bounds for Basic Building Blocks of Double-Word Arithmetic" by Jean-Michel Muller and Laurence Rideau (2022)
>
>   。
