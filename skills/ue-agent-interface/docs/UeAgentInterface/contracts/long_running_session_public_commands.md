# Long-running / Session Public Commands

本文是 `job.compile_build`、`editor.session`、Capture 与 operation lifecycle 的正式
服务端行为说明。Python SDK 和 CLI 只转发这里列出的真实 command；它们不维护第二套
任务状态、不解释 UE 业务结果，也不自动重试写操作。

## 统一生命周期

六条 start command 是：

| command | Python 方法 | 必填参数 |
|---|---|---|
| `job.compile_build` | `client.job.compile_build(...)` | `family_id`、`subject_ref`、`policy_id`、`parameters` |
| `editor.session` | `client.editor.session(...)` | `family_id`、`subject_ref`、`policy_id`、`parameters` |
| `capture.image.execute` | `client.capture.image_execute(...)` | `subject_ref`、`policy_id`、`parameters` |
| `capture.media.execute` | `client.capture.media_execute(...)` | `subject_ref`、`policy_id`、`parameters` |
| `capture.render.execute` | `client.capture.render_execute(...)` | `subject_ref`、`policy_id`、`parameters` |
| `editor.safe_exit` | `client.editor.safe_exit(...)` | `dirty_resolution` |

start 成功只表示 operation 已被接受，不表示 native work 已完成。返回值是
`uai.long_running.snapshot.v1`，其中 `operation_ref` 必须原样保存：

```json
{
  "operation_id": "operation:...",
  "owner_lease_id": "lease:...",
  "server_session_id": "..."
}
```

调用方用同一 `operation_ref` 执行以下六条 lifecycle command：

| command | 用途 |
|---|---|
| `operation.status` | 只读取当前 snapshot，不启动或推进 native work |
| `operation.resume` | 以 `expected_generation` 显式推进一次 |
| `operation.cancel` | 请求 exact-owned native resource 在安全边界停止 |
| `operation.receipt` | 读取已形成的终态 receipt |
| `operation.reconcile` | 只对账；不得启动、推进或重放 native work |
| `operation.release` | 释放当前 operation 的 C11 owner 与临时 native resource |

错误的 session、lease 或 generation 必须 fail closed。release 后 reconcile 返回
`state_unknown` 时，`retry_safe=false`；调用方不能把它解释为可以重放。snapshot 的
`latest_signal` 是当前 generation 的最新 typed signal，整数 lexeme 不经过 IEEE-754
浮点转换。canonical value 的数组和对象转换使用迭代遍历，没有嵌套深度上限。

## 正式 policy

policy 只按 exact `(family_id, policy_id)` 注册，不接受后缀匹配或前缀猜测。

### Compile / Build

- `asset_compile` + `policy:asset-compile:standard/v1`
- `world_build` + `policy:world-build:standard/v1`
- `external_process` + `policy:owned-tool:standard/v1`
- `world_partition_resave` + `policy:world-partition-resave:actors/v1`
- `localization_owned_tool` + `policy:owned-tool:localization-gather-text/v1`
- `localization_owned_tool` + `policy:owned-tool:localization-compile-text/v1`
- `localization_owned_tool` + `policy:owned-tool:localization-export-po/v1`

GameThread stage 和 owned process 都由 operation-scoped port 持有。`external_process`
只接受 subject `project:owned-tool-probe` 与空 `parameters`；executable 和 arguments
由服务端固定，客户端不能注入任意命令行。任务完成后，terminal typed signal 的
`report_ref` 指向真实进程输出，内容必须包含 `UAI_OWNED_TOOL_PROBE_OK`。其他 subject、
参数或 policy 组合均 fail closed。

三个 Localization policy 只接受 subject `localization:<Target>`。参数可包含
`execute`、`cultures[]` 和 `timeout_seconds`（大于 0 且不超过 300）；
gather/compile 在真实执行时还要求 `allow_commandlet=true`，PO export 要求
`output_dir`。客户端不能注入 executable 或 arguments。`execute=false` 仍经过
operation lifecycle 形成计划报告；真实执行由 operation-owned commandlet 完成。
terminal report 使用 `uai.localization.owned_tool_report.v1`：compile 提供
`locres_files[]/compiled_count`，export 提供 `po_files[]/entry_count`，gather
提供 commandlet plan、log 和 report 路径。release 与异常析构都必须清理临时配置和
进程资源。

