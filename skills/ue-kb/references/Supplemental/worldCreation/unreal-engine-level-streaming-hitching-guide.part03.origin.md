# 关卡流媒体连接指南

### 4.11 FlushAsyncLoading 故障

**展开以查看蓝图示例。**

```
Begin Object Class=/Script/BlueprintGraph.K2Node_VariableGet Name="K2Node_VariableGet_0" ExportPath="/Script/BlueprintGraph.K2Node_VariableGet'/Game/Blueprints/BP_FlushAsyncLoadRepro.BP_FlushAsyncLoadRepro:EventGraph.K2Node_VariableGet_0'"
   VariableReference=(MemberName="SoftClassPath",MemberGuid=5CE597A94991E2A18080B38AE0C9772B,bSelfContext=True)
   NodePosX=416
   NodePosY=592
   NodeGuid=995880954DEB10081367B2B3D6DDF163
   CustomProperties Pin (PinId=11489BA24BBDBC9321FC7A811E1646C1,PinName="SoftClassPath",Direction="EGPD_Output",PinType.PinCategory="softclass",PinType.PinSubCategory="",PinType.PinSubCategoryObject="/Script/CoreUObject.Class'/Script/Engine.Actor'",PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_LoadAssetClass_0 00C419A34E37BACC5AC5B5935C8B8BB6,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=19B016F7420983E73B8C3D8E3E997945,PinName="self",PinFriendlyName=NSLOCTEXT("K2Node", "Target", "Target"),PinType.PinCategory="object",PinType.PinSubCategory="",PinType.PinSubCategoryObject="/Script/Engine.BlueprintGeneratedClass'/Game/Blueprints/BP_FlushAsyncLoadRepro.BP_FlushAsyncLoadRepro_C'",PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=True,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
Begin Object Class=/Script/BlueprintGraph.K2Node_LoadAssetClass Name="K2Node_LoadAssetClass_0" ExportPath="/Script/BlueprintGraph.K2Node_LoadAssetClass'/Game/Blueprints/BP_FlushAsyncLoadRepro.BP_FlushAsyncLoadRepro:EventGraph.K2Node_LoadAssetClass_0'"
   NodePosX=608
```

**异步加载软对象路径**

```cpp
#include "Engine/AssetManager.h"
#include "Engine/StreamableManager.h"

void AFlushAsyncLoadRepro::BeginPlay()
{
	Super::BeginPlay();

	// Loading one asset async by soft object path, with a callback
	AssetToSyncLoad.LoadAsync(FLoadSoftObjectPathAsyncDelegate::CreateUObject(this, &AFlushAsyncLoadRepro::OnAsyncLoadCompleted));
```

### 4.12 ProcessAsyncLoading 故障

### 4.13 PSO 挂钩

```cpp
[ConsoleVariables]
r.PSOPrecache.KeepInMemoryUntilUsed=2
```

### 5. 总结
