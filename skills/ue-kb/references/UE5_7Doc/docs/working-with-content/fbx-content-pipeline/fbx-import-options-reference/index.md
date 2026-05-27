---
title: "FBX导入选项参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/fbx-import-options-reference-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "FBX内容管线", "FBX导入选项参考"]
---

# FBX导入选项参考

> 路径：虚幻引擎5.7文档 / 管理内容 / FBX内容管线 / FBX导入选项参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/fbx-import-options-reference-in-unreal-engine

虽然将FBX文件导入到虚幻引擎4是一个相对简单的过程，但是有相当多的选项可以调整导入的资产。本文档将介绍这些选项。

当你使用FBX管道通过 **内容浏览器** 导入内容时，将出现 **FBX导入选项（FBX Import Options）** 对话框。导入器将自动检测你要导入的文件类型，并相应地调整其接口。

## 静态网格体选项

使用FBX导入 *StaticMesh* 时可用的选项如下所示。

| 选项 | 说明 |
| --- | --- |
| 网格体 |  |
| **骨架网格体（Skeletal Mesh）** | 对于静态网格体：这将尝试将FBX文件作为骨架网格体导入。此导入选项会切换到将FBX文件作为骨架网格体导入的处理过程。 |
| **自动生成碰撞（Auto Generate Collision）** | 该选项将自动为静态网格体生成碰撞。如果在FBX文件中检测到自定义碰撞，则不使用该选项。 |
| **静态网格体LOD组（Static Mesh LODGroup）** | 该下拉菜单允许你选择将网格体分配到的LOD组。网格体LOD组定义默认的详细级别设置、光照贴图分辨率，并允许全局覆盖（例如，将所有 *SmallProp* LOD减少10%）。网格体LOD组设置可以逐个平台/设备概述文件覆盖。你可以在导入时选择LOD组，并在 **静态网格体编辑器（Static Mesh Editor）** 中随时更改。 |
| **顶点颜色导入选项（Vertex Color Import Option）** | 如果启用，则用FBX文件中的顶点颜色替换现有网格体上的顶点颜色。禁用该选项，以保存使用[网格体绘制](../../../building-virtual-worlds/level-editor/level-editor-modes/mesh-paint-mode/index.md)工具在编辑器中绘制的顶点颜色。 |
| **顶点覆盖颜色（Vertex Override Color）** | 在顶点颜色导入选项（Vertex Color Import Option）设置为覆盖（Override）的情况下，该选项将是覆盖颜色。 |
| **移除退化（Remove Degenerates）** | 如果启用，将移除导入过程中发现的退化三角形。禁用该选项将保留发现的退化三角形。通常，应该启用该选项。 |
| **构建邻接缓冲（Build Adjacency Buffer）** | 如果为 *true*，将优化网格体以进行PN曲面细分。对于较大的网格体，建议禁用此选项。 |
| **构建反向的索引缓冲（Build Reveresed Index Buffer）** | 该选项用于减少绘制调用之间的GPU状态更改数量。该选项是优化镜像变换中的网格体所必需的。它还会使索引缓冲区的大小翻倍。 |
| **生成光照贴图UV（Generate Lightmap UVs）** | 如果启用，导入器将生成一组独特的、不重叠的UV，用于静态照明。 |
| **每个UCX一个凸包（One Convex Hull per UCX）** | 该选项强制所有UCX网格体接收一个凸包。如果禁用，则引擎可以将UCX网格体分解为一系列凸包，以获得合适的形状。 |
| **Transform Vertex to Absolute** | 如果为 *true*，FBX文件将为世界场景原点使用变换、偏移和枢轴。如果为 *false*，FBX将在转换任何节点层级的情况下导入。 |
| **Bake Pivot in Vertex** | 如果为 *true*，枢轴旋转将应用于网格体。然后，FBX文件的枢轴将是网格体的原点。Transform Vertex to Absolute必须设置为 *false*。 |
| **导入网格体LOD（Import Mesh LODs）** | 从文件中定义的LOD为虚幻网格体创建LOD模型。否则，仅从LOD组导入基本网格体。对于骨架网格体，LOD模型可以蒙皮到相同或不同的骨架上。如果将LOD模型蒙皮到不同的骨架上，则必须满足虚幻的LOD需求，但根骨骼的名称可以不同，因为FBX导入器会自动重命名根骨骼。 |
| **法线导入方法（Normal Import Method）** | 该导入选项调整将如何处理法线。选项如下： **计算法线（Compute Normals）**：引擎计算法线和切线。平滑组和法线信息将从FBX信息中丢弃。 **导入法线（Import Normals）**：法线从FBX文件导入，切线由引擎计算。 **导入法线和切线（Import Normals and Tangents）**：法线和切线是从FBX文件导入的，引擎不计算任何东西。 |
| **法线生成方法（Normal Generation Method）** | 在MikkTSpace或内置的法线生成方法之间进行选择的选项。 |

