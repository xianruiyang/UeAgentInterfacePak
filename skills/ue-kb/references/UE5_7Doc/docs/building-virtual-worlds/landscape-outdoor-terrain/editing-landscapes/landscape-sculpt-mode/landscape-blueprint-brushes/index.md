---
title: "地形蓝图笔刷"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/landscape-blueprint-brushes-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "地形户外地貌", "编辑地形", "雕刻模式", "地形蓝图笔刷"]
---

# 地形蓝图笔刷

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 地形户外地貌 / 编辑地形 / 雕刻模式 / 地形蓝图笔刷

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/landscape-blueprint-brushes-in-unreal-engine

地形蓝图笔刷提供了用户定义的造型笔刷堆栈，其支持非破坏性操纵。因此，堆栈中的低层笔刷若发生变化，变化也将自动流入堆栈上方的笔刷。这些笔刷可用于将多个地貌操纵彼此叠加，同时让各个操纵相互分离，必要时用户可以围绕地貌重新排列或在移动地貌。

> [!NOTE]
> 要使用地形蓝图笔刷，必须在插件浏览器中启用Landmass插件，并在创建地形时选中 **启用编辑图层（Enable Edit Layers）** 。
>
> **在插件浏览器中启用Landmass插件的方法：**
>
> 1. 从主菜单打开插件浏览器。
> 2. 搜索 *Landmass* 并点击 **启用（Enable）** 。
>
> **在创建地形时启用编辑图层的方法：**
>
> - 在 **新地形（New Landscape）** 分段中勾选 **启用编辑图层（Enable Edit Layers）** 属性。

## 将地形蓝图笔刷添加到编辑图层

**将新地形蓝图笔刷添加到现有编辑图层的方法：**

1. 在关卡编辑器工具栏中选择地形模式后，选择"造型（Sculpt）"选项卡，并从可用造型工具选择 **蓝图（Blueprint）** 。
2. 点击 **蓝图笔刷（Blueprint Brush）** 下拉菜单，选择一种可用的笔刷类型。
3. 在视口中，点击地形以添加新笔刷。

## 内置地形蓝图笔刷类型

### CustomBrush_Landmass笔刷

CustomBursh_Landmass笔刷从用户定义的样条线形状和可配置效果集合（例如侵蚀、旋度噪点和置换）生成地块形状，并将生成的形状应用于地貌

#### 混合模式

混合模式将确定形状如何添加到或剪切到地貌中，类似于CSG或布尔运算。 有四种混合模式可用：

| 混合模式 | 说明 |
| --- | --- |
| Alpha混合 | 同时生成地块形状的常规和反转版本，并将反转形状应用于位于底层地貌下面的部分，从而升高和降低地貌。 [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/e24c0adc-d8fc-492c-8494-472cc932d9d4/blend_alpha.png) |
| 最小值 | 生成地块形状的反转版本，并仅应用位于底层地貌下面的部分，从而降低地貌。 [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/60543aa4-f07e-4955-9718-d5264620c4cd/blend_min.png) |
| 最大值 | 仅应用地块形状中位于底层地貌上方的部分，从而升高地貌。 [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/f17d74fb-f593-412f-b205-d18eda12a119/blend_max.png) |
| 叠加 | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/2002c4ea-8497-440b-b25d-49b6396819fe/blend_additive.png) |

#### 形状限制

Landmass笔刷生成的形状可以限顶或不限顶。如果形状限顶，则效果类似于平顶高原。如不限顶，则形状类似于有尖顶的山峰或山丘。

|  |  |
| --- | --- |
| 启用形状限顶 | Cap Shape disabled |
| 启用形状限顶 | 禁用形状限顶 |

#### 衰减

衰减将决定从笔刷形状到底层地貌的过渡斜面。

| 属性 | 说明 |
| --- | --- |
| 角度 | [见下文](#%E8%A7%92%E5%BA%A6) |
| 宽度 | [见下文](#%E5%AE%BD%E5%BA%A6) |

##### 角度

衰减斜面由指定角度决定。衰减角度越大，斜面越陡峭。对不限顶的形状而言，形状内部也会持续衰减，从而形成山峰的形状

|  |  |  |
| --- | --- | --- |
|  |  |  |
| 30度 | 45度 | 60度 |

###### 宽度

指定距离（虚幻单位）可决定衰减斜面。衰减距离越短，斜面越陡峭。

|  |  |  |
| --- | --- | --- |
|  |  |  |
| 100个单位 | 200个单位 | 400个单位 |

#### 噪点

噪点能将最多两个倍频的旋度噪点应用于生成的地块形状。

| 属性 | 说明 |
| --- | --- |
| 旋度[1/2]强度 | [见下文](#%E6%97%8B%E5%BA%A6%E5%BC%BA%E5%BA%A6) |
| 旋度[1/2]平铺 | [见下文](#%E6%97%8B%E5%BA%A6%E5%B9%B3%E9%93%BA)) |

##### 旋度强度

设置应用于地块形状的噪点振幅。

|  |  |  |
| --- | --- | --- |
|  |  |  |
| 强度0 | 强度1 | 强度2 |

##### 旋度平铺

设置应用于地块形状的噪点频率。

|  |  |  |
| --- | --- | --- |
|  |  |  |
| 平铺0 | 平铺5 | 平铺15 |

### CustomBrush_LandmassRiver笔刷

CustomBrush_LandmassRiver笔刷将沿用户定义的样条线挤压静态网格体，并升高或降低地貌以匹配挤压的网格体。此笔刷很适合为道路或河流布局，使地貌自动调整以匹配。

### CustomBrush_MaterialOnly笔刷

CustomBrush_MaterialOnly笔刷将使用材质将流程性噪点应用于整个地貌，以形成基础。
