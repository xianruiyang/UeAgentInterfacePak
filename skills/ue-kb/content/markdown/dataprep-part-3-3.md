# 使用几何脚本 + Dataprep 修改导入后的网格 (Part 3/3)

# 使用几何脚本 + Dataprep 修改导入后的网格 (Part 3/3)

Source file: `unreal-engine-modifying-meshes-upon-import-with-geometry-script-dataprep.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### 处理标记的演员

我们在场景中标记了演员。我们有一个想要对它们使用的函数。我们可以直接跳到编辑器实用程序小部件将这两件事联系在一起。然而，因为我以前必须这样做，所以我的建议是在我们的函数库中再创建一个函数来帮助我们处理网格。原因是我们已经标记了静态网格物体***actors***，但是我们需要对其静态网格物体***资产***进行操作。很多时候，传入的 Datasmith 场景将提供静态网格物体 Actor，它们具有多个静态网格物体组件，因此具有多个资产。因此，我们需要构建一个强大的选择方法，我们可以一遍又一遍地重复使用，而无需复制和粘贴太多节点。再次打开编辑器函数库并创建一个新函数。我将我的命名为 **GetAllStaticMeshesFromTaggedActors**。下面嵌入了该函数的完整节点图。逻辑如下： 1. 我们有一个输入参数，用于搜索要搜索的 **Tag**。 2. 我们聚集场景中带有该标签的**所有演员**。 3. **对于每个演员**，我们收集所有**静态网格物体组件**。 4. **对于每个组件**，我们记录其静态网格体**资产**的副本。 5. 我们还记录了我们收集的所有组件的列表。 （这稍后有用） 6. 最后，我们为调用此函数的人**返回资产和组件的列表** 您可以复制并粘贴下面的节点，在这种情况下，您需要右键单击变量并为它们创建新的局部变量。然后编译并保存。如果您自己构建该函数，您将需要静态网格体和静态网格体组件类型的两个局部变量（对象数组）。您还需要**添加返回节点**并输出两个相同类型的变量。加上标签名称类型的输入。

**从标记的 Actor 中获取所有静态网格体**

```
Begin Object Class=/Script/BlueprintGraph.K2Node_FunctionEntry Name="K2Node_FunctionEntry_0" ExportPath="/Script/BlueprintGraph.K2Node_FunctionEntry'/Game/Utilities/BP_GeometryOperations.BP_GeometryOperations:GetAllStaticMeshesFromTaggedActors.K2Node_FunctionEntry_0'"
   MetaData=(bCallInEditor=True)
   LocalVariables(0)=(VarName="TaggedComponents",VarGuid=4950B04341ABED2F979C199F6E77B160,VarType=(PinCategory="object",PinSubCategoryObject="/Script/CoreUObject.Class'/Script/Engine.StaticMeshComponent'",ContainerType=Array),FriendlyName="Tagged Components",Category=NSLOCTEXT("KismetSchema", "Default", "Default"),PropertyFlags=5)
   LocalVariables(1)=(VarName="TaggedMeshAssets",VarGuid=163E31644DC22FB6815572B3F2DDC0E8,VarType=(PinCategory="object",PinSubCategoryObject="/Script/CoreUObject.Class'/Script/Engine.StaticMesh'",ContainerType=Array),FriendlyName="Tagged Mesh Assets",Category=NSLOCTEXT("KismetSchema", "Default", "Default"),PropertyFlags=5)
   ExtraFlags=201465856
   FunctionReference=(MemberName="GetAllStaticMeshesFromTaggedActors")
   bIsEditable=True
   NodePosX=-64
   NodeGuid=940D4B5C46535A3D58EC289CF3B36A79
   CustomProperties Pin (PinId=AC22B4B14EFC15DBCA2803A67372B379,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_CallFunction_0 6F24CB4043571DBE17F0F5AB205C7F40,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
```
### 编辑器实用工具小部件

现在把它们放在一起。返回内容浏览器，右键单击空白处，然后转到 **编辑器实用程序 > 编辑器实用程序小组件**。为了简单起见（这不是 UMG 教程），请使用下拉菜单并为根小部件选择 **无** 将​​资产命名为您想要的任何名称，然后将其打开。它将在 **Designer** 视图中打开。在这里，我们将尽力创建一个您可以按需使用的自定义导入器。我们需要的主要东西是从调色板拖到画布中的**编辑器实用程序按钮**小部件。如果您将文本小部件拖到顶部并给它一个标签，则会获得奖励积分。选择按钮后，向下滚动到详细信息面板的底部，然后单击 + 图标为 **单击时** 创建事件。这将打开图形编辑器。当我们单击此按钮时，我们希望发生两件事： 1. 重新导入最新的 Datasmith 模型（这也会清除任何网格编辑） 2. 在标记的 actor 上运行几何脚本修改 从我们的单击事件中，我们将触发一个 **执行 Dataprep** 节点，该节点引用 Dataprep 资产接口下的现有 Dataprep 配方。然后接下来要做的就是使用我们花了所有时间创建的两个方便的函数......
### 运行管道
### 结论
## 相关链接

- [Download the Blueprints (5.4+)](https://epicgames.box.com/s/v3urqi4bm1maiphxyor10b0dbozlaxea)
- [Geometry Script Documentation](https://dev.epicgames.com/documentation/en-us/unreal-engine/geometry-scripting-users-guide-in-unreal-engine)

