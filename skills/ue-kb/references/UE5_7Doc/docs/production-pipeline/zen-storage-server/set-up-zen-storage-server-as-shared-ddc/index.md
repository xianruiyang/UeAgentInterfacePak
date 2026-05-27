---
title: "将Zenserver作为共享DDC"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/set-up-zen-storage-server-as-shared-ddc-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Zen存储服务器", "将Zenserver作为共享DDC"]
---

# 将Zenserver作为共享DDC

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Zen存储服务器 / 将Zenserver作为共享DDC

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/set-up-zen-storage-server-as-shared-ddc-for-unreal-engine

在将Zenserver用作共享DDC之前，务必要对其适用的环境有明确认知。Zenserver是一款 **不使用身份验证** 的存储服务器。

虽然未来可能会增加身份验证功能，但Zenserver目前的用途是在办公室局域网或VPN等可信环境中使用，在这种环境中，所有能访问Zenserver的用户都享有对内容进行读/写/删除的所有权限。

不建议在公共场合（如互联网）或不受信任的网络环境中使用Zenserver，否则可能导致数据泄漏、数据损坏或中毒，或造成存储在Zenserver中的DDC或其他数据丢失。

如果你需要在公共互联网或不受信任的网络环境中使用存储服务器，请参阅[虚幻云DDC](../../using-derived-data-cache/how-to-set-up-a-cloud-type-derived-data-cache/index.md)技术，该技术适合此种使用情况，并且可以与Zenserver共享的DDC实例一起组合到DDC图表中。

一直以来，共享DDC都是使用局域网内托管的网络文件共享，或通过附近仅可从局域网访问的云主机，在办公室、工作室或VPN中实施。通常这将是CIFS/SMB文件共享，要么托管在原生的Windows服务器上，或通过Samba或Linux服务器上的同等技术进行托管。这种DDC存储很适合取代Zenserver作为共享DDC。

## Zenserver共享DDC如何适应DDC图表和网络

[派生数据缓存（DDC）](../../using-derived-data-cache/index.md)文档概述了DDC技术，并介绍了必要的预备知识。在考虑Zenserver共享DDC如何适应你的组织或项目的DDC图表时，请考虑DDC图表中的三大主要层：

1. 云
2. 共享
3. 本地

你有充分的理由在图表中添加其他层（如Pak层），也存在其他隐藏层（如内存层），但仅就规划Zen共享DDC的使用而言，只需单独考虑以上三层即可。

并非所有用例都需要用到这三个层级，但假设三个层级都出现，则其结构为：

1. 云 - 虚幻引擎云DDC，延迟时间为20毫秒至100毫秒，使用身份验证，任何位置的公共互联网均可用，可在区域实例之间进行数据复制。
2. 共享 - 文件共享DDC或Zenserver共享DDC，延迟时间为1毫秒至60毫秒，不使用身份验证，仅在局域网或VPN上可用，在用户/员工群集的每个办公室或区域中仅存在一个实例。
3. 本地 - Zenserver本地DDC（在虚幻引擎5.4及更高版本中为默认项），延迟时间为0.1毫秒至10毫秒，不使用身份验证且仅限回送/本地主机服务，仅在各工作站上可用。

如果你是单一用户，则可能只有本地层。

如果你是某个地区的中型团队，则可能在办公室内或经由VPN对地区可用的云主机中拥有本地层和共享层。

如果你是一个大型组织，在多个地区都有团队，那么你应该拥有本地层、共享层和云DDC层，且每个地区办公室都存在一个Zenserver共享DDC实例，同时云层可全局共享缓存数据，并提供跨地区复制功能。

**示例** ：贵组织的员工分布在三个办公地点：蒙特利尔、西雅图和丹佛，同时在美国东部拥有云托管构建场，负责生产烘焙的数据构建。每个地点的员工都超过50名。那么最佳设置是：

