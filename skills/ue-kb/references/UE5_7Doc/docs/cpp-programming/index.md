---
title: "用C++编程"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/programming-with-cplusplus-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程"]
---

# 用C++编程

> 路径：虚幻引擎5.7文档 / 用C++编程

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/programming-with-cplusplus-in-unreal-engine

虚幻引擎为C++程序员提供了一个健壮的框架，帮助他们实现版本。

> [!NOTE]
> 本文假定你拥有一定的C++经验。

文本介绍了一些强大的功能，你可以用它们加快你的开发流程，它们分别是：

- 在C++中创建新的[Gameplay类](../gameplay-systems/programming-with-cpp/gameplay-classes/index.md)，在用[Visual Studio](https://dev.epicgames.com/documentation/404)或XCode进行编译后，所有的改变都将反映在[虚幻编辑器](../get-started/unreal-engine-for-new-users/unreal-editor-interface/index.md)中。在虚幻引擎中创建类与创建标准C++类、函数和变量相似。这些都是用[标准C++语法](epic-cplusplus-coding-standard/index.md)定义的。
- 使用[虚幻反射系统](reflection-system/index.md)，用[元数据属性说明符](reflection-system/metadata-specifiers/index.md)的宏封装你的类，它提供编辑器功能。每个类都定义了一个新的Object或Actor的模板。
- [虚幻引擎中的容器](containers/index.md)提供关于类和数据结构的集合信息。
- 使用[Gameplay Architecture](../gameplay-systems/programming-with-cpp/index.md) 在虚幻引擎中构建你的项目。Gameplay框架提供了一个由Object和Actor构成的结构。这些类包含模板变量和函数，你可以在创建和设计互动体验时使用。
- 创建[委托](delegates-and-lambda-functions/index.md))能够一种通用的、类型安全的方式调用C++对象上的成员函数。你可以动态地将一个委托绑定到一个任意对象的成员函数上，并在未来的某个时间调用该对象的函数，即使调用者不知道该对象的类型。

## 章节目录

- [虚幻引擎反射系统](reflection-system/index.md) - 为开发用于虚幻引擎的Objects的程序员提供的信息。

- [代码规范](epic-cplusplus-coding-standard/index.md) - 通过遵守既定标准和最佳实践，编写可维护的代码。

- [虚幻引擎中的容器](containers/index.md) - 关于虚幻引擎中各种类和数据结构的信息。

- [游戏性架构](../gameplay-systems/programming-with-cpp/index.md) - 创建和实现游戏性类的参考。

- [委托](delegates-and-lambda-functions/index.md) - 在C++对象上引用和执行成员函数的数据类型。
