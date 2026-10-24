# CLI：查询与单次命令

使用已安装的 `ueagentinterfacecmd`。适用于取得一次公开 Result 即可完成的查询或命令；
需要 workspace、operation、artifact 或 PIE 会话句柄时，按所属流程使用 [SDK](sdk-and-runners.md)。

## 发现与调用

已知命令和参数直接执行；未知名称先搜索，再一次查询选中命令的用法：

```powershell
ueagentinterfacecmd exec query.command.search --params-json '{"intent":"asset clone"}'
ueagentinterfacecmd exec query.command.usage --params-json '{"commands":["asset.object.clone"]}'
```

`command_search` 返回命令名；`command_usage` 的 CLI 紧凑输出同时给出 SDK 示例和 `required_params`
必填参数名、类型（来自同一生成 binding）。CLI JSON 按这些名称填写，不根据示例的位置值猜字段名。
参数名称、可选项或嵌套结构不明确时，按需读取同一生成合同，不连接 Editor：

```powershell
ueagentinterfacecmd describe animation.sequence.pose.sample
ueagentinterfacecmd describe animation.sequence.pose.sample --parameter input --pointer /properties/time_point
```

不指定参数只给短列表及已注册的 `variants`；有分支时用 `--variant <variant_id>` 读取所选合同，
再用 `--parameter` 返回该分支的参数结构，`--pointer` 缩到所需部分。未选分支时读取基础参数合同。
SDK 对应 `uai.describe_command(...)`。结构中包含实际必填字段、类型、固定值和枚举，按返回值填写；
没有结构会明确返回 `schema_available: false`；先核对是否应选择已列出的 variant，再查领域合同。
解释 UE 语义时也查所属领域合同。
`--format json` 和 `--report` 保持 SDK 公开结果结构，不附加 CLI 提示。

参数已明确的只读调用示例：

```powershell
ueagentinterfacecmd exec asset.registry_record --params-json '{"target":"/Engine/BasicShapes/Cube.Cube"}'
```

stdout 默认是紧凑阅读格式，完整保留 `ok`、`payload`、`error`：对象用缩进键值，
列表的 `[N]` 表示条目数，统一记录用 `{列名…}` 表头与制表符分隔行；标量列表在一行内用制表符分隔。
有歧义的字符串使用 JSON 引号和转义，空对象/数组/字符串分别为 `{}` / `[]` / `""`。
先判断 `ok`；参数错误按诊断的路径和 `expected` 修正字段，不靠更换搜索词重试同一缺参调用。
不为简单查询编写 Python、参数文件或结果摘要脚本。参数较大或已存在文件时才用 `--params-file`；
复杂多行参数也可经 `--params-stdin` 输入，避免 shell 改写引号。`cli_params_invalid` 给出参数来源、
JSON 错误原因与行列；这时尚未连接 UE，按该位置修正输入，不更换连接或反复改转义。
需要保存完整公开结果时用 `--report`，报告始终为 JSON；程序解析 stdout 时显式加 `--format json`。
Python SDK 仍返回原有结构化 Result。更详细的参数来源和退出码见 CMD `docs/PYTHON_SDK_AND_CLI.md`。

候选搜索使用简短关键词，在查询适用的目标/图/引脚上下文中复用返回的可读名称。切换上下文时
查询新上下文所需的候选，不把另一资产的名称视为通用创建许可。已确定且参数接受的类路径或资产引用可以直接使用，
不把工厂候选查询当作所有资产操作的前置步骤。

## 项目与安装

默认从工作目录向上定位 UE 项目并托管连接；其他目录用 `ueagentinterfacecmd --project <项目目录或.uproject> exec ...`。
独立部署才使用明确提供的 `--connection <connection.toml>`；已有本地项目使用托管入口，
不搜索其他任务的连接文件或读取凭据。CLI 是 `ueagentinterfacecmd` 可执行程序；`cli/uai/` 是 SDK 包目录。

首次安装或明确更新时，在项目根执行：

```powershell
python.exe UeAgentInterfaceCMD/tools/sdk_environment.py install
```

同一工具的 `status` 查看安装，`uninstall` 同时卸载用户 CLI 和专用 SDK 环境。正常调用不重复安装或检查环境。
Windows 原生入口位于 `%USERPROFILE%/.local/bin/ueagentinterfacecmd.exe`；宿主尚未继承 PATH 时可用完整路径。
不要换成 `.cmd` 包装器，以免改变 JSON 引号。CLI 与 SDK 共用同一公开实现，不依赖特定代理或编排工具。
