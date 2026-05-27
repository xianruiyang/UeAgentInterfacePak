# SketchUp Pro

---
title: "SketchUp Pro"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-datasmith-with-sketchup-pro-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Datasmith", "Datasmith软件交互指南", "SketchUp Pro"]
---

# SketchUp Pro

> 路径：虚幻引擎5.7文档 / 管理内容 / Datasmith / Datasmith软件交互指南 / SketchUp Pro

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-datasmith-with-sketchup-pro-in-unreal-engine

此页面介绍了Datasmith如何将Trimble SketchUp Pro中的场景导入虚幻编辑器中。它遵循[Datasmith概述](../../datasmith-plugins-overview/index.md)和[关于Datasmith导入流程](../../datasmith-import-process/index.md)中描述的基本流程，但加入了一些专为SketchUp设计的转换行为。如果你计划用Datasmith将SketchUp中的场景导入虚幻编辑器，阅读此页面可以帮助你理解自己的场景是如何被转换的，以及你该如何操作虚幻编辑器里的结果。

![SketchUp](../../../../../assets/images/79/7949c7bcbb25714001d02daf507bbad9ee2289ff4706033efab7026f2c665dea.jpg)

SketchUp

虚幻引擎

## SketchUp工作流程

### 导出流程

Datasmith对SketchUp使用 **导出插件（Export Plugin）** 工作流程。这意味着，要使用Datasmith将SketchUp内容导入到虚幻中，你需要：

1. 为SketchUp安装插件。请参阅下文的 **Installation Notes** 小节。
2. 将SketchUp内容导出为 `.udatasmith` 文件。请参阅[从SketchUp Pro导出Datasmith内容](exporting-datasmith-content-from-sketchup-pro-to/index.md)。
3. 如尚未安装，需为项目启用 **导入器（Importers）> Datasmith导入器（Datasmith Importer）** 插件。
4. 使用虚幻编辑器的工具栏上的 **Datasmith** 导入器将 `.udatasmith` 文件导入。请参阅[将Datasmith内容导入到虚幻引擎中](../../datasmith-tutorials/importing-datasmith-content-into/index.md)。

### 使用Ruby进行批量场景导出

你可以在SketchUp中运行一个Ruby脚本来批量导出 `.udatasmith` 文件。这有助于实现管线自动化。

