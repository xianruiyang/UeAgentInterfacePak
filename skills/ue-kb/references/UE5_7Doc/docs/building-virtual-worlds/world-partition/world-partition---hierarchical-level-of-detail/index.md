---
title: "世界分区 - 分层细节级别"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/world-partition---hierarchical-level-of-detail-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "世界分区", "世界分区 - 分层细节级别"]
---

# 世界分区 - 分层细节级别

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 世界分区 / 世界分区 - 分层细节级别

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/world-partition---hierarchical-level-of-detail-in-unreal-engine

世界分区系统利用网格将你的场景分隔成可在运行期间动态加载和卸载的单元。但有时候，你会希望一些相隔较远且无法互动的Actor仍然可见，比如远方的山脉、树木和悬崖。

| HLOD关闭 | HLODs 打开 |
| --- | --- |
| *HLOD关闭。仅显示加载的单元中的内容。* | _HLOD打开。未加载的单元中的内容会替换为HLOD。 |

**世界分区 - 分层细节级别（HLOD）** 系统使用自定义HLOD层组织大量静态网格体Actor，生成单个代理网格体和材质。此技术用于使未加载的世界分区网格单元可视化，以减少每帧的绘图调用次数，提高性能，尤其是在使用大型开放世界的情况下。

## 创建HLOD层

世界分区HLOD由HLOD层资产控制。这些专用资产包含你的设置，同时你的项目可使用多个HLOD层：

![image alt text](../../../../assets/images/f7/f77153024ed8494fdad35f0cc52c6e18ef973da268e1d4fe2aae106443f4faea.jpg)

新建HLOD层资产的步骤如下：

1. 打开 **内容侧滑菜单（Content Drawer）** ，点击 **+ 添加（+ Add）** 打开菜单。找到 **杂项（Miscellaneous）** 菜单，然后选择 **HLOD层（HLOD Layer）** 资产。（右键单击 **内容侧滑菜单（Content Drawer）** ，打开同一个菜单。）
2. 双击新HLOD层，打开资产编辑器窗口。

![image alt text](../../../../assets/images/19/19dce505a49bce53fc99276228abf26af2d85c8e2d703cc217bbd89f63748f8f.png)

| 设置 | 说明 |
| --- | --- |
| **层类型（Layer Type）** | 从以下选项中选择层类型： 实例化 合并的网格体 简化的网格体（Simplified Mesh） |
| **网格体合并设置/代理设置（Mesh Merge Settings/Proxy Settings）** | 在选择 **合并的网格体（Merged Mesh）** 或 **简化的网格体（Simplified Mesh）** 层类型后显示其他选项。 |
| **始终加载（Always Loaded）** | 确定是否始终加载该层生成的HLOD代理网格体。 |
| **单元大小（Cell Size）** | 设置运行时网格的单元格大小，以在此层中包含HLOD Actor。如果将HLOD层设置为 **始终加载（Always Loaded）** ，此选项不可用。 |
| **加载范围（Loading Range）** | 设置运行时网格流送其单元的距离。如果将HLOD层设置为 **始终加载（Always Loaded）** ，此选项不可用。 |
| **父层（Parent Layer）** | 允许此HLOD层创建的资产被自动分配给特定HLOD层。 |
| **HLOD材质（HLODMaterial）** | 设置在为合并的网格体（Merged Mesh）和简化的网格体（Simplified Mesh）层类型烘焙材质时可使用的基本材质。 这是一个高级设置。默认材质对大多数用例来说已经足够了。 |

### 选择层类型

使用HLOD层的第一步是选择层类型：

![image alt text](../../../../assets/images/25/2575861d6cc55fa2ce35e850d349c31d2ddee90de9adb5118863ea65a26a20a4.png)

| 层类型 | 说明 |
| --- | --- |
| **实例化（Instancing）** | 为那些资产使用最低细节级别 (LOD) 设置将此类层中的静态网格体资产替换为实例化静态网格体 (ISM) 组件。此类型是理想的替代物网格体，如树木和枝叶。 |
| **合并的网格体（Merged Mesh）** | 此层类型中的静态网格体将合并，以生成单个代理网格体。 |
| **简化的网格体（Simplified Mesh）** | 此层类型中的静态网格体将合并，以生成单个代理网格体，然后执行网格体简化。 |

### 网格体合并设置

