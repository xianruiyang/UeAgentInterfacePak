---
title: "打包iOS项目"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/packaging-ios-projects-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "iOS、iPadOS和tvOS", "打包和发布", "打包iOS项目"]
---

# 打包iOS项目

> 路径：虚幻引擎5.7文档 / 移动端开发 / iOS、iPadOS和tvOS / 打包和发布 / 打包iOS项目

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/packaging-ios-projects-in-unreal-engine

选择操作系统：

Windows

macOS

Linux

## 步骤

在下文中，我们将介绍如何使用UE4编辑器为你的项目创建 **.IPA**，并且让它之后无需UE4编辑器即可安装。

> [!NOTE]
> 如果要本地化iOS项目，你还需要翻译代码中的字符串。请参阅[本地化iOS项目中的"plist"和"NSLocalizedString"](../../developing-on-ios-tvos-and-ipados/localizing-plist-and-nslocalizedstring-in-an-ios-project/index.md)页面了解如何执行该操作的说明。

1. 如果你的设备尚未连接到计算机，请将其连接到计算机。
2. 在虚幻编辑器中打开你的项目。
3. 在 **文件（File）** 菜单中，选择 **打包项目（Package Project）> iOS**。
4. 在目录对话框中，为"`.ipa`文件选择要保存的位置。
5. 当打包游戏时，打包信息将出现在编辑器的右下角。
6. 当成功打包项目后，将显示一条消息。

## 最终结果

完成后，你即将有一个.IPA，可以将它部署到你的iOS设备。

## 步骤

在下面部分，我们将介绍如何创建你的UE4项目的 **.IPA**，无需UE4编辑器即可安装。

1. 如果你的设备尚未连接到计算机，请将其连接到计算机。
2. 在虚幻编辑器中打开你的项目。
3. 在 **文件（File）** 菜单中，选择 **打包项目（Package Project）> iOS**。
4. 在目录对话框中，选择你的项目的目录，因为打包的项目（`.ipa`文件）将位于此目录中。
5. 当打包游戏时，打包信息将出现在编辑器的右下角。
6. 当成功打包项目后，将显示一条消息。
7. 在Xcode中，前往 **窗口（Window）**，然后选择 **设置和模拟器（Devices and Simulators）**。
8. 在 **设备（Devices）** 部分中，按 **加号（Plus）** 符号图标以启动应用程序安装过程。 app_Install_xCode_2.png
9. 找到并选择UE4创建的 **.ipa**，然后按 **打开（Open）** 按钮以开始安装过程。
10. 安装进度将显示在 **设备（Devices）** 窗口的顶部。

## 最终结果

完成后，你将看到IPA已添加到你的iOS设备。