### Editor Session

- `asset_editor` + `policy:asset-editor:open/v1`
- `runtime_preview` + `policy:runtime-session:pie/v1`
- `runtime_preview` + `policy:runtime-session:culture-preview/v1`
- `world_context` + `policy:world-context:set-current/v1`
- `world_context` + `policy:world-context:create-blank/v1`
- `world_context` + `policy:world-context:partition-region-loader/v1`
- `world_context` + `policy:world-context:partition-actor-loader/v1`
- `modeling_tool` + `policy:modeling-tool:invoke-action/v1`
- `voxel_grid` + `policy:voxel-session:apply/v1`
- `host_lifecycle` + `policy:host-lifecycle:prepare-safe-exit/v1`

World-context policies use subject `world:/Game/...` and never infer a map from
the current selection. `set-current/v1` opens one existing map and accepts only
optional `save_existing_map` (default `true`). `create-blank/v1` creates and
persists one map; `overwrite_policy` is `fail`, `reuse`, or `replace` (default
`fail`), `save_existing_map` defaults to `true`, and
`create_world_partition=true` enables External Actors and initializes World
Partition before the map is saved.

Both partition loader policies require that the subject is the exact current
World Partition map. The region loader takes `bounds.center[3]`,
`bounds.extent[3]`, an optional non-empty `label`, and optional `dry_run`; the
actor loader takes at least one `actor_guids[]` or currently resolvable
`actor_ids[]`, plus optional `dry_run`. A non-dry loader remains owned by its
operation after publishing a `world-partition-loader:*` session ref. The caller
must use `operation.cancel`, advance to the cancelled terminal state, and then
`operation.release`; switching maps or dropping the Python object is not a
cleanup contract.

`modeling_tool` 只接受 subject `modeling-session:operation-local`、参数 `action_id`
取值 `spawn_transient_box`，以及可选的正数 `size_x/size_y/size_z`；缺省尺寸为 100，单轴上限
为 100000。`voxel_grid` 只接受 subject `voxel-session:operation-local`，以及正数
`cell_size` 和整数 `cells_x/cells_y/cells_z`；各轴 cell 数不得超过 1024，最终尺寸同样
不得超过 100000。两者都创建 operation-owned transient `ADynamicMeshActor`，不写入旧
static session registry；cancel/release 只销毁该 operation 的 actor。

调用方通过 typed signal 的 `session_ref` 取得 actor path，再用 `world.actor_components`
确认唯一 `DynamicMeshComponent`，并用 `world.property(..., property_path="Bounds")` 独立
读回非零几何边界。对 `UPrimitiveComponent`，`Bounds` 是 WorldRead 提供的通用计算属性，
返回 origin、extent 与 sphere radius；它不依赖 session 自报成功。

`editor.safe_exit` 先按 `dirty_resolution` 处理 dirty resource，再由 operation-owned ticker
请求退出；`RequestExit` 返回仍是非终态，真正关闭必须由进程外 witness 验证。

`culture-preview/v1` 的 subject 是 `culture:<Culture>`，参数精确为
`culture`、`restore_after` 与 `scope="session"`。该 policy 使用 Editor world
context，不要求 `runtime-subject:pie:<instance>`。当 `restore_after=true` 时，owned
action 设置请求 culture 后立即恢复先前 culture；terminal signal 的 `session_ref`
记录 previous/requested/restored，调用方还必须用
`content_graph.compound` 的 `localization.culture.read` 独立确认恢复结果。
未知 culture、subject/policy 不一致或恢复失败均为 typed terminal failure。

### Capture

