# Media Framework快速入门指南

---
title: "Media Framework快速入门指南"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/media-framework-quick-start-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "媒体框架", "Media Framework快速入门指南"]
---

# Media Framework快速入门指南

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 媒体框架 / Media Framework快速入门指南

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/media-framework-quick-start-for-unreal-engine

*本指南结束时，您的关卡中会有一个电视在播放内容，您可以站在附近通过按键来打开或关闭电视。*

### 目的

在Media Framework快速入门指南中，我们将介绍如何设置可以在关卡中播放视频的电视（TV）。我们还使用蓝图设置TV，这样TV上的内容可以通过按按钮来打开。我们还通过 **细节（Details）** 面板公开Media Framework变量，以便快速更改TV上显示的内容。如果您是刚开始接触Media Framework工具，或者想要知道如何在关卡内的静态网格体上播放视频，本指南正适合您阅读。

> [!NOTE]
> 本指南包含一些使用[材质](../../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/index.md)和[蓝图](../../../../blueprints-visual-scripting/index.md)的设置以实现在TV上播放视频的效果。建议事先学习一些本主题的预备知识，但不是强制性要求。

### 目标

完成本教程后，开发者将掌握以下几点：

- 如何导入媒体和使用不同的媒体源。
- 如何创建包含用来播放媒体文件的媒体纹理的材质。
- 如何使用蓝图开始和停止播放媒体。
- 如何创建TV蓝图并在其中指定想要使用的媒体源。

## 1 - 项目和材质设置

1. 使用游戏分类中的 **ThirdPerson** 蓝图模板创建新项目，并为其指定任意名称。
2. 将该[样本内容](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/1f974732-44cd-4878-9ab8-00eb1b8d9e3c/sample_content.zip)提取到机器，然后将所有内容导入到引擎。

   您可以选择创建一个新文件夹来保存所有样本内容。**材质** 将根据纹理资源自动创建。
3. 在 **M_TV_Inst** 材质中，删除 **矢量参数** 节点，添加一个 **纹理样本**，并将 **样本类型（Sample Type）** 设置为 **外部（External）**。
4. 添加 **纹理对象参数**，并将其命名为 **TV_Texture**，然后通过 **Tex** 引脚连接到 **纹理样本**。
5. 对于 **TV_Texture** 参数文本对象，将 **纹理** 更改为新的 **媒体纹理** 并将其命名为 **MediaPlayer_01_Video**。

   ![undefined](../../../../../assets/images/91/910f57d03e608335837ff3ff469db73c86a325f60ff5f11489a53ad8281b92a7.jpg)

   点击查看大图。
6. 单击放大镜图标以浏览并打开 **MediaPlayer_01_Video** 资源。

   > [!NOTE]
   > 如果你要在 **Electra媒体播放器** 中使用纹理取样或纹理对象，请将 **取样器类型（Sampler Type）** 设置为 **颜色（Color）**。
7. 单击 **媒体播放器（Media Player）** 下拉菜单，并创建 **媒体播放器** 资源，将其命名为 **MyMediaPlayer**。

   当 **创建媒体播放器（Create Media Player）** 弹出菜单出现时，只需单击 **确定（Ok）** 即可，因为我们已经在上述步骤 5 中创建过了，因此不需要再创建一个 **媒体纹理**。
8. 打开 **MyMediaPlayer** 资源，然后双击 **Gideon_1080p_H264** 文件，视频将会开始播放。

   ![undefined](../../../../../assets/images/27/279ec3b1e91c8ce6acdc765cd468f6b92a5c9590ffa54b87a7e223b9d3ff451f.jpg)

   点击查看大图。
9. 在 **M_TV_Inst** 材质中，添加 **TexCoord**，并将 **VTiling** 设置为 **2.0**，然后连接到 **纹理样本** 的 **UV** 引脚。
10. 再添加一个 **TextureSample**，并将 **纹理（Texture）** 设置为 **T_TV_M2** 资源。
11. 添加一个 **LinearInterpolate** 节点，将上一步中的 **纹理** 通过 **绿色** 通道连接到 **Alpha**。
12. 如下所示连接剩余引脚。

    ![undefined](../../../../../assets/images/e7/e753254947714fa44bd3be0642fa365750c189753f3cdaafaa989c160ba8a735.jpg)

    点击查看大图。

### 分段结果

我们已经设置了材质，它将使用 **媒体播放器** 和关联的 **媒体纹理** 资源播放我们的媒体。如果我们在 **内容浏览器** 中打开TV网格体，可能会注意到屏幕显示为黑色（某些情况下为白色）。

要预览，可以打开媒体播放器资源，双击媒体源，此时媒体将在视口中的静态网格体TV上播放。

![undefined](../../../../../assets/images/b3/b38d0d2e0e26212a94dc0ab885b016af7933927543038fbb5d382869cb5356eb.jpg)

点击查看大图。

