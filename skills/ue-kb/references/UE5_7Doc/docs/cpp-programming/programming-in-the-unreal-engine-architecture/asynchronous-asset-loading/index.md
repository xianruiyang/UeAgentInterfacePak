---
title: "资产异步加载"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/asynchronous-asset-loading-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "虚幻架构", "资产异步加载"]
---

# 资产异步加载

> 路径：虚幻引擎5.7文档 / 用C++编程 / 虚幻架构 / 资产异步加载

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/asynchronous-asset-loading-in-unreal-engine

**虚幻引擎（UE）** 中有很多方法可以简化资产数据的异步加载流程。这些新方法在开发中以及对设备上的烘焙数据的作用相同，因此无需维护两条按需加载数据的代码路径。按需引用和加载数据通常有两种方法：

## FSoftObjectPaths和TSoftObjectPtr

让美术或设计师引用资源的最简单方法是创建硬指针的 `UProperty` 并为它指定一个类别。在UE4中，如果有一个硬 `UObject` 指针属性引用了一个资源，则加载包含这个属性的对象（放在贴图中，或者从gameinfo等引用）时，就会加载这个资源。如果处理不当，就会在游戏开始时加载全部资源。如果您希望美术/设计师能够使用同一个UI作为硬指针来引用特定资源，而不必总是加载被引用资源，可以使用`FSoftObjectPath`或`TSoftObjectPtr`。

`FSoftObjectPath`是一个简单的结构体，其中有一个字符串包含资源的完整名称。如果您在类中添加这个类型的属性，它就会像`UObject *`属性一样显示在编辑器中。它还会正确处理烘焙和重定向，因此如果您使用 `SoftObjectPath`，就一定能在设备上正确工作。`TSoftObjectPtr`基本上是包含了`FSoftObjectPath`的`TWeakObjectPtr`，将用于设置特定类的模板，这样就可以限制编辑器UI仅允许选择特定类。如果被引用资源存在于内存中，则`TSoftObjectPtr.Get()`将返回这个资源。如果不存在，可以调用`ToSoftObjectPath()`来找出它引用的资源，使用下述方法加载这个资源，然后再次调用`TSoftObjectPtr.Get()`来取消引用。

如果美术或设计师要手动设置引用，则`TSoftObjectPtrs`和Soft Object Paths十分有用，但如果想要通过查询等功能来查找符合特定要求的资源，而不加载所有资源，则可以使用资源注册表和对象库。

## 资源注册表和对象库

资源注册表是用于存储资源元数据的系统，允许搜索和查询这些资源。编辑器利用资源注册表在 **内容浏览器** 中显示信息，但您也可以从游戏代码中使用资源注册表，以查询当前没有加载的游戏资源的元数据。要让资源数据可供搜索，需要向属性添加 `AssetRegistrySearchable` 标记。对资源注册表的查询返回 `FAssetData` 类型的对象，其中包含关于对象的信息以及"键->值"对映射，后者包含标记为可搜索的属性。

处理已卸载资源组的最简单方法是使用 `ObjectLibrary`。`ObjectLibrary` 是一个对象，它包含已加载对象列表或已卸载对象的 `FAssetData`，这些对象都是从共享基类继承而来。通过为对象库指定搜索路径来加载对象库，它会将所有资源添加到该路径。这样十分有用，因为您可以针对不同类型指定内容文件夹的各个部分，美术/设计师不必人工编辑主列表即可添加新资源。下面是如何使用对象库从磁盘加载AssetData的示例：

```
	if (!ObjectLibrary)	{		   ObjectLibrary = UObjectLibrary::CreateLibrary(BaseClass, false, GIsEditor);		   ObjectLibrary->AddToRoot();	}	ObjectLibrary->LoadAssetDataFromPath(TEXT("/Game/PathWithAllObjectsOfSameType");	if (bFullyLoad)	{		   ObjectLibrary->LoadAssetsFromAssetData();	}
```

