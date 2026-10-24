# 预览截图与时间轴

先在资产 workspace 的 `preview/` 中应用配置，见[资产预览](asset-preview.md)。
截图只触发已应用配置，不再次传相机、环境或采样参数。
策略与结果字段的正式合同见项目 `Plugins/UeAgentInterface/docs/active/t44_capture_media_operation.md` 的 Asset preview workspace capture 节；
SDK 调用与 operation 示例见 `UeAgentInterfaceCMD/docs/active/t44_capture_media_operation.md`。

Level 视口截图走 `policy:image-capture:viewport/v1`，取得现有 backbuffer；`max_size` 只控制输出缩放。
`level-sequence/v1` 是另一个独立场景相机渲染入口，即使 fallback 到 viewport 也只借用相机几何，
不复制视口的曝光历史和显示状态。不要为提高普通截图分辨率而把空序列当成等价替代；
需要序列采样时按其公开合同使用，并读取终态 `capture_receipt` 中实际 render path、尺寸、相机和帧信息。
主图用 `result.primary_artifact`，逐帧 `raw_artifact_index` 对应 `result.additional_artifacts`；
`result.artifacts` 仍可枚举全部产物，但不要将其第一项猜成主图。

## 单图与多图

```python
started = client.capture.image_execute(
    subject_ref="capture-subject:asset:" + asset_path,
    policy_id="policy:image-capture:asset-preview/v1",
    parameters={"mode": "single"},
)
started.raise_for_error()
```

多图用 `mode="sequence"`，帧数和间隔从目标的 `capture.hjson` 读取；多目标时传 index 中的
`target` 名称。按[非 PIE 长任务](sdk-and-runners.md#非-pie-长任务与恢复)用 `started.operation.finish()`
取得终态收据并释放，消费业务状态、清理结果和 `artifacts`；失败时也保留已取得产物，释放后仍可 materialize。
需要真实渲染尺寸时编辑已导出的
`RenderWidth/RenderHeight`；两者为0沿用视口，单个为0保持比例。`Width/Height`只缩放输出。
检查实际图像和收据的`native_width/height`，不把插值放大当作细节增加；显式渲染尺寸覆盖在采集结束后恢复。

## 选择时间推进方式

只使用当前目标实际导出的选项：

| Sampling | 适用目标与行为 |
| --- | --- |
| `Realtime` | 按间隔观察实际预览；`ResetBeforeCapture`/`WarmupSeconds` 用于准备 |
| `Timeline` | 直接求值姿态或数值；不用于依赖沿途事件的模拟，Niagara 不支持这种采集 |
| `Continuous` | Niagara System/Emitter、LevelSequence 从原生播放范围起点（通常 0）正常播放到请求位置，多图沿同一轨迹继续，不逐点跳转 |

需要保留粒子模拟和沿途事件时使用适用的 `Continuous`，而不是先 seek 再截图。
这里的事件范围是原生资产预览，不能据此声称 PIE 游戏事件已验证。

`TimeUnit=Frames` 使用 `StartFrame`/`StepFrames`，帧率以原生预览为准（status 返回分子/分母）；
`Seconds` 使用 `StartTimeSeconds`/`StepTimeSeconds`。Sequencer 起点是 focused sequence 的绝对本地时间，可为该原生范围内的负值；步长与等待时长仍非负。起点设置对单图同样生效；没有原生帧率时使用 Seconds。
Continuous 必然从起点重建过程。

## 读取实际结果

请求时间和实际时间分别报告，不能把请求间隔当作达到的帧率。连续播放优先保留原生求值区间，
可能晚于请求帧；查看 `actual_asset_frame`/`frame_deviation`，Niagara 再看真实 `simulation_age_seconds`。
请求帧或 desired age 不能代替实际结果。

单图的采样时刻记录在 `capture.sample`，多图在逐帧结果中；`end_preview_state` 是恢复播放后的结束状态，
不能代替截图时刻。采集负责后台所需的原生视口更新，报告配置边界、结束状态，恢复临时播放状态/速率并保留实际推进后位置。
同一资产的导入会排在当前采集之后；共享 profile 被其他资产窗口改变时，收据记录变化而不回写覆盖。
