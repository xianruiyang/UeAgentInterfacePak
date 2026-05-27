---
title: "Structs"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/structs-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "虚幻引擎反射系统", "Structs"]
---

# Structs

> 路径：虚幻引擎5.7文档 / 用C++编程 / 虚幻引擎反射系统 / Structs

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/structs-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

A **struct** is a data structure that helps you organize and manipulate its member properties. Unreal Engine's reflection system recognizes structs as a `UStruct`, but they are not part of the [UObject](../objects/index.md) ecosystem, and cannot be used inside of [UClasses](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/CoreUObject/UObject/UClass?application_version=5.5).

- A `UStruct` is faster to create than a `UObject` with the same data layout.
- UStruct supports [UProperty](https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-uproperties?application_version=5.7), but are not managed by the Garbage Collection system and cannot provide the functionality of a [UFunction](https://dev.epicgames.com/documentation/unreal-engine/ufunctions-in-unreal-engine?application_version=5.7).

## Implement a UStruct

To make a struct into a `UStruct`, follow the steps below:

1. Open the **header (.h)** file where you want to define your struct.
2. To define your C++ struct, put the `USTRUCT` macro above the struct's definition.
3. Include the `GENERATED_BODY()` macro as the first line of the definition.

The result should look like the following example:

C++

```
USTRUCT([Specifier, Specifier, ...])	struct FStructName	{		GENERATED_BODY()	};
```

> [!NOTE]
> You can tag the struct's member variables with `UPROPERTY` to make them visible to the Unreal Reflection System and Blueprint Scripting. See the list of [UProperty Specifiers](https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-uproperties?application_version=5.7) to learn how the property can behave in various [模块](../../programming-in-the-unreal-engine-architecture/unreal-engine-modules/index.md) of the Engine and Editor.

## Struct Specifiers

**Struct Specifiers** provide metadata that controls how your structs behave with various aspects of the Engine and Editor.

| Struct Specifier | Effect |
| --- | --- |
| `Atomic` | Indicates that this struct should always be serialized as a single unit. No auto-generated code will be created for this class. The header is only provided to parse metadata from. |
| `BlueprintType` | Exposes this struct as a type that can be used for variables in Blueprints. |
| `NoExport` | No auto-generated code will be created for this class. The header is only provided for parsing metadata. |

## Best Practices & Tips

Below are some helpful tips to remember when you use `UStruct`:

1. `UStruct` can use Unreal Engine's [smart pointer](../smart-pointers/index.md) and garbage collection systems to prevent garbage collection from removing`UObjects`.
2. Structs are best used for simple data types. For more complicated interactions in your project, you might want to make a `UObject` or `AActor` subclass instead.
3. `UStructs` **ARE NOT** considered for replication. However, `UProperty` variables **ARE** considered for replication.
4. Unreal Engine can automatically create Make and Break functions for Structs.

   1. Make appears for any `UStruct` with the `BlueprintType` tag.
   2. Break appears if you have at least one `BlueprintReadOnly` or `BlueprintReadWrite` property in the UStruct.
   3. The pure node that Break creates provides one output pin for each property tagged as `BlueprintReadOnly` or `BlueprintReadWrite`.
