# Texture Graph Node Reference

---
title: "Texture Graph Node Reference"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/texture-graph-node-reference-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "纹理", "Getting started with Texture Graph", "Texture Graph Node Reference"]
---

# Texture Graph Node Reference

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 纹理 / Getting started with Texture Graph / Texture Graph Node Reference

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/texture-graph-node-reference-in-unreal-engine

## 调整节点

### BrightnessContrast

该 **BrightnessContrast** 节点会在 Texture Graph Editor 中调整纹理的亮度和对比度。Brightness 影响整体明度，提高会让纹理变亮，降低会让纹理变暗。Contrast 控制明暗区域之间的差异，值越高，视觉动态越强。

![Brightness Contrast](../../../../../assets/images/92/9213893efb3d34ca9229c5793f182bc5e282573cf2d68934584edbc56263433e.png)

### ConvertToGrayscale

该 **ConvertToGrayScale** 节点会将颜色值转换为指定范围内从黑到白（0-1）的灰度值。

![ConvertToGrayscale](../../../../../assets/images/17/170b9a2f90f3b12ee2a63ac0445e9edf77387b30b89603da9256c936e734cb8a.png)

### HSV

该 **HSV** 节点会基于 HSV 颜色模型的三个分量调整颜色：色相、饱和度和值。该节点适用于为各种视觉效果微调纹理，或实现特定颜色变化。

![HSV](../../../../../assets/images/90/90b58df4c58fa8bd8d2bb6f26d8fac9bb11e65d493f8833e34ee024a83681aa3.png)

### HSVtoRGB

该 **HSVtoRGB** 节点会将输入解释为 HSV，并将其转换为 RGB（红、绿、蓝）。

![HSV to RGB](../../../../../assets/images/03/0335c8aff5c1b38384879e155b299e89c03b69d22f026e434b8609fd086b3fea.png)

### Levels

该 **Levels** 节点会根据 Levels 节点中的 Low、Medium 和 High 三个参数，重新映射输入的阴影和高光。

任何大于等于 high 的值（在 levels 节点的 Details 标签页中调整）都会映射为白色。中间范围内的任何值会以 gamma 作为指数应用。任何小于等于 low 的值都会映射为黑色。

**Auto levels** 应基于传入图像中的最小值、最大值和中点自动归一化。勾选 Auto Levels 后，应禁用手动滑块。

![Levels](../../../../../assets/images/1b/1bfd77622dfacb78ed1b66713be72484740a40623ae00ada34a4ec3141510d80.png)

### NormalFromHeightMap（由高度生成法线）

**NormalFromHeightmap（由高度生成法线）** 节点会将给定输入高度图或纹理转换为对应的法线贴图。此功能让用户可以基于提供的高度图轻松生成法线贴图。

以下是用于调整 Normal 的选项：

- **Offset:** 为边界创建偏移，看起来会扩展并模糊边界。
- **Strength:** 调整贴图深度。

![NormalFromHeightMap](../../../../../assets/images/2a/2a88f5a4b40bc912bf9cad6a3f6079937eda2d19a8f3065cde2bf91f951b0817.jpg)

### RGBtoHSV

该 **RGBtoHSV** 节点会将输入解释为 RGB，并将其转换为 HSV。

![RGBtoHSV](../../../../../assets/images/f9/f966a7992946fbcff0d5d7db553471b07f2a26db7031b2757557170026cdca7a.png)

### Threshold

该 **Threshold** 节点会对输入图像应用阈值滤镜。如果像素亮度大于等于阈值，输出为白色；否则输出为黑色。

![Threshold](../../../../../assets/images/cc/cc0350a153ee454d68f4b08114cb4d134e546f2a0b0699f225fbf06e21133dfb.png)

## 通道

### CombineChannels

该 **CombineChannels** 节点会将不同输入中的红、绿、蓝和 alpha 通道合并为单个 RGBA 格式输出。通过将纹理或颜色值连接到节点的 R、G、B 和 A 引脚，可将分离通道统一起来。

> 图片已省略：CombineChannels

### SplitChannels

该 **SplitChannels** 节点用于从输入中隔离并分离红、绿、蓝和 alpha 通道，为每个通道提供四个独立输出。

> 图片已省略：SplitChannels

## 滤镜

### Blur

该 **Blur** 节点可对输入数据应用模糊效果，并提供 Gaussian blur、directional blur 和 radial blur 选项。将 Blur 节点加入 texture graph 并选择所需模糊类型后，用户可以按设计需求定制并增强模糊效果。

> 图片已省略：Blur

## 输入

### Color

该 **Color** 节点作为输入节点使用，便于指定 0-255 范围内的颜色值。

该节点提供一个用于选择颜色的字段。颜色值可以直接从 Details 面板配置，也可以在节点本身选择颜色字段进行配置。

> 图片已省略：Color

### Scalar

该 **Scalar** 节点作为定义浮点值的输入节点使用。浮点值是可包含小数部分的十进制数，可为纹理操作提供较高精度。

> 图片已省略：Scalar

### Settings

该 **Settings** 节点允许用户配置输出设置。在不想为多个输出节点分别调整设置时，可以使用 Settings 节点。将其连接到多个输出节点后，用户可以用相同设置导出多个输出，从而简化流程。

(w:700)

### Texture

其主要功能是 **Texture** 节点用于选择现有纹理，并从中派生新的独特纹理。通过这种方式，可以探索各种变换和调整，以获得期望的视觉结果。

