# nDisplay 3D配置编辑器

---
title: "nDisplay 3D配置编辑器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/ndisplay-3d-config-editor-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "使用nDisplay在多显示屏上进行渲染", "nDisplay 3D配置编辑器"]
---

# nDisplay 3D配置编辑器

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 使用nDisplay在多显示屏上进行渲染 / nDisplay 3D配置编辑器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/ndisplay-3d-config-editor-in-unreal-engine

你通过单个配置资产定义nDisplay系统的大部分方面，通过 **nDisplay 3D配置编辑器（nDisplay 3D Config Editor）** 定义 **nDisplay配置资产（nDisplay Config Asset）** 。该资产定义了构成你的集群网络的计算机、你希望虚幻引擎在每台计算机上渲染的窗口和视口的特征、显示设备的拓扑和配置、每个视口应该渲染的虚拟世界部分、你希望接受的输入设备类型，等等。

本页面介绍了 **nDisplay 3D配置编辑器（nDisplay 3D Config Editor）** 中可用的所有设置。

> 图片已省略：undefined

点击查看大图

1. **工具栏（Toolbar）** ，位于编辑器左上角。
2. **组件（Components）** ，位于工具栏下面的左侧。
3. **预览（Preview）** ，位于编辑器中部、组件（Components）面板右侧。
4. **细节（Details）** ，位于编辑器右侧、预览（Preview）面板旁边。
5. **群集（Cluster）** ，位于编辑器左侧、组件（Components）面板下方。
6. **输出映射（Output Mapping）** ，位于编辑器中部、预览（Preview）面板下方。
7. **编译器结果（Compiler Results）** ，位于编辑器右下角、细节（Details）面板下方。

## 工具栏

![nDsiplay配置编辑器工具栏](../../../../../assets/images/3b/3b8b75b5a82010592dce254db7318d7699701c49b08c21233f93455ea3e60e9b.png)

在3D配置编辑器的工具栏中，大部分按钮与蓝图编辑器的工具栏相同。下面是nDisplay 3D配置编辑器独有的两个按钮：

- **导入（Import）** ：从本地计算机导入nDisplay配置文件（`.ndisplay`、`.cfg`）。
- **导出（Export）** ：将nDisplay设置导出到本地计算机上的配置文件（`.ndisplay`）。

请参阅[工具栏](../../../../blueprints-visual-scripting/user-interface-reference-for-the-blueprint-73593f79/user-interface-components/toolbar-in-the-blueprints-visual-scripting-editor/index.md)，了解有关其他选项的更多细节。

## 组件

![nDisplay组件面板](../../../../../assets/images/38/382e6dde6d4533289aa60ba7acdca1198799ac01f7323ed6222afb483694cc04.png)

组件（Components）面板将定义nDisplay群集的物理显示、追踪和摄像机内设置。在设计nDisplay网络时，第一步是将组件添加到继承的根组件。你可以从预定义的显示器、变换和默认摄像机Actor列表中选择，或添加额外可用的UE组件。

> [!TIP]
> 要通过真实世界追踪系统使用nDisplay，需要将Live Link组件添加到组件（Components）面板。请参阅[Live Link](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/live-link/index.md)，了解有关如何为你的设置配置它的更多信息。

以下分段介绍了可以添加到你的设置的特定于nDisplay的组件。

### 屏幕

nDisplay **屏幕（Screen）** 组件旨在方便地定义任意大小、形状和分辨率的平面2D显示器。通过引用的视点 **查看原件（View Origin）** 组件，它们定义了一个称为 *视锥（view frustum）* 的体积，用于从摄像机或视点的视角渲染3D场景的一个部分。渲染的像素存储在视口结构中，该结构将显示器、视点和投影策略绑定在一起。上述每个投影屏幕都需要与物理屏幕相同或相似的空间尺寸，以用于渲染它。此设置与大部分投影策略兼容。

屏幕的枢轴点始终在其正中点。

![nDisplay屏幕组件](../../../../../assets/images/26/26c0f99dda118f5762b2420ebb9d3b59f68f0df10cf700d58958c0f2fb200944.jpg)

### 静态网格体

处理非平面显示器（如曲面LED墙或显示器）时，你可以使用静态网格体组件来取代屏幕组件。这样一来，你可以使用静态网格体完全定义屏幕的形状。此设置与大部分投影策略兼容。

![nDisplay配置编辑器中的静态网格体组件](../../../../../assets/images/83/8303e00ef672593dbb324c02d3c5af963a7c9a8d14d5135c2171b211fbb35462.jpg)

### Xform

