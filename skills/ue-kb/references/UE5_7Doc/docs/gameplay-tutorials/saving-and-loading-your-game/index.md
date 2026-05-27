---
title: "保存和加载游戏"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/saving-and-loading-your-game-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay教程", "保存和加载游戏"]
---

# 保存和加载游戏

> 路径：虚幻引擎5.7文档 / Gameplay教程 / 保存和加载游戏

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/saving-and-loading-your-game-in-unreal-engine

编程语言

C++

从下拉菜单中选择一个选项以查看与之相关的内容

保存游戏的含义可能因游戏不同而有很大差异，但大多数现代游戏的一般想法都是让玩家退出游戏，稍后再从中断的地方继续游戏。 根据所开发的游戏类型，可能仅需一些基本信息即可实现此目的，例如玩家到达的最后一个检查点，以及玩家可能找到的物品。 或者，也可能需要更详细的信息，可能涉及玩家与游戏内其他角色的社交互动列表，或各种请求、任务目标或次要情节的当前状态，等等。

虚幻引擎（UE）有一个保存和加载系统，该系统涉及你创建的旨在满足游戏特定需求的一个或多个自定义**SaveGame**类，包括你需要在多个游玩会话中保留的所有信息。 该系统允许保存多个游戏文件，并将不同的SaveGame类保存到这些文件。 这对于将全局解锁的功能与特定于游戏通关的游戏数据分开非常有用。

## Creating a SaveGame Object

The `USaveGame` class sets up an object that can be used as a target for the saving and loading functions declared in `Kismet/GameplayStatics.h`.

You can create a new class based on `USaveGame` using the [C++ Class Wizard](../../cpp-programming/setting-up-your-development-environment-for-cplusplus/using-the-cplusplus-class-wizard/index.md).

In this example, the new `USaveGame` class is called `UMySaveGame`. In order to use it, add the following lines to your game module's header file, after any other `#include` directives:

C++

MyProject.h

```
#include "MySaveGame.h"	#include "Kismet/GameplayStatics.h"
```

### Header

In the header file for your `SaveGame` object, you can declare any variables you want your `SaveGame` to store.

C++

```
UPROPERTY(VisibleAnywhere, Category = Basic)	FString PlayerName;
```

> [!NOTE]
> In this example, there are also variables declared that will be used to store default values for the `SaveSlotName` and the `UserIndex`, so that each class that saves to this `SaveGame` object will not have to independently set those variables. This step is optional, and will cause there to be one save slot that gets overwritten if the default values are not changed.

C++

MySaveGame.h

```
#pragma once

	#include "GameFramework/SaveGame.h"
	#include "MySaveGame.generated.h"

	/**
	 *
	 */
	UCLASS()
	class [PROJECTNAME]_API UMySaveGame : public USaveGame
```

### Source

Generally, the `SaveGame` object's source file does not need any particular code to function, unless your particular save system has additional functionality you would like to set up here.

This example does define the values of `SaveSlotName` and `UserIndex` in the class constructor, so they can be read out and used by other gameplay classes.

C++

MySaveGame.cpp

```
// Copyright 1998-2018 Epic Games, Inc. All Rights Reserved. 	#include "[ProjectName].h"	#include "MySaveGame.h" 	UMySaveGame::UMySaveGame()	{		SaveSlotName = TEXT("TestSaveSlot");		UserIndex = 0;	}
```

## 保存游戏

创建SaveGame类后，可向该类填充变量以存储游戏数据。 例如，可创建一个整型变量来存储玩家的分数，或者创建一个字符串变量来存储玩家的姓名。 保存游戏时，会将该信息从当前游戏世界转移到SaveGame对象，而加载游戏时，会将该信息从SaveGame对象复制到游戏对象（如角色、玩家控制器或游戏模式）。

First, call `CreateSaveGameObject` (from the `UGameplayStatics` library) to get a new `UMySaveGame` object. Once you have the object, you can populate it with the data you want to save. Finally, call `SaveGameToSlot` or `AsyncSaveGameToSlot` to write the data out to your device.

### Asynchronous Saving

`AsyncSaveGameToSlot` is the recommended method for saving the game. Running asynchronously prevents a sudden framerate hitch, making it less noticeable to players and avoiding a possible certification issue on some platforms. When the save process is complete, the delegate (of type `FAsyncSaveGameToSlotDelegate`) will be called with the slot name, the user index, and a `bool` indicating success or failure.

C++

```
if (UMySaveGame* SaveGameInstance = Cast<UMySaveGame>(UGameplayStatics::CreateSaveGameObject(UMySaveGame::StaticClass())))
	{
		// Set up the (optional) delegate.
		FAsyncSaveGameToSlotDelegate SavedDelegate;
		// USomeUObjectClass::SaveGameDelegateFunction is a void function that takes the following parameters: const FString& SlotName, const int32 UserIndex, bool bSuccess
		SavedDelegate.BindUObject(SomeUObjectPointer, &USomeUObjectClass::SaveGameDelegateFunction);

		// Set data on the savegame object.
		SaveGameInstance->PlayerName = TEXT("PlayerOne");
```

