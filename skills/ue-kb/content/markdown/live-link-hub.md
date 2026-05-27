# Live Link Hub快速入门

---
title: "Live Link Hub快速入门"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/live-link-hub-quick-start-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "Live Link", "LiveLink Hub", "Live Link Hub快速入门"]
---

# Live Link Hub快速入门

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / Live Link / LiveLink Hub / Live Link Hub快速入门

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/live-link-hub-quick-start-in-unreal-engine

本文介绍了Live Link Hub的基本设置步骤及入门指南。

## 在虚幻编辑器中激活必要的插件

要启用Live Link Hub插件，请找到**编辑（Edit）** > **插件（Plugins）**并打开**插件浏览器（Plugin Browser）**。 搜索"Live Link"。

![Live Link插件](../../../../../../assets/images/f3/f39f1d9e8afcebc0b70947f2781e728f4694cddcfad9b29a206a530a52007053.jpg)

启用Live Link Hub插件条目。

> [!NOTE]
> Live Link - 在空白项目中，此插件是默认启用的。 你之前可能禁用了它。 如果禁用过，请将其启用。

重启编辑器。

## 启动Live Link Hub

在菜单中会出现Live Link Hub的新条目。 找到**工具（Tools） -> Live Link Hub**。

![工具菜单中的Live Link Hub](../../../../../../assets/images/2d/2dc9cc21a5e070977bb8ba057d59156c4c63f99f0cfbafe91c7c0611c1e4e539.jpg)

这会在你的计算机上启动Live Link Hub。

如果你想要在未安装虚幻引擎的计算机上运行Live Link Hub，可以从[Epic游戏商城](https://store.epicgames.com/)下载Live Link Hub。

在启动Live Link Hub时，同一个网络中的所有运行虚幻编辑器且启用了Live Link Hubris插件的PC客户端都会出现在"客户端（Clients）"面板中。

你的编辑器会话应该已经出现在了最右边的"客户端（Clients）"面板中。

![Live Link Hub中的虚幻编辑器会话](../../../../../../assets/images/1d/1de57f570506357d9daeb701eacad32a0de1300fd656a9b55f2fa99157b94fea.jpg)

在UE中，消息条会显示绿色的"Live Link已连接（Live Link Connected）"横幅：

![Live Link已连接横幅](../../../../../../assets/images/48/4827808ce6a4174bcadb7c3156d0fe65eb0b9d5e611d999e72cbb3c21879e2be.png)

如果发生错误，消息条会显示警告信息：

![Live Link Hub错误警告信息](../../../../../../assets/images/89/898887f73c05126350db8bf584fe0d45a7b96e38a173465b2b6ec90c6f4865f1.jpg)

在虚幻引擎中打开Live Link面板，查看其中是否列出了一个名为"Live Link Hub"的源。 它应该如下所示：

![Live Link面板中的Live Link Hub源](../../../../../../assets/images/dc/dcfe3d3ddde4f729db448aefb8c5ecb3df2c29a68aaa051789c9b3895fc831d4.png)

如果列表中没有名为"Live Link Hub"的源，你可以点击**+添加源（+Add Source）**手动添加。

如果有新的客户端（引擎会话）上线，它们会被自动添加到Live Link Hub。 如果它们断开连接，则会在列表中显示为未连接。

## 添加源

要添加实时的动画数据源，请在**源（Sources）**面板中点击**+添加源（+Add Source）**：

![添加源](../../../../../../assets/images/13/130a36706492c32c6ed6c9c0c5f5bdfa553ea3897531a588b57fed7f16ba6752.jpg)

数据会被发送到所有连接的客户端。 源的主体会出现在中间的**主体（Subjects）**面板中：

![源的主体](../../../../../../assets/images/16/16b999c6efca253ca429a41234a15e54a3ff5b7334ee9d20a8e44171f76c48ef.jpg)

你也可以在UE中点击消息条中的Live Link Hub分段，或打开Live Link面板，查看列出的主体：

> 图片已省略：虚幻引擎中列出的Live Link主体

此时，数据会被流送到你的虚幻编辑器。你可以按照[Live Link文档](../../using-live-link-data/index.md)所描述的那样对其进行处理。

## 高级主题

### 通过命令行启动

你可以通过命令行启动Live Link Hub，这可以让你访问额外的启动参数。

如果你时通过虚幻引擎安装运行Live Link Hub，可以选择在Hubris中启用以下Live Link插件：

- LiveLinkFreeD
- LiveLinkPrestonMDR
- LiveLinkMasterLockit
- LiveLinkVRPN

按Windows+R并输入CMD。 按回车键打开命令行窗口。

输入并执行以下命令：

C++

```
[your install directory]\Engine\Binaries\LiveLinkHub.exe -EnablePlugins="LiveLinkFreeD,LiveLinkPrestonMDR,LiveLinkMasterLockit,LiveLinkVRPN"
```