默认情况下，所有对象的父节点是根组件原点：3D世界空间中的一个任意点，其中X、Y和Z轴都有其0点。你还可以在3D空间中配置具体名称的变换，称为Xform，可充当一个或多个组件的父节点。这有助于简化界面、摄像机和其他组件的空间布局。Xform包含可视化网格体，能够对细节（Details）面板中的组件进行缩放。

![nDisplay Xform组件](../../../../../assets/images/59/598fe6ad7dbb59ef910e579bb5408e51f6d61d9c449b8e69637b62336187075a.jpg)

> [!NOTE]
> 你可以使用UE的标准场景组件来取代Xform，以充当一个或多个组件的父节点，但它们没有可视化网格体，也不能在细节（Details）面板中控制其大小。

### 观察原点

nDisplay设置中的组件，用于定义渲染视口中内容时使用的原点。它们与用于定义显示内容的屏幕或静态网格体组件一起，定义了用于正确渲染3D内容的视锥。你可以在配置文件中包含多个"观察原点（View Origin）"，并将它们绑定到不同的视口和显示器。"观察原点"还包含使用nDisplay的[立体渲染](../stereoscopic-rendering-with-ndisplay/index.md)的设置。

### ICVFX摄像机

这是你可以引用或链接到关卡或项目中放置的外部摄像机的电影摄像机组件。此组件创建[摄像机内视觉特效处理](../../icvfx/index.md)项目所需的内视锥。

## 群集

![nDisplay群集面板](../../../../../assets/images/7c/7ccb8a2052383d7e7bf1c112bef003a62bc0a2273bfee63c04c8516a3955334d.png)

对于你将在nDisplay网络中使用的虚幻引擎应用程序的每个不同实例，你需要定义一个 **群集节点（Cluster Node）**。每个群集节点表示一个应用程序实例，并定义了将运行该应用程序实例的计算机主机名或IP地址。你可以为每个群集节点设置不同的物理计算机，或者可以具有多个在同一主机上运行的群集节点。

每个群集节点包含一个或多个视口。它们与其关联的显示或静态网格体组件一起，定义了3D世界中的窗口。然后，该窗口用于从任意"查看原件"的视角渲染你的场景。下表介绍了可以添加到群集的元素。

| 节点 | 说明 |
| --- | --- |
| 群集（Cluster） | 托管构成一个nDisplay群集的一组PC。每个nDisplay配置资产只能创建一个群集。 |
| 主机（Host） | 表示带有唯一IP地址的一个PC。可以自定义彩色签名以区分不同的PC。该颜色也可以在输出映射（Output Mapping）面板中使用。 |
| 节点（应用程序实例）（Node (Application Instance)） | UE的一个实例。通常，每个PC有一个应用程序实例，但允许有更多实例，以用于特定用例。应用程序实例窗口在此节点的细节（Details）面板中进行配置。 |
| 视口（Viewports） | 定义3D世界中的窗口。投影策略、摄像机和目标显示器的容器。 |

### 群集配置

要访问群集设置：

1. 在 **群集（Cluster）** 面板中选择 **群集（Cluster）** ，打开其 **细节（Details）** 面板。

   ![在群集面板中选择群集](../../../../../assets/images/41/4191c05be8ba85a19748dc97ce6d78149bff7d002b684a4677bcd22703606a09.png)
2. 在 **细节（Details）** 面板中，展开 **配置（Configuration）** 分段。

   ![在群集细节中展开配置分段](../../../../../assets/images/19/192d165d0d6790990fe12a0b2e812566613b954d1e0564776876c8195f613ea8.png)

在群集设置中，你可以为群集设置端口、网络和同步策略。如需详细了解如何更改端口、网络和同步设置，请参阅[更改nDisplay通信端口](../changing-ndisplay-communication-ports/index.md)和[nDisplay中的同步](../synchronization-in-ndisplay/index.md)。

## 输出映射

> 图片已省略：nDisplay输出映射面板

**输出映射（Output Mapping）** 面板实际上将群集（Cluster）面板中定义的视口映射到2D UE应用程序窗口。在输出映射（Output Mapping）面板中，你可以：

- 查看主机计算机、群集节点（UE应用程序实例）和视口之间的关系。
- 在应用程序实例窗口中可视化、编辑和映射2D视口。
- 平移和旋转视口。

按从左到右的顺序使用位于 **输出映射（Output Mapping）** 面板左上角的以下工具，修改nDisplay群集的窗口和视口：

> 图片已省略：nDisplay配置编辑器的输出映射面板中的工具

