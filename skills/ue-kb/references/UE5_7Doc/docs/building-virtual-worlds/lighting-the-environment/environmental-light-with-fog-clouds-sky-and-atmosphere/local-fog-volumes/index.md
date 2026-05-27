---
title: "局部雾体积"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/local-fog-volumes-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "为场景设置光照", "雾、云、天空和大气的环境光源", "局部雾体积"]
---

# 局部雾体积

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 为场景设置光照 / 雾、云、天空和大气的环境光源 / 局部雾体积

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/local-fog-volumes-in-unreal-engine

在世界中添加雾通常会用到[天空大气](../sky-atmosphere-component/index.md)或[指数高度雾](../exponential-height-fog/index.md)，效果要么全有，要么全无。但使用[体积雾](../volumetric-fog/index.md)时则不同，它能够使用网格体和材质创建局部的变体。

**局部雾体积** 属于可放置的Actor，可以简单高效地快速创建雾的局部变体。与体积雾不同，局部雾体积适用于所有的平台和伸缩性级别，能提供与其他雾和光照系统一致的视觉效果，因而对低端和高端平台而言都是理想的选择。

![放置了局部雾体积和大气以及高度雾的场景。](../../../../../assets/images/70/70e8e9af12df45f3234e248f56d11527b6b8431f581fbe4f77fc792fb968c8f8.jpg)

![仅使用大气和高度雾的场景。](../../../../../assets/images/4b/4b00d70bc8c1adc1b814f2dd73e20623b521f01f122fa7a9ecbd1b74e4393e61.jpg)

放置了局部雾体积和大气以及高度雾的场景。

仅使用大气和高度雾的场景。

局部雾体积的主要应用场景是创建雾的变体，无需单独且更昂贵的系统——例如在启用体积雾的同时使用指数高度雾。因此，将局部雾体积与其他体积元素搭配使用时，合成顺序是：

1. 天空大气空气透视
2. 指数高度雾
3. 其他局部雾体积
4. 体积雾（如果启用）

## 使用局部雾体积

你可以在游戏世界的任何地方放置局部雾体积。它是一团球体状的参与介质，是指数高度雾与径向消散雾的混合体。所有局部雾体积都可以独立地进行平移、旋转和等分缩放以适应场景。

你可以使用 **视觉效果（Visual Effects）** 类别的 **创建（Create）** 菜单为场景添加局部雾体积，也可以使用 **放置Actor（Place Actors）** 面板。

> 动图已省略：局部雾体积变换演示。

将局部雾体积添加到场景中并进行缩放、平移和旋转。不支持非等分缩放。

### 搭配使用局部雾体积和体积雾

你可以将[体积雾](../volumetric-fog/index.md)与局部雾体积结合使用，这样可以为这些体积提供体积阴影和光照，但性能开销较高。

要搭配使用体积雾和局部雾体积，请打开 **指数高度雾（Exponential Height Fog）** 的细节面板，勾选 **体积雾(Volumetric Fog)** 属性。下面是启用和未启用体积雾的示例场景。

|  |  |
| --- | --- |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/b1caf850-2723-4eb3-889f-4218c5d2cfbd/lfv-withoutvolfog.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/796bb8a5-c3b8-4815-a6ca-d620801be4b5/lfv-withvolfog.png) |
| 仅局部雾体积 | 启用局部雾体积和体积雾 |

## 局部雾体积的属性和项目设置

局部雾体积的属性如下：

![局部雾体积细节面板设置](../../../../../assets/images/3d/3de858ee529371e95e059639740a7310476dd502e6629316bf2a987d8711b750.png)

