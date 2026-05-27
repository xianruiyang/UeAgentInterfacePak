# 设置适用于虚幻引擎的ShotGrid项目

---
title: "设置适用于虚幻引擎的ShotGrid项目"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/setting-up-a-shotgrid-project-to-work-with-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "虚幻引擎与Autodesk ShotGrid", "设置适用于虚幻引擎的ShotGrid项目"]
---

# 设置适用于虚幻引擎的ShotGrid项目

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 虚幻引擎与Autodesk ShotGrid / 设置适用于虚幻引擎的ShotGrid项目

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/setting-up-a-shotgrid-project-to-work-with-unreal-engine

> 图片已省略：ShotGrid Project in Unreal Editor

设置ShotGrid项目以与虚幻引擎4配合工作的流程与内容流程中的其他应用程序（例如，Autodesk Maya或3ds Max、或Foundry Nuke）的流程相似。你将需要将ShotGrid项目配置为使用 *工具包引擎*，它是一系列工具和脚本，旨在让ShotGrid项目了解虚幻引擎并将ShotGrid工具和工作流集成到虚幻编辑器界面。

针对每个要与虚幻引擎配合使用的ShotGrid项目，只需进行一次本页面中列出来的配置。此配置通常由ShotGrid管理员完成。如果你已设置过ShotGrid项目并将它们配置为与其他内容创建工具集成，那么此流程对你来说应该相当熟悉了。如果对此流程不太熟悉，请参阅以下资源：