| 按钮 | 快捷键 | 说明 |
| --- | --- | --- |
| 汉堡菜单（Hamburger Menu） |  | 你可以启用或禁用以下选项： 给选定的视口着色（Tint Selected Viewports） 重叠和边界（Overlap and Bounds） 主机布局（Host Arrangement） |
| 信息栏（Info Bar） | W | 启用此选项会显示窗口信息，例如分辨率和IP地址。 |
| 显示窗口之外的视口（Show Viewports Outside Window） | R | 启用此选项会显示应用程序窗口之外的所有视口。 |
| 缩放以适配（Zoom to Fit） | Z | 自动缩放以适配面板视图。 |
| 查看比例（View Scale） |  | 设置窗口和视口的比例。 |
| 变换操作（Transform Operations） |  | 将变换应用于视口的选项： 逆时针旋转90度（Rotate 90 degrees counterclockwise）。 顺时针旋转90度（Rotate 90 degrees clockwise）。 旋转180度（Rotate 90 degrees clockwise）。 水平翻转（Flip horizontal）。 垂直翻转（Flip vertical）。 重置变换（Reset transform）。 |
| 定位设置（Positioning Settings） |  | 与节点定位方式有关的设置。你可以启用或禁用以下选项： 允许群集项重叠（Allow Cluster Item Overlap） 将群集节点保留在主机中（Keep Cluster Nodes inside Hosts） 将群集节点锁定（Lock Cluster Nodes in place） 将视口锁定（Lock Viewports in place） |
| 节点对齐（Node Snapping） |  | 与将节点对齐到一起的方式有关的选项。你可以启用或禁用以下选项： 切换相邻边缘对齐（Toggle Adjacent Edge Snapping） 相邻边缘填充（Adjacent Edge Padding） 切换相同边缘对齐（Toggle Same Edge Snapping） 对齐距离（Snap Proximity） |

### 窗口配置

每个窗口配置都为你的虚幻引擎应用程序的实例主窗口定义一组属性。它用于配置细节，例如在nDisplay启动应用程序时配置窗口的启动大小和位置，以及窗口是否应该占据全屏。

此外，你还可以提供一个或多个视口配置，用于标识nDisplay将通过场景渲染来填充的主应用程序窗口中的特定区域。

在 **nDisplay 3D配置编辑器（nDisplay 3D Config Editor）** 中，你可以配置窗口，具体做法是选择输出映射（Output Mapping）面板中的群集节点并修改其大小，或更改群集节点的 **细节（Details）** 面板的 **窗口（Window）** 分段中的设置。

#### 输出重新映射

通过输出重新映射，你可以按应用程序窗口中的位置和比例指定视口的渲染方式。输出重新映射通过允许提供的网格体的UV通道中定义的自定义变换（如旋转）来扩展此功能。

例如，可平移、旋转、缩放输出图像的各部分，使其在应用程序窗口的不同区域显示。

> 图片已省略：undefined

点击查看大图

有三种方式可启用此功能：

- 分配一个静态网格体，其中包含带有自定义UV映射的平面几何体。
- 分配一个外部.obj文件，其中包含带有自定义UV映射的平面几何体。
- 在输出映射（Output Mapping）面板中选择一个视口，并选择 **变换操作（Transform Operation）** 。

##### 使用静态网格体或外部文件的输出重新映射

要应用输出重新映射，你可以提供静态网格体或外部.obj文件，其中包含设置了自定义UV映射的平面几何体。nDisplay将使用为你的平面设置的UV通道来确定输出图像如何映射到应用程序窗口的每个部分。

输入网格体可以是单元大小，并将应用于整个应用程序窗口。这是因为，nDisplay将最终渲染缓冲区作为输入GPU纹理取样器，以用于最终后期处理着色器，而该着色器则被应用于带有任意UV空间的网格体。

> 图片已省略：undefined

点击查看大图

将旋转应用于使用外部文件的nDisplay渲染时，你必须手动调整应用程序窗口分辨率，以适应旋转，否则渲染看起来会像是被拉伸的状态。

要在项目中启用输出重新映射：

1. 在 **群集（Cluster）** 面板中，选择 **节点（Node）** 以打开其 **细节（Details）** 面板。
2. 在 **细节（Details）** 面板中，展开 **输出重新映射（Output Remapping）** 分段。

   > 图片已省略：展开节点的细节面板中的输出重新映射分段
3. 启用 **输出重新映射（Output Remapping）** 。

   > 图片已省略：启用输出重新映射
4. 选择你想使用的 **数据源（Data Source）** ： **静态网格体（Static Mesh）** 或 **外部文件（External File）** 。

   1. 对于静态网格体

      ：浏览到项目中的

      静态网格体（Static Mesh）

      。

   > 图片已省略：静态网格体输出重新映射

   1. 对于外部文件

      ：输入.obj文件的磁盘上路径。

   > 图片已省略：外部文件输出重新映射

