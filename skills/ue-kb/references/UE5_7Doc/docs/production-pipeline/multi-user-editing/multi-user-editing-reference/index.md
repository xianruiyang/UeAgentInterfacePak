---
title: "多用户编辑参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/multi-user-editing-reference-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "虚幻引擎多用户编辑", "多用户编辑参考"]
---

# 多用户编辑参考

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 虚幻引擎多用户编辑 / 多用户编辑参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/multi-user-editing-reference-for-unreal-engine

本页面包含 **多用户编辑** 系统的要求、设置、命令行参数和控制台命令的相关信息。

## 项目设置

### 多用户编辑设置

当你在项目中激活 **多用户编辑插件** 时，可以在 **项目设置（Project Settings）** 窗口的 **插件（Plugins ）> 多用户编辑（Multi-User Editing）** 下访问以下设置。

![Multi-User Editing settings](../../../../assets/images/7e/7e6f32c1facf800c3d1f099624ace6378ba5e747b8b98254827cd2f6e5cb9d6c.png)

| 设置 | 描述 |
| --- | --- |
| **客户端设置** |  |
| **启用多用户工具栏按钮（Enable Multi-User Toolbar Button）** | 启用后，虚幻编辑器主窗口里的工具栏将包含一个按钮，以便用户快速执行常规多用户编辑任务： Join：用户断开链接后，下方会保存默认服务器名称或会话名称。点击 **加入** 即可加入默认会话。 Browse：用户断开链接后，如果下方没有保存默认服务器名称或会话名称，可点击 **浏览** 开启 **多用户浏览器** 查找并手动加入会话。 Leave：在接入会话的状态下，可以点击 **离开** 断开连接。 Cancel：连接会话时，点击 **取消（Cancel）** 可以断开连接。 你也可以随时用工具栏按钮旁的下箭头来访问 **多用户浏览器**，打开 **项目设置** 窗口或在你的电脑上开启多用户服务器。 |
| **自动连接（Auto Connect）** | 启用此设置可使虚幻编辑器在每次打开此项目时，立即尝试与 **默认服务器** 和其下方设置的 **默认会话名称** 建立连接。 |
| **默认服务器URL（Default Server URL）** | 当你启用 **自动连接（Auto Connect）** 设置或点击工具栏上的 **加入** 按钮时，多用户编辑系统试图连接的服务器名称进行设置。 必须将其设置为服务器所在的电脑的主机名，如 **会话浏览器（Session Browser）** 窗口所示。 |
| **默认会话名称（Default Session Name）** | 当你启用 **自动连接（Auto Connect）** 设置或点击工具栏上的 **加入** 按钮时，多用户编辑系统尝试连接的会话名称进行设置。 如果在默认服务器上，以该名字命名的会话尚未创建，服务器将启动一个新会话。 |
| **默认恢复的会话（Default Session to Restore）** | 当你启用 **自动连接（Auto Connect）** 设置或点击工具栏上的 **加入** 按钮时，恢复已保存的会话，请输入该会话的名称。 |
| **会话默认另存名（Default Save Session As）** | 当你启用 **自动连接（Auto Connect）** 设置或点击工具栏上的 **加入** 按钮时，多用户编辑系统保存其打开的会话，请输入希望该会话另存时的命名。 |
| **显示名称（Display Name）** | 在对其他用户可见的所有在线状态信息中，设置你的识别名称。 |
| **化身颜色（Avatar Color）** | 在对其他用户可见的所有在线状态信息中，设置多用户编辑系统与你关联的颜色。 |
| **桌面化身Actor类（Desktop Avatar Actor Class）** | 设置当你使用标准键盘和鼠标与虚幻编辑器交互时，多用户编辑系统在其他用户的关卡视口中用于代表你的类。 如果想要对默认化身进行更改，你可以从内置的 **DesktopPresence** 类中派生自己的蓝图类，并根据你的需求对其进行自定义。 |
| **VR化身Actor类（VRAvatar Actor Class）** | 设置在你使用VR头戴设备和控制器通过VR编辑系统在关卡中工作时，多用户编辑系统在其他用户的关卡视口中用于代表你的类。 如果想要对默认化身进行更改，你可以从内置的 **VRPresence** 类中派生自己的蓝图类，并根据你的需求对其进行自定义。 |
| **客户端设置——高级** |  |
| **服务器端口（Server Port）** | 当你从虚幻编辑器启动多用户编辑服务器时，服务器会监听你在此设置中指定的组播通信端口。 假如你在UDP消息设置中为单播端点IP地址也设置了一个端口，则你在 **服务器端口（Server Port）** 中设置的端口会被优先使用。另请参阅[高级多用户网络](../advanced-multi-user-networking/index.md)。 |
| **发现超时（Discovery Timeout）** | 如果先前发现的服务器没有在此时间范围内响应消息，它将被视为超时，并从 **多用户浏览器** 的列表中删除。 |
| **会话更新计时频率（Session Tick Frequency）** | 确定虚幻编辑器实例处理会话更新的频率。 |
| **延迟补偿（Latency Compensation）** | 确定当处理涉及Sequencer播放等对时间敏感的操作的传入事务时，虚幻编辑器实例应该采用的补偿数额。 |
| **端点设置** |  |
| **启用日志记录（Enable Logging）** | 确定此虚幻编辑器实例是否应记录关于当前会话的详细信息。你可以在项目的 `Saved/Logs/Concert 子文件夹中找到这些日志。 激活此选项会在短时间内消耗大量磁盘空间。 如果你在启用过日志后再将其禁用，就需要手动移除日志文件以释放磁盘空间。 |
| **清除已处理消息的延迟（Purge Processed Message Delay）** | 对于已处理的任何会话状态消息，确定虚幻编辑器实例在将其从内存中删除之前所应等待的时间。 |
| **远程端点超时（Remote Endpoint Timeout）** | 如果虚幻编辑器的远程实例没有对消息在该时间范围内进行响应，它将被视为超时，并从当前会话中删除。 |

### 多用户事务设置

你还可以在 **插件（Plugins）> 多用户事务（Multi-User Transactions）** 下访问以下设置。

![Multi-User Editing transaction settings](../../../../assets/images/b2/b201fe2d105e5538afff1e44a4c39bf90ff7ea73d9a9602cf7d884cd93a3cb91.jpg)

> [!NOTE]
> 在你多次使用默认值对多用户编辑系统完成操作，并对其工作原理建立深刻理解之前，请避免调整这些设置。更改这些设置会影响多用户编辑系统的稳定性。

| 设置 | 描述 |
| --- | --- |
| **事务设置** |  |
| **每秒快照事务数（Snapshot Transactions Per Second）** | 当你与工具或功能按钮交互时，为了与其他客户端实现更改的实时同步，多用户编辑系统每秒所发送的事务数量，例如，当在关卡视口中拖动Actor，或在Actor的 **细节（Details）** 面板中拖动滑块时。 |
| **包含对象类过滤器（Include Object Class Filters）** | 当此列表为空时，为了对所有类的类型进行修改，多用户编辑系统会自动发送事务。如果你坚持只对某些特定类的修改进行同步，可以在此列表中指定这些类。此列表中默认显示的值，都已经过测试，并被判断为足够稳定，可以公开。 |
| **排除事务类过滤器（Exclude Transaction Class Filters）** | 如果你希望限制多用户编辑系统，避免同步对某些类的更改，可以在此列表中指定这些类。任何事务，只要涉及了更改这些被排除的类的对象，都不会被同步。 该列表的优先级高于前文的 **包含对象类过滤器（Include Object Class Filters）** 列表。 默认情况下，该列表包括地形类。在保存包含地形的关卡之前，你对地形所做的任何修改都不会被同步。 |
| **允许的瞬态属性（Allowed Transient Properties）** | 包含瞬态类属性的列表，它们始终会被同步，虽然通常会被过滤掉。编辑器中默认条目同步Actor的可视性。如果希望在同一关卡工作的不同用户能够显示和隐藏不同的Actor集，你可以从列表中将这些默认条目删除。 如果需要更改这些值，请直接在 `Saved/Config/<platform>/Engine.ini` 文件的 `[/Script/ConcertSyncCore.ConcertSyncConfig]` 分段进行修改，切勿在UI中修改。 |
| **事务设置 — 高级** |  |
| **交互的编辑器热重载（Interactive Editor Hot Reload）** | 确定当虚幻编辑器需要将已完成加载的资产替换为相同资产的其他版本，应如何处理。当连接至你的会话的另一个用户对该资产进行修改并保存时，就会发生这种情况。当你离开会话而不保存更改时，也会发生这种情况，编辑器需要把你在会话中修改的内容替换为你加入会话时的初始内容。 如果继续禁用此设置，你新加载的内容会立即替换以前所加载的内容。如果希望系统提示你是否重新加载每个修改后的资产，请启用此设置。 |
| **在PIE中显示在线状态（Show Presence in PIE）** | 确定当你处于 **在编辑器中运行（PIE）** 会话时，是否应显示其他用户的在线状态信息。 |
| **打包设置（Package Settings）** |  |
| **排除打包类过滤（Exclude Package Class Filters）** | 决定哪些保存的包不会传播到多用户服务器。你可以通过包的路径和特定的资产类别来过滤。例如，在 **内容路径** 中添加 **/Game/Maps/**，这会阻止所有保存在 **/Game/Maps/** 中的内容传播到多用户服务器上。 |

## 虚幻多用户服务器的命令行参数

我们在[入门](../getting-started-with-multi-user-editing/index.md)页面说明了，如何从虚幻编辑器的UI内启动多用户编辑系统的服务器组件。但是，你也可以在任何安装了虚幻引擎的电脑上从命令行启动此服务器。

如果从命令行运行服务器，则不需要在该电脑上运行项目。服务器只记录事务和修改后的资产；它不必提供完整的项目内容。只有加入会话的电脑需要有项目内容的副本。

你可以在虚幻引擎安装文件夹中找到多用户编辑服务器，位于 `Engine/Binaries/<platform>/UnrealMultiUserServer.exe`。启动它时，可以在命令行上提供以下可选参数控制其行为。

| 参数 | 描述 |
| --- | --- |
| **-ConcertSession=** | 如果已指定，服务器会在启动时创建一个以此命名的新会话。例如： `-ConcertSession=DemoSession` |
| **-ConcertProject=** | 如果你已经指定了一个 **-ConcertSession**，服务器会把 **ConcertProject** 的值设置为与该会话相关联的虚幻引擎项目的名称。它所允许连接的虚幻编辑器实例，必须正在运行同名项目。例如： `-ConcertProject=MyUprojectName` |
| **-ConcertVersion=** | 如果你已经指定了一个 **-ConcertSession**，服务器会使用 **ConcertVersion** 的值作为与该会话相关联的虚幻引擎的版本。它所允许连接的虚幻编辑器实例，必须使用相同的版本构建。例如： `-ConcertVersion=4.22.0-123456` 要获取此版本号，请打开虚幻编辑器，从主菜单选择 **帮助（Help）> 关于虚幻编辑器...（About Unreal Editor...）**。 |
| **-ConcertRevision=** | 如果你已经指定了一个 **-ConcertSession**，服务器会使用 **ConcertRevsion** 的值作为与会话相关的基础源代码控制变更列表。它要求连入的虚幻编辑器实例，具备有效的源代码管理、已签出了相同版本的内容、没有本地修改。例如： `-ConcertRevision=4725058` |
| **-ConcertIgnore** | 如果想要避免多用户编辑服务器对连接的虚幻编辑器实例与每个会话相关联的项目名称、引擎版本和内容源代码管理变更列表是否匹配进行验证，请将此值添加到命令行。 虽然有时允许客户端在项目内容中存在细微差异的情况下进行连接可能很有用，但是在典型工作流中你应该避免对此设置的依赖，从而防止由于内容在不同客户端上的不同步而导致的任何意外操作。 |
| **-ConcertClean** | 如果你希望服务器在启动时，从其临时存储目录中删除所有现有会话文件，请将此值添加至命令行。 这将删除所有保存的会话。 |
| **-ConcertSaveSessionAs=** | 如果你已经指定了一个 **-ConcertSession**，那么如果服务器在会话删除之前被关闭，将使用 **ConcertSaveSessionAs** 的值来定义用来另存会话数据的名称。这种指定名称的方式，相当于当你在虚幻编辑器UI中创建新会话时，设置 **会话数据管理（Session Data Management）> 会话另存为（Save Session As）**。 保存会话并关闭服务器后，你可以使用 **ConcertSessionToRestore** 参数再次启动服务器，从而恢复该会话的状态。 |
| **-ConcertSessionToRestore=** | 如果你已经指定了一个 **-ConcertSession**，则可以使用此参数还原该服务器曾用该指定名称保存的会话，而不是创建新会话。 |

## 虚幻编辑器命令行参数

如果从命令行启动虚幻编辑器，你可以使用以下参数来对多用户编辑系统进行控制。这些参数是上文 [项目设置（Project Settings）](#%E9%A1%B9%E7%9B%AE%E8%AE%BE%E7%BD%AE) 下列出的一些设置的默认值。

| 参数 | 描述 |
| --- | --- |
| **-ConcertAutoConnect** | 为你的项目启用 **自动连接（Auto Connect）** 设置。启动后，虚幻编辑器将立即尝试与默认服务器和为其配置的会话建立连接。你可以提前在 **项目设置（Project Settings）** 中对此默认会话配置进行设置，或者使用以下参数在命令行中进行指定。 |
| **-ConcertServer=** | 设置项目的 **默认服务器URL（Default Server URL）** 的值。 |
| **-ConcertSession=** | 设置项目的 **默认会话名称（Default Session Name）** 的值。 |
| **-ConcertSaveSessionAs=** | 设置项目的 **默认的会话另存名称（Default Save Session As）** 的值。 |
| **-ConcertSessionToRestore=** | 设置项目的 **默认恢复的会话（Default Session to Restore）** 的值。 |
| **-ConcertDisplayName=** | 设置项目的 **显示名称（Display Name）** 的值。 |

## 控制台命令

本部分列出了影响多用户编辑系统的虚幻引擎控制台命令。

| 命令 | 说明 |
| --- | --- |
| `Concert.DefaultConnect` | 如果你在项目设置（Project Settings）中，已经设置了 **默认服务器URL（Default Server URL）** 和 **默认会话名称（Default Session Name）**，并且尚未连接至多用户编辑会话，此控制台命令会立即尝试将你连接至默认服务器和会话。 |
| `Concert.Disconnect` | 如果连接存在，会断开你与当前的会话的连接。 |
| `Concert.EnableOpenRemoteSequencer` | 启用了该设置的用户，在Sequencer UI中打开关卡序列或主序列时，多用户编辑系统都会自动为同一会话中也启用了此设置的所有其他用户打开Sequencer UI ，并加载相同的序列。 默认情况下，此设置被禁用。输入 `Concert.EnableOpenRemoteSequencer 1` 启用该设置，或 `Concert.EnableOpenRemoteSequencer 0` 禁用该设置。 |
| `Concert.EnablePresence` | 启用此设置后，对于每个在同一关卡工作并且在"项目设置（Project Settings）"中设置了 **桌面化身Actor类（Desktop Avatar Actor Class）** 或 **VR化身Actor类（VRAvatar Actor Class）** 的其他用户，你都将在关卡视口中看到一个Actor，该Actor代表了该用户的当前位置和视点。 |
| `Concert.EnableSequencePlayer` | 默认情况下，多用户编辑系统仅会在Sequencer UI中打开的序列相同的虚幻编辑器实例之间，同步Sequencer播放事件。 如果你想让Sequencer播放事件与在 `-游戏` 模式下运行的虚幻编辑器实例同步，请启用此设置。 默认情况下，此设置被禁用。输入 `Concert.EnableOpenRemoteSequencer 1` 启用该设置，或 `Concert.EnableOpenRemoteSequencer 0` 禁用该设置。你必须为每个以你想要响应这些播放事件的 `-游戏` 参数开始的虚幻编辑器实例启用该设置。 注意，假如你在启动引擎时使用了"-game"参数，你还需要同时使用"-messaging"参数。 |
| `Concert.OpenBrowser` | 打开 **多用户浏览器（Multi-User Browser）** 窗口。相当于从主菜单选择 **窗口（Windows）> 开发者工具（Developer Tools）> 多用户浏览器（Multi-User Browser）** 或从工具栏里的多用户编辑（Multi-User Editing）旁的下箭头选择 **会话浏览器（Session Browser）** 。 |
| `Concert.OpenSettings` | 打开 **项目设置（Project Settings）** 窗口至 **插件（Plugins）- 多用户编辑（Multi-User Editing）** 页面。相当于从工具栏中的多用户编辑按钮旁的下箭头中选择 **多用户设置（Multi-User Settings）**。 有关这些设置的细节，请参见上文中的 [项目设置（Project Settings）](#%E9%A1%B9%E7%9B%AE%E8%AE%BE%E7%BD%AE)。 |