1. **云** - 设置于云托管服务提供商上的虚幻引擎云DDC，在公共互联网上可用，在美国东部和美国西部都有实例，且两者之间可以双向复制。
2. **共享** - 三个地区办公室（蒙特利尔、西雅图和丹佛）各有一台供Zenserver共享DDC使用的主机（物理机或虚拟机），主机之间不进行复制，另外还对一个Zenserver共享DDC实例进行私人托管，托管的云主机和区域与你的云托管构建场相同
3. **本地** - Zen本地DDC，默认用于各个用户的工作站。

![undefined](../../../../assets/images/25/251b5434253fffd2283051e021e3db74081b07abe4127091cf89ae46e6d1c408.jpg)

云DDC服务器示例（使用双向复制）：

- 美国东部云DDC实例
- 美国西部云DDC实例

Zenserver共享DDC服务器实例：

- 蒙特利尔现场机器
- 西雅图现场机器
- 丹佛现场机器
- 美国东部云托管构建场机器

这种布置为组织提供了一个全局复制缓存层、一个局域网速度共享层（可避免在单个办公室内共享时产生大量的网络进入流量）以及一个高效的本地缓存层。构建场进行烘焙时会将所有新DDC数据写入共享层和云层，然后经此复制到其他区域，供这些区域的用户使用。

## 使用Zenserver设置共享DDC服务器

### 硬件

共享DDC服务器的具体规格将根据你的组织和数据集的情况进行定制和调整。在Epic内部，我们发现更合理的做法是偏重内存和IO功能，而不是偏重CPU核心数或单核速度。

为方便对比，下方列出了我们的硬件配置：

大型办公室（数百名开发者）：

- 拥有超线程技术的8核CPU（16个逻辑处理器），主频为2.40 GHz
- 64 GB内存
- 4 TB固态硬盘（独立于系统盘），如果是虚拟硬盘，则偏重高IOPS和吞吐量
- 首选10 Gbps局域网链接

Zenserver进程本身不会占用大部分内存，但它的存在将使操作系统级的文件缓存（备用内存）更为高效。

在构建场环境中，我们会完全禁用本地DDC，更多地依赖每台进行烘焙的构建场机器对共享DDC的重度使用。在这种重度使用的场景中，我们会依赖云托管Zenserver共享DDC服务器的高规格配置：

- 拥有超线程技术的24核CPU（48个逻辑处理器），主频为3.80 GHz
- 192 GB内存
- 12 TB固态硬盘（独立于系统盘），如果是虚拟硬盘，则偏重高IOPS和吞吐量
- 云区域内提供100 Gbps的局域网连接

> [!NOTE]
> 上述配置并非最低要求，而是基于Epic Games内部需求的推荐配置。Zenserver可以在更低配的硬件上运行，以适配规模较小的团队。

建议将Zenserver数据保存在独立于操作系统的硬盘上，从而达到以下效果：

- 便于将来扩展/更换Zenserver数据硬盘。
- 避免因磁盘空间不足而导致系统无法使用。

如果要将现有的文件共享DDC替换为Zenserver共享DDC，最佳做法是：

1. **匹配磁盘大小** - 不论文件共享中DDC的磁盘容量/配额是多少，Zenserver共享DDC的磁盘容量/配额都应相同，因为其磁盘空间需求也应相同。
2. **匹配或优化距离/网络延迟** - DDC对服务器和连接客户端之间的通信延迟很敏感。从文件共享DDC转变为Zenserver共享DDC时，主机硬件与用户的距离或延迟应保持一致，以避免用户体验下降。如果你在多个地区拥有文件共享DDC，则应计划针对每个存在文件共享DDC主机的地区，为Zenserver共享DDC主机进行1比1的复制。Zenserver共享DDC上线且被所有项目使用后，就可以考虑缩减或移除文件共享DDC。

### 软件

推荐使用Windows服务器数据中心作为操作系统（在撰写本文时，2019版为扩展支持版本，2022版为主流支持版本，更新的版本将在发布时考虑），但只要是虚幻引擎支持的Windows版本（桌面版和服务器版），Zenserver就可以运行。

