---
title: "自定义材质表达式"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/custom-material-expressions-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "材质", "材质表达式参考", "自定义材质表达式"]
---

# 自定义材质表达式

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 材质 / 材质表达式参考 / 自定义材质表达式

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/custom-material-expressions-in-unreal-engine

利用 **自定义** 材质表达式，你可以编写拥有任意数量输入参数的自定义HLSL着色器代码，并输出结果。

你可以从材质控制板中的 **自定义（Custom）** 类别中插入自定义表达式，或在材质图表中点击右键，通过搜索菜单中添加自定义表达式。

![插入自定义表达式](../../../../../assets/images/78/7872361ee14cfee7390a028495a75968274782c2a72c5cd7145b83f909c60a91.jpg)

选择自定义节点时，**细节（Details）** 面板中会显示以下属性。

![自定义表达式细节面板属性](../../../../../assets/images/d8/d86169e3d52c30aa478c8e75329827215a3764f9d7cf9afc6328f56e677621c0.png)

| 属性 | 说明 |
| --- | --- |
| **代码（Code）** | 包含表达式将执行的着色器代码。（请参阅下文中的 [警告](#warnings)） |
| **输出类型（Output Type）** | 指定表达式所输出的值的类型。 |
| **说明（Description）** | 指定要在材质编辑器中的表达式栏中显示的文本。 |
| **输入（Inputs）** | 表达式所使用的输入数组。 |
| **输入名称（Input Name）** | 指定输入的名称。这是材质编辑器中显示在此表达式上的名称，并且是 HLSL 代码中用来引用输入值的名称。 |
| **其他输出（Additional Outputs）** | 允许你定义要在自定义表达式上显示的其他输出引脚。 添加输出时，你必须展开数组元素并指定其 **输出名称（Output Name）** 和 **输出类型（Output Type）** 属性。 |
| **其他定义（Additional Defines）** | 允许你添加你的自定义HLSL代码所需的其他定义。 向数组添加元素时，你必须指定 **定义名称（Define Name）** 和 **定义值（Define Value）** 。 |
| **包含文件路径（Include File Paths）** | 从虚幻引擎已经提供的常用着色器路径之外的源文件中指定你想包含的着色器代码的文件路径。 |

## 使用自定义材质表达式

根据需要，在 **输入（Inputs）** 数组中添加输入，并对其命名。然后在 **代码（Code）** 属性字段中输入或粘贴你的HLSL代码。你可以使用示例中所示的return语句输入完整的函数正文，也可以输入 **Input.bgr** 之类的简单表达式。你还必须在OutputType中指定输出数据类型。

下述示例是一个自定义表达式，它可以基于标量参数中的值，对纹理对象进行模糊处理。

![undefined](../../../../../assets/images/19/196580102a2c60e7fdd6da74f9d8ad1ef8f5ea5b799996ff35e2d527c8bc1e8c.jpg)

点击查看大图。

下面是以上所用的代码，供你参考，用于自行尝试自定义节点。将以下文本复制并粘贴到"细节（Details）"面板属性中的 **代码（Code）** 字段。

```
    float3 blur = Texture2DSample(Tex, TexSampler, UV);     for (int i = 0; i < r; i++)    {       blur += Texture2DSample(Tex, TexSampler, UV + float2(i * dist, 0));      blur += Texture2DSample(Tex, TexSampler, UV - float2(i * dist, 0));     }     for (int j = 0; j < r; j++)    {        blur += Texture2DSample(Tex, TexSampler, UV + float2(0, j * dist));      blur += Texture2DSample(Tex, TexSampler, UV - float2(0, j * dist));     }     blur /= 2*(2*r)+1;    return blur;
```

以下视频显示了使用HLSL代码创建自定义表达式的过程和结果。

## 已知问题

以下小节详述了在编写自定义材质表达式时应注意的一些常见陷阱。

### 输入参数限于函数本地

请注意，自定义表达式总是有返回值，因为它们封装在其他函数中。所有输入参数（例如以上示例中的Tex、UV、r和dist）都声明为该外层函数的参数，因此其可视性范围限于函数本地。

有时，开发人员会编写带有成员函数的结构，并预期可在该结构内部访问这些参数，但他们无法访问函数本地的参数。因此，在自定义表达式内部使用成员函数时，你必须手动复制这些参数。

下面的示例将无法编译（假定仍沿用上述示例的情形）。

```
	struct InnerStruct	{	  float4 Run()	  {		// 错误：Tex、TexSampler和UV在InnerStruct中不可访问		return Texture2DSample(Tex, TexSampler, UV);	  }	};	InnerStruct S;	return S.Run();
```

### 使用HLSLcc编译器时的语法错误

一些使用旧版HLSLcc编译器的着色器后端在向量和矩阵等HLSL类型上会报告语法错误。尽量采用明确的数据类型，分别使用 **float4** 或 **float4x4**。我们会持续修复这些漏洞，但与此同时，我们的主要精力会放在新的DirectXShaderCompiler（DXC）上。

### 警告

> [!WARNING]
> - 使用自定义节点会阻止常量折叠，并且，与使用内置节点实现的等效版本相比，可能会大幅增加所使用的指令！
>
>   常量折叠是虚幻引擎内部利用的一项优化功能，旨在必要时减少着色器指令数。例如，
>
>   Sin（正弦）> 乘以（Mul）参数 > 加入（Add）某内容
>
>   表达式链可以并且将会由虚幻引擎折叠为单一指令，即最终的相加。可以做到这一点的原因是，该表达式的所有输入（参数）在整个绘制调用中保持不变，而不是随像素而变化。虚幻引擎无法折叠自定义节点中的任何内容，与使用现有节点实现的等效版本相比，这可能会生成效率欠佳的着色器。因此，最好是仅当自定义节点允许您访问无法通过现有节点访问的功能时，才使用自定义节点。
> - 写入自定义节点的着色器代码必须为有效的HLSL。
