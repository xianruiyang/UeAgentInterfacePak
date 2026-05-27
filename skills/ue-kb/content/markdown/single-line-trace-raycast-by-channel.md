# 使用 Single Line Trace (Raycast) by Channel

---
title: "使用 Single Line Trace (Raycast) by Channel"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-a-single-line-trace-raycast-by-channel-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "物理", "使用射线进行命中判定", "追踪指南", "使用 Single Line Trace (Raycast) by Channel"]
---

# 使用 Single Line Trace (Raycast) by Channel

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 物理 / 使用射线进行命中判定 / 追踪指南 / 使用 Single Line Trace (Raycast) by Channel

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-a-single-line-trace-raycast-by-channel-in-unreal-engine

**Line Trace By Channel** 将沿给定的线执行碰撞追踪并返回追踪命中的首个物体。以下是设置 **Single Line Trace By Channel** 的步骤。

## 步骤

1. 使用 **包括 Starter Content** 的 **Blueprint First Person** 模版创建新项目并打开项目。
2. 在 **FirstPerson/Blueprints** 文件夹中，打开 **BP_FirstPersonCharacter** 蓝图。
3. 在图表中单击右键，搜索并添加一个 **Event Tick** 节点。

   ![Add an Event Tick node](../../../../../../assets/images/a2/a25f1517a8e7740f97c6d834c475c34506e82850a58e90639e198a6c8a8a968d.png)

   这会导致追踪每帧运行。
4. 从执行引脚连出引线，然后搜索 **LineTraceByChannel** 节点。

   ![Search for the Line Trace By Channel node](../../../../../../assets/images/cf/cfdd2374c79a43d5009ef0664b29d36590733d46da7c6133a185573dfce0cc57.png)
5. 按住 **Ctrl** 键，拖入 **First Person Camera** 组件。

   ![Drag in the First Person Camera component](../../../../../../assets/images/6e/6eb6d14e8f7c49389c1710c925366814450370a0ca37a5e2148df0c305cbefaf.jpg)

   我们便会从这个摄像机开始追踪。
6. 从 **First Person Camera** 节点连出引线，添加一个 **Get World Location** 节点，然后将其连接到追踪的 **Start**。
7. 再次从 **First Person Camera** 节点连出引线，添加一个 **Get World Rotation** 节点。

   ![Add a Get World Rotation node](../../../../../../assets/images/be/be9aa4e0f8e0ee0799502b3de4758cb4b2ca27656e2b882b405c99c641665dc8.jpg)

   我们从 FirstPersonCamera 的位置开始追踪，然后获得 FirstPersonCamera 的旋转。
8. 从 **Get World Rotation** 节点连出引线并添加一个 **Get Forward Vector**，然后再从此处连出引线并添加一个 **Vector * Float** 节点，设为 **1500**。

   ![Drag off the Get World Rotation node and add a Get Forward Vector then drag off that and add a Vector Multiple Float node set to 1500](../../../../../../assets/images/d3/d3cf62568b855fa6bb3f2f70f93b0c83a5a25ce8bfc6a9199e4fbdf390ed29cb.jpg)

   获得旋转和向前矢量后，然后将其向外延伸 1500（此值为追踪的长度）。
9. 从 **Get World Location** 节点连出引线并添加一个 **Vector + Vector** 节点，然后（按下图所示）连接到追踪节点的 **End**。

   ![Drag off the Get World Location node and add a Vector Plus Vector node connecting to the End of the Line Trace By Channel node](../../../../../../assets/images/95/959bfc2a75dc4563f87bfb54df6b322997793922f3c44f2b6f6d9dbeac2846c0.jpg)

   我们在此使用 FirstPersonCamera 的位置并将其向外延伸 1500 个单位（基于其旋转和向前矢量）。
10. 在追踪节点上将 **Draw Debug Type** 设为 **For One Frame**。

    ![Set the Draw Debug Type to For One Frame on the Line Trace By Channel node](../../../../../../assets/images/83/83ecc084b429aad29ea7ebee55847ae7fe73bd408ed55fd4f2e06ab29f3a8471.jpg)

    进行游戏查看线条追踪时即可看到一条调试线。
11. 从追踪的执行输出引脚连出引线并添加一个 **Print String** 节点。

    ![Drag off the execution out pin of the Line Trace By Channel node and add a Print String node](../../../../../../assets/images/19/1982fbadac59ba993454b3d5526ee861d6ed7924ba422db8b67662d2e9e1a22b.png)
12. 从 **Out Hit** 引脚连出引线，搜索 **Break Hit**，然后添加一个 **Break Hit Result** 节点。

    > 图片已省略：Drag off the Out Hit pin and search for Break Hit then add a Break Hit Result node
13. 从（**Break Hit Result** 的）**Hit Actor** 引脚连出引线，添加一个 **To String (Object)** 节点并将其连接到 **Print String** 节点。

    > 图片已省略：undefined

    点击查看大图。

    > [!NOTE]
    > 这可以让我们调试输出追踪命中的对象。
14. 点击 **Compile** 按钮，然后在编辑器中开始游戏，查看关卡中的立方体。

    > 图片已省略：Play in the Editor and look at the cubes in the level

    此处脱离了第一人称视角，便于从追踪射线的角度查看。

    > [!NOTE]
    > 追踪命中立方体后，便会把立方体的名称显示到屏幕上。

## 最终结果

上例将返回设为对提供的追踪通道产生响应的所有物体，然而有时候可能需要只返回特定的物体。上例中，可使用 **Actors to Ignore** 引脚接收应被追踪无视的 Actor 阵列（但这意味着必须指定需要无视的每个 Actor）。

> [!TIP]
> 也可执行 **Line Trace By Object**，只返回特定的 **ObjectTypes**。这样便能以（追踪中包含的）特定物体集为目标。

