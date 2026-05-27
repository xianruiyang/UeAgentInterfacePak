# Asset Management

---
title: "Asset Management"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/asset-management-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Asset Management"]
---

# Asset Management

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Asset Management

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/asset-management-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

**Unreal Engine（UE）** 会处理 [Asset](../../understanding-the-basics/assets-and-content-packs/index.md) 的自动加载和卸载。这为开发者提供了一种方式，用来告知引擎每个资产何时会被需要。不过，在某些情况下，你可能希望精确控制资产何时以及如何被发现、加载和审计。对于这些情况， **Asset Manager** 可以提供帮助。 Asset Manager 是一个唯一的全局对象，存在于编辑器和打包游戏中。 它可以针对任意项目进行重写和自定义，并提供一个资产管理框架 可按项目语境将内容划分为有意义的 chunk, 同时不失去 Unreal 的 [松散包架构](../../understanding-the-basics/assets-and-content-packs/asset-metadata/index.md). Asset Manager 提供一组工具，用于帮助审计磁盘和内存使用情况, 为你提供优化资产组织所需的信息，以便进行 [Cooking 和 Chunking](../../sharing-and-releasing-projects/packaging-and-cooking/cooking-content-and-creating-chunks/index.md) 。

## Primary Asset 和 Secondary Asset

Unreal 中的资产管理系统会将所有 Asset 分为两种类型： **Primary Asset** 和 **Secondary Asset**。Asset Manager 可以通过 [Primary Asset ID](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/CoreUObject/UObject/FPrimaryAssetId?application_version=5.5), 直接操作 Primary Asset，该 ID 通过调用以下函数获得： `GetPrimaryAssetId`. 要将由特定 `UObject` 类创建的 Asset 指定为 Primary Asset, 可以重写 `GetPrimaryAssetId` 函数，使其返回有效的 `FPrimaryAssetId` structure. Secondary Asset 不由 Asset Manager 直接处理, 而是在被 Primary Asset 引用或使用时，由引擎自动加载。 默认情况下，只有 `UWorld` Asset (关卡) 是 Primary，其余所有 Asset 都是 Secondary。 要将 Secondary Asset 转为 Primary Asset, the `GetPrimaryAssetId` 它所属类的函数必须被重写并返回有效的 `FPrimaryAssetId` structure. Primary Asset ID 由两部分组成, 用于标识一组 Asset 的唯一 Primary Asset Type, 以及该特定 Primary Asset 的名称, 默认情况下，该名称就是资产在以下位置显示的名称： **Content Browser**.

## 蓝图类资产与数据资产

Asset Manager 会处理两种不同类型的 Asset: Blueprint Class，以及 Level 和 Data Asset 等非蓝图 Asset（即 `UDataAsset` 类的 Asset 实例）。 每个 Primary Asset Type 都与某个基类关联, 并会在下文描述的配置中指定它是否存储蓝图类。

### 蓝图类

要创建新的 Blueprint Primary Asset，请前往 **Content Browser** 和 [创建新的蓝图类](../../blueprints-visual-scripting/specialized-blueprint-visual-scripting-node-groups/types-of-blueprints/blueprint-class-assets/creating-blueprint-classes/index.md)，使其派生自重写了 `GetPrimaryAssetId` 函数的类。这个基类可以是 Primary Data Asset 或其任意子类，也可以是重写了 `GetPrimaryAssetId` 的 Actor 子类。要访问 Blueprint Primary Asset，可以从 C++ 代码调用类似 `GetPrimaryAssetObjectClass` 的函数，或使用名称中包含“Class”的 Blueprint Asset Manager 函数。 获得该类后，可以像处理其他蓝图类一样使用它生成新实例, 也可以使用 Get Defaults 函数访问与该蓝图关联的 Class Default Object 中的只读数据。

对于永远不需要实例化的蓝图类，可以将数据存储在 [Data-Only Blueprint](../../blueprints-visual-scripting/user-interface-reference-for-the-blu-73593f79/user-interface-breakdown/blueprints-visual-scripting-editor-user-interac-eb14d598/index.md) 中，该蓝图继承自 `UPrimaryDataAsset`。也可以从基类派生子类，包括基于蓝图的子类。例如，可以创建一个类似 `UMyShape` 的基类，在 C++ 中扩展 `UPrimaryDataAsset`，然后创建名为 `BP_MyRectangle` 且以 `UMyShape` 作为父类的基于蓝图的子类，再创建 `BP_MyRectangle` 的基于蓝图的子类 `BP_MySquare`。使用默认设置时，最后创建的类的 PrimaryAssetId 将是 `MyShape:BP_MySquare`。

## 非蓝图资产

当 Primary Asset Type 不需要存储蓝图数据时，可以使用非蓝图 Asset。非蓝图 Asset 在代码中访问更简单，也更节省内存。要在编辑器中创建新的非蓝图 Primary Asset，可以从高级 Content Browser 窗口创建新的 Data Asset，或使用用于创建新关卡等内容的自定义 UI。以这种方式创建 Asset 与创建蓝图类不同；你创建的是类的实例，而不是类本身。要访问该类，可以使用类似 `GetPrimaryAssetObject` 的 C++ 函数加载它们，或使用名称中不含 Class 的蓝图函数。加载后，可以直接访问它们并读取数据。

