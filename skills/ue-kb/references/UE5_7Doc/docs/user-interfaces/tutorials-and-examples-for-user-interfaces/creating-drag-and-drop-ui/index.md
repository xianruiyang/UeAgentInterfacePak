---
title: "创建拖放UI"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/creating-drag-and-drop-ui-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建用户界面", "用户界面教程和示例", "创建拖放UI"]
---

# 创建拖放UI

> 路径：虚幻引擎5.7文档 / 创建用户界面 / 用户界面教程和示例 / 创建拖放UI

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/creating-drag-and-drop-ui-in-unreal-engine

在项目中，玩家有时需要通过屏幕上的拖放操作与UI元素进行交互。这可以是自定义界面布局（放置体力条或单元框架），或与物品栏画面等游戏系统交互（添加/移除物品）。使用UMG，便可以借助 **DragAndDropOperation**节点创建这些类型的交互，并基于交互方法覆盖部分继承的蓝图函数。

在此例中，我们将实现一个玩家能用鼠标左键进行拖动和放置的体力条。在此指南的最后，您将拥有一个可以在视口中进行四处拖动、并放置到新位置的UI控件。

## 1 - 项目设置

开始之前，我们需要在项目设置阶段创建一些资源。在本示例中，需要在HUD中拖放的元素是 **HealthBar**。 为实现此功能，我们将以生命值条的形状创建一个 **DragWidget**，而不拖动实际的生命值条。这样可以将生命值条编程和拖放函数区分开来。

> [!NOTE]
> 在本操作指南中，我们现在使用 **蓝图第三人称** 模板项目。

1. 在 **内容浏览器** 中，创建三个 **控件蓝图**，分别名为：**DragWidget**、**HealthBar** 和 **HUD**。
2. 在 **内容浏览器** 中单击右键，为 **DragDropOperation** 类创建新的 **蓝图类**，命名为 **WidgetDrag**。

   这个专用蓝图类使我们能够在拖放操作的过程中传递信息。
3. 打开 **WidgetDrag** 蓝图，创建 **用户控件** 变量，命名为 **WidgetReference**。选中 **实例可编辑（Instance Editable）** 和 **生成时公开（Expose on Spawn）**。

   这将用于存放我们想要在屏幕上四处拖动的UMG控件。
4. 创建 **矢量2D** 变量，命名为 **DragOffset**。选中 **实例可编辑（Instance Editable）** 和 **生成时公开（Expose on Spawn）**。

   这会使位置从我们开始拖放控件的位置偏移。
5. **编译** 并 **保存** **WidgetDrag** 蓝图。
6. 打开 **DragWidget** 蓝图，创建 **用户控件** 变量，命名为 **WidgetReference**。选中 **实例可编辑（Instance Editable）** 和 **生成时公开（Expose on Spawn）**。
7. **编译** 并 **保存** **DragWidget** 蓝图。

项目设置完成后，接下来开始处理HealthBar控件蓝图，这是我们希望进行拖拽的UI元素。

## 2 - 设置生命值条控件

在这步中，我们将决定何时按下鼠标左键，并保存其在屏幕空间中按下的位置。我们还使用 **DetectDragIfPressed** 节点来确定玩家是否使用指定键进行拖拽。

1. 打开 **HealthBar** 控件蓝图，删除 **层级（Hierarchy）** 窗口中的 **画布面板**。
2. 添加 **缩放框**，并为这个框添加 **进度条**。在缩放框的 **细节（Details）** 面板中，将 **宽度（Width）** 和 **高度覆盖（Height Override）** 设为 **500x50**。

   您还可以通过将预览设置为 **适应屏幕（Desired on Screen）**，调整进度条的样式。然后，将 **百分比（Percent）** 设为 **1.0**，填充进度条并改变它的颜色。

### 2.1 - 编写OnMouseButtonDown功能的脚本

这一步使我们能够确定玩家是否在拖动鼠标左键。

1. 在 **事件图表** 中，添加 **OnMouseButtonDown** 和 **OnDragDetected** 覆盖。这样会为事件图表中的每个覆盖创建选项卡。

   调用自定义脚本需要置换几个函数。鼠标键按下时将进行一些检查，还将检查出现控件拖动时发生的状况。
2. 选择 **OnMouseButtonDown** 选项卡。从 **OnMouseButtonDown** 节点上 **我的几何结构（My Geometry）** 引脚拖出引线并添加 **绝对到局部（Absolute to Local）** 节点。
3. 从 **鼠标事件（Mouse Event）** 引脚拖出引线，添加 **获取屏幕空间位置（Get Screen Space Position）** 节点，并将返回值连接到 **绝对坐标（Absolute Coordinate）** 引脚。

   此操作会将生命值条控件的绝对坐标转换为局部空间，原理是 获取鼠标按钮注册按下鼠标键的屏幕位置。这样会将位置存储为变量，以便我们确定玩家实际点击控件的位置以及放下控件的位置。
