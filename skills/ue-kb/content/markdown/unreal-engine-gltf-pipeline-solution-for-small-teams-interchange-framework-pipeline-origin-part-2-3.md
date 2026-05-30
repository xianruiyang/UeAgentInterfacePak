# unreal-engine-gltf-pipeline-solution-for-small-teams-interchange-framework-pipeline.origin (Part 2/3)

# unreal-engine-gltf-pipeline-solution-for-small-teams-interchange-framework-pipeline.origin (Part 2/3)

Source file: `unreal-engine-gltf-pipeline-solution-for-small-teams-interchange-framework-pipeline.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### 功能

**功能：设置网格名称**

```
Begin Object Class=/Script/BlueprintGraph.K2Node_FunctionEntry Name="K2Node_FunctionEntry_0" ExportPath="/Script/BlueprintGraph.K2Node_FunctionEntry'/Game/project_guild/Core/InterchangeFramework/IEBP_Pipeline.IEBP_Pipeline:SetMeshName.K2Node_FunctionEntry_0'"
   MetaData=(bCallInEditor=True)
   LocalVariables(0)=(VarName="BNC",VarGuid=FF89BDD8483F4C8949C549B57D7647DF,VarType=(PinCategory="object",PinSubCategoryObject="/Script/CoreUObject.Class'/Script/InterchangeCore.InterchangeBaseNodeContainer'"),FriendlyName="BNC",Category=NSLOCTEXT("KismetSchema", "Default", "Default"),PropertyFlags=5)
   LocalVariables(1)=(VarName="MN",VarGuid=5BE156DD405CEDFE5254E4A19827D050,VarType=(PinCategory="string"),FriendlyName="MN",Category=NSLOCTEXT("KismetSchema", "Default", "Default"),PropertyFlags=5)
   ExtraFlags=201457664
   FunctionReference=(MemberName="SetMeshName")
   bIsEditable=True
   NodePosX=-592
   NodePosY=-448
   NodeGuid=10D3D8EA45C2487DC8297FA82CC88AFA
```

**功能：资产名称前缀**

```
Begin Object Class=/Script/BlueprintGraph.K2Node_FunctionEntry Name="K2Node_FunctionEntry_0" ExportPath="/Script/BlueprintGraph.K2Node_FunctionEntry'/Game/project_guild/Core/InterchangeFramework/IEBP_Pipeline.IEBP_Pipeline:PrefixAssetName.K2Node_FunctionEntry_0'"
   MetaData=(ToolTip=NSLOCTEXT("", "F2AA8F664E96F42E04751A9ADC05A9D3", "Sets the prefix name no need to add underscores"),bCallInEditor=True)
   ExtraFlags=201457664
   FunctionReference=(MemberName="PrefixAssetName")
   bIsEditable=True
   NodePosX=2336
   NodePosY=1584
   NodeGuid=EA0C8B844A5814116BB1078A9FB18436
   CustomProperties Pin (PinId=96381E034DD9355C620EEDAD7669B1E4,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_IfThenElse_2 151C9E24494E9709C3FD51953EC95273,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=A003C5B741E2AA07D12CE686F390F596,PinName="InterchangeFactoryNode",Direction="EGPD_Output",PinType.PinCategory="object",PinType.PinSubCategory="",PinType.PinSubCategoryObject="/Script/CoreUObject.Class'/Script/InterchangeCore.InterchangeBaseNode'",PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=True,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_CallFunction_4 02CB45C14A5B11024AAD03AB2CDEE7E4,K2Node_Knot_0 717AC31F4B8D29056E94F1B0C60889A7,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
```

**功能：将资产添加到评论集合**

```
Begin Object Class=/Script/BlueprintGraph.K2Node_FunctionEntry Name="K2Node_FunctionEntry_0" ExportPath="/Script/BlueprintGraph.K2Node_FunctionEntry'/Game/project_guild/Core/InterchangeFramework/IEBP_Pipeline.IEBP_Pipeline:AddAssetToReviewCollection.K2Node_FunctionEntry_0'"
   MetaData=(bCallInEditor=True)
   LocalVariables(0)=(VarName="asset",VarGuid=590D17D74A3E2128CB11069929D39710,VarType=(PinCategory="object",PinSubCategoryObject="/Script/CoreUObject.Class'/Script/CoreUObject.Object'"),FriendlyName="Asset",Category=NSLOCTEXT("KismetSchema", "Default", "Default"),PropertyFlags=5)
   ExtraFlags=201457664
   FunctionReference=(MemberName="AddAssetToReviewCollection")
   bIsEditable=True
   NodePosX=3792
   NodePosY=6592
   NodeGuid=A09B96444B245D93AE1D5C87D1C12396
   CustomProperties Pin (PinId=FF06EBB54C5832A00B258BB2A5CB1AB3,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_VariableSet_0 0A6A822B4427877CF57A5C8630F2AF03,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
```

