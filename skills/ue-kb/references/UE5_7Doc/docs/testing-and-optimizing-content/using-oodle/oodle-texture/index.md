---
title: "Oodle纹理"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/oodle-texture-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "使用Oodle", "Oodle纹理"]
---

# Oodle纹理

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / 使用Oodle / Oodle纹理

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/oodle-texture-in-unreal-engine

**Oodle纹理（Oodle Texture）**为各种BCn/DXTn格式提供了快速、高质量的纹理编码。 配置Oodle纹理之后，它会自动在后台运行。 你可以全局设置Oodle纹理，然后为LOD组和单独的纹理更具体地进行定义。

> [!WARNING]
> Oodle纹理不会编码ASTC或其他移动设备格式。

## 启用Oodle纹理

虚幻引擎中默认启用了Oodle纹理的插件。

![Oodle纹理插件](../../../../assets/images/29/297927cf47feaa88b2fa97ff2781e6cea1006a287e926f6373871bfb278887f8.jpg)

除了该插件之外，Oodle纹理还需要`DefaultEngine.ini`文件中的一个设置。

C++

```
\Engine\Config\DefaultEngine.ini    [AlternateTextureCompression]    TextureCompressionFormat="TextureFormatOodle"    TextureFormatPrefix="OODLE_"    bEnableInEditor=True
```

> [!NOTE]
> 由于Oodle纹理在**虚幻引擎**中默认启用，你的`BaseEngine.ini`文件中应该已经写入了这些行。

我们强烈建议保留`bEnableInEditor=true`，以在编辑器和打包构建之间保持行为一致。 如果设置为`False`，那么当美术师在编辑器中查看编码结果时，所看到的结果将与烘焙系统所生成的结果有所不同。 你可以检查日志，验证Oodle纹理是否已启用：

`LogTextureFormatOodle: Display: Oodle Texture 2.9.0 init RDO On with DefaultRDOLambda=30`

当你将Oodle用于给定纹理时，格式将包含前缀`OODLE_`：

`LogTexture: Display: Building textures: test (OODLE_AutoDXT, 256X256)`

## Oodle纹理的关键概念

要利用Oodle纹理，你必须理解两个概念：**RDO（率失真优化，Rate Distortion Optimization）**和**Lambda**。

### 理解RDO

RDO这个术语指的是牺牲质量（失真），换取大小（率）。 对于纹理编码，这听起来有点奇怪，毕竟DXTn/BCn纹理不会随质量改变大小，它们基于格式、分辨率和mip数量采用固定大小。

Oodle纹理可以选择公开一种方式来管理所生成的编码纹理数据，这样一来，当包含纹理的uasset被压缩以通过IOStore/.pak文件系统发布时，它会压缩得更小。 因此，Oodle纹理中的RDO仅减小发布大小。

