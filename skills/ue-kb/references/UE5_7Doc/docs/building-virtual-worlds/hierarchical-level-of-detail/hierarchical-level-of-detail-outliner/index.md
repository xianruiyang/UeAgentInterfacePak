---
title: "分层细节级别大纲视图"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/hierarchical-level-of-detail-outliner-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "分层细节级别（HLOD）", "分层细节级别大纲视图"]
---

# 分层细节级别大纲视图

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 分层细节级别（HLOD） / 分层细节级别大纲视图

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/hierarchical-level-of-detail-outliner-in-unreal-engine

**分层细节级别（LOD）大纲视图** 中有几个选项可用于定义您的HLOD网格体的设置方法。一旦启用HLOD系统，您就可以从 **关卡编辑器（Level Editor）** 下的Window菜单选项访问HLOD大纲视图。

![Window menu](../../../../assets/images/3b/3b42c6f59e0e113b2df8f6138ba9bc1f05415ebca7809839da174cdb1998caec.jpg)

点击查看大图。

![HLOD Outliner Window option](../../../../assets/images/fa/fa61d919fe0b8faf53a667dfc7a94a9a70039a52957c20014b00b5a504560ae3.png)

点击查看大图。

本页面详述 **HLOD大纲视图** 的可用属性，更多信息请参阅各个部分。

![HLOD Outliner Breakdown](../../../../assets/images/ce/ce9f5db19a95a0ae83a9a3a831638c33c9735bdd24068f000a52ab9d00d9c8e5.png)

点击查看大图。

1. **HLOD操作（HLOD Actions）**：为关卡中的每个群集生成HLOD代理网格体，为关卡中生成的每个群集重新生成群集并编译代理网格体，保存所有外部HLOD数据，或者在LOD查看选项之间切换。
2. **HLOD场景Actor（HLOD Scene Actors）** ：包含已生成的每个群集（或代理网格体）以及有关各个Actor的信息。您还可从该面板中 **生成（Generate）** 或 **删除群集（Delete Clusters）**，也可右键单击场景Actor以执行快捷操作。
3. **LOD系统（LODSystem）**：定义要包括的 **HLOD关卡** 数量以及每个HLOD关卡的 **群集（Cluster）** 和 **网格体生成设置**。您也可覆盖用于代理材质的材质，或覆盖 **HLOD设置资产**。

## 属性和界面参考

![HLOD Outliner](../../../../assets/images/81/813fd0b7f8237f30d53052e93f06602774acafbc9422653300e1ce82c7ed8a92.png)

点击查看大图。

## HLOD操作

在 **HLOD大纲视图** 顶部，可找到以下可用选项：

![HLOD Outliner Actions](../../../../assets/images/c2/c2bd9004fadfe76cbb3c81a5556754e1f71c2f91fcd2c20cd988651404cee794.png)

点击查看大图。

|  |  |
| --- | --- |
| **生成代理网格体（Generate Proxy Meshes）** | 在创建要生成代理网格体的 **已生成群集** 之后，就可以使用这个选项了。当您生成代理网格体时，这将使用群集化的LOD并将这些 **Actor** 合并到单个资产中。您可以定义如何使用 **群集生成设置（Cluster Generation Settings）** 群集化代理网格体，以及最终如何使用 **网格体生成设置（Mesh Generation Settings）** 生成代理网格体。该选项仅影响生成的网格体，而非整个关卡。 请注意，这个过程可能会花费很长时间，具体取决于场景的复杂程度以及为HLOD关卡选择的设置。 |
| **全部（重新）编译（Build (Rebuild) All）** | 使用该选项，只需一个步骤即可从这些群集编译群集和代理网格体。通常您需要生成群集，并确保在生成代理网格体之前您对所需的结果很满意（该选项将自动编译代理网格体）。一旦生成了群集，就可以使用 **全部重新编译（Rebuild All）** 选项重新生成群集并从这些群集编译代理网格体。 与 **生成代理网格体（Generate Proxy Meshes）** 不同，这个选项会修改关卡，并且根据场景的复杂性和设置可能会花费大量的时间。 |
| **全部保存（Save All）** | 该选项允许您保存所有外部HLOD数据，包括网格体、材质和纹理。 |
| **LOD视图（LOD View）** | 可使用该选项选择要在编辑器中查看的LOD关卡，或在编辑器中指定一个 **强制查看关卡**。这有助于调试您可能遇到的任何LOD问题。 |

