---
title: "影片渲染图表节点"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/movie-render-graph-nodes-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "影片渲染管线", "渲染设置与格式", "影片渲染图表节点"]
---

# 影片渲染图表节点

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / 影片渲染管线 / 渲染设置与格式 / 影片渲染图表节点

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/movie-render-graph-nodes-in-unreal-engine

## 全局

大部分节点都可以被应用到全局（Globals）链，但有些节点只能连接到全局链。此类设置只能 **逐渲染作业设定一次** ，而不能逐图层设置。

大部分此类设置都存在于旧版虚幻引擎的影片渲染队列预设中。如需详细信息，请参阅[虚幻引擎过场动画渲染图像质量设置](../index.md)文档。

下面列出了一部分影片渲染图表中可使用的全局节点以及功能说明：

| 节点 | 说明 |
| --- | --- |
| **Warm Up Settings** | 预热设置已被改进和简化，现在你只需要设置一个数值并决定是否模拟动态模糊。 |
| **Global Game Overrides** | 此项对应旧版MRQ界面中的游戏重载项分段。可用此节点在渲染时以各种方式提高渲染质量，从而让编辑器保持快速运行。如果编辑器视口和MRQ渲染之间出现差异，请考虑断开/禁用此节点并进行故障排除。 |
| **Global Output Settings** | 输出设置决定输出文件的目录、帧率和输出分辨率。文件名则由影片渲染图表的File Type节点所控制。 **Global Output Settings** 节点还包含一个 **时间码（Timecode）** 分类，其中有两个属性： **自定义时间码起始（Custom Timecode Start）**：默认情况下，影片渲染队列会包含它从被染的关卡序列中接收到的所有时间码数据。但你可以选择 **自定义时间码起始** 来重载它。 **如FPS为29.97则使用DF时间码（Use DF Timecode if 29.97 fps）**：**丢帧（DF）** 时间码只在帧率为 `29.97` 才适用。在配置使用 `29.97` 帧率时，系统会自动使用它。但如果你禁用此属性可以选择不使用DF时间码。 |
| **Sampling Method** | 设置时间样本数。时间样本只能逐渲染作业来应用。空间样本则位于Render Type节点中，而且可逐图层应用。 |
| **Camera Settings** | 包括快门时间设置，可指定过扫描百分比，从而在图像边缘渲染额外像素。 |
| **Debug Settings** | 此节点让你能直接从影片渲染队列中捕获Unreal Insights的追踪，并将帧发送到Render Doc。 |
| **Apply CVar Preset** | 此节点让你能在渲染时应用控制台变量的预设。你可以在节点的 **细节** 面板中浏览应用的预设列表。此外，你也可以重载单个预设，方法是右键点击列表中的预设，并选择 **使用设置控制台变量节点重载（Override with Set Console Variable Node）** 选项。在选择此项后，新的 **Set Console Variable** 节点会被添加到图表并连接到 **Apply Console Variable Preset** 节点。它可以调整所选的控制台变量，以及预设资产的值。你也可以单独公开每个预设，方法是右键点击图表中的Apply Console Variable Prest节点，点击指定预设旁的复选框。此外，你还可以通过 **队列（Queue）** 窗口手动调整控制台变量。 |
| **Set CVar Value** | 此节点让你能在渲染时设定控制台的变量值。 |
| **Command Line Encoder** | Command Line Encoder节点让你可以用第三方软件（比如FFmpeg）创建自己的输出格式。此设置需要在你的"项目设置"中启用编码器可执行文件和设置。 |
| **Execute Script** | Execute Script节点可以让你选择预定义的Python UClass，而后者可以重载前期或后期的镜头和作业回调。此设置项需要你创建从MovieGraphScriptBase派生的专门类。 |
| **Set Start/End Console Commands** | 你可以用此节点为给定渲染添加和移除开始（Start）和结束（End）控制台命令。 |
| **Object IDs** | 此节点为特定对象分配唯一ID。渲染可以使用此唯一ID包含或排除特定对象。 |

## Render Layer节点

