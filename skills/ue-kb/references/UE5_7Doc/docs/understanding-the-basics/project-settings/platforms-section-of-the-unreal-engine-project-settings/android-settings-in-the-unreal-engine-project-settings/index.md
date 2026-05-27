---
title: "Android设置"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/android-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "平台", "Android设置"]
---

# Android设置

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 平台 / Android设置

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/android-settings-in-the-unreal-engine-project-settings

## Android

### APK打包

| **设置** | **说明** |
| --- | --- |
| **Android包名（"com.Company.Project"，[PROJECT]替换为项目名称）（Android Package Name ('com.Company.Project', [PROJECT] is replaced with project name)）** | 产品的官方名称（与Play Store网站上使用的名称相同）。 名称必须包含至少2个分段，以句点分隔，并且必须唯一。 |
| **商城版本（Store Version (1-2147483647)）** | 用于表明商城中的更新版本的版本号。 |
| **商城版本偏移（Store Version Offset (ARMv7)）** | 要添加到为ARMv7生成的APK的商城版本的偏移。 |
| **商城版本偏移（Store Version Offset (ARM64)）** | 要添加到为ARM64生成的APK的商城版本的偏移。 |
| **商城版本偏移（Store Version Offset (x86_64)）** | 要添加到为x86_64生成的APK的商城版本的偏移。 |
| **应用程序显示名称（app_name），为空白则采用项目名称（Application Display Name (app_name), Project Name If Blank）** | 为最终用户显示的应用程序名称（ `app_name` ）。 如果该字段留空，引擎将使用项目名称。 |
| **版本显示名称（通常为x.y）（Version Display Name (usually x.y)）** | 为最终用户显示的版本。 |
| **最低SDK版本（Minimum SDK Version (19=KitKat, 21=Lollipop)）** | 设置允许应用安装在什么Android版本上（不要设为低于19）。 |
| **目标SDK版本（Target SDK Version (19=KitKat, 21=Lollipop)）** | 设置应用预期在什么操作系统版本上运行（不要设为低于19）。 |
| **安装位置（Install Location）** | 应用程序的偏好安装位置。 你可以从以下选项中选择： **仅限内部（Internal Only）** ：仅在内部设备存储上安装你的应用。 **偏好外部（Prefer External）** ：可用时在外部存储上安装你的应用。 **自动（Auto）** ：内部存储优先于外部，除非内部存储的空间不足。 |
| **启用Lint弃用检查（Enable Lint Depreciation Checks）** | 为Java编译（仅限Gradle）启用 `-Xlint:unchecked` 和 `-Clint:depreciation` 。 |
| **在.apk中打包游戏数据（Package Game Data Inside .apk）** | 定义是否应该将数据放入 `.apk` 文件而不是单独的 `.obb` 文件。 Amazon需要启用此设置，但Google Play Store不允许大于100 MB的 `.apk` 文件，因此在启用此设置之后，只有小游戏才能运行。 |
| **为所有平台生成安装文件（Generate Install Files for All Platforms）** | 启用后，批处理（ `.bat` ）文件和shell脚本（ `.command` ）文件都将生成，否则仅为当前系统执行（默认值）。 |
| **首次启动或更新时禁用.obb验证（Disable .obb Verification on First Start or Update）** | 在发行版本中下载或首次启动 `.obb` 文件时，禁用其验证。 |
| **强制小.obb文件（Force Small .obb Files）** | 启用后， `.obb` 文件大小限制为1 GB。 |
| **允许大.obb文件（Allow Large .obb Files）** | 启用后， `.obb` 文件大小不限制为Google Play Store所允许的2 GB，但仍限制为4 GB `.zip` 上限。 |
| **允许补丁.obb文件（Allow Patch .obb File）** | 启用后，将为主 `.obb` 中容纳不下的文件生成补丁 `.obb` 。这需要使用多个 `.pak` 文件，因此请按数据块ID分割内容。 |
| **允许溢出.obb文件（Allow Overflow .obb Files）** | 启用后，将为补丁 `.obb` 中容纳不下的文件生成两个额外的溢出 `.obb` 文件。这需要使用多个 `.pak` 文件，因此你应该按数据块ID分割内容。 |
| **将ExternalFilesDir用于虚幻游戏文件（Use ExternalFilesDir for UnrealGame Files）** | 启用后，虚幻游戏文件将放入 `ExternalFilesDir` 中，卸载时会删除该目录。 如果你需要保存游戏进度而不请求Android API 23+中的运行时 `WRITE_EXTERNAL_STORAGE` 权限，你也应该启用此设置。 |
| **将日志文件设为总是可公开访问（Make Log Files Always Publicly Accessible）** | 启用后，日志文件将总是放在公开可用的目录（ `/sdcard/Android` 或 `/sdcard/UnrealGame` ）中。 如果你在Android API 23+中不使用 `ExternalFilesDir` 复选框，你可能需要 `WRITE_EXTERNAL_STORAGE` 权限。 |
| **方向（Orientation）** | 设备上应用程序的允许方向。 你可以从以下选项中选择： **纵向（Portrait）** ：纵向方向（显示屏高度大于宽度）。 **逆纵向（Reverse Portrait）** ：纵向方向旋转180度。 **传感器纵向（Sensor Portrait）** ：基于设备方向传感器，根据设备的支持情况使用纵向或逆纵向方向。 **横向（Landscape）** ：横向方向（显示屏宽度大于高度）。 **逆横向（Reverse Landscape）** ：横向方向旋转180度。 **传感器横向（Sensor Landscape）** ：基于设备方向传感器，使用横向或逆横向方向。 **传感器（Sensor）** ：基于设备方向传感器，使用设备通常支持的任意方向。 **完全传感器（Full Sensor）** ：基于设备方向传感器，使用任意方向（包括设备在传感器模式下不会选择的方向）。 |
| **支持的长宽比上限（Maximum Supported Aspect Ratio）** | 支持的长宽比上限（宽度/高度）。 Android会为长宽比更大的设备上的应用程序自动加上黑边。 |
| **使用显示屏切口区域（Use Display Cutout Region）** | 在Android 9+上启用显示屏切口区域。 |
| **重新启动时恢复安排的通知（Restore Scheduled Notifications on Reboot）** | 定义在重新启动时是否应该恢复安排的本地通知。 这将添加启动完成的接收器和对清单的权限。 |
| **在KitKat及更高版本设备上启用沉浸式全屏（Enable Full Screen Immersive on KitKat and Above Devices）** | 定义软件导航按钮是否应该隐藏。 |
| **启用改进的虚拟键盘（Enable Improved Virtual Keyboard）** | 启用后，你可以直接编辑文本字段。 禁用后，若点击应用内文本字段，将打开额外的文本字段供编辑之用。 |
| **偏好的深度缓冲区格式（Preferred Depth Buffer Format）** | Android的偏好深度缓冲区位数。 你可以从以下选项中选择： **默认值（Default）** **16位（16-bit）** **24位（24-bit）** **32位（32-bit）** |
| **验证纹理格式（Validate Texture Formats）** | 验证设备是否在运行时支持至少一个烘焙的纹理格式。 |
| **强制Gradle压缩原生库，无论MinSDKVersion设置如何（Force Gradle to Compress Native Libs Regardless of MinSDKVersion Setting）** | 为MinSDKVersion >= 23构建时，Gradle将使原生库在 `.apk` 中保留未压缩状态。 对于不打算通过Google Play发布的版本，此选项可能很有用。 |
| **启用重定位表压缩（取决于MinSDKVersion设置）（Enable Compression of Relocation Tables (Depends on MinSDKVersion Setting)）** | 针对MinSDKVersion >= 28构建时使用RELR和APS2重定位表生成Android二进制文件，或在为MinSDKVersion >= 23构建时仅使用APS2生成。 |
| **平台设置文件的状态（Status of Platform Setup File）** | 这将显示是否针对Android平台配置了项目。 对于使用4.6或更早版本的用户：现在引擎会在构建时生成 `AndroidManifest.xml` 文件，因此如果你自定义了 `.xml` 文件，你将需要将所有更改放入下面的设置中。请注意，引擎不会对你的项目目录中的 `AndroidManifest.xml` 做出更改。 引擎生成的 `.xml` 文件会放入 `(YourProjectName)\\Intermediate\\Android\\APK` 文件夹中。 此外，引擎不再使用 `SigningConfig.xml` ，现在设置在 **发行版签名（Distribution Signing）** 分段中设置。 你必须接受SDK许可协议才能使用Gradle。如果按钮未禁用，你可以从"项目设置（Project Settings）> Android"窗口操作。 |
| **接受SDK许可证（Accept SDK License）** | 必须接受SDK许可协议，才能使用Gradle。 |
| **构建文件夹（Build Folder）** | 资源管理器或访达中包含构建文件的文件夹。我们建议将这些文件检入源码控制中，与你的团队共享。 |

