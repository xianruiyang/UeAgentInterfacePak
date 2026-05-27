---
title: "在游戏中实现ChunkDownloader"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/implementing-chunkdownloader-in-your-gameplay-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "补丁和DLC", "使用ChunkDownloader实现游戏补丁功能", "在游戏中实现ChunkDownloader"]
---

# 在游戏中实现ChunkDownloader

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / 补丁和DLC / 使用ChunkDownloader实现游戏补丁功能 / 在游戏中实现ChunkDownloader

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/implementing-chunkdownloader-in-your-gameplay-in-unreal-engine

**ChunkDownloader** 是面向 **虚幻引擎（UE）** 的补丁解决方案。它从远程服务下载资产，并将其在内存中挂载供游戏使用，以便你可以轻松提供更新和资产。本指南将向你展示如何在自己的项目中实现ChunkDownloader。完成本指南，你便能够：

- 使用Visual Studio初始化和关闭ChunkDownloader。
- 使用Visual Studio从主机网站中下载打包文件。
- 设置

  游戏模式蓝图（Game Mode Blueprint）

  以在UE中实现ChunkDownloader。
- 在

  关卡编辑器视口（Level Editor Viewport）

  或游戏中显示下载的内容。
- 安全访问已挂载的打包文件中的内容。
- 在本地机器上测试UE项目中已调整的系统。

## 1.所需设置和建议资产

在继续进行任何操作之前，你应该阅读以下指南并遵循每个步骤：

- 设置ChunkDownloader插件
- 准备资产进行分块
- 为ChunkDownloader托管清单和资产

如参考指南中所示，你需要：

1. 基于 **空白模板** 创建 **C++项目** 。将该项目命名为 **PatchingDemo** 。
2. 在 **插件（Plugins）** 菜单中启用 **ChunkDownloader** 插件。
3. 在 **项目设置（Project Settings）> 项目（Project）> 打包（Packaging）** 中，启用 **使用Pak文件（Use Pak File）** 和 **生成块（Generate Chunks）** 。
4. 在 **Visual Studio** 中编辑你项目的 `[ProjectName]Build.cs` 文件。
5. 生成Visual Studio项目文件。
6. 在Visual Studio中构建你的项目。
7. 将 **Paragon** 的 **Boris** 、 **Crunch** 和 **Khaimera** 资产添加到该项目。
8. 基于 **主要资产标签（Primary Asset Label）** 为每个添加的资产调整 **数据资产（Data Asset）** 。
9. 烘培或打包项目，并在构建文件夹中包含打包文件。
10. 将打包文件分发到本地托管的网站。
11. 创建名为 `BuildManifest-Windows.txt` 的清单文件。
12. 为你的项目定义 `DefaultGame.ini` 文件。

## 2.初始化和关闭ChunkDownloader

ChunkDownloader是对 `FPlatformChunkInstall` 接口的实现，该接口是许多接口之一，可以根据你的游戏运行平台交替加载不同的模块。需要先加载和初始化所有模块才能使用它们，还需要关闭并清理它们。

通过ChunkDownloader进行此操作的最简单方法是使用自定义 **GameInstance** 类。GameInstance不仅具有可以绑定的相应初始化和关闭函数，而且还可以在游戏运行时持续访问ChunkDownloader。以下步骤将引导你完成此实现过程。

使用 **GameInstance** 作为基类创建 **新C++类** 。将其命名为 **PatchingDemoGameInstance** 。

![undefined](../../../../../assets/images/84/840b4fef2e41c3d1355358a0f9c438674917c15b944eafbf394d91d6325313bc.png)

点击查看大图。

编译进程完成时，文件 `PatchingDemoGameInstance.h` 和 `PatchingDemoGameInstance.cpp` 将在Visual Studio中自动打开。

### 处理PatchingDemoGameInstance.h

文件打开时， `PatchingDemoGameInstance.h` 中的代码应如下所示：

PatchingDemoGameInstance.h

```
	#pragma once 	#include "CoreMinimal.h"	#include "Engine/GameInstance.h"	#include "PatchingDemoGameInstance.generated.h" 	UCLASS()	class UPatchingDemoGameInstance : public UGameInstance	{		GENERATED_BODY()	}; 
```

