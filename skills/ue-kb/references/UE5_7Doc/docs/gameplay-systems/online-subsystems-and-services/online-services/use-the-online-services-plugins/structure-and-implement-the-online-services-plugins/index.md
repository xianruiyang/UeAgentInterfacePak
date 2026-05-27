---
title: "构造和实现在线服务插件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/structure-and-implement-the-online-services-plugins-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "在线服务", "使用在线服务插件", "构造和实现在线服务插件"]
---

# 构造和实现在线服务插件

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 在线服务 / 使用在线服务插件 / 构造和实现在线服务插件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/structure-and-implement-the-online-services-plugins-in-unreal-engine

## 概述

### 本页面介绍的内容

本页面将指导你在游戏中构造和实现一些在线服务功能。本教程不会指导你实现在线服务插件支持的每个接口，而是实现更简单的接口，即在线服务作品文件接口，它演示了在线服务插件的常见编程模式。本页面将指导你：

1. 从在线服务获取关于本地玩家的信息。
2. 从后端服务检索作品文件。
3. 在游戏中显示作品文件内容。

> [!NOTE]
> 本指南使用标题为 **OnlineSample** 的项目和 **在线服务Null（Online Services Null）** 插件。

### 开始之前

确保你已启用并配置了在线服务插件以在游戏中使用。如果你还没有这样做，请查看[设置和配置在线服务插件](../setup-and-configure-the-online-services-plugins/index.md)文档页面。

### 你需要怎么做

首先，你要检索当前登录的本地玩家的信息。此本地玩家的账号ID将被用作其他所有在线服务插件操作的参数。了解如何获取此信息后，你就可以执行其他所有在线服务函数。本指南使用在线服务Null插件。用户会自动注册Null服务，所以不需要调用登录函数。因此，你不需要发起显式登录调用，但确实需要从在线服务获取关于本地用户的在线信息。

接下来，从后端在线服务检索作品文件。由于此教程使用在线服务Null插件，作品文件及其内容会被添加到[引擎配置](../../../../../cpp-programming/programming-in-the-unreal-engine-architecture/configuration-files/index.md)。作品文件接口将负责从后端在线服务查询和读取作品文件。

最后，你要在屏幕上显示作品文件。这是文件已成功检索的视觉确认。

## 配置

如前所述，本指南使用在线服务Null插件。此插件旨在测试和调试在线服务实现。Null服务不提供后端服务来存储作品文件。因此，此存储是使用引擎配置模拟的。

要将作品文件添加到Null插件，请执行以下步骤：

1. 在Visual Studio中打开你的项目。为此，你可以从虚幻编辑器中找到

   工具（Tools）> 打开Visual Studio（Open Visual Studio）

   。
2. 在Visual Studio解决方案浏览器中找到

   游戏（Games）> [YOUR_GAME] > 配置（Config）> DefaultEngine.ini

   ，打开你的项目的

   DefaultEngine.ini

   文件。
3. 将以下内容添加到你的项目的 `DefaultEngine.ini` 文件：

   DefaultEngine.ini

   ```
    ; Null Platform Configuration [OnlineServices.Null.TitleFile] +Files=(Name=StatusFile, Contents="Explore this virtual world with me!")
   ```

## 结构

### 添加游戏实例

要使用在线服务插件功能，你需要创建C++类来实现你想使用的在线服务。本教程使用 **游戏实例（Game Instance）** 类。大部分游戏框架类会在关卡或地图之间重新实例化。这意味着游戏框架类中包含的信息会在关卡或地图之间重置或丢失。而游戏实例及其子系统在游戏从初始化到关闭的整个生命周期内持久存在。因此，它们可以充当持久结构，帮助你在不同地图或关卡之间传递信息。在此操作说明中，游戏实例类名为 **OnlineSampleGameInstance** 。

要添加游戏实例类，请通过虚幻编辑器中的[C++类向导](../../../../../cpp-programming/setting-up-your-development-environment-for-cplusplus/using-the-cplusplus-class-wizard/index.md)，使用以下信息创建新的C++类：

- 类：

  游戏实例
- 名称：

  OnlineSampleGameInstance
- 路径：

  ../OnlineSample/Source/OnlineSample/GameInstance

虚幻编辑器会将新类添加到你的虚幻引擎项目代码并初始化[**实时编码（Live Coding）**](../../../../../cpp-programming/setting-up-your-development-environment-for-cplusplus/using-live-coding-to-recompile-unreal-engine-ap-74541679/index.md)。这会重新编译你的Visual Studio代码，以便你的新类在虚幻编辑器仍打开时显示。你的新 `.cpp` 和 `.h` 文件也应该在Visual Studio中打开，你随时可以将代码添加到新类文件。