### Synchronous Saving

`SaveGameToSlot` is sufficient for small SaveGame formats, and for saving the game while paused or in a menu. It's also easy to use, as it simply saves the game immediately and returns a `bool` indicating success or failure. For larger amounts of data, or for auto-saving game while the player is still actively interacting with your game world, `AsyncSaveGameToSlot` is a better choice.

C++

```
if (UMySaveGame* SaveGameInstance = Cast<UMySaveGame>(UGameplayStatics::CreateSaveGameObject(UMySaveGame::StaticClass())))
	{
		// Set data on the savegame object.
		SaveGameInstance->PlayerName = TEXT("PlayerOne");

		// Save the data immediately.
		if (UGameplayStatics::SaveGameToSlot(SaveGameInstance, SlotNameString, UserIndexInt32))
		{
			// Save succeeded.
		}
```

### Binary Saving

You can transfer a SaveGame object to memory with the `SaveGameToMemory` function. This function only offers synchronous operation, but is faster than saving to a drive. The caller provides a reference to a buffer (a `TArray<uint8>&`) where the data will be stored. On success, the function returns true.

C++

```
TArray<uint8> OutSaveData;	if (UGameplayStatics::SaveGameToMemory(SaveGameObject, OutSaveData))	{		// The operation succeeded, and OutSaveData now contains a binary represenation of the SaveGame object.	}
```

You can also save binary data directly to a file, similar to the `SaveGameToSlot` function, by calling `SaveDataToSlot` with the buffer (a `const TArray<uint8>&`) and the slot name and user ID information. As with `SaveGameToMemory`, this function only offers synchronous operation, and returns a `bool` to indicate success or failure.

C++

```
if (UGameplayStatics::SaveDataToSlot(InSaveData, SlotNameString, UserIndexInt32))	{		// The operation succeeded, and InSaveData has been written to the save file defined by the slot name and user ID we provided.	}
```

在开发平台上，保存的游戏文件会使用`.sav`扩展名，并显示在项目的`Saved\SaveGames`文件夹中。 在其他平台（尤其是游戏主机）上，为适应特定的文件系统，这会有所不同。

## 加载游戏

要加载已保存的游戏，必须提供保存游戏时使用的保存插槽名称和用户ID。 如果指定的SaveGame存在，引擎将向SaveGame对象填充其包含的数据，并将其作为基础SaveGame（`USaveGame`类）对象返回。 然后，可将该对象的类型转换回自定义SaveGame类并访问数据。 根据SaveGame类型包含的数据种类，你可能希望保留其副本，或者只是使用数据并丢弃对象。

与保存一样，可同步或异步加载。 如果数据量很大，或者希望在加载时使用加载屏幕或动画，我们建议使用非同步方法。 对于可快速加载的少量数据，则可选用同步方法。

### Asynchronous Loading

When loading asynchronously with `AsyncLoadGameFromSlot`, you must provide a callback delegate in order to receive the data that the system loads.

C++

```
// Set up the delegate.	FAsyncLoadGameFromSlotDelegate LoadedDelegate;	// USomeUObjectClass::LoadGameDelegateFunction is a void function that takes the following parameters: const FString& SlotName, const int32 UserIndex, USaveGame* LoadedGameData	LoadedDelegate.BindUObject(SomeUObjectPointer, &USomeUObjectClass::LoadGameDelegateFunction);	UGameplayStatics::AsyncLoadGameFromSlot(SlotName, 0, LoadedDelegate);
```

### Synchronous Loading

The `LoadGameFromSlot` function will create and return a `USaveGame` object if it succeeds.

C++

```
// Retrieve and cast the USaveGame object to UMySaveGame.	if (UMySaveGame* LoadedGame = Cast<UMySaveGame>(UGameplayStatics::LoadGameFromSlot(SlotName, 0)))	{		// The operation was successful, so LoadedGame now contains the data we saved earlier.		UE_LOG(LogTemp, Warning, TEXT("LOADED: %s"), *LoadedGame->PlayerName);	}
```

### Binary Loading

You can load SaveGame data from a file in raw, binary form with `LoadDataFromSlot`. This function is very similar to `LoadGameFromSlot`, except that it does not create a SaveGame object. Only synchronous operation is available for this type of loading.

C++

```
TArray<uint8> OutSaveData;	if (UGameplayStatics::LoadDataFromSlot(OutSaveData, SlotNameString, UserIndexInt32))	{		// The operation succeeded, and OutSaveData now contains a binary represenation of the SaveGame object.	}
```

You can also convert this binary data to a SaveGame object by calling `LoadGameFromMemory`. This is a synchronous call, and returns a new `USaveGame` object upon success, or a null pointer on failure.

C++

```
if (UMySaveGame* SaveGameInstance = Cast<UMySaveGame>(LoadGameFromMemory(InSaveData)))	{		// The operation succeeded, and SaveGameInstance was able to cast to type we expected (UMySaveGame).	}
```
