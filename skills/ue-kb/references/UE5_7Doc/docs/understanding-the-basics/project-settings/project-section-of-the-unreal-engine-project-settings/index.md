---
title: "项目"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/project-section-of-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "项目"]
---

# 项目

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 项目

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/project-section-of-the-unreal-engine-project-settings

## 说明

你可以在此处设置有关项目的信息，如项目名称、版本、公司名称、版权等。这些设置主要用于提供信息，不会影响项目的运行或表现。

### 关于

| **分段** | **说明** |
| --- | --- |
| **说明（Description）** | 项目说明文本。 |
| **项目ID（Project ID）** | 项目的唯一标识符。 |
| **项目名称（Project Name）** | 项目的非本地化名称。 |
| **项目版本（Project Version）** | 项目的版本号。 |
| **项目缩略图（Project Thumbnail）** | 项目的预览缩略图。 |

### 发布者

| **分段** | **说明** |
| --- | --- |
| **公司名称（Company Name）** | 创建该项目的公司（作者、提供商）的名称。 |
| **公司专有名称（Company Distinguished Name）** | 创建该项目的公司（作者、提供商）的专有名称，一些平台上的发布工具会用到。 |
| **主页（Homepage）** | 项目的主页URL。 |
| **支持联系人（Support Contact）** | 项目的支持联系人信息。 |

### 法律信息

| **分段** | **说明** |
| --- | --- |
| **版权声明（Copyright Notice）** | 项目的版权和/或商标声明。 |
| **许可条款（Licensing Terms）** | 项目的许可条款。 |
| **隐私政策（Privacy Policy）** | 项目的隐私政策。 |

### 显示信息

| **分段** | **说明** |
| --- | --- |
| **项目显示的标题（Project Displayed Title）** | 窗口标题栏上显示的项目标题。可能包含令牌 `{GameName}` 、 `{PlatformArchitecture}` 、 `{BuildConfiguration}` 或 `{RHIName}` ，这些将替换为指定的文本。 |
| **项目调试标题信息（Project Debug Title Info）** | 非发布（调试）配置中窗口标题栏上要显示的其他数据。可能包含令牌 `{GameName}` 、 `{PlatformArchitecture}` 、 `{BuildConfiguration}` 或 `{RHIName}` ，这些将替换为指定的文本。 |

### 设置

| **分段** | **说明** |
| --- | --- |
| **窗口是否应保留长宽比（Should Window Preserve Aspect Ratio）** | 指定在用户调整游戏窗口的大小后是否应保留长宽比。 |
| **使用无边框窗口（Use Borderless Window）** | 指定游戏是否应使用无边框Slate窗口来取代包含系统标题栏和边框的窗口。 |
| **在VR中启动（Start in VR）** | 指定游戏是否应尝试在VR中启动，无论命令行中是否设置了 `-vr` 。 |
| **允许调整窗口大小（Allow Window Resize）** | 指定不采用全屏模式时，是否应允许用户调整游戏窗口的大小。 |
| **允许关闭（Allow Close）** | 指定不采用全屏模式时，是否应为游戏窗口显示 **关闭** 按钮。 |
| **允许最大化（Allow Maximize）** | 指定在不采用全屏模式时，是否应该为游戏窗口显示 **最大化** 按钮。 |
| **允许最小化（Allow Minimize）** | 指定在不采用全屏模式时，是否应该为游戏窗口显示 **最小化** 按钮。 |

## 加密

### 加密

| **分段** | **说明** |
| --- | --- |
| **加密密钥（Encryption Key）** | 用于保护 `.pak` 文件的默认加密密钥。 |
| **辅助加密密钥（Secondary Encryption Keys）** | 可以选择用于不同资产的辅助加密密钥。 游戏需要在运行时将这些密钥提供给 `.pak` 平台文件，以便访问密钥保护的数据。 |
| **加密Pak Ini文件（Encrypt Pak Ini Files）** | 加密 `.pak` 中的所有 `.ini` 文件。 保护可挖掘信息的最常见来源，同时尽可能降低运行时IO开销。 |
| **加密Pak索引（Encrypt Pak Index）** | 加密 `.pak` 索引，使得在没有加密密钥的情况下无法使用UnrealPak操纵 `.pak` 文件。 |
| **加密UAsset文件（Encrypt UAsset Files）** | 加密 `.uasset` 文件。 |
| **加密所有资产文件（Encrypt All Asset Files）** | 加密 `.pak` 文件中的所有文件。 很安全，但运行时IO性能会有所降低，打包数据的熵也很高，这不利于打补丁。 |
| **生成新加密密钥（Generate New Encryption Key）** | 生成新的加密密钥。 |

