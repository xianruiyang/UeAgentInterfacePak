# Scene State

---
title: "Scene State"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/scene-state-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "动态设计", "Scene State"]
---

# Scene State

> 路径：虚幻引擎5.7文档 / 动态设计 / Scene State

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/scene-state-for-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

## 什么是 Motion Design Scene State？

**Motion Design Scene State（动态设计场景状态）** 是一个面向广播图形的状态机插件，用于将行为封装到 state 中。该插件的主要目标，是提供一种方式在图形内部隔离不同行为，同时定义这些行为与 state 之间的关系，从而更轻松、更可维护地构建逻辑。

该插件本身被设计为可在 Motion Design level 之外使用。另一个插件 **Motion Design/Scene State Integration（动态设计场景状态集成）**用于将 scene state 集成到 Motion Design level，并提供 Motion Design 专用 task。

> [!TIP]
> 如果熟悉 Animation Blueprint 中的状态机，Motion Design Scene State 中的很多元素会比较熟悉。不过请注意，这两个系统完全不同，设计目标也不同。

## 概述

![Scene State User Interface](../../../assets/images/65/65f18df8eedbfd437fcc9c6bd54b7b28beadc4b3eca8ce0f7d9ca70d40960ac4.jpg)

1. State Machine List 标签页

   - 列出 Scene State Blueprint 中存在的所有 state machine。
   - 点击“Add”按钮可添加新的 state machine。
   - 选择一个 state machine，可在 details view（4）中查看和编辑其设置。
   - 双击 state machine 可在 graph view（7）中打开它。
   - 拖动 state machine 可重新排序并分类。
2. Debug View 标签页

   - 被调试 Scene State object 的视点。
   - 对于 Motion Design Scene State object，该视点是 game viewport。
   - 可以从 debug toolbar（3）更改被调试对象。
3. Play World 与 Debug Toolbar

   - 以指定模式播放当前 world（PIE、Standalone）。
   - 设置被调试对象，以检查该对象的 scene state 行为和数据。
   - 可在 graph view（7）和 debug controls（8）中可视化 Scene State 的行为和数据。
4. Details View 标签页

   - 当前所选 editor object 的 Property editor 标签页。
   - 该对象可以是 state、state machine、transition、task，也可以是变量、函数、宏等 Blueprint node。
5. Property Binding Extension（属性绑定扩展）

   - Details view 的扩展，用于将 target property 绑定到 source property 或 property function。
   - 例如，source property 可以是 Blueprint variable。
   - 它只适用于可绑定的 property。
6. My Blueprint 标签页

   - 与其它 Blueprint 一样，它保存该 Blueprint 的变量、函数、事件和其它节点。
   - 点击 Add 按钮可添加新变量、事件、函数或其它节点。
7. Graph View（图表视图）

   - 显示当前打开的 graph。
   - 这些 graph 可以是 state machine graph、transition graph，也可以是 function graph 或 event graph 之类的 Blueprint graph。
   - 播放时，它会显示当前被调试对象的执行流。
   - 可以从 debug toolbar（3）更改被调试对象。
8. Debug Controls（调试控件）

   - 向当前被调试对象发送 event，或更改其数据，以检查播放期间的行为变化。
   - 可以从 debug toolbar（3）更改被调试对象。

### State（状态）

**state（状态）**是 state machine 中的基础对象。在一个 state machine 中，同一时间只能有一个 state 处于 active 状态。一个 state 可以拥有 task、指向其它 state 的 transition（称为 exit transition）、子 state machine 和 event handler。每一项都会在各自章节中说明。

当 state 变为 active 时，该 state 会存储 event handler 所需的 event data（如果有），并且 task graph 与子 state machine 都会开始执行。

![State node](../../../assets/images/59/59197af0f84e33e909f2b61fab2ad868617b66700f2ae9fccad4e6b5846ea316.png)

### State Machine（状态机）

**state machine（状态机）** 是 scene state system 中执行的基础起点。顶层 state machine 具有 Run Mode property，可设置为 Auto 或 Manual。

