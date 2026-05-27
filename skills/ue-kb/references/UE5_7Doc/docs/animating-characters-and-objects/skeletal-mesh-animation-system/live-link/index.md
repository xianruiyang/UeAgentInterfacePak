---
title: "Live Link"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/live-link-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "Live Link"]
---

# Live Link

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / Live Link

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/live-link-in-unreal-engine

Live Link的用途是提供一个通用接口，将外部来源（例如DDC工具或Mocap服务器）的动画数据流送和加入到虚幻引擎中。第三方可以通过虚幻插件对它进行扩展，无需创建和维护引擎修改即可开发新功能。

Live Link借助Motionbuilder等DDC工具，便于用户在外部编辑动画的同时在虚幻引擎中实时预览工作。动作捕捉系统还可以使用Live Link将数据流送到引擎中，以便实时预览。

## Live Link客户端

Live Link的中心是 **Live Link客户端**。在项目中启用Live Link插件时将创建客户端。它有两个主要作用：

1. 管理源

   ：这些是数据的源，主要代表与其它应用程序的连接（在同一台设备上或通过网络连接），它们将为Live Link提供数据。
2. **管理主体**：主体是客户端中的个体数据流。举例而言，一个动画角色就是一个主体。

   主体由以下数据组成：

   1. 名称。
   2. 不会变更的静态数据（例如动画角色骨架）。
   3. 一个或多个"帧"数据（例如动画角色的骨骼变换）。

客户端还负责构建引擎要使用的下一帧的数据。这可以是最新接收数据的直接拷贝，也可以是通过缓冲输入的数据、并以用户可定义的延迟播放来创建的内插帧。

**角色**

Live Link还利用 **角色** 的概念来定义应该如何使用传入的数据。这让数据能更容易映射到引擎中的目标Actor。支持的角色包括摄像机、光源、角色、变换和基本角色（用于一般数据）。

**源**

源是数据进入Live Link客户端的方式。可以在插件中对源进行定义，这样第三方无需修改引擎代码即可构建自己的源。源负责管理它们接收动画数据的方式（例如通过网络协议接收，或者从连接到机器的设备API进行读取）。每个源都拥有对客户端的引用，以便其向客户端传输数据。 我们在Live Link插件中定义了自己的源（名为 **消息总线源（Message Bus Source）**），它会从虚幻消息总线（Unreal Message Bus）连接中读取数据。我们已经用它为Motionbuilder构建了Live Link插件。

### UDP消息传递

使用Live Link消息总线源时，它会在后台使用UDP消息，并且（默认）使用它找到的第一个网络适配器。如计算机中有多个网络适配器，而希望从特定适配器接收数据，这可能会导致问题。 如要在特定网络适配器上接收UDP数据，需转到 **编辑（Edit） > 项目设置（Project Settings） > UDP消息传递（UDP Messaging）**，更改 **单播末端（Unicast Endpoint）** 来修改项目设置。

举例而言，如果有两个适配器：

- 适配器A：XX.X.XXX.123
- 适配器B：XXX.XXX.X.53

如想从网络适配器B上的Live Link消息总线源接收数据，需将单播末端设为：XXX.XXX.X.53:0

":0"指定应被列出的所有端口。

> [!NOTE]
> 游戏内不会默认启用UDP消息传递。可以通过在打包好的游戏（不支持发布目标）内添加 `-messaging` 来启用它。

## 启用Live Link

打开插件窗口（**编辑（Edit） > 插件（Plugins）**），选择 **动画（Animation）** 类别，并在Live Link插件上选择 **启用（Enabled）**，即可启用Live Link插件。

## Live Link连接窗口

启用后，就可以从 **窗口（Window）** 菜单访问Live Link客户端。

选择Live Link选项后将打开 **Live Link连接（Live Link Connection）** 窗口，可在其中添加源类型和主体。

我们可以在上方看到Live Link客户端，包括到运行插件的Maya实例的开放连接（左上角部分）。 该实例会向编辑器发送三个主体：两个摄像机主体（一个名为"EditorActiveCamera"，另一个名为"camera1"），以及一个包含变换数据的主体，名为"TestCube"（左下角部分）。

**添加一个源**

可通过 **+ 源（Source）** 按钮添加源，并选择要与Live Link连接的源类型。

