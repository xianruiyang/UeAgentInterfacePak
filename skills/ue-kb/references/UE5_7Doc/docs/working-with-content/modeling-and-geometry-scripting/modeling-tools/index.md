---
title: "建模工具"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/modeling-tools-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "建模和几何体脚本编写", "建模工具"]
---

# 建模工具

> 路径：虚幻引擎5.7文档 / 管理内容 / 建模和几何体脚本编写 / 建模工具

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/modeling-tools-in-unreal-engine

**建模模式（Modeling Mode）** 提供了多种用于创建和编辑几何体的工具。我们将这些工具归入了具体的类别，以引导你完成建模过程。

[创建](#%E5%88%9B%E5%BB%BA)类别可以帮助你开始构建新网格体。你可以使用以下类别来编辑和检查网格体的属性：

- 选择

  ：编辑元素选择。
- 变换

  ：调整网格体的放置或呈现。
- 变形

  ：塑造或扭曲网格体的整体或特定区域。
- 建模

  ：执行精细网格体编辑。
- 网格体

  ：用于检查、优化、编辑网格体的几何体的网格体处理。
- 体素

  ：将网格体转换为体素以执行体积操作，然后再将其转换回网格体。
- 烘焙

  ：为网格体生成纹理和顶点颜色数据。
- UV

  ：编辑网格体的UV坐标。
- 属性

  ：检查和调整网格体的二级属性。
- 杂项

  ：其他实用工具，例如，管理LOD和体积转换。

每个类别的每个工具会在[工具属性](../getting-started-with-modeling-mode/modeling-mode/index.md#%E8%AE%BF%E9%97%AE%E5%BB%BA%E6%A8%A1%E6%A8%A1%E5%BC%8F)面板中打开特定工具集和设置。请参阅下面的类别，了解如何在你的工作流程中实现它们。

> [!NOTE]
> 当你在虚幻引擎中处理各种类型的Actor时，比如静态网格体、动态网格体或体积，你可以使用建模工具。这些Actor统称为"网格体"，工具仅可用于特定Actor类型的情形除外。

## 创建

从预定义图元、路径或样条线构建新网格体。以下预定义的图元可用：

*盒体* 球体 *圆柱体* 椎体 *环面* 箭头 *矩形* 圆盘 *楼梯* 胶囊体

如需详细了解这些图元，请参阅[预定义形状](predefined-shapes/index.md)。

> [!TIP]
> **挤压多边形（Extrude Polygon）** 和 **挤压路径（Extrude Path）** 等多种工具使用网格绘制形状。要控制网格的位置，请按住CTRL+点击所需位置。

| 工具 | 说明 |
| --- | --- |
| **立方体网格（Cube Grid）** | 使用可重新定位的网格创建方块网格体。如需详细了解此工具，请参阅[CubeGrid](cubegrid-tool/index.md)介绍。 |
| **挤压多边形（Extrude Polygon）** | 徒手或根据所选预定义形状绘制和挤压多边形。 |
| **挤压路径（Extrude Path）** | 绘制并挤压 **多路径（PolyPaths）** 以创建新的网格体，例如墙壁和匝道。 |
| **旋转路径（Revolve Path）** | 绘制通路并围绕某个轴旋转通路以创建对称网格体。 |
| **旋转路径（Revolve Path）** | 绘制并旋转2D路径以创建新网格体。 |
| **旋转样条线（Revolve Spline）** | 旋转样条线以创建新网格体。 |
| **绘制样条线（Draw Spline）** | 在关卡中绘制样条线。关于此工具的详情，请参阅[绘制样条线](draw-spline-tool/index.md)。 |
| **网格体样条线（Mesh Spline）** | 对所选Actor的样条线组件进行三角剖分，以创建新网格体。 |

### 选择

编辑元素选择。

> [!NOTE]
> 必须在 **建模模式快速设置（Modeling Mode Quick Settings）** 中启用 **网格体元素选择（Mesh Element Select）** 。

| 工具 | 说明 |
| --- | --- |
| **删除（Delete）** | 删除当前网格体选择。 |
| **挤压（Extrude）** | 通过移动和拼接一组选定的面，从这些面挤出几何体。 |
| **偏移（Offset）** | 挤出所选的面，与挤压操作类似，但挤出的面默认会沿着顶点法线的方向移动，而不是沿着单一方向移动。鼠标移动可控制偏移距离。在视口中点击可完成偏移。 |
| **推拉（Push Pull）** | 面可以切割网格体或桥接网格体部分。详情请参阅[推拉](push-pull-tool/index.md)。 |
| **内嵌（Inset）** | 内嵌选定面的当前集合。鼠标移动可控制内嵌距离。在视口中点击可完成内嵌。 |
| **外嵌（Outset）** | 向外扩展选定面的集合。鼠标移动可控制外嵌距离。在视口中点击可确认外嵌距离。 |
| **切割（Cut）** | 沿着绘制的线条分割所选的多边形组面，如同使用穿过该线条的面切割了多边形组。点击面绘制切割线。切线的边界处将形成新的多边形组。 |
| **倒角（Bevel）** | 围绕选定面倾斜边缘循环。 |
| **插入循环（Insert Loop）** | 在网格体中的四边形之间插入边缘链。你不对在非四边形的面上插入边缘。 |
| **清除（Clean）** | 对当前网格体或网格体选择重新进行三角剖分。 |

## Xform

调整网格体的放置或呈现。

| 工具 | 说明 |
| --- | --- |
| **变换（Transform）** | 变换选定网格体的不同方面。 |
| **对齐（Align）** | 相对于彼此重新定位所选网格体。 |
| **合并（Merge）** | 将多个网格体组合为一个网格体，保留相交的几何体。 |
| **复制（Duplicate）** | 复制单个网格体，创建新的Actor。 |
| **编辑枢轴点（Edit Pivot）** | 编辑选定网格体上的枢轴点位置。关于此工具的详情，请参阅[编辑枢轴点](edit-pivot-tool/index.md)概述。 |
| **烘焙变换（Bake Transform）** | 将缩放和旋转值烘焙到网格体中。默认情况下，缩放一致设为1，而旋转一致设为0。 |
| **传输（Transfer）** | 将一个网格体的数据传输到目标网格体，或传输到目标网格体使用的特定LOD。 |
| **转换（Convert）** | 在静态网格体、动态网格体或体积之间更改网格体的输出类型。 |
| **拆分（Split）** | 接受带有断开连接的几何体的网格体，并将其拆分为单独的网格体。 |
| **图案（Pattern）** | 沿可移动3D平面上定向的 **线条（Line）** 、 **网格（Grid）** 或 **圆周（Circle）** 平铺一个或多个所选网格体。 |
| **ISMEd** | 编辑实例静态网格体组件中的实例。 |

## 变形

塑造或扭曲网格体的整体或特定区域。

| 工具 | 说明 |
| --- | --- |
| **顶点塑造（Vertex Sculpt）** | 所用各种笔刷塑造所选的网格体（调整其顶点）。详情请参阅[顶点塑造工具](https://dev.epicgames.com/documentation/unreal-engine/vertex-sculpt-tool-in-unreal-engine)概述。 |
| **动态塑造（Dynamic Sculpt）** | 使用各种笔刷塑造所选的网格体，并通过重网格化将新的几何体动态添加到网格体。详情请参阅[动态塑造工具](https://dev.epicgames.com/documentation/unreal-engine/dynamic-sculpt-tool-in-unreal-engine)概述。 |
| **平滑（Smooth）** | 使网格体表面变得平滑，帮助去除锯齿状瑕疵。详情请参阅[平滑工具](smooth-tool/index.md)概述。 |
| **偏移（Offset）** | 沿法线按指定数量调整网格体顶点的位置。详情请参阅[偏移工具](offset-tool/index.md)概述。 |
| **扭曲（Warp）** | 使用 **混合（Blend）** 、 **迸发（Flare）** 和 **扭转（Twist）** 等非线性变换，改变网格体的形状。详情请参阅[扭曲](warp-tool/index.md)概述。 |
| **格栅（Lattice）** | 使用点结构通过顶点编辑网格体。详情请参阅[格栅工具](https://dev.epicgames.com/documentation/unreal-engine/lattice-tool-in-unreal-engine)概述。 |
| **置换（Displace）** | 基于预设算法、用户生成的权重贴图或纹理贴图，扭曲网格体的顶点。详情请参阅[位移工具](https://dev.epicgames.com/documentation/unreal-engine/displace-tool-in-unreal-engine)概述。 |
| **使多边形组变形（Deform PolyGroups）** | 打开工具以通过多边形组使网格体变形。如需详细了解此工具，请参阅[使多边形组变形](deform-polygroups-tool/index.md)概述。 |

## 建模

执行精细网格体编辑。

| 工具 | 说明 |
| --- | --- |
| **多边形组编辑（PolyGroup Edit）** | 打开工具，例如 **挤压（Extrude）** 、 **倒角（Bevel）** 和 **边缘循环（Edge Loop）** ，以通过多边形组编辑网格体。如需详细了解此工具，请参阅[多边形组编辑](polygroup-edit-tool/index.md)概述。 |
| **细分（Subdivide）** | 通过多边形组或三角形增加网格体的分辨率。如需详细了解此工具，请参阅[细分](subdivide-tool/index.md)概述。 |
| **布尔（Boolean）** | 减去或加上网格体对。如需详细了解此工具，请参阅[布尔](boolean-tool/index.md)概述。 |
| **多边形剪切（PolyCut）** | 使用挤压多边形和打开工具剪切所选网格体，以定义新的网格体。 |
| **平面剪切（Plane Cut）** | 剪切平面上的所选网格体。 |
| **镜像（Mirror）** | 沿给定平面反射网格体，以创建新的几何体。 |
| **网格体剪切（Mesh Cut）** | 使用第二个网格体将一个网格体拆分为多个部分。如需详细了解此工具，请参阅[网格体剪切](mesh-cut-tool/index.md)概述。 |
| **修剪（Trim）** | 使用第二个网格体修剪或剪切所选网格体。 |

## 网格体

用于优化和编辑网格体的几何体的网格体处理。

> [!TIP]
> 使用以下工具进行优化时，在[显示](../../../building-virtual-worlds/level-editor/editor-viewports/viewport-show-flags/index.md) > **高级（Advance）** 下更改[视图模式](../../../building-virtual-worlds/level-editor/editor-viewports/viewport-modes/index.md)并启用 **网格体边缘（Mesh Edges）** 会很有用。

| 工具 | 说明 |
| --- | --- |
| **三角形选择（Tri Select）** | 选择三角形以编辑网格体并调整二级属性。 |
| **三角形编辑（Triangle Edit）** | 打开工具以通过三角形编辑网格体。 |
| **填洞（Fill Holes）** | 填充网格体中的孔洞。 |
| **结合（Weld）** | 在给定公差之内自动合并所选网格体断开连接的边缘。 |
| **并集（Union）** | 将多个网格体合并为一个，解决自相交。 |
| **包壳（Jacket）** | 从所选网格体去除隐藏的三角形。 |
| **简化（Simplify）** | 尝试降低所选网格体的三角形密度。 |
| **重新网格化（Remesh）** | 重新三角剖分并增加所选网格体上的三角形密度。 |
| **投射（Project）** | 将一个网格体映射或重新网格化到目标网格体（第二个所选网格体）上。 |

## 体素

将网格体转换为体素以执行体积操作，然后再将其转换回网格体。

| 工具 | 说明 |
| --- | --- |
| **体素封装（Voxel Wrap）** | 使用体素封装所选网格体，帮助去除孔洞，以及去除自相交和隐藏的三角形。 |
| **体素混合（Voxel Blend）** | 使用体素混合所选网格体。 |
| **体素偏移（Voxel Offset）** | 使用体素偏移或插入所选网格体的表面。 |
| **体素布尔（Voxel Boolean）** | 对所选网格体执行布尔运算，然后使用体素封装结果。 |
| **体素合并（Voxel Merge）** | 合并所选网格体，然后将结果体素化。 |

## 烘焙

为网格体生成纹理和顶点颜色数据。

> [!TIP]
> 要恰当烘焙，源网格体和目标网格体必须重叠。

| 工具 | 说明 |
| --- | --- |
| **烘焙纹理（Bake Textures）** | 将源网格体的细节作为纹理烘焙到目标网格体。 |
| **全部烘焙（Bake All）** | 根据多个源网格体烘焙单个网格体的纹理。 |
| **烘焙顶点颜色（Bake Vertex Colors）** | 将源网格体的细节作为顶点颜色烘焙到目标网格体。 |
| **烘焙RC（Bake RC）** | 通过虚拟照片或渲染捕获，根据多个源网格体烘焙目标网格体的纹理。 |

## UV

编辑网格体的UV坐标，更改纹理映射到表面的方式。关于此类别的详情，请参阅[UV类别](uvs-category/index.md)。

| 工具 | 说明 |
| --- | --- |
| **自动UV（AutoUV）** | 自动展开和打包所选网格体的UV。 |
| **UV解包（UV Unwrap）** | 重新计算现有UV岛状区或多边形组的UV，从而帮助最大限度减少拉伸和压扁的区域。 |
| **投射UV（Project UVs）** | 通过将预定义的形状或点投射到网格体上来创建UV。 |
| **编辑UV接缝（Edit UV Seams）** | 在视口中交互式地分离边缘以创建接缝。 |
| **变换UV（Transform UVs）** | 在视口中交互式地缩放、旋转和平移UV岛状区。 |
| **布局UV（Layout UVs）** | 变换、堆叠或重新打包现有UV。 |
| **UV编辑器（UV Editor）** | 启动用于创建和编辑UV的专用编辑器。 |

## 属性

检查并调整网格体的二级属性，例如法线和多边形组。

| 工具 |  | 说明 |
| --- | --- | --- |
| **检查（Inspect）** | 检查网格体属性。 |  |
| **LOD管理（LOD Manager）** | 打开LOD管理器，为所选静态网格体资产定义和创建LOD。 |  |
| **法线（Normals）** | 重新计算法线并打开工具，通过切换打开和关闭选项并设置法线部位起伏来设置法线计算。 |  |
| **切线（Tangents）** | 编辑网格体的线条和切线。 |  |
| **生成多边形组（Generate PolyGroups）** | 为你的网格体生成多边形组。 |  |
| **绘制多边形组（Paint PolyGroups）** | 使用笔划将多边形组绘制到网格体上。 |  |
| **编辑属性（Edit Attributes）** | 编辑网格体的不同属性，包括UV，并添加新属性。 |  |
| **编辑材质（Edit Materials）** | 将多种材质和新材质元素分配给通过笔划选择的三角形。 |  |
| **绘制顶点颜色（Paint Vertex Colors）** | 将颜色值添加到网格体的顶点（包括Nanite网格体）。关于此工具的详情，请参阅[绘制顶点颜色](https://dev.epicgames.com/documentation/404)。 |  |
| **绘制地图（Paint Maps）** | 在特定权重地图层上绘制，你需要先使用编辑属性（Edit Attribute）工具生成这些层。关于此工具的详情，请参阅[绘制地图](paint-maps-tool/index.md)。 |  |
| **检查碰撞（Inspect Collision）** | 检查所选网格体的物理几何体。 |  |
| **简单碰撞编辑器（Simple Collision Editor）** | 编辑所选网格体的简单碰撞形状。 |  |
| **网格体至碰撞（Mesh To Collision）** | 将所选网格体转换为上次所选网格体的简单碰撞几何体。 |  |
| **碰撞至网格体（Collision To Mesh）** | 将简单碰撞几何体转换为新的网格体Actor。 |  |

## 杂项

其他实用工具，例如，管理LOD和体积转换。

| 工具 | 说明 |
| --- | --- |
| **自动LOD（AutoLOD）** | 打开工具集，生成和定义静态网格体LOD资产。 |
| **枢轴点Actor（Pivot Actor）** | 添加Actor以充当子组件的枢轴点。 |
| **旋转边界（Revolve Boundary）** | 旋转网格体边界循环以创建新形状。 |
| **体积对网格体（Volume To Mesh）** | 定义体积Actor并将其转换为静态或动态网格体Actor。 |
| **网格体至体积（Mesh To Volume）** | 定义网格体到新体积的转换。 |
| **转换BSP（Convert BSPs）** | 将二进制空间分区几何体转换为网格体。 |
