# Substrate材质概述

---
title: "Substrate材质概述"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/overview-of-substrate-materials-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "材质", "Substrate材质", "Substrate材质概述"]
---

# Substrate材质概述

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 材质 / Substrate材质 / Substrate材质概述

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/overview-of-substrate-materials-in-unreal-engine

Substrate是虚幻引擎中的材质创建方法，将着色模型和混合模式的固定套件（例如默认光照和透明涂层）替换为了表现力更强、更为模块化的框架。

Substrate材质消除了非Substrate（或旧版）材质系统的特定抽象性，而改用有度量的物质属性。 这扩大了可以工作的参数空间，可以更准确地呈现混合金属、玻璃、塑料等复杂的材质表面。 Substrate还简化了材质分层过程，可以更轻松地表示诸如金属上有液体或次表面散射上有透明涂层之类的表面。

Substrate中的材质依赖"物质Slab（slab of matter）"概念。 这些Slab是一种由具有明确单位的物理量参数化的原则性BSDF表示。 材质表示为执行各种运算（例如混合与分层）的Slab图。 由于其原则性表示，Substrate材质可以根据平台的容量进行简化，放弃视觉质量，以换取性能的提升。

## 新建项目

对于任何新建项目，默认启用Substrate。 **升级到UE 5.7及更高版本的现有项目**将继续默认使用非Substrate路径，除非其项目设置明确选择加入Substrate支持。

对于这些现有项目，你可以从**项目设置（Project Settings）> 渲染（Rendering）**选择加入Substrate，并启用**Substrate材质**，然后重新启动项目以使更改生效。

**对于默认启用Substrate的新项目，将使用可混合GBuffer格式，速度会优先于视觉保真度。** 此格式可以在项目的渲染设置中更改。

> [!TIP]
> 某些模板项目（例如汽车和建筑）默认使用**自适应GBuffer**，以便将视觉保真度置于性能之上。

> [!NOTE]
> 如需详细了解如何为项目设置GBuffer格式，请参阅本页的GBuffer格式分段。

### 材质编辑器转换

现有非Substrate材质可直接使用，但不会自动转换为Substrate节点。 对于现有非Substrate材质或新创建的材质，它们将继续使用非Substrate根节点参数化，并在编译时转换为Substrate材质。 这简化了项目迁移，无需修改资产或重新保存，并有助于降低烘焙成本。

要将材质转换为Substrate材质，请右键点击根节点，然后选择**Convert to Substrate**。 这会自动创建**Slab**，将其连接到根节点的**Front Material**，并将输入从非Substrate根节点连接到该Slab。

Substrate材质转换

在现有项目中启用Substrate或迁移到虚幻引擎5.7或更高版本时，请按照以下准则操作：

- 在启用Substrate的项目中打开现有的非Substrate材质将不会再改变材质。 它仍然会兼容非Substrate项目。
- 已明确被转换的材质与非Substrate项目不兼容。 转换是永久性的，不能恢复为非Substrate材质。
- 如果项目禁用了Substrate，Substrate材质将被渲染为黑色。 这包括利用转换后的材质创建的旧版Substrate材质。 你可以手动将转换后的Substrate材质重新连接到旧版材质，但这并不会移除材质图表中存在的Substrate节点。

## 视觉保真度GBuffer格式

Substrate支持两种不同的GBuffer格式来存储材质数据，即**可混合GBuffer**和**自适应GBuffer**。 这些格式在速度、内存和视觉保真度方面有不同的权衡。

### 可混合GBuffer

此格式的首要目标是*固定内存*占用和*可预测的速度*。 其主要用于60Hz项目。 它带有有限的功能集，类似于非Substrate路径。

- 性能与非Substrate路径持平。
- 面向性能导向型项目（60Hz）。
- 确保所有平台上的视觉效果一致性。
- 无烘焙开销。
- 它**不会**强制启用DBuffer贴花技术。

### 自适应GBuffer

这种格式的目标是视觉保真度，并充分发挥Substrate的潜力，允许丰富的材质复杂性。

- 性能成本较高，具体取决于屏幕上可见材质的复杂程度。
- 以视觉保真度为目标，支持更复杂的着色行为。
- 高视觉保真度取决于平台。
- 与可混合物格式相比，烘焙时间增加约15%。 具有复杂着色行为的材质会额外增加烘焙时间。
- 它会强制启用**DBuffer**贴花技术。
- 项目设置和控制台变量中提供了**闭合数（Closure Count）**和**逐像素字节数（Bytes Per Pixel）**的其它控制。

此格式仅在当前世代主机Xbox Series X/S、PlayStation 5和PlayStation 5 Pro、Windows PC (SM6)、MacOS (SM6)和Linux (SM6)上受支持。 在其他平台（包括SM5平台）上，材质会被简化，并且平台会以**可混合GBuffer**格式运行。