> [!NOTE]
> 为将外部应用程序显示为要连接的源，需将其设为通过Live Link将数据推送至虚幻引擎。欲了解更多信息，请参阅[Live Link插件开发](live-link-plugin-development/index.md)页面。

除通过消息总线源接收数据外，Live Link还支持Magic Leap等设备的 **手部追踪（Hand Tracking）** 源，并支持创建 **虚拟主体（Virtual Subjects）**，通过此功能可以将多个主体组合成一个"虚拟主体"。 举例而言，可以选取角色A的下肢，角色B的上肢，然后将它们组合成一个新的主体。或者，可以使用来自一个源的摄像机追踪数据，与来自另一个被追踪对象的转换相结合，然后手动驱动。

在"源（Sources）"面板中，可以管理所有连接的源。也可以通过点击源旁边的 **垃圾桶** 图标来删除源。

还可以点击 **预设（Presets）** 按钮，保存或加载先前保存的任意预设。

预设会作为资产保存在 **内容浏览器** 中，便于快速加载之前的配置。

### 主体面板

Live Link连接窗口的 **主体（Subjects）** 面板显示已连接的源和正在流送至客户端的主体。

此面板显示每个主体的名称、其相关的角色以及状态指示器。绿灯表示正在接收数据。 黄灯则表示已经连接到源，但没有在指定时间段内接收到数据（可在项目设置中配置，默认值为0.5ms）。

**连接设置**

建立活跃的连接后，可使用以下设置定义连接的参数：

| 属性 | 说明 |
| --- | --- |
| 计算模式（Evaluation Mode） | 确定创建帧快照的方式。 **引擎时间（Engine Time）**：源将使用引擎的时间来计算其主体。需要保持动画流畅时，这种模式最为实用。 **最新（Latest）**：源将使用可用的最新帧来对其主体进行计算。该模式不会尝试任何类型的内插或时间同步。 **时间码（Timecode）**： 源将使用引擎的时间码来计算其主体。当源需要与多个其他外部输入同步时（如视频或其他时间同步源），此模式最为实用。 引擎未设置时间码提供程序时，不应使用此模式。 |
| 有效引擎时间（Valid Engine Time） | 如果该帧早于ValidTIme，则将其从缓冲列表中删除（单位为秒）。 |
| 引擎时间偏差（Engine Time Offset） | 用时间计算时，对缓冲区的读取应从当前时间回溯多久（单位为秒）。 |
| 时间码帧率（Timecode Frame Rate） | 用时间码计算时，时间码的预期帧率为何。 |
| 有效时间码帧（Valid Timecode Frame） | 如果该帧时间码早于ValidTimecodeFrame，则将其从缓冲列表中删除（以TimecodeFrameRate的速率）。 |
| 时间码帧偏差（Timecode Frame Offset） | 用时间码计算时，对缓冲区的读取，应从当前时间码回溯多久（以TimecodeFrameRate的速率）。 |
| 需缓冲的最大帧数（Max Number of Frame to Buffered） | 定义需要在内存中保留的最大帧数。 |
| 源调试信息（Source Debug Infos） | 从源传递的调试信息的集合。 |

**内插设定**

添加主体后，可将任何 **预处理器（Pre Processors）**、**内插（Interpolation）** 方法或 **平移器（Translators）** 指定到选中的主体。

| 属性 | 说明 |
| --- | --- |
| 预处理器（Pre Processors） | 此属性适用于在将传入的数据推送到给定帧的主体之前对其进行处理。一种可能的使用情况是 **轴切换（Axis Switch）**，它会将输入变换的任意轴与另一个轴进行切换。 |
| 内插（Interpolation） | 定义用于混合帧的内插方法类型。 |
| 转换器（Translators） | 用于将数据从一个角色转换到另一个角色。举例而言，如果想要将数据从骨架转换为变换。如果只需要获取角色臀部的位置，此属性应十分实用。它会把数据转换成正确的角色。 |

## 编辑器整合

当前版本中，动画编辑器内部整合了Live Link。可以在 **预览控制器（Preview Controller）** 属性下的 **预览场景设置（Preview Scene Settings）** 选项卡中访问。

启用Live Link插件后，预览控制器选项可以更改为 **Live Link预览控制器（Live Link Preview Controller）**。选择后，可对以下选项进行设置：