## HLOD场景Actor

可使用 **HLOD场景Actor（HLOD Scene Actors）** 面板为关卡中的网格体 **生成群集（Generate Clusters）**（但不是代理网格体）或 **删除群集（Delete Clusters）**（这将删除关卡中的所有群集）。该面板还显示给定LOD关卡的所有LODActor以及有关Actor的信息，例如初始的三角形数、LOD网格体中减少的三角形数量、LOD网格体保留的三角形减少百分比，以及LOD网格体所处的关卡。

![HLOD Outliner Scene Actor](../../../../assets/images/86/862d6439cb08b8c4c6d50f8b6ec3926f58a5f67de59e90476a41046338ecdac9.png)

点击查看大图。

右键单击面板中的LOD Actor或静态网格体Actor可以访问其他操作：

### LOD Actor快捷菜单

右键单击 **场景Actor名称（Scene Actor Name）** 列下列示的任何LOD Actor，显示以下菜单和选项。

![HLOD Outliner LODActor Menu](../../../../assets/images/4f/4f343f3b22bf334b002784a7b83f24b5a21736aaf7441be0e1df16bf6ae2ea35.png)

点击查看大图。

| 选项 | 说明 |
| --- | --- |
| **选择LOD Actor（Select LOD Actor）** | 在视口中选择LOD Actor（与左键单击群集产生的效果相同）。 |
| **选择包含的Actor（Select Contained Actors）** | 选择LOD群集中包含的所有Actor。 |
| **强制视图（Forceview）** | 在视口中切换HLOD Actor的LOD视图。 该选项可用于已编译到代理网格体中的LODActor。 |
| **重新编译代理网格体（Rebuild Proxy Mesh）** | 强制被右键单击的群集重新编译其代理网格体。 |
| **创建包含分层体积（Create Containing Hierarchical Volume）** | 围绕群集中包含的Actor创建分层体积，然后可以修改该体积以包含更多或更少的Actor。 |
| **删除群集（Delete Cluster）** | 删除被右键单击的群集。 |

### Actor快捷菜单

展开LODActor会公开已生成HLOD群集中包含的场景Actor。右键单击场景Actor，出现以下选项：

![HLOD Outliner SM Context](../../../../assets/images/54/54ad470755f340409046fd3840e7595c6d70604a5b41f558dfbb3dc659595fb9.png)

点击查看大图。

| 选项 | 说明 |
| --- | --- |
| **从群集中删除（Remove From Cluster）** | 从群集中删除被右键单击的Actor。 |
| **从群集生成中排除（Exclude From Cluster Generation）** | 从群集生成中排除被右键单击的Actor。如果想要重新添加被排除的Actor，单击它并将其从 **世界大纲视图** 拖动到 **HLOD大纲视图** 中的群集中。 |

## 属性

下面是 **HLOD大纲视图（Hierarchical LOD Outliner）** 界面底部的 **LOD系统（LODSystem）** 面板上 **HLOD设置（Hierarchical LODSetup）** 中的属性细分（按主要部分划分）。

### 群集生成设置

可使用 **群集生成（Cluster Generation）** 设置控制HLOD群集的生成方式，以通过设置群集的期望边界，群集填充程度，以及生成群集必须用到的最小Actor数量来包括关卡中的Actor。

> 图片已省略：HLOD Outliner Cluster Settings

点击查看大图。

