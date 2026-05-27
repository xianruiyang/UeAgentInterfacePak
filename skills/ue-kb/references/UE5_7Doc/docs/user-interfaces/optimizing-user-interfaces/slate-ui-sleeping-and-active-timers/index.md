---
title: "Slate的休眠计时器和活跃计时器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/slate-ui-sleeping-and-active-timers-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建用户界面", "优化用户界面", "Slate的休眠计时器和活跃计时器"]
---

# Slate的休眠计时器和活跃计时器

> 路径：虚幻引擎5.7文档 / 创建用户界面 / 优化用户界面 / Slate的休眠计时器和活跃计时器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/slate-ui-sleeping-and-active-timers-in-unreal-engine

Slate是一个"即时模式"的UI框架，这意味着它会在每一帧中重新绘制整个UI。这对于具有丰富的图形和动画的动态接口非常有用，但当UI中无需更改任何内容时，会导致不必要的处理器使用。在Slate中使用活跃计时器系统允许它在无需更新UI时进入休眠状态。在编辑器UI上工作时应该使用活跃计时器功能，而在UI上使用实时视口进行游戏工作时则不应该使用该功能。

对于给定帧，当以下两个条件都为true时，Slate就会休眠：

- 没有用户操作
- 无需执行活跃计时器

用户操作为任何鼠标移动、单击或按键。

下图说明了Slate应用程序现在如何进行每一帧的周期计时：

该图显示了一旦实现Slate休眠，编辑器的处理器时间如何变化。

## 活跃计时器（Active Timers）

活跃计时器是一个由控件显式注册的委托函数，它会在执行时产生一个Slate计时/绘制通道，即使在没有用户操作的情况下也是如此（即计时器的"活跃"性质）。 活跃计时器将继续以其执行周期确定的频率无限期地执行，直到取消注册为止。

原始的"Tick()"函数仍然作为一个"被动的"计时周期出现。它将像以前一样由Slate调用，但仅在Slate处于苏醒状态时。在将来的某个时候，它可能会被重命名为"PassiveTick()"， 同时"Tick()"被弃用，以更清楚地反映这一点。

要注册一个活跃计时器：

1. 使用以下签名定义一个函数：

   EActiveTimerReturnType Foo(double InCurrentTime, float InDeltaTime)
2. 将它绑定到"FWidgetActiveTimerDelegate"。
3. 将委托和计时器执行之间的时间间隔（0调用每一帧）传递给"SWidget::RegisterActiveTimer()"。

有三种方法可用于取消注册活跃计时器。

- 从委托中返回"EActiveTimerReturnType::Stop"。
- 将"SWidget::RegisterActiveTimer()"返回的"FActiveTimerHandle"传递给"SWidget::UnRegisterActiveTick()"。
- 销毁在其下注册活跃计时器的控件。

> [!NOTE]
> 当前活跃计时器是一种全是或全否的情况，因此如果需要执行单个活跃计时器，将勾选整个Slate。此外，控件可以同时注册的活跃计时器 的数量没有限制。这可能非常有用，但也引入了重复注册的可能性。为了防止这些情况，请使用以下方法之一 跟踪注册状态：
>
> - 在控件中保留一个标记，以跟踪活跃计时器是否已注册。
>
>   - 例如，在UE代码库中搜索"bIsActiveTimerRegistered"。
> - 将一个弱指针存储到"RegisterActiveTimer()"返回的"FActiveTimerHandle"，并且只在它无效时注册。
>
>   - 例如，在UE代码库中搜索"TWeakPtr ActiveTimerHandle"。
>   - 为了节省内存，只在活跃计时器需要显式取消注册时使用该方法。

## 常见用例

对于以下常见用例，下面是活跃计时器的一些推荐设置：

- **当触发某个操作时：**

  - 注册一个周期为0的活跃计时器，总是返回"EActiveTimerReturnType::Stop"。
- **当执行某种不受[FCurveSequence](#fcurvesequenceandactivetimers)控制的动画或插值时：**

  1.当惯性滚动开始时，注册一个周期为0的活跃计时器来在每一帧中更新滚动。 2.直到到达目的地时，返回"EActiveTimerReturnType::Continu"。 3.到达目标目的地后，返回"EActiveTimerReturnType::Stop"以取消注册。

  > [!TIP]
  > 惯性滚动就是一个例子；有关示例，请参阅"SScrollBox"。
- **当在一段延迟时间后执行操作时，例如打开不同的子菜单或停靠选项卡：**

  - 使用正的非零延迟注册

  > [!NOTE]
  > 活跃计时器上的周期一经注册就不能更改。要在执行之前"重置"延迟，必须显式地取消注册并重新注册活跃计时器。
- **当周期性、无限期地执行某个操作时：**

  - 使用正的非零周期注册，然后继续返回"EActiveTimerReturnType::Continue"。

## FCurveSequence和活跃计时器

"FCurveSequence"的API进行了更新，以简化在为控件设置动画时注册活跃定时周期的过程。 播放该序列现在需要对控件的引用，将通过该序列为控件设置动画。 在整个序列播放期间，将代表传递的控件自动注册一个空白活跃定时周期。 现在在播放该序列时指定该序列是否应该循环。但是，这样做会无限期地注册该活跃定时周期，所以要谨慎使用。 无论是否循环，当调用"Pause()"、"JumpToStart()"或"JumpToEnd()"时，活跃tick将注销注册。

## 测试Slate休眠

有两个控制台变量与Slate休眠相关：

- "Slate.AllowSlateToSleep"控制Slate是否可以进入休眠状态。当前，默认情况下它处于启用状态。
- "Slate.SleepBufferPostInput"指定在最后一个用户操作之后Slate将继续保持苏醒状态的时长。它默认为0。这应该只用于调试目的，因为它可能不是睡眠系统的一项永久性功能。

因为我们的目标是让可以休眠的Slate与从不休眠的Slate难以区分，所以很难判断Slate是否在休眠。目前，监视Slate的最佳方法是显示编辑器帧率 （**编辑器->杂项->显示帧率和内存（Editor Settings->Miscellaneous->Show Frame Rate and Memory）**）。当它冻结时，则Slate正处于休眠状态。
