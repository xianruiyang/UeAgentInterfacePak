# iOS

---
title: "iOS"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/ios-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "平台", "iOS"]
---

# iOS

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 平台 / iOS

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/ios-settings-in-the-unreal-engine-project-settings

## iOS

### 移动预配

默认情况下，虚幻引擎会在你的计算机上扫描所有可用的移动预配配置文件和证书（由Apple提供），并自动选择要使用哪些。

你可以在以下设置中选择预配配置文件和证书，覆盖该行为。

| **设置** | **说明** |
| --- | --- |
| **导入预配（Import Provision）** | 在此处选择你的应用程序的预配配置文件。 |
| **导入证书（Import Certificate）** | 在此处选择你的应用程序的证书。 |

### 程序包信息

> [!NOTE]
> 使用4.6或更早版本的用户请注意：现在引擎会在构建时会生成 `Info.plist` 文件，因此如果你自定义了 `.plist` 文件，你将需要将所有更改放入下面的设置中。请注意，引擎不会更改你的项目目录中的 `.plist` 文件，这样你可以将其用作参考。

| **设置** | **说明** |
| --- | --- |
| **程序包显示名称（Bundle Display Name）** | 指定应用程序的显示名称。 这显示在设备上的图标下。 |
| **程序包名称（Bundle Name）** | 指定应用程序包的名称。 这是应用程序包的简称。 |
| **程序包标识符（Bundle Identifier）** | 设置程序包标识符（程序包ID），用于在App Store中唯一识别你的应用。 |
| **版本信息（Version Info）** | 指定应用程序的版本。 |

### 方向

| **设置** | **说明** |
| --- | --- |
| **支持纵向方向（Supports Portrait Orientation）** | 支持默认纵向方向。 不支持横向。 |
| **支持上下颠倒方向（Supports Upside Down Orientation）** | 支持上下颠倒方向。 不支持横向。 |
| **支持横向左方向（Supports Landscape Left Orientation）** | 支持左横向方向。 选择此设置后，不支持纵向方向。 |
| **支持横向由方向（Supports Landscape Right Orientation）** | 支持右横向方向。 选择此设置后，不支持纵向方向。 |
| **偏好横向方向（Preferred Landscape Orientation）** | 横向左和横向右方向都受支持时，偏好方向将用作启动时的初始方向。 你可以从以下选项中选择： **横向（左主页按钮）（Landscape (left Home button)）** **横向（右主页按钮）（Landscape (right Home button)）** |

### 输入

| **设置** | **说明** |
| --- | --- |
| **游戏可以同时连接多个游戏手柄（Can the Game Have Multiple Gamepads Connected at a Single Time）** | 启用后，游戏将能够同时处理多个游戏手柄（Siri Remote是一种游戏手柄）。 |
| **允许AppleTV Remote横向模式（Allow AppleTV Remote Landscape Mode）** | 启用后，Siri Remote可以旋转到横向视图。 |
| **使用AppleTV Remote绝对触控板值（Use AppleTV Remote Absolute Trackpad Values）** | 启用后，对于虚拟摇杆，触控板的中心是 `0,0` （中心）。 禁用后，用户点击的位置将变为 `0,0` 。 |
| **允许MFi（蓝牙）控制器（Allow MFi (Bluetooth) Controllers）** | 启用后，连接蓝牙的控制器将发送输入。 |
| **在附加控制器时阻止在设备上强制反馈（Block Force Feedback on the Device When Controllers Are Attached）** | 在附加控制器时阻止在设备上强制反馈。 |
| **禁用运动控制（Disable Motion Controls）** | 禁用设备运动数据。 如果应用程序不使用运动数据，禁用此选项将提高电池寿命。 |
| **使用集成键盘（Use Integrated Keyboard）** | 定义键盘是否应该可在没有 `UITextField` 的情况下单独使用。 |

### 文件系统