这些设置仅在已选定合并的网格体（Merged Mesh）时可用：

![image alt text](../../../../assets/images/39/39a4406ea4a73aeb253b349436d4155d276804f1d068c6b5bb9b5426265f931d.png)

| 设置 | 说明 |
| --- | --- |
| **生成光照贴图UV（Generate Lightmap UV）** | 针对合并的网格体生成光照贴图UV。此新布局将被置于目标光照贴图UV信道中。 |
| **目标光照贴图分辨率（Target Lightmap Resolution）** | 指定用于在已生成静态网格体上生成光照贴图UV坐标的光照贴图分辨率。此操作可控制UV岛状区之间的距离。分辨率越高，每个UV岛状区之间的空间越加紧密。 |
| **计算出的光照贴图分辨率（Computed Lightmap Resolution）** | 确定是否应该通过对输入网格体组件的光照贴图分辨率求和来计算光照贴图分辨率。 |
| **零位枢轴点（Pivot Point at Zero）** | 确定合并的网格体的枢轴点位置是在世界原点，还是在首个合并的组件上。 |
| **合并物理数据（Merge Physics Data）** | 确定是否合并网格体组件的物理数据，尤其是碰撞图元。 |
| **合并材质（Merge Materials）** | 将源材质合并到单个平坦材质中。此操作仅在合并单个LOD层时可用，由你的 **LOD选择类型（LODSelection Type）** 决定。 |
| **材质设置（Material Settings）** | 包含在启用 **合并材质（Merge Materials）** 时生成的简化材质的材质设置。 |
| **边距大小（Gutter Size）** | 以烘焙材质的原始纹理分辨率设置UV岛之间的空间（以像素为单位）。该空间有助于防止各岛屿之间的颜色重叠。否则，当渲染中发生纹理的下采样时，网格体上可能出现瑕疵。缩小的纹理大小被称为mipmap。 |
| **创建合并的材质（Create Merged Materials）** | 从所有源组件材质中创建一个平坦材质以及一组新的UV坐标。默认情况下，此材质不应用于任何分段。 |
| **烘焙顶点数据至网格体（Bake Vertex Data to Mesh）** | 将顶点数据（如顶点颜色和法线）烘焙成产生的代理网格体。 |
| **输出UV（Output UVs）** | 将指定的UV信道输出到合并的网格体中。源网格体组件必须包含指定信道的有效UV。 |
| **LOD选择类型（LODSelection Type）** | 确定在生成合并的静态网格体时使用哪个LOD选项模式： **使用所有LOD层（Use all LOD levels）** ：在合并Actor时使用所有可用LOD层。 **使用指定LOD层（Use specific LOD level）** ：在合并Actor时使用所有选定的LOD层。 **计算正确的LOD层（Calculate correct LOD level）** ：针对给定界面大小计算合适的LOD模型。 **始终使用最低细节LOD（Always use lowest detail LOD）** ：在合并Actor时使用最低细节LOD。 |
| **特定LOD（Specific LOD）** | 指定要从源网格体导出的LOD关卡。 |
| **使用顶点数据烘焙材质（Use Vertex Data for Baking Material）** | 将顶点数据（如顶点颜色和法线）烘焙成为烘焙材质。仅在选定 **合并材质（Merge Materials）** 时可用。 |
| **使用纹理装箱（Use Texture Binning）** | 根据在最终图谱纹理的重要性计算不同的输出纹理大小。仅在选定 **合并材质（Merge Materials）** 时可用。 |
| **复用网格体光照贴图UV（Reuse Mesh Lightmap UVs）** | 确定是否在烘焙材质时复用源网格体中的光照贴图UV。如果为false，引擎将生成一组新的UV。 |
| **合并等效材质（Merge Equivalent Materials）** | 尝试合并视为等效的材质。如果使用世界场景位置或Actor位置来确定输出颜色，则此流程会导致合并的网格体出现瑕疵。 |
| **使用地形剔除** | 利用可用的地形几何体剔除不可见的三角形部分。例如，如果有一个树网格体被放在处于地形表面以下的最低三角形位置，则被遮挡的三角形部分会在合并时被移除。 |
| **包括替代物（Include Imposters）** | 包括任何属于源网格体组件的替代物LOD。 |
| **允许距离场（Allow Distance Fields）** | 允许计算此网格体的距离场。如果合并后的网格体仅在远处渲染，禁用该选项将节省内存。 |
| **生成启用了Nanite的网格体** | 在已生成的网格体上启用Nanite。 |

