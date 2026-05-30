# 指南：调查虚幻引擎中的蓝图数据丢失问题

### 加载实例修改值

```cpp
UStruct::SerializeVersionedTaggedProperties(FStructuredArchiveSlot,unsigned char *,UStruct *,unsigned char *,const UObject *) Class.cpp:1297
UStruct::SerializeTaggedProperties(FStructuredArchiveSlot,unsigned char *,UStruct *,unsigned char *,const UObject *) Class.cpp:1284
UObject::SerializeScriptProperties(FStructuredArchiveSlot) Obj.cpp:1642
UObject::Serialize(FStructuredArchiveRecord) Obj.cpp:1459
UObject::Serialize(FArchive &) Obj.cpp:1347
AMyActor::Serialize(FArchive &) MyActor.cpp:52
FLinkerLoad::Preload(UObject *) LinkerLoad.cpp:4490
EndLoad(FUObjectSerializeContext *,TArray > *) UObjectGlobals.cpp:2111
::operator()() UObjectGlobals.cpp:1693
LoadPackageInternal(UPackage *,const FPackagePath &,unsigned int,FLinkerLoad *,FArchive *,const FLinkerInstancingContext *,const FPackagePath *) LoadPackage(UPackage *,const FPackagePath &,unsigned int,FArchive *,const FLinkerInstancingContext *,const FPackagePath *) UObjectGlobals.cpp:1958
```

### 保存实例修改值

```cpp
FIntProperty::SerializeItem(FStructuredArchiveSlot,void *,const void *) PropertyNumeric.cpp:304
FPropertyTag::SerializeTaggedProperty(FStructuredArchiveSlot,FProperty *,unsigned char *,unsigned char *) PropertyTag.cpp:254
UStruct::SerializeVersionedTaggedProperties(FStructuredArchiveSlot,unsigned char *,UStruct *,unsigned char *,const UObject *) Class.cpp:1627
UStruct::SerializeTaggedProperties(FStructuredArchiveSlot,unsigned char *,UStruct *,unsigned char *,const UObject *) Class.cpp:1287
UObject::SerializeScriptProperties(FStructuredArchiveSlot) Obj.cpp:1785
UObject::Serialize(FStructuredArchiveRecord) Obj.cpp:1602
UObject::Serialize(FArchive &) Obj.cpp:1488
AActor::Serialize(FArchive &) Actor.cpp:851
AMyActor::Serialize(FArchive &) MyActor.cpp:54
FPackageHarvester::ProcessExport(const FPackageHarvester::FExportWithContext &) PackageHarvester.cpp:468
```

### 5.3 蓝图编译

### 将默认值重新传播到子类

```cpp
UStruct::SerializeVersionedTaggedProperties(FStructuredArchiveSlot,unsigned char *,UStruct *,unsigned char *,const UObject *) Class.cpp:1471
UStruct::SerializeTaggedProperties(FStructuredArchiveSlot,unsigned char *,UStruct *,unsigned char *,const UObject *) Class.cpp:1284
UObject::SerializeScriptProperties(FStructuredArchiveSlot) Obj.cpp:1642
UObject::Serialize(FStructuredArchiveRecord) Obj.cpp:1459
UObject::Serialize(FArchive &) Obj.cpp:1347
AActor::Serialize(FArchive &) Actor.cpp:824
AMyActor::Serialize(FArchive &) MyActor.cpp:52
[Inlined] FCPFUOReader::{ctor}(FCPFUOWriter &,UObject *) UnrealEngine.cpp:16838
UEngine::CopyPropertiesForUnrelatedObjects(UObject *,UObject *,FCopyPropertiesForUnrelatedObjectsParams) UnrealEngine.cpp:17016
FBlueprintEditorUtils::PropagateParentBlueprintDefaults(UClass *) BlueprintEditorUtils.cpp:1836
```

### 保留类修改后的默认值

```cpp
UStruct::SerializeVersionedTaggedProperties(FStructuredArchiveSlot,unsigned char *,UStruct *,unsigned char *,const UObject *) Class.cpp:1297
UStruct::SerializeTaggedProperties(FStructuredArchiveSlot,unsigned char *,UStruct *,unsigned char *,const UObject *) Class.cpp:1284
UObject::SerializeScriptProperties(FStructuredArchiveSlot) Obj.cpp:1642
UObject::Serialize(FStructuredArchiveRecord) Obj.cpp:1459
UObject::Serialize(FArchive &) Obj.cpp:1347
AActor::Serialize(FArchive &) Actor.cpp:824
AMyActor::Serialize(FArchive &) MyActor.cpp:52
[Inlined] FCPFUOReader::{ctor}(FCPFUOWriter &,UObject *) UnrealEngine.cpp:16838
UEngine::CopyPropertiesForUnrelatedObjects(UObject *,UObject *,FCopyPropertiesForUnrelatedObjectsParams) UnrealEngine.cpp:17016
FBlueprintCompileReinstancer::CopyPropertiesForUnrelatedObjects(UObject *,UObject *,bool,bool) KismetReinstanceUtilities.cpp:2714
```

### 5.4 对象重新实例化

### 将默认值重新传播到实例

```cpp
[Inlined] FProperty::ContainerVoidPtrToValuePtrInternal(void *,int) UnrealType.h:685
[Inlined] FProperty::ContainerPtrToValuePtr(void *,int) UnrealType.h:755
[Inlined] FProperty::ContainerPtrToValuePtr(const void *,int) UnrealType.h:765
[Inlined] FProperty::CopyCompleteValue_InContainer(void *,const void *) UnrealType.h:878
FObjectInitializer::InitProperties(UObject *,UClass *,UObject *,bool) UObjectGlobals.cpp:4030
FObjectInitializer::PostConstructInit() UObjectGlobals.cpp:3816
FObjectInitializer::~FObjectInitializer() UObjectGlobals.cpp:3717
StaticConstructObject_Internal(const FStaticConstructObjectParameters &) UObjectGlobals.cpp:4385
NewObject(UObject *,const UClass *,FName,EObjectFlags,UObject *,bool,FObjectInstancingGraph *,UPackage *) UObjectGlobals.h:1642
UWorld::SpawnActor(UClass *,const UE::Math::TTransform *,const FActorSpawnParameters &) LevelActor.cpp:666
```

### 保留实例修改值

```cpp
AMyActor::Serialize(FArchive &) MyActor.cpp:51
FCPFUOWriter::FCPFUOWriter(UObject *,UObject *,const UEngine::FCopyPropertiesForUnrelatedObjectsParams &) UnrealEngine.cpp:16799
UEngine::CopyPropertiesForUnrelatedObjects(UObject *,UObject *,FCopyPropertiesForUnrelatedObjectsParams) UnrealEngine.cpp:17001
ReplaceActorHelper(AActor *,UClass *,UObject *&,UClass *,TMap
FBlueprintCompilationManagerImpl::CompileSynchronouslyImpl(const FBPCompileRequestInternal &) BlueprintCompilationManager.cpp:299
FBlueprintCompilationManager::CompileSynchronously(const FBPCompileRequest &) BlueprintCompilationManager.cpp:3474
FKismetEditorUtilities::CompileBlueprint(UBlueprint *,EBlueprintCompileOptions,FCompilerResultsLog *) Kismet2.cpp:774
FBlueprintEditor::Compile() BlueprintEditor.cpp:4095
```

### 六、总结
