---
title: "调整团队规模所需的资源"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/resources-for-scaling-your-unreal-engine-team"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "汽车HMI开发", "调整团队规模所需的资源"]
---

# 调整团队规模所需的资源

> 路径：虚幻引擎5.7文档 / 移动端开发 / 汽车HMI开发 / 调整团队规模所需的资源

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/resources-for-scaling-your-unreal-engine-team

随着项目的代码和资产数量的增长以及团队规模的扩大，你可能会面临项目规模方面的挑战。 为确保项目能够尽可能流畅地运行，Epic Games为虚幻引擎提供了多款工具，旨在帮助你解决下列问题：

- 为你的团队分发引擎和项目。
- 降低编译和打包的耗时。
- 减少项目所占用的硬盘空间。
- 缩短从版本控制拉取最新代码和资产的同步时间。
- 建立自动化编译管线。
- 建立自动化测试管线。

以上这些举措都是为了减少团队成员在使用虚幻引擎时所受到的阻力，并缩短编译、测试和修改功能所需的迭代时间。

### 利用版本控制软件管理项目

*版本控制*是所有游戏开发项目的重要组成部分。 版本控制服务器会存储项目代码和文件的集中式权威副本，而版本控制客户端则会为团队成员提供访问和更新这些文件的途径。 "仓库（Repository）"会将版本控制服务器上存储的文件按版本严格分组，"工作空间（Workspace）"则是客户端侧的目录，每个工作空间都会存储该客户端专属仓库的副本。

集成版本控制能为你带来下列功能：

- 将项目副本拉取到本地机器。
- 审查并提交代码和资产。
- 隔离工作流以防止冲突。
- 检出、锁定和发布文件，从而防止多个团队成员处理同一文件。
- 比较（diff）和合并文件。

此外，版本控制还会保存提交到仓库的变更列表（该列表实时更新），以便在变更导致问题时，轻松回滚到资产或代码的早期版本。

虚幻引擎支持集成下列版本控制：

- Perforce
- 附带GitLFS的Git
- Subversion
- Diversion

在开始处理资产或代码前，你应该首先为项目设置任一上述版本控制工具。 上述工具均可胜任，但Epic Games主要使用Perforce，本指南中的许多功能也都围绕虚幻引擎的Perforce集成。 项目拥有仓库后，你可以将其集成到内容浏览器，以便直接在虚幻编辑器中检出和管理文件。

如需详细了解如何为虚幻引擎使用版本控制，请参阅[源码管理](../../../understanding-the-basics/source-control/index.md)页面以及[协作和版本控制](../../../production-pipeline/collaboration-and-version-control/index.md)小节。

### 使用Unreal Game Sync分发项目

**Unreal Game Sync**（**UGS**）是一款客户端，可与Perforce、虚幻编译工具和你的IDE（如适用）交互，方便团队成员下载或编译项目的有效构建。 设置好UGS后，用户可以选择各自的`.uproject` 文件，查看该项目的构建列表，并查找被验证有效的构建。 如果你安装了IDE，则可以使用单个命令拉取并编译源文件。 如果没有安装IDE，你也可以找到附带预编译二进制文件的构建并下载。

如需更多信息，请参阅[UGS文档](../../../production-pipeline/deploying/unrealgamesync-ugs/index.md)。

### 为团队创建离线安装程序

如果你已经分叉并自定义了引擎源代码，那么你将可能需要创建一个**已安装构建**，并将其打包为虚幻引擎的**离线安装程序**。 如需详细了解如何创建离线安装程序，请参阅[创建已安装构建](../../../production-pipeline/deploying/create-an-installed-build-of/index.md) 和 [已安装构建参考](../../../production-pipeline/deploying/installed-build-reference-guide/index.md)页面。

### 使用虚幻引擎模块和ICWYU减少多余的C++编译

项目中的C++代码越多，从IDE编译所需的时间就越长。 因此，通常而言，C++的编译时间会随着项目的进展而增加。 尤其是对于超大型项目，这可能会影响程序员的迭代时间。

虚幻引擎的架构会将代码分解为模块，以缓解此问题。 当你将代码分类为模块时，只有你正在处理的模块中的代码会被重新编译，而其他模块将保持不变。 使用模块还有其他好处，详情请参阅[虚幻引擎模块](../../../cpp-programming/programming-in-the-unreal-engine-architecture/unreal-engine-modules/index.md)小节和[编辑器模块](../../../production-pipeline/scripting-and-automating-the-unreal-editor/programming-tools/setting-up-editor-modules-for-customizing-the-editor/index.md)页面。

虚幻引擎的基本代码也使用了**包含你所使用的内容**（**Include What You Use，IWYU**）范式，该范式能使用`#include`语句和更高效的前向声明来缩短编译时间。 如需更多信息，请参阅[IWYU](../../../production-pipeline/using-the-unreal-engine-build-pipeline/unreal-build-tool/include-what-you-use-iwyu-for-unreal-engine-programming/index.md)页面。

### 使用UAT、BuildGraph和Horde创建自动化构建