### 代理设置

这些设置仅在已选定简化的网格体（Simplified Mesh）时可用：

![image alt text](../../../../assets/images/bd/bdf4d0c8574b544e35c3b869afc0914263971c2db81230085f270d3ee15e0413.png)

| 设置 | 说明 |
| --- | --- |
| **界面大小（Screen Size）** | 确定生成代理网格体的大小，以像素为单位。 |
| **计算正确的LOD模型（Calculate Correct LODModel）** | 根据指定界面大小计算足以使用的LOD模型。通过分析每个输入网格体的数据，然后根据LOD过渡大小选择正确的LOD来完成计算。 |
| **覆盖空间采样距离（Override Spatial Sampling Distance）** | 在为LOD合并转换多个源网格体时覆盖。 带有小采样的大几何体，其内存成本极高。 |
| **材质设置（Material Settings）** | 包含材质简化设置。 |
| **合并距离（Merge Distance）** | 网格体应该以怎样的距离合并。该选项可以关闭远处几何体中的间隙（如门窗）。 |
| **未解析几何体颜色（Unresolved Geometry Color）** | 分配一个会在合并的几何体无法与源几何体相关联（如被合并距离封闭的门窗）时会显示的基础颜色。 |
| **传输距离覆盖（Transfer Distance Override）** | 覆盖在发现简化的几何体纹理数值时使用的搜索距离。当非零点合并距离设置在凹角点生成新的几何体时使用。 |
| **硬边角度阈值（Hard Edge Angle）** | 两面之间引入硬边的角度。此选项可增加顶点数，并可能引入其他UV接缝。推荐仅在未使用法线地图时使用。 |
| **法线计算方法（Normal Calculation Method）** | 控制简化的几何体的法线计算方法。 **角度加权（Angle Weighted）** ：使用周围面角度为法线加权。 **区域加权（Area Weighted）** ：使用周围面区域为法线加权。 **平均加权（Equal Weighted）** : 使用周围面法线平均值为法线加权。 |
| **光照贴图分辨率（Lightmap Resolution）** | 设置新生成的光照贴图分辨率。 |
| **计算光照贴图分辨率（Compute Lightmap Resolution）** | 通过运算合并过程中每个网格体的有效维度之和，计算出光照贴图分辨率。 |
| **启用体积剔除（Enable Volume Culling）** | 允许剔除体积，以排除几何体。 |
| **允许距离场（Allow Distance Fields）** | 允许计算此网格体的距离场。如果合并后的网格体仅在远处渲染，禁用该选项将节省内存。 |
| **复用网格体光照贴图UV（Reuse Mesh Lightmap UVs）** | 确定是否在烘焙材质时复用源网格体中的光照贴图UV。如果为false，引擎将生成一组新的UV。 |
| **组合相同的网格体进行烘焙（Group Identical Meshes for Baking）** | 仅烘焙相同网格体或网格体实例一次。这将提高已烘焙纹理的品质，减少烘焙时间。这将导致合并的网格体和源网格体视觉效果之间出现差异。 |
| **生成碰撞（Create Collision）** | 针对合并的网格体生成碰撞。 |
| **允许顶点颜色（Allow Vertex Colors）** | 允许保存合并的网格全中的顶点颜色。 |
| **生成光照贴图UV（Generate Lightmap UVs）** | 针对合并的网格体生成光照贴图UV。 |
| **生成启用了Nanite的网格体** | 在已生成的网格体上启用Nanite。 |

## 使用HLOD层

如需生成HLOD代理网格体，需将Actor添加至HLOD层，然后将其 **移动性（Mobility）** 设置为 **静态（Static）**，并告知Actor生成HLOD。方法是使用 **构建（Build） > 构建HLOD（Build HLODs）** 或者使用 **WorldPartitionHLODsBuilder** commandlet。

### 添加Actor

目前，可采用以下方法为HLOD层添加Actor。

1. Actor的 **细节（Details）** 面板中的HLOD属性。

   ![image alt text](../../../../assets/images/a8/a844b72476d8fb6f43d529c06fb7b236178b39131b7a4fb1e9e2cabbef363389.jpg)
2. 数据层的默认HLOD层属性。

   ![image alt text](../../../../assets/images/b5/b5904599161e6b91bdf1f4f5d169c5a02520f2530128b3607ddcf22b79943ee8.png)
