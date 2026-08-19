# UObject 属性值协议 v2

`uai.uobject_properties.v2` 是 UAI 反射属性导出、HJSON authoring 和回写的唯一正式协议。Export 始终输出本文件定义的 canonical value；Apply 在已由反射确定真实字段类型时，也接受本节列出的类型定向简写并自动补全为 canonical value。Apply 简写不会改变 Export 输出。v1、`value_text` 写入、`property_name` 别名和 `ImportText` fallback 不属于 v2 输入。

## 字段契约

每个可写属性条目至少包含：

```hjson
{
  property_path: Intensity
  value_kind: float
  value: { literal: 5000 }
}
```

- `property_path` 是 owner 内唯一写入身份，不接受 `property_name` 或 `selector` 替代。
- `value_kind` 必须与 UE 反射得到的实际 `FProperty` 类型完全一致。
- `value` 是唯一写入来源。只要 `value` 存在但不合法，整次 owner apply 失败，不得回退到 `value_text`。
- `category_path` 不进入 authoring descriptor、group 文件或 `details/index.hjson`；分组目录和文件名已经表达导航关系。
- `value_text` 只用于 debug/readback，或无法生成可靠 canonical value 的只读诊断；不能用于 authoring apply。
- 共享状态快照不随 Export profile 改变；profile 过滤在公共 projection 层处理 authoring envelope。`llm_authoring` 会在存在可靠同级 `value` 时移除 `value_text`，readback/debug 保留它，canonical `value` 内部的同名业务字段不受影响。

## 基本类型

bool、数值、字符串、name 和 text 使用 `literal`：

```hjson
{ value_kind: bool, value: { literal: true } }
```

```hjson
{ value_kind: int32, value: { literal: -12 } }
```

```hjson
{ value_kind: double, value: { literal: 0.125 } }
```

```hjson
{ value_kind: string, value: { literal: "text with {}[],:#" } }
```

Apply 可在 `value` 中直接提交对应的裸 bool、number 或 string；字段真实类型来自 UE 反射，不通过 JSON 值猜测类型。text 的裸 string 按普通非本地化文本处理，enum 的裸 string 按枚举项名称处理。Export 和 readback 仍只输出上面的 canonical object：

```hjson
{ property_path: bEnabled, value: true }
```

```hjson
{ property_path: Intensity, value: 5000 }
```

```hjson
{ property_path: DisplayName, value: "雷击区域" }
```

```hjson
{ property_path: Mobility, value: Movable }
```

整数 kind 精确区分 `int8/int16/int32/int64/uint8/uint16/uint32/uint64`。`int64` 和 `uint64` 的 `literal` 必须是十进制字符串，防止 JSON/HJSON number 丢失整数精度：

```hjson
{ value_kind: int64, value: { literal: "9007199254740993" } }
```

enum 使用枚举项名称；bitmask 使用枚举项名称列表：

```hjson
{ value_kind: enum, value: { selected: Movable } }
```

```hjson
{ value_kind: bitmask, value: { selected: [OptionA, OptionC] } }
```

`bitmask` 只在 `BitmaskEnum` 能通过 UE 反射可靠解析时成立；此时 descriptor 同时携带枚举约束，`selected` 必须使用真实枚举项名称。如果属性声明了 bitmask metadata，但当前反射生命周期无法解析对应枚举，Export 必须按属性的底层整数类型输出 `literal`，Apply 也按同一整数类型解码。不得输出缺少 enum 约束、无法验证或无法回写的伪 `bitmask`。这种回退保留完整位值；枚举重新可解析后才恢复名称列表形式。

## 固定分量类型

分量顺序由 `value_kind` 固定，不输出 `x/y/z/w/r/g/b/a` 字段名：

```hjson
{ value_kind: vector2, value: { components: [1, 2] } }
```

```hjson
{ value_kind: vector3, value: { components: [1, 2, 3] } }
```

```hjson
{ value_kind: vector4, value: { components: [1, 2, 3, 4] } }
```

```hjson
{ value_kind: rotator, value: { components: [10, 20, 30] } } // pitch, yaw, roll
```

```hjson
{ value_kind: quat, value: { components: [0, 0, 0, 1] } }
```

```hjson
{ value_kind: color8, value: { components: [255, 128, 0, 255] } }
```

```hjson
{ value_kind: linear_color, value: { components: [1, 0.5, 0, 1] } }
```

长度必须完全匹配。`color8` 分量必须是 `0..255` 整数，quat 写入后归一化。

Transform 保留语义字段，但字段内部使用固定数组：

```hjson
{
  value_kind: transform
  value: {
    translation: [100, 0, 50]
    rotation: [0, 90, 0] // pitch, yaw, roll
    scale: [1, 1, 1]
  }
}
```

## Struct

通用 struct 使用 `fields`。每个成员按自身实际 `FProperty` 类型递归编码，不允许把 struct 成员降级为文本或统一裸值：

```hjson
{
  property_path: Bounds
  value_kind: struct
  struct_path: "/Script/CoreUObject.Box"
  value: {
    fields: {
      Min: { components: [-100, -100, 0] }
      Max: { components: [100, 100, 500] }
      IsValid: { literal: true }
    }
  }
}
```

