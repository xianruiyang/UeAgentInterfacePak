# Secondary split of unreal-engine-music-nodes-in-metasounds.part02.origin.md (2/2)

Source generated part: `unreal-engine-music-nodes-in-metasounds.part02.origin.md`.

```
Begin Object Class=/Script/MetasoundEditor.MetasoundEditorGraphExternalNode Name="MetasoundEditorGraphExternalNode_0"
   ClassName=(Namespace="UE",Name="MIDI Note Quantizer",Variant="Audio")
   NodeID=9DCF4BF34A475D10BE34AF912CBA552C
   NodePosX=656
   NodePosY=528
   ErrorType=4
   NodeGuid=9F6C68FF44DF6C7D48952F908F55AB65
   CustomProperties Pin (PinId=00C587814F3421C5FB42AA94E5058232,PinName="Note In",PinType.PinCategory="float",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,DefaultValue="60.000000",LinkedTo=(MetasoundEditorGraphExternalNode_3 075ECD1149766A2BE6425285017CDEF0,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=194DAADA48439ACD7A31D6893FD43D1C,PinName="Root Note",PinType.PinCategory="float",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,DefaultValue="0.000000",LinkedTo=(MetasoundEditorGraphInputNode_1 AE975CE84CF18A4455E357801CA67544,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=FD7ABA2E44E0BFCE97374B94F8A024BD,PinName="Scale Degrees",PinType.PinCategory="float",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=Array,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(MetasoundEditorGraphExternalNode_7 418CF6524C391551F854CFA10BBCD8CD,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
```

**实践中的音乐节点** 虽然上面的 MetaSounds 相当简单，但其中描述的音乐节点可以与其他 MetaSound 功能相结合，以创建日益复杂的程序音乐系统。蓝图数据、随机性、Quartz 节奏量化和触发逻辑是这些 MetaSounds 扩展选项的开始。这里使用的音乐节点可用于执行任何操作，从快速移调或改变您在运行时根据游戏参数编写的旋律的节奏，到创建完全程序化的旋律内容。可能性是无限的 - 尽情享受创造的乐趣吧！ - [有关如何从外部设备获取 MIDI 数据的教程](https://docs.unrealengine.com/4.27/en-US/WorkingWithAudio/MIDI) - [给定 MIDI 值的关联音符名称和频率 (Hz) 列表](https://newt.phys.unsw.edu.au/jw/notes.html) - [有关音阶的更多信息](http://openmusictheory.com/scales.html) - [有关音符量化的更多信息（诚然，重点是物理合成器，但这里的概念相同）](https://perfectcirc.com/signal/learning-synthesis-quantizers) - [MIDI 的一些背景](https://cecm.indiana.edu/361/midi.html)
