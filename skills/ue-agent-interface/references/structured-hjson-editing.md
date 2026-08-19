# Structured HJSON Editing

本页定义单文件和 folder HJSON 的日常编辑流程。字段细节仍以 `docs/UeAgentInterface/HjsonAuthoring_Guide.md`、当前命令 authoring pack、实际导出和 readback 为准。

## 选择编辑面

编辑前确认：目标资产/owner、单文件或 folder、authoring profile、目标文件/ref、可写/readonly/unsupported 范围、validate/diff/apply/readback 命令，以及 compile/save/probe/screenshot 验收要求。

优先级：

1. 支持 folder HJSON 的复杂资产直接编辑 folder authoring。
2. 单文件资产使用单文件 HJSON round-trip。
3. 新增内容先最小 seed -> apply -> readback -> patch 必要字段。
4. 原子命令只用于 bootstrap、只读 probe、迁移、schema 边界、局部修复和故障恢复。

`_json` 可以保留为稳定命令名，但文件 authoring 统一使用 HJSON。HTTP/CLI JSON envelope 和第三方协议 JSON 不属于文件格式迁移范围。

## Folder 导航

```text
folder root
-> ExportProfile included_files
-> tutorial read_order / required identity-entry files
-> target section/ref when present
-> target authoring file
-> required owner context/direct refs
```

- 默认不读 sibling、raw、readonly、debug、coverage、report 或完整 readback。
- ref 必须留在 package 根目录内，不能使用越界相对路径。
- Details group 已由 `details/index.hjson` 和 group 文件表达，不再输出 `category_path`。
- 公共路径 resolver 统一处理 owner、group、section 和 stem；不得重复拼接形成多余中间目录。
- 一个目标能在一个文件表达时，不联动修改无关文件。

## 字段规则

默认 authoring 字段使用：

- `property_path` 或域内 selector：定位字段；
- `selector`：定位结构对象；
- `display_name`、`value_kind`、结构化 `value`；
- 条件适用时使用 `availability`、`tooltip` 和 `candidates`。

限制：

- 有可靠 `value` 时不输出 `value_text`；它只用于 debug/readback 或契约明确的无可靠结构值 fallback。
- grouped Details 不输出 `category_path`。
- 普通属性不输出复数 `operations` 能力列表。
- 单数 `operation` 只用于 add/remove/replace/clear/rename/set_binding/upsert 等结构意图；普通值修改只改 `value`。
- `control_type` 由 `value_kind`、`candidates` 和值结构推导。
- enum/choice 写 `value.selected`，且必须来自 `candidates`。
- `full_name/class_path/asset_path/object_path` 等旧身份只用于 legacy/debug/readback；新 seed 使用公开 `path` 或 `name`。

## 最小编辑

1. 新增节点、模块、组件、控件或 expression 前先运行 `node_catalog_search` 搜索 3-5 条候选，只对选中行的 `path/full_name/name` 做唯一 `exact` 查询。若该 kind 有正式 Apply 投影，读取独立的 `seed` 与 `placement`；Catalog 不提供 operation、owner patch、父级、连线、layout、默认值或 readback。
2. 最小 seed 只写公开身份、归属、必要 selector 和用户要求的初始值。
3. 不手写 id、template、slot、pin、默认属性、derived 字段和 diagnostics。
4. 跨文件引用使用正式 ref，不复制被引用对象全文。
5. 删除/重命名前检查 owner、ref、binding 和 index 更新要求。

## 直接与程序化编辑

- 小范围修改可以直接编辑完整目标 HJSON 对象，写后必须 parse。
- 程序化文件读取使用 `load_authoring_file(...)`；字符串读取使用 `loads_authoring_hjson(...)`。
- 写出使用 `write_authoring_file(...)` / `dumps_authoring_hjson(...)`。
- 批量、重复数组或跨文件一致性修改使用结构化 Python API。
- 不使用正则、全局字符串替换、手工拼接或 `json.dumps(..., indent=2)` 修改 authoring。
- 程序化重写不得无必要改变未修改字段、文件布局和稳定顺序。

## 同行与字符串安全

公共 writer 的固定规则：

1. object 递归计算有效字段数；scalar 计 1。
2. 不含 object 的 list 在所属 object 中计 1，并整体同行。
3. 嵌套 object 的字段递归累计。
4. object 有效字段数 `<= 6` 且所有子值可同行时整体同行，否则折行。
5. 含 object 的 list 不作为普通同行列表，各 object 继续按同一规则判断。

字符串可能包含 `#`、`//`、`/*`、引号、反斜杠、冒号、逗号、边界符、换行和 Unicode。把原值交给 HJSON writer，由 writer 决定引用和转义；不得为同行截断、双重转义或改变换行。重要写入执行 parse -> write -> parse round-trip。

## Apply 与验证

```text
export/readback
-> navigate target
-> minimal edit
-> parse/round-trip
-> validate/diff/dry-run
-> preflight/apply
-> compile/save
-> export/readback/probe/screenshot
-> semantic comparison
```

- 多文件变更全部 parse/validate 通过后才 apply。
- apply 后导出到独立 readback 位置，不覆盖 authoring 输入。
- diff 比较业务语义，不把空白、同行方式和字段顺序当作业务变化。
- readback 缺少目标、值不一致、分支不活跃或 compile 失败时，任务未完成。
- 大型 readback 只投影目标对象/字段，完整证据留在 artifact。