1. Change string `class UPatchingDemoGameInstance : public UGameInstance` to

   PatchingDemoGameInstance.h

   ```
        class PATCHINGDEMO_API UPatchingDemoGameInstance : public UGameInstance 
   ```

   你将在 `PatchingDemoGameInstance.h` 文件中声明的所有后续变量、函数和属性都需要添加到 `UPatchingDemoGameInstance` 类下。
2. 在 `public` 标头下声明以下函数覆盖：

   PatchingDemoGameInstance.h

   ```
        public:     // 覆盖         virtual void Init() override;         virtual void Shutdown() override; 
   ```

   `Init` 函数会在游戏启动时运行，使其成为初始化ChunkDownloader的理想位置。同样，`Shutdown` 函数会在游戏停止时运行，因此你可以用它来关闭ChunkDownloader模块。
3. 在 `protected` 标头下声明以下变量：

   PatchingDemoGameInstance.h

   ```
        protected:     //用我们网站上托管的清单文件追踪本地清单文件是否为最新文件。     bool bIsDownloadManifestUpToDate; 
   ```
4. 在 `protected` 标头下声明以下函数：

   PatchingDemoGameInstance.h

   ```
        protected:     //在文件块下载进程完成时调用     void OnManifestUpdateComplete(bool bSuccess); 
   ```

### 处理PatchingDemoGameInstance.cpp

1. 打开 `PatchingDemoGameInstance.cpp` 。在此文件顶部的 `#include "PatchingDemoGameInstance.h"` 下添加以下 `#includes` ：

   PatchingDemoGameInstance.cpp

   ```
        #include "PatchingDemoGameInstance.h"      #include "ChunkDownloader.h"     #include "Misc/CoreDelegates.h"     #include "AssetRegistryModule.h" 
   ```

   这样你可以访问ChunkDownloader，以及一些用于管理资产和委托的有用工具。
2. 为 `Init` 函数创建以下实现：

   PatchingDemoGameInstance.cpp

   ```
        void UPatchingDemoGameInstance::Init()     {         Super::Init();         const FString DeploymentName = "PatchingDemoLive";         const FString ContentBuildId = "PatchingDemoKey";          // 用选定平台初始化文件块下载器         TSharedRef<FChunkDownloader> Downloader = FChunkDownloader::GetOrCreate();         Downloader->Initialize("Windows", 8);          //加载缓存的版本ID         Downloader->LoadCachedBuild(DeploymentName);          //更新版本清单文件         TFunction<void(bool bSuccess)> UpdateCompleteCallback = [&](bool bSuccess) {bIsDownloadManifestUpToDate = true; };         Downloader->UpdateBuild(DeploymentName, ContentBuildId, UpdateCompleteCallback);     } 
   ```

   我们总结一下这段代码的作用：

   1. 此函数定义 `DeploymentName` 和 `ContentBuildID` 以便匹配 `DefaultGame.ini` 中使用的值。这些是目前用于测试的固定值，但是在完整版本中，你将使用HTTP请求获取 `ContentBuildID`。该函数使用这些变量中的信息来向你的网站请求清单。
   2. 该函数调用 `FChunkDownloader::GetOrCreate` 设置ChunkDownloader并获取它的引用，然后将其存储在 `TSharedRef` 中。这是获取对这个或类似平台接口引用的首选方法。
   3. 该函数使用所需平台名称（在本例中为Windows）调用 `FChunkDownloader::Initialize` 。此示例为TargetDownloadsInFlight赋予值 **8** ，该值设置ChunkDownloader同时处理的最大下载数量。
   4. 该函数使用 `DeploymentName` 调用 `FChunkDownloader::LoadCachedBuild` 。这将检查磁盘上是否已经下载文件，如果它们是最新清单文件，则ChunkDownloader可以跳过下载流程。
   5. 该函数调用 `FChunkDownloader::UpdateBuild` 以下载清单文件的更新版本。

      - 这就是系统不需要全新的可执行文件即可支持更新补丁的方式。
      - UpdateBuild

        获取

        DeploymentName

        和

        ContentBuildID

        以及输出操作成功或失败的回调。
      - 它还使用

        OnManifestUpdateComplete

        设置

        bIsDownloadManifestUpToDate

        ，以便GameInstance可以全局识别此补丁阶段已完成。

   执行以下步骤可确保ChunkDownloader已初始化，准备开始下载内容，并告知其他函数清单的状态。