## 2 - TV蓝图 - 组件设置

在该步骤中，我们创建使用TV静态网格体的蓝图，以及让TV能够在关卡中运行所需的其余组件。

1. 在 **内容浏览器** 中，单击 **新增（Add New）** 按钮并选择 **蓝图类（Blueprint Class）**。
2. 在 **选取父类（Pick Parent Class）** 菜单中，选择 **Actor** 并将蓝图命名为 **TV_BP**。
3. 在 **TV_BP** 资源中，单击 **添加组件（Add Component）** 按钮并选择 **静态网格体（Static Mesh）**。
4. 在 **静态网格体（Static Mesh）** 的 **细节（Details）** 面板中，将 **SM_TV** 指定为要使用的 **静态网格体**。
5. 添加 **箱体碰撞** 组件，然后调节大小并将箱体移到TV前面，如下所示。

   ![undefined](../../../../../assets/images/0e/0e606fe7d89fa2629c18287de26eb6dbe2fd03bd73c9fb00548e4f6545fae299.jpg)

   点击查看大图。

   我们将使用箱体碰撞来指示当玩家位于TV前面时玩家可以打开TV（我们不希望站在TV后面时能够打开TV）。
6. 添加 **MediaSound** 组件并在 **细节（Details）** 面板中为 **媒体播放器（Media Player）** 属性分配 **MyMediaPlayer** 资源。

   这将用于在 **媒体播放器** 中播放与定义的 **媒体源** 关联的音频。
7. 在 **箱体碰撞** 的 **细节（Details）** 面板中，添加 **组件开始重叠时（On Component Begin Overlap）** 和 **组件结束重叠时（On Component End Overlap）** 事件。

### 分段结果

我们的TV蓝图设置妥当，接下来添加脚本功能，以便能够在站在TV旁边时通过按键来打开TV。

## 3 - TV蓝图 - 脚本设置

在最后一步中，我们添加脚本功能，让玩家能够按按钮来打开或关闭TV。

1. 在TV蓝图的 **事件图表** 中，使用 **获取玩家控制器（Get Player Controller）**、**启用输入（Enable Input）** 和 **禁用（Disable）** 输入，连接方式如下所示。

   ![undefined](../../../../../assets/images/83/838c2e9c45c63fcb5a351ad98e4c653ba40bc7aad387b186e5042d9e39c02bbf.jpg)

   点击查看大图。
2. 右键单击图表，添加 **P** 键盘事件（或者所需的按键），将 **按下（Pressed）** 连接到 **触发器（FlipFlop）** 节点。
3. 右键单击图表并禁用 **情境关联（Context Sensitive）**，然后添加 **打开源（Open Source）** 节点。
4. 在 **打开源（Open Source）** 节点上，右键单击 **目标（Target）** 引脚，选择 **提升为变量（Promote to Variable）** 并将其命名为 **MediaPlayerforVideo**。

   在默认情况下，媒体播放器设置为 **打开即播放（Play on Open）**，这样会在打开时播放媒体。

   > [!NOTE]
   > 对于禁用了 **打开即播放（Play on Open）** 的媒体播放器，可以使用 **播放（Play）** 节点，后跟 **打开源（Open Source）** 调用。
5. 将 **媒体源（Media Source）** 提升为变量，将其命名为 **SourceToOpen**。
6. 在 **变量（Variables）** 列表中，单击两个变量上的眼睛图标，将它们设为 **实例可编辑（Instance Editable）** 并按如下所示进行连接。
7. 添加 **结束（Close）** 节点，将其连接到 **触发器（FlipFlop）** 的 **B** 引脚，并将 **目标（Target）** 设为 **MediaPlayerforVideo**。
8. 将 **TV_BP** 拖到关卡，然后在 **细节（Details）** 面板中，分配 **MyMediaPlayer** 和 **Gideon_1080p_H264** 资源。

   我们将使用箱体碰撞来指示当玩家位于TV前面时玩家可以打开TV（我们不希望站在TV后面时能够打开TV）。
9. 在 **MyMediaPlayer** 资源中，启用 **循环（Loop）** 选项。

   这样视频开始播放后将自动循环视频，除非收到关闭指令。
10. 单击 **播放（Play）** 按钮以在关卡中播放。

### 最终结果

在关卡中播放并接近TV时，按P按钮开始播放指定的媒体。再次按P将停止播放。

## 4 - 看你的了！

下面是一些额外操作，您可以使用Media Framework工具在您的项目中尝试操作：

*让玩家[控制TV的播放](../media-framework-unreal-engine-tutorials/control-video-playback-with-blueprints/index.md)。*使用[媒体播放列表](../media-framework-unreal-engine-tutorials/using-media-playlists/index.md)作为媒体源，并允许玩家"更改TV频道"。 *向拥有自己的媒体播放器、媒体声音和媒体源资源的关卡添加第二个TV蓝图。