> [!NOTE]
> Visual Studio中可能会显示弹出窗口，称解决方案文件已更新，并且项目需要重新加载。选择"全部重新加载（Reload All）"以在Visual Studio中重新加载你的项目。如果你的编译由于系统无法打开包含文件"GameInstance/OnlineSampleGameInstance.h"，请转至你的"OnlineSampleGameInstance.cpp"并编辑以下行：
>
> ```
> #include "GameInstance/OnlineSampleGameInstance.h"
> ```
>
> 为：
>
> ```
> #include "OnlineSample/GameInstance/OnlineSampleGameInstance.h"
> ```
>
> 其中 `OnlineSample` 是你的项目的名称。更改此项后，请返回虚幻编辑器，并使用实时编码重新编译你的项目。你的项目现在应该会正确找到头文件并成功编译。

#### 指定你的项目的游戏实例类

为你的项目创建游戏实例类后，你需要指示引擎使用新创建的游戏实例类，而不是默认类。

要指定你的项目的游戏实例类，请执行以下步骤：

1. 找到虚幻编辑器。
2. 在菜单栏中选择

   编辑（Edit）> 项目设置（Project Settings）

   。
3. 在左侧，选择

   项目（Project）> 地图和模式（Maps & Modes）

   。
4. 找到

   游戏实例（Game Instance）

   分段，选择你在上面的

   添加游戏实例

   小节中创建的

   游戏实例类（Game Instance Class）

   。如果你使用了与本指南相同的名称，请选择

   OnlineSampleGameInstance

   。

你的项目现在将默认使用你的自定义游戏实例类。

### 添加游戏实例子系统

此操作说明使用 **游戏实例子系统（Game Instance Subsystem）** 整理游戏实例结构中的在线代码。编程子系统可帮助你将代码整理为模块化系统，每个有特定的关注点。

要添加游戏实例子系统类，请通过虚幻编辑器中的[C++类向导](../../../../../cpp-programming/setting-up-your-development-environment-for-cplusplus/using-the-cplusplus-class-wizard/index.md)，使用以下信息创建新的C++类：

- 类：

  游戏实例子系统
- 名称：

  OnlineSampleOnlineSubsystem
- 路径：

  ../OnlineSample/Source/OnlineSample/GameInstance

虚幻编辑器会将新类添加到你的虚幻引擎项目代码，初始化实时编码，并重新编译你的项目。

### 添加玩家控制器

**玩家控制器（Player Controller）** 类是在游戏代码中玩游戏的自然人的抽象。此类提供了 `BeginPlay` 函数，用于在游戏中调用在线用户注册和标题文件读取。

要添加玩家控制器类，请通过用虚幻编辑器中的[C++类向导](../../../../../cpp-programming/setting-up-your-development-environment-for-cplusplus/using-the-cplusplus-class-wizard/index.md)，使用以下信息创建新的C++类：

- 类：

  玩家控制器
- 名称：

  OnlineSamplePlayerController
- 路径：

  ../OnlineSample/Source/OnlineSample/Player

与之前一样，虚幻编辑器会将新类添加到你的虚幻引擎项目代码，初始化 **实时编码（Live Coding）** ，并重新编译你的项目。

## 添加代码

