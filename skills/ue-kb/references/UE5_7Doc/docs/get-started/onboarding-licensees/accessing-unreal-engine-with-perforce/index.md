---
title: "使用Perforce访问虚幻引擎"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/accessing-unreal-engine-with-perforce"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "许可用户入驻", "使用Perforce访问虚幻引擎"]
---

# 使用Perforce访问虚幻引擎

> 路径：虚幻引擎5.7文档 / 入门指南 / 许可用户入驻 / 使用Perforce访问虚幻引擎

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/accessing-unreal-engine-with-perforce

> [!WARNING]
> 使用本页内容要求你与Epic Games签订定制的许可支持协议，该协议需包含对虚幻引擎P4 Perforce仓库的访问权限。

Epic Games提供虚幻引擎访问权限的一种方式是通过Perforce仓库提供源代码，被许可方可以连接至该仓库以下载虚幻引擎。 考虑到虚幻引擎会定期更新，被许可方在开发周期中会多次更新引擎版本。 因此，从一开始就正确设置Perforce就显得非常重要，因为这样能让引擎版本的同步和集成更方便。

## 必要步骤

继续阅读本文前，请确保你所在的公司已与Epic Games签订了[定制许可协议](https://www.unrealengine.com/en-US/custom-licensing)。 签订 定制许可支持协议 后，我们的支持人员将为你创建账号，并联系贵公司的 技术许可管理员，以便提供信息让你开始使用服务。

如果你已经签订了定制许可支持协议，但尚未获得Perforce访问权限，请联系你的Epic Games业务开发代表，申请访问Epic Perforce代理服务器的访问权限。 在你获得访问权限后，我们将为你设置Perforce账号，并向你的技术许可管理员提供登录凭据和入驻文档。

要连接Epic Games的Perforce仓库，你的账号需要通过**Okta**进行验证。 访问Perforce仓库需要有效的密码，而Epic Games的Okta访问还要求多因素验证（MFA）。 [Epic Games开发者访问权限团队](mailto:developer-access@unrealengine.com)将协助贵公司的技术许可管理员完成Okta账号的设置，包括提供临时的密码。 你需要每年至少更新一次密码。

## 连接Epic Games的仓库

建立Okta账号后，你就可以使用Perforce客户端在本地安全访问仓库。 正确安装和配置客户端后才能连接。 安装和连接**P4V Perforce客户端**的步骤大致如下：

1. 从[Perforce软件下载页](http://www.perforce.com/downloads/complete_list)下载客户端。
2. 安装并运行客户端。
3. 在**连接对话框**中填写相应的**服务器（Server）**和**用户（User）****信息**，然后点击**确定（OK）**。
4. 提供你在Epic Games的Okta中设置的密码。
5. 客户端将打开并连接至Epic Games的Perforce仓库。

详情请参阅Perforce的[P4V文档](https://help.perforce.com/helix-core/server-apps/p4v/current/Content/P4V/Home-p4v.html)。

> [!WARNING]
> 请注意，仅限一名授权用户登录Perforce账号。 **多名用户登录同一账号属于违反Perforce服务条款的行为。**
>
> Epic Games的建议是，由单一用户或自动化工具使用该账号将引擎构建同步到本地Perforce仓库，然后让你的员工使用公司授权的个人Perforce账号进行访问。
>
> 即使你的团队尚未获得Perforce许可证，[也有最多5名用户可免费使用](https://www.perforce.com/products/helix-core/free-version-control)，或者你也可以[探索其他许可选项](https://www.perforce.com/how-buy)。

## 同步流（Stream）

Epic Games托管了许多Perforce流，可用于同步代码。 所有开发团队都有一个"开发"（dev）流，其可提供团队的最新代码，而测试（QA）部门会在将"开发"流复制到"主"（main）引擎流前定期对其进行测试。

在正式发布前，"主"流快照将被复制到"发布"（release）流中，进行严格的测试和漏洞修补，直至正式发布。 在完整发布、预览发布或热修复补丁之后"发布"流的快照会被用于将修复补丁移回"主"流。

请考虑同步时所需代码（例如，所需的是整个引擎、仅针对特定流，还是精选功能或修复补丁）、代码更新程度，以及稳定程度等。

下列表格描述了流的四种类型，并提供了示例流名称，同时还描述了每种流的内容、相对时长和稳定性：

| 流类型 | 示例流名称 | 说明 |
| --- | --- | --- |
| **主要（Main）** | //UE5/Main//UE5/Dev-Main | 此流中的代码相对较新，而且已经通过了一些测试。 "Dev-Main"变体是一个不包含部分样本的虚拟流。 开发流复制到该流，并向下进行合并。 |
| **开发（Development）** | //UE5/Dev-Core//UE5/Dev-Rendering//UE5/Dev-Framework | 引擎特定区域相关功能的最新工作源，便是开发该功能团队的开发流。 该代码目前正处于开发阶段，因此该流类型最不稳定。 |
| **发布版（Release）** | //UE5/Release-5.6.0//UE5/Release-5.5.4//UE5/Release-Latest | 此类流符合Epic正式公开发布的相关要求且经过严格测试，非常稳定。 它们包含指定引擎的最新版本。"Release-Latest"流是虚拟的，而且始终指向Epic最新的正式发布版本。 除"Release-Latest"外，可同过将名称划分为三段式编号（例如，"Release-5.6.0"）识别此类流。 |
| **稳定发布版（Release Stabilization）** | //UE5/Release-5.6//UE5/Release-5.5 | 当Epic准备发布新版本虚幻引擎4时，会在主流的当前快照中创建一个流。 在公开发布前，此流将进行日常测试和漏洞修补，因此其可能不太稳定。通过在名称中添加两段式编号（例如，"Release-5.6"），可以将其与"Release"流进行区分。不建议同步到此类型的流。 |

### 其他信息

- [使用Perforce下载虚幻引擎](downloading-unreal-engine-with-perforce/index.md) - 介绍如何使用Perforce下载虚幻引擎源代码。
- [设置Perforce连接](setting-up-a-perforce-connection/index.md) - 关于连接Epic Games的Perforce服务器并获取虚幻引擎构建的指南。
