# Common Input Value Contract

本页只定义 `uai.uobject_properties.v2` 的通用 UObject/FProperty descriptor 与 value codec。领域结构由各自的动态 authoring schema 定义字段形态；只有领域 schema 明确引用本合同的值，才复用这里的 canonical value，不能把本页的 Transform 容器形态套用到所有领域。

## UObject Descriptor

```hjson
{
  property_path: Intensity
  value_kind: float
  value: { literal: 5000 }
}
```

- `property_path`、`value_kind`、`value` 是可写 descriptor 的核心字段。
- `property_path` 是唯一属性身份，不接受 `property_name`、`name`、`selector` 替代。
- `value` 是唯一写入来源；authoring 不接受 `value_text` 或 `import_text`。
- `display_name`、`tooltip`、`availability`、`constraints`、`candidates` 只在确有额外编辑语义时保留。
- 普通属性赋值不使用 `operation/operations`。
- `control_type` 可由 `value_kind` 推导，不输出。

## Canonical Values

| 类型 | `value_kind` | canonical `value` |
| --- | --- | --- |
| bool | `bool` | `{literal:true}` |
| 精确整数 | `int8/int16/int32/uint8/uint16/uint32` | `{literal:12}` |
| 64 位整数 | `int64/uint64` | `{literal:"9007199254740993"}` |
| 浮点 | `float/double` | `{literal:12.5}` |
| 文本 | `string/name/text` | `{literal:"Player"}` |
| enum | `enum` | `{selected:ValueName}` |
| bitmask | `bitmask` | `{selected:[FlagA,FlagB]}` |
| Vector2/3/4 | `vector2/vector3/vector4` | `{components:[...]}` |
| Rotator | `rotator` | `{components:[pitch,yaw,roll]}` |
| Quat | `quat` | `{components:[x,y,z,w]}` |
| Color | `color8/linear_color` | `{components:[r,g,b,a]}` |
| Transform（仅 `uai.uobject_properties.v2`） | `transform` | `{translation:[x,y,z],rotation:[pitch,yaw,roll],scale:[x,y,z]}` |
| 引用 | `object_ref/soft_object_ref/class_ref/...` | `{path:"/Game/A.A"}` 或 `{path:null}` |

在本页负责的 UObject/FProperty codec 中，固定分量必须长度完全一致；不接受 `{x,y,z}`、`{r,g,b,a}` 或 v1 裸数组，Transform 只接受 `translation/rotation/scale` 三个字段。World、Level 或其他领域的 Transform 必须先读取该领域的动态 schema 与 [Space Contract](04_SpaceContract.md)，不得从这一行推断其输入形态。

硬 UObject 引用在导入时会先解析已加载的 `UObjectRedirector` 链，再对最终对象执行 allowed-class 校验。重定向链循环或最终对象类型不兼容会拒绝导入；不能把 redirector 自身的类型当作目标类型，也不能依赖重启 Editor 后重定向对象恰好未加载的状态。

精确类型、struct、容器、optional、引用约束和 apply 原子语义见 `../UObjectPropertyValueV2.md`。

## Struct And Containers

通用 struct 使用 `value.fields`，成员继续按真实类型编码：

```hjson
{
  property_path: Bounds
  value_kind: struct
  struct_path: "/Script/CoreUObject.Box"
  value: {
    fields: {
      Min: { components: [-100, -100, -100] }
      Max: { components: [100, 100, 100] }
    }
  }
}
```

容器必须携带递归类型：

- array/set/fixed array: `element_type`
- map: `key_type` 和 `mapped_type`
- optional: `inner_type`
- fixed array: `fixed_length`

列表值使用 `{items:[...]}`，map 使用 `{entries:[{key:...,value:...}]}`。重复 set 项、重复 map key、错误固定长度和截断值都会在 preflight 失败。

## Enum And Candidates

enum descriptor 应携带 `candidates` 或 `candidates_ref`。LLM 只修改 `value.selected`，不能写展示名或底层数字。bitmask 的 `selected` 是候选名称列表。

`bitmask` 需要 UE 反射能够解析 `BitmaskEnum`。若 metadata 存在但枚举当前不可解析，公共 codec 会按真实底层整数 kind 导出和回写，例如 `{value_kind:uint8,value:{literal:3}}`；不得构造没有枚举约束的 `selected` 列表。该规则由公共 UObject/FProperty codec 统一处理，不由资产域自行转换。

## Domain Values

领域结构不需要伪装成 FProperty descriptor。例如 Niagara module input 可以保留 `source/default/link/dynamic_input`，Sequence key 可以保留 frame/interpolation。领域层负责业务结构和字段形态；基础值只有在该领域 schema 明确引用本合同的对应 value codec 时才使用上面的 canonical 形态。特别是领域 Transform 可以由自己的 adapter 定义 components object、别名与规范化规则，不能与本页的 UObject Transform 互换。

领域 source 示例：

```hjson
{ value: { source: local_value, literal: 12.5 } }
```

```hjson
{ value: { source: default_value } }
```

```hjson
{ value: { source: linked_input, linked_parameter: Particles.Velocity } }
```

```hjson
{ value: { source: dynamic_input, dynamic_input: { path: "/Niagara/Functions/Random/RandomRangeVector.RandomRangeVector" } } }
```

只有领域文档明确声明支持时才可切换 source。

## Details And Inline Seed

已有 owner 的持续编辑通过相邻 `details/index.hjson` 和 group 文件进行。创建期 owner 可以使用 inline `properties[]` 提供初始值。inline 与 grouped 使用同一 v2 descriptor、preflight、codec 和原子 apply。

同一 owner 不能同时提供 inline properties 和 Details ref，否则返回 `inline_grouped_details_conflict`。`raw_properties`、`readonly_properties`、`missing_properties`、`unsupported_properties` 属于诊断或只读内容，不是通用写入入口。

## HJSON Safety

字符串引用、注释符、冒号、花括号、反斜杠和换行由公共 HJSON writer 处理。批量编辑后必须重新 parse；不要用正则或字符串替换拼装值。

同行规则由公共 writer 统一执行：struct/object 递归有效字段数 `<= 6` 且子值可同行时同行；不含 object 的 list 整体同行并在所属 object 中只计 1 个字段。
