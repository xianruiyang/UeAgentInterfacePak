# HJSON workspace

## 导出

查询候选、类型或资产信息使用 [CLI](cli.md)；公共 workspace 的导出、打开和导入使用 [SDK](sdk-and-runners.md)。
HJSON 内容直接用文件工具编辑。已有 SDK 会话可复用其中的查询，不必来回切换入口。

普通资产导出包含适用的预览配置；资产曾从外部文件导入，不会把本次导出变为重导入任务。
准备外部来源导入时才显式提供对应 `source` 文档。

`target` 使用目标的完整 UObject 路径，例如资产 `/Game/Example/BP_Item.BP_Item`、
关卡 `/Game/Example/L_Main.L_Main`。优先沿用公开查询或创建结果返回的对象路径；
PIE/session 的 `world:/...` 引用不是 Level workspace 的目标格式。
部分资产入口接受包路径简写，不据此推断其他领域也接受。

项目设置也使用同一 workspace 流程：先以
`project.settings(input={"editor_project_capability":"project_settings.index"})`
取得真实 `section_id` 和 `settings_object_path`；`parameters.container` 可按目标限定为 `Editor` 或 `Project`。
需要字段发现时用同命令的 `project_settings.page` capability，`parameters` 携带该 `section_id`；
其 `observation.properties` 给出 `property_path`、`kind`、authoring `value` 和 `availability`，两种查询均不写文件。
只读已知字段时用 `input={"section_id":...,"field_ids":[...]}`；
省略 `field_ids` 只返回数量。编辑用 index 的 `settings_object_path` 作为 target，修改导出的
`properties.hjson`，不把属性名猜写成 ini 键名。详细合同见 Plugin `docs/active/t06_non_hjson_query_migration.md`。
导入保存实际变化并调用原生修改通知。结果 `settings_effects` 区分实时 CVar 值、原生通知和需重启项；
`saved_live_value_differs` 表示配置已保存但当前值不同，不能据此声称已生效，也不要为此自动重启 Editor。

```python
workspace = client.content_graph.export_workspace(
    target,
    name="current",
    profile_id="llm_authoring",
)
if not workspace.result.ok:
    raise RuntimeError(workspace.result.error)
```

Level 的摆放、挂接、基础可见性、网格/材质槽及原生 Engine 灯光强度/局部光衰减半径、
PostProcessVolume `Settings` 可显式选 `profile_id="scene_editing"`，减少属性捕获与输出。
默认 `llm_authoring` 仍为完整范围。精简工作区仍用同一 `import_changes()`，刷新保持原 profile，
未导出属性不作删除或重置；修改曝光时保留 Settings 的其他成员及覆盖标志。
其他灯光字段、碰撞/模拟、自定义玩法属性或 PCG 使用另一个名称的完整工作区；
准确原生类/字段范围见 Plugin `docs/active/t26_level_world_domain.md`。
完整状态恢复与持久化读回仍可能运行，不把导出提速外推为全部导入阶段同幅提速。

需要在应用前了解 Level 编辑影响或几何交叠时，使用同一工作区的只读分析：

```python
context = workspace.scene_context(limit=40)
overlap = context.geometry_overlap(limit=40)
# 按结果判断用途，必要时继续修改 HJSON 并从 workspace 重新分析。
import_result = workspace.import_changes(analysis=overlap)
```