3. 为 `Shutdown` 函数创建以下实现：

   PatchingDemoGameInstance.cpp

   ```
        void UPatchingDemoGameInstance::Shutdown()     {         Super::Shutdown();         //关闭ChunkDownloader         FChunkDownloader::Shutdown();     } 
   ```

   调用FChunkDownloader::Shutdown将停止当前正在进行的所有ChunkDownloader下载，然后清理并卸载该模块。
4. 为 `OnManifestUpdateComplete` 函数创建以下实现：

   PatchingDemoGameInstance.cpp

   ```
        void UPatchingDemoGameInstance::OnManifestUpdateComplete(bool bSuccess)     {         bIsDownloadManifestUpToDate = bSuccess;     } 
   ```

   清单更新完成后，此函数将用作异步回调。

## 3. 下载打包文件

现在，你已经有ChunkDownloader的相应初始化和关闭函数，你可以公开其下载打包文件的功能。

### 处理PatchingDemoGameInstance.h

1. 在 `PatchingDemoGameInstance.h` 中，在 `#includes` 下面添加以下动态组播委托：

   PatchingDemoGameInstance.h

   ```
        DECLARE_DYNAMIC_MULTICAST_DELEGATE_OneParam(FPatchCompleteDelegate, bool, Succeeded); 
   ```

   该委托输出一个布尔值，该布尔值将告知你补丁下载操作是否成功。委托通常用于响应异步操作，例如下载或安装文件。
2. 在你的 `UPatchingDemoGameInstance` 类中，在 `public` 标头下添加 `GetLoadingProgress` 的以下函数声明：

   PatchingDemoGameInstance.h

   ```
        public:         UFUNCTION(BlueprintPure, Category = "Patching|Stats")         void GetLoadingProgress(int32& BytesDownloaded, int32& TotalBytesToDownload, float& DownloadPercent, int32& ChunksMounted, int32& TotalChunksToMount, float& MountPercent) const; 
   ```
3. 在 `public` 标头下添加以下委托声明：

   PatchingDemoGameInstance.h

   ```
        public:         // 委托         // 补丁过程成功或失败时触发         UPROPERTY(BlueprintAssignable, Category="Patching");         FPatchCompleteDelegate OnPatchComplete; 
   ```

   这为你提供了一个在补丁操作完成后与蓝图挂接的位置。
4. 在 `protected` 标头下，为 `ChunkDownloadList` 添加以下声明：

   PatchingDemoGameInstance.h

   ```
        protected:         // 要尝试和下载的文件块ID列表         UPROPERTY(EditDefaultsOnly, Category="Patching")         TArray<int32> ChunkDownloadList; 
   ```

   你将使用此列表保存后续你要下载的所有文件块ID。在开发设置中，你可以根据需要使用资产列表对此进行初始化。但是出于测试目的，你只需公开默认值，以便你可以使用 **蓝图编辑器** 填写它们。
5. 在 `public` 标头下，为 `PatchGame` 添加以下声明：

   PatchingDemoGameInstance.h

   ```
        public:         // 启动游戏补丁过程。如果补丁清单不是最新的，则返回false。*/         UFUNCTION(BlueprintCallable, Category = "Patching")         bool PatchGame(); 
   ```

   此函数提供了蓝图的一种公开的补丁过程启动方式。它返回布尔值指示成功还是失败。这是下载管理和其他类型异步任务中的通用模式。
6. 在 `protected` 标头下添加以下函数声明：

   PatchingDemoGameInstance.h

   ```
        protected:         // 在文件块下载进程完成时调用         void OnDownloadComplete(bool bSuccess);          // ChunkDownloader加载模式完成时调用         void OnLoadingModeComplete(bool bSuccess);          // ChunkDownloader完成挂载文件块时调用         void OnMountComplete(bool bSuccess); 
   ```

   你将使用它们响应下载过程中的异步回调。

### 处理PatchingDemoGameInstance.cpp