Zenserver支持Windows、Linux和Mac。但对于虚幻引擎5.5共享DDC而言，处于生产就绪状态的只有Windows版本，同时已在Epic内部的生产中广泛使用也只有该版本。

Linux版Zenserver可用于本地DDC。预计在未来，通过进一步调整、优化和测试，后续版本的虚幻引擎将为Linux版Zenserver的共享DDC应用提供生产就绪状态的支持。

## 版本兼容性和多项目注意事项

Zenserver被设计为向后兼容。这意味着你可以获取使用中引擎版本的Engine\Binaries\目录下的Zenserver可执行文件，并将该版本的Zenserver用于你的共享DDC。如果你所处的环境中存在多个使用不同版本虚幻引擎的项目，那么只要你运行的是当前所用最新版本虚幻引擎的Zenserver版本，你就仍然可以在项目之间共享Zenserver。最新版Zenserver兼容旧版虚幻引擎。

Zenserver的开发和发布环境与虚幻引擎相隔离，并在虚幻引擎组织下的GitHub库中有镜像，见[https://github.com/EpicGames/zen/](https://github.com/EpicGames/zen/)。

访问Zenserver库需要Epic库的访问权限，获取途径见[此处](https://www.unrealengine.com/zh-CN/ue-on-github)。版本发布见Zen库。如果用户希望在其共享DDC上评估Zenserver的新版本，请从GitHub库获取新版本，因为这些版本将向后兼容用户当前使用的虚幻引擎版本。

> [!NOTE]
> 请勿在生产环境中运行GitHub库中的新版本Zenserver。请始终仅用非生产环境的共享DDC实例来评估新版本。

Zenserver使用自身的版本编号模式，可能与引擎版本的编号有所不同。在获取Zenserver的版本时，请务必检查你所拥有的可执行文件的版本号，并将其与你要获取的版本进行比较。版本号应始终向前更新，而不是向后更新。

## 网络基础设施

目前，将Zen作为共享DDC的指导原则是不要将其置于负载平衡器之后。当前的服务器设计允许由单个实例处理繁重的工作负载，并且应该足以为单个工作室或构建场位置内的项目处理大型团队的工作负载。

如前所述，按照预期，Zenserver共享DDC应该存在于分层级的缓存中，该缓存也可以包含云层和本地层。如果你的缓存中存在云层或本地层，那么共享层停机应该不会影响虚幻引擎对缓存的访问，只不过会在停机期间降低缓存延迟/性能。

目前，与Zenserver的通信默认会通过端口8558的未加密HTTP1.1进行。Zenserver的虚幻引擎DDC客户端将绕过所有客户端代理配置，并尝试直接连接到已配置的Zenserver主机。建议允许Zenserver和虚幻引擎客户端之间的直接无代理访问，但如果你想使用HTTP代理，可以用虚幻引擎的INI文件配置Zenserver共享DDC的图表节点，从而添加 **BypassProxy=false** 参数。

未来版本的虚幻引擎和Zenserver可能会在其他端口上更改或添加额外的通信协议。请务必让你的网络防火墙或流量管理允许Zenserver和虚幻引擎客户端之间进行快速高效的通信。否则，编辑器、烘焙和Pak功能可能出现性能低下的问题。

## 服务器设置/更新（Windows）

设置/更新的过程会引用两个不同的文件夹。文件夹的位置由你自己决定，但其放置位置的指导如下。

- **{ZenInstall}** - 这是用于存放可执行文件和配置的文件夹。可以放置于系统盘或其他地方。正常情况下应该为只读，且仅在升级到新版本Zenserver时修改。
- **{ZenData}** - 这是用于存放Zenserver运行数据的文件夹。最好将其放在系统盘 **之外** 的地方。正常情况下，该文件夹可进行读写。

除文件夹外，你还必须选择运行Zenserver的用户身份（即 **{ZenUser}** ，并提供名为 **{ZenPassword}** 的密码）。

你可以以非管理员用户身份运行Zenserver，这样做在安全性上更有优势。如果以非管理员用户身份运行，则假定你已准备好供此用户使用的环境，并确保：

- {ZenUser} 拥有 **"以服务身份登录（log on as a service）"** 的权限
- {ZenUser} 拥有对 {ZenInstall} 目录进行读取的权限
- {ZenUser} 拥有对 {ZenData} 目录进行读取和写入的权限
- {ZenUser} 已被授予http.sys urlacl系统中端口8558下整个端点空间的URL保留权限。要授予此权限，只需在高级命令提示符下发出一次下列命令：

命令行

```
	netsh http add urlacl url=http://*:8558/ user={ZenUser}
```

要将某台机器设置/更新为Zenserver共享DDC，请执行下列步骤：

1. 如果Zen存储（Zenserver）服务正在运行，请执行以下命令停止该服务：

   命令行

   ```
        sc stop "Zen Store"
   ```
2. 将下列文件从仓库复制到服务器主机上选择的 {ZenInstall} 文件夹中：

   - `Engine\Binaries\Win64\zenserver.exe`
   - `Engine\Binaries\Win64\zenserver.pdb`
   - `Engine\Binaries\Win64\crashpad_handler.exe`
   - `Engine\Binaries\Win64\zen.exe`
   - `Engine\Binaries\Win64\zen.pdb`

   这些文件将被平铺到 {ZenInstall} 文件夹中，且不应位于所选 {ZenInstall} 文件夹的任何子目录中。
3. 将下列Zenserverconfig文件模板复制到{ZenInstall}\zen_config.lua中，作为起始点使用。

   zen_config.lua

   ```
        -- Zen Store Lua config      server = {          dedicated = true,          datadir = "{ZenData}",          abslog = "{ZenData}\\local.log",          debug = false,          sentry = {              disable = false,              allowpersonalinfo = false,          }      }      network = {          httpserverclass = "httpsys", -- httpsys|asio          port = 8558,      }      gc = {          intervalseconds = 28800, -- every 8 hour          lightweightintervalseconds = 3600, -- every hour          cache = {              maxdurationseconds = 864000, -- 10 days          }      }      cache = {          enable = true,          accesslog = false,          upstream = {              upstreamthreadcount = 4,              policy = "disabled", -- readwrite|readonly|writeonly|disabled          },          memlayer = {              targetfootprint = 1073741824, -- 1 GB              triminterval = 120, -- max every 2 minutes              maxage = 172800, -- 2 days          }      }
   ```
4. 修改你的zen_config.lua文件，确保：

   - `server\data_dir` 与你的{ZenData}目录一致，并将 **所有反斜杠都替换为双反斜杠** （例如将 `C:\myfolder\mysubfolder` 变为 `C:\\myfolder\\mysubfolder` ）。
   - 将 `server\abslog` 设为写入日志文件位置的路径，并将 **所有反斜杠都替换为双反斜杠** （例如将 `C:\myfolder\mysubfolder\local.log` 变为 `C:\\myfolder\\mysubfolder\\local.log` ）。

   另外，请谨慎选择是否要使用Sentry服务与Epic Games共享Zenserver的崩溃信息：

   - `server\sentry\disable` 在上述配置中为false，这意味着Zenserver的崩溃信息将通过Sentry服务与Epic Games共享。要阻止共享，你可以将此值设为true。
   - `server\sentry\allowpersonalinfo` 的值为false，以防止在发生崩溃时向崩溃记录系统上传日志或用户名。如果未禁用Sentry服务，则当此值为false时，崩溃记录仍将被发送到 Epic Games，但其中将不会包含日志、用户名或其他潜在的身份信息。

   修改 `zen_config.lua` 文件时，请记住：

   - 在待转义的特殊字符（如反斜杠）前使用反斜杠。
   - 将字符串值括在双引号中。
   - 在字段或结构末尾保留逗号。
   - 以双破折号 "**--**" 作为注释的前缀。该行中双破折号后的所有内容都将被忽略。
5. 确保将Zenserver安装为一项服务，并让其在启动时自动运行，并在发生故障后重新启动。这可以通过高级命令提示符使用以下命令来完成：

   命令行

   ```
        sc create "Zen Store" start=auto binpath="{ZenInstall}\zenserver.exe --config={ZenInstall}\zen_config.lua" obj={ZenUser} password={ZenPassword}		     sc failure "Zen Store" reset=60 actions=restart/60000
   ```

   如果以系统用户身份运行，则可以省略命令行的 `obj={ZenUser} password={ZenPassword}` 部分。
6. 使用以下命令启动Zenserver服务：

   命令行

   ```
        sc start "Zen Store"
   ```
7. 通过以下方式确认zenserver.exe正在运行且可访问：

   - 检查任务管理器中是否存在该程序。
   - 在服务器主机的浏览器中打开 `http://localhost:8558/dashboard` 并确保它可以响应。
   - 在网络中另一台机器的浏览器中打开 `http://<public_hostname_or_ip>:8558/dashboard` 并确保它可以响应。

   如果该进程并未运行，请检查配置的日志位置，并查看日志文件是否指出了问题。

   如果进程正在运行且可以作为本地主机进行访问，但未使用 ，则请确保已配置前述设置步骤中提到的 `http.sys` URL保留权限。
8. 重新启动服务器主机，并确保Zenserver在启动时自动启动。

## 设置虚幻引擎客户端以使用Zenserver共享DDC服务器

### 理解并选择命名空间

命名空间是Zenserver共享DDC和虚幻引擎云DDC都具有的功能。命名空间被用于将项目的DDC数据分隔到单独的逻辑空间中，这些逻辑空间可以在[虚幻引擎云DDC中拥有单独的访问权限](../../using-derived-data-cache/how-to-set-up-a-cloud-type-derived-data-cache/index.md#%E5%91%BD%E5%90%8D%E7%A9%BA%E9%97%B4)。

Zenserver目前不强制执行命名空间的访问控制（所有用户都可以访问所有数据，不论数据位于哪个命名空间）。不过，它会将一个命名空间中的数据与另一个命名空间中的数据略做区分。

存在一个内容可寻址的存储层，它能够去除重复的字节，但两个DDC密钥可以在两个命名空间中存储不同的数据Blob，并且在一个命名空间中对密钥进行写入不会影响另一个命名空间中的密钥。

多个项目可以共享同一个命名空间，但根据一般经验，如果你希望对可以访问项目数据的人进行区别，那么你应该为该项目指定单独的命名空间。Zenserver和虚幻云DDC接受任意的命名空间名称，只要符合下列限制即可：

- 不超过64个字符
- 不以句号开头或结尾
- 由小写拉丁字母数字字符（a至z、0至9）或破折号（-）、下划线（_）或点（.）等字符组成

### 标准配置

一旦服务器设置完成并确认可在浏览器访问，你就可以更改一个或多个虚幻引擎项目的配置，从而使用该服务器。要完成此操作，你需要关注项目DefaultEngine.ini文件中的 `[DerivedDataBackendGraph]` 和 `[StorageServers]` 分段。

`BaseEngine.ini` 中的常规配置指定了两个有命名的共享层：

- **Shared**- 被配置为传统的文件共享DDC（type=FileSystem）
- **ZenShared** - 被配置为Zenserver共享DDC（type=Zen）

务必注意，ZenShared层拥有一个特殊功能，使其能使用 `ServerID=<StorageServersKeyName>` 参数，将配置重定向到配置文件的 `[StorageServers]` 分段。具体来说，它使用 `ServerID=Shared` 重定向至 `[StorageServers]` 下的共享密钥。

`StorageServers\Shared` 的基本/常规配置如下：

BaseEngine.ini

```
	[StorageServers] 	Shared=(Host=**None**, Namespace="**ue.ddc**", EnvHostOverride=UE-ZenSharedDataCacheHost, CommandLineHostOverride=ZenSharedDataCacheHost, DeactivateAt=60)
```

`BaseEngine.ini` 对各条目可用的参数给出了详尽的注释。不过就设置而言，请特别关注两个参数：

- **主机（Host）：** 待连接服务器的URL。本地自动启动的Zen实例可以排除此项。例如： `http://sharedzen.example.com:8558`.
- **命名空间（Namespace）：** 服务器上使用的缓存命名空间（必填）。

要让虚幻引擎使用Zen共享DDC，必须从BaseEngine.ini中复制此行的常规配置，并将其粘贴到项目的 `DefaultEngine.ini` 文件中，然后对其进行修改，以指定适合环境的主机和命名空间。例如：

BaseEngine.ini

```
	[StorageServers] 	Shared=(Host="**http://public_hostname_or_ip:8558"**, Namespace="**myproject.ddc**", EnvHostOverride=UE-ZenSharedDataCacheHost, CommandLineHostOverride=ZenSharedDataCacheHost, DeactivateAt=60)
```

在上方示例中，我们让虚幻引擎连接到端口8558的Zenserver共享DDC，其主机名为 `public_hostname_or_ip` ，并指示它将DDC数据存储在名为 `myproject.ddc` 的命名空间中。

让 `DefaultEngine.ini` 文件使用此配置后，请启动游戏编辑器并检查日志，以确认存在以下日志行：

日志输出

```
	LogDerivedDataCache：Display: ZenShared: Using ZenServer HTTP service at http://public_hostname_or_ip:8558/ with namespace myproject.ddc status: OK!.
```

确认无误后，你就可以成功使用Zenserver共享DDC了，也可以同时使用文件共享DDC（如果有）。

如果文件共享DDC中填满了过去的数据，建议以两周为过渡期，同时使用文件共享DDC和Zenserver共享DDC。两周后，可以考虑禁用文件共享DDC。方法是在项目的 `DefaultEngine.ini` 中将文件共享DDC设置为 `Path=None` ，或者覆盖下列基础图表节点集，从而将其从项目图表中完全移除：

DefaultEngine.ini

```
	Root=(Type=Hierarchical, Inner=Pak, Inner=EnginePak, Inner=ZenLocal, Inner=Local, Inner=ZenShared**, Inner=Shared**, Inner=Cloud)
```

如此一来，列表中将清除"Shared"部分，如下所示：

DefaultEngine.ini

```
	Root=(Type=Hierarchical, Inner=Pak, Inner=EnginePak, Inner=ZenLocal, Inner=Local, Inner=ZenShared, Inner=Cloud)
```

如果你正在设置Zenserver共享DDC，且不存在历史文件共享DDC，那么你无需两周过渡期，可以直接从列表中删除"Shared"部分。

### 多区域配置

如果你的用户分布在多个区域，那么你可以为每个地区/办公室都设置一个文件共享DDC。转到Zenserver共享DDC即意味着在每个地区/办事处设置一个Zenserver共享DDC，然后选择一种策略，让各个虚幻引擎客户端选择适合该地区的服务器。你可以通过多种方式来选择适合地区的服务器。

- 可以使用群组策略为各办公室/地区的机器设置环境变量，也可以使用其他机制，例如：

  - 西雅图的环境变量： `UE-ZenSharedDataCacheHost=seattle-zen.domain.com`
  - 丹佛的环境变量： `UE-ZenSharedDataCacheHost=denver-zen.domain.com`
  - 蒙特利尔的环境变量： `E-ZenSharedDataCacheHost=montreal-zen.domain.com`
- 可以使用针对站点的DNS，从而让同一主机名指向不同站点的不同IP地址。

## 使用从共享到Zenserver共享的重定向

最后可考虑的选项是，使用重定向机制，让虚幻引擎自动由使用文件共享DDC切换为使用Zenserver共享DDC。可通过覆盖文件共享DDC的配置来设置重定向。原配置如下：

ddc.ini

```
	Shared=(Type=FileSystem, UnusedFileAge=10, FoldersToClean=10, ConsiderSlowAt=70, Path=?EpicDDC, EnvPathOverride=UE-SharedDataCachePath, EditorOverrideSetting=SharedDerivedDataCache, CommandLineOverride=SharedDataCachePath)
```

变更后的配置为：

ddc.ini

```
	Shared=(Type=FileSystem, UnusedFileAge=10, FoldersToClean=10, ConsiderSlowAt=70, Path=?EpicDDC, EnvPathOverride=UE-SharedDataCachePath, EditorOverrideSetting=SharedDerivedDataCache, CommandLineOverride=SharedDataCachePath**, RedirectionFileName=ddc.ini**)
```

注意添加的 **", RedirectionFileName=ddc.ini".** 它表示文件共享DDC应在文件共享根目录下查找名为ddc.ini的文件，如果该文件存在，则尝试从中读取重定向信息。

如果该文件不存在，或不包含重定向信息，那么将按原样使用文件共享DDC。为了从Shared重定向为ZenShared，可以在文件共享DDC根目录下放置一个 `ddc.ini` 文件，并在文件中包含以下内容：

ddc.ini

```
	[Redirect]		Default=(Target=ZenShared, SetEnvName=UE-ZenSharedDataCacheHost, SetEnvValue=public_hostname_or_ip)
```

此重定向会让虚幻引擎将自身进程的 `UE-ZenSharedDataCacheHost` 环境变量单独设置为public_hostname_or_ip，并尝试使用ZenShared节点配置。

如果你的文件共享使用了分布式文件系统（DFS）架构，且其中主机名可根据地区映射到不同的实际主机，那么对多地区DDC配置而言，使用重定向将非常有用。然后各个实际主机将都可以拥有对应的 `ddc.ini` 文件，并重定向到适合地区的Zenserver主机名。例如：

西雅图：`\\seattle-fileshare.domain.com\ddc\ddc.ini` 包含重定向至 `seattle-zen.domain.com` 的配置。

丹佛：`\\denver-fileshare.domain.com\ddc\ddc.ini` 包含重定向至 `denver-zen.domain.com` 的配置。

蒙特利尔：`\\montreal-fileshare.domain.com\ddc\ddc.ini` 包含重定向至 `montreal-zen.domain.com` 的配置。

## 在编辑器中验证性能

一旦你在服务器端完成了Zenserver共享DDC的设置，并将其配置为供虚幻引擎或客户端使用，就应该验证到Zenserver共享DDC的延迟是否符合预期。为此，请点击虚幻编辑器主窗口右下角的衍生数据（Derived Data）控件，并选择查看缓存统计数据（View Cache Statistics）。

![undefined](../../../../assets/images/98/98a69f7c2b26625be379c2c5b1418c5d12d0358d88fc207d98dee9b3e5646cb3.jpg)

这时将显示缓存统计数据（Cache Statistics）面板。面板中应该会显示DDC层级中的活动层。如前文所述，显示的内容应该如下：

![undefined](../../../../assets/images/12/12e329106205bf2f783b21d5fa00e03798701543dc93c4a826d721f2c84ae939.jpg)

1. 本地DDC - 缓存类型 = Zen，位置 = 本地
2. 新建的Zen共享DDC - 缓存类型 = Zen，位置 = 远程
3. （如果有）云DDC - 缓存类型 = 虚幻云DDC，位置 = 远程

如果你的图表中仍存在文件共享DDC，那么列表中应该也会显示。你可以使用此面板检查Zenserver共享DDC的延迟，确保其符合预期。理想情况下，Zenserver共享DDC的延迟应低于20毫秒，但当客户端机器距离Zenserver共享DDC较远时，延迟可能变大。只要Zen共享DDC的延迟低于60毫秒，那么编辑器和烘焙器就会使用Zen共享DDC。

## 参考

- [Zen公共GitHub库](https://github.com/EpicGames/zen)
- [Zen开发自述文件](https://github.com/EpicGames/zen/blob/main/README.md)
- [Epic Zen配置模版](https://github.com/EpicGames/zen/blob/main/upstream-config-templates/zen_config.lua.j2)
- [DDC用户指南](../../using-derived-data-cache/index.md)
- [虚幻引擎云DDC设置指南](../../using-derived-data-cache/how-to-set-up-a-cloud-type-derived-data-cache/index.md)
