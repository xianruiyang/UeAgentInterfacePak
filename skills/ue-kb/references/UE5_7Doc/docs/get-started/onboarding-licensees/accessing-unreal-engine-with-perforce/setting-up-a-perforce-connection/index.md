---
title: "设置Perforce连接"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/setting-up-a-perforce-connection-with-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "许可用户入驻", "使用Perforce访问虚幻引擎", "设置Perforce连接"]
---

# 设置Perforce连接

> 路径：虚幻引擎5.7文档 / 入门指南 / 许可用户入驻 / 使用Perforce访问虚幻引擎 / 设置Perforce连接

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/setting-up-a-perforce-connection-with-unreal-engine

> [!WARNING]
> 使用本页内容要求你与Epic Games签订定制的许可支持协议，该协议需包含对虚幻引擎P4 Perforce仓库的访问权限。

Epic Games会通过一个可从外部访问的Perforce仓库，将通过测试的虚幻引擎版本以及其他特定代码提供给许可用户。 许可用户可通过此方法来初次获取引擎，并在新版本发布时获取合适的更新内容。 本文介绍了在本地设置Perforce以连接到Epic Games的虚幻引擎仓库并与引擎构建同步的步骤。

## 连接策略

请注意，仅限一名授权用户登录Perforce账号。 多名用户登录同一账号属于违反Perforce服务条款的行为。

Epic Games的建议是，由单一用户或自动化工具使用该账号将引擎构建同步到本地Perforce仓库，然以让你的员工使用公司授权的个人Perforce账号进行访问。

即使你的团队尚未获得Perforce许可证，[也有最多5名用户可免费使用](https://www.perforce.com/products/helix-core/free-version-control)，或者你也可以[探索其他许可选项](https://www.perforce.com/how-buy)。

如需了解如何从Epic Games的Perforce仓库下载虚幻引擎的构建或修订内容，请参阅[使用Perforce下载虚幻引擎](../downloading-unreal-engine-with-perforce/index.md)页面。

## 安装和配置

### 设置P4V

P4V客户端是Perforce当前提供的客户端。 它允许用户通过图形界面访问版本文件，此外，它含包含各类工具，以便合并代码并现实代码的改动历史。

你可以从[Perforce下载](https://www.perforce.com/downloads)页面下载完整的P4V安装程序。 请参阅Perforce的[P4V文档](https://help.perforce.com/helix-core/server-apps/p4v/current/Content/P4V/Home-p4v.html)，以获取关于安装和设置P4V的说明。

> [!NOTE]
> 请针对你的操作系统下载合适的版本（注意是32位还是64位版本）。
>
> 你必须运行2017.2或更高版本的Perforce客户端

### 字符编码

如果你在Perforce上将Unicode文件存储为文本，文本会添加0xd以匹配本地行尾；因此，Unicode行尾0x0a 0x00 0x0d 0x00将被转换成0x0a 0x0d 0x00 0x0d 0x00，并出现中断。 然而，当发生这种情况时，它将保持你的本地版本不变（并正常运行）。 同步到之前的版本，然后返回到开始部分查看问题。

Perforce将UTF-8定义为Unicode。 UTF-16是理想的选择，前提是没有意外转换成ASCII。 如果你没有错过合并或多重签出，也可以选择二进制格式。

虚幻引擎会加载ASCII或UTF-16（带有BOM），前提是它们是有效的文件。

### 为虚幻引擎分发设置Perforce

你的团队已获得Epic Games的Perforce P4服务器的单一账号，你可通过该账号下载虚幻引擎源代码。 请按照以下说明设置与团队共享虚幻引擎构建的流程。

#### 执行初始设置和导入

1. 创建你自己的（本地）P4服务器。
2. 在该服务器上创建一个用于导入的流仓库，例如：`//UE5`
3. 为从Epic导入的特定版本创建一个流，例如：`//UE5/Release-5.6.0`

   1. 不要为这个本地流添加任何文件 — 你需要在下面的单独步骤中完成添加。
4. 在Epic Games Perforce P4服务器上创建一个工作空间（见[使用Perforce下载虚幻引擎](../downloading-unreal-engine-with-perforce/index.md)），并同步你所需的数据。

   1. 设置工作空间的根文件夹，例如`c:\UE5\release-5.6`
   2. 请注意你在同步的最新变更列表（在P4V中选择流后，查看历史记录选项卡）。
5. 在P4V中新建一个与你的Perforce P4服务器相连的新连接。
6. 为新建的流创建工作空间（`//UE5/Release-5.6.0`）
7. 将该工作空间的根目录设置为与Epic Games Perforce P4服务器上的工作空间相同的文件夹（在本示例中为`c:\UE\release-5.6`）。
8. 右键点击根文件夹，选择**标记添加（Mark for Add）**。
9. 转到待处理的变更列表文件夹，提交变更列表。

   1. 在描述中注明你从Epic Games服务器同步的特定变更列表编号

### 从Epic Games获取并导入新快照

此流程是一个使用你之前创建的工作空间进行的常规流程。 这是上述步骤的修改版，且该工作流程假设你依然拥有之前设置的工作空间。 你需要导入最新的更改。

1. 连接到Epic Games Perforce P4服务器

   1. 选择你先前创建的工作空间。
   2. 点击**获取最新文件（Get Latest）**以更新文件。
   3. 请注意你同步的最新变更列表。
2. 连接至你本地的Perforce P4服务器。
3. 选择你先前创建的工作空间。
4. 右键点击根文件夹，选择**协调离线工作（Reconcile offline work）**。
5. 转到待处理的变更列表文件夹，提交变更列表。

   1. 在描述中注明你从Epic Games服务器同步的特定变更列表编号。

## 支持

### 连接问题

如果你因故无法连接到Perforce仓库，请联系[developer-access@unrealengine.com](mailto:developer-access@unrealengine.com)，或在[Epic专业支持](https://epicprosupport.epicgames.com/)论坛上留言。
