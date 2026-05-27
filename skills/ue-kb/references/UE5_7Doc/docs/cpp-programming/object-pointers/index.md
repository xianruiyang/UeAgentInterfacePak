---
title: "Object Pointers"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/object-pointers-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "Object Pointers"]
---

# Object Pointers

> 路径：虚幻引擎5.7文档 / 用C++编程 / Object Pointers

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/object-pointers-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

Unreal Engine 提供了多种模板化智能指针，用于不同使用场景。 所有 Unreal Engine 对象指针类型都必须使用 `UObject` 类型构造，也就是派生自以下类型的类： `UObject`.

下表概述 Unreal Engine 中可用的对象指针类型及其部分属性。表格列包括：

- **指针类型**：指针类型。
- **用法**：该指针类型是常用、需谨慎使用、已标记弃用，还是已移除。
- **支持 UPROPERTY？**: 该指针类型是否可以标记为 `UPROPERTY`.
- **影响 GC？**：此类型指向目标对象的指针存在时，是否会让被引用对象保持存活。
- **支持按需加载？**：该指针类型是否跟踪目标对象在磁盘上的路径，以便之后加载。
- **可序列化？**：该指针类型是否支持序列化目标对象以便存储。
- **支持网络？**：是否具备网络序列化器，并用于或支持复制属性或远程过程调用。

在本页面中，假设模板类型 `T`.

| 指针类型 | 用法 | 支持 UPROPERTY？ | 影响 GC？ | 支持按需加载？ | 可序列化？ | 网络支持？ |
| --- | --- | --- | --- | --- | --- | --- |
| `T*` (Raw Pointer) | 常用 | ❌* | ❌* | ❌ | ❌* | ❌* |
| `TObjectPtr<T>` | 常用 | ✔️ | ✔️ † | ❌ | ✔️ | ✔️ |
| `TLazyObjectPtr<T>` | Deprecated ‡ | ✔️ | ❌ | ❌ | ✔️ | ❌ |
| `TSoftObjectPtr<T>` | 常用 | ✔️ | ❌ | ✔️ | ✔️ | ✔️ |
| `TWeakObjectPtr<T>` | 常用 | ✔️ | ❌ | ❌ | ✔️ | ✔️ |
| `TStrongObjectPtr<T>` | 使用 Caution § | ❌ | ✔️ ❡ | ❌ | ❌ | ❌ |

> [!NOTE]
> **表格脚注：**
>
> * 可以配置 Unreal Header Tool（UHT），以启用标记为 `UPROPERTY`, 在这种情况下，裸指针会影响 GC，支持序列化，并支持网络。 已有 `UPROPERTY`-标记的裸指针应迁移为使用 `UPROPERTY`-标记的 `TObjectPtr` ，如果可行。
>
> † `TObjectPtr` 只有在标记为以下内容时才是垃圾回收安全的： `UPROPERTY`.
>
> ‡ `TLazyObjectPtr` 已弃用，并标记为将在未来引擎版本中移除，请改用 `TSoftObjectPtr` 。
>
> § 请参阅 `TStrongObjectPtr` 部分了解更多信息。
>
> ❡ 由于 `TStrongObjectPtr` 不能标记为 `UPROPERTY`, 因此它会在所有位置影响垃圾回收（栈上、lambda 捕获中等）。

## 对象指针快速指南

下面是一个快速指南，用于判断常见场景应使用哪种指针。 `TLazyObjectPtr` 已弃用，因此从下表中省略。

| 使用场景... | 使用指针类型... |
| --- | --- |
| 未标记为 `UPROPERTY`-字段的局部变量、参数或短生命周期引用。 | `T*` (Raw Pointer) |
| 持久 `UObject` 引用，位于 `UCLASS` or `USTRUCT` 上，并被 GC 跟踪、序列化或复制。 | `TObjectPtr<T>` |
| 对资产的引用，该资产不应在请求前被强制加载，也不应创建硬依赖。 | `TSoftObjectPtr<T>` |
| 对 `UObject` 的非拥有引用或缓存，该对象可能随时被销毁。 | `TWeakObjectPtr<T>` |
| 对 `UObject` 的强引用，来自非`UObject` 类或结构体。 | `TStrongObjectPtr<T>` |

