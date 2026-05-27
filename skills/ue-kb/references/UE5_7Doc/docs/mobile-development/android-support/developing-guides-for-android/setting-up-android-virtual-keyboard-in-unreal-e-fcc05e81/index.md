---
title: "Android虚拟键盘"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/setting-up-android-virtual-keyboard-in-unreal-engine-projects"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "Android支持", "Android开发指南", "Android虚拟键盘"]
---

# Android虚拟键盘

> 路径：虚幻引擎5.7文档 / 移动端开发 / Android支持 / Android开发指南 / Android虚拟键盘

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/setting-up-android-virtual-keyboard-in-unreal-engine-projects

所有基于Android的虚幻引擎项目都支持使用标准弹出对话框输入框或操作系统的虚拟键盘。在下面的文档中，我们将了解如何在UE4项目中设置和调用任一虚拟键盘。

![New Keyboard Input](../../../../../assets/images/4a/4a4d0d05d8761e55857b4b9d1606bda5b200f4bdaaae967f23190038c949c180.jpg)

![Old Keyboard Input](../../../../../assets/images/c0/c094370290b5328ccddf553fb69caab542db9c1ded61d139fc897bee4a6a26cf.jpg)

New Keyboard Input

Old Keyboard Input

## 步骤

要在项目中启用虚拟键盘，需要执行以下操作：

1. 在 **主菜单（Main Menu）** 中，转到 **编辑（Edit）**，然后单击 **Project Settings（项目设置）** 选项。
2. 在项目设置（ Project Settings）菜单中，转到 **平台（Platforms）** > **Android** ，在 **APK打包（APKPackaging）** 部分下，找到并单击 **启用改进型虚拟键盘[实验性]（Enable improved virtual keyboard [Experimental]）** 选项旁边的复选框以启用它。

   ![undefined](../../../../../assets/images/d0/d06fce7dbb3942ed77ca16e139812600f605aeb5604999781e5467bf1bd1dd29.jpg)

   单击显示全图。
3. 右键单击 **内容浏览器（Content Browser）**，然后转到 **用户界面（User Interface）** 并单击 **控件蓝图（Widget Blueprint）** 选项，为此新蓝图提供一个 **输入文本（Input Text）** 的名称。
4. 双击输入文本UMG（Input Text UMG）小组件以打开它，并从 **调色板（Palette）** 中将一个 **文本框（TextBox）** 拖动到UMG图中。

   ![undefined](../../../../../assets/images/57/57bf50cf53d08ec0713601e388485bb301e8e419a40fe664fb0b8c6cbb2731c6.png)

   单击显示全图。
5. 将 **文本框（TextBox）** 定位到画布面板的中间位置，然后按下 **编译（Compile）** 和 **保存（Save）** 按钮。

   ![undefined](../../../../../assets/images/98/98f74a80f2a8c749a25ac32c2a3d8db6ce9976cf4110291baf5f57d5d0e231f1.png)

   单击显示全图。

   > [!NOTE]
   > 请记住，应用程序负责确保：输入元素可见且不会被遮蔽在虚拟键盘后面。您可以使用提供的 **OnVirtualKeyboardShown** 和 **OnVirtualKeyboardHidden** 事件处理程序来确保UI元素不会遮蔽虚拟键盘。
6. 打开 **关卡蓝图（Level Blueprint）**，并将以下节点添加到事件图表（Event Graph）。

   ![undefined](../../../../../assets/images/05/05e68c0e76a285b2eb191e9f82ff5d59c6407d315d9a24af583ce68a1828e6f4.jpg)

   单击显示全图。

   - 事件开始运行（Event Begin Play）
   - 创建控件（Create Widget）
   - 添加视口（Add to Viewport）
7. 将 **事件开始运行（Event Begin Play）** 节点连接到 **创建控件（Create Widget）** 节点，然后将 **创建控件（Create Widget）** 节点连接到 **添加视口（Add to Viewport）** 节点。完成后，**关卡蓝图（Level Blueprint）** 应该如下图所示。

   ![undefined](../../../../../assets/images/20/20fcdf7eac2751013f9d431c490b0dc1c05dcf2424b258b29a14339fb0d00f81.jpg)

   单击显示全图。
8. 接下来，在创建控件蓝图（Create Widget Blueprint）节点的 **类（Class）** 输入中，添加之前创建的 **InputText** 控件蓝图。
9. 保存关卡，同时为它提供一个 **Android虚拟键盘（AndroidVirtualKeyboard）** 名称，然后打开 Project Settings（项目设置）并转到 **图与模式（Maps & Modes）**，在 **默认图（Default Maps）** 中，将 **Android虚拟键盘（AndroidVirtualKeyboard）** 图输入 **编辑器启动图（Editor Startup Map）** 和 **游戏默认图（Game Default Map）** 中。

   ![undefined](../../../../../assets/images/c0/c047f4c3433fc900d6faf04473b8828b1ba80a7cb479a72acd31e08d154f2217.jpg)

   单击显示全图。
10. 现在，在主菜单中，单击 **启动（Launch）** 旁边的白色小三角形，并从显示的列表中，选择您要部署UE4项目的Android设备。

## 最终结果

项目在Android设备上启动后，按下文本输入框，此时应该可以使用Android系统键盘输入所需的文本，如下面的视频所示。

您也可以使用 **Android新键盘（Android.NewKeyboard）** 控制台变量再结合以下任意一个数字来禁用虚拟键盘。当用户使用的语言需要不同IME（输入法编辑器）时，这样做特别有用。

| 命令名称 | 输入 | 说明 |
| --- | --- | --- |
| **Android.NewKeyboard** | 0 | 使用UE4编辑器中设置的复选框设置。 |
| **Android.NewKeyboard** | 1 | 强制使用新键盘。 |
| **Android.NewKeyboard** | 2 | 强制使用对话框。 |