1. 为 `GetLoadingProgress` 函数创建以下实现：

   PatchingDemoGameInstance.cpp

   ```
        void UPatchingDemoGameInstance::GetLoadingProgress(int32& BytesDownloaded, int32& TotalBytesToDownload, float& DownloadPercent, int32& ChunksMounted, int32& TotalChunksToMount, float& MountPercent) const     {         //获取ChunkDownloader的引用         TSharedRef<FChunkDownloader> Downloader = FChunkDownloader::GetChecked();          //获取加载统计结构体         FChunkDownloader::FStats LoadingStats = Downloader->GetLoadingStats();          //获取已下载和要下载的的字节         BytesDownloaded = LoadingStats.BytesDownloaded;         TotalBytesToDownload = LoadingStats.TotalBytesToDownload;          //获取已挂载文件块数和要下载的文件块数         ChunksMounted = LoadingStats.ChunksMounted;         TotalChunksToMount = LoadingStats.TotalChunksToMount;          //使用以上统计信息计算下载和挂载百分比         DownloadPercent = ((float)BytesDownloaded / (float)TotalBytesToDownload) * 100.0f;         MountPercent = ((float)ChunksMounted / (float)TotalChunksToMount) * 100.0f;     } 
   ```
2. 为 `PatchGame` 创建以下实现：

   PatchingDemoGameInstance.cpp

   ```
        bool UPatchingDemoGameInstance::PatchGame()     {         //确保下载清单是最新的         if (bIsDownloadManifestUpToDate)         {             //获取文件块下载器             TSharedRef<FChunkDownloader> Downloader = FChunkDownloader::GetChecked();              //报告当前文件块状态             (int32 ChunkID : ChunkDownloadList)             {                 int32 ChunkStatus = static_cast<int32>(Downloader->GetChunkStatus(ChunkID));                 UE_LOG(LogTemp, Display, TEXT("Chunk %i status: %i"), ChunkID, ChunkStatus);             }              TFunction<void (bool bSuccess)> DownloadCompleteCallback = [&](bool bSuccess){OnDownloadComplete(bSuccess);};             Downloader->DownloadChunks(ChunkDownloadList, DownloadCompleteCallback, 1);              //启动加载模式             TFunction<void (bool bSuccess)> LoadingModeCompleteCallback = [&](bool bSuccess){OnLoadingModeComplete(bSuccess);};             Downloader->BeginLoadingMode(LoadingModeCompleteCallback);             return true;         }          // 我们无法联系服务器验证清单，因此你无法修补         UE_LOG(LogTemp, Display, TEXT("Manifest Update Failed.Can't patch the game"));          return false;     } 
   ```

   此函数遵循以下步骤：

   1. 首先，它检查清单是否是当前最新的。如果你尚未初始化ChunkDownloader并成功获取清单的新副本，则 `bIsDownloadManifestUpToDate` 将为false，并且此函数将返回false，表示无法开始补丁。
   2. 接下来，如果补丁过程可以继续，则该函数将获取ChunkDownloader的引用。然后，它遍历下载列表并检查每个文件块的状态。
   3. 定义了两个回调：

      - 当每个单独的文件块完成下载时，将调用

        DownloadCompleteCallback

        。当每个文件块成功下载或下载失败时，它将输出一条消息。
      - 所有文件块下载完毕后，就会触发

        LoadingModeCompleteCallback

        。
   4. 该函数调用 `FChunkDownloader::DownloadChunks` 开始下载所需文件块，这些文件块在 `ChunkDownloadList` 中列出。在调用此函数之前，必须用你想要的文件块ID填充此列表。它还传递 `DownloadCompleteCallback`。
   5. 该函数使用你先前定义的回调调用

      FChunkDownloader::BeginLoadingMode

      。

      - 加载模式将告知ChunkDownloader开始监视其下载状态。
      - 可以在不调用加载模式的情况下在后台被动下载文件块，使用它将输出下载统计信息，使你可以创建一个可以跟踪用户下载进度的UI。
      - 下载整批文件块时，你还可以使用该回调函数运行特定功能。
3. 为 `OnDownloadComplete` 和 `OnLoadingModeBegin` 函数创建以下实现：

   PatchingDemoGameInstance.cpp

   ```
        void UPatchingDemoGameInstance::OnLoadingModeComplete(bool bSuccess)     {         OnDownloadComplete(bSuccess);     }      UPatchingDemoGameInstance::OnLoadingModeComplete(bool bSuccess)     {         OnPatchComplete.Broadcast(bSuccess);     } 
   ```

   `OnLoadingModeComplete` 将传递给 `OnDownloadComplete` ，后者将在后续步骤中继续挂载文件块。`OnMountComplete` 将指示所有文件块均已完成挂载，并且内容可用。
