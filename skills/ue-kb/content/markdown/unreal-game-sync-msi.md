# Unreal Game Sync MSI 安装程序创建

# Unreal Game Sync MSI 安装程序创建

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/Ykar/unreal-engine-unreal-game-sync-msi-installer-creation

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2815 字符。

## 摘要

Unreal Game Sync MSI 安装程序创建 本文由 Brian Frager 撰写 在某些情况下，工作室需要一个特定于站点并与内部 Perforce 服务器绑定的 UGS 版本，而不是 Epic 的 Pe…

## 中文整理

### 概览

*本文由 Brian Frager 撰写* 在某些情况下，工作室需要特定于站点并与内部 Perforce 服务器（而不是 Epic 的 Perforce 服务器）绑定的 UGS 版本，用于编译引擎的自定义版本以供内部团队分发。

### UE4（需要手动安装Wix）：

1. 为您的 Visual Studio 版本安装 Wix 扩展：[WiX 发行说明 | WiX 工具集](https://wixtoolset.org/releases/) 2. 安装最新版本的 WixSDK（同一页面） 3. 转到位于 Engine/Source/Programs/UnrealGameSync 的源代码。 4. 打开 UnrealGameSync.sln 5. 在 Visual Studio 中，转至 Tools → Nuget Package Manager → Package Manager Console 6. 在 VS 控制台中输入：Install-Package WiX -Version 3.8.0 7. 在 Engine/Source/Programs/UnrealGameSync/UnrealGameSync/DeploymentSettings.cs 中设置任何特定于工作室的设置 8. 部署设置是特定于站点的，因此请参阅 [UGS文档](https://docs.unrealengine.com/4.26/ProductionPipelines/DeployingTheEngine/UnrealGameSync/Reference/#:~:text=a%20MetadataServer%20instance.-,Configuration,-Deployment%20settings%20for)（如果您要设置内部 Perforce 服务器）。需要至少设置 DefaultDepotPath。 9. 构建 UnrealGameSyncLauncher 项目 10. 查看在 Engine\Source\Programs\UnrealGameSync\UnrealGameSync.msi 中创建的 MSI 安装程序包（从位于 Engine/Source/Programs/UnrealGameSync/Installer 中的 wix 文件生成）

### UE5（自动处理 Wix 依赖性）：

1. 转到位于 Engine/Source/Programs/UnrealGameSync 的源。 2. 打开 UnrealGameSync.sln 3. 在 Engine/Source/Programs/UnrealGameSync/UnrealGameSync/DeploymentSettings.cs 中设置任何特定于工作室的设置 4. 部署设置是特定于站点的，因此请参阅 [UGS文档](https://docs.unrealengine.com/4.26/en-US/ProductionPipelines/DeployingTheEngine/UnrealGameSync/Reference/#:~:text=a%20MetadataServer%20instance.-,Configuration,-Deployment%20settings%20for)（如果您要设置内部 Perforce 服务器）。需要至少设置 DefaultDepotPath。 5. 构建 UnrealGameSyncLauncher 项目 6. 查看在 Engine\Source\Programs\UnrealGameSync\UnrealGameSync.msi 中创建的 MSI 安装程序包（从位于 Engine/Source/Programs/UnrealGameSync/Installer 中的 wix 文件生成） *请注意，UGS MSI 安装程序包指向 Perforce 的最新 UGS 可执行文件（在 DefaultDepotPath 设置中指定）并运行它们，因此 Perforce 上的 UGS 可执行文件可以不断更新无需更新 MSI 安装程序 在[知识库](https://forums.unrealengine.com/docs) 获取更多答案！