| 属性 | 说明 |
| --- | --- |
| **允许特定排除（Allow Specific Exclusion）** | 该属性与网格体组件上的属性结合使用，您可以添加一个HLOD关卡索引，该索引不应该包含该网格体。这样，您就可以仅包含HLOD关卡0的小道具，对于后续HLOD则忽略这些小道具（因为您将无法从特定距离查看它们）。 |
| **所需边界半径（Desired Bound Radius）** | 将网格体聚集在一起的半径。通常（不是必然）用于计算自动群集化的填充因子。 |
| **所需填充百分比（Desired Filling Percentage）** | 在生成群集时，该属性可以确定群集边界（球体）中被所包含的Actor的边界占据的程度。本质上指的是必须由包含的Actor所占的群集体积的百分比。 |
| **要编译的最小Actor数量（Min Number of Actors to Build）** | 构建LODActor的最小Actor数量。 |
| **仅生成体积的群集（Only Generate Clusters for Volumes）** | 如果启用，将仅为HLOD体积内的网格体生成群集。 |

### 网格体生成设置

可使用 **网格体生成（Mesh Generation）** 设置控制合并HLOD群集Actor时将使用的特定属性，比如生成光照图，组合材质，平移大小等。

> 图片已省略：HLOD Outliner Mesh Generation

点击查看大图。