4. 为 `OnDownloadComplete` 函数创建以下实现：

   PatchingDemoGameInstance.cpp

   ```
        void UPatchingDemoGameInstance::OnDownloadComplete(bool bSuccess)     {     if (bSuccess)         {             UE_LOG(LogTemp, Display, TEXT("Download complete"));              //获取文件块下载器             TSharedRef<FChunkDownloader> Downloader = FChunkDownloader::GetChecked();             FJsonSerializableArrayInt DownloadedChunks;              (int32 ChunkID : ChunkDownloadList)             {                 DownloadedChunks.Add(ChunkID);             }              //挂载文件块             TFunction<void(bool bSuccess)> MountCompleteCallback = [&](bool bSuccess){OnMountComplete(bSuccess);};             Downloader->MountChunks(DownloadedChunks, MountCompleteCallback);              OnPatchComplete.Broadcast(true);         }         else         {             UE_LOG(LogTemp, Display, TEXT("Load process failed"));              //调用委托             OnPatchComplete.Broadcast(false);         }     } 
   ```

   这是另一个复杂函数，你将分解其运行模式。当你的打包文件已成功下载到用户的设备上时，它将运行。

   1. 它获取ChunkDownloader的引用。
   2. 该函数设置Json数组，并用 `ChunkDownloadList` 中的信息填充它。这将用于发出你的请求。
   3. 该函数使用 `MountCompleteCallback` 输出是否已成功应用补丁。
   4. 该函数调用 `MountCompleteCallback`（使用Json列表）和 `ChunkDownloader::MountChunks` ，开始挂载已下载文件块。
   5. 如果下载成功，则该函数激活值为true的 `OnPatchComplete` 委托。如果失败，则会以 `false` 值激活。`UE_LOG` 根据故障点输出错误消息。

## 4. 设置补丁游戏模式

要启动补丁过程，你可以设置一个特定的 **关卡** 和 **游戏模式** 来调用 `PatchGame` ，并将补丁统计信息输出到界面。

1. 在虚幻编辑器中，在 **内容浏览器** 中创建新的 **蓝图（Blueprints）** 文件夹。然后，使用 **PatchingDemoGameInstance** 作为基类创建 **新蓝图** 。

   将新蓝图类命名为 **CDGameInstance** 。

   你将使用此蓝图以更轻松的方式编辑设置和追踪文件块下载过程。
2. 创建名为 **PatchingGameMode** 的新 **游戏模式** 蓝图。
3. 创建 **地图（Maps）** 文件夹，然后创建两个新关卡，分别称为 **PatchingDemoEntry** 和 **PatchingDemoTest** 。PatchingDemoEntry关卡应基于空白地图，而PatchingDemoTest关卡应基于默认地图。
4. 打开你的 **项目设置（Project Settings）** ，然后找到 **项目（Project）** > **地图和模式（Maps & Modes）** 。设置下列参数：

   ![undefined](../../../../../assets/images/25/25bb77e47929f7305403b7e2f8cac3d6a99d27e37a3a9114e963230fb557a1b3.png)

   点击查看大图。

   | ID | 参数 | 值 |
   | --- | --- | --- |
   | 1 | 游戏实例类 | CDGameInstance |
   | 2 | 编辑器启动地图 | PatchingDemoTest |
   | 3 | 游戏默认地图 | PatchingDemoEntry |
5. 在 **蓝图编辑器** 中打开 **CDGameInstance** 。在 **默认（Defaults）** 面板中，将三个条目添加到 **文件块下载列表** 中。条目值分别为 **1001** 、 **1002** 和 **1003** 。这些是你的文件块ID。

### 处理补丁游戏模式

1. 在 **蓝图编辑器** 中打开 **PatchingGameMode** ，并找到 **EventGraph** 。
2. 创建 **Get Game Instance** 节点，然后将其投射到 **CDGameInstance** 。
3. 拖动 **As CDGameInstance** 引脚，然后点击 **升级为变量（Promote to Variable）** ，创建游戏实例的引用。调用新变量 **Current Game Instance** 。
4. 拖动 **Set Current Game Instance** 的输出引脚，然后创建对 **Patch Game** 的调用。
5. 拖动 **Patch Game** 的 **返回值（Return Value）** ，然后点击 **升级为变量（Promote to Variable）** ，创建用于存储其值的布尔值。调用新变量 **Is Patching In Progress**

   ![undefined](../../../../../assets/images/12/1273b02e1d1bacb794535df7db5d866943d1157e2125d7de99a49cbd7a254a20.jpg)

   点击查看大图。