如果你的链中存在 **Render Layer节点** ，那么影片渲染图表就会渲染此链。否则就只会执行逻辑。Render Layer节点对子图表或管线工具而言很有用，可以更好地控制渲染结果。

![Render Layer node](../../../../../../assets/images/7c/7ccd64b25085f02d954db984c9773ad631dee111ce1af4d70fa9d59d1e1bd7b3.jpg)

要禁用链中的渲染，除了将链与输出选项卡断开外，你还可以右键点击该节点以打开快捷菜单，选择 **禁用（Disable）** 属性。

![Disable Render Layer node](../../../../../../assets/images/a5/a5236ef1385172211dc123fa9c0bf29b3555b3479c474d020c4f890e7e8ce938.jpg)

## 逐层节点

使用影片渲染图表时，以下节点可逐图层使用。

### Render Type节点

你可以在影片渲染图表中使用 **路径追踪（Path Traced）** 和 **延迟（Deferred）** 渲染器节点。连接链中的相关节点即可定义选择的渲染路径。这可以逐渲染图层进行选择。这意味着在同一个渲染图表中，你可以让一个图层采用延迟渲染路径，另一个图层则采用路径追踪渲染路径。

![Graph showing Deferred and Path Traced Renderer nodes](../../../../../../assets/images/98/981325354cfb0e80fd372788dcce158b76ffa2b027cba164fa94f0f03e1b8d55.jpg)

#### 延迟渲染器

**Deferred Renderer** 节点中存在许多可以在渲染时重载编辑器设置项的参数，也可以设定强制应用于所有渲染图层的属性。下方列出了Deferred Renderer节点中可用的属性：

| 属性 |
| --- |
| **空间样本数（Spatial Sample Count）** |
| **抗锯齿方法（AntiAliasing Method）** |
| **禁用色调曲线（Disable Tone Curve）** |
| **允许OCIO（Allow OCIO）** |
| **查看索引模式（View Index Mode）** |
| **额外后期处理材质（Additional Post Process Materials）** 启用 **使用高精度（32位）输出（Use High Precision (32 bit) Output）** 属性后，你的图像将逐PPM，以32位色彩输出渲染。PPM也有 **名称（Name）** 属性，可用于来定义输出名称，使其成为易于理解且可自定义的字符串形式。 |
| **渲染显示标记（Render Show Flags）** |

#### **路径追踪渲染器**

**Path Traced Renderer** 节点中存在许多可以在渲染时重载编辑器设置项的参数。下方列出了Path Traced Renderer节点中可用的属性：

| 属性 |
| --- |
| **空间样本数（Spatial Sample Count）** |
| **降噪器（Denoiser）** |
| **禁用色调曲线（Disable Tone Curve）** |
| **允许OCIO（Allow OCIO）** |
| **额外后期处理材质（Additional Post Process Materials）** 启用 **使用高精度（32位）输出（Use High Precision (32 bit) Output）** 属性后，你的图像将逐PPM，以32位色彩输出渲染。PPM也有 **名称（Name）** 属性，可用于来定义输出名称，使其成为易于理解且可自定义的字符串形式。 |
| **渲染显示标记（Render Show Flags）** |
| **引用动态模糊（Reference Motion Blur）** |

Path Traced Renderer节点还支持时间降噪器（简称NFOR）。在使用Path Traced Renderer节点时，默认选项还是 **空间（Spatial）** 降噪器，但你可以使用节点 **细节** 面板中的属性将其切换为时间降噪器。在启用时间降噪器节点后，你可以使用 **帧数（Frame Count）** 属性设置在执行时间降噪时要考虑的帧数。帧数越高，渲染时间越长。

### Output File Type节点

影片渲染图表给出了许多输出文件类型的选项。你可以逐渲染链选择文件输出的类型。

![ImageAltText](../../../../../../assets/images/68/6857daf66e5f81b71cebf69cb32b502243896b7491c4473300ef662fd6278e6e.jpg)

使用 **Output File Type** 节点，影片渲染图表可输出下列文件类型：

