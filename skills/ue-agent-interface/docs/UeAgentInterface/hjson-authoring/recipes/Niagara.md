# Niagara HJSON Authoring Recipe

本页只描述当前统一 Niagara workspace。通用 operation、identity、structured value 和 completion 规则先读 `../00_DirectHjsonAuthoring.md` 到 `../08_NiagaraApplyDomain.md`。

## 1. 能力边界

当前 folder Export/Apply 纵切覆盖：

- Niagara System、standalone Emitter、standalone Script 的资产生命周期。
- System stage、embedded Emitter stage、standalone Emitter stage 的稳定 identity。
- Module script、module order、module add/update/remove。
- Module input 上的 Dynamic Input script 设置和清除。
- UE factory/schema/domain-native completion、原子事务、回滚和 snapshot readback。

当前 folder Export 覆盖受控 Renderer、Event Handler、System User Parameter、Module literal/linked input 和递归 Dynamic Input；Data Interface 的任意对象拓扑和任意 Script graph topology 仍不在本纵切。不要从旧多文件 Niagara 文档推断额外字段仍由 folder 命令覆盖；缺失能力应补齐统一领域语义，而不是恢复旧 reader/writer。

## 2. 发现与取证

1. 已知命令用法时直接调用。
2. 新增模块时，先用 `niagara.module.candidates` 在目标 System、usage、usage-id 和可选 emitter-handle 上下文中搜索 3-5 条候选；Dynamic Input 只使用当前 Niagara 合同明确提供的候选入口或真实 readback。
3. 选定候选后只保留 `candidate.id` 或在该上下文唯一的 `candidate.name`；usage/context 写在 stage 外层，不复制完整候选、脚本路径或 binding revision，也不要经 `query.content.search` 转换领域 identity。
4. 用对应 `niagara*_export_folder` 获取目标资产当前 `index.hjson`。
5. 需要 live Stack 细节时，再调用 `niagara_emitter_list_*` 或 `niagara_system_list_*`。
6. 编辑 HJSON、Apply、重新 Export，对比稳定 identity 与语义结果。

新模块通过当前领域候选创建；已有模块和 Dynamic Input 的路径 assertion 必须来自当前 readback。不要凭 UI 显示名、记忆或网络示例拼路径。

候选只选择“创建什么”。stage identity、module stable key/GUID、顺序、operation 和 input context 必须来自当前 workspace/readback 或用户意图，不由候选查询补全。服务端在首写前重枚举同一原生 Stack action；当前只有 `asset_module` 可创建，其他 Add Module action 会明确拒绝。Niagara input value source 和 Script graph function 没有可脱离 owner 的 standalone placement。

## 3. Workspace

默认根目录：

~~~text
Saved/UeAssetFolders/NiagaraSystem/<asset path>/index.hjson
Saved/UeAssetFolders/NiagaraEmitter/<asset path>/index.hjson
Saved/UeAssetFolders/NiagaraScript/<asset path>/index.hjson
~~~

统一 workspace 只有一个 `index.hjson`。旧 `asset.hjson`、`emitter.hjson`、`settings/`、`emitters/`、`stages/index.hjson`、`graphs/` 和 `coverage_report.hjson` 不再是 Niagara folder 输入。

## 4. Module 与 Dynamic Input

以下例子在现有 Particle Update stage 中新增一个已搜索到的原生资产 module，并为它的 `Module.Jitter Amount` 设置 Dynamic Input。stage key 和 usage ID 必须保留 Export 结果；module key 可使用 Export 返回的合法稳定 GUID，也可使用由 Apply 在资产与 stage 上下文中补全为确定性 GUID 的稳定语义键。

~~~hjson
operation: update
target: { asset_path: "/Game/VFX/NE_Example", asset_kind: emitter }
provider_extension: {
  stages: {
    "standalone|ParticleUpdateScript|<usage-guid>": {
      target: { usage: ParticleUpdateScript, usage_id: "<usage-guid>" }
      modules: {
        "native-jitter-module": {
          candidate: { id: "candidate:..." }
          module_index: 0
          dynamic_inputs: {
            "Module.Jitter Amount": {
              script_asset_path: "/Niagara/DynamicInputs/Multiply/Multiply_Float.Multiply_Float"
              input_name: "Module.Jitter Amount"
            }
          }
        }
      }
    }
  }
}
~~~

规则：

- 已有 module 优先使用导出的 module GUID key。
- 新 module 可使用调用方提供的合法 GUID 或稳定语义 key；Apply 创建后由读回确认实际 GUID。
- `module_index` 是目标顺序；不写则保持/追加。
- Dynamic Input key 与 `input_name` 应一致；Apply 会通过 Niagara schema 解析真实输入。
- 删除 module：在该 module 对象上写 `remove: true`。
- 清除 Dynamic Input：将对应 Dynamic Input 值设为 `null`，或写 `remove: true`。
- 未知脚本、冲突 alias、歧义 stage 或非法 GUID 必须在 preflight 失败，不得 warning-and-skip。

## 5. System 与 Embedded Emitter

System workspace 会把 system stages 和 embedded emitter stages 合并到 `provider_extension.stages`。Embedded emitter stage 的 `target` 带 `emitter_name`；System stage 不带。

不要删除或改写导出的 `usage`、`usage_id`、`emitter_name` 来“猜”目标。它们共同构成 stage identity。

## 6. Script 边界

`niagara_script_export_folder` 当前只导出资产 identity，因此可用于确认 target 和执行资产生命周期 roundtrip，不能用来读取或编辑 Script graph。

需要理解脚本来源时用 `reference.origin.resolve`。需要 Script graph authoring 时搜索专用 graph 命令；当前 folder contract 没有该能力时应明确报告边界。

## 7. 验证

最小充分门禁：

1. Apply 成功且 `phase=complete`。
2. 重新 Export 到新目录。
3. 比较 `target`、stage identity、module GUID、script path、module order 和 Dynamic Input。
4. 对幂等修改重复 Apply，确认重新 Export 的 HJSON golden 不变。
5. 需要保存时在 HJSON 的 `provider_extension.save` 明确请求，并在失败时检查 rollback 字段。

不要只检查 HTTP `ok=true` 或 `mutations_applied` 数字；最终结论来自 Export/readback 语义。