- 主体名称（Subject Name）

  ：在Live Link中应用于预览网格体的主体名称。
- 启用摄像机同步（Enable Camera Sync）

  ：启用虚幻编辑器摄像机与外部编辑器的同步。从内部来看，这是一个名为

  EditorActiveCamera

  的主体的Live Link。我们内部开发的Motionbuilder插件为它提供了支持。
- 重定向资产（Retarget Asset）

  ：指定应用于Live Link数据（该数据将被应用到预览网格体）的重定向资产。

### Live Link组件

将 **Live Link控制器（Live Link Controller）** 和 **Live Link骨骼动画（Live Link Skeletal Animation）** 组件添加至Actor，可以实现从连接的外部源通过Live Link驱动其参数。

要使用这些组件，请点击 **添加组件（Add Component）** 按钮，并使用Live Link控制器（或Live Link骨骼动画）组件。

对于Live Link控制器，可以在 **细节（Details）** 面板中使用 **主体表示（Subject Representation）** 属性，并从连接的主体中进行选择。系统将根据主体自动指定角色（必要时可进行修改）。**要控制的组件（Component to Control）** 实际上是通过Live Link驱动的。 在下方的示例中有一个具备Live Link控制器组件的电影摄像机Actor，我们可以利用它来移动摄像机，并在MotionBuilder中改变焦距。我们还在骨架网格体上使用了Live Link骨骼动画组件，并流入了动画数据。为了实现这一点，我们在动画蓝图中添加了 **Live Link姿势（Live Link Pose）** 节点，并且选择了我们的主体。

> [!NOTE]
> Live Link控制器能够控制动画，为获得最佳效果，建议将Live Link骨骼动画组件用于动画。

### 蓝图中的Live Link

也可使用蓝图函数调用来访问Live Link数据。下方，**计算Live Link帧（Evaluate Live Link Frame）** 函数尝试了使用给定角色从指定主体获取Live Link帧（下方的示例访问了主体"camera1"和摄像机的角色）。

然后，我们可以从数据结果中获取帧数据，本例是从我们的主体中获取变换信息。随后，此信息会被用于在蓝图中更新电影摄像机的相对变换。

## 动画蓝图

来自Live Link的数据可以直接应用于动画蓝图中：

在动画蓝图的动画图表中创建 **Live Link姿势（Live Link Pose）** 节点即可实现这一点。该节点有两个属性：

- 主体名称（Subject Name）

  ：Live Link中流送数据来源的主体名称
- 重定向资产（Retarget Asset）

  ：用于将Live Link中的数据应用至动画蓝图所使用骨架的重定向资产。

Live Link Pose节点的输出和动画蓝图中的任何其他姿势节点一样，都是普通姿势，因此可以像其他姿势一样进行操作（例如输入修饰符或混合节点）。

> [!NOTE]
> 在编辑器中，虽然可以不使用Live Link Pose节点驱动动画，但如果想在运行时驱动动画，则需要在动画蓝图中设置Live Link Pose节点。

## 插件开发

与Live Link整合的路径有两条：

- 构建一个虚幻引擎插件，将一个新源对Live Link公开。

此方法推荐给已拥有自身流送协议的开发者。

- 在第三方软件中整合一个消息总线（Message Bus）终端，使其成为内置消息总线源的数据传输器。

此法我们已用于Motionbuilder插件。

> [!NOTE]
> 欲知更多详情，请参阅[Live Link插件的开发](live-link-plugin-development/index.md)页面。

## Motionbuilder Live Link插件

Motionbuilder插件以与标准Live Link链接类似的方式，在编辑器中显示为连接。它还拥有用于管理流送的自定义用户界面：

可以在当前场景中选择对象，并将其添加到流送列表中（如上所示）。从列表中，可以在 **主体名称（Subject Name）** 列中设置它们的名称，并且可以设置它们的 **流送类型（Stream Type）**（例如摄像机、骨架）。也可以从列表中启用和禁用主体的流送。

可以从虚幻引擎4的GitHub元库下载[Motionbuilder Live Link插件](https://github.com/ue4plugins/MobuLiveLink)的二进制文件。

> [!NOTE]
> 欲知设置Motionbuilder Live Link插件的分步指南，请参阅[使用Live Link整合UE4与Motionbuilder](live-link-stream-motionbuilder-to/index.md)操作指南。
