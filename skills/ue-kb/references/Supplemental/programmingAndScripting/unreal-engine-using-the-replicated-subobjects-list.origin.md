# 使用复制子对象列表

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/7y39/unreal-engine-using-the-replicated-subobjects-list

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 6559 字符。

## 摘要

使用复制子对象列表 本文由 Alex K 撰写 目前，复制组件和子对象依赖于虚拟函数 AActor::ReplicateSubobjects。对于具有复制子对象的演员，...

## 中文整理

### 概览

*本文由 [Alex K](https://dev.epicgames.com/community/profile/ZvMA/akoumandarakis) 撰写* 目前，[复制组件和子对象](https://docs.unrealengine.com/4.26/en-US/InteractiveExperiences/Networking/Actors/Components/) 依赖于虚拟函数 AActor::ReplicateSubobjects。对于具有复制子对象的参与者，必须重写此函数，参与者需要在每个复制的组件/子对象上手动调用 ReplicateSubobject 和 ReplicateSubobjects。最近添加到引擎中的是一个用于处理复制组件和子对象的新系统，这使得参与者无需实现此虚拟功能并手动复制单个子对象。 Actor 现在具有将子对象注册到所属 Actor 或 ActorComponent 上的列表的新方法，这些注册子对象的复制由 Actor 通道自动处理。这个新系统允许在注册子对象时为其指定 ELifetimeCondition，从而更好地控制复制子对象的时间和地点，而无需在 ReplicateSubobjects 中自定义实现此逻辑。使用这个新系统非常简单： 1. 为该类设置 bReplicateUsingRegisteredSubObjectList = true。 2. 在ReadyForReplication、BeginPlay 或创建新子对象时调用AddReplicatedSubObject。 （ReadyForReplication 在 InitComponent 和 BeginPlay 之间调用，在这里注册组件允许它在组件的 BeginPlay 内部尽早调用 RPC。） 3. 在修改或删除子对象时调用RemoveReplicatedSubObject。 （这一步非常重要，因为除非删除引用，否则列表仍然会引用已更改或标记为销毁的子对象的指针，从而在对象被垃圾收集时导致崩溃。）例如：

```cpp
AMyActor::AMyActor()
{
    bReplicateUsingRegisteredSubObjectList = true;
}

void AMyActor::CreateMyClass()
{
    MySubObject= NewObject<UMySubObjectClass >();
    MySubObject->Counter = 10;
    AddReplicatedSubObject(MySubObject);
```

转换现有代码时，可以设置“net.SubObjects.CompareWithLegacy”CVar 在运行时将新列表与旧方法进行比较，如果检测到任何差异则触发确保。使用此系统的复制 ActorComponent 应该以相同的方式处理，因为它们也只是复制的子对象。要为 ActorComponent 设置复制条件，拥有的 Actor 类应该实现 AllowActorComponentToReplicate 并让它返回特定组件所需的 ELifetimeCondition。要在 BeginPlay 之后更改组件的条件，可以直接调用 SetReplicatedComponentNetCondition 来执行此操作。 （您还应该确保AllowActorComponentToReplicate将返回新​​条件，否则如果在actor上调用UpdateAllReplicatedComponents，它可能会被重置。）

```cpp
ELifetimeCondition AMyWeaponClass::AllowActorComponentToReplicate(const UActorComponent* ComponentToReplicate) const
{
   // Don’t replicate some components while the object is on the ground.
   if (!bIsInInventory)
   { 
       if (IsA<UDamageComponent>(ComponentToReplicate))
       {
           return COND_Never;
       }
   }
```

ActorComponent 还可以拥有自己的复制子对象列表，并且它们使用与 Actor 相同的 API 来注册/取消注册这些对象。 ActorComponent 中的这些子对象也可以具有复制条件，但值得注意的是，在检查其复制子对象的条件之前，必须将所属组件复制到连接。例如，如果子对象具有“Owner Only”条件，则如果将其注册到使用“Skip Owner”条件的组件，则该子对象将永远不会被复制。这个新系统还支持通过 NetConditionGroupManager 和 COND_NetGroup 为子对象创建自定义复制条件。要实现和使用复制组： 1. 向 COND_NetGroup 注册子对象。 2. 创建一个 FName 来表示该条件。例如：FName NetGroupCheatMaster(TEXT(“NetGroup_CheatMaster”)) 3. 将子对象添加到组中，例如：FNetConditionGroupManager::RegisterSubObjectInGroup(MyCheatSubObject, NetGroupCheatMaster) 4. 通过客户端的 PlayerController，添加组中子对象应复制到的任何客户端，例如：PlayerControllerCheatOwner->IncludeInNetConditionGroup(NetGroupCheatMaster) 子对象。并且 PlayerController 可以同时属于多个组，如果子对象是至少一个客户端组的一部分，则该子对象将被复制到客户端。虽然服务器肯定需要维护这些列表，但客户端上的参与者/组件也应该在本地维护其子对象列表，特别是对于具有本地权限的任何参与者，如果项目在客户端上记录重播，则这一点尤其重要，因为在将参与者记录到重播中时，客户端上的参与者将暂时交换为本地权限角色。重放记录的参与者应该在客户端上维护其子对象列表，无论其本地 NetRole 是什么。如果子对象是复制的属性，则使管理客户端上的子对象列表变得更容易的一种方法是使用该属性的repnotify 函数，客户端可以使用此 OnRep 来了解子对象何时发生更改，从子对象列表中删除旧引用并添加新引用。还值得注意的是，从服务器上的列表中删除子对象确实会导致该对象不被复制。一旦服务器检测到 UObject 无效，它将通知客户端在下一次网络更新时删除子对象。最后，这个新系统不支持子对象的 RepKeys。相反，建议对子对象的所有复制属性使用推送模型复制，并且仅在必要时将子对象标记为脏。 “net.PushModelSkipUndirtiedReplication” CVar 在使用推送模型复制时可能会节省更多时间，但是值得注意的是，对于具有大量子对象的 Actor，这可能不如 RepKeys 有效。在 [知识库！](https://forums.unrealengine.com/docs) 上获取更多答案。