## 指针类型

本节更详细介绍每种指针类型，并提供示例使用场景，帮助判断何时使用每种类型。

### TObjectPtr

`TObjectPtr` is meant 标记为 裸指针的直接替代品. `TObjectPtr` 只能与派生自以下类型的类型一起使用： `UObject`. 它的序列化方式与指向以下类型的裸指针相同： `UObject`. 当 `TObjectPtr` is 标记的 标记为 `UPROPERTY`, 时，它是对对象的强引用，会影响垃圾回收，并阻止垃圾回收销毁目标对象。

`TObjectPtr` 应尽可能代替裸指针使用，因为它支持高级 cook 时依赖跟踪，并启用垃圾回收屏障，从而解锁增量垃圾回收标记。 `TObjectPtr` also supports replication.

绝不应直接访问 `UObject` 通过 `TObjectPtr` 从工作线程访问，除非确定其中包含的对象已经正确 root，并且在访问期间不会被垃圾回收。’re accessing them. 要处理 `UObject`s ，请从工作线程使用 `TWeakObjectPtr` 并通过 `TWeakObjectPtr::Pin` 方法获取 `TStrongObjectPtr` 指向目标 `UObject` 前提是目标对象仍然有效。

示例使用场景： `TObjectPtr` 包括：

- `UPROPERTY`-标记为 UPROPERTY 的指针，指向 `UObject` ，位于另一个 `UObject`.

  - C++

    ```
    class UMyObject : UObject{    // ...     UPROPERTY()    TObjectPtr<UMyOtherObject> MyOtherObject;}
    ```
- 对 Actor 组件的硬引用。

  - C++

    ```
    class AMyActor : AActor{    // ...     UPROPERTY()    TObjectPtr<UStaticMeshComponent> Mesh;}
    ```

### TLazyObjectPtr

> [!WARNING]
> `TLazyObjectPtr` is 标记的 将在未来引擎版本中弃用. 新功能应使用 `TSoftObjectPtr` 。

`TLazyObjectPtr` is a lazy, GUID-based, weak pointer. `TLazyObjectPtr` 如果目标对象尚未加载，它不会加载目标对象；随着对象载入和卸出内存，它可在有效和等待状态之间切换。 `TLazyObjectPtr` 不会阻止目标对象被垃圾回收。

### TSoftObjectPtr

`TSoftObjectPtr` 是对对象的弱引用，会跟踪目标对象在磁盘上的路径，并且不影响被指向对象是否被垃圾回收。 由于 `TSoftObjectPtr` 会跟踪对象在磁盘上的路径，因此随着引用对象载入和卸出内存，它可能在有效和等待状态之间来回变化。 这对需要按需异步加载的资产或避免硬依赖很有用。 如果目标对象尚未有效，必须显式同步或异步加载它。

示例使用场景： `TSoftObjectPtr` 包括：

- 按路径同步或异步加载对象。

  - C++

    ```
    public AMyActor : AActor
    {
        // ...

        UPROPERTY(EditAnywhere)
        TSoftObjectPtr<UNiagaraSystem> NiagaraVFX;

        // Use NiagaraVFX.Get() inside OnLoadComplete
        void OnLoadComplete();
    }
    ```

### TWeakObjectPtr

`TWeakObjectPtr` 是指向对象的弱指针。 A `TWeakObjectPtr` 不需要标记为 `UPROPERTY`, 不过 `UPROPERTY` 是支持的。 `TWeakObjectPtr` 支持序列化，也支持网络。 多数情况下， `TWeakObjectPtr` 用于明确不想阻止对象被垃圾回收的场景。 如果目标对象被垃圾回收或销毁，弱指针会自动变为 null。 始终检查 `TWeakObjectPtr` 是否有效，可使用 `TWeakObjectPtr::IsValid` 或使用 `TWeakObject::Get` 并在使用前测试是否为 null。

