# 全景采集（Panoramic Capture）工具快速入门

---
title: "全景采集（Panoramic Capture）工具快速入门"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/panoramic-capture-tool-quick-start-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体捕获", "全景采集工具", "全景采集（Panoramic Capture）工具快速入门"]
---

# 全景采集（Panoramic Capture）工具快速入门

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体捕获 / 全景采集工具 / 全景采集（Panoramic Capture）工具快速入门

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/panoramic-capture-tool-quick-start-for-unreal-engine

> [!WARNING]
> Epic Games不再支持或维护全景采集插件。它只在你希望自行创建解决方案时作为参考存在。该插件可能无法正常工作。

在以下示例中，你将了解如何设置、创建和查看立体全景截屏——以上操作均需在UE4中进行。在完成此项目后，你将创建一张全景图片。

## 1 - 项目设置

在这部分中，我们将新建一个UE4项目并对其进行设置。

### 步骤

1. 用 **游戏（Games）> 第一人称（First Person）** 模板创建一个新项目，并使用以下设置：

   - 蓝图（Blueprint）
   - 目标平台台式机（Target Platform Desktop）
   - 质量预设最大（Quality Preset Maximum）
   - 启用

     初学者内容（Starter Content）

   ![Project Settings](../../../../../assets/images/35/358f904c3525f3434ffe0ed231ec54279adb436cdae58a54799d1216e4818cf2.jpg)

   点击查看大图
2. 按 **新建（Create）** 按钮加载新项目。

   > [!NOTE]
   > 适用于所有项目。以上列出的值只是提供了一个创建项目的起点。
3. 项目打开后，从主菜单中选择 **编辑（Edit）** > **插件（Plugins）**。

   ![选择插件](../../../../../assets/images/de/deb938d32cfe680321a118c041f3473b15d42ae35aebdf16e0f4e294aaebb8db.png)
4. 在 **插件（Plugins）** 菜单下的 **影片采集（Movie Capture）** 中启用 **全景采集（Panoramic Capture）** 插件。弹出提示后重启编辑器。

   ![Enable Panoramic Capture Plugin](../../../../../assets/images/49/4998a87992e3f28643553d2ab7b9c4f302dd2b5d0256e7e8ec8d63cdfb5e40d0.jpg)

   点击查看大图

## 2 - 截取立体图像

在这步中，你将使用 **全景采集（Panoramic Capture）** 插件和 **BP_Capture** 蓝图来采集关卡的3D立体图像。

### 步骤

1. 打开

   内容侧滑菜单

   ，选择

   全景采集内容（PanoramicCapture Content） > 资源（Assets）

   。

   ![资产文件夹](../../../../../assets/images/12/1217c1186cc7fa0af738f79622ec16df9e5100f25e464f533763b83ae67e5234.jpg)

> [!NOTE]
> **内容Assets Folder** 不会默认显示插件内容。要修改此设置，请选择 **设置（Settings)** 并启用 **显示引擎内容（Show Engine Content）** 和 **显示插件内容（Show Plugin Content）**。

1. 将 **BP_Capture** 蓝图拖到场景上。
2. 点击 **运行（Play）** 开始运行 **BP_Capture** 蓝图并开始采集进程。

   ![Click the Play Button](../../../../../assets/images/cc/cc103e6a9cdb077f1b73cea91ce9895179925185554fb91d6d7983c117bffe80.png)

   点击查看大图
3. 在采集过程中，编辑器可能失去响应数秒甚至数分钟。这是由于 **全景采集（Panoramic Capture）** 插件存在渲染需求。编辑器重新获得响应后，即可在以下路径中找到截图。

   - C:\PanoramicCaptureFrames[Date & Time]\FinalColor\Frame_00000_FinalColor.png

   ![Image Folder](../../../../../assets/images/ac/acac0cbf30174528ecb431492f0f86ff7181e4e73f3b01c6d4a43f0dceba347c.png)

   点击查看大图
4. 此处是由 **BP_Capture** 蓝图生成的立体图像。

   ![Stereo Image](../../../../../assets/images/32/328852ee281e02a9831b1bef7ca63aa64c83de4f4938ec0230f9ab6e732a9ac0.jpg)

   点击查看大图

   > [!NOTE]
   > **BP_Capture** 蓝图的默认输出为8位图像（.png），可在蓝图中选择设置32位图像（.exr）。