### 签名

| **分段** | **说明** |
| --- | --- |
| **签名公共指数（Signing Public Exponent）** | 用于对 `.pak` 文件签名的RSA密钥公共指数。 |
| **签名模数（Signing Modulus）** | 用于对 `.pak` 文件签名的RSA密钥模数。 |
| **签名私有指数（Signing Private Exponent）** | 用于对 `.pak` 文件签名的RSA密钥私有指数。 |
| **启用Pak签名（Enable Pak Signing）** | 启用 `.pak` 文件的签名以防止篡改数据。 |
| **生成新签名密钥（Generate New Signing Keys）** | 生成新的签名密钥。 |

## Gameplay标签

### Gameplay标签

| **分段** | **说明** |
| --- | --- |
| **从配置导入标签（Import Tags from Config）** | 如果为true，将从 `Config/Tags` 文件夹中的 `.ini` 文件导入标签。 |
| **标签无效时警告（Warn on Invalid Tags）** | 如果为true，在字典之外的已保存标签引用中读取时将提供加载警告。 |
| **清除无效标签（Clear Invalid Tags）** | 如果为true，在字典之外的已保存标签引用中读取时将清除所有无效标签。 |
| **无效标签字符（Invalid Tag Characters）** | 这些字符连同 `newline` 等特殊字符都不能在Gameplay标签中使用。 |
| **类别重新映射（Category Remapping）** | 这允许基础引擎标签类别元数据重新映射到特定于项目的多个类别。 |
| **Gameplay标签表列表（Gameplay Tag Table List）** | 要从中加载标签的数据表的列表。 |
| **Gameplay标签重定向（Gameplay Tag Redirects）** | 活动标签重定向的列表。 |
| **Gameplay标签列表（Gameplay Tag List）** | 活动标签重定向的列表。 |

### 高级复制

| **分段** | **说明** |
| --- | --- |
| **快速复制（Fast Replication）** | 如果为true，将按索引而不是名称来复制Gameplay标签。 要做到这一点，标签在客户端和服务器上必须完全相同。 |
| **通常复制的标签（Commonly Replicated Tags）** | 最常复制的标签的列表。 |
| **容器大小的比特数（Num Bits for Container Size）** | 要用于复制容器大小的比特数。根据你的容器一般大小来设置该数字。 |
| **净索引首个比特片段（Net Index First Bit Segment）** | 对标签净序列化时首个片段的长度，以比特为单位。 我们会序列化NetIndexFirstBitSegment + 1个比特来表示"更多"，这样复制起来会更慢。 |

### 高级Gameplay标签

| **分段** | **说明** |
| --- | --- |
| **受限制配置文件（Restricted Config Files）** | 用于存储受限制Gameplay标签的 `.ini` 文件的列表。 |
| **受限制标签列表（Restricted Tag List）** | 受限制标签旨在用作对于你的数据层级很重要的顶层标签，修改这些标签的人非常少。 |

## 映射和模式

### 默认模式

| **分段** | **说明** |
| --- | --- |
| **默认GameMode（Default GameMode）** | 未以其他任何方式（例如，逐映射 `DefaultGameMode` ，或在URL上）指定时要使用的 `GameMode` 。 你可以在项目中选择任意 `GameMode` 类。 |
| **默认Pawn类（Default Pawn Class）** | 玩家使用的默认Pawn类。 你可以在项目中选择任意Pawn类。 |
| **HUD类（HUD Class）** | 此游戏使用的HUD类。 你可以在项目中选择任意HUD类。 |
| **玩家控制器类（Player Controller Class）** | 要为登录的玩家生成的 `PlayerController` 类。 你可以在项目中选择任意 `PlayerController` 类。 |
| **游戏状态类（Game State Class）** | 与此 `GameMode` 关联的 `GameState` 类。 你可以在项目中选择任意 `GameState` 类。 |
| **玩家状态类（Player State Class）** | 此类的 `PlayerState` 将与每个玩家关联，以将相关玩家信息复制到所有客户端。 |
| **旁观者类（Spectator Class）** | 旁观时由 `PlayerController` 用于玩家的Pawn类。 |
| **全局默认服务器游戏模式（Global Default Server Game Mode）** | 未以其他任何方式（例如，逐映射 `DefaultGameMode` ，或在URL上）指定时要使用的 `GameMode` 。 此设置仅在将引擎作为专用服务器运行时使用。 你可以在项目中选择任意 `GameMode` 类。 如果未设置，将使用 `GlobalDefaultGameMode` 值。 |
| **游戏模式地图前缀（Game Mode Map Prefixes）** | 覆盖在加载以特定前缀开头的地图时要使用的 `GameMode` 。 |
| **游戏模式类别名（Game Mode Class Aliases）** | 在URL中指定游戏时要加载的 `GameMode` 列表（例如， **DM** 可以是 **MyProject.MyGameModeMP_DM** 的别名）。 |

