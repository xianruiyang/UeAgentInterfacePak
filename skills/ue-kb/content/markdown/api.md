# 简化的批量处理器/查询API（查询执行器）

---
title: "简化的批量处理器/查询API（查询执行器）"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/simplified-mass-processor"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "人工智能", "MassEntity", "简化的批量处理器/查询API（查询执行器）"]
---

# 简化的批量处理器/查询API（查询执行器）

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 人工智能 / MassEntity / 简化的批量处理器/查询API（查询执行器）

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/simplified-mass-processor

## 概述

简化的**批量处理器/查询API**旨在减少创建批量处理器逻辑所需的样板代码，并提高代码的可读性和类型安全性。 这是一个可选的API，当前样式将继续受到支持。

### 使用QueryExecutor创建批量处理器

在.cpp中创建一个结构体按照以下示例继承UE::Mass::FQueryExecutor：

C++

```
struct FExampleExecutor : public UE::Mass::FQueryExecutor
{
  UE::Mass::FQueryDefinition<
    UE::Mass::FMutableFragmentAccess<FExampleFragmentA>,
    UE::Mass::FConstSubsystemAccess<UExampleSubsystem>,
    UE::Mass::FMassTagRequired<FExampleTag>
  > Accessors{ *this };


  virtual void Execute(FMassExecutionContext& Context)
```

目前，QueryExecutors需要由常规UMassProcessor拥有。 此要求将在未来的更新中被删除。

要创建封装器UMassProcessor，请按以下步骤操作：

1. 创建一个继承自UMassProcessor的类。
2. 不要重载ConfigureQuery或Execute函数。
3. 按以下步骤在该处理器的构造函数中创建QueryExecutor：

   C++

   ```
   UE::Mass::FQueryExecutor::CreateQuery<QueryType>(...)
   ```

## 局限性

目前仍然需要UMassProcessor来与批量阶段执行器进行交互。 我们将在未来的更新中修复此问题。

FQueryDefinition模板的声明需要对查询类型进行完整定义，因此在头文件中进行此类操作应仅限于预定义的查询定义（而非大型接口头文件的一部分）。 通常，最佳做法是在使用它们的 .cpp 文件中将其声明为私有成员。