| **设置** | **说明** |
| --- | --- |
| **支持iTunes文件共享（Support iTunes File Sharing）** | 定义是否可从iTunes文件共享功能访问应用创建的文件。 |
| **支持文件应用（Support Files App）** | 定义是否可从设备的"文件"应用（需要iTunes文件共享）中访问应用创建的文件。 |

### 渲染

| **设置** | **说明** |
| --- | --- |
| **使用Fast-Math固有参数（Use Fast-Math Intrinsics）** | 是否使用金属着色语言的"fast"固有参数。 Fast固有参数假定不会提供 `NaN` 或 `INF` 值作为输入，因此它们更高效。 但是，如果参数中存在 `NaN` / `INF` ，它们会生成未定义的结果。 |
| **强制32位浮点精度（Force 32-bit Floating Point Precision）** | 定义是否强制金属着色器使用32位浮点精度，即使着色器使用半浮点。 半浮点高效得多（可用时），但在远距离时准确性更低。一些项目可能需要使用32位浮点来确保正确的渲染。 |
| **启用Fast-Math优化（Enable Fast-Math Optimizations）** | 定义是否使用金属着色器编译器的 `-ffast-math` 优化。 Fast-Math将执行浮点算术标准（IEEE-754）不允许的代数等效和再结合优化。 这些可以提高着色器性能，代价是牺牲一些精度，并可能导致NaN/INF传播，因为它们依赖不包含 `NaN` / `INF` 值的着色器输入或变量。 默认启用Fast-Math以提高性能。 |
| **编译着色器时要使用的间接参数缓冲区层（Tier of Indirect Argument Buffers to Use When Compiling Shaders）** | 定义是否使用层间接参数缓冲区编译着色器。 |
| **支持Apple A8（Support Apple A8）** | 启用对Apple A8设备的支持并禁用3D纹理压缩。 |
| **金属移动渲染器（Metal Mobile Renderer）** | 是否为移动渲染器编译iOS金属着色器（需要iOS 8+和A7处理器）。 |
| **金属桌面渲染器（Metal Desktop Renderer）** | 是否为桌面渲染器编译iOS金属着色器（需要iOS 10+和A10处理器）。 |
| **要作为目标的金属着色器标准（Metal Shader Standard To Target）** | 编译着色器时要使用的金属着色器语言版本。 你可以从以下选项中选择： **最低，当前v2.3（Minimum, Currently v2.3 (iOS 14.0 / tvOS 14.0)）** **金属v2.3（Metal v2.3 (iOS 14.0 / tvOS 14.0)）** **金属v2.4（Metal v2.4 (iOS 15.0 / tvOS 15.0)）** |

### 操作系统信息

| **设置** | **说明** |
| --- | --- |
| **最低iOS 版本（Minimum iOS Version）** | 定义应用支持的最低iOS版本。 你可以从以下选项中选择： **14.0** **15.0** |

### 功率使用情况

| **设置** | **说明** |
| --- | --- |
| **帧率锁定（Frame Rate Lock）** | 设置最大帧率以节省功耗。 你可以从以下选项中选择： **无（None）** ：帧率不受限制。 **20 FPS** ：帧率限制为最大20帧/秒。 **30 FPS** ：帧率限制为最大30帧/秒。 **60 FPS** ：帧率限制为最大60帧/秒。 你还可以编辑此属性的配置值。 |
| **启用动态最大FPS（Enable Dynamic Max FPS）** | 启用后，引擎将从设备获取 `MaxRefreshRate` ，而不是 `IOSPlatform/framePacer` 类中的常量（20、30或60 FPS）。 你还可以编辑此属性的配置值。 |

### 设备

| **设置** | **说明** |
| --- | --- |
| **支持IPad（Supports IPad）** | 是否添加对iPad设备的支持。 |
| **支持IPad（Supports IPhone）** | 是否添加对iPhone设备的支持。 |

### 构建