在此之前，你需要为SketchUp安装 **Ruby代码编辑器** 插件。安装方法请参见SketchUp文档[管理扩展](https://help.sketchup.com/en/extension-warehouse/managing-extensions)。安装完Ruby代码编辑器插件后，你就可以从SketchUp的主菜单中访问它：**窗口 > Ruby代码编辑器** 。

如需从指定目录导出所有SketchUp文件，请运行以下代码：

```
            target_dir = 'C:\temp\udatasmithExports'           source_directory = 'E:\path\to\folder'           Dir.foreach(source_directory) do |filename|             ext = File.extname(filename)             if ext == '.skp' then                 name = File.basename(filename, ext)                 path = File.join source_directory, filename                 Sketchup.active_model.close true                 Sketchup.open_file path                 puts "Exporting '#{filename}' as '#{name}' to '#{target_dir}'"                 EpicGames::Datasmith.export name, target_dir           end         end 
```

你还能运行代码来导出单个文件。相当于点击Datasmith工具栏中的 **导出** 按钮：

```
        Sketchup.open_file 'E:\path\to\file\sketchup_file.skp'       EpicGames::Datasmith.export "hello", 'C:\temp'       # 这将创建C:\temp\hello.udatasmith文件。 
```

### Direct Link工作流程

为了在虚幻引擎中实时预览SketchUp的场景变化，你可以在两者之间建立Datasmith DirectLink。这样一来，你就无需在每次更改后，手动将整个场景重新导入到虚幻引擎中。更多信息，请参阅[运行时使用Datasmith](../../datasmith-tutorials/using-datasmith-at-runtime/index.md)。

> [!NOTE]
> 下述SketchUp版本只有在搭配使用4.27及以后版本的虚幻引擎时才能使用Datasmith DirectLink：
>
> - SketchUp 2020 （Windows 和 macOS）
> - SketchUp 2021 （Windows 和 macOS）

## 安装说明

导出SketchUp内容前，你必须首先下载并安装[Datasmith导出插件](https://www.unrealengine.com/zh-CN/datasmith/plugins)页面中的 **Datasmith Exporter for SketchUp** 插件。

请参阅了解该插件支持的SketchUp版本。

> [!WARNING]
> Datasmith导出插件当前仅支持SketchUp Pro。它暂不支持或者已停产的SketchUp Make。

> [!TIP]
> 我们鼓励你将Datasmith Exporter插件的下载链接分享给你的组织内部（或外部）的人员。请注意，禁止直接分发Datasmith Exporter插件本身。

在你安装Datasmith Exporter for SketchUp插件之前，请确保满足以下条件：

- SketchUp当前未运行。
- 你下载的导出插件的版本支持你的虚幻引擎版本。
- 之前安装的Datasmith Exporter for SketchUp插件已经全部卸载。

下载安装程序后，双击打开它，然后按照指示操作。

Datasmith Exporter for SketchUp插件的卸载方式类似其他软件：

- Windows系统：在 **控制面板** 中卸载该插件。
- macOS系统：在 **访达（Finder）** 中找到该插件，然后将其拖放到Dock中的垃圾桶图标上；或者，右键点击插件并点击 **移动到垃圾桶（Move to Trash）** 。

## 使用Datasmith工具栏

安装Datasmith插件后，SketchUp中会新增一个工具栏。

![SketchUp中的Datasmith工具栏](../../../../../assets/images/f2/f23c02b95056a87817f8b45656c857c9d78f51601db15bb1313a138a907eac2d.png)

Datasmith工具栏支持以下操作：

| **操作** | **按钮** | **描述** |
| --- | --- | --- |
| **DirectLink同步（Synchronize with DirectLink）** |  | 通过Direct Link将选定模型直接推送到虚幻引擎或Twinmotion。 |
| **管理连接（Manage Connections）** |  | 打开 **连接状态** 对话框。 |
| **导出至Datasmith文件（Export to Datasmith File）** |  | 打开现有的 `.udatasmith` 导出器，将一个 `.udatasmith` 文件保存到磁盘上。 |
| **显示消息（Show Messages）** |  | 打开消息和日志窗口。可查看错误、丢失纹理以及其他信息。 |

> [!TIP]
> 你还可以在SketchUp主菜单中点击 **扩展 > Datasmith** 来使用这些命令。

## 将几何结构转换为静态网格体

Datasmith将SketchUp几何结构划分为静态网格体资源，将位于同一组件或群组中的所有连接的多边形面组合起来，形成一个静态网格体。知道这种策略可以帮助你影响它所创建的静态网格体。

如果虚幻中的静态网格体非常大，那么在为场景烘焙静态或静止照明时，可能难以实现好的效果。大网格体需要同样大的光照贴图纹理，这样才能确保模型的每个部分都有足够的纹理空间来记录其照明和阴影。你可以尝试增加大静态网格体上的光照贴图分辨率，但这样也会增加烘焙时间和运行时内存要求。根据光照贴图UV的布局方式，可能完全无法实现好的效果。如果发生这种情况，可以尝试在SketchUp中将大几何结构拆分成多个组件或层，减轻虚幻中要处理的静态网格体的工作量。

### 实例化

当Datasmith检测到，同一个组件在SketchUp场景中有多个副本时，它只会为该组件创建一组静态网格体资源，并将这些静态网格体的多个实例放在场景中。这通常对运行时内存需求和项目性能更为有利，同时也更方便管理内容浏览器中的静态网格体资源数量。

但如果可能，我们建议充分利用这个功能，在SketchUp中，将场景中的重复元素（如窗户、门或椅子）创建为可重复使用的组件。

### 公告板

Datasmith会将你的SketchUp场景中的旋转公告板导出为平面的静态网格体，并将这些平面静态网格体的实例放入关卡。

关卡中每个静态网格体的朝向都基于你导出场景时SketchUp摄像机的视角。当虚幻引擎的摄像机与SketchUp的原始摄像机位于关卡中的同一位置时，平面静态网格体的现实方式将与SketchUp中的旋转公告板完全一致。但是，如果你在虚幻引擎中移动摄像机，静态网格体将不会像在SketchUp中一样更新自己的旋转角度以匹配摄像机的当前视角。

### 三角形朝向

SketchUp对几何结构的朝向没有严格要求。你可以创建"单面"几何结构（即，没有厚度的几何结构），然后从两面查看；甚至可以对每个平面的不同表面应用不同的材质。

虚幻引擎使用不同的方法：它假设所有几何结构在建模时都是有厚度的。没有朝向摄像头的所有三角形都表示一个表面的背面，并可以假设为被该表面的正面遮挡而无法看到。为了在运行时实现最可能的最佳性能，它始终 *剔除* 这些背朝三角形，避免浪费GPU周期来渲染实际上看不到的三角形。

我们建议始终构造有厚度的3D对象，这样它们就能在虚幻中正常使用。但是，如果你在SketchUp中确实使用单面几何结构，则Datasmith在静态网格体中为三角形分配材质和朝向时，会尽力以你的意图为先：

- 如果SketchUp中的表面只有一面分配有材质，则在虚幻中，将选择该表面来指定三角形的朝向。
- 否则，Datasmith将选择SketchUp中表面的正面作为虚幻中的朝向。
- 如果你为

  两面

  都指定了材质，则Datasmith仅从正面导入材质。

默认情况下，这意味着，当你从背面观察时，单面几何结构中的三角形不会出现在虚幻场景中。此外，背朝面不会投射阴影。

![SketchUp](../../../../../assets/images/18/1854ee264d71b81748c8d660a6610df45fcae2daf8c5a4b106db63be74ded744.jpg)

SketchUp

虚幻引擎

在以上示例中，每个箱体的侧面和底面朝外。在左侧，每一面的外朝面都指定有一种材质。在中间，每一面都指定有两种材质，一面一种。在右侧，为整个群组指定了红色材质，箱体的一个面专门指定了不同的材质。外朝面的颜色全部转换到虚幻，但未朝向镜头的面仅在从另一侧观察箱体时才能看到。

解决这个问题的最佳方法是在SketchUp中解决，为对象指定厚度。但是，如果你想要在虚幻中解决，也有一些其他选项。有关完整的讨论，请参阅[关于Datasmith导入流程](../../datasmith-import-process/index.md#%E4%B8%89%E8%A7%92%E5%BD%A2%E6%9C%9D%E5%90%91)。

## SketchUp材质

对于SketchUp场景中的每种材质，Datasmith都会在虚幻中新建一个对应的材质实例，以此尽可能替代原来的SketchUp材质。这些材质资产都是Datasmith在项目的"材质/主材质"目录中创建的父材质的实例。Datasmith为这些父材质中的每一个都创建了材质图表，目的是为了在虚幻引擎的PBR渲染器中产生与SketchUp相同的效果。

并非所有材质实例都有其父材质。只要有可能，如果两个不同的材质实例可以共享同一个材质图表，则Datasmith会尝试让两个材质实例使用同一个父材质。

你在虚幻中看到的材质属性取决于SketchUp材质的配置方式。你可以通过编辑父材质的PBR图来进一步添加材质属性。

> [!WARNING]
> 从SketchUp重写导入这些场景后，这些属性会被覆盖。

你可以编辑父材质，以此添加或覆盖下文中列出的属性。

### 颜色和纹理图像

默认情况下，导入的材质保持它们在SketchUp使用的纹理或颜色。你可以覆盖此设置，让你的材质使用某种纯色或纹理。

- 激活

  颜色（Color）

  选项或

  使用纹理图像（Use Texture Image）

  选项。（如果你完全看不到

  颜色（Color）

  选项，请先取消激活

  使用纹理图像（Use Texture Image）

  选项。）
- 要使用纯色，请设置

  RGB

  颜色值以产生你所需的颜色。

  ![datasmith-sketchup-material-color.png](../../../../../assets/images/7e/7e1ad92e668122c94c0226c4ee75de44a1bb3f7bea0390b339e4a5dedfa2f8ef.jpg)

  请注意，不使用A通道：透明混合由单独的不透明度（Opacity）选项控制（参见下文）。
- 如果你选择使用纹理图像，你会看到

  纹理（Texture）

  属性，你可以设置该属性以引用想要使用的纹理资源。（如果你想要使用不在虚幻项目中的纹理，将其拖放到内容浏览器中以将其导入到项目中。）

  ![datasmith-sketchup-material-usetexture.png](../../../../../assets/images/f8/f8613a89b0368e2e7a56abc80e2cf478c17f600ef4b13d82fbfe5d810ebbd20f.jpg)

  如果你需要更改纹理在表面上的平铺方式，还可以使用

  纹理缩放（Texture Scale）

  控件。

  R

  值控制水平缩放（UV空间中的U轴），

  G

  值控制垂直缩放（UV空间中的V轴）。不使用

  B

  和

  A

  值。

![不同纹理缩放设置的效果。](../../../../../assets/images/26/26b516c112710b4497f174069a42c71e1d2d5296fb11b579f6c8794359899d24.jpg)

不同纹理缩放设置的效果。

### 不透明度和混合模式

当你使用某种纯色或纹理贴图作为材质的基色时，可以使用 **不透明度（Opacity）** 控件来确定你透过静态网格体能够看到多少背景。

默认情况下，如果材质在SketchUp中的不透明度值低于100%，则该值应该会正确地转移到虚幻中的材质上。

如果你想对虚幻中之前 *不透明的* 材质指定不透明度设置，则需要更改材质的混合模式。在 **常规（General）** 部分中，展开 **材质属性覆盖（Material Property Overrides）** 群组，选中 **混合模式（Blend Mode）** 选项，并将它的值设置为 **半透明（Translucent）** 。

![SketchUp material opacity](../../../../../assets/images/34/347b2e6a33522380790419e85a0ccc606e5e58cc6e5063bf46f5c428307e3576.jpg)

点击查看大图。

### UE扩展属性

在默认情况下，所有导入的材质都设置为非金属色，均衡粗糙度值为0.5。但是，你会发现，在虚幻中稍微调整不同材质的这些值可以轻松地提高场景的渲染真实度。这些值位于 **UE扩展** 属性组中：

![UE扩展属性组](../../../../../assets/images/79/796b0f998c3418f3eebe54cbd80dbdfafda619f0735112e9ea7da20bc3c5a7b8.jpg)

- 对于任何金属物体，请选择

  金属（Metallic）

  选项。这会让底色或纹理产生极其细微的差异，从而影响照射到表面的射入光线。

> 图片已省略：默认

默认

- 如果物体表面特别粗糙或特别有光泽，选中

  粗糙度（Roughness）

  选项并增大或减小它的值。

> 图片已省略：默认粗糙度0.5

> 图片已省略：粗糙度0.05

默认粗糙度0.5

粗糙度0.05

- 如果物体的不同部分需要有不同的光泽度，你可以改用"粗糙度贴图"：这是一个灰度纹理图像，你可以将需要粗糙的部分涂成白色，需要显出光泽的部分涂成黑色。
- 有关"粗糙度"和"金属"值如何相互作用以创造出光泽表面的更多信息，还可以参阅

  创建光泽材质

  。
- 此外，你可以为导入的材质设置法线贴图。这样会给渲染器一些提示，告诉它几何结构的小规模表面细节。

> 图片已省略：无法线贴图

> 图片已省略：有法线贴图

无法线贴图

有法线贴图

你可以在Adobe Photoshop等2D图片创建软件中生成法线贴图和粗糙度贴图。在某些情况下，如以上所示纹理，你或许能够将这些法线贴图和粗糙度贴图用作材质的底色纹理。

## 元数据

你可以为自己在SketchUp中创建的每个组件设置[高级属性](https://help.sketchup.com/es/article/3000124#advanced-attributes)，如价格、大小和状态：

> 图片已省略：SketchUp Pro高级属性中的元数据

SketchUp组件或SketchUp组上的实体信息以标准[Datasmith元数据](../../using-datasmith-metadata/index.md)形式导出。虚幻引擎将在代表SketchUp组件或SketchUp组的根的Actor上存储元数据。

> [!NOTE]
> Datasmith元数据附加到的可能是在场景层级中表示你的组件的Actor，而不是表示该组件几何体的任何个体静态网格体Actor。如果你的场景中是这种情况，将需要调整[在蓝图和Python中访问元数据](../../using-datasmith-metadata/index.md#%E5%9C%A8%E8%93%9D%E5%9B%BE%E5%92%8Cpython%E4%B8%AD%E8%AE%BF%E9%97%AE%E5%85%83%E6%95%B0%E6%8D%AE)中所示的蓝图和Python示例。