> [!NOTE]
> 由于这些 Asset 是实例而不是类，因此不能从它们继承类或其他 Asset。如果确实需要这样做，例如希望创建一个子 Asset，除显式重写的值外继承父级的值，应改用 Blueprint Class。

## Asset Manager 与 Streamable Manager

该 [Asset Manager](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Engine/UAssetManager?application_version=5.5) 对象是一个单例，用于管理 Primary Asset 的发现和加载。引擎内置的基础 Asset Manager 类提供基本管理功能，但可以扩展以适应项目特定需求。 [Streamable Manager](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Engine/FStreamableManager?application_version=5.5) 结构体包含在 Asset Manager 中，负责异步加载对象的实际工作，并通过使用 **Streamable Handle** 让对象保持在内存中，直到它们不再需要并可以卸载。不同于单例 Asset Manager，引擎的不同部分和不同用例中存在多个 Streamable Manager。

## Asset Bundle

一个 **Asset Bundle** 是与 Primary Asset 关联的特定 Asset 命名列表。 通过给 通过给 `UObject` 的 `TSoftObjectPtr` 或 `FStringAssetReference` 成员的 `UPROPERTY` 部分添加“AssetBundles”元标签，即可创建 Asset Bundle。该标签的值表示 Secondary Asset 应存储到的 bundle 名称。例如，以下 Static Mesh Asset 存储在名为 `MeshPtr` 的成员变量中，当 UObject 保存时，它会被添加到名为“TestBundle”的 Asset Bundle：

C++

```
/** Mesh */	UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = Display, AssetRegistrySearchable, meta = (AssetBundles = "TestBundle"))	TSoftObjectPtr<UStaticMesh> MeshPtr;
```

使用 Asset Bundle 的第二种方式，是在运行时通过项目的 Asset Manager 类注册它们。在这种情况下，程序员需要编写代码来填充 `FAssetBundleData` 结构体，然后将该结构体传给 Asset Manager。可以通过重写 `UpdateAssetBundleData` 函数，或调用 `AddDynamicAsset` 并传入想要与 bundle 中 Secondary Asset 关联的 Primary Asset ID 来实现。

### 从磁盘注册和加载 Primary Asset

大多数 Primary Asset 在 **Content Browser** 中可见，并以存储在磁盘上的 Asset 文件存在, 因此美术或设计师可以编辑它们。 程序员创建可用于这种方式的类，最简单的方法是继承 `UDataAsset` 的子类 `UPrimaryDataAsset`， 该类内置加载和保存 Asset Bundle 数据的功能。 如果想使用不同的基类，例如 `APawn`，可以研究 `UPrimaryDataAsset` 会很有用，因为它是让你的类支持 Asset Bundle 所需功能的最小示例。 以下类示例展示如何在假想游戏中指定一种区域类型; 该区域类型会告知游戏在整体地图界面中构建世界的视觉表现时应使用哪些美术 Asset:

C++

```
/** A zone that can be selected by the user from the map screen */
	UCLASS(Blueprintable)
	class MYGAME_API UMyGameZoneTheme : public UPrimaryDataAsset
	{
		GENERATED_BODY()

		/** Name of the zone */
		UPROPERTY(EditDefaultsOnly, Category=Zone)
		FText ZoneName;
```

因为此类继承自 `UPrimaryDataAsset`，所以它具有可工作的 `GetPrimaryAssetId` 版本，该版本会使用 Asset 的短名称和原生类。例如，以“Forest”名称保存的 `UMyGameZoneTheme` 会拥有 Primary Asset ID“MyGameZoneTheme:Forest”。每当 `UMyGameZoneTheme` Asset 在编辑器中保存时，`PrimaryDataAsset` 的 `AssetBundleData` 成员都会更新，将其作为 Secondary Asset 包含进来。

注册和加载 Primary Asset 需要执行以下操作：

1. **如果项目存在自定义 Asset Manager 类，需要让引擎知道它。** 只有当项目需要特殊功能时，才需要重写默认 Asset Manager 类 `UAssetManager`。 如果项目不需要特殊功能，可以跳过此步骤。 要重写它，请修改项目的 `DefaultEngine.ini` 文件，并设置 `[/Script/Engine.Engine]` 部分下的 `AssetManagerClassName` 变量。 最终值应采用以下格式:

   C++

   ```
   [/Script/Engine.Engine]     AssetManagerClassName=/Script/Module.UClassName
   ```

   其中“Module”表示项目模块名称，“UClassName”表示要使用的 `UClass` 名称。在本例中，项目模块名为“MyGame”，要使用的类名为 `UFortAssetManager`（这意味着它的 `UClass` 名称是 `FortAssetManager`），因此第二行应写作：

   C++

   ```
   AssetManagerClassName=/Script/FortniteGame.FortAssetManager
   ```