`workspace.geometry_overlap()` 也可直接调用，不要求先取上下文。两个能力共用正式导入准备，
分析的是增改删后的拟状态；不会应用内容、执行任意蓝图构造或把暂存字段当成真实读回。
同一分析句柄可用 `offset`、`limit`、`object_ref` 展开上下文或几何事实；读取总数、分页和覆盖状态，
不要将首屏或 unsupported 当作全部无问题。当前场景的精确对象或区域查询及字段沿 CMD T26 文档。
工具提供共面、接触、穿交、包含等事实；允许嵌合与错误穿插按[完成面与连接](../../ue-essential-knowledge/references/07-world-level-rendering/blockout-and-traversal.md#完成面与连接)判断。
`analysis=` 只应用与该报告绑定的编辑版本；文件、相关对象、网格或邻域成员变动后重新分析。
普通 `import_changes()` 保持原行为，不以分析作为所有导入的前置门禁。
带分析的成功导入还返回 `scene_analysis`：应用/保存成功与预测吻合分别表达；
若需 `geometry_recheck_required`，沿该分析句柄分页取得具体对象，对实际结果补查，不能重放导入。

`name` 是短名称，不是目录路径：以小写字母或数字开头，其余可用小写字母、数字、下划线和连字符。
SDK 将 workspace 放在项目的 `tmp/uai-workspaces/<name>`；自写脚本和报告的输出目录与此独立。
通过返回的 `workspace.path` 定位普通 HJSON，用文件补丁直接增删改；无需用 Python 解析再序列化整份文件。
绝对路径由 SDK 托管；隐藏实现目录由服务端持有，不枚举、不编辑，也不把
其中机器状态复制进模型上下文。

先通过文件名或目标名称定位所需普通文件，再读取相关范围。`content_ref` 是 workspace 根目录相对路径，
指向同一语义对象的内容分片；分片中 `value` 才是该部分的编辑位置。曲线保留完整关键帧和切线，骨骼采样
保留整条轨道，MovieScene 动画/绑定/轨道沿同一公共组织规则分开。沿引用读到目标即可，不默认串读所有
分片；新增集合成员按导出的集合值与既有类型合同表达，不手工创建机器映射。

先按所属对象定位，再按内容定位：Sequence 是绑定/轨道，UMG 是动画/绑定/轨道，Niagara 是 emitter/stack/module。
集合目录的 `index.hjson` 保存成员入口；轨道中的 section/channel/key 保持在轨道文件内。不要将不同 owner 的同类
内容假定为全局平铺集合，也不要根据旧导出的编号目录猜新路径；以本次 `content_ref` 为准。

空数组/集合不知道如何新增时，先查本次 workspace 的 `examples/index.hjson`，按业务文件定位
`examples/files/<业务文件路径>`；其中 `at` 指向要编辑的位置，类型示例可继续引用 `examples/types/`。
只读当前需要的条目。示例由现行类型与创建合同生成，空集合也有说明，不必找旧资产或猜字段。
这些文件只作说明，不导入，也不用作 `content_ref`；将需要的 `example` 合入业务 HJSON，保留原有成员。
`<...>` 必须换为当前查询/定义给出的值；示例不是业务默认值，也不保证上下文中的所有引用已可用。
节点、组件、Notify 等按示例的创建层次和所属查询填写；类型说明不能替代候选选择与关系语义。

## 最小编辑

- 只修改目标变化需要的字段；新增字段依据当前类型的创建合同，不凭记忆补齐。
  workspace 中局部修改普通反射结构时，未改成员保留 UE 原生更新后的值；不必重写整份结构。
  创建合同未要求填写的默认字段交由 UE 补齐。导入刷新值包含原生数值/时间精度、布局和顺序归一化；继续编辑使用刷新后的 workspace。
- 保留导出给出的文件分工、对象边界和相邻结构。
- 编辑分片的业务值；`content_ref` 仅负责定位，不需要改引用、hash 或隐藏 manifest 来提交普通值变化。
  不把已拆出的值再复制进主文件形成两个编辑位置。
- UObject 属性在同一对象文件的 `categories` 下按实际类别组织。只改 `value`，保留导出的值类型 `type` 和可选只读 `definition`，不自行添加类型编号或构造定义引用。
  `definition` 对应所属 `definitions.hjson` 的 `definitions` key，枚举候选在同文件的 `enums[definition]`；嵌套短引用匹配条目的 `ref`。类型写法与递归模板见 Plugin `docs/hjson-authoring/02_CommonInputValue.md`，不从基础类型名猜完整定义。
  原生启用开关与受控值是独立字段，按意图分别设置；只改受控值不会自动启用开关。
  `EditCondition` 描述 Details UI 状态，不禁止持久 authoring 写入；其他只读或领域限制仍按真实写资格判断。控制字段合同见 Plugin `docs/UObjectPropertyValueV2.md` 的 Apply 语义。
- 同名的不同条目由公共规则分配 `X`、`X#2`、`X#3`，同一身份重复引用不再编号。`type` 不随属性约束或引用次数编号，`definition` 才可能区分不同合同。使用导出的完整别名，并保留含 `#` 的名称、引用和路径的双引号；不剥除名称本来带有的数字。
- 单位先读当前 definition 的 `type.value_semantics` 和原生 `constraints.units/force_units`；不要凭 float/vector 或字段名推断角度单位。
  Niagara 可定向查询所选模块的 `input_schema`，其输入 `contract` 与 workspace definition 的 `value_definition` 共用来源；
  `description` 保留原生说明，`display_unit` 只是显示提示，不自动换算。单位缺失仍是未知；依赖模式/枚举或脚本版本时，改变后读取刷新定义。
  数值保存成功只能证明写入，不能证明解释的单位正确。这些说明不复制进业务 `inputs`，具体表示见公共类型与对应领域文档。
- 创建结构项使用候选的可读 `name`，层级按该类型创建合同：Blueprint/SCS组件行用顶层 `name`，图节点按其 `candidate` 合同。普通Level Actor及实例组件集合按[场景公开入口](scene-creation.md#使用公开入口搭建)；Level组件可消费候选 `describe` 的首批属性，归属和attachment仍使用Level合同，不照搬Blueprint层级。
  `choose.name` 替换该位置的名称并去掉旧 `select`；其他 `choose` 只在对应选择器位置补最短 `select`。
- 节点接口、可变 pin、动态列表以当前查询或导出的 companion 为准。查询接口用
  `client.content_graph.items(target=target, input={"items": [node_alias], "fields": ["pin_interface"]})` 选定当前节点；
  字段属于所选条目，不对混合类型集合套用节点字段。字段错误先看诊断中的条目定位与 `choose`，按实际建议细化 `items`/`containers`；不把局部字段不兼容判为领域能力缺失。
  `pin_interface.pins[].alias` 直接用于连接端点，不从原生名或数字后缀推算。
  `default_editable=false` 表示当前不能填写 Pin 默认值，不等于该输入不可用或插件缺失能力；已连接 Pin、引用参数等可能要求连线提供值。
  按当前接口的类型和连接限制判断可用输入，连接改变类型后重读接口，不强写默认值或据单个标志判为产品故障。
- 候选选择只负责类型或能力；实例名、parent、graph、stage、layout、属性值和连接留在目标
  authoring 位置。
- 关系、顺序和依赖只引用导出的短可读 ref，例如 `surface:component_tree`、
  `structure:eventgraph`、`item:doorleft`。十六进制 semantic unit id 只存在于隐藏 manifest；
  普通 HJSON 若要求模型处理这些内部身份，保留公开错误并交所属 owner，不手工搬运身份绕过。
- 删除或改型后，未修改的关联内容交由 UE 原生编辑机制处理，再读刷新结果；不先手工清空所有引用。
  同批显式编辑应保留或得到明确诊断。原生处理不等于自动把旧引用转向替代对象；需要承接的关系按实际owner显式处理，Level替换见[场景引用承接](scene-creation.md#资产替换与引用承接)。原生保留的失效引用显示为可读的 `Unresolved reference` 名称，不是新建候选。

## 新增内容

Blueprint 子图按图头只读 `display_name`/`parent_graph` 定位：普通过渡图显示实际起止状态，共享规则显示原生共享名称；不按编号后缀猜归属。查询该图节点时优先用返回的 `query_name`，未返回时用 `name`；导入身份由服务端保留。

新建缺失的资产目标，先读 `Plugins/UeAgentInterface/docs/active/` 中对应 domain 的创建入口。
若该类型提供 HJSON 初始化合同，用 `content_graph.import_inline(target, document)` 提交完整 schema、root 层次及创建设置；target 是独立参数，`document` 是 HJSON/JSON 文本字符串，不能直接传 Python dict。
通用资产按 T37 的 `asset.object.create` factory 合同创建，再导出 workspace；已登记为可读根不等于支持 HJSON 新建。
Settings 编辑已有设置对象，ExternalInput 编辑其来源载体，均不套用缺失资产初始化文档。
动画家族的共享文档与类型表见 `t23_animation_curve_domain.md` 的 Missing-root animation documents 节。
AI 行为资产见 `t20_ai_behavior_domain.md` 的 Root lifecycle、BehaviorTree 和 EQS 章节。
资产初始化的 `root.create` 与图中的固有根节点属于不同层次；创建空资产不等于已建立执行图。根节点、候选节点及连接分别按该图的领域合同填写，不把固有节点一律当作普通候选。
`asset.factory.candidates` 只覆盖指定 create command 的候选，不覆盖所有 HJSON 领域；无命中不代表该类型不能创建。
AnimBlueprint 的骨架绑定在创建合同的 `class_settings`，不能从 AnimInstance CDO 属性推断；
角色使用具名骨架资产，无骨架 `template` 是另一种原生用途。现有类设置按本次导出的设置文件编辑。

Control Rig 与 Sequencer 互相烘焙时，用 `rig.control.bake.context` 按已导出的 binding 名和 Rig 生成类查询，
再通过公开 `result.rig_bake_context.bake_controls()` / `.bake_animation()` 调用既有原生烘焙；后者需查询时指定已存在的动画目标。
SDK handle 保管绑定与修订，payload 只是摘要；编辑目标或重启 Editor 后重新查询。完整输入与 Operation 用法见 CMD `docs/active/t58_rig_spatial_command_migration.md`。

在现有集合中新增成员，按该集合当前生成的示例及创建合同填写值。两种写法使用同一导入链：

行内对象/数组中的字符串加双引号；裸字符串独占一行，避免逗号或结束符被当作字符串内容。

缺少首批属性形状时，支持的候选查询可按需传 `describe: {name, fields}`；普通搜索返回名称及查询作用域，不附加整份属性。
Material、Niagara、PCG、UMG、Control Rig、AI行为和动画状态机的详情用 `description.creation.supported/reason` 区分当前能否创建；原生菜单有名称不等于能写入，陌生动作可按需描述，unsupported 也可只读描述。
可用范围和默认值来源见 `UeAgentInterfaceCMD/docs/active/candidate_properties.md`，动态接口仍读真实实例。
`description.properties` 是创建入口可直接使用的 descriptor 数组，按需复制并改 `value`；
不要把整个导出文件的 `categories` 当成内联创建属性。

Niagara 的 Assignment 按生成的 `assignment` 示例直接填 `module_kind` 和 `assignment_targets`，无需候选名；脚本模块才使用模块候选。已知原生属性可用 `null` 推断类型，自定义变量显式填类型。

- 内联：把新记录直接放在集合值中。图节点在 `nodes` 中用可读别名和候选创建，可同次携带内联
  `properties`；属性形状仍从该领域当前合同/查询取得，不猜测其他资产的字段。
- 分片：把该值写到 workspace 内的新普通文件中，文件内容为 `{value: ...}`，原位置改成
  `{content_ref: "new-content/example.hjson"}`。路径相对 workspace 根；不用改隐藏 manifest 或登记哈希。

依赖目标上下文的候选查询返回一次 `scope`（目标及该领域的图、stage、surface 等）。名称在相同
上下文内可批量复用；切换资产、图或引脚/阶段后，查询新上下文所需的名称。成员或组件变更后只刷新
受影响候选。`scope` 是查询说明，不写进 HJSON，也不把别的资产的候选当作当前图可用的依据。

Blueprint、UMG、AnimBP普通图的候选若按现有引脚查询，把返回的 `candidate_context` 原样放到
新节点中，与 `candidate` 同级；查询已将名称及 occurrence 转成当前工作区别名，不自行转换。
名称不携带前次查询的上下文，导入会重新枚举该原生菜单；背景菜单查询可省略此字段。

区分创建载体和导出投影：新增节点的属性形状以当前领域创建合同为准，不能直接照搬整个导出文件。
Blueprint 已导出节点的引脚默认值在其 `properties.hjson` 的 `categories.General` 中编辑，
保留导出的可读 Pin 名、类型和值结构。连接与引脚输入的完整合同见
`Plugins/UeAgentInterface/docs/hjson-authoring/00_DirectHjsonAuthoring.md` 的“图接口、默认值与连接”节；
不从其他图领域推断相同字段或填写内部 Pin 身份。

两种方式都只保留一个输入值，不要同时留下内联值和引用。`properties_ref` 是已导出节点属性的定位，
不能用尚不存在的 `properties_ref` 代替新节点的 `properties` 创建输入。
成功刷新后，插件按该内容类型的正式导出规则重排文件：新节点的属性回到正常属性文件，临时内联表达和
已消费的自定义分片退出。继续编辑时重新定位，不假定自选的临时文件名会保留。未引用的用户文件会保留，
不会仅因扩展名是 `.hjson` 被当作资产内容。

## 导入

直接编辑完成后，可在新的 SDK 会话中打开已有目录并导入。需要追溯输入差异的实践或故障调查，
在导入前保留本次改动的普通业务文件或补丁，并与返回收据对应，避免覆盖唯一证据；成功刷新会替换原输入。
这不要求备份整个工作区，也不读取隐藏目录。普通内容任务仅按实际留证需要处理。

```python
workspace = client.content_graph.open_workspace(target, name="current")
import_result = workspace.import_changes()
if not import_result.ok:
    raise RuntimeError(import_result.error)
print(import_result.payload.get("warnings"), import_result.payload.get("workspace_refresh"))
```

`open_workspace` 只取得已有目录的句柄，不导出、不写文件、不读取隐藏清单，`result` 为 None；
导入结果由 `import_changes()` 返回。复用导出时的 target 和短 name，服务端仍处理目标、基线及变更。
失败时按 `result.error["diagnostic"]` 的文件/行列和 `diagnostics` 集中修正已报告错误；`unchecked` 是尚未
检查的范围，不是额外错误，不能据当前错误列表声称已找齐全部问题。若标为
`provider_field_location_not_reported`，来源仅指编辑单元上下文，不是已确认的出错字段。
不要把绝对 `workspace_path` 送入 named call 或 HJSON，也不要在 Python 中自行合并、解释或执行 HJSON 业务。

检查 `import_result.payload` 中的 `workspace_refresh.status`：

- `refreshed`：原目录已按真实资产重新生成，含最新基线。可以继续使用同一 `workspace`，只重新读取目标文件。
- `workspace_refresh.warnings`：已刷新后的清理警告，不表示资产或目录应用失败，不应据此重复 import。
- 未返回该字段：旧版本或非目录输入没有自动刷新承诺，继续修改前取得新的 export。

若 `Result.ok=false` 且错误为 `content_graph_import_applied_workspace_refresh_failed`，资产已经应用，
目录刷新却未完成。错误会明确 `asset_applied=true; retry_import=false`；不要重复 import，处理该错误后
重新 export 到新的短名称再继续，不能把原输入目录当作新基线。

同一资产/图上下文内，集中查询已知所需候选并复用返回的可读名称；仅补查尚缺或上下文变化后失效的候选。
可同时表达的变化合为一次 `import_changes()`；不需要模型追加清理、手动创建属性分片或同步机器字段。
依赖生成结果时保留必要的多次导入，例如连线确定通配 pin 类型后再写默认值。
跨资产编辑优先完成上游，再导出下游，避免摆放后又补改上游的固定几何或接口。
公共导入会保留当前资产中的无关变化，并核对本次编辑及其显式类型/绑定依赖；不必因打开预览、未编辑子项重建或任意上游修改就重导出。
本 workspace 的 `refreshed` 不保证其他目录也刷新。若返回 `hjson_import_stale_base_revision` 或
`hjson_import_stale_state_revision`，按诊断中的变化/冲突位置保留编辑，另名导出当前基线后重施需要的变化；
类型、身份、连接或集合顺序变化不能靠修改机器基线、手工舍入或原样重试解决。
资产移动或改名后，按新路径另名导出再继续；旧 workspace 不自动跟随目标身份变化，也不应手改绑定。
读取刷新后的主图名称、接口和分片引用，再直接编辑目标文件并用 `open_workspace` 导入；不重复 export，
也不沿用刷新前的 alias。节点 alias 优先来自业务名称；数字后缀只区分重名，不表示创建顺序。
主图仍无法区分节点时，按 `properties_ref` 定向或合批读取相关属性，不根据编号猜测语义。
一般 SDK 连续操作见 [SDK 与 runner](sdk-and-runners.md)。

## 导入后的完成判断

普通 Blueprint 根资产成功导入已覆盖编译、保存、重载和持久读回；不再追加独立编译任务来证明同一结果。
其他领域按各自入口合同判断，不从 Blueprint 推断。继续编辑使用上面的刷新基线；只补目标尚缺的
证据，选择方法见 [验证与知识](verification-and-knowledge.md)。Authoring 输入不能充当自己的验证结果。

返回的 `warnings` 是观察诊断，不等于导入失败。输入与原生结果的一致性差异不会阻止成功、回滚或强制写回旧值；
保留 UE 的实际结果，按警告定位检查是否影响目标，不为消除警告原样重试或修改正确输入。
`hjson_import_intent_*` 等意图差异警告不因刷新成功就成为允许的归一化；结合具体原因、期望/实际值和输入位置判断。
目标所需字段未保留或仍无法判定时，不能宣称目标完成，按当前任务的继续/停止边界处理。
语法、类型、引用错误及实际执行、编译、保存、重载失败仍按错误处理；成功不承诺原生结果与输入逐项相等。

## 仅保存既有资源

后续 Editor 操作使资源变为 dirty、而 HJSON 没有内容变化时，使用 `editor.save_resources`，
`resource_refs` 可直接使用任意持久资产的 package/object 路径，也可取 `editor.dirty_resources` 的原始引用；
插件内容根和未加载资产同样适用，不按资产类型选择保存指令；地图保存包括所属 build data 和外部对象包。
检查逐项 `status`、失败项 `reason` 与 `remaining_dirty_resources`；部分失败时独立成功项已保存，失败项的
未保存状态保留。按失败原因修正后保存仍需处理的资源。Editor 保持打开。无变化的 import 不代替保存，
不制造额外内容变化来触发保存。需要关闭 Editor 才使用生命周期 runner。