### 默认地图

| **分段** | **说明** |
| --- | --- |
| **编辑器启动地图（Editor Startup Map）** | 设置后，此地图将在编辑器启动时加载。 你可以在项目中选择任意可用地图。 |
| **编辑器模板地图覆盖（Editor Template Map Overrides）** | 新关卡对话框中应显示的地图模板。 这会完全覆盖默认编辑器选定的默认地图。 |
| **游戏默认地图（Game Default Map）** | 没有加载其他任何地图时将默认加载的地图。 你可以在项目中选择任意可用地图。 |
| **本地地图选项（Local Map Options）** | 将附加到所加载地图的默认选项。 |
| **过渡地图（Transition Map）** | 从一个地图过渡到另一个地图时加载的地图。 你可以在项目中选择任意可用地图。 |
| **服务器默认地图（Server Default Map）** | 没有加载其他任何地图时将默认加载的地图。 此设置仅在将引擎作为专用服务器运行时使用。 你可以在项目中选择任意可用地图。 |

### 本地多人游戏

| **分段** | **说明** |
| --- | --- |
| **使用分屏（Use Splitscreen）** | 指定在有多个本地玩家时是否应分屏。 |
| **两个玩家分屏布局（Two Player Splitscreen Layout）** | 应当分屏且有两个本地玩家时要使用的视口布局。 你可以从以下选项中选择： **水平（Horizontal）** **垂直（Vertical）** |
| **三个玩家分屏布局（Three Player Splitscreen Layout）** | 应当分屏且有三个本地玩家时要使用的视口布局。 你可以从以下选项中选择： **顶部优先（Favor Top）** **底部优先（Favor Bottom）** **水平（Horizontal）** **垂直（Vertical）** |
| **四个玩家分屏布局（Four Player Splitscreen Layout）** | 应当分屏且有四个本地玩家时要使用的视口布局。 你可以从以下选项中选择： **网格（Grid）** **水平（Horizontal）** **垂直（Vertical）** |
| **分配游戏手柄时跳过玩家1（Skip Assigning Gamepad to Player 1）** | 启用后，游戏手柄会开始分配给本地多人游戏中的第二个控制器ID。 在有多个窗口的PIE（在编辑器中运行）会话中，其效果相当于在编辑器偏好设置（Editor Preferences）中启用 **将第一个游戏手柄传送至第二个客户端（Route 1st Gamepad to 2nd Client）** 设置。 |

### 游戏实例

| **分段** | **说明** |
| --- | --- |
| **游戏实例类（Game Instance Class）** | 实例化临时 `GameInstance` 类时要使用的类。 你可以在项目中选择任意 `GameInstance` 类。 |

## 视频

### 视频

| **分段** | **说明** |
| --- | --- |
| **等待视频完成播放（Wait for Movies to Complete）** | 启用后，即使加载已结束，游戏也会等待开场视频完成播放。 |
| **视频可跳过（Movies Are Skippable）** | 启用后，用户在按下鼠标按键时可以跳过开场视频。 |
| **开场视频（Startup Movies）** | 启动时要播放的视频。 请注意，这些必须位于游戏的 `Game/Content/Movies` 目录中。 |

## 打包

### 打包