> 图片已省略：Texture

### Vector

该 **Vector** 节点允许用户定义 XYZ 向量，并会自动公开为图表输入参数。该节点接受 X、Y 和 Z 坐标的输入值。

> 图片已省略：Vector

## 数学

可以使用 **数学** 节点执行多种操作，并根据输入返回数值或基于图像的操作。例如，可以使用 **Add** 节点控制圆形与矩形尺寸之间的关系。此外，还可以使用 Add 节点将图像组合为遮罩。

> 图片已省略：Math

| 数学节点 | 说明 |
| --- | --- |
| **Abs** | 确定浮点数输入的绝对值。 |
| **Add** | 对数值或图像输入执行加法。它允许用户组合并修改值，是创建纹理的基础构建块。 |
| **Blend** | 使用多种方法混合前景值和背景值。也可以选择使用遮罩控制混合操作。通过组合不同视觉元素，该节点在创建复杂细腻的纹理时尤其有用。不同于其它数学节点，Blend 节点提供混合类型和混合操作不透明度选项。 Opacity（不透明度） BlendMode（混合模式） Copy（复制） Add Subtract（相减） Multiply（相乘） Divide（相除） Difference（差值） Max Min Step Overlay（叠加） |
| **Cbrt** （立方根） | 计算给定输入的立方根。 |
| **Ceil** | 将给定数字向上舍入到大于等于原值的最近整数。 |
| **Clamp** | 接收单个输入，并确保它位于定义的最小值与最大值范围内。如果输入值低于最小值，则设为最小值；如果超过最大值，则限制为最大值。 |
| **Cross** | 计算输入值的叉积。 |
| **Cube** | 计算给定输入的立方。 |
| **Divide（相除）** | 对输入执行除法运算。Divide 节点的主要用途是将两个输入相除，并根据除法结果生成输出。 |
| **Dot** | 计算两个向量输入的点积。 |
| **Exp** (Exponential) | 接收单个数值输入并计算其指数值，通常表示为“e”的输入次幂。 |
| **Floor** | 将给定实数向下舍入到小于等于原值的最近整数。 |
| **IfThenElse** | 基于所选运算符和比较类型比较输入 A 与输入 B，并根据结果选择 then 输入或 if 输入。 |
| **Invert** | Invert 节点用于反转任何值或输入。 |
| **Lerp** | 接收三个输入：起始值、结束值和插值因子。它会根据插值因子计算起始值与结束值之间的线性插值。 |
| **Log** | Log 节点接收单个数值输入，并计算其对数，通常以指定底数为基准。 |
| **Log10** | 接收单个数值输入并计算以 10 为底的对数。处理相对于 10 的幂呈指数增长或衰减的值时，此操作特别有用。 |
| **Log2** | 接收单个数值输入并计算以 2 为底的对数。处理相对于 2 的幂呈指数增长或衰减的值时，此操作特别有用。 |
| **Max** | 比较两个输入并输出最大值。 |
| **Min** | 比较两个输入并输出最小值。 |
| **Multiply（相乘）** | 对输入执行乘法。该节点接收两个输入，并生成输入乘积作为输出。 |
| **MultiplyAdd** | 接收三个输入：两个要相乘的值（A 和 B），以及第三个要相加的值（Addend）。 |
| **Pow** | 计算给定底数的指定指数次幂。 |
| **Round** | 接收单个数值输入，并将其舍入到最近整数。当需要将数值转换为整数时，此操作很有用。 |
| **SmoothStep** | 当 x 位于 [min, max] 范围内时，返回 0 到 1 之间的平滑 Hermite 插值。如果输入小于最小输入，则返回 0；如果输入大于最大输入，则返回 1。 |
| **Sqrt** | 计算给定输入的平方根。 |
| **Square** | 计算给定输入的平方。 |
| **Subtract（相减）** | 对数值输入执行减法。 |
| **三角函数** | 对输入值执行多种三角函数。Trigonometry 节点支持若干基础三角函数，包括正弦、余弦、正切、反正弦、反余弦和反正切。 |

## 输出

该 **输出** 节点作为 texture graph 的终点。随着不同节点被添加并连接到输出，最终结果会在视口中可见。

要查看最终结果，请将各种节点连接到 texture graph 的 Output 节点。已连接节点会共同影响整体纹理。

## 程序化

### Noise

一个 **Noise** 遮罩在 Texture Graph Editor 中通常是指使用噪声函数创建可应用到纹理的遮罩。

噪声遮罩的目的是向纹理引入随机性或不规则性，从而增加细节和复杂度。

### 图案

一个 **图案** 节点会使用预定义图案来影响 Texture Graph Editor 中纹理的外观。

该节点提供以下 Pattern 类型：Square、Circle、Checker 和 Gradient。每种类型都有自己的设置。

### 形状

该 **形状** 节点是 Texture Graph Editor 中的基础几何体生成节点。这个多用途节点可用于创建多种几何形状，包括圆形、线段、矩形、三角形、椭圆、五边形、六边形和多边形。

### Transform

该 **Transform** 节点是 Texture Graph Editor 中用于对输入应用变换的强大工具，例如对输入进行平移、旋转和重复。

## 实用工具

### MaterialID

该 **MaterialID** 节点可从给定纹理输入中提取颜色，并通过选择特定颜色创建遮罩。

### TextureGraph

该 **TextureGraph** 节点可用于在一个 texture graph 内添加另一个 texture graph。这样可以使用另一个 texture graph 创建不同图表。

