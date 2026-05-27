# Data Assets

---
title: "Data Assets"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/data-assets-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "虚幻架构", "Data Assets"]
---

# Data Assets

> 路径：虚幻引擎5.7文档 / 用C++编程 / 虚幻架构 / Data Assets

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/data-assets-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

A **Data Asset** is an asset that stores data related to a particular system in an instance of its class.

- **Assets**can be made in the [Content Browser](../../../understanding-the-basics/content-browser/index.md) using native classes that inherit from [UDataAsset](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Engine/UDataAsset?application_version=5.5). If you want data inheritance or a more complex hierarchy, we recommend creating Data Only Blueprint Classes.
- Inheriting from a [Primary Data Asset](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Engine/UPrimaryDataAsset?application_version=5.5) implements a **Primary Asset Id** and has asset bundle support, which allows it to be manually loaded and unloaded from the [Asset Manager](../../../production-pipeline/asset-management/index.md).
- Instances of native subclasses can be created directly as Data Assets in the Unreal editor and will use the name of the native class as the **PrimaryAssetType**.

  In the image above, when creating a new data asset in the editor, you will be prompted to choose from a list of native subclasses.
- [Blueprint](../../../blueprints-visual-scripting/index.md) subclasses can be created to add variables and then subclassed again by Data Only Blueprint that sets those variables. With Blueprint subclasses, we recommend using Data Only Blueprints instead of the Data Asset instance to handle data inheritance and update the parent class.

## Creating a Data Asset

To inherit or create your own **Data Asset**, follow the steps below:

1. Navigate to **Tools** > **New C++ Class** then create a new class based on a **DataAsset**.
2. Add your class data members.

   C++

   ```
   USTRUCT()
           struct FMyAssetInfo {
               GENERATED_BODY()

               UPROPERTY(EditAnywhere)
               FString AssetName;

               UPROPERTY(EditAnywhere)
               UTexture2D* AssetThumbnail;

   ```
3. Build your project.
4. In the Unreal editor, right-click on the **Content Browser**, then select **Miscellaneous** > **Data Asset**.
5. When prompted to choose your class for the data asset instance, your asset should be populated in the list.
6. Open your **Data Asset Blueprint** to observe the member variables.

When using [Property Specifiers](https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-uproperties?application_version=5.7), you can observe all of your member variables in an asset so designers can modify the data directly from the editor.

## Primary Data Asset

A **Primary Data Asset** is a Data Asset that implements a `GetPrimaryAssetId` function and has asset bundle support, which allows it to be manually loaded/unloaded from the Asset Manager.

The **PrimaryAssetType** is equal to the name of the first native class going up the hierarchy or the highest-level Blueprint class. For example, if you have a `UPrimaryDataAsset` **->** `UParentNativeClass` **->** `UChildNativeClass` **->** `DataOnlyBlueprintClass`, then the type will be a `ChildNativeClass`.

Alternatively, if you have a `UPrimaryDataAsset` **->** `ParentBlueprintClass` **->** `DataOnlyBlueprintClass`, then the type will be a `ParentBlueprintClass`.

To change this behavior, you can override the `GetPrimaryAssetId` function in your native class or copy those functions into a different native base class.

### Creating a Primary Data Asset

To inherit or create your own Primary Data Asset, follow the steps below:

1. Navigate to **Tools** > **New C++ Class,** then create a new class based on a PrimaryDataAsset.
2. Add your class members and override the **GetPrimaryAssetID** function.

   C++

   ```
   UCLASS()
            class PROJECTExample_API UExampleDataAsset : public UPrimaryDataAsset {
                GENERATED_BODY()

                UPROPERTY(EditAnywhere)
                FString AssetName;

                UPROPERTY(EditAnywhere)
                UTexture2D* AssetThumbnail;

   ```

## Loading and Unloading Assets

**Unreal Engine** automatically handles [Asset](../../../understanding-the-basics/assets-and-content-packs/index.md) loading and unloading to provide developers a method to communicate with the Engine when each asset is needed. However, you may want precise control over when assets are discovered, loaded, and audited. For these cases, we recommend using the [Asset Manager](../../../production-pipeline/asset-management/index.md).

### Asynchronous Asset Loading

Unreal Engine simplifies the process of asynchronously loading asset data. These methods work identically in development and with cooked data on devices, so you do not need to maintain two code paths for loading data on demand.

See [Asynchronous Asset Loading](../asynchronous-asset-loading/index.md) for documentation.