- **Auto**表示 scene state system 启动时，state machine 也会启动。这是默认选项。
- **Manual**表示 state machine 不会自动启动，而是可通过 Run State Machine task 等其它方式启动。

![State machine category and run mode](../../../assets/images/86/86c9700ead5277cf8f4acb2e9d03e3ebe1e8ab21197789484bc246d45d88bab7.png)

![State machine graph](../../../assets/images/f2/f2c9262fc88d33eb5d4cdee10d20a488db2f6c97576388278f0b0cb0347aa5e3.jpg)

由于底层 scene state 架构，同一个 state machine 可以同时执行多次，每次执行都分别管理自己的 instance data。

State Machine 也包含 parameter。更多信息请参阅 [State Machine Parameters（状态机参数）](index.md#state-machine-parameters).

### Entry（入口）

**entry（入口）**用于告诉所属 state machine 在启动时首先激活哪个 state。在一个 state machine graph 中只会考虑一个 entry node。

![Entry node](../../../assets/images/8e/8e8061af2d97ab0c6199f7a81da51a2f35a9dae515732bcab0b5c9fdd889f04a.png)

### Exit（退出）

**exit（退出）**用于指示 state machine 结束执行。它是可选的，因此一个 state machine 可以没有 exit，也可以有多个 exit。Exit 可以作为 transition 的目标，但不能作为源，因为一旦执行到某个 exit 的 transition，所属 state machine 的执行就会停止。

![Exit node](../../../assets/images/90/90dde75f84af9d330264b9ff8cfae7628c88bc87f0f0bb4fb7c87bbb233691d1.png)

### Task（任务）

**task（任务）**是 scene state system 中主要的可实现对象。它保存运行时要执行的具体逻辑。内置示例包括 Print String、Delay 等。可以用 C++ 或 Blueprint 实现 task，但 C++ 更推荐，因为它对逻辑和 instance data 的区分更清晰，性能和内存效率也更好。

一个 task 只能由一个 state 拥有。当所属 state 处于 active 状态，且 prerequisite task 都已完成时，task 才会开始执行。这些 prerequisite task 也由同一个 state 拥有。

![State task graph](../../../assets/images/96/96b2bd1e17b42f683ffba744be6b6f8d4f0c1363ea6b2842512e26d03a484ac3.png)

在上例中，state 拥有三个 task：Print Red、Print Blue 和延迟 task Wait 1s。只有 Print Blue 拥有 prerequisite task，即 Wait 1s 延迟 task。这意味着一旦 state 变为 active，Print Red 和延迟 task 会在同一帧执行，而 Print Blue 会在等待一秒结束后执行。

拥有多个 prerequisite 的 task 只有在所有 prerequisite task 完成后才会执行。

### Transition（转换）

**transition（转换）**定义从 source 到 target 的链接。source 和 target 通常是 state，但也可以是 conduit 或 exit（exit 只能作为 transition 的 target）。

![State machine transition](../../../assets/images/a5/a50d1ee9dda894e2ee7a202645652d07285b0c4dacf515a305dcd8f1126ffff9.png)

> 图片已省略：State machine transition settings

Transition 具有 priority value。从同一个 state 或 conduit 离开的 transition 会按优先级从高到低求值。第一个满足条件的 transition 会被执行。如果 transition 指向另一个 state，则 source state 变为 inactive，target state 变为 active。如果 transition 指向 exit，则所属 state machine 停止执行。如果 transition 指向 conduit，则对该 conduit 求值（会继续求值其 exit transition，并重复这一过程）。

transition 有一个 **Wait for tasks to finish** 选项。启用后，必须等 state 的所有 task 完成，才会考虑该 transition。

> 图片已省略：State machine transition to an event

如果 transition 的目标 state 需要先 push 或 broadcast 某些 event，则该 transition 也会检查这些 event 是否存在于 stream 中。如果不存在，该 transition 在这次求值中不会被考虑。在上例中，只有 Event X 存在于 event stream 中时，State A 到 On Event X 的 transition 才能发生。关于 event 的更多信息，请参阅 [Event（事件）](index.md#event).

#### Transition Graph（转换图表）

> 图片已省略：Transition graph

**Transition graph** 是以 boolean 作为结果的 Blueprint graph，用于决定 transition 是否可以发生。因为它需要经过 Blueprint system，所以在求值 transition 时最后执行。如果其它条件不满足，transition graph 根本不会执行。

此外， **Can Transition** 设置为 true 时会明确编译为无 Blueprint 开销。 Can Transition 设置为 false 的 transition graph 完全不会编译，因此 transition link 不会存在于编译后数据中.

Transition 拥有可供 transition graph 使用的 parameter。更多信息请参阅 [Transition Parameters（转换参数）](index.md#transition-parameters).

### Conduit（中转）

**Conduit（中转）**是 transition 的间接层，可保存多个指向其它 target 的 exit transition。一个 conduit 可从多个 state（或其它 conduit）连接，从而在相同 transition 和规则可跨多个 state 复用时减少 transition link 数量。

与 transition 类似，当 conduit 的某个 source state 在 state machine 中处于 active 状态时，该 conduit 就会变得相关。Conduit 还有额外的 condition graph，用于决定该 conduit 是否启用。

> 图片已省略：Complex transitions

> 图片已省略：Simplified conduit

上例展示了使用 conduit 的好处。两个 graph 都表达了 graph 中每个 state 都可 transition 到其它 state。conduit 版本将 transition link 数量从十二个减少到八个，同时提高清晰度。添加的 state 越多，transition link 减少带来的收益越明显。

### Event（事件）

当 scene state system 外部发生需要关注的事情时，它可以向 scene state system 的 event stream push 一个 **event（事件）**，以便系统处理。

event 由 **event schema（事件模式）** 创建，event schema 保存一个名称和可选的用户定义 struct。这些 event schema 保存在 **Event Schema Collection（事件模式集合）** 资产中。下面的示例展示了一个包含两个 event schema 的集合：

- Event X 没有 property。
- Event Y 有两个 property。

> 图片已省略：Event schema collection

#### Event Stream（事件流）

**event stream（事件流）** 是特定 scene state system 的 event 队列。event 可以直接 push 到 event stream，也可以 broadcast 到特定 context；该 context 中的所有 event stream 都会向自己的 stream push 该 event 的一个副本。

> 图片已省略：Event stream

broadcast 或 push event 的主要方式之一，是使用同时提供以下节点的 Blueprint API： **Broadcast Event** and **Push Event** 。Broadcast Event 只需要一个 world context object（例如 actor、component 或类似对象），而 Push Event 需要显式指定要 push 到的 stream。

这些 event node 会自动创建与 event payload struct 匹配的 pin。在上例中，Broadcast Event: Event Y 节点会自动添加 Property A 和 Property B pin，以匹配 Event Y 的 payload struct。

### Event Handler（事件处理器）

**Event handler** 是拥有 stream 中特定 event 的对象。这称为 capture event。当 event 被某个 handler capture 后，它不再对 stream 中的其它 handler 可见，只能由 capture 它的 handler 访问。

Event handler 由唯一 ID 和 event schema 的 handle 组成，因此由该 event schema 创建的任何 event 都可能被该 event handler capture。

如上所述，可以为 state 设置 event handler。当 state 被激活时，它会通知所有 event handler capture 与其匹配的 event。这些 captured event 持有的数据随后会由 property binding system 转发给系统中的 task。关于此绑定机制的更多信息，请参阅 [Property Binding System（属性绑定系统）](index.md#property-binding-system).

> 图片已省略：State machine event handler

在上例中，On Event Y state 拥有 Event Y schema 的 handler，因此它的 task（例如 Print String task）可以绑定到 Event Y 的 payload data，这里可以是 Property B。当 Event Y 被 push 到 stream 时，它在 Property B string 中包含数据，并会复制到 Print String 的 Message 参数。

### Property Binding System（属性绑定系统）

像 Print String 这样的简单 task 有一个 Message parameter，可直接在 Details panel 中设置。但在真实场景中，task 通常需要固定值之外的数据。该值可以来自 Blueprint variable、event 或其它来源。

可以使用 **property binding system（属性绑定系统）** 解决此问题。它会将 source data 绑定到 target data。对于 task，target 是 task instance data 本身。在上面描述的示例中，此处的 target struct 是包含 message parameter 的 struct。task 的 source data 可以是 Blueprint variable、所属 state 中由 event handler capture 的 event、所属 state machine 的 state machine parameter，或 property function 的结果。

> 图片已省略：Proeprty binding variable data source

> 图片已省略：Property binding in the state machine

> 图片已省略：Property binding data bound to task

上例展示了如何将 Scene State Blueprint 中的 SourceMessage 变量绑定到 Print String task 的 Message parameter。

这些绑定会在 task 开始执行前应用一次。绑定是复制操作，因此对于处理 Message parameter 的 Print String，它处理的是 SourceMessage 在当时的值副本。Print String 会立即执行逻辑，但对于稍后处理数据的 task，它们复制的 source data 可能已经改变，而随后处理的只是 task 开始时 source data 的副本。更多信息请参阅 Property Functions。

如 Event Handler 部分所述，如果 state 拥有 event handler，表示只有必要 event 存在于 stream 中时，该 state 才能被激活。如果向 state 添加 event handler，则该 state 知道被激活时 event data 一定存在，因此该 event data 可作为绑定 source：

> 图片已省略：Event handler property binding

### Property References（属性引用）

**Property reference** 让 binding system 能够以引用而不是复制的方式处理 property。这意味着 task 不仅可以减少大型 struct 的复制操作，还可以写回 property。

> [!NOTE]
> 目前 property reference 仅限在 C++ task 中使用，但计划支持 Blueprint Task。

> 图片已省略：State machine print Hello World!

上例展示了 Set String task，它是多个 setter task 之一，其中 Target parameter 是 property reference。在该示例中，运行该 task 会将 Source Message 变量设置为“Hello World!”。

此外，也可以在 State Machine parameter 等 parameter 中使用 property reference：

> 图片已省略：Setting state machine parameters

> 图片已省略：State machine parameters

### Property Functions（属性函数）

如果 source data type 兼容且格式可供 task 使用，直接绑定到 property 会很有效。如果不是这种情况，要么需要更改 source data 使其可供 task 使用，要么需要额外 custom task 来处理。这两种方案都不理想。

**Property function** 是在应用 property binding 之前执行的一层逻辑。这些 function 在 source data 和 target data 之间进行转换。

> [!NOTE]
> 目前 property function 只能用 C++ 实现。

例如，Integer to String 这样的 property function 可将 integer 类型的 source data 输入到 task 的 string parameter 中。这些 function 可在同一个 property binding 菜单中找到，其可用性/可见性取决于 target property type：

> 图片已省略：State machine set property function source data

> 图片已省略：State machine set property function target data

> 图片已省略：State machine complete property function

在上例中，由于 target property Message 是 string，因此只显示 string function。Integer to String function 用于绑定到 Count integer 变量。

Property function 可以解锁各种能力。例如，结合 property reference，可以使用 Integer setter task 递增 Count integer 变量：

> 图片已省略：State machine use property function

下面可以看到多次激活 State A 以重新运行其 task 后的结果：

> 图片已省略：State machine property function output

### State Machine Parameters（状态机参数）

state machine 可以拥有 **parameter（参数）**.

> 图片已省略：State machine parameters

使用 **Run State Machine** task 执行 state machine 时，可以编辑这些 parameter。在下面的示例中，同一个 state machine 运行了两次，但传入了不同 parameter。

> 图片已省略：State machine parameters version 1

> 图片已省略：State machine parameters version 2

这些 state machine parameter 可用于 task 和 transition parameter 的绑定：

> 图片已省略：State machine using parameters

### Transition Parameters（转换参数）

与 state machine parameter 类似， **transition（转换）**也拥有 **parameter（参数）**。transition 拥有 parameter 的主要原因，是在 transition graph 与可通过 property binding system 访问的数据之间建立桥接，例如 state machine parameter、event 等。

> 图片已省略：State machine transition parameters

随后可在 transition graph 中使用 Transition Parameters node 访问这些 parameter：

> 图片已省略：Transition graph parameters node