### 应用程序包

| **设置** | **说明** |
| --- | --- |
| **生成程序包（AAB）（Generate Bundle (AAB)）** | 启用生成AAB程序包。 |
| **从程序包生成通用.apk（Generate Universal .apk from Bundle）** | 从程序包启用生成通用 `.apk` 。 |
| **启用ABI分割（Enable ABI Split）** | 在程序包中将ABI分离到各自`.apk` 文件中。 |
| **启用语言分割（Enable Language Split）** | 在程序包中按语言将资源分离到各自的`.apk` 中。 |
| **启用密度分割（Enable Density Split）** | 在程序包中按密度将资源分离到各自的`.apk` 程序包中。 |

### 构建

| **设置** | **说明** |
| --- | --- |
| **支持OpenGL ES3.2（Support OpenGL ES3.2）** | 包含支持OpenGL ES 3.2及更高版本的设备的着色器（默认值）。 |
| **支持Vulkan（Support Vulkan）** | 支持Vulkan RHI并包含Vulkan着色器。 |
| **支持Vulkan桌面/SM5（试验性）（Support Vulkan Desktop / SM5 (Experimental)）** | 启用Vulkan SM5渲染支持。 |
| **调试Vulkan层目录（Debug Vulkan Layer Directory）** | 调试Vulkan层打包的目录。 |
| **调试Vulkan设备层（Debug Vulkan Device Layers）** | 要启用的调试Vulkan设备层。 |
| **调试Vulkan实例层（Debug Vulkan Instance Layers）** | 要启用的调试Vulkan实例层。 |
| **在OpenGL上支持后台缓冲区取样（Support Backbuffer Sampling on OpenGL）** | 是否渲染到屏幕外的表面而不是直接在Android OpenGL平台上渲染到后台缓冲区。 如果你想在Android OpenGL上支持UMG背景模糊，请启用该选项。 |
| **支持ARM64（也称为arm64-v8a）（Support ARM64 (also known as arm64-v8a)）** | 定义是否支持ARM64 CPU架构。 使用至少NDK r11c。这至少需要Lollipop (Android-21)。 |
| **支持x86_64（也称为x64）（Support x86_64 (also known as x64)）** | 这需要GitHub源。 |
| **高级（Advanced）** |  |
| **检测Vulkan设备支持（Detect Vulkan Device Support）** | 定义在项目使用Vulkan支持打包时，是否默认检测Vulkan设备支持。 禁用后， `-detectvulkan` 命令行将启用Vulkan检测。 |

