# 本机 Actor 组件上的热重载可能会导致蓝图损坏和数据丢失

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/jP5O/unreal-engine-hot-reload-on-native-actor-component-can-lead-to-blueprint-corruption-and-data-loss

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 4231 字符。

## 摘要

Branden T 撰写的文章。摘要：基于 UActorComponent/USceneComponent 的本机类的热重载目前会损坏任何在其层次结构或 AddCom 中包含该类型组件的已加载蓝图...

## 中文整理

### 概览

*文章由 [Branden T.](https://dev.epicgames.com/community/profile/Kzq2/Branden.Turner) 撰写* **摘要：** 如果在热重载成功后保存蓝图，则基于 UActorComponent/USceneComponent 的本机类的热重载当前将损坏任何在其层次结构或 AddComponent 节点中包含该类型组件的已加载蓝图。为了发生错误，加载的蓝图还必须是： 在蓝图编辑器中打开（即具有活动的预览实例） 在当前关卡中的某处实例化。最终结果是，在热重载之后，原型被热重载类的 CDO 的引用所取代。如果用户在此之后保存蓝图，则修改后的组件数据将不再保留。唯一的办法是销毁/重新创建或复制组件或（可能）将 BP 复制到新资产；重新加载无法修复它。这至少会影响引擎版本 4.21 及更高版本。这个问题目前还没有明确的解决方案，并且目前还积压了许多其他热重载错误。详细信息：根本原因是在本机组件类热重载期间，在 KismetReinstanceUtilities.cpp 中的 ReplaceObjectHelper() 期间，从 CPFUO 内部的 UBlueprintGenerateClass::FindArchetype() 中原型查找失败：

```cpp
InstancedPropertyUtils::FInstancedPropertyMap InstancedPropertyMap;
InstancedPropertyUtils::FArchiveInstancedSubObjCollector  InstancedSubObjCollector(OldObject, InstancedPropertyMap);
==> UEditorEngine::CopyPropertiesForUnrelatedObjects(OldObject, NewUObject);
InstancedPropertyUtils::FArchiveInsertInstancedSubObjects InstancedSubObjSpawner(NewUObject, InstancedPropertyMap);
```

当调用它来更新热重载组件类的新预览 Actor 实例时，CPFUO 会尝试查找新实例的原型：

```cpp
// Gather references to old instances or objects that need to be replaced after we serialize in saved data
TMap<UObject*, UObject*> ReferenceReplacementMap;
ReferenceReplacementMap.Add(OldObject, NewObject);
==> ReferenceReplacementMap.Add(OldObject->GetArchetype(), NewObject->GetArchetype());
```

这无法通过内部的类型检查

```cpp
UBlueprintGeneratedClass::FindArchetype():

 

if (SCSNode->ComponentTemplate && SCSNode->ComponentTemplate->IsA(ArchetypeClass))
{
    Archetype = SCSNode->ComponentTemplate;
}
```

此时，ArchetypeClass 被设置为热重载（新）类，但存储在 SCS 节点的组件模板属性中的引用尚未被替换，因此它仍然引用旧类的旧原型实例。由于它无法匹配节点，因此 GetArchetype() 回退到其默认情况并返回热重载（新）类的本机 CDO。因此，在由 CPFUO 填充并通过委托广播回重建器的 ReferenceReplacementMap 中，我们（错误地）最终得到： *SCS 节点模板（旧）→ 新组件类 CDO* 当它应该是： *SCS 节点模板（旧）→ SCS 节点模板（新）* 重建器在此处跟踪此映射：

```cpp
struct FObjectRemappingHelper
{
	void OnObjectsReplaced(const TMap<UObject*, UObject*>& InReplacedObjects)
	{
==>		ReplacedObjects.Append(InReplacedObjects);
	}

	TMap<UObject*, UObject*> ReplacedObjects;
} ObjectRemappingHelper;
```

后来它在这里践踏了正确的映射：OldToNewInstanceMap.Append(ObjectRemappingHelper.ReplacedObjects);之后是引用替换，SCS 节点最终引用热重载类的 CDO。这意味着用户在编辑时最终会修改本机类 CDO，而不是重新实例化的模板对象。这就是编辑默认值时重置箭头停止出现的原因，因为增量是与同一对象 (CDO) 进行比较。这就是为什么不保存默认值的原因，因为本机 CDO 没有序列化，因此会导致永久数据丢失。它还可能在编辑器会话中导致其他奇怪的行为，因为本机 CDO 现在可能会在蓝图编辑器中无意中被修改。