- WAV（只能全局应用。）
- PNG
- JPG
- BMP
- EXR
- EXR Multilayer* （只能全局应用，首个输出将进入RGBA。其他输出都将被列在以其本身命名的图层中。）

你可以定义 **OpenColorIO** （**OCIO**）的配置、适用的压缩文件类型以及文件的命名。你还可以在 **Output File Type** 节点的细节面板中定义文件命名。

![Details panel for Output File Type node](../../../../../../assets/images/48/48e3b24f04a120688603c063b203e0a89df7ba0f5617e4519fe5f62787c81058.png)

你还可以在此处声明 **文件名（File Name）** 。影片渲染图表默认使用 **{sequence_name}.{layer_name}.{frame_number}** 令牌。令牌可以用来指示 **Global Output Settings** 节点中的框架名称以及文件夹名称。

![File Name Format property](../../../../../../assets/images/75/755291594eb493ef87f305e5ebe9db29991b67793d9bcc3c52dddb861a71c028.png)

如果你清空了文件名格式（File Name Format）属性，还可以从下拉菜单中选择不同的文件名格式。

![Select a different File Name Format](../../../../../../assets/images/67/67940e9c2ef2aba16584a6fdf8640f0e046060dd61503335a0d26f5852f5f34f.png)

此外，你还可以输出 **Apple ProRes Movie** 和 **Avid DNxHR Movie** 文件，方法是使用其各自的 **Output Type** 节点。这两个节点与其他Output Type节点不同，包含一个额外的 **质量（Quality）** 属性，可用于设置每个编码解码器的选项。可选的质量（Quality）属性有：

**Apple ProRes Movie**

- Apple ProRes 422 Proxy
- Apple ProRes 422 LT（默认）
- Apple ProRes 422
- Apple ProRes 422 HQ
- Apple ProRes 4444
- Apple ProRes 4444 XQ

**Avid DNxHR Movie**

- DNxHR RGB 444 12-bit
- DNxHR HQX 10-bit
- DNxHR HQ 8-bit（默认）
- DNxHR SQ 8-bit
- DNxHR LB 8-bit

**Apple ProRes Movie** 和 **Avid DNxHR Movie** 节点会按照 **Global Output Settings** 节点指定的方式嵌入时间码。

> [!NOTE]
> **Apple ProRes Movie** 和 **Avid DNxHR Movie** 节点只在虚幻引擎的Windows构建中可用。

### Collection节点

根据你想在关卡中重载的可见性属性，可以用Collections节点来对不同的Actor进行收集和分组。例如背景、角色、光源和植被等。

![ImageAltText](../../../../../../assets/images/e2/e20065743ef6c9a5c1f0d78dea0b087ab2c36c37c3bc4071a70b1aac4c0cba96.jpg)

> [!NOTE]
> 必须为所有Collection节点设置唯一名称。否则图表下游的同名集合会重载上游集合。

#### 条件组

集合存在 **条件组** 的概念。条件组定义了填充集合的条件。有多种条件可供选择，使你能遍历所有级别以获取所需的Actor。以下为可以添加到条件组的条件类型：

- Actor
- Actor Tag Name
- Actor Name
- Actor Type
- Actor Layer
- Component Tag Name
- Component Type
- Editor Folder
- Sublevel
- Data Layer
- Is Spawnable

> [!NOTE]
> 要将一个可生成Actor添加到条件组，你必须使用Actor Name条件，或使用 **Is Spawnable** 属性将给定镜头的场景中所有的Spawnable Actor包含在内。

下面列出了 **String** 数据类型输入所使用的一些通配符示例，例如 **Actor Name** 、 **Actor Tag Name** 以及 **Component Tag Name** 。