### 高级APK打包

| **设置** | **说明** |
| --- | --- |
| **节点的额外标签（Extra Tags for Node）** | 节点的额外标签。 |
| **节点的额外标签（Extra Tags for Node）** | 节点的额外标签。 |
| **分段的额外设置（添加换行符(\\n)以分隔各行）（Extra Settings for Section (add newline character (\\n) to separate lines)）** | 分段的额外设置（还将包含可选文件 `<Project>/Build/Android/ManifestApplicationAdditions.txt` ）。 添加换行符（ `\\n` ）以分隔各行。 |
| **com.epicgames.unreal.GameActivity 节点的额外标签（Extra Tags for com.epicgames.unreal.GameActivity node）** | com.epicgames.unreal.GameActivity 节点的额外标签。 |
| **分段的额外设置（添加换行符(\\n)以分隔各行）（Extra Settings for Section (add newline character (\\n) to separate lines)）** | 主分段的额外设置（还将包含可选文件 `<Project>/Build/Android/ManifestApplicationActivityAdditions.txt` ）。 添加换行符（ `\\n` ）以分隔各行。 |
| **额外权限（Extra Permissions）** | 你的应用需要的额外权限（"android.permission.INTERNET"）。 此外还将包含可选文件 `<Project>/Build/Android/ManifestRequirementsAdditions.txt` ，或者可选文件 `<Project>/Build/Android/ManifestRequirementsOverride.txt` 将替换整个 **要求（Requirements）** 分段。 |
| **添加权限以支持语音聊天（Add Permissions to Support Voice Chat）** | 添加必需权限以支持语音聊天（ `RECORD_AUDIO` ） |
| **为Oculus移动设备打包（Package for Oculus Mobile Device）** | 为Oculus移动设备打包。 |
| **从发行版.apk删除Oculus签名文件（Remove Oculus Signature Files from Distribution .apk）** | 如果 Quest/Go `.apk` 已签名进行发行，则从 `.apk` 文件删除Oculus签名文件（ `.osig` ），并启用授权检查器。 |