| **设置** | **说明** |
| --- | --- |
| **将项目作为框架构建（试验性）（Build Project as a Framework (Experimental)）** | 定义是否将iOS项目作为框架构建。 |
| **覆盖金属工具链的位置（Override Location of Metal Toolchain）** | 使用Windows编译金属着色器时，使用该设置为Windows覆盖Apple的金属开发人员工具的默认安装位置。 |
| **生成dSYM用于代码调试和分析（Generate dSYMs for Code Debugging and Profiling）** | 启用dSYM文件的生成。 |
| **生成dSYM作为第三方崩溃工具的程序包（Generate dSYMs as a Bundle for Third Party Crash Tools）** | 启用dSYM程序包的生成。 |
| **生成.udebugsymbols文件（Generate .udebugsymbols File）** | 启用 `.udebugsymbols` 文件的生成，这允许针对Malloc Profiler或外部崩溃报告工具进行独立于平台的离线符号化。 现有dSYM文件或程序包。 |
| **生成Xcode存档包（Generate Xcode Archive Package）** | 启用Xcode存档包的生成。 |
| **在发售中支持Bitcode（Support Bitcode in Shipping）** | 定义是否启用Bitcode编译。 Apple不久将停止对该功能的支持。 |
| **启用广告标识符（Enable Advertising Identifier (IDFA)）** | 启用广告标识符（如需更多信息，请参阅[Apple的开发人员文档](https://developer.apple.com/documentation/adsupport/asidentifiermanager/1614151-advertisingidentifier)）。 |
| **其他非发售链接器标记（Additional Non-Shipping Linker Flags）** | 非发售版本中要传递到链接器的其他链接器标记。 你还可以编辑此属性的配置值。 |
| **其他发售链接器标记（Additional Shipping Linker Flags）** | 发售版本中要传递到链接器的其他链接器标记。 你还可以编辑此属性的配置值。 |
| **覆盖现有SSH权限文件（Override Existing SSH Permissions File）** | 连接到远程服务器时要使用的SSH权限密钥的路径。 你还可以编辑此属性的配置值。 |
| **支持tvOS上的用户切换（Support User Switching on tvOS）** | 定义应用是否应该与tvOS上的多用户功能兼容。 启用后，游戏将随典型退出流程关闭。 |
| **开发中心用户名（Dev Center Username）** | 通过Turnkey登录DevCenter时要使用的用户名或电子邮箱。 这可以在Turnkey中使用 `RunUAT Turnkey -command=ManageSettings` 覆盖。 进行构建时会剥离该值。 你还可以编辑此属性的配置值。 |
| **开发中心密码（Dev Center Password）** | 通过Turnkey登录DevCenter时要使用的密码。 此密码以明文保存，旨在用于共享账户。 进行构建时会剥离该值。 你还可以编辑此属性的配置值。 |
| **远程构建选项（Remote Build Options）** |  |
| **远程服务器名称（Remote Server Name）** | 将用于构建iOS的远程Mac的名称或IP地址。 你还可以编辑此属性的配置值。 |
| **RSync用户名（RSync User Name）** | 使用RSync的远程构建在远程服务器上的用户名。 应该匹配用于生成SSH私钥的用户名。 你还可以编辑此属性的配置值。 |
| **远程服务器覆盖构建路径（Remote Server Override Build Path）** | 构建文件将复制到的远程Mac上的可选路径。 如果留空，将使用 `~/UE5/Builds` 。 你还可以编辑此属性的配置值。 |
| **发现的现有SSH权限文件（Found Existing SSH Permissions File）** | 虚幻引擎发现的SSH密钥的现有位置。 |
| **Cw Rsync安装路径（Cw Rsync Install Path）** | cwRsync的安装目录。 你还可以编辑此属性的配置值。 |
| **生成SSH密钥（Generate SSH Key）** | 选择该设置以生成SSH密钥。 |

### 在线

| **设置** | **说明** |
| --- | --- |
| **启用游戏中心支持（Enable Game Center Support）** | 定义是否启用游戏中心支持（iOS在线子系统）。 你还可以编辑此属性的配置值。 |
| **启用云工具包支持（Enable Cloud Kit Support）** | 定义是否启用云工具包支持（iOS在线子系统）。 |
| **iCloud保存文件同步策略（iCloud Save Files Sync Strategy）** | 用于从iCloud保存文件读取的策略。 你可以从以下选项中选择： **从不（不将iCloud用于加载/保存游戏）（Never (do not use iCloud for Load / Save Game)）** ：仅在游戏启动时。 **仅在游戏启动时（At Game Start Only (iOS)）** ：仅在游戏启动时。 **总是（每当调用LoadGame时）（Always (whenever LoadGame is called)）** 。 |
| **启用背景获取（Enable Background Fetch）** | 定义是否启用背景获取支持。 |
| **启用Facebook支持（Enable Facebook Support）** | 定义应用是否支持Facebook。 |
| **Facebook应用ID（Facebook App ID）** | 从[Facebook的开发人员中心](https://developers.facebook.com/apps/)获取的Facebook应用ID。 为此，你需要Facebook的开发人员账号。 |
| **允许与非HTTPS网站的Web连接（Allow Web Connections to Non-HTTPS Websites）** | 定义是否允许建立与不使用HTTPS的网站的Web连接。 |
| **启用远程通知支持（Enable Remote Notifications Support）** | 启用远程通知支持。 这需要GitHub源。 |

### 额外PList数据

| **设置** | **说明** |
| --- | --- |
| **其他PList数据（Additional Plist Data）** | 其他plist键/值数据。 添加换行符 `\\n` 以分隔各行。 |

### 必需图标

| **设置** | **说明** |
| --- | --- |
| **营销图标（1024x1024）（Marketing Icon (1024x1024)）** | AppStore中使用的大小为1024x1024像素的 `.png` 图标。 其他图标大小可以根据营销图标生成。 |
| **默认iPhone图标（120x120）（Default iPhone Icon (120x120)）** | 用作iPhone默认值的 `.png` 图标。 |
| **默认iPad图标（152x152）（Default iPad Icon (152x152)）** | 用作iPad默认值的 `.png` 图标。 |
| **iPad Pro Retina应用图标（167x167）（iPad Pro Retina App Icon (167x167)）** | **默认iPad应用图标（Default iPad App Icon）** 的更高分辨率版本。 |

### 可选图标

| **设置** | **说明** |
| --- | --- |
| **3倍iPhone应用图标（180x180）（3x iPhone App Icon (180x180)）** | 3倍iPhone应用图标(180x180) |
| **3倍iPhone Spotlight图标（120x120）（3x iPhone Spotlight Icon (120x120)）** | 3倍iPhone Spotlight图标(120x120) |
| **默认Spotlight图标（80x80）（Default Spotlight Icon (80x80)）** | 默认Spotlight图标(80x80) |
| **3倍iPhone设置图标（87x87）（3x iPhone Settings Icon (87x87)）** | 3倍iPhone设置图标(87x87) |
| **默认设置图标（58x58）（Default Settings Icon (58x58)）** | 默认设置图标(58x58) |
| **3倍iPhone通知图标（60x60）（3x iPhone Notification Icon (60x60)）** | 3倍iPhone通知图标(60x60) |
| **默认通知图标（40x40）（Default Notification Icon (40x40)）** | 默认通知图标(40x40) |

### 启动画面

| **设置** | **说明** |
| --- | --- |
| **自定义启动画面故事板（试验性）（Custom Launchscreen Storyboard (Experimental)）** | 选择是否使用自定义启动画面。 要使用此选项，请在Xcode中创建故事板，并将其复制到项目文件夹下的 `Build/IOS/Resources/Interface` 中。将其命名为 `Launchscreen.storyboard` 。 这将编译并复制到程序包应用，并且应用中不会包含上面的启动画面图像。 使用自定义 `LaunchScreen.storyboard` 中的资产时，将其添加到 `Build/IOS/Resources/Interface/Assets` 中，应用中就会包含它们。 |
| **启动画面图像（Launch Screen Image）** | 此图像在未使用自定义启动画面故事板时用于启动画面。 此图像用于纵向和横向模式，并将缩放以占据所有设备的完整宽度或高度，因此如果你的应用支持这两种模式，推荐使用正方形图像。 提供的 `.png` 文件不得包含alpha通道。 |

### TvOS

| **设置** | **说明** |
| --- | --- |
| **图标大背面（1280x768）（Icon Large Back (1280x768)）** | *图标大背面(1280x768) |
| **图标大正面（1280x768）（Icon Large Front (1280x768)）** | *图标大正面(1280x768) |
| **图标大中间（1280x768）（Icon Large Middle (1280x768)）** | *图标大中间(1280x768) |
| **图标小背面（400x240）（Icon Small Back (400x240)）** | *图标小背面(400x240) |
| **图标小正面（400x240）（Icon Small Front (400x240)）** | *图标小正面(400x240) |
| **图标小中间（400x240）（Icon Small Middle (400x240)）** | *图标小中间(400x240) |
| **顶层（1920x720）（Top Shelf (1920x720)）** | 顶层(1920x720) |
| **顶层（6840x1440）（Top Shelf (6840x1440)）** | 顶层(6840x1440) |
| **顶层宽（2320x720）（Top Shelf Wide (2320x720)）** | 顶层宽(2320x720) |
| **2倍顶层宽（4640x1440）（2xTop Shelf Wide (4640x1440)）** | 2倍顶层宽(4640x1440) |

### 音频

| **设置** | **说明** |
| --- | --- |
| **音频混合器采样率（Audio Mixer Sample Rate）** | 要用于运行音频混合器的采样率。 |
| **回调缓冲区大小（Callback Buffer Size）** | 要在每个回调块中计算的音频数量。 使用较低值会减少延迟，但可能增加CPU成本。 |
| **要排队的缓冲区数量（Number of Buffers To Enqueue）** | 要保持排队的缓冲区数量。 缓冲区的数量越多，延迟越长，但可以补偿一些平台上的音频回调的可变计算可用性。 |
| **最大通道数量（Max Channels）** | 要为该平台限制的通道（语音）最大数量。 如果你在此处以及你的全局音频质量设置中指定最大通道数量，你的应用程序将使用两个值中的较小者。 如果设为0，虚幻引擎将使用所有可用通道。 |
| **源工作程序数量（Number of Source Workers）** | 要用于计算源音频的工作程序数量。 将仅使用不超过最大数量的源（ **最大通道数量（Max Channels）** 值）。 会将源均匀划分到每个源工作程序。 |
| **压缩覆盖（Compression Overrides）** | 请参阅下面的[压缩覆盖](#%E5%8E%8B%E7%BC%A9%E8%A6%86%E7%9B%96)表。 |
| **烘焙覆盖（Cook Overrides）** | 请参阅下面的[烘焙覆盖](#%E7%83%98%E7%84%99%E8%A6%86%E7%9B%96)表。 |
| **空间化插件（Spatialization Plugin）** | 定义要使用当前启用的哪个空间化插件。 如果在下拉菜单中找不到所需的空间化，请确保它在"插件（Plugins）"窗口（主菜单： **编辑（Edit）> 插件（Plugins）** ）中已启用。 你可以从以下选项中选择： **内置空间化（Built-In Spatialization）** **谐振音频（Resonance Audio）** **其他（Other）** |
| **混响插件（Reverb Plugin）** | 定义要使用当前启用的哪个混响插件。 如果在下拉菜单中找不到所需的混响插件，请确保它在"插件（Plugins）"窗口（主菜单： **编辑（Edit）> 插件（Plugins）** ）中已启用。 你可以从以下选项中选择： **内置混响（Built-In Reverb）** **谐振音频（Resonance Audio）** **其他（Other）** |
| **遮挡插件（Occlusion Plugin）** | 定义要使用当前启用的哪个遮挡插件。 如果在下拉菜单中找不到所需的遮挡插件，请确保它在"插件（Plugins）"窗口（主菜单： **编辑（Edit）> 插件（Plugins）** ）中已启用。 你可以从以下选项中选择： **内置遮挡（Built-In Occlusion）** **其他（Other）** |
| **Sound Cue烘焙质量（Sound Cue Cook Quality）** | 用于烘焙SoundCue的质量级别（设置后，烘焙器将剥离所有其他级别）。 |

#### 压缩覆盖

| **设置** | **说明** |
| --- | --- |
| **覆盖压缩时间（Override Compression Times）** | 启用后，将覆盖每个声波上的声音组，而改用时长阈值来确定声音是否应该在初始加载期间完全解压。 |
| **时长阈值（Duration Threshold）** | 启用 **覆盖压缩时间（Override Compression Times）** 后，低于此阈值（以秒为单位）的声音都将在加载时完全解压。 否则，此声音的第一个数据块会在加载时缓存，其余内容将实时解压。 如果设为0，将默认为相关声波上的声音组。 |
| **随机SoundCue节点上的最大分支数量（Maximum Branches on Random SoundCue Nodes）** | 在此平台上，Sound Cue上的所有随机节点将自动仅预先加载此数量的分支，并在加载时放弃所有其他分支。 这可大幅减少内存使用量。 如果设为0，不会剔除分支。 |
| **Sound Cue的质量索引（Quality Index for Sound Cues）** | 在该平台上，使用该索引处的指定质量来覆盖用于SoundCue的质量。 |

请返回[音频](#%E9%9F%B3%E9%A2%91)表。

#### 烘焙覆盖

| **设置** | **说明** |
| --- | --- |
| **为设备重新采样（Resample for Device）** | 在该平台上启用音频重新采样使用给定的重新采样质量采样率。 |
| **压缩质量修饰符（Compression Quality Modifier）** | 在烘焙到此平台时缩放所有压缩质量。 例如，使用0.5会将所有压缩质量减半，使用1.0会将其保持不变。 |
| **流送缓存（Stream Caching）** | 请参阅下面的[流送缓存](#%E6%B5%81%E9%80%81%E7%BC%93%E5%AD%98)表。 |
| **重新采样质量（Resampling Quality）** | 请参阅下面的[重新采样质量](#%E9%87%8D%E6%96%B0%E9%87%87%E6%A0%B7%E8%B4%A8%E9%87%8F)表。 |

请返回[音频](#%E9%9F%B3%E9%A2%91)表。

##### 流送缓存

| **设置** | **说明** |
| --- | --- |
| **最大缓存大小（Max Cache Size (KB)）** | 这将确定在任意给定时间应该用于缓存的最大内存数量。 如果设置很低（<= 8 MB），会降低烘焙期间音频的单独数据块的大小。 |
| **最大数据块大小覆盖（Max Chunk Size Override (KB)）** | 这将覆盖掉为流送缓存的音频分块时使用的默认最大数据块大小（< 0时忽略）。 |

请返回[烘焙覆盖](#%E7%83%98%E7%84%99%E8%A6%86%E7%9B%96)表。

##### 重新采样质量

| **设置** | **说明** |
| --- | --- |
| **最大采样率（Max Sample Rate）** | 重新采样质量最大采样率。 |
| **高采样率（High Sample Rate）** | 重新采样质量高采样率。 |
| **中采样率（Medium Sample Rate）** | 重新采样质量中采样率。 |
| **低采样率（Low Sample Rate）** | 重新采样质量低采样率。 |
| **最低采样率（Min Sample Rate）** | 重新采样质量最低采样率。 |

请返回[烘焙覆盖](#%E7%83%98%E7%84%99%E8%A6%86%E7%9B%96)表。

### 杂项

| **设置** | **说明** |
| --- | --- |
| **流送地形视觉网格体LOD（Stream Landscape Visual Mesh LODs）** | 定义是否为地形视觉网格体启用LOD流送。 |