| 属性 | 说明 |
| --- | --- |
| 径向雾分布 |  |
| **径向雾密度（Radial Fog Density）** | 径向雾的密度表示其在球体中心的系数。体积的最终外观由结合径向雾和高度雾的"覆盖率 = 1 - 透射率"决定，能实现柔和的边缘和高度雾。 |
| 高度雾分布 |  |
| **高度雾密度（Height Fog Density）** | 高度雾的密度表示其在单位球体中心中高度为0时的消光系数。体积的最终外观由结合径向雾和高度雾的"覆盖率 = 1 - 透射率"决定，能实现柔和的边缘和高度雾。 |
| **高度雾衰减（Height Fog Falloff）** | 决定密度如何随高度的增加而减小。值越小，过渡就越明显。1.0是最低值，低于此值时，地平线上将出现可见的视觉瑕疵。 |
| **高度雾偏移（Height Fog Offset）** | 相对于Actor的Z轴位置的高度偏移。 |
| 着色 |  |
| **散射分布（Scattering Distribution）** | 控制相位"G"参数，描述此雾体积内的散射。 |
| **雾反射率（Fog Albedo）** | 设置此雾体积的反射颜色。反射率（Albedo）是应用任何光照前的基础颜色。 |
| **雾自发光（Fog Emissive ）** | 决定此雾体积的自发光颜色。 |
| 排序 |  |
| **雾的排序优先级（Fog Sort Priority）** | 优先级可被用来重载按距离的排序。值越低，表示体积越远。例如，它将于优先级更高的体积之后绘制。 当在指数高度雾（Exponential Height Fog）设置中启用体积雾（Volumetric Fog）时，此设置不会被使用。 |

项目设置包含 **引擎（Engine） > 渲染（Rendering）** 分段中的局部雾体积的以下属性：

![局部雾体积项目设置。](../../../../../assets/images/33/3321e0f2e0e140d673dc03a6d786588c71d95f77e25951163605b5d8fabe6578.png)

| 项目设置 | 说明 |
| --- | --- |
| 半透明度 |  |
| **局部雾体积应用于半透明（Local Fog Volume Apply on Translucent）** | 对半透明元素启用局部雾体积的取样。 |
| 优化 |  |
| **支持局部雾体积（Support Local Fog Volumes）** | 局部雾体积组件可以在前向着色中应用于半透明和不透明表面，因此需要绑定资源才能将空气透视应用在透明表面上（并通过逐顶点求值应用于移动设备上的所有表面）。要求 `r.SupportLocalFogVolumes` 为true。 |

### 雾的着色

你可以用 **着色（Shading）** 属性定义雾的美学外观，包括反射颜色、自发光颜色和散射分布等。

**雾反射（Fog Albedo）** 决定雾和光源（如太阳和天空）互动时的颜色。可以用取色器选择雾的颜色。

|  |  |  |
| --- | --- | --- |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/24f04916-0d65-4aa7-8308-b0c3be7beaba/lfv-look-white.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/c6abe5eb-ac80-478a-929e-6f1a01251934/lfv-look-green.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/6a0b6032-b44e-4aba-926a-b6e65fa3f474/lfv-look-brown.png) |
| 反射颜色：白色（默认） | 反射颜色：绿色 | 反射颜色：棕色 |

**雾自发光（Fog Emissive）** 即雾发出的光的颜色。所发光的密度与局部雾体积的密度相同。可以用取色器选择雾自发光的颜色。

|  |  |  |
| --- | --- | --- |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/bf6173ad-ecf5-43d6-81e1-9f1f2b59dd3e/lfv-emissive-1.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/b96abb42-f851-432a-a8c1-75833e669d17/lfv-emissive-2.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/2b07090d-aa4a-4100-b7c6-c34fbca973ea/lfv-emissive-3.png) |
| 自发光颜色：无（默认） | 自发光颜色：绿色 | 自发光颜色：红色 |

**散射分布（Scattering Distribution）** 决定入射光在各个方向上散射的程度。零表示光线在所有方向上均匀散射，而值越接近1，则散射方向越集中于光线的方向。

> 图片已省略：拖动滑块即可查看局部雾散射分布从低到高的变化，数值分别为0、0.25、0.5、0.75、0.98和0.99

**拖动滑块即可查看局部雾散射分布从低到高的变化，数值分别为0、0.25、0.5、0.75、0.98和0.99**

> [!TIP]
> 要产生体积雾光束，必须启用体积雾，且散射分布必须接近零。默认的散射分布0.2就是很好的起始值。