### 高级版本

| **设置** | **说明** |
| --- | --- |
| **在发售配置中使用隐藏符号可视性构建（试验性）（Build with Hidden Symbol Visibility in Shipping Config (Experimental)）** | 默认使用隐藏可视性构建发售配置。 这将产生更小的 `.so` 文件，但还会删除用于显示调用堆栈转储的符号。 |
| **总是使用符号保存libUnreal.so的副本（试验性）（Always Save a Copy of the libUnreal.so With Symbols (Experimental)）** | 总是使用符号保存 `.so` 文件，允许在原始调用堆栈地址上使用 `addr2line` 。 |
| **强制链接使用LD而不是LLD（强制LDLinker）（Force Linking to Use LD instead of LLD (Force LDLinker)）** | 使用旧版LD而不是新的LLD链接器。 |

### 项目SDK覆盖

> [!NOTE]
> 将这些字段留空以使用全局Android SDK项目设置。更改这些设置只会影响该项目。

| **设置** | **说明** |
| --- | --- |
| **构建工具版本（Build-Tools Version）** | 要用于打包的构建工具（具体版本，或 `latest` 以表示磁盘上的最新版本）。 |
| **SDK API级别（SDK API Level）** | 使用哪个SDK来打包和编译Java（具体版本，或 `latest` 以表示磁盘上的最新版本，或 `matchndk` 以匹配NDK API级别）。 |
| **NDK API级别（NDK API Level）** | 使用哪个NDK来编译（具体版本，或 `latest` 以表示磁盘上的最新版本）。 如果你选择android-21或更高版本，你的游戏无法在5.0之前版本的设备上运行。 |

### 发行版签名

| **设置** | **说明** |
| --- | --- |
| **密钥库（Key Store）** | 这是keytool输出的文件，使用 `-keystore` 参数指定（文件应该在 `<Project>/Build/Android` 中）。 |
| **密钥别名（Key Alias）** | 这是你使用 `-alias` 参数向keytool指定的密钥名称。 |
| **密钥库密码（Key Store Password）** | 这是你在运行时为密钥库指定的密码（使用 `-storepass` 或直接输入）。 这是密钥库密码，不要与密钥密码混淆。 |
| **密钥密码（Key Password）** | 这是你可能已使用keytool指定的密钥密码（如果不同于密钥库密码）。 留空以使用与密钥库相同的密码。 |
| **用于为发行版签名的Android开发人员页面（Android Developer Page on Signing for Distribution）** | 将打开一个页面，其中介绍了如何使用keytool签名。 |

### Google Play服务

