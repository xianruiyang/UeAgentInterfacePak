---
title: "使用 Multi Line Trace (Raycast) by Object"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-a-multi-line-trace-raycast-by-object-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "物理", "使用射线进行命中判定", "追踪指南", "使用 Multi Line Trace (Raycast) by Object"]
---

# 使用 Multi Line Trace (Raycast) by Object

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 物理 / 使用射线进行命中判定 / 追踪指南 / 使用 Multi Line Trace (Raycast) by Object

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-a-multi-line-trace-raycast-by-object-in-unreal-engine

**MultiLineTraceForObjects** 将沿给定的线执行碰撞追踪并返回所有遭遇的命中，只返回与特定物体类型相匹配的物体。以下是设置 **MultiLineTraceForObjects** 的步骤。

## 步骤

1. 按照用于 [LineTraceByChannel](../using-a-single-line-trace-raycast-by-channel/index.md) 范例的步骤设置追踪。
2. 用 **MultiLineTraceForObjects** 节点替代 **LineTraceByChannel** 节点。
3. 从 **Object Types** 引脚连出引线并添加一个 **Make Array** 节点，然后使用下拉菜单将物体添加到阵列。

   ![Drag off the Object Types pin and add a Make Array node then use the drop-down menus to add Objects to the Array](../../../../../../assets/images/29/299622a1b4da02050617c92cae7ecf8965b3852c562b4b4dca1ae15c8e9e25c3.jpg)

   我们在此将 **WorldDynamic** 和 **PhysicsBody** 指定为物体类型。可使用 **Add pin** 按钮添加更多物体类型到阵列。
4. 从追踪节点的 **Out Hits** 引脚连出引线并添加一个 **ForEachLoop** 节点。

   ![Drag off the Out Hits pin of the trace node and add a For Each Loop node](../../../../../../assets/images/6a/6a1ec0faeabf0e4158b391e3c01e3fa6042a2fe6d0ecd4de1500d43df14cb567.jpg)

   这使我们能够对追踪命中的每个 Actor 执行操作。
5. 从 **Array Element** 连出引线并添加一个 **Break Hit Result**。然后从 **Hit Actor** 连出引线，添加一个 **To String (Object)** 并连接到 **Print String**。

   ![undefined](../../../../../../assets/images/e9/e92cf3e4b4822fe56ff95fefe16a20b13f883a3d4bd85ec20ad3b81d9f8c777a.jpg)

   点击查看大图。

   > [!NOTE]
   > 每个被阵列命中的 Actor 将被输出到屏幕。

## 结果

此处，物理 Actor（物体类型为物理形体）前方有一个悬挂的吊灯（物体类型为世界动态）。

![A hanging ceiling light World Dynamic Object Type in front of a Physics Actor Physics Body Object Type](../../../../../../assets/images/7e/7e013499f26236812c41845b3f6fb4edcb2af5cc55dfd067563e2f60d39b1b56.jpg)

**Multi Line Trace by Object** 与 **Multi Line Trace by Channel** 不同，不会在其命中的首个物体上停止，因此追踪将穿过吊灯到达立方体。
