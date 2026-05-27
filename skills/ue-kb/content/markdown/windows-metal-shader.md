# Windows Metal Shader编译器

---
title: "Windows Metal Shader编译器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-the-windows-metal-shader-compiler-for-ios-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "iOS、iPadOS和tvOS", "在Windows上开发iOS项目", "Windows Metal Shader编译器"]
---

# Windows Metal Shader编译器

> 路径：虚幻引擎5.7文档 / 移动端开发 / iOS、iPadOS和tvOS / 在Windows上开发iOS项目 / Windows Metal Shader编译器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-the-windows-metal-shader-compiler-for-ios-in-unreal-engine

> [!WARNING]
> The Windows Metal shader compiler currently does not work in UE 5.1 through UE 5.4.

**虚幻引擎** 可以在Windows机器上为Apple的 **Metal** API编译着色器，极大地简化了iOS应用程序的工作流。要启用此功能，你需要安装Apple的 **Metal Developer Tools for Windows** 工具集。设置此工具集之后，虚幻引擎将自动使用它。

## 步骤

要安装Metal Developer Tools for Windows，请按照以下步骤操作：

1. 在Web浏览器中登录你的 **Apple开发者账户（Apple Developer Account）**，然后导航至 **下载（Downloads）** 部分。
2. 在Downloads（下载）页面右上角的选项卡中，点击 **版本（Release）** 选项卡。

   ![测试版下载页面](../../../../../assets/images/57/579645ebbb156d0d8a8611b3f46423f33c2050b6d793cefab8248e5e40f4f35e.jpg)
3. 在Software Downloads（软件下载）页面中，点击 **应用程序（Applications）** 按钮。

   ![应用程序按钮](../../../../../assets/images/06/06354476d18713fa674c7f7dfd28506014bf3a8f31260f362ff03740ddf40250.jpg)
4. 向下滚动页面，直到找到 **Metal Developer Tools for Windows** 的条目，然后点击 **下载（Download）** 按钮开始下载安装程序。

   ![undefined](../../../../../assets/images/10/105649fe0717f24c834d76511e4f59f53acaa4334ba855fc32e2e5f44c44e8e3.png)

   Metal Developer Tools for Windows的下载条目。点击放大图像。
5. 运行安装程序以安装Metal Developer Tools。

## 最终结果

完成Metal Developer Tools for Windows的设置之后，你的Windows版虚幻引擎将能够为Metal 2.0编译着色器。无需额外设置。