- `Foo*` 可匹配 `Foo` 、 `FooBar` 以及 `FooBaz` ，但 **不匹配** `BarFoo` 。
- `*Foo*` 可匹配上述项目，外加 `BarFoo` 。
- `Foo?Bar` 可匹配 `Foo.Bar` 以及 `Foo_Bar` ，但 **不匹配** `FooBar` 。
- `Foo?` 可匹配 `Food` ，但 **不匹配** `FooBar` 或 `BarFoo` 。
- `Foo???` 可匹配 `FooBar` 和 `FooBaz` ，但 **不匹配** `Foo` 或 `Food` 。
- `?oo?` 可匹配 `Food` ，但 **不匹配** `Foo` 。
- `?Foo*` 可匹配 `AFooBar` ，但 **不匹配** `FooBar` 。

#### 利用条件组

你可以逐组添加多个条件来创建成员身份。你也可以利用条件进行相互配合和/或制衡。可用条件包括 **Add**、**Subtract** 以及 **And** 。

| 条件 |  |
| --- | --- |
| **ADD** | Add条件可将所有条件的结果相加到一起。 例如： Actor名称匹配 `CHAR_*` **Add** Actor位于子关卡 `FG_SUBLEVEL` 这将包括所有子关卡中匹配 `CHAR_*` 的Actor，以及子关卡 `FG_SUBLEVEL` 中的所有Actor，无论其名称为何。 |
| **SUBTRACT** | Subtract条件会让条件组彼此相减。 例如： Actor名称匹配 `CHAR_*` **Subtract** Actor位于子关卡 `FG_SUBLEVEL` 这将包括所有子关卡中匹配 `CHAR_*` 的Actor，但减去子关卡 `FG_SUBLEVEL` 中的所有Actor。 |
| **AND** | And将检查是否符合所有条件组。 例如： Actor名称匹配 `CHAR_*` **And** Actor位于子关卡 `FG_SUBLEVEL` 即使其他子关卡（如 `OTHER_SUBLEVEL`）中的Actor匹配 `CHAR_*` 也不会被包括在内，而如果 `FG_SUBLEVEL` 中其他Actor不匹配 `CHAR_*` ，那么也不会被包括在内。因而只有同时符合条件的Actor才会产出结果。 |

你甚至可以利用多个条件组。

> 图片已省略：Use multiple condition groups

此外你还可以拥有多个复杂条件组，并利用这些组进行相互配合或制衡。

> 图片已省略：Multiple condition groups

#### 条件组重新排序

将鼠标悬停在条件组或条件组图层的左侧，界面上会出现十个点，且光标将变成手型。这时你就能通过拖放操作来重新排列条件组。

#### 编辑器内集合的成员身份显示

细节面板顶部的箭头图标将解析节点并选择引擎中的Actor成员。

同一个Actor可以是多个条件组和集合的成员。图表内部不限制任何成员资格，需要手动管理。

#### 集合可用性

你必须将集合以及欲使用的修饰符在同一个链中定义。如果集合处于链之外，选择未连接的集合就会报错。子图表中的集合也可在父节点图表中使用。

#### 可生成对象

由于引擎中的可生成对象具有瞬时性，影片渲染图表对它们的支持较为有限，但未来这一情况可能会有所改进。在Collection节点中，你需要使用应用的Actor标签来获取可生成的Actor。

> [!NOTE]
> 目前，带标签的组件存在限制。当Actor由于蓝图重构而重新生成时，关卡中将不会保留这些组件。要标记组件，你需要将这些渲染标签应用于资产而不是Actor。

### Modifier节点

Modifier节点被用于控制集合的可见性条件。**和集合同理，强烈推荐为每个修饰符赋予唯一名称。**

可以在 **集合（Collection）** 分段下设置Modifier节点可控制的集合。

可视性分段下有5个属性和1个材质插槽，供你对集合中的Actor进行控制。 这些参数和Actor上的相同参数一致。天空大气和高度雾的 **在主通道中渲染（Render in Main）** 参数相当于 **隐藏时影响间接光照（Affect Indirect Lighting While Hidden）** 。影片渲染图表会在内部为你建立此连接。下面列出了这些属性及对应的功能说明：

> [!NOTE]
> 如果你没有在给定的Actor类型上看到这些属性，那说明这些类型尚不受支持。

