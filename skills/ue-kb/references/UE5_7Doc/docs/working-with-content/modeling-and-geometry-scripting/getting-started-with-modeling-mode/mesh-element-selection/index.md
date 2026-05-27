---
title: "网格体元素选择"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/mesh-element-selection-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "建模和几何体脚本编写", "建模模式入门指南", "网格体元素选择"]
---

# 网格体元素选择

> 路径：虚幻引擎5.7文档 / 管理内容 / 建模和几何体脚本编写 / 建模模式入门指南 / 网格体元素选择

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/mesh-element-selection-in-unreal-engine

**建模模式（Modeling Mode）**提供了在虚幻引擎中直接选择网格体元素（拓扑）的选项，以实现更加一致且优化的建模工作流程。 美术师可以使用**网格体元素选择（Mesh Element Selection）**工具栏来选择网格体或网格体元素，然后调用操作，而无需使用**多边形组编辑（PolyGroup Edit）**或**三角形编辑（Triangle Edit）**等中间工具。

网格体元素包括以下内容：

- 三角形
- 三角形的顶点
- 三角形的边
- 多边形组
- 多边形组的边
- 多边形组的顶点

这些元素代表构成网格体的粒状几何体。 元素的选择和编辑工作流程可以帮助你创建干净的网格体拓扑。

> [!NOTE]
> 多边形组是一组已分组的三角形，对你的建模工作流程有帮助。 例如，你可以构造类似于四边形的组以进行盒体建模。 如需详细了解多边形组以及其与三角形的区别，请参阅[了解多边形组](../understanding-polygroups/index.md)。

## 访问工具栏

在建模模式下，默认禁用网格体元素选择（Mesh Element Selection）工具栏。 如需详细了解建模模式以及访问方法，请参阅[建模模式概述](../modeling-mode/index.md)。

要启用工具栏，请按照以下步骤操作：

1. 在**建模模式快速设置（Modeling Mode Quick Settings）**中，点击**齿轮**图标
2. 点击**网格体元素选择（Mesh Element Selection）**。
3. 退出并重新进入建模模式。

**视口（Viewport）**中将出现工具栏。 此外，当你重新进入建模模式时，**选择（Select）**类别将变为可用，并提供用于编辑元素选择的工具。

## 使用网格体元素选择

你可以使用建模小工具变换元素选择，并使用**选择（Select）**类别工具进行额外的编辑。 当你打开可用工具时，将保留你选择的元素。

在打开工具时，元素选择是不可编辑的。 要更新所选的元素，你必须退出工具，调整选择，再重新进入工具。

各种选择命令，例如**全选（Select All）**和**反选（Invert Selection）**，可帮助你快速选择所需的元素。 你可以切换**拖动模式（Drag Mode）**来调整高亮显示元素的方法。 拖动模式选项是点击单个元素或用鼠标拖动以选择多个元素。 如需详细了解这些属性，请参阅本页的**工具栏属性**小节。

> [!NOTE]
> 对于导入的静态网格体，网格元素分段默认被锁定。 此设置可确保你不会意外编辑网格体的几何体。 要启用元素选择，你可以开关工具栏中的**锁定**图标。

### 小工具和数字控制

你可以使用建模小工具变换每个元素选择，或者使用**变换（Transformation）**面板进行数字输入。 要将小工具的方向从本地空间调整为法线选择，请使用工具栏的附加设置分段（参见下表）。

如需详细了解建模小工具和变换面板，请参阅建模模式概述的[小工具](../modeling-mode/index.md)小节。

### 工具栏属性