在这个示例中，创建了一个新对象库，关联基类，然后在指定路径中加载所有资源数据。之后可以选择性加载实际资源。如果资源很小，或者您在进行烘焙并需要确保资源均得到烘焙，才需要完全加载资源。只要在烘焙期间执行资源注册表查询，并加载返回的资源，那么对象库对设备上的烘焙数据和开发期间的作用就是相同的。`ObjectLibrary`中包含了资源数据后，就可以执行查询并选择性加载特定资源。以下是如何执行查询的示例：

```
	TArray<FAssetData> AssetDatas;	ObjectLibrary->GetAssetDataList(AssetDatas); 	for (int32 i = 0; i < AssetDatas.Num(); ++i)	{		   FAssetData& AssetData = AssetDatas[i]; 		   const FString* FoundTypeNameString = AssetData.TagsAndValues.Find(GET_MEMBER_NAME_CHECKED(UAssetObject,TypeName)); 		   if (FoundTypeNameString && FoundTypeNameString->Contains(TEXT("FooType")))		   {				  return AssetData;		   }	}
```

该示例在对象库中搜索是否有哪个对象的 `TypeName` 字段包含 `"FooType"`，然后返回所找到的第一个结果。得到 `AssetData` 后，调用 `ToStringReference()` 将它转换为`FSoftObjectPath`，然后使用下一个系统异步加载转换后的对象：

## StreamableManager和异步加载

现在您已经了解了用于引用磁盘资源的 `FSoftObjectPath`，那么如何对它进行异步加载呢？`FStreamableManager` 就是最简单的方法。首先，需要创建 `FStreamableManager`，我建议将它放在某类全局游戏单件对象中，如使用 `GameSingletonClassName` 在 `DefaultEngine.ini` 中指定的对象。然后，可以将 `FSoftObjectPath` 传递给它并开始加载。`SynchronousLoad` 将进行一次简单的块加载并返回对象。该方法或许适用于较小对象，但可能会导致主线程长时间停滞。在这种情况下，您将需要使用 `RequestAsyncLoad`，它将异步加载一组资源并在完成后调用委托。请参见以下示例：

```
	void UGameCheatManager::GrantItems()	{		   TArray<FSoftObjectPath> ItemsToStream;		   FStreamableManager& Streamable = UGameGlobals::Get().StreamableManager;		   for(int32 i = 0; i < ItemList.Num(); ++i)		   {				  ItemsToStream.AddUnique(ItemList[i].ToStringReference());		   }		   Streamable.RequestAsyncLoad(ItemsToStream, FStreamableDelegate::CreateUObject(this, &UGameCheatManager::GrantItemsDeferred));	} 	void UGameCheatManager::GrantItemsDeferred()	{		   for(int32 i = 0; i < ItemList.Num(); ++i)		   {				  UGameItemData* ItemData = ItemList[i].Get();				  if(ItemData)				  {						 MyPC->GrantItem(ItemData);				  }		   }	}
```

在这个示例中，`ItemList` 是设计师在编辑器中修改过的`TArray< TSoftObjectPtr<UGameItem> >`。代码迭代了这个列表，将其转换为 `StringReferences`，并令其排队等候加载。所有这些项目加载完成（或由于缺少而加载失败）后，它调用传入的委托。然后，这个委托迭代同一个项目列表，取消引用，并将它们指定给一个玩家。`StreamableManager` 在调用委托之前保持对其加载的任何资源的硬引用，因此在调用委托之前，您就不必担心想要异步加载的对象会被垃圾回收。它在调用委托后释放这些引用，因此如果您仍希望保留引用，就需要在其他位置执行硬引用。

您可以使用相同方法来异步加载 `FAssetData`，对它们调用 `ToStringReference`，然后添加到数组，再通过委托调用 `RequestAsyncLoad`。委托可以是任何对象，因此如果需要，可以传递有效负载信息。结合使用上述方法，您应能够建立一个系统来有效地加载游戏资源。对于直接存取内存的游戏代码，将它转换为处理异步加载需要花费一些时间，但完成后，游戏卡顿情况将明显改善，内存占用也会大幅降低。
