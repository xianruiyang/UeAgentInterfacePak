---
title: "材质函数表达式"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/material-function-expressions-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "材质", "材质表达式参考", "材质函数表达式"]
---

# 材质函数表达式

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 材质 / 材质表达式参考 / 材质函数表达式

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/material-function-expressions-in-unreal-engine

## FunctionInput

**FunctionInput（函数输入）**表达式只能放在材质函数中，用于在该函数中定义该函数的某个输入。

| 项目 | 说明 |
| --- | --- |
| 属性 |  |
| **输入名称（Input Name）** | 输入的名称，此名称将显示在使用了包含该输入的材质函数的 MaterialFunctionCall（材质函数调用）表达式中。 |
| **说明（Description）** | 这是对输入的说明，当用户将鼠标指针悬停在 MaterialFunctionCall（材质函数调用）表达式中此输入的连接器上方时，此说明将显示为"工具提示"。 |
| **输入类型（Input Type）** | 此输入所需的数据类型。传递到此输入的数据将强制转换为此类型，如果因为数据不兼容而导致强制转换失败，那么将抛出编译器错误。 |
| **预览值（Preview Value）** | 这是编辑包含此输入的材质函数时，要用作此输入的预览的值。 |
| **使用预览值作为默认值（Use Preview Value As Default）** | 如果启用此项目，并且未传入任何数据，那么将使用 **预览值** 作为此输入的默认值。 |
| **排序优先顺序（Sort Priority）** | 指定确定 MaterialFunctionCall（材质函数调用）表达式中显示各个输入的顺序时，对于此输入要使用的优先顺序。 |

此节点与[材质函数](../../material-functions/index.md)配合使用。

## FunctionOutput

**FunctionOutput（函数输出）**表达式只能放在材质函数中，用于在该函数中定义该函数的某个输出。

| 项目 | 说明 |
| --- | --- |
| 属性 |  |
| **输出名称（Output Name）** | 输出的名称，此名称将显示在使用了包含该输出的材质函数的 MaterialFunctionCall（材质函数调用）表达式中。 |
| **说明（Description）** | 这是对输出的说明，当用户将鼠标指针悬停在 MaterialFunctionCall（材质函数调用）表达式中此输出的连接器上方时，此说明将显示为"工具提示"。 |
| **排序优先顺序（Sort Priority）** | 指定确定 MaterialFunctionCall（材质函数调用）表达式中显示各个输出的顺序时，对于此输出要使用的优先顺序。 |

此节点与[材质函数](../../material-functions/index.md)配合使用。

## MaterialFunctionCall

**MaterialFunctionCall（材质函数调用）**表达式允许您使用来自另一材质或函数的外部 [材质函数](../../material-functions/index.md)。这个外部函数的输入及输出节点将变成函数调用节点的输入和输出。如果放置其中某个表达式时在 **内容浏览器** 中选中了某个材质函数，那么将自动指派该函数。

**快捷键：***F + 鼠标左键单击*

| 项目 | 说明 |
| --- | --- |
| 属性 |  |
| **材质函数（Material Function）** | 指定要使用的 [材质函数](../../material-functions/index.md)。 |

此节点与[材质函数](../../material-functions/index.md)配合使用。

## StaticBool

**StaticBool（静态布尔值）**表达式用来为函数内的静态布尔函数输入提供默认布尔值。此节点不会在任何内容之间切换，因此必须与 StaticSwitch（静态开关）节点配合使用。

| 项目 | 说明 |
| --- | --- |
| 属性 |  |
| **值（Value）** | 布尔值 *True*（选中）或 *False*。 |

此节点与[材质函数](../../material-functions/index.md)配合使用。

## StaticSwitch

**StaticSwitch（静态开关）**表达式的工作方式与 StaticSwitchParameter（静态开关参数）类似，但是它仅实现开关，而不会创建参数。

| 项目 | 说明 |
| --- | --- |
| 属性 |  |
| **默认值（Default Value）** | 参数的默认布尔值（用于确定哪个输入处于活动状态），即 *True*（选中）或 *False*。 |
| 输入 |  |
| **True** | 当开关的 **值（Value）**为 *True* 时使用的输入。 |
| **False** | 当开关的 **值（Value）**为 *False* 时使用的输入。 |
| **值（Value）** | 接收一个布尔值，用于确定哪个输入处于活动状态。 |

此节点与[材质函数](../../material-functions/index.md)配合使用。

## TextureObject

**TextureObject**（纹理对象）表达式用来为函数内的纹理函数输入提供默认纹理。此节点不会对该纹理进行实际取样，因此必须与"纹理取样"（TextureSample）节点配合使用。

| 项目 | 说明 |
| --- | --- |
| 属性 |  |
| **纹理（Texture）** | **内容浏览器** 中要应用于此节点的纹理。 |
| **取样类型（Sampler Type）** | 此节点所要输出的数据类型。 |