4. 右键单击 **绝对到局部（Absolute to Local）** 节点的 **返回值（Return Value）**，并选择 **提升为变量（Promote to Variable）**。将变量命名为 **拖拽偏移（Drag Offset）**。

   > [!NOTE]
   > 如果看到OnMouseButtonDown节点出现错误，不必担心。编写完这个功能后，错误就会消失。
5. 在图中单击右键，并添加 **按下后检测拖拽（Detect Drag if Pressed）** 节点。将 **拖拽键（Drag Key）** 设置为 **鼠标左键（Left Mouse Button）**。
6. 完成其余引脚的连接。

   - 将

     鼠标事件（Mouse Event）

     连接到

     指针事件（Pointer Event）

     。
   - 将

     按下后检测拖拽（Detect Drag if Pressed）

     的

     返回值（Return Value）

     引脚连接到

     返回节点
   - 将四个节点的

     执行（Exec）

     引脚连接起来。

   这将确定玩家是否拖拽鼠标左键，从而启动OnDragDetected脚本。
7. 编译

   并

   保存

   HealthBar

   蓝图。

### 2.2 - 编写OnDragDetect功能的脚本

在这步中，我们将决定玩家实际在屏幕上拖动HealthBar时发生的状况。

1. 选择 **OnDragDetected** 选项卡。在 **OnDragDetected** 节点上单击右键并添加 **创建控件（Create Widget）** 节点。将 **类（Class）** 设置为 **拖拽控件（Drag Widget）**。
2. 从 **控件引用（Widget Reference）** 引脚连接 **Self** 节点。将返回值 **提升** 为变量，命名为 **已拖拽控件（Dragged Widget）** 并连接引脚。

   现在，当我们创建拖拽控件时，它将引用现有的HealthBar控件。我们还会将虚拟拖拽控件提升为变量，以便稍后访问它，并在选择放下控件时从显示画面中将它移除。
3. 单击右键并创建 **Drag & Drop Operation** 节点。将 **类（Class）** 设置为 **控件拖拽（Widget Drag）**，并将 **枢轴（Pivot）** 设为 **鼠标按下（Mouse Down）**。

   如果相对于指针拖拽，枢轴将确定在执行拖拽操作时拖拽控件显示（Drag Widget Visual）应出现的位置。
4. 将以下节点连接到

   DragAndDropOperation

   节点引脚。

   - 从

     被拖拽控件设置（Dragged Widget Set）

     到

     返回节点

     的

     执行

     线
   - Self

     到

     控件引用（Widget Reference）
   - 被拖拽控件（Dragged Widget）

     到

     默认拖拽显示（Default Drag Visual）
   - 拖拽偏移（Drag Offset）

     到

     拖拽偏移（Drag Offset）

   前文中我们说明了哪个控件蓝图是引用，拖动可视应该是什么，并提供了一个开始拖动的偏移。默认情况下，节点上有一个偏移引脚；但我们使用自己的计算来确定按下鼠标按钮时要开始偏移的位置。
5. 编译

   并

   保存

   HealthBar

   蓝图。

接下来需要确定玩家按下鼠标左键时应该发生的操作并执行OnDrop函数。

## 3 - 设置OnDrop函数

这里，我们设置主 **HUD** 控件蓝图，并覆盖我们执行 **OnDrop** 函数时要发生的操作。

1. 打开 **HUD** 控件蓝图。在 **画布面板** 的 **细节（Details）** 面板中，将 **可视性（Visibility）** 设为 **可见（Visible）**。

   我们在HealthBar控件内部编写了拖拽检测脚本；但松开鼠标左键时，我们希望将生命值条放到HUD控件蓝图中。为了让HUD接收到命中检测，需要让面板可见。
2. 在 **调色板（Palette）** 窗口中，将 **HealthBar** 控件添加到画布。
3. 在 **事件图表** 中，从 **我的蓝图（My Blueprint）** 面板添加 **OnDrop** 函数覆盖。
4. 在 **OnDrop** 节点上 **运算（Operation）** 拖出引线，并添加 **转换为控件拖拽（Cast to WidgetDrag）** 节点。然后，添加 **获取控件引用（Get Widget Reference）** 并将 **作为控件拖拽（As Widget Drag）** 引脚连接到 **控件引用（Widget Reference）** 和 **拖拽偏移（Drag Offset）** 节点。

   此操作将检查哪类操作正作为 **OnDrop** 函数的部分在执行。如果是 **控件拖拽（Widget Drag）**，我们会获得 **WidgetReference**（作为被拖拽的控件传递）以及 **DragOffset**（或开始拖拽的位置）。
5. 从 **我的几何结构（My Geometry）** 引脚，添加 **绝对到局部（Absolute to Local）** 节点。从 **指针事件（Pointer Event）** 引脚，添加 **GetScreenSpacePosition** 节点。

   这将告诉我们在2D空间中松开鼠标左键放置控件的位置。我们将用这个值减去 **DragOffset**，确定应该在什么位置放下控件。
