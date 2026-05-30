# Secondary split of unreal-engine-efectos-de-camara.part02.origin.md (2/2)

# Secondary split of unreal-engine-efectos-de-camara.part02.origin.md (2/2)

Source generated part: `unreal-engine-efectos-de-camara.part02.origin.md`.

```
Begin Object Class=/Script/BlueprintGraph.K2Node_CustomEvent Name="K2Node_CustomEvent_0" ExportPath="/Script/BlueprintGraph.K2Node_CustomEvent'/EfectosDeCamara/CameraAdmin.CameraAdmin:StrafeTilt.K2Node_CustomEvent_0'"
   CustomFunctionName="Begin StrafeTilt"
   NodePosX=256
   NodePosY=304
   NodeGuid=6B77B5974A17E407507CE1B53706FDEC
   CustomProperties Pin (PinId=8877E9144178CA76AA56BF9F1F568435,PinName="OutputDelegate",Direction="EGPD_Output",PinType.PinCategory="delegate",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(MemberParent="/Script/Engine.BlueprintGeneratedClass'/EfectosDeCamara/CameraAdmin.CameraAdmin_C'",MemberName="Begin StrafeTilt",MemberGuid=6B77B5974A17E407507CE1B53706FDEC),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=F50296D7479FA9E34FE0F9B44F17C926,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_ExecutionSequence_0 C317B9FC4C00975DBCFBDB8D48EF6BD0,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
Begin Object Class=/Script/BlueprintGraph.K2Node_CallFunction Name="K2Node_CallFunction_14" ExportPath="/Script/BlueprintGraph.K2Node_CallFunction'/EfectosDeCamara/CameraAdmin.CameraAdmin:StrafeTilt.K2Node_CallFunction_14'"
   FunctionReference=(MemberName="AddNewCameraModifier",bSelfContext=True)
```

我们必须确保在带有 3 颗心的注释的区域内为右侧和左侧修改器分配 **ChildActorOfClass,** 分配修改器后，我们将转到输入的位置并放置以下代码，确保投射我们创建的 **PlayerCameraManager**，为此，我们将删除代码的投射并调用我们创建的文件，从而结束此相机效果。

```
Begin Object Class=/Script/BlueprintGraph.K2Node_DynamicCast Name="K2Node_DynamicCast_4" ExportPath="/Script/BlueprintGraph.K2Node_DynamicCast'/Game/FirstPerson/Blueprints/BP_FirstPersonPlayerController.BP_FirstPersonPlayerController:EventGraph.K2Node_DynamicCast_4'"
   TargetType="/Script/Engine.BlueprintGeneratedClass'/EfectosDeCamara/CameraAdmin.CameraAdmin_C'"
   NodePosX=-2096
   NodePosY=-2272
   NodeGuid=D460FF4244F7752EACFE15A5B59A6456
   CustomProperties Pin (PinId=713DB8884AA71565AFD002B52838EECB,PinName="execute",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_EnhancedInputAction_0 D065A56445E3A6B52E8C638D1CE49011,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=A8F5A9764BD08F5C01C8CDA9431D8503,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_CallFunction_39 6B5E4475413286762B164EAEC2914446,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=6DB658D0419C0A67003BC4AEB7474011,PinName="CastFailed",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=0E564BA146D165885E8AF4857692581F,PinName="Object",PinType.PinCategory="object",PinType.PinSubCategory="",PinType.PinSubCategoryObject="/Script/CoreUObject.Class'/Script/CoreUObject.Object'",PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_CallFunction_1 BFD6BDD940CE37CE872A13AC0E663205,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=1559BCCB45B49139B784C483F67269E2,PinName="AsCamera Admin",Direction="EGPD_Output",PinType.PinCategory="object",PinType.PinSubCategory="",PinType.PinSubCategoryObject="/Script/Engine.BlueprintGeneratedClass'/EfectosDeCamara/CameraAdmin.CameraAdmin_C'",PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_CallFunction_39 038F3466433957A76F55489E6297008E,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
```