## 骨架网格体选项

使用FBX导入 *SkeletalMesh* 时可用的选项如下所示。

| 选项 | 说明 |
| --- | --- |
| 网格体 |  |
| **骨架网格体（Skeletal Mesh）** | 对于骨架网格体，禁用该选项将使导入器尝试将FBX文件作为静态网格体导入。 |
| **导入网格体（Import Mesh）** | 是否导入网格体。该选项允许动画仅在导入骨架网格体时导入。 |
| **导入内容类型（Import Content Type）** | 导入的网格体内容类型。 |
| **骨架（Skeleton）** | 骨架网格体应定位的[骨架](../../../animating-characters-and-objects/skeletal-mesh-animation-system/index.md)。如果没有选择现有的骨架，将从导入的骨架网格体创建一个新的骨架。新骨架的名称将是附加 *Skeleton* 的骨架网格体。 |
| **顶点颜色导入选项（Vertex Color Import Options）** | 启用后，现有网格体上的顶点颜色将被替换为FBX文件的顶点颜色。禁用此项可保留在编辑器中使用[网格体绘制](../../../building-virtual-worlds/level-editor/level-editor-modes/mesh-paint-mode/index.md)工具绘制的顶点颜色。 |
| **顶点覆盖颜色（Vertex Override Color）** | 将顶点颜色导入选项（Vertex Color Import Options）设置为覆盖（Override）时，这就是覆盖用的颜色。 |
| **更新骨架参考姿势（Update Skeleton Reference Pose）** | 如果启用，该选项将把导入的骨架网格体/动画的骨架资产的参考姿势更新为导入的FBX文件中的参考姿势。 |
| **使用TOA参考姿势（Use T0As Ref Pose）** | 如果启用，动画轨迹的第一帧（帧0）将用于替换骨架网格体的参考姿势。 |
| **维持平滑组（Preserve Smoothing Group）** | 如果启用，具有不匹配平滑组的三角形将被物理分割，复制共享顶点。 |
| **在骨骼层级中导入网格体（Import Meshes in Bone Hierarchy）** | 如果启用，内嵌于骨骼层级中的网格体将被导入，而非转换为骨骼。 |
| **导入变形目标（Import Morph Targets）** | 如果启用，[变形目标](../fbx-morph-target-pipeline/index.md)将与骨架网格体一同从FBX文件中导入。 |
| **导入网格体LOD（Import Mesh LODs）** | 如果启用，从文件中定义的LOD创建虚幻网格体的LOD模型。否则，仅从LOD组导入基本网格体。对于骨架网格体，LOD模型可以蒙皮到相同或不同的骨架上。如果将LOD模型蒙皮到不同的骨架上，则必须满足虚幻的LOD需求，但根骨骼的名称可以不同，因为FBX导入器会自动重命名根骨骼。 |
| **法线导入方法（Normal Import Method）** | 允许控制法线的处理方式。选项如下： **计算法线（Compute Normals）**：引擎计算法线和切线。平滑组和法线信息将从FBX信息中丢弃。 **导入法线（Import Normals）**：法线从FBX文件导入，切线由引擎计算。 **导入法线和切线（Import Normals and Tangents）**：法线和切线是从FBX文件导入的，引擎不计算任何东西。 |
| **法线生成方法（Normal Generation Method）** | 在MikkTSpace或内置的法线生成方法之间进行选择的选项。 |
| **创建物理资产（Create PhysicsAsset）** | 如果启用，该选项将为导入的骨架网格体生成一个新的物理资产。物理资产将主要由球体组成（除了根将是胶囊体/球体对象之外），约束在所有旋转轴上完全自由，在位置轴上完全锁定。 |
| **选择物理资产（Select PhysicsAsset）** | 如果禁用创建物理资产（Create PhysicsAsset），你将可以选择已存在的物理资产，或选择 **无（none）** 使骨架网格体与物理资产不关联。 |

