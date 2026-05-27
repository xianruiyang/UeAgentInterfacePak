---
title: "设置适用于虚幻Turnkey的Google Drive"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/setting-up-google-drive-for-turnkey-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "虚幻Turnkey", "设置适用于虚幻Turnkey的Google Drive"]
---

# 设置适用于虚幻Turnkey的Google Drive

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 虚幻Turnkey / 设置适用于虚幻Turnkey的Google Drive

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/setting-up-google-drive-for-turnkey-for-unreal-engine

设置适用于 **虚幻Turnkey（Unreal Turnkey）** 的 **Google Drive** 的过程比使用Perforce或本地仓库更复杂，但却提供了一个公共的位置，以便在完成初始设置之后存储和维护SDK文件。要完成此设置，你需要为组织设置以下资源：

- 已经启用了Google Drive的组织Google账号。
- 已经启用了 **Google Drive API** 的 **Google Cloud Platform** 应用，并设置了 **OAuth 2.0凭证（OAuth 2.0 credentials）**。
- 指向Google Drive文件夹和所需凭证的Turnkey清单文件。

本文档将引导你完成为组织设置这些资源的流程。

## 1.必要设置

本指南假设你已经为组织设置了Google Drive账号。如需有关如何设置账号的信息，请参阅[Google的文档](https://developers.google.com/drive/api/v3/about-sdk)。

本指南还假设你已经为支持的平台生成了所需的SDK包，并且这些包在.zip或.7z文件中。每个平台都有创建完整SDK或创建Flash SDK的不同方法。一些包在接收的时候已经压缩，在这种情况下就可以将其直接上传到Google Drive，不需要进行任何更改。但是，一些控制台的SDK需要额外的步骤。

如需有关如何使用从SDK提供商处接收的文件来生成完整或Flash SDK所需的文件的信息，请参考[Turnkey命令行](../using-the-turnkey-commandline/index.md)中的 **Help** 命令。此命令将输出有关如何配置SDK的说明，并提供相应的版本编号惯例。

由于这些.zip和.7z文件没有规定命名惯例，为便于引用，我们建议选择一致的压缩格式和命名惯例。我们还强烈建议首先将SDK文件打包，然后再上传到Google Drive，因为通过Google Drive平台处理下载请求时，下载单个压缩文件比同时下载大量文件快得多。

## 2.设置Google Drive API

你需要设置启用了Google Drive API的应用，以允许用户访问你的Google Drive文件夹及其文件。此外，你还需要设置安全凭证，从而仅允许获得授权的用户访问你的Drive文件夹。

此部分将引导你完成API和OAuth 2.0凭证的启用过程：

1. 访问Google开发人员控制台：[https://console.developers.google.com/projectcreate](https://console.developers.google.com/projectcreate)，并 **同意（agree）** 服务条款。
2. 填写 **项目名称（project name）**、**组织（organization）** 和 **位置（location）** 字段，然后点击 **创建（Create）**。
3. 你将导航到 **Google Cloud控制面板（Google Cloud dashboard）**，将弹出一条 **通知（notification）** 来确认你的项目已经设置。在此通知中点击 **选择项目（Select Project）**。
4. 在 **API** 面板中，点击 **转到API概览（Go to APIs overview）**。这将打开 **API和服务（APIs & Services）** 页面。
5. 在API和服务页面的顶部，点击 **启用API和服务（Enable APIs and Services）**。这将打开 **API库（API Library）**。
6. 选择 **Google Drive API**。你可以在 **Google工作区（Google Workspace）** 部分下找到该API。
7. 点击此API的 **启用（Enable）** 按钮。
8. Google Drive API的API和服务页面将打开。点击 **创建凭证（Create Credentials）** 按钮。这将打开表单，用于为你的项目添加凭证。
9. 使用以下设置来填写表单：

   | 编号 | 设置 | 数值 |
   | --- | --- | --- |
   | 1 | 你使用哪个API？ | Google Drive API |
   | 2 | 你将在何处调用此API？ | 其他UI |
   | 3 | 你将访问哪些数据？ | 用户数据 |
10. 点击标有 **我需要什么凭证？（What credentials do I need?）** 的按钮。
11. 此时将弹出对话框，提示你设置OAuth同意界面（OAuth Consent Screen）。点击此选项 **设置同意界面（Set Up Consent Screen）**。
12. 这将打开一个用于配置OAuth凭证的新选项卡。在 **用户类型（User Type）** 下，选择 **内部（Internal）**，然后点击 **创建（Create）**。
13. 将打开另一个用于编辑应用注册的表单。在 **应用信息（App Information）** 下，输入你的应用的 **应用程序名称（Application Name）** 和 **用户支持电子邮箱（User support email）**。此用户支持电子邮箱将作为你的组织的联络点，可以用于解决问题。
14. 向下滚动到 **开发人员联系信息（Developer Contact Information）**，然后输入将要管理你的组织的Turnkey Drive文件夹的人员的电子邮件地址。
15. 点击 **保存并继续（Save and Continue）** 按钮。
16. 关闭当前选项卡，返回到 **凭证（Credentials）** 页面，然后点击 **刷新（Refresh）** 按钮。为你的凭证 **命名**，然后点击 **创建OAuth客户ID（Create OAuth Client ID）**。
17. 创建之后，**下载凭证（Download credentials）** 部分将变得可用。点击 **下载（Download）** 按钮，下载名为 `client_id.json` 的文件，你需要此文件才能向你的用户授予你的组织的Google Drive访问权限。

你设置的凭证将允许应用程序访问你的共享磁盘并从中下载文件。

## 3.提供Google Drive凭证

要在你的Google Drive上发现文件，需要提供安全凭证来进行访问。此信息包含在其 `<Studio_GoogleDriveCredentials>` 设置下的 `TurnkeyManifest.xml` 文件中。

1. 将你在上一节中生成的 `client_id.json` 文件移动到引擎安装目录的 `Engine/Build/Turnkey` 文件夹。确保将文件添加到你的组织的版本控制系统，使其可供用户使用。
2. 打开位于此文件夹中的 `TurnkeyManifest.xml` 文件，然后将以下行添加到文件顶部：

   ```
            <Studio_GoogleDriveCredentials>$(ThisManifestDir)/client_id.json</Studio_GoogleDriveCredentials>		
   ```
3. 保存清单，并在你组织的版本控制系统中更新它。

你的应用程序现在可以使用提供的凭证连接到Google Drive。

> [!NOTE]
> 用户首次连接到你的Google Drive时，将打开一个网页对用户进行身份验证。此时，Turnkey将触发并显示一条消息，表示正在等待进行身份验证，但你可能需要手动查看新的浏览器窗口。完成此步骤之后，Google Drive将会缓存用户的登录信息，以供将来使用。

## 4.将你的SDK上传到Google Drive

现在，你已经生成并分配了用于访问Drive的凭证，接下来将需要设置用于存储文件的Google Drive文件夹结构。

1. 为你的组织创建名为 **SdkInstallers** 的共享磁盘。
2. 在此磁盘中，为你要支持的每个平台创建文件夹。确保这些文件夹的名称与 `TurnkeyManifest.xml` 清单文件中列出的名称匹配。
3. 在每个平台的文件夹中为你要托管每个SDK版本创建一个子文件夹。
4. 对于每个SDK版本，创建名为 `Install.zip` 或 `Install.7z` 的.zip或.7z文件。将此文件放到Google Drive上与其对应的平台和版本文件夹。

完成这些步骤之后，你的SDK即可在组织中发布。

> [!NOTE]
> 如果你使用具有 `$fileexpansion:` 前缀和文件扩展变量 `$[ExpVersion]` 的自动文件发现，请确保版本文件夹名称与对应平台使用的版本编号惯例匹配。你可以在Turnkey命令行中使用Help命令来检查此信息。

## 5.创建清单文件

最后，你需要编辑Turnkey清单，使其指向Google Drive上的文件。为了便于维护，引擎目录中的主 `TurnkeyManifest.xml` 文件可以指向每个平台的唯一清单文件。

1. 打开引擎安装目录的 `Engine/Build/Turnkey` 文件夹中的 `TurnkeyManifest.xml`。
2. 为你的SDK添加相关的 `<FileSource>` 信息。例如，以下是 `TurnkeyManifest_Win64.xml` 的有效 `<FileSource>`。

   ```
            <FileSource>             <Platform>Win64</Platform>             <Type>Full</Type>             <Version>$(ExpVersion)</Version>             <Name>Win64 v.($ExpVersion)</Name>             <Source>fileexpansion:googledrive:/SdkInstallers/Win64/$[ExpVersion]/Install.zip</Source>         </FileSource>		
   ```

   由于源路径包含 `fileexpansion:` 和 `$[ExpVersion]` 捕获变量，Turnkey将在Win64文件夹中查找所有可用的版本文件夹，并为每个有效的版本号创建 `<FileSource>` 对象。每个FileSource对象都将使用找到的版本号替换 `$(ExpVersion)`。

   如需有关设置清单格式的更多信息，请参阅[编辑Turnkey清单文件](../setting-up-turnkey-for-your-organization/index.md)。
3. 将每个清单上传到其在SdkInstallers磁盘中的对应平台文件夹。
4. 确保已在组织的版本控制系统上保存和更新 `Engine/Build/Turnkey` 中的 `TurnkeyManifest.xml` 文件，以便于每个用户的引擎安装目录都可以访问它。

   创建你的清单之后，将可以在Turnkey启动时在Google Drive上发现你的SDK文件。

## 6.最终结果

按照本指南完成操作之后，你的组织已经拥有了共享的磁盘，你可以在其中上传和访问平台SDK。你的组织的管理员可以添加或删除SDK以及编辑清单，而虚幻引擎用户将能够通过向Turnkey发出请求来访问，从而安装或更新SDK。