6. 创建名为 **Try Patch Count** 的整型变量，并将 **Get Try Patch Count** 节点拖动到 **图表（Graph）** 。
7. 拖动 **Get Try Patch Count** 节点的输出引脚，然后创建 **Increament Int** 节点。
8. 拖动 **Is Patching In Progress** 的输出引脚，然后创建 **Branch** 节点，将其 **False** 引脚连接到 **Increament Int** 节点。
9. 拖动 **Increament Int** 节点的输出引脚，然后创建另一个 **Branch** 节点，拖动其 **False** 引脚并创建一个 **Delay** 节点。
10. 将 **Delay** 节点的 **Complited** 引脚连接到 **Patch Game** 节点的输入引脚。
11. 创建 **Greater** 节点。将其 **A Input** 引脚连接到 **Increament Int** 节点的 **结果（Result）** 引脚。将其 **Return** 输入连接到第二个 **Branch** 节点的 **条件（Condition）** 引脚。

    ![undefined](../../../../../assets/images/98/9880497cc9dcdfb93c13a77d93f01bffa8773365682a3f6df4089881f40454cd.jpg)

    点击查看大图。
12. 拖动 **更新函数（Tick）** 事件，然后创建新的 **Branch** 节点。将 **Is Patching In Progress** 连接到其 **条件（Condition）** 输入。
13. 拖动 **Branch** 节点的 **True** 引脚，然后创建 **Print String** 节点和 **Print String** 节点，前者用于显示下载百分比，后者用于显示挂载百分比。
14. 创建 **Get Current Game Instance** 节点，然后拖动其输出引脚，并创建对 **Get Loading Progress** 的调用。
15. 从 **Get Loading Progress** 节点的 **下载百分比（Download Percent）** 引脚拖出一根引线，然后创建 **Build String (float)** 节点。
16. 在 **前缀（Prefix）** 引脚的文本字段中输入 **Current Loading Progress** ，并在 **后缀（Suffix）** 引脚的文本字段中输入 **%** 。
17. 从 **Get Loading Progress** 节点的 **挂载百分比（Mount Percent）** 引脚拖出一根引线，然后创建 **Build String (float)** 节点。
18. 在 **前缀（Prefix）** 引脚的文本字段中输入 **Current Mount Progress** ，并在 **后缀（Suffix）** 引脚的文本字段中输入 **%** 。
19. 将用于加载进度的 **Build String (Float)** 的 **Return Value** 连接到第一个 **Print String** 节点。
20. 将用于挂载进度的 **Build String (Float)** 的 **Return Value** 连接到第二个 **Print String** 节点。
21. 从 **Print String** 节点上，创建 **Branch** 节点，然后创建 **AND** 节点并将其连接到 **条件（Condition）** 引脚。
22. 创建 **Greater Equal** 节点，检查 **下载百分比（Download Percent）** 是否为 **100.0** 或更高，然后对 **挂载百分比（Mount Percent）** 执行相同的操作。将两者都连接到 **AND** 节点。如果这两个条件都为true，则使用 **打开关卡（Open Level）** 打开你的 **PatchingGameTest** 关卡。

    ![undefined](../../../../../assets/images/1c/1c5aab6a82bc7838c2a07af7aaa729e9d22268978237ef02c9e08239474d7c03.jpg)

    点击查看大图。

现在，当你的游戏运行时，它将打开入门级地图，运行ChunkDownloader，并输出文件块下载（Chunk Download）列表中文件块的下载进度和挂载进度。下载完成后，将过渡到测试地图。

> [!NOTE]
> 如果你尝试使用 **在编辑器中运行** 运行它，则下载将不会开始。你需要使用打包的版本测试ChunkDownloader。

## 5. 显示已下载内容

要显示我们的角色网格体，你需要获取它们的引用。本节将简单举例说明如何生成Actor。

1. 打开 **PatchingDemoTest** 关卡，然后打开 **关卡蓝图** 。
2. 创建名为

   网格体（Meshes）

   的新变量。

   - 对于其

     变量类型（Variable Type）

     ，选择

     骨骼网格体（Skeletal Mesh）

     。
   - 将鼠标悬停在类型列表中的条目上，然后选择

     对象引用（Object Reference）

     。