| 属性 | 说明 |
| --- | --- |
| **隐藏（Is Hidden）（对摄像机可见（Visible to Camera））** | 决定集合的Actor成员可见性。 |
| **投射阴影（Cast Shadows）** | 决定集合的Actor成员是否会在关卡中投射阴影。 |
| **隐藏时投射阴影（Cast Shadows While Hidden）（对阴影可见（Visible to Shadows））** | 决定集合的Actor成员在对主像素不可见时投射阴影的能力。 |
| **隐藏时影响间接光照（Affect Indirect Lighting While Hidden）（对间接光照可见（Visible to Indirect））** | 决定集合的Actor成员是否对Lumen场景（包括全局光照和反射）可见，同时对主像素不可见。 |
| **维持（Holdout）** | 决定集合的Actor成员是否会在渲染层的RGBA中造成黑洞。 |

#### 使用Modifier节点

请看Meerkat示例项目中的可视化示例。第一个镜头中存在背景（BG）图像、一枚蛋和一只狐蒙。

关闭蛋的 **可见（Visible）** 标记后，它的阴影、反射以及它对场景中的所有全局光照效果都会一起消失。

但如果启用蛋的 **隐藏阴影（Hidden Shadow）** 属性，阴影就会再度出现。

这时如果再启用 **Lumen概览（Lumen Overview）** ，蛋就不会出现在Lumen场景中，因此它不会投射任何反射或全局光照。

这时再启用 **隐藏时影响间接光照（Affect Indirect Lighting While Hidden）** 并禁用 **屏幕追踪（Screen Traces）** ，蛋就会重新出现在Lumen场景中，同时视口中会出现全局光照遮蔽和反射。

这时再开启 **可见性（Visibility）** ，禁用 **隐藏时影响间接光照（Affect Indirect Lighting While Hidden）** 和 **隐藏阴影（Hidden Shadow）** ，并启用 **Holdout** 参数，蛋就会完全变黑并且不会在渲染中造成黑洞。它的alpha也会被渲染为黑色。

它仍然会投射阴影，这时再看Lumen场景，我们会看到蛋仍然在那里，并且会投射适当的全局光照和反射。

### Burn-In和UI Renderer节点

Burn-In节点可在渲染中添加自定义水印，水印通常与时间码相关。你可以选择是将烧入效果应用到最终图像中，还是将其渲染到单独的图层。默认提供的BurnIn类涵盖了作业名称、日期、关卡名称、作者、变更清单、摄像机信息等基本内容。

**UI Renderer** 节点包含渲染输出场景内的UMG控件，并允许基于UMG的元素位于单独的渲染层或合成到最终图像，并以此提供了灵活性。

## 输出

输出节点负责对渲染器发送逻辑。要创建输出，找到 **输出（OUTPUTS）** 分段，点击 **成员（Members）** 选项卡上的加号图标。

如果链中存在插入到输出的Render Layer节点，那么该链的逻辑将被发送到渲染器。如果没有Render Layer节点，影片渲染图表将传出逻辑，这将帮助你使用管线工具和子图表。无连接的输出将不执行任何操作。

## Conditional节点

部分逻辑节点可以应用到影片渲染图表中，从而控制分支的计算。

### Branch节点

此节点以True/False布尔值作为输入，从而让影片渲染图表决定要计算的分支。

举例说明，如果你想设置单个渲染图层，但希望能够选择使用路径追踪还是延迟路径对其进行渲染。

### Select节点

此节点接受输入从而让影片渲染图表知晓要计算哪一个分支。你可以在Select节点的细节面板中选择所需的数据类型作为输入。如果没有指定选项，数据将由 **默认（Default）** 路径传输。

示例请见下图：

## 变量和公开的属性

影片渲染图表中的大多数节点都提供了将某些属性公开为引脚的能力。这使你能够 **提升** 这些属性，从而在基础影片渲染队列界面上进行设置，而不是在影片渲染图表中进行硬编码。如果你熟悉蓝图的话，其工作原理是类似的。

