# Secondary split of unreal-engine-using-generator-nodes-in-metasounds.part02.origin.md (2/2)

# Secondary split of unreal-engine-using-generator-nodes-in-metasounds.part02.origin.md (2/2)

Source generated part: `unreal-engine-using-generator-nodes-in-metasounds.part02.origin.md`.

```
Begin Object Class=/Script/MetasoundEditor.MetasoundEditorGraphExternalNode Name="MetasoundEditorGraphExternalNode_1"
   ClassName=(Namespace="UE",Name="Sine",Variant="Audio")
   NodeID=F43AD6184A4244DCCE58C4BF6E09449B
   NodePosX=144
   NodePosY=224
   ErrorType=4
   NodeGuid=818367494E613F2F7EEB6587D867C603
   CustomProperties Pin (PinId=2D74B2584989087B1279F5B81C2DD797,PinName="Enabled",PinType.PinCategory="bool",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,DefaultValue="true",PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=695D8698400CA52C9F4F9380A3811038,PinName="Bi Polar",PinType.PinCategory="bool",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,DefaultValue="true",PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=72DF80C94D483CF1DD1614AE0164AF45,PinName="Frequency",PinType.PinCategory="float",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,DefaultValue="440.000000",LinkedTo=(MetasoundEditorGraphInputNode_3 70D0AA614008FEBA4E2C998002AEA8A2,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
```

**频率调制 - 更好的值选择** 此 MetaSound 提供了一种选择调制器频率、载波频率和强调谐波分音的调制指数的机制。如果您以前没有在 MetaSounds 中看到过这一点，那么这是一个不错的 Composition 示例：您可以引用您在其他 MetaSounds 中创建的 MetaSounds 图表。换句话说，这个 MetaSound 的工作方式是引用我们之前创建的基本频率调制设置，并向其发送不同的输入参数。 （说到这里，您需要设置上面的 MetaSound 才能正常工作 - 在创建了FrequencyModulationBase MetaSound 后，右键单击图表，进入“Graphs”选项卡，然后选择“FrequencyModulationBase”）。为此 MetaSound 设置输入节点也更加复杂一些。正如您所期望的，主频率输入受益于“频率（对数）”值类型。对于 ModulationIndex，您可能需要高于 1 的最大值 - 我个人选择 10。ModFrequencyOffset 具有非常强的效果，因此您可能希望其范围非常小 - 我使用 -.3 到 0.3。您可能还希望将 0 作为默认值。更改 ModFrequencyMultiplier 和/或 CarrierFrequencyMultiplier 将导致音色发生最明显的变化（但请注意，如果将它们都更改为互为因子的数字，例如 2 和 4，它也会改变感知的音高）。调制指数可以被认为是效果的强度，值越低，声音越接近纯正弦波。当“调制频率偏移”旋钮设置为 0 以外的值时，可能会给声音添加一些失真。为什么这种选择方法提供更多辅音超出了本特定教程的范围，但如果您感兴趣，有用链接部分中有频率调制背后的数学的外部解释。

![发电机节点调频复合 MetaSound 的屏幕截图](assets/unreal-engine-using-generator-nodes-in-metasounds/image-04.jpg)

**发电机节点调频复合体**

```
Begin Object Class=/Script/MetasoundEditor.MetasoundEditorGraphInputNode Name="MetasoundEditorGraphInputNode_0"
   Input=MetasoundEditorGraphInput'"MetasoundEditorGraphInput_0"'
   NodePosX=-736
   NodePosY=96
   ErrorType=4
   NodeGuid=EF9AD736471138638BEA3DB80A46E316
   CustomProperties Pin (PinId=50644F2A4107B3A9FD26F7A022C7865F,PinName="UE.Source.OnPlay",Direction="EGPD_Output",PinType.PinCategory="trigger",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(MetasoundEditorGraphExternalNode_4 71D6180A47961636998EB5AF2A2BE525,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
Begin Object Class=/Script/MetasoundEditor.MetasoundEditorGraphExternalNode Name="MetasoundEditorGraphExternalNode_4"
   ClassName=(Name="0072A895440ABA3D9FCFB3B9633231A9")
```

**回顾** 在本教程之后，您现在应该掌握如何与生成器节点交互。这些节点可以与其他 MetaSound 功能相结合，作为程序合成声音的强大来源。当与 AD 或 ADSR 节点等包络结合使用时，这些 Generator 节点可以快速成为一种乐器，可以通过 MIDI 音高和速度控件或随机生成的旋律等进行控制。它们可以用作通过环形调制等技术来更改现有波形文件的方法。生成器节点发出的声音可以通过加法合成进行组合、通过减法合成进行过滤、以音频速率调制其幅度、通过节点的音频版本（例如 Min 和 Max）进行实时波形整形等来扩展。探索综合有很多方向——它本身就是一个完整的领域。好消息是，很多针对物理模块化合成器或 Pd 等软件的学习资源都具有也可以应用于 MetaSounds 的概念。无论是通过传统的减法合成方法还是更复杂的频率调制技术，或者完全是其他东西，选择一个方向并花一些时间来探索都是值得的。玩得开心！ - [有关一般波形的更多信息](https://teachmeaudio.com/recording/sound-reproductive/waveshapes) - [有关相位和相互添加波形的更多信息](https://helpx.adobe.com/audition/using/sound.html) - [有关频率调制的更多信息](https://soundonsound.com/techniques/introduction-Frequency-modulation)

