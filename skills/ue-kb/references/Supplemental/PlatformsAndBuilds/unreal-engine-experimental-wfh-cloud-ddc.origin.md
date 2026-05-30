# 实验性 WFH：云 DDC

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/YkJx/unreal-engine-experimental-wfh-cloud-ddc

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 8991 字符。

## 摘要

文章由 Branden T 撰写。通过 VPN 工作的主要挑战之一是在同步新内容（编译着色器、压缩纹理等）后必须重建派生数据。在现场工作时，我们...

## 中文整理

### 概览

*文章由 [Branden T.](https://dev.epicgames.com/community/profile/Kzq2/Branden.Turner) 撰写* 通过 VPN 工作的主要挑战之一是在同步新内容（编译着色器、压缩纹理等）后必须重建派生数据。在现场工作时，我们鼓励使用共享的派生数据缓存来存储此内容 - 编辑器可以读取和写入的网络共享，以便缓存转换后的资源。 [派生数据缓存|虚幻引擎 5.0 文档](https://docs.unrealengine.com/en-US/Engine/Basics/DerivedDataCache/index.html) 由于位于许多编辑器操作的关键路径上，对派生数据缓存的访问通常对延迟高度敏感，并且通过 VPN 访问网络共享可能会导致严重的故障和非常慢的启动时间。我们尝试了几种方法来改善在家运行编辑器时的情况。首先，我们尝试将单个文件上传到云存储提供商（由于延迟和建立连接所花费的时间增加，这比在本地重新生成数据表现更差）。接下来，我们尝试归档共享 DDC 文件夹并将其放入云托管驱动器中（由于 DDC 的庞大规模和不断的变动，这表现不佳）。我们最终成功的解决方案是： 1. 我们添加了一个 DDC 后端，它将针对 DDC 进行的任何查询记录到纯文本文件中。 2. 我们添加了一个自动化测试，可以加载到编辑器中的一些常用地图中并运行 play-in-editor 命令。上面提到的 DDC 记录后端生成一个文本文件到网络共享。 3. 我们添加了一个 AutomationTool 命令 (UploadDDCToAWS)，该命令扫描所有文本文件，将派生的数据文件连接成 100mb 的捆绑包，并将它们上传到 Amazon S3。该脚本在我们的现场构建场中每 4 小时运行一次。 4. 我们添加了一个新的 DDC 后端，它可以在编辑器启动时下载并解压缩这些捆绑包，从而消除了按需执行此操作所需的延迟。由于缓存以及在 UploadDDCToAWS 命令​​迭代之间重复使用现有捆绑包，即使通过家庭网络连接下载 10 GB 也能提供合理的性能。

### 1 - 设置访问记录器

这是通过使用自定义 DDC 后端运行引擎来完成的，该后端通过游戏的 DefaultEngine.ini 文件进行配置，如下所示：

```cpp
[EnumerateForS3DDC]
MinimumDaysToKeepFile=7
Root=(Type=KeyLength, Length=120, Inner=AsyncPut)
AsyncPut=(Type=AsyncPut, Inner=Hierarchy)
Hierarchy=(Type=Hierarchical, Inner=Shared)
Shared=(Type=FileSystem, ReadOnly=false, Clean=false, Flush=false, DeleteUnused=true, UnusedFileAge=5, FoldersToClean=10, MaxFileChecksPerSec=1, Path=\\path\to\your\regular\shared\ddc, EnvPathOverride=UE-SharedDataCachePath, WriteAccessLog="%GAMEDIR%Saved/Logs/DDCAccessLog.txt")
```

**注意：** 图中的 Shared 节点包含一个指向您正常配置的网络 DDC 的 Path 参数，以及指定将访问日志输出到何处的 WriteAccessLog 参数。 CL 12166433 中添加了对 WriteAccessLog 属性的支持。要在运行编辑器时启用此 DDC 后端，请在命令行上传递 -DDC=EnumerateForS3DDC 参数。

### 2 - 自动化测试

此过程的实现是特定于游戏的，我们目前没有可用的示例。如有必要，您可以让某人定期手动生成此数据，只要他们在启用记录后端的情况下运行编辑器即可。

### 3 - 将数据上传到 S3

UploadDDCToAWS 命令​​在 /UE4/Main/Engine/Source/Programs/AutomationTool/Scripts/UploadDDCToAWS.cs 中实现（请参阅 CL 12626541），并且通常使用 RunUAT 批处理文件运行。该命令采用以下参数： - Bucket=...* 指定要上传到的 S3 存储桶的名称 - CredentialsFile=...* 指定包含 S3 凭证的配置文件的路径。请参阅[此处](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)了解此文件的格式。 - CredentialsKey=…* 指定凭证文件中要从中获取凭证的部分名称。 - CacheDir=…* 共享网络 DDC 的路径。记录的 DDC 访问日志中的路径将根据此基本目录进行解析。 - FilterDir=…* 包含记录的访问日志的目录路径。 - Days=…* FilterDir 中保留文件的天数。任何早于此时间的文件都将被删除。 - Manifest=...* 指定当前工作区中用于存储根清单 URL 的路径。该文件将被检入 P4。请参阅下面有关捆绑包 URL、清单 URL 和根清单如何交互的注释。 - KeyPrefix=...* 用于上传到存储桶的所有内容的对象前缀。 - 重置* 如果设置，现有捆绑包将不会被重复使用。

### 4 - 在运行时下载数据

启用从 S3 下载数据需要配置新的 DDC 图，或修改默认的 DDC 图。要修改默认配置以使用 S3 后端而不是网络共享，请在游戏的 DefaultEngine.ini 文件中添加如下部分：Shared=(Type=S3, Manifest="%GAMEDIR%Build/S3DDC.json", BaseUrl="https://foo.s3.us-east-1.amazonaws.com/", Region="us-east-1", AccessKey="abc123", SecretKey="def465")此处，Manifest 参数指定通过 UploadDDCToAWS 命令提交到源代码管理的根清单的路径，BaseUrl/Region 指定要从中下载的 S3 存储桶，AccessKey/SecretKey 指定要用于下载的凭证。 S3 派生数据后端在 //UE4/Main/Engine/Source/Developer/DerivedDataCache/Private/S3DerivedDataBackend.cpp 和 S3DerivedDataBackend.h 中实现。需要以下更改列表： 12149604 12149624 12155157 12156082 12158937 12195879 12459547 12468805 通过将以下设置添加到 DefaultEditor.ini，可以在编辑器首选项面板中显示禁用 S3 DDC 的选项：

```cpp
[EditorSettings] 
bShowEnableS3DDC=true
```

### 一些实施细节

- 7 天后，UploadDDCToAWS 命令​​ (3) 从网络共享中删除记录器 (1) 生成的文本文件。 - S3 后端 (4) 配置有密钥和访问密钥，但这些凭据必须提交给源代码管理。为了提高安全性，捆绑包被赋予一个随机的、不可猜测的 URL，并由清单索引 - 也使用不可猜测的 URL 上传。最近几天清单的路径存储在 Perforce 的配置文件中，并在之后删除。该存储桶配置为拒绝 LIST 请求，因此即使拥有访问密钥、秘密密钥和清单 URL，也只能在几天内提供对最新捆绑包数据的访问。 - 只要至少 40% 的数据仍被引用，捆绑包就会保留在活动清单中。一旦捆绑包被丢弃，其中的数据就可以添加到新的捆绑包中。

### 实施云 DDC 所需的所有 CL 列表：

12149604 12149624 12155157 12156082 12158937 12166433 12195879 12459547 12468805 12626541

### 无法访问 Perforce 的用户的 GitHub 提交列表：

- [https://github.com/EpicGames/UnrealEngine/commit/7d6083104f873abac544d0a9b04ce4dffb9135bd](https://github.com/EpicGames/UnrealEngine/commit/7d6083104f873abac544d0a9b04ce4dffb9135bd) - [https://github.com/EpicGames/UnrealEngine/commit/b5fdbe9e35a91d2fa6b7e95603e2df15b9fc9dd4](https://github.com/EpicGames/UnrealEngine/commit/b5fdbe9e35a91d2fa6b7e95603e2df15b9fc9dd4) - [https://github.com/EpicGames/UnrealEngine/commit/5393bfd155be9f81f337aa8dfeb46c7140c2d06e](https://github.com/EpicGames/UnrealEngine/commit/5393bfd155be9f81f337aa8dfeb46c7140c2d06e) - [https://github.com/EpicGames/UnrealEngine/commit/ff74b40543ac82cf110d7c8b1f84689947691d30](https://github.com/EpicGames/UnrealEngine/commit/ff74b40543ac82cf110d7c8b1f84689947691d30) - [https://github.com/EpicGames/UnrealEngine/commit/4fbcf75b6e59670b4b184b1a48bbde7ea84e11aa](https://github.com/EpicGames/UnrealEngine/commit/4fbcf75b6e59670b4b184b1a48bbde7ea84e11aa) - [https://github.com/EpicGames/UnrealEngine/commit/31934e0cc13f020f974b1f6326a3f58a85bc24ad](https://github.com/EpicGames/UnrealEngine/commit/31934e0cc13f020f974b1f6326a3f58a85bc24ad) - [https://github.com/EpicGames/UnrealEngine/commit/8b87619ad5134b7a094b4131829a7d55cf49457f](https://github.com/EpicGames/UnrealEngine/commit/8b87619ad5134b7a094b4131829a7d55cf49457f) - [https://github.com/EpicGames/UnrealEngine/commit/604cd089682edb66ebf1bef76cea9134f54ea893](https://github.com/EpicGames/UnrealEngine/commit/604cd089682edb66ebf1bef76cea9134f54ea893) - [https://github.com/EpicGames/UnrealEngine/commit/e14b92bc18334ba2671969387f5c305c8f8985d2](https://github.com/EpicGames/UnrealEngine/commit/e14b92bc18334ba2671969387f5c305c8f8985d2) - [https://github.com/EpicGames/UnrealEngine/commit/6f6fe556a9348d7426cfa3e161b61ea6fdc47623](https://github.com/EpicGames/UnrealEngine/commit/6f6fe556a9348d7426cfa3e161b61ea6fdc47623)
