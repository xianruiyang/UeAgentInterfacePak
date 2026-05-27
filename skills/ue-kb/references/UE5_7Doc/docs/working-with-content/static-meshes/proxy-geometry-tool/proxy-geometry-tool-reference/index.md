---
title: "代理几何体工具参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/proxy-geometry-tool-reference-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "静态网格体", "代理几何工具", "代理几何体工具参考"]
---

# 代理几何体工具参考

> 路径：虚幻引擎5.7文档 / 管理内容 / 静态网格体 / 代理几何工具 / 代理几何体工具参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/proxy-geometry-tool-reference-in-unreal-engine

## 参考

![Proxy_Geo_RF_01.png](../../../../../assets/images/4c/4c230704d5ae39edcdbb6d75972c5571923725d7c720138bb442112393fe262f.jpg)

在下表中，您将找到代理几何体工具中的每个设置的属性描述：

| **属性名称** | **说明** |
| --- | --- |
| **屏幕大小（Screen Size）** | 生成的代理网格体的屏幕大小（以像素为单位）。 |
| **覆盖空间采样距离（Override Spatial Sampling Distance）** | 当从代理LOD合并转换网格体时覆盖。警告，大几何体与小采样会产生非常高的内存开销。 |
| **材质设置（Material Settings）** | 材质简化设置。 |
| **计算正确的LOD模型（Calculate Correct LOD Model）** | 确定在给定源网格体和平移大小的情况下，是否应该计算正确的LOD模型。 |
| **合并距离（Merge Distance）** | 网格体应该合并在一起时的距离，这可以闭合遥远几何体内像门窗这样的间隙。 |
| **未解析的几何体颜色（Unresolved Geometry Color）** | 指定给不能与源几何体关联的LOD几何体的基础颜色。例如，按合并距离（Merge Distance）关闭的门窗。 |
| **传输距离覆盖（Transfer Distance Override）** | 覆盖在发现简化几何体的纹理值时使用的搜索距离。当非零合并距离设置在凹角生成新的几何体时非常有用。 |
| **硬边角度（Hard Edge Angle）** | 在面与面之间引入硬边的角度。注意：增加顶点数，并可能引入额外的UV缝隙。只推荐在不使用法线贴图的情况下使用。 |
| **法线计算方法（Normal Calculation Method）** | 控制用于计算简化几何体法线的方法。 |
| **光照图分辨率（Light Map Resolution）** | 光照图分辨率大小。 |
| **计算光照图分辨率（Compute Light Map Resolution）** | 如果勾选此项，将通过对合并所包含的每个网格体的尺寸求和来计算光照图的分辨率。 |
| **启用体积剔除（Enable Volume Culling）** | 允许剔除体积，以排除几何体。 |
| **允许邻接（Allow Adjacency）** | 是否允许邻接缓冲区在合并网格体中进行曲面细分。 |
| **允许距离场（Allow Distance Field）** | 是否允许计算该网格体的距离场。如果网格体只在远处渲染，则禁用此选项以节省内存。 |
| **重用网格体光照图UV（Reuse Mesh Lightmap UVs）** | 是否在烘焙材质时尝试重新使用源网格体的光照图UV或总是产生一个新集合。 |
| **允许顶点颜色（Allow Vertex Colors）** | 是否允许在合并网格体中保存顶点颜色。 |
| **生成光照图UV（Generate Lightmap UVs）** | 是否为合并网格体生成光照图UV。 |

在下表中，您将找到可以与代理几何体工具一起使用的各控制台命令的说明：

| **命令名称** | **说明** |
| --- | --- |
| **r.ProxyLODChartColorVerts** | 按UV图表的颜色顶点。默认为关闭。 0: 禁用。 1: 启用。 |
| **r.ProxyLODCorrectCollapsedWalls** | ProxyLOD系统应尝试纠正具有互穿面的墙壁 0: 禁用 - 默认。 1: 启用，可能会导致裂缝。 |
| **r.ProxyLODMaterialInParallel** | 网格体简化的同时并行地做材质工作。 0: 禁用。 1: 启用 - 默认。 |
| **r.ProxyLODMaxDilationSteps** | 出于性能原因，限制在填充间隙时使用的膨胀步骤的数量。这可能会影响间隙填充质量，因为膨胀步长越大，配合使用的最大值越小。 0: 将禁用间隙填充。 1: 默认 - 默认。 |
| **r.ProxyLODMeshReductionModule** | 要选择的代理LOD简化模块的名称。如果为空，则选择任何存在的模块。 |
| **r.ProxyLODRemeshOnly** | 仅重建网格体。无简化或材质。 0: 禁用 - 将简化并生成材质 - 默认。 1: 启用 - 将不会简化或生成材质。 |
| **r.ProxyLODSingleThreadSimplify** | 使用单线程代码路径。 0: 多线程。- 默认。 1: 单线程。 |
| **r.ProxyLODTransfer** | 0：两路发射。 1：偏好前向 - 默认。 |
| **r.ProxyLODUseTangentSpace** | 控制在每个顶点生成Mikk-T空间的选项。默认为开启。禁用此选项后，将向每个顶点添加(1,0,0)(0,0,1)(0,1,0)的切线空间来对法线贴图进行编码。 0：各个顶点的世界空间。 1：各个顶点的切线控件 - 默认。 |
