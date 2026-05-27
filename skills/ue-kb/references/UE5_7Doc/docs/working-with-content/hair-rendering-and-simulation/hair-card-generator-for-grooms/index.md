---
title: "发片生成器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/hair-card-generator-for-grooms-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "毛发渲染与模拟", "发片生成器"]
---

# 发片生成器

> 路径：虚幻引擎5.7文档 / 管理内容 / 毛发渲染与模拟 / 发片生成器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/hair-card-generator-for-grooms-in-unreal-engine

创建这些发片是非常困难且耗时的工作，尤其是在试图匹配某个基于发束的Groom对应物的体积和形状时。**毛发发片生成器（Hair Card Generator）** 插件可简化此过程，方法是在[Groom资产编辑器](../groom-asset-editor-user-guide/index.md)中将基于发束的Groom转换成基于发片的表示。

| 基于发束的Groom | 生成的基于发片的Groom |
| --- | --- |
| 原始的基于发束的Groom | 生成的基于发片的Groom |

## 启用发片生成器插件

你可以在 **几何体（Geometry）** 类别下的 **插件** 浏览器中启用 **毛发发片生成器（Hair Card Generator）** 插件。你可以在主菜单中的 **编辑（Edit）** 处打开插件浏览器。

![毛发发片生成器插件](../../../../assets/images/e4/e42a63ece67d3ad74b954f93dfb4f9de8aea3de6444f58522a27062b667c70cd.jpg)

> [!NOTE]
> 如需了解如何启用插件，请参阅[使用插件](../../../understanding-the-basics/foundational-knowledge-in/working-with-plugins/index.md)。

启用后，你可以在[Groom资产编辑器](../groom-asset-editor-user-guide/index.md)的 **发片（Cards）** 面板中访问发片生成器，并在该面板下使用 **添加发片资产（Add Card asset）** 的 **添加（+）** 图标添加条目。

![Groom资产编辑器发片设置](../../../../assets/images/ce/ce9971e45b46d1c958db2d1f514f760522ab2d499a033494e3b0b96c9b872e9d.png)

## 发片生成器对话框与设置

你可以在Groom资产编辑器中的 **发片（Card）** 面板中点击 **网格体（Mesh）** 指定插槽下的 **生成毛发发片（Generate Hair Cards）** ，为此Groom启动发片生成。

![Groom发片面板生成毛发发片按钮](../../../../assets/images/51/5120c66ae24aa5714dc9a41cf1dda35834bc6d46e613c2f23cf609245d9e95d6.png)

这会打开 **发片生成设置（Card Generation Settings）** 对话框。你可以在此处配置各种属性，为毛发Groom组生成发片网格体。

![发片生成设置布局](../../../../assets/images/ca/cac365de740bb8b4a5d68d344283058398f9e8e95719f40e48af4e4c881edcb2.png)

下面是发片生成设置对话框的关键区域：

1. 已命名Groom和正在生成的LOD。
2. 将所有设置重置为默认值的按钮。
3. 生成发片网格体的可配置设置。
4. 已生成发片网格体的信息，以及发片、纹理和三角形数量的目标值。
5. 访问高级设置、强制重新生成发片网格体以及生成发片网格体的按钮。

**发片生成设置（Card Generation Settings）** 中有以下属性：

