# Meerkat演示

---
title: "Meerkat演示"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/meerkat-sample-project-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "示例与教学", "引擎功能示例", "Meerkat演示"]
---

# Meerkat演示

> 路径：虚幻引擎5.7文档 / 示例与教学 / 引擎功能示例 / Meerkat演示

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/meerkat-sample-project-for-unreal-engine

实时渲染技术是电影制作流程（从预可视化到最终渲染）中的一项工具，它的作用现在已变得越来越重要，因为它让电影制作人能够非常迅速地查看和迭代数字场景和效果。 Weta Digital发布的**Meerkat演示（Meerkat Demo）**是一部完全在**虚幻引擎**中渲染的短片，专门用于探索最高水平的画质，同时保持尽可能快的渲染速度。 如果有合适的显卡，这部Meerkat短片能够实时运行。 本文档将引导你独立使用**影片渲染队列（Movie Render Queue）**插件输出高质量渲染的Meerkat短片。

> [!NOTE]
> 此示例可用于虚幻引擎5和更高版本。 请注意，此示例是一个图形密集度非常高的场景，需要高效的显卡才能以稳定的帧率运行。

## 必要设置

要使用Meerkat示例设置项目，请按照以下步骤操作：

1. 通过**Fab**访问[Meerkat示例](https://fab.com/s/094cb6da0970)，点击**添加到我的库（Add to My Library）**，即可在**Epic Games启动器**中显示该项目文件。

   1. 或者，你也可以在启动程序的Fab中或UE的Fab插件中搜索该示例项目。
2. 在**Epic Games启动器**中，找到**虚幻引擎 > 库 > Fab库**以访问项目。

   > [!NOTE]
   > 只有在你安装了兼容的引擎版本时，示例项目才会出现在**Fab库**中。
3. 点击**创建项目（Create Project）**并按照屏幕上的提示下载示例并启动新项目。

   1. 要了解有关从Fab访问示例内容的更多信息，请参阅[示例与教程](../../index.md)。
4. 在**虚幻编辑器**中打开新项目。
5. 打开**编辑（Edit）**>**插件（Plugins）**窗口，然后导航至**内置（Built-In）**>**渲染（Rendering）**分段。 确保**影片渲染队列（Movie Render Queue）**插件已启用，必要时重启编辑器。

   ![启用影片渲染队列插件](../../../../assets/images/ba/ba214041755daf1a877a8d186894b62fe0a285fa61c715def812e02323ffe61c.png)

   启用影片渲染队列插件。 点击查看大图。

## 查看Meerkat序列

在加载虚幻编辑器并打开Meerkat演示项目之后，请转到**内容侧滑菜单（Content Drawer）**并双击**Master_SEQ**。

![Master_SEQ在内容侧滑菜单中的位置](../../../../assets/images/47/4763fc8a8fe4e63ef85d2f7845fedebb0445bebf641b921a82d75807f3185196.jpg)

这将打开**Sequencer**并加载Master_SEQ关卡序列。

![Sequencer选项卡中加载的Master_SEQ关卡序列](../../../../assets/images/03/0376a6d9f3b0803f7a7312ebe389e6bd8cb644777158bca633d7514ac48b823c.jpg)

Sequencer选项卡中加载的Master_SEQ关卡序列。 点击查看大图。

你可以通过点击时间轴，拖拉不同镜头中的时间轴。

![Master_SEQ的时间轴](../../../../assets/images/38/38c464dd73a16084cc4e71d621c2028663751a398b40681b93c612765904190d.png)

Master_SEQ关卡序列的时间轴。 点击查看大图。

如果你希望能够通过场景中设置的过场动画摄像机查看镜头，可以点击**镜头（Shots）**旁边的**摄像机图标**。 你的视口随后将通过与时间轴位置对应的摄像机来查看。

![Sequencer选项卡中的过场动画摄像机模式切换按钮](../../../../assets/images/7f/7f0eb016549804c2592830615adb2dffe4defcee5e52f1446bd62da864a7579a.jpg)

显示在Sequencer选项卡中的过场动画摄像机模式的切换按钮。 点击查看大图。

你还可以将视口模式从透视（Perspective）改为**过场动画视口（Cinematic Viewport）**。

![使用视口功能按钮更改为过场动画视口模式](../../../../assets/images/bd/bda9090935cd3cd83d337c0641093022c64eb907c33dd2bde958bd201f44b76d.jpg)

使用视口功能按钮更改为过场动画视口模式。 点击查看大图。

> [!TIP]
> 如需有关使用Sequencer的更多信息，请参阅[Sequencer编辑器](https://dev.epicgames.com/documentation/assets/animating-characters-and-objects/Sequencer/)部分。

## 优化设置

为了提高性能，Meerkat演示默认使用低分辨率设置。 如果需要最高质量视觉效果，你可以编辑几种优化设置。

### 切换高分辨率环境网格体

在**大纲（Outliner）**视图中，点击**VisualSettings_BP**蓝图。 在**细节（Details）**选项卡中的**默认（Default）**下，你将找到**高分辨率环境网格体（Highres Env Meshes）**设置。 开启设置之后，你的场景将具有更高的保真度，但在关闭后将运行得稍微快一些。

![高分辨率网格体关闭](../../../../assets/images/ae/aea76644a78913877eb2fc0efd36e23a36309e2537feaada8c8389b303c3a289.jpg)

![高分辨率网格体开启](../../../../assets/images/d0/d0b7676cd06ed4777ba3868da7f8b5f831e882451a5dc960127b69f10a4c843e.jpg)

高分辨率网格体关闭

高分辨率网格体开启

*移动滑块以比较已开启和未开启高分辨率环境网格体时的场景。*

### 更改鹰的Groom分辨率

Meerkat演示中的**鹰（Eagle）**使用**Groom**毛发资产来表示它的羽毛。 默认情况下，它使用低分辨率groom来提高性能，但是你可以将其更改为高分辨率资产。

1. 在**大纲（Outliner）**视图中，点击**角色（Characters）**组，然后选择**amlEagle_BP**并查看其**细节（Details）**选项卡。
2. 选择**Groom**属性，该属性列示在**细节（Details）**选项卡中的**amlEagle_BP(self)**下。

   > 图片已省略：细节选项卡中的Groom属性

   可以从细节选项卡访问Groom属性。 点击查看大图。
3. 此处具有**Groom资产（Groom Asset）**和**绑定资产（Binding Asset）**，每种资产的图标右侧都有一个下拉菜单。

   1. 点击**Groom资产（Groom Asset）**菜单，然后将Groom从amlEagle_groomLowRes_r036_GRO改为**amlEagle_highRes_GRO**。
   2. 点击**绑定资产（Binding Asset）**，然后将其从amlEagle_groomLowRes_r036_GRB改为**amlEagle_highRes_GRB**。

> 图片已省略：低分辨率Groom资产

> 图片已省略：高分辨率Groom资产

低分辨率Groom资产

高分辨率Groom资产

*移动滑块以比较采用低分辨率Groom资产和采用高分辨率资产的鹰。 注意羽毛上更精细的细节。*

> [!TIP]
> 如需有关使用Groom资产的更多信息，请参阅[Groom资产编辑器用户指南](../../../working-with-content/hair-rendering-and-simulation/groom-asset-editor-user-guide/index.md)。

## 使用影片渲染队列渲染Meerkat演示

要渲染Meerkat演示，你需要使用[影片渲染队列](../../../animating-characters-and-objects/cinematics-and-movie-making/movie-render-pipeline/index.md#movie-render-queue)输出高质量渲染的Sequencer影片。 请查看[必要设置](index.md#required-setup)中的步骤，以确保你启用了影片渲染队列插件，然后按照下面的步骤设置渲染任务：

1. 通过选择**窗口（Window）**>**过场动画（Cinematics）**>**影片渲染队列（Movie Render Queue）**启动影片渲染队列。

   > 图片已省略：访问影片渲染队列
2. 在**影片渲染队列窗口（Movie Render Queue window）**的左上角，点击**+渲染（+ Render）**按钮。 从下拉菜单中选择**Master_SEQ**。

   > 图片已省略：从+渲染下拉菜单访问Master_SEQ

   从"+渲染"下拉菜单访问Master_SEQ。 点击查看大图。

   这会将条目添加到影片渲染队列的**任务（jobs）**列表进行渲染。
3. 在Master_SEQ的条目中，点击**设置（Settings）**列下的**未保存配置（Unsaved Config）**以打开**设置窗口（Settings Window）**。

   > 图片已省略：点击未保存配置打开设置窗口。
4. 在设置窗口（Settings Window）中，点击右上角的**加载/保存预设（Load/Save Presets）**下拉菜单，然后选择**MoviePipelineConfig_Temporal**预设。

   > 图片已省略：选择MoviePipelineConfig_Temporal预设

   选择MoviePipelineConfig_Temporal预设，并将其应用到镜头。 点击查看大图。

你现在具有了渲染Meerkat演示所需的设置。 在"设置"窗口中，你将会在窗口左侧看到一个列表，该列表显示已经明确为此项目设置的项。 你可以编辑这些设置，以更改所渲染图像的输出目录，更改将要保存的图像类型，或者编辑后处理设置。 点击右下角的**接受（Accept）**按钮以关闭窗口。

> 图片已省略：带已应用设置的影片渲染队列设置窗口

应用了MoviePipelineConfig_Temporal中的设置的"设置"窗口。 点击查看大图。

> [!NOTE]
> 注意：上图在**设置（Settings）**窗口中显示警告图标。 点击图标可查看警告详情。 项目中的TAA示例设置为16，但警告仍然会显示。 你可以忽略此警告。

要启动渲染，请点击影片渲染队列窗口右下角中的**渲染（本地）（Render (Local)）**按钮。

> 图片已省略：渲染（本地）按钮将开始渲染你的视频

完成影片渲染队列（Movie Render Queue）窗口中的设置。 点击查看大图。

渲染预览（Render Preview）窗口将会出现，显示与渲染有关的信息。

> 图片已省略：影片渲染队列的渲染预览

影片渲染队列（Movie Render Preview）预览窗口显示与渲染进度有关的信息。 点击查看大图。

> [!TIP]
> 如需详细了解如何使用影片渲染队列，请参阅Sequencer工作流指南的[影片渲染队列部分](https://dev.epicgames.com/documentation/assets/animating-characters-and-objects/Sequencer/movie-render-pipeline#movierenderqueue)。

## 将Meerkat 控制绑定添加到镜头

此项目包括Meerkat的**Control Rig**，你可以用它在虚幻编辑器中探索某些关键帧动画。 要使用此Control Rig，需要将**amlMeerkat_BP**添加到Sequencer中的镜头。 执行此任务最轻松的方式是创建新的关卡序列。

1. 选择**过场动画（Cinematics）**>**添加关卡序列（Add Level Sequence）**。

   > 图片已省略：添加关卡序列
2. 在**资产另存为（Save Asset As）**窗口中，导航至**关卡（Levels）**文件夹，将关卡序列命名为**MeerkatAnim_SEQ**，然后点击**保存（Save）**。 你刚刚保存的关卡序列将成为Sequencer中的激活序列。

   > 图片已省略：保存新序列

   保存要用于Meerkat控制绑定的新序列。 点击查看大图。

   > [!NOTE]
   > 要返回原始序列，可以在内容侧滑菜单中找到Master_SEQ并双击它。
3. 在内容侧滑菜单（Content Drawer）中，打开**内容（Content）**>**资产（Assets）**>**meerkat**>**蓝图（Blueprints）**文件夹，然后找到**amlMeerkat_BP**资产。

   > 图片已省略：Meerkat Control Rig资产的位置

   内容侧滑菜单中的Meerkcat控制绑定资产。 点击查看大图。
4. 点击**amlMeerkat_BP**资产并将其拖到**MeerkatAnim_SEQ**。

   > 图片已省略：点击Meerkat Control Rig资产并将其拖到序列中

   点击Meerkat控制绑定蓝图并将其拖动到序列中。 点击查看大图。

你现在具有了Meerkat资产的副本以及可以在关卡序列中使用的控制绑定。

> 图片已省略：Sequencer时间轴中的Meerkat Control Rig

在Sequencer时间轴中设置Meerkat控制绑定的关键帧。 点击查看大图。

你可以在时间轴中编辑此参数，或者直接在视口中操控控制绑定。

> 图片已省略：关卡中可见的Meerkat Control Rig

在关卡视口中操控控制绑定。 点击查看大图。

> [!TIP]
> 如果你尝试使用Meerkat控制绑定但没有高端显卡，那么可以关闭groom组件的可见性以隐藏毛发，这样可以提高性能。
>
> 要实现这一目的，在你的视口中点击Meerkat，在细节面板中显示其信息。 在SkeletalMeshComponent下，点击"Groom（继承）"，向下滚动到渲染（Rendering），然后关闭Visible（可见）标记。
>
> > 图片已省略：Groom可见性复选框
>
> 在关卡视口中操控控制绑定。 点击查看大图。