> [!WARNING]
> `TWeakObjectPtr` 不支持作为 `TMap`, 中的元素，也不支持作为 `TSet`. 如果想使用 `UObject` 作为键，请使用 `TObjectKey` 。

示例使用场景： `TWeakObjectPtr` 包括：

- 缓存对象。

  - C++

    ```
    // Object Cache
    TMap<TSubclassOf<UObject>, TWeakObjectPtr<UObject>> CachedObjects;

    // Get cached object by class, if still valid
    UObject* GetCachedObject(TSubclassOf<UObject> CachedObjectClass)
    {
        if (TWeakObjectPtr<UObject> FoundObject = *CachedObjects.Find(CachedObjectClass))
        {
            // If running on the game thread, this pattern is permissable:
            if (FoundObject.IsValid())
    ```
- 在 lambda 中捕获弱对象指针。

  - C++

    ```
    FSimpleDelegate MyDelegate;
    TObjectPtr<UMyObject> MyObject;

    MyDelegate.BindLambda(
        [MyWeakObject = MakeWeakObjectPtr(MyObject)]()
        {
            if (TStrongObjectPtr<UMyObject> MyStrongObject = MyWeakObject.Pin())
            {
                // object safe to access
            }
    ```

### TStrongObjectPtr

`TStrongObjectPtr` 是指向对象的强指针。 `TStrongObjectPtr` 会计数对目标对象的引用，并在其作用域内阻止垃圾回收，从而强制保持目标对象存活。 `TStrongObjectPtr` 不支持 `UPROPERTY`, 因此不适合作为以下类型中的字段： `UObject`-派生类。 将 `TStrongObjectPtr` 内部的 `UObject` 标记为 `UPROPERTY` 容易创建无法回收的循环。 例如，如果一个 `UObject`-派生类拥有一个 `TStrongObjectPtr` 成员字段并将其设置为指向自身，就会创建一个无法回收的循环。也就是说，即使没有其他引用指向该对象，该对象也永远不会被删除 (以下类型的自引用不会出现这种情况： `TObjectPtr` 自引用）。 由于 `TStrongObjectPtr` 不支持 `UPROPERTY`, 它对调试工具的可见性也较低，因此更难判断目标对象为什么仍然存活。

创建和销毁 `TStrongObjectPtr` 是昂贵操作，应尽可能避免。 使用 `TStronObjectPtr` 处理生命周期较长且不常变化的引用。 因此， `TStrongObjectPtr` 应避免在 Mass 等对象不太可能在帧更新之间被删除的系统中使用。 每个 `TStrongObjectPtr` 都会为垃圾回收添加一个被跟踪引用。 `TStrongObjectPtr` 始终是强引用，会保持目标对象存活，即使该对象已不可达并本可被垃圾回收。 因此， 使用 `TStrongObjectPtr` 可能降低性能。

`TStrongObjectPtr` 用于存储对 `UObject` 的强引用，位于非`UObject` 所有者类中，例如不派生自 `UObject` 的类或结构体，因为 `UPROPERTY` 不能在以下类型外部使用： `UObject`.

对于以下使用场景，请使用建议的指针类型，而不是 `TStrongObjectPtr`:

- 对于以下类型内部的拥有引用： `UObject` 类，请使用 `TObjectPtr` 标记的 标记为 `UPROPERTY`.
- 对于非拥有引用，请使用 `TWeakObjectPtr`. 对于资产引用，请使用 `TWeakObjectPtr`.

示例使用场景： `TStrongObjectPtr` 包括：

- Strong reference to `UObject` 位于非`UObject` 所有者中。

  - C++

    ```
    class FMyClass{    // ...     // Strong reference to a UObject inside a non-UObject class    TStrongObjectPtr<UMyObject> MyObject;}
    ```