| 属性 | 说明 |
| --- | --- |
| 资产（Asset） |  |
| **基本文件名（Base Filename）** | 用于识别已生成发片集的名称。 |
| **为所有组生成几何体（Generate Geometry for All Groups）** | 启用后，使用所有物理组生成发片。禁用后，仅使用当前Groom组生成发片几何体。如果Groom组具有不同的物理模拟设置，则应禁用此设置。 |
| **LODIndex** | 设置LOD索引，仅可在 **发片（Cards）** 面板中编辑。 |
| **为Groom组生成（Generate for Groom Group）** | 设置Groom组的索引。此项可在 **发片（Cards）** 面板中编辑。仅有在禁用 **为所有组生成几何体（Generate Geometry for All Groups）** 时，此设置才有作用。 |
| 导入（Import） |  |
| **目标路径（Destination Path）** | 已生成网格体和纹理的路径。默认选项是放置在内容浏览器中Groom所在文件夹中的子文件夹。 |
| 细节级别（Level of Detail） |  |
| **在前一个LOD的基础上减少发片（Reduce Cards from Previous LOD）** | 启用后，将生成共享前一个LOD纹理的发片（如果存在）。只能基于前一个LOD修改 **三角形（Triangles）** 和 **最大飘动发片数量（Max Flyaway Cards）**。 |
| 随机性（Randomness） |  |
| **随机种子（Random Seed）** | 该数字用于初始化发片生成器，即以各种方式聚类发片和纹理。改变种子数可使结果略有不同。 |
| 纹理渲染（Texture Rendering） |  |
| **使用前一个LOD的保留空间（Use Reserved Space from Previous LOD）** | 如果存在前一个LOD并且在纹理图集中有一些保留空间，则使用同一个纹理，将当前LOD的已生成纹理放置在保留空间中。 |
| **图集大小（Atlas Size）** | 已生成纹理资产的像素大小。 |
| **已保留纹理空间LOD（Reserved Texture Space LOD）** | 为后续生成新LOD而保留的纹理百分比。 |
| **使用Groom资产发束宽度（Use Groom Asset Strand Width）** | 启用后，将使用 **发束（Strands）** 面板中的 **毛发宽度（Hair Width）** 、 **毛发根部比例（Hair Root Scale）** 和 **毛发末梢比例（Hair Tip Scale）** 创建纹理。 |
| 过滤选项（Filter Options） |  |
| **ID** | 发束过滤组ID号。 |
| **发片组（Card Groups）** | 如果存在发片组（groom_group_cards_id_attributes），将显示在发片组标签中。可以在 **高级（Advanced）** 设置中修改与发束过滤组（Strand Filter Group）关联的发片组（Card Group）标签，以将不同的几何体生成设置应用于发片组集。 |
| **发片数（Number of Cards）** | 已生成发片数量。最终数字可能与所选的理想数字略有不同，具体取决于正在生成的几何体。 |
| **纹理数（Number of Textures）** | 图集中的纹理数量。如果该值小于发片数量，一些发片将共享纹理。最终数字可能与所选的理想值略有不同。 |
| **三角形数量（Number of Triangles）** | 已生成网格体的三角形数量。最终数字可能与所选的理想值略有不同。 |
| **最大飘动发片数量（Max Flyaway Cards）** | 飘动发片的最大数量。这包含单股发束，代表飘动的毛发。 |
| **发束数量（Strand Count）** | 发束过滤组中的发束数量。 |
| **生成（Generate）** | 显示发片是否将完全或部分重新生成。这取决于与前一次发片生成相比已改变的参数。 |

#### 发片组设置

点击窗口底部的 **高级（Advanced）** 按钮，可以通过发片生成设置（Card Generation Settings）对话框访问 **发片组设置（Card Group Settings）** 。

![发片生成设置](../../../../assets/images/b3/b326b2a7ec84575bfd9cf3fa8a57ba7ff75e4de69f7f4450f1bdad5ea29b7e6e.png)

**发片组设置（Card Group Settings）** 中有以下属性。

![发片组设置](../../../../assets/images/65/6501f64d82814dcad43f50b3bd38b77f6de86e86a31aac26e0ee8297879a92e7.jpg)

