# Common Input Value Contract

本页是所有结构化 JSON authoring 的通用 input/value 教程。只要字段表示“某个可写值”，都应优先使用这里的形态；模块分册只补定位方式和特殊验证。

## 基本原则

1. 可写值统一放在 `value` 对象中。
2. `type_info` 是紧凑编辑语义类型，例如 `bool`、`float`、`enum`、`vector3`、`float_curve`。
3. 普通改值只改 `value` 内部字段。
4. `allowed_values[]` 是 enum/choice 的可写候选；LLM 只能写候选里的值。
5. `display_name`、`display_label`、默认值、raw enum options、override 状态属于只读辅助，不表达写入意图；可写 `value` 对象里不要放 `display_label`。
6. `import_text` 只作为兼容 fallback；生成新 authoring 时不要优先使用它。
7. JSON 输出使用自动紧凑规则：对象暴露出的属性数量低于阈值，且自身或嵌套对象不暴露 list/array 字段时单行；暴露数组字段的对象保持展开。短 `value`、`components` 和 `allowed_values[]` 候选对象通常会单行，复杂 curve、graph、stage、module、input 结构保持多行展开。

## 通用类型写法

| `type_info` 类别 | 写法 | 示例 |
| --- | --- | --- |
| `bool` | `value.literal` | `{ "value": { "literal": true } }` |
| `int` / `float` | `value.literal` | `{ "value": { "literal": 12.5 } }` |
| `string` / `name` / `text` | `value.literal` | `{ "value": { "literal": "Player" } }` |
| `enum` / choice | `value.selected` + `allowed_values[]` | `{ "value": { "selected": "NewEnumerator2" } }` |
| `vector2` / `vector3` / `color` / `rotator` / `quat` | `value.components` | `{ "value": { "components": { "X": 1, "Y": 2, "Z": 3 } } }` |
| `transform` | `value.translation`、`value.rotation`、`value.scale` 或域内 transform object | 需同时带 `space_contract` |
| object/class asset path | 明确语义 path 字段 | `{ "value": { "asset_path": "/Game/Foo.Bar" } }` |
| folder/package path | 明确语义 path 字段 | `{ "value": { "folder_path": "/Game/Generated" } }` |
| curve | `value.curve` | `{ "value": { "curve": { "schema": "ue_agent_interface.curve.v1", "keys": [] } } }` |
| array/object | `value.items` 或域内明确结构 | 保留 JSON 原生结构，不转成字符串 |

## Enum 规则

可编辑 enum 必须有候选项：

```json
{
  "input_name": "Randomness Mode",
  "type_info": "enum",
  "allowed_values": [
    { "value": "NewEnumerator0", "display_label": "Simulation Defaults" },
    { "value": "NewEnumerator2", "display_label": "Non-Deterministic" }
  ],
  "value": {
    "selected": "NewEnumerator2"
  }
}
```

规则：

- LLM 写 `value.selected`。
- 写入值必须来自 `allowed_values[].value`。
- `value.display_label` 不写。
- `allowed_values[].display_label` 只读，用于显示候选语义。
- enum 的数字值、raw `enum_options`、UE 内部 display name 留在 `readback` 或 `diagnostics`。
- 缺少候选项的 editable enum 是 lint error。
- 候选项对象通常保持一项一行，便于扫读和减少不必要行数。

## Source 层

有些 input 不只是“改本地值”，还可以切换来源，例如 default、linked input、dynamic input。统一表达为 `value.source`，但只有对应域声明支持时才可用。

当前已支持的典型来源是 Niagara module input：

```json
{ "value": { "source": "local_value", "literal": 12.5 } }
{ "value": { "source": "default_value" } }
{ "value": { "source": "linked_input", "linked_parameter": "Particles.Velocity" } }
{
  "value": {
    "source": "dynamic_input",
    "dynamic_input": {
      "kind": "niagara_dynamic_input",
      "name": "Random Range Vector",
      "full_name": "/Niagara/Functions/Random/RandomRangeVector.RandomRangeVector"
    }
  }
}
```

通用规则：

- `source` 表示值从哪里来，不替代 `type_info`。
- `local_value` 后面仍按普通 type 写 `literal/selected/components/curve`。
- `default_value` 表示清除本地 override/link，回到默认。
- `linked_input` 必须写明确目标参数。
- `dynamic_input` / `make` 必须写 `kind/name/full_name`，其中 `full_name` 来自 `node_catalog_search(catalog_type=niagara_dynamic_input)`；不能只写 UI 菜单显示名。
- 也可以把 `node_catalog_search.items[].json_authoring` 整个对象放在 input 的 `value` 位置，由 adapter 解包并转成当前 folder apply 需要的 legacy 字段。
- 旧 `script_asset_path` / `node_name` 只作为 adapter 兼容输入和 readback 证据，新 authoring 主路径不使用它们。
- 未支持的 source 必须明确失败，不得静默忽略。

## Operation 边界

普通值编辑不用 `operation`：

```json
{
  "input_name": "Spawn Rate",
  "type_info": "float",
  "value": { "literal": 120.0 }
}
```

`operation` 只用于非普通值意图，例如：

- `add`
- `remove`
- `replace`
- `clear`
- `rename`
- `set_binding`
- `link_existing`
- `create_if_missing`

如果只是把 float 从 10 改到 20，使用 `operation` 反而会让语义变复杂。

## 只读字段

以下字段不应进入可写 authoring 主面：

- `has_override`
- `has_links`
- `generated_class`
- `engine_version`
- `*_count`
- `file`
- `complete_inventory_path`
- `validation`
- `compile_report`
- `runtime_probe`
- `roundtrip_status`
- raw `enum_options`
- raw `input_type` 显示名

需要这些信息时放到 `readback` 或 `diagnostics`。
