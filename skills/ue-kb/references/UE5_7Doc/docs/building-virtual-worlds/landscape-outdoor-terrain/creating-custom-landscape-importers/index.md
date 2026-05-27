---
title: "创建自定义地形导入器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/creating-custom-landscape-importers-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "地形户外地貌", "创建自定义地形导入器"]
---

# 创建自定义地形导入器

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 地形户外地貌 / 创建自定义地形导入器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/creating-custom-landscape-importers-in-unreal-engine

可通过编写插件创建自定义导入地形数据的高度图和权重图格式。插件会将新格式添加到引擎中，并从文件导入数据。

### 编写自定义导入器

- 为新建导入器，插件应该创建实现 `ILandscapeHeightmapFileFormat` 和 `ILandscapeWeightmapFileFormat` 的对象实例，并分别使用 `ILandscapeEditorModulemodule::RegisterHeightmapFileFormat` 和 `ILandscapeEditorModulemodule::RegisterWeightmapFileFormat` 注册这些对象。
- 要实现插件中的

  ILandscapeHeightmapFileFormat

  接口需要覆盖以下函数：

  1. const FLandscapeFileTypeInfo& GetInfo() const

     ：返回类型信息，表明此类处理哪些文件类型，以及是否支持导出。
  2. FLandscapeHeightmapInfo Validate(const TCHAR* HeightmapFilename) const

     - 验证命名的文件，或拒绝它并返回错误代码和消息。
  3. FLandscapeHeightmapImportData Import(const TCHAR* HeightmapFilename, FLandscapeFileResolution ExpectedResolution) const

     - 实际导入文件。
  4. void Export(const TCHAR* HeightmapFilename, TArrayView<const uint16> Data, FLandscapeFileResolution DataResolution, FVector Scale) const

     - 如果此格式支持导出，则导出文件（请参阅

     GetInfo

     中的返回值）。这是唯一不需要覆盖即可编译的函数。但是，如果在不覆盖的情况下调用它，它将调用

     check

     。
  5. (Destructor)

     - 实现此接口的类应该使用虚拟析构函数，因为它们将通过指向接口类的指针删除。
- 实现

  ILandscapeWeightmapFileFormat

  接口的操作几乎完全相同，仅在一些返回类型中稍有不同：

  1. const FLandscapeFileTypeInfo& GetInfo() const

     - 返回类型信息，表明此类处理哪些文件类型，以及是否支持导出。
  2. FLandscapeWeightmapInfo Validate(const TCHAR* WeightmapFilename) const

     - 验证命名的文件，或拒绝它并返回错误代码和消息。
  3. FLandscapeWeightmapImportData Import(const TCHAR* WeightmapFilename, FLandscapeFileResolution ExpectedResolution) const

     - 实际导入文件。
  4. void Export(const TCHAR* WeightmapFilename, TArrayView<const uint16> Data, FLandscapeFileResolution DataResolution, FVector Scale) const

     - 如果此格式支持导出，则导出文件（请参阅

     GetInfo

     中的返回值）。这是唯一不需要覆盖即可编译的函数。但是，如果在不覆盖的情况下调用它，它将调用

     check

     。
  5. (Destructor)

     - 实现此接口的类应该使用虚拟析构函数，因为它们将通过指向接口类的指针删除。
- 如需更多信息和示例，你可以查看

  LandscapeFileFormatInterfaces.h

  中的接口、

  LandscapeFileFormatPng.cpp

  和

  LandscapeFileFormatPng.h

  中的.PNG实现，以及

  LandscapeFileFormatRaw.cpp

  和

  LandscapeFileFormatRaw.h

  中的.RAW实现。所有这些代码都在引擎中的LandscapeEditor模块中。