| **分段** | **说明** |
| --- | --- |
| **使用Pak文件（Use Pak File）** | 启用后，所有内容将放入到一个或多个 `.pak` 文件中，而不是放入许多单独的文件。此分段默认启用。 |
| **使用Io Store（Use Io Store）** | 启用后，会将 `.utoc` / `.ucas` 容器文件用于暂存/打包的数据包数据而不是 `.pak` 。 |
| **使用Zen Store（Use Zen Store）** | 启用后，会使用Zen存储服务器来存储和获取烘焙的数据，而不是使用本地文件系统。 |
| **创建二进制配置（Make Binary Config）** | 启用后，暂存操作将创建二进制配置文件，以便更快加载。 |
| **生成数据块（Generate Chunks）** | 启用后，将生成 `.pak` 文件数据块。 资产可以在编辑器中或通过委托分配给数据块（参见 `ShooterGameDelegates.cpp` ）。 可以用于流送安装（PS4 Playgo、XboxOne Streaming Install，等等）。 |
| **不生成数据块（Generate No Chunks）** | 启用后，无论在特定于平台的 `.ini` 文件中如何设置，所有平台都不会生成数据块。 |
| **仅限数据块硬引用（Chunk Hard References Only）** | 通常在数据块生成期间，数据块中数据包的所有依赖性都将拉取到该数据包的数据块中。 启用此项后，仅会拉入硬依赖性。软依赖性保留在原始数据块中。 |
| **构建HTTP数据块安装数据（Build HTTP Chunk Install Data）** | 启用后，将为HTTP数据块安装程序生成数据。 此数据可以在Web服务器上托管，以在运行时安装。 需要启用 **生成数据块（Generate Chunks）** 选项。 |
| **HTTP数据块安装数据目录（HTTP Chunk Install Data Directory）** | 启用 **构建HTTP数据块安装数据（Build HTTP Chunk Install Data）** 后，这将是数据会构建到的目录。 |
| **DDC要考虑的数据包压缩最小大小（Package Compression Min Size to Consider DDC）** | 指定在派生数据缓存(DDC)中存储压缩IoStore区块的最小（未压缩）大小。 |
| **HTTP数据块安装数据版本（HTTP Chunk Install Data Version）** | HTTP数据块安装数据的版本名称。 |
| **共享材质着色器代码（Share Material Shader Code）** | 默认情况下，着色器代码会以内联方式保存在材质资产中。启用此选项会仅将着色器代码存储为单独文件一次。 这会减小总体数据包大小，但可能增加加载时间。 |
| **确定性着色器代码顺序（Deterministic Shader Code Order）** | 禁用此选项后，着色器代码基本上会按随机顺序存储在库中，正好与烘焙器加载资产的顺序完全一样。 启用此项将按哈希对着色器排序，使着色器库在不同版本之间更为相似。这有助于打补丁，但可能对加载时间带来不利影响。 |
| **共享材质原生库（Shared Material Native Libraries）** | 默认情况下，着色器代码会保存到与平台无关的单独文件。启用此选项将仅在提供了平台专用库格式时才使用该格式。 这会减小总体数据包大小，但可能增加加载时间。 |
| **Ini密钥拒绝列表（Ini Key Denylist）** | 打包时要剥离的 `.ini` 文件密钥的列表。 |
| **Ini分段拒绝列表（Ini Section Denylist）** | 打包时要剥离的 `.ini` 文件分段的列表。 |
| **此项目的其他版本（Additional Builds for This Project）** | 将显示在平台（Platforms）菜单中的自定义版本列表，用于允许对你的项目有意义的自定义版本。将显示在关卡编辑器主工具栏中的"平台（Platforms）"菜单中的"数据包项目（Package Project）"附近。 |
| **强制每个文件一个数据块（Force One Chunk Per File）** | 如果为true，单独的文件仅允许位于单个数据块中，并且会将其指定给请求的最低数量。 如果为false，在烘焙器请求的情况下，文件可能会出现在多个数据块中。 |
| **最大数据块大小（Max Chunk Size）** | 如果大于0，这会设置每个数据块的最大大小。 大于此大小的数据块将拆分为多个 `.pak` 文件，例如 `pakchunk0_s1` 。 这可以在平台专用游戏 `.ini` 文件中设置。 |
| **创建压缩烘焙数据包（Create Compressed Cooked Packages）** | 创建压缩烘焙数据包（减小了部署大小）。 |
| **数据包压缩格式（Package Compression Format）** | 要用于 `.pak` 文件和IoStore压缩的格式的逗号分隔列表。 如果指定了多种格式，列表顺序即优先级顺序，出错或格式不可用（例如，格式的插件未启用）时退却到其他格式。 通常，`PackageCompressionFormat=Oodle` 或 `PackageCompressionFormat=None` 。 |
| **使用此压缩格式非硬件覆盖（Use This Compression Format Not Hardware Override）** | 启用后，将强制使用指定的 **数据包压缩格式（Package Compression Format）** 。 此选项会覆盖 `DataDrivenPlatformInfo.ini` 中 `HardwareCompressionFormat` 参数设置的特定于平台的值。 |
| **数据包压缩命令行选项（Package Compression Command Line Options）** | 一种通用设置，用于允许项目在 `.pak` 文件和IoStore压缩期间控制压缩设置。 例如：`PackageAdditionalCompressionOptions=-compressionblocksize=1MB -asynccompression`。 |
| **数据包压缩方法（Package Compression Method）** | 对于有多种方法的压缩器，选择一种方法。例如，对于Oodle，你可以使用以下方法之一： **Kraken** **Mermaid** **Selkie** **Leviathan** 你可以在[此处](../../../testing-and-optimizing-content/using-oodle/oodle-data/index.md#compressionmethods)阅读每种方法的说明。 |
| **用于调试和开发的编码器工作级别（Encoder Effort Level for Debug & Development）** | 对于有可变级别的压缩器，选择编码器级别，让数据包变得更小，但编码所需时间更长。 这不会影响解码速度。 要更快迭代，请使用较低的工作级别（例如 `1` ）。 |
| **用于测试和发布的编码器工作级别（Encoder Effort Level for Test & Shipping）** | 数据包压缩级别测试发布。 |
| **用于发行的编码器工作级别（Encoder Effort Level for Distribution）** | 数据包压缩级别发行。 |
| **压缩数据块时应节省的最小字节数，否则数据仍处于未压缩状态（Minimum Amount of Bytes Which Should Be Saved When Compressing a Block of Data, Otherwise Data Remains Uncompressed）** | 一种通用设置，用于确定在创建IoStore或 `.pak` 文件时是否值得将压缩用于数据块。 如果节省的字节数小于指定值，则数据块仍处于未压缩状态。 此设置的最佳值取决于目标平台的能力。例如，`PackageCompressionMinBytesSaved=1024` 。 请注意，一些压缩器（例如Oodle）会在内部自行检查是否值得压缩，仅将该值用于确定应压缩的数据块的最小大小。 |
| **执行压缩时应节省的数据块最小百分比，否则数据仍处于未压缩状态（Minimum Percentage of a Block of Data Which Should Be Saved When Performing Compression, Otherwise Data Remains Uncompressed）** | 一种通用设置，用于确定在创建IoStore或 `.pak` 文件时是否值得将压缩用于数据块。 如果压缩数据块的节省百分比小于指定值，则数据块仍处于未压缩状态。 此设置的最佳值取决于目标平台的能力。例如，`PackageCompressionMinPercentSaved=5` 。 请注意，一些压缩器（例如Oodle）会在内部自行检查是否值得压缩，并忽略该值。 |
| **为IoStore压缩启用DDC（Enable DDC for IoStore Compression）** | 指定在创建IoStore容器时是否应该将派生数据缓存用于存储和检索压缩数据。 |
| **包含崩溃报告器（Include Crash Reporter）** | 指定是否在打包的项目中包含崩溃报告器。 基于蓝图的项目默认包含该报告器，但可以选择将其禁用。 |
| **国际化支持（Internationalization Support）** | 应打包国际化数据的文化的预定义集。 你可以从以下选项中选择： **英语（English）** **EFIGS** ：英语、法语、意大利语、德语、西班牙语 **EFIGSCJK** ：英语、法语、意大利语、德语、西班牙语、中文、日语、韩语 **CJK** ：中文、日语、韩语 **全部（All）** |
| **数据块的本地化目标（Localization Targets to Chunk）** | 烘焙期间应分块的本地化目标的列表（如果使用数据块）。 |
| **本地化目标总受数据块ID（Localization Target Catch All Chunk ID）** | 应该用作所有非资产本地化字符串的总受数据块的数据块ID。 |
| **烘焙项目内容目录中的所有内容（忽略"打包版本中要包含的地图列表"设置中的地图列表）（Cook Everything in the Project Content Directory (Ignore List of Maps in the "List of Maps to Include in a Packaged Build" setting)）** | 烘焙项目内容目录中的所有内容。 |
| **仅烘焙地图（这仅影响Cookall）（Cook Only Maps (This Only Affects Cookall)）** | 仅烘焙地图（这仅影响Cookall标记）。 如需更多信息，请参阅[内容烘焙](../../../sharing-and-releasing-projects/packaging-and-cooking/cooking-content/index.md)页面。 |
| **烘焙时排除编辑器内容（Exclude Editor Content When Cooking）** | 烘焙时不包含任何编辑器文件夹中的内容（ `Engine/Content/Editor*` 下的所有内容）。 如果游戏使用的内容被排除在外，这可能会导致烘焙游戏内容缺失问题。 |
| **暂存时排除视频文件（跳过视频）（Exclude Movie Files When Staging (Skip Movies)）** | 此设置将指示编辑器在暂存或打包时默认不包括视频。 如果此设置（ `.ini` 文件中的 `bSkipMovies` ）为true，则跳过 `Engine\\Content\\Movies` 和 `<ProjectRoot>\\Content\\Movies` 中的所有视频文件，并暂存或打包 `UFSMovies` 和 `Non-UFSMovies` 中列出的视频。 如果此设置（`.ini` 文件中的 `bSkipMovies`）为false，则 `Engine\\Content\\Movies` 和 `<ProjectRoot>\\Content\\Movies` 中的所有视频文件都将暂存或打包。 |
| **要打包的特定视频（UFSMovies）（Specific Movies to Package (UFSMovies)）** | 如果 `bSkipMovies` 为true，这些特定视频仍将添加到 `.pak` 文件（如果使用 `.pak` 文件；否则，它们会作为单独的文件复制）。 视频文件的名称在列表中应该不含扩展名：例如，如果视频的文件名是 `Level2CinematicScene.mp4` ，你应该将 `Level2CinematicScene` 添加到此数组。 `UFSMovies` 和 `Non-UFSMovies` 字段从平台 `.ini` 文件读取，而不是仅从编辑器 `.ini` 文件读取。 |
| **要打包的特定视频（Non-UFSMovies）（Specific Movies to Copy (Non-UFSMovies)）** | 如果 `SkipMovies` 为true，打包项目时会复制这些特定视频，但它们不应成为 `.pak` 文件的一部分。 视频文件的名称在列表中应该不含扩展名：例如，如果视频的文件名是 `Level2CinematicScene.mp4` ，你应该将 `Level2CinematicScene` 添加到此数组。 `UFSMovies` 和 `Non-UFSMovies` 字段从平台 `.ini` 文件读取，而不是仅从编辑器 `.ini` 文件读取。 |
| **压缩数据块通配符（Compressed Chunk Wildcard）** | 如果设置此项，将仅压缩这些特定 `.pak` 文件。 这应该采用 `*pakchunk0*` 的形式。 这可以在特定于平台的 `.ini` 文件中设置。 |
| **打包版本中要包含的地图列表（List of Maps to Include in a Packaged Build）** | 命令行中未指定其他地图时要包含的地图列表。 |
| **要烘焙的其他资产目录（Additional Asset Directories to Cook）** | 这些目录包含的 `.uasset` 文件应该一律烘焙，无论是否被项目中的任何内容引用。 这些路径存储为完整数据包路径（例如， `/Game/Folder` 、 `/Engine/Folder` 、 `/PluginName/Folder` ）或相对于 `/Game` 的数据包路径。 |
| **从不烘焙的目录（Directories to Never Cook）** | 这些目录包含的 `.uasset` 文件应该从不烘焙，即使被项目引用也不例外。 这些路径存储为完整数据包路径（例如， `/Game/Folder` 、 `/Engine/Folder` 、 `/PluginName/Folder` ）或相对于 `/Game` 的数据包路径。 |
| **不搜索的测试目录（Test Directories to Not Search）** | 这些目录包含的 `.uasset` 文件用于编辑器测试目的，不应包含在根目录中的所有数据包的枚举中，因为会导致加载时出错。 这些路径存储为完整数据包路径（例如， `/Game/Folder` 、 `/Engine/Folder` 、 `/PluginName/Folder` ）或相对于 `/Game` 的数据包路径。 |
| **要打包的其他非资产目录（Additional Non-Asset Directories to Package）** | 这些目录包含的文件应该一律添加到 `.pak` 文件（如果使用 `.pak` 文件；否则，作为单独的文件复制）。 这用于暂存你通过UFS（虚幻文件系统）文件IO API手动加载的其他文件。 这些路径相对于你的项目 `Content` 目录。 |
| **要复制的其他非资产目录（Additional Non-Asset Directories to Copy）** | 这些目录包含的文件在打包项目时应该一律复制，但不应成为 `.pak` 文件的一部分。 这用于暂存你在不使用UFS（虚幻文件系统）文件IO API的情况下手动加载的其他文件，例如，执行其自己的内部文件IO的第三方库。 这些路径相对于你的项目 `Content` 目录。 |
| **仅针对专用服务器要打包的其他非资产目录（Additional Non-Asset Directories to Package for Dedicated Server Only）** | 这些目录包含的文件应该一律添加到专用服务器的 `.pak` 文件（如果使用 `.pak` 文件；否则，作为单独的文件复制）。 这用于暂存你通过UFS（虚幻文件系统）文件IO API手动加载的其他文件。 这些路径相对于你的项目 `Content` 目录。 |
| **仅针对专用服务器要复制的其他非资产目录（Additional Non-Asset Directories to Copy for Dedicated Server Only）** | 这些目录包含的文件在针对专用服务器打包项目时应该一律复制，但不应成为 `.pak` 文件的一部分。 这用于暂存你在不使用UFS（虚幻文件系统）文件IO API的情况下手动加载的其他文件，例如，执行其自己的内部文件IO的第三方库。 这些路径相对于你的项目 `Content` 目录。 |
| **要打包的本地化（Localizations to Package）** | 应该烘焙、暂存并打包其数据的文化。 |

### 项目

| **分段** | **说明** |
| --- | --- |
| **编译（Build）** | 指定是否在打包期间编译游戏可执行文件。 你可以从以下选项中选择： **总是（Always）** **从不（Never）** **如果项目有代码，或运行本地编译的编辑器（If Project Has Code, or Running a Locally Built Editor）** **如果运行本地编译的编辑器（If Running a Locally Built Editor）** |
| **编译配置（Build Configuration）** | 打包项目的编译配置。 你可以从以下选项中选择： **调试（Debug）** **调试游戏（DebugGame）** **开发（Development）** **测试（Test）** **发布（Shipping）** |
| **编译目标（Build Target）** | 要编译的目标的名称。 |
| **暂存目录（Staging Directory）** | 打包的项目将复制到的目录。 |
| **完全重新编译（Full Rebuild）** | 启用后，每次打包项目时将强制完全重新编译。 禁用后，仅会编译修改的文件，这可以改善迭代时间。 除非你在打包时迭代，否则我们建议在打包时完全重新编译。 |
| **用于发行（For Distribution）** | 启用后，将使用发布配置创建发行版本。 禁用后，将创建开发版本。 发行版本用于发布到App Store。 |
| **在发布版本中包含调试文件（Include Debug Files in Shipping Builds）** | 启用后，将在暂存的发布版本中包含调试文件。 |

### 先决条件

| **分段** | **说明** |
| --- | --- |
| **包含先决条件安装程序（Include Prerequisites Installer）** | 指定是否在支持的平台上为打包游戏的先决条件包含一个安装程序，例如可再发行操作系统组件。 |
| **包含应用本地先决条件（Include App-Local Prerequisites）** | 指定是否随游戏可执行文件一起包含先决条件。 |
| **应用本地先决条件目录（App-Local Prerequisites Directory）** | 该目录包含应该在可执行文件目录中暂存的其他先决条件程序包。 可以相对于虚幻引擎安装目录中的 `Engine` 文件夹，或你的 `.uproject` 文件所在的文件夹。 |

## 支持的平台

你可以在此处选择项目的支持平台。如果你试图在不支持的平台上打包、运行或烘焙项目，系统将发出警告。

你可以选择以下一个或多个选项：

- 所有平台（All Platforms）
- Android
- IOS
- Linux
- LinuxARM64
- TVOS
- Windows

## 目标硬件

### 目标硬件

| **分段** | **说明** |
| --- | --- |
| **优化项目设置（Optimize Project Settings for）** | 选择硬件类和图形级别。 你可以从以下选项中选择： 要作为目标的硬件类： **桌面端（Desktop）：** 台式机或主机 **移动端（Mobile）：** 手机或平板电脑 要作为目标的图形级别： **最大值（Maximum）：** 默认启用的高端功能。 **可伸缩（Scalable）：** 一些功能默认禁用，但可以基于实际硬件启用。 |

### 待定更改

此分段将显示对项目设置的所有待定更改。
