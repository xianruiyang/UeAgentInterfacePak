---
title: "C++类向导"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-the-cplusplus-class-wizard-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "开发设置", "C++类向导"]
---

# C++类向导

> 路径：虚幻引擎5.7文档 / 用C++编程 / 开发设置 / C++类向导

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-the-cplusplus-class-wizard-in-unreal-engine

选择操作系统：

Windows

macOS

Linux

**C++类向导** 提供了一种快速而简单的方法，可将本地C++代码类添加到项目中，以便用户对自有的功能进行延展。 这会将纯内容的项目转换为一个代码项目。你可以像这样访问C++类向导，然后参照下述步骤新建C++类：

> [!NOTE]
> 开始前请确保已安装Windows桌面版Visual Studio 2019或更高版本。如使用的是Mac，则必须安装Xcode 9或更高版本。

1. 在主编辑器中选择 **工具（Tool） > 新建C++类（New C++ Class...）**

   ![Open a new CPP class from the menu bar.](../../../../assets/images/6f/6fe1096b886bcb0774726eab1b8913d881f1d236d7c2e600c4bf0346350b8221.jpg)
2. **C++类向导** 将出现，并默认显示 **常用类（Common Classes）**。如果你没有找到所需的类，可以点击窗口右上角的 **显示所有类** 勾选框并查看所有类。

   | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/c3502128-3bc4-415d-b5cc-67181f3c49a1/common-classes.png) | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/f4c7b3a4-5096-43d4-93a9-aa335e7d6acc/all-classes.png) |
   | --- | --- |
   | 常用类 | 所有类 |
3. 选择你要添加的类。在本文中，我们将选择新建 **Actor** 类。选择 **Actor** 类，然后点击 **下一步（Next >）**。

   ![undefined](../../../../assets/images/59/59aa6ed2da55ec81c99f7de41cc94078db007cb8ef23fda6ece0bd6dc49caea6.jpg)
4. 之后将弹出为新类输入 **命名** 的提示。执行此操作并点击 **创建类（Create Class）** 按钮。这将创建标头（`.h`）和源（`.cpp`）文件。

   ![undefined](../../../../assets/images/90/90f35f8e7f751e6e5eea2b58c193d34a5451a1a99c6ef911af6cd26a1d686ec4.jpg)

   > [!NOTE]
   > 类命名只包含字母数字字符，不包含空格。域将通知是否输入了无效命名。
5. 在虚幻引擎中，现在 **Live Coding** 会默认启用。新建类文件后，会显示Live Coding窗口并编译类文件。

   ![undefined](../../../../assets/images/7d/7d63f8fd38de8fc8efbb2f3925df02a830c9fe870f89177d41901a0f173ba50a.png)
6. 代码将立即在Visual Studio中打开，可进行编辑。

   代码将立即在Xcode中打开，可进行编辑。