- image：`capture.image.execute` 只接受以下 15 个 exact policy；每个 policy 的 subject 与
  参数合同由 active T44 catalog 和 `query.command.detail` 共同公开，客户端不得从旧 command
  identity 或 Editor 状态推断 policy：

  - `policy:image-capture:anim-blueprint/v1`
  - `policy:image-capture:anim-sequence/v1`
  - `policy:image-capture:behavior-tree/v1`
  - `policy:image-capture:blueprint/v1`
  - `policy:image-capture:control-rig/v1`
  - `policy:image-capture:metasound/v1`
  - `policy:image-capture:niagara/v1`
  - `policy:image-capture:pcg-viewport/v1`
  - `policy:image-capture:viewport/v1`
  - `policy:image-capture:viewport-buffer/v1`
  - `policy:image-capture:level-sequence/v1`
  - `policy:image-capture:sound-cue/v1`
  - `policy:image-capture:state-tree/v1`
  - `policy:image-capture:texture/v1`
  - `policy:image-capture:umg/v1`

  两条 active viewport policy 的 subject 均为 `capture-subject:viewport:active`；资产与
  Actor policy 使用 `capture-subject:asset:<object-path>` 或
  `capture-subject:actor:<actor-name-or-label>`；每个 policy 的精确字段继续以正式
  manifest 与 `query.command.detail` 为准。
- submix media：`policy:media-recording:submix-wav/v1`，subject
  `media-source:audio-submix:master` 或显式 `USoundSubmix` object path
- sound preview：`policy:media-recording:sound-preview-wav/v1`，subject
  `media-source:sound:<USoundWave object path>`
- render：`policy:render-operation:clear/v1`；`render-resource:operation-local` 通过
  `parameters.width`、`height` 和 clear color 建立 operation-owned transient target

image、media 与 render 共用 C8F file artifact 发布。artifact 位于 terminal snapshot 的
`latest_signal.payload.artifact_ref`；调用方必须独立读取 `locator`，校验 `byte_count`、
`content_hash` 和格式内容。RenderTarget 还必须用独立像素 readback 验证，不能把 native
session 自报的 success 当作 C9。

`sound-preview-wav` 从指定 `USoundWave` 的真实导入 PCM 确定性生成 WAV，因此不依赖窗口
焦点或音频硬件；`submix-wav` 则要求实际 mixer frame。viewport capture 要求存在尺寸有效、
已经渲染的 level viewport；最小化导致 viewport 为零尺寸时会明确返回
`capture_image_viewport_unavailable`，不会生成替代图片冒充 viewport readback。

全部 image policy 都要求 Editor 进程具备渲染能力。`FApp::CanEverRender()` 为 false
（包括 `-NullRHI`）时，operation 在参数投影、截图 mechanics 或打开资产编辑器之前以
`capture_image_rhi_unavailable:<policy_id>` 失败关闭，不生成 artifact，也不提供无渲染
fallback。图片产品验证使用具备 RHI 的 owned worker；NullRHI 只验证这一失败合同和不依赖
渲染的 capture mechanics。

## 旧入口终态

旧 `/api/exec` 的 editor close、submix record、packaging task、localization external task、
world-partition resave、viewport screenshot 与 voxel-grid session command 均不在当前
immutable registry/manifest 中。旧 compiled registry、prefix/exact dispatch 与
`FUeAgentHttpServer` handler 已从编译树物理删除，不再存在一套可执行 tombstone registry；
未知旧 identity 只会在当前 exact ingress 以未注册 identity 失败关闭。

仍被 EditorProject、ModelingGeometry 与 CaptureMedia 当前领域 owner 复用的 UE mechanics
位于私有 `LegacyMechanics` 边界。该边界不拥有 listener、route、authentication、command
registry 或 dispatch，模块启动也不能实例化它；每个当前 consumer 只能显式调用其所需
mechanics。旧 generated spec/doc、hidden resave consumer、active legacy smoke/coverage，
以及 EditorViewport adapter 内第二套 screenshot 方法、辅助函数和 capability 广告均已从
活动入口删除。不得恢复
`GRecordSessions`、`FShotJob`、`GExternalTasks`、`GVoxelGridSessions`、ownerless task map、
delayed-exit wrapper、第二 screenshot 流程或 Python business owner。