此外，它调整为使用Kraken压缩格式。 如需更多信息，请参阅[Oodle数据](https://dev.epicgames.com/documentation/assets/testing-and-optimizing-your-content/Oodle/Data)。

### 理解Lambda

有一个参数用于确定造成了多大程度的失真，进而确定生成的文件缩小了多少，该参数称为Lambda。

Lambda可以设置为0到100之间的值，数字越低，失真越少，质量越高。 Lambda值为30左右时，仍可生成高质量的结果。 Lambda值为0将完全禁用RDO，达到理论上最佳的质量。 但是，即使要追求最佳质量，我们也推荐将Lambda值设为1，因为此时的成本效益比仍然非常出色，产生的失真极少，同时又能带来可观的发布大小收益。

一般而言，我们预期Lambda在全局设置，不会经常被覆盖。 若要为你的项目确定合适的值，需要多方协作，根据发布大小需求来确定。 最好将全局Lambda设置为最高的值（最低质量），然后根据需要针对LOD组或特定纹理选择性设置更高质量/更低Lambda。

> [!NOTE]
> 漫反射/反射率贴图之外的其他纹理很可能需要较低的Lambda（通常为5-20），尤其是法线贴图，因为肉眼看不出来的失真对于高光度高光之类的纹理可能会更加明显。

## 配置Oodle纹理

Oodle纹理主要使由`DefaultEngine.ini`文件配置，但也会在纹理LOD组上以及逐个纹理公开Lambda。

### 全局配置

`DefaultEngine.ini文件`中的`TextureFormatOodle`分段包含了Oodle纹理的全局设置。

C++

```
\Engine\Config\DefaultEngine.ini    [TextureFormatOodle]    DefaultRDOLambda=30    GlobalLambdaMultiplier=1.0    bForceAllBC23ToBC7=False    bForceRDOOff=False    bDebugColor=False
```

| 设置 | 定义 |
| --- | --- |
| `DefaultRDOLambda` | 这是别处未设置时将使用的RDO Lambda。 |
| `GlobalLambdaMultiplier` | 这用于缩放传递给编码器的Lambda。 它用作最后一刻的控制措施，不必细究单独的纹理或LOD组，即可管理发布大小。 该值直接应用于Lambda，意味着大于1的乘数值会增加失真并降低质量，而介于0到1之间的乘数值会减少失真并提高质量。 结果会舍入到最接近的整数来使用。 它无法禁用RDO（结果至少为1）。 |
| `bForceAllBC23ToBC7` | 启用后，只要请求BC2或BC3（即 DXT3和DXT5）格式，Oodle就会改为压缩BC7纹理。 BC7通常质量更高，但根据你的最低规格，有可能不可用。 |
| `bForceRDOOff` | 启用此项后，将始终禁用RDO，无论特定于纹理的RDO设置如何。 |
| `bDebugColor` | 启用此项后，纹理将压缩为表示其编码格式的纯色，用于目测识别。**格式 - 颜色**BC1 - 红色 (0xff0000)BC2 - 深绿色 (0x008000)BC3 - 绿色 (0x00ff00)BC4 - 深黄色 (0x808000)BC5 - 黄色 (0xffff00)BC6 - 紫色 (R = .5f、G = 0.0fB = .8f)BC7（不透明） - 深蓝色 (0x8080ff)BC7（透明） - 蓝色 (0x0000ff) |

### 配置纹理LOD组

表示RDO Lambda的LOD组参数被称为**有损压缩量（Lossy Compression Amount）**。 此参数在`DefaultDeviceProfiles.ini`文件中针对LOD组定义。

C++

```
TextureLODGroups=(Group=TEXTUREGROUP_WorldNormalMap,MinLODSize=1,MaxLODSize=8192,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage,**LossyCompressionAmount=TLCA_Low**)
```

"有损压缩量（Lossy Compression Amount）"可以采用以下值：

| 值（Value） | 说明 |
| --- | --- |
| TLCA_Default | 继承。 如果在纹理上设置，则从LOD组继承。 如果在LOD组上设置，则从`DefaultRDOLambda`继承。 |
| TLCA_None | 禁用RDO (0) |
| TLCA_Lowest | 1 - 最佳质量，最大文件大小。 |
| TLCA_Low | 10 |
| TLCA_Medium | 20 |
| TLCA_High | 30 |
| TLCA_Highest | 40 - 最差质量，最小文件大小。 |

### 配置单个纹理

RDO Lambda还可以使用"有损压缩量（Lossy Compression Amount）"参数为单个纹理设置，并采用上面所示的相同值。

要为单个纹理设置该参数，请执行以下操作：

1. 在**内容浏览器（Content Browser）**中双击要为其设置RDO Lambda的纹理，即可在**纹理编辑器（Texture Editor）**窗口中将其打开。
2. 转到**细节（Details）**面板，展开**压缩（Compression）**分段，然后点击箭头图标以显示**高级（Advanced）**选项。

   ![打开高级压缩选项](../../../../assets/images/6f/6f44b5c008467d9096ca5707fc1aa5868b046a107ad5668973a80342e6c1a6ae.jpg)
3. 使用**有损压缩量（Lossy Compression Amount）**参数旁边的下拉菜单，选择所需的值。

   ![使用有损压缩量下拉菜单选择RDO Lambda](../../../../assets/images/57/574b88365cb166a245d2dd008d8465bfce77a562983aa65574afc06e4aa50cea.jpg)