2. **向 Asset Manager 注册 Primary Asset。** 可以在 **Project Settings** 菜单中配置，也可以通过编写 Asset Manager 类，在启动期间注册 Primary Asset。

   - 使用 **Project Settings** 进行配置（位于 **Game / Asset Manager** 部分下）如下所示：

     ![Project settings Asset Manager window](../../../assets/images/41/414827e95f3e24e662b023c42b65e17f9d1a5b4dd94a715c3093076dec603e2e.png)

     可以配置扫描 Primary Asset 的路径。

     > [!NOTE]
     > | 设置 | 效果 |
     > | --- | --- |
     > | Primary Asset Types to Scan | 列出要发现和注册的 Primary Asset 类型，以及在哪里查找它们、如何处理它们。 |
     > | Directories to Exclude | 明确不会被扫描 Primary Asset 的目录。这可用于排除测试 Asset。 |
     > | Primary Asset Rules | 列出具体的 Rules Override，用于指定 Asset 的处理方式。请参阅 [Cooking 和 Chunking](../../sharing-and-releasing-projects/packaging-and-cooking/cooking-content-and-creating-chunks/index.md) 获取更多信息。 |
     > | Only Cook Production Asset | 如果勾选此项，指定为 DevelopmentCook 的 Asset 会在 cook 过程中导致错误。这有助于确保最终发布构建不包含测试 Asset。 |
     > | Primary Asset ID Redirects | 当 Asset Manager 查找某个 Primary Asset 的数据，且该 ID 出现在此列表中时，会用提供的替代 ID 替换该 ID。 |
     > | Primary Asset Type Redirects | 当 Asset Manager 查找某个 Primary Asset 的数据时，会使用此列表中提供的类型名称，而不是其原生类型。 |
     > | Primary Asset Name Redirects | 当 Asset Manager 查找某个 Primary Asset 的数据时，会使用此列表中提供的 Asset 名称，而不是其原生名称。 |
   - 如果想直接在代码中注册 Primary Asset，请重写 Asset Manager 类中的 `StartInitialLoading` 函数，并从那里调用 `ScanPathsForPrimaryAssets`。 在这种情况下，建议将同一类型的所有 Primary Asset 放在单个子文件夹中。 这会让发现和注册更快。
3. **加载 Asset。** 使用 Asset Manager 函数 `LoadPrimaryAssets`、`LoadPrimaryAsset` 和 `LoadPrimaryAssetsWithType` 在适当时间开始加载 Primary Asset。之后使用 `UnloadPrimaryAssets`、`UnloadPrimaryAsset` 和 `UnloadPrimaryAssetsWithType` 卸载 Asset。 使用这些加载函数时，可以指定 Asset Bundle 列表。 以这种方式加载会使 Asset Manager 加载这些 Asset Bundle 按上文所述引用的 Secondary Asset。

### 注册和加载动态创建的 Primary Asset

Primary Asset Bundle 也可以在运行时动态注册和加载。为此，有两个 Asset Manager 函数值得了解：

- `ExtractSoftObjectPaths` 会检查传入 `UScriptStruct` 的所有 `UPROPERTY` 成员，并识别 Asset 引用，然后将它们存储在 Asset 名称数组中。创建 Asset Bundle 时可以使用此数组。 `ExtractSoftObjectPaths` parameters:

| 参数 | 用途 |
| --- | --- |
| `Struct` | 要搜索 Asset 引用的 UStruct。 |
| `StructValue` | 指向该结构体的 void 指针。 |
| `FoundAssetReferences` | 用于返回该结构体中找到的 Asset 引用的数组。 |
| `PropertiesToSkip` | 要从返回数组中排除的属性名数组。 |

- `RecursivelyExpandBundleData` 会查找对 Primary Asset 的所有引用，并递归展开以查找它们的所有 Asset Bundle 依赖。在此情况下，这意味着上文 ZoneTheme 引用的 TheaterMapTileClass 会添加到 AssetBundleData。随后它会注册命名动态 Asset 并开始加载它。 `RecursivelyExpandBundleData` parameters:

| 参数 | 用途 |
| --- | --- |
| `BundleData` | 包含 Asset 引用的 Bundle Data。这些引用会被递归展开，可用于加载一组相关资产。 |

例如，“MyGame”项目可以在其自定义 Asset Manager 类中使用以下代码，根据游戏过程中下载的“theater”数据构建并加载 Asset：

C++

```
// Construct the name from the theater ID
	UMyGameAssetManager& AssetManager = UMyGameAssetManager::Get();
	FPrimaryAssetId WorldMapAssetId = FPrimaryAssetId(UMyGameAssetManager::WorldMapInfoType, FName(*WorldMapData.UniqueId));

	TArray<FSoftObjectPath> AssetReferences;
	AssetManager.ExtractSoftObjectPaths(FMyGameWorldMapData::StaticStruct(), &WorldMapData, AssetReferences);

	FAssetBundleData GameDataBundles;
	GameDataBundles.AddBundleAssets(UMyGameAssetManager::LoadStateMenu, AssetReferences);
```

