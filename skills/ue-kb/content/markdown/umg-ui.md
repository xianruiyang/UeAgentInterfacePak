# UMG UI设计器快速入门

---
title: "UMG UI设计器快速入门"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/umg-ui-designer-quick-start-guide-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建用户界面", "构建用户界面", "构建你的UI", "UMG UI设计器快速入门"]
---

# UMG UI设计器快速入门

> 路径：虚幻引擎5.7文档 / 创建用户界面 / 构建用户界面 / 构建你的UI / UMG UI设计器快速入门

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/umg-ui-designer-quick-start-guide-in-unreal-engine

在本 **快速入门指南** 中，您将了解如何使用 **虚幻示意图形界面设计器（Unreal Motion Graphics UI Designer）(UMG)** 实现一些基本的游戏中HUD元素和前端菜单。你将了解如何创建动态元素：血条、能量条和弹药数量，还将学习如何将它们添加到 **视口** 中。

所有的操作都一步一步详细介绍。如果您从未使用过 **虚幻引擎**，建议您首先熟悉阅读[关卡设计快速入门](https://dev.epicgames.com/documentation/unreal-engine/level-designer-quick-start-in-unreal-engine)。其中您可以找到使用UE工作的基本知识和术语。另外，本教程还包含了相关的延伸阅读链接。如有需要，请查阅这些链接。

## 1 - 必要的项目设置

> [!NOTE]
> 在本教程中，我们将在启用 **初学者内容包（Starter Content）** 的情况下使用 **蓝图第一人称（Blueprint First Person）** 模板。

角色在游戏开始时没有武器。拿到武器后，画面就会出现弹药提示。因此，需要用到两个控件：HUD和HUD_AmmoCount。你要调整HUD控件，让它在游戏开始时显示角色的血条和能量条，而HUD_AmmoCount控件则用于在角色使用武器时显示弹药。

1. 创建 **控件蓝图**。单击 **内容浏览器（Content Browser）** 中的 **新增（Add New）** 按钮，然后在 **用户界面（User Interface）** 下选择 **控件蓝图（Widget Blueprint）** 并将其命名为 **HUD**。

   控件蓝图可用于创建并设置UI元素，例如HUD、菜单等等。在控件蓝图中，你可以设置UI布局，并编写UI逻辑。

   > [!NOTE]
   > 有关控件蓝图的更多信息，请参阅[UMG控件蓝图](https://dev.epicgames.com/documentation/unreal-engine/level-designer-quick-start-in-unreal-engine)文档。
2. 再创建三个控件蓝图，分别命名为 **HUD_AmmoCount** 、 **主菜单（MainMenu）**、**暂停菜单（PauseMenu）**。
3. 新建一个 **关卡**。**右键单击** **内容浏览器（Content Browser）**，并创建一个名为 **主关卡（Main）** 的新 **关卡（Level）**。

   你会在本指南的稍后部分使用它进行主菜单（Main Menu）设置。

### 修改BP_FirstPersonCharacter蓝图

1. 在 **内容浏览器（Content Browser）** 中，打开 **Content/FirstPerson/Blueprints** 文件夹下的 **第一人称角色（FirstPersonCharacter）** 蓝图。

   这就是你在游戏中操控的 **角色的蓝图**。你将调整它，让它添加HUD控件并在视口中显示HUD控件。
2. 在 **蓝图编辑器** 中，单击 **添加变量（Add Variable）** 按钮。
3. 在新变量的 **细节（Details）** 面板中，将其命名为 **生命值（Health）**，将其更改为 **浮点（Float）** 变量类型。将 **默认值（Default Value）** 设置为 **1.0**。

   你将通过这个变量来调整HUD控件中的玩家角色的生命值。
4. 创建另一个名为 **能量（Energy）** 的 **浮点（Float）** 变量，并将其 **默认值（Default Value）** 设置为 **1.0**。

   你将通过这个变量来调整HUD控件中的玩家角色的能量值。

   > [!NOTE]
   > 在输入默认值前，你需要单击工具栏中的 **编译（Compile）** 按钮以编译蓝图。
5. 创建另一个名为 **弹药（Ammo）** 的 **整数（Integer）** 类型的变量，并将其 **默认值（Default Value）** 设置为 **25**。
6. 再创建一个名为 **最大弹药量（MaxAmmo）** 的 **整型（Integer）** 变量，并将其 **默认值（Default Value）** 设置为 **25**。
7. 在 **图表（Graph）** 窗口中点击右键，添加 **Event Begin Play** 节点。然后添加 **创建控件（Create Widget）** 节点。将 **类（Class）** 设置为 **HUD** 控件。
8. 对于 **创建HUD控件（Create HUD Widget）** 的 **返回值（Return Value）**，请选择 **提升为变量（Promote to Variable）** 并将其命名为 **HUD引用（HUD Reference）**。

   执行此操作后，即可在游戏开始时创建HUD控件，并将其设置为变量以供稍后调用。如果需要通过蓝图调用某些函数或设置HUD控件的属性，这种方法很有用。例如，如果需要在游戏暂停时隐藏HUD，则可以通过此变量访问HUD。
9. 将 **添加到视口（Add to Viewport）** 节点连接到 **设置（Set）** 节点的输出引脚。

   执行此操作后，从游戏过程开始便已经将HUD控件添加到了视口。
10. **编译（Compile）** 并 **保存（Save）** **BP_FirstPersonCharacter** 蓝图，然后将其关闭。

### 调整BP_Rifle蓝图

调整BP_Rifle蓝图的过程与调整BP_FirstPersonCharacter蓝图的过程类似。如需了解更多细节，请参阅上文的[调整BP_FirstPersonCharacter蓝图](#%E8%B0%83%E6%95%B4bp_firstpersoncharacter%E8%93%9D%E5%9B%BE)小节。

1. 在 **内容浏览器（Content Browser）** 中，打开位于 **Content/FirstPerson/Blueprints** 文件夹下的 **BP_Rifle** 蓝图。
2. 找到 **在组件开始重叠时（SphereCollision）（On Component Begin Overlap (SphereCollision)）** 节点。**右键单击** 相应的执行引脚，然后选择 **断开所有引脚连接（Break All Pin Link(s)）**。
3. 拖动 **在组件开始重叠时（SphereCollision）（On Component Begin Overlap (SphereCollision)）** 节点的执行引脚，添加一个 **创建控件（Create Widget）** 节点。将 **类（Class）** 设置为 **HUD_AmmoCount** 控件。
4. 对于 **创建HUD控件（Create HUD Widget）** 的 **返回值（Return Value）**，请选择 **提升为变量（Promote to Variable）** 并将其命名为 **HUD弹药计数引用（HUD Ammo Count Ref）**。
5. 将 **添加到视口（Add to Viewport）** 节点连接到 **设置（Set）** 节点的输出引脚。
6. 将 **添加到视口（Add to Viewport）** 节点的执行引脚与 **转换为BP_FirstPersonCharacter（Cast to BP_FirstPersonCharacter）** 节点的执行引脚连接起来。脚本应如下所示。

   执行此操作后，便将HUD_AmmoCount控件添加到了视口，以便在角色携带武器时进行计数。
7. **编译（Compile）** 并 **保存（Save）** **BP_Rifle** 蓝图，然后将其关闭。

### 调整BP_FirstPersonCharacter蓝图中的角色变量

本章介绍如何调整声明的变量并将它们添加到蓝图中。

1. 在 **BP_FirstPersonCharacter** 的蓝图编辑器中，按住 **Alt** 将 **能量（Energy）** 变量拖入 **图表（Graph）** 窗口，并将其放置在"跳跃（Jump）"脚本的旁边。
2. 按住 **Ctrl**，拖入 **能量（Energy）** 变量副本，并将其连接到 **Float - Float** 节点，值设置为 **0.25**，连接方式如图所示。

   借助此脚本，每次角色跳跃时，都会在当前能量值的基础上将能量值减少0.25。
3. 为 **生命值（Health）** 变量设置相同的脚本，但是使用 **F** 按键事件（或任何其他按键事件）进行测试。

   借助此脚本，可以测试是否每次按 **F** 时都会在当前生命值的基础上将生命值减少0.25。
4. **编译（Compile）** 并 **保存（Save）** **BP_FirstPersonCharacter** 蓝图，然后将其关闭。

   > [!TIP]
   > 要添加重新装弹功能，请执行以下操作。添加 **R按键事件（R Key Event）**。按住 **Alt** 拖动 **弹药（Ammo）** 变量。按住 **Ctrl** 拖动 **最大弹药数（Max Ammo）** 变量。如下图所示进行连接。

### 调整BP_Rifle蓝图中的角色变量

1. 打开 **BP_Rifle** 蓝图。找到 **OnFireProjectile自定义事件（OnFireProjectile Custom Event）**。**右键单击** 相应的执行引脚，然后选择 **断开所有引脚连接（Break All Pin Link(s)）**。
2. 在此节点附近 **右键单击**，然后添加 **分支（Branch）** 节点。
3. 按住 **Ctrl** 将 **FirstPersonCharacterReference** 变量的副本拖入 **图表（Graph）** 窗口。拖动相应的引脚并选择 **获取弹药（Get Ammo）**。
4. 添加 **大于（Greater）** 运算符节点，设置为 **0**，并进行如下所示的连接。

   由于此脚本，选择的角色可以在弹药数大于零时开火。
5. 在 **蒙太奇播放（Montage Play）** 节点之后的 **OnFireProjectile自定义事件（OnFireProjectile Custom Event）** 脚本的末尾，按住 **Ctrl** 将 **FirstPersonCharacterReference** 变量的副本拖入 **图形（Graph）** 窗口。拖动相应的引脚并选择 **获取弹药（Get Ammo）**。再次拖动引脚并选择 **设置弹药（Set Ammo）**。
6. 添加 **减法（Substruct）** 运算符，并将 **弹药（Ammo）** 设置为等于 **弹药 - 1（Ammo - 1）**。脚本应如下所示。

   由于此脚本，选择的角色每次开火都会减少弹药。
7. **编译（Compile）** 并 **保存（Save）** **BP_Rifle** 蓝图，然后将其关闭。

## 2 - 显示生命值、能量和弹药

在此步骤中，应在控件中设置"生命值（Health）"、"能量（Energy）"和"弹药（Ammo）"变量的可视化，并调整与游戏过程的关联性。

### 视觉效果：生命值、能量和弹药

要设置HUD控件的可视化，请执行以下操作。

1. 打开您的 **HUD** 控件蓝图，访问 **控件蓝图编辑器（Widget Blueprint Editor）**。执行此操作后，即可创建HUD控件的可视化布局和脚本功能。

   ![undefined](../../../../../assets/images/aa/aa7a6764af3561b3c7e3e69cd3c30cc8a4f6459fc006edf78cb3e792fef95d49.png)

   > [!NOTE]
   > 有关控件蓝图编辑器的各个不同方面的更多信息，请参阅[UMG控件蓝图](../widget-blueprints-in-umg/index.md)。
2. 在 **控制板（Palette）** 面板中的 **面板（Panel）** 下找到 **水平方框（Horizontal Box）**，然后将其拖到 **层级（Hierarchy）** 面板中的 **画布面板（Canvas Panel）** 上。

   **面板（Panel）** 控件有点像其他控件的容器，并为其中的控件提供额外的功能。
3. 同样在 **面板（Panel）** 下，将两个 **垂直方框（Vertical Box）** 拖到 **水平方框（Horizontal Box）** 上。
4. 在 **常见（Common）** 下，将两个 **文本（Text）** 控件拖动到第一个垂直方框上，将两个 **进度条（Progress Bar）** 拖动到第二个垂直方框上。
5. 选择 **水平方框（Horizontal Box）**，然后在图表中调整该框大小，并将其放置在窗口的左上角。
6. 选择这两个 **进度条（Progress Bar）**，然后在 **细节（Details）** 面板中将这两者均设置为 **尺寸（Size）** 下的 **填充（Fill）**。
7. 选择包含这些进度条（Progress Bar）的 **垂直方框（Vertical Box）**，然后同样在 **细节（Details）** 面板中将这两者均设置为 **尺寸（Size）** 下的 **填充（Fill）**。
8. 再次选择 **水平方框（Horizontal Box）**，重新调整其大小，使进度条与文本对齐。
9. 在 **层级（Hierarchy）** 窗口中选择最顶部的 **文本（Text）** 控件，然后在 **详情（Details）** 面板的 **内容（Content）** 下，输入 **生命值：（Health:）**。
10. 对另一个 **文本（Text）** 控件执行相同的操作，但将它标记为 **能量（Energy）**：图表看起来如下所示。

    > [!NOTE]
    > 默认情况下，虚幻示意图形文本控件使用虚幻引擎中的字体。这样就可以在虚幻引擎中快速开始工作。但是，这种内置字体有一些局限性。例如，只支持一小部分的语言。在大多数情况下，需要将自定义字体导入资产中。有关设置文本控件以使用自定义字体的更多细节，请参阅[在虚幻引擎用户界面中创建和指定字体](../../../text-formatting-localization-and-fonts/fonts/creating-and-assigning-fonts-in-unreal-engine-u-36e56af2/index.md)。
11. 选择生命值旁边的 **进度条（Progress Bar）**，并在 **详情（Details）** 面板中，将 **填充颜色和不透明度（Fill Color and Opacity）** 设置为绿色。

    > [!NOTE]
    > 指定颜色时，进度条（Progress Bar）不会改变颜色。这是因为用于填充进度条的 **百分比（Percent）** 值设置为0.0。可以更改这个值来测试不同的颜色。稍后会将这个值关联到角色的"生命值（Health）"变量值。
12. 还要为 **能量（Energy）** 条设置"填充颜色（Fill Color）"和"不透明度（Opacity）"（例如，橙色）。
13. HUD控件布局应如下所示。
14. **编译（Compile）** 并 **保存（Save）** **HUD** 控件蓝图，然后将其关闭。

### 视觉效果：弹药

要设置HUD_AmmoCount控件的可视化，请执行以下操作。

1. 打开 **HUD_AmmoCount** 控件蓝图以访问 **控件蓝图编辑器（Widget Blueprint Editor）**。
2. 使用同样的方式向 **层级（Hierarchy）** 面板添加控件。布局结构应如下所示。
3. 选择 **图表（Graph）** 中的 **水平方框（Horizontal Box）**，调整方框的尺寸，并将其放置在窗口的右上角。
4. 选择 **水平方框（Horizontal Box）**，然后在 **细节（Details）** 面板中单击 **锚点（Anchors）** 并选择右上角的锚点。

   借助此锚点，将 **锚点标牌（Anchor Medallion）** 放置在屏幕的右上角。

   由于锚点设置，无论屏幕尺寸如何，都可以固定水平方框位置。调整屏幕尺寸时，控件与锚点标牌之间的距离保持不变。

   > [!NOTE]
   > 您可以单击并更改图表内的 **预览大小（Preview Size）** 选项，从而测试不同尺寸的屏幕大。
5. **编译（Compile）** 并 **保存（Save）** **HUD_AmmoCount** 控件蓝图，然后将其关闭。

### 脚本：生命值、能量和弹药

下一步是为HUD元素编写功能。

1. 打开 **HUD** 控件蓝图以访问 **控件蓝图编辑器（Widget Blueprint Editor）**。
2. 在控件蓝图编辑器（Widget Blueprint Editor）窗口的右上角单击 **图表（Graph）** 按钮。
3. 在 **图表（Graph）** 中的 **Event Construct** 节点下，**右键单击** 并添加 **Get Player Character** 节点。
4. 拖出 **返回值（Return Value）** 引脚，并选择 **转换为第一人称角色（Cast to BP_FirstPersonCharacter）
5. 拖动 **作为BP第一人称角色（As BP First Person Character）** 引脚并选择 **提升为变量（Promote to Variable）**（将其命名为 **我的角色（My Character）**），然后如下图所示进行连接。

   执行此操作后，即可从 **BP_FirstPersonCharacter** 蓝图中访问变量。
6. 单击工具栏中的 **编译（Compile）** 对脚本进行编译。
7. 返回到 **设计器（Designer）** 并选择 **生命值（Health）** 旁边的 **进度条（Progress Bar）**。
8. 在 **细节（Details）** 面板中的 **进度（Progress）** 下，单击 **百分比（Percent）** 旁边的 **绑定（Bind）** 选项，然后单击 **创建绑定（Create Binding）**。

   执行此操作后，即可通过在打开的窗口中调整函数脚本来创建自定义绑定。
9. 按住 **Ctrl** 将 **MyCharacter** 变量的副本拖入 **图表（Graph）**。
10. 拖动 **MyCharacter** 引脚并选择 **获取生命值（Get Health）**。
11. 将 **生命值（Health）** 引脚连接到 **返回节点（Return Node）** 的 **返回值（Return Value）**。结果应如下所示。
12. 执行同样的过程来调整 **能量（Energy）** 旁边的 **进度条（Progress Bar）**。结果应如下所示。
13. **编译（Compile）** 并 **保存（Save）** **HUD** 控件蓝图，然后将其关闭。

### 脚本：弹药和AmmoMax

设置"弹药（Ammo）"变量的过程类似于设置"生命值（Health）"和"能量（Energy）"变量。如需了解更多详细信息，请参阅上文的[脚本：生命值和能量](#%E8%84%9A%E6%9C%AC%EF%BC%9A%E7%94%9F%E5%91%BD%E5%80%BC%E5%92%8C%E8%83%BD%E9%87%8F)小节。

1. 打开 **HUD_AmmoCount** 控件蓝图并转到 **图表（Graph）** 选项卡。
2. 如前文所述，创建用于将 **HUD_AmmoCount** 控件蓝图连接到 **BP_FirstPersonCharacter** 蓝图的脚本。结果应如下所示。
3. 单击工具栏中的 **编译（Compile）** 对脚本进行编译。
4. 返回到 **设计器（Designer）** 并在 **弹药（Ammo）** 文本后面选择 **25**。在 **文本（Text）** 的 **细节（Details）** 面板中，单击 **绑定（Bind）** 和 **创建绑定（Create Binding）**。
5. 在打开的窗口中，按住 **Ctrl** 将 **MyCharacter** 变量的副本拖入 **图表（Graph）**。拖动 **MyCharacter** 引脚并选择 **获取弹药（Get Ammo）**。将 **弹药（Ammo）** 引脚连接到 **返回节点（Return Node）** 的 **返回值（Return Value）**。结果应如下所示。

   > [!NOTE]
   > 将 **弹药（Ammo）** 节点连接到 **返回的节点（Returned Node）** 后，将自动创建一个转换节点 **至文本（To Text）**。
6. 对其他 **25** 文本重复上述过程，并为"AmmoMax"文本创建绑定。

   > [!NOTE]
   > 如果最大弹药数为常量，则没有必要这样做。但是，借助此 **AmmoMax** 变量设置，可以通过在 **BP_FirstPersonCharacter** 中创建脚本来更改此数值。
7. 单击 **编译（Compile）** 和 **保存（Save）**，然后单击 **运行（Play）** 按钮以在编辑器中运行。

在本指南的帮助下，你调整了通过HUD控件显示生命值和能量条的方式，以及通过HUD_AmmoCount控件显示弹药的方式。所有这些控件都会显示角色蓝图中的当前值。游戏过程中，按 **空格键** 会使角色跳跃，能量将降低；按 **F** 会使生命值减少；按 **鼠标左键** 会使武器开火，弹药将减少。

下一小节将介绍如何创建主菜单，此菜单可用于加载到你设置的游戏中。此外，还将介绍如何使用 **虚幻示意图形** 和 **蓝图**。

## 3 - 延伸阅读

本指南涵盖主题的相关内容：

- 有关虚幻示意图形（Unreal Motion Graphics）的更多信息，请参阅：

  UMG UI设计器
- 有关蓝图（Blueprint）的更多信息，请参阅：

  蓝图可视化脚本

  。