### 雾的分部

雾的分布通过密度、衰减和高度偏移等属性控制穿过雾体积的光量。这些属性与指数高度雾组件中的属性类似。

**径向雾密度（Radial Fog Density）** 和 **高度雾密度（Height Fog Density）** 控制体积的外观，以实现柔和的边缘和高度雾。

![径向雾和高度雾密度](../../../../../assets/images/21/217807f51af2de35e5b8d4a5ca9e1e9e10ddd0d3330ffc14c0215d7bc8d73f55.jpg)

局部雾体积的示例。从左到右分别为具有径向密度的雾、具有高度密度的雾、具有径向和高度密度组合的雾。

> [!NOTE]
> 局部雾体积的相位函数控制体积内光的一致性。由于使用快速解析积分来对光照进行求值，因此阴影和光照函数是被忽略的。

**高度雾衰减（Height Fog Falloff）** 决定雾的密度如何随高度增加而减小。值越小，过渡就越明显，值越大，过渡就越不明显。

|  |  |  |
| --- | --- | --- |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/fec46eef-2bd8-467e-9619-0ec4fd046c71/lfv-falloff-1.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/494766ef-20b1-4ab3-a70d-ec7faf5e10e2/lfv-falloff-2.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/51965c31-f7d7-4397-bd12-00e51a6db5be/lfv-falloff-3.png) |
| 高度雾衰减：500 | 高度雾衰减：1000（默认） | 高度雾衰减：2500 |

**高度雾偏移（Height Fog Offset）** 将根据相对于局部雾体积内Actor Z轴（向上）的位置而移动高度雾的中心。偏移量越低，雾在径向体积内越向下移动，偏移量越高，雾越向垂直方向向上移动。

|  |  |  |
| --- | --- | --- |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/196eaf8c-3a25-4b37-9798-9f12d3f2b128/lfv-offset-1.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/6f9653f0-b237-449d-91e2-f0425434ba17/lfv-offset-2.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/e57128f0-a267-48c4-8b3e-b41f2e62bab0/lfv-offset-3.png) |
| 高度雾偏移: -0.12 | 高度雾偏移: 0（默认） | 高度雾偏移: 0.12 |

### 雾的排序优先级

局部雾体积根据其中心到摄像机视图的距离在屏幕上合成。当它们发生重叠时，你可以应用优先级来控制它们的排序顺序。若在指数高度雾设置中启用体积雾，局部雾体积将被体素化为体积表示——局部雾体积不进行排序，而是被体素化为重叠的参与介质。当体积雾启用阴影投射时，光照也将造成雾。

下面两个示例展示了启用和未启用体积雾时的重叠局部雾体积。

|  |  |
| --- | --- |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/92b15bf9-79dd-45a0-9349-3c8639b3c22e/lfv-fog-sorting-standard.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/a6f764f3-8517-4d51-a8ee-6eecc50da8b6/lfv-fog-sorting-volfog.png) |
| 两个不同颜色的局部雾体积进行合成。 | 两个不同颜色的局部雾体积进行合成，且开启体积雾。 |

> [!NOTE]
> 由于体积雾被体素化为参与介质且没有进行排序，这可能导致视觉效果上的差异。例如，如果散射分布（相位函数）与体积雾的散射分布不同，最终的视觉效果就可能会不同。

如果启用了体积雾，雾将被体素化，以便适当排序。但如果未对局部雾体积使用体积雾，你可以使用 **雾的排序优先级（Fog Sort Priority）** 设置项来重载按距离排序。值越小意味着该体积距离越远——该体积将在其他体积之后绘制。值越大意味着该体积距离摄像机越近，因此将优先于其他体积渲染。

因为可能存在多个重叠的局部雾体积，所以当你希望将较大的环境局部雾始终位于更小、更浓密的雾体积后时，排序将很有用。在这些情况下，即使不启用体积雾，局部雾在近距离观看时也会被很好地混合，如下方场景所示。