3. 点击 **网格体（Meshes）** 的 **变量类型（Variable Type）** 旁边的图标，将其更改为 **数组（Array）** 。编译你的蓝图以便应用更改。
4. 在 **网格体（Meshes）** 的 **默认值（Default Value）** 中，添加三个条目，然后为 **Boris** 、 **Crunch** 和 **Khaimera** 选择骨骼网格体。
5. 在关卡的 **EventGraph** 中，从 **BeginPlay** 事件中拖出一根引线，然后创建 **面向每个循环（For Each Loop）** ，并将其连接到 **网格体（Meshes）** 数组。
6. 拖动 **面向每个循环（For Each Loop）** 的 **数组元素（Array Element）** 引脚，然后创建 **Is Valid** 节点。
7. 创建 **Spawn Actor From Class** 节点，并将其连接到 **Is Valid** 节点的 **有效（Is Valid）** 引脚。选择 **类** 的 **骨骼网格体Actor** 。
8. 拖动 **面向每个循环（For Each Loop）** 中的 **数组元素（Array Element）** 引脚，然后创建 **Multiply** 节点。将浮点值设置为 **256** 。
9. 再创建一个

   Multiply

   节点。将上一个

   Multiply

   节点的

   返回值（Return value）

   引脚连接到已创建的

   Multiply

   节点的

   B输入值（B Input Value）

   引脚。右键点击此

   Multiply

   节点的

   B输入值（B Input Value）

   引脚并选择

   转换为（Convert to）> 向量（Vector）

   ，将

   B输入值（B Input Value）

   引脚转换为

   向量（Vector）

   。将向量的值设为

   (1.0, 0.0, 0.0)

   。

   - 每次我们遍历

     面向每个循环（For Each Loop）

     时，这将使坐标远离原点256个单位。这将在你生成网格体时为每个网格体创造一些空间。
10. 将上一步中的向量用作 **Make Transform** 节点中的 **位置（Location）** ，然后将 **返回值（Return Value）** 连接到 **Spawn Actor** 节点的 **生成变换（Spawn Transform）** 输入。
11. 拖动 **Spawn Actor** 节点的 **返回值（Return Value）** 引脚，然后获取其 **骨骼网格体组件（Skeletal Mesh Component）** 的引用。用其调用 **Set Skeletal Mesh** 。
12. 拖动 **For Each Loop** 节点的 **数组元素（Array Element）** 引脚，将此节点的输出连接到 **Set Skeletal Mesh** 的 **新网格体（New Mesh）** 输入引脚。

    ![undefined](../../../../../assets/images/1d/1d251a571fa1a5ab330d5bd1a8f40d726461cf05635f336a3d4660378058eeea.jpg)

    点击查看大图。
13. 将关卡内的 **玩家出生点** 移动到 **(256.0, 800.0, 100.0)** 。

    ![undefined](../../../../../assets/images/29/290e6b47e57a8672ff283e20498fa0c57902864b1b22564e9010249606d84a82.jpg)

    点击查看大图。
14. 保存进度并编译蓝图。

关卡加载时，将生成每个角色的骨骼网格体。如果对象引用不起作用，则每个角色的文件块尚未挂载，它们的资产将不可用，并且它们将不会生成。

## 6.测试游戏

最后，你需要在独立版本中测试你的项目。Pak挂载不能在PIE模式下运行，因此这是测试补丁功能的必要步骤。

1. 打包项目。
2. 将打包文件和清单复制到 **IIS测试网站** 上相应的文件夹中。
3. 确保IIS进程和网站都正在运行。
4. 运行打包的可执行文件。

## 最终结果

你应该看到一个黑色界面，界面左上方显示补丁输出，然后，当补丁和挂载状态都达到100%时，你的游戏应加载到默认地图中，并显示Boris、Crunch和Khaimera。如果补丁或挂载过程出现问题，则不会显示这些内容。

## 自行尝试

可以执行几个步骤来细化你的文件块下载方案：

- 编译在加载模式下显示的UI，并显示进度条和播放器提示。
- 编译UI错误提示，例如超时和安装失败。
- 创建PrimaryAssetLabel的自定义子类，以包含资产相关的其他元数据。例如，《战争破坏者》（Battle Breakers）的自定义PrimaryAssetLabel类包括一个父文件块，必须加载该父文件块，这是使用当前文件块的先决条件。
