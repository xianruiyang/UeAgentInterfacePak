---
title: "Niagara"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/niagara-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "插件设置", "Niagara"]
---

# Niagara

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 插件设置 / Niagara

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/niagara-settings-in-the-unreal-engine-project-settings

## Niagara

### Niagara

| **设置** | **说明** |
| --- | --- |
| **其他参数类型（Additional Parameter Types）** | 启用后，你可以将参数结构体保存到项目中。接着你可以在不同的Niagara脚本中复用该结构体。 通过 **内容浏览器（Content Browser）** 创建结构体资产：右键点击空白区域，然后选择 **蓝图（Blueprints）> 结构（Structure）** 。 |
| **其他负载类型（Additional Payload Types）** | 启用后，你可以将负载结构体保存到你的项目中。负载也是参数的结构体，但还能够在其上执行读写事件。 |
| **其他参数枚举（Additional Parameter Enums）** | 将枚举保存到你的项目中，以在不同的Niagara脚本中复用。 |
| **以堆栈显示可转换的输入（Show Convertible Inputs in Stack)** | 启用后，"链接输入（link input）"菜单还将显示不同类型的变量，只要它们有转换脚本即可。 |
| **系统支持大型世界坐标（Systems Support Large World Coordinates）** | 启用后，活动效果将对模拟位置重定基，以便不丢失精度。 如果你不需要该设置，将其禁用以跳过不必要的重定基计算。 |
| **在图表中强制执行严格类型检查（Enforce strict type checks in the graph）** | 启用后，位置和向量等类型必须先执行显式的转换步骤，才能分配到彼此。 如果禁用，类型检查会放松，一些类型可以彼此隐式转换。 处理大型世界坐标时，不要将其禁用。 |
| **默认效果类型（Default Effect Type）** | 要用于没有定义自己的效果类型的默认效果类型。 可以是 `null` 。 |
| **位置引脚类型颜色（Position Pin Type Color）** | 位置引脚类型颜色。 其他引脚颜色在通用编辑器设置中定义。 |

### 视口

| **设置** | **说明** |
| --- | --- |
| **环绕模式下的系统视口（System Viewport in Orbit Mode）** | 设置系统预览视口的默认寻路行为。 |

### 可扩展性

| **设置** | **说明** |
| --- | --- |
| **质量级别（Quality Levels）** | Niagara使用的质量级别。 |

### 渲染器

| **设置** | **说明** |
| --- | --- |
| **按类的组件渲染器警告（Component Renderer Warnings Per Class）** | 组件渲染器基于所选组件类显示的信息文本。 |
| **默认渲染目标格式（Default Render Target Format）** | 除非覆盖，由所有Niagara渲染目标数据接口使用的默认渲染目标格式。 你可以从以下选项中选择： **RTF R8** ：R通道，每个通道固定点8位，区间[0, 1]。 **RTF RG8** ：RG通道，每个通道固定点8位，区间[0, 1]。 **RTF RGBA8** ：RGBA通道，每个通道固定点8位，区间[0, 1]。 **RTF RGBA8 SRGB** ：RGBA通道，每个通道固定点8位，区间[0, 1]。RGB使用sRGB gamma曲线编码。Alpha总是存储为线性。 **RTF R16f** ：R通道，每个通道浮点16位，区间[-65504, 65504]。 **RTF RG16f** ：RG通道，每个通道浮点16位，区间[-65504, 65504]。 **RTF RGBA16f** ：RGBA通道，每个通道浮点16位，区间[-65504, 65504]。 **RTF R32f** ：R通道，每个通道浮点32位，区间[-3.402823 x 10^38, 3.402823 x 10^38]。 **RTF RG32f** ：RG通道，每个通道浮点32位，区间[-3.402823 x 10^38, 3.402823 x 10^38]。 **RTF RGBA32f** ：RGBA通道，每个通道浮点32位，区间[-3.402823 x 10^38, 3.402823 x 10^38]。 **RTF RGB10A2** ：RGBA通道，每个通道固定点10位，alpha 2位。 |
| **默认网格格式（Default Grid Format）** | 除非覆盖，由所有Niagara网格数据接口使用的默认缓冲区格式。 你可以从以下选项中选择： **浮点（Float）** ：每个通道浮点32位，区间[-3.402823 x 10^38, 3.402823 x 10^38] **半浮点（Half Float）** ：每个通道浮点16位，区间[-65504, 65504] **无符号规格化字节（Unsigned Normalized Byte）** ：每个通道固定点8位，区间[0, 1]。 |
| **默认渲染器运动向量设置（Default Renderer Motion Vector Setting）** | Niagara渲染器中运动向量的默认设置。 你可以从以下选项中选择： **精确（Precise）** ：运动向量会精确生成（非常适合动态模糊和时间抗锯齿）。需要相关发射器，以便每个粒子存储更多数据，并可能影响顶点处理性能。 **近似（Approximate）** ：根据当前速度近似表示运动向量。可节省内存和性能，但可能导致更低质量的动态模糊和/或抗锯齿。 |
| **默认像素覆盖模式（Default Pixel Coverage Mode）** | 在Niagara渲染器上设置自动时，像素覆盖模式的默认设置。 你可以从以下选项中选择： **启用（Enabled）** ：渲染器设为自动模式时，将启用像素覆盖。 **禁用（Disabled）** ：渲染器设为自动模式时，将禁用像素覆盖。 |

### 骨骼网格体数据接口（DI）

| **设置** | **说明** |
| --- | --- |
| **Gpu最大骨骼影响数量（Gpu Max Bone Influences）** | 控制骨骼网格体数据接口可以在GPU上使用的最大影响数量。 更改此设置需要重启编辑器。 你可以从以下选项中选择： **最多允许4个（Allow Max 4）** ：允许对最多4个骨骼取样。 **最多允许8个（Allow Max 8）** ：最多允许对8个骨骼取样。 **无限制（Unlimited）** ：允许对无限制数量的骨骼取样。 |
| **Gpu均匀取样格式（Gpu Uniform Sampling Format）** | 控制用于GPU上的均匀取样的格式。 更改此设置需要重启编辑器。 你可以从以下选项中选择： **完整（Full）** ：每个条目64位。允许完整int32范围的三角形（20亿）。 **有限的24.8（Limited 24.8）** ：每个条目32位。允许约1670万个三角形和8位的概率精度。 **有限的23.9（Limited 23.9）** ：每个条目32位。允许约840万个三角形和8位的概率精度。 |
| **相邻性三角形索引格式（Adjacency Triangle Index Format）** | 控制用于指定相邻性缓冲区中的三角形索引的格式。 更改此设置需要重启编辑器。 你可以从以下选项中选择： **完整（Full）** ：每个条目32位。允许完整int32范围的三角形（20亿）。 **一半（Half）** ：每个条目16位。允许一半（int16）范围的三角形（64000）。 |

### 静态网格体DI

| **设置** | **说明** |
| --- | --- |
| **允许距离场（试验性）（Allow Distance Fields (Experimental)）** | 启用后，允许静态网格体数据接口从GPU上的距离场数据（如果存在）取样。 无论使用什么功能，启用该功能会将包含静态网格体取样的所有系统移至 `PostRenderOpaque` 更新函数组中。 更改此设置需要重启编辑器。 |

### 异步GPU追踪DI

| **设置** | **说明** |
| --- | --- |
| **追踪提供程序优先级（试验性）（Trace Provider Priorities (Experimental)）** | 定义在使用 `AsyncGpuTrace` 数据接口时如何解译标记为项目默认值的追踪。 系统将遍历（从元素0开始）查找第一个可用的提供程序。 |
