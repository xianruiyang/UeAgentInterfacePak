---
title: "使用iOS设备录制面部动画"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/recording-face-animation-on-ios-device-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "动画操作指南和示例", "使用iOS设备录制面部动画"]
---

# 使用iOS设备录制面部动画

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / 动画操作指南和示例 / 使用iOS设备录制面部动画

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/recording-face-animation-on-ios-device-in-unreal-engine

Apple最新型号的iPhone都提供了强大的面部识别和运动追踪功能，可区分用户面部50多种特定肌肉的位置、拓扑结构和运动变化。如果你的iPhone搭载了深度摄像头和ARKit功能，你就能使用Epic Games提供的免费的 **Live Link Face** 应用程序，以便在虚幻引擎中控制复杂的3D角色面部动画，并在手机和引擎中进行实时录制。

本页将介绍如何使用Live Link Face应用程序让3D角色的面部作出实时表演动作，以及如何将基于此方案实现的面部捕捉系统用于成熟的制作拍摄环境中。

> [!TIP]
> Live Link Face所依赖的ARKit功能正是 **面部AR示例（Face AR Sample）** 中用到的相同ARKit功能，你可以在Epic Games启动器的 **学习（Learn）** 选项卡中找到该示例。但是，需要为iOS编译面部AR样本，而这需要用到Mac和Apple开发人员帐户。借助Live Link Face应用程序，只要角色在虚幻引擎中设置得当，就能立即应用面部动画。

> [!NOTE]
> **先决条件：**
>
> - 本页出现的知识点涉及虚幻引擎中的不同工具和不同功能。若你对以下这些知识点已经十分熟悉，那么你将会感到事半功倍：
>
>   - Live Link插件
>   - 动画蓝图
>   - Sequencer
>
>     和
>
>     镜头试拍录制器
> - 你需要一台支持ARKit和深度API的iOS设备。

## 入门指南

请按照本部分中的说明设置虚幻引擎项目、连接Live Link Face应用程序，并将该应用程序记录的数据应用于3D角色。

1. 请为项目启用以下插件：

   - Live Link
   - ARKit
   - ARKit面部支持（ARKit Face Support）