|  |  |
| --- | --- |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/bb17db68-cb97-4605-8cb4-2be2f0f98215/lfv-sorting-3.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/2b8deaf2-d6e9-4a8b-afd8-9bcf7efd61cf/lfv-sorting-4.png) |
| 从地面观察两个重叠的局部雾体积。 | 从上方观察两个重叠的局部雾体积。 |

## 性能和调试

以下是一些关于局部雾体积性能改进和内容调试的建议：

- 局部雾体积是使用屏幕图块（屏幕被分成的小块即图块）进行剔除的，这使得它们的开销类似于添加到场景中的动态光源，因为它们的开销与它们在屏幕上占用的空间范围相关。

  - 你可以使用控制台命令

    r.LocalFogVolume.TileDebug

    在屏幕空间中直观地看到开销范围。

    - 1

      以颜色显示逐图块的局部雾体积数量。
    - 2

      以颜色显示逐图块的局部雾体积数量，以及显示像素丢弃/裁剪的效果。
- 对低端硬件而言，最好限制不同体积之间的重叠。当摄像机完全位于其中时，这能减少需要逐像素处理的体积数量。

### 局部雾体积图块调试

你可以使用控制台命令 `r.LocalFogVolume.TileDebug` 直观地显示逐屏幕图块的局部雾体积剔除。

请从以下值中任选其一：

- 1

  以颜色显示逐屏幕图块的局部雾体积数量。
- 2

  以颜色显示逐屏幕图块的局部雾体积数量，以及显示像素丢弃/裁剪的效果。

以下场景中的示例展示了多个局部雾体积，有些体积彼此靠近，有些体积则重叠在了一起。

![用于调试目的的重叠局部雾体积示例。](../../../../../assets/images/df/dfe8053101dc19b836400955876c8b8e5a9af255a6584089d7d88fbf5a959694.jpg)

以上方示例场景为例，下方显示了启用图块调试时视图的样子。

|  |  |
| --- | --- |
| [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/a51e573c-476d-445c-85b6-fdc721a1078f/lfv-tiledebug-2.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/24c23287-66ca-4b8f-bf06-a2e86e05ff38/lfv-tiledebug-3.png) |
| r.LocalFogVolume.TileDebug 1 | r.LocalFogVolume.TileDebug 2 |

> [!NOTE]
> 启用体积雾时，图块调试视图将无法工作。

## 实用的控制台变量

| 控制台变量 | 说明 | 默认值 |
| --- | --- | --- |
| `r.LocalFogVolume.ApplyOnTranslucent` | 此项目设置决定能否对半透明元素上的局部雾体积进行取样。设置为1即可为半透明网格体应用局部雾体积。 | 0 |
| `r.LocalFogVolume.RenderIntoVolumetricFog` | 设置是否将局部雾体积体素化以放入体积雾渲染系统。否则，局部雾体积将保持孤立。此功能默认启用。 | 1 |
| `r.LocalFogVolume.TilePixelSize` | 局部雾体积被剔除时屏幕上图块的像素大小。 | 128 |
| `r.LocalFogVolume.TileMaxInstanceCount` | 逐视图（以及逐图块，以确保一致性）所考虑的最大局部雾体积数量。 | 32 |
| `r.LocalFogVolume.TileDebug` | 调试图块化渲染数据的复杂性。0表示禁用。1表示以颜色显示逐图块的局部雾体积数量。2表示的内容与1相同，但还将显示像素丢弃/裁剪的效果。 | 0 |
| `r.LocalFogVolume.GlobalStartDistance` | 设置局部雾体积开始出现时距离摄像机的起始距离（以厘米为单位）。 | 2000 |
| `r.LocalFogVolume.HalfResolution` | 将以一半的分辨率渲染局部雾体积，然后再上采样到全分辨率。启用后，仅适用于移动端的渲染路径。 | 0 |
| `r.LocalFogVolume.MaxDensityIntoVolumetricFog` | LocalFogVolume高度雾模式在底部的密度可以呈指数级增长。由于密度高，体积雾时间重投影可能会发生泄漏。降低密度即可控制视觉瑕疵。 | 0.01 |
