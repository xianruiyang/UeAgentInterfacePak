---
title: "使用水波资产模拟波浪"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/simulating-waves-using-the-water-waves-asset-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "水体系统", "使用水波资产模拟波浪"]
---

# 使用水波资产模拟波浪

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 水体系统 / 使用水波资产模拟波浪

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/simulating-waves-using-the-water-waves-asset-in-unreal-engine

水系统会使用GPU驱动的波浪数据在水体Actor上模拟波浪表面。**水波（Water Waves）** 资产提供了由其模拟模型管控的各种波浪参数。

## 创建水波资产

水体随附了波浪模拟模型，可以和 **水波资产（Water Waves Asset）** 指定插槽配合使用。默认情况下会提供一个，使用的是[盖斯特纳波模拟模型](#%E7%9B%96%E6%96%AF%E7%89%B9%E7%BA%B3%E6%B0%B4%E6%B3%A2%E5%B1%9E%E6%80%A7)。

虽然不是每次使用水体时都需要创建新的水波资产，但有时你可能希望模拟模型有不同类型的波浪输入来产生不同的表现，或者你可能希望使用完全不同的波浪模拟模型。

你可以前往内容浏览器，点击 **添加/导入（Add/Import）** 或使用 **右键点击上下文菜单（Right-Click Context Menu）**，从而创建自己的水波资产。在菜单中，选择 **水（Water） > 水波（Water Waves）**。

在选择的 **水体（Water Body）** 上，使用 **水波资产（Water Waves Asset）** 指定要应用此资产的插槽。

![Content Browser Context Menu](../../../../assets/images/61/61cfdedcc59f41d45efc7ad88634eb5b212849894d5369f86436f2c022a8f1d4.jpg)

点击查看大图。

![Water Body](../../../../assets/images/a3/a3e8b643a9f685238b72ad55ece0b659feeacb16e10105230866b4bb2c1a338d.jpg)

点击查看大图。

![Water Wave Asset](../../../../assets/images/01/01bb45037980e0b535ae5b8342a6d6697f9bc85e75ea08814bb5d7aa2da80bd3.jpg)

点击查看大图。

## 编辑水波资产

在创建水波资产或打开现有的水波资产时，如果有多个模拟模型可供选择，则需要选择要使用的波浪模拟类型。所有可编辑的属性会填充到面板中，对模拟进行配置。

![Water Wave Asset Editor](../../../../assets/images/02/02a7b779848dfa487a7e0e329dc232de853ae509f18c6a12acbc48f7c07232d3.jpg)

点击查看大图。

使用盖斯特纳波模拟模型的水波资产编辑器。

**波浪来源（Waves Source）** 会指定要用于在水体上生成波浪的波浪模拟模型。选择一个来源之后，该来源就会提供要通过所选 **波浪来源（Waves Source）** 文件公开的参数，以控制波浪模拟。例如，**盖斯特纳波（Gerstner Water Waves）** 来源会在 **盖斯特纳波生成器（Gerstner Wave Generator）** 下提供参数。

凡是在关卡中分配了此水波资产的水体，你都可以通过配置这些参数来定义这些水体上波浪模拟的外观。

> [!NOTE]
> 虚幻引擎仅提供盖斯特纳波模拟模型。但是，你可以实施其他模型，也可以使用蓝图或C++代码自制模型，将其用作函数，令其根据某些指定的输入来输出波浪。如需详细信息，请参阅本页面中的[添加你自己的波浪模拟模型和波浪生成器](#%E6%B7%BB%E5%8A%A0%E4%BD%A0%E8%87%AA%E5%B7%B1%E7%9A%84%E6%B3%A2%E6%B5%AA%E6%A8%A1%E6%8B%9F%E6%A8%A1%E5%9E%8B%E5%92%8C%E6%B3%A2%E6%B5%AA%E7%94%9F%E6%88%90%E5%99%A8)小节。

## 盖斯特纳水波属性

**盖斯特纳水波（Gerstner Water Waves）** 模拟模型提供了以下可以用于模拟波浪的参数。

![Water Wave Asset Settings](../../../../assets/images/cb/cb7427fd67bd5fd9b2f8036ffb3b0db13f948c65f6b831b0ddbbe77ddfd1fd0f.png)

点击查看大图。

| 属性 | 说明 |
| --- | --- |
| 默认 |  |
| **波浪数量（Num Waves）** | 要统计的波浪数量。 |
| **种子（Seed）** | 一个决定性的起点，用于生成随机数值来填充波浪模型。 |
| **随机性（Randomness）** | 在盖斯特纳水波模型所使用的最小和最大波长和振幅数值之间的插值中添加一定程度的随机性。 |
| 波长 |  |
| **最小波长（Min Wavelength）** | 在具有指定衰减的波浪之间指定波长范围的下限。 |
| **最大波长（Max Wavelength）** | 在具有指定衰减的波浪之间指定波长范围的上限。 |
| **波长衰减（Wavelength Falloff）** | 使用最小和最大波长来确定连续波浪的波峰距离。 |
| 振幅 |  |
| **最小振幅（Min Amplitude）** | 为所有生成的具有指定衰减的波浪的振幅指定下限。 |
| **最大振幅（Max Amplitude）** | 为所有生成的具有指定衰减的波浪的振幅指定上限。 |
| **振幅衰减（Amplitude Falloff）** | 使用最小和最大振幅来确定所生成波浪的高度。 |
| 方向 |  |
| **主导风向角（Dominant Wind Angle）** | 设定风的主要方向。 |
| **主导角展度（Dominant Angular Spread）** | 在风应该吹来的指定角度范围内设置随机风向。波浪将表现为沿着此方向扩展。 |
| 陡度 |  |
| **小型波浪陡度（Small Wave Steepness）** | 指定具有指定衰减的较小波浪的陡度。陡度决定了波峰点可以形成什么样的尖锐度。这是通过横向运动来实现的，控制着波浪如何从一边移动到另一边。 |
| **大型波浪陡度（Large Wave Steepness）** | 指定具有指定衰减的较大波浪的陡度。陡度决定了波峰点可以形成什么样的尖锐度。这是通过横向运动来实现的，控制着波浪如何从一边移动到另一边。 |
| **陡度衰减（Steepness Falloff）** | 使用小型波浪陡度和大型波浪陡度数值来确定波峰可以出现在其中的高度范围。 |

> [!TIP]
> 水系统的表面细节网格体渲染系统非常适合用于定义波浪的宏观运动模式和外观。但是，微观细节最好使用具有常规贴图的水材质进行处理，贴图中的网格体曲面由于需要在质量和性能方面取得平衡而受到相应限制。

> [!NOTE]
> 接下来的演示中禁用了由材质驱动的细节，展示了可以单独使用水波资产实现的宏观级细节。

### 设置波浪数量和随机性

**默认（Default）** 类别的参数定义湖泊和海洋水体的总体外观。

**波浪数量（Num Waves）** 参数指定波浪的数量。此参数决定了所形成的波浪的总体外观。默认情况下使用16个波浪。波浪越少，性能越高，但在波浪碰撞时，随机变化将会减少。

**种子（Seed）** 参数将为随机数值创建决定性的起点，此参数将会传递到波浪模拟算法来创造波浪的变体。**随机性（Randomness）** 参数会将随机数值馈送到最小和最大波长和振幅数值，以减少波浪模拟中的重复模式。

### 波浪模拟的波长

在使用衰减数值时，**波长（Wavelength）** 参数将指定波浪间隔距离范围的最小和最大数值。在种子和随机性数值与波长范围的最小和最大数值的共同作用下，水面的外观得到了进一步定义。

### 波浪模拟的振幅

**振幅（Amplitude）** 参数将指定各个波浪之间高度变化范围的最小和最大数值。此参数控制波峰的最高点和最低点。在种子和随机性数值与振幅范围的最小和最大数值的共同作用下，水面的外观得到了进一步定义。

### 风的方向和角展度

**方向（Directions）** 参数将指定风所吹往的方向。对于 **主导风向角（Dominant Wind Angle）**，风会在风的大致方向上推动波浪形成。**主导角展度（Dominant Angular Spread）** 指定波浪在沿着"主导风向角"设定的方向扩展时，还需要遵循的辅助方向。

### 波浪模拟的陡度

**陡度（Steepness）** 参数将定义所激起的波浪可以达到怎样的尖锐或圆润程度。波峰的陡度是通过横向运动来实现的，控制着波浪如何从一边移动到另一边。

较小的陡度数据具有较为柔和圆润的波峰。较大的陡度数据具有较为尖锐的波峰。这些数值可以提供随机的波浪交互，形成的波峰既有较为柔和的，也有较为尖锐的，而不是让所有波峰通通变得柔和，或通通变得尖锐。

## 添加你自己的波浪模拟模型和波浪生成器

虚幻引擎为水系统提供了盖斯特纳波模拟模型。水系统具有可配置的参数的水波浪资产，所以支持更多的波浪模拟模型，你可以通过C++代码或蓝图来实现。

此部分中的信息使用了盖斯特纳波实施，用以举例说明如何创建你自己的波浪生成器后端，从而对水面波浪进行求值。

在C++中，你可以首先创建一个从 `UGerstnerWaterWaveGeneratorBase` 推导出的新类型，然后使用 `GenerateGerstnerWaves_Implementation(TArray<FGerstnerWave>&OutWaves) const`。

在蓝图中，父类继承自 **GerstnerWaterWaveGeneratorBase** 类。

![Blueprint Class Button](../../../../assets/images/e9/e9ccbd5b02662fab29b3bf8393173fb47587817a2a6359f7edd17c84edabda84.jpg)

点击查看大图。

![Gerstner Wave Asset Class](../../../../assets/images/ea/eafa88e43659eeac06c59e2c4c6892f367e0f98c318f0d4498f83ce2f840a6e6.png)

点击查看大图。

![Gerstner Water Wave Generator Base](../../../../assets/images/2a/2a3eebd30c1b83cd03d4f6435c1974a46d163260de6c3cb7ce278b5768c3c4a4.jpg)

点击查看大图。

在蓝图中，你需要重载并添加你自己的盖斯特纳波函数，此函数使用 **Make GerstnerWave** 和 **Make GerstnerWaveOctave** 节点，从而输出到存储了信息的数组中。

> 图片已省略：Gerstner Generator Wave Function

点击查看大图。

> 图片已省略：BP Custom Wave Simulation

点击查看大图。

在水波资产中，**盖斯特纳波生成器（Gerstner Wave Generator）** 选项下拉菜单会列出从"盖斯特纳波来源"继承的所有类。

> 图片已省略：BP Custom Gerstner Wave Generator

点击查看大图。