为了将静态网格体用于输出重新映射，必须为该静态网格体启用 **允许CPUAccess（Allow CPUAccess）** 。为此，请执行以下操作：

1. 在 **内容浏览器（Content Browser）** 中双击该静态网格体以在 **静态网格体编辑器（Static Mesh Editor）** 中将其打开。
2. 在 **细节（Details）** 面板中，展开 **一般设置（General Settings）> 高级（Advanced）** 。
3. 启用 **允许CPUAccess（Allow CPUAccess）** 。
4. 保存静态网格体资产以保留你的更改。

   > 图片已省略：允许静态网格体访问CPU

##### 使用变换操作的输出重新映射

你可以在输出映射（Output Mapping）面板中变换视口，以修改它们将在应用程序窗口中渲染的方式。

> 图片已省略：使用变换操作工具的输出重新映射

左侧两个视口顺时针旋转了90度，并缩小以适配该空间。

要将旋转或翻转变换快速应用于项目中的视口：

1. 在群集（Cluster）面板或输出映射（Output Mapping）面板中选择该视口。
2. 在输出映射（Output Mapping）面板中，选择 **变换（Transform）** 并选择你想应用的操作。

   或者，右键点击视口以打开上下文菜单，并选择所需的 **变换（Transform）** 。

   > 图片已省略：输出重新映射变换操作的选项

### 视口配置

每个窗口配置指的是一个或多个视口配置，每个视口配置定义了窗口中nDisplay应该使用场景的渲染视图进行填充的一个矩形区域。通常情况下，视口从应用程序窗口的左上角开始，并且其宽度和高度设置为可以填满父窗口。

在一些情况下，你可能需要在视口的父应用程序窗口内偏移、缩放或旋转视口。例如，LED处理器有时以编程方式将自定义2D映射包含在更大的画布上。使用nDisplay输出映射（Output Mapping）面板，你可以放置或旋转视口，使其适配显示设备或处理器预期的区域。你可以针对每个应用程序窗口加载一个自定义背景图像，以帮助放置视口。

如果你使用操作系统配置来旋转或平移显示内容，还可以使用输出映射工具来匹配这种任意旋转和位置。

上述每个视口配置指的是一种投影策略，它负责定义图像在视口中如何渲染。虚幻引擎会自动将整个群集连接到当前摄像机的位置，这样就能够制作烘焙的或交互式摄像机动画。你可以根据需要禁用摄像机。

在大部分常见2D情形中，你将使用 **简单（Simple）** 的投影类型，这会使用显示配置和"查看原件"所定义的视锥渲染虚拟世界。这些渲染的像素实际上由连接的视口存储和定义。

对于更复杂的设置（例如摄像机内视觉特效处理的设置，或在显示器为曲面或任意形状的表面时），你可以使用 **网格体（Mesh）** 或 **MPCDI** 投影策略。

其他特定于行业的投影类型（例如 **EasyBlend** 、 **VIOSO** 和 **DomeProjection** ）会瞄准投影器照亮的显示表面，并使用其他方法来定义或适应视口的渲染内容。它们可能在将图像渲染到矩形视口之前引入更多校正或应用自定义渲染技术。例如，投影可能会挤压、拉伸或扭曲图像，使其在曲面或任意形状的表面上看起来比较自然。它们还可能为连续渲染的图像应用所需的颜色或伽马曲线校正。

如需详细了解投影类型及其配置，请参阅[nDisplay中的投影策略](../projection-policies-in-ndisplay/index.md)。

#### 纹理共享

你可以利用TextureShare将视口纹理与另一个应用程序共享，或从另一个应用程序接收纹理并将其显示在指定的视口中。

要启用视口的纹理共享：

1. 在 **3D配置编辑器（3D Config Editor）** 中，选择 **视口（viewport）** 以查看其 **细节（Details）** 面板。
2. 在 **细节（Details）** 面板中，启用 **共享视口（Share Viewport）** 。

   > 图片已省略：启用共享视口
3. 现在你可以在外部应用程序中使用该视口来发送或接收纹理。

请参阅[纹理共享](../../texture-share/index.md)，详细了解同步设置以及如何设置外部应用程序。

## 3D视口

你可以利用3D视口直观地看到nDisplay群集的显示、摄像机和追踪设置。该面板是一种3D编辑工具，用于可视化和编辑以下内容：

- 显示拓扑和投影策略。
- 追踪的摄像机位置。
- 追踪的用户位置。

使用此视图以确保：

- 你的显示器已正确设置。
- 预览渲染从摄像机优势点看起来正确。
- 视口正确映射到屏幕。