| **设置** | **说明** |
| --- | --- |
| **连接时请求访问令牌（Request Access Token On Connect）** | 启用该设置会将 `GET_ACCOUNTS` 添加到应用清单，并需要用户权限。 这是重置成就所必需的。 |
| **成就贴图（Achievement Map）** | 将游戏成就名称映射到Google Play生成的ID。 |
| **排行榜贴图（Leaderboard Map）** | 将游戏排行榜名称映射到Google Play生成的ID。 |
| **在Google Play登录时启用快照（试验性）（Enable Snapshots on Google Play Login (Experimental)）** | 在Google Play登录期间为保存的游戏启用此请求的快照支持。 |
| **Google云消息传递发送者ID（Google Cloud Messaging Sender ID）** | 发送者ID，从Firebase控制台获取。将其与Google Play开发人员控制台中的应用关联。 将该字段留空可禁用。 |
| **平台设置文件的状态（Status of Platform Setup File）** | 此分段显示是否针对Google Play服务平台恰当配置了项目。 |
| **Google Play服务上的Android开发人员页面（Android Developer Page on Google Play Services）** | 打开讨论Google Play服务的页面。 |
| **启用Google Play支持（Enable Google Play Support）** | 定义是否应该启用Google Play支持。 |
| **游戏应用ID（Games App ID）** | 从Google Play开发人员控制台获取的应用ID。 |
| **包含对广告的AdMob支持（Include AdMob Support for Ads）** | 启用该设置会包括AdMob SDK，并将在上传APK时由Google Play控制台检测到。 如果你不需要广告，请禁用，以去除警告。 |
| **Ad Mob广告单元ID（Ad Mob Ad Unit IDs）** | 从AdMob获取的广告的标识符。 |
| **Google Play许可证密钥（Google Play License Key）** | 此应用程序的唯一标识符（应用内购买所需）。 |

### 图标

| **设置** | **说明** |
| --- | --- |
| **图标上的Android开发人员页面（Android Developer Page on Iconography）** | 在Android图标上打开页面。 |
| **图标（Icon）** | 默认应用图标。 |
| **LDPI图标（LDPI Icon）** | 低密度屏幕的应用图标。 |
| **MDPI图标（MDPI Icon）** | 中密度屏幕的应用图标。 |
| **HDPI图标（HDPI Icon）** | 高密度屏幕的应用图标。 |
| **XHDPI图标（XHDPI Icon）** | 特高密度屏幕的应用图标。 |

### 启动图像

启动图像将缩放以适合活动方向的设备。可以提供额外的可选启动图像作为LDPI、MDPI、HDPI和XHDPI的覆盖，方法是将其放入项目的对应 `Build/Android/res/drawable-*` 目录中。

| **设置** | **说明** |
| --- | --- |
| **显示启动图像（Show Launch Image）** | 将启动图像显示为启动画面。 |
| **下载背景垂直图像（Download Background Vertical Image）** | 下载背景图像用作下载OBB文件时的背景。 |
| **下载背景水平图像（Download Background Horizontal Image）** | 下载背景图像用作下载OBB文件时的背景。 |
| **启动纵向（Launch Portrait）** | 启动纵向图像用作带有纵向、逆纵向、传感器纵向、传感器或完全传感器方向的应用程序的启动画面。 |
| **启动横向（Launch Landscape）** | 启动横向图像用作带有横向、传感器横向、逆横向、传感器或完全传感器方向的应用程序的启动画面。 |

### 图形调试器

| **设置** | **说明** |
| --- | --- |
| **启用Mali Perf计数器（Enable Mali Perf Counters）** | 启用后，在通过生成的批处理文件启动或安装你的应用时，这将禁用Android设备上的 `security.perf_harden` 标记。 需要禁用 `security.perf_harden` ，HWCPipe才能在Mali设备上报告性能计数器。 |
| **Android图形调试器（Android Graphics Debugger）** | 多个Android图形调试器需要对你的应用程序进行配置更改才能正常运行。 从该菜单选择选项将配置你的项目，以用于该图形调试器。 你可以从以下选项中选择： **无（None）** **Mali图形调试器（Mali Graphics Debugger）** **Adreno分析器（Adreno Profiler）** |