现在你已设置了项目的结构和所需的各种文件，下一步是实现功能。本小节的一些分段将为你在[构造你的项目](#%E6%9E%84%E9%80%A0%E4%BD%A0%E7%9A%84%E9%A1%B9%E7%9B%AE)小节中创建的每个C++类列举头文件和源文件的示例代码，还有一些分段将讲解如何编辑现有项目文件。

这些文件包含代码注释、日志记录和错误处理，可帮助你详细了解涉及的对象，在日志中跟踪活动和问题，并诊断错误。

> [!TIP]
> 如果你使用实时编码，并在实时编码控制台中收到显示"编译失败"的日志消息，又无法诊断失败原因，可尝试关闭虚幻编辑器并改为使用Visual Studio编译。

### 游戏实例

游戏实例及其子系统在游戏从初始化到关闭的整个生命周期内持久存在。这意味着，从游戏初始化到关闭，都存在相同的游戏实例对象和子系统对象及其函数和字段。这很适合用于存放在线服务插件功能，因为你可能需要访问在线功能——无论是在UI菜单中、在单人模式中与好友聊天时，还是在多人模式中通过在线会话加入其他用户。游戏实例还充当了游戏实例子系统的管理器。尤其是，游戏实例充当了此教程中实现的在线服务游戏实例子系统（ `OnlineSampleOnlineSubsystem` ）的管理器。

#### OnlineSampleGameInstance.h

OnlineSampleGameInstance.h

```
	#pragma once 	#include "CoreMinimal.h"	#include "Engine/GameInstance.h"	#include "OnlineSampleGameInstance.generated.h" 	// 前置声明类	class AOnlineSamplePlayerController;	class UObject; 	DECLARE_LOG_CATEGORY_EXTERN(LogGameInstance, Log, All); 	/**	* 用于管理游戏实例子系统的自定义游戏实例类	*/	UCLASS()	class ONLINESAMPLE_API UOnlineSampleGameInstance : public UGameInstance	{ 		GENERATED_BODY() 	protected: 		/** 在游戏启动时调用以初始化游戏实例 */		virtual void Init() override;		/** 在游戏退出时调用以关闭游戏实例 */		virtual void Shutdown() override; 	public: 		/** 调用以初始化游戏实例对象 */		UOnlineSampleGameInstance(const FObjectInitializer& ObjectInitializer = FObjectInitializer::Get());		/** 调用以检索主玩家控制器 */		AOnlineSamplePlayerController* GetPrimaryPlayerController() const;	};
```

#### OnlineSampleGameInstance.cpp

OnlineSampleGameInstance.cpp

```
#include "OnlineSampleGameInstance.h"#include "OnlineSample/Player/OnlineSamplePlayerController.h" DEFINE_LOG_CATEGORY(LogGameInstance); /// <summary>/// 初始化游戏实例对象/// </summary>void UOnlineSampleGameInstance::Init(){	UE_LOG(LogGameInstance, Log, TEXT("OnlineSampleGameInstance initialized."));	Super::Init();} /// <summary>/// 关闭游戏实例对象/// </summary>void UOnlineSampleGameInstance::Shutdown(){	UE_LOG(LogGameInstance, Log, TEXT("OnlineSampleGameInstance shutdown."));	Super::Shutdown();} /// <summary>/// 初始化游戏实例对象/// </summary>/// <param name="ObjectInitializer"></param>UOnlineSampleGameInstance::UOnlineSampleGameInstance(const FObjectInitializer& ObjectInitializer)	: Super(ObjectInitializer){ } /// <summary>/// 检索主玩家控制器的引用/// </summary>/// <returns>AOnlineSamplePlayerController pointer</returns>AOnlineSamplePlayerController* UOnlineSampleGameInstance::GetPrimaryPlayerController() const{	return Cast<AOnlineSamplePlayerController>(Super::GetPrimaryPlayerController(false));}
```

### 游戏实例子系统

在线服务插件功能的所有实现细节都存放在游戏实例子系统中。如前所述，游戏实例在游戏从初始化到关闭的整个生命周期内持久存在。游戏实例子系统有助于将你可能需要在游戏实例整个生命周期内访问的代码整理为多个不同的系统。此项目会将在线服务插件相关代码整理到名为"OnlineSampleOnlineSubsystem"的游戏实例子系统中。此示例实现了[作品文件接口](https://dev.epicgames.com/documentation/404)功能。

#### 实现细节

在线服务插件在 `OnlineSampleOnlineSubsystem` 中包含此页面实现的常见模式：

##### 查询和获取

在线服务插件中的一个常见模式是首先 *查询* 接口获得信息。此信息接着会使用接口缓存，然后，当你想检索此信息时，会从缓存 *获取* 信息。该查询由查询和获取这两个异步操作构成。`OnlineSampleOnlineSubsystem` 示例代码中有此模式的一些不同示例。尤其是，你可以查看：

- RetrieveTitleFile

  及其对

  HandleEnumerateFiles

  的调用

#### OnlineSampleOnlineSubsystem.h

OnlineSampleOnlineSubsystem.h

```
#pragma once #include "CoreMinimal.h" #include "Online/OnlineServices.h"#include "Online/OnlineAsyncOpHandle.h"#include "Online/TitleFile.h"#include "Subsystems/GameInstanceSubsystem.h" #include "OnlineSampleOnlineSubsystem.generated.h" DECLARE_LOG_CATEGORY_EXTERN(LogOnlineSampleOnlineSubsystem, Log, All); /** *  */UCLASS()class ONLINESAMPLE_API UOnlineSampleOnlineSubsystem : public UGameInstanceSubsystem{ 	GENERATED_BODY() public: 	////////////////////////////////////////////////////////	/// OnlineSampleOnlineSubsystem Init/Deinit  	/** 调用以确定是否应该创建子系统 */	virtual bool ShouldCreateSubsystem(UObject* Outer) const override; 	/** 调用以初始化游戏实例子系统 */	virtual void Initialize(FSubsystemCollectionBase& Collection) override; 	/** 调用以取消初始化游戏实例子系统 */	virtual void Deinitialize() override; 	/** 调用以向游戏实例子系统注册本地在线用户 */	void RegisterLocalOnlineUser(FPlatformUserId PlatformUserId); 	/** 调用以检索此平台用户ID的在线用户信息 */	TObjectPtr<UOnlineUserInfo> GetOnlineUserInfo(FPlatformUserId PlatformUserId); 	/** 调用以从后端服务读取游戏的作品文件并返回内容 */	FString ReadTitleFile(FString Filename, FPlatformUserId PlatformUserId); protected: 	struct FOnlineServicesInfo 	{		/** 在线服务指针 - 通过此指针访问接口 */		UE::Online::IOnlineServicesPtr OnlineServices = nullptr; 		/** 接口指针 */		UE::Online::IAuthPtr AuthInterface = nullptr;		UE::Online::ITitleFilePtr TitleFileInterface = nullptr; 		/** 在线服务实现 */		UE::Online::EOnlineServices OnlineServicesType = UE::Online::EOnlineServices::None; 		/** 作品文件内容 */		UE::Online::FTitleFileContents TitleFileContent; 		/** 将结构体重置为初始设置 */		void Reset()		{			OnlineServices.Reset();			AuthInterface.Reset();			TitleFileInterface.Reset();			OnlineServicesType = UE::Online::EOnlineServices::None;		}	}; 	////////////////////////////////////////////////////////	// 在线服务初始化 	/** 包含相关在线服务指针的内部结构体的指针 */	FOnlineServicesInfo* OnlineServicesInfoInternal = nullptr; 	/** 调用以初始化在线服务和接口指针 */	void InitializeOnlineServices(); 	////////////////////////////////////////////////////////	// 作品文件 	/** 调用以从在线服务检索作品文件 */	void RetrieveTitleFile(FString Filename, FPlatformUserId PlatformUserId); 	////////////////////////////////////////////////////////	/// 事件 	/** 调用以处理EnumerateFiles异步事件 */	void HandleEnumerateFiles(const UE::Online::TOnlineResult<UE::Online::FTitleFileEnumerateFiles>& EnumerateFilesResult, TObjectPtr<UOnlineUserInfo> OnlineUser, FString Filename); 	/** 调用以处理ReadFile异步事件 */	void HandleReadFile(const UE::Online::TOnlineResult<UE::Online::FTitleFileReadFile>& ReadFileResult, FString Filename); 	////////////////////////////////////////////////////////    /// 在线用户信息 	/** 调用以为此用户创建UOnlineUserInfo对象 */	TObjectPtr<UOnlineUserInfo> CreateOnlineUserInfo(int32 LocalUserIndex, FPlatformUserId PlatformUserId, UE::Online::FAccountId AccountId, UE::Online::EOnlineServices Services);		/** 调用以向OnlineUserInfos地图注册用户并在使用CreateOnlineUserInfo创建之后添加用户 */	TObjectPtr<UOnlineUserInfo> CreateAndRegisterUserInfo(int32 LocalUserIndex, FPlatformUserId PlatformUserId, UE::Online::FAccountId AccountId, UE::Online::EOnlineServices Services); 	/** 关于每个本地用户的信息 */	TMap<FPlatformUserId, TObjectPtr<UOnlineUserInfo>> OnlineUserInfos; 	/** 将UOnlineUserInfo类加为好友以访问它 */	friend UOnlineUserInfo;}; UCLASS()class ONLINESAMPLE_API UOnlineUserInfo : public UObject{ 	GENERATED_BODY() public: 	UOnlineUserInfo(); 	////////////////////////////////////////////////////////    /// 在线用户字段 	int32 LocalUserIndex = -1;	FPlatformUserId PlatformUserId;	UE::Online::FAccountId AccountId;	UE::Online::EOnlineServices Services = UE::Online::EOnlineServices::None; 	////////////////////////////////////////////////////////	/// 在线用户日志记录/调试函数 	/** 调用以获取OnlineUserInfo字符串 */	const FString DebugInfoToString(); 	friend UOnlineSampleOnlineSubsystem;};
```

#### OnlineSampleOnlineSubsystem.cpp

OnlineSampleOnlineSubsystem.cpp

```
#include "OnlineSampleOnlineSubsystem.h" #include "Online/CoreOnline.h"#include "Online/OnlineResult.h"#include "Online/OnlineAsyncOpHandle.h"#include "Online/OnlineError.h"#include "Online/OnlineServices.h"#include "Online/Auth.h"#include "Online/TitleFile.h" DEFINE_LOG_CATEGORY(LogOnlineSampleOnlineSubsystem); /// <summary>/// 是否创建此子系统。简便起见，子系统仅///		在客户端和独立游戏上创建，而不在服务器上创建。此函数///		常用于将子系统的创建限制到服务器或客户端。///		务必在使用之前对子系统进行null检查！/// </summary>/// <param name="Outer"></param>/// <returns>布尔值，是否创建此子系统</returns>bool UOnlineSampleOnlineSubsystem::ShouldCreateSubsystem(UObject* Outer) const{#if UE_SERVER	return false;#else	return Super::ShouldCreateSubsystem(Outer);#endif} /// <summary>/// 初始化游戏实例后调用了Initialize/// </summary>/// <param name="Collection">游戏实例初始化的子系统集合</param>void UOnlineSampleOnlineSubsystem::Initialize(FSubsystemCollectionBase& Collection){	UE_LOG(LogTemp, Log, TEXT("OnlineSampleOnlineSubsystem initialized."));	Super::Initialize(Collection); 	// 初始化在线服务	InitializeOnlineServices();} /// <summary>/// 取消初始化/关闭游戏实例后调用了Deinitialize/// </summary>void UOnlineSampleOnlineSubsystem::Deinitialize(){	UE_LOG(LogTemp, Log, TEXT("OnlineSampleOnlineSubsystem deinitialized.")); 	// 取消绑定事件句柄并重置结构体信息	OnlineServicesInfoInternal->Reset(); 	// 取消初始化父类	Super::Deinitialize();} /// <summary>/// 处理异步EnumerateFiles函数。记录是否有失败。///		成功会调用HandleReadFile处理的异步ReadFile函数。/// </summary>/// <param name="EnumerateFilesResult">EnumerateFiles尝试的结果</param>/// <param name="OnlineUser">查询作品文件的用户</param>/// <param name="Filename">查询的文件用户的名称</param>void UOnlineSampleOnlineSubsystem::HandleEnumerateFiles(const UE::Online::TOnlineResult<UE::Online::FTitleFileEnumerateFiles>& EnumerateFilesResult, TObjectPtr<UOnlineUserInfo> OnlineUser, FString Filename){	using namespace UE::Online; 	if (EnumerateFilesResult.IsOk())	{		FTitleFileGetEnumeratedFiles::Params GetParams;		GetParams.LocalAccountId = OnlineUser->AccountId; 		TOnlineResult<FTitleFileGetEnumeratedFiles> GetResult = OnlineServicesInfoInternal->TitleFileInterface->GetEnumeratedFiles(MoveTemp(GetParams));		if (GetResult.IsOk())		{			FTitleFileGetEnumeratedFiles::Result& CachedFiles = GetResult.GetOkValue();			int32 FileIndex = CachedFiles.Filenames.Find(Filename);			if (FileIndex == INDEX_NONE)			{				UE_LOG(LogOnlineSampleOnlineSubsystem, Error, TEXT("Title File \"%s\" not found!"), *Filename);			}			else			{				FTitleFileReadFile::Params ReadParams;				ReadParams.LocalAccountId = OnlineUser->AccountId;				ReadParams.Filename = Filename; 				OnlineServicesInfoInternal->TitleFileInterface->ReadFile(MoveTemp(ReadParams)).OnComplete(this, &ThisClass::HandleReadFile, Filename);			}		}		else		{			UE_LOG(LogOnlineSampleOnlineSubsystem, Error, TEXT("Get Title File Error: %s"), *GetResult.GetErrorValue().GetLogString());		}	}	else	{		UE_LOG(LogOnlineSampleOnlineSubsystem, Error, TEXT("Enum Title File Error: %s"), *EnumerateFilesResult.GetErrorValue().GetLogString());	}} /// <summary>/// 处理异步ReadFile函数。记录是否有失败。///		成功会填充用户的TitleFileContent。/// </summary>/// <param name="ReadFileResult">ReadFile尝试的结果</param>/// <param name="Filename">要读取的文件的名称</param>void UOnlineSampleOnlineSubsystem::HandleReadFile(const UE::Online::TOnlineResult<UE::Online::FTitleFileReadFile>& ReadFileResult, FString Filename){	using namespace UE::Online; 	if (ReadFileResult.IsOk())	{		const FTitleFileReadFile::Result& ReadFileResultValue = ReadFileResult.GetOkValue();		OnlineServicesInfoInternal->TitleFileContent = *ReadFileResultValue.FileContents;	}	else	{		UE_LOG(LogOnlineSampleOnlineSubsystem, Error, TEXT("Read Title File Error: %s"), *ReadFileResult.GetErrorValue().GetLogString());	}} /// <summary>/// 初始化在线服务：///		获取服务的指针///		获取接口的指针///		添加事件句柄///		检查指针有效性/// </summary>void UOnlineSampleOnlineSubsystem::InitializeOnlineServices(){	OnlineServicesInfoInternal = new FOnlineServicesInfo(); 	// 初始化服务指针	OnlineServicesInfoInternal->OnlineServices = UE::Online::GetServices();	check(OnlineServicesInfoInternal->OnlineServices.IsValid()); 	// 验证服务类型	OnlineServicesInfoInternal->OnlineServicesType = OnlineServicesInfoInternal->OnlineServices->GetServicesProvider();	if (OnlineServicesInfoInternal->OnlineServices.IsValid())	{		// 初始化接口指针		OnlineServicesInfoInternal->AuthInterface = OnlineServicesInfoInternal->OnlineServices->GetAuthInterface();		check(OnlineServicesInfoInternal->AuthInterface.IsValid()); 		OnlineServicesInfoInternal->TitleFileInterface = OnlineServicesInfoInternal->OnlineServices->GetTitleFileInterface();		check(OnlineServicesInfoInternal->TitleFileInterface.IsValid());	}	else {		UE_LOG(LogOnlineSampleOnlineSubsystem, Error, TEXT("Error: Failed to initialize services."));	}} /// <summary>/// EnumerateFiles、GetEnumeratedFiles和ReadFile。此实现使用lambda函数///		来处理OnComplete回调。/// </summary>/// <param name="Filename">要读取的文件</param>/// <param name="PlatformUserId">要为其检索文件的用户</param>void UOnlineSampleOnlineSubsystem::RetrieveTitleFile(FString Filename, FPlatformUserId PlatformUserId){	using namespace UE::Online; 	FTitleFileEnumerateFiles::Params EnumParams;	FAccountId LocalAccountId;	TObjectPtr<UOnlineUserInfo> OnlineUser;	if (OnlineUserInfos.Contains(PlatformUserId))	{		OnlineUser = *OnlineUserInfos.Find(PlatformUserId);		LocalAccountId = OnlineUser->AccountId;		EnumParams.LocalAccountId = LocalAccountId;		if (OnlineServicesInfoInternal->TitleFileInterface.IsValid())		{			(OnlineServicesInfoInternal->TitleFileInterface)->EnumerateFiles(MoveTemp(EnumParams)).OnComplete(this, &ThisClass::HandleEnumerateFiles, OnlineUser, Filename);		}		else		{			UE_LOG(LogOnlineSampleOnlineSubsystem, Error, TEXT("Title File Interface pointer invalid."));		}	}	else	{		UE_LOG(LogOnlineSampleOnlineSubsystem, Error, TEXT("Could not find user with Platform User Id: %d"), PlatformUserId.GetInternalId());	}} /// <summary>/// 向本地注册表OnlineUserInfos注册在线用户/// </summary>/// <param name="PlatformUserId">要注册的用户的平台用户ID</param>void UOnlineSampleOnlineSubsystem::RegisterLocalOnlineUser(FPlatformUserId PlatformUserId){	using namespace UE::Online; 	FAuthGetLocalOnlineUserByPlatformUserId::Params GetUserParams;	GetUserParams.PlatformUserId = PlatformUserId;	if (OnlineServicesInfoInternal->AuthInterface.IsValid())	{		TOnlineResult<FAuthGetLocalOnlineUserByPlatformUserId> AuthGetResult = OnlineServicesInfoInternal->AuthInterface->GetLocalOnlineUserByPlatformUserId(MoveTemp(GetUserParams)); 		if (AuthGetResult.IsOk())		{			FAuthGetLocalOnlineUserByPlatformUserId::Result& LocalOnlineUser = AuthGetResult.GetOkValue();			TSharedRef<FAccountInfo> UserAccountInfo = LocalOnlineUser.AccountInfo;			FAccountInfo UserAccountInfoContent = *UserAccountInfo;			if (!OnlineUserInfos.Contains(UserAccountInfoContent.PlatformUserId))			{				UOnlineUserInfo* NewUser = CreateAndRegisterUserInfo(UserAccountInfoContent.AccountId.GetHandle(), PlatformUserId, UserAccountInfoContent.AccountId, UserAccountInfoContent.AccountId.GetOnlineServicesType()); 				UE_LOG(LogOnlineSampleOnlineSubsystem, Log, TEXT("Local User Registered: %s"), *(NewUser->DebugInfoToString()));			}			else			{				UE_LOG(LogOnlineSampleOnlineSubsystem, Log, TEXT("Local User with platform user id %d already registered."), PlatformUserId.GetInternalId());			}		}		else		{			FOnlineError ErrorResult = AuthGetResult.GetErrorValue();			UE_LOG(LogOnlineSampleOnlineSubsystem, Error, TEXT("Get Local Online User Error: %s"), *ErrorResult.GetLogString());		}	}	else	{		UE_LOG(LogOnlineSampleOnlineSubsystem, Error, TEXT("Auth Interface pointer invalid."));	}} /// <summary>/// 获取作品文件并读取其内容。/// </summary>/// <param name="Filename">要读取的文件</param>/// <param name="PlatformUserId">要为其读取文件的用户</param>/// <returns>带有Filename的内容的FileString</returns>FString UOnlineSampleOnlineSubsystem::ReadTitleFile(FString Filename, FPlatformUserId PlatformUserId){	using namespace UE::Online; 	RetrieveTitleFile(Filename, PlatformUserId);	FTitleFileContents FileContents = OnlineServicesInfoInternal->TitleFileContent;	FString FileString = FString(FileContents.Num(), UTF8_TO_TCHAR(FileContents.GetData()));	UE_LOG(LogOnlineSampleOnlineSubsystem, Log, TEXT("Reading Title File: %s"), *Filename);	return FileString;} /// <summary>/// 利用给定信息创建UOnlineUserInfo对象。/// </summary>/// <param name="LocalUserIndex"></param>/// <param name="PlatformUserId"></param>/// <param name="AccountId"></param>/// <param name="Services">用户注册了的在线服务</param>/// <returns>NewUser的对象指针</returns>TObjectPtr<UOnlineUserInfo> UOnlineSampleOnlineSubsystem::CreateOnlineUserInfo(int32 LocalUserIndex, FPlatformUserId PlatformUserId, UE::Online::FAccountId AccountId, UE::Online::EOnlineServices Services){	TObjectPtr<UOnlineUserInfo> NewUser = NewObject<UOnlineUserInfo>(this);	NewUser->LocalUserIndex = LocalUserIndex;	NewUser->PlatformUserId = PlatformUserId;	NewUser->AccountId = AccountId;	NewUser->Services = Services;	return NewUser;} /// <summary>/// 调用CreateOnlineUserInfo来创建UOnlineUserInfo对象，然后/// 向本地注册表OnlineUserInfos注册用户/// </summary>/// <param name="LocalUserIndex"></param>/// <param name="PlatformUserId"></param>/// <param name="AccountId"></param>/// <param name="Services">用户注册了的在线服务</param>/// <returns>NewUser的对象指针</returns>TObjectPtr<UOnlineUserInfo> UOnlineSampleOnlineSubsystem::CreateAndRegisterUserInfo(int32 LocalUserIndex, FPlatformUserId PlatformUserId, UE::Online::FAccountId AccountId, UE::Online::EOnlineServices Services){	TObjectPtr<UOnlineUserInfo> NewUser = CreateOnlineUserInfo(LocalUserIndex, PlatformUserId, AccountId, Services);	OnlineUserInfos.Add(PlatformUserId, NewUser);	return NewUser;} /// <summary>/// 为提供的平台用户ID获取UOnlineUserInfo。/// </summary>/// <param name="PlatformUserId">要检索的用户的ID</param>/// <returns>OnlineUser的对象指针</returns>TObjectPtr<UOnlineUserInfo> UOnlineSampleOnlineSubsystem::GetOnlineUserInfo(FPlatformUserId PlatformUserId){	TObjectPtr<UOnlineUserInfo> OnlineUser;	if (OnlineUserInfos.Contains(PlatformUserId))	{		OnlineUser = *OnlineUserInfos.Find(PlatformUserId);	}	else	{		UE_LOG(LogOnlineSampleOnlineSubsystem, Error, TEXT("Could not find user with Platform User Id: %d"), PlatformUserId.GetInternalId());		OnlineUser = nullptr;	}	return OnlineUser;} /// <summary>/// UOnlineUserInfo对象的构造函数/// </summary>UOnlineUserInfo::UOnlineUserInfo(){ } /// <summary>/// 返回UOnlineUserInfo的调试字符串/// </summary>/// <returns>UOnlineUserInfo的字符串表示</returns>const FString UOnlineUserInfo::DebugInfoToString(){	int32 UserIndex = this->LocalUserIndex;	int32 PlatformId = this->PlatformUserId;	TArray<FStringFormatArg> FormatArgs;	FormatArgs.Add(FStringFormatArg(UserIndex));	FormatArgs.Add(FStringFormatArg(PlatformId));	return FString::Format(TEXT("LocalUserNumber: {0}, PlatformUserId: {1}"), FormatArgs);}
```

### 玩家控制器

玩家控制器类是你向在线服务注册玩家并从后端服务读取作品文件的地方。

#### OnlineSamplePlayerController.h

OnlineSamplePlayerController.h

```
#pragma once #include "CoreMinimal.h"#include "GameFramework/PlayerController.h"#include "OnlineSamplePlayerController.generated.h" /** *  */UCLASS()class ONLINESAMPLE_API AOnlineSamplePlayerController : public APlayerController{	GENERATED_BODY() public: 	AOnlineSamplePlayerController(); protected: 	/** 运行开始时调用 */	virtual void BeginPlay(); 	/** 运行结束时调用 */	virtual void EndPlay(EEndPlayReason::Type EndReason);};
```

#### OnlineSamplePlayerController.cpp

OnlineSamplePlayerController.cpp

```
#include "OnlineSamplePlayerController.h"#include "OnlineSample/GameInstance/OnlineSampleGameInstance.h"#include "OnlineSample/GameInstance/OnlineSampleOnlineSubsystem.h" AOnlineSamplePlayerController::AOnlineSamplePlayerController(){ } void AOnlineSamplePlayerController::BeginPlay(){	Super::BeginPlay(); 	////////////////////////////////////////////////	/// 在线服务  	// 向在线服务注册此玩家	UOnlineSampleGameInstance* GameInstance = Cast<UOnlineSampleGameInstance>(GetWorld()->GetGameInstance());	UOnlineSampleOnlineSubsystem* OnlineSubsystem = GameInstance->GetSubsystem<UOnlineSampleOnlineSubsystem>();	ULocalPlayer* LocalPlayer = Super::GetLocalPlayer();	if (LocalPlayer)	{		FPlatformUserId LocalPlayerPlatformUserId = LocalPlayer->GetPlatformUserId();		if (OnlineSubsystem) // 在访问之前对子系统进行null检查		{			UE_LOG(LogOnlineSampleOnlineSubsystem, Log, TEXT("Registering PlatformUserId: %d"), LocalPlayerPlatformUserId.GetInternalId());			OnlineSubsystem->RegisterLocalOnlineUser(LocalPlayerPlatformUserId); 			// 读取作品文件并在屏幕上显示内容			FString TitleFileContent = OnlineSubsystem->ReadTitleFile(FString("StatusFile"), LocalPlayerPlatformUserId);			if (GEngine)			{				GEngine->AddOnScreenDebugMessage(-1, 10, FColor::Black, TitleFileContent);			}		}	} 	///////////////////////////////////////////////	/// 下一个分段...} void AOnlineSamplePlayerController::EndPlay(EEndPlayReason::Type EndReason){	Super::EndPlay(EndReason);}
```

### 编辑游戏模式

你还需要编辑标题为 `<PROJECT_NAME>GameMode.cpp` 的游戏模式源文件，以便使用你在之前小节中创建的玩家控制器类。

OnlineSampleGameMode.cpp

```
// 版权所有Epic Games, Inc.保留所有权利。 #include "OnlineSampleGameMode.h"#include "Player/OnlineSamplePlayerController.h"#include "OnlineSampleCharacter.h"#include "UObject/ConstructorHelpers.h" AOnlineSampleGameMode::AOnlineSampleGameMode(){	//将默认Pawn类设置为已绘制蓝图的角色	static ConstructorHelpers::FClassFinder<APawn> PlayerPawnBPClass(TEXT("/Game/ThirdPerson/Blueprints/BP_ThirdPersonCharacter"));	if (PlayerPawnBPClass.Class != NULL)	{		DefaultPawnClass = PlayerPawnBPClass.Class;	} 	// 分配我们的新玩家控制器类	PlayerControllerClass = AOnlineSamplePlayerController::StaticClass();}
```

## 编译

现在你可以开始编译项目。如果你从虚幻编辑器中打开了Visual Studio，你可以使用[实时编码](../../../../../cpp-programming/setting-up-your-development-environment-for-cplusplus/using-live-coding-to-recompile-unreal-engine-ap-74541679/index.md)来编译你的项目的C++，并在虚幻编辑器中立即开始游戏。如果虚幻编辑器已关闭，请使用Visual Studio编译你的项目。如需更多信息，请参阅[在虚幻引擎中编译游戏项目](../../../../../cpp-programming/setting-up-your-development-environment-for-cplusplus/compiling-game-projects-in-unreal-engine-using-cplusplus/index.md)文档。

## 测试

此时，你已经：

- 启用并配置了在线服务插件。
- 正确构造了你的项目。
- 添加了代码来实现在线服务插件功能。
- 编译了你的项目代码。

成功编译你的项目后，你就可以开始测试项目。要测试你的项目，请执行以下步骤： 1.在虚幻编辑器中打开你的项目。 1.开始在编辑器中运行（Play In Editor）以测试你的项目。

> [!TIP]
> 关于测试项目的更多信息，请参阅[在虚幻引擎中运行和模拟](../../../../../understanding-the-basics/playing-and-simulating/index.md)文档。

### 开始运行

你在开始运行时，应该看到这样的内容：

![开始运行](../../../../../../assets/images/37/372ebd39aba5ff5d1b4afc66e5b3f5d6f5c8187403c052d1bdcc7f5c3c2b80e2.jpg)

### 控制台命令

你还可以使用控制台命令调试和测试当前在线服务实现：

![在线服务控制台命令](../../../../../../assets/images/fd/fd6027fd97967818eda45bd40fe460d4487ffeda974777bcc67336d3eac1bf3f.jpg)

关于如何将控制台命令用于在线服务插件的更多信息，请参阅[在线服务控制台命令](../../debugging-online-services-plugin/online-services-console-commands/index.md)文档页面。