3. 世界设置的默认HLOD层属性。

   ![image alt text](../../../../assets/images/c4/c41cd18701a25c1ce67ebf5f20543da728fcc1fe4685881828aa9da5545daa91.png)

> [!NOTE]
> 使用WorldPartitionConvertCommandlet时同样有多个HLOD层选项可用。可使用转换ini文件指定HLOD层属性：
>
> ```
> 	[/Script/UnrealEd.WorldPartitionConvertCommandlet]	EditorHashClass=Class'/Script/Engine.WorldPartitionEditorSpatialHash'	RuntimeHashClass=Class'/Script/Engine.WorldPartitionRuntimeSpatialHash'	HLODLayerAssetsPath="/Game/WorldPartition/HLODLayers"	DefaultHLODLayerName="HLODLayer_Default"	HLODLayersForActorClasses=(ActorClass=/Game/Blueprint/Base_Tree.Base_Tree_C,HLODLayer="HLODLayer_Tree") 	[HLODLayer_Default HLODLayer]	LayerType=MeshMerge	MeshMergeSettings=(TargetLightMapResolution=256,OutputUVs[0]=OutputChannel, ...)	HLODMaterial=/Engine/EngineMaterials/BaseFlattenMaterial.BaseFlattenMaterial	RuntimeGrid="HLODGrid_Default"	LoadingRange=30000.000000 	[HLODLayer_Tree HLODLayer]	LayerType=Instancing	RuntimeGrid="HLODGrid_Trees"	LoadingRange=30000.000000
> ```

使用此配置转换的世界将指定一个 **DefaultHLODLayerName** （在本例中，名称为 **HLODLayer_Default** )。此名称将使用匹配的.ini分段中指定的属性生成。由 **HLODLayer_Default** 生成的Actor将分配到带有.ini文件对应分段定义属性的 **HLODLayer_Tree** 。

### 使用Commandlet生成HLOD

可使用 **WorldPartitionHLODsBuilder** Commandlet生成HLOD。运行此Commandlet将根据在HLOD层中指定的生成设置为世界分区单元生成HLOD Actor。

> [!NOTE]
> 如果未对源 Actor进行任何更改，则不会重新生成或建立HLOD Actor。如果重新执行该Commandlet，对多个Actor本身或其网格体、材质或纹理进行更改将导致HLOD被重建。

> 图片已省略：HLOD Commandlet Format

请按照下面的步骤使用此Commandlet：

1. 在Windows中，打开"命令提示符"窗口。

   > 图片已省略：image alt text
2. 在提示符中，首先导航到UnrealEditor.exe文件的位置。例如：`C:\Program Files\Epic Games\UE_5.3\Engine\Binaries\Win64`。
3. 然后，在命令开头提供将要运行该Commandlet的.exe文件名称，即 **UnrealEditor.exe** 。
4. 添加以下参数：

   ` YourProject YourMap -run=WorldPartitionBuilderCommandlet -AllowCommandletRendering -Builder=WorldPartitionHLODsBuilder`

   其中， **YourProject** 是项目文件夹名， **YourMap** 是你想要在其中建立HLOD的贴图文件名。
5. 此外，以下任一选项可用于更改此命令的行为：

| 选项 | 说明 |
| --- | --- |
| -SetupHLODs | 为世界分区设置HLOD Actor，但不建立对应的几何体。可能会更新、删除或创建新的Actor。 |
| -BuildHLODs | 为所有现存HLOD Actor构建几何体。 |
| -DeleteHLODs | 删除所有HLOD Actor。 |

## 可视化HLOD

若能在运行时看到HLOD单元的状态，就能在编辑器视口中看到HLOD Actor。

### 在编辑器中

在视口中，将视图模式更改为 **细节级别着色（Level of Detail Coloration）**，并选择 **层级LOD着色（Hierarchical LOD Coloration）** 后，分配给HLOD层的Actor将呈现为绿色：

> 图片已省略：image alt text

将摄像机从Actor处移开后，将以蓝色显示其HLOD代理网格体：

> 图片已省略：image alt text

### 在运行时

在运行时，运行控制台命令 `wp.Runtime.ToggleDrawRuntimeHash2D`，以绿色显示加载的HLOD单元。

> 图片已省略：image alt text
