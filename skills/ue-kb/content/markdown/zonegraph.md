# ZoneGraph 快速入门指南

# ZoneGraph 快速入门指南

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/qz6r/unreal-engine-zonegraph-quick-start-guide

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 11057 字符。

## 摘要

开始使用 ZoneGraph 的指南，涵盖制作车道轮廓、设置区域形状、创建交叉口以及使用 ZoneGraph 的一些一般知识。

## 中文整理

### 实验免责声明

**** ZoneGraph 目前是一个实验性插件，随着其开发进展到后续引擎版本中的完整发布，它将对 API 进行重大更改。 ****

### 入门

### 启用插件

要为您的项目启用 ZoneGraph，请通过单击菜单栏中的 **编辑->插件** 并搜索 ZoneGraph 来添加插件。 ZoneGraph 使用两个插件，**ZoneGraph** 和 **ZoneGraph Annotations**，我们建议启用这两个插件。 **ZoneGraph** 插件包含 ZoneGraph 的主要功能。 **ZoneGraph Annotations** 插件能够在 ZoneGraph 的车道上进行运行时标记，例如障碍物或干扰。

![ZoneGraph 插件](assets/unreal-engine-zonegraph-quick-start-guide/image-01.jpg)

### 区域图概述

ZoneGraph 被设想为一种轻量级导航系统，即使在世界上无流的部分也可以进行寻路并控制导航方向。一种用例是处理行人和车辆交通，如 [城市示例项目](https://docs.unrealengine.com/5.0/en-US/city-sample-project-unreal-engine-demonstration/) 和 [黑客帝国觉醒] 中所示。演示](https://www.unrealengine.com/en-US/wakeup?utm_source=GoogleSearch&utm_medium=Performance&utm_campaign=an*3Q_pr*UnrealEng ine_ct*Search_pl*Brand_co*US_cr*Frosty&utm_id=15986877528&sub_campaign=&utm_content=July2020_Generic_V2&utm_term=ue5%20matrix)。 ZoneGraph 目前不支持运行时生成或修改底层通道，但它使用 **ZoneGraphAnnotations** 在运行时向通道添加标记，以允许出现诸如阻塞导航或应避免的危险干扰之类的情况。

### ZoneGraph Actor 概述

**区域形状** - 区域形状定义区域图通道的面积和形状。区域形状需要配置车道配置文件，该配置文件确定车道数量、标签、方向和车道宽度。 **区域图数据** - 区域图数据是为区域图构建的导航数据，类似于使用导航网格时出现的 Recast actor。 **区域图测试 Actor** - 区域图测试 Actor 用于测试两个测试 Actor 之间是否可以进行导航，类似于与 Recast 导航网格一起使用的传统导航测试 Actor。区域图测试参与者可以配置一个查询过滤器、另一个区域图测试参与者来测试之间的导航，以及在尝试导航时运行的可选测试。测试参与者还可以显示与寻路相关的其他调试信息，例如车道路径、链接车道、平滑和 BV 树查询。 **区域图注释测试参与者** - 区域图注释测试参与者允许运行任意数量的测试来模拟特定点的注释。可以创建自定义测试来满足项目的特定需求。

### 制作区域图

### 定义车道轮廓

车道剖面图在**项目设置->区域图**中创建。按“**+**”按钮创建新的车道配置文件。展开新创建的车道配置文件并在名称字段中填写“2-Way Traffic”。按 **车道** 标题上的“**+**”按钮添加新车道。将车道宽度设置为 200，方向设置为向前。将标签设置保留为“默认”。为车道轮廓创建另一个车道，并将其宽度设置为 200，方向设置为向后。

![2 路交通车道配置文件设置](assets/unreal-engine-zonegraph-quick-start-guide/image-02.jpg)

### 设置形状

将 ZoneShape actor 添加到关卡中。在“区域形状详细信息”面板中，将车道配置文件设置为使用刚刚创建的 2 路交通车道配置文件。将标签设置为使用默认标签。

![ZoneShape 配置文件设置](assets/unreal-engine-zonegraph-quick-start-guide/image-03.jpg)

当选择形状时，您可以单击 ZoneShape 样条曲线的点，以便能够编辑它们的位置或显示它们的贝塞尔手柄（如果该点配置为使用贝塞尔曲线）。通过按 **Alt** 并拖动变换手柄，向形状添加新点。或者，**右键单击**将显示一个带有**重复点**选项的菜单。创建另一个点并将其放置，使形状如下所示。

![带 90 度尖角的 ZoneShape](assets/unreal-engine-zonegraph-quick-start-guide/image-04.jpg)

为了使车道的拐角弯曲而不是急转弯 90 度，请从两个拐角创建新点并将它们移动到如下图所示。

![带角点额外点的 ZoneShape](assets/unreal-engine-zonegraph-quick-start-guide/image-05.jpg)

接下来，将顶角点移向中间，使角现在成为斜角。

![移动角点以创建斜角的 ZoneShape](assets/unreal-engine-zonegraph-quick-start-guide/image-06.jpg)

要使曲线更平滑，请更改角点以使用贝塞尔曲线作为其类型。自动贝塞尔曲线将使路径曲线平滑，但它会使两侧也稍微向外，导致比拐角更多的曲线。通过使用贝塞尔曲线手柄，可以使曲线仅影响点之间的部分。

![带贝塞尔曲线的 ZoneShape 可以制作平滑的拐角](assets/unreal-engine-zonegraph-quick-start-guide/image-07.jpg)

选择您的 ZoneShape 并复制它。将其沿 Z 轴旋转 180 度。移动新形状，使两端与原始形状相交，形成椭圆形。

![复制 ZoneShape 以制作椭圆形轨道](assets/unreal-engine-zonegraph-quick-start-guide/image-08.jpg)

### 构建ZoneGraphData

在您编辑时，区域图不会自动构建其导航数据。它是通过菜单栏中的 **Build->Build ZoneGraph** 按需构建的。您可以通过在**项目设置->区域图**中启用**编辑时构建区域图**标志来启用自动区域图构建。区域图将尝试将车道连接在一起，但它要求车道朝同一方向行驶，并且车道之间的距离和角度在设定的构建公差范围内。如果您只有一条车道，您可以在形状上启用 **Reverse Lane Profile** 标志，以将车道定向到正确的方向，而无需手动更改每个点的位置。您可以在 **Build Settings** 标题下的 **Project Settings->Zone Graph** 中手动更改这些构建设置。通过查看通道末端的 V 形，可以在编辑器中看到连接。如果 V 形为白色，则车道在区域图中相连，但如果 V 形为黑色/灰色，则两条车道不相连。

### 在 ZoneGraph 中制作交叉点

### 初始 ZoneShape 设置

添加 4 个新的 ZoneShapes 并将它们排列成十字 + 图案，如下所示。这些形状将重新使用之前创建的**双向交通**车道轮廓。

![4 路交叉口的初始 ZoneShape 设置](assets/unreal-engine-zonegraph-quick-start-guide/image-09.jpg)

### 添加多边形 ZoneShape

将新的 ZoneShape 添加到关卡中，并将 **Shape Type** 更改为使用 **Polygon**。您的新形状现在应该看起来像一条直线。设置 **车道配置文件** 以使用其他车道正在使用的 **2 路交通** 车道配置文件。您的交叉路口现在应如下所示：

![初始多边形区域形状](assets/unreal-engine-zonegraph-quick-start-guide/image-10.jpg)

接下来将左侧点移动到交点上左侧形状的末端。选择点后，将其**类型**更改为**车道轮廓**。这应该会在该点上添加一个白色 V 形，类似于连接两个形状时使用 ZoneShape 样条线时所看到的情况。它还会将当前形状更改为三角形而不是直线，如下所示： 接下来，将另一个点移动到底部形状连接点。将点的 **类型** 设置为 **车道轮廓**。请注意，多边形区域形状具有将两条车道连接在一起的曲线。选择任一点将显示类似于贝塞尔曲线手柄的手柄，可用于手动调整车道的进入角度，以便以更简单的方法将车道轮廓点与其连接样条线相匹配。 ZoneGraph** **还提供了一种在交叉点自动制作更通用的弧线的方法。设置 ZoneShape** 的 **多边形布线类型** 以使用 **圆弧**。注意曲线在相交处如何变化。构建区域图，现在该图应如下所示： 接下来，通过复制底部点并将其拖动到右侧形状，向多边形 ZoneShape 添加其他点。再次复制该点并将其拖动到顶部形状。新点需要旋转，以便它们与形状正确对齐。旋转可以通过变换工具或使用点的控制点手柄来完成。如果在进行任何旋转之前复制了两个点，则将右侧点在 Z 轴上旋转 -90 度，将顶部点在 Z 轴上旋转 -180 度。如果在添加顶点之前旋转了右侧点，则顶点只需旋转 -90 度。 ZoneGraph 交叉路口现在应该看起来像一个正确的 4 路交叉路口，从接近交叉路口的每条车道都有向左、向前和向右延伸的路径。

### 特殊多边形区域形状点设置

ZoneGraph 还允许特殊的交叉路口规则，例如不允许某些方向转弯、合并到单车道以及只有一条车道通往目的地。多边形 ZoneShape 的点也可以具有与整体形状不同的车道轮廓。使用上面的交叉点，选择底部点并从 **连接限制** 下拉列表中选中 **禁止左转** 选项。构建 ZoneGraph 以查看变化。请注意，从底部到左侧形状的左转选项不再位于交叉点。

### 其他连接限制示例

### 各种各样的

- 当使 ZoneGraph 与 MassTraffic 配合使用（如 City Sample 项目中使用的内容）时，请确保最短的 ZoneShape 比最长的车辆长。如果车辆比最短形状长，则可能会开始出现不需要的行为。 - 您可以在**项目设置-Zone Graph**中的ZoneGraph中创建自己的标签标签。这些标签与 GameplayTags 分开，并且特定于 ZoneGraph。这些标签可用于在使用 ZoneGraph 时进行查询或过滤。 - 您可以通过 ZoneShape 打开 ZoneGraph 的设置，方法是单击 **Lane Profile->Create** 或 **Edit Lane Profile**。您还可以通过单击 ZoneShape 的 **标签 -> 编辑标签** 打开设置。这两个选项都会打开**项目设置->区域图**的同一部分。 - 您可以在**项目设置->区域图**中更改**形状最大绘制距离**，以允许以更大/更短的距离绘制区域图数据。这对于查看大型图表以查看连接和流量（例如城市中的流量）非常有用。 - 您可以让 ZoneGraph 通过 **项目设置** 中的通道颜色可视化不同的标签。将显示所有 ZoneGraph 数据，但是，只有具有已配置标签的通道才会显示为彩色。车道的颜色由与区域图标签部分中的标签关联的颜色决定。您可以通过在“标签”列表中单击颜色、选择新颜色并单击“确定”来更改颜色。 - 当与 ZoneShapes 建立交叉点时，点的方向应逆时针方向进行。顺时针建造会导致出现非常奇怪的形状和车道曲线。 - 多边形 ZoneShape 点默认设置为指向多边形内部。如果您使用的车道轮廓远离多边形中心，则需要设置该点以启用 **反向车道轮廓** 标志。 - 将 ZoneGraph 与 MassTraffic 结合使用时，请确保图表中没有死胡同，因为交通“监督者”将尝试避开它们，并使车辆停在死胡同之前的车道/形状末端（请参阅 **MassTrafficMovement.cpp** 中的 **ShouldStopAtLaneExit**）。 MassTraffic 与闭环 ZoneGraph 系统配合使用效果最佳，因此在形状的末端始终有一条车道可供选择。