> [!NOTE]
> 有关使用自适应GBuffer的已知问题，请参阅本页面的[局限性和已知问题](index.md#limitations-and-known-issues)分段。

### DBuffer

- **可混合Gbuffer** **格式**将继续支持可混合物贴花和DBuffer贴花。 DBuffer贴花默认启用，但你可以在项目设置中选择退出。
- 自适应GBuffer格式仅支持DBuffer贴花。 如果项目不使用DBuffer贴花，渲染系统会自动为支持自适应GBuffer格式的平台启用。

使用DBuffer贴花时，作为实验性路径，Substrate支持材质在DBuffer求值期间法线读取，这可以通过`r.Substrate.DBufferPass`启用。 这允许DBuffer材质使用材质的法线，而无需任何时间重新投影或基于深度的法线重建。

## 可选项目设置和控制台变量

Substrate包括以下可选项目设置和控制台变量：

![Substrate项目设置](../../../../../assets/images/6b/6b31b22338dfa9668e44e7fa5ec47ee83d4f0f6a32b3707384c13d939d00c327.png)

Substrate项目设置

| 项目设置 | 说明 |
| --- | --- |
| **Substrate GBuffer格式（项目）** | 选择用于项目的GBuffer格式：**可混合GBuffer：**速度快，但光照复杂性有限。 如果选中，将强制所有平台使用此格式。**自适应GBuffer：**开销更大，但支持复杂的逐像素光照行为。 如果选择此项，则只有兼容平台才会使用此格式。 不兼容的平台将使用可混合GBuffer。 |
| **Substrate逐像素闭合（项目）** | 定义每个像素可以求值的最大闭合数。 如果材质包含的闭合数超过此值，则系统将以迭代方式简化该材质，直到其符合项目的预算。 此外，每个平台都有自己的闭合数上限，可以使用以下设置覆盖：**项目和平台的最小闭合数：**默认情况下，对于给定的平台，最大闭合数是平台的数量和项目指定的闭合数之间的最小值。**强制闭合数（Force Closure Count）**：这会强制项目指定闭合数为所有平台的最大值。 |
| **Substrate逐像素闭合重载** | 选择各平台每像素可求值的最大闭合数的定义方式： **使用平台闭合数：**在支持自适应GBuffer的平台上，取平台闭合数与项目闭合数中的较小值。**强制闭合数（Force Closure Count）：**在所有支持自适应GBuffer的平台上强制使用项目的闭合数。 |
| **Substrate不透明材质粗糙反射（实验性）** | 启用后，覆盖在其他材质上的粗糙表面能以物理上合理的方式模糊较低层。此功能为试验性功能。 |
| **Substrate半透明材质粗糙折射（Substrate translucent material rough refraction）** | 启用后，半透明表面会根据粗糙度产生粗糙折射。 启用此功能会增加失真通道的开销。 |
| **Substrate高级可视化着色器（限编辑器/Win64/DX12）（Substrate advanced visualization shaders (Editor / Win64 / DX12 Only)）** | 启用高级Substrate材质调试可视化着色器。 基础通道着色器可以输出此类高级数据。 目前，仅适用于针对Win64系统且运行DX12图形API的编辑器版本。 |
| **Substrate启用材质层支持（实验性）** | 启用Substrate材质层和用户界面。 注意：此支持是单向的；旧版层材质会自动升级，并且只能在重新保存资产后手动撤消。 |
| 控制台变量 |  |
| `r.Substrate.BytesPerPixel` | 用于指定Substrate材质自动简化前的逐像素存储字节数。 此变量默认设置为每个像素80字节。 你可以增大该值，材质越复杂，存储要求越高。 值越高，使用的内存越多，并且 **可能会影响内存带宽和其他性能特征** 。 此变量与性能的关系高度依赖内容和平台。 你可以根据需要在platform.ini配置文件中逐平台指定此值。 |
| `r.Substrate.MaxClosureCount` | 提供了一种方法来固定逐像素求值的闭包数量。 如果材质的闭包数量超过此值，则系统将自动简化该材质以遵循闭包数量。 |
| `r.Substrate.BlendableGBuffer` | 启用此功能将强制Substrate使用逐像素的单个着色模型将所有材质转换为旧版GBuffer。 可在低端平台上使用此功能，从而为需要此功能的项目优化性能。 |

## Substrate与材质层的关系

虚幻引擎中传统的**材质分层**（包括[基于图表的层](../../layering-materials/layered-materials/index.md)和[自定义层GUI中的层](../../layering-materials/using-material-layers/index.md)）都基于参数混合的概念。 每一层都定义了一个模式图表，其中的参数经混合后送入最终的着色模型。

材质层驱动的参数在送入Substrate定义的着色模型时不会受到阻碍。 但你必须使用父材质中的[Material Attribute](../../unreal-engine-material-expressions-reference/material-attributes-expressions/index.md)节点的输出手动设置此逻辑。 此方法存在局限性，即材质特性系统的参数列表是固定的，可能没有足够的插槽供送入多Slab的Substrate设置 — 你可能需要随意使用与其真正含义无关的引脚。

正如本页面后续所述，Substrate可以原生使用[参数混合](index.md)，但你无法从材质层接口访问该功能。 **将Substrate和材质层统一起来是未来开发中备受关注的领域。**

> [!NOTE]
> 务必注意，材质特性和材质层并不能真正实现物质分层：它可以模拟透明涂层，但无法在顶层之上形成彩色透光效果。 它们只能在表面上实现两种材质的混合（或水平混合），而不是将一层物质Slab叠加在另一层物质Slab之上。

## 处理Substrate材质

Substrate材质以类似于旧版材质的方式创作。 本小节介绍了构成Substrate材质的关键元素，包括其节点、混合模式以及有关你可以创建的材质类型的详情。

### Substrate Material Root节点

类似于旧版材质，**Material Root**节点是Substrate Slab和其他Substrate节点（例如运算符和构建块）通过正面材质送入的地方。

![Substrate Material Root节点](../../../../../assets/images/ee/ee8d675006cc043c7a3b54c0fda03dbf732f6fb0f8d828dd4e58d12769161d9e.jpg)

所有Substrate材质图表都必须连接到Root节点上的**正面材质（Front Material**）输入。 该输入是所有Substrate图表的端点。

![Material Root节点的正面材质输入](../../../../../assets/images/c0/c041955d7cbde6f71fb8f9c064ce4754763dc41cd20aa520af08f60965a66c06.jpg)

和旧版材质一样，选择Material Root节点后，请使用**细节（Details）**面板设置**混合模式（Blend Mode）**和其他属性，以定义材质的外观。 系统会自动从图表中扣除材质域和着色模型。

![设置Substrate混合模式](../../../../../assets/images/bb/bb03d9ba2a573d7884c4f13745caf26c3796981a53fbb28f9e8b8378eb37cfcc.png)

#### Substrate混合模式

Substrate使用自带的一套[混合模式](index.md)来定义材质颜色与背景的混合方式。 旧版材质混合模式在彼此混合方面效果有限，所以能够创建的材质类型受限。 Substrate的混合模式选择更多，可将材质混合到一起，形成各种各样的材质。 这对于实现物理上正确的半透明表面着色尤其重要。

Substrate包括以下混合模式：

![选择Substrate混合模式](../../../../../assets/images/bb/bb03d9ba2a573d7884c4f13745caf26c3796981a53fbb28f9e8b8378eb37cfcc.png)

| 混合模式 | 说明 |
| --- | --- |
| **不透明（Opaque）** | 定义了光线既不能通过也不能穿透的表面。 覆盖范围是1的不透明表面。 这与旧版不透明混合模式相同。 |
| **遮罩（Masked）** | 用于需要以二元（开/关）方式选择性控制可视性的材质。 覆盖范围是1或0的不透明表面。 这与旧版遮罩混合模式相同。 |
| **半透明 - 灰色透光（Translucent - Grey Transmittance）** | 一种具有彩色表面和覆盖范围，但透射率减少为灰阶的半透明材质。 这可以加快速度，因为它可以防止将后景深半透明额外渲染成调制通道。 这是退却混合模式，适合不支持硬件彩色半透明度（称为双源颜色混合）的平台。 [与旧版半透明混合模式类似](../../lit-translucency/index.md)。 |
| **叠加（Additive）** | 将材质颜色添加到背景颜色，其中最终颜色 = 源颜色 + 目标颜色。 |
| **仅彩色透光（Colored Transmittance Only）** | 仅使用材质的透射率。 表面相互作用减少到0。 这与旧版乘混合模式相同。 |
| **AlphaComposite（预乘的Alpha）** | 此混合模式让你可以更精细地控制材质在场景中以加法方式混合的颜色贡献，以及降低场景可见度的覆盖量（材质的覆盖范围可以使用根节点的"不透明度（Opacity）"输入重载）。 其工作原理与旧版Alpha合成（预乘Alpha）混合模式相同。 |
| **AlphaHoldout** | 此混合模式将维持Alpha，以便给对象打孔，露出后面的对象。 工作方式与旧版AlphaHoldout混合模式相同。 |
| **半透明 - 彩色透光（Translucent - Colored Transmittance）** | 一种具有彩色表面、覆盖范围和彩色透射率的全功能半透明材质。 在景深后期处理时使用单独半透明的开销更大，因为必须在单独的缓冲区中渲染透射率分量，类似于旧版薄半透明（ThinTranslucent）着色模型。 |

利用Substrate处理半透明比传统材质更简单，半透明混合模式的意图更明确。 这两者都有一个方面没有变化，即所有半透明混合模式也必须设置**光照模式（Lighting Mode）**来定义如何计算表面的光照。 这对于实现半透明材质的正确外观很重要。

你创建的绝大部分半透明材质都将使用**表面半透明体积（Surface Translucency Volume）**或**表面前向着色（Surface Forward Shading）**。

以下光照模式可供选择：

| 光照模式 | 说明 |
| --- | --- |
| **体积非定向（Volumetric NonDirectional）** | 将针对体积计算照明，且照明没有方向性。 此设置用于烟雾和灰尘等粒子特效。 这是最经济实惠的逐像素光照方法。 但是，没有考虑材质法线。 |
| **体积定向（Volumetric Directional）** | 将针对体积计算照明，且照明具有方向性，因此材质法线也被纳入考虑范围。 请注意，默认粒子切线空间面向摄像机，因此，启用"生成球体粒子（Generate Spherical Particles）"可获得更有用的切线空间。 |
| **体积逐顶点非定向（Volumetric PerVertex NonDirectional）** | 与体积非定向相同，但光照仅在顶点处求值，因此像素着色器开销低得多。 请注意，光照仍然来自于一个体积纹理，所以它被限制在一定范围内。 定向光源在远处无阴影。 |
| **体积逐顶点定向（Volumetric PerVertex Directional）** | 与体积定向相同，但光照仅在顶点处求值，因此像素着色器开销低得多。 请注意，光照仍然来自于一个体积纹理，所以它被限制在一定范围内。 定向光源在远处无阴影。 |
| **表面半透明体积（Surface Translucency Volume）** | 将为表面计算光照。 光线会在体积中累积，因此结果比较模糊，距离也有限，但逐像素开销非常低。 适合在半透明表面（如玻璃和水）上使用。 仅支持漫反射光照。 |
| **表面前向着色（Surface ForwardShading）** | 将为表面计算光照。 适合在半透明表面（如玻璃和水）上使用。 这使用前向着色来实现，因此支持来自局部光源的高光度高光，但不支持许多纯延迟功能。 这是开销最大的半透明光照方法，因为每个光源的贡献量逐像素计算。 |

> [!NOTE]
> 如需了解在Substrate材质中设置并使用半透明的示例，请参阅本页面的[半透明](index.md)小节。

### Substrate Slab

**Substrate Slab**是用来组装Substrate材质的基本构建块。 它是最小必要参数集，可用于实现绝大部分材质外观。 因此，可在它的基础上创作表现力强得多的外观。

Slab是物质Slab的原则性表示，由**界面（Interface）**和**介质（Medium）**组成。

![Substrate Slab的构成](../../../../../assets/images/bb/bb160f3d8bf2a63225c3cd3ad45bb11b17fc0548d0a4ab12770d41604a895eab.png)

Substrate Slab的构成：界面(1)和介质(2)。

1. **界面**是光线与材质表面交互的边界。 界面的属性主要由送入其中的粗糙度、法线、散射反照率（DiffusedAlbedo）、F0和F90值定义。
2. **介质**是界面之下光线被散射、透射和吸收的物质体积。 介质的属性主要由[平均自由程（Mean Free Path）](index.md)（即MFP）和"漫反射反射率（Diffuse Albedo）"输入定义。

Substrate Slab是非Substrate材质中单块Material Root节点的模块化替代品。 它由多个表面属性构成，例如漫反射、高光度、粗糙度、自发光、布料、各向异性，等等。 所有[Substrate BSDF节点](index.md)都包含对其所生成的材质类型已命名输出相关的属性，例如眼睛、毛发、简单透明涂层等等。

传统材质依赖混合模式来表示可以使用的输入。 Substrate使用不同BSDF Slab来定义材质类型。 由于这些材质不再直接绑定到混合模式，因此可以层层叠加和混合，生成不同类型的材质。

|  |  |
| --- | --- |
| [旧版Material Root节点](https://dev.epicgames.com/community/api/documentation/image/0a7912c7-9ff4-46ea-8940-f3bdbcd62da2?resizing_type=fit) | [Substrate Slab和Material Root节点](https://dev.epicgames.com/community/api/documentation/image/34df5bed-6b32-4452-b764-b13b94b94434?resizing_type=fit) |
| 旧版Material Root节点 | Substrate Slab和Material Root节点 |

常用的**Substrate Slab BSDF**节点包括以下输入：

| Substrate Slab输入 | 定义 |
| --- | --- |
| **漫反射反射率（Diffuse Albedo）** | 定义从表面进行漫反射的光线百分比。 这类似于介质的局部基础颜色。 默认值为0.18。当使用简单体积次表面表示时，漫反射反射率还表示参与介质散射的光的百分比。 |
| **F0** | 定义表面与摄像机垂直的高光度高光的颜色和亮度。 对于非传导性材质（塑料和其他非金属材质），这个数值通常在0到0.08的范围内。 对于金属材质，它的取值最高可以达1。 宝石的范围最高可以达到0.16左右。 |
| **F90** | 定义表面法线与摄像机成90度夹角的高光度高光的颜色。 换言之，在相对于摄像机视图的切线角。 仅会感知到色调和饱和度，因为亮度固定为1.0。随着F0降至0.02以下，这会淡入淡出为黑色。 |
| **粗糙度（Roughness）** | 控制材质的粗糙程度。 表面粗糙度的范围是从0到1。 为0（光滑）时，粗糙度是镜面反射。 为1（完全粗糙）时，粗糙度是完全哑光或漫反射。 使用各向异性时，会使用切线轴上的粗糙度值。 |
| **各向异性（Anisotropy）** | 控制材质的各向异性方向（-1：高光与双切线对齐，1：高光与切线对齐）。 |
| **法线（Normal）** | 取表面法线为输入。 法线根据Material Root节点上的空间属性被视为切线或世界空间。 此输入逐像素定义着色法线。 |
| **切线（Tangent）** | 取表面切线为输入。 法线根据Material Root节点上的空间属性被视为切线或世界空间。 此输入逐像素定义着色切线。 |
| **SSS MFP** | 次表面散射平均自由程（MFP）。 控制材质的感知密度并影响材质对光的吸收和散射。 更准确地说，它定义了光子与物质粒子相互作用的平均距离（厘米）。 这个距离由每个颜色通道控制。MFP直接影响透射以及Slab内光的散射量：透射：MFP越长，穿过物质Slab的光就越多。 例如，透过半透明表面时，场景会更加清晰可见。与Slab厚度相等的MFP只允许透过36%的场景颜色。散射：MFP越长，散射到摄像机的光就越少。MFP为零时，表面会呈不透明。此输入仅在没有为Material Root节点指定次表面轮廓资产时使用。 |
| **SSS MFP缩放（SSS MFP Scale）** | 此输入会将次表面轮廓中的次表面散射平均自由程半径缩放为0到1之间的值。 |
| **SSS相位各向异性（SSS Phase Anisotropy）** | 正值沿光线方向延长相位函数，导致前向散射。 负值沿光线方向的反方向延长函数，导致后向散射。 |
| **自发光颜色（Emissive Color）** | 控制材质表面上的自发光颜色。 |
| **第二粗糙度（Second Roughness）** | 控制次要高光度波瓣的粗糙度。 为0（光滑）时，粗糙度是镜面反射。 为1（完全粗糙）时，粗糙度是完全哑光或漫反射。此输入不影响漫反射粗糙度。 |
| **第二粗糙度权重（Second Roughness Weight）** | 主要和次要高光度波瓣之间的混合因子。 使用粗糙度的第一高光度的权重为(1 - SecondRoughnessWeight)。 值等于0时，仅渲染主要波瓣。 值为0.5时，主次各占50%，值为1.0时，仅渲染次要波瓣。 |
| **绒毛粗糙度（Fuzz Roughness）** | 控制绒毛层的粗糙程度。 粗糙度为0的绒毛为光滑（更有光泽），粗糙度为1的绒毛为完全粗糙（哑光）。 |
| **绒毛量（Fuzz Amount）** | 大于0时，在界面上添加类似绒毛的层，从而引发色彩逆反射。 这控制应用于表面层上的绒毛量。 通常在创建织物材质时使用。 |
| **绒毛颜色（Fuzz Color）** | 定义绒毛层的颜色。 |
| **闪烁密度（Glint Density）** | 材质表面上的微面片密度的对数表示。需要在配置文件ConsoleVariables.ini中设置`r.Substrate.Glints=1`。 |
| **闪烁UV（Glint UVs）** | 控制材质表面上闪光的位置和比例。需要在配置文件ConsoleVariables.ini中设置`r.Substrate.Glints=1`。 |

Slab的**次表面类型（Sub-Surface Type）**属性定义了Slab的次表面行为。 该属性定义了给定Slab的散射模型。 它提供了实现现存旧版行为或不同外观的显式控制点。

可用的**次表面类型**如下：

- **包裹（Wrap）**：使用包裹光照模型模拟光线散射。 相当于旧版的次表面（Subsurface）着色模型。
- **双面包裹（Two-Sided Wrap）**：在表面两侧使用包裹式光照模型模拟光线散射。 相当于旧版的双面植被（Two-Sided Foliage）着色模型。
- **漫反射（Diffusion）**：使用漫反射模型（屏幕空间或光线追踪）更新光线散射。 当提供SSS轮廓时，它就相当于旧版的次表面轮廓着色模型。 若未提供，则可以直接在Slab上控制MFP。
- **简单体积（Simple Volume）**：透射部分采用Beer-Lambert模型，散射部分则采用拟合模型。

对于垂直分层的Slab，有效的次表面类型仅限**简单体积**。 各层类型支持的次表面类型如下表：

| 底层 | 上层 |
| --- | --- |
| 无（None）简单体积包裹双面包裹漫反射 | 无简单体积 |

根据平台和着色路径的不同，漫反射次表面类型可能会不可用。 在此类情况下，系统会退却为简单的非散射漫反射模型。 仅延迟路径和路径追踪的路径支持漫反射，且仅限以下平台：Xbox One、Xbox Series S、Xbox Series X、PlayStation 4和5、PC DX11、PC DX12、Linux Vulkan和Mac OS。 低端平台（如移动端）不支持漫反射模型。 在所有Slab节点的底部，都有一个标签会根据拓扑结构指示使用哪种散射模型。 如果该散射类型与拓扑结构不兼容，则此标签可能与**次表面类型（Sub-Surface Type）**属性指定的标签不同。

### Substrate材质参数化

Substrate使用F0/漫反射反射率（Diffuse Albedo）参数化，而非Substrate路径则使用基础颜色/高光度/金属度。 此参数化提供了更大的灵活性，同时继续确保节能。 但是，一开始可能无法直观地选出适合F0的值。

作为一个简单的指导原则，你可以将材质分为两组：

- **绝缘性材质：**这类材质的金属度为0，在线性空间中，F0值通常在0.02到0.06之间。 在线性空间中，宝石的F0值最大为0.18。
- **导体材质：**此类材质的金属度为1，在线性空间中的F0值通常在0.5到1之间。

介于这些范围之间的是在现实世界中很少遇到的半导体材质。

![绝缘材质合理范围图表。](../../../../../assets/images/83/83791c7427d25be8a3dcfc95d559013daaf782a4ca60c8b3784d1e9032d3f314.jpg)

绝缘材质合理范围图表（来源Adobe Substance）

> [!NOTE]
> 取自[Adobe Substances](https://www.adobe.com/learn/substance-3d-designer/web/the-pbr-guide-part-2)的图表。

以下是常用材料的F0值列表：

> [!NOTE]
> 此列表摘自《实时渲染》第三版，作者为Tomas Akenine-Moller、Eric Haines和Naty Hoffman。

| 材质（Material） | F0线性 | F0 sRGB | 颜色 |
| --- | --- | --- | --- |
| **水** | 0.02 | 0.15 |  |
| **塑料/玻璃（低）** | 0.03 | 0.21 |  |
| **塑料（高）** | 0.05 | 0.24 |  |
| **玻璃（高）/红宝石色** | 0.08 | 0.31 |  |
| **钻石** | 0.17 | 0.45 |  |
| **铁** | 0.56、0.57、0.58 | 0.77、0.78、0.78 |  |
| **铜** | 0.95、0.64、0.54 | 0.98、0.82、0.76 |  |
| **金** | 1.00、0.71、0.29 | 1.00、0.86、0.57 |  |
| **铝** | 0.91、0.92、0.92 | 0.96、0.96、0.97 |  |
| **银** | 0.95、0.93、0.88 | 0.98、0.97、0.95 |  |

### 材质简化

当材质不匹配以下限制之一时，就会发生材质简化：

- 对于**可混合GBuffer**格式，如果材质有多个闭合。
- 对于**自适应GBuffer**格式，材质的逐像素闭合数多于项目/平台设置，或逐像素字节数超出项目设置。

考虑到这些参数，通过使用参数混合合并Slab，简化材质，直至满足要求。 简化原因和细节在Substrate面板（**窗口（Window）> Substrate**）中可见。

![材质编辑器中的Substrate统计数据面板。](../../../../../assets/images/34/347574d48649710f73e83904ce1f2f68d5158839248cfc48ac7cee0dbc393e05.png)

材质编辑器中的Substrate统计数据面板。

对于使用可混合Gbuffer格式的项目/平台，最终材质强制逐像素使用单个功能，对应于旧版着色模型。 这些功能是（按优先级顺序排列）：

- 绒毛
- 次表面散射（有或没有轮廓）
- 浑浊度

如果对给定像素同时启用了多个功能，则仅使用优先级最高的功能。 请注意，各向异性可以独立于其他功能启用。

在下面的示例材质中，在材质编辑器中查看Substrate统计数据面板时，Substrate材质超出了预算，并已做过相应的简化。

> 图片已省略：超出预算的简化Substrate材质。

超出预算的简化Substrate材质。

Substrate支持多个视觉功能，这些功能可以为每个Slab启用（或在使用SubstrateShadingModel表达式节点时自动启用）。 这些着色模型包括：

- F90
- 绒毛
- SSS效果（SSS配置文件（SSS Profile）、封装（Wrapped）、简单体积（Simple Volume））
- 浑浊度
- 各向异性
- 高光度配置文件
- 闪烁

使用可混合GBuffer格式时，某些功能不受支持。 包括：

- F90
- 逐像素MFP的扩散SSS
- 浑浊度
- 闪烁

在这种情况下，材质中将看不到该功能。 请注意，高光度LUT受支持，但类似于仅依赖于视图的效果。

下面是两种GBuffer格式之间这些功能的直观比较：

> 图片已省略：自适应GBuffer格式

> 图片已省略：可混合GBuffer格式

自适应GBuffer格式

可混合GBuffer格式

出于性能原因，在光照求值期间，这些功能会被映射到复杂度集，对应于越来越高的求值成本：

- 简单：默认光照材质（彩色漫反射和高光度、粗糙度）
- 单个：F90颜色、绒毛、SSS效果（使用MFP的轮廓（Profile）、封装（Wrapped）和简单体积（Simple Volume））、透明涂层（Clear Coat）。
- 复杂：各向异性、高光度配置文件、眼睛和毛发
- 特殊复杂：闪烁

### Substrate材质节点

以下类型的节点用于创作Substrate材质：

| 节点类型 | 说明 |
| --- | --- |
| [BSDFs](index.md) | 这些节点表示大部分类型的表面，从简单材质到更复杂的材质，如毛发、眼睛和水。 |
| [运算符](index.md) | 这些节点用于混合与分层多个Substrate Slab BSDF，创建复杂的不同表面。 |
| [构建块](index.md) | 这些节点转换常见材质类型，以用于Substrate，如创建涂层或虚幻引擎的默认旧版材质着色模型。 |
| [额外](index.md) | 这些节点定义Substrate材质的材质域，直接类似于其旧版材质域同名项。 |
| [辅助](index.md) | 这些节点用于在材质中执行一些转换，例如将透射率映射到Substrate Slab 的平均自由程。 |

#### Substrate BSDF节点

Substrate **BSDF**（双向散射分布函数）节点用于表示大部分类型的表面。该节点决定了你所创作的材质的视效效果，并会自动设置其对应的域和着色模型。 目标是从Material Root节点的细节面板删除这些方面。

Substrate包括以下BSDF：

> 图片已省略：Substrate BSDF节点

> [!NOTE]
> Slab BSDF是用于在Substrate中进行创作的主节点，可以使用其他Slab叠层。 其他BSDF用于专门用例，必须单独使用，不与其他BSDF混合。

| SubstrateBSDF节点 | 说明 |
| --- | --- |
| **Substrate Slab BSDF** | 一个聚合了以下多个分量的物质Slab的原则性表示：漫反射、高光度、浑浊度、布料绒毛和各向异性。 它可以渲染不透明次表面或半透明散射和半透明透射率次表面散射等效果。 |
| **Substrate Eye BSDF** | 用于使用Substrate渲染眼睛材质的BSDFS。 这包括角膜和虹膜的特定输入。 |
| **Substrate Hair BSDF** | 用于使用Substrate渲染毛发材质的BSDF。 |
| **Substrate Simple Clear Coat** | 简单又快速地渲染顶部有透明涂层的材质。 此节点在后台使用Substrate Slab BSDF，但简化了透明涂层的渲染工作流程。 它经过优化，用于渲染旧版透明涂层材质。 |
| **Substrate SingleLayerWater BSDF** | 渲染[单层水](../../unreal-engine-material-properties/shading-models/single-layer-water-shading-model/index.md)材质的专用BSDF，主要用于[水体](../../../../building-virtual-worlds/water-system/index.md)系统。 |
| **Substrate Unlit BSDF** | 用于使用彩色自发光亮度渲染无光照元素的BSDF。 此Substrate节点将旧版灰阶不透明度替换为了彩色透射。如果需要混合无光照Slab，需要使用只有自发光颜色输入的常规Substrate Slab。 可使用Coverage Weight运算符。 |
| **Substrate Volumetric-Fog-Cloud BSDF** | 用于表示参与介质的BSDF。 此节点用于渲染体积云和异类体积。 |

#### Substrate运算符节点

**Substrate运算符**节点可混合或叠加多个[Substrate Slab](index.md)，以形成各种复杂的表面。 如果Substrate Slab表示一块物质，运算符则表示将这些块组合在一起的方式。

以下Substrate运算符可供选择：

> 图片已省略：Substrate运算符节点

> [!NOTE]
> Substrate运算符节点并不适用于所有[Substrate BSDF](index.md)节点。 只有**Substrate Slab BSDF**和**Substrate Simple Clear Coat**节点可以使用这些运算符节点。

| Substrate运算符节点 | 说明 |
| --- | --- |
| **Substrate Coverage Weight** | 此运算符从Slab获取输入，并控制它具有的覆盖量，其中权重是覆盖量。 降低权重会降低Slab的物质覆盖范围，意味着你能透视下面的物质。 权重就类似于旧版材质根节点上的"不透明度（Opacity）"输入。 例如，在使用半透明混合模式时，你可以使用权重使表面变得半透明，或降低顶层透明涂层的可见性。 |
| **Substrate Horizontal Blend** | 此运算符从两块Slab获取输入：背景和前景。 混合输入使用线性插值控制这两块Slab混合在一起的程度。 可用于在表面上实现Slab之间的柔和过渡。 |
| **Substrate Vertical Layer** | 此运算符从两块Slab获取输入：顶层和底层。 顶部Slab覆盖底部Slab，底层的外观会受顶层属性的影响。 使用顶部厚度输入可控制顶层在底部上有多厚。 此运算符非常适合用于创建车漆、涂漆木材和潮湿表面。 |
| **Substrate Add** | 此运算符从两块Slab获取输入并将其相加。 创建的材质在物理上缺乏可行性，因为它会导致从表面传出的能量比传入的能量更多。应尽量避免使用此节点。 |
| **Substrate选择** | 此运算符从两个Substrate材质路径获取输入，并选择一个。 两条路径都启用了参数混合，因此最终只会留下一个Slab材质。它可用于随机选择带或不带次表面轮廓的Slab，例如使用蓝色噪点时。 这对于性能很重要，因为它强制使用单个Slab作为输出，因此将在光照通道期间对每个像素的单个闭合求值。 |

当启用了**使用参数混合（Use Parameter Blending）**时，运算符节点会提供一个选项，即将其输入板以参数混合的方式混合为单个板。 由于Substrate运算符可以通过将几块Slab混合并叠加以形成复杂的材质外观，其运行时开销可能会非常高（主要原因在于光照求值），可能对性能造成影响。 参数混合这项优化放弃了视觉效果准确性和开销较高的光照求值，以换取运行时性能的提升，以及更经济实惠的光照求值。

> [!NOTE]
> 如需详细了解参数混合优化，请参阅本页面的[参数混合](index.md)小节。

##### Substrate Coverage Weight

**Substrate Coverage Weight**运算符可控制垂直分层操作中两块Slab的比率。 **权重（Weight）**输入可驱动此材质在与[Substrate Vertical Layer运算符](index.md)叠加到一起时的覆盖范围（如下方示例所示）。 在使用作为覆盖范围的Alpha或作为不透明度的Alpha时（类似于半透明混合模式使用不透明度的情况），你还可以使用该运算符实现半透明表面。

> 图片已省略：Substrate Coverage Weight

上方图表使用了**Substrate Coverage Weight**运算符，其中**权重（Weight）**可驱动应用于底部Slab上的覆盖量。 权重为1时，为完全不透明，屏蔽绿色纹理图案。 权重为0.5时，为50%透明，混合两种材质颜色，并显示纹理图案。 权重为0时，为完全透明，仅显示绿色纹理图案。

> 图片已省略：Substrate Coverage Weight的示例

##### Substrate Horizontal Layer

**Substrate Horizontal Layer**运算符将两块Slab混合在一起，使其中一块表示背景，另一块表示前景。 **混合（Mix）**输入使用线性插值控制其混合比率。

> 图片已省略：Substrate Horizontal Blend节点

**背景（Background）**输入在其值为**0**时完全可见，**前景（Foreground）**在其值为**1**时完全可见。 混合比率为**0.5**时，这些Slab会被混合在一起，然后逐像素对混合求值。 混合输入可以使用纹理控制混合比率，如以下示例所示。

> 图片已省略：Substrate水平混合示例材质

##### Substrate Vertical Layer

**Substrate Vertical Layer**运算符可叠加**顶部Slab**和**底部Slab**。 此节点还会考虑顶层的厚度，以应用物理上正确的透射率和散射。此操作就类似于顶层覆盖底层的涂层运算。 底部Slab的外观依赖顶部Slab的属性。 如果传递到顶部输入的BSDF完全不透明，则底部Slab将完全不可见

在不透明底部层上需要透明或半透明顶部涂层的情况下，垂直分层尤其很有用。 例如，车漆、涂漆木材或水坑等潮湿表面。

##### Substrate Add

**Substrate Add**运算符可将两块Slab相加，并输出其结果。 此运算符在物理上缺乏可行性，因为它生成的材质从表面传出的能量会超出传入的能量。 当美术设计比物理合理性更重要时，它将很有用。 但是，为了维持物理上准确的表面，应避免使用此运算符。

> 图片已省略：Substrate Add节点示例

#### Substrate构建块节点

**Substrate构建块**节点是一组[材质函数](../../material-functions/index.md)，可为一些常见用例提供转译。 由于这些是材质函数，因此可以直接打开和检查。

以下Substrate构建块可供选择：

> 图片已省略：Substrate构建块节点

| Substrate构建块节点 | 说明 |
| --- | --- |
| **Substrate Coated Layer** | 该材质函数会创建由彼此叠加的两块Slab构成的涂层材质。 它会公开用户友好的参数，用于控制涂层界面和吸收率。 |
| **Substrate Standard Surface Opaque** | 该材质函数使用不透明表面的用户友好参数化来创建类似于Uber着色器的Substrate材质。 参数化使用行业的标准词汇和概念。 |
| **Substrate Standard Surface Translucent** | 该材质函数使用半透明表面的用户友好参数化来创建类似于Uber着色器的Substrate材质。 参数化使用行业的标准词汇和概念。 |
| **Substrate UE4 Default Shading** | 该材质函数复制Substrate的默认着色模型，用于非Substrate材质中使用的漫反射、金属感和高光度参数化。 |
| **Substrate UE5 Unlit Shading** | 该材质函数会重新创建带Substrate的UE4无光照着色模型。 |

#### Substrate额外节点

**Substrate额外**节点负责指定材质的类型及其功能，例如将Substrate材质指定为贴花或光源函数使用。 这些节点正好类似于非Substrate材质，后者被指定为材质域的一部分。

以下Substrate额外可供选择：

> 图片已省略：Substrate额外节点

> [!NOTE]
> 这些节点是单块的，必须单独使用。 此类节点不兼容[Substrate运算符](index.md)。

> [!TIP]
> 作为一种良好习惯，推荐将这些节点放在材质图表的末尾，在插入**正面材质（Front Material）**输入之前的位置。

| Substrate额外节点 | 说明 |
| --- | --- |
| **Substrate Convert To Decal** | 所有材质图表都可以用作贴花。 此节点可指定材质将进行转换，并仅用作贴花材质。 |
| **Substrate Light Function** | 此节点可指定仅将材质作为[光源函数](https://dev.epicgames.com/documentation/assets/building-virtual-worlds/lighting-and-shadows/features-of-lights/light-functions)使用。 它必须单独使用。 |
| **Substrate Post Process** | 此节点可指定仅将材质作为[后期处理材质](../../../post-process-effects/post-process-materials/index.md)使用。 它必须单独使用。 |
| **Substrate UI** | 此节点可指定仅将材质作为用户界面元素使用，例如被设计为用于[UMG UI设计器](../../../../user-interfaces/umg-editor-reference/index.md)的元素。 它必须单独使用。 |

例如，使用**Substrate Convert To Decal**节点时，所有Substrate材质都可以当作贴花材质，应用于场景中的网格体贴花和贴花Actor。

当连接到**Material Root**节点的**正面材质（Front Material）**输入时，额外节点会自动设置**材质域（Material Domain）**。 部分额外节点需要更改[混合模式](index.md)才能支持输出。

> 图片已省略：Substrate Convert-to-Decal的示例

使用**Substrate Convert To Decal**节点时，你必须将混合模式设置为**半透明灰色透射率（TranslucentGrey Transmittance）**、**彩色透射率（Colored Transmittance）**、**半透明彩色透射率（TranslucentColorTransmittance）**或**Alpha复合（预乘的Alpha）（AlphaComposite (Premultiplied Alpha)）**。 否则，材质编辑器的**统计数据（Stats）**面板中会显示错误。

#### Substrate辅助节点

**Substrate辅助**节点是一组节点和材质函数，用于执行某些转换，或实现旧版材质能实现的某些功能。

> 图片已省略：Substrate辅助节点

| Substrate辅助节点 | 说明 |
| --- | --- |
| **Substrate Flip Flop** | 基于入射视角控制表面反射率。 它允许基于视角将面向法线的颜色（F0）插入切线角颜色（F90），并使用衰减参数控制插值速度。 |
| **Substrate Haziness-To-Secondary-Roughness** | 根据基础表面粗糙度和浑浊度计算次要高光度波瓣粗糙度。 此参数化可确保浑浊度在物理上具备合理性，并且在感知上更容易创作。 |
| **Substrate IOR-To-F0** | 将非传导性IOR转换为F0值。 |
| **Substrate Metalness-To-DiffuseColorF0** | 将金属度参数化（基础颜色/高光度/金属感）转换为散射反照率（DiffuseAlbedo）/F0参数化。 |
| **Substrate Rotation-To-Tangent** | 将旋转角度转换为切线向量。 |
| **Substrate Thin-Film** | 根据薄膜参数，计算生成的材质高光度参数F0和F90。 |
| **Substrate Transmittance-To-MeanFreePath** | 根据参与介质的Slab（垂直于表面查看），将其对应的透射率颜色转换为平均自由程。 此节点会直接映射到Slab BSDF的SSS MPF输入。 |
| **Substrate View-Dependent-Coverage** | 基于入射视角调整覆盖范围。 此节点适合用于混合足够厚的层，厚到效果会随视角发生变化。 例如，在切线角的遮挡程度相较于入射角更大的大颗粒灰尘。 |

### 关于Substrate节点的补充说明

- **Substrate贴花材质**

  - 目前，Substrate贴花使用与旧版贴花混合模式路径相同的功能。
  - Substrate贴花的未来版本将设法提供与Substrate的其他功能相似但更强大的功能集，例如针对水体、血液、粘性物等的层半透明Slab。 此外还会考虑引入可以根据厚度侵蚀的层，例如车漆划痕、地面台阶和轮胎痕迹。
- **Substrate Shading Models节点**

  - 在项目启用了Substrate之后，打开之前创建的材质会将其自动转换，以使用其Slab。 所有现存输入都会被送入**Substrate Shading Model**节点。

  > 图片已省略：Substrate Shading Models节点

  > [!WARNING]
  > 在创建新Substrate材质时，此节点 **不应该** 手动创建或使用。

### Substrate统计数据面板

**Substrate**统计数据面板在材质编辑器的材质图表下可用。

> 图片已省略：Substrate统计数据面板

Substrate面板会显示关于材质、拓扑结构、其特性以及简化处理等方面的信息。

> 图片已省略：Substrate统计数据面板

### 使用运算符混合参数

若逐像素使用多个BSDF（双向散射分布函数），渲染速度会根据其在材质图表中的数量等比例减慢。 对两个BSDF的光照求值时，速度比对一个BSDF的光照求值慢一倍。 对于不透明和半透明表面也是如此。

运算符节点包括一个**使用参数混合（Use Parameter Blending）**复选框，可用来优化材质的性能和内存占用，同时维持图表中所有混合与分层操作的外观。 只有Material Root节点之前最右侧的运算符节点需要启用该设置。 图表中的其他所有节点都会自动应用参数混合。

需要考虑材质中多块Slab的性能时，参数混合是一个不错的回退选项。 启用后，两块Slab会合并为单块Slab，只需要单次光照求值。 将两块Slab合并为单块Slab之后，使用的内存也比两块Slab少得多。

> 图片已省略：Substrate运算符的使用参数混合复选框

> [!NOTE]
> 下方示例材质取自[内容示例Substrate关卡](https://www.fab.com/listings/4d251261-d98c-48e2-baee-8f4e47c67091)，分别为已启用和未启用**使用参数混合（Use Parameter Blending）**的版本。

此示例显示使用了两个BSDF的材质（M_Substrate_ShaderBall_IceRocks)。 左边无混合，右边则使用了参数混合。

> 图片已省略：Substrate参数混合示例

此材质（M_Substrate_ShaderBall_AnisoOverSSS）更为复杂，使用了两个垂直层运算符和单个覆盖范围权重运算符混合了四块Slab。 对于这样生成的材质，内存开销为每像素108字节。 启用"使用参数混合（Use Parameter Blending）"后，所有运算符的混合开销会降至每像素28字节。 左边的材质无混合，右边的材质则使用了参数混合。

> 图片已省略：Substrate参数混合示例

除了"运算符上的参数混合"节点之外，你还可以使用以下某个工作流程来实现类似结果：

- 在图表中手动混合散射反射率（DiffuseAlbedo）、F0、F90、粗糙度（Roughness）和其他特性。 将所有属性传入已连接到正面材质输入的单块Slab。 此方法很适合孤立的材质，但对于一大堆复杂的材质，可能会变得难以管理。
- 使用基于图表的[分层材质](../../layering-materials/layered-materials/index.md)工作流程。 由于它利用材质函数来复用工作，其扩展效果优于第一个选项。

在移动平台等更低端的平台上，为了提高性能，编译器会自动启用参数混合。 在中端平台上，材质的底层将渐进式使用参数混合，以保持在目标性能和内存约束范围之内。

### 金属度和高光度响应

Substrate使用的参数化不同于非Substrate（或旧版）材质中的DefaultLit着色模型，金属感输入没有了。 此参数化试图放弃抽象值（例如金属感和高光度），而转向有现实世界单位的物理属性。

Substrate材质的反光属性和高光度响应使用三个属性定义：散射反照率（DiffuseAlbedo）、F0和F90。 Substrate会自动强制节能，确保高光度界面和介质不会增加能量。 因此，F0越高，漫反射贡献量的可见度就越低。

金属度（Metalness）由辅助节点**Substrate Metalness-To-DiffuseAlbedo-F0**模拟而来。 它取基础颜色、高光度和金属感的值作为输入，并将其转换为映射到Substrate Slab上的**漫反射反射率（Diffuse Albedo）**和**F0**的值。

> 图片已省略：Substrate Metalness-To-DiffuseAlbedo-F0。

使用**边缘颜色（EdgeColor）或****F90**输入，即可实现对光源的各种各样的复杂材质漫反射和高光度响应。 例如，带有青色到黄色、垂直于切线的高光度反射的红色球体。

> 图片已省略：Substrate Metalness-to-DiffuseAlbedo-F0的示例

> [!TIP]
> 辅助节点**Substrate FlipFlop**适合用于实现基于法线的高光度着色。 通过可调衰减过渡控制高光度颜色随NoV发生的F0和F90的变化。

### 粗糙折射

Substrate支持透过半透明对象的粗糙折射，在带有半透明顶层的分层不透明材质上也支持粗糙折射。 场景背景的模糊度以及与被折射对象的距离是根据你使用扭曲/折射时的主材质粗糙度和被折射对象的距离来计算的。

#### 半透明粗糙折射

要创建带有粗糙折射的半透明材质，请在**细节**面板中设置以下属性。

- **混合模式（Blend Mode）**：半透明彩色透射（TranslucentColoredTransmittance）、半透明灰色透射（TranslucentGreyTransmittance），或仅彩色透射（ColoredTransmittanceOnly）。
- **折射方法（Refraction Method）**：折射率（Refraction，IOR）、像素法线偏移（Pixel Normal Offset）或2D偏移（2D Offset）。

将值传递到**折射（Refraction）**、**粗糙度（Roughness）**和**次表面散射平均自由程（SSS MFP）**中。 下面的图表在粗糙度大于0时生成了简单的磨砂玻璃效果。 使用了很高的次表面散射平均自由程（SSS MFP）值来创建完全透明的材质，而IOR值1.514则近似表示玻璃的相应值。

> 图片已省略：Substrate半透明粗糙折射的示例图表。

在下面的示例中，随着粗糙度值的增加（从左到右为0、0.2、0.6），玻璃背后的对象越来越模糊。

> 图片已省略：Substrate半透明粗糙折射的示例。

> [!NOTE]
> 粗糙折射中的模糊效果使用近似值来表示场景中半透明元素背后的深度。

#### 不透明粗糙折射

Substrate涂层可以基于顶部涂层的粗糙度和厚度来模糊下方的层。 此类型的折射对性能的消耗更大，必须在项目设置的**引擎（Engine）> 渲染（Rendering）**类别下为项目启用。 勾选**Substrate不透明材质粗糙折射（Substrate opaque material rough refraction）**复选框即可启用此功能。

> 图片已省略：Substrate不透明粗糙折射的项目设置

下面的图表展示了一个使用不透明材质粗糙折射的示例，在不透明棋盘格上使用带有透明涂层的垂直分层材质。

> 图片已省略：使用带有Substrate的不透明材质粗糙折射的示例。

**粗糙度（Roughness）**和**厚度（Thickness）**参数决定了底部材质层所应用的模糊程度。 增加任一值会增加折射的模糊程度。

你可以在下面的示例中看到这一点，其中左侧的透明涂层顶层的粗糙度和厚度为0.1。 右侧示例的粗糙度为0.8，厚度为6，从而导致底层变模糊。

> 图片已省略：Substrate粗糙折射厚度的示例

### Substrate层厚度

底层厚度被隐式固定为0.01厘米。

- 对于**不透明表面**（即无法透视的表面），此厚度**无关紧要**。
- 对于**半透明表面**（可透视的表面），你可以使用Transmittance to MFP节点，该节点会表示给定厚度所需的透射率。
- 对于**薄表面**（具有一定厚度但由于太薄而无法用几何体建模的表面），可以启用材质的"是薄表面（Is Thin Surface）"选项。 这样一来，根节点上就会指定底层的厚度。

### Substrate材质实例重载

你可以重载材质实例上的某些材质属性（如着色模型、高光度轮廓等）。 此类重载存在一些限制：

- 仅当材质仅包含SubstrateShadingModel节点时，**着色模型**的重载才可用。 如果材质包含Slab，则重载选项将不可用。
- 仅当Slab包含高光度轮廓时，**高光度轮廓**的重载才可用。 如果提供了重载项，则重载所有Slab的高光度轮廓（如果有）。

### 次表面散射和参与介质

Substrate Slab包含参与介质，可以用于模拟各种体积外观。

如果仅考虑渲染不透明材质，当Slab位于材质拓扑底部时，会考虑将其用于次表面散射。 此时将考虑两种情况：

- 如果在材质的细节面板中为某个Slab指定[次表面轮廓](../../unreal-engine-material-properties/shading-models/subsurface-profile-shading-model/index.md)，则该轮廓将被逐像素使用。 请记住，次表面轮廓**不可混合**。
- 如果未指定次表面轮廓，则由Slab的散射反射率（DiffuseAlbedo）和次表面轮廓平均自由程（SSS MPF）属性决定散射。 这些属性 **可以** 混合。

次表面散射的**MFP**（即平均自由程）是不同光波长在遇到碰撞之前可穿透介质的距离（以厘米为单位）。 下方示例从左到右显示了散射反射率（DiffuseAlbedo）（白色）和**次表面散射平均自由程（SSS MFP）**（红色）从0到1的变化。

> 图片已省略：将Substrate的MFP从0调整为1。

所有不在不透明材质底部（或在在半透明材质中使用）的Slab，都将考虑用于体积表示，同样要依靠散射反照率（DiffuseAlbedo）和次表面散射平均自由程（SSS MFP）属性。 散射反照率（DiffuseAlbed）表示将单次和多次散射都考虑在内的介质基础颜色

**次表面散射平均自由程（SSS MFP）**特性可控制介质垂直于表面视图的透射率，它表示下方表面的可见度。 **漫反射颜色（Diffuse Color）**代表光的散射量，也需遵守MFP距离。

> 图片已省略：Substrate SSS MFP网格的示例。

*透射率颜色从左到右从黑色过渡到蓝色，散射反射率（DiffuseAlbedo）从下到上从黑色过渡到白色的材质示例。*

将Slab彼此垂直叠加类似于一种涂层运算。 底Slab的可视性取决于顶Slab的透射率。 可以降低顶Slab的覆盖范围（例如在小水坑的边缘），使其逐渐消失。 使用**Coverage Weight**运算符节点即可实现此效果，类似于Alpha混合。

> 图片已省略：Substrate SSS MFP网格的示例。

*透射率范围从左到右从黑色向蓝色变化，覆盖范围从下到上从0过渡到1的材质示例。*

要实现特定透射率或散射颜色，你应该使用辅助节点**Substrate Transmittance-To-MeanFreePath**。 派生MFP是为了在沿法线的垂直方向查看表面时，使**透射率颜色（TransmittanceColor）**在法线入射处匹配。

下方示例显示了粉色不透明材质上的蓝色次表面散射，其中次表面散射平均自由程（SSS MFP）从透射率颜色派生。

> 图片已省略：使用Substrate Transmittance-To-MeanFreePath次表面散射的示例。

> [!TIP]
> **创作建议：**
>
> 平均自由程（MFP）表示与次表面散射相同的半透明或不透明材质的光线行为：即光在与物质互动（被吸收或散射）之前，其在介质内部的平均路径。 但针对不同的用例采用不同的设定可能会很有趣。
>
> 对于半透明（光学薄、透视）表面，不建议在尝试获得特定透射颜色时直接控制MFP，因为MFP不是颜色，而是光传输的度量。 建议使用Transmittance-To-MeanFreePath节点作为替代。
>
> 对于具有次表面散射（光学上指厚实且不透明）的表面，可以直接编写MFP。 在这种情况下，它大致表示光在其各个组成部分中散射的距离（厘米）。

## 覆盖率和透射率

**覆盖率（Coverage）**定义了材质的存在，可以将其理解为一种"遮罩"，用于定义材质存在的位置和数量。

- **0**表示完全无覆盖，即对应的层不可见。
- **1**表示完全覆盖：该层完全覆盖表面。

调整材质的覆盖率即可混合材质。 在Substrate中，覆盖率由**Coverage Weight**节点控制。

**透射率（Transmittance）**定义了光与材质的交互方式，即有多少光能穿过材质。

- **0**表示无光透射，即材质完全不透明。
- **1**表示光能完全透射，即材质不吸收任何光，而你可以完全看透该材质。

在Substrate中，透射率由Slab上的**平均自由程（MeanFreePath）**输入控制。 平均自由程（MFP）定义了光线与物质互动的平均距离。

- MFP为0表示光线会始终命中物质，但不会穿过该材质。 这相当于透射率为0。
- MFP为无限大表示光线永远不会命中物质，因此会穿过该物质。 这相当于透射率为1。

为方便起见，我们提供了**Transmittance-To-MFP**节点，用于将特定深度下实现的透射颜色转译为平均自由程。

**覆盖率（Coverage）**仅会对材质外观产生"灰度"影响（即材质可见程度定的变化）。 另一方面，**透射率（Transmittance）**可以根据其MFP值改变透射光的颜色。 某些颜色会被吸收，而其他颜色则会透射，从而产生彩色透射。 要实现这一点，你需要将混合模式设为**半透明彩色透射（TranslucentColoredTransmittance）**。 为提高性能，你可能需要使用**半透明灰色透射（TranslucentGreyTransmittance）**来退却到灰色透射。

### 半透明与混合模式

Substrate提供了更强大的半透明表面着色选择，优于传统非Substrate材质。 鉴于表面由物质（即Substrate Slab）构成，现在[Substrate混合模式](index.md)列表更具合理性。

要创建半透明材质，请执行以下操作：

1. 选择支持半透明的**混合模式**。

   - 半透明彩色透射（TranslucentColoredTransmittance）
   - 半透明灰色透射（TranslucentGreyTransmittance）
   - 仅彩色透射（ColoredTransmittanceOnly）
2. 选择Material Root节点后，使用**细节**面板选择**光照模式（Lighting Mode）**。 选项包括：

   - 表面前向着色（Surface Forward Shading）
   - 表面半透明体积（Surface Translucency Volume） — 此选项支持表面上的反射。
   - 体积非定向（Volumetric NonDirectional） — 使用起来开销更低，但不反射光线。

下面是半透明Substrate材质的示例设置。 其混合模式为**半透明彩色透射**，并使用**表面前向着色**光照模式。 它使用传递到Material Root节点的正面材质（Front Material）引脚的单一Slab，生成具有不透明外观的半透明材质。

> 图片已省略：不透明半透明Substrate材质的示例。

在Slab和正面材质输入之间使用**Substrate Coverage Weight**运算符即可控制材质的透射率。 使用Substrate Coverage Weight节点上的**权重（Weight）**输入即可控制材质的透明程度。

> 图片已省略：透明半透明Substrate材质的示例。

你可以使用0到1的常量值来控制整个材质的不透明度（如上所示），或使用纹理（如下所示）控制部分材质。

> 图片已省略：遮罩半透明Substrate材质的示例。

如果想创造类似彩色玻璃的物质Slab，则需要进一步指定参与介质的自由程。 此设置需要使用辅助节点**Transmittance-To-MeanFreePath**，如下方示例所示，使用连接到次表面散射平均自由程（SSS MFP）的透射颜色，即可仅在透光的区域将材质染为橙色。 指定的透射颜色即"目标"颜色，将在提供的厚度输入处达到（默认值为0.01厘米）。

> 图片已省略：用于被遮罩的半透明Substrate材质的彩色透射示例。

#### 关于Substrate半透明的其他说明

- 虽然Slab被视为参与介质的体积，但半透明材质并不支持屏幕空间次表面散射。

## Substrate性能

性能开销概览：

- 使用单个**SubstrateShadingModel**节点或旧版输入时，总体开销应与旧版模型相似。 基础通道、光照、通道和其他项目的开销应大致相同。
- 使用具备**多项功能**的**单个Slab**时（例如同时使用多项功能、诸如闪烁等高级功能，或在材质中使用多个Slab时），帧开销会开始增加。
- 在无参数混合的情况下使用**多块Slab**时，第二块Slab的开销会更高，后续Slab的成本将几乎呈线性增长。

Substrate在基础通道后使用材质分类通道，以帮助提高光照通道的效率。 这会在基础通道后增加一些小的固定开销，但有助于降低整体光照开销。 你可以使用调试视图模式来查看开销：

- 材质数量显示了逐像素执行的闭包数量，并直观地呈现了开销较高的项目。
- 材质分类显示了像素/图块运行时的光照复杂度。

## Substrate调试视图模式

使用Substrate时，查看其材质的性能如何以及哪些值得更多关注，会很有用。 Substrate的调试可视化模式位于**视图模式（View Modes）**下拉列表中的**Substrate**类别下。

> 图片已省略：在关卡编辑器中选择Substrate调试视图模式。

Substrate包括用于调试的以下可视化模式：

> [!NOTE]
> 在表中点击查看大图。

| 调试可视化 | 调试可视化名称 | 说明 |
| --- | --- | --- |
|  | **材质属性（Material Properties）** | 可视化鼠标光标下的Substrate属性。 将鼠标悬停在你想检查的像素上，将能够看到用于光照的最终封装材质闭包，例如属性、彩色权重、启用的材质特性、使用的字节等。 |
|  | **材质数量（Material Count）** | 可视化每像素的Substrate材质数量，并根据它们正在使用的BSDF Slab节点数量给像素着色。 |
|  | **材质字节数量（Material Bytes Count）** | 可视化每像素的Substrate材质占用量。 材质按它们正在使用的字节数量进行颜色编码。 你还可以将鼠标悬停在材质上，查看材质的逐像素字节数。 |
|  | **Substrate信息（Substrate Info）** | 此模式汇总了有关项目中Substrate使用情况的信息，包括有关最大内存使用情况、逐像素最大字节数（适合用于设置简化阈值）和启用的Substrate特性的信息。 |
| Substrate高级视图模式 |  |  |
|  | **高级材质属性（Advanced Material Properties）** | 报告当前光标下的材质所含不同Substrate Slab的信息。 每块Slab在屏幕上单独表示。此视图模式必须在"项目设置（Project Settings）"中启用，具体路径为**引擎（Engine）> 渲染（Rendering）**类别下的**Substrate高级可视化着色器（Substrate advanced visualization shaders）**复选框。 |
|  | **材质分类（Material Classification）** | 此模式按图块显示材质复杂度，并返回颜色编码的结果：**绿色**表示简单的Disney式材质，该材质使用旧版Slab。**黄色**表示启用除各向异性（Anisotropy）之外所有功能的单个Slab材质。**红色**表示在图块中已混合或已分层的多块Slab，或者材质启用了各向异性（Anisotropy）。查看Slab节点即可大致了解Substrate材质的复杂度，即**简单（Simple）**、**单个（Single）**还是**复杂（Complex）**。 |
|  | **粗糙折射分类（Rough Refraction Classification）** | 此模式显示使用不透明粗糙折射（Opaque Rough Refraction）属性的材质。 此模式还会区分启用或禁用了次表面散射的Substrate材质。其中一些可视化模式中显示的图块用于稍后运行优化的后期光照通道。 这适合用于优化Substrate材质，可减少使用的Slab数量、启用的功能数量，以及[在运算符上使用参数混合](index.md)。如果一种材质由多种材质混合并叠加而成，但针对给定的像素只有一个Slab可见（由于动态遮罩或低透射率值），则不可见的Slab在可视化中不会显示（或被优化掉）。 |

## 局限性和已知问题

- Substrate是一项测试版功能，因此不建议将其用于制片工作。
- 其平台支持和测试目前不完整。 随着Substrate转入可投入使用状态，我们将扩大测试覆盖范围。
- 其功能和用户体验可能会变化，导致现存资产表现出不同的行为，或完全失效。
- 对路径追踪器拥有试验性支持。
- 某些平台和渲染路径会出现问题，甚至可能完全不工作，例如DirectX 11（DX11）和Mac。
- 使用自适应GBuffer时：

  - 与使用可混合GBuffer相比，烘焙时间（着色器编译时间）会增加，即使对于简单材质也是如此。 这是因为自适应GBuffer需要更多处理，并且编码/解码步骤更复杂。
  - 对于完全相同的项目，运行时性能与可混合GBuffer相比会有所下降。 这主要是因为编码/解码步骤和更复杂的运行时求值。

## 其他资源

- [虚幻引擎中材质的未来 - GDC 2023](https://www.youtube.com/watch?v=joOIBteSo1w)
- [虚幻直播的状态](https://www.youtube.com/watch?v=teTroOAGZjM&t=8982s) — 时间戳：2:29:42
- [内容示例](https://www.fab.com/listings/4d251261-d98c-48e2-baee-8f4e47c67091)示例项目包括名为"SubstrateMaterials"的关卡，你可以在其中浏览关于Substrate材质运作方式的示例和演示。

  > [!WARNING]
  > 将Substrate用于内容示例项目时，需要为项目启用Substrate。 只有此地图经验证可在启用Substrate的情况下使用。 如果你仅使用内容示例项目的单个实例，建议仅为该关卡启用Substrate，而在使用项目其余部分时一律禁用。

