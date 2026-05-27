# 远程控制Web应用程序

---
title: "远程控制Web应用程序"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/remote-control-web-application-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "编辑器的脚本与自动化", "远程控制", "远程控制预设和Web应用程序", "远程控制Web应用程序"]
---

# 远程控制Web应用程序

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 编辑器的脚本与自动化 / 远程控制 / 远程控制预设和Web应用程序 / 远程控制Web应用程序

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/remote-control-web-application-for-unreal-engine

[远程控制预设](../getting-started-with-remo-1077b97f/index.md)中公开的参数和函数可以连接到 **远程控制Web界面（Remote Control Web Interface）** 插件提供的随附Web应用程序，以远程控制引擎。此Web应用程序具有内置的UI编辑器，可以用来自定义其界面，而不需要额外的代码来创建它或对其进行格式化。

由于这是Web应用程序，因此你可以同时运行多个客户端。在一个客户端中修改的任何属性都会通过Web服务器将其更改传播到所有其他客户端。这有助于在实时环境中创建协作式的工作流。

此页面介绍如何将公开的属性和函数连接到伙伴远程控制Web应用程序中的控件，以及如何使用应用程序的UI构建器构建你自己的UI。

## 先决条件

**远程控制Web界面（Remote Control Web Interface）** 使用NodeJS提供具有默认控件的伙伴Web应用程序，例如仪表、滑块和取色器，以远程控制引擎，无需任何额外的代码。

按照下面的步骤将Web应用程序连接到你的项目:

1. 在你的电脑上[安装NodeJS](https://nodejs.org/en/download/)。

   1. 最低版本：8。
   2. 最高版本：14.15.5。
2. 在虚幻编辑器中打开你的项目。
3. 在编辑器的主菜单中，选择 **编辑（Edit） > 插件（Plugins）** 以打开 **插件（Plugins）** 窗口。
4. 在 **插件（Plugins）** 窗口中，在 **消息传递（Messaging）** 类别下找到 **远程控制Web界面（Remote Control Web Interface）** 插件。勾选 **启用（Enabled）** 复选框。

   ![远程控制Web界面插件](../../../../../../assets/images/bb/bbcfe81aa29c3032b323fa29dae9ac267110d5dfcd36b5526281f4a58b28301e.jpg)
5. 重启引擎。
6. 验证Web应用程序已成功启动。在编辑器的主菜单中，选择 **窗口（Window） > 开发人员工具（Developer Tools） > 输出日志（Output Log）**，然后按照"远程控制Web"进行筛选，成功的日志类似于：LogRemoteControlWebInterface:

   `[Success] Remote Control Web Interface is running - WebApp started, port: 7000`

   ![Success message displayed in the output log](../../../../../../assets/images/9c/9cc0cd0fcb7b4cc4001f90319f0857acf4af3cb3898d70b18bf5c7688bdc2c59.png)

## 远程控制Web应用程序入门

在远程控制面板中将属性和函数连接到Web应用程序。Web应用程序将读取你在虚幻会话中已经打开的任何远程控制预设。官方支持以下浏览器：Chrome、Firefox、Safari。

> [!TIP]
> 你在web应用程序中更改属性值时，如果要在编辑器中查看更新，请打开 **编辑（Edit）> 编辑器首选项（Editor Preferences）**，然后在 **一般（General）** 下的 **性能（Performance）** 分段中，禁用 **在后台时使用更少的CPU（Use Less CPU when in Background）**。
>
> ![Use Less CPU in the Background setting in the Editor Preferences](../../../../../../assets/images/68/68bb349bee84af75816c98108f8cdcef10d43d6a8828c27379f27a8e2922c687.png)

按照这些步骤启动Web应用程序，并添加公开的属性：

1. 在运行引擎的同一台机器上打开你的Web浏览器，然后输入URL 127.0.0.1:7000。如需了解如何向其他机器公开远程控制API，请参见"远程控制快速入门"。

   ![在你的浏览器中输入URL](../../../../../../assets/images/64/643424fb7b38b083ffc704cf12ca311ac0d1b114f690830edecd82fc5ebb9f51.png)

   > [!NOTE]
   > 你可以更改 **远程控制Web界面（Remote Control Web Interface）** 为你的项目使用的端口。在 **编辑器（Editor）** 的主菜单中，选择 **编辑（Edit） > 项目设置…（Project Settings…）** 以打开 **项目置（Project Settings）** 窗口。在 **项目设置（Project Settings）** 窗口中，在 **插件（Plugins）** 分段中选择 **远程控制Web界面（Remote Control Web Interface）** 以查看其设置，你可以在其中更改默认端口。
   >
   > ![Remote control web interface plugin](../../../../../../assets/images/dd/ddb8fb521ded7824d1f3dc86e4b668bb9134c17b47a517f423c9a5739466973f.png)

   > [!TIP]
   > 此外，你还可以从 **远程控制预设（Remote Control Preset）** 启动Web应用程序.如需更多信息，请参考[远程控制面板参考](../remote-control-panel-reference/index.md#%E8%8F%9C%E5%8D%95)。
2. 在页面加载时，你应该可以看到空白的远程控制应用程序。在Web应用程序中点击 **控制（Control）** 开关，从而切换到 **设计（Design）** 模式，以开始添加控件。

   ![控制模式中的模式开关](../../../../../../assets/images/a8/a885beb81b20d5d9a6c5e64a6d85cbd37cf1dbfb100d8be0fd7cc48fd86fa023.png)

   ![Mode toggle in Design mode](../../../../../../assets/images/7e/7e6e2f725bd32c1e6b6daf3276d563a8606ac3d1c3cc252236e984f700960d99.png)
3. 选择 **属性（Properties）** 选项卡。

   ![Remote control properties tab](../../../../../../assets/images/8c/8c11b337741a54c29a945f553b59730da41fcaf4b45836b4885d57f87744937f.jpg)
4. 将一个公开的属性拖放到右侧面板中。从 **属性（Properties）** 面板添加属性时，如果属性当前不存在，则会创建 **面板控件（Panel Widget）**，并且属性的关联控件将添加到面板控件。

   在下面的示例中，创建了面板控件，并将取色器控件添加到了面板控件。取色器绑定到场景的 **PostProcessVolume** 的 **对比度（Contrast）** 字段。

   > 图片已省略：Color Picker Widget bound to Post Process Volume Contrast property
5. 切换到 **控制（Control）** 模式。

   > 图片已省略：Color Picker Widget in Control mode
6. 在Web应用程序中修改公开的属性，并验证关联的属性在编辑器中完成了更新。

   > 动图已省略：使用控件远程编辑后期处理对比度
7. 在虚幻编辑器中保存相应的远程控制预设，从而将你的更改保存到Web应用程序。下次打开Web应用程序时，布局将与上次保存资产时相同。

## 预设

Web应用程序中可以有多个远程预设，但一次只能打开一个远程控制预设。在 **设计（Design）** 模式中，转到 **预设（Presets）** 分段，在窗口左侧查看可用的远程预设并选择你要查看的预设。当前打开的远程控制预设的名称显示在窗口的右上角。

> 图片已省略：Multiple presets in the Remote Control window

## 选项卡

你可以在Web应用程序中拥有多个选项卡。这有助于在实时环境中为操作员创建不同的视图。

- 你可以更改选项卡的标签，然后从图标库中选择图标来区分这些选项卡。
- 你也可以复制一个选项卡，将其用作新界面的起始点。

> 图片已省略：Multiple tabs

在已经设置为使用其他虚幻工具的Web应用程序中，你可以添加两个独特的选项卡：[关卡快照](../../../../collaboration-and-version-control/level-snapshots/index.md)和[Sequencer](../../../../../working-with-media/integrating-media/real-time-compositing-with-composure/real-time-compositing-with-sequencer/index.md)。下面的部分介绍与远程控制之间的集成。

### 关卡快照集成

在远程控制Web应用程序中，你可以获取关卡的新快照，或切换到以前远程获取的快照。如需在项目中使用关卡快照的更多信息，请参阅[关卡快照](../../../../collaboration-and-version-control/level-snapshots/index.md)。

> 图片已省略：Remote Control Level Snapshots

> [!NOTE]
> 必须启用关卡快照插件才能在远程控制Web应用程序中使用此功能。

### Sequencer集成

在远程控制Web应用程序中，你可以查看项目中的所有序列、按名称筛选以及选择要查看的序列。如需在项目中使用序列的更多信息，请参阅[Sequencer](../../../../../animating-characters-and-objects/cinematics-and-movie-making/index.md)。点击序列右侧的播放（Play）按钮图标，可以在当前关卡中启动或回复序列。序列开始播放之前可能会存在短暂的延迟。

> [!NOTE]
> 页面中的序列将按照其资产名称显示，而不是按照大纲视图中列出的名称来显示。在放入世界之后重新命名的资产将按照其在内容浏览器中的名称显示。

> 图片已省略：远程控制Sequencer集成

> [!NOTE]
> 此选项卡显示项目中的所有序列，但你只能播放当前关卡中存在的序列。筛选仅基于资产路径，因此目前无法根据关卡中存在的序列进行筛选。

## 控件

控件包含在Web应用程序中，用于表示引擎中可以交互的数据格式，以及为Web页面提供格式设置。

下面的列表显示你可以添加到UI的所有可用控件：

- 按钮
- 取色器
- 调谐钮
- 下拉菜单
- 摇杆
- 标签
- 列表
- 迷你取色器
- 面板
- 滑块
- 间隔物
- 选项卡
- 文本
- 开关
- 向量

**面板（Panel）** 控件用于包含所有其他控件，并且必须在放置其他控件之前进行放置。**列表（List）** 控件用于包含 **面板（Panel）**，以及在同一个 **选项卡（Tab）** 中提供多个UI。

## 属性

远程控制Web应用程序的"属性"选项卡中列出的属性和组直接与远程控制预设中的属性和组匹配。

> 图片已省略：Comparing properties in Web Application and Preset

将属性从Web应用程序的左侧托盘拖放到画布区域，以添加已经绑定到UI中属性的控件。如果属性已经在面板上释放，将自动添加到面板。如果没有面板，将创建空面板并将其封装到内部。

## 控件和属性设置

在 **设计（Design）** 模式下的Web页面中选择控件，设置面板将会显示在窗口的左下角。根据控件类型和它表示的数据，将显示不同的字段。

对于每种控件类型，你可以更改其标签。如果控件绑定到属性，你可以更改控件连接到哪种属性。

### 控件模式

某些数据格式（例如向量）在UI中可以用多种方法表示。

按照下面的步骤为你的控件更改模式。

1. 选择你要查看的控件以打开其设置面板。
2. 在控件的设置面板中，选择你要使用的模式。例如，对于向量，你可以选择 **摇杆（Joystick）**、**调谐钮（Dial）** 或 **滑块（Sliders）**。

   > 图片已省略：Select a widget's mode
3. 在选择模式时，游戏控制器图标显示在属性旁边。选择此按钮，在你选择的模式中打开属性。

   > 图片已省略：Click game controller button to open property
4. 模式显示在窗口底部。

   > 图片已省略：Widget mode appears at the bottom of the screen

### 删除控件

你可以逐个删除控件，也可以同时删除面板中的所有控件。要删除一个控件，请选择控件以打开其设置面板并选择 **删除控件（Delete Widget）**。要删除面板中的所有控件，请选择面板以打开其设置面板并选择 **删除控件（Delete Widget）**。

