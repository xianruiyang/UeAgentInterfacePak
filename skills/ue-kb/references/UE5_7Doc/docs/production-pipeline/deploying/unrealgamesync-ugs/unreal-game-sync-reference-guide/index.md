---
title: "UGS参考页面"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-game-sync-reference-guide-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "部署虚幻引擎", "UnrealGameSync (UGS)", "UGS参考页面"]
---

# UGS参考页面

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 部署虚幻引擎 / UnrealGameSync (UGS) / UGS参考页面

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-game-sync-reference-guide-for-unreal-engine

本页面将讲解配置 **UnrealGameSync (UGS)** 并部署为工作室的方法。

## 朝向

UnrealGameSync的源代码位于 `Engine/Source/Programs/UnrealGameSync` 下面。

UnrealGameSync解决方案包含以下项目：

| 项目 | 描述 |
| --- | --- |
| **UnrealGameSync** | 主程序。 |
| **UnrealGameSyncLauncher** | UGS的启动程序，会在有新版本时自动更新主程序的可执行文件。 |
| **MetadataServer** | REST API，随UGS一起部署以启用其完整功能集，包括评论编译，对编译健康投票和标记较差编译，以及显示PostBadgeStatus提交的CIS结果。 元数据服务器必须部署到装有IIS 7.0或更高版本和.NET 4.6.2的Windows服务器上。 |
| **Installer** | UnrealGameSyncLauncher的MSI安装程序。此通常用于在开发机器上安装启动程序，可根据Perforce自动更新和运行程序。 需要Wix 3.8进行编译。 |
| **PostBadgeStatus** | 将编译结果推到MetadataServer实例的实用程序。 |

## 配置

在 `Engine/Source/Programs/UnrealGameSync/UnrealGameSync/DeploymentSettings.cs` 中指定UGS的部署设置。可使用自己团队的设置修此文件，然后将其编译为分发的可执行文件中。

此类设置包括：

| 设置 | 描述 |
| --- | --- |
| `ApiUrl` | 元数据服务的运行中实例的URL（见下文），此元数据服务用于向开发者显示信息。 |
| `DefaultDepotPath` | 默认Perforce仓库路径，UnrealGameSyncLauncher应从此路径同步UnrealGameSync可执行文件。 参阅下文了解该文件夹布局方式。 |
| `bSendTelemetry` | 是否将编译时的遥测发布到元数据服务。 |

## 自动更新

要在不同分支和项目的带外UGS上启用部署，通过自补丁机制来分发UGS，这种机制利用Perforce进行版本控制。

极少更新的启动程序应用使用Microsoft安装程序（MSI）软件包（"Installer"项目），手动安装在各开发者机器上。安装此程序会创建开始菜单图标，运行后会根据Perforce同步最新的UGS可执行文件并运行此类文件。该路径受监控，如提交了新可执行文件，程序将重新启动并重新同步。

同步此类文件无需工作空间；以无状态方式从Perforce服务器获取。

> [!NOTE]
> 编译安装程序需要Wix 3.8。

UnrealGameSyncLauncher用于更新应用程序的路径由 `DefaultDepotPath` 变量指定，通过 `DeploymentSettings.cs` 将此变量编译到应用程序中（上述链接）。该文件夹应如下布局（例如，DefaultDepotPath = "//depot/UnrealGameSync"）：

`//depot/UnrealGameSync/`**Release/UnrealGameSync.exe** `//depot/UnrealGameSync/`**Release/UnrealGameSync.exe.config** `//depot/UnrealGameSync/`**Release/UnrealGameSync.pdb** `//depot/UnrealGameSync/`**Release/Ionic.Zip.Reduced.dll**

`//depot/UnrealGameSync/`**UnstableRelease/UnrealGameSync.exe** `//depot/UnrealGameSync/`**UnstableRelease/UnrealGameSync.exe.config** `//depot/UnrealGameSync/`**UnstableRelease/UnrealGameSync.pdb** `//depot/UnrealGameSync/`**UnstableRelease/Ionic.Zip.Reduced.dll**

> [!NOTE]
> 迁入两个UnrealGameSync的副本——一个位于"Release"文件夹下，另一个位于"UnstableRelease"文件夹下。

