# Niagara 统一 HJSON Workspace

本页是 Niagara folder 命令的正式总览。字段级规则见 `../../../hjson-authoring/08_NiagaraApplyDomain.md`，实操见 `../../../hjson-authoring/recipes/Niagara.md`。

## Commands

| 命令 | 目标 | 关键参数 |
| --- | --- | --- |
| `niagara_export_folder` | System Export | `asset_path`, `folder_path?`, `profile?` |
| `niagara_apply_folder` | System Apply | `folder_path?`, `asset_path?` |
| `niagara_emitter_export_folder` | standalone Emitter Export | `emitter_asset_path`, `folder_path?`, `profile?` |
| `niagara_emitter_apply_folder` | standalone Emitter Apply | `folder_path?`, `emitter_asset_path?` |
| `niagara_script_export_folder` | standalone Script Export | `script_asset_path`, `folder_path?`, `profile?` |
| `niagara_script_apply_folder` | standalone Script Apply | `folder_path?`, `script_asset_path?` |

Emitter/Script 命令也接受 `asset_path` 作为定位别名。Apply 同时提供外部路径和 HJSON target 时，两者必须一致。

## Format

每个 workspace 只有一个 `index.hjson`：

~~~hjson
operation: update
target: { asset_path: "/Game/VFX/NE_Example", asset_kind: emitter }
provider_extension: {
  stages: {
    "<stable-stage-key>": {
      target: { usage: ParticleUpdateScript, usage_id: "<usage-guid>" }
      modules: {
        "<module-guid>": {
          script_asset_path: "/Niagara/Modules/Update/Position/JitterPosition.JitterPosition"
          module_index: 0
          dynamic_inputs: {}
        }
      }
    }
  }
}
~~~

旧多文件 Niagara folder 已删除，不再读取 `asset.hjson`、`settings/`、`emitters/`、`graphs/`、`validation/` 或 JSON 兼容文件。未知文件由 workspace contract 拒绝。

## Export

Export 从 `niagara.state` snapshot 投影，不直接遍历 UObject 写文件。所有 profile 使用同一 Export Contract 和 writer policy：

- `llm_authoring`：编辑所需身份和内容。
- `readback`：允许读回附加信息。
- `debug`：允许诊断信息。
- `validation`：只保留验证所需身份。

Export 重置自己拥有的输出目录，但不得修改资产、Package dirty 状态或 Apply contract。

## Apply

Directory、single-file 和 inline 输入共用一个 Apply contract。整个 workspace 在任何 mutation 前完成：

1. HJSON parse 与 unknown-field 检查。
2. unit route 与 dependency graph。
3. operation/target/stage/module/dynamic-input preflight。
4. UE native completion。
5. rollback capture。
6. atomic mutation、可选 compile/save。
7. shared snapshot verification。

`operation` 支持 `create`、`update`、`upsert`、`remove`、`clone`。Export 默认生成 `update`。Apply 可以接受 Export 未展示的契约字段；Apply 输入不会改变 Export 输出。

## Current Scope

统一可编辑投影覆盖 stage、module 和 Dynamic Input script。Renderer、Event Handler、User Parameter、Data Interface 详细属性、普通 literal input 和 Script graph topology 尚未进入本纵切。必须通过对应专用命令或后续统一领域扩展处理，不得恢复旧 folder reader/writer。

## Verification

- `UeAgentInterface.Authoring.Niagara`：注册、资产生命周期、module/dynamic input、Export 只读、token budget、roundtrip。
- `GptProjectTest.UeAgentInterface.Smoke.NiagaraStageModulePatch`：真实命令编辑、幂等重放、删除读回。
- `GptProjectTest.UeAgentInterface.Smoke.NiagaraFolderWorkflow`：System/Emitter/Script 六命令 golden。