你可以用虚幻编辑器打包项目，但**虚幻自动化工具**（**UAT**）的[BuildCookRun](../../../sharing-and-releasing-projects/packaging-and-cooking/build-operations-cooking-packaging-deploying-an-ca003a9c/index.md)命令才是创建打包构建的底层机制。你可以使用操作系统的任何命令行界面访问该机制。 UAT提供了许多脚本，可以帮你在无法使用GUI的情况下将编译过程自动化，例如设置编译服务器，进而自动编译所有提交到版本控制系统的版本。 你可以使用UAT的BuildCookRun命令编写自定义的自动编译管线脚本，从而获得更直接、更简单的体验，或者你也可以使用[BuildGraph](https://dev.epicgames.com/documentation/unreal-engine/buildgraph?application_version=5.7)设置更详细的自动构建系统。

[Horde](../../../production-pipeline/horde/index.md)是一款基于BuildGraph框架构建的强大、持续的集成套件，包含多种工具，可用于监控构建运行状况、集成任务跟踪软件、管理远程测试设备，以及提供详细的分析和日志。 此外，Horde还支持[虚幻编译加速器（Unreal Build Accelerator，UBA）](../../../production-pipeline/horde/horde-tutorials/horde-unreal-build-accelerator-and-remote-compi-426eec09/index.md)，该工具可以将工作分配到多个服务器和/或工作站，从而提高编译速度。

如果你需要自定义编译管线，请参阅[虚幻编译系统](../../../production-pipeline/using-the-unreal-engine-build-pipeline/index.md)小节，获取自动化工具和编译工具的完整参考。

## 使用多进程烘焙加快烘焙时间

打包构建时，虚幻引擎会针对目标平台烘焙项目资产，将其转换为兼容目标平台的格式，并应用你为其设置的压缩设置。 通常而言，这是一个单独的进程，但为了加快烘焙速度，你也可以启用多进程烘焙，并配置要使用并发烘焙进程的数量。 如需更多信息，请参阅[多进程烘焙](../../../sharing-and-releasing-projects/packaging-and-cooking/using-multi-process-cooking/index.md)指南。

## 使用虚拟资产简化资产管理

随着项目中资产数量和大小的增长，团队成员从源代码控制更新项目所需的时间会显著加长，而项目的本地副本所使用的硬盘空间也会增加。

为解决此问题，虚幻引擎支持**虚拟资产**。 虚拟资产可以将资产的主要数据与在编辑器的内容浏览器中显示所用的元数据相分离。 当团队成员同步项目时，他们只会同步元数据，而这比使用完整资产占用的空间要小得多。 当他们需要实际访问资产以进行查看或更改时，虚幻引擎会按需从团队的仓库库或**派生数据缓存**（**Derived Data Cache，DDC**）中提取资产的批量数据。

如需更多信息，请参阅[虚拟资产](../../../production-pipeline/virtual-assets/index.md)文档。

### 使用派生数据缓存缩短编辑器着色器编译时间

虚幻引擎中的许多资产都使用**派生数据**。 例如，当你创建材质时，虚幻引擎需要紧接着编译着色器，然后材质才能完全显示。 版本控制系统中的文件包含了创建着色器所需的指令，这些指令在所有平台上通用且易于编辑；派生数据作为一个独特的概念和机制而存在，原因有两点：一是将派生数据与原始数据存储在同一个文件中会使仓库变得非常庞大；二是编译后的着色器的具体格式可能因你使用的硬件和操作系统而异。 随着项目或团队的规模扩大，当需要获取大量更改时，这可能会让过程变得异常繁琐，在你需要从头开始重新下载项目时尤其如此。

**派生数据缓存**（**DDC**）专为此类派生数据充当二级仓库。 当某个用户编译或烘焙资产时，该用户会将派生数据添加到DDC。 然后，当其他使用兼容硬件的用户同步该资产时，虚幻引擎可以同时提取该资产及其派生数据 – 意味着无需从头开始重新编译。 与版本控制不同，DDC通常不会保留所有被提交文件的所有版本，而只会根据指定的限制保留最新数据。 就算在极少数情况下，有人需要检出项目的极旧版本，那么也始终可以重新生成派生数据。 你可以在相对于员工的不同位置部署各种共享DDC，并定义团队成员访问它们的规则，以确保团队成员能从最快、最可靠的来源提取数据。

如需详细了解DDC，请参阅[派生数据缓存](../../../production-pipeline/using-derived-data-cache/index.md)文档。 虚幻引擎支持多种托管共享DDC的方法，但我们推荐[Zen存储服务器](../../../production-pipeline/zen-storage-server/index.md)。

### 利用自动化测试调整测试规模

虚幻引擎提供多种自动化测试框架，让你可以在不同上下文中测试代码。 这让你可以更早、更频繁地检测代码中的漏洞，并让QA测试人员能对用户体验问题投入更多精力。 如需更多信息，请参阅[自动化测试框架](../../../testing-and-optimizing-content/automation-test-framework/index.md)小节。