| 图标 | 说明 |
| --- | --- |
| [元素选择](https://dev.epicgames.com/community/api/documentation/image/bc217b3c-fbba-4ee3-851e-1ebcce9ba140?resizing_type=fit) | 禁用元素选择。 返回至网格体选择。 |
| [三角形](https://dev.epicgames.com/community/api/documentation/image/2822fc13-d973-4fff-8225-1aee82b0f821?resizing_type=fit) | 选择三角形的（面）。 |
| [三角形的边](https://dev.epicgames.com/community/api/documentation/image/40547e09-279f-4b67-9862-777892e5d7f2?resizing_type=fit) | 选择三角形的边缘。 |
| [三角形的顶点](https://dev.epicgames.com/community/api/documentation/image/47af6174-f32b-44d2-a519-49561dc1faa5?resizing_type=fit) | 选择三角形的顶点。 |
| [多边形组](https://dev.epicgames.com/community/api/documentation/image/c4037883-036b-438f-8f20-c4f68f29316c?resizing_type=fit) | 选择多边形组的（面）。 |
| [多边形组的边](https://dev.epicgames.com/community/api/documentation/image/0f7d6d8a-7b04-4cbd-ad30-ddc665963997?resizing_type=fit) | 选择多边形组的边缘，也称为边界。 |
| [多边形组的顶点](https://dev.epicgames.com/community/api/documentation/image/0a964ef5-14b9-4893-a636-a8840853180a?resizing_type=fit) | 选择多边形组的顶点，也称为角。 |
| [其他选择](https://dev.epicgames.com/community/api/documentation/image/08564399-7577-420c-a4f2-3cb68a051f23?resizing_type=fit) | 其他选择功能。全选扩展到连接项反选反转连接项展开选择收起选择 |
| [其他设置](https://dev.epicgames.com/community/api/documentation/image/bc1485bd-aa93-4c5a-887f-1b3c2bb99bfd?resizing_type=fit) | 其他设置。**拖动模式（Drag Mode）**：鼠标的选择方法。**无（None）：**点击单个元素。**路径（Path）**：点击一个元素，然后拖动以选中更多。**可选网格体类型（Selectable Mesh Types）**：体积静态网格体**本地线框模式（Local Frame Mode）**：调整小工具的方向。**根据几何体（From Geometry）**（选择法线）**根据对象（From Object）**（本地空间） |
| [锁定](https://dev.epicgames.com/community/api/documentation/image/0ca968e1-0d28-483d-93c8-d39e78b9c17d?resizing_type=fit) | 从元素选择中锁定和解锁选定的网格体。 当你选择元素类型时可用。 |

> [!TIP]
> 多边形组元素基于三角形的分组。 为获取特定选择，请尝试调整你的多边形组。 如需了解详情，请参阅[了解多边形组](../understanding-polygroups/index.md)。

### 热键

| 命令 | 说明 |
| --- | --- |
| **Shift + 点击（网格体）** | 将元素添加到选择中。 启用**路径拖动模式（Path Drag Mode）**后，使用**Ctrl + 拖动**。 |
| **Ctrl + 点击（网格体）** | 从选择中删除元素。 启用**路径拖动模式（Path Drag Mode）**后，使用**Ctrl + 拖动**。 |
| **Ctrl + Z** | 撤消操作。 |
| **鼠标中键 + 平移（小工具）** | 暂时重置小工具的位置。 |
| **Shift + Ctrl + 点击（小工具）** | 将小工具网格重新定位到命中法线。 |

## 选择类别工具

**选择（Select）**类别中的许多工具都可以打开拥有额外操作的面板。 但是，**清理（Clean）**和**删除（Delete）**选项都是一键操作。

- **删除（Delete）**：删除选择项。
- **清理（Clean）**：对选择项重新进行三角剖分。 仅适用于多边形组选择。

你可以在下表中查看有关其余工具的更多信息。

> [!NOTE]
> 有些工具仅适用于特定元素，或位于其他类别下。

| 工具 | 说明 |
| --- | --- |
| **挤压（Extrude）** | 通过移动和拼接一组选定的面，从这些面挤出几何体。 |
| **挤压边缘（Extrude Edge）** | 通过移动并缝合一组选定的边缘来挤出几何体。 |
| **偏移（Offset）** | 突出所选面，类似于挤压操作，但默认沿顶点法线而非单一方向移动面。 移动鼠标可控制偏移距离。 在视口中点击可完成偏移。 |
| **推拉（Push Pull）** | 面可以切割网格体或桥接网格体部分。 如需了解详情，请参阅[推拉](../../modeling-tools/push-pull-tool/index.md)。 |
| **内嵌（Inset）** | 内嵌选定面的当前集合。 鼠标移动可控制内嵌距离。 在视口中点击可完成内嵌。 |
| **外嵌（Outset）** | 向外扩展选定面的集合。 移动鼠标可控制外嵌距离。 在视口中点击可确认外嵌距离。 |
| **切割（Cut）** | 沿着绘制的线条分割所选的多边形组面，如同使用穿过该线条的面切割了多边形组。 点击面绘制切割线。 切线的边界处将形成新的多边形组。 |
| **倒角（Bevel）** | 围绕选定面倾斜边缘循环。 |
| **插入循环（Insert Loop）** | 在网格体中的四边形之间添加边缘链。 你不能在非四边形面上插入边缘。 |
| **接合（Weld）** | 将所选元素合并到容差范围内的、与其匹配且未连接的元素。 该工具位于**网格体（Mesh）**类别中。 |
| **拆分（Split）** | 将所选元素与未选择的元素断开，创建一个新网格体。 该工具位于**XForm**类别中。 |
| **平滑（Smooth）** | 将顶点向其相邻顶点的平均位置移动，以使表面更加柔和。 该工具位于**变形（Deform）**类别中。 详情请参阅[平滑](../../modeling-tools/smooth-tool/index.md)。 |
| **格栅（Lattice）** | 通过点的3D网格编辑网格体的顶点。 该工具位于**变形（Deform）**类别中。 详情请参阅[格栅](https://dev.epicgames.com/documentation/unreal-engine/lattice-tool-in-unreal-engine?application_version=5.7)。 |
| **置换（Displace）** | 为网格体添加曲边细分和扭曲。 在使用**扁平（Flat）**细分类型时，该工具位于**变形（Deform）**类别中。 详情请参阅[置换](https://dev.epicgames.com/documentation/unreal-engine/displace-tool-in-unreal-engine?application_version=5.7)。 |