authoring export 会递归只投影可编辑且安全的 struct 成员；无 `CPF_Edit`、`EditConst`、transient、deprecated 等内部成员不会进入 authoring value，但仍可进入 readback/debug 诊断。域级 provider 可以通过共享的三态 struct field override 明确授权由该域专用解析器管理的非普通 Edit 成员；未作决定时继续使用通用反射规则，显式拒绝时不得由通用规则重新放行。transient、deprecated 等危险成员不受域级 override 放宽。apply 接受部分 `fields`：显式成员按真实 `FProperty` 类型递归解析，缺失成员保留现值；创建新值时由 UE 初始化后的默认结构补全。未知成员、成员 shape 错误，或显式提交只读/危险成员仍会失败，不能借部分写入覆盖内部缓存。

`FInstancedPropertyBag`、`FInstancedStruct` 等动态结构沿用同一递归规则：动态 schema 必须先明确每个字段的真实类型，已知 Vector/Rotator/Color/Transform 成员仍按对应固定结构编码，不能因为外层是动态 struct 就降级为普通 object 或文本。apply 会按请求中的动态 `struct_path` 再执行一次递归写资格检查，不能通过切换动态类型绕过门禁。

## 容器和 Optional

容器条目必须声明递归内层类型，元数据由反射生成且不可改写：

```hjson
{
  property_path: Points
  value_kind: array
  element_type: { kind: vector3 }
  value: { items: [{ components: [0, 0, 0] }] }
}
```

```hjson
{
  property_path: Lookup
  value_kind: map
  key_type: { kind: name }
  mapped_type: { kind: vector3 }
  value: {
    entries: [{ key: { literal: Origin }, value: { components: [0, 0, 0] } }]
  }
}
```

- array/set/fixed array 使用 `element_type`。
- map 使用 `key_type` 和 `mapped_type`。
- optional 使用 `inner_type`，值为 `{is_set:false}` 或 `{is_set:true,value:<canonical>}`。
- fixed array 额外使用 `fixed_length`，值为 `{items:[...]}`，长度必须相等。
- 被导出上限截断的容器会标记 `truncated:true`，只能用于 readback，apply 必须拒绝。
- 合法递归结构没有固定人工深度上限。共享 Object Apply 与 PropertyValueCodec 不使用 `MaxDepth` 拒绝 authoring 输入；循环依据 UObject identity 的当前 active path 判断，深结构与环不能互相替代。容器元素、字符串、输入总量、时间和内存仍可作为独立资源预算。

## 引用

hard/soft/weak/lazy/class/interface reference 的 canonical value 都使用 `{path: ...}`；空引用使用 `{path:null}`。各引用类型有独立 `value_kind`，并携带反射得到的 `allowed_class`。Apply 在字段类型已知时也接受裸对象路径 string 或 `null`，并在共享 codec 中补全为同一引用结构；Export 始终保留 `{path: ...}`。

soft reference 的 authoring 校验只验证规范对象路径和类型约束，不为校验而强制加载资产；hard/class/interface reference 在提交前解析真实对象并检查类型。

## Apply 语义

1. 校验 schema、`property_path` 唯一性、可编辑性、`value_kind`、容器类型元数据和 canonical value。
2. 所有字段在临时属性内存中完整解码；任一字段失败时 owner 保持不变。
3. create/replace omitted 内容从 UE factory、constructor、CDO/archetype/template、struct initializer、schema 或真实 staged object 补全；provider 输入即使采用 codec shorthand，也必须先进入 typed storage，再 canonical encode/readback。多态 owned object 缺少 existing/explicit/可靠 class source 时返回 `owned_object_class_source_required`。
4. 预检全部通过后，在同一 transaction 中提交。
5. 写后先使用 `FProperty::Identical` 比较；若底层内存不等，再执行类型语义比较。float/double 使用类型匹配容差，Rotator/Quat/Transform 按等价旋转比较，其余类型回到 canonical value 比较。任一字段仍不一致时恢复整组快照。
6. 全部读回一致后才标记 package dirty 并返回 `applied`。

Folder grouped Details 可以保留 `availability.editable:false` 的诊断字段，但提交该字段仍会失败；通用 UObject apply 总会重新检查真实反射写资格，删除或篡改 availability 不能把 unavailable 字段变成可写。

delegate、multicast delegate、field path、Verse value 和无法递归编码的 opaque property 只进入 unavailable/debug 诊断，不进入 authoring apply。

带 `EditCondition` 的 UObject 字段、UObject 内嵌 struct 字段和 struct root 字段统一使用 UE PropertyEditor 的属性句柄语义求值。整批 descriptor 会先解码并复制到临时 UObject 或 `FStructOnScope`，再按字段地址定位属性句柄并评估 proposed values，因此控制字段与受控字段的排列顺序不影响结果；条件为 false 时返回 `property_edit_condition_false`，无法建立真实属性句柄时返回 `property_edit_condition_evaluation_failed`。该流程不使用字符串正则猜测 EditCondition 表达式。
