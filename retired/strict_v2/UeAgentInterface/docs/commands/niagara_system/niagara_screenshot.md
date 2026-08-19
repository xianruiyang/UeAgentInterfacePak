---
command: niagara_screenshot
category: niagara_system
title: `niagara_screenshot`
summary: 截取 Niagara 资产预览，或对当前关卡中的同一 Niagara 组件执行固定步长连续序列采样
aliases: []
tags: [niagara_system]
status: active
---

# `niagara_screenshot`

## 用途

`niagara_screenshot` 有两类正式用途：

- 资产预览：截图 Niagara System / Emitter / Script 编辑器或其 preview component，并支持连续推进的序列帧。
- 关卡组件序列：`capture_mode: current_level_component_sequence`，解析当前 Editor World 中已有的 Actor 与 Niagara Component，在同一组件实例和同一相机下执行一次激活后的连续固定步长采样。

命令不运行 PIE。资产预览路径保持调用前 package dirty 状态；关卡组件路径属于 Editor 会话控制，不修改 Niagara System 默认参数，也不保存关卡。

## 关卡组件序列契约

- `actor_id` 与 `component` 必填；组件使用的 System 必须与 `asset_path` 一致。
- 帧序列由 `frames[]`，或 `start_frame_index + count + frame_interval` 指定，最多 600 帧。
- `reset_component: true` 时只在序列开始执行一次 reset activation；帧间只调用连续 `AdvanceSimulation` 或 `TickComponent`，不得逐帧激活或重置。
- `preview_tick_delta_seconds` / `tick_delta_seconds` 是固定步长；60 fps 使用 `0.0166666666666667`。
- `user_parameters` 复用 Niagara authoring 的结构化类型解析，但只允许修改 System 已暴露且组件参数存储中已存在的值；不得通过截图命令增删参数结构。
- `restore_component_after_capture: true` 会恢复参数值、激活/暂停状态和采样配置；失败路径始终强制恢复。设为 false 时成功后保留序列结束状态，便于随后读回或继续观察。
- `camera.location` 或 `camera.translation` 是世界坐标 `[x,y,z]`；`camera.rotation` 是 `[pitch,yaw,roll]`；整个序列复用同一 SceneCapture 与相机。
- 像素截图要求可用 RHI；`-NullRHI` 环境只能运行非渲染 probe，不能作为截图失败结论。

## HJSON 示例

```hjson
{
  asset_path: "/Game/VFX/Lightning/NS_Example"
  capture_mode: current_level_component_sequence
  target: current_level_component
  actor_id: LightningController
  component: ThunderStrikeFX
  start_frame_index: 0
  count: 107
  frame_interval: 1
  preview_tick_delta_seconds: 0.0166666666666667
  advance_mode: advance_simulation
  reset_component: true
  restore_component_after_capture: false
  pause_after_capture: true
  create_frame_sheet: false
  write_individual_frames: true
  width: 960
  height: 540
  max_size: 960
  camera: {
    location: [-6350, 900, 2500]
    rotation: [0, 0, 0]
    fov: 42
  }
  user_parameters: {
    "User.PlayMode": { value: { literal: 1 } }
    "User.RandomSeed": { value: { literal: 470200 } }
    "User.ColorPrimary": { value: { components: [0.06, 0.32, 1, 1] } }
  }
}
```

## 关键返回

- 身份：`component_source`、`actor_id`、`component_name`、`component_path`、`component_world`。
- 连续性：`activation_count`、`reset_count`、`continuous_tick_count`、`system_age_monotonic`、`advance_semantics`。
- 参数：`user_parameter_readback`，使用与输入相同的结构化 value 表达。
- 相机：`scene_capture_camera.source`；显式世界相机返回 `explicit_world_camera`。
- 帧：`frames` 中包含 `frame_index`、`system_age`、运行时统计、像素签名、变化比例和文件路径。大数组按 response policy 外置为 artifact。
- 恢复：`component_restore`、`restore_component_after_capture`、`restored_dirty_state`。

## 验证

关卡组件序列至少检查：同一组件身份、`activation_count == 1`、`reset_count <= 1`、`system_age_monotonic == true`、目标帧数量、固定相机 source、参数读回和帧文件存在。视觉连续性必须查看 60 fps 视频，不能只依赖 Contact Sheet。