2. 你需要准备一个已经设置好一组混合变形的角色，且这组混合变形需要与ARKit面部识别生成的面部混合变形相吻合。通常你需要在第三方绑定和动画工具（例如Autodesk Maya）中执行此操作，然后将角色导入虚幻引擎。

   欲知角色需要支持的混合变形列表，请参见[Apple ARKit文档](https://developer.apple.com/documentation/arkit/arfaceanchor/blendshapelocation)。

   > [!TIP]
   > 若你没有现成的角色可用，你可以在Epic Games启动器的 **学习（Learn）** 选项卡中找到 **脸部AR示例（Face AR Sample）** ，然后使用该示例中提供的男孩。

   > [!TIP]
   > 角色的混合变形不必使用与ARKit混合变形完全相同的名称。可在 **LiveLinkRemap** 资产中创建自定义蓝图函数，将ARKit混合变形名称转译为角色使用的名称。欲知说明，请参见[面部AR样本文档](../../../../sharing-and-releasing-projects/developing-for-xr-experiences/developing-for-handheld-augmented-reality-experiences/face-ar-sample/index.md)。但为了获得最佳效果，角色的面部混合变形须与ARKit混合变形覆盖相同的面部区域。
3. 在虚幻引擎中使用一个包含 **Live Link姿势（Live Link Pose）** 节点的动画蓝图来设置角色。举例而言，在面部AR示例中，男孩所用的动画蓝图中：

   ![动画蓝图中的Live Link姿势节点](../../../../../assets/images/ef/ef7bc410c2269e23385ea32c6dd928cc7ce708617ba1fd76d229603fe65e5a72.jpg)

   之后，在收到手机发送的动画数据后，你将通过此节点将数据应用到角色上。
4. 获取计算机的IP地址。需要IP地址才能连接Live Link Face应用程序。

   你通常可以在电脑的控制面板或设置中找到IP地址。或者，在多数Windows平台上，你也可以使用 **ipconfig** 命令行工具来确定IP地址。

   > [!TIP]
   > - 假如你的计算机已连接到因特网，并且拥有一个仅在你的网络中可见的本地IP地址和一个在因特网上公开的公共IP地址。如果是这样，则请你选择本地IP地址。本地IP地址通常以
   >
   >   10.
   >
   >   或
   >
   >   192.168.
   >
   >   开头。
   > - 你的计算机也可能为不同的适配器配置了多个IP地址。例如，你可能有一个有线以太网适配器和一个无线适配器，每个适配器都有自己的地址。请确保无论你的计算机使用哪个适配器，该适配器所用的IP地址都能让它与你的iPhone处于相同的网络中。
5. 在Apple App Store上找到Epic Games发布的免费 **Live Link Face** 应用程序，然后安装在手机上。

   ![Live Link Face图标](../../../../../assets/images/9c/9ccb4f9115386c0eea54cf0f56cf3fb52037e2caa0f4a35b0115d2b37f556723.png)
6. 将手机和计算机连接到同一无线网络；或使用以太网网线，通过Lightning以太网适配器将手机直接连接到计算机。

   > [!NOTE]
   > Live Link需要网络数据源，因此仅通过USB将手机连接到计算机并不够。
7. 在iPhone上运行Live Link Face应用程序。你将进入主画面，并能开始新的录制。

   ![Live Link Face with overlaid mesh](../../../../../assets/images/d7/d7a9623a37dc82bc3ad823765a6da2c9df58a398474c52df3662222703ea336a.jpg)

   点击查看大图。

   > [!TIP]
   > 当你首次启动时，你会看到摄像头拍摄的图片被ARKit面部识别系统生成的三角形网格体覆盖。你可以关闭 **预览网格体（Preview Mesh）** 设置，禁用覆盖层，只查看你的面部（如上图所示）。请参阅下文内容[LiveLinkFace应用程序控制选项](#livelinkface%E5%BA%94%E7%94%A8%E7%A8%8B%E5%BA%8F%E6%8E%A7%E5%88%B6%E9%80%89%E9%A1%B9)。
8. 点击左上方的图标，打开应用程序设置。至少需要进入 **LiveLink** 设置才能连接到计算机。

   ![LiveLink settings](../../../../../assets/images/b3/b39a7d366aeaa4b55d9018e714365e2ca94ee3b724f2b243d6d3ff5213c7a9aa.jpg)

   点击查看大图。

   在LiveLink设置页面中点击 **添加目标（Add Target）**，然后输入计算机的IP地址。

   > [!TIP]
   > 如果你希望将动画广播到多台虚幻编辑器实例上，你可以在此处输入多个IP地址。更多信息，请参阅下文内容[多用户设置](#%E5%A4%9A%E7%94%A8%E6%88%B7%E5%8D%8F%E4%BD%9C)。

   有关Live Link Face应用程序可用的所有其他设置的细节，请参见以下部分。
9. 在虚幻编辑器中，在主菜单中选择 **窗口（Window） > Live Link**，打开 **Live Link** 面板。现在，你可以看到iPhone被列为主题。

   ![Live Link主题](../../../../../assets/images/7c/7cba8748386e1aec2af85bea78fd025e62052f6137379497d8645dba98df749e.jpg)
10. 在角色的动画图表中找到 **Live Link Pose** 节点，将其主题设置为代表iPhone的主题。

    ![拥有主题的Live Link姿势节点](../../../../../assets/images/84/8452a6caddee128121743b002981bf513bab78311fbf7498d30bcb87aec1d6c6.jpg)
11. **编译（Compile）** 并 **保存（Save）** 动画蓝图。
12. 选择角色。在 **细节（Details）** 面板中，须启用 **骨架网格体（Skeletal Mesh）** 类别中的 **在编辑器中更新动画（Update Animation in Editor）** 设置。

    ![在编辑器中更新动画](../../../../../assets/images/10/108cddd39fc6f3d91b774ac428b65fcba5f6ab44f0dac49828e2b6657b62e9ad.jpg)
13. 返回Live Link Face，将手机摄像头对准你的脸部，直到应用程序识别出人脸并开始追踪你的脸部动作。

    此时，你会看到虚幻编辑器中的角色开始移动面部，以实时匹配你的面部动作。
14. 当你准备要录制表演时，请点击Live Link Face应用程序中的红色 **录制（Record）** 按钮。这将开始在iPhone上录制表演，并在虚幻编辑器中启动镜头试拍录制器，开始在引擎中的角色上记录动画数据。

    再次点击 **录制（Record）** 按钮停止录制。

## 设置头部旋转

假如要用Live Link Face中的数据将头部旋转应用到Actor身上，你首先要设置蓝图的事件图表和动画图表，以便控制头部的关节。

### 头部旋转蓝图 - 事件图表

此蓝图位于你的角色的动画蓝图的事件图表中。它会读取Live Link中表演数据的偏转、滚动和俯仰数据，然后将其应用到角色身上合适的骨骼位置。

![将此添加进动画蓝图事件图表](../../../../../assets/images/f7/f7f450778f91d405492d4945acb15118fc114695757dc01777e4ee70a06e438b.jpg)

点击查看大图。

1. 右键点击蓝图并添加

   事件蓝图更新动画（Event Blueprint Update Animation）

   节点。这能确保动作发生变化时，头部位置能每帧更新。
2. 接着，在我的蓝图面板中创建三个浮点变量，分别命名为

   HeadRoll

   、

   HeadYaw

   和

   HeadPitch

   。将它们全部拖进蓝图并选择

   设置

   变量。
3. 拖动"事件蓝图更新动画"（Event Blueprint Update Animation）节点，创建一个

   Evaluate Live Link Frame

   节点。这样就能提供来自Live Link源的数据，该数据会被保存在你的浮点变量中。
4. 使用

   主题（Subject）

   下拉菜单，选择代表你iPhone的主题。
5. 打开

   角色（Role）

   下拉菜单，然后选择

   LiveLinkBasicRole

   。
6. 在"Evaluate Live Link Frame"附近点击右键，然后创建三个

   获取属性值（Get Property Value）

   节点。它们将被用于从Live Link应用获取偏转、滚动和俯仰信息。使用各个节点上的

   属性名称（Property Name）

   方框，分别设置成

   headYaw

   、

   headRoll

   以及

   headPitch

   。
7. 将"Evaluate Live Link Frame"的

   Valid Frame

   输出连到上图中的

   Set

   变量。
8. 最后，将各个 "Get Property Value"节点的

   变量（Value）

   输出连到其对应设置变量节点的浮点输入上。

### 头部旋转蓝图 - 动画图表

从App获取头部和颈部旋转数据后，就可以在动画图表中将它们应用到角色的骨骼上了：

> 图片已省略：将此添加进动画蓝图动画图表

点击查看大图。

上述部分添加在动画图表的末尾位置，正好位于"输出姿势（Output Pose）"节点的前面。

1. 在

   输出姿势（Output Pose）

   的后面，拖动

   Result

   并创建一个

   Component To Local

   节点。
2. 接着，你需要为角色骨架中所有会受到旋转数据影响的头部和颈部骨骼准备一个

   Transform (Modify) Bone

   节点。如果你用的是Face AR示例中的风筝男孩，你就需要两个（该节点）。
3. 在蓝图中分别点击各个节点，将细节面板中的"Bone to Modify"设置成正确的骨骼名称。如果是风筝男孩，就应该是

   neckRoot

   和

   head

   。
4. 如上图所示，将第一个节点的输出连接到下个节点的

   组件姿势

   输入。
5. 在每个"Transform (Modify) Bone"节点中，点击

   Translation Space

   选项所在的下拉菜单，将它改为

   Bone Space

   。
6. 在 "Transform (Modify) Bone" 节点的细节面板中，找到

   旋转（Rotation）

   分段然后将

   旋转模式（Rotation Mode）

   改为

   添加到已有（Add to Existing）

   ，然后将

   旋转空间（Rotation Space）

   改为

   骨骼空间（Bone Space）

   。
7. 现在找到你在事件图表中准备好的偏转、俯仰和滚动数据，创建一个旋转度（Rotator）来更新头部和颈部的骨骼。将你之前创建的浮点变量拖进来，然后选择

   获取

   变量。
8. 分别拖动这几个变量的输出引脚并创建

   浮点 x 浮点

   节点。将"Pitch"乘以15，将"Yaw"和"Roll"乘以 -15。你可能需要调整这几个参数才能获得合适的效果。你可能需要尝试正值和负值才能获得合适的旋转角度。
9. 设置完乘数后，你可以创建旋转度。右键点击蓝图面板，创建一个

   创建旋转度（Make Rotator）

   节点。
10. 将偏转乘数连到 "Make Rotator" 的

    X (Roll)

    输入。
11. 将俯仰乘数连到

    Z (Yaw)

    。
12. 最后，将滚动乘数连到"Y (Pitch)"。
13. 将"Make Rotator"的输出连到各个"Transform (Modify) Bone"节点的旋转输入。
14. 最后，创建一个

    Live Link Pose

    节点并将

    Live Link Subject Name

    设置为你的iPhone。拖动输出并创建

    Local to Component

    节点。
15. 将它的输出连接到第一个"Transform (Modify) Bone"节点的"Component Pose"输入。

> [!NOTE]
> 偏转、俯仰和滚动连接可能需要经过调整才能获得正确的旋转效果。检查旋转效果的最佳方法是，在完成设置后，进入软件实时测试一下。你的角色应该会与你一起移动。如果你向左倾斜头部，你的角色应该会同步向左倾斜。

点击"在编辑器中运行"，测试头部的旋转效果。你的角色现在应该会根据Live Link录制到的内容，同步旋转头部。

## LiveLinkFace应用程序控制选项

Live Link Face应用程序的主画面中有以下功能按钮。

> 图片已省略：Live Link Face UI

点击查看大图。

| 列 1 | 列 2 |
| --- | --- |
| 1 | 打开设置对话框。 |
| 2 | 切换是否将面部动画数据发送到所有LiveLink目标。以绿色高亮显示时，表明应用程序正在发送动画数据。 实时状态下，还会列出从应用程序设置中配置的时间码源读取的当前时间码值。 |
| 3 | 切换视频显示和面部追踪的开启和关闭。 |
| 4 | 开始和停止录制新镜头试拍。 |
| 5 | 打开之前由应用程序录制的镜头试拍列表。 |
| 6 | 显示当前的slate和镜头试拍，以及LiveLink主题名称。点击可重命名当前slate或更改镜头试拍编号。 |
| 7 | 以绿色高亮显示时，表示ARKit面部捕捉系统能够在当前拍摄画面中成功检测到面部。 |

## Live Link Face应用程序设置

点击主画面左上方的图标进入设置页面，可在其中配置应用程序的行为。

| 设置 | 说明 |
| --- | --- |
| LiveLink | 将应用程序配置为连接到运行虚幻引擎的计算机，以便其通过Live Link发送动画数据并控制录制。 |
| 时间码（Timecode） | 配置Live Link Face应用程序的时间码源。如需了解详情，请参阅下文中的[时间码源](#%E6%97%B6%E9%97%B4%E7%A0%81%E6%BA%90)一节。 |
| OSC | 配置Live Link Face应用程序与外部OSC控制器和设备之间的连接。欲知详情，请参见下文小节[通过OSC控制Live Link Face](#%E9%80%9A%E8%BF%87osc%E6%8E%A7%E5%88%B6livelinkface)。 |
| 校准（Calibration） | 打开[校准](#%E6%A0%A1%E5%87%86)菜单。 |
| 流送头部旋转 | 确定应用程序是否通过Live Link连接发送ARKit的头部旋转数据（偏转/俯仰/旋转）。 假如你将手机放置在固定的三脚架上，并且希望一边对着手机上下左右移动头部，一边使用Live Link Face应用程序来控制虚拟头部的动作，那么你可以启用此选项。 假如你想让Live Link Face应用程序与身体动作捕捉系统搭配使用，那么可能就不需要启用这个选项。相反，你可以将iPhone固定在你的头盔上，这样它就始终处于你的脸的正前方，然后你可以让身体动作捕捉系统记录你的头部的上下左右移动情况。 |
| 预览网格体（Preview mesh） | 确定在主画面中，是否用ARKit面部识别系统生成的三角形网格覆盖拍摄画面。 |
| 录制按钮（Record button） | 确定红色的录制（Record）按钮在主画面上是否可见。 若要从外部OSC设备切换录制，则可能要禁用此选项，以免演员意外触碰手机按钮。 |
| Blendshape数据（Blendshape data） | 确定主画面是否显示ARKit面部识别系统为所有面部混合变形生成的数据值。此信息通常仅用于调试。 |
| 镜头试拍录制器（Take Recorder） | 确定主画面是否将显示当前slate名称和镜头试拍编号，或用于当前录制的文件名。 |
| 覆层（Overlay） | 确定Live Link Face应用程序主画面是否始终可见，或者在与触摸屏交互之前是否隐藏。 退出覆层可以防止演员在表演期间因为看到采集的视频而分心。 |
| 视频质量（Video Quality） | 确定用于编码参考视频的JPEG压缩质量。质量越高，生成的图像越清晰，但是相应地会占用更多iPhone存储空间。 |
| 存储（Storage） | 显示设备上的可用空间大小，以及Live Link Face正在使用的空间大小。也可使用此画面删除此前录制的镜头试拍。 |
| 重置（Reset） | 可将Live Link Face应用程序重置为出厂设置，撤消自安装该应用程序以来对上述设置所做的更改。 |
| 关于（About） | 显示该应用程序的相关法律信息。 |

## 原始面部录制

每当你从Live Link Face应用程序启动新录制时，捕捉信息都会在iPhone上被记录为两个文件：

- 一个 `.mov` 文件，其中包含摄像头录制的参考视频。

  视频帧使用JPEG编码解码器压缩，但拥有帧精度，未经临时压缩。该文件包含音频和时间码，可作用参考，以便动画师在录制后处理动画表演。
- 一个 `.csv` 文件，其中包含ARKit在录制过程中捕捉到的原始动画数据。

  你可以从iOS设备导出此.csv文件，并将其导入虚幻引擎中，就像你在镜头试拍录制器中录制的一样。阅读下方章节，了解如何从Live Link提取.csv录制文件，并使用它驱动虚幻引擎中的面部动画。此文件中的原始数据也可以帮助开发人员围绕面部捕捉构建更多工具。

### 从iOS设备提取.CSV面部录制文件

有两种方法能够从iOS设备中提取出 `.csv` 格式的原始Live Link面部录制文件。最简单的方法是，从Live Link应用程序本身中共享镜头试拍，但你也可以在iOS文件应用中找到 `.csv` 文件，并手动传输或共享。

#### 通过Live Link应用程序共享

1. 点击主屏幕左下角的 **镜头试拍浏览器** 图标。

   > 图片已省略：打开镜头试拍浏览器
2. 点击 **选择（Select）** ，然后选择你想从设备提取的 **镜头试拍（Takes）** 。

   > 图片已省略：选择镜头试拍
3. 点击 **共享** 图标，并选用一种iOS内置的共享功能，例如隔空投送或邮件。

   > 图片已省略：共享选项

> [!TIP]
> 隔空投送是从设备共享Live Link镜头试拍的最可靠选项。 提取大量镜头试拍或长镜头可能会对第三方服务（例如Google Drive）造成问题。 iOS共享功能对于集成的非Apple服务经常会出错。

#### 通过iOS文件应用程序传输

iOS文件应用程序提供了多种备用方法来从iOS设备提取文件。 阅读[Apple文档](https://support.apple.com/guide/iphone/transfer-files-iphone-computer-iphf2d851b9/ios)了解如何在iOS设备和计算机之间传输文件。

Live Link应用程序会将原始面部录制文件存储在iOS设备上的 **Files** > **Browse** 文件夹中名为 **Live Link Face** 的文件夹中。

> 图片已省略：Live Link应用程序位置

打开 **Live Link Face** > **镜头试拍（takes）** ，然后点击你想要分享的镜头试拍的文件夹。原始 `.csv` 文件就位于该文件夹中。

> 图片已省略：undefined

点击查看大图。

如需共享 `.csv` 文件，你可以点击它，并在快捷菜单中选择一个共享选项。

### 在虚幻引擎中使用.CSV面部录制文件

此过程需要本文档开头的[入门](#%E5%85%A5%E9%97%A8)章节中列出的所有三个插件，以及 **LiveLinkFaceImporter** 测试版插件。

1. 找到 **编辑（Edit）** > **插件（Plugins）** ，打开插件浏览器。搜索 **LiveLinkFaceImporter** 并启用该插件。重启编辑器，然后继续。

   > 图片已省略：启用Live Link Face导入器
2. 点击 **内容浏览器（Content Browser）** 中的 **导入（Import）** ，然后导入你想使用的Live Link `.csv` 文件。

   > 图片已省略：导入Live LInk CSV镜头试拍
3. UE将在内容浏览器中使用与 `.csv` 文件相同的名称创建新的 **关卡序列（Level Sequence）** 资产。

   > 图片已省略：Live Link关卡序列
4. 双击此资产，在 **Sequencer** 中打开关卡序列。点击轨道名称旁边的下拉插入符号，就能看到来自所有不同面部混合形状的关键帧数据。

   > 图片已省略：undefined

   点击查看大图。

#### 将.CSV文件应用于MetaHuman角色

要将关卡序列用于某个角色，请在Sequencer中将其打开，然后在配置了你的Live Link源的地方将其设置为主题。关卡序列会出现在选项中。要在MetaHuman上播放动画，你可以选择MetaHuman蓝图，然后在 **细节面板（Details Panel）** 的 **Live Link** 分段中配置以下设置。

> 图片已省略：MetaHuman蓝图设置

1. 勾选该复选框以启用

   使用ARKit面部（Use ARKit Face）

   。
2. 在

   ARKit面部主题（ARKit Face Subj）

   下拉菜单中，选择匹配你导入的

   .csv

   的主题。

这些设置也可从MetaHuman蓝图的事件图表中访问。

> 图片已省略：undefined

点击查看大图。

现在，当你在Sequencer中播放关卡序列时，面部动画就绑定到你的MetaHuman角色了。

## 校准

为了提升面部追踪质量，你可以捕捉一张你的面部在自然状态下的"休息"姿势，校准Live Link Face应用，从而让应用更好地响应你的面部变化。

要启用校准，打开Live Link Face应用程序，打开左上方的 **设置** 图标，然后点击 **校准**。现在，你应该能看到校准菜单，你可以点击 **启用** 按钮来启用该功能。

> 图片已省略：face应用程序校准

> [!NOTE]
> 你可以选择性地启用 **倒计时（Countdown）** 功能；它会在你校准图像后，打开一个持续三秒的计时器。

现在，回到Live Link Face主屏幕后，会在右下方出现一个新的 **校准（+）** 按钮。点击它将启用一个特殊的"校准模式"，可以将 **录制** 按钮的功能变为校准捕捉。

> 图片已省略：face应用程序校准按钮

如需校准你的面部，请点击 **校准** 按钮。然后，朝向设备摄像头，确保面部处于自然放松状态，没有表情，按下 **录制** 按钮。校准图像会被立即拍摄，或者，拍摄前会有一个三秒倒计时（如果在校准设置中启用了 **倒计时** 功能的话）。

拍摄完校准图像后，你可以选择 **保存** 或 **删除**，以便再次尝试。如果你选择保存，然后再次点击 **校准** 按钮，将显示 **重新校准** 选项以便拍摄新图像，或者显示 **删除** 校准。

## 录制模式和结果

每当通过iPhone上的Live Link Face应用程序或通过Unreal Face应用程序的OSC界面启动录制时，表演都会记录到手机中，正如上一部分中所介绍的那样。你不必连接虚幻引擎实例就能以此方式录制。

当你使用Live Link Face应用程序或通过OSC界面开始录制时，假如iPhone已经通过Live Link与虚幻引擎的实例相连接，则 *还* 将在所有连接上的虚幻引擎实例中启动镜头试拍录制器。动画表演将同时记录在iPhone和计算机上的镜头试拍录制器中。

若通过Live Link连接到虚幻引擎的一个或多个实例，并且在虚幻编辑器界面中从镜头试拍录制器启动录制，*而不是* 从iPhone或OSC界面启动录制，则表演 *不会* 保存到iPhone上。它只会记录在计算机的镜头试拍录制器中。

## 多用户协作

在一些更为复杂的现实场景制作中，可能会有多个操作员同时在虚幻引擎中工作，需使用多用户编辑[多用户编辑](../../../../production-pipeline/multi-user-editing/index.md)在同一虚拟场景中实时协作。在这种情况下，建议将Live Link Face应用程序配置到连接至所有操作员运行的 *所有* 虚幻引擎实例。该应用程序会将表演捕捉组播到所有引擎实例，以便所有操作员都能以最小延迟在情境中看到传入的动画数据。

## 时间码源

在现实制作中，Live Link Face很可能只是充当大型表演捕捉制作中的一个环节。你可能需要同时记录其他内容：音频、实时视频、其他人体捕捉数据、摄像机追踪数据等等。为了能以最佳精度同步这些单独记录，所有录制须嵌入一致的时间码值。

针对时间码源，Live Link Face提供了三个选项，可在设置面板中进行配置。

- **系统定时器**

  默认情况下，Live Link Face的时间码值基于iPhone的系统定时器。此定时器基于自上次系统重启以来的实际耗时。此选项能提供一种相对自身十分精确的时间码，但很难将此时间码与其他设备上的录制关联起来。
- **NTP服务器**

  有一种方法能让你获得与一天中的时间始终同步的时间码，那就是通过网络时间协议（NTP）从服务器获取时间值。若选择此选项，则默认服务器为 **time.apple.com**，即Apple用于同步iPhone时间的服务器。但是，假如你希望像许多制片商那样使用自定义NTP服务器为舞台设备同步时间码，则你可以自行输入服务器名称和IP地址。
- **Tentacle同步**

  Tentacle同步是一种第三方硬件设备，它允许设备通过蓝牙与拍摄现场的主时钟同步。这可能是最专业的时间码同步方式；高端制片通常会在拍摄过程中依赖主时钟同步时间码。欲知详情，请参见[Tentacle同步](https://tentaclesync.com/)。

## 通过OSC控制LiveLinkFace

Live Link Face应用程序支持通过[开放声音控制（OSC）](https://en.wikipedia.org/wiki/Open_Sound_Control)协议进行双向通信。

- 可使用OSC设备远程控制Live Link Face。例如可以使用外部设备远程启动应用程序录制。
- 还可配置Live Link Face，将活动通知发送到其他OSC设备。举例而言，只要该应用程序开始新的录制，就可以在其他设备上触发操作。

要设置OSC，请打开应用程序设置：

- 在 **侦听器（Listener）** 部分中，可看到iPhone的当前IP地址以及Live Link Face应用程序正在监听的、用于传入OSC消息的端口。需OSC远程控制设备将命令发送到此IP地址和端口。
- 若要Live Link Face发送OSC命令控制另一台设备，请在 **目标（Target）** 部分中输入该设备的IP地址和端口。

Live Link Face应用程序支持以下OSC命令：

| 命令 | 说明 |
| --- | --- |
| `/OSCSetSendTarget <IP:string> <port:int32>` | 将OSC发送目标设置为给定的IP地址和端口。该应用程序通过命令 `/OSCSetSendTargetConfirm` 回复新的OSC发送目标。 |
| `/AddLiveLinkAddress <IP:string> <port:int32>` | 为应用程序添加新的Live Link目标，以广播混合变形数据。 |
| `/ClearAllLiveLinkAddresses` | 删除所有Live Link目标。 |
| `/LiveLinkSubject <name:string>` | 设置Live Link主题名称。 |
| `/LiveLinkStreamStart` | 开始将数据流送到所有Live Link目标。 |
| `/LiveLinkStreamStop` | 停止将数据流送到Live Link目标。 |
| `/BatteryQuery` | 请求设备的电池电量。该应用程序通过 `/Battery <level:float32>` 回复OSC发送目标。 |
| `/ThermalsQuery` | 请求设备的发热状态。该应用程序通过 `/Thermals <state:int32>` 回复OSC发送目标。 |
| `/Slate <name:string>` | 将slate设为给定名称。 |
| `/Take <number:int32>` | 将镜头试拍编号设为给定值。 |
| `/ARSessionStart` | 打开视频和AR追踪。该应用程序通过命令 `/ARSessionStartConfirm` 回复OSC发送目标。 |
| `/ARSessionStop` | 关闭视频和AR追踪。该应用程序通过命令 `/ARSessionStopConfirm` 回复OSC发送目标。 |
| `/RecordStart <slate:string> <take:int32>` | 使用给定slate和镜头试拍编号开始录制。该应用程序通过 `/RecordStartConfirm <timecode:string>` 回复OSC发送目标。请注意，此时时间码固定为 `00:00:00.000`。 |
| `/RecordStop` | 停止录制。该应用程序通过 `/RecordStopConfirm <timecode:string> <blendshapesCSV:string> <referenceMOV:string>` 回复OSC发送目标。可使用下面 `/Transport` 命令中的两个字符串从设备复制数据。 |
| `/Transport <IP:port:string> <path:string>` | 使用 `/RecordStopConfirm` 命令返回的路径（上述），请求应用程序将文件内容传输到指定的IP地址和端口。该应用程序将打开到该地址和端口的TCP连接。首先以大端（big-endian）格式发送一个包含文件总大小的 `int32` 。然后发送文件内容。 |
| `/VideoDisplayOn` | 打开视频显示。 |
| `/VideoDisplayOff` | 关闭视频显示。追踪和录制仍会发生。 |
| `/AppActivated` | 该应用程序在手机上变为活动状态时，会将此内容发送到OSC发送目标。即首次启动时会进入前景，等等。 |
| `/AppDeactivated` | 该应用程序在手机上变为非活动状态时，会将此内容发送到OSC发送目标。即停止时发送到背景，等等。 |
