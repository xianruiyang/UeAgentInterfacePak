# 适用于拥挤 AI 的 NavLink 代理系统

# 适用于拥挤 AI 的 NavLink 代理系统

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/Z6P/unreal-engine-navlink-proxy-system-for-crowded-ai

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 3251 字符。

## 摘要

虽然使用 NavLink Proxy 让 AI pawn 在导航网格中的间隙上攀爬/移动并不是那么困难，但在更拥挤的场景中可能会让人头疼。本教程旨在向您展示如何准备 navlink 代理并解决此问题。

## 中文整理

### 概览

当 AI 使用 navlink 代理作为路径时，它可能看起来已被占用，但它不会阻止后续 pawn 使用它。这最终可能会导致后面的 pawn 卡住、滑动，甚至移出导航网格。为了防止这种情况发生，我们将在自定义导航链接代理 BP 中使用导航修改器组件来暂时断开链接。首先，我们创建一个源自 NavLinkProxy 的新蓝图。

![教程图片](assets/unreal-engine-navlink-proxy-system-for-crowded-ai/image-01.jpg)

接下来，我们在自定义的 Nav Link Proxy BP 中添加一个 Nav Modifier 组件。

![教程图片](assets/unreal-engine-navlink-proxy-system-for-crowded-ai/image-02.jpg)

调整链接的开始和结束位置，如下所示。这为我们提供了一个用于 1 米高攀爬的链接。您可以通过移动简单链接左右点的菱形小部件来在关卡中进行调整 - 不要忘记单击“将端点从简单链接复制到智能链接”按钮来更新链接。

![教程图片](assets/unreal-engine-navlink-proxy-system-for-crowded-ai/image-03.jpg)

对于 Nav Modifier 的大小，30、30、150 基本上就足够了。如果它没有删除足够的导航网格来断开链接，请根据您的导航网格属性进行调整。

![教程图片](assets/unreal-engine-navlink-proxy-system-for-crowded-ai/image-04.jpg)

在您的 pawn BP 中，将场景组件添加到胶囊组件的底部。我们稍后将使用它来计算我们位于链接的哪一侧。

![教程图片](assets/unreal-engine-navlink-proxy-system-for-crowded-ai/image-05.jpg)

现在我们可以告诉我们的自定义导航链接要做什么。创建接收智能链接已达到事件。

![教程图片](assets/unreal-engine-navlink-proxy-system-for-crowded-ai/image-06.jpg)

当 pawn 将此导航链接代理作为其路径并到达其其中一个点时，会触发此事件，并且它会给出当前位于此链接上的 pawn 以及它要移动到链接的哪个点。

![教程图片](assets/unreal-engine-navlink-proxy-system-for-crowded-ai/image-07.jpg)

我们设置了两个条件来确保只有第一个 pawn 到达这里，然后设置第三个条件来确保路径不会因掉落而中断（这个条件非常具体，具体取决于您正在制作的游戏。您很可能不需要此检查。）我们将在该图的其余部分之后回到 Reset 事件。

![教程图片](assets/unreal-engine-navlink-proxy-system-for-crowded-ai/image-08.jpg)

一旦我们确保我们在此链接上处理相同的 Pawn，我们就禁用智能链接，并将导航修改器区域类设置为 Null。这将产生一个间隙，该间隙将破坏链接，并通过路径到下一个最近的链接或导航网格上目标的关闭点来刷新以下 AI 的路径。然后，我们通过创建的自定义事件（攀爬）向 pawn 发送必要的信息，最后我们在延迟后重置智能链接和导航修改器 - 此延迟是一种故障保护，以防 pawn 的攀爬功能以某种方式中断，因此链接可以再次有用。延迟应该比 pawn 的攀爬动画长一点。当 pawn 获得攀爬命令时，我们使用下图。

![教程图片](assets/unreal-engine-navlink-proxy-system-for-crowded-ai/image-09.jpg)

![教程图片](assets/unreal-engine-navlink-proxy-system-for-crowded-ai/image-10.jpg)

这里有两件重要的事情；您需要使用根运动动画进行攀爬，并且为了使用它们，您需要在动画期间将运动模式更改为“飞行”。否则根运动将忽略 Z 轴上的运动。就是这样。您可以在模拟模式下测试代理和显示导航网格（热键 **P**）的 pawn 的行为。希望这对像我这样使用蓝图完成大部分编码并且无法在 C++ 中编写新的路径系统/修改 NavLink 代理的人有所帮助。

