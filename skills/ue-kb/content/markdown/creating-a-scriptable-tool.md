# Creating a Scriptable Tool

---
title: "Creating a Scriptable Tool"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/creating-a-scriptable-tool-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "编辑器的脚本与自动化", "使用蓝图编写编辑器脚本", "可脚本化工具系统", "Creating a Scriptable Tool"]
---

# Creating a Scriptable Tool

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 编辑器的脚本与自动化 / 使用蓝图编写编辑器脚本 / 可脚本化工具系统 / Creating a Scriptable Tool

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/creating-a-scriptable-tool-in-unreal-engine

本指南展示如何创建一个 **Scriptable Tool** 。该工具会在关卡中点击时生成新的 dynamic mesh sphere，并在工具用户界面（UI）中提供 radius 属性。

可以使用任意关卡或项目，但本教程最终得到的 Scriptable Tool 需要可点击的 geometry。建议使用 [Third Person Template](https://dev.epicgames.com/documentation/404) 创建新项目。

## 前置知识

为了更好理解和使用本页内容，建议：

- 对以下内容有基础理解：

  Blueprint

  .
- 熟悉以下入门主题：

  Scriptable Tools

  .

## 启用插件

要使用 Scriptable Tools editor mode 并访问相关节点，必须启用对应插件。本指南中的若干函数会使用 Geometry Script，它也需要插件。

要启用插件或验证插件已启用，请执行以下步骤：

1. 在

   菜单栏

   中选择

   Edit > Plugins

   .
2. 在搜索栏中输入“scriptable tools”。
3. 启用 **Scriptable Tools Editor Mode**插件，并在对话弹窗中选择 **Yes** 以重启编辑器。

   1. 不需要启用 Scriptable Tools Framework 模块。editor mode 会自动包含它。

   ![Scriptable Tools Editor Mode Plugin](../../../../../../assets/images/6f/6f31379168d0ab5b4c114086dbcae296a48f870add7d889b9ce8be136397ce6e.jpg)
4. 对 Geometry Script 插件重复这些步骤。在搜索栏中输入“geometry script”。
5. 在编辑器中，点击

   Selection Mode

   下拉菜单并选择

   Scriptable Tools

   .

应该会看到类似下图的 UI，左侧有一个空的 tool palette。视口可能会因起始项目模板不同而不同。

![Scriptable Tool Editor Mode UI](../../../../../../assets/images/3a/3adeed508576d87ad656c918689d7924d1c7a403288738dd1ec07b486e23972c.jpg)

## 创建工具 Blueprint

可以从 Blueprint Class 或 Editor Utility Blueprint 创建 Scriptable Tool。

> [!NOTE]
> 如果使用 Blueprint Class 而不是 Editor Utility Blueprint 制作编辑器工具，则无法访问 editor subsystem 和其它仅编辑器功能。 This is true even inside an `UEditorScriptableTool`.

要创建 Blueprint，请执行以下步骤：

1. 在主 Content 文件夹中创建一个文件夹并命名为 Blueprints，以辅助项目组织。
2. 在 Blueprints 文件夹中右键点击并选择

   Editor Utilities

   >

   Editor Utility Blueprint

   。
3. 打开 **ALL CLASSES** 子菜单，在搜索框中输入“scriptable”，并选择 **EditorScriptable/ModularBehaviorTool（模块化行为工具类）**.

   ![Scriptable Tool Class](../../../../../../assets/images/f1/f184430d0f7d941f6e21f06030a5bd632f69455b61aaed65324e1fc8a6fe56be.jpg)

   > [!NOTE]
   > The **EditorScriptableClickDragTool** 已弃用，并由以下类替代： **EditorScriptable/ModularBehaviorTool（模块化行为工具类）**.
4. 将新的 BP asset 命名为 `BP_tool_MakeSphere`，然后右键点击并选择 **Edit**，或双击该 asset 以打开 Blueprint。
5. 在 **Details** 面板中为工具命名。本示例使用“Sphere”。还要填写 **Category** 字段，并使用合适名称。本示例使用“Shape Tools”。

   1. 以后如果要返回编辑名称、category 或其它方面，请点击 BP Editor 顶部的

      Class Defaults

      。

   ![Class Defaults](../../../../../../assets/images/9c/9c3a3a91ef9e8fcc82fc4354dbdd0fcf8e4e1cf7e2fcad4ff558de89a40b69b0.jpg)
6. Compile

   （Ctrl + Alt）并保存（Ctrl + S）Blueprint。切回 Scriptable Tools editor mode。

The **Sphere** 工具现在应显示在 Tool Palette 中，并位于对应 category 名称的部分下。

![Scriptable Tool Sphere](../../../../../../assets/images/b2/b2ae7b59dc2e46e6a9769deadcdf4af459ff0da7af2b3e00c0b269d827884e19.jpg)

现在可以运行 **Sphere** 工具，但它目前不会执行任何操作。使用视口底部中央的 **Complete** 按钮退出工具。

## If Hit 函数设置和测试

此工具的目标是在关卡中点击 geometry 时放置一个球体。因此需要一个函数来判断鼠标点击是否选中（“hit”）了 mesh。

> [!TIP]
> 搜索并找到节点时，可以查看它们所属的 category。

要创建该函数，请执行以下步骤：

1. 返回 BP Editor。在左侧面板中，点击 **Override** 下拉菜单，该菜单位于 **FUNCTIONS** 并选择 **OnScriptSetup**。此 Override 菜单包含各种函数，可控制 Scriptable Tool 的几乎所有方面。

   ![OnScriptSetup Event](../../../../../../assets/images/1f/1f90c68fa931e60a8f9584b4d60c2023618976362d7d7d2d17d8d0b340d74734.jpg)
2. 右键点击 Event Graph 背景，向下滚动到 **Scriptable Tool > Input** 并选择 **Add Single Click Behavior（添加单击行为）**.

   1. 所有 Scriptable Tool 节点都位于 Scriptable Tool 子菜单下。这是探索时发现其它节点的好方法。知道要找什么后，在顶部搜索字段输入会更快。

   ![Add Single Click Behavior](../../../../../../assets/images/fe/fefd35fb2ce6ae1df99b976f7f461234cb75c5d6c6181f441cb28cabbdea67b5.jpg)

   > [!NOTE]
   > 有很多 behavior，其中一些比其它更复杂。 其强大之处在于 `EditorScriptableModularBehaviorTool` 可以在单个工具中拥有多个 behavior。 完成本教程后，可以随意添加其它 behavior 来进一步增强工具，因为它们都基于 callback event 的同一范式工作。
3. 将

   Event OnScriptSetup

   的 execution pin 连接到

   Add Single Click Behaviour（添加单击行为）

   .
4. 在

   Add Single Click Behaviour（添加单击行为）

   节点的输入 execution pin，拖出

   If Hit By Click

   pin 并选择

   Event Dispatchers > Create Event

   。这将用于测试在视口中点击时是否 hit 到任何内容。
5. 在 **Create Event** 节点上点击 **Select Function 并选择**Create a matching function**。应该会看到一个新函数出现在 My Blueprint 的**FUNCTIONS**区域中，名称为**BP_tool_MakeSphere_AutoGenFunc**。

   ![Make Sphere Function](../../../../../../assets/images/39/394a8c8e42c8d50801c8f317ab83a46538b5e4f6febd8c2ae082835febb92981.jpg)
6. 右键点击新函数并将其重命名为“IfHitByClick”，以表明该函数的用途。
7. 在 graph 中右键点击，然后搜索并选择

   Print String

   .
8. 拖出

   IfHitByClick

   execution pin，并连接到

   Print String

   的 execution pin，以创建连线连接。连接 Print String 和 Return Node 的 execution pin。
9. 在字符串字段中输入“Running IfHitByClick function”。运行工具时，此文本会显示在视口中。

   > 图片已省略：Debug Print Text
10. Compile

    （Ctrl + Alt）并保存（Ctrl + S）。
11. 选择 **Sphere** 工具 palette 中的工具并在视口中点击，以测试新函数是否工作。点击视口时应看到“Running IfHitByClick function”文本。

    1. 文本会在点击后立即出现。尝试点击并按住鼠标按钮，应该会在点击时立即看到文本，而不是在释放时才看到。

> 动图已省略：Scriptable Tool FunctionTest

现在已经确认工具可被识别并会运行，print statement 会显示按钮点击和释放。

### 扩展函数

既然已经确认工具能正确处理点击，就可以替换 print 函数。

要更新该函数，请执行以下步骤：

1. 移除

   Print String

   节点，从 IfHitByClick 函数中删除。
2. 在 graph 中右键点击，然后搜索并选择 **Get Ray Start End** ，它位于 **Geometry Script > Shapes > Ray** category。

   1. 此节点获取该函数提供的 ray 输入信息，并给出 world space 中的起点和终点，可用于判断点击是否命中某物。ray 表示点击的屏幕位置和方向。

   > [!NOTE]
   > 如果尝试将 **Click Pos** 输出连接到 **Ray** 输入，会出现错误消息。该消息表示 pin 类型不匹配，即使它们颜色相同。将鼠标悬停在这些 pin 上： **Click Pos** and **Ray**。注意这些 pin 类型不同：一个是 input device ray structure，另一个只是 ray structure。
3. 右键点击 **Click Pos** pin，并选择 **Split Struct Pin**。structure 或 struct 是数据集合。

   1. 拆分 pin 后，可以看到传递给函数的信息。所有信息都很有用，但这里只会使用 world ray。将鼠标悬停在该 pin 上，可以看到它是 ray structure，与 Get Ray Start End 节点的输入完全一致。
4. 连接 **Click Pos World Ray** 输出 pin 到 Get Ray Start End 的 **Ray** 输入。将起点和终点距离保持为 0.0，这实际上会在 world 中设置自动距离。

   > 图片已省略：Click Pos World Ray Pin
5. 在 graph 中右键点击，然后搜索并选择

   Line Trace by Channel。

   连接

   Start Point

   and

   End Point

   pin 从

   Get Ray Start End

   连接到以下节点中的对应 pin：

   Line Trace by Channel（按通道线追踪）

   .
6. 启用

   Trace Complex（复杂追踪）

   in

   Line Trace by Channel（按通道线追踪）

   以针对 complex collision 进行测试。
7. 将 **IfHitByClick**节点的 execution pin 连接到 **Line Trace By Channel** 节点。

   > 图片已省略：Line Trace by Channel
8. The **Out Hit** pin 是 Line Trace By Channel 节点中的 struct，包含 trace hit 的属性。右键点击该 pin 并选择 **Split Struct Pin**以查看这些属性。

   1. The

      Return Value

      是 boolean；如果 Line Trace By Channel 命中 world 中的任意 Actor，则为 true，否则为 false。
9. 在 **Return Node**，右键点击 **Return Value** 并选择 **Split Struct Pin**。顶部条目是 **Return Value Hit**，它是 boolean。

   1. 这个 boolean 是

      IfHitByClick

      函数中最关键的部分。如果函数返回 true，表示用户释放鼠标时检测到 hit；如果为 false，表示未检测到 hit。这个区别很重要，因为当它为 false 时，可以跳过剩余脚本，不再执行任何操作。
10. 连接

    Return Value

    pin 从 Line Trace By Channel 连接到

    Return Value Hit

    输入，并连接 execution pin。
11. Compile

    (Ctrl + Alt)

    并保存（Ctrl + S）Blueprint。

> 图片已省略：Connect Return Values

### Print 函数测试

继续添加球体之前，可以用 print text 测试此函数。

这次使用 **Print Text** and **Format Text** 节点测试该函数。Format Text 可将输入文本与变量值组合，是直观看到发生了什么的强大方式。

要创建该函数，请执行以下步骤：

1. 右键点击 graph，然后搜索并选择

   Format Text

   and

   Print Text

   节点。
2. 在 Format Text 节点中输入

   Trace Return Value is: {b}

   （不要使用引号）并按 Enter。 Format Text 节点上应出现一个新输入，标记为

   b

   的新输入。该节点会识别花括号之间的任何内容，并创建一个可连接其它 pin 的新 pin。灰色 pin 表示在连接内容之前它没有类型。
3. 将

   Return Value

   输出 pin 连接到

   b

   的输入

   Format Text

   .
4. 将 **Result**pin 从 **Format Text** 连接到 **In Text**输入，该输入属于**Print Text**节点。连接 **Print Text** 节点的 execution pin，将其放在 **Line Trace by Channel（按通道线追踪）**and **Return Node**.

   > 图片已省略：Print Text Script
5. Compile

   之间，然后在 Scriptable Tools mode 中再次测试工具。点击 Actor 和空背景。

点击 Actor 时，print text 中应显示 true；点击场景背景时应显示 false。尝试点击并按住 Actor，然后在 Actor 和背景上释放。true 和 false 会在释放鼠标按钮时确定。

会看到 true 和 false 各出现两次。初次点击时， **Line Trace by Channel（按通道线追踪）** 节点触发，并且 **Print Text** 节点显示值。不过， **Return Node** 不会返回该值。释放时， **Line Trace by Channel（按通道线追踪）** 会在新的鼠标位置再次触发。这一次才决定返回值。

### Location 变量

为避免 Line Trace by Channel 节点运行超过必要次数，可以将 hit position 存储在变量中。

要创建变量，请执行以下步骤：

1. 打开

   IfHitByClick

   函数。
2. 在 **Line Trace by Channel（按通道线追踪）** 节点中，右键点击 **Out Hit Location** 并选择 **Promote to Variable**.

   1. The

      Promote to Local Variable

      选项表示该变量仅在此函数中可用。使用 Promote to Variable 可让变量在整个 MakeSphere 工具中可用。新变量会出现在 My Blueprint 选项卡中，并与连接到的 pin 同名。
3. 将

   Set

   节点的 execution pin 放在

   Line Trace by Channel（按通道线追踪）

   and

   Print Text

   节点之间，以便设置该变量。

## On Hit 函数设置

用于指示对象是否被 hit 的 IfHitByClick 函数已经完成。接下来实现 On Hit By Click event，用于确定 Actor 何时以及在哪里生成。

要创建新函数，请执行以下步骤：

1. 在 **Event Graph**，点击并拖出 **On Hit By Click** pin，然后选择 **Create Event** 节点。

   1. 这与为 If Hit By Click 创建 Create Event 的过程相同。
2. 点击

   Select Function

   并选择

   Create a Matching Function

   这会向 My Blueprint 选项卡的 FUNCTIONS 部分添加新函数，并立即跳转到那里进行编辑。
3. Rename the new function to `OnHitByClick`.

   > 图片已省略：OnHitByClick Function
4. 在 **OnHitByClick** 函数中，右键点击 graph，然后搜索并选择 **Spawn Actor from Class** 节点，并将 **Editor Level Library（编辑器关卡库）** 作为 target（确保 **Context Sensitive** 已启用）。将其 execution pin 连接到函数输入。
5. Click the **Actor Class**下拉菜单，然后搜索并点击 **Dynamic Mesh Actor**.
6. **Compile**(Ctrl + Alt) 并保存（Ctrl + S）Blueprint。
7. Actor 会在 hit object 的位置生成。要确定位置，请拖入 **Out Hit Location** 变量并选择 **Get Out Hit Location**.
8. 将变量连接到 **Location** pin，该 pin 位于 **Spawn Actor From Class** 节点。
9. Compile

   (Ctrl + Alt) and save (Ctrl + S) the Blueprint.

> 图片已省略：OnHitByClick Script

> [!WARNING]
> 如果 **Context Sensitive** 在搜索以下节点时被禁用： **Spawn Actor from Class**，可能出现两个同名函数。这两个节点 target 不同： **Editor Level Library（编辑器关卡库）** and **Editor Actor Subsystem（编辑器 Actor 子系统）**。后者有额外 Target 输入，由于它需要输入，编译时会报错。

### 在 Hit Location 生成球体

该工具现在会在有效点击点的位置添加 dynamic mesh actor。不过，dynamic mesh actor 是空的。必须获取 actor 的 dynamic mesh component 上的 dynamic mesh 本身，才能生成球体。

要添加球体，请执行以下步骤：

1. 右键点击节点背景，确保 **Context Sensitive** 已关闭，然后搜索并选择 **Get Dynamic Mesh**.
2. 将 **Return Value** pin，从**Spawn Actor from Class** 节点的 execution pin 连接到 **Target** pin 拖出。一个新节点会自动出现。该节点会从 Actor 获取 dynamic mesh component，使 Get Dynamic Mesh 能够工作。
3. 连接 execution pin。
4. 右键点击节点背景，然后搜索并选择 **Append Sphere Box** 节点。该节点会为 Actor 添加一个球体作为 dynamic mesh。
5. 连接 execution pin，并将 Get Dynamic Mesh 的 **Return Value** 连接到 **Target Mesh** pin。

   > 图片已省略：Append Sphere Box node
6. **Compile**(Ctrl + Alt) and save (Ctrl + S) the Blueprint.
7. 在视口中测试工具。

点击任意非空背景位置时，应出现一个球体。新的 dynamic mesh actor 也会出现在 Outliner 中，print text 信息会出现在视口中。

> 动图已省略：Sphere Placement Tool

> [!TIP]
> 创建 mesh 有许多选择，可以查看 **Geometry Script > Primitives** category 并尝试其它选项。

## 添加 Radius 属性

现在已经创建了 Sphere 工具的基础。要扩展功能，可以为球体添加 radius 设置。

要调整 radius 设置，请执行以下步骤：

1. 打开 Content Drawer，然后在创建的 Blueprints 文件夹中右键点击并选择 **Blueprint Class**.
2. 在搜索框中输入“propertyset”，然后选择 **EditorScriptable/InteractiveToolPropertySet（属性集类）**。将新的 BP asset 命名为“BP_MakeSphere_Settings”，然后双击打开它。
3. 在 **Variables** 部分，点击左侧的 **+** 图标添加新变量。将其命名为 **Radius**，将类型改为 **Float**，并通过打开眼睛图标将其设为 **Public** 。如果变量保持 private，它不会出现在工具的 settings panel 中。

   > 图片已省略：Radius Variable
4. Compile

   (Ctrl + Alt) and save (Ctrl + S) the Blueprint.
5. 在 Details 面板中，将 **Slider Range** 字段设置为 10 和 200，然后将 **Default Value** 设置为 50。 **Compile** 第二次。

   > 图片已省略：Radius Variable Details Variable
6. 打开 **BP_tool_MakeSphere** Blueprint，并导航到 **Event Graph**.
7. 右键点击 graph 背景，然后搜索并选择 **Add Property Set of Type（添加属性集类型）**。将此节点的 execution pin 连接在 **Event OnScriptSetup** 和 **Add Single Click Behavior（添加单击行为）** 节点。
8. 在 **Property Set Type** pin 下拉菜单中选择 **BP_MakeSphere_Settings** 类，即包含 Radius 变量的已创建类。
9. 拖出 **New Property Set** pin，然后搜索并选择 **Cast to BP_MakeSphere_Settings**
10. 将 **BP_MakesSphere_Settings** 节点的 execution pin 放在 **Add Property Set of Type（添加属性集类型）** and **Add Single Click Behavior（添加单击行为）**.
11. 右键点击 **As BP Make Sphere Settings** pin 并选择 **Promote to Variable**。将此变量重命名为“Settings”并连接 execution pin。
12. **Compile**（Ctrl + Alt）。

    > [!NOTE]
    > Add Property Set of Type 节点会创建包含 Radius 变量的 Blueprint 实例，以便在此 Scriptable Tool Blueprint 中使用。它会 cast 为特定类型，以便从创建的变量直接访问；否则在需要时无法获取 Radius 值。
13. 返回以下函数的 graph： **OnHitByClick** 函数，拖入 Settings 变量，并选择 **Get Settings** （Ctrl + 拖动）。
14. 拖出 Settings pin，然后搜索并选择 **Get Radius**。将输出连接到 **Radius** 输入，该输入位于 **Append Sphere Box** 节点。
15. Compile

    (Ctrl + Alt) and save (Ctrl + S) the Blueprint.

如果向 Property Set 添加其它变量，可以使用变量名，以与 Settings 变量相同的方式访问它们。

返回视口并重新运行 Sphere 工具。在 Details 面板中，应看到 **Radius** 字段的滑块。调整该值时，放置的球体会改变大小。

> 图片已省略：Radious Property Set in the Editor Mode

## 最终结果

你已经完全用 Blueprint 创建了一个带自定义设置、可处理鼠标点击的工具。