6. 添加 **Vector2D - Vector 2D** 节点，从 **绝对到局部（Absolute to Local）** 的 **返回值** 减去 **DragOffset**。
7. 单击右键并添加 **从父项移除（Remove from Parent）**、**添加到视口（Add to Viewport）** 和 **设置视口中的位置（Set Position in Viewport）** 节点。按照以上所列的顺序将所有3个节点的 **执行（Exec）** 引脚连接起来，并将 **设置视口中的位置（Set Position in Viewport）** 节点连接到 **返回节点**。
8. 进行以下连接和调整：

   - 控件引用（Widget Reference）

     引脚连接到所有三个节点上的

     目标（Target）

     引脚。
   - Vector2D - Vector 2D

     节点的

     返回值

     引脚连接到

     位置（Position）

     引脚。
   - 取消选中

     移除DPIScale（Remove DPIScale）
   - 选中

     返回值（Return Value）

   取消勾选 **移除DPIScale（Remove DPIScale）** 并选中 **返回值**，因为无需移除[DPI缩放](../../umg-editor-reference/dpi-scaling/index.md)。我们已经处理了这个函数，因此返回为true。我们首先通过此脚本移除现有的体力条控件，然后将其重新添加到相对于Drag Offset的新位置中的画面。
9. 编译

   并

   保存

   HUD

   控件蓝图。

我们已设置HUD处理拖拽控件的放置，它还将显示体力条。接下来将设置被拖拽控件模拟体力条的外形，并对角色蓝图发出指令将 HUD 添加到视口。

## 4 - 编写Drag Widget脚本

在这一步中，配置 **DragWidget**，这是我们将拖到视口中的可视控件。

1. 打开 **DragWidget** 控件蓝图，并将 **画布面板** 替换为拥有子 **边框** 的 **缩放框**。
2. 将 **缩放框** 重命名为 **WidgetSize**，并将 **isVariable** 设为 true。选中 **宽度覆盖（Width Override）** 和 **高度覆盖（Height Override）**。

   我们将对缩放框的宽度和高度进行设置，使其成为体力条控件的尺寸。
3. 选择 **边框**，并将 **笔刷颜色（Brush Color）** 设为 **黑色（Black）**，**Alpha** 值为 **0.5**，以呈现一定的透明度。

   在本示例中，我们的生命值条轮廓为拖拽显示，同时在同一个位置保留实际的生命值条。
4. 在 **事件图表** 中，从 **事件构造** 拖出引线，添加 **转换为生命值条（Cast to HealthBar）** 节点。从 **控件引用（Widget Reference）** 连出引线，并将它连接到 **对象（Object）** 引脚。
5. 从 **作为生命值条（As Health Bar）** 引脚，添加 **获取所需大小（Get Desired Size）** 节点。将返回值连接到 **中断矢量2D（Break Vector 2D）** 节点。

   这样就获得了生命值条的大小，并可以将缩放框设置为相同大小。我们可以手动输入覆盖；但如果要更改生命值条的大小，也必须在此处更改。
6. 单击右键并添加 **设置高度覆盖（Set Height Override）** 和 **设置控件覆盖（Set Widget Override）** 节点，并将它们分别连接到 **转换为生命值条（Cast to HealthBar）** 节点。然后拖入 **控件大小（Widget Size）** 节点。
7. 连接以下引脚：

   - 控件大小（Widget Size）

     到两个

     目标（Target）

     引脚
   - 中断矢量2D

     X

     到

     输入高度覆盖（In Height Override）
   - 中断矢量2D

     Y

     到

     输入宽度覆盖（In Width Override）
8. 编译

   并

   保存

   DragWidget

   蓝图。

## 5 - 向视口添加HUD控件

最后，需要将 **HUD** 控件蓝图添加到 **角色** 蓝图中的视口并启用鼠标光标，以便能够看到拖拽位置。

1. 在 **内容浏览器** 中的 **Content/ThirdPersonBP/Blueprints** 下，打开 **ThirdPersonCharacter** 蓝图。
2. 从 **事件开始播放（Event Begin Play）** 节点拖出引线，添加 **创建控件（Create Widget）** 节点并将 **类（Class）** 设置为 **HUD**。创建 **添加到视口（Add to Viewport）** 节点并将它连接到 **设置显示鼠标光标（SET Show Mouse Cursor）**。添加 **获取玩家控制器（Get Player Controller）** 节点，并将 **返回值** 连接到 **设置目标（SET Target）**。
3. **编译**、**保存** 并单击 **运行（Play）** 按钮，以运行拖拽控件。

### 最终结果

在编辑器中运行时，可以单击左键，并将生命值条拖到屏幕上，然后将它放到新位置。

这只是开始拖放流程的一个元素范例。可能需要进行额外检查，确保玩家不会将控件拖至安全区外，或放在其他控件之上。
