# 可变：删除看不见的网格部分（续 2）

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/DPO8/unreal-engine-mutable-remove-unseen-mesh-parts
- 原始文件：unreal-engine-mutable-remove-unseen-mesh-parts.origin.md
- 分段：第 2/2 段

## 中文整理

### 步骤

- 继续前面的示例，添加一个新的子对象，添加一个新的切换选项以添加 SK_RobotArm_L 网格部分及其材质。继续前面的示例，添加一个新的子对象，添加一个新的切换选项以添加 SK_RobotArm_L 网格部分及其材质。 - 将“删除网格”节点添加到“Arm Child Object Modifiers”引脚，并将 SK_BaseBody_RemoveArmL 网格连接到它。设置删除网格修改器所需标签以影响网格部分 [MI_MaleBodyYoung]。将“删除网格”节点添加到“Arm Child Object Modifiers”引脚并将 SK_BaseBody_RemoveArmL 网格连接到它。设置删除网格修改器所需标签以影响网格部分 [MI_MaleBodyYoung]。 - 编译网格部分 MI_MaleBodyYoung 中与 SK_BaseBody_RemoveArmL 中的面重合的所有面后，将被剪裁。编译网格部分 MI_MaleBodyYoung 中与 SK_BaseBody_RemoveArmL 中的面重合的所有面后，将被剪裁。 - 我们现在会发现的一个问题是，当夹克穿上时，机器人手臂没有被夹住。为了解决这个问题，我们将 JacketOn 添加到 MaI_RobotArm_L Mesh Section 节点启用标签列表中。这样，手臂将受到我们用来剪辑身体部位的“Clip Mesh With Mesh”修改器的影响。我们现在会发现的一个问题是，当夹克穿上时，机器人手臂没有被夹住。为了解决这个问题，我们将 JacketOn 添加到 MaI_RobotArm_L Mesh Section 节点启用标签列表中。这样，手臂将受到我们用来剪辑身体部位的“Clip Mesh With Mesh”修改器的影响。 - 可变的

## 相关链接

- [Mutable Sample](https://www.fab.com/listings/209e82f6-ad40-4253-b565-d2f65b12efe7)
- [Overview](https://dev.epicgames.com/community/learning/tutorials/DPO8/unreal-engine-mutable-remove-unseen-mesh-parts#overview)
- [Using a Clipping Volume](https://dev.epicgames.com/community/learning/tutorials/DPO8/unreal-engine-mutable-remove-unseen-mesh-parts#usingaclippingvolume)
- [Assets required](https://dev.epicgames.com/community/learning/tutorials/DPO8/unreal-engine-mutable-remove-unseen-mesh-parts#assetsrequired)
- [Steps](https://dev.epicgames.com/community/learning/tutorials/DPO8/unreal-engine-mutable-remove-unseen-mesh-parts#steps)
- [Remove Mesh Blocks](https://dev.epicgames.com/community/learning/tutorials/DPO8/unreal-engine-mutable-remove-unseen-mesh-parts#removemeshblocks)
- [Assets required](https://dev.epicgames.com/community/learning/tutorials/DPO8/unreal-engine-mutable-remove-unseen-mesh-parts#assetsrequired-2)
- [Steps](https://dev.epicgames.com/community/learning/tutorials/DPO8/unreal-engine-mutable-remove-unseen-mesh-parts#steps-2)
- [Clip Mesh With Plane and Morph](https://dev.epicgames.com/community/learning/tutorials/DPO8/unreal-engine-mutable-remove-unseen-mesh-parts#clipmeshwithplaneandmorph)
- [Assets Required](https://dev.epicgames.com/community/learning/tutorials/DPO8/unreal-engine-mutable-remove-unseen-mesh-parts#assetsrequired-3)
- [Steps](https://dev.epicgames.com/community/learning/tutorials/DPO8/unreal-engine-mutable-remove-unseen-mesh-parts#steps-3)
- [Remaining Work](https://dev.epicgames.com/community/learning/tutorials/DPO8/unreal-engine-mutable-remove-unseen-mesh-parts#remainingwork)
- [Remove With Vertex Precision](https://dev.epicgames.com/community/learning/tutorials/DPO8/unreal-engine-mutable-remove-unseen-mesh-parts#removewithvertexprecision)
- [Assets Required](https://dev.epicgames.com/community/learning/tutorials/DPO8/unreal-engine-mutable-remove-unseen-mesh-parts#assetsrequired-4)
- [Steps](https://dev.epicgames.com/community/learning/tutorials/DPO8/unreal-engine-mutable-remove-unseen-mesh-parts#steps-4)