## 动画选项

使用FBX导入动画时可用的选项如下所示。

| 选项 | 说明 |
| --- | --- |
| 网格体 |  |
| **骨架（Skeleton）** | 骨架网格体应定位的[骨架](../../../animating-characters-and-objects/skeletal-mesh-animation-system/index.md)。如果没有选择现有的骨架，将从导入的骨架网格体创建一个新的骨架。新骨架的名称将是附加 *Skeleton* 的骨架网格体。 |
| Animation |  |
| **导入动画（Import Animations）** | 如果启用，[动画](../fbx-animation-pipeline/index.md)将与骨架网格体一同从FBX文件中导入。可在文本框中输入动画的名称，以覆盖默认名称。 |
| **动画长度（Animation Length）** | **导出时间（Exported Time）**：该选项根据导出时定义的内容导入动画帧。 **动画时间（Animated Time）**：将导入具有动画的帧范围。如果导出范围比FBX文件中的实际动画长，则此选项可能有用。 **设置范围（Set Range）**：该选项将启用开始帧（Start Frame）和结束帧（End Frame）属性，以便你定义要导入的动画的帧。 |
| **在骨骼层级中导入网格体（Import Meshes in Bone Hierarchy）** | 如果选中，内嵌于骨骼层级中的网格体将被导入，而非转换为骨骼。 |
| **帧导入范围（Frame Import Range）** | **最小值（Min）**：在动画长度（Animation Length）中使用 *Set Range* 时，该选项将使你可以设置要导入的动画的开始帧。 **最大值（Max）**：在动画长度（Animation Length）中使用 *Set Range* 时，该选项将使你可以设置要导入的动画的结束帧。 |
| **使用默认采样率（Use Default Sample Rate）** | 如果为 *true*，将对动画使用每秒30帧的默认采样率。如果取消选中，系统根据FBX文件确定采样率。 |
| **自定义采样率（Custom Sample Rate）** | 以指定采样率采集FBX动画数据。设为0时，将自动决定最佳采样率。 |
| **导入自定义属性（Import Custom Attribute）** | 如果启用，将自定义属性作为动画中的曲线导入。需要启用导入动画（Import Animations）。 |
| **删除现有自定义属性曲线（Delete Existing Custom Attribute Curves）** | 如果为True，在进行重新导入时，之前所有的自定义属性曲线都将被删除。 |
| **导入骨骼轨迹（Import Bone Track）** | 导入骨骼变换轨迹。如果为False，将弃用所有骨骼变换轨迹（对仅曲线动画非常有用）。 |
| **设置材质曲线类型（Set Material Curve Type）** | 如果为 *true*，将为现有的所有自定义属性设置材质曲线类型。 |
| **材质曲线后缀（Material Curve Suffixes）** | 使用自定义属性指定材质曲线类型的后缀。如果设置材质曲线类型（Set Material Curve Type）设置为 *true*，则该选项没有影响。 |
| **移除冗余密钥（Remove Redundant Keys）** | 将自定义属性导入为曲线时，将移除冗余密钥。 |
| **删除现有变形目标曲线（Delete Existing Morph Target Curves）** | 如果启用，该选项删除当前存在的变形目标。该设置仅在重新导入网格体时使用，可以在骨架网格体编辑器重新导入（Skeletal Mesh Editors Reimport）设置选项卡中设置。 |
| **不导入0值曲线（Do not import curves with 0 values）** | 导入自定义属性或变形目标作为曲线时，如果没有除0之外的任何其他值，则不导入。这是为了避免添加额外的曲线来求值。 |
| **维持局部变换（Preserve Local Transform）** | 引擎计算和累加变换的方式是不同的。我们计算全局变换，然后反算回局部变换。在某些情况下，这可能会影响使用3DS Max或非均匀缩放的动画。 |
| **覆盖动画名称（Override Animation Name）** | 指定给动画的名称。如果未在此处输入任何内容，将使用[命名规则](#%E5%91%BD%E5%90%8D%E8%A7%84%E5%88%99)。需要启用导入动画（Import Animations）。 |

## 变换

下面将解释使用FBX导入任何静态或骨架网格体资产时可用的选项。

| 选项 | 说明 |
| --- | --- |
| **导入平移（Import Translation）** | 该选项将允许网格体在导入时沿着XYZ轴移动。它将是网格体从世界场景原点偏移时的导入位置。 |
| **导入旋转（Import Rotation）** | 该选项将允许网格体在导入时沿XYZ轴旋转。 |
| **导入均匀缩放（Import Uniform Scale）** | 该选项将使网格体在导入时均匀缩放。 |

## 杂项

下面将解释使用FBX导入任何静态或骨架网格体资产时可用的其他各种选项。

| 选项 | 说明 |
| --- | --- |
| **转换场景（Convert Scene）** | 该选项将把场景从FBX坐标系转换为使用UE的坐标系。 |
| **Force Front XAxis** | 该选项将把场景从FBX坐标系转换为使用前X轴而非Y轴的UE坐标系。 |
| **转换场景单位（Convert Scene Unit）** | 该选项将把场景从FBX计量单位转换为UE计量单位，即厘米。 |
| **覆盖全名（Override Full Name）** | 该选项将使用字符串"名称（Name）"字段作为网格体的全名。该选项仅当场景包含一个网格体时才有效。 |

## 材质选项

使用FBX导入材质时可用的选项如下所示。

| 选项 | 说明 |
| --- | --- |
| Material |  |
| **搜索位置（Search Location）** | 指定导入时应该在何处搜索匹配的材质： **本地（Local）**：只在本地导入文件夹中搜索匹配的材质。 **父级下（Under Parent）**：从父文件夹中递归搜索匹配的材质。 **根下（Under Root）**：从根文件夹中递归搜索匹配的材质。 **所有资产（All Assets）**：在所有资产文件夹中搜索匹配的材质。 |
| **材质导入方法（Material Import Method）** | 指定以下选项的导入方法。 **新建材质（Create New Materials）**：自动从导入内容中新建一个材质资产。 **新建实例化材质（Create New Instanced Materials）**：允许选择基本材质名称。 **不创建材质（Do Not Create Material）**：不从导入内容中新建材质资产。 |
| **导入纹理（Import Textures）** | 如果启用，FBX文件中引用的纹理将被导入到虚幻。如果 **导入材质（Import Materials）** 为 *true*，则不管该设置如何，始终导入纹理。 |
| **反转法线贴图（Invert Normal Maps）** | 如果启用，且正在导入纹理，法线贴图值将被反转。 |
| **按照FBX顺序重新调整材质顺序（Reorder Material to Fbx Order）** | 若启用，材质列表会重新调整成和FBX文件一样的顺序。 |

## 命名规范

下表显示了在启用 **覆盖全名（Override FullName）** 时如何命名各种内容类型。

> [!NOTE]
> 该表假定以下条件：
>
> - %1
>
>   是要导入的资产的名称，即导入路径的最后一部分。
> - %2
>
>   是FBX文件中的网格体节点名称。对于骨架网格体，如果它由多个FBX网格提组成，则使用第一个FBX网格体名称作为FBX节点名称的一部分。

| 内容类型 | 命名规则 |
| --- | --- |
| **静态网格体** | 如果 **覆盖全名（Override FullName）** 为： **启用（Enabled）** 如果文件中有单个网格体 - 命名为 *%1* 如果文件中有多个网格体，且 **组合网格体（Combine Meshes）** 为： **启用（Enabled）** - 命名为 *%1* **禁用（Disabled）** - 命名为 *%1_%2* **禁用** 如果文件中有单个网格体 - 命名为 *%1_%2* 如果文件中有多个网格体，且 **组合网格体（Combine Meshes）** 为： **启用（Enabled）** - 命名为 *%1* **禁用（Disabled）** - 命名为 *%1_%2* |
| **骨架网格体** | 如果 **覆盖全名（Override FullName）** 为： **启用（Enabled）** 如果文件中有单个网格体 - 命名为 *%1* 如果文件中有多个网格体 - 命名为 *%1_%2* **禁用（Disabled）** - 命名为 *%1_%2* |
| **动画序列** | 如果导入动画和骨架网格体： 如果输入了动画名称（本例中视为%1）： 如果文件中有单个序列 - 命名为 *%1* 如果文件中有多个序列 - 命名为 *%1_%2* 如果未输入名称 - 命名为 *%1_%2* 如果仅导入动画： 如果文件中有单个序列 - 命名为 *%1* 如果文件中有多个序列 - 命名为 *%1_%2* |
| **变形目标** | 使用FBX文件中的MorphTarget节点的名称。 |