- [集成用户手册](https://developer.shotgridsoftware.com/d587be80/?title=Integrations+User+Guide)总体概述了如何快速上手使用ShotGrid集成。
- [集成管理员手册](https://developer.shotgridsoftware.com/a944bb05/?title=Administration)对流程配置进行了详细说明。

## 开始之前

我们建议你使用GitHub上tk-config-unrealbasic](https://github.com/ue4plugins/tk-config-unrealbasic)库中已为你设置好的项目配置。此配置对基本ShotGrid工具包配置进行了扩展，增加了构成虚幻集成的元素。我们还在[tk-config-unreal](https://github.com/ue4plugins/tk-config-unreal)库中提供了第二个示例项目，它相当于ShotGrid的default2配置。

- 要使用GitHub中的这一配置，计算机上必须安装有Git。如果尚未安装Git，

  请从此处下载

  。
- 从网站的 **Apps** 菜单下载并安装 **ShotGrid Desktop** 应用程序。

  ![Downloading ShotGrid Desktop via the ShotGrid Apps menu](../../../../assets/images/94/94c9fe2f554dcf1c27e690ff972e5f5f160fca77ab790a3acc52262988e4e585.jpg)

## 1 - 将虚幻引擎软件添加到ShotGrid

在此步骤中，你需要将虚幻引擎集成作为新软件添加到你的组织。

1. 在网页浏览器中登录你所在组织的ShotGrid页面。然后在用户菜单中选择 **Software**。

   ![undefined](../../../../assets/images/2e/2e19259d67a338047b35dfef76a79ebce0ef369d9aa64838c87453654f7b12db.jpg)
2. 在 **Software** 页面上点击 **Add Software** 按钮。

   ![undefined](../../../../assets/images/51/51482d94c0c2990184081fed03e80311210cdd7aff38392d77bf397c6471a933.png)
3. 将 **Software Name** 设置为 **Unreal Engine**，并将 **Engine** 设置为 **tk-unreal**。

   ![undefined](../../../../assets/images/65/65313fd05bd4a155ca0244aee867c286bc27ec5231579d24490bc8f4f0715a32.png)
4. 点击 **Create Software**。 在返回 **Software** 页面后，你将可以在列表中看到新添加的虚幻引擎条目。

   ![undefined](../../../../assets/images/9c/9cd2d5f6263b0ac5a6f06a47c377bbeaf29334d0b12494f087a4aee38d875a6a.png)

### 最终结果

ShotGrid现在已经得知了虚幻引擎集成的存在，你可以继续按照以下步骤将组织中的ShotGrid项目与虚幻编辑器配合使用。

## 2 - 设置ShotGrid项目

在此步骤中，你将在ShotGrid项目中添加一个 **管线配置（Pipeline Configuration）**，并使用[分发配置](https://developer.shotgridsoftware.com/tk-core/initializing.html#distributed-configurations)部署它。这会在所有能够访问ShotGrid网站的项目用户间共享该配置。如有需要，你也可以根据ShotGrid的文档指导，在磁盘上设置一个[集中式配置](https://developer.shotgridsoftware.com/tk-core/initializing.html#centralized-configurations)。

要向ShotGrid项目添加管线配置，请执行以下操作：

1. 从GitHub上下载[最新版tk-config-unrealbasic](https://github.com/ue4plugins/tk-config-unrealbasic/releases)的.zip文件。

   ![undefined](../../../../assets/images/a4/a4171fe1ec73ad1aecae1d4721c3f80d893720422678c24639dedccfb207ea30.png)
2. 在你的ShotGrid网站上，打开项目并找到 **Other > Pipeline Configurations**。

   ![undefined](../../../../assets/images/7a/7a701b93061419d4225b6c1a0667bdb5dd5200b92579659314d6c6d12da8dcee.jpg)
3. 在 **Pipeline Configurations** 页面上，点击 **Add Pipeline Configuration**。

   ![undefined](../../../../assets/images/e9/e9d3124f69c235fc8f0c4a478f798c87a24f88fd0b280fbd9d36fec3d01ead50.png)
4. 将 **Config Name** 设置为Primary，并将 ***Plugin Ids** 设置为 **basic.***。

   > 图片已省略：undefined
5. 点击 **Create Pipeline Configuration**。在返回 **Pipeline Configurations** 页面后，你就能看到 **Primary** 列表中新增了一个条目。

   > 图片已省略：undefined
6. 点击 **Uploaded Config** 字段，选择 **Upload File**。将你从GitHub上下载的.zip文件添加到这里。

   > 图片已省略：undefined

### 最终结果

现在，你的ShotGrid项目已经可以使用虚幻引擎集成了。ShotGrid Desktop会为每个项目用户自动下载并安装你上传的管线配置。如果有管理员修改了上传的配置，.zip文件中配置文件的后续更新都会被检测到并为每个用户更新。

## 3 - 设置ShotGrid项目配置

在此步骤中，你将安装ShotGrid Desktop中的管线配置并启动一个能被ShotGri感知到的虚幻引擎实例。

要安装管线配置，请执行以下操作：

1. 打开ShotGrid Desktop并点击你刚刚在ShotGrid网站上为其上传了管线配置的项目。

   > 图片已省略：undefined
2. 点击项目时，它会检测到上传的管线配置并从GitHub上下载它及所有必要的ShotGrid组件（引擎、应用程序和框架）。

   > 图片已省略：undefined

### 最终结果

项目设置完成后，ShotGrid Desktop将扫描你的计算机以查找虚幻引擎安装程序并在项目的"应用程序（Apps）"页面上将它们列出。点击图标即可启动最新可用的引擎版本，或在下拉菜单中选择特定的引擎版本。

> 图片已省略：Launch the latest version of Unreal Engine

如果你从ShotGrid Desktop启用虚幻引擎，并打开了一个启用过ShotGrid插件的虚幻引擎项目，你就可以入[将虚幻引擎与Autodesk ShotGrid配合使用](#using-unreal-engine-with-autodesk-shortgrid)页面中所述的那样使用ShotGrid集成了。

## 后续步骤

- 有关如何为项目扩展工具包配置的更多信息，请参阅Autodesk的

  Beyond Your First Project

  文档。
- 有关如何在ShotGrid中管理项目配置的更多信息，请参阅Autodesk的

  Configuration staging and rollout

  文档。
- 要了解如何设置虚幻项目配置，请参阅

  tk-config-unreal-basic

  库。
- 要探索虚幻工具包引擎的实现，包括它使用及公开的Python连接，请参阅

  tk-unreal

  库。