### 输入

| **设置** | **说明** |
| --- | --- |
| **允许IMU取样（Allow IMU Sampling）** | 允许加速度计、磁力计和陀螺仪事件处理。 禁用该设置可以提高性能。 |
| **允许蓝牙控制器（Allow Bluetooth Controllers）** | 启用后，连接蓝牙的控制器将发送输入。 |
| **阻止从控制器发送Android系统密钥（Block Android System Keys Being Sent from Controllers）** | 启用后，控制器不会发送 `Android_Back` 和 `Android_Menu` 事件，因为这些事件可能导致不必要或不需要的操作。 |
| **在附加控制器时阻止在设备上强制反馈（Block Force Feedback on the Device When Controllers Are Attached）** | 在附加控制器时阻止在设备上强制反馈。 |

### 音频

| **设置** | **说明** |
| --- | --- |
| **编码格式（Encoding Format）** | Android音频编码选项。 你可以从以下选项中选择： **默认值（Default）** ：选择默认编码器。 **Ogg Vorbis** ：选择OGG Vorbis编码。 **ADCPM** ：选择ADCPM无损编码。 |
| **音频混合器采样率（Audio Mixer Sample Rate）** | 要用于运行音频混合器的采样率。 |
| **回调缓冲区大小（Callback Buffer Size）** | 要在每个回调块中计算的音频数量。 使用较低值会减少延迟，但可能增加CPU成本。 |
| **要排队的缓冲区数量（Number of Buffers To Enqueue）** | 要保持排队的缓冲区数量。 缓冲区越多，延迟越长，但可以补偿一些平台上音频回调的可变计算可用性。 |
| **最大通道数量（Max Channels）** | 要为该平台限制的通道（语音）最大数量。 如果你在此处以及你的全局音频质量设置中指定最大通道数量，你的应用程序将使用两个值中的较小者。 如果设为0，虚幻引擎将使用所有可用通道。 |
| **源工作程序数量（Number of Source Workers）** | 要用于计算源音频的工作程序数量。 这仅使用不超过最大数量的源（最大通道数量值），并将源均匀地划分到每个源工作程序。 |
| **压缩覆盖（Compression Overrides）** | 请参阅下面的[压缩覆盖](#%E5%8E%8B%E7%BC%A9%E8%A6%86%E7%9B%96)表。 |
| **烘焙覆盖（Cook Overrides）** | 请参阅下面的[烘焙覆盖](#%E7%83%98%E7%84%99%E8%A6%86%E7%9B%96)表。 |
| **空间化插件（Spatialization Plugin）** | 定义要使用当前启用的哪个空间化插件。 如果你在下拉菜单中找不到要使用的空间化插件，确保其插件已启用（从主菜单，转至 **编辑（Edit）> 插件（Plugins）** ）。 你可以从以下选项中选择： **内置空间化（Built-In Spatialization）** **谐振音频（Resonance Audio）** **其他（Other）** |
| **混响插件（Reverb Plugin）** | 定义要使用当前启用的哪个混响插件。 如果你在下拉菜单中找不到要使用的混响插件，确保其插件已启用（从主菜单，转至 **编辑（Edit）> 插件（Plugins）** ）。 你可以从以下选项中选择： **内置混响（Built-In Reverb）** **谐振音频（Resonance Audio）** **其他（Other）** |
| **遮挡插件（Occlusion Plugin）** | 定义要使用当前启用的哪个遮挡插件。 如果你在下拉菜单中找不到要使用的遮挡插件，确保其插件已启用（从主菜单，转至 **编辑（Edit）> 插件（Plugins）** ）。 你可以从以下选项中选择： **内置遮挡（Built-In Occlusion）** **其他（Other）** |
| **Sound Cue烘焙质量（Sound Cue Cook Quality）** | 用于烘焙SoundCue的质量级别（设置后，烘焙器将剥离所有其他级别）。 |

#### 压缩覆盖

| **设置** | **说明** |
| --- | --- |
| **覆盖压缩时间（Override Compression Times）** | 启用后，将覆盖每个声波上的声音组，而改用时长阈值来确定声音是否应该在初始加载期间完全解压。 |
| **时长阈值（Duration Threshold）** | 启用 **覆盖压缩时间（Override Compression Times）** 后，低于此阈值（以秒为单位）的声音都将在加载时完全解压。 否则，此声音的第一个数据块会在加载时缓存，其余内容将实时解压。 如果设为0，将默认为相关声波上的声音组。 |
| **随机SoundCue节点上的最大分支数量（Maximum Branches on Random SoundCue Nodes）** | 在此平台上，Sound Cue上的所有随机节点将自动仅预先加载此数量的分支，并在加载时放弃所有其他分支。 这可大幅减少内存使用量。 如果设为0，不会剔除分支。 |
| **Sound Cue的质量索引（Quality Index for Sound Cues）** | 在该平台上，使用该索引处的指定质量来覆盖用于该平台上的SoundCue的质量。 |

请返回[音频](#%E9%9F%B3%E9%A2%91)表。

#### 烘焙覆盖

| **设置** | **说明** |
| --- | --- |
| **为设备重新采样（Resample for Device）** | 在该平台上启用音频重新采样，使用给定的重新采样质量采样率。 |
| **压缩质量修饰符（Compression Quality Modifier）** | 在烘焙到此平台时缩放所有压缩质量。 例如，使用0.5会将所有压缩质量减半，使用1.0会将其保持不变。 |
| **流送缓存（Stream Caching）** | 请参阅下面的[流送缓存](#%E6%B5%81%E9%80%81%E7%BC%93%E5%AD%98)表。 |
| **重新采样质量（Resampling Quality）** | 请参阅下面的[重新采样质量](#%E9%87%8D%E6%96%B0%E9%87%87%E6%A0%B7%E8%B4%A8%E9%87%8F)表。 |

请返回[音频](#%E9%9F%B3%E9%A2%91)表。

##### 流送缓存

| **设置** | **说明** |
| --- | --- |
| **最大缓存大小（Max Cache Size (KB)）** | 确定在任意给定时间应该用于缓存的最大内存数量。 如果设置很低（<= 8 MB），会降低烘焙期间音频的单独数据块的大小。 |
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

### 多纹理格式

| **设置** | **说明** |
| --- | --- |
| **包含ETC2纹理（Include ETC2 Textures）** | 在使用Android（多）变体打包时包含ETC2纹理。 |
| **包含DXT纹理（Include DXT Textures）** | 在使用Android（多）变体打包时包含DXT纹理。 |
| **包含ASTC纹理（Include ASTC Textures）** | 在使用Android（多）变体打包时包含ASTC纹理。 |

### 纹理格式优先级

| **设置** | **说明** |
| --- | --- |
| **ETC2纹理格式优先级（ETC2 Texture Format Priority）** | 在设备上启动或使用Android_Multi打包时，ETC2纹理格式的优先级。 将使用设备支持的最高优先级格式。 默认值为0.2。 |
| **DXT纹理格式优先级（DXT Texture Format Priority）** | 在设备上启动或使用Android_Multi打包时，DXT纹理格式的优先级。 将使用设备支持的最高优先级格式。 默认值为0.6。 |
| **ASTC纹理格式优先级（ASTC Texture Format Priority）** | 在设备上启动或使用Android_Multi打包时，ASTC纹理格式的优先级。 将使用设备支持的最高优先级格式。 默认值为0.9。 |

### 杂项

| **设置** | **说明** |
| --- | --- |
| **流送地形视觉网格体LOD（Stream landscape visual mesh LODs）** | 定义是否为地形视觉网格体启用LOD流送。 仅在功能级别ES3.1或更高级别上受到支持。 |
| **为Web视图启用DOM存储（Enable DOM storage for WebViews）** | 允许Web视图使用DOM存储API。 |