这一特性对源码控制的环境尤为强大。你无需逐镜头准备图表，可以在作业级别上公开所需的参数，而无需将其硬编码到图表中。

例如，如果你想要为序列中的每个镜头设置不同的时间取样，又不想逐镜头制作影片渲染图表，这时你只需右键点击Sampling Method节点，将 **TemporalSampleCount** 参数 **公开** 到该节点的引脚即可。

然后你只需 **右键点击** 新公开的引脚，选择 **提升为变量（Promote to Variable）** 即可。

这将自动创建具有正确数据类型的变量，在本例中为整型：

这时你就可以在队列中的作业上进行设置。

你也可以使用 **分支（Branch）** 条件语句来选择要渲染的渲染图层，而无需深入图表资产。

## 脚本标签

MRG图标中的所有节点都有一个 **脚本标签（Script Tags）** 属性。你可以用它标记并整理节点，以便于管线工具使用，并使用解析图标的脚本来查找可能需要访问或修改的特定节点，这些节点可能是其所需功能的一部分。

## 移除渲染设置

可以在父图表中连接此节点，从而移除子图表中任意类型的节点。

例如，子图表中包含你不希望出现在父图表中的JPG节点。这时你就可以在父图表中连接Remove Render Setting节点，从而移除该JPG节点。

## Set Metadata Attributes节点

你可以使用 **Set Metadata Attributes** 渲染图层节点来配置自定义属性，这些属性在以该输出类型进行渲染时将作为EXR元数据被写入。元数据属性是键值对，其默认前缀为EXR。你可以使用斜杠来为元数据提供组织结构。

文件名称格式（File Name Format）可以提供动态元数据。此外，你还可以使用 **{** 键在Output Type节点上调出下拉列表。

此节点还支持脚本变形，管线可以通过Python添加节点，以实现自动化创建元数据，从而无需使用定制工具在写入EXR之后再插入元数据。

> [!NOTE]
> EXR是唯一可以接收元数据的输出类型。其他格式，如JPG、PNG和TIF都不支持元数据。

## 子图表

创建 **子图表** 是为了在源码控制的环境中为基础图表提供更大的灵活性。子图表是受独立源码控制的影片渲染图表资产，可以加载到其他父图表中并仍然应用逻辑。然后你就可以添加、附带或重载参数和/或逻辑。

下方截图中，我们使用了out_ENV渲染图层链的输出，且创建了新集合。然后我们将 **漏洞（Bugs）** 分离到了它们自己的渲染图层。该示例说明了美术师如何进行镜头级别的更改，而无需对序列级的影片渲染图表进行检出和编辑，或复制和编辑。

## 图表求值

按下活动渲染设置（Active Render Settings）选项卡上的图表求值（Evaluate Graph）按钮，即可查看图表求值的结果。

影片渲染图表的求值是从 **输出（Output）** 回溯进行的，或者说从右到左进行的。 图表的合成是从左到右的，其中最接近输出节点的节点将'胜出'，或者说具有最高优先级

要实际观察这一过程，你可以打破链条并进行重新求值，或在Branch节点上以某种方式设置默认条件状态：

## 支持的Actor类型

影片渲染图表支持渲染图层中的所有Actor类型。但在使用 **Holdouts** 和 **隐藏时影响间接光照（Affect Indirect While Hidden）** 时，部分Actor类型需要额外的考虑。你可以参考下表，了解在使用影片渲染图表时需要额外设置或考虑的Actor类型：

| Actor类型 | 支持水平 |
| --- | --- |
| **半透明Actor（Translucent Actors）** | 半透明对象上的Holdout在与雾气效果一起使用时存在局限。 |
| **Niagara** 、 **流体（Fluid）** 以及其他 **半透明效果（Translucent FX）** | 当场景中存在多个HV时，只有使用 **延迟渲染器（Deferred Renderer）才能对当个Actor应用Holdout。在使用**路径追踪渲染器（Path Traced Renderer）** 是，将场景中的一个HV设置为Holdout会导致场景中的所有HV都被当做Holdout渲染。 |
