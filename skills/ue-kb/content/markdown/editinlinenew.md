# EditInlineNew + 实例化组件

# EditInlineNew + 实例化组件

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/15xj/unreal-engine-editinlinenew-instanced-components

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 3874 字符。

## 摘要

文章作者：Alex K. [Bug] 编辑器创建的用作原型的子对象无法按预期工作 | Dan O’Connor 编辑器创建的用作原型的子对象，无法像当前实现的那样发挥作用。弧…

## 中文整理

### 概览

*文章作者：[Alex K.](https://dev.epicgames.com/community/profile/ZvMA/akoumandarakis)*

### [Bug] 编辑器创建的用作原型的子对象无法按预期工作 |丹·奥康纳

编辑器创建的用作原型的子对象，不能像当前实现的那样发挥作用。对象的原型查找基于名称，并且编辑器（详细信息面板和其他控件）不执行任何操作来维护跨层次结构的一致名称。即使它确实可靠地命名了用户创建的子对象，关于如何处理原型图各个部分的更改仍然存在悬而未决的问题。 Actor/Component 系统、UMG 和动画系统都在这里重新发明轮子，但它们都没有解决使用 EditInlineNew 和 Instanced 关键字的缺点。以下是我们发现的为了使 EditInlineNew 和 Instanced 关键字正确运行而需要完成的工作的粗略列表。该列表大致按从最简单到最困难的顺序排列：** - FPropertyValueImpl::ImportText 将对 UObject* 进行浅层复制，从而导致共享“实例”对象 - 它们不会呈现为共享 - FPropertyNode::PropagatePropertyChange 将对实例化的 UObject* 进行浅层比较，它还直接调用 UProperty::ImportText 来浅层复制 UObject。 - UEngine::CopyPropertiesForUnlatedObjects 对实例化、editinlineonly 引用的处理不一致。这会影响重新实例化流程 - FObjectInstancingGraph::GetInstancedSubobject 通常会认为它不需要实例化 Instanced、EditinlineNew 子对象 - UArrayProperty/USetProperty/UMMapProperty::SerializeItem 不为其内部 Serialize 调用提供默认值，破坏了嵌套在数组中的对象的增量序列化 - FComponentPropertyWriter 不进行嵌套对象的深度比较 - **FComponentPropertyReader 没有映射已在新实例中重新创建的子对象的方法 - **UActorComponent::DetermineUCSModifiedProperties 不会对嵌套对象进行深入比较 - FActorComponentInstanceData 无法正确实例化子对象 - 蓝图编译管理器不会检测依赖于其他原型的原型 - 它可能需要这样做才能使原型重新排序顺序正确。 - 详细信息面板不会确定性地命名子对象，因此通过名称查找其原型是不可靠的。详细信息面板要么需要确定性地命名它们（在动态容器的情况下非常困难），要么需要在原型编辑时（启动时间、蓝图加载时间、蓝图编译时间等）存储原型数据，要么详细信息面板需要允许用户命名子对象 - 让用户能够控制原型。设计必须考虑基于原型但当前未加载的数据。 - 实例化深度嵌套的子对象并且也基于深度嵌套的子对象时，也会出现严重的性能问题。不幸的是，我们无法确认此列表是否详尽。我们欢迎对社区认为应该在这里发生的事情提供反馈。我们试图对这一领域的拉取请求做出非常积极的响应，但缺点是有些系统性的。另外，为了澄清 UMG 和 Actor/组件系统如何解决这个问题，它们都将属性编辑器重定向到特殊的模板实例，并处理新小部件/组件本身的编辑时创建（请参阅 SCSEditor.cpp）。然后在运行时，他们不依赖普通的 NewObject，而是使用 StaticDuplicateObject 作为基准实现（使用优化的路径来处理常见情况）。了解这些系统提供了一种实现您自己的基于对象的 DSL 的方法。

