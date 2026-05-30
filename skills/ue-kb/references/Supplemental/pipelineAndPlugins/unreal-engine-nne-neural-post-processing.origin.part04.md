# unreal-engine-nne-neural-post-processing.origin (Part 4/4)

Source file: `unreal-engine-nne-neural-post-processing.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### 执行

```
Begin Object Class=/Script/BlueprintGraph.K2Node_Event Name="K2Node_Event_3" ExportPath="/Script/BlueprintGraph.K2Node_Event'/Game/ThirdPerson/Blueprints/NeuralPostProcessingActor.NeuralPostProcessingActor:EventGraph.K2Node_Event_3'"
   EventReference=(MemberParent="/Script/CoreUObject.Class'/Script/Engine.Actor'",MemberName="ReceiveBeginPlay")
   bOverrideFunction=True
   bCommentBubblePinned=True
   NodeGuid=327DE9B54F3E2CBFDB51ACAD50897D73
   CustomProperties Pin (PinId=5D1C355044766A747AFF33A10253C8DB,PinName="OutputDelegate",Direction="EGPD_Output",PinType.PinCategory="delegate",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(MemberParent="/Script/CoreUObject.Class'/Script/Engine.Actor'",MemberName="ReceiveBeginPlay"),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=602685804096CAE7D44EE1838B8ADE4A,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_GenericCreateObject_2 BB29979A49572EB89651EEBB7AE64717,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
Begin Object Class=/Script/BlueprintGraph.K2Node_GenericCreateObject Name="K2Node_GenericCreateObject_2" ExportPath="/Script/BlueprintGraph.K2Node_GenericCreateObject'/Game/ThirdPerson/Blueprints/NeuralPostProcessingActor.NeuralPostProcessingActor:EventGraph.K2Node_GenericCreateObject_2'"
   NodePosX=208
```

### 模型资产创建

```
pip install torch
pip install onnxscript
```

```
import torch
```

```
class SobelFilter(torch.nn.Module):
    
    def __init__(self):
        super(SobelFilter, self).__init__()
        self.hFilter = torch.tensor([[[[1, 0, -1], [2, 0, -2], [1, 0, -1]]]*3]*3, dtype=torch.float)
        self.vFilter = torch.tensor([[[[1, 2, 1], [0, 0, 0], [-1, -2, -1]]]*3]*3, dtype=torch.float)

    def forward(self, x):
        x = torch.nn.functional.pad(x, (1, 1, 1, 1), mode='replicate')
        h = torch.nn.functional.conv2d(x, self.hFilter)
```

```
if __name__=="__main__":
    model = SobelFilter()
    input = torch.randn(1, 3, 256, 256)
    onnx = torch.onnx.export(model, (input,), 'sobel.onnx', 
                             input_names=['input'], output_names=['output'], opset_version=9,
                             dynamic_axes={'input': {2: 'height', 3: 'width'}, 'output' : {2: 'height', 3: 'width'}})
```

### 关卡设置

### 下一步