| 属性 | 说明 |
| --- | --- |
| **平移屏幕大小（Transition Screen Size）** | 这将根据群集的大小计算显示群集的距离。它根据固定的视野(FOV)/16:9比率，计算群集在什么距离占据用户定义的屏幕大小。如果您想要强制所有群集在预定义的距离切换，可以使用 **覆盖绘制距离（Override draw distance）** 来实现。 |
| **覆盖绘制距离（Override Draw Distance）** | 强制所有群集在指定的预定义距离切换。 |
| **简化网格体（Simplify Mesh）** | 启用后，网格体结果将被简化。如果禁用，它将只合并Actor，但不会使用更低的LOD（如有（进行简化。例如，如果你构建了LOD 1，它会使用网格体的LOD 1（如有）来合并Actor。如果你合并材质，它会减少绘制调用。 |
| 合并设置 |  |
| **生成光照贴图UV（Generate Light Map UV）** | 启用后，将为合并的网格体生成光照贴图UV，并将光照贴图坐标索引赋值为1。 |
| **目标光照贴图分辨率（Target Light Map Resolution）** | 要用于HLOD Actor的光照贴图分辨率。 |
| **计算出的光照贴图分辨率（Computed Light Map Resolution）** | 是否应该通过对输入网格体组件的光照贴图分辨率求和来计算光照贴图分辨率。 |
| **轴心点位置（Pivot Point at Zero）** | 将合并网格体的轴心定位在世界场景原点（坐标0,0,0），或生成HLOD群集时列出的第一个Actor的位置。 |
| **合并物理数据（Merge Physics Data）** | 启用后，将为组合Actor合并碰撞基元。 |
| **合并材质（Merge Materials）** | 启用后，系统将烘焙分配给所有内含网格体的材质，并将它们组合成一个的材质。该操作可以降低合并网格体的绘制调用复杂性，但只在合并网格体而不是生成代理网格体时使用。简化网格体时，请始终烘焙材质并将其应用于代理网格体。 |
| **材质设置（Material Settings）** | 详见[材质设置](#%E6%9D%90%E8%B4%A8%E8%AE%BE%E7%BD%AE)表格。 |
| **边距大小（Gutter Size）** | 以烘焙材质的原始纹理分辨率设置UV岛之间的空间（以像素为单位）。该空间有助于防止各岛屿之间的颜色重叠。否则，当渲染中发生纹理的下采样时，网格体上可能出现瑕疵。缩小的纹理大小被称为mipmap。 |
| **烘焙顶点数据至网格体（Bake Vertex Data to Mesh）** | 启用后，顶点数据（例如顶点颜色）将被烘焙到生成的代理网格体中。 |
| **输出UV（Output UVs）** | 启用后，任何已绘制到选定网格体上的顶点颜色都将整合到生成的HLOD Actor和创建的材质中。 |
| **LOD选择类型（LODSelection Type）** | 用于定义确定LOD关卡的方式。 |
| **特定LOD（Specific LOD）** | 要从源网格体导出的给定LOD关卡。 |
| **使用顶点数据烘焙材质（Use Vertex Data for Baking Material）** | 启用后，会在烘焙材质时使用顶点数据。 |
| **使用纹理装箱（Use Texture Binning）** | 这将在打包最终的图谱纹理时，根据重要性计算不同的输出纹理大小。 |
| **重用网格体光照贴图UV（Reuse Mesh Lightmap UVs）** | 在烘焙材质时尝试重用源网格体的光照贴图UV，还是始终生成一组新的光照贴图UV。 |
| **合并等效材质（Merge Equivalent Materials）** | 每次生成合并网格体或代理网格体时，我们需确定要烘焙哪些材质。无论何时，一旦设置此值，我们还将合并任何材质实例。假设您为放置的任何道具生成了动态材质实例。它们本质上是相同的材质，但其属性可能是特定于实例的。这意味着当您合并它们时，将只对所有网格体使用一个实例，这意味着HLOD网格体的最终外观可能与原始外观不同。 如果使用世界场景位置/actor位置来确定输出颜色，则会导致合并网格体中出现瑕疵。 |
| **使用地形剔除（Use Landscape Culling）** | 启用后，可使用地形几何体剔除（或删除）不可见网格体的任何三角形部分。 |
| **允许距离场（Allow Distance Field）** | 是否允许为该网格体计算距离场。 如果合并后的网格体仅在远处渲染，禁用该选项以节省内存。 |

#### 材质设置

可使用此处的设置控制在生成HLOD Actor时如何打包和组合材质。

| 属性 | 说明 |
| --- | --- |
| **纹理大小（Texture Size）** | 生成的BaseColor纹理贴图的大小。 |
| **纹理大小类型（Texture Sizing Type）** | 为所有材质属性使用指定的 **纹理大小（Texture Size）** 参数，使用基于 **纹理大小（Texture Size）** 的自动偏置纹理大小，还是逐个属性使用手动覆盖的纹理大小。 |
| **法线贴图（Normal Map）** | 是否生成法线贴图。 |
| **金属感贴图（Metallic Map）** | 是否生成金属感贴图。 |
| **金属感常量（Metallic Constant）** | 能够设置金属感常量值，取代纹理贴图。 |
| **粗糙感贴图（Roughness Map）** | 是否生成粗糙感贴图。 |
| **粗糙感常量（Roughness Constant）** | 能够设置粗糙感常量值，取代纹理贴图。 |
| **高光度贴图（Specular Map）** | 是否生成高光度贴图。 |
| **高光度常量（Specular Constant）** | 能够设置高光度常量值，取代纹理贴图。 |
| **自发光贴图（Emissive Map）** | 是否生成自发光贴图。 |
| **不透明度贴图（Opacity Map）** | 如果启用，将为生成的合并Actor烘焙不透明度贴图。这将使不透明度常量属性无效。 必须同时使用 **半透明（Translucent）** **混合模式（Blend Mode）** ，以便在生成的实例中显示正确。 |
| **不透明度常量（Opacity Constant）** | 只有在禁用不透明度贴图时才启用，这将为合并后的Actor材质的不透明度属性设置一个常量值。 |
| **不透明度蒙版贴图（Opacity Mask Map）** | 如果启用，将为生成的合并Actor烘焙不透明度蒙版贴图。这将使不透明度蒙版常量属性无效。 必须同时使用 **遮罩（Masked）** **混合模式（Blend Mode）** ，以便在生成的实例中显示正确。 |
| **不透明度蒙版常量（Opacity Mask Constant）** | 只有在禁用不透明度蒙版贴图时才启用，这将为合并后的Actor材质的不透明度蒙版属性设置一个常量值。 |
| **环境遮挡贴图（Ambient Occlusion Map）** | 是否生成环境遮挡贴图。 |
| **环境遮挡常量（Ambient Occlusion Constant）** | 能够设置环境遮挡常量值，取代纹理贴图。 |
| **混合模式（Blend Mode）** | 能够为代理材质定义[混合模式](../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/unreal-engine-material-properties/material-blend-modes/index.md)。 |