| 属性 | 说明 |
| --- | --- |
| 设置组（Settings Group） |  |
| **发束数量（Strand Count）** |  |
| 资产（Asset） |  |
| **生成文件名（Generate Filename）** | 根据生成发片的Groom的名称为已生成发片生成名称。 |
| **LODIndex** | 明确说明将指定给这些已生成发片的细节级别索引。 |
| 发片（Cards） |  |
| **应用到发片组（Apply to Cards Group）** | 这些设置将适用的发片组(groom_group_cards_id)集。 |
| **发片目标数量（Target Number of Cards）** | 要生成的发片目标数量。这与主设置对话框中的 **发片数量（Number of Cards）** 相同。 |
| **最大飘动发片数量（Max Number of Flyaways）** | 将生成的飘动发片的最大数量，其中包含代表飘动毛发的单股发束。这与主设置对话框中的 **最大飘动发片数（Max Flyaway Cards）** 相同。 |
| 几何体（Geometry） |  |
| **三角形目标数量（Target Triangle Count）** | 此发束过滤组中所有发片的三角形目标数量。这与主设置对话框中的 **三角形数量（Number of Triangles）** 相同。如果禁用 **使用自适应细分（Use Adaptive Subdivision）** ，则此设置也将被禁用并忽略。 |
| 几何体（Geometry）：高级（Advanced） |  |
| **使用自适应细分（Use Adaptive Subdivision）** | 细分发片几何体以更好地匹配发束的局部曲率，直线区域使用更少的几何体。自适应细分使用 **三角形目标数量（Target Triangle Count）** 设置来确定可接受的误差率，以便大致达到三角形目标数量。 |
| **每发片最大垂直段数量（Max Vertical Segments Per Card）** | 如果禁用 **使用自适应细分（Use Adaptive Subdivision）** ，则为每个发片的垂直段（四边形）数量。 |
| 纹理（Textures） |  |
| **图集中的纹理数量（Number of Textures in Atlas）** | 存储在纹理图集中的纹理数量。这与主设置对话框中的 **纹理数量（Number of Textures）** 相同。 |
| 纹理渲染（Texture Rendering） |  |
| **发束宽度缩放因子（Strand Width Scaling Factor）** | 当生成发束纹理时，此选项会根据使用的缩放因子缩放发束宽度。除非发束宽度单位不是虚幻单位，否则通常应将其保留为1.0。 |
| **使用优化压缩（Use Optimized Compression）** | 生成发束纹理时，沿发束方向使用非常直的发束压缩纹理以节省纹理空间。 |

## 在虚幻引擎中生成发片网格体

按照以下步骤操作，即可通过基于发束的Groom生成发片网格体：

1. 在

   插件（Plugins）

   浏览器中，启用

   毛发发片生成器（Hair Card Generator）

   插件。
2. 在

   Groom资产编辑器（Groom Asset Editor）

   中，打开

   Groom

   资产。
3. 选择

   发片（Cards）

   面板。
4. 点击

   添加发片资产（Add Card Asset）

   添加新条目。
5. 在发片条目中进行以下设置：

   - 设置

     LOD索引（LOD Index）

     。这是生成发片网格体的细节级别，例如LOD 0。
   - 展开

     纹理（Textures）

     并设置

     布局（Layout）

     。这是已生成纹理所需的布局。
   - 设置

     组索引（Group Index）

     。这是将为其生成并映射发片的几何体（请参阅组的

     LOD

     面板）。
6. 点击网格体指定插槽下的

   生成毛发发片（Generate Hair Cards）

   。这将激活

   发片生成设置（Card Generation Settings）

   对话框。
7. 在

   发片生成设置（Card Generation Settings）

   对话框中，进行以下设置：

   - 可选

     ：修改

     基本文件名（Base Filename）

     和

     目标路径（Destination Path）

     ，改变资产输出位置。
   - 设置

     发片数（# Cards）

     ，粗略估计所需的独特发片数量，用以表示Groom中的发束数据。
   - 设置 **纹理数（# Textures）**，设置要在输出图集中创建的独特发束纹理数量。

     > [!NOTE]
     > 纹理目标数量不得超过发片数量。当纹理数量低于发片数量时，具有相似发束的发片将被映射到同一个纹理。
   - 设置 **三角形数（# Triangles）**，粗略估计所有发片上的目标三角形数量。

     > [!TIP]
     > 此设置与发片数量决定了发片几何体的精度。一般来说，发片越多，Groom覆盖会越好，但三角形的数量也必须增加，以便单个发片有足够的三角形来准确地呈现Groom发束。
   - 设置

     最大飘动发片数量（Max Flyaway Cards）

     ，选择专用于单股飘动发束的发片数量。
   - 可选

     ：修改其他设置，以便对已生成发片和纹理进行更高级的控制。
8. 在发片生成设置（Card Generation Settings）对话框的底部，点击

   生成（Generate）

   ，开始发片生成过程。

发片生成过程可能需要几分钟才能完成，完成后，已生成发片和纹理会被自动应用到Groom资产编辑器中的 **网格体（Mesh）** 和 **纹理（Textures）** 指定插槽。

## 其他资源

- 你可以在Epic开发者社区论坛上观看此流程的视频教程，了解如何通过基于发束的Groom生成发片网格体。