默认使用 `Release` 文件夹下的可执行文件，但通过UGS中的 `**应用程序设置** 对话框，或开始启动程序时长按shift键，使用`UnstableRelease` 文件夹将测试版本分布到选择其的用户。

提交新可执行文件，即可推出UnrealGameSync的新版本。应用程序将轮询已提交变更的文件夹，找到变更时重新启动并重新同步二进制文件。

## 设置元数据服务

UGS可与网络服务通信，以在团队成员间共享信息。无需设置此项，其也可以运行，但将无法使用部分更强大的协作功能。

- 显示编译结果并提供关于编译损坏的桌面通知。
- 用户可标记变更为好和差，并向其他团队成员表明其正在调查版本问题。
- 显示哪些用户同步到哪些更改

元数据服务使用ASP.NET进行实现，需设置数据库后端的MySql实例。

> [!TIP]
> 数据库进程（理想下）可使用所有机器资源，因此建议在不同机器上使用MetadataServer和数据库后端主持IIS实例——但此并非必需操作。

### 设置MySql后端

> [!NOTE]
> 在继续下一步前，请注意最低版本要求为[MySQL 8.0](https://dev.mysql.com/doc/relnotes/mysql/8.0/en/)。

要设置MySql后端，执行以下步骤：

1. 下载最新版本的MySql安装程序：[https://dev.mysql.com/downloads/installer/](https://dev.mysql.com/downloads/installer/)
2. 在 **选择设置类型** 上，选择 **仅限服务器（Server Only）**。
3. 在 **配置步骤（Configuration Steps）** 中设置：

   1.**高可用性（High Availability）**：独立MySql服务器 1.**类型和网络**：如与上文中的IIS实例进行共享，则为 **服务器计算机**；如位于单独实例上，则为 **专属服务器**。所有TCP/IP配置和端口保留默认值。 1.**验证方法（Authentication Method）**：使用强密码加密 1.对于 **帐户** 和 **角色**： 1.选择根用户名和密码。

   > [!NOTE]
   > 此为数据库的主账户，因此不要丢密码。

   1.添加另一用户作为服务帐户，IIS实例将使用此帐户进行连接。

   > [!NOTE]
   > 不要使用根帐户。

   1.**Windows服务**（假设在Windows机器上安装）：可忽略此类选项。

   > [!TIP]
   > 在本地工作站上安装MySql Workbench：[https://dev.mysql.com/downloads/workbench/](https://dev.mysql.com/downloads/workbench/).有了MySQL Workbench，不仅可查看和操纵数据库，还可执行备份和还原等管理任务。

#### 故障诊断

##### 禁用ONLY_FULL_GROUP_BY

如启用 `ONLY_FULL_GROUP_BY` 函数，运行MySQL脚本时可能会遇到错误。此函数可通过运行命令（方法1）或修改MySQL选项文件（方法2）来禁用：

###### 方法1：运行命令

从命令行启动MySQL服务器并运行：

```
	mysql > SET GLOBAL sql_mode=(SELECT_REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', '')); 
```

> [!NOTE]
> 如Windows用户在从命令行运行MySQL服务器时遇到困难，请阅读MySQL 8.0 参考手册中的[从Windows命令行开始MySQL（Starting MySQL from the Windows Command Line）](https://dev.mysql.com/doc/refman/8.0/en/windows-start-command-line.html)。

###### 方法2：修改选项文件

> [!NOTE]
> **必需：**如不知如何使用MySQL选项文件，请阅读MySQL 8.0参考手册中的[使用选项文件（Using Option Files）](https://dev.mysql.com/doc/refman/8.0/en/option-files.html)。

1. 找到并打开

   my.cnf

   选项文件。
2. 运行此查询来检查 `sql_mode`：

   ```
           SELECT @@sql_mode;		
   ```
3. 查看查询结果，应类似于这些值：

   ```
           ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE, ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION		
   ```
4. 编辑 `my.cnf`，输入下列 `sql_mode` 语句（在[mysqld]下）以及上一步中的值：

   ```
           sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE, ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION		
   ```

   > [!NOTE]
   > 请注意，该语句不包含 `ONLY_FULL_GROUP_BY` 值。
5. 重新启动MySQL服务器。

> [!NOTE]
> 欲了解更多信息，请查看MySQL 8.0参考手册中的这些章节：
>
> - Server
>
>   SQL Modes
> - MySQL
>
>   Handling of GROUP BY

### 设置元数据服务

要设置元数据服务，执行以下步骤：

- 修改UGS可执行文件以设置ApiUrl

1. 确保已安装ASP.NET Web Publishing工具。可在Visual Studio安装目录中找到这个软件包。如不安装此软件包，编译项目将失败并提示"TransformXml task not found"错误。
2. 项目不与

   web.config

   文件共同发布，而是与

   web.template.config.xml

   。此文件根据

   .debug

   和

   .release

   XML文件转变得来，可动态生成

   web.config

   。建议将

   web.template.config

   迁入源控制，而非

   web.config

   。
3. 在 .`debug` 和 `.release` XML文件中，可通过"Connection String"属性指定保存MySql数据库的路径。此与标准MySql连接字符串类似：

   ```
            <add name="ConnectionString" connectionString="server=localhost;UserId=service_account_username;password=service_account_password;" providerName="MySql.Data.Client"/>		
   ```

   > [!NOTE]
   > `serviceaccountusername` 和 `serviceaccountpassword` 是MySql设置进程中输入的帐户凭证。
4. 首次启动站点时会自动种入数据库。

要验证服务器是否已正确配置，在Web浏览器中打开 `servername.com/api/latest`。应可看到以下类似内容：

```
	<LatestData xmlns:i="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://schemas.datacontract.org/2004/07/MetadataServer.Models">	  <LastBuildId>0</LastBuildId>	  <LastCommentId>0</LastCommentId>	  <LastEventId>0</LastEventId>	</LatestData> 
```

> [!NOTE]
> 要确保正确初始化数据库，无法创建或找到数据库时站点将终止。如部署站点并出现404错误，很可能是由该原因造成。检查连接字符串，如位于不同实例上，IIS实例能够与数据库通信。

## 与编译进程集成

### 徽章

通过提交的变更列表中显示的 **徽章**，UGS显示编译系统结果（以"正在"编译的通知）。如编译中断，则会上次成功后所有已提交的开发者显示通知。点击徽章可在Web浏览器中打开URL，其中包含编译日志。

该信息由元数据服务存储，使用PostBadgeStatus实用程序可向其添加条目。

### PostBadgeStatus

`PostBadgeStatus` 命令行语法如下：

```
	PostBadgeStatus.exe	    //（将出现在UGS中的徽章名称。）	  -Name=Editor	    //（正在编译的变更列表。）	  -Change=123456	    //（要显示徽章的项目。注意：此为文件夹路径，而非实际.uproject文件。）	  -Project=//UE4/Main/Samples/StarterContent	    //（部署UGSAPI的基本URI）	  -RestUrl="http://ugsapi-server.net"	    //（编译状态。有效值为"Starting"、"Failure"、"Warning"和"Success"。）	  -Status=Success	    //（如用户点击徽章，此为将用户导航到编译日志的链接。）	  -Url=http://link-to-build-log 
```

## 项目的自定义化

### 品牌

将 `Build\UnrealGameSync.png` 文件放置在包含项目的目录中，可添加要在UGS中显示的项目徽章。该图像将缩放到126像素高度。

> [!TIP]
> 建议使用200x126像素尺寸。 BrandPxDim.png
>
> *请随意下载该参考图片。*

### 项目配置文件

可使用项目特定配置文件自定义向用户显示项目的方法。项目配置文件应以 /Build/UnrealGameSync.ini 形式提交到Perforce。

可用以下设置：

*UGS仅默认显示因项目源代码变更而编译失败的通知。如有应向提交内容的开发者显示的徽章，按照以下步骤将其加入白名单：

```
		[Notifications]		+ContentBadges=Content 
```

- 如果向CL的描述列添加可点击按钮，点击相应按钮后，对CL描述运行正则表达式以将用户导航到URL。例如，以下用例将徽章添加到所有带有 `#jira` 标记的CL旁，并带有指向Jira中的对应问题的链接：

  ```
            [Badges]          +DescriptionBadges=(Pattern="(?i)#\\s*jira\\s*:?\\s+([A-Za-z]+-[0-9]+)", Name="$1", Group="Jira", Color="#c0c0c0", HoverColor="#e0e0e0", Url="https://jira.it.yourcompany.net/browse/$1")		
  ```

  本例中使用以下属性：

  | 属性 | 描述 |
  | --- | --- |
  | **Pattern** | 指定要匹配的正则表达式，其会采集部分匹配文本，可之后进行提交。 |
  | **Label** | 指定徽章上将显示标签。 |
  | **Group** | 指定任意辨识符，将相关徽章分组，而非使用空格进行分隔。 |
  | **Color** | 指定徽章的十六进制RGB值。 |
  | **HoverColor** | 指定悬停徽章时的十六进制RGB值。 |
  | **Url** | 指定点击徽章时使用C# Process.Open调用打开的路径。 |
- 添加"Message of the day"及相对特定分支的状态面板颜色：

  ```
            [//UE4/Main/Samples/Games/ShooterGame/ShooterGame.uproject]          Message=:alert:Lock-down for fixes is **5 pm on Friday**.仅将1.2.3发布的修复提交到该分支。自1/23后还剩余123问题.          StatusPanelColor=#e20000		          使用StatusPanelColor选项，可轻松辨识流送。此外，使用消息选项时，支持Markdown的有限子集：		          [网络链接](http://www.google.com)          *斜体*          _italic_          **粗体**          __bold__		
  ```

  > [!NOTE]
  > 支持使用 `:icon:` 语法的图标；但 `:alert:` 为当前唯一可用的图标。
- 自定义CIS列中的徽章大小和排列：

  ```
            [Default]          ColumnWidth_CIS=580          +BadgeGroups=Editor          +BadgeGroups=And, Lin, PS4, XB1, Win, IOS, Mac, Swi          +BadgeGroups=Content		
  ```
- 使用以下设置定义特定于项目的同步过滤器：

  ```
            [Options]          +SyncCategory=(UniqueId="d9610e2f-7f6f-4898-bc98-d39dd7053d75", Name="FirstCategory", Paths="/MyGame/Content/Foo/...")		
  ```

  > [!NOTE]
  > - UniqueId
  >
  >   是随机生成的GUID。
  > - Name
  >
  >   显示在UGS UI中。
  > - Paths
  >
  >   可以用分号隔开。
  >
  > 要修改现有的目录设置，需要指定其 `GUID`，它位于 `.../UnrealGameSync/Workspace.cs` 中的 `DefaultSyncCategories` 数组。在默认情况下，UGS会将指定的路径附加到现有列表，但设置 `Clear=true` 会替换它。

### 预编译二进制

要使用户能下载预编译编辑器编译，而无需在本地编译，可向Perforce提交包含所需二进制文件的zip文件，并让UnrealGameSync同步和抽取此类文件。为此，使用与本地编译相同的用户界面，但无相匹配二进制文件的修改将变灰。配置后，用户可选择 **选项** 菜单下的 **同步预编译二进制（Sync Precompiled Binaries）** 项目使用预编译二进制文件。

要配置预编译二进制文件的路径，将 `Build\UnrealGameSync.ini` 文件添加到项目下，并在提交此类文件的Perforce服务器上引用位置，如下所示：

```
	[//UE4/Main/Samples/Games/ShooterGame/ShooterGame.uproject]	ZippedBinariesPath=//UE4/Dev-Binaries/++UE4+Main-Editor.zip 
```

建议使用常规开发流外的位置保存预编译二进制文件，以避免干扰未使用预编译二进制文件的用户。无需维护其的单独工作空间；UnrealGameSync会以无状态方式，使用同步文件所用的相同登录凭证获取此类文件。

无需设置元数据服务器以使用预编译二进制文件；各zip文件修订版的对应更改列表将在更改列表描述（以标记 `[CL 12345678]` 开头）中进行解析。

在此提供一个范例脚本，以展示以正确格式创建和提交编辑器二进制文件的方法，具体位置如下：`Engine/Build/Graph/Examples/BuildEditorAndTools.xml`

运行该脚本的典型命令行如下：

```
	Engine\Build\BatchFiles\RunUAT.bat	  BuildGraph	  -Script=Engine/Build/Graph/Examples/BuildEditorAndTools.xml	  -Target="Submit To Perforce for UGS"	  -set:EditorTarget=ShooterGameEditor	  -set:ArchiveStream=//UE4/Dev-Binaries	  -p4	  -submit 
```

此操作会向 `//UE4/Dev-Binaries/++UE4+Main-Editor.zip` 提交zip文件，其中 `++UE4+Main` 为当前分支的名称，斜杠被换码为"+"字符。相同路径应设为 `UnrealGameSync.ini` 中的 `ZippedBinariesPath` 的值。

文件开头的注释中包含使用 `BuildEditorAndTools.xml` 的更多相关信息。

### 同步过滤器

> [!NOTE]
> 有关该功能的更多详情，请参阅[同步过滤器](unreal-game-sync-filters/index.md)。
