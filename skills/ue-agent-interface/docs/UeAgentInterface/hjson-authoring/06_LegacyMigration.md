# Legacy Rejection And Deprecation

本页定义结构化 HJSON authoring 对旧输入和 deprecated 命令的拒绝边界。活跃 UAI 不保留旧 JSON、旧 workspace、旧字段迁移器或 legacy adapter；历史材料只用于审计，不是可执行兼容路径。

## Authoring 主路径

- 目录输入只接受对应 folder contract 声明的 HJSON 文件树。
- 单文件和 inline 输入先归一为同一 virtual bundle，再进入统一 Workspace Apply 和 Object Apply。
- Export 只由当前 ExportContract、snapshot 和 profile 决定，不生成旧 `asset.json`、`manifest.json`、split `properties.json` 或旧 full-object index。
- 旧输入命中时 fail-fast，返回稳定的 unsupported/legacy 错误；不得自动改名、补文件、迁移字段或回退到另一套解析器。

## 旧结构

以下结构不能作为活跃 authoring 输入：

- JSON 格式的 authoring workspace 或 `.json` 属性 sidecar。
- 旧平铺 `graphs/<name>.hjson` 和 graph 内混合 layout。
- 旧 split `properties.hjson`、`raw_properties.*`、`readonly_properties.*`。
- 旧 full-object `index.hjson`、`asset.hjson` 或 `manifest.hjson`，除非当前 profile 的正式 contract 明确声明该文件角色。
- 通过 `legacy_path`、旧 identity alias 或历史文件位置推断新 target。

需要恢复历史内容时，先由人工或一次性离线脚本显式转换成当前 contract，再作为普通新输入验证；该转换工具不进入 UAI runtime、CLI 主路径、skill 或发布包。

## 字段边界

`asset_path`、`class_path`、`object_path` 等名称可能仍是某些独立命令的正式参数或 readback 字段，是否可用只由该命令当前 CommandSpec 决定。folder authoring 不把这些名称自动转换成 `path/name`，也不因为字段名相似而启用兼容语义。

新 authoring 示例只使用当前 contract 声明的 identity、selector、target、properties 和 provider extension。未知字段直接拒绝。

## Deprecated 命令

`commands/deprecatedCommand/**` 只保存历史说明，不进入默认搜索、教程包、command pack 或 authoring route。当前 CLI 对 deprecated 命令 fail-closed，并返回正式 replacement 或明确的无替代原因。

普通资产制作、节点新增、属性写入和 folder authoring 不得调用 deprecated 命令。诊断历史工程时也不能把 deprecated 命令包装成新的兼容入口。

## 验证要求

- `no_json_authoring_guard` 必须扫描为零问题，且不为迁移器设置例外。
- authoring coverage 的 `legacy_path` 必须为 0。
- 活跃源码不得引用旧 JSON/HJSON workspace parser、legacy field migrator 或 P2 migration shard。
- 历史文档只能位于明确排除的归档目录，不同步到日常 skill 文档路由。
