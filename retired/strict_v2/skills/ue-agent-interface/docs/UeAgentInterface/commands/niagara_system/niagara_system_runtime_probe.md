---
command: niagara_system_runtime_probe
category: niagara_system
title: `niagara_system_runtime_probe`
summary: 读取 System 预览组件运行统计
aliases: []
tags: [niagara_system]
status: active
---

# `niagara_system_runtime_probe`

## LLM Compact

- status: active.
- purpose: 读取 System 预览组件运行统计
- key_inputs: `asset_path`, `advance_mode`, `open_editor_if_needed`, `tick_count`, `use_transient_component`, `particle_attributes`, `max_particle_samples`, `measure_performance`, `performance_warmup_ticks`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- note: 读取结果时不要只看最终快照。对 Collision Event、Death Event、短 lifetime 水花/火花这类瞬时粒子，最终帧可能已经归零，应优先看 `summary.emitter_peaks[]`。
- note: 推荐新流程是 `niagara_preview_advance` 推进一次并暂停，然后用 `sample_mode=current_preview` 只读；不要让 screenshot 和 probe 分别重复推进同一帧。
- note: Ray Trace Collision / Event Handler 场景依赖预览世界和碰撞上下文。若重置后的 probe 与界面观察不一致，先对比 `component_source`、`component_world`、`reset_preview`、`advance_mode`，再判断资产是否有问题。
- note: `open_editor_if_needed` 默认 false；可用 `use_transient_component=true` 在不打开编辑器的情况下执行 transient runtime probe。
- note: 已存在于当前关卡的组件使用 `sample_mode=current_level_component`，并同时提供 `actor_id` 与 `component`；该分支只读真实组件状态，不 reset、activate、tick 或修改组件。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- 读取结果时不要只看最终快照。对 Collision Event、Death Event、短 lifetime 水花/火花这类瞬时粒子，最终帧可能已经归零，应优先看 `summary.emitter_peaks[]`。
- 推荐新流程是 `niagara_preview_advance` 推进一次并暂停，然后用 `sample_mode=current_preview` 只读；不要让 screenshot 和 probe 分别重复推进同一帧。
- Ray Trace Collision / Event Handler 场景依赖预览世界和碰撞上下文。若重置后的 probe 与界面观察不一致，先对比 `component_source`、`component_world`、`reset_preview`、`advance_mode`，再判断资产是否有问题。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `actor_id`：`current_level_component` 分支的 Actor 名称或标签，必须与 `component` 同时提供。
- `component`：`current_level_component` 分支的组件名称或对象路径，必须与 `actor_id` 同时提供。
- `sample_mode`：规范采样模式；显式提供时优先于所有兼容别名。
- `probe_mode`：`sample_mode` 的旧兼容别名；仅在未提供 `sample_mode` 时读取，新调用不要同时发送两者。
- `advance_mode`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `open_editor_if_needed`：默认 false；设为 true 才允许打开 Niagara 编辑器。
- `tick_count`：数量摘要。
- `use_transient_component`：使用 transient Niagara component 执行运行时 probe，避免依赖已打开的资产编辑器。
- `particle_attributes`：可选的规范粒子属性名数组，最多 16 项。接受 authoring 常用的 `Particles.Position` 与 CPU 数据集名称 `Position`；先精确匹配，再仅对唯一结果归一 `Particles.` 前缀。只对 CPU stateful Emitter 读取当前粒子数据集；不请求时保持原有低成本聚合统计。
- `max_particle_samples`：每个 Emitter 的采样上限，默认 64，范围 1..1024。固定池验收应设置为不小于池大小，并检查 `complete=true`；较大的上限会按 `tick_count * Emitter 数量 * 属性数量` 增加返回体积，应只请求验收所需属性和帧数。
- `measure_performance`：仅对 `sample_mode=simulate` 生效。开启后使用 `FPlatformTime::Seconds` 测量每一步的 component advance、Niagara world queue flush 与两者合计；默认 false，不改变普通 probe 成本。
- `performance_warmup_ticks`：从 `tick_count` 开头排除的 warmup 步数，默认 0；开启性能测量时必须小于 `tick_count`。

`current_level_component` 会校验目标组件为 `UNiagaraComponent`，且其 `Asset` 与 `asset_path` 一致；结果中的 `final_stats` 直接描述该关卡组件的注册、激活、system instance、execution state、粒子数和 emitter 状态。

## Returns

- `final_stats.emitters[].particle_attribute_capture`：仅在请求 `particle_attributes` 时返回。
- `available/reason/sim_target`：明确区分 CPU 可读、GPU 未请求 readback、stateless 或数据集不可用，不会把缺失伪装为空数组。
- `particle_count/sampled_particle_count/complete`：说明采样是否覆盖全部活粒子。
- `attributes[]`：逐属性返回 `found`、请求名称、实际 `resolved_name`、类型、distinct 数量、顺序哈希、集合哈希及有界样本。
- `particle_attribute_ordered_hash`：对粒子缓冲顺序敏感；`particle_attribute_set_hash`：保留重复项但忽略缓冲顺序。固定池跨周期身份验收优先比较集合哈希，并同时检查粒子数和累计生成数。
- GPU Emitter 默认返回 `available=false, reason=gpu_readback_not_requested`，命令不会隐式触发昂贵同步 GPU readback。
- `performance.advance/flush/combined`：分别返回 `sample_count`、`total_ms`、`min_ms`、`mean_ms`、`median_ms`、`p95_ms` 和 `max_ms`。
- `performance` 是固定步长预览组件在当前主机上的同步 wall-clock 成本，排除快照收集和粒子属性序列化；`flush` 包含 Niagara world compute/deferred queue flush，但不等待 GPU 完成。因此它可用于 CPU Sim 成本和 GPU dispatch host cost 比较，不能声明为 GPU frame time。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
